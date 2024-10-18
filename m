Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D05D3DEA3
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 17:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E4610E384;
	Fri, 18 Oct 2024 17:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C+lAIJSr";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCCB510E384
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 17:39:58 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2e2b71fd16fso334243a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 10:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729273198; x=1729877998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBj9dHF1q4nf8ho/00pGcMn/Dpj0XfcwODiPB50lktw=;
 b=C+lAIJSrBJBE4FjIM9eWnSaObpZwEb8v1vpBSU+0Mle/e+3rPvMkMnz3AhWYWzarER
 /N8yXDJ4mie8EN6k6hNj+eKL9GcFFbprgGZqO7LPg3/Fsdp9SXr4QrJnkQK0wtxvDybf
 MKd274fDZ2AdCxxw5IBH1yQTqgexMbpwU6pgFkfBWwZlCoempf1oSbXZeV8TautcBSBO
 FTdBHQC92oX6ueHoXaC4YLoO1mTVVXtjr3Wds5a7keX0/vy1Kb+pJS2v39V4per4BgCa
 wByHbQlpHH3WR6lMs6Wl8hQWITeZ/nWAd95Z3vnG7GtTKVjaO8FfHllB7f35PU+cav6A
 Nwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729273198; x=1729877998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gBj9dHF1q4nf8ho/00pGcMn/Dpj0XfcwODiPB50lktw=;
 b=hxDX8HO8P6ZtUqJ6m+/UC8qLiW8NMjkj4JaVgYWR35kYEGIm7a7VMNBqOb9pnELFlu
 KQ8mpPup0yOtcSrin695KZ+ruJRY9c6ZeanYp6a4/Z9JEiwmQleMJ8r/B34R3hjT9D6c
 +Cr1IXABzKyaNiDXP7H22LMlTid9SeEyoPjZvMql+o5ufIfKwuOs6LDcS1ASPjtYog+V
 d6wfAyuRmDsJ4VBaktklL13m3icx0FNbaxSZeesFIC5bgTKYUTC/NKSOI1JD1rlhNF21
 JlyB4A+xIdV2NHGIcr1g+crCuB0kMdvjQCBxr3GzoLKTWiA2MAvzGPCfRi3xguIzS41B
 fnLg==
X-Gm-Message-State: AOJu0Yx+XRPT8L2Qb37gaE70cdBMadqPTZsN8BvAE1xmdEIXPSJzUHOD
 jx9gtqQw8Ptrx9Obh9JnsOcIgIoHyPv8YBGq9KDHCt3pLyyegprPumyXpjAL1iAMfw+f2Oj2b7u
 +D6BQAbu0UqGShg5etmE3XKS2II8=
X-Google-Smtp-Source: AGHT+IFRq1MxrYBX6nQfOuDASJ4dSUuCfZpdsB8n86SVX+13bpmAVQM3Crtzr/wXY5HD4S81XxAMVKi01TVafJN5I7E=
X-Received: by 2002:a17:90a:fc48:b0:2e2:c414:80a4 with SMTP id
 98e67ed59e1d1-2e561856253mr1696191a91.9.1729273198203; Fri, 18 Oct 2024
 10:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240909200614.481-1-shashank.sharma@amd.com>
 <20240909200614.481-7-shashank.sharma@amd.com>
In-Reply-To: <20240909200614.481-7-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Oct 2024 13:39:45 -0400
Message-ID: <CADnq5_PFKfWWTiZ0YJcgEgtj-2XeD1kfoaxT0B71AQbANffgHg@mail.gmail.com>
Subject: Re: [PATCH v11 06/28] drm/amdgpu: create context space for usermode
 queue
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Christian Koenig <christian.koenig@amd.com>,
 Arvind Yadav <arvind.yadav@amd.com>
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

On Mon, Sep 9, 2024 at 4:07=E2=80=AFPM Shashank Sharma <shashank.sharma@amd=
.com> wrote:
>
> The MES FW expects us to allocate at least one page as context
> space to process gang and process related context data. This
> patch creates a joint object for the same, and calculates GPU
> space offsets of these spaces.
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
> V10:
>    - making this patch independent of IP based changes, moving any
>      GFX object related changes in GFX specific patch (Alex)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Acked-by: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 33 +++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  1 +
>  2 files changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c b/drivers/g=
pu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> index 63fd48a5b8b0..2486ea2d72fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
> @@ -27,6 +27,31 @@
>  #include "mes_v11_0.h"
>  #include "mes_v11_0_userqueue.h"
>
> +#define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
> +#define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE

I just realized these are set to PAGE_SIZE.  That's probably not what
we want.  Since the PAGE_SIZE could be really large on some systems.
I would change these to align with whatever the sizes and alignments
for them are in the firmware.  Probably 4K is a good place to start,
but maybe that is bigger than we need.

Alex

> +
> +static int mes_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_=
mgr,
> +                                           struct amdgpu_usermode_queue =
*queue,
> +                                           struct drm_amdgpu_userq_in *m=
qd_user)
> +{
> +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> +       int r, size;
> +
> +       /*
> +        * The FW expects at least one page space allocated for
> +        * process ctx and gang ctx each. Create an object
> +        * for the same.
> +        */
> +       size =3D AMDGPU_USERQ_PROC_CTX_SZ + AMDGPU_USERQ_GANG_CTX_SZ;
> +       r =3D amdgpu_userqueue_create_object(uq_mgr, ctx, size);
> +       if (r) {
> +               DRM_ERROR("Failed to allocate ctx space bo for userqueue,=
 err:%d\n", r);
> +               return r;
> +       }
> +
> +       return 0;
> +}
> +
>  static int mes_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
>                                       struct drm_amdgpu_userq_in *args_in=
,
>                                       struct amdgpu_usermode_queue *queue=
)
> @@ -73,6 +98,13 @@ static int mes_v11_0_userq_mqd_create(struct amdgpu_us=
erq_mgr *uq_mgr,
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
> @@ -88,6 +120,7 @@ static void
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
> 2.45.1
>
