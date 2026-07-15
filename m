Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95529C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D5510F09F;
	Wed, 15 Jul 2026 13:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1v9ND6al";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013049.outbound.protection.outlook.com
 [40.93.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED9E10F09F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPdIjDNO4csQgfcvoOnFChsOi7bak9XIJ3R2dGKBuD6Yhdk7juAhoa7176rJkgi9BYaUt47xC5l+2IeBVO7aN/wFMFZeP+CgQvJizQv/OijCKJ/SqIdjDEK+bgRg/VWSfQ3LufhLfEktT3425M8E+cME1XIUe+DeCwwFCKHRQ//tAVP9gXWmb2FQHXnbvkRBVC4ruS5VEI/XJrq/mQCbzE6/k7O3p3wxuF7IXiXWjUXEXv1ZnuQjklpQaShjo4CJkmsa3p1OOgv2B85jtbIsYvNGV56akIQ2mM/kD2f4VtWRQVv4AcGCNb9pX8s8GqhfQY8Y3y3ENE0sB05oiNeETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWNxxo3KznQU+/UgCmtpi/XZZ3lHeDidxtSRLeqVSyk=;
 b=YIFtzbwFlEBs/GXXmdTbI7KUG94wSHhfefCJdwt4Bz7Gl6IIHymz8WW/xKarcxYugazFh8PzzKvhfshAWFnifTx/IEjr34BqM5GQvkdEHCvLCY+b2Y5rKwJu0fZZ5bwWVoOEqxn5L4AbQVNLq0idNgiuCDYL5NronTQl7SiG3XOKVF0E3DyOTjCM3KVBhf+unIRnNZNcCj4MdyATdVY+Nfy/c5XlUu6KMMK7U6y2iftdSNOgfvcpeQ0yiRyghzm3MF7tb+4AHc6y5hM9QiFYW1Dt3j4sSjAPEfB7m0IUnJ8UPbv1GKfxYx/gxGg2VP8JQa+dABXy695/yBDbC4rHow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWNxxo3KznQU+/UgCmtpi/XZZ3lHeDidxtSRLeqVSyk=;
 b=1v9ND6al0/l/SDIe09Kh4FbEb390w1lYiz1UFmtyy0HialmJoKsqG4+ivx/jxEZ7xHvnJj3ghtvH8EeboTtPu9ygKdTkGrDox+G1BZeuXsB2AsGKAUc178EWRnMkxi37Ne12TbhA+u5mGj5ylbHhXk8lP5seZe0XpR/kejCf5V0=
Received: from SJ0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:a03:39f::30)
 by CH2PR12MB4104.namprd12.prod.outlook.com (2603:10b6:610:a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:48:16 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::4c) by SJ0PR03CA0235.outlook.office365.com
 (2603:10b6:a03:39f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:48:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 06:47:53 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:50 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 48/70] drm/amd/display: Add stream validation tests for
 connector
Date: Wed, 15 Jul 2026 21:37:58 +0800
Message-ID: <20260715134432.1975118-49-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CH2PR12MB4104:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ff828f-2dc5-445d-b17b-08dee277b870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kpuv69VLTGCii0YKE9caccacDG6yyJF1vm2pIs4+KxPLVsWWUqPvJaIGOI82y1S6YBPjiRb1Z7t3WjVoMfGbaWbZV1r1zev0FGrVpyhT9Y/Qb3HrwrW5mz2gV1EgwaEuXljkHYOBiz0Ax2SDzB4nQ61MLcgXPetJZpf5NS5iHxjI5SBjrqtJ7j4VG8vcspxzyWO+aFAQH0MA4R8JA1nahPDH6jflm617hYF82zqg3GZZtsfrhETCihy4iJOUNFuJc42+qrqRq3eT1MdLnqASAn6LVLavSVuauThuHFfNunLF7VFjAKQlS2SwOPd1OgrI6j1TEvcxZQBMre0f4TBIp6RJ4i4D/vhI2rsLWeKyK1pDDGklYKjdSe4lsQscKRiFk7u8gnbbP+OtP1nxeal9tq9eUhvlmiEzHUSTdHBpOcqLJ/+LKZORoUMRa5k1zUvmr18xpCf7DHzh7VfDdhcLQY9+Nwaf8wFFG0re0F4ozBzOtUFJbR8nCUX7rl92AwZ33fYKWi7Br7726QTrc0K9asjIkWgxQ5ADTT5HC46NAU+Z/xP46nMX01ZtJPs9FS9q52QgBh6JBYtJg878yAn98sszb/VTbpAsrZiEE+mHzjA4V67MNMJ79frBXpSDkS7btXydnRwX6tJ9wGL4FFPs4MIHdYKRuOw7m8gJUsgYDqYALsnM7sNBrqbGW1EgWvh37o5QRssw//ICdPWW+PDpUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 26hx738KVwPxjLB19FzsgKQ1UKX0V2+vBHd9L1vdFoyM1ibazQo7Ck88Gbwl5p80t5AkhU0j23B0MuOOAVCeRJpoCzMzsUy72ww878wX/zy2NIKOTQdEtTbi+K+tyV/UZNJ9UChU/ITnsmXh/ot9vaPMqGGb0+ccnpo1oqjGPqxcJmcH8MjDaKGYNeBAubdr00llhH756U753VyQuE63NzqbsvPNDBQRF67/8eEWFCdkLrdfWaEwgHYIv/7TpGcd0B5jp1G9NmhqpfPnu5RfewabBWKznc4M3Be+k9/VSlPrXE2gOtlDwY6oOYLFM7I2AQqBCp+o6hAzgne9iws65fmIcT4aXQoPlvEeKZbOH48gXs4QshSLWiEQUW2BLtBLeTqMkDUKQu1/9n9xeFu9AU1dojmIeAqfRfnuMbE8IOPYLs+LdX+U29GWoNjG7W6u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:15.5900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ff828f-2dc5-445d-b17b-08dee277b870
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4104
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

Add KUnit coverage for amdgpu_dm_create_validate_stream_for_sink()
and amdgpu_dm_connector_funcs_update_after_detect(): null dm_state,
MST no-op, and unchanged sink handling.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  2 +
 .../tests/amdgpu_dm_connector_test.c          | 68 +++++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 3fa2392549eb..da6ec75bb0f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -650,6 +650,7 @@ void amdgpu_dm_update_connector_after_detect(
 	if (!drm_kms_helper_is_poll_worker())
 		mutex_unlock(&dev->mode_config.mutex);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_update_connector_after_detect);
 
 enum dc_color_depth
 amdgpu_dm_convert_color_depth_from_display_info(const struct drm_connector *connector,
@@ -2203,6 +2204,7 @@ amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
 
 	return stream;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_create_validate_stream_for_sink);
 
 enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connector,
 				   const struct drm_display_mode *mode)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index cfb114d5b879..b58bb2d3309c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -4997,6 +4997,69 @@ static void dm_test_s3_handle_hdmi_cec_resume(struct kunit *test)
 	amdgpu_dm_s3_handle_hdmi_cec(drm, false);
 }
 
+/**
+ * dm_test_create_validate_stream_null_dm_state - Test NULL state returns NULL
+ * @test: The KUnit test context
+ *
+ * Without a connector state there is nothing to validate against, so the
+ * helper bails out with NULL before touching the dc handle.
+ */
+static void dm_test_create_validate_stream_null_dm_state(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	KUNIT_EXPECT_NULL(test,
+			  amdgpu_dm_create_validate_stream_for_sink(&aconnector->base,
+								    NULL, NULL, NULL));
+}
+
+/**
+ * dm_test_update_after_detect_mst_noop - Test MST connectors are left to drm_mst
+ * @test: The KUnit test context
+ *
+ * An MST connector is handled by the drm_mst framework, so the function
+ * returns immediately and never dereferences the (NULL) dc_link.
+ */
+static void dm_test_update_after_detect_mst_noop(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	aconnector->mst_mgr.mst_state = true;
+
+	amdgpu_dm_update_connector_after_detect(aconnector);
+}
+
+/**
+ * dm_test_update_after_detect_sink_unchanged - Test the short-pulse no-op path
+ * @test: The KUnit test context
+ *
+ * When the link reports no local sink and the connector already has no
+ * dc_sink, the "sink didn't change" path returns without touching DC.
+ */
+static void dm_test_update_after_detect_sink_unchanged(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_link *link;
+
+	aconnector = dm_test_add_connector(test, drm, DRM_MODE_CONNECTOR_HDMIA);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	aconnector->dc_link = link;
+
+	/* link->local_sink and aconnector->dc_sink are both NULL. */
+	amdgpu_dm_update_connector_after_detect(aconnector);
+
+	KUNIT_EXPECT_NULL(test, aconnector->dc_sink);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -5271,6 +5334,11 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* amdgpu_dm_s3_handle_hdmi_cec */
 	KUNIT_CASE(dm_test_s3_handle_hdmi_cec_suspend),
 	KUNIT_CASE(dm_test_s3_handle_hdmi_cec_resume),
+	/* amdgpu_dm_create_validate_stream_for_sink */
+	KUNIT_CASE(dm_test_create_validate_stream_null_dm_state),
+	/* amdgpu_dm_update_connector_after_detect */
+	KUNIT_CASE(dm_test_update_after_detect_mst_noop),
+	KUNIT_CASE(dm_test_update_after_detect_sink_unchanged),
 	{}
 };
 
-- 
2.43.0

