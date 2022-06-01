Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67972CCA468
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 14:16:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F299F10EEA2;
	Wed,  1 Jun 2022 14:16:25 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF9F10EEA2
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 14:16:25 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id w130so2885785oig.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O8wr9nffUZC0d8LU9hyrZSGn6oN+jrs2NhZq3goO0Bw=;
 b=iNcwN8LnplODCoU+JZu1JRl6aDwWM1Lc2AuN7B2EkmYy81jGWxt1z7gs4GwsOgMWOl
 rab0QMAGwb1/JjNJLRcu6f5FOMXC7UtJ2GysoqCcpm9RRncEnx5IxJd6izpOQoiOjdLi
 tuvuPvp+iiKSg+rHVZTrC5Ieuity7g/2DuwNvRe6n5oVo6t5YeRi6IiuMlaMf2VXNfGb
 Gr1/P/x9J/bG9yterBCnU9EelOUEY7Ix+rZA7HAeKWusFwVltEkBJdB653sH5hnMQ1oZ
 fdj8ri77coFs7GmEGIhasRntmbw7FMnJUhZtS3o0K0xtz4RtnFB3OOysrR1jTSqy9P0O
 b8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O8wr9nffUZC0d8LU9hyrZSGn6oN+jrs2NhZq3goO0Bw=;
 b=q1qtzbiSl2k8rVcmk6jk6xtjaTfz8NyjZhNiIL9FLjg+enuLcTA5cjGZC5TLn8ahCV
 IO0pF1DE+DEWvCrDKUHeB8lFFcXreZghbVchw4tHqXgUzJkicibFb2DV/romWUqWcEFH
 UfDWlYbQolbHYOenSFEllOdSuemyv1GCLwZ65K7gqXs1dX1O7btPEy1lzSE+hbBD/tcg
 55JaedGws58o6vZRT6p1snaT8ypx+Sc2Ej5vUq2d/4xpMQ2RgV2W6kZx34EgKIaoE0Mq
 da782RCr7s02R3+2j5iDS7SR38fvDshDD2Eql63dcgBdF4iURUE8moaMGGGAAKXK4esA
 Pr5A==
X-Gm-Message-State: AOAM531hZzW9IWXRvblCe0Rvj0o6VcpvUCXg0Aa2R0tV3QpdZ5VXjOwx
 y2l9sp0exBTWM8CmwgkEBQEDDLoP+uPQaky7GmDjGL8v
X-Google-Smtp-Source: ABdhPJyU2tkvLV+buzC62neI5GicWuAq+j9rTGB65wgqOdFXMViWqdm8nU3tS4ACBhMtFcBeiPte4ExChuze7/zMSFc=
X-Received: by 2002:a05:6808:114f:b0:32b:1be0:2316 with SMTP id
 u15-20020a056808114f00b0032b1be02316mr14692036oiu.200.1654092984556; Wed, 01
 Jun 2022 07:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220601072732.2773139-1-zhenguo.yin@amd.com>
In-Reply-To: <20220601072732.2773139-1-zhenguo.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 Jun 2022 10:16:13 -0400
Message-ID: <CADnq5_Nm-Hgk7oua0Qqbj6Cn0JkwgLe5NP-hZDwu4JG16J-bgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix scratch register access method in SRIOV
To: ZhenGuo Yin <zhenguo.yin@amd.com>
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
Cc: Jingwen Chen <jingwen.chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jun 1, 2022 at 3:27 AM ZhenGuo Yin <zhenguo.yin@amd.com> wrote:
>
> The scratch register should be accessed through MMIO instead of RLCG
> in SRIOV, since it being used in RLCG register access function.
>
> Fixes: 0e1314781b9c("drm/amdgpu: nuke dynamic gfx scratch reg allocation")

Missing your signed-off-by.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index c5f46d264b23..8331e0c5e18e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3784,7 +3784,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>         unsigned i;
>         int r;
>
> -       WREG32_SOC15(GC, 0, mmSCRATCH_REG0, 0xCAFEDEAD);
> +       WREG32(SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0), 0xCAFEDEAD);
>         r = amdgpu_ring_alloc(ring, 3);
>         if (r) {
>                 DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
> @@ -3799,7 +3799,7 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
>         amdgpu_ring_commit(ring);
>
>         for (i = 0; i < adev->usec_timeout; i++) {
> -               tmp = RREG32_SOC15(GC, 0, mmSCRATCH_REG0);
> +               tmp = RREG32(SOC15_REG_OFFSET(GC, 0, mmSCRATCH_REG0));
>                 if (tmp == 0xDEADBEEF)
>                         break;
>                 if (amdgpu_emu_mode == 1)
> --
> 2.35.1
>
