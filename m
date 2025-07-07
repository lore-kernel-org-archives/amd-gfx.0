Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB32C8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 09:29:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B034210E319;
	Mon,  7 Jul 2025 09:29:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=holodeck1.com header.i=@holodeck1.com header.b="gOCucfBN";
	dkim-atps=neutral
X-Greylist: delayed 360 seconds by postgrey-1.36 at gabe;
 Mon, 07 Jul 2025 09:29:46 UTC
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.155])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD7210E319
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 09:29:46 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mx.kolabnow.com (Postfix) with ESMTP id F192520B275B;
 Mon,  7 Jul 2025 11:23:44 +0200 (CEST)
Authentication-Results: ext-mx-out011.mykolab.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=holodeck1.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=holodeck1.com;
 h=content-type:content-type:mime-version:references:in-reply-to
 :organization:message-id:date:date:subject:subject:from:from
 :received:received:received; s=dkim2; t=1751880223; x=
 1753694624; bh=ucVJc7Nis8vBbLGTPWF3kBljITl4fTU5kUGtxKRPEug=; b=g
 OCucfBNhM6AG4KG8jN90wDFNI2k2dpFYMM4eGfB6vclUIWApjjtrcvwgsZW+fwHd
 jePdpoFli9T7odxWpbdRD4GSKcPOs+5fHdy8vUk1s8d3Xut4DWDbbO2RTEUs7hLV
 1yVCi1oNpdKAz6tG98AqjugfAhp39OIXAatANm7Miam37oydoPNGdlxnJ6K10Ho+
 ACWGpSu0w5y+O09jFBQZuPQoAN8TCE/2CKph/lB2gQ4aRcCUjm4Lfh5plL71yCsY
 5Hv1pvOdaiixNNrDrJotbQ1T9ZYekFe/idprv0W1dqfNpWJXHPROJnuOma5oyTLL
 pwkN5IFahwdXfbVk8j4Yg==
X-Virus-Scanned: amavis at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id HGYzK6BE8JMj; Mon,  7 Jul 2025 11:23:43 +0200 (CEST)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
 by mx.kolabnow.com (Postfix) with ESMTPS id 40B9120B2745;
 Mon,  7 Jul 2025 11:23:43 +0200 (CEST)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
 by int-mx009.mykolab.com (Postfix) with ESMTPS id F070D2093AFD;
 Mon,  7 Jul 2025 11:23:42 +0200 (CEST)
From: Jure Repinc <jlp@holodeck1.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] Documentation: add initial documenation for user queues
Date: Mon, 07 Jul 2025 11:23:35 +0200
Message-ID: <1908655.LH7GnMWURc@excalibur>
Organization: Holodeck 1
In-Reply-To: <20250502205924.935319-1-alexander.deucher@amd.com>
References: <20250502205924.935319-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3555875.sQuhbGJ8Bu";
 micalg="sha256"; protocol="application/pkcs7-signature"
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

--nextPart3555875.sQuhbGJ8Bu
Content-Type: multipart/alternative; boundary="nextPart2208764.yiUUSuA9gR"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart2208764.yiUUSuA9gR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi

Some suggestions in addition to ones from Rodrigo

> Add an initial documentation page for user mode queues.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  Documentation/gpu/amdgpu/index.rst |   1 +
>  Documentation/gpu/amdgpu/userq.rst | 196 +++++++++++++++++++++++++++++
>  2 files changed, 197 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/userq.rst
> 
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
> index bb2894b5edaf2..45523e9860fc5 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -12,6 +12,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
>     module-parameters
>     gc/index
>     display/index
> +   userq
>     flashing
>     xgmi
>     ras
> diff --git a/Documentation/gpu/amdgpu/userq.rst b/Documentation/gpu/amdgpu/userq.rst
> new file mode 100644
> index 0000000000000..53e6b053f652f
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/userq.rst
> @@ -0,0 +1,196 @@
> +==================
> + User Mode Queues
> +==================
> +
> +Introduction
> +============
> +
> +Similar to the KFD, GPU engine queues move into userspace.  The idea is to let
> +user processes manage their submissions to the GPU engines directly, bypassing
> +IOCTL calls to the driver to submit work.  This reduces overhead and also allows
> +the GPU to submit work to itself.  Applications can set up work graphs of jobs
> +across multiple GPU engines without needing trips through the CPU.
> +
> +UMDs directly interface with firmware via per application shared memory areas.
> +The main vehicle for this is queue.  A queue is a ring buffer with a read
> +pointer (rptr) and a write pointer (wptr).  The UMD writes IP specific packets
> +into the queue and the firmware processes those packets, kicking off work on the
> +GPU engines.  The CPU in the application (or another queue or device) updates
> +the wptr to tell the firmware how far into the ring buffer to process packets
> +and the rtpr provides feedback to the UMD on how far the firmware has progressed
> +in executing those packets.  When the wptr and the rptr are equal, the queue is
> +idle.
> +
> +Theory of Operation
> +===================
> +
> +The various engines on modern AMD GPUs support multiple queues per engine with a
> +scheduling firmware which handles dynamically scheduling user queues on the
> +available hardware queue slots.  When the number of user queues outnumbers the
> +available hardware queue slots, the scheduling firmware dynamically maps and
> +unmaps queues based on priority and time quanta.  The state of each user queue
> +is managed in the kernel driver in an MQD (Memory Queue Descriptor).  This is a
> +buffer in GPU accessible memory that stores the state of a user queue.  The
> +scheduling firmware uses the MQD to load the queue state into an HQD (Hardware
> +Queue Descriptor) when a user queue is mapped.  Each user queue requires a
> +number of additional buffers which represent the ring buffer and any metadata
> +needed by the engine for runtime operation.  On most engines this consists of
> +the ring buffer itself, a rptr buffer (where the firmware will shadow the rptr
> +to userspace), a wrptr buffer (where the application will write the wptr for the
wrptr -> wptr

> +firmware to fetch it), and a doorbell.  A doorbell is a piece of the device's
> +MMIO BAR which can be mapped to specific user queues.  Writing to the doorbell
> +wakes the firmware and causes it to fetch the wptr and start processing the
> +packets in the queue. Each 4K page of the doorbell BAR supports specific offset
> +ranges for specific engines.  The doorbell of a queue most be mapped into the
> +aperture aligned to the IP used by the queue (e.g., GFX, VCN, SDMA, etc.).
> +These doorbell apertures are set up via NBIO registers.  Doorbells are 32 bit or
> +64 bit (depending on the engine) chunks of the doorbell BAR.  A 4K doorbell page
> +provides 512 64-bit doorbells for up to 512 user queues.  A subset of each page
> +is reserved for each IP type supported on the device.  The user can query the
> +doorbell ranges for each IP via the INFO IOCTL.
> +
> +When an application wants to create a user queue, it allocates the the necessary
the the -> the

> +buffers for the queue (ring buffer, wptr and rptr, context save areas, etc.).
> +These can be separate buffers or all part of one larger buffer.  The application
> +would map the buffer(s) into its GPUVM and use the GPU virtual addresses of for
> +the areas of memory they want t use for the user queue.  They would also
> +allocate a doorbell page for the doorbells used by the user queues.  The
> +application would then populate the MQD in the USERQ IOCTL structure with the
> +GPU virtual addresses and doorbell index they want to use.  The user can also
> +specify the attributes for the user queue (priority, whether the queue is secure
> +for protected content, etc.).  The application would then call the USERQ
> +create IOCTL to create the queue from using the specified MQD.  The
create IOCTL -> CREATE IOCTL
> +kernel driver then validates the MQD provided by the application and translates
> +the MQD into the engine specific MQD format for the IP.  The IP specific MQD
> +would be allocated and the queue would be added to the run list maintained by
> +the scheduling firmware.  Once the queue has been created, the application can
> +write packets directly into the queue, update the wptr, and write to the
> +doorbell offset to kick off work in the user queue.
> +
> +When the application is done with the user queue, it would call the USERQ
> +FREE IOCTL to destroy it.  The kernel driver would preempt the queue and
> +remove it from the scheduling firmware's run list.  Then the IP specific MQD
> +would be freed and the user queue state would be cleaned up.
> +
> +Some engines may require the aggregated doorbell to if the engine does not
> +support doorbells from unmapped queues.  The aggregated doorbell is a special
> +page of doorbell space which wakes the scheduler.  In cases where the engine may
> +be oversubscribed, some queues may not be mapped.  If the doorbell is rung when
> +the queue is not mapped, the engine firmware may miss the request.  Some
> +scheduling firmware may work around this my polling wptr shadows when the
> +hardware is oversubscribed, other engines may support doorbell updates from
> +unmapped queues.  In the event that one of these options is not available, the
> +kernel driver will map a page of aggregated doorbell space into each GPUVM
> +space.  The UMD will then update the doorbell and wptr as normal and then write
> +to the aggregated doorbell as well.
> +
> +Special Packets
> +---------------
> +
> +In order to support legacy implicit synchronization, as well as mixed user and
> +kernel queues, we need a synchronization mechanism that is secure.  Because
> +kernel queues or memory management tasks depend on kernel fences, we need a way
> +for user queues to update memory that the kernel can use for a fence, that can't
> +be messed with by a bad actor.  To support this, we've added protected fence
> +packet.  This packet works by writing the a monotonically increasing value to
the a -> a

> +a memory location that is only the privileged clients have write access to.
is only -> only

> +User queues only have read access.  When this packet is executed, the memory
> +location is updated and other queues (kernel or user) can see the results.
> +
> +Memory Management
> +=================
> +
> +It is assumed that all buffers mapped into the GPUVM space for the process are
> +valid when engines on the GPU are running.  The kernel driver will only allow
> +user queues to run when all buffers are mapped.  If there is a memory event that
> +requires buffer migration, the kernel driver will preempt the user queues,
> +migrate buffers to where they need to be, update the GPUVM page tables and
> +invaldidate the TLB, and then resume the user queues.
> +
> +Interaction with Kernel Queues
> +==============================
> +
> +Depending on the IP and the scheduling firmware, you can enable kernel queues
> +and user queues at the same time,  However, you are limited by the HQD slots.
> +Kernel queues are always mapped so any work the goes into kernel queues will
the goes -> that goes

> +take priority.  This limits the available HQD slots for user queues.
> +
> +Not all IPs will support user queues on all GPUs.  As such, UMDs will need to
> +support both user queues and kernel queues depending on the IP.  For example, a
> +GPU may support user queues for GFX, compute, and SDMA, but not for VCN, JPEG,
> +and VPE.  UMDs need to support both.  The kernel driver provides a way to
> +determine if user queues and kernel queues are supported on a per IP basis.
> +UMDs can query this information via the INFO IOCTL and determine whether to use
> +kernel queues or user queues for each IP.
> +
> +Queue Resets
> +============
> +
> +For most engines, queues can be reset individually.  GFX, compute, and SDMA
> +queues can be reset individually.  When a hung queue is detected, it can be
> +reset either via the scheduling firmware or MMIO.  Since there are no kernel
> +fences for most user queues, they will usually only be detected when some other
> +event happens; e.g., a memory event which requires migration of buffers.  When
> +the queues are preempted, if the queue is hung, the preemption will fail.
> +Driver will them look up the queues that failed to preempt and reset them and
them -> then

> +record which queues are hung.
> +
> +
> +On the UMD side, we will add an USERQ QUERY_STATUS IOCTL to query the queue
an USERQ -> a USERQ

> +status.  UMD will provide the queue id in the IOCTL and the kernel driver
> +will check if it has already recorded the queue as hung (e.g., due to failed
> +peemption) and report back the status.
> +
> +IOCTL Interfaces
> +================
> +
> +GPU virtual addresses used for queues and related data (rptrs, wptrs, context
> +save areas, etc.) should be validated by the kernel mode driver to prevent the
> +user from specifying invalid GPU virtual addresses.  If the user provides
> +invalid GPU virtual addresses or doorbell indicies, the IOCTL should return an
> +error message.  These buffers should also be tracked in the kernel driver so
> +that if the user attempts to unmap the buffer(s) from the GPUVM, the umap call
> +would return an error.
> +
> +INFO
> +----
> +There are several new INFO queries related to user queues in order to query the
> +size of user queue meta data needed for a user queue (e.g., context save areas
> +or shadow buffers), and whether kernel or user queues or both are supported
> +for each IP type.
> +
> +USERQ
> +-----
> +The USERQ IOCTL is used for creating, freeing, and querying the status of user
> +queues.  It supports 3 opcodes:
> +
> +1. CREATE - Create a user queue.  The application provides a MQD-like structure
> +   that devices the type of queue and associated metadata and flags for that
devices -> describes/defines

> +   queue type.  Returns the queue id.
> +2. FREE - Free a user queue.
> +3. QUERY_STATRUS - Query that status of a queue.  Used to check if the queue is
> +   healthy or not.  E.g., if the queue has been reset. (WIP)
> +
> +USERQ_SIGNAL
> +------------
> +The USERQ_SIGNAL IOCTL is used to provide a list of sync objects to be signaled.
> +
> +USERQ_WAIT
> +----------
> +The USERQ_WAIT IOCTL is used to provide a list of sync object to be waited on.
> +
> +Kernel and User Queues
> +======================
> +
> +In order to properly validate and test performance, we have a driver option to
> +select what type of queues are enabled (kernel queues, user queues or both).
> +The user_queue driver parameter allows you to enable kernel queues only (0),
> +user queues and kernel queues (1), and user queues only (2).  Enabling user
> +queues only will free up static queue assignments that would otherwise be used
> +by kernel queues for use by the scheduling firmware.  Some kernel queues are
> +required for kernel driver operation and they will always be created.  When the
> +kernel queues are not enabled, they are not registered with the drm scheduler
> +and the CS IOCTL will reject any incoming command submissions which target those
> +queue types.  Kernel queues only mirrors the behavior on all existing GPUs.
> +Enabling both queues allows for backwards compatibility with old userspace while
> +still supporting user queues.
> 

Have a great time,
Jure Repinc

-- 
         Jabber/XMPP: JLP@jabber.org
              Matrix: @jlp:matrix.org
Mastodon/ActivityPub: @JRepin@mstdn.io


--nextPart2208764.yiUUSuA9gR
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="utf-8"

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Hi</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Some suggestions in addition to ones from Rodrigo</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Add an initial documentation page for user mode queues.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; ---</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp; Documentation/gpu/amdgpu/index.rst |&nbsp;&nbsp; 1 +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp; Documentation/gpu/amdgpu/userq.rst | 196 +++++++++++++++++++++++++++++</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp; 2 files changed, 197 insertions(+)</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp; create mode 100644 Documentation/gpu/amdgpu/userq.rst</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; index bb2894b5edaf2..45523e9860fc5 100644</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; --- a/Documentation/gpu/amdgpu/index.rst</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +++ b/Documentation/gpu/amdgpu/index.rst</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; @@ -12,6 +12,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp;&nbsp;&nbsp;&nbsp; module-parameters</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp;&nbsp;&nbsp;&nbsp; gc/index</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp;&nbsp;&nbsp;&nbsp; display/index</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp; userq</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp;&nbsp;&nbsp;&nbsp; flashing</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp;&nbsp;&nbsp;&nbsp; xgmi</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt;&nbsp;&nbsp;&nbsp;&nbsp; ras</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; diff --git a/Documentation/gpu/amdgpu/userq.rst b/Documentation/gpu/amdgpu/userq.rst</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; new file mode 100644</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; index 0000000000000..53e6b053f652f</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; --- /dev/null</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +++ b/Documentation/gpu/amdgpu/userq.rst</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; @@ -0,0 +1,196 @@</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +==================</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; + User Mode Queues</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +==================</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Introduction</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +============</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Similar to the KFD, GPU engine queues move into userspace.&nbsp; The idea is to let</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +user processes manage their submissions to the GPU engines directly, bypassing</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +IOCTL calls to the driver to submit work.&nbsp; This reduces overhead and also allows</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +the GPU to submit work to itself.&nbsp; Applications can set up work graphs of jobs</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +across multiple GPU engines without needing trips through the CPU.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +UMDs directly interface with firmware via per application shared memory areas.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +The main vehicle for this is queue.&nbsp; A queue is a ring buffer with a read</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +pointer (rptr) and a write pointer (wptr).&nbsp; The UMD writes IP specific packets</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +into the queue and the firmware processes those packets, kicking off work on the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +GPU engines.&nbsp; The CPU in the application (or another queue or device) updates</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +the wptr to tell the firmware how far into the ring buffer to process packets</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +and the rtpr provides feedback to the UMD on how far the firmware has progressed</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +in executing those packets.&nbsp; When the wptr and the rptr are equal, the queue is</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +idle.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Theory of Operation</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +===================</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +The various engines on modern AMD GPUs support multiple queues per engine with a</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +scheduling firmware which handles dynamically scheduling user queues on the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +available hardware queue slots.&nbsp; When the number of user queues outnumbers the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +available hardware queue slots, the scheduling firmware dynamically maps and</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +unmaps queues based on priority and time quanta.&nbsp; The state of each user queue</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +is managed in the kernel driver in an MQD (Memory Queue Descriptor).&nbsp; This is a</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +buffer in GPU accessible memory that stores the state of a user queue.&nbsp; The</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +scheduling firmware uses the MQD to load the queue state into an HQD (Hardware</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Queue Descriptor) when a user queue is mapped.&nbsp; Each user queue requires a</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +number of additional buffers which represent the ring buffer and any metadata</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +needed by the engine for runtime operation.&nbsp; On most engines this consists of</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +the ring buffer itself, a rptr buffer (where the firmware will shadow the rptr</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +to userspace), a wrptr buffer (where the application will write the wptr for the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">wrptr -&gt; wptr</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +firmware to fetch it), and a doorbell.&nbsp; A doorbell is a piece of the device's</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +MMIO BAR which can be mapped to specific user queues.&nbsp; Writing to the doorbell</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +wakes the firmware and causes it to fetch the wptr and start processing the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +packets in the queue. Each 4K page of the doorbell BAR supports specific offset</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +ranges for specific engines.&nbsp; The doorbell of a queue most be mapped into the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +aperture aligned to the IP used by the queue (e.g., GFX, VCN, SDMA, etc.).</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +These doorbell apertures are set up via NBIO registers.&nbsp; Doorbells are 32 bit or</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +64 bit (depending on the engine) chunks of the doorbell BAR.&nbsp; A 4K doorbell page</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +provides 512 64-bit doorbells for up to 512 user queues.&nbsp; A subset of each page</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +is reserved for each IP type supported on the device.&nbsp; The user can query the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +doorbell ranges for each IP via the INFO IOCTL.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +When an application wants to create a user queue, it allocates the the necessary</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">the the -&gt; the</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +buffers for the queue (ring buffer, wptr and rptr, context save areas, etc.).</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +These can be separate buffers or all part of one larger buffer.&nbsp; The application</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +would map the buffer(s) into its GPUVM and use the GPU virtual addresses of for</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +the areas of memory they want t use for the user queue.&nbsp; They would also</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +allocate a doorbell page for the doorbells used by the user queues.&nbsp; The</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +application would then populate the MQD in the USERQ IOCTL structure with the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +GPU virtual addresses and doorbell index they want to use.&nbsp; The user can also</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +specify the attributes for the user queue (priority, whether the queue is secure</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +for protected content, etc.).&nbsp; The application would then call the USERQ</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +create IOCTL to create the queue from using the specified MQD.&nbsp; The</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">create IOCTL -&gt; CREATE IOCTL</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +kernel driver then validates the MQD provided by the application and translates</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +the MQD into the engine specific MQD format for the IP.&nbsp; The IP specific MQD</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +would be allocated and the queue would be added to the run list maintained by</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +the scheduling firmware.&nbsp; Once the queue has been created, the application can</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +write packets directly into the queue, update the wptr, and write to the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +doorbell offset to kick off work in the user queue.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +When the application is done with the user queue, it would call the USERQ</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +FREE IOCTL to destroy it.&nbsp; The kernel driver would preempt the queue and</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +remove it from the scheduling firmware's run list.&nbsp; Then the IP specific MQD</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +would be freed and the user queue state would be cleaned up.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Some engines may require the aggregated doorbell to if the engine does not</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +support doorbells from unmapped queues.&nbsp; The aggregated doorbell is a special</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +page of doorbell space which wakes the scheduler.&nbsp; In cases where the engine may</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +be oversubscribed, some queues may not be mapped.&nbsp; If the doorbell is rung when</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +the queue is not mapped, the engine firmware may miss the request.&nbsp; Some</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +scheduling firmware may work around this my polling wptr shadows when the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +hardware is oversubscribed, other engines may support doorbell updates from</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +unmapped queues.&nbsp; In the event that one of these options is not available, the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +kernel driver will map a page of aggregated doorbell space into each GPUVM</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +space.&nbsp; The UMD will then update the doorbell and wptr as normal and then write</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +to the aggregated doorbell as well.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Special Packets</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +---------------</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +In order to support legacy implicit synchronization, as well as mixed user and</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +kernel queues, we need a synchronization mechanism that is secure.&nbsp; Because</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +kernel queues or memory management tasks depend on kernel fences, we need a way</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +for user queues to update memory that the kernel can use for a fence, that can't</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +be messed with by a bad actor.&nbsp; To support this, we've added protected fence</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +packet.&nbsp; This packet works by writing the a monotonically increasing value to</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">the a -&gt; a</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +a memory location that is only the privileged clients have write access to.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">is only -&gt; only</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +User queues only have read access.&nbsp; When this packet is executed, the memory</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +location is updated and other queues (kernel or user) can see the results.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Memory Management</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +=================</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +It is assumed that all buffers mapped into the GPUVM space for the process are</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +valid when engines on the GPU are running.&nbsp; The kernel driver will only allow</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +user queues to run when all buffers are mapped.&nbsp; If there is a memory event that</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +requires buffer migration, the kernel driver will preempt the user queues,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +migrate buffers to where they need to be, update the GPUVM page tables and</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +invaldidate the TLB, and then resume the user queues.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Interaction with Kernel Queues</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +==============================</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Depending on the IP and the scheduling firmware, you can enable kernel queues</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +and user queues at the same time,&nbsp; However, you are limited by the HQD slots.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Kernel queues are always mapped so any work the goes into kernel queues will</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">the goes -&gt; that goes</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +take priority.&nbsp; This limits the available HQD slots for user queues.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Not all IPs will support user queues on all GPUs.&nbsp; As such, UMDs will need to</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +support both user queues and kernel queues depending on the IP.&nbsp; For example, a</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +GPU may support user queues for GFX, compute, and SDMA, but not for VCN, JPEG,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +and VPE.&nbsp; UMDs need to support both.&nbsp; The kernel driver provides a way to</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +determine if user queues and kernel queues are supported on a per IP basis.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +UMDs can query this information via the INFO IOCTL and determine whether to use</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +kernel queues or user queues for each IP.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Queue Resets</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +============</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +For most engines, queues can be reset individually.&nbsp; GFX, compute, and SDMA</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +queues can be reset individually.&nbsp; When a hung queue is detected, it can be</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +reset either via the scheduling firmware or MMIO.&nbsp; Since there are no kernel</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +fences for most user queues, they will usually only be detected when some other</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +event happens; e.g., a memory event which requires migration of buffers.&nbsp; When</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +the queues are preempted, if the queue is hung, the preemption will fail.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Driver will them look up the queues that failed to preempt and reset them and</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">them -&gt; then</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +record which queues are hung.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +On the UMD side, we will add an USERQ QUERY_STATUS IOCTL to query the queue</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">an USERQ -&gt; a USERQ</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +status.&nbsp; UMD will provide the queue id in the IOCTL and the kernel driver</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +will check if it has already recorded the queue as hung (e.g., due to failed</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +peemption) and report back the status.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +IOCTL Interfaces</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +================</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +GPU virtual addresses used for queues and related data (rptrs, wptrs, context</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +save areas, etc.) should be validated by the kernel mode driver to prevent the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +user from specifying invalid GPU virtual addresses.&nbsp; If the user provides</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +invalid GPU virtual addresses or doorbell indicies, the IOCTL should return an</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +error message.&nbsp; These buffers should also be tracked in the kernel driver so</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +that if the user attempts to unmap the buffer(s) from the GPUVM, the umap call</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +would return an error.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +INFO</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +----</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +There are several new INFO queries related to user queues in order to query the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +size of user queue meta data needed for a user queue (e.g., context save areas</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +or shadow buffers), and whether kernel or user queues or both are supported</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +for each IP type.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +USERQ</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +-----</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +The USERQ IOCTL is used for creating, freeing, and querying the status of user</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +queues.&nbsp; It supports 3 opcodes:</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +1. CREATE - Create a user queue.&nbsp; The application provides a MQD-like structure</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp; that devices the type of queue and associated metadata and flags for that</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">devices -&gt; describes/defines</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp; queue type.&nbsp; Returns the queue id.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +2. FREE - Free a user queue.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +3. QUERY_STATRUS - Query that status of a queue.&nbsp; Used to check if the queue is</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +&nbsp;&nbsp; healthy or not.&nbsp; E.g., if the queue has been reset. (WIP)</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +USERQ_SIGNAL</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +------------</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +The USERQ_SIGNAL IOCTL is used to provide a list of sync objects to be signaled.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +USERQ_WAIT</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +----------</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +The USERQ_WAIT IOCTL is used to provide a list of sync object to be waited on.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Kernel and User Queues</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +======================</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +In order to properly validate and test performance, we have a driver option to</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +select what type of queues are enabled (kernel queues, user queues or both).</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +The user_queue driver parameter allows you to enable kernel queues only (0),</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +user queues and kernel queues (1), and user queues only (2).&nbsp; Enabling user</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +queues only will free up static queue assignments that would otherwise be used</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +by kernel queues for use by the scheduling firmware.&nbsp; Some kernel queues are</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +required for kernel driver operation and they will always be created.&nbsp; When the</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +kernel queues are not enabled, they are not registered with the drm scheduler</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +and the CS IOCTL will reject any incoming command submissions which target those</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +queue types.&nbsp; Kernel queues only mirrors the behavior on all existing GPUs.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +Enabling both queues allows for backwards compatibility with old userspace while</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; +still supporting user queues.</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&gt; </p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Have a great time,</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Jure Repinc</p>
<br /><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">-- </p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Jabber/XMPP: JLP@jabber.org</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Matrix: @jlp:matrix.org</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Mastodon/ActivityPub: @JRepin@mstdn.io</p>
<br /></body>
</html>
--nextPart2208764.yiUUSuA9gR--

--nextPart3555875.sQuhbGJ8Bu
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIP3gYJKoZIhvcNAQcCoIIPzzCCD8sCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg1qMIIGdTCCBN2gAwIBAgIMKMOYHQAAAABXHdDnMA0GCSqGSIb3DQEBCwUAMFwxCzAJBgNVBAYT
AlNJMRwwGgYDVQQKExNSZXB1Ymxpa2EgU2xvdmVuaWphMRcwFQYDVQRhEw5WQVRTSS0xNzY1OTk1
NzEWMBQGA1UEAxMNU0ktVFJVU1QgUm9vdDAeFw0xNjA1MjQxMTQ5NDFaFw0zNjA0MjMyMjAwMDBa
MFoxCzAJBgNVBAYTAlNJMRwwGgYDVQQKExNSZXB1Ymxpa2EgU2xvdmVuaWphMRcwFQYDVQRhEw5W
QVRTSS0xNzY1OTk1NzEUMBIGA1UEAxMLU0lHRU4tQ0EgRzIwggGiMA0GCSqGSIb3DQEBAQUAA4IB
jwAwggGKAoIBgQDRJl0dqc7nAg7Bi5WGSvyYlSuJq1N/3IqHKoA4JK2iB46GMBSc/akw2EMOigD1
9Uce9jNnKi3cZpDMQglTi3MlAX3pv8wajmMBMfQ2P5ID2F3VkcZVKWlPUAnWjzr+3SW3neGqMN+/
3jixXPuyB45BGhW1kjqZ5i8DIwppQuF3dUYAkyESdGCwtqYAWn1d1vATzdRs7fn5uKNCGqbMcYaL
7hhC5Z0j+hnfKuZKRtzSH9xM07+xXKIoF8gvYEfWB/lkcIdVEUBANSa8TefuhVoClTapLH/zjZBV
tHt4xBMbc+6go8KD/p7J+V9+uH3QCgzM3RdIIgl13TJUtMWAByzmkq74UFM0CsOTlVvpfUzqEUUY
Zi0PYtg6/fDzg1k2dtqOEeQonQVBtPot0bP643D0zDS/kk0+V4zeQjhhVawBAvwTsOXOx9MRzyt8
5mnlMMN4Vdqk2vJd2C+uADBknlFXv5CM2CmtAbOXH4OeS0qICTqqWw8uh6T+DVl4eommyY8CAwEA
AaOCAjcwggIzMBIGA1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQDAgEGMDoGA1UdIAQzMDEw
LwYEVR0gADAnMCUGCCsGAQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9jcHMvMGkGCCsGAQUF
BwEBBF0wWzA2BggrBgEFBQcwAoYqaHR0cDovL3d3dy5jYS5nb3Yuc2kvY3J0L3NpLXRydXN0LXJv
b3QuY3J0MCEGCCsGAQUFBzABhhVodHRwOi8vb2NzcC5jYS5nb3Yuc2kwEQYDVR0OBAoECEwlJ4yo
LXKeMIIBPAYDVR0fBIIBMzCCAS8wgbeggbSggbGGKmh0dHA6Ly93d3cuY2EuZ292LnNpL2NybC9z
aS10cnVzdC1yb290LmNybIaBgmxkYXA6Ly94NTAwLmdvdi5zaS9jbj1TSS1UUlVTVCUyMFJvb3Qs
b3JnYW5pemF0aW9uSWRlbnRpZmllcj1WQVRTSS0xNzY1OTk1NyxvPVJlcHVibGlrYSUyMFNsb3Zl
bmlqYSxjPVNJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3Qwc6BxoG+kbTBrMQswCQYDVQQGEwJT
STEcMBoGA1UEChMTUmVwdWJsaWthIFNsb3ZlbmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2NTk5NTcx
FjAUBgNVBAMTDVNJLVRSVVNUIFJvb3QxDTALBgNVBAMTBENSTDEwEwYDVR0jBAwwCoAITKPDaF4I
AmMwDQYJKoZIhvcNAQELBQADggGBADVgVyRt64166Ry1oNxqii/zIzrKEr24IPkI7vJmczGJ/lRm
6vIaZBdxeuebD1KICR8YQznI0xRiQZ/cz2oINJdVqCqXlOddRZvufWIcZXpmDPlig86+gueYtJIR
Lq+gk4Fjz8tdPo6GhYN7b9wQ15FYDIjgPzEDnq/YQJ+ZJs9aPotskKHvKyaDg8NibS7qdiLXaToo
WFCaSV4h+JPtStbw+R7MaLnHvyp8sqhl4vgnPNv3TLwPmWr1jU+EP1gx5axEkKpJamc1zMgTWw/F
S4VzrxSKsDZM/7E6cCZHCWziPWs8C3uLqye2tBBBCgjmyNY5XC8rj85Rbpl5K1SIlg9jetEfUNoa
WXP0S/GgAtgB5EQ9IXwSjf9D/DxqvOme5bhK7o2l3r/1/OvPmoYttgQhBmpIYQfzacB94yTHDCJZ
rWqFc+DW4BOg/dyLLsykcNEnYWClibUWiU/ITlW/AcKkuovMQVMAHYu4u5LveEWEymkbaTxRmHx3
/swn3eZi2jCCBu0wggVVoAMCAQICDBSL7r4AAAAAVyU92jANBgkqhkiG9w0BAQsFADBaMQswCQYD
VQQGEwJTSTEcMBoGA1UEChMTUmVwdWJsaWthIFNsb3ZlbmlqYTEXMBUGA1UEYRMOVkFUU0ktMTc2
NTk5NTcxFDASBgNVBAMTC1NJR0VOLUNBIEcyMB4XDTIwMTAwNjE2MzMwMFoXDTI1MTAwNjE3MDMw
MFowfzELMAkGA1UEBhMCU0kxEjAQBgNVBAgTCVNsb3ZlbmlqYTEUMBIGA1UECxMLaW5kaXZpZHVh
bHMxRjALBgNVBCoTBEp1cmUwDQYDVQQEEwZSZXBpbmMwEgYDVQQDEwtKdXJlIFJlcGluYzAUBgNV
BAUTDTI0NjY0NzgzMTIwMzkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCu1oYnY4M9
ZB4zQrL+Ynjuc1zIYxmHZNwqgv38oz5QzIdJIyg0XRgaOrFcevE30AZMrSwYsVD689pEnQgqrkbA
JqExEBi3TtmsH4N5czwtIDiP2MYp9lkrNV/+/ND8hUUVz1i4LkFt8k8PHujuPrLgY/zmsS6Sz07I
G05lf/gxlkPMKn8oOKwiCAny4qUYEEZeQG6B2gjkayXn11Uz4DVEIpUd76BaQAYgmC1kicmJXWYm
CqKjQDMlXekvNhpFgmse3jnAlunPfoBtWM3OjSra7EJGSrWIkL1aHcXc8wMhwT2n9IsEuTitZOKw
S17bOKEqWzQ/fXGgTyt8BSSMB6H3AgMBAAGjggMMMIIDCDAOBgNVHQ8BAf8EBAMCBeAwTAYDVR0g
BEUwQzA2BgsrBgEEAa9ZAgIDBTAnMCUGCCsGAQUFBwIBFhlodHRwOi8vd3d3LmNhLmdvdi5zaS9j
cHMvMAkGBwQAi+xAAQAwgaUGCCsGAQUFBwEDBIGYMIGVMAgGBgQAjkYBATB0BgYEAI5GAQUwajAz
Fi1odHRwczovL3d3dy5jYS5nb3Yuc2kvY3BzL3NpZ2VuY2EyX3Bkc19lbi5wZGYTAmVuMDMWLWh0
dHBzOi8vd3d3LmNhLmdvdi5zaS9jcHMvc2lnZW5jYTJfcGRzX3NsLnBkZhMCc2wwEwYGBACORgEG
MAkGBwQAjkYBBgEwcQYIKwYBBQUHAQEEZTBjMDwGCCsGAQUFBzAChjBodHRwOi8vd3d3LnNpZ2Vu
LWNhLnNpL2NydC9zaWdlbi1jYS1nMi1jZXJ0cy5wN2MwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3Nw
LnNpZ2VuLWNhLnNpMBwGA1UdEQQVMBOBEWpscEBob2xvZGVjazEuY29tMIIBOgYDVR0fBIIBMTCC
AS0wgbWggbKgga+GKmh0dHA6Ly93d3cuc2lnZW4tY2Euc2kvY3JsL3NpZ2VuLWNhLWcyLmNybIaB
gGxkYXA6Ly94NTAwLmdvdi5zaS9jbj1TSUdFTi1DQSUyMEcyLG9yZ2FuaXphdGlvbklkZW50aWZp
ZXI9VkFUU0ktMTc2NTk5NTcsbz1SZXB1Ymxpa2ElMjBTbG92ZW5pamEsYz1TST9jZXJ0aWZpY2F0
ZVJldm9jYXRpb25MaXN0MHOgcaBvpG0wazELMAkGA1UEBhMCU0kxHDAaBgNVBAoTE1JlcHVibGlr
YSBTbG92ZW5pamExFzAVBgNVBGETDlZBVFNJLTE3NjU5OTU3MRQwEgYDVQQDEwtTSUdFTi1DQSBH
MjEPMA0GA1UEAxMGQ1JMMzM1MBMGA1UdIwQMMAqACEwlJ4yoLXKeMBEGA1UdDgQKBAhBsPrpktbp
jTAJBgNVHRMEAjAAMA0GCSqGSIb3DQEBCwUAA4IBgQB7FJBhacs9mzlIcERXuoNW+MjDa9dEflGl
cfDWQsZSmuuu8k11KGfoQtqB6a/CT7mYf54abpcWMjQ3H9y0gwft/ZX5sHQsZV/qGyh+2KjE+gwA
XXZ2R5lIAYDkZQBBU88dE6XzR3ibgpQ6O7wmGBN6dmIwLK1LMpOtEwHQqw/WWB6gRS+mpPnZhk9Z
6i4WVRHf5Gs/Xl3vUtV2V5VziGTc4evMh49+VG4oNG9EyF110JSAdAIbZ/F+Jz49UlzGrau6dh3H
pS/tBk0m+nTdHurklnCobrPsE9viAdUVjIQ5vfN5SXTxBSDH5Ag/8OSEfPoJBykgGYkNST52HvXT
M6WZqx9JSwA/tQrJpFrpDORgwyVRRgxgR7z7Dx38TViV7HeuqLVEJTtRIk8c6/Z2CYOlmSsUNNLw
q72j2Wv2zXSzWS2aD7cMR5v8jPzatYf4TYVOdxygrGOEBHYoElWk7ixXHyheYEqix5CFBYA7PuQm
CdDquv2oAC7tTM5m/uoS1N4xggI4MIICNAIBATBqMFoxCzAJBgNVBAYTAlNJMRwwGgYDVQQKExNS
ZXB1Ymxpa2EgU2xvdmVuaWphMRcwFQYDVQRhEw5WQVRTSS0xNzY1OTk1NzEUMBIGA1UEAxMLU0lH
RU4tQ0EgRzICDBSL7r4AAAAAVyU92jANBglghkgBZQMEAgEFAKCBoDAYBgkqhkiG9w0BCQMxCwYJ
KoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNTA3MDcwOTIzMzVaMC8GCSqGSIb3DQEJBDEiBCB+
C5wR6WniP459hCkCijAGPXVpKHpRHvuk41kEg3gSPzA1BgkqhkiG9w0BCQ8xKDAmMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDQYJKoZIhvcNAQEBBQAEggEASYDnWCCuzPPt
/SnpTZSOSgOzDJFZREbO6oJOEJSBz71SJQ/9rgYZswh+Jh6Wtd10IDrAbbtSw4Aln6KcdHSH9IQ3
eRt6xAj8hVaecbzA2bjbcoLdVrB5jvhaTZ3Fi6N8BsMdoL42bpucB+cvL6PlwFLdjG3tWIVmg0u+
h00gCaf8HMopr8c3nSThXHX53ucATXELG//0oU4vxFbD7deDHRRRjDJKtuIdH/39bLaGuBWXq7yD
yfdkLR71moxkoNBa4qEsiFVcnNbZNKMriNnjmc79HROsZruOuwxVs5KHEGXlHu7PJ0UZ+fUb7zqV
uXnEcbDNn1Ycj6Ur8bjPftLROQ==


--nextPart3555875.sQuhbGJ8Bu--



