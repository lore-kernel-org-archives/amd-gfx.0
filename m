Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0BB5C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ABB410EC9D;
	Tue, 18 Aug 2026 20:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cyD+Hkj3";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAFDC10EC9D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cqiNXvwom+L8w0Ose9wGYPRIjW+CHD4+puKDXjQyf9dOK2OxaLYDaTL/9QmkBmIOsYEzQ93Y/Mw7Dzn9yCi56Q/Ke+KCgGgytr6RPdxKRJDPm4UJY7N2cHF8vxSQu8ryF0k1jRmsmRp9ruflkL3wzMSG6fRxBEyto81ucNiW1KO5+PBU/+nNdKPMJ7/DHp0Jl8a8CnaRtoz82fFEnUHc6k7U+mZSud39dWwGEcxeCGsttO9TgKhCYdCZXFRrQ6SuSMfFWgFCFC5hFUE2w9OOPHuv5vPrNtpKGi9EzYYEAjv3r4ijOV/fvcK7GtzEiYZm7H0iNqcLD7wBrjSjllrxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxxSOU5gdWwb5CUsMoJqKu5kIf0OPdr7JVm/QjKPlaU=;
 b=WnyKZMaLq4aCw4hSQ4dk/H/q/wi23wOjMA56Z6s62vl0DOqPNs8asSHdBlrN8vdDkvEEcgSdxvHLL7u3/xfdIfgfzpRfBVTQ7M1+LoGwqxM3PCjrnLbxgFu18o8ayZlV1GKmUoKukQ6VuHGGrn+zP0C55Hgywgd5qVe3ne3+WFptQ7Nev/C3xXnRFh9f64txKqBu919uSDk7C9amuMx86LVctijSPe79qb2Ox+VdOcqEHjdtuhtoeIqgEb0nF5bVshw8qF/zeDfyP7kHta6qvT+kNOYPJNnFt0v8I0HDgiFw2LUawo4NJVWKnLXJR7taZOUTg87F/y9XTD/2wXkWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxxSOU5gdWwb5CUsMoJqKu5kIf0OPdr7JVm/QjKPlaU=;
 b=cyD+Hkj39rjxvltccrUX7cyk9+vhnmUXiBy2e/ue9k1Pe3KJ64ldjUBdwM1rgSdN7OGgKZBLAX65hOzvNDweOV2WT9O19mZDovPfnhrSpX4dfOIm7crgW48c4i8Vspz/oW9ihK0EkqlwJi7RrJmAiYi6DbCnsqgZzuyyNaEqNv4=
Received: from IA1P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::14)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 18 Aug
 2026 20:22:31 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::79) by IA1P220CA0008.outlook.office365.com
 (2603:10b6:208:461::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:06 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:06 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:05 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 17/82] drm/amd/display: Test EDID quirks and ACPI EDID read
Date: Tue, 18 Aug 2026 16:15:09 -0400
Message-ID: <20260818202139.4172592-18-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be6d31c-bfbb-4377-2831-08defd666e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|18002099003|56012099006|22082099003|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: qvkt8HWTl/Eu1HIIKlsbQ5zPEQGdKGsL5qsz1FTtRh9MHkh79FoK7WsN3zMChH+HrDrstI+rxOZBaLyz/84WyBOMK11dBcGl2BQbTbXlfffOVvK1V4oRsSlcVY3Oe0kdfrSpXnI1TW5Tf9MLaiQbNki5A6962gj0jK1kiPrNjFrftuazKI9I6mBP/xEoc3yAjDoibRG6M5YYd2r80FyAdwHhsaxxSmdetMztFp2E23/thSdTT5hlmsRmNqA95GmCRmnAPg5PvD/gZYms47gtRzJ/jzfGel7HWzfxdpXM3K58tZjPJnb+pujUXm6j/FmjB8g2NzDv7qXHWtuW3SgaWdbDDfzldk9VabyYjRZcqcmkelRpH9LtlnqaDWElD2Wggh31/lHAxd6wNFKyUVPurw/F3i/7eTCE+LaksptIDCHhvftjG9lG/QveVhlJt3h5xHwF6E2dSmGxIv5inD8+C+cR4HndLIP8GO1Zd3M2USyJtCAJ0zytU9eAP4GkxfjdTwCWbRMYLYpuJ6SJHtkOv+tm5SVSgwfCaPopXhQnxQvnRyTdBaJYQ8NT1BrIASc31erELkxGtGnGXYaa7kakMBPX1hQpf8XQnJPpnNdzKBWUzdzy16ORKQ/O6Letq4C4tj4XJ3iFYifJmt+m6vn+I4Szt6uTEhGsJkiciowTC/eXIeQL2Iqis2QHqDLMmY0njr9BsxX8IhLFW83yOk66MQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(18002099003)(56012099006)(22082099003)(3023799007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mOVT1YTcf7SJKH5X+gQrgzGlD9UbyTPSiRTeV8HRYT84p6LIQd7DP7X7rbbqUXWNTCkr50Fq9ITRBQPFKZRHjC1jAxwGz/jwRla93jMOheJcROt23cHeIyGEHI7to1Kf8l0xrjHwl483hNL+gXdqIuJtJhFhTqR1/l2vtJnsX4Wwl7cmIWFPsFw9KRwOGmTbiJuCx3JkbfZGyVp9xFdbLXhMNm1Zff5hpzrpwr2q9OgtgORLJkQqiotTRKj5+vhWNxvRkSUvCfiqiwYXkv7/gfl3GhFlDWens6AmMGwnoCXKDjf8DLorRJ6TwjrCUiCR7NhGIzDUl2s/FGcNZt1/nxUBObL+UoXeJH01g/Fp8gEpndMQL0s4OXCAJ4x+wHJF7CEBsvM6RepQd2HViJezz5Creys7zA4hW2+fSGf89GGHGQJRSP+XqZ1EHQ2Hs5Il
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:30.9431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be6d31c-bfbb-4377-2831-08defd666e29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
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
Add KUnit tests for apply_edid_quirks() covering the two quirk entries
that had no coverage: the Apple Studio Display tile quirk and the Lenovo
G34w-30 FreeSync minimum refresh rate override. Both tests build an EDID
carrying the quirked panel ID and check the resulting dc_edid_caps panel
patch.

Add a KUnit test for dm_helpers_read_acpi_edid() that lets an eDP
connector reach drm_edid_read_custom() instead of returning early. The
probe callback finds no ACPI companion, so the helper returns NULL,
which covers the read and the failure return.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 5de697ca0fcce..89ce10d84f035 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -223,6 +223,38 @@ static void dm_test_apply_edid_quirks_unknown_noop(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, link->wa_flags.skip_phy_ssc_reduction);
 }
 
+/**
+ * dm_test_apply_edid_quirks_disable_second_tile - Test Apple Studio Display tile quirk
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_edid_quirks_disable_second_tile(struct kunit *test)
+{
+	struct dc_edid_caps edid_caps = {0};
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct edid *edid = dm_test_edid_with_panel_id(test,
+			drm_edid_encode_panel_id('A', 'P', 'P', 0xAE3A));
+
+	apply_edid_quirks(link, edid, &edid_caps);
+
+	KUNIT_EXPECT_TRUE(test, edid_caps.panel_patch.disable_second_tile);
+}
+
+/**
+ * dm_test_apply_edid_quirks_force_freesync_min_60 - Test Lenovo G34w-30 FreeSync min quirk
+ * @test: The KUnit test context
+ */
+static void dm_test_apply_edid_quirks_force_freesync_min_60(struct kunit *test)
+{
+	struct dc_edid_caps edid_caps = {0};
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct edid *edid = dm_test_edid_with_panel_id(test,
+			drm_edid_encode_panel_id('L', 'E', 'N', 0x66F1));
+
+	apply_edid_quirks(link, edid, &edid_caps);
+
+	KUNIT_EXPECT_EQ(test, edid_caps.panel_patch.force_freesync_min_hz, 60U);
+}
+
 /* Tests for dm_helpers_parse_edid_caps() */
 
 /*
@@ -595,6 +627,25 @@ static void dm_test_read_acpi_edid_force_off(struct kunit *test)
 	KUNIT_EXPECT_NULL(test, dm_helpers_read_acpi_edid(aconnector));
 }
 
+/**
+ * dm_test_read_acpi_edid_panel_connector - Test the ACPI EDID read is attempted
+ * @test: The KUnit test context
+ *
+ * An eDP connector that is not forced off reaches drm_edid_read_custom(), whose
+ * probe callback finds no ACPI companion, so no EDID is returned.
+ */
+static void dm_test_read_acpi_edid_panel_connector(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+
+	adev = dm_kunit_alloc_adev(test);
+	aconnector = dm_kunit_alloc_connector(test, adev, NULL);
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
+
+	KUNIT_EXPECT_NULL(test, dm_helpers_read_acpi_edid(aconnector));
+}
+
 struct dm_test_vbios_edid {
 	struct dc_bios bios;
 	enum bp_result result;
@@ -3742,6 +3793,8 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_apply_edid_quirks_skip_phy_ssc),
 	KUNIT_CASE(dm_test_apply_edid_quirks_force_freesync_min),
 	KUNIT_CASE(dm_test_apply_edid_quirks_unknown_noop),
+	KUNIT_CASE(dm_test_apply_edid_quirks_disable_second_tile),
+	KUNIT_CASE(dm_test_apply_edid_quirks_force_freesync_min_60),
 	/* dm_helpers_parse_edid_caps */
 	KUNIT_CASE(dm_test_parse_edid_caps_null_edid),
 	KUNIT_CASE(dm_test_parse_edid_caps_null_caps),
@@ -3756,6 +3809,7 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_read_acpi_edid_debug_mask_disabled),
 	KUNIT_CASE(dm_test_read_acpi_edid_non_panel_connector),
 	KUNIT_CASE(dm_test_read_acpi_edid_force_off),
+	KUNIT_CASE(dm_test_read_acpi_edid_panel_connector),
 	KUNIT_CASE(dm_test_read_vbios_edid_non_embedded),
 	KUNIT_CASE(dm_test_read_vbios_edid_missing_callback),
 	KUNIT_CASE(dm_test_read_vbios_edid_callback_error),
-- 
2.43.0

