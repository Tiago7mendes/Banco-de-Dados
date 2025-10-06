--9. Crie um sinônimo para a tabela D_TRACK_LISTINGS. Verifique se ele foi criado consultando o
--dicionário de dados.
CREATE SYNONYM dj_tracks FOR d_track_listings;

SELECT synonym_name, table_owner, table_name
FROM user_synonyms
WHERE synonym_name = 'DJ_TRACKS';

-- 10.Elimine o sinônimo criado na pergunta 9.
DROP SYNONYM dj_tracks;
