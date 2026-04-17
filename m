Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4DEF99C65
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 21:08:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14FF110EA8B;
	Fri, 17 Apr 2026 21:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SFZXuWpU";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9504610EA96
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 21:08:18 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2d9472c97dbso116732eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 14:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776460098; cv=none;
 d=google.com; s=arc-20240605;
 b=cn8DimhcSb9ZQbiE7NCB285FDyTFdR5QKi1aUeTd7NkQDRDycQmlSbq/aMWRnWPkO2
 BOWcC53bJ/p6Hh0HOZEvWx73ECUvxCxaHF5eg7RpmUBJ4Rlv+ZIiBFHD5uwVRxtJ1dq8
 bNYanZv1mxFxCvx5sdqtWyJim2EAmHdZfNmePxKNYOYHdO0TqnANb99purosS9LFiKA7
 2GMHm5qG3bJR++71B90DLprMDXRQdm/u5/ES8MJtIxZeqVxV3pnLsRZsUirsr0TuF4HF
 P+0MNkpll3BVOz/3FTAjk+N0Q5l8JAPExU9LfEIxZm6bHiLRB/oy6CxBXlZxpLeCehie
 +pxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BLB+XBTQqjSFa8P//h5k3pTMTzVU/JvGGmC7MbxqqGA=;
 fh=LD8ASSsFUKYm+pm8VdwAeYQsx/+0v8dDFSKfkIeV+Mc=;
 b=U3nCamNGhM5LCykFIa2WxzjcmwugnJQL8OFAOwdTdy+BTPPElh05a6WbkmRcLaOekm
 6qVQLxH/Ic+6ZqABxIG+MzoB0UU5/zKTsUNPprk6+t2QO0OSD0gAA6qsVNFB2J/M7+ye
 onpldld8WVD5V8gydYCnQmnMQ8At2oi1wkOjPn6zaWh3VJO32FuL/+UGyqWI6VjPf1mv
 yepUXzWhA06KuHQUvsiazq2B6A+db1YHpQ40vgQe27TctUBR3UcaF4GfMZWYQ+R+gHUZ
 Y411iv435qOUfqw/LcLI96n7AzJke6UaCcI3zqqW1EiuP+ctiLpkE3uGzt6Zle07PAus
 W7VQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776460098; x=1777064898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLB+XBTQqjSFa8P//h5k3pTMTzVU/JvGGmC7MbxqqGA=;
 b=SFZXuWpU9+CE5x1rZu3rs8uCwp2qm8d72yBdGAt0adngIllPJELdnljIAWqFM3kWN2
 PLGUHxA3fQMTrsg5HQxXtwq35v6Z5a+qOjE6UN8Rmrf2X/V39dVvbuYHiIOtLNDrOLdB
 eZkbLDnxCEYEwllbexJwjLsW+8iEJuZr8aOtWvd9Qladvz4jA1LPYgHQLlMqVpq127X/
 O8DBr9FeKEs9Apzc34pfpZMe9hcxGaLI4Dzz+YGpOMthI/jLprvmW6OQzakMvsLLBX83
 Opb8249StQZI7pWOW/cBFtEcG9mpA7vbJdlW5iqhihSRPVMtZVkPEFeIxAftnnZLN8hc
 wRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776460098; x=1777064898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BLB+XBTQqjSFa8P//h5k3pTMTzVU/JvGGmC7MbxqqGA=;
 b=FZITzieop34w05OnJ0lPOmu4En29s/teOQgU6AGv/3pf6tnf7lee1VKJZ3RKFfS7qU
 KAkI5n+Y8DHgeeUirgcuq0vvB8CPU6kcmp0/jGt/WQAGSb6K6WDKOQKENDkMiyp/IjTP
 wcAGPvFHRsN6wE2FjWNXlfg3XyU3MTtAysQUqKBofR9DXH8N40WwkqfTZSJgS2SuQCDm
 5hdRXuX5jod4WIKbJxBDtouaYzgW/8O79nwkDbxTIwF3KjvsGSvBUH59tz7PFNJte/eg
 QJsmy+sPgezfOCjoMjToag6Wa4s/LdsdrhU9axRB0tazqocvvicD2DcWjKUW8SkkOUDg
 m2IQ==
X-Gm-Message-State: AOJu0YwzzyRTOTILkq215Vq9bIKT1tVy9OiMrI1xmfGEV8Psihy4nkuU
 xXbOP+qUaAPitN/lUlk2g8yIRuYOh5aJZa9ryaLgb97RXYNK/7hosaTLEQQNB7x00UVH8qvdTpv
 mR5BeVwWcPlO1DXC0o1l8ZkKZaOtnzCs=
X-Gm-Gg: AeBDieuvDE4QxO5J75YqHxUD9ncRzI/8vYdmPeoPqttcBfLcSfy1HhPkSnOVCYFyjTk
 uAXsDJiKC0MRnsJxqMeiD8bSN7XZ1jBuG9wqkUqMrKa7odbvLChNHwqk2DK8LwYHlZRofXPnpcY
 DQoyZ9zFbpQLyvmrMPIcqnKUoUJ8m29PVsuYsNhjOcMxEXjg5yzdN75MLftPDr8vhUdVL+eftMO
 cqjrE/ZBZ9wa65J1T8FzXDwjbpg7Owqp7Xco3QEEE9UeIURTKhTDcYxEAP2tnk75oG+uAkpAMkJ
 jDP/Z5Jqkt1Rs6LBcEsb9uYYhaQUUHyvsXV+UPjDeAvY9ki3ujaWAuA7nK+SvoTn+sLjvLCeA0b
 1dfpt
X-Received: by 2002:a05:7022:6889:b0:124:af80:9d0c with SMTP id
 a92af1059eb24-12c73d26cc4mr839812c88.0.1776460097659; Fri, 17 Apr 2026
 14:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260417205507.1844039-1-Roman.Li@amd.com>
In-Reply-To: <20260417205507.1844039-1-Roman.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 17:08:06 -0400
X-Gm-Features: AQROBzAGERG41Nji40JuDSNs8sc4WEnNezZPg0vrEFIXA8HUwvIPyIH0pQQjy6E
Message-ID: <CADnq5_M+37OEmw7ZczDUeSw0dne7tCgv8ojvRUSFL5R8OQOZuQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Restore analog connector support
To: Roman.Li@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Aurabindo.Pillai@amd.com, 
 alex.hung@amd.com, =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 17, 2026 at 5:04=E2=80=AFPM <Roman.Li@amd.com> wrote:
>
> From: Roman Li <Roman.Li@amd.com>
>
> [Why]
> The analog connector support was accidentally removed,
> causing a crash when connecting an analog monitor.
>
> [How]
> This patch restores the functions and pointers required for proper analog
> and DP bridge encoder support on legacy GPUs.
>
> V2: Restore the external encoder control functions.
>
> Fixes: 66715fc0ecfd ("drm/amd/display: Sync dcn42 with DC 3.2.373")

I think you also need to revert this hunk:

--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -794,13 +794,11 @@ static enum bp_result
bios_parser_external_encoder_control(

 static enum bp_result bios_parser_dac_load_detection(
        struct dc_bios *dcb,
-       enum engine_id engine_id,
-       struct graphics_object_id ext_enc_id)
+       enum engine_id engine_id)
 {
        struct bios_parser *bp =3D BP_FROM_DCB(dcb);
        struct dc_context *ctx =3D dcb->ctx;
        struct bp_load_detection_parameters bp_params =3D {0};
-       struct bp_external_encoder_control ext_cntl =3D {0};
        enum bp_result bp_result =3D BP_RESULT_UNSUPPORTED;
        uint32_t bios_0_scratch;
        uint32_t device_id_mask =3D 0;
@@ -826,13 +824,6 @@ static enum bp_result bios_parser_dac_load_detection(

                bp_params.engine_id =3D engine_id;
                bp_result =3D bp->cmd_tbl.dac_load_detection(bp, &bp_params=
);
-       } else if (ext_enc_id.id) {
-               if (!bp->cmd_tbl.external_encoder_control)
-                       return BP_RESULT_UNSUPPORTED;
-
-               ext_cntl.action =3D EXTERNAL_ENCODER_CONTROL_DAC_LOAD_DETEC=
T;
-               ext_cntl.encoder_id =3D ext_enc_id;
-               bp_result =3D bp->cmd_tbl.external_encoder_control(bp, &ext=
_cntl);
        }

        if (bp_result !=3D BP_RESULT_OK)


>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> ---
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 5273ca09fe12..73fb808dc016 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -677,6 +677,48 @@ dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx=
, bool enable)
>         bios->funcs->encoder_control(bios, &encoder_control);
>  }
>
> +static void
> +dce110_external_encoder_control(enum bp_external_encoder_control_action =
action,
> +                               struct dc_link *link,
> +                               struct dc_crtc_timing *timing)
> +{
> +       struct dc *dc =3D link->ctx->dc;
> +       struct dc_bios *bios =3D link->ctx->dc_bios;
> +       const struct dc_link_settings *link_settings =3D &link->cur_link_=
settings;
> +       enum bp_result bp_result =3D BP_RESULT_OK;
> +       struct bp_external_encoder_control ext_cntl =3D {
> +               .action =3D action,
> +               .connector_obj_id =3D link->link_enc->connector,
> +               .encoder_id =3D link->ext_enc_id,
> +               .lanes_number =3D link_settings->lane_count,
> +               .link_rate =3D link_settings->link_rate,
> +
> +               /* Use signal type of the real link encoder, ie. DP */
> +               .signal =3D link->connector_signal,
> +
> +               /* We don't know the timing yet when executing the SETUP =
action,
> +                * so use a reasonably high default value. It seems that =
ENABLE
> +                * can change the actual pixel clock but doesn't work wit=
h higher
> +                * pixel clocks than what SETUP was called with.
> +                */
> +               .pixel_clock =3D timing ? timing->pix_clk_100hz / 10 : 30=
0000,
> +               .color_depth =3D timing ? timing->display_color_depth : C=
OLOR_DEPTH_888,
> +       };
> +       DC_LOGGER_INIT(dc->ctx);
> +
> +       bp_result =3D bios->funcs->external_encoder_control(bios, &ext_cn=
tl);
> +
> +       if (bp_result !=3D BP_RESULT_OK)
> +               DC_LOG_ERROR("Failed to execute external encoder action: =
0x%x\n", action);
> +}
> +
> +static void
> +dce110_prepare_ddc(struct dc_link *link)
> +{
> +       if (link->ext_enc_id.id)
> +               dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_=
DDC_SETUP, link, NULL);
> +}
> +
>  static bool
>  dce110_dac_load_detect(struct dc_link *link)
>  {
> @@ -721,6 +763,9 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
>
>         if (dc_is_rgb_signal(pipe_ctx->stream->signal))
>                 dce110_dac_encoder_control(pipe_ctx, true);
> +
> +       if (link->ext_enc_id.id)
> +               dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_=
ENABLE, link, timing);
>  }
>
>  static enum bp_result link_transmitter_control(
> @@ -1221,6 +1266,9 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ct=
x)
>
>         if (dc_is_rgb_signal(pipe_ctx->stream->signal))
>                 dce110_dac_encoder_control(pipe_ctx, false);
> +
> +       if (link->ext_enc_id.id)
> +               dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_=
DISABLE, link, NULL);
>  }
>
>  void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
> @@ -3376,6 +3424,15 @@ void dce110_enable_tmds_link_output(struct dc_link=
 *link,
>         link->phy_state.symclk_state =3D SYMCLK_ON_TX_ON;
>  }
>
> +static void dce110_enable_analog_link_output(
> +               struct dc_link *link,
> +               uint32_t pix_clk_100hz)
> +{
> +       link->link_enc->funcs->enable_analog_output(
> +                       link->link_enc,
> +                       pix_clk_100hz);
> +}
> +
>  void dce110_enable_dp_link_output(
>                 struct dc_link *link,
>                 const struct link_resource *link_res,
> @@ -3423,6 +3480,11 @@ void dce110_enable_dp_link_output(
>                 }
>         }
>
> +       if (link->ext_enc_id.id) {
> +               dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_=
INIT, link, NULL);
> +               dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_=
SETUP, link, NULL);
> +       }
> +
>         if (dc->link_srv->dp_get_encoding_format(link_settings) =3D=3D DP=
_8b_10b_ENCODING) {
>                 if (dc->clk_mgr->funcs->notify_link_rate_change)
>                         dc->clk_mgr->funcs->notify_link_rate_change(dc->c=
lk_mgr, link);
> @@ -3513,8 +3575,10 @@ static const struct hw_sequencer_funcs dce110_func=
s =3D {
>         .enable_lvds_link_output =3D dce110_enable_lvds_link_output,
>         .enable_tmds_link_output =3D dce110_enable_tmds_link_output,
>         .enable_dp_link_output =3D dce110_enable_dp_link_output,
> +       .enable_analog_link_output =3D dce110_enable_analog_link_output,
>         .disable_link_output =3D dce110_disable_link_output,
>         .dac_load_detect =3D dce110_dac_load_detect,
> +       .prepare_ddc =3D dce110_prepare_ddc,
>  };
>
>  static const struct hwseq_private_funcs dce110_private_funcs =3D {
> --
> 2.34.1
>
