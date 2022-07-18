Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A95CC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 19:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D2F510F236;
	Mon, 18 Jul 2022 19:00:49 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B7F10F1F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 19:00:47 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id mf4so23039143ejc.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 12:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VQyoH7Iz8mEpqAOd0ZONZyEq4M37QPm603w2BBFwKM8=;
 b=Z79+e/QKWsVqEovUmcQ2HznGd9tPqIiEP5LgIpEpC7EHyvSgvZ6t5FZRTRMhZHZLGN
 M9+guF5Kv6dOe9rhbQGBtAPC63QjnJON4DrsYkf13p8b2jizjEhg9uNHyiz5gCpGKUJU
 amsxg0l8FbxjkVnVVT11Bq0lf//qNSZnSSWN8xuyppw3PXiO+g58dAUHMz2tgOpHpsAE
 lKbypVyE16N+UPos58AN9XJk/jLsIjMbkPaW4ry1F/rciHBVI9ssjViIobffSlbWiB9s
 XX1KUi6qymYRQLLM/93caMa381BoDz/bJVbGqz988oAVh8T+meqjiOu53xMkXQY6j/Pz
 N1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VQyoH7Iz8mEpqAOd0ZONZyEq4M37QPm603w2BBFwKM8=;
 b=5YhZSbwSyvBE1E4QC833X3YMYyh/vryvGqxvGHqtkkvEJR+GyLcWybo7pIm/qS1z+b
 XHbmUyMRtaugh+syMyofyxMzoc4uYwR0Hr0H3CpvxeBkSvXg1I9akx9n6AHA+5IdTOtA
 Da0rc5aGryiHRJMPg/a0nt59z4z+hYr7mitYY5TidUpN2j3Se49J7Bs9SaRKLu6BZTke
 5MK/D8p3kpR6qH63+ZeED2esV6uhFp+G5pVoIgBkfAMmjTIlUWWH1UO6CkJ/6mbh3rZ/
 lP2/JK3OffVulqqwODsGbMYx2E8DtaFlebLfIr7wx1tcC+y4bYhJuirVYnicIG8u1paZ
 LjSg==
X-Gm-Message-State: AJIora8JvdUEzWiHiubtNPOAG+2HE3PylBX3+iFv0rv0lVh+GbsZ3xc+
 2hgrwf9NQSrZPM+/qPmbW8BSc0pAnab7gzTMD6U=
X-Google-Smtp-Source: AGRyM1sAm0ceprBeNasxCBhGobuk2pQl9XbeaWeQmikg9R40pJTUHYeb+giTHB2g6CW/mQzFSVkhhZ9LsDrrgRr3LwU=
X-Received: by 2002:a17:907:2702:b0:72b:307b:98e6 with SMTP id
 w2-20020a170907270200b0072b307b98e6mr27482559ejk.658.1658170845590; Mon, 18
 Jul 2022 12:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-9-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-9-mairacanal@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Jul 2022 15:00:34 -0400
Message-ID: <CADnq5_MYHR256zeDaGpbs9=ax9LqmThWeZ0Ld4_YUfNeDMwuqw@mail.gmail.com>
Subject: Re: [PATCH 09/12] drm/amd/display: Remove unused MaxUsedBW variable
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

Applied.  Thanks!

Alex

On Thu, Jul 14, 2022 at 12:46 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> Remove the variable MaxUsedBW from the function
> DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCal=
culation.
> As a side-effect, the variables MaxPerPlaneVActiveWRBandwidth and
> WRBandwidth are also removed.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:=
3043:10:
> warning: variable 'MaxUsedBW' set but not used [-Wunused-but-set-variable=
]
>                 double MaxUsedBW =3D 0;
>                        ^
> 1 warning generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  .../dc/dml/dcn30/display_mode_vba_30.c        | 28 -------------------
>  1 file changed, 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> index 842eb94ebe04..876b321b30ca 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
> @@ -3037,40 +3037,12 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchP=
arametersWatermarksAndPerforman
>
>         {
>                 //Maximum Bandwidth Used
> -               double TotalWRBandwidth =3D 0;
> -               double MaxPerPlaneVActiveWRBandwidth =3D 0;
> -               double WRBandwidth =3D 0;
> -               double MaxUsedBW =3D 0;
> -               for (k =3D 0; k < v->NumberOfActivePlanes; ++k) {
> -                       if (v->WritebackEnable[k] =3D=3D true
> -                                       && v->WritebackPixelFormat[k] =3D=
=3D dm_444_32) {
> -                               WRBandwidth =3D v->WritebackDestinationWi=
dth[k] * v->WritebackDestinationHeight[k]
> -                                               / (v->HTotal[k] * v->Writ=
ebackSourceHeight[k] / v->PixelClock[k]) * 4;
> -                       } else if (v->WritebackEnable[k] =3D=3D true) {
> -                               WRBandwidth =3D v->WritebackDestinationWi=
dth[k] * v->WritebackDestinationHeight[k]
> -                                               / (v->HTotal[k] * v->Writ=
ebackSourceHeight[k] / v->PixelClock[k]) * 8;
> -                       }
> -                       TotalWRBandwidth =3D TotalWRBandwidth + WRBandwid=
th;
> -                       MaxPerPlaneVActiveWRBandwidth =3D dml_max(MaxPerP=
laneVActiveWRBandwidth, WRBandwidth);
> -               }
> -
>                 v->TotalDataReadBandwidth =3D 0;
>                 for (k =3D 0; k < v->NumberOfActivePlanes; ++k) {
>                         v->TotalDataReadBandwidth =3D v->TotalDataReadBan=
dwidth
>                                         + v->ReadBandwidthPlaneLuma[k]
>                                         + v->ReadBandwidthPlaneChroma[k];
>                 }
> -
> -               {
> -                       double MaxPerPlaneVActiveRDBandwidth =3D 0;
> -                       for (k =3D 0; k < v->NumberOfActivePlanes; ++k) {
> -                               MaxPerPlaneVActiveRDBandwidth =3D dml_max=
(MaxPerPlaneVActiveRDBandwidth,
> -                                               v->ReadBandwidthPlaneLuma=
[k] + v->ReadBandwidthPlaneChroma[k]);
> -
> -                       }
> -               }
> -
> -               MaxUsedBW =3D MaxTotalRDBandwidth + TotalWRBandwidth;
>         }
>
>         // VStartup Margin
> --
> 2.36.1
>
