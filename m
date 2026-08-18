Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C843C61CE2
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C92C10ECE9;
	Tue, 18 Aug 2026 20:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hZSkHS0h";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010045.outbound.protection.outlook.com
 [52.101.193.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3869A10ECDA
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndAnWutr5ayr3dIBTevEWCVjExQ9MoyJZtmPDp+gvAz0+802scdcCgha4Dc3WUHeIsU64FBW8hQslQ0GgsT8wYciZdMJXL2tMkJiaUOgPrdN4wRj66JA/m99LnGxbkUIwbfX5+Z8gb8PXLy4VcBD9endrrrcj096aaNWvCYc9gtHaQSLywe1ex9vmybOXbfbu5o3i4dCYpwGBqfgj37fcnU9BwKoi+wkcADOk1VqqnKxhSxDVCrZtRJ1z0nEL5g2mYbArZAMcpvNwfvFNipiaOKYMjv970j2VPl/dIlGy+JM4sGJCJmAtlR0cWUliuMIlq4QR/TzAN+0au5EB+QPFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f7sEFSwwX7gdxx4tEaA4OwxlpD0F76VvlAic+2yKWA=;
 b=hAiERC1Zqxbz1bQNiZNDmDJE+vRRzoMkVsdT3AtUurtcwV9lzd5vriCvp6HXAKYd4GGMqF7upxK2yQwp3gfNath04Q3nyAnu8zHd00iBSdb8DuNjjIltmhN+pEd/vVhbDsc5/EdG71e71h33Ff0ZU8qO3L4YAdRyfKm5kM6cIU113YJCs6QBM8HvXIV53Y6z6AcKxd67xMGgG6xR9P9Qi+QGJheC3H5oHe7TWK3gqCoQqnCn27NhJz9uIIs4e726oSS91M9NfJdI5bXYMNQKni4Dt1lUOWRrEenckd2VArkNZOMi7NMtcuByjSLSZ1gfPjpokeAiHTzlLRnM6Yu/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f7sEFSwwX7gdxx4tEaA4OwxlpD0F76VvlAic+2yKWA=;
 b=hZSkHS0h1UUZTh/hcUagzzUAynWnwQNrPSAoiHglTFdSXziifzgr+8T7q9XTUVvcRN/6n3LmPLszgBZnsTWEJYzQRaY26WzMBpqanUxXNLLcK6YJ+j1p+scIiMlihej/mt1XKFEIj9i3zlzgJRb2UtV96Pp7XDndK2aX7vF+rKU=
Received: from BN9PR03CA0345.namprd03.prod.outlook.com (2603:10b6:408:f6::20)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:53 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::88) by BN9PR03CA0345.outlook.office365.com
 (2603:10b6:408:f6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:52 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:51 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:51 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 77/82] drm/amd/display: Cover amdgpu_dm_create_i2c
Date: Tue, 18 Aug 2026 16:16:09 -0400
Message-ID: <20260818202139.4172592-78-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 829d2f44-ca61-498b-c1cf-08defd667aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8ZbgsUg1Hkkn1zahavYxFK22rs5VYTrV5+inUHN1pW/mVGnJ16lZYjniQ4yJouxVoibfET5EMqea+sU/ZeMxyFjlVx022XwYAGeSQCEXySiKuS0NJv+av0Re/qaUu/nSfC9PZ02RFGmb3jf35YFfwivRWcbm3VpX9uvsmGu01XNqAlO3W1VyYRmwvIpM+uT0rF827X9JU8FdptagCulnkSeKkXrSNyWSxjgnCIAOvEmp9M0kf/+Pww04tSWomvamRxi6ekyZ7PEnCqKZrZl0T5qzDR52oeuklfmrlaL/L5ScAg2GdJbK9ZfePn630E87K5vnXjJe4/uNsh+NpIP34ltDl0TZI44klX+TtHhYVpcV2unAHyxaW5mNU44eJNZXjC2w4YY9gigsYz0byDLGtvwmtFoelU9BwQQ4LMy9wEOd+cQ2RKkHT3YLDhCSUBzbFFrn6JJJ+KL2jjr6uVTdLWEr6aawsNZU4SanpIDpuqeio2uk6algzzNGFIVRO1rSYfh6occIehpQp6I4utETJbJ4ihiwf+EXsgRa/6xH6Uh0CJcYv44iE46nD9YV8Pmqmhy2Z/1cM/79DbU32AZsWvbIMvFoAk/61SxZ7S0H0gWGWYKIlogdY9L4k+j8L5/aS8IIJRbSh7aflE+DRKToYQBDTXD22bo8I1PgYdAEPXYVmmXVgWprDCnyBUWUgXNskdtj4IaKEsvnnh0rUm8DYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Lvp3v2uT8kAc5F1nHBn48/F9uJCCm03gb+ICg2Qjcaz7x5kGkF9Mejn5WzJ1NhKKCCb0bHW9Tqr6yFKXSMQisJYqd+FE32S4Gb4weDdzeYaQCJVsXtoPV0ZVXNFe5QT6MoIg9KCreZDYltMYeDhb8vsWcG1X7VR9WW3F2B+EluR54eHrxCIdlXoduhtQjUbLfjfEginFA6yMS4P71+dFxAYIo3YGFxdpEAFGWVeMNWPLucp83A9tTe5hvT2IDV0Alvov0cTaL6LjUGn1L/9WkMOHDiYpvSfvc86A+UCpV3fF+HJ0unXdLYUC8NeNTLVEWtNxp3HUCDFkop1x5/9SZhFGk2TPT+63zMd2onwd7mNs5O91Q3UQdl6N7EQ16k77nAh2Z143nJuOU3bmHl8Gppt+sc7Ol1UBn6ma/j8ZjVT5wFk6pI8zKXrIN6o/we1t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:52.3661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 829d2f44-ca61-498b-c1cf-08defd667aed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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

Add KUnit tests for amdgpu_dm_create_i2c() covering the OEM i2c adapter
and the hardware i2c bus creation paths.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  1 +
 .../tests/amdgpu_dm_connector_test.c          | 91 +++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 837ab9cfd35f6..8a35e4df13cbf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3344,6 +3344,7 @@ amdgpu_dm_create_i2c(struct ddc_service *ddc_service, bool oem)
 
 	return i2c;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_create_i2c);
 
 int amdgpu_dm_initialize_hdmi_connector(struct amdgpu_dm_connector *aconnector)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 39b7dda52fb0b..76334fb840d64 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -5841,6 +5841,94 @@ static void dm_test_i2c_xfer_oem_no_device(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_i2c_xfer(&ctx->i2c->base, msgs, 1), -EIO);
 }
 
+/* Fake ddc_service chain for amdgpu_dm_create_i2c() tests. */
+struct dm_test_create_i2c_ctx {
+	struct ddc_service *ddc;
+	struct amdgpu_device *adev;
+	struct pci_dev *pdev;
+	struct dc_link *link;
+};
+
+/*
+ * Build a ddc_service whose dc_context driver_context is an amdgpu_device with
+ * a pci_dev (for the parent device), plus a link used by the hardware-bus name.
+ */
+static struct dm_test_create_i2c_ctx *dm_test_create_i2c_setup(struct kunit *test)
+{
+	struct dm_test_create_i2c_ctx *ctx;
+	struct dc_context *dc_ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->ddc = kunit_kzalloc(test, sizeof(*ctx->ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->ddc);
+	ctx->adev = kunit_kzalloc(test, sizeof(*ctx->adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->adev);
+	ctx->pdev = kunit_kzalloc(test, sizeof(*ctx->pdev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->pdev);
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_ctx);
+
+	ctx->adev->pdev = ctx->pdev;
+	dc_ctx->driver_context = ctx->adev;
+	ctx->ddc->ctx = dc_ctx;
+	ctx->ddc->link = ctx->link;
+
+	return ctx;
+}
+
+/**
+ * dm_test_create_i2c_oem - Test the OEM adapter name and wiring
+ * @test: The KUnit test context
+ *
+ * The OEM adapter is named for the OEM bus and is wired to the dm i2c
+ * algorithm, the backing ddc_service, and the pci parent device.
+ */
+static void dm_test_create_i2c_oem(struct kunit *test)
+{
+	struct dm_test_create_i2c_ctx *ctx = dm_test_create_i2c_setup(test);
+	struct amdgpu_i2c_adapter *i2c;
+
+	i2c = amdgpu_dm_create_i2c(ctx->ddc, true);
+	KUNIT_ASSERT_NOT_NULL(test, i2c);
+
+	KUNIT_EXPECT_TRUE(test, i2c->oem);
+	KUNIT_EXPECT_PTR_EQ(test, i2c->ddc_service, ctx->ddc);
+	KUNIT_EXPECT_PTR_EQ(test, i2c_get_adapdata(&i2c->base), i2c);
+	KUNIT_EXPECT_PTR_EQ(test, i2c->base.dev.parent, &ctx->adev->pdev->dev);
+	KUNIT_EXPECT_TRUE(test, i2c->base.algo->master_xfer == amdgpu_dm_i2c_xfer);
+	KUNIT_EXPECT_TRUE(test, i2c->base.algo->functionality == amdgpu_dm_i2c_func);
+	KUNIT_EXPECT_STREQ(test, i2c->base.name, "AMDGPU DM i2c OEM bus");
+
+	kfree(i2c);
+}
+
+/**
+ * dm_test_create_i2c_hw_bus - Test the hardware bus adapter name carries the index
+ * @test: The KUnit test context
+ *
+ * The non-OEM adapter is named for the hardware bus and embeds the link index,
+ * and the OEM flag is left clear.
+ */
+static void dm_test_create_i2c_hw_bus(struct kunit *test)
+{
+	struct dm_test_create_i2c_ctx *ctx = dm_test_create_i2c_setup(test);
+	struct amdgpu_i2c_adapter *i2c;
+
+	ctx->link->link_index = 7;
+
+	i2c = amdgpu_dm_create_i2c(ctx->ddc, false);
+	KUNIT_ASSERT_NOT_NULL(test, i2c);
+
+	KUNIT_EXPECT_FALSE(test, i2c->oem);
+	KUNIT_EXPECT_PTR_EQ(test, i2c->ddc_service, ctx->ddc);
+	KUNIT_EXPECT_STREQ(test, i2c->base.name, "AMDGPU DM i2c hw bus 7");
+
+	kfree(i2c);
+}
+
 /**
  * dm_test_get_amd_vsdb_unsupported - Test a zero VSDB version reports no support
  * @test: The KUnit test context
@@ -8594,6 +8682,9 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_i2c_xfer_no_ddc_pin),
 	KUNIT_CASE(dm_test_i2c_xfer_hw_submit_fails),
 	KUNIT_CASE(dm_test_i2c_xfer_oem_no_device),
+	/* amdgpu_dm_create_i2c */
+	KUNIT_CASE(dm_test_create_i2c_oem),
+	KUNIT_CASE(dm_test_create_i2c_hw_bus),
 	/* get_amd_vsdb */
 	KUNIT_CASE(dm_test_get_amd_vsdb_unsupported),
 	KUNIT_CASE(dm_test_get_amd_vsdb_supported),
-- 
2.43.0

