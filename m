Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6318EC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 20:06:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E491910E4C8;
	Tue, 18 Mar 2025 20:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RoXcBzy6";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF0210E4C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 20:06:14 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2240ff0bd6eso14566835ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742328374; x=1742933174; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUrhPP0ccomj8F+84FJYK5BzeihJGFQ4IHbFhRrHbes=;
 b=RoXcBzy6OQ1tMle/bFfFFNlVPDN5ob28FXQauYCNwcx1EJirl8EhyrNt1Ms0qQmaEt
 mOV5QIPX39CaC9ecYrayHM4pf16Xs5NS7r6OVSSUelKtw+YS+tNvwoqps1L4SA75Rw6N
 iwn3ky5djvgEgR34uQG69cN5qJGrMjK9l123E2KbOY3YgwfvqP59ha6Ek2IXcFbfbr66
 ng+oIK97+6kqCwq3SevPkfpVs5YbB8HEsfZUn/Xm+ovDo+UHtSBlUk9zDUHFL3U7ndi0
 Oh5PHyhlu36KvEjv8bn1e7zNkQvCGYsry0cHPkCzXkFs6nqziOHMsiGt7LG3MdGYE/f4
 Icqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742328374; x=1742933174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xUrhPP0ccomj8F+84FJYK5BzeihJGFQ4IHbFhRrHbes=;
 b=OJpxMEB85j6zZJN85BQImMtOAvYcTJ8592CkBAVOGQTSdWbA3kLccAbZE4YiedlSrJ
 0bX7BqeWXy5V4t8LMUxx3awKIfWW3ELaUHtNSBho7qf9LSL9x9sldaoR0U7F+Ja8AzSl
 UAnkM6tIj3iiQaMUKXkH00GOUJO0cV/g5PR39y+V+uioxA7fM34Ny3CgBoXY/SDycdV3
 4YsLqFxNQKc4QODgIPOYujoomuYnnvX7MCpDgO8YTyXFn7oldA7sBIG6JEZxnVfGjPMk
 ulTib9deFgziNvEDQZE9F3b7vgc5Sr2VwqgfMXXUO7bLZV/oa3fWXLtjxAQmBsc1hUmn
 95rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8/KNdghieWtND3PosoxHzXjL3kr25QiveMWv0e4Iu9LZkdGblPbx0+bdCLTfb3Z6Zxy+gQ0ot@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwLbTTeBP8elE/A6jFG8TbVpp0HyzOKkEnqawtsAnsCGFiwFJf
 0U2u+RNICgekh6K3Gjy7mR0+5XBG7Ujr9A6zlE3Z7EjMQzR/dbkBiP0zUWxpUUt8LvYQuDw5B4c
 mybcZ5ItdQtXNkVnkIQeW9HIJbmA=
X-Gm-Gg: ASbGncv6f3TC/in3Zm7Dr4VtAawLAj13UIYmXn0YYrgjWhbZJvOXjLtaP+LC2aDdSVu
 PYbUAICtbiWVYTgVgaTMu/0AXTJ/p/Xd0OzqG/ki5Natlm45f+tRXE+lUEiR9v2th24eq639ViO
 MabDrXHmgtqYoNiJB/A9U2iGa1Ug==
X-Google-Smtp-Source: AGHT+IH30jkK1CY3y2MCHKtBPH5ZiCWioJjFmME3yx4AJFmzNNnwtIcf4TrzZuDEM6aFYuwb119R0lsAaYz6YBG2pOc=
X-Received: by 2002:a17:902:f70b:b0:224:1785:8044 with SMTP id
 d9443c01a7336-225e0a34d69mr89806325ad.4.1742328373558; Tue, 18 Mar 2025
 13:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <6itqgifq2c2q3mo5uikvciog4n4ubviolciya5hgturekeykhd@rxzxgul5aqz7>
 <CADnq5_NTPr17pTyWAh9a_VQwBkEE7+wr8NMk0HWqFQb4mz1L1g@mail.gmail.com>
 <zuhuoeekbsx62g32lxq7qzq7eeqgh56xt64rpnh6zs75wonoie@hkruwukqfuem>
In-Reply-To: <zuhuoeekbsx62g32lxq7qzq7eeqgh56xt64rpnh6zs75wonoie@hkruwukqfuem>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Mar 2025 16:06:01 -0400
X-Gm-Features: AQ5f1JrFFbmdWt3Woo3pi2pw2cmSgk16WjrzRy8Px3dYKwVP9bPtvl3gfPSF6sk
Message-ID: <CADnq5_Pcz2x4aJzKbVrN3jsZhD6sTydtDw=6PaN4O3m4t+Grtg@mail.gmail.com>
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

On Tue, Mar 18, 2025 at 1:46=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 03/13, Alex Deucher wrote:
> > On Thu, Mar 13, 2025 at 6:21=E2=80=AFPM Rodrigo Siqueira <siqueira@igal=
ia.com> wrote:
> > >
> > > n 03/13, Alex Deucher wrote:
> > > > To better evaluate user queues, add a module parameter
> > > > to disable kernel queues.  With this set kernel queues
> > > > are disabled and only user queues are available.  This
> > > > frees up hardware resources for use in user queues which
> > > > would otherwise be used by kernel queues and provides
> > > > a way to validate user queues without the presence
> > > > of kernel queues.
> > >
> > > Hi Alex,
> > >
> > > I'm trying to understand how GFX and MES deal with different queues, =
and
> > > I used this patchset to guide me through that. In this sense, could y=
ou
> > > help me with the following points?
> > >
> > > FWIU, the GFX has what are called pipes, which in turn have hardware
> > > queues associated with them. For example, a GFX can have 2 pipes, and
> > > each pipe could have 2 hardware queues; or it could have 1 pipe and 8
> > > queue. Is this correct?
> >
>
> Hi Alex, first of all, thanks a lot for your detailed explanation.
>
> I still have some other questions, see it inline.
>
> > Right.  For gfx, compute, and SDMA you have pipes (called instances on
> > SDMA) and queues.  A pipe can only execute one queue at a time.  The
>
> What is the difference between GFX and Compute? Tbh, I thought they were
> the same component.

They both share access to the shader cores, but they have different
front ends.  GFX has a bunch of fixed function blocks used by draws
while compute dispatches directly to the shaders.  There are separate
pipes for each.  You can send dispatch packets to GFX, but you can't
send draw packets to compute.

>
> I was also thinking about the concept of a pipe, and I'm trying to
> define what a pipe is in this context (the word pipe is one of those
> words with many meanings in computers). Is the below definition accurate
> enough?
>
>  Pipe, in the context of GFX, Compute, and SDMA, is a mechanism for
>  running threads.

Yes. It's the hardware that actually processes the packets in a queue.
You have multiple HQDs associated with a pipe, only one will be
processed by a pipe at a time.

>
> > pipe will switch between all of the mapped queues.  You have storage
>
> Above, you said that each pipe will switch between queues, and a little
> bit below, in your explanation about MES, you said:
>
>  [..] If there are more MQDs than HQDs, the MES firmware will preempt
>  other user queues to make sure each queue gets a time slice.
>
> Does it mean that the GFX Pipe has the mechanic of switching queues
> while MES has the scheduling logic?

The pipes have hardware logic to switch between the HQD slots.  MES is
a separate microcontroller which handles the mapping and unmapping of
MQDs into HQDs.  It handles priorities and oversubscription (more MQDs
than HQDs).

>
> Does the below example and explanation make sense?
>
> Suppose the following scenario:
>  - One pipe (pipe0) and two queues (queue[0], and queue[1]).
>  - 3 MQDs (mqd[0], mqd[1], and mqd[2]).
>  - pipe0 is running an user queue in queue[1].
>  - pipe0 is running a kernel queue in queue[0].

Yes.  A pipe can only execute one queue at a time, it will dynamically
switch between the active HQDs.

>
> Fwiu, a pipe can change the current queue in execution, but it does not
> do it by itself. In other words, it has no scheduling logic; it only has
> the mechanics of switching queues inside it. When the pipe switches
> between queues, it uses Mid Command Buffer Preemption (MCBP), which
> saves some very basic information but has no register state; in other
> words, those registers must be stored in memory (MES handles it?).

More or less.  A pipe will switch between queues on a command stream
or on a packet by packet basis, depending on the engine.  You can
preempt a queue if you want.  In general the driver will ask MES to do
this if it needs to preempt a queue.  The MES will also do this
internally for scheduling reasons.  MES firmware handles the saving of
state to the MQD.

>
> In turn, MES has access to all MQDs handed over to it, which means that
> MES has all the queue states available for the scheduling and
> communication with the GFX pipe. Suppose that the GFX pipe is running
> mqd[2] in the queue[1], and now MES wants to replace it with mqd[0]. The
> communication will be something like the following:
>
> 1. MES to GFX pipe0: Replace(mqd[2], in pipe0, queue[1]) with mqd[0].
> 2. GFX pipe0: Just stop the current pipe, and start mqd[0].
>
> Does it looks correct to you?

MES would talk to the hardware to unmap queue[1] and save its state to
mqd[2].  It would then talk to the hardware to map the state from
mqd[0] into queue[1].

>
> > in memory (called an MDQ -- Memory Queue Descriptor) which defines the
> > state of the queue (GPU virtual addresses of the queue itself, save
> > areas, doorbell, etc.).  The queues that the pipe switches between are
> > defined by HQDs (Hardware Queue Descriptors).  These are basically
> > register based memory for the queues that the pipe can switch between.
>
> I was thinking about this register-based memory part. Does it mean that
> switching between it is just a matter of updating one of those LOW and
> HIGH registers?

Not exactly, but close.  The HQD registers are saved in/out of the MQD
and the MQD also has pointers to other buffers which store other
things like pipeline state, etc.  Firmware basically tells the hw to
preempt or umap the queues, waits for that to complete (waits for
HQD_ACTIVE bit for the queue to go low), then saves the state to the
MQD.  For resuming or mapping a queue, the opposite happens, firmware
copies the state out of the MQD into the HQD registers and loads any
additional state.  Setting the HQD_ACTIVE bit for the queue is what
ultimately enables it.

>
> > The driver sets up an MQD for each queue that it creates.  The MQDs
> > are then handed to the MES firmware for mapping.  The MES firmware can
> > map a queue as a legacy queue (i.e. a kernel queue) or a user queue.
> > The difference is that a legacy queue is statically mapped to a HQD
> > and is never preempted.  User queues are dynamically mapped to the
> > HQDs by the MES firmware.  If there are more MQDs than HQDs, the MES
> > firmware will preempt other user queues to make sure each queue gets a
> > time slice.
> >
> > >
> > > (for this next part, suppose 1 pipe 2 hardware queues)
> > > By default, one of the hardware queues is reserved for the Kernel Que=
ue,
> > > and the user space could use the other. GFX has the MES block "connec=
ted"
> > > to all pipe queues, and MES is responsible for scheduling different r=
ing
> > > buffers (in memory) in the pipe's hardware queue (effectively making =
the
> > > ring active). However, since the kernel queue is always present, MES
> > > only performs scheduling in one of the hardware queues. This scheduli=
ng
> > > occurs with the MES mapping and unmapping available Rings in memory t=
o
> > > the hardware queue.
> > >
> > > Does the above description sound correct to you?  How about the below
> > > diagram? Does it look correct to you?
> >
> > More or less.  The MES handles all of the queues (kernel or user).
> > The only real difference is that kernel queues are statically mapped
> > to an HQD while user queues are dynamically scheduled in the available
> > HQDs based on level of over-subscription.  E.g., if you have hardware
> > with 1 pipe and 2 HQDs you could have a kernel queue on 1 HQD and the
> > MES would schedule all of the user queues on the remaining 1 HQD.  If
> > you don't enable any kernel queues, then you have 2 HQDs that the MES
> > can use for scheduling user queues.
> >
> > >
> > > (I hope the diagram looks fine in your email client; if not, I can
> > > attach a picture of it.)
> > >
> > > +--------------------------------------------------------------------=
-----------------------------------------------------------------------+
> > > |                                                           GFX      =
                                                                       |
> > > |                                                                    =
                                                                       |
> > > |                                                                    =
           +-----------------------------+                             |
> > > |           +---------------------------------------------+ (Hw Queue=
 0)        | Kernel Queue (No eviction)  +------- No MES Scheduling    |
> > > |           |        (Hardware Queue 0)                   | ---------=
---------->|                             |               |             |
> > > |PIPE 0     |   -------------------------------------     |          =
           +-----------------------------+               X             |
> > > |           |        (Hardware Queue 1)                   |          =
                                              +----------+---------+   |
> > > |           |   -------------------------------------     |--+       =
                                              |                    |   |
> > > |           |                                             |  |       =
           +----------------------------+     |                    |   |
> > > |           +---------------------------------------------+  | (Hw Qu=
eue 1)     |                            |     |   MES Schedules    |   |
> > > |                                                            +-------=
---------> |  User Queue                +-----+                    |   |
> > > |                                                                    =
           |                            |     |                    |   |
> > > |                                                                    =
           +----------------------------+     |                    |   |
> > > |                                                                    =
                                              +--------------------+   |
> > > |                                                                    =
                                                        |              |
> > > |                                                                    =
                  +-------------------------------------+              |
> > > |                                                                    =
                  |Un/Map Ring                                         |
> > > |                                                                    =
                  |                                                    |
> > > +--------------------------------------------------------------------=
-----------------------------------------------------------------------+
> > >                                                                      =
                  |
> > >                                                                  +---=
------------------+--------------------------------------------+
> > >                                                                  |   =
MEMORY            v                                            |
> > >                                                                  |   =
                                                               |
> > >                                                                  |   =
                                                               |
> > >                                                                  |  +=
----------+                                                    |
> > >                                                                  |  |=
          |  +---------+         +--------+                    |
> > >                                                                  |  |=
    Ring 0|  | Ring 1  |  ...    | Ring N |                    |
> > >                                                                  |  |=
          |  |         |         |        |                    |
> > >                                                                  |  +=
----------+  +---------+         +--------+                    |
> > >                                                                  |   =
                                                               |
> > >                                                                  |   =
                                                               |
> > >                                                                  +---=
---------------------------------------------------------------+
> > >
> > > Is the idea in this series to experiment with making the kernel queue
> > > not fully occupy one of the hardware queue? By making the kernel queu=
e
> > > able to be scheduled, this would provide one extra queue to be used f=
or
> > > other things. Is this correct?
> >
> > Right.  This series paves the way for getting rid of kernel queues all
> > together.  Having no kernel queues leaves all of the resources
> > available to user queues.
>
> Another question: I guess kernel queues use VMID 0, and all of the other
> user queues will use a different VMID, right? Does the VMID matter for
> this transition to make the kernel queue legacy?

vmid 0 is the GPU virtual address space used for all kernel driver
operations.  For kernel queues, the queue itself operates in the vmid
0 address space, but each command buffer (Indirect Buffer -- IB)
operates in a driver assigned non-0 vmid address space.  For kernel
queues, the driver manages the vmids.  For user queues, the queue and
IBs both operate in the user's non-0 vmid address space.  The MES
manages the vmids assignments for user queues.  The driver provides a
pointer to the user's GPU VM page tables and MES assigns a vmid when
it maps the queue.  Driver provides a mask which vmids the MES can use
so that there are no conflicts when mixing kernel and user queues.

Alex

>
> Thanks
>
> >
> > >
> > > I'm unsure if I fully understand this series's idea; please correct m=
e
> > > if I'm wrong.
> > >
> > > Also, please elaborate more on the type of tasks that the kernel queu=
e
> > > handles. Tbh, I did not fully understand the idea behind it.
> >
> > In the future of user queues, kernel queues would not be created or
> > used at all.  Today, on most existing hardware, kernel queues are all
> > that is available.  Today, when an application submits work to the
> > kernel driver, the kernel driver submits all of the application
> > command buffers to kernel queues.  E.g., in most cases there is a
> > single kernel GFX queue and all applications which want to use the GFX
> > engine funnel into that queue.  The CS IOCTL basically takes the
> > command buffers from the applications and schedules them on the kernel
> > queue.  With user queues, each application will create its own user
> > queues and will submit work directly to its user queues.  No need for
> > an IOCTL for each submission, no need to share a single kernel queue,
> > etc.
> >
> > Alex
> >
> > >
> > > Thanks
> > >
> > > >
> > > > v2: use num_gfx_rings and num_compute_rings per
> > > >     Felix suggestion
> > > > v3: include num_gfx_rings fix in amdgpu_gfx.c
> > > > v4: additional fixes
> > > > v5: MEC EOP interrupt handling fix (Sunil)
> > > >
> > > > Alex Deucher (11):
> > > >   drm/amdgpu: add parameter to disable kernel queues
> > > >   drm/amdgpu: add ring flag for no user submissions
> > > >   drm/amdgpu/gfx: add generic handling for disable_kq
> > > >   drm/amdgpu/mes: centralize gfx_hqd mask management
> > > >   drm/amdgpu/mes: update hqd masks when disable_kq is set
> > > >   drm/amdgpu/mes: make more vmids available when disable_kq=3D1
> > > >   drm/amdgpu/gfx11: add support for disable_kq
> > > >   drm/amdgpu/gfx12: add support for disable_kq
> > > >   drm/amdgpu/sdma: add flag for tracking disable_kq
> > > >   drm/amdgpu/sdma6: add support for disable_kq
> > > >   drm/amdgpu/sdma7: add support for disable_kq
> > > >
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |   4 +
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   9 ++
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |   8 +-
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  30 ++--
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  26 ++-
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   2 +-
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   1 +
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 191 ++++++++++++++++---=
----
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 183 +++++++++++++++----=
---
> > > >  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |   2 +-
> > > >  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   |   2 +-
> > > >  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  16 +-
> > > >  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |  15 +-
> > > >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |   4 +
> > > >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |   4 +
> > > >  17 files changed, 345 insertions(+), 155 deletions(-)
> > > >
> > > > --
> > > > 2.48.1
> > > >
> > >
> > > --
> > > Rodrigo Siqueira
>
> --
> Rodrigo Siqueira
