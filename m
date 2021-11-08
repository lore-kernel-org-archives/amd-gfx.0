Return-Path: <SRS0=P/1w=P4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83501C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 01:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F26861215
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Nov 2021 01:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F26861215
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1C189CC4;
	Tue,  9 Nov 2021 01:00:45 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A947989CBA;
 Tue,  9 Nov 2021 01:00:44 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB46D6120D;
 Tue,  9 Nov 2021 01:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636419644;
 bh=YN6xwZy/paczEow3ObgEpQ6WyRCEARqtGbMo+1NGYVc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oTdeAr4C/e18PkXscMa8cP0dGtuWKZIamFCh5PiBWexnbZdNIgMv02JgeVmm/WbGQ
 Gs+YM2zJJYE7zpZs7ebokTFIeIfM9wWt9xswDSBAaP2kSIOrR6Fo+9oJ+/8+a/3BMB
 7UQ0Gm7sFDC/u8ziUwhhe/VaBxnwAvcqFqmg7GWTjb/1HfrxV8aLyT0HS2KMCeiJVU
 0Lf5FwAaPfE5KeysJ8WGtaILSmdGd/ypGw4R9/Mggp6izvp+81eUwixAfAmRaGU9KG
 8Xf2XIi0lu2TKmfkOpgOesM18sfhvGpqGAIq7N1ybXF5BAodxiAOQETYS3KkuWspSn
 3ohB8QGjtJ0aw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 028/146] drm/amdgpu: Fix MMIO access page fault
Date: Mon,  8 Nov 2021 12:42:55 -0500
Message-Id: <20211108174453.1187052-28-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211108174453.1187052-1-sashal@kernel.org>
References: <20211108174453.1187052-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>,
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>, satyajit.sahu@amd.com,
 guchun.chen@amd.com, airlied@linux.ie, lee.jones@linaro.org, Oak.Zeng@amd.com,
 Xinhui.Pan@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 leo.liu@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

[ Upstream commit c03509cbc01559549700e14c4a6239f2572ab4ba ]

Add more guards to MMIO access post device
unbind/unplug

Bug: https://bugs.archlinux.org/task/72092?project=1&order=dateopened&sort=desc&pagenum=1
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 17 +++++++++++------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index f4686e918e0d1..c405075a572c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/firmware.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_vcn.h"
@@ -192,11 +193,14 @@ static int vcn_v2_0_sw_init(void *handle)
  */
 static int vcn_v2_0_sw_fini(void *handle)
 {
-	int r;
+	int r, idx;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
 
-	fw_shared->present_flag_0 = 0;
+	if (drm_dev_enter(&adev->ddev, &idx)) {
+		fw_shared->present_flag_0 = 0;
+		drm_dev_exit(idx);
+	}
 
 	amdgpu_virt_free_mm_table(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index e0c0c3734432e..a0956d8623770 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/firmware.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_vcn.h"
@@ -233,17 +234,21 @@ static int vcn_v2_5_sw_init(void *handle)
  */
 static int vcn_v2_5_sw_fini(void *handle)
 {
-	int i, r;
+	int i, r, idx;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	volatile struct amdgpu_fw_shared *fw_shared;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
-		fw_shared->present_flag_0 = 0;
+	if (drm_dev_enter(&adev->ddev, &idx)) {
+		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
+			if (adev->vcn.harvest_config & (1 << i))
+				continue;
+			fw_shared = adev->vcn.inst[i].fw_shared_cpu_addr;
+			fw_shared->present_flag_0 = 0;
+		}
+		drm_dev_exit(idx);
 	}
 
+
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
-- 
2.33.0

