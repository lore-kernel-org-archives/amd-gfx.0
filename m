Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEB4C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 14:35:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D624010ED32;
	Fri, 30 Sep 2022 14:35:55 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 595E410ED34
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 14:35:52 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1280590722dso5679600fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Sep 2022 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=kkPJ64cgf+FCFlNWU0OIWrKzbwQpBg0/nR7/eKGFRf8=;
 b=noiangsmvAbv09GghmUEIalbqwU0qITvM4RT4YKQuPZvtMiCkhW/7b72hiyCuWvz2i
 krxRvfxfM2WlQ0Ciq9+ALNjTiMP6Upp9N4nyN06keqSxXOB5GvYOPPnIJCIKbBMw7VWr
 tQB+4sgGcvjZvMENSwuBtpcmDiNABNmqzqLa6iFc5TPGvHER0mwtNIVrM7MMc9sLHPH6
 DjcF/X75eTL4lo6MXbMFtPNyUCq0lZ2AQhvc4VdlqPGj3XN4RHTZeuynVdtqnpIJvSdm
 JpizsK0gtDrdaGyW5KhJH9nb72wsMKyFxIPkkH7HAHrires/SBkP+9/5WqCF9SKeNBhC
 8fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=kkPJ64cgf+FCFlNWU0OIWrKzbwQpBg0/nR7/eKGFRf8=;
 b=YuK/Uf+qle/lEqEd3HUj7YQTN/CIzZeeorD4jES2rFBCqTPrB0jKEU7LRjqT9IVAwH
 bF1GYmZ+WXwqiYF32uM0TqxXb51vpOvVoh41zHpdg4/jZRBH8BIZs91IcElv2hFHyBrd
 hwIxgPddpLqJYHF3rkiAFY2xqgPSrIh2Tfb/ZFUN7M+cM3iJf86PJQQfMjDExBN2iK6R
 /QqeUz8CzYDt0bMaAJhqw6fRNCd7Utu6ckpAk9Ca8guF5voQI6VuOlpJ3nPGbTo19S2a
 aBTKsAJXLKqjrCOaD4WqEc8ZzxB4RtszWs+kbxfHuoh+6E9/BTdmwBb7MmR5bUJxds+W
 B7fg==
X-Gm-Message-State: ACrzQf2uFVfqMxb6tcZiX47UlzqqFuntKrsQYyEtzIKKjyXX65m+Q20q
 byeYgBjZn3vkXYrIFo96sSaWhU3W3lgBedn7555OfZFx
X-Google-Smtp-Source: AMsMyM5WXYxKeKCQCn+QN2AAGxW4e8BNvmNInDCZGBxf51BaEhJWEKDI5xtAEpDoPR/hHpqpmym6XgBg5hTk2dJ3av4=
X-Received: by 2002:a05:6870:c5a4:b0:131:6edd:3955 with SMTP id
 ba36-20020a056870c5a400b001316edd3955mr5043804oab.96.1664548551529; Fri, 30
 Sep 2022 07:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220930061634.1531705-1-yifan1.zhang@amd.com>
 <20220930061634.1531705-2-yifan1.zhang@amd.com>
In-Reply-To: <20220930061634.1531705-2-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Sep 2022 10:35:39 -0400
Message-ID: <CADnq5_NHb65ApzNjytAOXOD39cBnCNAvY-YpHM5hEYPmcUkm1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: remove unnecessary judgement in sdma reg
 offest calculaton
To: Yifan Zhang <yifan1.zhang@amd.com>
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, ruiliji2@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Sep 30, 2022 at 2:17 AM Yifan Zhang <yifan1.zhang@amd.com> wrote:
>
> clean sdma_v6_0_get_reg_offset function.
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index db51230163c5..b2c71f533e93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -67,12 +67,10 @@ static u32 sdma_v6_0_get_reg_offset(struct amdgpu_device *adev, u32 instance, u3
>         if (internal_offset >= SDMA0_HYP_DEC_REG_START &&
>             internal_offset <= SDMA0_HYP_DEC_REG_END) {
>                 base = adev->reg_offset[GC_HWIP][0][1];
> -               if (instance != 0)
> -                       internal_offset += SDMA1_HYP_DEC_REG_OFFSET * instance;
> +               internal_offset += SDMA1_HYP_DEC_REG_OFFSET * instance;
>         } else {
>                 base = adev->reg_offset[GC_HWIP][0][0];
> -               if (instance == 1)
> -                       internal_offset += SDMA1_REG_OFFSET;
> +               internal_offset += SDMA1_REG_OFFSET * instance;
>         }
>
>         return base + internal_offset;
> --
> 2.37.3
>
