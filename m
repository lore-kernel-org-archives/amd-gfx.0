Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F017BC4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 13:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E89310E1DC;
	Wed, 29 Nov 2023 13:46:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6134610E1DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 13:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDGHrjKTX5E4v6DFftdaBB0pq4w5Um9x4mA3XvnCYVfNwdUPwNhwsdl1RXuYrLn2uPgoOUf/aRU1gAJ2g71YKFFGwUzOloPFlgqz60jIT+HCjs2afaAWQTFmNwtFsh8VV7lIRUarXx+KeFJlFB8Hr4m2dRoIx6drsTEHDwBoZIhEIP+Fx8Fkk669QJzWHHrJ/hGzNCSMV8Z78sfOU5aFs6YxcT3K8zBPFkLuuoSL/N6iX+RFfmnkyxsBTPuKh//cukdt0hGZxOaixLnenYsSoAZdQUBdj8JdGMd0g2HjSv3SDn8j3jEs/YS95CJkF/oaZiEL/Qcc0qi+HL2kO5I0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AVlY5TkkI2UK38kNfbH+fUnLeCY0l0VROy14wmepPk=;
 b=I6y2wzsoucQFM9xIXcBPloLOWKlEcms7lZFYQDGHvKsfxM5xi66zpPrDHvi/NPmr0s0i/wVxMgEYbZ3fY4UWnUN7pnVtWlJ3l/gcNr7JGX/Bbt4sRBy54oyx7bxOy2MF9G0QT1v2541I3L5RhqjNFE7MiQL3sLBYxI5dEvh2yz6ob0ecHX+lAbtUX/iNp+SP6+IKKGpbttcMRT8epkoST6ozU+QhbeJh57rca6aD4wCKGktWrPVJAyDardmHudXxmgOfpRTJ5HvJ/HZlFw1lHxTRA4Gb5qYEsiS4F/lTS3g/tMvY+EYXLZUvP/1aao5Uh6FM2k+npyveu5TVly3uqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AVlY5TkkI2UK38kNfbH+fUnLeCY0l0VROy14wmepPk=;
 b=cf98VJjkRH1xX0NhFeHRbpg3XOwVmrFjVZ33eSZmLeY+Y3D0VZlLfdJuKTxaCHu2S1yaeBLIT/+twOpAi9smep2y2fly8o+kEDCAfBkIcw7nq57GsZB+7UI1v1UDvBUuYNf2vMq88fd2dzqANqrlxIS4FJCfoAiowxbVmLl+h9Q=
Received: from BL1PR13CA0392.namprd13.prod.outlook.com (2603:10b6:208:2c2::7)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Wed, 29 Nov
 2023 13:46:37 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::c9) by BL1PR13CA0392.outlook.office365.com
 (2603:10b6:208:2c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Wed, 29 Nov 2023 13:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 13:46:37 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 07:46:36 -0600
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: Add SMUIO headers for 10.0.2
Date: Wed, 29 Nov 2023 08:46:29 -0500
Message-ID: <20231129134629.1478602-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DM6PR12MB4331:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c4b30c-5e76-4735-d61f-08dbf0e19bc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3f4tsCRHDysT2nIcItaKYbmsSlfYdfp6csMCG3faCyLG+gd0rDuIKxG83UtfjEnL6gOQalK1Eu5OLxkWdemdNQQ808IPex6HabCdKPlU6V08zu9b569pw4caorSRfHkMR8DRjPs7W6RbUHhVDV/O7kRMKvJYOh8vsh6j5CrDKHWJE1R1TCv5UudPCb2d26OVl83Sv1RC47kkYjQKf/TO9Vx40XJkBgzWonk3Ckoj7gjlMDOrz0HdSI7cZBF0vtd4sV+qR+dBC7bkTxx8lPo6ykDepJpnpSfVCaMejRfTxzRvMwOIM+7naRWKEGwOxr5mdpSSzdQc649RqR8vAk0bgkGmK5RuFmmclqoyZASqwfENuBh7YiDFgSn9hQ/ii/RtMC7y42lfl78fGjH949CgOQaHJVkRuRboFId6dL5e7EalzeLqP5FuqQmTZtNOtX5SGryAOU3l+j/Vg8eESzD2G6QACCdZewZh2bkyTBKFTGxqn7nxMBOSQ83z5iQPyvOrwlESQXS0KkO/1zVz5Wp96qFjKqhWd1NKRwVK3C/7A171ojAysCp5yzWOlaGQgUfxbLEZUTcq5WPfttx5nxIimiRx7dVn+gJiUfp0t8evYKPRZhtshRXNh1dZl7Ds9PuL+DX+sKbYj6nseRFHwScPOOTguJUEevjnWgsDaBUy63iIT6Ufcxk96Qu31/6cQB38YQ3H1+hqpZZtDX2vZ6+2+xpOSfTLMAWf14dymTOJNLNHqZ72KjdjTTxEriZWP0A4x3oBETik+U9iJP8RD0L+xQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(66899024)(40480700001)(16526019)(26005)(1076003)(2616005)(426003)(336012)(356005)(81166007)(82740400003)(40460700003)(86362001)(36756003)(5660300002)(41300700001)(2906002)(30864003)(6666004)(478600001)(36860700001)(47076005)(4326008)(8676002)(316002)(8936002)(6916009)(70206006)(83380400001)(70586007)(19627235002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:46:37.4067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c4b30c-5e76-4735-d61f-08dbf0e19bc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These were requested by a UMR user for debugging purposes.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../asic_reg/smuio/smuio_10_0_2_offset.h      | 102 ++++++++++
 .../asic_reg/smuio/smuio_10_0_2_sh_mask.h     | 184 ++++++++++++++++++
 2 files changed, 286 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_sh_mask.h

diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_offset.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_offset.h
new file mode 100644
index 000000000000..a4dd372c0541
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_offset.h
@@ -0,0 +1,102 @@
+/*
+ * Copyright (C) 2023  Advanced Micro Devices, Inc.
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
+#ifndef _smuio_10_0_2_OFFSET_HEADER
+
+// addressBlock: smuio_smuio_misc_SmuSmuioDec
+// base address: 0x5a000
+#define mmSMUIO_MCM_CONFIG                                                                             0x0023
+#define mmSMUIO_MCM_CONFIG_BASE_IDX                                                                    0
+#define mmIP_DISCOVERY_VERSION                                                                         0x0000
+#define mmIP_DISCOVERY_VERSION_BASE_IDX                                                                1
+#define mmIO_SMUIO_PINSTRAP                                                                            0x01b1
+#define mmIO_SMUIO_PINSTRAP_BASE_IDX                                                                   1
+#define mmSCRATCH_REGISTER0                                                                            0x01b2
+#define mmSCRATCH_REGISTER0_BASE_IDX                                                                   1
+#define mmSCRATCH_REGISTER1                                                                            0x01b3
+#define mmSCRATCH_REGISTER1_BASE_IDX                                                                   1
+#define mmSCRATCH_REGISTER2                                                                            0x01b4
+#define mmSCRATCH_REGISTER2_BASE_IDX                                                                   1
+#define mmSCRATCH_REGISTER3                                                                            0x01b5
+#define mmSCRATCH_REGISTER3_BASE_IDX                                                                   1
+#define mmSCRATCH_REGISTER4                                                                            0x01b6
+#define mmSCRATCH_REGISTER4_BASE_IDX                                                                   1
+#define mmSCRATCH_REGISTER5                                                                            0x01b7
+#define mmSCRATCH_REGISTER5_BASE_IDX                                                                   1
+#define mmSCRATCH_REGISTER6                                                                            0x01b8
+#define mmSCRATCH_REGISTER6_BASE_IDX                                                                   1
+#define mmSCRATCH_REGISTER7                                                                            0x01b9
+#define mmSCRATCH_REGISTER7_BASE_IDX                                                                   1
+
+
+// addressBlock: smuio_smuio_reset_SmuSmuioDec
+// base address: 0x5a300
+#define mmSMUIO_MP_RESET_INTR                                                                          0x00c1
+#define mmSMUIO_MP_RESET_INTR_BASE_IDX                                                                 0
+#define mmSMUIO_SOC_HALT                                                                               0x00c2
+#define mmSMUIO_SOC_HALT_BASE_IDX                                                                      0
+#define mmSMUIO_GFX_MISC_CNTL                                                                          0x00c8
+#define mmSMUIO_GFX_MISC_CNTL_BASE_IDX                                                                 0
+
+
+// addressBlock: smuio_smuio_ccxctrl_SmuSmuioDec
+// base address: 0x5a000
+#define mmPWROK_REFCLK_GAP_CYCLES                                                                      0x0001
+#define mmPWROK_REFCLK_GAP_CYCLES_BASE_IDX                                                             1
+#define mmGOLDEN_TSC_INCREMENT_UPPER                                                                   0x0004
+#define mmGOLDEN_TSC_INCREMENT_UPPER_BASE_IDX                                                          1
+#define mmGOLDEN_TSC_INCREMENT_LOWER                                                                   0x0005
+#define mmGOLDEN_TSC_INCREMENT_LOWER_BASE_IDX                                                          1
+#define mmGOLDEN_TSC_COUNT_UPPER                                                                       0x0025
+#define mmGOLDEN_TSC_COUNT_UPPER_BASE_IDX                                                              1
+#define mmGOLDEN_TSC_COUNT_LOWER                                                                       0x0026
+#define mmGOLDEN_TSC_COUNT_LOWER_BASE_IDX                                                              1
+#define mmGFX_GOLDEN_TSC_SHADOW_UPPER                                                                  0x0029
+#define mmGFX_GOLDEN_TSC_SHADOW_UPPER_BASE_IDX                                                         1
+#define mmGFX_GOLDEN_TSC_SHADOW_LOWER                                                                  0x002a
+#define mmGFX_GOLDEN_TSC_SHADOW_LOWER_BASE_IDX                                                         1
+#define mmSOC_GOLDEN_TSC_SHADOW_UPPER                                                                  0x002b
+#define mmSOC_GOLDEN_TSC_SHADOW_UPPER_BASE_IDX                                                         1
+#define mmSOC_GOLDEN_TSC_SHADOW_LOWER                                                                  0x002c
+#define mmSOC_GOLDEN_TSC_SHADOW_LOWER_BASE_IDX                                                         1
+#define mmSOC_GAP_PWROK                                                                                0x002d
+#define mmSOC_GAP_PWROK_BASE_IDX                                                                       1
+
+// addressBlock: smuio_smuio_swtimer_SmuSmuioDec
+// base address: 0x5ac40
+#define mmPWR_VIRT_RESET_REQ                                                                           0x0110
+#define mmPWR_VIRT_RESET_REQ_BASE_IDX                                                                  1
+#define mmPWR_DISP_TIMER_CONTROL                                                                       0x0111
+#define mmPWR_DISP_TIMER_CONTROL_BASE_IDX                                                              1
+#define mmPWR_DISP_TIMER2_CONTROL                                                                      0x0113
+#define mmPWR_DISP_TIMER2_CONTROL_BASE_IDX                                                             1
+#define mmPWR_DISP_TIMER_GLOBAL_CONTROL                                                                0x0115
+#define mmPWR_DISP_TIMER_GLOBAL_CONTROL_BASE_IDX                                                       1
+#define mmPWR_IH_CONTROL                                                                               0x0116
+#define mmPWR_IH_CONTROL_BASE_IDX                                                                      1
+
+// addressBlock: smuio_smuio_svi0_SmuSmuioDec
+// base address: 0x6f000
+#define mmSMUSVI0_TEL_PLANE0                                                                           0x520e
+#define mmSMUSVI0_TEL_PLANE0_BASE_IDX                                                                  1
+#define mmSMUSVI0_PLANE0_CURRENTVID                                                                    0x5217
+#define mmSMUSVI0_PLANE0_CURRENTVID_BASE_IDX                                                           1
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_sh_mask.h
new file mode 100644
index 000000000000..d10ae61c346b
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_10_0_2_sh_mask.h
@@ -0,0 +1,184 @@
+/*
+ * Copyright (C) 2023  Advanced Micro Devices, Inc.
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
+#ifndef _smuio_10_0_2_SH_MASK_HEADER
+
+// addressBlock: smuio_smuio_misc_SmuSmuioDec
+//SMUIO_MCM_CONFIG
+#define SMUIO_MCM_CONFIG__DIE_ID__SHIFT                                                                       0x0
+#define SMUIO_MCM_CONFIG__PKG_TYPE__SHIFT                                                                     0x2
+#define SMUIO_MCM_CONFIG__SOCKET_ID__SHIFT                                                                    0x5
+#define SMUIO_MCM_CONFIG__PKG_SUBTYPE__SHIFT                                                                  0x6
+#define SMUIO_MCM_CONFIG__CONSOLE_K__SHIFT                                                                    0x10
+#define SMUIO_MCM_CONFIG__CONSOLE_A__SHIFT                                                                    0x11
+#define SMUIO_MCM_CONFIG__DIE_ID_MASK                                                                         0x00000003L
+#define SMUIO_MCM_CONFIG__PKG_TYPE_MASK                                                                       0x0000001CL
+#define SMUIO_MCM_CONFIG__SOCKET_ID_MASK                                                                      0x00000020L
+#define SMUIO_MCM_CONFIG__PKG_SUBTYPE_MASK                                                                    0x000000C0L
+#define SMUIO_MCM_CONFIG__CONSOLE_K_MASK                                                                      0x00010000L
+#define SMUIO_MCM_CONFIG__CONSOLE_A_MASK                                                                      0x00020000L
+//IP_DISCOVERY_VERSION
+#define IP_DISCOVERY_VERSION__IP_DISCOVERY_VERSION__SHIFT                                                     0x0
+#define IP_DISCOVERY_VERSION__IP_DISCOVERY_VERSION_MASK                                                       0xFFFFFFFFL
+//IO_SMUIO_PINSTRAP
+#define IO_SMUIO_PINSTRAP__AUD_PORT_CONN__SHIFT                                                               0x0
+#define IO_SMUIO_PINSTRAP__AUD__SHIFT                                                                         0x3
+#define IO_SMUIO_PINSTRAP__AUD_PORT_CONN_MASK                                                                 0x00000007L
+#define IO_SMUIO_PINSTRAP__AUD_MASK                                                                           0x00000018L
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
+// addressBlock: smuio_smuio_reset_SmuSmuioDec
+//SMUIO_MP_RESET_INTR
+#define SMUIO_MP_RESET_INTR__SMUIO_MP_RESET_INTR__SHIFT                                                       0x0
+#define SMUIO_MP_RESET_INTR__SMUIO_MP_RESET_INTR_MASK                                                         0x00000001L
+//SMUIO_SOC_HALT
+#define SMUIO_SOC_HALT__WDT_FORCE_PWROK_EN__SHIFT                                                             0x2
+#define SMUIO_SOC_HALT__WDT_FORCE_RESETn_EN__SHIFT                                                            0x3
+#define SMUIO_SOC_HALT__WDT_FORCE_PWROK_EN_MASK                                                               0x00000004L
+#define SMUIO_SOC_HALT__WDT_FORCE_RESETn_EN_MASK                                                              0x00000008L
+//SMUIO_GFX_MISC_CNTL
+#define SMUIO_GFX_MISC_CNTL__SMU_GFX_cold_vs_gfxoff__SHIFT                                                    0x0
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS__SHIFT                                                         0x1
+#define SMUIO_GFX_MISC_CNTL__PWR_GFX_DLDO_CLK_SWITCH__SHIFT                                                   0x3
+#define SMUIO_GFX_MISC_CNTL__PWR_GFX_RLC_CGPG_EN__SHIFT                                                       0x4
+#define SMUIO_GFX_MISC_CNTL__SMU_GFX_cold_vs_gfxoff_MASK                                                      0x00000001L
+#define SMUIO_GFX_MISC_CNTL__PWR_GFXOFF_STATUS_MASK                                                           0x00000006L
+#define SMUIO_GFX_MISC_CNTL__PWR_GFX_DLDO_CLK_SWITCH_MASK                                                     0x00000008L
+#define SMUIO_GFX_MISC_CNTL__PWR_GFX_RLC_CGPG_EN_MASK                                                         0x00000010L
+
+// addressBlock: smuio_smuio_ccxctrl_SmuSmuioDec
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
+//GFX_GOLDEN_TSC_SHADOW_UPPER
+#define GFX_GOLDEN_TSC_SHADOW_UPPER__GfxGoldenTscShadowUpper__SHIFT                                           0x0
+#define GFX_GOLDEN_TSC_SHADOW_UPPER__GfxGoldenTscShadowUpper_MASK                                             0x00FFFFFFL
+//GFX_GOLDEN_TSC_SHADOW_LOWER
+#define GFX_GOLDEN_TSC_SHADOW_LOWER__GfxGoldenTscShadowLower__SHIFT                                           0x0
+#define GFX_GOLDEN_TSC_SHADOW_LOWER__GfxGoldenTscShadowLower_MASK                                             0xFFFFFFFFL
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
+// addressBlock: smuio_smuio_svi0_SmuSmuioDec
+//SMUSVI0_TEL_PLANE0
+#define SMUSVI0_TEL_PLANE0__SVI0_PLANE0_IDDCOR__SHIFT                                                         0x0
+#define SMUSVI0_TEL_PLANE0__SVI0_PLANE0_VDDCOR__SHIFT                                                         0x10
+#define SMUSVI0_TEL_PLANE0__SVI0_PLANE0_IDDCOR_MASK                                                           0x000000FFL
+#define SMUSVI0_TEL_PLANE0__SVI0_PLANE0_VDDCOR_MASK                                                           0x01FF0000L
+//SMUSVI0_PLANE0_CURRENTVID
+#define SMUSVI0_PLANE0_CURRENTVID__CURRENT_SVI0_PLANE0_VID__SHIFT                                             0x18
+#define SMUSVI0_PLANE0_CURRENTVID__CURRENT_SVI0_PLANE0_VID_MASK                                               0xFF000000L
+
+#endif
-- 
2.40.1

