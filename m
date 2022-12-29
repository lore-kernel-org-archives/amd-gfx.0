Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86221C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Dec 2022 18:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3DB10E029;
	Thu, 29 Dec 2022 18:03:14 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2635B10E029
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 18:03:10 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1441d7d40c6so22453736fac.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Dec 2022 10:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+TgF11nJtwD7ikruReryrlXm1ZsvypKS5yQMpgCjtE4=;
 b=Co/4sXOoad5SIE2lMLGLNLo6quXbScITTsowFYbdQCscbnOenWyBlKbjmq+r1QKeAO
 izHRswTPPX3T4Pj+5hJ5blKu1Ksfa4WtA2FUg0mAiUYcCcxxW5muEYgCXX0yq3H+TgBX
 isFRY0sBPPzPPXqBhWBancw3kiWKzp9bqyXEcWIyP3RP8xuX+rc9xPuI+pkyLc9s9Udy
 fTad2SDsJrs0aK7R7iItOAhlARppztodeu/eNA+ua5Xf1uSgk6lYngi5pDZdZFWdd4cb
 UGUtPD4PvwSTWB4Inzxv3SVFeW4P9rklSAilrpVkFnaSCJJJoKmbJusaSxL7jRfRCKgx
 T6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+TgF11nJtwD7ikruReryrlXm1ZsvypKS5yQMpgCjtE4=;
 b=rCFqSWmlptGV8zexbkpPRkA+Sz63tBmB19rEZwBa3zI50PtK/qa7MGiYQkAD1G7dOX
 YUk6g5YsjqaXBYY9Kr6N+XirJ0bgQz6FM0uyRTEtUw/JXaRkrONnViifUu6ziFyxIb0i
 LFBj0Wuumv/vNc5lt3wf0yBnhouEXpdjRnWhZonukSlaX+gzj7c1PfhJtSRz2PnAKRJK
 AdXJD7VUjk7+Iqt9ITuQHNUpnLqTNib9zxRzHHjCut16OSCalG6xnAXJ7rZYgt1sbI9X
 qYYrwpLSKqT2r86r6dHW0RXXTl7du1YaWxQKDwznxVhSUzKgqbj+viGqQ7apG90xC9rd
 H/Vw==
X-Gm-Message-State: AFqh2koWkLQqwsmm9e7YcodzRuSjSDPsBrnZntmj3WonCD7scr1WW7kI
 liv8NR3+PK/kzp7IsHygaLEn41Gas/jIux0IIYTmRdV2
X-Google-Smtp-Source: AMrXdXsAnLKzz+EQBznjanDkxsEV9OGMxhOJwiFtbhGdCnOzMwr7oa0/4IH1XpCN7jPQJPz0ifO8LRw4ryG6WhUD7X0=
X-Received: by 2002:a05:6870:970e:b0:148:3c8f:15ab with SMTP id
 n14-20020a056870970e00b001483c8f15abmr2465671oaq.46.1672336989831; Thu, 29
 Dec 2022 10:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
In-Reply-To: <20221223193655.1972-1-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Dec 2022 13:02:58 -0500
Message-ID: <CADnq5_MuJdXE3CjuibmiW72bPFfAN1YCr20tUpayf9fnn+DXZQ@mail.gmail.com>
Subject: Re: [RFC 0/7] RFC: Usermode queue for AMDGPU driver
To: Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 23, 2022 at 2:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>
> This is a RFC series to implement usermode graphics queues for AMDGPU
> driver (Navi 3X and above). The idea of usermode graphics queue is to
> allow direct workload submission from a userspace graphics process who
> has amdgpu graphics context.
>
> Once we have some initial feedback on the design, we will publish a
> follow up V1 series with a libdrm consumer test.

I think this should look more like the following:
1. Convert doorbells to full fledged GEM objects just like vram.  Then
update the GEM IOCTL to allow allocation of doorbell BOs.
2. Store MQD data per amdgpu_ctx.
3. Create secure semaphore pool and map RO into each GPUVM.
4. Add callbacks to each IP type that supports user mode queues.
These callbacks should handle the IP specific MQD initialization and
mapping/unmapping details including allocation of BOs for the MQD
itself and any relevant metadata.  The USERQ IOCTL handler will look
up the callback based on the IP type specified in the IOCTL.

Alex

>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
>
> Alex Deucher (1):
>   drm/amdgpu: UAPI for user queue management
>
> Arunpravin Paneer Selvam (1):
>   drm/amdgpu: Secure semaphore for usermode queue
>
> Arvind Yadav (1):
>   drm/amdgpu: Create MQD for userspace queue
>
> Shashank Sharma (4):
>   drm/amdgpu: Add usermode queue for gfx work
>   drm/amdgpu: Allocate doorbell slot for user queue
>   drm/amdgpu: Create context for usermode queue
>   drm/amdgpu: Map userqueue into HW
>
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  14 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 486 ++++++++++++++++
>  .../amd/amdgpu/amdgpu_userqueue_secure_sem.c  | 245 ++++++++
>  .../drm/amd/include/amdgpu_usermode_queue.h   |  68 +++
>  .../amd/include/amdgpu_usermode_queue_mqd.h   | 544 ++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h                 |  52 ++
>  8 files changed, 1413 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_secure_sem.c
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue_mqd.h
>
> --
> 2.34.1
>
