Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE26C88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8225410EC90;
	Wed, 16 Sep 2026 17:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TU73qECM";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013000.outbound.protection.outlook.com
 [40.107.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78BA210EBD9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ob8hrKxdfBimStberxgJFW+kjUSTTp5pQ1TVb/dwZwoBCBGTMZNhacDzuPOpzk5qd9/NN7Uz+WO7q1euQV6VB2gPa0f8uH6o5u5v0lqxv7TlEsOhXccWP737qKZIvE4bD4XCPQrVuUIG9bOqys4v1qjtVUdQ9KVmTb+BHJ6fpU4O2bYnnxzfz3xE8THiF3bu7cujXP2Cr6OexnVrhfnoIrDhyL5Q7ThX9D/Ni7WwORyTgyPTvwHCSuTeDdoEFBqrejd107WKWDXIasxdcKWplgfocPcX0aUZDy4K2LQ0DgFf749q4Sa0bYjL++Pd+RxEK8rdQiVbU8mYiZEQfu03hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy36+aoGLnIIG+5d5oKB5UehCEO0Gc+ivxwqxktoF9o=;
 b=PUqyJN/rt//pmXh+Tucz3ZAo3q3RCVqgnrIEHrssckOSru0/53dPWV2Q1qBxGsjCPPWxQRVMQ4FgdGVUsvFP79eteuAHbHCN+X/rXFf3OsrRTGB5w7kItjoYAg2pxdO/8FTyQsOglA6nBiM9WyICj0SqfOprhyfjbvgTO+NaIQglg5pMO4tg9ui0G9SlXKAKTPwRqaHPYkZGjhJKG8rTrmyCOMAVtOPXxf3gtYD4Xwa3s0A9YmFLEtpWDTJJOlERqNS6026VUErEiVO0kymH3yM64NZXEz+eKU+VjWqIAYkLD4jahqWoBHPCMiyaxKDu68IOCQVCd5Ta7qQpgipigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy36+aoGLnIIG+5d5oKB5UehCEO0Gc+ivxwqxktoF9o=;
 b=TU73qECMy5W7Q2ixN3c6BJldrmk9bRhmRUIhcGEmcdDI8YztJLNzzSs6KuORjUedFmGQV5w/t3w5Qpyhk65sPifGbrzKt1l/HLgYhR3wWERUHK9baUOR+1+GFE3T5mcNf4utwEX5FCtS6uk+vgn9hS5A8vwNWWFVCPvRMwbBBGs=
Received: from CH0PR03CA0186.namprd03.prod.outlook.com (2603:10b6:610:e4::11)
 by CYYPR12MB8702.namprd12.prod.outlook.com (2603:10b6:930:c8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Wed, 16 Sep
 2026 17:52:47 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::81) by CH0PR03CA0186.outlook.office365.com
 (2603:10b6:610:e4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:47 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:36 -0500
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
Subject: [PATCH 29/64] drm/amd/display: Test AUX transfer paths
Date: Wed, 16 Sep 2026 13:51:44 -0400
Message-ID: <20260916175301.368306-30-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|CYYPR12MB8702:EE_
X-MS-Office365-Filtering-Correlation-Id: e75df0c3-1ece-45e6-3412-08df141b5157
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: CaN2Jxmaoze141vgsmlhVqEHLb4nodp6Z3SDmeJB2wK1IxUlk5UEuacQelb674b1XRaiszkA2EKWW8SNPWOJAchCqEOZbQB+wekZr87zJnHHpGpgb4KctgdGFuVFhd66SjczqDE+A3/1eidTRFmnQO9UzSUuioOpLow4/QaZWnAnHPg/ovT7Ed2JQjAAfrv64JCp9yb6qZ5cteox27X9grG3w2V3hp6fWAazWvCQGc2VlHHVGDxwdojENNz61vnjjqJECY09FeHlzi2hzwDh4+KKVW1v9YUkQ+wANrItOyNCz3YDjyQGpbkcyYdB+EUuL2KTs5xKXPKVx9EhHLUZq4qjs4/Avbt1bZEltbian69rpTZNmz90VoKVubBF2FH14jWZLhSEjRalLwqhqhu4OSQxVfEft6sIOwZt2QVER729/2LuiyyqCP3g6T8tEgK5PsRBOo4/hH1V607ZJvbDAqL7CSvR4yYXhF0QcJ25Ew63+F6mx2UC3WCTRPh64VFNtBM6cyM3DAb3LG/IDBbZ+m8ni/rVK9jqzFlBSO/JjULZByrUKp6L4vasyTQT4U3NCR4+MeZbErDATqFKBaElbrI15XFCJ6HUlvCMagyKpgYstahhJia/cDFc7gv0pj4sHTsV9szKCBpxmjggUYmdTznc9XKtEwGFuyr9KiKhAxWl0VgAWCfvzIkb4u9H8cA4PbsY8LM6eFuFweTe7BuGfQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: B4/5euWH9o3KkbAp8b8Nlz9HkLHseiJcsRInxuA+rFdjf4pBmuR6xhU1hmSrczwZ6cFh7MNoiLV4a94DJFsmdPMomSZTyS1xxNsN1zyqRRNkmUkeeaNEAANmkoTMAKGLCw8C2yTrHJ1gIFLTnySXg+k6tomngwSTW8snmuLpu0fHydJUCLNWDKeCrrkyrYmUsnwBEsNNBqAW2RqPtT3zFVFWnU6wVlSZtUjX6/14PFBCuAWVeVdZW1+nD/Ss9E0C/odcf5krzeSbh9gN71rC9QDwmgy5uJRY6gNY4e6EdsBmhayJGzzfaXa6v8pAZDY/BwfRg9t8j8J5+20FNiANtQxH2pSD2Br43VlL5J+EDT18iq66p/OiOTwjpzx4j9yXmhyu7pCCe2AzFeF0klZxhqJyVgf7t9YnbjbP3miaz41CEPOqhBpC43Yt1pkN9thf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:47.0682 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75df0c3-1ece-45e6-3412-08df141b5157
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8702
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
Add KUnit tests for the AUX paths of dm_helper_dmub_aux_transfer_sync(),
dm_helpers_read_mccs_caps() and dm_helpers_mccs_vcp_set(). Only their
early returns and the plain I2C branch were covered before.

[HOW]
dm_helper_dmub_aux_transfer_sync() is called with HPD connected so it
forwards the payload to the DMUB transfer. dc->link_count is zero, so
the async transfer is rejected and the engine-acquire error is
reported.

Both MCCS helpers pick their DDC adapter from link->aux_mode. Add a
fake AUX channel that ACKs every I2C-over-AUX transaction and counts
the sized writes, then route the shared MCCS fixture through it. The
VCP set completes on the first write. The VCP request gets an empty
reply, so every attempt is retried and the request finally fails.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index b433634e0390..b38601c1da5a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -2488,6 +2488,39 @@ static void dm_test_dmub_aux_transfer_sync_hpd_discon(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)result, (int)AUX_RET_ERROR_HPD_DISCON);
 }
 
+/**
+ * dm_test_dmub_aux_transfer_sync_hpd_connected - Test the transfer is forwarded to DMUB
+ * @test: The KUnit test context
+ *
+ * With HPD connected the helper forwards the payload to
+ * amdgpu_dm_process_dmub_aux_transfer_sync(). dc->link_count is zero, so the
+ * async transfer is rejected and the engine-acquire error is reported.
+ */
+static void dm_test_dmub_aux_transfer_sync_hpd_connected(struct kunit *test)
+{
+	struct aux_payload payload = {0};
+	enum aux_return_code_type result = AUX_RET_SUCCESS;
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	int ret;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	ctx = dm_kunit_alloc_dc_with_ctx(test)->ctx;
+	link = dm_kunit_alloc_link(test);
+
+	ctx->driver_context = adev;
+	mutex_init(&adev->dm.dpia_aux_lock);
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+	link->hpd_status = true;
+
+	ret = dm_helper_dmub_aux_transfer_sync(ctx, link, &payload, &result);
+
+	KUNIT_EXPECT_EQ(test, ret, -1);
+	KUNIT_EXPECT_EQ(test, (int)result, (int)AUX_RET_ERROR_ENGINE_ACQUIRE);
+}
+
 /* Tests for empty stub functions (must not crash) */
 
 /**
@@ -3075,6 +3108,56 @@ static void dm_test_read_mccs_caps_i2c_failure(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fake->reads, 0U);
 }
 
+/* Counts sized I2C-over-AUX writes; the bracketing bare-address ones have size 0. */
+static unsigned int dm_test_mccs_aux_writes;
+
+static ssize_t dm_test_mccs_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
+{
+	if ((msg->request & ~DP_AUX_I2C_MOT) == DP_AUX_I2C_WRITE && msg->size)
+		dm_test_mccs_aux_writes++;
+
+	msg->reply = DP_AUX_I2C_REPLY_ACK;
+	return msg->size;
+}
+
+/*
+ * Route the fixture's link through an AUX DDC instead of the fake I2C adapter,
+ * so the MCCS helpers take their link->aux_mode branch.
+ */
+static void dm_test_mccs_use_aux(struct dm_test_mccs_fixture *fixture)
+{
+	struct drm_dp_aux *aux = &fixture->aconnector->dm_dp_aux.aux;
+
+	aux->drm_dev = &fixture->adev->ddev;
+	aux->transfer = dm_test_mccs_aux_transfer;
+	drm_dp_aux_init(aux);
+
+	fixture->aconnector->base.dev = &fixture->adev->ddev;
+	fixture->link->aux_mode = true;
+	dm_test_mccs_aux_writes = 0;
+}
+
+/**
+ * dm_test_read_mccs_caps_aux_mode - Test the MCCS VCP request over I2C-over-AUX
+ * @test: The KUnit test context
+ *
+ * The AUX DDC ACKs both transactions but answers with an empty VCP reply, so
+ * every attempt is retried and the request finally fails.
+ */
+static void dm_test_read_mccs_caps_aux_mode(struct kunit *test)
+{
+	struct dm_test_mccs_fixture fixture = dm_test_alloc_mccs_fixture(test);
+
+	dm_test_mccs_use_aux(&fixture);
+	fixture.link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
+	fixture.sink->edid_caps.freesync_vcp_code = 0xe3;
+
+	dm_helpers_read_mccs_caps(fixture.ctx, fixture.link, fixture.sink);
+
+	KUNIT_EXPECT_FALSE(test, fixture.sink->mccs_caps.freesync_supported);
+	KUNIT_EXPECT_EQ(test, dm_test_mccs_aux_writes, 5U);
+}
+
 /* Tests for dm_helpers_mccs_vcp_set() */
 
 /**
@@ -3188,6 +3271,23 @@ static void dm_test_mccs_vcp_set_i2c_failure(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, fake->reads, 0U);
 }
 
+/**
+ * dm_test_mccs_vcp_set_aux_mode - Test the MCCS VCP set over I2C-over-AUX
+ * @test: The KUnit test context
+ */
+static void dm_test_mccs_vcp_set_aux_mode(struct kunit *test)
+{
+	struct dm_test_mccs_fixture fixture = dm_test_alloc_mccs_fixture(test);
+
+	dm_test_mccs_use_aux(&fixture);
+	fixture.sink->mccs_caps.freesync_supported = true;
+	fixture.sink->edid_caps.freesync_vcp_code = 0xe3;
+
+	dm_helpers_mccs_vcp_set(fixture.ctx, fixture.link, fixture.sink);
+
+	KUNIT_EXPECT_EQ(test, dm_test_mccs_aux_writes, 1U);
+}
+
 /* Tests for dm_helpers_construct_old_payload() */
 
 /**
@@ -4809,6 +4909,7 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_submit_i2c_partial_transfer),
 	/* dm_helper_dmub_aux_transfer_sync */
 	KUNIT_CASE(dm_test_dmub_aux_transfer_sync_hpd_discon),
+	KUNIT_CASE(dm_test_dmub_aux_transfer_sync_hpd_connected),
 	/* Empty stub functions */
 	KUNIT_CASE(dm_test_dp_update_branch_info_no_crash),
 	KUNIT_CASE(dm_test_mst_poll_pending_down_reply_no_crash),
@@ -4854,12 +4955,14 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_read_mccs_caps_hdmi_vcp_request),
 	KUNIT_CASE(dm_test_read_mccs_caps_legacy_pcon_vcp_request),
 	KUNIT_CASE(dm_test_read_mccs_caps_i2c_failure),
+	KUNIT_CASE(dm_test_read_mccs_caps_aux_mode),
 	/* dm_helpers_mccs_vcp_set */
 	KUNIT_CASE(dm_test_mccs_vcp_set_null_ctx),
 	KUNIT_CASE(dm_test_mccs_vcp_set_not_supported),
 	KUNIT_CASE(dm_test_mccs_vcp_set_null_link),
 	KUNIT_CASE(dm_test_mccs_vcp_set_i2c_packet),
 	KUNIT_CASE(dm_test_mccs_vcp_set_i2c_failure),
+	KUNIT_CASE(dm_test_mccs_vcp_set_aux_mode),
 	/* dm_helpers_construct_old_payload */
 	KUNIT_CASE(dm_test_construct_old_payload_empty_list),
 	KUNIT_CASE(dm_test_construct_old_payload_intervening),
-- 
2.55.0

