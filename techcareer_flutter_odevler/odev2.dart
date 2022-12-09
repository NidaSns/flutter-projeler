class Odev2 {
  //soru 1
  double dereceToFahrenhiet(double derece) {
    double fahrenheit = (derece * 1.8) + 32;
    return fahrenheit;
  }

  //soru 2
  double diktortgenCevresiBulma(double kisaKenar, double uzunKenar) {
    double cevresi = kisaKenar * 2 + uzunKenar * 2;
    return cevresi;
  }

  //soru 3
  int faktoriyel(int sayi) {
    int sonuc = sayi;
    while (sayi > 1) {
      sayi -= 1;
      sonuc *= sayi;
    }
    return sonuc;
  }

  // soru 4
  int aHarfiSayisi(String deger) {
    int adet = 0;
    for (int i = 0; i < deger.length; i++) {
      if (deger[i].contains('a')) {
        adet += 1;
      }
    }
    return adet;
  }

  // soru 5
  double icAciOlcusu(int kenar) {
    double aci = (kenar - 2) * 180;
    aci = aci / kenar;
    return aci;
  }

  // soru 6
  int maasHesabi(int gun) {
    int maas;
    int fazlaMesai = 0;
    maas = gun * 8;
    if (maas > 150) {
      fazlaMesai = maas - 150;
      fazlaMesai *= 80;
      maas = 150 * 40;
    } else {
      maas *= 40;
    }
    maas += fazlaMesai;
    return maas;
  }

  // soru 7
  int otoparkUcreti(int saat) {
    int saatAsim = 0;
    if (saat > 1) {
      saatAsim = saat - 1;
      saatAsim *= 10;
      saat = 50;
    } else {
      saat *= 50;
    }
    saat += saatAsim;
    return saat;
  }
}
