Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C1FC54F30
	for <amd-gfx@archiver.kernel.org>; Tue, 27 May 2025 14:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8240D10E41F;
	Tue, 27 May 2025 14:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OqrSyU1n";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504D410E11B
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 14:45:35 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-30f1bde0399so521346a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 07:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748357135; x=1748961935; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ip+e/SJd/yvpPjmtsH8M07sEyHpD5ah3KUF6Fkw8JU=;
 b=OqrSyU1nSZi1ckcBeplOYOHAF6EXxwb6Sy//TKPQ9I/6HejSxUvTbT0bnFNkXkDbiK
 XGKgqVuncfjr3dlhMg++mt/gg1o0yXsIQQFdZ4Rt10wW7o82a3dzFAzHFaanQxgKzjcr
 OWRTXPHNnFFwJnTBdKfkqe3eDygKEnua7lexOSBGTSf4srFgdnIeDdMxNS8BArGrETG/
 YOAksdqlpmy9+F6yZUwPKv3fgfGQPlTFKEiRJ0sRqgjowlGFizU5d9Y7RMqOfapYoBCq
 Hn0kKeHmSQvgO7B6S6Z+T1onn1Fotc6c08GRg/f8RXgMjK4mYbrpMvHvn3B2ZkoVqOzQ
 cIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748357135; x=1748961935;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ip+e/SJd/yvpPjmtsH8M07sEyHpD5ah3KUF6Fkw8JU=;
 b=LFHopdLoOo3dGCQASxuoN7CyEpMLPkbfa1kA6GC9zRBEqXR5lflGjm3xX8QxvM2A/S
 3xBMa8eMJIJ8QNcWBP3tIQbhaZGJrqkJ519dAJ36VTu8qFnDVZWg2PSTSsTUjjl9MM08
 jbiyIhc4pjo4jpZq4C1y8cMGn4SFrHSbMKAYY3BUMZFqkQj/ufeASlMRGIAEiSVqm0mj
 y0fZ9TynqTRc9WDJDUQO5EmvocGcZLAOC3w9BfDAk9z03uOLAdIT8CXfS+xCVtn1eCk9
 CefGpmqZ+rM3dsEXRCJgc6b6bFq72li7OidFCNpPUEUFLY3xHJby/7NmIni4j+eb44LA
 8XAA==
X-Gm-Message-State: AOJu0YzUJrzKnAO3CXntWv+RSYUpUxT5RSi2pm5wv6kEtk4wQqXbqTuA
 xIOwm9eTIvrRpyPE2XWNP3GLRGtYtgu8pY+Ocd+/r0BXF2XdTZri2odi+4HWw9j+eYOKMesOjnn
 0eww3HiVUZq1ddNq5ShuP8FQRQjROV9CRcg==
X-Gm-Gg: ASbGncs2GcYAzyeK6g2eF/caPTG0izndCsG7TZ6ZDmjn+YqjtXMoZOcmFRIHXo8sc83
 WNHqeq+284nanObP7WqsfVv4uFSzrOyYRGeRrfbZpWHlim/Au7bDEktMOZW1nl+6IivT7AIPm+0
 zk4YdXRRZaInQFlDwWTlmP3FUkocAzdoVrTw==
X-Google-Smtp-Source: AGHT+IEJy5v8ZC8LLVO9rJrFPmSyQDXAzmYqeU8VzMXQQYmUAEATilLkKyHMWLtdFeaAfRWpiIGf4DsVnu95nbFARLw=
X-Received: by 2002:a17:90b:2250:b0:310:cfd2:bad5 with SMTP id
 98e67ed59e1d1-3110efe16b1mr7869856a91.0.1748357134413; Tue, 27 May 2025
 07:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250502205924.935319-1-alexander.deucher@amd.com>
In-Reply-To: <20250502205924.935319-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 May 2025 10:45:23 -0400
X-Gm-Features: AX0GCFuoANWCxwsTbACwHGZ9M5JMgdS-AJOr6mYg9vpHLL9cg3l17JJEzVRhD-o
Message-ID: <CADnq5_NndZ00kcOPWHEKSmy9Wy0NP9NErqD47d+pmMY3KhZ=CQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add initial documenation for user queues
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

Alex

On Fri, May 2, 2025 at 5:00=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> Add an initial documentation page for user mode queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  Documentation/gpu/amdgpu/index.rst |   1 +
>  Documentation/gpu/amdgpu/userq.rst | 196 +++++++++++++++++++++++++++++
>  2 files changed, 197 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/userq.rst
>
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgp=
u/index.rst
> index bb2894b5edaf2..45523e9860fc5 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -12,6 +12,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) a=
rchitectures.
>     module-parameters
>     gc/index
>     display/index
> +   userq
>     flashing
>     xgmi
>     ras
> diff --git a/Documentation/gpu/amdgpu/userq.rst b/Documentation/gpu/amdgp=
u/userq.rst
> new file mode 100644
> index 0000000000000..53e6b053f652f
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/userq.rst
> @@ -0,0 +1,196 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + User Mode Queues
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Similar to the KFD, GPU engine queues move into userspace.  The idea is =
to let
> +user processes manage their submissions to the GPU engines directly, byp=
assing
> +IOCTL calls to the driver to submit work.  This reduces overhead and als=
o allows
> +the GPU to submit work to itself.  Applications can set up work graphs o=
f jobs
> +across multiple GPU engines without needing trips through the CPU.
> +
> +UMDs directly interface with firmware via per application shared memory =
areas.
> +The main vehicle for this is queue.  A queue is a ring buffer with a rea=
d
> +pointer (rptr) and a write pointer (wptr).  The UMD writes IP specific p=
ackets
> +into the queue and the firmware processes those packets, kicking off wor=
k on the
> +GPU engines.  The CPU in the application (or another queue or device) up=
dates
> +the wptr to tell the firmware how far into the ring buffer to process pa=
ckets
> +and the rtpr provides feedback to the UMD on how far the firmware has pr=
ogressed
> +in executing those packets.  When the wptr and the rptr are equal, the q=
ueue is
> +idle.
> +
> +Theory of Operation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The various engines on modern AMD GPUs support multiple queues per engin=
e with a
> +scheduling firmware which handles dynamically scheduling user queues on =
the
> +available hardware queue slots.  When the number of user queues outnumbe=
rs the
> +available hardware queue slots, the scheduling firmware dynamically maps=
 and
> +unmaps queues based on priority and time quanta.  The state of each user=
 queue
> +is managed in the kernel driver in an MQD (Memory Queue Descriptor).  Th=
is is a
> +buffer in GPU accessible memory that stores the state of a user queue.  =
The
> +scheduling firmware uses the MQD to load the queue state into an HQD (Ha=
rdware
> +Queue Descriptor) when a user queue is mapped.  Each user queue requires=
 a
> +number of additional buffers which represent the ring buffer and any met=
adata
> +needed by the engine for runtime operation.  On most engines this consis=
ts of
> +the ring buffer itself, a rptr buffer (where the firmware will shadow th=
e rptr
> +to userspace), a wrptr buffer (where the application will write the wptr=
 for the
> +firmware to fetch it), and a doorbell.  A doorbell is a piece of the dev=
ice's
> +MMIO BAR which can be mapped to specific user queues.  Writing to the do=
orbell
> +wakes the firmware and causes it to fetch the wptr and start processing =
the
> +packets in the queue. Each 4K page of the doorbell BAR supports specific=
 offset
> +ranges for specific engines.  The doorbell of a queue most be mapped int=
o the
> +aperture aligned to the IP used by the queue (e.g., GFX, VCN, SDMA, etc.=
).
> +These doorbell apertures are set up via NBIO registers.  Doorbells are 3=
2 bit or
> +64 bit (depending on the engine) chunks of the doorbell BAR.  A 4K doorb=
ell page
> +provides 512 64-bit doorbells for up to 512 user queues.  A subset of ea=
ch page
> +is reserved for each IP type supported on the device.  The user can quer=
y the
> +doorbell ranges for each IP via the INFO IOCTL.
> +
> +When an application wants to create a user queue, it allocates the the n=
ecessary
> +buffers for the queue (ring buffer, wptr and rptr, context save areas, e=
tc.).
> +These can be separate buffers or all part of one larger buffer.  The app=
lication
> +would map the buffer(s) into its GPUVM and use the GPU virtual addresses=
 of for
> +the areas of memory they want t use for the user queue.  They would also
> +allocate a doorbell page for the doorbells used by the user queues.  The
> +application would then populate the MQD in the USERQ IOCTL structure wit=
h the
> +GPU virtual addresses and doorbell index they want to use.  The user can=
 also
> +specify the attributes for the user queue (priority, whether the queue i=
s secure
> +for protected content, etc.).  The application would then call the USERQ
> +create IOCTL to create the queue from using the specified MQD.  The
> +kernel driver then validates the MQD provided by the application and tra=
nslates
> +the MQD into the engine specific MQD format for the IP.  The IP specific=
 MQD
> +would be allocated and the queue would be added to the run list maintain=
ed by
> +the scheduling firmware.  Once the queue has been created, the applicati=
on can
> +write packets directly into the queue, update the wptr, and write to the
> +doorbell offset to kick off work in the user queue.
> +
> +When the application is done with the user queue, it would call the USER=
Q
> +FREE IOCTL to destroy it.  The kernel driver would preempt the queue and
> +remove it from the scheduling firmware's run list.  Then the IP specific=
 MQD
> +would be freed and the user queue state would be cleaned up.
> +
> +Some engines may require the aggregated doorbell to if the engine does n=
ot
> +support doorbells from unmapped queues.  The aggregated doorbell is a sp=
ecial
> +page of doorbell space which wakes the scheduler.  In cases where the en=
gine may
> +be oversubscribed, some queues may not be mapped.  If the doorbell is ru=
ng when
> +the queue is not mapped, the engine firmware may miss the request.  Some
> +scheduling firmware may work around this my polling wptr shadows when th=
e
> +hardware is oversubscribed, other engines may support doorbell updates f=
rom
> +unmapped queues.  In the event that one of these options is not availabl=
e, the
> +kernel driver will map a page of aggregated doorbell space into each GPU=
VM
> +space.  The UMD will then update the doorbell and wptr as normal and the=
n write
> +to the aggregated doorbell as well.
> +
> +Special Packets
> +---------------
> +
> +In order to support legacy implicit synchronization, as well as mixed us=
er and
> +kernel queues, we need a synchronization mechanism that is secure.  Beca=
use
> +kernel queues or memory management tasks depend on kernel fences, we nee=
d a way
> +for user queues to update memory that the kernel can use for a fence, th=
at can't
> +be messed with by a bad actor.  To support this, we've added protected f=
ence
> +packet.  This packet works by writing the a monotonically increasing val=
ue to
> +a memory location that is only the privileged clients have write access =
to.
> +User queues only have read access.  When this packet is executed, the me=
mory
> +location is updated and other queues (kernel or user) can see the result=
s.
> +
> +Memory Management
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +It is assumed that all buffers mapped into the GPUVM space for the proce=
ss are
> +valid when engines on the GPU are running.  The kernel driver will only =
allow
> +user queues to run when all buffers are mapped.  If there is a memory ev=
ent that
> +requires buffer migration, the kernel driver will preempt the user queue=
s,
> +migrate buffers to where they need to be, update the GPUVM page tables a=
nd
> +invaldidate the TLB, and then resume the user queues.
> +
> +Interaction with Kernel Queues
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +Depending on the IP and the scheduling firmware, you can enable kernel q=
ueues
> +and user queues at the same time,  However, you are limited by the HQD s=
lots.
> +Kernel queues are always mapped so any work the goes into kernel queues =
will
> +take priority.  This limits the available HQD slots for user queues.
> +
> +Not all IPs will support user queues on all GPUs.  As such, UMDs will ne=
ed to
> +support both user queues and kernel queues depending on the IP.  For exa=
mple, a
> +GPU may support user queues for GFX, compute, and SDMA, but not for VCN,=
 JPEG,
> +and VPE.  UMDs need to support both.  The kernel driver provides a way t=
o
> +determine if user queues and kernel queues are supported on a per IP bas=
is.
> +UMDs can query this information via the INFO IOCTL and determine whether=
 to use
> +kernel queues or user queues for each IP.
> +
> +Queue Resets
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +For most engines, queues can be reset individually.  GFX, compute, and S=
DMA
> +queues can be reset individually.  When a hung queue is detected, it can=
 be
> +reset either via the scheduling firmware or MMIO.  Since there are no ke=
rnel
> +fences for most user queues, they will usually only be detected when som=
e other
> +event happens; e.g., a memory event which requires migration of buffers.=
  When
> +the queues are preempted, if the queue is hung, the preemption will fail=
.
> +Driver will them look up the queues that failed to preempt and reset the=
m and
> +record which queues are hung.
> +
> +
> +On the UMD side, we will add an USERQ QUERY_STATUS IOCTL to query the qu=
eue
> +status.  UMD will provide the queue id in the IOCTL and the kernel drive=
r
> +will check if it has already recorded the queue as hung (e.g., due to fa=
iled
> +peemption) and report back the status.
> +
> +IOCTL Interfaces
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +GPU virtual addresses used for queues and related data (rptrs, wptrs, co=
ntext
> +save areas, etc.) should be validated by the kernel mode driver to preve=
nt the
> +user from specifying invalid GPU virtual addresses.  If the user provide=
s
> +invalid GPU virtual addresses or doorbell indicies, the IOCTL should ret=
urn an
> +error message.  These buffers should also be tracked in the kernel drive=
r so
> +that if the user attempts to unmap the buffer(s) from the GPUVM, the uma=
p call
> +would return an error.
> +
> +INFO
> +----
> +There are several new INFO queries related to user queues in order to qu=
ery the
> +size of user queue meta data needed for a user queue (e.g., context save=
 areas
> +or shadow buffers), and whether kernel or user queues or both are suppor=
ted
> +for each IP type.
> +
> +USERQ
> +-----
> +The USERQ IOCTL is used for creating, freeing, and querying the status o=
f user
> +queues.  It supports 3 opcodes:
> +
> +1. CREATE - Create a user queue.  The application provides a MQD-like st=
ructure
> +   that devices the type of queue and associated metadata and flags for =
that
> +   queue type.  Returns the queue id.
> +2. FREE - Free a user queue.
> +3. QUERY_STATRUS - Query that status of a queue.  Used to check if the q=
ueue is
> +   healthy or not.  E.g., if the queue has been reset. (WIP)
> +
> +USERQ_SIGNAL
> +------------
> +The USERQ_SIGNAL IOCTL is used to provide a list of sync objects to be s=
ignaled.
> +
> +USERQ_WAIT
> +----------
> +The USERQ_WAIT IOCTL is used to provide a list of sync object to be wait=
ed on.
> +
> +Kernel and User Queues
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In order to properly validate and test performance, we have a driver opt=
ion to
> +select what type of queues are enabled (kernel queues, user queues or bo=
th).
> +The user_queue driver parameter allows you to enable kernel queues only =
(0),
> +user queues and kernel queues (1), and user queues only (2).  Enabling u=
ser
> +queues only will free up static queue assignments that would otherwise b=
e used
> +by kernel queues for use by the scheduling firmware.  Some kernel queues=
 are
> +required for kernel driver operation and they will always be created.  W=
hen the
> +kernel queues are not enabled, they are not registered with the drm sche=
duler
> +and the CS IOCTL will reject any incoming command submissions which targ=
et those
> +queue types.  Kernel queues only mirrors the behavior on all existing GP=
Us.
> +Enabling both queues allows for backwards compatibility with old userspa=
ce while
> +still supporting user queues.
> --
> 2.49.0
>
