Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FACC5DF9D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 07:56:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE01F10E660;
	Mon, 24 Aug 2026 07:56:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="ecyOhAzH";
	dkim-atps=neutral
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33D410E048
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Aug 2026 16:21:33 +0000 (UTC)
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 8E2DB240101
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Aug 2026 18:21:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
 s=1984.8680eb; t=1787502091;
 bh=mEOJq7UxWHPkzNjETfIWWWWXi44WijsRRLbP+7qEVKk=;
 h=Message-ID:Date:MIME-Version:To:Subject:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=ecyOhAzHAPj7WaG7AzNIyvzwFDZ1xoAjQTEhi6EUpla5ZhEgiu0WoERb1iYiQkbmt
 2kEJSB1BRLJUhk73k4Hr8PHquBCWAv2QECFT3BvuiGs2yN1aO9mZRZmNF+d8aDJlcc
 EYmiutY88J31jtjmeWvUsJ9BfmBFbWLLaxxEFrCqdxszlzw2p00afWrZ6FIvWL7JY7
 ClSAHo48AwGpMZ/jh2tDrV34TszYFJRDX9YYtoAVvv+VRoJGF1RhBRqC5jMhNo+B/B
 lpB2eZIPLaQjiSGmMOS8erBJqHRgFzRHvaCAvAZZ0Rnr6KpohkMaSbyEraGEnzZNc1
 7WRB1tgwyjClQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4hSfSC1c6Kz9rxG
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Aug 2026 18:21:30 +0200 (CEST)
Message-ID: <9644200c-ebc9-4039-a32d-39ee20849942@posteo.net>
Date: Sun, 23 Aug 2026 16:21:31 +0000
MIME-Version: 1.0
To: amd-gfx@lists.freedesktop.org
Subject: VCN 4.0 ring reset cannot recover a power-gated block, taking down
 the whole GPU (Phoenix, vcn_v4_0)
Content-Language: en-US
From: Lukas Heumos <lukas.heumos@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 07:56:52 +0000
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

I am hitting a reproducible full GPU loss on VCN 4.0.0 during hardware 
video decode, and I would like to ask whether the ring reset path is 
missing the same guard that was added to the suspend path for VCN 1.0 in 
2022.

Hardware and software
---------------------

Machine: TUXEDO InfinityBook Pro AMD Gen9
SoC: AMD Ryzen 7 8845HS w/ Radeon 780M (Phoenix3, 1002:1900 rev c5)
IP block: vcn_v4_0_0
VCN fw: ENC 1.19 DEC 7 VEP 0 Revision 0 (linux-firmware 20240318)
Kernels: 6.17.0-121035-tuxedo, 6.17.0-122035-tuxedo, 7.0.0-28-generic
Distro: Ubuntu 24.04
Userspace: Mesa 25.0.7 radeonsi VA-API, Firefox 152, GNOME/Wayland
amdgpu: pg_mask=0xFFFFFFFF, reset_method=-1 (auto), gpu_recovery=-1

Symptom
-------

During hardware-accelerated video decode in Firefox the unified VCN ring 
stops retiring work, the ring reset fails, the escalated full-adapter 
reset fails to resume the VCN block, and the driver gives up.
The display dies and the machine has to be powered off with the power 
button.

This has occurred 7 times over roughly two months, across three kernels. 
It is not tied to a particular site or codec.
Confirmed sources include YouTube, ZDF Mediathek and a third streaming 
site, and two occurrences had no video navigation at all, most likely a 
background tab.
The submitting process is always Firefox's RDD (decode) process.

Log
---

amdgpu 0000:65:00.0: ring vcn_unified_0 timeout, signaled seq=13423, 
emitted seq=13425
amdgpu 0000:65:00.0: Process RDD Process pid 7866 thread browser 4 :cs0 
pid 23438
amdgpu 0000:65:00.0: Starting vcn_unified_0 ring reset
amdgpu 0000:65:00.0: Register(0) [regUVD_POWER_STATUS] failed to reach 
value 0x00000001 != 0x00000002
amdgpu 0000:65:00.0: Register(0) [regUVD_RB_RPTR] failed to reach value 
0x00000200 != 0x00000180
amdgpu 0000:65:00.0: Register(0) [regUVD_POWER_STATUS] failed to reach 
value 0x00000001 != 0x00000002
amdgpu 0000:65:00.0: Ring vcn_unified_0 reset failed
amdgpu 0000:65:00.0: GPU reset begin!. Source: 1
amdgpu 0000:65:00.0: MODE2 reset
amdgpu 0000:65:00.0: GPU reset succeeded, trying to resume
amdgpu 0000:65:00.0: SMU is resuming...
amdgpu 0000:65:00.0: SMU is resumed successfully!
amdgpu 0000:65:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring 
vcn_unified_0 test failed (-110)
amdgpu 0000:65:00.0: resume of IP block <vcn_v4_0> failed -110
amdgpu 0000:65:00.0: GPU reset end with ret = -110
amdgpu 0000:65:00.0: GPU Recovery Failed: -110
amdgpu 0000:65:00.0: [drm] *ERROR* [CRTC:364:crtc-0] hw_done or 
flip_done timed out

Across the single failing boot, regUVD_POWER_STATUS misses its expected 
value eight times, always reading 0x2 where the driver requires 0x1:

8x regUVD_POWER_STATUS expected 0x00000001 read 0x00000002
4x regUVD_RB_RPTR expected 0x00000040 read 0x00000000
1x regUVD_RB_RPTR expected 0x00000200 read 0x00000180


Thanks,
Lukas Heumos
