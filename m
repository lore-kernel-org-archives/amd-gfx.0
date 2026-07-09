Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F521C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE70D10F6C9;
	Thu,  9 Jul 2026 21:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2pTjQ8UG";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012052.outbound.protection.outlook.com [40.107.209.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8B5D10F6D6
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tC9GAEuW1QZ5veB4aCNioo0dxDGqZHmymUgTJVPEODW3nmg47BXqtTS/8UAdowO3XlCX0YliT/1D6oZsjyyNoXUPPVxia5M8id3zJWwnxI5jKks3WXjl3UWDVZUKOCL/HcQl0mwHg1qc8whwDa0MrZS6valW5rkphYfwt4iuNf9aGyP5lH0mOCARmyajq+2NzTTKFOgS15Ajx5ddMgfOrln6xaP6evDYLRCC0kuq4QGulbc/GgpHvKJMrODmwoQtZigCmXRNkvsK2L2gNPym5Y/aVurVfsDza2Rm9P6IMClJK04SeSUIeDv8oEuLmoinRLeM0nQrXAQtPs4Nf/ADNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cghx3J6zHRW8M9SStMbSYvM7NIT539VIdDgxK2PkWOc=;
 b=xdPcz69FUnU02lK1QOXF9JdK46v7QWZ15B524OMhVA/7eQYr/XAhdFmsLHozuIuAtZrKhk5TP4TDOOwHARxfUaYQLKTPiM05j1m92sYdripDSMAsuBZg1nUunFG4M9wEL2/ANBhvsSdMm950VlTt3ZxUdCdikzxB2UFBT5fj7qjLyYue79NHHclZpTVcVGVSEXkck/tmdorAJQuC/cSMw7p3y9qAj6n+pirqDXUlFRj6rd4nZTrhpSAeQpXi+t0ykH8qf60YKZSzycL9PQZiKJ0MsKZEN00Lesm10g2nbe3oZV9ZyNc9MKhiEJY30Ig9NT0HeT034Tq1pj73j5+z3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cghx3J6zHRW8M9SStMbSYvM7NIT539VIdDgxK2PkWOc=;
 b=2pTjQ8UGhS0oYmupfjjyZ+2foK4ghW6nS2IGifc1GE/Y4glJtmiD/yT7SfE1EggrQiKmN1SMnQ0LPlxgBaA0/nApt1RG/m8xg5K4/7LiyG5aCgidVHwaixoGwssog2lJ07x5+CGHo2Qc4wKcVqawDOnejcB2d6ltBtzj7MlqE14=
Received: from MN0PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:52d::19)
 by LV3PR12MB9410.namprd12.prod.outlook.com (2603:10b6:408:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 21:02:19 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::75) by MN0PR04CA0020.outlook.office365.com
 (2603:10b6:208:52d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:18 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:58 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 29/80] drm/amd/display: Test MST payload and DSC enable helpers
Date: Thu, 9 Jul 2026 16:47:57 -0400
Message-ID: <20260709205936.5719-30-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|LV3PR12MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: 25832dcf-22a9-4142-c8c0-08deddfd5cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|3023799007|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: evFZfb10qp0erGE9D1GGKhL5GQnPItQR5JGefMUmLHnjGHKL9plM9aYOd1EBmJyKO7rBF5Z49pqoRO3XTSiJ7mSDwYVSwZ2fK95BTWi5QpNEn54I58MG2fR06UhSjU0dWc5Z6oDi5uto2aejb1FKjH0hu1fZzmcG6BPBtUl4m89lOmxqGqTtRLr58HGt8K29Y3Y5rqx7JITYtYjRLDUV+n+0ma+YlUDHYbll6wpqkKR7nxkxCMF2orOJOeAHIjJ3sICAFV7oqHHIlm55SVS6enRFlI3AQvCTAG0vpAH8flWFOs9IFw5oOGAmUjdjZRqEfrzw1hr4qELVXdP00EFHFS+4OnFC8pjHwJbMI571mhCcMbMEGuo88nxtFcjSeFZL7C2sfue9pXWzdEUTzGp5nWpU1JZdPFjoUZLPl+GZxRZ1CXVqzWyu9WVYnJqpyr7E9QcXQ9YZqobleamXRfhVR7rKBJxVbhBTxUJ0vsBc0V4gW5/m2G8FxeM7cqtQIKZvimvmunCJ9Nvq2oZkRO7her3nLagbH9VpYBCfKXEV1g4vKdGxZirduRelqJ0pSTwTFovLqj/prUK0syNkm2HgtCrnovqhyVDcRSpEa8b5fZFJ2xdor/dXAqofMZpYdR4leTv3clMwsnvRVUcH9zR0aTU7xStee8mpscSFUoMRAxQiKi5fd7Q5vVvlKbqrAgyr84ZOuGph8w2/FSPWxOHXig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(3023799007)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M+kNjanVYUHEWYhhuTwGEimzNT8JukwLL4wb/HI9ZwWLRUAokcl99ersEuY4pjkTRbaueAfGJNNUWHgPigmcAkxwMgq3v8bpSV7YZ2IpUW2PskYim5iicwHFrd+ZCHpz9/c1skY/RRysEHwi+wZYW4NbTAFpvYWhqcdpHyocGrA/I8N1RtBO4PT/sds7wzHnPkpg0ZLSuiJu0PdYM2syqMDnHa9fuG6YMoFPWgS85SxMUgVTRgdpkBSbNuIKVqv0WWkoQwBA1i1Dz8yRAGZAsyHSNwaxDncF0Imo8P6WOrsUDerWjnhPlbkMm37OzcRID4mbgIihDHHFuhsxeNbs9/NAAtWfxeA1aYKgLSJbN4ncnLHLRtUyy8UGq98mPn0C79I72CBXwF+AH6O/CCrNLfdvlMcpUbeRQpVDJpT72QxcR1rpQi8sZLU+/xARgZAa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:18.9366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25832dcf-22a9-4142-c8c0-08deddfd5cfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9410
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
Add KUnit coverage for dm_helpers_construct_old_payload, the DP MST
payload allocation, poll-for-ACT and deallocation success paths, the
full dm_helpers_dp_write_dsc_enable matrix and
dm_helpers_dp_handle_test_pattern_request.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.h |   4 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 806 ++++++++++++++++++
 3 files changed, 813 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 48ed6d8d9580..d177489a2684 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -298,7 +298,7 @@ void dm_helpers_dp_update_branch_info(
 {}
 EXPORT_IF_KUNIT(dm_helpers_dp_update_branch_info);

-static void dm_helpers_construct_old_payload(
+STATIC_IFN_KUNIT void dm_helpers_construct_old_payload(
 			struct drm_dp_mst_topology_mgr *mgr,
 			struct drm_dp_mst_topology_state *mst_state,
 			struct drm_dp_mst_atomic_payload *new_payload,
@@ -329,6 +329,7 @@ static void dm_helpers_construct_old_payload(
 	old_payload->time_slots = allocated_time_slots;
 	old_payload->pbn = allocated_time_slots * pbn_per_slot;
 }
+EXPORT_IF_KUNIT(dm_helpers_construct_old_payload);

 /*
  * Writes payload allocation table in immediate downstream device.
@@ -1588,6 +1589,7 @@ bool dm_helpers_dp_handle_test_pattern_request(

 	return false;
 }
+EXPORT_IF_KUNIT(dm_helpers_dp_handle_test_pattern_request);

 void dm_set_phyd32clk(struct dc_context *ctx, int freq_khz)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
index e256e1e12422..0eab820757c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.h
@@ -33,6 +33,10 @@ void fill_dc_mst_payload_table_from_drm(struct dc_link *link,
 					 bool enable,
 					 struct drm_dp_mst_atomic_payload *target_payload,
 					 struct dc_dp_mst_stream_allocation_table *table);
+void dm_helpers_construct_old_payload(struct drm_dp_mst_topology_mgr *mgr,
+				      struct drm_dp_mst_topology_state *mst_state,
+				      struct drm_dp_mst_atomic_payload *new_payload,
+				      struct drm_dp_mst_atomic_payload *old_payload);
 bool dm_helpers_dp_write_dsc_enable(struct dc_context *ctx,
 				    const struct dc_stream_state *stream,
 				    bool enable);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index bde697092032..058e1ad15dfe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -2936,6 +2936,784 @@ static void dm_test_mccs_vcp_set_i2c_failure(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fake->reads, 0U);
 }

+/* Tests for dm_helpers_construct_old_payload() */
+
+/**
+ * dm_test_construct_old_payload_empty_list - Test PBN/time-slot calc, empty list
+ * @test: The KUnit test context
+ *
+ * With no other payloads, next_payload_vc_start stays at mgr->next_start_slot,
+ * so allocated time_slots = next_start_slot - vc_start_slot.
+ */
+static void dm_test_construct_old_payload_empty_list(struct kunit *test)
+{
+	struct drm_dp_mst_topology_mgr *mgr;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_dp_mst_atomic_payload *new_payload;
+	struct drm_dp_mst_atomic_payload *old_payload;
+
+	mgr = kunit_kzalloc(test, sizeof(*mgr), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mgr);
+	mst_state = kunit_kzalloc(test, sizeof(*mst_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mst_state);
+	new_payload = kunit_kzalloc(test, sizeof(*new_payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_payload);
+	old_payload = kunit_kzalloc(test, sizeof(*old_payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_payload);
+
+	INIT_LIST_HEAD(&mst_state->payloads);
+	mgr->next_start_slot = 10;
+	mst_state->pbn_div.full = 5 << 12;	/* dfixed_trunc → 5 PBN/slot */
+	new_payload->vc_start_slot = 3;
+
+	dm_helpers_construct_old_payload(mgr, mst_state, new_payload,
+					 old_payload);
+
+	/* 10 - 3 = 7 slots, 7 * 5 = 35 PBN */
+	KUNIT_EXPECT_EQ(test, old_payload->time_slots, 7);
+	KUNIT_EXPECT_EQ(test, old_payload->pbn, 35);
+}
+
+/**
+ * dm_test_construct_old_payload_intervening - Test calc with an intervening payload
+ * @test: The KUnit test context
+ *
+ * A payload whose vc_start_slot falls between the new payload and the manager's
+ * next_start_slot narrows the allocated time-slot window.
+ */
+static void dm_test_construct_old_payload_intervening(struct kunit *test)
+{
+	struct drm_dp_mst_topology_mgr *mgr;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_dp_mst_atomic_payload *new_payload;
+	struct drm_dp_mst_atomic_payload *other_payload;
+	struct drm_dp_mst_atomic_payload *old_payload;
+
+	mgr = kunit_kzalloc(test, sizeof(*mgr), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mgr);
+	mst_state = kunit_kzalloc(test, sizeof(*mst_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mst_state);
+	new_payload = kunit_kzalloc(test, sizeof(*new_payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_payload);
+	other_payload = kunit_kzalloc(test, sizeof(*other_payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, other_payload);
+	old_payload = kunit_kzalloc(test, sizeof(*old_payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_payload);
+
+	INIT_LIST_HEAD(&mst_state->payloads);
+	mgr->next_start_slot = 10;
+	mst_state->pbn_div.full = 5 << 12;
+	new_payload->vc_start_slot = 3;
+
+	/* other payload at slot 6 (between 3 and 10) narrows window to 6 */
+	other_payload->vc_start_slot = 6;
+	list_add_tail(&other_payload->next, &mst_state->payloads);
+
+	dm_helpers_construct_old_payload(mgr, mst_state, new_payload,
+					 old_payload);
+
+	/* 6 - 3 = 3 slots, 3 * 5 = 15 PBN */
+	KUNIT_EXPECT_EQ(test, old_payload->time_slots, 3);
+	KUNIT_EXPECT_EQ(test, old_payload->pbn, 15);
+}
+
+/* Tests for dm_helpers_dp_mst_write_payload_allocation_table() success path */
+
+/**
+ * dm_test_write_payload_alloc_table_success - Exercise the MST success path
+ * @test: The KUnit test context
+ * @enable: true for the add-payload path, false for the remove-payload path
+ *
+ * Builds a minimal MST topology-state fixture so the helper traverses past the
+ * early NULL checks and runs the real DRM MST payload helpers
+ * (drm_dp_add_payload_part1 / drm_dp_remove_payload_part1). With
+ * mgr->mst_primary == NULL the topology walk fails gracefully, so no remote
+ * DPCD/AUX traffic is generated, and the helper still returns true.
+ */
+static void dm_test_write_payload_alloc_table_success(struct kunit *test,
+						      bool enable)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_topology_mgr *mgr;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_dp_mst_atomic_payload *payload;
+	struct drm_dp_mst_port *port;
+	struct dc_stream_state *stream;
+	struct dc_link *link;
+	struct dc_dp_mst_stream_allocation_table table = { 0 };
+	bool ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	mst_state = kunit_kzalloc(test, sizeof(*mst_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mst_state);
+	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, payload);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	/* aconnector acts as its own MST root for this fixture */
+	aconnector->mst_root = aconnector;
+	aconnector->mst_output_port = port;
+
+	mgr = &aconnector->mst_mgr;
+	mutex_init(&mgr->lock);
+	mgr->dev = &adev->ddev;
+	mgr->mst_primary = NULL;		/* topology walk fails gracefully */
+	mgr->base.state = &mst_state->base;
+
+	INIT_LIST_HEAD(&mst_state->payloads);
+	mst_state->pbn_div.full = 5 << 12;	/* dfixed_trunc → 5 PBN/slot */
+
+	/* payload found by drm_atomic_get_mst_payload_state via matching port */
+	payload->port = port;
+	payload->vcpi = 1;
+	payload->vc_start_slot = 1;
+	payload->time_slots = 2;
+	list_add_tail(&payload->next, &mst_state->payloads);
+
+	/* pre-existing HW allocation so the disable path finds a VCPI to clear */
+	link->mst_stream_alloc_table.stream_count = 1;
+	link->mst_stream_alloc_table.stream_allocations[0].vcp_id = 1;
+	link->mst_stream_alloc_table.stream_allocations[0].slot_count = 2;
+
+	stream->dm_stream_context = aconnector;
+	stream->link = link;
+
+	ret = dm_helpers_dp_mst_write_payload_allocation_table(NULL, stream,
+							       &table, enable);
+
+	KUNIT_EXPECT_TRUE(test, ret);
+
+	if (enable)
+		/* add path keeps the old entry and appends the new payload */
+		KUNIT_EXPECT_EQ(test, table.stream_count, 2);
+	else
+		/* remove path clears the only entry */
+		KUNIT_EXPECT_EQ(test, table.stream_count, 0);
+}
+
+/**
+ * dm_test_write_payload_alloc_table_enable - Test add-payload success path
+ * @test: The KUnit test context
+ */
+static void dm_test_write_payload_alloc_table_enable(struct kunit *test)
+{
+	dm_test_write_payload_alloc_table_success(test, true);
+}
+
+/**
+ * dm_test_write_payload_alloc_table_disable - Test remove-payload success path
+ * @test: The KUnit test context
+ */
+static void dm_test_write_payload_alloc_table_disable(struct kunit *test)
+{
+	dm_test_write_payload_alloc_table_success(test, false);
+}
+
+/* Tests for dm_helpers_dp_mst_poll_for_allocation_change_trigger() */
+
+/*
+ * Stub AUX transfer that ACKs a DPCD read of the payload-table update status
+ * with the ACT-handled bit set, so drm_dp_check_act_status() returns 0.
+ */
+static ssize_t dm_test_act_aux_transfer_handled(struct drm_dp_aux *aux,
+						struct drm_dp_aux_msg *msg)
+{
+	if ((msg->request & ~DP_AUX_I2C_MOT) == DP_AUX_NATIVE_READ) {
+		memset(msg->buffer, 0, msg->size);
+		if (msg->size > 0)
+			((u8 *)msg->buffer)[0] = DP_PAYLOAD_ACT_HANDLED;
+	}
+	msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+	return msg->size;
+}
+
+/*
+ * Stub AUX transfer that fails every transaction, so the ACT status read
+ * returns an error and drm_dp_check_act_status() returns non-zero.
+ */
+static ssize_t dm_test_act_aux_transfer_fail(struct drm_dp_aux *aux,
+					     struct drm_dp_aux_msg *msg)
+{
+	return -EIO;
+}
+
+/**
+ * dm_test_mst_start_top_mgr_set_mst_fail - Test MST start failure path
+ * @test: The KUnit test context
+ *
+ * With a connector-backed link and a failing AUX channel, the non-boot
+ * path calls drm_dp_mst_topology_mgr_set_mst(true), which fails to read the
+ * DPCD caps and returns a negative error, so the helper returns false.
+ */
+static void dm_test_mst_start_top_mgr_set_mst_fail(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_aux *aux;
+	struct dc_link *link;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	aux = kunit_kzalloc(test, sizeof(*aux), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aux);
+	link = dm_kunit_alloc_link(test);
+
+	aux->drm_dev = &adev->ddev;
+	aux->transfer = dm_test_act_aux_transfer_fail;
+	drm_dp_aux_init(aux);
+
+	mutex_init(&aconnector->mst_mgr.lock);
+	aconnector->mst_mgr.dev = &adev->ddev;
+	aconnector->mst_mgr.aux = aux;
+	link->priv = aconnector;
+
+	KUNIT_EXPECT_FALSE(test, dm_helpers_dp_mst_start_top_mgr(NULL, link, false));
+}
+
+/**
+ * dm_test_mst_stop_top_mgr_active - Test MST stop on an active topology manager
+ * @test: The KUnit test context
+ *
+ * With mst_state set, the helper calls drm_dp_mst_topology_mgr_set_mst(false)
+ * to disable MST and clears the link lane count. The helper always returns
+ * false.
+ */
+static void dm_test_mst_stop_top_mgr_active(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_aux *aux;
+	struct dc_link *link;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	aux = kunit_kzalloc(test, sizeof(*aux), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aux);
+	link = dm_kunit_alloc_link(test);
+
+	aux->drm_dev = &adev->ddev;
+	aux->transfer = dm_test_act_aux_transfer_handled;
+	drm_dp_aux_init(aux);
+
+	mutex_init(&aconnector->mst_mgr.lock);
+	aconnector->mst_mgr.dev = &adev->ddev;
+	aconnector->mst_mgr.aux = aux;
+	aconnector->mst_mgr.mst_state = true;
+	link->cur_link_settings.lane_count = 4;
+	link->priv = aconnector;
+
+	KUNIT_EXPECT_FALSE(test, dm_helpers_dp_mst_stop_top_mgr(NULL, link));
+	KUNIT_EXPECT_EQ(test, link->cur_link_settings.lane_count, 0);
+}
+
+/**
+ * dm_test_poll_for_act_no_mst_state - Test ACT poll bails when MST not started
+ * @test: The KUnit test context
+ *
+ * With mst_root set but mst_mgr->mst_state false, the helper returns
+ * ACT_FAILED before touching the AUX channel.
+ */
+static void dm_test_poll_for_act_no_mst_state(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_stream_state *stream;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	aconnector->mst_root = aconnector;
+	aconnector->mst_mgr.mst_state = false;
+	stream->dm_stream_context = aconnector;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)dm_helpers_dp_mst_poll_for_allocation_change_trigger(NULL, stream),
+			(int)ACT_FAILED);
+}
+
+/**
+ * dm_test_poll_for_act_success - Test ACT poll success path
+ * @test: The KUnit test context
+ *
+ * With MST started and the AUX channel reporting ACT handled,
+ * drm_dp_check_act_status() returns 0 and the helper returns ACT_SUCCESS.
+ */
+static void dm_test_poll_for_act_success(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_aux *aux;
+	struct dc_stream_state *stream;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	aux = kunit_kzalloc(test, sizeof(*aux), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aux);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	aux->drm_dev = &adev->ddev;
+	aux->transfer = dm_test_act_aux_transfer_handled;
+	drm_dp_aux_init(aux);
+
+	aconnector->mst_root = aconnector;
+	aconnector->mst_mgr.mst_state = true;
+	aconnector->mst_mgr.aux = aux;
+	stream->dm_stream_context = aconnector;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)dm_helpers_dp_mst_poll_for_allocation_change_trigger(NULL, stream),
+			(int)ACT_SUCCESS);
+}
+
+/**
+ * dm_test_poll_for_act_status_failed - Test ACT poll failure path
+ * @test: The KUnit test context
+ *
+ * With MST started but the AUX channel failing, drm_dp_check_act_status()
+ * returns non-zero and the helper returns ACT_FAILED.
+ */
+static void dm_test_poll_for_act_status_failed(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_aux *aux;
+	struct dc_stream_state *stream;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	aux = kunit_kzalloc(test, sizeof(*aux), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aux);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	aux->drm_dev = &adev->ddev;
+	aux->transfer = dm_test_act_aux_transfer_fail;
+	drm_dp_aux_init(aux);
+
+	aconnector->mst_root = aconnector;
+	aconnector->mst_mgr.mst_state = true;
+	aconnector->mst_mgr.aux = aux;
+	stream->dm_stream_context = aconnector;
+
+	KUNIT_EXPECT_EQ(test,
+			(int)dm_helpers_dp_mst_poll_for_allocation_change_trigger(NULL, stream),
+			(int)ACT_FAILED);
+}
+
+/* Tests for dm_helpers_dp_mst_send_payload_allocation() */
+
+/**
+ * dm_test_mst_send_payload_alloc_part2_fail - Exercise the failure branch
+ * @test: The KUnit test context
+ *
+ * Builds a minimal MST topology-state fixture so the helper runs past the early
+ * NULL checks and calls drm_dp_add_payload_part2(). The payload's allocation
+ * status is left at its default (not DRM_DP_MST_PAYLOAD_ALLOCATION_DFP), so
+ * drm_dp_add_payload_part2() returns -EIO without any remote DPCD/AUX traffic.
+ * The non-zero return drives the failure branch, which clears the
+ * MST_ALLOCATE_NEW_PAYLOAD status bit.
+ */
+static void dm_test_mst_send_payload_alloc_part2_fail(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_topology_mgr *mgr;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_dp_mst_atomic_payload *payload;
+	struct drm_dp_mst_port *port;
+	struct dc_stream_state *stream;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	mst_state = kunit_kzalloc(test, sizeof(*mst_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mst_state);
+	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, payload);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	/* aconnector acts as its own MST root for this fixture */
+	aconnector->mst_root = aconnector;
+	aconnector->mst_output_port = port;
+	/* drm_dp_add_payload_part2() logs port->connector->name on failure */
+	port->connector = &aconnector->base;
+
+	mgr = &aconnector->mst_mgr;
+	mgr->dev = &adev->ddev;
+	mgr->base.state = &mst_state->base;
+
+	INIT_LIST_HEAD(&mst_state->payloads);
+
+	/* payload found by drm_atomic_get_mst_payload_state via matching port */
+	payload->port = port;
+	list_add_tail(&payload->next, &mst_state->payloads);
+
+	/* pre-set the bit so we can observe it being cleared on failure */
+	aconnector->mst_status = MST_ALLOCATE_NEW_PAYLOAD;
+
+	stream->dm_stream_context = aconnector;
+	dm_helpers_dp_mst_send_payload_allocation(NULL, stream);
+
+	KUNIT_EXPECT_EQ(test,
+			aconnector->mst_status & MST_ALLOCATE_NEW_PAYLOAD, 0);
+}
+
+/* Tests for dm_helpers_dp_mst_update_mst_mgr_for_deallocation() */
+
+/**
+ * dm_test_mst_update_mgr_dealloc_success - Exercise the deallocation path
+ * @test: The KUnit test context
+ *
+ * Builds a minimal MST topology-state fixture so the helper runs past the early
+ * NULL checks through dm_helpers_construct_old_payload() and
+ * drm_dp_remove_payload_part2(), both of which are pure list/slot math with no
+ * remote DPCD/AUX traffic. Afterwards MST_CLEAR_ALLOCATED_PAYLOAD must be set,
+ * MST_ALLOCATE_NEW_PAYLOAD cleared, and the payload's slot released.
+ */
+static void dm_test_mst_update_mgr_dealloc_success(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_topology_mgr *mgr;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_dp_mst_atomic_payload *payload;
+	struct drm_dp_mst_port *port;
+	struct dc_stream_state *stream;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	mst_state = kunit_kzalloc(test, sizeof(*mst_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mst_state);
+	payload = kunit_kzalloc(test, sizeof(*payload), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, payload);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	/* aconnector acts as its own MST root for this fixture */
+	aconnector->mst_root = aconnector;
+	aconnector->mst_output_port = port;
+
+	mgr = &aconnector->mst_mgr;
+	mgr->base.state = &mst_state->base;
+	mgr->next_start_slot = 10;
+	mgr->payload_count = 1;
+
+	INIT_LIST_HEAD(&mst_state->payloads);
+	mst_state->pbn_div.full = 5 << 12;	/* dfixed_trunc → 5 PBN/slot */
+
+	/* payload found by drm_atomic_get_mst_payload_state via matching port */
+	payload->port = port;
+	payload->vc_start_slot = 3;
+	payload->time_slots = 7;
+	list_add_tail(&payload->next, &mst_state->payloads);
+
+	/* pre-set the bit so we can observe it being cleared */
+	aconnector->mst_status = MST_ALLOCATE_NEW_PAYLOAD;
+
+	stream->dm_stream_context = aconnector;
+	dm_helpers_dp_mst_update_mst_mgr_for_deallocation(NULL, stream);
+
+	KUNIT_EXPECT_EQ(test,
+			aconnector->mst_status & MST_CLEAR_ALLOCATED_PAYLOAD,
+			(int)MST_CLEAR_ALLOCATED_PAYLOAD);
+	KUNIT_EXPECT_EQ(test,
+			aconnector->mst_status & MST_ALLOCATE_NEW_PAYLOAD, 0);
+	/* drm_dp_remove_payload_part2() releases the payload's slot */
+	KUNIT_EXPECT_EQ(test, payload->vc_start_slot, -1);
+}
+
+/* Tests for dm_helpers_dp_write_dsc_enable() */
+
+/**
+ * dm_test_dp_write_dsc_enable_mst_no_aux - Test MST early return without dsc_aux
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dsc_enable_mst_no_aux(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_stream_state *stream;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	stream->dm_stream_context = aconnector;
+	stream->signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
+	aconnector->dsc_aux = NULL;
+
+	/* MST signal with NULL dsc_aux → return false */
+	KUNIT_EXPECT_FALSE(test, dm_helpers_dp_write_dsc_enable(NULL, stream, true));
+}
+
+/**
+ * dm_test_dp_write_dsc_enable_non_dp - Test non-DP signal returns false
+ * @test: The KUnit test context
+ *
+ * For an HDMI signal neither the MST nor the DP/eDP block runs, so ret stays 0.
+ */
+static void dm_test_dp_write_dsc_enable_non_dp(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_stream_state *stream;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	stream->dm_stream_context = aconnector;
+	stream->signal = SIGNAL_TYPE_HDMI_TYPE_A;
+
+	/* Non-DP/MST signal → no DPCD write, ret stays 0 (false) */
+	KUNIT_EXPECT_FALSE(test, dm_helpers_dp_write_dsc_enable(NULL, stream, true));
+}
+
+struct dm_test_dsc_aux_pair {
+	struct dm_test_synaptics_aux *main;
+	struct dm_test_synaptics_aux *passthrough;
+};
+
+static struct amdgpu_dm_connector *dm_test_alloc_dsc_connector(struct kunit *test,
+						       struct dc_link *link)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	aconnector->dc_link = link;
+
+	return aconnector;
+}
+
+static struct dc_stream_state *dm_test_alloc_dsc_stream(struct kunit *test,
+						       struct dc_link *link,
+						       enum signal_type signal)
+{
+	struct dc_stream_state *stream;
+	struct dc_sink *sink;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+	sink = kunit_kzalloc(test, sizeof(*sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, sink);
+
+	stream->link = link;
+	stream->signal = signal;
+	stream->sink = sink;
+	sink->link = link;
+
+	return stream;
+}
+
+static struct dm_test_dsc_aux_pair dm_test_dp_write_dsc_enable_mst(struct kunit *test,
+							   bool enable,
+							   bool passthrough)
+{
+	struct dm_test_dsc_aux_pair aux_pair;
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_mst_port *port;
+	struct dc_stream_state *stream;
+	struct dc_link *link;
+	bool ret;
+
+	link = dm_kunit_alloc_link(test);
+	aconnector = dm_test_alloc_dsc_connector(test, link);
+	stream = dm_test_alloc_dsc_stream(test, link, SIGNAL_TYPE_DISPLAY_PORT_MST);
+	port = kunit_kzalloc(test, sizeof(*port), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, port);
+	aux_pair.main = dm_test_alloc_synaptics_aux_with_dev(test, NULL);
+	aux_pair.passthrough = dm_test_alloc_synaptics_aux_with_dev(test, NULL);
+
+	stream->dm_stream_context = aconnector;
+	aconnector->dsc_aux = &aux_pair.main->aux;
+	aconnector->mst_output_port = port;
+	if (passthrough)
+		port->passthrough_aux = &aux_pair.passthrough->aux;
+
+	ret = dm_helpers_dp_write_dsc_enable(NULL, stream, enable);
+
+	KUNIT_EXPECT_TRUE(test, ret);
+	KUNIT_EXPECT_EQ(test, aux_pair.main->dsc_enable_writes, 1U);
+	KUNIT_EXPECT_EQ(test, aux_pair.main->dsc_enable_values[0], enable ? 1 : 0);
+	KUNIT_EXPECT_EQ(test, aux_pair.passthrough->dsc_enable_writes,
+			 passthrough ? 1U : 0U);
+	if (passthrough)
+		KUNIT_EXPECT_EQ(test, aux_pair.passthrough->dsc_enable_values[0], enable ? 2 : 0);
+
+	return aux_pair;
+}
+
+/**
+ * dm_test_dp_write_dsc_enable_mst_enable_decode_only - Test MST enable decoding write
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dsc_enable_mst_enable_decode_only(struct kunit *test)
+{
+	dm_test_dp_write_dsc_enable_mst(test, true, false);
+}
+
+/**
+ * dm_test_dp_write_dsc_enable_mst_enable_passthrough - Test MST enable passthrough write
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dsc_enable_mst_enable_passthrough(struct kunit *test)
+{
+	dm_test_dp_write_dsc_enable_mst(test, true, true);
+}
+
+/**
+ * dm_test_dp_write_dsc_enable_mst_disable_decode_only - Test MST disable decoding write
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dsc_enable_mst_disable_decode_only(struct kunit *test)
+{
+	dm_test_dp_write_dsc_enable_mst(test, false, false);
+}
+
+/**
+ * dm_test_dp_write_dsc_enable_mst_disable_passthrough - Test MST disable passthrough write
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dsc_enable_mst_disable_passthrough(struct kunit *test)
+{
+	dm_test_dp_write_dsc_enable_mst(test, false, true);
+}
+
+static void dm_test_dp_write_dsc_enable_sst(struct kunit *test,
+					   enum display_dongle_type dongle_type,
+					   bool enable,
+					   u8 expected_value)
+{
+	struct dm_test_synaptics_aux *fixture;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_stream_state *stream;
+	struct dc_link *link;
+	bool ret;
+
+	link = dm_kunit_alloc_link(test);
+	aconnector = dm_test_alloc_dsc_connector(test, link);
+	stream = dm_test_alloc_dsc_stream(test, link, SIGNAL_TYPE_DISPLAY_PORT);
+	fixture = dm_test_alloc_synaptics_aux_with_dev(test, NULL);
+
+	stream->dm_stream_context = aconnector;
+	link->priv = aconnector;
+	link->dpcd_caps.dongle_type = dongle_type;
+	dm_test_current_aux_recorder = fixture;
+	aconnector->dm_dp_aux.aux.transfer = dm_test_current_aux_transfer;
+	drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
+
+	ret = dm_helpers_dp_write_dsc_enable(NULL, stream, enable);
+
+	KUNIT_EXPECT_TRUE(test, ret);
+	KUNIT_EXPECT_EQ(test, fixture->dsc_enable_writes, 1U);
+	KUNIT_EXPECT_EQ(test, fixture->dsc_enable_values[0], expected_value);
+}
+
+/**
+ * dm_test_dp_write_dsc_enable_sst_rx_enable - Test SST RX enable DPCD write
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dsc_enable_sst_rx_enable(struct kunit *test)
+{
+	dm_test_dp_write_dsc_enable_sst(test, DISPLAY_DONGLE_NONE, true, 1);
+}
+
+/**
+ * dm_test_dp_write_dsc_enable_sst_rx_disable - Test SST RX disable DPCD write
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dsc_enable_sst_rx_disable(struct kunit *test)
+{
+	dm_test_dp_write_dsc_enable_sst(test, DISPLAY_DONGLE_NONE, false, 0);
+}
+
+/**
+ * dm_test_dp_write_dsc_enable_pcon_enable - Test DP-HDMI PCON enable DPCD write
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dsc_enable_pcon_enable(struct kunit *test)
+{
+	dm_test_dp_write_dsc_enable_sst(test, DISPLAY_DONGLE_DP_HDMI_CONVERTER, true, 1);
+}
+
+/**
+ * dm_test_dp_write_dsc_enable_pcon_disable - Test DP-HDMI PCON disable DPCD write
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_write_dsc_enable_pcon_disable(struct kunit *test)
+{
+	dm_test_dp_write_dsc_enable_sst(test, DISPLAY_DONGLE_DP_HDMI_CONVERTER, false, 0);
+}
+
+/* Tests for dm_helpers_dp_handle_test_pattern_request() */
+
+/**
+ * dm_test_dp_handle_test_pattern_no_pipe - Test no matching pipe returns false
+ * @test: The KUnit test context
+ */
+static void dm_test_dp_handle_test_pattern_no_pipe(struct kunit *test)
+{
+	union link_test_pattern test_pattern = {0};
+	union test_misc test_params = {0};
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_state *state;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	link = dm_kunit_alloc_link(test);
+	aconnector = dm_kunit_alloc_connector(test, adev, link);
+
+	ctx->dc = dc;
+	dc->current_state = state;
+	link->dc = dc;
+	link->priv = aconnector;
+
+	KUNIT_EXPECT_FALSE(test,
+			dm_helpers_dp_handle_test_pattern_request(ctx, link,
+							       test_pattern,
+							       test_params));
+}
+
 static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* edid_extract_panel_id */
 	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
@@ -3020,6 +3798,8 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_mst_start_top_mgr_null_priv),
 	KUNIT_CASE(dm_test_mst_stop_top_mgr_null_priv),
 	KUNIT_CASE(dm_test_mst_start_top_mgr_boot),
+	KUNIT_CASE(dm_test_mst_start_top_mgr_set_mst_fail),
+	KUNIT_CASE(dm_test_mst_stop_top_mgr_active),
 	/* dm_helpers_dp_write_hblank_reduction */
 	KUNIT_CASE(dm_test_dp_write_hblank_reduction_false),
 	/* get_dsc_max_slices */
@@ -3056,12 +3836,22 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_smu_timeout_no_crash),
 	KUNIT_CASE(dm_test_set_phyd32clk_no_crash),
 	KUNIT_CASE(dm_test_mst_update_branch_bandwidth_no_crash),
+	/* dm_helpers_dp_mst_write_payload_allocation_table success path */
+	KUNIT_CASE(dm_test_write_payload_alloc_table_enable),
+	KUNIT_CASE(dm_test_write_payload_alloc_table_disable),
 	/* MST null-connector early returns */
 	KUNIT_CASE(dm_test_mst_write_payload_alloc_table_null_ctx),
 	KUNIT_CASE(dm_test_mst_poll_for_act_null_ctx),
 	/* dm_helpers_dp_mst_poll_for_allocation_change_trigger success/fail */
+	KUNIT_CASE(dm_test_poll_for_act_no_mst_state),
+	KUNIT_CASE(dm_test_poll_for_act_success),
+	KUNIT_CASE(dm_test_poll_for_act_status_failed),
 	KUNIT_CASE(dm_test_mst_send_payload_alloc_null_ctx),
 	KUNIT_CASE(dm_test_mst_update_mgr_dealloc_null_ctx),
+	/* dm_helpers_dp_mst_send_payload_allocation failure path */
+	KUNIT_CASE(dm_test_mst_send_payload_alloc_part2_fail),
+	/* dm_helpers_dp_mst_update_mst_mgr_for_deallocation success path */
+	KUNIT_CASE(dm_test_mst_update_mgr_dealloc_success),
 	/* dm_helpers_is_dp_sink_present */
 	KUNIT_CASE(dm_test_is_dp_sink_present_null_priv),
 	/* dm_helpers_dmub_outbox_interrupt_control */
@@ -3087,6 +3877,22 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_mccs_vcp_set_null_link),
 	KUNIT_CASE(dm_test_mccs_vcp_set_i2c_packet),
 	KUNIT_CASE(dm_test_mccs_vcp_set_i2c_failure),
+	/* dm_helpers_construct_old_payload */
+	KUNIT_CASE(dm_test_construct_old_payload_empty_list),
+	KUNIT_CASE(dm_test_construct_old_payload_intervening),
+	/* dm_helpers_dp_write_dsc_enable */
+	KUNIT_CASE(dm_test_dp_write_dsc_enable_mst_no_aux),
+	KUNIT_CASE(dm_test_dp_write_dsc_enable_non_dp),
+	KUNIT_CASE(dm_test_dp_write_dsc_enable_mst_enable_decode_only),
+	KUNIT_CASE(dm_test_dp_write_dsc_enable_mst_enable_passthrough),
+	KUNIT_CASE(dm_test_dp_write_dsc_enable_mst_disable_decode_only),
+	KUNIT_CASE(dm_test_dp_write_dsc_enable_mst_disable_passthrough),
+	KUNIT_CASE(dm_test_dp_write_dsc_enable_sst_rx_enable),
+	KUNIT_CASE(dm_test_dp_write_dsc_enable_sst_rx_disable),
+	KUNIT_CASE(dm_test_dp_write_dsc_enable_pcon_enable),
+	KUNIT_CASE(dm_test_dp_write_dsc_enable_pcon_disable),
+	/* dm_helpers_dp_handle_test_pattern_request */
+	KUNIT_CASE(dm_test_dp_handle_test_pattern_no_pipe),
 	{}
 };

--
2.55.0

