Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 933FDF8D75C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 19:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1623910EA82;
	Fri, 17 Apr 2026 19:36:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J8Tf0dQG";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063C110EA82
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 19:36:00 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so624898f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 12:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776454558; x=1777059358; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=se5JFXi9hkfYAm6vnz6IfnclG6zuIDKJskwiqxro0Y8=;
 b=J8Tf0dQGpNEOAATWwfh5C4gXzrsw6MNQ8jX44KLG0NcBVbvKZvxu3FtkXwIYS3RkeY
 7JLOgsCrE6vYyzT5P7WYVgW1T0ARX/QbuQ1gbab/BV8iYk4xTQkoyetxwdn2rbwGiC0g
 5+Mqms3HdzpCowlWHdS38/DjFFdZoLVtXtN7pcN5QwIGjbzkscN5T6fCeW0FDNFFhO0a
 1l7TSkIIcOH7zviQNSEjkPrNBQjZNe8Gs3feuiswDrkz7F1XR2L/S8Q5e+Wom7aH+gKT
 20priWwFANgcutBZcBPsdMhHXGFSWmghWWfpKVuF1AnRgrzZ0Xc+5XsRMHxPzxyBB+zj
 66Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776454558; x=1777059358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=se5JFXi9hkfYAm6vnz6IfnclG6zuIDKJskwiqxro0Y8=;
 b=dPKiMAowHCMp65b+Khr8EMoeSOHHBc7+rGhemr/phcEs8kUAsKXGjAzVsBA7gB1mqr
 IqZ5wMzNxVvNCvOsugQDcB2/U6oWlfir74vy+Xx478WYQOdbI3upxsTMPYuwwR/p16Cq
 G352P/bBZZC2gUvGxsO+ora5Lo5nOMwrZd1T4BjxH5h31VPLsvog52fB5D0fyM9ih9zR
 jPd6Vuv26vTF0nCgePU0eShZMwa+msEvW5eoNpqWJCDb/g0X9ohZn5PQYkxxPfKOlGYp
 J5V6er+hjEsRM3bEWm4dhe7JY6nwTaR59cmP1jP+0YDpBs0MphxhbhzoV9Myo2iuuiNq
 yqaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ylDZTEw9c4pPYhuvzoECyxk2PQXYm7CsXLfTclUgVTqYIcr4NDDr5ezBRs5ZeaSy5OKxHNT6L@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQuE2CN8GF69qkc39HzzowG3g/MFS7j+JtuQCJdC/R3qEbH2Lo
 /bY8yOz/iZzhldsitiL88n//cDyt1t6s5ca6ZgDYAwpwlbwMdlP9a6KD
X-Gm-Gg: AeBDieuOFTiaO5s/mQMqkiIwX2e7iXDjdwvAqODFIwhfLy/AexERabeSYxBmkRBWmGN
 pwSjvQ4qGbjMU6eVA0U0O5m5r7aUSBbLQq/Gm7o3uiShmIloN6czw1G2j/7HDAZv+r693SwbmlZ
 1zNzHOPJ4+oyPgEygmxinVnkBQlyjT7QgEihnbAVi8z7k8cshCG0eRptCCDCqzlKsDJl7sLYXoS
 Eqs0rGojW6/7KiTZmPciUrecSkzxkP99tC93D8JP6ZTjrrDSHPbex767s4KMcmmqj9Un8PUsN/z
 kW9Qj70rmCfyqNkgRWHyBJC+FpSSeuuirW3/3Y3Q+SonbTQQNE6QWDSKIKgZClsk3xcU+kZ9jig
 +w4M0Cr66FECJuLr/NtaYSRphPJWTa6envGgdeZSlpsTcFyHUk3shnp8o7YEBtggP2tLnJlts9h
 VkrnRvQ5xni0OPTjUq3yQ6FSrVlUAiLEY42VVt8Pxg9SlUJTE1HpsTw5FvPT+Ku1Y6Ou3+LFNk5
 9zqDpBrjkc=
X-Received: by 2002:a05:6000:1ac9:b0:43d:6787:9934 with SMTP id
 ffacd0b85a97d-43fe3db39b2mr6469228f8f.9.1776454558190; 
 Fri, 17 Apr 2026 12:35:58 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a18csm7750448f8f.20.2026.04.17.12.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 12:35:57 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Hung <alex.hung@amd.com>
Cc: Roman Li <Roman.Li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Leo Li <Sunpeng.Li@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Subject: Re: [PATCH] drm/amd/display: Restore analog connector support
Date: Fri, 17 Apr 2026 21:35:56 +0200
Message-ID: <2356837.vFx2qVVIhK@timur-hyperion>
In-Reply-To: <CAFF-SiWw6vJR3uKO3Zw7XrmfF2Vx35dJRVMVviCu2gzhuT6RKw@mail.gmail.com>
References: <20260415224150.1807020-1-Roman.Li@amd.com>
 <b6e52939-5593-4874-a8d0-010594d6a637@amd.com>
 <CAFF-SiWw6vJR3uKO3Zw7XrmfF2Vx35dJRVMVviCu2gzhuT6RKw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Hi,

Tested this on the following:
HD 7870 XT - works
R9 280X (Tahiti) - works
R9 380X (Tonga) - works
A10-7850K (Kaveri) - broken

It seems that some other chunks of code were removed which were necessary f=
or=20
external DP bridge encoders to work properly. Those will need to be added b=
ack=20
too, otherwise we regress Kaveri APUs.

Best regards,
Timur


On Thursday, April 16, 2026 7:38:39=E2=80=AFPM Central European Summer Time=
 Timur=20
Krist=C3=B3f wrote:
> Hi,
>=20
> I'll test this on a few different old GPUs and get back to you.
>=20
> Thanks,
> Timur
>=20
> Alex Hung <alex.hung@amd.com> ezt =C3=ADrta (id=C5=91pont: 2026. =C3=A1pr=
=2E 16., Cs=C3=BC 17:46):
> > Reviewed-by: Alex Hung <alex.hung@amd.com>
> >=20
> > On 4/15/26 16:41, Roman.Li@amd.com wrote:
> > > From: Roman Li <Roman.Li@amd.com>
> > >=20
> > > [Why]
> > > The analog connector support was accidentally removed,
> > > causing a crash when connecting an analog monitor.
> > >=20
> > > [How]
> > > This patch restores the functions and pointers required for proper
> > > analog
> > > and DP bridge encoder support on legacy GPUs.
> > >=20
> > > Fixes: 66715fc0ecfd ("drm/amd/display: Sync dcn42 with DC 3.2.373")
> > > Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > Signed-off-by: Roman Li <Roman.Li@amd.com>
> > > ---
> > >=20
> > >   .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 53 ++++++++++++++++=
+++
> > >   1 file changed, 53 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> >=20
> > b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> >=20
> > > index 5273ca09fe12..e76abc877f4a 100644
> > > --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> > > +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> > > @@ -677,6 +677,48 @@ dce110_dac_encoder_control(struct pipe_ctx
> >=20
> > *pipe_ctx, bool enable)
> >=20
> > >       bios->funcs->encoder_control(bios, &encoder_control);
> > >  =20
> > >   }
> > >=20
> > > +static void
> > > +dce110_external_encoder_control(enum bp_external_encoder_control_act=
ion
> >=20
> > action,
> >=20
> > > +                             struct dc_link *link,
> > > +                             struct dc_crtc_timing *timing)
> > > +{
> > > +     struct dc *dc =3D link->ctx->dc;
> > > +     struct dc_bios *bios =3D link->ctx->dc_bios;
> > > +     const struct dc_link_settings *link_settings =3D
> >=20
> > &link->cur_link_settings;
> >=20
> > > +     enum bp_result bp_result =3D BP_RESULT_OK;
> > > +     struct bp_external_encoder_control ext_cntl =3D {
> > > +             .action =3D action,
> > > +             .connector_obj_id =3D link->link_enc->connector,
> > > +             .encoder_id =3D link->ext_enc_id,
> > > +             .lanes_number =3D link_settings->lane_count,
> > > +             .link_rate =3D link_settings->link_rate,
> > > +
> > > +             /* Use signal type of the real link encoder, ie. DP */
> > > +             .signal =3D link->connector_signal,
> > > +
> > > +             /* We don't know the timing yet when executing the SETUP
> >=20
> > action,
> >=20
> > > +              * so use a reasonably high default value. It seems that
> >=20
> > ENABLE
> >=20
> > > +              * can change the actual pixel clock but doesn't work w=
ith
> >=20
> > higher
> >=20
> > > +              * pixel clocks than what SETUP was called with.
> > > +              */
> >=20
> > > +             .pixel_clock =3D timing ? timing->pix_clk_100hz / 10 :
> > 300000,
> >=20
> > > +             .color_depth =3D timing ? timing->display_color_depth :
> > COLOR_DEPTH_888,
> >=20
> > > +     };
> > > +     DC_LOGGER_INIT(dc->ctx);
> > > +
> > > +     bp_result =3D bios->funcs->external_encoder_control(bios,
> > > &ext_cntl);
> > > +
> > > +     if (bp_result !=3D BP_RESULT_OK)
> >=20
> > > +             DC_LOG_ERROR("Failed to execute external encoder action:
> > 0x%x\n", action);
> >=20
> > > +}
> > > +
> > > +static void
> > > +dce110_prepare_ddc(struct dc_link *link)
> > > +{
> > > +     if (link->ext_enc_id.id)
> > > +
> > =20
> >  dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DDC_SETUP, li=
nk,
> >=20
> > NULL);
> >=20
> > > +}
> > > +
> > >=20
> > >   static bool
> > >   dce110_dac_load_detect(struct dc_link *link)
> > >   {
> > >=20
> > > @@ -3376,6 +3418,15 @@ void dce110_enable_tmds_link_output(struct
> >=20
> > dc_link *link,
> >=20
> > >       link->phy_state.symclk_state =3D SYMCLK_ON_TX_ON;
> > >  =20
> > >   }
> > >=20
> > > +static void dce110_enable_analog_link_output(
> > > +             struct dc_link *link,
> > > +             uint32_t pix_clk_100hz)
> > > +{
> > > +     link->link_enc->funcs->enable_analog_output(
> > > +                     link->link_enc,
> > > +                     pix_clk_100hz);
> > > +}
> > > +
> > >=20
> > >   void dce110_enable_dp_link_output(
> > >  =20
> > >               struct dc_link *link,
> > >               const struct link_resource *link_res,
> > >=20
> > > @@ -3513,8 +3564,10 @@ static const struct hw_sequencer_funcs
> >=20
> > dce110_funcs =3D {
> >=20
> > >       .enable_lvds_link_output =3D dce110_enable_lvds_link_output,
> > >       .enable_tmds_link_output =3D dce110_enable_tmds_link_output,
> > >       .enable_dp_link_output =3D dce110_enable_dp_link_output,
> > >=20
> > > +     .enable_analog_link_output =3D dce110_enable_analog_link_output,
> > >=20
> > >       .disable_link_output =3D dce110_disable_link_output,
> > >       .dac_load_detect =3D dce110_dac_load_detect,
> > >=20
> > > +     .prepare_ddc =3D dce110_prepare_ddc,
> > >=20
> > >   };
> > >  =20
> > >   static const struct hwseq_private_funcs dce110_private_funcs =3D {




