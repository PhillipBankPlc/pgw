-- Off Domain
CREATE OR REPLACE FUNCTION bk_khqr_off_domain()
RETURNS trigger
language plpgsql
as $$
DECLARE
HASH_COUNT INT;
BEGIN
SELECT COUNT(*) INTO HASH_COUNT FROM bk_khqr WHERE trx_hash LIKE
NEW.trx_hash;
IF NEW.status_string = 'SUCCESS' AND NEW.dest_account_id =
'khqr@pinc' AND
NEW.qr_code NOTNULL AND HASH_COUNT = 0
THEN
INSERT INTO bk_khqr (id, src_account_id, asset_id, amount, create_time, trx_hash,
qr_code, trn_type, status)
VALUES (NEW.id, NEW.src_account_id, NEW.asset_id, NEW.amount,
NEW.create_time, NEW.trx_hash, NEW.qr_code,'OFF', 'PENDING');
END IF;
RETURN NEW;
END;
$$;
-- Trigger 
CREATE TRIGGER bk_khqr_off_domain_tg
after insert
on fst_iroha_trx
for each row
execute procedure bk_khqr_off_domain();


-- On Domain 
CREATE OR REPLACE FUNCTION bk_khqr_on_domain()
returns trigger
language plpgsql
as $$
DECLARE
HASH_COUNT INT;
BEGIN
SELECT COUNT(*) INTO HASH_COUNT FROM bk_khqr WHERE trx_hash LIKE
NEW.trx_hash;
IF OLD.status_string <> 'SUCCESS' AND NEW.status_string = 'SUCCESS' AND
NEW.dest_account_id = 'khqr@pinc' AND
NEW.qr_code NOTNULL AND HASH_COUNT = 0
THEN
INSERT INTO bk_khqr (id, src_account_id, asset_id, amount, create_time, trx_hash,
qr_code, trn_type, status)
VALUES (NEW.id, NEW.src_account_id, NEW.asset_id, NEW.amount,
NEW.create_time, NEW.trx_hash, NEW.qr_code, 'ON', 'PENDING');
END IF;
RETURN NEW;
END;
$$;
--Trigger
CREATE TRIGGER bk_khqr_on_domain_tg
after update
of status_string
on fst_iroha_trx
for each row
execute procedure bk_khqr_on_domain();