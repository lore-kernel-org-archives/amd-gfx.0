Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC53EE49AD
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 22:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEA410E1BA;
	Tue,  5 Sep 2023 22:51:55 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09BB10E1BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 22:51:54 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3a7781225b4so2044783b6e.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Sep 2023 15:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693954314; x=1694559114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eIWqRo+x4wwLxtN4PZRlBxMZysMn/JbKLSQBLs9KtQ8=;
 b=duh5nuTu0TkVrIlEidfeoG3s/TW6YauedHTBzrMpd/JJK38HxbqvU9joQCcp9rX4Yo
 AHiyPyneg7KM+Fp0O5/sn338SojfIMDWa4ms0/mx3L0+S8F6W5Sg0WUarAHZ8SOmG3ty
 VEntlJd9b7jtLlcSMfJemWSX+QT7JXHyNvJg1UoeK1l7DACrRvWl6yoR1s6d/N7bnS90
 GJN7aqBTTYNl5oTnPU8Ii9wneyhOKXj76JW4t57p64bc7z1FrO/F1yRljHx3l93bDbRa
 TzI9hgHDRIMQl/bcKtBKrCoQVdJCwSF3zs7/gIR8Ma6N6YyrfPvJK9TBHg30hNHyX8hS
 pI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693954314; x=1694559114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIWqRo+x4wwLxtN4PZRlBxMZysMn/JbKLSQBLs9KtQ8=;
 b=JBDK8ojOxEQNGednPY/vkLfzsLJA3Y6nzWykWJqtReJzuxxVAejDSUK3mIpmttRKni
 rGKaD8CWxZpMynaQf2agq0WfZzehtGl2vBI3gxWTp5Bed/w4QPQ7827k43LQvxj/ldIl
 wqO+FI6VMhn9+EZi2nfY8b3XPLRn7CbLUmf4olvPOaYVMtPi65esTAOmMMA/luLNBgwJ
 HbfbyXSNyeDUQtEkRXOQI4EZxIRKhGBrewPgRaYY5EbeefmvcgqjDsHJKycS7pXVIBfT
 8o6XaDjDuqcHWo/ums873DDFa2noHPigbmQ4E7pl0btV3chymquvU1LImGQHQynZCc+l
 VnnQ==
X-Gm-Message-State: AOJu0Yy4vohxiesqOahBjN1FcD819q3/Iz+t3Z1Rge6sS6joxRKLcF57
 9mjCUnUN7+xtu9DC0hDJazQ+U2sN+e/zW2vOsi3qytE+JHU=
X-Google-Smtp-Source: AGHT+IETXxSwcqJUVcMa3I08403wM6kEp0+Kv6CjTXecsUcGPx69ziZUwQQes1ro3t5JvO1ZhIj+nkeCErTMwL8eBw8=
X-Received: by 2002:a05:6808:2020:b0:3a8:4af7:67b1 with SMTP id
 q32-20020a056808202000b003a84af767b1mr17273317oiw.55.1693954313987; Tue, 05
 Sep 2023 15:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-12-christian.koenig@amd.com>
In-Reply-To: <20230905060415.1400-12-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Sep 2023 18:51:42 -0400
Message-ID: <CADnq5_MUwWDcFM=xN=wB8LKM5V72kRGQKQ1oZDu00zvUvgFoVQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] drm/amdgpu: further move TLB hw workarounds a layer
 up
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

On Tue, Sep 5, 2023 at 3:00=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> For the PASID flushing we already handled that at a higher layer, apply
> those workarounds to the standard flush as well.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 +++++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 74 ++++++++-----------------
>  2 files changed, 42 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index c24252304d48..8a5381ca7713 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -597,6 +597,14 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *=
adev, uint32_t vmid,
>                 if(!down_read_trylock(&adev->reset_domain->sem))
>                         return;
>
> +               if (adev->gmc.flush_tlb_needs_extra_type_2)
> +                       adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid,
> +                                                          vmhub, 2);
> +
> +               if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type =
=3D=3D 2)
> +                       adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid,
> +                                                          vmhub, 0);
> +
>                 adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
>                                                    flush_type);
>                 up_read(&adev->reset_domain->sem);
> @@ -647,6 +655,17 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_dev=
ice *adev, uint16_t pasid,
>
>         if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
>             !down_read_trylock(&adev->reset_domain->sem)) {
> +
> +               if (adev->gmc.flush_tlb_needs_extra_type_2)
> +                       adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pa=
sid,
> +                                                                2, all_h=
ub,
> +                                                                inst);
> +
> +               if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type =
=3D=3D 2)
> +                       adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pa=
sid,
> +                                                                0, all_h=
ub,
> +                                                                inst);
> +
>                 adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
>                                                          flush_type, all_=
hub,
>                                                          inst);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index c5df8f052f3f..a1a6f4b63208 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -812,37 +812,18 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_de=
vice *adev, uint32_t vmid,
>                                         uint32_t vmhub, uint32_t flush_ty=
pe)
>  {
>         bool use_semaphore =3D gmc_v9_0_use_invalidate_semaphore(adev, vm=
hub);
> -       u32 j, inv_req, inv_req2, tmp, sem, req, ack;
> +       u32 j, inv_req, tmp, sem, req, ack;
>         const unsigned int eng =3D 17;
>         struct amdgpu_vmhub *hub;
>
>         BUG_ON(vmhub >=3D AMDGPU_MAX_VMHUBS);
>
>         hub =3D &adev->vmhub[vmhub];
> +       inv_req =3D gmc_v9_0_get_invalidate_req(vmid, flush_type);
>         sem =3D hub->vm_inv_eng0_sem + hub->eng_distance * eng;
>         req =3D hub->vm_inv_eng0_req + hub->eng_distance * eng;
>         ack =3D hub->vm_inv_eng0_ack + hub->eng_distance * eng;
>
> -       if (adev->gmc.xgmi.num_physical_nodes &&
> -           adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, 0)) {
> -               /* Vega20+XGMI caches PTEs in TC and TLB. Add a
> -                * heavy-weight TLB flush (type 2), which flushes
> -                * both. Due to a race condition with concurrent
> -                * memory accesses using the same TLB cache line, we
> -                * still need a second TLB flush after this.
> -                */
> -               inv_req =3D gmc_v9_0_get_invalidate_req(vmid, 2);
> -               inv_req2 =3D gmc_v9_0_get_invalidate_req(vmid, flush_type=
);
> -       } else if (flush_type =3D=3D 2 &&
> -                  adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 4, =
3) &&
> -                  adev->rev_id =3D=3D 0) {
> -               inv_req =3D gmc_v9_0_get_invalidate_req(vmid, 0);
> -               inv_req2 =3D gmc_v9_0_get_invalidate_req(vmid, flush_type=
);
> -       } else {
> -               inv_req =3D gmc_v9_0_get_invalidate_req(vmid, flush_type)=
;
> -               inv_req2 =3D 0;
> -       }
> -
>         /* This is necessary for a HW workaround under SRIOV as well
>          * as GFXOFF under bare metal
>          */
> @@ -853,10 +834,6 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>
>                 amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_re=
q,
>                                                    1 << vmid);
> -               if (inv_req2)
> -                       amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack=
,
> -                                                          inv_req2, 1 <<=
 vmid);
> -
>                 return;
>         }
>
> @@ -886,34 +863,29 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_de=
vice *adev, uint32_t vmid,
>                         DRM_ERROR("Timeout waiting for sem acquire in VM =
flush!\n");
>         }
>
> -       do {
> -               if (vmhub >=3D AMDGPU_MMHUB0(0))
> -                       WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
> -               else
> -                       WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
> -
> -               /*
> -                * Issue a dummy read to wait for the ACK register to
> -                * be cleared to avoid a false ACK due to the new fast
> -                * GRBM interface.
> -                */
> -               if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) &&
> -                   (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2))=
)
> -                       RREG32_NO_KIQ(req);
> +       if (vmhub >=3D AMDGPU_MMHUB0(0))
> +               WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
> +       else
> +               WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
>
> -               for (j =3D 0; j < adev->usec_timeout; j++) {
> -                       if (vmhub >=3D AMDGPU_MMHUB0(0))
> -                               tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, ack=
);
> -                       else
> -                               tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, ack);
> -                       if (tmp & (1 << vmid))
> -                               break;
> -                       udelay(1);
> -               }
> +       /*
> +        * Issue a dummy read to wait for the ACK register to
> +        * be cleared to avoid a false ACK due to the new fast
> +        * GRBM interface.
> +        */
> +       if ((vmhub =3D=3D AMDGPU_GFXHUB(0)) &&
> +           (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
> +               RREG32_NO_KIQ(req);
>
> -               inv_req =3D inv_req2;
> -               inv_req2 =3D 0;
> -       } while (inv_req);
> +       for (j =3D 0; j < adev->usec_timeout; j++) {
> +               if (vmhub >=3D AMDGPU_MMHUB0(0))
> +                       tmp =3D RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
> +               else
> +                       tmp =3D RREG32_SOC15_IP_NO_KIQ(GC, ack);
> +               if (tmp & (1 << vmid))
> +                       break;
> +               udelay(1);
> +       }
>
>         /* TODO: It needs to continue working on debugging with semaphore=
 for GFXHUB as well. */
>         if (use_semaphore) {
> --
> 2.34.1
>
