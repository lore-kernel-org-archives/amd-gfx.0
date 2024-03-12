Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A282C54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C31894EA;
	Tue, 12 Mar 2024 09:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mxUZyOUh";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D7E112B70
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGLDI8Xll94NkpX5G5eNCiE3qI1gRZ/o05b+aHlc0nEesxBFl5WGlnYjn1mZJSNcmOAACfk8S2+tDwR8fUjsTIyFjND6eruQE6NADsasnWu3jQnHXXx2G2dPX6u9Eb+FRBX2YAsMx+EkIqyPgXiTD1BfG9m7LqWIHOQoHSWEdD1dxfxW7trgk6SsRC49xrpkuhd8NvNnsXg86cqWR84HVYzdAgt7/p3TtbEPSxpn9kAiIHSwkZsCEuxwuZGN3BtRqrA7z8onCYKwOCPI3gETGqEhbamGxBE2F1vTuwg4w+o55+xQEUqyoxLmv+FSfCK94KVEdFFg8mIin9pdGlgw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vKNl6YL+49RX3zmOoI412Q5UB2JlSBNl7eHa8sakBg=;
 b=nzYlmz62/q9yOpD214o7Oi46SrLNuSHyGRWLckjk3b9x3GL8E6ZVmKgMLExWEhYwmiu4SnLhfrQYsU/I4Snvnt8xn9beFJj6v7xwJJEI5h9/bTHyLIc4oU7BcRhmAEhTaI+FJJsvKsGpz/5UUXS0SPY5G7YX67nCQBmz84+jyjlre1DOpkMNbyqBWJWZAPuIl8f9XG7pXCanQ0LmUc7zqiBbcKsOAWmqF4AuqlzBy0f9tovB8lmev4LBOl/X5x2DZ+GEfxurh8+q3qD6+z6rg296wjW9DCuyEtAAZyw+CRIDVtj5XGqcDgM2dq37AD89ggy5rxo/AxpUWqO311/ing==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vKNl6YL+49RX3zmOoI412Q5UB2JlSBNl7eHa8sakBg=;
 b=mxUZyOUh5bm4CfdoWpi08/XgkojDfBVshkjHQ+rybMafZ9ne+m5RgqX9Ba6/ZAAX9W8O8AjEEmRr5xELYeoNeQioy/XoiJTnXn7Gv9pDzSGeW1xckoefNCoioRNiQ+yMW+lA06r82M+YK79iWREi3EEyreGgWe7HCn6fWi8L92M=
Received: from DS7PR03CA0197.namprd03.prod.outlook.com (2603:10b6:5:3b6::22)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 09:22:12 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::1b) by DS7PR03CA0197.outlook.office365.com
 (2603:10b6:5:3b6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 09:22:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:22:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:22:09 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:22:06 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>
Subject: [PATCH 12/43] drm/amd/display: Add missing registers and offset
Date: Tue, 12 Mar 2024 17:20:05 +0800
Message-ID: <20240312092036.3283319-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|SN7PR12MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: d35c7106-3020-436d-6bb9-08dc4275e66e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xn4t8fRVzo/y7eM3zPfjLwQPu8f6idtPhox1uwUurTUfinB9Ei4VBMiNWTJHF9/U+0Qm8V7hMi2a6iMe6veLZXs8BIPABxybjELaBfDZTAYPZxxRPqWIiRE52nILmjtt60bfe7uuF6fXmoJ5BJxpHjld62icJvcnP5F04Q7K+EGGuep33ByJXmf8vthJg9LYjzY5wgh8PskM1tvwKDJgp7RD+DrB6b5VbIsYhbdkCZWZVyh4/OPkcrQseBCin8AgVTokm/EYCPOf+awnWko9ahKoU/6ezax71e+NcDoOPfusglrcKBSKUoases7ZpXP2Z4YRYjipBLJU7UEVx+/INFesAjCiarm5S9ytjERqNfES67gT7wBAeCLp00ZQY2U20/KQ/plQOvibTKbX6bVS6mdv0cy7jD+20sIxHbfUmDXEZT/GJUw44RoYhCTCgyQ3vFFzVNgAqMscICuWET9m+B+lSggQIOsT4yPl+uoDdMUOpYs5/cf/PDL8/CQgyQSj5w8x8q22GmeK2ThfRhtD3wBwSfsLfe/QPGQ5upW+KUPjjI+hPzBic+PkOyX+TTyKBvra6Zg7HPaoJJELNZoCC0WGiWG9nqRZZQUbwwIJ9CLuiG1COMcEQittECujMpMmK06dJ3tDCO4VCacStwBhaA3pnfTKyVRzuE+3PtYQeunn0rQTkpcozGF2vrqycH5cGv8AHllpYHVUSLQO2ju3tF2Qu9jVnRRYdGghh1oUf7t1MkpOK98TTwTgnlfohHkW
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:22:12.3589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35c7106-3020-436d-6bb9-08dc4275e66e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
Registers and offset are missing. Add it back

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../include/asic_reg/dcn/dcn_3_2_1_offset.h   | 37 ++++++++++++++++++-
 .../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h  | 16 ++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h
index 3bd8792fd7b3..a04b8c32c564 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_offset.h
@@ -1719,6 +1719,10 @@
 #define regDCHUBBUB_TIMEOUT_INTERRUPT_STATUS_BASE_IDX                                                   2
 #define regFMON_CTRL                                                                                    0x0541
 #define regFMON_CTRL_BASE_IDX                                                                           2
+#define regDCHUBBUB_TEST_DEBUG_INDEX                                                                    0x0542
+#define regDCHUBBUB_TEST_DEBUG_INDEX_BASE_IDX                                                           2
+#define regDCHUBBUB_TEST_DEBUG_DATA                                                                     0x0543
+#define regDCHUBBUB_TEST_DEBUG_DATA_BASE_IDX                                                            2
 
 
 // addressBlock: dce_dc_dchubbubl_hubbub_sdpif_dispdec
@@ -3573,6 +3577,10 @@
 #define regCM0_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM0_CM_COEF_FORMAT                                                                           0x0d8c
 #define regCM0_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM0_CM_TEST_DEBUG_INDEX                                                                      0x0d8d
+#define regCM0_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM0_CM_TEST_DEBUG_DATA                                                                       0x0d8e
+#define regCM0_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp0_dispdec_dpp_top_dispdec
@@ -3959,6 +3967,10 @@
 #define regCM1_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM1_CM_COEF_FORMAT                                                                           0x0ef7
 #define regCM1_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM1_CM_TEST_DEBUG_INDEX                                                                      0x0ef8
+#define regCM1_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM1_CM_TEST_DEBUG_DATA                                                                       0x0ef9
+#define regCM1_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp1_dispdec_dpp_top_dispdec
@@ -4345,6 +4357,10 @@
 #define regCM2_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM2_CM_COEF_FORMAT                                                                           0x1062
 #define regCM2_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM2_CM_TEST_DEBUG_INDEX                                                                      0x1063
+#define regCM2_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM2_CM_TEST_DEBUG_DATA                                                                       0x1064
+#define regCM2_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp2_dispdec_dpp_top_dispdec
@@ -4731,6 +4747,10 @@
 #define regCM3_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM3_CM_COEF_FORMAT                                                                           0x11cd
 #define regCM3_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM3_CM_TEST_DEBUG_INDEX                                                                      0x11ce
+#define regCM3_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM3_CM_TEST_DEBUG_DATA                                                                       0x11cf
+#define regCM3_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp3_dispdec_dpp_top_dispdec
@@ -11789,6 +11809,10 @@
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x3035
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define regDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x303a
+#define regDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
+#define regDSCC0_DSCC_TEST_DEBUG_DATA0                                                                  0x303b
+#define regDSCC0_DSCC_TEST_DEBUG_DATA0_BASE_IDX                                                         2
 
 
 // addressBlock: dce_dc_dsc0_dispdec_dsccif_dispdec
@@ -11897,6 +11921,10 @@
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x3091
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define regDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x3096
+#define regDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
+#define regDSCC1_DSCC_TEST_DEBUG_DATA0                                                                  0x3097
+#define regDSCC1_DSCC_TEST_DEBUG_DATA0_BASE_IDX                                                         2
 
 
 // addressBlock: dce_dc_dsc1_dispdec_dsccif_dispdec
@@ -12005,7 +12033,10 @@
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x30ed
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
-
+#define regDSCC2_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x30f2
+#define regDSCC2_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
+#define regDSCC2_DSCC_TEST_DEBUG_DATA0                                                                  0x30f3
+#define regDSCC2_DSCC_TEST_DEBUG_DATA0_BASE_IDX                                                         2
 
 // addressBlock: dce_dc_dsc2_dispdec_dsccif_dispdec
 // base address: 0x2e0
@@ -12113,6 +12144,10 @@
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x3149
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define regDSCC3_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x314e
+#define regDSCC3_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
+#define regDSCC3_DSCC_TEST_DEBUG_DATA0                                                                  0x314f
+#define regDSCC3_DSCC_TEST_DEBUG_DATA0_BASE_IDX                                                         2
 
 
 // addressBlock: dce_dc_dsc3_dispdec_dsccif_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h
index e82dffc2b9b0..ce773fca621f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_1_sh_mask.h
@@ -11547,6 +11547,11 @@
 #define CM0_CM_COEF_FORMAT__CM_BIAS_FORMAT_MASK                                                               0x00000001L
 #define CM0_CM_COEF_FORMAT__CM_POST_CSC_COEF_FORMAT_MASK                                                      0x00000010L
 #define CM0_CM_COEF_FORMAT__CM_GAMUT_REMAP_COEF_FORMAT_MASK                                                   0x00000100L
+//CM0_CM_TEST_DEBUG_INDEX
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX__SHIFT                                                   0x0
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN__SHIFT                                                0x8
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX_MASK                                                     0x000000FFL
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN_MASK                                                  0x00000100L
 
 
 // addressBlock: dce_dc_dpp0_dispdec_dpp_top_dispdec
@@ -42315,6 +42320,15 @@
 //DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL
 #define DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__SHIFT  0x0
 #define DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_MASK  0x0003FFFFL
+//DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS0_ROTATE__SHIFT                                  0x0
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS1_ROTATE__SHIFT                                  0x8
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS2_ROTATE__SHIFT                                  0x10
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS3_ROTATE__SHIFT                                  0x18
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS0_ROTATE_MASK                                    0x0000001FL
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS1_ROTATE_MASK                                    0x00001F00L
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS2_ROTATE_MASK                                    0x001F0000L
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS3_ROTATE_MASK                                    0x1F000000L
 
 
 // addressBlock: dce_dc_dsc0_dispdec_dsccif_dispdec
@@ -42348,7 +42362,9 @@
 #define DSC_TOP0_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK                                                  0x00000100L
 //DSC_TOP0_DSC_DEBUG_CONTROL
 #define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_TEST_CLOCK_MUX_SEL__SHIFT                                             0x4
 #define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                                                           0x00000001L
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_TEST_CLOCK_MUX_SEL_MASK                                               0x00000070L
 
 
 // addressBlock: dce_dc_dsc1_dispdec_dscc_dispdec
-- 
2.37.3

