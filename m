Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA3BF8D761
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 17:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B0510E91A;
	Thu, 16 Apr 2026 17:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jiN8Dob4";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0692310E91A
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 17:38:57 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-605def5b807so2555184137.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 10:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776361137; cv=none;
 d=google.com; s=arc-20240605;
 b=Olao5GIy3B3tq9oKkjv95F94QnaaQtkOTFMKW7n6uTZK3qGS2RFzujSPMoT5ktSHy7
 uJ/MkYwUBv84GUdpTMx2MpEFCaWJG/8D6UQ+q8dAoABK8VA2mgcYdmKhNmOh4RDrzg7D
 GadbRyjW2uP7r53zyaOf3nlHdg5gMacZX5704UkIY3Uyhkpasuu2I4tNKKoP5Rhb+Z1q
 TcM6dclrnBJVyWuyz9ocXMTK9DYHDSS2oNiF5yPMUL+R1a8crgTeY9U+cF+xwjDxzKtU
 7cisf91fmVJK9mjBEi+uQD/itwBs1Aklbnk9VSK7TkbWpTxzjolTktLk61WmTk/R7x+3
 AX4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A7iNW3JHuRGMp48gnwzuz7jVF183d1vdhGDJQ4dp17g=;
 fh=HCwtLsuG9pVO/+4FH+7TRtNWE9FDJycA6+u6MlgdO40=;
 b=ia9EX3cTQ/nn/EtlUdbFMeG7u692DlE4Jt7Tth55yhH+GpiAs5eGauZxVbrRSKupqi
 BiPc7GsO6M3GuJwqaav/wvTmg803o/WIAMgN8OsnT3GmGzKul+GhvUznOH6KZqpd3SlI
 FmPTJATrrT++OgrwG+bmeOek6UvFe8FnA5VtmcwpPO6Ws075zO84MUsQIeaHYmmEzw9f
 eb56RuotXKSqU7UUF/H9pKX/4bZuXGimNhmNNsIdjsvc8JuGgy33jPsqCnRScKaTAv4s
 rqRcX+RtRylMX4jK3XVBXJxFS/eaniVUsX3w87x4Oq21E42pLHp/p4F0pkyhHUTPmamf
 5vvQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776361137; x=1776965937; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A7iNW3JHuRGMp48gnwzuz7jVF183d1vdhGDJQ4dp17g=;
 b=jiN8Dob4Q2cGO1VwC3iKO9faQXHb4/Iz72R4kV4UIWt00uS69KGWkKTCx7qfnaPh/2
 WK3+V+qq9qIYQmXPiKUi3QAPBG1WDr1svpHWYrCmMaT/EIK3C5PfVETeA4XOTJDen1wf
 J5qdRU8MkBnJ0UPkv0hAk95C5G8HTsWhIKp0Y8xb1bvW+hShSEh/hp18+5aghdhK7N+o
 fINc0ysiDYszSQJumVNdEX//652lZN3ovR/hkHSHbhwGrj2Z2DYpPyDwcTTpB0V6ZJFF
 jUtxgeQFSwpNAUWTb+8lfsu68kBrzzGtAEVV+OY2ytcVEQK4LfEygMpFTLQXc3SCifbE
 qslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776361137; x=1776965937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7iNW3JHuRGMp48gnwzuz7jVF183d1vdhGDJQ4dp17g=;
 b=S9kYG4/rFdSBujycbADdIX5Nve6JGrhmTtgR63FjxuLrA6mFnKndX2AnhNSWRavSQ9
 dhTiLxSo34BMPMZGh9x+clZRDCCwJ8aK29dZNmkRHyVj2G/X/5vqolpkjyr2FkDSRWKd
 lN7ebsVQGkJuTEJxw1/snLQAFN4Sx5Qw8pE60E5QLKIbLak7bjZBL5EyEOywnNYW0Qon
 clj5rcJFU4SeLmBygAEBvsHOHezaMBZvNjnIK4n8K0kSPt1P25Hff3uezvhs3e5jgdKr
 pYtzgZud64rpXzPGtLijtJZQFAvH5fSSrEhkZj3BRQ9c22s7YlCRxUtdQwNWmvsZAF4J
 pd+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9TzXMiKqjL8OKyFHGkHx4Sww9DI/5oM/l665GeQ5UH+ndWdLLhPT5XCv+3+bUMNEvMv/6vrpZP@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcnXsjdE/5J0VMqyVfUhW/CVN7/vz/TUZYLKKKHYqC6SITkvn4
 lUSlBlJR7SM6+3grX1NS31HRLVLC0+rHid4iOL0T6nw+1UmyrnqINCDYJLc/uOXPnhlVOzyqXcs
 G2YelkxSHZeFT1V0dNipfq3gBO6LAnzU=
X-Gm-Gg: AeBDieupi/ZUsXA6MhHXTCMhZ+oYk7HKEf63zBwxaiDO141d2Az+6YWBVH+IHfR2+wP
 iPqAB1FHwojspVZ6FTU9dioLijPaZhULsQ1686hg5oJlipVJxgPY/KrWRDiD0q/v+TqXO4U5ucR
 p/QuMOzkSJ7obSWYe9PbQ9J2r8Wyj09s2TA9gEEmQh/LCjrb4CADB8iG7y/FmkgU57jtoqivp6a
 5TFodeKTC1k+NtfcYkYyg5QDxdkr6G70Ec6nxQkr1ZXTlZOspgRdowettm3+BpMnyYYR2+VWGF9
 5p8bQPFC8a3v0uoD9+SKI03xHpkAHS8gUs/BweVrMoMjq7zh5Fs=
X-Received: by 2002:a05:6102:e07:b0:5ff:2963:52dc with SMTP id
 ada2fe7eead31-616cb3ceb9cmr26005137.4.1776361136628; Thu, 16 Apr 2026
 10:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260415224150.1807020-1-Roman.Li@amd.com>
 <b6e52939-5593-4874-a8d0-010594d6a637@amd.com>
In-Reply-To: <b6e52939-5593-4874-a8d0-010594d6a637@amd.com>
From: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Thu, 16 Apr 2026 19:38:39 +0200
X-Gm-Features: AQROBzBsAv34kfXaSv_3nbsTDuvHXph3SC0wexZo40JznwBN0Ivt8UH0S21YTh8
Message-ID: <CAFF-SiWw6vJR3uKO3Zw7XrmfF2Vx35dJRVMVviCu2gzhuT6RKw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Restore analog connector support
To: Alex Hung <alex.hung@amd.com>
Cc: Roman Li <Roman.Li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, 
 Leo Li <Sunpeng.Li@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Content-Type: multipart/alternative; boundary="0000000000008aa74c064f974e87"
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

--0000000000008aa74c064f974e87
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'll test this on a few different old GPUs and get back to you.

Thanks,
Timur

Alex Hung <alex.hung@amd.com> ezt =C3=ADrta (id=C5=91pont: 2026. =C3=A1pr. =
16., Cs=C3=BC 17:46):

> Reviewed-by: Alex Hung <alex.hung@amd.com>
>
> On 4/15/26 16:41, Roman.Li@amd.com wrote:
> > From: Roman Li <Roman.Li@amd.com>
> >
> > [Why]
> > The analog connector support was accidentally removed,
> > causing a crash when connecting an analog monitor.
> >
> > [How]
> > This patch restores the functions and pointers required for proper anal=
og
> > and DP bridge encoder support on legacy GPUs.
> >
> > Fixes: 66715fc0ecfd ("drm/amd/display: Sync dcn42 with DC 3.2.373")
> > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Signed-off-by: Roman Li <Roman.Li@amd.com>
> > ---
> >   .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 53 ++++++++++++++++++=
+
> >   1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> > index 5273ca09fe12..e76abc877f4a 100644
> > --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> > +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> > @@ -677,6 +677,48 @@ dce110_dac_encoder_control(struct pipe_ctx
> *pipe_ctx, bool enable)
> >       bios->funcs->encoder_control(bios, &encoder_control);
> >   }
> >
> > +static void
> > +dce110_external_encoder_control(enum bp_external_encoder_control_actio=
n
> action,
> > +                             struct dc_link *link,
> > +                             struct dc_crtc_timing *timing)
> > +{
> > +     struct dc *dc =3D link->ctx->dc;
> > +     struct dc_bios *bios =3D link->ctx->dc_bios;
> > +     const struct dc_link_settings *link_settings =3D
> &link->cur_link_settings;
> > +     enum bp_result bp_result =3D BP_RESULT_OK;
> > +     struct bp_external_encoder_control ext_cntl =3D {
> > +             .action =3D action,
> > +             .connector_obj_id =3D link->link_enc->connector,
> > +             .encoder_id =3D link->ext_enc_id,
> > +             .lanes_number =3D link_settings->lane_count,
> > +             .link_rate =3D link_settings->link_rate,
> > +
> > +             /* Use signal type of the real link encoder, ie. DP */
> > +             .signal =3D link->connector_signal,
> > +
> > +             /* We don't know the timing yet when executing the SETUP
> action,
> > +              * so use a reasonably high default value. It seems that
> ENABLE
> > +              * can change the actual pixel clock but doesn't work wit=
h
> higher
> > +              * pixel clocks than what SETUP was called with.
> > +              */
> > +             .pixel_clock =3D timing ? timing->pix_clk_100hz / 10 :
> 300000,
> > +             .color_depth =3D timing ? timing->display_color_depth :
> COLOR_DEPTH_888,
> > +     };
> > +     DC_LOGGER_INIT(dc->ctx);
> > +
> > +     bp_result =3D bios->funcs->external_encoder_control(bios, &ext_cn=
tl);
> > +
> > +     if (bp_result !=3D BP_RESULT_OK)
> > +             DC_LOG_ERROR("Failed to execute external encoder action:
> 0x%x\n", action);
> > +}
> > +
> > +static void
> > +dce110_prepare_ddc(struct dc_link *link)
> > +{
> > +     if (link->ext_enc_id.id)
> > +
>  dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DDC_SETUP, link=
,
> NULL);
> > +}
> > +
> >   static bool
> >   dce110_dac_load_detect(struct dc_link *link)
> >   {
> > @@ -3376,6 +3418,15 @@ void dce110_enable_tmds_link_output(struct
> dc_link *link,
> >       link->phy_state.symclk_state =3D SYMCLK_ON_TX_ON;
> >   }
> >
> > +static void dce110_enable_analog_link_output(
> > +             struct dc_link *link,
> > +             uint32_t pix_clk_100hz)
> > +{
> > +     link->link_enc->funcs->enable_analog_output(
> > +                     link->link_enc,
> > +                     pix_clk_100hz);
> > +}
> > +
> >   void dce110_enable_dp_link_output(
> >               struct dc_link *link,
> >               const struct link_resource *link_res,
> > @@ -3513,8 +3564,10 @@ static const struct hw_sequencer_funcs
> dce110_funcs =3D {
> >       .enable_lvds_link_output =3D dce110_enable_lvds_link_output,
> >       .enable_tmds_link_output =3D dce110_enable_tmds_link_output,
> >       .enable_dp_link_output =3D dce110_enable_dp_link_output,
> > +     .enable_analog_link_output =3D dce110_enable_analog_link_output,
> >       .disable_link_output =3D dce110_disable_link_output,
> >       .dac_load_detect =3D dce110_dac_load_detect,
> > +     .prepare_ddc =3D dce110_prepare_ddc,
> >   };
> >
> >   static const struct hwseq_private_funcs dce110_private_funcs =3D {
>
>

--0000000000008aa74c064f974e87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi,<div dir=3D"auto"><br></div><div dir=3D"auto">I&#39;ll=
 test this on a few different old GPUs and get back to you.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto">Timur<=
/div></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D=
"ltr" class=3D"gmail_attr">Alex Hung &lt;<a href=3D"mailto:alex.hung@amd.co=
m">alex.hung@amd.com</a>&gt; ezt =C3=ADrta (id=C5=91pont: 2026. =C3=A1pr. 1=
6., Cs=C3=BC 17:46):<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Reviewed-by: A=
lex Hung &lt;<a href=3D"mailto:alex.hung@amd.com" target=3D"_blank" rel=3D"=
noreferrer">alex.hung@amd.com</a>&gt;<br>
<br>
On 4/15/26 16:41, <a href=3D"mailto:Roman.Li@amd.com" target=3D"_blank" rel=
=3D"noreferrer">Roman.Li@amd.com</a> wrote:<br>
&gt; From: Roman Li &lt;<a href=3D"mailto:Roman.Li@amd.com" target=3D"_blan=
k" rel=3D"noreferrer">Roman.Li@amd.com</a>&gt;<br>
&gt; <br>
&gt; [Why]<br>
&gt; The analog connector support was accidentally removed,<br>
&gt; causing a crash when connecting an analog monitor.<br>
&gt; <br>
&gt; [How]<br>
&gt; This patch restores the functions and pointers required for proper ana=
log<br>
&gt; and DP bridge encoder support on legacy GPUs.<br>
&gt; <br>
&gt; Fixes: 66715fc0ecfd (&quot;drm/amd/display: Sync dcn42 with DC 3.2.373=
&quot;)<br>
&gt; Cc: Timur Krist=C3=B3f &lt;<a href=3D"mailto:timur.kristof@gmail.com" =
target=3D"_blank" rel=3D"noreferrer">timur.kristof@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Roman Li &lt;<a href=3D"mailto:Roman.Li@amd.com" target=
=3D"_blank" rel=3D"noreferrer">Roman.Li@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0.../amd/display/dc/hwss/dce110/dce110_hwseq.c | 53 +++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 53 insertions(+)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c=
 b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
&gt; index 5273ca09fe12..e76abc877f4a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c<br>
&gt; @@ -677,6 +677,48 @@ dce110_dac_encoder_control(struct pipe_ctx *pipe_=
ctx, bool enable)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bios-&gt;funcs-&gt;encoder_control(bios, &am=
p;encoder_control);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void<br>
&gt; +dce110_external_encoder_control(enum bp_external_encoder_control_acti=
on action,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dc_link *link,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dc_crtc_timing *timing)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct dc *dc =3D link-&gt;ctx-&gt;dc;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct dc_bios *bios =3D link-&gt;ctx-&gt;dc_bios=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct dc_link_settings *link_settings =3D =
&amp;link-&gt;cur_link_settings;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0enum bp_result bp_result =3D BP_RESULT_OK;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct bp_external_encoder_control ext_cntl =3D {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.action =3D action,<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.connector_obj_id =3D=
 link-&gt;link_enc-&gt;connector,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.encoder_id =3D link-=
&gt;ext_enc_id,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.lanes_number =3D lin=
k_settings-&gt;lane_count,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.link_rate =3D link_s=
ettings-&gt;link_rate,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use signal type of=
 the real link encoder, ie. DP */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.signal =3D link-&gt;=
connector_signal,<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* We don&#39;t know =
the timing yet when executing the SETUP action,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * so use a reasonabl=
y high default value. It seems that ENABLE<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * can change the act=
ual pixel clock but doesn&#39;t work with higher<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * pixel clocks than =
what SETUP was called with.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.pixel_clock =3D timi=
ng ? timing-&gt;pix_clk_100hz / 10 : 300000,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.color_depth =3D timi=
ng ? timing-&gt;display_color_depth : COLOR_DEPTH_888,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0};<br>
&gt; +=C2=A0 =C2=A0 =C2=A0DC_LOGGER_INIT(dc-&gt;ctx);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bp_result =3D bios-&gt;funcs-&gt;external_encoder=
_control(bios, &amp;ext_cntl);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (bp_result !=3D BP_RESULT_OK)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DC_LOG_ERROR(&quot;Fa=
iled to execute external encoder action: 0x%x\n&quot;, action);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void<br>
&gt; +dce110_prepare_ddc(struct dc_link *link)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (link-&gt;<a href=3D"http://ext_enc_id.id" rel=
=3D"noreferrer noreferrer" target=3D"_blank">ext_enc_id.id</a>)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dce110_external_encod=
er_control(EXTERNAL_ENCODER_CONTROL_DDC_SETUP, link, NULL);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static bool<br>
&gt;=C2=A0 =C2=A0dce110_dac_load_detect(struct dc_link *link)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; @@ -3376,6 +3418,15 @@ void dce110_enable_tmds_link_output(struct dc_l=
ink *link,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0link-&gt;phy_state.symclk_state =3D SYMCLK_O=
N_TX_ON;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void dce110_enable_analog_link_output(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dc_link *link,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pix_clk_100h=
z)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0link-&gt;link_enc-&gt;funcs-&gt;enable_analog_out=
put(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0link-&gt;link_enc,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pix_clk_100hz);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0void dce110_enable_dp_link_output(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dc_link *=
link,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct lin=
k_resource *link_res,<br>
&gt; @@ -3513,8 +3564,10 @@ static const struct hw_sequencer_funcs dce110_f=
uncs =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.enable_lvds_link_output =3D dce110_enable_l=
vds_link_output,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.enable_tmds_link_output =3D dce110_enable_t=
mds_link_output,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.enable_dp_link_output =3D dce110_enable_dp_=
link_output,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.enable_analog_link_output =3D dce110_enable_anal=
og_link_output,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.disable_link_output =3D dce110_disable_link=
_output,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.dac_load_detect =3D dce110_dac_load_detect,=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0.prepare_ddc =3D dce110_prepare_ddc,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static const struct hwseq_private_funcs dce110_private_fun=
cs =3D {<br>
<br>
</blockquote></div>

--0000000000008aa74c064f974e87--
