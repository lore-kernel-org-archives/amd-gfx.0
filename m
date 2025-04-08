Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD89C369A1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 18:10:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3587710E739;
	Tue,  8 Apr 2025 18:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lc9/Ylt+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCCBC10E722
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 18:10:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EEE37615EA;
 Tue,  8 Apr 2025 18:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6139AC4CEE8;
 Tue,  8 Apr 2025 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744135803;
 bh=rWZn0qvJ6UM8UkbrJEKtTdKfCddZp2wmqY85OYDMFbs=;
 h=From:To:Cc:Subject:Date:From;
 b=lc9/Ylt+3rvzJsiz1YtTQ4XeAfsDFqUjbWZB5h1IdLjrkklojKtzsI0g9V46mir2C
 BUJ2G+4NiFS53n5cDVFKdfHtu8xzqTZcZkdfEkPs8Wu2hRpmxlyyvq2FNZKglXFusy
 CTZxjU8fULNhK2XbCL1iRhDsTphCA5wz5bQmXdqzyGcFA86KpX9t1tPIzlUneYTddf
 ORoDCMPYUpe0XoPvgR1ptXhrwwDeG2T5G3CMgGJQ8yLcH1Wf2pQyiW5bleSAWbyDtp
 rLgddEs422F978z4Nmi09NbS7xbc0m84/m9iM03OWYP+aZ0ImtdJKnTe78XBS9IqDH
 a60Zw3xFyRtIw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Forbid suspending into non-default suspend states
Date: Tue,  8 Apr 2025 13:09:57 -0500
Message-ID: <20250408180957.4027643-1-superm1@kernel.org>
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

On systems that default to 'deep' some userspace software likes
to try to suspend in 'deep' first.  If there is a failure for any
reason (such as -ENOMEM) the failure is ignored and then it will
try to use 's2idle' as a fallback. This fails, but more importantly
it leads to graphical problems.

Forbid this behavior and only allow suspending in the last state
supported by the system.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4093
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6d83ccfa42eeb..d79fd557b2d6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1124,6 +1124,7 @@ struct amdgpu_device {
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
+	suspend_state_t			last_suspend_state;
 
 	enum pp_mp1_state               mp1_state;
 	struct amdgpu_doorbell_index doorbell_index;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 26bf896f1444e..24ee4710f807f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2548,8 +2548,20 @@ static int amdgpu_pmops_suspend(struct device *dev)
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
 		adev->in_s3 = true;
-	if (!adev->in_s0ix && !adev->in_s3)
+	if (!adev->in_s0ix && !adev->in_s3) {
+		/* don't allow going deep first time followed by s2idle the next time */
+		if (adev->last_suspend_state != PM_SUSPEND_ON &&
+		    adev->last_suspend_state != pm_suspend_target_state) {
+			drm_err_once(drm_dev, "Unsupported suspend state %d\n",
+				     pm_suspend_target_state);
+			return -EINVAL;
+		}
 		return 0;
+	}
+
+	/* cache the state last used for suspend */
+	adev->last_suspend_state = pm_suspend_target_state;
+
 	return amdgpu_device_suspend(drm_dev, true);
 }
 
-- 
2.43.0

