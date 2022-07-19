Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5811C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 13:03:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA5F14B6F7;
	Tue, 19 Jul 2022 13:03:46 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BDBD14B6F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 13:03:44 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id b11so27002526eju.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KxQYN1a3ZGfB1KOqQ5k407MEFQumt7EgdtfRF8EZXWc=;
 b=h0d/jj6QF54fTlzQ2C4SclHkOfXgT+pVprPhXVapFUzBTN56U/6xdpVijg8B6pGKn1
 ZdxszDIKt6HuOtLmtxHjziCOMdDMnThWOswz6jvA5o8DmLR4DyUTeKsEJk3PD+rXUXSU
 ilvAg66Am7Ikj6/msciZJJm4j4Xl7+sQyDCqIWgpF18AHrMGFZcgaDsvCrkxPdNQTpFH
 rrp512V/CQvFgiOxzH53+VrJ1ti1ZScqfqtpMv8TE8qtWpeVO6V2dF6Cy32Kg5Nfelqw
 SjLPoci2e2nrTbqTwNk92pyJ7tzImNgfcvJXYkyiWfpJfYImygNBIGl04fdwiKL6xlxT
 r3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KxQYN1a3ZGfB1KOqQ5k407MEFQumt7EgdtfRF8EZXWc=;
 b=3MeM/IH2j3UFVVrs8dO88+2VhOq3iQRpZ9d2woNkX+oBTkhE/qHHB5V0oXHfR8TwJ1
 e9oO6u0tWYGPbeei8stt9A8zjeHqImt4xUzGGePd9VlGj8k89cjc+ZrgOrqiDouOzrot
 LLWCpQyxAfh4F69xXR8B1nJh9Dp2Zp+VvBCFmNLGuAMsYnWp27AcoWKJ0JpDEEjFj7fZ
 5igdcMq/XahBpvzVlakvlFZp4+1L5e9vz1r1v/3EoSt4KPVDTLYh3XyNEeB397cpVlG+
 UpV5EAhgWn1LKNQEoAGewlNLh1AEikQYfra+e4V/rCYHhLERSzm0eI0JfbGBgS9xUjyy
 1UIg==
X-Gm-Message-State: AJIora+B2C77GMCUIqDUnesmGSqDkftmpEXqxUVxuLtrr+EQVioXBc/c
 X+2ymOEeX1/hT3/iRHSrDJ+YUDn60gsCKi3A3whS9xTT
X-Google-Smtp-Source: AGRyM1uRm9Fj0U0RWtE9K6bHZ7V4KioIK5xyrjD5MLJ3IY09CuC6+9GYnh29PUvWdMfk0Fier4w1MWixWHujw4hSHm4=
X-Received: by 2002:a17:906:9751:b0:72f:1b36:e1de with SMTP id
 o17-20020a170906975100b0072f1b36e1demr14314745ejy.451.1658235822618; Tue, 19
 Jul 2022 06:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-10-mairacanal@riseup.net>
 <CADnq5_Ot2ecb=D7M2fznBWuZiC-OwPPAnfPfwFXbnrWcevAtzA@mail.gmail.com>
 <fef5812c-53e9-9222-e888-3556c6a9cc7a@riseup.net>
In-Reply-To: <fef5812c-53e9-9222-e888-3556c6a9cc7a@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Jul 2022 09:03:30 -0400
Message-ID: <CADnq5_O93QfDTKCoL4scVRMqLjP2Rtm2kB4+80GeM7b_oMT_+w@mail.gmail.com>
Subject: Re: [PATCH 10/12] drm/amd/display: Remove parameters from
 dml30_CalculateWriteBackDISPCLK
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
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
Cc: Magali Lemes <magalilemes00@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
 xinhui pan <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Melissa Wen <mwen@igalia.com>, David Airlie <airlied@linux.ie>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 19, 2022 at 6:49 AM Ma=C3=ADra Canal <mairacanal@riseup.net> wr=
ote:
>
> On 7/18/22 16:02, Alex Deucher wrote:
> > On Thu, Jul 14, 2022 at 12:46 PM Ma=C3=ADra Canal <mairacanal@riseup.ne=
t> wrote:
> >>
> >> The parameters WritebackPixelFormat and WritebackVRatio are removed as
> >> they are not used on the function dml30_CalculateWriteBackDISPCLK.
> >
> > Maybe this is done for consistency with other dml code for other DCN bl=
ocks?
> >
> > Alex
>
> This is reasonable. Anyway, the functions
> dml30_CalculateWriteBackDISPCLK and dml31_CalculateWriteBackDISPCLK are
> identical. May I send a v2 from PATCH 11/12 with the original function
> signature?

Sounds good.  Thanks!

Alex

>
> Best Regards,
> - Ma=C3=ADra Canal
>
> >
> >>
> >> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> >> ---
> >>  drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c        | 2 --
> >>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 6 -----=
-
> >>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h  | 2 --
> >>  3 files changed, 10 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/dr=
ivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> >> index a8db1306750e..746bb93ade6c 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> >> @@ -322,10 +322,8 @@ void dcn30_fpu_populate_dml_writeback_from_contex=
t(
> >>                                  * parameters per pipe
> >>                                  */
> >>                                 writeback_dispclk =3D dml30_CalculateW=
riteBackDISPCLK(
> >> -                                               dout_wb.wb_pixel_forma=
t,
> >>                                                 pipes[pipe_cnt].pipe.d=
est.pixel_rate_mhz,
> >>                                                 dout_wb.wb_hratio,
> >> -                                               dout_wb.wb_vratio,
> >>                                                 dout_wb.wb_htaps_luma,
> >>                                                 dout_wb.wb_vtaps_luma,
> >>                                                 dout_wb.wb_src_width,
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba=
_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> >> index 876b321b30ca..37049daaab4c 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> >> @@ -1938,10 +1938,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetc=
hParametersWatermarksAndPerforman
> >>                 if (v->WritebackEnable[k]) {
> >>                         v->WritebackDISPCLK =3D dml_max(v->WritebackDI=
SPCLK,
> >>                                 dml30_CalculateWriteBackDISPCLK(
> >> -                                               v->WritebackPixelForma=
t[k],
> >>                                                 v->PixelClock[k],
> >>                                                 v->WritebackHRatio[k],
> >> -                                               v->WritebackVRatio[k],
> >>                                                 v->WritebackHTaps[k],
> >>                                                 v->WritebackVTaps[k],
> >>                                                 v->WritebackSourceWidt=
h[k],
> >> @@ -3284,10 +3282,8 @@ static double CalculateTWait(
> >>  }
> >>
> >>  double dml30_CalculateWriteBackDISPCLK(
> >> -               enum source_format_class WritebackPixelFormat,
> >>                 double PixelClock,
> >>                 double WritebackHRatio,
> >> -               double WritebackVRatio,
> >>                 unsigned int WritebackHTaps,
> >>                 unsigned int WritebackVTaps,
> >>                 long   WritebackSourceWidth,
> >> @@ -3794,10 +3790,8 @@ void dml30_ModeSupportAndSystemConfigurationFul=
l(struct display_mode_lib *mode_l
> >>                 if (v->WritebackEnable[k] =3D=3D true) {
> >>                         v->WritebackRequiredDISPCLK =3D dml_max(v->Wri=
tebackRequiredDISPCLK,
> >>                                         dml30_CalculateWriteBackDISPCL=
K(
> >> -                                                       v->WritebackPi=
xelFormat[k],
> >>                                                         v->PixelClock[=
k],
> >>                                                         v->WritebackHR=
atio[k],
> >> -                                                       v->WritebackVR=
atio[k],
> >>                                                         v->WritebackHT=
aps[k],
> >>                                                         v->WritebackVT=
aps[k],
> >>                                                         v->WritebackSo=
urceWidth[k],
> >> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba=
_30.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> >> index daaf0883b84d..12c070434eee 100644
> >> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> >> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> >> @@ -29,10 +29,8 @@
> >>  void dml30_recalculate(struct display_mode_lib *mode_lib);
> >>  void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_=
lib *mode_lib);
> >>  double dml30_CalculateWriteBackDISPCLK(
> >> -               enum source_format_class WritebackPixelFormat,
> >>                 double PixelClock,
> >>                 double WritebackHRatio,
> >> -               double WritebackVRatio,
> >>                 unsigned int WritebackHTaps,
> >>                 unsigned int WritebackVTaps,
> >>                 long   WritebackSourceWidth,
> >> --
> >> 2.36.1
> >>
