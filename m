Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A604C83038
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Jun 2025 19:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9337D10E23D;
	Mon, 30 Jun 2025 19:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XwLIL+OS";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2396710E23D
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 19:11:33 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-b3510c22173so228611a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Jun 2025 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751310692; x=1751915492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i3qZ5hUXtNbHpxXgBaXen3G1wtCTDe76eEuZkvEVtj0=;
 b=XwLIL+OSkq/5Q138cU60/EIqSWmUpxKsPYaMtGJTRuRnGLhR/VTiQKsCzhurOIUc1N
 0VBC5V/QzoS8EW5vJmk6YWG1P3pSWUjmM12QqXQn1dOjfzzzBbOxaNa0haWNCSDDccLc
 DI+cVg4vVt45CrZX1lx6d9seH+KcBxmVFcUNWppytk7LeQ+TE2yofOvR0V2Ido6vyga4
 N22QJCfP+to5ALQyKgpgLfbZXVDRp02Rl4YLdk8KsAof2XHtUysuOxdr79/YFzm5djeI
 kOUoNqMHu4g8FTZsh5B7N+Yb/MSyCiRaOgQmcamynHAGCUbFhKla4BztKT/W+sfil0iD
 6qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751310692; x=1751915492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i3qZ5hUXtNbHpxXgBaXen3G1wtCTDe76eEuZkvEVtj0=;
 b=m+quTqw+uoUmDrDi41V2VDgash1c8/o2pMNRzQnk3uTARp89t2aohaXEbqLIno2t7n
 s1MjRZNtYoLNg5wPziPM/uYzXCuRn2lfwWHAMNAEzj0nlhiEEpW2HlBt9PAFsnLSaNUV
 PT/KA3Ve7+k5jlDMITkK3sOeym21O9TBl68FxmUAU3WKQCs12NeCuaHqRPMTKgN3klU6
 pdixlHl8iXlXFme5r6w6EY+XKGVJP7wMHV6TJa3ErTXmn3mWP6iXBbvcukuFPK/waJYF
 mvYS0oTVn3VJwLPBS3RPYm264MpVboRi+QQYbMxvrJe2E1te+WbCAJQb2bIWtGYCieut
 w5xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiQeb1Xb9DDqOVY6DBImgxSwed4Hp5zSCVvoKt9BCDCEPJlHl2l91SuDynHjiVyoDiZQJ4vG2a@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwB8Z2cdfc5PvHXeSN2cJhHYq4rroLYBZ3K2zBxMgxibL5Mxsy9
 pTTgiiNWXNmBOlylykhDU7W0tTjn9Jtmu5SthLnW58mUp5GvZ4ordvI/tjRbtDbaWH43Fx8/Acx
 sVpoXZlATfcperxLzj7q16P5lISDw+RY=
X-Gm-Gg: ASbGncuLF4HKOLF1McF+/BuKdxfvsJlCASPbSFgN1h+Cze788whTsJFef7uIhELsKm9
 jYTU2dxsP1ONMWZCFymcpEWzBto61b04JMomAfF4tin/XCF/IpaNQf0I++t7l3L9xh/t8FA9dv0
 08EGzwjhw55Io0+v4RNB0lnINzQDbZXac22+1AHvcWmgOR
X-Google-Smtp-Source: AGHT+IHjWFzP8IGPOZw/rdOxm4rKCvt6HQguTmUCNREjnruXxcWJyea5uyCz+owc3baL8NQh/KTY4YW0MzgS+cSjv78=
X-Received: by 2002:a17:90b:48c6:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-31951a0e74amr186859a91.7.1751310692235; Mon, 30 Jun 2025
 12:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250502205924.935319-1-alexander.deucher@amd.com>
 <aws6c3hsphrcdaap4wmptu6q4psout2pdebzcupy4wtzasvufy@xcizj5e5rkgy>
In-Reply-To: <aws6c3hsphrcdaap4wmptu6q4psout2pdebzcupy4wtzasvufy@xcizj5e5rkgy>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 30 Jun 2025 15:11:19 -0400
X-Gm-Features: Ac12FXx1wxQ7Dggyc-lLUY_0JpFz30E5CZqCjkid6p2wf7as6jB6k-79aZFOdC8
Message-ID: <CADnq5_PvPMtAeE1OPxtbEeuCTzkSrmvbgjwmutsCWN2zbKxQ+g@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add initial documenation for user queues
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

On Tue, May 27, 2025 at 4:46=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> Hi Alex,
>
> Follow some comments and questions.
>
> On 05/02, Alex Deucher wrote:
> > Add an initial documentation page for user mode queues.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  Documentation/gpu/amdgpu/index.rst |   1 +
> >  Documentation/gpu/amdgpu/userq.rst | 196 +++++++++++++++++++++++++++++
> >  2 files changed, 197 insertions(+)
> >  create mode 100644 Documentation/gpu/amdgpu/userq.rst
> >
> > diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amd=
gpu/index.rst
> > index bb2894b5edaf2..45523e9860fc5 100644
> > --- a/Documentation/gpu/amdgpu/index.rst
> > +++ b/Documentation/gpu/amdgpu/index.rst
> > @@ -12,6 +12,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA)=
 architectures.
> >     module-parameters
> >     gc/index
> >     display/index
> > +   userq
> >     flashing
> >     xgmi
> >     ras
> > diff --git a/Documentation/gpu/amdgpu/userq.rst b/Documentation/gpu/amd=
gpu/userq.rst
> > new file mode 100644
> > index 0000000000000..53e6b053f652f
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/userq.rst
> > @@ -0,0 +1,196 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > + User Mode Queues
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Introduction
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Similar to the KFD, GPU engine queues move into userspace.  The idea i=
s to let
> > +user processes manage their submissions to the GPU engines directly, b=
ypassing
> > +IOCTL calls to the driver to submit work.  This reduces overhead and a=
lso allows
> > +the GPU to submit work to itself.  Applications can set up work graphs=
 of jobs
> > +across multiple GPU engines without needing trips through the CPU.
> > +
> > +UMDs directly interface with firmware via per application shared memor=
y areas.
> > +The main vehicle for this is queue.  A queue is a ring buffer with a r=
ead
> > +pointer (rptr) and a write pointer (wptr).  The UMD writes IP specific=
 packets
> > +into the queue and the firmware processes those packets, kicking off w=
ork on the
> > +GPU engines.  The CPU in the application (or another queue or device) =
updates
> > +the wptr to tell the firmware how far into the ring buffer to process =
packets
> > +and the rtpr provides feedback to the UMD on how far the firmware has =
progressed
> > +in executing those packets.  When the wptr and the rptr are equal, the=
 queue is
> > +idle.
> > +
> > +Theory of Operation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The various engines on modern AMD GPUs support multiple queues per eng=
ine with a
> > +scheduling firmware which handles dynamically scheduling user queues o=
n the
> > +available hardware queue slots.  When the number of user queues outnum=
bers the
> > +available hardware queue slots, the scheduling firmware dynamically ma=
ps and
> > +unmaps queues based on priority and time quanta.  The state of each us=
er queue
> > +is managed in the kernel driver in an MQD (Memory Queue Descriptor).  =
This is a
> > +buffer in GPU accessible memory that stores the state of a user queue.=
  The
> > +scheduling firmware uses the MQD to load the queue state into an HQD (=
Hardware
> > +Queue Descriptor) when a user queue is mapped.  Each user queue requir=
es a
> > +number of additional buffers which represent the ring buffer and any m=
etadata
> > +needed by the engine for runtime operation.  On most engines this cons=
ists of
> > +the ring buffer itself, a rptr buffer (where the firmware will shadow =
the rptr
> > +to userspace), a wrptr buffer (where the application will write the wp=
tr for the
> > +firmware to fetch it), and a doorbell.  A doorbell is a piece of the d=
evice's
>
> In this part, you started to explain about the doorbell; consider adding
> a new paragraph here.

Added some additional info here.

>
> Another idea could be to create a dedicated page to explain doorbells
> and move all the general doorbell information from this patch to the new
> page. I think there is no kernel-doc about amdgpu doorbells.
>
> > +MMIO BAR which can be mapped to specific user queues.  Writing to the =
doorbell
> > +wakes the firmware and causes it to fetch the wptr and start processin=
g the
> > +packets in the queue. Each 4K page of the doorbell BAR supports specif=
ic offset
> > +ranges for specific engines.  The doorbell of a queue most be mapped i=
nto the
>
> /most/must/

Fixed.

>
> > +aperture aligned to the IP used by the queue (e.g., GFX, VCN, SDMA, et=
c.).
> > +These doorbell apertures are set up via NBIO registers.  Doorbells are=
 32 bit or
> > +64 bit (depending on the engine) chunks of the doorbell BAR.  A 4K doo=
rbell page
> > +provides 512 64-bit doorbells for up to 512 user queues.  A subset of =
each page
> > +is reserved for each IP type supported on the device.  The user can qu=
ery the
> > +doorbell ranges for each IP via the INFO IOCTL.
>
> The first time that I read this, I was confused about the IOCTL part;
> however, at the end of this patch, I noticed that you explained the
> IOCTL part. Perhaps add a mention in parenthesis so the reader can see
> more details about this info in the "IOCTL Interfaces" section.

Updated.

>
> > +
> > +When an application wants to create a user queue, it allocates the the=
 necessary
> > +buffers for the queue (ring buffer, wptr and rptr, context save areas,=
 etc.).
> > +These can be separate buffers or all part of one larger buffer.  The a=
pplication
> > +would map the buffer(s) into its GPUVM and use the GPU virtual address=
es of for
> > +the areas of memory they want t use for the user queue.  They would al=
so
>
> /t/to/

Fixed.

>
> > +allocate a doorbell page for the doorbells used by the user queues.  T=
he
> > +application would then populate the MQD in the USERQ IOCTL structure w=
ith the
> > +GPU virtual addresses and doorbell index they want to use.  The user c=
an also
> > +specify the attributes for the user queue (priority, whether the queue=
 is secure
> > +for protected content, etc.).  The application would then call the USE=
RQ
> > +create IOCTL to create the queue from using the specified MQD.  The
> > +kernel driver then validates the MQD provided by the application and t=
ranslates
> > +the MQD into the engine specific MQD format for the IP.  The IP specif=
ic MQD
> > +would be allocated and the queue would be added to the run list mainta=
ined by
> > +the scheduling firmware.  Once the queue has been created, the applica=
tion can
> > +write packets directly into the queue, update the wptr, and write to t=
he
> > +doorbell offset to kick off work in the user queue.
> > +
> > +When the application is done with the user queue, it would call the US=
ERQ
> > +FREE IOCTL to destroy it.  The kernel driver would preempt the queue a=
nd
> > +remove it from the scheduling firmware's run list.  Then the IP specif=
ic MQD
> > +would be freed and the user queue state would be cleaned up.
>
> Is it possible to add some pseudo-code that summarizes the programming
> model described here?

I'm not sure I understand what you are asking for here.

>
> > +
> > +Some engines may require the aggregated doorbell to if the engine does=
 not
>
> /to/too/ or /to//?

Fixed.

>
> Do you know which engines requires the aggreted doorbell? Can this
> information be retrieved via IOCTL?  I think this information can be
> helpful for userspace implementation.

No IPs which currently support user queues require the aggregated
doorbell.  VCN likely will be the first IP
that needs it.

>
> > +support doorbells from unmapped queues.  The aggregated doorbell is a =
special
> > +page of doorbell space which wakes the scheduler.  In cases where the =
engine may
> > +be oversubscribed, some queues may not be mapped.  If the doorbell is =
rung when
> > +the queue is not mapped, the engine firmware may miss the request.  So=
me
> > +scheduling firmware may work around this my polling wptr shadows when =
the
> > +hardware is oversubscribed, other engines may support doorbell updates=
 from
> > +unmapped queues.  In the event that one of these options is not availa=
ble, the
> > +kernel driver will map a page of aggregated doorbell space into each G=
PUVM
> > +space.  The UMD will then update the doorbell and wptr as normal and t=
hen write
> > +to the aggregated doorbell as well.
> > +
> > +Special Packets
> > +---------------
> > +
> > +In order to support legacy implicit synchronization, as well as mixed =
user and
> > +kernel queues, we need a synchronization mechanism that is secure.  Be=
cause
> > +kernel queues or memory management tasks depend on kernel fences, we n=
eed a way
> > +for user queues to update memory that the kernel can use for a fence, =
that can't
> > +be messed with by a bad actor.  To support this, we've added protected=
 fence
> > +packet.  This packet works by writing the a monotonically increasing v=
alue to
> > +a memory location that is only the privileged clients have write acces=
s to.
> > +User queues only have read access.  When this packet is executed, the =
memory
> > +location is updated and other queues (kernel or user) can see the resu=
lts.
>
> Does the driver handle this packet? I mean, does the driver insert it
> without the userspace request? What is the packet name? How can I find
> it in the kernel?

The actual packet format varies from IP to IP (GFX/Compute, SDMA, VCN,
etc.), but the behavior is the same.  The packet submission is handled
in userspace.  The kernel driver just sets up the privileged memory
used for each user queue when it sets them up when the application
creates them.

>
> > +
> > +Memory Management
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +It is assumed that all buffers mapped into the GPUVM space for the pro=
cess are
> > +valid when engines on the GPU are running.  The kernel driver will onl=
y allow
> > +user queues to run when all buffers are mapped.  If there is a memory =
event that
> > +requires buffer migration, the kernel driver will preempt the user que=
ues,
> > +migrate buffers to where they need to be, update the GPUVM page tables=
 and
> > +invaldidate the TLB, and then resume the user queues.
> > +
> > +Interaction with Kernel Queues
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Depending on the IP and the scheduling firmware, you can enable kernel=
 queues
> > +and user queues at the same time,  However, you are limited by the HQD=
 slots.
>
> /However/however/

Fixed.

>
> > +Kernel queues are always mapped so any work the goes into kernel queue=
s will
> > +take priority.  This limits the available HQD slots for user queues.
> > +
> > +Not all IPs will support user queues on all GPUs.  As such, UMDs will =
need to
> > +support both user queues and kernel queues depending on the IP.  For e=
xample, a
> > +GPU may support user queues for GFX, compute, and SDMA, but not for VC=
N, JPEG,
> > +and VPE.  UMDs need to support both.  The kernel driver provides a way=
 to
> > +determine if user queues and kernel queues are supported on a per IP b=
asis.
> > +UMDs can query this information via the INFO IOCTL and determine wheth=
er to use
> > +kernel queues or user queues for each IP.
> > +
> > +Queue Resets
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +For most engines, queues can be reset individually.  GFX, compute, and=
 SDMA
> > +queues can be reset individually.  When a hung queue is detected, it c=
an be
> > +reset either via the scheduling firmware or MMIO.  Since there are no =
kernel
> > +fences for most user queues, they will usually only be detected when s=
ome other
> > +event happens; e.g., a memory event which requires migration of buffer=
s.  When
> > +the queues are preempted, if the queue is hung, the preemption will fa=
il.
> > +Driver will them look up the queues that failed to preempt and reset t=
hem and
> > +record which queues are hung.
> > +
> > +
> > +On the UMD side, we will add an USERQ QUERY_STATUS IOCTL to query the =
queue
> > +status.  UMD will provide the queue id in the IOCTL and the kernel dri=
ver
> > +will check if it has already recorded the queue as hung (e.g., due to =
failed
> > +peemption) and report back the status.
> > +
> > +IOCTL Interfaces
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +GPU virtual addresses used for queues and related data (rptrs, wptrs, =
context
> > +save areas, etc.) should be validated by the kernel mode driver to pre=
vent the
> > +user from specifying invalid GPU virtual addresses.  If the user provi=
des
> > +invalid GPU virtual addresses or doorbell indicies, the IOCTL should r=
eturn an
> > +error message.  These buffers should also be tracked in the kernel dri=
ver so
> > +that if the user attempts to unmap the buffer(s) from the GPUVM, the u=
map call
> > +would return an error.
> > +
> > +INFO
> > +----
> > +There are several new INFO queries related to user queues in order to =
query the
> > +size of user queue meta data needed for a user queue (e.g., context sa=
ve areas
> > +or shadow buffers), and whether kernel or user queues or both are supp=
orted
> > +for each IP type.
> > +
> > +USERQ
> > +-----
> > +The USERQ IOCTL is used for creating, freeing, and querying the status=
 of user
> > +queues.  It supports 3 opcodes:
> > +
> > +1. CREATE - Create a user queue.  The application provides a MQD-like =
structure
> > +   that devices the type of queue and associated metadata and flags fo=
r that
> > +   queue type.  Returns the queue id.
> > +2. FREE - Free a user queue.
> > +3. QUERY_STATRUS - Query that status of a queue.  Used to check if the=
 queue is
>
> /QUERY_STATRUS/QUERY_STATUS/?

Fixed.

Thanks,

Alex

>
> Thanks
> Siqueira
>
> > +   healthy or not.  E.g., if the queue has been reset. (WIP)
> > +
> > +USERQ_SIGNAL
> > +------------
> > +The USERQ_SIGNAL IOCTL is used to provide a list of sync objects to be=
 signaled.
> > +
> > +USERQ_WAIT
> > +----------
> > +The USERQ_WAIT IOCTL is used to provide a list of sync object to be wa=
ited on.
> > +
> > +Kernel and User Queues
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +In order to properly validate and test performance, we have a driver o=
ption to
> > +select what type of queues are enabled (kernel queues, user queues or =
both).
> > +The user_queue driver parameter allows you to enable kernel queues onl=
y (0),
> > +user queues and kernel queues (1), and user queues only (2).  Enabling=
 user
> > +queues only will free up static queue assignments that would otherwise=
 be used
> > +by kernel queues for use by the scheduling firmware.  Some kernel queu=
es are
> > +required for kernel driver operation and they will always be created. =
 When the
> > +kernel queues are not enabled, they are not registered with the drm sc=
heduler
> > +and the CS IOCTL will reject any incoming command submissions which ta=
rget those
> > +queue types.  Kernel queues only mirrors the behavior on all existing =
GPUs.
> > +Enabling both queues allows for backwards compatibility with old users=
pace while
> > +still supporting user queues.
> > --
> > 2.49.0
> >
>
> --
> Rodrigo Siqueira
