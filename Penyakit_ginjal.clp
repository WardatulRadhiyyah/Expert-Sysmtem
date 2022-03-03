(defglobal
  
  ?*ginjal_akut* = 0
  ?*ginjal_kronis* = 0
  ?*nefropati_diabetik* = 0
  ?*infeksi_saluran* = 0

)
(defrule ask
  =>
  (printout t crlf "Apakah kamu ingin memeriksa penyakit ? (yes/no)" crlf)
  (bind ?answer (read))
    (if (eq ?answer yes)
       then (printout t crlf "Silahkan pilih gejala yang anda rasakan" crlf)
       then (printout t crlf "Jika gejala sesuai dengan yang anda rasakan ketik y jika tidak ketik n" crlf)
    )
    (if (eq ?answer no)
      then (printout t crlf "Terima Kasih" crlf)
    )
  => 
    (assert(deteksi_gejala))
)

(defrule tekanan_darah_tinggi
    (deteksi_gejala)
  =>
  (printout t crlf "Apakah anda mengidap darah tinggi (y/n)?" crlf)
  (bind ?answer (read))
    (if (eq ?answer y)

      then 
        (bind ?*ginjal_akut* (+ ?*ginjal_akut* 1))
        (bind ?*ginjal_kronis* (+ ?*ginjal_kronis* 1))
        (bind ?*nefropati_diabetik* (+ ?*nefropati_diabetik* 1))
        (bind ?*infeksi_saluran* (+ ?*infeksi_saluran* 1))
        (assert (darah_tinggi))
                      (assert (chk_gula))

      else
          (assert (tidak_darah_tinggi))
                      (assert (chk_gula))
    )
)

(defrule Kadar_gula_darah
   (chk_gula)
  =>
  (printout t crlf "Apakah gula darah anda tinggi (y/n)?" crlf)
  (bind ?answer (read))
    (if (eq ?answer y)
      then 
        (bind ?*ginjal_akut* (+ ?*ginjal_akut* 1))
        (bind ?*ginjal_kronis* (+ ?*ginjal_kronis* 1))
        (bind ?*nefropati_diabetik* (+ ?*nefropati_diabetik* 1))
        (bind ?*infeksi_saluran* (+ ?*infeksi_saluran* 1))
          (assert (gula_tinggi))
                  (assert (chk_lelah))
      else 
          (assert (tidak_gula_tinggi))
                  (assert (chk_lelah))
    )
)

(defrule Lelah
    (chk_lelah)
  =>
    (printout t crlf "Apakah anda sering merasa mudah lelah (y/n)?" crlf)
    (bind ?answer (read))
      (if (eq ?answer y)
        then 
        (bind ?*ginjal_akut* (+ ?*ginjal_akut* 1))
        (bind ?*ginjal_kronis* (+ ?*ginjal_kronis* 1))
          (assert (lelah))
                (assert(chk_kulit))
        else 
          (assert (tidak_lelah))
                (assert(chk_kulit))
      )
) 
(defrule Kulit
    (chk_kulit)
  =>
  (printout t crlf "Apakah kulit anda kering (y/n)?" crlf)
  (bind ?answer (read))
      (if (eq ?answer y)
        then 
          (bind ?*ginjal_akut* (+ ?*ginjal_akut* 1))
          (bind ?*ginjal_kronis* (+ ?*ginjal_kronis* 1))
          (bind ?*nefropati_diabetik* (+ ?*nefropati_diabetik* 1))
          (assert (kulit_kering))
                (assert(chk_mata))
        else 
          (assert (tidak_kulit_kering))
                  (assert(chk_mata))
      )
)

(defrule bengkak_mata
    (chk_mata)
  =>
  (printout t crlf "Apakah mata anda bengkak? (y/n)" crlf)
  (bind ?answer (read))
      (if (eq ?answer y)
        then 
        (bind ?*ginjal_akut* (+ ?*ginjal_akut* 1))
        (bind ?*ginjal_kronis* (+ ?*ginjal_kronis* 1))
          (assert (mata_bengkak))
              (assert (chk_bab))
          
        else 
          (assert (mata_tidak_bengkak))
             (assert (chk_bab))
          
      )
)
(defrule buang_air_besar
    (chk_bab)
  =>
  (printout t crlf "Apakah buang air besar anda berdarah ? (y/n)" crlf)
  (bind ?answer (read))
      (if (eq ?answer y)
        then 
        (bind ?*ginjal_akut* (+ ?*ginjal_akut* 1))
          (assert (bab_drh))
            (assert (chk_urin))
        else 
          (assert (bab_tidak_drh))
            (assert (chk_urin))
      )
)
(defrule kulit_gatal
    (chk_urin)
  =>
  (printout t crlf "Apakah kulit anda gatal? (y/n) " crlf)
  (bind ?answer (read))
      (if (eq ?answer y)
        then 
          (bind ?*ginjal_kronis* (+ ?*ginjal_kronis* 1))
          (assert (kulit_gatal))
            (assert (chk_kaki))
        else 
          (assert (kulit_tidak_gatal))
            (assert (chk_kaki))
      )
)
(defrule kaki_bengkak
    (chk_kaki)
  =>
  (printout t crlf "Apakah kaki anda bengkak ? (y/n)" crlf)
  (bind ?answer (read))
      (if (eq ?answer y)
        then 
          (bind ?*nefropati_diabetik* (+ ?*nefropati_diabetik* 1))
          (assert (kaki_bengkak))
            (assert (chk_otot))
        else 
          (assert (kaki_tidak_bengkak))
            (assert (chk_otot))
      )
)
(defrule keram_otot
    (chk_otot)
  =>
  (printout t crlf "Apakah anda sering keram otot pada malam hari ? (y/n)" crlf)
  (bind ?answer (read))
      (if (eq ?answer y)
        then 
          (bind ?*nefropati_diabetik* (+ ?*nefropati_diabetik* 1))
          (assert (keram_otot))
            (assert (chk_demam))
        else 
          (assert (tidak_keram_otot))
            (assert (chk_demam))
      )
)
(defrule Demam
    (chk_demam)
  =>
  (printout t crlf "Apakah anda demam?(y/n)" crlf)
  (bind ?answer (read))
      (if (eq ?answer y)
        then 
          (bind ?*infeksi_saluran* (+ ?*infeksi_saluran* 1))
          (assert (demam))
            (assert (chk_nyeri))
        else 
          (assert (tidak_demam))
            (assert (chk_nyeri))
      )
)
(defrule Nyeri
    (chk_nyeri)
  =>
  (printout t crlf "Apakah saat buang air kecil anda merasa nyeri? (y/n)" crlf)
  (bind ?answer (read))
      (if (eq ?answer y)
        then 
          (bind ?*infeksi_saluran* (+ ?*infeksi_saluran* 1))
          (assert (nyeri))
            (assert (chk_nyeri_pinggang))
        else 
          (assert (tidak_nyeri))
            (assert (chk_nyeri_pinggang))
      )
)
(defrule Nyeri_pinggang
    (chk_nyeri_pinggang)
  =>
  (printout t crlf "Apakah Anda sering sakit pinggang ? (y/n)"crlf)
  (bind ?answer (read))
      (if (eq ?answer y)
        then 
          (bind ?*infeksi_saluran* (+ ?*infeksi_saluran* 1))
          (assert (nyeri_pinggang))
            (assert (chk_nafas))
        else 
          (assert (tidak_nyeri_pinggang))
            (assert (chk_nafas))
      )
)
(defrule Sesak_nafas
    (chk_nafas)
  =>
  (printout t crlf "Apakah Anda sering mengalami sesak nafas?" crlf)
  (bind ?answer (read))
      (if (eq ?answer y)
        then 
          (bind ?*ginjal_kronis* (+ ?*ginjal_kronis* 1))
          (assert (sesak_nafas))
              (assert(chk_diagnosa))
            
        else 
          (assert (tidak_sesak_nafas))
              (assert(chk_diagnosa))
      )
)

(defrule Diagnosa
  (chk_diagnosa)
  =>
    (if (and (eq ?*ginjal_akut* 6) (<> ?*ginjal_kronis* 7) (<> ?*nefropati_diabetik* 5) (<> ?*infeksi_saluran* 5))
        then 
            (printout t crlf "Anda mengalami gejala penyakit gagal ginjal akut, silahkan melakukan pemeriksaan lebih lanjut" crlf)
        else
            (if (and (eq ?*ginjal_kronis* 7) (<> ?*ginjal_akut* 6) (<> ?*nefropati_diabetik* 5) (<> ?*infeksi_saluran* 5))
                then
                    (printout t crlf "Anda mengalami gejala penyakit gagal ginjal kronis, silahkan melakukan pemeriksaan lebih lanjut" crlf)

            )
        else
            (if (and (eq ?*nefropati_diabetik* 5) (<> ?*ginjal_kronis* 7) (<> ?*ginjal_akut* 6) (<> ?*infeksi_saluran* 5))
                then
                    (printout t crlf "Anda mengalami gejala penyakit nefropati_diabetik , silahkan melakukan pemeriksaan lebih  lanjut" crlf)
            )
        else
            (if (and (eq ?*infeksi_saluran* 5) (<> ?*ginjal_kronis* 7) (<> ?*nefropati_diabetik* 5) (<> ?*ginjal_akut* 6))
                then
                    (printout t crlf "Anda mengalami gejala penyakit Infeksi saluran kemih , silahkan melakukan pemeriksaan lebih  lanjut" crlf)
            )
        else
            (if(and (<> ?*ginjal_akut* 6) (<> ?*ginjal_kronis* 7) (<> ?*nefropati_diabetik* 5) (<> ?*infeksi_saluran* 5))
                then
                    (printout t crlf "Penyakit yang sesuai gejala anda, tidak dapat didiagnosis, silahkan melakukan pemeriksaan lebih lanjut ke dokter" crlf)
            )
        else
            (if(and (eq ?*ginjal_akut* 6) (eq ?*ginjal_kronis* 7) (eq ?*nefropati_diabetik* 5) (eq ?*infeksi_saluran* 5))
                then
                    (printout t crlf "Gejala anda terlalu kompleks, silahkan melakukan pemeriksaan lebih lanjut ke dokter" crlf)
            )        
    )
)