Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A870C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B2CC10EB48;
	Tue,  8 Sep 2026 11:37:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1CxAYsOd";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3167710EB48
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:36:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydnhflwyhtKc3moz6PQlohSrTmTJg6pssbA3dGAj/wJkqLFKWQ5Cyq+haIwc4YNk4AEyy1AURCukjot0hD/dEOmg5J9R6jB9EBGe7CHN0i1Caq+s4ek48fyOJ6Ad7JKLPIiBB4Ud9FptWLnfKlqWYq5Gz+/MJm4KdSBUEowuTebcp1DiRFuUJj0LNSkUIVa/60mf2KwNR1Jqvn3vwTFMeXJT9gC38940pQIYyfmpBsKnpGm5nCSvTfiUQEc4sOol6sTWp/3B0FgCPQqqaQURnJw7V3O4aE0+yS6FUVACg/RS0LnX9x4mAWao3Nl4O/Lq5Wgu8bt3C/7WedqiEcdW3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4X+2l3btByIEDNvvMaOep00dBZcEr9zhv62mju1uKpU=;
 b=ETFYSI3duilaI2ObwkrK7YS/pnSYnJ74DIqMtmxcEbHT0uwSsMUoeZGI5YPke/X+lOer/RFhM6jAq/ZqQ52Z6VrcDEPa/m2NEuNPIFF5Wohutm1YmEunljzy03X49aoufd12cJy8cCish4x3A12gQIEy2zC6vjyfAPR0unvc6QFhHlRGAvHhw3ZgLWnuXtAdjZjdhFHZJVIFSmaJLXNRDzrx01v/tc8r4SB7SHOXQiiLhEl+AUsEc5ZD5JVUUXRdr26Wf9VGOd06rb9KhQXPYtiFbsbTzkchaZusIjjRaoxDAm+M/AY+r+Ev0Ye/VS6cXsruprskjSmUmvDKS6GQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4X+2l3btByIEDNvvMaOep00dBZcEr9zhv62mju1uKpU=;
 b=1CxAYsOdrphM4BRY1iOBc8QBtxas3rWe0gNxmDIqGm0QW7r4NwRyXSRg+LFpT2d8Hdk6f3PqrsRHHd0wBJcIl2aUGxYTytdnQOWHcKUFPYt1kkzhd4T9BcFer1rjSjadubboMvlbFCamJyY3NEIS7a2DYBmYlOlMJfHmNplgGIM=
Received: from MN2PR18CA0021.namprd18.prod.outlook.com (2603:10b6:208:23c::26)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:36:54 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::18) by MN2PR18CA0021.outlook.office365.com
 (2603:10b6:208:23c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:36:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:36:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:36:53 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:36:44 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 21/66] drm/amd/display: Test MST connector creation
Date: Tue, 8 Sep 2026 19:31:14 +0800
Message-ID: <20260908113338.2433445-22-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|CH1PR12MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c186a65-3186-4e66-5a26-08df0d9d7b5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: JQx8N/5HoFHEtUh6fEANM6O9aMil33aDBn74ZRhJrVX5FWAK0NADuZjqMVtUTBrY4uqezQid+l+CpiTPROJgpLg0vyXtqjIm0J/GaBt6GpAhIgUtjJPcnfEKd+gfqiyEottaK+dE0H7oTcGb/GFvnTxStgMkefWRKcNbMBtsIJfNPNCgwryXujDMc1rf5lT5On+TNcmdso5CmxyJZ+yWGMapG/TR9l+AQG/QLBJgEvLhxcxJCKhX7D/wy38jLRu220YAtrZqIVCxgVANFbmMn9/yrEYt6qFk49JsYIfoliP6MA3MrLMcjN0mv/YrRRpNRPEwFzuh8qshyh0DWE4r0MbeSJBB776e5L0u2cn2BtSAUhYuXkPuRbxot0F+mcTYbPGLuhV+rR+1grX9NsZ0BPUQXJr8V3xVF4wVTsCjuQJao3cRm7OzQvUKcY0w9fZ3rFRFuQNoG6eLW/7ivawVN24uKXH375H3s745qGAWYt28bS+VyYHcbRCGKawafxsOx513NUCEJJjOPvsjDSR7BAH6MVF8zdkbMhM5xcYYWyrZ+c2rKL6PcYwtcnGy3vwi0DqpxPFSeIJVwpVniRbqHlm7JqQFuGaR84PEGgtCTd3UL4CoNNe1k3Et0FfZNdp9kMfJsKgTFF9p/bzCcRBBFo1pOe/PNKxyDyzVrjNpqXxnG8+gajj0cOfXM0jrAF7HoNev2vcY9VecZR+xVPAfiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0AW541DyB56OSG8IMw4Ne56tSFVPD3ZOqvnNwk2+kbQ5z+azptKgp9oA1EG0SFOW1OJ1XCFKR2trV2d/QaRV7qKIUyngkwbfgnJhoMmH8V4ibB5fS3hD1E7/GTvqj4ZbQQeTnNFWjJS+rnpCy9bQKpRaXkpPOJHC2+A4HICG21X8auF6jlsvM7dTkjpOTCsiaprkBLDDD7bQZIckQpJjodyerqO5FTXEHBlB4fJZ5yxqldpLDSp6GOMQ0UrPfAErXwKCggXK0nnGUHcQ3KWRGFT/aTZ13M10eEerf2tr2ZTLiRu98Od3PWSRYsK60GYQ1+4T/BE0iDVoGCv/B3X59HBSHgav6IWxBuKYFpGQEADWH5OCtpSDA8qYrn5SappOygebJ1H7nkGK7f2aHesVa0m6zaTfE6J99ngigRGE25LzzLA63VdRFmox0kLl3515
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:36:54.0271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c186a65-3186-4e66-5a26-08df0d9d7b5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576
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
Add KUnit tests for dm_dp_add_mst_connector() covering successful
connector creation, inheritance of the master connector properties and
the connector init failure path.

[HOW]
Set up an MST topology manager owned by a master amdgpu_dm_connector
plus the mode properties the helper attaches, then add a port and check
the resulting connector, its property values and the encoder links. The
failure path is driven by a mode config without the connector functions
required by drm_connector_init(), and the port reference count is
checked to confirm the error unwind releases it.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   4 +
 .../tests/amdgpu_dm_mst_types_test.c          | 202 ++++++++++++++++++
 3 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index aad8fff2cd6f..f857303fe386 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -660,7 +660,7 @@ dm_dp_create_fake_mst_encoders(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(dm_dp_create_fake_mst_encoders);
 
-static struct drm_connector *
+STATIC_IFN_KUNIT struct drm_connector *
 dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 			struct drm_dp_mst_port *port,
 			const char *pathprop)
@@ -742,6 +742,7 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 
 	return connector;
 }
+EXPORT_IF_KUNIT(dm_dp_add_mst_connector);
 
 /*
  * Select the ESI[1] mask used to filter the MST sideband ready bits for a
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 50dca0ef98fe..0e6189219eb2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -65,6 +65,7 @@ struct dc_state;
 struct dc_stream_state;
 struct dm_atomic_state;
 struct drm_atomic_commit;
+struct drm_dp_mst_port;
 struct drm_dp_mst_topology_mgr;
 
 uint32_t dm_mst_get_pbn_divider(struct dc_link *link);
@@ -119,6 +120,9 @@ int dm_dp_mst_atomic_check(struct drm_connector *connector,
 int dm_dp_mst_detect(struct drm_connector *connector,
 			     struct drm_modeset_acquire_ctx *ctx, bool force);
 int dm_dp_mst_get_modes(struct drm_connector *connector);
+struct drm_connector *dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
+					      struct drm_dp_mst_port *port,
+					      const char *pathprop);
 int amdgpu_dm_mst_connector_late_register(struct drm_connector *connector);
 void amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector);
 void dm_dp_mst_connector_destroy(struct drm_connector *connector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index af2dd5b8e79d..f2bae3a50941 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -15,6 +15,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_modeset_lock.h>
+#include <drm/drm_property.h>
 #include <drm/display/drm_dp.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
@@ -1297,6 +1298,203 @@ static void dm_mst_test_create_fake_mst_encoders(struct kunit *test)
 	}
 }
 
+/* Tests for dm_dp_add_mst_connector */
+
+struct dm_mst_test_add_ctx {
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *master;
+	struct drm_dp_mst_port *port;
+	struct dc_link *link;
+};
+
+/*
+ * Stand in for amdgpu_display_modeset_create_props(), which the test module
+ * cannot link against. Only the properties amdgpu_dm_connector_init_helper()
+ * attaches are created.
+ */
+static void dm_mst_test_create_mode_props(struct kunit *test, struct amdgpu_device *adev)
+{
+	struct amdgpu_mode_info *mode_info = &adev->mode_info;
+	struct drm_device *drm = adev_to_drm(adev);
+
+	KUNIT_ASSERT_EQ(test, drm_mode_create_scaling_mode_property(drm), 0);
+
+	mode_info->underscan_property =
+		drm_property_create_range(drm, 0, "underscan", 0, 1);
+	mode_info->underscan_hborder_property =
+		drm_property_create_range(drm, 0, "underscan hborder", 0, 128);
+	mode_info->underscan_vborder_property =
+		drm_property_create_range(drm, 0, "underscan vborder", 0, 128);
+	KUNIT_ASSERT_NOT_NULL(test, mode_info->underscan_property);
+	KUNIT_ASSERT_NOT_NULL(test, mode_info->underscan_hborder_property);
+	KUNIT_ASSERT_NOT_NULL(test, mode_info->underscan_vborder_property);
+}
+
+/*
+ * Build the MST root connector and the topology port the new downstream
+ * connector hangs off. The port has no parent branch so the callback takes the
+ * "no branch descriptor" path without needing a sideband AUX backend.
+ */
+static void dm_mst_test_init_add_ctx(struct kunit *test, struct dm_mst_test_add_ctx *ctx)
+{
+	struct amdgpu_device *adev;
+	struct drm_device *drm;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	drm = &adev->ddev;
+	ret = drmm_mode_config_init(drm);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	dm_mst_test_create_mode_props(test, adev);
+
+	adev->dm.adev = adev;
+	adev->dm.ddev = drm;
+	adev->dm.display_indexes_num = 2;
+	adev->mode_info.num_crtc = 2;
+	dm_dp_create_fake_mst_encoders(adev);
+
+	ctx->adev = adev;
+	ctx->link = dm_kunit_alloc_link(test);
+	/* Inflexible DIG mapping lets link_enc_cfg_get_link_enc() skip the dc lookup. */
+	ctx->link->link_enc = kunit_kzalloc(test, sizeof(*ctx->link->link_enc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link->link_enc);
+
+	ctx->master = dm_kunit_alloc_connector(test, adev, ctx->link);
+	ctx->master->connector_id = 5;
+	ret = drm_connector_init(drm, &ctx->master->base, &dm_mst_test_connector_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ctx->port = kunit_kzalloc(test, sizeof(*ctx->port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->port);
+	kref_init(&ctx->port->malloc_kref);
+	ctx->port->mgr = &ctx->master->mst_mgr;
+}
+
+/* True when @prop is attached to the connector's mode object. */
+static bool dm_mst_test_has_prop(struct drm_connector *connector, struct drm_property *prop)
+{
+	struct drm_object_properties *props = connector->base.properties;
+	int i;
+
+	if (!prop)
+		return false;
+
+	for (i = 0; i < props->count; i++)
+		if (props->properties[i] == prop)
+			return true;
+
+	return false;
+}
+
+/**
+ * dm_mst_test_add_mst_connector_creates - Test downstream connector creation
+ * @test: KUnit test context
+ *
+ * The topology callback must allocate a DisplayPort connector bound to the port
+ * and the root connector, inherit the root's dc_link and connector id, attach
+ * every fake MST encoder, publish the path property and take a malloc
+ * reference on the port.
+ */
+static void dm_mst_test_add_mst_connector_creates(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct dm_mst_test_add_ctx ctx;
+	struct drm_connector *connector;
+
+	dm_mst_test_init_add_ctx(test, &ctx);
+
+	connector = dm_dp_add_mst_connector(&ctx.master->mst_mgr, ctx.port, "1-3");
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+
+	aconnector = to_amdgpu_dm_connector(connector);
+	KUNIT_EXPECT_PTR_EQ(test, aconnector->mst_output_port, ctx.port);
+	KUNIT_EXPECT_PTR_EQ(test, aconnector->mst_root, ctx.master);
+	KUNIT_EXPECT_PTR_EQ(test, aconnector->dc_link, ctx.link);
+	KUNIT_EXPECT_EQ(test, aconnector->connector_id, 5);
+	KUNIT_EXPECT_TRUE(test, aconnector->mst_status & MST_PROBE);
+	KUNIT_EXPECT_EQ(test, aconnector->branch_ieee_oui, 0U);
+	KUNIT_EXPECT_EQ(test, connector->connector_type, DRM_MODE_CONNECTOR_DisplayPort);
+	KUNIT_EXPECT_EQ(test, connector->possible_encoders, 0x3U);
+	KUNIT_EXPECT_NOT_NULL(test, connector->state);
+	KUNIT_EXPECT_NOT_NULL(test, connector->path_blob_ptr);
+	KUNIT_EXPECT_EQ(test, kref_read(&ctx.port->malloc_kref), 2U);
+	KUNIT_EXPECT_TRUE(test,
+			  dm_mst_test_has_prop(connector,
+					       ctx.adev->ddev.mode_config.path_property));
+	KUNIT_EXPECT_TRUE(test,
+			  dm_mst_test_has_prop(connector,
+					       ctx.adev->ddev.mode_config.tile_property));
+
+	dm_dp_mst_connector_destroy(connector);
+}
+
+/**
+ * dm_mst_test_add_mst_connector_inherits_props - Test optional property sharing
+ * @test: KUnit test context
+ *
+ * Max bpc, VRR capable and colorspace properties are only attached to the new
+ * connector when the root connector already owns them, so the downstream
+ * connector shares the root's property objects.
+ */
+static void dm_mst_test_add_mst_connector_inherits_props(struct kunit *test)
+{
+	struct dm_mst_test_add_ctx ctx;
+	struct drm_connector *connector;
+	struct drm_device *drm;
+
+	dm_mst_test_init_add_ctx(test, &ctx);
+	drm = &ctx.adev->ddev;
+
+	ctx.master->base.max_bpc_property =
+		drm_property_create_range(drm, 0, "max bpc", 8, 16);
+	ctx.master->base.vrr_capable_property =
+		drm_property_create_bool(drm, DRM_MODE_PROP_IMMUTABLE, "vrr_capable");
+	KUNIT_ASSERT_NOT_NULL(test, ctx.master->base.max_bpc_property);
+	KUNIT_ASSERT_NOT_NULL(test, ctx.master->base.vrr_capable_property);
+	KUNIT_ASSERT_EQ(test, drm_mode_create_dp_colorspace_property(&ctx.master->base, 0), 0);
+
+	connector = dm_dp_add_mst_connector(&ctx.master->mst_mgr, ctx.port, "1-4");
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+
+	KUNIT_EXPECT_PTR_EQ(test, connector->max_bpc_property, ctx.master->base.max_bpc_property);
+	KUNIT_EXPECT_PTR_EQ(test, connector->vrr_capable_property,
+			    ctx.master->base.vrr_capable_property);
+	KUNIT_EXPECT_PTR_EQ(test, connector->colorspace_property,
+			    ctx.master->base.colorspace_property);
+	KUNIT_EXPECT_TRUE(test, dm_mst_test_has_prop(connector, connector->max_bpc_property));
+	KUNIT_EXPECT_TRUE(test, dm_mst_test_has_prop(connector, connector->colorspace_property));
+
+	dm_dp_mst_connector_destroy(connector);
+}
+
+/**
+ * dm_mst_test_add_mst_connector_init_fails - Test the connector init failure path
+ * @test: KUnit test context
+ *
+ * Exhausting the device connector index space makes drm_connector_dynamic_init()
+ * fail, so the callback must free the connector it allocated, leave the port
+ * malloc reference untouched and report no connector to the MST helpers.
+ */
+static void dm_mst_test_add_mst_connector_init_fails(struct kunit *test)
+{
+	struct dm_mst_test_add_ctx ctx;
+	struct drm_device *drm;
+	int id;
+
+	dm_mst_test_init_add_ctx(test, &ctx);
+	drm = &ctx.adev->ddev;
+
+	/* drm_connector_init_only() takes an index out of the same [0, 31] space. */
+	do {
+		id = ida_alloc_max(&drm->mode_config.connector_ida, 31, GFP_KERNEL);
+	} while (id >= 0);
+	KUNIT_ASSERT_EQ(test, id, -ENOSPC);
+
+	KUNIT_EXPECT_NULL(test, dm_dp_add_mst_connector(&ctx.master->mst_mgr, ctx.port, "1-5"));
+	KUNIT_EXPECT_EQ(test, kref_read(&ctx.port->malloc_kref), 1U);
+}
+
 /**
  * dm_mst_test_atomic_check_no_old_crtc - Test atomic check no-op path
  * @test: KUnit test context
@@ -2134,6 +2332,10 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_atomic_best_encoder),
 	/* dm_dp_create_fake_mst_encoders tests */
 	KUNIT_CASE(dm_mst_test_create_fake_mst_encoders),
+	/* dm_dp_add_mst_connector tests */
+	KUNIT_CASE(dm_mst_test_add_mst_connector_creates),
+	KUNIT_CASE(dm_mst_test_add_mst_connector_inherits_props),
+	KUNIT_CASE(dm_mst_test_add_mst_connector_init_fails),
 	/* dm_dp_mst_atomic_check tests */
 	KUNIT_CASE(dm_mst_test_atomic_check_no_old_crtc),
 	/* dm_dp_mst_detect tests */
-- 
2.43.0

