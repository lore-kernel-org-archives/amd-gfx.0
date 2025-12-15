Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A70D5B172
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 01:12:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A97B10E0D7;
	Mon, 15 Dec 2025 01:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hUIrZcFi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F37A10E0D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 61BA36013F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D75C4CEF1;
 Mon, 15 Dec 2025 01:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765761158;
 bh=C1OQ2YwjHQVXtJgr4gnp1PacLqe33RfvGT+AP4CI/xs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hUIrZcFiKSIfFuXiHbzAfG1KvNv6Ox1sCxZWinNtkjOyciZjex9NXtU/QgBN75PW5
 /a7Vq1TbZVURzGpBsOyhrAQPJE4UE606KF77DfSXrkiOr6rwH0abtUbdYs21am2veU
 R46S+CIL67Q78Nn1ASs8keP+rmnRpQ9ZLScc7fOvw2Boo0oc/3oLGdIfqp4LeOC5pD
 nmRB24WgX3Lm607zXJcSFmuWlzn4R5fU7sse6z8hl/OgvvjanSaTPNSdWg5WdaP77G
 9EkBtC7cDgt7facppIGAL+/Arvx2G8dQ6AwPPh3sj4vBWYYBC1TRjLJot+b4dLxU5g
 DELBoXfERdr9w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 9/9] drm/amd: Convert DRM_*() to drm_*()
Date: Sun, 14 Dec 2025 19:12:27 -0600
Message-ID: <20251215011227.161597-10-superm1@kernel.org>
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

The drm_*() macros include the device which is helpful for debugging
issues in multi-GPU systems.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |  9 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c       |  7 ++--
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 34 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c       | 12 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       | 14 +++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   | 12 ++++---
 .../gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c  |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  4 +--
 .../drm/amd/amdgpu/amdgpu_fw_attestation.c    | 11 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 10 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  7 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |  4 ++-
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  6 ++--
 drivers/gpu/drm/amd/amdgpu/cik.c              |  8 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  8 ++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 15 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |  4 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         | 12 +++----
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |  4 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c        |  6 ++--
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c         |  6 ++--
 drivers/gpu/drm/amd/amdgpu/si.c               |  8 ++---
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c    |  8 +++--
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c         |  9 ++---
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |  4 +--
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         | 14 ++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  8 ++---
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |  6 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |  8 ++---
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |  6 ++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  4 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |  8 +++--
 .../link/protocols/link_edp_panel_control.c   |  9 +++--
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 20 +++++------
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  5 ++-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |  7 ++--
 61 files changed, 210 insertions(+), 177 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 61aa0ebec63e5..3b0cb8ec471cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -745,7 +745,8 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
 
 		size = *(u16 *) info->buffer.pointer;
 		if (size < 3) {
-			DRM_INFO("ATCS buffer is too small: %zu\n", size);
+			drm_info(adev_to_drm(adev),
+				"ATCS buffer is too small: %zu\n", size);
 			kfree(info);
 			return -EINVAL;
 		}
@@ -804,7 +805,7 @@ int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
 
 	info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_POWER_SHIFT_CONTROL, &params);
 	if (!info) {
-		DRM_ERROR("ATCS PSC update failed\n");
+		drm_err(adev_to_drm(adev), "ATCS PSC call failed\n");
 		return -EIO;
 	}
 
@@ -1121,10 +1122,8 @@ int amdgpu_acpi_enumerate_xcc(void)
 
 		xcc_info = kzalloc(sizeof(struct amdgpu_acpi_xcc_info),
 				   GFP_KERNEL);
-		if (!xcc_info) {
-			DRM_ERROR("Failed to allocate memory for xcc info\n");
+		if (!xcc_info)
 			return -ENOMEM;
-		}
 
 		INIT_LIST_HEAD(&xcc_info->list);
 		xcc_info->handle = acpi_device_handle(acpi_dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index a2879d2b7c8ec..67a01c4f38855 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -683,7 +683,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
 
 	if (ret) {
-		DRM_ERROR("amdgpu: failed to schedule IB.\n");
+		drm_err(adev_to_drm(adev), "failed to schedule IB.\n");
 		goto err_ib_sched;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 004a6a9d6b9fa..09c8942c22d3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -349,7 +349,7 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 				strscpy(fw_name, "amdgpu/vega20_smc.bin");
 				break;
 			default:
-				DRM_ERROR("SMC firmware not supported\n");
+				drm_err(adev_to_drm(adev), "SMC firmware not supported\n");
 				return -EINVAL;
 			}
 
@@ -357,7 +357,8 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 						   AMDGPU_UCODE_REQUIRED,
 						   "%s", fw_name);
 			if (err) {
-				DRM_ERROR("Failed to load firmware \"%s\"", fw_name);
+				drm_err(adev_to_drm(adev),
+					"Failed to load firmware \"%s\"\n", fw_name);
 				amdgpu_ucode_release(&adev->pm.fw);
 				return err;
 			}
@@ -402,7 +403,7 @@ struct cgs_device *amdgpu_cgs_create_device(struct amdgpu_device *adev)
 		kmalloc(sizeof(*cgs_device), GFP_KERNEL);
 
 	if (!cgs_device) {
-		DRM_ERROR("Couldn't allocate CGS device structure\n");
+		drm_err(adev_to_drm(adev), "Couldn't allocate CGS device structure\n");
 		return NULL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 47e9bfba06424..8851d7e6784d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -879,8 +879,9 @@ amdgpu_connector_vga_detect(struct drm_connector *connector, bool force)
 		amdgpu_connector_get_edid(connector);
 
 		if (!amdgpu_connector->edid) {
-			DRM_ERROR("%s: probed a monitor but no|invalid EDID\n",
-					connector->name);
+			drm_err(connector->dev,
+				"%s: probed a monitor but no|invalid EDID\n",
+				connector->name);
 			ret = connector_status_connected;
 		} else {
 			amdgpu_connector->use_digital =
@@ -1060,7 +1061,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 		amdgpu_connector_get_edid(connector);
 
 		if (!amdgpu_connector->edid) {
-			DRM_ERROR("%s: probed a monitor but no|invalid EDID\n",
+			drm_err(adev_to_drm(adev), "%s: probed a monitor but no|invalid EDID\n",
 					connector->name);
 			ret = connector_status_connected;
 			broken_edid = true; /* defer use_digital to later */
@@ -1675,7 +1676,8 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 	if (router->ddc_valid || router->cd_valid) {
 		amdgpu_connector->router_bus = amdgpu_i2c_lookup(adev, &router->i2c_info);
 		if (!amdgpu_connector->router_bus)
-			DRM_ERROR("Failed to assign router i2c bus! Check dmesg for i2c errors.\n");
+			drm_err(adev_to_drm(adev),
+				"Failed to assign router i2c bus! Check dmesg for i2c errors.\n");
 	}
 
 	if (is_dp_bridge) {
@@ -1689,7 +1691,8 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 				has_aux = true;
 				ddc = &amdgpu_connector->ddc_bus->adapter;
 			} else {
-				DRM_ERROR("DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+				drm_err(adev_to_drm(adev),
+					"DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 			}
 		}
 		switch (connector_type) {
@@ -1783,7 +1786,8 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 			if (i2c_bus->valid) {
 				amdgpu_connector->ddc_bus = amdgpu_i2c_lookup(adev, i2c_bus);
 				if (!amdgpu_connector->ddc_bus)
-					DRM_ERROR("VGA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev),
+						"VGA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				else
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 			}
@@ -1808,7 +1812,8 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 			if (i2c_bus->valid) {
 				amdgpu_connector->ddc_bus = amdgpu_i2c_lookup(adev, i2c_bus);
 				if (!amdgpu_connector->ddc_bus)
-					DRM_ERROR("DVIA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev),
+						"DVIA: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				else
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 			}
@@ -1838,7 +1843,8 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 			if (i2c_bus->valid) {
 				amdgpu_connector->ddc_bus = amdgpu_i2c_lookup(adev, i2c_bus);
 				if (!amdgpu_connector->ddc_bus)
-					DRM_ERROR("DVI: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev),
+						"DVI: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				else
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 			}
@@ -1894,7 +1900,8 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 			if (i2c_bus->valid) {
 				amdgpu_connector->ddc_bus = amdgpu_i2c_lookup(adev, i2c_bus);
 				if (!amdgpu_connector->ddc_bus)
-					DRM_ERROR("HDMI: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev),
+						"HDMI: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				else
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 			}
@@ -1945,7 +1952,8 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 					has_aux = true;
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 				} else {
-					DRM_ERROR("DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev),
+						"DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				}
 			}
 			drm_connector_init_with_ddc(dev, &amdgpu_connector->base,
@@ -1993,7 +2001,8 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 					has_aux = true;
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 				} else {
-					DRM_ERROR("DP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev),
+						"eDP: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				}
 			}
 			drm_connector_init_with_ddc(dev, &amdgpu_connector->base,
@@ -2016,7 +2025,8 @@ amdgpu_connector_add(struct amdgpu_device *adev,
 			if (i2c_bus->valid) {
 				amdgpu_connector->ddc_bus = amdgpu_i2c_lookup(adev, i2c_bus);
 				if (!amdgpu_connector->ddc_bus)
-					DRM_ERROR("LVDS: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
+					drm_err(adev_to_drm(adev),
+						"LVDS: Failed to assign ddc bus! Check dmesg for i2c errors.\n");
 				else
 					ddc = &amdgpu_connector->ddc_bus->adapter;
 			}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index dfb6cfd837606..a25ad16a31985 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -76,7 +76,8 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r)) {
-			DRM_ERROR("failed to reserve CSA,PD BOs: err=%d\n", r);
+			drm_err(adev_to_drm(adev),
+				"failed to reserve CSA,PD BOs: err=%d\n", r);
 			goto error;
 		}
 	}
@@ -92,7 +93,8 @@ int amdgpu_map_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			     AMDGPU_VM_PAGE_EXECUTABLE);
 
 	if (r) {
-		DRM_ERROR("failed to do bo_map on static CSA, err=%d\n", r);
+		drm_err(adev_to_drm(adev),
+			"failed to do bo_map on static CSA, err=%d\n", r);
 		amdgpu_vm_bo_del(adev, *bo_va);
 		goto error;
 	}
@@ -116,14 +118,16 @@ int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			r = drm_exec_lock_obj(&exec, &bo->tbo.base);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(r)) {
-			DRM_ERROR("failed to reserve CSA,PD BOs: err=%d\n", r);
+			drm_err(adev_to_drm(adev),
+				"failed to reserve CSA,PD BOs: err=%d\n", r);
 			goto error;
 		}
 	}
 
 	r = amdgpu_vm_bo_unmap(adev, bo_va, csa_addr);
 	if (r) {
-		DRM_ERROR("failed to do bo_unmap on static CSA, err=%d\n", r);
+		drm_err(adev_to_drm(adev),
+			"failed to do bo_unmap on static CSA, err=%d\n", r);
 		goto error;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index afedea02188dd..5c344665b43cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -438,18 +438,21 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 	struct drm_sched_entity *ctx_entity;
 
 	if (hw_ip >= AMDGPU_HW_IP_NUM) {
-		DRM_ERROR("unknown HW IP type: %d\n", hw_ip);
+		drm_err(adev_to_drm(ctx->mgr->adev),
+			"unknown HW IP type: %d\n", hw_ip);
 		return -EINVAL;
 	}
 
 	/* Right now all IPs have only one instance - multiple rings. */
 	if (instance != 0) {
-		DRM_DEBUG("invalid ip instance: %d\n", instance);
+		drm_dbg(adev_to_drm(ctx->mgr->adev),
+			"invalid ip instance: %d\n", instance);
 		return -EINVAL;
 	}
 
 	if (ring >= amdgpu_ctx_num_entities[hw_ip]) {
-		DRM_DEBUG("invalid ring: %d %d\n", hw_ip, ring);
+		drm_dbg(adev_to_drm(ctx->mgr->adev),
+			"invalid ring: %d %d\n", hw_ip, ring);
 		return -EINVAL;
 	}
 
@@ -874,7 +877,8 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
 
 	r = dma_fence_wait(other, true);
 	if (r < 0 && r != -ERESTARTSYS)
-		DRM_ERROR("Error (%ld) waiting for fence!\n", r);
+		drm_err(adev_to_drm(ctx->mgr->adev),
+			"AMDGPU: Error waiting for fence in ctx %p\n", ctx);
 
 	dma_fence_put(other);
 	return r;
@@ -929,7 +933,7 @@ static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 
 	idr_for_each_entry(idp, ctx, id) {
 		if (kref_read(&ctx->refcount) != 1) {
-			DRM_ERROR("ctx %p is still alive\n", ctx);
+			drm_err(adev_to_drm(mgr->adev), "ctx %p is still alive\n", ctx);
 			continue;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index d3a5189bd512b..1f3e52637326b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1945,7 +1945,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	/* preempt the IB */
 	r = amdgpu_ring_preempt_ib(ring);
 	if (r) {
-		DRM_WARN("failed to preempt ring %d\n", ring->idx);
+		drm_warn(adev_to_drm(adev), "failed to preempt ring %d\n", ring->idx);
 		goto failure;
 	}
 
@@ -1953,7 +1953,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 
 	if (atomic_read(&ring->fence_drv.last_seq) !=
 	    ring->fence_drv.sync_seq) {
-		DRM_INFO("ring %d was preempted\n", ring->idx);
+		drm_info(adev_to_drm(adev), "ring %d was preempted\n", ring->idx);
 
 		amdgpu_ib_preempt_mark_partial_job(ring);
 
@@ -2041,14 +2041,16 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	ent = debugfs_create_file("amdgpu_preempt_ib", 0600, root, adev,
 				  &fops_ib_preempt);
 	if (IS_ERR(ent)) {
-		DRM_ERROR("unable to create amdgpu_preempt_ib debugsfs file\n");
+		drm_err(adev_to_drm(adev),
+			"unable to create amdgpu_preempt_ib debugsfs file\n");
 		return PTR_ERR(ent);
 	}
 
 	ent = debugfs_create_file("amdgpu_force_sclk", 0200, root, adev,
 				  &fops_sclk_set);
 	if (IS_ERR(ent)) {
-		DRM_ERROR("unable to create amdgpu_set_sclk debugsfs file\n");
+		drm_err(adev_to_drm(adev),
+			"unable to create amdgpu_set_sclk debugsfs file\n");
 		return PTR_ERR(ent);
 	}
 
@@ -2061,7 +2063,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 	r = amdgpu_debugfs_regs_init(adev);
 	if (r)
-		DRM_ERROR("registering register debugfs failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "registering register debugfs failed (%d).\n", r);
 
 	amdgpu_debugfs_firmware_init(adev);
 	amdgpu_ta_if_debugfs_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 8a026bc9ea44f..0bb430853a9f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -334,11 +334,8 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	struct drm_sched_job *s_job;
 
 	coredump = kzalloc(sizeof(*coredump), GFP_NOWAIT);
-
-	if (!coredump) {
-		DRM_ERROR("%s: failed to allocate memory for coredump\n", __func__);
+	if (!coredump)
 		return;
-	}
 
 	coredump->skip_vram_check = skip_vram_check;
 	coredump->reset_vram_lost = vram_lost;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index d681ba6595039..30b29a35aff45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6548,7 +6548,7 @@ static int amdgpu_device_sched_resume(struct list_head *device_list,
 			    !amdgpu_ras_eeprom_check_err_threshold(tmp_adev))
 				dev_info(
 					tmp_adev->dev,
-					"GPU reset(%d) failed with error %d \n",
+					"GPU reset(%d) failed with error %d\n",
 					atomic_read(
 						&tmp_adev->gpu_reset_counter),
 					tmp_adev->asic_reset_res);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f520f7450d795..ccf6ed3310c2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2402,7 +2402,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		supports_atomic = true;
 
 	if ((flags & AMD_EXP_HW_SUPPORT) && !amdgpu_exp_hw_support) {
-		DRM_INFO("This hardware requires experimental hardware support.\n"
+		drm_info(adev_to_drm(adev), "This hardware requires experimental hardware support.\n"
 			 "See modparam exp_hw_support\n");
 		return -ENODEV;
 	}
@@ -2449,7 +2449,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 retry_init:
 	ret = drm_dev_register(ddev, flags);
 	if (ret == -EAGAIN && ++retry <= 3) {
-		DRM_INFO("retry init %d\n", retry);
+		drm_info(adev_to_drm(adev), "retry init %d\n", retry);
 		/* Don't request EX mode too frequently which is attacking */
 		msleep(5000);
 		goto retry_init;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
index 328a1b9635481..988ec7d7b4874 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c
@@ -62,17 +62,17 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
 	struct FW_ATT_RECORD fw_att_record = {0};
 
 	if (size < sizeof(struct FW_ATT_RECORD)) {
-		DRM_WARN("FW attestation input buffer not enough memory");
+		drm_warn(adev_to_drm(adev), "FW attestation input buffer not enough memory");
 		return -EINVAL;
 	}
 
 	if ((*pos + sizeof(struct FW_ATT_DB_HEADER)) >= FW_ATTESTATION_MAX_SIZE) {
-		DRM_WARN("FW attestation out of bounds");
+		drm_warn(adev_to_drm(adev), "FW attestation out of bounds");
 		return 0;
 	}
 
 	if (psp_get_fw_attestation_records_addr(&adev->psp, &records_addr)) {
-		DRM_WARN("Failed to get FW attestation record address");
+		drm_warn(adev_to_drm(adev), "Failed to get FW attestation record address");
 		return -EINVAL;
 	}
 
@@ -86,11 +86,12 @@ static ssize_t amdgpu_fw_attestation_debugfs_read(struct file *f,
 					  false);
 
 		if (fw_att_hdr.AttDbCookie != FW_ATTESTATION_DB_COOKIE) {
-			DRM_WARN("Invalid FW attestation cookie");
+			drm_warn(adev_to_drm(adev), "Invalid FW attestation cookie");
 			return -EINVAL;
 		}
 
-		DRM_INFO("FW attestation version = 0x%X", fw_att_hdr.AttDbVersion);
+		drm_info(adev_to_drm(adev), "FW attestation version = 0x%X",
+			fw_att_hdr.AttDbVersion);
 	}
 
 	amdgpu_device_vram_access(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index d2237ce9da70e..16c3b78e50cbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -476,7 +476,7 @@ int amdgpu_gart_init(struct amdgpu_device *adev)
 	/* Compute table size */
 	adev->gart.num_cpu_pages = adev->gmc.gart_size / PAGE_SIZE;
 	adev->gart.num_gpu_pages = adev->gmc.gart_size / AMDGPU_GPU_PAGE_SIZE;
-	DRM_INFO("GART: num cpu pages %u, num gpu pages %u\n",
+	drm_info(adev_to_drm(adev), "GART: num cpu pages %u, num gpu pages %u\n",
 		 adev->gart.num_cpu_pages, adev->gart.num_gpu_pages);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index fb15f5b1d474e..6abe5103a78dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -125,7 +125,7 @@ void amdgpu_gfx_parse_disable_cu(struct amdgpu_device *adev, unsigned int *mask,
 		int ret = sscanf(p, "%u.%u.%u", &se, &sh, &cu);
 
 		if (ret < 3) {
-			DRM_ERROR("amdgpu: could not parse disable_cu\n");
+			drm_err(adev_to_drm(adev), "could not parse disable_cu\n");
 			return;
 		}
 
@@ -134,7 +134,7 @@ void amdgpu_gfx_parse_disable_cu(struct amdgpu_device *adev, unsigned int *mask,
 			mask[se * max_sh + sh] |= 1u << cu;
 		} else {
 			drm_err(adev_to_drm(adev), "disable_cu %u.%u.%u is out of range\n",
-			          se, sh, cu);
+				se, sh, cu);
 		}
 
 		next = strchr(p, ',');
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 8a90b7ba59e6b..224d620a860da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -92,7 +92,7 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
 		return;
 
 	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DRV_UNLOAD))
-		DRM_WARN("smart shift update failed\n");
+		drm_warn(dev, "smart shift update failed\n");
 
 	amdgpu_acpi_fini(adev);
 	amdgpu_device_fini_hw(adev);
@@ -105,7 +105,7 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 	mutex_lock(&mgpu_info.mutex);
 
 	if (mgpu_info.num_gpu >= MAX_GPU_INSTANCE) {
-		DRM_ERROR("Cannot register more gpu instance\n");
+		drm_err(adev_to_drm(adev), "Cannot register more gpu instance\n");
 		mutex_unlock(&mgpu_info.mutex);
 		return;
 	}
@@ -162,7 +162,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		dev_dbg(dev->dev, "Error during ACPI methods call\n");
 
 	if (amdgpu_acpi_smart_shift_update(adev, AMDGPU_SS_DRV_LOAD))
-		DRM_WARN("smart shift update failed\n");
+		drm_warn(dev, "smart shift update failed\n");
 
 out:
 	if (r)
@@ -1476,7 +1476,9 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, file_priv, adev);
 	if (r)
-		DRM_WARN("Can't setup usermode queues, use legacy workload submission only\n");
+		drm_warn(adev_to_drm(adev),
+			 "Failed to init usermode queue manager (%d), use legacy workload submission only\n",
+			 r);
 
 	r = amdgpu_eviction_fence_init(&fpriv->evf_mgr);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 415d8d88bbb63..b676310ce9acd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1081,10 +1081,10 @@ int amdgpu_bo_init(struct amdgpu_device *adev)
 				adev->gmc.aper_size);
 	}
 
-	DRM_INFO("Detected VRAM RAM=%lluM, BAR=%lluM\n",
+	drm_info(adev_to_drm(adev), "Detected VRAM RAM=%lluM, BAR=%lluM\n",
 		 adev->gmc.mc_vram_size >> 20,
 		 (unsigned long long)adev->gmc.aper_size >> 20);
-	DRM_INFO("RAM width %dbits %s\n",
+	drm_info(adev_to_drm(adev), "RAM width %dbits %s\n",
 		 adev->gmc.vram_width, amdgpu_vram_names[adev->gmc.vram_type]);
 	return amdgpu_ttm_init(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 83194eb6344a6..f7d05ec5e937f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4418,10 +4418,10 @@ static int amdgpu_persistent_edc_harvesting(struct amdgpu_device *adev,
 		return 0;
 
 	if (amdgpu_ras_query_error_status(adev, &info) != 0)
-		DRM_WARN("RAS init harvest failure");
+		drm_warn(adev_to_drm(adev), "RAS init query failure");
 
 	if (amdgpu_ras_reset_error_status(adev, ras_block->block) != 0)
-		DRM_WARN("RAS init harvest reset failure");
+		drm_warn(adev_to_drm(adev), "RAS init harvest reset failure");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8b33966a745f4..f2b4c0022dcc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2197,7 +2197,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 				AMDGPU_GEM_DOMAIN_GTT,
 				&adev->mman.sdma_access_bo, NULL,
 				&adev->mman.sdma_access_ptr))
-		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
+		drm_warn(adev_to_drm(adev),
+				"Debug VRAM access will use slowpath MM access\n");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 5c38f0d30c87a..9d5cca7da1d9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -279,7 +279,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 
 		version_major = (le32_to_cpu(hdr->ucode_version) >> 24) & 0xff;
 		version_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
-		DRM_INFO("Found UVD firmware Version: %u.%u Family ID: %u\n",
+		drm_info(adev_to_drm(adev), "Found UVD firmware Version: %u.%u Family ID: %u\n",
 			version_major, version_minor, family_id);
 
 		/*
@@ -306,7 +306,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		dec_minor = (le32_to_cpu(hdr->ucode_version) >> 8) & 0xff;
 		enc_minor = (le32_to_cpu(hdr->ucode_version) >> 24) & 0x3f;
 		enc_major = (le32_to_cpu(hdr->ucode_version) >> 30) & 0x3;
-		DRM_INFO("Found UVD firmware ENC: %u.%u DEC: .%u Family ID: %u\n",
+		drm_info(adev_to_drm(adev), "Found UVD firmware ENC: %u.%u DEC: .%u Family ID: %u\n",
 			enc_major, enc_minor, dec_minor, family_id);
 
 		adev->uvd.max_handles = AMDGPU_MAX_UVD_HANDLES;
@@ -467,7 +467,8 @@ int amdgpu_uvd_prepare_suspend(struct amdgpu_device *adev)
 int amdgpu_uvd_suspend(struct amdgpu_device *adev)
 {
 	if (amdgpu_ras_intr_triggered())
-		DRM_WARN("UVD VCPU state may lost due to RAS ERREVENT_ATHUB_INTERRUPT\n");
+		drm_warn(adev_to_drm(adev),
+			"UVD VCPU state may lost due to RAS ERREVENT_ATHUB_INTERRUPT\n");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index 79bad9cbe2abd..e548dc9708a22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -53,7 +53,9 @@ static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *timer)
 	ret_overrun = hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
 					  output->period_ns);
 	if (ret_overrun != 1)
-		DRM_WARN("%s: vblank timer overrun\n", __func__);
+		drm_warn(amdgpu_crtc->base.dev,
+			 "%s: vblank timer overrun count: %llu\n",
+			 __func__, ret_overrun);
 
 	ret = drm_crtc_handle_vblank(crtc);
 	/* Don't queue timer again when vblank is disabled. */
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index a51f3414b65dd..34644cab6cff5 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -218,7 +218,7 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 	bd->props.power = BACKLIGHT_POWER_ON;
 	backlight_update_status(bd);
 
-	DRM_INFO("amdgpu atom DIG backlight initialized\n");
+	drm_info(adev_to_drm(adev), "ATOM DIG backlight initialized\n");
 
 	return;
 
@@ -256,7 +256,7 @@ amdgpu_atombios_encoder_fini_backlight(struct amdgpu_encoder *amdgpu_encoder)
 		backlight_device_unregister(bd);
 		kfree(pdata);
 
-		DRM_INFO("amdgpu atom LVDS backlight unloaded\n");
+		drm_info(adev_to_drm(adev), "ATOM LVDS backlight unloaded\n");
 	}
 }
 
@@ -1724,7 +1724,7 @@ amdgpu_atombios_encoder_dac_detect(struct drm_encoder *encoder,
 	uint32_t bios_0_scratch;
 
 	if (!amdgpu_atombios_encoder_dac_load_detect(encoder, connector)) {
-		DRM_DEBUG_KMS("detect returned false \n");
+		DRM_DEBUG_KMS("detect returned false\n");
 		return connector_status_unknown;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index fc0d2524b16fa..c081784a19c4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1552,16 +1552,16 @@ static void cik_pcie_gen3_enable(struct amdgpu_device *adev)
 		PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
 		if (current_data_rate == 2) {
-			DRM_INFO("PCIE gen 3 link speeds already enabled\n");
+			drm_info(adev_to_drm(adev), "PCIE gen 3 link speeds already enabled\n");
 			return;
 		}
-		DRM_INFO("enabling PCIE gen 3 link speeds, disable with amdgpu.pcie_gen2=0\n");
+		drm_info(adev_to_drm(adev), "enabling PCIE gen 3 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	} else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) {
 		if (current_data_rate == 1) {
-			DRM_INFO("PCIE gen 2 link speeds already enabled\n");
+			drm_info(adev_to_drm(adev), "PCIE gen 2 link speeds already enabled\n");
 			return;
 		}
-		DRM_INFO("enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
+		drm_info(adev_to_drm(adev), "enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	}
 
 	if (!pci_is_pcie(root) || !pci_is_pcie(adev->pdev))
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 7501b4a7efb55..41bbedb8e157e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4170,7 +4170,7 @@ static void gfx_v10_0_check_fw_write_wait(struct amdgpu_device *adev)
 	}
 
 	if (!adev->gfx.cp_fw_write_wait)
-		DRM_WARN_ONCE("CP firmware version too old, please update!");
+		drm_warn_once(adev_to_drm(adev), "CP firmware version too old, please update!");
 }
 
 static bool gfx_v10_0_navi10_gfxoff_should_enable(struct amdgpu_device *adev)
@@ -9385,7 +9385,7 @@ static int gfx_v10_0_bad_op_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal opcode in command stream \n");
+	DRM_ERROR("Illegal opcode in command stream\n");
 	gfx_v10_0_handle_priv_fault(adev, entry);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 78096da317531..08e9004593925 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4789,7 +4789,7 @@ static int gfx_v11_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.is_poweron = true;
 
 	if(get_gb_addr_config(adev))
-		DRM_WARN("Invalid gb_addr_config !\n");
+		drm_warn(adev_to_drm(adev), "Invalid gb_addr_config !\n");
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP &&
 	    adev->gfx.rs64_enable)
@@ -6659,7 +6659,7 @@ static int gfx_v11_0_bad_op_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal opcode in command stream \n");
+	DRM_ERROR("Illegal opcode in command stream\n");
 	gfx_v11_0_handle_priv_fault(adev, entry);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index b1441d38f376f..6cd16f016c374 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3657,7 +3657,7 @@ static int gfx_v12_0_hw_init(struct amdgpu_ip_block *ip_block)
 	adev->gfx.is_poweron = true;
 
 	if (get_gb_addr_config(adev))
-		DRM_WARN("Invalid gb_addr_config !\n");
+		drm_warn(adev_to_drm(adev), "Invalid gb_addr_config !\n");
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
 		gfx_v12_0_config_gfx_rs64(adev);
@@ -5046,7 +5046,7 @@ static int gfx_v12_0_bad_op_irq(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
 				struct amdgpu_iv_entry *entry)
 {
-	DRM_ERROR("Illegal opcode in command stream \n");
+	DRM_ERROR("Illegal opcode in command stream\n");
 	gfx_v12_0_handle_priv_fault(adev, entry);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index fd89fb5028a50..73223d97a87f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3002,7 +3002,7 @@ static void gfx_v6_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id
 static void gfx_v6_0_select_me_pipe_q(struct amdgpu_device *adev,
 				  u32 me, u32 pipe, u32 q, u32 vm, u32 xcc_id)
 {
-	DRM_INFO("Not implemented\n");
+	drm_info(adev_to_drm(adev), "Not implemented\n");
 }
 
 static const struct amdgpu_gfx_funcs gfx_v6_0_gfx_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 028ae5fbdb405..a6b4c8f41dc11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1048,7 +1048,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	if (adev->gfx.ce_feature_version >= 46 &&
 	    adev->gfx.pfp_feature_version >= 46) {
 		adev->virt.chained_ib_support = true;
-		DRM_INFO("Chained IB support enabled!\n");
+		drm_info(adev_to_drm(adev), "Chained IB support enabled!\n");
 	} else
 		adev->virt.chained_ib_support = false;
 
@@ -3820,7 +3820,7 @@ static void gfx_v8_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 				gfx_v8_0_select_se_sh(adev, 0xffffffff,
 						      0xffffffff, 0xffffffff, 0);
 				mutex_unlock(&adev->grbm_idx_mutex);
-				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
+				drm_info(adev_to_drm(adev), "Timeout wait for RLC serdes %u,%u\n",
 					 i, j);
 				return;
 			}
@@ -6669,7 +6669,7 @@ static void gfx_v8_0_parse_sq_irq(struct amdgpu_device *adev, unsigned ih_data,
 
 	switch (enc) {
 		case 0:
-			DRM_INFO("SQ general purpose intr detected:"
+			drm_info(adev_to_drm(adev), "SQ general purpose intr detected:"
 					"se_id %d, immed_overflow %d, host_reg_overflow %d,"
 					"host_cmd_overflow %d, cmd_timestamp %d,"
 					"reg_timestamp %d, thread_trace_buff_full %d,"
@@ -6711,7 +6711,7 @@ static void gfx_v8_0_parse_sq_irq(struct amdgpu_device *adev, unsigned ih_data,
 			else
 				sprintf(type, "EDC/ECC error");
 
-			DRM_INFO(
+			drm_info(adev_to_drm(adev),
 				"SQ %s detected: "
 					"se_id %d, sh_id %d, cu_id %d, simd_id %d, wave_id %d, vm_id %d "
 					"trap %s, sq_ed_info.source %s.\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e7bc93bb8845e..7b012ca1153ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1301,7 +1301,8 @@ static void gfx_v9_0_check_fw_write_wait(struct amdgpu_device *adev)
 	     (adev->gfx.mec_feature_version < 46) ||
 	     (adev->gfx.pfp_fw_version < 0x000000b7) ||
 	     (adev->gfx.pfp_feature_version < 46)))
-		DRM_WARN_ONCE("CP firmware version too old, please update!");
+		drm_warn_once(adev_to_drm(adev),
+			      "CP firmware version too old, please update!");
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 0, 1):
@@ -2040,7 +2041,7 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_hiz_tile_fifo_size = 0x30;
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
 		gb_addr_config = VEGA12_GB_ADDR_CONFIG_GOLDEN;
-		DRM_INFO("fix gfx.config for vega12\n");
+		drm_info(adev_to_drm(adev), "fix gfx.config for vega12\n");
 		break;
 	case IP_VERSION(9, 4, 0):
 		adev->gfx.ras = &gfx_v9_0_ras;
@@ -2728,7 +2729,7 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 				amdgpu_gfx_select_se_sh(adev, 0xffffffff,
 						      0xffffffff, 0xffffffff, 0);
 				mutex_unlock(&adev->grbm_idx_mutex);
-				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
+				drm_info(adev_to_drm(adev), "Timeout wait for RLC serdes %u,%u\n",
 					 i, j);
 				return;
 			}
@@ -3151,7 +3152,7 @@ static void gfx_v9_0_rlc_start(struct amdgpu_device *adev)
 	/* RLC_GPM_GENERAL_6 : RLC Ucode version */
 	rlc_ucode_ver = RREG32_SOC15(GC, 0, mmRLC_GPM_GENERAL_6);
 	if(rlc_ucode_ver == 0x108) {
-		DRM_INFO("Using rlc debug ucode. mmRLC_GPM_GENERAL_6 ==0x08%x / fw_ver == %i \n",
+		drm_info(adev_to_drm(adev), "Using rlc debug ucode. mmRLC_GPM_GENERAL_6 ==0x08%x / fw_ver == %i\n",
 				rlc_ucode_ver, adev->gfx.rlc_fw_version);
 		/* RLC_GPM_TIMER_INT_3 : Timer interval in RefCLK cycles,
 		 * default is 0x9C4 to create a 100us interval */
@@ -3334,12 +3335,12 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 	 */
 	if (adev->flags & AMD_IS_APU &&
 			adev->in_s3 && !pm_resume_via_firmware()) {
-		DRM_INFO("Will skip the CSB packet resubmit\n");
+		drm_info(adev_to_drm(adev), "Will skip the CSB packet resubmit\n");
 		return 0;
 	}
 	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
@@ -5734,7 +5735,7 @@ static int gfx_v9_0_ring_preempt_ib(struct amdgpu_ring *ring)
 
 	if (i >= adev->usec_timeout) {
 		r = -EINVAL;
-		DRM_WARN("ring %d timeout to preempt ib\n", ring->idx);
+		drm_warn(adev_to_drm(adev), "ring %d timeout to preempt ib\n", ring->idx);
 	}
 
 	/*reset the CP_VMID_PREEMPT after trailing fence*/
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 14fc9a3b93343..ad4d442e7345e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1482,7 +1482,7 @@ static void gfx_v9_4_3_xcc_wait_for_rlc_serdes(struct amdgpu_device *adev,
 							    0xffffffff,
 							    0xffffffff, xcc_id);
 				mutex_unlock(&adev->grbm_idx_mutex);
-				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
+				drm_info(adev_to_drm(adev), "Timeout wait for RLC serdes %u,%u\n",
 					 i, j);
 				return;
 			}
@@ -1583,7 +1583,7 @@ static void gfx_v9_4_3_rlc_start(struct amdgpu_device *adev)
 		rlc_ucode_ver = RREG32_SOC15(GC, GET_INST(GC, i), regRLC_GPM_GENERAL_6);
 		if (rlc_ucode_ver == 0x108) {
 			dev_info(adev->dev,
-				 "Using rlc debug ucode. regRLC_GPM_GENERAL_6 ==0x08%x / fw_ver == %i \n",
+				 "Using rlc debug ucode. regRLC_GPM_GENERAL_6 ==0x08%x / fw_ver == %i\n",
 				 rlc_ucode_ver, adev->gfx.rlc_fw_version);
 			/* RLC_GPM_TIMER_INT_3 : Timer interval in RefCLK cycles,
 			 * default is 0x9C4 to create a 100us interval */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index deb95fab02dfe..aceb8447feacc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -649,7 +649,7 @@ static void gfxhub_v2_1_halt(struct amdgpu_device *adev)
 	}
 
 	if (!time)
-		DRM_WARN("failed to wait for GRBM(EA) idle\n");
+		drm_warn(adev_to_drm(adev), "failed to wait for GRBM(EA) idle\n");
 }
 
 const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 2bbb2ff7cb0a6..2568eeaae9454 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -957,7 +957,7 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (!adev->in_s0ix)
 		gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
 
-	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 81e96f88f9712..f61e2ebae66cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -922,7 +922,7 @@ static int gmc_v11_0_gart_enable(struct amdgpu_device *adev)
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
 	gmc_v11_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
-	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index ada821f2e65da..14bbd2343e251 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -976,7 +976,7 @@ static int gmc_v12_0_gart_enable(struct amdgpu_device *adev)
 	adev->mmhub.funcs->set_fault_enable_default(adev, value);
 	gmc_v12_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB0(0), 0);
 
-	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index a8ec95f42926b..886bf77309a54 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -555,7 +555,7 @@ static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
 		gmc_v6_0_set_fault_enable_default(adev, true);
 
 	gmc_v6_0_flush_gpu_tlb(adev, 0, 0, 0);
-	dev_info(adev->dev, "PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)table_addr);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index fbd0bf147f50c..b2e87d3aa2038 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -705,7 +705,7 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
 	}
 
 	gmc_v7_0_flush_gpu_tlb(adev, 0, 0, 0);
-	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)table_addr);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 6551b60f25847..1d5bd90ac57f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -560,7 +560,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 	tmp = RREG32(mmCONFIG_MEMSIZE);
 	/* some boards may have garbage in the upper 16 bits */
 	if (tmp & 0xffff0000) {
-		DRM_INFO("Probable bad vram size: 0x%08x\n", tmp);
+		drm_info(adev_to_drm(adev), "Probably bad vram size: 0x%08x\n", tmp);
 		if (tmp & 0xffff)
 			tmp &= 0xffff;
 	}
@@ -939,7 +939,7 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
 		gmc_v8_0_set_fault_enable_default(adev, true);
 
 	gmc_v8_0_flush_gpu_tlb(adev, 0, 0, 0);
-	DRM_INFO("PCIE GART of %uM enabled (table at 0x%016llX).\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled (table at 0x%016llX).\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20),
 		 (unsigned long long)table_addr);
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b0421b261e747..3f1178be219e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1137,13 +1137,13 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 		 */
 		mtype_local = MTYPE_RW;
 		if (amdgpu_mtype_local == 1) {
-			DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
+			drm_info_once(adev_to_drm(adev), "Using MTYPE_NC for local memory\n");
 			mtype_local = MTYPE_NC;
 		} else if (amdgpu_mtype_local == 2) {
-			DRM_INFO_ONCE("Using MTYPE_CC for local memory\n");
+			drm_info_once(adev_to_drm(adev), "Using MTYPE_CC for local memory\n");
 			mtype_local = MTYPE_CC;
 		} else {
-			DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
+			drm_info_once(adev_to_drm(adev), "Using MTYPE_RW for local memory\n");
 		}
 		is_local = (!is_vram && (adev->flags & AMD_IS_APU) &&
 			    num_possible_nodes() <= 1) ||
@@ -2131,12 +2131,12 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	DRM_INFO("PCIE GART of %uM enabled.\n",
+	drm_info(adev_to_drm(adev), "PCIE GART of %uM enabled.\n",
 		 (unsigned int)(adev->gmc.gart_size >> 20));
 	if (adev->gmc.pdb0_bo)
-		DRM_INFO("PDB0 located at 0x%016llX\n",
+		drm_info(adev_to_drm(adev), "PDB0 located at 0x%016llX\n",
 				(unsigned long long)amdgpu_bo_gpu_offset(adev->gmc.pdb0_bo));
-	DRM_INFO("PTB located at 0x%016llX\n",
+	drm_info(adev_to_drm(adev), "PTB located at 0x%016llX\n",
 			(unsigned long long)amdgpu_bo_gpu_offset(adev->gart.bo));
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 923369ece0d10..9fe8d10ab2705 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -240,7 +240,7 @@ static int jpeg_v2_0_disable_power_gating(struct amdgpu_device *adev)
 			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
-			DRM_ERROR("amdgpu: JPEG disable power gating failed\n");
+			drm_err(adev_to_drm(adev), "failed to disable JPEG power gating\n");
 			return r;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 5159f4a9787ca..e267c811c63f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -660,7 +660,7 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
 		break;
 
 	default:
-		DRM_ERROR("unsupported misc op (%d) \n", input->op);
+		drm_err(adev_to_drm(mes->adev), "unsupported misc op (%d)\n", input->op);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 5cbd3a4ff5970..b1c864dc79a86 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -699,7 +699,7 @@ static int mes_v12_0_misc_op(struct amdgpu_mes *mes,
 		break;
 
 	default:
-		DRM_ERROR("unsupported misc op (%d) \n", input->op);
+		DRM_ERROR("unsupported misc op (%d)\n", input->op);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 78408b257afc7..f2e456390b27e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -96,7 +96,9 @@ static int xgpu_nv_poll_ack(struct amdgpu_device *adev)
 		timeout -= 5;
 	} while (timeout > 1);
 
-	dev_err(adev->dev, "Doesn't get TRN_MSG_ACK from pf in %d msec \n", NV_MAILBOX_POLL_ACK_TIMEDOUT);
+	dev_err(adev->dev,
+		"Doesn't get TRN_MSG_ACK from pf in %d msec\n",
+		NV_MAILBOX_POLL_ACK_TIMEDOUT);
 
 	return -ETIME;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
index 3584b8c18fd99..8a6431487ed04 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -140,7 +140,7 @@ static int psp_v10_0_ring_destroy(struct psp_context *psp,
 
 static int psp_v10_0_mode1_reset(struct psp_context *psp)
 {
-	DRM_INFO("psp mode 1 reset not supported now! \n");
+	drm_info(adev_to_drm(psp->adev), "psp mode 1 reset not supported now!\n");
 	return -EINVAL;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index a9be7a5050268..9aa988982304b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -412,7 +412,7 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 			   MBOX_TOS_READY_MASK, 0);
 
 	if (ret) {
-		DRM_INFO("psp is not working correctly before mode1 reset!\n");
+		drm_info(adev_to_drm(adev), "psp is not working correctly before mode1 reset!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
index 4c6450d62299a..c3cae29eeca1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v12_0.c
@@ -225,7 +225,7 @@ static int psp_v12_0_mode1_reset(struct psp_context *psp)
 			   MBOX_TOS_READY_MASK, 0);
 
 	if (ret) {
-		DRM_INFO("psp is not working correctly before mode1 reset!\n");
+		drm_info(adev_to_drm(adev), "psp is not working correctly before mode1 reset!\n");
 		return -EINVAL;
 	}
 
@@ -240,11 +240,11 @@ static int psp_v12_0_mode1_reset(struct psp_context *psp)
 			   0);
 
 	if (ret) {
-		DRM_INFO("psp mode 1 reset failed!\n");
+		drm_info(adev_to_drm(adev), "psp mode 1 reset failed!\n");
 		return -EINVAL;
 	}
 
-	DRM_INFO("psp mode1 reset succeed \n");
+	drm_info(adev_to_drm(adev), "psp mode1 reset succeed\n");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index 833830bc3e2e3..f5030efc6c804 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -315,7 +315,7 @@ static int psp_v3_1_mode1_reset(struct psp_context *psp)
 	ret = psp_wait_for(psp, offset, 0x80000000, 0x8000FFFF, 0);
 
 	if (ret) {
-		DRM_INFO("psp is not working correctly before mode1 reset!\n");
+		drm_info(adev_to_drm(adev), "psp is not working correctly before mode1 reset!\n");
 		return -EINVAL;
 	}
 
@@ -329,11 +329,11 @@ static int psp_v3_1_mode1_reset(struct psp_context *psp)
 	ret = psp_wait_for(psp, offset, 0x80000000, 0x80000000, 0);
 
 	if (ret) {
-		DRM_INFO("psp mode 1 reset failed!\n");
+		drm_info(adev_to_drm(adev), "psp mode 1 reset failed!\n");
 		return -EINVAL;
 	}
 
-	DRM_INFO("psp mode1 reset succeed \n");
+	drm_info(adev_to_drm(adev), "psp mode1 reset succeed\n");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 70e9ba9d927c4..509d43b238f3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -2255,16 +2255,16 @@ static void si_pcie_gen3_enable(struct amdgpu_device *adev)
 		PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3) {
 		if (current_data_rate == 2) {
-			DRM_INFO("PCIE gen 3 link speeds already enabled\n");
+			drm_info(adev_to_drm(adev), "PCIE gen 3 link speeds already enabled\n");
 			return;
 		}
-		DRM_INFO("enabling PCIE gen 3 link speeds, disable with amdgpu.pcie_gen2=0\n");
+		drm_info(adev_to_drm(adev), "enabling PCIE gen 3 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	} else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2) {
 		if (current_data_rate == 1) {
-			DRM_INFO("PCIE gen 2 link speeds already enabled\n");
+			drm_info(adev_to_drm(adev), "PCIE gen 2 link speeds already enabled\n");
 			return;
 		}
-		DRM_INFO("enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
+		drm_info(adev_to_drm(adev), "enabling PCIE gen 2 link speeds, disable with amdgpu.pcie_gen2=0\n");
 	}
 
 	if (!pci_is_pcie(root) || !pci_is_pcie(adev->pdev))
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 7f18e4875287c..74fcaa340d9b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -584,7 +584,7 @@ static int si_dma_wait_for_idle(struct amdgpu_ip_block *ip_block)
 
 static int si_dma_soft_reset(struct amdgpu_ip_block *ip_block)
 {
-	DRM_INFO("si_dma_soft_reset --- not implemented !!!!!!!\n");
+	drm_info(adev_to_drm(ip_block->adev), "si_dma_soft_reset --- not implemented !!!!!!!\n");
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 68aef47254a90..c86acee05d0b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -196,7 +196,9 @@ static uint32_t smu_v11_0_i2c_poll_tx_status(struct i2c_adapter *control)
 
 	if (REG_GET_FIELD(reg, CKSVII2C_IC_INTR_STAT, R_TX_ABRT) == 1) {
 		reg_c_tx_abrt_source = RREG32_SOC15(SMUIO, 0, mmCKSVII2C_IC_TX_ABRT_SOURCE);
-		DRM_INFO("TX was terminated, IC_TX_ABRT_SOURCE val is:%x", reg_c_tx_abrt_source);
+		drm_info(adev_to_drm(adev),
+			 "TX was terminated, IC_TX_ABRT_SOURCE val is:%x",
+			 reg_c_tx_abrt_source);
 
 		/* Check for stop due to NACK */
 		if (REG_GET_FIELD(reg_c_tx_abrt_source,
@@ -769,7 +771,7 @@ bool smu_v11_0_i2c_test_bus(struct i2c_adapter *control)
 	uint8_t data[6] = {0xf, 0, 0xde, 0xad, 0xbe, 0xef};
 
 
-	DRM_INFO("Begin");
+	drm_info(adev_to_drm(adev), "Begin");
 
 	if (!smu_v11_0_i2c_bus_lock(control)) {
 		DRM_ERROR("Failed to lock the bus!.");
@@ -788,7 +790,7 @@ bool smu_v11_0_i2c_test_bus(struct i2c_adapter *control)
 	smu_v11_0_i2c_bus_unlock(control);
 
 
-	DRM_INFO("End");
+	drm_info(adev_to_drm(adev), "End");
 	return true;
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index f17d297b594bc..f2dfacb952b8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -267,7 +267,8 @@ static void umc_v6_1_query_ras_error_count(struct amdgpu_device *adev,
 
 	if ((adev->asic_type == CHIP_ARCTURUS) &&
 		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
-		DRM_WARN("Fail to disable DF-Cstate.\n");
+		drm_warn(adev_to_drm(adev),
+			"Fail to disable DF-Cstate.\n");
 
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
 		umc_reg_offset = get_umc_6_reg_offset(adev,
@@ -284,7 +285,7 @@ static void umc_v6_1_query_ras_error_count(struct amdgpu_device *adev,
 
 	if ((adev->asic_type == CHIP_ARCTURUS) &&
 		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
-		DRM_WARN("Fail to enable DF-Cstate\n");
+		drm_warn(adev_to_drm(adev), "Fail to enable DF-Cstate\n");
 
 	if (rsmu_umc_index_state)
 		umc_v6_1_enable_umc_index_mode(adev);
@@ -366,7 +367,7 @@ static void umc_v6_1_query_ras_error_address(struct amdgpu_device *adev,
 
 	if ((adev->asic_type == CHIP_ARCTURUS) &&
 		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
-		DRM_WARN("Fail to disable DF-Cstate.\n");
+		drm_warn(adev_to_drm(adev), "Fail to disable DF-Cstate.\n");
 
 	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
 		umc_reg_offset = get_umc_6_reg_offset(adev,
@@ -382,7 +383,7 @@ static void umc_v6_1_query_ras_error_address(struct amdgpu_device *adev,
 
 	if ((adev->asic_type == CHIP_ARCTURUS) &&
 		amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
-		DRM_WARN("Fail to enable DF-Cstate\n");
+		drm_warn(adev_to_drm(adev), "Fail to enable DF-Cstate\n");
 
 	if (rsmu_umc_index_state)
 		umc_v6_1_enable_umc_index_mode(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 12b1b1c9ed66a..454f109cbb2e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -191,7 +191,7 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 done:
 	if (!r)
-		DRM_INFO("UVD initialized successfully.\n");
+		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
 
@@ -846,7 +846,7 @@ static void uvd_v5_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u64
 
 	if (RREG32_SMC(ixCURRENT_PG_STATUS) &
 				CURRENT_PG_STATUS__UVD_PG_STATUS_MASK) {
-		DRM_INFO("Cannot get clockgating state when UVD is powergated.\n");
+		drm_info(adev_to_drm(adev), "Cannot get clockgating state when UVD is powergated.\n");
 		goto out;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index a1d29fae331b4..ecd7ead7a60b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -408,7 +408,7 @@ static int uvd_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->uvd.inst->irq.num_types = 1;
 		adev->uvd.num_enc_rings = 0;
 
-		DRM_INFO("UVD ENC is disabled\n");
+		drm_info(adev_to_drm(adev), "UVD ENC is disabled\n");
 	}
 
 	ring = &adev->uvd.inst->ring;
@@ -515,9 +515,9 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
 done:
 	if (!r) {
 		if (uvd_v6_0_enc_support(adev))
-			DRM_INFO("UVD and UVD ENC initialized successfully.\n");
+			drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
 		else
-			DRM_INFO("UVD initialized successfully.\n");
+			drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 	}
 
 	return r;
@@ -1513,7 +1513,7 @@ static void uvd_v6_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u64
 		data = RREG32_SMC(ixCURRENT_PG_STATUS);
 
 	if (data & CURRENT_PG_STATUS__UVD_PG_STATUS_MASK) {
-		DRM_INFO("Cannot get clockgating state when UVD is powergated.\n");
+		drm_info(adev_to_drm(adev), "Cannot get clockgating state when UVD is powergated.\n");
 		goto out;
 	}
 
@@ -1633,10 +1633,10 @@ static void uvd_v6_0_set_ring_funcs(struct amdgpu_device *adev)
 {
 	if (adev->asic_type >= CHIP_POLARIS10) {
 		adev->uvd.inst->ring.funcs = &uvd_v6_0_ring_vm_funcs;
-		DRM_INFO("UVD is enabled in VM mode\n");
+		drm_info(adev_to_drm(adev), "UVD is enabled in VM mode\n");
 	} else {
 		adev->uvd.inst->ring.funcs = &uvd_v6_0_ring_phys_funcs;
-		DRM_INFO("UVD is enabled in physical mode\n");
+		drm_info(adev_to_drm(adev), "UVD is enabled in physical mode\n");
 	}
 }
 
@@ -1647,7 +1647,7 @@ static void uvd_v6_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 	for (i = 0; i < adev->uvd.num_enc_rings; ++i)
 		adev->uvd.inst->ring_enc[i].funcs = &uvd_v6_0_enc_ring_vm_funcs;
 
-	DRM_INFO("UVD ENC is enabled in VM mode\n");
+	drm_info(adev_to_drm(adev), "UVD ENC is enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs uvd_v6_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 89d9637a2401f..df2c83348315d 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -438,7 +438,7 @@ static int uvd_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 		}
-		DRM_INFO("PSP loading UVD firmware\n");
+		drm_info(adev_to_drm(adev), "PSP loading UVD firmware\n");
 	}
 
 	for (j = 0; j < adev->uvd.num_uvd_inst; j++) {
@@ -582,7 +582,7 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 	}
 done:
 	if (!r)
-		DRM_INFO("UVD and UVD ENC initialized successfully.\n");
+		drm_info(adev_to_drm(adev), "UVD and UVD ENC initialized successfully.\n");
 
 	return r;
 }
@@ -1606,7 +1606,7 @@ static void uvd_v7_0_set_ring_funcs(struct amdgpu_device *adev)
 			continue;
 		adev->uvd.inst[i].ring.funcs = &uvd_v7_0_ring_vm_funcs;
 		adev->uvd.inst[i].ring.me = i;
-		DRM_INFO("UVD(%d) is enabled in VM mode\n", i);
+		drm_info(adev_to_drm(adev), "UVD(%d) is enabled in VM mode\n", i);
 	}
 }
 
@@ -1622,7 +1622,7 @@ static void uvd_v7_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 			adev->uvd.inst[j].ring_enc[i].me = j;
 		}
 
-		DRM_INFO("UVD(%d) ENC is enabled in VM mode\n", j);
+		drm_info(adev_to_drm(adev), "UVD(%d) ENC is enabled in VM mode\n", j);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
index 8ea8a6193492f..db149eda62044 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v2_0.c
@@ -280,7 +280,7 @@ static int vce_v2_0_stop(struct amdgpu_device *adev)
 
 
 	if (vce_v2_0_lmi_clean(adev)) {
-		DRM_INFO("VCE is not idle \n");
+		drm_info(adev_to_drm(adev), "VCE is not idle\n");
 		return 0;
 	}
 
@@ -289,7 +289,7 @@ static int vce_v2_0_stop(struct amdgpu_device *adev)
 		return -EINVAL;
 
 	if (vce_v2_0_wait_for_idle(ip_block)) {
-		DRM_INFO("VCE is busy, Can't set clock gating");
+		drm_info(adev_to_drm(adev), "VCE is busy, Can't set clock gating");
 		return 0;
 	}
 
@@ -481,7 +481,7 @@ static int vce_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	DRM_INFO("VCE initialized successfully.\n");
+	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 719e9643c43d4..03d79e464f04f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -485,7 +485,7 @@ static int vce_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	DRM_INFO("VCE initialized successfully.\n");
+	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
 }
@@ -846,7 +846,7 @@ static void vce_v3_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u64
 		data = RREG32_SMC(ixCURRENT_PG_STATUS);
 
 	if (data & CURRENT_PG_STATUS__VCE_PG_STATUS_MASK) {
-		DRM_INFO("Cannot get clockgating state when VCE is powergated.\n");
+		drm_info(adev_to_drm(adev), "Cannot get clockgating state when VCE is powergated.\n");
 		goto out;
 	}
 
@@ -978,13 +978,13 @@ static void vce_v3_0_set_ring_funcs(struct amdgpu_device *adev)
 			adev->vce.ring[i].funcs = &vce_v3_0_ring_vm_funcs;
 			adev->vce.ring[i].me = i;
 		}
-		DRM_INFO("VCE enabled in VM mode\n");
+		drm_info(adev_to_drm(adev), "VCE enabled in VM mode\n");
 	} else {
 		for (i = 0; i < adev->vce.num_rings; i++) {
 			adev->vce.ring[i].funcs = &vce_v3_0_ring_phys_funcs;
 			adev->vce.ring[i].me = i;
 		}
-		DRM_INFO("VCE enabled in physical mode\n");
+		drm_info(adev_to_drm(adev), "VCE enabled in physical mode\n");
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
index 2d64002bed61f..ee445d8abe474 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -460,7 +460,7 @@ static int vce_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->firmware.ucode[AMDGPU_UCODE_ID_VCE].fw = adev->vce.fw;
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
-		DRM_INFO("PSP loading VCE firmware\n");
+		drm_info(adev_to_drm(adev), "PSP loading VCE firmware\n");
 	} else {
 		r = amdgpu_vce_resume(adev);
 		if (r)
@@ -536,7 +536,7 @@ static int vce_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	DRM_INFO("VCE initialized successfully.\n");
+	drm_info(adev_to_drm(adev), "VCE initialized successfully.\n");
 
 	return 0;
 }
@@ -864,7 +864,7 @@ static void vce_v4_0_set_ring_funcs(struct amdgpu_device *adev)
 		adev->vce.ring[i].funcs = &vce_v4_0_ring_vm_funcs;
 		adev->vce.ring[i].me = i;
 	}
-	DRM_INFO("VCE enabled in VM mode\n");
+	drm_info(adev_to_drm(adev), "VCE enabled in VM mode\n");
 }
 
 static const struct amdgpu_irq_src_funcs vce_v4_0_irq_funcs = {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index e20aa74380665..327b20055729c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -105,7 +105,9 @@ static void update_phy_id_mapping(struct amdgpu_device *adev)
 			continue;
 
 		if (idx >= AMDGPU_DM_MAX_CRTC) {
-			DRM_WARN("%s connected connectors exceed max crtc\n", __func__);
+			drm_warn(adev_to_drm(adev),
+				"%s connected connectors exceed max crtc\n",
+				__func__);
 			mutex_unlock(&ddev->mode_config.mutex);
 			return;
 		}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index a9839485f2a29..36078ed5103d7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -95,7 +95,7 @@ static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
 		return -EFAULT;
 	}
 
-	/* check number of parameters. isspace could not differ space and \n */
+	/* check number of parameters. isspace could not differ space and\n */
 	while ((*wr_buf_ptr != 0xa) && (wr_buf_count < wr_buf_size)) {
 		/* skip space*/
 		while (isspace(*wr_buf_ptr) && (wr_buf_count < wr_buf_size)) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index b680a3547856d..f2bd2d211cf48 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -503,7 +503,8 @@ static bool enable_assr(void *handle, struct dc_link *link)
 	struct ta_dtm_shared_memory *dtm_cmd;
 
 	if (!psp->dtm_context.context.initialized) {
-		DRM_INFO("Failed to enable ASSR, DTM TA is not initialized.");
+		drm_info(adev_to_drm(psp->adev),
+			 "Failed to enable ASSR, DTM TA is not initialized.");
 		return false;
 	}
 
@@ -520,7 +521,8 @@ static bool enable_assr(void *handle, struct dc_link *link)
 	psp_dtm_invoke(psp, dtm_cmd->cmd_id);
 
 	if (dtm_cmd->dtm_status != TA_DTM_STATUS__SUCCESS) {
-		DRM_INFO("Failed to enable ASSR");
+		drm_info(adev_to_drm(psp->adev),
+			 "Failed to enable ASSR");
 		return false;
 	}
 
@@ -813,7 +815,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,
 	sysfs_bin_attr_init(&hdcp_work[0].attr);
 
 	if (sysfs_create_bin_file(&adev->dev->kobj, &hdcp_work[0].attr))
-		DRM_WARN("Failed to create device file hdcp_srm");
+		drm_warn(adev_to_drm(adev), "Failed to create device file hdcp_srm\n");
 
 	return hdcp_work;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 0b05ee9f6ea1a..a2bf23a0d9384 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -96,11 +96,10 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 	}
 
 	link->panel_mode = panel_mode;
-	DC_LOG_DETECTION_DP_CAPS("Link: %d eDP panel mode supported: %d "
-		 "eDP panel mode enabled: %d \n",
-		 link->link_index,
-		 link->dpcd_caps.panel_mode_edp,
-		 panel_mode_edp);
+	DC_LOG_DETECTION_DP_CAPS("%d eDP panel mode supported: %d, enabled: %d\n",
+				 link->link_index,
+				 link->dpcd_caps.panel_mode_edp,
+				 panel_mode_edp);
 }
 
 enum dp_panel_mode dp_get_panel_mode(struct dc_link *link)
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 74bb2d9f7faa3..b27e4c2e550ff 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -607,8 +607,8 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable, 0);
 	if (ret)
-		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
-			  enable ? "enable" : "disable", ret);
+		drm_err(adev_to_drm(adev), "DPM %s uvd failed, ret = %d.\n",
+			enable ? "enable" : "disable", ret);
 }
 
 void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst)
@@ -617,8 +617,8 @@ void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst)
 
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, inst);
 	if (ret)
-		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
-			  enable ? "enable" : "disable", ret);
+		drm_err(adev_to_drm(adev), "DPM %s vcn failed, ret = %d.\n",
+			enable ? "enable" : "disable", ret);
 }
 
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
@@ -642,8 +642,8 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable, 0);
 	if (ret)
-		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
-			  enable ? "enable" : "disable", ret);
+		drm_err(adev_to_drm(adev), "DPM %s vce failed, ret = %d.\n",
+			enable ? "enable" : "disable", ret);
 }
 
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
@@ -652,8 +652,8 @@ void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable)
 
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_JPEG, !enable, 0);
 	if (ret)
-		DRM_ERROR("Dpm %s jpeg failed, ret = %d. \n",
-			  enable ? "enable" : "disable", ret);
+		drm_err(adev_to_drm(adev), "Dpm %s jpeg failed, ret = %d.\n",
+			enable ? "enable" : "disable", ret);
 }
 
 void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable)
@@ -662,8 +662,8 @@ void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable)
 
 	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VPE, !enable, 0);
 	if (ret)
-		DRM_ERROR("Dpm %s vpe failed, ret = %d.\n",
-			  enable ? "enable" : "disable", ret);
+		drm_err(adev_to_drm(adev), "DPM %s vpe failed, ret = %d.\n",
+			enable ? "enable" : "disable", ret);
 }
 
 int amdgpu_pm_load_smu_firmware(struct amdgpu_device *adev, uint32_t *smu_version)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 1f539cc65f41f..9bdcd4e2aeb22 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7800,13 +7800,12 @@ static int si_dpm_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
 	if (amdgpu_dpm == 1)
 		amdgpu_pm_print_power_states(adev);
-	DRM_INFO("amdgpu: dpm initialized\n");
-
+	drm_info(adev_to_drm(adev), "si dpm initialized\n");
 	return 0;
 
 dpm_failed:
 	si_dpm_fini(adev);
-	DRM_ERROR("amdgpu: dpm initialization failed\n");
+	drm_err(adev_to_drm(adev), "dpm initialization failed\n");
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index c10cb8124349d..0bbb89788335e 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -198,7 +198,7 @@ static void pp_reserve_vram_for_smu(struct amdgpu_device *adev)
 						&adev->pm.smu_prv_buffer,
 						&gpu_addr,
 						&cpu_ptr)) {
-		DRM_ERROR("amdgpu: failed to create smu prv buffer\n");
+		drm_err(adev_to_drm(adev), "failed to create smu prv buffer\n");
 		return;
 	}
 
@@ -213,7 +213,7 @@ static void pp_reserve_vram_for_smu(struct amdgpu_device *adev)
 	if (r) {
 		amdgpu_bo_free_kernel(&adev->pm.smu_prv_buffer, NULL, NULL);
 		adev->pm.smu_prv_buffer = NULL;
-		DRM_ERROR("amdgpu: failed to notify SMU buffer address\n");
+		drm_err(adev_to_drm(adev), "failed to notify SMU buffer address\n");
 	}
 }
 
@@ -1053,7 +1053,8 @@ static int pp_get_current_clocks(void *handle,
 					&hw_clocks, PHM_PerformanceLevelDesignation_Activity);
 
 	if (ret) {
-		pr_debug("Error in phm_get_clock_info \n");
+		drm_err(adev_to_drm(hwmgr->adev),
+		       "Error in phm_get_clock_info\n");
 		return -EINVAL;
 	}
 
-- 
2.43.0

