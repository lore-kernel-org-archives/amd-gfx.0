Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D615C4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 20:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E73E10FF0F;
	Wed,  1 May 2024 20:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kEFJciaH";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03CBC10FF0F
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 20:45:08 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so5251443a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 May 2024 13:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714596308; x=1715201108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPb6UUJC4B4zLamD4FLtdc5xm1WJdu3hSKHiQFijTEs=;
 b=kEFJciaHpJAwv+QP60dDl3o+hktrSint4BYjB2Di0iU3aWJ1Hs5rjN4m9BhAyN8B/j
 wi7nCt8hIDn7gka0EC2Scpsp+1nLvOfeP8YQUUn6BPQAVtvJcQrXeaLDTMgDQkKe5g8z
 lC+vYR/SkFNyT/tHZE9HPV4dTt12ebQWlRvSs9KHuU41d9Gh5LuvA+DaFEiWJ990gl8+
 iHS0URdbkBlIbUGPlpW/mVcz9C3i79cMwfPBohZdJyykb2AqlYbkhV4GxKB+fTYaHKDT
 pKOe35xeeCSHirDWEL6jrwDhaFc80Wr9ORg/JK6/2FtTCfueai9s5ezQLAMJAYrZZvTt
 mvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714596308; x=1715201108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPb6UUJC4B4zLamD4FLtdc5xm1WJdu3hSKHiQFijTEs=;
 b=H3I5bkdavJqGvGDFwqn/+fTVUFj2VgLFoFkOVUd/qOBZUfDiEdKvTg8lVtdnKbUjrt
 16CimzuuxPjQ3WFNKhs9HV0s+6cbpgJIu/Y16ek1VL+qTqXHz9XbFmcRs0wu/icmcMrF
 NjVX11q8WpjUFBKcUNFrjetf2zxj7C3R46sFxweNwce83W1UyCWM6Eo2ZWZfyH2E/DBt
 lRvaGedllzlHffZXa/7IkTERjz+Bk/t47LTveCT+uFteoJk9FT+OoLcHaAe7PE5ECur3
 fFEqcm5/iqVXxAy3NSnLvoqshD7BycOCB6veOHpRGIJzJ0lZaHNz9axUylfUR5blyHCT
 cByA==
X-Gm-Message-State: AOJu0YwpqRp0yudwgpP4AQlbxsJxjjC+WCFhS8k7bei0O1weLFt7CfcW
 krPbpne4T/LZMwxXHEDpgA9nz72mCLGtaOIzdmmFw7CXjp5LTLhhudosRhczYo5b7dY1Onk5qCF
 Kz04M+W8FfqdBFoMC2mbHHVKbP1QV1w==
X-Google-Smtp-Source: AGHT+IGG2szT8hUmT0Iy6bf2ahk3LXZNkIKVG/DG27B8s1FoGA/bpp+K7ZMYMQ/ldMdap6zCwMskoAnJB3fAIxJ05Qg=
X-Received: by 2002:a17:90a:c7c1:b0:2af:6ce2:bd2f with SMTP id
 gf1-20020a17090ac7c100b002af6ce2bd2fmr3826525pjb.1.1714596308340; Wed, 01 May
 2024 13:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-14-shashank.sharma@amd.com>
In-Reply-To: <20240426134810.1250-14-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 May 2024 16:44:56 -0400
Message-ID: <CADnq5_OQHhmPZXsPdQfygAR3=EsWMB3r3n=Y0ajJFBhA+voY+A@mail.gmail.com>
Subject: Re: [PATCH v9 13/14] drm/amdgpu: enable compute/gfx usermode queue
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

On Fri, Apr 26, 2024 at 10:27=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> From: Arvind Yadav <arvind.yadav@amd.com>
>
> This patch does the necessary changes required to
> enable compute workload support using the existing
> usermode queues infrastructure.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c           |  2 ++
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 10 +++++++++-
>  include/uapi/drm/amdgpu_drm.h                    |  1 +
>  4 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> index e516487e8db9..78d34fa7a0b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -189,7 +189,8 @@ amdgpu_userqueue_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
>         int qid, r =3D 0;
>
>         /* Usermode queues are only supported for GFX/SDMA engines as of =
now */
> -       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX && args->in.ip_type !=
=3D AMDGPU_HW_IP_DMA) {
> +       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX && args->in.ip_type !=
=3D AMDGPU_HW_IP_DMA
> +                       && args->in.ip_type !=3D AMDGPU_HW_IP_COMPUTE) {
>                 DRM_ERROR("Usermode queue doesn't support IP type %u\n", =
args->in.ip_type);
>                 return -EINVAL;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 525bd0f4d3f7..27b86f7fe949 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1350,6 +1350,7 @@ static int gfx_v11_0_sw_init(void *handle)
>                 adev->gfx.mec.num_pipe_per_mec =3D 4;
>                 adev->gfx.mec.num_queue_per_pipe =3D 4;
>                 adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_mes_v11_0_=
funcs;
> +               adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &userq_mes_v1=
1_0_funcs;
>                 break;
>         case IP_VERSION(11, 0, 1):
>         case IP_VERSION(11, 0, 4):
> @@ -1362,6 +1363,7 @@ static int gfx_v11_0_sw_init(void *handle)
>                 adev->gfx.mec.num_pipe_per_mec =3D 4;
>                 adev->gfx.mec.num_queue_per_pipe =3D 4;
>                 adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_mes_v11_0_=
funcs;
> +               adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &userq_mes_v1=
1_0_funcs;
>                 break;
>         default:
>                 adev->gfx.me.num_me =3D 1;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/g=
pu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> index a5e270eda37b..d61d80f86003 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> @@ -183,7 +183,8 @@ static int mes_v11_0_userq_create_ctx_space(struct am=
dgpu_userq_mgr *uq_mgr,
>         }
>
>         /* We don't need to set other FW objects for SDMA queues */
> -       if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA)
> +       if ((queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) ||
> +           (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE))
>                 return 0;
>
>         /* Shadow and GDS objects come directly from userspace */
> @@ -246,6 +247,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_=
userq_mgr *uq_mgr,
>         userq_props->use_doorbell =3D true;
>         userq_props->doorbell_index =3D queue->doorbell_index;
>
> +       if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
> +               userq_props->eop_gpu_addr =3D mqd_user->eop_va;
> +               userq_props->hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_N=
ORMAL;
> +               userq_props->hqd_queue_priority =3D AMDGPU_GFX_QUEUE_PRIO=
RITY_MINIMUM;
> +               userq_props->hqd_active =3D false;
> +       }
> +
>         queue->userq_prop =3D userq_props;
>
>         r =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, =
userq_props);
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 22f56a30f7cb..676792ad3618 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -375,6 +375,7 @@ struct drm_amdgpu_userq_mqd {
>          * sized.
>          */
>         __u64   csa_va;
> +       __u64   eop_va;
>  };

Let's add a new mqd descriptor for compute since it's different from
gfx and sdma.  Also, can we handle the eop buffer as part of the
kernel metadata for compute user queues rather than having the user
specify it?

Alex

>
>  struct drm_amdgpu_userq_in {
> --
> 2.43.2
>
