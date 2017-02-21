From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add HDMI audio support for si dce6
Date: Tue, 21 Feb 2017 13:16:39 +0100
Message-ID: <1e362d8c-d028-b787-8c2d-d952eaf741ef@vodafone.de>
References: <1487673594-1452-1-git-send-email-Xiaojie.Yuan@amd.com>
 <d2ba0088-cac6-7674-a6e7-d00d7f69b68c@folklore1984.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0772693906=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <d2ba0088-cac6-7674-a6e7-d00d7f69b68c-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
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
To: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--===============0772693906==
Content-Type: multipart/alternative;
 boundary="------------48A5BB894C1FCB7BECFCA132"

This is a multi-part message in MIME format.
--------------48A5BB894C1FCB7BECFCA132
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Not much of an issue, but when sending out a second version of a patch 
we usually put a v2 on the subject line to indicate that.

Additional to that the patch also needs at least a little bit of commit 
message.

With that fixed it is Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

Regards,
Christian.

Am 21.02.2017 um 13:08 schrieb Edward O'Callaghan:
> Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
>
> On 02/21/2017 09:39 PM, Xiaojie Yuan wrote:
>> Signed-off-by: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 130 +++++++++++++++++++++++++++++++---
>>   1 file changed, 121 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> index c940bec..1398db6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
>> @@ -1531,12 +1531,58 @@ static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
>>   	adev->mode_info.audio.enabled = false;
>>   }
>>   
>> -/*
>> -static void dce_v6_0_afmt_update_ACR(struct drm_encoder *encoder, uint32_t clock)
>> +static void dce_v6_0_audio_set_vbi_packet(struct drm_encoder *encoder)
>>   {
>> -	DRM_INFO("xxxx: dce_v6_0_afmt_update_ACR---no imp!!!!!\n");
>> +	struct drm_device *dev = encoder->dev;
>> +	struct amdgpu_device *adev = dev->dev_private;
>> +	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
>> +	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
>> +	u32 tmp;
>> +
>> +	tmp = RREG32(mmHDMI_VBI_PACKET_CONTROL + dig->afmt->offset);
>> +	tmp = REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL, HDMI_NULL_SEND, 1);
>> +	tmp = REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL, HDMI_GC_SEND, 1);
>> +	tmp = REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL, HDMI_GC_CONT, 1);
>> +	WREG32(mmHDMI_VBI_PACKET_CONTROL + dig->afmt->offset, tmp);
>> +}
>> +
>> +static void dce_v6_0_audio_set_acr(struct drm_encoder *encoder,
>> +				   uint32_t clock, int bpc)
>> +{
>> +	struct drm_device *dev = encoder->dev;
>> +	struct amdgpu_device *adev = dev->dev_private;
>> +	struct amdgpu_afmt_acr acr = amdgpu_afmt_acr(clock);
>> +	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
>> +	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
>> +	u32 tmp;
>> +
>> +	tmp = RREG32(mmHDMI_ACR_PACKET_CONTROL + dig->afmt->offset);
>> +	tmp = REG_SET_FIELD(tmp, HDMI_ACR_PACKET_CONTROL, HDMI_ACR_AUTO_SEND, 1);
>> +	tmp = REG_SET_FIELD(tmp, HDMI_ACR_PACKET_CONTROL, HDMI_ACR_SOURCE,
>> +			bpc > 8 ? 0 : 1);
>> +	WREG32(mmHDMI_ACR_PACKET_CONTROL + dig->afmt->offset, tmp);
>> +
>> +	tmp = RREG32(mmHDMI_ACR_32_0 + dig->afmt->offset);
>> +	tmp = REG_SET_FIELD(tmp, HDMI_ACR_32_0, HDMI_ACR_CTS_32, acr.cts_32khz);
>> +	WREG32(mmHDMI_ACR_32_0 + dig->afmt->offset, tmp);
>> +	tmp = RREG32(mmHDMI_ACR_32_1 + dig->afmt->offset);
>> +	tmp = REG_SET_FIELD(tmp, HDMI_ACR_32_1, HDMI_ACR_N_32, acr.n_32khz);
>> +	WREG32(mmHDMI_ACR_32_1 + dig->afmt->offset, tmp);
>> +
>> +	tmp = RREG32(mmHDMI_ACR_44_0 + dig->afmt->offset);
>> +	tmp = REG_SET_FIELD(tmp, HDMI_ACR_44_0, HDMI_ACR_CTS_44, acr.cts_44_1khz);
>> +	WREG32(mmHDMI_ACR_44_0 + dig->afmt->offset, tmp);
>> +	tmp = RREG32(mmHDMI_ACR_44_1 + dig->afmt->offset);
>> +	tmp = REG_SET_FIELD(tmp, HDMI_ACR_44_1, HDMI_ACR_N_44, acr.n_44_1khz);
>> +	WREG32(mmHDMI_ACR_44_1 + dig->afmt->offset, tmp);
>> +
>> +	tmp = RREG32(mmHDMI_ACR_48_0 + dig->afmt->offset);
>> +	tmp = REG_SET_FIELD(tmp, HDMI_ACR_48_0, HDMI_ACR_CTS_48, acr.cts_48khz);
>> +	WREG32(mmHDMI_ACR_48_0 + dig->afmt->offset, tmp);
>> +	tmp = RREG32(mmHDMI_ACR_48_1 + dig->afmt->offset);
>> +	tmp = REG_SET_FIELD(tmp, HDMI_ACR_48_1, HDMI_ACR_N_48, acr.n_48khz);
>> +	WREG32(mmHDMI_ACR_48_1 + dig->afmt->offset, tmp);
>>   }
>> -*/
>>   
>>   static void dce_v6_0_afmt_update_avi_infoframe(struct drm_encoder *encoder,
>>   					       struct drm_display_mode *mode)
>> @@ -1585,6 +1631,7 @@ static void dce_v6_0_audio_set_dto(struct drm_encoder *encoder, u32 clock)
>>   	struct drm_device *dev = encoder->dev;
>>   	struct amdgpu_device *adev = dev->dev_private;
>>   	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder->crtc);
>> +	int em = amdgpu_atombios_encoder_get_encoder_mode(encoder);
>>   	u32 tmp;
>>   
>>   	/*
>> @@ -1596,10 +1643,21 @@ static void dce_v6_0_audio_set_dto(struct drm_encoder *encoder, u32 clock)
>>   	tmp = RREG32(mmDCCG_AUDIO_DTO_SOURCE);
>>   	tmp = REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE,
>>   			DCCG_AUDIO_DTO0_SOURCE_SEL, amdgpu_crtc->crtc_id);
>> -	tmp = REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, 1);
>> +	if (em == ATOM_ENCODER_MODE_HDMI) {
>> +		tmp = REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE,
>> +				DCCG_AUDIO_DTO_SEL, 0);
>> +	} else if (ENCODER_MODE_IS_DP(em)) {
>> +		tmp = REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE,
>> +				DCCG_AUDIO_DTO_SEL, 1);
>> +	}
>>   	WREG32(mmDCCG_AUDIO_DTO_SOURCE, tmp);
>> -	WREG32(mmDCCG_AUDIO_DTO1_PHASE, 24000);
>> -	WREG32(mmDCCG_AUDIO_DTO1_MODULE, clock);
>> +	if (em == ATOM_ENCODER_MODE_HDMI) {
>> +		WREG32(mmDCCG_AUDIO_DTO0_PHASE, 24000);
>> +		WREG32(mmDCCG_AUDIO_DTO0_MODULE, clock);
>> +	} else if (ENCODER_MODE_IS_DP(em)) {
>> +		WREG32(mmDCCG_AUDIO_DTO1_PHASE, 24000);
>> +		WREG32(mmDCCG_AUDIO_DTO1_MODULE, clock);
>> +	}
>>   }
>>   
>>   static void dce_v6_0_set_audio_packet(struct drm_encoder *encoder)
>> @@ -1659,6 +1717,43 @@ static void dce_v6_0_audio_set_mute(struct drm_encoder *encoder, bool mute)
>>   	WREG32(mmHDMI_GC + dig->afmt->offset, tmp);
>>   }
>>   
>> +static void dce_v6_0_audio_hdmi_enable(struct drm_encoder *encoder, bool enable)
>> +{
>> +	struct drm_device *dev = encoder->dev;
>> +	struct amdgpu_device *adev = dev->dev_private;
>> +	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
>> +	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
>> +	u32 tmp;
>> +
>> +	if (enable) {
>> +		tmp = RREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset);
>> +		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_SEND, 1);
>> +		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_CONT, 1);
>> +		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, 1);
>> +		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_CONT, 1);
>> +		WREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset, tmp);
>> +
>> +		tmp = RREG32(mmHDMI_INFOFRAME_CONTROL1 + dig->afmt->offset);
>> +		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL1, HDMI_AVI_INFO_LINE, 2);
>> +		WREG32(mmHDMI_INFOFRAME_CONTROL1 + dig->afmt->offset, tmp);
>> +
>> +		tmp = RREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset);
>> +		tmp = REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL, AFMT_AUDIO_SAMPLE_SEND, 1);
>> +		WREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset, tmp);
>> +	} else {
>> +		tmp = RREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset);
>> +		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_SEND, 0);
>> +		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_CONT, 0);
>> +		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, 0);
>> +		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_CONT, 0);
>> +		WREG32(mmHDMI_INFOFRAME_CONTROL0 + dig->afmt->offset, tmp);
>> +
>> +		tmp = RREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset);
>> +		tmp = REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL, AFMT_AUDIO_SAMPLE_SEND, 0);
>> +		WREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig->afmt->offset, tmp);
>> +	}
>> +}
>> +
>>   static void dce_v6_0_audio_dp_enable(struct drm_encoder *encoder, bool enable)
>>   {
>>   	struct drm_device *dev = encoder->dev;
>> @@ -1696,6 +1791,8 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
>>   	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
>>   	struct drm_connector *connector;
>>   	struct amdgpu_connector *amdgpu_connector = NULL;
>> +	int em = amdgpu_atombios_encoder_get_encoder_mode(encoder);
>> +	int bpc = 8;
>>   
>>   	if (!dig || !dig->afmt)
>>   		return;
>> @@ -1719,6 +1816,11 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
>>   	if (!dig->afmt->pin)
>>   		return;
>>   
>> +	if (encoder->crtc) {
>> +		struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder->crtc);
>> +		bpc = amdgpu_crtc->bpc;
>> +	}
>> +
>>   	/* disable audio before setting up hw */
>>   	dce_v6_0_audio_enable(adev, dig->afmt->pin, false);
>>   
>> @@ -1726,12 +1828,22 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
>>   	dce_v6_0_audio_write_speaker_allocation(encoder);
>>   	dce_v6_0_audio_write_sad_regs(encoder);
>>   	dce_v6_0_audio_write_latency_fields(encoder, mode);
>> -	dce_v6_0_audio_set_dto(encoder, adev->clock.default_dispclk * 10);
>> +	if (em == ATOM_ENCODER_MODE_HDMI) {
>> +		dce_v6_0_audio_set_dto(encoder, mode->clock);
>> +		dce_v6_0_audio_set_vbi_packet(encoder);
>> +		dce_v6_0_audio_set_acr(encoder, mode->clock, bpc);
>> +	} else if (ENCODER_MODE_IS_DP(em)) {
>> +		dce_v6_0_audio_set_dto(encoder, adev->clock.default_dispclk * 10);
>> +	}
>>   	dce_v6_0_set_audio_packet(encoder);
>>   	dce_v6_0_afmt_audio_select_pin(encoder);
>>   	dce_v6_0_afmt_update_avi_infoframe(encoder, mode);
>>   	dce_v6_0_audio_set_mute(encoder, false);
>> -	dce_v6_0_audio_dp_enable(encoder, 1);
>> +	if (em == ATOM_ENCODER_MODE_HDMI) {
>> +		dce_v6_0_audio_hdmi_enable(encoder, 1);
>> +	} else if (ENCODER_MODE_IS_DP(em)) {
>> +		dce_v6_0_audio_dp_enable(encoder, 1);
>> +	}
>>   
>>   	/* enable audio after setting up hw */
>>   	dce_v6_0_audio_enable(adev, dig->afmt->pin, true);
>>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------48A5BB894C1FCB7BECFCA132
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Not much of an issue, but when sending
      out a second version of a patch we usually put a v2 on the subject
      line to indicate that.<br>
      <br>
      Additional to that the patch also needs at least a little bit of
      commit message.<br>
      <br>
      With that fixed it is Acked-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 21.02.2017 um 13:08 schrieb Edward O'Callaghan:<br>
    </div>
    <blockquote
      cite="mid:d2ba0088-cac6-7674-a6e7-d00d7f69b68c-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org"
      type="cite">
      <pre wrap="">Reviewed-by: Edward O'Callaghan <a class="moz-txt-link-rfc2396E" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;</a>

On 02/21/2017 09:39 PM, Xiaojie Yuan wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">Signed-off-by: Xiaojie Yuan <a class="moz-txt-link-rfc2396E" href="mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org">&lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 130 +++++++++++++++++++++++++++++++---
 1 file changed, 121 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index c940bec..1398db6 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -1531,12 +1531,58 @@ static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
 	adev-&gt;mode_info.audio.enabled = false;
 }
 
-/*
-static void dce_v6_0_afmt_update_ACR(struct drm_encoder *encoder, uint32_t clock)
+static void dce_v6_0_audio_set_vbi_packet(struct drm_encoder *encoder)
 {
-	DRM_INFO("xxxx: dce_v6_0_afmt_update_ACR---no imp!!!!!\n");
+	struct drm_device *dev = encoder-&gt;dev;
+	struct amdgpu_device *adev = dev-&gt;dev_private;
+	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
+	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder-&gt;enc_priv;
+	u32 tmp;
+
+	tmp = RREG32(mmHDMI_VBI_PACKET_CONTROL + dig-&gt;afmt-&gt;offset);
+	tmp = REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL, HDMI_NULL_SEND, 1);
+	tmp = REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL, HDMI_GC_SEND, 1);
+	tmp = REG_SET_FIELD(tmp, HDMI_VBI_PACKET_CONTROL, HDMI_GC_CONT, 1);
+	WREG32(mmHDMI_VBI_PACKET_CONTROL + dig-&gt;afmt-&gt;offset, tmp);
+}
+
+static void dce_v6_0_audio_set_acr(struct drm_encoder *encoder,
+				   uint32_t clock, int bpc)
+{
+	struct drm_device *dev = encoder-&gt;dev;
+	struct amdgpu_device *adev = dev-&gt;dev_private;
+	struct amdgpu_afmt_acr acr = amdgpu_afmt_acr(clock);
+	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
+	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder-&gt;enc_priv;
+	u32 tmp;
+
+	tmp = RREG32(mmHDMI_ACR_PACKET_CONTROL + dig-&gt;afmt-&gt;offset);
+	tmp = REG_SET_FIELD(tmp, HDMI_ACR_PACKET_CONTROL, HDMI_ACR_AUTO_SEND, 1);
+	tmp = REG_SET_FIELD(tmp, HDMI_ACR_PACKET_CONTROL, HDMI_ACR_SOURCE,
+			bpc &gt; 8 ? 0 : 1);
+	WREG32(mmHDMI_ACR_PACKET_CONTROL + dig-&gt;afmt-&gt;offset, tmp);
+
+	tmp = RREG32(mmHDMI_ACR_32_0 + dig-&gt;afmt-&gt;offset);
+	tmp = REG_SET_FIELD(tmp, HDMI_ACR_32_0, HDMI_ACR_CTS_32, acr.cts_32khz);
+	WREG32(mmHDMI_ACR_32_0 + dig-&gt;afmt-&gt;offset, tmp);
+	tmp = RREG32(mmHDMI_ACR_32_1 + dig-&gt;afmt-&gt;offset);
+	tmp = REG_SET_FIELD(tmp, HDMI_ACR_32_1, HDMI_ACR_N_32, acr.n_32khz);
+	WREG32(mmHDMI_ACR_32_1 + dig-&gt;afmt-&gt;offset, tmp);
+
+	tmp = RREG32(mmHDMI_ACR_44_0 + dig-&gt;afmt-&gt;offset);
+	tmp = REG_SET_FIELD(tmp, HDMI_ACR_44_0, HDMI_ACR_CTS_44, acr.cts_44_1khz);
+	WREG32(mmHDMI_ACR_44_0 + dig-&gt;afmt-&gt;offset, tmp);
+	tmp = RREG32(mmHDMI_ACR_44_1 + dig-&gt;afmt-&gt;offset);
+	tmp = REG_SET_FIELD(tmp, HDMI_ACR_44_1, HDMI_ACR_N_44, acr.n_44_1khz);
+	WREG32(mmHDMI_ACR_44_1 + dig-&gt;afmt-&gt;offset, tmp);
+
+	tmp = RREG32(mmHDMI_ACR_48_0 + dig-&gt;afmt-&gt;offset);
+	tmp = REG_SET_FIELD(tmp, HDMI_ACR_48_0, HDMI_ACR_CTS_48, acr.cts_48khz);
+	WREG32(mmHDMI_ACR_48_0 + dig-&gt;afmt-&gt;offset, tmp);
+	tmp = RREG32(mmHDMI_ACR_48_1 + dig-&gt;afmt-&gt;offset);
+	tmp = REG_SET_FIELD(tmp, HDMI_ACR_48_1, HDMI_ACR_N_48, acr.n_48khz);
+	WREG32(mmHDMI_ACR_48_1 + dig-&gt;afmt-&gt;offset, tmp);
 }
-*/
 
 static void dce_v6_0_afmt_update_avi_infoframe(struct drm_encoder *encoder,
 					       struct drm_display_mode *mode)
@@ -1585,6 +1631,7 @@ static void dce_v6_0_audio_set_dto(struct drm_encoder *encoder, u32 clock)
 	struct drm_device *dev = encoder-&gt;dev;
 	struct amdgpu_device *adev = dev-&gt;dev_private;
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder-&gt;crtc);
+	int em = amdgpu_atombios_encoder_get_encoder_mode(encoder);
 	u32 tmp;
 
 	/*
@@ -1596,10 +1643,21 @@ static void dce_v6_0_audio_set_dto(struct drm_encoder *encoder, u32 clock)
 	tmp = RREG32(mmDCCG_AUDIO_DTO_SOURCE);
 	tmp = REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE,
 			DCCG_AUDIO_DTO0_SOURCE_SEL, amdgpu_crtc-&gt;crtc_id);
-	tmp = REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE, DCCG_AUDIO_DTO_SEL, 1);
+	if (em == ATOM_ENCODER_MODE_HDMI) {
+		tmp = REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE,
+				DCCG_AUDIO_DTO_SEL, 0);
+	} else if (ENCODER_MODE_IS_DP(em)) {
+		tmp = REG_SET_FIELD(tmp, DCCG_AUDIO_DTO_SOURCE,
+				DCCG_AUDIO_DTO_SEL, 1);
+	}
 	WREG32(mmDCCG_AUDIO_DTO_SOURCE, tmp);
-	WREG32(mmDCCG_AUDIO_DTO1_PHASE, 24000);
-	WREG32(mmDCCG_AUDIO_DTO1_MODULE, clock);
+	if (em == ATOM_ENCODER_MODE_HDMI) {
+		WREG32(mmDCCG_AUDIO_DTO0_PHASE, 24000);
+		WREG32(mmDCCG_AUDIO_DTO0_MODULE, clock);
+	} else if (ENCODER_MODE_IS_DP(em)) {
+		WREG32(mmDCCG_AUDIO_DTO1_PHASE, 24000);
+		WREG32(mmDCCG_AUDIO_DTO1_MODULE, clock);
+	}
 }
 
 static void dce_v6_0_set_audio_packet(struct drm_encoder *encoder)
@@ -1659,6 +1717,43 @@ static void dce_v6_0_audio_set_mute(struct drm_encoder *encoder, bool mute)
 	WREG32(mmHDMI_GC + dig-&gt;afmt-&gt;offset, tmp);
 }
 
+static void dce_v6_0_audio_hdmi_enable(struct drm_encoder *encoder, bool enable)
+{
+	struct drm_device *dev = encoder-&gt;dev;
+	struct amdgpu_device *adev = dev-&gt;dev_private;
+	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
+	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder-&gt;enc_priv;
+	u32 tmp;
+
+	if (enable) {
+		tmp = RREG32(mmHDMI_INFOFRAME_CONTROL0 + dig-&gt;afmt-&gt;offset);
+		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_SEND, 1);
+		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_CONT, 1);
+		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, 1);
+		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_CONT, 1);
+		WREG32(mmHDMI_INFOFRAME_CONTROL0 + dig-&gt;afmt-&gt;offset, tmp);
+
+		tmp = RREG32(mmHDMI_INFOFRAME_CONTROL1 + dig-&gt;afmt-&gt;offset);
+		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL1, HDMI_AVI_INFO_LINE, 2);
+		WREG32(mmHDMI_INFOFRAME_CONTROL1 + dig-&gt;afmt-&gt;offset, tmp);
+
+		tmp = RREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig-&gt;afmt-&gt;offset);
+		tmp = REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL, AFMT_AUDIO_SAMPLE_SEND, 1);
+		WREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig-&gt;afmt-&gt;offset, tmp);
+	} else {
+		tmp = RREG32(mmHDMI_INFOFRAME_CONTROL0 + dig-&gt;afmt-&gt;offset);
+		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_SEND, 0);
+		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AVI_INFO_CONT, 0);
+		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_SEND, 0);
+		tmp = REG_SET_FIELD(tmp, HDMI_INFOFRAME_CONTROL0, HDMI_AUDIO_INFO_CONT, 0);
+		WREG32(mmHDMI_INFOFRAME_CONTROL0 + dig-&gt;afmt-&gt;offset, tmp);
+
+		tmp = RREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig-&gt;afmt-&gt;offset);
+		tmp = REG_SET_FIELD(tmp, AFMT_AUDIO_PACKET_CONTROL, AFMT_AUDIO_SAMPLE_SEND, 0);
+		WREG32(mmAFMT_AUDIO_PACKET_CONTROL + dig-&gt;afmt-&gt;offset, tmp);
+	}
+}
+
 static void dce_v6_0_audio_dp_enable(struct drm_encoder *encoder, bool enable)
 {
 	struct drm_device *dev = encoder-&gt;dev;
@@ -1696,6 +1791,8 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder-&gt;enc_priv;
 	struct drm_connector *connector;
 	struct amdgpu_connector *amdgpu_connector = NULL;
+	int em = amdgpu_atombios_encoder_get_encoder_mode(encoder);
+	int bpc = 8;
 
 	if (!dig || !dig-&gt;afmt)
 		return;
@@ -1719,6 +1816,11 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 	if (!dig-&gt;afmt-&gt;pin)
 		return;
 
+	if (encoder-&gt;crtc) {
+		struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(encoder-&gt;crtc);
+		bpc = amdgpu_crtc-&gt;bpc;
+	}
+
 	/* disable audio before setting up hw */
 	dce_v6_0_audio_enable(adev, dig-&gt;afmt-&gt;pin, false);
 
@@ -1726,12 +1828,22 @@ static void dce_v6_0_afmt_setmode(struct drm_encoder *encoder,
 	dce_v6_0_audio_write_speaker_allocation(encoder);
 	dce_v6_0_audio_write_sad_regs(encoder);
 	dce_v6_0_audio_write_latency_fields(encoder, mode);
-	dce_v6_0_audio_set_dto(encoder, adev-&gt;clock.default_dispclk * 10);
+	if (em == ATOM_ENCODER_MODE_HDMI) {
+		dce_v6_0_audio_set_dto(encoder, mode-&gt;clock);
+		dce_v6_0_audio_set_vbi_packet(encoder);
+		dce_v6_0_audio_set_acr(encoder, mode-&gt;clock, bpc);
+	} else if (ENCODER_MODE_IS_DP(em)) {
+		dce_v6_0_audio_set_dto(encoder, adev-&gt;clock.default_dispclk * 10);
+	}
 	dce_v6_0_set_audio_packet(encoder);
 	dce_v6_0_afmt_audio_select_pin(encoder);
 	dce_v6_0_afmt_update_avi_infoframe(encoder, mode);
 	dce_v6_0_audio_set_mute(encoder, false);
-	dce_v6_0_audio_dp_enable(encoder, 1);
+	if (em == ATOM_ENCODER_MODE_HDMI) {
+		dce_v6_0_audio_hdmi_enable(encoder, 1);
+	} else if (ENCODER_MODE_IS_DP(em)) {
+		dce_v6_0_audio_dp_enable(encoder, 1);
+	}
 
 	/* enable audio after setting up hw */
 	dce_v6_0_audio_enable(adev, dig-&gt;afmt-&gt;pin, true);

</pre>
      </blockquote>
      <pre wrap="">
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------48A5BB894C1FCB7BECFCA132--

--===============0772693906==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0772693906==--
