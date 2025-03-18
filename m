Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C13C28B2F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 17:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 178E010E4B8;
	Tue, 18 Mar 2025 17:46:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="IIMc5PIQ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA1D10E4B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 17:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9IHs6ECRNA5KtdEpr3bQXKf17qSq3Dp2wvgG6sPeki8=; b=IIMc5PIQWmc6YtqQrSEdWYk6LT
 NX4Pz3R6dqs366+MT96icuq8cOVtaVDWmnsUZp7gPKejPx9IwGSAg17nyFZR1DpB5ht0lsJn2/ykk
 p6zJ69HPs17y1NREXvOVIffbqCaXyu/Wk46NXI8pxGOg8/yDd4Y1VUUfleZlB7vQ23iuBmMHuPOVK
 RZlTIQPGWCunsqCjuiZQsNGi4J0haU5vZDJq17cnKg15Dgl10775+FxX51VZfBFcwp1VJxzd2gKhO
 NhWpwou9lOpQgzo6TKU34c9Q7cw0mItdKacfB9zgbRRZBU+MQk90ic2GvgGcKRdY38NrKPR4lbLFn
 WkyxzKDA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tub0w-002rYX-0f; Tue, 18 Mar 2025 18:46:06 +0100
Date: Tue, 18 Mar 2025 11:46:01 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH V5 00/11] Add disable kernel queue support
Message-ID: <zuhuoeekbsx62g32lxq7qzq7eeqgh56xt64rpnh6zs75wonoie@hkruwukqfuem>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <6itqgifq2c2q3mo5uikvciog4n4ubviolciya5hgturekeykhd@rxzxgul5aqz7>
 <CADnq5_NTPr17pTyWAh9a_VQwBkEE7+wr8NMk0HWqFQb4mz1L1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_NTPr17pTyWAh9a_VQwBkEE7+wr8NMk0HWqFQb4mz1L1g@mail.gmail.com>
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

On 03/13, Alex Deucher wrote:
> On Thu, Mar 13, 2025 at 6:21 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
> >
> > n 03/13, Alex Deucher wrote:
> > > To better evaluate user queues, add a module parameter
> > > to disable kernel queues.  With this set kernel queues
> > > are disabled and only user queues are available.  This
> > > frees up hardware resources for use in user queues which
> > > would otherwise be used by kernel queues and provides
> > > a way to validate user queues without the presence
> > > of kernel queues.
> >
> > Hi Alex,
> >
> > I'm trying to understand how GFX and MES deal with different queues, and
> > I used this patchset to guide me through that. In this sense, could you
> > help me with the following points?
> >
> > FWIU, the GFX has what are called pipes, which in turn have hardware
> > queues associated with them. For example, a GFX can have 2 pipes, and
> > each pipe could have 2 hardware queues; or it could have 1 pipe and 8
> > queue. Is this correct?
>

Hi Alex, first of all, thanks a lot for your detailed explanation.

I still have some other questions, see it inline.
 
> Right.  For gfx, compute, and SDMA you have pipes (called instances on
> SDMA) and queues.  A pipe can only execute one queue at a time.  The

What is the difference between GFX and Compute? Tbh, I thought they were
the same component.

I was also thinking about the concept of a pipe, and I'm trying to
define what a pipe is in this context (the word pipe is one of those
words with many meanings in computers). Is the below definition accurate
enough?

 Pipe, in the context of GFX, Compute, and SDMA, is a mechanism for
 running threads.

> pipe will switch between all of the mapped queues.  You have storage

Above, you said that each pipe will switch between queues, and a little
bit below, in your explanation about MES, you said:

 [..] If there are more MQDs than HQDs, the MES firmware will preempt
 other user queues to make sure each queue gets a time slice.

Does it mean that the GFX Pipe has the mechanic of switching queues
while MES has the scheduling logic?

Does the below example and explanation make sense?

Suppose the following scenario:
 - One pipe (pipe0) and two queues (queue[0], and queue[1]).
 - 3 MQDs (mqd[0], mqd[1], and mqd[2]).
 - pipe0 is running an user queue in queue[1].
 - pipe0 is running a kernel queue in queue[0].

Fwiu, a pipe can change the current queue in execution, but it does not
do it by itself. In other words, it has no scheduling logic; it only has
the mechanics of switching queues inside it. When the pipe switches
between queues, it uses Mid Command Buffer Preemption (MCBP), which
saves some very basic information but has no register state; in other
words, those registers must be stored in memory (MES handles it?).

In turn, MES has access to all MQDs handed over to it, which means that
MES has all the queue states available for the scheduling and
communication with the GFX pipe. Suppose that the GFX pipe is running
mqd[2] in the queue[1], and now MES wants to replace it with mqd[0]. The
communication will be something like the following:

1. MES to GFX pipe0: Replace(mqd[2], in pipe0, queue[1]) with mqd[0].
2. GFX pipe0: Just stop the current pipe, and start mqd[0].

Does it looks correct to you?

> in memory (called an MDQ -- Memory Queue Descriptor) which defines the
> state of the queue (GPU virtual addresses of the queue itself, save
> areas, doorbell, etc.).  The queues that the pipe switches between are
> defined by HQDs (Hardware Queue Descriptors).  These are basically
> register based memory for the queues that the pipe can switch between.

I was thinking about this register-based memory part. Does it mean that
switching between it is just a matter of updating one of those LOW and
HIGH registers?

> The driver sets up an MQD for each queue that it creates.  The MQDs
> are then handed to the MES firmware for mapping.  The MES firmware can
> map a queue as a legacy queue (i.e. a kernel queue) or a user queue.
> The difference is that a legacy queue is statically mapped to a HQD
> and is never preempted.  User queues are dynamically mapped to the
> HQDs by the MES firmware.  If there are more MQDs than HQDs, the MES
> firmware will preempt other user queues to make sure each queue gets a
> time slice.
> 
> >
> > (for this next part, suppose 1 pipe 2 hardware queues)
> > By default, one of the hardware queues is reserved for the Kernel Queue,
> > and the user space could use the other. GFX has the MES block "connected"
> > to all pipe queues, and MES is responsible for scheduling different ring
> > buffers (in memory) in the pipe's hardware queue (effectively making the
> > ring active). However, since the kernel queue is always present, MES
> > only performs scheduling in one of the hardware queues. This scheduling
> > occurs with the MES mapping and unmapping available Rings in memory to
> > the hardware queue.
> >
> > Does the above description sound correct to you?  How about the below
> > diagram? Does it look correct to you?
> 
> More or less.  The MES handles all of the queues (kernel or user).
> The only real difference is that kernel queues are statically mapped
> to an HQD while user queues are dynamically scheduled in the available
> HQDs based on level of over-subscription.  E.g., if you have hardware
> with 1 pipe and 2 HQDs you could have a kernel queue on 1 HQD and the
> MES would schedule all of the user queues on the remaining 1 HQD.  If
> you don't enable any kernel queues, then you have 2 HQDs that the MES
> can use for scheduling user queues.
> 
> >
> > (I hope the diagram looks fine in your email client; if not, I can
> > attach a picture of it.)
> >
> > +-------------------------------------------------------------------------------------------------------------------------------------------+
> > |                                                           GFX                                                                             |
> > |                                                                                                                                           |
> > |                                                                               +-----------------------------+                             |
> > |           +---------------------------------------------+ (Hw Queue 0)        | Kernel Queue (No eviction)  +------- No MES Scheduling    |
> > |           |        (Hardware Queue 0)                   | ------------------->|                             |               |             |
> > |PIPE 0     |   -------------------------------------     |                     +-----------------------------+               X             |
> > |           |        (Hardware Queue 1)                   |                                                        +----------+---------+   |
> > |           |   -------------------------------------     |--+                                                     |                    |   |
> > |           |                                             |  |                  +----------------------------+     |                    |   |
> > |           +---------------------------------------------+  | (Hw Queue 1)     |                            |     |   MES Schedules    |   |
> > |                                                            +----------------> |  User Queue                +-----+                    |   |
> > |                                                                               |                            |     |                    |   |
> > |                                                                               +----------------------------+     |                    |   |
> > |                                                                                                                  +--------------------+   |
> > |                                                                                                                            |              |
> > |                                                                                      +-------------------------------------+              |
> > |                                                                                      |Un/Map Ring                                         |
> > |                                                                                      |                                                    |
> > +-------------------------------------------------------------------------------------------------------------------------------------------+
> >                                                                                        |
> >                                                                  +---------------------+--------------------------------------------+
> >                                                                  |   MEMORY            v                                            |
> >                                                                  |                                                                  |
> >                                                                  |                                                                  |
> >                                                                  |  +----------+                                                    |
> >                                                                  |  |          |  +---------+         +--------+                    |
> >                                                                  |  |    Ring 0|  | Ring 1  |  ...    | Ring N |                    |
> >                                                                  |  |          |  |         |         |        |                    |
> >                                                                  |  +----------+  +---------+         +--------+                    |
> >                                                                  |                                                                  |
> >                                                                  |                                                                  |
> >                                                                  +------------------------------------------------------------------+
> >
> > Is the idea in this series to experiment with making the kernel queue
> > not fully occupy one of the hardware queue? By making the kernel queue
> > able to be scheduled, this would provide one extra queue to be used for
> > other things. Is this correct?
> 
> Right.  This series paves the way for getting rid of kernel queues all
> together.  Having no kernel queues leaves all of the resources
> available to user queues.

Another question: I guess kernel queues use VMID 0, and all of the other
user queues will use a different VMID, right? Does the VMID matter for
this transition to make the kernel queue legacy?

Thanks

> 
> >
> > I'm unsure if I fully understand this series's idea; please correct me
> > if I'm wrong.
> >
> > Also, please elaborate more on the type of tasks that the kernel queue
> > handles. Tbh, I did not fully understand the idea behind it.
> 
> In the future of user queues, kernel queues would not be created or
> used at all.  Today, on most existing hardware, kernel queues are all
> that is available.  Today, when an application submits work to the
> kernel driver, the kernel driver submits all of the application
> command buffers to kernel queues.  E.g., in most cases there is a
> single kernel GFX queue and all applications which want to use the GFX
> engine funnel into that queue.  The CS IOCTL basically takes the
> command buffers from the applications and schedules them on the kernel
> queue.  With user queues, each application will create its own user
> queues and will submit work directly to its user queues.  No need for
> an IOCTL for each submission, no need to share a single kernel queue,
> etc.
> 
> Alex
> 
> >
> > Thanks
> >
> > >
> > > v2: use num_gfx_rings and num_compute_rings per
> > >     Felix suggestion
> > > v3: include num_gfx_rings fix in amdgpu_gfx.c
> > > v4: additional fixes
> > > v5: MEC EOP interrupt handling fix (Sunil)
> > >
> > > Alex Deucher (11):
> > >   drm/amdgpu: add parameter to disable kernel queues
> > >   drm/amdgpu: add ring flag for no user submissions
> > >   drm/amdgpu/gfx: add generic handling for disable_kq
> > >   drm/amdgpu/mes: centralize gfx_hqd mask management
> > >   drm/amdgpu/mes: update hqd masks when disable_kq is set
> > >   drm/amdgpu/mes: make more vmids available when disable_kq=1
> > >   drm/amdgpu/gfx11: add support for disable_kq
> > >   drm/amdgpu/gfx12: add support for disable_kq
> > >   drm/amdgpu/sdma: add flag for tracking disable_kq
> > >   drm/amdgpu/sdma6: add support for disable_kq
> > >   drm/amdgpu/sdma7: add support for disable_kq
> > >
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h      |   1 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |   4 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  |   9 ++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |   8 +-
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   2 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  30 ++--
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c  |  26 ++-
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   2 +-
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |   1 +
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 191 ++++++++++++++++-------
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 183 +++++++++++++++-------
> > >  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |   2 +-
> > >  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c   |   2 +-
> > >  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c   |  16 +-
> > >  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c   |  15 +-
> > >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |   4 +
> > >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |   4 +
> > >  17 files changed, 345 insertions(+), 155 deletions(-)
> > >
> > > --
> > > 2.48.1
> > >
> >
> > --
> > Rodrigo Siqueira

-- 
Rodrigo Siqueira
