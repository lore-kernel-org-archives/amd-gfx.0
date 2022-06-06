Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2222C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 18:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EBB211BDBD;
	Mon,  6 Jun 2022 18:40:15 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 209AA11BDBC
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 18:40:14 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-f33f0f5b1dso20179703fac.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jun 2022 11:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Uc2hkTFdKpdgT7FiQgdSvMsPRktNGVpWl55w0UpQ3RA=;
 b=JOLWkS7fdqLSK+nWcm5ck6ohcHRJeogBIPgdC2c4UzZaxuiarOvtH/moBcwzFapI6L
 aOCHYxqKNMkXG2tUi0eUQioUISHwCd9rAYhvX2uo/ZKZNPyB6YqOirC+qLTo2ZQaHlLv
 JNsrVw3Bsy1g2jvDPKVUETL28CFzlk2ztRe0I8x4ulvHEREVccJhM+BRDObggKXmUNIG
 p+76keJRiJAsPj1qbL9tm1K/Dta+f87RngpY0Efq++7t0NNiuDR0MDneBi7NwPx3CN1J
 tUCqZ2shYt4DJj8MwBhdQDj+84CtS3ZFC1Hn6u+v4qbzvzgV7ZuFCbVv4wOthmURj62Y
 9VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Uc2hkTFdKpdgT7FiQgdSvMsPRktNGVpWl55w0UpQ3RA=;
 b=0OLyvERV33PgqajWes9l3wM3vRngotn0wQPgB6xfeMcDSuD01jTiZXbNgTYJ7PLS51
 vocqgmGzmobOu/q/PHQqhDMXhF/FXNM0BWAQR5kRNj1+JzCFcMsDQxrSZM5/P6yxjB9v
 8MvRG3lV27NFMK4BNsDCuDjo+4VYvAarVbUNAejUyrAcTAIzKitRMBwjbS/+WKYufA21
 hvd/ACptZ+3UYRJC6on4WbKr7eOzvI3QavwZRznTROVBQJycrdNkY+wCvDZVuTBtWJvK
 FUA9tSQ9E+HeeCt9trJm79kukyygNYzZniWcDKyp5mYkbqeqagiK2qpc1zk10ccrms+P
 GFFA==
X-Gm-Message-State: AOAM530X37wjNXmcdKwbNtoRleMbjWAlr4VomsGqPmaU8w6tykX/fzis
 5a9Bm1ItULAbEbpDo0LzHlACj5qt+5bUVcbsIQGjeihx
X-Google-Smtp-Source: ABdhPJxF0ZeLmxeMrFIk9lQpQzdDOCFwWeyQkpAWUcKlY5rFxKvpolN+/H17/8dn7Y8BB3cXjzhRXHQAJHMPF2Shavc=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr14516090oap.253.1654540813365; Mon, 06
 Jun 2022 11:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220525020926.1951685-1-alexander.deucher@amd.com>
 <20220525020926.1951685-3-alexander.deucher@amd.com>
In-Reply-To: <20220525020926.1951685-3-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jun 2022 14:40:02 -0400
Message-ID: <CADnq5_OcqxGKYYfOXVoH4so3Wqa2R3TSTARXb7+-8SCJEq7p=A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: simplify amdgpu_ucode_get_load_type()
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

Alex

On Tue, May 24, 2022 at 10:09 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> This is the same as the default case, so drop the extra
> logic.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index ffa4c0d207db..c312577df596 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -486,26 +486,6 @@ amdgpu_ucode_get_load_type(struct amdgpu_device *adev, int load_type)
>         case CHIP_POLARIS12:
>         case CHIP_VEGAM:
>                 return AMDGPU_FW_LOAD_SMU;
> -       case CHIP_VEGA10:
> -       case CHIP_RAVEN:
> -       case CHIP_VEGA12:
> -       case CHIP_VEGA20:
> -       case CHIP_ARCTURUS:
> -       case CHIP_RENOIR:
> -       case CHIP_NAVI10:
> -       case CHIP_NAVI14:
> -       case CHIP_NAVI12:
> -       case CHIP_SIENNA_CICHLID:
> -       case CHIP_NAVY_FLOUNDER:
> -       case CHIP_VANGOGH:
> -       case CHIP_DIMGREY_CAVEFISH:
> -       case CHIP_ALDEBARAN:
> -       case CHIP_BEIGE_GOBY:
> -       case CHIP_YELLOW_CARP:
> -               if (!load_type)
> -                       return AMDGPU_FW_LOAD_DIRECT;
> -               else
> -                       return AMDGPU_FW_LOAD_PSP;
>         case CHIP_CYAN_SKILLFISH:
>                 if (!(load_type &&
>                       adev->apu_flags & AMD_APU_IS_CYAN_SKILLFISH2))
> --
> 2.35.3
>
