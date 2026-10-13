Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE75CA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D1410F784;
	Tue, 13 Oct 2026 11:19:57 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD7C10F785
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QSupGhBTn8aaoLKAIPatrm3J4HRcpD5A0ZYCUDrbOU5GVY59cVgqjlXETAzApkTJDbM8g1BmncMu51ZtMW1hAgwKJHZeNNThsn7rmniKSDEfm0NTpz2PbB565DkzxdAbQywCT+OHKC/aAwlHx8z0AB3eGOZZzozpzPxhr6TtRAu+tRx2x4Cch+OVBJMaAiJmtK/NakRqyIFJqFGn94eLovr7Wu1P1UdAKEgkN4Yl2sRtfZ6KPjEyrtSpSms5X3eMOs6n22v7t8MinsJXRaGFtrGlM48F/Nx1I7ypc9j4Hw1Ljhym6DLmMIQxLHa5i3qxGcQJzslg23aBncGqXO77aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubSaHI9G+Ef4Ig3xiPWhBuw2MQoTdLZPk+HZRZnZO2g=;
 b=XO6Dl5E8QCnZnOMXWl01whKoodoP56Ryfc6Mphg/EepfdpY1SkJBR46o/0fH5Kf/obAWPM8EaEu6d7h7rMNoNcdGhzQuyiFobuScgGkepRfRWc+rSljRT3q9UdSrFmrzTszzUulDrw0Nv5iA5ZaCYYeO7RgM2X7ujdW8bR2iE6XMdzqS+G+/T2cxJv46gAWfqCHDORbcAztunpwPpkZTBdRW9zGQR0S2pKhRqVNHLm/x8Ntk55ytDpzQCaq8PMMOlBh3ubGmnY8u2ZUzDNDdaNRIrSfSe0ve8rKkliYtJluR6vmKF9i9026C6unHIiNYEU9tnCqJ1i4b28TljeTiog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubSaHI9G+Ef4Ig3xiPWhBuw2MQoTdLZPk+HZRZnZO2g=;
 b=F7CCgxLDNDhNXWDbsuUpuGAEUYP8G6XDGqL6XAXZAnO439ahaXbeoLVVJ3zwEtTVU/mvKRSrMiYuof7psVxO2JnkzWX8pv4zXKydCkd3hDpisJzbcHL2DTq5h16n1wx3qIft8aXBfCnvue3/VfJGEkvwAjL1HhZ/TpXVPowaKDM=
Received: from SJ0PR05CA0116.namprd05.prod.outlook.com (2603:10b6:a03:334::31)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 13 Oct
 2026 11:19:45 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:334:cafe::5c) by SJ0PR05CA0116.outlook.office365.com
 (2603:10b6:a03:334::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 11:19:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:19:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:19:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:19:36 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:19:28 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 24/30] drm/amd/display: fix NULL dc deref in hpd_init KUnit
 tests
Date: Tue, 13 Oct 2026 19:08:11 +0800
Message-ID: <20261013111616.2267344-25-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b482f2-6142-4ebb-ba1c-08df291be10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|56012099006|18002099003|22082099003|10067099003|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info: xN+l8TvvlmU1ziQ6l80QSS4HghT2tOcTctw5h99mBPjZV4qqx93b3fcoTu8srzk0UY5e/8K9ZuUbyi9kucUXKZM72fGW38sG2EwwHjhUUdHn+oqhTTmQPce8SoSl/+wymIX94wC5I/2aaMgUhiXC2TxV0CaTWRHe70p8KyI+OkrrchcG+8WwHjZb0roZYGULN5qOdGTnlKu6aY4EcGQS85mlRmqgnaYIEuS3cLCO1O9mpOssAs5k0AEddBEIOb3CiUL8lMPtN99K8JxReleJbug25NYlo0cqDKeZ6nhyh+6knuuP1YkZA/HbrpHYK3femuNbtRgmf0cU3W6QhDG6q9ellfjEkNhIaijnM2/VbX2CYZi8/TqR9KsNm8m9mePnXeLsGSiGoJkyajip1Rol4P1pnoqXBE5I/qHVegvmvGzgSGSpaYTZPKKVrr+yR0QlqNKQ0SD+vjYRx41PLTnCFBr7K8vTJqDL/j+X3Qf2fNL9+fJpEhHwc3q5mEhWP1fjP52q32h+86gsacyHch9xvC08JgLXq+MmV8f4RLwRxJXfsMP2T0vas4ENKs7WVJJCKVBvctjZZ/QNBNpiRPCA3zf3apLGU6Bx8NG+mcJZ6uNLWwcfarC7cesCPT29AQmG84s+slQpdSdAxagvCeB9smCC3SQsTQooAT4pJVvb9o8rNT5TQdlDLJLvhUBYJCNz4LYFLnChttjWeFKm0vw1IA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(18002099003)(22082099003)(10067099003)(11063799006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8uf8oBrWtJNaFBp+48aGVLIjIt8Ez7gb43saJHs8/V09Q/qaPFRVEcrF7h19uxzSyexL4YGW+l0D9mREG04wdGq/pGFsXeAHSqOJKmyRypQkk9kEuh+VUiT6CMpJFlaUNM+c3zNYrCw/nmw+Z57Rj1ClV7TMSLiqRDzMcE7/s8adPhJXJ5x+pE2HOJieLE87TYSQhs8Lj4NMDJ+HxKYMZtMjGZvY7J4NDyWLlAI2gyNFn1Olku6no9o2QeIcBNwsOcZovG65Xu/WhcyKGsBV3jnch+GV8EQUYwglrMQ3hjuvjk0C7ght5zbG/EtgZBwafK3k0pqci3cirXMNenrAb3jdU7EQ4fV7i5R/BY26MKnJo1QdMWEPuzq16n8AAytIdL39Rs8thWYDbkOYDVmFhoLyj5Ts4+wt6KrdIQQ7E5kyPwJE0uiJouIz1NRy6fQf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:19:42.5614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b482f2-6142-4ebb-ba1c-08df291be10f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why & How]
amdgpu_dm_hpd_init() was changed to walk adev->dm.dc->links directly,
so the two tests that left adev->dm.dc NULL now panic on a NULL dc
dereference.

Give both tests a real DC via dm_test_alloc_dc_with_irq_service()
with a dc_link and dc->links[0] / link_count = 1.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 48 ++++++++++++++++---
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index a139890b7cd5..18a2409c5a69 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -2035,14 +2035,27 @@ static void dm_test_outbox_init_null_dc(struct kunit *test)
 static void dm_test_hpd_init_empty_connectors(struct kunit *test)
 {
 	struct amdgpu_device *adev;
+	struct dc_link *link;
+	struct dc *dc;
 
 	adev = dm_kunit_alloc_adev(test);
 
 	/*
-	 * With an empty connector list the per-connector loop is skipped and
-	 * the initial clear loop relies on amdgpu_dm_irq_set() being a no-op
-	 * for a NULL dc, so init must complete without touching the DC.
+	 * The initial clear loop walks adev->dm.dc->links, so a DC with a
+	 * populated irq service is required. With an empty connector list the
+	 * per-connector loop is skipped, so init must complete after only the
+	 * clear loop runs.
 	 */
+	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
+	adev->dm.dc = dc;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, link);
+	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1;
+	link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX;
+	dc->links[0] = link;
+	dc->link_count = 1;
+
 	amdgpu_dm_hpd_init(adev);
 }
 
@@ -2070,13 +2083,17 @@ static void dm_test_hpd_init_fini_with_connectors(struct kunit *test)
 	struct drm_connector *wbconn;
 	struct amdgpu_device *adev;
 	struct dc_link *link;
+	struct dc *dc;
 
 	adev = dm_kunit_alloc_adev(test);
 
+	/* The clear loop walks dc->links, so set up a DC with an irq service. */
+	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
+	adev->dm.dc = dc;
+
 	/*
 	 * num_hpd = 0 forces irq_type >= num_hpd so the loop takes the HW
-	 * fallback (amdgpu_dm_irq_set()) instead of amdgpu_irq_get(); with a
-	 * NULL dc that fallback is a safe no-op.
+	 * fallback (amdgpu_dm_irq_set()) instead of amdgpu_irq_get().
 	 */
 	adev->mode_info.num_hpd = 0;
 
@@ -2102,8 +2119,10 @@ static void dm_test_hpd_init_fini_with_connectors(struct kunit *test)
 	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1;
 	link->irq_source_hpd_rx = DC_IRQ_SOURCE_HPD1RX;
 	aconn->dc_link = link;
+	dc->links[0] = link;
+	dc->link_count = 1;
 
-	/* DC is absent (NULL), so the HW writes are NULL-safe no-ops. */
+	/* The irq service stubs accept the HW writes without register access. */
 	amdgpu_dm_hpd_init(adev);
 	amdgpu_dm_hpd_fini(adev);
 }
@@ -2117,10 +2136,15 @@ static void dm_test_hpd_init_fini_analog_connector(struct kunit *test)
 	struct amdgpu_dm_connector *aconn;
 	struct amdgpu_device *adev;
 	struct dc_link *link;
+	struct dc *dc;
 
 	adev = dm_kunit_alloc_adev(test);
 	adev->mode_info.num_hpd = 0;
 
+	/* The clear loop walks dc->links, so set up a DC with an irq service. */
+	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
+	adev->dm.dc = dc;
+
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
@@ -2136,6 +2160,8 @@ static void dm_test_hpd_init_fini_analog_connector(struct kunit *test)
 	/* An analog connector id makes the loop request polling. */
 	link->link_id.id = CONNECTOR_ID_VGA;
 	aconn->dc_link = link;
+	dc->links[0] = link;
+	dc->link_count = 1;
 
 	/* use_polling becomes true, so init must enable KMS polling. */
 	amdgpu_dm_hpd_init(adev);
@@ -2155,9 +2181,14 @@ static void dm_test_hpd_init_fini_irq_ref(struct kunit *test)
 	struct amdgpu_dm_connector *aconn;
 	struct amdgpu_device *adev;
 	struct dc_link *link;
+	struct dc *dc;
 
 	adev = dm_kunit_alloc_adev(test);
 
+	/* The clear loop walks dc->links, so set up a DC with an irq service. */
+	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
+	adev->dm.dc = dc;
+
 	/*
 	 * num_hpd >= 1 makes irq_type (0) < num_hpd, so the loop takes the
 	 * amdgpu_irq_get()/amdgpu_irq_put() branch instead of the
@@ -2180,6 +2211,8 @@ static void dm_test_hpd_init_fini_irq_ref(struct kunit *test)
 	link->irq_source_hpd = DC_IRQ_SOURCE_HPD1;
 	link->irq_source_hpd_rx = DC_IRQ_SOURCE_INVALID;
 	aconn->dc_link = link;
+	dc->links[0] = link;
+	dc->link_count = 1;
 
 	amdgpu_dm_hpd_init(adev);
 	amdgpu_dm_hpd_fini(adev);
@@ -2200,6 +2233,9 @@ static void dm_test_hpd_init_skips_connector_without_link(struct kunit *test)
 	adev = dm_kunit_alloc_adev(test);
 	adev->mode_info.num_hpd = 0;
 
+	/* The clear loop walks dc->links, so set up a DC with an irq service. */
+	adev->dm.dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dcn10);
+
 	aconn = kunit_kzalloc(test, sizeof(*aconn), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, aconn);
 	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, &aconn->base,
-- 
2.43.0

