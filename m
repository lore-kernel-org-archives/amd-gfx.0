From: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix a bug that vm size is wrong on Raven
Date: Sun, 17 Dec 2017 00:21:48 +0100
Message-ID: <9ebd38b5-2b12-8797-65e5-3a920ce697aa@gmail.com>
References: <1513269904-3385-1-git-send-email-yong.zhao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1275423494=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1513269904-3385-1-git-send-email-yong.zhao-5C7GfCeVMHo@public.gmane.org>
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
To: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1275423494==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bOELGwIDPfWvJxQHeKiCXDuJKQFalK2wi"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bOELGwIDPfWvJxQHeKiCXDuJKQFalK2wi
Content-Type: multipart/mixed; boundary="hvgag6HlqM9tO98xALb9m2R7SDNF0U2lP";
 protected-headers="v1"
From: =?UTF-8?Q?Felix_K=c3=bchling?= <felix.kuehling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <9ebd38b5-2b12-8797-65e5-3a920ce697aa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix a bug that vm size is wrong on Raven
References: <1513269904-3385-1-git-send-email-yong.zhao-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1513269904-3385-1-git-send-email-yong.zhao-5C7GfCeVMHo@public.gmane.org>

--hvgag6HlqM9tO98xALb9m2R7SDNF0U2lP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB

Is there a way to override the VM size for KFD VMs only? Only they
depend on ATS, so only they need to be forced to be 48-bits.

On the other hand, it could be argued that a user who manually sets the
VM size with a module parameter knows what they're doing. So let them
break ATS.

Regards,
=C2=A0 Felix


Am 14.12.2017 um 17:45 schrieb Yong Zhao:
> Change-Id: Id522c1cbadb8c069720f4e64a31cff42cd014733
> Signed-off-by: Yong Zhao <yong.zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> index 709587d..93500e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2534,7 +2534,7 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *=
adev, uint32_t vm_size,
>  	uint64_t tmp;
> =20
>  	/* adjust vm size first */
> -	if (amdgpu_vm_size !=3D -1) {
> +	if (amdgpu_vm_size !=3D -1 && adev->asic_type !=3D CHIP_RAVEN) {
>  		unsigned max_size =3D 1 << (max_bits - 30);
> =20
>  		vm_size =3D amdgpu_vm_size;



--hvgag6HlqM9tO98xALb9m2R7SDNF0U2lP--

--bOELGwIDPfWvJxQHeKiCXDuJKQFalK2wi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlo1qowACgkQ1hkrDAUMk3YMrwEAiUaG+O1CybIA2uFYzPGGYg+7
Ou/H5TmiSlAosnVDN5EA/0JJan+ZEk3qN5AOMXQnrAkICVWY5psTkelN+EUpivUZ
=4Xvy
-----END PGP SIGNATURE-----

--bOELGwIDPfWvJxQHeKiCXDuJKQFalK2wi--

--===============1275423494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1275423494==--
