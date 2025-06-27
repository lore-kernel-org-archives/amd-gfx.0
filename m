Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7F5C7EE31
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Jun 2025 14:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F15C10EA40;
	Fri, 27 Jun 2025 14:34:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sJAAdt6q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C3A10EA2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Jun 2025 14:34:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CCA6543E8F;
 Fri, 27 Jun 2025 14:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CF9C4CEEF;
 Fri, 27 Jun 2025 14:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751034878;
 bh=fuuBtpfxo+3ldX8wgxlc7hAAfTDXMhcp0UrYCOsvzM0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sJAAdt6qV4i8Srk481kYJ09Y/Q2/JdHgzSJdBvDepB8N5g5pw8pDr36yGmhlRErwT
 iPkS7+9Os4zGjPf7WH0U+MReln7sT5YUJ27dyfSo7rR1I7kD3H9L7l2L/VHVIR7msY
 +HJgcVyqPfSHsCmpBJWhEEnZFnvz5ocF6lmAXxLVxkWAzVhZA+E9NbElFYkg8wi6Vp
 PhabDlgwI8gqBYzIPyErCGAjkVlKP5ODJJ/mO9gaNiYiriQW0zicXNA+bqNdaq7YLv
 pZVJK8aLzDhtxi+5FcFynbfNM/rBNr7DE8dEr8knZnFoHwJQGIkGU5sAMxK5JTQYP6
 9OLEib6N0B0EA==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>
Subject: [PATCH v3 2/3] drm/amd: Change legacy-dpm DRM_*() macros to drm_*()
Date: Fri, 27 Jun 2025 09:34:31 -0500
Message-ID: <20250627143432.3222843-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627143432.3222843-1-superm1@kernel.org>
References: <20250627143432.3222843-1-superm1@kernel.org>
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

drm_*() macros can show the device a message came from.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Cc: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index 2492d9a31bdfa..ea3ace882a10a 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -673,64 +673,64 @@ void amdgpu_add_thermal_controller(struct amdgpu_device *adev)
 			adev->pm.fan_max_rpm = controller->ucFanMaxRPM;
 		}
 		if (controller->ucType == ATOM_PP_THERMALCONTROLLER_RV6xx) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_RV6XX;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_RV770) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_RV770;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_EVERGREEN) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_EVERGREEN;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_SUMO) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_SUMO;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_NISLANDS) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_NI;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_SISLANDS) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_SI;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_CISLANDS) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_CI;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_KAVERI) {
-			DRM_INFO("Internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "Internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_KV;
 		} else if (controller->ucType == ATOM_PP_THERMALCONTROLLER_EXTERNAL_GPIO) {
-			DRM_INFO("External GPIO thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "External GPIO thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_EXTERNAL_GPIO;
 		} else if (controller->ucType ==
 			   ATOM_PP_THERMALCONTROLLER_ADT7473_WITH_INTERNAL) {
-			DRM_INFO("ADT7473 with internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "ADT7473 with internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_ADT7473_WITH_INTERNAL;
 		} else if (controller->ucType ==
 			   ATOM_PP_THERMALCONTROLLER_EMC2103_WITH_INTERNAL) {
-			DRM_INFO("EMC2103 with internal thermal controller %s fan control\n",
+			drm_info(adev_to_drm(adev), "EMC2103 with internal thermal controller %s fan control\n",
 				 (controller->ucFanParameters &
 				  ATOM_PP_FANPARAMETERS_NOFAN) ? "without" : "with");
 			adev->pm.int_thermal_type = THERMAL_TYPE_EMC2103_WITH_INTERNAL;
 		} else if (controller->ucType < ARRAY_SIZE(pp_lib_thermal_controller_names)) {
-			DRM_INFO("Possible %s thermal controller at 0x%02x %s fan control\n",
+			drm_info(adev_to_drm(adev), "Possible %s thermal controller at 0x%02x %s fan control\n",
 				 pp_lib_thermal_controller_names[controller->ucType],
 				 controller->ucI2cAddress >> 1,
 				 (controller->ucFanParameters &
@@ -746,7 +746,7 @@ void amdgpu_add_thermal_controller(struct amdgpu_device *adev)
 				i2c_new_client_device(&adev->pm.i2c_bus->adapter, &info);
 			}
 		} else {
-			DRM_INFO("Unknown thermal controller type %d at 0x%02x %s fan control\n",
+			drm_info(adev_to_drm(adev), "Unknown thermal controller type %d at 0x%02x %s fan control\n",
 				 controller->ucType,
 				 controller->ucI2cAddress >> 1,
 				 (controller->ucFanParameters &
-- 
2.43.0

