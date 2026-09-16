Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75346C982D0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BA9510ECA4;
	Wed, 16 Sep 2026 17:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tfCqGl6+";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24FFF10EA44
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijIOJR0oUodTU1RJy0qzEc3lRGnwIYpQTJ6sDMDIISRnZqmXod/xAmSo4HGboXT/ktbzME63xos1DUkH/tBMj3F9TQCFEMAh4wpibIMK4sT+wpBg9+i3WpEywLFHRy/PkwxJyKM380bNUIiPivWkFRd7F5jKKSLDDjN/uqBPWgdiIq2pnVkrEdvxMJQH8PRTCu6W+L780C/ToMliUemoNJ4qOEFrlb0nJzvnr22ekcQGq4g6ueq612E9wjJbz1tISQ8sE53t/Tijioaj/lXtKA8ja+xrDOEp0clXhbEnkkw206Xvp/ME+U/YAnoiofeyJeoejEXI3e1JhzrRcMXPHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QcDBLeoWo1+O2JXhJE4lWAiQRQHS5OBb8mcHu2WJ09E=;
 b=l8Pw3qjr/zwABlUQzUwouRFm/MvFewOMzH9eu9Z2oLEcUHidTYnynrBKIU0wAEujuy6QI/35cd3nYFJlJVXVbbqDikQFkCCt9WMYrVP7Cu41KYbRRmC1fAcKc2biaD/j2ShozkUQSVlCw4ZUQMIvePVqXZCUqdKy57oynxdrh2BfjX8z67Ss7l6nnD2aziE5F9S2Rm+fivXcYQp8TC6OEYEtp8FvCar4FanBFza9iRfVtb2XLcSaI+0Un6DjbArb7ZepqkkV405g0oMBVJuj5VGp3MRPPLWhCD2QVDWGHXfwc3FKNG8p1b7cB7lchlvvX6xoTUG6hMQlNhARIQ3oPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcDBLeoWo1+O2JXhJE4lWAiQRQHS5OBb8mcHu2WJ09E=;
 b=tfCqGl6+R1O5KSDT8xXKQWcGln+1QTx7Frm8MjT+/F82auAmSnvHZnYA1Md6Ej6IOxEfGPlCXalkrx7gPBFoYDXz8uO80hE7wYLFIjib6i0C2jb25JrXf5U/qHtebz2ezwYYelaLnmA+S4VzpIQ2lo17NqiD1pFkSxUsMCHm6w4=
Received: from CH0PR03CA0189.namprd03.prod.outlook.com (2603:10b6:610:e4::14)
 by LV3PR12MB9141.namprd12.prod.outlook.com (2603:10b6:408:1a7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:46 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::aa) by CH0PR03CA0189.outlook.office365.com
 (2603:10b6:610:e4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:46 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:35 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 28/64] drm/amd/display: Test EDID helper paths
Date: Wed, 16 Sep 2026 13:51:43 -0400
Message-ID: <20260916175301.368306-29-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|LV3PR12MB9141:EE_
X-MS-Office365-Filtering-Correlation-Id: 794447bf-00d0-499f-cba3-08df141b50e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|10067099003|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: inp6TPb/0a57SrMHaq2rp7wmnoI1LOSIZnujDNUkWL/wHDeTboiPbrmRodmVyA8sNgyKDLTb7eZ0cpxZgPFTCKnOzXZnPwp2vF/F5Y+yZPLCt3xHjTxV9p98l13hTGSG40jG0hXiAL8wBK80SPjPr8UE/w/meC7dpPjJaTRC+cL2f3i903kqpazqu8gjLFI1TP/n4DuEM0Q2ZLW6k+rFNdw8gcAFFQSIM1NYHp2MhA9eewsncnz8z7sIW6ZpCLs8M5Mdt9l8Hn/Xo7IxzCv6SsyS+5FPNXbZUlMYEHpOK1O6bUlU2BUevfKSPgSfb5aabtsYhXDmewMNxevTfDYtAETTI+p5u7Dhy+iawKvHTWTtr1eVD2F9zL6KST5J5qwF/Umm0cpo92AtCK56rMfGvppT+ws4I712pA94XJHVXLJR5c7HjznyFZUut1dsE4ybiufy/Arh6yCdfR5Lh4xONermbpb90NpOsyGL7wOgfdH6+5AENDOGgNFfO2WCmdomxh09DtBvLWr6kF1Rk0ViH02DUBU/GVu4xMdweFPc42X15VCtTQWMQRtgp81FkLDGERA25Qkt3dkpAVBsCI+dABOgPE+Rrwi8rkTSLuQdDHzGhClEf6jHLNqlqTsYco9J0h0oG2LZKzuiFcmYbah2wxAtz8fpWb1j8ngiamOlnJb8JXaT9z/dKpNa1KC12fSOjeL+RfijFlpYj1X3+y6Q3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yD4UDSpI54CKlB0iJrqaDELYemBERzlWFXqEGcxqZAm0tn8/I/NumuHN2S2ieiVeLZu0/Wk2eqAQvKPGuIAsdYrGjlUWgWy8XuaRWjVb6BsLIAGj0gRU/8/W9+jnjzguO4D77e3dt9eZYp9hOKIsFzfHrVD3a/N1OsGdPSA1sfkypN3ZBsAOKiCobJlWzz6A9pAJP8u28f5hjHGg15iGTTCgNMJqjbvGWUu+9IrsJgVaUv7347O7eNy/hWF4sFWuEjpDqYM0mGUyOFmVWFqGOU8JsCmI0d2+nKh+KwGBbddP81qPMJSJkO05d0/Kv29T/il1iLzpvoVGZXXDdXqaNefakdQRgJE5q7IEiKrqJU0CFPmXbayUbRdEro5BC2CU3fuVtmPo9+icISe2A17Vs2AKmbaLcTq+AR2FINDAPOfzoJ/iADcJHscklHbIWN61
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:46.3477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794447bf-00d0-499f-cba3-08df141b50e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9141
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
Add KUnit tests for three EDID paths in amdgpu_dm_helpers.c the SDC
panel PSR PHY power-down quirk in apply_edid_quirks(), the HDMI
compliance-auto branch of dm_helpers_parse_edid_caps(), and the VBIOS
fallback and corrupt-EDID paths of dm_helpers_read_local_edid().

[HOW]
apply_edid_quirks() is driven twice with the SDC panel ids, once on a
DisplayPort signal and once on eDP, showing the quirk is embedded-only.

dm_helpers_parse_edid_caps() runs against an HDMI connector whose
hdmi_comp_auto flag is set, so the FRL and FRL DSC debug options are
forced on and the quirk is recorded in the panel patch.

dm_helpers_read_local_edid() is given an embedded link with no DDC
line, so it falls back to the EDID hardcoded in the VBIOS embedded
panel info that the existing fake dc_bios supplies. A second test
corrupts the base block checksum served by the fake AUX DDC, so the
read fails, the real checksum is written back and EDID_BAD_CHECKSUM is
reported.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 51c3995de76d..b433634e0390 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -176,6 +176,34 @@ static void dm_test_apply_edid_quirks_disable_colorimetry(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, edid_caps.panel_patch.disable_colorimetry);
 }
 
+/**
+ * dm_test_apply_edid_quirks_psr_phy_power_down - Test SDC PSR PHY power-down quirk
+ * @test: The KUnit test context
+ *
+ * The quirk is embedded-only, so an external signal leaves the debug option
+ * alone and an embedded one forces PHY power down/up level 2.
+ */
+static void dm_test_apply_edid_quirks_psr_phy_power_down(struct kunit *test)
+{
+	struct dc_edid_caps edid_caps = {0};
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+	struct edid *external = dm_test_edid_with_panel_id(test,
+			drm_edid_encode_panel_id('S', 'D', 'C', 0x4197));
+	struct edid *embedded = dm_test_edid_with_panel_id(test,
+			drm_edid_encode_panel_id('S', 'D', 'C', 0x4203));
+
+	link->ctx = dc->ctx;
+
+	link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+	apply_edid_quirks(link, external, &edid_caps);
+	KUNIT_EXPECT_FALSE(test, dc->debug.psr_phy_force_phy_power_down_up_level_2);
+
+	link->connector_signal = SIGNAL_TYPE_EDP;
+	apply_edid_quirks(link, embedded, &edid_caps);
+	KUNIT_EXPECT_TRUE(test, dc->debug.psr_phy_force_phy_power_down_up_level_2);
+}
+
 /**
  * dm_test_apply_edid_quirks_skip_phy_ssc - Test DEL 0x4147 PHY SSC quirk
  * @test: The KUnit test context
@@ -463,6 +491,40 @@ static void dm_test_parse_edid_caps_hdmi_frl_dsc(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, edid_caps->frl_dsc_10bpc);
 }
 
+/**
+ * dm_test_parse_edid_caps_hdmi_comp_auto - Test the HDMI compliance-auto branch
+ * @test: The KUnit test context
+ *
+ * A connector flagged for automated HDMI compliance forces the FRL and FRL DSC
+ * debug options on and records the quirk in the panel patch.
+ */
+static void dm_test_parse_edid_caps_hdmi_comp_auto(struct kunit *test)
+{
+	struct dc_link *link = dm_test_quirk_link(test);
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
+	struct dc_edid_caps *edid_caps;
+	struct dc_edid *dc_edid;
+
+	dc_edid = kunit_kzalloc(test, sizeof(*dc_edid), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_edid);
+	edid_caps = kunit_kzalloc(test, sizeof(*edid_caps), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, edid_caps);
+
+	link->dc = dc;
+	link->ctx = dc->ctx;
+
+	dm_test_fill_base_edid(dc_edid, true);
+
+	aconnector->base.display_info.is_hdmi = true;
+	aconnector->hdmi_comp_auto = true;
+
+	KUNIT_EXPECT_EQ(test, dm_helpers_parse_edid_caps(link, dc_edid, edid_caps), EDID_OK);
+	KUNIT_EXPECT_TRUE(test, edid_caps->panel_patch.hdmi_comp_auto);
+	KUNIT_EXPECT_TRUE(test, dc->debug.force_frl_max);
+	KUNIT_EXPECT_TRUE(test, dc->debug.force_frl_dsc);
+}
+
 /*
  * Build a 2-block EDID: a valid base block plus a CTA-861 extension block
  * carrying one LPCM Short Audio Descriptor and, when @with_speaker is set, a
@@ -4570,6 +4632,60 @@ static void dm_test_read_local_edid_i2c_no_response(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_test_prepare_ddc_calls, 1U);
 }
 
+/**
+ * dm_test_read_local_edid_vbios_embedded - Test the VBIOS hardcoded EDID path
+ * @test: The KUnit test context
+ *
+ * An embedded panel with no DDC line has no I2C adapter to read from, so the
+ * helper falls back to the EDID hardcoded in the VBIOS embedded panel info.
+ */
+static void dm_test_read_local_edid_vbios_embedded(struct kunit *test)
+{
+	struct dm_test_local_edid fixture = dm_test_setup_local_edid(test);
+	struct dm_test_vbios_edid *vbios;
+
+	vbios = kunit_kzalloc(test, sizeof(*vbios), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, vbios);
+
+	vbios->bios.funcs = &dm_test_vbios_edid_funcs;
+	vbios->result = BP_RESULT_OK;
+	/* the fixture already holds a valid base EDID */
+	vbios->fake_edid = fixture.aux->edid;
+	vbios->fake_edid_size = EDID_LENGTH;
+
+	fixture.ctx->dc_bios = &vbios->bios;
+	fixture.link->ctx = fixture.ctx;
+	fixture.link->aux_mode = false;
+	fixture.link->ddc_hw_inst = GPIO_DDC_LINE_UNKNOWN;
+	fixture.link->connector_signal = SIGNAL_TYPE_EDP;
+
+	KUNIT_EXPECT_EQ(test,
+			dm_helpers_read_local_edid(fixture.ctx, fixture.link, fixture.sink),
+			EDID_OK);
+	KUNIT_EXPECT_EQ(test, fixture.sink->dc_edid.length, (uint32_t)EDID_LENGTH);
+	KUNIT_EXPECT_EQ(test, fixture.sink->edid_caps.manufacturer_id, 0xAC10);
+}
+
+/**
+ * dm_test_read_local_edid_corrupt_checksum - Test the corrupt-EDID compliance path
+ * @test: The KUnit test context
+ *
+ * The sink serves an EDID with a bad checksum, so the DDC read fails and marks
+ * the connector's EDID corrupt. The helper writes the real checksum back over
+ * AUX, clears the corrupt flag and reports EDID_BAD_CHECKSUM.
+ */
+static void dm_test_read_local_edid_corrupt_checksum(struct kunit *test)
+{
+	struct dm_test_local_edid fixture = dm_test_setup_local_edid(test);
+
+	fixture.aux->edid[EDID_LENGTH - 1] ^= 0xFF;
+
+	KUNIT_EXPECT_EQ(test,
+			dm_helpers_read_local_edid(fixture.ctx, fixture.link, fixture.sink),
+			EDID_BAD_CHECKSUM);
+	KUNIT_EXPECT_FALSE(test, fixture.aconnector->base.edid_corrupt);
+}
+
 static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* edid_extract_panel_id */
 	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
@@ -4579,6 +4695,7 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_apply_edid_quirks_disable_fams),
 	KUNIT_CASE(dm_test_apply_edid_quirks_remove_sink_ext_caps),
 	KUNIT_CASE(dm_test_apply_edid_quirks_disable_colorimetry),
+	KUNIT_CASE(dm_test_apply_edid_quirks_psr_phy_power_down),
 	KUNIT_CASE(dm_test_apply_edid_quirks_skip_phy_ssc),
 	KUNIT_CASE(dm_test_apply_edid_quirks_force_freesync_min),
 	KUNIT_CASE(dm_test_apply_edid_quirks_unknown_noop),
@@ -4591,6 +4708,7 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_parse_edid_caps_bad_checksum),
 	KUNIT_CASE(dm_test_parse_edid_caps_hdmi_frl),
 	KUNIT_CASE(dm_test_parse_edid_caps_hdmi_frl_dsc),
+	KUNIT_CASE(dm_test_parse_edid_caps_hdmi_comp_auto),
 	KUNIT_CASE(dm_test_parse_edid_caps_cea_audio),
 	KUNIT_CASE(dm_test_parse_edid_caps_cea_no_speaker),
 	/* ACPI / VBIOS / local EDID readers */
@@ -4774,6 +4892,8 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_read_local_edid_aux_mode),
 	KUNIT_CASE(dm_test_read_local_edid_test_request),
 	KUNIT_CASE(dm_test_read_local_edid_i2c_no_response),
+	KUNIT_CASE(dm_test_read_local_edid_vbios_embedded),
+	KUNIT_CASE(dm_test_read_local_edid_corrupt_checksum),
 	{}
 };
 
-- 
2.55.0

