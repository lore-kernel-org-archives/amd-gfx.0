Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DBDC25B75
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 19:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87EA10F2B4;
	Thu, 23 May 2024 19:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hd7z+Mmg";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BED210F2AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 19:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFDVJHA160rwFnAFX4sQH72Od0NL2173xtJmEfKBvPXPYB+p8XqyJNfmuZfUlsMvrPraE70BgD2U/0C0bRIMdYKPPfLik8ZaSdz2Nl/059mGgQp7asRBvjIDI0JP6bDY/vrEspMivsYkxbGgOOO8XDu00sOxMSaNRIK4JDnilSZqu4jcqWEYgEgJRAI9qsH2RKj8hYduxaGBYr71ExzoCBzieZ2j5o6oCBa6gBbbpTJv/CpHxsi7xBZ3ndmnQCee1lCV7vRbvhv+1pmkdb0AfyMWXRUG1sznKsZt4fvlToQj6DAW1CHQeVFRQfq5R2CLe/XSUyCy9vdt+jR+DWscng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9vGV3QLPf1+3slwkqaPMrGobfqaxywKKjpLvmbvXK4=;
 b=HGAUeU8A+PHuMIT7IDAXxKOXuVdp0EtykU08AgMY8cWiWxPZixxuDPSqWdOPznpycnbFn1q9w/mjXT79YwBXUAiaopOzbr/lhY//9cuZ3y8FmoE+aAHxYvQ7jbAq0xClwdiui3SV3rZfCiv5IsNAzx9fQhnCpRrzWRFqZZNTk+T331b7fWY+YVO0FRY0OMoEkZJifuHWJYWfQnVw+9wKvYsflBKThcS/Ykwon1Yv0DtN5+BwnOsJV+VnOmM0JNWCiCUrFR+e79ZzD9Z6h4W14iqUg60Zsf/m4al5LvFsI28XWfvhdiytTjDD7hK2XTOlvXl8dTtSZY0Hu8XRkNY94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9vGV3QLPf1+3slwkqaPMrGobfqaxywKKjpLvmbvXK4=;
 b=hd7z+Mmgx/7gTTIk+vNi+r/Q0Cq/nY14N1A0mFTPUsRPv/HOi8inITxD1T1CjuoqyTDRP8UhvpJ/K7ydf3fHIBjTwudzcjPZl0DPr6icfz9mHdQ28+Nh6DPsRHB0Pudv/i1Exk19mlFNwevLUWlNgWP6/N1SrwTaaw/vxwCk6Kk=
Received: from PH7PR17CA0065.namprd17.prod.outlook.com (2603:10b6:510:325::9)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.31; Thu, 23 May
 2024 19:21:24 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::c7) by PH7PR17CA0065.outlook.office365.com
 (2603:10b6:510:325::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22 via Frontend
 Transport; Thu, 23 May 2024 19:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 19:21:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 14:21:23 -0500
Received: from debian.net (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 23 May 2024 14:21:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 10/13] drm/amd/display: Add missing registers for DCN401
Date: Thu, 23 May 2024 19:20:24 +0000
Message-ID: <20240523192027.50630-10-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240523192027.50630-1-aurabindo.pillai@amd.com>
References: <20240523192027.50630-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c6d172-dff0-475b-072b-08dc7b5d892a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kIx/lPjy1v0Ej6KgElGG6Xr/6LjuiKbjmt79wAoQXbLA9YTrvBnDq+lgljlz?=
 =?us-ascii?Q?Hwfcip8FKihUjobSGanDrFFIz5MPjMqpJTRo9I7zFhhmPivSvxabwFKW1W9e?=
 =?us-ascii?Q?iYT9sybmvs9nKqV7Jsjvq3S97TJblN6lETr3de7A1odpmOeqfnyZEiziJNna?=
 =?us-ascii?Q?Qn7d7bMRZQggHT1LJ3utQD5TnuW8C5IeR/LvEsG9IYEZ0jXDDVv11A3I8QHd?=
 =?us-ascii?Q?oliUGmIEWyQcfkcYugAbYmQMQdMct/P8xjdrNHcMQzUrA6qimFjvK+Mgr1lA?=
 =?us-ascii?Q?JMS83sZQC3WEszFnhKBSJKQ9Uy/lc8kOtKS7xX/jJH+PG+yorGgdo6Aavprh?=
 =?us-ascii?Q?ccdHCWZ0zXmTBmVzKj/lOmn0R4RQjyNublTdzCjhFmo3GbvK8f3dmvmO/WWu?=
 =?us-ascii?Q?o8fUd7Xv5oBvE4TIhYV1rSrgV9LYuIsdYVW8kPIGs9InnVtf4RZisRrcLLYq?=
 =?us-ascii?Q?UtOjvkjauXkTnx770Kq4o0bY7IKorp08HTdQMqxOrPsUlurZ7baiZLuXL2KT?=
 =?us-ascii?Q?P5N0c0uUrlWYg9Focp3pgHq0Sb58Fsure201KootaGQ1MUzwCNxzoVGBATTg?=
 =?us-ascii?Q?Qip8wxvcFq5q96ynSgXJU8S84mm/AWO+ToP1k0RJciVYfcZxIiZ9U/G+HPzs?=
 =?us-ascii?Q?7oP7V8zNIVGbTcdJmV3DkO0J3Ut2xU2EWPBGOvciB8aZEo7rRHdpl6eQsjN7?=
 =?us-ascii?Q?QGMIJFahlObBOEcOIt+0sj3adLAtgCdm+xQ8llMoWQGIQGx1MTKKa6HN0JK3?=
 =?us-ascii?Q?FXqYakaCwHC3VDV6S8YXw73ggRoHvCj/cREZeh+je3uSBl+dyxlF0VUD0jPv?=
 =?us-ascii?Q?BlEMot9jxIRn7N3yAag1Ei0vwXcf66yst3qOzEWv2OpyjYgTZsokhjRQfLtp?=
 =?us-ascii?Q?UxDZQGGYVbxFowo+6EFZ8Hj77GGIFCzxoPGSmOKmCEe6D+lmk3McD/DuQcw+?=
 =?us-ascii?Q?VRodW9zKe2rn/K/j+0zuzJ+3qCP55zoP2UbwUidUAaxD/XVs7iSBvmfQ0Fl9?=
 =?us-ascii?Q?O9AqyXkNeo9LPPCDWiSIRwECJB4Fu9xvLlAc4ZasDT65PxmzyOek2+zy+TlA?=
 =?us-ascii?Q?ieMB1rJAIpkaHJPOJVIbqFeHNg7G70dPXKwHch3iVQAQVoDy/6W2IPSxIq99?=
 =?us-ascii?Q?CyEyaPmnoG1gstKncL7GdYHbOAaz9y771V96uAac5FjvSRP6xQ2JLdselomF?=
 =?us-ascii?Q?/ZjLo8BIDX3hT1egS4mlToM465bknWYEL+X3NP+JpuPK9xk3JyLS56a4jbfC?=
 =?us-ascii?Q?zyJReli/QQBIHX2E+VA9SW2TR6iJlXT9c+a/Q4RByNvK0o2hwvkPMSIN4BBE?=
 =?us-ascii?Q?PW3Xl10mLAQ9J0CsrFAv2/1/aDfk0Z6O7lqxOEg5Lz2v4E+7a74lAyFr7M3l?=
 =?us-ascii?Q?OaCUaoKgGHf6l3OZt5PZ5+o+RCt0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 19:21:24.2082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c6d172-dff0-475b-072b-08dc7b5d892a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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
---
 .../include/asic_reg/dcn/dcn_4_1_0_offset.h   | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
index cd9d01fc12af..5dabf0abccce 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
@@ -258,6 +258,17 @@
 #define regHDMISTREAMCLK0_DTO_PARAM                                                                     0x005b
 #define regHDMISTREAMCLK0_DTO_PARAM_BASE_IDX                                                            2
 
+// base address: 0x0
+
+
+// base address: 0x30
+
+
+// addressBlock: dcn_dcec_dmu_fgsec_dispdec
+// base address: 0x0
+#define regDMCUB_RBBMIF_SEC_CNTL                                                                        0x017a
+#define regDMCUB_RBBMIF_SEC_CNTL_BASE_IDX                                                               2
+
 // addressBlock: dcn_dcec_dmu_rbbmif_dispdec
 // base address: 0x0
 #define regRBBMIF_TIMEOUT                                                                               0x017f
@@ -861,6 +872,10 @@
 #define regDWB_OVERFLOW_COUNTER_BASE_IDX                                                                2
 #define regDWB_SOFT_RESET                                                                               0x323b
 #define regDWB_SOFT_RESET_BASE_IDX                                                                      2
+#define regDWB_DEBUG_CTRL                                                                               0x323c
+#define regDWB_DEBUG_CTRL_BASE_IDX                                                                      2
+#define regDWB_DEBUG                                                                                    0x323d
+#define regDWB_DEBUG_BASE_IDX                                                                           2
 
 
 // addressBlock: dcn_dcec_wb0_dispdec_dwbcp_dispdec
@@ -1073,6 +1088,10 @@
 #define regMCIF_WB_ARBITRATION_CONTROL_BASE_IDX                                                         2
 #define regMCIF_WB_SCLK_CHANGE                                                                          0x027f
 #define regMCIF_WB_SCLK_CHANGE_BASE_IDX                                                                 2
+#define regMCIF_WB_TEST_DEBUG_INDEX                                                                     0x0280
+#define regMCIF_WB_TEST_DEBUG_INDEX_BASE_IDX                                                            2
+#define regMCIF_WB_TEST_DEBUG_DATA                                                                      0x0281
+#define regMCIF_WB_TEST_DEBUG_DATA_BASE_IDX                                                             2
 #define regMCIF_WB_BUF_1_ADDR_Y                                                                         0x0282
 #define regMCIF_WB_BUF_1_ADDR_Y_BASE_IDX                                                                2
 #define regMCIF_WB_BUF_1_ADDR_C                                                                         0x0284
@@ -7706,7 +7725,10 @@
 #define regMPC_OUT3_CSC_C31_C32_B_BASE_IDX                                                              3
 #define regMPC_OUT3_CSC_C33_C34_B                                                                       0x033e
 #define regMPC_OUT3_CSC_C33_C34_B_BASE_IDX                                                              3
-
+#define regMPC_OCSC_TEST_DEBUG_INDEX                                                                    0x035b
+#define regMPC_OCSC_TEST_DEBUG_INDEX_BASE_IDX                                                           3
+#define regMPC_OCSC_TEST_DEBUG_DATA                                                                     0x035c
+#define regMPC_OCSC_TEST_DEBUG_DATA_BASE_IDX                                                            3
 
 // addressBlock: dcn_dcec_opp_abm0_dispdec
 // base address: 0x0
@@ -12857,6 +12879,8 @@
 #define regHDMI_TB_ENC_CRC_CNTL_BASE_IDX                                                                3
 #define regHDMI_TB_ENC_CRC_RESULT_0                                                                     0x0904
 #define regHDMI_TB_ENC_CRC_RESULT_0_BASE_IDX                                                            3
+#define regHDMI_TB_ENC_ENCRYPTION_CONTROL                                                               0x0907
+#define regHDMI_TB_ENC_ENCRYPTION_CONTROL_BASE_IDX                                                      3
 #define regHDMI_TB_ENC_MODE                                                                             0x0908
 #define regHDMI_TB_ENC_MODE_BASE_IDX                                                                    3
 #define regHDMI_TB_ENC_INPUT_FIFO_STATUS                                                                0x0909
@@ -14297,6 +14321,8 @@
 #define regRDPCSTX0_RDPCSTX_PATTERN_DETECT_CTRL_BASE_IDX                                                2
 #define regRDPCSTX0_RDPCSTX_CNTL4                                                                       0x293c
 #define regRDPCSTX0_RDPCSTX_CNTL4_BASE_IDX                                                              2
+#define regRDPCSTX0_RDPCSTX_DEBUG_CONFIG                                                                0x293d
+#define regRDPCSTX0_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define regRDPCSTX0_RDPCSTX_PHY_CNTL0                                                                   0x2940
 #define regRDPCSTX0_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define regRDPCSTX0_RDPCSTX_PHY_CNTL1                                                                   0x2941
@@ -14347,6 +14373,8 @@
 #define regRDPCSTX0_RDPCSTX_PHY_CNTL16_BASE_IDX                                                         2
 #define regRDPCSTX0_RDPCSTX_PHY_CNTL17                                                                  0x295a
 #define regRDPCSTX0_RDPCSTX_PHY_CNTL17_BASE_IDX                                                         2
+#define regRDPCSTX0_RDPCSTX_DEBUG_CONFIG2                                                               0x295b
+#define regRDPCSTX0_RDPCSTX_DEBUG_CONFIG2_BASE_IDX                                                      2
 #define regRDPCSTX0_RDPCS_CNTL3                                                                         0x295c
 #define regRDPCSTX0_RDPCS_CNTL3_BASE_IDX                                                                2
 #define regRDPCSTX0_RDPCS_TX_PLL_UPDATE_ADDR_OVRRD                                                      0x295d
@@ -14383,6 +14411,8 @@
 #define regRDPCSTX1_RDPCSTX_PATTERN_DETECT_CTRL_BASE_IDX                                                2
 #define regRDPCSTX1_RDPCSTX_CNTL4                                                                       0x2a14
 #define regRDPCSTX1_RDPCSTX_CNTL4_BASE_IDX                                                              2
+#define regRDPCSTX1_RDPCSTX_DEBUG_CONFIG                                                                0x2a15
+#define regRDPCSTX1_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define regRDPCSTX1_RDPCSTX_PHY_CNTL0                                                                   0x2a18
 #define regRDPCSTX1_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define regRDPCSTX1_RDPCSTX_PHY_CNTL1                                                                   0x2a19
@@ -14433,6 +14463,8 @@
 #define regRDPCSTX1_RDPCSTX_PHY_CNTL16_BASE_IDX                                                         2
 #define regRDPCSTX1_RDPCSTX_PHY_CNTL17                                                                  0x2a32
 #define regRDPCSTX1_RDPCSTX_PHY_CNTL17_BASE_IDX                                                         2
+#define regRDPCSTX1_RDPCSTX_DEBUG_CONFIG2                                                               0x2a33
+#define regRDPCSTX1_RDPCSTX_DEBUG_CONFIG2_BASE_IDX                                                      2
 #define regRDPCSTX1_RDPCS_CNTL3                                                                         0x2a34
 #define regRDPCSTX1_RDPCS_CNTL3_BASE_IDX                                                                2
 #define regRDPCSTX1_RDPCS_TX_PLL_UPDATE_ADDR_OVRRD                                                      0x2a35
@@ -14469,6 +14501,8 @@
 #define regRDPCSTX2_RDPCSTX_PATTERN_DETECT_CTRL_BASE_IDX                                                2
 #define regRDPCSTX2_RDPCSTX_CNTL4                                                                       0x2aec
 #define regRDPCSTX2_RDPCSTX_CNTL4_BASE_IDX                                                              2
+#define regRDPCSTX2_RDPCSTX_DEBUG_CONFIG                                                                0x2aed
+#define regRDPCSTX2_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define regRDPCSTX2_RDPCSTX_PHY_CNTL0                                                                   0x2af0
 #define regRDPCSTX2_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define regRDPCSTX2_RDPCSTX_PHY_CNTL1                                                                   0x2af1
@@ -14519,6 +14553,8 @@
 #define regRDPCSTX2_RDPCSTX_PHY_CNTL16_BASE_IDX                                                         2
 #define regRDPCSTX2_RDPCSTX_PHY_CNTL17                                                                  0x2b0a
 #define regRDPCSTX2_RDPCSTX_PHY_CNTL17_BASE_IDX                                                         2
+#define regRDPCSTX2_RDPCSTX_DEBUG_CONFIG2                                                               0x2b0b
+#define regRDPCSTX2_RDPCSTX_DEBUG_CONFIG2_BASE_IDX                                                      2
 #define regRDPCSTX2_RDPCS_CNTL3                                                                         0x2b0c
 #define regRDPCSTX2_RDPCS_CNTL3_BASE_IDX                                                                2
 #define regRDPCSTX2_RDPCS_TX_PLL_UPDATE_ADDR_OVRRD                                                      0x2b0d
@@ -14555,6 +14591,8 @@
 #define regRDPCSTX3_RDPCSTX_PATTERN_DETECT_CTRL_BASE_IDX                                                2
 #define regRDPCSTX3_RDPCSTX_CNTL4                                                                       0x2bc4
 #define regRDPCSTX3_RDPCSTX_CNTL4_BASE_IDX                                                              2
+#define regRDPCSTX3_RDPCSTX_DEBUG_CONFIG                                                                0x2bc5
+#define regRDPCSTX3_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define regRDPCSTX3_RDPCSTX_PHY_CNTL0                                                                   0x2bc8
 #define regRDPCSTX3_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define regRDPCSTX3_RDPCSTX_PHY_CNTL1                                                                   0x2bc9
@@ -14605,6 +14643,8 @@
 #define regRDPCSTX3_RDPCSTX_PHY_CNTL16_BASE_IDX                                                         2
 #define regRDPCSTX3_RDPCSTX_PHY_CNTL17                                                                  0x2be2
 #define regRDPCSTX3_RDPCSTX_PHY_CNTL17_BASE_IDX                                                         2
+#define regRDPCSTX3_RDPCSTX_DEBUG_CONFIG2                                                               0x2be3
+#define regRDPCSTX3_RDPCSTX_DEBUG_CONFIG2_BASE_IDX                                                      2
 #define regRDPCSTX3_RDPCS_CNTL3                                                                         0x2be4
 #define regRDPCSTX3_RDPCS_CNTL3_BASE_IDX                                                                2
 #define regRDPCSTX3_RDPCS_TX_PLL_UPDATE_ADDR_OVRRD                                                      0x2be5
@@ -15392,6 +15432,15 @@
 #define ixOTG2_OTG_DOUT_INTERFACE_01_A                                                                 0x0043
 #define ixOTG2_OTG_DOUT_INTERFACE_01_B                                                                 0x0044
 #define ixOTG2_OTG_DOUT_INTERFACE_02                                                                   0x0045
+#define ixDCIO_DEBUG_ID                                                                                0x0000
+#define ixDCIO_DEBUG1B                                                                                 0x001b
+#define ixDCIO_DEBUG1C                                                                                 0x001c
+#define ixDCIO_DEBUG1D                                                                                 0x001d
+#define ixDCIO_DEBUG1E                                                                                 0x001e
+#define ixDCIO_DEBUG1F                                                                                 0x001f
+#define ixDCIO_DEBUG20                                                                                 0x0020
+#define ixDCIO_DEBUG21                                                                                 0x0021
+#define ixDCIO_DEBUG22                                                                                 0x0022
 
 
 // addressBlock: otg3_otgdebugind
-- 
2.39.2

