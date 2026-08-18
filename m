Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03886C5DF90
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E6110ECB6;
	Tue, 18 Aug 2026 20:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V0GD4a10";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F20A910ECAE
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dx/r4V9qR/+x+ZJfdhMgcxtXmvwDStcOBbfTQyX7rZz0gkbXwmaPiKOUZofAF+g1GrD8RwQGiUqMyZkgKvcWWKpcxevB21rAG/71ZE0VdGwPPQVWRE4xoPDjQvidVqgl7o62B5TtL86eNDyczsl1ptV/+rqy2moFTW9O8pMSsxJkclerOUWuPSeBt4lbm9+OZnAwLfhqPA+XvtN8NxLHsqzjd5CPaY9x2F19Z4TojLhmUVLs82I6tsEiYvvWbVmLixyfOA0DBYmm05t6U0Ct3ttFiRvtDka7LiKYthiQ1ixdFcoTXsPbccWetl4ie/tN8xpGZPbu8CsnTNxY9lCY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ruh3Tvs29eWS8V6ElnCTGBym/WipqEPMiuAnTayw86g=;
 b=UxuckR/WfWKrQO+jxLqDIc3Qd4xlxy9khAfYI1lit+wAd1SlGkpW6XETR0DuOED4/cHZL1uEJES7Aenr7o3pMYLM+GpKBeV7xh8An2sK90asJxBseZ8lEkqCgRnOwTmFup9vNjC/gcPcJrtEaxfihpuZhYmmH3KuCyybLtpH1G4+tfFNSqv8j/E7w5A3IRIktxEm6mi7d6K4U3k+o+Op/B/WGU7hgtdtgLjTDO1kDyTuqLSnaD+1U6qS4EMMnR8LT/XYA62n+jZNYXZtO7FuXxagtzoww6IVtshVhotUk96k+q/XaDQ+apV08uLjyRh51qckNMFMU47sG8FPknlPaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ruh3Tvs29eWS8V6ElnCTGBym/WipqEPMiuAnTayw86g=;
 b=V0GD4a10oFmC8ftuOxbnG7/uveKw0pTBBCM8OdosnKTTQFehxnQm7Hp/NQLE84Ga2tyJJuBykIZt2/sWiBRZqkdLlPPRqllJWc9RzV+dAdGpXkyUB7btosbtJoJuM2bF9yZG5l3V4lce9j9sgvYBq/lNUY5OBijN0SAjAGfUF0g=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by DS0PR12MB9727.namprd12.prod.outlook.com (2603:10b6:8:226::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:40 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::3) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:22 -0500
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
Subject: [PATCH 40/82] drm/amd/display: Test dm_dp_mst_get_modes with a remote
 EDID
Date: Tue, 18 Aug 2026 16:15:32 -0400
Message-ID: <20260818202139.4172592-41-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS0PR12MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d9f8645-40cb-4a83-53ce-08defd667375
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r/Y3H88rN7CXGtYhTCw0rURc/SD+vY3qbl+wu1y/D0RJVIlcxSnWyIGnp+pVYJZWqWLPKg/L5zUGQdiJd4wJ+pReQt43cTF4O+JNdrjS0JV5uGMumUGJ9R8t7LfpQzPiC51GtnX6Dj4W2/Xt79KXkChtzb6+Msx5hl7OhJVV1wIBvVaxXpA3NBMFoNk7xArucpvhBWdaL0ugdDlrCC+ZYbWCi07ogjxMXci54q0XSVeqH6/POS2X0Z4h2bSFSL9kgPSfhSJW/fR8asOmi7r+3BQgjSg3PG+FLJDfChHoL7tKWj/kR8cti+2Gh0z9C/cPfbzEnpd/eXKB0pxPvyVDVhpJXqWiwHDisCG/QEco2JXJqYNjb2EsZ2PoIZmVumAW/bpbOXGXLlmfwBmSXDZd4eI/Rnw8MAuONe5BZf06v5WTtrorqjqG0/J3IhSKbZ3Q6m3yh7/VIbJC7rMkYi7/72+GNwnp9mTd4byWix2eVEs0mDRNmvfImNcEQXVn6G3WPOMq9SjcBcadpzSgjEm0tZth609zWIr6hlkm2xcw6e8KElaT1EtcicwdIkX38dZYLmdp5rfhezAcOW7Y1fn6mCSn5Pc65Pe133KPRAkoaGxsPbP1xops7yk7R5s54MmYb0T3RW39sfgK1sBQm7iV22Im+ZuXC2dnXcZ6TJPleg898svTYGeZCUTZzlFtQzfmlFAyVfsKjakPyQSHVirPgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QIm3QdgQUybz7EfkniHB1sBTElrG8/XQRHJH7Kpncg+Q5Wqb5BeMjEdaLCus8ILl2G0vTKIKv1fTLzjdDfl8m71fe1LcJF1VsvuvB5UDvcdKrjleQvZKAHxwkdtfDri9oFIQOLuuIe+/qYiY/xQbUFj6ygUyG4ggz+GemdZYkOS2fi+fSGKGjh6yxWXdF2XrjJeJHq0H6D4xgUXrjG6M2L+Fxo4NtlBofC8mTIJaUqd7BN3EW/VStwOf1GdyNczHIFFrEXemWtNMmIUqrBCsx4X9hHCC1Sr4slEmt0YwnYSEtR4KeYOE7Yk24ev3LnO8BnrZGWhQ7EIR+Rh58J01nql4ZCL7krFqUwJZhJRr8yeW6+YfcOiJMruQDgyNQM3wZmwbH//cfFgpFoB//kV2D4mn4ArD0n86wM65hIW6UpfIRQIh3lT7u1Fc/6xM78tN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:39.8278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9f8645-40cb-4a83-53ce-08defd667375
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9727
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
Add KUnit tests for dm_dp_mst_get_modes() covering the paths taken once
an EDID is available: a placeholder virtual sink is released and replaced
by a real remote sink, DC refusing that sink returns zero modes, the
content protection state is restored from the HDCP workqueue, and an EDID
read from a port still in the topology is cached with MST_REMOTE_EDID
flagged.

[HOW]
The tests reuse the MST downstream connector fixture and feed it a
minimal EDID base block. For the remote read the fixture topology gains a
branch device holding the port so drm_dp_mst_edid_read() can validate it
and return the cached EDID.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_mst_types_test.c          | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index ee4e1f3963736..b74f0611dfe06 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -25,6 +25,7 @@
 #include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
+#include "amdgpu_dm_hdcp.h"
 #include "amdgpu_dm_mst_types.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 #include "inc/link_service.h"
@@ -1555,6 +1556,161 @@ static void dm_mst_test_get_modes_no_edid_keeps_existing_sink(struct kunit *test
 	dm_mst_test_fini_child(&child);
 }
 
+/* Minimal EDID base block: valid header, no extensions, correct checksum. */
+static const u8 dm_mst_test_edid[EDID_LENGTH] = {
+	0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00,
+	[EDID_LENGTH - 1] = 0x06,
+};
+
+/**
+ * dm_mst_test_get_modes_cached_edid_replaces_virtual_sink - Test EDID sink path
+ * @test: KUnit test context
+ *
+ * With a cached EDID and a placeholder virtual sink, dm_dp_mst_get_modes() must
+ * release the virtual sink, add a real remote sink built from the EDID, and
+ * update the connector's mode list.
+ */
+static void dm_mst_test_get_modes_cached_edid_replaces_virtual_sink(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+	struct dc_sink *virtual_sink;
+	struct dc_sink *sink;
+
+	dm_mst_test_init_child(test, &child);
+
+	child.aconnector->drm_edid = drm_edid_alloc(dm_mst_test_edid, sizeof(dm_mst_test_edid));
+	KUNIT_ASSERT_NOT_NULL(test, child.aconnector->drm_edid);
+
+	virtual_sink = dm_mst_test_alloc_sink(test);
+	virtual_sink->sink_signal = SIGNAL_TYPE_VIRTUAL;
+	child.aconnector->dc_sink = virtual_sink;
+
+	sink = dm_mst_test_alloc_sink(test);
+	dm_mst_test_next_remote_sink = sink;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_get_modes(&child.aconnector->base), 0);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_add_remote_sink_calls, 1U);
+	KUNIT_EXPECT_PTR_EQ(test, child.aconnector->dc_sink, sink);
+	KUNIT_EXPECT_EQ(test, sink->sink_signal, SIGNAL_TYPE_DISPLAY_PORT_MST);
+	KUNIT_EXPECT_PTR_EQ(test, sink->priv, (void *)child.aconnector);
+
+	dc_sink_release(sink);
+	dm_mst_test_fini_child(&child);
+}
+
+/**
+ * dm_mst_test_get_modes_cached_edid_sink_alloc_fails - Test EDID sink failure
+ * @test: KUnit test context
+ *
+ * If DC cannot add the remote sink built from the cached EDID,
+ * dm_dp_mst_get_modes() must bail out with zero modes.
+ */
+static void dm_mst_test_get_modes_cached_edid_sink_alloc_fails(struct kunit *test)
+{
+	struct dm_mst_test_child child;
+
+	dm_mst_test_init_child(test, &child);
+
+	child.aconnector->drm_edid = drm_edid_alloc(dm_mst_test_edid, sizeof(dm_mst_test_edid));
+	KUNIT_ASSERT_NOT_NULL(test, child.aconnector->drm_edid);
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
+ * dm_mst_test_get_modes_restores_hdcp_properties - Test HDCP property restore
+ * @test: KUnit test context
+ *
+ * A connector re-plugged at the same display index must have its content
+ * protection state restored from the HDCP workqueue when the remote sink is
+ * re-created.
+ */
+static void dm_mst_test_get_modes_restores_hdcp_properties(struct kunit *test)
+{
+	struct dm_connector_state *conn_state;
+	struct dm_mst_test_child child;
+	struct hdcp_workqueue *hdcp;
+	struct dc_sink *sink;
+	unsigned int index;
+
+	dm_mst_test_init_child(test, &child);
+
+	child.aconnector->drm_edid = drm_edid_alloc(dm_mst_test_edid, sizeof(dm_mst_test_edid));
+	KUNIT_ASSERT_NOT_NULL(test, child.aconnector->drm_edid);
+
+	/* drm_connector_cleanup() hands the state back to the DRM helper's kfree(). */
+	conn_state = kzalloc_obj(*conn_state);
+	hdcp = kunit_kzalloc(test, sizeof(*hdcp), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+	KUNIT_ASSERT_NOT_NULL(test, hdcp);
+
+	index = child.aconnector->base.index;
+	hdcp->hdcp_content_type[index] = DRM_MODE_HDCP_CONTENT_TYPE1;
+	hdcp->content_protection[index] = DRM_MODE_CONTENT_PROTECTION_ENABLED;
+	child.adev->dm.hdcp_workqueue = hdcp;
+	child.aconnector->base.state = &conn_state->base;
+
+	sink = dm_mst_test_alloc_sink(test);
+	dm_mst_test_next_remote_sink = sink;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_get_modes(&child.aconnector->base), 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, child.aconnector->dc_sink, sink);
+	KUNIT_EXPECT_EQ(test, child.aconnector->base.state->hdcp_content_type,
+			(unsigned int)DRM_MODE_HDCP_CONTENT_TYPE1);
+	KUNIT_EXPECT_EQ(test, child.aconnector->base.state->content_protection,
+			(unsigned int)DRM_MODE_CONTENT_PROTECTION_ENABLED);
+
+	dc_sink_release(sink);
+	dm_mst_test_fini_child(&child);
+}
+
+/**
+ * dm_mst_test_get_modes_reads_remote_edid - Test remote EDID caching
+ * @test: KUnit test context
+ *
+ * When the MST port is still in the topology, dm_dp_mst_get_modes() must read
+ * its EDID, cache it on the connector and flag MST_REMOTE_EDID.
+ */
+static void dm_mst_test_get_modes_reads_remote_edid(struct kunit *test)
+{
+	struct drm_dp_mst_branch *mstb;
+	struct dm_mst_test_child child;
+	struct dc_sink *sink;
+
+	dm_mst_test_init_child(test, &child);
+
+	/* Minimal topology so drm_dp_mst_edid_read() can validate the port. */
+	mstb = kunit_kzalloc(test, sizeof(*mstb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mstb);
+	mstb->mgr = &child.root->mst_mgr;
+	INIT_LIST_HEAD(&mstb->ports);
+	list_add(&child.port->next, &mstb->ports);
+	kref_init(&child.port->topology_kref);
+	child.root->mst_mgr.mst_primary = mstb;
+
+	child.port->cached_edid = drm_edid_alloc(dm_mst_test_edid, sizeof(dm_mst_test_edid));
+	KUNIT_ASSERT_NOT_NULL(test, child.port->cached_edid);
+
+	sink = dm_mst_test_alloc_sink(test);
+	dm_mst_test_next_remote_sink = sink;
+
+	KUNIT_EXPECT_EQ(test, dm_dp_mst_get_modes(&child.aconnector->base), 0);
+
+	KUNIT_EXPECT_NOT_NULL(test, child.aconnector->drm_edid);
+	KUNIT_EXPECT_EQ(test, child.aconnector->mst_status & MST_REMOTE_EDID, (int)MST_REMOTE_EDID);
+	KUNIT_EXPECT_PTR_EQ(test, child.aconnector->dc_sink, sink);
+
+	dc_sink_release(sink);
+	dm_mst_test_fini_child(&child);
+}
+
 /*
  * Sideband connector with a live topology manager and the DOWN_REP ready bit
  * armed, so dm_handle_mst_sideband_msg_ready_event() reaches its ack path.
@@ -1707,6 +1863,10 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_get_modes_no_edid_adds_default_sink),
 	KUNIT_CASE(dm_mst_test_get_modes_no_edid_sink_alloc_fails),
 	KUNIT_CASE(dm_mst_test_get_modes_no_edid_keeps_existing_sink),
+	KUNIT_CASE(dm_mst_test_get_modes_cached_edid_replaces_virtual_sink),
+	KUNIT_CASE(dm_mst_test_get_modes_cached_edid_sink_alloc_fails),
+	KUNIT_CASE(dm_mst_test_get_modes_restores_hdcp_properties),
+	KUNIT_CASE(dm_mst_test_get_modes_reads_remote_edid),
 	/* CONFIG_DRM_AMD_DC_FP disabled public paths */
 #if !defined(CONFIG_DRM_AMD_DC_FP)
 	KUNIT_CASE(dm_mst_test_fp_guarded_public_stubs),
-- 
2.43.0

