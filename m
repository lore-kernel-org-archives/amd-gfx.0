Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36823C83F03
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jul 2025 21:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D241A10E8E7;
	Thu,  3 Jul 2025 21:06:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Mv3O950t";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E698E10E8E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jul 2025 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L6q2iTzAg/U4DrBxstd48TH1p6vURbhNzZpIkDrBxcw=; b=Mv3O950tkzQ1NzEJw2qdP2d+uu
 83zQ0gQq+YL9PaE9AwUu/FVcovjw+RUsYDSj0ZLWuX6NmdOgrvdaB/VdyFQO2m8Io/zKHudeXNO5o
 9fBhp/UcJfWoAGQ5594+y65BdoPnWEFXfvPIPYRpn4XprrIPhYSxMFwfkUaOHjACl/EAc8szfHAOW
 ZjzSn8MbDPPWNYJWlA8lfD7ucUN+W4AuKNOzDliEZHkEJojby5OxoSR/IFeXnsazdl+XEVGV4WBS9
 gLcnonlcW6f+WWIszBgcUUE7A51I6wx0o9rsV+fP5jjOPMq4nrtqm+jGXhY04zdCvYGOTe+bY7gYm
 DIYUfeDw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uXR8D-00C4mk-Ud; Thu, 03 Jul 2025 23:06:10 +0200
Date: Thu, 3 Jul 2025 15:06:05 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] Documentation: add initial documenation for user queues
Message-ID: <h6xtfigou6xb32kkw53ukipyzwp6sigguickyniklymvjmgs2q@nspsum5okfrn>
References: <20250502205924.935319-1-alexander.deucher@amd.com>
 <aws6c3hsphrcdaap4wmptu6q4psout2pdebzcupy4wtzasvufy@xcizj5e5rkgy>
 <CADnq5_PvPMtAeE1OPxtbEeuCTzkSrmvbgjwmutsCWN2zbKxQ+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PvPMtAeE1OPxtbEeuCTzkSrmvbgjwmutsCWN2zbKxQ+g@mail.gmail.com>
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

On 06/30, Alex Deucher wrote:
> On Tue, May 27, 2025 at 4:46 PM Rodrigo Siqueira <siqueira@igalia.com> wrote:
> >
> > Hi Alex,
> >
> > Follow some comments and questions.
> >
> > On 05/02, Alex Deucher wrote:
> > > Add an initial documentation page for user mode queues.
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  Documentation/gpu/amdgpu/index.rst |   1 +
> > >  Documentation/gpu/amdgpu/userq.rst | 196 +++++++++++++++++++++++++++++
> > >  2 files changed, 197 insertions(+)
> > >  create mode 100644 Documentation/gpu/amdgpu/userq.rst
> > >
> > > diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
> > > index bb2894b5edaf2..45523e9860fc5 100644
> > > --- a/Documentation/gpu/amdgpu/index.rst
> > > +++ b/Documentation/gpu/amdgpu/index.rst
> > > @@ -12,6 +12,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
> > >     module-parameters
> > >     gc/index
> > >     display/index
> > > +   userq
> > >     flashing
> > >     xgmi
> > >     ras
> > > diff --git a/Documentation/gpu/amdgpu/userq.rst b/Documentation/gpu/amdgpu/userq.rst
> > > new file mode 100644
> > > index 0000000000000..53e6b053f652f
> > > --- /dev/null
> > > +++ b/Documentation/gpu/amdgpu/userq.rst
> > > @@ -0,0 +1,196 @@
> > > +==================
> > > + User Mode Queues
> > > +==================
> > > +
> > > +Introduction
> > > +============
> > > +
> > > +Similar to the KFD, GPU engine queues move into userspace.  The idea is to let
> > > +user processes manage their submissions to the GPU engines directly, bypassing
> > > +IOCTL calls to the driver to submit work.  This reduces overhead and also allows
> > > +the GPU to submit work to itself.  Applications can set up work graphs of jobs
> > > +across multiple GPU engines without needing trips through the CPU.
> > > +
> > > +UMDs directly interface with firmware via per application shared memory areas.
> > > +The main vehicle for this is queue.  A queue is a ring buffer with a read
> > > +pointer (rptr) and a write pointer (wptr).  The UMD writes IP specific packets
> > > +into the queue and the firmware processes those packets, kicking off work on the
> > > +GPU engines.  The CPU in the application (or another queue or device) updates
> > > +the wptr to tell the firmware how far into the ring buffer to process packets
> > > +and the rtpr provides feedback to the UMD on how far the firmware has progressed
> > > +in executing those packets.  When the wptr and the rptr are equal, the queue is
> > > +idle.
> > > +
> > > +Theory of Operation
> > > +===================
> > > +
> > > +The various engines on modern AMD GPUs support multiple queues per engine with a
> > > +scheduling firmware which handles dynamically scheduling user queues on the
> > > +available hardware queue slots.  When the number of user queues outnumbers the
> > > +available hardware queue slots, the scheduling firmware dynamically maps and
> > > +unmaps queues based on priority and time quanta.  The state of each user queue
> > > +is managed in the kernel driver in an MQD (Memory Queue Descriptor).  This is a
> > > +buffer in GPU accessible memory that stores the state of a user queue.  The
> > > +scheduling firmware uses the MQD to load the queue state into an HQD (Hardware
> > > +Queue Descriptor) when a user queue is mapped.  Each user queue requires a
> > > +number of additional buffers which represent the ring buffer and any metadata
> > > +needed by the engine for runtime operation.  On most engines this consists of
> > > +the ring buffer itself, a rptr buffer (where the firmware will shadow the rptr
> > > +to userspace), a wrptr buffer (where the application will write the wptr for the
> > > +firmware to fetch it), and a doorbell.  A doorbell is a piece of the device's
> >
> > In this part, you started to explain about the doorbell; consider adding
> > a new paragraph here.
> 
> Added some additional info here.
> 
> >
> > Another idea could be to create a dedicated page to explain doorbells
> > and move all the general doorbell information from this patch to the new
> > page. I think there is no kernel-doc about amdgpu doorbells.
> >
> > > +MMIO BAR which can be mapped to specific user queues.  Writing to the doorbell
> > > +wakes the firmware and causes it to fetch the wptr and start processing the
> > > +packets in the queue. Each 4K page of the doorbell BAR supports specific offset
> > > +ranges for specific engines.  The doorbell of a queue most be mapped into the
> >
> > /most/must/
> 
> Fixed.
> 
> >
> > > +aperture aligned to the IP used by the queue (e.g., GFX, VCN, SDMA, etc.).
> > > +These doorbell apertures are set up via NBIO registers.  Doorbells are 32 bit or
> > > +64 bit (depending on the engine) chunks of the doorbell BAR.  A 4K doorbell page
> > > +provides 512 64-bit doorbells for up to 512 user queues.  A subset of each page
> > > +is reserved for each IP type supported on the device.  The user can query the
> > > +doorbell ranges for each IP via the INFO IOCTL.
> >
> > The first time that I read this, I was confused about the IOCTL part;
> > however, at the end of this patch, I noticed that you explained the
> > IOCTL part. Perhaps add a mention in parenthesis so the reader can see
> > more details about this info in the "IOCTL Interfaces" section.
> 
> Updated.
> 
> >
> > > +
> > > +When an application wants to create a user queue, it allocates the the necessary
> > > +buffers for the queue (ring buffer, wptr and rptr, context save areas, etc.).
> > > +These can be separate buffers or all part of one larger buffer.  The application
> > > +would map the buffer(s) into its GPUVM and use the GPU virtual addresses of for
> > > +the areas of memory they want t use for the user queue.  They would also
> >
> > /t/to/
> 
> Fixed.
> 
> >
> > > +allocate a doorbell page for the doorbells used by the user queues.  The
> > > +application would then populate the MQD in the USERQ IOCTL structure with the
> > > +GPU virtual addresses and doorbell index they want to use.  The user can also
> > > +specify the attributes for the user queue (priority, whether the queue is secure
> > > +for protected content, etc.).  The application would then call the USERQ
> > > +create IOCTL to create the queue from using the specified MQD.  The
> > > +kernel driver then validates the MQD provided by the application and translates
> > > +the MQD into the engine specific MQD format for the IP.  The IP specific MQD
> > > +would be allocated and the queue would be added to the run list maintained by
> > > +the scheduling firmware.  Once the queue has been created, the application can
> > > +write packets directly into the queue, update the wptr, and write to the
> > > +doorbell offset to kick off work in the user queue.
> > > +
> > > +When the application is done with the user queue, it would call the USERQ
> > > +FREE IOCTL to destroy it.  The kernel driver would preempt the queue and
> > > +remove it from the scheduling firmware's run list.  Then the IP specific MQD
> > > +would be freed and the user queue state would be cleaned up.
> >
> > Is it possible to add some pseudo-code that summarizes the programming
> > model described here?
> 
> I'm not sure I understand what you are asking for here.

Hi Alex,

You can ignore my question.

> 
> >
> > > +
> > > +Some engines may require the aggregated doorbell to if the engine does not
> >
> > /to/too/ or /to//?
> 
> Fixed.
> 
> >
> > Do you know which engines requires the aggreted doorbell? Can this
> > information be retrieved via IOCTL?  I think this information can be
> > helpful for userspace implementation.
> 
> No IPs which currently support user queues require the aggregated
> doorbell.  VCN likely will be the first IP
> that needs it.
> 
> >
> > > +support doorbells from unmapped queues.  The aggregated doorbell is a special
> > > +page of doorbell space which wakes the scheduler.  In cases where the engine may
> > > +be oversubscribed, some queues may not be mapped.  If the doorbell is rung when
> > > +the queue is not mapped, the engine firmware may miss the request.  Some
> > > +scheduling firmware may work around this my polling wptr shadows when the

/my/by/ ?

> > > +hardware is oversubscribed, other engines may support doorbell updates from
> > > +unmapped queues.  In the event that one of these options is not available, the
> > > +kernel driver will map a page of aggregated doorbell space into each GPUVM
> > > +space.  The UMD will then update the doorbell and wptr as normal and then write
> > > +to the aggregated doorbell as well.
> > > +
> > > +Special Packets
> > > +---------------
> > > +
> > > +In order to support legacy implicit synchronization, as well as mixed user and
> > > +kernel queues, we need a synchronization mechanism that is secure.  Because
> > > +kernel queues or memory management tasks depend on kernel fences, we need a way
> > > +for user queues to update memory that the kernel can use for a fence, that can't
> > > +be messed with by a bad actor.  To support this, we've added protected fence
> > > +packet.  This packet works by writing the a monotonically increasing value to
> > > +a memory location that is only the privileged clients have write access to.
> > > +User queues only have read access.  When this packet is executed, the memory
> > > +location is updated and other queues (kernel or user) can see the results.
> >
> > Does the driver handle this packet? I mean, does the driver insert it
> > without the userspace request? What is the packet name? How can I find
> > it in the kernel?
> 
> The actual packet format varies from IP to IP (GFX/Compute, SDMA, VCN,
> etc.), but the behavior is the same.  The packet submission is handled
> in userspace.  The kernel driver just sets up the privileged memory
> used for each user queue when it sets them up when the application
> creates them.

Could you include this additional information in the new version?

Thanks

> 
> >
> > > +
> > > +Memory Management
> > > +=================
> > > +
> > > +It is assumed that all buffers mapped into the GPUVM space for the process are
> > > +valid when engines on the GPU are running.  The kernel driver will only allow
> > > +user queues to run when all buffers are mapped.  If there is a memory event that
> > > +requires buffer migration, the kernel driver will preempt the user queues,
> > > +migrate buffers to where they need to be, update the GPUVM page tables and
> > > +invaldidate the TLB, and then resume the user queues.
> > > +
> > > +Interaction with Kernel Queues
> > > +==============================
> > > +
> > > +Depending on the IP and the scheduling firmware, you can enable kernel queues
> > > +and user queues at the same time,  However, you are limited by the HQD slots.
> >
> > /However/however/
> 
> Fixed.
> 
> >
> > > +Kernel queues are always mapped so any work the goes into kernel queues will
> > > +take priority.  This limits the available HQD slots for user queues.
> > > +
> > > +Not all IPs will support user queues on all GPUs.  As such, UMDs will need to
> > > +support both user queues and kernel queues depending on the IP.  For example, a
> > > +GPU may support user queues for GFX, compute, and SDMA, but not for VCN, JPEG,
> > > +and VPE.  UMDs need to support both.  The kernel driver provides a way to
> > > +determine if user queues and kernel queues are supported on a per IP basis.
> > > +UMDs can query this information via the INFO IOCTL and determine whether to use
> > > +kernel queues or user queues for each IP.
> > > +
> > > +Queue Resets
> > > +============
> > > +
> > > +For most engines, queues can be reset individually.  GFX, compute, and SDMA
> > > +queues can be reset individually.  When a hung queue is detected, it can be
> > > +reset either via the scheduling firmware or MMIO.  Since there are no kernel
> > > +fences for most user queues, they will usually only be detected when some other
> > > +event happens; e.g., a memory event which requires migration of buffers.  When
> > > +the queues are preempted, if the queue is hung, the preemption will fail.
> > > +Driver will them look up the queues that failed to preempt and reset them and
> > > +record which queues are hung.
> > > +
> > > +
> > > +On the UMD side, we will add an USERQ QUERY_STATUS IOCTL to query the queue
> > > +status.  UMD will provide the queue id in the IOCTL and the kernel driver
> > > +will check if it has already recorded the queue as hung (e.g., due to failed
> > > +peemption) and report back the status.
> > > +
> > > +IOCTL Interfaces
> > > +================
> > > +
> > > +GPU virtual addresses used for queues and related data (rptrs, wptrs, context
> > > +save areas, etc.) should be validated by the kernel mode driver to prevent the
> > > +user from specifying invalid GPU virtual addresses.  If the user provides
> > > +invalid GPU virtual addresses or doorbell indicies, the IOCTL should return an
> > > +error message.  These buffers should also be tracked in the kernel driver so
> > > +that if the user attempts to unmap the buffer(s) from the GPUVM, the umap call
> > > +would return an error.
> > > +
> > > +INFO
> > > +----
> > > +There are several new INFO queries related to user queues in order to query the
> > > +size of user queue meta data needed for a user queue (e.g., context save areas
> > > +or shadow buffers), and whether kernel or user queues or both are supported
> > > +for each IP type.
> > > +
> > > +USERQ
> > > +-----
> > > +The USERQ IOCTL is used for creating, freeing, and querying the status of user
> > > +queues.  It supports 3 opcodes:
> > > +
> > > +1. CREATE - Create a user queue.  The application provides a MQD-like structure
> > > +   that devices the type of queue and associated metadata and flags for that
> > > +   queue type.  Returns the queue id.
> > > +2. FREE - Free a user queue.
> > > +3. QUERY_STATRUS - Query that status of a queue.  Used to check if the queue is
> >
> > /QUERY_STATRUS/QUERY_STATUS/?
> 
> Fixed.
> 
> Thanks,
> 
> Alex
> 
> >
> > Thanks
> > Siqueira
> >
> > > +   healthy or not.  E.g., if the queue has been reset. (WIP)
> > > +
> > > +USERQ_SIGNAL
> > > +------------
> > > +The USERQ_SIGNAL IOCTL is used to provide a list of sync objects to be signaled.
> > > +
> > > +USERQ_WAIT
> > > +----------
> > > +The USERQ_WAIT IOCTL is used to provide a list of sync object to be waited on.
> > > +
> > > +Kernel and User Queues
> > > +======================
> > > +
> > > +In order to properly validate and test performance, we have a driver option to
> > > +select what type of queues are enabled (kernel queues, user queues or both).
> > > +The user_queue driver parameter allows you to enable kernel queues only (0),
> > > +user queues and kernel queues (1), and user queues only (2).  Enabling user
> > > +queues only will free up static queue assignments that would otherwise be used
> > > +by kernel queues for use by the scheduling firmware.  Some kernel queues are
> > > +required for kernel driver operation and they will always be created.  When the
> > > +kernel queues are not enabled, they are not registered with the drm scheduler
> > > +and the CS IOCTL will reject any incoming command submissions which target those
> > > +queue types.  Kernel queues only mirrors the behavior on all existing GPUs.
> > > +Enabling both queues allows for backwards compatibility with old userspace while
> > > +still supporting user queues.
> > > --
> > > 2.49.0
> > >
> >
> > --
> > Rodrigo Siqueira

-- 
Rodrigo Siqueira
