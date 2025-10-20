Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C501CCD1A2
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 20:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C9B10E50D;
	Mon, 20 Oct 2025 20:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FNyVp+BI";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23A610E50D
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 20:53:45 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-290aaff26c1so12266395ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 13:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760993625; x=1761598425; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AYga6IdOpOhY+zhkZuUxhXEH8nGN5mpgbUppJlZZu7w=;
 b=FNyVp+BIGfSZHzXChAhNFQXT7BKXRCPrl5uic6cbOoSvqp4IFRK+ZaM214Y5IYQQhV
 XT4UaJoQrNsOeNag+hBClYQiIBpT4bLEq7WjVdzC40fthdCUq/35/D0gIC7NbqSM+7CU
 Z3ng3GK0TX7HG4pkAbuEB5T5IY+6HXjz8qXitVplmEyn28HUnZvC5JRz8UJnXo6aeNbF
 OXMfHMyTcSeYjASB01yUjoDQ4tfUNUi0jFqnqbWynRPF9y1hb3m7iPyrJtVmm+ZILC0h
 8tO6/pOB6w+jo+v7MxIlUdGzF18EOfDdUTHNHrh899FutHsH+/RQYWt4viTbs7TUeSm8
 dTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760993625; x=1761598425;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AYga6IdOpOhY+zhkZuUxhXEH8nGN5mpgbUppJlZZu7w=;
 b=wS0YRxCyJjY0zlQI5DxW6GhIYV1PF6lvc/B4rOUQeeHzP+wfWaIF/ao2XROstqJgPM
 ydxuMdzyAWGCp4g/cmclmnqBo/JIinCqwx7fV1O433GTsJN+vtfC+vYeLu1BaHDFlJ8Y
 i69f6hRONPm8we9xsbDdGjU90Yawe+bBqgUzir+KZ5ZOsp+i7MShh2o6XmRwmCzE4Dqx
 ZUDGgA7xcoaS7kD1QkWf605uocqaMnGCGYp9Ddi0tMz9SdZpa1eHLCAyXWzvwbPqT9IG
 5U0ysXk5rRtetGjmFMQyoDAN0p7tHRy9Fsa4NQSrE1gPbs9L3gJxzvqY+jhYtU260REX
 s5qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjkOKncNPOvimobfu1EudJo92Ph/GzLSHvk4fsL1OCxzDMIK4w+Qg0jksHN/6V1bTdDEq1gvJ3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdTfJ+i18sBBku+uEGnio3OazhRs+4y2VYFBD0G8/fJ55TW0jd
 GUiADk+VOY98GJdfxAy3Gn9la67qKYxxPfQp+0wXucvCa7dyoiyOS8GZCS0BKdt73WzJ46eRPix
 a9admQT1N3DiyDIAINs5H/MrAhnXlJxg=
X-Gm-Gg: ASbGncsvsg0n/gsWa4lWZVa2and9XOOhvNKA0pGGL59iunoXiE8xhYlzkeDnzQJwGJf
 RuYR7LNuTPdHCm/qNZLcNwxe4FBclrRgosJHqpNeFDdthcYX+z1ZEf8J63GSF2JD+F8B3M/piUG
 Ph87BqTgOsiYPU1UCp9XLRawWphDVrrl4zpmqZn5C0EtNlQRRzPzcIUbebXwTbaHlq/9iUeQLtr
 T55cnG4XPVKlfDY9UJtS7PKUj89csV7IEJtcMAMmNrRdWoewXCW4G/sgxkb
X-Google-Smtp-Source: AGHT+IE8VoCDpj2WU1PkxOWFvf9fvsiIscumwGm3OBF8xf4z0J78tQuNKC2Eg2OHEe3oiqkLlRm9ghFLxtNjZOVEUjg=
X-Received: by 2002:a17:903:907:b0:26c:3c15:f780 with SMTP id
 d9443c01a7336-292d3fcc93amr5351905ad.8.1760993624953; Mon, 20 Oct 2025
 13:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20251020194631.102260-1-siqueira@igalia.com>
 <20251020194631.102260-6-siqueira@igalia.com>
In-Reply-To: <20251020194631.102260-6-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 20 Oct 2025 16:53:33 -0400
X-Gm-Features: AS18NWAGt6gN0Fxu3ftWeXg_cfrOVsTr3xD3jDom0qnqcc-qRQT9sfcRuuZ2tMM
Message-ID: <CADnq5_PnkLU4-wR+6_G_+f-nRiYF8Z3GvBj0jA-TvbZUO08zhw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] Documentation/gpu: Add documentation about ring
 buffer
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Mon, Oct 20, 2025 at 3:47=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> AMDGPU heavily relies on ring buffers to manage its components; as a
> result, it has an elaborate mechanism of operation with multiple details
> around it. This commit introduces new documentation on ring buffers,
> detailing their management and expanding the explanation of Enforce
> isolation. Finally, this commit also adds the documentation available in
> the amdgpu_ring.c file to it.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  .../gpu/amdgpu/enforce_isolation.svg          |  654 +++++++
>  Documentation/gpu/amdgpu/gfx_pipeline_seq.svg |  413 +++++
>  Documentation/gpu/amdgpu/index.rst            |    1 +
>  .../gpu/amdgpu/no_enforce_isolation.svg       |  707 +++++++
>  Documentation/gpu/amdgpu/ring-buffer.rst      |   91 +
>  Documentation/gpu/amdgpu/ring_buffers.svg     | 1633 +++++++++++++++++
>  Documentation/gpu/amdgpu/userq.rst            |    2 +
>  7 files changed, 3501 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/enforce_isolation.svg
>  create mode 100644 Documentation/gpu/amdgpu/gfx_pipeline_seq.svg
>  create mode 100644 Documentation/gpu/amdgpu/no_enforce_isolation.svg
>  create mode 100644 Documentation/gpu/amdgpu/ring-buffer.rst
>  create mode 100644 Documentation/gpu/amdgpu/ring_buffers.svg

Got a link to the images?

<snip>

> diff --git a/Documentation/gpu/amdgpu/ring-buffer.rst b/Documentation/gpu=
/amdgpu/ring-buffer.rst
> new file mode 100644
> index 000000000000..015d803541fe
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/ring-buffer.rst
> @@ -0,0 +1,91 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + Ring Buffer
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To handle communication between user space and kernel space, amdgpu adop=
ts a
> +strategy based on a ring buffer, which is used by GFX, Compute, SDMA, UV=
D, VCE,
> +VCN, VPE, KIQ, MES, UMSCH, and CPER.

To handle communication between user space and kernel space, AMD GPUs
use a ring buffer design to feed the engines (GFX, Compute, SDMA, UVD,
VCE, VCN, VPE, etc.).

> See the figure below that illustrates how
> +this communication works:
> +
> +.. kernel-figure:: ring_buffers.svg
> +
> +Ring buffers in the amdgpu work as a producer-consumer problem, where us=
erspace

Ring buffers in the amdgpu work as a producer-consumer model, where softwar=
e

> +acts as the producer, constantly filling the ring buffer with GPU comman=
ds to
> +be executed. Meanwhile, the GPU retrieves the information from the ring,=
 parses
> +it, and distributes the specific set of instructions between the differe=
nt
> +amdgpu blocks.

> Notice from the diagram that the ring has a Read Pointer (rptr)
> +that indicates where the GPU is currently reading, and there is a Write =
Pointer
> +(wptr) that indicates where the host has written the message. Note that =
every
> +time something is written to the ring, the wptr is incremented. Meanwhil=
e, the
> +GPU constantly updates the rptr pointer, chasing the wptr until both poi=
nters
> +are equal. The User space or the driver can utilize the rptr pointer to =
roughly
> +estimate how many instructions are still pending completion.

The ring has a Read Pointer (rptr), which indicates where the engine
is currently reading packets from the ring, and a Write Pointer which
indicates how many packets software has added to the ring.  When the
rptr and wptr are equal, the ring is idle.  When software adds packets
to the ring, it updates the wptr, this causes the engine to start
fetching and processing packets.  As the engine processes packets, the
rptr gets updates until the rptr catches up to the wptr and they are
equal again.

> +
> +Usually, ring buffers in the driver have a limited size (search for occu=
rrences
> +of `amdgpu_ring_init()`). One of the reasons for the small ring buffer s=
ize is
> +that CP (Command Processor) is capable of following addresses inserted i=
nto the
> +ring; this is illustrated in the image by the reference to the IB (Indir=
ect
> +Buffer). The IB gives userspace the possibility to have an area in memor=
y that
> +CP can read and feed the hardware with extra instructions.
> +
> +All ASICs pre-GFX11 use what is called a kernel queue, which means
> +the ring is allocated in kernel space and has some restrictions, such as=
 not
> +being able to be :ref:`preempted directly by the scheduler<amdgpu-mes>`.=
 GFX11
> +and newer support kernel queues, but also provide a new mechanism named
> +:ref:`user queues<amdgpu-userq>`, where the queue is moved to the user s=
pace
> +and can be mapped and unmapped via the scheduler. In practice, both queu=
es
> +insert user-space-generated GPU commands from different jobs into the re=
quested
> +component ring.
> +
> +Enforce Isolation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +

Might want to cross link to the other process isolation documentation
at Documentation/gpu/amdgpu/process-isolation.rst

> +Before examining the Enforce Isolation mechanism in the ring buffer cont=
ext, it
> +is helpful to briefly discuss how instructions from the ring buffer are
> +processed in the graphics pipeline. Let=E2=80=99s expand on this topic b=
y checking the
> +diagram below that illustrates the graphics pipeline:
> +
> +.. kernel-figure:: gfx_pipeline_seq.svg
> +
> +In terms of executing instructions, the GFX pipeline follows the sequenc=
e:
> +Shader Export (SX), Geometry Engine (GE), Shader Process or Input (SPI),=
 Scan
> +Converter (SC), Primitive Assembler (PA), and cache manipulation (which =
may
> +vary across ASICs). Another common way to describe the pipeline is to us=
e Pixel
> +Shader (PS), raster, and Vertex Shader (VS) to symbolize the two shader =
stages.
> +Now, with this pipeline in mind, let's assume that Job B causes a hang i=
ssue,
> +but Job C's instruction might already be executing, leading developers t=
o
> +incorrectly identify Job C as the problematic one. This problem can be
> +mitigated on multiple levels; the diagram below illustrates how to minim=
ize
> +part of this problem:
> +
> +.. kernel-figure:: no_enforce_isolation.svg
> +
> +Note from the diagram that there is no guarantee of order or a clear sep=
aration
> +between instructions, which is not a problem most of the time, and is al=
so good
> +for performance. Furthermore, notice some circles between jobs in the di=
agram
> +that represent a **fence wait** used to avoid overlapping work in the ri=
ng. At
> +the end of the fence, a cache flush occurs, ensuring that when the next =
job
> +starts, it begins in a clean state and, if issues arise, the developer c=
an
> +pinpoint the problematic process more precisely.
> +
> +To increase the level of isolation between jobs, there is the "Enforce
> +Isolation" method described in the picture below:
> +
> +.. kernel-figure:: enforce_isolation.svg
> +
> +As shown in the diagram, enforcing isolation introduces ordering between
> +submissions, since the access to GFX/Compute/Other is serialized.   Noti=
ce that

enforce isolation only affects GFX and compute.  It's probably easier
to think about it as single process at a time mode for gfx/compute.

Alex

> +this approach has a significant performance impact, as it allows only on=
e job
> +to submit commands at a time. However, this option can help pinpoint the=
 job
> +that caused the problem. Although enforcing isolation improves the situa=
tion,
> +it does not fully resolve the issue of precisely pinpointing bad jobs, s=
ince
> +isolation might mask the problem. In summary, identifying which job caus=
ed the
> +issue may not be precise, but enforcing isolation might help with the
> +debugging.
> +
> +Ring Operations
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +   :internal:
> +
