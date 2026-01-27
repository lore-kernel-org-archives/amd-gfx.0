Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018A7D2FEF3
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 22:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF3710E1CC;
	Tue, 27 Jan 2026 22:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFFaw7E1";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48FAD10E1CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 22:22:59 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2b7063004daso428117eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 14:22:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769552578; cv=none;
 d=google.com; s=arc-20240605;
 b=SGMtAdH8aZwiIwrhwt4QA00vm1bQuvZACyssidvKohG+i6anm3dM6YnLpwkT0rEWTE
 RNdaf3xx8qiMqpXRf2SiGB9tWoxdjezC8GI/uEMqhG+VfwbcZBo6rkC+BuZkfxr6y+yL
 hnbSHEM0GwRTbCcWq6vknTmi52Cb4Zy66r+CYVru4JSy8CEFjROqmyzFVzcoWsLxJdoL
 Xl4pT0Qx2s6nVgyow2WDnxwgFru2Ei7Zb4VcR5Lu1ckUUNGjW1Qe3Iea7o6MoQ7rzFxd
 +CZECBzWFvm/ezP/TseF4cvp8xh5yCO6GPdJbjOIyNhDWk1xeLTe6q4vCfQ/RXZUCD9j
 V2+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9bBTwMnyyjQCxgT+QrJzOAr4bKe1pkUJYEHEXdtJ3Cc=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=ZsH/ghQIn26P299ImQX6SOZpn5NpxaBsVEGRBDlj7E+lEcKSCvyocKzv9tms+uV2cR
 yfPtyaQLcjjNcDFIvg1VJCe2hPUyig5CjPUIHf+fXmbHKji/PBm1w50FMkjY2XyhquIh
 zZZIw89AMIBhUUv2ovKCl/nkAZnVFj8rk0kH1povutlLL4UA/k1/KyNfpd5LsvzQydoI
 2fkLJ0BHB4ph5Kq9el+K96Lx3LsBXOHs6u8fHwWtPRnmCNJaN6Su2/piXJDnamJKn09a
 lwIhV7edIyu331YeJPVK9IxKobQpBt53VEq0WJEcmHy5TRtr29F/O/ZzDpNzlH+nFK7D
 /Stw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769552578; x=1770157378; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bBTwMnyyjQCxgT+QrJzOAr4bKe1pkUJYEHEXdtJ3Cc=;
 b=YFFaw7E1andntcuirAIxP05YZoUFTY3dvL2wW48RZuys5Ficy72THSRzcXkIewbMNR
 2ZAGlU8NVFEYmoPKWmCMXyBUZvx2bG25TeiMuzCdXvPJoExK/VpxjIM2agy3rfFJ/lqx
 ikDKf7wyQItqwCpx7ZDWoEqF5Ww8e0eMiloQXAXK5GHwdoAEOI5vX/eDKtp+vQQt5wqR
 eRPMbBY8RIA58poVdpw3CUjKpJ+cCxlX004vHp2cEQHCzbhJ34ojp3FUjaoSppx2SRgf
 QxCcK8aaiJPKQwoPX48gINZ8+XJ7LdL3JPhyZVOvLbabkxOnYEEwF/puRUiUB+eta+Cz
 afSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769552578; x=1770157378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9bBTwMnyyjQCxgT+QrJzOAr4bKe1pkUJYEHEXdtJ3Cc=;
 b=omKI5LUlxkYnnrUcrJ+nLdGoknS9J9/RTMYpzvDzS+01FqjA8NK0bD/Fwc/DmzFMba
 TiIhoqzEhj04BxUbwfGBGrQZeZlE4J3vrYQvuBMHqlgIGI5fppzB/djd9fbP57uZF80h
 sg/v8EsjtAxiGukCwzDDiibgp0olaxYbFw5VjXySpw11xcc+6LjCOTvJ5NgwhcLreJXu
 sNQd+qX617k1ltL16+dJn8XUJCNDFNyWJBv2zmMHSOdtNqs5xwFgOoiB7bmCdLtjQr+P
 pUWq9liJrOpoFNVgXANhe6LbbjcO6om1rApaOgEAFX+PFAjwBNZFaWkSed0ERHjnZPzN
 94yg==
X-Gm-Message-State: AOJu0YwQDea3/b9aBaqChlIWN34A+IBU2/1HcUubG2NcfkJ+JT77E4hK
 BtOZPPN9UkYaJpuBqNRSaK1hyjkGAK16ETNhP/8lYaiMliXnL1QiAELGm0uPL8H/gje56rYsSi9
 KPZx/BWLNxjMb5dCep3u3afCQcRwg1rs=
X-Gm-Gg: AZuq6aLMR3gkYoRr5VTEPQhqLdbjxN861KhKzTjwMsGYbwjcB8d493sJAD0UL/WoZbo
 VqsMuYqBH5hxRiGCCeeSgrmg0w8X4GtMPZOoBunzR+EvtmpNWikYBe5M1YewzyrxClc/4nl61xu
 SzJO1JHsm6AwPFUX7TnN8IekxGbKBPNEZzvq7deN/vrw0N/wGJm9bmgPEct0pN1UEee5tCxLsCh
 BjRNTMZBuJGaQdQxJa9YEEFGzPKu2kZD/L8T5kiQFtsbIba212EywQG0NeMMcI+yaLtEhUu
X-Received: by 2002:a05:7301:9bc5:b0:2b7:2bf3:ce06 with SMTP id
 5a478bee46e88-2b7a13d087bmr33727eec.3.1769552577933; Tue, 27 Jan 2026
 14:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
 <20260127071800.2395621-5-Jesse.Zhang@amd.com>
In-Reply-To: <20260127071800.2395621-5-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Jan 2026 17:22:46 -0500
X-Gm-Features: AZwV_QgQlX2DNr-ClxDYAOhbxoznreIYRknn4g78uvek4zxmE5eAOvjHs2vV_V8
Message-ID: <CADnq5_PZrnee9js+AoVWwN_q7ZCJ6M=RB+++mq7k=fCdLNTAgQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] drm/amdgpu: add MQD update support for user mode
 compute queues
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
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

On Tue, Jan 27, 2026 at 2:27=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> The update functionality allows dynamic adjustment of queue properties at=
 runtime,
> enabling better resource management and performance tuning for compute wo=
rkloads.
>
> v2: Return an error for non-compute queues. (Alex)
>     remove the parameter minfo
>
> V3: put the new paramters in drm_amdgpu_userq_mqd_compute_gfx11. (Alex)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   3 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 167 ++++++++++++++++++++-
>  include/uapi/drm/amdgpu_drm.h              |  29 ++++
>  3 files changed, 196 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a8f4f73fa0ce..ad136145316b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -819,6 +819,9 @@ struct amdgpu_mqd_prop {
>         uint32_t cu_mask_count;
>         uint32_t cu_flags;
>         bool is_user_cu_masked;
> +       uint32_t queue_percentage;
> +       /* used in gfx9 and gfx12.1 */
> +       uint32_t pm4_target_xcc;
>  };
>
>  struct amdgpu_mqd {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index f2309d72bbe6..ee91721f322b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -30,6 +30,26 @@
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>
> +/* Mapping queue priority to pipe priority, indexed by queue priority */
> +int amdgpu_userq_pipe_priority_map[] =3D {
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_0,
> +       AMDGPU_RING_PRIO_1,
> +       AMDGPU_RING_PRIO_1,
> +       AMDGPU_RING_PRIO_1,
> +       AMDGPU_RING_PRIO_1,
> +       AMDGPU_RING_PRIO_2,
> +       AMDGPU_RING_PRIO_2,
> +       AMDGPU_RING_PRIO_2,
> +       AMDGPU_RING_PRIO_2,
> +       AMDGPU_RING_PRIO_2
> +};
> +
>  static int
>  mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
>  {
> @@ -272,6 +292,104 @@ static int mes_userq_detect_and_reset(struct amdgpu=
_device *adev,
>         return r;
>  }
>
> +/**
> + * amdgpu_userq_set_compute_mqd - Parse compute MQD and update queue pro=
ps
> + * @queue: Target user mode queue
> + * @args: User queue input arguments
> + * @uq_mgr: User queue manager (for logging)
> + *
> + * This function only parses and validates user input, updating queue pr=
ops
> + * (no hardware MQD configuration - that's handled in MES layer)
> + * Returns: 0 on success, negative error code on failure
> + */
> +static int amdgpu_userq_set_compute_mqd(struct amdgpu_usermode_queue *qu=
eue,
> +                                          struct drm_amdgpu_userq_mqd_co=
mpute_gfx11 * compute_mqd)
> +{
> +       struct amdgpu_mqd_prop *props =3D queue->userq_prop;
> +       struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const int max_num_cus =3D 1024;
> +       size_t cu_mask_size;
> +       uint32_t count;
> +       uint32_t *cu_mask =3D NULL;
> +       int ret =3D 0;
> +
> +       if (!queue || !compute_mqd)
> +               return -EINVAL;
> +
> +       if (compute_mqd->queue_percentage > AMDGPU_USERQ_MAX_QUEUE_PERCEN=
TAGE) {
> +               DRM_ERROR("Queue percentage must be between 0 to AMDGPU_U=
SERQ_MAX_QUEUE_PERCENTAGE\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Validate priority */
> +       if (compute_mqd->hqd_queue_priority > AMDGPU_GFX_QUEUE_PRIORITY_M=
AXIMUM) {
> +               DRM_ERROR("Queue priority must be between 0 to KFD_MAX_QU=
EUE_PRIORITY\n");
> +               return -EINVAL;
> +       }
> +
> +
> +       /* validate and set CU mask property */
> +       if (compute_mqd->cu_mask_count) {
> +               if (compute_mqd->cu_mask_count % 32 !=3D 0) {
> +                       DRM_ERROR("CU mask count must be a multiple of 32=
\n");
> +                       return -EINVAL;
> +               }
> +               count =3D compute_mqd->cu_mask_count;
> +
> +               /* Limit CU mask size to prevent excessive memory allocat=
ion */
> +               if (count > max_num_cus) {
> +                       DRM_ERROR("CU mask cannot be greater than 1024 bi=
ts");
> +                       count =3D max_num_cus;
> +                       cu_mask_size =3D sizeof(uint32_t) * (max_num_cus =
/ 32);
> +               } else {
> +                       cu_mask_size =3D sizeof(uint32_t) * (compute_mqd-=
>cu_mask_count / 32);
> +               }
> +
> +               /* Copy CU mask from user space */
> +               cu_mask =3D memdup_user(u64_to_user_ptr(compute_mqd->cu_m=
ask_ptr), cu_mask_size);
> +               if (IS_ERR(cu_mask)) {
> +                       ret =3D PTR_ERR(cu_mask);
> +                       cu_mask =3D NULL;
> +                       goto cleanup;
> +               }
> +
> +               /* Validate pairwise CU mask for WGP-based ASICs */
> +               if (cu_mask && adev->ip_versions[GC_HWIP][0] >=3D IP_VERS=
ION(10, 0, 0)) {
> +                       for (int i =3D 0; i < count; i +=3D 2) {
> +                              uint32_t cu_pair =3D (cu_mask[i / 32] >> (=
i % 32)) & 0x3;
> +                              if (cu_pair && cu_pair !=3D 0x3) {
> +                                      DRM_ERROR("CUs must be adjacent pa=
irwise enabled.\n");
> +                                      kfree(cu_mask);
> +                                      cu_mask =3D NULL;
> +                                      ret =3D -EINVAL;
> +                                      goto cleanup;
> +                              }
> +                       }
> +               }
> +
> +               /* Free old CU mask */
> +               if (props->cu_mask) {
> +                       kfree(props->cu_mask);
> +                       props->cu_mask =3D NULL;
> +               }
> +
> +               props->cu_mask =3D cu_mask;
> +               props->cu_mask_count =3D count;
> +               props->is_user_cu_masked =3D (cu_mask !=3D NULL);
> +       }
> +
> +       /* Parse HQD priority and other compute properties */
> +       props->queue_percentage =3D compute_mqd->queue_percentage;
> +       props->pm4_target_xcc =3D compute_mqd->pm4_target_xcc;
> +       props->hqd_queue_priority =3D compute_mqd->hqd_queue_priority;
> +       props->hqd_pipe_priority =3D amdgpu_userq_pipe_priority_map[compu=
te_mqd->hqd_queue_priority];
> +       props->eop_gpu_addr =3D compute_mqd->eop_va;
> +
> +cleanup:
> +       return ret;
> +}
> +
>  static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>                                 struct drm_amdgpu_userq_in *args_in)
>  {
> @@ -326,9 +444,10 @@ static int mes_userq_mqd_create(struct amdgpu_usermo=
de_queue *queue,
>                 if (r)
>                         goto free_mqd;
>
> -               userq_props->eop_gpu_addr =3D compute_mqd->eop_va;
> -               userq_props->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_N=
ORMAL;
> -               userq_props->hqd_queue_priority =3D AMDGPU_GFX_QUEUE_PRIO=
RITY_MINIMUM;
> +               r =3D amdgpu_userq_set_compute_mqd(queue, compute_mqd);
> +               if (r)
> +                       goto free_mqd;
> +
>                 userq_props->hqd_active =3D false;
>                 userq_props->tmz_queue =3D
>                         mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE=
_SECURE;
> @@ -432,11 +551,52 @@ static int mes_userq_mqd_create(struct amdgpu_userm=
ode_queue *queue,
>         return r;
>  }
>
> +static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, str=
uct drm_amdgpu_userq_in *args_in)
> +{
> +       int retval =3D 0;
> +       struct amdgpu_device *adev =3D queue->userq_mgr->adev;
> +       struct amdgpu_mqd_prop *userq_props =3D queue->userq_prop;
> +       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_ty=
pe];
> +       struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd_v11;
> +       struct drm_amdgpu_userq_in *mqd_user =3D args_in;
> +
> +       if (!queue || !userq_props)
> +               return -EINVAL;
> +
> +       if (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE)
> +               return -EINVAL;
> +
> +       if (arg_in->mqd_size !=3D sizeof(*compute_mqd_v11)) {
> +               DRM_ERROR("Invalid compute IP MQD size\n");
> +               return -EINVAL;
> +       }
> +
> +       compute_mqd_v11 =3D memdup_user(u64_to_user_ptr(args_in->mqd), ar=
gs_in->mqd_size);
> +       if (IS_ERR(compute_mqd_v11)) {
> +               DRM_ERROR("Failed to read user MQD\n");
> +               return -ENOMEM;
> +       }
> +
> +       retval =3D amdgpu_userq_set_compute_mqd(queue, compute_mqd_v11);
> +       if (retval)
> +               goto free;
> +
> +       userq_props->queue_size =3D args_in->queue_size;
> +       userq_props->hqd_base_gpu_addr =3D args_in->queue_va;
> +
> +       retval =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_=
ptr, userq_props);
> +
> +free:
> +       kfree(compute_mqd_v11);
> +       return retval;
> +}
> +
>  static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
>  {
>         struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
>
>         amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
> +       kfree(queue->userq_prop->cu_mask);
>         kfree(queue->userq_prop);
>         amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
>  }
> @@ -513,6 +673,7 @@ static int mes_userq_restore(struct amdgpu_usermode_q=
ueue *queue)
>
>  const struct amdgpu_userq_funcs userq_mes_funcs =3D {
>         .mqd_create =3D mes_userq_mqd_create,
> +       .mqd_update =3D mes_userq_mqd_update,
>         .mqd_destroy =3D mes_userq_mqd_destroy,
>         .unmap =3D mes_userq_unmap,
>         .map =3D mes_userq_map,
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index ab2bf47553e1..aa9b31578c6b 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -330,6 +330,7 @@ union drm_amdgpu_ctx {
>  /* user queue IOCTL operations */
>  #define AMDGPU_USERQ_OP_CREATE 1
>  #define AMDGPU_USERQ_OP_FREE   2
> +#define AMDGPU_USERQ_OP_MODIFY 3

This should be in patch 6.  With that moved,
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>  /* queue priority levels */
>  /* low < normal low < normal high < high */
> @@ -341,6 +342,7 @@ union drm_amdgpu_ctx {
>  #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_HIGH 3 /* admin only */
>  /* for queues that need access to protected content */
>  #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
> +#define AMDGPU_USERQ_MAX_QUEUE_PERCENTAGE      100
>
>  /*
>   * This structure is a container to pass input configuration
> @@ -460,6 +462,33 @@ struct drm_amdgpu_userq_mqd_compute_gfx11 {
>          * to get the size.
>          */
>         __u64   eop_va;
> +       /**
> +        * @cu_mask_ptr: User-space pointer to CU (Compute Unit) mask arr=
ay
> +        * Points to an array of __u32 values that define which CUs are e=
nabled
> +        * for this queue (0 =3D disabled, 1 =3D enabled per bit)
> +        */
> +       __u64 cu_mask_ptr;
> +       /**
> +        * @cu_mask_count: Number of entries in the CU mask array
> +        * Total count of __u32 elements in the cu_mask_ptr array (each e=
lement
> +        * represents 32 CUs/WGPs)
> +        */
> +       __u32 cu_mask_count;
> +       /**
> +        * @queue_percentage: Queue resource allocation percentage (0-100=
)
> +        * Defines the percentage of GPU resources allocated to this queu=
e
> +        */
> +       __u32 queue_percentage;
> +       /**
> +        * @hqd_queue_priority: Hqd Queue priority (0-15)
> +        * Higher values indicate higher scheduling priority for the queu=
e
> +        */
> +       __u32 hqd_queue_priority;
> +       /**
> +        * @pm4_target_xcc: PM4 target XCC identifier (for gfx9/gfx12.1)
> +        * Specifies the target XCC (Cross Compute Complex) for PM4 comma=
nds
> +        */
> +       __u32 pm4_target_xcc;
>  };
>
>  /* userq signal/wait ioctl */
> --
> 2.49.0
>
