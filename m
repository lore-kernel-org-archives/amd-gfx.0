Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E93C5DF93
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25FBE10ECD8;
	Tue, 18 Aug 2026 20:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5dSYI8Fa";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCAC10ECD2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkFf4xVBazsBEtYEokNCUQ0fZWVhL6hc/J9RA0/vRXuVOY5TvrfplQP0t7f88ER3kDz95epqHvxVN57P4hY00/bUnClQm3VvU8Q1Iy1qNes/939wmXVIS/YjYcgvHSU30o16NnJPAThfA0ePhfLVnGFasQUDGVm7PENGmnmmRiBeYJ8QqK4S+/0oRIkStMXIj/8JSfRbzGyT8MZu8+p9WSZgEXWrREPPbAEtV8srmn9GKrjOml1iG0svUfXpd8jlIMfAoP6ir7Ydyfxpcvf50mJvZNndMxq7n9XvTs4EdXW1YnSi2rYFf+srbuI8LD7dtYdcAutNNS43RHHvigrkiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bV8xutFDLmnwCqj0IdEQ7ofcW2ICkcZz5i5qgMCq4LE=;
 b=rvrhIGkk0vjE9f+Eyj4APJ6icff7iC8QtjClyj2odag7suYWr7naXL384hWJ3JZWXXSb1Ozsm1DjFrFenM/AtU8p/FXBOf2/bth4Bt9V1C6r/uSRq61ABec82HgNYIyMqnN7v8g7gSYw8udFxcOMypKPbwOunnsYl1hj5SbQmD2KxggEh5cldVYJVGeTvcYKRdfjp2/XBtU31131FlaCFMd9vL2QvvWLn9BvW/R0cgZ6ONwocAdAZJTCW9+mXrR0b9zdO5Tif4KbVaLcWyyq864kWITTdLd+gLebLQe8SHOwtlLtntNbk0tPGAnWYX/GbP3B75VPbm0B6GW4nClPgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bV8xutFDLmnwCqj0IdEQ7ofcW2ICkcZz5i5qgMCq4LE=;
 b=5dSYI8FaN7T9ELYCH29CmRiZ4jfdKYcUchHn+UJDgcRLbHJDQ9Ns7hRRmh9+LCOT0aeNoKgtjndno3ACTewJqGvbTqcr2NBpYow2HT8CReEtDSQe7k+ab27WXxwmlXooeyIOMv6Qix7tN5opGQb39iQ1ZrlXWEm1ZulHDFtwe6M=
Received: from BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::31)
 by DS0PR12MB8477.namprd12.prod.outlook.com (2603:10b6:8:15b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:48 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::90) by BL1P221CA0024.outlook.office365.com
 (2603:10b6:208:2c5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:45 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:44 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:44 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 68/82] drm/amd/display: Test
 amdgpu_dm_dce110_register_irq_handlers
Date: Tue, 18 Aug 2026 16:16:00 -0400
Message-ID: <20260818202139.4172592-69-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS0PR12MB8477:EE_
X-MS-Office365-Filtering-Correlation-Id: e5beb6df-161f-44e4-e962-08defd667867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: STuL1Wxk6iHRN/1EWIpyNXCPuBHvHQvm2p9N9Wt/vNO2hCaspBkU3pewAR+pS/V0BGTumNkiEinKK4CthYxMTD8VMPO8oZSI/i8BHtqv//KLTFTDUd3hbAk7/XhO5/YGWtFFPAUFi2aDaQlIN1oO2K0xwU0HUumAp7NI5s2cugFappVMNdFx4BR6g11tA8oWMNqt1RTCRJfnIVh5OHYFuFi6lH2sqxvH+JKpL6wjdFN5MkLAwYF2I38VR7BZSD1BYYQ6BFwVkjZfOTYQnN8StxmqI1RnonPEqeXqFP3Bfpsk62G1Sq0z2AZQFB3iADqgRJGVeUa+Dgqqefx5DqlpXBESJa+lrZmejVuHvMZYRGVgOESSD5klYhINHPPx1X4cFOyGZ+DyEQgCivjPTTl6ItXox34Ps8IpjKFBml1joQggff0L9vEMrAIeK2jN6nPSQy1vwQfqv8N6p4KhsSbcPyirm8Q2A18wLoIrfNnJJY75Fx2VwrVidxZ7tkpD4LGeAZ4QWjNEaSPnRP1sPGcgvrexzWHIRtt0eQ8q1ZHAy8C+L+HhBgJ7WcZyXSsc+SrmbrUlzX0DNi3cGMmLPl5dQ6M2GhPSWtm4M4MZW3/RpIa5Ar9AQHTzQAVT6TFEVIYRhQg48Hl1JcD7Sq64pIGvWERBuq2mcviIa7kISzToZyY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X0Qmui42PaaC8NS5gUf7+EmbYtM4eivcVKEI0kV8wbYHIKasJeGHkAPjA4pNOaT0MN79iT46cYASbCN6lfArbwX+1Z6wGhPSU9mNQ7s6bp7sxywFkGNVfyVqa5KRRw8ZKA6UWjCeRKMOtFJd0kM+6hWkmdniAA/w3jKgeJ/uPIErhiySKRKLLOSgpZzjFFXriGTzzxi75VpAaBfl9WjwKrZRtnkMu2QeGloTdUHwXuMmmfpqW9SccycO4PmCuriMBgrXeGM0I7pX0vYYUQazSR42plEFTaZR6xlh+Stae9f+ajt0yy07v8TJDsq3eFqlZBfFcS9teYpNjlfruHaN+BMxWKqX2s0gVXz14kw8a8ToO8ev/aK+3+ZcnFjt7OgjYb8mO5sPAINUTjQ6YIDIPw30DAMX1V60UaheVvO7zJHsa9P945rEADL8TjXcMi5C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:48.1324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5beb6df-161f-44e4-e962-08defd667867
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8477
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
Add KUnit tests for amdgpu_dm_dce110_register_irq_handlers() covering
the SOC15 DCE client used from Vega on, the amdgpu_irq_add_id()
rejections for the CRTC, VUPDATE and HPD sources, and the
invalid-source guards in the VBLANK, VUPDATE and PFLIP loops.

[HOW]
Add three fake IRQ services that map only a prefix of the source IDs so
each loop reaches its guard in turn. Clearing a single amdgpu_irq_src's
funcs makes only that source's add_id() fail.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 196 ++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 933a33a360fbe..a354fa25998f7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -276,6 +276,55 @@ static const struct irq_service_funcs dm_test_irq_service_funcs_dce110 = {
 	.to_dal_irq_source = dm_test_to_dal_irq_source_dce110
 };
 
+/* Maps nothing, so the first (VBLANK) register loop sees an invalid source. */
+static enum dc_irq_source dm_test_to_dal_irq_source_unmapped(
+		struct irq_service *irq_service,
+		uint32_t src_id,
+		uint32_t ext_id)
+{
+	return DC_IRQ_SOURCE_INVALID;
+}
+
+static const struct irq_service_funcs dm_test_irq_service_funcs_unmapped = {
+	.to_dal_irq_source = dm_test_to_dal_irq_source_unmapped
+};
+
+/* Maps VBLANK only, so the VUPDATE register loop sees an invalid source. */
+static enum dc_irq_source dm_test_to_dal_irq_source_vblank_only(
+		struct irq_service *irq_service,
+		uint32_t src_id,
+		uint32_t ext_id)
+{
+	if (src_id == VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0)
+		return DC_IRQ_SOURCE_VBLANK1;
+
+	return DC_IRQ_SOURCE_INVALID;
+}
+
+static const struct irq_service_funcs dm_test_irq_service_funcs_vblank_only = {
+	.to_dal_irq_source = dm_test_to_dal_irq_source_vblank_only
+};
+
+/* Maps everything but PFLIP, so the PFLIP register loop sees an invalid source. */
+static enum dc_irq_source dm_test_to_dal_irq_source_no_pflip(
+		struct irq_service *irq_service,
+		uint32_t src_id,
+		uint32_t ext_id)
+{
+	switch (src_id) {
+	case VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0:
+		return DC_IRQ_SOURCE_VBLANK1;
+	case VISLANDS30_IV_SRCID_D1_V_UPDATE_INT:
+		return DC_IRQ_SOURCE_VUPDATE1;
+	default:
+		return DC_IRQ_SOURCE_INVALID;
+	}
+}
+
+static const struct irq_service_funcs dm_test_irq_service_funcs_no_pflip = {
+	.to_dal_irq_source = dm_test_to_dal_irq_source_no_pflip
+};
+
 static enum dc_irq_source dm_test_to_dal_irq_source_dcn10(
 		struct irq_service *irq_service,
 		uint32_t src_id,
@@ -4266,6 +4315,146 @@ static void dm_test_dce110_register_irq_handlers_one_crtc(struct kunit *test)
 	amdgpu_dm_irq_fini(adev);
 }
 
+/**
+ * dm_test_dce110_register_irq_handlers_soc15_client - Test DCE110 on AI+ ASICs
+ * @test: The KUnit test context
+ *
+ * From Vega on, the DCE interrupts are routed through the SOC15 DCE client
+ * rather than the legacy one, so the IRQ sources must be registered there.
+ */
+static void dm_test_dce110_register_irq_handlers_soc15_client(struct kunit *test)
+{
+	struct amdgpu_irq_src **soc15_sources;
+	struct amdgpu_device *adev;
+
+	adev = dm_test_setup_irq_regs(test, &dm_test_irq_service_funcs_dce110);
+	adev->family = AMDGPU_FAMILY_AI;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), 0);
+
+	KUNIT_EXPECT_NULL(test, adev->irq.client[AMDGPU_IRQ_CLIENTID_LEGACY].sources);
+	soc15_sources = adev->irq.client[SOC15_IH_CLIENTID_DCE].sources;
+	KUNIT_ASSERT_NOT_NULL(test, soc15_sources);
+	KUNIT_EXPECT_PTR_EQ(test,
+			    soc15_sources[VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0],
+			    &adev->crtc_irq);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_dce110_register_irq_handlers_crtc_add_id_fails - Test add-id failure
+ * @test: The KUnit test context
+ *
+ * amdgpu_irq_add_id() rejects a source with no funcs table, so registering the
+ * VBLANK interrupt before amdgpu_dm_set_irq_funcs() has run must fail.
+ */
+static void dm_test_dce110_register_irq_handlers_crtc_add_id_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	dc = dm_test_alloc_dc_with_irq_service(test, &dm_test_irq_service_funcs_dce110);
+	dc->ctx->dce_version = DCE_VERSION_11_0;
+	adev->dm.dc = dc;
+	adev->mode_info.num_crtc = 1;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), -EINVAL);
+}
+
+/**
+ * dm_test_dce110_register_irq_handlers_bad_vblank_source - Test VBLANK guard
+ * @test: The KUnit test context
+ *
+ * A source ID that DC does not map to a VBLANK IRQ source must be rejected
+ * rather than used to index the vblank parameter array.
+ */
+static void dm_test_dce110_register_irq_handlers_bad_vblank_source(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_test_setup_irq_regs(test, &dm_test_irq_service_funcs_unmapped);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), -EINVAL);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_dce110_register_irq_handlers_bad_vupdate_source - Test VUPDATE guard
+ * @test: The KUnit test context
+ *
+ * With VBLANK mapped but VUPDATE unmapped, registration must fail once the
+ * VUPDATE loop sees the invalid source.
+ */
+static void dm_test_dce110_register_irq_handlers_bad_vupdate_source(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_test_setup_irq_regs(test, &dm_test_irq_service_funcs_vblank_only);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), -EINVAL);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_dce110_register_irq_handlers_bad_pflip_source - Test PFLIP guard
+ * @test: The KUnit test context
+ *
+ * With VBLANK and VUPDATE mapped but PFLIP unmapped, registration must fail
+ * once the pageflip loop sees the invalid source.
+ */
+static void dm_test_dce110_register_irq_handlers_bad_pflip_source(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_test_setup_irq_regs(test, &dm_test_irq_service_funcs_no_pflip);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), -EINVAL);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_dce110_register_irq_handlers_vupdate_add_id_fails - Test add-id failure
+ * @test: The KUnit test context
+ *
+ * The VBLANK loop succeeds, then a VUPDATE source with no funcs table is
+ * rejected by amdgpu_irq_add_id().
+ */
+static void dm_test_dce110_register_irq_handlers_vupdate_add_id_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_test_setup_irq_regs(test, &dm_test_irq_service_funcs_dce110);
+	adev->vupdate_irq.funcs = NULL;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), -EINVAL);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
+/**
+ * dm_test_dce110_register_irq_handlers_hpd_add_id_fails - Test HPD add-id failure
+ * @test: The KUnit test context
+ *
+ * All three per-CRTC loops succeed, then the HPD source with no funcs table is
+ * rejected by amdgpu_irq_add_id().
+ */
+static void dm_test_dce110_register_irq_handlers_hpd_add_id_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = dm_test_setup_irq_regs(test, &dm_test_irq_service_funcs_dce110);
+	adev->hpd_irq.funcs = NULL;
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_dce110_register_irq_handlers(adev), -EINVAL);
+
+	amdgpu_dm_irq_fini(adev);
+}
+
 /**
  * dm_test_dcn10_register_irq_handlers_zero_crtc - Test DCN10 zero-CRTC registration
  * @test: The KUnit test context
@@ -4673,6 +4862,13 @@ static struct kunit_case amdgpu_dm_irq_tests[] = {
 	/* IRQ handler registration helpers */
 	KUNIT_CASE(dm_test_dce110_register_irq_handlers_rejects_uninitialized_sources),
 	KUNIT_CASE(dm_test_dce110_register_irq_handlers_one_crtc),
+	KUNIT_CASE(dm_test_dce110_register_irq_handlers_soc15_client),
+	KUNIT_CASE(dm_test_dce110_register_irq_handlers_crtc_add_id_fails),
+	KUNIT_CASE(dm_test_dce110_register_irq_handlers_bad_vblank_source),
+	KUNIT_CASE(dm_test_dce110_register_irq_handlers_bad_vupdate_source),
+	KUNIT_CASE(dm_test_dce110_register_irq_handlers_bad_pflip_source),
+	KUNIT_CASE(dm_test_dce110_register_irq_handlers_vupdate_add_id_fails),
+	KUNIT_CASE(dm_test_dce110_register_irq_handlers_hpd_add_id_fails),
 	KUNIT_CASE(dm_test_dcn10_register_irq_handlers_zero_crtc),
 	KUNIT_CASE(dm_test_dcn10_register_irq_handlers_one_crtc),
 	KUNIT_CASE(dm_test_register_outbox_irq_handlers_without_dmub),
-- 
2.43.0

