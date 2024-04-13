Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D41C4345F
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Apr 2024 23:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C05C510F4FD;
	Sat, 13 Apr 2024 23:40:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4KTpGElk";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2042.outbound.protection.outlook.com [40.107.95.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13A610F4FD
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Apr 2024 23:40:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGQyPo+O6qnKdV6GV9I3pyRqDsL7nYh7Pi1l5D/+j9plCeE1VFAKOH9qNpWn9PG1KE6QyzSb1qccMPxafje4ShAl5QGLw8tOzQtGgRlbLM4NRYtKjPnkEWeusvJ0+2YiVUAIwHLzGaFSixWoDosQnrTux+h4L0VX/6JxpmvVp+iiD2aOjeciebpiqO934/gjEJjTPSZ3cNvxaNwkmthXwmdD8IPN853tyCPBpjiPUpb6uiv8fcrDXUkeAWPFzu+4HvB+kIBuPpziQxc/jRi/C4JoZnCQfDiLvgrqaxpk+87DjIsJzAtat9JA79S8PKrYiJe5Oyzj2rqQLSbZ36C+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m43SJn8iHCUYQv8ciHwq7yaJwjyW2TuMul9dO0bxez8=;
 b=TWVVRL2x4bD8xXcqKfRE/en7AK2Ujai6Q2VJQ5Z/PPUO2+Itcgyoc148TkClYJ8ss7DshaJS4mi/6lqHUeM/Z9aRCWWv7wa6F+DtNhPtPFdZXTv/BnNz16gZbKGWXx4RqBXgREqaTWA3qzC+8M2ru7uw3bsnaA/8u4WjLTDdrt6oSUbTxm0N5ow3j/oUcIaC44NaUwmoT7kgpSxkUwerTdta0CRotJwByJWVewhKSj6xptGfOEIx2lDm5BaptNTSWJw1Eg9cCPALsI/nIba58cX+T3EhdI7RArN/wtrT1+7Y4kbMboeHAXhqLHYAM9XZucvBsV6uDn65lB/EyaDSbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m43SJn8iHCUYQv8ciHwq7yaJwjyW2TuMul9dO0bxez8=;
 b=4KTpGElkW6SkCcUlyk7/VNQtX/hEvIbCf/92ibR//82nwYKbMO/5FtS6Orxk5rjQUnuRayT3yBDWRl7kSfY+kwygmtEFa5SMoQw4soOLIU0Q1Oy2Jx4eIyXc3s5vcXvZPALGJt/AlsGGR3q/J98J8b2kR173H1fqeoS/tvWF7t4=
Received: from BY5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:1d0::31)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Sat, 13 Apr
 2024 23:40:22 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::68) by BY5PR04CA0021.outlook.office365.com
 (2603:10b6:a03:1d0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Sat, 13 Apr 2024 23:40:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 23:40:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 13 Apr
 2024 18:40:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/7] drm/amd/swsmu: add smu v14_0_2 ppsmc file
Date: Sat, 13 Apr 2024 19:39:41 -0400
Message-ID: <20240413233945.4002886-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240413233945.4002886-1-alexander.deucher@amd.com>
References: <20240413233945.4002886-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|PH7PR12MB5783:EE_
X-MS-Office365-Filtering-Correlation-Id: 6510ae9c-88f7-4407-5ac6-08dc5c1315e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40D+3r6TxHc0lwfg4JA6F4NBzb1AMzPCcwzAi+B3bX6xvNmntamtvOUjdE1k4KPm59GNOR3UWIU7sTf3/1YChtYtNUH3IX/qP3yasuEj6kKShksaJwqIuCjw0F1suk5gYJfIl94Eg5GAcu027JvhMWLyeVVk9A8pj0EADQBKmkgBrUB6tkdDc8xWsAizZoDIP+LQdoKxfn+MtGr4VMDxuyVpgT+kzQVIyO1t8QQbTEX1aYa11bvyU1jJf7q7Fo8e9d9ugrVIpZWxVhlGdnIokj1+fakKucIdN3uo8DPQgou7FdPN1PKMy1Ul/aeGlEmEH7KS404ZZe/SujjoVsRA7FvrHMmOCDsnbBvRybVfCeX37q4P0gRgsfLrd33PTHyax3OAG4LtwhqXuoOEk/QCoN3zHo25FguUFnLasFdQ2nTHl4OCNB1Ol/BOYXRiFO96lbKPUFKUVCGzpQousL5Xs2uRm+S1nxQ3ZmVBzMhtQKCPhcqlxgjk0LNVfVZvscfyjFjsEp2FCt6sHeE2QVtukEpBoDu1cjtycgt5VSH1uFcBB4nIfDvKlw1gtEn0GNxkXNsJVCnIz2eG9x8S7nXWSSUzyCYHyBTcFb3dAJFXV5GTOLn46JsAt6MwP3GPNoNzkiTNdcJBciosLb0AbLaSXexZnD/LPEfCi6wRJ/618QEc5R0xRzR2e/9v+sa5ST75Rq99ubJS5NWleJRUdZXcWxewXYspADMu8EhOVPmwmYMG28GK6ryC1x48jwxLMDfn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 23:40:22.0029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6510ae9c-88f7-4407-5ac6-08dc5c1315e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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

From: Kenneth Feng <kenneth.feng@amd.com>

Add initial smu v14_0_2 ppsmc file

v2: Squash in updates (Alex)
v3: Squash in updates (Alex)

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h  | 140 ++++++++++++++++++
 1 file changed, 140 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h
new file mode 100644
index 0000000000000..de2e442281ffe
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_2_ppsmc.h
@@ -0,0 +1,140 @@
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
+#ifndef SMU_V14_0_2_PPSMC_H
+#define SMU_V14_0_2_PPSMC_H
+
+#define PPSMC_VERSION 0x1
+
+// SMU Response Codes:
+#define PPSMC_Result_OK                    0x1
+#define PPSMC_Result_Failed                0xFF
+#define PPSMC_Result_UnknownCmd            0xFE
+#define PPSMC_Result_CmdRejectedPrereq     0xFD
+#define PPSMC_Result_CmdRejectedBusy       0xFC
+
+// Message Definitions:
+// BASIC
+#define PPSMC_MSG_TestMessage                    0x1
+#define PPSMC_MSG_GetSmuVersion                  0x2
+#define PPSMC_MSG_GetDriverIfVersion             0x3
+#define PPSMC_MSG_SetAllowedFeaturesMaskLow      0x4
+#define PPSMC_MSG_SetAllowedFeaturesMaskHigh     0x5
+#define PPSMC_MSG_EnableAllSmuFeatures           0x6
+#define PPSMC_MSG_DisableAllSmuFeatures          0x7
+#define PPSMC_MSG_EnableSmuFeaturesLow           0x8
+#define PPSMC_MSG_EnableSmuFeaturesHigh          0x9
+#define PPSMC_MSG_DisableSmuFeaturesLow          0xA
+#define PPSMC_MSG_DisableSmuFeaturesHigh         0xB
+#define PPSMC_MSG_GetRunningSmuFeaturesLow       0xC
+#define PPSMC_MSG_GetRunningSmuFeaturesHigh      0xD
+#define PPSMC_MSG_SetDriverDramAddrHigh          0xE
+#define PPSMC_MSG_SetDriverDramAddrLow           0xF
+#define PPSMC_MSG_SetToolsDramAddrHigh           0x10
+#define PPSMC_MSG_SetToolsDramAddrLow            0x11
+#define PPSMC_MSG_TransferTableSmu2Dram          0x12
+#define PPSMC_MSG_TransferTableDram2Smu          0x13
+#define PPSMC_MSG_UseDefaultPPTable              0x14
+
+//BACO/BAMACO/BOMACO
+#define PPSMC_MSG_EnterBaco                      0x15
+#define PPSMC_MSG_ExitBaco                       0x16
+#define PPSMC_MSG_ArmD3                          0x17
+#define PPSMC_MSG_BacoAudioD3PME                 0x18
+
+//DPM
+#define PPSMC_MSG_SetSoftMinByFreq               0x19
+#define PPSMC_MSG_SetSoftMaxByFreq               0x1A
+#define PPSMC_MSG_SetHardMinByFreq               0x1B
+#define PPSMC_MSG_SetHardMaxByFreq               0x1C
+#define PPSMC_MSG_GetMinDpmFreq                  0x1D
+#define PPSMC_MSG_GetMaxDpmFreq                  0x1E
+#define PPSMC_MSG_GetDpmFreqByIndex              0x1F
+#define PPSMC_MSG_OverridePcieParameters         0x20
+
+//DramLog Set DramAddr
+#define PPSMC_MSG_DramLogSetDramAddrHigh         0x21
+#define PPSMC_MSG_DramLogSetDramAddrLow          0x22
+#define PPSMC_MSG_DramLogSetDramSize             0x23
+#define PPSMC_MSG_SetWorkloadMask                0x24
+
+#define PPSMC_MSG_GetVoltageByDpm                0x25 // Can be removed
+#define PPSMC_MSG_SetVideoFps                    0x26 // Can be removed
+#define PPSMC_MSG_GetDcModeMaxDpmFreq            0x27
+
+//Power Gating
+#define PPSMC_MSG_AllowGfxOff                    0x28
+#define PPSMC_MSG_DisallowGfxOff                 0x29
+#define PPSMC_MSG_PowerUpVcn                     0x2A
+#define PPSMC_MSG_PowerDownVcn                   0x2B
+#define PPSMC_MSG_PowerUpJpeg                    0x2C
+#define PPSMC_MSG_PowerDownJpeg                  0x2D
+
+//Resets
+#define PPSMC_MSG_PrepareMp1ForUnload            0x2E
+#define PPSMC_MSG_Mode1Reset                     0x2F
+
+//Set SystemVirtual DramAddrHigh
+#define PPSMC_MSG_SetSystemVirtualDramAddrHigh   0x30
+#define PPSMC_MSG_SetSystemVirtualDramAddrLow    0x31
+//ACDC Power Source
+#define PPSMC_MSG_SetPptLimit                    0x32
+#define PPSMC_MSG_GetPptLimit                    0x33
+#define PPSMC_MSG_ReenableAcDcInterrupt          0x34
+#define PPSMC_MSG_NotifyPowerSource              0x35
+
+//BTC
+#define PPSMC_MSG_RunDcBtc                       0x36
+
+//                                               0x37
+
+//Others
+#define PPSMC_MSG_SetTemperatureInputSelect      0x38 // Can be removed
+#define PPSMC_MSG_SetFwDstatesMask               0x39
+#define PPSMC_MSG_SetThrottlerMask               0x3A
+
+#define PPSMC_MSG_SetExternalClientDfCstateAllow 0x3B
+
+#define PPSMC_MSG_SetMGpuFanBoostLimitRpm        0x3C
+
+//STB to dram log
+#define PPSMC_MSG_DumpSTBtoDram                  0x3D
+#define PPSMC_MSG_STBtoDramLogSetDramAddrHigh    0x3E
+#define PPSMC_MSG_STBtoDramLogSetDramAddrLow     0x3F
+#define PPSMC_MSG_STBtoDramLogSetDramSize        0x40
+#define PPSMC_MSG_SetOBMTraceBufferLogging       0x41
+
+#define PPSMC_MSG_AllowGfxDcs                    0x43
+#define PPSMC_MSG_DisallowGfxDcs                 0x44
+#define PPSMC_MSG_EnableAudioStutterWA           0x45
+#define PPSMC_MSG_PowerUpUmsch                   0x46
+#define PPSMC_MSG_PowerDownUmsch                 0x47
+#define PPSMC_MSG_SetDcsArch                     0x48
+#define PPSMC_MSG_TriggerVFFLR                   0x49
+#define PPSMC_MSG_SetNumBadMemoryPagesRetired    0x4A
+#define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4B
+#define PPSMC_MSG_SetPriorityDeltaGain           0x4C
+#define PPSMC_MSG_AllowIHHostInterrupt           0x4D
+#define PPSMC_MSG_Mode3Reset                     0x4F
+#define PPSMC_Message_Count                      0x50
+#endif
-- 
2.44.0

