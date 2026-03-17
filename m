Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAB5FD707A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6323D10E635;
	Tue, 17 Mar 2026 20:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a7iAV0j5";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FFD210E635
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:14:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odKEQFT4oZGvEgYhiqbS3YxicBIzxXtzRZNkg24DrD9VN9Skt2O8+eMfq8rZ/n4LgqTKsjYYGo7jAFQSwvLngyWrbPJC7GnVQW3rUy7vr9dqoJjv3Uy4emCxhskRlt455Az80r9+bGqQa9eGxP6lzexZWj9JRiLs/3o2KEQFcZgWR2/f0j73cKHbsbx3klCktR0efCvMHqAWINifsV7DWUT3Jk+OgTnRaTT77T+PSsM/Sb0eKNNnhxpsmC2WY6l3TO1M6po5JyyRowjcwyG1hJ4yNmXJe/fMMPVetxAib0FFHjAxvvbDzfyKV6arkGJCvcZG/uU9+mBgniOdYpRayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaMPudZs2u2APoS+BXps4qlGLMgCwQ4z5YHZ1yjHaPc=;
 b=Lu5y0j7dtXQz6zjxRjbM9+nR4KILHt+rxkDvXdDj0kD6mdMwh525B/SZtSlR6Vmt2FE6tyDB4BAECdCcI8YVYkKqTXty/bovvEaXZnpC1b6pQn9M91JVP0arssbQBXA2IFfd438o6yX2PdAckRW4ug55NfGei9QnLf9ZedKOy2KwDdFcTSWV9X3Qpyjr+Vw3q6STr3AsrtXexshEVl41Rb2kqzuvAAbAk/ZdUY50cVs0VULlVowqmQAtoTCzUNgWJWCJcH8lcqTT8w49JD2Di3ILMK4vl0HhULF6tF2cxv5G9JnlVdDEpVLQ79d4EII6LjYugI3GwXRyeRZXsxWlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaMPudZs2u2APoS+BXps4qlGLMgCwQ4z5YHZ1yjHaPc=;
 b=a7iAV0j5Bsi+oAXqkENmXCUOwf1RUEDNRqwfr4GiLomq5AxgBURFyiFk0wPtywDKKuKdT5k5pv1gadJGrc7fJHJ6qv+yjzAGa4y+js8IdN939YBuI3XSIi+tf4gq5nPRcgArFI19cklabg1ez5EeWelKsBebnnWjoGTlsa9LZXI=
Received: from PH2PEPF00003857.namprd17.prod.outlook.com (2603:10b6:518:1::79)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 20:12:58 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2a01:111:f403:f910::2) by PH2PEPF00003857.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 20:12:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 20:12:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 15:12:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 13:12:55 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 17 Mar 2026 15:12:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Yang
 Wang <kevinyang.wang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/25] drm/amd/pm: Add smu v15_0_8 driver interface header
Date: Tue, 17 Mar 2026 16:12:17 -0400
Message-ID: <20260317201242.3808136-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: c38c00e3-ab93-45d7-0ec9-08de846193fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: ADh8PyzUzgNNmPWHYYliUMVGLWEZz7Jl/Mf3NsUwgVnDuFzzhVIxMxb/pydmFVA+bNRoWTEH5TUgaGouJQiW9zcYSO98rPoP+IAcvdvpQG8X4GpSo9RXzS3W9fRkyWbHdS2+6rIEGyax0YvIxshEaGvNOMxcmQeRA96MHZWTwnSNZm2wsWCsdM3chmvHA37yfyUnEm/nOK5lCu9JqUMLI0D8dOJ+sRx67WY0hyvC7KHrKg//IRQ2pD+qDpVA7vx8DqpCaxv/sYmjRhjvisB3cY4L1kDvjon+M3s+IbtiShxc+qpUPd1Lu79ji9AMftLVpXnrbVu8Ba9362LpsM9Rp/Ixh4Pj9h+xPQ1ySyIehpv82geKXpWWNasxoEHZXuCHB7CWrtfnFYId+F1TAHhmVX43yYtMguATHC8CpSLKqwj+MKFM0zltYp9IXy4HYyWi1vO73Uu8GUrrDk4be+C8C2FUJkfkB+EKgdAh1esI3TD7CkGNdMcOiNJ02N26b97+Had0gjYtmbPvWwtdXe+moHN0vWWT1x+ufxp9DLGazyL+t9Y+PJXJd2VJ6ZIC/tHZTFxk2jBanUKPJ8gum4LShynbzFzDliZgMDdSCHB0nnUXVMEslDRl1Axg7DBkKQuwdOnlVwIjMbkd/DyT7Qq9wVtsM1hJT3il7Gu+u9MK5FPt2KK+PaYBC2aE4tJxkCuc2Q79EU0VbSwJX2JvNnWD232iH3BVRSCwtW/GtK1ihQpk9RelD6Vgw2ZLcHT/LPCRqZg9b3+OpePkz14i+R+ymg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k+ioX/aqsyzmTd3vaMUk8GfYinQFN6criYS5qV5y0VVozWYL1S4dmCg9YgWp96SJEvXPchRihiUV9R1t/SLsw0/SWprxemEcFkBO45CNUJ0kj67U/uRM9KDah/1spJ/fRpJck5YeOziKKykQxJj3nRzhw0QPF8Nz7xjAwqUI05P9X41azcvU1JNvBVum/6/ATkb0SyqMKWQRPY6mo3l3viLgtmWH/m26RZr9KMpgnpEuJVlOngIxIOCvUiYwpvWDviMdb5WCYqliCdqwL2jGPWeke2TNiD3SpLZk1puvciezomdzR8dyxyc1Q3+NFMkBBZpJoYqF/MJMmAGYVhdgQ69DuHkur65qFwG3EbQ45vKf4+Gb+iD7dXfBrW0nR7oC+hadk9oM943Pzb6kxFQ5tmLAdEcgqwP7GaEP/emFBTlNM51MtrmVFccUOKpJJRMO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 20:12:56.1319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c38c00e3-ab93-45d7-0ec9-08de846193fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add smu v15_0_8 driver interface header

v2: squash in updates (Alex)

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../inc/pmfw_if/smu15_driver_if_v15_0_8.h     | 295 ++++++++++++++++++
 1 file changed, 295 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h
new file mode 100644
index 0000000000000..6993d866183d7
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_8.h
@@ -0,0 +1,295 @@
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
+ *
+ */
+#ifndef SMU_15_0_8_DRIVER_IF_H
+#define SMU_15_0_8_DRIVER_IF_H
+
+//I2C Interface
+#define NUM_I2C_CONTROLLERS                8
+#define I2C_CONTROLLER_ENABLED             1
+#define I2C_CONTROLLER_DISABLED            0
+
+#define MAX_SW_I2C_COMMANDS                24
+
+typedef enum {
+	I2C_CONTROLLER_PORT_0,
+	I2C_CONTROLLER_PORT_COUNT,
+} I2cControllerPort_e;
+
+typedef enum {
+	/* 50  Kbits/s not supported anymore! */
+	UNSUPPORTED_1,
+	/* 100 Kbits/s */
+	I2C_SPEED_STANDARD_100K,
+	/* 400 Kbits/s */
+	I2C_SPEED_FAST_400K,
+	/* 1   Mbits/s (in fast mode) */
+	I2C_SPEED_FAST_PLUS_1M,
+	/* 1   Mbits/s (in high speed mode)  not supported anymore!*/
+	UNSUPPORTED_2,
+	/* 2.3 Mbits/s  not supported anymore! */
+	UNSUPPORTED_3,
+	I2C_SPEED_COUNT,
+} I2cSpeed_e;
+
+typedef enum {
+	I2C_CMD_READ,
+	I2C_CMD_WRITE,
+	I2C_CMD_COUNT,
+} I2cCmdType_e;
+
+#define CMDCONFIG_STOP_BIT             0
+#define CMDCONFIG_RESTART_BIT          1
+/* bit should be 0 for read, 1 for write */
+#define CMDCONFIG_READWRITE_BIT        2
+
+#define CMDCONFIG_STOP_MASK           (1 << CMDCONFIG_STOP_BIT)
+#define CMDCONFIG_RESTART_MASK        (1 << CMDCONFIG_RESTART_BIT)
+#define CMDCONFIG_READWRITE_MASK      (1 << CMDCONFIG_READWRITE_BIT)
+
+/* 64 Bit register offsets for PPSMC_MSG_McaBankDumpDW, PPSMC_MSG_McaBankCeDumpDW messages
+ * eg to read MCA_BANK_OFFSET_SYND for CE index, call PPSMC_MSG_McaBankCeDumpDW twice,
+ * (index << 16 + MCA_BANK_OFFSET_SYND*8) argument for 1st DWORD, and
+ * ((index << 16 ) + MCA_BANK_OFFSET_SYND*8 + 4) argument for 2nd DWORD */
+typedef enum {
+	MCA_BANK_OFFSET_CTL 		= 0,
+	MCA_BANK_OFFSET_STATUS 		= 1,
+	MCA_BANK_OFFSET_ADDR 		= 2,
+	MCA_BANK_OFFSET_MISC 		= 3,
+	MCA_BANK_OFFSET_IPID 		= 5,
+	MCA_BANK_OFFSET_SYND 		= 6,
+	MCA_BANK_OFFSET_MAX 		= 16,
+} MCA_BANK_OFFSET_e;
+
+/* Firmware MP1 AID MCA Error Codes stored in MCA_MP_MP1:MCMP1_SYNDT0 errorinformation */
+typedef enum {
+	/* MMHUB */
+	CODE_DAGB0        = 0,
+	CODE_DAGB1        = 1,
+	CODE_DAGB2        = 2,
+	CODE_DAGB3        = 3,
+	CODE_DAGB4        = 4,
+	CODE_EA0          = 5,
+	CODE_EA1          = 6,
+	CODE_EA2          = 7,
+	CODE_EA3          = 8,
+	CODE_EA4          = 9,
+	CODE_UTCL2_ROUTER = 10,
+	CODE_VML2         = 11,
+	CODE_VML2_WALKER  = 12,
+	CODE_MMCANE       = 13,
+
+	/* VCN VCPU */
+	CODE_VIDD         = 14,
+	CODE_VIDV         = 15,
+	/* VCN JPEG */
+	CODE_JPEG0S       = 16,
+	CODE_JPEG0D       = 17,
+	CODE_JPEG1S       = 18,
+	CODE_JPEG1D       = 19,
+	CODE_JPEG2S       = 20,
+	CODE_JPEG2D       = 21,
+	CODE_JPEG3S       = 22,
+	CODE_JPEG3D       = 23,
+	CODE_JPEG4S       = 24,
+	CODE_JPEG4D       = 25,
+	CODE_JPEG5S       = 26,
+	CODE_JPEG5D       = 27,
+	CODE_JPEG6S       = 28,
+	CODE_JPEG6D       = 29,
+	CODE_JPEG7S       = 30,
+	CODE_JPEG7D       = 31,
+	/* VCN MMSCH */
+	CODE_MMSCHD       = 32,
+
+	/* SDMA */
+	CODE_SDMA0        = 33,
+	CODE_SDMA1        = 34,
+	CODE_SDMA2        = 35,
+	CODE_SDMA3        = 36,
+
+	/* SOC */
+	CODE_HDP          = 37,
+	CODE_ATHUB        = 38,
+	CODE_IH           = 39,
+	CODE_XHUB_POISON  = 40,
+	CODE_SMN_SLVERR   = 41,
+	CODE_WDT          = 42,
+
+	CODE_UNKNOWN      = 43,
+	CODE_DMA          = 44,
+	CODE_COUNT        = 45,
+} ERR_CODE_e;
+
+/* Firmware MP5 XCD MCA Error Codes stored in MCA_MP_MP5:MCMP5_SYNDT0 errorinformation */
+typedef enum {
+	/* SH POISON FED */
+	SH_FED_CODE      = 0,
+	/* GCEA Pin UE_ERR regs */
+	GCEA_CODE        = 1,
+	SQ_CODE          = 2,
+	LDS_CODE         = 3,
+	GDS_CODE         = 4,
+	SP0_CODE         = 5,
+	SP1_CODE         = 6,
+	TCC_CODE         = 7,
+	TCA_CODE         = 8,
+	TCX_CODE         = 9,
+	CPC_CODE         = 10,
+	CPF_CODE         = 11,
+	CPG_CODE         = 12,
+	SPI_CODE         = 13,
+	RLC_CODE         = 14,
+	/* GCEA Pin, UE_EDC regs */
+	SQC_CODE         = 15,
+	TA_CODE          = 16,
+	TD_CODE          = 17,
+	TCP_CODE         = 18,
+	TCI_CODE         = 19,
+	/* GC Router */
+	GC_ROUTER_CODE   = 20,
+	VML2_CODE        = 21,
+	VML2_WALKER_CODE = 22,
+	ATCL2_CODE       = 23,
+	GC_CANE_CODE     = 24,
+
+	/* SOC error codes 41-43 are common with ERR_CODE_e */
+	MP5_CODE_SMN_SLVERR = CODE_SMN_SLVERR,
+	MP5_CODE_UNKNOWN = CODE_UNKNOWN,
+} GC_ERROR_CODE_e;
+
+/* SW I2C Command Table */
+typedef struct {
+	/* Return data for read. Data to send for write*/
+	uint8_t ReadWriteData;
+	/* Includes whether associated command should have a stop or restart command,
+	 * and is a read or write */
+	uint8_t CmdConfig;
+} SwI2cCmd_t;
+
+/* SW I2C Request Table */
+typedef struct {
+	/* CKSVII2C0(0) or //CKSVII2C1(1) */
+	uint8_t    I2CcontrollerPort;
+	/* Use I2cSpeed_e to indicate speed to select */
+	uint8_t    I2CSpeed;
+	/* Slave address of device */
+	uint8_t    SlaveAddress;
+	/* Number of commands */
+	uint8_t    NumCmds;
+	SwI2cCmd_t SwI2cCmds[MAX_SW_I2C_COMMANDS];
+} SwI2cRequest_t;
+
+typedef struct {
+	SwI2cRequest_t SwI2cRequest;
+	uint32_t       Spare[8];
+	/* SMU internal use */
+	uint32_t       MmHubPadding[8];
+} SwI2cRequestExternal_t;
+
+typedef enum {
+  PPCLK_UCLK,
+  PPCLK_COUNT,
+} PPCLK_e;
+
+typedef enum {
+	GPIO_INT_POLARITY_ACTIVE_LOW,
+	GPIO_INT_POLARITY_ACTIVE_HIGH,
+} GpioIntPolarity_e;
+
+/* TODO confirm if this is used in MI300 PPSMC_MSG_SetUclkDpmMode */
+typedef enum {
+	UCLK_DPM_MODE_BANDWIDTH,
+	UCLK_DPM_MODE_LATENCY,
+} UCLK_DPM_MODE_e;
+
+typedef struct {
+	/* 2 AVFS.PSM chains */
+	uint16_t  AvgPsmCount_Chain0[13];
+	uint16_t  AvgPsmCount_Chain1[15];
+	uint16_t  MinPsmCount_Chain0[13];
+	uint16_t  MinPsmCount_Chain1[15];
+	float     MaxTemperature;
+
+	/* For voltage conversions, these are the array indexes
+	 * 0:SOCIO
+	 * 1:065_UCIE
+	 * 2:075_UCIE
+	 * 3:11_GTA
+	 * 4:075_GTA */
+	float     MinPsmVoltage[5];
+	float     AvgPsmVoltage[5];
+} AvfsDebugTableMid_t;
+
+typedef struct {
+	/* 7 AVFS.PSM chains - not including TRO */
+	uint16_t  AvgPsmCount_Chain0[15];
+	uint16_t  AvgPsmCount_Chain1[15];
+	uint16_t  AvgPsmCount_Chain2[13];
+	uint16_t  AvgPsmCount_Chain3[13];
+	uint16_t  AvgPsmCount_Chain4[15];
+	uint16_t  AvgPsmCount_Chain5[15];
+	uint16_t  AvgPsmCount_Chain6[5];
+	uint16_t  MinPsmCount_Chain0[15];
+	uint16_t  MinPsmCount_Chain1[15];
+	uint16_t  MinPsmCount_Chain2[13];
+	uint16_t  MinPsmCount_Chain3[13];
+	uint16_t  MinPsmCount_Chain4[15];
+	uint16_t  MinPsmCount_Chain5[15];
+	uint16_t  MinPsmCount_Chain6[5];
+	float     MaxTemperature;
+
+	/* For voltage conversions, these are the array indexes
+	 * 0:VDDX */
+	float     MinPsmVoltage;
+	float     AvgPsmVoltage;
+} AvfsDebugTableAid_t;
+
+typedef struct {
+	/* 0-27 GFX, 28-29 SOC */
+	uint16_t avgPsmCount[30];
+	uint16_t minPsmCount[30];
+	float    avgPsmVoltage[30];
+	float    minPsmVoltage[30];
+} AvfsDebugTableXcd_t;
+
+/* Defines used for IH-based thermal interrupts to GFX driver - A/X only */
+#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
+#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
+#define IH_INTERRUPT_VFFLR_INT                      0xA
+
+/* thermal over-temp mask defines for IH interrup to host */
+#define THROTTLER_PROCHOT_BIT           0
+#define THROTTLER_RESERVED              1
+/* AID, XCD, CCD throttling */
+#define THROTTLER_THERMAL_SOCKET_BIT    2
+/* VRHOT */
+#define THROTTLER_THERMAL_VR_BIT        3
+#define THROTTLER_THERMAL_HBM_BIT       4
+/* UEs are always reported, set flag to 0 to prevent clearing of UEs */
+#define ClearMcaOnRead_UE_FLAG_MASK              0x1
+/* Enable CE logging and clearing to driver */
+#define ClearMcaOnRead_CE_POLL_MASK              0x2
+/* AID MMHUB client IP CE Logging and clearing */
+#define ClearMcaOnRead_MMHUB_POLL_MASK           0x4
+
+#endif
-- 
2.53.0

