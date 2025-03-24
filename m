Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4616BC36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 19:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B4210E4D3;
	Mon, 24 Mar 2025 19:57:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SX+uzygD";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A22510E4D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 19:57:09 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3032a9c7cfeso849347a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 12:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742846229; x=1743451029; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MBfeL2W1ZkYlc+c0zilJUfvDYil2knEM+fK+3cDWJgc=;
 b=SX+uzygDD3p+YHzJLEIZ9ON+0BNtD9JQN0//wYlqROYYd5eVisxBVQMYsRhPkNF/ny
 nns90omcdCpCPpZ/nNVq3Sxx1LB4AUu2g57OjlUVIYIhsH/8/ZdMOZUwMFXIKxLJ6ZyR
 zEn1hqE1bPImU72g5Pteof4hhUMh5w3wIurr4rutAzm+CM35SBKD0u91PJCHBDgOHqZd
 mXdaMEr9B/fv4Y6w3JLDezCHjXZXr9EvpLXbNlkL/LJp/YvTgVt/RZ110WPRrCExDsJJ
 rT0rJp1C4t4Ct8vVQ9p69a+9WDkBDG7fuGlHmE3MWhlRBqHMkx/cqsJ94Cqt2eBFgrKa
 ZEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742846229; x=1743451029;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MBfeL2W1ZkYlc+c0zilJUfvDYil2knEM+fK+3cDWJgc=;
 b=ni83EOblhxtYzWj7G0nYjzzVc4tOZrQrbQEh9ewBSp8qVHFopprmzR8VhaRg0u989e
 d/rT1p/8ojD2ZgDcv59SsZBlgQJBgMt6ACORn3wlE3naefO4wQlRPNLJ8Yk2QFjBsz43
 mwo+YI8kd28Pn2otiqsRuQW1hGFyNaaC9HFkH34q8kbE0zE46rF5uER/qwjM6Y7sqfgE
 TOYEdeLJ7vKExmm88EsCBkw+118HKPRYFZVLxaEaoq/RTaE3ymCb25cZvhlGyX2iFyVQ
 /NEPV2C6vg3poLchzSAShFZmhuw0RrW4alblq6tU9POI29I6fj4cVe69A/c7BjI3D9wV
 71ww==
X-Gm-Message-State: AOJu0YxLfvZCIWaI5CW/SKL59tWso/ZSZ7YD8ZF/ygd4CK6Wsm3B4T8o
 9yY1l+eHz0TzswBj/zG2TKL8cFxWw8xTpYfNlwMG1jB5+Bfxl5qlqdZ6ovWd7elFL8q/KZk+o/7
 aisbXfNbAUx+KFX9Hj9KXkfo/6aGcIg==
X-Gm-Gg: ASbGnculzmObGMMungGo4wE2nyKvTmh1/3z3x4pPTvXScy6Ir1tYGNOooWgbOmZ9HzA
 N4pFyzhA/nTfiFtN2eIoQPVvyQPJ723rpB8SAi4jzKS/bCpcN63nTnuD1Q1DJ9feUhudUgRqsVC
 U0ZXDQua5gpNf9BWaiNKng6oUpFQ==
X-Google-Smtp-Source: AGHT+IG5Tbm0w+Al2Nm24Rg3kf5fUq/1bV0iMZFvdmJrMob/sp1mCDGmDL2I8Kex/12mrGCRyT36uwfJT0s5XqaoCwM=
X-Received: by 2002:a17:90b:3a8d:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-3036b4abf73mr154426a91.5.1742846228872; Mon, 24 Mar 2025
 12:57:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250306155341.1770809-1-alexander.deucher@amd.com>
 <CADnq5_MWVcsY99bBOgLk9rtcV042AE+BvuiZ6mmm83OJzYsB8w@mail.gmail.com>
In-Reply-To: <CADnq5_MWVcsY99bBOgLk9rtcV042AE+BvuiZ6mmm83OJzYsB8w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 15:56:57 -0400
X-Gm-Features: AQ5f1JrcqO3r49IrF1PJcToUp6HHiB8-EJlmrHpBT2ocI3KIZv2Mgn96bkuuB4U
Message-ID: <CADnq5_O7mXWTMVpePYvjS=zugH3nY-fjMdbXwtC0-W4Bop-ENQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add initial documentation for debugfs files
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

On Tue, Mar 18, 2025 at 9:16=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Ping?
>
> On Thu, Mar 6, 2025 at 10:54=E2=80=AFAM Alex Deucher <alexander.deucher@a=
md.com> wrote:
> >
> > Describes what debugfs files are available and what
> > they are used for.
> >
> > v2: fix some typos (Mark Glines)
> > v3: Address comments from Siqueira and Kent
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  Documentation/gpu/amdgpu/debugfs.rst   | 210 +++++++++++++++++++++++++
> >  Documentation/gpu/amdgpu/debugging.rst |   7 +
> >  Documentation/gpu/amdgpu/index.rst     |   1 +
> >  3 files changed, 218 insertions(+)
> >  create mode 100644 Documentation/gpu/amdgpu/debugfs.rst
> >
> > diff --git a/Documentation/gpu/amdgpu/debugfs.rst b/Documentation/gpu/a=
mdgpu/debugfs.rst
> > new file mode 100644
> > index 0000000000000..fdfc1a8773c72
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/debugfs.rst
> > @@ -0,0 +1,210 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +AMDGPU DebugFS
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The amdgpu driver provides a number of debugfs files to aid in debuggi=
ng
> > +issues in the driver.  Thse are usually found in
> > +/sys/kernel/debug/dri/<num>.
> > +
> > +DebugFS Files
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +amdgpu_benchmark
> > +----------------
> > +
> > +Run benchmarks using the DMA engine the driver uses for GPU memory pag=
ing.
> > +Write a number to the file to run the test.  The results are written t=
o the
> > +kernel log.  VRAM is on device memory (dGPUs) or cave out (APUs) and G=
TT
> > +(Graphics Translation Tables) is system memory that is accessible by t=
he GPU.
> > +The following tests are available:
> > +
> > +- 1: simple test, VRAM to GTT and GTT to VRAM
> > +- 2: simple test, VRAM to VRAM
> > +- 3: GTT to VRAM, buffer size sweep, powers of 2
> > +- 4: VRAM to GTT, buffer size sweep, powers of 2
> > +- 5: VRAM to VRAM, buffer size sweep, powers of 2
> > +- 6: GTT to VRAM, buffer size sweep, common display sizes
> > +- 7: VRAM to GTT, buffer size sweep, common display sizes
> > +- 8: VRAM to VRAM, buffer size sweep, common display sizes
> > +
> > +amdgpu_test_ib
> > +--------------
> > +
> > +Read this file to run simple IB (Indirect Buffer) tests on all kernel =
managed
> > +rings.  IBs are command buffers usually generated by userspace applica=
tions
> > +which are submitted to the kernel for execution on an particular GPU e=
ngine.
> > +This just runs the simple IB tests included in the kernel.  These test=
s
> > +are engine specific and verify that IB submission works.
> > +
> > +amdgpu_discovery
> > +----------------
> > +
> > +Provides raw access to the IP discovery binary provided by the GPU.  R=
ead this
> > +file to acess the raw binary.  This is useful for verifying the conten=
ts of
> > +the IP discovery table.  It is chip specific.
> > +
> > +amdgpu_vbios
> > +------------
> > +
> > +Provides raw access to the ROM binary image from the GPU.  Read this f=
ile to
> > +access the raw binary.  This is useful for verifying the contents of t=
he
> > +video BIOS ROM.  It is board specific.
> > +
> > +amdgpu_evict_gtt
> > +----------------
> > +
> > +Evict all buffers from the GTT memory pool.  Read this file to evict a=
ll
> > +buffers from this pool.
> > +
> > +amdgpu_evict_vram
> > +-----------------
> > +
> > +Evict all buffers from the VRAM memory pool.  Read this file to evict =
all
> > +buffers from this pool.
> > +
> > +amdgpu_gpu_recover
> > +------------------
> > +
> > +Trigger a GPU reset.  Read this file to trigger reset the entire GPU.
> > +All work currently running  on the GPU will be lost.
> > +
> > +amdgpu_ring_<name>
> > +------------------
> > +
> > +Provides read access to the kernel managed ring buffers for each ring =
<name>.
> > +These are useful for debugging problems on a particular ring.  The rin=
g buffer
> > +is how the CPU sends commands to the GPU.  The CPU writes commands int=
o the
> > +buffer and then asks the GPU engine to process it.  This is the raw bi=
nary
> > +contents of the ring buffer.  Use a tool like UMR to decode the rings =
into human
> > +readable form.
> > +
> > +amdgpu_mqd_<name>
> > +-----------------
> > +
> > +Provides read access to the kernel managed MQD (Memory Queue Descripto=
r) for
> > +ring <name> managed by the kernel driver.  MQDs define the features of=
 the ring
> > +and are used to store the ring's state when it is not connected to har=
dware.
> > +The driver writes the requested ring features and metadata (GPU addres=
ses of
> > +the ring itself and associated buffers) to the MQD and the firmware us=
es the MQD
> > +to populate the hardware when the ring is mapped to a hardware slot.  =
Only
> > +available on engines which use MQDs.  This provides access to the raw =
MQD
> > +binary.
> > +
> > +amdgpu_error_<name>
> > +-------------------
> > +
> > +Provides an interface to set an error code on the dma fences associate=
d with
> > +ring <name>.  The error code specified is propogated to all fences ass=
ociated
> > +with the ring.  Use this to inject a fence error into a ring.
> > +
> > +amdgpu_pm_info
> > +--------------
> > +
> > +Provides human readable information about the power management feature=
s
> > +and state of the GPU.  This includes current GFX clock, Memory clock,
> > +voltages, average SoC power, temperature, GFX load, Memory load, SMU
> > +feature mask, VCN power state, clock and power gating features.
> > +
> > +amdgpu_firmware_info
> > +--------------------
> > +
> > +Lists the firmware versions for all firmwares used by the GPU.  Only
> > +entries with a non-0 version are valid.  If the version is 0, the firm=
ware
> > +is not valid for the GPU.
> > +
> > +amdgpu_fence_info
> > +-----------------
> > +
> > +Shows the last signalled and emitted fence sequence numbers for each
> > +kernel driver managed ring.  Fences are associated with submissions
> > +to the engine.  Emitted fences have been submitted to the ring
> > +and signalled fences have been signalled by the GPU.  Rings with a
> > +larger emitted fence value have outstanding work that is still being
> > +processed by the engine that owns that ring.  When the emitted and
> > +signalled fence values are equal, the ring is idle.
> > +
> > +amdgpu_gem_info
> > +---------------
> > +
> > +Lists all of the PIDs using the GPU and the GPU buffers that they have
> > +allocated.  This lists the buffer size, pool (VRAM, GTT, etc.), and bu=
ffer
> > +attributes (CPU access required, CPU cache attributes, etc.).
> > +
> > +amdgpu_vm_info
> > +--------------
> > +
> > +Lists all of the PIDs using the GPU and the GPU buffers that they have
> > +allocated as well as the status of those buffers relative to that proc=
ess'
> > +GPU virtual address space (e.g., evicted, idle, invalidated, etc.).
> > +
> > +amdgpu_sa_info
> > +--------------
> > +
> > +Prints out all of the suballocations (sa) by the suballocation manager=
 in the
> > +kernel driver.  Prints the GPU address, size, and fence info associate=
d
> > +with each suballocation.  The suballocations are used internally withi=
n
> > +the kernel driver for various things.
> > +
> > +amdgpu_<pool>_mm
> > +----------------
> > +
> > +Prints TTM information about the memory pool <pool>.
> > +
> > +amdgpu_vram
> > +-----------
> > +
> > +Provides direct access to VRAM.  Used by tools like UMR to inspect
> > +objects in VRAM.
> > +
> > +amdgpu_iomem
> > +------------
> > +
> > +Provides direct access to GTT memory.  Used by tools like UMR to inspe=
ct
> > +GTT memory.
> > +
> > +amdgpu_regs_*
> > +-------------
> > +
> > +Provides direct access to various register aperatures on the GPU.  Use=
d
> > +by tools like UMR to access GPU registers.
> > +
> > +amdgpu_regs2
> > +------------
> > +
> > +Provides an IOCTL interface used by UMR for interacting with GPU regis=
ters.
> > +
> > +
> > +amdgpu_sensors
> > +--------------
> > +
> > +Provides an interface to query GPU power metrics (temperature, average
> > +power, etc.).  Used by tools like UMR to query GPU power metrics.
> > +
> > +
> > +amdgpu_gca_config
> > +-----------------
> > +
> > +Provides an interface to query GPU details (Graphics/Compute Array con=
fig,
> > +PCI config, GPU family, etc.).  Used by tools like UMR to query GPU de=
tails.
> > +
> > +amdgpu_wave
> > +-----------
> > +
> > +Used to query GFX/compute wave infomation from the hardware.  Used by =
tools
> > +like UMR to query GFX/compute wave information.
> > +
> > +amdgpu_gpr
> > +----------
> > +
> > +Used to query GFX/compute GPR (General Purpose Register) infomation fr=
om the
> > +hardware.  Used by tools like UMR to query GPRs when debugging shaders=
.
> > +
> > +amdgpu_gprwave
> > +--------------
> > +
> > +Provides an IOCTL interface used by UMR for interacting with shader wa=
ves.
> > +
> > +amdgpu_fw_attestation
> > +---------------------
> > +
> > +Provides an interface for reading back firmware attestation records.
> > diff --git a/Documentation/gpu/amdgpu/debugging.rst b/Documentation/gpu=
/amdgpu/debugging.rst
> > index e75f97d0e4eaf..7cbfea0606e15 100644
> > --- a/Documentation/gpu/amdgpu/debugging.rst
> > +++ b/Documentation/gpu/amdgpu/debugging.rst
> > @@ -2,6 +2,13 @@
> >   GPU Debugging
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > +General Debugging Options
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +The DebugFS section provides documentation on a number files to aid in=
 debugging
> > +issues on the GPU.
> > +
> > +
> >  GPUVM Debugging
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amd=
gpu/index.rst
> > index 302d039928ee8..4c75567854cb2 100644
> > --- a/Documentation/gpu/amdgpu/index.rst
> > +++ b/Documentation/gpu/amdgpu/index.rst
> > @@ -16,5 +16,6 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA)=
 architectures.
> >     thermal
> >     driver-misc
> >     debugging
> > +   debugfs
> >     process-isolation
> >     amdgpu-glossary
> > --
> > 2.48.1
> >
