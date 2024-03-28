Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D1CCD1283
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E3711232A;
	Thu, 28 Mar 2024 19:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v7gInUsD";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64127112546
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGW/UHnwRsU/v222emFTuPQCDLDHUTeJPb/c4T8lOy9mJLyEfODZ9wc/fVsQ8+MRSern/Zcd0qLrNgna7TLgM9HIyhfPOTZblc2Gpxc7S37tUL1cPefDKUCTvWhSM8h8697o8awX8pb2Qrd9VyYXDviI3rfqN5XLrVAQMdz51DBIrVTIJjuuYH+lNJa5YhgD7DA9m7OBCaZlM5tGURZ7bPcZbtq4pFdq2VYBgSnuuTEVNElRQjjWIOkSn+tdaDuYAhw1HJtem5qzbS6jZ3UQFLrDOAm0BSqIes4Zwa0CuLVEsHbZnpQaVibnKDog2QiC0dRqEktzDge3LbFVbkIaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO0WBBytDmKhQxq0O+p6m9MuBx2GYzQPVjhW2BSyl6o=;
 b=Z1aV6p30CXVXGJ6yBufQzlsiJMsMQaKqbk5X8Iu5yEnH9uos2l9fwwOrP6/vHQarDAshQop0x1vaMyijlwoNEPpAPOoWPRXYBteSOg4nSamioPtsioPNEXG0VwJSSMvdSsYzZ6SwkUGPMGHIGtFhQZgjhfMkZYJHDSJyR7SNEI4h4xjVQ9VEQ/CDGxshjNwK/VBZe8i8hUMP8sWf2f5OujzOh4VbnrpAZQHHVNYlIoHvBNqYBPk8AwB+n8hXkyO1uocfyXiyLOf2cJzGugOjBLEqAypoqpQA4ESslNmkvrE1gPXyjEqMOGVcjap9LwVOKgJh0U5Q8eap4rJ6AYTSmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lO0WBBytDmKhQxq0O+p6m9MuBx2GYzQPVjhW2BSyl6o=;
 b=v7gInUsDfj32yyfSllPfUpRVW4PN99mxhJXfK4jCHXcTre2Z4LLGPLhm2NjhtRGSSkJ6FJSKZwUGr105JXiQxDeSL9qGPd3CqLOki8qz+m98YoEB4eVM7Q+JXowOZ3YNNE3YvKaNHHqm90zABwm9OujLsluY518lJd/ubcvr/lY=
Received: from SJ0PR13CA0239.namprd13.prod.outlook.com (2603:10b6:a03:2c1::34)
 by SJ1PR12MB6170.namprd12.prod.outlook.com (2603:10b6:a03:45b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:52:09 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::58) by SJ0PR13CA0239.outlook.office365.com
 (2603:10b6:a03:2c1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:09 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:06 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:06 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 34/43] drm/amd/display: Add missing registers
Date: Thu, 28 Mar 2024 15:50:38 -0400
Message-ID: <20240328195047.2843715-35-Roman.Li@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SJ1PR12MB6170:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e60559b-abb0-4049-5a41-08dc4f608db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DyKLeDOft1x4ZsKP17/RciAWJFAH8/K5YbmcdKfQ8DjJM0MQa1mqgHSDpCoNaRFLm0VXTt6EKHGzfY0Q+LS0uGwG3wGA+o4Y8lgk4lzaEFdcD4tMbOzQaVJhwObCbhJSNrYP1TUKMpB2fXEvN51ltIyyReJS5WJbnaNJxjVkKL7CHxHuMAe4umFj3uVbveq6DSgD3KoY1IPr/CLvnb4XlYw6bPMBo6rApDuqMBOVPA/4PYu7FkK2aE+vOW2mK/Tx4oo1xIiVls3xXyqnLEcIkXiOXxo3hGEreg2OnoSKF1GtYSHrL0UDfd3gnvZlZXQUG5xPYRDWFTgLkaf3RUxcD1us1/3QngwPSsVnJBLym5iWH2yqHLI8Hu8+FJpgIze4Yt4LYNplwz10ofISnEx8U8obccw7O7//Mrai/WedknrFurJmg66fhjsFXZbCLbBQSeoS4hXrLLNqypWQhs67e9OlsUNwKLo7d0XPn6KUykF0srRSiyDRLLKF8gI4A0edQRwI/7KgJXOHD68S4r9jnDPJZgP306x2x2glBTeHSwX2Dzm9fBqk9nDQ9Z4V0Wj4OIM8ByucnbrGMjnWQRzcTBejbTI1Q0DqrUr9z8QpqH5cIqb6035KVORGdkz8ziSyWNk2OjbDzmn55ujVZsiYtZjQm+3I8D9bJVpwdUkB40j6aCjIGutB0UorFwXE54RRC94UA/p67CKXYpc+z7V9rHHmxEO4SE47NMaMZBcqv0Fz8CRpDu47VhqMRPtXl84f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:09.0573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e60559b-abb0-4049-5a41-08dc4f608db6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6170
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
 .../include/asic_reg/dcn/dcn_3_0_3_offset.h   | 20 +++++++
 .../include/asic_reg/dcn/dcn_3_0_3_sh_mask.h  | 11 ++++
 .../include/asic_reg/dcn/dcn_3_1_2_offset.h   |  4 ++
 .../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h  | 19 ++++++
 .../include/asic_reg/dcn/dcn_3_2_0_offset.h   | 60 +++++++++++++++++++
 .../include/asic_reg/dcn/dcn_3_2_0_sh_mask.h  | 22 +++++++
 .../asic_reg/dpcs/dpcs_3_0_3_sh_mask.h        |  4 +-
 .../include/asic_reg/dpcs/dpcs_4_2_0_offset.h | 10 ++++
 8 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
index e90f31bbb4d2..8b0d2638a6b0 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_offset.h
@@ -5695,6 +5695,16 @@
 #define mmDSCC0_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define mmDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x3035
 #define mmDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define mmDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x303a
+#define mmDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
+#define mmDSCC0_DSCC_TEST_DEBUG_DATA0                                                                  0x303b
+#define mmDSCC0_DSCC_TEST_DEBUG_DATA0_BASE_IDX                                                         2
+#define mmDSCC0_DSCC_TEST_DEBUG_DATA1                                                                  0x303c
+#define mmDSCC0_DSCC_TEST_DEBUG_DATA1_BASE_IDX                                                         2
+#define mmDSCC0_DSCC_TEST_DEBUG_DATA2                                                                  0x303d
+#define mmDSCC0_DSCC_TEST_DEBUG_DATA2_BASE_IDX                                                         2
+#define mmDSCC0_DSCC_TEST_DEBUG_DATA3                                                                  0x303e
+#define mmDSCC0_DSCC_TEST_DEBUG_DATA3_BASE_IDX                                                         2
 
 
 // addressBlock: dce_dc_dsc0_dispdec_dsc_dcperfmon_dc_perfmon_dispdec
@@ -5825,6 +5835,16 @@
 #define mmDSCC1_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define mmDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x3091
 #define mmDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define mmDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x3096
+#define mmDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
+#define mmDSCC1_DSCC_TEST_DEBUG_DATA0                                                                  0x3097
+#define mmDSCC1_DSCC_TEST_DEBUG_DATA0_BASE_IDX                                                         2
+#define mmDSCC1_DSCC_TEST_DEBUG_DATA1                                                                  0x3098
+#define mmDSCC1_DSCC_TEST_DEBUG_DATA1_BASE_IDX                                                         2
+#define mmDSCC1_DSCC_TEST_DEBUG_DATA2                                                                  0x3099
+#define mmDSCC1_DSCC_TEST_DEBUG_DATA2_BASE_IDX                                                         2
+#define mmDSCC1_DSCC_TEST_DEBUG_DATA3                                                                  0x309a
+#define mmDSCC1_DSCC_TEST_DEBUG_DATA3_BASE_IDX                                                         2
 
 
 // addressBlock: dce_dc_dsc1_dispdec_dsc_dcperfmon_dc_perfmon_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
index 3be176174b20..53f1705f8d99 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_3_sh_mask.h
@@ -22265,7 +22265,9 @@
 #define DSC_TOP0_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK                                                  0x00000100L
 //DSC_TOP0_DSC_DEBUG_CONTROL
 #define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_TEST_CLOCK_MUX_SEL__SHIFT                                             0x4
 #define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                                                           0x00000001L
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_TEST_CLOCK_MUX_SEL_MASK                                               0x00000070L
 
 
 // addressBlock: dce_dc_dsc0_dispdec_dsccif_dispdec
@@ -22638,6 +22640,15 @@
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
 
 
 // addressBlock: dce_dc_dsc0_dispdec_dsc_dcperfmon_dc_perfmon_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_offset.h
index f268d33c4744..7fd906f10803 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_offset.h
@@ -424,6 +424,8 @@
 #define regDTBCLK_DTO2_MODULO_BASE_IDX                                                                  2
 #define regDTBCLK_DTO3_MODULO                                                                           0x0022
 #define regDTBCLK_DTO3_MODULO_BASE_IDX                                                                  2
+#define regHDMICHARCLK0_CLOCK_CNTL                                                                      0x004a
+#define regHDMICHARCLK0_CLOCK_CNTL_BASE_IDX                                                             2
 #define regPHYASYMCLK_CLOCK_CNTL                                                                        0x0052
 #define regPHYASYMCLK_CLOCK_CNTL_BASE_IDX                                                               2
 #define regPHYBSYMCLK_CLOCK_CNTL                                                                        0x0053
@@ -434,6 +436,8 @@
 #define regPHYDSYMCLK_CLOCK_CNTL_BASE_IDX                                                               2
 #define regPHYESYMCLK_CLOCK_CNTL                                                                        0x0056
 #define regPHYESYMCLK_CLOCK_CNTL_BASE_IDX                                                               2
+#define regHDMISTREAMCLK_CNTL                                                                           0x0059
+#define regHDMISTREAMCLK_CNTL_BASE_IDX                                                                  2
 #define regDCCG_GATE_DISABLE_CNTL3                                                                      0x005a
 #define regDCCG_GATE_DISABLE_CNTL3_BASE_IDX                                                             2
 #define regHDMISTREAMCLK0_DTO_PARAM                                                                     0x005b
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
index cf3398f15666..07fbfafe6056 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_1_2_sh_mask.h
@@ -1372,6 +1372,11 @@
 //DTBCLK_DTO3_MODULO
 #define DTBCLK_DTO3_MODULO__DTBCLK_DTO3_MODULO__SHIFT                                                         0x0
 #define DTBCLK_DTO3_MODULO__DTBCLK_DTO3_MODULO_MASK                                                           0xFFFFFFFFL
+//HDMICHARCLK0_CLOCK_CNTL
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN__SHIFT                                                       0x0
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL__SHIFT                                                  0x4
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_EN_MASK                                                         0x00000001L
+#define HDMICHARCLK0_CLOCK_CNTL__HDMICHARCLK0_SRC_SEL_MASK                                                    0x00000070L
 //PHYASYMCLK_CLOCK_CNTL
 #define PHYASYMCLK_CLOCK_CNTL__PHYASYMCLK_FORCE_EN__SHIFT                                                     0x0
 #define PHYASYMCLK_CLOCK_CNTL__PHYASYMCLK_FORCE_SRC_SEL__SHIFT                                                0x4
@@ -1397,6 +1402,13 @@
 #define PHYESYMCLK_CLOCK_CNTL__PHYESYMCLK_FORCE_SRC_SEL__SHIFT                                                0x4
 #define PHYESYMCLK_CLOCK_CNTL__PHYESYMCLK_FORCE_EN_MASK                                                       0x00000001L
 #define PHYESYMCLK_CLOCK_CNTL__PHYESYMCLK_FORCE_SRC_SEL_MASK                                                  0x00000030L
+//HDMISTREAMCLK_CNTL
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_SRC_SEL__SHIFT                                                     0x0
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_EN__SHIFT                                                          0x3
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_DTO_FORCE_DIS__SHIFT                                               0x4
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_SRC_SEL_MASK                                                       0x00000007L
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_EN_MASK                                                            0x00000008L
+#define HDMISTREAMCLK_CNTL__HDMISTREAMCLK0_DTO_FORCE_DIS_MASK                                                 0x00000010L
 //DCCG_GATE_DISABLE_CNTL3
 #define DCCG_GATE_DISABLE_CNTL3__HDMISTREAMCLK0_GATE_DISABLE__SHIFT                                           0x0
 #define DCCG_GATE_DISABLE_CNTL3__HDMISTREAMCLK1_GATE_DISABLE__SHIFT                                           0x1
@@ -46978,6 +46990,13 @@
 #define DSC_TOP0_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                                                           0x00000001L
 #define DSC_TOP0_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK                                                 0x00000010L
 #define DSC_TOP0_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK                                                  0x00000100L
+
+
+//DSC_TOP0_DSC_DEBUG_CONTROL
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_TEST_CLOCK_MUX_SEL__SHIFT                                             0x4
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                                                           0x00000001L
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_TEST_CLOCK_MUX_SEL_MASK                                               0x00000070L
 //DSC_TOP0_DSC_DEBUG_CONTROL
 #define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
 #define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_TEST_CLOCK_MUX_SEL__SHIFT                                             0x4
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
index 14c29ce4c7b3..78cb61d5800a 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_offset.h
@@ -1719,6 +1719,10 @@
 #define regDCHUBBUB_TIMEOUT_INTERRUPT_STATUS_BASE_IDX                                                   2
 #define regFMON_CTRL                                                                                    0x0541
 #define regFMON_CTRL_BASE_IDX                                                                           2
+#define regDCHUBBUB_TEST_DEBUG_INDEX                                                                    0x0542
+#define regDCHUBBUB_TEST_DEBUG_INDEX_BASE_IDX                                                           2
+#define regDCHUBBUB_TEST_DEBUG_DATA                                                                     0x0543
+#define regDCHUBBUB_TEST_DEBUG_DATA_BASE_IDX                                                            2
 
 
 // addressBlock: dcn_dc_dchubbubl_hubbub_sdpif_dispdec
@@ -3574,6 +3578,10 @@
 #define regCM0_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM0_CM_COEF_FORMAT                                                                           0x0d8c
 #define regCM0_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM0_CM_TEST_DEBUG_INDEX                                                                      0x0d8d
+#define regCM0_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM0_CM_TEST_DEBUG_DATA                                                                       0x0d8e
+#define regCM0_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dcn_dc_dpp0_dispdec_dpp_top_dispdec
@@ -3960,6 +3968,10 @@
 #define regCM1_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM1_CM_COEF_FORMAT                                                                           0x0ef7
 #define regCM1_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM1_CM_TEST_DEBUG_INDEX                                                                      0x0ef8
+#define regCM1_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM1_CM_TEST_DEBUG_DATA                                                                       0x0ef9
+#define regCM1_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dcn_dc_dpp1_dispdec_dpp_top_dispdec
@@ -4346,6 +4358,10 @@
 #define regCM2_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM2_CM_COEF_FORMAT                                                                           0x1062
 #define regCM2_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM2_CM_TEST_DEBUG_INDEX                                                                      0x1063
+#define regCM2_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM2_CM_TEST_DEBUG_DATA                                                                       0x1064
+#define regCM2_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dcn_dc_dpp2_dispdec_dpp_top_dispdec
@@ -4732,6 +4748,10 @@
 #define regCM3_CM_DEALPHA_BASE_IDX                                                                      2
 #define regCM3_CM_COEF_FORMAT                                                                           0x11cd
 #define regCM3_CM_COEF_FORMAT_BASE_IDX                                                                  2
+#define regCM3_CM_TEST_DEBUG_INDEX                                                                      0x11ce
+#define regCM3_CM_TEST_DEBUG_INDEX_BASE_IDX                                                             2
+#define regCM3_CM_TEST_DEBUG_DATA                                                                       0x11cf
+#define regCM3_CM_TEST_DEBUG_DATA_BASE_IDX                                                              2
 
 
 // addressBlock: dcn_dc_dpp3_dispdec_dpp_top_dispdec
@@ -11780,6 +11800,16 @@
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x3035
 #define regDSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define regDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x303a
+#define regDSCC0_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
+#define regDSCC0_DSCC_TEST_DEBUG_DATA0                                                                  0x303b
+#define regDSCC0_DSCC_TEST_DEBUG_DATA0_BASE_IDX                                                         2
+#define regDSCC0_DSCC_TEST_DEBUG_DATA1                                                                  0x303c
+#define regDSCC0_DSCC_TEST_DEBUG_DATA1_BASE_IDX                                                         2
+#define regDSCC0_DSCC_TEST_DEBUG_DATA2                                                                  0x303d
+#define regDSCC0_DSCC_TEST_DEBUG_DATA2_BASE_IDX                                                         2
+#define regDSCC0_DSCC_TEST_DEBUG_DATA3                                                                  0x303e
+#define regDSCC0_DSCC_TEST_DEBUG_DATA3_BASE_IDX                                                         2
 
 
 // addressBlock: dcn_dc_dsc0_dispdec_dsccif_dispdec
@@ -11888,6 +11918,16 @@
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x3091
 #define regDSCC1_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define regDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x3096
+#define regDSCC1_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
+#define regDSCC1_DSCC_TEST_DEBUG_DATA0                                                                  0x3097
+#define regDSCC1_DSCC_TEST_DEBUG_DATA0_BASE_IDX                                                         2
+#define regDSCC1_DSCC_TEST_DEBUG_DATA1                                                                  0x3098
+#define regDSCC1_DSCC_TEST_DEBUG_DATA1_BASE_IDX                                                         2
+#define regDSCC1_DSCC_TEST_DEBUG_DATA2                                                                  0x3099
+#define regDSCC1_DSCC_TEST_DEBUG_DATA2_BASE_IDX                                                         2
+#define regDSCC1_DSCC_TEST_DEBUG_DATA3                                                                  0x309a
+#define regDSCC1_DSCC_TEST_DEBUG_DATA3_BASE_IDX                                                         2
 
 
 // addressBlock: dcn_dc_dsc1_dispdec_dsccif_dispdec
@@ -11996,6 +12036,16 @@
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x30ed
 #define regDSCC2_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define regDSCC2_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x30f2
+#define regDSCC2_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
+#define regDSCC2_DSCC_TEST_DEBUG_DATA0                                                                  0x30f3
+#define regDSCC2_DSCC_TEST_DEBUG_DATA0_BASE_IDX                                                         2
+#define regDSCC2_DSCC_TEST_DEBUG_DATA1                                                                  0x30f4
+#define regDSCC2_DSCC_TEST_DEBUG_DATA1_BASE_IDX                                                         2
+#define regDSCC2_DSCC_TEST_DEBUG_DATA2                                                                  0x30f5
+#define regDSCC2_DSCC_TEST_DEBUG_DATA2_BASE_IDX                                                         2
+#define regDSCC2_DSCC_TEST_DEBUG_DATA3                                                                  0x30f6
+#define regDSCC2_DSCC_TEST_DEBUG_DATA3_BASE_IDX                                                         2
 
 
 // addressBlock: dcn_dc_dsc2_dispdec_dsccif_dispdec
@@ -12104,6 +12154,16 @@
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER2_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL                                           0x3149
 #define regDSCC3_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_BASE_IDX                                  2
+#define regDSCC3_DSCC_TEST_DEBUG_BUS_ROTATE                                                             0x314e
+#define regDSCC3_DSCC_TEST_DEBUG_BUS_ROTATE_BASE_IDX                                                    2
+#define regDSCC3_DSCC_TEST_DEBUG_DATA0                                                                  0x314f
+#define regDSCC3_DSCC_TEST_DEBUG_DATA0_BASE_IDX                                                         2
+#define regDSCC3_DSCC_TEST_DEBUG_DATA1                                                                  0x3150
+#define regDSCC3_DSCC_TEST_DEBUG_DATA1_BASE_IDX                                                         2
+#define regDSCC3_DSCC_TEST_DEBUG_DATA2                                                                  0x3151
+#define regDSCC3_DSCC_TEST_DEBUG_DATA2_BASE_IDX                                                         2
+#define regDSCC3_DSCC_TEST_DEBUG_DATA3                                                                  0x3152
+#define regDSCC3_DSCC_TEST_DEBUG_DATA3_BASE_IDX                                                         2
 
 
 // addressBlock: dcn_dc_dsc3_dispdec_dsccif_dispdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
index d70518307a34..1093105ca35b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_2_0_sh_mask.h
@@ -42272,6 +42272,18 @@
 //DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL
 #define DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__SHIFT  0x0
 #define DSCC0_DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL__DSCC_RATE_CONTROL_BUFFER3_MAX_FULLNESS_LEVEL_MASK  0x0003FFFFL
+//DSCC0_DSCC_TEST_DEBUG_INDEX2
+#define DSCC0_DSCC_TEST_DEBUG_INDEX2__DSCC_TEST_DEBUG_INDEX2__SHIFT                                           0x0
+#define DSCC0_DSCC_TEST_DEBUG_INDEX2__DSCC_TEST_DEBUG_INDEX2_MASK                                             0x000000FFL
+//DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS0_ROTATE__SHIFT                                  0x0
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS1_ROTATE__SHIFT                                  0x8
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS2_ROTATE__SHIFT                                  0x10
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS3_ROTATE__SHIFT                                  0x18
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS0_ROTATE_MASK                                    0x0000001FL
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS1_ROTATE_MASK                                    0x00001F00L
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS2_ROTATE_MASK                                    0x001F0000L
+#define DSCC0_DSCC_TEST_DEBUG_BUS_ROTATE__DSCC_TEST_DEBUG_BUS3_ROTATE_MASK                                    0x1F000000L
 
 
 // addressBlock: dcn_dc_dsc0_dispdec_dsccif_dispdec
@@ -42305,6 +42317,16 @@
 #define DSC_TOP0_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK                                                  0x00000100L
 //DSC_TOP0_DSC_DEBUG_CONTROL
 #define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_TEST_CLOCK_MUX_SEL__SHIFT                                             0x4
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                                                           0x00000001L
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_TEST_CLOCK_MUX_SEL_MASK                                               0x00000070L
+
+
+//DSC_TOP0_DSC_DEBUG_CONTROL
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_TEST_CLOCK_MUX_SEL__SHIFT                                             0x4
+//DSC_TOP0_DSC_DEBUG_CONTROL
+#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                                                         0x0
 #define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                                                           0x00000001L
 
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h
index 55743d06f728..e55ff0e8d74c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h
@@ -70,7 +70,9 @@
 //DPCSTX0_DPCSTX_PLL_UPDATE_DATA
 #define DPCSTX0_DPCSTX_PLL_UPDATE_DATA__DPCS_PLL_UPDATE_DATA__SHIFT                                           0x0
 #define DPCSTX0_DPCSTX_PLL_UPDATE_DATA__DPCS_PLL_UPDATE_DATA_MASK                                             0xFFFFFFFFL
-
+//DPCSTX0_DPCSTX_DEBUG_CONFIG
+#define DPCSTX0_DPCSTX_DEBUG_CONFIG__DPCS_DBG_CBUS_DIS__SHIFT                                                 0xe
+#define DPCSTX0_DPCSTX_DEBUG_CONFIG__DPCS_DBG_CBUS_DIS_MASK                                                   0x00004000L
 
 // addressBlock: dpcssys_dpcs0_rdpcstx0_dispdec
 //RDPCSTX0_RDPCSTX_CNTL
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_offset.h
index 01a56556cde1..5b4fdeda1040 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_2_0_offset.h
@@ -155,6 +155,8 @@
 #define regRDPCSTX0_RDPCSTX_CNTL2_BASE_IDX                                                              2
 #define regRDPCSTX0_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG                                                    0x293c
 #define regRDPCSTX0_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG_BASE_IDX                                           2
+#define regRDPCSTX0_RDPCSTX_DEBUG_CONFIG                                                                0x293d
+#define regRDPCSTX0_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define regRDPCSTX0_RDPCSTX_PHY_CNTL0                                                                   0x2940
 #define regRDPCSTX0_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define regRDPCSTX0_RDPCSTX_PHY_CNTL1                                                                   0x2941
@@ -239,6 +241,8 @@
 #define regRDPCSTX1_RDPCSTX_CNTL2_BASE_IDX                                                              2
 #define regRDPCSTX1_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG                                                    0x2a14
 #define regRDPCSTX1_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG_BASE_IDX                                           2
+#define regRDPCSTX1_RDPCSTX_DEBUG_CONFIG                                                                0x2a15
+#define regRDPCSTX1_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define regRDPCSTX1_RDPCSTX_PHY_CNTL0                                                                   0x2a18
 #define regRDPCSTX1_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define regRDPCSTX1_RDPCSTX_PHY_CNTL1                                                                   0x2a19
@@ -323,6 +327,8 @@
 #define regRDPCSTX2_RDPCSTX_CNTL2_BASE_IDX                                                              2
 #define regRDPCSTX2_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG                                                    0x2aec
 #define regRDPCSTX2_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG_BASE_IDX                                           2
+#define regRDPCSTX2_RDPCSTX_DEBUG_CONFIG                                                                0x2aed
+#define regRDPCSTX2_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define regRDPCSTX2_RDPCSTX_PHY_CNTL0                                                                   0x2af0
 #define regRDPCSTX2_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define regRDPCSTX2_RDPCSTX_PHY_CNTL1                                                                   0x2af1
@@ -407,6 +413,8 @@
 #define regRDPCSTX3_RDPCSTX_CNTL2_BASE_IDX                                                              2
 #define regRDPCSTX3_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG                                                    0x2bc4
 #define regRDPCSTX3_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG_BASE_IDX                                           2
+#define regRDPCSTX3_RDPCSTX_DEBUG_CONFIG                                                                0x2bc5
+#define regRDPCSTX3_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define regRDPCSTX3_RDPCSTX_PHY_CNTL0                                                                   0x2bc8
 #define regRDPCSTX3_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define regRDPCSTX3_RDPCSTX_PHY_CNTL1                                                                   0x2bc9
@@ -491,6 +499,8 @@
 #define regRDPCSTX4_RDPCSTX_CNTL2_BASE_IDX                                                              2
 #define regRDPCSTX4_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG                                                    0x2c9c
 #define regRDPCSTX4_RDPCSTX_DMCU_DPALT_DIS_BLOCK_REG_BASE_IDX                                           2
+#define regRDPCSTX4_RDPCSTX_DEBUG_CONFIG                                                                0x2c9d
+#define regRDPCSTX4_RDPCSTX_DEBUG_CONFIG_BASE_IDX                                                       2
 #define regRDPCSTX4_RDPCSTX_PHY_CNTL0                                                                   0x2ca0
 #define regRDPCSTX4_RDPCSTX_PHY_CNTL0_BASE_IDX                                                          2
 #define regRDPCSTX4_RDPCSTX_PHY_CNTL1                                                                   0x2ca1
-- 
2.34.1

