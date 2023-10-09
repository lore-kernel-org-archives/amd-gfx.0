Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC00CD611D
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 18:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7564510E29C;
	Mon,  9 Oct 2023 18:33:13 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00CA810E124
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 18:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc5gEKN3v4F5qKiqjF+8xAdaxY4q3Z27SxPlz6HGgQfKu6kS3BKNLc/DQVSk3cBeqpQS9MLSja2OQZjXF3w97/yF3mvzL06M+5Nke/2mERzFUSSB53oW1u8p2arp9OsDxrVEE2AquXiZe5CfMwN2bTASAfnjNt4GUsG5ti1vOCFZu849clADZ/g27XSh4q/L9UEZgWi6XzEidfkcn8LOixx2Xsg59GnMQ7BAQoHPj8YFjHVu14dQSUEgMNb0XRxtepkQnwYoWg/z9H3CairMJ8MUgaw/nfDANIic/IkPr6cy461KIsyEsCijx33hYkx8N3bgg94OX8CAEnR05rslcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlHa6RZjWlWzb64h3Ps3hm2WpHSDkpxWT+fbRyJEaXE=;
 b=XF8uM0lTJPJnKxVhHMACURG1U6tEKIiUkciGxgo8x9lM+g4tw8XfrVZjAe5KCEiCTUUb8QpmPSJNbrtvwCUk2hFgsNRpuHzDbEqMVQVofsvEUPQKi50EcXctcUQjrdy6EsCeFL6UrVH9SGN75Erj690gXSIidzthoMm87r2itCBXkjbddxb7A7YyentCBuFJW4fhMY/MTZXmwdojXF7DKdC7aKDCxF1GU8YWr+JfUkWx8lnzZHPx+2XPrEIY8Tw5vJBdzra2b9uUJJgPlZrAUWzSAgZGVbNMjzfmmJBdvwOqw5eAcwj7x5xOdkJ4oUEwuQa8IKrSmEYSp8MTZmBXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlHa6RZjWlWzb64h3Ps3hm2WpHSDkpxWT+fbRyJEaXE=;
 b=PD6OJCkK30rolAfGT/yu+wmWkj5Emz+C05WfJslXZWlBXDiXoGPJ3wGBwH3a7HYCgj7vHlOTnY+JJqY/mAOhi0u4MmXuNj07X1kJpnyFt2bBFGlVmiU6X6ix2KqApOFsvnQk9kndH+5usnW44EieZpz+Ajmx9aM9lSsLbJPmfDI=
Received: from BL1PR13CA0348.namprd13.prod.outlook.com (2603:10b6:208:2c6::23)
 by MW3PR12MB4523.namprd12.prod.outlook.com (2603:10b6:303:5b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 18:33:08 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::33) by BL1PR13CA0348.outlook.office365.com
 (2603:10b6:208:2c6::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.20 via Frontend
 Transport; Mon, 9 Oct 2023 18:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 18:33:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:33:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amd/swsmu: add smu v14_0_0 ppsmc file
Date: Mon, 9 Oct 2023 14:32:31 -0400
Message-ID: <20231009183234.518379-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009183234.518379-1-alexander.deucher@amd.com>
References: <20231009183234.518379-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|MW3PR12MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a515a10-507c-42a0-4e85-08dbc8f62ef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SP2CGI/Vgtv8TSMAAdezMGa4NoUAO7qS819LQE4tK+jDWncL0MDuNx6s1jIwTOMUZTmVNeq5IOrNkVq+FhulVGwzvEENc7oTjmvyYn5w1jTna1h6CRzo57unnzQOfxh0u96QY3u6DFrTs9iaRwKMewhNo+0MUru50wNjmYgkdj99MfUDb1bZXxpgAgACZ7XrdwCwxhLVqq8htvspiQpuYILF+iOpF9w5torYb9pDUUhxwNuve2QM7R1IY+RvU9AgQYpCYiwbgVWR0CqlCcKdEfeYy9q/ndhZGLHI/Gk/02Fs9KtKtgHmLG16uaUp08AxgCr/9xivKhCwQJjDuLJ+Hu2/pohp0HNXhilyKZ0RzSFcrDd/5QhCJdilh/zU2jKAGCH4vWPNUbFyXVG7mv8h9SfruSY4WIJyzC/vSN27pOHibWfBLDxHWc50x7XhhvQn1JPXBTfWpMoAECEiGYe6PiWPDW24bVzWlP9vrN2u27zILJOu1zFig7kXa128lXS04HaRPT4Qyt5EjlYkZy/BP20LUvgFrF/BRRZYMSeFrP0r4E8F0Chu65lY+qraTRPf0KVb5YjTMYWqwRefePrNdJJPnsT6lFD8c8qmiy5axZVkjayeR66MVNapZ8+h5iH2MoMmtJmbcfQ9svW5Xxmw7Hy3I/uf0WMp/SgPQrmWN3aRObFjoeOOUUctv8q+tkH1g4qpf5BFcJ+rM4gyL4UZ5ZGxM5x51EdcwMFn7eUbBFEEYh1wGDrX66muWKge2wZYvar0ksGsaugGluNxkt5MGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(66899024)(1076003)(426003)(16526019)(26005)(336012)(2616005)(40460700003)(81166007)(86362001)(82740400003)(36756003)(40480700001)(356005)(8936002)(83380400001)(2906002)(4326008)(478600001)(7696005)(36860700001)(6666004)(41300700001)(47076005)(5660300002)(8676002)(19627235002)(6916009)(316002)(54906003)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:33:07.8123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a515a10-507c-42a0-4e85-08dbc8f62ef8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4523
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Li Ma <li.ma@amd.com>

Add initial smu v14_0_0 ppsmc file

v2: squash in updates (Alex)
v3: squash in updates (Alex)

Signed-off-by: Li Ma <li.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h  | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
new file mode 100644
index 000000000000..82fec93e0114
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
@@ -0,0 +1,142 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+
+#ifndef __SMU_V14_0_0_PPSMC_H__
+#define __SMU_V14_0_0_PPSMC_H__
+
+/*! @mainpage PMFW-PPS (PPLib) Message Interface
+  This documentation contains the subsections:\n\n
+  @ref ResponseCodes\n
+  @ref definitions\n
+  @ref enums\n
+*/
+
+/** @def PPS_PMFW_IF_VER
+* PPS (PPLib) to PMFW IF version 1.0
+*/
+#define PPS_PMFW_IF_VER "1.0" ///< Major.Minor
+
+/** @defgroup ResponseCodes PMFW Response Codes
+*  @{
+*/
+// SMU Response Codes:
+#define PPSMC_Result_OK                    0x1  ///< Message Response OK
+#define PPSMC_Result_Failed                0xFF ///< Message Response Failed
+#define PPSMC_Result_UnknownCmd            0xFE ///< Message Response Unknown Command
+#define PPSMC_Result_CmdRejectedPrereq     0xFD ///< Message Response Command Failed Prerequisite
+#define PPSMC_Result_CmdRejectedBusy       0xFC ///< Message Response Command Rejected due to PMFW is busy. Sender should retry sending this message
+/** @}*/
+
+/** @defgroup definitions Message definitions
+*  @{
+*/
+// Message Definitions:
+#define PPSMC_MSG_TestMessage                   0x01 ///< To check if PMFW is alive and responding. Requirement specified by PMFW team
+#define PPSMC_MSG_GetPmfwVersion                0x02 ///< Get PMFW version
+#define PPSMC_MSG_GetDriverIfVersion            0x03 ///< Get PMFW_DRIVER_IF version
+#define PPSMC_MSG_SPARE0                        0x04 ///< SPARE
+#define PPSMC_MSG_SPARE1                        0x05 ///< SPARE
+#define PPSMC_MSG_PowerDownVcn                  0x06 ///< Power down VCN
+#define PPSMC_MSG_PowerUpVcn                    0x07 ///< Power up VCN; VCN is power gated by default
+#define PPSMC_MSG_SetHardMinVcn                 0x08 ///< For wireless display
+#define PPSMC_MSG_SetSoftMinGfxclk              0x09 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
+#define PPSMC_MSG_SPARE2                        0x0A ///< SPARE
+#define PPSMC_MSG_SPARE3                        0x0B ///< SPARE
+#define PPSMC_MSG_PrepareMp1ForUnload           0x0C ///< Prepare PMFW for GFX driver unload
+#define PPSMC_MSG_SetDriverDramAddrHigh         0x0D ///< Set high 32 bits of DRAM address for Driver table transfer
+#define PPSMC_MSG_SetDriverDramAddrLow          0x0E ///< Set low 32 bits of DRAM address for Driver table transfer
+#define PPSMC_MSG_TransferTableSmu2Dram         0x0F ///< Transfer driver interface table from PMFW SRAM to DRAM
+#define PPSMC_MSG_TransferTableDram2Smu         0x10 ///< Transfer driver interface table from DRAM to PMFW SRAM
+#define PPSMC_MSG_GfxDeviceDriverReset          0x11 ///< Request GFX mode 2 reset
+#define PPSMC_MSG_GetEnabledSmuFeatures         0x12 ///< Get enabled features in PMFW
+#define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min for SOC CLK
+#define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
+#define PPSMC_MSG_SetSoftMinVcn                 0x15 ///< Set soft min for VCN clocks (VCLK and DCLK)
+
+#define PPSMC_MSG_EnableGfxImu                  0x16 ///< Enable GFX IMU
+
+#define PPSMC_MSG_GetGfxclkFrequency            0x17 ///< Get GFX clock frequency
+#define PPSMC_MSG_GetFclkFrequency              0x18 ///< Get FCLK frequency
+#define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of allowing GFXOFF entry
+#define PPSMC_MSG_DisallowGfxOff                0x1A ///< Inform PMFW of disallowing GFXOFF entry
+#define PPSMC_MSG_SetSoftMaxGfxClk              0x1B ///< Set soft max for GFX CLK
+#define PPSMC_MSG_SetHardMinGfxClk              0x1C ///< Set hard min for GFX CLK
+
+#define PPSMC_MSG_SetSoftMaxSocclkByFreq        0x1D ///< Set soft max for SOC CLK
+#define PPSMC_MSG_SetSoftMaxFclkByFreq          0x1E ///< Set soft max for FCLK
+#define PPSMC_MSG_SetSoftMaxVcn                 0x1F ///< Set soft max for VCN clocks (VCLK and DCLK)
+#define PPSMC_MSG_PowerDownJpeg                 0x21 ///< Power down Jpeg
+#define PPSMC_MSG_PowerUpJpeg                   0x22 ///< Power up Jpeg; VCN is power gated by default
+
+#define PPSMC_MSG_SetHardMinFclkByFreq          0x23 ///< Set hard min for FCLK
+#define PPSMC_MSG_SetSoftMinSocclkByFreq        0x24 ///< Set soft min for SOC CLK
+#define PPSMC_MSG_AllowZstates                  0x25 ///< Inform PMFM of allowing Zstate entry, i.e. no Miracast activity
+#define PPSMC_MSG_Reserved                      0x26 ///< Not used
+#define PPSMC_MSG_Reserved1                     0x27 ///< Not used, previously PPSMC_MSG_RequestActiveWgp
+#define PPSMC_MSG_Reserved2                     0x28 ///< Not used, previously PPSMC_MSG_QueryActiveWgp
+#define PPSMC_MSG_PowerDownIspByTile            0x29 ///< ISP is power gated by default
+#define PPSMC_MSG_PowerUpIspByTile              0x2A ///< This message is used to power up ISP tiles and enable the ISP DPM
+#define PPSMC_MSG_SetHardMinIspiclkByFreq       0x2B ///< Set HardMin by frequency for ISPICLK
+#define PPSMC_MSG_SetHardMinIspxclkByFreq       0x2C ///< Set HardMin by frequency for ISPXCLK
+#define PPSMC_MSG_PowerDownUmsch                0x2D ///< Power down VCN.UMSCH (aka VSCH) scheduler
+#define PPSMC_MSG_PowerUpUmsch                  0x2E ///< Power up VCN.UMSCH (aka VSCH) scheduler
+#define PPSMC_Message_IspStutterOn_MmhubPgDis   0x2F ///< ISP StutterOn mmHub PgDis
+#define PPSMC_Message_IspStutterOff_MmhubPgEn   0x30 ///< ISP StufferOff mmHub PgEn
+#define PPSMC_MSG_PowerUpVpe                    0x31 ///< Power up VPE
+#define PPSMC_MSG_PowerDownVpe                  0x32 ///< Power down VPE
+#define PPSMC_MSG_GetVpeDpmTable                0x33 ///< Get VPE DPM table
+#define PPSMC_MSG_EnableLSdma                   0x34 ///< Enable LSDMA
+#define PPSMC_MSG_DisableLSdma                  0x35 ///< Disable LSDMA
+#define PPSMC_MSG_SetSoftMaxVpe                 0x36 ///<
+#define PPSMC_MSG_SetSoftMinVpe                 0x37 ///<
+#define PPSMC_Message_Count                     0x38 ///< Total number of PPSMC messages
+/** @}*/
+
+/**
+* @defgroup enums Enum Definitions
+*  @{
+*/
+
+/** @enum Mode_Reset_e
+* Mode reset type, argument for PPSMC_MSG_GfxDeviceDriverReset
+*/
+//argument for PPSMC_MSG_GfxDeviceDriverReset
+typedef enum {
+  MODE1_RESET = 1,  ///< Mode reset type 1
+  MODE2_RESET = 2   ///< Mode reset type 2
+} Mode_Reset_e;
+
+/** @}*/
+
+/** @enum ZStates_e
+* Zstate types, argument for PPSMC_MSG_AllowZstates
+*/
+//Argument for PPSMC_MSG_AllowZstates
+typedef enum  {
+  DISALLOW_ZSTATES = 0, ///< Disallow Zstates
+  ALLOW_ZSTATES_Z8 = 8, ///< Allows Z8 only
+  ALLOW_ZSTATES_Z9 = 9, ///< Allows Z9 and Z8
+} ZStates_e;
+
+/** @}*/
+#endif
-- 
2.41.0

