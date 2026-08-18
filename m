Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE0CC5DF8B
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6715110ECC8;
	Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s9Ndp22y";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013047.outbound.protection.outlook.com
 [40.93.196.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA0610ECBF
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpDd4Auq4hlilwWw3gvGbUBqHfD4sWku9o8ScOItMt58X/o7WdtB5AWTwh0i3UksdyNns2iSFxLORCuieUrYuo9YsgHo1CtkNrkefjA6W5gLNHl3S6OS+iYE+Y0fS+ezhZDJUJ9wIY7hP/fTEWp6asEh4z0Wr0VDOSqWqsMqSPItnqorzbQMbzHk95+s0bYTLqh9k99waoOatOu3Zkk12gqzirISLLLjvExCwsgwoYPkMQ8lj3CD7fVzmB3c3IJg+TBT8nr/4JglRxvbQXM2aC6vHBh1Ift8oLT0zEnr9akSPZ+/IZojwr9KyUmaJTeUrGUnWxIMnKU9Z3L7Kq72OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBNx43bRjVLrRtaZxP1+QRWXri69NuiLksKOx31XVyQ=;
 b=azXLTyJZ69ATNrlUDRDwkqp66V4mCeeeMnJoL+loHY0CDutDauVx7ldcpTBwmIfq4xHqwCBLP5/Z8rteqjs8C4At4QPwZvt1IXKorATwKQi/bEypDk1sb75Wpt4K1fc4ZjzpGXNXsc08bJjmaUYGkigb46Ui/mwEZgpeg2+RudQyRCmQ5kEhBgdLb9Ob8ForHBloyLn0824lQqV5QA+RhT4Lumw4gHkk+eG3VWNri4LcVk28SKNA2UR5FvLdVoc1GsbqrphYuOOhUp2RWhyXaRckRBQeFz5CTmqpz5SlLuDYQiC+bP7qrA3GuTslcNzsyJyA4uiARS1vvexYu4RFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBNx43bRjVLrRtaZxP1+QRWXri69NuiLksKOx31XVyQ=;
 b=s9Ndp22ygyOffZ12ce+A2o9VLbNhcUKYdHy8X7v/nJHolX8Ppe28+FNThCteK9mUiygNzHUI9ZBGk/BGz/V6pfP6SGBlctfRQkGv9+1oSx1vLZbITE0OzfeLHukg0xAvpkBj1mxmMvTfOkmDAJWQ2wSrWJIUTUGIDds9jviC0JY=
Received: from CH5P222CA0016.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::23)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:43 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::b) by CH5P222CA0016.outlook.office365.com
 (2603:10b6:610:1ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:36 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:35 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 59/82] drm/amd/display: Cover create_eml_sink valid EDID path
Date: Tue, 18 Aug 2026 16:15:51 -0400
Message-ID: <20260818202139.4172592-60-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f5ae026-1e36-424a-16bc-08defd66754b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NMuya74hxxppHOxfNQo4O1VWpGoqZuRmXMwxWYzd1wndMwGuph4mWLJIWt43iQqdustIVFfZPmZbsSpKVNW1bm6DbeOt56GJVl7OWCYmngH/8JxgundXvKAaFsNP83rG1IQtPXLY3OzMWt/DBUuqEbCx/t9J96o6enQG9H0ak6U2BfdqvF4E1dTpGKEwCxsQhY5h1vt6BYFe3smO/JiLTGt/9ITqZQFmgl5p98ktN3ohmLWotjghZB2BBT2bhthj1Y80+N0/LYW4dHH52nbe5695OnclOAhJ8S9QCB5pgijTv5NLA+ccXLqAhbaNH9pd66WkY/O86hM8fImwA2c7opvrvXgOjE+lsNok0ZuKjaQhl+kGhEyUvR2a0K6ZDk/I3FkkxpqCG7IXPjgiiqCHGXeiWx7WoT40YjmckQQ4i4m7XqGVhqdskjwCo+ithANHvTvb6Y6T2fLSFmVkOQiLsodsKsVJA43B5QvJLo6aTkV1IpFhDROsMBA+k0t5v1+fB0PBOpeXqrXODbaz1L28hMkjp8LVW+gGXbddcql3TPU3lSrv0Sk3cI84gBoCCy56m+TIyuzpoyOX9CUkT7CiKlhNwSfpX7Yz9TbiPu4XCsLxiyzzYAhYvkhjn8U5GHSl4biHFuG33o1YI4QpW4oBhqfejnDY3U/6RqtS++nZBwwCbUr2aN192jk6wQEJnuaqVwLLB5Mlu3GgDBBPADPeqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hcf7iMCihjHzwGzkUWIAB9uEJnipkgy1dyG3Ykam6gI6LmrgE43OXEekCdS5J/gZX6F389x7zvDPCJKqdhmb1YFj64p6iYsXyVhm9tY1wI+vVrg3P1E0z0oF4cwjSRM4O+SO6RH79zN/LY8eZA4dM8gAJKoGkhM8fV7k7Q2kG9EnxuIakVoFOk8PdIMn4uxtVvKLtwallDD1t6FRKVguRgYBVwezWsdng5haa/Rrc3S2bnrFziSMJL+zb1Yx2/9oZr5SAl85fsttFipm/wY42q0WdAKOWYLRgkstoHPww25RDtym+4DLpxpTawVT0YtFuM7vvkCwk+4RDm/vRv/SO6rMDtSowd5G19MhLqhzMwuJVpgtE3zJHe3nu4ZyOPHyGI3/0ivyDBFyroA2Z3dzY0IcKaj1Ke2qixgFS2l1UZFOGEen9rnWI9WJZezskEsm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:42.9121 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f5ae026-1e36-424a-16bc-08defd66754b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Add KUnit tests driving create_eml_sink() through the valid-EDID
branch: reading the EDID over DDC, and the forced-on paths using an
emulated sink and a cached local sink.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index fc6b6013d1188..120d0e27f5eed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -7171,6 +7171,138 @@ static void dm_test_funcs_force_reads_edid(struct kunit *test)
 	ctx->aconnector->drm_edid = NULL;
 }
 
+/* Tests for create_eml_sink() with a valid EDID */
+
+/*
+ * create_eml_sink() reads the EDID off the connector DDC and, on success,
+ * installs an emulated sink from link_srv->add_remote_sink(). A non-AUX link
+ * selects the connector i2c adapter (serving dm_test_uad_edid) and a fake
+ * add_remote_sink() returns dm_test_ces_remote_sink, so the full EDID path
+ * runs without real hardware or DC.
+ */
+static struct dc_sink *dm_test_ces_remote_sink;
+
+static struct dc_sink *
+dm_test_ces_add_remote_sink(struct dc_link *link, const uint8_t *edid,
+			    unsigned int len, struct dc_sink_init_data *init_data)
+{
+	return dm_test_ces_remote_sink;
+}
+
+static void dm_test_ces_setup(struct kunit *test, struct dm_test_edid_ctx *ctx,
+			      struct dc_sink *em_sink)
+{
+	struct amdgpu_i2c_adapter *i2c;
+	struct link_service *link_srv;
+	struct dc *dc;
+
+	i2c = kunit_kzalloc(test, sizeof(*i2c), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, i2c);
+	i2c->base.algo = &dm_test_force_edid_i2c_algo;
+	i2c->base.lock_ops = &dm_test_force_edid_lock_ops;
+	ctx->aconnector->i2c = i2c;
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	link_srv->add_remote_sink = dm_test_ces_add_remote_sink;
+	dc->link_srv = link_srv;
+
+	ctx->link->dc = dc;
+	ctx->link->aux_mode = false;
+	dm_test_ces_remote_sink = em_sink;
+}
+
+/**
+ * dm_test_create_eml_sink_reads_edid - Test the valid-EDID path builds a sink
+ * @test: The KUnit test context
+ *
+ * With a readable EDID and force unspecified, create_eml_sink() caches the EDID
+ * in drm_edid and installs the emulated sink while leaving dc_sink untouched.
+ */
+static void dm_test_create_eml_sink_reads_edid(struct kunit *test)
+{
+	struct dm_test_edid_ctx *ctx =
+	dm_test_edid_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dc_sink *em_sink;
+
+	em_sink = kunit_kzalloc(test, sizeof(*em_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, em_sink);
+	dm_test_ces_setup(test, ctx, em_sink);
+	ctx->aconnector->base.force = DRM_FORCE_UNSPECIFIED;
+
+	create_eml_sink(ctx->aconnector);
+
+	KUNIT_EXPECT_NOT_NULL(test, ctx->aconnector->drm_edid);
+	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_em_sink, em_sink);
+	KUNIT_EXPECT_NULL(test, ctx->aconnector->dc_sink);
+
+	drm_edid_free(ctx->aconnector->drm_edid);
+	ctx->aconnector->drm_edid = NULL;
+}
+
+/**
+ * dm_test_create_eml_sink_force_on_em - Test force-on adopts the emulated sink
+ * @test: The KUnit test context
+ *
+ * With DRM_FORCE_ON and no local sink, create_eml_sink() adopts the emulated
+ * sink as dc_sink and retains it.
+ */
+static void dm_test_create_eml_sink_force_on_em(struct kunit *test)
+{
+	struct dm_test_edid_ctx *ctx =
+	dm_test_edid_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dc_sink *em_sink;
+
+	em_sink = kunit_kzalloc(test, sizeof(*em_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, em_sink);
+	kref_init(&em_sink->refcount);
+	dm_test_ces_setup(test, ctx, em_sink);
+	ctx->link->local_sink = NULL;
+	ctx->aconnector->base.force = DRM_FORCE_ON;
+
+	create_eml_sink(ctx->aconnector);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_sink, em_sink);
+	KUNIT_EXPECT_EQ(test, kref_read(&em_sink->refcount), 2);
+
+	drm_edid_free(ctx->aconnector->drm_edid);
+	ctx->aconnector->drm_edid = NULL;
+}
+
+/**
+ * dm_test_create_eml_sink_force_on_local - Test force-on prefers the local sink
+ * @test: The KUnit test context
+ *
+ * With DRM_FORCE_ON and a local sink present, create_eml_sink() adopts the
+ * local sink as dc_sink instead of the emulated one and retains it.
+ */
+static void dm_test_create_eml_sink_force_on_local(struct kunit *test)
+{
+	struct dm_test_edid_ctx *ctx =
+	dm_test_edid_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dc_sink *em_sink;
+	struct dc_sink *local_sink;
+
+	em_sink = kunit_kzalloc(test, sizeof(*em_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, em_sink);
+	local_sink = kunit_kzalloc(test, sizeof(*local_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, local_sink);
+	kref_init(&local_sink->refcount);
+	dm_test_ces_setup(test, ctx, em_sink);
+	ctx->link->local_sink = local_sink;
+	ctx->aconnector->base.force = DRM_FORCE_ON;
+
+	create_eml_sink(ctx->aconnector);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_sink, local_sink);
+	KUNIT_EXPECT_EQ(test, kref_read(&local_sink->refcount), 2);
+
+	drm_edid_free(ctx->aconnector->drm_edid);
+	ctx->aconnector->drm_edid = NULL;
+}
+
 /* Tests for amdgpu_dm_connector_get_modes() */
 
 static enum dp_link_encoding dm_test_gm_enc_8b10b(const struct dc_link_settings *s)
@@ -7801,6 +7933,9 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_hdmi_cec_unset_edid_no_notifier),
 	/* create_eml_sink */
 	KUNIT_CASE(dm_test_create_eml_sink_no_edid),
+	KUNIT_CASE(dm_test_create_eml_sink_reads_edid),
+	KUNIT_CASE(dm_test_create_eml_sink_force_on_em),
+	KUNIT_CASE(dm_test_create_eml_sink_force_on_local),
 	/* handle_edid_mgmt */
 	KUNIT_CASE(dm_test_handle_edid_mgmt_dp_sets_link_caps),
 	KUNIT_CASE(dm_test_handle_edid_mgmt_non_dp_leaves_caps),
-- 
2.43.0

