Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6B5C5DF86
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2929210ECB8;
	Tue, 18 Aug 2026 20:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iygQbN/6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC22C10ECB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBzaSqddDZXKxAclHcRrY2OBlT8s7hUJ5QxMERVKNVBO8sIBJ/0f8CcnoJtaARRG5TffMp92fGerjriC2aPJKNz/DovlKQO5pT/TH5O+ZZ5PmnfBJnfSqa9QvZfHd/N8vxr9sg4rSLDGWVJ6RsnB4NiXCaj+YnF00P1h3vEVaCdt5F5RCEuWiZl0w919KIcCZrkwnMoV1w0AXslD3hTHp0juZGLnJNQqreZLTR2ATOsOETaW0t1hvY2g/xbv9AsAM/ViHgubBCyURi7dwAyay72A+EjNoTA/7Wj/plOAeCNw20jaTFKvOR6b2b4DPt003uzKB/OF9y6qnPP3PN+yZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZwOHfHYXlWrFQCgKeCkjTTwqoKZOuu1/1vmb960ThQ=;
 b=LNVblPQ8znIna0guE29bwQuea/+wMrlSKre/iKuwckMVL8yrrw1bZs9uGzF97matApX4yFZz3YK1XgV2Wk8nbi/yA9AYBwOkdXNJEg21FUc83IReDqdcBmGffM2/52Et6EqNA2A1Ai54vdiVe9InadSeHd+wInk20AItfMT82D1qB/r6W+geaBLUWlKGe5PXo3AvAzRVr1rYt2hO0sPxzLhb0kMeQUPSGj+E51EPhcWOPDXPrYj8JWby3puNn/gzE03bNMn3CLVyRLz7bCge7CrKUKD4uYkdjOQjySik8SLXkTnZB3L9eF0SUf/0lcIkAwGOzbjYlm6F8dIvq4PstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZwOHfHYXlWrFQCgKeCkjTTwqoKZOuu1/1vmb960ThQ=;
 b=iygQbN/6B2c+VDBDppKXvPbuXNkzeAn+hU19RSy8j7/KcVcdexQBEqvekKBGhMJJmMPrVjBh5jRYu3HwBuxbbeSeY8J3niXqfXrYpBQVU/7dmvaMjTWX1E5JvYIbM3VyFJQ/oLzNbYYjbAvN7PV38oxAs/Jp5xLrIbBqrJwFibI=
Received: from BN9PR03CA0566.namprd03.prod.outlook.com (2603:10b6:408:138::31)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:39 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::9c) by BN9PR03CA0566.outlook.office365.com
 (2603:10b6:408:138::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:39 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:20 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:19 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 37/82] drm/amd/display: Cover amdgpu_dm_connector_mode_valid
Date: Tue, 18 Aug 2026 16:15:29 -0400
Message-ID: <20260818202139.4172592-38-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a4a82c-86c4-48e4-58be-08defd667367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|22082099003|56012099006|10067099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: DbDSITVpTxuPe8tQ9QfTXedKfEGZrknzubVI2kdtJIyjsQnHtTp8w1Fx0Efv1VPllBrUBjMGPy0CiNhbeVpfvhGHtxsbEmWo0zX8PLA7hqPqnSPKuEB16t5o4egtKo3CtZUnkn6aUFRUE1AMs2TjHoPd+eFG0UZG94igPGB06uACWBtyetijphoMar/Uqycue1i36v2CBjDsew2D8383OeX/B6uZoEREEdA33lVQ9weuwTykJENDqM7Va0PDnokgs5Ov1Ig+GzbTNi4WjF6vP/Bx6H+gLWa0DNgpYWBGFR2Nos9ycn9WRuAE87iUTSLHl6hUmfnrDq4CEbcepezFkFaj2s+KE59vq8FOEiKFoa3lQUP7ngDD6wT0f51OEXE4f58z7gU/NuAGNkhTU0kQxqRiuwTAZSYgL4odDKO774ZhW/lE1u05i8GEtwWi070Ui6aTR9/M5cDmva0S6uMBOn16hXKvSlTC0bubZbsCTUryk09s8v7NIbjdYpC28RNgnTk5zuVu0mE5hvyssnQt8pSUuk+s7EPLVg6I4uam+EOabWVxJlU5/6ah2XJW95aYVrgMJci3pxbQ14+zT/hrBOpNFtJ8o/01l8usg/U9WvoAJBnWCGoSPeLUoeh1iomrE/gIoJjs26/NZf3gmMIil8he08uZUEr00GwW72OctMFiZL9aB7KIoqodj3GfEeNPGNwAJkxpMQzM3DTCSh79uQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pSwEi9AFGrGcNi7zTLdff9o8ha718dzUevQ+P++NF29Ojv6tMdMvwjKQS1Fs/XNmTjXsN/Fsk/lRRCgK9dUPvBAPcaE3lawkYQGDKyrLGK9oXQQfXO2zoqdkGGyGh/wyZZXzLdJ8yluKNbf5k5enkabDIISy7ke2jog8N+1B1JG7jp5ubSCT+VUVOn/fPTXszBQl2gNHnq4T8AY9zOFUCplQ+ekntINF/3Gz6lkRa0N/iEwlkf263/NjO1P8wGJinUCKu85pBGP5rDr2oBVdp8JjOlfLLSSFzbXLdyLsbZPjAThNfqOOB1PsMqcTUii/Hummlk0NHAZh03xpFNGtapwl69PY7ligkYUJxCkMlD/yJEXhf88+W29bqHeCopc504saZig0ywU+K2/K8JDzpD7NDJAi3I/iOusZ1ewX802jllL4NYZhnoV/ZydpEecg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:39.7401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a4a82c-86c4-48e4-58be-08defd667367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Add KUnit tests for amdgpu_dm_connector_mode_valid() covering the
missing dc_sink path and a forced-on connector that fails to create a
validation stream.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index b9b32194a657f..23b83bbde73fd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4161,7 +4161,7 @@ static const u8 dm_test_detect_tile_edid[256] = {
  *
  * A sink whose panel patch requests disable_second_tile combined with a tiled
  * EDID at a non-origin tile location makes the detect path hide the secondary
- * Apple Studio Display tile, reporting the connector as disconnected.
+ * display tile, reporting the connector as disconnected.
  */
 static void dm_test_detect_hides_secondary_tile(struct kunit *test)
 {
@@ -6262,6 +6262,65 @@ static void dm_test_create_validate_stream_prune_context(struct kunit *test)
 								    NULL));
 }
 
+/* Further tests for amdgpu_dm_connector_mode_valid() */
+
+/**
+ * dm_test_mode_valid_no_dc_sink - Test the missing-sink rejection
+ * @test: The KUnit test context
+ *
+ * With no dc_sink and an unforced connector there is nothing to validate
+ * against, so mode_valid() logs and returns MODE_ERROR without reaching stream
+ * creation.
+ */
+static void dm_test_mode_valid_no_dc_sink(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector =
+		dm_test_add_connector(test, drm, DRM_MODE_CONNECTOR_HDMIA);
+	struct drm_display_mode *mode;
+
+	mode = kunit_kzalloc(test, sizeof(*mode), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_connector_mode_valid(&aconnector->base, mode),
+			MODE_ERROR);
+}
+
+/**
+ * dm_test_mode_valid_force_on_no_stream - Test the forced no-stream rejection
+ * @test: The KUnit test context
+ *
+ * A forced-on connector with dc_em_sink already set skips the EDID refresh and
+ * the missing-sink bail, reaching stream creation; with no validatable depth no
+ * stream is produced, so mode_valid() returns MODE_ERROR.
+ */
+static void dm_test_mode_valid_force_on_no_stream(struct kunit *test)
+{
+	struct dm_test_cvs_ctx *ctx =
+		dm_test_cvs_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct dc_sink *em_sink;
+
+	em_sink = kunit_kzalloc(test, sizeof(*em_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, em_sink);
+
+	ctx->link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	ctx->aconnector->dc_em_sink = em_sink;
+	ctx->aconnector->base.force = DRM_FORCE_ON;
+
+	/* drm_connector_cleanup() kfree()s connector->state, so it must not
+	 * point at KUnit-managed memory.
+	 */
+	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
+	ctx->aconnector->base.state->max_requested_bpc = 4;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_connector_mode_valid(&ctx->aconnector->base,
+						       ctx->mode),
+			MODE_ERROR);
+}
+
 /**
  * dm_test_update_after_detect_mst_noop - Test MST connectors are left to drm_mst
  * @test: The KUnit test context
@@ -7117,6 +7176,8 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* amdgpu_dm_connector_mode_valid */
 	KUNIT_CASE(dm_test_mode_valid_interlace_rejected),
 	KUNIT_CASE(dm_test_mode_valid_dblscan_rejected),
+	KUNIT_CASE(dm_test_mode_valid_no_dc_sink),
+	KUNIT_CASE(dm_test_mode_valid_force_on_no_stream),
 	/* amdgpu_dm_hdmi_cec_set_edid */
 	KUNIT_CASE(dm_test_hdmi_cec_set_edid_no_notifier),
 	/* amdgpu_dm_s3_handle_hdmi_cec */
-- 
2.43.0

