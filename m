Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E45C28B2F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 13:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2046F10E486;
	Tue, 18 Mar 2025 13:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T/qD3sU7";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E4B010E486
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 13:16:23 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2ff73032ac0so726434a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742303782; x=1742908582; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nRKaz91RdtOZ1WX7PuS+sAz7JFPWOIDKHMlKGc5SDzA=;
 b=T/qD3sU7fkUBMGCvCAayfWZ22xf5P9IUPj82OhJ5TCjmpkmJbsVfq+l9h0rsQQs6IS
 ad/ZOZ25uNyoWm2SIpfE64azJf9gCCznUpyk28QhUcdvvthK8rKXyTOVgdt74zURbKoV
 8MXawloD4qxRkp1CQkviIYwqOWOO+QfNAYqni1P8BWiYY8ZLfugWcoaeR5uxt4yaiTBr
 +lh3Dx/CHwG7Nvzz6DTC+K0EhFYDEDdeHyzuEFF8QtTdMWcawjK2ESlHUaVTJMXVEhNN
 6rCUiy58iCtEyySIEiMpY/ny8FwOU+mpuvuhY9U5Sq8pquic7nnhCJmPYkG/O2ipuC20
 DZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303782; x=1742908582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nRKaz91RdtOZ1WX7PuS+sAz7JFPWOIDKHMlKGc5SDzA=;
 b=uUwrj1AGzlmE+J31g30BkGC16uSvaQj7itx4vE6VN3qnGO4lYvTH+/KLGN1QvbqgEV
 /DHa9OPjSacvvRirEo6QeIk2nAu02kY9I2APdKj3/GXIR8aVRKPT/7uizk0iEGxGc/1g
 3HhtxTQ54+BpxhvZNf1pds27+p8z1X9RDJJ5R15AT8h59P5DC0/Y3N3j8rPEwDd1J9ut
 I9WcTi8LLnPHJ6ysVFjwRKEpsq5IcwJCnClZhFDKy3iQWqh55AWYPibhhuq3A/K5ROeA
 NEA9efoKiweMfKIGTkNDbDR/Xnhrz5aEKBQUyooEdfK0BYF7B++xA3bkQiNdHuZEDGmj
 khgA==
X-Gm-Message-State: AOJu0YzxijjXYBSIiVGfSH9iZauEKcsPJI8pAJEqu7PYm+T395a3igJf
 Q6i/Up79BnWEPaAPfZT+g4p3yim1M+TpLxCbRrHF8+tIobYKFIjmkWi0yo/+bjEw90Tzf47s9C7
 Ilh52KiB2svwh9Q84ID86OQCDSvk=
X-Gm-Gg: ASbGncsvlTKQmDexukZV0SUMVTTdUVyku8aRzgblO+Llmt/8vA1DGCcWZevg05P/J4B
 p9YzAIN3aprnyUpNHNiMVdulkCWfUt+UYwhspEH3UlY808+tys7d9LALmpk09xIPRv58T/QRq9C
 v5wEJx8M9DtIIf7bm0CZSFSdhUmQ==
X-Google-Smtp-Source: AGHT+IFIrYlD5CwmBalyYVAvpm2Kwq/qCdErkgyTg90Q5sqdCI42lBEE7qqK6QJbayJxBOukz0XBY0TNF11pTf+Zvhc=
X-Received: by 2002:a17:90b:1b48:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-30151d56e76mr8004060a91.4.1742303782222; Tue, 18 Mar 2025
 06:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250306155341.1770809-1-alexander.deucher@amd.com>
In-Reply-To: <20250306155341.1770809-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Mar 2025 09:16:09 -0400
X-Gm-Features: AQ5f1JryNtqylQBCKYYnnJL_iLwsESIHia65qF9y4JiBXVt9cgLBP-pg0Mih74Y
Message-ID: <CADnq5_MWVcsY99bBOgLk9rtcV042AE+BvuiZ6mmm83OJzYsB8w@mail.gmail.com>
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

On Thu, Mar 6, 2025 at 10:54=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Describes what debugfs files are available and what
> they are used for.
>
> v2: fix some typos (Mark Glines)
> v3: Address comments from Siqueira and Kent
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  Documentation/gpu/amdgpu/debugfs.rst   | 210 +++++++++++++++++++++++++
>  Documentation/gpu/amdgpu/debugging.rst |   7 +
>  Documentation/gpu/amdgpu/index.rst     |   1 +
>  3 files changed, 218 insertions(+)
>  create mode 100644 Documentation/gpu/amdgpu/debugfs.rst
>
> diff --git a/Documentation/gpu/amdgpu/debugfs.rst b/Documentation/gpu/amd=
gpu/debugfs.rst
> new file mode 100644
> index 0000000000000..fdfc1a8773c72
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/debugfs.rst
> @@ -0,0 +1,210 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +AMDGPU DebugFS
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The amdgpu driver provides a number of debugfs files to aid in debugging
> +issues in the driver.  Thse are usually found in
> +/sys/kernel/debug/dri/<num>.
> +
> +DebugFS Files
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +amdgpu_benchmark
> +----------------
> +
> +Run benchmarks using the DMA engine the driver uses for GPU memory pagin=
g.
> +Write a number to the file to run the test.  The results are written to =
the
> +kernel log.  VRAM is on device memory (dGPUs) or cave out (APUs) and GTT
> +(Graphics Translation Tables) is system memory that is accessible by the=
 GPU.
> +The following tests are available:
> +
> +- 1: simple test, VRAM to GTT and GTT to VRAM
> +- 2: simple test, VRAM to VRAM
> +- 3: GTT to VRAM, buffer size sweep, powers of 2
> +- 4: VRAM to GTT, buffer size sweep, powers of 2
> +- 5: VRAM to VRAM, buffer size sweep, powers of 2
> +- 6: GTT to VRAM, buffer size sweep, common display sizes
> +- 7: VRAM to GTT, buffer size sweep, common display sizes
> +- 8: VRAM to VRAM, buffer size sweep, common display sizes
> +
> +amdgpu_test_ib
> +--------------
> +
> +Read this file to run simple IB (Indirect Buffer) tests on all kernel ma=
naged
> +rings.  IBs are command buffers usually generated by userspace applicati=
ons
> +which are submitted to the kernel for execution on an particular GPU eng=
ine.
> +This just runs the simple IB tests included in the kernel.  These tests
> +are engine specific and verify that IB submission works.
> +
> +amdgpu_discovery
> +----------------
> +
> +Provides raw access to the IP discovery binary provided by the GPU.  Rea=
d this
> +file to acess the raw binary.  This is useful for verifying the contents=
 of
> +the IP discovery table.  It is chip specific.
> +
> +amdgpu_vbios
> +------------
> +
> +Provides raw access to the ROM binary image from the GPU.  Read this fil=
e to
> +access the raw binary.  This is useful for verifying the contents of the
> +video BIOS ROM.  It is board specific.
> +
> +amdgpu_evict_gtt
> +----------------
> +
> +Evict all buffers from the GTT memory pool.  Read this file to evict all
> +buffers from this pool.
> +
> +amdgpu_evict_vram
> +-----------------
> +
> +Evict all buffers from the VRAM memory pool.  Read this file to evict al=
l
> +buffers from this pool.
> +
> +amdgpu_gpu_recover
> +------------------
> +
> +Trigger a GPU reset.  Read this file to trigger reset the entire GPU.
> +All work currently running  on the GPU will be lost.
> +
> +amdgpu_ring_<name>
> +------------------
> +
> +Provides read access to the kernel managed ring buffers for each ring <n=
ame>.
> +These are useful for debugging problems on a particular ring.  The ring =
buffer
> +is how the CPU sends commands to the GPU.  The CPU writes commands into =
the
> +buffer and then asks the GPU engine to process it.  This is the raw bina=
ry
> +contents of the ring buffer.  Use a tool like UMR to decode the rings in=
to human
> +readable form.
> +
> +amdgpu_mqd_<name>
> +-----------------
> +
> +Provides read access to the kernel managed MQD (Memory Queue Descriptor)=
 for
> +ring <name> managed by the kernel driver.  MQDs define the features of t=
he ring
> +and are used to store the ring's state when it is not connected to hardw=
are.
> +The driver writes the requested ring features and metadata (GPU addresse=
s of
> +the ring itself and associated buffers) to the MQD and the firmware uses=
 the MQD
> +to populate the hardware when the ring is mapped to a hardware slot.  On=
ly
> +available on engines which use MQDs.  This provides access to the raw MQ=
D
> +binary.
> +
> +amdgpu_error_<name>
> +-------------------
> +
> +Provides an interface to set an error code on the dma fences associated =
with
> +ring <name>.  The error code specified is propogated to all fences assoc=
iated
> +with the ring.  Use this to inject a fence error into a ring.
> +
> +amdgpu_pm_info
> +--------------
> +
> +Provides human readable information about the power management features
> +and state of the GPU.  This includes current GFX clock, Memory clock,
> +voltages, average SoC power, temperature, GFX load, Memory load, SMU
> +feature mask, VCN power state, clock and power gating features.
> +
> +amdgpu_firmware_info
> +--------------------
> +
> +Lists the firmware versions for all firmwares used by the GPU.  Only
> +entries with a non-0 version are valid.  If the version is 0, the firmwa=
re
> +is not valid for the GPU.
> +
> +amdgpu_fence_info
> +-----------------
> +
> +Shows the last signalled and emitted fence sequence numbers for each
> +kernel driver managed ring.  Fences are associated with submissions
> +to the engine.  Emitted fences have been submitted to the ring
> +and signalled fences have been signalled by the GPU.  Rings with a
> +larger emitted fence value have outstanding work that is still being
> +processed by the engine that owns that ring.  When the emitted and
> +signalled fence values are equal, the ring is idle.
> +
> +amdgpu_gem_info
> +---------------
> +
> +Lists all of the PIDs using the GPU and the GPU buffers that they have
> +allocated.  This lists the buffer size, pool (VRAM, GTT, etc.), and buff=
er
> +attributes (CPU access required, CPU cache attributes, etc.).
> +
> +amdgpu_vm_info
> +--------------
> +
> +Lists all of the PIDs using the GPU and the GPU buffers that they have
> +allocated as well as the status of those buffers relative to that proces=
s'
> +GPU virtual address space (e.g., evicted, idle, invalidated, etc.).
> +
> +amdgpu_sa_info
> +--------------
> +
> +Prints out all of the suballocations (sa) by the suballocation manager i=
n the
> +kernel driver.  Prints the GPU address, size, and fence info associated
> +with each suballocation.  The suballocations are used internally within
> +the kernel driver for various things.
> +
> +amdgpu_<pool>_mm
> +----------------
> +
> +Prints TTM information about the memory pool <pool>.
> +
> +amdgpu_vram
> +-----------
> +
> +Provides direct access to VRAM.  Used by tools like UMR to inspect
> +objects in VRAM.
> +
> +amdgpu_iomem
> +------------
> +
> +Provides direct access to GTT memory.  Used by tools like UMR to inspect
> +GTT memory.
> +
> +amdgpu_regs_*
> +-------------
> +
> +Provides direct access to various register aperatures on the GPU.  Used
> +by tools like UMR to access GPU registers.
> +
> +amdgpu_regs2
> +------------
> +
> +Provides an IOCTL interface used by UMR for interacting with GPU registe=
rs.
> +
> +
> +amdgpu_sensors
> +--------------
> +
> +Provides an interface to query GPU power metrics (temperature, average
> +power, etc.).  Used by tools like UMR to query GPU power metrics.
> +
> +
> +amdgpu_gca_config
> +-----------------
> +
> +Provides an interface to query GPU details (Graphics/Compute Array confi=
g,
> +PCI config, GPU family, etc.).  Used by tools like UMR to query GPU deta=
ils.
> +
> +amdgpu_wave
> +-----------
> +
> +Used to query GFX/compute wave infomation from the hardware.  Used by to=
ols
> +like UMR to query GFX/compute wave information.
> +
> +amdgpu_gpr
> +----------
> +
> +Used to query GFX/compute GPR (General Purpose Register) infomation from=
 the
> +hardware.  Used by tools like UMR to query GPRs when debugging shaders.
> +
> +amdgpu_gprwave
> +--------------
> +
> +Provides an IOCTL interface used by UMR for interacting with shader wave=
s.
> +
> +amdgpu_fw_attestation
> +---------------------
> +
> +Provides an interface for reading back firmware attestation records.
> diff --git a/Documentation/gpu/amdgpu/debugging.rst b/Documentation/gpu/a=
mdgpu/debugging.rst
> index e75f97d0e4eaf..7cbfea0606e15 100644
> --- a/Documentation/gpu/amdgpu/debugging.rst
> +++ b/Documentation/gpu/amdgpu/debugging.rst
> @@ -2,6 +2,13 @@
>   GPU Debugging
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> +General Debugging Options
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +The DebugFS section provides documentation on a number files to aid in d=
ebugging
> +issues on the GPU.
> +
> +
>  GPUVM Debugging
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgp=
u/index.rst
> index 302d039928ee8..4c75567854cb2 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -16,5 +16,6 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) a=
rchitectures.
>     thermal
>     driver-misc
>     debugging
> +   debugfs
>     process-isolation
>     amdgpu-glossary
> --
> 2.48.1
>
