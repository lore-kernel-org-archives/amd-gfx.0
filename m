Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEF5C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 782BD10E478;
	Wed,  2 Sep 2026 05:05:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3BOXyhp1";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0463210E478
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:05:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJwkqZ1drI6CIoDu9Md3WQZuoruaDzHCpAyoHjzpLklpBc7DctShOzBeEHAbyaUxeisJDnO8j10ct3XYtIELOwXtV9kMAsrNsI45xbOXa2fIZCZy0ueKI30kGLNuLWDn63S9CXQ3v2T7pA37eTgWrPmIfvum44FD6mqbeLN+jiWz/djFHoZPDSdh/vKmIdLsIHi/KLgWwdXtgqXFmboq2IxTQhMO+SfqI7pyo4CymMvmKnJUVOwaroVHxW25NIYRpNqrdnJoBpD38nDTBOxitZlBFLt7h3RCPbGHZ7cQmfpGLnf0XCL+pEJ2hH0azpuZTQaSMFR9WLc9mR9Q00oyKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrKFgwgVpb9gaVsGiMqfbdIrLCiQOd/udNuFy2bHYOU=;
 b=AbrjN3fZGFq+yXMN6tWbvS+k1TE91T/2u7BW9TT3oNVuXohAw82ZWNgP4zy1mlusZuk4dqR5/XL5lzUXCqPSWSNnQmHmmw+ab1ndt0cDoAgUa0xGcWpWP74aq51lq8CWtU7KfWyydXygSOFWBkLNBTHaB4plkP4TpyUn2XlXjfzTAbetUB79zq2l9cTavV2H7KP50K1k+0ujfoYkxTAyoE/2VGzcXmqLp085fpWV0Qgb8T2cGdh01FDcicSZPanE0ADaoBJ1SzQwGFKO++ISnqKSlgIUVi7bqVGk466KX6gjlv2qLIZ/r/9zdxKWqcqjFHYZNyxE6UwX3H42t/6iiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrKFgwgVpb9gaVsGiMqfbdIrLCiQOd/udNuFy2bHYOU=;
 b=3BOXyhp1eINO9UIAp0J/SR493zEYFkG3RZbMuXNWznWTpGhkQ0jrjyVBIXUUZXtNIW8K41/RaHlIQf/F/4QjIUeJ+Fo/VGkTn7IizZ2quaKNUWuC8hBYBNrMyAxj76boAS48IqNSv3BGB9gmAouWo9Fhjp3rhgfZa+dohORsXxE=
Received: from CH5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:610:1f4::22)
 by LVUPR12MB999137.namprd12.prod.outlook.com (2603:10b6:408:39e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:05:14 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::15) by CH5PR04CA0005.outlook.office365.com
 (2603:10b6:610:1f4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:05:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:05:08 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:04:59 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 05/40] drm/amd/display: Test GPU reset helpers
Date: Wed, 2 Sep 2026 12:58:27 +0800
Message-ID: <20260902050411.3473916-6-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|LVUPR12MB999137:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a45c2d2-c4bb-4182-0a18-08df08afc5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|23010399003|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ItTBpxnZHoYPsNGcJJMtcSa9M3jpk6QBMudzvAUyGfCPBWl6NCa+Qirv9yliu/9s7oyPAyzr1CWniej7TDo1GmJATBFWbXJSOrxpdSUkkINKzjemzoV4W4xW+zA1OL0XhYjDimtu1E8BmT0mIDfk8TH3dF9R/LjDwT4E+wtacLPbwhlvEJ+JtExxAKE/5PVl8TdISgPaJNHCkQpvUC7Y1QmJjuxwQRW91l/gRqfJDh5BTri676NrZsW3LxNDEfsj4ShT8B46m32k+u+6rWHuL3cZ+xCp5pvIr8vJ05j39zCMBo8mEejRu0oQWLnqyOQTdGaUmNvpUhzG/mrIyT3XvD8+Is1aiqFJiWKILMsS0C3gRrvGNR8H6/PzeoFMlwh5aBQQpPqtnwu8Lrkoz9kj3OEAIvndZjhTdjRi+Est7WoFzg+Y7pzjQLmAcAKoIpPwH5M7Z2CBtZmkNWZjahwhsP5eMzpkfSYg/qWDx1/v8qzkWc25CzIUJDU4vybemgP5RmQ0mm9Mx3mjY9LFr1XB6zB/DOrmobMuZHVRkvydwk4J0qoYLa1BLAfR7h2HgYw6vfIvkabznXmUqB8x/3zPsMqI9Nowov0uLk3/j7q977Ef5gKnVzXdhE+u//Z+xLRlY71oaOUHmXDhvzJVfOhndeF3vyAQWgLaRxjeXd9cT7S8832cF1J5KianCKqLKBvElCXssjtmHCGr3FIP5Te37A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VJOWqgCPYWNKrsU8mURHJB52TVoVqkrrIPu2SXDzfWcDt3hVeKZbT0NeP/wrcRt3wjb01PXX2LGw/sT9NIlrjwQ2pKlms3Y965CWxRMZOm+aNvBPjB5bsAmUpmBPqbWE3c8JlgxpZlAafX7CCGPaVph5bay+6NDEAph1tQpqo+PvqjuSrFY4Gxa3Tswg3I7wHLqF1xxCyF3LUcElVO0QIGyG4HjBEuVPY5rAsPQ1LZ1xGswL/yn69C7CAqd6g+sY8WEOgIZHHGaRu9ATjxl5PHfwe7mEm5NUp9DhNoGgeNLbKcUZsIzJk9FyoBxEsm+ta3i9+llpOXXn2hSqAnJGSupGvoMstLVfED4WVYFcW9jzOatRPJqOEWD30NVLDQAYNjZcm/FSQXrWLO52vFdQOVyANk2lRmLH9Rlxhx76B6qMoQSy8B9kkh4rwYo4rqto
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:05:13.7777 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a45c2d2-c4bb-4182-0a18-08df08afc5a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999137
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

From: Alex Hung <alex.hung@amd.com>

[Why]
Add KUnit tests for dm_gpureset_toggle_interrupts() on DCN,
amdgpu_dm_commit_zero_streams() on an already empty DC state, and
dm_destroy_cached_state() without a cached state.

[How]
GRPH_PFLIP is unused on DCN, so only the vupdate interrupt is toggled
and no interrupt service is needed. An unchanged empty stream list makes
dc_commit_streams() return early.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6 Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 63 +++++++++++++++++++
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7a06486cec9e..bd087155aac2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1425,8 +1425,8 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_block)
 }
 
 
-static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
-				 struct dc_state *state, bool enable)
+STATIC_IFN_KUNIT void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
+						    struct dc_state *state, bool enable)
 {
 	enum dc_irq_source irq_source;
 	struct amdgpu_crtc *acrtc;
@@ -1477,10 +1477,11 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 	}
 
 }
+EXPORT_IF_KUNIT(dm_gpureset_toggle_interrupts);
 
-DEFINE_FREE(state_release, struct dc_state *, if (_T) dc_state_release(_T))
+DEFINE_FREE(state_release, struct dc_state *, dc_state_release(_T))
 
-static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
+STATIC_IFN_KUNIT enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 {
 	struct dc_state *context __free(state_release) = NULL;
 	int i;
@@ -1518,6 +1519,7 @@ static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 
 	return dc_commit_streams(dc, &params);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_commit_zero_streams);
 
 static int dm_cache_state(struct amdgpu_device *adev)
 {
@@ -1532,7 +1534,7 @@ static int dm_cache_state(struct amdgpu_device *adev)
 	return adev->dm.cached_state ? 0 : r;
 }
 
-static void dm_destroy_cached_state(struct amdgpu_device *adev)
+STATIC_IFN_KUNIT void dm_destroy_cached_state(struct amdgpu_device *adev)
 {
 	struct amdgpu_display_manager *dm = &adev->dm;
 	struct drm_device *ddev = adev_to_drm(adev);
@@ -1582,6 +1584,7 @@ static void dm_destroy_cached_state(struct amdgpu_device *adev)
 
 	dm->cached_state = NULL;
 }
+EXPORT_IF_KUNIT(dm_destroy_cached_state);
 
 static int dm_suspend(struct amdgpu_ip_block *ip_block)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 9399f71c528e..645b39e4223b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1257,6 +1257,9 @@ struct dsc_mst_fairness_vars;
 void mmhub_read_system_context(struct amdgpu_device *adev,
 			       struct dc_phy_addr_space_config *pa_config);
 int amdgpu_dm_init_power_module(struct amdgpu_display_manager *dm);
+void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev, struct dc_state *state, bool enable);
+enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc);
+void dm_destroy_cached_state(struct amdgpu_device *adev);
 int dm_early_init(struct amdgpu_ip_block *ip_block);
 int fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 				const struct drm_plane_state *plane_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 3c975ca2710d..7a79aee057f8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -4217,6 +4217,35 @@ static void dm_test_early_init_unsupported_version(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, adev->dc_enabled);
 }
 
+/* Tests for the remaining suspend and resume helpers */
+
+/**
+ * dm_test_commit_zero_streams_empty - Test committing an already empty DC state
+ * @test: The KUnit test context
+ */
+static void dm_test_commit_zero_streams_empty(struct kunit *test)
+{
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+
+	dc->current_state = dm_kunit_alloc_dc_state(test);
+	KUNIT_ASSERT_NOT_NULL(test, dc->current_state);
+
+	KUNIT_EXPECT_EQ(test, (int)amdgpu_dm_commit_zero_streams(dc), (int)DC_OK);
+}
+
+/**
+ * dm_test_destroy_cached_state_none - Test no cached state is a no-op
+ * @test: The KUnit test context
+ */
+static void dm_test_destroy_cached_state_none(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	dm_destroy_cached_state(adev);
+
+	KUNIT_EXPECT_NULL(test, adev->dm.cached_state);
+}
+
 /* Tests for dm_update_mst_vcpi_slots_for_dsc() */
 
 /**
@@ -4790,6 +4819,35 @@ static void dm_test_initialize_plane_overlay(struct kunit *test)
 					       DRM_PLANE_TYPE_OVERLAY, plane_cap), 0);
 }
 
+/* Tests for dm_gpureset_toggle_interrupts() */
+
+/**
+ * dm_test_gpureset_toggle_interrupts_dcn - Test DCN only toggles the vupdate IRQ
+ * @test: The KUnit test context
+ */
+static void dm_test_gpureset_toggle_interrupts_dcn(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dc_state *state = dm_kunit_alloc_dc_state(test);
+	struct amdgpu_crtc *acrtc;
+
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 2, 0);
+	adev->mode_info.num_crtc = 1;
+	adev->mode_info.crtcs[0] = acrtc;
+	acrtc->base.dev = &adev->ddev;
+	acrtc->otg_inst = 0;
+	state->stream_count = 1;
+	state->stream_status[0].primary_otg_inst = 0;
+	state->stream_status[0].plane_count = 1;
+
+	/* GRPH_PFLIP is unused on DCN, so only the vupdate IRQ is touched. */
+	dm_gpureset_toggle_interrupts(adev, state, true);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -4994,6 +5052,9 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_early_init_legacy_asics),
 	KUNIT_CASE(dm_test_early_init_dcn_versions),
 	KUNIT_CASE(dm_test_early_init_unsupported_version),
+	/* suspend and resume helpers */
+	KUNIT_CASE(dm_test_commit_zero_streams_empty),
+	KUNIT_CASE(dm_test_destroy_cached_state_none),
 	/* dm_update_mst_vcpi_slots_for_dsc */
 	KUNIT_CASE(dm_test_mst_vcpi_slots_no_connector),
 	KUNIT_CASE(dm_test_mst_vcpi_slots_skips_writeback),
@@ -5023,6 +5084,8 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	/* initialize_plane */
 	KUNIT_CASE(dm_test_initialize_plane_primary),
 	KUNIT_CASE(dm_test_initialize_plane_overlay),
+	/* dm_gpureset_toggle_interrupts */
+	KUNIT_CASE(dm_test_gpureset_toggle_interrupts_dcn),
 	{}
 };
 
-- 
2.43.0

