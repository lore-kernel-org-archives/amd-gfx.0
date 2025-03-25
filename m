Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61269C3600D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 20:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0384410E5F2;
	Tue, 25 Mar 2025 20:08:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cfodxU3h";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BD8F10E5F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 20:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TqSb/92Ja/3FiowNR8PVUekmoz0XynXtfGyoP65jQDc=; b=cfodxU3hwLRTcXallXuLNI/0hl
 oT3AQQ5KSYaBxvtwfzWpzVTBAxFzIsuwcxAICg1UlooQfnuEBlfWe264mkGnzsnTxSwIA5ohsql+d
 EjyK09trJ384jq7rhQ7nMmREsxEycQ6hnyl2dR9WGpmfwWVJLvbRmvx/mafUqaULSQQaPPuKzOxiQ
 VFKUX/qKjulgNOAfCshutXfDq3w9hcDtpGmo7k8Jd+TpcQSC5SOfN/voQxGQh6S9TWix8RGH+c3yU
 N4U7QbcUG5QDdSbd9UW+D4cdMnSXYIZ1Uz6RdMLqK2GrGMTmiVEr7sGaaI714EUfqYJV8RyhsfQrW
 fzPdPw+A==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1txAZ3-006Im2-0I; Tue, 25 Mar 2025 21:07:57 +0100
Date: Tue, 25 Mar 2025 14:07:54 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: add initial documentation for debugfs files
Message-ID: <xpxmbhqdepcf3pwbrlec5avtd2zsvnqzdd65gyhvwl24vdf4ya@4vbmdn575ubb>
References: <20250306155341.1770809-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306155341.1770809-1-alexander.deucher@amd.com>
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

On 03/06, Alex Deucher wrote:
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
> diff --git a/Documentation/gpu/amdgpu/debugfs.rst b/Documentation/gpu/amdgpu/debugfs.rst
> new file mode 100644
> index 0000000000000..fdfc1a8773c72
> --- /dev/null
> +++ b/Documentation/gpu/amdgpu/debugfs.rst
> @@ -0,0 +1,210 @@
> +==============
> +AMDGPU DebugFS
> +==============
> +
> +The amdgpu driver provides a number of debugfs files to aid in debugging
> +issues in the driver.  Thse are usually found in

/Thse/These/

With that change:

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

> +/sys/kernel/debug/dri/<num>.
> +
> +DebugFS Files
> +=============
> +
> +amdgpu_benchmark
> +----------------
> +
> +Run benchmarks using the DMA engine the driver uses for GPU memory paging.
> +Write a number to the file to run the test.  The results are written to the
> +kernel log.  VRAM is on device memory (dGPUs) or cave out (APUs) and GTT
> +(Graphics Translation Tables) is system memory that is accessible by the GPU.
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
> +Read this file to run simple IB (Indirect Buffer) tests on all kernel managed
> +rings.  IBs are command buffers usually generated by userspace applications
> +which are submitted to the kernel for execution on an particular GPU engine.
> +This just runs the simple IB tests included in the kernel.  These tests
> +are engine specific and verify that IB submission works.
> +
> +amdgpu_discovery
> +----------------
> +
> +Provides raw access to the IP discovery binary provided by the GPU.  Read this
> +file to acess the raw binary.  This is useful for verifying the contents of
> +the IP discovery table.  It is chip specific.
> +
> +amdgpu_vbios
> +------------
> +
> +Provides raw access to the ROM binary image from the GPU.  Read this file to
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
> +Evict all buffers from the VRAM memory pool.  Read this file to evict all
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
> +Provides read access to the kernel managed ring buffers for each ring <name>.
> +These are useful for debugging problems on a particular ring.  The ring buffer
> +is how the CPU sends commands to the GPU.  The CPU writes commands into the
> +buffer and then asks the GPU engine to process it.  This is the raw binary
> +contents of the ring buffer.  Use a tool like UMR to decode the rings into human
> +readable form.
> +
> +amdgpu_mqd_<name>
> +-----------------
> +
> +Provides read access to the kernel managed MQD (Memory Queue Descriptor) for
> +ring <name> managed by the kernel driver.  MQDs define the features of the ring
> +and are used to store the ring's state when it is not connected to hardware.
> +The driver writes the requested ring features and metadata (GPU addresses of
> +the ring itself and associated buffers) to the MQD and the firmware uses the MQD
> +to populate the hardware when the ring is mapped to a hardware slot.  Only
> +available on engines which use MQDs.  This provides access to the raw MQD
> +binary.
> +
> +amdgpu_error_<name>
> +-------------------
> +
> +Provides an interface to set an error code on the dma fences associated with
> +ring <name>.  The error code specified is propogated to all fences associated
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
> +entries with a non-0 version are valid.  If the version is 0, the firmware
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
> +allocated.  This lists the buffer size, pool (VRAM, GTT, etc.), and buffer
> +attributes (CPU access required, CPU cache attributes, etc.).
> +
> +amdgpu_vm_info
> +--------------
> +
> +Lists all of the PIDs using the GPU and the GPU buffers that they have
> +allocated as well as the status of those buffers relative to that process'
> +GPU virtual address space (e.g., evicted, idle, invalidated, etc.).
> +
> +amdgpu_sa_info
> +--------------
> +
> +Prints out all of the suballocations (sa) by the suballocation manager in the
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
> +Provides an IOCTL interface used by UMR for interacting with GPU registers.
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
> +Provides an interface to query GPU details (Graphics/Compute Array config,
> +PCI config, GPU family, etc.).  Used by tools like UMR to query GPU details.
> +
> +amdgpu_wave
> +-----------
> +
> +Used to query GFX/compute wave infomation from the hardware.  Used by tools
> +like UMR to query GFX/compute wave information.
> +
> +amdgpu_gpr
> +----------
> +
> +Used to query GFX/compute GPR (General Purpose Register) infomation from the
> +hardware.  Used by tools like UMR to query GPRs when debugging shaders.
> +
> +amdgpu_gprwave
> +--------------
> +
> +Provides an IOCTL interface used by UMR for interacting with shader waves.
> +
> +amdgpu_fw_attestation
> +---------------------
> +
> +Provides an interface for reading back firmware attestation records.
> diff --git a/Documentation/gpu/amdgpu/debugging.rst b/Documentation/gpu/amdgpu/debugging.rst
> index e75f97d0e4eaf..7cbfea0606e15 100644
> --- a/Documentation/gpu/amdgpu/debugging.rst
> +++ b/Documentation/gpu/amdgpu/debugging.rst
> @@ -2,6 +2,13 @@
>   GPU Debugging
>  ===============
>  
> +General Debugging Options
> +=========================
> +
> +The DebugFS section provides documentation on a number files to aid in debugging
> +issues on the GPU.
> +
> +
>  GPUVM Debugging
>  ===============
>  
> diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
> index 302d039928ee8..4c75567854cb2 100644
> --- a/Documentation/gpu/amdgpu/index.rst
> +++ b/Documentation/gpu/amdgpu/index.rst
> @@ -16,5 +16,6 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
>     thermal
>     driver-misc
>     debugging
> +   debugfs
>     process-isolation
>     amdgpu-glossary
> -- 
> 2.48.1
> 

-- 
Rodrigo Siqueira
