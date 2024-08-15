Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CA2C3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 16:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F47C10E16F;
	Thu, 15 Aug 2024 16:09:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mqmQCFHi";
	dkim-atps=neutral
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFEA410E16F
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 16:09:39 +0000 (UTC)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-3db1d0fca58so658173b6e.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 09:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723738179; x=1724342979; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hohbc0C9Dec2MHy8H383CSM0VaSedEdiA+XXnCQy+z4=;
 b=mqmQCFHiwjKtHuD0iSZ44lNoTxIUhE/78LRUUmrn6TvSMaqp3Cr4b+u9/QibpJT7KB
 TYoFSsggX/RtqXVTdVDxPjMWZmHBeSiuFdBWK34q22mn410XbJA1J+w3joLGtovFxweZ
 76NOUQYMbX/p6G5SMVjQtyetMWoLnX/jcRLnV7VfbjQCcWWsP0xa0HXjAl5uS0+jCrpe
 lNPGarVBe3D/xkYIiSEZZx+bNV6bfvPtPHbk5MV3tEjmKpXmkslayh7+SEQaW6e2M1Xw
 1pxH6BXgCfOcQyXUap0xGmbcF+btWOPzyco0dU7ZJ9wBSjN9XJpY0PjXrIvfXOBW8XCn
 qrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723738179; x=1724342979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hohbc0C9Dec2MHy8H383CSM0VaSedEdiA+XXnCQy+z4=;
 b=T6ahmwRBRJy7tq9XRXGRg3kmXrxAyldBRw81B5xW5Skm8dLSmLgI96o1dPUoA4W4IU
 fj9jnPgT8lb0KBK1XkxgtGQgQTevKaTrAt/9hGcJEPijs0ngWpeeenqkIjQhkW65QHpJ
 00VRYe99nDTUU/q5g1PM9OWTILlfZRR84kEPfBey/UJpcC8EfoF64YGuwz5Gk57BtVO7
 qCVBxuaknSwTGtNkqsJlesnJOxB43r6qqXWXBseT2xNjoNAgmr7SiERgTFDB23FNjzXd
 LQ/m+u2koyebS1D/7r0uSqT2lQFF4n34cb8SBpsxibmzGntQtupYUvzm+G5NaOkXf/FL
 dRxQ==
X-Gm-Message-State: AOJu0YxD+kUwkLTdsbl4yQk9TWJ5l+xchYSvhhW3qciHLWbWGQTYEv7f
 VBz6tskVIn92soSYVj3OG5P9t0wEjYHgvThDX4oZfdvFp5stvpqW6Jca6c068KKs2/1SF/wlxZo
 yTgqt8/bRnBlKrXt+5ZMepm9HU84=
X-Google-Smtp-Source: AGHT+IFB19k2XIdXtVZHOcdUBfZkfrp2N7n642A7tZtt/VS7/phEJgUV8sHPmeq7myFHS7bSBh/jvnpWsiiBvVbGkNI=
X-Received: by 2002:a05:6808:1386:b0:3da:bc74:e9c6 with SMTP id
 5614622812f47-3dd29964212mr7363696b6e.37.1723738178883; Thu, 15 Aug 2024
 09:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240815113836.399377-1-Trigger.Huang@amd.com>
 <20240815113836.399377-4-Trigger.Huang@amd.com>
In-Reply-To: <20240815113836.399377-4-Trigger.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Aug 2024 12:09:27 -0400
Message-ID: <CADnq5_MmzVx2we4a=odouhdwBZ2t=L+H_Bdrr0-WvrnoA0vMaw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Change the timing of doing coredump
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

On Thu, Aug 15, 2024 at 7:50=E2=80=AFAM <Trigger.Huang@amd.com> wrote:
>
> From: Trigger Huang <Trigger.Huang@amd.com>
>
> Do the coredump immediately after a job timeout to get a closer
> representation of GPU's error status. For other code paths that
> need to do the coredump, keep the original logic unchanged, except:
> 1,All the coredump operations will be under the control of parameter
> amdgpu_gpu_coredump
> 2, Do the ip dump and register to dev codedump system together.
>
> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 10 ++++++++++
>  2 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 69d6a5b7ca34..a8eb76d82921 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5341,15 +5341,9 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_dev=
ice *adev,
>                         }
>                 }
>
> -               if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags=
)) {
> -                       dev_info(tmp_adev->dev, "Dumping IP State\n");
> -                       /* Trigger ip dump before we reset the asic */
> -                       for (i =3D 0; i < tmp_adev->num_ip_blocks; i++)
> -                               if (tmp_adev->ip_blocks[i].version->funcs=
->dump_ip_state)
> -                                       tmp_adev->ip_blocks[i].version->f=
uncs
> -                                               ->dump_ip_state((void *)t=
mp_adev);
> -                       dev_info(tmp_adev->dev, "Dumping IP State Complet=
ed\n");
> -               }
> +               if (amdgpu_gpu_coredump &&
> +                   (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flag=
s)))
> +                       amdgpu_device_gpu_coredump_single(tmp_adev, job);
>
>                 if (need_full_reset)
>                         r =3D amdgpu_device_ip_suspend(adev);
> @@ -5444,10 +5438,6 @@ int amdgpu_do_asic_reset(struct list_head *device_=
list_handle,
>                                         goto out;
>
>                                 vram_lost =3D amdgpu_device_check_vram_lo=
st(tmp_adev);
> -
> -                               if (!test_bit(AMDGPU_SKIP_COREDUMP, &rese=
t_context->flags))
> -                                       amdgpu_coredump(tmp_adev, vram_lo=
st, reset_context);

This needs to stay here, otherwise, we won't know the status of vram_lost.

> -
>                                 if (vram_lost) {
>                                         DRM_INFO("VRAM is lost due to GPU=
 reset!\n");
>                                         amdgpu_inc_vram_lost(tmp_adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index c6a1783fc9ef..63869820c334 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -48,6 +48,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(str=
uct drm_sched_job *s_job)
>                 return DRM_GPU_SCHED_STAT_ENODEV;
>         }
>
> +       /*
> +        * Do the coredump immediately after a job timeout to get a close=
r
> +        * representation of GPU's error status.
> +        */
> +       if (amdgpu_gpu_coredump)
> +               amdgpu_device_gpu_coredump(adev, job);

The problem with doing this here is that we miss core dumps for GPU
resets that happen for reasons besides a user job timeout.  E.g.,
resets from KFD or a hang due to bad programming in a kernel context.

If you want to keep this here, I'd suggest something like:

if (!amdgpu_gpu_recovery)
     amdgu_core_dump();

That way you'll get a dump in both cases.  Maybe add a flag to skip
printing vram_lost in this case since it happens before reset so it's
irrelevant.

Alex

>
>         adev->job_hang =3D true;
>
> @@ -101,6 +107,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(s=
truct drm_sched_job *s_job)
>                 reset_context.src =3D AMDGPU_RESET_SRC_JOB;
>                 clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>
> +               /* To avoid a double coredump, as we have already done it=
 */
> +               if (amdgpu_gpu_coredump)
> +                       set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flag=
s);
> +
>                 r =3D amdgpu_device_gpu_recover(ring->adev, job, &reset_c=
ontext);
>                 if (r)
>                         dev_err(adev->dev, "GPU Recovery Failed: %d\n", r=
);
> --
> 2.34.1
>
