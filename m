Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C777C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 21:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCB8111244A;
	Wed,  1 May 2024 21:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QXKTxVVl";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915DF11244A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 21:11:50 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so4546059a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 May 2024 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714597910; x=1715202710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WhggGPq3Lrry37rI4vafPO1NQqllE+y/Dzxiv+hrAY=;
 b=QXKTxVVlS3myrHfM9JsR53JaoZjLZFADUvsr44AyQFHk6S5c6BVgiEu+VcUPgNb+h/
 tp//zIxlEPk+BA//2Sq+AvEjP6moRloS6Pdl39lv0e/LSJABe59zWxW9T1Sj5qNbcyTh
 uLdOxJ5/77GWju6oKnrzBREQX0o/w//ADLTmeVA8wix7PUGBYUAQUzCGPADjye/kryPM
 CrccikB+3TAK0qWuLorpsw5jbQ7iUxjFtmk/OdJIupX8cCVai0iCdYJ4sL1AkTuqms3H
 rmgKJTxaBWy7bsW01+CUMkp1WIyMoaxhlLsOTsW4PkbNOfwq+E4epw64k2kmZgJ0rsUZ
 33Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714597910; x=1715202710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WhggGPq3Lrry37rI4vafPO1NQqllE+y/Dzxiv+hrAY=;
 b=fiPn4r21UwXF+6fEUY0lGQPOtNoZ5hUZnN6n7FVhNa03wGJecYCg368flQfk9X1dWj
 Lu+9XGXhYx2hMyTV0ZfAK+j9YQm9M7290ILBtxtWxC7Yi0NXe+g7TR11RtTE8DLZUWKV
 rOvm6cuF5mfzQ+GV2YsGVjyD+AGdr4l9N7wIMYEhqRverxtv8QkUogsxjNM6fc5IoOgg
 dUevDRqaQU0NdYd5vVJ2DGV/xewfbkhgwLLJt2ZEzCvKBLAxPNJEjFbV6d9CTfChu8XR
 7TB5wxuaNrDHnw6NBYnP1ARrrJzTsYNo0p+u6VCY/moCbZc10NEVRpWHZ5ya1zIGwies
 bTQg==
X-Gm-Message-State: AOJu0YwetjfKJw/graauzO1KVa+W7wssjeFmB953xqOZPtdby7HuH3GJ
 FCs8pFYMoknv3E1knAhraBAYMfgey7yCKjYYJsKdy2vyACjo9jOJKZM/CQT4J3Hly+gJv1RflcY
 RKScXBuAfukPzKVgYYqqdx5lwmPtfAA==
X-Google-Smtp-Source: AGHT+IGySU2wLISYGc/qCZeywmsV0/CisO4BXe1pZwD/QWw13RO0fZd1Albpp887LC8jswCbZs5XsnVL6wiMo3H8I+E=
X-Received: by 2002:a17:90b:38d2:b0:2a2:2dc9:7437 with SMTP id
 nn18-20020a17090b38d200b002a22dc97437mr3204722pjb.43.1714597909848; Wed, 01
 May 2024 14:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-7-shashank.sharma@amd.com>
In-Reply-To: <20240426134810.1250-7-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 May 2024 17:11:38 -0400
Message-ID: <CADnq5_P-JA3eEB0wU2n3-iw+q4yfb1Mh4rWPEEjEv61=SmoVig@mail.gmail.com>
Subject: Re: [PATCH v9 06/14] drm/amdgpu: create context space for usermode
 queue
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
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

On Fri, Apr 26, 2024 at 10:07=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> The FW expects us to allocate at least one page as context
> space to process gang, process, GDS and FW  related work.
> This patch creates a joint object for the same, and calculates
> GPU space offsets of these spaces.
>
> V1: Addressed review comments on RFC patch:
>     Alex: Make this function IP specific
>
> V2: Addressed review comments from Christian
>     - Allocate only one object for total FW space, and calculate
>       offsets for each of these objects.
>
> V3: Integration with doorbell manager
>
> V4: Review comments:
>     - Remove shadow from FW space list from cover letter (Alex)
>     - Alignment of macro (Luben)
>
> V5: Merged patches 5 and 6 into this single patch
>     Addressed review comments:
>     - Use lower_32_bits instead of mask (Christian)
>     - gfx_v11_0 instead of gfx_v11 in function names (Alex)
>     - Shadow and GDS objects are now coming from userspace (Christian,
>       Alex)
>
> V6:
>     - Add a comment to replace amdgpu_bo_create_kernel() with
>       amdgpu_bo_create() during fw_ctx object creation (Christian).
>     - Move proc_ctx_gpu_addr, gang_ctx_gpu_addr and fw_ctx_gpu_addr out
>       of generic queue structure and make it gen11 specific (Alex).
>
> V7:
>    - Using helper function to create/destroy userqueue objects.
>    - Removed FW object space allocation.
>
> V8:
>    - Updating FW object address from user values.
>
> V9:
>    - uppdated function name from gfx_v11_* to mes_v11_*
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 43 +++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/g=
pu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> index 9e7dee77d344..9f9fdcb9c294 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> @@ -27,6 +27,41 @@
>  #include "mes_v11_0.h"
>  #include "amdgpu_userqueue.h"
>
> +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> +
> +static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_=
mgr,
> +                                           struct amdgpu_usermode_queue =
*queue,
> +                                           struct drm_amdgpu_userq_mqd *=
mqd_user)
> +{
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +       struct v11_gfx_mqd *mqd =3D queue->mqd.cpu_ptr;
> +       int r, size;
> +
> +       /*
> +        * The FW expects at least one page space allocated for
> +        * process ctx and gang ctx each. Create an object
> +        * for the same.
> +        */
> +       size =3D AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
> +       r =3D amdgpu_userqueue_create_object(uq_mgr, ctx, size);

Is this per queue or per context?  I.e., is this shared with all
queues associated with an fd?

Alex

> +       if (r) {
> +               DRM_ERROR("Failed to allocate ctx space bo for userqueue,=
 err:%d\n", r);
> +               return r;
> +       }
> +
> +       /* Shadow and GDS objects come directly from userspace */
> +       mqd->shadow_base_lo =3D mqd_user->shadow_va & 0xFFFFFFFC;
> +       mqd->shadow_base_hi =3D upper_32_bits(mqd_user->shadow_va);
> +
> +       mqd->gds_bkup_base_lo =3D mqd_user->gds_va & 0xFFFFFFFC;
> +       mqd->gds_bkup_base_hi =3D upper_32_bits(mqd_user->gds_va);
> +
> +       mqd->fw_work_area_base_lo =3D mqd_user->csa_va & 0xFFFFFFFC;
> +       mqd->fw_work_area_base_hi =3D upper_32_bits(mqd_user->csa_va);
> +       return 0;
> +}
> +
>  static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>                                       struct drm_amdgpu_userq_in *args_in=
,
>                                       struct amdgpu_usermode_queue *queue=
)
> @@ -82,6 +117,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_u=
serq_mgr *uq_mgr,
>                 goto free_mqd;
>         }
>
> +       /* Create BO for FW operations */
> +       r =3D mes_v11_0_userq_create_ctx_space(uq_mgr, queue, mqd_user);
> +       if (r) {
> +               DRM_ERROR("Failed to allocate BO for userqueue (%d)", r);
> +               goto free_mqd;
> +       }
> +
>         return 0;
>
>  free_mqd:
> @@ -100,6 +142,7 @@ static void
>  mes_v11_0_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
>                             struct amdgpu_usermode_queue *queue)
>  {
> +       amdgpu_userqueue_destroy_object(uq_mgr, &queue->fw_obj);
>         kfree(queue->userq_prop);
>         amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>  }
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index bbd29f68b8d4..643f31474bd8 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -44,6 +44,7 @@ struct amdgpu_usermode_queue {
>         struct amdgpu_userq_mgr *userq_mgr;
>         struct amdgpu_vm        *vm;
>         struct amdgpu_userq_obj mqd;
> +       struct amdgpu_userq_obj fw_obj;
>  };
>
>  struct amdgpu_userq_funcs {
> --
> 2.43.2
>
