Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABCEC47088
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 19:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03869613B5
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 19:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03869613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 750886E50E;
	Wed, 26 May 2021 19:08:15 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DE976E50E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 19:08:14 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id c196so2564184oib.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FZtcI192k1h7O1bxJqVvAlksUJlYcgtyVwuoikHseMw=;
 b=lALfFEc7Y6xQk3+FqncwF3MCOAN+mq1sl2xa/i/0z9tnghKY++lzNeKCnQye3WCv9d
 877mz+mlyWKUliM+OX6m/dCZqxLoQANuLBG8TloqkX0FZ0OJooVqzcJhmvB86bWA8cnL
 SgFAFlY3AvTPDTav/8vnZ9g/0mgMqcap26ABZDqCcyoVe3v5Zhdv3hZWCETFobQ2Oyx0
 yMfcIzx7iGJ5aVo9ddYNUe4qwBOeEM0i9lJ/ZxxPZV3CbIml5gCF4AQgAJfOC57v28Nz
 RN6hImCGuCnB2iInr8o89q8/XnSVFwhDkGyl59npWXaz5up7mW0zfDJ651Q/xy36DJsu
 v1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FZtcI192k1h7O1bxJqVvAlksUJlYcgtyVwuoikHseMw=;
 b=MQG9SKpiiKEhAeKnP2VQtBY4OL9hQyxrlGOxdYo4DOpfHaWKn0+6Nr2iJy0a47xD4O
 SsB3mCZVjFjyIglSmcxSDA30LhBT/n3o92DCm/z7pofBxgJurXgQAufD7mbED2mkGLAS
 llpuCy+EwPsQDyIa/uYC3h/iOsknIgIzyI/lCtTBXUKoDhOodtKPJ0lTZSovmK5i5MKq
 GCAVppFJW1CR77XdV013KVwTOdvY6kwDU7UFWqQnLEYEQKF/YHkD3hGyLLJWIYLoEKnr
 YBdXzUJeN6QyDgOki9nDMTfI7vykp+wEPawGkMCoBnIF0NCYNW5yAtMSadHBcvcBIqP3
 cQgA==
X-Gm-Message-State: AOAM532vIqpYaK/Ur8kfqIeLTnk/VnT8DXRgwczKZmYCc1EauJezywTv
 4aoY+M6VzeSrJTAod1hMTbyyCsZhQJxcmLh+e/8=
X-Google-Smtp-Source: ABdhPJydhO5qOqxCZ0okale+hfpUc7S5IXqNYLqMZpWR7EK/eCaPEAHIpRTcEbpUGo2lDvkA/yueZVdPsiaJcXQLI+A=
X-Received: by 2002:a05:6808:1592:: with SMTP id
 t18mr2948814oiw.123.1622056093598; 
 Wed, 26 May 2021 12:08:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210526101310.1872892-1-xin2.li@amd.com>
In-Reply-To: <20210526101310.1872892-1-xin2.li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 May 2021 15:08:02 -0400
Message-ID: <CADnq5_MZK5B0KYw3Kd_Motkw5gyuOdzNJA+avCKw2a2b1qz02w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
To: "Li, Xin (Justin)" <xin2.li@amd.com>
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
Cc: "Alex . Deucher" <alexander.deucher@amd.com>,
 "Frank . Min" <Frank.Min@amd.com>,
 "Christian . Konig" <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 26, 2021 at 6:13 AM Li, Xin (Justin) <xin2.li@amd.com> wrote:
>
> since vcn decoding ring is not required, so just disable it.
>
> Cc: Alex.Deucher <alexander.deucher@amd.com>
> Cc: Christian.Konig <christian.koenig@amd.com>
> Signed-off-by: Li.Xin.Justin <xin2.li@amd.com>
> Signed-off-by: Frank.Min <Frank.Min@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 25 ++++++++++++++-----------
>  2 files changed, 17 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 524e4fe5efe8..614e6b06e94e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -427,7 +427,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>                         if (adev->uvd.harvest_config & (1 << i))
>                                 continue;
>
> -                       if (adev->vcn.inst[i].ring_dec.sched.ready)
> +                       if (adev->vcn.inst[i].ring_dec.sched.ready ||
> +                               (adev->asic_type == CHIP_NAVI12 &&
> +                               amdgpu_sriov_vf(adev)))
>                                 ++num_rings;
>                 }
>                 ib_start_alignment = 16;
> @@ -770,8 +772,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>                         dev_info->ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
>                 if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
>                         dev_info->ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
> -               if (amdgpu_is_tmz(adev))
> -                       dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
>

This looks unrelated and should be dropped.

>                 vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
>                 vm_size -= AMDGPU_VA_RESERVED_SIZE;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 8af567c546db..dc8a36766c4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -220,17 +220,20 @@ static int vcn_v2_0_hw_init(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>         struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
> -       int i, r;
> +       int i, r = -1;
>
>         adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
>                                              ring->doorbell_index, 0);
>
> -       if (amdgpu_sriov_vf(adev))
> +       if (amdgpu_sriov_vf(adev)) {
>                 vcn_v2_0_start_sriov(adev);
> -
> -       r = amdgpu_ring_test_helper(ring);
> -       if (r)
> -               goto done;
> +               if (adev->asic_type == CHIP_NAVI12)
> +                       ring->sched.ready = false;
> +       } else {
> +               r = amdgpu_ring_test_helper(ring);
> +               if (r)
> +                       goto done;
> +       }
>
>         //Disable vcn decode for sriov
>         if (amdgpu_sriov_vf(adev))
> @@ -245,8 +248,11 @@ static int vcn_v2_0_hw_init(void *handle)
>
>  done:
>         if (!r)
> -               DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
> -                       (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
> +               DRM_INFO("VCN %s encode initialized successfully(under %s).\n",
> +                       (adev->asic_type == CHIP_NAVI12 &&
> +                               amdgpu_sriov_vf(adev))?"":"decode and",
> +                       (adev->pg_flags &
> +                               AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
>
>         return r;
>  }
> @@ -1721,9 +1727,6 @@ int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
>         unsigned i;
>         int r;
>
> -       if (amdgpu_sriov_vf(adev))
> -               return 0;
> -
>         WREG32(adev->vcn.inst[ring->me].external.scratch9, 0xCAFEDEAD);
>         r = amdgpu_ring_alloc(ring, 4);
>         if (r)
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
