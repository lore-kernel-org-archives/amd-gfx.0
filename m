Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AE7C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4DC110ECCA;
	Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VtLglq4n";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011055.outbound.protection.outlook.com
 [40.93.194.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0DE10E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVctGhnX2ikPUQAEIsstkKAMjlDJOoUkzDMYgDLTHhXq3mLtoiMaSjwuWnl5tRdRcP9N/W4QdZ3PbizImsJYYnrPaMZKNQw8y2j5Dz0Tb8chvaASzXMe+6KFXsb0DD/CA6b7CC6B1oRRdRI7RCweEFb6dmujN6dadAvZVk1HauMnDN5T4VSiQI52OtmToboFoGMqQ8yOXmzMR+zj60WjvI3DKaoPCwH0bk0vej8r3LsKJue5TuZ0z86/MtOm7/wGkNXzbbHmDt/MtvNCoVgn9MulIhiTyMrCkYh3aTBmDYlTRCT8rSRAC8/D/X9mo0lyLEm7dMaNcyRXUsM4Wq44Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVO48kjV4BQWMi8vbwXiITNDxtw4W5lMklujpVyxr/k=;
 b=JbEJGDBcuFqiYB9HPfWHjmtNc3F3iEU9MoTlXrVPR3s1yBdWm57/Dzv107oouDPn751Jd3vK46ss+S/oDVOIAVQtw8LRru8kL8mxWFeWuzZn/Ix3jvXHi8sp/HLm4gQz/sfWFvaYXSPNagMdnqS5xumCqSEtbkjP/OuTGGu345mC5G53AzqPbhg2A9MiR/mPJ0P7FU3PATtzAvkxHGf7uFeQW8T+UguNduWaASte07HBFdkrwJzpot4AZdSv77xu53v/P2kldj+KUcORo8kHCvJ+CBsj1Wcg6Go4J27oGmZt/q5v2589aLtVEVBeGH0wKbZZqIVYDj9nf59vgmiwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVO48kjV4BQWMi8vbwXiITNDxtw4W5lMklujpVyxr/k=;
 b=VtLglq4nfGh6JGBZ4Tokfe8WTfcxMS7Brv2VyI6paIeU8T/JXJeIQpIqZb+OBr7tu6gmuhEezoOLi+ODU0BP9mJYXlbrGiOAVWl+RKr6sDo0RCaCwZzZigbLxOedjIK+sbc+VpxhS6tEntPJY/4ZA0aIkagvZmVMUciaOnHXr4w=
Received: from BN9PR03CA0562.namprd03.prod.outlook.com (2603:10b6:408:138::27)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:44 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::a7) by BN9PR03CA0562.outlook.office365.com
 (2603:10b6:408:138::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:37 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:37 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 61/82] drm/amd/display: Refactor amdgpu_dm_irq_test
Date: Tue, 18 Aug 2026 16:15:53 -0400
Message-ID: <20260818202139.4172592-62-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 460addad-e609-4822-73db-08defd667663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yt3lpNzkGppFdHFuuQq1UxWH+/Xdgq4/fPxGOYH8EYVZAmBlSzrWYtsI0AQr+x+/FCbncC+tKDbWzaxXnqt4odDtE7p8bjtO7XNGhtb2WnrO9qwW6qWXYPn0a8vVp++O/5rO3SaJaApHscUWVLLTLGZgudeJ/V1Zf8mcTfwyUmShiY1FOu8HrM5DHZ9ajkBNrbQvz5EAFCgIjmknNUaB4ma39yjdZRxWMcbarohAHbuFRW4/MSia67LZ0DsXixEPQdRVpFne41BYR9DAZTFlJD/nUirONJw5/ddPucLni6SoMYZU+kMhsc1RzOkiQ7xmmwSsQ6Bdbe98r0F2MeTHOPe3KRd6NE3KwRZ/HqF/rMfuICaxwTTvjjqfE+/NV1UPR/9kDvQ4csEL6/ptYMlJcZ9C+KRbgXMAbgbUNePg639i3nbsUSgNFCHrwE3WPYkIuWh6E5WhzNZ9uKvKmvrMPLm5nMxfK9DSKhVOWCoRGJIe+6jJeRWf7KNM3m7BkPj8JSfgC2wWqsjpSz91PWBoeJCT0A+XZgzkpq4a55KBxQhstmia3dTty1cfgY52g/HpffJvKKmrnaAp8U0c9/vmG+1rLIXp6q/+Ju+llq1KE27/lohh0Qcv25p0bcDi/LFBxlQnceqoE9kGtIQqQFcaEke6r89MMg1G7QBx1barcu2gUktCN3RxK2qguelPhQp4DfyFWL1J+t2pmqwLwXCxXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2y0vVBNRCZ6zoRmstY92uHt/5Lbu+UzwzFkG484lxBza9xuqos6ZHylcDbQA93M0JISvjek6Z5qLHhuqHfE/RvZDQhvG+1sgEShDLmXCr/0Gb6DPRiSgXWeCo6nKxZ6cz6vpcRIi1vG6Ezq5mhDirWQv1/y691cFya+NyTGZO3zJD7oAbkTcQ0/BOokgKrkbh4YUb5xrSsaHuJAnqYqIWYaa0WufR4BqkrdZcfg7R4CLIYZ9LMypb+Mae6CHd82eKOeaHjJ38wTTcka1wi6IZW9iQo0kgWNpUO7xSB/yTLaS+pYUwmO0fGyWWlLvSGFWcyDHWTwp2iU+g0WVRv5Qlv728AdH9inx5ZOoDAeQRSJ0+YeQ+130PHS3/+DJYr59fDeOPyoWS/8MuB8ImMIU27EwzHU6QODtMOJ2tGPBJZKpNPSkZD45+VlO2bwwAWjt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:44.7447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 460addad-e609-4822-73db-08defd667663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
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
Several amdgpu_dm_irq tests were each open-coding the same setup. Share
it through three functions: dm_test_add_crtc(),
dm_test_setup_hpd_irq_helper() and dm_test_setup_irq_regs().

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 214 ++++++++----------
 1 file changed, 95 insertions(+), 119 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 28c36217f6a21..fbe37bb0a39d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -340,6 +340,38 @@ static void dm_test_crtc_list_del(void *data)
 	list_del_init(&acrtc->base.head);
 }
 
+/*
+ * The DRM vblank core looks CRTCs up by index on mode_config.crtc_list and
+ * dereferences crtc->funcs, so a listed CRTC must carry a funcs table even
+ * when it implements no callbacks.
+ */
+static const struct drm_crtc_funcs dm_test_crtc_funcs = {
+};
+
+/*
+ * Add an OTG instance 0 CRTC to the device so amdgpu_dm_get_crtc_by_otg_inst()
+ * finds it. The CRTC is removed from the list again on test teardown.
+ */
+static struct amdgpu_crtc *dm_test_add_crtc(struct kunit *test,
+					    struct amdgpu_device *adev)
+{
+	struct amdgpu_crtc *acrtc;
+
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
+
+	INIT_LIST_HEAD(&acrtc->base.head);
+	acrtc->base.dev = &adev->ddev;
+	acrtc->base.funcs = &dm_test_crtc_funcs;
+	acrtc->otg_inst = 0;
+
+	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
+	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
+				dm_test_crtc_list_del, acrtc), 0);
+
+	return acrtc;
+}
+
 struct dm_test_hpd_rx_wq_ctx {
 	struct hpd_rx_irq_offload_work_queue *wq;
 	int count;
@@ -2481,16 +2513,14 @@ static void dm_test_handle_hpd_irq_disabled(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, aconn->fake_enable);
 }
 
-/**
- * dm_test_handle_hpd_irq_helper_debounce_schedule - Test HDMI debounce branch
- * @test: The KUnit test context
- *
- * An HDMI link reporting a disconnect (connection type none) with a non-zero
- * debounce delay and a cached local_sink must take the debounce branch: it
- * caches local_sink in hdmi_prev_sink and schedules the delayed debounce work
- * instead of detecting immediately.
+/*
+ * Build an aconnector wired for handle_hpd_irq_helper(): an HPD lock, an armed
+ * debounce work item, an atomic state and a dc/link pair reporting no
+ * connection. Caller sets the link_srv stubs and any HDMI/debounce fields the
+ * branch under test needs.
  */
-static void dm_test_handle_hpd_irq_helper_debounce_schedule(struct kunit *test)
+static struct amdgpu_dm_connector *dm_test_setup_hpd_irq_helper(struct kunit *test,
+								struct link_service **link_srv_out)
 {
 	struct amdgpu_dm_connector *aconn;
 	struct dm_connector_state *state;
@@ -2501,6 +2531,7 @@ static void dm_test_handle_hpd_irq_helper_debounce_schedule(struct kunit *test)
 	struct dc *dc;
 
 	adev = dm_kunit_alloc_adev(test);
+	mutex_init(&adev->dm.dc_lock);
 
 	aconn = dm_kunit_alloc_connector(test, adev, NULL);
 	mutex_init(&aconn->hpd_lock);
@@ -2528,6 +2559,29 @@ static void dm_test_handle_hpd_irq_helper_debounce_schedule(struct kunit *test)
 	link->ctx = ctx;
 	aconn->dc_link = link;
 
+	*link_srv_out = link_srv;
+
+	return aconn;
+}
+
+/**
+ * dm_test_handle_hpd_irq_helper_debounce_schedule - Test HDMI debounce branch
+ * @test: The KUnit test context
+ *
+ * An HDMI link reporting a disconnect (connection type none) with a non-zero
+ * debounce delay and a cached local_sink must take the debounce branch: it
+ * caches local_sink in hdmi_prev_sink and schedules the delayed debounce work
+ * instead of detecting immediately.
+ */
+static void dm_test_handle_hpd_irq_helper_debounce_schedule(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconn;
+	struct link_service *link_srv;
+	struct dc_link *link;
+
+	aconn = dm_test_setup_hpd_irq_helper(test, &link_srv);
+	link = aconn->dc_link;
+
 	/* HDMI signal + debounce delay + cached sink -> debounce branch. */
 	aconn->hdmi_hpd_debounce_delay_ms = 100;
 	link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
@@ -2555,40 +2609,11 @@ static void dm_test_handle_hpd_irq_helper_debounce_schedule(struct kunit *test)
 static void dm_test_handle_hpd_irq_helper_debounce_release_prev(struct kunit *test)
 {
 	struct amdgpu_dm_connector *aconn;
-	struct dm_connector_state *state;
 	struct link_service *link_srv;
-	struct amdgpu_device *adev;
-	struct dc_context *ctx;
 	struct dc_link *link;
-	struct dc *dc;
-
-	adev = dm_kunit_alloc_adev(test);
 
-	aconn = dm_kunit_alloc_connector(test, adev, NULL);
-	mutex_init(&aconn->hpd_lock);
-	INIT_DELAYED_WORK(&aconn->hdmi_hpd_debounce_work,
-			  amdgpu_dm_hdmi_hpd_debounce_work);
-
-	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
-	aconn->base.state = &state->base;
-
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
-	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
-
-	link_srv->detect_connection_type = dm_test_detect_connection_none;
-	dc->ctx = ctx;
-	dc->link_srv = link_srv;
-	ctx->dc = dc;
-	link->dc = dc;
-	link->ctx = ctx;
-	aconn->dc_link = link;
+	aconn = dm_test_setup_hpd_irq_helper(test, &link_srv);
+	link = aconn->dc_link;
 
 	/* HDMI signal + debounce delay + cached sink -> debounce branch. */
 	aconn->hdmi_hpd_debounce_delay_ms = 100;
@@ -2623,42 +2648,10 @@ static void dm_test_handle_hpd_irq_helper_debounce_release_prev(struct kunit *te
 static void dm_test_handle_hpd_irq_helper_detect_false(struct kunit *test)
 {
 	struct amdgpu_dm_connector *aconn;
-	struct dm_connector_state *state;
 	struct link_service *link_srv;
-	struct amdgpu_device *adev;
-	struct dc_context *ctx;
-	struct dc_link *link;
-	struct dc *dc;
 
-	adev = dm_kunit_alloc_adev(test);
-	mutex_init(&adev->dm.dc_lock);
-
-	aconn = dm_kunit_alloc_connector(test, adev, NULL);
-	mutex_init(&aconn->hpd_lock);
-	INIT_DELAYED_WORK(&aconn->hdmi_hpd_debounce_work,
-			  amdgpu_dm_hdmi_hpd_debounce_work);
-
-	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
-	aconn->base.state = &state->base;
-
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dc);
-	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
-	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link_srv);
-	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
-
-	link_srv->detect_connection_type = dm_test_detect_connection_none;
+	aconn = dm_test_setup_hpd_irq_helper(test, &link_srv);
 	link_srv->detect_link = dm_test_detect_link_false;
-	dc->ctx = ctx;
-	dc->link_srv = link_srv;
-	ctx->dc = dc;
-	link->dc = dc;
-	link->ctx = ctx;
-	aconn->dc_link = link;
 	aconn->fake_enable = true;
 
 	/* No debounce delay and no force -> immediate-detect else branch. */
@@ -3315,16 +3308,8 @@ static void dm_test_pflip_high_irq_not_submitted(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = dm_kunit_alloc_adev(test);
-	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
-
-	INIT_LIST_HEAD(&acrtc->base.head);
-	acrtc->base.dev = &adev->ddev;
-	acrtc->otg_inst = 0;
+	acrtc = dm_test_add_crtc(test, adev);
 	acrtc->pflip_status = AMDGPU_FLIP_NONE;
-	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
-	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
-				dm_test_crtc_list_del, acrtc), 0);
 
 	params.adev = adev;
 	params.irq_src = (enum dc_irq_source)IRQ_TYPE_PFLIP;
@@ -3380,17 +3365,9 @@ static void dm_test_crtc_high_irq_vrr_pre_ai(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = dm_kunit_alloc_adev(test);
-	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
-
-	INIT_LIST_HEAD(&acrtc->base.head);
-	acrtc->base.dev = &adev->ddev;
-	acrtc->otg_inst = 0;
+	acrtc = dm_test_add_crtc(test, adev);
 	/* VRR active so the !vrr_active vblank handler is skipped. */
 	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
-	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
-	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
-				dm_test_crtc_list_del, acrtc), 0);
 
 	/* Pre-AI family returns right after CRC handling. */
 	adev->family = AMDGPU_FAMILY_SI;
@@ -3417,18 +3394,10 @@ static void dm_test_crtc_high_irq_vrr_ai_no_stream(struct kunit *test)
 	struct amdgpu_device *adev;
 
 	adev = dm_kunit_alloc_adev(test);
-	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, acrtc);
-
-	INIT_LIST_HEAD(&acrtc->base.head);
-	acrtc->base.dev = &adev->ddev;
-	acrtc->otg_inst = 0;
+	acrtc = dm_test_add_crtc(test, adev);
 	acrtc->pflip_status = AMDGPU_FLIP_NONE;
 	/* VRR active so the !vrr_active vblank handler is skipped. */
 	acrtc->dm_irq_params.freesync_config.state = VRR_STATE_ACTIVE_VARIABLE;
-	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
-	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
-				dm_test_crtc_list_del, acrtc), 0);
 
 	/* AI+ family runs the freesync section; no stream skips it. */
 	adev->family = AMDGPU_FAMILY_AI;
@@ -3625,14 +3594,14 @@ static void dm_test_dce110_register_irq_handlers_rejects_uninitialized_sources(s
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), -EINVAL);
 }
 
-/**
- * dm_test_dce110_register_irq_handlers_one_crtc - Test DCE110 with 1 CRTC
- * @test: The KUnit test context
- *
- * Exercises the VBLANK, VUPDATE, PFLIP and HPD for-loop bodies with a
- * fake IRQ service that maps source IDs to DC IRQ sources.
+/*
+ * Build an adev/dc pair with one CRTC, ready for either register_irq_handlers()
+ * entry point, using the given fake IRQ service to map source IDs. A service
+ * that only maps a subset lets a chosen register loop hit its invalid-source
+ * guard, and clearing an amdgpu_irq_src's funcs makes its add_id() fail.
  */
-static void dm_test_dce110_register_irq_handlers_one_crtc(struct kunit *test)
+static struct amdgpu_device *dm_test_setup_irq_regs(struct kunit *test,
+						   const struct irq_service_funcs *funcs)
 {
 	struct amdgpu_device *adev;
 	struct dc *dc;
@@ -3640,14 +3609,31 @@ static void dm_test_dce110_register_irq_handlers_one_crtc(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_free_irq_sources,
 							 adev), 0);
-	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dce110);
+	dc = dm_test_alloc_dc_with_irq_service(test, funcs);
 	dc->ctx->dce_version = DCE_VERSION_11_0;
+	dc->caps.max_otg_num = 1;
 	adev->dm.dc = dc;
 	adev->mode_info.num_crtc = 1;
 	adev->mode_info.num_hpd = 1;
 	amdgpu_dm_set_irq_funcs(adev);
 	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
 
+	return adev;
+}
+
+/**
+ * dm_test_dce110_register_irq_handlers_one_crtc - Test DCE110 with 1 CRTC
+ * @test: The KUnit test context
+ *
+ * Exercises the VBLANK, VUPDATE, PFLIP and HPD for-loop bodies with a
+ * fake IRQ service that maps source IDs to DC IRQ sources.
+ */
+static void dm_test_dce110_register_irq_handlers_one_crtc(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_test_setup_irq_regs(test, &dm_test_irq_service_funcs_dce110);
+
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), 0);
 
 	/* Verify VBLANK params were populated */
@@ -3702,18 +3688,8 @@ static void dm_test_dcn10_register_irq_handlers_zero_crtc(struct kunit *test)
 static void dm_test_dcn10_register_irq_handlers_one_crtc(struct kunit *test)
 {
 	struct amdgpu_device *adev;
-	struct dc *dc;
 
-	adev = dm_kunit_alloc_adev(test);
-	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test, dm_test_free_irq_sources,
-							 adev), 0);
-	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
-	adev->dm.dc = dc;
-	adev->mode_info.num_crtc = 1;
-	adev->mode_info.num_hpd = 1;
-	dc->caps.max_otg_num = 1;
-	amdgpu_dm_set_irq_funcs(adev);
-	KUNIT_ASSERT_EQ(test, amdgpu_dm_irq_init(adev), 0);
+	adev = dm_test_setup_irq_regs(test, &dm_test_irq_service_funcs_dcn10);
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_dcn10_register_irq_handlers(adev), 0);
 
-- 
2.43.0

