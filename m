Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3368BC7115A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 21:42:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B918E10E5C5;
	Wed, 18 Jun 2025 21:42:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m5NoQ3XX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF7B10E5C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 21:42:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 258326116E;
 Wed, 18 Jun 2025 21:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72554C4CEE7;
 Wed, 18 Jun 2025 21:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750282349;
 bh=0t0EqoryOE/uzCFtYW5Bi9sFaX5/CC8TSykMJc47B3M=;
 h=From:To:Cc:Subject:Date:From;
 b=m5NoQ3XXY6WXyI7S5HgKZj7lUXymGKdsu64FgEQ02ngOHGkKx06HFdx69LS036NqY
 UdBQflzypJKG5x5CFaY4ifoz1JDHH0MlHZ/qce3J6apZGrGtHD2oHkBAlVK6XjGgBd
 ic+pFi/4ZeE3hFBooD9VUPUm36f+PRH9yK/h2cAHNjvr+ATieFlcCE57PJYLZT52g8
 12mMgAqiABwdeqD8ITKmeZmwDTL+USvOxOoWFKxfFhpf9U3zMPy+Q1kst8Hgc15YIB
 RUVaIeqpDgC1zS+WmB1AVvlGlzcrHCtZvLcF9MDt7PqQVr3vc6bP3oC9Iae3l/eO+e
 fXa8wjCSaG/Kw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>
Subject: [PATCH] drm/amd: Decrease message level for legacy-pm prints
Date: Wed, 18 Jun 2025 16:32:17 -0500
Message-ID: <20250618213217.3862490-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

legacy-pm has prints while changing power states that don't have
a level and thus are printed by default.  These are not useful at
runtime for most people, so decrease them to debug.

Reported-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4322
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index c7518b13e7879..5b09c5fd9dc13 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -123,14 +123,10 @@ void amdgpu_dpm_print_cap_info(u32 caps)
 void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
 				struct amdgpu_ps *rps)
 {
-	printk("\tstatus:");
-	if (rps == adev->pm.dpm.current_ps)
-		pr_cont(" c");
-	if (rps == adev->pm.dpm.requested_ps)
-		pr_cont(" r");
-	if (rps == adev->pm.dpm.boot_ps)
-		pr_cont(" b");
-	pr_cont("\n");
+	drm_dbg(adev_to_drm(adev), "\tstatus:%s%s%s\n",
+		rps == adev->pm.dpm.current_ps ? " c" : "",
+		rps == adev->pm.dpm.requested_ps ? " r" : "",
+		rps == adev->pm.dpm.boot_ps ? " b" : "");
 }
 
 void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
@@ -943,9 +939,9 @@ static int amdgpu_dpm_change_power_state_locked(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	if (amdgpu_dpm == 1 && pp_funcs->print_power_state) {
-		printk("switching from power state:\n");
+		drm_dbg(adev_to_drm(adev), "switching from power state\n");
 		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.current_ps);
-		printk("switching to power state:\n");
+		drm_dbg(adev_to_drm(adev), "switching to power state\n");
 		amdgpu_dpm_print_power_state(adev, adev->pm.dpm.requested_ps);
 	}
 
-- 
2.43.0

