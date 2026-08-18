Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73B0EC5DF85
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E657610ECE6;
	Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wkl7NMhb";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98CF910E38B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yTAgXUf1ZcKka6hbhw9OYjW64beH9zanq1JgCJvcmM15OtHDTarMCoNWPdpAs1e7DqCX8QR0TtyJM0Kbynul0Unt+63F/xDok8wmacuCGUt/N6fhfW+dVKHBH8knQQaChaXQM//57cGQU1+ilaJqrCyrXgrl1LZNpGhVbTEc4hykBV/DSTCC+I7YJIZ1Ct/tkamkZSaWlNDSf4/7mdaBLsV30j/c31iH81TGioDL3GCXbwwGsXmC17SbsEDeqeG+yNKVYpXERAZ7FOEqmze+h7J9tFT7eBcEgn2LP7EozMEYyxgZrQQdz6hWY7+5GSsClmcM1+80cEQxtW1TlxelVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lH/vbhoCGvIN0o6Irdtv7a2xflXcHP8dhJKSKdOIo40=;
 b=eV70+UOPP48rESZLUOsLJUF/NNS9jDfrzYsrjzVXCMQCIR5AX4ZQBzvtZDq0leRkWNKoYBjW/HjZlVlIoDtg72JiMvXEOzSKpbtg549W1Ffm2BMS0KK3nTIs/h+m+ho7pr8C1Q+QNcRnrqKYK4i5xlPvPwPxRyCrxGPaLBQt8rNMyCyAyosaeqZhRSOqQZaja7JMVK1mkdcDw1mFOihSvA5Fg6xA6BoM0YmeOkhjFlXukst7ZJ88xD3Ti/kVNJl3qpG8ATt/cciC15W9RmcCgXCOyMGk+BaEFgwdFVRX/NlvHHAyj0lEtAFyyrB9JTkO1CHIzwL7Wwx1mGrLlMJE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lH/vbhoCGvIN0o6Irdtv7a2xflXcHP8dhJKSKdOIo40=;
 b=wkl7NMhbx6ywR+2QzAztZWiC2yzUsqDOKVHDmRq5hNNkXRG7y6WJk42ZDveN16TG5xTJ6lbbzEkHvvHp4AqPQOl0zL+CIoh2XrRnHMYzK5V1c1m8rV8gg8uP1VpVKc5vmkvR4EcTyf3homH+V+iUe1oJhOLtYZfd0B2S4Hcs/Ws=
Received: from BN9PR03CA0340.namprd03.prod.outlook.com (2603:10b6:408:f6::15)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:47 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::61) by BN9PR03CA0340.outlook.office365.com
 (2603:10b6:408:f6::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:47 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:47 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:46 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 71/82] drm/amd/display: Cover
 amdgpu_dm_prune_primary_tile_modes
Date: Tue, 18 Aug 2026 16:16:03 -0400
Message-ID: <20260818202139.4172592-72-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c79528a-6ab4-40a5-613d-08defd66780c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: WqrKlArEamgKeTWCBVR1y0SlqTzio4xhphIRwXbNyPr56CzdfL4nK3vyhc4D+khNt6EGwxQP+HcycOs7SYU48HrPl+B+j6NUce11yCZB3dLdmfU1SGHFlvmmjupJofBU17O6UApeCMbF3z9TekCnx9wtuN9qzJerdOJPvE4Dlf5FEgbKgtp/CYzKcerp4AxQXjjNJpLfzWPcTM66xF2eBWjvvmClJJbwcgonpHvUjpAZj503elBSHV1AAC8y8kr5tHxW9pV9LxxD6evAXDprudRZQ/m1j2GqkQogYmMgW5tKKqcNFC+4xAbpcpEgiPXiG6r10YEehfNThd5NhtNGIcI3wOA/jTBvzzbzG2VhW6xZenqzHjz7muZZ1VrF+YwDlWbGhfb0+KZiH0YYRD4akUlVShwQx1lr4oy43R4IwF1NaDzfjlRTZqR1AHQdO4bY3EB/SyfRXTiOZJi5RvI4gpo7HAaPivB5/TO1ytYojpDiVq5Ja5rOv6XRnb/pF4orZf8UjO29t8por0iAZrGqOD4wW3CiFHhcDSZtlX5Hf9iFlni4io3HtlQPpO9Gp2jE2Sl2iy4yyr5tf+ffpJEfA4az4DKdZjxQ3RGSQTmk28XlCWd5CmmiCNgRV+xfH9MiUoLMipQMJmESCBFCA59HgLuO9UeXLcP43/C7WUZgzN8UObRU1weywA1rTkerc4Tglqnkm1lsyMgqcORZtXo2Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9+dbpg1bUQCplfm5YwcwTGvUTYTqpmPWu3uS1wRmp6RELT42Ak9qOCI2p4kE/Hg5bhceXsVSZ0NlabyKaJflSTrZCIofovGNIRv9f/iFWDBiuVS5kPwTlLEr3ibnOzXqYipTCsYFNINlK3OLPqHrrPckdCRXT3iJkvW/OPVuARvlfGYaGjviBsNYoRbKiCSnf/e1qHyc6JYyXfmDGz1UefQjvdbWMBBbySOW0A6Y75p5O/kmxxLB/CMEmR9sBeS1oiPdHgcSpBghBsPmX6R0IiskSaQeDIrnkWVrAVVZDSZZmF/jRc/yt3FptJ3xZtpP2+y719Md5qv8glB5KuaAb/DUcKLSYOiDI/yyWeY2G2AeJXgxuCf9vp/IWppkWO7QKUEFUi/H/BN1m+Z+yql0bR/1hDUDQax+1hy051gpfoJnMyu5iThI1WYf3FGahKAU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:47.5276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c79528a-6ab4-40a5-613d-08defd66780c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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

Add KUnit tests for amdgpu_dm_prune_primary_tile_modes() covering the
no-sink, no panel-patch and non-tiled early returns, a secondary tile,
and the primary-tile path that prunes per-tile modes.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 172 ++++++++++++++++++
 3 files changed, 175 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index ddefef1debf25..a473218f4d75c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2853,7 +2853,7 @@ EXPORT_IF_KUNIT(amdgpu_set_panel_orientation);
  * per-tile timing from the primary connector so compositors only pick the full
  * 5K mode.
  */
-static void amdgpu_dm_prune_primary_tile_modes(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_prune_primary_tile_modes(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct drm_display_mode *mode, *t;
@@ -2886,6 +2886,7 @@ static void amdgpu_dm_prune_primary_tile_modes(struct drm_connector *connector)
 		aconnector->num_modes--;
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_prune_primary_tile_modes);
 
 STATIC_IFN_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 					      const struct drm_edid *drm_edid)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 91b8434ba591d..a86d5c879b646 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -169,6 +169,7 @@ void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 				       const struct drm_edid *drm_edid);
 int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
+void amdgpu_dm_prune_primary_tile_modes(struct drm_connector *connector);
 uint add_fs_modes(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
 					    const struct drm_edid *drm_edid);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index e63202fc7ba9f..e022f93c36cf5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -7540,6 +7540,172 @@ static void dm_test_panel_orientation_applies_quirk(struct kunit *test)
 			DRM_MODE_PANEL_ORIENTATION_UNKNOWN);
 }
 
+/* Tests for amdgpu_dm_prune_primary_tile_modes() */
+
+struct dm_test_prune_ctx {
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc_sink *sink;
+};
+
+/*
+ * Build a connector configured as the primary tile of an Apple Studio Display:
+ * a dc_sink requesting the second-tile patch, has_tile set, tile location (0,0)
+ * and a per-tile timing of tile_h_size x tile_v_size. Individual tests relax a
+ * single precondition to exercise the early-return guards.
+ */
+static struct dm_test_prune_ctx *
+dm_test_prune_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_prune_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->drm = dm_test_alloc_drm(test);
+	ctx->aconnector = dm_test_add_connector(test, ctx->drm,
+						DRM_MODE_CONNECTOR_DisplayPort);
+
+	ctx->sink = kunit_kzalloc(test, sizeof(*ctx->sink), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->sink);
+	ctx->sink->edid_caps.panel_patch.disable_second_tile = true;
+	ctx->aconnector->dc_sink = ctx->sink;
+
+	ctx->aconnector->base.has_tile = true;
+	ctx->aconnector->base.tile_h_size = 2560;
+	ctx->aconnector->base.tile_v_size = 2880;
+
+	return ctx;
+}
+
+static struct drm_display_mode *
+dm_test_prune_add_mode(struct kunit *test, struct drm_connector *connector,
+		       int hdisplay, int vdisplay)
+{
+	struct drm_display_mode *mode = drm_mode_create(connector->dev);
+
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	mode->hdisplay = hdisplay;
+	mode->vdisplay = vdisplay;
+	list_add_tail(&mode->head, &connector->probed_modes);
+
+	return mode;
+}
+
+static int dm_test_prune_count(struct drm_connector *connector)
+{
+	struct drm_display_mode *mode;
+	int n = 0;
+
+	list_for_each_entry(mode, &connector->probed_modes, head)
+		n++;
+
+	return n;
+}
+
+/**
+ * dm_test_prune_no_sink - Test a connector without a sink is left untouched
+ * @test: The KUnit test context
+ */
+static void dm_test_prune_no_sink(struct kunit *test)
+{
+	struct dm_test_prune_ctx *ctx = dm_test_prune_ctx_alloc(test);
+
+	ctx->aconnector->dc_sink = NULL;
+	dm_test_prune_add_mode(test, &ctx->aconnector->base, 2560, 2880);
+	ctx->aconnector->num_modes = 1;
+
+	amdgpu_dm_prune_primary_tile_modes(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, dm_test_prune_count(&ctx->aconnector->base), 1);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->num_modes, 1);
+}
+
+/**
+ * dm_test_prune_no_patch - Test the patch flag being unset skips pruning
+ * @test: The KUnit test context
+ */
+static void dm_test_prune_no_patch(struct kunit *test)
+{
+	struct dm_test_prune_ctx *ctx = dm_test_prune_ctx_alloc(test);
+
+	ctx->sink->edid_caps.panel_patch.disable_second_tile = false;
+	dm_test_prune_add_mode(test, &ctx->aconnector->base, 2560, 2880);
+	ctx->aconnector->num_modes = 1;
+
+	amdgpu_dm_prune_primary_tile_modes(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, dm_test_prune_count(&ctx->aconnector->base), 1);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->num_modes, 1);
+}
+
+/**
+ * dm_test_prune_no_tile - Test a non-tiled connector skips pruning
+ * @test: The KUnit test context
+ */
+static void dm_test_prune_no_tile(struct kunit *test)
+{
+	struct dm_test_prune_ctx *ctx = dm_test_prune_ctx_alloc(test);
+
+	ctx->aconnector->base.has_tile = false;
+	dm_test_prune_add_mode(test, &ctx->aconnector->base, 2560, 2880);
+	ctx->aconnector->num_modes = 1;
+
+	amdgpu_dm_prune_primary_tile_modes(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, dm_test_prune_count(&ctx->aconnector->base), 1);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->num_modes, 1);
+}
+
+/**
+ * dm_test_prune_secondary_tile - Test a secondary tile is left untouched
+ * @test: The KUnit test context
+ *
+ * Only the primary tile (location 0,0) is pruned; a secondary tile keeps its
+ * per-tile timing.
+ */
+static void dm_test_prune_secondary_tile(struct kunit *test)
+{
+	struct dm_test_prune_ctx *ctx = dm_test_prune_ctx_alloc(test);
+
+	ctx->aconnector->base.tile_h_loc = 1;
+	dm_test_prune_add_mode(test, &ctx->aconnector->base, 2560, 2880);
+	ctx->aconnector->num_modes = 1;
+
+	amdgpu_dm_prune_primary_tile_modes(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, dm_test_prune_count(&ctx->aconnector->base), 1);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->num_modes, 1);
+}
+
+/**
+ * dm_test_prune_removes_per_tile - Test the per-tile timing is pruned
+ * @test: The KUnit test context
+ *
+ * On the primary tile the per-tile (tile_h_size x tile_v_size) timing is
+ * dropped while the full-resolution mode is kept and num_modes is decremented.
+ */
+static void dm_test_prune_removes_per_tile(struct kunit *test)
+{
+	struct dm_test_prune_ctx *ctx = dm_test_prune_ctx_alloc(test);
+	struct drm_display_mode *mode;
+	bool has_tile_mode = false;
+
+	dm_test_prune_add_mode(test, &ctx->aconnector->base, 2560, 2880);
+	dm_test_prune_add_mode(test, &ctx->aconnector->base, 5120, 2880);
+	ctx->aconnector->num_modes = 2;
+
+	amdgpu_dm_prune_primary_tile_modes(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, dm_test_prune_count(&ctx->aconnector->base), 1);
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->num_modes, 1);
+
+	list_for_each_entry(mode, &ctx->aconnector->base.probed_modes, head)
+		if (mode->hdisplay == 2560 && mode->vdisplay == 2880)
+			has_tile_mode = true;
+	KUNIT_EXPECT_FALSE(test, has_tile_mode);
+}
+
 /* Tests for amdgpu_dm_update_stream_scaling_settings() */
 
 /**
@@ -8015,6 +8181,12 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_panel_orientation_non_edp),
 	KUNIT_CASE(dm_test_panel_orientation_no_native_mode),
 	KUNIT_CASE(dm_test_panel_orientation_applies_quirk),
+	/* amdgpu_dm_prune_primary_tile_modes */
+	KUNIT_CASE(dm_test_prune_no_sink),
+	KUNIT_CASE(dm_test_prune_no_patch),
+	KUNIT_CASE(dm_test_prune_no_tile),
+	KUNIT_CASE(dm_test_prune_secondary_tile),
+	KUNIT_CASE(dm_test_prune_removes_per_tile),
 	/* dm_validate_stream_and_context */
 	KUNIT_CASE(dm_test_validate_stream_null_stream),
 	KUNIT_CASE(dm_test_validate_stream_dc_ok_no_pipe),
-- 
2.43.0

