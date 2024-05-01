Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E856BC4345F
	for <amd-gfx@archiver.kernel.org>; Wed,  1 May 2024 20:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5509D10FA9A;
	Wed,  1 May 2024 20:41:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jPmzkXbK";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D126C10F87B
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 May 2024 20:41:38 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2b2769f017aso1788694a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 May 2024 13:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714596098; x=1715200898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ao7FvABvl1GyT4rpGxQRKH1t3OtuhFeJcFKiDwbNs0o=;
 b=jPmzkXbKSWaJC9dNWckIDz0Tc9gc5W/3p7fJoEdQmguc1zNqe7GXQVO4SpGg5zfNFU
 OVl30TSUAU2nbYHfrxda1QwfNrJNvdjohQUFAeTbMPED7FQOpOSECQcMI+X/JPZ1mIji
 QcYxdjtbP86o+K5QxWJ/Ic0qLSPOu/4AcFOr3FYLlbTOQwIV1fQ0TcthpIozoofJkKr4
 AMne745vqUquOpGSNfG1VxKXlFnYNngO3F9mtzJB3xcG4wLY36OYzTrh4qeZILxpoYwx
 5RhS6RJ8kD5UM4fd5hd9gjAQo5NsgXvzQI1T5WI1BHtawR2JcRNg3UcQSLnmRDth1yww
 GvzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714596098; x=1715200898;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ao7FvABvl1GyT4rpGxQRKH1t3OtuhFeJcFKiDwbNs0o=;
 b=oT5x4Bn7If4dYe7LhoznBjv4t1MyghWNJpxwoj779auecLwaqZy9g8nfkbW0kB6JBi
 2VHY0FxwbagsDK5utEmDXnDAm2CYvr/fyEXdX0ELbk4WYHpYfuWhJ0qC0xPtuLaTBO7M
 S5juLi6zJETWiNhZ6qpXqHxK8xn8qMQH9oOQ0JvswQbYCE91coaEyFvzUKjxGIbYEzRC
 zwvMVDimri2E+NcHOBuabHl9XwDx4V1mi1AbqV9ZEzOzf5N0AzhyQ670r7L0TAWcKNQr
 XdTsfZtaY5jbHUn8Bobdh4Kx+f48yF56NrEksJ3L2cnt8zPoipDYb1KQfymBPqYmROpj
 xBEA==
X-Gm-Message-State: AOJu0YyH3NZNA03iCPNIJMRGlK0jy/vRQTuaQYCuQSsn1OUsoTDBQyvi
 9WkGWaCFEOeq0OsUlP0RkASBKQtN+6lvGjC7YRIyExuCGRdOaJ2At6zlzysD1pY7C7adJD3hnGL
 7/FgD0ZES+yZce8WBU16FxDGsIPmmFw==
X-Google-Smtp-Source: AGHT+IERF7XvyDnVBsgIMwDn8rh/VKF0TbQOjcby7cJz9XLc7eG4RNnNmla/2qYBKYEW2kz2Ap3R7UPiyb2GAwdKwsM=
X-Received: by 2002:a17:90b:f87:b0:2a7:7a8e:bdc2 with SMTP id
 ft7-20020a17090b0f8700b002a77a8ebdc2mr3683910pjb.9.1714596098117; Wed, 01 May
 2024 13:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
 <20240426134810.1250-13-shashank.sharma@amd.com>
In-Reply-To: <20240426134810.1250-13-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 1 May 2024 16:41:26 -0400
Message-ID: <CADnq5_OKanvT1co22rxHEjBc_4RJwN4Ss5VrZ4Btx_bDFh0F2Q@mail.gmail.com>
Subject: Re: [PATCH v9 12/14] drm/amdgpu: enable SDMA usermode queues
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
> This patch does necessary modifications to enable the SDMA
> usermode queues using the existing userqueue infrastructure.
>
> V9: introduced this patch in the series
>
> Cc: Christian K=C3=B6nig <Christian.Koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c    | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c           | 3 +++
>  3 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> index 781283753804..e516487e8db9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -189,7 +189,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
>         int qid, r =3D 0;
>
>         /* Usermode queues are only supported for GFX/SDMA engines as of =
now */
> -       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX) {
> +       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX && args->in.ip_type !=
=3D AMDGPU_HW_IP_DMA) {
>                 DRM_ERROR("Usermode queue doesn't support IP type %u\n", =
args->in.ip_type);
>                 return -EINVAL;
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/g=
pu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> index a6c3037d2d1f..a5e270eda37b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> @@ -182,6 +182,10 @@ static int mes_v11_0_userq_create_ctx_space(struct a=
mdgpu_userq_mgr *uq_mgr,
>                 return r;
>         }
>
> +       /* We don't need to set other FW objects for SDMA queues */
> +       if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA)
> +               return 0;
> +
>         /* Shadow and GDS objects come directly from userspace */
>         mqd->shadow_base_lo =3D mqd_user->shadow_va & 0xFFFFFFFC;
>         mqd->shadow_base_hi =3D upper_32_bits(mqd_user->shadow_va);
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v6_0.c
> index 361835a61f2e..90354a70c807 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1225,6 +1225,8 @@ static int sdma_v6_0_early_init(void *handle)
>         return 0;
>  }
>
> +extern const struct amdgpu_userq_funcs userq_mes_v11_0_funcs;

Can you include the header rather than adding an extern?

> +
>  static int sdma_v6_0_sw_init(void *handle)
>  {
>         struct amdgpu_ring *ring;
> @@ -1265,6 +1267,7 @@ static int sdma_v6_0_sw_init(void *handle)
>                 return -EINVAL;
>         }
>
> +       adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_v11_0_funcs;
>         return r;
>  }

I think we need a new mqd descriptor in amdgpu_drm.h as well since the
sdma metadata is different from gfx and compute.

Alex

>
> --
> 2.43.2
>
