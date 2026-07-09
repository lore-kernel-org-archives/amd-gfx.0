Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B12C44508
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C4510F6C2;
	Thu,  9 Jul 2026 21:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E85K7jeg";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1D4F10F6B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyYfpmq8MHcG/iLrScI6A2we8eTXx80/BZPy9fKkJnCL9wYdbdFgrDRXb6JszJ1QruFW784jkbA6XQ6fewASsb99d4LYI4B4uEihsyXysfekjuhj3luRFLmzxuT73b9ztKFH0G3v1hsPlz70gPJDurBGatie4ybjpiiGX7oLq0KqZ2qaUwxgUpBvJfQeuj2XAA//nHn+D/znYDCgmXgfa9yRxoWHGqFjU3DDMsFyxMzoxyJLe9ps40PyPvgAsrGzXld3kSw2Pvj46hJ+Cq/BzXfoAURpDt0sb725UadWgYONxZOEJ1eQ1is5WMGLG/yTX/P0L+gcaBh8jQf2YnFypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze5RYrnt8eRQcxfmorVpmLcdZGKvwXeh3KaIl/ubFLI=;
 b=olVbuqhbRxVcnfmp/H8YChsaESutuhaiP8PZ1+/B226Vo2nZZH+37mS/hVi0zrrBC/no4mhSxLqWPeuZdL8kNIi5CZNVhUy2Qo2nCdk1e+SspsAs8bRC+QRsPvGlU87O03eCWrs2GnChL3NrcHa/wVnCRkuf9fDLGwVtElUuwQog/M3HqvnFg00nXL/hI+rCGQJr+sS4wNws8yHLxVeL61rPAZwuAUZ1iAvcP/uFYz2Rrf6mMPLR86hjGKnn0bNvyjmIqUP7ehyq70EeR/+OacqQ0dXUDwVx+6zNogBUvN6Afw9LfZbGd1LwGcxqGN2Y6o5B2JT4Ha9hgACVV3Bv6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze5RYrnt8eRQcxfmorVpmLcdZGKvwXeh3KaIl/ubFLI=;
 b=E85K7jegT6pjvEohLKfrT/NMw068K2EPc/fNkP83hIqdOl5WKQP3yIxon0QWTRdVu/l35J5MtYT4AEiwfLwjm2VXLru51r4/zT4fxErdzQG2CK/HfSi5JhAAptULMV2rQKyDrIOC7mCtls+U7cfOKa6f1Md++oIh8HOQvdBESds=
Received: from SA9PR11CA0016.namprd11.prod.outlook.com (2603:10b6:806:6e::21)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:01:49 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:6e:cafe::88) by SA9PR11CA0016.outlook.office365.com
 (2603:10b6:806:6e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:48 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:44 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 13/80] drm/amd/display: Add KUnit tests for CACP on Linux
Date: Thu, 9 Jul 2026 16:47:41 -0400
Message-ID: <20260709205936.5719-14-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fdba19-ccf9-4890-e861-08deddfd4b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: P7L8Le+ZLHkKQaxdgvXAECi1MYBgXO1ha7diwniWKqdvEXlEZP92Ygm4FtNWZvX7RMkJ1wYb/MnBaZPavDugr21hCx2QdM/ziDa3Zf6A2nxBwq4wBM2gZ1IbzMFBzw/vbcvdXX+qSqbGk8QiGHSh/i6HxVxYFChEVQ9MK44tpdp5V8RCp5ruhBj1chkQkZiaLeHS5qJkXikDaLvhmGsjIGRY2TmCuAZmA1Cy8Wgv+zC4lZivs3R6vnYJJBcUMR1yAgXjiveIBym42uBapkmy9AKqT5vUMcyof+F+OESaPwTaW6LaLRADjJpUI73QCGBvGrJyG3kFr9lukKKoN/0lZyz78A67XK9QolJ6i2pTGt5J22T/ov4GLJGPVE8g+71nuR+s2VWDwPKE1iARFNLZgGf6dc3I4ucAAOtbOcMks1G9lU/Pfd35npmu9bEp10QRY6XqI9xQYzUe+1ucHGZZVUUIiRzCDoNZmG/ZmJiyGthnGdQK2nmspahwpZo8TYhFjys5UGdqyFYE1TR8SBXm5khQE4rhDyjrruJ9wYErb4r/ZYgQK7Q6qxlA+BqNOx1P4uuXlLZMCe/PnOm1Q0FCZlVP6vn7pQuOhUZa+KnV0pE0ci5TRYHQfuMe9oIg5maWTOy0uHFSL98QzRMZs7rBIsNzA3mkZIkydPOWZaGsoXkB49ZkCRMqrv6p0G3fF7nPmDs4fozB4/ALuY4iCht6Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZHibEMWFG1ORSGaRJr1zitI9tJZZRntujK4F20Fle2KMSmNIj/+w1E/YgVKapX9sFPwGro+cNSsS28k39VuUk9wJHQ3bhTe8ENrCGEvfx/11ULVmdZwSUoMNhBcoFOBF/GnKRzlBQ+/Z5F5LzDFHv+MxzEw7CamuyP5w5o3KU1C2Z2V64mCZJkbXLF/GJMfkkzObL6Y2RNCETb8q5th7u9EUpkI9evUdv3gE3gfxN5Vfn0+tPsCkY5hIyylIkm2MZu2a7K6r6VdZZkqDmeCrgbHAqXNTm4LbZU0eekIY+fFnS/1Eial6FKCncmK0UNFpq3Hd/C3pDiBkQkep7PC5TfbqiW3aAMOjkGPwvZTE3TzzR7mpVIVd4lymR4pKV2b6mthbCEzHXvQuEP3RxoKBPf+ZuiQhV7kg8/z9lWRhxnsbgmK1vHOY50m9nmer/zHO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:48.8558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fdba19-ccf9-4890-e861-08deddfd4b13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
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

From: Chenyu Chen <chen-yu.chen@amd.com>

[Why]
The CACP enablement on Linux added panel-type detection and CACP
capability logic that was not covered by KUnit tests.

[How]
Export amdgpu_dm_set_panel_type() and amdgpu_dm_update_cacp_caps() for
KUnit via STATIC_IFN_KUNIT/EXPORT_IF_KUNIT and add unit tests covering:
- amdgpu_dm_update_cacp_caps(): IP version gating (including the 3.1.6
  exclusion), eDP/LVDS signal handling, non-eDP signals, and OLED vs LCD
  panel types.
- amdgpu_dm_set_panel_type(): VSDB OLED/MINILED, DPCD oled/miniled bits,
  the DID path (OLED and LCD), the vendor luminance heuristic, and the
  LCD default.

Update the should_create_sysfs backlight tests to reflect the new
OLED/CACP behavior (OLED with/without CACP and LCD eDP panels).

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   6 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   2 +
 .../tests/amdgpu_dm_backlight_test.c          |  43 ++-
 .../tests/amdgpu_dm_connector_test.c          | 351 ++++++++++++++++++
 4 files changed, 392 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 9d0231016ad6..56e4bbff383f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -392,7 +392,7 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 	return NULL;
 }

-static void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_display_info *display_info = &connector->display_info;
@@ -459,8 +459,9 @@ static void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector)

 	drm_dbg_kms(aconnector->base.dev, "Panel type: %d\n", link->panel_type);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_set_panel_type);

-static void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector)
 {
 	struct amdgpu_device *adev = drm_to_adev(aconnector->base.dev);
 	struct dc_link *link = aconnector->dc_link;
@@ -485,6 +486,7 @@ static void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector)
 	drm_dbg_kms(aconnector->base.dev, "cacp_supported: %d\n",
 		    link->panel_config.cacp.cacp_supported);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_update_cacp_caps);

 DEFINE_FREE(sink_release, struct dc_sink *, if (_T) dc_sink_release(_T))

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index ab6938a0b8ed..865646303dcb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -158,5 +158,7 @@ enum dc_aspect_ratio get_aspect_ratio(const struct drm_display_mode *mode_in);
 void decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 					     const struct drm_display_mode *native_mode,
 					     bool scale_enabled);
+void amdgpu_dm_set_panel_type(struct amdgpu_dm_connector *aconnector);
+void amdgpu_dm_update_cacp_caps(struct amdgpu_dm_connector *aconnector);
 #endif
 #endif /* __AMDGPU_DM_CONNECTOR_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
index 53df4b668f2e..adb896022a27 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
@@ -1034,10 +1034,13 @@ static void dm_test_should_create_sysfs_no_backlight_index(struct kunit *test)
 }

 /**
- * dm_test_should_create_sysfs_aux_backlight - Test AUX backlight disables sysfs
+ * dm_test_should_create_sysfs_oled_no_cacp - Test OLED without CACP disables sysfs
  * @test: The KUnit test context
+ *
+ * A non-LCD panel that does not support CACP must not expose the sysfs
+ * backlight interface.
  */
-static void dm_test_should_create_sysfs_aux_backlight(struct kunit *test)
+static void dm_test_should_create_sysfs_oled_no_cacp(struct kunit *test)
 {
 	struct dm_backlight_connector_fixture fixture = {};
 	int saved_abm_level = amdgpu_dm_get_abm_level_param();
@@ -1045,7 +1048,8 @@ static void dm_test_should_create_sysfs_aux_backlight(struct kunit *test)
 	amdgpu_dm_set_abm_level_param(-1);
 	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_EDP);
 	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
-	fixture.adev->dm.backlight_caps[0].aux_support = true;
+	fixture.link->panel_type = PANEL_TYPE_OLED;
+	fixture.link->panel_config.cacp.cacp_supported = false;

 	KUNIT_EXPECT_FALSE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));

@@ -1053,10 +1057,33 @@ static void dm_test_should_create_sysfs_aux_backlight(struct kunit *test)
 }

 /**
- * dm_test_should_create_sysfs_pwm_backlight - Test PWM backlight enables sysfs
+ * dm_test_should_create_sysfs_oled_cacp - Test OLED with CACP enables sysfs
+ * @test: The KUnit test context
+ *
+ * An OLED panel that supports CACP must expose the sysfs backlight
+ * interface so the ABM/CACP level can be controlled.
+ */
+static void dm_test_should_create_sysfs_oled_cacp(struct kunit *test)
+{
+	struct dm_backlight_connector_fixture fixture = {};
+	int saved_abm_level = amdgpu_dm_get_abm_level_param();
+
+	amdgpu_dm_set_abm_level_param(-1);
+	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_EDP);
+	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
+	fixture.link->panel_type = PANEL_TYPE_OLED;
+	fixture.link->panel_config.cacp.cacp_supported = true;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));
+
+	amdgpu_dm_set_abm_level_param(saved_abm_level);
+}
+
+/**
+ * dm_test_should_create_sysfs_lcd_panel - Test LCD eDP panel enables sysfs
  * @test: The KUnit test context
  */
-static void dm_test_should_create_sysfs_pwm_backlight(struct kunit *test)
+static void dm_test_should_create_sysfs_lcd_panel(struct kunit *test)
 {
 	struct dm_backlight_connector_fixture fixture = {};
 	int saved_abm_level = amdgpu_dm_get_abm_level_param();
@@ -1065,7 +1092,6 @@ static void dm_test_should_create_sysfs_pwm_backlight(struct kunit *test)
 	setup_test_connector(test, &fixture, 0, SIGNAL_TYPE_EDP);
 	fixture.aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
 	fixture.link->panel_type = PANEL_TYPE_LCD;
-	fixture.adev->dm.backlight_caps[0].aux_support = false;

 	KUNIT_EXPECT_TRUE(test, amdgpu_dm_should_create_sysfs(fixture.aconnector));

@@ -1225,8 +1251,9 @@ static struct kunit_case dm_backlight_test_cases[] = {
 	KUNIT_CASE(dm_test_should_create_sysfs_abm_forced),
 	KUNIT_CASE(dm_test_should_create_sysfs_non_edp),
 	KUNIT_CASE(dm_test_should_create_sysfs_no_backlight_index),
-	KUNIT_CASE(dm_test_should_create_sysfs_aux_backlight),
-	KUNIT_CASE(dm_test_should_create_sysfs_pwm_backlight),
+	KUNIT_CASE(dm_test_should_create_sysfs_oled_no_cacp),
+	KUNIT_CASE(dm_test_should_create_sysfs_oled_cacp),
+	KUNIT_CASE(dm_test_should_create_sysfs_lcd_panel),
 	/* amdgpu_dm_setup_backlight_device */
 	KUNIT_CASE(dm_test_setup_backlight_device_non_edp),
 	KUNIT_CASE(dm_test_setup_backlight_device_connection_none),
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index aa451064b30c..45210c64a000 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -2015,6 +2015,341 @@ static void dm_test_is_freesync_video_mode_no_match(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_freesync_video_mode(&candidate, aconnector));
 }

+/* Tests for amdgpu_dm_update_cacp_caps() */
+
+struct dm_cacp_fixture {
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+};
+
+static void setup_cacp_fixture(struct kunit *test,
+			       struct dm_cacp_fixture *fixture,
+			       enum signal_type signal,
+			       enum dc_panel_type panel_type)
+{
+	fixture->adev = kunit_kzalloc(test, sizeof(*fixture->adev), GFP_KERNEL);
+	fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture->aconnector),
+					    GFP_KERNEL);
+	fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->adev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
+
+	fixture->aconnector->dc_link = fixture->link;
+	fixture->aconnector->base.dev = &fixture->adev->ddev;
+	fixture->link->connector_signal = signal;
+	fixture->link->panel_type = panel_type;
+}
+
+/**
+ * dm_test_cacp_caps_unsupported_ip - Test CACP disabled on old DCE IP
+ * @test: The KUnit test context
+ *
+ * A DCE IP version below 3.1.4 does not support CACP, so cacp_supported
+ * must remain false regardless of signal or panel type.
+ */
+static void dm_test_cacp_caps_unsupported_ip(struct kunit *test)
+{
+	struct dm_cacp_fixture fixture = {};
+
+	setup_cacp_fixture(test, &fixture, SIGNAL_TYPE_EDP, PANEL_TYPE_OLED);
+	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 2);
+
+	amdgpu_dm_update_cacp_caps(fixture.aconnector);
+
+	KUNIT_EXPECT_FALSE(test, fixture.link->panel_config.cacp.cacp_supported);
+}
+
+/**
+ * dm_test_cacp_caps_excluded_ip_316 - Test CACP disabled on DCE IP 3.1.6
+ * @test: The KUnit test context
+ *
+ * DCE IP version 3.1.6 is explicitly excluded from CACP support.
+ */
+static void dm_test_cacp_caps_excluded_ip_316(struct kunit *test)
+{
+	struct dm_cacp_fixture fixture = {};
+
+	setup_cacp_fixture(test, &fixture, SIGNAL_TYPE_EDP, PANEL_TYPE_OLED);
+	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 6);
+
+	amdgpu_dm_update_cacp_caps(fixture.aconnector);
+
+	KUNIT_EXPECT_FALSE(test, fixture.link->panel_config.cacp.cacp_supported);
+}
+
+/**
+ * dm_test_cacp_caps_edp_oled_supported - Test CACP enabled on eDP OLED
+ * @test: The KUnit test context
+ *
+ * A supported DCE IP version on an eDP OLED panel must enable CACP.
+ */
+static void dm_test_cacp_caps_edp_oled_supported(struct kunit *test)
+{
+	struct dm_cacp_fixture fixture = {};
+
+	setup_cacp_fixture(test, &fixture, SIGNAL_TYPE_EDP, PANEL_TYPE_OLED);
+	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 4);
+
+	amdgpu_dm_update_cacp_caps(fixture.aconnector);
+
+	KUNIT_EXPECT_TRUE(test, fixture.link->panel_config.cacp.cacp_supported);
+}
+
+/**
+ * dm_test_cacp_caps_lvds_oled_supported - Test CACP enabled on LVDS OLED
+ * @test: The KUnit test context
+ *
+ * LVDS is an accepted connector signal for CACP support.
+ */
+static void dm_test_cacp_caps_lvds_oled_supported(struct kunit *test)
+{
+	struct dm_cacp_fixture fixture = {};
+
+	setup_cacp_fixture(test, &fixture, SIGNAL_TYPE_LVDS, PANEL_TYPE_OLED);
+	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 0);
+
+	amdgpu_dm_update_cacp_caps(fixture.aconnector);
+
+	KUNIT_EXPECT_TRUE(test, fixture.link->panel_config.cacp.cacp_supported);
+}
+
+/**
+ * dm_test_cacp_caps_non_edp_signal - Test CACP disabled on non-eDP/LVDS signal
+ * @test: The KUnit test context
+ *
+ * External DisplayPort is neither eDP nor LVDS, so CACP must be disabled.
+ */
+static void dm_test_cacp_caps_non_edp_signal(struct kunit *test)
+{
+	struct dm_cacp_fixture fixture = {};
+
+	setup_cacp_fixture(test, &fixture, SIGNAL_TYPE_DISPLAY_PORT,
+			   PANEL_TYPE_OLED);
+	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 4);
+
+	amdgpu_dm_update_cacp_caps(fixture.aconnector);
+
+	KUNIT_EXPECT_FALSE(test, fixture.link->panel_config.cacp.cacp_supported);
+}
+
+/**
+ * dm_test_cacp_caps_lcd_panel - Test CACP disabled on LCD panel
+ * @test: The KUnit test context
+ *
+ * Plain LCD panels do not benefit from CACP, so it must be disabled even
+ * on a supported IP version and eDP signal.
+ */
+static void dm_test_cacp_caps_lcd_panel(struct kunit *test)
+{
+	struct dm_cacp_fixture fixture = {};
+
+	setup_cacp_fixture(test, &fixture, SIGNAL_TYPE_EDP, PANEL_TYPE_LCD);
+	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 4);
+
+	amdgpu_dm_update_cacp_caps(fixture.aconnector);
+
+	KUNIT_EXPECT_FALSE(test, fixture.link->panel_config.cacp.cacp_supported);
+}
+
+/* Tests for amdgpu_dm_set_panel_type() */
+
+struct dm_panel_type_fixture {
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+	struct dc_sink *sink;
+};
+
+static void setup_panel_type_fixture(struct kunit *test,
+				     struct dm_panel_type_fixture *fixture)
+{
+	struct device *dev;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	fixture->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+							   sizeof(*fixture->adev),
+							   offsetof(struct amdgpu_device, ddev),
+							   DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->drm);
+	fixture->adev = drm_to_adev(fixture->drm);
+
+	fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture->aconnector),
+					    GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
+	fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
+	fixture->sink = kunit_kzalloc(test, sizeof(*fixture->sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->sink);
+
+	fixture->aconnector->dc_link = fixture->link;
+	drmm_connector_init(fixture->drm, &fixture->aconnector->base,
+			    &dm_test_connector_funcs, DRM_MODE_CONNECTOR_eDP,
+			    NULL);
+}
+
+/**
+ * dm_test_set_panel_type_vsdb_oled - Test VSDB OLED maps to PANEL_TYPE_OLED
+ * @test: The KUnit test context
+ */
+static void dm_test_set_panel_type_vsdb_oled(struct kunit *test)
+{
+	struct dm_panel_type_fixture fixture = {};
+
+	setup_panel_type_fixture(test, &fixture);
+	fixture.aconnector->base.display_info.amd_vsdb.panel_type =
+		AMD_VSDB_PANEL_TYPE_OLED;
+
+	amdgpu_dm_set_panel_type(fixture.aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)fixture.link->panel_type,
+			(int)PANEL_TYPE_OLED);
+}
+
+/**
+ * dm_test_set_panel_type_vsdb_miniled - Test VSDB MINILED maps to PANEL_TYPE_MINILED
+ * @test: The KUnit test context
+ */
+static void dm_test_set_panel_type_vsdb_miniled(struct kunit *test)
+{
+	struct dm_panel_type_fixture fixture = {};
+
+	setup_panel_type_fixture(test, &fixture);
+	fixture.aconnector->base.display_info.amd_vsdb.panel_type =
+		AMD_VSDB_PANEL_TYPE_MINILED;
+
+	amdgpu_dm_set_panel_type(fixture.aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)fixture.link->panel_type,
+			(int)PANEL_TYPE_MINILED);
+}
+
+/**
+ * dm_test_set_panel_type_dpcd_oled - Test DPCD oled bit maps to PANEL_TYPE_OLED
+ * @test: The KUnit test context
+ */
+static void dm_test_set_panel_type_dpcd_oled(struct kunit *test)
+{
+	struct dm_panel_type_fixture fixture = {};
+
+	setup_panel_type_fixture(test, &fixture);
+	fixture.link->dpcd_sink_ext_caps.bits.oled = 1;
+
+	amdgpu_dm_set_panel_type(fixture.aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)fixture.link->panel_type,
+			(int)PANEL_TYPE_OLED);
+}
+
+/**
+ * dm_test_set_panel_type_dpcd_miniled - Test DPCD miniled bit maps to PANEL_TYPE_MINILED
+ * @test: The KUnit test context
+ */
+static void dm_test_set_panel_type_dpcd_miniled(struct kunit *test)
+{
+	struct dm_panel_type_fixture fixture = {};
+
+	setup_panel_type_fixture(test, &fixture);
+	fixture.link->dpcd_sink_ext_caps.bits.miniled = 1;
+
+	amdgpu_dm_set_panel_type(fixture.aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)fixture.link->panel_type,
+			(int)PANEL_TYPE_MINILED);
+}
+
+/**
+ * dm_test_set_panel_type_did_oled - Test DID OLED maps to PANEL_TYPE_OLED
+ * @test: The KUnit test context
+ *
+ * When VSDB and DPCD do not identify the panel, a DID panel type of
+ * DRM_MODE_PANEL_TYPE_OLED must map to PANEL_TYPE_OLED.
+ */
+static void dm_test_set_panel_type_did_oled(struct kunit *test)
+{
+	struct dm_panel_type_fixture fixture = {};
+
+	setup_panel_type_fixture(test, &fixture);
+	fixture.aconnector->base.display_info.panel_type =
+		DRM_MODE_PANEL_TYPE_OLED;
+
+	amdgpu_dm_set_panel_type(fixture.aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)fixture.link->panel_type,
+			(int)PANEL_TYPE_OLED);
+}
+
+/**
+ * dm_test_set_panel_type_did_lcd - Test DID LCD maps to PANEL_TYPE_LCD
+ * @test: The KUnit test context
+ *
+ * When VSDB and DPCD do not identify the panel, a DID panel type of
+ * DRM_MODE_PANEL_TYPE_LCD must map to PANEL_TYPE_LCD.
+ */
+static void dm_test_set_panel_type_did_lcd(struct kunit *test)
+{
+	struct dm_panel_type_fixture fixture = {};
+
+	setup_panel_type_fixture(test, &fixture);
+	fixture.aconnector->base.display_info.panel_type =
+		DRM_MODE_PANEL_TYPE_LCD;
+
+	amdgpu_dm_set_panel_type(fixture.aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)fixture.link->panel_type,
+			(int)PANEL_TYPE_LCD);
+}
+
+/**
+ * dm_test_set_panel_type_vendor_lum_heuristic - Test vendor luminance heuristic maps to MINILED
+ * @test: The KUnit test context
+ *
+ * A panel from the specific vendor whose first luminance range is at least
+ * 1.5x the second is treated as a mini-LED panel.
+ */
+static void dm_test_set_panel_type_vendor_lum_heuristic(struct kunit *test)
+{
+	struct dm_panel_type_fixture fixture = {};
+	struct drm_amd_vsdb_info *vsdb;
+
+	setup_panel_type_fixture(test, &fixture);
+	fixture.link->local_sink = fixture.sink;
+	fixture.sink->edid_caps.manufacturer_id = DDC_MANUFACTURERNAME_SAMSUNG;
+
+	vsdb = &fixture.aconnector->base.display_info.amd_vsdb;
+	vsdb->version = 1;
+	vsdb->luminance_range1.max_luminance = 3000;
+	vsdb->luminance_range2.max_luminance = 1000;
+
+	amdgpu_dm_set_panel_type(fixture.aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)fixture.link->panel_type,
+			(int)PANEL_TYPE_MINILED);
+}
+
+/**
+ * dm_test_set_panel_type_defaults_to_lcd - Test undetermined panel defaults to LCD
+ * @test: The KUnit test context
+ *
+ * When no source identifies the panel, the type now defaults to
+ * PANEL_TYPE_LCD instead of remaining PANEL_TYPE_NONE.
+ */
+static void dm_test_set_panel_type_defaults_to_lcd(struct kunit *test)
+{
+	struct dm_panel_type_fixture fixture = {};
+
+	setup_panel_type_fixture(test, &fixture);
+
+	amdgpu_dm_set_panel_type(fixture.aconnector);
+
+	KUNIT_EXPECT_EQ(test, (int)fixture.link->panel_type,
+			(int)PANEL_TYPE_LCD);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -2143,6 +2478,22 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_is_freesync_video_mode_null_mode),
 	KUNIT_CASE(dm_test_is_freesync_video_mode_match),
 	KUNIT_CASE(dm_test_is_freesync_video_mode_no_match),
+	/* amdgpu_dm_update_cacp_caps */
+	KUNIT_CASE(dm_test_cacp_caps_unsupported_ip),
+	KUNIT_CASE(dm_test_cacp_caps_excluded_ip_316),
+	KUNIT_CASE(dm_test_cacp_caps_edp_oled_supported),
+	KUNIT_CASE(dm_test_cacp_caps_lvds_oled_supported),
+	KUNIT_CASE(dm_test_cacp_caps_non_edp_signal),
+	KUNIT_CASE(dm_test_cacp_caps_lcd_panel),
+	/* amdgpu_dm_set_panel_type */
+	KUNIT_CASE(dm_test_set_panel_type_vsdb_oled),
+	KUNIT_CASE(dm_test_set_panel_type_vsdb_miniled),
+	KUNIT_CASE(dm_test_set_panel_type_dpcd_oled),
+	KUNIT_CASE(dm_test_set_panel_type_dpcd_miniled),
+	KUNIT_CASE(dm_test_set_panel_type_did_oled),
+	KUNIT_CASE(dm_test_set_panel_type_did_lcd),
+	KUNIT_CASE(dm_test_set_panel_type_vendor_lum_heuristic),
+	KUNIT_CASE(dm_test_set_panel_type_defaults_to_lcd),
 	{}
 };

--
2.55.0

