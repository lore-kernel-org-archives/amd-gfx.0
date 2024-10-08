Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090A9CED263
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 04:00:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D8910E359;
	Tue,  8 Oct 2024 04:00:01 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8674D10E359
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 04:00:00 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 4983xt33595715; Tue, 8 Oct 2024 09:29:55 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 4983xsOs595714;
 Tue, 8 Oct 2024 09:29:54 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: fix dm_suspend/resume arguments to ip_block
Date: Tue,  8 Oct 2024 09:29:53 +0530
Message-Id: <20241008035953.595701-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

"build failure after merge of the amdgpu tree"
dm_suspend/dm_resume functions argument mismatch
not caught in validation as it was under config
CONFIG_DEBUG_KERNEL_DC which wasnt enabled by
default.

Change argument from adev to ip_block.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e4511f2fb929..6d5b899941af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5201,15 +5201,20 @@ static ssize_t s3_debug_store(struct device *device,
 	int s3_state;
 	struct drm_device *drm_dev = dev_get_drvdata(device);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	struct amdgpu_ip_block *ip_block;
+
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_DCE);
+	if (!ip_block)
+		return -EINVAL;
 
 	ret = kstrtoint(buf, 0, &s3_state);
 
 	if (ret == 0) {
 		if (s3_state) {
-			dm_resume(adev);
+			dm_resume(ip_block);
 			drm_kms_helper_hotplug_event(adev_to_drm(adev));
 		} else
-			dm_suspend(adev);
+			dm_suspend(ip_block);
 	}
 
 	return ret == 0 ? count : 0;
-- 
2.34.1

