Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C0DCF395D
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 16:59:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 197BA10E096;
	Thu, 19 Sep 2024 16:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HTaUHKif";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3E8E10E096
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 16:59:55 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2d871bd95ffso181577a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726765195; x=1727369995; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rmt1OY81W09kX9Tc0DN4+79ATVDwgLije1EzCv1QHfY=;
 b=HTaUHKifJl3c1WVCxuqYeHEhSGj0zqxx4JXMuc8GVRhm5CzTQKYMA9CxxxkFkCXEhU
 M9JccSmGeD3y8nKBfCB4SQiJZQjVYEtoMy3hH2wgJM/aGe2Atu3KNguRfbazGJ56Eil8
 49Ll2pBCj9BB5+yfmM1z/KQpeBQ4sl2UJKp5Cm0PRaxIneepvKegfsNg/whRB6tH11ry
 hdLy7zVu+oS7zA1iKRR8SdM5FESvSlQs6McXs5zAQlr3nY/ySwKTUGOc01U9wU/6k7Jq
 S/lfEIEKMLXnAybZnbeYxNcXmRo5/hjwN2Q42G9HAuatpZCqSI8sFGQbrQ3CNtJAw3X2
 qMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726765195; x=1727369995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmt1OY81W09kX9Tc0DN4+79ATVDwgLije1EzCv1QHfY=;
 b=egTPDCO44uQxMA5DlmZ0PL2NdSwBLApXWMHKOut0FKd5S4Dlgw0hf8I4y9m+0bVf6l
 v/R+Ak4sBUuEO8vN6td/PIktDe/apc/0UY33tbwpVrmeLdV7VsSsgs+HmxAT5GcAZY1n
 YkvArmmd3/eruTqeUtfTr+MZBFW21omNS0jnPqrp4gh10LOP1/oh0cB/Mh3ABkAGZM/a
 b4A/+gdosTGP2snHuuIGh+O0b76AWp+e67+UlcZ4LEMTF5BDJrPxc3W8A619YA5PGMa2
 986nlg0hEhiCVfrwAgqn8nPN+y0fq95lCqLlkQOozUr1WayEVfD6C3iBqCI7JdZ4AuK7
 FPjA==
X-Gm-Message-State: AOJu0YzPMoPd5MjZHNxJsnXJgVHtdPykMlz6dD8q3q1vesrFCgF5P7hA
 b+jy3aWXW0QXoOMzFXvu8Bn6wCv4VQvAV6L9jWR3wcVy3063RivY8WFDdBLT5R9PAmfmVAnCmup
 kNadHZRp0L0zr7BLfLHFJWUqNBHz/Vg==
X-Google-Smtp-Source: AGHT+IGEcW8FtAO2T6Fvj8qGxe4lBlMr6ZAt7bG8VqpnMePAuuaFgtKy9R4gkHXcgaPzcdc1n70SY5m9AlfBGEJ6Bd8=
X-Received: by 2002:a17:90a:6443:b0:2db:60b:9be4 with SMTP id
 98e67ed59e1d1-2dd7f72c223mr22928a91.7.1726765195181; Thu, 19 Sep 2024
 09:59:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240909200614.481-1-shashank.sharma@amd.com>
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Sep 2024 12:59:42 -0400
Message-ID: <CADnq5_OzaOWZ4tvN=13oXHc091kFUdtkhz9=R8-eknD1PMhYkw@mail.gmail.com>
Subject: Re: [PATCH v11 00/28] AMDGPU usermode queues
To: Shashank Sharma <shashank.sharma@amd.com>
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

On Mon, Sep 9, 2024 at 4:07=E2=80=AFPM Shashank Sharma <shashank.sharma@amd=
.com> wrote:
>
> This patch series introduces base code of AMDGPU usermode queues for gfx
> workloads. Usermode queues is a method of GPU workload submission into th=
e
> graphics hardware without any interaction with kernel/DRM schedulers. In
> this method, a userspace graphics application can create its own workqueu=
e
> and submit it directly in the GPU HW.
>
> The general idea of how Userqueues are supposed to work:
> - The application creates the following GPU objetcs:
>   - A queue object to hold the workload packets.
>   - A read pointer object.
>   - A write pointer object.
>   - A doorbell page.
>   - Other supporting buffer objects as per target IP engine (shadow, GDS
>     etc, information available with AMDGPU_INFO_IOCTL)

the queue, rptr, wptr, and metadata buffers don't have to be separate
buffers.  Userspace could suballocate them out of the same buffer.  We
just need the virtual addresses.  However, we need to keep track of
the GPU virtual addresses used by the user queue for these buffers and
prevent them from being unmapped until the queue is destroyed, similar
to what we do on the KFD side.  Otherwise, the user could unmap one of
the buffers and submit work to the user queue which could cause it to
hang.

Alex

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
>   WPTR buffer. The GPU will start fetching the data as soon as its done.
> - This series adds usermode queue support for all three MES based IPs
>   (GFX, SDMA and Compute).
> - This series also adds eviction fences to handle migration of the
>   userqueue mapped buffers by TTM.
> - For synchronization of userqueues, we have added a secure semaphores
>   IOCTL which is getting reviewed separately here:
>   https://patchwork.freedesktop.org/patch/611971/
>
> libDRM UAPI changes for this series can be found here:
> (This also contains an example test utility which demonstrates
> the usage of userqueue UAPI)
> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
>
> MESA changes consuming this series can be seen in the MR here:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/29010
>
> Alex Deucher (1):
>   drm/amdgpu: UAPI for user queue management
>
> Arvind Yadav (4):
>   drm/amdgpu: enable SDMA usermode queues
>   drm/amdgpu: Add input fence to sync bo unmap
>   drm/amdgpu: fix MES GFX mask
>   Revert "drm/amdgpu: don't allow userspace to create a doorbell BO"
>
> Shashank Sharma (18):
>   drm/amdgpu: add usermode queue base code
>   drm/amdgpu: add new IOCTL for usermode queue
>   drm/amdgpu: add helpers to create userqueue object
>   drm/amdgpu: create MES-V11 usermode queue for GFX
>   drm/amdgpu: create context space for usermode queue
>   drm/amdgpu: map usermode queue into MES
>   drm/amdgpu: map wptr BO into GART
>   drm/amdgpu: generate doorbell index for userqueue
>   drm/amdgpu: cleanup leftover queues
>   drm/amdgpu: enable GFX-V11 userqueue support
>   drm/amdgpu: enable compute/gfx usermode queue
>   drm/amdgpu: update userqueue BOs and PDs
>   drm/amdgpu: add kernel config for gfx-userqueue
>   drm/amdgpu: add gfx eviction fence helpers
>   drm/amdgpu: add userqueue suspend/resume functions
>   drm/amdgpu: suspend gfx userqueues
>   drm/amdgpu: resume gfx userqueues
>   Revert "drm/amdgpu/gfx11: only enable CP GFX shadowing on SR-IOV"
>
>  drivers/gpu/drm/amd/amdgpu/Kconfig            |   8 +
>  drivers/gpu/drm/amd/amdgpu/Makefile           |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  11 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   5 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  10 +
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 297 ++++++++
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.h    |  67 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  68 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  11 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c       |   3 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |   2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 713 ++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  74 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 644 ++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  42 +-
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  16 +-
>  .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c  | 395 ++++++++++
>  .../gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h  |  30 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   5 +
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    | 100 +++
>  drivers/gpu/drm/amd/include/v11_structs.h     |   4 +-
>  include/uapi/drm/amdgpu_drm.h                 | 252 +++++++
>  22 files changed, 2722 insertions(+), 45 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v11_0_userqueue.h
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>
> --
> 2.45.1
>
