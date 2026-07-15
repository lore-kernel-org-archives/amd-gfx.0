Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2B9C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F102810F06D;
	Wed, 15 Jul 2026 13:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EZeUrimW";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010047.outbound.protection.outlook.com
 [52.101.193.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 767EA10F06D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:45:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnVeIp8zNHIaufnk8GIlpUeRVQaN++LjMJ4dLHWm6iUCJo8EZ12ivY+VEwcmjee4tV9op+7K91zZboPoUFTWgzOQp/IMER8UnWfzImo5Nen7GZkxmvAtmi69A8adYZxWtD51daFxK3zD3ZdeyANaLf/V6lpxsZPvhbPXTFxexz8rslvnORfeABXhujtT/P9P9hrVV4pOXZQ63/Bg+DccCCveNw8up30yVIG6rIaTePmZbl9V180EoOMJzaKFLY7e17owL8U/tSyugDF+fRndulmQLrPz3r3kWHEtB1ny2FHyYEkBZrcgqSXBjZ5+Mvsba2/ygIbi8zPKm0PF56aHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNiGSzJfIBjRmxJqfzpgaBd5lGadmZ50dHcAutWZBMM=;
 b=uEoWR2Vtta4wJwCZamBr3IKI+8owpheY79gmQuOGxr5n8YH0w29qUSSk7WciMPnjKGLPNOsjHYh7zya+G9QVprlhMNLBAulRyKRSlqaEmzSBOv78LZpcMfskUFVAIlRkBvXBpJuBenV2SDIQyBVgjjYsYI0Swg32lKodH0js1JbqN9cH9XOI11my64QLWykB4UcF0s3Znv8bge9gW34O00mk+nGdvQO39k1/lFdz586Z42a5n8/MwSrq3piQMSx6/jpfnF8/r2suJDcE3rQCt4dQ4pVJwsTTuc6s5dWsxcjSOCQ/YJG2gher94amsMXZ/uFAxIBkUD5I9I0s36VSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNiGSzJfIBjRmxJqfzpgaBd5lGadmZ50dHcAutWZBMM=;
 b=EZeUrimWyOq1DVAOdFCArt6ce+iAkLHq6k5Qv4L34z5sPdaKJUfRLHFLbLQP96rKN3WEQHNB1tq4jgYXIW6mgULCu8rqxnKygMhlgwa0DT9Ydykg3Yzgd5eEDXsoHim98/OL4CBV/JvHMYlD6uW9amVcSycj2shoKFRZkIbok8g=
Received: from SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:45:35 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::15) by SJ0PR03CA0278.outlook.office365.com
 (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:45:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:19 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:16 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 07/70] drm/amd/display: add fused IO KUnit coverage
Date: Wed, 15 Jul 2026 21:37:17 +0800
Message-ID: <20260715134432.1975118-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: f903f0c1-fe1a-4eac-566c-08dee2775879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|6133799003|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 8rpa0Zi/heHYmsdiE0bepQnXdWiKDaMzyTrjfalK5QTTuNAdiw1zsWIuBDesfLYPa+DcspBw6I462DUqwGkLehfnPQgbopMjFc1gJEkjrjTT+th6LnWSnFvVb+VMwk7n8UUXqGmRjvhq4orIP0x8dD0+MWOl6IS1n9k+/3mJi1oJFqDpPUUf8M5vH3B9JjHle4+eYEyfWldQ4VDB59vGeP0ZhKeN/oRwv+dkmhiBy/9uQ8vVyUdrfrS6gSFeSdZu7m3Q4ID2u0/yt6aneFdw/hhs5d18pnyTTaMQJZHckol/hP45MoO4WqH+Uwboc1Ik5kFkOl+mOiQHTdYyXqq27XLec+tkB9X7ui6PBCzy6PjX+q2QV0mpWPJ9KbAl/LpRbVMVN1+GYmjIFS3En7P3J5Ff+Ebp2umjIZ5bcV5DyqY/VdWWbzEyNyLtvhr/lwZbJdW/JZzU0YDbJmuSQBGdlRzyGO3+vJU4nV44M/r0zx25R0igBvJ/8Nal9A07saDiZqXF8nKLjiujGiUByJ73t9s8kXW7db+E4hv3Ggt9RGh3DsUYCLaQ0xafZveTuleA/8e4DDmFNpEFqQ4PUC1WM5qwjONqjiAm+xO7lH3YEwyUMGBPZPSEWQnIonnkktUC1sn8ZKwxvjpE7q+NRIVxxNpXftKlmlFywBjCzWW44x24gYpcVJPE6T4dFs3PDxenq65zqnRKYO9W4ouhlELVCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UUXXs+Nnr0c7/K06XMOucjXo83veie4xQct4PD8h0yUxesWS+MjjrBc5AkECWYTYzAzmaTeqhdPrIcTTA/gEVVZgXMhw6i7UTCSByyFRdYzsQCGPJ6MIlVbNaDpGTqffSkeSuWFFag0pZw+EbmgGJp56KgJYrQ36p//lyhmWg+Onq43/Rbg8eksZvecupRTgKrYuVpRLA8YDp9ekmO7SzebY5n7uhZNYeKj+AdqHo9XGJP3vOqLqZwNRg98wlpMWgH357xfbrH5wbz84WKGR/Syuv3zC7WnXEONc5PsUdhAFgRG2Jt7BWXcwSrBLXHfj5ifbzBsknAyWMUk5yOkllV9Iijsq8H1B5rzrM7006MUXgcoSfxtuHHVSxMRsInuv5LxR9YAnCCi3KykiPGlFaEZV/G5RysqJWCRZKs7kr/US6tvvp8Xw/8vM7GJ9QOJc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:45:34.5265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f903f0c1-fe1a-4eac-566c-08dee2775879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
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
Add KUnit coverage for the DMUB fused IO helpers: the
dm_dmub_aux_fused_io_callback() NULL-argument guard and the
abort_fused_io() no-DMUB-service path.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  8 +++
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 52 +++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index d2148b62073d..b6f09a687969 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -831,7 +831,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 	return ret;
 }
 
-static void abort_fused_io(
+STATIC_IFN_KUNIT void abort_fused_io(
 		struct dc_context *ctx,
 		const struct dmub_cmd_fused_request *request
 )
@@ -845,6 +845,7 @@ static void abort_fused_io(
 	io->request = *request;
 	dm_execute_dmub_cmd(ctx, &command, DM_DMUB_WAIT_TYPE_NO_WAIT);
 }
+EXPORT_IF_KUNIT(abort_fused_io);
 
 static bool execute_fused_io(
 		struct amdgpu_device *dev,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
index a4a03e40ec37..ba50e1af80c1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
@@ -65,4 +65,12 @@ int dm_init_microcode(struct amdgpu_device *adev);
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 #define FIRMWARE_NAVI12_DMCU		"amdgpu/navi12_dmcu.bin"
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+struct dc_context;
+struct dmub_cmd_fused_request;
+
+void abort_fused_io(struct dc_context *ctx,
+		    const struct dmub_cmd_fused_request *request);
+#endif
+
 #endif /* AMDGPU_DM_AMDGPU_DM_DMUB_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index bae34436c89e..c3bd93b15d0a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -396,6 +396,22 @@ static void dm_test_dmub_aux_fused_io_callback_max_ddc_line(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, reply_ddc_line, notify_ddc_line);
 }
 
+/**
+ * dm_test_dmub_aux_fused_io_callback_null_args - Test the NULL-argument guard
+ * @test: The KUnit test context
+ *
+ * Passing a NULL device triggers the defensive guard (an ASSERT that maps to
+ * WARN_ON_ONCE in this build) and returns early without dereferencing the
+ * arguments. The call must not crash.
+ */
+static void dm_test_dmub_aux_fused_io_callback_null_args(struct kunit *test)
+{
+	struct dmub_notification notify = {};
+
+	/* Must not crash; guard hits ASSERT (WARN_ON_ONCE) and returns. */
+	dm_dmub_aux_fused_io_callback(NULL, &notify);
+}
+
 /* Tests for dm_get_default_ips_mode() */
 
 /**
@@ -916,6 +932,39 @@ static void dm_test_init_microcode_unsupported_asic(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_init_microcode(adev), 0);
 }
 
+/* Tests for abort_fused_io() */
+
+/**
+ * dm_test_abort_fused_io_no_dmub_srv - Test fused IO abort is a safe no-op without DMUB service
+ * @test: The KUnit test context
+ *
+ * abort_fused_io() builds an abort command and submits it via
+ * dm_execute_dmub_cmd(); with no DC DMUB service the submission fails
+ * silently and the call must not crash.
+ */
+static void dm_test_abort_fused_io_no_dmub_srv(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	struct dmub_cmd_fused_request *req;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	req = kunit_kzalloc(test, sizeof(*req), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, req);
+
+	spin_lock_init(&adev->dm.dmub_lock);
+	ctx->driver_context = adev;
+	ctx->dmub_srv = NULL;
+
+	/* Must not crash. */
+	abort_fused_io(ctx, req);
+}
+
 static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	/* dm_register_dmub_notify_callback() */
 	KUNIT_CASE(dm_test_register_dmub_notify_callback_null_callback),
@@ -930,6 +979,7 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	/* dm_dmub_aux_fused_io_callback() */
 	KUNIT_CASE(dm_test_dmub_aux_fused_io_callback_copies_reply_and_completes),
 	KUNIT_CASE(dm_test_dmub_aux_fused_io_callback_max_ddc_line),
+	KUNIT_CASE(dm_test_dmub_aux_fused_io_callback_null_args),
 	/* dm_get_default_ips_mode() */
 	KUNIT_CASE(dm_test_get_default_ips_mode_dcn35),
 	KUNIT_CASE(dm_test_get_default_ips_mode_dcn351),
@@ -959,6 +1009,8 @@ static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	KUNIT_CASE(dm_test_dmub_sw_init_unsupported_asic),
 	/* dm_init_microcode() */
 	KUNIT_CASE(dm_test_init_microcode_unsupported_asic),
+	/* abort_fused_io() */
+	KUNIT_CASE(dm_test_abort_fused_io_no_dmub_srv),
 	{}
 };
 
-- 
2.43.0

