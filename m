Return-Path: <SRS0=WaPU=7J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8E3C433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 20:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67466204EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2020 20:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEkflJv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67466204EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23FEE88EF2;
	Wed, 27 May 2020 20:29:43 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAEDA88EF2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 20:29:42 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id x14so20141090wrp.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2020 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dwXDn8Toi8QU//epVrMXDPIpsvlB3FDuLk3PYHd8/X8=;
 b=MEkflJv2vdYQh7xuifxvH/Ws0Gh3+PP4bNZD8qpiWTrOr50EwBDwrYCd3N67W/Wm0r
 H7+VzqFyB/U1nq1EqRPC/aLVQYqpsi6l6xIyfBpYwK0n9nkAyJOpHz4OQhK4scqoEuhO
 NQFogdRqzVbdivqfttZkAxPvFngdPRF6xKOgtCEPY7G4sdy7j3XFV7ExtyRuwACmSsSP
 7bwzbF691smQHtCrEDhiodZNDdxQ/yEgItUxKEpL0t1SjoLP/0ZrcrPBEKn3nKii4YhD
 gJe3uStOG4O13uHWEGQeMnsftfvPVA4KBN8uCaLHcbstSTaTmAFU0yd2rrxX4HLwnTFd
 qGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dwXDn8Toi8QU//epVrMXDPIpsvlB3FDuLk3PYHd8/X8=;
 b=Tf20Gmw/nvfqp9+jTnOhpc7u3k2SBopwuPxxqu0Xv9k3oXv9vDwYwOSNEv+oAJb0yQ
 HLcuEyl2e+mfVnJKFUswf2ucP5VAVLLmnpVy+i26MelzzV10shFuYwGQDgxU6jEzAbnh
 RIcUB2c0nmF6myyqzRs1PRzRve9kTycyAjsXggnLi4TSOKWt0Ss0tY2Cqs4OYh/aRVRt
 mMegIPWx2i5VofPw3yc0r65WXsWFtumxnMwOZ+akINLOBialyi1JeslWqxN2pCRGAeNu
 0e74GnyhC3hBWvg5KncGz6t2DRFjkpQu9WS7q+Lo/ien+sTvSbEKdjYjrC9CE95dPZSe
 pt+g==
X-Gm-Message-State: AOAM533vM9ITiSQO08FG4vvB+M3HzX6bDEXpqjPwjhEzrHahK/YKFCGj
 EIcWaDL8g1qxbIGlIh8JuMqZwzJ0GZmlw9R515BzSw==
X-Google-Smtp-Source: ABdhPJxb9I7UncxKD7/tgH4dJqLfU4EDkcfmlZDFvgVA5VgtC9rzxSnmz25YWClMpEmUN/K0fKa6KvhUguAkONzamzc=
X-Received: by 2002:a5d:6789:: with SMTP id v9mr92219wru.124.1590611381233;
 Wed, 27 May 2020 13:29:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200522221728.808568-1-alexander.deucher@amd.com>
In-Reply-To: <20200522221728.808568-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 May 2020 16:29:28 -0400
Message-ID: <CADnq5_Nr-xOhM25cApQ5m8kYkk4A_U++riJcL3bCCoJWKpANXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc10: program the smallK fragment size
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Fri, May 22, 2020 at 6:17 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Explicitly set the smallk size to 0 (4k).  This is the hw
> default, but set it anyway just in case something else
> changed it.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> index cc866c367939..6939edfc5232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -181,6 +181,10 @@ static void gfxhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
>         tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
>         tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
>         WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL4, tmp);
> +
> +       tmp = mmGCVM_L2_CNTL5_DEFAULT;
> +       tmp = REG_SET_FIELD(tmp, GCVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
> +       WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL5, tmp);
>  }
>
>  static void gfxhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index fb3f228458e5..616309e85d6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -164,6 +164,10 @@ static void mmhub_v2_0_init_cache_regs(struct amdgpu_device *adev)
>         tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
>         tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL4, VMC_TAP_PTE_REQUEST_PHYSICAL, 0);
>         WREG32_SOC15(MMHUB, 0, mmMMVM_L2_CNTL4, tmp);
> +
> +       tmp = mmMMVM_L2_CNTL5_DEFAULT;
> +       tmp = REG_SET_FIELD(tmp, MMVM_L2_CNTL5, L2_CACHE_SMALLK_FRAGMENT_SIZE, 0);
> +       WREG32_SOC15(GC, 0, mmMMVM_L2_CNTL5, tmp);
>  }
>
>  static void mmhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
