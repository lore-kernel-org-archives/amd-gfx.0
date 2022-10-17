Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0F1C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Oct 2022 14:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8037710E109;
	Mon, 17 Oct 2022 14:09:46 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB6EA10E0A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Oct 2022 14:09:38 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-132fb4fd495so13328425fac.12
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Oct 2022 07:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hTN9SwpkLZT8bF7u2F8ocqiG8KtKFjdQYnrwYOVE4Eo=;
 b=d/pMNAV0Xn8ad8HH70yOtcRsgt6rsdqknrbQAi2WEs/hnKwN44iCv6ZUR8mDscmf7I
 SG/WHd/cx61r0g0nKUU+M+TST3iwU3VFqlVtul2B1oXUX0iV9/xrVPoYnqVfcxzxltI4
 zNsti5g7mM74AyfHLklSL/gcOqEx5zs4bjgKDtvI0WAJOk163CwouCh1V96PmK9pHOvc
 ApGmOFW3BBeuKAyVulLNUYdH8lOTgLcB5RfuyfWoGQs3GFPcAsnjHu7VzIUbVjLiO1JB
 UY6rXjpT9HF/S8mNNs2e/TzL+dWai6I9HgzQXlUTTq4rCIJKK6w8GMxtoVao3fu0R868
 ltug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hTN9SwpkLZT8bF7u2F8ocqiG8KtKFjdQYnrwYOVE4Eo=;
 b=dVXH8MIsOSwPG7SB5229Pk7a8sK1Up5JD47PCjiGEeZi9t4oC4D8LZH8WI81ftw1ki
 QlYIV9xNkKgGAtjIQ7FwFcaYZ2HKImPv212PqO4T/plyZe2C36dkp3E5b48Zpkjpxe86
 H3/67vix9hFYoqPFMwlykOWkdj7yWyoPQ0h5hNbB6Hkf5tsmtrwX6zOTD/t2f4jWWmvI
 UNp4cE04IEOzOjYpPC86ubCpfyFP6S/oTlePNJzyzsVcVrLxI3l5k+gNfvkalOtMkZYQ
 MGNx/ZRQUzjQq3/SK/gnHrjRfY50tM8qpI78lXWlteQgCKh86AOstOwrMxTIjxFfw3gF
 gWZw==
X-Gm-Message-State: ACrzQf1DI8dzOWQYdGlGaf8TVg5fzZT0HLt1uz/3UjVlmEczZSNuTKm6
 VjwyKutgPhXOR6jBVacckvNBDU6qjYvETfdA2Xg=
X-Google-Smtp-Source: AMsMyM7ToIEtmxq8gLIaLZj5+DxL70xmdsBvy0CDeF9DvcnFwlZanmwK+ypvkVoxjvlVOTIackSUoTZNKZK5qp1su10=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr5942044oao.96.1666015778186; Mon, 17
 Oct 2022 07:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221017092059.68674-1-Yifan.Zha@amd.com>
In-Reply-To: <20221017092059.68674-1-Yifan.Zha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Oct 2022 10:09:26 -0400
Message-ID: <CADnq5_N87aL3cbD5WLqa=K96gtWJ27M=xQG0MkOJ=07mdRZ1nQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Program GC registers through RLCG interface
 in gfx_v11/gmc_v11
To: Yifan Zha <Yifan.Zha@amd.com>
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
Cc: Alexander.Deucher@amd.com, Horace.Chen@amd.com, Hawking.Zhang@amd.com,
 amd-gfx@lists.freedesktop.org, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 17, 2022 at 5:21 AM Yifan Zha <Yifan.Zha@amd.com> wrote:
>
> [Why]
> L1 blocks most of GC registers accessing by MMIO.
>
> [How]
> Use RLCG interface to program GC registers under SRIOV VF in full access time.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
> Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c         | 18 +++++++++++-------
>  3 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index 0b0a72ca5695..7e80caa05060 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -111,7 +111,7 @@ static int init_interrupts_v11(struct amdgpu_device *adev, uint32_t pipe_id)
>
>         lock_srbm(adev, mec, pipe, 0, 0);
>
> -       WREG32(SOC15_REG_OFFSET(GC, 0, regCPC_INT_CNTL),
> +       WREG32_SOC15(GC, 0, regCPC_INT_CNTL,
>                 CP_INT_CNTL_RING0__TIME_STAMP_INT_ENABLE_MASK |
>                 CP_INT_CNTL_RING0__OPCODE_ERROR_INT_ENABLE_MASK);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 73106f53246d..e3842dc100d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1571,7 +1571,7 @@ static void gfx_v11_0_init_compute_vmid(struct amdgpu_device *adev)
>                 WREG32_SOC15(GC, 0, regSH_MEM_BASES, sh_mem_bases);
>
>                 /* Enable trap for each kfd vmid. */
> -               data = RREG32(SOC15_REG_OFFSET(GC, 0, regSPI_GDBG_PER_VMID_CNTL));
> +               data = RREG32_SOC15(GC, 0, regSPI_GDBG_PER_VMID_CNTL);
>                 data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
>         }
>         soc21_grbm_select(adev, 0, 0, 0, 0);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 846ccb6cf07d..66dfb574cc7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -186,6 +186,10 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>         /* Use register 17 for GART */
>         const unsigned eng = 17;
>         unsigned int i;
> +       unsigned char hub_ip = 0;
> +
> +       hub_ip = (vmhub == AMDGPU_GFXHUB_0) ?
> +                  GC_HWIP : MMHUB_HWIP;
>
>         spin_lock(&adev->gmc.invalidate_lock);
>         /*
> @@ -199,8 +203,8 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>         if (use_semaphore) {
>                 for (i = 0; i < adev->usec_timeout; i++) {
>                         /* a read return value of 1 means semaphore acuqire */
> -                       tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_sem +
> -                                           hub->eng_distance * eng);
> +                       tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
> +                                           hub->eng_distance * eng, hub_ip);
>                         if (tmp & 0x1)
>                                 break;
>                         udelay(1);
> @@ -210,12 +214,12 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>                         DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
>         }
>
> -       WREG32_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
> +       WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, hub_ip);
>
>         /* Wait for ACK with a delay.*/
>         for (i = 0; i < adev->usec_timeout; i++) {
> -               tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack +
> -                                   hub->eng_distance * eng);
> +               tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
> +                                   hub->eng_distance * eng, hub_ip);
>                 tmp &= 1 << vmid;
>                 if (tmp)
>                         break;
> @@ -229,8 +233,8 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
>                  * add semaphore release after invalidation,
>                  * write with 0 means semaphore release
>                  */
> -               WREG32_NO_KIQ(hub->vm_inv_eng0_sem +
> -                             hub->eng_distance * eng, 0);
> +               WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
> +                             hub->eng_distance * eng, 0, hub_ip);
>
>         /* Issue additional private vm invalidation to MMHUB */
>         if ((vmhub != AMDGPU_GFXHUB_0) &&
> --
> 2.25.1
>
