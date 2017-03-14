From: Umang Raghuvanshi <u@umangis.me>
Subject: Re: [PATCH] drm/radeon: Fix GPU lockups for the R7 M270
Date: Tue, 14 Mar 2017 08:12:00 +0530
Message-ID: <dcf05c1d-b672-7f49-8f22-68e30a6aae12@umangis.me>
References: <20170311162113.7497-1-u@umangis.me>
 <CADnq5_MUP3KSEWed47Ot617UwaGxvjuwdWjCDFmrb7_hDEXiLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AvBDLiRq1FlvPC6T2t9wKoIcdlj4nDcwx"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_MUP3KSEWed47Ot617UwaGxvjuwdWjCDFmrb7_hDEXiLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AvBDLiRq1FlvPC6T2t9wKoIcdlj4nDcwx
Content-Type: multipart/mixed; boundary="dudtklv3V88vMJ4uVsJWBlrUieRKaWLus";
 protected-headers="v1"
From: Umang Raghuvanshi <u@umangis.me>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, amd-gfx list
 <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-ID: <dcf05c1d-b672-7f49-8f22-68e30a6aae12@umangis.me>
Subject: Re: [PATCH] drm/radeon: Fix GPU lockups for the R7 M270
References: <20170311162113.7497-1-u@umangis.me>
 <CADnq5_MUP3KSEWed47Ot617UwaGxvjuwdWjCDFmrb7_hDEXiLw@mail.gmail.com>
In-Reply-To: <CADnq5_MUP3KSEWed47Ot617UwaGxvjuwdWjCDFmrb7_hDEXiLw@mail.gmail.com>

--dudtklv3V88vMJ4uVsJWBlrUieRKaWLus
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/14/2017 01:00 AM, Alex Deucher wrote:

> Does your kernel have this patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Def736d394e85b1bf1fd65ba5e5257b85f6c82325

Yes, my kernel has this patch (this issue first occurred in v4.10).

--=20
Cheers,
Umang Raghuvanshi.


--dudtklv3V88vMJ4uVsJWBlrUieRKaWLus--

--AvBDLiRq1FlvPC6T2t9wKoIcdlj4nDcwx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEutgiak89t6LZ3k+4vAe2ilv7qqsFAljHWHkACgkQvAe2ilv7
qqvfbRAAkbnHRXr68qDfPowKb9NtJgCi19+ncPsFoVhqS8QgC26+gwEimI9DZlLd
RbHPLzEW9LVO9g91EH05y8tuuT7H8iEI5QEbqVKrXyumRJgHFAgqRY5p8XW6gsYm
OZC+g6vvlcuf3ws8rr9JGwEURcs+S3sUIZSsSeGufflSiQANnJSXbIwXVmuFTpw3
jcYiGWuugfzRNrRoOdZ5dSEs8yGFnxK9frktea3rqTS0FlSJu7B5QiyxTQv7XbCo
AwcTwuCpl64VppRtlkcU1oD8eM81FYMq/CwB0ImMOnnBvUmfvWhfY+I+m7GasQcB
4Jn1I0CMAIm4i1mekcoKU0T+4DN1TKPvVGCGzzarT9xZAzadto215AZvlQWl8Rzi
UFtf+9rtKurIz9t2IPiT/oDPuTM5hC7oSzEy/1GFpQI0ycdMO2GkEesu9OH3CIXk
UZsF41Z2RC2wsZaSHWtmBBgi6nwSep5QybYnVxzplOB3te5148U/sZ1sqp5PTJUD
TGqVyMqVUrXjJWhsD1Fiqz3FdyGCoMu5CPTTM/lIqg+i98PrKoYzLRfAcz6iaNi/
5yHZp8hMqeZKSbciUuvAegjxxHBKfO2y3iQTyso2DZ7kYVeScdVFluiC0g5Q/XLA
Uie2rMfzfVlQxgY87/y8/XCD4H0nf1omPV4BpoGFdxh8THvBFOY=
=mfj7
-----END PGP SIGNATURE-----

--AvBDLiRq1FlvPC6T2t9wKoIcdlj4nDcwx--
