Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66BAC02185
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 16:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E2710E08B;
	Wed, 15 Jan 2025 16:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cMyw1XLc";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 334B710E065
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 16:29:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6MwscK5zo+jn4XFXpSokw3cDRNK5l1KrUveQjxv41mW6EUTCgWYYIH3diYCZsI1mXNFJBwKfI38c4H996NX/S/Pq90eUU/2kHZHcf6JzNvTpcOFrXNyXhYnZkrBbExRY2pfRctcgiUcru3ctwqz+4OSfd/1YUIvvEdhcmLb4W/LDr30l4AOoglL1s9hec6oT6iXVTah83Z6sHUt7+UCFwkmx7+ww4kKrdiue0qGFAP2H5IL6292nQwphnfHqS6yrUsnMOx4xTc3GC95peOVGzChept/rtlNCNdBHgkNts6JBC060lF6nALsBR/EQsFQQuWWit/XiPrBef8DeDF4yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIHnatUZqh0V5eumCSHxNQ6jJhKYF9rESZU6iEvi5xA=;
 b=XRPazRD6Ap58qHhV6d/iSpWMTq22/JzEVnIbmwS/kuAv38wAtaOo8Tig2qOQBqac8KFVv2C/Crlq1y3UUhC6MbthhuD/g4qqyG9HC1zPRSdbFxPY1Sczxgohw/opXZZEll+a/k2u3ClS3r5fGbFYcqqmTorAkjJBF5bHd29ZrieWodqGQzB4Li+KbNhspeBGwnCvLWn/9TM975e61qCN4Qc9zbophgs3j/A4ZT/WPI4iax3x7iMU44F3RtMPcagkSy3Csz7J37UnpRVNvVHB7lUOsD0wmFg96Yg66aGhknOrV+e+Fc2Mf2/r3opi6YC86zsN4KOd/lIrHT8/srqHLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIHnatUZqh0V5eumCSHxNQ6jJhKYF9rESZU6iEvi5xA=;
 b=cMyw1XLcNp5SlTl5bGlUAJKRz9MsJh8eWpX2uE0eKVymbnU9bu3GkBsrwLUt9DlRVhAANieib6zYgK+Xj1iEsKHt03K4yQkda2QXPnplnX4pmvIYVkym+pIEjPidXjuGmc62/HuFv7sUC56io2KAL5p0Ty8L0VDYQmMEIwCqxog=
Received: from BY3PR05CA0048.namprd05.prod.outlook.com (2603:10b6:a03:39b::23)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.14; Wed, 15 Jan 2025 16:29:13 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::6e) by BY3PR05CA0048.outlook.office365.com
 (2603:10b6:a03:39b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 16:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 16:29:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 10:29:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Add SMUv13.0.12 PMFW headers
Date: Wed, 15 Jan 2025 11:28:19 -0500
Message-ID: <20250115162820.637642-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 00001885-ff2c-4424-7deb-08dd3581bef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?29J5yqpra5nbrbu8dgy8ClFSkmppEmjULiVgLon40f4hPxUe1ML9escZIROU?=
 =?us-ascii?Q?pFNJ7/AaAGy8xfAuAlp2zsxoHiOI8t3Gck9TdfcpbanNLzrFs7GWTa8/avXE?=
 =?us-ascii?Q?Y9rYEO3PqfBPHSXpeI8rfGjJy3xxEhgBkRxrRZDTTBwHKliKAUDe7SmAM+0c?=
 =?us-ascii?Q?pOdN0W87nlEzFCXUdZhdM+Mm7ICNKY7xDUNCtTU89885gMr3qjqg90sMvUhL?=
 =?us-ascii?Q?J6T2zpZhP9sUTcCS9fq7XxKK0Ts6cqikL+Sj2o5CfwJv7m9Xyr5m0ytz3eHm?=
 =?us-ascii?Q?sF6k0b8ipiwdtYVML9QL2/xD5ZfRHBIULVCYXy8Hjef3vRbwc1hUbaqXBBP9?=
 =?us-ascii?Q?D7XRpGHoZ2LRbDBZ5nWxaCnkgbm6J2Gxcdz9D2Ay7bcuwIv4Ziv21feMWyA4?=
 =?us-ascii?Q?cojMaFBE/mZNCBag4CO2wEe6x8wI56usPC7+OgixioziULcadyS1H47gZw4j?=
 =?us-ascii?Q?dvCm8Di3avHeAT6s+CXWCRdWqROzn9Ew/Cbe0r9fik7SC9MoJlDD4gAudjBv?=
 =?us-ascii?Q?roZVpDvqJ4dXcSGlsQ28yGM/pn6w6z/u7Ua7fUCpZXEG3oEDqpMIMuQjj6oU?=
 =?us-ascii?Q?pXkBegVtIoX3bE91YEmj1FjMwlGhGDedwSpLq/FtxiWRLgSz9REBtcz1bZFa?=
 =?us-ascii?Q?l1x3yxVn8FKoFV+P6Z5M2EU3gDo0fwlgPsk2AF6al7bFsgpb/ShBDfm8Iq7D?=
 =?us-ascii?Q?H2rWthHGu1tYXaEeEKfoZj43oaCegbFnsNZh9FZrJHTjRC/Qhr361Ssx/PhP?=
 =?us-ascii?Q?q+oZBn/M3zqdAjY5CHfkb+iA1cRwDH8/LX+NgqjhfNUrZad8qv9ll31/8wBn?=
 =?us-ascii?Q?GNw+zLZjaxgUDHS3LIT4Jue/TGF//idppvlj1ZUY2fJOWknDwn+iMeTciGPy?=
 =?us-ascii?Q?NcsKMkqx3q/SYsDrGrqz+KGSqNK/M4c0ndG2VQVuNTtSPneUbrp9YqmjB7Ko?=
 =?us-ascii?Q?y/9L/GCEcNfFRH540sfEF339l4N35rCCEdaklifHRNYjQwvVQrReLj01UeqX?=
 =?us-ascii?Q?dCbudGN/yjQq5ivslZSrNNibyXztEYwys0Wiy2DS21adsLOAJUTf9Dd22iSE?=
 =?us-ascii?Q?OPV9gF2Z64u8jV9ILcem4t7vZumRGo9U2HOxhHR5VT5EvwAcggyW6iJmY1cz?=
 =?us-ascii?Q?anhUpS4HLbUc/uovlJKs83HsnbRjzbIuSA1xxgxPPqER0icGvgMJPRHMYrQk?=
 =?us-ascii?Q?+CeWbT9R+BbVYRtNhEYHk1SrPWzn0ybakXVxw4+9faPPw1pL7tYntDN92O9J?=
 =?us-ascii?Q?WWHhn/9BRuaTsOKyinVN4N/hf7Dd+HG985q93dF4g+05ToRl4jny3B91Ttqk?=
 =?us-ascii?Q?bVekqNAYRiM6TdGuKocaWz0P1OfOD3UKXoQMUjnHDF9mYSLSs9wE6fP8yVia?=
 =?us-ascii?Q?bMZ63MG/e6eKD4J5dVP60cx2DOHz4Earqtiimt1+IHEICu86a3z5cwjd+euZ?=
 =?us-ascii?Q?LsJIehsBZ3ngFPK2t1u/W1z9+MAavdPz4KVrNB4/SCQ+HgjNs6SFZlpJB8LB?=
 =?us-ascii?Q?pqNh707LwGRfLzU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:29:12.5441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00001885-ff2c-4424-7deb-08dd3581bef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
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

From: Asad Kamal <asad.kamal@amd.com>

Add pmfw headers for smuv13.0.12 to pmfw version 86.24.0

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h  | 248 ++++++++++++++++++
 1 file changed, 248 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
new file mode 100644
index 0000000000000..859e7a3813bb5
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -0,0 +1,248 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef SMU_13_0_12_PMFW_H
+#define SMU_13_0_12_PMFW_H
+
+#define NUM_VCLK_DPM_LEVELS   4
+#define NUM_DCLK_DPM_LEVELS   4
+#define NUM_SOCCLK_DPM_LEVELS 4
+#define NUM_LCLK_DPM_LEVELS   4
+#define NUM_UCLK_DPM_LEVELS   4
+#define NUM_FCLK_DPM_LEVELS   4
+#define NUM_XGMI_DPM_LEVELS   2
+#define NUM_CXL_BITRATES      4
+#define NUM_PCIE_BITRATES     4
+#define NUM_XGMI_BITRATES     4
+#define NUM_XGMI_WIDTHS       3
+#define NUM_TDP_GROUPS        4
+#define NUM_SOC_P2S_TABLES    6
+#define NUM_GFX_P2S_TABLES    8
+#define NUM_PSM_DIDT_THRESHOLDS 3
+
+typedef enum {
+/*0*/   FEATURE_DATA_CALCULATION            = 0,
+/*1*/   FEATURE_DPM_FCLK                    = 1,
+/*2*/   FEATURE_DPM_GFXCLK                  = 2,
+/*3*/   FEATURE_DPM_LCLK                    = 3,
+/*4*/   FEATURE_DPM_SOCCLK                  = 4,
+/*5*/   FEATURE_DPM_UCLK                    = 5,
+/*6*/   FEATURE_DPM_VCN                     = 6,
+/*7*/   FEATURE_DPM_XGMI                    = 7,
+/*8*/   FEATURE_DS_FCLK                     = 8,
+/*9*/   FEATURE_DS_GFXCLK                   = 9,
+/*10*/  FEATURE_DS_LCLK                     = 10,
+/*11*/  FEATURE_DS_MP0CLK                   = 11,
+/*12*/  FEATURE_DS_MP1CLK                   = 12,
+/*13*/  FEATURE_DS_MPIOCLK                  = 13,
+/*14*/  FEATURE_DS_SOCCLK                   = 14,
+/*15*/  FEATURE_DS_VCN                      = 15,
+/*16*/  FEATURE_APCC_DFLL                   = 16,
+/*17*/  FEATURE_APCC_PLUS                   = 17,
+/*18*/  FEATURE_PPT                         = 18,
+/*19*/  FEATURE_TDC                         = 19,
+/*20*/  FEATURE_THERMAL                     = 20,
+/*21*/  FEATURE_SOC_PCC                     = 21,
+/*22*/  FEATURE_PROCHOT                     = 22,
+/*23*/  FEATURE_FDD_AID_HBM                 = 23,
+/*24*/  FEATURE_FDD_AID_SOC                 = 24,
+/*25*/  FEATURE_FDD_XCD_EDC                 = 25,
+/*26*/  FEATURE_FDD_XCD_XVMIN               = 26,
+/*27*/  FEATURE_FW_CTF                      = 27,
+/*28*/  FEATURE_SMU_CG                      = 28,
+/*29*/  FEATURE_PSI7                        = 29,
+/*30*/  FEATURE_XGMI_PER_LINK_PWR_DOWN      = 30,
+/*31*/  FEATURE_SOC_DC_RTC                  = 31,
+/*32*/  FEATURE_GFX_DC_RTC                  = 32,
+/*33*/  FEATURE_DVM_MIN_PSM                 = 33,
+/*34*/  FEATURE_PRC                         = 34,
+/*35*/  FEATURE_PSM_SQ_THROTTLER            = 35,
+/*36*/  FEATURE_PIT                         = 36,
+/*37*/  FEATURE_DVO                         = 37,
+/*38*/  FEATURE_XVMINORPSM_CLKSTOP_DS       = 38,
+
+/*39*/  NUM_FEATURES                        = 39
+} FEATURE_LIST_e;
+
+//enum for MPIO PCIe gen speed msgs
+typedef enum {
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN1,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN2,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN3,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN4,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN4_ESM,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN5,
+  PCIE_LINK_SPEED_INDEX_TABLE_COUNT
+} PCIE_LINK_SPEED_INDEX_TABLE_e;
+
+typedef enum {
+  GFX_GUARDBAND_OFFSET_0,
+  GFX_GUARDBAND_OFFSET_1,
+  GFX_GUARDBAND_OFFSET_2,
+  GFX_GUARDBAND_OFFSET_3,
+  GFX_GUARDBAND_OFFSET_4,
+  GFX_GUARDBAND_OFFSET_5,
+  GFX_GUARDBAND_OFFSET_6,
+  GFX_GUARDBAND_OFFSET_7,
+  GFX_GUARDBAND_OFFSET_COUNT
+} GFX_GUARDBAND_OFFSET_e;
+
+typedef enum {
+  GFX_DVM_MARGINHI_0,
+  GFX_DVM_MARGINHI_1,
+  GFX_DVM_MARGINHI_2,
+  GFX_DVM_MARGINHI_3,
+  GFX_DVM_MARGINHI_4,
+  GFX_DVM_MARGINHI_5,
+  GFX_DVM_MARGINHI_6,
+  GFX_DVM_MARGINHI_7,
+  GFX_DVM_MARGINLO_0,
+  GFX_DVM_MARGINLO_1,
+  GFX_DVM_MARGINLO_2,
+  GFX_DVM_MARGINLO_3,
+  GFX_DVM_MARGINLO_4,
+  GFX_DVM_MARGINLO_5,
+  GFX_DVM_MARGINLO_6,
+  GFX_DVM_MARGINLO_7,
+  GFX_DVM_MARGIN_COUNT
+} GFX_DVM_MARGIN_e;
+
+#define SMU_METRICS_TABLE_VERSION 0xF
+
+typedef struct __attribute__((packed, aligned(4))) {
+  uint64_t AccumulationCounter;
+
+  //TEMPERATURE
+  uint32_t MaxSocketTemperature;
+  uint32_t MaxVrTemperature;
+  uint32_t MaxHbmTemperature;
+  uint64_t MaxSocketTemperatureAcc;
+  uint64_t MaxVrTemperatureAcc;
+  uint64_t MaxHbmTemperatureAcc;
+
+  //POWER
+  uint32_t SocketPowerLimit;
+  uint32_t MaxSocketPowerLimit;
+  uint32_t SocketPower;
+
+  //ENERGY
+  uint64_t Timestamp;
+  uint64_t SocketEnergyAcc;
+  uint64_t CcdEnergyAcc;
+  uint64_t XcdEnergyAcc;
+  uint64_t AidEnergyAcc;
+  uint64_t HbmEnergyAcc;
+
+  //FREQUENCY
+  uint32_t GfxclkFrequencyLimit;
+  uint32_t FclkFrequency;
+  uint32_t UclkFrequency;
+  uint32_t SocclkFrequency[4];
+  uint32_t VclkFrequency[4];
+  uint32_t DclkFrequency[4];
+  uint32_t LclkFrequency[4];
+  uint64_t GfxclkFrequencyAcc[8];
+
+  //FREQUENCY RANGE
+  uint32_t MaxGfxclkFrequency;
+  uint32_t MinGfxclkFrequency;
+  uint32_t FclkFrequencyTable[4];
+  uint32_t UclkFrequencyTable[4];
+  uint32_t SocclkFrequencyTable[4];
+  uint32_t VclkFrequencyTable[4];
+  uint32_t DclkFrequencyTable[4];
+  uint32_t LclkFrequencyTable[4];
+  uint32_t MaxLclkDpmRange;
+  uint32_t MinLclkDpmRange;
+
+  //XGMI
+  uint32_t XgmiWidth;
+  uint32_t XgmiBitrate;
+  uint64_t XgmiReadBandwidthAcc[8];
+  uint64_t XgmiWriteBandwidthAcc[8];
+
+  //ACTIVITY
+  uint32_t SocketGfxBusy;
+  uint32_t DramBandwidthUtilization;
+  uint64_t SocketC0ResidencyAcc;
+  uint64_t SocketGfxBusyAcc;
+  uint64_t DramBandwidthAcc;
+  uint32_t MaxDramBandwidth;
+  uint64_t DramBandwidthUtilizationAcc;
+  uint64_t PcieBandwidthAcc[4];
+
+  //THROTTLERS
+  uint32_t ProchotResidencyAcc;
+  uint32_t PptResidencyAcc;
+  uint32_t SocketThmResidencyAcc;
+  uint32_t VrThmResidencyAcc;
+  uint32_t HbmThmResidencyAcc;
+  uint32_t GfxLockXCDMak;
+
+  // New Items at end to maintain driver compatibility
+  uint32_t GfxclkFrequency[8];
+
+  //PSNs
+  uint64_t PublicSerialNumber_AID[4];
+  uint64_t PublicSerialNumber_XCD[8];
+
+  //XGMI Data tranfser size
+  uint64_t XgmiReadDataSizeAcc[8];//in KByte
+  uint64_t XgmiWriteDataSizeAcc[8];//in KByte
+
+  //PCIE BW Data and error count
+  uint32_t PcieBandwidth[4];
+  uint32_t PCIeL0ToRecoveryCountAcc;      // The Pcie counter itself is accumulated
+  uint32_t PCIenReplayAAcc;               // The Pcie counter itself is accumulated
+  uint32_t PCIenReplayARolloverCountAcc;  // The Pcie counter itself is accumulated
+  uint32_t PCIeNAKSentCountAcc;           // The Pcie counter itself is accumulated
+  uint32_t PCIeNAKReceivedCountAcc;       // The Pcie counter itself is accumulated
+
+  // VCN/JPEG ACTIVITY
+  uint32_t VcnBusy[4];
+  uint32_t JpegBusy[32];
+
+  // PCIE LINK Speed and width
+  uint32_t PCIeLinkSpeed;
+  uint32_t PCIeLinkWidth;
+
+  // PER XCD ACTIVITY
+  uint32_t GfxBusy[8];
+  uint64_t GfxBusyAcc[8];
+
+  //PCIE BW Data and error count
+  uint32_t PCIeOtherEndRecoveryAcc;       // The Pcie counter itself is accumulated
+
+  //Total App Clock Counter
+  uint64_t GfxclkBelowHostLimitAcc[8];
+} MetricsTable_t;
+
+#define SMU_VF_METRICS_TABLE_VERSION 0x3
+
+typedef struct __attribute__((packed, aligned(4))) {
+  uint32_t AccumulationCounter;
+  uint32_t InstGfxclk_TargFreq;
+  uint64_t AccGfxclk_TargFreq;
+  uint64_t AccGfxRsmuDpm_Busy;
+} VfMetricsTable_t;
+
+#endif
-- 
2.47.1

