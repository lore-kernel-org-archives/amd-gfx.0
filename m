Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F29C5DF9F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDE3410ECE4;
	Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qxvo8Xsj";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E75F10ECA9
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRzodx4SpYk4FxQiq0gj+KGmCL/PqwA/DyPWe+B/5Hn8nsXdCHHFExQGvwEmhHd+C8PVDxrzyWwzP5+Onfl66xfyoklx10zfCce0u5QJQwWVOwXnLSCflNRDTNcnZoDAraY4sFctiy3ysB6/nGiHewQRS+tfWptS1NJljbOZKC6y26bBAJAWacLBUcYOXr5ITRlT4TFnEjHAtVQnozf0zlLf53PQHOpLEhLL2Bv5mPo8wKO962wleMpJUcCD7cgzVz1jNV3X4ImOtAnRVPEe2X+rXX7SG9l2tbeta3eDFK58HNrIdL/Ewn51DfrPI9NUY0c9eQ06pe3JyvfCLh0cIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqrjUKwlLV6bq9Lmg1pFvD2nW8KlULKBNtSXl27Oe5c=;
 b=NtP2jZtKwayfuixKF4uhEEJTIT7xOc2IMaGJnHu3FRwXU3m7sb0ZLNp63WFhPOthGKXHSr/hPD5tcL1CCME0Vd1QyKynFczugDEm/ZmPykXx+l9hmfsFL0uzYalDOnfXtHsitkixF2yD316FYa3asb99usktlftb6vg6o6nIylhtOH4+GiSYAel7jMlzH6JluwZ5/0p1bDM7CVntb7WQgqzN4Ap795yp9WBGtF4e5K0CMR7SCMTcm4JRDS2g3inKAx3GGIfRLFf56i8KP6yyVFIj+f/m4k8IaSGxUbDZMycGD4AyWbpndAnRnlembWhSdjNPCmDbqTeClQDk4eaRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqrjUKwlLV6bq9Lmg1pFvD2nW8KlULKBNtSXl27Oe5c=;
 b=qxvo8Xsjeafk0PMB+X16xyKvVNh2NMBWJ4tXJ3H8PY6jWCwauwhnFnhD/bl+j2p1zJ3B5Ct3unq42cTnNQHdeOSc+jnEEIVQtKRXVvmDSd0YI81b4Ymz5osQ5Ge5+wnfzhGM2jO4h5HS3/5lR8SElP/TiBpTku96dMjHU+wk5gs=
Received: from CH5P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::25)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:30 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::63) by CH5P222CA0009.outlook.office365.com
 (2603:10b6:610:1ee::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:26 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:21 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:20 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 38/82] drm/amd/display: Test MST sideband message ack path
Date: Tue, 18 Aug 2026 16:15:30 -0400
Message-ID: <20260818202139.4172592-39-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: cdae3fc1-ad2b-48ce-e6eb-08defd666bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ck4fylI/FadtU5IOnfLHFetBxffeF6DQOmrLdxpsuWJIUc/9aQ0GZfwRyIq/JdfnGU30OqH7F6e6swE/woFEi17K8wt9riA0VtSTyzRxbHCWkBygxEk5fLhMC2MgzdgVT9V5BLj3dP0sNa7xnpmT//C3EDvLI1shtyJyAwR5S9NZ4ehYCK4/seToT9d67iMYCbUM0hL/ujmyjfCWMzQT0uWVwt5RBRBomVJLJgRvzk5i/ayITcxmzukIni6bJRiPwZcAGXoTjBGdGiy3D7OOZVa06p/WGe18nlxl8XM3DNTm2x4UfS7AzqASD/BdXteBmlxMUMQK27SxcpG7lv/lr8TNRfzNoeXK9luw7UbXhoj31oTB/qlVojkeqk1Pt37+bG1OUAGFdTJmlkxjl9Zw2R404JK3lFOQk2+YGyHTW+/uZ8d8fwEE+mp2XlYT9aOlaqoXiJxxwO5uNXyDaNKnGedKYxhRm4zpcEsMFM16GYWipw0IjqxrjSkM153UNDOIQcPJUEwRy6CSpTKcuCTTbgYdiG4J3s4CNDykEqASpphOdTNR2nOK8GJfKYxOmu0nl/xeJhxiHymqs/1GScnkDwIFXd1DVrsJ00C/Vv10PHwI8B38UWt3zr6/uIaNZn6VA3isNHq8sNQuA2w4RHnu0cyyxIeA85FHBi97LELlx+wmOjVcX9qHdv5d5fun0uvYiSsuEX68CqCaeraCSC1qhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gYKZmmZHb+atFoZp3TebDqq6Ej+iBc/5zFzY0KFez1HjdyFaG3dYgm/F1cmPdO+3wD5F99rbLDMzUgPtdeKiidA93w+Q4nEtBys7SL3/4jFn5Feq2+pzp91sP7LlBb6hsTffcw3yNZtxc74D2G+P3LrbWmk04Cz8e00TQh4HOP+R5XT8xr3PFto0wWJqjFIcEcaS0i3u+qvVLEYLJwg1LRqNXBE0ZfbquD4e6njQ1q/p28JIleNqhaaXbgvYVE+mHQxeKY0bOydF3sCPvt7UO0wfqPUCPqej6I3IKYN+6KuRHa5dx+ihUC2n9C+1ttlLlI72dqxJNndeJD4M293YiAPhwGMZPkAQVqka3w0RkIozOkJl8I5SZPyPcSaYN+LofRgp9Rm2g63L1nbwwdGfkwhm4ywAfvfRZlWwfavaj8fPPVf/JjjtZNDcWWxvEXTj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:26.8997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdae3fc1-ad2b-48ce-e6eb-08defd666bbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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
Add KUnit tests for dm_handle_mst_sideband_msg_ready_event() covering the
DOWN_REP ready bit that is acknowledged at DPCD and re-polled until the
iteration limit, and the case where the acknowledge write keeps failing
and the handler gives up after the third retry.

[HOW]
A live topology manager is needed for the handler to reach its ack path,
so the tests initialise one on a DRM device and arm the DOWN_REP ready
bit in the fake DPCD. The fake AUX channel gains a separate write result
so the ESI read still succeeds while the acknowledge write fails.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_mst_types_test.c          | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index caedad4197bd9..6a5191f9baf61 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -38,6 +38,7 @@ static int dm_mst_test_aux_transfer_raw_result;
 static u8 dm_mst_test_aux_transfer_raw_reply;
 static enum aux_return_code_type dm_mst_test_aux_transfer_raw_operation_result;
 static ssize_t dm_mst_test_aux_transfer_override;
+static ssize_t dm_mst_test_aux_write_override;
 
 static int dm_mst_test_aux_transfer_raw(struct ddc_service *ddc,
 						struct aux_payload *payload,
@@ -109,6 +110,8 @@ static ssize_t dm_mst_test_aux_transfer(struct drm_dp_aux *aux,
 		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
 		return msg->size;
 	case DP_AUX_NATIVE_WRITE:
+		if (dm_mst_test_aux_write_override)
+			return dm_mst_test_aux_write_override;
 		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
 		return msg->size;
 	default:
@@ -146,6 +149,7 @@ static struct amdgpu_dm_connector *dm_mst_test_alloc_sideband_connector(struct k
 
 	memset(dm_mst_test_dpcd, 0, sizeof(dm_mst_test_dpcd));
 	dm_mst_test_aux_transfer_override = 0;
+	dm_mst_test_aux_write_override = 0;
 
 	return aconnector;
 }
@@ -1339,6 +1343,80 @@ static void dm_mst_test_detect_unregistered(struct kunit *test)
 			(int)connector_status_disconnected);
 }
 
+/*
+ * Sideband connector with a live topology manager and the DOWN_REP ready bit
+ * armed, so dm_handle_mst_sideband_msg_ready_event() reaches its ack path.
+ */
+static struct amdgpu_dm_connector *
+dm_mst_test_alloc_armed_sideband_connector(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	ret = drmm_mode_config_init(&adev->ddev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	aconnector = dm_mst_test_alloc_sideband_connector(test);
+
+	ret = drm_dp_mst_topology_mgr_init(&aconnector->mst_mgr, &adev->ddev,
+					   &aconnector->dm_dp_aux.aux, 16, 4, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	aconnector->mst_mgr.mst_state = true;
+	dm_mst_test_dpcd[(DP_SINK_COUNT_ESI + 1) & 0xf] = DP_DOWN_REP_MSG_RDY;
+
+	return aconnector;
+}
+
+static void dm_mst_test_free_armed_sideband_connector(struct amdgpu_dm_connector *aconnector)
+{
+	aconnector->mst_mgr.mst_state = false;
+	drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
+}
+
+/**
+ * dm_mst_test_sideband_msg_ready_acks_down_rep - Test DOWN_REP ack handling
+ * @test: KUnit test context
+ *
+ * With an active topology manager and the DOWN_REP ready bit set, the sideband
+ * handler must acknowledge the event at DPCD and keep polling until the
+ * iteration limit is reached, since the fake sideband message never completes.
+ */
+static void dm_mst_test_sideband_msg_ready_acks_down_rep(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_mst_test_alloc_armed_sideband_connector(test);
+
+	dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr, DOWN_REP_MSG_RDY_EVENT);
+
+	KUNIT_EXPECT_EQ(test, aconnector->mst_mgr.sink_count, 0);
+
+	dm_mst_test_free_armed_sideband_connector(aconnector);
+}
+
+/**
+ * dm_mst_test_sideband_msg_ready_ack_write_fails - Test failed DPCD ack
+ * @test: KUnit test context
+ *
+ * When the DPCD acknowledge write keeps failing, the sideband handler must give
+ * up after the third retry instead of looping forever.
+ */
+static void dm_mst_test_sideband_msg_ready_ack_write_fails(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_mst_test_alloc_armed_sideband_connector(test);
+	dm_mst_test_aux_write_override = -EIO;
+
+	dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr, DOWN_REP_MSG_RDY_EVENT);
+
+	KUNIT_EXPECT_EQ(test, aconnector->mst_mgr.sink_count, 0);
+
+	dm_mst_test_free_armed_sideband_connector(aconnector);
+}
+
 #if !defined(CONFIG_DRM_AMD_DC_FP)
 /**
  * dm_mst_test_fp_guarded_public_stubs - Test FP-off public fallbacks
@@ -1399,6 +1477,8 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_sideband_msg_ready_no_ready_bits),
 	KUNIT_CASE(dm_mst_test_sideband_msg_ready_read_error),
 	KUNIT_CASE(dm_mst_test_sideband_msg_ready_without_mst_state),
+	KUNIT_CASE(dm_mst_test_sideband_msg_ready_acks_down_rep),
+	KUNIT_CASE(dm_mst_test_sideband_msg_ready_ack_write_fails),
 	KUNIT_CASE(dm_mst_test_down_rep_msg_ready_wrapper),
 	/* amdgpu_dm_initialize_dp_connector tests */
 	KUNIT_CASE(dm_mst_test_initialize_dp_connector_edp),
-- 
2.43.0

