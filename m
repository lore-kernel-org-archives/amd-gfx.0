Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADBAD5B170
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 01:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 012E310E0AD;
	Mon, 15 Dec 2025 01:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L9ulV/qR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A4A10E0AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E231640A9A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761E1C4CEF1;
 Mon, 15 Dec 2025 01:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765761156;
 bh=vEihxNlQ54wrIKHTp1xKuZ3XWOFSXuCA9scK3rPnuXU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L9ulV/qRMs0OXWiKgRdz/C38ybn8uDPPQMIhLiv0uySxScS6srVF9wtVkE8oY+aI/
 /0VwgD+M4ZyB2jwT1CeQAZIgH6YNrGzHYypOSYVx06DjWyqsNxwuths4S8QP/yIn5w
 KsFid/rmnvoLNClJiFdrTrIy09UlbHKDjKizXp4QwBQjlasJmJ4KmXs3gMnQ2UWaeZ
 Xx+clB8mX1cEcs5JdYwqs2V+h25q6bLvwoClTuYGVVKpkty7SmmyqU6aDMTD4wGFN3
 HBv9LbF46QdPFUgTl6Gczv4WHaBEhKf6C2gzrHyynRRPTrWVOVg70RW/wa/SjpCGcn
 zGsNAvwAu2ZxA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 7/9] drm/amd: Convert amdgpu_display from DRM_* to drm_ macros
Date: Sun, 14 Dec 2025 19:12:25 -0600
Message-ID: <20251215011227.161597-8-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215011227.161597-1-superm1@kernel.org>
References: <20251215011227.161597-1-superm1@kernel.org>
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

drm_* macros show the device they were called with which is helpful
in multi-GPU systems.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 40 ++++++++++-----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index f8b35c487b6c6..ee26e848f02d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -417,15 +417,15 @@ void amdgpu_display_print_display_setup(struct drm_device *dev)
 	int i = 0;
 
 	drm_connector_list_iter_begin(dev, &iter);
-	DRM_INFO("AMDGPU Display Connectors\n");
+	drm_info(dev, "AMDGPU Display Connectors\n");
 	drm_for_each_connector_iter(connector, &iter) {
 		amdgpu_connector = to_amdgpu_connector(connector);
-		DRM_INFO("Connector %d:\n", i);
-		DRM_INFO("  %s\n", connector->name);
+		drm_info(dev, "Connector %d:\n", i);
+		drm_info(dev, "  %s\n", connector->name);
 		if (amdgpu_connector->hpd.hpd != AMDGPU_HPD_NONE)
-			DRM_INFO("  %s\n", hpd_names[amdgpu_connector->hpd.hpd]);
+			drm_info(dev, "  %s\n", hpd_names[amdgpu_connector->hpd.hpd]);
 		if (amdgpu_connector->ddc_bus) {
-			DRM_INFO("  DDC: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+			drm_info(dev, "  DDC: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
 				 amdgpu_connector->ddc_bus->rec.mask_clk_reg,
 				 amdgpu_connector->ddc_bus->rec.mask_data_reg,
 				 amdgpu_connector->ddc_bus->rec.a_clk_reg,
@@ -435,11 +435,11 @@ void amdgpu_display_print_display_setup(struct drm_device *dev)
 				 amdgpu_connector->ddc_bus->rec.y_clk_reg,
 				 amdgpu_connector->ddc_bus->rec.y_data_reg);
 			if (amdgpu_connector->router.ddc_valid)
-				DRM_INFO("  DDC Router 0x%x/0x%x\n",
+				drm_info(dev, "  DDC Router 0x%x/0x%x\n",
 					 amdgpu_connector->router.ddc_mux_control_pin,
 					 amdgpu_connector->router.ddc_mux_state);
 			if (amdgpu_connector->router.cd_valid)
-				DRM_INFO("  Clock/Data Router 0x%x/0x%x\n",
+				drm_info(dev, "  Clock/Data Router 0x%x/0x%x\n",
 					 amdgpu_connector->router.cd_mux_control_pin,
 					 amdgpu_connector->router.cd_mux_state);
 		} else {
@@ -449,35 +449,35 @@ void amdgpu_display_print_display_setup(struct drm_device *dev)
 			    connector->connector_type == DRM_MODE_CONNECTOR_DVIA ||
 			    connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
 			    connector->connector_type == DRM_MODE_CONNECTOR_HDMIB)
-				DRM_INFO("  DDC: no ddc bus - possible BIOS bug - please report to xorg-driver-ati@lists.x.org\n");
+				drm_info(dev, "  DDC: no ddc bus - possible BIOS bug - please report to xorg-driver-ati@lists.x.org\n");
 		}
-		DRM_INFO("  Encoders:\n");
+		drm_info(dev, "  Encoders:\n");
 		list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
 			amdgpu_encoder = to_amdgpu_encoder(encoder);
 			devices = amdgpu_encoder->devices & amdgpu_connector->devices;
 			if (devices) {
 				if (devices & ATOM_DEVICE_CRT1_SUPPORT)
-					DRM_INFO("    CRT1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev, "    CRT1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_CRT2_SUPPORT)
-					DRM_INFO("    CRT2: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev, "    CRT2: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_LCD1_SUPPORT)
-					DRM_INFO("    LCD1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev, "    LCD1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP1_SUPPORT)
-					DRM_INFO("    DFP1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev, "    DFP1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP2_SUPPORT)
-					DRM_INFO("    DFP2: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev, "    DFP2: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP3_SUPPORT)
-					DRM_INFO("    DFP3: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev, "    DFP3: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP4_SUPPORT)
-					DRM_INFO("    DFP4: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev, "    DFP4: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP5_SUPPORT)
-					DRM_INFO("    DFP5: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev, "    DFP5: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_DFP6_SUPPORT)
-					DRM_INFO("    DFP6: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev, "    DFP6: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_TV1_SUPPORT)
-					DRM_INFO("    TV1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev, "    TV1: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
 				if (devices & ATOM_DEVICE_CV_SUPPORT)
-					DRM_INFO("    CV: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
+					drm_info(dev, "    CV: %s\n", encoder_names[amdgpu_encoder->encoder_id]);
 			}
 		}
 		i++;
-- 
2.43.0

