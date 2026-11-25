Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9992606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KE2DdK+P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587AA10F895;
	Wed, 25 Nov 2026 06:58:46 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010012.outbound.protection.outlook.com
 [52.101.193.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BDB10F785
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:58:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nga+YcSciLG5mAGCR1V2cUYq9ddeb+MZmsUkBBpGyloSCRh8Ji3YMvTsSloC7gwvtfiLTl1kATLOU8wQC03uY63R41tCWwhdwWHBVobODKe+wnX9f1ZprdZLRKws+eqBnoGHqRQbsd34tyeQP7KU+XWx4p87eax4WryHCAFQp14PQC+OPJ10pIAMkF1irksQv5v3rbTjGVsG5mFyFY0G76LUp6MqvVMDMkKrpuXBz41tujNHyQdS1lTtdBffGax7XwOfCFzttMwQD2Dyaf3bvlMv5dHkXSgoUeuzY2F2PO9fuA2Pd25lZiwXOzW+whoN4KzGCmK/Z/OVhdnp/QC/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF4p0/dRL0ivJmo6HHpxpqXw6c/R1iW8QSwyPmBF56o=;
 b=r5BldH5h4VCWAnlMhmAyT75OjTj9yPyYCBb5d4yKwDCQFbF1jJKHGB/Pkqx96+Mu1L/4XACQdiBBRTW64Wb4BC9+KrC0aiF0mcTyfrVMD4VgiB6W/k/HAtFB0T79aKNRgEUWopnvZpNVsP6rvgArLcm89m5UfAl1GV0Jowdx0GCCWl0OdaY5Z0llR+LRtywyaqUMnSjcuCIvk3OBmNKMf8L/zk99qNJ/EeGiO6dOll1mlqt7pNOrvhOfkWEoUMHk5FOIPVWMZ825HwRs1BHcTSqUys8w183313Jj6MFSP0aKFWJNCe8DcWd/W8ANUGFyOtvtsbIbgFLBECAqcrdDxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF4p0/dRL0ivJmo6HHpxpqXw6c/R1iW8QSwyPmBF56o=;
 b=KE2DdK+PQLWJvc1TImRlPxBsTDuHMmSBQpPoUaW2IEmEFF9+gpY2QekOqzTppnG3pPHSl9NLmQicbnUWn2NJ71xr+U+RuWCsXyasEOzY8+AhfWXxA/z0lVaw9s5CVxSUQdeFWXYCz7IfhjXxXlWQvver8K3zqDAwGrIBO1XDPsw=
Received: from PH0PR07CA0068.namprd07.prod.outlook.com (2603:10b6:510:f::13)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 06:58:36 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:510:f:cafe::6) by PH0PR07CA0068.outlook.office365.com
 (2603:10b6:510:f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 06:58:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:58:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:58:34 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:58:34 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:58:26 -0600
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
Subject: [PATCH 22/27] drm/amd/display: Test amdgpu_dm_dmub fused IO replies
Date: Wed, 25 Nov 2026 14:55:11 +0800
Message-ID: <20261125065631.3889665-23-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 757ad744-dff6-42da-9039-08df4ac1867d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|18002099003|22082099003|56012099006|11063799006|261102130727099003|261102123227099003|261021123027099003|261026121527099003|261009223027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: lX5OD6hVgD82j6B+mqM6MSVRFtUZcf8JKQVoP0ZeNgRJIsOvOL5XDP8aGW7x1CUCcWsgPmqB6uWLhlew3N4GBxxMOEgeWEzZuDcnrUE3zbmr9WQs+oW5RwAzh+wwn7TcqHOjojE5XLZnmLi9BJpTF1+D3iYVYpUt/TBmkmOor/kTdF5p+ysl10v2Fh9KVGuvnJW6oXRs+O15b1pR/IqBdHyDRe755/A7Grqb/9Gh9K9+NNV2x/nha7ECeIGusBPfUSxq14L7R+BGn8+Y/Z0zIKRsng99nq+82KAMLiNNuCtwGAN8pdJw8iuMkRQmktztFemXV67BnlsROeVEkouAYfCIzjzzHONvIBuVZhCLJ1NNLwLcq4BOSlyf/Opqjrtv5Ah9WKfsdO8+MlcNSRYQtCNA3RzjFoGMjWRNq+3aDeRxHSoQi57qfSnE8d1uAdhq9G7YvgP/DSOXyqIjRPRgHwwt/RG3E3qUo9fsAlRe21g1iAzr05Pi6csCQtbUrSPhGpmESblu/zWY3VQFnv1VPmoXpekqHhoJZo+VNj2mtybQ1SqsOucHBxDtOx0aLt24tulb4kytWUi3hjdw+0bp5CJiVIZdgE10k4MYvqq95kOMHl6ExJxwkvfLFLWVevouf/KMXBm/wm2fG1GYbd7ZX7UAeWEXeesdpxSpWQju0Vr4um0SJ/ljhyPZaDGaR2ChjfsAYO3bBnWSAXNamQaCww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(261102130727099003)(261102123227099003)(261021123027099003)(261026121527099003)(261009223027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J/ZL9KMxU+v9JZ+M3DKFFBgLLYHuUOduV1sckcY7sbptA66KgVPgTSg+dSaanTR6VLhuRWbRejT5G3h+jccNfeIUZpLn4w4G80aQD8E5s/41g++B648Z5jBcORP+3teE7j4f2aSSRCtIEBgm4MAIQy1tv6qIvez17PaK7zdlV7yXYfLeTfqsxlSMt4GsSFYGKKPE2k/3BOx0yyad5V/hUwZjzjQu1BNrhdX7HUr1K/voXY0ZcFWoXXYelJAklSq7zorjaro+vreovp3kQ3IdTHNFvDHzcQ43y2j6pAgv0TCNgJsHGSpt29xJE+DNU5JHVxtG6yUC499o1fzaco+A03RDQKs8KpNcJS0I9WJsZI6Zc/oYEq3JAOBlwDZBSbDfEaYaqIWkwePsqOLuDMG5XYIv4npl1Ha4Siu9OqXNNZh4LzVVom5dE4GuPLWgJeit
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:58:35.4157 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 757ad744-dff6-42da-9039-08df4ac1867d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Hung <alex.hung@amd.com>

[WHAT]
Add KUnit tests for amdgpu_dm_execute_fused_io() covering a matching
reply, and a stale reply that times out and aborts the request.

Cc: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 73 +++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 6c26fd361ce4..024c2395d2c2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -1018,6 +1018,7 @@ bool amdgpu_dm_execute_fused_io(
 	mutex_unlock(&dm->dpia_aux_lock);
 	return result;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_execute_fused_io);
 
 int amdgpu_dm_process_dmub_set_config_sync(
 		struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index 8117ae4a2aef..9c0171b86c67 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -1589,6 +1589,76 @@ static void dm_test_abort_fused_io_no_dmub_srv(struct kunit *test)
 	abort_fused_io(ctx, req);
 }
 
+/* Tests for amdgpu_dm_execute_fused_io() */
+
+#define DM_TEST_FUSED_DDC_LINE	2
+#define DM_TEST_FUSED_ID	0x5a
+
+/*
+ * Fill @cmd with a fused IO request the fake DMUB echoes back as accepted, and
+ * seed the reply slot of its DDC line with a reply carrying @reply_id as if
+ * the DMUB outbox callback had already delivered it.
+ */
+static struct completion *dm_test_prepare_fused_io(struct amdgpu_device *adev,
+						   union dmub_rb_cmd *cmd, u8 reply_id)
+{
+	struct fused_io_sync *sync = &adev->dm.fused_io[DM_TEST_FUSED_DDC_LINE];
+	struct dmub_cmd_fused_request *reply = (struct dmub_cmd_fused_request *)sync->reply_data;
+
+	cmd->fused_io.header.ret_status = 1;
+	cmd->fused_io.request.status = FUSED_REQUEST_STATUS_SUCCESS;
+	cmd->fused_io.request.identifier = DM_TEST_FUSED_ID;
+	cmd->fused_io.request.u.aux.ddc_line = DM_TEST_FUSED_DDC_LINE;
+
+	init_completion(&sync->replied);
+	reply->status = FUSED_REQUEST_STATUS_REPLY;
+	reply->identifier = reply_id;
+	complete(&sync->replied);
+
+	return &sync->replied;
+}
+
+/**
+ * dm_test_execute_fused_io_reply_matches - Test fused IO returns the matching reply
+ * @test: The KUnit test context
+ *
+ * Once DMUB accepts the request, a reply with the same identifier must be
+ * copied into the caller's request and the reply completion rearmed.
+ */
+static void dm_test_execute_fused_io_reply_matches(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_link(test);
+	union dmub_rb_cmd cmd = { 0 };
+	struct completion *replied = dm_test_prepare_fused_io(adev, &cmd, DM_TEST_FUSED_ID);
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_execute_fused_io(adev, adev->dm.dc->links[0], &cmd, 1,
+							   1000));
+	KUNIT_EXPECT_EQ(test, cmd.fused_io.request.status, FUSED_REQUEST_STATUS_REPLY);
+	KUNIT_EXPECT_FALSE(test, completion_done(replied));
+}
+
+/**
+ * dm_test_execute_fused_io_reply_mismatch_aborts - Test a stale reply leads to abort
+ * @test: The KUnit test context
+ *
+ * A reply for a different identifier is discarded; when no matching reply
+ * arrives before the timeout, the request is marked timed out and an abort
+ * command follows the execute command into the DMUB inbox.
+ */
+static void dm_test_execute_fused_io_reply_mismatch_aborts(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_link(test);
+	u32 wrpt = adev->dm.dmub_srv->inbox1.rb.wrpt;
+	union dmub_rb_cmd cmd = { 0 };
+
+	dm_test_prepare_fused_io(adev, &cmd, DM_TEST_FUSED_ID + 1);
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_execute_fused_io(adev, adev->dm.dc->links[0], &cmd, 1,
+							    1000));
+	KUNIT_EXPECT_EQ(test, cmd.fused_io.request.status, FUSED_REQUEST_STATUS_TIMEOUT);
+	KUNIT_EXPECT_EQ(test, adev->dm.dmub_srv->inbox1.rb.wrpt, wrpt + 2 * DMUB_RB_CMD_SIZE);
+}
+
 /*
  * Fake CGS device: the DMUB register callbacks reach the hardware through
  * cgs_read_register()/cgs_write_register(), which dispatch via the ops table
@@ -2191,6 +2261,9 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	KUNIT_CASE_SLOW(dm_test_process_dmub_set_config_sync_timeout),
 	/* abort_fused_io() */
 	KUNIT_CASE(dm_test_abort_fused_io_no_dmub_srv),
+	/* amdgpu_dm_execute_fused_io() */
+	KUNIT_CASE(dm_test_execute_fused_io_reply_matches),
+	KUNIT_CASE(dm_test_execute_fused_io_reply_mismatch_aborts),
 	{}
 };
 
-- 
2.43.0

