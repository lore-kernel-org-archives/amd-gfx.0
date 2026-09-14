Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03FAC88E72
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 16:12:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43CD110EFFC;
	Mon, 14 Sep 2026 16:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="brE53jes";
	dkim-atps=neutral
Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com
 [74.125.227.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7011810EFF2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 16:12:53 +0000 (UTC)
Received: by mail-vs2-f12.google.com with SMTP id
 ada2fe7eead31-781d5f20ed2so85079137.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 09:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789402372; cv=none;
 d=google.com; s=arc-20260327;
 b=jje4AdJTwRrPS8u6E4Kk2qN28Te209xdpxG2buI+MeooyfRTywz0ZZWJu7Vuzr7ci2
 VLeJzs3Hsrmc93QrlLFZc4PxKuMxyecrj4I2bE2JiAN3XtrL6Bkyhk3U1KmrQzF5Fiiu
 i8bhDGGimNZVglcYupXGYgtCB92/4yIucpbFj+mmMgHdP9R+Tq9KVKQn2SglXjM9AzQv
 vOEoolvYymC1Js2drI921qzEhYBO8VsqNLa7DOkrCg93ROCNU9VB8P3fA0XyxOS52QFR
 n0db5Wvrupe2cUvi/crDK6Jx+UhdHcDbf+P1nvDgKF6HMpcNrsFmdyZ+iFwjcjiL7qbS
 aKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z/02PYO5WkcKW0ekvpAtiy3eBIUToWmxvBxdkAfUeaM=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=qTSvixDQvukTS+qralqymbs85TAbpE1Xe3YmpdinfWi5Tv8tTjr1JyHDUlkvD5K1oz
 wyy7h9IncjIUKmodvDLPdjUu7HyjiFIRPAlDzruVNNrv3QQoo+gt+mpxcf2oncQkSlUT
 e8PagyTf2sdUAeLud68LglPKiGhKTBrZNLXMkO9WZHNzCWwekwk2p084J9QwHk5Xy5Z7
 OJJXh6n5UNF0vzpcKuaB40Fk4dQPz3H3oBdCKAIXcjsmTyN1eydkucpP6piVfjhSLQ62
 uZaLegf2PRMe9Jph7c2uamXhRtSA3FwDwv/lrZ5otQMbTQGFiSc0kcbQJyRv93E4N0+s
 1Uuw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789402372; x=1790007172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z/02PYO5WkcKW0ekvpAtiy3eBIUToWmxvBxdkAfUeaM=;
 b=brE53jeserfdGCIFG/9DGMFyXSHIdzYy+VIMmEtQHZgWo/RwxvxLWs5qgEtdlVgxBG
 1Q1irUhuNMdLoPnxf5P3wnRXK9hjaH+YzDksK9t3/xYsffuX3vvI09TviWz9leC3r08u
 QVwIpN/QMsvuFmtQaM+GLD6XUbV6nT0fq3Z77pKlnPD8NM3+9i/VKSyHfQ9anUlmSuEF
 lZ9QzVIwswF1MBjzAGxoTdR9Ioq8Rbd3SKc751h+D6bwnAiMLyZMAdfYpOfpCu37A7IT
 MAVcZGpECEMrUace+6py2VOGFdS9vZ33/LFCUXfkYMHCxIjSeVPWlv7kdJfgv3IjLPd/
 pxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789402372; x=1790007172;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z/02PYO5WkcKW0ekvpAtiy3eBIUToWmxvBxdkAfUeaM=;
 b=nxDcjuVRAG+/gHWREX/QnJJRIt0s38zlmGEXH/xx/KnwX7HeLETcErJp/FEFeuiXub
 2D88nUiU0TXICjEWyMk93t1RP4AaaUuztt2PzY2BsJ7wQ1wbsVm/HLB3NqblsAcfdO5w
 WciMNNehyni4v3ob0hdURfvuduweUC2LCHn98Pn70VkSRo0L7r8gWpu0it+Ncy47ncgQ
 mmsSn0y/Nl0JNwTi1JG4aC85Q4dbjnUwPJnsqfPiFvWLvZr+sJ9SrInEJqrkpRIhIj6k
 C5M2E7TcZMIjnCqMMEgAs4HyAtfSASDfZTn4PYmbAqxknkZq+dWOvghAXBSMoxNejQDC
 NGCg==
X-Gm-Message-State: AFuF++nL2x2qSd0cPrKShx3hCwcUv46vpvsuXhHwHBtWHwFtQXlJ/I37
 EzrfkBXHHgwApmWGq/Rfyr1sECb+qJp0BxPBMs9t8fl6jGXN5O1Ehhe7N8jCiCewIha/+BG2GT8
 bJLT60Zv6K4E5Lfi18ek+6T+Q6rR5Yaw=
X-Gm-Gg: AYBFou2izX2aJJEYG6hg7SD9Lg628rMqN82VA1y2xoMeDnP69qEvJus82kZFODXWA4K
 YttC2xTn8zRf5wfN2HZ+/N9VmGs3dStMRoW7resOAFOWTHl2dNiPTcjY/QE4w2l2KWNMCIz64++
 jrVqthIsHTHdDWQxvY2uNSeVRj4LtNOnqe2zLTF7BaF2F2SRfqx4WbPKg8liSW70+KacpqSUBvN
 gz2MG/5Ci+uo91NCt2leAbDtzQlDYcilcHkOG9wS6OMXwFTlKgYw2g9/GpL9YlYRshw9WIQmuNX
 ZHFCML+nuDEVTUxQrDtoNj8S3L8xza6zXQauA9SpiBrr1uq2Vps13J2DipcT479wvHmQIXNgAhi
 zwzOi7dNKPKCC+E2lXYQTwQ/zb8bbua+rgkjktQMzDQ==
X-Received: by 2002:a05:6102:160b:b0:78f:c6f5:27c9 with SMTP id
 ada2fe7eead31-79b509df7c8mr1072980137.0.1789402372071; Mon, 14 Sep 2026
 09:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260907014629.2186163-1-Jesse.Zhang@amd.com>
 <20260907014629.2186163-8-Jesse.Zhang@amd.com>
In-Reply-To: <20260907014629.2186163-8-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Sep 2026 12:12:39 -0400
X-Gm-Features: AcwNN1W0fUW5JhEY6uj_UQ5vpYtlV8d8BHSOVjmTVHUstl-dWmE2g_sRp-erWH0
Message-ID: <CADnq5_MFHfw9mwFwEQhUz1a9EvwPbXW_MSEX8oHwLdxterZQFQ@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] drm/amdgpu/mes_userqueue: add SDMA MODIFY support
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Sun, Sep 6, 2026 at 9:46=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> Add mes_userq_sdma_mqd_update() to update an SDMA queue's MQD from a
> drm_amdgpu_userq_mqd_sdma_gfx11 (csa address, queue size, ring base),
> re-init it in place via prop->modify, and wire it into the queue_type
> dispatcher. This aligns KGD user queues with KFD's update_mqd_sdma.
>
> v3: re-init the MQD via the mqd_prop modify flag instead of a separate
>     update_mqd callback, per review.
> v4: keep the context-saved wptr instead of forwarding a user_wptr, per
>     review.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c   |   1 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 104 ++++++++++++++++++++-
>  include/uapi/drm/amdgpu_drm.h              |  12 +++
>  3 files changed, 116 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index 686c92e96025..5210ec381be7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -840,6 +840,7 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_rin=
g *ring,
>         prop->use_doorbell =3D ring->use_doorbell;
>         prop->doorbell_index =3D ring->doorbell_index;
>         prop->kernel_queue =3D true;
> +       prop->modify =3D false;
>
>         /* map_queues packet doesn't need activate the queue,
>          * so only kiq need set this field.
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 82bb4369451e..5b53e6ec8897 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -479,6 +479,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermod=
e_queue *queue,
>         userq_props->use_doorbell =3D true;
>         userq_props->doorbell_index =3D queue->doorbell_index;
>         userq_props->fence_address =3D queue->fence_drv->gpu_addr;
> +       userq_props->modify =3D false;
>
>         if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
>                 struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> @@ -573,8 +574,16 @@ static int mes_userq_mqd_create(struct amdgpu_usermo=
de_queue *queue,
>                         goto free_mqd;
>                 }
>
> +               if (mqd_gfx_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEU=
E_PERCENTAGE) {
> +                       DRM_ERROR("Queue percentage must be between 0 to =
AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
> +                       r =3D -EINVAL;
> +                       kfree(mqd_gfx_v11);
> +                       goto free_mqd;
> +               }
> +
>                 userq_props->shadow_addr =3D mqd_gfx_v11->shadow_va;
>                 userq_props->csa_addr =3D mqd_gfx_v11->csa_va;
> +               userq_props->queue_percentage =3D mqd_gfx_v11->queue_perc=
entage;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
>
> @@ -618,6 +627,13 @@ static int mes_userq_mqd_create(struct amdgpu_usermo=
de_queue *queue,
>                         goto free_mqd;
>                 }
>
> +               if (mqd_sdma_v11->queue_percentage > AMDGPU_USERQ_MAX_QUE=
UE_PERCENTAGE) {
> +                       DRM_ERROR("Queue percentage must be between 0 to =
AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE.\n");
> +                       r =3D -EINVAL;
> +                       kfree(mqd_sdma_v11);
> +                       goto free_mqd;
> +               }
> +
>                 r =3D amdgpu_bo_reserve(queue->vm->root.bo, false);
>                 if (r) {
>                         kfree(mqd_sdma_v11);
> @@ -633,6 +649,7 @@ static int mes_userq_mqd_create(struct amdgpu_usermod=
e_queue *queue,
>                 }
>
>                 userq_props->csa_addr =3D mqd_sdma_v11->csa_va;
> +               userq_props->queue_percentage =3D mqd_sdma_v11->queue_per=
centage;
>                 kfree(mqd_sdma_v11);
>         }
>
> @@ -681,6 +698,85 @@ static int mes_userq_mqd_create(struct amdgpu_usermo=
de_queue *queue,
>         return r;
>  }
>
> +static int mes_userq_sdma_mqd_update(struct amdgpu_usermode_queue *queue=
,
> +                                    struct drm_amdgpu_userq_in *args_in)
> +{
> +       int retval =3D 0;
> +       struct amdgpu_device *adev =3D queue->userq_mgr->adev;
> +       struct amdgpu_mqd_prop *userq_props =3D queue->userq_prop;
> +       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_ty=
pe];
> +       struct drm_amdgpu_userq_mqd_sdma_gfx11 *sdma_mqd_v11;
> +
> +       if (args_in->mqd_size !=3D sizeof(*sdma_mqd_v11)) {
> +               DRM_ERROR("Invalid SDMA IP MQD size\n");
> +               return -EINVAL;
> +       }
> +
> +       sdma_mqd_v11 =3D memdup_user(u64_to_user_ptr(args_in->mqd), args_=
in->mqd_size);
> +       if (IS_ERR(sdma_mqd_v11)) {
> +               DRM_ERROR("Failed to read user MQD\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (sdma_mqd_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCE=
NTAGE) {
> +               DRM_ERROR("Queue percentage must be between 0 to AMDGPU_U=
SERQ_MAX_QUEUE_PERCENTAGE.\n");
> +               kfree(sdma_mqd_v11);
> +               return -EINVAL;
> +       }
> +
> +       userq_props->csa_addr =3D sdma_mqd_v11->csa_va;
> +       userq_props->queue_size =3D args_in->queue_size;
> +       userq_props->hqd_base_gpu_addr =3D args_in->queue_va;
> +       userq_props->queue_percentage =3D sdma_mqd_v11->queue_percentage;
> +       userq_props->modify =3D true;
> +
> +       retval =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_=
ptr,
> +                                        userq_props);
> +
> +       kfree(sdma_mqd_v11);
> +       return retval;
> +}
> +
> +static int mes_userq_gfx_mqd_update(struct amdgpu_usermode_queue *queue,
> +                                   struct drm_amdgpu_userq_in *args_in)
> +{
> +       int retval =3D 0;
> +       struct amdgpu_device *adev =3D queue->userq_mgr->adev;
> +       struct amdgpu_mqd_prop *userq_props =3D queue->userq_prop;
> +       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_ty=
pe];
> +       struct drm_amdgpu_userq_mqd_gfx11 *gfx_mqd_v11;
> +
> +       if (args_in->mqd_size !=3D sizeof(*gfx_mqd_v11)) {
> +               DRM_ERROR("Invalid GFX IP MQD size\n");
> +               return -EINVAL;
> +       }
> +
> +       gfx_mqd_v11 =3D memdup_user(u64_to_user_ptr(args_in->mqd), args_i=
n->mqd_size);
> +       if (IS_ERR(gfx_mqd_v11)) {
> +               DRM_ERROR("Failed to read user MQD\n");
> +               return -ENOMEM;
> +       }
> +
> +       if (gfx_mqd_v11->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCEN=
TAGE) {
> +               DRM_ERROR("Queue percentage must be between 0 to AMDGPU_U=
SERQ_MAX_QUEUE_PERCENTAGE.\n");
> +               kfree(gfx_mqd_v11);
> +               return -EINVAL;
> +       }
> +
> +       userq_props->shadow_addr =3D gfx_mqd_v11->shadow_va;
> +       userq_props->csa_addr =3D gfx_mqd_v11->csa_va;
> +       userq_props->queue_size =3D args_in->queue_size;
> +       userq_props->hqd_base_gpu_addr =3D args_in->queue_va;
> +       userq_props->queue_percentage =3D gfx_mqd_v11->queue_percentage;
> +       userq_props->modify =3D true;
> +
> +       retval =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_=
ptr,
> +                                        userq_props);
> +
> +       kfree(gfx_mqd_v11);
> +       return retval;
> +}
> +
>  static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue *qu=
eue,
>                                         struct drm_amdgpu_userq_in *args_=
in)
>  {
> @@ -707,8 +803,10 @@ static int mes_userq_compute_mqd_update(struct amdgp=
u_usermode_queue *queue,
>
>         userq_props->queue_size =3D args_in->queue_size;
>         userq_props->hqd_base_gpu_addr =3D args_in->queue_va;
> +       userq_props->modify =3D true;
>
> -       retval =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_=
ptr, userq_props);
> +       retval =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_=
ptr,
> +                                        userq_props);
>
>  free:
>         kfree(compute_mqd_v11);
> @@ -723,6 +821,10 @@ static int mes_userq_mqd_update(struct amdgpu_usermo=
de_queue *queue, struct drm_
>         switch (queue->queue_type) {
>         case AMDGPU_HW_IP_COMPUTE:
>                 return mes_userq_compute_mqd_update(queue, args_in);
> +       case AMDGPU_HW_IP_GFX:
> +               return mes_userq_gfx_mqd_update(queue, args_in);
> +       case AMDGPU_HW_IP_DMA:
> +               return mes_userq_sdma_mqd_update(queue, args_in);
>         default:
>                 return -EINVAL;
>         }
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 2de47ff7c4d0..94497d1217b8 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -449,6 +449,12 @@ struct drm_amdgpu_userq_mqd_gfx11 {
>          * Use AMDGPU_INFO_IOCTL to find the exact size of the object.
>          */
>         __u64   csa_va;
> +       /**
> +        * @queue_percentage: Queue resource allocation percentage (0-100=
)
> +        * Defines the percentage of GPU resources allocated to this queu=
e.
> +        * A value of 0 marks the queue inactive and it will not be mappe=
d.
> +        */
> +       __u32   queue_percentage;
>  };
>
>  /* GFX V11 SDMA IP specific MQD parameters */
> @@ -459,6 +465,12 @@ struct drm_amdgpu_userq_mqd_sdma_gfx11 {
>          * to get the size.
>          */
>         __u64   csa_va;
> +       /**
> +        * @queue_percentage: Queue resource allocation percentage (0-100=
)
> +        * Defines the percentage of GPU resources allocated to this queu=
e.
> +        * A value of 0 marks the queue inactive and it will not be mappe=
d.
> +        */
> +       __u32   queue_percentage;
>  };
>
>  /* GFX V11 Compute IP specific MQD parameters */
> --
> 2.49.0
>
