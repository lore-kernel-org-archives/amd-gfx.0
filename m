Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19422C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:26:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840FC10EE50;
	Wed, 26 Aug 2026 23:26:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J9QjKDTL";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5051A10EE50
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:26:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2cglnqSA3SHCRijMILmsnx3oGx7xn+tHu+kD2FWTg5vmOg0hPALAN8OQjwxZ4S25LSqonp5a8El2mVU6FoZrUxTqSCcWucRsFV/pahXkW3VqRj2YfAQosvUP7Jr36xWEZ35gnbg948OoyxzZIFav3XOOyO2AhgqDeJvc8dV4ZH5HnGkGQ40OJcmIiCHaVJF5Br8EMpfWrzJGsiNqCpXo/uDtnRjBUrG248RP/sw0Bkin6Y+FpKVoJhU31Y06hUuOoow8gXGiXQu/QqihH5cKTwdodSLnazJ6S74o24jOWtFN3WNvOBFcGnQcnSlUfesfUV5NLfjdH3iruIFYml6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TceCrwFC7wqWtXLHJwysN7lCM1gcCieUU/QZJGQQiA=;
 b=XfSV9Dc+dYpfAXBiMNZTcl6XiyK1QLZsG0CwAa2bJ2J+gCkCXN4FxuEb/wJjVyrHKY87ltfl+IM3jsmpFSlMcYemd5nK1rR6ISINAYQ6rxTx79pPG4pq1lNTJfdkBgoktEwZtSphb0XgYhUri3mbJ6kFHAMfJWf9IKmwSenHnIRBRb1E7yT32Q5Um4ysv/6M7pCc0lCyfThVvydvQ3Ry/otbDBygj19W0PZxnvsX/ZbapgLqCQtNoD/PLwbMUUyTJ6YEhfEXKEbcDgD5qOAImmR3lhOVIJojU6NxkXc6ddOMwIjMO4Xo+okrkKGocuVwX0K9K8iI9IEcTvXv1wNUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TceCrwFC7wqWtXLHJwysN7lCM1gcCieUU/QZJGQQiA=;
 b=J9QjKDTLec1AFccsU523HAFCBdiwmH1kOwFCjyNR+oumr1Dg4YTRD6IcMPXyAtPlePxyQLSdDjI6ro+QGogHvzDbIIvm/S2atq0XZ5fhg4SR2cEgQTZ5OF6OtkD30iPQSw2XgnNXSv6veUaGo+KDrvTAh3lM+oMR+LZSLHp80Yk=
Received: from SA9PR13CA0091.namprd13.prod.outlook.com (2603:10b6:806:24::6)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:26:13 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::31) by SA9PR13CA0091.outlook.office365.com
 (2603:10b6:806:24::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Wed, 26
 Aug 2026 23:26:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:26:13 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:26:05 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 31/59] drm/amd/display: Test affected MST DSC CRTC selection
Date: Wed, 26 Aug 2026 17:05:02 -0600
Message-ID: <20260826231519.881949-32-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: ca4373e5-4609-48d0-f1d8-08df03c96b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|5023799004|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HozU0hP68syfegwyx60hGpzjiXRWPqEYWCWA1aikLwgM8H1Ti1J/f2m0nVGwWbhZeOSUHAPDGRQ1jaJWJlYpELmgL19ditfsjiq9Xrn73rpmu8mYoZ0WDZ7mQNvVJg3yBu+1lRg/fQxS70XpRpuXy6QZygT+lRYf7sjgQGR07bGnONJ+M0vE32WsBlBNfzlAv2uuyXuRqhiRRqdHIv87g2kWI5HssaC/OKHRmKnqpHAK0aVOWwhzHHPNGrnYZlF5n43b7MGEVeikDVhSJeY3GHLi3bNFutbHL96Iq9F/qGRG6L8K5cDaamJr1g2ciXi/nqIHfuOaUR0p5EKJwJ6r3GUyylJJf4te2Xt3fxmR3F7eM/1hLvFraCaN39LMry0J+OMSKDhR6kGSzN0LE7zj1ddMGlnwRIz6XNPh7fpX0Mn2ddllSB5amMqYozfbFjCY+RaSCsfVhzl5Opl8hTV20nW7Cojmdx0ArfwUvBEES5l4E7UbTOeWjE7fyR+UqWd/BRFdQmQaHBglmprKXRiyl0QSNl7eQe55MnTgNQ3Ry1Xf+jr+83wZs3nFtrc8pZSlRciqSGaL9Tb2KN55D5T2RtcZTgktBlMkNZmK6NAmHFFu/lq+NyEbW0qg3/ld4XcTxB6A0Z/cqcUG2NQp/znK5iyClgqLy75F2mWPyWqk+CGI0AZY/DhMQcHUo7tCVSyEBFV8nWhE4A2KjyN0io375A==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(5023799004)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8a7dB6Us9D8n24E5BP6tNdKQjqvXcGy/dF7ziLtAJSXqhMf/tgeUj7is02TaxlEpX9ZhmaVbvwDYlZWbRnoRXE6LH/FKuSRTvm37Igk36cYwUbl6lVKpoHGD5rf4tFj9ORrifpCO5hfex3vAA5GVyhsSQMcAbtZjkBdN5VVfSHK9o/7f52SuO+2MArBMCm3VyMxnBu7v/nFV8lR2XKlJlyMmPm9I+VmNkYUjYkTFafiJdLSJCVewqP94iLObFItGbiVpBBrPtwr3SCULec8v6PVh/Bv5O1775lTlZR7giJ8hTX2+Ul07TPyJ70VaWItEPofaLadoSoAMKozpZteaAkLxYJfyAD5nsetvAvnDQg9zl5tlNMhanQkvcBLGYxy4xBRbQSQXYqJ6GOZfyuNGTrJmTjO/akqbo206JdPorVqZB4T2qTj4GnFy6QFASnuO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:26:13.0529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4373e5-4609-48d0-f1d8-08df03c96b2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
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

[WHAT]
Add KUnit tests for add_affected_mst_dsc_crtcs() covering an empty commit,
a writeback connector, a connector that is not behind an MST branch, a
connector bound to a different CRTC, and a disabled connector whose old
state decides which CRTC is affected.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 142 ++++++++++++++++++
 3 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5c4aac207e8f..9d233b18f2df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6007,7 +6007,8 @@ struct __drm_planes_state *amdgpu_dm_get_next_zpos(
 	return &state->planes[highest_i];
 }
 
-static int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state, struct drm_crtc *crtc)
+STATIC_IFN_KUNIT int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
+						struct drm_crtc *crtc)
 {
 	struct drm_connector *connector;
 	struct drm_connector_state *conn_state, *old_conn_state;
@@ -6036,6 +6037,7 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state, struct dr
 
 	return drm_dp_mst_add_affected_dsc_crtcs(state, &aconnector->mst_root->mst_mgr);
 }
+EXPORT_IF_KUNIT(add_affected_mst_dsc_crtcs);
 
 static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 					    struct drm_atomic_commit *state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 6e078be5bc5e..a48154ea62ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1171,6 +1171,8 @@ struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_commit *state)
 struct drm_private_state *dm_atomic_duplicate_state(struct drm_private_obj *obj);
 void dm_atomic_destroy_state(struct drm_private_obj *obj,
 			     struct drm_private_state *state);
+int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
+			       struct drm_crtc *crtc);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 				const enum surface_pixel_format format,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 66c35a22c45e..2afa73a07ebd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1282,6 +1282,142 @@ static void dm_test_atomic_duplicate_state_no_context(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, dm_atomic_duplicate_state(obj));
 }
 
+/* Tests for add_affected_mst_dsc_crtcs() */
+
+/**
+ * dm_test_add_affected_mst_dsc_crtcs_no_connector - Test an empty state adds nothing
+ * @test: The KUnit test context
+ */
+static void dm_test_add_affected_mst_dsc_crtcs_no_connector(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state = dm_test_alloc_commit(test, adev);
+	struct drm_crtc *crtc;
+
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	KUNIT_EXPECT_EQ(test, add_affected_mst_dsc_crtcs(state, crtc), 0);
+}
+
+/*
+ * Build an atomic state holding a single connector bound to @crtc.
+ */
+static struct drm_atomic_commit *
+dm_test_state_with_connector(struct kunit *test, struct drm_connector *connector,
+			     struct drm_crtc *crtc)
+{
+	struct drm_connector_state *conn_state;
+	struct drm_atomic_commit *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+
+	state->connectors = kunit_kzalloc(test, sizeof(*state->connectors),
+					  GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state->connectors);
+
+	conn_state->crtc = crtc;
+	state->num_connector = 1;
+	state->connectors[0].ptr = connector;
+	state->connectors[0].old_state = conn_state;
+	state->connectors[0].new_state = conn_state;
+
+	return state;
+}
+
+/**
+ * dm_test_add_affected_mst_dsc_crtcs_writeback - Test writeback connectors are ignored
+ * @test: The KUnit test context
+ */
+static void dm_test_add_affected_mst_dsc_crtcs_writeback(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_WRITEBACK;
+	state = dm_test_state_with_connector(test, &aconnector->base, crtc);
+
+	KUNIT_EXPECT_EQ(test, add_affected_mst_dsc_crtcs(state, crtc), 0);
+}
+
+/**
+ * dm_test_add_affected_mst_dsc_crtcs_not_mst - Test a non-MST connector adds nothing
+ * @test: The KUnit test context
+ */
+static void dm_test_add_affected_mst_dsc_crtcs_not_mst(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_DisplayPort;
+	state = dm_test_state_with_connector(test, &aconnector->base, crtc);
+
+	KUNIT_EXPECT_EQ(test, add_affected_mst_dsc_crtcs(state, crtc), 0);
+}
+
+/**
+ * dm_test_add_affected_mst_dsc_crtcs_other_crtc - Test connectors on other CRTCs are skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_add_affected_mst_dsc_crtcs_other_crtc(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc, *other_crtc;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	other_crtc = kunit_kzalloc(test, sizeof(*other_crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other_crtc);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_DisplayPort;
+	state = dm_test_state_with_connector(test, &aconnector->base, other_crtc);
+
+	KUNIT_EXPECT_EQ(test, add_affected_mst_dsc_crtcs(state, crtc), 0);
+}
+
+/**
+ * dm_test_add_affected_mst_dsc_crtcs_disabled - Test a disabled connector uses its old state
+ * @test: The KUnit test context
+ */
+static void dm_test_add_affected_mst_dsc_crtcs_disabled(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector_state *new_conn_state;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	new_conn_state = kunit_kzalloc(test, sizeof(*new_conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_conn_state);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_DisplayPort;
+	state = dm_test_state_with_connector(test, &aconnector->base, crtc);
+	state->connectors[0].new_state = new_conn_state;
+
+	KUNIT_EXPECT_EQ(test, add_affected_mst_dsc_crtcs(state, crtc), 0);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -1355,6 +1491,12 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	/* dm_atomic_get_state / dm_atomic_duplicate_state */
 	KUNIT_CASE(dm_test_atomic_get_state_already_acquired),
 	KUNIT_CASE(dm_test_atomic_duplicate_state_no_context),
+	/* add_affected_mst_dsc_crtcs */
+	KUNIT_CASE(dm_test_add_affected_mst_dsc_crtcs_no_connector),
+	KUNIT_CASE(dm_test_add_affected_mst_dsc_crtcs_writeback),
+	KUNIT_CASE(dm_test_add_affected_mst_dsc_crtcs_not_mst),
+	KUNIT_CASE(dm_test_add_affected_mst_dsc_crtcs_other_crtc),
+	KUNIT_CASE(dm_test_add_affected_mst_dsc_crtcs_disabled),
 	{}
 };
 
-- 
2.43.0

