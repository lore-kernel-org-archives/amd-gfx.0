From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add AMDGPU_INFO_NUM_EVICTIONS
Date: Sun, 21 Aug 2016 15:42:40 +1000
Message-ID: <3b6d31ba-6711-5b2a-77dd-1bda3e0045c9@folklore1984.net>
References: <1471542523-15729-1-git-send-email-maraeo@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0444819056=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471542523-15729-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0444819056==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QLNKLS8PFKELf4qLNt2eSuNtGiITPt2Is"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QLNKLS8PFKELf4qLNt2eSuNtGiITPt2Is
Content-Type: multipart/mixed; boundary="AsV2ICHJ3XPWP6s1UL2KA3IUm2MQv6k4a"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <3b6d31ba-6711-5b2a-77dd-1bda3e0045c9-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add AMDGPU_INFO_NUM_EVICTIONS
References: <1471542523-15729-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <1471542523-15729-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--AsV2ICHJ3XPWP6s1UL2KA3IUm2MQv6k4a
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 08/19/2016 03:48 AM, Marek Ol=C5=A1=C3=A1k wrote:
> From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>=20
> For profiling.
>=20
> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 3 +++
>  include/uapi/drm/amdgpu_drm.h           | 2 ++
>  3 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> index 2d7072a..a75d45a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -46,20 +46,21 @@
> =20
>  #include "amdgpu_amdkfd.h"
> =20
>  /*
>   * KMS wrapper.
>   * - 3.0.0 - initial driver
>   * - 3.1.0 - allow reading more status registers (GRBM, SRBM, SDMA, CP=
)
>   * - 3.2.0 - GFX8: Uses EOP_TC_WB_ACTION_EN, so UMDs don't have to do =
the same
>   *           at the end of IBs.
>   * - 3.3.0 - Add VM support for UVD on supported hardware.
> + * - 3.4.0 - Add AMDGPU_INFO_NUM_EVICTIONS.
>   */
>  #define KMS_DRIVER_MAJOR	3
>  #define KMS_DRIVER_MINOR	3
>  #define KMS_DRIVER_PATCHLEVEL	0
> =20
>  int amdgpu_vram_limit =3D 0;
>  int amdgpu_gart_size =3D -1; /* auto */
>  int amdgpu_max_bo_reloc_rate =3D -1; /* auto */
>  int amdgpu_benchmarking =3D 0;
>  int amdgpu_testing =3D 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> index 0fb5488..f0c01da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -360,20 +360,23 @@ static int amdgpu_info_ioctl(struct drm_device *d=
ev, void *data, struct drm_file
>  		ret =3D amdgpu_firmware_info(&fw_info, &info->query_fw, adev);
>  		if (ret)
>  			return ret;
> =20
>  		return copy_to_user(out, &fw_info,
>  				    min((size_t)size, sizeof(fw_info))) ? -EFAULT : 0;
>  	}
>  	case AMDGPU_INFO_NUM_BYTES_MOVED:
>  		ui64 =3D atomic64_read(&adev->num_bytes_moved);
>  		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
> +	case AMDGPU_INFO_NUM_EVICTIONS:
> +		ui64 =3D atomic64_read(&adev->num_evictions);
> +		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>  	case AMDGPU_INFO_VRAM_USAGE:
>  		ui64 =3D atomic64_read(&adev->vram_usage);
>  		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>  	case AMDGPU_INFO_VIS_VRAM_USAGE:
>  		ui64 =3D atomic64_read(&adev->vram_vis_usage);
>  		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>  	case AMDGPU_INFO_GTT_USAGE:
>  		ui64 =3D atomic64_read(&adev->gtt_usage);
>  		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
>  	case AMDGPU_INFO_GDS_CONFIG: {
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> index 8df3816..72eb21a 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -474,20 +474,22 @@ struct drm_amdgpu_cs_chunk_data {
>  /* Information about GDS, etc. resource configuration */
>  #define AMDGPU_INFO_GDS_CONFIG			0x13
>  /* Query information about VRAM and GTT domains */
>  #define AMDGPU_INFO_VRAM_GTT			0x14
>  /* Query information about register in MMR address space*/
>  #define AMDGPU_INFO_READ_MMR_REG		0x15
>  /* Query information about device: rev id, family, etc. */
>  #define AMDGPU_INFO_DEV_INFO			0x16
>  /* visible vram usage */
>  #define AMDGPU_INFO_VIS_VRAM_USAGE		0x17
> +/* number of TTM buffer evictions */
> +#define AMDGPU_INFO_NUM_EVICTIONS		0x18
> =20
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
>  #define AMDGPU_INFO_MMR_SH_INDEX_SHIFT	8
>  #define AMDGPU_INFO_MMR_SH_INDEX_MASK	0xff
> =20
>  struct drm_amdgpu_query_fw {
>  	/** AMDGPU_INFO_FW_* */
>  	__u32 fw_type;
>  	/**
>=20


--AsV2ICHJ3XPWP6s1UL2KA3IUm2MQv6k4a--

--QLNKLS8PFKELf4qLNt2eSuNtGiITPt2Is
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXuT9QAAoJEP4bvbfZuWjbbGkP/01FbQz6ZGl27ecf6KsS8WpU
t1SutsjfusRUbxMShfPF+QxfD4C0JGiUo6VqorQjIpagY21+GOkq0VFdx7LKCJek
5LgRY3XPOfhP2bHjEQ3oBCW4t9eWT6rvsVyg2AIqLMVVTYxjmfdpD2rDGL6lTx2P
zq0yf0LRB5JNxQ0XLjhKaF45s9sKnTX5CkDUj9VzMDR94Sc3kPlNBKrUtNoHF/xe
Sly+7u4zGM1rNM9cmb4NJUMDzrb2EwHLynTO+8LaI0/QsOAQ7zGotAD8uODKdUDQ
GK69vXnCXQl7i3P8r8hiPTMy1hC+Ypp6FLPGeonJEflqNi8LNqBO2g2W/6QMdZNQ
n6rHywbNMVDrilzgVXw0uuNyhfQrsxwub/1WnTdceQlxGI59JjX5GTJWz+0Dm7WO
9bIzeXhxkYtjxjj8BANbetM5WczUeXan+PeBH5WLuskSeOiWNHKYVG9f36mzJZp6
8U2rLqzgJwDn8bsc3wfbZO5wndRgitQ7Vu0pPZx00ncvCyQaEGKTtMZnb8NSpHdB
J6UK5/l2Hy/ImpK7HNuj5dNHhGBvYE3iypE/Iku4Mupuxo0ot4OH8I15YlMZJ7/z
jTZFosGWQMHhxQ1hLVmu2sjI2LjLq99uQIpzZPinhwnw/AQ97KcHYldzXUmgAuDx
tWPIGvPuJOBWftRDE7VR
=lUSi
-----END PGP SIGNATURE-----

--QLNKLS8PFKELf4qLNt2eSuNtGiITPt2Is--

--===============0444819056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0444819056==--
