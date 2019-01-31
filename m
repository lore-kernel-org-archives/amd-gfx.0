From: Przemek Socha <soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: amd-staging-drm-next: Oops - BUG: unable to handle kernel NULL
 pointer dereference, bisected.
Date: Thu, 31 Jan 2019 10:23:49 +0100
Message-ID: <3492051.hfQoeLTAnN@eclipse>
References: <1631249.cbNX0rPzdC@eclipse>
 <34e7e9b9-8d16-1055-cd08-68eac497743e@amd.com>
 <7a65412b-1b41-9e5b-f700-0a944a33cf49@amd.com>
Reply-To: soprwa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0171485010=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7a65412b-1b41-9e5b-f700-0a944a33cf49-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0171485010==
Content-Type: multipart/signed; boundary="nextPart14763000.Lxdld5ivXe"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart14763000.Lxdld5ivXe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Dnia =C5=9Broda, 30 stycznia 2019 13:42:33 CET piszesz:
> Does the attached patch fix the issue?
>=20
> Christian.

I have tested this one also - "drm/amdgpu: partial revert cleanup setting=20
bulk_movable v2"

>We still need to set bulk_movable to false when new BOs are added or remov=
ed.
>
>v2: also set it to false on removal
>
>Signed-off-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/
>amdgpu/amdgpu_vm.c
>index 79f9dde70bc0..822546a149fa 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>@@ -332,6 +332,7 @@  static void amdgpu_vm_bo_base_init(struct=20
>amdgpu_vm_bo_base *base,
> 	if (bo->tbo.resv !=3D vm->root.base.bo->tbo.resv)
> 		return;
>=20
>+	vm->bulk_moveable =3D false;
> 	if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
> 		amdgpu_vm_bo_relocated(base);
> 	else
>@@ -2772,6 +2773,9 @@  void amdgpu_vm_bo_rmv(struct amdgpu_device *adev,
> 	struct amdgpu_vm_bo_base **base;
>=20
> 	if (bo) {
>+		if (bo->tbo.resv =3D=3D vm->root.base.bo->tbo.resv)
>+			vm->bulk_moveable =3D false;
>+
> 		for (base =3D &bo_va->base.bo->vm_bo; *base;
> 		     base =3D &(*base)->next) {
> 			if (*base !=3D &bo_va->base)

and so far I have no lockup and Oops, so I think this one is ok.

Thank you very much,
Przemek.
--nextPart14763000.Lxdld5ivXe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2zcce+zboy/je1pmPMstj1lsVJMFAlxSvqUACgkQPMstj1ls
VJNSiRAAroOh+QD7IphTakXKBT2j4Q0UAqtl+iTuxHEObOyUcQcCxCHUQPzhuBwr
FAhKVjX4rWhp+vrcfixXzMiAkKu7cdxh/NCdAuonLKFX3xrKCGWaoJK9CosXRPte
kFwPrJjvtF2XoO2hFOmIVnyOZSW6DlmS1reeunwVRcogKwTXXyKQmG/cBJ8hWqkB
6yf6UIUUE110xuliwDPiQxtmQ9NyYKecSReSO534p382pCWJsXdYNxQKx8BBQp8O
+KkEczVnaPpL97FJ29DOU/uvSxXkwb4rO85pSU9Jj1MMJqC98PKcXQfSj3EujdRF
TL++4BAeUHmM98DODWGH+S8P/CmzXQBuh+Mrh2xKNjQb5TXlMCKhjcx/bqTB5iWW
txVBlB0YJjWn51gAtoEviuy6PnvsH5ksWuGLSpSf5pIDtJI/RccnJ4WXEsfuIOAp
KqYFBLMDlsSZtsi3uFdQ8BBEvIf1eHf4qf5TB3YuzOMdf/sHgiuR2c+dyedNTeYa
3pYB0w/O/5xZaTQ7+qMBXythhZ+GU8+QeP0gBQo/MBYEE79uLM9s3kGDPZiwS2xo
ysAZrlERBWY/hDZaRzFH7o/Z5C+65z5S/qbmZpM+0/N7cKX4EQ63BrOOpdWZMn/g
u7PqBMpzS0DX7Vb6KS1+j45y0dt9CUBKs6XoQ9IqtAiLDolqgU0=
=ck3P
-----END PGP SIGNATURE-----

--nextPart14763000.Lxdld5ivXe--




--===============0171485010==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0171485010==--
