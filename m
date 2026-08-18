Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E369C5DF9B
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53DC10ECD7;
	Tue, 18 Aug 2026 20:23:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N7PQU+Pp";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012057.outbound.protection.outlook.com
 [40.93.195.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CCBE10ECCD
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOpfjkhHToLVzZvXfFYUYWGF8U837/3g64eGE7TQ3vNKDPy1soHoPiREgRbct7iKHizck/PIpKG8jHpnAsqX3ANBzY7r9tCHX/1bnZrJ7MMYhs0OOIUlCb6K82LCc8v4gr8TXm4pMtKqztD4Uxk07gD/Jr0HzG3e4vy8jQEzq3etUTd/O+FKmv3p8Q1bxzrKc8q/9ytKdtr3jonWqggzMerjay1Z2/SbR5N8go/mc9U5ra5UdTPF3P3yTC6/OC6fl8a89uQVIzZgVOOonG/Mzoko9ARnj9zH0k2247cHfioqq8EIZU3P/6Qd7OQhZXxW0YyOecwtuFvf4Wy7+XigRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fhdLqSL1Mh9INt8x2QCZVVKfxwvyS7VAHJM7xJOAGk=;
 b=sVmsCIUAh9dAp4PT4x3ocTV3DoQ0GegfJVuzsZ79nnOuzU3gJtSn2crxHjn+EeiXh20MVAgwDWRNj6Mtn5tCfxdp0e5xVnoKc/cEQ4HATs5zdD2lu9dw8bRd7kI8KFCeDzYdvHZCrP6/HxR3YNqKyTISV7RXge8uSiErXu2aN2uRhKaOyJfiYvW0t7i2oanrevOdfaNjuWsiCIDAJU2wZuVzU7VIskRT6RPx14UviWPjsszUnLpFEfX7iO9Itn9bcby/+tPfR5MFyqWRLBFEK7ddCxJz4YtbEEJigX2tnOEc/n83LhuvPsmuLT9yPbAqO9cTKeZQtfP37hQoJ9eU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fhdLqSL1Mh9INt8x2QCZVVKfxwvyS7VAHJM7xJOAGk=;
 b=N7PQU+PpzDxtDkEhLjL6wMt5GNj+6nmTlTudZh2SipDM4fZfoYQSmhRkZkk5kJ0YRSURkZvLI+RbFAyUmmOZzqazY1GCPfw2wH2iOL5N0kDdic9NT38pytQRsZcLDxxNx75xwQ7SZaRdo6GUkK581tRBCnJ2s7RuSVzkKTbcKjg=
Received: from BN9PR03CA0552.namprd03.prod.outlook.com (2603:10b6:408:138::17)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:51 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::32) by BN9PR03CA0552.outlook.office365.com
 (2603:10b6:408:138::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:50 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:50 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 76/82] drm/amd/display: Cover amdgpu_dm_i2c_xfer
Date: Tue, 18 Aug 2026 16:16:08 -0400
Message-ID: <20260818202139.4172592-77-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 6728b01e-0565-4790-76fa-08defd667a61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dHWSweWJBDOegsnK52ZXHVxUctIGGpmU3rov6Ay7jvvPxuR2YmxI/EUD2GgBTL7fpGo/JtrSI8bM9W6VZUeoXLhRjwTL8y6Ysb/9HgemM8H8D+dVK6jUrC+K9Yi9vU0H92YSVzd0HrKR7WrXT3BptXzA+dxMBoCBwZn5Dvioo+li/UdEDpwn8MgOciszdbaCrSbM3isejt/Ygnagn+HH55Tu5LPTsu5mMZvQyye4MXxA21xwemMWles35hwKQt7RfQ+Ts6dNSadnIbyKE4sEIx8sI0PnbiUiBLpxlyRjxtH7SHGdCmmIM54LOMBIaYYNMo1lravK4J5cY6unhXeDQS+jYxgX7yvAnebPH78PkQSZHx4/ri9jwY/FvBOATudxL4PuVxFlRT7t2sa75r2HWNZ0Xi7s10iO6S1CSQKiOuywHLnq42rX+hAhPAp0ia7ENjyk/x/VN9QGnOydkODalCAaVKih2wowiQstPbjXE03XxlDl7t+5lCxoFm43J43EZZZfU0tcnZgiAQtVDGQLYrkGNs8Alg2jMRuICnqeue6/3bC1XkT4WtxRyHTkQ9dcjKdbuuFWmZ9/X10BpCiJqpi0xf0frxfkYhwSqfGLoUgemFEzyPeQJd3hyCbGCxTA071m3ExmkS21OuhFU+nrQpav6nQDYKYGhxoYOioAuAwPDR/2jzNBPiFdEwkPeQzAmA5T1E2XBkXg69YtNzjyiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z/wMn+GJekj4AqzDbeDhgE5pRpg20PvDCI5S/Q1YDdiYAxDKYCQlX3S57EjSJuatixj4WptTtYNymiOVNMZ88MqEsNcSk4omooR+E30a+zm8bHfzqeIRjv4nI2U8wmFRjST9xqc/jCyIZzAv8bkhJo/oVYBN3D/foH6SyH7cRyFuHdGIQSsB9kufU9sBKiZr/MAxZwnXIibWUKMHI0VhMtiGOeqVpIt3C7j1L0jdG9ViB/8dYb503RSW9t5R56n552CeVlMRGKXDhVtCMO+C5IBzBhcdaVB6pwDiyc9ydBudd6+HGhaZTGpOz/vvbvQmHG6atPWS7SwnqVTSi8HikBcgCGlM4Iq8/jq/911xEh9DhJ7xdllGyPEGfxeQqtwNJvWDPEejFnElsaAjht+pjlyeiUOziZspdUVAt3PLbRjUBrsj7+FruWcLymY4Okx3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:51.4443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6728b01e-0565-4790-76fa-08defd667a61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095
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

Add KUnit tests for amdgpu_dm_i2c_xfer() covering a failed hardware
command submission and the OEM i2c path with no device present.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 24f55432e3262..39b7dda52fb0b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -5746,6 +5746,101 @@ static void dm_test_i2c_xfer_no_ddc_pin(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_i2c_xfer(&i2c->base, NULL, 0), -EIO);
 }
 
+/* Fake i2c adapter chain used by the amdgpu_dm_i2c_xfer() tests. */
+struct dm_test_i2c_ctx {
+	struct amdgpu_i2c_adapter *i2c;
+	struct ddc_service *ddc;
+	struct dc_context *dc_ctx;
+	struct dc *dc;
+	struct dc_link *link;
+};
+
+/*
+ * Build an i2c adapter whose ddc_service has a ddc_pin (so the transfer is not
+ * rejected up front) and whose dc back-pointer resolves to a link at index 0.
+ * The link ddc has no ddc_pin, so the non-OEM dc_submit_i2c() path bails out
+ * and reports failure without touching real hardware.
+ */
+static struct dm_test_i2c_ctx *dm_test_i2c_setup(struct kunit *test)
+{
+	struct dm_test_i2c_ctx *ctx;
+	struct ddc_service *link_ddc;
+	struct ddc *pin;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->i2c = kunit_kzalloc(test, sizeof(*ctx->i2c), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->i2c);
+	ctx->ddc = kunit_kzalloc(test, sizeof(*ctx->ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->ddc);
+	ctx->dc_ctx = kunit_kzalloc(test, sizeof(*ctx->dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc_ctx);
+	ctx->dc = kunit_kzalloc(test, sizeof(*ctx->dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc);
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+	pin = kunit_kzalloc(test, sizeof(*pin), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pin);
+	link_ddc = kunit_kzalloc(test, sizeof(*link_ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link_ddc);
+
+	ctx->ddc->ddc_pin = pin;
+	ctx->ddc->ctx = ctx->dc_ctx;
+	ctx->ddc->link = ctx->link;
+	ctx->dc_ctx->dc = ctx->dc;
+	ctx->link->link_index = 0;
+	ctx->link->ddc = link_ddc;
+	ctx->dc->links[0] = ctx->link;
+	ctx->i2c->ddc_service = ctx->ddc;
+	i2c_set_adapdata(&ctx->i2c->base, ctx->i2c);
+
+	return ctx;
+}
+
+/**
+ * dm_test_i2c_xfer_hw_submit_fails - Test the non-OEM path reports a failed submit
+ * @test: The KUnit test context
+ *
+ * With a ddc_pin present the transfer builds the payload list and dispatches
+ * through dc_submit_i2c(); the target link has no ddc_pin, so the submit fails
+ * and the transfer returns -EIO instead of the message count.
+ */
+static void dm_test_i2c_xfer_hw_submit_fails(struct kunit *test)
+{
+	struct dm_test_i2c_ctx *ctx = dm_test_i2c_setup(test);
+	u8 buf[2];
+	struct i2c_msg msgs[] = {
+		{ .addr = 0x50, .flags = I2C_M_RD, .len = sizeof(buf), .buf = buf },
+	};
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_i2c_xfer(&ctx->i2c->base, msgs, 1), -EIO);
+}
+
+/**
+ * dm_test_i2c_xfer_oem_no_device - Test the OEM path with no OEM device fails
+ * @test: The KUnit test context
+ *
+ * When the adapter is flagged as OEM the transfer routes through
+ * dc_submit_i2c_oem(); with no oem_device on the resource pool the submit
+ * fails and the transfer returns -EIO.
+ */
+static void dm_test_i2c_xfer_oem_no_device(struct kunit *test)
+{
+	struct dm_test_i2c_ctx *ctx = dm_test_i2c_setup(test);
+	struct resource_pool *pool;
+	u8 buf[2] = { 0x12, 0x34 };
+	struct i2c_msg msgs[] = {
+		{ .addr = 0x50, .flags = 0, .len = sizeof(buf), .buf = buf },
+	};
+
+	pool = kunit_kzalloc(test, sizeof(*pool), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pool);
+	ctx->dc->res_pool = pool;
+	ctx->i2c->oem = true;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_i2c_xfer(&ctx->i2c->base, msgs, 1), -EIO);
+}
+
 /**
  * dm_test_get_amd_vsdb_unsupported - Test a zero VSDB version reports no support
  * @test: The KUnit test context
@@ -8497,6 +8592,8 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_i2c_func_returns_flags),
 	/* amdgpu_dm_i2c_xfer */
 	KUNIT_CASE(dm_test_i2c_xfer_no_ddc_pin),
+	KUNIT_CASE(dm_test_i2c_xfer_hw_submit_fails),
+	KUNIT_CASE(dm_test_i2c_xfer_oem_no_device),
 	/* get_amd_vsdb */
 	KUNIT_CASE(dm_test_get_amd_vsdb_unsupported),
 	KUNIT_CASE(dm_test_get_amd_vsdb_supported),
-- 
2.43.0

