From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: amd-staging-drm-next, CIK apu,
 [TTM] Erroneous page count. Leaking pages. [BISECTED]
Date: Thu, 11 Apr 2019 20:41:30 +0200
Message-ID: <3663873.0cdN12EykA@eclipse>
References: <7748299.amKHJ1hp7T@eclipse>
 <97bc37a4-f6fc-30f8-c6ff-554fa04cb03e@amd.com>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0299930241=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <97bc37a4-f6fc-30f8-c6ff-554fa04cb03e-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Daenzer,
 Michel" <Michel.Daenzer-5C7GfCeVMHo@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "Huang,
 Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>

--===============0299930241==
Content-Type: multipart/signed; boundary="nextPart5275573.qyYc03lapt"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5275573.qyYc03lapt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dnia czwartek, 11 kwietnia 2019 19:31:27 CEST piszesz:
> Yeah, that is a known issue and already fixed in amd-staging-drm-next.
>=20
> You just need to wait for the public mirror to update.
>=20
> Christian.
>=20
> Am 11.04.19 um 18:53 schrieb Przemek Socha:
>=20
> > Hi All,
> > after today's sync with amd-staging-drm-next branch I have problems with
> > my
 Mullins APU Netbook.
> > Kernel log is flooded with "[TTM] Erroneous page count. Leaking pages."
> > message.
> >
> >
> >
> > Bisected, and it seems that "drm/ttm: fix start page for huge page check
> > in
 ttm_put_pages()" commit is causing this.
> >
> >
> >
> > git bisect log:
> > git bisect start
> > # good: [c2af9f9e84183a4dbcb53a74abbe3362dc181682] drm/amd/display: fix
> > cursor
 black issue
> > git bisect good c2af9f9e84183a4dbcb53a74abbe3362dc181682
> > # bad: [b07c394a327fc9e435ee03288584c111fa73d963] drm/amd/display: fix =
is
> > odm
 head pipe logic
> > git bisect bad b07c394a327fc9e435ee03288584c111fa73d963
> > # bad: [367fa96ad66fef31bf73916cf4949c475f42563f] drm/amd/display: use
> > proper
 formula to calculate bandwidth from timing
> > git bisect bad 367fa96ad66fef31bf73916cf4949c475f42563f
> > # good: [94275c6d27deebbce5055e1bb1959986051b93f2] drm/amdgpu: Add a ch=
eck
> > to
 avoid panic because of unexpected irqs
> > git bisect good 94275c6d27deebbce5055e1bb1959986051b93f2
> > # bad: [8198a32b1211c6f625623bae22629cf852531097] drm/amd/display:
> > Initialize
 stream_update with memset
> > git bisect bad 8198a32b1211c6f625623bae22629cf852531097
> > # bad: [e16858a7e6e7dc00345703682d490b96f2883b99] drm/ttm: fix start pa=
ge
> > for
 huge page check in ttm_put_pages()
> > git bisect bad e16858a7e6e7dc00345703682d490b96f2883b99
> > # good: [b414dfd1f975bbf4c9ee4600f9bedcf77bae84ed] drm/ttm: fix
> > out-of-bounds
 read in ttm_put_pages() v2
> > git bisect good b414dfd1f975bbf4c9ee4600f9bedcf77bae84ed
> > # first bad commit: [e16858a7e6e7dc00345703682d490b96f2883b99] drm/ttm:
> > fix
 start page for huge page check in ttm_put_pages()
> >
> >
> >
> > e16858a7e6e7dc00345703682d490b96f2883b99 is the first bad commit
> > commit e16858a7e6e7dc00345703682d490b96f2883b99
> > Author: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> > Date:   Tue Apr 2 09:29:35 2019 +0200
> >
> >
> >
> >      drm/ttm: fix start page for huge page check in ttm_put_pages()
> >     =20
> >      The first page entry is always the same with itself.
> >     =20
> >      Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >      Reviewed-by: Michel D=C3=A4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
> >      Reviewed-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
> >      Reviewed-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> >
> >
> >
> > Any help is appreciated.
> > Thanks,
> > Przemek.
>=20
>=20

Thanks, and sorry about all the fuss.
Przemek.
--nextPart5275573.qyYc03lapt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAlyviloACgkQPMstj1ls
VJMXkg//U+2mgk3xYOOziCYlhDk0ZlzIfWKkv14CYCZotKZZP7fW5M611JUq/wm9
+PMM3D6zCFX4Py+SmQFkNIUOn5NJG+IphxHBUkLH81to4UoE4tG7Q84BLDQb3w5F
XQ4JvCu9zPRMoFJm7IUsD4xZ6BNi/uZeR9j27zKzB0CnO0MihZmW6Hu6m8SE3R2Y
k4nIT1Bvvtv29u58mPytcoX1oPgGY+6SZ5YGQnYiuzLxEz9ayEGFEqriyf1oktop
dv6Lj1n18uf5nn6WlYvVkUEmMwwItWIjYSvz+qaJWZQYt7WRWfk4to0G8YJR1XCV
qs2bIbapQF+yhvPoH12KYD3p7QDmx+gqHF8xjDo3lW+1oVzXFKE9ZbS6ruY2BfCo
7ub/FWkY58bvrt/4VBzLMohud204XtyNhERGuIDDw9OpQ6Loz6rEOEo8k0KUNpo/
NSaQFCnrsbkbTDM11DHW/A6K4ycEasexpdFNXNW+jW7wemQ9zjZrsMhU6Ak+W9J1
oP7gk2nFSxKCuBCgFdMFK6rXDR67luEY3xmcvGJnBz8Vr8aqM6qWI5RO3xE598zx
eBUh8Rzj5S+OvVd72OolHJhz1zEI4vNSZO2T5Ry3xhtDcV4/n9dJuS9WQwq8tx4G
Pv+XWNVmfjWOalaF9ATQ0Z19KyolQB1dvLyQSaKc8zCitxfhdao=
=SLFz
-----END PGP SIGNATURE-----

--nextPart5275573.qyYc03lapt--




--===============0299930241==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0299930241==--
