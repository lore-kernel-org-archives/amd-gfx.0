Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ADFC5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D166E10EC9E;
	Tue, 18 Aug 2026 20:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dMRrN9hz";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013059.outbound.protection.outlook.com
 [40.107.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EAD610EC9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8qBIV3WFXoFEzgwL8GZO5POTMaA9tCWLOU3U+xOjQ7fdVdj/h+z6BE4165ZSu4GFpRRSYqSsdz0WrqeAGjqKAceKqR7kRhCminHZAQ0bdKYFa6wBwpqdjgKdP+ckpwEwTH5XgyceAANSSpU5mvIRXvlqXVST0XDKv9AREylVLtzKGqOtWi0s3+xstpObkXKGaCok8XxD+fcG37zgsqsVzxq/doiFZsvZ5LykSG8Yb8IpdNhwKtXfLAE/EkKTUUQOqqi9iwBuiuhztbcE0lz3zaNhU+D6+9Tt8pvXtPKSewzr0r2+DoWeNlFUguRDRu/utZL2y+QrZOSjAl9d27TnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P9R2mbdvALQi9H587yz36epUU5G++MQ9vrOltpcn+Q=;
 b=stJkaCtBxXKbELHIUZGUN3m6VgnK7LuCFgZ709tigq/16btFFIykEzmCUoz2KJnUc6phvES3U9IqMcess0CNtoaFWI3O1iyVXcaMVD7DTyBKPDnwbwusWMeHKsf6XVh/ovt97BI4Eh9xaD0KaWflWLGDyNnjbumPjPRzjYD2Ny/+jDmmjehWqhJ10epbPTdxSF7uW62v4gVHij8lKcFXUFroRXLg5QNwC0gTbtfKJBvsw7EV8D0EBFJIxcO3VvzVMNUkFEM0+1LA7TpxpeOk/rlcSs50b7z8GZkRWTHA+gSDjYmyCcylsUe9WmPhV9DZJ859iVSDR0pheINr3E+rOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P9R2mbdvALQi9H587yz36epUU5G++MQ9vrOltpcn+Q=;
 b=dMRrN9hzF3Ahgxtp/qa6Ahe5q3D0ikhIlT6MjPYtdNtMleYOYoydW+TgOyJiIUYVmhcbX/QdKUMBvwPs9flut53WbDQ7kszaJE/J5ODce9bPXmjJxxw7lgf/hHs35VWiWPbEevpENxNeQ6MlRS+5asONgfMN49C8GIz2sEWiLAU=
Received: from BN9PR03CA0883.namprd03.prod.outlook.com (2603:10b6:408:13c::18)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:23 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::a) by BN9PR03CA0883.outlook.office365.com
 (2603:10b6:408:13c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:11 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:10 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 24/82] drm/amd/display: Test dm_helpers_read_local_edid
Date: Tue, 18 Aug 2026 16:15:16 -0400
Message-ID: <20260818202139.4172592-25-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f22710-0079-4bb0-6fb4-08defd666968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|10067099003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: Mv5jcLUDzfQ4e+v57GEFt2t9Y10eB+3NN3TIVUTxamjhFjbNw7ByMMKE7CGQrLH5MO/FZo5Tt1H9tzL6s7A32mcRPXFfXAPgW7yNBbXW5fmAPAkWNZ2rXyIIC+EVnOVgiOWqFPnuJI6y8RdZCgLlAVl7WOMpCGW0z/8RI822P5aZN6qBtWqE+NycfY3k+ZmwzUO79haBPNeZleWUJPbE/twQeM4AWsoUw0qjKGkjO808pxLn+5g9CUj7+cAHe/vdCBwjWtDwIDK8ZV/5aE17+GH2QB60BO26ErfMPgxhjvQwkM7BoAVQeqLEWBRALhtjL9S7m/QVYbgYaIzOyzD7yyk5p6N5ucGrwNwhPXEu8CkBj7VBR5WzLd8EV2ibqZ/g5bPV6fd/2H+V5QH7cmgmxcVhdUqcM4xZzQlTOfnITaJCf4ckhCQa15RqNJo4wMs6pqgX5sthhK/ct4hUB9A58rs950jd+zH0wurU7r2iJRe7CFhzSsLfOiBo3Legxe1gWewrZlwStRUadhE96PJ+CONQj3y+DBm/DKi6T4TUghIXUZXPoMkfV5VrXYw5LKywhlQ0l47FEQ7D5eIzICOB0daxyTsHSXbFxwd43SY7LnnXELp884g5FhmNkLq6Bw9/5gySqtiw+2z9c/Un0rRJaGy43Vg8wpv5/1FJbgSKAL/SksbVyf0xmOvSNY6uL/QPY7HvzuOKqC8D/9AMNtB9qA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9SwQfks+DAc0rhLsgLSv2sAaka+pAECEV/qsdmCjyVa4V9Ku3IInHUfNh7h6Mm5ONlF8vTyBCT8TgLru5L6/8RpWrF4VbuPHijVz/Uu4/trofF0eP4hts4QcKPqDNDyUW6GbG8Sz7u40Jzjwf3Cl873hZPjWNYOR6k8KfP0CLRNG7PjPAShi6M8sahJ5fv5uIFIrIqJA1hclZ4pMc76ONYhIEM1+5QZW9fCG8ry7XRGo0YNpZMibgG8qTwphF0Ctdlrq5/VyY3xwLjdX/ZyDZ6taMHLZC0ZzhnnaXcbQ1QVEt0iq03djG0e4kV3Savf+Uy6gcw+VjsgEYSjbTGccjk82394qRv+UDi6DA+AzPDD7TM5h4E2QMYy2GqEfROcwZhrf0c660ynXdZo1AK1CMPeOCQBjg9orKNEAyQoTACawrDBo6exqNspzbIbTvJne
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:22.9677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f22710-0079-4bb0-6fb4-08defd666968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
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
Add KUnit tests for dm_helpers_read_local_edid() covering the AUX read
that returns a valid EDID, the compliance test request that acknowledges
the EDID checksum, and the I2C path where no sink responds.

[HOW]
The helper publishes the EDID through drm_edid_connector_update(), which
needs a fully initialised connector, so the tests build a real one. A
fake AUX channel serves the EDID and answers the native DPCD reads, and
a fake I2C algorithm always reports no response.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 231 ++++++++++++++++++
 2 files changed, 233 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 7c7783aa40745..ab15ceec4daa0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1350,6 +1350,8 @@ enum dc_edid_status dm_helpers_read_local_edid(
 
 	return edid_status;
 }
+EXPORT_IF_KUNIT(dm_helpers_read_local_edid);
+
 int dm_helper_dmub_aux_transfer_sync(
 		struct dc_context *ctx,
 		const struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index b0733961545dc..3531d52da1591 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -6,8 +6,10 @@
  */
 
 #include <kunit/test.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/drm_managed.h>
 #include <drm/display/drm_dp_mst_helper.h>
 
 #include "dc.h"
@@ -19,6 +21,7 @@
 #include "amdgpu_dm_mst_types.h"
 #include "dc_bios_types.h"
 #include "dm_helpers.h"
+#include "dpcd_defs.h"
 #include "ddc_service_types.h"
 #include "dmub/dmub_srv.h"
 #include "dmub_cmd.h"
@@ -4087,6 +4090,230 @@ static void dm_test_is_dp_sink_present_queries_link_service(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, dm_helpers_is_dp_sink_present(link));
 }
 
+/* Tests for dm_helpers_read_local_edid() */
+
+/*
+ * dm_helpers_read_local_edid() feeds the EDID it reads into
+ * drm_edid_connector_update(), which needs a fully initialised connector so the
+ * EDID property blob is published. dm_kunit_alloc_connector() only fills in the
+ * device pointer, so build a real one here.
+ */
+static const struct drm_connector_funcs dm_test_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+};
+
+static struct amdgpu_dm_connector *dm_test_alloc_real_connector(struct kunit *test,
+								struct amdgpu_device *adev)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	KUNIT_ASSERT_EQ(test, drmm_mode_config_init(&adev->ddev), 0);
+
+	aconnector = drmm_kzalloc(&adev->ddev, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	KUNIT_ASSERT_EQ(test,
+			drmm_connector_init(&adev->ddev, &aconnector->base,
+					    &dm_test_connector_funcs,
+					    DRM_MODE_CONNECTOR_DisplayPort, NULL),
+			0);
+
+	return aconnector;
+}
+
+/*
+ * Fake AUX channel that serves an EDID over I2C-over-AUX and answers the
+ * native DPCD reads the compliance test-request path makes.
+ */
+struct dm_test_edid_aux {
+	u8 edid[EDID_LENGTH];
+	u8 offset;
+	u8 test_request;
+	u8 checksum_written;
+	u8 response_written;
+};
+
+static struct dm_test_edid_aux *dm_test_current_edid_aux;
+
+static ssize_t dm_test_edid_aux_transfer(struct drm_dp_aux *aux,
+					 struct drm_dp_aux_msg *msg)
+{
+	struct dm_test_edid_aux *fixture = dm_test_current_edid_aux;
+	u8 *buffer = msg->buffer;
+	size_t len;
+
+	switch (msg->request & ~DP_AUX_I2C_MOT) {
+	case DP_AUX_I2C_WRITE:
+		if (msg->size >= 1)
+			fixture->offset = buffer[0];
+		msg->reply = DP_AUX_I2C_REPLY_ACK;
+		return msg->size;
+	case DP_AUX_I2C_READ:
+		len = min_t(size_t, msg->size, EDID_LENGTH - fixture->offset);
+		memcpy(buffer, fixture->edid + fixture->offset, len);
+		fixture->offset += len;
+		msg->reply = DP_AUX_I2C_REPLY_ACK;
+		return len;
+	case DP_AUX_NATIVE_READ:
+		memset(buffer, 0, msg->size);
+		if (msg->address == DP_TEST_REQUEST && msg->size)
+			buffer[0] = fixture->test_request;
+		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+		return msg->size;
+	case DP_AUX_NATIVE_WRITE:
+		if (msg->size) {
+			if (msg->address == DP_TEST_EDID_CHECKSUM)
+				fixture->checksum_written = buffer[0];
+			else if (msg->address == DP_TEST_RESPONSE)
+				fixture->response_written = buffer[0];
+		}
+		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+		return msg->size;
+	}
+
+	msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+	return msg->size;
+}
+
+/* Fake I2C DDC adapter and prepare_ddc hook for the non-AUX EDID read path. */
+
+static int dm_test_ddc_no_sink_xfer(struct i2c_adapter *adapter,
+				    struct i2c_msg *msgs, int num)
+{
+	return -ENXIO;
+}
+
+static const struct i2c_algorithm dm_test_ddc_algorithm = {
+	.master_xfer = dm_test_ddc_no_sink_xfer,
+};
+
+static unsigned int dm_test_prepare_ddc_calls;
+
+static void dm_test_prepare_ddc(struct dc_link *link)
+{
+	dm_test_prepare_ddc_calls++;
+}
+
+struct dm_test_local_edid {
+	struct dm_test_edid_aux *aux;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc_sink *sink;
+	struct dc *dc;
+};
+
+static struct dm_test_local_edid dm_test_setup_local_edid(struct kunit *test)
+{
+	struct dm_test_local_edid fixture = {0};
+	struct amdgpu_device *adev;
+	struct dc_edid *dc_edid;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	fixture.aconnector = dm_test_alloc_real_connector(test, adev);
+	fixture.aux = kunit_kzalloc(test, sizeof(*fixture.aux), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.aux);
+	fixture.ctx = kunit_kzalloc(test, sizeof(*fixture.ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.ctx);
+	fixture.sink = kunit_kzalloc(test, sizeof(*fixture.sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.sink);
+	fixture.dc = kunit_kzalloc(test, sizeof(*fixture.dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fixture.dc);
+	fixture.link = dm_kunit_alloc_link(test);
+	dc_edid = kunit_kzalloc(test, sizeof(*dc_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_edid);
+
+	dm_test_fill_base_edid(dc_edid, true);
+	memcpy(fixture.aux->edid, dc_edid->raw_edid, EDID_LENGTH);
+	dm_test_current_edid_aux = fixture.aux;
+
+	fixture.aconnector->dm_dp_aux.aux.drm_dev = &adev->ddev;
+	fixture.aconnector->dm_dp_aux.aux.transfer = dm_test_edid_aux_transfer;
+	drm_dp_aux_init(&fixture.aconnector->dm_dp_aux.aux);
+
+	fixture.link->priv = fixture.aconnector;
+	fixture.link->dc = fixture.dc;
+	fixture.link->aux_mode = true;
+
+	return fixture;
+}
+
+/**
+ * dm_test_read_local_edid_aux_mode - Test reading EDID over the AUX DDC channel
+ * @test: The KUnit test context
+ *
+ * A DP link reads the EDID through the connector's AUX channel, copies it into
+ * the sink and parses the caps.
+ */
+static void dm_test_read_local_edid_aux_mode(struct kunit *test)
+{
+	struct dm_test_local_edid fixture = dm_test_setup_local_edid(test);
+
+	KUNIT_EXPECT_EQ(test,
+			dm_helpers_read_local_edid(fixture.ctx, fixture.link, fixture.sink),
+			EDID_OK);
+	KUNIT_EXPECT_EQ(test, fixture.sink->dc_edid.length, (uint32_t)EDID_LENGTH);
+	KUNIT_EXPECT_EQ(test, fixture.sink->edid_caps.manufacturer_id, 0xAC10);
+	KUNIT_EXPECT_EQ(test, fixture.sink->edid_caps.product_id, 0x1234);
+}
+
+/**
+ * dm_test_read_local_edid_test_request - Test the compliance EDID-read request
+ * @test: The KUnit test context
+ *
+ * When the sink raises the EDID_READ test request, the helper writes back the
+ * EDID checksum and the test response.
+ */
+static void dm_test_read_local_edid_test_request(struct kunit *test)
+{
+	struct dm_test_local_edid fixture = dm_test_setup_local_edid(test);
+	struct dm_test_edid_aux *aux = fixture.aux;
+	union test_response expected_response = {0};
+
+	aux->test_request = DP_TEST_LINK_EDID_READ;
+	expected_response.bits.EDID_CHECKSUM_WRITE = 1;
+
+	KUNIT_EXPECT_EQ(test,
+			dm_helpers_read_local_edid(fixture.ctx, fixture.link, fixture.sink),
+			EDID_OK);
+	KUNIT_EXPECT_EQ(test, aux->checksum_written,
+			aux->edid[EDID_LENGTH - 1]);
+	KUNIT_EXPECT_EQ(test, aux->response_written, expected_response.raw);
+}
+
+/**
+ * dm_test_read_local_edid_i2c_no_response - Test the I2C DDC path with no sink
+ * @test: The KUnit test context
+ *
+ * A non-AUX link reads the EDID over the connector's I2C adapter. With no sink
+ * responding, every retry fails and the helper reports EDID_NO_RESPONSE.
+ */
+static void dm_test_read_local_edid_i2c_no_response(struct kunit *test)
+{
+	struct dm_test_local_edid fixture = dm_test_setup_local_edid(test);
+	struct i2c_adapter *ddc;
+
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
+	ddc->algo = &dm_test_ddc_algorithm;
+	ddc->lock_ops = &dm_test_i2c_lock_ops;
+	rt_mutex_init(&ddc->bus_lock);
+	rt_mutex_init(&ddc->mux_lock);
+
+	fixture.link->aux_mode = false;
+	fixture.link->ddc_hw_inst = 1;
+	fixture.aconnector->i2c = (struct amdgpu_i2c_adapter *)ddc;
+	fixture.dc->hwss.prepare_ddc = dm_test_prepare_ddc;
+	dm_test_prepare_ddc_calls = 0;
+
+	KUNIT_EXPECT_EQ(test,
+			dm_helpers_read_local_edid(fixture.ctx, fixture.link, fixture.sink),
+			EDID_NO_RESPONSE);
+	KUNIT_EXPECT_EQ(test, dm_test_prepare_ddc_calls, 1U);
+}
+
 static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* edid_extract_panel_id */
 	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
@@ -4283,6 +4510,10 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_dmub_set_config_sync_unknown_error),
 	/* dm_helpers_is_dp_sink_present */
 	KUNIT_CASE(dm_test_is_dp_sink_present_queries_link_service),
+	/* dm_helpers_read_local_edid */
+	KUNIT_CASE(dm_test_read_local_edid_aux_mode),
+	KUNIT_CASE(dm_test_read_local_edid_test_request),
+	KUNIT_CASE(dm_test_read_local_edid_i2c_no_response),
 	{}
 };
 
-- 
2.43.0

