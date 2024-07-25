Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56AAC3DA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627F110E882;
	Thu, 25 Jul 2024 15:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BEC9+C3D";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F235D10E882
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:29:26 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2cd1661174cso34a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721921366; x=1722526166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTgV5WGclQrpLo9XK8FsNIB+Jnu+X8s/EUlQVOxpS/M=;
 b=BEC9+C3DqPb7Q+cFnjygX5RKKt05rXd7orKakyq2epFm9WlLEZ3lZ9FAQLlXwLvUVG
 M0tFB48KMb5FrtEqEr5A2OP7Oc4sSNOQFMWrlCG7R6rIaLjvpK1UO5IkWxI6bA/fHVe1
 ThZrWIhvXn7xwmK8Jg8izJk10SPz5ZdGjeFdXYlr25z7XnzNG8icKqTy1ecdS9dbHCLS
 Us9L9nTC9QSCqN4x2LhtRcFzV/CgHP82Ew9zd7Vzzs8EhLzr3tv4NF887dEdR008pr+i
 oWnA8R/ckT1nTDJAPCYUe6tinuiiL+kHMlIx0jzJzw5og7tRbdXshE3gx56VUzrfktya
 2Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721921366; x=1722526166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jTgV5WGclQrpLo9XK8FsNIB+Jnu+X8s/EUlQVOxpS/M=;
 b=TULp4Mo/eIJIuzYfhBgy3uFRgJQzz/ZyPQC4nYkp84OdOV0sAgfFG76qcT1Y6rjZDQ
 P6FgT3tJqC++ThtKvLVpcO79D+PDRe9eXJwbWd7kvjBRQBstsjZegmy0xVyAL8G/3bVu
 IGhCErw8fqTKoo+9R9b0CHcfoPEUWbaB4gn6cTRBGlMk3SxMMzwZvxZ3kkdyCFC0W3gV
 bCaeq41gueqAS6HiaDlPHY3OuAfpmqyX+ngo6hjWolKIQMQ8UL5K1e6Uq6pl+kfeuW5X
 gc1/yPwB6PWBziJ5zsDG/6IltsRF0CbBqQjICnQ/2CGJAnqyo84sJ++HD+bqtonPNORj
 jTZQ==
X-Gm-Message-State: AOJu0Ywp8nJ8wkptJelpZYtlMzm6yGRkdhV8DWGKa5W6IBuqZQG6AltG
 8L2sAAvglmTHB347DYOVFTGU7hkMOV4+QVS/0i3QgeHJN94kxqu+k5y8Fd8H7YuJ4r5A0yUSL4p
 Zqf/dkDDm6TlpwgrhJ65h5xCAdn+PYgdO
X-Google-Smtp-Source: AGHT+IGJJONBvyIDzHn2gmacKs5JgPTA/TMcxvUJ/weRfLLmaW+VA0EqMmd8KUWMhFjvACt3kbPGGYWtcA5IS//sDhI=
X-Received: by 2002:a17:90a:4bc6:b0:2c9:6f5e:f5c1 with SMTP id
 98e67ed59e1d1-2cf2379baa2mr3493269a91.10.1721921366081; Thu, 25 Jul 2024
 08:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jul 2024 11:29:14 -0400
Message-ID: <CADnq5_NWdzoTVOuCEOFMhC0GF+26=2z8nknADXyiLxmAs9fTzQ@mail.gmail.com>
Subject: Re: [PATCH V2 00/53] GC per queue reset
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Jul 25, 2024 at 11:20=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> This adds preliminary support for GC per queue reset.  In this
> case, only the jobs currently in the queue are lost.  If this
> fails, we fall back to a full adapter reset.
>
> V2: Fix fallbacks to full adapter reset
>     RLC safemode cleanup
>     Preliminary support for older GPUs

Forgot to add a git link as well:
https://gitlab.freedesktop.org/agd5f/linux/-/tree/amd-staging-drm-next-queu=
e-reset?ref_type=3Dheads

Alex

>
> Alex Deucher (38):
>   drm/amdgpu/gfx10: handle SDMA in KIQ map/unmap
>   drm/amdgpu/mes11: handle second gfx pipe
>   drm/amdgpu/mes: add API for legacy queue reset
>   drm/amdgpu/mes11: add API for legacy queue reset
>   drm/amdgpu/mes12: add API for legacy queue reset
>   drm/amdgpu/mes: add API for user queue reset
>   drm/amdgpu/mes11: add API for user queue reset
>   drm/amdgpu/mes12: add API for user queue reset
>   drm/amdgpu: add new ring reset callback
>   drm/amdgpu: add per ring reset support (v5)
>   drm/amdgpu/gfx11: add ring reset callbacks
>   drm/amdgpu/gfx11: rename gfx_v11_0_gfx_init_queue()
>   drm/amdgpu/gfx10: add ring reset callbacks
>   drm/amdgpu/gfx10: rework reset sequence
>   drm/amdgpu/gfx9: add ring reset callback
>   drm/amdgpu/gfx9.4.3: add ring reset callback
>   drm/amdgpu/gfx12: add ring reset callbacks
>   drm/amdgpu/gfx12: fallback to driver reset compute queue directly
>   drm/amdgpu/gfx11: enter safe mode before touching CP_INT_CNTL
>   drm/amdgpu/gfx11: add a mutex for the gfx semaphore
>   drm/amdgpu/gfx11: export gfx_v11_0_request_gfx_index_mutex()
>   drm/amdgpu/gfx9: per queue reset only on bare metal
>   drm/amdgpu/gfx10: per queue reset only on bare metal
>   drm/amdgpu/gfx11: per queue reset only on bare metal
>   drm/amdgpu/gfx12: per queue reset only on bare metal
>   drm/amdgpu/gfx9: add ring reset callback for gfx
>   drm/amdgpu/gfx8: add ring reset callback for gfx
>   drm/amdgpu/gfx7: add ring reset callback for gfx
>   drm/amdgpu/gfx9: use proper rlc safe mode helpers
>   drm/amdgpu/gfx9.4.3: use proper rlc safe mode helpers
>   drm/amdgpu/gfx10: use proper rlc safe mode helpers
>   drm/amdgpu/gfx11: use proper rlc safe mode helpers
>   drm/amdgpu/gfx12: use proper rlc safe mode helpers
>   drm/amdgpu/gfx12: use rlc safe mode for soft recovery
>   drm/amdgpu/gfx11: use rlc safe mode for soft recovery
>   drm/amdgpu/gfx10: use rlc safe mode for soft recovery
>   drm/amdgpu/gfx9.4.3: use rlc safe mode for soft recovery
>   drm/amdgpu/gfx9: use rlc safe mode for soft recovery
>
> Jiadong Zhu (13):
>   drm/amdgpu/gfx11: wait for reset done before remap
>   drm/amdgpu/gfx10: remap queue after reset successfully
>   drm/amdgpu/gfx10: wait for reset done before remap
>   drm/amdgpu/gfx9: remap queue after reset successfully
>   drm/amdgpu/gfx9: wait for reset done before remap
>   drm/amdgpu/gfx9.4.3: remap queue after reset successfully
>   drm/amdgpu/gfx_9.4.3: wait for reset done before remap
>   drm/amdgpu/gfx: add a new kiq_pm4_funcs callback for reset_hw_queue
>   drm/amdgpu/gfx9: implement reset_hw_queue for gfx9
>   drm/amdgpu/gfx9.4.3: implement reset_hw_queue for gfx9.4.3
>   drm/amdgpu/mes: modify mes api for mmio queue reset
>   drm/amdgpu/mes: implement amdgpu_mes_reset_hw_queue_mmio
>   drm/amdgpu/mes11: implement mmio queue reset for gfx11
>
> Prike Liang (2):
>   drm/amdgpu: increase the reset counter for the queue reset
>   drm/amdgpu/gfx11: fallback to driver reset compute queue directly (v2)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  20 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c    |  88 ++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |  37 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |   2 +
>  drivers/gpu/drm/amd/amdgpu/cikd.h          |   1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 251 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 127 +++++++++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.h     |   3 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     | 103 ++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  76 ++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  75 +++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 179 ++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 132 ++++++++++-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c     | 134 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c     |  54 +++++
>  drivers/gpu/drm/amd/amdgpu/nvd.h           |   2 +
>  drivers/gpu/drm/amd/amdgpu/vid.h           |   1 +
>  19 files changed, 1243 insertions(+), 49 deletions(-)
>
> --
> 2.45.2
>
