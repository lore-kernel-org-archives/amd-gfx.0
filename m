Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EC1C71159
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 20:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947D210E35A;
	Mon, 16 Jun 2025 20:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jou9LCd7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F7910E35A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 20:15:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4427A629C0;
 Mon, 16 Jun 2025 20:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8853C4CEEA;
 Mon, 16 Jun 2025 20:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750104957;
 bh=QUHb43659WkvsnPZP3NAMLeSsC2Vg10stmli5aEXEaA=;
 h=From:To:Cc:Subject:Date:From;
 b=Jou9LCd7AS8dWmUDl7lZPdW1c3FNTrqScLFCE4lYZxUEObyiqGrXp74f01T89HioF
 330khX36CkINlOpLkRWX0iuT4AYdGbOUSMlm1nEQKyjREjaeoKyRtaNX7NAH+ZoLuz
 8fOxcebcqVGhsaWFsIXb3O+25wtYeCjkWYa7wyKFhzloDv7H5LyulYHmGTuXZjWOMh
 DLE8WW59mcxCZXAT1clxfEd4D1gRM1KgTOAog3oE8FPvCaLt2dnnRzASfpvTWvn8P9
 z4kAtJWV2bzeW1Ye8B4a/qtCR7M8cFV3uMCSYHMXvhw4KXbVEQ/wgIrmDqnQYD5nix
 3n6cR3TBi34AA==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Add a sysfs file to detect whether a GPU is an APU
Date: Mon, 16 Jun 2025 15:15:52 -0500
Message-ID: <20250616201552.4022366-1-superm1@kernel.org>
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

In order to discover whether a GPU is part of a dGPU or APU userspace has
to do some mental gymnastics or heuristics.  Add a sysfs file that clearly
indicates to userspace.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c     | 16 ++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index edd9895b46c02..4e4c77488e334 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -945,6 +945,21 @@ static ssize_t amdgpu_get_pp_features(struct device *dev,
 	return size;
 }
 
+/**
+ * DOC: apu
+ *
+ * Represents whether GPU is on a dGPU (0) or APU (1)
+ */
+static ssize_t amdgpu_get_apu(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	return sysfs_emit(buf, "%d\n", adev->flags & AMD_IS_APU ? 1 : 0);
+}
+
 /**
  * DOC: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie
  *
@@ -2287,6 +2302,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 			      .attr_update = ss_bias_attr_update),
 	AMDGPU_DEVICE_ATTR_RO(pm_metrics,				ATTR_FLAG_BASIC,
 			      .attr_update = amdgpu_pm_metrics_attr_update),
+	AMDGPU_DEVICE_ATTR_RO(apu,					ATTR_FLAG_BASIC),
 };
 
 static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_attr *attr,
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
index c12ced32f7808..ffd008c1e6ec2 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h
@@ -78,6 +78,7 @@ enum amdgpu_device_attr_id {
 	device_attr_id__smartshift_dgpu_power,
 	device_attr_id__smartshift_bias,
 	device_attr_id__pm_metrics,
+	device_attr_id__apu,
 	device_attr_id__count,
 };
 
-- 
2.43.0

