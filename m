Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDE6C7EE32
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 21:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B270B10E75C;
	Fri,  3 Mar 2023 21:11:57 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFCC10E75C
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 21:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idFwoUkcPBA4WcGEZbQXBfd8TmJJWsiALezdaa9DqcMvTqr4bvEA50g9axIqdnA6N2dIwMQnhXPE6aiuLXQrvbMRWSe6OASH/KMYTjDo05YXzS3DkzCLOfBZF0wYjPWhw8iIosdIQLlew7MQeBEuMHPbaWH2i9uQ9sxVigQpCOuXaEsfMXMqgEWolhakBXdYf6JKgU14tOZio5eHzu0n3ae0gUpbMa/l+PtiLs8bB6DYcLwWTZiAPk/t7jDLgX8RwqeauAUHdvwe1xa/bKUhijDXTbKWzxc6K5N12tv5t/4FTcS0hCl9kyAxwaLdEv/wbLDVYBqLEvR+1zUeWTGc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRTioft79Z3qBzLdvE2B8S7XWKXOO12p7+0/d9b3WRI=;
 b=Gtd87JPSF98sqPLFnlLF2UEn4ROj3yo6W9Ld/hot9SoPRAFdbvrVw8VaBNPdyciAZWuJtQfiB7h5/Qe2SbjqNL5WYQFKLJylX1+Tyt1Y1qPc+YjMU5GcOfZHP4EsYdfqhHeIY+1pA4Q3GmeUzlSVnDFOn4Lbs9JyR4vZFvoYNBUII511/LnzSA1FIThvy1ZO0vvDQKa4/DITYvDZvrJAp3UFY4/XGzLuubGZEqzNtQyyqRyHxlYxFuBgllohXBAqCNI4p/3x3YlOKLxn5UNpM9dQkSHIwltzI1Jv4qngqWbbs2O9x2ekDObsdEw2vS7LcxymOcuGCoI2nsH4IK+lkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRTioft79Z3qBzLdvE2B8S7XWKXOO12p7+0/d9b3WRI=;
 b=EzqJf5HKxraeU680uSWKq9ZC31gLjbrAIhyRjMJwGeqp6Y9H8nHPLbx8dhhHygokaGYeC0MPZXGSyZpTY9lWgyVMqo3v/hTHoRDequhQpTdyNiNCxUX8fChHzEWWrZdbPa22pd7okx/ZBk3VswQCtnmF3AKBhW+ULPRfqhQiYU8=
Received: from BL0PR01CA0009.prod.exchangelabs.com (2603:10b6:208:71::22) by
 CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6156.22; Fri, 3 Mar 2023 21:11:53 +0000
Received: from BL02EPF00010207.namprd05.prod.outlook.com
 (2603:10b6:208:71:cafe::1c) by BL0PR01CA0009.outlook.office365.com
 (2603:10b6:208:71::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21 via Frontend
 Transport; Fri, 3 Mar 2023 21:11:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00010207.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.16 via Frontend Transport; Fri, 3 Mar 2023 21:11:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 15:11:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amd/pm: Add PMFW headers for SMU 13.0.6
Date: Fri, 3 Mar 2023 16:11:34 -0500
Message-ID: <20230303211135.568607-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230303211135.568607-1-alexander.deucher@amd.com>
References: <20230303211135.568607-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010207:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a20008-e9df-4dd2-9c71-08db1c2be969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htp2zVuziM3qxBrFIqdCHE6/VwIzlzBjhgDrFMGgRMJfgalgux3ZqhgWIyQuyW0GjD5ZeQTJlcyXP/D49jZD+86xQxEBVfmceY7v4CCh0SdvG9csj7oyL2jHWGHMbhWBYGmdjwUwsWKWdVij3vQU1FSJRMPTPTGQOXVfHRssBzTBxO0aAkje+hfq1uGMAXW/BrZ1ace87M5ZGIXnd0D9y6jlFHFMsUEn3F308isxdjq+rvHasOFUJ8GN9eW8A8gLzzTCv3/z8zbjn/2/+Cp6oQ4FWxDSTqh4pBqsfw6P+x8Lkj0JZ8xpXJf+yMw48MJeMXtZPWdn8wVBxmBqbvK9HOHmE/KAEkfiIgsHu0RZIjyTUWtjOapMr8WUOKQLxDlr0L3BEkMnHW8p8yHL01bMIpUf0zqvZzJ5RwueNlyBJ9SwiGkXBdLwT7dVMAaGUC6MESXu1EDHm3DHhaoyDHx4x86yRKPMQvkNmC7e0SG+mAuqXEjLyDt10Cj8ewvknTrj+17MeoVoUQfUR1Wn+jR7UdPrk1q8JFutPD1oBu0iKMik7LZoiVg/4My/Lpx7vn+sPFbkQZEnzBSttLM/WAYmcDYsp44oxfkuj934KxBLzoVzdD+NS8KLVPsYhJVYOjJGR0yx5e6/X512647oQFiz/jf4ss43Bakd5yzUEkkc7zBMLkCNK7YC7Ko8u/Ml5fFWDVd8OAtfzW6udr/ZRpF8/tb4K5uuI072nNv82WA9p6k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(40460700003)(4326008)(8676002)(70206006)(6916009)(54906003)(19627235002)(83380400001)(8936002)(316002)(36860700001)(41300700001)(5660300002)(6666004)(2616005)(1076003)(70586007)(478600001)(16526019)(186003)(426003)(47076005)(26005)(336012)(40480700001)(7696005)(82310400005)(36756003)(82740400003)(30864003)(2906002)(81166007)(356005)(66899018)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 21:11:52.7459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a20008-e9df-4dd2-9c71-08db1c2be969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Initial version of PMFW interface and message
headers for SMU 13.0.6 support.

v2: squash in location fixes (Alex)
v3: squash in updates (Alex)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_6.h     | 141 ++++++++++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h   | 212 ++++++++++++++++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h  |  95 ++++++++
 3 files changed, 448 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
new file mode 100644
index 000000000000..be596777cd2c
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
@@ -0,0 +1,141 @@
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
+#ifndef SMU_13_0_6_DRIVER_IF_H
+#define SMU_13_0_6_DRIVER_IF_H
+
+// *** IMPORTANT ***
+// PMFW TEAM: Always increment the interface version if
+// anything is changed in this file
+#define SMU13_0_6_DRIVER_IF_VERSION 0x08042022
+
+//I2C Interface
+#define NUM_I2C_CONTROLLERS                8
+#define I2C_CONTROLLER_ENABLED             1
+#define I2C_CONTROLLER_DISABLED            0
+
+#define MAX_SW_I2C_COMMANDS                24
+
+typedef enum {
+  I2C_CONTROLLER_PORT_0, //CKSVII2C0
+  I2C_CONTROLLER_PORT_1, //CKSVII2C1
+  I2C_CONTROLLER_PORT_COUNT,
+} I2cControllerPort_e;
+
+typedef enum {
+  UNSUPPORTED_1,              //50  Kbits/s not supported anymore!
+  I2C_SPEED_STANDARD_100K,    //100 Kbits/s
+  I2C_SPEED_FAST_400K,        //400 Kbits/s
+  I2C_SPEED_FAST_PLUS_1M,     //1   Mbits/s (in fast mode)
+  UNSUPPORTED_2,              //1   Mbits/s (in high speed mode)  not supported anymore!
+  UNSUPPORTED_3,              //2.3 Mbits/s  not supported anymore!
+  I2C_SPEED_COUNT,
+} I2cSpeed_e;
+
+typedef enum {
+  I2C_CMD_READ,
+  I2C_CMD_WRITE,
+  I2C_CMD_COUNT,
+} I2cCmdType_e;
+
+#define CMDCONFIG_STOP_BIT             0
+#define CMDCONFIG_RESTART_BIT          1
+#define CMDCONFIG_READWRITE_BIT        2 //bit should be 0 for read, 1 for write
+
+#define CMDCONFIG_STOP_MASK           (1 << CMDCONFIG_STOP_BIT)
+#define CMDCONFIG_RESTART_MASK        (1 << CMDCONFIG_RESTART_BIT)
+#define CMDCONFIG_READWRITE_MASK      (1 << CMDCONFIG_READWRITE_BIT)
+
+typedef struct {
+  uint8_t ReadWriteData;  //Return data for read. Data to send for write
+  uint8_t CmdConfig; //Includes whether associated command should have a stop or restart command, and is a read or write
+} SwI2cCmd_t; //SW I2C Command Table
+
+typedef struct {
+  uint8_t    I2CcontrollerPort; //CKSVII2C0(0) or //CKSVII2C1(1)
+  uint8_t    I2CSpeed;          //Use I2cSpeed_e to indicate speed to select
+  uint8_t    SlaveAddress;      //Slave address of device
+  uint8_t    NumCmds;           //Number of commands
+  SwI2cCmd_t SwI2cCmds[MAX_SW_I2C_COMMANDS];
+} SwI2cRequest_t; // SW I2C Request Table
+
+typedef struct {
+  SwI2cRequest_t SwI2cRequest;
+  uint32_t       Spare[8];
+  uint32_t       MmHubPadding[8]; // SMU internal use
+} SwI2cRequestExternal_t;
+
+typedef enum {
+  PPCLK_VCLK,
+  PPCLK_DCLK,
+  PPCLK_SOCCLK,
+  PPCLK_UCLK,
+  PPCLK_FCLK,
+  PPCLK_LCLK,
+  PPCLK_COUNT,
+} PPCLK_e;
+
+typedef enum {
+  GPIO_INT_POLARITY_ACTIVE_LOW,
+  GPIO_INT_POLARITY_ACTIVE_HIGH,
+} GpioIntPolarity_e;
+
+//TODO confirm if this is used in SMU_13_0_6 PPSMC_MSG_SetUclkDpmMode
+typedef enum {
+  UCLK_DPM_MODE_BANDWIDTH,
+  UCLK_DPM_MODE_LATENCY,
+} UCLK_DPM_MODE_e;
+
+typedef struct {
+  //0-26 SOC, 27-29 SOCIO
+  uint16_t avgPsmCount[30];
+  uint16_t minPsmCount[30];
+  float    avgPsmVoltage[30];
+  float    minPsmVoltage[30];
+} AvfsDebugTableAid_t;
+
+typedef struct {
+  //0-27 GFX, 28-29 SOC
+  uint16_t avgPsmCount[30];
+  uint16_t minPsmCount[30];
+  float    avgPsmVoltage[30];
+  float    minPsmVoltage[30];
+} AvfsDebugTableXcd_t;
+
+// These defines are used with the following messages:
+// SMC_MSG_TransferTableDram2Smu
+// SMC_MSG_TransferTableSmu2Dram
+// #define TABLE_PPTABLE                 0
+// #define TABLE_AVFS_PSM_DEBUG          1
+// #define TABLE_AVFS_FUSE_OVERRIDE      2
+// #define TABLE_PMSTATUSLOG             3
+// #define TABLE_SMU_METRICS             4
+// #define TABLE_DRIVER_SMU_CONFIG       5
+// #define TABLE_I2C_COMMANDS            6
+// #define TABLE_COUNT                   7
+
+// // Table transfer status
+// #define TABLE_TRANSFER_OK         0x0
+// #define TABLE_TRANSFER_FAILED     0xFF
+// #define TABLE_TRANSFER_PENDING    0xAB
+
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
new file mode 100644
index 000000000000..bdccbb4a6276
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -0,0 +1,212 @@
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
+#ifndef SMU_13_0_6_PMFW_H
+#define SMU_13_0_6_PMFW_H
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
+
+typedef enum {
+/*0*/   FEATURE_DATA_CALCULATION            = 0,
+/*1*/   FEATURE_DPM_CCLK                    = 1,
+/*2*/   FEATURE_DPM_FCLK                    = 2,
+/*3*/   FEATURE_DPM_GFXCLK                  = 3,
+/*4*/   FEATURE_DPM_LCLK                    = 4,
+/*5*/   FEATURE_DPM_SOCCLK                  = 5,
+/*6*/   FEATURE_DPM_UCLK                    = 6,
+/*7*/   FEATURE_DPM_VCN                     = 7,
+/*8*/   FEATURE_DPM_XGMI                    = 8,
+/*9*/   FEATURE_DS_FCLK                     = 9,
+/*10*/  FEATURE_DS_GFXCLK                   = 10,
+/*11*/  FEATURE_DS_LCLK                     = 11,
+/*12*/  FEATURE_DS_MP0CLK                   = 12,
+/*13*/  FEATURE_DS_MP1CLK                   = 13,
+/*14*/  FEATURE_DS_MPIOCLK                  = 14,
+/*15*/  FEATURE_DS_SOCCLK                   = 15,
+/*16*/  FEATURE_DS_VCN                      = 16,
+/*17*/  FEATURE_APCC_DFLL                   = 17,
+/*18*/  FEATURE_APCC_PLUS                   = 18,
+/*19*/  FEATURE_DF_CSTATE                   = 19,
+/*20*/  FEATURE_CC6                         = 20,
+/*21*/  FEATURE_PC6                         = 21,
+/*22*/  FEATURE_CPPC                        = 22,
+/*23*/  FEATURE_PPT                         = 23,
+/*24*/  FEATURE_TDC                         = 24,
+/*25*/  FEATURE_THERMAL                     = 25,
+/*26*/  FEATURE_SOC_PCC                     = 26,
+/*27*/  FEATURE_CCD_PCC                     = 27,
+/*28*/  FEATURE_CCD_EDC                     = 28,
+/*29*/  FEATURE_PROCHOT                     = 29,
+/*30*/  FEATURE_DVO_CCLK                    = 30,
+/*31*/  FEATURE_FDD_AID_HBM                 = 31,
+/*32*/  FEATURE_FDD_AID_SOC                 = 32,
+/*33*/  FEATURE_FDD_XCD_EDC                 = 33,
+/*34*/  FEATURE_FDD_XCD_XVMIN               = 34,
+/*35*/  FEATURE_FW_CTF                      = 35,
+/*36*/  FEATURE_GFXOFF                      = 36,
+/*37*/  FEATURE_SMU_CG                      = 37,
+/*38*/  FEATURE_PSI7                        = 38,
+/*39*/  FEATURE_CSTATE_BOOST                = 39,
+/*40*/  FEATURE_XGMI_PER_LINK_PWR_DOWN      = 40,
+/*41*/  FEATURE_CXL_QOS                     = 41,
+/*42*/  FEATURE_SOC_DC_RTC                  = 42,
+/*43*/  FEATURE_GFX_DC_RTC                  = 43,
+
+/*44*/  NUM_FEATURES                        = 44
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
+  VOLTAGE_COLD_0,
+  VOLTAGE_COLD_1,
+  VOLTAGE_COLD_2,
+  VOLTAGE_COLD_3,
+  VOLTAGE_COLD_4,
+  VOLTAGE_COLD_5,
+  VOLTAGE_COLD_6,
+  VOLTAGE_COLD_7,
+  VOLTAGE_MID_0,
+  VOLTAGE_MID_1,
+  VOLTAGE_MID_2,
+  VOLTAGE_MID_3,
+  VOLTAGE_MID_4,
+  VOLTAGE_MID_5,
+  VOLTAGE_MID_6,
+  VOLTAGE_MID_7,
+  VOLTAGE_HOT_0,
+  VOLTAGE_HOT_1,
+  VOLTAGE_HOT_2,
+  VOLTAGE_HOT_3,
+  VOLTAGE_HOT_4,
+  VOLTAGE_HOT_5,
+  VOLTAGE_HOT_6,
+  VOLTAGE_HOT_7,
+  VOLTAGE_GUARDBAND_COUNT
+} GFX_GUARDBAND_e;
+
+#define SMU_METRICS_TABLE_VERSION 0x1
+
+typedef struct {
+  uint32_t AccumulationCounter;
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
+  uint32_t CclkFrequencyLimit;
+  uint32_t GfxclkFrequencyLimit;
+  uint32_t FclkFrequency;
+  uint32_t UclkFrequency;
+  uint32_t SocclkFrequency[4];
+  uint32_t VclkFrequency[4];
+  uint32_t DclkFrequency[4];
+  uint32_t LclkFrequency[4];
+  uint64_t GfxclkFrequencyAcc[8];
+  uint64_t CclkFrequencyAcc[96];
+
+  //FREQUENCY RANGE
+  uint32_t MaxCclkFrequency;
+  uint32_t MinCclkFrequency;
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
+  uint32_t SocketC0Residency;
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
+} MetricsTable_t;
+
+#define SMU_VF_METRICS_TABLE_VERSION 0x1
+
+typedef struct {
+  uint32_t AccumulationCounter;
+  uint32_t InstGfxclk_TargFreq;
+  uint64_t AccGfxclk_TargFreq;
+  uint64_t AccGfxRsmuDpm_Busy;
+} VfMetricsTable_t;
+
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
new file mode 100644
index 000000000000..b838e8db395a
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -0,0 +1,95 @@
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
+#ifndef SMU_13_0_6_PPSMC_H
+#define SMU_13_0_6_PPSMC_H
+
+// SMU Response Codes:
+#define PPSMC_Result_OK                             0x1
+#define PPSMC_Result_Failed                         0xFF
+#define PPSMC_Result_UnknownCmd                     0xFE
+#define PPSMC_Result_CmdRejectedPrereq              0xFD
+#define PPSMC_Result_CmdRejectedBusy                0xFC
+
+// Message Definitions:
+#define PPSMC_MSG_TestMessage                       0x1
+#define PPSMC_MSG_GetSmuVersion                     0x2
+#define PPSMC_MSG_GfxDriverReset                    0x3
+#define PPSMC_MSG_GetDriverIfVersion                0x4
+#define PPSMC_MSG_EnableAllSmuFeatures              0x5
+#define PPSMC_MSG_DisableAllSmuFeatures             0x6
+#define PPSMC_MSG_RequestI2cTransaction             0x7
+#define PPSMC_MSG_GetMetricsVersion                 0x8
+#define PPSMC_MSG_GetMetricsTable                   0x9
+#define PPSMC_MSG_GetEccInfoTable                   0xA
+#define PPSMC_MSG_GetEnabledSmuFeaturesLow          0xB
+#define PPSMC_MSG_GetEnabledSmuFeaturesHigh         0xC
+#define PPSMC_MSG_SetDriverDramAddrHigh             0xD
+#define PPSMC_MSG_SetDriverDramAddrLow              0xE
+#define PPSMC_MSG_SetToolsDramAddrHigh              0xF
+#define PPSMC_MSG_SetToolsDramAddrLow               0x10
+#define PPSMC_MSG_SetSystemVirtualDramAddrHigh      0x11
+#define PPSMC_MSG_SetSystemVirtualDramAddrLow       0x12
+#define PPSMC_MSG_SetSoftMinByFreq                  0x13
+#define PPSMC_MSG_SetSoftMaxByFreq                  0x14
+#define PPSMC_MSG_GetMinDpmFreq                     0x15
+#define PPSMC_MSG_GetMaxDpmFreq                     0x16
+#define PPSMC_MSG_GetDpmFreqByIndex                 0x17
+#define PPSMC_MSG_SetPptLimit                       0x18
+#define PPSMC_MSG_GetPptLimit                       0x19
+#define PPSMC_MSG_DramLogSetDramAddrHigh            0x1A
+#define PPSMC_MSG_DramLogSetDramAddrLow             0x1B
+#define PPSMC_MSG_DramLogSetDramSize                0x1C
+#define PPSMC_MSG_GetDebugData                      0x1D
+#define PPSMC_MSG_HeavySBR                          0x1E
+#define PPSMC_MSG_SetNumBadHbmPagesRetired          0x1F
+#define PPSMC_MSG_DFCstateControl                   0x20
+#define PPSMC_MSG_GetGmiPwrDnHyst                   0x21
+#define PPSMC_MSG_SetGmiPwrDnHyst                   0x22
+#define PPSMC_MSG_GmiPwrDnControl                   0x23
+#define PPSMC_MSG_EnterGfxoff                       0x24
+#define PPSMC_MSG_ExitGfxoff                        0x25
+#define PPSMC_MSG_EnableDeterminism                 0x26
+#define PPSMC_MSG_DisableDeterminism                0x27
+#define PPSMC_MSG_DumpSTBtoDram                     0x28
+#define PPSMC_MSG_STBtoDramLogSetDramAddrHigh       0x29
+#define PPSMC_MSG_STBtoDramLogSetDramAddrLow        0x2A
+#define PPSMC_MSG_STBtoDramLogSetDramSize           0x2B
+#define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrHigh 0x2C
+#define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrLow  0x2D
+#define PPSMC_MSG_GfxDriverResetRecovery            0x2E
+#define PPSMC_MSG_TriggerVFFLR                      0x2F
+#define PPSMC_MSG_SetSoftMinGfxClk                  0x30
+#define PPSMC_MSG_SetSoftMaxGfxClk                  0x31
+#define PPSMC_MSG_GetMinGfxDpmFreq                  0x32
+#define PPSMC_MSG_GetMaxGfxDpmFreq                  0x33
+#define PPSMC_Message_Count                         0x34
+
+//PPSMC Reset Types for driver msg argument
+#define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
+#define PPSMC_RESET_TYPE_DRIVER_MODE_2_RESET	      0x2
+#define PPSMC_RESET_TYPE_DRIVER_MODE_3_RESET        0x3
+
+typedef uint32_t PPSMC_Result;
+typedef uint32_t PPSMC_MSG;
+
+#endif
-- 
2.39.2

