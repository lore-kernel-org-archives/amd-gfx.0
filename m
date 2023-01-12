Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C318C61DB3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 19:34:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC7E10E1BF;
	Thu, 12 Jan 2023 19:34:51 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AEE10E1BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 19:34:49 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-15027746720so19973743fac.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 11:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+8nu1ZxSz+lzsOwmnk3S6vpGyooNUhSvY+dMLIN+ciw=;
 b=VwG05rRmriP2tu6X6AaAtseGv47fsiz283oXXpLMYIAw6UqllPdufT/GGRsqJwRbE1
 awyF66rus7FXrHo/+0JuV/qhsvVWKmX/Pi89e9FC2QhOrmHK18ylFvAKN1S/Rf/vkffC
 J/MFtH+htYzsf6BX/seVlRxopVHW6tD7l2DV4bzDgBCtkZVWN1CaFKwYbNyP+EkC1M/i
 dOI2A9EVBM3DTNgfq2iFmPlgB6LzGX3wTcjMXyESJJyjh7AmsQGWWSSACVRX0tNcW4AG
 oQZ6Eb+QH9+PldloIw9egaehddb08G9ld3VDeWaBn8Wowa45Vp+jLBENfbzVAWHywVDU
 W+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+8nu1ZxSz+lzsOwmnk3S6vpGyooNUhSvY+dMLIN+ciw=;
 b=4rO8zbnL9yxoVDMMdQoGesHHCPI+DS4B3dYsTWVmYWxP+GrzWpCyn9sxJoQk3wTljc
 z3Hclku1or5FFq6cMO79QPNEjRTMahuUR6StGOWQ3dNHCkOP9PSgAChMXn1R4gp+Zdxk
 BkkyX43ek4ZWbckgtHEcaWqN9by5cxKfRDPgtzNKZwdwyqibevg7PYhaZ56aOHImbzRX
 cuRu8nW+Fbg4y5jUNrMKVr+lND8gvI4ZY2XiTxjXGXygfajvreYLerNxk4T6OuW/oGPv
 nxNZat4EZQjU03znazFAXDH+VckQy2qIOjscXeg6kFnCbMtNSHiYiDq+o3tLvsN6nFVJ
 HD5g==
X-Gm-Message-State: AFqh2kq+aZ+VDCq2lLH396dnEGsSE6oxxmrtUwGwJZv4bOeRbL3S25vk
 722XR26jOCBzv7ObNr7KBr7ELDthkxgITG//rrY=
X-Google-Smtp-Source: AMrXdXuFrKCd0QXQbVOIPL9uEcp2V6JHdWWvP7GmqMmm8eDgu0uZ4BOc1SxWLglM3yXQSIu+uCLOso/9Aqzg3EYeTOQ=
X-Received: by 2002:a05:6870:c59c:b0:150:d9aa:4011 with SMTP id
 ba28-20020a056870c59c00b00150d9aa4011mr2951182oab.96.1673552087550; Thu, 12
 Jan 2023 11:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20230111075226.150161-1-Yifan.Zha@amd.com>
In-Reply-To: <20230111075226.150161-1-Yifan.Zha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Jan 2023 14:34:36 -0500
Message-ID: <CADnq5_NNF8=oMYrhhe1K=jrAj10fO_6qvHn4B72ew7NrdFkGnA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Skip specific mmhub and sdma registers
 accessing under sriov
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
Cc: Alexander.Deucher@amd.com, Horace.Chen@amd.com, haijun.chang@amd.com,
 amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 11, 2023 at 2:53 AM Yifan Zha <Yifan.Zha@amd.com> wrote:
>
> [Why]
> SDMA0_CNTL and MMHUB system aperture related registers are blocked by L1 Policy.
> Therefore, they cannot be accessed by VF and loged in violation.
>
> [How]
> For MMHUB registers, they will be programmed by PF. So VF will skip to program them in mmhubv3_0.
> For SDMA0_CNTL which is a PF_only register, VF don't need to program it in sdma_v6_0.
>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c | 34 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c  | 10 +++++---
>  2 files changed, 23 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> index e9dcd6fcde7f..ae9cd1a4cfee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
> @@ -169,23 +169,23 @@ static void mmhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
>         uint64_t value;
>         uint32_t tmp;
>
> -       if (!amdgpu_sriov_vf(adev)) {
> -               /*
> -                * the new L1 policy will block SRIOV guest from writing
> -                * these regs, and they will be programed at host.
> -                * so skip programing these regs.
> -                */
> -               /* Disable AGP. */
> -               WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
> -               WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
> -               WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
> -
> -               /* Program the system aperture low logical page number. */
> -               WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
> -                            adev->gmc.vram_start >> 18);
> -               WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
> -                            adev->gmc.vram_end >> 18);
> -       }
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +
> +       /*
> +        * the new L1 policy will block SRIOV guest from writing
> +        * these regs, and they will be programed at host.
> +        * so skip programing these regs.
> +        */
> +       /* Disable AGP. */
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BASE, 0);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_TOP, 0);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_AGP_BOT, 0x00FFFFFF);
> +       /* Program the system aperture low logical page number. */
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR,
> +                    adev->gmc.vram_start >> 18);
> +       WREG32_SOC15(MMHUB, 0, regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR,
> +                    adev->gmc.vram_end >> 18);
>
>         /* Set default page address. */
>         value = adev->mem_scratch.gpu_addr - adev->gmc.vram_start +
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index bf1fa5e8d2f9..6fe292a2486b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1403,10 +1403,12 @@ static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
>
>         u32 reg_offset = sdma_v6_0_get_reg_offset(adev, type, regSDMA0_CNTL);
>
> -       sdma_cntl = RREG32(reg_offset);
> -       sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
> -                      state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> -       WREG32(reg_offset, sdma_cntl);
> +       if (!amdgpu_sriov_vf(adev)) {
> +               sdma_cntl = RREG32(reg_offset);
> +               sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA0_CNTL, TRAP_ENABLE,
> +                               state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
> +               WREG32(reg_offset, sdma_cntl);
> +       }
>
>         return 0;
>  }
> --
> 2.25.1
>
