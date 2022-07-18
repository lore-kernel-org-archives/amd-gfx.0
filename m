Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16FFC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 19:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CFE10F313;
	Mon, 18 Jul 2022 19:02:55 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B4910F313
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 19:02:53 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id z23so23027540eju.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 12:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5eZUjMBlv+MHYtkWtM00Fh2DEyY+EQOvDm4200JOmkc=;
 b=QUNSfxy+Cb5amV/eOl1pSDwfWLs7tXgKRh9KTBSQ5AZzkYGjCQ0trWoeeOm+GhZFG2
 Yvpz7/c9SzxH/gtw+ckQjPwhHlPgyact+idm7tj5XUJnqHkWShCGnTgAXjxUrkI6m0Ca
 5OOcm0KMZbRafk3RUCKmf7KoQDrvxxnYl6LvGaWh5wmoLFCuYwhHqDXk6RKdLksG8KQJ
 9dTP6VARVBnWD83LHsQnizjFJQt0lJOY2FYrssWyDkLU4qWkwm+O/FIuXd6ktR8ibp10
 cZjeyZzlpWQ3fuhQz6sD90mtjLt9DsAdHAqeO9nsM0NXkRcgfT4MVHyLBHJNmmtmPiL0
 SieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5eZUjMBlv+MHYtkWtM00Fh2DEyY+EQOvDm4200JOmkc=;
 b=Cc+yiaGm4rABYrx1Sis6dSUccASbmwGhbUk7r213WNyQDeR+P9uEnIqGLT5FDxxWgy
 FOcHMAvDsJelSy1/3FgP9/OES8RraHQ6Z1iDql13aZ/t0WZnX8WAikAkeiZSE36pSAEc
 W1O4tVwTh09MHFGzKjmhkbRoStkB/MueUQ/HU0Yv5YxoEeL2lM57c5FuIAxmsETUUleq
 r6uoyj1B1Lq3tbMCRqVzBh7Tm+7VuJCDT58+gpBlbyL/S6NgpSPe54FZXGYVnc5ycGFs
 HZnOIMANP9mmd86LzbY6IKtaKttlQCr4X/hZh2UcPl9A3TtaGqjhYI+9vM/p/OVz32o+
 tLoA==
X-Gm-Message-State: AJIora8a8GA/mmcp7MRVFr/N1WOqytfviHTpZmfP6bXldMOQwn5FODsV
 ht5eSOM/zZ7Z6odxBNWqj6E5FMN/CHhzLeM/qrE=
X-Google-Smtp-Source: AGRyM1vb0994V4n0N4nVQ5zZ3Q+6sY9BLaheAKz+lLSpF84KnxgMo3VEQgstLOpF3Z9pm7TKpvgWJOla7v7oPlmIhaY=
X-Received: by 2002:a17:906:9751:b0:72f:1b36:e1de with SMTP id
 o17-20020a170906975100b0072f1b36e1demr10911090ejy.451.1658170971881; Mon, 18
 Jul 2022 12:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-10-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-10-mairacanal@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Jul 2022 15:02:40 -0400
Message-ID: <CADnq5_Ot2ecb=D7M2fznBWuZiC-OwPPAnfPfwFXbnrWcevAtzA@mail.gmail.com>
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

On Thu, Jul 14, 2022 at 12:46 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> The parameters WritebackPixelFormat and WritebackVRatio are removed as
> they are not used on the function dml30_CalculateWriteBackDISPCLK.

Maybe this is done for consistency with other dml code for other DCN blocks=
?

Alex

>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c        | 2 --
>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c  | 6 ------
>  .../gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h  | 2 --
>  3 files changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> index a8db1306750e..746bb93ade6c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> @@ -322,10 +322,8 @@ void dcn30_fpu_populate_dml_writeback_from_context(
>                                  * parameters per pipe
>                                  */
>                                 writeback_dispclk =3D dml30_CalculateWrit=
eBackDISPCLK(
> -                                               dout_wb.wb_pixel_format,
>                                                 pipes[pipe_cnt].pipe.dest=
.pixel_rate_mhz,
>                                                 dout_wb.wb_hratio,
> -                                               dout_wb.wb_vratio,
>                                                 dout_wb.wb_htaps_luma,
>                                                 dout_wb.wb_vtaps_luma,
>                                                 dout_wb.wb_src_width,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index 876b321b30ca..37049daaab4c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -1938,10 +1938,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchPa=
rametersWatermarksAndPerforman
>                 if (v->WritebackEnable[k]) {
>                         v->WritebackDISPCLK =3D dml_max(v->WritebackDISPC=
LK,
>                                 dml30_CalculateWriteBackDISPCLK(
> -                                               v->WritebackPixelFormat[k=
],
>                                                 v->PixelClock[k],
>                                                 v->WritebackHRatio[k],
> -                                               v->WritebackVRatio[k],
>                                                 v->WritebackHTaps[k],
>                                                 v->WritebackVTaps[k],
>                                                 v->WritebackSourceWidth[k=
],
> @@ -3284,10 +3282,8 @@ static double CalculateTWait(
>  }
>
>  double dml30_CalculateWriteBackDISPCLK(
> -               enum source_format_class WritebackPixelFormat,
>                 double PixelClock,
>                 double WritebackHRatio,
> -               double WritebackVRatio,
>                 unsigned int WritebackHTaps,
>                 unsigned int WritebackVTaps,
>                 long   WritebackSourceWidth,
> @@ -3794,10 +3790,8 @@ void dml30_ModeSupportAndSystemConfigurationFull(s=
truct display_mode_lib *mode_l
>                 if (v->WritebackEnable[k] =3D=3D true) {
>                         v->WritebackRequiredDISPCLK =3D dml_max(v->Writeb=
ackRequiredDISPCLK,
>                                         dml30_CalculateWriteBackDISPCLK(
> -                                                       v->WritebackPixel=
Format[k],
>                                                         v->PixelClock[k],
>                                                         v->WritebackHRati=
o[k],
> -                                                       v->WritebackVRati=
o[k],
>                                                         v->WritebackHTaps=
[k],
>                                                         v->WritebackVTaps=
[k],
>                                                         v->WritebackSourc=
eWidth[k],
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30=
.h b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> index daaf0883b84d..12c070434eee 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.h
> @@ -29,10 +29,8 @@
>  void dml30_recalculate(struct display_mode_lib *mode_lib);
>  void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib=
 *mode_lib);
>  double dml30_CalculateWriteBackDISPCLK(
> -               enum source_format_class WritebackPixelFormat,
>                 double PixelClock,
>                 double WritebackHRatio,
> -               double WritebackVRatio,
>                 unsigned int WritebackHTaps,
>                 unsigned int WritebackVTaps,
>                 long   WritebackSourceWidth,
> --
> 2.36.1
>
