Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC3BC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 16:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F07A2073D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 16:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXSaMpn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F07A2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97156E8F9;
	Tue, 10 Dec 2019 16:57:57 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AE196E8C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 16:57:56 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id d73so776644wmd.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 08:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bTCxtCJYS9bibDAN1btvSLp/5t4/7SznSunDpBrIABI=;
 b=qXSaMpn+Qt2mLxjfHJE4yHCjqqOKbrjkF3/UKcsM5pZ7V9cADUPdo5fHzB6j6hf7Go
 C5HwTGQFqdtlrsn0trRtYR7DwYjttfd3D5HYLLnZlskzhzkDd/2o1Japp4rrKtqxm7mg
 HCWpTCnkE/UPVLTl+g7FoPZg33rpCO+Ht7EJNDrDj8ajym6TitPCyHIWZbaS0EFKhaWD
 WsjnsWShuLXO6TgnW6tuXBy3TCtajAnBetvs31Hhkgg7+Yfdu12YyMxQ8VCOhMl+GnKP
 7wKq0xKNsxRxpTDhAbYyxioma8B6qMS5y3MgEjd5uoHH5BAU7cDkmkFlHt88Sfq6NK7p
 OgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bTCxtCJYS9bibDAN1btvSLp/5t4/7SznSunDpBrIABI=;
 b=sDPX45RyMlWFF5uM56aVVC0BrBFKyNSiY6XsLSw9GH/R6GW7FuF0WXy9IMceChy8e7
 glLpQ3YiakGSAAUKT+R0o84w4YIeIy7bzu/aQo3AiCN49DNAjM94C0mwEv+WjxKXaJVD
 4yJ3NJepZstqTCtlS7s9S48ZguB+MaGf4fJAGS4Qfl/j2L+RASnDlXJFmXi4x19B1pjS
 3bu3sLoCqUG/OPXbNnCjHIlzjz6qQik1bFBNrb4Q8ayy6CGFYr/O+rQN61gLTG4fIPWV
 3IcwaWTVdfJqBNCDy1jhDCo/1AGGA+TZhVDHzbCv+57Sa1utAQ72wmg11/yxKSwnd0zF
 zZ/w==
X-Gm-Message-State: APjAAAXYbMW3DJKvzc0lFN9XJTtHA0lmavj+AZiTOSxt5dV5bbBms1Lm
 Bzm+0LUNxX1u4ZkQM4ScVPb/dfr7lnj5ywFKhKs=
X-Google-Smtp-Source: APXvYqx9hM/o6c/Ndl93d6ceCtmu7rKaCgpYg84ElbXQm+N1fA3EjSmWgnn+WXFl5HEmUxvUd72Ea2n3s7X5sKz/f/w=
X-Received: by 2002:a1c:486:: with SMTP id 128mr6468077wme.163.1575997074661; 
 Tue, 10 Dec 2019 08:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20191210162008.23482-1-changfeng.zhu@amd.com>
In-Reply-To: <20191210162008.23482-1-changfeng.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Dec 2019 11:57:43 -0500
Message-ID: <CADnq5_MYsoFrHxL+E6M2Yqh4AOKfrFjwZ0eh_8Gk1Gshs8vXpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: modify invalidate semaphore limit in gmc9
To: "Changfeng.Zhu" <changfeng.zhu@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Xinmei.Huang@amd.com,
 Huang Rui <Ray.Huang@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 10, 2019 at 11:21 AM Changfeng.Zhu <changfeng.zhu@amd.com> wrote:
>
> From: changzhu <Changfeng.Zhu@amd.com>
>
> It may fail to load guest driver in round 2 or cause Xstart problem
> when using invalidate semaphore for SRIOV or picasso. So it needs avoid
> using invalidate semaphore for SRIOV and picasso.
>
> Change-Id: I806f8e99ec97be84e6aed0f5c499a53b1931b490
> Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 47 +++++++++++++++------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 601667246a1c..552fd7f3fec4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -412,6 +412,27 @@ static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
>         return req;
>  }
>
> +/**
> + * gmc_v9_0_use_invalidate_semaphore - judge whether to use semaphore
> + *
> + * @adev: amdgpu_device pointer
> + * @vmhub: vmhub type
> + *
> + */
> +static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
> +                                      uint32_t vmhub)
> +{
> +       if ((vmhub == AMDGPU_MMHUB_0 ||
> +            vmhub == AMDGPU_MMHUB_1) &&
> +           (!amdgpu_sriov_vf(adev)) &&
> +           (!(adev->asic_type == CHIP_RAVEN &&
> +              adev->rev_id < 0x8 &&
> +              adev->pdev->device == 0x15d8)))
> +               return true;
> +       else
> +               return false;
> +}
> +
>  /*
>   * GART
>   * VMID 0 is the physical GPU addresses as used by the kernel.
> @@ -434,6 +455,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>         const unsigned eng = 17;
>         u32 j, tmp;
>         struct amdgpu_vmhub *hub;
> +       bool value = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);

Call this use_semaphore or something like that rather than value.
Same comment to the instances below as well.  With that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>         BUG_ON(vmhub >= adev->num_vmhubs);
>
> @@ -464,11 +486,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>          */
>
>         /* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -       if ((vmhub == AMDGPU_MMHUB_0 ||
> -            vmhub == AMDGPU_MMHUB_1) &&
> -           (!(adev->asic_type == CHIP_RAVEN &&
> -              adev->rev_id < 0x8 &&
> -              adev->pdev->device == 0x15d8))) {
> +       if (value) {
>                 for (j = 0; j < adev->usec_timeout; j++) {
>                         /* a read return value of 1 means semaphore acuqire */
>                         tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng);
> @@ -498,11 +516,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
>         }
>
>         /* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -       if ((vmhub == AMDGPU_MMHUB_0 ||
> -            vmhub == AMDGPU_MMHUB_1) &&
> -           (!(adev->asic_type == CHIP_RAVEN &&
> -              adev->rev_id < 0x8 &&
> -              adev->pdev->device == 0x15d8)))
> +       if (value)
>                 /*
>                  * add semaphore release after invalidation,
>                  * write with 0 means semaphore release
> @@ -524,6 +538,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>         struct amdgpu_vmhub *hub = &adev->vmhub[ring->funcs->vmhub];
>         uint32_t req = gmc_v9_0_get_invalidate_req(vmid, 0);
>         unsigned eng = ring->vm_inv_eng;
> +       bool value = gmc_v9_0_use_invalidate_semaphore(ring->adev, ring->funcs->vmhub);
>
>         /*
>          * It may lose gpuvm invalidate acknowldege state across power-gating
> @@ -533,11 +548,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>          */
>
>         /* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -       if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> -            ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
> -           (!(adev->asic_type == CHIP_RAVEN &&
> -              adev->rev_id < 0x8 &&
> -              adev->pdev->device == 0x15d8)))
> +       if (value)
>                 /* a read return value of 1 means semaphore acuqire */
>                 amdgpu_ring_emit_reg_wait(ring,
>                                           hub->vm_inv_eng0_sem + eng, 0x1, 0x1);
> @@ -553,11 +564,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>                                             req, 1 << vmid);
>
>         /* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -       if ((ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> -            ring->funcs->vmhub == AMDGPU_MMHUB_1) &&
> -           (!(adev->asic_type == CHIP_RAVEN &&
> -              adev->rev_id < 0x8 &&
> -              adev->pdev->device == 0x15d8)))
> +       if (value)
>                 /*
>                  * add semaphore release after invalidation,
>                  * write with 0 means semaphore release
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
