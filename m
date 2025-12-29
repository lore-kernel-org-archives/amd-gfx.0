Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5807EE92733
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Dec 2025 17:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F398210E5DB;
	Mon, 29 Dec 2025 17:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=deeplearntech.com header.i=@deeplearntech.com header.b="MsKz5NcE";
	dkim-atps=neutral
Received: from zmailpro.com (zmailpro.com [174.129.240.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D34E110E5DB
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 17:25:25 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by zmailpro.com (Postfix) with ESMTP id DC04C8A5833;
 Mon, 29 Dec 2025 12:25:24 -0500 (EST)
Received: from zmailpro.com ([127.0.0.1])
 by localhost (zmailpro.com [127.0.0.1]) (amavis, port 10032) with ESMTP
 id Nn_r2n4zfa1b; Mon, 29 Dec 2025 12:25:23 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by zmailpro.com (Postfix) with ESMTP id A91F18A5807;
 Mon, 29 Dec 2025 12:25:23 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zmailpro.com A91F18A5807
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeplearntech.com;
 s=E11F0DAC-414D-11E7-97F0-308B22DE3479; t=1767029123;
 bh=1N1kFhuqUGtZrEJRBcs1sQw0g7qqoevj503UtbzMN7E=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=MsKz5NcEyYWuL9OOVhwlRtRF2/6gnwpKvLw3pjt7SxB5yetpJjf8D3YL0PZLKUxQ/
 zFsnutzyBeVmp0FxXfDKrTMAMAJv1KNgWaRB1DXAHwkQ0vzpkSYLrarJLYmMZnjLPA
 87WCzXfDwe+4gingaT+X2IyIQ8mlH6vG6ohqQyCJznPuKDIWoenlBQ4eGpQ2hgE44h
 ntq3D1sJDWzyCYRCrKg5AuCgUHW/OYiGKCA+lSX4kL6e98IAsp0lS/DMg2RZW6mst6
 XCO8smxVHK2DJCVHQIdBL7FChl0PtZrsHYZpoJ9nmzyPSE4CER7jOrTCqbS53A2t/x
 sR74ZWFZPdiUg==
X-Virus-Scanned: amavis at zmailpro.com
Received: from zmailpro.com ([127.0.0.1])
 by localhost (zmailpro.com [127.0.0.1]) (amavis, port 10026) with ESMTP
 id Ln1lGYeL5PGP; Mon, 29 Dec 2025 12:25:23 -0500 (EST)
Received: from zmailpro.com (zmailpro.com [174.129.240.60])
 by zmailpro.com (Postfix) with ESMTP id 6347E8A572F;
 Mon, 29 Dec 2025 12:25:23 -0500 (EST)
Date: Mon, 29 Dec 2025 12:25:22 -0500 (EST)
From: Harris Landgarten <harrisl@deeplearntech.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Message-ID: <506816970.137303.1767029122753.JavaMail.zimbra@lhjonline.com>
Subject: [BUG] Linux 6.19-rc3: Long-run MES hang leads to global fence
 starvation under sustained compute (gfx11 / Strix gfx1150)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [174.129.240.60]
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC144
 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Index: tFdV0/yUJRJW0RfQ0aYnYkGKYBjAnA==
Thread-Topic: Linux 6.19-rc3: Long-run MES hang leads to global fence
 starvation under sustained compute (gfx11 / Strix gfx1150)
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

I am reporting a reproducible GPU hang on Linux 6.19-rc3 involving the amdgpu MES control path, which after a long-running compute workload escalates into global fence starvation across multiple GPU rings.

### Hardware/software

* Platform: AZW SER9 (Ryzen AI 9 HX 370)
* GPU: Radeon 880M / 890M (gfx1150, Strix)
* BIOS: SER9T304 (11/13/2025)
* Kernel: Linux 6.19.0-rc3 (vanilla git, no downstream patches)
* Firmware: linux-firmware current as of Dec 2025
* Desktop: GNOME Wayland
* amdgpu: MES enabled (default)

### Workload

* Sustained GPU compute workload (training loop)
* Runtime before failure: ~13 hours
* No suspend/resume, power gating, or thermal events
* System otherwise idle

### Failure sequence

After approximately 13 hours, the following sequence occurs:

1. **MES control-path failure**

```
amdgpu: MES failed to respond to msg=MISC (WAIT_REG_MEM)
amdgpu: failed to reg_write_reg_wait
```

2. **MES ring buffer saturation**

```
amdgpu: MES ring buffer is full.
```

This message repeats continuously.

3. **Global fence starvation**
   Shortly after the MES ring fills, fence fallback timers begin expiring on multiple rings:

```
amdgpu: Fence fallback timer expired on ring vcn_unified_0
amdgpu: Fence fallback timer expired on ring sdma0
amdgpu: Fence fallback timer expired on ring gfx_0.0.0
amdgpu: Fence fallback timer expired on ring comp_1.3.0
```

These messages persist until reboot.

### Resulting behavior

* GPU compute and graphics are effectively deadlocked
* No forward progress on any affected ring
* GNOME becomes unresponsive
* SSH and local console remain functional
* amdgpu reset does not recover the device
* Full reboot is required

### Interpretation

This appears to be a long-run livelock or resource exhaustion in the scheduling/control path:

* MES stops responding to control messages
* The MES ring buffer fills and never drains
* Dependent rings stop retiring fences
* Fence fallback timers expire, indicating loss of forward progress
* No successful recovery path is triggered

This does not appear to be a client misuse or transient reset issue, but rather a deterministic failure after prolonged operation.

I can reliably reproduce this issue and can provide full logs, ring dumps, kernel config, or test patches if useful.

I can also report that, unlike RC2, which failed and never recovered, RC3, after waiting 30 min, recovered enough for consoles under Gnome to operate normally, and a systemd reboot completed normally, even if very slowly.
This is a definite improvement.

Best regards,
Harris Landgarten
