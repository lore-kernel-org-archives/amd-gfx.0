Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57FDC36013
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A9D610E944;
	Thu, 27 Mar 2025 20:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DVYPsNxa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA43E10E942
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C4DEB614C1;
 Thu, 27 Mar 2025 20:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7021CC4CEDD;
 Thu, 27 Mar 2025 20:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107953;
 bh=WGAL56aAoKtDSncqn93Cns4Wlz4HioAxjzdvlv4HpL0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DVYPsNxakuUIBmKgaxqVm/6WzRMXav7SFm8FT/f2k/YF0oUqPxlWDA6GcAB9yvYbo
 wEDuT/vobAoBj5m7lOT9AnJMAxbsNa/TZiKeamL4Gk4y4mRYnQdZutDqyR7/aigKi6
 1d/cf4dpyOS3Qh3QcVTK5lFc4pXrTJ/pmzT1X8cYYBCsm5owRF8Fm7eEOgE1RLVvoy
 bHjdRio4vQSw9nHy9+o9yCO6IFDK/2F693CPrdLx9f2CHah/0XVJlyKedNTs2Mlkob
 hs/5gzGycr46ciUfXC4zs+06n8K9ZhkoDrYqy3GH35eOIF0OSGQ/KfjbfgIs1lncei
 6OjS9UMs/7EIQ==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 09/14] drm/amd: Adjust amdgpu connector messages from DRM_*()
 to drm_*()
Date: Thu, 27 Mar 2025 15:38:53 -0500
Message-ID: <20250327203858.3796086-10-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
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

Messages emitted from amdgpu connector are currently with legacy DRM
macros. These don't show which device they are using. To make messages
clearer in multi-GPU systems adjust to drm_*() macros.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 344e0a9ee08a9..2521220e21f93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -882,7 +882,7 @@ amdgpu_connector_vga_detect(struct drm_connector *connector, bool force)
 		amdgpu_connector_get_edid(connector);
 
 		if (!amdgpu_connector->edid) {
-			DRM_ERROR("%s: probed a monitor but no|invalid EDID\n",
+			drm_err(connector->dev, "%s: probed a monitor but no|invalid EDID\n",
 					connector->name);
 			ret = connector_status_connected;
 		} else {
@@ -1063,7 +1063,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 		amdgpu_connector_get_edid(connector);
 
 		if (!amdgpu_connector->edid) {
-			DRM_ERROR("%s: probed a monitor but no|invalid EDID\n",
+			drm_err(adev_to_drm(adev), "%s: probed a monitor but no|invalid EDID\n",
 					connector->name);
 			ret = connector_status_connected;
 			broken_edid = true; /* defer use_digital to later */
@@ -1638,7 +1638,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 	if (router->ddc_valid || router->cd_valid) {
 		amdgpu_connector->router_bus = amdgpu_i2c_lookup(adev, &router->i2c_info);
 		if (!amdgpu_connector->router_bus)
-			DRM_ERROR("Failed to assign router i2c bus! Check dmesg for i2c errors.\n");
+			drm_err(adev_to_drm(adev), "Failed to assign router i2c bus! Check dmesg for i2c errors.\n");
 	}
 
 	if (is_dp_bridge) {
@@ -1652,7 +1652,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 				has_aux = true;
 				ddc = &amdgpu_connector->ddc_bus->adapter;
 			} else {
-				DRM_ERROR("DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+				drm_err(adev_to_drm(adev), "DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 			}
 		}
 		switch (connector_type) {
@@ -1746,7 +1746,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 			if (i2c_bus->valid) {
 				amdgpu_connector->ddc_bus = amdgpu_i2c_lookup(adev, i2c_bus);
 				if (!amdgpu_connector->ddc_bus)
-					DRM_ERROR("VGA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev), "VGA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				else
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 			}
@@ -1771,7 +1771,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 			if (i2c_bus->valid) {
 				amdgpu_connector->ddc_bus = amdgpu_i2c_lookup(adev, i2c_bus);
 				if (!amdgpu_connector->ddc_bus)
-					DRM_ERROR("DVIA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev), "DVIA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				else
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 			}
@@ -1801,7 +1801,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 			if (i2c_bus->valid) {
 				amdgpu_connector->ddc_bus = amdgpu_i2c_lookup(adev, i2c_bus);
 				if (!amdgpu_connector->ddc_bus)
-					DRM_ERROR("DVI: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev), "DVI: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				else
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 			}
@@ -1857,7 +1857,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 			if (i2c_bus->valid) {
 				amdgpu_connector->ddc_bus = amdgpu_i2c_lookup(adev, i2c_bus);
 				if (!amdgpu_connector->ddc_bus)
-					DRM_ERROR("HDMI: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev), "HDMI: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				else
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 			}
@@ -1908,7 +1908,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 					has_aux = true;
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 				} else {
-					DRM_ERROR("DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev), "DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				}
 			}
 			drm_connector_init_with_ddc(dev, &amdgpu_connector->base,
@@ -1956,7 +1956,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 					has_aux = true;
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 				} else {
-					DRM_ERROR("DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev), "DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				}
 			}
 			drm_connector_init_with_ddc(dev, &amdgpu_connector->base,
@@ -1979,7 +1979,7 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 			if (i2c_bus->valid) {
 				amdgpu_connector->ddc_bus = amdgpu_i2c_lookup(adev, i2c_bus);
 				if (!amdgpu_connector->ddc_bus)
-					DRM_ERROR("LVDS: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev), "LVDS: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				else
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 			}
-- 
2.43.0

