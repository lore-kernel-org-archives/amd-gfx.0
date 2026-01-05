Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B25BCCF2D5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 20:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F0AE10E26A;
	Mon,  5 Jan 2026 20:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R2Q8gD5M";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010040.outbound.protection.outlook.com
 [52.101.193.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDFEB10E285
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 20:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9UjRamWCGkLVLejUdVlrI+iCDQZ8tUk/mZ/XMcYSjLUKLK2zg7Na85fAA/CKBG7eNzCxbsS9x8Y+0bwLlyqwsXpUISLsPsGINK14WrDuPiaSnTdsM9WHMxfOwfZ2nTQkBajCr03w3Xncvm3lPQlJkXWVvcI/yHB5IqhW2TUiy4Fdb/iFqM3TvBCHNpinxj1YPpjyjOjMU11lOygVDjlskpv9sEbJoZIyZrDqjiHdDOfZYDVapJmj5+df2Tj8J0svVg4yplMTTOtVNQj1xMgnWAvwgttG2Y2oHyBZ4MMzyh1E7mffs7Hnr/VdNwdCA/9nWRPd9XSNDB6BcWB+uph6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBsn7+XfFDetnvfeq1Td7Ns8H/zEDwwdwpRflIVSEEM=;
 b=OpOnOiK0gUOu+J6qZMgC1PQsGPm0VRZZ+8GjKFjOfVDEkDzqNlqhmRrpj4EIKP2AjvvlbA10IsUhaVO333pqMVi0xgGGIsq73lHLM9+PH+uAsPoZEVpvm1YW/VL85Cg8IlUpHrNbslOl4s8HLyK3ZXMlo+h9YnImgW2LYpaqgi3/aCk7mgw0nlqF5CD7StgozpnDA7fuUjExlzFsBncROEt0/MdidOe+cehoOqHfx7n+Ul5qm3yZLf5qCVVzeNQLxbVE1RqUDQR/RLwvvJoiD4DNJzeHcT1ZtqpzkEhUQNQI2QKgfSW1au3KIwYvYn0NxZTsr8zeB5Xwz4tz6Xn8Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBsn7+XfFDetnvfeq1Td7Ns8H/zEDwwdwpRflIVSEEM=;
 b=R2Q8gD5MpUQOIdzX0+NlpxUnKv2t+mgJ7YsOQlVpMCUsHdi4+GyPSnFtM5PGNl6WHXFUUtuPCa+vs9Hc7F8+r8gfZTdEdYhsogU7gbAXnTsRAzynnBnezl8BZ5zRd2KDuLxHV0vFcaVHqxAFqZm0WBF9VhSi2tqrHbTNHAxYfPY=
Received: from SJ0PR13CA0171.namprd13.prod.outlook.com (2603:10b6:a03:2c7::26)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 20:13:33 +0000
Received: from SJ1PEPF000023D0.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::5) by SJ0PR13CA0171.outlook.office365.com
 (2603:10b6:a03:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Mon, 5
 Jan 2026 20:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D0.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 20:13:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 5 Jan
 2026 14:13:31 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 Jan
 2026 14:13:30 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 5 Jan 2026 14:13:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: add SMUIO 15.0.0 headers
Date: Mon, 5 Jan 2026 15:13:14 -0500
Message-ID: <20260105201318.64865-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D0:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a564ad4-3c08-4393-9988-08de4c96e5de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PXsbsQ+KlMN2vOl4r5+B0LruEuuo62OAMgU74lM//G21ADGDSpZ7DbSNhFOX?=
 =?us-ascii?Q?OKz/m58CQXVT5PiNANvu9NcMt5jwSGrz3h96gZGHlmF6PZVsWgxEw7flCMGc?=
 =?us-ascii?Q?EnYQy2g41ZIAZsJnnhr5V3RDfEVWq+tKNE58C4NcJaOGrvCz/izmgtmd6BVV?=
 =?us-ascii?Q?2wWFlhc89P7WqBYiIVFbGtjnMsX41WweQHPGE6oxrKFHJygiiwKmCRBg5MpR?=
 =?us-ascii?Q?LfV5XRJUG804hMVxr6tXb7T5YT9Qw2Yf+SkQeHWJOt1OInNnkw0mXQrREPVj?=
 =?us-ascii?Q?UsREcHCVkd4SjgOKXsTeojitYIKe19atDyPofZwskoIVv9TTkuTYZc6ZXjzS?=
 =?us-ascii?Q?ReE+B6IemzMqE2djToZw5SsPzftqPS/B1Ki7jsHmzGJ03L6m51/T93POmcug?=
 =?us-ascii?Q?Nma5xBaWGjl2NtPTEf82ddXvN1nG4nnHzDCwF3vIo1GKrHaQ5C1Dcl+1fnO9?=
 =?us-ascii?Q?AqwONRMiCa4cSCSdnWTu++xajuJovaFBKMW1p/wS+Wy7zZ+ghM2T8vfq6j0d?=
 =?us-ascii?Q?V1f1MPcwhsaCcmNZgFHLal3n6cBf1TbIPfl19Tg8StWkjiUOR5j8kb8HosS2?=
 =?us-ascii?Q?ZhagjTFw7fhUv4yZwIbzlPo0Mrslaf7+fs7xDE8+sFlUQaggO5uEA8c7v4vR?=
 =?us-ascii?Q?H5Lucn5SbYQKK9r/LDLYShfMfHZyRvrz4VcgabBlfZ8Qx5UpQzCquzvug6hN?=
 =?us-ascii?Q?khc8jTofaFwjXel4XTBfm4NILRQn0J8BakH52JJJ+es0qFffz3XotyPImI9O?=
 =?us-ascii?Q?0Auc7PjjW61Hne1oT+lhHiIPVg4sns7Z8lTzM9V3ohWHE35H/hBmlIZ1oou7?=
 =?us-ascii?Q?jvc1B8pXdHLEI41GBs//b8rZshIekGr9n+Vja+AVCU8zLROON71qyRmizi2b?=
 =?us-ascii?Q?7P7qpG4jTe8tOFhXojuLKu0Y8wvR2zmRAn0yvMuU5YPnSf1Lg7wlp/EFXPEa?=
 =?us-ascii?Q?GRVcyenjoi/a/Vf0K8zbKx3rfG8x+TfzNqmyDtbKMkiHIHB1yPMx3InJ/sIA?=
 =?us-ascii?Q?T0tuUFAkR7kE5YbrHkVG7QHwdx//fKBsl9TlMohj7eS7U3p010wCmRTzrV2s?=
 =?us-ascii?Q?eTbiX3mD/5n+lydcV4uCw/cSjvkSMQ6+wgNv1mYA6MK2q3QkSea8QR4nBYUX?=
 =?us-ascii?Q?Mo25i7/t7h5nF/Ib2+5a1b7QbREGSnP/Rf+iZfDgYcY6bvHsNuB3mWWpHdqE?=
 =?us-ascii?Q?Wai+6TVErSfFwLFx2QtdTjNGy0GzxIBduyyMUy/niIAPcAAuKz02YHcv4tlB?=
 =?us-ascii?Q?Cp2z6JWzNZWMI2QuwSrNxXo8MG75CtdEyCQgWF+B8ed7rCf8RyQ5ZBAmH1wn?=
 =?us-ascii?Q?UfUKiHGAWj+j7W8CIPPEHh9aFag8aIASvMaDqPXbTpBDjqTJu9CNN9G6a3X9?=
 =?us-ascii?Q?M2OW3aLHuKHUHJJtMtT3TkuL/usxvknWMqJvxRlKioIL4C6wOxNMsj7L9Qtp?=
 =?us-ascii?Q?F6desVfYAvf3cPuB7n4a3gdeDEAD6R81mQ/cXW+CQ28rwf4+votFTsMgkjh+?=
 =?us-ascii?Q?Rd5rfGqg50TRm6B4LrtOdpDi3rRVQGSC3HWHx+iKwpzOSLTYx0MbFTDpW0O+?=
 =?us-ascii?Q?Sew2SQM4Fy+i13rypCk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 20:13:31.7212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a564ad4-3c08-4393-9988-08de4c96e5de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
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

Add headers for SMUIO 15.0.0.

v2: squash in updates (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../asic_reg/smuio/smuio_15_0_0_offset.h      | 100 +++++++++
 .../asic_reg/smuio/smuio_15_0_0_sh_mask.h     | 190 ++++++++++++++++++
 2 files changed, 290 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_0_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_0_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_0_offset.h
new file mode 100644
index 0000000000000..54e8fd6c72488
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_0_offset.h
@@ -0,0 +1,100 @@
+/*
+ * Copyright (C) 2025  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _smuio_15_0_0_OFFSET_HEADER
+#define _smuio_15_0_0_OFFSET_HEADER
+
+
+
+// addressBlock: smuio_smuio_misc_SmuSmuioDec
+// base address: 0x5a000
+#define regSMUIO_MCM_CONFIG                                                                             0x0023
+#define regSMUIO_MCM_CONFIG_BASE_IDX                                                                    0
+#define regIP_DISCOVERY_VERSION                                                                         0x0000
+#define regIP_DISCOVERY_VERSION_BASE_IDX                                                                1
+#define regSCRATCH_REGISTER0                                                                            0x01c6
+#define regSCRATCH_REGISTER0_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER1                                                                            0x01c7
+#define regSCRATCH_REGISTER1_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER2                                                                            0x01c8
+#define regSCRATCH_REGISTER2_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER3                                                                            0x01c9
+#define regSCRATCH_REGISTER3_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER4                                                                            0x01ca
+#define regSCRATCH_REGISTER4_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER5                                                                            0x01cb
+#define regSCRATCH_REGISTER5_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER6                                                                            0x01cc
+#define regSCRATCH_REGISTER6_BASE_IDX                                                                   1
+#define regSCRATCH_REGISTER7                                                                            0x01cd
+#define regSCRATCH_REGISTER7_BASE_IDX                                                                   1
+#define regIO_SMUIO_PINSTRAP                                                                            0x01ce
+#define regIO_SMUIO_PINSTRAP_BASE_IDX                                                                   1
+
+
+// addressBlock: smuio_smuio_reset_SmuSmuioDec
+// base address: 0x5a300
+#define regSMUIO_GFX_MISC_CNTL                                                                          0x00c5
+#define regSMUIO_GFX_MISC_CNTL_BASE_IDX                                                                 0
+
+
+// addressBlock: smuio_smuio_tsc_SmuSmuioDec
+// base address: 0x5a8a0
+#define regPWROK_REFCLK_GAP_CYCLES                                                                      0x0028
+#define regPWROK_REFCLK_GAP_CYCLES_BASE_IDX                                                             1
+#define regGOLDEN_TSC_INCREMENT_UPPER                                                                   0x002b
+#define regGOLDEN_TSC_INCREMENT_UPPER_BASE_IDX                                                          1
+#define regGOLDEN_TSC_INCREMENT_LOWER                                                                   0x002c
+#define regGOLDEN_TSC_INCREMENT_LOWER_BASE_IDX                                                          1
+#define regGOLDEN_TSC_COUNT_UPPER                                                                       0x0030
+#define regGOLDEN_TSC_COUNT_UPPER_BASE_IDX                                                              1
+#define regGOLDEN_TSC_COUNT_LOWER                                                                       0x0031
+#define regGOLDEN_TSC_COUNT_LOWER_BASE_IDX                                                              1
+#define regSOC_GOLDEN_TSC_SHADOW_UPPER                                                                  0x0032
+#define regSOC_GOLDEN_TSC_SHADOW_UPPER_BASE_IDX                                                         1
+#define regSOC_GOLDEN_TSC_SHADOW_LOWER                                                                  0x0033
+#define regSOC_GOLDEN_TSC_SHADOW_LOWER_BASE_IDX                                                         1
+#define regSOC_GAP_PWROK                                                                                0x0034
+#define regSOC_GAP_PWROK_BASE_IDX                                                                       1
+
+
+// addressBlock: smuio_smuio_swtimer_SmuSmuioDec
+// base address: 0x5aca8
+#define regPWR_VIRT_RESET_REQ                                                                           0x012a
+#define regPWR_VIRT_RESET_REQ_BASE_IDX                                                                  1
+#define regPWR_DISP_TIMER_CONTROL                                                                       0x012b
+#define regPWR_DISP_TIMER_CONTROL_BASE_IDX                                                              1
+#define regPWR_DISP_TIMER_DEBUG                                                                         0x012c
+#define regPWR_DISP_TIMER_DEBUG_BASE_IDX                                                                1
+#define regPWR_DISP_TIMER_ELAPSED_CONTROL                                                               0x012d
+#define regPWR_DISP_TIMER_ELAPSED_CONTROL_BASE_IDX                                                      1
+#define regPWR_DISP_TIMER2_CONTROL                                                                      0x012e
+#define regPWR_DISP_TIMER2_CONTROL_BASE_IDX                                                             1
+#define regPWR_DISP_TIMER2_DEBUG                                                                        0x012f
+#define regPWR_DISP_TIMER2_DEBUG_BASE_IDX                                                               1
+#define regPWR_DISP_TIMER2_ELAPSED_CONTROL                                                              0x0130
+#define regPWR_DISP_TIMER2_ELAPSED_CONTROL_BASE_IDX                                                     1
+#define regPWR_DISP_TIMER_GLOBAL_CONTROL                                                                0x0131
+#define regPWR_DISP_TIMER_GLOBAL_CONTROL_BASE_IDX                                                       1
+#define regPWR_IH_CONTROL                                                                               0x0132
+#define regPWR_IH_CONTROL_BASE_IDX                                                                      1
+
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_0_sh_mask.h
new file mode 100644
index 0000000000000..f10e702bf5e90
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_15_0_0_sh_mask.h
@@ -0,0 +1,190 @@
+/*
+ * Copyright (C) 2025  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
+ */
+#ifndef _smuio_15_0_0_SH_MASK_HEADER
+#define _smuio_15_0_0_SH_MASK_HEADER
+
+
+// addressBlock: smuio_smuio_misc_SmuSmuioDec
+//SMUIO_MCM_CONFIG
+#define SMUIO_MCM_CONFIG__DIE_ID__SHIFT                                                                       0x0
+#define SMUIO_MCM_CONFIG__PKG_TYPE__SHIFT                                                                     0x2
+#define SMUIO_MCM_CONFIG__SOCKET_ID__SHIFT                                                                    0x8
+#define SMUIO_MCM_CONFIG__CONSOLE_K__SHIFT                                                                    0x10
+#define SMUIO_MCM_CONFIG__CONSOLE_A__SHIFT                                                                    0x11
+#define SMUIO_MCM_CONFIG__PKG_SUBTYPE__SHIFT                                                                  0x12
+#define SMUIO_MCM_CONFIG__DIE_ID_MASK                                                                         0x00000003L
+#define SMUIO_MCM_CONFIG__PKG_TYPE_MASK                                                                       0x0000003CL
+#define SMUIO_MCM_CONFIG__SOCKET_ID_MASK                                                                      0x00000100L
+#define SMUIO_MCM_CONFIG__CONSOLE_K_MASK                                                                      0x00010000L
+#define SMUIO_MCM_CONFIG__CONSOLE_A_MASK                                                                      0x00020000L
+#define SMUIO_MCM_CONFIG__PKG_SUBTYPE_MASK                                                                    0x00040000L
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
+//IO_SMUIO_PINSTRAP
+#define IO_SMUIO_PINSTRAP__AUD_PORT_CONN__SHIFT                                                               0x0
+#define IO_SMUIO_PINSTRAP__AUD__SHIFT                                                                         0x3
+#define IO_SMUIO_PINSTRAP__AUD_PORT_CONN_MASK                                                                 0x00000007L
+#define IO_SMUIO_PINSTRAP__AUD_MASK                                                                           0x00000018L
+
+
+// addressBlock: smuio_smuio_reset_SmuSmuioDec
+//SMUIO_GFX_MISC_CNTL
+#define SMUIO_GFX_MISC_CNTL__SMU_GFX_cold_vs_gfxoff__SHIFT                                                    0x0
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT                                                         0x1
+#define SMUIO_GFX_MISC_CNTL__SMU_GFX_cold_vs_gfxoff_MASK                                                      0x00000001L
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK                                                           0x00000006L
+
+
+// addressBlock: smuio_smuio_tsc_SmuSmuioDec
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
+// addressBlock: smuio_smuio_swtimer_SmuSmuioDec
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
+//PWR_DISP_TIMER_ELAPSED_CONTROL
+#define PWR_DISP_TIMER_ELAPSED_CONTROL__DISP_TIMER_ELAPSED_TIME_COUNT__SHIFT                                  0x0
+#define PWR_DISP_TIMER_ELAPSED_CONTROL__DISP_TIMER_COMP_ENABLE__SHIFT                                         0x19
+#define PWR_DISP_TIMER_ELAPSED_CONTROL__DISP_TIMER_ELAPSED_TIME_COUNT_MASK                                    0x01FFFFFFL
+#define PWR_DISP_TIMER_ELAPSED_CONTROL__DISP_TIMER_COMP_ENABLE_MASK                                           0x02000000L
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
+//PWR_DISP_TIMER2_ELAPSED_CONTROL
+#define PWR_DISP_TIMER2_ELAPSED_CONTROL__DISP_TIMER_ELAPSED_TIME_COUNT__SHIFT                                 0x0
+#define PWR_DISP_TIMER2_ELAPSED_CONTROL__DISP_TIMER_COMP_ENABLE__SHIFT                                        0x19
+#define PWR_DISP_TIMER2_ELAPSED_CONTROL__DISP_TIMER_ELAPSED_TIME_COUNT_MASK                                   0x01FFFFFFL
+#define PWR_DISP_TIMER2_ELAPSED_CONTROL__DISP_TIMER_COMP_ENABLE_MASK                                          0x02000000L
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
+#endif
-- 
2.52.0

