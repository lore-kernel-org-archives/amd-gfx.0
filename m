Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5CCE6400C
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 20:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1024610E2E3;
	Thu, 21 Nov 2024 20:22:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KvUMc6cO";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4577E10E2E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 20:22:49 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7247888f092so155036b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 12:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732220569; x=1732825369; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoxmNgST4zdEI1Ux9zljFHxZlD2iFGA4pLFPI52a708=;
 b=KvUMc6cO7N0OaLh+9C4JYbHj8VyIhN66z0xMlwKP55k0LIs1nLayc1Ma+1iMKtyHX/
 x2RmicabhFQwAH6y7prxpxcwJ4cwsXHQHerUfvws3G86NJbMV+aCLnQ19s8es8B2Q15k
 HU3xGD0ka+wGPeCVjRzSVXjCx9iN6UI6WDt+/zQMSA//5DYRUVAxQOV95CNd9MrtvxeS
 TUxaM/WXHgXIs/Mwh+2+In2Cv+sJm4nUNyvpWdq9wKx5NDazoqYnQ0aduaxNQqGvTxbL
 4TZsSDMg1tAqUA++PjDGX2WudUx728zS+5pITr6aWSB1K2lpNLuSLdsvIEJ40CpUf92L
 mHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732220569; x=1732825369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoxmNgST4zdEI1Ux9zljFHxZlD2iFGA4pLFPI52a708=;
 b=RUvMHdD3TL+xV0U6GR/QQ0M6269YkEZMbg4+1aq1ms72YsQYjgAQwSqehx96luJCI/
 tvETOnG/f4oHlm4eRbVCVA8xPesW0oNiF2wUDxKRrg+9jWMdHc/kiGRWxFpnhQChZGtG
 pfIhkpEuiP/p2at5ivxhO9HumNkkwc9R0LrdKH+IsP4LamS+8aEirK+6p+k9broi5Chj
 PPwdYnuJpjHjFLEAIt9NhKm3W4r47RAw5KJyFc/BVXzlDNbPeRuq5nr7LL1vAvpCBz+x
 f81qp8D2gmxJgy1wh2CcXVQ7MijXMzZRYZHSSWOL7wcpcIDfGByvN8+vI/Mbq0TWhCXS
 bzwg==
X-Gm-Message-State: AOJu0YwQtD49Z9I2W1ETNv+0YJRmAoLodJQoBp4tdVRF0Axz9yEkaJlM
 +26UxDjPLxkZuZy7qT0nCj1Aba/II0PKZf3Y4nzOU7c+IAAUQorLfuu7Qk3j9OAGXzJK0ktYo12
 NubSSjrnaiICmEJzqxByUQ17j3vKV1A==
X-Gm-Gg: ASbGnct4kwpnFCNnmOHemh7lT3NKhd+T2TN8BXi581rh5dT3ls7QkjNOolJfrdEoJsk
 5ZjiPdSqrqQ4z0+kp4xd/1PO5yDut2/Y=
X-Google-Smtp-Source: AGHT+IG7SQZZ9ODufJftvcUqp1b2Ui0+JxIMnOiv2/T8DlQadOFwA8DccVQhdRDbDxeELr0icw1m+KtYem+75BaVN+E=
X-Received: by 2002:a05:6a00:1950:b0:724:bf53:34a7 with SMTP id
 d2e1a72fcca58-724df6a90eamr194220b3a.7.1732220568497; Thu, 21 Nov 2024
 12:22:48 -0800 (PST)
MIME-Version: 1.0
References: <20241121133307.594-1-shashank.sharma@amd.com>
 <20241121133307.594-10-shashank.sharma@amd.com>
In-Reply-To: <20241121133307.594-10-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Nov 2024 15:22:37 -0500
Message-ID: <CADnq5_N8Vet2n-QCNqVoWQXHb_D5iTjpd5w0-p8tqARCkooQ9Q@mail.gmail.com>
Subject: Re: [PATCH 9/9] drm/amdgpu: enable userqueue secure semaphore for GFX
 12
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>, 
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 21, 2024 at 8:33=E2=80=AFAM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>
> - Add a field in struct amdgpu_mqd_prop for userqueue
>   secure sem fence address since now we have a generic
>   file for mes_userqueue.c
> - Add secure sem fence address mqd support to gfx12 into
>   their corresponding init functions.
> - Enable secure semaphore IRQ handling
>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Signed-off-by: Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     |  2 ++
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 27 +++++++++++-----------
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 11 +--------
>  drivers/gpu/drm/amd/include/v12_structs.h  |  4 ++--
>  5 files changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 2c889cc2a59e..9c4df966fa8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -829,6 +829,7 @@ struct amdgpu_mqd_prop {
>         uint64_t shadow_addr;
>         uint64_t gds_bkup_addr;
>         uint64_t csa_addr;
> +       uint64_t fenceaddress;

I'd prefer fence_address here for readability.  With that and the
other comments on the earlier patches addressed, the series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>  };
>
>  struct amdgpu_mqd {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 0e5732795891..fc2e82eb0d64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4058,6 +4058,8 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_dev=
ice *adev, void *m,
>         mqd->gds_bkup_base_hi =3D upper_32_bits(prop->gds_bkup_addr);
>         mqd->fw_work_area_base_lo =3D prop->csa_addr & 0xFFFFFFFC;
>         mqd->fw_work_area_base_hi =3D upper_32_bits(prop->csa_addr);
> +       mqd->fenceaddress_lo =3D lower_32_bits(prop->fenceaddress);
> +       mqd->fenceaddress_hi =3D upper_32_bits(prop->fenceaddress);
>
>         return 0;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index b151a75cf88c..ff74f7d389e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -47,6 +47,7 @@
>  #include "nbif_v6_3_1.h"
>  #include "mes_v12_0.h"
>  #include "mes_userqueue.h"
> +#include "amdgpu_userq_fence.h"
>
>  #define GFX12_NUM_GFX_RINGS    1
>  #define GFX12_MEC_HPD_SIZE     2048
> @@ -2972,6 +2973,8 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_dev=
ice *adev, void *m,
>         mqd->shadow_base_hi =3D upper_32_bits(prop->shadow_addr);
>         mqd->fw_work_area_base_lo =3D prop->csa_addr & 0xFFFFFFFC;
>         mqd->fw_work_area_base_hi =3D upper_32_bits(prop->csa_addr);
> +       mqd->fenceaddress_lo =3D lower_32_bits(prop->fenceaddress);
> +       mqd->fenceaddress_hi =3D upper_32_bits(prop->fenceaddress);
>
>         return 0;
>  }
> @@ -4817,25 +4820,23 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device=
 *adev,
>                              struct amdgpu_irq_src *source,
>                              struct amdgpu_iv_entry *entry)
>  {
> -       int i;
> +       u32 doorbell_offset =3D entry->src_data[0];
>         u8 me_id, pipe_id, queue_id;
>         struct amdgpu_ring *ring;
> -       uint32_t mes_queue_id =3D entry->src_data[0];
> +       int i;
>
>         DRM_DEBUG("IH: CP EOP\n");
>
> -       if (adev->enable_mes && (mes_queue_id & AMDGPU_FENCE_MES_QUEUE_FL=
AG)) {
> -               struct amdgpu_mes_queue *queue;
> +       if (adev->enable_mes && doorbell_offset) {
> +               struct amdgpu_userq_fence_driver *fence_drv =3D NULL;
> +               struct xarray *xa =3D &adev->userq_xa;
> +               unsigned long flags;
>
> -               mes_queue_id &=3D AMDGPU_FENCE_MES_QUEUE_ID_MASK;
> -
> -               spin_lock(&adev->mes.queue_id_lock);
> -               queue =3D idr_find(&adev->mes.queue_id_idr, mes_queue_id)=
;
> -               if (queue) {
> -                       DRM_DEBUG("process mes queue id =3D %d\n", mes_qu=
eue_id);
> -                       amdgpu_fence_process(queue->ring);
> -               }
> -               spin_unlock(&adev->mes.queue_id_lock);
> +               xa_lock_irqsave(xa, flags);
> +               fence_drv =3D xa_load(xa, doorbell_offset);
> +               if (fence_drv)
> +                       amdgpu_userq_fence_driver_process(fence_drv);
> +               xa_unlock_irqrestore(xa, flags);
>         } else {
>                 me_id =3D (entry->ring_id & 0x0c) >> 2;
>                 pipe_id =3D (entry->ring_id & 0x03) >> 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index fe50c85fb2ff..93eb26f072df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -183,14 +183,6 @@ static int mes_userq_create_ctx_space(struct amdgpu_=
userq_mgr *uq_mgr,
>         return 0;
>  }
>
> -static void mes_userq_set_fence_space(struct amdgpu_usermode_queue *queu=
e)
> -{
> -       struct v11_gfx_mqd *mqd =3D queue->mqd.cpu_ptr;
> -
> -       mqd->fenceaddress_lo =3D lower_32_bits(queue->fence_drv->gpu_addr=
);
> -       mqd->fenceaddress_hi =3D upper_32_bits(queue->fence_drv->gpu_addr=
);
> -}
> -
>  static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>                                 struct drm_amdgpu_userq_in *args_in,
>                                 struct amdgpu_usermode_queue *queue)
> @@ -229,6 +221,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>         userq_props->mqd_gpu_addr =3D queue->mqd.gpu_addr;
>         userq_props->use_doorbell =3D true;
>         userq_props->doorbell_index =3D queue->doorbell_index;
> +       userq_props->fenceaddress =3D queue->fence_drv->gpu_addr;
>
>         if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>                 struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> @@ -305,8 +298,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>                 goto free_mqd;
>         }
>
> -       mes_userq_set_fence_space(queue);
> -
>         /* FW expects WPTR BOs to be mapped into GART */
>         r =3D mes_userq_create_wptr_mapping(uq_mgr, queue, userq_props->w=
ptr_gpu_addr);
>         if (r) {
> diff --git a/drivers/gpu/drm/amd/include/v12_structs.h b/drivers/gpu/drm/=
amd/include/v12_structs.h
> index 5eabab611b02..bbb6ebdc6238 100644
> --- a/drivers/gpu/drm/amd/include/v12_structs.h
> +++ b/drivers/gpu/drm/amd/include/v12_structs.h
> @@ -535,8 +535,8 @@ struct v12_gfx_mqd {
>      uint32_t reserved_507; // offset: 507  (0x1FB)
>      uint32_t reserved_508; // offset: 508  (0x1FC)
>      uint32_t reserved_509; // offset: 509  (0x1FD)
> -    uint32_t reserved_510; // offset: 510  (0x1FE)
> -    uint32_t reserved_511; // offset: 511  (0x1FF)
> +    uint32_t fenceaddress_lo; // offset: 510  (0x1FE)
> +    uint32_t fenceaddress_hi; // offset: 511  (0x1FF)
>  };
>
>  struct v12_sdma_mqd {
> --
> 2.46.2
>
