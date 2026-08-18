Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8518CC5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B810910ECB9;
	Tue, 18 Aug 2026 20:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pf56Ebc/";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E69310ECAC
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqiaeA027ieim6txDHK2Sd8NL+xlXskP/QWJP9avC2zghSOMsq61wPTgo6c1cVT30foviD2FOlFO5aSoaCE5SW0ZNjNo9GgWNAFMWebPm8elxRtZW1ANTDDpysz6/e82gksRHpxcwVMBOt1rSPVk1bVhdu8/TXthqIgcrQuv9iYCoKqIWiDGCjmgPVgeLmad74nWXBrD6ZQ0eSIuDD/lzoXWimva+Pz0KrpAB10Ta4CRrdO9fXZjSfpYXMOQEKR2d2NjjA/Sun/3Qu/a4uFEZkx0OEqFPXwSZ76ccjssEiMQqw4M1jhKeCsOCQF8biJ9qrNsWUn3ULUmFNBX+vjq/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9milpO6V4I0pJiv8Sh8r26VUd85l4427YioUxNa6Coo=;
 b=OFNwCpzBX19sbFNbb+2kNTbORlZ84wV4LvknJ8DzICpYkE/PP2fPvkp4aq3Ij2qB/5nIPzPTmqMXS/b1yqVMO8t/SzKb0imstIPGS6OwRTrXr8PESafM5bGqvqRknyJ34WdacjHbKpw50ak8HZBeAzKp6pu/s9ziQPhd8Q/uQpqfp37lx+/UOQ+ryH+dc22OKFFFj+SGDaGdvHR55LrVTiW/BTZ3Q4ANkKZv3se9COeoWYEs33qLTJPmkrw5Z4DjwEk2Cw29U08eM8K5ItICkhxUNb60ZtQwq/MqeRwMM79ajqoPO7cXP7FdhdBlUw1RhDAlSF2iLKBlAQfdCnICpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9milpO6V4I0pJiv8Sh8r26VUd85l4427YioUxNa6Coo=;
 b=Pf56Ebc/OWIkMuYUgmk3VX/uVfwFuxFnqH9WXrLtXj6SdfUJ2u5nkfxz5nPDsOhv4HNDttnzWhbmR2gVmGMNPW1doHMfsM9ayphFbsnJTiU6RawvcJ/aqG3Yq1S4eD6wrb0Hz0xOMZwwbxeWGVatSTstGKTREllC61HNBnOThic=
Received: from BN9PR03CA0555.namprd03.prod.outlook.com (2603:10b6:408:138::20)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:39 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::a7) by BN9PR03CA0555.outlook.office365.com
 (2603:10b6:408:138::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:17 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:16 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 33/82] drm/amd/display: Add amdgpu_dm_connector_poll KUnit
 tests
Date: Tue, 18 Aug 2026 16:15:25 -0400
Message-ID: <20260818202139.4172592-34-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 2459216c-fedb-4e8d-8020-08defd6672e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: SWLkskfPzERMr2COx+vYJ3wrOHcmRsrmh7HcJ93xyYLR7WW4fBrgQMFv/V0xSjKw86njXLkVgh/1S6bjZucG7SzPaXen6IGemYaKfC6mpAAk1vWUgjBpOro2OMwlm+SSOKwKJGuLhSOO8HO/bkv59O1ixaYIr1tiN/5Oeq2WQTK+8QoKEdAmVH/v6oDhq3qpH4IVUMUL0PXIfS/tBGhr4eSWFP/PxptPq0uVN1iHAzademGzoYt0j25IzvcWUO21VV/Cib09H73hnibdC081yQEoqh1FWDdYrcE6nTtw3nyXDcjIM0R3oFJBTLFkPhvQzApBBkrpJx28T4ip3mOoxWg4P6qbMGrfSOMeTx0Fd4ncV6i9zVM1tLoyGZWj+GcUoVj2uu1VykKFkURW+4ZHGNnvKqMvH9E7Ar4a85d0L0lFZArp/jw/EKEQ4IIw6R6B3freVESCFWySQUCtYehybC0kleeeqhCphCcCi0wBCkhKciTYpHl0aRkT5ejmus311yj8exF5sxWVuacYA0GhmYCkCJt08EhgypOTGJ/vG53+WurQunbDy07yQQJCJxtdemImldL1ONEtfQQkS6TCF2rHV7CxKXXD8ZW0aVhjp63+39jFfqnos8Sn839oepkljTf+NZ2G6xYcGpSWvO+JaenMQAVMc60TvjwHMW4i5TD0f9hXd2MPFWWUVKiGtswnxxJWPsdOEWhwQ9C+UV8VYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rmI/2qJLgVFwg9jtX6tzf4cCXtZNELINgj5cZ+q55GRYSJl45p+I6ILAdAkRCR76BvRLS06ZKPNJ9+yTL6px0VNd4l+Ebr2ubVqG2cKuLfxDWM4m2AYy/LMF+1AGJjfC7aSagOcdmzAgtHPgB7N9ZqwJaWggmptwVbxC1SfDBH/EVJFG+aVtsucW/b5jhG4bJ/5LiBeKwbTDJ/7bJL6Ee9kj0iKIIjPWtVTqn3y3+Wa6HLlGYUhxKEMj11SrJQrcmEVgBuYPKVt8ic9SXx0mfYL6ZVZGYH8UpvyI8aySUf1uC3PTaBxYBwnOSu49pFQ9jXfCeNpJDjcS1MPCw9AbY0ngKUF//qKL2Mp+/OHZ3aICwfvMpkxuS6gfkPA+oafSQ21FBiCKrt39mcDudnXtYVat/soRku3KvJVZNluJuC402QKoMgkNIT1QsgRPTtBh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:38.9080 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2459216c-fedb-4e8d-8020-08defd6672e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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

Add tests covering the non-shortcut poll paths: connected reusing a cached
local_sink, connected via full dc_link_detect(), and the disconnect
teardown that releases and clears a stale sink. Fakes wire
link->dc->link_srv detect_connection_type/detect_link function pointers.
Raises amdgpu_dm_connector_poll coverage from 35% to 100%.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 165 ++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 1a95694ea35cd..1b1ed534ed441 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4175,6 +4175,168 @@ static void dm_test_poll_dac_load_returns_cached(struct kunit *test)
 		(int)connector_status_connected);
 }
 
+/*
+ * Fake link_service detection callbacks used by the connector poll tests.
+ * dc_link_detect_connection_type() and dc_link_detect() proxy through
+ * link->dc->link_srv, so faking these pointers exercises the poll paths
+ * without touching real hardware.
+ */
+static bool dm_test_poll_detect_type_connected(struct dc_link *link,
+						enum dc_connection_type *type)
+{
+	*type = dc_connection_single;
+	return true;
+}
+
+static bool dm_test_poll_detect_type_none(struct dc_link *link,
+					   enum dc_connection_type *type)
+{
+	*type = dc_connection_none;
+	return false;
+}
+
+static bool dm_test_poll_detect_link_connected(struct dc_link *link,
+					       enum dc_detect_reason reason)
+{
+	return true;
+}
+
+struct dm_test_poll_ctx {
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+	struct dc *dc;
+	struct dc_context *dc_ctx;
+	struct link_service *link_srv;
+	struct drm_device *drm;
+};
+
+/*
+ * Build an amdgpu_dm_connector embedded in an amdgpu_device (so drm_to_adev()
+ * resolves) with a faked dc_link->dc->link_srv. The hpd_lock and dc_lock
+ * mutexes are initialised because the non-shortcut poll path takes them.
+ */
+static struct dm_test_poll_ctx *dm_test_poll_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_poll_ctx *ctx;
+	struct device *dev;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	ctx->drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						       sizeof(*ctx->adev),
+						       offsetof(struct amdgpu_device, ddev),
+						       DRIVER_MODESET);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
+	ctx->adev = drm_to_adev(ctx->drm);
+	mutex_init(&ctx->adev->dm.dc_lock);
+
+	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	KUNIT_ASSERT_EQ(test,
+		drmm_connector_init(ctx->drm, &ctx->aconnector->base,
+				    &dm_test_connector_funcs,
+				    DRM_MODE_CONNECTOR_VGA, NULL), 0);
+	mutex_init(&ctx->aconnector->hpd_lock);
+
+	ctx->dc = kunit_kzalloc(test, sizeof(*ctx->dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc);
+	ctx->link_srv = kunit_kzalloc(test, sizeof(*ctx->link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link_srv);
+	ctx->dc->link_srv = ctx->link_srv;
+
+	ctx->dc_ctx = kunit_kzalloc(test, sizeof(*ctx->dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc_ctx);
+
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	ctx->link->dc = ctx->dc;
+	ctx->link->ctx = ctx->dc_ctx;
+	ctx->aconnector->dc_link = ctx->link;
+
+	return ctx;
+}
+
+/**
+ * dm_test_poll_connected_cached_sink - Test the connected path reusing a sink
+ * @test: The KUnit test context
+ *
+ * detect_connection_type reports a connection and a local_sink already exists,
+ * so the short-circuit skips full detection and the status stays connected.
+ */
+static void dm_test_poll_connected_cached_sink(struct kunit *test)
+{
+	struct dm_test_poll_ctx *ctx = dm_test_poll_ctx_alloc(test);
+	struct dc_sink *local_sink;
+
+	ctx->link_srv->detect_connection_type = dm_test_poll_detect_type_connected;
+	local_sink = kunit_kzalloc(test, sizeof(*local_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, local_sink);
+	ctx->link->local_sink = local_sink;
+	ctx->link->type = dc_connection_single;
+	ctx->aconnector->base.status = connector_status_connected;
+
+	KUNIT_EXPECT_EQ(test,
+		(int)amdgpu_dm_connector_poll(ctx->aconnector, false),
+		(int)connector_status_connected);
+}
+
+/**
+ * dm_test_poll_connected_new_sink - Test the connected path via full detection
+ * @test: The KUnit test context
+ *
+ * With no cached local_sink, dc_link_detect() is consulted and reports a
+ * connection, so the status becomes connected.
+ */
+static void dm_test_poll_connected_new_sink(struct kunit *test)
+{
+	struct dm_test_poll_ctx *ctx = dm_test_poll_ctx_alloc(test);
+
+	ctx->link_srv->detect_connection_type = dm_test_poll_detect_type_connected;
+	ctx->link_srv->detect_link = dm_test_poll_detect_link_connected;
+	ctx->link->local_sink = NULL;
+	ctx->aconnector->base.status = connector_status_connected;
+
+	KUNIT_EXPECT_EQ(test,
+		(int)amdgpu_dm_connector_poll(ctx->aconnector, false),
+		(int)connector_status_connected);
+}
+
+/**
+ * dm_test_poll_disconnect_releases_sink - Test the disconnect teardown path
+ * @test: The KUnit test context
+ *
+ * detect_connection_type reports no connection while the cached status was
+ * connected, so the stale local_sink is released and cleared before the
+ * connector is re-evaluated.
+ */
+static void dm_test_poll_disconnect_releases_sink(struct kunit *test)
+{
+	struct dm_test_poll_ctx *ctx = dm_test_poll_ctx_alloc(test);
+	struct dc_sink_init_data sink_init = { 0 };
+	struct dc_sink *local_sink;
+
+	ctx->link_srv->detect_connection_type = dm_test_poll_detect_type_none;
+
+	sink_init.link = ctx->link;
+	sink_init.sink_signal = SIGNAL_TYPE_VIRTUAL;
+	local_sink = dc_sink_create(&sink_init);
+	KUNIT_ASSERT_NOT_NULL(test, local_sink);
+	ctx->link->local_sink = local_sink;
+
+	ctx->aconnector->base.status = connector_status_connected;
+	ctx->aconnector->dc_sink = NULL;
+
+	KUNIT_EXPECT_EQ(test,
+		(int)amdgpu_dm_connector_poll(ctx->aconnector, false),
+		(int)connector_status_disconnected);
+	KUNIT_EXPECT_NULL(test, ctx->link->local_sink);
+}
+
 /* Tests for amdgpu_dm_connector_late_register() and _unregister() */
 
 /*
@@ -6331,6 +6493,9 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_detect_no_sink),
 	/* amdgpu_dm_connector_poll */
 	KUNIT_CASE(dm_test_poll_dac_load_returns_cached),
+	KUNIT_CASE(dm_test_poll_connected_cached_sink),
+	KUNIT_CASE(dm_test_poll_connected_new_sink),
+	KUNIT_CASE(dm_test_poll_disconnect_releases_sink),
 	/* amdgpu_dm_connector_late_register */
 	KUNIT_CASE(dm_test_late_register_non_dp_succeeds),
 	/* amdgpu_dm_connector_unregister */
-- 
2.43.0

