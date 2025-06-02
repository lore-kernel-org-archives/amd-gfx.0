Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8163C5B543
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jun 2025 01:44:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC7910E174;
	Mon,  2 Jun 2025 01:44:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m+lTUgvT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5C710E298
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jun 2025 01:44:46 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 161556113B;
 Mon,  2 Jun 2025 01:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660FCC4CEED;
 Mon,  2 Jun 2025 01:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1748828680;
 bh=sOj+vMcGSpkrJuSvboO8dgUzWvjLunGU//CbLA/ymfg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m+lTUgvTDO8kLtAk/4O/kstUK3FXysKwcACHsr5OMerVf6H41oF3oUMDifKPEm2Lx
 VYV/tpZ62myowB1cI+sghk89G4kRqse6HUJfcBIYx12zoBfbeSADs4G2gaHoJ5E6Jp
 POcHoUYj/ckCtj5hI0SEMhm7JiXGFmn7f1KMiW9Eym1T+wS7Vapo9mZfVdeiECowsN
 /CxfEs2H13TfUMnVYPvEjWXkGBxf3ifEcBMsdN2xhOx/UClfT4+aQLzxNab/S1WH6z
 2GCF7/8VgtHkguZwVRGHrVM47/b7LT9LjsdfPW3adSwdNJDFUmrN0JMI9+YoxVhamm
 5I+XXULtwnPGw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Chris Bainbridge <chris.bainbridge@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/3] drm/amd: Add support for a complete pmops action
Date: Sun,  1 Jun 2025 20:44:30 -0500
Message-ID: <20250602014432.3538345-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250602014432.3538345-1-superm1@kernel.org>
References: <20250602014432.3538345-1-superm1@kernel.org>
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

complete() callbacks are supposed to handle reversing anything
that occurred during prepare() callbacks.  They'll be called on every
power state transition, and will also be called if the sequence is
failed (such as an aborted suspend).

Add support for IP blocks to support this action.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  2 +-
 drivers/gpu/drm/amd/include/amd_shared.h   |  1 +
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a5ccd0ada16ab..77da367231b3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1619,6 +1619,7 @@ void amdgpu_driver_release_kms(struct drm_device *dev);
 
 int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
 int amdgpu_device_prepare(struct drm_device *dev);
+void amdgpu_device_complete(struct drm_device *dev);
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
 int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
 u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 72e41781afb06..abe86c7d830d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5034,6 +5034,28 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	return 0;
 }
 
+/**
+ * amdgpu_device_complete - complete power state transition
+ *
+ * @dev: drm dev pointer
+ *
+ * Undo the changes from amdgpu_device_prepare. This will be
+ * called on all resume transitions, including those that failed.
+ */
+void amdgpu_device_complete(struct drm_device *dev)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int i;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid)
+			continue;
+		if (!adev->ip_blocks[i].version->funcs->complete)
+			continue;
+		adev->ip_blocks[i].version->funcs->complete(&adev->ip_blocks[i]);
+	}
+}
+
 /**
  * amdgpu_device_suspend - initiate device suspend
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4db92e0a60da7..0fc0eeedc6461 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2570,7 +2570,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 
 static void amdgpu_pmops_complete(struct device *dev)
 {
-	/* nothing to do */
+	amdgpu_device_complete(dev_get_drvdata(dev));
 }
 
 static int amdgpu_pmops_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 11374a2cbab87..a06e92b1b2ef9 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -427,6 +427,7 @@ struct amd_ip_funcs {
 	int (*prepare_suspend)(struct amdgpu_ip_block *ip_block);
 	int (*suspend)(struct amdgpu_ip_block *ip_block);
 	int (*resume)(struct amdgpu_ip_block *ip_block);
+	void (*complete)(struct amdgpu_ip_block *ip_block);
 	bool (*is_idle)(struct amdgpu_ip_block *ip_block);
 	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
 	bool (*check_soft_reset)(struct amdgpu_ip_block *ip_block);
-- 
2.43.0

