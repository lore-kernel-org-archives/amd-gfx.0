Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54037CCD193
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Oct 2025 04:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF98010E1B5;
	Sun, 26 Oct 2025 04:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BSm/2Xo5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D3210E049
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:30:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E6AE06026F
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Oct 2025 04:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A290C4CEE7;
 Sun, 26 Oct 2025 04:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761453000;
 bh=UoFLG8bNMjn4uj6/kPuTPYxOANwBfTzqwT+iZPywZmI=;
 h=From:To:Cc:Subject:Date:From;
 b=BSm/2Xo5M+8xW5RItescrIGMU9ojMc3jC+58ujzH6FZm3nAfMHZ3XRjY+gOb2sQSG
 Ed29DbbFKS1cdvGo2Z0WrWKUsMtt/3x4F4iZHh1bOBSvaWYCcGkLX+9uEvWYvE1gmD
 67gAHe76tBuHwdntr3a3WmZVhVAX54RGv7oNlkmXQdFtX8YOEzqwmzBqh528/B3PIy
 TusZ6avI0MeD27LUNqPtiPkJoeDAoh7E0De4ufbIk3JCJd7B0eDWh5sFZ7TOhYmDf+
 TPcC768opQLXTz0SASkh8gmseOi/zTSJRkOqatQGo/bBjNTrKq9+HCg6KCAdCnKxzt
 SDucgmCDWqdEA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v5 0/5] Unwind failed suspend
Date: Sat, 25 Oct 2025 23:29:35 -0500
Message-ID: <20251026042942.549389-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If a suspend fails the PM core doesn't clean it up, the device
is just left in a bad state.  If this happens during memory pressure
it could be a hung system from just trying to suspend.

For all phases of suspend that return an error code, add an unwind
flow that will (try to) resume exactly the parts that have failed.

If this fails, then reset the GPU during complete() callback.

v5:
 * Take RLC patch from Alex's Van Gogh series, slight modifications
 * Unwind in middle of IP suspend too
 * Fix missing call to fix console
 * Cover issues with DPM_FLAG_SMART_SUSPEND

Alex Deucher (1):
  drm/amdgpu: Drop PMFW RLC notifier from amdgpu_device_suspend()

Mario Limonciello (AMD) (3):
  drm/amd: Reset the GPU if pmops failed
  drm/amd: Add an unwind for failures in
    amdgpu_device_ip_suspend_phase1()
  drm/amd: Add an unwind for failures in
    amdgpu_device_ip_suspend_phase2()
  drm/amd: Unwind for failed device suspend

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 121 ++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  11 ++
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c        |  18 ---
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |   2 -
 4 files changed, 117 insertions(+), 35 deletions(-)

-- 
2.51.1

