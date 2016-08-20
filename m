From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: sync amdgpu_drm.h with the kernel
Date: Sat, 20 Aug 2016 20:45:02 +1000
Message-ID: <919be648-e127-6d10-c6e3-d9dcf5c87d3d@folklore1984.net>
References: <1471616102-4889-1-git-send-email-maraeo@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1908101189=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1471616102-4889-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
--===============1908101189==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VIE6ks84bBNRFqCI1kIUxMmcrgJhnNEIn"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VIE6ks84bBNRFqCI1kIUxMmcrgJhnNEIn
Content-Type: multipart/mixed; boundary="sbwmRbSQkCobIqUMs4SPg9mmSFu2wwl6u"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <919be648-e127-6d10-c6e3-d9dcf5c87d3d-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH libdrm 1/2] amdgpu: sync amdgpu_drm.h with the kernel
References: <1471616102-4889-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <1471616102-4889-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--sbwmRbSQkCobIqUMs4SPg9mmSFu2wwl6u
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 08/20/2016 12:15 AM, Marek Ol=C5=A1=C3=A1k wrote:
> From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>=20
> ---
>  include/drm/amdgpu_drm.h | 42 ++++++++++++++++++++++++++--------------=
--
>  1 file changed, 26 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/drm/amdgpu_drm.h b/include/drm/amdgpu_drm.h
> index 92f5970..d192052 100644
> --- a/include/drm/amdgpu_drm.h
> +++ b/include/drm/amdgpu_drm.h
> @@ -27,20 +27,24 @@
>   *    Kevin E. Martin <martin-jCdQPDEk3idBDgjK7y7TUQ@public.gmane.org>
>   *    Gareth Hughes <gareth-jCdQPDEk3idBDgjK7y7TUQ@public.gmane.org>
>   *    Keith Whitwell <keith-CdwZJljFklH+2FeEXyspIVaTQe2KTcn/@public.gmane.org>
>   */
> =20
>  #ifndef __AMDGPU_DRM_H__
>  #define __AMDGPU_DRM_H__
> =20
>  #include "drm.h"
> =20
> +#if defined(__cplusplus)
> +extern "C" {
> +#endif
> +
>  #define DRM_AMDGPU_GEM_CREATE		0x00
>  #define DRM_AMDGPU_GEM_MMAP		0x01
>  #define DRM_AMDGPU_CTX			0x02
>  #define DRM_AMDGPU_BO_LIST		0x03
>  #define DRM_AMDGPU_CS			0x04
>  #define DRM_AMDGPU_INFO			0x05
>  #define DRM_AMDGPU_GEM_METADATA		0x06
>  #define DRM_AMDGPU_GEM_WAIT_IDLE	0x07
>  #define DRM_AMDGPU_GEM_VA		0x08
>  #define DRM_AMDGPU_WAIT_CS		0x09
> @@ -476,20 +480,36 @@ struct drm_amdgpu_cs_chunk_data {
>  /* Query information about device: rev id, family, etc. */
>  #define AMDGPU_INFO_DEV_INFO			0x16
>  /* visible vram usage */
>  #define AMDGPU_INFO_VIS_VRAM_USAGE		0x17
> =20
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT	0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK	0xff
>  #define AMDGPU_INFO_MMR_SH_INDEX_SHIFT	8
>  #define AMDGPU_INFO_MMR_SH_INDEX_MASK	0xff
> =20
> +struct drm_amdgpu_query_fw {
> +	/** AMDGPU_INFO_FW_* */
> +	uint32_t fw_type;
> +	/**
> +	 * Index of the IP if there are more IPs of
> +	 * the same type.
> +	 */
> +	uint32_t ip_instance;
> +	/**
> +	 * Index of the engine. Whether this is used depends
> +	 * on the firmware type. (e.g. MEC, SDMA)
> +	 */
> +	uint32_t index;
> +	uint32_t _pad;
> +};
> +
>  /* Input structure for the INFO ioctl */
>  struct drm_amdgpu_info {
>  	/* Where the return value will be stored */
>  	uint64_t return_pointer;
>  	/* The size of the return value. Just like "size" in "snprintf",
>  	 * it limits how many bytes the kernel can write. */
>  	uint32_t return_size;
>  	/* The query request id. */
>  	uint32_t query;
> =20
> @@ -511,35 +531,21 @@ struct drm_amdgpu_info {
> =20
>  		struct {
>  			uint32_t dword_offset;
>  			/** number of registers to read */
>  			uint32_t count;
>  			uint32_t instance;
>  			/** For future use, no flags defined so far */
>  			uint32_t flags;
>  		} read_mmr_reg;
> =20
> -		struct {
> -			/** AMDGPU_INFO_FW_* */
> -			uint32_t fw_type;
> -			/**
> -			 * Index of the IP if there are more IPs of
> -			 * the same type.
> -			 */
> -			uint32_t ip_instance;
> -			/**
> -			 * Index of the engine. Whether this is used depends
> -			 * on the firmware type. (e.g. MEC, SDMA)
> -			 */
> -			uint32_t index;
> -			uint32_t _pad;
> -		} query_fw;
> +		struct drm_amdgpu_query_fw query_fw;
>  	};
>  };
> =20
>  struct drm_amdgpu_info_gds {
>  	/** GDS GFX partition size */
>  	uint32_t gds_gfx_partition_size;
>  	/** GDS compute partition size */
>  	uint32_t compute_partition_size;
>  	/** total GDS memory size */
>  	uint32_t gds_total_size;
> @@ -634,13 +640,17 @@ struct drm_amdgpu_info_hw_ip {
>  };
> =20
>  /*
>   * Supported GPU families
>   */
>  #define AMDGPU_FAMILY_UNKNOWN			0
>  #define AMDGPU_FAMILY_SI			110 /* Hainan, Oland, Verde, Pitcairn, Tahi=
ti */
>  #define AMDGPU_FAMILY_CI			120 /* Bonaire, Hawaii */
>  #define AMDGPU_FAMILY_KV			125 /* Kaveri, Kabini, Mullins */
>  #define AMDGPU_FAMILY_VI			130 /* Iceland, Tonga */
> -#define AMDGPU_FAMILY_CZ			135 /* Carrizo */
> +#define AMDGPU_FAMILY_CZ			135 /* Carrizo, Stoney */
> +
> +#if defined(__cplusplus)
> +}
> +#endif
> =20
>  #endif
>=20


--sbwmRbSQkCobIqUMs4SPg9mmSFu2wwl6u--

--VIE6ks84bBNRFqCI1kIUxMmcrgJhnNEIn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXuDSyAAoJEP4bvbfZuWjb9WAP/igPB+1i0rjnOUyxcFtaC8PO
5PCA8lHwt6JRPwYdp6/ZeFx2Y2QcNAnOSyw0lavvoXE5JBGUc2nJAERq9x5IDEYN
YSWqrs2He/vULLklKiPn/XDpBTbE33/KXo0hFq32dw07X5Kxti4PhN3QbqwSQEVv
1mYAHBGOy6xATLVEc0lCN9nmonxfICLVw6TbVfuAlLtpN28r0eqz0WiBAPsDSE55
45bSLSMEJlm664QhdUJqVoEXctm1ah4Q5pyMttwvlloJZz1hJcekyXDTsLgtuwMM
WmFex0L/q1MNjtnBD3Kz9EV1314FTcgPsljtTQI6Wyy2pLQO1W5yaH+3b/TqNdNc
TQVxbURrvwsJjxQFg9NgPF2sz+bzmA/0hvBc0zKyjDlmt5ADDlGouuflPzkb7DmP
07ORfEU42hg49uC7n58l6eHk9bXGRZp93AeS48LltdORzwVot76wxneuYHpob0p2
kyugZYyytGG3Bq+Jq5WdB8rDEoTtvdB06oqwKsOyvTGPN/MlU7OYmV+319u4TGbc
SGxg5BLPmV1auCbHVrMQLPVa567YUgIzTc8qDv8+2e31QDddj6/CSKNlLS49dXY5
kyXw4mGIZrMB9WUGLDEa1jtKJQjgLU2S+t8IX+4oK5ctEie4o+R/49uygBC/6Ylw
QkhjlMoMfIMXQeLtJ1na
=b6Wj
-----END PGP SIGNATURE-----

--VIE6ks84bBNRFqCI1kIUxMmcrgJhnNEIn--

--===============1908101189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1908101189==--
