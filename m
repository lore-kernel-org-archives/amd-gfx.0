From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH v3] drm/amdgpu: add DP audio support for si dce6 (v3)
Date: Wed, 22 Feb 2017 15:40:08 +1100
Message-ID: <86e62166-a3fa-92af-17d1-4bf1f90f1583@folklore1984.net>
References: <1487734626-27738-1-git-send-email-Xiaojie.Yuan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0652012425=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1487734626-27738-1-git-send-email-Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
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
--===============0652012425==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fMssQ2OaujtTFVKQSb5fSKMXUuPVAXUDl"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fMssQ2OaujtTFVKQSb5fSKMXUuPVAXUDl
Content-Type: multipart/mixed; boundary="qGuQTinwKmfKaheVKLP8P9vpgVqxtAgb2";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <86e62166-a3fa-92af-17d1-4bf1f90f1583-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH v3] drm/amdgpu: add DP audio support for si dce6 (v3)
References: <1487734626-27738-1-git-send-email-Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1487734626-27738-1-git-send-email-Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

--qGuQTinwKmfKaheVKLP8P9vpgVqxtAgb2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 02/22/2017 02:37 PM, Xiaojie Yuan wrote:
> v2: refine dce_v6_0_audio_endpt_wreg() and unify inconsistent method na=
mes
> v3: fix num_pins for tahiti, pitcairn, verde and oland
>=20
> Signed-off-by: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              | 467 +++++++++++++=
++++++--
>  .../drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h |   2 +
>  2 files changed, 433 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v6_0.c
> index 94877cb..7c11ed8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -118,14 +118,27 @@ static const struct {
>  static u32 dce_v6_0_audio_endpt_rreg(struct amdgpu_device *adev,
>  				     u32 block_offset, u32 reg)
>  {
> -	DRM_INFO("xxxx: dce_v6_0_audio_endpt_rreg ----no impl!!!!\n");
> -	return 0;
> +	unsigned long flags;
> +	u32 r;
> +
> +	spin_lock_irqsave(&adev->audio_endpt_idx_lock, flags);
> +	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_INDEX + block_offset, reg);
> +	r =3D RREG32(mmAZALIA_F0_CODEC_ENDPOINT_DATA + block_offset);
> +	spin_unlock_irqrestore(&adev->audio_endpt_idx_lock, flags);
> +
> +	return r;
>  }
> =20
>  static void dce_v6_0_audio_endpt_wreg(struct amdgpu_device *adev,
>  				      u32 block_offset, u32 reg, u32 v)
>  {
> -	DRM_INFO("xxxx: dce_v6_0_audio_endpt_wreg ----no impl!!!!\n");
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&adev->audio_endpt_idx_lock, flags);
> +	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_INDEX + block_offset,
> +		reg | AZALIA_F0_CODEC_ENDPOINT_INDEX__AZALIA_ENDPOINT_REG_WRITE_EN_M=
ASK);
> +	WREG32(mmAZALIA_F0_CODEC_ENDPOINT_DATA + block_offset, v);
> +	spin_unlock_irqrestore(&adev->audio_endpt_idx_lock, flags);
>  }
> =20
>  static bool dce_v6_0_is_in_vblank(struct amdgpu_device *adev, int crtc=
)
> @@ -1231,17 +1244,17 @@ static void dce_v6_0_bandwidth_update(struct am=
dgpu_device *adev)
>  		dce_v6_0_program_watermarks(adev, adev->mode_info.crtcs[i+1], lb_siz=
e, num_heads);
>  	}
>  }
> -/*
> +
>  static void dce_v6_0_audio_get_connected_pins(struct amdgpu_device *ad=
ev)
>  {
>  	int i;
> -	u32 offset, tmp;
> +	u32 tmp;
> =20
>  	for (i =3D 0; i < adev->mode_info.audio.num_pins; i++) {
> -		offset =3D adev->mode_info.audio.pin[i].offset;
> -		tmp =3D RREG32_AUDIO_ENDPT(offset,
> -				      AZ_F0_CODEC_PIN_CONTROL_RESPONSE_CONFIGURATION_DEFAULT);
> -		if (((tmp & PORT_CONNECTIVITY_MASK) >> PORT_CONNECTIVITY_SHIFT) =3D=3D=
 1)
> +		tmp =3D RREG32_AUDIO_ENDPT(adev->mode_info.audio.pin[i].offset,
> +				ixAZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_CONFIGURATION_DEFAULT);
> +		if (REG_GET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_CONFIGUR=
ATION_DEFAULT,
> +					PORT_CONNECTIVITY))
>  			adev->mode_info.audio.pin[i].connected =3D false;
>  		else
>  			adev->mode_info.audio.pin[i].connected =3D true;
> @@ -1263,45 +1276,206 @@ static struct amdgpu_audio_pin *dce_v6_0_audio=
_get_pin(struct amdgpu_device *ade
>  	return NULL;
>  }
> =20
> -static void dce_v6_0_afmt_audio_select_pin(struct drm_encoder *encoder=
)
> +static void dce_v6_0_audio_select_pin(struct drm_encoder *encoder)
>  {
>  	struct amdgpu_device *adev =3D encoder->dev->dev_private;
>  	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

>  	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> -	u32 offset;
> =20
>  	if (!dig || !dig->afmt || !dig->afmt->pin)
>  		return;
> =20
> -	offset =3D dig->afmt->offset;
> -
> -	WREG32(AFMT_AUDIO_SRC_CONTROL + offset,
> -	       AFMT_AUDIO_SRC_SELECT(dig->afmt->pin->id));
> -
> +	WREG32(mmAFMT_AUDIO_SRC_CONTROL + dig->afmt->offset,
> +	       REG_SET_FIELD(0, AFMT_AUDIO_SRC_CONTROL, AFMT_AUDIO_SRC_SELECT=
,
> +		             dig->afmt->pin->id));
>  }
> =20
>  static void dce_v6_0_audio_write_latency_fields(struct drm_encoder *en=
coder,
>  						struct drm_display_mode *mode)
>  {
> -	DRM_INFO("xxxx: dce_v6_0_audio_write_latency_fields---no imp!!!!!\n")=
;
> +	struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> +	struct drm_connector *connector;
> +	struct amdgpu_connector *amdgpu_connector =3D NULL;
> +	int interlace =3D 0;
> +	u32 tmp;
> +
> +	list_for_each_entry(connector, &encoder->dev->mode_config.connector_l=
ist, head) {
> +		if (connector->encoder =3D=3D encoder) {
> +			amdgpu_connector =3D to_amdgpu_connector(connector);
> +			break;
> +		}
> +	}
> +
> +	if (!amdgpu_connector) {
> +		DRM_ERROR("Couldn't find encoder's connector\n");
> +		return;
> +	}
> +
> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +		interlace =3D 1;
> +
> +	if (connector->latency_present[interlace]) {
> +		tmp =3D REG_SET_FIELD(0, AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_LIPSYN=
C,
> +				VIDEO_LIPSYNC, connector->video_latency[interlace]);
> +		tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_LIPS=
YNC,
> +				AUDIO_LIPSYNC, connector->audio_latency[interlace]);
> +	} else {
> +		tmp =3D REG_SET_FIELD(0, AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_LIPSYN=
C,
> +				VIDEO_LIPSYNC, 0);
> +		tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_LIPS=
YNC,
> +				AUDIO_LIPSYNC, 0);
> +	}
> +	WREG32_AUDIO_ENDPT(dig->afmt->pin->offset,
> +			   ixAZALIA_F0_CODEC_PIN_CONTROL_RESPONSE_LIPSYNC, tmp);
>  }
> =20
>  static void dce_v6_0_audio_write_speaker_allocation(struct drm_encoder=
 *encoder)
>  {
> -	DRM_INFO("xxxx: dce_v6_0_audio_write_speaker_allocation---no imp!!!!!=
\n");
> +	struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> +	struct drm_connector *connector;
> +	struct amdgpu_connector *amdgpu_connector =3D NULL;
> +	u8 *sadb =3D NULL;
> +	int sad_count;
> +	u32 tmp;
> +
> +	list_for_each_entry(connector, &encoder->dev->mode_config.connector_l=
ist, head) {
> +		if (connector->encoder =3D=3D encoder) {
> +			amdgpu_connector =3D to_amdgpu_connector(connector);
> +			break;
> +		}
> +	}
> +
> +	if (!amdgpu_connector) {
> +		DRM_ERROR("Couldn't find encoder's connector\n");
> +		return;
> +	}
> +
> +	sad_count =3D drm_edid_to_speaker_allocation(amdgpu_connector_edid(co=
nnector), &sadb);
> +	if (sad_count < 0) {
> +		DRM_ERROR("Couldn't read Speaker Allocation Data Block: %d\n", sad_c=
ount);
> +		sad_count =3D 0;
> +	}
> +
> +	/* program the speaker allocation */
> +	tmp =3D RREG32_AUDIO_ENDPT(dig->afmt->pin->offset,
> +			ixAZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER);
> +	tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKE=
R,
> +			HDMI_CONNECTION, 0);
> +	tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKE=
R,
> +			DP_CONNECTION, 0);
> +
> +	if (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort)
> +		tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAK=
ER,
> +				DP_CONNECTION, 1);
> +	else
> +		tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAK=
ER,
> +				HDMI_CONNECTION, 1);
> +
> +	if (sad_count)
> +		tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAK=
ER,
> +				SPEAKER_ALLOCATION, sadb[0]);
> +	else
> +		tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAK=
ER,
> +				SPEAKER_ALLOCATION, 5); /* stereo */
> +
> +	WREG32_AUDIO_ENDPT(dig->afmt->pin->offset,
> +			ixAZALIA_F0_CODEC_PIN_CONTROL_CHANNEL_SPEAKER, tmp);
> +
> +	kfree(sadb);
>  }
> =20
>  static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)=

>  {
> -	DRM_INFO("xxxx: dce_v6_0_audio_write_sad_regs---no imp!!!!!\n");
> +	struct amdgpu_device *adev =3D encoder->dev->dev_private;
> +	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> +	struct drm_connector *connector;
> +	struct amdgpu_connector *amdgpu_connector =3D NULL;
> +	struct cea_sad *sads;
> +	int i, sad_count;
> +
> +	static const u16 eld_reg_to_type[][2] =3D {
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0, HDMI_AUDIO_CODING=
_TYPE_PCM },
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR1, HDMI_AUDIO_CODING=
_TYPE_AC3 },
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR2, HDMI_AUDIO_CODING=
_TYPE_MPEG1 },
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR3, HDMI_AUDIO_CODING=
_TYPE_MP3 },
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR4, HDMI_AUDIO_CODING=
_TYPE_MPEG2 },
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR5, HDMI_AUDIO_CODING=
_TYPE_AAC_LC },
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR6, HDMI_AUDIO_CODING=
_TYPE_DTS },
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR7, HDMI_AUDIO_CODING=
_TYPE_ATRAC },
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR9, HDMI_AUDIO_CODING=
_TYPE_EAC3 },
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR10, HDMI_AUDIO_CODIN=
G_TYPE_DTS_HD },
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR11, HDMI_AUDIO_CODIN=
G_TYPE_MLP },
> +		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR13, HDMI_AUDIO_CODIN=
G_TYPE_WMA_PRO },
> +	};
> +
> +	list_for_each_entry(connector, &encoder->dev->mode_config.connector_l=
ist, head) {
> +		if (connector->encoder =3D=3D encoder) {
> +			amdgpu_connector =3D to_amdgpu_connector(connector);
> +			break;
> +		}
> +	}
> +
> +	if (!amdgpu_connector) {
> +		DRM_ERROR("Couldn't find encoder's connector\n");
> +		return;
> +	}
> +
> +	sad_count =3D drm_edid_to_sad(amdgpu_connector_edid(connector), &sads=
);
> +	if (sad_count <=3D 0) {
> +		DRM_ERROR("Couldn't read SADs: %d\n", sad_count);
> +		return;
> +	}
> +
> +	for (i =3D 0; i < ARRAY_SIZE(eld_reg_to_type); i++) {
> +		u32 tmp =3D 0;
> +		u8 stereo_freqs =3D 0;
> +		int max_channels =3D -1;
> +		int j;
> +
> +		for (j =3D 0; j < sad_count; j++) {
> +			struct cea_sad *sad =3D &sads[j];
> +
> +			if (sad->format =3D=3D eld_reg_to_type[i][1]) {
> +				if (sad->channels > max_channels) {
> +					tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESC=
RIPTOR0,
> +							MAX_CHANNELS, sad->channels);
> +					tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESC=
RIPTOR0,
> +							DESCRIPTOR_BYTE_2, sad->byte2);
> +					tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESC=
RIPTOR0,
> +							SUPPORTED_FREQUENCIES, sad->freq);
> +					max_channels =3D sad->channels;
> +				}
> +
> +				if (sad->format =3D=3D HDMI_AUDIO_CODING_TYPE_PCM)
> +					stereo_freqs |=3D sad->freq;
> +				else
> +					break;
> +			}
> +		}
> +
> +		tmp =3D REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIP=
TOR0,
> +				SUPPORTED_FREQUENCIES_STEREO, stereo_freqs);
> +		WREG32_AUDIO_ENDPT(dig->afmt->pin->offset, eld_reg_to_type[i][0], tm=
p);
> +	}
> +
> +	kfree(sads);
> =20
>  }
> -*/
> +
>  static void dce_v6_0_audio_enable(struct amdgpu_device *adev,
>  				  struct amdgpu_audio_pin *pin,
>  				  bool enable)
>  {
> -	DRM_INFO("xxxx: dce_v6_0_audio_enable---no imp!!!!!\n");
> +	if (!pin)
> +		return;
> +
> +	WREG32_AUDIO_ENDPT(pin->offset, ixAZALIA_F0_CODEC_PIN_CONTROL_HOT_PLU=
G_CONTROL,
> +			enable ? AZALIA_F0_CODEC_PIN_CONTROL_HOT_PLUG_CONTROL__AUDIO_ENABLE=
D_MASK : 0);
>  }
> =20
>  static const u32 pin_offsets[7] =3D
> @@ -1317,12 +1491,54 @@ static const u32 pin_offsets[7] =3D
> =20
>  static int dce_v6_0_audio_init(struct amdgpu_device *adev)
>  {
> +	int i;
> +
> +	if (!amdgpu_audio)
> +		return 0;
> +
> +	adev->mode_info.audio.enabled =3D true;
> +
> +	switch (adev->asic_type) {
> +	case CHIP_TAHITI:
> +	case CHIP_PITCAIRN:
> +	case CHIP_VERDE:
> +	default:
> +		adev->mode_info.audio.num_pins =3D 6;
> +		break;
> +	case CHIP_OLAND:
> +		adev->mode_info.audio.num_pins =3D 2;
> +		break;
> +	}
> +
> +	for (i =3D 0; i < adev->mode_info.audio.num_pins; i++) {
> +		adev->mode_info.audio.pin[i].channels =3D -1;
> +		adev->mode_info.audio.pin[i].rate =3D -1;
> +		adev->mode_info.audio.pin[i].bits_per_sample =3D -1;
> +		adev->mode_info.audio.pin[i].status_bits =3D 0;
> +		adev->mode_info.audio.pin[i].category_code =3D 0;
> +		adev->mode_info.audio.pin[i].connected =3D false;
> +		adev->mode_info.audio.pin[i].offset =3D pin_offsets[i];
> +		adev->mode_info.audio.pin[i].id =3D i;
> +		dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
> +	}
> +
>  	return 0;
>  }
> =20
>  static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
>  {
> +	int i;
> =20
> +	if (!amdgpu_audio)
> +		return;
> +
> +	if (!adev->mode_info.audio.enabled)
> +		return;
> +
> +	for (i =3D 0; i < adev->mode_info.audio.num_pins; i++)
> +		dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
> +
> +	adev->mode_info.audio.enabled =3D false;
>  }
> =20
>  /*
> @@ -1331,28 +1547,204 @@ static void dce_v6_0_afmt_update_ACR(struct dr=
m_encoder *encoder, uint32_t clock
>  	DRM_INFO("xxxx: dce_v6_0_afmt_update_ACR---no imp!!!!!\n");
>  }
>  */
> -/*
> - * build a HDMI Video Info Frame
> - */
> -/*
> -static void dce_v6_0_afmt_update_avi_infoframe(struct drm_encoder *enc=
oder,
> -					       void *buffer, size_t size)
> +
> +static void dce_v6_0_audio_set_avi_infoframe(struct drm_encoder *encod=
er,
> +					       struct drm_display_mode *mode)
>  {
> -	DRM_INFO("xxxx: dce_v6_0_afmt_update_avi_infoframe---no imp!!!!!\n");=

> +	struct drm_device *dev =3D encoder->dev;
> +	struct amdgpu_device *adev =3D dev->dev_private;
> +	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> +	struct hdmi_avi_infoframe frame;
> +	u8 buffer[HDMI_INFOFRAME_HEADER_SIZE + HDMI_AVI_INFOFRAME_SIZE];
> +	uint8_t *payload =3D buffer + 3;
> +	uint8_t *header =3D buffer;
> +	ssize_t err;
> +	u32 tmp;
> +
> +	err =3D drm_hdmi_avi_infoframe_from_display_mode(&frame, mode);
> +	if (err < 0) {
> +		DRM_ERROR("failed to setup AVI infoframe: %zd\n", err);
> +		return;
> +	}
> +
> +	err =3D hdmi_avi_infoframe_pack(&frame, buffer, sizeof(buffer));
> +	if (err < 0) {
> +		DRM_ERROR("failed to pack AVI infoframe: %zd\n", err);
> +		return;
> +	}
> +
> +	WREG32(mmAFMT_AVI_INFO0 + dig->afmt->offset,
> +	       payload[0x0] | (payload[0x1] << 8) | (payload[0x2] << 16) | (p=
ayload[0x3] << 24));
> +	WREG32(mmAFMT_AVI_INFO1 + dig->afmt->offset,
> +	       payload[0x4] | (payload[0x5] << 8) | (payload[0x6] << 16) | (p=
ayload[0x7] << 24));
> +	WREG32(mmAFMT_AVI_INFO2 + dig->afmt->offset,
> +	       payload[0x8] | (payload[0x9] << 8) | (payload[0xA] << 16) | (p=
ayload[0xB] << 24));
> +	WREG32(mmAFMT_AVI_INFO3 + dig->afmt->offset,
> +	       payload[0xC] | (payload[0xD] << 8) | (header[1] << 24));
> +
> +	tmp =3D RREG32(mmHDMI_INFOFRAME_CONTROL1 + dig->afmt->offset);
> +	/* anything other than 0 */
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL1,
> +			HDMI_AUDIO_INFO_LINE, 2);
> +	WREG32(mmHDMI_INFOFRAME_CONTROL1 + dig->afmt->offset, tmp);
>  }
> =20
>  static void dce_v6_0_audio_set_dto(struct drm_encoder *encoder, u32 cl=
ock)
>  {
> -	DRM_INFO("xxxx: dce_v6_0_audio_set_dto---no imp!!!!!\n");
> +	struct drm_device *dev =3D encoder->dev;
> +	struct amdgpu_device *adev =3D dev->dev_private;
> +	struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(encoder->crtc);
> +	u32 tmp;
> +
> +	/*
> +	 * Two dtos: generally use dto0 for hdmi, dto1 for dp.
> +	 * Express [24MHz / target pixel clock] as an exact rational
> +	 * number (coefficient of two integer numbers.  DCCG_AUDIO_DTOx_PHASE=

> +	 * is the numerator, DCCG_AUDIO_DTOx_MODULE is the denominator
> +	 */
> +	tmp =3D RREG32(mmDCCG_AUDIO_DTO_SOURCE);
> +	tmp =3D REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE,
> +			DCCG_AUDIO_DTO0_SOURCE_SEL, amdgpu_crtc->crtc_id);
> +	tmp =3D REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL,=
 1);
> +	WREG32(mmDCCG_AUDIO_DTO_SOURCE, tmp);
> +	WREG32(mmDCCG_AUDIO_DTO1_PHASE, 24000);
> +	WREG32(mmDCCG_AUDIO_DTO1_MODULE, clock);
>  }
> -*/
> -/*
> - * update the info frames with the data from the current display mode
> - */
> +
> +static void dce_v6_0_audio_set_packet(struct drm_encoder *encoder)
> +{
> +	struct drm_device *dev =3D encoder->dev;
> +	struct amdgpu_device *adev =3D dev->dev_private;
> +	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> +	u32 tmp;
> +
> +	tmp =3D RREG32(mmAFMT_INFOFRAME_CONTROL0 + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_INFOFRAME_CONTROL0, AFMT_AUDIO_INFO_U=
PDATE, 1);
> +	WREG32(mmAFMT_INFOFRAME_CONTROL0 + dig->afmt->offset, tmp);
> +
> +	tmp =3D RREG32(mmAFMT_60958_0 + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_0, AFMT_60958_CS_CHANNEL_NUMBER=
_L, 1);
> +	WREG32(mmAFMT_60958_0 + dig->afmt->offset, tmp);
> +
> +	tmp =3D RREG32(mmAFMT_60958_1 + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_1, AFMT_60958_CS_CHANNEL_NUMBER=
_R, 2);
> +	WREG32(mmAFMT_60958_1 + dig->afmt->offset, tmp);
> +
> +	tmp =3D RREG32(mmAFMT_60958_2 + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2, AFMT_60958_CS_CHANNEL_NUMBER=
_2, 3);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2, AFMT_60958_CS_CHANNEL_NUMBER=
_3, 4);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2, AFMT_60958_CS_CHANNEL_NUMBER=
_4, 5);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2, AFMT_60958_CS_CHANNEL_NUMBER=
_5, 6);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2, AFMT_60958_CS_CHANNEL_NUMBER=
_6, 7);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_60958_2, AFMT_60958_CS_CHANNEL_NUMBER=
_7, 8);
> +	WREG32(mmAFMT_60958_2 + dig->afmt->offset, tmp);
> +
> +	tmp =3D RREG32(mmAFMT_AUDIO_PACKET_CONTROL2 + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL2, AFMT_AUDIO_CHA=
NNEL_ENABLE, 0xff);
> +	WREG32(mmAFMT_AUDIO_PACKET_CONTROL2 + dig->afmt->offset, tmp);
> +
> +	tmp =3D RREG32(mmHDMI_AUDIO_PACKET_CONTROL + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_AUDIO_PACKET_CONTROL, HDMI_AUDIO_DELA=
Y_EN, 1);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_AUDIO_PACKET_CONTROL, HDMI_AUDIO_PACK=
ETS_PER_LINE, 3);
> +	WREG32(mmHDMI_AUDIO_PACKET_CONTROL + dig->afmt->offset, tmp);
> +
> +	tmp =3D RREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL, AFMT_RESET_FIFO=
_WHEN_AUDIO_DIS, 1);
> +	tmp =3D REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL, AFMT_60958_CS_U=
PDATE, 1);
> +	WREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset, tmp);
> +}
> +
> +static void dce_v6_0_audio_set_mute(struct drm_encoder *encoder, bool =
mute)
> +{
> +	struct drm_device *dev =3D encoder->dev;
> +	struct amdgpu_device *adev =3D dev->dev_private;
> +	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> +	u32 tmp;
> +
> +	tmp =3D RREG32(mmHDMI_GC + dig->afmt->offset);
> +	tmp =3D REG_SET_FIELD(tmp, HDMI_GC, HDMI_GC_AVMUTE, mute ? 1 : 0);
> +	WREG32(mmHDMI_GC + dig->afmt->offset, tmp);
> +}
> +
> +static void dce_v6_0_audio_dp_enable(struct drm_encoder *encoder, bool=
 enable)
> +{
> +	struct drm_device *dev =3D encoder->dev;
> +	struct amdgpu_device *adev =3D dev->dev_private;
> +	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> +	u32 tmp;
> +
> +	if (enable) {
> +		tmp =3D RREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset);
> +		tmp =3D REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL, AFMT_AUDIO_SAM=
PLE_SEND, 1);
> +		WREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset, tmp);
> +
> +		tmp =3D RREG32(mmDP_SEC_TIMESTAMP + dig->afmt->offset);
> +		tmp =3D REG_SET_FIELD(tmp, DP_SEC_TIMESTAMP, DP_SEC_TIMESTAMP_MODE, =
1);
> +		WREG32(mmDP_SEC_TIMESTAMP + dig->afmt->offset, tmp);
> +
> +		tmp =3D RREG32(mmDP_SEC_CNTL + dig->afmt->offset);
> +		tmp =3D REG_SET_FIELD(tmp, DP_SEC_CNTL, DP_SEC_ASP_ENABLE, 1);
> +		tmp =3D REG_SET_FIELD(tmp, DP_SEC_CNTL, DP_SEC_ATP_ENABLE, 1);
> +		tmp =3D REG_SET_FIELD(tmp, DP_SEC_CNTL, DP_SEC_AIP_ENABLE, 1);
> +		tmp =3D REG_SET_FIELD(tmp, DP_SEC_CNTL, DP_SEC_STREAM_ENABLE, 1);
> +		WREG32(mmDP_SEC_CNTL + dig->afmt->offset, tmp);
> +	} else {
> +		WREG32(mmDP_SEC_CNTL + dig->afmt->offset, 0);
> +	}
> +}
> +
>  static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
>  				  struct drm_display_mode *mode)
>  {
> -	DRM_INFO("xxxx: dce_v6_0_afmt_setmode ----no impl !!!!!!!!\n");
> +	struct drm_device *dev =3D encoder->dev;
> +	struct amdgpu_device *adev =3D dev->dev_private;
> +	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	struct amdgpu_encoder_atom_dig *dig =3D amdgpu_encoder->enc_priv;
> +	struct drm_connector *connector;
> +	struct amdgpu_connector *amdgpu_connector =3D NULL;
> +
> +	if (!dig || !dig->afmt)
> +		return;
> +
> +	list_for_each_entry(connector, &encoder->dev->mode_config.connector_l=
ist, head) {
> +		if (connector->encoder =3D=3D encoder) {
> +			amdgpu_connector =3D to_amdgpu_connector(connector);
> +			break;
> +		}
> +	}
> +
> +	if (!amdgpu_connector) {
> +		DRM_ERROR("Couldn't find encoder's connector\n");
> +		return;
> +	}
> +
> +	if (!dig->afmt->enabled)
> +		return;
> +
> +	dig->afmt->pin =3D dce_v6_0_audio_get_pin(adev);
> +	if (!dig->afmt->pin)
> +		return;
> +
> +	/* disable audio before setting up hw */
> +	dce_v6_0_audio_enable(adev, dig->afmt->pin, false);
> +
> +	dce_v6_0_audio_set_mute(encoder, true);
> +	dce_v6_0_audio_write_speaker_allocation(encoder);
> +	dce_v6_0_audio_write_sad_regs(encoder);
> +	dce_v6_0_audio_write_latency_fields(encoder, mode);
> +	dce_v6_0_audio_set_dto(encoder, adev->clock.default_dispclk * 10);
> +	dce_v6_0_audio_set_packet(encoder);
> +	dce_v6_0_audio_select_pin(encoder);
> +	dce_v6_0_audio_set_avi_infoframe(encoder, mode);
> +	dce_v6_0_audio_set_mute(encoder, false);
> +	dce_v6_0_audio_dp_enable(encoder, 1);
> +
> +	/* enable audio after setting up hw */
> +	dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
>  }
> =20
>  static void dce_v6_0_afmt_enable(struct drm_encoder *encoder, bool ena=
ble)
> @@ -1368,6 +1760,7 @@ static void dce_v6_0_afmt_enable(struct drm_encod=
er *encoder, bool enable)
>  	/* Silent, r600_hdmi_enable will raise WARN for us */
>  	if (enable && dig->afmt->enabled)
>  		return;
> +
>  	if (!enable && !dig->afmt->enabled)
>  		return;
> =20
> @@ -2781,6 +3174,7 @@ dce_v6_0_encoder_mode_set(struct drm_encoder *enc=
oder,
>  {
> =20
>  	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

> +	int em =3D amdgpu_atombios_encoder_get_encoder_mode(encoder);
> =20
>  	amdgpu_encoder->pixel_clock =3D adjusted_mode->clock;
> =20
> @@ -2790,7 +3184,7 @@ dce_v6_0_encoder_mode_set(struct drm_encoder *enc=
oder,
>  	/* set scaler clears this on some chips */
>  	dce_v6_0_set_interleave(encoder->crtc, mode);
> =20
> -	if (amdgpu_atombios_encoder_get_encoder_mode(encoder) =3D=3D ATOM_ENC=
ODER_MODE_HDMI) {
> +	if (em =3D=3D ATOM_ENCODER_MODE_HDMI || ENCODER_MODE_IS_DP(em)) {
>  		dce_v6_0_afmt_enable(encoder, true);
>  		dce_v6_0_afmt_setmode(encoder, adjusted_mode);
>  	}
> @@ -2852,11 +3246,12 @@ static void dce_v6_0_encoder_disable(struct drm=
_encoder *encoder)
> =20
>  	struct amdgpu_encoder *amdgpu_encoder =3D to_amdgpu_encoder(encoder);=

>  	struct amdgpu_encoder_atom_dig *dig;
> +	int em =3D amdgpu_atombios_encoder_get_encoder_mode(encoder);
> =20
>  	amdgpu_atombios_encoder_dpms(encoder, DRM_MODE_DPMS_OFF);
> =20
>  	if (amdgpu_atombios_encoder_is_digital(encoder)) {
> -		if (amdgpu_atombios_encoder_get_encoder_mode(encoder) =3D=3D ATOM_EN=
CODER_MODE_HDMI)
> +		if (em =3D=3D ATOM_ENCODER_MODE_HDMI || ENCODER_MODE_IS_DP(em))
>  			dce_v6_0_afmt_enable(encoder, false);
>  		dig =3D amdgpu_encoder->enc_priv;
>  		dig->dig_encoder =3D -1;
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h=
 b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
> index 9a4d4c2..abe05bc 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
> @@ -906,6 +906,8 @@
>  #define AZALIA_F0_CODEC_ENDPOINT_DATA__AZALIA_ENDPOINT_REG_DATA__SHIFT=
 0x00000000
>  #define AZALIA_F0_CODEC_ENDPOINT_INDEX__AZALIA_ENDPOINT_REG_INDEX_MASK=
 0x000000ffL
>  #define AZALIA_F0_CODEC_ENDPOINT_INDEX__AZALIA_ENDPOINT_REG_INDEX__SHI=
FT 0x00000000
> +#define AZALIA_F0_CODEC_ENDPOINT_INDEX__AZALIA_ENDPOINT_REG_WRITE_EN_M=
ASK 0x00000100L
> +#define AZALIA_F0_CODEC_ENDPOINT_INDEX__AZALIA_ENDPOINT_REG_WRITE_EN__=
SHIFT 0x00000008
>  #define AZALIA_F0_CODEC_FUNCTION_CONTROL_CONVERTER_SYNCHRONIZATION__CO=
NVERTER_SYNCHRONIZATION_MASK 0x0000003fL
>  #define AZALIA_F0_CODEC_FUNCTION_CONTROL_CONVERTER_SYNCHRONIZATION__CO=
NVERTER_SYNCHRONIZATION__SHIFT 0x00000000
>  #define AZALIA_F0_CODEC_FUNCTION_CONTROL_POWER_STATE__CLKSTOPOK_MASK 0=
x00000200L
>=20


--qGuQTinwKmfKaheVKLP8P9vpgVqxtAgb2--

--fMssQ2OaujtTFVKQSb5fSKMXUuPVAXUDl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrRYoAAoJEP4bvbfZuWjbvl4QAKnRBjw/3NRI+OG1bdu0ukkF
lUxOoUJTm7fsE2K0P8GmW3WcGITnQChvJJKKbPdPcfNYxViapcDooVDJ5TwVb/HA
DEEU9YshLpi5DKx+gCCcFpZEPEnooqkZEDwtMAIkXzTAwGZvrLaqez8vVUjGuuS0
p+F1A3PFooQhNy0CcLfMrp5QibREM/li1SxXHIBatW4R+bs+GiYqOwjutDaNHzNN
0SFPdRyDNwRYp2/u3PhHM8Xlt/NCANjBYm9+GYYZFSNeH7Za/TZbFvQRXgC3zksk
1hN2YQvWW0HiYOzs9TOOxgPx56XMrEDHlZT5eaoKmsYaOWqIriBsv9CekOVrovdm
2+M+qFurjI0d/CKjHhKMnU/8LYb5RYzgn8DVpP6jJKwXaGOgvqQZdlpWgIO3oGNP
MivZLrdzAy+qbJViqFNAuESBls/EOP0GJnC3/p2k6Q5jnIeHJ0Z0guV9bNUzcRRf
f7r0QW5i3sUrg2d7mYsBSDFeHEb1D7z8DnXDvfS9mnIrgeLlLmVyAKsMJyzDGy6E
zg7qdUYmER8KOeAKdkr+ViE0H1LV5PhlBONL4mPJGrc+IlArTbrcSzab3qYwLTh4
S/xpPSmUNy2knuqh9qEPGXqJaiSkzv54QZKK0xMlw9M8EJpMZ4dhcOXWaJZjHCRu
6aQLM+PSJ9ZLx6b0Mo25
=GrOH
-----END PGP SIGNATURE-----

--fMssQ2OaujtTFVKQSb5fSKMXUuPVAXUDl--

--===============0652012425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0652012425==--
