Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF382C7619A
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 21:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74F7E10F036;
	Thu, 30 Mar 2023 21:25:56 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1336B88CE4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 21:25:54 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id w133so15290838oib.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680211553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7nPE0s6LU+OSIidrfEvkxXwHQhsqxUAN7U9sE4hZiA=;
 b=bUTh2h+O5X2HGhogI4HNEt9mpJenCHu9e6LYVKZ20h8q3sqs9UnU9TLzPSU1cUrfY1
 qHPIEJmBk3UpF7HiLUKQbx7DqeChPqRB0fTRj4BNMYeB3Fe0ME+INQXa4K0YFQMAgx48
 LLZrjycRBi40BXMvcsey9xBI0tn1w5+KxnU/Csdjg4jDz6dKrLJzYpRzN4OcXNK0UGzI
 SsenjIdc7EmYW14wUUHHCz+SjWXUaOQmSYcmiIR7u4mpLGYm5RqtMeSLSkvF92eMFHZs
 4fH61Hnh693cZhNsTRi+u7tKcjTgd22nerelsT+nWodAR5zcXViNiYsjWEHK8qALpUvE
 2aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680211553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7nPE0s6LU+OSIidrfEvkxXwHQhsqxUAN7U9sE4hZiA=;
 b=YBJW2jc6+MLjBWsZEjOuTY2oqAtaya0D7/6BfZmTdPA8J3Arf2DDzrMrxOkyMlpeNT
 tOupGIoy9KnB4uiPPkCkdfrBVurJbePhZh6ZAVUJonHw3/C+xERcU02YF4j4yBNIYbxt
 /cLaf8z7aZASH8AuuWLGGjnYemet01o5MY6Ck9ZzxGJFKccvDYr5OqMRPquqesDyzKAv
 6+z0J4IlqExOET/QJzItX+k3tjoqVI0JfagqhibjRDUxSFxZJtx/loBRtUloLWWDeCVP
 rk9X1LCDlqh1jSTs9mIIl5Fh1LqVGKFe1JvSapXq8HSBO705i0MURSF+6pxNG1QHNR/W
 tgFg==
X-Gm-Message-State: AO0yUKWGF2jtfkg5JU1LNVanBv0/XLubjVcnkdr/Bu/0waVOBFet3JC+
 iRlCzdDvmPC+UzaksCXhRDZ/v0jPzjIRdVUJt70X8WPk
X-Google-Smtp-Source: AK7set/pWqA6JsGeAWMk35yX0odkN4xJ/5+/HYo5svKZsgOiM/L62AXsULR8pg37GmbPqcJknTl8tIZ0PMfjeiqfFFI=
X-Received: by 2002:a05:6808:b22:b0:387:e26:4b6f with SMTP id
 t2-20020a0568080b2200b003870e264b6fmr6380665oij.3.1680211553330; Thu, 30 Mar
 2023 14:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-7-shashank.sharma@amd.com>
In-Reply-To: <20230329160445.1300-7-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 17:25:42 -0400
Message-ID: <CADnq5_ONXNsjsAbXYB=aWEw0mm4MRw2UVPmCoS6xAEAw3Dqwhw@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] drm/amdgpu: add new parameters in v11_struct
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Arvind Yadav <arvind.yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 12:05=E2=80=AFPM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> From: Arvind Yadav <arvind.yadav@amd.com>
>
> This patch:
> - adds some new parameters defined for the gfx usermode queues
>   use cases in the v11_mqd_struct.
> - sets those parametes with the respective allocated gpu context
>   space addresses.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 21 ++++++++++++++++++-
>  drivers/gpu/drm/amd/include/v11_structs.h     | 16 +++++++-------
>  2 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> index 52de96727f98..39e90ea32fcb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
> @@ -22,6 +22,7 @@
>   */
>  #include "amdgpu.h"
>  #include "amdgpu_userqueue.h"
> +#include "v11_structs.h"
>
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> @@ -68,6 +69,22 @@ static void amdgpu_userq_gfx_v11_destroy_ctx_space(str=
uct amdgpu_userq_mgr *uq_m
>                            &ctx->cpu_ptr);
>  }
>
> +static void
> +amdgpu_userq_set_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> +                           struct amdgpu_usermode_queue *queue)
> +{
> +    struct v11_gfx_mqd *mqd =3D queue->mqd.cpu_ptr;
> +
> +    mqd->shadow_base_lo =3D queue->shadow_ctx_gpu_addr & 0xfffffffc;
> +    mqd->shadow_base_hi =3D upper_32_bits(queue->shadow_ctx_gpu_addr);
> +
> +    mqd->gds_bkup_base_lo =3D queue->gds_ctx_gpu_addr & 0xfffffffc;
> +    mqd->gds_bkup_base_hi =3D upper_32_bits(queue->gds_ctx_gpu_addr);
> +
> +    mqd->fw_work_area_base_lo =3D queue->fw_ctx_gpu_addr & 0xfffffffc;
> +    mqd->fw_work_area_base_lo =3D upper_32_bits(queue->fw_ctx_gpu_addr);
> +}
> +
>  static int
>  amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct =
amdgpu_usermode_queue *queue)
>  {
> @@ -104,12 +121,14 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq=
_mgr *uq_mgr, struct amdgpu_u
>      queue->userq_prop.use_doorbell =3D true;
>      queue->userq_prop.mqd_gpu_addr =3D mqd->gpu_addr;
>      r =3D gfx_v11_mqd->init_mqd(adev, (void *)mqd->cpu_ptr, &queue->user=
q_prop);
> -    amdgpu_bo_unreserve(mqd->obj);
>      if (r) {
> +        amdgpu_bo_unreserve(mqd->obj);
>          DRM_ERROR("Failed to init MQD for queue\n");
>          goto free_ctx;
>      }
>
> +    amdgpu_userq_set_ctx_space(uq_mgr, queue);
> +    amdgpu_bo_unreserve(mqd->obj);
>      DRM_DEBUG_DRIVER("MQD for queue %d created\n", queue->queue_id);
>      return 0;
>
> diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/=
amd/include/v11_structs.h
> index b8ff7456ae0b..f8008270f813 100644
> --- a/drivers/gpu/drm/amd/include/v11_structs.h
> +++ b/drivers/gpu/drm/amd/include/v11_structs.h
> @@ -25,14 +25,14 @@
>  #define V11_STRUCTS_H_
>
>  struct v11_gfx_mqd {
> -       uint32_t reserved_0; // offset: 0  (0x0)
> -       uint32_t reserved_1; // offset: 1  (0x1)
> -       uint32_t reserved_2; // offset: 2  (0x2)
> -       uint32_t reserved_3; // offset: 3  (0x3)
> -       uint32_t reserved_4; // offset: 4  (0x4)
> -       uint32_t reserved_5; // offset: 5  (0x5)
> -       uint32_t reserved_6; // offset: 6  (0x6)
> -       uint32_t reserved_7; // offset: 7  (0x7)
> +       uint32_t shadow_base_lo; // offset: 0  (0x0)
> +       uint32_t shadow_base_hi; // offset: 1  (0x1)
> +       uint32_t gds_bkup_base_lo; // offset: 2  (0x2)
> +       uint32_t gds_bkup_base_hi; // offset: 3  (0x3)
> +       uint32_t fw_work_area_base_lo; // offset: 4  (0x4)
> +       uint32_t fw_work_area_base_hi; // offset: 5  (0x5)
> +       uint32_t shadow_initialized; // offset: 6  (0x6)
> +       uint32_t ib_vmid; // offset: 7  (0x7)
>         uint32_t reserved_8; // offset: 8  (0x8)
>         uint32_t reserved_9; // offset: 9  (0x9)
>         uint32_t reserved_10; // offset: 10  (0xA)

We should split this hunk out as a separate patch and upstream it now.

Alex

> --
> 2.40.0
>
