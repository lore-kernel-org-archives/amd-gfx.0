Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D5EF436BF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 18:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874D310EA91;
	Fri, 17 Apr 2026 18:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EbxNrWvf";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A545B10EA91
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 18:59:26 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2d89bbca7b5so80211eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 11:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776452366; cv=none;
 d=google.com; s=arc-20240605;
 b=Cua1iTN5dt3dyZn28dIEVgvDekPbSydXkR54c3zZEgSeV78pGLYa1kdHsguyVEBRx5
 /56V3pbyXpznQJ+hMEZnXCqX1yI/IBHxiaFGH8OcddfhP1nBDACkV6Bf/m4SVzMtuHUP
 aLahWSQomtwHIhLn5PvFVCkmOqSHCQ8YdkP6Qd4Bt6jq2QJ6L810C25PsJ6E1/ASQ0LP
 aBoKuBezoPm8VFfUNbBnlEQHFAAz6eK7a/7SsFBRyEQfMslUD1+jWUgdUbSCGFWsfYAb
 g0PdRvZ9CvV84pA/L1IgBSiROF/I5V2gLtWGa0QplMbk1l85WX7rYE3/7JGO9cqWqsh/
 /X/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GVayih+677UGEhKbuHytFZu0KVUTWAb29aMb2tSjHe8=;
 fh=wvO27Ep+adkqfRHG926HQ9wsmd6yUHdCvs9BaniW2l8=;
 b=VW9chqQkCYyRrLwWxldBWG8Q42Ak8UAIaZX48loEfKBJyLZ/dJYlSX4XtxkRyC1grg
 22OqMoqs43svbGi4gcruGDnU0VB5MWVv21TyK2vEbikqYsnAQXIu9l8FuNZClG53PuuR
 Eot4SR6UWLi1kBX+VClJSaytFAsxvWh5dlJ8F93RLX6AYC9fG++EQC4NbYuAaGfdTkP4
 pisU+nveov8SyI0x7WgXSCafSs5Q9UIG39aj/IdPbrcK62w7sp7xIh6lkskvGLtu1HDb
 f7GF+FrMR5rONfpBy/T1vejzV2u2/5gEmn7VGa56yTk+nJrPpETX8ADh40mTnIsxiamC
 xR+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776452366; x=1777057166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVayih+677UGEhKbuHytFZu0KVUTWAb29aMb2tSjHe8=;
 b=EbxNrWvfxMA+pVzKHlcHj28Rg6iqPkF2xBk+arR0Rms4cJlbq8hj/3T0udqxpQ9vWn
 WAE+7IB+idYDjODuVPeibrMtZdxHEoD9TxNH0BTtFpkrMfEBlkPuWsHkez14a73+V+h1
 VabYrbOHC2wbATX0gyw1i0pGsS/e4kGc83UB3MVGGYgebyYT7+3HL5v99duAKpCyUwL+
 e8YdiKxANoya9H0YhLj+1S2bmdwHRL9AFGeFD5yms5NFMKHQ6ZswjEG8lB0vtQZ7FroK
 p0s0LHmb8t9EIrhzdp8ODy42CwTajQpkIzG9r2dE8wAZQZ604HN2eFsrDODfSPNYPhTr
 2tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776452366; x=1777057166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GVayih+677UGEhKbuHytFZu0KVUTWAb29aMb2tSjHe8=;
 b=AthaW1byR0UjCq0906HcwE32rTHpvGSTNgdqi5e08mdvpoG2P/I0U1csU8oRhZ3FSJ
 QhorFN/avACgkY1Uw/xcMYrRNUD93kaJewTm76tJ2UJwtwx/fhe1KtsIJZgsVPhN37/2
 fk5ISS/1MGO9+p0zF1QHMMcy+fxn2t9Dgm+XXvdaz2Voa4IcZTHjotu0W5O0MwBGLOoL
 XQD/A/rE0fOHJm8++OaE1iZgoc0nGITycnCDuY5fGQMYurPE7eSS0JxTva3twtIeDPPj
 PeESZnvxud0CKOWe680WCWOxukr5MIaDCmcyJyYMdIChiX1MQ8L5Vya2KWU903Q3Bba7
 Uzuw==
X-Gm-Message-State: AOJu0Yy9oagRf/QrTdmjxS6Wxc7VTU0oyx/Af8l4LBmCKZ3L52MoktH3
 GaE2A6HWUXWYAHnLz617oSF5GCUebjLiNu8UNw2CTOPsULF5QqC2qJwgCOL3ksW2BaJHbb3jxnS
 mx8a5Oz4vocGNMfsLHmX0l5Pelg4rdkw=
X-Gm-Gg: AeBDietauea5F7WL5SwibSTj9gmlgGRN0t0Cf+PNv5MOwpK2DLawKX/nEGE1u/x5AiD
 3VfWiTKOCxZRKNV3Q0cPawgA8GddOrJnzweKHbXPy5e1HFNcqC8GgwOLyoWiuj1P38a/F7bzKRf
 SQTUkrJ4zgIVD0ZWaoUfnOg8R5Kq3DsS0o0f12g5vV4/ycF8gq2qso1R+vdQkSRffWBAe1LlaVy
 NJhsjNsnOScGRojmRggXU4pYNoCol7xC6BlTOk46r5AjP5IwM5xhpWn3ejeYkwsJCTvXXONk0N3
 nkZA1yrVmTHG4AlVk9At/2PxqJ53UIAyrbtgmNx9ojgOx5UnSjNe7W7QUCvwzTgfL4CEpmZYHKg
 8XlOj
X-Received: by 2002:a05:7022:6289:b0:123:2d38:929b with SMTP id
 a92af1059eb24-12c73f9f31fmr781927c88.6.1776452365771; Fri, 17 Apr 2026
 11:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260415224150.1807020-1-Roman.Li@amd.com>
In-Reply-To: <20260415224150.1807020-1-Roman.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Apr 2026 14:59:14 -0400
X-Gm-Features: AQROBzD8Wv2nPyNGzNzF78IqQOiuHAQfeyg3IVwLaVcacDiXJKhoJRw0crI7a-c
Message-ID: <CADnq5_ONKfhoTTzG4+SdkvA80YXxsJg6_QXhDqDhBP5ZtePG-w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Restore analog connector support
To: Roman.Li@amd.com
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Aurabindo.Pillai@amd.com, 
 alex.hung@amd.com, timur.kristof@gmail.com
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

On Wed, Apr 15, 2026 at 6:42=E2=80=AFPM <Roman.Li@amd.com> wrote:
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
> Fixes: 66715fc0ecfd ("drm/amd/display: Sync dcn42 with DC 3.2.373")

66715fc0ecfd looks like it also accidently dropped some of the new
external encoder handling from bios_parser.c, dc_bios_types.h, and
dce110_hwseq.c

Alex

> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> ---
>  .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/=
drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 5273ca09fe12..e76abc877f4a 100644
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
> @@ -3376,6 +3418,15 @@ void dce110_enable_tmds_link_output(struct dc_link=
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
> @@ -3513,8 +3564,10 @@ static const struct hw_sequencer_funcs dce110_func=
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
