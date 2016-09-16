From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: libdrm/amdgpu - Fixup typedef not to hide pointer type
Date: Fri, 16 Sep 2016 19:02:37 +1000
Message-ID: <bc823f27-6163-1688-9cf0-0c8b5934111d@folklore1984.net>
References: <1474015570-30928-1-git-send-email-funfunctor@folklore1984.net>
 <98564703-e915-2729-b5c9-43afddc881a5@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1405032244=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <98564703-e915-2729-b5c9-43afddc881a5-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1405032244==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FBxQUSQR1gXK21rPR5B9RUUMk5frPCdpu"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FBxQUSQR1gXK21rPR5B9RUUMk5frPCdpu
Content-Type: multipart/mixed; boundary="btWIt3nGu1vFHc1Nb9OB2LDB2m2uWKsEb";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <bc823f27-6163-1688-9cf0-0c8b5934111d-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: libdrm/amdgpu - Fixup typedef not to hide pointer type
References: <1474015570-30928-1-git-send-email-funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
 <98564703-e915-2729-b5c9-43afddc881a5-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
In-Reply-To: <98564703-e915-2729-b5c9-43afddc881a5-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>

--btWIt3nGu1vFHc1Nb9OB2LDB2m2uWKsEb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On 09/16/2016 06:49 PM, Christian K=C3=B6nig wrote:
> NAK, that is clearly an API breakage.

It should have never been typedef'ed in the first place. Does that mean
we would have to bump version for API change? What is the procedure there=
?

>=20
> BTW: Why would we want to stop hiding the type?

Quite a few reasons, I'll start with to justify the change:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Docu=
mentation/CodingStyle?id=3Drefs/tags/v4.8-rc6#n276

Suppose you have 'amdgpu_semaphore_handle' as typedef of a pointer type
and you had some function 'void f(amdgpu_semaphore_handle * h) {}'.
Suppose now, within 'f()' we deference 'h' and use the result in some
way. The issue is that it is not directly obvious that we have a double
pointer type and so while it maybe the case that '(*h !=3D NULL)' it coul=
d
well be the case that '(h =3D=3D NULL)'.

Kind Regards,
Edward.

>=20
> Christian.
>=20
> Am 16.09.2016 um 10:46 schrieb Edward O'Callaghan:
>> Oops, turns out I mailed to dri-devel by mistake so resending here.
>>
>> The following series fixes up libdrm/amdgpu such that to not hide
>> a pointer type behind a typedef.
>>
>> Please Review,
>>
>> Edward O'Callaghan (3):
>>   [PATCH 1/3] amdgpu: Fix amdgpu_va_handle typedef not to hide pointer=

>>   [PATCH 2/3] amdgpu: Fix amdgpu_semaphore_handle typedef not to hide
>>   [PATCH 3/3] amdgpu: Fix amdgpu_bo_list_handle typedef not to hide
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>=20
>=20


--btWIt3nGu1vFHc1Nb9OB2LDB2m2uWKsEb--

--FBxQUSQR1gXK21rPR5B9RUUMk5frPCdpu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX27UtAAoJEP4bvbfZuWjbokUQAMNc1POHaFpUO/m2T1t0pGI0
iqRHJrLSv7XOcLj04byKWkn8dmoQMT95Q8tSTHejrp/13mLz1LeiE1PYNHsU/RKx
tIyCL9/4E/Lzu0npABn7AvhAs4087ZhDiGXerX03ho9CIrN39NhVGa2byX2lAFkj
R7UPe34CFmfrPbU7bn+/4HmDZt+WLl86wRtnQLNn58gEkRTXe1U0VPATpAF59L4O
tciz79gRO17D+mMiQuHqSh7hD9FhOTsbsf5CMYlvKR3J6G3/x/AN8i/CmtSu3OmL
VNgo9CbFl5jsvOVZOYjUbEQRi/6vStPX9xXge1PF7kIVCSx5Ar5wPrORzzLqQBRq
LiO9dR3KeNJXkuxkA1W0krnBLyvnvtbA7emHYoDArwAxFpOSDZjSGLgTusjdbcuC
g0dkSZnsyq0oK61VlB3hGU2Gx1+a7qiODnLugE6OXc0u5f6IovsJ/gkgz3KvsK7/
Z/qvfpelSTkDAD6Bz8klPjsbyI7XeMSwVXQh4tLAg1KkF4quZLzvh5uyD5AhSF2J
59V5gp3bFtlMmGnlky7VWoxBF64tgcfRNaZPSFN0GdyAYcB/wUbPQ8tChaNtdC5g
H8RPCOfCEGCCTV4ZuYN+8AQgO7i8LOclwRTXB0pCxBaFa3XciEv8g3lsPy8FxqN8
Z9RoFwSUOuuzQyVjAitS
=TXbV
-----END PGP SIGNATURE-----

--FBxQUSQR1gXK21rPR5B9RUUMk5frPCdpu--

--===============1405032244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1405032244==--
