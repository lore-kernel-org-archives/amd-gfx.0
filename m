Return-Path: <SRS0=thZ3=2A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E9BC43603
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 16:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F6472073D
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2019 16:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSXqNavD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6472073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41FA46E14F;
	Tue, 10 Dec 2019 16:58:28 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2556B6E14F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 16:58:27 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p17so4027379wma.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2019 08:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VJdfqLUBwB9jjxSTtBXVTzuin/yve2/TmxTqz1kPKko=;
 b=aSXqNavDKpLb9itL+cG/K07c8JyFtpvmd2zTOp913+EsYGNEibqxs0U2IGqr0aAXJh
 riTeXGArrw02T2+YHqoRHHm7EV4eX621bORg4WVUIQXeH7lDFGtzg5UjwVO7lcoszFmG
 rsV3nPUqme4Tg6BlU1G3EZdquDYT4cilhEVF/fn9E2+YyBhu3deQytkvxMYtHhnGAyL1
 N7Gaol46Y6Fs8oAX5GoOnJlOsisqL9VoSMO9kl8gZPyJZ7E/4ezH+cl9Tq6FiZuikMqb
 IjgTMctqYDFW6Qx1xWmDYzWlLp5q2harFuRACyCkQr9Sr//OncF/Qb8XPQT5PdnVA1/I
 Yflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VJdfqLUBwB9jjxSTtBXVTzuin/yve2/TmxTqz1kPKko=;
 b=VtUGOzXcscNJf73Tkf79vwNijW47oLuBoZKGAkOyHzGrfS4SPNVQv5TXBeN6Dkz2Zt
 IYOubJNRep2kik+/h7gXgl53fTI6AvsxJTBB48LiEXdPTkkD43golV4PEsAiLeG+wRBg
 ddH7sCul3TeYrTNEJM8WgH7MYuhRsKmQxNUvBmM3aWvcDJ+vj7sxPviqLDUrFvSYDGI1
 p6ATjANQbK5n0af0J84hxkaV+JncTB3Y4wloD587JsJg+1DvR+utjzTiw04208T6Giw2
 Bfj6DX7kobJkpGFhIPg5bohzm+2bGUdeAlAsSGWWhAfJRorHbbSjnWRshD4s60H4kJMo
 4WHA==
X-Gm-Message-State: APjAAAWU0Rz3gGY9eiwKu8RxX1LfhdmkGHolrAq/YzsqulIK3p+Y0GJq
 5aYDeoEJxXmD5OTXvZ2j1u3Ur8uFm5MYOeaQopE=
X-Google-Smtp-Source: APXvYqxa0QR+eHW3luAK5OvxOLWpAiYlhV50ghD5y/+emOMSzstk/Yo5Ab8gO2stCjqiNbs3MLpuZ/f1p5o+/zX0MaY=
X-Received: by 2002:a1c:e909:: with SMTP id q9mr6537453wmc.30.1575997105606;
 Tue, 10 Dec 2019 08:58:25 -0800 (PST)
MIME-Version: 1.0
References: <20191210162137.23538-1-changfeng.zhu@amd.com>
In-Reply-To: <20191210162137.23538-1-changfeng.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Dec 2019 11:58:14 -0500
Message-ID: <CADnq5_NqKnFySQg7sYiJqjDzBKctgAKv3ttLjCb2WwZJWc4Dkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: modify invalidate semaphore limit in gmc10
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

On Tue, Dec 10, 2019 at 11:22 AM Changfeng.Zhu <changfeng.zhu@amd.com> wrote:
>
> From: changzhu <Changfeng.Zhu@amd.com>
>
> It may fail to load guest driver in round 2 when using invalidate
> semaphore for SRIOV. So it needs to avoid using invalidate semaphore
> for SRIOV.
>
> Change-Id: I2719671cf86a1755b05c5f2ac7420a901abbe916
> Signed-off-by: changzhu <Changfeng.Zhu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 32 +++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 381bb709f021..fd6e3b3b8084 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -218,6 +218,24 @@ static uint32_t gmc_v10_0_get_invalidate_req(unsigned int vmid,
>         return req;
>  }
>
> +/**
> + * gmc_v10_0_use_invalidate_semaphore - judge whether to use semaphore
> + *
> + * @adev: amdgpu_device pointer
> + * @vmhub: vmhub type
> + *
> + */
> +static bool gmc_v10_0_use_invalidate_semaphore(struct amdgpu_device *adev,
> +                                      uint32_t vmhub)
> +{
> +       if ((vmhub == AMDGPU_MMHUB_0 ||
> +            vmhub == AMDGPU_MMHUB_1) &&
> +           (!amdgpu_sriov_vf(adev)))
> +               return true;
> +       else
> +               return false;
> +}
> +
>  /*
>   * GART
>   * VMID 0 is the physical GPU addresses as used by the kernel.
> @@ -233,6 +251,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>         /* Use register 17 for GART */
>         const unsigned eng = 17;
>         unsigned int i;
> +       bool value = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);

Call this use_semaphore or something like that rather than value.
Same comment to the instances below as well.  With that fixed,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>         spin_lock(&adev->gmc.invalidate_lock);
>         /*
> @@ -243,8 +262,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>          */
>
>         /* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -       if (vmhub == AMDGPU_MMHUB_0 ||
> -           vmhub == AMDGPU_MMHUB_1) {
> +       if (value) {
>                 for (i = 0; i < adev->usec_timeout; i++) {
>                         /* a read return value of 1 means semaphore acuqire */
>                         tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem + eng);
> @@ -277,8 +295,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>         }
>
>         /* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -       if (vmhub == AMDGPU_MMHUB_0 ||
> -           vmhub == AMDGPU_MMHUB_1)
> +       if (value)
>                 /*
>                  * add semaphore release after invalidation,
>                  * write with 0 means semaphore release
> @@ -372,6 +389,7 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>         struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
>         uint32_t req = gmc_v10_0_get_invalidate_req(vmid, 0);
>         unsigned eng = ring->vm_inv_eng;
> +       bool value = gmc_v10_0_use_invalidate_semaphore(ring->adev, ring->funcs->vmhub);
>
>         /*
>          * It may lose gpuvm invalidate acknowldege state across power-gating
> @@ -381,8 +399,7 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>          */
>
>         /* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -       if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> -           ring->funcs->vmhub == AMDGPU_MMHUB_1)
> +       if (value)
>                 /* a read return value of 1 means semaphore acuqire */
>                 amdgpu_ring_emit_reg_wait(ring,
>                                           hub->vm_inv_eng0_sem + eng, 0x1, 0x1);
> @@ -398,8 +415,7 @@ static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
>                                             req, 1 << vmid);
>
>         /* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
> -       if (ring->funcs->vmhub == AMDGPU_MMHUB_0 ||
> -           ring->funcs->vmhub == AMDGPU_MMHUB_1)
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
