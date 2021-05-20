Return-Path: <SRS0=8Dg8=KP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB4C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7935E611BE
	for <amd-gfx@archiver.kernel.org>; Thu, 20 May 2021 03:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7935E611BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073EA6E839;
	Thu, 20 May 2021 03:48:34 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EC856E839
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 May 2021 03:48:32 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 i14-20020a9d624e0000b029033683c71999so2512222otk.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 20:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SAybIDptnyWL2NwGraFZl83ghvhiw0d1pDGYuphoUVQ=;
 b=ndEYES9+RwnUQITurwG6eGZKq6EG1GVfzSsinNwA1oi13wirsniBackCyjUOR7WO4r
 UgqSZ3lidccA+U6Au9Wlt5LBw3tCb2/kMuOIm+tNUsIjvm3Ro14GxeBeFBzYegI8ga8o
 PA2W+gOecwLK6adNnkfDtWk3mlZCGzLAbeEL10j2wd48A6DWl19nwgQ33Sbf6p4y2MCQ
 mLY2nLj/A9kgQm0qP4THssNN/jrRH0QIhwHyn5WAzkkeZ8y+TO7pG68lgd99GXmSAiW1
 /QDX6MDA9NsyDQLQ6GGIPXKnIW9biROe/2x0CpKg31LYo+vpXg1jGonofRe9EIF+XlUM
 +URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SAybIDptnyWL2NwGraFZl83ghvhiw0d1pDGYuphoUVQ=;
 b=CjBCB3HpiO96PS+2Kpf6tmfd8r3FtoCEfll/f9w17I8aghJTVG5y6hh9bPaCzlQAca
 p4zQ+8w5nqd4vGYQgcXz1MC2QYDq4lM4ZuC+2NrdinRlVo3C5kskMuetuB9wAKX+ZnHq
 raZuxU7mGCdgP5Z7tnXLd8mxbtXZvmN6WMPesnlr3REdFXOd48xsiuE/G0RQnQ8KYQuu
 XWte8cIaMBOtTTl/lyvPoJN+O0nwKaK3PAotGPbxFtpPwohN2rBwA4mhQsFzXM0hb63J
 OFffc9pd2eBvSJUWO2riguHhwGrv6h3q/vwGiJR0VfuXt1Nk4dHOFg4wQjI9erCfhkJi
 pL+Q==
X-Gm-Message-State: AOAM533GReecPaBQ4K6bRq7xn9JXBuLg0bzPrvDiGpsavj5jpa9jS2v6
 YvSyCZc8XXzx7UYrY7rA7eCklVFzIyL/EhNQBaSI8pQs
X-Google-Smtp-Source: ABdhPJx8MHyc7mEXGX5kviRpox7qoSNSKr3YSvOJjifSONhO/lupMt7iDZA5Hw4vlIOOXwchVSJHeFKJuBjrKryvC9Y=
X-Received: by 2002:a9d:6548:: with SMTP id q8mr2299576otl.311.1621482511559; 
 Wed, 19 May 2021 20:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210517143910.2125-1-PengJu.Zhou@amd.com>
 <20210517143910.2125-8-PengJu.Zhou@amd.com>
In-Reply-To: <20210517143910.2125-8-PengJu.Zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 May 2021 23:48:20 -0400
Message-ID: <CADnq5_PUB-uRRr73ZgfLkEKfHuAvVMttY-Tz_bt++UpRy5L-_A@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] drm/amdgpu: Modify MMHUB register access from
 MMIO to RLCG in file mmhub_v2*
To: Peng Ju Zhou <PengJu.Zhou@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 17, 2021 at 10:39 AM Peng Ju Zhou <PengJu.Zhou@amd.com> wrote:
>
> From: pengzhou <PengJu.Zhou@amd.com>
>
> In SRIOV environment, KMD should access GC registers
> with RLCG if GC indirect access flag enabled.
>
> Signed-off-by: pengzhou <PengJu.Zhou@amd.com>

Patches 1-8 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
See my comments on patch 9.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 37 +++++++++++++------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> index ac76081b91d5..e24225b3d42a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
> @@ -29,6 +29,7 @@
>  #include "mmhub/mmhub_2_0_0_default.h"
>  #include "navi10_enum.h"
>
> +#include "gc/gc_10_1_0_offset.h"
>  #include "soc15_common.h"
>
>  #define mmMM_ATC_L2_MISC_CG_Sienna_Cichlid                      0x064d
> @@ -165,11 +166,11 @@ static void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmi
>  {
>         struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
>
> -       WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
> +       WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
>                             hub->ctx_addr_distance * vmid,
>                             lower_32_bits(page_table_base));
>
> -       WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
> +       WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
>                             hub->ctx_addr_distance * vmid,
>                             upper_32_bits(page_table_base));
>  }
> @@ -180,14 +181,14 @@ static void mmhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
>
>         mmhub_v2_0_setup_vm_pt_regs(adev, 0, pt_base);
>
> -       WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
> +       WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
>                      (u32)(adev->gmc.gart_start >> 12));
> -       WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
> +       WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_HI32,
>                      (u32)(adev->gmc.gart_start >> 44));
>
> -       WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
> +       WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
>                      (u32)(adev->gmc.gart_end >> 12));
> -       WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
> +       WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
>                      (u32)(adev->gmc.gart_end >> 44));
>  }
>
> @@ -197,9 +198,9 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
>         uint32_t tmp;
>
>         /* Program the AGP BAR */
> -       WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
> -       WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> -       WREG32_SOC15(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
> +       WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BASE, 0);
> +       WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
> +       WREG32_SOC15_RLC(MMHUB, 0, mmMMMC_VM_AGP_TOP, adev->gmc.agp_end >> 24);
>
>         if (!amdgpu_sriov_vf(adev)) {
>                 /* Program the system aperture low logical page number. */
> @@ -308,7 +309,7 @@ static void mmhub_v2_0_enable_system_domain(struct amdgpu_device *adev)
>         tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH, 0);
>         tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT0_CNTL,
>                             RETRY_PERMISSION_OR_INVALID_PAGE_FAULT, 0);
> -       WREG32_SOC15(MMHUB, 0, mmMMVM_CONTEXT0_CNTL, tmp);
> +       WREG32_SOC15_RLC(MMHUB, 0, mmMMVM_CONTEXT0_CNTL, tmp);
>  }
>
>  static void mmhub_v2_0_disable_identity_aperture(struct amdgpu_device *adev)
> @@ -370,16 +371,16 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
>                 tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
>                                     RETRY_PERMISSION_OR_INVALID_PAGE_FAULT,
>                                     !adev->gmc.noretry);
> -               WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
> +               WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
>                                     i * hub->ctx_distance, tmp);
> -               WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
> +               WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_LO32,
>                                     i * hub->ctx_addr_distance, 0);
> -               WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
> +               WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_START_ADDR_HI32,
>                                     i * hub->ctx_addr_distance, 0);
> -               WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
> +               WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_LO32,
>                                     i * hub->ctx_addr_distance,
>                                     lower_32_bits(adev->vm_manager.max_pfn - 1));
> -               WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
> +               WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
>                                     i * hub->ctx_addr_distance,
>                                     upper_32_bits(adev->vm_manager.max_pfn - 1));
>         }
> @@ -391,9 +392,9 @@ static void mmhub_v2_0_program_invalidation(struct amdgpu_device *adev)
>         unsigned i;
>
>         for (i = 0; i < 18; ++i) {
> -               WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
> +               WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
>                                     i * hub->eng_addr_distance, 0xffffffff);
> -               WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
> +               WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_INVALIDATE_ENG0_ADDR_RANGE_HI32,
>                                     i * hub->eng_addr_distance, 0x1f);
>         }
>  }
> @@ -422,7 +423,7 @@ static void mmhub_v2_0_gart_disable(struct amdgpu_device *adev)
>
>         /* Disable all tables */
>         for (i = 0; i < AMDGPU_NUM_VMID; i++)
> -               WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT0_CNTL,
> +               WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT0_CNTL,
>                                     i * hub->ctx_distance, 0);
>
>         /* Setup TLB control */
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
