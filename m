Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D8EE668BC
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Nov 2024 19:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068EB10E2B7;
	Sun, 24 Nov 2024 19:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EnbZ2eM7";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFA110E0B1
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Nov 2024 19:00:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4D5815C3D5F;
 Sun, 24 Nov 2024 18:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45450C4CED3;
 Sun, 24 Nov 2024 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732474807;
 bh=4XvsKQ5Re1KUK2asHZeTQuZ4c3/bnJekay93utCSSfQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EnbZ2eM756hGrtWDgPhK2SzQgdIm3zGPZhC4P1D/JcrzEZdiVNgghV6p0y27R7NYw
 ZvQXtG1V1ifHNTeT0Nx0XGR8tBxmplShgEqfWKn5E2a1de5pfpb1q9Xtw7IJsacuJW
 FdeluE9FtFY77MtEeH021Z6Xi+O2wy4kKWD8mHXg2Ssy+Nk7LpM8S2DrT6xapKuire
 EnAzr7ndmqVjpnbLZHBzWf04B5W1tPqgCs9tdUQV1otdd624wpWRX6EqJCThvGoxbB
 7/yDZN3mK64WyZqKMHVVyGqEtQqPSQNPY6QCj7LJT2qoYaYRxcJCPjc0G71hrhHggY
 hIhWCPRFQgR6Q==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 2/2] drm/amd: Add Suspend/Hibernate notification callback
 support
Date: Sun, 24 Nov 2024 13:00:01 -0600
Message-ID: <20241124190001.2633591-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124190001.2633591-1-superm1@kernel.org>
References: <20241124190001.2633591-1-superm1@kernel.org>
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

As part of the suspend sequence VRAM needs to be evicted on dGPUs.
In order to make suspend/resume more reliable we moved this into
the pmops prepare() callback so that the suspend sequence would fail
but the system could remain operational under high memory usage suspend.

Another class of issues exist though where due to memory fragementation
there isn't a large enough contiguous space and swap isn't accessible.

Add support for a suspend/hibernate notification callback that could
evict VRAM before tasks are frozen. This should allow paging out to swap
if necessary.

Link: https://github.com/ROCm/ROCK-Kernel-Driver/issues/174
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3476
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3781
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * Make non fatal, drop patch 3
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 ++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d8bc6da500161..79ec4ab8ecfc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -879,6 +879,7 @@ struct amdgpu_device {
 	bool				need_swiotlb;
 	bool				accel_working;
 	struct notifier_block		acpi_nb;
+	struct notifier_block		pm_nb;
 	struct amdgpu_i2c_chan		*i2c_bus[AMDGPU_MAX_I2C_BUS];
 	struct debugfs_blob_wrapper     debugfs_vbios_blob;
 	struct debugfs_blob_wrapper     debugfs_discovery_blob;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 996e9c78384dd..56510ab4b6650 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -191,6 +191,8 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
 }
 
 static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev);
+static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
+				     void *data);
 
 /**
  * DOC: pcie_replay_count
@@ -4553,6 +4555,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	amdgpu_device_check_iommu_direct_map(adev);
 
+	adev->pm_nb.notifier_call = amdgpu_device_pm_notifier;
+	r = register_pm_notifier(&adev->pm_nb);
+	if (r)
+		goto failed;
+
 	return 0;
 
 release_ras_con:
@@ -4617,6 +4624,8 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		drain_workqueue(adev->mman.bdev.wq);
 	adev->shutdown = true;
 
+	unregister_pm_notifier(&adev->pm_nb);
+
 	/* make sure IB test finished before entering exclusive mode
 	 * to avoid preemption on IB test
 	 */
@@ -4748,6 +4757,42 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 /*
  * Suspend & resume.
  */
+/**
+ * amdgpu_device_pm_notifier - Notification block for Suspend/Hibernate events
+ * @nb: notifier block
+ * @mode: suspend mode
+ * @data: data
+ *
+ * This function is called when the system is about to suspend or hibernate.
+ * It is used to evict resources from the device before the system goes to
+ * sleep while there is still access to swap.
+ */
+static int amdgpu_device_pm_notifier(struct notifier_block *nb, unsigned long mode,
+				     void *data)
+{
+	struct amdgpu_device *adev = container_of(nb, struct amdgpu_device, pm_nb);
+	int r;
+
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+		adev->in_s4 = true;
+		fallthrough;
+	case PM_SUSPEND_PREPARE:
+		r = amdgpu_device_evict_resources(adev);
+		adev->in_s4 = false;
+		/*
+		 * This is considered non-fatal at thie time because
+		 * amdgpu_device_prepare() will also evict resources.
+		 * See https://gitlab.freedesktop.org/drm/amd/-/issues/3781
+		 */
+		if (r)
+			drm_warn(adev_to_drm(adev), "Failed to evict resources, freeze active processes if problems occur\n");
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 /**
  * amdgpu_device_prepare - prepare for device suspend
  *
-- 
2.43.0

