Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95959C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jun 2025 02:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C41110E82C;
	Thu, 26 Jun 2025 02:39:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LdQaf3uj";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6424010E264
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jun 2025 02:39:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id B5DEBA4EEF3;
 Thu, 26 Jun 2025 02:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09766C4CEEF;
 Thu, 26 Jun 2025 02:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750905538;
 bh=x5H3XJ6YROCrGIDmETiwti37k+Z2Jee+m1T/6J1e/DA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LdQaf3ujabTqSTozcmbsJ5QJqUa2vtlBijrutwSGoYI0o/vdYGA7qvHYekzAzLHf1
 9auCMhunhHVvhbw/U0CKSmZ6o7fl/yBU1n9UWcCFDUYPOI9e0ZW9Cy/KjzBTPT5x5N
 03bjpRNo0nA/SIzJiNHzDJwcwcmb27+94Cse6uqazkqyxVYem3lKPuMe1tErgLn9Ys
 ruHRnQ+eLwAp1B/xpq+RpLsGlfWznOJH0w65WNOwPxur2av2vv903puiRhZZVTfo5p
 wI0DN0zJ7NPXxdWh1n/RDWkePUlfX7hhJUI0eHTlb4TeNCD7gNpke2pxabUhX4MXH9
 XAzQYbWTxLw7g==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>
Subject: [PATCH v2 2/3] drm/amd: Change legacy-dpm DRM_*() macros to drm_*()
Date: Wed, 25 Jun 2025 21:38:54 -0500
Message-ID: <20250626023855.4026084-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250626023855.4026084-1-superm1@kernel.org>
References: <20250626023855.4026084-1-superm1@kernel.org>
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

Cc: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index 287a22082c9ed..e5ba4c526d913 100644
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

