Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60077C3DA4A
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 13:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDDE010E776;
	Fri, 16 Aug 2024 13:52:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TAlv2Glu";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF4410E776
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 13:52:25 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-6e7b121be30so1570719a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 06:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723816345; x=1724421145; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8XQrmvLX1pNNdpqoOGr4L77koiJHLq1TY4T2T+Q9bB4=;
 b=TAlv2GlunvqdXH0viqQGyOS769xbq7AaLTSNYbAgkc/K2c0IDvIOwxYGI7e+YYVeQV
 nyOV3PGsyVgcR90vv3KrqfqtArVEZjsJVbDnfIldEy5WloftSO6DBmIw4dpzA5IVsbUc
 GUNntfkrMPF9Kag97rxr7z3BntgfCIQqeoq4qqem965hvJR2KtXBWugIaGSydwdjsIG1
 CUI9oq2jZb+EhB8yakf2Yr2DhmrmsrHmfIOyiBbj7ikhOGvC15eu7cv6lFRDcLYdXuCW
 /bZ5Oep2oQyBj9++ziFrJsK7Jj+J63oF4UURewvpfxR8Nb+qHwuJbAvTXnuEyWb77Akj
 B3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723816345; x=1724421145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8XQrmvLX1pNNdpqoOGr4L77koiJHLq1TY4T2T+Q9bB4=;
 b=Jfv3d/8aXHlf6ffZ25szDmS0slW5dMKQpgTuevMNmufl2t6cJC8iEIMChYNsw9BUjq
 Rt3ocLPJwHgtDFHuWPnxm4fjlv8VPhhQMewemgsbz/uJnOUNHlqAoDN+8rSmyvUx74TX
 2hqWP9uptM8dvw5GcHXJi+Y6E1o+vX27tvNDU1/BlgOg2GGNGuVdFP0LUpcvJcEVUtBn
 qIpB+nXfSFvcZh+V4FM6ENceGwkqXmmT65/xkGCr3AAac0yOTmL7PPBHAFAyScxT7dJw
 z6BKpkNUlea9xmLqfB4O7z5F49Vs3ZvnBCnFPd3LJNiR172UabTeqdS84fxLA9Knauxd
 JiUQ==
X-Gm-Message-State: AOJu0Yz4ezv43YP9Z2lbv9SqkQJj/B7qsgdD/mG94XZYNmdA0/m8sGI5
 IVvjQuOdkEbrANXHyR1DAcxlDMJso3ERYoPH7/Nu+T1gRLV6KmHqgX44ITyI/hso1akZYxu9Paa
 FH9o0hYjA7ENefdZG62bMMKBOMljjqD9c
X-Google-Smtp-Source: AGHT+IGZL6BcrOa8LeC89pDQZmvDaiYuSYUfi+enFAjSj+9VB6qgjweGBk2fSvBCmmOUhzbC2yMcjXpuS5XVZw0AjvA=
X-Received: by 2002:a17:90a:d904:b0:2c9:635b:7271 with SMTP id
 98e67ed59e1d1-2d3dfd8d9e1mr3174735a91.21.1723816344896; Fri, 16 Aug 2024
 06:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240816075447.442983-1-Trigger.Huang@amd.com>
 <20240816075447.442983-4-Trigger.Huang@amd.com>
In-Reply-To: <20240816075447.442983-4-Trigger.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Aug 2024 09:52:13 -0400
Message-ID: <CADnq5_PqbSr=1bqkKL=ocwzWcyZGjDKiNBEp5HUuP477mC=aww@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu: skip printing vram_lost if needed
To: Trigger.Huang@amd.com
Cc: amd-gfx@lists.freedesktop.org, sunil.khatri@amd.com, 
 alexander.deucher@amd.com
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

On Fri, Aug 16, 2024 at 3:55=E2=80=AFAM <Trigger.Huang@amd.com> wrote:
>
> From: Trigger Huang <Trigger.Huang@amd.com>
>
> The vm lost status can only be obtained after a GPU reset occurs, but
> sometimes a dev core dump can be happened before GPU reset. So a new
> argument is added to tell the dev core dump implementation whether to
> skip printing the vram_lost status in the dump.
> And this patch is also trying to decouple the core dump function from
> the GPU reset function, by replacing the argument amdgpu_reset_context
> with amdgpu_job to specify the context for core dump.
>
> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  | 19 ++++++++++---------
>  .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h  |  6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
>  3 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index cf2b4dd4d865..a860f52d8bb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -28,8 +28,9 @@
>  #include "atom.h"
>
>  #ifndef CONFIG_DEV_COREDUMP
> -void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> -                    struct amdgpu_reset_context *reset_context)
> +void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
> +                    bool vram_lost, struct amdgpu_job *job)
> +
>  {
>  }
>  #else
> @@ -315,7 +316,7 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, =
size_t count,
>                 }
>         }
>
> -       if (coredump->reset_vram_lost)
> +       if (!(coredump->skip_vram_check) && coredump->reset_vram_lost)
>                 drm_printf(&p, "VRAM is lost due to GPU reset!\n");

You might want to say something like:
drm_printf(&p, "VRAM lost status skipped\n");
in the skip case so we know that we skipped it so users don't assume
it wasn't lost.

Alex

>
>         return count - iter.remain;
> @@ -326,12 +327,11 @@ static void amdgpu_devcoredump_free(void *data)
>         kfree(data);
>  }
>
> -void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> -                    struct amdgpu_reset_context *reset_context)
> +void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
> +                    bool vram_lost, struct amdgpu_job *job)
>  {
> -       struct amdgpu_coredump_info *coredump;
>         struct drm_device *dev =3D adev_to_drm(adev);
> -       struct amdgpu_job *job =3D reset_context->job;
> +       struct amdgpu_coredump_info *coredump;
>         struct drm_sched_job *s_job;
>
>         coredump =3D kzalloc(sizeof(*coredump), GFP_NOWAIT);
> @@ -341,11 +341,12 @@ void amdgpu_coredump(struct amdgpu_device *adev, bo=
ol vram_lost,
>                 return;
>         }
>
> +       coredump->skip_vram_check =3D skip_vram_check;
>         coredump->reset_vram_lost =3D vram_lost;
>
> -       if (reset_context->job && reset_context->job->vm) {
> +       if (job && job->vm) {
>                 struct amdgpu_task_info *ti;
> -               struct amdgpu_vm *vm =3D reset_context->job->vm;
> +               struct amdgpu_vm *vm =3D job->vm;
>
>                 ti =3D amdgpu_vm_get_task_info_vm(vm);
>                 if (ti) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> index 52459512cb2b..c4e522e49251 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> @@ -26,7 +26,6 @@
>  #define __AMDGPU_DEV_COREDUMP_H__
>
>  #include "amdgpu.h"
> -#include "amdgpu_reset.h"
>
>  #ifdef CONFIG_DEV_COREDUMP
>
> @@ -36,12 +35,13 @@ struct amdgpu_coredump_info {
>         struct amdgpu_device            *adev;
>         struct amdgpu_task_info         reset_task_info;
>         struct timespec64               reset_time;
> +       bool                            skip_vram_check;
>         bool                            reset_vram_lost;
>         struct amdgpu_ring              *ring;
>  };
>  #endif
>
> -void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
> -                    struct amdgpu_reset_context *reset_context);
> +void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
> +                    bool vram_lost, struct amdgpu_job *job);
>
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 9885d0606b0a..825cc62cd75d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5445,7 +5445,7 @@ int amdgpu_do_asic_reset(struct list_head *device_l=
ist_handle,
>                                 vram_lost =3D amdgpu_device_check_vram_lo=
st(tmp_adev);
>
>                                 if (amdgpu_gpu_coredump && (!test_bit(AMD=
GPU_SKIP_COREDUMP, &reset_context->flags)))
> -                                       amdgpu_coredump(tmp_adev, vram_lo=
st, reset_context);
> +                                       amdgpu_coredump(tmp_adev, false, =
vram_lost, reset_context->job);
>
>                                 if (vram_lost) {
>                                         DRM_INFO("VRAM is lost due to GPU=
 reset!\n");
> --
> 2.34.1
>
