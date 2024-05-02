Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8245DC4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 15:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 162E411252F;
	Thu,  2 May 2024 15:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PJQ8fEr5";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8FED11252F
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 15:52:10 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-6f26588dd5eso6888742b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714665130; x=1715269930; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jh/76aKL7teYK5llzyesRpicpVH9v9xFYh+ALGss/4U=;
 b=PJQ8fEr5MTr0nNazBZTNa/QNK9FNwZCWWVutCCJV4ahqc9MIxP4THCIkBb/GsKvHWW
 2iK3ImUIu1BpQbiHp8uUgVQ5R4l/Vs75ZH/SwYuXqoPw7xKwFyqQ+JRoONh+8PXckD3K
 wS4U7V03Rp/iaqs8EtLpMIKy6evM4pd3xaFyXFssRGK7JBynDxB+1Ym64TKeZOMSOjK9
 DY5QI0JjtFSzN3I7mVSs5ywpLf+Vk/cmQyeQUihCh+UKWQg224kQsa7WupRLFsYafoHt
 2agT1M92CM6XhGK/SA7mnKwcDqn1a24FAsvSpoUVUBCPeA2yZiWOQQY9b+unxWtFh5zB
 Nl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665130; x=1715269930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jh/76aKL7teYK5llzyesRpicpVH9v9xFYh+ALGss/4U=;
 b=Tc8JltLLdnk2o7WHPtc4ryrsulXeLeXBk7SB5zh+x71hKDonTq7Q+07U4thJFAl6Fz
 jxNEqTJPQAAqotL7bHUV/Oa4FRa0DtZbs1DULxJ8F/v9zmYwPYT8Taqv7V1U6HV+ChSW
 5ZsTXmS7C1BJntTPDLuf9pUGnvcMZzjHde2ftKMRSZD9ESR2ZDhcs2ZTNMzAGxjvADCg
 CXPXYv3BBWWT3L8U01f912qyBjt+HI+PIdhoCktNJtxr7Gxlbo/T/UcpFK5i78Tx0FBv
 QWOTvKKovdDSbcP9nnPdDHVK4VLXrRWO+Dg8zrgw1IdlYTjgVzq2SEPEtn3ZXYul2v+y
 5vTw==
X-Gm-Message-State: AOJu0YyRuM105GZfh4AeipSi4e6WQQMALfq9l6its8HOgJg4s4sPKJ7k
 +NUFa5F3f7MFQPFu/7u79RmXXODvzCjGHfvGOqxzuW0K71VEuAJc3rLFi/RKKJPRayAtpmi02SC
 rbfsw5POrCXqj7KyhBDh4911oVTlnyg==
X-Google-Smtp-Source: AGHT+IEuEsZMH00J1ZZuTQgSmum83Y9roaiixJ+ANjsHEmPtcKewZBUbMi9kYg2/dQt1aVdJJBdJ1rmqx7Esha2ugGU=
X-Received: by 2002:a05:6a20:5a96:b0:1ad:1612:7656 with SMTP id
 kh22-20020a056a205a9600b001ad16127656mr23046pzb.59.1714665130164; Thu, 02 May
 2024 08:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240426134810.1250-1-shashank.sharma@amd.com>
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 May 2024 11:51:58 -0400
Message-ID: <CADnq5_N61q_o+5WYUZsZ=qu7VmeXTFHQSxLwTco05gLzHaiswA@mail.gmail.com>
Subject: Re: [PATCH v9 00/14] AMDGPU usermode queues
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>
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

On Fri, Apr 26, 2024 at 10:17=E2=80=AFAM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> This patch series introduces AMDGPU usermode queues for gfx workloads.
> Usermode queues is a method of GPU workload submission into the graphics
> hardware without any interaction with kernel/DRM schedulers. In this
> method, a userspace graphics application can create its own workqueue and
> submit it directly in the GPU HW.
>
> The general idea of how this is supposed to work:
> - The application creates the following GPU objetcs:
>   - A queue object to hold the workload packets.
>   - A read pointer object.
>   - A write pointer object.
>   - A doorbell page.
>   - Shadow bufffer pages.
>   - GDS buffer pages (as required).
> - The application picks a 32-bit offset in the doorbell page for this
>   queue.
> - The application uses the usermode_queue_create IOCTL introduced in
>   this patch, by passing the GPU addresses of these objects (read ptr,
>   write ptr, queue base address, shadow, gds) with doorbell object and
>   32-bit doorbell offset in the doorbell page.
> - The kernel creates the queue and maps it in the HW.
> - The application maps the GPU buffers in process address space.
> - The application can start submitting the data in the queue as soon as
>   the kernel IOCTL returns.
> - After filling the workload data in the queue, the app must write the
>   number of dwords added in the queue into the doorbell offset and the
>   WPTR buffer, and the GPU will start fetching the data.
> - This series adds usermode queue support for all three MES based IPs
>   (GFX, SDMA and Compute).

I think we also need a new INFO IOCTL query to get the doorbell
offsets for each engine type within each doorbell page.

Alex

>
> libDRM changes for this series and a sample DRM test program can be found
> in the MESA merge request here:
> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
>
> Alex Deucher (1):
>   drm/amdgpu: UAPI for user queue management
>
> Arvind Yadav (1):
>   drm/amdgpu: enable compute/gfx usermode queue
>
> Shashank Sharma (12):
>   drm/amdgpu: add usermode queue base code
>   drm/amdgpu: add new IOCTL for usermode queue
>   drm/amdgpu: add helpers to create userqueue object
>   drm/amdgpu: create MES-V11 usermode queue for GFX
>   drm/amdgpu: create context space for usermode queue
>   drm/amdgpu: map usermode queue into MES
>   drm/amdgpu: map wptr BO into GART
>   drm/amdgpu: generate doorbell index for userqueue
>   drm/amdgpu: cleanup leftover queues
>   drm/amdgpu: fix MES GFX mask
>   drm/amdgpu: enable SDMA usermode queues
>   drm/amdgpu: add kernel config for gfx-userqueue
>
>  drivers/gpu/drm/amd/amdgpu/Kconfig            |   8 +
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   7 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   3 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 296 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  10 +
>  drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        |   9 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |   9 +-
>  .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 317 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   6 +
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  79 +++++
>  include/uapi/drm/amdgpu_drm.h                 | 111 ++++++
>  15 files changed, 859 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>
> --
> 2.43.2
>
