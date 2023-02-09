Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAFFC05027
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Feb 2023 04:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7138B10E8FA;
	Thu,  9 Feb 2023 04:25:36 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 852CF10E8FA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Feb 2023 04:25:34 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-16ab8581837so1060233fac.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Feb 2023 20:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A915+ev5DSHuNQFFCX2ACfQke89hBXz2iTFS3TXzsKk=;
 b=HgqOriZfRdrRVQjEO8tDDS6KvptWU1/Q9ax5nJSFyyMoxrk6S6j9sELSraQU1vYWWG
 Kd3AhWb+cFZeiEiPHMXgLrnuzcjKWfBHiJaegZ1UtsusgwUEldaF3It4rzGDQDF7nyvI
 dA7Fd0PQSsh8LnU+UAnAvrXr7CUAMxx1xFLT0AW9TiyxWtbuNxgB/loe9SeNYAR4qnb8
 RKV00s3M61sG7gO6qhIIo4T8Pva4JVSmcqpm5p5uRzFtjZNI8l6jElgiOOb2z7AuiTnz
 5kXEKdcOOm0AYp3yIrjPBY+4WWAYQ+gyGwpboQT895UdNkdbXqxbhwapuFTwec1TE1uM
 jWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A915+ev5DSHuNQFFCX2ACfQke89hBXz2iTFS3TXzsKk=;
 b=ElgAJgzbPC0R0I7X+oug2T2Z5hpwdvw47+FxmleeiVh+Tu/PaFGZOmLRcr9+zjQ82b
 mxO0rZjdZz8g35z+Wun8CnV0zGBHuZluGLwGRKVeH0qc4cjEYSBAxMVjcWq/BxER343V
 Wug3H8tyZMpL/DhUWjAS+2pL8BFkLtJKXu88T8syAFfU28FUqnHfd9Bmtzx4yX/fxdbz
 wV0/tDut/u3kxlEDzRYTYiPZ/Mrt/i3cXkex9uII4HocIvCzXSG8NFTKDkvJiQYu/qyJ
 xVdQ2vY9LS5XEokWNcxpS1yjtQHuEB2VM6U8de98bFHiYeF53mp3n/qe+r8f1oVAiaOs
 pTNg==
X-Gm-Message-State: AO0yUKXSSDpAkwINKaidRSeX3Eq7dqrW0cXdxx2ZuJUKj8CocqX0aher
 EFRfY9hqHtPkpqg6IS68p0d9ogTNI9Y/86wsQi4=
X-Google-Smtp-Source: AK7set/iYze0C8zzxq++E6KiKMwz0IhodVbxxhP6KDHiljWcjM+nf8YGTo7o0w6n8hVRuouQQZ16j3OIFZPVhN5m2TU=
X-Received: by 2002:a05:6871:29c:b0:163:8cc6:86a with SMTP id
 i28-20020a056871029c00b001638cc6086amr848276oae.46.1675916733562; Wed, 08 Feb
 2023 20:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20230208212404.2656017-1-alexander.deucher@amd.com>
 <BN9PR12MB5257E2BFD7F039156ECC1F55FCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257E2BFD7F039156ECC1F55FCD99@BN9PR12MB5257.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Feb 2023 23:25:22 -0500
Message-ID: <CADnq5_OWm735ow+is5fay++u=RYS5UZw_3yRXGCpwRbYXb6mLA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc11: disable AGP aperture again
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Actually, nevermind, I found the bug.  New patch on the way.

Alex

On Wed, Feb 8, 2023 at 9:52 PM Zhang, Hawking <Hawking.Zhang@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
>
> Regards,
> Hawking
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Thursday, February 9, 2023 05:24
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/gmc11: disable AGP aperture again
>
> It seems not all of the issues with SDMA firmware have been resolved leading to spurious GPU page faults on some variants.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c  | 7 +++----
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c    | 1 -
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c   | 7 +++----
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c | 5 +++--  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c | 6 +++---
>  5 files changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> index 7c069010ca9a..fa42d1907dfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
> @@ -151,11 +151,10 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)  {
>         uint64_t value;
>
> -       /* Program the AGP BAR */
> +       /* Disable AGP. */
>         WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
> -       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> -       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
> -
> +       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
> +       WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, 0x00FFFFFF);
>
>         /* Program the system aperture low logical page number. */
>         WREG32_SOC15(GC, 0, regGCMC_VM_SYSTEM_APERTURE_LOW_ADDR,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 0a31a341aa43..5e0018fe7e7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -673,7 +673,6 @@ static void gmc_v11_0_vram_gtt_location(struct amdgpu_device *adev,
>
>         amdgpu_gmc_vram_location(adev, &adev->gmc, base);
>         amdgpu_gmc_gart_location(adev, mc);
> -       amdgpu_gmc_agp_location(adev, mc);
>
>         /* base offset of vram pages */
>         if (amdgpu_sriov_vf(adev))
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> index 923fc09bc8fc..ae9cd1a4cfee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> @@ -177,11 +177,10 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>          * these regs, and they will be programed at host.
>          * so skip programing these regs.
>          */
> -       /* Program the AGP BAR */
> +       /* Disable AGP. */
>         WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
> -       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> -       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
> -
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
>         /* Program the system aperture low logical page number. */
>         WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
>                      adev->gmc.vram_start >> 18);
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> index c8d478f2afdc..fb2f0eb72f69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
> @@ -173,8 +173,9 @@ static void mmhub_v3_0_1_init_system_aperture_regs(struct amdgpu_device *adev)
>
>         /* Program the AGP BAR */
>         WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
> -       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> -       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
> +
>
>         /*
>          * the new L1 policy will block SRIOV guest from writing diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> index 51580302ec42..c30e40e52fb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
> @@ -162,10 +162,10 @@ static void mmhub_v3_0_2_init_system_aperture_regs(struct amdgpu_device *adev)
>         uint64_t value;
>         uint32_t tmp;
>
> -       /* Program the AGP BAR */
> +       /* Disable AGP. */
>         WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
> -       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> -       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
>
>         if (!amdgpu_sriov_vf(adev)) {
>                 /*
> --
> 2.39.1
>
