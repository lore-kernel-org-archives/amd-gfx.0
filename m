Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A10C77B6E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 00:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF8F410E21C;
	Mon, 10 Apr 2023 00:38:50 +0000 (UTC)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0300610E21C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 00:38:48 +0000 (UTC)
Received: by mail-yb1-xb36.google.com with SMTP id i20so6919757ybg.10
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 17:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681087128; x=1683679128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhFTsXwmF5whC2KI03VAym+2gZK46UV+EvOd4XgCHFs=;
 b=HEvcXke+S685I9M2cBx6UarBDE9oROzNHBck3FOZuuMn1O8zjfyCbFqhz/By8TLxaU
 UbT8cFkg2esASrmKvzSxJ9jOQYSDz4E2+BjnEiOzdoo1nyCrHuMzFbc+YFrhT0NS7eUN
 UegaPmljqoRkOIe7yBSOBmpziwuHpFQMLN/fhhRVRoEjk5nFeRhUg97LU1Fx0rmFh3vZ
 793ob0tUlKBDXa8mZXC0rWNSMZtxTUmjurf0M8kXjqZ7kFG7Pp6tfxZykmEqb5pOOiZs
 cy6KH/YZnlLxGHL7JcuyNmVKWPHPU6UEPbNHtCqQ60bNq9i2T/vHR8x1vbpFTCcEHy+C
 UVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681087128; x=1683679128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhFTsXwmF5whC2KI03VAym+2gZK46UV+EvOd4XgCHFs=;
 b=u77rLcX35XmslTZ9SfICa8uKtrHtLYWLeCF2QQokFxKPUEKONpikEMLx1LHMfuxp7W
 nhc3jghVi103MWN4lEYULir7PLAN8IrEy9lcH2u/CNCDCqxmynkaAKfbxECmzecd8CrY
 UhjmBGXXadhqDICiYI+Nm7yzirc0tCvYjArjlGqD5DygJawUY3edZtUTZPV1SG37SC69
 y350xZYxrIfX8EN5HnEEgcOROnGzORu51+Rq8J2vBxw5dU+Qh4acbp+/TMhShBisol5x
 vFyWVocjIZoAr++VCSkFfqeHjeqbHqK9QYn4q/HyB9nbrOGwR2cBQbJ1BuaLW1LBO7w8
 ij5w==
X-Gm-Message-State: AAQBX9eSRiNJfruvPbAg+uns2rjG58lBzetrQfLxIZiBTKgkiJiLHVgM
 nMYp4InoN3n4Ia2igkcMxODb3poWD5lWtJT0uuCIpQ==
X-Google-Smtp-Source: AKy350aoZNB6Xo9XJ43epUeUKINkLGgupp8hr42BDKy+evFARENzT4glCB/Zp9zP9LXj4B0XT3GEDpYcNrxFE/mZjGE=
X-Received: by 2002:a25:dfc3:0:b0:b8a:5fd7:5180 with SMTP id
 w186-20020a25dfc3000000b00b8a5fd75180mr6360197ybg.2.1681087128021; Sun, 09
 Apr 2023 17:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
In-Reply-To: <20230329160445.1300-1-shashank.sharma@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 10 Apr 2023 02:36:35 +0200
Message-ID: <CAP+8YyFgbru=1HkLo1Kfm1jKPrk5sXenUmmkzzysWbSh05q2tg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] AMDGPU Usermode queues
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Shashank,

I tried writing a program to experiment with usermode queues and I
found some weird behavior: The first run of the program works as
expected, while subsequent runs don't seem to do anything (and I
allocate everything in GTT, so it should be zero initialized
consistently). Is this a known issue?

The linked libdrm code for the uapi still does a doorbell ioctl so it
could very well be that I do the doorbell wrong (especially since the
ioctl implementation was never shared AFAICT?), but it seems like the
kernel submissions (i.e. write wptr in dwords to the wptr va and to
the doorbell). Is it possible to update the test in libdrm?

Code: https://gitlab.freedesktop.org/bnieuwenhuizen/usermode-queue

Thanks,
Bas

On Wed, Mar 29, 2023 at 6:05=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> This patch series introduces AMDGPU usermode queues for gfx workloads.
> Usermode queues is a method of GPU workload submission into the graphics
> hardware without any interaction with kernel/DRM schedulers. In this
> method, a userspace graphics application can create its own workqueue
> and submit it directly in the GPU HW.
>
> The general idea of how this is supposed to work:
> - The application creates the following GPU objetcs:
>   - A queue object to hold the workload packets.
>   - A read pointer object.
>   - A write pointer object.
>   - A doorbell page.
> - The application picks a 32-bit offset in the doorbell page for this que=
ue.
> - The application uses the usermode_queue_create IOCTL introduced in
>   this patch, by passing the the GPU addresses of these objects (read
>   ptr, write ptr, queue base address and 32-bit doorbell offset from
>   the doorbell page)
> - The kernel creates the queue and maps it in the HW.
> - The application can start submitting the data in the queue as soon as
>   the kernel IOCTL returns.
> - After filling the workload data in the queue, the app must write the
>   number of dwords added in the queue into the doorbell offset, and the
>   GPU will start fetching the data.
>
> libDRM changes for this series and a sample DRM test program can be found
> in the MESA merge request here:
> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/287
>
> This patch series depends on the doorbell-manager changes, which are bein=
g
> reviewed here:
> https://patchwork.freedesktop.org/series/115802/
>
> Alex Deucher (1):
>   drm/amdgpu: UAPI for user queue management
>
> Arvind Yadav (2):
>   drm/amdgpu: add new parameters in v11_struct
>   drm/amdgpu: map wptr BO into GART
>
> Shashank Sharma (6):
>   drm/amdgpu: add usermode queue base code
>   drm/amdgpu: add new IOCTL for usermode queue
>   drm/amdgpu: create GFX-gen11 MQD for userqueue
>   drm/amdgpu: create context space for usermode queue
>   drm/amdgpu: map usermode queue into MES
>   drm/amdgpu: generate doorbell index for userqueue
>
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  10 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 298 ++++++++++++++++++
>  .../drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c | 230 ++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  66 ++++
>  drivers/gpu/drm/amd/include/v11_structs.h     |  16 +-
>  include/uapi/drm/amdgpu_drm.h                 |  55 ++++
>  9 files changed, 677 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_gfx_v11.c
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>
> --
> 2.40.0
>
