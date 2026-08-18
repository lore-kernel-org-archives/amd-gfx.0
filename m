Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BF4C5DF86
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E2B10ECA9;
	Tue, 18 Aug 2026 20:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x1HaV6KQ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DE310EC9C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjkIjFklxUnPZO+8dQJlO3Rtsb7PJOxlW1a7EtTozVNJWW8o13W9cp7A3eVamrdZV9jEQxFEouNew6nmS/7glPXczWVOA5hjLID2OxjCYl+wKKgWmxWBBJDnubpBV/F84swYLoeLUGwjsml69yAMsj/3wNtR2OQqCLrwcTL22pKRjVFLhManQbiRcDxZLKIndmpZhkwxj9ebjwyP9zH5wyk7moViFrD10Bmpkrgpe7XM1w2xySx/LsPbHAsX131WPm9zirRpaqkiXdO2V9HU0GtovayEDBvtpoAHnbwwq6lbnZzH/5aB7JC/WIBorUKsKH5w9Uf2J4LyAc7D5Cilug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8OxKa0SfgKumOFGm8hVyudha7ETNrfBxIPgnQx1Q9w=;
 b=fgw715jIDjmGthGUGAIHASvgtGsZZGK/x+U3s/CmVjCoVlVqCzooHnqFurHmxkGtkQK2nryytUKA3RkexVQ3n5jwAlC7sKOC8FK89/UW8e1+r9xHuFFsP3reoFwMwnmPL1RNl72XANmpbY8WTLYMsRDlO98bmGCoS1Prv3vVnjbCCnSpSBP7ZrBi4JBO3CTprv/hxpHnYYK0kjjV3t095qLsL2L96Ju9ETeOXAVoBX6PB3JQw10sALPRLxQ+ky9keoiP+8EShmQrepQiuBjCVqyjlptlnRonAyw18i9wSbw43Xi+qRH+uJ0cBvTlAuJgC6gJSf4UDumbC7IuCwM4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8OxKa0SfgKumOFGm8hVyudha7ETNrfBxIPgnQx1Q9w=;
 b=x1HaV6KQ8PfTn0lpr4ijwJ4Hn/5RNOvXTrbVX0lE27demKj6vPDOinPODekjnoHD5s1VmRMgGf6WGCrpG7zun8di+XEheDIZIKO3n4hab9MOwRyftMlQu4cd6DkFw2ide52yUx6YFznEiVQl7EXwX9pgP/nreSHmXbRC1kUPRyo=
Received: from CH5P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::29)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:31 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::a5) by CH5P222CA0018.outlook.office365.com
 (2603:10b6:610:1ee::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:31 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:23 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:23 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 42/82] drm/amd/display: Test MST connector register and
 unregister
Date: Tue, 18 Aug 2026 16:15:34 -0400
Message-ID: <20260818202139.4172592-43-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|BN3PR12MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 9622a08d-6738-4570-cc6e-08defd666e91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8Ksu+ELNHIPhIDfLb3BFIVPWVFHvU48+yLdPg1ggdtgw8dRch+JfuQEAGYIqObl8qCYd0wcYdGX94kfwsjh1XskYgTqqm0LWVmeRxA36beA9PxgKoTukj/5uIhOzQJjTw8VfnvFLIUooWMKnhnSqHLFgYE3hz/wIB/ad7/+s5vEa+EfzD0NewDQSQAPNKUotpUCAup9T0bcx39ThFIHYmYE1TLM2+HGhflFjh5Sr/SdgGZ8nsdimRVAgYFzjbulkUOF7gPv4bE4pIaYlpPn7UJqBxAKOhBn8suu1u+MZAlwvK8eAJPoj6oNNZcEa2Mh+QhoW59b30kGwJwwyofRgL4MUvf41asnL0oo7WjH3t9JphlIZXYj51lnOv9+rE7pUj3K0wUDLdIZlEXzkIvsu7Utxzpp4XL5B/2TfuvbiJv1DRWYaVOzKmM+QPPjZR7MyNdh82souWsfP1q0Q8ufC70DC+zxyitgQp8Kg7caJvZfw243Yv/9mJrSlxb8yCrWgMD3PjTs4EiKDXoET4k4e8H97ZEWJL0WQdBSuf4te4zqV2Q0KN8u5uyFlgf6SV2mEpxMQQxAIgG6cZi23067k4ZOYPvtaOqtrsaPTIIA3uG/aWHT7phmzngCV0+9jCZZ1N44O7jDSjpN0QHhPiY01twU2Y5nyfJvFzQJP11ASRh2DAsAqSfzQyKpV2XrYcvOQgDkWdF2OQEf9EfTJr9QtZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NJpCbYpNkn/UItWlUbdPO09Jqnoc1u7yycgSYqD0YRkWwcMO7Q4jZzT43Eh9jvYHW9M85FcUYXpcqSsfK9Et8VZfVhdvdpTCnKwP5QUNaHlMXyLJVl5botmpr8VDLqp8HM6pauK0CsXVfqzSW5EmwTgZ81vsmQnzqtDK3oYxqrvKpZF0Ra/XbR1vtpgytsU7NNFfxin1+YrTepK48h0RjXwiHHdQ/a54csSGg8ZIXFK4sLSt7Fx/08XAiE+ayhWozMzDfLYIdadivt0KQzZx5DvEFH/pKM/cLgBKjKP4XBdqlO3w+0r8+ToLf1fpXYMvbpCz9zUthYzi3mvovY/SsbSJDwIUiSZ+b6YJFoyl2WINIg5YXIYgjSgdEFxc9FQExUhBI+Tr9LH5Rm0G52qaH+2b146fav3qbr8fgAMM6GAyULxg1jjoglbjl4QLBV1J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:31.6336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9622a08d-6738-4570-cc6e-08defd666e91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572
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

[WHAT]
Add KUnit tests for amdgpu_dm_mst_connector_late_register() and
amdgpu_dm_mst_connector_early_unregister(), covering the remote AUX bus
registration, the unregister that only resets the MST status when no
remote sink is attached, and the unregister that removes the sink from
the DC link and clears the MST connector state.

[HOW]
The tests reuse the MST downstream connector fixture, which already
provides the kernel device the DRM MST helpers log through and the
modeset lock the unregister path takes.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  6 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  2 +
 .../tests/amdgpu_dm_mst_types_test.c          | 79 +++++++++++++++++++
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 79e8952edf8c0..693fd782283bc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -187,7 +187,7 @@ dm_dp_mst_connector_destroy(struct drm_connector *connector)
 	kfree(aconnector);
 }
 
-static int
+STATIC_IFN_KUNIT int
 amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -205,6 +205,7 @@ amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_mst_connector_late_register);
 
 
 STATIC_IFN_KUNIT void
@@ -218,7 +219,7 @@ amdgpu_dm_mst_reset_mst_connector_setting(struct amdgpu_dm_connector *aconnector
 }
 EXPORT_IF_KUNIT(amdgpu_dm_mst_reset_mst_connector_setting);
 
-static void
+STATIC_IFN_KUNIT void
 amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector =
@@ -251,6 +252,7 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 	aconnector->mst_status = MST_STATUS_DEFAULT;
 	drm_modeset_unlock(&root->mst_mgr.base.lock);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_mst_connector_early_unregister);
 
 static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 406dba95c4aec..63130226e67eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -119,6 +119,8 @@ int dm_dp_mst_atomic_check(struct drm_connector *connector,
 int dm_dp_mst_detect(struct drm_connector *connector,
 			     struct drm_modeset_acquire_ctx *ctx, bool force);
 int dm_dp_mst_get_modes(struct drm_connector *connector);
+int amdgpu_dm_mst_connector_late_register(struct drm_connector *connector);
+void amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector);
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 6c0d5d233dcf1..6d920bc783d54 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -1818,6 +1818,80 @@ static void dm_mst_test_detect_disconnect_releases_sink(struct kunit *test)
 	dm_mst_test_fini_child(&child);
 }
 
+/* Tests for amdgpu_dm_mst_connector_late_register */
+
+/**
+ * dm_mst_test_connector_late_register - Test MST connector late registration
+ * @test: KUnit test context
+ *
+ * amdgpu_dm_mst_connector_late_register() must register the port's remote AUX
+ * bus and report success.
+ */
+static void dm_mst_test_connector_late_register(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+
+	dm_mst_test_init_child(test, &child);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_mst_connector_late_register(&child.aconnector->base), 0);
+
+	dm_mst_test_fini_child(&child);
+}
+
+/* Tests for amdgpu_dm_mst_connector_early_unregister */
+
+/**
+ * dm_mst_test_connector_early_unregister_no_sink - Test unregister without sink
+ * @test: KUnit test context
+ *
+ * With no remote sink attached, amdgpu_dm_mst_connector_early_unregister() must
+ * only reset the MST status.
+ */
+static void dm_mst_test_connector_early_unregister_no_sink(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+
+	dm_mst_test_init_child(test, &child);
+	child.aconnector->mst_status = MST_REMOTE_EDID;
+
+	amdgpu_dm_mst_connector_early_unregister(&child.aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_remove_remote_sink_calls, 0U);
+	KUNIT_EXPECT_EQ(test, (int)child.aconnector->mst_status, (int)MST_STATUS_DEFAULT);
+
+	dm_mst_test_fini_child(&child);
+}
+
+/**
+ * dm_mst_test_connector_early_unregister_releases_sink - Test sink release
+ * @test: KUnit test context
+ *
+ * When the port leaves the topology, amdgpu_dm_mst_connector_early_unregister()
+ * must remove the remote sink from the link and reset the MST connector state.
+ */
+static void dm_mst_test_connector_early_unregister_releases_sink(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+	struct dc_sink *sink;
+
+	dm_mst_test_init_child(test, &child);
+
+	sink = dm_mst_test_alloc_sink(test);
+	child.aconnector->dc_sink = sink;
+	child.aconnector->vc_full_pbn = 42;
+	child.link->sink_count = 1;
+
+	amdgpu_dm_mst_connector_early_unregister(&child.aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_remove_remote_sink_calls, 1U);
+	KUNIT_EXPECT_PTR_EQ(test, dm_mst_test_removed_sink, sink);
+	KUNIT_EXPECT_NULL(test, child.aconnector->dc_sink);
+	KUNIT_EXPECT_EQ(test, child.aconnector->vc_full_pbn, 0U);
+	KUNIT_EXPECT_EQ(test, (int)child.aconnector->mst_status, (int)MST_STATUS_DEFAULT);
+
+	dm_mst_test_fini_child(&child);
+}
+
 /*
  * Sideband connector with a live topology manager and the DOWN_REP ready bit
  * armed, so dm_handle_mst_sideband_msg_ready_event() reaches its ack path.
@@ -1978,6 +2052,11 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_get_modes_cached_edid_sink_alloc_fails),
 	KUNIT_CASE(dm_mst_test_get_modes_restores_hdcp_properties),
 	KUNIT_CASE(dm_mst_test_get_modes_reads_remote_edid),
+	/* amdgpu_dm_mst_connector_late_register tests */
+	KUNIT_CASE(dm_mst_test_connector_late_register),
+	/* amdgpu_dm_mst_connector_early_unregister tests */
+	KUNIT_CASE(dm_mst_test_connector_early_unregister_no_sink),
+	KUNIT_CASE(dm_mst_test_connector_early_unregister_releases_sink),
 	/* CONFIG_DRM_AMD_DC_FP disabled public paths */
 #if !defined(CONFIG_DRM_AMD_DC_FP)
 	KUNIT_CASE(dm_mst_test_fp_guarded_public_stubs),
-- 
2.43.0

