Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9C3C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 18:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85BC10EBDA;
	Mon, 18 Jul 2022 18:55:35 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65D8189CA0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 18:55:34 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id sz17so22973501ejc.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 11:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kIztP35AVtY3Dcob7hWoCvvqV3w68ASQI2y6wb5SraQ=;
 b=RBl+Jgtzs8yMw7hGgLK07sQQzjRDR2jlkfoiPAfrQ7bdIBR5roZdVpOF6TP0JKUEgw
 D1APVjySG+bYk87HAgHZtPMwzxloM57fqDhnzbrKiIbD1fN+zr6ciE/glmOUT/V/05a0
 guvlG+o0NDHaAUycP+F/YfXDhbtsvGqUP1HVi4G/ZwyXU1MxD+zYyY+TUnpZ06fapJv0
 EcaQW5E0bLUgmikV7YvQL498m1fLwroFLJArVUqinpldJWcA8Zj2VEPI0dxLI3xD9anG
 UrFKXa4aJfR+B1CPx5avjPTvPdJgY8K6sLbYZJtj53AfRhyHfUJkCM7uLXgd4yfMsqiy
 5LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kIztP35AVtY3Dcob7hWoCvvqV3w68ASQI2y6wb5SraQ=;
 b=bnc0NTOP19EsVyesVHS1h/SHb9denX8O0F97QVEHmfNthzFPQQ7cmrSu2ViYkJ0G8U
 lxsGuoDF9VMFTcghXF0bAWvnjuY7RxeTA1KBB1b0RubPPViBqkhgLROdIlrsayJX+3Bx
 STfF5URvLug/GKhxzLQZ9LOu7ussCUlfDyw17Zm/Pnqq2NGcc/TYGb5KrxJgG/epihq7
 +gNPuRxAr0nVKwtmb8r5MckwMmm4Ms3CDfNS01X5CWIWswxSl6S9m0RRcCsCaeZBIeFZ
 YDn0VEsCkBXHnD9DgaMx9lJCmqr55kmOV+GPRt6wlly3NRpacxlHf+3TQGayOeAK/AXL
 2WOg==
X-Gm-Message-State: AJIora9rSU0cYdOESYMd4UA7wXtjCi6ObnP0ai1GtQyqS1P0wTnUmgBl
 Y5VS0edyKFMFy6apY45TfvklEh06Cv0KytNX2aM=
X-Google-Smtp-Source: AGRyM1vYAJVMzNxF8xuwyGfk2rC1AOsPwP3wd79f+FSLIzqPaQWQFIhAwMZ/cdRPI9PmmdhfukyY31rILgVLsvv7dgE=
X-Received: by 2002:a17:907:2702:b0:72b:307b:98e6 with SMTP id
 w2-20020a170907270200b0072b307b98e6mr27463747ejk.658.1658170532827; Mon, 18
 Jul 2022 11:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
 <20220714164507.561751-5-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-5-mairacanal@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Jul 2022 14:55:21 -0400
Message-ID: <CADnq5_M18H3J1dCxjMCdT6V=TuNhC+oySpidJEXJzL-d_dMg5A@mail.gmail.com>
Subject: Re: [PATCH 05/12] drm/amd/display: Remove unused NumberOfStates
 variable
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
> Remove the unused unsigned int NumberOfStates from the file, which was
> declared but never hooked up.
>
> This was pointed by clang with the following warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:=
33:27:
> warning: unused variable 'NumberOfStates' [-Wunused-const-variable]
> static const unsigned int NumberOfStates =3D DC__VOLTAGE_STATES;
>                           ^
> 1 warning generated.
>
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> index c6c3a9e6731a..dff8f8f27de4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> @@ -30,8 +30,6 @@
>  #include "../dml_inline_defs.h"
>  #include "display_mode_vba_util_32.h"
>
> -static const unsigned int NumberOfStates =3D DC__VOLTAGE_STATES;
> -
>  void dml32_recalculate(struct display_mode_lib *mode_lib);
>  static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndP=
erformanceCalculation(
>                 struct display_mode_lib *mode_lib);
> --
> 2.36.1
>
