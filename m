Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A906CC83F3E
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 20:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23A9710E514;
	Tue,  5 Sep 2023 20:56:37 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20C1A10E514
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 20:56:35 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a7ca8720a0so2163082b6e.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693947394; x=1694552194; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cz7cSTMBbRUjkDN8TuhEYaH6l3Qwhxy2xQnnKqa/CG0=;
 b=KPP4z6wgRzQEAMotAO4EAOwkXV4lALFwk864xj39LiefRZM+yLzrr3eAQPhRcTwLTl
 erXv55JzAhOKb3aVtUsBv3YoF9RWbrQo5sKzrDLUJGqn/vWN0yiFLTfkOYqQ/Svy4jz+
 K8an/OAGGP359HveoDqdqttto62CAwuvu/CVoQpf2wmfpG6NVoFoKs+sphuvRfa3vWa5
 Xohk0opcXKH4z9Tij5BP+eu0Ba9XtZy/9p4kmqZ8NKQTJggXrGWR3tv+4clFfJNIboiW
 m7DVblhe0uTmHc7KKHUY2qvLAgRshpY7xNGitAreV2ed+1K9GRzuXQ1/VOGuTPZO0X91
 jbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693947394; x=1694552194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cz7cSTMBbRUjkDN8TuhEYaH6l3Qwhxy2xQnnKqa/CG0=;
 b=JYz2MySl+kqi8JNo1JmzTi+mWwpC/oUt3GsiulKsmb3nJiSOV+F26IA0X1aJ7Pzv/S
 ZwxupM0tjTrEBdjj7STcrSi8XokoqRI4wA/iKgXc8vT2n2JNljVFRa2pvuvmolPhErqn
 FN1lkZF0YLZcJzwu3DBqbok/w1uS0vdhKKmcnuzHrvooQz9D12RQCXYvBUwfYIkcMiqW
 FWYP0xxJGXQlPkcx1xIM+b58YVpvcFuN54Zw4zi7QwkfzMJVYdOwZE5MFfDkmbM1ncbi
 wrU5jzJfYasZFOLJrLrwZ5SAvXKWrOZ2yIJXVNlsCoAH9tvsMwz7tNQYQKHeP0pVht2X
 CIZw==
X-Gm-Message-State: AOJu0Yx2hvJef9USjuu8Kvmm1+U2CgxZp64NqH18Iu2QDcGHtHMt3ts9
 i8Dw8U/GTE1kUi6OcY3SRvNAEGbsNUpC+8PmDVY=
X-Google-Smtp-Source: AGHT+IH3Cd1ZuPN9y1VE0AQ0kJUZRK/FT+LeKZxsvm6vsvYrFWwLgDjWaCQeTSWYkr8tCW+eh/bb7PBA5PWYV+u92+8=
X-Received: by 2002:a05:6808:30a3:b0:3a3:e6d4:69d6 with SMTP id
 bl35-20020a05680830a300b003a3e6d469d6mr16431714oib.7.1693947392844; Tue, 05
 Sep 2023 13:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-4-christian.koenig@amd.com>
In-Reply-To: <20230905060415.1400-4-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 16:56:21 -0400
Message-ID: <CADnq5_O8E+dsbL8+aaNQDbq1Agiw_66RKfYJU9qFEWaoRgh-sA@mail.gmail.com>
Subject: Re: [PATCH 03/11] drm/amdgpu: cleanup gmc_v11_0_flush_gpu_tlb
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
> Remove leftovers from copying this from the gmc v10 code.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 108 ++++++++++---------------
>  1 file changed, 41 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index dcbba981462e..3c3ad3f17c6a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -186,27 +186,50 @@ static bool gmc_v11_0_get_vmid_pasid_mapping_info(
>         return !!(*p_pasid);
>  }
>
> -/*
> - * GART
> - * VMID 0 is the physical GPU addresses as used by the kernel.
> - * VMIDs 1-15 are used for userspace clients and are handled
> - * by the amdgpu vm/hsa code.
> +/**
> + * gmc_v11_0_flush_gpu_tlb - gart tlb flush callback
> + *
> + * @adev: amdgpu_device pointer
> + * @vmid: vm instance to flush
> + * @vmhub: which hub to flush
> + * @flush_type: the flush type
> + *
> + * Flush the TLB for the requested page table.
>   */
> -
> -static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t =
vmid,
> -                                  unsigned int vmhub, uint32_t flush_typ=
e)
> +static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t=
 vmid,
> +                                       uint32_t vmhub, uint32_t flush_ty=
pe)
>  {
>         bool use_semaphore =3D gmc_v11_0_use_invalidate_semaphore(adev, v=
mhub);
>         struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub];
>         u32 inv_req =3D hub->vmhub_funcs->get_invalidate_req(vmid, flush_=
type);
> -       u32 tmp;
>         /* Use register 17 for GART */
>         const unsigned int eng =3D 17;
> +       unsigned char hub_ip;
> +       u32 sem, req, ack;
>         unsigned int i;
> -       unsigned char hub_ip =3D 0;
> +       u32 tmp;
> +
> +       if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
> +               return;
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
> +       if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.re=
ady) &&
> +           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
> +               amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_re=
q,
> +                               1 << vmid);
> +               return;
> +       }
> +
> +       hub_ip =3D (vmhub =3D=3D AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP=
;
>
>         spin_lock(&adev->gmc.invalidate_lock);
>         /*
> @@ -220,8 +243,7 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_devi=
ce *adev, uint32_t vmid,
>         if (use_semaphore) {
>                 for (i =3D 0; i < adev->usec_timeout; i++) {
>                         /* a read return value of 1 means semaphore acuqi=
re */
> -                       tmp =3D RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
> -                                           hub->eng_distance * eng, hub_=
ip);
> +                       tmp =3D RREG32_RLC_NO_KIQ(sem, hub_ip);
>                         if (tmp & 0x1)
>                                 break;
>                         udelay(1);
> @@ -231,12 +253,11 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_de=
vice *adev, uint32_t vmid,
>                         DRM_ERROR("Timeout waiting for sem acquire in VM =
flush!\n");
>         }
>
> -       WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng,=
 inv_req, hub_ip);
> +       WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
>
>         /* Wait for ACK with a delay.*/
>         for (i =3D 0; i < adev->usec_timeout; i++) {
> -               tmp =3D RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
> -                                   hub->eng_distance * eng, hub_ip);
> +               tmp =3D RREG32_RLC_NO_KIQ(ack, hub_ip);
>                 tmp &=3D 1 << vmid;
>                 if (tmp)
>                         break;
> @@ -246,12 +267,7 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>
>         /* TODO: It needs to continue working on debugging with semaphore=
 for GFXHUB as well. */
>         if (use_semaphore)
> -               /*
> -                * add semaphore release after invalidation,
> -                * write with 0 means semaphore release
> -                */
> -               WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
> -                             hub->eng_distance * eng, 0, hub_ip);
> +               WREG32_RLC_NO_KIQ(sem, 0, hub_ip);
>
>         /* Issue additional private vm invalidation to MMHUB */
>         if ((vmhub !=3D AMDGPU_GFXHUB(0)) &&
> @@ -268,50 +284,8 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>
>         spin_unlock(&adev->gmc.invalidate_lock);
>
> -       if (i < adev->usec_timeout)
> -               return;
> -
> -       DRM_ERROR("Timeout waiting for VM flush ACK!\n");
> -}
> -
> -/**
> - * gmc_v11_0_flush_gpu_tlb - gart tlb flush callback
> - *
> - * @adev: amdgpu_device pointer
> - * @vmid: vm instance to flush
> - * @vmhub: which hub to flush
> - * @flush_type: the flush type
> - *
> - * Flush the TLB for the requested page table.
> - */
> -static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t=
 vmid,
> -                                       uint32_t vmhub, uint32_t flush_ty=
pe)
> -{
> -       if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
> -               return;
> -
> -       /* flush hdp cache */
> -       adev->hdp.funcs->flush_hdp(adev, NULL);
> -
> -       /* For SRIOV run time, driver shouldn't access the register throu=
gh MMIO
> -        * Directly use kiq to do the vm invalidation instead
> -        */
> -       if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.re=
ady) &&
> -           (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
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
> -               return;
> -       }
> -
> -       mutex_lock(&adev->mman.gtt_window_lock);
> -       gmc_v11_0_flush_vm_hub(adev, vmid, vmhub, 0);
> -       mutex_unlock(&adev->mman.gtt_window_lock);
> +       if (i >=3D adev->usec_timeout)
> +               DRM_ERROR("Timeout waiting for VM flush ACK!\n");

While you are at it, maybe switch this to use dev_err so we can better
tell what GPU in the multi-GPU case.  Same comment for the other
patches.  Either way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>  }
>
>  /**
> --
> 2.34.1
>
