Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBBBEE49AD
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 22:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39B7110E559;
	Tue,  5 Sep 2023 22:49:37 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE3AB10E559
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 22:49:36 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1a1fa977667so2478912fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 15:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693954176; x=1694558976; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q9Vyl8X3Kx03oCKPLHafLp8MSmLOT69VEd45eOHIUAE=;
 b=knv6iuNxWOdOBP7sBkGPc1o/qQxYj9GOvXfEnObGz7YjD3SyDT0PtY3fM2pOK4nu5t
 RdNF4NNVV/ebuQAk4sqwKeykS34Vokx/9gLsdInc0QmOLIrTT7MbANRlq5nv6e/Ua8aF
 Oyus177CEp1EFvkzWKXmKMxG7kv/OlGVFi0M9pDUQ8RZ0ep6x0ng1kG1RlHhEGN/ALPR
 +WNp74egoq+7R9++q+cYTL7nHNzOrZQXal9QxxKMwbnO/j7vbQSvZ1l02FmuVsNFqJJ4
 YC9gAE3dos0YDonsKzaClj7gXTZjKdSXQkGygQBhB0QcXdB9YdbAZwk5ua0rPb5Ygkg1
 o+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693954176; x=1694558976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q9Vyl8X3Kx03oCKPLHafLp8MSmLOT69VEd45eOHIUAE=;
 b=fkN1eugdY0q+lHO17kDDmYTCkNaP5VU6Es1m2YBpPbbUN+op0QJ0Qudvl4diUxN21i
 Uiwl2+/X499hPhXnmmdtDgS2WCKcJ7CrmKEJFfbmr3sdcif5cn1kimFI62qpjrQd+g+S
 H8VRwR+qPWCFYZcWrLYIxjaO+yO/P41Mu0HafmVteiUJrZkqnt2B+RehquAPbP7kpEH5
 /HA67lQyW3jfxRj9cp71FfeaiufvcK+6e1A7u/Ncn1F8N2AtZ+DLN+0FiUTCRxbOG6yh
 yeO1VgpXyybpObi2Awd82mfhjLwXNHl1YIJOxAnaAO/jK+GBtU2gxNYF2hTW0oWa0oKr
 SK2w==
X-Gm-Message-State: AOJu0YzSQPDQ9Kflzo47nZXv3tRSEP0SvVCj+CPqtMmSmXm8Og2trODi
 cQ0TlVoL/uX4pAotmihJsuRltqv/dY+4QaR39xs=
X-Google-Smtp-Source: AGHT+IFeiU6D//FgqY7dh75e0zGaDmuGtb5tJRozcUYMWtpwVOY551aW2eSes5hEIXS6nollwzCSpBu0bORtZQLKM4o=
X-Received: by 2002:a05:6808:1311:b0:3a7:8e05:1699 with SMTP id
 y17-20020a056808131100b003a78e051699mr20304644oiv.37.1693954175913; Tue, 05
 Sep 2023 15:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-11-christian.koenig@amd.com>
In-Reply-To: <20230905060415.1400-11-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 18:49:25 -0400
Message-ID: <CADnq5_NRHm7so_cCcJopSduCyzWGx=5GmM3VYy5FMMxttx=hEA@mail.gmail.com>
Subject: Re: [PATCH 10/11] drm/amdgpu: rework lock handling fro flush_tlb
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: amd-gfx@lists.freedesktop.org, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 5, 2023 at 2:30=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Instead of each implementation doing this more or less correctly
> move taking the reset lock at a higher level.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 6 +-----
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 5 -----
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 5 -----
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 6 +-----
>  5 files changed, 11 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 15814cb801e7..c24252304d48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -589,8 +589,17 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *=
adev, uint32_t vmid,
>             !adev->mman.buffer_funcs_enabled ||
>             !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
>             !ring->sched.ready) {
> +
> +               /*
> +                * A GPU reset should flush all TLBs anyway, so no need t=
o do
> +                * this while one is ongoing.
> +                */
> +               if(!down_read_trylock(&adev->reset_domain->sem))

space between the if and (.
With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> +                       return;
> +
>                 adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
>                                                    flush_type);
> +               up_read(&adev->reset_domain->sem);
>                 return;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index 40d432d46469..302279497d67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -51,8 +51,6 @@
>  #include "athub_v2_0.h"
>  #include "athub_v2_1.h"
>
> -#include "amdgpu_reset.h"
> -
>  static int gmc_v10_0_ecc_interrupt_state(struct amdgpu_device *adev,
>                                          struct amdgpu_irq_src *src,
>                                          unsigned int type,
> @@ -264,11 +262,9 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_de=
vice *adev, uint32_t vmid,
>          * Directly use kiq to do the vm invalidation instead
>          */
>         if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> -           down_read_trylock(&adev->reset_domain->sem)) {
> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>                 amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_re=
q,
>                                 1 << vmid);
> -               up_read(&adev->reset_domain->sem);
>                 return;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index fa3586efacd2..998f6ee60b78 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -33,7 +33,6 @@
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_gem.h"
> -#include "amdgpu_reset.h"
>
>  #include "bif/bif_4_1_d.h"
>  #include "bif/bif_4_1_sh_mask.h"
> @@ -430,9 +429,6 @@ static void gmc_v7_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>         u32 mask =3D 0x0;
>         int vmid;
>
> -       if(!down_read_trylock(&adev->reset_domain->sem))
> -               return;
> -
>         for (vmid =3D 1; vmid < 16; vmid++) {
>                 u32 tmp =3D RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>
> @@ -443,7 +439,6 @@ static void gmc_v7_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>
>         WREG32(mmVM_INVALIDATE_REQUEST, mask);
>         RREG32(mmVM_INVALIDATE_RESPONSE);
> -       up_read(&adev->reset_domain->sem);
>  }
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index ffcd79d28b9a..8dcd9b13673c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -31,7 +31,6 @@
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_gem.h"
> -#include "amdgpu_reset.h"
>
>  #include "gmc/gmc_8_1_d.h"
>  #include "gmc/gmc_8_1_sh_mask.h"
> @@ -620,9 +619,6 @@ static void gmc_v8_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>         u32 mask =3D 0x0;
>         int vmid;
>
> -       if(!down_read_trylock(&adev->reset_domain->sem))
> -               return;
> -
>         for (vmid =3D 1; vmid < 16; vmid++) {
>                 u32 tmp =3D RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>
> @@ -633,7 +629,6 @@ static void gmc_v8_0_flush_gpu_tlb_pasid(struct amdgp=
u_device *adev,
>
>         WREG32(mmVM_INVALIDATE_REQUEST, mask);
>         RREG32(mmVM_INVALIDATE_RESPONSE);
> -       up_read(&adev->reset_domain->sem);
>  }
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 94ba16536fc2..c5df8f052f3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -64,8 +64,6 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_xgmi.h"
>
> -#include "amdgpu_reset.h"
> -
>  /* add these here since we already include dce12 headers and these are f=
or DCN */
>  #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                           =
                               0x055d
>  #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                  =
                               2
> @@ -849,8 +847,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>          * as GFXOFF under bare metal
>          */
>         if (adev->gfx.kiq[0].ring.sched.ready &&
> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> -           down_read_trylock(&adev->reset_domain->sem)) {
> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
>                 uint32_t req =3D hub->vm_inv_eng0_req + hub->eng_distance=
 * eng;
>                 uint32_t ack =3D hub->vm_inv_eng0_ack + hub->eng_distance=
 * eng;
>
> @@ -860,7 +857,6 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>                         amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack=
,
>                                                            inv_req2, 1 <<=
 vmid);
>
> -               up_read(&adev->reset_domain->sem);
>                 return;
>         }
>
> --
> 2.34.1
>
