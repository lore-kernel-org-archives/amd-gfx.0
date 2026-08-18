Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2ECC5DF92
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183A910ECD3;
	Tue, 18 Aug 2026 20:22:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ea2Ws0jb";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011063.outbound.protection.outlook.com [40.107.208.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ADED10ECC2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzGtrawkDjhzabkfO2TO9hku5sMS/gY59v/MlGL8uPAXTLHsZ7cd0I+97NCdBXhZZdXyVQ0L/NfElhwKL8JbMYdMw8b1XosnyelRxdEf3ifK4yN9FOaDoVu8eipDUYnv6bew2hUD7OUoR+V8HcyBWE7j4XytLqYszUmApaCRUAMHjIy/1dHiEXvzfwiL56Du2VPaSDz35izB5fDvBQEsWw7eyf2c1c6YlHpFfemsDBhotP79m72wvy6Obi4Kr7tgdWdhpI1FKma73Dt2LMp8VwljZkuVaHreFCpzXIHNVq3T+35GE42s14AWj61M8yLShmnJFb956ZC/ANQR0ER9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUdlCvx6abjOupJtKci4CYNNejWDZtdVdSuvZ+GZvb8=;
 b=VcSe2oBIpGza3FRlwxlRZqPyub1ukYV7hthWzMc5mvGaV8eK2Rhqx0oJpyyxblCjfk+bJB7NuFoRnxzjaunlUIAh7tw+S04RiNqD0zanLpzEQ54oWnruFB+ifpmNPwc1Ewrj2h8b+r4Zfk2HQuqR+6aXkrWZdbsQ03OzvNf2aL5abiz5cw/igjPStM1d4EvKawD7b+zogZXTIuzR4gYzPx1Qm7sPktn+EKNFnZa+V2z5vmt/YHWrN5AyXjnOtYLUTRaAcgl9ZyAK5TWfM9DfD8agkKMyBSmSfIKZSJU3tg7h8TPaWedYHAmWfkYwz4I/Df4jTJDlnhJjGJSuDz/2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUdlCvx6abjOupJtKci4CYNNejWDZtdVdSuvZ+GZvb8=;
 b=ea2Ws0jbV9I7f3tdEHj+4G7ijLgTfHyKgkvzE6I6XxjkU7A433ZMZw8Cc7aQQQFKgdB+6nxX050Sw1mjEORRvHnD0Fug24vGYP7+n/xxzL9nbvKJcEWzCcoop1DN5RaYNiKuQOdp4r2zlS4bEx1K7M1TnxPFqz3G2J9dsLdgJ+4=
Received: from BL1P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::28)
 by BY5PR12MB4305.namprd12.prod.outlook.com (2603:10b6:a03:213::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:50 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::70) by BL1P221CA0008.outlook.office365.com
 (2603:10b6:208:2c5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:50 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:49 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 75/82] drm/amd/display: Cover hdmi_frl_status_polling_work
Date: Tue, 18 Aug 2026 16:16:07 -0400
Message-ID: <20260818202139.4172592-76-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|BY5PR12MB4305:EE_
X-MS-Office365-Filtering-Correlation-Id: dc629d6b-04ec-4468-33f5-08defd6679ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|6133799003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qV7cFOLxWvoFjPcAH95+6NMOyJof+r3Tgg0bHxLF5TWeI+t/IvfsT467QWptupAgtgecSh+5MCraddNjut3/RKIOovw7BrbIczDyXTQTSbH+pxDYzDx5OAKklS2674qCkqjwJ1Pw/gejUvVKndOWK08bzdfUtf2tfaS1h4XTx75/4tKglqZJgcV9BNOk4LJJRuXlonJew4jGOZsg6D7Rh0nWOZ8cqdpp4oQmTiKZs92vd+1DjZSK3jqJcvdCTWr0XnBiezZlRK/2Xize5Cpcs9rwjoQYiLtyR/KDOtjqaN8SNOsYx0Mu2ZDWCVNv9MszXCNE4hgiEpFTdi7e0n1zbzfsat9f6ZyIulX+GCXMab2iERj8RxfZGHra/5xW/W6tkS2GTTZTLqeNEExnmsk5OhuHdF32bsoBo0e2kCY3RyKQGqcB1W7EenEHNUFdGTnH8pRQycy2znLZEiy2bLA74xDtyF4Abj5PN+h5TxCQC5liCepehNAvclugg6YHS2ivpiz4HzjHeatRboaW4TwpFIXfyo9mxtdeVJLGWmCupNWgHqaVkffuixZcEkha4sWRLLbdL2IFP6P9VO3MZhTLs5PG+pnAfQl6hyXD3pgUgkEYG1zFRjm+ojMtZMegPPiQaoMTe6iUO2OOuTjIUtTBYDQgU6pQRZYE1rrcJI4gxVo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F2r2h37yPUrUztYIqAB46SrVXLFrfbCigsQodHL2yD84UZ2nJBdFN2mSWjYXN6B1olRoaZYTvFx1cIah0rCMcTUb2LthFCyezEfC/+O1Isz/VMUKnjbVfIM1qnmLo81yBF5y4/VYFL1HUmSNc2FwphBoSQtxIAf9tbCNvMasUUeqFV8yz1H0F6uIcUn6nQymw/t9AQYippYX0qP582pyw0JLfOST7r6qucEdEoXp2BdYW4fQa1StoXoEZuYgLhaIBwwhSCIjV9XjtN3C7rLydaNqn+wwlNFNuP/yxgGHW1jy1rS8sCbvgN6DLNqXBfI1C3dY4qlAN2JZxPpTA0Jj63dUduufrpbGIeaFypE8r2b2VCsXSu0BNEMc5gzM7wEEqG7NAzY24BQgpdjK9+npYaOy+EFqqxhZyGgSi0D0L/A5krwbN+vhe+/iw1DSVWXZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:50.6899 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc629d6b-04ec-4468-33f5-08defd6679ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4305
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

Add KUnit tests for hdmi_frl_status_polling_work() covering the
no-links, no-local-sink, non-HDMI and zero-FRL-rate skip cases, plus
the poll paths that leave the link unchanged or trigger a retrain.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 207 ++++++++++++++++++
 2 files changed, 208 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 13f9ed0220c37..837ab9cfd35f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3121,6 +3121,7 @@ void hdmi_frl_status_polling_work(struct work_struct *work)
 			   &dm->hdmi_frl_status_polling_work,
 			   msecs_to_jiffies(dm->hdmi_frl_status_polling_delay_ms));
 }
+EXPORT_IF_KUNIT(hdmi_frl_status_polling_work);
 
 void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 				     struct amdgpu_dm_connector *aconnector,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 5e5c372e9e01e..24f55432e3262 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -7988,6 +7988,206 @@ static void dm_test_update_scaling_underscan(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, stream->dst.height, 1048);
 }
 
+/* Tests for hdmi_frl_status_polling_work() */
+
+static int dm_test_frl_poll_calls;
+static int dm_test_frl_detect_calls;
+
+static bool dm_test_frl_poll_true(struct dc_link *link)
+{
+	dm_test_frl_poll_calls++;
+	return true;
+}
+
+static bool dm_test_frl_poll_false(struct dc_link *link)
+{
+	dm_test_frl_poll_calls++;
+	return false;
+}
+
+static bool dm_test_frl_detect(struct dc_link *link, enum dc_detect_reason reason)
+{
+	dm_test_frl_detect_calls++;
+	return true;
+}
+
+struct dm_test_frl_ctx {
+	struct amdgpu_display_manager *dm;
+	struct dc *dc;
+	struct link_service *link_srv;
+};
+
+/*
+ * Build a display manager whose polling work re-arms on a real workqueue. The
+ * dc starts with an empty link array and link_srv hooks that count poll and
+ * detect calls, so a test can assert exactly how far a link progresses. A large
+ * re-arm delay keeps the requeued work dormant until the test cancels it.
+ */
+static struct dm_test_frl_ctx *dm_test_frl_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_frl_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->dm = kunit_kzalloc(test, sizeof(*ctx->dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dm);
+	ctx->dc = kunit_kzalloc(test, sizeof(*ctx->dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc);
+	ctx->link_srv = kunit_kzalloc(test, sizeof(*ctx->link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link_srv);
+
+	ctx->link_srv->hdmi_frl_poll_status_flag = dm_test_frl_poll_true;
+	ctx->link_srv->detect_link = dm_test_frl_detect;
+	ctx->dc->link_srv = ctx->link_srv;
+	ctx->dm->dc = ctx->dc;
+	mutex_init(&ctx->dm->dc_lock);
+	INIT_DELAYED_WORK(&ctx->dm->hdmi_frl_status_polling_work, hdmi_frl_status_polling_work);
+	ctx->dm->hdmi_frl_status_polling_delay_ms = 100000;
+	ctx->dm->hdmi_frl_status_polling_wq = system_wq;
+
+	dm_test_frl_poll_calls = 0;
+	dm_test_frl_detect_calls = 0;
+
+	return ctx;
+}
+
+/* Allocate a dc_link, wire its dc back-pointer and register it at index 0. */
+static struct dc_link *dm_test_frl_add_link(struct kunit *test, struct dm_test_frl_ctx *ctx)
+{
+	struct dc_link *link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	link->dc = ctx->dc;
+	ctx->dc->links[0] = link;
+
+	return link;
+}
+
+/* Register a link that satisfies every guard up to the poll status check. */
+static struct dc_link *dm_test_frl_add_hdmi_link(struct kunit *test, struct dm_test_frl_ctx *ctx)
+{
+	struct dc_link *link = dm_test_frl_add_link(test, ctx);
+
+	link->local_sink = kunit_kzalloc(test, sizeof(*link->local_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link->local_sink);
+	link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	link->frl_link_settings.frl_link_rate = HDMI_FRL_LINK_RATE_3GBPS;
+
+	return link;
+}
+
+/* Run the work once directly, then cancel and tear down the re-armed work. */
+static void dm_test_frl_run(struct dm_test_frl_ctx *ctx)
+{
+	hdmi_frl_status_polling_work(&ctx->dm->hdmi_frl_status_polling_work.work);
+	cancel_delayed_work_sync(&ctx->dm->hdmi_frl_status_polling_work);
+}
+
+/**
+ * dm_test_frl_no_links - Test an empty link array is a no-op
+ * @test: The KUnit test context
+ *
+ * With no links registered the loop body never runs, so neither the poll nor
+ * the detect hook is invoked.
+ */
+static void dm_test_frl_no_links(struct kunit *test)
+{
+	struct dm_test_frl_ctx *ctx = dm_test_frl_ctx_alloc(test);
+
+	dm_test_frl_run(ctx);
+
+	KUNIT_EXPECT_EQ(test, dm_test_frl_poll_calls, 0);
+	KUNIT_EXPECT_EQ(test, dm_test_frl_detect_calls, 0);
+}
+
+/**
+ * dm_test_frl_skips_no_local_sink - Test a link without a local sink is skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_frl_skips_no_local_sink(struct kunit *test)
+{
+	struct dm_test_frl_ctx *ctx = dm_test_frl_ctx_alloc(test);
+
+	dm_test_frl_add_link(test, ctx);
+
+	dm_test_frl_run(ctx);
+
+	KUNIT_EXPECT_EQ(test, dm_test_frl_poll_calls, 0);
+}
+
+/**
+ * dm_test_frl_skips_non_hdmi - Test a non-HDMI link is skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_frl_skips_non_hdmi(struct kunit *test)
+{
+	struct dm_test_frl_ctx *ctx = dm_test_frl_ctx_alloc(test);
+	struct dc_link *link = dm_test_frl_add_link(test, ctx);
+
+	link->local_sink = kunit_kzalloc(test, sizeof(*link->local_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link->local_sink);
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	dm_test_frl_run(ctx);
+
+	KUNIT_EXPECT_EQ(test, dm_test_frl_poll_calls, 0);
+}
+
+/**
+ * dm_test_frl_skips_zero_rate - Test a link with no FRL rate is skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_frl_skips_zero_rate(struct kunit *test)
+{
+	struct dm_test_frl_ctx *ctx = dm_test_frl_ctx_alloc(test);
+	struct dc_link *link = dm_test_frl_add_hdmi_link(test, ctx);
+
+	link->frl_link_settings.frl_link_rate = 0;
+
+	dm_test_frl_run(ctx);
+
+	KUNIT_EXPECT_EQ(test, dm_test_frl_poll_calls, 0);
+}
+
+/**
+ * dm_test_frl_poll_no_update - Test a clear poll status skips retraining
+ * @test: The KUnit test context
+ *
+ * The poll hook is reached but reports no change, so dc_link_detect() is not
+ * called.
+ */
+static void dm_test_frl_poll_no_update(struct kunit *test)
+{
+	struct dm_test_frl_ctx *ctx = dm_test_frl_ctx_alloc(test);
+
+	ctx->link_srv->hdmi_frl_poll_status_flag = dm_test_frl_poll_false;
+	dm_test_frl_add_hdmi_link(test, ctx);
+
+	dm_test_frl_run(ctx);
+
+	KUNIT_EXPECT_EQ(test, dm_test_frl_poll_calls, 1);
+	KUNIT_EXPECT_EQ(test, dm_test_frl_detect_calls, 0);
+}
+
+/**
+ * dm_test_frl_poll_retrains - Test a set poll status triggers a retrain
+ * @test: The KUnit test context
+ *
+ * A poll status change drives dc_link_detect() with DETECT_REASON_RETRAIN.
+ */
+static void dm_test_frl_poll_retrains(struct kunit *test)
+{
+	struct dm_test_frl_ctx *ctx = dm_test_frl_ctx_alloc(test);
+
+	dm_test_frl_add_hdmi_link(test, ctx);
+
+	dm_test_frl_run(ctx);
+
+	KUNIT_EXPECT_EQ(test, dm_test_frl_poll_calls, 1);
+	KUNIT_EXPECT_EQ(test, dm_test_frl_detect_calls, 1);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -8348,6 +8548,13 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_update_scaling_rmx_aspect_letterbox),
 	KUNIT_CASE(dm_test_update_scaling_rmx_center),
 	KUNIT_CASE(dm_test_update_scaling_underscan),
+	/* hdmi_frl_status_polling_work */
+	KUNIT_CASE(dm_test_frl_no_links),
+	KUNIT_CASE(dm_test_frl_skips_no_local_sink),
+	KUNIT_CASE(dm_test_frl_skips_non_hdmi),
+	KUNIT_CASE(dm_test_frl_skips_zero_rate),
+	KUNIT_CASE(dm_test_frl_poll_no_update),
+	KUNIT_CASE(dm_test_frl_poll_retrains),
 	{}
 };
 
-- 
2.43.0

