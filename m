Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F92CA1008
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 20:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E2F10E517;
	Tue,  5 Sep 2023 20:52:35 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E7E10E517
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 20:52:33 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1c4b4c40281so141363fac.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693947152; x=1694551952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFbjEQYZjy2boNkoh5aHXAe3//PvG4u3215AbMMbiM8=;
 b=AO2Er4L+IpgAgJLNUpGQ2r4VU3YJ2BXQG6rNxWaTmsMUfCWsvK7KUV7ieeswQP8d8l
 ySx3zTXt3BYNkBxr5I0zeK9dC9cToimWP3g9f2ezZyYy+Hfb6eqOYT4L5V5N9lMlIhhE
 vXRN+49thiPNTu9dtyuzlFx5yPFRzDyXTpBciuS/gwAjAjn0KW+qVYuwMrAMr77UGcLq
 VUB9oc6qJ8cSY5kslqK2Slpl76cKJex4Z97+07QAfnEs5mIuiM6gjurK7g76o0rRP19P
 QeMUAOvsdMRNfBmWrvWhF0sE0vHiBOKZjROtV4u0bjaLcrqY3UmZaAWLEYtqzd4MGHOU
 QRiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693947152; x=1694551952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFbjEQYZjy2boNkoh5aHXAe3//PvG4u3215AbMMbiM8=;
 b=aRUaA03XeXnCWLxS03VqtzyDb108KhNmSY5GIxRarvQr65CAHcSlarZ1xVwr7ImlES
 WivDY1bWsZS1KLVfXbEcDINhQaDIjGLAqM9gMp7zwDoAISco05EmXr72AoFICjXQtPvk
 sdFF/HyDGQTikVQv/a+t7HZo04cTQdeOvr/BNReHB20UIfZuslgM91UH5DkteU0CnpMW
 BlpsScK9GYyKMnS0Jh1HzFbxOcczfwcsHHur48JW7UkLfkyPo51yCVI81I4EF6SKtOMg
 F3MNVS1/4uKVLaOtiUY8jq7aBacTjF/y2IOVtdYVGBdSV3y0+XvwY5UKxDs+AXiWfmLQ
 2CPg==
X-Gm-Message-State: AOJu0YzA/VAkwC8GgFhCMxorE9ZBd8cc1rmHmjtGCyI6A+APpl2xSGyZ
 yovOeg5tod9rlyl6UAQKhDhvZBhEhnEoXgRnJu0=
X-Google-Smtp-Source: AGHT+IH4qJnRyYpLDFUGaWtrTf/Uy6EhmhlRjdd6D/KAKYoYoVkVCsjXGT0DzMMGOOElGucyrD9cublt1e2hs4t/wzk=
X-Received: by 2002:a05:6870:46a9:b0:1ba:bef6:9d80 with SMTP id
 a41-20020a05687046a900b001babef69d80mr8033698oap.4.1693947152443; Tue, 05 Sep
 2023 13:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-3-christian.koenig@amd.com>
In-Reply-To: <20230905060415.1400-3-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 16:52:21 -0400
Message-ID: <CADnq5_OMxU6pNJynp-epL3w8ZH4dN=UeFZ9yOU=Jt4w7CrtSpg@mail.gmail.com>
Subject: Re: [PATCH 02/11] drm/amdgpu: rework gmc_v10_0_flush_gpu_tlb
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

On Tue, Sep 5, 2023 at 2:20=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Move the SDMA workaround necessary for Navi 1x into a higher layer.

You could split out the register offsets code cleanup into a separate
patch.  Either way, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  48 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |   5 +-
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c |   3 +
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 159 ++++++-----------------
>  4 files changed, 97 insertions(+), 118 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index d78bd9732543..857051093900 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -575,6 +575,54 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_dev=
ice *adev)
>         return 0;
>  }
>
> +void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
> +                             uint32_t vmhub, uint32_t flush_type)
> +{
> +       struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
> +       struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub];
> +       struct dma_fence *fence;
> +       struct amdgpu_job *job;
> +       int r;
> +
> +       if (!hub->sdma_invalidation_workaround || vmid ||
> +           !adev->mman.buffer_funcs_enabled ||
> +           !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
> +           !ring->sched.ready) {
> +               adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
> +                                                  flush_type);
> +               return;
> +       }
> +
> +       /* The SDMA on Navi 1x has a bug which can theoretically result i=
n memory
> +        * corruption if an invalidation happens at the same time as an V=
A
> +        * translation. Avoid this by doing the invalidation from the SDM=
A
> +        * itself at least for GART.
> +        */
> +       mutex_lock(&adev->mman.gtt_window_lock);
> +       r =3D amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
> +                                    AMDGPU_FENCE_OWNER_UNDEFINED,
> +                                    16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> +                                    &job);
> +       if (r)
> +               goto error_alloc;
> +
> +       job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> +       job->vm_needs_flush =3D true;
> +       job->ibs->ptr[job->ibs->length_dw++] =3D ring->funcs->nop;
> +       amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> +       fence =3D amdgpu_job_submit(job);
> +       mutex_unlock(&adev->mman.gtt_window_lock);
> +
> +       dma_fence_wait(fence, false);
> +       dma_fence_put(fence);
> +
> +       return;
> +
> +error_alloc:
> +       mutex_unlock(&adev->mman.gtt_window_lock);
> +       DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
> +}
> +
>  /**
>   * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
>   * @adev: amdgpu_device pointer
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.h
> index fdc25cd559b6..9e7df2f69123 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -117,6 +117,8 @@ struct amdgpu_vmhub {
>
>         uint32_t        vm_contexts_disable;
>
> +       bool            sdma_invalidation_workaround;
> +
>         const struct amdgpu_vmhub_funcs *vmhub_funcs;
>  };
>
> @@ -335,7 +337,6 @@ struct amdgpu_gmc {
>         u64 noretry_flags;
>  };
>
> -#define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.g=
mc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
>  #define amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, type, allhub, inst) =
\
>         ((adev)->gmc.gmc_funcs->flush_gpu_tlb_pasid \
>         ((adev), (pasid), (type), (allhub), (inst)))
> @@ -401,6 +402,8 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev=
);
>  int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
>  void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
>  int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
> +void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
> +                             uint32_t vmhub, uint32_t flush_type);
>
>  extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
>  extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfxhub_v2_0.c
> index a041c6c970e1..8521c45e8f38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
> @@ -471,6 +471,9 @@ static void gfxhub_v2_0_init(struct amdgpu_device *ad=
ev)
>                 GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRU=
PT_MASK |
>                 GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTER=
RUPT_MASK;
>
> +       /* TODO: This is only needed on some Navi 1x revisions */
> +       hub->sdma_invalidation_workaround =3D true;
> +
>         hub->vmhub_funcs =3D &gfxhub_v2_0_vmhub_funcs;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v10_0.c
> index fa87a85e1017..1f70c57bcd69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -230,20 +230,49 @@ static bool gmc_v10_0_get_atc_vmid_pasid_mapping_in=
fo(
>   * by the amdgpu vm/hsa code.
>   */
>
> -static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t =
vmid,
> -                                  unsigned int vmhub, uint32_t flush_typ=
e)
> +/**
> + * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
> + *
> + * @adev: amdgpu_device pointer
> + * @vmid: vm instance to flush
> + * @vmhub: vmhub type
> + * @flush_type: the flush type
> + *
> + * Flush the TLB for the requested page table.
> + */
> +static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t=
 vmid,
> +                                       uint32_t vmhub, uint32_t flush_ty=
pe)
>  {
>         bool use_semaphore =3D gmc_v10_0_use_invalidate_semaphore(adev, v=
mhub);
>         struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub];
>         u32 inv_req =3D hub->vmhub_funcs->get_invalidate_req(vmid, flush_=
type);
> -       u32 tmp;
>         /* Use register 17 for GART */
>         const unsigned int eng =3D 17;
> -       unsigned int i;
>         unsigned char hub_ip =3D 0;
> +       u32 sem, req, ack;
> +       unsigned int i;
> +       u32 tmp;
>
> -       hub_ip =3D (vmhub =3D=3D AMDGPU_GFXHUB(0)) ?
> -                  GC_HWIP : MMHUB_HWIP;
> +       sem =3D hub->vm_inv_eng0_sem + hub->eng_distance * eng;
> +       req =3D hub->vm_inv_eng0_req + hub->eng_distance * eng;
> +       ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;
> +
> +       /* flush hdp cache */
> +       adev->hdp.funcs->flush_hdp(adev, NULL);
> +
> +       /* For SRIOV run time, driver shouldn't access the register throu=
gh MMIO
> +        * Directly use kiq to do the vm invalidation instead
> +        */
> +       if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> +           down_read_trylock(&adev->reset_domain->sem)) {
> +               amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_re=
q,
> +                               1 << vmid);
> +               up_read(&adev->reset_domain->sem);
> +               return;
> +       }
> +
> +       hub_ip =3D (vmhub =3D=3D AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP=
;
>
>         spin_lock(&adev->gmc.invalidate_lock);
>         /*
> @@ -257,9 +286,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>         if (use_semaphore) {
>                 for (i =3D 0; i < adev->usec_timeout; i++) {
>                         /* a read return value of 1 means semaphore acuqi=
re */
> -                       tmp =3D RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
> -                                        hub->eng_distance * eng, hub_ip)=
;
> -
> +                       tmp =3D RREG32_RLC_NO_KIQ(sem, hub_ip);
>                         if (tmp & 0x1)
>                                 break;
>                         udelay(1);
> @@ -269,9 +296,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>                         DRM_ERROR("Timeout waiting for sem acquire in VM =
flush!\n");
>         }
>
> -       WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
> -                         hub->eng_distance * eng,
> -                         inv_req, hub_ip);
> +       WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
>
>         /*
>          * Issue a dummy read to wait for the ACK register to be cleared
> @@ -279,14 +304,11 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_de=
vice *adev, uint32_t vmid,
>          */
>         if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) &&
>             (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 3, 0)))
> -               RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
> -                                 hub->eng_distance * eng, hub_ip);
> +               RREG32_RLC_NO_KIQ(req, hub_ip);
>
>         /* Wait for ACK with a delay.*/
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               tmp =3D RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
> -                                 hub->eng_distance * eng, hub_ip);
> -
> +               tmp =3D RREG32_RLC_NO_KIQ(ack, hub_ip);
>                 tmp &=3D 1 << vmid;
>                 if (tmp)
>                         break;
> @@ -296,109 +318,12 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_d=
evice *adev, uint32_t vmid,
>
>         /* TODO: It needs to continue working on debugging with semaphore=
 for GFXHUB as well. */
>         if (use_semaphore)
> -               /*
> -                * add semaphore release after invalidation,
> -                * write with 0 means semaphore release
> -                */
> -               WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
> -                                 hub->eng_distance * eng, 0, hub_ip);
> +               WREG32_RLC_NO_KIQ(sem, 0, hub_ip);
>
>         spin_unlock(&adev->gmc.invalidate_lock);
>
> -       if (i < adev->usec_timeout)
> -               return;
> -
> -       DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
> -}
> -
> -/**
> - * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
> - *
> - * @adev: amdgpu_device pointer
> - * @vmid: vm instance to flush
> - * @vmhub: vmhub type
> - * @flush_type: the flush type
> - *
> - * Flush the TLB for the requested page table.
> - */
> -static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t=
 vmid,
> -                                       uint32_t vmhub, uint32_t flush_ty=
pe)
> -{
> -       struct amdgpu_ring *ring =3D adev->mman.buffer_funcs_ring;
> -       struct dma_fence *fence;
> -       struct amdgpu_job *job;
> -
> -       int r;
> -
> -       /* flush hdp cache */
> -       adev->hdp.funcs->flush_hdp(adev, NULL);
> -
> -       /* For SRIOV run time, driver shouldn't access the register throu=
gh MMIO
> -        * Directly use kiq to do the vm invalidation instead
> -        */
> -       if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
> -           down_read_trylock(&adev->reset_domain->sem)) {
> -               struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub];
> -               const unsigned int eng =3D 17;
> -               u32 inv_req =3D hub->vmhub_funcs->get_invalidate_req(vmid=
, flush_type);
> -               u32 req =3D hub->vm_inv_eng0_req + hub->eng_distance * en=
g;
> -               u32 ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * en=
g;
> -
> -               amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_re=
q,
> -                               1 << vmid);
> -
> -               up_read(&adev->reset_domain->sem);
> -               return;
> -       }
> -
> -       mutex_lock(&adev->mman.gtt_window_lock);
> -
> -       if (vmhub =3D=3D AMDGPU_MMHUB0(0)) {
> -               gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB0(0), 0);
> -               mutex_unlock(&adev->mman.gtt_window_lock);
> -               return;
> -       }
> -
> -       BUG_ON(vmhub !=3D AMDGPU_GFXHUB(0));
> -
> -       if (!adev->mman.buffer_funcs_enabled ||
> -           !adev->ib_pool_ready ||
> -           amdgpu_in_reset(adev) ||
> -           ring->sched.ready =3D=3D false) {
> -               gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB(0), 0);
> -               mutex_unlock(&adev->mman.gtt_window_lock);
> -               return;
> -       }
> -
> -       /* The SDMA on Navi has a bug which can theoretically result in m=
emory
> -        * corruption if an invalidation happens at the same time as an V=
A
> -        * translation. Avoid this by doing the invalidation from the SDM=
A
> -        * itself.
> -        */
> -       r =3D amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
> -                                    AMDGPU_FENCE_OWNER_UNDEFINED,
> -                                    16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
> -                                    &job);
> -       if (r)
> -               goto error_alloc;
> -
> -       job->vm_pd_addr =3D amdgpu_gmc_pd_addr(adev->gart.bo);
> -       job->vm_needs_flush =3D true;
> -       job->ibs->ptr[job->ibs->length_dw++] =3D ring->funcs->nop;
> -       amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> -       fence =3D amdgpu_job_submit(job);
> -
> -       mutex_unlock(&adev->mman.gtt_window_lock);
> -
> -       dma_fence_wait(fence, false);
> -       dma_fence_put(fence);
> -
> -       return;
> -
> -error_alloc:
> -       mutex_unlock(&adev->mman.gtt_window_lock);
> -       DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
> +       if (i >=3D adev->usec_timeout)
> +               DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhu=
b);
>  }
>
>  /**
> --
> 2.34.1
>
