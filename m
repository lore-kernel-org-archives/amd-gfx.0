Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A67C53219
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 18:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44A310E4D9;
	Tue, 28 Jul 2026 18:50:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fc+5UOTc";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E4F10E4D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 18:50:21 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-37f9e2642deso569a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 11:50:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785264621; cv=none;
 d=google.com; s=arc-20260327;
 b=VfdOe4bd7ptWyy3pOxc30z0kCzFDvXpMrcDXqwzYU2TGuI/cZUuBsDUkw6ZpSoCRea
 fgxpdrZqkERShig3YZeUa6IIBwzha1uEdI8I60ejffNEujXUHNNAu7uMMHCAFx3U/k/9
 0TvGKbbBb8g5Jfa8fSIwRkNNd9CpQbI4KcOi2Nj9PvBr1qKhyOUMF4yr49iDTmWeO8rW
 kKqPlG2vRgSqFOouMAuxFzpBhIpwlzCqjiQ04h4kt1GY+gbABFxUaZOWgz+zZP7nentR
 PGnxeQMvbxDPIwN+diFKAMo6SoQwRaUX9jzQYsGdGpaNC7z322HWlfBnYNl4FDuvO7ph
 2veA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vgHV+tnNQZWPxWIdaMgAR7tVyl17SlWcyRKQThG2SRE=;
 fh=wJtYjAenXUV+YGAVpzXzpZvFnIFKWwzGZvrNsGCfJ4s=;
 b=eana8AtxOEivOF4Zp3sQP3TxPTewX6Y6yw2P2Ycz9H48qkwdAfV/UMNPDZLIDDxV/+
 eAUt5LbeUMnI+6j19OnDzTEDT4k8OQmWHEq1f+k2SxklgxEs2v+BH7t8sLNJQhWNBUeA
 e3SuScap0P0iv6PDmTb5h8Wi5sxCr9BMk+9JB9hmC4ivC1eePn1fNRe48Dfh0CAW5qNL
 WLZB0WhMlXyTfppzR3xYxUfZk0IVmqfUbK8Ov7xlWpBN18LjM2IXtkb5+9O4MnE3L1E3
 EQfuQTMRbpQS5IhdjTaGj2Pj+DxMUwh23pjf3OWyaMVJpMzEX3thRwMjOsX+YWBrHG8b
 x3Aw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785264621; x=1785869421; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vgHV+tnNQZWPxWIdaMgAR7tVyl17SlWcyRKQThG2SRE=;
 b=fc+5UOTc0jUyoIS80a50poHnzPkIpvZcpdu8bb0bjwaIHv4ZoYEUL2uKhTjPyUJnlm
 u6BV+lDSLL6rTZu8gwSRbKf2aUPejlUMTR7UtkoYgfQCYBu/1T6qGw5utyvsSVclJE4l
 QUNFdYnPn/am1dNCd3TiuAMff3cXiG46lyLMbvVdq9Jk3EOMJ4igXQ/SUVVON2w7CCCD
 jYw7z6xZhY6NA96OGpwkz1RK0TpqhhQ+VqGDDOx7e4WNTA+huBdmDBrniHggY8ao1V2E
 k5pdyRYGmU2rXt1i5Wd3Qizv7FkhQT76Q9aMmowLZOpq66B99tCp0uOA8EpFlxlxE2z4
 R5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785264621; x=1785869421;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vgHV+tnNQZWPxWIdaMgAR7tVyl17SlWcyRKQThG2SRE=;
 b=Bg5l+858DfOfgb7dg11p/3Wof0jlHBqms44buyLXM0j9ZtM5RWg+sSU/Ad1gjeWHpq
 SesmXUAIMhEW2teDjM3+O0aDXR/Ao6bUlCCa3Hx/REwvHFhJslf7ZY1JcPLDfomTstQa
 u4QJTT41Z/LhLfd7S1DMq7+f1UzR8L0NoQpX5iEeAzhoDiHYJr3yA4urJHyE7jfPEGOX
 l6BK7RFvDiu6x7VwOQdZWbXZeIT1qSEzSgaMUcjghC+Y/XBcLmhFP+Y5MAci5megBqsg
 qUBfhwBs6RE55Kssh397rQu1hWFHx1LJv8Uur4nzJTrYqGY5nzgEVij9S8OM7wdWN0BS
 77sQ==
X-Gm-Message-State: AOJu0Yz2eWSqWGf9pF3PovUPS2k/F1Qw7qNDtlNzANB34+VR9Lk6HIwQ
 f66Nr4X82LtufKOUmiT39vELynVvOqXbfXLf4cR6SE6QFtC5PMB11IwFdc/VM8r46vPNB+dfYM6
 2QVKO79FKu/qie+P0cZAVzRnogwaG3IE=
X-Gm-Gg: AR+sD11EvGhSkVkyUhClbbT8+PcBG/KVYhzE7nnkbMPJLQTcSrFHQdCXEIKbHSLKb2h
 QOEopL2xZUBASSBiafWOczGVnm++UvvyxDhbKUM25XkSVTAC/cLMroNtu4a5k/BakGqViVonKX9
 u9vjZli5R/dql6L2DUUxiYyjTBNdT6lD3XaGLYSL7oWL80v0a2K56F6EW0Waarb4+30oQK9C04g
 xj++yM48QPHYSdDb5DWvBqA1gKZnBn7KEhB64yCNBzHhOVXp4j3EHIGga4g46ZGyLYiMDLQUhKp
 +tt+IyiZvoHNUbhr2ybw7rHI3l7l32bqLL2OiALohXgOVf+tQF1VVd5PppcZwIQyZquJFP2P2Aq
 pSg6jtJKBO5KnxiG/OQsd95o5K9R5GL4=
X-Received: by 2002:a17:90b:2b8b:b0:38e:480b:99a5 with SMTP id
 98e67ed59e1d1-38f6a2579a2mr3166693a91.2.1785264621154; Tue, 28 Jul 2026
 11:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260728181608.10541-1-andrew.martin@amd.com>
In-Reply-To: <20260728181608.10541-1-andrew.martin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jul 2026 14:50:09 -0400
X-Gm-Features: AUfX_mx6OpYt53tgWnQHB6anKIyJ4_rfo4Ww9z-qipxcxPywDAmNSdsDBASy3rU
Message-ID: <CADnq5_NCuSjcREYmLCm5Lnk4NQ4W1oDZy_9Cbh9JUUn_oOY8Qg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: zero SDMA mid-command save state before
 restoring user queues
To: Andrew Martin <andrew.martin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Andrew Martin <andmarti@amd.com>
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

On Tue, Jul 28, 2026 at 2:33=E2=80=AFPM Andrew Martin <andrew.martin@amd.co=
m> wrote:
>
> From: Andrew Martin <andmarti@amd.com>
>
> Applies to gfx10 (RDNA2) and gfx11 (RDNA3).
>
> The SDMA firmware's saved mid-command state for a preempted COPY_LINEAR
> (sdmax_rlcx_midcmd_data0 =3D source byte offset) has been observed to
> overshoot the packet's byte count on gfx10.3 (Navi21, XNACK off) after
> rapid quiesce/resume cycles driven by userptr/SVM eviction. On
> MAP_QUEUES the engine resumes the copy at src+offset past the buffer:
> an unmapped VA turns into a UTCL2 'Page not present' fault, a mapped
> one into silent data corruption.
>
> The silent corruption variant produces no dmesg output and is only
> detectable through application-level data integrity checks (checksums,
> validation). This makes diagnosis extremely difficult as there is no
> kernel-level indication of the failure.
>
> Zero the mid-command save area before remapping so the pending packet
> re-executes from its packet boundary (idempotent for COPY/GCR/FENCE).
> Workaround for field crashes of ROCm workloads on RDNA2/RDNA3.
>
> Signed-off-by: Andrew Martin <andmarti@amd.com>

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5475
If you are going to go this way, you should just apply the patches
attached to that ticket already since they are basically the same
fixes.  That said, It's not clear to me that this is a proper fix.
Clearing the state may prevent the issue, but it may also leave the
sdma copy in question incomplete.  We need to work with the FW teams
to understand why this is happening.

Alex

> Assisted-by: Claude:Sonnet 4-5
> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 37 ++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 51ee9c39104b..1507d371f741 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -40,6 +40,8 @@
>  #include "amdgpu_ring.h"
>  #include "amdgpu_mes.h"
>  #include "kfd_debug.h"
> +#include "v10_structs.h"
> +#include "v11_structs.h"
>
>  /* Size of the per-pipe EOP queue */
>  #define CIK_HPD_EOP_BYTES_LOG2 11
> @@ -1447,6 +1449,37 @@ static int restore_process_queues_nocpsch(struct d=
evice_queue_manager *dqm,
>         return ret;
>  }
>
> +/*
> + * Zero SDMA mid-command state before MAP_QUEUES. Firmware bug: preempte=
d
> + * COPY_LINEAR can resume at corrupted offset past buffer (silent corrup=
tion
> + * or VM fault). Re-executing from packet start is idempotent and safe.
> + */
> +static void clamp_sdma_midcmd_state(struct device_queue_manager *dqm,
> +                                   struct qcm_process_device *qpd)
> +{
> +       struct queue *q;
> +       uint32_t gc_ver =3D KFD_GC_VERSION(dqm->dev);
> +
> +       if (gc_ver < IP_VERSION(10, 1, 1) || gc_ver >=3D IP_VERSION(12, 0=
, 0))
> +               return;
> +
> +       list_for_each_entry(q, &qpd->queues_list, list) {
> +               if ((q->properties.type !=3D KFD_QUEUE_TYPE_SDMA &&
> +                    q->properties.type !=3D KFD_QUEUE_TYPE_SDMA_XGMI) ||=
 !q->mqd)
> +                       continue;
> +
> +               if (gc_ver < IP_VERSION(11, 0, 0)) {
> +                       struct v10_sdma_mqd *m =3D q->mqd;
> +
> +                       memset(&m->sdmax_rlcx_midcmd_data0, 0, 10 * sizeo=
f(uint32_t));
> +               } else {
> +                       struct v11_sdma_mqd *m =3D q->mqd;
> +
> +                       memset(&m->sdmax_rlcx_midcmd_data0, 0, 12 * sizeo=
f(uint32_t));
> +               }
> +       }
> +}
> +
>  static int restore_process_queues_cpsch(struct device_queue_manager *dqm=
,
>                                         struct qcm_process_device *qpd)
>  {
> @@ -1498,9 +1531,11 @@ static int restore_process_queues_cpsch(struct dev=
ice_queue_manager *dqm,
>                         }
>                 }
>         }
> -       if (!dqm->dev->kfd->shared_resources.enable_mes)
> +       if (!dqm->dev->kfd->shared_resources.enable_mes) {
> +               clamp_sdma_midcmd_state(dqm, qpd);
>                 retval =3D execute_queues_cpsch(dqm,
>                                               KFD_UNMAP_QUEUES_FILTER_DYN=
AMIC_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD);
> +       }
>         eviction_duration =3D get_jiffies_64() - pdd->last_evict_timestam=
p;
>         atomic64_add(eviction_duration, &pdd->evict_duration_counter);
>  vm_not_acquired:
> --
> 2.43.0
>
