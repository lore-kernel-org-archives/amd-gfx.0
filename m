From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add HDMI audio support for si dce6
Date: Tue, 21 Feb 2017 23:08:04 +1100
Message-ID: <d2ba0088-cac6-7674-a6e7-d00d7f69b68c@folklore1984.net>
References: <1487673594-1452-1-git-send-email-Xiaojie.Yuan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1716203786=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1487673594-1452-1-git-send-email-Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
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
To: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1716203786==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gv8nPD65lIArMvScsTSQnvehExiVrCapq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gv8nPD65lIArMvScsTSQnvehExiVrCapq
Content-Type: multipart/mixed; boundary="MUN9VevhExTsc5C48PpT8gMCmLp6IsSXH";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <d2ba0088-cac6-7674-a6e7-d00d7f69b68c-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add HDMI audio support for si dce6
References: <1487673594-1452-1-git-send-email-Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1487673594-1452-1-git-send-email-Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

--MUN9VevhExTsc5C48PpT8gMCmLp6IsSXH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 02/21/2017 09:39 PM, Xiaojie Yuan wrote:
> Signed-off-by: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 130 ++++++++++++++++++++++++++=
+++++---
>  1 file changed, 121 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v6_0.c
> index c940bec..1398db6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1531,12 +1531,58 @@ static void dce_v6_0_audio_fini(struct amdgpu_d=
evice *adev)
>  	adev->mode_info.audio.enabled =3D false;
>  }
> =20
> -/*
> -static void dce_v6_0_afmt_update_ACR(struct drm_encoder *encoder, uint=
32_t clock)
> +static void dce_v6_0_audio_set_vbi_packet(struct drm_encoder *encoder)=

>  {
> -	DRM_INFO("xxxx: dce_v6_0_afmt_update_ACR---no imp!!!!!\n");
> +	struct drm_device *dev =3D encoder->dev;
> +	struct amdgpu_device *adev =3D dev->dev_private;
> +	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> +	u32 tmp;
> +
> +	tmp =3D RREG32(mmHDMI_VBI_PACKET_CONTROL + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL, HDMI_NULL_SEND, 1=
);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL, HDMI_GC_SEND, 1);=

> +	tmp =3D REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL, HDMI_GC_CONT, 1);=

> +	WREG32(mmHDMI_VBI_PACKET_CONTROL + dig->afmt->offset, tmp);
> +}
> +
> +static void dce_v6_0_audio_set_acr(struct drm_encoder *encoder,
> +				   uint32_t clock, int bpc)
> +{
> +	struct drm_device *dev =3D encoder->dev;
> +	struct amdgpu_device *adev =3D dev->dev_private;
> +	struct amdgpu_afmt_acr acr =3D amdgpu_afmt_acr(clock);
> +	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> +	u32 tmp;
> +
> +	tmp =3D RREG32(mmHDMI_ACR_PACKET_CONTROL + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_PACKET_CONTROL, HDMI_ACR_AUTO_SEN=
D, 1);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_PACKET_CONTROL, HDMI_ACR_SOURCE,
> +			bpc > 8 ? 0 : 1);
> +	WREG32(mmHDMI_ACR_PACKET_CONTROL + dig->afmt->offset, tmp);
> +
> +	tmp =3D RREG32(mmHDMI_ACR_32_0 + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_32_0, HDMI_ACR_CTS_32, acr.cts_32=
khz);
> +	WREG32(mmHDMI_ACR_32_0 + dig->afmt->offset, tmp);
> +	tmp =3D RREG32(mmHDMI_ACR_32_1 + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_32_1, HDMI_ACR_N_32, acr.n_32khz)=
;
> +	WREG32(mmHDMI_ACR_32_1 + dig->afmt->offset, tmp);
> +
> +	tmp =3D RREG32(mmHDMI_ACR_44_0 + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_44_0, HDMI_ACR_CTS_44, acr.cts_44=
_1khz);
> +	WREG32(mmHDMI_ACR_44_0 + dig->afmt->offset, tmp);
> +	tmp =3D RREG32(mmHDMI_ACR_44_1 + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_44_1, HDMI_ACR_N_44, acr.n_44_1kh=
z);
> +	WREG32(mmHDMI_ACR_44_1 + dig->afmt->offset, tmp);
> +
> +	tmp =3D RREG32(mmHDMI_ACR_48_0 + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_48_0, HDMI_ACR_CTS_48, acr.cts_48=
khz);
> +	WREG32(mmHDMI_ACR_48_0 + dig->afmt->offset, tmp);
> +	tmp =3D RREG32(mmHDMI_ACR_48_1 + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_ACR_48_1, HDMI_ACR_N_48, acr.n_48khz)=
;
> +	WREG32(mmHDMI_ACR_48_1 + dig->afmt->offset, tmp);
>  }
> -*/
> =20
>  static void dce_v6_0_afmt_update_avi_infoframe(struct drm_encoder *enc=
oder,
>  					       struct drm_display_mode *mode)
> @@ -1585,6 +1631,7 @@ static void dce_v6_0_audio_set_dto(struct drm_enc=
oder *encoder, u32 clock)
>  	struct drm_device *dev =3D encoder->dev;
>  	struct amdgpu_device *adev =3D dev->dev_private;
>  	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(encoder->crtc);
> +	int em =3D amdgpu_atombios_encoder_get_encoder_mode(encoder);
>  	u32 tmp;
> =20
>  	/*
> @@ -1596,10 +1643,21 @@ static void dce_v6_0_audio_set_dto(struct drm_e=
ncoder *encoder, u32 clock)
>  	tmp =3D RREG32(mmDCCG_AUDIO_DTO_SOURCE);
>  	tmp =3D REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE,
>  			DCCG_AUDIO_DTO0_SOURCE_SEL, amdgpu_crtc->crtc_id);
> -	tmp =3D REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL,=
 1);
> +	if (em =3D=3D ATOM_ENCODER_MODE_HDMI) {
> +		tmp =3D REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE,
> +				DCCG_AUDIO_DTO_SEL, 0);
> +	} else if (ENCODER_MODE_IS_DP(em)) {
> +		tmp =3D REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE,
> +				DCCG_AUDIO_DTO_SEL, 1);
> +	}
>  	WREG32(mmDCCG_AUDIO_DTO_SOURCE, tmp);
> -	WREG32(mmDCCG_AUDIO_DTO1_PHASE, 24000);
> -	WREG32(mmDCCG_AUDIO_DTO1_MODULE, clock);
> +	if (em =3D=3D ATOM_ENCODER_MODE_HDMI) {
> +		WREG32(mmDCCG_AUDIO_DTO0_PHASE, 24000);
> +		WREG32(mmDCCG_AUDIO_DTO0_MODULE, clock);
> +	} else if (ENCODER_MODE_IS_DP(em)) {
> +		WREG32(mmDCCG_AUDIO_DTO1_PHASE, 24000);
> +		WREG32(mmDCCG_AUDIO_DTO1_MODULE, clock);
> +	}
>  }
> =20
>  static void dce_v6_0_set_audio_packet(struct drm_encoder *encoder)
> @@ -1659,6 +1717,43 @@ static void dce_v6_0_audio_set_mute(struct drm_e=
ncoder *encoder, bool mute)
>  	WREG32(mmHDMI_GC + dig->afmt->offset, tmp);
>  }
> =20
> +static void dce_v6_0_audio_hdmi_enable(struct drm_encoder *encoder, bo=
ol enable)
> +{
> +	struct drm_device *dev =3D encoder->dev;
> +	struct amdgpu_device *adev =3D dev->dev_private;
> +	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> +	u32 tmp;
> +
> +	if (enable) {
> +		tmp =3D RREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset);
> +		tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_SE=
ND, 1);
> +		tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_CO=
NT, 1);
> +		tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_=
SEND, 1);
> +		tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_=
CONT, 1);
> +		WREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset, tmp);
> +
> +		tmp =3D RREG32(mmHDMI_INFOFRAME_CONTROL1 + dig->afmt->offset);
> +		tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL1, HDMI_AVI_INFO_LI=
NE, 2);
> +		WREG32(mmHDMI_INFOFRAME_CONTROL1 + dig->afmt->offset, tmp);
> +
> +		tmp =3D RREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset);
> +		tmp =3D REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL, AFMT_AUDIO_SAM=
PLE_SEND, 1);
> +		WREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset, tmp);
> +	} else {
> +		tmp =3D RREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset);
> +		tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_SE=
ND, 0);
> +		tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_CO=
NT, 0);
> +		tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_=
SEND, 0);
> +		tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_=
CONT, 0);
> +		WREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset, tmp);
> +
> +		tmp =3D RREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset);
> +		tmp =3D REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL, AFMT_AUDIO_SAM=
PLE_SEND, 0);
> +		WREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset, tmp);
> +	}
> +}
> +
>  static void dce_v6_0_audio_dp_enable(struct drm_encoder *encoder, bool=
 enable)
>  {
>  	struct drm_device *dev =3D encoder->dev;
> @@ -1696,6 +1791,8 @@ static void dce_v6_0_afmt_setmode(struct drm_enco=
der *encoder,
>  	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
>  	struct drm_connector *connector;
>  	struct amdgpu_connector *amdgpu_connector =3D NULL;
> +	int em =3D amdgpu_atombios_encoder_get_encoder_mode(encoder);
> +	int bpc =3D 8;
> =20
>  	if (!dig || !dig->afmt)
>  		return;
> @@ -1719,6 +1816,11 @@ static void dce_v6_0_afmt_setmode(struct drm_enc=
oder *encoder,
>  	if (!dig->afmt->pin)
>  		return;
> =20
> +	if (encoder->crtc) {
> +		struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(encoder->crtc);
> +		bpc =3D amdgpu_crtc->bpc;
> +	}
> +
>  	/* disable audio before setting up hw */
>  	dce_v6_0_audio_enable(adev, dig->afmt->pin, false);
> =20
> @@ -1726,12 +1828,22 @@ static void dce_v6_0_afmt_setmode(struct drm_en=
coder *encoder,
>  	dce_v6_0_audio_write_speaker_allocation(encoder);
>  	dce_v6_0_audio_write_sad_regs(encoder);
>  	dce_v6_0_audio_write_latency_fields(encoder, mode);
> -	dce_v6_0_audio_set_dto(encoder, adev->clock.default_dispclk * 10);
> +	if (em =3D=3D ATOM_ENCODER_MODE_HDMI) {
> +		dce_v6_0_audio_set_dto(encoder, mode->clock);
> +		dce_v6_0_audio_set_vbi_packet(encoder);
> +		dce_v6_0_audio_set_acr(encoder, mode->clock, bpc);
> +	} else if (ENCODER_MODE_IS_DP(em)) {
> +		dce_v6_0_audio_set_dto(encoder, adev->clock.default_dispclk * 10);
> +	}
>  	dce_v6_0_set_audio_packet(encoder);
>  	dce_v6_0_afmt_audio_select_pin(encoder);
>  	dce_v6_0_afmt_update_avi_infoframe(encoder, mode);
>  	dce_v6_0_audio_set_mute(encoder, false);
> -	dce_v6_0_audio_dp_enable(encoder, 1);
> +	if (em =3D=3D ATOM_ENCODER_MODE_HDMI) {
> +		dce_v6_0_audio_hdmi_enable(encoder, 1);
> +	} else if (ENCODER_MODE_IS_DP(em)) {
> +		dce_v6_0_audio_dp_enable(encoder, 1);
> +	}
> =20
>  	/* enable audio after setting up hw */
>  	dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
>=20


--MUN9VevhExTsc5C48PpT8gMCmLp6IsSXH--

--gv8nPD65lIArMvScsTSQnvehExiVrCapq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrC2lAAoJEP4bvbfZuWjbdh8QAMvP93jzGAMWm0bwnzX1wOlQ
SBrWQCNUnT0rBMybShO8jmgcGgF1rqaeErGPsxYv/CzgKMVRZxu+EIXQcD5hih3R
gD79kgejX/yP/CJtGs+ayhCS3HWZC3122JD/YJhA2nXf6YGPyGi3I+1YGSp/ArvQ
Hc9/njFduRFFa3geArTa6cUqiW6TsYmOzKNrJrTgRHbe9HC64HwfoqKvIctZR2kj
hOLaAUP6TW57SpS19xpMWr/eg5BeKTwVmn4g9/3p//HCFsImgqDnCaMqO9fIPpUt
ytYo5yYqWsKsVCLqdgK3UklgW/9pyz3rdUthnKsLY0G+QtL9iturUTxAUVmpYdy+
lc7J6GhicHxmOR+wEEAbMsuxxZGbomMsIbsy7PaVrSyDBDhO0y7G3HOO/x81jWdk
ksO1jDnXuL1sxtU6cDnzcOLoVlraGFScEH7iNFQrkn1dSLxNfPi8se6aAOrlWssd
hI4kksCp5WTg+IifggGhQqg3XlOmTYiCB0NxNkgJgiBoAkwRx66nyKArYh+EJF+Q
Xzkl9f5WpBKY2VQ3L5AlMG0hRypRZrXDl7VLraVOVMerC1c+Qe68UAPjshWEbjJg
EDY3KCwucr4rya4YlzvKbvuQFbZ19CmOnThJZd9ELd2/wMdmj+CMsArCBrsRfGSV
QQZAoDLyhH8szDuQSkSJ
=hoij
-----END PGP SIGNATURE-----

--gv8nPD65lIArMvScsTSQnvehExiVrCapq--

--===============1716203786==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1716203786==--
