Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C9EE6749D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 08:23:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1723D10E596;
	Mon, 22 Dec 2025 08:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=glanzmann.de header.i=@glanzmann.de header.b="U07KSS4i";
	dkim-atps=neutral
X-Greylist: delayed 427 seconds by postgrey-1.36 at gabe;
 Mon, 22 Dec 2025 06:25:48 UTC
Received: from infra.glanzmann.de (infra.glanzmann.de [88.198.237.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF3510E1B1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 06:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
 s=infra26101010; t=1766384319;
 bh=Cw92PG2Uk7ofVOyfPAtZNDbYl2tZ1ufkc6kNDBpeVrQ=;
 h=Date:From:To:Subject:From;
 b=U07KSS4iBuHJ4/a86f7ShNH+4M/ORKCCjv7WGLpKnpxNAmP7KCr1ryXw56yuLCqHX
 XyCkMIWyFNxKUMjoSfqySXu3c/8OpOv8Hqu/LR0y3xLf+lcocEJdGRgn9GpoJcfERI
 ijKjzkevxUUh3AOPuFwqmocF3wIWFuaDVHfsxy3heu/bH+WPxjDYewpUNRfstcWgWA
 vzS0ZDBWJW3TskDEW+y/RseRbiBwEo0BiS2W3UwcCPobQlNJKlxtvni1zdXuLrvE/r
 6gEATkfP7k95j8PLzdqGImjcQX435t7ZlmMho8CXfhq5QiXkw1jIheD4eYPn54+N7z
 +rqhQFM3bxCMIlb+kHwxcESXkiLt9O90+el+8YorZ6rFU1isLz61tbcYrVwSS2DwZy
 HtZeeYEd7bVSSJQmq5Z55oE9ImI4IxYFImnrVgWBT8eFgSS3AJ6EN0tuEFBcbEyo9C
 +igwbUVGNuS2EP2PrKzLPglVbcAbj7HNhT3XpzeEQbx85O+q3R3skX66MuaMA9jS5Z
 1TeLXoIMVUsgM3BHM4V/oR6+GDa3/8wWyK4QVINWJSe9a4Dnt+jo6WnCC4tyxkkQ7w
 qzHuukEPUvPpWkG2nBatFoV7bmAJI1ZH24PwiF6eqjEIWWooT3gRXU+Wfyxp31AIQi
 mRTz2NDJptQZiRd1yNcIEfqY=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
 id 6C407255DE6; Mon, 22 Dec 2025 07:18:39 +0100 (CET)
Date: Mon, 22 Dec 2025 07:18:39 +0100
From: Thomas Glanzmann <thomas@glanzmann.de>
To: amd-gfx@lists.freedesktop.org
Subject: amdgpu: [drm] AMDGPU device coredump file has been created
Message-ID: <aUjiv4TnoVJ9LysI@glanzmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 22 Dec 2025 08:23:36 +0000
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

Hello,
I have a PC which worked fine for many years that I did not use for half
a year. Yesterday I want to use it, but sway appears to be crashing
amdgpu in DRM. The components are:

- ASUS System Product Name/TUF GAMING B650M-PLUS
- AMD Ryzen 9 7950X 16-Core Processor
- Debian trixie

I already tried the following:

        - Upgrading to Debian forky
        - Debian trixie live cd
        - Installing the latested amd gpu firmware
	- Updating the Bios to the latest.

In order to reproduce the issue, I boot linux, start sway and open an
alacritty terminal with a tmux inside. amdgpu crashes immediatly. Find
here a video and the full dmesg.

https://tg.st/u/dmesg_9f62587406fb808dc4d91d41029ccf88ceeadf13e1f91d65c27b57536f375550.txt
https://tg.st/u/amdgpu_device_coredump_data_a25f2060c56260bb46ac95ee3123969d5127bf31b29ea3adfe3feeac67bf4edc.zst
https://tg.st/u/VID_20251222_071051104.mp4

[   57.342777] amdgpu 0000:0b:00.0: amdgpu: Dumping IP State
[   57.343822] amdgpu 0000:0b:00.0: amdgpu: Dumping IP State Completed
[   57.343869] amdgpu 0000:0b:00.0: amdgpu: [drm] AMDGPU device coredump file has been created
[   57.343871] amdgpu 0000:0b:00.0: amdgpu: [drm] Check your /sys/class/drm/card0/device/devcoredump/data
[   57.343872] amdgpu 0000:0b:00.0: amdgpu: ring gfx_0.0.0 timeout, signaled seq=106, emitted seq=108
[   57.343873] amdgpu 0000:0b:00.0: amdgpu:  Process sway pid 2021 thread sway:cs0 pid 2317
[   57.343875] amdgpu 0000:0b:00.0: amdgpu: Starting gfx_0.0.0 ring reset
[   57.485168] amdgpu 0000:0b:00.0: amdgpu: Ring gfx_0.0.0 reset failed
[   57.485170] amdgpu 0000:0b:00.0: amdgpu: GPU reset begin!
[   57.609921] amdgpu 0000:0b:00.0: amdgpu: MODE2 reset
[   57.616920] amdgpu 0000:0b:00.0: amdgpu: GPU reset succeeded, trying to resume
[   57.617008] [drm] PCIE GART of 1024M enabled (table at 0x000000F41FC00000).
[   57.617024] amdgpu 0000:0b:00.0: amdgpu: PSP is resuming...
[   57.638326] amdgpu 0000:0b:00.0: amdgpu: reserve 0xa00000 from 0xf41e000000 for PSP TMR
[   57.832236] amdgpu 0000:0b:00.0: amdgpu: RAS: optional ras ta ucode is not available
[   57.837959] amdgpu 0000:0b:00.0: amdgpu: RAP: optional rap ta ucode is not available
[   57.837961] amdgpu 0000:0b:00.0: amdgpu: SECUREDISPLAY: optional securedisplay ta ucode is not available
[   57.837963] amdgpu 0000:0b:00.0: amdgpu: SMU is resuming...
[   57.838869] amdgpu 0000:0b:00.0: amdgpu: SMU is resumed successfully!
[   57.839132] amdgpu 0000:0b:00.0: amdgpu: kiq ring mec 2 pipe 1 q 0
[   57.842333] amdgpu 0000:0b:00.0: amdgpu: [drm] DMUB hardware initialized: version=0x05002C00
[   57.944932] amdgpu 0000:0b:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
[   57.944935] amdgpu 0000:0b:00.0: amdgpu: ring gfx_0.1.0 uses VM inv eng 1 on hub 0
[   57.944936] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 4 on hub 0
[   57.944937] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 5 on hub 0
[   57.944938] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
[   57.944938] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
[   57.944939] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
[   57.944939] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
[   57.944940] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
[   57.944940] amdgpu 0000:0b:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
[   57.944941] amdgpu 0000:0b:00.0: amdgpu: ring kiq_0.2.1.0 uses VM inv eng 12 on hub 0
[   57.944941] amdgpu 0000:0b:00.0: amdgpu: ring sdma0 uses VM inv eng 13 on hub 0
[   57.944942] amdgpu 0000:0b:00.0: amdgpu: ring vcn_dec_0 uses VM inv eng 0 on hub 8
[   57.944943] amdgpu 0000:0b:00.0: amdgpu: ring vcn_enc_0.0 uses VM inv eng 1 on hub 8
[   57.944943] amdgpu 0000:0b:00.0: amdgpu: ring vcn_enc_0.1 uses VM inv eng 4 on hub 8
[   57.944944] amdgpu 0000:0b:00.0: amdgpu: ring jpeg_dec uses VM inv eng 5 on hub 8
[   57.948092] amdgpu 0000:0b:00.0: amdgpu: GPU reset(1) succeeded!
[   57.948107] amdgpu 0000:0b:00.0: [drm] device wedged, but recovered through reset
[   57.961832] [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initialize parser -125!

I'm grateful for any pointers that resolve the issue and available for debugging.

Cheers,
        Thomas
