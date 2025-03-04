Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B426C021B8
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Mar 2025 19:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F98510E15C;
	Tue,  4 Mar 2025 19:25:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MOnsQQrr";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4092210E15C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Mar 2025 19:25:26 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2feb700271aso1163916a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Mar 2025 11:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741116325; x=1741721125; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tReD7ubAUU6eQHIDBtyLFvKL32/ed+7QcvSbJ34tsNo=;
 b=MOnsQQrr5mSDZqowqblYhDpXSXvuwROq75yU5psoTppk669Opu/jXrLoiW5plXJzpv
 NlOz1kkKd9VSYGaXoypp7Emm2AXnw5IkXo1pXucYri0IssGddBVB7VL6eL27sKK13RMy
 oZFErsN4iUUyMDEACqGz18Kj7bGSWrd756M/jO6/+hpuQNxN0jETSFasiQsb9SRXCmzA
 9TLiaiHZ7F3f2s4SlYEG5Loa6DYnYG6nM8NCZ2+vgnsv4kB6VRZTZPOZUnaoc19l7pXr
 U3kfW1s08OcKliKka3hzpmglf7vhLfaaDrY8P6JReBIgTOl0VAYXNT8TRlgq33LTdblC
 v7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741116325; x=1741721125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tReD7ubAUU6eQHIDBtyLFvKL32/ed+7QcvSbJ34tsNo=;
 b=fH2Ssz4QfIX0GW6OQCriARPh67wJ+pTZ8NF5TCOXH0U63YDWguTybepCWBddQ6Ofiw
 5ZiAZBFhVot3ghqXvIgzEiEaTCyVqmdUAW2CU3tFaeS0khpMagp9FScr+dZaw8+pwll3
 Wan75/CyojKDPcJ+Pk5WTtz8wD0dTdMZbdllaOIK6e/t7a9DbGRonDgNJQHrUCjv3t6T
 2YNdRyY2piCuGer7jzBhNWIRvDLfoxWBuVVc0ofBlJ4m7k4ODSTnzf9CJjrk2yDTOmTH
 eI0rCrCxLf7ex2eK50lxQzfYWjIjG125ldKLHEmgaBZJRTOzqiLfonB0CuuIXawRM6DM
 8sDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5DhWaB+GcZ4UFLfG3q6FVdSt0osdFDwJaFyO1Nz0drc0d59w77SN/SsI2LtIoHXnINiCSQT3j@lists.freedesktop.org
X-Gm-Message-State: AOJu0YynefZvof5CY9z2/8typvP1LHDoMiV3Zh+0SkT30MlROAjocSvd
 71gmml5Ipp7zVRdYp2OgpKfI7y0tkIovnjgZSEuaz27GNn/+kjb2/rGVM+o/ecEEtly7l5rHfBo
 ZvD/K8YCBmP6CldRmn4WnyquVhFk=
X-Gm-Gg: ASbGncuXBrmtccBSqSp+lovwlZF3fLtGtR8SgUchu+DH+f/tKdj+fdcdsnCCx/n941F
 QrJ6lgBogcBhQwfDTN4RYVA72ZYzLC/omm7ZmPdMswu1kC4r62qc2Us7DdT+goALr9KlqM26ADG
 h8qmzSKocZUV1V6RSYy3ytIcy7rg==
X-Google-Smtp-Source: AGHT+IG1GT3DaFcvd/7b5kNBuH/DfU6iVVmwpmesTzaUlwVzgcNNv3zWgBm0m3tdh5SiwWSmk0SZ5o725nz9OzkpBLA=
X-Received: by 2002:a17:90b:4d88:b0:2fe:da90:c7c2 with SMTP id
 98e67ed59e1d1-2ff49815cafmr260829a91.3.1741116324783; Tue, 04 Mar 2025
 11:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20250303230149.3544994-1-alexander.deucher@amd.com>
 <wykdd6kr3axxoeg2rq3mxtlaix5y4trrimnzlzzqbb456ypg2z@r5yoaqk6etrk>
In-Reply-To: <wykdd6kr3axxoeg2rq3mxtlaix5y4trrimnzlzzqbb456ypg2z@r5yoaqk6etrk>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Mar 2025 14:25:13 -0500
X-Gm-Features: AQ5f1JrPbL-RzyYu5JVNma9hbjUWWchHC4la4DCEjxcDS1gZ61VYQ8MH09IZWaM
Message-ID: <CADnq5_PGSx_z5-jbAZC-ck+igMNNOhRvp3zn-gtvYbyKo2dOLA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add initial documentation for debugfs files
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

On Tue, Mar 4, 2025 at 12:37=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> Hi Alex,
>
> I added a few suggestions and questions.
>
> On 03/03, Alex Deucher wrote:
> > Describes what debugfs files are available and what
> > they are used for.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  Documentation/gpu/amdgpu/debugfs.rst | 201 +++++++++++++++++++++++++++
> >  Documentation/gpu/amdgpu/index.rst   |   1 +
> >  2 files changed, 202 insertions(+)
> >  create mode 100644 Documentation/gpu/amdgpu/debugfs.rst
> >
> > diff --git a/Documentation/gpu/amdgpu/debugfs.rst b/Documentation/gpu/a=
mdgpu/debugfs.rst
> > new file mode 100644
> > index 0000000000000..9d82c770c1e78
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/debugfs.rst
> > @@ -0,0 +1,201 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +AMDGPU DebugFS
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The amdgpu driver provides a number of debugfs files to aid in debuggi=
ng
> > +issues in the driver.
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
> > +kernel log.  The following tests are available:
> > +
> > +- 1: simple test, VRAM to GTT and GTT to VRAM
>
> I know GTT is part of the glossary, but to improve this part of the doc
> readability, I suggested adding the acronym meaning the first time you
> mentioned GTT. You already used this approach in the rest of this patch.

Sure.

>
> > +- 2: simple test, VRAM to VRAM
> > +- 3: GTT to VRAM, buffer size sweep, powers of 2
> > +- 4: VRAM to GTT, buffer size sweep, powers of 2
> > +- 5: VRAM to VRAM, buffer size sweep, powers of 2
> > +- 6: GTT to VRAM, buffer size sweep, common modes
>
> What do you mean by "common modes"? Maybe consider adding a brief
> explanation or point to the documentation that explains it.

Sure.

>
> > +- 7: VRAM to GTT, buffer size sweep, common modes
> > +- 8: VRAM to VRAM, buffer size sweep, common modes
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
> > +This just runs the simple IB tests included in the kernel.
>
> How about adding the path to the simple IB test that you mentioned?

It's different for each engine type, but the basic idea is that it
provides the minimum viable IB that can exercise the functionality.

>
> > +
> > +amdgpu_discovery
> > +----------------
> > +
> > +Provides raw access to the IP discovery binary provided by the GPU.  R=
ead this
> > +file to acess the raw binary.
>
> /acess/access/

Will fix.

>
> Just out of curiosity, what is the use for these debugfs? Why users
> might want to use it? Can you get this binary from one device and load
> it into another device for testing?

It's the binary that the driver parses to determine which IP's are
present on the GPU.  It's mainly for debugging the actual binary.  You
shouldn't try and use this on any GPU other than the one that
generated it.

>
> > +
> > +amdgpu_vbios
> > +------------
> > +
> > +Provides raw access to the ROM binary image from the GPU.  Read this f=
ile to
> > +access the raw binary.
> > +
>
> I repeat my previous question:
>
> Can you get this binary from one device and load it into another device
> for testing?

Similar to the discovery binary.  Mainly for debugging the contents of
the binary.  E.g., the data tables and command tables included in it.
You wouldn't want to use this for any GPU other than the one it came
from.

>
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
> > +Read this file to trigger a full GPU reset.  All work currently runnin=
g
> > +on the GPU will be lost.
>
> iirc, AMD has 3 reset modes. By full GPU reset, do you mean the Mode
> that resets the entire device (mode 0?)?

I meant whole GPU reset rather than per queue reset.  How the driver
accomplishes this depends on the individual chip (some will use mode1
some will use mode2, etc.).

>
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
> > +buffer and then asks the GPU engine to process it.
>
> When I checked this debugfs, it prints a non-human readable output
> (maybe I did something wrong?). How can users use this output for
> debugging? Is there a way to parser the output?

This is the raw content of the ring buffer itself.  You can use UMR to
parse the contents and print contents in human readable form.

>
> > +
> > +amdgpu_mqd_<name>
> > +-----------------
> > +
>
> Same as my previous question.

This is also the raw content.  You'll need a separate tool to parse
this.  I don't remember if UMR can or not off hand.

>
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
> > +available on engines which use MQDs.
> > +
> > +amdgpu_error_<name>
> > +-------------------
> > +
> > +Provides an interface to set an error on fences associated with ring <=
name>.
> > +The error code specified is propogated to all fences associated with t=
he
> > +ring.
>
> I don't know how this error works. Is it something like this:
>
> echo 23 > /sys/kernel/debug/dri/1/amdgpu_error_gfx # 23 is a random numbe=
r
>
> And if there is a fence error in the gfx ring, should I see the error
> code 23 in the dmesg?

It would need to be a valid error number for a dma fence.  E.g., like
-ETIME.  The status of the fences determine the status of jobs on the
ring.

>
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
> > +Lists all of the PIDs using the GPU and the GPU buffers that are they =
have
> > +allocated.  This lists the buffer size, pool (VRAM, GTT, etc.), and bu=
ffer
> > +attributes (CPU access required, CPU cache attributes, etc.).
> > +
> > +amdgpu_vm_info
> > +--------------
> > +
> > +Lists all of the PIDs using the GPU and the GPU buffers that are they =
have
> > +allocated as well as the status of those buffers relative to that proc=
ess'
> > +GPU virtual address space (e.g., evicted, idle, invalidated, etc.).
> > +
> > +amdgpu_sa_info
> > +--------------
>
> Is sa =3D=3D SubAllocation?

Yes.  Will update.

>
> > +
> > +Prints out all of the suballocations by the suballocation manager in t=
he
> > +kernel driver.  Prints the GPU address, size, and fence info associate=
d
> > +with each suballocation.  They suballocations are used internally with=
in
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
>
> What is GCA? Could you add this to the amdgpu glossary?

yes.  Graphics and Compute Array (it's another name for the GFX/GC IP).

>
> > +
> > +Provides an interface to query GPU details (GFX config, PCI config,
> > +GPU family, etc.).  Used by tools like UMR to query GPU details.
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
> > +Used to      query GFX/compute GPR (General Purpose Register) infomati=
on from the
>
> It looks like that GPR it is not part of the amdgpu glossary.

Wasn't sure if it was worth putting this in the glossary since GPR is
a pretty common term in computer processors.

>
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
>
> What is this attestation record?

It's the attestation results for the firmwares used by the GPU.

>
> Is this available for all GPUs and APUs?

It's available on certain dGPUs.

>
> > diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amd=
gpu/index.rst
> > index 302d039928ee8..5254f3a162f84 100644
> > --- a/Documentation/gpu/amdgpu/index.rst
> > +++ b/Documentation/gpu/amdgpu/index.rst
> > @@ -17,4 +17,5 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA)=
 architectures.
> >     driver-misc
> >     debugging
>
> I believe this page is directly related to the debugging page. In this
> sense, maybe add a new section about the debugfs entries to the
> debugging page.

Will do.

>
> Thanks
>
> >     process-isolation
> > +   debugfs
> >     amdgpu-glossary
> > --
> > 2.48.1
> >
>
> --
> Rodrigo Siqueira
