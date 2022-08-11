Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94F6C19F2A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Aug 2022 14:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FF1B2702;
	Thu, 11 Aug 2022 14:34:03 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6033BB2833
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 14:33:58 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id w197so8557153oie.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Aug 2022 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=52VtnrqGYXcrI4iSknOQ4Qg+FutM1dlwMRHe3u800mA=;
 b=iiaA4fYg44Lcv6QYUjp0qz7bVtyuyzH2k16sf/ZS+WFHLZbPoIIGhh5tODXMz85JBA
 rAs7BY92FJ9+nAwm9yJ4hUIYGSaMaXB4M6JxCUqD5Ba8/tPqTACwUiwjxT1neriv3sWh
 pyuWgarR/R8zGGfKw1Abw334QDE1vrzUq5nH6UbDPHjh8EHe2hjeo+atHFgEpyrtG/sf
 hod7BYLFayeaJ/nwGvh2k9SsomDEGk9AKCUHrRxeZZzRYGTV+3MZTUDFN2YOp9ECy14E
 8hcOhmIrUxjmzUb6I9ReQoC2Br4FLnsimtCIzJ4mvZENVhd92fjdoLiEFcvSmhFxsWWT
 s24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=52VtnrqGYXcrI4iSknOQ4Qg+FutM1dlwMRHe3u800mA=;
 b=Rb2vJknKfs6qH00D3T6biteKC3n+4GKwqzQ0S1haeN3wgXskBidiYqE0Z/zWBtdFjX
 /l4DoLe7ZXtV4Ek3gbBi2gPrA37MIgkcT21kGV+/OxmXwJ4eCzYC6TQGOI807Atp/aRI
 Ia7QZOJEs1DF6OUz+LUT31alH6LBvqVM/BqHlNWkzFAK57y2J7FaI33Q90WpB0Ogj5+W
 mjgwQhxwag0FcB+37QG/dEVZz/BI8cTdiIPyeDCJL/bNRZI5jJ1TJwFdIdqJkU8MvmRX
 PwyW86YXRX6hK5FH22b82q1kTxxDKw8vV7aiY+/tG668pnKEAS5hbGIqWEAZkfjK7mCN
 Nfyg==
X-Gm-Message-State: ACgBeo2Sq0hgwxVIAUhsUvnhouUIcZB981aA5xhXE3d08OKeTeahc4Jl
 BBv4TRSjCJuvM9k7KPDZEEG0z6gO/G3KikbjqhnZn83t
X-Google-Smtp-Source: AA6agR6hV6N166ws2pyxPh1D12a5Ez7GxGuJVQFeBHsP5kzNUqlzJfsaaEK36vlGwEhtLvmlt1fQ/gGz9KBKw+i0HvU=
X-Received: by 2002:a05:6808:19a3:b0:33e:1525:3fb4 with SMTP id
 bj35-20020a05680819a300b0033e15253fb4mr3640560oib.106.1660228437536; Thu, 11
 Aug 2022 07:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220811100039.122346-1-Dusica.Milinkovic@amd.com>
 <CH0PR12MB537267005EC57D1D8F969C7CF4649@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB537267005EC57D1D8F969C7CF4649@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Aug 2022 10:33:46 -0400
Message-ID: <CADnq5_OqvbfscLkF-jcTRWULSnpvdHeGh9DgadN4vyYXSVRQJw@mail.gmail.com>
Subject: Re: [Patch V3] drm/amdgpu: Increase tlb flush timeout for sriov
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Milinkovic, Dusica" <Dusica.Milinkovic@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 11, 2022 at 10:16 AM Liu, Shaoyun <Shaoyun.Liu@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> From HW point of view , the  maximum VF number can reach 16  instead  of 12 . Although currently no product will use the 16 VFs  together,  not sure about the future.
> You can added Acked-by me.  I will let Alex & Christion decide whether accept this change.
>

I'll let you two sort out the timeout, but the rest of the patch looks
good to me.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Regards
> Shaoyun.liu
>
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Dusica Milinkovic
> Sent: Thursday, August 11, 2022 6:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Milinkovic, Dusica <Dusica.Milinkovic@amd.com>
> Subject: [Patch V3] drm/amdgpu: Increase tlb flush timeout for sriov
>
> [Why]
> During multi-vf executing benchmark (Luxmark) observed kiq error timeout.
> It happenes because all of VFs do the tlb invalidation at the same time.
> Although each VF has the invalidate register set, from hardware side the invalidate requests are queue to execute.
>
> [How]
> In case of 12 VF increase timeout on 12*100ms
>
> Signed-off-by: Dusica Milinkovic <Dusica.Milinkovic@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 3 ++-  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5a639c857bd0..79bb6fd83094 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -320,7 +320,7 @@ enum amdgpu_kiq_irq {
>         AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
>         AMDGPU_CP_KIQ_IRQ_LAST
>  };
> -
> +#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
>  #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
>  #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
>  #define MAX_KIQ_REG_TRY 1000
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 9ae8cdaa033e..f513e2c2e964 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -419,6 +419,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>         uint32_t seq;
>         uint16_t queried_pasid;
>         bool ret;
> +       u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
> +adev->usec_timeout;
>         struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
>         struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>
> @@ -437,7 +438,7 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>
>                 amdgpu_ring_commit(ring);
>                 spin_unlock(&adev->gfx.kiq.ring_lock);
> -               r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> +               r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
>                 if (r < 1) {
>                         dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
>                         return -ETIME;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index ab89d91975ab..4603653916f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -896,6 +896,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>         uint32_t seq;
>         uint16_t queried_pasid;
>         bool ret;
> +       u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
> +adev->usec_timeout;
>         struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
>         struct amdgpu_kiq *kiq = &adev->gfx.kiq;
>
> @@ -935,7 +936,7 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
>
>                 amdgpu_ring_commit(ring);
>                 spin_unlock(&adev->gfx.kiq.ring_lock);
> -               r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
> +               r = amdgpu_fence_wait_polling(ring, seq, usec_timeout);
>                 if (r < 1) {
>                         dev_err(adev->dev, "wait for kiq fence error: %ld.\n", r);
>                         up_read(&adev->reset_domain->sem);
> --
> 2.25.1
>
