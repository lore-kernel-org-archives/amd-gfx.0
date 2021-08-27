Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EB3C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 04:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8E560F92
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 04:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3C8E560F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1666E049;
	Fri, 27 Aug 2021 04:57:48 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EDC96E049
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 04:57:48 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 b5-20020a4ac285000000b0029038344c3dso1636196ooq.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 21:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ROu48dQssFUZ7gCfgTGtFIzofd1VEgpKkGbmLSvyV/E=;
 b=BnulUxK4T1MTzE/zFaGJ9120HdrkDJZT4s92OKt0xyB17lfcpQO5m7EbSilfsEQUi6
 r4kG53s7mc5617N0EFtoMnEk71mppX1cSXUQ31qNcAUuWYb0PVziUzk7d82bczTpE1rR
 opraZ8bGLxhfsy3DOgBSGaMdFCBvc0mKkoJyeR0y1aUUbtrR8VJNYijlgzFylQUrsI+T
 Ebn/3nYW63Si+G+aSNpPqf1JhkxM67542M+AiLatxYmp2lRhDAO2x0RhyHhDelBnupck
 PVpJAt1kS38CPN314U35c+6rB37OzrjYYv6s68DCSffK/uYBcMc/mCgKE9uYFcClcjFY
 73GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ROu48dQssFUZ7gCfgTGtFIzofd1VEgpKkGbmLSvyV/E=;
 b=NZ2fJc6SHVukz0cS8xu7Ony1xBY3SOuMpZngDrKYNOgF7cExBeTUY2t/J7c0D9CRKj
 xufgcYfjTuk+mlRLzzqteLS96cfspE0QSwdAs3JJKVsjRYfTKkOqjwAeqLNyqpXUUAw8
 XKT6N6NF8BrGP/Qj5hi+ZKg+23h+OYW0UVr4thbqUME2uZIhOy4Np/yLUpxPKRIEBn9H
 DGTonHa/mYrDa4IIgaXPMW4CwpZUJZMNN9npOsz3WS5Knb9AWVTNUl9y38Wqy3xvn9hc
 eL2zhQl5VDCXlLtuT91Ea7xxiP1iAbolnFMx35xxPqEIPrz6z/iGNHtgS1140Nz4aZk4
 B+Gw==
X-Gm-Message-State: AOAM531jegH/98Ex5jd9ECXt0HAO1OfQ72uZMPNdsAM2A3rwCA+3833U
 tZTlymR5rxoHmBNL1ktaYtorI7mVw/J5G/qkRDI=
X-Google-Smtp-Source: ABdhPJyFA8ohvf+5fy1rX1AnlpoDj5YG1zUc7IAYBOgMR76OGTwoqz2DIQssLlJ/w+i3cgOfuyOdkB0Gps4PHsBikfs=
X-Received: by 2002:a4a:4484:: with SMTP id o126mr6008154ooa.90.1630040267751; 
 Thu, 26 Aug 2021 21:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210826180754.3193315-1-rajib.mahapatra@amd.com>
 <BL1PR12MB5144C0F1425B8CE8B11BC093F7C79@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BL1PR12MB53034286ED2BA36EC616C422F2C89@BL1PR12MB5303.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB53034286ED2BA36EC616C422F2C89@BL1PR12MB5303.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 27 Aug 2021 00:57:36 -0400
Message-ID: <CADnq5_MDmamdma-OS0evAVgDK953L3YbH1ApHCF4_fwqyUOw+g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Set the domain as GTT when VRAM size <=
 32 MB
To: "Mahapatra, Rajib" <Rajib.Mahapatra@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>, "Wu,
 Hersen" <hersenxs.wu@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 27, 2021 at 12:38 AM Mahapatra, Rajib
<Rajib.Mahapatra@amd.com> wrote:
>
> [Public]
>
>
>
> Thanks Alex for your reply.
>
> The patch is not fixing our issue.
>

What exactly is going wrong?  I don't see what this patch fixes.
amdgpu_display_supported_domains() already sets domain to
AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT if the asic can support
display from system memory and the buffer is suitable for display.  If
amdgpu_display_supported_domains() only returns
AMDGPU_GEM_DOMAIN_VRAM, then you shouldn't be adding
AMDGPU_GEM_DOMAIN_GTT because the buffer is not suitable for display
for some reason.  If you force AMDGPU_GEM_DOMAIN_GTT in this case, you
will get hangs on most chips.

Alex

>
>
> Thanks
>
> -Rajib
>
>
>
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Thursday, August 26, 2021 11:48 PM
> To: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/display: Set the domain as GTT when VRAM size <= 32 MB
>
>
>
> [Public]
>
>
>
> I think this may have already been fixed with this patch:
>
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/2a7b9a8437130fd328001f4edfac8eec98dfe298
>
>
>
> Alex
>
>
>
> ________________________________
>
> From: Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
> Sent: Thursday, August 26, 2021 2:07 PM
> To: Wentland, Harry <Harry.Wentland@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Mahapatra, Rajib <Rajib.Mahapatra@amd.com>
> Subject: [PATCH] drm/amd/display: Set the domain as GTT when VRAM size <= 32 MB
>
>
>
> [Why]
> In lower carve out (<= 32 MB) devices, it was unable to pin framebuffer in
> VRAM domain for some BO allocations. The device shows below error logs and
> sometimes it reboots too.
>
> amdgpu 0000:02:00.0: amdgpu: 00000000d721431c pin failed
> [drm:dm_plane_helper_prepare_fb] *ERROR* Failed to pin framebuffer with error -12
>
> [How]
> Place the domain as GTT when VRAM size <= 32 MB.
>
> Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index dc3c6b3a00e5..d719be448eec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -236,6 +236,7 @@ extern int amdgpu_num_kcq;
>
>  #define AMDGPU_VM_MAX_NUM_CTX                   4096
>  #define AMDGPU_SG_THRESHOLD                     (256*1024*1024)
> +#define AMDGPU_VRAM_MIN_THRESHOLD              (32*1024*1024)
>  #define AMDGPU_DEFAULT_GTT_SIZE_MB              3072ULL /* 3GB by default */
>  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS          3000
>  #define AMDGPU_MAX_USEC_TIMEOUT                 100000  /* 100 ms */
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e1e57e7465a7..f71391599be1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7106,8 +7106,16 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>                  return r;
>          }
>
> -       if (plane->type != DRM_PLANE_TYPE_CURSOR)
> +       if (plane->type != DRM_PLANE_TYPE_CURSOR) {
>                  domain = amdgpu_display_supported_domains(adev, rbo->flags);
> +               /*
> +                * Handle devices with lower carve out.
> +                */
> +               if (adev->gmc.real_vram_size <= AMDGPU_VRAM_MIN_THRESHOLD) {
> +                       domain |= (domain & AMDGPU_GEM_DOMAIN_GTT) ? domain :
> +                                  AMDGPU_GEM_DOMAIN_GTT;
> +               }
> +       }
>          else
>                  domain = AMDGPU_GEM_DOMAIN_VRAM;
>
> --
> 2.25.1
