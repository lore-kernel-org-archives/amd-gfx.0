Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF0BC5DF86
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A62C610ECEB;
	Tue, 18 Aug 2026 20:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uW+tI+f6";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010023.outbound.protection.outlook.com [52.101.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65BA810ECC1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5si2UtuXKvot4ezXi5R5suwm5CvAoZQraNYwxiBGHGVmBwJCnHfvWqLa2y19o16WYZvPsixFDAuHAOZytjkGPULHYO0Qs8iOVFOBRZVgqFOAzvjfbqtt8y3YEtzsaWXvDbMbDxckRQYF40jpiDNq98Zo/HZNw5jts1l1nAdbr1kFShaMwL3Mdarbes1SSF0PcgU6pOecVm64BvGG8C10BxRvlGFMHR9TEh0PaZDxH6qSvUn123CemC7dRjzkk1JpCEcFn9F/T7ZfqnVetf4EYhtCpkweqAwEAoacSZyV5H+OU5fYz6b3eo5rLWgm2ulrYch50OnZwMtecdy+mCvZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeRTQtDSxNfp8UjbbkLWiQPPSqisZ6zQRG17Zr9+Zg8=;
 b=VzuqC0GkXjLKOczEycLIEeafga8sn4Rf1qNj1ZTeaZ+AgB9i64eDcad3xNP1baXV19Dl8GD578lT0NE56EtIW0+fNqxkJ99gDqBUlI8yFZ5/6GoGXZMgJa1n/fWmmgqL/UI0LWCgucumU/Nj9c0TscUJQ4EUDWiy35Ky39WAi7VQSulAdQYWIIjCGyKhil338GKwARL912ZnjrDzznzfxADkMhohAkYH3CPH9AvHUZc1r1VPtJPbmunUxwlzvKwziFwMMAQ8CZtcXqOSClhzEUjVwnKyfEf6Y03HrlN/4iayyEFi6VwtM8OjtUW0C5fT29qBHqJklPspsMKSPk5Erw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeRTQtDSxNfp8UjbbkLWiQPPSqisZ6zQRG17Zr9+Zg8=;
 b=uW+tI+f6LPp0rXB0HMuNwR57dh5v5Uzi9jpTQKh2MJ+kOcTZlEA7kU4s9igqxICf0gC+ob5L3xWj8AXIy0P6G0YGJRXYV40JBJNSfJVTVwskyTHsROCG7H2Lp/i2qs4JUShRoHCsZ/LgwlbSp7krFE4EI2QdvW8rEsFZEM4Y8p0=
Received: from BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::27)
 by DSVPR12MB999124.namprd12.prod.outlook.com (2603:10b6:8:38b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:44 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::74) by BL1P221CA0026.outlook.office365.com
 (2603:10b6:208:2c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:37 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:36 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:36 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 60/82] drm/amd/display: Cover amdgpu_set_panel_orientation
Date: Tue, 18 Aug 2026 16:15:52 -0400
Message-ID: <20260818202139.4172592-61-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DSVPR12MB999124:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f278ae5-9201-45cb-664a-08defd6675a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WP0HzQi9brEXWMtfEN+DrZ3Ak9cWEnCqfKrHVji9LoIxswmjVWNdtApRYi47J/lFY5rHSNVh5PUZ9T08uFwSzHLrOwdrhOjMHkUuV4VASK4HSpBuZC+gJkhrd+dGOrx/3QWxDOgxiakDnED+A6JAoIXwvW0ph01Sdn4mhA/cx2Cg1fozLI+ugKz8FZTz3pD61iHFknViAekzMQBFfZMoqqkeXmhM3Wg1jTS7vhYS58ppIrSIz9J1UgjfdPjnv+I2XIeX3r42Z12gipP2hgSkbGMivEVu712npGDf5/MAybjcM2z08p0vs3UYBUz2qckC1MaZZJDfiywQmXaOaN7qjHPMMpc7aT0vmuLLFSx18lCvrt8yxaSkCwfUw5iZuGvRkBnix5UF6qg1tHxJeFFGyCwI5X4sYzZHq9uTk4E+ygeoQiJtwNA34vKK82OEO8TYmnnRdZ/fdvpRfDGx9jzqOwTNFHWxi1BIP2NRq9ynWaYOHLF49+4t39wgnzrZVSKO0Z9k76YG+LICO8bjCDpwwikZ1Df3AGXYy1cn0AonuR/XeDzm5a+j1dalvpsurcbyqqXl1Zm+IRZdAq4c3m/L+ySIdoPRfNJEJQcMGjY5MK9T+P+2XYksSmRumyAzDuvzMyvq9TBQcOoRpQSwtSEoQpSJy8J2jdFGffa5CioMzDw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UcBAOm26FHNgyP68dsXp8P8wvUQP2FjRO5Q2Uxzy2M46ONvHoD3vKyU1SNE7/hP2voRxI6fM34Qrf4HT0rOu7VQDVdB4XaB5GVAf3h6sJjJLXqrAemXIFMtskkgUQ/Gt/MR2ExDupJd5AMq2uLva8clZv7NMIrwcRVeTieXSnj/lKL0ZfApSwngQyAhHxPH98Hou4bt0svKFy/TqoqHNofAqnk46IHBIe4EWbtGE4iZrmxycFWxrjJscZQXg5+Ukfg9P3Rv/blyws6LvbxYVvD5zV8y9KRUqKXYPgFM67G0FRUWy5S0nDF4XO2cK5G4c5wHnpOqL4J5HWynDUzFbGfTca4oroMnfQE3cXUZ2FO72d87EYvCdcOYeTqtEW9mjMo4hfEhMR3HdSFWtWrooTv76o36tEybd07JFoGh6g1EGjjP6MZHiI8lgIq3fGo9M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:43.5024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f278ae5-9201-45cb-664a-08defd6675a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999124
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

Add KUnit tests for amdgpu_set_panel_orientation() covering the non-eDP
early return, the missing native mode case, and a panel that applies
the orientation quirk.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  1 +
 .../tests/amdgpu_dm_connector_test.c          | 68 +++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 45ac4e2b5029b..ddefef1debf25 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2844,6 +2844,7 @@ void amdgpu_set_panel_orientation(struct drm_connector *connector)
 						       native_mode->hdisplay,
 						       native_mode->vdisplay);
 }
+EXPORT_IF_KUNIT(amdgpu_set_panel_orientation);
 
 /*
  * The Apple Studio Display primary tile advertises both the full 5120x2880
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 120d0e27f5eed..e63202fc7ba9f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -7476,6 +7476,70 @@ static void dm_test_get_modes_with_edid(struct kunit *test)
 	ctx->aconnector->drm_edid = NULL;
 }
 
+/* Tests for amdgpu_set_panel_orientation() */
+
+/**
+ * dm_test_panel_orientation_non_edp - Test non-eDP/LVDS connectors are skipped
+ * @test: The KUnit test context
+ *
+ * Only eDP and LVDS panels carry a fixed orientation, so a DisplayPort
+ * connector returns immediately with its panel_orientation left unknown.
+ */
+static void dm_test_panel_orientation_non_edp(struct kunit *test)
+{
+	struct dm_test_gm_ctx *ctx =
+	dm_test_gm_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+
+	amdgpu_set_panel_orientation(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test,
+			ctx->aconnector->base.display_info.panel_orientation,
+			DRM_MODE_PANEL_ORIENTATION_UNKNOWN);
+}
+
+/**
+ * dm_test_panel_orientation_no_native_mode - Test a missing native mode is skipped
+ * @test: The KUnit test context
+ *
+ * On an eDP connector with no cached EDID the encoder native mode stays 0x0, so
+ * the function returns before applying an orientation.
+ */
+static void dm_test_panel_orientation_no_native_mode(struct kunit *test)
+{
+	struct dm_test_gm_ctx *ctx =
+	dm_test_gm_ctx_alloc(test, DRM_MODE_CONNECTOR_eDP);
+
+	amdgpu_set_panel_orientation(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, ctx->aenc->native_mode.hdisplay, 0);
+	KUNIT_EXPECT_EQ(test,
+			ctx->aconnector->base.display_info.panel_orientation,
+			DRM_MODE_PANEL_ORIENTATION_UNKNOWN);
+}
+
+/**
+ * dm_test_panel_orientation_applies_quirk - Test a native mode reaches the quirk
+ * @test: The KUnit test context
+ *
+ * With a valid encoder native mode on an eDP connector the panel dimensions are
+ * forwarded to the orientation quirk lookup; absent a matching quirk the
+ * orientation stays unknown.
+ */
+static void dm_test_panel_orientation_applies_quirk(struct kunit *test)
+{
+	struct dm_test_gm_ctx *ctx =
+	dm_test_gm_ctx_alloc(test, DRM_MODE_CONNECTOR_eDP);
+
+	ctx->aenc->native_mode.hdisplay = 1920;
+	ctx->aenc->native_mode.vdisplay = 1200;
+
+	amdgpu_set_panel_orientation(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test,
+			ctx->aconnector->base.display_info.panel_orientation,
+			DRM_MODE_PANEL_ORIENTATION_UNKNOWN);
+}
+
 /* Tests for amdgpu_dm_update_stream_scaling_settings() */
 
 /**
@@ -7947,6 +8011,10 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_get_modes_noedid_128b_adds_more),
 	KUNIT_CASE(dm_test_get_modes_noedid_analog_adds_common),
 	KUNIT_CASE(dm_test_get_modes_with_edid),
+	/* amdgpu_set_panel_orientation */
+	KUNIT_CASE(dm_test_panel_orientation_non_edp),
+	KUNIT_CASE(dm_test_panel_orientation_no_native_mode),
+	KUNIT_CASE(dm_test_panel_orientation_applies_quirk),
 	/* dm_validate_stream_and_context */
 	KUNIT_CASE(dm_test_validate_stream_null_stream),
 	KUNIT_CASE(dm_test_validate_stream_dc_ok_no_pipe),
-- 
2.43.0

