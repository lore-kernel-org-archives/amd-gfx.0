Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA08ECD128E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1095F112543;
	Thu, 28 Mar 2024 19:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vUjp2Go5";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7206A112339
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq7SeCix/viWaSC/NgIyKCQu3KBDrHpLK/8wvTIf0wjv1qAufUQUVVtn2Bkr1E06B9B9AzPB+dbpycghBy+SE56wDRBxatgAEyS7bMMIakHWXkyNQqC7lTrVBkV9utP805LqLwvbO04apf9cjDw/eleyDpQ5YtZVB4Zf8IAMmMrl23k6dFet5pvKKSHdxH7tmT80KTxVzmDtCZaCj4DeNnfXCRerSZUehow7cI1+LChNjkelhQzNGAuiYkkwJvoprfl5u8GMSRNGyI8Y0CQij8vlStz7gz+rbctyUOpPQtg8My5Fkyuy+EXiARvR10eTK1ur1LRxGsmIFhFGllu7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEJ9zyTuch6wc77G8lT68zOD6W3T95xijEA5ZllFJGQ=;
 b=mR1zhlTpPZ+kurdSVO/Q7qVcbcoH/ka+E+NsSSQhLD1loZFUPxivHY3GQgoTUVFNRx+0K4uub9gsDHknP+Btx9Kc0pQui9AiIEfyul1WnD/42LkR4QAbtIVuGJpxQtX3kAf6tC0v6tuXNvIJgfh5/nabH93i4L0LaTin2p2qc2z92I7yBfpi6vgasj/qdzIHOdmbFtNaCLP7kjKhRyPkSfMvmwJqr2r1+pqGc7jcXwPDqAkUiWgEJtQHdZqEaZkNfVIDxxf/1ZGNGaCOqFFR6mczCTImOHcB5Og6/4zlSICyRqq/SWuTYz8gVXVtjgcMsHR07HIpK1xMKGcIsswm7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEJ9zyTuch6wc77G8lT68zOD6W3T95xijEA5ZllFJGQ=;
 b=vUjp2Go50VfiIgCA48bS1knxpR4cn1Pzuyi7mMBsSF7aqd10X4dKMwGnrc3gBkl/oqppUCWmHzFNKbEm6UVJowIWY9+58KJNnJ8n4Vw6doqwzi231EHkrSpPxYXhHZc4JynYqOBQDRXzRO9bln9i/S63DHak2bqVOos50ifDl1c=
Received: from CH5PR02CA0022.namprd02.prod.outlook.com (2603:10b6:610:1ed::8)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.40; Thu, 28 Mar
 2024 19:52:07 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::a2) by CH5PR02CA0022.outlook.office365.com
 (2603:10b6:610:1ed::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:04 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:04 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 31/43] drm/amd/display: Add some missing debug registers
Date: Thu, 28 Mar 2024 15:50:35 -0400
Message-ID: <20240328195047.2843715-32-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: f070af2c-a44a-458b-0bc2-08dc4f608c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUyRZwuSb/J6MBPUB+ZTftVlgNhLpFEeBVoYWj0AloBlP8UBsrHjrmrAqZ/aAvLgmJYuDnVmFWyvmhe2WQ253h2klQ04p1qpRkq5axmxwjLHLDz7p5U0BygzKh5G4uXxOWsz9eoOEA0GgJw9mKgSaFkwcmCQa1nGGVkXTa7IUCVYcDYmra0fRMgyj75dwtVhPlouNUMYU1C3/A1q+z4CEyfI3oM6uMKmybeuB9vlSpGyKeth39KTAntK4L6ciDOPL8c5GjrHNaAw70JJ8/sKSmJZ+vJalkvS3BRxv3qO8f6rF2QNsziR3ELwmlq0UaZ/VDYyXtgp1OD/QBJNzJzoHrDNcmp4c83Fdem3um3yBw2b2txzQrePqTZ6b8bYmWLZQoXrwDdbARRyq2gfSoUf9jhFFKtwSLrr4Cevm/sKjCRhW9HFoRXvKEZddPc5mzL81Oh9H2hKCX1wWHi1FqW7PeihHxlQjGVS9xZee498y2jpgxI7Lux0nKkThKKRSuqEjkD73R7j0b/KJfJ/Fmp5+PolempG0Pcc2/huYe8NGWPgiwwGljtdfKxQRCWbGF5HWkFcLGpUzg9cUtICyZqud72dA+ar2rXImyDupV3F1zhwb2duJr1OTydLzbru2pL4N+A2hIgElusRBLj5MARz6Mp6u/gW9+Mw4ZGR9p1qmR9ojwXpFM3AJa0HgyvcSD056CMQVLUWN6MCv4gDXN/zapojDHjnFy6eC5dfKKBlbgGcVQDuY8+jshhw7FlHnZCk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:07.0992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f070af2c-a44a-458b-0bc2-08dc4f608c82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |  4 ++++
 .../include/asic_reg/dcn/dcn_3_0_0_offset.h   | 24 +++++++++++++++++++
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  |  9 +++++++
 .../include/asic_reg/dcn/dcn_3_0_2_offset.h   | 20 ++++++++++++++++
 .../include/asic_reg/dcn/dcn_3_0_2_sh_mask.h  |  8 +++++++
 .../include/asic_reg/dcn/dcn_3_0_3_offset.h   |  8 +++++++
 .../include/asic_reg/dcn/dcn_3_0_3_sh_mask.h  |  7 ++++++
 .../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h  |  5 ++++
 8 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
index 2ac8045a87a1..269f437c1633 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h
@@ -132,6 +132,8 @@
 	SRI(CM_POST_CSC_B_C33_C34, CM, id), \
 	SRI(CM_MEM_PWR_CTRL, CM, id), \
 	SRI(CM_CONTROL, CM, id), \
+	SRI(CM_TEST_DEBUG_INDEX, CM, id), \
+	SRI(CM_TEST_DEBUG_DATA, CM, id), \
 	SRI(FORMAT_CONTROL, CNVC_CFG, id), \
 	SRI(CNVC_SURFACE_PIXEL_FORMAT, CNVC_CFG, id), \
 	SRI(CURSOR0_CONTROL, CNVC_CUR, id), \
@@ -294,6 +296,7 @@
 	TF_SF(CM0_CM_POST_CSC_C11_C12, CM_POST_CSC_C12, mask_sh), \
 	TF_SF(CM0_CM_POST_CSC_C33_C34, CM_POST_CSC_C33, mask_sh), \
 	TF_SF(CM0_CM_POST_CSC_C33_C34, CM_POST_CSC_C34, mask_sh), \
+	TF_SF(CM0_CM_TEST_DEBUG_INDEX, CM_TEST_DEBUG_INDEX, mask_sh), \
 	TF_SF(CNVC_CFG0_FORMAT_CONTROL, CNVC_BYPASS, mask_sh), \
 	TF2_SF(CNVC_CFG0, FORMAT_CONTROL__ALPHA_EN, mask_sh), \
 	TF_SF(CNVC_CFG0_FORMAT_CONTROL, FORMAT_EXPANSION_MODE, mask_sh), \
@@ -426,6 +429,7 @@
 	type CM_GAMCOR_LUT_DATA; \
 	type CM_GAMCOR_LUT_WRITE_COLOR_MASK; \
 	type CM_GAMCOR_LUT_READ_COLOR_SEL; \
+	type CM_GAMCOR_LUT_READ_DBG; \
 	type CM_GAMCOR_LUT_HOST_SEL; \
 	type CM_GAMCOR_LUT_CONFIG_MODE; \
 	type CM_GAMCOR_LUT_STATUS; \
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
index f2f8f9b39c6b..b5bfaa64a9db 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
@@ -4513,6 +4513,10 @@
 #define mmCM0_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM0_CM_3DLUT_OUT_OFFSET_B                                                                    0x0e18
 #define mmCM0_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM0_CM_TEST_DEBUG_INDEX                                                                      0x0e19
+#define mmCM0_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM0_CM_TEST_DEBUG_DATA                                                                       0x0e1a
+#define mmCM0_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -5201,6 +5205,10 @@
 #define mmCM1_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM1_CM_3DLUT_OUT_OFFSET_B                                                                    0x0f83
 #define mmCM1_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM1_CM_TEST_DEBUG_INDEX                                                                      0x0f84
+#define mmCM1_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM1_CM_TEST_DEBUG_DATA                                                                       0x0f85
+#define mmCM1_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp1_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -5888,6 +5896,10 @@
 #define mmCM2_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM2_CM_3DLUT_OUT_OFFSET_B                                                                    0x10ee
 #define mmCM2_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM2_CM_TEST_DEBUG_INDEX                                                                      0x10ef
+#define mmCM2_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM2_CM_TEST_DEBUG_DATA                                                                       0x10f0
+#define mmCM2_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp2_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -6576,6 +6588,10 @@
 #define mmCM3_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM3_CM_3DLUT_OUT_OFFSET_B                                                                    0x1259
 #define mmCM3_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM3_CM_TEST_DEBUG_INDEX                                                                      0x125a
+#define mmCM3_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM3_CM_TEST_DEBUG_DATA                                                                       0x125b
+#define mmCM3_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp3_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -7264,6 +7280,10 @@
 #define mmCM4_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM4_CM_3DLUT_OUT_OFFSET_B                                                                    0x13c4
 #define mmCM4_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM4_CM_TEST_DEBUG_INDEX                                                                      0x13c5
+#define mmCM4_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM4_CM_TEST_DEBUG_DATA                                                                       0x13c6
+#define mmCM4_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp4_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -7952,6 +7972,10 @@
 #define mmCM5_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM5_CM_3DLUT_OUT_OFFSET_B                                                                    0x152f
 #define mmCM5_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM5_CM_TEST_DEBUG_INDEX                                                                      0x1530
+#define mmCM5_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM5_CM_TEST_DEBUG_DATA                                                                       0x1531
+#define mmCM5_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp5_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
index e0a447351623..a2ab7f9efc83 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
@@ -16739,6 +16739,15 @@
 #define CM0_CM_3DLUT_OUT_OFFSET_B__CM_3DLUT_OUT_SCALE_B__SHIFT                                                0x10
 #define CM0_CM_3DLUT_OUT_OFFSET_B__CM_3DLUT_OUT_OFFSET_B_MASK                                                 0x0000FFFFL
 #define CM0_CM_3DLUT_OUT_OFFSET_B__CM_3DLUT_OUT_SCALE_B_MASK                                                  0xFFFF0000L
+//CM0_CM_TEST_DEBUG_INDEX
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX__SHIFT                                                   0x0
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN__SHIFT                                                0x8
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX_MASK                                                     0x000000FFL
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN_MASK                                                  0x00000100L
+//CM0_CM_TEST_DEBUG_DATA
+#define CM0_CM_TEST_DEBUG_DATA__CM_TEST_DEBUG_DATA__SHIFT                                                     0x0
+#define CM0_CM_TEST_DEBUG_DATA__CM_TEST_DEBUG_DATA_MASK                                                       0xFFFFFFFFL
+
 
 // addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
 //DC_PERFMON12_PERFCOUNTER_CNTL
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
index b45a35aae241..bf84f97d9162 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_offset.h
@@ -4466,6 +4466,10 @@
 #define mmCM0_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM0_CM_3DLUT_OUT_OFFSET_B                                                                    0x0e18
 #define mmCM0_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM0_CM_TEST_DEBUG_INDEX                                                                      0x0e19
+#define mmCM0_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM0_CM_TEST_DEBUG_DATA                                                                       0x0e1a
+#define mmCM0_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -5154,6 +5158,10 @@
 #define mmCM1_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM1_CM_3DLUT_OUT_OFFSET_B                                                                    0x0f83
 #define mmCM1_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM1_CM_TEST_DEBUG_INDEX                                                                      0x0f84
+#define mmCM1_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM1_CM_TEST_DEBUG_DATA                                                                       0x0f85
+#define mmCM1_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp1_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -5841,6 +5849,10 @@
 #define mmCM2_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM2_CM_3DLUT_OUT_OFFSET_B                                                                    0x10ee
 #define mmCM2_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM2_CM_TEST_DEBUG_INDEX                                                                      0x10ef
+#define mmCM2_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM2_CM_TEST_DEBUG_DATA                                                                       0x10f0
+#define mmCM2_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp2_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -6529,6 +6541,10 @@
 #define mmCM3_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM3_CM_3DLUT_OUT_OFFSET_B                                                                    0x1259
 #define mmCM3_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM3_CM_TEST_DEBUG_INDEX                                                                      0x125a
+#define mmCM3_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM3_CM_TEST_DEBUG_DATA                                                                       0x125b
+#define mmCM3_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp3_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -7217,6 +7233,10 @@
 #define mmCM4_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM4_CM_3DLUT_OUT_OFFSET_B                                                                    0x13c4
 #define mmCM4_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM4_CM_TEST_DEBUG_INDEX                                                                      0x13c5
+#define mmCM4_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM4_CM_TEST_DEBUG_DATA                                                                       0x13c6
+#define mmCM4_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp4_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
index 3dae29f9581e..56cdb219874a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_2_sh_mask.h
@@ -15676,6 +15676,14 @@
 #define CM0_CM_3DLUT_OUT_OFFSET_B__CM_3DLUT_OUT_SCALE_B__SHIFT                                                0x10
 #define CM0_CM_3DLUT_OUT_OFFSET_B__CM_3DLUT_OUT_OFFSET_B_MASK                                                 0x0000FFFFL
 #define CM0_CM_3DLUT_OUT_OFFSET_B__CM_3DLUT_OUT_SCALE_B_MASK                                                  0xFFFF0000L
+//CM0_CM_TEST_DEBUG_INDEX
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX__SHIFT                                                   0x0
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN__SHIFT                                                0x8
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX_MASK                                                     0x000000FFL
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN_MASK                                                  0x00000100L
+//CM0_CM_TEST_DEBUG_DATA
+#define CM0_CM_TEST_DEBUG_DATA__CM_TEST_DEBUG_DATA__SHIFT                                                     0x0
+#define CM0_CM_TEST_DEBUG_DATA__CM_TEST_DEBUG_DATA_MASK                                                       0xFFFFFFFFL
 
 
 // addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
index daa8130636f0..e90f31bbb4d2 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
@@ -3110,6 +3110,10 @@
 #define mmCM0_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM0_CM_3DLUT_OUT_OFFSET_B                                                                    0x0e18
 #define mmCM0_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM0_CM_TEST_DEBUG_INDEX                                                                      0x0e19
+#define mmCM0_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM0_CM_TEST_DEBUG_DATA                                                                       0x0e1a
+#define mmCM0_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp0_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
@@ -3798,6 +3802,10 @@
 #define mmCM1_CM_3DLUT_OUT_OFFSET_G_BASE_IDX                                                           2
 #define mmCM1_CM_3DLUT_OUT_OFFSET_B                                                                    0x0f83
 #define mmCM1_CM_3DLUT_OUT_OFFSET_B_BASE_IDX                                                           2
+#define mmCM1_CM_TEST_DEBUG_INDEX                                                                      0x0f84
+#define mmCM1_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define mmCM1_CM_TEST_DEBUG_DATA                                                                       0x0f85
+#define mmCM1_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dce_dc_dpp1_dispdec_dpp_dcperfmon_dc_perfmon_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
index 5c469cf635e5..3be176174b20 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
@@ -10701,6 +10701,13 @@
 #define CM0_CM_COEF_FORMAT__CM_BIAS_FORMAT_MASK                                                               0x00000001L
 #define CM0_CM_COEF_FORMAT__CM_POST_CSC_COEF_FORMAT_MASK                                                      0x00000010L
 #define CM0_CM_COEF_FORMAT__CM_GAMUT_REMAP_COEF_FORMAT_MASK                                                   0x00000100L
+
+//CM0_CM_TEST_DEBUG_INDEX
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX__SHIFT                                                   0x0
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN__SHIFT                                                0x8
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX_MASK                                                     0x000000FFL
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN_MASK                                                  0x00000100L
+
 //CM0_CM_SHAPER_CONTROL
 #define CM0_CM_SHAPER_CONTROL__CM_SHAPER_LUT_MODE__SHIFT                                                      0x0
 #define CM0_CM_SHAPER_CONTROL__CM_SHAPER_MODE_CURRENT__SHIFT                                                  0x2
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
index 0691e328d0f0..d70518307a34 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
@@ -11544,6 +11544,11 @@
 #define CM0_CM_COEF_FORMAT__CM_BIAS_FORMAT_MASK                                                               0x00000001L
 #define CM0_CM_COEF_FORMAT__CM_POST_CSC_COEF_FORMAT_MASK                                                      0x00000010L
 #define CM0_CM_COEF_FORMAT__CM_GAMUT_REMAP_COEF_FORMAT_MASK                                                   0x00000100L
+//CM0_CM_TEST_DEBUG_INDEX
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX__SHIFT                                                   0x0
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN__SHIFT                                                0x8
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_INDEX_MASK                                                     0x000000FFL
+#define CM0_CM_TEST_DEBUG_INDEX__CM_TEST_DEBUG_WRITE_EN_MASK                                                  0x00000100L
 
 
 // addressBlock: dcn_dc_dpp0_dispdec_dpp_top_dispdec
-- 
2.34.1

