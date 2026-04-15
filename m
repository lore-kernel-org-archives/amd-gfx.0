Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B14F8A14C
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 08:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD75B10E858;
	Thu, 16 Apr 2026 08:46:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=posteo.de header.i=@posteo.de header.b="W5igBjuf";
	dkim-atps=neutral
X-Greylist: delayed 493 seconds by postgrey-1.36 at gabe;
 Wed, 15 Apr 2026 13:16:45 UTC
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE3E110E6DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 13:16:45 +0000 (UTC)
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 5F8BA240027
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 15:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
 t=1776258510; bh=04ZcX92PpWxllNndeRKP5p8NWiOL24tDJbryhVFq4/A=;
 h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
 Content-Transfer-Encoding:From;
 b=W5igBjufotCJbhrkJu3xXUlDVl7zYlXYaqXyEV+rI9hdoTOLEs882DjKgGkkT4zZR
 rwOonogXt9wDCJlgL9V1YCGtFpancAP9KBnBboqPggU+RDVy8e+XJ5irgXpRaAxGnm
 MecFxGY/Grqn7SlC2sFdxs7Fxw+a5u+LmS8aQmVVzC+FmIlYAiuKGxnMHYlXxOzSnn
 QsEr8WY1/zEn00WRXGcJwFIOWGjcLSYO7b/Hgb2YYtfiPh2UypafdpuliNLQKfGc7U
 95cjcB/KDsLrOCCU2HI9YgFdsW6o8xh2rbQRE1MIgcxl61YfrNUoJM867dp2x895vG
 RH3kqWZ6qlCkw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4fwhKT5RhGz6tsb
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 15:08:29 +0200 (CEST)
MIME-Version: 1.0
Date: Wed, 15 Apr 2026 13:08:29 +0000
From: a-development@posteo.de
To: amd-gfx@lists.freedesktop.org
Subject: [BUG] amdgpu: Mode1 resets and Link Training failure on RX 9070XT
 via KVM
Message-ID: <0f072e49eac0206de1ac795fd91bc32b@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 16 Apr 2026 08:46:30 +0000
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

I am experiencing a consistent display power-cycling issue with a new 
AMD Radeon RX 9070XT (RDNA 4). I am looking for guidance on whether this 
is a known regression in DCN (Display Core Next) or a specific hardware 
compatibility issue.

Hardware Environment:
- GPU: AMD Radeon RX 9070XT
- Comparison GPU: AMD Radeon W7500 (Works perfectly in the same setup)
- Connection Chain: Multiple DP ports via CableMatters Dongle -> TeSmart 
KVM.
- Direct Port: HDMI-A-1 is connected without a dongle, yet also exhibits 
failures.
- Display: 1920x1080 @ 240Hz (Issue persists even when lowered to 60Hz)

Kernel/Software Environment:
- Distributions: Arch Linux
- Kernels tested: 6.19.11-arch1-1.1 and Mainline 7.0-rc
- Firmware: Tested with latest linux-firmware (up to 2026-04-15)
- Compositors: Sway (constant cycling), Niri (intermittent), SDDM 
(constant)
- Troubleshooting: Tested multiple command-line options including 
pcie_aspm=performance, amdgpu.abmlevel=0.

EDID and Firmware Troubleshooting:
I have attempted to bypass the EDID communication errors by manually 
exporting the EDID and applying it via the 'drm.edid_firmware' 
parameter. This did not resolve the power-cycling, suggesting the 
failure occurs deeper in the link training or DCN power state transition 
rather than just simple metadata acquisition.

Furthermore, the logs indicate a potential SMU issue:
"amdgpu: SMU driver if version not matched"

Description of Behavior:
Upon entering a graphical environment, any mouse movement triggers the 
displays to power off and then back on again. While the 9070XT 
successfully negotiates the 1920x1080 @ 240Hz link initially and can 
render frames, it enters an immediate on-off cycle during active input.

Critically, HDMI-A-1 (which does not use a dongle) also fails to read 
EDID initially, and forced EDID overrides do not stabilize the link. 
This behavior is unique to the 9070XT; the W7500 workstation card 
functions without issue on the exact same cabling setup.

Relevant journalctl output (amdgpu):
amdgpu 0000:03:00.0: [drm] enabling link 0 failed: 15
amdgpu 0000:03:00.0: [drm] enabling link 2 failed: 15
[drm:dm_helpers_read_local_edid [amdgpu]] *ERROR* EDID err: 2, on 
connector: HDMI-A-1
amdgpu 0000:94:00.0: [drm] *ERROR* No EDID read.
amdgpu 0000:03:00.0: amdgpu: SMU driver if version not matched
amdgpu 0000:03:00.0: amdgpu: MODE1 reset
amdgpu 0000:03:00.0: amdgpu: GPU mode1 reset

Analysis:
Since forced EDID injection fails and the SMU reports a version 
mismatch, I am concerned this is an issue with the SMU/DCN firmware 
interaction on this new architecture or a driver-side link training 
timeout.

Could you provide insight on whether there are specific 'amdgpu' module 
parameters I should use to debug the Display Core (DC) or if I should 
provide a more verbose log with amdgpu.debug_mask?

Thank you for your time and assistance.

Best regards,
