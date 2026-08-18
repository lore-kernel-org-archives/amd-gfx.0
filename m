Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8702DC5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2226E10E38B;
	Tue, 18 Aug 2026 20:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a0wB2p1D";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010052.outbound.protection.outlook.com
 [40.93.198.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 811F210ECA7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:23:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQ/jqeS/6lYCX8zCVVaoi69X8GKEgB1uzNrhjS0asvd+851Cu8pkUE0031QfrGLHfxDz1f/xAY7wjPK4j92pk//UTg+fG4tGnA4+jj4TN5W24MgFqtX32vlVQuVQPTi9HQfz5olN2yofT/3hihU04FigXzuR25Td8TVvtqdYu10Xa9zM1EBm7Bmrd6gQh4UNFHTm6x3rRlvatdhHa/nrt5SdCob9UdTM2pd0VZTkG2DZD4fqW2157cGuNzuOvVG0u/cRLqhVeeyTYQ7BCAgsRg9xtAK3OHHxQLPUVCQKm9Y2E9Hbhm2l7VumNCtFPsDdRZLL393OKeW+r6bA+nbq1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ihXUVNol6uYesgGMh7yPd37AX+yy+ySDOUVh3numtI=;
 b=W4p3i5+sfoOVjtaVM0ptZS1239z4iyrjvXK73aDa8FsN/Il/OHGDx1rmxedIyli3GwY5ch26hWyh9Zln/101rG7TNL1VaDmdfZ/BG/q7Vlmx+sjxCvvw7HOEs3ZtM+71DMAKx3wsMJD+qjsJbr2shaoMJe4hAg+nN8IdTTQhmilYMh9W+rbg647HaiGWh2Hif9yjfFSbQGH2mGNIgomE6OlejfNBa2r6mvCZKVqIgGWL+9ZThh3GYk8t3t7e5Lq9zBJDQB8Sdl9PjXEDAyFkWay64jVLs37Fey5t2b94KVeja6Jzg+rPW72IZ1H5My/DEDRkOEC9KO4gYb+zP80FYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ihXUVNol6uYesgGMh7yPd37AX+yy+ySDOUVh3numtI=;
 b=a0wB2p1D+08pvV5ReZM/KufAcj7zApO1YQWulM7zI7LtAA1scv79nLkpdDo/7NT2Whsf4mZcP+roA8mTrLoAm8m47PQmDChNqXBgYwV6muZX5wO/+9gDkc/QH8PFJ9aZ1rtmaTsL+DaIUNgpaoGB6xmvw0ovpTI+Av28xFhbGdA=
Received: from CH5P222CA0008.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::17)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:30 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::a2) by CH5P222CA0008.outlook.office365.com
 (2603:10b6:610:1ee::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:21 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:21 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 39/82] drm/amd/display: Test dm_dp_mst_get_modes without a
 remote EDID
Date: Tue, 18 Aug 2026 16:15:31 -0400
Message-ID: <20260818202139.4172592-40-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: 146a88fc-6a4a-443e-18a8-08defd666de1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TbXXvUba9hK1WVsd+4Gym/wHnfFfty0f3hlJ5VjFPc+GWF6i0M0WALEwKy+ifGVRXo43GiV72oCE14H6o+mR9Q+J94wE9ahLJwlAazQNKuRy2YRRt8KqU/aSTu0c/jakbCYFfrOlwn9oXCkfLn3PhXxyBeG1Nqv8LSuZSi3U7oY3wp/tCT94+8Xwjfd6ZJeleCN2Qp+g7ZtIzfNhw2E9Y+Hxoi3XBEt/cGG1DQfrANEPc/d2OaqBIh3qxHbvGbIrI6I/BkLbA6aWq8I1yple6Zcx+WiXz2vS5FKf5naFMU3A0rzwQxhJRcBoD979l11XxCD70KvSKhMSSFxhxrXaGHZVExAKEhS3DUxiLkStN9Jk6nVtTUrba/v3BzV02tx3RNuV45s+VeLrXsgWVzhqRTJ7jyQoE4B2MoFM+6Okdlnw9Wic9uawL7NaseHhxcvWXJ/wYuve6591D+YirE4dIrBq/9pIIfhFfNWGA44OVvECJYR30p5Qozg4U39SQRAGkLHWyJ0st2wwircFl7CtdMkTn2QiJu3ugZo8RGo1MgVWkdVZWiSY/3wGfnCZin3ZcjH0NERoahE3CGjGhnX16Xe6dsFgRjgOiy8KN07Bk1WJstFNRcrpyRTENn/mbMwYbgjLchjcdO1ZnB9yS+zaAhQr5qAu7bJVoISM+yIMCBOEG2F8zL/RiFcnUzHX61jiAbVFCeOZuJ7RtVTmoX5LOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jQODYC+zRq7fvEJHppBKeak5lhwPFkC0F4mdKdjEhMYrbxZQAaAc+ZjVv83fiMAv2CVIRMo4NCDIWleut4b+ilQ/xdI3fbeIq6UkTgDgwGQqnKE7yZkbaBxVT2lzdkgG8NAWOAS9dy31i7wVU+9t9nnttGDXaz69ITSEe+Ma7pfQA04Ox3f8nlMUncw2GpqAsaIlbBEaJezmjhTRDr8h/AK/xqgSDsLmhXaUkIYt10ru+anD7mnO1OGR0qOZBLX4WMXIax9Ybc8HkonTMLVK98YC+/soCoQ2tvlhymruUCWrYTiA7W+Ve0l15J/nG+CngSZ37TE7qz98tRCrGDFxFibXY8MISLSCF0Yjxy+sS3ztUq/5+5YqG+GYihsjiaxK/rpFsCuwaCmUmSW834hM3B5g2TfKigNGowi/VbodQ6x07OhfXoXi05fOcIB9QwND
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:30.4705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 146a88fc-6a4a-443e-18a8-08defd666de1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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
Add KUnit tests for dm_dp_mst_get_modes() covering the path taken when
the remote EDID cannot be read: the default remote sink is registered and
MST_REMOTE_EDID is cleared, DC refusing the sink leaves the connector
without one, and an already attached sink is kept instead of asking DC
for a second one.

[HOW]
A shared fixture builds an MST downstream connector on a real DRM device
with an empty topology manager, so drm_dp_mst_edid_read() takes its "port
is gone" path without needing a branch device. dc_link_add_remote_sink()
and dc_link_remove_remote_sink() are thin wrappers over link_service
callbacks, so fakes for those two are enough to run the connector paths
without a DC core.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   1 +
 .../tests/amdgpu_dm_mst_types_test.c          | 216 ++++++++++++++++++
 3 files changed, 219 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 045a7f88b7546..79e8952edf8c0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -386,7 +386,7 @@ STATIC_IFN_KUNIT bool retrieve_branch_specific_data(struct amdgpu_dm_connector *
 }
 EXPORT_IF_KUNIT(retrieve_branch_specific_data);
 
-static int dm_dp_mst_get_modes(struct drm_connector *connector)
+STATIC_IFN_KUNIT int dm_dp_mst_get_modes(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	int ret = 0;
@@ -518,6 +518,7 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 
 	return ret;
 }
+EXPORT_IF_KUNIT(dm_dp_mst_get_modes);
 
 STATIC_IFN_KUNIT struct drm_encoder *
 dm_mst_atomic_best_encoder(struct drm_connector *connector,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 2ae9d4b88888f..406dba95c4aec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -118,6 +118,7 @@ int dm_dp_mst_atomic_check(struct drm_connector *connector,
 				   struct drm_atomic_commit *state);
 int dm_dp_mst_detect(struct drm_connector *connector,
 			     struct drm_modeset_acquire_ctx *ctx, bool force);
+int dm_dp_mst_get_modes(struct drm_connector *connector);
 #endif
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 6a5191f9baf61..ee4e1f3963736 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -8,11 +8,13 @@
 #include <kunit/test.h>
 
 #include <drm/drm_drv.h>
+#include <drm/drm_edid.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_mode_config.h>
+#include <drm/drm_modeset_lock.h>
 #include <drm/display/drm_dp.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
@@ -1343,6 +1345,216 @@ static void dm_mst_test_detect_unregistered(struct kunit *test)
 			(int)connector_status_disconnected);
 }
 
+/*
+ * Fake DC remote-sink backend. dc_link_add_remote_sink() and
+ * dc_link_remove_remote_sink() are thin wrappers over these link_service
+ * callbacks, so overriding them is enough to run the MST connector paths
+ * without a DC core.
+ */
+static struct dc_sink *dm_mst_test_next_remote_sink;
+static struct dc_sink *dm_mst_test_removed_sink;
+static unsigned int dm_mst_test_add_remote_sink_calls;
+static unsigned int dm_mst_test_remove_remote_sink_calls;
+
+/* Signature copied verbatim from struct link_service::add_remote_sink. */
+static struct dc_sink *dm_mst_test_add_remote_sink(
+		struct dc_link *link,
+		const uint8_t *edid,
+		unsigned int len,
+		struct dc_sink_init_data *init_data)
+{
+	struct dc_sink *sink = dm_mst_test_next_remote_sink;
+
+	dm_mst_test_add_remote_sink_calls++;
+
+	if (sink) {
+		sink->link = link;
+		sink->sink_signal = init_data->sink_signal;
+		link->sink_count++;
+	}
+
+	return sink;
+}
+
+/* Signature copied verbatim from struct link_service::remove_remote_sink. */
+static void dm_mst_test_remove_remote_sink(struct dc_link *link, struct dc_sink *sink)
+{
+	dm_mst_test_remove_remote_sink_calls++;
+	dm_mst_test_removed_sink = sink;
+
+	if (link->sink_count)
+		link->sink_count--;
+}
+
+/*
+ * dc_sink_release() frees the sink with kfree(), so these must not come from
+ * the KUnit managed allocator.
+ */
+static struct dc_sink *dm_mst_test_alloc_sink(struct kunit *test)
+{
+	struct dc_sink *sink = kzalloc_obj(*sink);
+
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+	kref_init(&sink->refcount);
+
+	return sink;
+}
+
+struct dm_mst_test_child {
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_dm_connector *root;
+	struct drm_dp_mst_port *port;
+	struct dc_link *link;
+};
+
+/*
+ * Build an MST downstream connector hanging off a root connector. The topology
+ * manager is left empty (no mst_primary) so the DRM MST helpers take their
+ * "port is gone" paths instead of requiring a real branch device.
+ */
+static void dm_mst_test_init_child(struct kunit *test, struct dm_mst_test_child *child)
+{
+	struct link_service *link_srv;
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	ret = drmm_mode_config_init(&adev->ddev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	child->port = kunit_kzalloc(test, sizeof(*child->port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, child->port);
+
+	link_srv->add_remote_sink = dm_mst_test_add_remote_sink;
+	link_srv->remove_remote_sink = dm_mst_test_remove_remote_sink;
+	dc->link_srv = link_srv;
+
+	child->adev = adev;
+	child->link = dm_kunit_alloc_link(test);
+	child->link->dc = dc;
+
+	child->root = dm_kunit_alloc_connector(test, adev, child->link);
+	child->root->mst_mgr.dev = &adev->ddev;
+	mutex_init(&child->root->mst_mgr.lock);
+	drm_modeset_lock_init(&child->root->mst_mgr.base.lock);
+
+	child->port->mgr = &child->root->mst_mgr;
+	child->port->aux.name = "dm_mst_test_port_aux";
+	child->port->aux.transfer = dm_mst_test_aux_transfer;
+	drm_dp_aux_init(&child->port->aux);
+	drm_dp_dpcd_set_probe(&child->port->aux, false);
+
+	child->aconnector = dm_kunit_alloc_connector(test, adev, child->link);
+	child->aconnector->mst_root = child->root;
+	child->aconnector->mst_output_port = child->port;
+
+	ret = drm_connector_init(&adev->ddev, &child->aconnector->base,
+				 &dm_mst_test_connector_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	/* The MST (un)register helpers log through the connector's kernel device. */
+	child->aconnector->base.kdev = adev->ddev.dev;
+
+	memset(dm_mst_test_dpcd, 0, sizeof(dm_mst_test_dpcd));
+	dm_mst_test_aux_transfer_override = 0;
+	dm_mst_test_aux_write_override = 0;
+	dm_mst_test_next_remote_sink = NULL;
+	dm_mst_test_removed_sink = NULL;
+	dm_mst_test_add_remote_sink_calls = 0;
+	dm_mst_test_remove_remote_sink_calls = 0;
+}
+
+static void dm_mst_test_fini_child(struct dm_mst_test_child *child)
+{
+	drm_edid_free(child->aconnector->drm_edid);
+	drm_edid_free(child->port->cached_edid);
+	drm_connector_cleanup(&child->aconnector->base);
+	drm_modeset_lock_fini(&child->root->mst_mgr.base.lock);
+	mutex_destroy(&child->root->mst_mgr.lock);
+}
+
+/* Tests for dm_dp_mst_get_modes */
+
+/**
+ * dm_mst_test_get_modes_no_edid_adds_default_sink - Test default remote sink
+ * @test: KUnit test context
+ *
+ * When the remote EDID cannot be read, dm_dp_mst_get_modes() must clear the
+ * MST_REMOTE_EDID status and register a default remote sink for the connector.
+ */
+static void dm_mst_test_get_modes_no_edid_adds_default_sink(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+	struct dc_sink *sink;
+
+	dm_mst_test_init_child(test, &child);
+	sink = dm_mst_test_alloc_sink(test);
+	dm_mst_test_next_remote_sink = sink;
+	child.aconnector->mst_status = MST_REMOTE_EDID;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_get_modes(&child.aconnector->base), 0);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_add_remote_sink_calls, 1U);
+	KUNIT_EXPECT_PTR_EQ(test, child.aconnector->dc_sink, sink);
+	KUNIT_EXPECT_PTR_EQ(test, sink->priv, (void *)child.aconnector);
+	KUNIT_EXPECT_EQ(test, child.aconnector->mst_status & MST_REMOTE_EDID, 0);
+
+	dc_sink_release(sink);
+	dm_mst_test_fini_child(&child);
+}
+
+/**
+ * dm_mst_test_get_modes_no_edid_sink_alloc_fails - Test remote sink failure
+ * @test: KUnit test context
+ *
+ * If DC cannot add the default remote sink, dm_dp_mst_get_modes() must bail out
+ * with zero modes and leave the connector without a sink.
+ */
+static void dm_mst_test_get_modes_no_edid_sink_alloc_fails(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+
+	dm_mst_test_init_child(test, &child);
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_get_modes(&child.aconnector->base), 0);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_add_remote_sink_calls, 1U);
+	KUNIT_EXPECT_NULL(test, child.aconnector->dc_sink);
+
+	dm_mst_test_fini_child(&child);
+}
+
+/**
+ * dm_mst_test_get_modes_no_edid_keeps_existing_sink - Test cached sink reuse
+ * @test: KUnit test context
+ *
+ * With no readable EDID but an existing remote sink, dm_dp_mst_get_modes() must
+ * keep that sink and must not ask DC for another one.
+ */
+static void dm_mst_test_get_modes_no_edid_keeps_existing_sink(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+	struct dc_sink *sink;
+
+	dm_mst_test_init_child(test, &child);
+	sink = dm_mst_test_alloc_sink(test);
+	child.aconnector->dc_sink = sink;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_get_modes(&child.aconnector->base), 0);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_add_remote_sink_calls, 0U);
+	KUNIT_EXPECT_PTR_EQ(test, child.aconnector->dc_sink, sink);
+
+	dc_sink_release(sink);
+	dm_mst_test_fini_child(&child);
+}
+
 /*
  * Sideband connector with a live topology manager and the DOWN_REP ready bit
  * armed, so dm_handle_mst_sideband_msg_ready_event() reaches its ack path.
@@ -1491,6 +1703,10 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_atomic_check_no_old_crtc),
 	/* dm_dp_mst_detect tests */
 	KUNIT_CASE(dm_mst_test_detect_unregistered),
+	/* dm_dp_mst_get_modes tests */
+	KUNIT_CASE(dm_mst_test_get_modes_no_edid_adds_default_sink),
+	KUNIT_CASE(dm_mst_test_get_modes_no_edid_sink_alloc_fails),
+	KUNIT_CASE(dm_mst_test_get_modes_no_edid_keeps_existing_sink),
 	/* CONFIG_DRM_AMD_DC_FP disabled public paths */
 #if !defined(CONFIG_DRM_AMD_DC_FP)
 	KUNIT_CASE(dm_mst_test_fp_guarded_public_stubs),
-- 
2.43.0

