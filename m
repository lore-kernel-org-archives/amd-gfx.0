From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Remove checking for atombios
Date: Thu, 15 Dec 2016 13:14:04 +1100
Message-ID: <5a7b19aa-2c1b-79ed-4ae7-a49be56edf37@folklore1984.net>
References: <20161214205245.2639-1-nils.wallmenius@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0986534711=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20161214205245.2639-1-nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?Q?Nils_Wallm=c3=a9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0986534711==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ifRrHJSCsIgqNAHTAlr8fNOOR8eKXT8wJ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ifRrHJSCsIgqNAHTAlr8fNOOR8eKXT8wJ
Content-Type: multipart/mixed; boundary="JI5ImnHm3j9sjjXSWljbF0QBuAt29NCGF";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?Q?Nils_Wallm=c3=a9nius?= <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <5a7b19aa-2c1b-79ed-4ae7-a49be56edf37-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Remove checking for atombios
References: <20161214205245.2639-1-nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <20161214205245.2639-1-nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--JI5ImnHm3j9sjjXSWljbF0QBuAt29NCGF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 12/15/2016 07:52 AM, Nils Wallm=C3=A9nius wrote:
> This is a left over from radeon, amdgpu doesn't support any
> non-atombios parts and amdgpu_device_init would bail if the
> check for atombios failed anyway.
>=20
> Signed-off-by: Nils Wallm=C3=A9nius <nils.wallmenius-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c       | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c       | 12 ++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  8 +-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c    | 10 ++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c        |  3 +--
>  drivers/gpu/drm/amd/amdgpu/atombios_encoders.c |  6 ------
>  7 files changed, 16 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> index 29d3a91..11de710 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1330,7 +1330,6 @@ struct amdgpu_device {
> =20
>  	/* BIOS */
>  	uint8_t				*bios;
> -	bool				is_atom_bios;
>  	struct amdgpu_bo		*stollen_vga_memory;
>  	uint32_t			bios_scratch[AMDGPU_BIOS_NUM_SCRATCH];
> =20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_acpi.c
> index 5796539..ef79551 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -672,12 +672,10 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
> =20
>  			if ((enc->devices & (ATOM_DEVICE_LCD_SUPPORT)) &&
>  			    enc->enc_priv) {
> -				if (adev->is_atom_bios) {
> -					struct amdgpu_encoder_atom_dig *dig =3D enc->enc_priv;
> -					if (dig->bl_dev) {
> -						atif->encoder_for_bl =3D enc;
> -						break;
> -					}
> +				struct amdgpu_encoder_atom_dig *dig =3D enc->enc_priv;
> +				if (dig->bl_dev) {
> +					atif->encoder_for_bl =3D enc;
> +					break;
>  				}
>  			}
>  		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_bios.c
> index b7e2762..1103259 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -387,15 +387,15 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
>  	if (!bios_header_start) {
>  		goto free_bios;
>  	}
> +
> +	/* Must be an ATOMBIOS */
>  	tmp =3D bios_header_start + 4;
> -	if (!memcmp(adev->bios + tmp, "ATOM", 4) ||
> -	    !memcmp(adev->bios + tmp, "MOTA", 4)) {
> -		adev->is_atom_bios =3D true;
> -	} else {
> -		adev->is_atom_bios =3D false;
> +	if (memcmp(adev->bios + tmp, "ATOM", 4) &&
> +	    memcmp(adev->bios + tmp, "MOTA", 4)) {
> +		goto free_bios;
>  	}
> =20
> -	DRM_DEBUG("%sBIOS detected\n", adev->is_atom_bios ? "ATOM" : "COM");
> +	DRM_DEBUG("ATOMBIOS detected\n");
>  	return true;
>  free_bios:
>  	kfree(adev->bios);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index d907411..dc017d1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1603,7 +1603,6 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
>  	adev->pdev =3D pdev;
>  	adev->flags =3D flags;
>  	adev->asic_type =3D flags & AMD_ASIC_MASK;
> -	adev->is_atom_bios =3D false;
>  	adev->usec_timeout =3D AMDGPU_MAX_USEC_TIMEOUT;
>  	adev->mc.gtt_size =3D 512 * 1024 * 1024;
>  	adev->accel_working =3D false;
> @@ -1718,12 +1717,7 @@ int amdgpu_device_init(struct amdgpu_device *ade=
v,
>  		r =3D -EINVAL;
>  		goto failed;
>  	}
> -	/* Must be an ATOMBIOS */
> -	if (!adev->is_atom_bios) {
> -		dev_err(adev->dev, "Expecting atombios for GPU\n");
> -		r =3D -EINVAL;
> -		goto failed;
> -	}
> +
>  	r =3D amdgpu_atombios_init(adev);
>  	if (r) {
>  		dev_err(adev->dev, "amdgpu_atombios_init failed\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_display.c
> index 741144f..d235125 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -582,12 +582,10 @@ int amdgpu_modeset_create_props(struct amdgpu_dev=
ice *adev)
>  {
>  	int sz;
> =20
> -	if (adev->is_atom_bios) {
> -		adev->mode_info.coherent_mode_property =3D
> -			drm_property_create_range(adev->ddev, 0 , "coherent", 0, 1);
> -		if (!adev->mode_info.coherent_mode_property)
> -			return -ENOMEM;
> -	}
> +	adev->mode_info.coherent_mode_property =3D
> +		drm_property_create_range(adev->ddev, 0 , "coherent", 0, 1);
> +	if (!adev->mode_info.coherent_mode_property)
> +		return -ENOMEM;
> =20
>  	adev->mode_info.load_detect_property =3D
>  		drm_property_create_range(adev->ddev, 0, "load detection", 0, 1);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_i2c.c
> index 91d3673..f273999 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
> @@ -231,8 +231,7 @@ void amdgpu_i2c_init(struct amdgpu_device *adev)
>  	if (amdgpu_hw_i2c)
>  		DRM_INFO("hw_i2c forced on, you may experience display detection pro=
blems!\n");
> =20
> -	if (adev->is_atom_bios)
> -		amdgpu_atombios_i2c_init(adev);
> +	amdgpu_atombios_i2c_init(adev);
>  }
> =20
>  /* remove all the buses */
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/g=
pu/drm/amd/amdgpu/atombios_encoders.c
> index c32eca2..2af26d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -181,9 +181,6 @@ void amdgpu_atombios_encoder_init_backlight(struct =
amdgpu_encoder *amdgpu_encode
>  	if (!amdgpu_encoder->enc_priv)
>  		return;
> =20
> -	if (!adev->is_atom_bios)
> -		return;
> -
>  	if (!(adev->mode_info.firmware_flags & ATOM_BIOS_INFO_BL_CONTROLLED_B=
Y_GPU))
>  		return;
> =20
> @@ -236,9 +233,6 @@ amdgpu_atombios_encoder_fini_backlight(struct amdgp=
u_encoder *amdgpu_encoder)
>  	if (!amdgpu_encoder->enc_priv)
>  		return;
> =20
> -	if (!adev->is_atom_bios)
> -		return;
> -
>  	if (!(adev->mode_info.firmware_flags & ATOM_BIOS_INFO_BL_CONTROLLED_B=
Y_GPU))
>  		return;
> =20
>=20


--JI5ImnHm3j9sjjXSWljbF0QBuAt29NCGF--

--ifRrHJSCsIgqNAHTAlr8fNOOR8eKXT8wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUfxvAAoJEP4bvbfZuWjbeSgQAL/hbjd4zrAYLQ3ovrSSd34c
OHonJTEL0nx7ZzNz0Sg2e5zX74N32dmHv1kbAmBeI18P4KLQmzbijLQ29hzUuwQZ
+Vnvv+HWoaD0jo3t2kPtjE2j+0ULkogvPBNzxIlSa/eyJ+lXI2JV4GLVIbT9Yn9u
5Mmuwa4DGAoUEA4lxbSx/qdRu5Tx19NTTBEoVH46p3wj6xkaSmH6sNgAO+fuwZGZ
8chcW8ndeHpQ0yv+tWeBVEs8xD96P+A5D6GRMaDRpA/IgAuXUj/Rnl3ChEzSOjUY
VYN8uJkT59mDxrRnGLL3CS6CwqvOuc9PRf9Rl4pW8RcBTpa74UTNxy69Fcgf3RoR
ELo5dm7ASacFFBAxpzkQkPN2pkwfWN9SMcLKCl0BuQjCmxop5iTCKMCyeC5XV2ga
NHdFA3KrS4H7Hhi4asswf1pgvu0odVKbNpqHbl5zYr8k0tKXCTlPA9EqqE5kofnB
9Ij6m9t3SqbV7dcaGJyowbLRxgkgLB5OeQoi5eqvyBT8vxltmzpZgv88wdmn9YdF
gv1wbA667kK4iCFUVFzMZiyE0qdh4X2VCDLjXijSAjyk5Mi1dKm2K0AQYW7LAGDy
LVfarhXQGLCeKt95yTtL+cdI6/kXxOAmPlzoGqpOop8DCZI+Woq3UJkEBm8yZD/z
kleYI/6BQKjgD9XCYhQn
=oBbo
-----END PGP SIGNATURE-----

--ifRrHJSCsIgqNAHTAlr8fNOOR8eKXT8wJ--

--===============0986534711==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0986534711==--
