Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A331C28B28
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 02:28:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F0F810E27C;
	Fri, 14 Mar 2025 02:28:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PFla7A5o";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFFF510E27C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 02:28:19 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-301001bc6a8so395629a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 19:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741919299; x=1742524099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBYtL3IMISraXx5YTrl/XMvUL53p+XKyQu56LD4iGAs=;
 b=PFla7A5ojZiqpfHMS6zmVstP6VeUuBJQsrhZORsudDwGhOZ6mnRdqiqkCmWDcgDp6G
 eA59ajhKoYN7J5DSzg/J1SbJS2g7DJip1OfBORkskNxH42nNT79+CtLKWtypOjGwLwSf
 DhAk0LstU6ZYM5ySA4WwI8n+aaqfLCFwqoU7+5rPSa/CSxqK62EjfbGHRKHu9WiSIEj6
 p0xN2qdxR9ymV1NqsEJJJi23OHqNRrS74XW1A3gJEsbA3YxoDXkHkEg/VrmJTFesyxxJ
 P72y4CZnhJc+edxoN7jP/NpB7iau4wLXLsaVy9sq5HlUqxEIH4BiC48lXsNIN22xh6dv
 fY4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741919299; x=1742524099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBYtL3IMISraXx5YTrl/XMvUL53p+XKyQu56LD4iGAs=;
 b=gY6CIYxsREom+LO+s/Jtcu03wOSLQvjIAmk+aK63f/VRY2vzB8429ZJBwZaDB/u79+
 +xFq/OeLq3oSs18crQ3WJtW4l3qcrvBFshRd504zYnBBeS4FEe6m0FGMGa/Y77RsVgjp
 6d9PqhyM5WxTuuVVbeG2UcV5C+BF4BgIoti6SQU2LYRwgZgkOq/I6VMZqPf4zBreyg14
 y0Wnhovezh2GBB2wdXqaXLeRY9XzyGt4cJVndLuJ7VA+IPovkGyOpRRhrVQWjJiXtWQg
 S/ZG9h3XB+eIGbhdMgGf6jFAEvbWPsk8KDHcOPYHCIR8ZhSurJ2h6hZZsRJfYHYS0aZ/
 4kcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzMve9QDtJJBAmW357AgMSKaxymf2q850HDLSlup43LNnFrLj0TiDE+RQkX7+mRAlo8idAv6kN@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFnGUh5aVZ8EzaOuTOcXZPnen2kcapkQ2wM5b1Ft5VI1FpwKmT
 CF7znpip8I5r1V6y1C/32yz8S5fVoxZYElWZhWPY0nQf/nC/qzvM2uvvD1FNu6798qLNYNZfTN7
 1EmpMkdsdJDDrJ7E2DqKzr8sdhHs=
X-Gm-Gg: ASbGnct2REQUnxuNXbPKRN+ijyRsX/PRLMd0yQ6Ro8wM0KqG6sIAdRanUehvTlqDGJ6
 /hF8XhYG2yoisnGz5RwjpkccDzA0cLW2f35E8+/kwmjpH+/XoNvIIq59zzrbk46gN/ARGbmU8g6
 TVOuX4OOLLUml8i6VRcEKszffepg==
X-Google-Smtp-Source: AGHT+IG1jNGgSybDzgF8kiWc6J9UJWml9Uer4wwAtc6AfuXOsKtpnNe3yGAeOmT0khk7vW9o6spz0ZFhAt7l2/BRdZA=
X-Received: by 2002:a17:90b:164f:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-30151d56e87mr401910a91.3.1741919299043; Thu, 13 Mar 2025
 19:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <6itqgifq2c2q3mo5uikvciog4n4ubviolciya5hgturekeykhd@rxzxgul5aqz7>
In-Reply-To: <6itqgifq2c2q3mo5uikvciog4n4ubviolciya5hgturekeykhd@rxzxgul5aqz7>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Mar 2025 22:28:07 -0400
X-Gm-Features: AQ5f1Jqc47Tcg4TvUPSOyUgvyyLSvCwY0WZ-c0aXKlBU5WZ53xCUah04Y0a0xvY
Message-ID: <CADnq5_NTPr17pTyWAh9a_VQwBkEE7+wr8NMk0HWqFQb4mz1L1g@mail.gmail.com>
Subject: Re: [PATCH V5 00/11] Add disable kernel queue support
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Mar 13, 2025 at 6:21=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> n 03/13, Alex Deucher wrote:
> > To better evaluate user queues, add a module parameter
> > to disable kernel queues.  With this set kernel queues
> > are disabled and only user queues are available.  This
> > frees up hardware resources for use in user queues which
> > would otherwise be used by kernel queues and provides
> > a way to validate user queues without the presence
> > of kernel queues.
>
> Hi Alex,
>
> I'm trying to understand how GFX and MES deal with different queues, and
> I used this patchset to guide me through that. In this sense, could you
> help me with the following points?
>
> FWIU, the GFX has what are called pipes, which in turn have hardware
> queues associated with them. For example, a GFX can have 2 pipes, and
> each pipe could have 2 hardware queues; or it could have 1 pipe and 8
> queue. Is this correct?

Right.  For gfx, compute, and SDMA you have pipes (called instances on
SDMA) and queues.  A pipe can only execute one queue at a time.  The
pipe will switch between all of the mapped queues.  You have storage
in memory (called an MDQ -- Memory Queue Descriptor) which defines the
state of the queue (GPU virtual addresses of the queue itself, save
areas, doorbell, etc.).  The queues that the pipe switches between are
defined by HQDs (Hardware Queue Descriptors).  These are basically
register based memory for the queues that the pipe can switch between.
The driver sets up an MQD for each queue that it creates.  The MQDs
are then handed to the MES firmware for mapping.  The MES firmware can
map a queue as a legacy queue (i.e. a kernel queue) or a user queue.
The difference is that a legacy queue is statically mapped to a HQD
and is never preempted.  User queues are dynamically mapped to the
HQDs by the MES firmware.  If there are more MQDs than HQDs, the MES
firmware will preempt other user queues to make sure each queue gets a
time slice.

>
> (for this next part, suppose 1 pipe 2 hardware queues)
> By default, one of the hardware queues is reserved for the Kernel Queue,
> and the user space could use the other. GFX has the MES block "connected"
> to all pipe queues, and MES is responsible for scheduling different ring
> buffers (in memory) in the pipe's hardware queue (effectively making the
> ring active). However, since the kernel queue is always present, MES
> only performs scheduling in one of the hardware queues. This scheduling
> occurs with the MES mapping and unmapping available Rings in memory to
> the hardware queue.
>
> Does the above description sound correct to you?  How about the below
> diagram? Does it look correct to you?

More or less.  The MES handles all of the queues (kernel or user).
The only real difference is that kernel queues are statically mapped
to an HQD while user queues are dynamically scheduled in the available
HQDs based on level of over-subscription.  E.g., if you have hardware
with 1 pipe and 2 HQDs you could have a kernel queue on 1 HQD and the
MES would schedule all of the user queues on the remaining 1 HQD.  If
you don't enable any kernel queues, then you have 2 HQDs that the MES
can use for scheduling user queues.

>
> (I hope the diagram looks fine in your email client; if not, I can
> attach a picture of it.)
>
> +------------------------------------------------------------------------=
-------------------------------------------------------------------+
> |                                                           GFX          =
                                                                   |
> |                                                                        =
                                                                   |
> |                                                                        =
       +-----------------------------+                             |
> |           +---------------------------------------------+ (Hw Queue 0) =
       | Kernel Queue (No eviction)  +------- No MES Scheduling    |
> |           |        (Hardware Queue 0)                   | -------------=
------>|                             |               |             |
> |PIPE 0     |   -------------------------------------     |              =
       +-----------------------------+               X             |
> |           |        (Hardware Queue 1)                   |              =
                                          +----------+---------+   |
> |           |   -------------------------------------     |--+           =
                                          |                    |   |
> |           |                                             |  |           =
       +----------------------------+     |                    |   |
> |           +---------------------------------------------+  | (Hw Queue =
1)     |                            |     |   MES Schedules    |   |
> |                                                            +-----------=
-----> |  User Queue                +-----+                    |   |
> |                                                                        =
       |                            |     |                    |   |
> |                                                                        =
       +----------------------------+     |                    |   |
> |                                                                        =
                                          +--------------------+   |
> |                                                                        =
                                                    |              |
> |                                                                        =
              +-------------------------------------+              |
> |                                                                        =
              |Un/Map Ring                                         |
> |                                                                        =
              |                                                    |
> +------------------------------------------------------------------------=
-------------------------------------------------------------------+
>                                                                          =
              |
>                                                                  +-------=
--------------+--------------------------------------------+
>                                                                  |   MEMO=
RY            v                                            |
>                                                                  |       =
                                                           |
>                                                                  |       =
                                                           |
>                                                                  |  +----=
------+                                                    |
>                                                                  |  |    =
      |  +---------+         +--------+                    |
>                                                                  |  |    =
Ring 0|  | Ring 1  |  ...    | Ring N |                    |
>                                                                  |  |    =
      |  |         |         |        |                    |
>                                                                  |  +----=
------+  +---------+         +--------+                    |
>                                                                  |       =
                                                           |
>                                                                  |       =
                                                           |
>                                                                  +-------=
-----------------------------------------------------------+
>
> Is the idea in this series to experiment with making the kernel queue
> not fully occupy one of the hardware queue? By making the kernel queue
> able to be scheduled, this would provide one extra queue to be used for
> other things. Is this correct?

Right.  This series paves the way for getting rid of kernel queues all
together.  Having no kernel queues leaves all of the resources
available to user queues.

>
> I'm unsure if I fully understand this series's idea; please correct me
> if I'm wrong.
>
> Also, please elaborate more on the type of tasks that the kernel queue
> handles. Tbh, I did not fully understand the idea behind it.

In the future of user queues, kernel queues would not be created or
used at all.  Today, on most existing hardware, kernel queues are all
that is available.  Today, when an application submits work to the
kernel driver, the kernel driver submits all of the application
command buffers to kernel queues.  E.g., in most cases there is a
single kernel GFX queue and all applications which want to use the GFX
engine funnel into that queue.  The CS IOCTL basically takes the
command buffers from the applications and schedules them on the kernel
queue.  With user queues, each application will create its own user
queues and will submit work directly to its user queues.  No need for
an IOCTL for each submission, no need to share a single kernel queue,
etc.

Alex

>
> Thanks
>
> >
> > v2: use num_gfx_rings and num_compute_rings per
> >     Felix suggestion
> > v3: include num_gfx_rings fix in amdgpu_gfx.c
> > v4: additional fixes
> > v5: MEC EOP interrupt handling fix (Sunil)
> >
> > Alex Deucher (11):
> >   drm/amdgpu: add parameter to disable kernel queues
> >   drm/amdgpu: add ring flag for no user submissions
> >   drm/amdgpu/gfx: add generic handling for disable_kq
> >   drm/amdgpu/mes: centralize gfx_hqd mask management
> >   drm/amdgpu/mes: update hqd masks when disable_kq is set
> >   drm/amdgpu/mes: make more vmids available when disable_kq=3D1
> >   drm/amdgpu/gfx11: add support for disable_kq
> >   drm/amdgpu/gfx12: add support for disable_kq
> >   drm/amdgpu/sdma: add flag for tracking disable_kq
> >   drm/amdgpu/sdma6: add support for disable_kq
> >   drm/amdgpu/sdma7: add support for disable_kq
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |   4 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   9 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |   8 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  30 ++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  26 ++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   1 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 191 ++++++++++++++++-------
> >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 183 +++++++++++++++-------
> >  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |   2 +-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   |   2 +-
> >  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  16 +-
> >  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |  15 +-
> >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |   4 +
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |   4 +
> >  17 files changed, 345 insertions(+), 155 deletions(-)
> >
> > --
> > 2.48.1
> >
>
> --
> Rodrigo Siqueira
