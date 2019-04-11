From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: amd-staging-drm-next, CIK apu,
 [TTM] Erroneous page count. Leaking pages. [BISECTED]
Date: Thu, 11 Apr 2019 18:53:23 +0200
Message-ID: <7748299.amKHJ1hp7T@eclipse>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1966093882=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
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
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, Michel =?ISO-8859-1?Q?D=E4nzer?= <michel.daenzer-5C7GfCeVMHo@public.gmane.org>, Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

--===============1966093882==
Content-Type: multipart/signed; boundary="nextPart3341740.nS66X44CjF"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart3341740.nS66X44CjF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Hi All,
after today's sync with amd-staging-drm-next branch I have problems with my=
=20
Mullins APU Netbook.
Kernel log is flooded with "[TTM] Erroneous page count. Leaking pages."=20
message.

Bisected, and it seems that "drm/ttm: fix start page for huge page check in=
=20
ttm_put_pages()" commit is causing this.

git bisect log:
git bisect start
# good: [c2af9f9e84183a4dbcb53a74abbe3362dc181682] drm/amd/display: fix cur=
sor=20
black issue
git bisect good c2af9f9e84183a4dbcb53a74abbe3362dc181682
# bad: [b07c394a327fc9e435ee03288584c111fa73d963] drm/amd/display: fix is o=
dm=20
head pipe logic
git bisect bad b07c394a327fc9e435ee03288584c111fa73d963
# bad: [367fa96ad66fef31bf73916cf4949c475f42563f] drm/amd/display: use prop=
er=20
formula to calculate bandwidth from timing
git bisect bad 367fa96ad66fef31bf73916cf4949c475f42563f
# good: [94275c6d27deebbce5055e1bb1959986051b93f2] drm/amdgpu: Add a check =
to=20
avoid panic because of unexpected irqs
git bisect good 94275c6d27deebbce5055e1bb1959986051b93f2
# bad: [8198a32b1211c6f625623bae22629cf852531097] drm/amd/display: Initiali=
ze=20
stream_update with memset
git bisect bad 8198a32b1211c6f625623bae22629cf852531097
# bad: [e16858a7e6e7dc00345703682d490b96f2883b99] drm/ttm: fix start page f=
or=20
huge page check in ttm_put_pages()
git bisect bad e16858a7e6e7dc00345703682d490b96f2883b99
# good: [b414dfd1f975bbf4c9ee4600f9bedcf77bae84ed] drm/ttm: fix out-of-boun=
ds=20
read in ttm_put_pages() v2
git bisect good b414dfd1f975bbf4c9ee4600f9bedcf77bae84ed
# first bad commit: [e16858a7e6e7dc00345703682d490b96f2883b99] drm/ttm: fix=
=20
start page for huge page check in ttm_put_pages()

e16858a7e6e7dc00345703682d490b96f2883b99 is the first bad commit
commit e16858a7e6e7dc00345703682d490b96f2883b99
Author: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Date:   Tue Apr 2 09:29:35 2019 +0200

    drm/ttm: fix start page for huge page check in ttm_put_pages()
   =20
    The first page entry is always the same with itself.
   =20
    Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
    Reviewed-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
    Reviewed-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
    Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>

Any help is appreciated.
Thanks,
Przemek.
--nextPart3341740.nS66X44CjF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAlyvcQMACgkQPMstj1ls
VJNKNhAAqSZx71ayc2FpjT59RBLiav4VoTcSbr1GdQFZbTRkIwk2qHyObpX9ZUIS
YIyoiUeCuMCBVrveNy0NDH2wTSxGwXWI9EMcQuJq58wMQuqB8DnsXiqD96BITocp
x2UFjqe5d5DQzpCoAs+zfQkwyWAwUO3G8wHILD6D7aCCc1WxEZQHaEFa7Si30kGq
X0I4H0Oiw9BQLnn4qhx2oRkk3YVTVUDmJhfUlDyS2L04EmitQfAj3pjdvf8RO1Al
/GoaAiIDYuZ1UkrWYBthkQZLr9IyylKfRIAwj3m5PsUW7nYDi0v2k8WyY36MKWRg
Lh7NDdpyqCCbaAzAgmboVvbsr0MTUcftXonqGVWk5M1Vw5XayArD9xj94yq/HWvE
ZYXRmBM53DwJrC7suDyVx2tCxfbxQ7byIxMvNIaTx/KFogrQ2+Sv5fKpgTdC2Ux9
ZWqboti6WYF3E3y6qHWkJ67ctoLdn8GdnOF1ux9DNyUMigCr41dj+Xo66vlHPy22
wtctGMceju2g/+116rrM6QZiIQA7CFvmnK4A1OrwxMhHlwE6jBBrqx+/kSc1b0b2
mEn4uzlCaq413q9SzO4ptqPncczfsLEjq+xNphT9sRPRcVweZg//OdzdVBwnNCTV
nroIG1ZPlcCRx6Zrs/PZdeKb8OPOdByvVUPzEck63fwRxUYgf2o=
=F/mY
-----END PGP SIGNATURE-----

--nextPart3341740.nS66X44CjF--




--===============1966093882==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1966093882==--
