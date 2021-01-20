Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCB2C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 21:36:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBAD7235DD
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 21:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAD7235DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597E089C33;
	Wed, 20 Jan 2021 21:36:03 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1C3A89C33
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 21:36:02 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id w8so4853725oie.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 13:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Gu9aHrFdiZX9JjEWS28h1IcPWJwxUZDcQf6knkCJCyU=;
 b=sn2QNYRkUJOHDhZ+FAzvLT/+VhIj5GBC7uLZ0PSkiyhYG54mJKLlmXSsodCdJqKzH9
 sa/K4hrAX1m5z/SHcMmiRiTeHvE7bPwchm8vE3d20qlSqViXNPQxzj+gNsojIaHYn2Bj
 0SbhbL3qXnj1F4l8ZXJDwAJxs2OYMpx4A88pFr3328Y5VOO4Ng8OjU/ZUqXfY1kjl9iJ
 ujm8XsxCVEBHm0rICP+piFC/Bd7QRpwqnM0p08upyXeQLU1DpRkbp50GLu+MEmFgKnff
 Omi5qas4ngmL6Ksvup73uASQHcntjd7kOYY1R67pe632d8++3ibNR4apT1qEZpP/zbdQ
 DPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Gu9aHrFdiZX9JjEWS28h1IcPWJwxUZDcQf6knkCJCyU=;
 b=uBL88iTtBiF7Lui0uFbMhedycA9uXZ6A3SpDhREVSVQa3e0wrGuzlvIPfnKuZXsN4g
 RGYTrKBgLJEpx57fD4LYsD8ld8U556g1LXVATRH/leexatgbHtlTn5Ec18+PXul4I0PP
 YfPX8kM/wjbjLfFruLKb6+tXgjQNyyh2nEIFBSVkEVRoBu6Zm5d4x4IkIAtqpb1TXBzs
 Slz2d9U9xjVKGYzzdcAq42u4uT2oMqoUJBWamUt35dOhMKt9Q24uGh8yzoZh1PgjJr3b
 U5lHCQhePncUNaWeKlPU475G2Wzfd7EsYMOcmYHj9hJ2RXXKkPYLQhCixyJOM0zgWnLf
 v2HQ==
X-Gm-Message-State: AOAM53046uH5ucK1o71MUjHRq+6UUOr5vdnYmgoWoqpV0HG88Q99UVB1
 IkKJgP1Y91BG0H5TMO4ipeP/B6EKEpfiz/gZ4Tg=
X-Google-Smtp-Source: ABdhPJydwEGcUfz0TaZNhDjrgK1X2u3kyaPmEfthNvopMzH4ml7/tVgSbzCfJwL4Fh6oX+Bla3EPuxddIVcoyuqZ32E=
X-Received: by 2002:aca:b755:: with SMTP id h82mr2947986oif.5.1611178562291;
 Wed, 20 Jan 2021 13:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20210120172306.276209-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20210120172306.276209-1-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Jan 2021 16:35:51 -0500
Message-ID: <CADnq5_M0f30Gqxz9graC=js42skS2vDKfb8eOheP5GxpNm8ebg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix unused variable warning
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 20, 2021 at 12:23 PM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> [Why]
> The dm struct is only being used if DCN config is defined and this
> causes a unused variable warning if DCN option is not set.
>
> [How]
> Remove the compile flag so the variable is used (there also seems to be
> a duplicate guard due to a bad rebase) so remove the outer guard to fix
> the warning.
>
> Fixes this warning
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c: In function 'dm_set_vblank':
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:5380:33: warning: unused variable 'dm' [-Wunused-variable]
>
> Fixes: e177af8a43da ("drm/amd/display: Fix deadlock during gpu reset v3")
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 83ec92a69cba..7c188c8eaeb1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5472,7 +5472,6 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>         if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
>                 return -EBUSY;
>
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
>         if (amdgpu_in_reset(adev))
>                 return 0;
>
> @@ -5492,7 +5491,6 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>
>         mutex_unlock(&dm->dc_lock);
>
> -#endif
>         return 0;
>  }
>
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
