Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DE4CD611F
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 18:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B0D210E2A5;
	Mon,  9 Oct 2023 18:33:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD84710E2A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 18:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHda/LySClWikyDb5W+kSg/vRPz+7feJJd7sW/12PcD3GVJGCz8pc6DSHsdMgKPS+Sinomhy4774m4KbKVI5DmmraTmYXzh0eWAEPVmNXR8hexjZcuatcFJPugyvu1EV7bEaEnejsJaMSsqEpNai6dGzreeMeg/RXlX2+vFtoaDqvHke0lzwMu1ZihVpdR6d/T0Vt+bM5gje6McM6VSBWZmFnqtknGimjr22saLFb2+wc5PcxRJs9y8uum9mpRWPfUx+KDh3LFCZTbh3hokn92pJoqpWg9lZ3zkrDpJTEr789CdMs7Jotr0i1cTAlXAZA+WaY9ek5gPWOCyPuRpIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxNOYeK7VJtebyjvUWc7UzddlC4rP++nBaQhpAFDVgo=;
 b=nl7enP8+OoxSw2mz6slET+tT41hCTH7VFHV3+dJwuoYjbTZBnuxhSd7l4SSi/1I7VmhMpb1o99CUzCQLS88qB+T4Wg3JkGLspCB0PRUdeRBBLodDVHFyQ+AxGvuzG3XmhtHiv7X8DYEMGC2WqP3glxeiN4LmzrkZqhI8Qm9KC8B4+rvOsSc6AfgxWX5fXO7cnH1P0OKNbUWvuMpkKoQErJMPDs97QD1yzILGFeffKLSpNk0Omp/ttM+tFfl9w7AAxJ0qEzev2qV4Zn7CDOcByT+9v2hkMSnEUe35RfBgNsG64+p3jEW2jlCGyAlK77RqoW0XVimi4XYfxeiQyTKw3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxNOYeK7VJtebyjvUWc7UzddlC4rP++nBaQhpAFDVgo=;
 b=sl5u9kKCq80M1bp/V621ctjr64KQ1q6zqGFKKApLMX13fbTjDLFyjb9cLj3uhm/gKjt6DZNF0QcQOCpw2fJfwBGb77Ytk09J8WbqgeC5s/5a3/pfk/wsZAcNvoxqua6wXM7BNznB+Ogf+J8t6toFJZ8Hub6BQX2snO0bnpBvft0=
Received: from BL1PR13CA0344.namprd13.prod.outlook.com (2603:10b6:208:2c6::19)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 18:33:09 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::c4) by BL1PR13CA0344.outlook.office365.com
 (2603:10b6:208:2c6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Mon, 9 Oct 2023 18:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 18:33:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:33:07 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amd/swsmu: add smu v14_0_0 pmfw if file
Date: Mon, 9 Oct 2023 14:32:32 -0400
Message-ID: <20231009183234.518379-4-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6c7adc-3752-4a4e-aaf8-08dbc8f62f76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjltOF036rxRMD8/hf9d8XcWUVQMepRlQDV56wZ18TLDromus9quIIVVe4zqFUjOsXbivhoFl8qupOAQfondXPGMsWxa9brugQMUGnv/WFOKeznwRU4hSEIq5hFehQ8FLTJF79WLJxZvkvfXdrdOkv1KN5nLu3UdK5GgUcqeNHXTwWIUKtFUNZvevL9wfW92D5Bhlqd+T97odl9rhUfOdBzbtA8j1vyWo43XWh4U7pooh1kX7p8+bs9VtyPPqAbsU0HZxhUPjJVAV6ez31tc6XfuSFe9+CwIku1dmZFGbW+KbcIMWCUhZomoWP2sN8jkYmsnpnFbUcVZs65T8+h7YO/icXII3pyydZvenJ7e6d6sxk3KmRgmIEjV7ykUAj4C8ZLV82hGiACo5/LOlNZI5NcbH5lPi7URR0AlWbl1B10vl6JKTJeRiJ5KUPqS+UxZ9tK3tVNMiElJftzNgq+339G8hkRzhnnmKSvvWmADgLW6CjFC1x1aBAd9grv1KAcpqG9moE7Q/zVaGrprT75MJf0iBJ44u1eo9I3iTgysTIXAO4PzzD50uu2p9JBhwGg5oT6jjeTTH9J6zsMRqIpquk+nRwHhpKWYL/qjRuXsnHfMcxn71PZLeZL2eDl9Yh+pmvhwzeNMUHa8HcjEdIQU7YGJFu1xC6wsU1i4BtEsl0IvamDzmsI8V6cIQkI+HpK+Opf8DV0K7qbNrSL6cFyU7ZIVcvbht467rdeag00PPShKFJN+jeVC23G8xTQD9bn2vJ+EZWbzDw73pny1ytIcHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(6666004)(66899024)(7696005)(2616005)(1076003)(40460700003)(82740400003)(36756003)(86362001)(40480700001)(81166007)(356005)(36860700001)(83380400001)(336012)(2906002)(47076005)(426003)(41300700001)(478600001)(316002)(26005)(8676002)(19627235002)(8936002)(4326008)(16526019)(5660300002)(70586007)(54906003)(70206006)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:33:08.6560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6c7adc-3752-4a4e-aaf8-08dbc8f62f76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209
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

Add initial smu v14_0_0 pmfw if file

v2: squash in updates (Alex)

Signed-off-by: Li Ma <li.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h   | 156 ++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h
new file mode 100644
index 000000000000..0dea30cceb98
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h
@@ -0,0 +1,156 @@
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
+#ifndef __SMU_V14_0_0_PMFW_H__
+#define __SMU_V14_0_0_PMFW_H__
+
+#include "smu14_driver_if_v14_0_0.h"
+
+#pragma pack(push, 1)
+
+#define ENABLE_DEBUG_FEATURES
+
+// Firmware features
+// Feature Control Defines
+#define FEATURE_CCLK_DPM_BIT                 0
+#define FEATURE_FAN_CONTROLLER_BIT           1
+#define FEATURE_DATA_CALCULATION_BIT         2
+#define FEATURE_PPT_BIT                      3
+#define FEATURE_TDC_BIT                      4
+#define FEATURE_THERMAL_BIT                  5
+#define FEATURE_FIT_BIT                      6
+#define FEATURE_EDC_BIT                      7
+#define FEATURE_PLL_POWER_DOWN_BIT           8
+#define FEATURE_VDDOFF_BIT                   9
+#define FEATURE_VCN_DPM_BIT                 10
+#define FEATURE_DS_MPM_BIT                  11
+#define FEATURE_FCLK_DPM_BIT                12
+#define FEATURE_SOCCLK_DPM_BIT              13
+#define FEATURE_DS_MPIO_BIT                 14
+#define FEATURE_LCLK_DPM_BIT                15
+#define FEATURE_SHUBCLK_DPM_BIT             16
+#define FEATURE_DCFCLK_DPM_BIT              17
+#define FEATURE_ISP_DPM_BIT                 18
+#define FEATURE_IPU_DPM_BIT                 19
+#define FEATURE_GFX_DPM_BIT                 20
+#define FEATURE_DS_GFXCLK_BIT               21
+#define FEATURE_DS_SOCCLK_BIT               22
+#define FEATURE_DS_LCLK_BIT                 23
+#define FEATURE_LOW_POWER_DCNCLKS_BIT       24  // for all DISP clks
+#define FEATURE_DS_SHUBCLK_BIT              25
+#define FEATURE_GFX_TEMP_VMIN_BIT           26
+#define FEATURE_ZSTATES_BIT                 27
+#define FEATURE_IOMMUL2_PG_BIT              28
+#define FEATURE_DS_FCLK_BIT                 29
+#define FEATURE_DS_SMNCLK_BIT               30
+#define FEATURE_DS_MP1CLK_BIT               31
+#define FEATURE_RESERVED3                   32
+#define FEATURE_SMU_LOW_POWER_BIT           33
+#define FEATURE_SMART_L3_RINSER_BIT         34
+#define FEATURE_GFX_DEM_BIT                 35
+#define FEATURE_PSI_BIT                     36
+#define FEATURE_PROCHOT_BIT                 37
+#define FEATURE_CPUOFF_BIT                  38
+#define FEATURE_STAPM_BIT                   39
+#define FEATURE_S0I3_BIT                    40
+#define FEATURE_DF_LIGHT_CSTATE             41   // shift the order or DFCstate annd DF light Cstate
+#define FEATURE_PERF_LIMIT_BIT              42
+#define FEATURE_CORE_DLDO_BIT               43
+#define FEATURE_DVO_BIT                     44
+#define FEATURE_DS_VCN_BIT                  45
+#define FEATURE_CPPC_BIT                    46
+#define FEATURE_CPPC_PREFERRED_CORES        47
+#define FEATURE_DF_CSTATES_BIT              48
+#define FEATURE_RESERVED4                   49
+#define FEATURE_ATHUB_PG_BIT                50
+#define FEATURE_VDDOFF_ECO_BIT              51
+#define FEATURE_ZSTATES_ECO_BIT             52
+#define FEATURE_CC6_BIT                     53
+#define FEATURE_DS_UMCCLK_BIT               54
+#define FEATURE_DS_ISPCLK_BIT               55
+#define FEATURE_DS_HSPCLK_BIT               56
+#define FEATURE_RESERVED5                   57
+#define FEATURE_DS_IPUCLK_BIT               58
+#define FEATURE_DS_VPECLK_BIT               59
+#define FEATURE_VPE_DPM_BIT                 60
+#define FEATURE_BABYPHASE_SVI3_BIT          61
+#define FEATURE_FP_DIDT_BIT                 62
+#define NUM_FEATURES                        63
+
+// Firmware Header/Footer
+struct SMU14_Firmware_Footer {
+  uint32_t Signature;
+};
+typedef struct SMU14_Firmware_Footer SMU14_Firmware_Footer;
+
+// PSP3.0 Header Definition
+typedef struct {
+  uint32_t ImageVersion;
+  uint32_t ImageVersion2; // This is repeated because DW0 cannot be written in SRAM due to HW bug.
+  uint32_t Padding0[3];
+  uint32_t SizeFWSigned;
+  uint32_t Padding1[25];
+  uint32_t FirmwareType;
+  uint32_t Filler[32];
+} SMU_Firmware_Header;
+
+typedef struct {
+  // MP1_EXT_SCRATCH0
+  uint32_t DpmHandlerID         : 8;
+  uint32_t ActivityMonitorID    : 8;
+  uint32_t DpmTimerID           : 8;
+  uint32_t DpmHubID             : 4;
+  uint32_t DpmHubTask           : 4;
+  // MP1_EXT_SCRATCH1
+  uint32_t CclkSyncStatus       : 8;
+  uint32_t GfxOffStatus         : 2;
+  uint32_t CpuOff               : 2;
+  uint32_t VddOff               : 1;
+  uint32_t spare0               : 3;
+  uint32_t ZstateStatus         : 4;
+  uint32_t spare1               : 4;
+  uint32_t DstateFun            : 4;
+  uint32_t DstateDev            : 4;
+  // MP1_EXT_SCRATCH2
+  uint32_t P2JobHandler         :24;
+  uint32_t RsmuPmiP2PendingCnt  : 8;
+  // MP1_EXT_SCRATCH3
+  uint32_t PostCode             :32;
+  // MP1_EXT_SCRATCH4
+  uint32_t MsgPortBusy          :24;
+  uint32_t RsmuPmiP1Pending     : 1;
+  uint32_t DfCstateExitPending  : 1;
+  uint32_t Pc6EntryPending      : 1;
+  uint32_t Pc6ExitPending       : 1;
+  uint32_t WarmResetPending     : 1;
+  uint32_t spare2               : 3;
+  // MP1_EXT_SCRATCH5
+  uint32_t IdleMask             :32;
+  // MP1_EXT_SCRATCH6 = RTOS threads' status
+  // MP1_EXT_SCRATCH7 = RTOS Current Job
+} FwStatus_t;
+
+
+#pragma pack(pop)
+
+#endif
-- 
2.41.0

