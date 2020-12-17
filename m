Return-Path: <SRS0=AWwP=FV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EFEC4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 19:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169C4239EE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Dec 2020 19:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169C4239EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDDD9897E4;
	Thu, 17 Dec 2020 19:09:22 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83403897E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 19:09:21 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id f132so19381oib.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Dec 2020 11:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZGaRXYphQhb9PVhbk95uQaKAXJ8fxTiV8D4yfLd3m+U=;
 b=BM7S4GZiphHzIAj0Ty1Eb7NLfkFZ+RT0O4TujhXRaCCehHozQjaSQbkEO1vcvxpBxP
 99/ZLXRlK9GuDdkMqEQBozGfK2dAuZCTnBoUuD8fdlgUPAbZAWjG6+0GXvmyzN88S0oG
 RKjXAZoOlVEmEHyc0tOfIDmCf09Z2U+q6dP3ygW3pofiTlG7FIrmEDnK3Gxj8r7ZRpNb
 bvdXgO2Qatw9y7rMJn1Q2QOtFjA6LJTi0GrEX5IQqxc0KDqABC3kq7StwQ8zq8/CJM/2
 AuBzjimfbwsGEWNssDtlrp3502uxMDJ28DDmNoePkif/B6ao9VmEXHG+25FGJbQYjS64
 Edmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZGaRXYphQhb9PVhbk95uQaKAXJ8fxTiV8D4yfLd3m+U=;
 b=V5SU05g0o6fsjmVabDG+mSd6LxZN4F57azQCIcg7O5VhsKggrQAss7xh4KA/uKIiuh
 4hSS23PiaGwUkkjGidNNaSvnHzBL/cDj46F+RN2Kb3st/9PKtNwmBIL93D9rRmHwJybZ
 MDIGYfeJKfDrn/LpJfREeSyllg9P3Hx04ONXn8j1ZGXrtfW3yC+ovLsisSfYs5eNY99s
 ILwAYCjbGfkKCnZOGJfVk2ZLaOk+x6f9pQI74Ehw320r6tqLlHfDoIPzTev6AkbkOP/v
 ZF8nadB2vFsyy3NdcA91xWy4pp5K1/Nei+km58KwRIbpTggD6ayNMjxHAhg+iZtOPovJ
 oa2A==
X-Gm-Message-State: AOAM532aiRpwxaW6E7wUj5C005iENBFNbFa0zwrJRsICv0PmXnEaTqun
 55ZWg13YIlLAcXL+K9OxTcn5ndvBLHpaD7UtgSA=
X-Google-Smtp-Source: ABdhPJyy3ix/YGRIUzODNiYC3rerBnltB5BWH0d18r8NEc3GP1p+Ekb78q7QkMPARGTjVEnvIEhk46b8uv5h4AU5mJk=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr434140oib.123.1608232160783; 
 Thu, 17 Dec 2020 11:09:20 -0800 (PST)
MIME-Version: 1.0
References: <20201214073744.160679-1-likun.gao@amd.com>
 <BL0PR12MB4913451620379BABACBACF5597C70@BL0PR12MB4913.namprd12.prod.outlook.com>
In-Reply-To: <BL0PR12MB4913451620379BABACBACF5597C70@BL0PR12MB4913.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Dec 2020 14:09:09 -0500
Message-ID: <CADnq5_OtLJ1uOLv9rR+Q1eUwEkxCgu6-24=D3G-Z8Te_39-twQ@mail.gmail.com>
Subject: Re: [v2] drm/amdgpu: skip vram operation for BAMACO runtime
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Gao,
 Likun" <Likun.Gao@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Dec 14, 2020 at 5:13 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> [AMD Public Use]
>
> >-----Original Message-----
> >From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Likun
> >Gao
> >Sent: Monday, December 14, 2020 1:08 PM
> >To: amd-gfx@lists.freedesktop.org
> >Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Gao, Likun
> ><Likun.Gao@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Zhang,
> >Hawking <Hawking.Zhang@amd.com>
> >Subject: [v2] drm/amdgpu: skip vram operation for BAMACO runtime
> >
> >[CAUTION: External Email]
> >
> >From: Likun Gao <Likun.Gao@amd.com>
> >
> >Skip vram related operation for bamaco rumtime suspend and resume as
> >vram is alive when BAMACO.
> >It can save about 32ms when suspend and about 15ms when resume.
> >
> >v2: add local adev variable for maco enablement which checked by device
> >MACO support cap and runtime method parameter to have a mix of devices
> >that support different runtime pm modes.

Something else just occurred to me, we need to handle
DPM_FLAG_NO_DIRECT_COMPLETE properly with the *MA* variants.  We need
to make sure set that flag if there are any cases where we will lose
the contents of memory and not have it backed up.

Alex


> >
> >Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> >Change-Id: I99cbaf720bfeecdc6682057b238d29c4e41cf155
> >---
> > drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
> > drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  9 ++-
> > drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 72 +++++++++++--------
> > .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  7 +-
> > 4 files changed, 56 insertions(+), 33 deletions(-)
> >
> >diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >index eed5410947e9..288c41e0b61f 100644
> >--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >@@ -1027,6 +1027,7 @@ struct amdgpu_device {
> >        /* enable runtime pm on the device */
> >        bool                            runpm;
> >        bool                            in_runpm;
> >+       bool                            runpm_maco_en;
> >
> >        bool                            pm_sysfs_en;
> >        bool                            ucode_sysfs_en;
>
> Isn't it better to move pm related variables to amdgpu_pm (at least going forward) instead of keeping too many in adev?
>
> >diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >index 0ec7c28c4d5a..0c608b903ec3 100644
> >--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >@@ -2464,7 +2464,8 @@ static int amdgpu_device_ip_late_init(struct
> >amdgpu_device *adev)
> >        amdgpu_device_set_cg_state(adev, AMD_CG_STATE_GATE);
> >        amdgpu_device_set_pg_state(adev, AMD_PG_STATE_GATE);
> >
> >-       amdgpu_device_fill_reset_magic(adev);
> >+       if (!adev->runpm_maco_en || !adev->in_runpm)
> >+               amdgpu_device_fill_reset_magic(adev);
> >        r = amdgpu_device_enable_mgpu_fan_boost();
> >        if (r)
> >@@ -3706,7 +3707,8 @@ int amdgpu_device_suspend(struct drm_device
> >*dev, bool fbcon)
> >        amdgpu_amdkfd_suspend(adev, !fbcon);
> >
> >        /* evict vram memory */
> >-       amdgpu_bo_evict_vram(adev);
> >+       if (!adev->runpm_maco_en || !adev->in_runpm)
> >+               amdgpu_bo_evict_vram(adev);
> >
> >        amdgpu_fence_driver_suspend(adev);
> >
> >@@ -3718,7 +3720,8 @@ int amdgpu_device_suspend(struct drm_device
> >*dev, bool fbcon)
> >         * This second call to evict vram is to evict the gart page table
> >         * using the CPU.
> >         */
> >-       amdgpu_bo_evict_vram(adev);
> >+       if (!adev->runpm_maco_en || !adev->in_runpm)
> >+               amdgpu_bo_evict_vram(adev);
> >
> >        return 0;
> > }
> >diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >index 523d22db094b..a198bc5d6a68 100644
> >--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >@@ -397,10 +397,12 @@ static int psp_tmr_init(struct psp_context *psp)
> >                }
> >        }
> >
> >-       pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> >-       ret = amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE,
> >+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
> >+               pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> >+               ret = amdgpu_bo_create_kernel(psp->adev, tmr_size,
> >+ PSP_TMR_SIZE,
> >                                      AMDGPU_GEM_DOMAIN_VRAM,
> >                                      &psp->tmr_bo, &psp->tmr_mc_addr, pptr);
> >+       }
> >
> >        return ret;
> > }
> >@@ -504,8 +506,10 @@ static int psp_tmr_terminate(struct psp_context
> >*psp)
> >                return ret;
> >
> >        /* free TMR memory buffer */
> >-       pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> >-       amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, pptr);
> >+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
> >+               pptr = amdgpu_sriov_vf(psp->adev) ? &tmr_buf : NULL;
> >+               amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr,
> >pptr);
> >+       }
> >
> >        return 0;
> > }
> >@@ -795,9 +799,10 @@ int psp_xgmi_terminate(struct psp_context *psp)
> >        psp->xgmi_context.initialized = 0;
> >
> >        /* free xgmi shared memory */
> >-       amdgpu_bo_free_kernel(&psp->xgmi_context.xgmi_shared_bo,
> >-                       &psp->xgmi_context.xgmi_shared_mc_addr,
> >-                       &psp->xgmi_context.xgmi_shared_buf);
> >+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
> >+               amdgpu_bo_free_kernel(&psp->xgmi_context.xgmi_shared_bo,
> >+                               &psp->xgmi_context.xgmi_shared_mc_addr,
> >+                               &psp->xgmi_context.xgmi_shared_buf);
> >
> >        return 0;
> > }
> >@@ -812,7 +817,8 @@ int psp_xgmi_initialize(struct psp_context *psp)
> >            !psp->adev->psp.ta_xgmi_start_addr)
> >                return -ENOENT;
> >
> >-       if (!psp->xgmi_context.initialized) {
> >+       if (!psp->xgmi_context.initialized &&
> >+           (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
> >                ret = psp_xgmi_init_shared_buf(psp);
> >                if (ret)
> >                        return ret;
> >@@ -1122,9 +1128,10 @@ static int psp_ras_terminate(struct psp_context
> >*psp)
> >        psp->ras.ras_initialized = false;
> >
> >        /* free ras shared memory */
> >-       amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
> >-                       &psp->ras.ras_shared_mc_addr,
> >-                       &psp->ras.ras_shared_buf);
> >+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
> >+               amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
> >+                               &psp->ras.ras_shared_mc_addr,
> >+                               &psp->ras.ras_shared_buf);
> >
> >        return 0;
> > }
> >@@ -1145,7 +1152,8 @@ static int psp_ras_initialize(struct psp_context *psp)
> >                return 0;
> >        }
> >
> >-       if (!psp->ras.ras_initialized) {
> >+       if (!psp->ras.ras_initialized &&
> >+           (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
> >                ret = psp_ras_init_shared_buf(psp);
> >                if (ret)
> >                        return ret;
> >@@ -1257,7 +1265,8 @@ static int psp_hdcp_initialize(struct psp_context
> >*psp)
> >                return 0;
> >        }
> >
> >-       if (!psp->hdcp_context.hdcp_initialized) {
> >+       if (!psp->hdcp_context.hdcp_initialized &&
> >+           (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
> >                ret = psp_hdcp_init_shared_buf(psp);
> >                if (ret)
> >                        return ret;
> >@@ -1325,9 +1334,10 @@ static int psp_hdcp_terminate(struct psp_context
> >*psp)
> >        psp->hdcp_context.hdcp_initialized = false;
> >
> >        /* free hdcp shared memory */
> >-       amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
> >-                             &psp->hdcp_context.hdcp_shared_mc_addr,
> >-                             &psp->hdcp_context.hdcp_shared_buf);
> >+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
> >+               amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
> >+                                     &psp->hdcp_context.hdcp_shared_mc_addr,
> >+
> >+ &psp->hdcp_context.hdcp_shared_buf);
> >
> >        return 0;
> > }
> >@@ -1404,7 +1414,8 @@ static int psp_dtm_initialize(struct psp_context
> >*psp)
> >                return 0;
> >        }
> >
> >-       if (!psp->dtm_context.dtm_initialized) {
> >+       if (!psp->dtm_context.dtm_initialized &&
> >+           (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
> >                ret = psp_dtm_init_shared_buf(psp);
> >                if (ret)
> >                        return ret;
> >@@ -1472,9 +1483,10 @@ static int psp_dtm_terminate(struct psp_context
> >*psp)
> >        psp->dtm_context.dtm_initialized = false;
> >
> >        /* free hdcp shared memory */
> >-       amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
> >-                             &psp->dtm_context.dtm_shared_mc_addr,
> >-                             &psp->dtm_context.dtm_shared_buf);
> >+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
> >+               amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
> >+                                     &psp->dtm_context.dtm_shared_mc_addr,
> >+                                     &psp->dtm_context.dtm_shared_buf);
> >
> >        return 0;
> > }
> >@@ -1563,7 +1575,8 @@ static int psp_rap_initialize(struct psp_context *psp)
> >                return 0;
> >        }
> >
> >-       if (!psp->rap_context.rap_initialized) {
> >+       if (!psp->rap_context.rap_initialized &&
> >+           (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)) {
> >                ret = psp_rap_init_shared_buf(psp);
> >                if (ret)
> >                        return ret;
> >@@ -1602,9 +1615,10 @@ static int psp_rap_terminate(struct psp_context
> >*psp)
> >        psp->rap_context.rap_initialized = false;
> >
> >        /* free rap shared memory */
> >-       amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
> >-                             &psp->rap_context.rap_shared_mc_addr,
> >-                             &psp->rap_context.rap_shared_buf);
> >+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm)
> >+               amdgpu_bo_free_kernel(&psp->rap_context.rap_shared_bo,
> >+                                     &psp->rap_context.rap_shared_mc_addr,
> >+                                     &psp->rap_context.rap_shared_buf);
> >
> >        return ret;
> > }
> >@@ -2261,10 +2275,12 @@ static int psp_resume(void *handle)
> >
> >        DRM_INFO("PSP is resuming...\n");
> >
> >-       ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
> >-       if (ret) {
> >-               DRM_ERROR("Failed to process memory training!\n");
> >-               return ret;
> >+       if (!psp->adev->runpm_maco_en || !psp->adev->in_runpm) {
> >+               ret = psp_mem_training(psp, PSP_MEM_TRAIN_RESUME);
> >+               if (ret) {
> >+                       DRM_ERROR("Failed to process memory training!\n");
> >+                       return ret;
> >+               }
> >        }
> >
> >        mutex_lock(&adev->firmware.mutex);
> >diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >index db0f2a476c23..fc8db9d69817 100644
> >--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> >@@ -302,9 +302,12 @@ static int
> >sienna_cichlid_check_powerplay_table(struct smu_context *smu)
> >                table_context->power_play_table;
> >        struct smu_baco_context *smu_baco = &smu->smu_baco;
> >
> >-       if (powerplay_table->platform_caps &
> >SMU_11_0_7_PP_PLATFORM_CAP_BACO ||
> >-           powerplay_table->platform_caps &
> >SMU_11_0_7_PP_PLATFORM_CAP_MACO)
> >+       if (powerplay_table->platform_caps &
> >+ SMU_11_0_7_PP_PLATFORM_CAP_BACO) {
> >                smu_baco->platform_support = true;
> >+               if ((powerplay_table->platform_caps &
> >SMU_11_0_7_PP_PLATFORM_CAP_MACO) &&
> >+                   (amdgpu_runtime_pm == 2))
> >+                       smu->adev->runpm_maco_en = true;
> >+       }
> >
>
> Consider BOCO path also in runtime suspend flow. Also, variable may be named more generic like mem_alive (or similar) for any other suspend/resume that could retain vram - S0ix.
>
> Thanks,
> Lijo
>
> >        table_context->thermal_controller_type =
> >                powerplay_table->thermal_controller_type;
> >--
> >2.25.1
> >
> >_______________________________________________
> >amd-gfx mailing list
> >amd-gfx@lists.freedesktop.org
> >https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.f
> >reedesktop.org%2Fmailman%2Flistinfo%2Famd-
> >gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C5d3ad5208b1e412a016
> >808d8a0034a97%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63743
> >5283286148631%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJ
> >QIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VmVF
> >w6%2FGsbwRUzXHG26DUut7y8MceVib6M7t84mM7YQ%3D&amp;reserved=0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
