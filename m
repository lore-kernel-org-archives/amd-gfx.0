Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A98C5DF86
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BEE810ECAF;
	Tue, 18 Aug 2026 20:22:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nj+li+VS";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD67210ECAB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHcKVxHsRCqdwzRhlZSjSGgNRrpevjYj6mXNOeeum+Pw797Ec6fzW+Vv3Nb2C39xnIt/E7RoEHKDca4pR8gMFM3Hv2bzyw06X6kK841wfSF+k8eyZisS0Vc4Zz+gYl3OOt76TyTQTZmWthLDklSuoPsLPTSayms1WKByHzh53Qyi8op52xTv+1cUOkCzOVgAnMlWml2eJHlUIlFNXKfDvKgltwYsTo7wtUCdiyargiod7+Dn9YUajnOcJV27cUS/KsWk5DemBjn/ImU6vqSnXxAZMH09pnAwrS8uP3ZneP5kBAgklAH0f1kBi3ggR+aaJQU3poAWGGGcr4ODotvO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRSxhZlmtZAz9GtTbkJigD7k0kZ+hbnEH/ey8bxQbEg=;
 b=CHuOoKHjuktaquDfvrDjOsa7uzGxzApAWw7KbsTrFiKiRn8RsWG45ZvsPsx/DwMy1A07NqOUeTS81dJsMHjE7i2e/6LM2Bo00a/AozV2WmttbcvDP1HfHmEUU0T9W7NMIF2quWag/UMF4/VRyTO6QzSDmQyiRZ8f8poGgx3D3Y2DeD+W4s7g5AltwxOeSEL/omdb/p0f+sIJyn7/rMB1WmNX5ahQdvZDyoaFOEqQwO8kiOGzVU1kGj/DBF/CIbdb46n9Rn6vowsKi+JYujvYhbV6ixyG36K4SlUb7OstIw647elHl9XcQHVZ0UXy8SMw3FvVs5jsLkoo84LV/SpwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRSxhZlmtZAz9GtTbkJigD7k0kZ+hbnEH/ey8bxQbEg=;
 b=nj+li+VS5uYcW63lg9y/br0ZOK7BO8wJj/s0PiJyFRJWavC1mDZv2B/V9AMNcuV7TQ/fnjbawGIPlIoFLK9gfn+zmed44rpRPdQU4W2oGPQxqFwtw7vZ99ry7dZ77gOqm1HkwTVo/03RLqP0K5GTO4Vyk2YLC5cLP8WuOwkV18o=
Received: from CH5P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::10)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:32 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::84) by CH5P222CA0021.outlook.office365.com
 (2603:10b6:610:1ee::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:24 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:24 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 43/82] drm/amd/display: Test dm_dp_mst_connector_destroy
Date: Tue, 18 Aug 2026 16:15:35 -0400
Message-ID: <20260818202139.4172592-44-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a32752c-d1b3-4700-8f23-08defd666ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vjol7hwh3MC9rw9zMn3LWveKzEmpQTY14PiHlFM8T2OZKvnEm207JglBjxbCCIv2iK8TeArD/f4nlrzAzfpKI74nGmHqi/xrXPT58vs/xnnspSPJGQrny5MkwmQ/BEi1q178jRhtLfPIQ6zF82+yP0XjvI4fJSobYz34VUmO3WTmaMqzf9vX0dXuek3bPjZ2butoQFukyvr7tTkxb4QbDQPUl6fILyNq2L2TyRzpJFk2radTbQJD63/ES+Sux9ibkW0YMtUIEW7iMCzt7oFq/2iRr5kajVd5w3xaYjVZTtsPLPTWG+mErIfz0CVNZAdpV7pS4sZ/OOlhpAcZ6PNfusNa/X+SWFX53SzS5DlbZmp5wApLf0+ggjnrKkAKi8g4TdBgsh2uCtSEivmdcLODXU6lKeQF6YTVE28kXLuBu4LpJnd+twjzLAV4/6XriPt9tM5AG+gJdYaY0LQ2vZCZGhjkhBFBfNAZucaRxpv45oszyTuqDg6zp22oF6UQYpQz6FQLo6eHvtRoVs3QKjG5QpXj25g7o3EJbW9Te5EUAEDsrkXGr3JUpABZS00/QCA9IbaHnQSj61lOdcNpjSKy9AnOoliF8MYNcEvHG0jLAwSyxE6hFFynMCo9XirlzSU6Md1pXYPhem87vflIWbqc7PFAPhb4L1lpdR9BmZ5iAeo6hlwAhNSmAhZc/XeyiMEhP+Uc2kgcStqSoaLagPoPIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P6b5J3xOWUjN3IzvVoFrAnTDkpnMsFvL14kt+NNhVf3gR8q2MPIK6FmPe1q3iaokxzEFOpW3KeuyOKsJe+H+bsaS9CXCYj225PidYFRuZnzw3RGKs3TVc0XL+NMhSC3kEX+GPzzzgCzkHOhH+GN/wky1mOlR9TcDegoWoWBNjDIXcD2J+QuGpuwTYUWE9gL8I1Vos8IhkbwOT3d0kaoSTxhP164gEywaVLqkOIxDMFQgrGgcvjIP9QAl376DFGJrCMjsEYacmzaiTlRgIZ7EuX6mY9HDTuFdondQIsxnWe5jOGMc2nXXG09iSQVwc5pWeuBb48elET0C2zIELm7m+Easr8ImXwXjSnNO+jwXHbGDfYoXJ2s9VXQv2R5gAsV8hgDMK8cJIxT3KyNv8/gXLQs7cQK4QxXF/FThIDPtvQvyUsjGySjm755EudNSKskj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:32.1756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a32752c-d1b3-4700-8f23-08defd666ee4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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
Add KUnit tests for dm_dp_mst_connector_destroy() covering the teardown
of a connector that never had a remote sink, and the teardown that first
removes the remote sink from the DC link.

[HOW]
The function frees both the connector and the MST port, so the test
allocates them outside the KUnit managed allocator. The parent branch
device takes an extra malloc reference so it survives the port teardown.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  3 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |  1 +
 .../tests/amdgpu_dm_mst_types_test.c          | 95 +++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 693fd782283bc..bce605fd6cdf1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -168,7 +168,7 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux,
 }
 EXPORT_IF_KUNIT(dm_dp_aux_transfer);
 
-static void
+STATIC_IFN_KUNIT void
 dm_dp_mst_connector_destroy(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector =
@@ -186,6 +186,7 @@ dm_dp_mst_connector_destroy(struct drm_connector *connector)
 	drm_dp_mst_put_port_malloc(aconnector->mst_output_port);
 	kfree(aconnector);
 }
+EXPORT_IF_KUNIT(dm_dp_mst_connector_destroy);
 
 STATIC_IFN_KUNIT int
 amdgpu_dm_mst_connector_late_register(struct drm_connector *connector)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 63130226e67eb..50dca0ef98fea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -121,6 +121,7 @@ int dm_dp_mst_detect(struct drm_connector *connector,
 int dm_dp_mst_get_modes(struct drm_connector *connector);
 int amdgpu_dm_mst_connector_late_register(struct drm_connector *connector);
 void amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector);
+void dm_dp_mst_connector_destroy(struct drm_connector *connector);
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 6d920bc783d54..064af0022fb62 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -1892,6 +1892,98 @@ static void dm_mst_test_connector_early_unregister_releases_sink(struct kunit *t
 	dm_mst_test_fini_child(&child);
 }
 
+/* Tests for dm_dp_mst_connector_destroy */
+
+/*
+ * dm_dp_mst_connector_destroy() frees both the connector and the MST port, so
+ * they are allocated outside the KUnit managed allocator. The parent branch
+ * device takes an extra malloc reference so it survives the port teardown.
+ */
+static struct amdgpu_dm_connector *
+dm_mst_test_alloc_destroyable_connector(struct kunit *test, struct dm_mst_test_child *child)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_branch *mstb;
+	struct drm_dp_mst_port *port;
+	int ret;
+
+	aconnector = kzalloc_obj(*aconnector);
+	port = kzalloc_obj(*port);
+	mstb = kunit_kzalloc(test, sizeof(*mstb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+	KUNIT_ASSERT_NOT_NULL(test, mstb);
+
+	mstb->mgr = &child->root->mst_mgr;
+	kref_init(&mstb->malloc_kref);
+	kref_get(&mstb->malloc_kref);
+
+	port->mgr = &child->root->mst_mgr;
+	port->parent = mstb;
+	kref_init(&port->malloc_kref);
+
+	aconnector->dc_link = child->link;
+	aconnector->mst_root = child->root;
+	aconnector->mst_output_port = port;
+
+	ret = drm_connector_init(&child->adev->ddev, &aconnector->base,
+				 &dm_mst_test_connector_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	return aconnector;
+}
+
+/**
+ * dm_mst_test_connector_destroy_no_sink - Test destroy without a remote sink
+ * @test: KUnit test context
+ *
+ * dm_dp_mst_connector_destroy() must clean up the DRM connector and drop the MST
+ * port reference even when no remote sink was ever attached.
+ */
+static void dm_mst_test_connector_destroy_no_sink(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_mst_test_child child;
+
+	dm_mst_test_init_child(test, &child);
+	aconnector = dm_mst_test_alloc_destroyable_connector(test, &child);
+
+	dm_dp_mst_connector_destroy(&aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_remove_remote_sink_calls, 0U);
+
+	dm_mst_test_fini_child(&child);
+}
+
+/**
+ * dm_mst_test_connector_destroy_releases_sink - Test destroy releases the sink
+ * @test: KUnit test context
+ *
+ * dm_dp_mst_connector_destroy() must remove the remote sink from the DC link
+ * before tearing down the connector.
+ */
+static void dm_mst_test_connector_destroy_releases_sink(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_mst_test_child child;
+	struct dc_sink *sink;
+
+	dm_mst_test_init_child(test, &child);
+	aconnector = dm_mst_test_alloc_destroyable_connector(test, &child);
+
+	sink = dm_mst_test_alloc_sink(test);
+	aconnector->dc_sink = sink;
+	child.link->sink_count = 1;
+
+	dm_dp_mst_connector_destroy(&aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_remove_remote_sink_calls, 1U);
+	KUNIT_EXPECT_PTR_EQ(test, dm_mst_test_removed_sink, sink);
+
+	dm_mst_test_fini_child(&child);
+}
+
 /*
  * Sideband connector with a live topology manager and the DOWN_REP ready bit
  * armed, so dm_handle_mst_sideband_msg_ready_event() reaches its ack path.
@@ -2057,6 +2149,9 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	/* amdgpu_dm_mst_connector_early_unregister tests */
 	KUNIT_CASE(dm_mst_test_connector_early_unregister_no_sink),
 	KUNIT_CASE(dm_mst_test_connector_early_unregister_releases_sink),
+	/* dm_dp_mst_connector_destroy tests */
+	KUNIT_CASE(dm_mst_test_connector_destroy_no_sink),
+	KUNIT_CASE(dm_mst_test_connector_destroy_releases_sink),
 	/* CONFIG_DRM_AMD_DC_FP disabled public paths */
 #if !defined(CONFIG_DRM_AMD_DC_FP)
 	KUNIT_CASE(dm_mst_test_fp_guarded_public_stubs),
-- 
2.43.0

