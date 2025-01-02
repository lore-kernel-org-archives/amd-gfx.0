Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00410E77188
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 16:24:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E136310E10F;
	Thu,  2 Jan 2025 16:24:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gTST7Koq";
	dkim-atps=neutral
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BA410E2DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 05:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1735796538; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=eRvFo58UkwSgSFpiYCOkBZvqNEXvkigSKipPVhqJXIA=;
 b=gTST7Koq6pTh/foT2khvqkOXS6viemJJRVCWK1tvgnrV0/+vJ+RgLc8RtMT3yjfhKlVfCxnZolqyHatKGHgdl/L6QeyNzUB7DzhhTsc/mQJ5t09Zrb45Z5hhRiKzD01KuZzfQUx7oehacXN+hQy8kKTVmLOk2kSvBI7IYnMeru4=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WMk35o2_1735796229 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 02 Jan 2025 13:37:15 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: amd-gfx@lists.freedesktop.org, kent.russell@amd.com,
 shuox.liu@linux.alibaba.com
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH 1/6] amdgpu: add flags to track sysfs initialization status
Date: Thu,  2 Jan 2025 13:36:52 +0800
Message-ID: <737a46d7273d625ef8a1146925296bbdf57f2274.1735795671.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1735795671.git.gerry@linux.alibaba.com>
References: <cover.1735795671.git.gerry@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jan 2025 16:24:05 +0000
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

Add flags to track sysfs initialization status, so we can correctly
clean them up on error recover paths.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 34 +++++++++++++++++-----
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 22c7e9669162..e4b13e729770 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1157,6 +1157,9 @@ struct amdgpu_device {
 	bool                            in_runpm;
 	bool                            has_pr3;
 
+	bool				sysfs_en;
+	bool				fru_sysfs_en;
+	bool				reg_state_sysfs_en;
 	bool                            ucode_sysfs_en;
 
 	struct amdgpu_fru_info		*fru_info;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d1bb9e85b6d7..3244966b0c39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4533,8 +4533,13 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 		adev->ucode_sysfs_en = true;
 
 	r = sysfs_create_files(&adev->dev->kobj, amdgpu_dev_attributes);
-	if (r)
+	if (r) {
 		dev_err(adev->dev, "Could not create amdgpu device attr\n");
+		adev->sysfs_en = false;
+	} else {
+		adev->sysfs_en = true;
+	}
+
 #ifdef HAVE_PCI_DRIVER_DEV_GROUPS
 	r = devm_device_add_group(adev->dev, &amdgpu_board_attrs_group);
 	if (r)
@@ -4542,8 +4547,21 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 			"Could not create amdgpu board attributes\n");
 #endif
 
-	amdgpu_fru_sysfs_init(adev);
-	amdgpu_reg_state_sysfs_init(adev);
+	r = amdgpu_fru_sysfs_init(adev);
+	if (r) {
+		dev_err(adev->dev, "Could not create amdgpu fru attr\n");
+		adev->fru_sysfs_en = false;
+	} else {
+		adev->fru_sysfs_en = true;
+	}
+
+	r = amdgpu_reg_state_sysfs_init(adev);
+	if (r) {
+		dev_err(adev->dev, "Could not create amdgpu reg state attr\n");
+		adev->reg_state_sysfs_en = false;
+	} else {
+		adev->reg_state_sysfs_en = true;
+	}
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
 		r = amdgpu_pmu_init(adev);
@@ -4666,10 +4684,12 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 		amdgpu_pm_sysfs_fini(adev);
 	if (adev->ucode_sysfs_en)
 		amdgpu_ucode_sysfs_fini(adev);
-	sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
-	amdgpu_fru_sysfs_fini(adev);
-
-	amdgpu_reg_state_sysfs_fini(adev);
+	if (adev->sysfs_en)
+		sysfs_remove_files(&adev->dev->kobj, amdgpu_dev_attributes);
+	if (adev->fru_sysfs_en)
+		amdgpu_fru_sysfs_fini(adev);
+	if (adev->reg_state_sysfs_en)
+		amdgpu_reg_state_sysfs_fini(adev);
 
 	/* disable ras feature must before hw fini */
 	amdgpu_ras_pre_fini(adev);
-- 
2.43.5

