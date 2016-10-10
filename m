From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: allow TA_CS_BC_BASE_ADDR on SI
Date: Tue, 11 Oct 2016 10:01:18 +1100
Message-ID: <be84b277-3ca8-0c2b-2fe7-5bdce46c5519@folklore1984.net>
References: <1476098605-8594-1-git-send-email-maraeo@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1933176723=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1476098605-8594-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
--===============1933176723==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bncojReoXukkodgKA7v7AHurWAnQ7GAra"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bncojReoXukkodgKA7v7AHurWAnQ7GAra
Content-Type: multipart/mixed; boundary="49ghRfl7KfSBUBkxnCe6HLlerMxeAil08";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <be84b277-3ca8-0c2b-2fe7-5bdce46c5519-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/radeon: allow TA_CS_BC_BASE_ADDR on SI
References: <1476098605-8594-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <1476098605-8594-1-git-send-email-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--49ghRfl7KfSBUBkxnCe6HLlerMxeAil08
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 10/10/2016 10:23 PM, Marek Ol=9A=E1k wrote:
> From: Marek Ol=9A=E1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>=20
> Required for border colors in compute shaders.
>=20
> Signed-off-by: Marek Ol=9A=E1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 3 ++-
>  drivers/gpu/drm/radeon/si.c         | 1 +
>  drivers/gpu/drm/radeon/sid.h        | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/rade=
on/radeon_drv.c
> index a192653..a95263c 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -90,23 +90,24 @@
>   *   2.39.0 - Add INFO query for number of active CUs
>   *   2.40.0 - Add RADEON_GEM_GTT_WC/UC, flush HDP cache before submitt=
ing
>   *            CS to GPU on >=3D r600
>   *   2.41.0 - evergreen/cayman: Add SET_BASE/DRAW_INDIRECT command par=
sing support
>   *   2.42.0 - Add VCE/VUI (Video Usability Information) support
>   *   2.43.0 - RADEON_INFO_GPU_RESET_COUNTER
>   *   2.44.0 - SET_APPEND_CNT packet3 support
>   *   2.45.0 - Allow setting shader registers using DMA/COPY packet3 on=
 SI
>   *   2.46.0 - Add PFP_SYNC_ME support on evergreen
>   *   2.47.0 - Add UVD_NO_OP register support
> + *   2.48.0 - TA_CS_BC_BASE_ADDR allowed on SI
>   */
>  #define KMS_DRIVER_MAJOR	2
> -#define KMS_DRIVER_MINOR	47
> +#define KMS_DRIVER_MINOR	48
>  #define KMS_DRIVER_PATCHLEVEL	0
>  int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags=
);
>  int radeon_driver_unload_kms(struct drm_device *dev);
>  void radeon_driver_lastclose_kms(struct drm_device *dev);
>  int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *fi=
le_priv);
>  void radeon_driver_postclose_kms(struct drm_device *dev,
>  				 struct drm_file *file_priv);
>  void radeon_driver_preclose_kms(struct drm_device *dev,
>  				struct drm_file *file_priv);
>  int radeon_suspend_kms(struct drm_device *dev, bool suspend,
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index 7ee9aaf..e402be8 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -4424,20 +4424,21 @@ static bool si_vm_reg_valid(u32 reg)
>  	case PA_SC_LINE_STIPPLE_STATE:
>  	case PA_SC_ENHANCE:
>  	case SQC_CACHES:
>  	case SPI_STATIC_THREAD_MGMT_1:
>  	case SPI_STATIC_THREAD_MGMT_2:
>  	case SPI_STATIC_THREAD_MGMT_3:
>  	case SPI_PS_MAX_WAVE_ID:
>  	case SPI_CONFIG_CNTL:
>  	case SPI_CONFIG_CNTL_1:
>  	case TA_CNTL_AUX:
> +	case TA_CS_BC_BASE_ADDR:
>  		return true;
>  	default:
>  		DRM_ERROR("Invalid register 0x%x in CS\n", reg);
>  		return false;
>  	}
>  }
> =20
>  static int si_vm_packet3_ce_check(struct radeon_device *rdev,
>  				  u32 *ib, struct radeon_cs_packet *pkt)
>  {
> diff --git a/drivers/gpu/drm/radeon/sid.h b/drivers/gpu/drm/radeon/sid.=
h
> index eb220ee..65a911d 100644
> --- a/drivers/gpu/drm/radeon/sid.h
> +++ b/drivers/gpu/drm/radeon/sid.h
> @@ -1138,20 +1138,21 @@
>  #define	CGTS_USER_TCC_DISABLE				0x914C
>  #define		TCC_DISABLE_MASK				0xFFFF0000
>  #define		TCC_DISABLE_SHIFT				16
>  #define	CGTS_SM_CTRL_REG				0x9150
>  #define		OVERRIDE				(1 << 21)
>  #define		LS_OVERRIDE				(1 << 22)
> =20
>  #define	SPI_LB_CU_MASK					0x9354
> =20
>  #define	TA_CNTL_AUX					0x9508
> +#define	TA_CS_BC_BASE_ADDR				0x950C
> =20
>  #define CC_RB_BACKEND_DISABLE				0x98F4
>  #define		BACKEND_DISABLE(x)     			((x) << 16)
>  #define GB_ADDR_CONFIG  				0x98F8
>  #define		NUM_PIPES(x)				((x) << 0)
>  #define		NUM_PIPES_MASK				0x00000007
>  #define		NUM_PIPES_SHIFT				0
>  #define		PIPE_INTERLEAVE_SIZE(x)			((x) << 4)
>  #define		PIPE_INTERLEAVE_SIZE_MASK		0x00000070
>  #define		PIPE_INTERLEAVE_SIZE_SHIFT		4
>=20


--49ghRfl7KfSBUBkxnCe6HLlerMxeAil08--

--bncojReoXukkodgKA7v7AHurWAnQ7GAra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX/B2+AAoJEP4bvbfZuWjbyscQANoFiqwtoAoUXyYu8WejmRsz
LcZhuEytXJPSgFz0ql1m7UIldTNoJSAdiAbyVH15U+Cr/H/MIioCBkFPb0SqhXaV
D6g5oJn50SL9QJUA8Diy7JPtaTbWnBnEd3KANjGOUhwkT/daJjzqJvUXgFY475R1
miXRp/eKXhCcEIW2Qcru7BV0h71MCheteXWwQXQJOxB/HP5xqIINdqkSA87bvvZ+
gEe5/dZ1FgDsLgBTMqMeHxARekUQ+x0UTmywAEHskzBQbKppFz9mPisqLqWsZnY5
/WY3eWCffE40pB6ZFRAoikkmxC3WCGKdZXagnBnpTkJGJ5DESBf2Vd6e8SHk8Xjy
CDB3YRec3Cpvoj18N/G2KSPFnyikVp6tS90HGOpp4lg1aNRdxCq00ay/VVXRuFWX
V+P9nvTdyVyJXHzNTF2S5w9/eymynzBUSg/3APjcbzb+LDnLab8u/PdCv6XsqhLa
ZlmHTv7w6shCiddVPK//JwcuQ/ty0NHFurrrMEgrY4tIfg0ApHblizv4XG/VmAVg
7PtjP57k4VB9DACWCItzBUNBcc6GQbPOHWQsL5I8h1lbk/62OJaqGjOzPIzASWeB
FJqq7jVtaDqlNYmxTIKGapcb5wvZjtWx8DNNceHw2NJFzMB3WEYURMNZOLyrzd3y
P6vul1JoLaoV595RXVcd
=CmCj
-----END PGP SIGNATURE-----

--bncojReoXukkodgKA7v7AHurWAnQ7GAra--

--===============1933176723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1933176723==--
