Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEB5C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E0B210EC65;
	Wed, 29 Mar 2023 20:31:21 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E2610EC5B
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:31:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhh5yCcwpNGe/xo9KXxWdXlM4lVeiHsuC+njsVvxaCXGN56/OKDj5Y/GGBZxm0Y3nCI5WZoxr2K2IJd9mirq+i/Ksk3xT5kkQp6D5oDnSq9D+YCgveAqb7NrN0p01m4VtMJrFKUxoYjooSgOyMwFlfEkvZ/jRmUDfnAyDwwRn3/ZnXheq21lunIZmxm3eksbfaQc5Zo4zJFGlXTcUxOZDTWkNhogLFLV9bjyBvD7QDwdE+5YQ+3wHap1G7Mqnd3ZvKwGX2PweQaoBv4LOnPuAzYEXc0DQ0u2nwGWd9JbkiFnc7J+iWGWuL9TwAo0kcyICYvWmrlenB0U6/s5t45WGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyMa1QmG/3Subjmi/Z4AcMo0sDiShYWj1QS2QL7/+RI=;
 b=lA4OZqBToaQAqm2Gb3LKegsDe+WFwWNu83sAM3aDOXDZGhYXvEbXwnRcTzodXW1rsWONkD34h0ezuOEQXSZPPLipzUq2z14ol95YMwoddZPQc51ytKcPAYV4ctIc6ZIJGzbxmbdt0gicEr6zBeelA/d9AK5e7zVXNU57r0kbmVROPZ6jn0uCLqQbmya3+O/iguF8l8iRFhG5ec7WgR4f+qAJdYd2lscV6S8OxYL2ogbMUgTU0tVk7Whq/Tn8dxVPd837xiczCaPdpJuuVvGeOizgIrkWzl7cwY/zyqUIOJDPXKrid6X3L+WdCZqzJbBQee7Yc4OWAvBI2FEw/dHgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyMa1QmG/3Subjmi/Z4AcMo0sDiShYWj1QS2QL7/+RI=;
 b=I/VvJeJaR7BfMr9Bw+CEFsH0gdykMYormODgcXdnsNJNbYIXvDEydt4+LCAGkSuczlvzoAkxOINWn4V/rhOOWKkHq60ECGKJBkIRkGsH4+18mU7YAA0Imk05j8v2r9z0SjG4JOW2KtwX5d62TGR8wiBAdPL9+0IiF/GedBN/cDU=
Received: from CY5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:930::19) by
 SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Wed, 29 Mar 2023 20:31:11 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::1e) by CY5PR13CA0005.outlook.office365.com
 (2603:10b6:930::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Wed, 29 Mar 2023 20:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.7 via Frontend Transport; Wed, 29 Mar 2023 20:31:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:31:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add smuio v13_0_3 ip headers
Date: Wed, 29 Mar 2023 16:30:07 -0400
Message-ID: <20230329203009.1983616-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329203009.1983616-1-alexander.deucher@amd.com>
References: <20230329203009.1983616-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f9229e-b55c-4116-3d95-08db309488a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2FxXloOnRB4QOknWrBELK/rxtrntOLPxJE5IufbWWGJpUy05AFqZvt6cuNx2pub/D760PCvKhpPy+NqJUydvkesB4XyxPdnNJl2vcNDMvpH0mcpAaXVp5CfZ/RxFSX8TRY/QA+xrb2vVVxND8kf0hLnlJZibbdF1YzNCAC1VsFJiBRxn8hqRp4BZOwgCxfc/qjALy00+CfYtH0dQt91IrN0IrISQRf/G3eHsX8YSGP2ByUMz18JxJyVCq9z8kBmWjjmb+iRNEqhlX4LkvS+40zSJfgQeIlDrELUwZIc2yuDWO6slkm4gMgyEGGdjWKy2iyamvE5jc+ME6xF+IJDrG77der7dSIMJMJ7A1N7uESgl8SzGtuA8SPt5vpHb1dABsepEzWgAZUjH9gVFjLbEpxJw9hH1EXb+zXiyj/6CDk0oFXt9O67Lam5IX9p7NL4Vxl9xnSAFf/w5Nk4Wqhb2g2cZNfYjrNfg62RMq8dE9vKeVtfgNVaYLWr09dYh+SZBkvsxtZLU/9nPgzrYUocH42M0TNJDkQIw2ldi0FPsk9rNrTBiVGADpICxlxyeX21R+oJcy5M0444E0Cwi4dL/FwuWZ86fJvmG/L0dneFtmEdoAjvI90L4edq93ejihAJOEr5A2LO0GC413MnKHoBQlFQNZYdqRp8e8aeQg+Xyr0LqzKEQ0tP0chzgbSq3209GLxMYyiaBnISejPiPj/X1kvLNkn9RL8toDyl9nnWTPNg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(8676002)(41300700001)(82310400005)(5660300002)(82740400003)(40460700003)(356005)(36860700001)(81166007)(86362001)(40480700001)(36756003)(478600001)(7696005)(70206006)(70586007)(54906003)(316002)(4326008)(19627235002)(2616005)(336012)(426003)(47076005)(83380400001)(186003)(16526019)(6916009)(1076003)(26005)(2906002)(30864003)(66899021)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:31:10.7918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f9229e-b55c-4116-3d95-08db309488a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add smuio v13_0_3 register offset and shift masks
header files

v2: update headers (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../asic_reg/smuio/smuio_13_0_3_offset.h      | 177 ++++++++
 .../asic_reg/smuio/smuio_13_0_3_sh_mask.h     | 428 ++++++++++++++++++
 2 files changed, 605 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_3_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_3_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_3_offset.h
new file mode 100644
index 000000000000..b62b489402c5
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_3_offset.h
@@ -0,0 +1,177 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#ifndef _smuio_13_0_3_OFFSET_HEADER
+#define _smuio_13_0_3_OFFSET_HEADER
+
+
+
+// addressBlock: aid_smuio_smuio_reset_SmuSmuioDec
+// base address: 0x5a300
+#define regSMUIO_MP_RESET_INTR                                                                          0x00c1
+#define regSMUIO_MP_RESET_INTR_BASE_IDX                                                                 1
+#define regSMUIO_SOC_HALT                                                                               0x00c2
+#define regSMUIO_SOC_HALT_BASE_IDX                                                                      1
+
+
+// addressBlock: aid_smuio_smuio_tsc_SmuSmuioDec
+// base address: 0x5a8a0
+#define regPWROK_REFCLK_GAP_CYCLES                                                                      0x0028
+#define regPWROK_REFCLK_GAP_CYCLES_BASE_IDX                                                             2
+#define regGOLDEN_TSC_INCREMENT_UPPER                                                                   0x002b
+#define regGOLDEN_TSC_INCREMENT_UPPER_BASE_IDX                                                          2
+#define regGOLDEN_TSC_INCREMENT_LOWER                                                                   0x002c
+#define regGOLDEN_TSC_INCREMENT_LOWER_BASE_IDX                                                          2
+#define regGOLDEN_TSC_COUNT_UPPER                                                                       0x002d
+#define regGOLDEN_TSC_COUNT_UPPER_BASE_IDX                                                              2
+#define regGOLDEN_TSC_COUNT_LOWER                                                                       0x002e
+#define regGOLDEN_TSC_COUNT_LOWER_BASE_IDX                                                              2
+#define regSOC_GOLDEN_TSC_SHADOW_UPPER                                                                  0x002f
+#define regSOC_GOLDEN_TSC_SHADOW_UPPER_BASE_IDX                                                         2
+#define regSOC_GOLDEN_TSC_SHADOW_LOWER                                                                  0x0030
+#define regSOC_GOLDEN_TSC_SHADOW_LOWER_BASE_IDX                                                         2
+#define regSOC_GAP_PWROK                                                                                0x0031
+#define regSOC_GAP_PWROK_BASE_IDX                                                                       2
+
+
+// addressBlock: aid_smuio_smuio_swtimer_SmuSmuioDec
+// base address: 0x5ac70
+#define regPWR_VIRT_RESET_REQ                                                                           0x011c
+#define regPWR_VIRT_RESET_REQ_BASE_IDX                                                                  2
+#define regPWR_DISP_TIMER_CONTROL                                                                       0x011d
+#define regPWR_DISP_TIMER_CONTROL_BASE_IDX                                                              2
+#define regPWR_DISP_TIMER_DEBUG                                                                         0x011e
+#define regPWR_DISP_TIMER_DEBUG_BASE_IDX                                                                2
+#define regPWR_DISP_TIMER2_CONTROL                                                                      0x011f
+#define regPWR_DISP_TIMER2_CONTROL_BASE_IDX                                                             2
+#define regPWR_DISP_TIMER2_DEBUG                                                                        0x0120
+#define regPWR_DISP_TIMER2_DEBUG_BASE_IDX                                                               2
+#define regPWR_DISP_TIMER_GLOBAL_CONTROL                                                                0x0121
+#define regPWR_DISP_TIMER_GLOBAL_CONTROL_BASE_IDX                                                       2
+#define regPWR_IH_CONTROL                                                                               0x0122
+#define regPWR_IH_CONTROL_BASE_IDX                                                                      2
+
+
+// addressBlock: aid_smuio_smuio_misc_SmuSmuioDec
+// base address: 0x5a000
+#define regSMUIO_MCM_CONFIG                                                                             0x0023
+#define regSMUIO_MCM_CONFIG_BASE_IDX                                                                    1
+#define regIP_DISCOVERY_VERSION                                                                         0x0000
+#define regIP_DISCOVERY_VERSION_BASE_IDX                                                                2
+#define regSCRATCH_REGISTER0                                                                            0x01bd
+#define regSCRATCH_REGISTER0_BASE_IDX                                                                   2
+#define regSCRATCH_REGISTER1                                                                            0x01be
+#define regSCRATCH_REGISTER1_BASE_IDX                                                                   2
+#define regSCRATCH_REGISTER2                                                                            0x01bf
+#define regSCRATCH_REGISTER2_BASE_IDX                                                                   2
+#define regSCRATCH_REGISTER3                                                                            0x01c0
+#define regSCRATCH_REGISTER3_BASE_IDX                                                                   2
+#define regSCRATCH_REGISTER4                                                                            0x01c1
+#define regSCRATCH_REGISTER4_BASE_IDX                                                                   2
+#define regSCRATCH_REGISTER5                                                                            0x01c2
+#define regSCRATCH_REGISTER5_BASE_IDX                                                                   2
+#define regSCRATCH_REGISTER6                                                                            0x01c3
+#define regSCRATCH_REGISTER6_BASE_IDX                                                                   2
+#define regSCRATCH_REGISTER7                                                                            0x01c4
+#define regSCRATCH_REGISTER7_BASE_IDX                                                                   2
+
+
+// addressBlock: aid_smuio_smuio_gpio_SmuSmuioDec
+// base address: 0x5a500
+#define regSMU_GPIOPAD_SW_INT_STAT                                                                      0x0140
+#define regSMU_GPIOPAD_SW_INT_STAT_BASE_IDX                                                             1
+#define regSMU_GPIOPAD_MASK                                                                             0x0141
+#define regSMU_GPIOPAD_MASK_BASE_IDX                                                                    1
+#define regSMU_GPIOPAD_A                                                                                0x0142
+#define regSMU_GPIOPAD_A_BASE_IDX                                                                       1
+#define regSMU_GPIOPAD_TXIMPSEL                                                                         0x0143
+#define regSMU_GPIOPAD_TXIMPSEL_BASE_IDX                                                                1
+#define regSMU_GPIOPAD_EN                                                                               0x0144
+#define regSMU_GPIOPAD_EN_BASE_IDX                                                                      1
+#define regSMU_GPIOPAD_Y                                                                                0x0145
+#define regSMU_GPIOPAD_Y_BASE_IDX                                                                       1
+#define regSMU_GPIOPAD_RXEN                                                                             0x0146
+#define regSMU_GPIOPAD_RXEN_BASE_IDX                                                                    1
+#define regSMU_GPIOPAD_RCVR_SEL0                                                                        0x0147
+#define regSMU_GPIOPAD_RCVR_SEL0_BASE_IDX                                                               1
+#define regSMU_GPIOPAD_RCVR_SEL1                                                                        0x0148
+#define regSMU_GPIOPAD_RCVR_SEL1_BASE_IDX                                                               1
+#define regSMU_GPIOPAD_PU_EN                                                                            0x0149
+#define regSMU_GPIOPAD_PU_EN_BASE_IDX                                                                   1
+#define regSMU_GPIOPAD_PD_EN                                                                            0x014a
+#define regSMU_GPIOPAD_PD_EN_BASE_IDX                                                                   1
+#define regSMU_GPIOPAD_PINSTRAPS                                                                        0x014b
+#define regSMU_GPIOPAD_PINSTRAPS_BASE_IDX                                                               1
+#define regDFT_PINSTRAPS                                                                                0x014c
+#define regDFT_PINSTRAPS_BASE_IDX                                                                       1
+#define regSMU_GPIOPAD_INT_STAT_EN                                                                      0x014d
+#define regSMU_GPIOPAD_INT_STAT_EN_BASE_IDX                                                             1
+#define regSMU_GPIOPAD_INT_STAT                                                                         0x014e
+#define regSMU_GPIOPAD_INT_STAT_BASE_IDX                                                                1
+#define regSMU_GPIOPAD_INT_STAT_AK                                                                      0x014f
+#define regSMU_GPIOPAD_INT_STAT_AK_BASE_IDX                                                             1
+#define regSMU_GPIOPAD_INT_EN                                                                           0x0150
+#define regSMU_GPIOPAD_INT_EN_BASE_IDX                                                                  1
+#define regSMU_GPIOPAD_INT_TYPE                                                                         0x0151
+#define regSMU_GPIOPAD_INT_TYPE_BASE_IDX                                                                1
+#define regSMU_GPIOPAD_INT_POLARITY                                                                     0x0152
+#define regSMU_GPIOPAD_INT_POLARITY_BASE_IDX                                                            1
+#define regSMUIO_PCC_GPIO_SELECT                                                                        0x0155
+#define regSMUIO_PCC_GPIO_SELECT_BASE_IDX                                                               1
+#define regSMU_GPIOPAD_S0                                                                               0x0156
+#define regSMU_GPIOPAD_S0_BASE_IDX                                                                      1
+#define regSMU_GPIOPAD_S1                                                                               0x0157
+#define regSMU_GPIOPAD_S1_BASE_IDX                                                                      1
+#define regSMU_GPIOPAD_SCHMEN                                                                           0x0158
+#define regSMU_GPIOPAD_SCHMEN_BASE_IDX                                                                  1
+#define regSMU_GPIOPAD_SCL_EN                                                                           0x0159
+#define regSMU_GPIOPAD_SCL_EN_BASE_IDX                                                                  1
+#define regSMU_GPIOPAD_SDA_EN                                                                           0x015a
+#define regSMU_GPIOPAD_SDA_EN_BASE_IDX                                                                  1
+#define regSMUIO_GPIO_INT0_SELECT                                                                       0x015b
+#define regSMUIO_GPIO_INT0_SELECT_BASE_IDX                                                              1
+#define regSMUIO_GPIO_INT1_SELECT                                                                       0x015c
+#define regSMUIO_GPIO_INT1_SELECT_BASE_IDX                                                              1
+#define regSMUIO_GPIO_INT2_SELECT                                                                       0x015d
+#define regSMUIO_GPIO_INT2_SELECT_BASE_IDX                                                              1
+#define regSMUIO_GPIO_INT3_SELECT                                                                       0x015e
+#define regSMUIO_GPIO_INT3_SELECT_BASE_IDX                                                              1
+#define regSMU_GPIOPAD_MP_INT0_STAT                                                                     0x015f
+#define regSMU_GPIOPAD_MP_INT0_STAT_BASE_IDX                                                            1
+#define regSMU_GPIOPAD_MP_INT1_STAT                                                                     0x0160
+#define regSMU_GPIOPAD_MP_INT1_STAT_BASE_IDX                                                            1
+#define regSMU_GPIOPAD_MP_INT2_STAT                                                                     0x0161
+#define regSMU_GPIOPAD_MP_INT2_STAT_BASE_IDX                                                            1
+#define regSMU_GPIOPAD_MP_INT3_STAT                                                                     0x0162
+#define regSMU_GPIOPAD_MP_INT3_STAT_BASE_IDX                                                            1
+#define regSMIO_INDEX                                                                                   0x0163
+#define regSMIO_INDEX_BASE_IDX                                                                          1
+#define regS0_VID_SMIO_CNTL                                                                             0x0164
+#define regS0_VID_SMIO_CNTL_BASE_IDX                                                                    1
+#define regS1_VID_SMIO_CNTL                                                                             0x0165
+#define regS1_VID_SMIO_CNTL_BASE_IDX                                                                    1
+#define regOPEN_DRAIN_SELECT                                                                            0x0166
+#define regOPEN_DRAIN_SELECT_BASE_IDX                                                                   1
+#define regSMIO_ENABLE                                                                                  0x0167
+#define regSMIO_ENABLE_BASE_IDX                                                                         1
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_3_sh_mask.h
new file mode 100644
index 000000000000..be896f3089fe
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_3_sh_mask.h
@@ -0,0 +1,428 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#ifndef _smuio_13_0_3_SH_MASK_HEADER
+#define _smuio_13_0_3_SH_MASK_HEADER
+
+
+// addressBlock: aid_smuio_smuio_reset_SmuSmuioDec
+//SMUIO_MP_RESET_INTR
+#define SMUIO_MP_RESET_INTR__SMUIO_MP_RESET_INTR__SHIFT                                                       0x0
+#define SMUIO_MP_RESET_INTR__SMUIO_MP_RESET_INTR_MASK                                                         0x00000001L
+//SMUIO_SOC_HALT
+#define SMUIO_SOC_HALT__WDT_FORCE_PWROK_EN__SHIFT                                                             0x2
+#define SMUIO_SOC_HALT__WDT_FORCE_RESETn_EN__SHIFT                                                            0x3
+#define SMUIO_SOC_HALT__WDT_FORCE_PWROK_EN_MASK                                                               0x00000004L
+#define SMUIO_SOC_HALT__WDT_FORCE_RESETn_EN_MASK                                                              0x00000008L
+
+
+// addressBlock: aid_smuio_smuio_tsc_SmuSmuioDec
+//PWROK_REFCLK_GAP_CYCLES
+#define PWROK_REFCLK_GAP_CYCLES__Pwrok_PreAssertion_clkgap_cycles__SHIFT                                      0x0
+#define PWROK_REFCLK_GAP_CYCLES__Pwrok_PostAssertion_clkgap_cycles__SHIFT                                     0x8
+#define PWROK_REFCLK_GAP_CYCLES__Pwrok_PreAssertion_clkgap_cycles_MASK                                        0x000000FFL
+#define PWROK_REFCLK_GAP_CYCLES__Pwrok_PostAssertion_clkgap_cycles_MASK                                       0x0000FF00L
+//GOLDEN_TSC_INCREMENT_UPPER
+#define GOLDEN_TSC_INCREMENT_UPPER__GoldenTscIncrementUpper__SHIFT                                            0x0
+#define GOLDEN_TSC_INCREMENT_UPPER__GoldenTscIncrementUpper_MASK                                              0x00FFFFFFL
+//GOLDEN_TSC_INCREMENT_LOWER
+#define GOLDEN_TSC_INCREMENT_LOWER__GoldenTscIncrementLower__SHIFT                                            0x0
+#define GOLDEN_TSC_INCREMENT_LOWER__GoldenTscIncrementLower_MASK                                              0xFFFFFFFFL
+//GOLDEN_TSC_COUNT_UPPER
+#define GOLDEN_TSC_COUNT_UPPER__GoldenTscCountUpper__SHIFT                                                    0x0
+#define GOLDEN_TSC_COUNT_UPPER__GoldenTscCountUpper_MASK                                                      0x00FFFFFFL
+//GOLDEN_TSC_COUNT_LOWER
+#define GOLDEN_TSC_COUNT_LOWER__GoldenTscCountLower__SHIFT                                                    0x0
+#define GOLDEN_TSC_COUNT_LOWER__GoldenTscCountLower_MASK                                                      0xFFFFFFFFL
+//SOC_GOLDEN_TSC_SHADOW_UPPER
+#define SOC_GOLDEN_TSC_SHADOW_UPPER__SocGoldenTscShadowUpper__SHIFT                                           0x0
+#define SOC_GOLDEN_TSC_SHADOW_UPPER__SocGoldenTscShadowUpper_MASK                                             0x00FFFFFFL
+//SOC_GOLDEN_TSC_SHADOW_LOWER
+#define SOC_GOLDEN_TSC_SHADOW_LOWER__SocGoldenTscShadowLower__SHIFT                                           0x0
+#define SOC_GOLDEN_TSC_SHADOW_LOWER__SocGoldenTscShadowLower_MASK                                             0xFFFFFFFFL
+//SOC_GAP_PWROK
+#define SOC_GAP_PWROK__soc_gap_pwrok__SHIFT                                                                   0x0
+#define SOC_GAP_PWROK__soc_gap_pwrok_MASK                                                                     0x00000001L
+
+
+// addressBlock: aid_smuio_smuio_swtimer_SmuSmuioDec
+//PWR_VIRT_RESET_REQ
+#define PWR_VIRT_RESET_REQ__VF_FLR__SHIFT                                                                     0x0
+#define PWR_VIRT_RESET_REQ__PF_FLR__SHIFT                                                                     0x1f
+#define PWR_VIRT_RESET_REQ__VF_FLR_MASK                                                                       0x7FFFFFFFL
+#define PWR_VIRT_RESET_REQ__PF_FLR_MASK                                                                       0x80000000L
+//PWR_DISP_TIMER_CONTROL
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_COUNT__SHIFT                                                   0x0
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_ENABLE__SHIFT                                                  0x19
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_DISABLE__SHIFT                                                 0x1a
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MASK__SHIFT                                                    0x1b
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_STAT_AK__SHIFT                                                 0x1c
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_TYPE__SHIFT                                                    0x1d
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MODE__SHIFT                                                    0x1e
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_COUNT_MASK                                                     0x01FFFFFFL
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_ENABLE_MASK                                                    0x02000000L
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_DISABLE_MASK                                                   0x04000000L
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MASK_MASK                                                      0x08000000L
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_STAT_AK_MASK                                                   0x10000000L
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_TYPE_MASK                                                      0x20000000L
+#define PWR_DISP_TIMER_CONTROL__DISP_TIMER_INT_MODE_MASK                                                      0x40000000L
+//PWR_DISP_TIMER_DEBUG
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT_RUNNING__SHIFT                                                   0x0
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT_STAT__SHIFT                                                      0x1
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT__SHIFT                                                           0x2
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_RUN_VAL__SHIFT                                                       0x7
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT_RUNNING_MASK                                                     0x00000001L
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT_STAT_MASK                                                        0x00000002L
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_INT_MASK                                                             0x00000004L
+#define PWR_DISP_TIMER_DEBUG__DISP_TIMER_RUN_VAL_MASK                                                         0xFFFFFF80L
+//PWR_DISP_TIMER2_CONTROL
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_COUNT__SHIFT                                                  0x0
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_ENABLE__SHIFT                                                 0x19
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_DISABLE__SHIFT                                                0x1a
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MASK__SHIFT                                                   0x1b
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_STAT_AK__SHIFT                                                0x1c
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_TYPE__SHIFT                                                   0x1d
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MODE__SHIFT                                                   0x1e
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_COUNT_MASK                                                    0x01FFFFFFL
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_ENABLE_MASK                                                   0x02000000L
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_DISABLE_MASK                                                  0x04000000L
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MASK_MASK                                                     0x08000000L
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_STAT_AK_MASK                                                  0x10000000L
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_TYPE_MASK                                                     0x20000000L
+#define PWR_DISP_TIMER2_CONTROL__DISP_TIMER_INT_MODE_MASK                                                     0x40000000L
+//PWR_DISP_TIMER2_DEBUG
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT_RUNNING__SHIFT                                                  0x0
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT_STAT__SHIFT                                                     0x1
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT__SHIFT                                                          0x2
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_RUN_VAL__SHIFT                                                      0x7
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT_RUNNING_MASK                                                    0x00000001L
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT_STAT_MASK                                                       0x00000002L
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_INT_MASK                                                            0x00000004L
+#define PWR_DISP_TIMER2_DEBUG__DISP_TIMER_RUN_VAL_MASK                                                        0xFFFFFF80L
+//PWR_DISP_TIMER_GLOBAL_CONTROL
+#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_WIDTH__SHIFT                                          0x0
+#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_EN__SHIFT                                             0xa
+#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_WIDTH_MASK                                            0x000003FFL
+#define PWR_DISP_TIMER_GLOBAL_CONTROL__DISP_TIMER_PULSE_EN_MASK                                               0x00000400L
+//PWR_IH_CONTROL
+#define PWR_IH_CONTROL__MAX_CREDIT__SHIFT                                                                     0x0
+#define PWR_IH_CONTROL__DISP_TIMER_TRIGGER_MASK__SHIFT                                                        0x5
+#define PWR_IH_CONTROL__DISP_TIMER2_TRIGGER_MASK__SHIFT                                                       0x6
+#define PWR_IH_CONTROL__PWR_IH_CLK_GATE_EN__SHIFT                                                             0x1f
+#define PWR_IH_CONTROL__MAX_CREDIT_MASK                                                                       0x0000001FL
+#define PWR_IH_CONTROL__DISP_TIMER_TRIGGER_MASK_MASK                                                          0x00000020L
+#define PWR_IH_CONTROL__DISP_TIMER2_TRIGGER_MASK_MASK                                                         0x00000040L
+#define PWR_IH_CONTROL__PWR_IH_CLK_GATE_EN_MASK                                                               0x80000000L
+
+
+// addressBlock: aid_smuio_smuio_misc_SmuSmuioDec
+//SMUIO_MCM_CONFIG
+#define SMUIO_MCM_CONFIG__DIE_ID__SHIFT                                                                       0x0
+#define SMUIO_MCM_CONFIG__PKG_TYPE__SHIFT                                                                     0x2
+#define SMUIO_MCM_CONFIG__SOCKET_ID__SHIFT                                                                    0x8
+#define SMUIO_MCM_CONFIG__PKG_SUBTYPE__SHIFT                                                                  0xc
+#define SMUIO_MCM_CONFIG__CONSOLE_K__SHIFT                                                                    0x10
+#define SMUIO_MCM_CONFIG__CONSOLE_A__SHIFT                                                                    0x11
+#define SMUIO_MCM_CONFIG__TOPOLOGY_ID__SHIFT                                                                  0x12
+#define SMUIO_MCM_CONFIG__DIE_ID_MASK                                                                         0x00000003L
+#define SMUIO_MCM_CONFIG__PKG_TYPE_MASK                                                                       0x0000003CL
+#define SMUIO_MCM_CONFIG__SOCKET_ID_MASK                                                                      0x00000F00L
+#define SMUIO_MCM_CONFIG__PKG_SUBTYPE_MASK                                                                    0x00001000L
+#define SMUIO_MCM_CONFIG__CONSOLE_K_MASK                                                                      0x00010000L
+#define SMUIO_MCM_CONFIG__CONSOLE_A_MASK                                                                      0x00020000L
+#define SMUIO_MCM_CONFIG__TOPOLOGY_ID_MASK                                                                    0x007C0000L
+//IP_DISCOVERY_VERSION
+#define IP_DISCOVERY_VERSION__IP_DISCOVERY_VERSION__SHIFT                                                     0x0
+#define IP_DISCOVERY_VERSION__IP_DISCOVERY_VERSION_MASK                                                       0xFFFFFFFFL
+//SCRATCH_REGISTER0
+#define SCRATCH_REGISTER0__ScratchPad0__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER0__ScratchPad0_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER1
+#define SCRATCH_REGISTER1__ScratchPad1__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER1__ScratchPad1_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER2
+#define SCRATCH_REGISTER2__ScratchPad2__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER2__ScratchPad2_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER3
+#define SCRATCH_REGISTER3__ScratchPad3__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER3__ScratchPad3_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER4
+#define SCRATCH_REGISTER4__ScratchPad4__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER4__ScratchPad4_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER5
+#define SCRATCH_REGISTER5__ScratchPad5__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER5__ScratchPad5_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER6
+#define SCRATCH_REGISTER6__ScratchPad6__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER6__ScratchPad6_MASK                                                                   0xFFFFFFFFL
+//SCRATCH_REGISTER7
+#define SCRATCH_REGISTER7__ScratchPad7__SHIFT                                                                 0x0
+#define SCRATCH_REGISTER7__ScratchPad7_MASK                                                                   0xFFFFFFFFL
+
+
+// addressBlock: aid_smuio_smuio_gpio_SmuSmuioDec
+//SMU_GPIOPAD_SW_INT_STAT
+#define SMU_GPIOPAD_SW_INT_STAT__SW_INT_STAT__SHIFT                                                           0x0
+#define SMU_GPIOPAD_SW_INT_STAT__SW_INT_STAT_MASK                                                             0x00000001L
+//SMU_GPIOPAD_MASK
+#define SMU_GPIOPAD_MASK__GPIO_MASK__SHIFT                                                                    0x0
+#define SMU_GPIOPAD_MASK__GPIO_MASK_MASK                                                                      0x7FFFFFFFL
+//SMU_GPIOPAD_A
+#define SMU_GPIOPAD_A__GPIO_A__SHIFT                                                                          0x0
+#define SMU_GPIOPAD_A__GPIO_A_MASK                                                                            0x7FFFFFFFL
+//SMU_GPIOPAD_TXIMPSEL
+#define SMU_GPIOPAD_TXIMPSEL__GPIO_TXIMPSEL__SHIFT                                                            0x0
+#define SMU_GPIOPAD_TXIMPSEL__GPIO_TXIMPSEL_MASK                                                              0x7FFFFFFFL
+//SMU_GPIOPAD_EN
+#define SMU_GPIOPAD_EN__GPIO_EN__SHIFT                                                                        0x0
+#define SMU_GPIOPAD_EN__GPIO_EN_MASK                                                                          0x7FFFFFFFL
+//SMU_GPIOPAD_Y
+#define SMU_GPIOPAD_Y__GPIO_Y__SHIFT                                                                          0x0
+#define SMU_GPIOPAD_Y__GPIO_Y_MASK                                                                            0x7FFFFFFFL
+//SMU_GPIOPAD_RXEN
+#define SMU_GPIOPAD_RXEN__GPIO_RXEN__SHIFT                                                                    0x0
+#define SMU_GPIOPAD_RXEN__GPIO_RXEN_MASK                                                                      0x7FFFFFFFL
+//SMU_GPIOPAD_RCVR_SEL0
+#define SMU_GPIOPAD_RCVR_SEL0__GPIO_RCVR_SEL0__SHIFT                                                          0x0
+#define SMU_GPIOPAD_RCVR_SEL0__GPIO_RCVR_SEL0_MASK                                                            0x7FFFFFFFL
+//SMU_GPIOPAD_RCVR_SEL1
+#define SMU_GPIOPAD_RCVR_SEL1__GPIO_RCVR_SEL1__SHIFT                                                          0x0
+#define SMU_GPIOPAD_RCVR_SEL1__GPIO_RCVR_SEL1_MASK                                                            0x7FFFFFFFL
+//SMU_GPIOPAD_PU_EN
+#define SMU_GPIOPAD_PU_EN__GPIO_PU_EN__SHIFT                                                                  0x0
+#define SMU_GPIOPAD_PU_EN__GPIO_PU_EN_MASK                                                                    0x7FFFFFFFL
+//SMU_GPIOPAD_PD_EN
+#define SMU_GPIOPAD_PD_EN__GPIO_PD_EN__SHIFT                                                                  0x0
+#define SMU_GPIOPAD_PD_EN__GPIO_PD_EN_MASK                                                                    0x7FFFFFFFL
+//SMU_GPIOPAD_PINSTRAPS
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_0__SHIFT                                                         0x0
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_1__SHIFT                                                         0x1
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_2__SHIFT                                                         0x2
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_3__SHIFT                                                         0x3
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_4__SHIFT                                                         0x4
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_5__SHIFT                                                         0x5
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_6__SHIFT                                                         0x6
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_7__SHIFT                                                         0x7
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_8__SHIFT                                                         0x8
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_9__SHIFT                                                         0x9
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_10__SHIFT                                                        0xa
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_11__SHIFT                                                        0xb
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_12__SHIFT                                                        0xc
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_13__SHIFT                                                        0xd
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_14__SHIFT                                                        0xe
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_15__SHIFT                                                        0xf
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_16__SHIFT                                                        0x10
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_17__SHIFT                                                        0x11
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_18__SHIFT                                                        0x12
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_19__SHIFT                                                        0x13
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_20__SHIFT                                                        0x14
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_21__SHIFT                                                        0x15
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_22__SHIFT                                                        0x16
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_23__SHIFT                                                        0x17
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_24__SHIFT                                                        0x18
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_25__SHIFT                                                        0x19
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_26__SHIFT                                                        0x1a
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_27__SHIFT                                                        0x1b
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_28__SHIFT                                                        0x1c
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_29__SHIFT                                                        0x1d
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_30__SHIFT                                                        0x1e
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_0_MASK                                                           0x00000001L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_1_MASK                                                           0x00000002L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_2_MASK                                                           0x00000004L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_3_MASK                                                           0x00000008L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_4_MASK                                                           0x00000010L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_5_MASK                                                           0x00000020L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_6_MASK                                                           0x00000040L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_7_MASK                                                           0x00000080L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_8_MASK                                                           0x00000100L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_9_MASK                                                           0x00000200L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_10_MASK                                                          0x00000400L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_11_MASK                                                          0x00000800L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_12_MASK                                                          0x00001000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_13_MASK                                                          0x00002000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_14_MASK                                                          0x00004000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_15_MASK                                                          0x00008000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_16_MASK                                                          0x00010000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_17_MASK                                                          0x00020000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_18_MASK                                                          0x00040000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_19_MASK                                                          0x00080000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_20_MASK                                                          0x00100000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_21_MASK                                                          0x00200000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_22_MASK                                                          0x00400000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_23_MASK                                                          0x00800000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_24_MASK                                                          0x01000000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_25_MASK                                                          0x02000000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_26_MASK                                                          0x04000000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_27_MASK                                                          0x08000000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_28_MASK                                                          0x10000000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_29_MASK                                                          0x20000000L
+#define SMU_GPIOPAD_PINSTRAPS__GPIO_PINSTRAP_30_MASK                                                          0x40000000L
+//DFT_PINSTRAPS
+#define DFT_PINSTRAPS__DFT_PINSTRAPS__SHIFT                                                                   0x0
+#define DFT_PINSTRAPS__DFT_PINSTRAPS_MASK                                                                     0x000003FFL
+//SMU_GPIOPAD_INT_STAT_EN
+#define SMU_GPIOPAD_INT_STAT_EN__GPIO_INT_STAT_EN__SHIFT                                                      0x0
+#define SMU_GPIOPAD_INT_STAT_EN__SW_INITIATED_INT_STAT_EN__SHIFT                                              0x1f
+#define SMU_GPIOPAD_INT_STAT_EN__GPIO_INT_STAT_EN_MASK                                                        0x1FFFFFFFL
+#define SMU_GPIOPAD_INT_STAT_EN__SW_INITIATED_INT_STAT_EN_MASK                                                0x80000000L
+//SMU_GPIOPAD_INT_STAT
+#define SMU_GPIOPAD_INT_STAT__GPIO_INT_STAT__SHIFT                                                            0x0
+#define SMU_GPIOPAD_INT_STAT__SW_INITIATED_INT_STAT__SHIFT                                                    0x1f
+#define SMU_GPIOPAD_INT_STAT__GPIO_INT_STAT_MASK                                                              0x1FFFFFFFL
+#define SMU_GPIOPAD_INT_STAT__SW_INITIATED_INT_STAT_MASK                                                      0x80000000L
+//SMU_GPIOPAD_INT_STAT_AK
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_0__SHIFT                                                    0x0
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_1__SHIFT                                                    0x1
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_2__SHIFT                                                    0x2
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_3__SHIFT                                                    0x3
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_4__SHIFT                                                    0x4
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_5__SHIFT                                                    0x5
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_6__SHIFT                                                    0x6
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_7__SHIFT                                                    0x7
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_8__SHIFT                                                    0x8
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_9__SHIFT                                                    0x9
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_10__SHIFT                                                   0xa
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_11__SHIFT                                                   0xb
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_12__SHIFT                                                   0xc
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_13__SHIFT                                                   0xd
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_14__SHIFT                                                   0xe
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_15__SHIFT                                                   0xf
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_16__SHIFT                                                   0x10
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_17__SHIFT                                                   0x11
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_18__SHIFT                                                   0x12
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_19__SHIFT                                                   0x13
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_20__SHIFT                                                   0x14
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_21__SHIFT                                                   0x15
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_22__SHIFT                                                   0x16
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_23__SHIFT                                                   0x17
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_24__SHIFT                                                   0x18
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_25__SHIFT                                                   0x19
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_26__SHIFT                                                   0x1a
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_27__SHIFT                                                   0x1b
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_28__SHIFT                                                   0x1c
+#define SMU_GPIOPAD_INT_STAT_AK__SW_INITIATED_INT_STAT_AK__SHIFT                                              0x1f
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_0_MASK                                                      0x00000001L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_1_MASK                                                      0x00000002L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_2_MASK                                                      0x00000004L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_3_MASK                                                      0x00000008L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_4_MASK                                                      0x00000010L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_5_MASK                                                      0x00000020L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_6_MASK                                                      0x00000040L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_7_MASK                                                      0x00000080L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_8_MASK                                                      0x00000100L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_9_MASK                                                      0x00000200L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_10_MASK                                                     0x00000400L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_11_MASK                                                     0x00000800L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_12_MASK                                                     0x00001000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_13_MASK                                                     0x00002000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_14_MASK                                                     0x00004000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_15_MASK                                                     0x00008000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_16_MASK                                                     0x00010000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_17_MASK                                                     0x00020000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_18_MASK                                                     0x00040000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_19_MASK                                                     0x00080000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_20_MASK                                                     0x00100000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_21_MASK                                                     0x00200000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_22_MASK                                                     0x00400000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_23_MASK                                                     0x00800000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_24_MASK                                                     0x01000000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_25_MASK                                                     0x02000000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_26_MASK                                                     0x04000000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_27_MASK                                                     0x08000000L
+#define SMU_GPIOPAD_INT_STAT_AK__GPIO_INT_STAT_AK_28_MASK                                                     0x10000000L
+#define SMU_GPIOPAD_INT_STAT_AK__SW_INITIATED_INT_STAT_AK_MASK                                                0x80000000L
+//SMU_GPIOPAD_INT_EN
+#define SMU_GPIOPAD_INT_EN__GPIO_INT_EN__SHIFT                                                                0x0
+#define SMU_GPIOPAD_INT_EN__SW_INITIATED_INT_EN__SHIFT                                                        0x1f
+#define SMU_GPIOPAD_INT_EN__GPIO_INT_EN_MASK                                                                  0x1FFFFFFFL
+#define SMU_GPIOPAD_INT_EN__SW_INITIATED_INT_EN_MASK                                                          0x80000000L
+//SMU_GPIOPAD_INT_TYPE
+#define SMU_GPIOPAD_INT_TYPE__GPIO_INT_TYPE__SHIFT                                                            0x0
+#define SMU_GPIOPAD_INT_TYPE__SW_INITIATED_INT_TYPE__SHIFT                                                    0x1f
+#define SMU_GPIOPAD_INT_TYPE__GPIO_INT_TYPE_MASK                                                              0x1FFFFFFFL
+#define SMU_GPIOPAD_INT_TYPE__SW_INITIATED_INT_TYPE_MASK                                                      0x80000000L
+//SMU_GPIOPAD_INT_POLARITY
+#define SMU_GPIOPAD_INT_POLARITY__GPIO_INT_POLARITY__SHIFT                                                    0x0
+#define SMU_GPIOPAD_INT_POLARITY__SW_INITIATED_INT_POLARITY__SHIFT                                            0x1f
+#define SMU_GPIOPAD_INT_POLARITY__GPIO_INT_POLARITY_MASK                                                      0x1FFFFFFFL
+#define SMU_GPIOPAD_INT_POLARITY__SW_INITIATED_INT_POLARITY_MASK                                              0x80000000L
+//SMUIO_PCC_GPIO_SELECT
+#define SMUIO_PCC_GPIO_SELECT__GPIO__SHIFT                                                                    0x0
+#define SMUIO_PCC_GPIO_SELECT__GPIO_MASK                                                                      0xFFFFFFFFL
+//SMU_GPIOPAD_S0
+#define SMU_GPIOPAD_S0__GPIO_S0__SHIFT                                                                        0x0
+#define SMU_GPIOPAD_S0__GPIO_S0_MASK                                                                          0x7FFFFFFFL
+//SMU_GPIOPAD_S1
+#define SMU_GPIOPAD_S1__GPIO_S1__SHIFT                                                                        0x0
+#define SMU_GPIOPAD_S1__GPIO_S1_MASK                                                                          0x7FFFFFFFL
+//SMU_GPIOPAD_SCHMEN
+#define SMU_GPIOPAD_SCHMEN__GPIO_SCHMEN__SHIFT                                                                0x0
+#define SMU_GPIOPAD_SCHMEN__GPIO_SCHMEN_MASK                                                                  0x7FFFFFFFL
+//SMU_GPIOPAD_SCL_EN
+#define SMU_GPIOPAD_SCL_EN__GPIO_SCL_EN__SHIFT                                                                0x0
+#define SMU_GPIOPAD_SCL_EN__GPIO_SCL_EN_MASK                                                                  0x7FFFFFFFL
+//SMU_GPIOPAD_SDA_EN
+#define SMU_GPIOPAD_SDA_EN__GPIO_SDA_EN__SHIFT                                                                0x0
+#define SMU_GPIOPAD_SDA_EN__GPIO_SDA_EN_MASK                                                                  0x7FFFFFFFL
+//SMUIO_GPIO_INT0_SELECT
+#define SMUIO_GPIO_INT0_SELECT__GPIO_INT0_SELECT__SHIFT                                                       0x0
+#define SMUIO_GPIO_INT0_SELECT__GPIO_INT0_SELECT_MASK                                                         0xFFFFFFFFL
+//SMUIO_GPIO_INT1_SELECT
+#define SMUIO_GPIO_INT1_SELECT__GPIO_INT1_SELECT__SHIFT                                                       0x0
+#define SMUIO_GPIO_INT1_SELECT__GPIO_INT1_SELECT_MASK                                                         0xFFFFFFFFL
+//SMUIO_GPIO_INT2_SELECT
+#define SMUIO_GPIO_INT2_SELECT__GPIO_INT2_SELECT__SHIFT                                                       0x0
+#define SMUIO_GPIO_INT2_SELECT__GPIO_INT2_SELECT_MASK                                                         0xFFFFFFFFL
+//SMUIO_GPIO_INT3_SELECT
+#define SMUIO_GPIO_INT3_SELECT__GPIO_INT3_SELECT__SHIFT                                                       0x0
+#define SMUIO_GPIO_INT3_SELECT__GPIO_INT3_SELECT_MASK                                                         0xFFFFFFFFL
+//SMU_GPIOPAD_MP_INT0_STAT
+#define SMU_GPIOPAD_MP_INT0_STAT__GPIO_MP_INT0_STAT__SHIFT                                                    0x0
+#define SMU_GPIOPAD_MP_INT0_STAT__GPIO_MP_INT0_STAT_MASK                                                      0x1FFFFFFFL
+//SMU_GPIOPAD_MP_INT1_STAT
+#define SMU_GPIOPAD_MP_INT1_STAT__GPIO_MP_INT1_STAT__SHIFT                                                    0x0
+#define SMU_GPIOPAD_MP_INT1_STAT__GPIO_MP_INT1_STAT_MASK                                                      0x1FFFFFFFL
+//SMU_GPIOPAD_MP_INT2_STAT
+#define SMU_GPIOPAD_MP_INT2_STAT__GPIO_MP_INT2_STAT__SHIFT                                                    0x0
+#define SMU_GPIOPAD_MP_INT2_STAT__GPIO_MP_INT2_STAT_MASK                                                      0x1FFFFFFFL
+//SMU_GPIOPAD_MP_INT3_STAT
+#define SMU_GPIOPAD_MP_INT3_STAT__GPIO_MP_INT3_STAT__SHIFT                                                    0x0
+#define SMU_GPIOPAD_MP_INT3_STAT__GPIO_MP_INT3_STAT_MASK                                                      0x1FFFFFFFL
+//SMIO_INDEX
+#define SMIO_INDEX__SW_SMIO_INDEX__SHIFT                                                                      0x0
+#define SMIO_INDEX__SW_SMIO_INDEX_MASK                                                                        0x00000001L
+//S0_VID_SMIO_CNTL
+#define S0_VID_SMIO_CNTL__S0_SMIO_VALUES__SHIFT                                                               0x0
+#define S0_VID_SMIO_CNTL__S0_SMIO_VALUES_MASK                                                                 0xFFFFFFFFL
+//S1_VID_SMIO_CNTL
+#define S1_VID_SMIO_CNTL__S1_SMIO_VALUES__SHIFT                                                               0x0
+#define S1_VID_SMIO_CNTL__S1_SMIO_VALUES_MASK                                                                 0xFFFFFFFFL
+//OPEN_DRAIN_SELECT
+#define OPEN_DRAIN_SELECT__OPEN_DRAIN_SELECT__SHIFT                                                           0x0
+#define OPEN_DRAIN_SELECT__RESERVED__SHIFT                                                                    0x1f
+#define OPEN_DRAIN_SELECT__OPEN_DRAIN_SELECT_MASK                                                             0x7FFFFFFFL
+#define OPEN_DRAIN_SELECT__RESERVED_MASK                                                                      0x80000000L
+//SMIO_ENABLE
+#define SMIO_ENABLE__SMIO_ENABLE__SHIFT                                                                       0x0
+#define SMIO_ENABLE__SMIO_ENABLE_MASK                                                                         0xFFFFFFFFL
+
+#endif
-- 
2.39.2

