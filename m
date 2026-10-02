Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6573CA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 18:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3516010E4A5;
	Fri,  2 Oct 2026 18:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XQfzEqa3";
	dkim-atps=neutral
Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com
 [74.125.229.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B64710E4A5
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 18:00:32 +0000 (UTC)
Received: by mail-dl2-f41.google.com with SMTP id
 a92af1059eb24-14b1b157591so147173c88.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Oct 2026 11:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790964031; cv=none;
 d=google.com; s=arc-20260327;
 b=f1aFfyufIKXpq3bjCxpSjknWA0CafPTiFxWd0koRBApm+am+354fBvvaTN3ZEe1dlu
 CVBYr+EbfBFUzfum5z8TOnVX5J2qvWXa+zE1cHkW54hpcuyjXszV5m+tIk12ku8IUBqm
 TmescBq8Nou8G9plIGaAwtHn2OLA1KzM2fYZYeZ+krqe5oyXjnTV119U/LL8nVM1J6BQ
 uwG548a3ac6jGApEVHEKe9ji2uKgDscXAbGyxsGx17RC4+GTD1oQnJV/ydh+RCHioY28
 ffJKTeU+bwlgccVnaLYKyRZc5LRAzWhx2QZCfC8jDYQeHD9iYDHGga06kOb/FxHTiO1I
 TmSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zRfRnYjNjF0lvUI4Ve4M2yqoOvKw8K7fBablx2zjV8o=;
 fh=LjTsKRGf1/9MnlH6cnacgyT+iaPM7AH5JOpirO5jmQI=;
 b=fCy++SLnce6AARUSRRHsPFykFQwKqY93niZF/ZKIT65vSaJJRuxVuPCEg+BAKuqllP
 opXWm2HP3we7ZoBX7YuluuJm4cN7TQYJ6qtSKq5i9qW9l1b/kEQlXG6TQaNac33T74l+
 jhHf9c7DM1QAHOc72/5oh+kRZVtYp2uuwIOA+8ErU/XApWCU/lphOJAVMqRYHRtGcY/h
 g/E3kNqvpL4e5TwSR12l/sULh8+9guROJbRSr7+XQcvplfKC4GnavGFP2Qf81aUDrFku
 RwvOn7GG/PhV130SoVivgiEmMSYPdTS8jVOkFvJUEdtZuP3wYUGspM9/GzjPGgcDJ7Sn
 b+0A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790964031; x=1791568831; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zRfRnYjNjF0lvUI4Ve4M2yqoOvKw8K7fBablx2zjV8o=;
 b=XQfzEqa3VRHwvLouuNmCWWGV1eXIMQ8a4BwqXUbQ/v7JvXl2p6gg4p6Hdk5OKi3MHg
 HixXyFH+MXDScvmiVQcsREpzd0aDh7MCfiXqnHwBkNDHOC+o/cC3Eh8fDI+rYXCNpnZX
 vu3Lu1uBp5pzJe+MyO0Ui3zx3DE2d12B6UB49T/4sQ3yTi2oJTd6mi1UcHUVAIGxCksQ
 cc3Jaz3HsrZca2RzulBDSz09vx4NWDPwm0D/DqM1fM1G3MD5hGW7AawAk8rqiVtWmQOE
 6Xw8kXxTeepRjYXOQGLhMwK/GFWjqQBxRFExGqLFLf4y0nWa/Lw1KbmO5YVmUdbiW3kD
 LJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790964031; x=1791568831;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zRfRnYjNjF0lvUI4Ve4M2yqoOvKw8K7fBablx2zjV8o=;
 b=aDtKMQ9esg6sSLKGX5YP6enldXzzGccYo+YT+PLEgzI1yul90duLj6F5h404/igjEr
 q4g+yQcTCkZx1kqlIeF7lnijp7ouZWyp2AKfI19Toqj+iLXcRvOqXNKYxAc8Hb6AMJAb
 QmwwR+d/7XWE9qhkCqbYWuQeTJ+6Tiv7vrdUMpZU4WEgtAxbV7NjHdrH+NIbHPjQYgjJ
 Ahu1UjH9ZLTuZZZZ+LOcXbXGVDkMUKReCsm5LB5sjpFmR+PfWmcnoTjhn4xvy2sps0/8
 OXfhVaMW1wTXqD58YqDo6miWmlZOuVr26IOU7ovfRZeR6Axc2sXL9mywFMIkEJelUIeM
 yXTw==
X-Gm-Message-State: AFuF++nCwHS6TulO+9+6XlCIKoXm+y5imxS9aWl+9ERK1BOvLaGTq6hh
 wIHlfRzC0jW5RhR3+FOahPDBxzAfrHHdyNIpnPyc2/B1qDmiYIu2OdHw/MxcWe9YqxX5bG+wyKu
 Wj3Ic4M3ZGin9oTnklKvRBIqgpUrujTA=
X-Gm-Gg: AYBFou0dPsE0uC9oKz2n/hTfBbluBcIFE/6toKhqpcZ/wJZOnmWqKRo3wxvE8tpVbmb
 qNQPnRGK4a9Ob981yBMfI956tqMdbTxnqD8Og1dai+Zuu/j3NaweNnBBaR8lccHpetB5il+MH5J
 hAP9IuR4pXgpARKCwVurUwSaAVTRXaCfloCs2ZB6P+CpySB+1W9B5VM3fK8Su2u0duDw7MPJyqp
 Liq1rGZZfSL6BNQ1NeCDIOk5qywvj5oZf8avTNZ3tkkxkr2dLTwUSO1ABV4iB7ObS46Xh2DTOqq
 NKNjNWH4qPzKoleB9iCjcJaHFwJvzntLzgcj2AerXbb0Vc1ggAkVbclF4gVWZ7CLAw20lx3TXbi
 jHxDI3sjWPdaS2T1eqI08ZzOJIlNk7f6vJh4ow8LZASeSOog57Po7
X-Received: by 2002:a05:7022:282:10b0:127:def:dd72 with SMTP id
 a92af1059eb24-14f5bff9b02mr5245975c88.2.1790964031219; Fri, 02 Oct 2026
 11:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20261002173445.1744755-1-Saleel.Kudchadker@amd.com>
In-Reply-To: <20261002173445.1744755-1-Saleel.Kudchadker@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 2 Oct 2026 14:00:18 -0400
X-Gm-Features: AclHuK9SpycXvW3DLBMoiiv0Hi4-kZKtSZd-4EYyJ6aaGulDxVr5PV1AMYi18i4
Message-ID: <CADnq5_OnS40VL-O8xbRfmBkgWK_MCG5kheU7ja=fyu5-QgM_gA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amdkfd: align SDMA doorbell base for shader
 doorbell writes
To: Saleel Kudchadker <Saleel.Kudchadker@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
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

On Fri, Oct 2, 2026 at 1:41=E2=80=AFPM Saleel Kudchadker
<Saleel.Kudchadker@amd.com> wrote:
>
> On GC 9.4.3, 9.4.4 and 9.5.0, doorbell writes issued from shaders are
> routed to an SDMA engine at 32-byte (4 doorbell index) granularity.
> SDMA engine doorbell ranges are 10 indices apart, so the range of every
> odd engine starts 2 indices into a 4-index block that begins in the
> previous engine's range. A shader ringing the doorbell of a queue on an
> odd engine therefore rings the previous engine instead. The intended
> queue never sees the doorbell, so its work stalls and the application
> hangs.
>
> Align the per-engine doorbell base up to a 4-index boundary on these
> ASICs. Each engine only uses 4 of its 10 indices, so the aligned base
> plus the queue offset stays within the engine's range. Even engines are
> already aligned, so only the doorbell IDs of odd-engine queues change.
>
> Only doorbells rung by the device itself are routed this way. Doorbell
> writes from the host, including the kernel's own SDMA rings, are not
> affected.
>
> The doorbell ID of an SDMA queue is saved in CRIU checkpoints and
> checked again on restore. A checkpoint taken before this change that
> contains an SDMA queue on an odd engine will fail to restore with
> -EINVAL. This is intentional: the restored process still holds the old
> doorbell address, so accepting the stale ID would bring back the same
> stall.
>
> Tested on MI300X with a shader-rung SDMA doorbell test: queues on odd
> engines hung before this change and complete with it.
>
> v2: use u32 instead of uint32_t for the new locals (checkpatch)
> v3: name the routing granularity, use dev->node_id, document the
>     layout invariants, describe impact
> v4: express the granularity in doorbell indices, drop unrelated
>     cleanups, explain the CRIU restore behavior, add test note
>
> Fixes: 6df442a03d1a ("drm/amdgpu: add new doorbell assignment table for a=
qua_vanjaram")
> Cc: stable@vger.kernel.org
> Signed-off-by: Saleel Kudchadker <Saleel.Kudchadker@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 32 +++++++++++++++----
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++++
>  2 files changed, 33 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6d12f9dc7f04..5e57576fba21 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -599,12 +599,32 @@ static int allocate_doorbell(struct qcm_process_dev=
ice *qpd,
>                  * we need the physical sdma engine id in order to get th=
e
>                  * correct doorbell offset.
>                  */
> -               uint32_t valid_id =3D idx_offset[qpd->dqm->dev->node_id *
> -                                              get_num_all_sdma_engines(q=
pd->dqm) +
> -                                              q->properties.sdma_engine_=
id]
> -                                               + (q->properties.sdma_que=
ue_id & 1)
> -                                               * KFD_QUEUE_DOORBELL_MIRR=
OR_OFFSET
> -                                               + (q->properties.sdma_que=
ue_id >> 1);
> +               u32 engine_base =3D idx_offset[dev->node_id *
> +                                            get_num_all_sdma_engines(qpd=
->dqm) +
> +                                            q->properties.sdma_engine_id=
];
> +               u32 valid_id;
> +
> +               /*
> +                * With the aqua_vanjaram doorbell layout, a shader doorb=
ell
> +                * write whose 32-byte block starts in the previous engin=
e's
> +                * range rings that engine instead. Engine ranges are 10
> +                * indices apart (sdma_doorbell_range =3D 20 dwords, halv=
ed for
> +                * 8-byte doorbells, in aqua_vanjaram_doorbell_index_init=
()),
> +                * which puts odd engines 2 indices into a shared block.
> +                * Aligning costs at most 2 indices, and 8 queues per eng=
ine use
> +                * only 4 of the 10, so the aligned base stays in range. =
The
> +                * 512-index mirror offset keeps the alignment.
> +                */
> +               if (KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 3) ||
> +                   KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 4, 4) ||
> +                   KFD_GC_VERSION(dev) =3D=3D IP_VERSION(9, 5, 0))
> +                       engine_base =3D ALIGN(engine_base,
> +                                           KFD_SDMA_SHADER_DOORBELL_GRAN=
ULARITY);
> +
> +               valid_id =3D engine_base +
> +                          (q->properties.sdma_queue_id & 1) *
> +                          KFD_QUEUE_DOORBELL_MIRROR_OFFSET +
> +                          (q->properties.sdma_queue_id >> 1);
>
>                 if (restore_id && *restore_id !=3D valid_id)
>                         return -EINVAL;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 2847a5ec5ede..b9a31489b1c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -133,6 +133,13 @@
>   */
>  #define KFD_QUEUE_DOORBELL_MIRROR_OFFSET 512
>
> +/*
> + * On GC 9.4.3, 9.4.4 and 9.5.0, doorbell writes issued from shaders are
> + * routed to an SDMA engine at 32-byte granularity, i.e. 4 indices with =
the
> + * 8-byte SDMA doorbells used on SOC15.
> + */
> +#define KFD_SDMA_SHADER_DOORBELL_GRANULARITY 4
> +
>  /**
>   * enum kfd_ioctl_flags - KFD ioctl flags
>   * Various flags that can be set in &amdkfd_ioctl_desc.flags to control =
how
> --
> 2.34.1
>
