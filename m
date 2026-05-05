Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2574CD342F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 08:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C84C10E9D2;
	Tue,  5 May 2026 08:17:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cQzVj3MG";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A521810E9CB
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 08:17:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=np3swDYwjUJJFCKB5S2uqBQ2M2ROtu+M3iHvxcHdTDsPxkhWC8oRyfgrUwqMxoFVSgqim11nAdZlmKOQCCn5s6LvcZGeRrR1pTjCVDGphVG5zEQgyfomp+VwkR7I92yM+agKRhrVjZvPpcf9j721t51lIT+hM1t5xtJyTaTmHD5wunVgVgLRqJINsumnd07KipMhhmHHEUP8IqcEa6pQG0k5+AlY5BqdXFuJoQyrPRCDT9CzQoZAmS5jIKJvTRLvpWtJ3VG9xo1ehNzlRbjUc7F/3o9zk5NsChlfj/9lAue/am2x3mRJyaFO7O6NOiW/P0g/9N7j7hpdCPJ2kzDHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcRTQvaZOcbWYZFfbPRJ7PLhZzcAP+KNrsyOyq5/IAQ=;
 b=M+5ssufxFk69Way2OWHxC95JDJC5E68TQsfJ4EIcPK145V6E00PtU7vhEjh6lBuqd2rwQjPitlnRGm3VQAVveHyz9063++3/QuUgl7wzimbz3nQW0cboD9KoLpVC5j6NZRDWN3cLmqQ8rP5IRpmv9AcgjQ2pkADaTQq4bfTLX8BREeXjayf7O087Mcb1yf4b1+DkR1g7rqa+gMSCIj1RsN56Q10bgNRnJTRNwr221zwellk3Hxye/eD+lesnZNGfTRfm8LWZejfHSWIoCyaIv0aQ4ynBNwRtKtPv+cB87mjm3Nfdc53475tDUtd+7w0qHKEbcre0U0vhUt1lgqek7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcRTQvaZOcbWYZFfbPRJ7PLhZzcAP+KNrsyOyq5/IAQ=;
 b=cQzVj3MGZn2B1g64smC2uRz0UdAEZZbbjfxDgDoGSmZ/vppaOpoAUKKaOdGUMsevxAzUkWvrntOE9lM7dvB9M6eA9L/Gi8IHjfJOO2HsnixiVUnySAnSpYWpRZMNQC9kh5meHq78+tah/YLRS4ubpbSykSgdb3oIWBunvZFCJ2E=
Received: from MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::13)
 by DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 08:17:13 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::f1) by MW4P221CA0008.outlook.office365.com
 (2603:10b6:303:8b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 08:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 08:17:12 +0000
Received: from caden-test (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 03:17:05 -0500
From: Caden Chien <chih-wei.chien@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: <HaoPing.Liu@amd.com>, <Solomon.Chiu@amd.com>, <Peyton.Lee@amd.com>,
 <Yu.Wang4@amd.com>, <Pratik.Vishwakarma@amd.com>, Caden Chien
 <chih-wei.chien@amd.com>, Roy Chan <Roy.Chan@amd.com>
Subject: [PATCH 3/4] drm/amdgpu/vpe: add new vpe v2.0.0 register offset and
 sh/mask
Date: Tue, 5 May 2026 16:13:11 +0800
Message-ID: <20260505081312.14047-4-chih-wei.chien@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505081312.14047-1-chih-wei.chien@amd.com>
References: <20260505081312.14047-1-chih-wei.chien@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|DS2PR12MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 80868c97-276d-4ce7-d6b6-08deaa7eb58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UmMVSPMVG2zHrsBipuogaw4hrewom/mC+pXwJWRA4adPvqtSmmlh7zqznEQLB1COPjA/E8EGjCsigwpYFOvy1mvfRYjuZQazpXbX26S30YC+j+k2EFCEOuTD+3pbj3+IS8f7+a19DIn3R18OXlBRg+PNoJIgz7NWQj/cVodo49kQrbVKLO2MIrWHIjuoN24DGA63/MvIZ4MwuuijZjebhFmusXBZE+4IkoUL0d5D/zFdLlX3LLRKLb8K/f5NXXmVz8vuCnMJ8AAn6evvFb92xqm//ynabAKZ5rEt3cYEib35vOw8KQuuoCHxJRM4oVKPDnwh+f7UOCpAnb31eFArAksgorzF0Lf4jSWfd8UV1i5dEXjuWNToarIFxVvQnhm7c84OOz5ImrifIH2Xx+S66llrVUYmXkCMpcZzXi2+IqmxyPC/X8ID0qPSmnt2rbhLejYkI9XOqVc2vzhnMm/9R13pLsSHiczYAPOuNUVCs/6Yn4UeBjwqQP3zb4nZhf4zJNv8h+But2yaH+tvRpo6XBkucVWC3BjXkT7yEm/QrqUN+vkPhOhJUmSuJrkEjH9+0GgEOJrS7JBhj6JIS0bZHNvYCMyQJj7al8s627nbmdytNfQS+Et8A6mamJAp92LGSUFZPKktAmLTrPAZ0M1R5CFP0R6ET3JYRNpMDugK8+NDh23RyhpP9GF85BmTDPhoiCqQ0lyeALzhOVl7kZ+dgH+sacge3kfLmsDem5aDx/Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: se6fLtpK9WlugzD/aSal5Fasdq5gMNXLRArVFpZYoh3yyVC5HByV1T7CXtXxl6/Vu1WOE0uiZFEjiKcho5lu+eSi6tlODOGO8Td0yPvkvZR/O1bSKVWVMCeDJT5pxP8BmIYDWZld0Vweyk833VDopECoCE8+xdvlwSYvDWHleyfsUvxbSduZq7oCwT8dh4ZXSLB+p+3B8Y0QxPpR5MsnhipNTCyiH3qoKk81Gv/kCuJxcG/LKK/bZdfZqstUOnODnhtjWbqu7Lqqp+2sNgpQ73kIVzPhHoXeKFTEUbvaMSbQ8OpkypipHj2uAc4IoEvEymGJV9CgAHysRlvZf4jh5NZb3V2H8DkZOmSnzXzZbCWBFutaG86sBS+U5bYSIwjZQt7UIa2kYmGjodDoY3Nq6xbdD1RNw+0kR5QpYWzWS5HRVUOUVv8hIBubpEbiq3v0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 08:17:12.1060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80868c97-276d-4ce7-d6b6-08deaa7eb58f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9566
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

New offset and sh/mask are added for vpe v2.0.0

Acked-by: Roy Chan <Roy.Chan@amd.com>
Signed-off-by: Caden Chien <chih-wei.chien@amd.com>
---
 .../include/asic_reg/vpe/vpe_2_0_0_offset.h   | 1041 ++++++
 .../include/asic_reg/vpe/vpe_2_0_0_sh_mask.h  | 3162 +++++++++++++++++
 2 files changed, 4203 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_offset.h
new file mode 100644
index 000000000000..d815f560dacc
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_offset.h
@@ -0,0 +1,1041 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+ */
+
+#ifndef _vpe_2_0_0_OFFSET_HEADER
+#define _vpe_2_0_0_OFFSET_HEADER
+
+
+
+// addressBlock: vpe_vpec_vpecdec
+// base address: 0x46000
+#define regVPEC_DEC_START                                                                               0x0000
+#define regVPEC_DEC_START_BASE_IDX                                                                      0
+#define regVPEC_UCODE_ADDR                                                                              0x0001
+#define regVPEC_UCODE_ADDR_BASE_IDX                                                                     0
+#define regVPEC_UCODE_DATA                                                                              0x0002
+#define regVPEC_UCODE_DATA_BASE_IDX                                                                     0
+#define regVPEC_F32_CNTL                                                                                0x0003
+#define regVPEC_F32_CNTL_BASE_IDX                                                                       0
+#define regVPEC_MMHUB_CNTL                                                                              0x0004
+#define regVPEC_MMHUB_CNTL_BASE_IDX                                                                     0
+#define regVPEC_MMHUB_TRUSTLVL                                                                          0x0005
+#define regVPEC_MMHUB_TRUSTLVL_BASE_IDX                                                                 0
+#define regVPEC_VPEP_CTRL                                                                               0x0010
+#define regVPEC_VPEP_CTRL_BASE_IDX                                                                      0
+#define regVPEC_CLK_CTRL                                                                                0x0011
+#define regVPEC_CLK_CTRL_BASE_IDX                                                                       0
+#define regVPEC_COLLABORATE_CNTL                                                                        0x0012
+#define regVPEC_COLLABORATE_CNTL_BASE_IDX                                                               0
+#define regVPEC_COLLABORATE_CFG                                                                         0x0013
+#define regVPEC_COLLABORATE_CFG_BASE_IDX                                                                0
+#define regVPEC_POWER_CNTL                                                                              0x0014
+#define regVPEC_POWER_CNTL_BASE_IDX                                                                     0
+#define regVPEC_ZPR_CNTL                                                                                0x0015
+#define regVPEC_ZPR_CNTL_BASE_IDX                                                                       0
+#define regVPEC_CNTL                                                                                    0x0016
+#define regVPEC_CNTL_BASE_IDX                                                                           0
+#define regVPEC_CNTL_DCC                                                                                0x0017
+#define regVPEC_CNTL_DCC_BASE_IDX                                                                       0
+#define regVPEC_CE_OP_MULTI_64B_BURST                                                                   0x0018
+#define regVPEC_CE_OP_MULTI_64B_BURST_BASE_IDX                                                          0
+#define regVPEC_CNTL1                                                                                   0x0019
+#define regVPEC_CNTL1_BASE_IDX                                                                          0
+#define regVPEC_CNTL2                                                                                   0x001a
+#define regVPEC_CNTL2_BASE_IDX                                                                          0
+#define regVPEC_GB_ADDR_CONFIG                                                                          0x001b
+#define regVPEC_GB_ADDR_CONFIG_BASE_IDX                                                                 0
+#define regVPEC_GB_ADDR_CONFIG_READ                                                                     0x001c
+#define regVPEC_GB_ADDR_CONFIG_READ_BASE_IDX                                                            0
+#define regVPEC_GB_ADDR_CONFIG_META                                                                     0x001d
+#define regVPEC_GB_ADDR_CONFIG_META_BASE_IDX                                                            0
+#define regVPEC_PROCESS_QUANTUM0                                                                        0x001e
+#define regVPEC_PROCESS_QUANTUM0_BASE_IDX                                                               0
+#define regVPEC_PROCESS_QUANTUM1                                                                        0x001f
+#define regVPEC_PROCESS_QUANTUM1_BASE_IDX                                                               0
+#define regVPEC_CONTEXT_SWITCH_THRESHOLD                                                                0x0020
+#define regVPEC_CONTEXT_SWITCH_THRESHOLD_BASE_IDX                                                       0
+#define regVPEC_GLOBAL_QUANTUM                                                                          0x0021
+#define regVPEC_GLOBAL_QUANTUM_BASE_IDX                                                                 0
+#define regVPEC_WATCHDOG_CNTL                                                                           0x0025
+#define regVPEC_WATCHDOG_CNTL_BASE_IDX                                                                  0
+#define regVPEC_ATOMIC_CNTL                                                                             0x0026
+#define regVPEC_ATOMIC_CNTL_BASE_IDX                                                                    0
+#define regVPEC_UCODE_VERSION                                                                           0x0027
+#define regVPEC_UCODE_VERSION_BASE_IDX                                                                  0
+#define regVPEC_MEMREQ_BURST_CNTL                                                                       0x0028
+#define regVPEC_MEMREQ_BURST_CNTL_BASE_IDX                                                              0
+#define regVPEC_TIMESTAMP_CNTL                                                                          0x0029
+#define regVPEC_TIMESTAMP_CNTL_BASE_IDX                                                                 0
+#define regVPEC_GLOBAL_TIMESTAMP_LO                                                                     0x002a
+#define regVPEC_GLOBAL_TIMESTAMP_LO_BASE_IDX                                                            0
+#define regVPEC_GLOBAL_TIMESTAMP_HI                                                                     0x002b
+#define regVPEC_GLOBAL_TIMESTAMP_HI_BASE_IDX                                                            0
+#define regVPEC_FREEZE                                                                                  0x002c
+#define regVPEC_FREEZE_BASE_IDX                                                                         0
+#define regVPEC_CE_CTRL                                                                                 0x002d
+#define regVPEC_CE_CTRL_BASE_IDX                                                                        0
+#define regVPEC_RELAX_ORDERING_LUT                                                                      0x002e
+#define regVPEC_RELAX_ORDERING_LUT_BASE_IDX                                                             0
+#define regVPEC_CREDIT_CNTL                                                                             0x002f
+#define regVPEC_CREDIT_CNTL_BASE_IDX                                                                    0
+#define regVPEC_SCRATCH_RAM_DATA                                                                        0x0030
+#define regVPEC_SCRATCH_RAM_DATA_BASE_IDX                                                               0
+#define regVPEC_SCRATCH_RAM_ADDR                                                                        0x0031
+#define regVPEC_SCRATCH_RAM_ADDR_BASE_IDX                                                               0
+#define regVPEC_QUEUE_RESET_REQ                                                                         0x0032
+#define regVPEC_QUEUE_RESET_REQ_BASE_IDX                                                                0
+#define regVPEC_MAILBOX0                                                                                0x0040
+#define regVPEC_MAILBOX0_BASE_IDX                                                                       0
+#define regVPEC_MAILBOX1                                                                                0x0041
+#define regVPEC_MAILBOX1_BASE_IDX                                                                       0
+#define regVPEC_MAILBOX2                                                                                0x0042
+#define regVPEC_MAILBOX2_BASE_IDX                                                                       0
+#define regVPEC_MAILBOX3                                                                                0x0043
+#define regVPEC_MAILBOX3_BASE_IDX                                                                       0
+#define regVPEC_MAILBOX4                                                                                0x0044
+#define regVPEC_MAILBOX4_BASE_IDX                                                                       0
+#define regVPEC_MAILBOX5                                                                                0x0045
+#define regVPEC_MAILBOX5_BASE_IDX                                                                       0
+#define regVPEC_MAILBOX6                                                                                0x0046
+#define regVPEC_MAILBOX6_BASE_IDX                                                                       0
+#define regVPEC_MAILBOX7                                                                                0x0047
+#define regVPEC_MAILBOX7_BASE_IDX                                                                       0
+#define regVPEC_MAILBOX8                                                                                0x0048
+#define regVPEC_MAILBOX8_BASE_IDX                                                                       0
+#define regVPEC_MAILBOX9                                                                                0x0049
+#define regVPEC_MAILBOX9_BASE_IDX                                                                       0
+#define regVPEC_MAILBOX10                                                                               0x004a
+#define regVPEC_MAILBOX10_BASE_IDX                                                                      0
+#define regVPEC_MAILBOX11                                                                               0x004b
+#define regVPEC_MAILBOX11_BASE_IDX                                                                      0
+#define regVPEC_MAILBOX12                                                                               0x004c
+#define regVPEC_MAILBOX12_BASE_IDX                                                                      0
+#define regVPEC_MAILBOX13                                                                               0x004d
+#define regVPEC_MAILBOX13_BASE_IDX                                                                      0
+#define regVPEC_MAILBOX14                                                                               0x004e
+#define regVPEC_MAILBOX14_BASE_IDX                                                                      0
+#define regVPEC_MAILBOX15                                                                               0x004f
+#define regVPEC_MAILBOX15_BASE_IDX                                                                      0
+#define regVPEC_PUB_DUMMY0                                                                              0x0050
+#define regVPEC_PUB_DUMMY0_BASE_IDX                                                                     0
+#define regVPEC_PUB_DUMMY1                                                                              0x0051
+#define regVPEC_PUB_DUMMY1_BASE_IDX                                                                     0
+#define regVPEC_PUB_DUMMY2                                                                              0x0052
+#define regVPEC_PUB_DUMMY2_BASE_IDX                                                                     0
+#define regVPEC_PUB_DUMMY3                                                                              0x0053
+#define regVPEC_PUB_DUMMY3_BASE_IDX                                                                     0
+#define regVPEC_PUB_DUMMY4                                                                              0x0054
+#define regVPEC_PUB_DUMMY4_BASE_IDX                                                                     0
+#define regVPEC_PUB_DUMMY5                                                                              0x0055
+#define regVPEC_PUB_DUMMY5_BASE_IDX                                                                     0
+#define regVPEC_PUB_DUMMY6                                                                              0x0056
+#define regVPEC_PUB_DUMMY6_BASE_IDX                                                                     0
+#define regVPEC_PUB_DUMMY7                                                                              0x0057
+#define regVPEC_PUB_DUMMY7_BASE_IDX                                                                     0
+#define regVPEC_PUB_DUMMY8                                                                              0x0058
+#define regVPEC_PUB_DUMMY8_BASE_IDX                                                                     0
+#define regVPEC_PUB_DUMMY9                                                                              0x0059
+#define regVPEC_PUB_DUMMY9_BASE_IDX                                                                     0
+#define regVPEC_PUB_DUMMY10                                                                             0x005a
+#define regVPEC_PUB_DUMMY10_BASE_IDX                                                                    0
+#define regVPEC_PUB_DUMMY11                                                                             0x005b
+#define regVPEC_PUB_DUMMY11_BASE_IDX                                                                    0
+#define regVPEC_UCODE1_CHECKSUM                                                                         0x005c
+#define regVPEC_UCODE1_CHECKSUM_BASE_IDX                                                                0
+#define regVPEC_VERSION                                                                                 0x005d
+#define regVPEC_VERSION_BASE_IDX                                                                        0
+#define regVPEC_UCODE_CHECKSUM                                                                          0x005e
+#define regVPEC_UCODE_CHECKSUM_BASE_IDX                                                                 0
+#define regVPEC_RB_RPTR_FETCH                                                                           0x005f
+#define regVPEC_RB_RPTR_FETCH_BASE_IDX                                                                  0
+#define regVPEC_RB_RPTR_FETCH_HI                                                                        0x0060
+#define regVPEC_RB_RPTR_FETCH_HI_BASE_IDX                                                               0
+#define regVPEC_IB_OFFSET_FETCH                                                                         0x0061
+#define regVPEC_IB_OFFSET_FETCH_BASE_IDX                                                                0
+#define regVPEC_CMDIB_OFFSET_FETCH                                                                      0x0062
+#define regVPEC_CMDIB_OFFSET_FETCH_BASE_IDX                                                             0
+#define regVPEC_3DLUTIB_OFFSET_FETCH                                                                    0x0063
+#define regVPEC_3DLUTIB_OFFSET_FETCH_BASE_IDX                                                           0
+#define regVPEC_ATOMIC_PREOP_LO                                                                         0x0064
+#define regVPEC_ATOMIC_PREOP_LO_BASE_IDX                                                                0
+#define regVPEC_ATOMIC_PREOP_HI                                                                         0x0065
+#define regVPEC_ATOMIC_PREOP_HI_BASE_IDX                                                                0
+#define regVPEC_CE_BUSY                                                                                 0x0066
+#define regVPEC_CE_BUSY_BASE_IDX                                                                        0
+#define regVPEC_F32_COUNTER                                                                             0x0067
+#define regVPEC_F32_COUNTER_BASE_IDX                                                                    0
+#define regVPEC_HOLE_ADDR_LO                                                                            0x0068
+#define regVPEC_HOLE_ADDR_LO_BASE_IDX                                                                   0
+#define regVPEC_HOLE_ADDR_HI                                                                            0x0069
+#define regVPEC_HOLE_ADDR_HI_BASE_IDX                                                                   0
+#define regVPEC_ERROR_LOG                                                                               0x006a
+#define regVPEC_ERROR_LOG_BASE_IDX                                                                      0
+#define regVPEC_INT_STATUS                                                                              0x006b
+#define regVPEC_INT_STATUS_BASE_IDX                                                                     0
+#define regVPEC_STATUS                                                                                  0x006c
+#define regVPEC_STATUS_BASE_IDX                                                                         0
+#define regVPEC_STATUS1                                                                                 0x006d
+#define regVPEC_STATUS1_BASE_IDX                                                                        0
+#define regVPEC_STATUS2                                                                                 0x006e
+#define regVPEC_STATUS2_BASE_IDX                                                                        0
+#define regVPEC_STATUS3                                                                                 0x006f
+#define regVPEC_STATUS3_BASE_IDX                                                                        0
+#define regVPEC_STATUS4                                                                                 0x0070
+#define regVPEC_STATUS4_BASE_IDX                                                                        0
+#define regVPEC_STATUS5                                                                                 0x0071
+#define regVPEC_STATUS5_BASE_IDX                                                                        0
+#define regVPEC_STATUS6                                                                                 0x0072
+#define regVPEC_STATUS6_BASE_IDX                                                                        0
+#define regVPEC_STATUS7                                                                                 0x0073
+#define regVPEC_STATUS7_BASE_IDX                                                                        0
+#define regVPEC_STATUS8                                                                                 0x0074
+#define regVPEC_STATUS8_BASE_IDX                                                                        0
+#define regVPEC_STATUS9                                                                                 0x0075
+#define regVPEC_STATUS9_BASE_IDX                                                                        0
+#define regVPEC_STATUS10                                                                                0x0076
+#define regVPEC_STATUS10_BASE_IDX                                                                       0
+#define regVPEC_STATUS_DCC                                                                              0x0077
+#define regVPEC_STATUS_DCC_BASE_IDX                                                                     0
+#define regVPEC_STATUS11                                                                                0x0078
+#define regVPEC_STATUS11_BASE_IDX                                                                       0
+#define regVPEC_INST                                                                                    0x0079
+#define regVPEC_INST_BASE_IDX                                                                           0
+#define regVPEC_QUEUE_STATUS0                                                                           0x007a
+#define regVPEC_QUEUE_STATUS0_BASE_IDX                                                                  0
+#define regVPEC_QUEUE_HANG_STATUS                                                                       0x007b
+#define regVPEC_QUEUE_HANG_STATUS_BASE_IDX                                                              0
+#define regVPEC_DPM_IDLE_TIME                                                                           0x007c
+#define regVPEC_DPM_IDLE_TIME_BASE_IDX                                                                  0
+#define regVPEC_DPM_BUSY_TIME                                                                           0x007d
+#define regVPEC_DPM_BUSY_TIME_BASE_IDX                                                                  0
+#define regVPEC_DPM_IDLE_START_LO                                                                       0x007e
+#define regVPEC_DPM_IDLE_START_LO_BASE_IDX                                                              0
+#define regVPEC_DPM_IDLE_START_HI                                                                       0x007f
+#define regVPEC_DPM_IDLE_START_HI_BASE_IDX                                                              0
+#define regVPEC_DPM_BUSY_START_LO                                                                       0x0080
+#define regVPEC_DPM_BUSY_START_LO_BASE_IDX                                                              0
+#define regVPEC_DPM_BUSY_START_HI                                                                       0x0081
+#define regVPEC_DPM_BUSY_START_HI_BASE_IDX                                                              0
+#define regVPEC_DPM_LAST_REQ_TIMESTAMP                                                                  0x0082
+#define regVPEC_DPM_LAST_REQ_TIMESTAMP_BASE_IDX                                                         0
+#define regVPEC_DPM_NEW_JOB_DUMMY3                                                                      0x0083
+#define regVPEC_DPM_NEW_JOB_DUMMY3_BASE_IDX                                                             0
+#define regVPEC_DPM_STATE                                                                               0x0084
+#define regVPEC_DPM_STATE_BASE_IDX                                                                      0
+#define regVPEC_DPM0_FREQ                                                                               0x0085
+#define regVPEC_DPM0_FREQ_BASE_IDX                                                                      0
+#define regVPEC_DPM1_FREQ                                                                               0x0086
+#define regVPEC_DPM1_FREQ_BASE_IDX                                                                      0
+#define regVPEC_DPM2_FREQ                                                                               0x0087
+#define regVPEC_DPM2_FREQ_BASE_IDX                                                                      0
+#define regVPEC_DPM3_FREQ                                                                               0x0088
+#define regVPEC_DPM3_FREQ_BASE_IDX                                                                      0
+#define regVPEC_DPM_THRESHOLD_SKIP                                                                      0x0089
+#define regVPEC_DPM_THRESHOLD_SKIP_BASE_IDX                                                             0
+#define regVPEC_DPM_THRESHOLD_BUSY_OVERFLOW                                                             0x008a
+#define regVPEC_DPM_THRESHOLD_BUSY_OVERFLOW_BASE_IDX                                                    0
+#define regVPEC_DPM_CALC_BUSY_IN_POSTPROCESS                                                            0x008b
+#define regVPEC_DPM_CALC_BUSY_IN_POSTPROCESS_BASE_IDX                                                   0
+#define regVPEC_DPM_IN_CHECKIDLE_LOOP                                                                   0x008c
+#define regVPEC_DPM_IN_CHECKIDLE_LOOP_BASE_IDX                                                          0
+#define regVPEC_DPM_THRESHOLD_IDLE_OVERFLOW                                                             0x008d
+#define regVPEC_DPM_THRESHOLD_IDLE_OVERFLOW_BASE_IDX                                                    0
+#define regVPEC_DPM_BUSY_CLAMP_COUNT                                                                    0x008e
+#define regVPEC_DPM_BUSY_CLAMP_COUNT_BASE_IDX                                                           0
+#define regVPEC_DPM_IDLE_CLAMP_COUNT                                                                    0x008f
+#define regVPEC_DPM_IDLE_CLAMP_COUNT_BASE_IDX                                                           0
+#define regVPEC_PG_CNTL                                                                                 0x00b8
+#define regVPEC_PG_CNTL_BASE_IDX                                                                        0
+#define regVPEC_PG_STATUS                                                                               0x00b9
+#define regVPEC_PG_STATUS_BASE_IDX                                                                      0
+#define regVPEC_CLOCK_GATING_STATUS                                                                     0x00ba
+#define regVPEC_CLOCK_GATING_STATUS_BASE_IDX                                                            0
+#define regVPEC_QUEUE0_RB_CNTL                                                                          0x00c0
+#define regVPEC_QUEUE0_RB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE0_SCHEDULE_CNTL                                                                    0x00c1
+#define regVPEC_QUEUE0_SCHEDULE_CNTL_BASE_IDX                                                           0
+#define regVPEC_QUEUE0_RB_BASE                                                                          0x00c2
+#define regVPEC_QUEUE0_RB_BASE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE0_RB_BASE_HI                                                                       0x00c3
+#define regVPEC_QUEUE0_RB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE0_RB_RPTR                                                                          0x00c4
+#define regVPEC_QUEUE0_RB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE0_RB_RPTR_HI                                                                       0x00c5
+#define regVPEC_QUEUE0_RB_RPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE0_RB_WPTR                                                                          0x00c6
+#define regVPEC_QUEUE0_RB_WPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE0_RB_WPTR_HI                                                                       0x00c7
+#define regVPEC_QUEUE0_RB_WPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE0_RB_RPTR_ADDR_HI                                                                  0x00c8
+#define regVPEC_QUEUE0_RB_RPTR_ADDR_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE0_RB_RPTR_ADDR_LO                                                                  0x00c9
+#define regVPEC_QUEUE0_RB_RPTR_ADDR_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE0_RB_AQL_CNTL                                                                      0x00ca
+#define regVPEC_QUEUE0_RB_AQL_CNTL_BASE_IDX                                                             0
+#define regVPEC_QUEUE0_MINOR_PTR_UPDATE                                                                 0x00cb
+#define regVPEC_QUEUE0_MINOR_PTR_UPDATE_BASE_IDX                                                        0
+#define regVPEC_QUEUE0_CD_INFO                                                                          0x00cc
+#define regVPEC_QUEUE0_CD_INFO_BASE_IDX                                                                 0
+#define regVPEC_QUEUE0_RB_PREEMPT                                                                       0x00cd
+#define regVPEC_QUEUE0_RB_PREEMPT_BASE_IDX                                                              0
+#define regVPEC_QUEUE0_SKIP_CNTL                                                                        0x00ce
+#define regVPEC_QUEUE0_SKIP_CNTL_BASE_IDX                                                               0
+#define regVPEC_QUEUE0_DOORBELL                                                                         0x00cf
+#define regVPEC_QUEUE0_DOORBELL_BASE_IDX                                                                0
+#define regVPEC_QUEUE0_DOORBELL_OFFSET                                                                  0x00d0
+#define regVPEC_QUEUE0_DOORBELL_OFFSET_BASE_IDX                                                         0
+#define regVPEC_QUEUE0_DUMMY0                                                                           0x00d1
+#define regVPEC_QUEUE0_DUMMY0_BASE_IDX                                                                  0
+#define regVPEC_QUEUE0_DUMMY1                                                                           0x00d2
+#define regVPEC_QUEUE0_DUMMY1_BASE_IDX                                                                  0
+#define regVPEC_QUEUE0_DUMMY2                                                                           0x00d3
+#define regVPEC_QUEUE0_DUMMY2_BASE_IDX                                                                  0
+#define regVPEC_QUEUE0_DUMMY3                                                                           0x00d4
+#define regVPEC_QUEUE0_DUMMY3_BASE_IDX                                                                  0
+#define regVPEC_QUEUE0_DUMMY4                                                                           0x00d5
+#define regVPEC_QUEUE0_DUMMY4_BASE_IDX                                                                  0
+#define regVPEC_QUEUE0_IB_CNTL                                                                          0x00ec
+#define regVPEC_QUEUE0_IB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE0_IB_RPTR                                                                          0x00ed
+#define regVPEC_QUEUE0_IB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE0_IB_OFFSET                                                                        0x00ee
+#define regVPEC_QUEUE0_IB_OFFSET_BASE_IDX                                                               0
+#define regVPEC_QUEUE0_IB_BASE_LO                                                                       0x00ef
+#define regVPEC_QUEUE0_IB_BASE_LO_BASE_IDX                                                              0
+#define regVPEC_QUEUE0_IB_BASE_HI                                                                       0x00f0
+#define regVPEC_QUEUE0_IB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE0_IB_SIZE                                                                          0x00f1
+#define regVPEC_QUEUE0_IB_SIZE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE0_CMDIB_CNTL                                                                       0x00f2
+#define regVPEC_QUEUE0_CMDIB_CNTL_BASE_IDX                                                              0
+#define regVPEC_QUEUE0_CMDIB_RPTR                                                                       0x00f3
+#define regVPEC_QUEUE0_CMDIB_RPTR_BASE_IDX                                                              0
+#define regVPEC_QUEUE0_CMDIB_OFFSET                                                                     0x00f4
+#define regVPEC_QUEUE0_CMDIB_OFFSET_BASE_IDX                                                            0
+#define regVPEC_QUEUE0_CMDIB_BASE_LO                                                                    0x00f5
+#define regVPEC_QUEUE0_CMDIB_BASE_LO_BASE_IDX                                                           0
+#define regVPEC_QUEUE0_CMDIB_BASE_HI                                                                    0x00f6
+#define regVPEC_QUEUE0_CMDIB_BASE_HI_BASE_IDX                                                           0
+#define regVPEC_QUEUE0_CMDIB_SIZE                                                                       0x00f7
+#define regVPEC_QUEUE0_CMDIB_SIZE_BASE_IDX                                                              0
+#define regVPEC_QUEUE0_3DLUTIB_CNTL                                                                     0x00f8
+#define regVPEC_QUEUE0_3DLUTIB_CNTL_BASE_IDX                                                            0
+#define regVPEC_QUEUE0_3DLUTIB_RPTR                                                                     0x00f9
+#define regVPEC_QUEUE0_3DLUTIB_RPTR_BASE_IDX                                                            0
+#define regVPEC_QUEUE0_3DLUTIB_OFFSET                                                                   0x00fa
+#define regVPEC_QUEUE0_3DLUTIB_OFFSET_BASE_IDX                                                          0
+#define regVPEC_QUEUE0_3DLUTIB_BASE_LO                                                                  0x00fb
+#define regVPEC_QUEUE0_3DLUTIB_BASE_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE0_3DLUTIB_BASE_HI                                                                  0x00fc
+#define regVPEC_QUEUE0_3DLUTIB_BASE_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE0_3DLUTIB_SIZE                                                                     0x00fd
+#define regVPEC_QUEUE0_3DLUTIB_SIZE_BASE_IDX                                                            0
+#define regVPEC_QUEUE0_CSA_ADDR_LO                                                                      0x00fe
+#define regVPEC_QUEUE0_CSA_ADDR_LO_BASE_IDX                                                             0
+#define regVPEC_QUEUE0_CSA_ADDR_HI                                                                      0x00ff
+#define regVPEC_QUEUE0_CSA_ADDR_HI_BASE_IDX                                                             0
+#define regVPEC_QUEUE0_CONTEXT_STATUS                                                                   0x0100
+#define regVPEC_QUEUE0_CONTEXT_STATUS_BASE_IDX                                                          0
+#define regVPEC_QUEUE0_DOORBELL_LOG                                                                     0x0101
+#define regVPEC_QUEUE0_DOORBELL_LOG_BASE_IDX                                                            0
+#define regVPEC_QUEUE0_IB_SUB_REMAIN                                                                    0x0102
+#define regVPEC_QUEUE0_IB_SUB_REMAIN_BASE_IDX                                                           0
+#define regVPEC_QUEUE0_PREEMPT                                                                          0x0103
+#define regVPEC_QUEUE0_PREEMPT_BASE_IDX                                                                 0
+#define regVPEC_QUEUE0_LOG0BUFFER_CFG                                                                   0x0104
+#define regVPEC_QUEUE0_LOG0BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE0_LOG1BUFFER_CFG                                                                   0x0105
+#define regVPEC_QUEUE0_LOG1BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE1_RB_CNTL                                                                          0x0118
+#define regVPEC_QUEUE1_RB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE1_SCHEDULE_CNTL                                                                    0x0119
+#define regVPEC_QUEUE1_SCHEDULE_CNTL_BASE_IDX                                                           0
+#define regVPEC_QUEUE1_RB_BASE                                                                          0x011a
+#define regVPEC_QUEUE1_RB_BASE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE1_RB_BASE_HI                                                                       0x011b
+#define regVPEC_QUEUE1_RB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE1_RB_RPTR                                                                          0x011c
+#define regVPEC_QUEUE1_RB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE1_RB_RPTR_HI                                                                       0x011d
+#define regVPEC_QUEUE1_RB_RPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE1_RB_WPTR                                                                          0x011e
+#define regVPEC_QUEUE1_RB_WPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE1_RB_WPTR_HI                                                                       0x011f
+#define regVPEC_QUEUE1_RB_WPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE1_RB_RPTR_ADDR_HI                                                                  0x0120
+#define regVPEC_QUEUE1_RB_RPTR_ADDR_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE1_RB_RPTR_ADDR_LO                                                                  0x0121
+#define regVPEC_QUEUE1_RB_RPTR_ADDR_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE1_RB_AQL_CNTL                                                                      0x0122
+#define regVPEC_QUEUE1_RB_AQL_CNTL_BASE_IDX                                                             0
+#define regVPEC_QUEUE1_MINOR_PTR_UPDATE                                                                 0x0123
+#define regVPEC_QUEUE1_MINOR_PTR_UPDATE_BASE_IDX                                                        0
+#define regVPEC_QUEUE1_CD_INFO                                                                          0x0124
+#define regVPEC_QUEUE1_CD_INFO_BASE_IDX                                                                 0
+#define regVPEC_QUEUE1_RB_PREEMPT                                                                       0x0125
+#define regVPEC_QUEUE1_RB_PREEMPT_BASE_IDX                                                              0
+#define regVPEC_QUEUE1_SKIP_CNTL                                                                        0x0126
+#define regVPEC_QUEUE1_SKIP_CNTL_BASE_IDX                                                               0
+#define regVPEC_QUEUE1_DOORBELL                                                                         0x0127
+#define regVPEC_QUEUE1_DOORBELL_BASE_IDX                                                                0
+#define regVPEC_QUEUE1_DOORBELL_OFFSET                                                                  0x0128
+#define regVPEC_QUEUE1_DOORBELL_OFFSET_BASE_IDX                                                         0
+#define regVPEC_QUEUE1_DUMMY0                                                                           0x0129
+#define regVPEC_QUEUE1_DUMMY0_BASE_IDX                                                                  0
+#define regVPEC_QUEUE1_DUMMY1                                                                           0x012a
+#define regVPEC_QUEUE1_DUMMY1_BASE_IDX                                                                  0
+#define regVPEC_QUEUE1_DUMMY2                                                                           0x012b
+#define regVPEC_QUEUE1_DUMMY2_BASE_IDX                                                                  0
+#define regVPEC_QUEUE1_DUMMY3                                                                           0x012c
+#define regVPEC_QUEUE1_DUMMY3_BASE_IDX                                                                  0
+#define regVPEC_QUEUE1_DUMMY4                                                                           0x012d
+#define regVPEC_QUEUE1_DUMMY4_BASE_IDX                                                                  0
+#define regVPEC_QUEUE1_IB_CNTL                                                                          0x0144
+#define regVPEC_QUEUE1_IB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE1_IB_RPTR                                                                          0x0145
+#define regVPEC_QUEUE1_IB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE1_IB_OFFSET                                                                        0x0146
+#define regVPEC_QUEUE1_IB_OFFSET_BASE_IDX                                                               0
+#define regVPEC_QUEUE1_IB_BASE_LO                                                                       0x0147
+#define regVPEC_QUEUE1_IB_BASE_LO_BASE_IDX                                                              0
+#define regVPEC_QUEUE1_IB_BASE_HI                                                                       0x0148
+#define regVPEC_QUEUE1_IB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE1_IB_SIZE                                                                          0x0149
+#define regVPEC_QUEUE1_IB_SIZE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE1_CMDIB_CNTL                                                                       0x014a
+#define regVPEC_QUEUE1_CMDIB_CNTL_BASE_IDX                                                              0
+#define regVPEC_QUEUE1_CMDIB_RPTR                                                                       0x014b
+#define regVPEC_QUEUE1_CMDIB_RPTR_BASE_IDX                                                              0
+#define regVPEC_QUEUE1_CMDIB_OFFSET                                                                     0x014c
+#define regVPEC_QUEUE1_CMDIB_OFFSET_BASE_IDX                                                            0
+#define regVPEC_QUEUE1_CMDIB_BASE_LO                                                                    0x014d
+#define regVPEC_QUEUE1_CMDIB_BASE_LO_BASE_IDX                                                           0
+#define regVPEC_QUEUE1_CMDIB_BASE_HI                                                                    0x014e
+#define regVPEC_QUEUE1_CMDIB_BASE_HI_BASE_IDX                                                           0
+#define regVPEC_QUEUE1_CMDIB_SIZE                                                                       0x014f
+#define regVPEC_QUEUE1_CMDIB_SIZE_BASE_IDX                                                              0
+#define regVPEC_QUEUE1_3DLUTIB_CNTL                                                                     0x0150
+#define regVPEC_QUEUE1_3DLUTIB_CNTL_BASE_IDX                                                            0
+#define regVPEC_QUEUE1_3DLUTIB_RPTR                                                                     0x0151
+#define regVPEC_QUEUE1_3DLUTIB_RPTR_BASE_IDX                                                            0
+#define regVPEC_QUEUE1_3DLUTIB_OFFSET                                                                   0x0152
+#define regVPEC_QUEUE1_3DLUTIB_OFFSET_BASE_IDX                                                          0
+#define regVPEC_QUEUE1_3DLUTIB_BASE_LO                                                                  0x0153
+#define regVPEC_QUEUE1_3DLUTIB_BASE_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE1_3DLUTIB_BASE_HI                                                                  0x0154
+#define regVPEC_QUEUE1_3DLUTIB_BASE_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE1_3DLUTIB_SIZE                                                                     0x0155
+#define regVPEC_QUEUE1_3DLUTIB_SIZE_BASE_IDX                                                            0
+#define regVPEC_QUEUE1_CSA_ADDR_LO                                                                      0x0156
+#define regVPEC_QUEUE1_CSA_ADDR_LO_BASE_IDX                                                             0
+#define regVPEC_QUEUE1_CSA_ADDR_HI                                                                      0x0157
+#define regVPEC_QUEUE1_CSA_ADDR_HI_BASE_IDX                                                             0
+#define regVPEC_QUEUE1_CONTEXT_STATUS                                                                   0x0158
+#define regVPEC_QUEUE1_CONTEXT_STATUS_BASE_IDX                                                          0
+#define regVPEC_QUEUE1_DOORBELL_LOG                                                                     0x0159
+#define regVPEC_QUEUE1_DOORBELL_LOG_BASE_IDX                                                            0
+#define regVPEC_QUEUE1_IB_SUB_REMAIN                                                                    0x015a
+#define regVPEC_QUEUE1_IB_SUB_REMAIN_BASE_IDX                                                           0
+#define regVPEC_QUEUE1_PREEMPT                                                                          0x015b
+#define regVPEC_QUEUE1_PREEMPT_BASE_IDX                                                                 0
+#define regVPEC_QUEUE1_LOG0BUFFER_CFG                                                                   0x015c
+#define regVPEC_QUEUE1_LOG0BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE1_LOG1BUFFER_CFG                                                                   0x015d
+#define regVPEC_QUEUE1_LOG1BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE2_RB_CNTL                                                                          0x0170
+#define regVPEC_QUEUE2_RB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE2_SCHEDULE_CNTL                                                                    0x0171
+#define regVPEC_QUEUE2_SCHEDULE_CNTL_BASE_IDX                                                           0
+#define regVPEC_QUEUE2_RB_BASE                                                                          0x0172
+#define regVPEC_QUEUE2_RB_BASE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE2_RB_BASE_HI                                                                       0x0173
+#define regVPEC_QUEUE2_RB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE2_RB_RPTR                                                                          0x0174
+#define regVPEC_QUEUE2_RB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE2_RB_RPTR_HI                                                                       0x0175
+#define regVPEC_QUEUE2_RB_RPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE2_RB_WPTR                                                                          0x0176
+#define regVPEC_QUEUE2_RB_WPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE2_RB_WPTR_HI                                                                       0x0177
+#define regVPEC_QUEUE2_RB_WPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE2_RB_RPTR_ADDR_HI                                                                  0x0178
+#define regVPEC_QUEUE2_RB_RPTR_ADDR_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE2_RB_RPTR_ADDR_LO                                                                  0x0179
+#define regVPEC_QUEUE2_RB_RPTR_ADDR_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE2_RB_AQL_CNTL                                                                      0x017a
+#define regVPEC_QUEUE2_RB_AQL_CNTL_BASE_IDX                                                             0
+#define regVPEC_QUEUE2_MINOR_PTR_UPDATE                                                                 0x017b
+#define regVPEC_QUEUE2_MINOR_PTR_UPDATE_BASE_IDX                                                        0
+#define regVPEC_QUEUE2_CD_INFO                                                                          0x017c
+#define regVPEC_QUEUE2_CD_INFO_BASE_IDX                                                                 0
+#define regVPEC_QUEUE2_RB_PREEMPT                                                                       0x017d
+#define regVPEC_QUEUE2_RB_PREEMPT_BASE_IDX                                                              0
+#define regVPEC_QUEUE2_SKIP_CNTL                                                                        0x017e
+#define regVPEC_QUEUE2_SKIP_CNTL_BASE_IDX                                                               0
+#define regVPEC_QUEUE2_DOORBELL                                                                         0x017f
+#define regVPEC_QUEUE2_DOORBELL_BASE_IDX                                                                0
+#define regVPEC_QUEUE2_DOORBELL_OFFSET                                                                  0x0180
+#define regVPEC_QUEUE2_DOORBELL_OFFSET_BASE_IDX                                                         0
+#define regVPEC_QUEUE2_DUMMY0                                                                           0x0181
+#define regVPEC_QUEUE2_DUMMY0_BASE_IDX                                                                  0
+#define regVPEC_QUEUE2_DUMMY1                                                                           0x0182
+#define regVPEC_QUEUE2_DUMMY1_BASE_IDX                                                                  0
+#define regVPEC_QUEUE2_DUMMY2                                                                           0x0183
+#define regVPEC_QUEUE2_DUMMY2_BASE_IDX                                                                  0
+#define regVPEC_QUEUE2_DUMMY3                                                                           0x0184
+#define regVPEC_QUEUE2_DUMMY3_BASE_IDX                                                                  0
+#define regVPEC_QUEUE2_DUMMY4                                                                           0x0185
+#define regVPEC_QUEUE2_DUMMY4_BASE_IDX                                                                  0
+#define regVPEC_QUEUE2_IB_CNTL                                                                          0x019c
+#define regVPEC_QUEUE2_IB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE2_IB_RPTR                                                                          0x019d
+#define regVPEC_QUEUE2_IB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE2_IB_OFFSET                                                                        0x019e
+#define regVPEC_QUEUE2_IB_OFFSET_BASE_IDX                                                               0
+#define regVPEC_QUEUE2_IB_BASE_LO                                                                       0x019f
+#define regVPEC_QUEUE2_IB_BASE_LO_BASE_IDX                                                              0
+#define regVPEC_QUEUE2_IB_BASE_HI                                                                       0x01a0
+#define regVPEC_QUEUE2_IB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE2_IB_SIZE                                                                          0x01a1
+#define regVPEC_QUEUE2_IB_SIZE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE2_CMDIB_CNTL                                                                       0x01a2
+#define regVPEC_QUEUE2_CMDIB_CNTL_BASE_IDX                                                              0
+#define regVPEC_QUEUE2_CMDIB_RPTR                                                                       0x01a3
+#define regVPEC_QUEUE2_CMDIB_RPTR_BASE_IDX                                                              0
+#define regVPEC_QUEUE2_CMDIB_OFFSET                                                                     0x01a4
+#define regVPEC_QUEUE2_CMDIB_OFFSET_BASE_IDX                                                            0
+#define regVPEC_QUEUE2_CMDIB_BASE_LO                                                                    0x01a5
+#define regVPEC_QUEUE2_CMDIB_BASE_LO_BASE_IDX                                                           0
+#define regVPEC_QUEUE2_CMDIB_BASE_HI                                                                    0x01a6
+#define regVPEC_QUEUE2_CMDIB_BASE_HI_BASE_IDX                                                           0
+#define regVPEC_QUEUE2_CMDIB_SIZE                                                                       0x01a7
+#define regVPEC_QUEUE2_CMDIB_SIZE_BASE_IDX                                                              0
+#define regVPEC_QUEUE2_3DLUTIB_CNTL                                                                     0x01a8
+#define regVPEC_QUEUE2_3DLUTIB_CNTL_BASE_IDX                                                            0
+#define regVPEC_QUEUE2_3DLUTIB_RPTR                                                                     0x01a9
+#define regVPEC_QUEUE2_3DLUTIB_RPTR_BASE_IDX                                                            0
+#define regVPEC_QUEUE2_3DLUTIB_OFFSET                                                                   0x01aa
+#define regVPEC_QUEUE2_3DLUTIB_OFFSET_BASE_IDX                                                          0
+#define regVPEC_QUEUE2_3DLUTIB_BASE_LO                                                                  0x01ab
+#define regVPEC_QUEUE2_3DLUTIB_BASE_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE2_3DLUTIB_BASE_HI                                                                  0x01ac
+#define regVPEC_QUEUE2_3DLUTIB_BASE_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE2_3DLUTIB_SIZE                                                                     0x01ad
+#define regVPEC_QUEUE2_3DLUTIB_SIZE_BASE_IDX                                                            0
+#define regVPEC_QUEUE2_CSA_ADDR_LO                                                                      0x01ae
+#define regVPEC_QUEUE2_CSA_ADDR_LO_BASE_IDX                                                             0
+#define regVPEC_QUEUE2_CSA_ADDR_HI                                                                      0x01af
+#define regVPEC_QUEUE2_CSA_ADDR_HI_BASE_IDX                                                             0
+#define regVPEC_QUEUE2_CONTEXT_STATUS                                                                   0x01b0
+#define regVPEC_QUEUE2_CONTEXT_STATUS_BASE_IDX                                                          0
+#define regVPEC_QUEUE2_DOORBELL_LOG                                                                     0x01b1
+#define regVPEC_QUEUE2_DOORBELL_LOG_BASE_IDX                                                            0
+#define regVPEC_QUEUE2_IB_SUB_REMAIN                                                                    0x01b2
+#define regVPEC_QUEUE2_IB_SUB_REMAIN_BASE_IDX                                                           0
+#define regVPEC_QUEUE2_PREEMPT                                                                          0x01b3
+#define regVPEC_QUEUE2_PREEMPT_BASE_IDX                                                                 0
+#define regVPEC_QUEUE2_LOG0BUFFER_CFG                                                                   0x01b4
+#define regVPEC_QUEUE2_LOG0BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE2_LOG1BUFFER_CFG                                                                   0x01b5
+#define regVPEC_QUEUE2_LOG1BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE3_RB_CNTL                                                                          0x01c8
+#define regVPEC_QUEUE3_RB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE3_SCHEDULE_CNTL                                                                    0x01c9
+#define regVPEC_QUEUE3_SCHEDULE_CNTL_BASE_IDX                                                           0
+#define regVPEC_QUEUE3_RB_BASE                                                                          0x01ca
+#define regVPEC_QUEUE3_RB_BASE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE3_RB_BASE_HI                                                                       0x01cb
+#define regVPEC_QUEUE3_RB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE3_RB_RPTR                                                                          0x01cc
+#define regVPEC_QUEUE3_RB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE3_RB_RPTR_HI                                                                       0x01cd
+#define regVPEC_QUEUE3_RB_RPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE3_RB_WPTR                                                                          0x01ce
+#define regVPEC_QUEUE3_RB_WPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE3_RB_WPTR_HI                                                                       0x01cf
+#define regVPEC_QUEUE3_RB_WPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE3_RB_RPTR_ADDR_HI                                                                  0x01d0
+#define regVPEC_QUEUE3_RB_RPTR_ADDR_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE3_RB_RPTR_ADDR_LO                                                                  0x01d1
+#define regVPEC_QUEUE3_RB_RPTR_ADDR_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE3_RB_AQL_CNTL                                                                      0x01d2
+#define regVPEC_QUEUE3_RB_AQL_CNTL_BASE_IDX                                                             0
+#define regVPEC_QUEUE3_MINOR_PTR_UPDATE                                                                 0x01d3
+#define regVPEC_QUEUE3_MINOR_PTR_UPDATE_BASE_IDX                                                        0
+#define regVPEC_QUEUE3_CD_INFO                                                                          0x01d4
+#define regVPEC_QUEUE3_CD_INFO_BASE_IDX                                                                 0
+#define regVPEC_QUEUE3_RB_PREEMPT                                                                       0x01d5
+#define regVPEC_QUEUE3_RB_PREEMPT_BASE_IDX                                                              0
+#define regVPEC_QUEUE3_SKIP_CNTL                                                                        0x01d6
+#define regVPEC_QUEUE3_SKIP_CNTL_BASE_IDX                                                               0
+#define regVPEC_QUEUE3_DOORBELL                                                                         0x01d7
+#define regVPEC_QUEUE3_DOORBELL_BASE_IDX                                                                0
+#define regVPEC_QUEUE3_DOORBELL_OFFSET                                                                  0x01d8
+#define regVPEC_QUEUE3_DOORBELL_OFFSET_BASE_IDX                                                         0
+#define regVPEC_QUEUE3_DUMMY0                                                                           0x01d9
+#define regVPEC_QUEUE3_DUMMY0_BASE_IDX                                                                  0
+#define regVPEC_QUEUE3_DUMMY1                                                                           0x01da
+#define regVPEC_QUEUE3_DUMMY1_BASE_IDX                                                                  0
+#define regVPEC_QUEUE3_DUMMY2                                                                           0x01db
+#define regVPEC_QUEUE3_DUMMY2_BASE_IDX                                                                  0
+#define regVPEC_QUEUE3_DUMMY3                                                                           0x01dc
+#define regVPEC_QUEUE3_DUMMY3_BASE_IDX                                                                  0
+#define regVPEC_QUEUE3_DUMMY4                                                                           0x01dd
+#define regVPEC_QUEUE3_DUMMY4_BASE_IDX                                                                  0
+#define regVPEC_QUEUE3_IB_CNTL                                                                          0x01f4
+#define regVPEC_QUEUE3_IB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE3_IB_RPTR                                                                          0x01f5
+#define regVPEC_QUEUE3_IB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE3_IB_OFFSET                                                                        0x01f6
+#define regVPEC_QUEUE3_IB_OFFSET_BASE_IDX                                                               0
+#define regVPEC_QUEUE3_IB_BASE_LO                                                                       0x01f7
+#define regVPEC_QUEUE3_IB_BASE_LO_BASE_IDX                                                              0
+#define regVPEC_QUEUE3_IB_BASE_HI                                                                       0x01f8
+#define regVPEC_QUEUE3_IB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE3_IB_SIZE                                                                          0x01f9
+#define regVPEC_QUEUE3_IB_SIZE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE3_CMDIB_CNTL                                                                       0x01fa
+#define regVPEC_QUEUE3_CMDIB_CNTL_BASE_IDX                                                              0
+#define regVPEC_QUEUE3_CMDIB_RPTR                                                                       0x01fb
+#define regVPEC_QUEUE3_CMDIB_RPTR_BASE_IDX                                                              0
+#define regVPEC_QUEUE3_CMDIB_OFFSET                                                                     0x01fc
+#define regVPEC_QUEUE3_CMDIB_OFFSET_BASE_IDX                                                            0
+#define regVPEC_QUEUE3_CMDIB_BASE_LO                                                                    0x01fd
+#define regVPEC_QUEUE3_CMDIB_BASE_LO_BASE_IDX                                                           0
+#define regVPEC_QUEUE3_CMDIB_BASE_HI                                                                    0x01fe
+#define regVPEC_QUEUE3_CMDIB_BASE_HI_BASE_IDX                                                           0
+#define regVPEC_QUEUE3_CMDIB_SIZE                                                                       0x01ff
+#define regVPEC_QUEUE3_CMDIB_SIZE_BASE_IDX                                                              0
+#define regVPEC_QUEUE3_3DLUTIB_CNTL                                                                     0x0200
+#define regVPEC_QUEUE3_3DLUTIB_CNTL_BASE_IDX                                                            0
+#define regVPEC_QUEUE3_3DLUTIB_RPTR                                                                     0x0201
+#define regVPEC_QUEUE3_3DLUTIB_RPTR_BASE_IDX                                                            0
+#define regVPEC_QUEUE3_3DLUTIB_OFFSET                                                                   0x0202
+#define regVPEC_QUEUE3_3DLUTIB_OFFSET_BASE_IDX                                                          0
+#define regVPEC_QUEUE3_3DLUTIB_BASE_LO                                                                  0x0203
+#define regVPEC_QUEUE3_3DLUTIB_BASE_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE3_3DLUTIB_BASE_HI                                                                  0x0204
+#define regVPEC_QUEUE3_3DLUTIB_BASE_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE3_3DLUTIB_SIZE                                                                     0x0205
+#define regVPEC_QUEUE3_3DLUTIB_SIZE_BASE_IDX                                                            0
+#define regVPEC_QUEUE3_CSA_ADDR_LO                                                                      0x0206
+#define regVPEC_QUEUE3_CSA_ADDR_LO_BASE_IDX                                                             0
+#define regVPEC_QUEUE3_CSA_ADDR_HI                                                                      0x0207
+#define regVPEC_QUEUE3_CSA_ADDR_HI_BASE_IDX                                                             0
+#define regVPEC_QUEUE3_CONTEXT_STATUS                                                                   0x0208
+#define regVPEC_QUEUE3_CONTEXT_STATUS_BASE_IDX                                                          0
+#define regVPEC_QUEUE3_DOORBELL_LOG                                                                     0x0209
+#define regVPEC_QUEUE3_DOORBELL_LOG_BASE_IDX                                                            0
+#define regVPEC_QUEUE3_IB_SUB_REMAIN                                                                    0x020a
+#define regVPEC_QUEUE3_IB_SUB_REMAIN_BASE_IDX                                                           0
+#define regVPEC_QUEUE3_PREEMPT                                                                          0x020b
+#define regVPEC_QUEUE3_PREEMPT_BASE_IDX                                                                 0
+#define regVPEC_QUEUE3_LOG0BUFFER_CFG                                                                   0x020c
+#define regVPEC_QUEUE3_LOG0BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE3_LOG1BUFFER_CFG                                                                   0x020d
+#define regVPEC_QUEUE3_LOG1BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE4_RB_CNTL                                                                          0x0220
+#define regVPEC_QUEUE4_RB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE4_SCHEDULE_CNTL                                                                    0x0221
+#define regVPEC_QUEUE4_SCHEDULE_CNTL_BASE_IDX                                                           0
+#define regVPEC_QUEUE4_RB_BASE                                                                          0x0222
+#define regVPEC_QUEUE4_RB_BASE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE4_RB_BASE_HI                                                                       0x0223
+#define regVPEC_QUEUE4_RB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE4_RB_RPTR                                                                          0x0224
+#define regVPEC_QUEUE4_RB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE4_RB_RPTR_HI                                                                       0x0225
+#define regVPEC_QUEUE4_RB_RPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE4_RB_WPTR                                                                          0x0226
+#define regVPEC_QUEUE4_RB_WPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE4_RB_WPTR_HI                                                                       0x0227
+#define regVPEC_QUEUE4_RB_WPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE4_RB_RPTR_ADDR_HI                                                                  0x0228
+#define regVPEC_QUEUE4_RB_RPTR_ADDR_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE4_RB_RPTR_ADDR_LO                                                                  0x0229
+#define regVPEC_QUEUE4_RB_RPTR_ADDR_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE4_RB_AQL_CNTL                                                                      0x022a
+#define regVPEC_QUEUE4_RB_AQL_CNTL_BASE_IDX                                                             0
+#define regVPEC_QUEUE4_MINOR_PTR_UPDATE                                                                 0x022b
+#define regVPEC_QUEUE4_MINOR_PTR_UPDATE_BASE_IDX                                                        0
+#define regVPEC_QUEUE4_CD_INFO                                                                          0x022c
+#define regVPEC_QUEUE4_CD_INFO_BASE_IDX                                                                 0
+#define regVPEC_QUEUE4_RB_PREEMPT                                                                       0x022d
+#define regVPEC_QUEUE4_RB_PREEMPT_BASE_IDX                                                              0
+#define regVPEC_QUEUE4_SKIP_CNTL                                                                        0x022e
+#define regVPEC_QUEUE4_SKIP_CNTL_BASE_IDX                                                               0
+#define regVPEC_QUEUE4_DOORBELL                                                                         0x022f
+#define regVPEC_QUEUE4_DOORBELL_BASE_IDX                                                                0
+#define regVPEC_QUEUE4_DOORBELL_OFFSET                                                                  0x0230
+#define regVPEC_QUEUE4_DOORBELL_OFFSET_BASE_IDX                                                         0
+#define regVPEC_QUEUE4_DUMMY0                                                                           0x0231
+#define regVPEC_QUEUE4_DUMMY0_BASE_IDX                                                                  0
+#define regVPEC_QUEUE4_DUMMY1                                                                           0x0232
+#define regVPEC_QUEUE4_DUMMY1_BASE_IDX                                                                  0
+#define regVPEC_QUEUE4_DUMMY2                                                                           0x0233
+#define regVPEC_QUEUE4_DUMMY2_BASE_IDX                                                                  0
+#define regVPEC_QUEUE4_DUMMY3                                                                           0x0234
+#define regVPEC_QUEUE4_DUMMY3_BASE_IDX                                                                  0
+#define regVPEC_QUEUE4_DUMMY4                                                                           0x0235
+#define regVPEC_QUEUE4_DUMMY4_BASE_IDX                                                                  0
+#define regVPEC_QUEUE4_IB_CNTL                                                                          0x024c
+#define regVPEC_QUEUE4_IB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE4_IB_RPTR                                                                          0x024d
+#define regVPEC_QUEUE4_IB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE4_IB_OFFSET                                                                        0x024e
+#define regVPEC_QUEUE4_IB_OFFSET_BASE_IDX                                                               0
+#define regVPEC_QUEUE4_IB_BASE_LO                                                                       0x024f
+#define regVPEC_QUEUE4_IB_BASE_LO_BASE_IDX                                                              0
+#define regVPEC_QUEUE4_IB_BASE_HI                                                                       0x0250
+#define regVPEC_QUEUE4_IB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE4_IB_SIZE                                                                          0x0251
+#define regVPEC_QUEUE4_IB_SIZE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE4_CMDIB_CNTL                                                                       0x0252
+#define regVPEC_QUEUE4_CMDIB_CNTL_BASE_IDX                                                              0
+#define regVPEC_QUEUE4_CMDIB_RPTR                                                                       0x0253
+#define regVPEC_QUEUE4_CMDIB_RPTR_BASE_IDX                                                              0
+#define regVPEC_QUEUE4_CMDIB_OFFSET                                                                     0x0254
+#define regVPEC_QUEUE4_CMDIB_OFFSET_BASE_IDX                                                            0
+#define regVPEC_QUEUE4_CMDIB_BASE_LO                                                                    0x0255
+#define regVPEC_QUEUE4_CMDIB_BASE_LO_BASE_IDX                                                           0
+#define regVPEC_QUEUE4_CMDIB_BASE_HI                                                                    0x0256
+#define regVPEC_QUEUE4_CMDIB_BASE_HI_BASE_IDX                                                           0
+#define regVPEC_QUEUE4_CMDIB_SIZE                                                                       0x0257
+#define regVPEC_QUEUE4_CMDIB_SIZE_BASE_IDX                                                              0
+#define regVPEC_QUEUE4_3DLUTIB_CNTL                                                                     0x0258
+#define regVPEC_QUEUE4_3DLUTIB_CNTL_BASE_IDX                                                            0
+#define regVPEC_QUEUE4_3DLUTIB_RPTR                                                                     0x0259
+#define regVPEC_QUEUE4_3DLUTIB_RPTR_BASE_IDX                                                            0
+#define regVPEC_QUEUE4_3DLUTIB_OFFSET                                                                   0x025a
+#define regVPEC_QUEUE4_3DLUTIB_OFFSET_BASE_IDX                                                          0
+#define regVPEC_QUEUE4_3DLUTIB_BASE_LO                                                                  0x025b
+#define regVPEC_QUEUE4_3DLUTIB_BASE_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE4_3DLUTIB_BASE_HI                                                                  0x025c
+#define regVPEC_QUEUE4_3DLUTIB_BASE_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE4_3DLUTIB_SIZE                                                                     0x025d
+#define regVPEC_QUEUE4_3DLUTIB_SIZE_BASE_IDX                                                            0
+#define regVPEC_QUEUE4_CSA_ADDR_LO                                                                      0x025e
+#define regVPEC_QUEUE4_CSA_ADDR_LO_BASE_IDX                                                             0
+#define regVPEC_QUEUE4_CSA_ADDR_HI                                                                      0x025f
+#define regVPEC_QUEUE4_CSA_ADDR_HI_BASE_IDX                                                             0
+#define regVPEC_QUEUE4_CONTEXT_STATUS                                                                   0x0260
+#define regVPEC_QUEUE4_CONTEXT_STATUS_BASE_IDX                                                          0
+#define regVPEC_QUEUE4_DOORBELL_LOG                                                                     0x0261
+#define regVPEC_QUEUE4_DOORBELL_LOG_BASE_IDX                                                            0
+#define regVPEC_QUEUE4_IB_SUB_REMAIN                                                                    0x0262
+#define regVPEC_QUEUE4_IB_SUB_REMAIN_BASE_IDX                                                           0
+#define regVPEC_QUEUE4_PREEMPT                                                                          0x0263
+#define regVPEC_QUEUE4_PREEMPT_BASE_IDX                                                                 0
+#define regVPEC_QUEUE4_LOG0BUFFER_CFG                                                                   0x0264
+#define regVPEC_QUEUE4_LOG0BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE4_LOG1BUFFER_CFG                                                                   0x0265
+#define regVPEC_QUEUE4_LOG1BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE5_RB_CNTL                                                                          0x0278
+#define regVPEC_QUEUE5_RB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE5_SCHEDULE_CNTL                                                                    0x0279
+#define regVPEC_QUEUE5_SCHEDULE_CNTL_BASE_IDX                                                           0
+#define regVPEC_QUEUE5_RB_BASE                                                                          0x027a
+#define regVPEC_QUEUE5_RB_BASE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE5_RB_BASE_HI                                                                       0x027b
+#define regVPEC_QUEUE5_RB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE5_RB_RPTR                                                                          0x027c
+#define regVPEC_QUEUE5_RB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE5_RB_RPTR_HI                                                                       0x027d
+#define regVPEC_QUEUE5_RB_RPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE5_RB_WPTR                                                                          0x027e
+#define regVPEC_QUEUE5_RB_WPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE5_RB_WPTR_HI                                                                       0x027f
+#define regVPEC_QUEUE5_RB_WPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE5_RB_RPTR_ADDR_HI                                                                  0x0280
+#define regVPEC_QUEUE5_RB_RPTR_ADDR_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE5_RB_RPTR_ADDR_LO                                                                  0x0281
+#define regVPEC_QUEUE5_RB_RPTR_ADDR_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE5_RB_AQL_CNTL                                                                      0x0282
+#define regVPEC_QUEUE5_RB_AQL_CNTL_BASE_IDX                                                             0
+#define regVPEC_QUEUE5_MINOR_PTR_UPDATE                                                                 0x0283
+#define regVPEC_QUEUE5_MINOR_PTR_UPDATE_BASE_IDX                                                        0
+#define regVPEC_QUEUE5_CD_INFO                                                                          0x0284
+#define regVPEC_QUEUE5_CD_INFO_BASE_IDX                                                                 0
+#define regVPEC_QUEUE5_RB_PREEMPT                                                                       0x0285
+#define regVPEC_QUEUE5_RB_PREEMPT_BASE_IDX                                                              0
+#define regVPEC_QUEUE5_SKIP_CNTL                                                                        0x0286
+#define regVPEC_QUEUE5_SKIP_CNTL_BASE_IDX                                                               0
+#define regVPEC_QUEUE5_DOORBELL                                                                         0x0287
+#define regVPEC_QUEUE5_DOORBELL_BASE_IDX                                                                0
+#define regVPEC_QUEUE5_DOORBELL_OFFSET                                                                  0x0288
+#define regVPEC_QUEUE5_DOORBELL_OFFSET_BASE_IDX                                                         0
+#define regVPEC_QUEUE5_DUMMY0                                                                           0x0289
+#define regVPEC_QUEUE5_DUMMY0_BASE_IDX                                                                  0
+#define regVPEC_QUEUE5_DUMMY1                                                                           0x028a
+#define regVPEC_QUEUE5_DUMMY1_BASE_IDX                                                                  0
+#define regVPEC_QUEUE5_DUMMY2                                                                           0x028b
+#define regVPEC_QUEUE5_DUMMY2_BASE_IDX                                                                  0
+#define regVPEC_QUEUE5_DUMMY3                                                                           0x028c
+#define regVPEC_QUEUE5_DUMMY3_BASE_IDX                                                                  0
+#define regVPEC_QUEUE5_DUMMY4                                                                           0x028d
+#define regVPEC_QUEUE5_DUMMY4_BASE_IDX                                                                  0
+#define regVPEC_QUEUE5_IB_CNTL                                                                          0x02a4
+#define regVPEC_QUEUE5_IB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE5_IB_RPTR                                                                          0x02a5
+#define regVPEC_QUEUE5_IB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE5_IB_OFFSET                                                                        0x02a6
+#define regVPEC_QUEUE5_IB_OFFSET_BASE_IDX                                                               0
+#define regVPEC_QUEUE5_IB_BASE_LO                                                                       0x02a7
+#define regVPEC_QUEUE5_IB_BASE_LO_BASE_IDX                                                              0
+#define regVPEC_QUEUE5_IB_BASE_HI                                                                       0x02a8
+#define regVPEC_QUEUE5_IB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE5_IB_SIZE                                                                          0x02a9
+#define regVPEC_QUEUE5_IB_SIZE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE5_CMDIB_CNTL                                                                       0x02aa
+#define regVPEC_QUEUE5_CMDIB_CNTL_BASE_IDX                                                              0
+#define regVPEC_QUEUE5_CMDIB_RPTR                                                                       0x02ab
+#define regVPEC_QUEUE5_CMDIB_RPTR_BASE_IDX                                                              0
+#define regVPEC_QUEUE5_CMDIB_OFFSET                                                                     0x02ac
+#define regVPEC_QUEUE5_CMDIB_OFFSET_BASE_IDX                                                            0
+#define regVPEC_QUEUE5_CMDIB_BASE_LO                                                                    0x02ad
+#define regVPEC_QUEUE5_CMDIB_BASE_LO_BASE_IDX                                                           0
+#define regVPEC_QUEUE5_CMDIB_BASE_HI                                                                    0x02ae
+#define regVPEC_QUEUE5_CMDIB_BASE_HI_BASE_IDX                                                           0
+#define regVPEC_QUEUE5_CMDIB_SIZE                                                                       0x02af
+#define regVPEC_QUEUE5_CMDIB_SIZE_BASE_IDX                                                              0
+#define regVPEC_QUEUE5_3DLUTIB_CNTL                                                                     0x02b0
+#define regVPEC_QUEUE5_3DLUTIB_CNTL_BASE_IDX                                                            0
+#define regVPEC_QUEUE5_3DLUTIB_RPTR                                                                     0x02b1
+#define regVPEC_QUEUE5_3DLUTIB_RPTR_BASE_IDX                                                            0
+#define regVPEC_QUEUE5_3DLUTIB_OFFSET                                                                   0x02b2
+#define regVPEC_QUEUE5_3DLUTIB_OFFSET_BASE_IDX                                                          0
+#define regVPEC_QUEUE5_3DLUTIB_BASE_LO                                                                  0x02b3
+#define regVPEC_QUEUE5_3DLUTIB_BASE_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE5_3DLUTIB_BASE_HI                                                                  0x02b4
+#define regVPEC_QUEUE5_3DLUTIB_BASE_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE5_3DLUTIB_SIZE                                                                     0x02b5
+#define regVPEC_QUEUE5_3DLUTIB_SIZE_BASE_IDX                                                            0
+#define regVPEC_QUEUE5_CSA_ADDR_LO                                                                      0x02b6
+#define regVPEC_QUEUE5_CSA_ADDR_LO_BASE_IDX                                                             0
+#define regVPEC_QUEUE5_CSA_ADDR_HI                                                                      0x02b7
+#define regVPEC_QUEUE5_CSA_ADDR_HI_BASE_IDX                                                             0
+#define regVPEC_QUEUE5_CONTEXT_STATUS                                                                   0x02b8
+#define regVPEC_QUEUE5_CONTEXT_STATUS_BASE_IDX                                                          0
+#define regVPEC_QUEUE5_DOORBELL_LOG                                                                     0x02b9
+#define regVPEC_QUEUE5_DOORBELL_LOG_BASE_IDX                                                            0
+#define regVPEC_QUEUE5_IB_SUB_REMAIN                                                                    0x02ba
+#define regVPEC_QUEUE5_IB_SUB_REMAIN_BASE_IDX                                                           0
+#define regVPEC_QUEUE5_PREEMPT                                                                          0x02bb
+#define regVPEC_QUEUE5_PREEMPT_BASE_IDX                                                                 0
+#define regVPEC_QUEUE5_LOG0BUFFER_CFG                                                                   0x02bc
+#define regVPEC_QUEUE5_LOG0BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE5_LOG1BUFFER_CFG                                                                   0x02bd
+#define regVPEC_QUEUE5_LOG1BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE6_RB_CNTL                                                                          0x02d0
+#define regVPEC_QUEUE6_RB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE6_SCHEDULE_CNTL                                                                    0x02d1
+#define regVPEC_QUEUE6_SCHEDULE_CNTL_BASE_IDX                                                           0
+#define regVPEC_QUEUE6_RB_BASE                                                                          0x02d2
+#define regVPEC_QUEUE6_RB_BASE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE6_RB_BASE_HI                                                                       0x02d3
+#define regVPEC_QUEUE6_RB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE6_RB_RPTR                                                                          0x02d4
+#define regVPEC_QUEUE6_RB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE6_RB_RPTR_HI                                                                       0x02d5
+#define regVPEC_QUEUE6_RB_RPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE6_RB_WPTR                                                                          0x02d6
+#define regVPEC_QUEUE6_RB_WPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE6_RB_WPTR_HI                                                                       0x02d7
+#define regVPEC_QUEUE6_RB_WPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE6_RB_RPTR_ADDR_HI                                                                  0x02d8
+#define regVPEC_QUEUE6_RB_RPTR_ADDR_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE6_RB_RPTR_ADDR_LO                                                                  0x02d9
+#define regVPEC_QUEUE6_RB_RPTR_ADDR_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE6_RB_AQL_CNTL                                                                      0x02da
+#define regVPEC_QUEUE6_RB_AQL_CNTL_BASE_IDX                                                             0
+#define regVPEC_QUEUE6_MINOR_PTR_UPDATE                                                                 0x02db
+#define regVPEC_QUEUE6_MINOR_PTR_UPDATE_BASE_IDX                                                        0
+#define regVPEC_QUEUE6_CD_INFO                                                                          0x02dc
+#define regVPEC_QUEUE6_CD_INFO_BASE_IDX                                                                 0
+#define regVPEC_QUEUE6_RB_PREEMPT                                                                       0x02dd
+#define regVPEC_QUEUE6_RB_PREEMPT_BASE_IDX                                                              0
+#define regVPEC_QUEUE6_SKIP_CNTL                                                                        0x02de
+#define regVPEC_QUEUE6_SKIP_CNTL_BASE_IDX                                                               0
+#define regVPEC_QUEUE6_DOORBELL                                                                         0x02df
+#define regVPEC_QUEUE6_DOORBELL_BASE_IDX                                                                0
+#define regVPEC_QUEUE6_DOORBELL_OFFSET                                                                  0x02e0
+#define regVPEC_QUEUE6_DOORBELL_OFFSET_BASE_IDX                                                         0
+#define regVPEC_QUEUE6_DUMMY0                                                                           0x02e1
+#define regVPEC_QUEUE6_DUMMY0_BASE_IDX                                                                  0
+#define regVPEC_QUEUE6_DUMMY1                                                                           0x02e2
+#define regVPEC_QUEUE6_DUMMY1_BASE_IDX                                                                  0
+#define regVPEC_QUEUE6_DUMMY2                                                                           0x02e3
+#define regVPEC_QUEUE6_DUMMY2_BASE_IDX                                                                  0
+#define regVPEC_QUEUE6_DUMMY3                                                                           0x02e4
+#define regVPEC_QUEUE6_DUMMY3_BASE_IDX                                                                  0
+#define regVPEC_QUEUE6_DUMMY4                                                                           0x02e5
+#define regVPEC_QUEUE6_DUMMY4_BASE_IDX                                                                  0
+#define regVPEC_QUEUE6_IB_CNTL                                                                          0x02fc
+#define regVPEC_QUEUE6_IB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE6_IB_RPTR                                                                          0x02fd
+#define regVPEC_QUEUE6_IB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE6_IB_OFFSET                                                                        0x02fe
+#define regVPEC_QUEUE6_IB_OFFSET_BASE_IDX                                                               0
+#define regVPEC_QUEUE6_IB_BASE_LO                                                                       0x02ff
+#define regVPEC_QUEUE6_IB_BASE_LO_BASE_IDX                                                              0
+#define regVPEC_QUEUE6_IB_BASE_HI                                                                       0x0300
+#define regVPEC_QUEUE6_IB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE6_IB_SIZE                                                                          0x0301
+#define regVPEC_QUEUE6_IB_SIZE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE6_CMDIB_CNTL                                                                       0x0302
+#define regVPEC_QUEUE6_CMDIB_CNTL_BASE_IDX                                                              0
+#define regVPEC_QUEUE6_CMDIB_RPTR                                                                       0x0303
+#define regVPEC_QUEUE6_CMDIB_RPTR_BASE_IDX                                                              0
+#define regVPEC_QUEUE6_CMDIB_OFFSET                                                                     0x0304
+#define regVPEC_QUEUE6_CMDIB_OFFSET_BASE_IDX                                                            0
+#define regVPEC_QUEUE6_CMDIB_BASE_LO                                                                    0x0305
+#define regVPEC_QUEUE6_CMDIB_BASE_LO_BASE_IDX                                                           0
+#define regVPEC_QUEUE6_CMDIB_BASE_HI                                                                    0x0306
+#define regVPEC_QUEUE6_CMDIB_BASE_HI_BASE_IDX                                                           0
+#define regVPEC_QUEUE6_CMDIB_SIZE                                                                       0x0307
+#define regVPEC_QUEUE6_CMDIB_SIZE_BASE_IDX                                                              0
+#define regVPEC_QUEUE6_3DLUTIB_CNTL                                                                     0x0308
+#define regVPEC_QUEUE6_3DLUTIB_CNTL_BASE_IDX                                                            0
+#define regVPEC_QUEUE6_3DLUTIB_RPTR                                                                     0x0309
+#define regVPEC_QUEUE6_3DLUTIB_RPTR_BASE_IDX                                                            0
+#define regVPEC_QUEUE6_3DLUTIB_OFFSET                                                                   0x030a
+#define regVPEC_QUEUE6_3DLUTIB_OFFSET_BASE_IDX                                                          0
+#define regVPEC_QUEUE6_3DLUTIB_BASE_LO                                                                  0x030b
+#define regVPEC_QUEUE6_3DLUTIB_BASE_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE6_3DLUTIB_BASE_HI                                                                  0x030c
+#define regVPEC_QUEUE6_3DLUTIB_BASE_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE6_3DLUTIB_SIZE                                                                     0x030d
+#define regVPEC_QUEUE6_3DLUTIB_SIZE_BASE_IDX                                                            0
+#define regVPEC_QUEUE6_CSA_ADDR_LO                                                                      0x030e
+#define regVPEC_QUEUE6_CSA_ADDR_LO_BASE_IDX                                                             0
+#define regVPEC_QUEUE6_CSA_ADDR_HI                                                                      0x030f
+#define regVPEC_QUEUE6_CSA_ADDR_HI_BASE_IDX                                                             0
+#define regVPEC_QUEUE6_CONTEXT_STATUS                                                                   0x0310
+#define regVPEC_QUEUE6_CONTEXT_STATUS_BASE_IDX                                                          0
+#define regVPEC_QUEUE6_DOORBELL_LOG                                                                     0x0311
+#define regVPEC_QUEUE6_DOORBELL_LOG_BASE_IDX                                                            0
+#define regVPEC_QUEUE6_IB_SUB_REMAIN                                                                    0x0312
+#define regVPEC_QUEUE6_IB_SUB_REMAIN_BASE_IDX                                                           0
+#define regVPEC_QUEUE6_PREEMPT                                                                          0x0313
+#define regVPEC_QUEUE6_PREEMPT_BASE_IDX                                                                 0
+#define regVPEC_QUEUE6_LOG0BUFFER_CFG                                                                   0x0314
+#define regVPEC_QUEUE6_LOG0BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE6_LOG1BUFFER_CFG                                                                   0x0315
+#define regVPEC_QUEUE6_LOG1BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE7_RB_CNTL                                                                          0x0328
+#define regVPEC_QUEUE7_RB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE7_SCHEDULE_CNTL                                                                    0x0329
+#define regVPEC_QUEUE7_SCHEDULE_CNTL_BASE_IDX                                                           0
+#define regVPEC_QUEUE7_RB_BASE                                                                          0x032a
+#define regVPEC_QUEUE7_RB_BASE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE7_RB_BASE_HI                                                                       0x032b
+#define regVPEC_QUEUE7_RB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE7_RB_RPTR                                                                          0x032c
+#define regVPEC_QUEUE7_RB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE7_RB_RPTR_HI                                                                       0x032d
+#define regVPEC_QUEUE7_RB_RPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE7_RB_WPTR                                                                          0x032e
+#define regVPEC_QUEUE7_RB_WPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE7_RB_WPTR_HI                                                                       0x032f
+#define regVPEC_QUEUE7_RB_WPTR_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE7_RB_RPTR_ADDR_HI                                                                  0x0330
+#define regVPEC_QUEUE7_RB_RPTR_ADDR_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE7_RB_RPTR_ADDR_LO                                                                  0x0331
+#define regVPEC_QUEUE7_RB_RPTR_ADDR_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE7_RB_AQL_CNTL                                                                      0x0332
+#define regVPEC_QUEUE7_RB_AQL_CNTL_BASE_IDX                                                             0
+#define regVPEC_QUEUE7_MINOR_PTR_UPDATE                                                                 0x0333
+#define regVPEC_QUEUE7_MINOR_PTR_UPDATE_BASE_IDX                                                        0
+#define regVPEC_QUEUE7_CD_INFO                                                                          0x0334
+#define regVPEC_QUEUE7_CD_INFO_BASE_IDX                                                                 0
+#define regVPEC_QUEUE7_RB_PREEMPT                                                                       0x0335
+#define regVPEC_QUEUE7_RB_PREEMPT_BASE_IDX                                                              0
+#define regVPEC_QUEUE7_SKIP_CNTL                                                                        0x0336
+#define regVPEC_QUEUE7_SKIP_CNTL_BASE_IDX                                                               0
+#define regVPEC_QUEUE7_DOORBELL                                                                         0x0337
+#define regVPEC_QUEUE7_DOORBELL_BASE_IDX                                                                0
+#define regVPEC_QUEUE7_DOORBELL_OFFSET                                                                  0x0338
+#define regVPEC_QUEUE7_DOORBELL_OFFSET_BASE_IDX                                                         0
+#define regVPEC_QUEUE7_DUMMY0                                                                           0x0339
+#define regVPEC_QUEUE7_DUMMY0_BASE_IDX                                                                  0
+#define regVPEC_QUEUE7_DUMMY1                                                                           0x033a
+#define regVPEC_QUEUE7_DUMMY1_BASE_IDX                                                                  0
+#define regVPEC_QUEUE7_DUMMY2                                                                           0x033b
+#define regVPEC_QUEUE7_DUMMY2_BASE_IDX                                                                  0
+#define regVPEC_QUEUE7_DUMMY3                                                                           0x033c
+#define regVPEC_QUEUE7_DUMMY3_BASE_IDX                                                                  0
+#define regVPEC_QUEUE7_DUMMY4                                                                           0x033d
+#define regVPEC_QUEUE7_DUMMY4_BASE_IDX                                                                  0
+#define regVPEC_QUEUE7_IB_CNTL                                                                          0x0354
+#define regVPEC_QUEUE7_IB_CNTL_BASE_IDX                                                                 0
+#define regVPEC_QUEUE7_IB_RPTR                                                                          0x0355
+#define regVPEC_QUEUE7_IB_RPTR_BASE_IDX                                                                 0
+#define regVPEC_QUEUE7_IB_OFFSET                                                                        0x0356
+#define regVPEC_QUEUE7_IB_OFFSET_BASE_IDX                                                               0
+#define regVPEC_QUEUE7_IB_BASE_LO                                                                       0x0357
+#define regVPEC_QUEUE7_IB_BASE_LO_BASE_IDX                                                              0
+#define regVPEC_QUEUE7_IB_BASE_HI                                                                       0x0358
+#define regVPEC_QUEUE7_IB_BASE_HI_BASE_IDX                                                              0
+#define regVPEC_QUEUE7_IB_SIZE                                                                          0x0359
+#define regVPEC_QUEUE7_IB_SIZE_BASE_IDX                                                                 0
+#define regVPEC_QUEUE7_CMDIB_CNTL                                                                       0x035a
+#define regVPEC_QUEUE7_CMDIB_CNTL_BASE_IDX                                                              0
+#define regVPEC_QUEUE7_CMDIB_RPTR                                                                       0x035b
+#define regVPEC_QUEUE7_CMDIB_RPTR_BASE_IDX                                                              0
+#define regVPEC_QUEUE7_CMDIB_OFFSET                                                                     0x035c
+#define regVPEC_QUEUE7_CMDIB_OFFSET_BASE_IDX                                                            0
+#define regVPEC_QUEUE7_CMDIB_BASE_LO                                                                    0x035d
+#define regVPEC_QUEUE7_CMDIB_BASE_LO_BASE_IDX                                                           0
+#define regVPEC_QUEUE7_CMDIB_BASE_HI                                                                    0x035e
+#define regVPEC_QUEUE7_CMDIB_BASE_HI_BASE_IDX                                                           0
+#define regVPEC_QUEUE7_CMDIB_SIZE                                                                       0x035f
+#define regVPEC_QUEUE7_CMDIB_SIZE_BASE_IDX                                                              0
+#define regVPEC_QUEUE7_3DLUTIB_CNTL                                                                     0x0360
+#define regVPEC_QUEUE7_3DLUTIB_CNTL_BASE_IDX                                                            0
+#define regVPEC_QUEUE7_3DLUTIB_RPTR                                                                     0x0361
+#define regVPEC_QUEUE7_3DLUTIB_RPTR_BASE_IDX                                                            0
+#define regVPEC_QUEUE7_3DLUTIB_OFFSET                                                                   0x0362
+#define regVPEC_QUEUE7_3DLUTIB_OFFSET_BASE_IDX                                                          0
+#define regVPEC_QUEUE7_3DLUTIB_BASE_LO                                                                  0x0363
+#define regVPEC_QUEUE7_3DLUTIB_BASE_LO_BASE_IDX                                                         0
+#define regVPEC_QUEUE7_3DLUTIB_BASE_HI                                                                  0x0364
+#define regVPEC_QUEUE7_3DLUTIB_BASE_HI_BASE_IDX                                                         0
+#define regVPEC_QUEUE7_3DLUTIB_SIZE                                                                     0x0365
+#define regVPEC_QUEUE7_3DLUTIB_SIZE_BASE_IDX                                                            0
+#define regVPEC_QUEUE7_CSA_ADDR_LO                                                                      0x0366
+#define regVPEC_QUEUE7_CSA_ADDR_LO_BASE_IDX                                                             0
+#define regVPEC_QUEUE7_CSA_ADDR_HI                                                                      0x0367
+#define regVPEC_QUEUE7_CSA_ADDR_HI_BASE_IDX                                                             0
+#define regVPEC_QUEUE7_CONTEXT_STATUS                                                                   0x0368
+#define regVPEC_QUEUE7_CONTEXT_STATUS_BASE_IDX                                                          0
+#define regVPEC_QUEUE7_DOORBELL_LOG                                                                     0x0369
+#define regVPEC_QUEUE7_DOORBELL_LOG_BASE_IDX                                                            0
+#define regVPEC_QUEUE7_IB_SUB_REMAIN                                                                    0x036a
+#define regVPEC_QUEUE7_IB_SUB_REMAIN_BASE_IDX                                                           0
+#define regVPEC_QUEUE7_PREEMPT                                                                          0x036b
+#define regVPEC_QUEUE7_PREEMPT_BASE_IDX                                                                 0
+#define regVPEC_QUEUE7_LOG0BUFFER_CFG                                                                   0x036c
+#define regVPEC_QUEUE7_LOG0BUFFER_CFG_BASE_IDX                                                          0
+#define regVPEC_QUEUE7_LOG1BUFFER_CFG                                                                   0x036d
+#define regVPEC_QUEUE7_LOG1BUFFER_CFG_BASE_IDX                                                          0
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_sh_mask.h
new file mode 100644
index 000000000000..7e0e56d14e67
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/vpe/vpe_2_0_0_sh_mask.h
@@ -0,0 +1,3162 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+ */
+
+#ifndef _vpe_2_0_0_SH_MASK_HEADER
+#define _vpe_2_0_0_SH_MASK_HEADER
+
+
+// addressBlock: vpe_vpec_vpecdec
+//VPEC_DEC_START
+#define VPEC_DEC_START__START__SHIFT                                                                          0x0
+#define VPEC_DEC_START__START_MASK                                                                            0xFFFFFFFFL
+//VPEC_UCODE_ADDR
+#define VPEC_UCODE_ADDR__VALUE__SHIFT                                                                         0x0
+#define VPEC_UCODE_ADDR__THID__SHIFT                                                                          0xf
+#define VPEC_UCODE_ADDR__VALUE_MASK                                                                           0x00001FFFL
+#define VPEC_UCODE_ADDR__THID_MASK                                                                            0x00008000L
+//VPEC_UCODE_DATA
+#define VPEC_UCODE_DATA__VALUE__SHIFT                                                                         0x0
+#define VPEC_UCODE_DATA__VALUE_MASK                                                                           0xFFFFFFFFL
+//VPEC_F32_CNTL
+#define VPEC_F32_CNTL__HALT__SHIFT                                                                            0x0
+#define VPEC_F32_CNTL__DBG_SELECT_BITS__SHIFT                                                                 0x2
+#define VPEC_F32_CNTL__TH0_CHECKSUM_CLR__SHIFT                                                                0x8
+#define VPEC_F32_CNTL__TH0_RESET__SHIFT                                                                       0x9
+#define VPEC_F32_CNTL__TH0_ENABLE__SHIFT                                                                      0xa
+#define VPEC_F32_CNTL__TH1_CHECKSUM_CLR__SHIFT                                                                0xc
+#define VPEC_F32_CNTL__TH1_RESET__SHIFT                                                                       0xd
+#define VPEC_F32_CNTL__TH1_ENABLE__SHIFT                                                                      0xe
+#define VPEC_F32_CNTL__TH0_PRIORITY__SHIFT                                                                    0x10
+#define VPEC_F32_CNTL__TH1_PRIORITY__SHIFT                                                                    0x18
+#define VPEC_F32_CNTL__HALT_MASK                                                                              0x00000001L
+#define VPEC_F32_CNTL__DBG_SELECT_BITS_MASK                                                                   0x000000FCL
+#define VPEC_F32_CNTL__TH0_CHECKSUM_CLR_MASK                                                                  0x00000100L
+#define VPEC_F32_CNTL__TH0_RESET_MASK                                                                         0x00000200L
+#define VPEC_F32_CNTL__TH0_ENABLE_MASK                                                                        0x00000400L
+#define VPEC_F32_CNTL__TH1_CHECKSUM_CLR_MASK                                                                  0x00001000L
+#define VPEC_F32_CNTL__TH1_RESET_MASK                                                                         0x00002000L
+#define VPEC_F32_CNTL__TH1_ENABLE_MASK                                                                        0x00004000L
+#define VPEC_F32_CNTL__TH0_PRIORITY_MASK                                                                      0x00FF0000L
+#define VPEC_F32_CNTL__TH1_PRIORITY_MASK                                                                      0xFF000000L
+//VPEC_MMHUB_CNTL
+#define VPEC_MMHUB_CNTL__UNIT_ID__SHIFT                                                                       0x0
+#define VPEC_MMHUB_CNTL__UNIT_ID_MASK                                                                         0x0000003FL
+//VPEC_MMHUB_TRUSTLVL
+#define VPEC_MMHUB_TRUSTLVL__SECLVL0__SHIFT                                                                   0x0
+#define VPEC_MMHUB_TRUSTLVL__SECLVL1__SHIFT                                                                   0x4
+#define VPEC_MMHUB_TRUSTLVL__SECLVL2__SHIFT                                                                   0x8
+#define VPEC_MMHUB_TRUSTLVL__SECLVL3__SHIFT                                                                   0xc
+#define VPEC_MMHUB_TRUSTLVL__SECLVL4__SHIFT                                                                   0x10
+#define VPEC_MMHUB_TRUSTLVL__SECLVL5__SHIFT                                                                   0x14
+#define VPEC_MMHUB_TRUSTLVL__SECLVL6__SHIFT                                                                   0x18
+#define VPEC_MMHUB_TRUSTLVL__SECLVL7__SHIFT                                                                   0x1c
+#define VPEC_MMHUB_TRUSTLVL__SECLVL0_MASK                                                                     0x0000000FL
+#define VPEC_MMHUB_TRUSTLVL__SECLVL1_MASK                                                                     0x000000F0L
+#define VPEC_MMHUB_TRUSTLVL__SECLVL2_MASK                                                                     0x00000F00L
+#define VPEC_MMHUB_TRUSTLVL__SECLVL3_MASK                                                                     0x0000F000L
+#define VPEC_MMHUB_TRUSTLVL__SECLVL4_MASK                                                                     0x000F0000L
+#define VPEC_MMHUB_TRUSTLVL__SECLVL5_MASK                                                                     0x00F00000L
+#define VPEC_MMHUB_TRUSTLVL__SECLVL6_MASK                                                                     0x0F000000L
+#define VPEC_MMHUB_TRUSTLVL__SECLVL7_MASK                                                                     0xF0000000L
+//VPEC_VPEP_CTRL
+#define VPEC_VPEP_CTRL__VPEP_SOCCLK_EN__SHIFT                                                                 0x0
+#define VPEC_VPEP_CTRL__VPEP_SW_RESETB__SHIFT                                                                 0x1
+#define VPEC_VPEP_CTRL__RESERVED__SHIFT                                                                       0x2
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S0P0__SHIFT                                                     0x16
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S0P1__SHIFT                                                     0x17
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S0P2__SHIFT                                                     0x18
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S1P0__SHIFT                                                     0x19
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S1P1__SHIFT                                                     0x1a
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S1P2__SHIFT                                                     0x1b
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_3DLUT__SHIFT                                                    0x1c
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_VPEC_VPEP_REG_FGCLKEN__SHIFT                                            0x1d
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_VPEP_SOCCLK__SHIFT                                                      0x1e
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_VPECLK__SHIFT                                                           0x1f
+#define VPEC_VPEP_CTRL__VPEP_SOCCLK_EN_MASK                                                                   0x00000001L
+#define VPEC_VPEP_CTRL__VPEP_SW_RESETB_MASK                                                                   0x00000002L
+#define VPEC_VPEP_CTRL__RESERVED_MASK                                                                         0x003FFFFCL
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S0P0_MASK                                                       0x00400000L
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S0P1_MASK                                                       0x00800000L
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S0P2_MASK                                                       0x01000000L
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S1P0_MASK                                                       0x02000000L
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S1P1_MASK                                                       0x04000000L
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_S1P2_MASK                                                       0x08000000L
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_FGCLKEN_3DLUT_MASK                                                      0x10000000L
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_VPEC_VPEP_REG_FGCLKEN_MASK                                              0x20000000L
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_VPEP_SOCCLK_MASK                                                        0x40000000L
+#define VPEC_VPEP_CTRL__SOFT_OVERRIDE_VPECLK_MASK                                                             0x80000000L
+//VPEC_CLK_CTRL
+#define VPEC_CLK_CTRL__VPECLK_EN__SHIFT                                                                       0x1
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE0_CLK__SHIFT                                                      0x8
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE1_CLK__SHIFT                                                      0x9
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE2_CLK__SHIFT                                                      0xa
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE3_CLK__SHIFT                                                      0xb
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE4_CLK__SHIFT                                                      0xc
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE5_CLK__SHIFT                                                      0xd
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE0_CLK__SHIFT                                                      0x10
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE1_CLK__SHIFT                                                      0x11
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE2_CLK__SHIFT                                                      0x12
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE3_CLK__SHIFT                                                      0x13
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE4_CLK__SHIFT                                                      0x14
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE5_CLK__SHIFT                                                      0x15
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE6_CLK__SHIFT                                                      0x16
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE7_CLK__SHIFT                                                      0x17
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE8_CLK__SHIFT                                                      0x18
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE9_CLK__SHIFT                                                      0x19
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_PERF_CLK__SHIFT                                                          0x1b
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_CE_CLK__SHIFT                                                            0x1c
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_F32_CLK__SHIFT                                                           0x1d
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_DYN_CLK__SHIFT                                                           0x1e
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_REG_CLK__SHIFT                                                           0x1f
+#define VPEC_CLK_CTRL__VPECLK_EN_MASK                                                                         0x00000002L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE0_CLK_MASK                                                        0x00000100L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE1_CLK_MASK                                                        0x00000200L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE2_CLK_MASK                                                        0x00000400L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE3_CLK_MASK                                                        0x00000800L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE4_CLK_MASK                                                        0x00001000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_IP_PIPE5_CLK_MASK                                                        0x00002000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE0_CLK_MASK                                                        0x00010000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE1_CLK_MASK                                                        0x00020000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE2_CLK_MASK                                                        0x00040000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE3_CLK_MASK                                                        0x00080000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE4_CLK_MASK                                                        0x00100000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE5_CLK_MASK                                                        0x00200000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE6_CLK_MASK                                                        0x00400000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE7_CLK_MASK                                                        0x00800000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE8_CLK_MASK                                                        0x01000000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_OP_PIPE9_CLK_MASK                                                        0x02000000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_PERF_CLK_MASK                                                            0x08000000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_CE_CLK_MASK                                                              0x10000000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_F32_CLK_MASK                                                             0x20000000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_DYN_CLK_MASK                                                             0x40000000L
+#define VPEC_CLK_CTRL__SOFT_OVERRIDE_REG_CLK_MASK                                                             0x80000000L
+//VPEC_COLLABORATE_CNTL
+#define VPEC_COLLABORATE_CNTL__COLLABORATE_MODE_EN__SHIFT                                                     0x0
+#define VPEC_COLLABORATE_CNTL__COLLABORATE_MODE_EN_MASK                                                       0x00000001L
+//VPEC_COLLABORATE_CFG
+#define VPEC_COLLABORATE_CFG__MASTER_ID__SHIFT                                                                0x0
+#define VPEC_COLLABORATE_CFG__MASTER_EN__SHIFT                                                                0x3
+#define VPEC_COLLABORATE_CFG__SLAVE0_ID__SHIFT                                                                0x4
+#define VPEC_COLLABORATE_CFG__SLAVE0_EN__SHIFT                                                                0x7
+#define VPEC_COLLABORATE_CFG__MASTER_ID_MASK                                                                  0x00000007L
+#define VPEC_COLLABORATE_CFG__MASTER_EN_MASK                                                                  0x00000008L
+#define VPEC_COLLABORATE_CFG__SLAVE0_ID_MASK                                                                  0x00000070L
+#define VPEC_COLLABORATE_CFG__SLAVE0_EN_MASK                                                                  0x00000080L
+//VPEC_POWER_CNTL
+#define VPEC_POWER_CNTL__LS_ENABLE__SHIFT                                                                     0x0
+#define VPEC_POWER_CNTL__UCODE_SRAM_DS_EN__SHIFT                                                              0x1
+#define VPEC_POWER_CNTL__FISO__SHIFT                                                                          0x2
+#define VPEC_POWER_CNTL__UCODE_SRAM_POWER_UP_RECOVER_DELAY__SHIFT                                             0x8
+#define VPEC_POWER_CNTL__UCODE_SRAM_POWER_STATUS_CHANGE_WAKEUP_TIME__SHIFT                                    0xf
+#define VPEC_POWER_CNTL__UCODE_SRAM_POWER_STATUS_CHANGE_CLK_FORCE__SHIFT                                      0x12
+#define VPEC_POWER_CNTL__SRAM_POWER_LS_CHANGE_DELAY__SHIFT                                                    0x14
+#define VPEC_POWER_CNTL__SRAM_POWER_LS_CHANGE_CLK_FORCE__SHIFT                                                0x17
+#define VPEC_POWER_CNTL__SRAM_POWER_LS_CHANGE_CLK_FORCE_DELAY__SHIFT                                          0x18
+#define VPEC_POWER_CNTL__LS_ENABLE_MASK                                                                       0x00000001L
+#define VPEC_POWER_CNTL__UCODE_SRAM_DS_EN_MASK                                                                0x00000002L
+#define VPEC_POWER_CNTL__FISO_MASK                                                                            0x00000004L
+#define VPEC_POWER_CNTL__UCODE_SRAM_POWER_UP_RECOVER_DELAY_MASK                                               0x00007F00L
+#define VPEC_POWER_CNTL__UCODE_SRAM_POWER_STATUS_CHANGE_WAKEUP_TIME_MASK                                      0x00038000L
+#define VPEC_POWER_CNTL__UCODE_SRAM_POWER_STATUS_CHANGE_CLK_FORCE_MASK                                        0x00040000L
+#define VPEC_POWER_CNTL__SRAM_POWER_LS_CHANGE_DELAY_MASK                                                      0x00700000L
+#define VPEC_POWER_CNTL__SRAM_POWER_LS_CHANGE_CLK_FORCE_MASK                                                  0x00800000L
+#define VPEC_POWER_CNTL__SRAM_POWER_LS_CHANGE_CLK_FORCE_DELAY_MASK                                            0x03000000L
+//VPEC_ZPR_CNTL
+#define VPEC_ZPR_CNTL__CLK_UNGATE_DELAY__SHIFT                                                                0x0
+#define VPEC_ZPR_CNTL__RESERVED__SHIFT                                                                        0x8
+#define VPEC_ZPR_CNTL__CLK_UNGATE_DELAY_MASK                                                                  0x000000FFL
+#define VPEC_ZPR_CNTL__RESERVED_MASK                                                                          0xFFFFFF00L
+//VPEC_CNTL
+#define VPEC_CNTL__TRAP_ENABLE__SHIFT                                                                         0x0
+#define VPEC_CNTL__RESERVED_2_2__SHIFT                                                                        0x2
+#define VPEC_CNTL__DATA_SWAP__SHIFT                                                                           0x3
+#define VPEC_CNTL__FENCE_SWAP_ENABLE__SHIFT                                                                   0x5
+#define VPEC_CNTL__MIDCMD_PREEMPT_ENABLE__SHIFT                                                               0x6
+#define VPEC_CNTL__MIDCMD_EXPIRE_ENABLE__SHIFT                                                                0x9
+#define VPEC_CNTL__UMSCH_INT_ENABLE__SHIFT                                                                    0xa
+#define VPEC_CNTL__RESERVED_13_11__SHIFT                                                                      0xb
+#define VPEC_CNTL__NACK_GEN_ERR_INT_ENABLE__SHIFT                                                             0xe
+#define VPEC_CNTL__NACK_PRT_INT_ENABLE__SHIFT                                                                 0xf
+#define VPEC_CNTL__RESERVED_16_16__SHIFT                                                                      0x10
+#define VPEC_CNTL__MIDCMD_WORLDSWITCH_ENABLE__SHIFT                                                           0x11
+#define VPEC_CNTL__RESERVED_19_19__SHIFT                                                                      0x13
+#define VPEC_CNTL__CTXEMPTY_INT_ENABLE__SHIFT                                                                 0x1c
+#define VPEC_CNTL__FROZEN_INT_ENABLE__SHIFT                                                                   0x1d
+#define VPEC_CNTL__IB_PREEMPT_INT_ENABLE__SHIFT                                                               0x1e
+#define VPEC_CNTL__RB_PREEMPT_INT_ENABLE__SHIFT                                                               0x1f
+#define VPEC_CNTL__TRAP_ENABLE_MASK                                                                           0x00000001L
+#define VPEC_CNTL__RESERVED_2_2_MASK                                                                          0x00000004L
+#define VPEC_CNTL__DATA_SWAP_MASK                                                                             0x00000018L
+#define VPEC_CNTL__FENCE_SWAP_ENABLE_MASK                                                                     0x00000020L
+#define VPEC_CNTL__MIDCMD_PREEMPT_ENABLE_MASK                                                                 0x00000040L
+#define VPEC_CNTL__MIDCMD_EXPIRE_ENABLE_MASK                                                                  0x00000200L
+#define VPEC_CNTL__UMSCH_INT_ENABLE_MASK                                                                      0x00000400L
+#define VPEC_CNTL__RESERVED_13_11_MASK                                                                        0x00003800L
+#define VPEC_CNTL__NACK_GEN_ERR_INT_ENABLE_MASK                                                               0x00004000L
+#define VPEC_CNTL__NACK_PRT_INT_ENABLE_MASK                                                                   0x00008000L
+#define VPEC_CNTL__RESERVED_16_16_MASK                                                                        0x00010000L
+#define VPEC_CNTL__MIDCMD_WORLDSWITCH_ENABLE_MASK                                                             0x00020000L
+#define VPEC_CNTL__RESERVED_19_19_MASK                                                                        0x00080000L
+#define VPEC_CNTL__CTXEMPTY_INT_ENABLE_MASK                                                                   0x10000000L
+#define VPEC_CNTL__FROZEN_INT_ENABLE_MASK                                                                     0x20000000L
+#define VPEC_CNTL__IB_PREEMPT_INT_ENABLE_MASK                                                                 0x40000000L
+#define VPEC_CNTL__RB_PREEMPT_INT_ENABLE_MASK                                                                 0x80000000L
+//VPEC_CNTL_DCC
+#define VPEC_CNTL_DCC__WDCC_COMP_MODE__SHIFT                                                                  0x0
+#define VPEC_CNTL_DCC__RESERVED_3_2__SHIFT                                                                    0x2
+#define VPEC_CNTL_DCC__WDCC_MICRO_TILE_MODE__SHIFT                                                            0x4
+#define VPEC_CNTL_DCC__RESERVED_7_6__SHIFT                                                                    0x6
+#define VPEC_CNTL_DCC__WDCC_DATA_FORMAT__SHIFT                                                                0x8
+#define VPEC_CNTL_DCC__RESERVED_15_13__SHIFT                                                                  0xd
+#define VPEC_CNTL_DCC__WDCC_NUM_FORMAT_EN__SHIFT                                                              0x10
+#define VPEC_CNTL_DCC__RESERVED_19_17__SHIFT                                                                  0x11
+#define VPEC_CNTL_DCC__WDCC_NUM_TYPE__SHIFT                                                                   0x14
+#define VPEC_CNTL_DCC__RESERVED_23_23__SHIFT                                                                  0x17
+#define VPEC_CNTL_DCC__WDCC_MAX_UNCOMP_SIZE__SHIFT                                                            0x18
+#define VPEC_CNTL_DCC__WDCC_MAX_COMP_SIZE__SHIFT                                                              0x19
+#define VPEC_CNTL_DCC__RESERVED_30_27__SHIFT                                                                  0x1b
+#define VPEC_CNTL_DCC__RDCC_COMP_MODE__SHIFT                                                                  0x1f
+#define VPEC_CNTL_DCC__WDCC_COMP_MODE_MASK                                                                    0x00000003L
+#define VPEC_CNTL_DCC__RESERVED_3_2_MASK                                                                      0x0000000CL
+#define VPEC_CNTL_DCC__WDCC_MICRO_TILE_MODE_MASK                                                              0x00000030L
+#define VPEC_CNTL_DCC__RESERVED_7_6_MASK                                                                      0x000000C0L
+#define VPEC_CNTL_DCC__WDCC_DATA_FORMAT_MASK                                                                  0x00001F00L
+#define VPEC_CNTL_DCC__RESERVED_15_13_MASK                                                                    0x0000E000L
+#define VPEC_CNTL_DCC__WDCC_NUM_FORMAT_EN_MASK                                                                0x00010000L
+#define VPEC_CNTL_DCC__RESERVED_19_17_MASK                                                                    0x000E0000L
+#define VPEC_CNTL_DCC__WDCC_NUM_TYPE_MASK                                                                     0x00700000L
+#define VPEC_CNTL_DCC__RESERVED_23_23_MASK                                                                    0x00800000L
+#define VPEC_CNTL_DCC__WDCC_MAX_UNCOMP_SIZE_MASK                                                              0x01000000L
+#define VPEC_CNTL_DCC__WDCC_MAX_COMP_SIZE_MASK                                                                0x06000000L
+#define VPEC_CNTL_DCC__RESERVED_30_27_MASK                                                                    0x78000000L
+#define VPEC_CNTL_DCC__RDCC_COMP_MODE_MASK                                                                    0x80000000L
+//VPEC_CE_OP_MULTI_64B_BURST
+#define VPEC_CE_OP_MULTI_64B_BURST__EN__SHIFT                                                                 0x0
+#define VPEC_CE_OP_MULTI_64B_BURST__RESERVED_3_1__SHIFT                                                       0x1
+#define VPEC_CE_OP_MULTI_64B_BURST__LAZY_TIMER_DLY__SHIFT                                                     0x4
+#define VPEC_CE_OP_MULTI_64B_BURST__NUM_64B_BURST_ALLOWED__SHIFT                                              0xa
+#define VPEC_CE_OP_MULTI_64B_BURST__RESERVED_31_12__SHIFT                                                     0xc
+#define VPEC_CE_OP_MULTI_64B_BURST__EN_MASK                                                                   0x00000001L
+#define VPEC_CE_OP_MULTI_64B_BURST__RESERVED_3_1_MASK                                                         0x0000000EL
+#define VPEC_CE_OP_MULTI_64B_BURST__LAZY_TIMER_DLY_MASK                                                       0x000003F0L
+#define VPEC_CE_OP_MULTI_64B_BURST__NUM_64B_BURST_ALLOWED_MASK                                                0x00000C00L
+#define VPEC_CE_OP_MULTI_64B_BURST__RESERVED_31_12_MASK                                                       0xFFFFF000L
+//VPEC_CNTL1
+#define VPEC_CNTL1__RESERVED_3_1__SHIFT                                                                       0x1
+#define VPEC_CNTL1__SRBM_POLL_RETRYING__SHIFT                                                                 0x5
+#define VPEC_CNTL1__RESERVED_23_10__SHIFT                                                                     0xa
+#define VPEC_CNTL1__CG_STATUS_OUTPUT__SHIFT                                                                   0x18
+#define VPEC_CNTL1__SW_FREEZE_ENABLE__SHIFT                                                                   0x19
+#define VPEC_CNTL1__VPEP_CONFIG_INVALID_CHECK_ENABLE__SHIFT                                                   0x1a
+#define VPEC_CNTL1__RSMU_ACCESS_OFF_VPEP_RETURN_ERROR_ENABLE__SHIFT                                           0x1b
+#define VPEC_CNTL1__RSMU_ACCESS_OFF_VPEP_REPORT_ERROR_ENABLE__SHIFT                                           0x1c
+#define VPEC_CNTL1__RESERVED__SHIFT                                                                           0x1d
+#define VPEC_CNTL1__RESERVED_3_1_MASK                                                                         0x0000000EL
+#define VPEC_CNTL1__SRBM_POLL_RETRYING_MASK                                                                   0x00000020L
+#define VPEC_CNTL1__RESERVED_23_10_MASK                                                                       0x00FFFC00L
+#define VPEC_CNTL1__CG_STATUS_OUTPUT_MASK                                                                     0x01000000L
+#define VPEC_CNTL1__SW_FREEZE_ENABLE_MASK                                                                     0x02000000L
+#define VPEC_CNTL1__VPEP_CONFIG_INVALID_CHECK_ENABLE_MASK                                                     0x04000000L
+#define VPEC_CNTL1__RSMU_ACCESS_OFF_VPEP_RETURN_ERROR_ENABLE_MASK                                             0x08000000L
+#define VPEC_CNTL1__RSMU_ACCESS_OFF_VPEP_REPORT_ERROR_ENABLE_MASK                                             0x10000000L
+#define VPEC_CNTL1__RESERVED_MASK                                                                             0xE0000000L
+//VPEC_CNTL2
+#define VPEC_CNTL2__F32_CMD_PROC_DELAY__SHIFT                                                                 0x0
+#define VPEC_CNTL2__F32_SEND_POSTCODE_EN__SHIFT                                                               0x4
+#define VPEC_CNTL2__UCODE_BUF_DS_EN__SHIFT                                                                    0x6
+#define VPEC_CNTL2__UCODE_SELFLOAD_THREAD_OVERLAP__SHIFT                                                      0x7
+#define VPEC_CNTL2__LUTIB_FIFO_WATERMARK__SHIFT                                                               0x8
+#define VPEC_CNTL2__CMDIB_FIFO_WATERMARK__SHIFT                                                               0xa
+#define VPEC_CNTL2__RESERVED_14_12__SHIFT                                                                     0xc
+#define VPEC_CNTL2__IMPROVE_CE_IP_ARBITER__SHIFT                                                              0xf
+#define VPEC_CNTL2__RB_FIFO_WATERMARK__SHIFT                                                                  0x10
+#define VPEC_CNTL2__IB_FIFO_WATERMARK__SHIFT                                                                  0x12
+#define VPEC_CNTL2__RESERVED_22_20__SHIFT                                                                     0x14
+#define VPEC_CNTL2__CH_RD_WATERMARK__SHIFT                                                                    0x17
+#define VPEC_CNTL2__CH_WR_WATERMARK__SHIFT                                                                    0x19
+#define VPEC_CNTL2__CH_WR_WATERMARK_LSB__SHIFT                                                                0x1e
+#define VPEC_CNTL2__F32_CMD_PROC_DELAY_MASK                                                                   0x0000000FL
+#define VPEC_CNTL2__F32_SEND_POSTCODE_EN_MASK                                                                 0x00000010L
+#define VPEC_CNTL2__UCODE_BUF_DS_EN_MASK                                                                      0x00000040L
+#define VPEC_CNTL2__UCODE_SELFLOAD_THREAD_OVERLAP_MASK                                                        0x00000080L
+#define VPEC_CNTL2__LUTIB_FIFO_WATERMARK_MASK                                                                 0x00000300L
+#define VPEC_CNTL2__CMDIB_FIFO_WATERMARK_MASK                                                                 0x00000C00L
+#define VPEC_CNTL2__RESERVED_14_12_MASK                                                                       0x00007000L
+#define VPEC_CNTL2__IMPROVE_CE_IP_ARBITER_MASK                                                                0x00008000L
+#define VPEC_CNTL2__RB_FIFO_WATERMARK_MASK                                                                    0x00030000L
+#define VPEC_CNTL2__IB_FIFO_WATERMARK_MASK                                                                    0x000C0000L
+#define VPEC_CNTL2__RESERVED_22_20_MASK                                                                       0x00700000L
+#define VPEC_CNTL2__CH_RD_WATERMARK_MASK                                                                      0x01800000L
+#define VPEC_CNTL2__CH_WR_WATERMARK_MASK                                                                      0x3E000000L
+#define VPEC_CNTL2__CH_WR_WATERMARK_LSB_MASK                                                                  0x40000000L
+//VPEC_GB_ADDR_CONFIG
+#define VPEC_GB_ADDR_CONFIG__NUM_PIPES__SHIFT                                                                 0x0
+#define VPEC_GB_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE__SHIFT                                                      0x3
+#define VPEC_GB_ADDR_CONFIG__MAX_COMPRESSED_FRAGS__SHIFT                                                      0x6
+#define VPEC_GB_ADDR_CONFIG__NUM_PKRS__SHIFT                                                                  0x8
+#define VPEC_GB_ADDR_CONFIG__NUM_SHADER_ENGINES__SHIFT                                                        0x13
+#define VPEC_GB_ADDR_CONFIG__NUM_RB_PER_SE__SHIFT                                                             0x1a
+#define VPEC_GB_ADDR_CONFIG__NUM_PIPES_MASK                                                                   0x00000007L
+#define VPEC_GB_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE_MASK                                                        0x00000038L
+#define VPEC_GB_ADDR_CONFIG__MAX_COMPRESSED_FRAGS_MASK                                                        0x000000C0L
+#define VPEC_GB_ADDR_CONFIG__NUM_PKRS_MASK                                                                    0x00000700L
+#define VPEC_GB_ADDR_CONFIG__NUM_SHADER_ENGINES_MASK                                                          0x00180000L
+#define VPEC_GB_ADDR_CONFIG__NUM_RB_PER_SE_MASK                                                               0x0C000000L
+//VPEC_GB_ADDR_CONFIG_READ
+#define VPEC_GB_ADDR_CONFIG_READ__NUM_PIPES__SHIFT                                                            0x0
+#define VPEC_GB_ADDR_CONFIG_READ__PIPE_INTERLEAVE_SIZE__SHIFT                                                 0x3
+#define VPEC_GB_ADDR_CONFIG_READ__MAX_COMPRESSED_FRAGS__SHIFT                                                 0x6
+#define VPEC_GB_ADDR_CONFIG_READ__NUM_PKRS__SHIFT                                                             0x8
+#define VPEC_GB_ADDR_CONFIG_READ__NUM_SHADER_ENGINES__SHIFT                                                   0x13
+#define VPEC_GB_ADDR_CONFIG_READ__NUM_RB_PER_SE__SHIFT                                                        0x1a
+#define VPEC_GB_ADDR_CONFIG_READ__NUM_PIPES_MASK                                                              0x00000007L
+#define VPEC_GB_ADDR_CONFIG_READ__PIPE_INTERLEAVE_SIZE_MASK                                                   0x00000038L
+#define VPEC_GB_ADDR_CONFIG_READ__MAX_COMPRESSED_FRAGS_MASK                                                   0x000000C0L
+#define VPEC_GB_ADDR_CONFIG_READ__NUM_PKRS_MASK                                                               0x00000700L
+#define VPEC_GB_ADDR_CONFIG_READ__NUM_SHADER_ENGINES_MASK                                                     0x00180000L
+#define VPEC_GB_ADDR_CONFIG_READ__NUM_RB_PER_SE_MASK                                                          0x0C000000L
+//VPEC_GB_ADDR_CONFIG_META
+#define VPEC_GB_ADDR_CONFIG_META__NUM_PIPES__SHIFT                                                            0x0
+#define VPEC_GB_ADDR_CONFIG_META__PIPE_INTERLEAVE_SIZE__SHIFT                                                 0x3
+#define VPEC_GB_ADDR_CONFIG_META__MAX_COMPRESSED_FRAGS__SHIFT                                                 0x6
+#define VPEC_GB_ADDR_CONFIG_META__NUM_PKRS__SHIFT                                                             0x8
+#define VPEC_GB_ADDR_CONFIG_META__NUM_SHADER_ENGINES__SHIFT                                                   0x13
+#define VPEC_GB_ADDR_CONFIG_META__NUM_RB_PER_SE__SHIFT                                                        0x1a
+#define VPEC_GB_ADDR_CONFIG_META__NUM_PIPES_MASK                                                              0x00000007L
+#define VPEC_GB_ADDR_CONFIG_META__PIPE_INTERLEAVE_SIZE_MASK                                                   0x00000038L
+#define VPEC_GB_ADDR_CONFIG_META__MAX_COMPRESSED_FRAGS_MASK                                                   0x000000C0L
+#define VPEC_GB_ADDR_CONFIG_META__NUM_PKRS_MASK                                                               0x00000700L
+#define VPEC_GB_ADDR_CONFIG_META__NUM_SHADER_ENGINES_MASK                                                     0x00180000L
+#define VPEC_GB_ADDR_CONFIG_META__NUM_RB_PER_SE_MASK                                                          0x0C000000L
+//VPEC_PROCESS_QUANTUM0
+#define VPEC_PROCESS_QUANTUM0__PROCESS0_QUANTUM__SHIFT                                                        0x0
+#define VPEC_PROCESS_QUANTUM0__PROCESS1_QUANTUM__SHIFT                                                        0x8
+#define VPEC_PROCESS_QUANTUM0__PROCESS2_QUANTUM__SHIFT                                                        0x10
+#define VPEC_PROCESS_QUANTUM0__PROCESS3_QUANTUM__SHIFT                                                        0x18
+#define VPEC_PROCESS_QUANTUM0__PROCESS0_QUANTUM_MASK                                                          0x000000FFL
+#define VPEC_PROCESS_QUANTUM0__PROCESS1_QUANTUM_MASK                                                          0x0000FF00L
+#define VPEC_PROCESS_QUANTUM0__PROCESS2_QUANTUM_MASK                                                          0x00FF0000L
+#define VPEC_PROCESS_QUANTUM0__PROCESS3_QUANTUM_MASK                                                          0xFF000000L
+//VPEC_PROCESS_QUANTUM1
+#define VPEC_PROCESS_QUANTUM1__PROCESS4_QUANTUM__SHIFT                                                        0x0
+#define VPEC_PROCESS_QUANTUM1__PROCESS5_QUANTUM__SHIFT                                                        0x8
+#define VPEC_PROCESS_QUANTUM1__PROCESS6_QUANTUM__SHIFT                                                        0x10
+#define VPEC_PROCESS_QUANTUM1__PROCESS7_QUANTUM__SHIFT                                                        0x18
+#define VPEC_PROCESS_QUANTUM1__PROCESS4_QUANTUM_MASK                                                          0x000000FFL
+#define VPEC_PROCESS_QUANTUM1__PROCESS5_QUANTUM_MASK                                                          0x0000FF00L
+#define VPEC_PROCESS_QUANTUM1__PROCESS6_QUANTUM_MASK                                                          0x00FF0000L
+#define VPEC_PROCESS_QUANTUM1__PROCESS7_QUANTUM_MASK                                                          0xFF000000L
+//VPEC_CONTEXT_SWITCH_THRESHOLD
+#define VPEC_CONTEXT_SWITCH_THRESHOLD__REALTIME_THRESHOLD__SHIFT                                              0x0
+#define VPEC_CONTEXT_SWITCH_THRESHOLD__FOCUS_THRESHOLD__SHIFT                                                 0x2
+#define VPEC_CONTEXT_SWITCH_THRESHOLD__NORMAL_THRESHOLD__SHIFT                                                0x4
+#define VPEC_CONTEXT_SWITCH_THRESHOLD__IDLE_THRESHOLD__SHIFT                                                  0x6
+#define VPEC_CONTEXT_SWITCH_THRESHOLD__REALTIME_THRESHOLD_MASK                                                0x00000003L
+#define VPEC_CONTEXT_SWITCH_THRESHOLD__FOCUS_THRESHOLD_MASK                                                   0x0000000CL
+#define VPEC_CONTEXT_SWITCH_THRESHOLD__NORMAL_THRESHOLD_MASK                                                  0x00000030L
+#define VPEC_CONTEXT_SWITCH_THRESHOLD__IDLE_THRESHOLD_MASK                                                    0x000000C0L
+//VPEC_GLOBAL_QUANTUM
+#define VPEC_GLOBAL_QUANTUM__GLOBAL_FOCUS_QUANTUM__SHIFT                                                      0x0
+#define VPEC_GLOBAL_QUANTUM__GLOBAL_NORMAL_QUANTUM__SHIFT                                                     0x8
+#define VPEC_GLOBAL_QUANTUM__GLOBAL_FOCUS_QUANTUM_MASK                                                        0x000000FFL
+#define VPEC_GLOBAL_QUANTUM__GLOBAL_NORMAL_QUANTUM_MASK                                                       0x0000FF00L
+//VPEC_WATCHDOG_CNTL
+#define VPEC_WATCHDOG_CNTL__QUEUE_HANG_COUNT__SHIFT                                                           0x0
+#define VPEC_WATCHDOG_CNTL__CMD_TIMEOUT_COUNT__SHIFT                                                          0x8
+#define VPEC_WATCHDOG_CNTL__QUEUE_HANG_COUNT_MASK                                                             0x000000FFL
+#define VPEC_WATCHDOG_CNTL__CMD_TIMEOUT_COUNT_MASK                                                            0x0000FF00L
+//VPEC_ATOMIC_CNTL
+#define VPEC_ATOMIC_CNTL__LOOP_TIMER__SHIFT                                                                   0x0
+#define VPEC_ATOMIC_CNTL__ATOMIC_RTN_INT_ENABLE__SHIFT                                                        0x1f
+#define VPEC_ATOMIC_CNTL__LOOP_TIMER_MASK                                                                     0x7FFFFFFFL
+#define VPEC_ATOMIC_CNTL__ATOMIC_RTN_INT_ENABLE_MASK                                                          0x80000000L
+//VPEC_UCODE_VERSION
+#define VPEC_UCODE_VERSION__T0_UCODE_VERSION__SHIFT                                                           0x0
+#define VPEC_UCODE_VERSION__T1_UCODE_VERSION__SHIFT                                                           0x10
+#define VPEC_UCODE_VERSION__T0_UCODE_VERSION_MASK                                                             0x0000FFFFL
+#define VPEC_UCODE_VERSION__T1_UCODE_VERSION_MASK                                                             0xFFFF0000L
+//VPEC_MEMREQ_BURST_CNTL
+#define VPEC_MEMREQ_BURST_CNTL__DATA_RD_BURST__SHIFT                                                          0x0
+#define VPEC_MEMREQ_BURST_CNTL__DATA_WR_BURST__SHIFT                                                          0x2
+#define VPEC_MEMREQ_BURST_CNTL__RB_RD_BURST__SHIFT                                                            0x4
+#define VPEC_MEMREQ_BURST_CNTL__IB_RD_BURST__SHIFT                                                            0x6
+#define VPEC_MEMREQ_BURST_CNTL__WR_BURST_WAIT_CYCLE__SHIFT                                                    0x8
+#define VPEC_MEMREQ_BURST_CNTL__DATA_RD_BURST_MASK                                                            0x00000003L
+#define VPEC_MEMREQ_BURST_CNTL__DATA_WR_BURST_MASK                                                            0x0000000CL
+#define VPEC_MEMREQ_BURST_CNTL__RB_RD_BURST_MASK                                                              0x00000030L
+#define VPEC_MEMREQ_BURST_CNTL__IB_RD_BURST_MASK                                                              0x000000C0L
+#define VPEC_MEMREQ_BURST_CNTL__WR_BURST_WAIT_CYCLE_MASK                                                      0x00000700L
+//VPEC_TIMESTAMP_CNTL
+#define VPEC_TIMESTAMP_CNTL__CAPTURE__SHIFT                                                                   0x0
+#define VPEC_TIMESTAMP_CNTL__CAPTURE_MASK                                                                     0x00000001L
+//VPEC_GLOBAL_TIMESTAMP_LO
+#define VPEC_GLOBAL_TIMESTAMP_LO__DATA__SHIFT                                                                 0x0
+#define VPEC_GLOBAL_TIMESTAMP_LO__DATA_MASK                                                                   0xFFFFFFFFL
+//VPEC_GLOBAL_TIMESTAMP_HI
+#define VPEC_GLOBAL_TIMESTAMP_HI__DATA__SHIFT                                                                 0x0
+#define VPEC_GLOBAL_TIMESTAMP_HI__DATA_MASK                                                                   0xFFFFFFFFL
+//VPEC_FREEZE
+#define VPEC_FREEZE__PREEMPT__SHIFT                                                                           0x0
+#define VPEC_FREEZE__FREEZE__SHIFT                                                                            0x4
+#define VPEC_FREEZE__FROZEN__SHIFT                                                                            0x5
+#define VPEC_FREEZE__F32_FREEZE__SHIFT                                                                        0x6
+#define VPEC_FREEZE__PREEMPT_MASK                                                                             0x00000001L
+#define VPEC_FREEZE__FREEZE_MASK                                                                              0x00000010L
+#define VPEC_FREEZE__FROZEN_MASK                                                                              0x00000020L
+#define VPEC_FREEZE__F32_FREEZE_MASK                                                                          0x00000040L
+//VPEC_CE_CTRL
+#define VPEC_CE_CTRL__RD_LUT_WATERMARK__SHIFT                                                                 0x0
+#define VPEC_CE_CTRL__RD_LUT_DEPTH__SHIFT                                                                     0x3
+#define VPEC_CE_CTRL__WR_AFIFO_WATERMARK__SHIFT                                                               0x5
+#define VPEC_CE_CTRL__RESERVED__SHIFT                                                                         0x8
+#define VPEC_CE_CTRL__RD_LUT_WATERMARK_MASK                                                                   0x00000007L
+#define VPEC_CE_CTRL__RD_LUT_DEPTH_MASK                                                                       0x00000018L
+#define VPEC_CE_CTRL__WR_AFIFO_WATERMARK_MASK                                                                 0x000000E0L
+#define VPEC_CE_CTRL__RESERVED_MASK                                                                           0xFFFFFF00L
+//VPEC_RELAX_ORDERING_LUT
+#define VPEC_RELAX_ORDERING_LUT__RESERVED0__SHIFT                                                             0x0
+#define VPEC_RELAX_ORDERING_LUT__VPE__SHIFT                                                                   0x1
+#define VPEC_RELAX_ORDERING_LUT__RESERVED_2_2__SHIFT                                                          0x2
+#define VPEC_RELAX_ORDERING_LUT__RESERVED3__SHIFT                                                             0x3
+#define VPEC_RELAX_ORDERING_LUT__RESERVED4__SHIFT                                                             0x4
+#define VPEC_RELAX_ORDERING_LUT__FENCE__SHIFT                                                                 0x5
+#define VPEC_RELAX_ORDERING_LUT__RESERVED76__SHIFT                                                            0x6
+#define VPEC_RELAX_ORDERING_LUT__POLL_MEM__SHIFT                                                              0x8
+#define VPEC_RELAX_ORDERING_LUT__COND_EXE__SHIFT                                                              0x9
+#define VPEC_RELAX_ORDERING_LUT__ATOMIC__SHIFT                                                                0xa
+#define VPEC_RELAX_ORDERING_LUT__RESERVED_11_11__SHIFT                                                        0xb
+#define VPEC_RELAX_ORDERING_LUT__RESERVED_12_12__SHIFT                                                        0xc
+#define VPEC_RELAX_ORDERING_LUT__TIMESTAMP__SHIFT                                                             0xd
+#define VPEC_RELAX_ORDERING_LUT__NATIVE_FENCE__SHIFT                                                          0xe
+#define VPEC_RELAX_ORDERING_LUT__RESERVED__SHIFT                                                              0xf
+#define VPEC_RELAX_ORDERING_LUT__WORLD_SWITCH__SHIFT                                                          0x1b
+#define VPEC_RELAX_ORDERING_LUT__RPTR_WRB__SHIFT                                                              0x1c
+#define VPEC_RELAX_ORDERING_LUT__RESERVED_29_29__SHIFT                                                        0x1d
+#define VPEC_RELAX_ORDERING_LUT__IB_FETCH__SHIFT                                                              0x1e
+#define VPEC_RELAX_ORDERING_LUT__RB_FETCH__SHIFT                                                              0x1f
+#define VPEC_RELAX_ORDERING_LUT__RESERVED0_MASK                                                               0x00000001L
+#define VPEC_RELAX_ORDERING_LUT__VPE_MASK                                                                     0x00000002L
+#define VPEC_RELAX_ORDERING_LUT__RESERVED_2_2_MASK                                                            0x00000004L
+#define VPEC_RELAX_ORDERING_LUT__RESERVED3_MASK                                                               0x00000008L
+#define VPEC_RELAX_ORDERING_LUT__RESERVED4_MASK                                                               0x00000010L
+#define VPEC_RELAX_ORDERING_LUT__FENCE_MASK                                                                   0x00000020L
+#define VPEC_RELAX_ORDERING_LUT__RESERVED76_MASK                                                              0x000000C0L
+#define VPEC_RELAX_ORDERING_LUT__POLL_MEM_MASK                                                                0x00000100L
+#define VPEC_RELAX_ORDERING_LUT__COND_EXE_MASK                                                                0x00000200L
+#define VPEC_RELAX_ORDERING_LUT__ATOMIC_MASK                                                                  0x00000400L
+#define VPEC_RELAX_ORDERING_LUT__RESERVED_11_11_MASK                                                          0x00000800L
+#define VPEC_RELAX_ORDERING_LUT__RESERVED_12_12_MASK                                                          0x00001000L
+#define VPEC_RELAX_ORDERING_LUT__TIMESTAMP_MASK                                                               0x00002000L
+#define VPEC_RELAX_ORDERING_LUT__NATIVE_FENCE_MASK                                                            0x00004000L
+#define VPEC_RELAX_ORDERING_LUT__RESERVED_MASK                                                                0x07FF8000L
+#define VPEC_RELAX_ORDERING_LUT__WORLD_SWITCH_MASK                                                            0x08000000L
+#define VPEC_RELAX_ORDERING_LUT__RPTR_WRB_MASK                                                                0x10000000L
+#define VPEC_RELAX_ORDERING_LUT__RESERVED_29_29_MASK                                                          0x20000000L
+#define VPEC_RELAX_ORDERING_LUT__IB_FETCH_MASK                                                                0x40000000L
+#define VPEC_RELAX_ORDERING_LUT__RB_FETCH_MASK                                                                0x80000000L
+//VPEC_CREDIT_CNTL
+#define VPEC_CREDIT_CNTL__DRM_CREDIT__SHIFT                                                                   0x0
+#define VPEC_CREDIT_CNTL__MC_WRREQ_CREDIT__SHIFT                                                              0x7
+#define VPEC_CREDIT_CNTL__MC_RDREQ_CREDIT__SHIFT                                                              0xd
+#define VPEC_CREDIT_CNTL__DRM_CREDIT_MASK                                                                     0x0000007FL
+#define VPEC_CREDIT_CNTL__MC_WRREQ_CREDIT_MASK                                                                0x00001F80L
+#define VPEC_CREDIT_CNTL__MC_RDREQ_CREDIT_MASK                                                                0x0007E000L
+//VPEC_SCRATCH_RAM_DATA
+#define VPEC_SCRATCH_RAM_DATA__DATA__SHIFT                                                                    0x0
+#define VPEC_SCRATCH_RAM_DATA__DATA_MASK                                                                      0xFFFFFFFFL
+//VPEC_SCRATCH_RAM_ADDR
+#define VPEC_SCRATCH_RAM_ADDR__ADDR__SHIFT                                                                    0x0
+#define VPEC_SCRATCH_RAM_ADDR__ADDR_MASK                                                                      0x000000FFL
+//VPEC_QUEUE_RESET_REQ
+#define VPEC_QUEUE_RESET_REQ__QUEUE0_RESET__SHIFT                                                             0x0
+#define VPEC_QUEUE_RESET_REQ__QUEUE1_RESET__SHIFT                                                             0x1
+#define VPEC_QUEUE_RESET_REQ__QUEUE2_RESET__SHIFT                                                             0x2
+#define VPEC_QUEUE_RESET_REQ__QUEUE3_RESET__SHIFT                                                             0x3
+#define VPEC_QUEUE_RESET_REQ__QUEUE4_RESET__SHIFT                                                             0x4
+#define VPEC_QUEUE_RESET_REQ__QUEUE5_RESET__SHIFT                                                             0x5
+#define VPEC_QUEUE_RESET_REQ__QUEUE6_RESET__SHIFT                                                             0x6
+#define VPEC_QUEUE_RESET_REQ__QUEUE7_RESET__SHIFT                                                             0x7
+#define VPEC_QUEUE_RESET_REQ__RESERVED__SHIFT                                                                 0x8
+#define VPEC_QUEUE_RESET_REQ__QUEUE0_RESET_MASK                                                               0x00000001L
+#define VPEC_QUEUE_RESET_REQ__QUEUE1_RESET_MASK                                                               0x00000002L
+#define VPEC_QUEUE_RESET_REQ__QUEUE2_RESET_MASK                                                               0x00000004L
+#define VPEC_QUEUE_RESET_REQ__QUEUE3_RESET_MASK                                                               0x00000008L
+#define VPEC_QUEUE_RESET_REQ__QUEUE4_RESET_MASK                                                               0x00000010L
+#define VPEC_QUEUE_RESET_REQ__QUEUE5_RESET_MASK                                                               0x00000020L
+#define VPEC_QUEUE_RESET_REQ__QUEUE6_RESET_MASK                                                               0x00000040L
+#define VPEC_QUEUE_RESET_REQ__QUEUE7_RESET_MASK                                                               0x00000080L
+#define VPEC_QUEUE_RESET_REQ__RESERVED_MASK                                                                   0xFFFFFF00L
+//VPEC_MAILBOX0
+#define VPEC_MAILBOX0__VALUE__SHIFT                                                                           0x0
+#define VPEC_MAILBOX0__VALUE_MASK                                                                             0xFFFFFFFFL
+//VPEC_MAILBOX1
+#define VPEC_MAILBOX1__VALUE__SHIFT                                                                           0x0
+#define VPEC_MAILBOX1__VALUE_MASK                                                                             0xFFFFFFFFL
+//VPEC_MAILBOX2
+#define VPEC_MAILBOX2__VALUE__SHIFT                                                                           0x0
+#define VPEC_MAILBOX2__VALUE_MASK                                                                             0xFFFFFFFFL
+//VPEC_MAILBOX3
+#define VPEC_MAILBOX3__VALUE__SHIFT                                                                           0x0
+#define VPEC_MAILBOX3__VALUE_MASK                                                                             0xFFFFFFFFL
+//VPEC_MAILBOX4
+#define VPEC_MAILBOX4__VALUE__SHIFT                                                                           0x0
+#define VPEC_MAILBOX4__VALUE_MASK                                                                             0xFFFFFFFFL
+//VPEC_MAILBOX5
+#define VPEC_MAILBOX5__VALUE__SHIFT                                                                           0x0
+#define VPEC_MAILBOX5__VALUE_MASK                                                                             0xFFFFFFFFL
+//VPEC_MAILBOX6
+#define VPEC_MAILBOX6__VALUE__SHIFT                                                                           0x0
+#define VPEC_MAILBOX6__VALUE_MASK                                                                             0xFFFFFFFFL
+//VPEC_MAILBOX7
+#define VPEC_MAILBOX7__VALUE__SHIFT                                                                           0x0
+#define VPEC_MAILBOX7__VALUE_MASK                                                                             0xFFFFFFFFL
+//VPEC_MAILBOX8
+#define VPEC_MAILBOX8__VALUE__SHIFT                                                                           0x0
+#define VPEC_MAILBOX8__VALUE_MASK                                                                             0xFFFFFFFFL
+//VPEC_MAILBOX9
+#define VPEC_MAILBOX9__VALUE__SHIFT                                                                           0x0
+#define VPEC_MAILBOX9__VALUE_MASK                                                                             0xFFFFFFFFL
+//VPEC_MAILBOX10
+#define VPEC_MAILBOX10__VALUE__SHIFT                                                                          0x0
+#define VPEC_MAILBOX10__VALUE_MASK                                                                            0xFFFFFFFFL
+//VPEC_MAILBOX11
+#define VPEC_MAILBOX11__VALUE__SHIFT                                                                          0x0
+#define VPEC_MAILBOX11__VALUE_MASK                                                                            0xFFFFFFFFL
+//VPEC_MAILBOX12
+#define VPEC_MAILBOX12__VALUE__SHIFT                                                                          0x0
+#define VPEC_MAILBOX12__VALUE_MASK                                                                            0xFFFFFFFFL
+//VPEC_MAILBOX13
+#define VPEC_MAILBOX13__VALUE__SHIFT                                                                          0x0
+#define VPEC_MAILBOX13__VALUE_MASK                                                                            0xFFFFFFFFL
+//VPEC_MAILBOX14
+#define VPEC_MAILBOX14__VALUE__SHIFT                                                                          0x0
+#define VPEC_MAILBOX14__VALUE_MASK                                                                            0xFFFFFFFFL
+//VPEC_MAILBOX15
+#define VPEC_MAILBOX15__VALUE__SHIFT                                                                          0x0
+#define VPEC_MAILBOX15__VALUE_MASK                                                                            0xFFFFFFFFL
+//VPEC_PUB_DUMMY0
+#define VPEC_PUB_DUMMY0__VALUE__SHIFT                                                                         0x0
+#define VPEC_PUB_DUMMY0__VALUE_MASK                                                                           0xFFFFFFFFL
+//VPEC_PUB_DUMMY1
+#define VPEC_PUB_DUMMY1__VALUE__SHIFT                                                                         0x0
+#define VPEC_PUB_DUMMY1__VALUE_MASK                                                                           0xFFFFFFFFL
+//VPEC_PUB_DUMMY2
+#define VPEC_PUB_DUMMY2__VALUE__SHIFT                                                                         0x0
+#define VPEC_PUB_DUMMY2__VALUE_MASK                                                                           0xFFFFFFFFL
+//VPEC_PUB_DUMMY3
+#define VPEC_PUB_DUMMY3__VALUE__SHIFT                                                                         0x0
+#define VPEC_PUB_DUMMY3__VALUE_MASK                                                                           0xFFFFFFFFL
+//VPEC_PUB_DUMMY4
+#define VPEC_PUB_DUMMY4__VALUE__SHIFT                                                                         0x0
+#define VPEC_PUB_DUMMY4__VALUE_MASK                                                                           0xFFFFFFFFL
+//VPEC_PUB_DUMMY5
+#define VPEC_PUB_DUMMY5__VALUE__SHIFT                                                                         0x0
+#define VPEC_PUB_DUMMY5__VALUE_MASK                                                                           0xFFFFFFFFL
+//VPEC_PUB_DUMMY6
+#define VPEC_PUB_DUMMY6__VALUE__SHIFT                                                                         0x0
+#define VPEC_PUB_DUMMY6__VALUE_MASK                                                                           0xFFFFFFFFL
+//VPEC_PUB_DUMMY7
+#define VPEC_PUB_DUMMY7__VALUE__SHIFT                                                                         0x0
+#define VPEC_PUB_DUMMY7__VALUE_MASK                                                                           0xFFFFFFFFL
+//VPEC_PUB_DUMMY8
+#define VPEC_PUB_DUMMY8__VALUE__SHIFT                                                                         0x0
+#define VPEC_PUB_DUMMY8__VALUE_MASK                                                                           0xFFFFFFFFL
+//VPEC_PUB_DUMMY9
+#define VPEC_PUB_DUMMY9__VALUE__SHIFT                                                                         0x0
+#define VPEC_PUB_DUMMY9__VALUE_MASK                                                                           0xFFFFFFFFL
+//VPEC_PUB_DUMMY10
+#define VPEC_PUB_DUMMY10__VALUE__SHIFT                                                                        0x0
+#define VPEC_PUB_DUMMY10__VALUE_MASK                                                                          0xFFFFFFFFL
+//VPEC_PUB_DUMMY11
+#define VPEC_PUB_DUMMY11__VALUE__SHIFT                                                                        0x0
+#define VPEC_PUB_DUMMY11__VALUE_MASK                                                                          0xFFFFFFFFL
+//VPEC_UCODE1_CHECKSUM
+#define VPEC_UCODE1_CHECKSUM__DATA__SHIFT                                                                     0x0
+#define VPEC_UCODE1_CHECKSUM__DATA_MASK                                                                       0xFFFFFFFFL
+//VPEC_VERSION
+#define VPEC_VERSION__MINVER__SHIFT                                                                           0x0
+#define VPEC_VERSION__MAJVER__SHIFT                                                                           0x8
+#define VPEC_VERSION__REV__SHIFT                                                                              0x10
+#define VPEC_VERSION__MINVER_MASK                                                                             0x0000007FL
+#define VPEC_VERSION__MAJVER_MASK                                                                             0x00007F00L
+#define VPEC_VERSION__REV_MASK                                                                                0x003F0000L
+//VPEC_UCODE_CHECKSUM
+#define VPEC_UCODE_CHECKSUM__DATA__SHIFT                                                                      0x0
+#define VPEC_UCODE_CHECKSUM__DATA_MASK                                                                        0xFFFFFFFFL
+//VPEC_RB_RPTR_FETCH
+#define VPEC_RB_RPTR_FETCH__OFFSET__SHIFT                                                                     0x2
+#define VPEC_RB_RPTR_FETCH__OFFSET_MASK                                                                       0xFFFFFFFCL
+//VPEC_RB_RPTR_FETCH_HI
+#define VPEC_RB_RPTR_FETCH_HI__OFFSET__SHIFT                                                                  0x0
+#define VPEC_RB_RPTR_FETCH_HI__OFFSET_MASK                                                                    0xFFFFFFFFL
+//VPEC_IB_OFFSET_FETCH
+#define VPEC_IB_OFFSET_FETCH__OFFSET__SHIFT                                                                   0x2
+#define VPEC_IB_OFFSET_FETCH__OFFSET_MASK                                                                     0x003FFFFCL
+//VPEC_CMDIB_OFFSET_FETCH
+#define VPEC_CMDIB_OFFSET_FETCH__OFFSET__SHIFT                                                                0x2
+#define VPEC_CMDIB_OFFSET_FETCH__OFFSET_MASK                                                                  0x003FFFFCL
+//VPEC_3DLUTIB_OFFSET_FETCH
+#define VPEC_3DLUTIB_OFFSET_FETCH__OFFSET__SHIFT                                                              0x2
+#define VPEC_3DLUTIB_OFFSET_FETCH__OFFSET_MASK                                                                0x003FFFFCL
+//VPEC_ATOMIC_PREOP_LO
+#define VPEC_ATOMIC_PREOP_LO__DATA__SHIFT                                                                     0x0
+#define VPEC_ATOMIC_PREOP_LO__DATA_MASK                                                                       0xFFFFFFFFL
+//VPEC_ATOMIC_PREOP_HI
+#define VPEC_ATOMIC_PREOP_HI__DATA__SHIFT                                                                     0x0
+#define VPEC_ATOMIC_PREOP_HI__DATA_MASK                                                                       0xFFFFFFFFL
+//VPEC_CE_BUSY
+#define VPEC_CE_BUSY__CE_IP_PIPE0_BUSY__SHIFT                                                                 0x0
+#define VPEC_CE_BUSY__CE_IP_PIPE1_BUSY__SHIFT                                                                 0x1
+#define VPEC_CE_BUSY__CE_IP_PIPE2_BUSY__SHIFT                                                                 0x2
+#define VPEC_CE_BUSY__CE_IP_PIPE3_BUSY__SHIFT                                                                 0x3
+#define VPEC_CE_BUSY__CE_IP_PIPE4_BUSY__SHIFT                                                                 0x4
+#define VPEC_CE_BUSY__CE_IP_PIPE5_BUSY__SHIFT                                                                 0x5
+#define VPEC_CE_BUSY__CE_OP_PIPE0_BUSY__SHIFT                                                                 0x10
+#define VPEC_CE_BUSY__CE_OP_PIPE1_BUSY__SHIFT                                                                 0x11
+#define VPEC_CE_BUSY__CE_OP_PIPE2_BUSY__SHIFT                                                                 0x12
+#define VPEC_CE_BUSY__CE_OP_PIPE3_BUSY__SHIFT                                                                 0x13
+#define VPEC_CE_BUSY__CE_OP_PIPE4_BUSY__SHIFT                                                                 0x14
+#define VPEC_CE_BUSY__CE_OP_PIPE5_BUSY__SHIFT                                                                 0x15
+#define VPEC_CE_BUSY__CE_OP_PIPE6_BUSY__SHIFT                                                                 0x16
+#define VPEC_CE_BUSY__CE_OP_PIPE7_BUSY__SHIFT                                                                 0x17
+#define VPEC_CE_BUSY__CE_OP_PIPE8_BUSY__SHIFT                                                                 0x18
+#define VPEC_CE_BUSY__CE_OP_PIPE9_BUSY__SHIFT                                                                 0x19
+#define VPEC_CE_BUSY__CE_IP_PIPE0_BUSY_MASK                                                                   0x00000001L
+#define VPEC_CE_BUSY__CE_IP_PIPE1_BUSY_MASK                                                                   0x00000002L
+#define VPEC_CE_BUSY__CE_IP_PIPE2_BUSY_MASK                                                                   0x00000004L
+#define VPEC_CE_BUSY__CE_IP_PIPE3_BUSY_MASK                                                                   0x00000008L
+#define VPEC_CE_BUSY__CE_IP_PIPE4_BUSY_MASK                                                                   0x00000010L
+#define VPEC_CE_BUSY__CE_IP_PIPE5_BUSY_MASK                                                                   0x00000020L
+#define VPEC_CE_BUSY__CE_OP_PIPE0_BUSY_MASK                                                                   0x00010000L
+#define VPEC_CE_BUSY__CE_OP_PIPE1_BUSY_MASK                                                                   0x00020000L
+#define VPEC_CE_BUSY__CE_OP_PIPE2_BUSY_MASK                                                                   0x00040000L
+#define VPEC_CE_BUSY__CE_OP_PIPE3_BUSY_MASK                                                                   0x00080000L
+#define VPEC_CE_BUSY__CE_OP_PIPE4_BUSY_MASK                                                                   0x00100000L
+#define VPEC_CE_BUSY__CE_OP_PIPE5_BUSY_MASK                                                                   0x00200000L
+#define VPEC_CE_BUSY__CE_OP_PIPE6_BUSY_MASK                                                                   0x00400000L
+#define VPEC_CE_BUSY__CE_OP_PIPE7_BUSY_MASK                                                                   0x00800000L
+#define VPEC_CE_BUSY__CE_OP_PIPE8_BUSY_MASK                                                                   0x01000000L
+#define VPEC_CE_BUSY__CE_OP_PIPE9_BUSY_MASK                                                                   0x02000000L
+//VPEC_F32_COUNTER
+#define VPEC_F32_COUNTER__VALUE__SHIFT                                                                        0x0
+#define VPEC_F32_COUNTER__VALUE_MASK                                                                          0xFFFFFFFFL
+//VPEC_HOLE_ADDR_LO
+#define VPEC_HOLE_ADDR_LO__VALUE__SHIFT                                                                       0x0
+#define VPEC_HOLE_ADDR_LO__VALUE_MASK                                                                         0xFFFFFFFFL
+//VPEC_HOLE_ADDR_HI
+#define VPEC_HOLE_ADDR_HI__VALUE__SHIFT                                                                       0x0
+#define VPEC_HOLE_ADDR_HI__VALUE_MASK                                                                         0xFFFFFFFFL
+//VPEC_ERROR_LOG
+#define VPEC_ERROR_LOG__OVERRIDE__SHIFT                                                                       0x0
+#define VPEC_ERROR_LOG__STATUS__SHIFT                                                                         0x10
+#define VPEC_ERROR_LOG__OVERRIDE_MASK                                                                         0x0000FFFFL
+#define VPEC_ERROR_LOG__STATUS_MASK                                                                           0xFFFF0000L
+//VPEC_INT_STATUS
+#define VPEC_INT_STATUS__DATA__SHIFT                                                                          0x0
+#define VPEC_INT_STATUS__DATA_MASK                                                                            0xFFFFFFFFL
+//VPEC_STATUS
+#define VPEC_STATUS__IDLE__SHIFT                                                                              0x0
+#define VPEC_STATUS__REG_IDLE__SHIFT                                                                          0x1
+#define VPEC_STATUS__RB_EMPTY__SHIFT                                                                          0x2
+#define VPEC_STATUS__RB_FULL__SHIFT                                                                           0x3
+#define VPEC_STATUS__RB_CMD_IDLE__SHIFT                                                                       0x4
+#define VPEC_STATUS__RB_CMD_FULL__SHIFT                                                                       0x5
+#define VPEC_STATUS__IB_CMD_IDLE__SHIFT                                                                       0x6
+#define VPEC_STATUS__IB_CMD_FULL__SHIFT                                                                       0x7
+#define VPEC_STATUS__BLOCK_IDLE__SHIFT                                                                        0x8
+#define VPEC_STATUS__INSIDE_VPEP_CONFIG__SHIFT                                                                0x9
+#define VPEC_STATUS__EX_IDLE__SHIFT                                                                           0xa
+#define VPEC_STATUS__INSIDE_VPEP_3DLUT_CONFIG__SHIFT                                                          0xb
+#define VPEC_STATUS__PACKET_READY__SHIFT                                                                      0xc
+#define VPEC_STATUS__MC_WR_IDLE__SHIFT                                                                        0xd
+#define VPEC_STATUS__SRBM_IDLE__SHIFT                                                                         0xe
+#define VPEC_STATUS__CONTEXT_EMPTY__SHIFT                                                                     0xf
+#define VPEC_STATUS__INSIDE_IB__SHIFT                                                                         0x10
+#define VPEC_STATUS__RB_MC_RREQ_IDLE__SHIFT                                                                   0x11
+#define VPEC_STATUS__IB_MC_RREQ_IDLE__SHIFT                                                                   0x12
+#define VPEC_STATUS__MC_RD_IDLE__SHIFT                                                                        0x13
+#define VPEC_STATUS__DELTA_RPTR_EMPTY__SHIFT                                                                  0x14
+#define VPEC_STATUS__MC_RD_RET_STALL__SHIFT                                                                   0x15
+#define VPEC_STATUS__LUTIB_CMD_IDLE__SHIFT                                                                    0x16
+#define VPEC_STATUS__LUTIB_CMD_FULL__SHIFT                                                                    0x17
+#define VPEC_STATUS__CMDIB_MC_RREQ_IDLE__SHIFT                                                                0x18
+#define VPEC_STATUS__PREV_CMD_IDLE__SHIFT                                                                     0x19
+#define VPEC_STATUS__CMDIB_CMD_IDLE__SHIFT                                                                    0x1a
+#define VPEC_STATUS__CMDIB_CMD_FULL__SHIFT                                                                    0x1b
+#define VPEC_STATUS__RESERVED_29_28__SHIFT                                                                    0x1c
+#define VPEC_STATUS__INT_IDLE__SHIFT                                                                          0x1e
+#define VPEC_STATUS__INT_REQ_STALL__SHIFT                                                                     0x1f
+#define VPEC_STATUS__IDLE_MASK                                                                                0x00000001L
+#define VPEC_STATUS__REG_IDLE_MASK                                                                            0x00000002L
+#define VPEC_STATUS__RB_EMPTY_MASK                                                                            0x00000004L
+#define VPEC_STATUS__RB_FULL_MASK                                                                             0x00000008L
+#define VPEC_STATUS__RB_CMD_IDLE_MASK                                                                         0x00000010L
+#define VPEC_STATUS__RB_CMD_FULL_MASK                                                                         0x00000020L
+#define VPEC_STATUS__IB_CMD_IDLE_MASK                                                                         0x00000040L
+#define VPEC_STATUS__IB_CMD_FULL_MASK                                                                         0x00000080L
+#define VPEC_STATUS__BLOCK_IDLE_MASK                                                                          0x00000100L
+#define VPEC_STATUS__INSIDE_VPEP_CONFIG_MASK                                                                  0x00000200L
+#define VPEC_STATUS__EX_IDLE_MASK                                                                             0x00000400L
+#define VPEC_STATUS__INSIDE_VPEP_3DLUT_CONFIG_MASK                                                            0x00000800L
+#define VPEC_STATUS__PACKET_READY_MASK                                                                        0x00001000L
+#define VPEC_STATUS__MC_WR_IDLE_MASK                                                                          0x00002000L
+#define VPEC_STATUS__SRBM_IDLE_MASK                                                                           0x00004000L
+#define VPEC_STATUS__CONTEXT_EMPTY_MASK                                                                       0x00008000L
+#define VPEC_STATUS__INSIDE_IB_MASK                                                                           0x00010000L
+#define VPEC_STATUS__RB_MC_RREQ_IDLE_MASK                                                                     0x00020000L
+#define VPEC_STATUS__IB_MC_RREQ_IDLE_MASK                                                                     0x00040000L
+#define VPEC_STATUS__MC_RD_IDLE_MASK                                                                          0x00080000L
+#define VPEC_STATUS__DELTA_RPTR_EMPTY_MASK                                                                    0x00100000L
+#define VPEC_STATUS__MC_RD_RET_STALL_MASK                                                                     0x00200000L
+#define VPEC_STATUS__LUTIB_CMD_IDLE_MASK                                                                      0x00400000L
+#define VPEC_STATUS__LUTIB_CMD_FULL_MASK                                                                      0x00800000L
+#define VPEC_STATUS__CMDIB_MC_RREQ_IDLE_MASK                                                                  0x01000000L
+#define VPEC_STATUS__PREV_CMD_IDLE_MASK                                                                       0x02000000L
+#define VPEC_STATUS__CMDIB_CMD_IDLE_MASK                                                                      0x04000000L
+#define VPEC_STATUS__CMDIB_CMD_FULL_MASK                                                                      0x08000000L
+#define VPEC_STATUS__RESERVED_29_28_MASK                                                                      0x30000000L
+#define VPEC_STATUS__INT_IDLE_MASK                                                                            0x40000000L
+#define VPEC_STATUS__INT_REQ_STALL_MASK                                                                       0x80000000L
+//VPEC_STATUS1
+#define VPEC_STATUS1__EX_START__SHIFT                                                                         0x0
+#define VPEC_STATUS1__VPEC_IDLE__SHIFT                                                                        0x1
+#define VPEC_STATUS1__RESERVED_31_2__SHIFT                                                                    0x2
+#define VPEC_STATUS1__EX_START_MASK                                                                           0x00000001L
+#define VPEC_STATUS1__VPEC_IDLE_MASK                                                                          0x00000002L
+#define VPEC_STATUS1__RESERVED_31_2_MASK                                                                      0xFFFFFFFCL
+//VPEC_STATUS2
+#define VPEC_STATUS2__ID__SHIFT                                                                               0x0
+#define VPEC_STATUS2__TH0F32_INSTR_PTR__SHIFT                                                                 0x2
+#define VPEC_STATUS2__CMD_OP__SHIFT                                                                           0x10
+#define VPEC_STATUS2__ID_MASK                                                                                 0x00000003L
+#define VPEC_STATUS2__TH0F32_INSTR_PTR_MASK                                                                   0x0000FFFCL
+#define VPEC_STATUS2__CMD_OP_MASK                                                                             0xFFFF0000L
+//VPEC_STATUS3
+#define VPEC_STATUS3__RESERVED_15_0__SHIFT                                                                    0x0
+#define VPEC_STATUS3__RESERVED_19_16__SHIFT                                                                   0x10
+#define VPEC_STATUS3__EXCEPTION_IDLE__SHIFT                                                                   0x14
+#define VPEC_STATUS3__RESERVED_21_21__SHIFT                                                                   0x15
+#define VPEC_STATUS3__RESERVED_22_22__SHIFT                                                                   0x16
+#define VPEC_STATUS3__RESERVED_23_23__SHIFT                                                                   0x17
+#define VPEC_STATUS3__RESERVED_24_24__SHIFT                                                                   0x18
+#define VPEC_STATUS3__RESERVED_25_25__SHIFT                                                                   0x19
+#define VPEC_STATUS3__INT_QUEUE_ID__SHIFT                                                                     0x1a
+#define VPEC_STATUS3__RESERVED_31_30__SHIFT                                                                   0x1e
+#define VPEC_STATUS3__RESERVED_15_0_MASK                                                                      0x0000FFFFL
+#define VPEC_STATUS3__RESERVED_19_16_MASK                                                                     0x000F0000L
+#define VPEC_STATUS3__EXCEPTION_IDLE_MASK                                                                     0x00100000L
+#define VPEC_STATUS3__RESERVED_21_21_MASK                                                                     0x00200000L
+#define VPEC_STATUS3__RESERVED_22_22_MASK                                                                     0x00400000L
+#define VPEC_STATUS3__RESERVED_23_23_MASK                                                                     0x00800000L
+#define VPEC_STATUS3__RESERVED_24_24_MASK                                                                     0x01000000L
+#define VPEC_STATUS3__RESERVED_25_25_MASK                                                                     0x02000000L
+#define VPEC_STATUS3__INT_QUEUE_ID_MASK                                                                       0x3C000000L
+#define VPEC_STATUS3__RESERVED_31_30_MASK                                                                     0xC0000000L
+//VPEC_STATUS4
+#define VPEC_STATUS4__IDLE__SHIFT                                                                             0x0
+#define VPEC_STATUS4__IH_OUTSTANDING__SHIFT                                                                   0x2
+#define VPEC_STATUS4__RESERVED_3_3__SHIFT                                                                     0x3
+#define VPEC_STATUS4__CH_RD_OUTSTANDING__SHIFT                                                                0x4
+#define VPEC_STATUS4__CH_WR_OUTSTANDING__SHIFT                                                                0x5
+#define VPEC_STATUS4__RESERVED_6_6__SHIFT                                                                     0x6
+#define VPEC_STATUS4__RESERVED_7_7__SHIFT                                                                     0x7
+#define VPEC_STATUS4__RESERVED_8_8__SHIFT                                                                     0x8
+#define VPEC_STATUS4__RESERVED_9_9__SHIFT                                                                     0x9
+#define VPEC_STATUS4__REG_POLLING__SHIFT                                                                      0xa
+#define VPEC_STATUS4__MEM_POLLING__SHIFT                                                                      0xb
+#define VPEC_STATUS4__VPEP_REG_RD_OUTSTANDING__SHIFT                                                          0xc
+#define VPEC_STATUS4__VPEP_REG_WR_OUTSTANDING__SHIFT                                                          0xd
+#define VPEC_STATUS4__RESERVED_15_14__SHIFT                                                                   0xe
+#define VPEC_STATUS4__ACTIVE_QUEUE_ID__SHIFT                                                                  0x10
+#define VPEC_STATUS4__RESERVED_27_20__SHIFT                                                                   0x14
+#define VPEC_STATUS4__IDLE_MASK                                                                               0x00000001L
+#define VPEC_STATUS4__IH_OUTSTANDING_MASK                                                                     0x00000004L
+#define VPEC_STATUS4__RESERVED_3_3_MASK                                                                       0x00000008L
+#define VPEC_STATUS4__CH_RD_OUTSTANDING_MASK                                                                  0x00000010L
+#define VPEC_STATUS4__CH_WR_OUTSTANDING_MASK                                                                  0x00000020L
+#define VPEC_STATUS4__RESERVED_6_6_MASK                                                                       0x00000040L
+#define VPEC_STATUS4__RESERVED_7_7_MASK                                                                       0x00000080L
+#define VPEC_STATUS4__RESERVED_8_8_MASK                                                                       0x00000100L
+#define VPEC_STATUS4__RESERVED_9_9_MASK                                                                       0x00000200L
+#define VPEC_STATUS4__REG_POLLING_MASK                                                                        0x00000400L
+#define VPEC_STATUS4__MEM_POLLING_MASK                                                                        0x00000800L
+#define VPEC_STATUS4__VPEP_REG_RD_OUTSTANDING_MASK                                                            0x00001000L
+#define VPEC_STATUS4__VPEP_REG_WR_OUTSTANDING_MASK                                                            0x00002000L
+#define VPEC_STATUS4__RESERVED_15_14_MASK                                                                     0x0000C000L
+#define VPEC_STATUS4__ACTIVE_QUEUE_ID_MASK                                                                    0x000F0000L
+#define VPEC_STATUS4__RESERVED_27_20_MASK                                                                     0x0FF00000L
+//VPEC_STATUS5
+#define VPEC_STATUS5__QUEUE0_RB_ENABLE_STATUS__SHIFT                                                          0x0
+#define VPEC_STATUS5__QUEUE1_RB_ENABLE_STATUS__SHIFT                                                          0x1
+#define VPEC_STATUS5__QUEUE2_RB_ENABLE_STATUS__SHIFT                                                          0x2
+#define VPEC_STATUS5__QUEUE3_RB_ENABLE_STATUS__SHIFT                                                          0x3
+#define VPEC_STATUS5__QUEUE4_RB_ENABLE_STATUS__SHIFT                                                          0x4
+#define VPEC_STATUS5__QUEUE5_RB_ENABLE_STATUS__SHIFT                                                          0x5
+#define VPEC_STATUS5__QUEUE6_RB_ENABLE_STATUS__SHIFT                                                          0x6
+#define VPEC_STATUS5__QUEUE7_RB_ENABLE_STATUS__SHIFT                                                          0x7
+#define VPEC_STATUS5__RESERVED_27_16__SHIFT                                                                   0x10
+#define VPEC_STATUS5__QUEUE0_RB_ENABLE_STATUS_MASK                                                            0x00000001L
+#define VPEC_STATUS5__QUEUE1_RB_ENABLE_STATUS_MASK                                                            0x00000002L
+#define VPEC_STATUS5__QUEUE2_RB_ENABLE_STATUS_MASK                                                            0x00000004L
+#define VPEC_STATUS5__QUEUE3_RB_ENABLE_STATUS_MASK                                                            0x00000008L
+#define VPEC_STATUS5__QUEUE4_RB_ENABLE_STATUS_MASK                                                            0x00000010L
+#define VPEC_STATUS5__QUEUE5_RB_ENABLE_STATUS_MASK                                                            0x00000020L
+#define VPEC_STATUS5__QUEUE6_RB_ENABLE_STATUS_MASK                                                            0x00000040L
+#define VPEC_STATUS5__QUEUE7_RB_ENABLE_STATUS_MASK                                                            0x00000080L
+#define VPEC_STATUS5__RESERVED_27_16_MASK                                                                     0x000F0000L
+//VPEC_STATUS6
+#define VPEC_STATUS6__ID__SHIFT                                                                               0x0
+#define VPEC_STATUS6__TH1F32_INSTR_PTR__SHIFT                                                                 0x2
+#define VPEC_STATUS6__TH1_EXCEPTION__SHIFT                                                                    0x10
+#define VPEC_STATUS6__ID_MASK                                                                                 0x00000003L
+#define VPEC_STATUS6__TH1F32_INSTR_PTR_MASK                                                                   0x0000FFFCL
+#define VPEC_STATUS6__TH1_EXCEPTION_MASK                                                                      0xFFFF0000L
+//VPEC_STATUS7
+#define VPEC_STATUS7__TH0_DBG_STATUS__SHIFT                                                                   0x0
+#define VPEC_STATUS7__TH0_DBG_STATUS_MASK                                                                     0xFFFFFFFFL
+//VPEC_STATUS8
+#define VPEC_STATUS8__CE_IP0_WREQ_IDLE__SHIFT                                                                 0x0
+#define VPEC_STATUS8__CE_IP0_WR_IDLE__SHIFT                                                                   0x1
+#define VPEC_STATUS8__CE_IP0_SPLIT_RD_IDLE__SHIFT                                                             0x2
+#define VPEC_STATUS8__CE_IP0_SPLIT_WR_IDLE__SHIFT                                                             0x3
+#define VPEC_STATUS8__CE_IP0_RREQ_IDLE__SHIFT                                                                 0x4
+#define VPEC_STATUS8__CE_IP0_OUT_IDLE__SHIFT                                                                  0x5
+#define VPEC_STATUS8__CE_IP0_IN_IDLE__SHIFT                                                                   0x6
+#define VPEC_STATUS8__CE_IP0_DST_IDLE__SHIFT                                                                  0x7
+#define VPEC_STATUS8__CE_IP0_CMD_IDLE__SHIFT                                                                  0x8
+#define VPEC_STATUS8__CE_IP1_WREQ_IDLE__SHIFT                                                                 0x9
+#define VPEC_STATUS8__CE_IP1_WR_IDLE__SHIFT                                                                   0xa
+#define VPEC_STATUS8__CE_IP1_SPLIT_RD_IDLE__SHIFT                                                             0xb
+#define VPEC_STATUS8__CE_IP1_SPLIT_WR_IDLE__SHIFT                                                             0xc
+#define VPEC_STATUS8__CE_IP1_RREQ_IDLE__SHIFT                                                                 0xd
+#define VPEC_STATUS8__CE_IP1_OUT_IDLE__SHIFT                                                                  0xe
+#define VPEC_STATUS8__CE_IP1_IN_IDLE__SHIFT                                                                   0xf
+#define VPEC_STATUS8__CE_IP1_DST_IDLE__SHIFT                                                                  0x10
+#define VPEC_STATUS8__CE_IP1_CMD_IDLE__SHIFT                                                                  0x11
+#define VPEC_STATUS8__CE_IP0_AFIFO_FULL__SHIFT                                                                0x12
+#define VPEC_STATUS8__CE_IP0_CMD_INFO_FULL__SHIFT                                                             0x13
+#define VPEC_STATUS8__CE_IP0_CMD_INFO1_FULL__SHIFT                                                            0x14
+#define VPEC_STATUS8__CE_IP1_AFIFO_FULL__SHIFT                                                                0x15
+#define VPEC_STATUS8__CE_IP1_CMD_INFO_FULL__SHIFT                                                             0x16
+#define VPEC_STATUS8__CE_IP1_CMD_INFO1_FULL__SHIFT                                                            0x17
+#define VPEC_STATUS8__CE_IP0_WR_STALL__SHIFT                                                                  0x18
+#define VPEC_STATUS8__CE_IP1_WR_STALL__SHIFT                                                                  0x19
+#define VPEC_STATUS8__CE_IP0_RD_STALL__SHIFT                                                                  0x1a
+#define VPEC_STATUS8__CE_IP1_RD_STALL__SHIFT                                                                  0x1b
+#define VPEC_STATUS8__RESERVED_31_28__SHIFT                                                                   0x1c
+#define VPEC_STATUS8__CE_IP0_WREQ_IDLE_MASK                                                                   0x00000001L
+#define VPEC_STATUS8__CE_IP0_WR_IDLE_MASK                                                                     0x00000002L
+#define VPEC_STATUS8__CE_IP0_SPLIT_RD_IDLE_MASK                                                               0x00000004L
+#define VPEC_STATUS8__CE_IP0_SPLIT_WR_IDLE_MASK                                                               0x00000008L
+#define VPEC_STATUS8__CE_IP0_RREQ_IDLE_MASK                                                                   0x00000010L
+#define VPEC_STATUS8__CE_IP0_OUT_IDLE_MASK                                                                    0x00000020L
+#define VPEC_STATUS8__CE_IP0_IN_IDLE_MASK                                                                     0x00000040L
+#define VPEC_STATUS8__CE_IP0_DST_IDLE_MASK                                                                    0x00000080L
+#define VPEC_STATUS8__CE_IP0_CMD_IDLE_MASK                                                                    0x00000100L
+#define VPEC_STATUS8__CE_IP1_WREQ_IDLE_MASK                                                                   0x00000200L
+#define VPEC_STATUS8__CE_IP1_WR_IDLE_MASK                                                                     0x00000400L
+#define VPEC_STATUS8__CE_IP1_SPLIT_RD_IDLE_MASK                                                               0x00000800L
+#define VPEC_STATUS8__CE_IP1_SPLIT_WR_IDLE_MASK                                                               0x00001000L
+#define VPEC_STATUS8__CE_IP1_RREQ_IDLE_MASK                                                                   0x00002000L
+#define VPEC_STATUS8__CE_IP1_OUT_IDLE_MASK                                                                    0x00004000L
+#define VPEC_STATUS8__CE_IP1_IN_IDLE_MASK                                                                     0x00008000L
+#define VPEC_STATUS8__CE_IP1_DST_IDLE_MASK                                                                    0x00010000L
+#define VPEC_STATUS8__CE_IP1_CMD_IDLE_MASK                                                                    0x00020000L
+#define VPEC_STATUS8__CE_IP0_AFIFO_FULL_MASK                                                                  0x00040000L
+#define VPEC_STATUS8__CE_IP0_CMD_INFO_FULL_MASK                                                               0x00080000L
+#define VPEC_STATUS8__CE_IP0_CMD_INFO1_FULL_MASK                                                              0x00100000L
+#define VPEC_STATUS8__CE_IP1_AFIFO_FULL_MASK                                                                  0x00200000L
+#define VPEC_STATUS8__CE_IP1_CMD_INFO_FULL_MASK                                                               0x00400000L
+#define VPEC_STATUS8__CE_IP1_CMD_INFO1_FULL_MASK                                                              0x00800000L
+#define VPEC_STATUS8__CE_IP0_WR_STALL_MASK                                                                    0x01000000L
+#define VPEC_STATUS8__CE_IP1_WR_STALL_MASK                                                                    0x02000000L
+#define VPEC_STATUS8__CE_IP0_RD_STALL_MASK                                                                    0x04000000L
+#define VPEC_STATUS8__CE_IP1_RD_STALL_MASK                                                                    0x08000000L
+#define VPEC_STATUS8__RESERVED_31_28_MASK                                                                     0xF0000000L
+//VPEC_STATUS9
+#define VPEC_STATUS9__CE_IP2_WREQ_IDLE__SHIFT                                                                 0x0
+#define VPEC_STATUS9__CE_IP2_WR_IDLE__SHIFT                                                                   0x1
+#define VPEC_STATUS9__CE_IP2_SPLIT_RD_IDLE__SHIFT                                                             0x2
+#define VPEC_STATUS9__CE_IP2_SPLIT_WR_IDLE__SHIFT                                                             0x3
+#define VPEC_STATUS9__CE_IP2_RREQ_IDLE__SHIFT                                                                 0x4
+#define VPEC_STATUS9__CE_IP2_OUT_IDLE__SHIFT                                                                  0x5
+#define VPEC_STATUS9__CE_IP2_IN_IDLE__SHIFT                                                                   0x6
+#define VPEC_STATUS9__CE_IP2_DST_IDLE__SHIFT                                                                  0x7
+#define VPEC_STATUS9__CE_IP2_CMD_IDLE__SHIFT                                                                  0x8
+#define VPEC_STATUS9__CE_IP3_WREQ_IDLE__SHIFT                                                                 0x9
+#define VPEC_STATUS9__CE_IP3_WR_IDLE__SHIFT                                                                   0xa
+#define VPEC_STATUS9__CE_IP3_SPLIT_RD_IDLE__SHIFT                                                             0xb
+#define VPEC_STATUS9__CE_IP3_SPLIT_WR_IDLE__SHIFT                                                             0xc
+#define VPEC_STATUS9__CE_IP3_RREQ_IDLE__SHIFT                                                                 0xd
+#define VPEC_STATUS9__CE_IP3_OUT_IDLE__SHIFT                                                                  0xe
+#define VPEC_STATUS9__CE_IP3_IN_IDLE__SHIFT                                                                   0xf
+#define VPEC_STATUS9__CE_IP3_DST_IDLE__SHIFT                                                                  0x10
+#define VPEC_STATUS9__CE_IP3_CMD_IDLE__SHIFT                                                                  0x11
+#define VPEC_STATUS9__CE_IP2_AFIFO_FULL__SHIFT                                                                0x12
+#define VPEC_STATUS9__CE_IP2_CMD_INFO_FULL__SHIFT                                                             0x13
+#define VPEC_STATUS9__CE_IP2_CMD_INFO1_FULL__SHIFT                                                            0x14
+#define VPEC_STATUS9__CE_IP3_AFIFO_FULL__SHIFT                                                                0x15
+#define VPEC_STATUS9__CE_IP3_CMD_INFO_FULL__SHIFT                                                             0x16
+#define VPEC_STATUS9__CE_IP3_CMD_INFO1_FULL__SHIFT                                                            0x17
+#define VPEC_STATUS9__CE_IP2_WR_STALL__SHIFT                                                                  0x18
+#define VPEC_STATUS9__CE_IP3_WR_STALL__SHIFT                                                                  0x19
+#define VPEC_STATUS9__CE_IP2_RD_STALL__SHIFT                                                                  0x1a
+#define VPEC_STATUS9__CE_IP3_RD_STALL__SHIFT                                                                  0x1b
+#define VPEC_STATUS9__RESERVED_31_28__SHIFT                                                                   0x1c
+#define VPEC_STATUS9__CE_IP2_WREQ_IDLE_MASK                                                                   0x00000001L
+#define VPEC_STATUS9__CE_IP2_WR_IDLE_MASK                                                                     0x00000002L
+#define VPEC_STATUS9__CE_IP2_SPLIT_RD_IDLE_MASK                                                               0x00000004L
+#define VPEC_STATUS9__CE_IP2_SPLIT_WR_IDLE_MASK                                                               0x00000008L
+#define VPEC_STATUS9__CE_IP2_RREQ_IDLE_MASK                                                                   0x00000010L
+#define VPEC_STATUS9__CE_IP2_OUT_IDLE_MASK                                                                    0x00000020L
+#define VPEC_STATUS9__CE_IP2_IN_IDLE_MASK                                                                     0x00000040L
+#define VPEC_STATUS9__CE_IP2_DST_IDLE_MASK                                                                    0x00000080L
+#define VPEC_STATUS9__CE_IP2_CMD_IDLE_MASK                                                                    0x00000100L
+#define VPEC_STATUS9__CE_IP3_WREQ_IDLE_MASK                                                                   0x00000200L
+#define VPEC_STATUS9__CE_IP3_WR_IDLE_MASK                                                                     0x00000400L
+#define VPEC_STATUS9__CE_IP3_SPLIT_RD_IDLE_MASK                                                               0x00000800L
+#define VPEC_STATUS9__CE_IP3_SPLIT_WR_IDLE_MASK                                                               0x00001000L
+#define VPEC_STATUS9__CE_IP3_RREQ_IDLE_MASK                                                                   0x00002000L
+#define VPEC_STATUS9__CE_IP3_OUT_IDLE_MASK                                                                    0x00004000L
+#define VPEC_STATUS9__CE_IP3_IN_IDLE_MASK                                                                     0x00008000L
+#define VPEC_STATUS9__CE_IP3_DST_IDLE_MASK                                                                    0x00010000L
+#define VPEC_STATUS9__CE_IP3_CMD_IDLE_MASK                                                                    0x00020000L
+#define VPEC_STATUS9__CE_IP2_AFIFO_FULL_MASK                                                                  0x00040000L
+#define VPEC_STATUS9__CE_IP2_CMD_INFO_FULL_MASK                                                               0x00080000L
+#define VPEC_STATUS9__CE_IP2_CMD_INFO1_FULL_MASK                                                              0x00100000L
+#define VPEC_STATUS9__CE_IP3_AFIFO_FULL_MASK                                                                  0x00200000L
+#define VPEC_STATUS9__CE_IP3_CMD_INFO_FULL_MASK                                                               0x00400000L
+#define VPEC_STATUS9__CE_IP3_CMD_INFO1_FULL_MASK                                                              0x00800000L
+#define VPEC_STATUS9__CE_IP2_WR_STALL_MASK                                                                    0x01000000L
+#define VPEC_STATUS9__CE_IP3_WR_STALL_MASK                                                                    0x02000000L
+#define VPEC_STATUS9__CE_IP2_RD_STALL_MASK                                                                    0x04000000L
+#define VPEC_STATUS9__CE_IP3_RD_STALL_MASK                                                                    0x08000000L
+#define VPEC_STATUS9__RESERVED_31_28_MASK                                                                     0xF0000000L
+//VPEC_STATUS10
+#define VPEC_STATUS10__CE_OP0_WR_IDLE__SHIFT                                                                  0x0
+#define VPEC_STATUS10__CE_OP0_CMD_IDLE__SHIFT                                                                 0x1
+#define VPEC_STATUS10__CE_OP1_WR_IDLE__SHIFT                                                                  0x2
+#define VPEC_STATUS10__CE_OP1_CMD_IDLE__SHIFT                                                                 0x3
+#define VPEC_STATUS10__CE_OP2_WR_IDLE__SHIFT                                                                  0x4
+#define VPEC_STATUS10__CE_OP2_CMD_IDLE__SHIFT                                                                 0x5
+#define VPEC_STATUS10__CE_OP3_WR_IDLE__SHIFT                                                                  0x6
+#define VPEC_STATUS10__CE_OP3_CMD_IDLE__SHIFT                                                                 0x7
+#define VPEC_STATUS10__CE_OP4_WR_IDLE__SHIFT                                                                  0x8
+#define VPEC_STATUS10__CE_OP4_CMD_IDLE__SHIFT                                                                 0x9
+#define VPEC_STATUS10__CE_OP5_WR_IDLE__SHIFT                                                                  0xa
+#define VPEC_STATUS10__CE_OP5_CMD_IDLE__SHIFT                                                                 0xb
+#define VPEC_STATUS10__CE_OP6_WR_IDLE__SHIFT                                                                  0xc
+#define VPEC_STATUS10__CE_OP6_CMD_IDLE__SHIFT                                                                 0xd
+#define VPEC_STATUS10__CE_OP7_WR_IDLE__SHIFT                                                                  0xe
+#define VPEC_STATUS10__CE_OP7_CMD_IDLE__SHIFT                                                                 0xf
+#define VPEC_STATUS10__CE_OP8_WR_IDLE__SHIFT                                                                  0x10
+#define VPEC_STATUS10__CE_OP8_CMD_IDLE__SHIFT                                                                 0x11
+#define VPEC_STATUS10__CE_OP9_WR_IDLE__SHIFT                                                                  0x12
+#define VPEC_STATUS10__CE_OP9_CMD_IDLE__SHIFT                                                                 0x13
+#define VPEC_STATUS10__RESERVED_31_28__SHIFT                                                                  0x1c
+#define VPEC_STATUS10__CE_OP0_WR_IDLE_MASK                                                                    0x00000001L
+#define VPEC_STATUS10__CE_OP0_CMD_IDLE_MASK                                                                   0x00000002L
+#define VPEC_STATUS10__CE_OP1_WR_IDLE_MASK                                                                    0x00000004L
+#define VPEC_STATUS10__CE_OP1_CMD_IDLE_MASK                                                                   0x00000008L
+#define VPEC_STATUS10__CE_OP2_WR_IDLE_MASK                                                                    0x00000010L
+#define VPEC_STATUS10__CE_OP2_CMD_IDLE_MASK                                                                   0x00000020L
+#define VPEC_STATUS10__CE_OP3_WR_IDLE_MASK                                                                    0x00000040L
+#define VPEC_STATUS10__CE_OP3_CMD_IDLE_MASK                                                                   0x00000080L
+#define VPEC_STATUS10__CE_OP4_WR_IDLE_MASK                                                                    0x00000100L
+#define VPEC_STATUS10__CE_OP4_CMD_IDLE_MASK                                                                   0x00000200L
+#define VPEC_STATUS10__CE_OP5_WR_IDLE_MASK                                                                    0x00000400L
+#define VPEC_STATUS10__CE_OP5_CMD_IDLE_MASK                                                                   0x00000800L
+#define VPEC_STATUS10__CE_OP6_WR_IDLE_MASK                                                                    0x00001000L
+#define VPEC_STATUS10__CE_OP6_CMD_IDLE_MASK                                                                   0x00002000L
+#define VPEC_STATUS10__CE_OP7_WR_IDLE_MASK                                                                    0x00004000L
+#define VPEC_STATUS10__CE_OP7_CMD_IDLE_MASK                                                                   0x00008000L
+#define VPEC_STATUS10__CE_OP8_WR_IDLE_MASK                                                                    0x00010000L
+#define VPEC_STATUS10__CE_OP8_CMD_IDLE_MASK                                                                   0x00020000L
+#define VPEC_STATUS10__CE_OP9_WR_IDLE_MASK                                                                    0x00040000L
+#define VPEC_STATUS10__CE_OP9_CMD_IDLE_MASK                                                                   0x00080000L
+#define VPEC_STATUS10__RESERVED_31_28_MASK                                                                    0xF0000000L
+//VPEC_STATUS_DCC
+#define VPEC_STATUS_DCC__CE_IP0_MRQ_IDLE__SHIFT                                                               0x0
+#define VPEC_STATUS_DCC__CE_IP0_DCCP_IDLE__SHIFT                                                              0x1
+#define VPEC_STATUS_DCC__CE_IP0_DCC_RET_IDLE__SHIFT                                                           0x2
+#define VPEC_STATUS_DCC__CE_IP1_MRQ_IDLE__SHIFT                                                               0x3
+#define VPEC_STATUS_DCC__CE_IP1_DCCP_IDLE__SHIFT                                                              0x4
+#define VPEC_STATUS_DCC__CE_IP1_DCC_RET_IDLE__SHIFT                                                           0x5
+#define VPEC_STATUS_DCC__CE_IP2_MRQ_IDLE__SHIFT                                                               0x6
+#define VPEC_STATUS_DCC__CE_IP2_DCCP_IDLE__SHIFT                                                              0x7
+#define VPEC_STATUS_DCC__CE_IP2_DCC_RET_IDLE__SHIFT                                                           0x8
+#define VPEC_STATUS_DCC__CE_IP3_MRQ_IDLE__SHIFT                                                               0x9
+#define VPEC_STATUS_DCC__CE_IP3_DCCP_IDLE__SHIFT                                                              0xa
+#define VPEC_STATUS_DCC__CE_IP3_DCC_RET_IDLE__SHIFT                                                           0xb
+#define VPEC_STATUS_DCC__CE_IP4_MRQ_IDLE__SHIFT                                                               0xc
+#define VPEC_STATUS_DCC__CE_IP4_DCCP_IDLE__SHIFT                                                              0xd
+#define VPEC_STATUS_DCC__CE_IP4_DCC_RET_IDLE__SHIFT                                                           0xe
+#define VPEC_STATUS_DCC__CE_IP5_MRQ_IDLE__SHIFT                                                               0xf
+#define VPEC_STATUS_DCC__CE_IP5_DCCP_IDLE__SHIFT                                                              0x10
+#define VPEC_STATUS_DCC__CE_IP5_DCC_RET_IDLE__SHIFT                                                           0x11
+#define VPEC_STATUS_DCC__RESERVED_31_18__SHIFT                                                                0x12
+#define VPEC_STATUS_DCC__CE_IP0_MRQ_IDLE_MASK                                                                 0x00000001L
+#define VPEC_STATUS_DCC__CE_IP0_DCCP_IDLE_MASK                                                                0x00000002L
+#define VPEC_STATUS_DCC__CE_IP0_DCC_RET_IDLE_MASK                                                             0x00000004L
+#define VPEC_STATUS_DCC__CE_IP1_MRQ_IDLE_MASK                                                                 0x00000008L
+#define VPEC_STATUS_DCC__CE_IP1_DCCP_IDLE_MASK                                                                0x00000010L
+#define VPEC_STATUS_DCC__CE_IP1_DCC_RET_IDLE_MASK                                                             0x00000020L
+#define VPEC_STATUS_DCC__CE_IP2_MRQ_IDLE_MASK                                                                 0x00000040L
+#define VPEC_STATUS_DCC__CE_IP2_DCCP_IDLE_MASK                                                                0x00000080L
+#define VPEC_STATUS_DCC__CE_IP2_DCC_RET_IDLE_MASK                                                             0x00000100L
+#define VPEC_STATUS_DCC__CE_IP3_MRQ_IDLE_MASK                                                                 0x00000200L
+#define VPEC_STATUS_DCC__CE_IP3_DCCP_IDLE_MASK                                                                0x00000400L
+#define VPEC_STATUS_DCC__CE_IP3_DCC_RET_IDLE_MASK                                                             0x00000800L
+#define VPEC_STATUS_DCC__CE_IP4_MRQ_IDLE_MASK                                                                 0x00001000L
+#define VPEC_STATUS_DCC__CE_IP4_DCCP_IDLE_MASK                                                                0x00002000L
+#define VPEC_STATUS_DCC__CE_IP4_DCC_RET_IDLE_MASK                                                             0x00004000L
+#define VPEC_STATUS_DCC__CE_IP5_MRQ_IDLE_MASK                                                                 0x00008000L
+#define VPEC_STATUS_DCC__CE_IP5_DCCP_IDLE_MASK                                                                0x00010000L
+#define VPEC_STATUS_DCC__CE_IP5_DCC_RET_IDLE_MASK                                                             0x00020000L
+#define VPEC_STATUS_DCC__RESERVED_31_18_MASK                                                                  0xFFFC0000L
+//VPEC_STATUS11
+#define VPEC_STATUS11__CE_IP4_WREQ_IDLE__SHIFT                                                                0x0
+#define VPEC_STATUS11__CE_IP4_WR_IDLE__SHIFT                                                                  0x1
+#define VPEC_STATUS11__CE_IP4_SPLIT_RD_IDLE__SHIFT                                                            0x2
+#define VPEC_STATUS11__CE_IP4_SPLIT_WR_IDLE__SHIFT                                                            0x3
+#define VPEC_STATUS11__CE_IP4_RREQ_IDLE__SHIFT                                                                0x4
+#define VPEC_STATUS11__CE_IP4_OUT_IDLE__SHIFT                                                                 0x5
+#define VPEC_STATUS11__CE_IP4_IN_IDLE__SHIFT                                                                  0x6
+#define VPEC_STATUS11__CE_IP4_DST_IDLE__SHIFT                                                                 0x7
+#define VPEC_STATUS11__CE_IP4_CMD_IDLE__SHIFT                                                                 0x8
+#define VPEC_STATUS11__CE_IP5_WREQ_IDLE__SHIFT                                                                0x9
+#define VPEC_STATUS11__CE_IP5_WR_IDLE__SHIFT                                                                  0xa
+#define VPEC_STATUS11__CE_IP5_SPLIT_RD_IDLE__SHIFT                                                            0xb
+#define VPEC_STATUS11__CE_IP5_SPLIT_WR_IDLE__SHIFT                                                            0xc
+#define VPEC_STATUS11__CE_IP5_RREQ_IDLE__SHIFT                                                                0xd
+#define VPEC_STATUS11__CE_IP5_OUT_IDLE__SHIFT                                                                 0xe
+#define VPEC_STATUS11__CE_IP5_IN_IDLE__SHIFT                                                                  0xf
+#define VPEC_STATUS11__CE_IP5_DST_IDLE__SHIFT                                                                 0x10
+#define VPEC_STATUS11__CE_IP5_CMD_IDLE__SHIFT                                                                 0x11
+#define VPEC_STATUS11__CE_IP4_AFIFO_FULL__SHIFT                                                               0x12
+#define VPEC_STATUS11__CE_IP4_CMD_INFO_FULL__SHIFT                                                            0x13
+#define VPEC_STATUS11__CE_IP4_CMD_INFO1_FULL__SHIFT                                                           0x14
+#define VPEC_STATUS11__CE_IP5_AFIFO_FULL__SHIFT                                                               0x15
+#define VPEC_STATUS11__CE_IP5_CMD_INFO_FULL__SHIFT                                                            0x16
+#define VPEC_STATUS11__CE_IP5_CMD_INFO1_FULL__SHIFT                                                           0x17
+#define VPEC_STATUS11__CE_IP4_WR_STALL__SHIFT                                                                 0x18
+#define VPEC_STATUS11__CE_IP5_WR_STALL__SHIFT                                                                 0x19
+#define VPEC_STATUS11__CE_IP4_RD_STALL__SHIFT                                                                 0x1a
+#define VPEC_STATUS11__CE_IP5_RD_STALL__SHIFT                                                                 0x1b
+#define VPEC_STATUS11__RESERVED_31_28__SHIFT                                                                  0x1c
+#define VPEC_STATUS11__CE_IP4_WREQ_IDLE_MASK                                                                  0x00000001L
+#define VPEC_STATUS11__CE_IP4_WR_IDLE_MASK                                                                    0x00000002L
+#define VPEC_STATUS11__CE_IP4_SPLIT_RD_IDLE_MASK                                                              0x00000004L
+#define VPEC_STATUS11__CE_IP4_SPLIT_WR_IDLE_MASK                                                              0x00000008L
+#define VPEC_STATUS11__CE_IP4_RREQ_IDLE_MASK                                                                  0x00000010L
+#define VPEC_STATUS11__CE_IP4_OUT_IDLE_MASK                                                                   0x00000020L
+#define VPEC_STATUS11__CE_IP4_IN_IDLE_MASK                                                                    0x00000040L
+#define VPEC_STATUS11__CE_IP4_DST_IDLE_MASK                                                                   0x00000080L
+#define VPEC_STATUS11__CE_IP4_CMD_IDLE_MASK                                                                   0x00000100L
+#define VPEC_STATUS11__CE_IP5_WREQ_IDLE_MASK                                                                  0x00000200L
+#define VPEC_STATUS11__CE_IP5_WR_IDLE_MASK                                                                    0x00000400L
+#define VPEC_STATUS11__CE_IP5_SPLIT_RD_IDLE_MASK                                                              0x00000800L
+#define VPEC_STATUS11__CE_IP5_SPLIT_WR_IDLE_MASK                                                              0x00001000L
+#define VPEC_STATUS11__CE_IP5_RREQ_IDLE_MASK                                                                  0x00002000L
+#define VPEC_STATUS11__CE_IP5_OUT_IDLE_MASK                                                                   0x00004000L
+#define VPEC_STATUS11__CE_IP5_IN_IDLE_MASK                                                                    0x00008000L
+#define VPEC_STATUS11__CE_IP5_DST_IDLE_MASK                                                                   0x00010000L
+#define VPEC_STATUS11__CE_IP5_CMD_IDLE_MASK                                                                   0x00020000L
+#define VPEC_STATUS11__CE_IP4_AFIFO_FULL_MASK                                                                 0x00040000L
+#define VPEC_STATUS11__CE_IP4_CMD_INFO_FULL_MASK                                                              0x00080000L
+#define VPEC_STATUS11__CE_IP4_CMD_INFO1_FULL_MASK                                                             0x00100000L
+#define VPEC_STATUS11__CE_IP5_AFIFO_FULL_MASK                                                                 0x00200000L
+#define VPEC_STATUS11__CE_IP5_CMD_INFO_FULL_MASK                                                              0x00400000L
+#define VPEC_STATUS11__CE_IP5_CMD_INFO1_FULL_MASK                                                             0x00800000L
+#define VPEC_STATUS11__CE_IP4_WR_STALL_MASK                                                                   0x01000000L
+#define VPEC_STATUS11__CE_IP5_WR_STALL_MASK                                                                   0x02000000L
+#define VPEC_STATUS11__CE_IP4_RD_STALL_MASK                                                                   0x04000000L
+#define VPEC_STATUS11__CE_IP5_RD_STALL_MASK                                                                   0x08000000L
+#define VPEC_STATUS11__RESERVED_31_28_MASK                                                                    0xF0000000L
+//VPEC_INST
+#define VPEC_INST__ID__SHIFT                                                                                  0x0
+#define VPEC_INST__RESERVED__SHIFT                                                                            0x3
+#define VPEC_INST__ID_MASK                                                                                    0x00000007L
+#define VPEC_INST__RESERVED_MASK                                                                              0xFFFFFFF8L
+//VPEC_QUEUE_STATUS0
+#define VPEC_QUEUE_STATUS0__QUEUE0_STATUS__SHIFT                                                              0x0
+#define VPEC_QUEUE_STATUS0__QUEUE1_STATUS__SHIFT                                                              0x4
+#define VPEC_QUEUE_STATUS0__QUEUE2_STATUS__SHIFT                                                              0x8
+#define VPEC_QUEUE_STATUS0__QUEUE3_STATUS__SHIFT                                                              0xc
+#define VPEC_QUEUE_STATUS0__QUEUE4_STATUS__SHIFT                                                              0x10
+#define VPEC_QUEUE_STATUS0__QUEUE5_STATUS__SHIFT                                                              0x14
+#define VPEC_QUEUE_STATUS0__QUEUE6_STATUS__SHIFT                                                              0x18
+#define VPEC_QUEUE_STATUS0__QUEUE7_STATUS__SHIFT                                                              0x1c
+#define VPEC_QUEUE_STATUS0__QUEUE0_STATUS_MASK                                                                0x0000000FL
+#define VPEC_QUEUE_STATUS0__QUEUE1_STATUS_MASK                                                                0x000000F0L
+#define VPEC_QUEUE_STATUS0__QUEUE2_STATUS_MASK                                                                0x00000F00L
+#define VPEC_QUEUE_STATUS0__QUEUE3_STATUS_MASK                                                                0x0000F000L
+#define VPEC_QUEUE_STATUS0__QUEUE4_STATUS_MASK                                                                0x000F0000L
+#define VPEC_QUEUE_STATUS0__QUEUE5_STATUS_MASK                                                                0x00F00000L
+#define VPEC_QUEUE_STATUS0__QUEUE6_STATUS_MASK                                                                0x0F000000L
+#define VPEC_QUEUE_STATUS0__QUEUE7_STATUS_MASK                                                                0xF0000000L
+//VPEC_QUEUE_HANG_STATUS
+#define VPEC_QUEUE_HANG_STATUS__F30T0_HANG__SHIFT                                                             0x0
+#define VPEC_QUEUE_HANG_STATUS__CE_HANG__SHIFT                                                                0x1
+#define VPEC_QUEUE_HANG_STATUS__EOF_MISMATCH__SHIFT                                                           0x2
+#define VPEC_QUEUE_HANG_STATUS__INVALID_PKT_FIELD__SHIFT                                                      0x3
+#define VPEC_QUEUE_HANG_STATUS__INVALID_VPEP_CONFIG_ADDR__SHIFT                                               0x4
+#define VPEC_QUEUE_HANG_STATUS__F32_ACCESS_OFF_VPDPP1__SHIFT                                                  0x5
+#define VPEC_QUEUE_HANG_STATUS__RSMU_ACCESS_OFF_VPDPP1__SHIFT                                                 0x6
+#define VPEC_QUEUE_HANG_STATUS__EOH_MISMATCH__SHIFT                                                           0x7
+#define VPEC_QUEUE_HANG_STATUS__F30T0_HANG_MASK                                                               0x00000001L
+#define VPEC_QUEUE_HANG_STATUS__CE_HANG_MASK                                                                  0x00000002L
+#define VPEC_QUEUE_HANG_STATUS__EOF_MISMATCH_MASK                                                             0x00000004L
+#define VPEC_QUEUE_HANG_STATUS__INVALID_PKT_FIELD_MASK                                                        0x00000008L
+#define VPEC_QUEUE_HANG_STATUS__INVALID_VPEP_CONFIG_ADDR_MASK                                                 0x00000010L
+#define VPEC_QUEUE_HANG_STATUS__F32_ACCESS_OFF_VPDPP1_MASK                                                    0x00000020L
+#define VPEC_QUEUE_HANG_STATUS__RSMU_ACCESS_OFF_VPDPP1_MASK                                                   0x00000040L
+#define VPEC_QUEUE_HANG_STATUS__EOH_MISMATCH_MASK                                                             0x00000080L
+//VPEC_DPM_IDLE_TIME
+#define VPEC_DPM_IDLE_TIME__VALUE__SHIFT                                                                      0x0
+#define VPEC_DPM_IDLE_TIME__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_DPM_BUSY_TIME
+#define VPEC_DPM_BUSY_TIME__VALUE__SHIFT                                                                      0x0
+#define VPEC_DPM_BUSY_TIME__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_DPM_IDLE_START_LO
+#define VPEC_DPM_IDLE_START_LO__VALUE__SHIFT                                                                  0x0
+#define VPEC_DPM_IDLE_START_LO__VALUE_MASK                                                                    0xFFFFFFFFL
+//VPEC_DPM_IDLE_START_HI
+#define VPEC_DPM_IDLE_START_HI__VALUE__SHIFT                                                                  0x0
+#define VPEC_DPM_IDLE_START_HI__VALUE_MASK                                                                    0xFFFFFFFFL
+//VPEC_DPM_BUSY_START_LO
+#define VPEC_DPM_BUSY_START_LO__VALUE__SHIFT                                                                  0x0
+#define VPEC_DPM_BUSY_START_LO__VALUE_MASK                                                                    0xFFFFFFFFL
+//VPEC_DPM_BUSY_START_HI
+#define VPEC_DPM_BUSY_START_HI__VALUE__SHIFT                                                                  0x0
+#define VPEC_DPM_BUSY_START_HI__VALUE_MASK                                                                    0xFFFFFFFFL
+//VPEC_DPM_LAST_REQ_TIMESTAMP
+#define VPEC_DPM_LAST_REQ_TIMESTAMP__VALUE__SHIFT                                                             0x0
+#define VPEC_DPM_LAST_REQ_TIMESTAMP__VALUE_MASK                                                               0xFFFFFFFFL
+//VPEC_DPM_NEW_JOB_DUMMY3
+#define VPEC_DPM_NEW_JOB_DUMMY3__VALUE__SHIFT                                                                 0x0
+#define VPEC_DPM_NEW_JOB_DUMMY3__VALUE_MASK                                                                   0xFFFFFFFFL
+//VPEC_DPM_STATE
+#define VPEC_DPM_STATE__VALUE__SHIFT                                                                          0x0
+#define VPEC_DPM_STATE__VALUE_MASK                                                                            0xFFFFFFFFL
+//VPEC_DPM0_FREQ
+#define VPEC_DPM0_FREQ__VALUE__SHIFT                                                                          0x0
+#define VPEC_DPM0_FREQ__VALUE_MASK                                                                            0xFFFFFFFFL
+//VPEC_DPM1_FREQ
+#define VPEC_DPM1_FREQ__VALUE__SHIFT                                                                          0x0
+#define VPEC_DPM1_FREQ__VALUE_MASK                                                                            0xFFFFFFFFL
+//VPEC_DPM2_FREQ
+#define VPEC_DPM2_FREQ__VALUE__SHIFT                                                                          0x0
+#define VPEC_DPM2_FREQ__VALUE_MASK                                                                            0xFFFFFFFFL
+//VPEC_DPM3_FREQ
+#define VPEC_DPM3_FREQ__VALUE__SHIFT                                                                          0x0
+#define VPEC_DPM3_FREQ__VALUE_MASK                                                                            0xFFFFFFFFL
+//VPEC_DPM_THRESHOLD_SKIP
+#define VPEC_DPM_THRESHOLD_SKIP__VALUE__SHIFT                                                                 0x0
+#define VPEC_DPM_THRESHOLD_SKIP__VALUE_MASK                                                                   0xFFFFFFFFL
+//VPEC_DPM_THRESHOLD_BUSY_OVERFLOW
+#define VPEC_DPM_THRESHOLD_BUSY_OVERFLOW__VALUE__SHIFT                                                        0x0
+#define VPEC_DPM_THRESHOLD_BUSY_OVERFLOW__VALUE_MASK                                                          0xFFFFFFFFL
+//VPEC_DPM_CALC_BUSY_IN_POSTPROCESS
+#define VPEC_DPM_CALC_BUSY_IN_POSTPROCESS__VALUE__SHIFT                                                       0x0
+#define VPEC_DPM_CALC_BUSY_IN_POSTPROCESS__VALUE_MASK                                                         0xFFFFFFFFL
+//VPEC_DPM_IN_CHECKIDLE_LOOP
+#define VPEC_DPM_IN_CHECKIDLE_LOOP__VALUE__SHIFT                                                              0x0
+#define VPEC_DPM_IN_CHECKIDLE_LOOP__VALUE_MASK                                                                0xFFFFFFFFL
+//VPEC_DPM_THRESHOLD_IDLE_OVERFLOW
+#define VPEC_DPM_THRESHOLD_IDLE_OVERFLOW__VALUE__SHIFT                                                        0x0
+#define VPEC_DPM_THRESHOLD_IDLE_OVERFLOW__VALUE_MASK                                                          0xFFFFFFFFL
+//VPEC_DPM_BUSY_CLAMP_COUNT
+#define VPEC_DPM_BUSY_CLAMP_COUNT__VALUE__SHIFT                                                               0x0
+#define VPEC_DPM_BUSY_CLAMP_COUNT__VALUE_MASK                                                                 0xFFFFFFFFL
+//VPEC_DPM_IDLE_CLAMP_COUNT
+#define VPEC_DPM_IDLE_CLAMP_COUNT__VALUE__SHIFT                                                               0x0
+#define VPEC_DPM_IDLE_CLAMP_COUNT__VALUE_MASK                                                                 0xFFFFFFFFL
+//VPEC_PG_CNTL
+#define VPEC_PG_CNTL__PG_EN__SHIFT                                                                            0x0
+#define VPEC_PG_CNTL__PG_HYSTERESIS__SHIFT                                                                    0x1
+#define VPEC_PG_CNTL__PG1_EN__SHIFT                                                                           0x8
+#define VPEC_PG_CNTL__PG1_HYSTERESIS__SHIFT                                                                   0x9
+#define VPEC_PG_CNTL__ZSTATES_ENABLE__SHIFT                                                                   0x10
+#define VPEC_PG_CNTL__ZSTATES_HYSTERESIS__SHIFT                                                               0x11
+#define VPEC_PG_CNTL__FENCE_HYSTERESIS__SHIFT                                                                 0x18
+#define VPEC_PG_CNTL__CHECK_RSMU_UPON_POWER_UP__SHIFT                                                         0x1c
+#define VPEC_PG_CNTL__PG_EN_MASK                                                                              0x00000001L
+#define VPEC_PG_CNTL__PG_HYSTERESIS_MASK                                                                      0x0000003EL
+#define VPEC_PG_CNTL__PG1_EN_MASK                                                                             0x00000100L
+#define VPEC_PG_CNTL__PG1_HYSTERESIS_MASK                                                                     0x00003E00L
+#define VPEC_PG_CNTL__ZSTATES_ENABLE_MASK                                                                     0x00010000L
+#define VPEC_PG_CNTL__ZSTATES_HYSTERESIS_MASK                                                                 0x003E0000L
+#define VPEC_PG_CNTL__FENCE_HYSTERESIS_MASK                                                                   0x0F000000L
+#define VPEC_PG_CNTL__CHECK_RSMU_UPON_POWER_UP_MASK                                                           0x10000000L
+//VPEC_PG_STATUS
+#define VPEC_PG_STATUS__PG_STATUS__SHIFT                                                                      0x0
+#define VPEC_PG_STATUS__PG1_STATUS__SHIFT                                                                     0x2
+#define VPEC_PG_STATUS__PG_STATUS_MASK                                                                        0x00000003L
+#define VPEC_PG_STATUS__PG1_STATUS_MASK                                                                       0x0000000CL
+//VPEC_CLOCK_GATING_STATUS
+#define VPEC_CLOCK_GATING_STATUS__DYN_CLK_GATE_STATUS__SHIFT                                                  0x0
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE0_CLK_GATE_STATUS__SHIFT                                             0x2
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE1_CLK_GATE_STATUS__SHIFT                                             0x3
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE2_CLK_GATE_STATUS__SHIFT                                             0x4
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE3_CLK_GATE_STATUS__SHIFT                                             0x5
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE0_CLK_GATE_STATUS__SHIFT                                             0x6
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE1_CLK_GATE_STATUS__SHIFT                                             0x7
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE2_CLK_GATE_STATUS__SHIFT                                             0x8
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE3_CLK_GATE_STATUS__SHIFT                                             0x9
+#define VPEC_CLOCK_GATING_STATUS__REG_CLK_GATE_STATUS__SHIFT                                                  0xa
+#define VPEC_CLOCK_GATING_STATUS__F32_CLK_GATE_STATUS__SHIFT                                                  0xb
+#define VPEC_CLOCK_GATING_STATUS__USRAM_CLK_GATE_STATUS__SHIFT                                                0xc
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE4_CLK_GATE_STATUS__SHIFT                                             0xd
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE5_CLK_GATE_STATUS__SHIFT                                             0xe
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE6_CLK_GATE_STATUS__SHIFT                                             0xf
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE7_CLK_GATE_STATUS__SHIFT                                             0x10
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE4_CLK_GATE_STATUS__SHIFT                                             0x11
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE5_CLK_GATE_STATUS__SHIFT                                             0x12
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE8_CLK_GATE_STATUS__SHIFT                                             0x13
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE9_CLK_GATE_STATUS__SHIFT                                             0x14
+#define VPEC_CLOCK_GATING_STATUS__DYN_CLK_GATE_STATUS_MASK                                                    0x00000001L
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE0_CLK_GATE_STATUS_MASK                                               0x00000004L
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE1_CLK_GATE_STATUS_MASK                                               0x00000008L
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE2_CLK_GATE_STATUS_MASK                                               0x00000010L
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE3_CLK_GATE_STATUS_MASK                                               0x00000020L
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE0_CLK_GATE_STATUS_MASK                                               0x00000040L
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE1_CLK_GATE_STATUS_MASK                                               0x00000080L
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE2_CLK_GATE_STATUS_MASK                                               0x00000100L
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE3_CLK_GATE_STATUS_MASK                                               0x00000200L
+#define VPEC_CLOCK_GATING_STATUS__REG_CLK_GATE_STATUS_MASK                                                    0x00000400L
+#define VPEC_CLOCK_GATING_STATUS__F32_CLK_GATE_STATUS_MASK                                                    0x00000800L
+#define VPEC_CLOCK_GATING_STATUS__USRAM_CLK_GATE_STATUS_MASK                                                  0x00001000L
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE4_CLK_GATE_STATUS_MASK                                               0x00002000L
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE5_CLK_GATE_STATUS_MASK                                               0x00004000L
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE6_CLK_GATE_STATUS_MASK                                               0x00008000L
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE7_CLK_GATE_STATUS_MASK                                               0x00010000L
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE4_CLK_GATE_STATUS_MASK                                               0x00020000L
+#define VPEC_CLOCK_GATING_STATUS__IP_PIPE5_CLK_GATE_STATUS_MASK                                               0x00040000L
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE8_CLK_GATE_STATUS_MASK                                               0x00080000L
+#define VPEC_CLOCK_GATING_STATUS__OP_PIPE9_CLK_GATE_STATUS_MASK                                               0x00100000L
+//VPEC_QUEUE0_RB_CNTL
+#define VPEC_QUEUE0_RB_CNTL__RB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE0_RB_CNTL__RB_SIZE__SHIFT                                                                   0x1
+#define VPEC_QUEUE0_RB_CNTL__WPTR_POLL_ENABLE__SHIFT                                                          0x8
+#define VPEC_QUEUE0_RB_CNTL__RB_SWAP_ENABLE__SHIFT                                                            0x9
+#define VPEC_QUEUE0_RB_CNTL__WPTR_POLL_SWAP_ENABLE__SHIFT                                                     0xa
+#define VPEC_QUEUE0_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT                                                      0xb
+#define VPEC_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                     0xc
+#define VPEC_QUEUE0_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                                0xd
+#define VPEC_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                      0x10
+#define VPEC_QUEUE0_RB_CNTL__RB_PRIV__SHIFT                                                                   0x17
+#define VPEC_QUEUE0_RB_CNTL__RB_VMID__SHIFT                                                                   0x18
+#define VPEC_QUEUE0_RB_CNTL__RB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE0_RB_CNTL__RB_SIZE_MASK                                                                     0x0000003EL
+#define VPEC_QUEUE0_RB_CNTL__WPTR_POLL_ENABLE_MASK                                                            0x00000100L
+#define VPEC_QUEUE0_RB_CNTL__RB_SWAP_ENABLE_MASK                                                              0x00000200L
+#define VPEC_QUEUE0_RB_CNTL__WPTR_POLL_SWAP_ENABLE_MASK                                                       0x00000400L
+#define VPEC_QUEUE0_RB_CNTL__F32_WPTR_POLL_ENABLE_MASK                                                        0x00000800L
+#define VPEC_QUEUE0_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                       0x00001000L
+#define VPEC_QUEUE0_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                  0x00002000L
+#define VPEC_QUEUE0_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                        0x001F0000L
+#define VPEC_QUEUE0_RB_CNTL__RB_PRIV_MASK                                                                     0x00800000L
+#define VPEC_QUEUE0_RB_CNTL__RB_VMID_MASK                                                                     0x0F000000L
+//VPEC_QUEUE0_SCHEDULE_CNTL
+#define VPEC_QUEUE0_SCHEDULE_CNTL__GLOBAL_ID__SHIFT                                                           0x0
+#define VPEC_QUEUE0_SCHEDULE_CNTL__PROCESS_ID__SHIFT                                                          0x2
+#define VPEC_QUEUE0_SCHEDULE_CNTL__LOCAL_ID__SHIFT                                                            0x6
+#define VPEC_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT                                                     0x8
+#define VPEC_QUEUE0_SCHEDULE_CNTL__GLOBAL_ID_MASK                                                             0x00000003L
+#define VPEC_QUEUE0_SCHEDULE_CNTL__PROCESS_ID_MASK                                                            0x0000001CL
+#define VPEC_QUEUE0_SCHEDULE_CNTL__LOCAL_ID_MASK                                                              0x000000C0L
+#define VPEC_QUEUE0_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK                                                       0x0000FF00L
+//VPEC_QUEUE0_RB_BASE
+#define VPEC_QUEUE0_RB_BASE__ADDR__SHIFT                                                                      0x0
+#define VPEC_QUEUE0_RB_BASE__ADDR_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE0_RB_BASE_HI
+#define VPEC_QUEUE0_RB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE0_RB_BASE_HI__ADDR_MASK                                                                     0x00FFFFFFL
+//VPEC_QUEUE0_RB_RPTR
+#define VPEC_QUEUE0_RB_RPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE0_RB_RPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE0_RB_RPTR_HI
+#define VPEC_QUEUE0_RB_RPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE0_RB_RPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE0_RB_WPTR
+#define VPEC_QUEUE0_RB_WPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE0_RB_WPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE0_RB_WPTR_HI
+#define VPEC_QUEUE0_RB_WPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE0_RB_WPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE0_RB_RPTR_ADDR_HI
+#define VPEC_QUEUE0_RB_RPTR_ADDR_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE0_RB_RPTR_ADDR_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE0_RB_RPTR_ADDR_LO
+#define VPEC_QUEUE0_RB_RPTR_ADDR_LO__ADDR__SHIFT                                                              0x2
+#define VPEC_QUEUE0_RB_RPTR_ADDR_LO__ADDR_MASK                                                                0xFFFFFFFCL
+//VPEC_QUEUE0_RB_AQL_CNTL
+#define VPEC_QUEUE0_RB_AQL_CNTL__AQL_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE0_RB_AQL_CNTL__AQL_PACKET_SIZE__SHIFT                                                       0x1
+#define VPEC_QUEUE0_RB_AQL_CNTL__PACKET_STEP__SHIFT                                                           0x8
+#define VPEC_QUEUE0_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE__SHIFT                                                 0x10
+#define VPEC_QUEUE0_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE__SHIFT                                           0x11
+#define VPEC_QUEUE0_RB_AQL_CNTL__OVERLAP_ENABLE__SHIFT                                                        0x12
+#define VPEC_QUEUE0_RB_AQL_CNTL__AQL_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE0_RB_AQL_CNTL__AQL_PACKET_SIZE_MASK                                                         0x000000FEL
+#define VPEC_QUEUE0_RB_AQL_CNTL__PACKET_STEP_MASK                                                             0x0000FF00L
+#define VPEC_QUEUE0_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE_MASK                                                   0x00010000L
+#define VPEC_QUEUE0_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE_MASK                                             0x00020000L
+#define VPEC_QUEUE0_RB_AQL_CNTL__OVERLAP_ENABLE_MASK                                                          0x00040000L
+//VPEC_QUEUE0_MINOR_PTR_UPDATE
+#define VPEC_QUEUE0_MINOR_PTR_UPDATE__ENABLE__SHIFT                                                           0x0
+#define VPEC_QUEUE0_MINOR_PTR_UPDATE__ENABLE_MASK                                                             0x00000001L
+//VPEC_QUEUE0_CD_INFO
+#define VPEC_QUEUE0_CD_INFO__CD_INFO__SHIFT                                                                   0x0
+#define VPEC_QUEUE0_CD_INFO__CD_INFO_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE0_RB_PREEMPT
+#define VPEC_QUEUE0_RB_PREEMPT__PREEMPT_REQ__SHIFT                                                            0x0
+#define VPEC_QUEUE0_RB_PREEMPT__PREEMPT_REQ_MASK                                                              0x00000001L
+//VPEC_QUEUE0_SKIP_CNTL
+#define VPEC_QUEUE0_SKIP_CNTL__SKIP_COUNT__SHIFT                                                              0x0
+#define VPEC_QUEUE0_SKIP_CNTL__SKIP_COUNT_MASK                                                                0x000FFFFFL
+//VPEC_QUEUE0_DOORBELL
+#define VPEC_QUEUE0_DOORBELL__ENABLE__SHIFT                                                                   0x1c
+#define VPEC_QUEUE0_DOORBELL__CAPTURED__SHIFT                                                                 0x1e
+#define VPEC_QUEUE0_DOORBELL__ENABLE_MASK                                                                     0x10000000L
+#define VPEC_QUEUE0_DOORBELL__CAPTURED_MASK                                                                   0x40000000L
+//VPEC_QUEUE0_DOORBELL_OFFSET
+#define VPEC_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT                                                            0x2
+#define VPEC_QUEUE0_DOORBELL_OFFSET__OFFSET_MASK                                                              0x0FFFFFFCL
+//VPEC_QUEUE0_DUMMY0
+#define VPEC_QUEUE0_DUMMY0__DUMMY__SHIFT                                                                      0x0
+#define VPEC_QUEUE0_DUMMY0__DUMMY_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE0_DUMMY1
+#define VPEC_QUEUE0_DUMMY1__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE0_DUMMY1__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE0_DUMMY2
+#define VPEC_QUEUE0_DUMMY2__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE0_DUMMY2__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE0_DUMMY3
+#define VPEC_QUEUE0_DUMMY3__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE0_DUMMY3__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE0_DUMMY4
+#define VPEC_QUEUE0_DUMMY4__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE0_DUMMY4__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE0_IB_CNTL
+#define VPEC_QUEUE0_IB_CNTL__IB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                          0x8
+#define VPEC_QUEUE0_IB_CNTL__CMD_VMID__SHIFT                                                                  0x10
+#define VPEC_QUEUE0_IB_CNTL__IB_PRIV__SHIFT                                                                   0x1f
+#define VPEC_QUEUE0_IB_CNTL__IB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE0_IB_CNTL__SWITCH_INSIDE_IB_MASK                                                            0x00000100L
+#define VPEC_QUEUE0_IB_CNTL__CMD_VMID_MASK                                                                    0x000F0000L
+#define VPEC_QUEUE0_IB_CNTL__IB_PRIV_MASK                                                                     0x80000000L
+//VPEC_QUEUE0_IB_RPTR
+#define VPEC_QUEUE0_IB_RPTR__OFFSET__SHIFT                                                                    0x2
+#define VPEC_QUEUE0_IB_RPTR__OFFSET_MASK                                                                      0x003FFFFCL
+//VPEC_QUEUE0_IB_OFFSET
+#define VPEC_QUEUE0_IB_OFFSET__OFFSET__SHIFT                                                                  0x2
+#define VPEC_QUEUE0_IB_OFFSET__OFFSET_MASK                                                                    0x003FFFFCL
+//VPEC_QUEUE0_IB_BASE_LO
+#define VPEC_QUEUE0_IB_BASE_LO__ADDR__SHIFT                                                                   0x5
+#define VPEC_QUEUE0_IB_BASE_LO__ADDR_MASK                                                                     0xFFFFFFE0L
+//VPEC_QUEUE0_IB_BASE_HI
+#define VPEC_QUEUE0_IB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE0_IB_BASE_HI__ADDR_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE0_IB_SIZE
+#define VPEC_QUEUE0_IB_SIZE__SIZE__SHIFT                                                                      0x0
+#define VPEC_QUEUE0_IB_SIZE__SIZE_MASK                                                                        0x000FFFFFL
+//VPEC_QUEUE0_CMDIB_CNTL
+#define VPEC_QUEUE0_CMDIB_CNTL__IB_ENABLE__SHIFT                                                              0x0
+#define VPEC_QUEUE0_CMDIB_CNTL__IB_SWAP_ENABLE__SHIFT                                                         0x4
+#define VPEC_QUEUE0_CMDIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                       0x8
+#define VPEC_QUEUE0_CMDIB_CNTL__CMD_VMID__SHIFT                                                               0x10
+#define VPEC_QUEUE0_CMDIB_CNTL__IB_PRIV__SHIFT                                                                0x1f
+#define VPEC_QUEUE0_CMDIB_CNTL__IB_ENABLE_MASK                                                                0x00000001L
+#define VPEC_QUEUE0_CMDIB_CNTL__IB_SWAP_ENABLE_MASK                                                           0x00000010L
+#define VPEC_QUEUE0_CMDIB_CNTL__SWITCH_INSIDE_IB_MASK                                                         0x00000100L
+#define VPEC_QUEUE0_CMDIB_CNTL__CMD_VMID_MASK                                                                 0x000F0000L
+#define VPEC_QUEUE0_CMDIB_CNTL__IB_PRIV_MASK                                                                  0x80000000L
+//VPEC_QUEUE0_CMDIB_RPTR
+#define VPEC_QUEUE0_CMDIB_RPTR__OFFSET__SHIFT                                                                 0x2
+#define VPEC_QUEUE0_CMDIB_RPTR__OFFSET_MASK                                                                   0x003FFFFCL
+//VPEC_QUEUE0_CMDIB_OFFSET
+#define VPEC_QUEUE0_CMDIB_OFFSET__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE0_CMDIB_OFFSET__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE0_CMDIB_BASE_LO
+#define VPEC_QUEUE0_CMDIB_BASE_LO__ADDR__SHIFT                                                                0x5
+#define VPEC_QUEUE0_CMDIB_BASE_LO__ADDR_MASK                                                                  0xFFFFFFE0L
+//VPEC_QUEUE0_CMDIB_BASE_HI
+#define VPEC_QUEUE0_CMDIB_BASE_HI__ADDR__SHIFT                                                                0x0
+#define VPEC_QUEUE0_CMDIB_BASE_HI__ADDR_MASK                                                                  0xFFFFFFFFL
+//VPEC_QUEUE0_CMDIB_SIZE
+#define VPEC_QUEUE0_CMDIB_SIZE__SIZE__SHIFT                                                                   0x0
+#define VPEC_QUEUE0_CMDIB_SIZE__SIZE_MASK                                                                     0x000FFFFFL
+//VPEC_QUEUE0_3DLUTIB_CNTL
+#define VPEC_QUEUE0_3DLUTIB_CNTL__IB_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE0_3DLUTIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                     0x8
+#define VPEC_QUEUE0_3DLUTIB_CNTL__CMD_VMID__SHIFT                                                             0x10
+#define VPEC_QUEUE0_3DLUTIB_CNTL__IB_PRIV__SHIFT                                                              0x1f
+#define VPEC_QUEUE0_3DLUTIB_CNTL__IB_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE0_3DLUTIB_CNTL__SWITCH_INSIDE_IB_MASK                                                       0x00000100L
+#define VPEC_QUEUE0_3DLUTIB_CNTL__CMD_VMID_MASK                                                               0x000F0000L
+#define VPEC_QUEUE0_3DLUTIB_CNTL__IB_PRIV_MASK                                                                0x80000000L
+//VPEC_QUEUE0_3DLUTIB_RPTR
+#define VPEC_QUEUE0_3DLUTIB_RPTR__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE0_3DLUTIB_RPTR__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE0_3DLUTIB_OFFSET
+#define VPEC_QUEUE0_3DLUTIB_OFFSET__OFFSET__SHIFT                                                             0x2
+#define VPEC_QUEUE0_3DLUTIB_OFFSET__OFFSET_MASK                                                               0x003FFFFCL
+//VPEC_QUEUE0_3DLUTIB_BASE_LO
+#define VPEC_QUEUE0_3DLUTIB_BASE_LO__ADDR__SHIFT                                                              0x5
+#define VPEC_QUEUE0_3DLUTIB_BASE_LO__ADDR_MASK                                                                0xFFFFFFE0L
+//VPEC_QUEUE0_3DLUTIB_BASE_HI
+#define VPEC_QUEUE0_3DLUTIB_BASE_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE0_3DLUTIB_BASE_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE0_3DLUTIB_SIZE
+#define VPEC_QUEUE0_3DLUTIB_SIZE__SIZE__SHIFT                                                                 0x0
+#define VPEC_QUEUE0_3DLUTIB_SIZE__SIZE_MASK                                                                   0x000FFFFFL
+//VPEC_QUEUE0_CSA_ADDR_LO
+#define VPEC_QUEUE0_CSA_ADDR_LO__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE0_CSA_ADDR_LO__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE0_CSA_ADDR_HI
+#define VPEC_QUEUE0_CSA_ADDR_HI__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE0_CSA_ADDR_HI__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE0_CONTEXT_STATUS
+#define VPEC_QUEUE0_CONTEXT_STATUS__SELECTED__SHIFT                                                           0x0
+#define VPEC_QUEUE0_CONTEXT_STATUS__USE_IB__SHIFT                                                             0x1
+#define VPEC_QUEUE0_CONTEXT_STATUS__IDLE__SHIFT                                                               0x2
+#define VPEC_QUEUE0_CONTEXT_STATUS__EXPIRED__SHIFT                                                            0x3
+#define VPEC_QUEUE0_CONTEXT_STATUS__EXCEPTION__SHIFT                                                          0x4
+#define VPEC_QUEUE0_CONTEXT_STATUS__CTXSW_ABLE__SHIFT                                                         0x7
+#define VPEC_QUEUE0_CONTEXT_STATUS__USE_3DLUTIB__SHIFT                                                        0x8
+#define VPEC_QUEUE0_CONTEXT_STATUS__PREEMPT_DISABLE__SHIFT                                                    0xa
+#define VPEC_QUEUE0_CONTEXT_STATUS__RPTR_WB_IDLE__SHIFT                                                       0xb
+#define VPEC_QUEUE0_CONTEXT_STATUS__WPTR_UPDATE_PENDING__SHIFT                                                0xc
+#define VPEC_QUEUE0_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT__SHIFT                                             0x10
+#define VPEC_QUEUE0_CONTEXT_STATUS__SELECTED_MASK                                                             0x00000001L
+#define VPEC_QUEUE0_CONTEXT_STATUS__USE_IB_MASK                                                               0x00000002L
+#define VPEC_QUEUE0_CONTEXT_STATUS__IDLE_MASK                                                                 0x00000004L
+#define VPEC_QUEUE0_CONTEXT_STATUS__EXPIRED_MASK                                                              0x00000008L
+#define VPEC_QUEUE0_CONTEXT_STATUS__EXCEPTION_MASK                                                            0x00000070L
+#define VPEC_QUEUE0_CONTEXT_STATUS__CTXSW_ABLE_MASK                                                           0x00000080L
+#define VPEC_QUEUE0_CONTEXT_STATUS__USE_3DLUTIB_MASK                                                          0x00000100L
+#define VPEC_QUEUE0_CONTEXT_STATUS__PREEMPT_DISABLE_MASK                                                      0x00000400L
+#define VPEC_QUEUE0_CONTEXT_STATUS__RPTR_WB_IDLE_MASK                                                         0x00000800L
+#define VPEC_QUEUE0_CONTEXT_STATUS__WPTR_UPDATE_PENDING_MASK                                                  0x00001000L
+#define VPEC_QUEUE0_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT_MASK                                               0x00FF0000L
+//VPEC_QUEUE0_DOORBELL_LOG
+#define VPEC_QUEUE0_DOORBELL_LOG__BE_ERROR__SHIFT                                                             0x0
+#define VPEC_QUEUE0_DOORBELL_LOG__DATA__SHIFT                                                                 0x2
+#define VPEC_QUEUE0_DOORBELL_LOG__BE_ERROR_MASK                                                               0x00000001L
+#define VPEC_QUEUE0_DOORBELL_LOG__DATA_MASK                                                                   0xFFFFFFFCL
+//VPEC_QUEUE0_IB_SUB_REMAIN
+#define VPEC_QUEUE0_IB_SUB_REMAIN__SIZE__SHIFT                                                                0x0
+#define VPEC_QUEUE0_IB_SUB_REMAIN__SIZE_MASK                                                                  0x00003FFFL
+//VPEC_QUEUE0_PREEMPT
+#define VPEC_QUEUE0_PREEMPT__IB_PREEMPT__SHIFT                                                                0x0
+#define VPEC_QUEUE0_PREEMPT__IB_PREEMPT_MASK                                                                  0x00000001L
+//VPEC_QUEUE0_LOG0BUFFER_CFG
+#define VPEC_QUEUE0_LOG0BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE0_LOG0BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE0_LOG0BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE0_LOG0BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE0_LOG0BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE0_LOG0BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE0_LOG0BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE0_LOG0BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE0_LOG1BUFFER_CFG
+#define VPEC_QUEUE0_LOG1BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE0_LOG1BUFFER_CFG__PARTIAL_ENTRY__SHIFT                                                      0x1
+#define VPEC_QUEUE0_LOG1BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE0_LOG1BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE0_LOG1BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE0_LOG1BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE0_LOG1BUFFER_CFG__PARTIAL_ENTRY_MASK                                                        0x00000002L
+#define VPEC_QUEUE0_LOG1BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE0_LOG1BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE0_LOG1BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE1_RB_CNTL
+#define VPEC_QUEUE1_RB_CNTL__RB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE1_RB_CNTL__RB_SIZE__SHIFT                                                                   0x1
+#define VPEC_QUEUE1_RB_CNTL__WPTR_POLL_ENABLE__SHIFT                                                          0x8
+#define VPEC_QUEUE1_RB_CNTL__RB_SWAP_ENABLE__SHIFT                                                            0x9
+#define VPEC_QUEUE1_RB_CNTL__WPTR_POLL_SWAP_ENABLE__SHIFT                                                     0xa
+#define VPEC_QUEUE1_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT                                                      0xb
+#define VPEC_QUEUE1_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                     0xc
+#define VPEC_QUEUE1_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                                0xd
+#define VPEC_QUEUE1_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                      0x10
+#define VPEC_QUEUE1_RB_CNTL__RB_PRIV__SHIFT                                                                   0x17
+#define VPEC_QUEUE1_RB_CNTL__RB_VMID__SHIFT                                                                   0x18
+#define VPEC_QUEUE1_RB_CNTL__RB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE1_RB_CNTL__RB_SIZE_MASK                                                                     0x0000003EL
+#define VPEC_QUEUE1_RB_CNTL__WPTR_POLL_ENABLE_MASK                                                            0x00000100L
+#define VPEC_QUEUE1_RB_CNTL__RB_SWAP_ENABLE_MASK                                                              0x00000200L
+#define VPEC_QUEUE1_RB_CNTL__WPTR_POLL_SWAP_ENABLE_MASK                                                       0x00000400L
+#define VPEC_QUEUE1_RB_CNTL__F32_WPTR_POLL_ENABLE_MASK                                                        0x00000800L
+#define VPEC_QUEUE1_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                       0x00001000L
+#define VPEC_QUEUE1_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                  0x00002000L
+#define VPEC_QUEUE1_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                        0x001F0000L
+#define VPEC_QUEUE1_RB_CNTL__RB_PRIV_MASK                                                                     0x00800000L
+#define VPEC_QUEUE1_RB_CNTL__RB_VMID_MASK                                                                     0x0F000000L
+//VPEC_QUEUE1_SCHEDULE_CNTL
+#define VPEC_QUEUE1_SCHEDULE_CNTL__GLOBAL_ID__SHIFT                                                           0x0
+#define VPEC_QUEUE1_SCHEDULE_CNTL__PROCESS_ID__SHIFT                                                          0x2
+#define VPEC_QUEUE1_SCHEDULE_CNTL__LOCAL_ID__SHIFT                                                            0x6
+#define VPEC_QUEUE1_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT                                                     0x8
+#define VPEC_QUEUE1_SCHEDULE_CNTL__GLOBAL_ID_MASK                                                             0x00000003L
+#define VPEC_QUEUE1_SCHEDULE_CNTL__PROCESS_ID_MASK                                                            0x0000001CL
+#define VPEC_QUEUE1_SCHEDULE_CNTL__LOCAL_ID_MASK                                                              0x000000C0L
+#define VPEC_QUEUE1_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK                                                       0x0000FF00L
+//VPEC_QUEUE1_RB_BASE
+#define VPEC_QUEUE1_RB_BASE__ADDR__SHIFT                                                                      0x0
+#define VPEC_QUEUE1_RB_BASE__ADDR_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE1_RB_BASE_HI
+#define VPEC_QUEUE1_RB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE1_RB_BASE_HI__ADDR_MASK                                                                     0x00FFFFFFL
+//VPEC_QUEUE1_RB_RPTR
+#define VPEC_QUEUE1_RB_RPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE1_RB_RPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE1_RB_RPTR_HI
+#define VPEC_QUEUE1_RB_RPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE1_RB_RPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE1_RB_WPTR
+#define VPEC_QUEUE1_RB_WPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE1_RB_WPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE1_RB_WPTR_HI
+#define VPEC_QUEUE1_RB_WPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE1_RB_WPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE1_RB_RPTR_ADDR_HI
+#define VPEC_QUEUE1_RB_RPTR_ADDR_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE1_RB_RPTR_ADDR_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE1_RB_RPTR_ADDR_LO
+#define VPEC_QUEUE1_RB_RPTR_ADDR_LO__ADDR__SHIFT                                                              0x2
+#define VPEC_QUEUE1_RB_RPTR_ADDR_LO__ADDR_MASK                                                                0xFFFFFFFCL
+//VPEC_QUEUE1_RB_AQL_CNTL
+#define VPEC_QUEUE1_RB_AQL_CNTL__AQL_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE1_RB_AQL_CNTL__AQL_PACKET_SIZE__SHIFT                                                       0x1
+#define VPEC_QUEUE1_RB_AQL_CNTL__PACKET_STEP__SHIFT                                                           0x8
+#define VPEC_QUEUE1_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE__SHIFT                                                 0x10
+#define VPEC_QUEUE1_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE__SHIFT                                           0x11
+#define VPEC_QUEUE1_RB_AQL_CNTL__OVERLAP_ENABLE__SHIFT                                                        0x12
+#define VPEC_QUEUE1_RB_AQL_CNTL__AQL_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE1_RB_AQL_CNTL__AQL_PACKET_SIZE_MASK                                                         0x000000FEL
+#define VPEC_QUEUE1_RB_AQL_CNTL__PACKET_STEP_MASK                                                             0x0000FF00L
+#define VPEC_QUEUE1_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE_MASK                                                   0x00010000L
+#define VPEC_QUEUE1_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE_MASK                                             0x00020000L
+#define VPEC_QUEUE1_RB_AQL_CNTL__OVERLAP_ENABLE_MASK                                                          0x00040000L
+//VPEC_QUEUE1_MINOR_PTR_UPDATE
+#define VPEC_QUEUE1_MINOR_PTR_UPDATE__ENABLE__SHIFT                                                           0x0
+#define VPEC_QUEUE1_MINOR_PTR_UPDATE__ENABLE_MASK                                                             0x00000001L
+//VPEC_QUEUE1_CD_INFO
+#define VPEC_QUEUE1_CD_INFO__CD_INFO__SHIFT                                                                   0x0
+#define VPEC_QUEUE1_CD_INFO__CD_INFO_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE1_RB_PREEMPT
+#define VPEC_QUEUE1_RB_PREEMPT__PREEMPT_REQ__SHIFT                                                            0x0
+#define VPEC_QUEUE1_RB_PREEMPT__PREEMPT_REQ_MASK                                                              0x00000001L
+//VPEC_QUEUE1_SKIP_CNTL
+#define VPEC_QUEUE1_SKIP_CNTL__SKIP_COUNT__SHIFT                                                              0x0
+#define VPEC_QUEUE1_SKIP_CNTL__SKIP_COUNT_MASK                                                                0x000FFFFFL
+//VPEC_QUEUE1_DOORBELL
+#define VPEC_QUEUE1_DOORBELL__ENABLE__SHIFT                                                                   0x1c
+#define VPEC_QUEUE1_DOORBELL__CAPTURED__SHIFT                                                                 0x1e
+#define VPEC_QUEUE1_DOORBELL__ENABLE_MASK                                                                     0x10000000L
+#define VPEC_QUEUE1_DOORBELL__CAPTURED_MASK                                                                   0x40000000L
+//VPEC_QUEUE1_DOORBELL_OFFSET
+#define VPEC_QUEUE1_DOORBELL_OFFSET__OFFSET__SHIFT                                                            0x2
+#define VPEC_QUEUE1_DOORBELL_OFFSET__OFFSET_MASK                                                              0x0FFFFFFCL
+//VPEC_QUEUE1_DUMMY0
+#define VPEC_QUEUE1_DUMMY0__DUMMY__SHIFT                                                                      0x0
+#define VPEC_QUEUE1_DUMMY0__DUMMY_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE1_DUMMY1
+#define VPEC_QUEUE1_DUMMY1__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE1_DUMMY1__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE1_DUMMY2
+#define VPEC_QUEUE1_DUMMY2__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE1_DUMMY2__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE1_DUMMY3
+#define VPEC_QUEUE1_DUMMY3__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE1_DUMMY3__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE1_DUMMY4
+#define VPEC_QUEUE1_DUMMY4__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE1_DUMMY4__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE1_IB_CNTL
+#define VPEC_QUEUE1_IB_CNTL__IB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE1_IB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                          0x8
+#define VPEC_QUEUE1_IB_CNTL__CMD_VMID__SHIFT                                                                  0x10
+#define VPEC_QUEUE1_IB_CNTL__IB_PRIV__SHIFT                                                                   0x1f
+#define VPEC_QUEUE1_IB_CNTL__IB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE1_IB_CNTL__SWITCH_INSIDE_IB_MASK                                                            0x00000100L
+#define VPEC_QUEUE1_IB_CNTL__CMD_VMID_MASK                                                                    0x000F0000L
+#define VPEC_QUEUE1_IB_CNTL__IB_PRIV_MASK                                                                     0x80000000L
+//VPEC_QUEUE1_IB_RPTR
+#define VPEC_QUEUE1_IB_RPTR__OFFSET__SHIFT                                                                    0x2
+#define VPEC_QUEUE1_IB_RPTR__OFFSET_MASK                                                                      0x003FFFFCL
+//VPEC_QUEUE1_IB_OFFSET
+#define VPEC_QUEUE1_IB_OFFSET__OFFSET__SHIFT                                                                  0x2
+#define VPEC_QUEUE1_IB_OFFSET__OFFSET_MASK                                                                    0x003FFFFCL
+//VPEC_QUEUE1_IB_BASE_LO
+#define VPEC_QUEUE1_IB_BASE_LO__ADDR__SHIFT                                                                   0x5
+#define VPEC_QUEUE1_IB_BASE_LO__ADDR_MASK                                                                     0xFFFFFFE0L
+//VPEC_QUEUE1_IB_BASE_HI
+#define VPEC_QUEUE1_IB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE1_IB_BASE_HI__ADDR_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE1_IB_SIZE
+#define VPEC_QUEUE1_IB_SIZE__SIZE__SHIFT                                                                      0x0
+#define VPEC_QUEUE1_IB_SIZE__SIZE_MASK                                                                        0x000FFFFFL
+//VPEC_QUEUE1_CMDIB_CNTL
+#define VPEC_QUEUE1_CMDIB_CNTL__IB_ENABLE__SHIFT                                                              0x0
+#define VPEC_QUEUE1_CMDIB_CNTL__IB_SWAP_ENABLE__SHIFT                                                         0x4
+#define VPEC_QUEUE1_CMDIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                       0x8
+#define VPEC_QUEUE1_CMDIB_CNTL__CMD_VMID__SHIFT                                                               0x10
+#define VPEC_QUEUE1_CMDIB_CNTL__IB_PRIV__SHIFT                                                                0x1f
+#define VPEC_QUEUE1_CMDIB_CNTL__IB_ENABLE_MASK                                                                0x00000001L
+#define VPEC_QUEUE1_CMDIB_CNTL__IB_SWAP_ENABLE_MASK                                                           0x00000010L
+#define VPEC_QUEUE1_CMDIB_CNTL__SWITCH_INSIDE_IB_MASK                                                         0x00000100L
+#define VPEC_QUEUE1_CMDIB_CNTL__CMD_VMID_MASK                                                                 0x000F0000L
+#define VPEC_QUEUE1_CMDIB_CNTL__IB_PRIV_MASK                                                                  0x80000000L
+//VPEC_QUEUE1_CMDIB_RPTR
+#define VPEC_QUEUE1_CMDIB_RPTR__OFFSET__SHIFT                                                                 0x2
+#define VPEC_QUEUE1_CMDIB_RPTR__OFFSET_MASK                                                                   0x003FFFFCL
+//VPEC_QUEUE1_CMDIB_OFFSET
+#define VPEC_QUEUE1_CMDIB_OFFSET__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE1_CMDIB_OFFSET__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE1_CMDIB_BASE_LO
+#define VPEC_QUEUE1_CMDIB_BASE_LO__ADDR__SHIFT                                                                0x5
+#define VPEC_QUEUE1_CMDIB_BASE_LO__ADDR_MASK                                                                  0xFFFFFFE0L
+//VPEC_QUEUE1_CMDIB_BASE_HI
+#define VPEC_QUEUE1_CMDIB_BASE_HI__ADDR__SHIFT                                                                0x0
+#define VPEC_QUEUE1_CMDIB_BASE_HI__ADDR_MASK                                                                  0xFFFFFFFFL
+//VPEC_QUEUE1_CMDIB_SIZE
+#define VPEC_QUEUE1_CMDIB_SIZE__SIZE__SHIFT                                                                   0x0
+#define VPEC_QUEUE1_CMDIB_SIZE__SIZE_MASK                                                                     0x000FFFFFL
+//VPEC_QUEUE1_3DLUTIB_CNTL
+#define VPEC_QUEUE1_3DLUTIB_CNTL__IB_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE1_3DLUTIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                     0x8
+#define VPEC_QUEUE1_3DLUTIB_CNTL__CMD_VMID__SHIFT                                                             0x10
+#define VPEC_QUEUE1_3DLUTIB_CNTL__IB_PRIV__SHIFT                                                              0x1f
+#define VPEC_QUEUE1_3DLUTIB_CNTL__IB_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE1_3DLUTIB_CNTL__SWITCH_INSIDE_IB_MASK                                                       0x00000100L
+#define VPEC_QUEUE1_3DLUTIB_CNTL__CMD_VMID_MASK                                                               0x000F0000L
+#define VPEC_QUEUE1_3DLUTIB_CNTL__IB_PRIV_MASK                                                                0x80000000L
+//VPEC_QUEUE1_3DLUTIB_RPTR
+#define VPEC_QUEUE1_3DLUTIB_RPTR__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE1_3DLUTIB_RPTR__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE1_3DLUTIB_OFFSET
+#define VPEC_QUEUE1_3DLUTIB_OFFSET__OFFSET__SHIFT                                                             0x2
+#define VPEC_QUEUE1_3DLUTIB_OFFSET__OFFSET_MASK                                                               0x003FFFFCL
+//VPEC_QUEUE1_3DLUTIB_BASE_LO
+#define VPEC_QUEUE1_3DLUTIB_BASE_LO__ADDR__SHIFT                                                              0x5
+#define VPEC_QUEUE1_3DLUTIB_BASE_LO__ADDR_MASK                                                                0xFFFFFFE0L
+//VPEC_QUEUE1_3DLUTIB_BASE_HI
+#define VPEC_QUEUE1_3DLUTIB_BASE_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE1_3DLUTIB_BASE_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE1_3DLUTIB_SIZE
+#define VPEC_QUEUE1_3DLUTIB_SIZE__SIZE__SHIFT                                                                 0x0
+#define VPEC_QUEUE1_3DLUTIB_SIZE__SIZE_MASK                                                                   0x000FFFFFL
+//VPEC_QUEUE1_CSA_ADDR_LO
+#define VPEC_QUEUE1_CSA_ADDR_LO__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE1_CSA_ADDR_LO__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE1_CSA_ADDR_HI
+#define VPEC_QUEUE1_CSA_ADDR_HI__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE1_CSA_ADDR_HI__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE1_CONTEXT_STATUS
+#define VPEC_QUEUE1_CONTEXT_STATUS__SELECTED__SHIFT                                                           0x0
+#define VPEC_QUEUE1_CONTEXT_STATUS__USE_IB__SHIFT                                                             0x1
+#define VPEC_QUEUE1_CONTEXT_STATUS__IDLE__SHIFT                                                               0x2
+#define VPEC_QUEUE1_CONTEXT_STATUS__EXPIRED__SHIFT                                                            0x3
+#define VPEC_QUEUE1_CONTEXT_STATUS__EXCEPTION__SHIFT                                                          0x4
+#define VPEC_QUEUE1_CONTEXT_STATUS__CTXSW_ABLE__SHIFT                                                         0x7
+#define VPEC_QUEUE1_CONTEXT_STATUS__USE_3DLUTIB__SHIFT                                                        0x8
+#define VPEC_QUEUE1_CONTEXT_STATUS__PREEMPT_DISABLE__SHIFT                                                    0xa
+#define VPEC_QUEUE1_CONTEXT_STATUS__RPTR_WB_IDLE__SHIFT                                                       0xb
+#define VPEC_QUEUE1_CONTEXT_STATUS__WPTR_UPDATE_PENDING__SHIFT                                                0xc
+#define VPEC_QUEUE1_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT__SHIFT                                             0x10
+#define VPEC_QUEUE1_CONTEXT_STATUS__SELECTED_MASK                                                             0x00000001L
+#define VPEC_QUEUE1_CONTEXT_STATUS__USE_IB_MASK                                                               0x00000002L
+#define VPEC_QUEUE1_CONTEXT_STATUS__IDLE_MASK                                                                 0x00000004L
+#define VPEC_QUEUE1_CONTEXT_STATUS__EXPIRED_MASK                                                              0x00000008L
+#define VPEC_QUEUE1_CONTEXT_STATUS__EXCEPTION_MASK                                                            0x00000070L
+#define VPEC_QUEUE1_CONTEXT_STATUS__CTXSW_ABLE_MASK                                                           0x00000080L
+#define VPEC_QUEUE1_CONTEXT_STATUS__USE_3DLUTIB_MASK                                                          0x00000100L
+#define VPEC_QUEUE1_CONTEXT_STATUS__PREEMPT_DISABLE_MASK                                                      0x00000400L
+#define VPEC_QUEUE1_CONTEXT_STATUS__RPTR_WB_IDLE_MASK                                                         0x00000800L
+#define VPEC_QUEUE1_CONTEXT_STATUS__WPTR_UPDATE_PENDING_MASK                                                  0x00001000L
+#define VPEC_QUEUE1_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT_MASK                                               0x00FF0000L
+//VPEC_QUEUE1_DOORBELL_LOG
+#define VPEC_QUEUE1_DOORBELL_LOG__BE_ERROR__SHIFT                                                             0x0
+#define VPEC_QUEUE1_DOORBELL_LOG__DATA__SHIFT                                                                 0x2
+#define VPEC_QUEUE1_DOORBELL_LOG__BE_ERROR_MASK                                                               0x00000001L
+#define VPEC_QUEUE1_DOORBELL_LOG__DATA_MASK                                                                   0xFFFFFFFCL
+//VPEC_QUEUE1_IB_SUB_REMAIN
+#define VPEC_QUEUE1_IB_SUB_REMAIN__SIZE__SHIFT                                                                0x0
+#define VPEC_QUEUE1_IB_SUB_REMAIN__SIZE_MASK                                                                  0x00003FFFL
+//VPEC_QUEUE1_PREEMPT
+#define VPEC_QUEUE1_PREEMPT__IB_PREEMPT__SHIFT                                                                0x0
+#define VPEC_QUEUE1_PREEMPT__IB_PREEMPT_MASK                                                                  0x00000001L
+//VPEC_QUEUE1_LOG0BUFFER_CFG
+#define VPEC_QUEUE1_LOG0BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE1_LOG0BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE1_LOG0BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE1_LOG0BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE1_LOG0BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE1_LOG0BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE1_LOG0BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE1_LOG0BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE1_LOG1BUFFER_CFG
+#define VPEC_QUEUE1_LOG1BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE1_LOG1BUFFER_CFG__PARTIAL_ENTRY__SHIFT                                                      0x1
+#define VPEC_QUEUE1_LOG1BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE1_LOG1BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE1_LOG1BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE1_LOG1BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE1_LOG1BUFFER_CFG__PARTIAL_ENTRY_MASK                                                        0x00000002L
+#define VPEC_QUEUE1_LOG1BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE1_LOG1BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE1_LOG1BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE2_RB_CNTL
+#define VPEC_QUEUE2_RB_CNTL__RB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE2_RB_CNTL__RB_SIZE__SHIFT                                                                   0x1
+#define VPEC_QUEUE2_RB_CNTL__WPTR_POLL_ENABLE__SHIFT                                                          0x8
+#define VPEC_QUEUE2_RB_CNTL__RB_SWAP_ENABLE__SHIFT                                                            0x9
+#define VPEC_QUEUE2_RB_CNTL__WPTR_POLL_SWAP_ENABLE__SHIFT                                                     0xa
+#define VPEC_QUEUE2_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT                                                      0xb
+#define VPEC_QUEUE2_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                     0xc
+#define VPEC_QUEUE2_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                                0xd
+#define VPEC_QUEUE2_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                      0x10
+#define VPEC_QUEUE2_RB_CNTL__RB_PRIV__SHIFT                                                                   0x17
+#define VPEC_QUEUE2_RB_CNTL__RB_VMID__SHIFT                                                                   0x18
+#define VPEC_QUEUE2_RB_CNTL__RB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE2_RB_CNTL__RB_SIZE_MASK                                                                     0x0000003EL
+#define VPEC_QUEUE2_RB_CNTL__WPTR_POLL_ENABLE_MASK                                                            0x00000100L
+#define VPEC_QUEUE2_RB_CNTL__RB_SWAP_ENABLE_MASK                                                              0x00000200L
+#define VPEC_QUEUE2_RB_CNTL__WPTR_POLL_SWAP_ENABLE_MASK                                                       0x00000400L
+#define VPEC_QUEUE2_RB_CNTL__F32_WPTR_POLL_ENABLE_MASK                                                        0x00000800L
+#define VPEC_QUEUE2_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                       0x00001000L
+#define VPEC_QUEUE2_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                  0x00002000L
+#define VPEC_QUEUE2_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                        0x001F0000L
+#define VPEC_QUEUE2_RB_CNTL__RB_PRIV_MASK                                                                     0x00800000L
+#define VPEC_QUEUE2_RB_CNTL__RB_VMID_MASK                                                                     0x0F000000L
+//VPEC_QUEUE2_SCHEDULE_CNTL
+#define VPEC_QUEUE2_SCHEDULE_CNTL__GLOBAL_ID__SHIFT                                                           0x0
+#define VPEC_QUEUE2_SCHEDULE_CNTL__PROCESS_ID__SHIFT                                                          0x2
+#define VPEC_QUEUE2_SCHEDULE_CNTL__LOCAL_ID__SHIFT                                                            0x6
+#define VPEC_QUEUE2_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT                                                     0x8
+#define VPEC_QUEUE2_SCHEDULE_CNTL__GLOBAL_ID_MASK                                                             0x00000003L
+#define VPEC_QUEUE2_SCHEDULE_CNTL__PROCESS_ID_MASK                                                            0x0000001CL
+#define VPEC_QUEUE2_SCHEDULE_CNTL__LOCAL_ID_MASK                                                              0x000000C0L
+#define VPEC_QUEUE2_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK                                                       0x0000FF00L
+//VPEC_QUEUE2_RB_BASE
+#define VPEC_QUEUE2_RB_BASE__ADDR__SHIFT                                                                      0x0
+#define VPEC_QUEUE2_RB_BASE__ADDR_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE2_RB_BASE_HI
+#define VPEC_QUEUE2_RB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE2_RB_BASE_HI__ADDR_MASK                                                                     0x00FFFFFFL
+//VPEC_QUEUE2_RB_RPTR
+#define VPEC_QUEUE2_RB_RPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE2_RB_RPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE2_RB_RPTR_HI
+#define VPEC_QUEUE2_RB_RPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE2_RB_RPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE2_RB_WPTR
+#define VPEC_QUEUE2_RB_WPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE2_RB_WPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE2_RB_WPTR_HI
+#define VPEC_QUEUE2_RB_WPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE2_RB_WPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE2_RB_RPTR_ADDR_HI
+#define VPEC_QUEUE2_RB_RPTR_ADDR_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE2_RB_RPTR_ADDR_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE2_RB_RPTR_ADDR_LO
+#define VPEC_QUEUE2_RB_RPTR_ADDR_LO__ADDR__SHIFT                                                              0x2
+#define VPEC_QUEUE2_RB_RPTR_ADDR_LO__ADDR_MASK                                                                0xFFFFFFFCL
+//VPEC_QUEUE2_RB_AQL_CNTL
+#define VPEC_QUEUE2_RB_AQL_CNTL__AQL_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE2_RB_AQL_CNTL__AQL_PACKET_SIZE__SHIFT                                                       0x1
+#define VPEC_QUEUE2_RB_AQL_CNTL__PACKET_STEP__SHIFT                                                           0x8
+#define VPEC_QUEUE2_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE__SHIFT                                                 0x10
+#define VPEC_QUEUE2_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE__SHIFT                                           0x11
+#define VPEC_QUEUE2_RB_AQL_CNTL__OVERLAP_ENABLE__SHIFT                                                        0x12
+#define VPEC_QUEUE2_RB_AQL_CNTL__AQL_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE2_RB_AQL_CNTL__AQL_PACKET_SIZE_MASK                                                         0x000000FEL
+#define VPEC_QUEUE2_RB_AQL_CNTL__PACKET_STEP_MASK                                                             0x0000FF00L
+#define VPEC_QUEUE2_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE_MASK                                                   0x00010000L
+#define VPEC_QUEUE2_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE_MASK                                             0x00020000L
+#define VPEC_QUEUE2_RB_AQL_CNTL__OVERLAP_ENABLE_MASK                                                          0x00040000L
+//VPEC_QUEUE2_MINOR_PTR_UPDATE
+#define VPEC_QUEUE2_MINOR_PTR_UPDATE__ENABLE__SHIFT                                                           0x0
+#define VPEC_QUEUE2_MINOR_PTR_UPDATE__ENABLE_MASK                                                             0x00000001L
+//VPEC_QUEUE2_CD_INFO
+#define VPEC_QUEUE2_CD_INFO__CD_INFO__SHIFT                                                                   0x0
+#define VPEC_QUEUE2_CD_INFO__CD_INFO_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE2_RB_PREEMPT
+#define VPEC_QUEUE2_RB_PREEMPT__PREEMPT_REQ__SHIFT                                                            0x0
+#define VPEC_QUEUE2_RB_PREEMPT__PREEMPT_REQ_MASK                                                              0x00000001L
+//VPEC_QUEUE2_SKIP_CNTL
+#define VPEC_QUEUE2_SKIP_CNTL__SKIP_COUNT__SHIFT                                                              0x0
+#define VPEC_QUEUE2_SKIP_CNTL__SKIP_COUNT_MASK                                                                0x000FFFFFL
+//VPEC_QUEUE2_DOORBELL
+#define VPEC_QUEUE2_DOORBELL__ENABLE__SHIFT                                                                   0x1c
+#define VPEC_QUEUE2_DOORBELL__CAPTURED__SHIFT                                                                 0x1e
+#define VPEC_QUEUE2_DOORBELL__ENABLE_MASK                                                                     0x10000000L
+#define VPEC_QUEUE2_DOORBELL__CAPTURED_MASK                                                                   0x40000000L
+//VPEC_QUEUE2_DOORBELL_OFFSET
+#define VPEC_QUEUE2_DOORBELL_OFFSET__OFFSET__SHIFT                                                            0x2
+#define VPEC_QUEUE2_DOORBELL_OFFSET__OFFSET_MASK                                                              0x0FFFFFFCL
+//VPEC_QUEUE2_DUMMY0
+#define VPEC_QUEUE2_DUMMY0__DUMMY__SHIFT                                                                      0x0
+#define VPEC_QUEUE2_DUMMY0__DUMMY_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE2_DUMMY1
+#define VPEC_QUEUE2_DUMMY1__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE2_DUMMY1__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE2_DUMMY2
+#define VPEC_QUEUE2_DUMMY2__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE2_DUMMY2__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE2_DUMMY3
+#define VPEC_QUEUE2_DUMMY3__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE2_DUMMY3__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE2_DUMMY4
+#define VPEC_QUEUE2_DUMMY4__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE2_DUMMY4__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE2_IB_CNTL
+#define VPEC_QUEUE2_IB_CNTL__IB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE2_IB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                          0x8
+#define VPEC_QUEUE2_IB_CNTL__CMD_VMID__SHIFT                                                                  0x10
+#define VPEC_QUEUE2_IB_CNTL__IB_PRIV__SHIFT                                                                   0x1f
+#define VPEC_QUEUE2_IB_CNTL__IB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE2_IB_CNTL__SWITCH_INSIDE_IB_MASK                                                            0x00000100L
+#define VPEC_QUEUE2_IB_CNTL__CMD_VMID_MASK                                                                    0x000F0000L
+#define VPEC_QUEUE2_IB_CNTL__IB_PRIV_MASK                                                                     0x80000000L
+//VPEC_QUEUE2_IB_RPTR
+#define VPEC_QUEUE2_IB_RPTR__OFFSET__SHIFT                                                                    0x2
+#define VPEC_QUEUE2_IB_RPTR__OFFSET_MASK                                                                      0x003FFFFCL
+//VPEC_QUEUE2_IB_OFFSET
+#define VPEC_QUEUE2_IB_OFFSET__OFFSET__SHIFT                                                                  0x2
+#define VPEC_QUEUE2_IB_OFFSET__OFFSET_MASK                                                                    0x003FFFFCL
+//VPEC_QUEUE2_IB_BASE_LO
+#define VPEC_QUEUE2_IB_BASE_LO__ADDR__SHIFT                                                                   0x5
+#define VPEC_QUEUE2_IB_BASE_LO__ADDR_MASK                                                                     0xFFFFFFE0L
+//VPEC_QUEUE2_IB_BASE_HI
+#define VPEC_QUEUE2_IB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE2_IB_BASE_HI__ADDR_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE2_IB_SIZE
+#define VPEC_QUEUE2_IB_SIZE__SIZE__SHIFT                                                                      0x0
+#define VPEC_QUEUE2_IB_SIZE__SIZE_MASK                                                                        0x000FFFFFL
+//VPEC_QUEUE2_CMDIB_CNTL
+#define VPEC_QUEUE2_CMDIB_CNTL__IB_ENABLE__SHIFT                                                              0x0
+#define VPEC_QUEUE2_CMDIB_CNTL__IB_SWAP_ENABLE__SHIFT                                                         0x4
+#define VPEC_QUEUE2_CMDIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                       0x8
+#define VPEC_QUEUE2_CMDIB_CNTL__CMD_VMID__SHIFT                                                               0x10
+#define VPEC_QUEUE2_CMDIB_CNTL__IB_PRIV__SHIFT                                                                0x1f
+#define VPEC_QUEUE2_CMDIB_CNTL__IB_ENABLE_MASK                                                                0x00000001L
+#define VPEC_QUEUE2_CMDIB_CNTL__IB_SWAP_ENABLE_MASK                                                           0x00000010L
+#define VPEC_QUEUE2_CMDIB_CNTL__SWITCH_INSIDE_IB_MASK                                                         0x00000100L
+#define VPEC_QUEUE2_CMDIB_CNTL__CMD_VMID_MASK                                                                 0x000F0000L
+#define VPEC_QUEUE2_CMDIB_CNTL__IB_PRIV_MASK                                                                  0x80000000L
+//VPEC_QUEUE2_CMDIB_RPTR
+#define VPEC_QUEUE2_CMDIB_RPTR__OFFSET__SHIFT                                                                 0x2
+#define VPEC_QUEUE2_CMDIB_RPTR__OFFSET_MASK                                                                   0x003FFFFCL
+//VPEC_QUEUE2_CMDIB_OFFSET
+#define VPEC_QUEUE2_CMDIB_OFFSET__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE2_CMDIB_OFFSET__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE2_CMDIB_BASE_LO
+#define VPEC_QUEUE2_CMDIB_BASE_LO__ADDR__SHIFT                                                                0x5
+#define VPEC_QUEUE2_CMDIB_BASE_LO__ADDR_MASK                                                                  0xFFFFFFE0L
+//VPEC_QUEUE2_CMDIB_BASE_HI
+#define VPEC_QUEUE2_CMDIB_BASE_HI__ADDR__SHIFT                                                                0x0
+#define VPEC_QUEUE2_CMDIB_BASE_HI__ADDR_MASK                                                                  0xFFFFFFFFL
+//VPEC_QUEUE2_CMDIB_SIZE
+#define VPEC_QUEUE2_CMDIB_SIZE__SIZE__SHIFT                                                                   0x0
+#define VPEC_QUEUE2_CMDIB_SIZE__SIZE_MASK                                                                     0x000FFFFFL
+//VPEC_QUEUE2_3DLUTIB_CNTL
+#define VPEC_QUEUE2_3DLUTIB_CNTL__IB_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE2_3DLUTIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                     0x8
+#define VPEC_QUEUE2_3DLUTIB_CNTL__CMD_VMID__SHIFT                                                             0x10
+#define VPEC_QUEUE2_3DLUTIB_CNTL__IB_PRIV__SHIFT                                                              0x1f
+#define VPEC_QUEUE2_3DLUTIB_CNTL__IB_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE2_3DLUTIB_CNTL__SWITCH_INSIDE_IB_MASK                                                       0x00000100L
+#define VPEC_QUEUE2_3DLUTIB_CNTL__CMD_VMID_MASK                                                               0x000F0000L
+#define VPEC_QUEUE2_3DLUTIB_CNTL__IB_PRIV_MASK                                                                0x80000000L
+//VPEC_QUEUE2_3DLUTIB_RPTR
+#define VPEC_QUEUE2_3DLUTIB_RPTR__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE2_3DLUTIB_RPTR__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE2_3DLUTIB_OFFSET
+#define VPEC_QUEUE2_3DLUTIB_OFFSET__OFFSET__SHIFT                                                             0x2
+#define VPEC_QUEUE2_3DLUTIB_OFFSET__OFFSET_MASK                                                               0x003FFFFCL
+//VPEC_QUEUE2_3DLUTIB_BASE_LO
+#define VPEC_QUEUE2_3DLUTIB_BASE_LO__ADDR__SHIFT                                                              0x5
+#define VPEC_QUEUE2_3DLUTIB_BASE_LO__ADDR_MASK                                                                0xFFFFFFE0L
+//VPEC_QUEUE2_3DLUTIB_BASE_HI
+#define VPEC_QUEUE2_3DLUTIB_BASE_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE2_3DLUTIB_BASE_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE2_3DLUTIB_SIZE
+#define VPEC_QUEUE2_3DLUTIB_SIZE__SIZE__SHIFT                                                                 0x0
+#define VPEC_QUEUE2_3DLUTIB_SIZE__SIZE_MASK                                                                   0x000FFFFFL
+//VPEC_QUEUE2_CSA_ADDR_LO
+#define VPEC_QUEUE2_CSA_ADDR_LO__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE2_CSA_ADDR_LO__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE2_CSA_ADDR_HI
+#define VPEC_QUEUE2_CSA_ADDR_HI__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE2_CSA_ADDR_HI__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE2_CONTEXT_STATUS
+#define VPEC_QUEUE2_CONTEXT_STATUS__SELECTED__SHIFT                                                           0x0
+#define VPEC_QUEUE2_CONTEXT_STATUS__USE_IB__SHIFT                                                             0x1
+#define VPEC_QUEUE2_CONTEXT_STATUS__IDLE__SHIFT                                                               0x2
+#define VPEC_QUEUE2_CONTEXT_STATUS__EXPIRED__SHIFT                                                            0x3
+#define VPEC_QUEUE2_CONTEXT_STATUS__EXCEPTION__SHIFT                                                          0x4
+#define VPEC_QUEUE2_CONTEXT_STATUS__CTXSW_ABLE__SHIFT                                                         0x7
+#define VPEC_QUEUE2_CONTEXT_STATUS__USE_3DLUTIB__SHIFT                                                        0x8
+#define VPEC_QUEUE2_CONTEXT_STATUS__PREEMPT_DISABLE__SHIFT                                                    0xa
+#define VPEC_QUEUE2_CONTEXT_STATUS__RPTR_WB_IDLE__SHIFT                                                       0xb
+#define VPEC_QUEUE2_CONTEXT_STATUS__WPTR_UPDATE_PENDING__SHIFT                                                0xc
+#define VPEC_QUEUE2_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT__SHIFT                                             0x10
+#define VPEC_QUEUE2_CONTEXT_STATUS__SELECTED_MASK                                                             0x00000001L
+#define VPEC_QUEUE2_CONTEXT_STATUS__USE_IB_MASK                                                               0x00000002L
+#define VPEC_QUEUE2_CONTEXT_STATUS__IDLE_MASK                                                                 0x00000004L
+#define VPEC_QUEUE2_CONTEXT_STATUS__EXPIRED_MASK                                                              0x00000008L
+#define VPEC_QUEUE2_CONTEXT_STATUS__EXCEPTION_MASK                                                            0x00000070L
+#define VPEC_QUEUE2_CONTEXT_STATUS__CTXSW_ABLE_MASK                                                           0x00000080L
+#define VPEC_QUEUE2_CONTEXT_STATUS__USE_3DLUTIB_MASK                                                          0x00000100L
+#define VPEC_QUEUE2_CONTEXT_STATUS__PREEMPT_DISABLE_MASK                                                      0x00000400L
+#define VPEC_QUEUE2_CONTEXT_STATUS__RPTR_WB_IDLE_MASK                                                         0x00000800L
+#define VPEC_QUEUE2_CONTEXT_STATUS__WPTR_UPDATE_PENDING_MASK                                                  0x00001000L
+#define VPEC_QUEUE2_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT_MASK                                               0x00FF0000L
+//VPEC_QUEUE2_DOORBELL_LOG
+#define VPEC_QUEUE2_DOORBELL_LOG__BE_ERROR__SHIFT                                                             0x0
+#define VPEC_QUEUE2_DOORBELL_LOG__DATA__SHIFT                                                                 0x2
+#define VPEC_QUEUE2_DOORBELL_LOG__BE_ERROR_MASK                                                               0x00000001L
+#define VPEC_QUEUE2_DOORBELL_LOG__DATA_MASK                                                                   0xFFFFFFFCL
+//VPEC_QUEUE2_IB_SUB_REMAIN
+#define VPEC_QUEUE2_IB_SUB_REMAIN__SIZE__SHIFT                                                                0x0
+#define VPEC_QUEUE2_IB_SUB_REMAIN__SIZE_MASK                                                                  0x00003FFFL
+//VPEC_QUEUE2_PREEMPT
+#define VPEC_QUEUE2_PREEMPT__IB_PREEMPT__SHIFT                                                                0x0
+#define VPEC_QUEUE2_PREEMPT__IB_PREEMPT_MASK                                                                  0x00000001L
+//VPEC_QUEUE2_LOG0BUFFER_CFG
+#define VPEC_QUEUE2_LOG0BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE2_LOG0BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE2_LOG0BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE2_LOG0BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE2_LOG0BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE2_LOG0BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE2_LOG0BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE2_LOG0BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE2_LOG1BUFFER_CFG
+#define VPEC_QUEUE2_LOG1BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE2_LOG1BUFFER_CFG__PARTIAL_ENTRY__SHIFT                                                      0x1
+#define VPEC_QUEUE2_LOG1BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE2_LOG1BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE2_LOG1BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE2_LOG1BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE2_LOG1BUFFER_CFG__PARTIAL_ENTRY_MASK                                                        0x00000002L
+#define VPEC_QUEUE2_LOG1BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE2_LOG1BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE2_LOG1BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE3_RB_CNTL
+#define VPEC_QUEUE3_RB_CNTL__RB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE3_RB_CNTL__RB_SIZE__SHIFT                                                                   0x1
+#define VPEC_QUEUE3_RB_CNTL__WPTR_POLL_ENABLE__SHIFT                                                          0x8
+#define VPEC_QUEUE3_RB_CNTL__RB_SWAP_ENABLE__SHIFT                                                            0x9
+#define VPEC_QUEUE3_RB_CNTL__WPTR_POLL_SWAP_ENABLE__SHIFT                                                     0xa
+#define VPEC_QUEUE3_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT                                                      0xb
+#define VPEC_QUEUE3_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                     0xc
+#define VPEC_QUEUE3_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                                0xd
+#define VPEC_QUEUE3_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                      0x10
+#define VPEC_QUEUE3_RB_CNTL__RB_PRIV__SHIFT                                                                   0x17
+#define VPEC_QUEUE3_RB_CNTL__RB_VMID__SHIFT                                                                   0x18
+#define VPEC_QUEUE3_RB_CNTL__RB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE3_RB_CNTL__RB_SIZE_MASK                                                                     0x0000003EL
+#define VPEC_QUEUE3_RB_CNTL__WPTR_POLL_ENABLE_MASK                                                            0x00000100L
+#define VPEC_QUEUE3_RB_CNTL__RB_SWAP_ENABLE_MASK                                                              0x00000200L
+#define VPEC_QUEUE3_RB_CNTL__WPTR_POLL_SWAP_ENABLE_MASK                                                       0x00000400L
+#define VPEC_QUEUE3_RB_CNTL__F32_WPTR_POLL_ENABLE_MASK                                                        0x00000800L
+#define VPEC_QUEUE3_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                       0x00001000L
+#define VPEC_QUEUE3_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                  0x00002000L
+#define VPEC_QUEUE3_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                        0x001F0000L
+#define VPEC_QUEUE3_RB_CNTL__RB_PRIV_MASK                                                                     0x00800000L
+#define VPEC_QUEUE3_RB_CNTL__RB_VMID_MASK                                                                     0x0F000000L
+//VPEC_QUEUE3_SCHEDULE_CNTL
+#define VPEC_QUEUE3_SCHEDULE_CNTL__GLOBAL_ID__SHIFT                                                           0x0
+#define VPEC_QUEUE3_SCHEDULE_CNTL__PROCESS_ID__SHIFT                                                          0x2
+#define VPEC_QUEUE3_SCHEDULE_CNTL__LOCAL_ID__SHIFT                                                            0x6
+#define VPEC_QUEUE3_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT                                                     0x8
+#define VPEC_QUEUE3_SCHEDULE_CNTL__GLOBAL_ID_MASK                                                             0x00000003L
+#define VPEC_QUEUE3_SCHEDULE_CNTL__PROCESS_ID_MASK                                                            0x0000001CL
+#define VPEC_QUEUE3_SCHEDULE_CNTL__LOCAL_ID_MASK                                                              0x000000C0L
+#define VPEC_QUEUE3_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK                                                       0x0000FF00L
+//VPEC_QUEUE3_RB_BASE
+#define VPEC_QUEUE3_RB_BASE__ADDR__SHIFT                                                                      0x0
+#define VPEC_QUEUE3_RB_BASE__ADDR_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE3_RB_BASE_HI
+#define VPEC_QUEUE3_RB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE3_RB_BASE_HI__ADDR_MASK                                                                     0x00FFFFFFL
+//VPEC_QUEUE3_RB_RPTR
+#define VPEC_QUEUE3_RB_RPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE3_RB_RPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE3_RB_RPTR_HI
+#define VPEC_QUEUE3_RB_RPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE3_RB_RPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE3_RB_WPTR
+#define VPEC_QUEUE3_RB_WPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE3_RB_WPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE3_RB_WPTR_HI
+#define VPEC_QUEUE3_RB_WPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE3_RB_WPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE3_RB_RPTR_ADDR_HI
+#define VPEC_QUEUE3_RB_RPTR_ADDR_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE3_RB_RPTR_ADDR_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE3_RB_RPTR_ADDR_LO
+#define VPEC_QUEUE3_RB_RPTR_ADDR_LO__ADDR__SHIFT                                                              0x2
+#define VPEC_QUEUE3_RB_RPTR_ADDR_LO__ADDR_MASK                                                                0xFFFFFFFCL
+//VPEC_QUEUE3_RB_AQL_CNTL
+#define VPEC_QUEUE3_RB_AQL_CNTL__AQL_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE3_RB_AQL_CNTL__AQL_PACKET_SIZE__SHIFT                                                       0x1
+#define VPEC_QUEUE3_RB_AQL_CNTL__PACKET_STEP__SHIFT                                                           0x8
+#define VPEC_QUEUE3_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE__SHIFT                                                 0x10
+#define VPEC_QUEUE3_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE__SHIFT                                           0x11
+#define VPEC_QUEUE3_RB_AQL_CNTL__OVERLAP_ENABLE__SHIFT                                                        0x12
+#define VPEC_QUEUE3_RB_AQL_CNTL__AQL_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE3_RB_AQL_CNTL__AQL_PACKET_SIZE_MASK                                                         0x000000FEL
+#define VPEC_QUEUE3_RB_AQL_CNTL__PACKET_STEP_MASK                                                             0x0000FF00L
+#define VPEC_QUEUE3_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE_MASK                                                   0x00010000L
+#define VPEC_QUEUE3_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE_MASK                                             0x00020000L
+#define VPEC_QUEUE3_RB_AQL_CNTL__OVERLAP_ENABLE_MASK                                                          0x00040000L
+//VPEC_QUEUE3_MINOR_PTR_UPDATE
+#define VPEC_QUEUE3_MINOR_PTR_UPDATE__ENABLE__SHIFT                                                           0x0
+#define VPEC_QUEUE3_MINOR_PTR_UPDATE__ENABLE_MASK                                                             0x00000001L
+//VPEC_QUEUE3_CD_INFO
+#define VPEC_QUEUE3_CD_INFO__CD_INFO__SHIFT                                                                   0x0
+#define VPEC_QUEUE3_CD_INFO__CD_INFO_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE3_RB_PREEMPT
+#define VPEC_QUEUE3_RB_PREEMPT__PREEMPT_REQ__SHIFT                                                            0x0
+#define VPEC_QUEUE3_RB_PREEMPT__PREEMPT_REQ_MASK                                                              0x00000001L
+//VPEC_QUEUE3_SKIP_CNTL
+#define VPEC_QUEUE3_SKIP_CNTL__SKIP_COUNT__SHIFT                                                              0x0
+#define VPEC_QUEUE3_SKIP_CNTL__SKIP_COUNT_MASK                                                                0x000FFFFFL
+//VPEC_QUEUE3_DOORBELL
+#define VPEC_QUEUE3_DOORBELL__ENABLE__SHIFT                                                                   0x1c
+#define VPEC_QUEUE3_DOORBELL__CAPTURED__SHIFT                                                                 0x1e
+#define VPEC_QUEUE3_DOORBELL__ENABLE_MASK                                                                     0x10000000L
+#define VPEC_QUEUE3_DOORBELL__CAPTURED_MASK                                                                   0x40000000L
+//VPEC_QUEUE3_DOORBELL_OFFSET
+#define VPEC_QUEUE3_DOORBELL_OFFSET__OFFSET__SHIFT                                                            0x2
+#define VPEC_QUEUE3_DOORBELL_OFFSET__OFFSET_MASK                                                              0x0FFFFFFCL
+//VPEC_QUEUE3_DUMMY0
+#define VPEC_QUEUE3_DUMMY0__DUMMY__SHIFT                                                                      0x0
+#define VPEC_QUEUE3_DUMMY0__DUMMY_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE3_DUMMY1
+#define VPEC_QUEUE3_DUMMY1__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE3_DUMMY1__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE3_DUMMY2
+#define VPEC_QUEUE3_DUMMY2__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE3_DUMMY2__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE3_DUMMY3
+#define VPEC_QUEUE3_DUMMY3__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE3_DUMMY3__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE3_DUMMY4
+#define VPEC_QUEUE3_DUMMY4__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE3_DUMMY4__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE3_IB_CNTL
+#define VPEC_QUEUE3_IB_CNTL__IB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE3_IB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                          0x8
+#define VPEC_QUEUE3_IB_CNTL__CMD_VMID__SHIFT                                                                  0x10
+#define VPEC_QUEUE3_IB_CNTL__IB_PRIV__SHIFT                                                                   0x1f
+#define VPEC_QUEUE3_IB_CNTL__IB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE3_IB_CNTL__SWITCH_INSIDE_IB_MASK                                                            0x00000100L
+#define VPEC_QUEUE3_IB_CNTL__CMD_VMID_MASK                                                                    0x000F0000L
+#define VPEC_QUEUE3_IB_CNTL__IB_PRIV_MASK                                                                     0x80000000L
+//VPEC_QUEUE3_IB_RPTR
+#define VPEC_QUEUE3_IB_RPTR__OFFSET__SHIFT                                                                    0x2
+#define VPEC_QUEUE3_IB_RPTR__OFFSET_MASK                                                                      0x003FFFFCL
+//VPEC_QUEUE3_IB_OFFSET
+#define VPEC_QUEUE3_IB_OFFSET__OFFSET__SHIFT                                                                  0x2
+#define VPEC_QUEUE3_IB_OFFSET__OFFSET_MASK                                                                    0x003FFFFCL
+//VPEC_QUEUE3_IB_BASE_LO
+#define VPEC_QUEUE3_IB_BASE_LO__ADDR__SHIFT                                                                   0x5
+#define VPEC_QUEUE3_IB_BASE_LO__ADDR_MASK                                                                     0xFFFFFFE0L
+//VPEC_QUEUE3_IB_BASE_HI
+#define VPEC_QUEUE3_IB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE3_IB_BASE_HI__ADDR_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE3_IB_SIZE
+#define VPEC_QUEUE3_IB_SIZE__SIZE__SHIFT                                                                      0x0
+#define VPEC_QUEUE3_IB_SIZE__SIZE_MASK                                                                        0x000FFFFFL
+//VPEC_QUEUE3_CMDIB_CNTL
+#define VPEC_QUEUE3_CMDIB_CNTL__IB_ENABLE__SHIFT                                                              0x0
+#define VPEC_QUEUE3_CMDIB_CNTL__IB_SWAP_ENABLE__SHIFT                                                         0x4
+#define VPEC_QUEUE3_CMDIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                       0x8
+#define VPEC_QUEUE3_CMDIB_CNTL__CMD_VMID__SHIFT                                                               0x10
+#define VPEC_QUEUE3_CMDIB_CNTL__IB_PRIV__SHIFT                                                                0x1f
+#define VPEC_QUEUE3_CMDIB_CNTL__IB_ENABLE_MASK                                                                0x00000001L
+#define VPEC_QUEUE3_CMDIB_CNTL__IB_SWAP_ENABLE_MASK                                                           0x00000010L
+#define VPEC_QUEUE3_CMDIB_CNTL__SWITCH_INSIDE_IB_MASK                                                         0x00000100L
+#define VPEC_QUEUE3_CMDIB_CNTL__CMD_VMID_MASK                                                                 0x000F0000L
+#define VPEC_QUEUE3_CMDIB_CNTL__IB_PRIV_MASK                                                                  0x80000000L
+//VPEC_QUEUE3_CMDIB_RPTR
+#define VPEC_QUEUE3_CMDIB_RPTR__OFFSET__SHIFT                                                                 0x2
+#define VPEC_QUEUE3_CMDIB_RPTR__OFFSET_MASK                                                                   0x003FFFFCL
+//VPEC_QUEUE3_CMDIB_OFFSET
+#define VPEC_QUEUE3_CMDIB_OFFSET__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE3_CMDIB_OFFSET__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE3_CMDIB_BASE_LO
+#define VPEC_QUEUE3_CMDIB_BASE_LO__ADDR__SHIFT                                                                0x5
+#define VPEC_QUEUE3_CMDIB_BASE_LO__ADDR_MASK                                                                  0xFFFFFFE0L
+//VPEC_QUEUE3_CMDIB_BASE_HI
+#define VPEC_QUEUE3_CMDIB_BASE_HI__ADDR__SHIFT                                                                0x0
+#define VPEC_QUEUE3_CMDIB_BASE_HI__ADDR_MASK                                                                  0xFFFFFFFFL
+//VPEC_QUEUE3_CMDIB_SIZE
+#define VPEC_QUEUE3_CMDIB_SIZE__SIZE__SHIFT                                                                   0x0
+#define VPEC_QUEUE3_CMDIB_SIZE__SIZE_MASK                                                                     0x000FFFFFL
+//VPEC_QUEUE3_3DLUTIB_CNTL
+#define VPEC_QUEUE3_3DLUTIB_CNTL__IB_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE3_3DLUTIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                     0x8
+#define VPEC_QUEUE3_3DLUTIB_CNTL__CMD_VMID__SHIFT                                                             0x10
+#define VPEC_QUEUE3_3DLUTIB_CNTL__IB_PRIV__SHIFT                                                              0x1f
+#define VPEC_QUEUE3_3DLUTIB_CNTL__IB_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE3_3DLUTIB_CNTL__SWITCH_INSIDE_IB_MASK                                                       0x00000100L
+#define VPEC_QUEUE3_3DLUTIB_CNTL__CMD_VMID_MASK                                                               0x000F0000L
+#define VPEC_QUEUE3_3DLUTIB_CNTL__IB_PRIV_MASK                                                                0x80000000L
+//VPEC_QUEUE3_3DLUTIB_RPTR
+#define VPEC_QUEUE3_3DLUTIB_RPTR__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE3_3DLUTIB_RPTR__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE3_3DLUTIB_OFFSET
+#define VPEC_QUEUE3_3DLUTIB_OFFSET__OFFSET__SHIFT                                                             0x2
+#define VPEC_QUEUE3_3DLUTIB_OFFSET__OFFSET_MASK                                                               0x003FFFFCL
+//VPEC_QUEUE3_3DLUTIB_BASE_LO
+#define VPEC_QUEUE3_3DLUTIB_BASE_LO__ADDR__SHIFT                                                              0x5
+#define VPEC_QUEUE3_3DLUTIB_BASE_LO__ADDR_MASK                                                                0xFFFFFFE0L
+//VPEC_QUEUE3_3DLUTIB_BASE_HI
+#define VPEC_QUEUE3_3DLUTIB_BASE_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE3_3DLUTIB_BASE_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE3_3DLUTIB_SIZE
+#define VPEC_QUEUE3_3DLUTIB_SIZE__SIZE__SHIFT                                                                 0x0
+#define VPEC_QUEUE3_3DLUTIB_SIZE__SIZE_MASK                                                                   0x000FFFFFL
+//VPEC_QUEUE3_CSA_ADDR_LO
+#define VPEC_QUEUE3_CSA_ADDR_LO__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE3_CSA_ADDR_LO__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE3_CSA_ADDR_HI
+#define VPEC_QUEUE3_CSA_ADDR_HI__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE3_CSA_ADDR_HI__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE3_CONTEXT_STATUS
+#define VPEC_QUEUE3_CONTEXT_STATUS__SELECTED__SHIFT                                                           0x0
+#define VPEC_QUEUE3_CONTEXT_STATUS__USE_IB__SHIFT                                                             0x1
+#define VPEC_QUEUE3_CONTEXT_STATUS__IDLE__SHIFT                                                               0x2
+#define VPEC_QUEUE3_CONTEXT_STATUS__EXPIRED__SHIFT                                                            0x3
+#define VPEC_QUEUE3_CONTEXT_STATUS__EXCEPTION__SHIFT                                                          0x4
+#define VPEC_QUEUE3_CONTEXT_STATUS__CTXSW_ABLE__SHIFT                                                         0x7
+#define VPEC_QUEUE3_CONTEXT_STATUS__USE_3DLUTIB__SHIFT                                                        0x8
+#define VPEC_QUEUE3_CONTEXT_STATUS__PREEMPT_DISABLE__SHIFT                                                    0xa
+#define VPEC_QUEUE3_CONTEXT_STATUS__RPTR_WB_IDLE__SHIFT                                                       0xb
+#define VPEC_QUEUE3_CONTEXT_STATUS__WPTR_UPDATE_PENDING__SHIFT                                                0xc
+#define VPEC_QUEUE3_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT__SHIFT                                             0x10
+#define VPEC_QUEUE3_CONTEXT_STATUS__SELECTED_MASK                                                             0x00000001L
+#define VPEC_QUEUE3_CONTEXT_STATUS__USE_IB_MASK                                                               0x00000002L
+#define VPEC_QUEUE3_CONTEXT_STATUS__IDLE_MASK                                                                 0x00000004L
+#define VPEC_QUEUE3_CONTEXT_STATUS__EXPIRED_MASK                                                              0x00000008L
+#define VPEC_QUEUE3_CONTEXT_STATUS__EXCEPTION_MASK                                                            0x00000070L
+#define VPEC_QUEUE3_CONTEXT_STATUS__CTXSW_ABLE_MASK                                                           0x00000080L
+#define VPEC_QUEUE3_CONTEXT_STATUS__USE_3DLUTIB_MASK                                                          0x00000100L
+#define VPEC_QUEUE3_CONTEXT_STATUS__PREEMPT_DISABLE_MASK                                                      0x00000400L
+#define VPEC_QUEUE3_CONTEXT_STATUS__RPTR_WB_IDLE_MASK                                                         0x00000800L
+#define VPEC_QUEUE3_CONTEXT_STATUS__WPTR_UPDATE_PENDING_MASK                                                  0x00001000L
+#define VPEC_QUEUE3_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT_MASK                                               0x00FF0000L
+//VPEC_QUEUE3_DOORBELL_LOG
+#define VPEC_QUEUE3_DOORBELL_LOG__BE_ERROR__SHIFT                                                             0x0
+#define VPEC_QUEUE3_DOORBELL_LOG__DATA__SHIFT                                                                 0x2
+#define VPEC_QUEUE3_DOORBELL_LOG__BE_ERROR_MASK                                                               0x00000001L
+#define VPEC_QUEUE3_DOORBELL_LOG__DATA_MASK                                                                   0xFFFFFFFCL
+//VPEC_QUEUE3_IB_SUB_REMAIN
+#define VPEC_QUEUE3_IB_SUB_REMAIN__SIZE__SHIFT                                                                0x0
+#define VPEC_QUEUE3_IB_SUB_REMAIN__SIZE_MASK                                                                  0x00003FFFL
+//VPEC_QUEUE3_PREEMPT
+#define VPEC_QUEUE3_PREEMPT__IB_PREEMPT__SHIFT                                                                0x0
+#define VPEC_QUEUE3_PREEMPT__IB_PREEMPT_MASK                                                                  0x00000001L
+//VPEC_QUEUE3_LOG0BUFFER_CFG
+#define VPEC_QUEUE3_LOG0BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE3_LOG0BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE3_LOG0BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE3_LOG0BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE3_LOG0BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE3_LOG0BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE3_LOG0BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE3_LOG0BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE3_LOG1BUFFER_CFG
+#define VPEC_QUEUE3_LOG1BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE3_LOG1BUFFER_CFG__PARTIAL_ENTRY__SHIFT                                                      0x1
+#define VPEC_QUEUE3_LOG1BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE3_LOG1BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE3_LOG1BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE3_LOG1BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE3_LOG1BUFFER_CFG__PARTIAL_ENTRY_MASK                                                        0x00000002L
+#define VPEC_QUEUE3_LOG1BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE3_LOG1BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE3_LOG1BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE4_RB_CNTL
+#define VPEC_QUEUE4_RB_CNTL__RB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE4_RB_CNTL__RB_SIZE__SHIFT                                                                   0x1
+#define VPEC_QUEUE4_RB_CNTL__WPTR_POLL_ENABLE__SHIFT                                                          0x8
+#define VPEC_QUEUE4_RB_CNTL__RB_SWAP_ENABLE__SHIFT                                                            0x9
+#define VPEC_QUEUE4_RB_CNTL__WPTR_POLL_SWAP_ENABLE__SHIFT                                                     0xa
+#define VPEC_QUEUE4_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT                                                      0xb
+#define VPEC_QUEUE4_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                     0xc
+#define VPEC_QUEUE4_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                                0xd
+#define VPEC_QUEUE4_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                      0x10
+#define VPEC_QUEUE4_RB_CNTL__RB_PRIV__SHIFT                                                                   0x17
+#define VPEC_QUEUE4_RB_CNTL__RB_VMID__SHIFT                                                                   0x18
+#define VPEC_QUEUE4_RB_CNTL__RB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE4_RB_CNTL__RB_SIZE_MASK                                                                     0x0000003EL
+#define VPEC_QUEUE4_RB_CNTL__WPTR_POLL_ENABLE_MASK                                                            0x00000100L
+#define VPEC_QUEUE4_RB_CNTL__RB_SWAP_ENABLE_MASK                                                              0x00000200L
+#define VPEC_QUEUE4_RB_CNTL__WPTR_POLL_SWAP_ENABLE_MASK                                                       0x00000400L
+#define VPEC_QUEUE4_RB_CNTL__F32_WPTR_POLL_ENABLE_MASK                                                        0x00000800L
+#define VPEC_QUEUE4_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                       0x00001000L
+#define VPEC_QUEUE4_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                  0x00002000L
+#define VPEC_QUEUE4_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                        0x001F0000L
+#define VPEC_QUEUE4_RB_CNTL__RB_PRIV_MASK                                                                     0x00800000L
+#define VPEC_QUEUE4_RB_CNTL__RB_VMID_MASK                                                                     0x0F000000L
+//VPEC_QUEUE4_SCHEDULE_CNTL
+#define VPEC_QUEUE4_SCHEDULE_CNTL__GLOBAL_ID__SHIFT                                                           0x0
+#define VPEC_QUEUE4_SCHEDULE_CNTL__PROCESS_ID__SHIFT                                                          0x2
+#define VPEC_QUEUE4_SCHEDULE_CNTL__LOCAL_ID__SHIFT                                                            0x6
+#define VPEC_QUEUE4_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT                                                     0x8
+#define VPEC_QUEUE4_SCHEDULE_CNTL__GLOBAL_ID_MASK                                                             0x00000003L
+#define VPEC_QUEUE4_SCHEDULE_CNTL__PROCESS_ID_MASK                                                            0x0000001CL
+#define VPEC_QUEUE4_SCHEDULE_CNTL__LOCAL_ID_MASK                                                              0x000000C0L
+#define VPEC_QUEUE4_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK                                                       0x0000FF00L
+//VPEC_QUEUE4_RB_BASE
+#define VPEC_QUEUE4_RB_BASE__ADDR__SHIFT                                                                      0x0
+#define VPEC_QUEUE4_RB_BASE__ADDR_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE4_RB_BASE_HI
+#define VPEC_QUEUE4_RB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE4_RB_BASE_HI__ADDR_MASK                                                                     0x00FFFFFFL
+//VPEC_QUEUE4_RB_RPTR
+#define VPEC_QUEUE4_RB_RPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE4_RB_RPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE4_RB_RPTR_HI
+#define VPEC_QUEUE4_RB_RPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE4_RB_RPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE4_RB_WPTR
+#define VPEC_QUEUE4_RB_WPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE4_RB_WPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE4_RB_WPTR_HI
+#define VPEC_QUEUE4_RB_WPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE4_RB_WPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE4_RB_RPTR_ADDR_HI
+#define VPEC_QUEUE4_RB_RPTR_ADDR_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE4_RB_RPTR_ADDR_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE4_RB_RPTR_ADDR_LO
+#define VPEC_QUEUE4_RB_RPTR_ADDR_LO__ADDR__SHIFT                                                              0x2
+#define VPEC_QUEUE4_RB_RPTR_ADDR_LO__ADDR_MASK                                                                0xFFFFFFFCL
+//VPEC_QUEUE4_RB_AQL_CNTL
+#define VPEC_QUEUE4_RB_AQL_CNTL__AQL_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE4_RB_AQL_CNTL__AQL_PACKET_SIZE__SHIFT                                                       0x1
+#define VPEC_QUEUE4_RB_AQL_CNTL__PACKET_STEP__SHIFT                                                           0x8
+#define VPEC_QUEUE4_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE__SHIFT                                                 0x10
+#define VPEC_QUEUE4_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE__SHIFT                                           0x11
+#define VPEC_QUEUE4_RB_AQL_CNTL__OVERLAP_ENABLE__SHIFT                                                        0x12
+#define VPEC_QUEUE4_RB_AQL_CNTL__AQL_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE4_RB_AQL_CNTL__AQL_PACKET_SIZE_MASK                                                         0x000000FEL
+#define VPEC_QUEUE4_RB_AQL_CNTL__PACKET_STEP_MASK                                                             0x0000FF00L
+#define VPEC_QUEUE4_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE_MASK                                                   0x00010000L
+#define VPEC_QUEUE4_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE_MASK                                             0x00020000L
+#define VPEC_QUEUE4_RB_AQL_CNTL__OVERLAP_ENABLE_MASK                                                          0x00040000L
+//VPEC_QUEUE4_MINOR_PTR_UPDATE
+#define VPEC_QUEUE4_MINOR_PTR_UPDATE__ENABLE__SHIFT                                                           0x0
+#define VPEC_QUEUE4_MINOR_PTR_UPDATE__ENABLE_MASK                                                             0x00000001L
+//VPEC_QUEUE4_CD_INFO
+#define VPEC_QUEUE4_CD_INFO__CD_INFO__SHIFT                                                                   0x0
+#define VPEC_QUEUE4_CD_INFO__CD_INFO_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE4_RB_PREEMPT
+#define VPEC_QUEUE4_RB_PREEMPT__PREEMPT_REQ__SHIFT                                                            0x0
+#define VPEC_QUEUE4_RB_PREEMPT__PREEMPT_REQ_MASK                                                              0x00000001L
+//VPEC_QUEUE4_SKIP_CNTL
+#define VPEC_QUEUE4_SKIP_CNTL__SKIP_COUNT__SHIFT                                                              0x0
+#define VPEC_QUEUE4_SKIP_CNTL__SKIP_COUNT_MASK                                                                0x000FFFFFL
+//VPEC_QUEUE4_DOORBELL
+#define VPEC_QUEUE4_DOORBELL__ENABLE__SHIFT                                                                   0x1c
+#define VPEC_QUEUE4_DOORBELL__CAPTURED__SHIFT                                                                 0x1e
+#define VPEC_QUEUE4_DOORBELL__ENABLE_MASK                                                                     0x10000000L
+#define VPEC_QUEUE4_DOORBELL__CAPTURED_MASK                                                                   0x40000000L
+//VPEC_QUEUE4_DOORBELL_OFFSET
+#define VPEC_QUEUE4_DOORBELL_OFFSET__OFFSET__SHIFT                                                            0x2
+#define VPEC_QUEUE4_DOORBELL_OFFSET__OFFSET_MASK                                                              0x0FFFFFFCL
+//VPEC_QUEUE4_DUMMY0
+#define VPEC_QUEUE4_DUMMY0__DUMMY__SHIFT                                                                      0x0
+#define VPEC_QUEUE4_DUMMY0__DUMMY_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE4_DUMMY1
+#define VPEC_QUEUE4_DUMMY1__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE4_DUMMY1__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE4_DUMMY2
+#define VPEC_QUEUE4_DUMMY2__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE4_DUMMY2__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE4_DUMMY3
+#define VPEC_QUEUE4_DUMMY3__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE4_DUMMY3__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE4_DUMMY4
+#define VPEC_QUEUE4_DUMMY4__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE4_DUMMY4__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE4_IB_CNTL
+#define VPEC_QUEUE4_IB_CNTL__IB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE4_IB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                          0x8
+#define VPEC_QUEUE4_IB_CNTL__CMD_VMID__SHIFT                                                                  0x10
+#define VPEC_QUEUE4_IB_CNTL__IB_PRIV__SHIFT                                                                   0x1f
+#define VPEC_QUEUE4_IB_CNTL__IB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE4_IB_CNTL__SWITCH_INSIDE_IB_MASK                                                            0x00000100L
+#define VPEC_QUEUE4_IB_CNTL__CMD_VMID_MASK                                                                    0x000F0000L
+#define VPEC_QUEUE4_IB_CNTL__IB_PRIV_MASK                                                                     0x80000000L
+//VPEC_QUEUE4_IB_RPTR
+#define VPEC_QUEUE4_IB_RPTR__OFFSET__SHIFT                                                                    0x2
+#define VPEC_QUEUE4_IB_RPTR__OFFSET_MASK                                                                      0x003FFFFCL
+//VPEC_QUEUE4_IB_OFFSET
+#define VPEC_QUEUE4_IB_OFFSET__OFFSET__SHIFT                                                                  0x2
+#define VPEC_QUEUE4_IB_OFFSET__OFFSET_MASK                                                                    0x003FFFFCL
+//VPEC_QUEUE4_IB_BASE_LO
+#define VPEC_QUEUE4_IB_BASE_LO__ADDR__SHIFT                                                                   0x5
+#define VPEC_QUEUE4_IB_BASE_LO__ADDR_MASK                                                                     0xFFFFFFE0L
+//VPEC_QUEUE4_IB_BASE_HI
+#define VPEC_QUEUE4_IB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE4_IB_BASE_HI__ADDR_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE4_IB_SIZE
+#define VPEC_QUEUE4_IB_SIZE__SIZE__SHIFT                                                                      0x0
+#define VPEC_QUEUE4_IB_SIZE__SIZE_MASK                                                                        0x000FFFFFL
+//VPEC_QUEUE4_CMDIB_CNTL
+#define VPEC_QUEUE4_CMDIB_CNTL__IB_ENABLE__SHIFT                                                              0x0
+#define VPEC_QUEUE4_CMDIB_CNTL__IB_SWAP_ENABLE__SHIFT                                                         0x4
+#define VPEC_QUEUE4_CMDIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                       0x8
+#define VPEC_QUEUE4_CMDIB_CNTL__CMD_VMID__SHIFT                                                               0x10
+#define VPEC_QUEUE4_CMDIB_CNTL__IB_PRIV__SHIFT                                                                0x1f
+#define VPEC_QUEUE4_CMDIB_CNTL__IB_ENABLE_MASK                                                                0x00000001L
+#define VPEC_QUEUE4_CMDIB_CNTL__IB_SWAP_ENABLE_MASK                                                           0x00000010L
+#define VPEC_QUEUE4_CMDIB_CNTL__SWITCH_INSIDE_IB_MASK                                                         0x00000100L
+#define VPEC_QUEUE4_CMDIB_CNTL__CMD_VMID_MASK                                                                 0x000F0000L
+#define VPEC_QUEUE4_CMDIB_CNTL__IB_PRIV_MASK                                                                  0x80000000L
+//VPEC_QUEUE4_CMDIB_RPTR
+#define VPEC_QUEUE4_CMDIB_RPTR__OFFSET__SHIFT                                                                 0x2
+#define VPEC_QUEUE4_CMDIB_RPTR__OFFSET_MASK                                                                   0x003FFFFCL
+//VPEC_QUEUE4_CMDIB_OFFSET
+#define VPEC_QUEUE4_CMDIB_OFFSET__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE4_CMDIB_OFFSET__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE4_CMDIB_BASE_LO
+#define VPEC_QUEUE4_CMDIB_BASE_LO__ADDR__SHIFT                                                                0x5
+#define VPEC_QUEUE4_CMDIB_BASE_LO__ADDR_MASK                                                                  0xFFFFFFE0L
+//VPEC_QUEUE4_CMDIB_BASE_HI
+#define VPEC_QUEUE4_CMDIB_BASE_HI__ADDR__SHIFT                                                                0x0
+#define VPEC_QUEUE4_CMDIB_BASE_HI__ADDR_MASK                                                                  0xFFFFFFFFL
+//VPEC_QUEUE4_CMDIB_SIZE
+#define VPEC_QUEUE4_CMDIB_SIZE__SIZE__SHIFT                                                                   0x0
+#define VPEC_QUEUE4_CMDIB_SIZE__SIZE_MASK                                                                     0x000FFFFFL
+//VPEC_QUEUE4_3DLUTIB_CNTL
+#define VPEC_QUEUE4_3DLUTIB_CNTL__IB_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE4_3DLUTIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                     0x8
+#define VPEC_QUEUE4_3DLUTIB_CNTL__CMD_VMID__SHIFT                                                             0x10
+#define VPEC_QUEUE4_3DLUTIB_CNTL__IB_PRIV__SHIFT                                                              0x1f
+#define VPEC_QUEUE4_3DLUTIB_CNTL__IB_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE4_3DLUTIB_CNTL__SWITCH_INSIDE_IB_MASK                                                       0x00000100L
+#define VPEC_QUEUE4_3DLUTIB_CNTL__CMD_VMID_MASK                                                               0x000F0000L
+#define VPEC_QUEUE4_3DLUTIB_CNTL__IB_PRIV_MASK                                                                0x80000000L
+//VPEC_QUEUE4_3DLUTIB_RPTR
+#define VPEC_QUEUE4_3DLUTIB_RPTR__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE4_3DLUTIB_RPTR__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE4_3DLUTIB_OFFSET
+#define VPEC_QUEUE4_3DLUTIB_OFFSET__OFFSET__SHIFT                                                             0x2
+#define VPEC_QUEUE4_3DLUTIB_OFFSET__OFFSET_MASK                                                               0x003FFFFCL
+//VPEC_QUEUE4_3DLUTIB_BASE_LO
+#define VPEC_QUEUE4_3DLUTIB_BASE_LO__ADDR__SHIFT                                                              0x5
+#define VPEC_QUEUE4_3DLUTIB_BASE_LO__ADDR_MASK                                                                0xFFFFFFE0L
+//VPEC_QUEUE4_3DLUTIB_BASE_HI
+#define VPEC_QUEUE4_3DLUTIB_BASE_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE4_3DLUTIB_BASE_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE4_3DLUTIB_SIZE
+#define VPEC_QUEUE4_3DLUTIB_SIZE__SIZE__SHIFT                                                                 0x0
+#define VPEC_QUEUE4_3DLUTIB_SIZE__SIZE_MASK                                                                   0x000FFFFFL
+//VPEC_QUEUE4_CSA_ADDR_LO
+#define VPEC_QUEUE4_CSA_ADDR_LO__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE4_CSA_ADDR_LO__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE4_CSA_ADDR_HI
+#define VPEC_QUEUE4_CSA_ADDR_HI__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE4_CSA_ADDR_HI__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE4_CONTEXT_STATUS
+#define VPEC_QUEUE4_CONTEXT_STATUS__SELECTED__SHIFT                                                           0x0
+#define VPEC_QUEUE4_CONTEXT_STATUS__USE_IB__SHIFT                                                             0x1
+#define VPEC_QUEUE4_CONTEXT_STATUS__IDLE__SHIFT                                                               0x2
+#define VPEC_QUEUE4_CONTEXT_STATUS__EXPIRED__SHIFT                                                            0x3
+#define VPEC_QUEUE4_CONTEXT_STATUS__EXCEPTION__SHIFT                                                          0x4
+#define VPEC_QUEUE4_CONTEXT_STATUS__CTXSW_ABLE__SHIFT                                                         0x7
+#define VPEC_QUEUE4_CONTEXT_STATUS__USE_3DLUTIB__SHIFT                                                        0x8
+#define VPEC_QUEUE4_CONTEXT_STATUS__PREEMPT_DISABLE__SHIFT                                                    0xa
+#define VPEC_QUEUE4_CONTEXT_STATUS__RPTR_WB_IDLE__SHIFT                                                       0xb
+#define VPEC_QUEUE4_CONTEXT_STATUS__WPTR_UPDATE_PENDING__SHIFT                                                0xc
+#define VPEC_QUEUE4_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT__SHIFT                                             0x10
+#define VPEC_QUEUE4_CONTEXT_STATUS__SELECTED_MASK                                                             0x00000001L
+#define VPEC_QUEUE4_CONTEXT_STATUS__USE_IB_MASK                                                               0x00000002L
+#define VPEC_QUEUE4_CONTEXT_STATUS__IDLE_MASK                                                                 0x00000004L
+#define VPEC_QUEUE4_CONTEXT_STATUS__EXPIRED_MASK                                                              0x00000008L
+#define VPEC_QUEUE4_CONTEXT_STATUS__EXCEPTION_MASK                                                            0x00000070L
+#define VPEC_QUEUE4_CONTEXT_STATUS__CTXSW_ABLE_MASK                                                           0x00000080L
+#define VPEC_QUEUE4_CONTEXT_STATUS__USE_3DLUTIB_MASK                                                          0x00000100L
+#define VPEC_QUEUE4_CONTEXT_STATUS__PREEMPT_DISABLE_MASK                                                      0x00000400L
+#define VPEC_QUEUE4_CONTEXT_STATUS__RPTR_WB_IDLE_MASK                                                         0x00000800L
+#define VPEC_QUEUE4_CONTEXT_STATUS__WPTR_UPDATE_PENDING_MASK                                                  0x00001000L
+#define VPEC_QUEUE4_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT_MASK                                               0x00FF0000L
+//VPEC_QUEUE4_DOORBELL_LOG
+#define VPEC_QUEUE4_DOORBELL_LOG__BE_ERROR__SHIFT                                                             0x0
+#define VPEC_QUEUE4_DOORBELL_LOG__DATA__SHIFT                                                                 0x2
+#define VPEC_QUEUE4_DOORBELL_LOG__BE_ERROR_MASK                                                               0x00000001L
+#define VPEC_QUEUE4_DOORBELL_LOG__DATA_MASK                                                                   0xFFFFFFFCL
+//VPEC_QUEUE4_IB_SUB_REMAIN
+#define VPEC_QUEUE4_IB_SUB_REMAIN__SIZE__SHIFT                                                                0x0
+#define VPEC_QUEUE4_IB_SUB_REMAIN__SIZE_MASK                                                                  0x00003FFFL
+//VPEC_QUEUE4_PREEMPT
+#define VPEC_QUEUE4_PREEMPT__IB_PREEMPT__SHIFT                                                                0x0
+#define VPEC_QUEUE4_PREEMPT__IB_PREEMPT_MASK                                                                  0x00000001L
+//VPEC_QUEUE4_LOG0BUFFER_CFG
+#define VPEC_QUEUE4_LOG0BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE4_LOG0BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE4_LOG0BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE4_LOG0BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE4_LOG0BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE4_LOG0BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE4_LOG0BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE4_LOG0BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE4_LOG1BUFFER_CFG
+#define VPEC_QUEUE4_LOG1BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE4_LOG1BUFFER_CFG__PARTIAL_ENTRY__SHIFT                                                      0x1
+#define VPEC_QUEUE4_LOG1BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE4_LOG1BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE4_LOG1BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE4_LOG1BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE4_LOG1BUFFER_CFG__PARTIAL_ENTRY_MASK                                                        0x00000002L
+#define VPEC_QUEUE4_LOG1BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE4_LOG1BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE4_LOG1BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE5_RB_CNTL
+#define VPEC_QUEUE5_RB_CNTL__RB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE5_RB_CNTL__RB_SIZE__SHIFT                                                                   0x1
+#define VPEC_QUEUE5_RB_CNTL__WPTR_POLL_ENABLE__SHIFT                                                          0x8
+#define VPEC_QUEUE5_RB_CNTL__RB_SWAP_ENABLE__SHIFT                                                            0x9
+#define VPEC_QUEUE5_RB_CNTL__WPTR_POLL_SWAP_ENABLE__SHIFT                                                     0xa
+#define VPEC_QUEUE5_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT                                                      0xb
+#define VPEC_QUEUE5_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                     0xc
+#define VPEC_QUEUE5_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                                0xd
+#define VPEC_QUEUE5_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                      0x10
+#define VPEC_QUEUE5_RB_CNTL__RB_PRIV__SHIFT                                                                   0x17
+#define VPEC_QUEUE5_RB_CNTL__RB_VMID__SHIFT                                                                   0x18
+#define VPEC_QUEUE5_RB_CNTL__RB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE5_RB_CNTL__RB_SIZE_MASK                                                                     0x0000003EL
+#define VPEC_QUEUE5_RB_CNTL__WPTR_POLL_ENABLE_MASK                                                            0x00000100L
+#define VPEC_QUEUE5_RB_CNTL__RB_SWAP_ENABLE_MASK                                                              0x00000200L
+#define VPEC_QUEUE5_RB_CNTL__WPTR_POLL_SWAP_ENABLE_MASK                                                       0x00000400L
+#define VPEC_QUEUE5_RB_CNTL__F32_WPTR_POLL_ENABLE_MASK                                                        0x00000800L
+#define VPEC_QUEUE5_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                       0x00001000L
+#define VPEC_QUEUE5_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                  0x00002000L
+#define VPEC_QUEUE5_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                        0x001F0000L
+#define VPEC_QUEUE5_RB_CNTL__RB_PRIV_MASK                                                                     0x00800000L
+#define VPEC_QUEUE5_RB_CNTL__RB_VMID_MASK                                                                     0x0F000000L
+//VPEC_QUEUE5_SCHEDULE_CNTL
+#define VPEC_QUEUE5_SCHEDULE_CNTL__GLOBAL_ID__SHIFT                                                           0x0
+#define VPEC_QUEUE5_SCHEDULE_CNTL__PROCESS_ID__SHIFT                                                          0x2
+#define VPEC_QUEUE5_SCHEDULE_CNTL__LOCAL_ID__SHIFT                                                            0x6
+#define VPEC_QUEUE5_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT                                                     0x8
+#define VPEC_QUEUE5_SCHEDULE_CNTL__GLOBAL_ID_MASK                                                             0x00000003L
+#define VPEC_QUEUE5_SCHEDULE_CNTL__PROCESS_ID_MASK                                                            0x0000001CL
+#define VPEC_QUEUE5_SCHEDULE_CNTL__LOCAL_ID_MASK                                                              0x000000C0L
+#define VPEC_QUEUE5_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK                                                       0x0000FF00L
+//VPEC_QUEUE5_RB_BASE
+#define VPEC_QUEUE5_RB_BASE__ADDR__SHIFT                                                                      0x0
+#define VPEC_QUEUE5_RB_BASE__ADDR_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE5_RB_BASE_HI
+#define VPEC_QUEUE5_RB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE5_RB_BASE_HI__ADDR_MASK                                                                     0x00FFFFFFL
+//VPEC_QUEUE5_RB_RPTR
+#define VPEC_QUEUE5_RB_RPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE5_RB_RPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE5_RB_RPTR_HI
+#define VPEC_QUEUE5_RB_RPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE5_RB_RPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE5_RB_WPTR
+#define VPEC_QUEUE5_RB_WPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE5_RB_WPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE5_RB_WPTR_HI
+#define VPEC_QUEUE5_RB_WPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE5_RB_WPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE5_RB_RPTR_ADDR_HI
+#define VPEC_QUEUE5_RB_RPTR_ADDR_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE5_RB_RPTR_ADDR_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE5_RB_RPTR_ADDR_LO
+#define VPEC_QUEUE5_RB_RPTR_ADDR_LO__ADDR__SHIFT                                                              0x2
+#define VPEC_QUEUE5_RB_RPTR_ADDR_LO__ADDR_MASK                                                                0xFFFFFFFCL
+//VPEC_QUEUE5_RB_AQL_CNTL
+#define VPEC_QUEUE5_RB_AQL_CNTL__AQL_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE5_RB_AQL_CNTL__AQL_PACKET_SIZE__SHIFT                                                       0x1
+#define VPEC_QUEUE5_RB_AQL_CNTL__PACKET_STEP__SHIFT                                                           0x8
+#define VPEC_QUEUE5_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE__SHIFT                                                 0x10
+#define VPEC_QUEUE5_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE__SHIFT                                           0x11
+#define VPEC_QUEUE5_RB_AQL_CNTL__OVERLAP_ENABLE__SHIFT                                                        0x12
+#define VPEC_QUEUE5_RB_AQL_CNTL__AQL_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE5_RB_AQL_CNTL__AQL_PACKET_SIZE_MASK                                                         0x000000FEL
+#define VPEC_QUEUE5_RB_AQL_CNTL__PACKET_STEP_MASK                                                             0x0000FF00L
+#define VPEC_QUEUE5_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE_MASK                                                   0x00010000L
+#define VPEC_QUEUE5_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE_MASK                                             0x00020000L
+#define VPEC_QUEUE5_RB_AQL_CNTL__OVERLAP_ENABLE_MASK                                                          0x00040000L
+//VPEC_QUEUE5_MINOR_PTR_UPDATE
+#define VPEC_QUEUE5_MINOR_PTR_UPDATE__ENABLE__SHIFT                                                           0x0
+#define VPEC_QUEUE5_MINOR_PTR_UPDATE__ENABLE_MASK                                                             0x00000001L
+//VPEC_QUEUE5_CD_INFO
+#define VPEC_QUEUE5_CD_INFO__CD_INFO__SHIFT                                                                   0x0
+#define VPEC_QUEUE5_CD_INFO__CD_INFO_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE5_RB_PREEMPT
+#define VPEC_QUEUE5_RB_PREEMPT__PREEMPT_REQ__SHIFT                                                            0x0
+#define VPEC_QUEUE5_RB_PREEMPT__PREEMPT_REQ_MASK                                                              0x00000001L
+//VPEC_QUEUE5_SKIP_CNTL
+#define VPEC_QUEUE5_SKIP_CNTL__SKIP_COUNT__SHIFT                                                              0x0
+#define VPEC_QUEUE5_SKIP_CNTL__SKIP_COUNT_MASK                                                                0x000FFFFFL
+//VPEC_QUEUE5_DOORBELL
+#define VPEC_QUEUE5_DOORBELL__ENABLE__SHIFT                                                                   0x1c
+#define VPEC_QUEUE5_DOORBELL__CAPTURED__SHIFT                                                                 0x1e
+#define VPEC_QUEUE5_DOORBELL__ENABLE_MASK                                                                     0x10000000L
+#define VPEC_QUEUE5_DOORBELL__CAPTURED_MASK                                                                   0x40000000L
+//VPEC_QUEUE5_DOORBELL_OFFSET
+#define VPEC_QUEUE5_DOORBELL_OFFSET__OFFSET__SHIFT                                                            0x2
+#define VPEC_QUEUE5_DOORBELL_OFFSET__OFFSET_MASK                                                              0x0FFFFFFCL
+//VPEC_QUEUE5_DUMMY0
+#define VPEC_QUEUE5_DUMMY0__DUMMY__SHIFT                                                                      0x0
+#define VPEC_QUEUE5_DUMMY0__DUMMY_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE5_DUMMY1
+#define VPEC_QUEUE5_DUMMY1__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE5_DUMMY1__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE5_DUMMY2
+#define VPEC_QUEUE5_DUMMY2__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE5_DUMMY2__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE5_DUMMY3
+#define VPEC_QUEUE5_DUMMY3__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE5_DUMMY3__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE5_DUMMY4
+#define VPEC_QUEUE5_DUMMY4__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE5_DUMMY4__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE5_IB_CNTL
+#define VPEC_QUEUE5_IB_CNTL__IB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE5_IB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                          0x8
+#define VPEC_QUEUE5_IB_CNTL__CMD_VMID__SHIFT                                                                  0x10
+#define VPEC_QUEUE5_IB_CNTL__IB_PRIV__SHIFT                                                                   0x1f
+#define VPEC_QUEUE5_IB_CNTL__IB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE5_IB_CNTL__SWITCH_INSIDE_IB_MASK                                                            0x00000100L
+#define VPEC_QUEUE5_IB_CNTL__CMD_VMID_MASK                                                                    0x000F0000L
+#define VPEC_QUEUE5_IB_CNTL__IB_PRIV_MASK                                                                     0x80000000L
+//VPEC_QUEUE5_IB_RPTR
+#define VPEC_QUEUE5_IB_RPTR__OFFSET__SHIFT                                                                    0x2
+#define VPEC_QUEUE5_IB_RPTR__OFFSET_MASK                                                                      0x003FFFFCL
+//VPEC_QUEUE5_IB_OFFSET
+#define VPEC_QUEUE5_IB_OFFSET__OFFSET__SHIFT                                                                  0x2
+#define VPEC_QUEUE5_IB_OFFSET__OFFSET_MASK                                                                    0x003FFFFCL
+//VPEC_QUEUE5_IB_BASE_LO
+#define VPEC_QUEUE5_IB_BASE_LO__ADDR__SHIFT                                                                   0x5
+#define VPEC_QUEUE5_IB_BASE_LO__ADDR_MASK                                                                     0xFFFFFFE0L
+//VPEC_QUEUE5_IB_BASE_HI
+#define VPEC_QUEUE5_IB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE5_IB_BASE_HI__ADDR_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE5_IB_SIZE
+#define VPEC_QUEUE5_IB_SIZE__SIZE__SHIFT                                                                      0x0
+#define VPEC_QUEUE5_IB_SIZE__SIZE_MASK                                                                        0x000FFFFFL
+//VPEC_QUEUE5_CMDIB_CNTL
+#define VPEC_QUEUE5_CMDIB_CNTL__IB_ENABLE__SHIFT                                                              0x0
+#define VPEC_QUEUE5_CMDIB_CNTL__IB_SWAP_ENABLE__SHIFT                                                         0x4
+#define VPEC_QUEUE5_CMDIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                       0x8
+#define VPEC_QUEUE5_CMDIB_CNTL__CMD_VMID__SHIFT                                                               0x10
+#define VPEC_QUEUE5_CMDIB_CNTL__IB_PRIV__SHIFT                                                                0x1f
+#define VPEC_QUEUE5_CMDIB_CNTL__IB_ENABLE_MASK                                                                0x00000001L
+#define VPEC_QUEUE5_CMDIB_CNTL__IB_SWAP_ENABLE_MASK                                                           0x00000010L
+#define VPEC_QUEUE5_CMDIB_CNTL__SWITCH_INSIDE_IB_MASK                                                         0x00000100L
+#define VPEC_QUEUE5_CMDIB_CNTL__CMD_VMID_MASK                                                                 0x000F0000L
+#define VPEC_QUEUE5_CMDIB_CNTL__IB_PRIV_MASK                                                                  0x80000000L
+//VPEC_QUEUE5_CMDIB_RPTR
+#define VPEC_QUEUE5_CMDIB_RPTR__OFFSET__SHIFT                                                                 0x2
+#define VPEC_QUEUE5_CMDIB_RPTR__OFFSET_MASK                                                                   0x003FFFFCL
+//VPEC_QUEUE5_CMDIB_OFFSET
+#define VPEC_QUEUE5_CMDIB_OFFSET__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE5_CMDIB_OFFSET__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE5_CMDIB_BASE_LO
+#define VPEC_QUEUE5_CMDIB_BASE_LO__ADDR__SHIFT                                                                0x5
+#define VPEC_QUEUE5_CMDIB_BASE_LO__ADDR_MASK                                                                  0xFFFFFFE0L
+//VPEC_QUEUE5_CMDIB_BASE_HI
+#define VPEC_QUEUE5_CMDIB_BASE_HI__ADDR__SHIFT                                                                0x0
+#define VPEC_QUEUE5_CMDIB_BASE_HI__ADDR_MASK                                                                  0xFFFFFFFFL
+//VPEC_QUEUE5_CMDIB_SIZE
+#define VPEC_QUEUE5_CMDIB_SIZE__SIZE__SHIFT                                                                   0x0
+#define VPEC_QUEUE5_CMDIB_SIZE__SIZE_MASK                                                                     0x000FFFFFL
+//VPEC_QUEUE5_3DLUTIB_CNTL
+#define VPEC_QUEUE5_3DLUTIB_CNTL__IB_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE5_3DLUTIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                     0x8
+#define VPEC_QUEUE5_3DLUTIB_CNTL__CMD_VMID__SHIFT                                                             0x10
+#define VPEC_QUEUE5_3DLUTIB_CNTL__IB_PRIV__SHIFT                                                              0x1f
+#define VPEC_QUEUE5_3DLUTIB_CNTL__IB_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE5_3DLUTIB_CNTL__SWITCH_INSIDE_IB_MASK                                                       0x00000100L
+#define VPEC_QUEUE5_3DLUTIB_CNTL__CMD_VMID_MASK                                                               0x000F0000L
+#define VPEC_QUEUE5_3DLUTIB_CNTL__IB_PRIV_MASK                                                                0x80000000L
+//VPEC_QUEUE5_3DLUTIB_RPTR
+#define VPEC_QUEUE5_3DLUTIB_RPTR__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE5_3DLUTIB_RPTR__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE5_3DLUTIB_OFFSET
+#define VPEC_QUEUE5_3DLUTIB_OFFSET__OFFSET__SHIFT                                                             0x2
+#define VPEC_QUEUE5_3DLUTIB_OFFSET__OFFSET_MASK                                                               0x003FFFFCL
+//VPEC_QUEUE5_3DLUTIB_BASE_LO
+#define VPEC_QUEUE5_3DLUTIB_BASE_LO__ADDR__SHIFT                                                              0x5
+#define VPEC_QUEUE5_3DLUTIB_BASE_LO__ADDR_MASK                                                                0xFFFFFFE0L
+//VPEC_QUEUE5_3DLUTIB_BASE_HI
+#define VPEC_QUEUE5_3DLUTIB_BASE_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE5_3DLUTIB_BASE_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE5_3DLUTIB_SIZE
+#define VPEC_QUEUE5_3DLUTIB_SIZE__SIZE__SHIFT                                                                 0x0
+#define VPEC_QUEUE5_3DLUTIB_SIZE__SIZE_MASK                                                                   0x000FFFFFL
+//VPEC_QUEUE5_CSA_ADDR_LO
+#define VPEC_QUEUE5_CSA_ADDR_LO__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE5_CSA_ADDR_LO__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE5_CSA_ADDR_HI
+#define VPEC_QUEUE5_CSA_ADDR_HI__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE5_CSA_ADDR_HI__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE5_CONTEXT_STATUS
+#define VPEC_QUEUE5_CONTEXT_STATUS__SELECTED__SHIFT                                                           0x0
+#define VPEC_QUEUE5_CONTEXT_STATUS__USE_IB__SHIFT                                                             0x1
+#define VPEC_QUEUE5_CONTEXT_STATUS__IDLE__SHIFT                                                               0x2
+#define VPEC_QUEUE5_CONTEXT_STATUS__EXPIRED__SHIFT                                                            0x3
+#define VPEC_QUEUE5_CONTEXT_STATUS__EXCEPTION__SHIFT                                                          0x4
+#define VPEC_QUEUE5_CONTEXT_STATUS__CTXSW_ABLE__SHIFT                                                         0x7
+#define VPEC_QUEUE5_CONTEXT_STATUS__USE_3DLUTIB__SHIFT                                                        0x8
+#define VPEC_QUEUE5_CONTEXT_STATUS__PREEMPT_DISABLE__SHIFT                                                    0xa
+#define VPEC_QUEUE5_CONTEXT_STATUS__RPTR_WB_IDLE__SHIFT                                                       0xb
+#define VPEC_QUEUE5_CONTEXT_STATUS__WPTR_UPDATE_PENDING__SHIFT                                                0xc
+#define VPEC_QUEUE5_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT__SHIFT                                             0x10
+#define VPEC_QUEUE5_CONTEXT_STATUS__SELECTED_MASK                                                             0x00000001L
+#define VPEC_QUEUE5_CONTEXT_STATUS__USE_IB_MASK                                                               0x00000002L
+#define VPEC_QUEUE5_CONTEXT_STATUS__IDLE_MASK                                                                 0x00000004L
+#define VPEC_QUEUE5_CONTEXT_STATUS__EXPIRED_MASK                                                              0x00000008L
+#define VPEC_QUEUE5_CONTEXT_STATUS__EXCEPTION_MASK                                                            0x00000070L
+#define VPEC_QUEUE5_CONTEXT_STATUS__CTXSW_ABLE_MASK                                                           0x00000080L
+#define VPEC_QUEUE5_CONTEXT_STATUS__USE_3DLUTIB_MASK                                                          0x00000100L
+#define VPEC_QUEUE5_CONTEXT_STATUS__PREEMPT_DISABLE_MASK                                                      0x00000400L
+#define VPEC_QUEUE5_CONTEXT_STATUS__RPTR_WB_IDLE_MASK                                                         0x00000800L
+#define VPEC_QUEUE5_CONTEXT_STATUS__WPTR_UPDATE_PENDING_MASK                                                  0x00001000L
+#define VPEC_QUEUE5_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT_MASK                                               0x00FF0000L
+//VPEC_QUEUE5_DOORBELL_LOG
+#define VPEC_QUEUE5_DOORBELL_LOG__BE_ERROR__SHIFT                                                             0x0
+#define VPEC_QUEUE5_DOORBELL_LOG__DATA__SHIFT                                                                 0x2
+#define VPEC_QUEUE5_DOORBELL_LOG__BE_ERROR_MASK                                                               0x00000001L
+#define VPEC_QUEUE5_DOORBELL_LOG__DATA_MASK                                                                   0xFFFFFFFCL
+//VPEC_QUEUE5_IB_SUB_REMAIN
+#define VPEC_QUEUE5_IB_SUB_REMAIN__SIZE__SHIFT                                                                0x0
+#define VPEC_QUEUE5_IB_SUB_REMAIN__SIZE_MASK                                                                  0x00003FFFL
+//VPEC_QUEUE5_PREEMPT
+#define VPEC_QUEUE5_PREEMPT__IB_PREEMPT__SHIFT                                                                0x0
+#define VPEC_QUEUE5_PREEMPT__IB_PREEMPT_MASK                                                                  0x00000001L
+//VPEC_QUEUE5_LOG0BUFFER_CFG
+#define VPEC_QUEUE5_LOG0BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE5_LOG0BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE5_LOG0BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE5_LOG0BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE5_LOG0BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE5_LOG0BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE5_LOG0BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE5_LOG0BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE5_LOG1BUFFER_CFG
+#define VPEC_QUEUE5_LOG1BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE5_LOG1BUFFER_CFG__PARTIAL_ENTRY__SHIFT                                                      0x1
+#define VPEC_QUEUE5_LOG1BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE5_LOG1BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE5_LOG1BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE5_LOG1BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE5_LOG1BUFFER_CFG__PARTIAL_ENTRY_MASK                                                        0x00000002L
+#define VPEC_QUEUE5_LOG1BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE5_LOG1BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE5_LOG1BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE6_RB_CNTL
+#define VPEC_QUEUE6_RB_CNTL__RB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE6_RB_CNTL__RB_SIZE__SHIFT                                                                   0x1
+#define VPEC_QUEUE6_RB_CNTL__WPTR_POLL_ENABLE__SHIFT                                                          0x8
+#define VPEC_QUEUE6_RB_CNTL__RB_SWAP_ENABLE__SHIFT                                                            0x9
+#define VPEC_QUEUE6_RB_CNTL__WPTR_POLL_SWAP_ENABLE__SHIFT                                                     0xa
+#define VPEC_QUEUE6_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT                                                      0xb
+#define VPEC_QUEUE6_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                     0xc
+#define VPEC_QUEUE6_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                                0xd
+#define VPEC_QUEUE6_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                      0x10
+#define VPEC_QUEUE6_RB_CNTL__RB_PRIV__SHIFT                                                                   0x17
+#define VPEC_QUEUE6_RB_CNTL__RB_VMID__SHIFT                                                                   0x18
+#define VPEC_QUEUE6_RB_CNTL__RB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE6_RB_CNTL__RB_SIZE_MASK                                                                     0x0000003EL
+#define VPEC_QUEUE6_RB_CNTL__WPTR_POLL_ENABLE_MASK                                                            0x00000100L
+#define VPEC_QUEUE6_RB_CNTL__RB_SWAP_ENABLE_MASK                                                              0x00000200L
+#define VPEC_QUEUE6_RB_CNTL__WPTR_POLL_SWAP_ENABLE_MASK                                                       0x00000400L
+#define VPEC_QUEUE6_RB_CNTL__F32_WPTR_POLL_ENABLE_MASK                                                        0x00000800L
+#define VPEC_QUEUE6_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                       0x00001000L
+#define VPEC_QUEUE6_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                  0x00002000L
+#define VPEC_QUEUE6_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                        0x001F0000L
+#define VPEC_QUEUE6_RB_CNTL__RB_PRIV_MASK                                                                     0x00800000L
+#define VPEC_QUEUE6_RB_CNTL__RB_VMID_MASK                                                                     0x0F000000L
+//VPEC_QUEUE6_SCHEDULE_CNTL
+#define VPEC_QUEUE6_SCHEDULE_CNTL__GLOBAL_ID__SHIFT                                                           0x0
+#define VPEC_QUEUE6_SCHEDULE_CNTL__PROCESS_ID__SHIFT                                                          0x2
+#define VPEC_QUEUE6_SCHEDULE_CNTL__LOCAL_ID__SHIFT                                                            0x6
+#define VPEC_QUEUE6_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT                                                     0x8
+#define VPEC_QUEUE6_SCHEDULE_CNTL__GLOBAL_ID_MASK                                                             0x00000003L
+#define VPEC_QUEUE6_SCHEDULE_CNTL__PROCESS_ID_MASK                                                            0x0000001CL
+#define VPEC_QUEUE6_SCHEDULE_CNTL__LOCAL_ID_MASK                                                              0x000000C0L
+#define VPEC_QUEUE6_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK                                                       0x0000FF00L
+//VPEC_QUEUE6_RB_BASE
+#define VPEC_QUEUE6_RB_BASE__ADDR__SHIFT                                                                      0x0
+#define VPEC_QUEUE6_RB_BASE__ADDR_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE6_RB_BASE_HI
+#define VPEC_QUEUE6_RB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE6_RB_BASE_HI__ADDR_MASK                                                                     0x00FFFFFFL
+//VPEC_QUEUE6_RB_RPTR
+#define VPEC_QUEUE6_RB_RPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE6_RB_RPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE6_RB_RPTR_HI
+#define VPEC_QUEUE6_RB_RPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE6_RB_RPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE6_RB_WPTR
+#define VPEC_QUEUE6_RB_WPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE6_RB_WPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE6_RB_WPTR_HI
+#define VPEC_QUEUE6_RB_WPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE6_RB_WPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE6_RB_RPTR_ADDR_HI
+#define VPEC_QUEUE6_RB_RPTR_ADDR_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE6_RB_RPTR_ADDR_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE6_RB_RPTR_ADDR_LO
+#define VPEC_QUEUE6_RB_RPTR_ADDR_LO__ADDR__SHIFT                                                              0x2
+#define VPEC_QUEUE6_RB_RPTR_ADDR_LO__ADDR_MASK                                                                0xFFFFFFFCL
+//VPEC_QUEUE6_RB_AQL_CNTL
+#define VPEC_QUEUE6_RB_AQL_CNTL__AQL_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE6_RB_AQL_CNTL__AQL_PACKET_SIZE__SHIFT                                                       0x1
+#define VPEC_QUEUE6_RB_AQL_CNTL__PACKET_STEP__SHIFT                                                           0x8
+#define VPEC_QUEUE6_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE__SHIFT                                                 0x10
+#define VPEC_QUEUE6_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE__SHIFT                                           0x11
+#define VPEC_QUEUE6_RB_AQL_CNTL__OVERLAP_ENABLE__SHIFT                                                        0x12
+#define VPEC_QUEUE6_RB_AQL_CNTL__AQL_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE6_RB_AQL_CNTL__AQL_PACKET_SIZE_MASK                                                         0x000000FEL
+#define VPEC_QUEUE6_RB_AQL_CNTL__PACKET_STEP_MASK                                                             0x0000FF00L
+#define VPEC_QUEUE6_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE_MASK                                                   0x00010000L
+#define VPEC_QUEUE6_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE_MASK                                             0x00020000L
+#define VPEC_QUEUE6_RB_AQL_CNTL__OVERLAP_ENABLE_MASK                                                          0x00040000L
+//VPEC_QUEUE6_MINOR_PTR_UPDATE
+#define VPEC_QUEUE6_MINOR_PTR_UPDATE__ENABLE__SHIFT                                                           0x0
+#define VPEC_QUEUE6_MINOR_PTR_UPDATE__ENABLE_MASK                                                             0x00000001L
+//VPEC_QUEUE6_CD_INFO
+#define VPEC_QUEUE6_CD_INFO__CD_INFO__SHIFT                                                                   0x0
+#define VPEC_QUEUE6_CD_INFO__CD_INFO_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE6_RB_PREEMPT
+#define VPEC_QUEUE6_RB_PREEMPT__PREEMPT_REQ__SHIFT                                                            0x0
+#define VPEC_QUEUE6_RB_PREEMPT__PREEMPT_REQ_MASK                                                              0x00000001L
+//VPEC_QUEUE6_SKIP_CNTL
+#define VPEC_QUEUE6_SKIP_CNTL__SKIP_COUNT__SHIFT                                                              0x0
+#define VPEC_QUEUE6_SKIP_CNTL__SKIP_COUNT_MASK                                                                0x000FFFFFL
+//VPEC_QUEUE6_DOORBELL
+#define VPEC_QUEUE6_DOORBELL__ENABLE__SHIFT                                                                   0x1c
+#define VPEC_QUEUE6_DOORBELL__CAPTURED__SHIFT                                                                 0x1e
+#define VPEC_QUEUE6_DOORBELL__ENABLE_MASK                                                                     0x10000000L
+#define VPEC_QUEUE6_DOORBELL__CAPTURED_MASK                                                                   0x40000000L
+//VPEC_QUEUE6_DOORBELL_OFFSET
+#define VPEC_QUEUE6_DOORBELL_OFFSET__OFFSET__SHIFT                                                            0x2
+#define VPEC_QUEUE6_DOORBELL_OFFSET__OFFSET_MASK                                                              0x0FFFFFFCL
+//VPEC_QUEUE6_DUMMY0
+#define VPEC_QUEUE6_DUMMY0__DUMMY__SHIFT                                                                      0x0
+#define VPEC_QUEUE6_DUMMY0__DUMMY_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE6_DUMMY1
+#define VPEC_QUEUE6_DUMMY1__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE6_DUMMY1__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE6_DUMMY2
+#define VPEC_QUEUE6_DUMMY2__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE6_DUMMY2__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE6_DUMMY3
+#define VPEC_QUEUE6_DUMMY3__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE6_DUMMY3__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE6_DUMMY4
+#define VPEC_QUEUE6_DUMMY4__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE6_DUMMY4__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE6_IB_CNTL
+#define VPEC_QUEUE6_IB_CNTL__IB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE6_IB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                          0x8
+#define VPEC_QUEUE6_IB_CNTL__CMD_VMID__SHIFT                                                                  0x10
+#define VPEC_QUEUE6_IB_CNTL__IB_PRIV__SHIFT                                                                   0x1f
+#define VPEC_QUEUE6_IB_CNTL__IB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE6_IB_CNTL__SWITCH_INSIDE_IB_MASK                                                            0x00000100L
+#define VPEC_QUEUE6_IB_CNTL__CMD_VMID_MASK                                                                    0x000F0000L
+#define VPEC_QUEUE6_IB_CNTL__IB_PRIV_MASK                                                                     0x80000000L
+//VPEC_QUEUE6_IB_RPTR
+#define VPEC_QUEUE6_IB_RPTR__OFFSET__SHIFT                                                                    0x2
+#define VPEC_QUEUE6_IB_RPTR__OFFSET_MASK                                                                      0x003FFFFCL
+//VPEC_QUEUE6_IB_OFFSET
+#define VPEC_QUEUE6_IB_OFFSET__OFFSET__SHIFT                                                                  0x2
+#define VPEC_QUEUE6_IB_OFFSET__OFFSET_MASK                                                                    0x003FFFFCL
+//VPEC_QUEUE6_IB_BASE_LO
+#define VPEC_QUEUE6_IB_BASE_LO__ADDR__SHIFT                                                                   0x5
+#define VPEC_QUEUE6_IB_BASE_LO__ADDR_MASK                                                                     0xFFFFFFE0L
+//VPEC_QUEUE6_IB_BASE_HI
+#define VPEC_QUEUE6_IB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE6_IB_BASE_HI__ADDR_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE6_IB_SIZE
+#define VPEC_QUEUE6_IB_SIZE__SIZE__SHIFT                                                                      0x0
+#define VPEC_QUEUE6_IB_SIZE__SIZE_MASK                                                                        0x000FFFFFL
+//VPEC_QUEUE6_CMDIB_CNTL
+#define VPEC_QUEUE6_CMDIB_CNTL__IB_ENABLE__SHIFT                                                              0x0
+#define VPEC_QUEUE6_CMDIB_CNTL__IB_SWAP_ENABLE__SHIFT                                                         0x4
+#define VPEC_QUEUE6_CMDIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                       0x8
+#define VPEC_QUEUE6_CMDIB_CNTL__CMD_VMID__SHIFT                                                               0x10
+#define VPEC_QUEUE6_CMDIB_CNTL__IB_PRIV__SHIFT                                                                0x1f
+#define VPEC_QUEUE6_CMDIB_CNTL__IB_ENABLE_MASK                                                                0x00000001L
+#define VPEC_QUEUE6_CMDIB_CNTL__IB_SWAP_ENABLE_MASK                                                           0x00000010L
+#define VPEC_QUEUE6_CMDIB_CNTL__SWITCH_INSIDE_IB_MASK                                                         0x00000100L
+#define VPEC_QUEUE6_CMDIB_CNTL__CMD_VMID_MASK                                                                 0x000F0000L
+#define VPEC_QUEUE6_CMDIB_CNTL__IB_PRIV_MASK                                                                  0x80000000L
+//VPEC_QUEUE6_CMDIB_RPTR
+#define VPEC_QUEUE6_CMDIB_RPTR__OFFSET__SHIFT                                                                 0x2
+#define VPEC_QUEUE6_CMDIB_RPTR__OFFSET_MASK                                                                   0x003FFFFCL
+//VPEC_QUEUE6_CMDIB_OFFSET
+#define VPEC_QUEUE6_CMDIB_OFFSET__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE6_CMDIB_OFFSET__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE6_CMDIB_BASE_LO
+#define VPEC_QUEUE6_CMDIB_BASE_LO__ADDR__SHIFT                                                                0x5
+#define VPEC_QUEUE6_CMDIB_BASE_LO__ADDR_MASK                                                                  0xFFFFFFE0L
+//VPEC_QUEUE6_CMDIB_BASE_HI
+#define VPEC_QUEUE6_CMDIB_BASE_HI__ADDR__SHIFT                                                                0x0
+#define VPEC_QUEUE6_CMDIB_BASE_HI__ADDR_MASK                                                                  0xFFFFFFFFL
+//VPEC_QUEUE6_CMDIB_SIZE
+#define VPEC_QUEUE6_CMDIB_SIZE__SIZE__SHIFT                                                                   0x0
+#define VPEC_QUEUE6_CMDIB_SIZE__SIZE_MASK                                                                     0x000FFFFFL
+//VPEC_QUEUE6_3DLUTIB_CNTL
+#define VPEC_QUEUE6_3DLUTIB_CNTL__IB_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE6_3DLUTIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                     0x8
+#define VPEC_QUEUE6_3DLUTIB_CNTL__CMD_VMID__SHIFT                                                             0x10
+#define VPEC_QUEUE6_3DLUTIB_CNTL__IB_PRIV__SHIFT                                                              0x1f
+#define VPEC_QUEUE6_3DLUTIB_CNTL__IB_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE6_3DLUTIB_CNTL__SWITCH_INSIDE_IB_MASK                                                       0x00000100L
+#define VPEC_QUEUE6_3DLUTIB_CNTL__CMD_VMID_MASK                                                               0x000F0000L
+#define VPEC_QUEUE6_3DLUTIB_CNTL__IB_PRIV_MASK                                                                0x80000000L
+//VPEC_QUEUE6_3DLUTIB_RPTR
+#define VPEC_QUEUE6_3DLUTIB_RPTR__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE6_3DLUTIB_RPTR__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE6_3DLUTIB_OFFSET
+#define VPEC_QUEUE6_3DLUTIB_OFFSET__OFFSET__SHIFT                                                             0x2
+#define VPEC_QUEUE6_3DLUTIB_OFFSET__OFFSET_MASK                                                               0x003FFFFCL
+//VPEC_QUEUE6_3DLUTIB_BASE_LO
+#define VPEC_QUEUE6_3DLUTIB_BASE_LO__ADDR__SHIFT                                                              0x5
+#define VPEC_QUEUE6_3DLUTIB_BASE_LO__ADDR_MASK                                                                0xFFFFFFE0L
+//VPEC_QUEUE6_3DLUTIB_BASE_HI
+#define VPEC_QUEUE6_3DLUTIB_BASE_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE6_3DLUTIB_BASE_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE6_3DLUTIB_SIZE
+#define VPEC_QUEUE6_3DLUTIB_SIZE__SIZE__SHIFT                                                                 0x0
+#define VPEC_QUEUE6_3DLUTIB_SIZE__SIZE_MASK                                                                   0x000FFFFFL
+//VPEC_QUEUE6_CSA_ADDR_LO
+#define VPEC_QUEUE6_CSA_ADDR_LO__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE6_CSA_ADDR_LO__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE6_CSA_ADDR_HI
+#define VPEC_QUEUE6_CSA_ADDR_HI__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE6_CSA_ADDR_HI__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE6_CONTEXT_STATUS
+#define VPEC_QUEUE6_CONTEXT_STATUS__SELECTED__SHIFT                                                           0x0
+#define VPEC_QUEUE6_CONTEXT_STATUS__USE_IB__SHIFT                                                             0x1
+#define VPEC_QUEUE6_CONTEXT_STATUS__IDLE__SHIFT                                                               0x2
+#define VPEC_QUEUE6_CONTEXT_STATUS__EXPIRED__SHIFT                                                            0x3
+#define VPEC_QUEUE6_CONTEXT_STATUS__EXCEPTION__SHIFT                                                          0x4
+#define VPEC_QUEUE6_CONTEXT_STATUS__CTXSW_ABLE__SHIFT                                                         0x7
+#define VPEC_QUEUE6_CONTEXT_STATUS__USE_3DLUTIB__SHIFT                                                        0x8
+#define VPEC_QUEUE6_CONTEXT_STATUS__PREEMPT_DISABLE__SHIFT                                                    0xa
+#define VPEC_QUEUE6_CONTEXT_STATUS__RPTR_WB_IDLE__SHIFT                                                       0xb
+#define VPEC_QUEUE6_CONTEXT_STATUS__WPTR_UPDATE_PENDING__SHIFT                                                0xc
+#define VPEC_QUEUE6_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT__SHIFT                                             0x10
+#define VPEC_QUEUE6_CONTEXT_STATUS__SELECTED_MASK                                                             0x00000001L
+#define VPEC_QUEUE6_CONTEXT_STATUS__USE_IB_MASK                                                               0x00000002L
+#define VPEC_QUEUE6_CONTEXT_STATUS__IDLE_MASK                                                                 0x00000004L
+#define VPEC_QUEUE6_CONTEXT_STATUS__EXPIRED_MASK                                                              0x00000008L
+#define VPEC_QUEUE6_CONTEXT_STATUS__EXCEPTION_MASK                                                            0x00000070L
+#define VPEC_QUEUE6_CONTEXT_STATUS__CTXSW_ABLE_MASK                                                           0x00000080L
+#define VPEC_QUEUE6_CONTEXT_STATUS__USE_3DLUTIB_MASK                                                          0x00000100L
+#define VPEC_QUEUE6_CONTEXT_STATUS__PREEMPT_DISABLE_MASK                                                      0x00000400L
+#define VPEC_QUEUE6_CONTEXT_STATUS__RPTR_WB_IDLE_MASK                                                         0x00000800L
+#define VPEC_QUEUE6_CONTEXT_STATUS__WPTR_UPDATE_PENDING_MASK                                                  0x00001000L
+#define VPEC_QUEUE6_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT_MASK                                               0x00FF0000L
+//VPEC_QUEUE6_DOORBELL_LOG
+#define VPEC_QUEUE6_DOORBELL_LOG__BE_ERROR__SHIFT                                                             0x0
+#define VPEC_QUEUE6_DOORBELL_LOG__DATA__SHIFT                                                                 0x2
+#define VPEC_QUEUE6_DOORBELL_LOG__BE_ERROR_MASK                                                               0x00000001L
+#define VPEC_QUEUE6_DOORBELL_LOG__DATA_MASK                                                                   0xFFFFFFFCL
+//VPEC_QUEUE6_IB_SUB_REMAIN
+#define VPEC_QUEUE6_IB_SUB_REMAIN__SIZE__SHIFT                                                                0x0
+#define VPEC_QUEUE6_IB_SUB_REMAIN__SIZE_MASK                                                                  0x00003FFFL
+//VPEC_QUEUE6_PREEMPT
+#define VPEC_QUEUE6_PREEMPT__IB_PREEMPT__SHIFT                                                                0x0
+#define VPEC_QUEUE6_PREEMPT__IB_PREEMPT_MASK                                                                  0x00000001L
+//VPEC_QUEUE6_LOG0BUFFER_CFG
+#define VPEC_QUEUE6_LOG0BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE6_LOG0BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE6_LOG0BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE6_LOG0BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE6_LOG0BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE6_LOG0BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE6_LOG0BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE6_LOG0BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE6_LOG1BUFFER_CFG
+#define VPEC_QUEUE6_LOG1BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE6_LOG1BUFFER_CFG__PARTIAL_ENTRY__SHIFT                                                      0x1
+#define VPEC_QUEUE6_LOG1BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE6_LOG1BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE6_LOG1BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE6_LOG1BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE6_LOG1BUFFER_CFG__PARTIAL_ENTRY_MASK                                                        0x00000002L
+#define VPEC_QUEUE6_LOG1BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE6_LOG1BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE6_LOG1BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE7_RB_CNTL
+#define VPEC_QUEUE7_RB_CNTL__RB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE7_RB_CNTL__RB_SIZE__SHIFT                                                                   0x1
+#define VPEC_QUEUE7_RB_CNTL__WPTR_POLL_ENABLE__SHIFT                                                          0x8
+#define VPEC_QUEUE7_RB_CNTL__RB_SWAP_ENABLE__SHIFT                                                            0x9
+#define VPEC_QUEUE7_RB_CNTL__WPTR_POLL_SWAP_ENABLE__SHIFT                                                     0xa
+#define VPEC_QUEUE7_RB_CNTL__F32_WPTR_POLL_ENABLE__SHIFT                                                      0xb
+#define VPEC_QUEUE7_RB_CNTL__RPTR_WRITEBACK_ENABLE__SHIFT                                                     0xc
+#define VPEC_QUEUE7_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE__SHIFT                                                0xd
+#define VPEC_QUEUE7_RB_CNTL__RPTR_WRITEBACK_TIMER__SHIFT                                                      0x10
+#define VPEC_QUEUE7_RB_CNTL__RB_PRIV__SHIFT                                                                   0x17
+#define VPEC_QUEUE7_RB_CNTL__RB_VMID__SHIFT                                                                   0x18
+#define VPEC_QUEUE7_RB_CNTL__RB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE7_RB_CNTL__RB_SIZE_MASK                                                                     0x0000003EL
+#define VPEC_QUEUE7_RB_CNTL__WPTR_POLL_ENABLE_MASK                                                            0x00000100L
+#define VPEC_QUEUE7_RB_CNTL__RB_SWAP_ENABLE_MASK                                                              0x00000200L
+#define VPEC_QUEUE7_RB_CNTL__WPTR_POLL_SWAP_ENABLE_MASK                                                       0x00000400L
+#define VPEC_QUEUE7_RB_CNTL__F32_WPTR_POLL_ENABLE_MASK                                                        0x00000800L
+#define VPEC_QUEUE7_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK                                                       0x00001000L
+#define VPEC_QUEUE7_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK                                                  0x00002000L
+#define VPEC_QUEUE7_RB_CNTL__RPTR_WRITEBACK_TIMER_MASK                                                        0x001F0000L
+#define VPEC_QUEUE7_RB_CNTL__RB_PRIV_MASK                                                                     0x00800000L
+#define VPEC_QUEUE7_RB_CNTL__RB_VMID_MASK                                                                     0x0F000000L
+//VPEC_QUEUE7_SCHEDULE_CNTL
+#define VPEC_QUEUE7_SCHEDULE_CNTL__GLOBAL_ID__SHIFT                                                           0x0
+#define VPEC_QUEUE7_SCHEDULE_CNTL__PROCESS_ID__SHIFT                                                          0x2
+#define VPEC_QUEUE7_SCHEDULE_CNTL__LOCAL_ID__SHIFT                                                            0x6
+#define VPEC_QUEUE7_SCHEDULE_CNTL__CONTEXT_QUANTUM__SHIFT                                                     0x8
+#define VPEC_QUEUE7_SCHEDULE_CNTL__GLOBAL_ID_MASK                                                             0x00000003L
+#define VPEC_QUEUE7_SCHEDULE_CNTL__PROCESS_ID_MASK                                                            0x0000001CL
+#define VPEC_QUEUE7_SCHEDULE_CNTL__LOCAL_ID_MASK                                                              0x000000C0L
+#define VPEC_QUEUE7_SCHEDULE_CNTL__CONTEXT_QUANTUM_MASK                                                       0x0000FF00L
+//VPEC_QUEUE7_RB_BASE
+#define VPEC_QUEUE7_RB_BASE__ADDR__SHIFT                                                                      0x0
+#define VPEC_QUEUE7_RB_BASE__ADDR_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE7_RB_BASE_HI
+#define VPEC_QUEUE7_RB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE7_RB_BASE_HI__ADDR_MASK                                                                     0x00FFFFFFL
+//VPEC_QUEUE7_RB_RPTR
+#define VPEC_QUEUE7_RB_RPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE7_RB_RPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE7_RB_RPTR_HI
+#define VPEC_QUEUE7_RB_RPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE7_RB_RPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE7_RB_WPTR
+#define VPEC_QUEUE7_RB_WPTR__OFFSET__SHIFT                                                                    0x0
+#define VPEC_QUEUE7_RB_WPTR__OFFSET_MASK                                                                      0xFFFFFFFFL
+//VPEC_QUEUE7_RB_WPTR_HI
+#define VPEC_QUEUE7_RB_WPTR_HI__OFFSET__SHIFT                                                                 0x0
+#define VPEC_QUEUE7_RB_WPTR_HI__OFFSET_MASK                                                                   0xFFFFFFFFL
+//VPEC_QUEUE7_RB_RPTR_ADDR_HI
+#define VPEC_QUEUE7_RB_RPTR_ADDR_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE7_RB_RPTR_ADDR_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE7_RB_RPTR_ADDR_LO
+#define VPEC_QUEUE7_RB_RPTR_ADDR_LO__ADDR__SHIFT                                                              0x2
+#define VPEC_QUEUE7_RB_RPTR_ADDR_LO__ADDR_MASK                                                                0xFFFFFFFCL
+//VPEC_QUEUE7_RB_AQL_CNTL
+#define VPEC_QUEUE7_RB_AQL_CNTL__AQL_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE7_RB_AQL_CNTL__AQL_PACKET_SIZE__SHIFT                                                       0x1
+#define VPEC_QUEUE7_RB_AQL_CNTL__PACKET_STEP__SHIFT                                                           0x8
+#define VPEC_QUEUE7_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE__SHIFT                                                 0x10
+#define VPEC_QUEUE7_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE__SHIFT                                           0x11
+#define VPEC_QUEUE7_RB_AQL_CNTL__OVERLAP_ENABLE__SHIFT                                                        0x12
+#define VPEC_QUEUE7_RB_AQL_CNTL__AQL_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE7_RB_AQL_CNTL__AQL_PACKET_SIZE_MASK                                                         0x000000FEL
+#define VPEC_QUEUE7_RB_AQL_CNTL__PACKET_STEP_MASK                                                             0x0000FF00L
+#define VPEC_QUEUE7_RB_AQL_CNTL__MIDCMD_PREEMPT_ENABLE_MASK                                                   0x00010000L
+#define VPEC_QUEUE7_RB_AQL_CNTL__MIDCMD_PREEMPT_DATA_RESTORE_MASK                                             0x00020000L
+#define VPEC_QUEUE7_RB_AQL_CNTL__OVERLAP_ENABLE_MASK                                                          0x00040000L
+//VPEC_QUEUE7_MINOR_PTR_UPDATE
+#define VPEC_QUEUE7_MINOR_PTR_UPDATE__ENABLE__SHIFT                                                           0x0
+#define VPEC_QUEUE7_MINOR_PTR_UPDATE__ENABLE_MASK                                                             0x00000001L
+//VPEC_QUEUE7_CD_INFO
+#define VPEC_QUEUE7_CD_INFO__CD_INFO__SHIFT                                                                   0x0
+#define VPEC_QUEUE7_CD_INFO__CD_INFO_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE7_RB_PREEMPT
+#define VPEC_QUEUE7_RB_PREEMPT__PREEMPT_REQ__SHIFT                                                            0x0
+#define VPEC_QUEUE7_RB_PREEMPT__PREEMPT_REQ_MASK                                                              0x00000001L
+//VPEC_QUEUE7_SKIP_CNTL
+#define VPEC_QUEUE7_SKIP_CNTL__SKIP_COUNT__SHIFT                                                              0x0
+#define VPEC_QUEUE7_SKIP_CNTL__SKIP_COUNT_MASK                                                                0x000FFFFFL
+//VPEC_QUEUE7_DOORBELL
+#define VPEC_QUEUE7_DOORBELL__ENABLE__SHIFT                                                                   0x1c
+#define VPEC_QUEUE7_DOORBELL__CAPTURED__SHIFT                                                                 0x1e
+#define VPEC_QUEUE7_DOORBELL__ENABLE_MASK                                                                     0x10000000L
+#define VPEC_QUEUE7_DOORBELL__CAPTURED_MASK                                                                   0x40000000L
+//VPEC_QUEUE7_DOORBELL_OFFSET
+#define VPEC_QUEUE7_DOORBELL_OFFSET__OFFSET__SHIFT                                                            0x2
+#define VPEC_QUEUE7_DOORBELL_OFFSET__OFFSET_MASK                                                              0x0FFFFFFCL
+//VPEC_QUEUE7_DUMMY0
+#define VPEC_QUEUE7_DUMMY0__DUMMY__SHIFT                                                                      0x0
+#define VPEC_QUEUE7_DUMMY0__DUMMY_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE7_DUMMY1
+#define VPEC_QUEUE7_DUMMY1__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE7_DUMMY1__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE7_DUMMY2
+#define VPEC_QUEUE7_DUMMY2__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE7_DUMMY2__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE7_DUMMY3
+#define VPEC_QUEUE7_DUMMY3__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE7_DUMMY3__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE7_DUMMY4
+#define VPEC_QUEUE7_DUMMY4__VALUE__SHIFT                                                                      0x0
+#define VPEC_QUEUE7_DUMMY4__VALUE_MASK                                                                        0xFFFFFFFFL
+//VPEC_QUEUE7_IB_CNTL
+#define VPEC_QUEUE7_IB_CNTL__IB_ENABLE__SHIFT                                                                 0x0
+#define VPEC_QUEUE7_IB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                          0x8
+#define VPEC_QUEUE7_IB_CNTL__CMD_VMID__SHIFT                                                                  0x10
+#define VPEC_QUEUE7_IB_CNTL__IB_PRIV__SHIFT                                                                   0x1f
+#define VPEC_QUEUE7_IB_CNTL__IB_ENABLE_MASK                                                                   0x00000001L
+#define VPEC_QUEUE7_IB_CNTL__SWITCH_INSIDE_IB_MASK                                                            0x00000100L
+#define VPEC_QUEUE7_IB_CNTL__CMD_VMID_MASK                                                                    0x000F0000L
+#define VPEC_QUEUE7_IB_CNTL__IB_PRIV_MASK                                                                     0x80000000L
+//VPEC_QUEUE7_IB_RPTR
+#define VPEC_QUEUE7_IB_RPTR__OFFSET__SHIFT                                                                    0x2
+#define VPEC_QUEUE7_IB_RPTR__OFFSET_MASK                                                                      0x003FFFFCL
+//VPEC_QUEUE7_IB_OFFSET
+#define VPEC_QUEUE7_IB_OFFSET__OFFSET__SHIFT                                                                  0x2
+#define VPEC_QUEUE7_IB_OFFSET__OFFSET_MASK                                                                    0x003FFFFCL
+//VPEC_QUEUE7_IB_BASE_LO
+#define VPEC_QUEUE7_IB_BASE_LO__ADDR__SHIFT                                                                   0x5
+#define VPEC_QUEUE7_IB_BASE_LO__ADDR_MASK                                                                     0xFFFFFFE0L
+//VPEC_QUEUE7_IB_BASE_HI
+#define VPEC_QUEUE7_IB_BASE_HI__ADDR__SHIFT                                                                   0x0
+#define VPEC_QUEUE7_IB_BASE_HI__ADDR_MASK                                                                     0xFFFFFFFFL
+//VPEC_QUEUE7_IB_SIZE
+#define VPEC_QUEUE7_IB_SIZE__SIZE__SHIFT                                                                      0x0
+#define VPEC_QUEUE7_IB_SIZE__SIZE_MASK                                                                        0x000FFFFFL
+//VPEC_QUEUE7_CMDIB_CNTL
+#define VPEC_QUEUE7_CMDIB_CNTL__IB_ENABLE__SHIFT                                                              0x0
+#define VPEC_QUEUE7_CMDIB_CNTL__IB_SWAP_ENABLE__SHIFT                                                         0x4
+#define VPEC_QUEUE7_CMDIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                       0x8
+#define VPEC_QUEUE7_CMDIB_CNTL__CMD_VMID__SHIFT                                                               0x10
+#define VPEC_QUEUE7_CMDIB_CNTL__IB_PRIV__SHIFT                                                                0x1f
+#define VPEC_QUEUE7_CMDIB_CNTL__IB_ENABLE_MASK                                                                0x00000001L
+#define VPEC_QUEUE7_CMDIB_CNTL__IB_SWAP_ENABLE_MASK                                                           0x00000010L
+#define VPEC_QUEUE7_CMDIB_CNTL__SWITCH_INSIDE_IB_MASK                                                         0x00000100L
+#define VPEC_QUEUE7_CMDIB_CNTL__CMD_VMID_MASK                                                                 0x000F0000L
+#define VPEC_QUEUE7_CMDIB_CNTL__IB_PRIV_MASK                                                                  0x80000000L
+//VPEC_QUEUE7_CMDIB_RPTR
+#define VPEC_QUEUE7_CMDIB_RPTR__OFFSET__SHIFT                                                                 0x2
+#define VPEC_QUEUE7_CMDIB_RPTR__OFFSET_MASK                                                                   0x003FFFFCL
+//VPEC_QUEUE7_CMDIB_OFFSET
+#define VPEC_QUEUE7_CMDIB_OFFSET__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE7_CMDIB_OFFSET__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE7_CMDIB_BASE_LO
+#define VPEC_QUEUE7_CMDIB_BASE_LO__ADDR__SHIFT                                                                0x5
+#define VPEC_QUEUE7_CMDIB_BASE_LO__ADDR_MASK                                                                  0xFFFFFFE0L
+//VPEC_QUEUE7_CMDIB_BASE_HI
+#define VPEC_QUEUE7_CMDIB_BASE_HI__ADDR__SHIFT                                                                0x0
+#define VPEC_QUEUE7_CMDIB_BASE_HI__ADDR_MASK                                                                  0xFFFFFFFFL
+//VPEC_QUEUE7_CMDIB_SIZE
+#define VPEC_QUEUE7_CMDIB_SIZE__SIZE__SHIFT                                                                   0x0
+#define VPEC_QUEUE7_CMDIB_SIZE__SIZE_MASK                                                                     0x000FFFFFL
+//VPEC_QUEUE7_3DLUTIB_CNTL
+#define VPEC_QUEUE7_3DLUTIB_CNTL__IB_ENABLE__SHIFT                                                            0x0
+#define VPEC_QUEUE7_3DLUTIB_CNTL__SWITCH_INSIDE_IB__SHIFT                                                     0x8
+#define VPEC_QUEUE7_3DLUTIB_CNTL__CMD_VMID__SHIFT                                                             0x10
+#define VPEC_QUEUE7_3DLUTIB_CNTL__IB_PRIV__SHIFT                                                              0x1f
+#define VPEC_QUEUE7_3DLUTIB_CNTL__IB_ENABLE_MASK                                                              0x00000001L
+#define VPEC_QUEUE7_3DLUTIB_CNTL__SWITCH_INSIDE_IB_MASK                                                       0x00000100L
+#define VPEC_QUEUE7_3DLUTIB_CNTL__CMD_VMID_MASK                                                               0x000F0000L
+#define VPEC_QUEUE7_3DLUTIB_CNTL__IB_PRIV_MASK                                                                0x80000000L
+//VPEC_QUEUE7_3DLUTIB_RPTR
+#define VPEC_QUEUE7_3DLUTIB_RPTR__OFFSET__SHIFT                                                               0x2
+#define VPEC_QUEUE7_3DLUTIB_RPTR__OFFSET_MASK                                                                 0x003FFFFCL
+//VPEC_QUEUE7_3DLUTIB_OFFSET
+#define VPEC_QUEUE7_3DLUTIB_OFFSET__OFFSET__SHIFT                                                             0x2
+#define VPEC_QUEUE7_3DLUTIB_OFFSET__OFFSET_MASK                                                               0x003FFFFCL
+//VPEC_QUEUE7_3DLUTIB_BASE_LO
+#define VPEC_QUEUE7_3DLUTIB_BASE_LO__ADDR__SHIFT                                                              0x5
+#define VPEC_QUEUE7_3DLUTIB_BASE_LO__ADDR_MASK                                                                0xFFFFFFE0L
+//VPEC_QUEUE7_3DLUTIB_BASE_HI
+#define VPEC_QUEUE7_3DLUTIB_BASE_HI__ADDR__SHIFT                                                              0x0
+#define VPEC_QUEUE7_3DLUTIB_BASE_HI__ADDR_MASK                                                                0xFFFFFFFFL
+//VPEC_QUEUE7_3DLUTIB_SIZE
+#define VPEC_QUEUE7_3DLUTIB_SIZE__SIZE__SHIFT                                                                 0x0
+#define VPEC_QUEUE7_3DLUTIB_SIZE__SIZE_MASK                                                                   0x000FFFFFL
+//VPEC_QUEUE7_CSA_ADDR_LO
+#define VPEC_QUEUE7_CSA_ADDR_LO__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE7_CSA_ADDR_LO__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE7_CSA_ADDR_HI
+#define VPEC_QUEUE7_CSA_ADDR_HI__ADDR__SHIFT                                                                  0x0
+#define VPEC_QUEUE7_CSA_ADDR_HI__ADDR_MASK                                                                    0xFFFFFFFFL
+//VPEC_QUEUE7_CONTEXT_STATUS
+#define VPEC_QUEUE7_CONTEXT_STATUS__SELECTED__SHIFT                                                           0x0
+#define VPEC_QUEUE7_CONTEXT_STATUS__USE_IB__SHIFT                                                             0x1
+#define VPEC_QUEUE7_CONTEXT_STATUS__IDLE__SHIFT                                                               0x2
+#define VPEC_QUEUE7_CONTEXT_STATUS__EXPIRED__SHIFT                                                            0x3
+#define VPEC_QUEUE7_CONTEXT_STATUS__EXCEPTION__SHIFT                                                          0x4
+#define VPEC_QUEUE7_CONTEXT_STATUS__CTXSW_ABLE__SHIFT                                                         0x7
+#define VPEC_QUEUE7_CONTEXT_STATUS__USE_3DLUTIB__SHIFT                                                        0x8
+#define VPEC_QUEUE7_CONTEXT_STATUS__PREEMPT_DISABLE__SHIFT                                                    0xa
+#define VPEC_QUEUE7_CONTEXT_STATUS__RPTR_WB_IDLE__SHIFT                                                       0xb
+#define VPEC_QUEUE7_CONTEXT_STATUS__WPTR_UPDATE_PENDING__SHIFT                                                0xc
+#define VPEC_QUEUE7_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT__SHIFT                                             0x10
+#define VPEC_QUEUE7_CONTEXT_STATUS__SELECTED_MASK                                                             0x00000001L
+#define VPEC_QUEUE7_CONTEXT_STATUS__USE_IB_MASK                                                               0x00000002L
+#define VPEC_QUEUE7_CONTEXT_STATUS__IDLE_MASK                                                                 0x00000004L
+#define VPEC_QUEUE7_CONTEXT_STATUS__EXPIRED_MASK                                                              0x00000008L
+#define VPEC_QUEUE7_CONTEXT_STATUS__EXCEPTION_MASK                                                            0x00000070L
+#define VPEC_QUEUE7_CONTEXT_STATUS__CTXSW_ABLE_MASK                                                           0x00000080L
+#define VPEC_QUEUE7_CONTEXT_STATUS__USE_3DLUTIB_MASK                                                          0x00000100L
+#define VPEC_QUEUE7_CONTEXT_STATUS__PREEMPT_DISABLE_MASK                                                      0x00000400L
+#define VPEC_QUEUE7_CONTEXT_STATUS__RPTR_WB_IDLE_MASK                                                         0x00000800L
+#define VPEC_QUEUE7_CONTEXT_STATUS__WPTR_UPDATE_PENDING_MASK                                                  0x00001000L
+#define VPEC_QUEUE7_CONTEXT_STATUS__WPTR_UPDATE_FAIL_COUNT_MASK                                               0x00FF0000L
+//VPEC_QUEUE7_DOORBELL_LOG
+#define VPEC_QUEUE7_DOORBELL_LOG__BE_ERROR__SHIFT                                                             0x0
+#define VPEC_QUEUE7_DOORBELL_LOG__DATA__SHIFT                                                                 0x2
+#define VPEC_QUEUE7_DOORBELL_LOG__BE_ERROR_MASK                                                               0x00000001L
+#define VPEC_QUEUE7_DOORBELL_LOG__DATA_MASK                                                                   0xFFFFFFFCL
+//VPEC_QUEUE7_IB_SUB_REMAIN
+#define VPEC_QUEUE7_IB_SUB_REMAIN__SIZE__SHIFT                                                                0x0
+#define VPEC_QUEUE7_IB_SUB_REMAIN__SIZE_MASK                                                                  0x00003FFFL
+//VPEC_QUEUE7_PREEMPT
+#define VPEC_QUEUE7_PREEMPT__IB_PREEMPT__SHIFT                                                                0x0
+#define VPEC_QUEUE7_PREEMPT__IB_PREEMPT_MASK                                                                  0x00000001L
+//VPEC_QUEUE7_LOG0BUFFER_CFG
+#define VPEC_QUEUE7_LOG0BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE7_LOG0BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE7_LOG0BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE7_LOG0BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE7_LOG0BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE7_LOG0BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE7_LOG0BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE7_LOG0BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+//VPEC_QUEUE7_LOG1BUFFER_CFG
+#define VPEC_QUEUE7_LOG1BUFFER_CFG__ENABLE__SHIFT                                                             0x0
+#define VPEC_QUEUE7_LOG1BUFFER_CFG__PARTIAL_ENTRY__SHIFT                                                      0x1
+#define VPEC_QUEUE7_LOG1BUFFER_CFG__FIRST_FREE_ENTRY__SHIFT                                                   0x4
+#define VPEC_QUEUE7_LOG1BUFFER_CFG__LAST_FREE_ENTRY__SHIFT                                                    0xc
+#define VPEC_QUEUE7_LOG1BUFFER_CFG__RESERVED__SHIFT                                                           0x14
+#define VPEC_QUEUE7_LOG1BUFFER_CFG__ENABLE_MASK                                                               0x00000001L
+#define VPEC_QUEUE7_LOG1BUFFER_CFG__PARTIAL_ENTRY_MASK                                                        0x00000002L
+#define VPEC_QUEUE7_LOG1BUFFER_CFG__FIRST_FREE_ENTRY_MASK                                                     0x00000FF0L
+#define VPEC_QUEUE7_LOG1BUFFER_CFG__LAST_FREE_ENTRY_MASK                                                      0x000FF000L
+#define VPEC_QUEUE7_LOG1BUFFER_CFG__RESERVED_MASK                                                             0xFFF00000L
+
+#endif
-- 
2.53.0

