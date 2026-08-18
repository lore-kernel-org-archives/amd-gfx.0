Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB59C5DF97
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 418B510ECBF;
	Tue, 18 Aug 2026 20:22:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5fS0czhl";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9205210ECC3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihadX46Bc8d/Q+cNNTOAYsfrJuxFAuazkiKt0oNwQiTgIgFzVHf+NfiOVossULzRBpc3ohifgD9GLgRsK6iFyksrk6Jf/qQzaQBe/RRsYoYwmZ1IRQgYkwgJ1fBSGBIzJac4uhVQ6uco5sOI2v2E1roZR3SVXqT/v1P657MANm36ubHjvxvbJ/SYrB0eOILxjTqGMZN/PibEzj540HuOgSUeJIuNrQYNOwX3j7HWtV2AHAkmblaQQbbX7SoIeWPiGIAM7BmaAzl79NT+q3iP2skkD7n/sbk2BflolrdwvGJYCUN+mqsAjKQb74woKMA94KHBioYrv3tWGDylk/w7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ml1PGtGjHdYwdkCALAruJvjhVqWql/Szpd9Fl5Vzjhs=;
 b=makr6NXWd22LtsQbEmIKE+IiiTeAJddzpCNuEew7ncgNJYdxDwSATDEUELn78JNLYX+AwdW+vsz79azQ26EcaTLPyfRNqz/ipD+ptepTfhYeh7mvYq3ncyYhNmchK89tcvxiNgO32W4dyBsuPmUbheW1GaGr4KEl3C4biI4OQVQA1cU78SMd0V5WhRToSS3ZUhq4NTgIJCs/Ozfl/RaPCvkdHW7NUIfFcvZVILVpMNex4rTySpRMZLsbziy9PO6k/SqI5qpaFRXVDUOMyufr8oCanXnS/zWOGabXiPfY78IZakThZgWNaheXcw7+VcDKPELFYM9bs8ppD3uH+YTlbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ml1PGtGjHdYwdkCALAruJvjhVqWql/Szpd9Fl5Vzjhs=;
 b=5fS0czhlARZpgV/G03n6f6DjGpemTpQRlaJbW34vs0NhRtIRRajoKdCXJgfpBnwHAZfvf8XrfTFlfEKaeS607F8CfC4YmnyQ4P76IPsUJsLRWoID6bOW1XeQem0m0QUIxcdHaAP4DYYnbrHyADRQDSqxl2bvRN/5pJy4jfbnnLY=
Received: from BN9PR03CA0560.namprd03.prod.outlook.com (2603:10b6:408:138::25)
 by CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:44 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::11) by BN9PR03CA0560.outlook.office365.com
 (2603:10b6:408:138::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:34 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:33 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 57/82] drm/amd/display: Cover funcs_force valid EDID path
Date: Tue, 18 Aug 2026 16:15:49 -0400
Message-ID: <20260818202139.4172592-58-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CY5PR12MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f18b5d-810d-4147-44e9-08defd66760f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|3023799007|56012099006|10067099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: RnZrTCKpPeKVV6CGS1xM9i+bFmfyl2lI3dapSlEEoFMYr4uCtKFkEjtjwuHUE34gLeXsA2qkDIuQVGMkQbncQtqZ/TxD5vQ34KIyYnxcrTDduzhyxlHKT2eMqyT+v6AK8OCZRw/a3cfx6gkVfvv0c2Tz4inrw5fQ6EU3665oKBWNysdmp6mtaPhl/QeoldpV0sM+peyWlqWNCquBQh+JnkH860SbpoZQdVNOfA5Ew7FVG7l+A9iscVjvOKzEPQcjle4x/+iTxdRgz5M7IgpE117nqUyp2DXXd0zQmflSx2hwGG8f4rfRorLiaVrjCE75XHoAdKHNI2/TRNoeosojcyjuG8BbHb7HaimVpvPv6RC/1ycjFQdKptTO/FVcycVRK0TanbTX2dnG9jUzW/rJa61pk/qYk7+q3Qcy+fGkqqnLUk9GgRkCOVfC5+XzYT9i2605isSg1j2r9XvjvercSm98iMRe5CK1sr0bHEOKBTam/ptUvVaODTeUZtvx47zCMPqSwcS1hODQ5sHVHqHaoZiZLy3G8PtzUDXM00CPd+KURkWcnu9s7PxC9FywoCeQuh3RRx0wTuuw88lvxZZLqxcsng2f0IK6tGDoauEITDEjKFkjt1gFNqfJjLBiVxblYTjxHVUJOLmsSv9IrBdb3R4qfy9O+wzgGmgpJNYRnzPBrbtXt1tHW2Qy2UWkHjtL5PF/vuA1/KOem7TGIMmTbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(3023799007)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X2ZbgXDr6ob2VmRmwxwFQGLhHWUHLkVEgVJqp/bLoj2MyDPFCiEM8H+Z9HXp1ZUVWCO/zB4pBSuovIupz5B1zlIQWBqGJunjN/Xsaba+/Rlwi+QqIJChARZWk2oi95udUxsmxgZs9uRLM/1qbSvP1JWed5ayvO+wOHeSvz1F2Ng63hXAoKT8WVwtm741xjfRYrghv3V+Wc3MbswsKV7CZg2efO3i2JSTz8XeWtIecHcyvc8xtnsnbc8JAqBh0rfPCgpcFPWhx8smfaNRG4jAo/bQ0SI66ha5TGA2SckSEZ8mcLjqe9uJMrD3CVS5W97hHIme4tnQW9CVKajsr2pEBMvxJs+30zo19URu04pUg3PGXHnWFaK/spr/uz2uizNJPKNm9luKeoZZSQeEWeeyF0UZCCvS8GW4MlA9nF/JWV3GNmMqfGSPU3inktyc02de
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:44.1949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f18b5d-810d-4147-44e9-08defd66760f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6155
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

Add a KUnit test that drives amdgpu_dm_connector_funcs_force() through
the valid-EDID branch: a fake i2c adapter serves a valid EDID over the
DDC read protocol so the connector caches drm_edid and, with an emulated
sink and dc_link present, copies the raw EDID into the sink and parses
its caps.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../tests/amdgpu_dm_connector_test.c          | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index f7ea6aa801bc8..3a5edf84fbc0a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -7077,6 +7077,100 @@ static void dm_test_update_after_detect_force_em_keep(struct kunit *test)
 	KUNIT_EXPECT_PTR_EQ(test, ctx->aconnector->dc_sink, dc_sink);
 }
 
+/* Tests for amdgpu_dm_connector_funcs_force() with a valid EDID */
+
+/*
+ * Fake i2c adapter that serves dm_test_uad_edid over the DDC read protocol
+ * drm_do_probe_ddc_edid() uses: a one-byte write to DDC_ADDR (0x50) sets the
+ * block offset and the following read returns bytes from that offset. This
+ * lets amdgpu_dm_connector_funcs_force() obtain a valid EDID without hardware.
+ */
+static int dm_test_force_edid_i2c_xfer(struct i2c_adapter *adap,
+				       struct i2c_msg *msgs, int num)
+{
+	u8 offset = 0;
+	int i;
+
+	for (i = 0; i < num; i++) {
+		if (msgs[i].flags & I2C_M_RD) {
+			size_t len = msgs[i].len;
+
+			if (offset >= sizeof(dm_test_uad_edid))
+				len = 0;
+			else if (len > sizeof(dm_test_uad_edid) - offset)
+				len = sizeof(dm_test_uad_edid) - offset;
+			memcpy(msgs[i].buf, dm_test_uad_edid + offset, len);
+		} else if (msgs[i].addr == 0x50 && msgs[i].len >= 1) {
+			offset = msgs[i].buf[0];
+		}
+	}
+
+	return num;
+}
+
+static u32 dm_test_force_edid_i2c_func(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_I2C;
+}
+
+static const struct i2c_algorithm dm_test_force_edid_i2c_algo = {
+	.master_xfer = dm_test_force_edid_i2c_xfer,
+	.functionality = dm_test_force_edid_i2c_func,
+};
+
+static void dm_test_force_edid_lock_bus(struct i2c_adapter *adap, unsigned int flags) {}
+static int dm_test_force_edid_trylock_bus(struct i2c_adapter *adap, unsigned int flags)
+{
+	return 1;
+}
+static void dm_test_force_edid_unlock_bus(struct i2c_adapter *adap, unsigned int flags) {}
+
+static const struct i2c_lock_operations dm_test_force_edid_lock_ops = {
+	.lock_bus = dm_test_force_edid_lock_bus,
+	.trylock_bus = dm_test_force_edid_trylock_bus,
+	.unlock_bus = dm_test_force_edid_unlock_bus,
+};
+
+/**
+ * dm_test_funcs_force_reads_edid - Test force() caches EDID and updates em_sink
+ * @test: The KUnit test context
+ *
+ * A non-AUX link selects the connector's i2c adapter, which serves a valid
+ * EDID. force() must cache it in drm_edid and, because an emulated sink and a
+ * dc_link are present, copy the raw EDID into the sink and parse its caps.
+ */
+static void dm_test_funcs_force_reads_edid(struct kunit *test)
+{
+	struct dm_test_edid_ctx *ctx =
+		dm_test_edid_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+	struct amdgpu_i2c_adapter *i2c;
+	struct dc_sink *em_sink;
+
+	i2c = kunit_kzalloc(test, sizeof(*i2c), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, i2c);
+	i2c->base.algo = &dm_test_force_edid_i2c_algo;
+	i2c->base.lock_ops = &dm_test_force_edid_lock_ops;
+	ctx->aconnector->i2c = i2c;
+
+	em_sink = kunit_kzalloc(test, sizeof(*em_sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, em_sink);
+	ctx->aconnector->dc_em_sink = em_sink;
+
+	/* Non-AUX link picks the i2c adapter; force-on skips the DDC probe. */
+	ctx->link->aux_mode = false;
+	ctx->link->priv = ctx->aconnector;
+	ctx->aconnector->base.force = DRM_FORCE_ON;
+
+	amdgpu_dm_connector_funcs_force(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_NOT_NULL(test, ctx->aconnector->drm_edid);
+	KUNIT_EXPECT_MEMEQ(test, em_sink->dc_edid.raw_edid,
+			   dm_test_uad_edid, sizeof(dm_test_uad_edid));
+
+	drm_edid_free(ctx->aconnector->drm_edid);
+	ctx->aconnector->drm_edid = NULL;
+}
+
 /* Tests for amdgpu_dm_update_stream_scaling_settings() */
 
 /**
@@ -7539,6 +7633,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_handle_edid_mgmt_non_dp_leaves_caps),
 	/* amdgpu_dm_connector_funcs_force */
 	KUNIT_CASE(dm_test_funcs_force_no_edid),
+	KUNIT_CASE(dm_test_funcs_force_reads_edid),
 	/* dm_validate_stream_and_context */
 	KUNIT_CASE(dm_test_validate_stream_null_stream),
 	KUNIT_CASE(dm_test_validate_stream_dc_ok_no_pipe),
-- 
2.43.0

