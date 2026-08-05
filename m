Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7B6C55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 06:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 160FA10ED0F;
	Wed,  5 Aug 2026 06:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I2xPg7Nr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013016.outbound.protection.outlook.com
 [40.93.196.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16A110ED0F
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 06:41:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfHREvvu62ClAwf3Ri4ufGcYOU8jx36/8LBrb3ZPq5ibbjKv3/DDVAhAZ1ZDP3NKYWyUBxj4/b8uSIZmMh+vpbg+mQ2ObCAGkROArc6DDxzgk8DIX/MyCCP7FWDXY5bDIVKiPEdny2cdI4rEVa8wt66wKsL9x4nO/w74lTaLEwxMm/ycXnUYKKv+EFGS0UKeYki5Y9N17+jnZt8DsbNWBbb/PvovY6wvkDntmlIGjiOT8v2y4ScuMdaqXd8N4CLozfibewiZmsvm/bqNi+9wTIP6IBbZi0qyr/QkBFvYloyoXxaUqy04tcJ8EQgzJisRzXypJUnpaZqdveRP7+A7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ta2mMef1JhBo8flwUxv8X5rPHPaOrxdaOYAOxQXqpdM=;
 b=XJdXI7CDIjA1XeSXwwDA5UQLD29ADAehXg2Iibzpgtjls7aqwSV0qz2+4BcONcmKctLbreDZ5VsvKQrGKwT892o3V0moPVpiTh0CmEwE13q6+WlExPFFCD1zElLOjVp4SnMPfAIfh5A33BK+sBlgoKs0LsigfcXKM6iPJzDAlv03BXyFLWmwS+uP/LodMmIL565/GGNEIBaeygVUjueF2x2qNnPmXlJ2e9EXkia4rlyIIeaqTK0b6W5X19UAUuQJrsUUgzMIr2CaYVO/12ZNsEfeU4eNSxtJ627iuMDkD8Mf1V7v8bXMhN2eggRB33Jw/OjOA2HLtGD2l2k1LH4Xfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ta2mMef1JhBo8flwUxv8X5rPHPaOrxdaOYAOxQXqpdM=;
 b=I2xPg7NrANdVC8ZTTyq1EacYXFYkOjtzcUxAVNmTqzxtlQFwEY7aQ7ZnuFMwUdtMPjbXvyal8VREHUpX7lNwEbkSpaSqHSrvQ1+CAAWOISmSuYO2655iaBwML6XmzVgXb73Ak9mSEN0HwLqWYpjzJWbeLN1ctdkOPOdBKORxNvc=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 06:41:41 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::4) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 06:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Wed, 5 Aug 2026 06:41:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 5 Aug
 2026 01:41:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 23:41:39 -0700
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 5 Aug 2026 01:41:36 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 27/34] drm/amd/display: Update dcn60 clkmgr interfaces
Date: Wed, 5 Aug 2026 14:36:39 +0800
Message-ID: <20260805063937.2145774-28-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: ee15b2d1-f99d-4b31-ff74-08def2bc9ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|56012099006|5023799004|10067099003|20052099010|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YblST03Myw7PirsBpaGXmyC5K4XXQmBinnhH3EmsnAra4vFA+U0Q8fm3QhVVzll8cjvjgspiYKj+SokTR3hJFl7ubBw1Kof5tnfatmvpS6dRKggseRWBAbgbkyT0XfhbYUwd9zDbq69w2J/flWxOgRsWYrDnBJMwoL75wai2XvlNq/j6Nrr/vr/sN1CksH3BKGFrs8RZM5ctPzfrx7z/bTbB65j41LDYA6Rnqv6OlskUBeP56OdJtP2ic/Acl+PH+8b0+wrMUWdwIvpzPhRyPswInJEZ/SZmY8UNnEwXBZxr1FX6EGQguM/Vx2zAINW5VGhZjuZ2U4GwdTmVGJWjwge0AP8CKqH/c7XDBk4SxwKw6Eow5qtn2OWokyBLeGW/DPQVSX/o8tnhfbQPQxRJFexQ+XYlhcAwNQWowbzbB9JnXdtCDnZrsGurkO3LIuy2DVS7X9Fa8DEArO7jTOExYbcutGCawlI9qjPvrXlqcd4DyKi2eJWpxfxR0IeKT9OtWFEk+yAqrkWVBW1+6hgT0NVgY5Wu7Wi089zEV9Anx3Mhw9wTF5iAQT4puWYYqug/8sv4aP7WPSqGR5SBlZx0uSOSMvJnSejx7b7ax60u0vJI4HH8qxYdjs3kXTgBDbVh0eAIE6ROxoCDrpYlcAzSOVgcuT0/IgDiWJjQEn1AoPhTmnNUyPC/TDuWYt3uNMJinJnAAphwdqdOopAcqtJNOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(56012099006)(5023799004)(10067099003)(20052099010)(11063799006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7EEC9f2tkPjmxm+VWue82l6Du2SsOQyn9nd7saV5vVvtNaraWP4t2PRdlc7kUihzEztDI/yvBEbkmB9qa0zclA2iCVzjGYTZG4gbm+QOfgEbaRzt/BKFKOpQMrvDmp5ZBzw/S098/2zUShSomgNKbjwhpjg+tedlngxFEiqpcgC8fpeUXCVNYUH05C3+0jeKi1DmktqTbWcrhtE1qq7gyNyKQkvtOtkyg9/pL2ATpt6uiY98Du5xjMXfLlI3M5+lfkVHkfK1vv2+ilGgpQovFEYxa/uqZ1wROgPXfqTBtAFmBCDnMte4GY95PnYpSRUl+KpPSf9o3K7Yq1RlcE9X8n7uPRO9zfcLe/EiYFldwTe0rxxFtWjV6/i3yH+oPL+A9HoEJaRETGGUgiJZLcqURiO9KUC7sXrvPrJGx1UNsfooZ53xwrO0vbcwyY27spuO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 06:41:41.0713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee15b2d1-f99d-4b31-ff74-08def2bc9ba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
Update clk_mgr interfaces to match with the DAL<->PMFW
message interfaces for DCN6.
- dalsmc.h MAX_PPCLK_COUNT must match PPCLK count in driver_if header
- include driver_if header as a local copy for now since PMFW carried one
  will not build
- clk table returned by PMFW is in Khz, must convert to Mhz accordingly
- boot snapshot for dispclk is in Khz
- Get*Clk interfaces should return frequency in Khz, ensure that DAL
  interfaces are implemented to handle this
- Move structure definitions into dcn60_clk_mgr_smu_msg.h header since
  the official dalsmc.h header does not carry all these definitions yet

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h | 344 ++++--------------
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 111 +++---
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h  |  17 +-
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c  | 220 +++++++++--
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h  | 167 ++++++++-
 .../dc/clk_mgr/dcn60/dcn60_smu_driver_if.h    |  76 ++++
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   3 +-
 7 files changed, 569 insertions(+), 369 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
index e10621b5eeff..6954a54dad89 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
@@ -6,287 +6,30 @@
 #define DALSMC_H
 
 /**
- * @file dalsmc.h
- *
- * @brief VBIOS and DAL to PMFW Interface
- *
- * Clients:  VBIOS and DAL
- * Protocols: dalsmc
- *
- * @date 2016 - 2026
- */
+* @file dalsmc.h
+*
+* @brief VBIOS and DAL to PMFW Interface
+*
+* Clients:  VBIOS and DAL
+* Protocols:
+*
+* @date 2016 - 2026
+*/
 
 /**
  * @mainpage PMFW-DAL Message Interface
+ * This documentation contains the subsections:
  *
- * The protocol uses six registers:
- *
- * - MSG_REG   — write the message ID (DALSMC_MSG_*) to trigger the transaction
- * - ARG_REG_0 — input argument Reg0; also carries response data on completion
- * - ARG_REG_1 — input argument Reg1
- * - ARG_REG_2 — input argument Reg2
- * - ARG_REG_3 — input argument Reg3
- * - RESP_REG  — poll until non-zero; value is a DALSMC_Result_* response code
- *
- * Programming sequence:
- * 1. Clear RESP_REG to 0
- * 2. Write input arguments to ARG_REG_0..3
- * 3. Write message ID to MSG_REG (triggers PMFW interrupt)
- * 4. Poll RESP_REG until non-zero — value is the result code
- * 5. Read response data from ARG_REG_0 (message-specific)
- *
- * For payloads too large for the four argument registers, the protocol supports
- * DRAM table transfers where DAL allocates a DRAM buffer and exchanges bulk data
- * with PMFW through system memory.
- *
- * This documentation contains the subsections:\n\n
- * @ref ResponseCodes\n
- * @ref Messages\n
- * @ref DramTables\n
- */
-
-#define DALSMC_VERSION  0x1
-
-/** @defgroup ResponseCodes PMFW Response Codes
- *  @{
- */
-// SMU Response Codes:
-#define DALSMC_Result_OK                    0x01
-#define DALSMC_Result_Failed                0xFF
-#define DALSMC_Result_UnknownCmd            0xFE
-#define DALSMC_Result_CmdRejectedPrereq     0xFD
-#define DALSMC_Result_CmdRejectedBusy       0xFC
-/** @} */
-
-/** @defgroup Messages Message definitions
- *  @{
+ * @ref ResponseCodes
+ * @ref definitions
  */
 
-/** Generic register overlay — four 32-bit C2PMSG argument registers. */
-typedef struct {
-	uint32_t Reg0;
-	uint32_t Reg1;
-	uint32_t Reg2;
-	uint32_t Reg3;
-} DALSMC_args_t;
+/** @def DAL_PMFW_IF_VER
+* VBIOS and DAL to PMFW IF version 1.0
+*/
+#define DAL_PMFW_IF_VER "1.0" ///< Major.Minor
 
-/**
- * DALSMC_MSG_TestMessage - Test interface connectivity.
- *
- * Echos back the argument value incremented by 1. Use to verify the mailbox
- * is functional before sending real messages.
- *
- * Request:  TestValue — arbitrary test integer
- * Response: Reg0      — TestValue + 1
- */
-#define DALSMC_MSG_TestMessage                  0x01
-typedef union {
-	struct {
-		uint32_t TestValue;
-		uint32_t Reserved[3];
-	};
-	DALSMC_args_t Args;
-} DALSMC_TestMessage_arg_t;
-
-/**
- * DALSMC_MSG_GetMsgHeaderVersion - Query the DALSMC header version running on PMFW.
- *
- * DAL uses the returned version to determine which messages are supported in
- * environments that require backwards compatibility.
- *
- * Request:  (none)
- * Response: Reg0 — DALSMC_VERSION value compiled into PMFW
- */
-#define DALSMC_MSG_GetMsgHeaderVersion          0x02
-
-/**
- * DALSMC_MSG_TransferTableSmu2Dram - Transfer a PMFW table into DRAM.
- * DALSMC_MSG_TransferTableDram2Smu - Transfer a DRAM buffer into PMFW.
- *
- * Both directions use the same argument layout. The DRAM address must be set
- * beforehand (AddrLow / AddrHigh are the GPU MC address bits [31:0] / [63:32]).
- *
- * Smu2Dram supported tables: TABLE_DAL_INIT (DPM clocks + UTM QoS + memory config)
- * Dram2Smu supported tables: TABLE_SOC_UTM  (debug override of UTM QoS parameters)
- *
- * Request:  TableId  — table identifier (TABLE_* defines below)
- *           AddrLow  — GPU MC address bits [31:0]  of destination/source buffer
- *           AddrHigh — GPU MC address bits [63:32] of destination/source buffer
- * Response: (none beyond result code)
- */
-#define DALSMC_MSG_TransferTableSmu2Dram        0x03
-#define DALSMC_MSG_TransferTableDram2Smu        0x04
-typedef union {
-	struct {
-		uint32_t TableId;
-		uint32_t AddrLow;
-		uint32_t AddrHigh;
-		uint32_t Reserved;
-	};
-	DALSMC_args_t Args;
-} DALSMC_TransferTable_arg_t;
-
-/**
- * DALSMC_MSG_SetHardMinByFreq - Set a lower bound frequency constraint on a PPCLK.
- *
- * Response does not indicate that the effective clock has already been raised to
- * meet the minimum requirement; poll DALSMC_MSG_ReturnHardMinStatus for the status
- * of the request.
- *
- * Supported clocks: SOCCLK, DISPCLK, DPPCLK, DCFCLK, DTBCLK.
- *
- * Request:  FreqKhz[23:0] — target minimum frequency in kHz (0 to ~16.7 GHz)
- *           Ppclk[31:24]  — PPCLK_e clock identifier
- * Response: (none beyond result code)
- */
-#define DALSMC_MSG_SetHardMinByFreq             0x05
-typedef union {
-	struct {
-		uint32_t FreqKhz : 24;
-		uint32_t Ppclk   : 8;
-		uint32_t Reserved[3];
-	};
-	DALSMC_args_t Args;
-} DALSMC_SetHardMinByFreq_arg_t;
-
-/**
- * DALSMC_MSG_SetMinDeepSleepDcfclk - Set the minimum DCFCLK frequency in deep sleep.
- *
- * Request:  MinDcfclkMhz — minimum DCFCLK frequency in MHz during deep sleep
- * Response: (none beyond result code)
- */
-#define DALSMC_MSG_SetMinDeepSleepDcfclk        0x06
-typedef union {
-	struct {
-		uint32_t MinDcfclkMhz;
-		uint32_t Reserved[3];
-	};
-	DALSMC_args_t Args;
-} DALSMC_SetMinDeepSleepDcfclk_arg_t;
-
-/**
- * DALSMC_MSG_BacoAudioD3PME - Wake the audio block from D3/BACO.
- *
- * Triggers PMFW to bring the AZ (audio) block out of its D3 power state.
- * No arguments or response data; result code indicates success.
- */
-#define DALSMC_MSG_BacoAudioD3PME               0x07
-
-/**
- * DALSMC_MSG_ReturnHardMinStatus - Query outstanding hard-min request status.
- *
- * Returns a bitmask reporting which PPCLK hard-min requests have been satisfied
- * by the arbiter. Each bit position corresponds to the matching PPCLK_e value.
- * A set bit means the arbiter has reached or exceeded the requested minimum.
- *
- * Request:  (none)
- * Response: Reg0 — bitmask of satisfied PPCLKs (bit N set ↔ PPCLK_e N is satisfied)
- */
-#define DALSMC_MSG_ReturnHardMinStatus          0x08
-
-/**
- * DALSMC_MSG_IndicatePstateStatus - Indicate to PMFW various DMU behaviors required
- * to support UCLK P-state, for example whether or not DMU needs to modulate refresh
- * rate to perform UCLK switches.
- *
- * Request:  WaitResp[0]   — DAL requires a synchronous response before proceeding
- *           DrrEnable[1]  — DRR (dynamic refresh rate modulation) is active
- *           AltCh[2]      — alternate-channel mode is active
- *           AllowUclk[16] — DCN can tolerate UCLK P-state switches
- *           AllowFclk[17] — DCN can tolerate FCLK P-state switches
- * Response: (none beyond result code)
- */
-#define DALSMC_MSG_IndicatePstateStatus         0x09
-typedef union {
-	struct {
-		uint32_t WaitResp  : 1;
-		uint32_t DrrEnable : 1;
-		uint32_t AltCh     : 1;
-		uint32_t Reserved  : 13;
-		uint32_t AllowUclk : 1;
-		uint32_t AllowFclk : 1;
-		uint32_t Reserved1 : 14;
-		uint32_t Reserved2[3];
-	};
-	DALSMC_args_t Args;
-} DALSMC_IndicatePstateStatus_arg_t;
-
-/**
- * DALSMC_MSG_UpdateUTMQoSRequest - Update the active UTM QoS bandwidth/latency request.
- *
- * Passes the current display bandwidth and latency requirements to PMFW so it
- * can select the appropriate SoC operating point (UCLK/FCLK level) from the
- * UTM table. Called whenever the display configuration changes.
- *
- * The QoS requirement must take effect before PMFW sends its response.
- *
- * Request:  LatencySopIndex      — index into the UTM SOP table that satisfies latency
- *           NominalBandwidthKBps — required nominal (average) bandwidth in KB/s
- *           UrgentBandwidthKBps  — required urgent bandwidth in KB/s
- *           LsdmaBandwidthKBps   — required LSDMA bandwidth in KB/s
- * Response: (none beyond result code)
- */
-#define DALSMC_MSG_UpdateUTMQoSRequest          0x0A
-typedef union {
-	struct {
-		uint32_t LatencySopIndex;
-		uint32_t NominalBandwidthKBps;
-		uint32_t UrgentBandwidthKBps;
-		uint32_t LsdmaBandwidthKBps;
-	};
-	DALSMC_args_t Args;
-} DALSMC_UpdateUTMQoSRequest_arg_t;
-
-/**
- * DALSMC_MSG_SetDisplayIdleOptimizations - Notify PMFW of DCN idle-state conditions.
- *
- * Indicates which display-side power optimizations are currently safe to apply.
- * PMFW uses these flags to gate deeper SoC power states such as S0i2.
- *
- * Request:  DfRequestDisabled[0] — DF (data fabric) requests from DCN are disabled
- *           PhyRefClkOff[1]      — PHY reference clock has been gated off
- *           S0i2Rdy[2]           — DCN is ready for the system to enter S0i2
- * Response: (none beyond result code)
- */
-#define DALSMC_MSG_SetDisplayIdleOptimizations  0x0B
-typedef union {
-	struct {
-		uint32_t DfRequestDisabled : 1;
-		uint32_t PhyRefClkOff      : 1;
-		uint32_t S0i2Rdy           : 1;
-		uint32_t Reserved          : 29;
-		uint32_t Reserved1[3];
-	};
-	DALSMC_args_t Args;
-} DALSMC_SetDisplayIdleOptimizations_arg_t;
-
-/**
- * DALSMC_MSG_SetStutterEfficiency - Report DCN stutter efficiency to PMFW.
- *
- * Informs PMFW of the current stutter utilisation for base and low-power stutter
- * modes so PMFW can adjust memory power policy accordingly.
- *
- * Base mode    — lower enter+exit latency (PHY LP1, no UCIE LP).
- * Low-power mode — higher enter+exit latency (PHY LP2, UCIE LP1).
- *
- * Request:  BaseEfficiencyPct[7:0]     — stutter efficiency % in base mode
- *           LowPowerEfficiencyPct[15:8] — stutter efficiency % in low-power mode
- * Response: (none beyond result code)
- */
-#define DALSMC_MSG_SetStutterEfficiency         0x0C
-typedef union {
-	struct {
-		uint32_t BaseEfficiencyPct     : 8;
-		uint32_t LowPowerEfficiencyPct : 8;
-		uint32_t Reserved              : 16;
-		uint32_t Reserved1[3];
-	};
-	DALSMC_args_t Args;
-} DALSMC_SetStutterEfficiency_arg_t;
-
-#define DALSMC_Message_Count                    0x0D ///< Total number of messages
-
-/** @} */
+#define DALSMC_VERSION 0x1
 
 /** @defgroup DramTables DRAM Tables
  *  @brief Bulk data structures exchanged between DAL and PMFW via system DRAM.
@@ -362,14 +105,14 @@ typedef struct {
 	+ (SopIndex)) * sizeof(SocUtmSopEntry_t))
 typedef struct {
 	SocUtmTableHeader_t Header;
-	SocUtmSopEntry_t Sops[MAX_UTM_LOAD_LEVEL_COUNT][DALSMC_MAX_UTM_SOP_COUNT];
+	SocUtmSopEntry_t Sops[MAX_UTM_LOAD_LEVEL_COUNT][DALSMC_MAX_UTM_SOP_COUNT];// 4 and 3 for dGPU PMFW
 } SocUtmTable_t;
 
 /**
  * TABLE_DAL_INIT - Full TABLE_DAL_INIT payload transferred from SMU to DRAM.
  */
 #define TABLE_DAL_INIT    0xD
-#define MAX_PPCLK_COUNT   12
+#define MAX_PPCLK_COUNT   20
 #define DPM_CLOCK_OFFSET(Ppclk) \
 	(sizeof(DalInitHeader_t) + (Ppclk) * sizeof(DpmClock_t))
 #define UTM_TABLE_OFFSET \
@@ -384,6 +127,51 @@ typedef struct {
 	MemoryConfig_t    MemoryConfig;
 } DalInitTable_t;
 
-/** @} */
 
-#endif /* DALSMC_H */
+/** @defgroup ResponseCodes PMFW Response Codes
+*  @{
+*/
+// SMU Response Codes:
+#define DALSMC_Result_OK                    0x01 ///< Message Response OK
+#define DALSMC_Result_Failed                0xFF ///< Message Response Failed
+#define DALSMC_Result_UnknownCmd            0xFE ///< Message Response Unknown Command
+#define DALSMC_Result_CmdRejectedPrereq     0xFD ///< Message Response Command Failed Prerequisite
+#define DALSMC_Result_CmdRejectedBusy       0xFC ///< Message Response Command Rejected due to PMFW is busy. Sender should retry sending this message
+/** @}*/
+
+// Message Definitions:
+/** @defgroup definitions Message definitions
+*  @{
+*/
+#define DALSMC_MSG_TestMessage                  0x01 ///< To check if PMFW is alive and responding. Requirement specified by PMFW team
+#define DALSMC_MSG_GetPmfwVersion               0x02 ///< Get version
+#define DALSMC_MSG_SetDispclkFreq               0x03 ///< Set display clock frequency in MHZ
+#define DALSMC_MSG_SetDppclkFreq                0x04 ///< Set DPP clock frequency in MHZ
+#define DALSMC_MSG_SetHardMinDcfclkByFreq       0x05 ///< Set DCF clock frequency hard min in MHZ
+#define DALSMC_MSG_SetMinDeepSleepDcfclk        0x06 ///< Set DCF clock minimum frequency in deep sleep in MHZ
+#define DALSMC_MSG_GetFclkFrequency             0x07 ///< Get FCLK frequency, return frequemcy in MHZ
+#define DALSMC_MSG_UpdatePmeRestore             0x08 ///< To ask PMFW to write into Azalia for PME wake up event
+#define DALSMC_MSG_SetDramAddrHigh              0x09 ///< Set DRAM address high 32 bits for WM table transfer
+#define DALSMC_MSG_SetDramAddrLow               0x0A ///< Set DRAM address low 32 bits for WM table transfer
+#define DALSMC_MSG_TransferTableSmu2Dram        0x0B ///< Transfer table from PMFW SRAM to system DRAM
+#define DALSMC_MSG_TransferTableDram2Smu        0x0C ///< Transfer table from system DRAM to PMFW
+#define DALSMC_MSG_SetDisplayIdleOptimizations  0x0D ///< Set Idle state optimization for display off
+#define DALSMC_MSG_GetDprefclkFreq              0x0E ///< Get DPREF clock frequency. Return in MHZ
+#define DALSMC_MSG_GetDtbclkFreq                0x0F ///< Get DTB clock frequency. Return in MHZ
+#define DALSMC_MSG_AllowZstatesEntry_Spare0     0x10 ///< Inform PMFW of display allowing Zstate entry
+#define DALSMC_MSG_SetDtbClk                    0x11 ///< Set DTB clock frequency in MHZ
+#define DALSMC_MSG_DispIPS2Exit_Spare1          0x12 ///< Display IPS2 exit
+#define DALSMC_MSG_QueryIPS2Support             0x13 ///< Return 1: support; else not supported
+#define DALSMC_MSG_BandWidthRequest             0x14 ///< Arg 1-15: BwUrg; Arg 16-31: BwNonUrg
+#define DALSMC_MSG_UpdateUtmQosParams           0x15
+#define DALSMC_MSG_StutterEfficiency            0x16
+#define DALSMC_MSG_GetMsgHeaderVersion          0x17 ///< Get message header version
+#define DALSMC_MSG_SacoAudioD3PME               0x18 ///< Saco audio D3 PME
+#define DALSMC_MSG_ReturnHardMinStatus          0x19 ///< Return hard min status
+#define DALSMC_MSG_GetDispclkFreq               0x1A ///< Get display clock frequency. Return in MHZ
+#define DALSMC_MSG_GetDppclkFreq                0x1B ///< Get DPP clock frequency. Return in MHZ
+#define DALSMC_Message_Count                    0x1C ///< Total number of VBIS and DAL messages
+
+/** @}*/
+
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index d71b0aed90c9..ead4ae9e51eb 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -213,13 +213,13 @@ static void dcn60_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 	}
 }
 
-static int dcn60_set_hard_min_by_freq_optimized(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, int requested_clk_khz)
+static int dcn60_set_clock_freq_optimized(struct clk_mgr_internal *clk_mgr, PPCLK_e clk, int requested_clk_khz)
 {
 	if (!clk_mgr->smu_present || !dcn60_is_ppclk_dpm_enabled(clk_mgr, clk))
 		return 0;
 
 	/*
-	 * SMU set hard min interface takes requested clock in mhz and return
+	 * SMU set clock interface takes requested clock in mhz and returns
 	 * actual clock configured in khz. If we floor requested clk to mhz,
 	 * there is a chance that the actual clock configured in khz is less
 	 * than requested. If we ceil it to mhz, there is a chance that it
@@ -228,11 +228,11 @@ static int dcn60_set_hard_min_by_freq_optimized(struct clk_mgr_internal *clk_mgr
 	 * clock returned is less than requested, then we will ceil the
 	 * requested value to mhz and call it again.
 	 */
-	int actual_clk_khz = dcn60_smu_set_hard_min_by_freq(clk_mgr, clk,
+	int actual_clk_khz = dcn60_smu_set_clock_freq(clk_mgr, clk,
 		(uint16_t)khz_to_mhz_floor(requested_clk_khz));
 
 	if (actual_clk_khz < requested_clk_khz)
-		actual_clk_khz = dcn60_smu_set_hard_min_by_freq(clk_mgr, clk,
+		actual_clk_khz = dcn60_smu_set_clock_freq(clk_mgr, clk,
 			(uint16_t)khz_to_mhz_ceil(requested_clk_khz));
 
 	return actual_clk_khz;
@@ -324,8 +324,8 @@ static unsigned int dcn60_build_update_display_clocks_sequence(
 		should_set_clock(safe_to_lower, new_clocks->ref_dtbclk_khz / 1000, clk_mgr_base->clks.ref_dtbclk_khz / 1000) && //TODO these should be ceiled
 		dcn60_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DTBCLK)) {
 		/* DCCG requires KHz precision for DTBCLK */
-		block_sequence[num_steps].params.update_hardmin_params.ppclk = PPCLK_DTBCLK;
-		block_sequence[num_steps].params.update_hardmin_params.freq_mhz =
+		block_sequence[num_steps].params.set_ppclk_params.ppclk = PPCLK_DTBCLK;
+		block_sequence[num_steps].params.set_ppclk_params.freq_mhz =
 			(uint16_t)khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz);
 		for (i = 0; i < context->stream_count; i++) {
 			otg_master = resource_get_otg_master_for_stream(
@@ -338,11 +338,11 @@ static unsigned int dcn60_build_update_display_clocks_sequence(
 			}
 		}
 		if (frl_present)
-			block_sequence[num_steps].params.update_hardmin_params.freq_mhz =
+			block_sequence[num_steps].params.set_ppclk_params.freq_mhz =
 				(uint16_t)clk_mgr_base->bw_params->clk_table.entries[
 					clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels - 1].dtbclk_mhz;
-		block_sequence[num_steps].params.update_hardmin_params.response = &clk_mgr_base->clks.ref_dtbclk_khz;
-		block_sequence[num_steps].func = CLK_MGR60_UPDATE_HARDMIN_PPCLK;
+		block_sequence[num_steps].params.set_ppclk_params.response = &clk_mgr_base->clks.ref_dtbclk_khz;
+		block_sequence[num_steps].func = CLK_MGR60_SET_PPCLK;
 		num_steps++;
 
 		/* Update DTO in DCCG */
@@ -366,10 +366,10 @@ static unsigned int dcn60_build_update_display_clocks_sequence(
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 
 		if (dcn60_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DISPCLK)) {
-			block_sequence[num_steps].params.update_hardmin_optimized_params.ppclk = PPCLK_DISPCLK;
-			block_sequence[num_steps].params.update_hardmin_optimized_params.freq_khz = clk_mgr_base->clks.dispclk_khz;
-			block_sequence[num_steps].params.update_hardmin_optimized_params.response = &clk_mgr_base->clks.actual_dispclk_khz;
-			block_sequence[num_steps].func = CLK_MGR60_UPDATE_HARDMIN_PPCLK_OPTIMIZED;
+			block_sequence[num_steps].params.set_ppclk_optimized_params.ppclk = PPCLK_DISPCLK;
+			block_sequence[num_steps].params.set_ppclk_optimized_params.freq_khz = clk_mgr_base->clks.dispclk_khz;
+			block_sequence[num_steps].params.set_ppclk_optimized_params.response = &clk_mgr_base->clks.actual_dispclk_khz;
+			block_sequence[num_steps].func = CLK_MGR60_SET_PPCLK_OPTIMIZED;
 			num_steps++;
 		}
 
@@ -386,10 +386,10 @@ static unsigned int dcn60_build_update_display_clocks_sequence(
 			num_steps++;
 
 			if (dcn60_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DPPCLK)) {
-				block_sequence[num_steps].params.update_hardmin_optimized_params.ppclk = PPCLK_DPPCLK;
-				block_sequence[num_steps].params.update_hardmin_optimized_params.freq_khz = clk_mgr_base->clks.dppclk_khz;
-				block_sequence[num_steps].params.update_hardmin_optimized_params.response = &clk_mgr_base->clks.actual_dppclk_khz;
-				block_sequence[num_steps].func = CLK_MGR60_UPDATE_HARDMIN_PPCLK_OPTIMIZED;
+				block_sequence[num_steps].params.set_ppclk_optimized_params.ppclk = PPCLK_DPPCLK;
+				block_sequence[num_steps].params.set_ppclk_optimized_params.freq_khz = clk_mgr_base->clks.dppclk_khz;
+				block_sequence[num_steps].params.set_ppclk_optimized_params.response = &clk_mgr_base->clks.actual_dppclk_khz;
+				block_sequence[num_steps].func = CLK_MGR60_SET_PPCLK_OPTIMIZED;
 				num_steps++;
 
 				block_sequence[num_steps].params.update_dppclk_dto_params.context = context;
@@ -401,10 +401,10 @@ static unsigned int dcn60_build_update_display_clocks_sequence(
 		} else {
 			/* if clock is being raised, increase refclk before lowering DTO */
 			if (update_dppclk && dcn60_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DPPCLK)) {
-				block_sequence[num_steps].params.update_hardmin_optimized_params.ppclk = PPCLK_DPPCLK;
-				block_sequence[num_steps].params.update_hardmin_optimized_params.freq_khz = clk_mgr_base->clks.dppclk_khz;
-				block_sequence[num_steps].params.update_hardmin_optimized_params.response = &clk_mgr_base->clks.actual_dppclk_khz;
-				block_sequence[num_steps].func = CLK_MGR60_UPDATE_HARDMIN_PPCLK_OPTIMIZED;
+				block_sequence[num_steps].params.set_ppclk_optimized_params.ppclk = PPCLK_DPPCLK;
+				block_sequence[num_steps].params.set_ppclk_optimized_params.freq_khz = clk_mgr_base->clks.dppclk_khz;
+				block_sequence[num_steps].params.set_ppclk_optimized_params.response = &clk_mgr_base->clks.actual_dppclk_khz;
+				block_sequence[num_steps].func = CLK_MGR60_SET_PPCLK_OPTIMIZED;
 				num_steps++;
 			}
 
@@ -528,37 +528,37 @@ static void dcn60_populate_clk_table(struct clk_mgr_internal *clk_mgr,
 	dpm_clk = &init_table->PPClocks[PPCLK_DCFCLK];
 	num_entries->num_dcfclk_levels = dpm_clk->NumClocks;
 	for (i = 0; i < dpm_clk->NumClocks && i < NUM_CLOCK_LEVELS; i++)
-		clk_table->entries[i].dcfclk_mhz = dpm_clk->Clocks[i];
+		clk_table->entries[i].dcfclk_mhz = khz_to_mhz_ceil(dpm_clk->Clocks[i]);
 
 	/* SOCCLK */
 	dpm_clk = &init_table->PPClocks[PPCLK_SOCCLK];
 	num_entries->num_socclk_levels = dpm_clk->NumClocks;
 	for (i = 0; i < dpm_clk->NumClocks && i < NUM_CLOCK_LEVELS; i++)
-		clk_table->entries[i].socclk_mhz = dpm_clk->Clocks[i];
+		clk_table->entries[i].socclk_mhz = khz_to_mhz_ceil(dpm_clk->Clocks[i]);
 
 	/* DTBCLK */
 	dpm_clk = &init_table->PPClocks[PPCLK_DTBCLK];
 	num_entries->num_dtbclk_levels = dpm_clk->NumClocks;
 	for (i = 0; i < dpm_clk->NumClocks && i < NUM_CLOCK_LEVELS; i++)
-		clk_table->entries[i].dtbclk_mhz = dpm_clk->Clocks[i];
+		clk_table->entries[i].dtbclk_mhz = khz_to_mhz_ceil(dpm_clk->Clocks[i]);
 
 	/* DISPCLK */
 	dpm_clk = &init_table->PPClocks[PPCLK_DISPCLK];
 	num_entries->num_dispclk_levels = dpm_clk->NumClocks;
 	for (i = 0; i < dpm_clk->NumClocks && i < NUM_CLOCK_LEVELS; i++)
-		clk_table->entries[i].dispclk_mhz = dpm_clk->Clocks[i];
+		clk_table->entries[i].dispclk_mhz = khz_to_mhz_ceil(dpm_clk->Clocks[i]);
 
 	/* DPPCLK */
 	dpm_clk = &init_table->PPClocks[PPCLK_DPPCLK];
 	num_entries->num_dppclk_levels = dpm_clk->NumClocks;
 	for (i = 0; i < dpm_clk->NumClocks && i < NUM_CLOCK_LEVELS; i++)
-		clk_table->entries[i].dppclk_mhz = dpm_clk->Clocks[i];
+		clk_table->entries[i].dppclk_mhz = khz_to_mhz_ceil(dpm_clk->Clocks[i]);
 
 	/* UCLK */
 	dpm_clk = &init_table->PPClocks[PPCLK_UCLK];
 	num_entries->num_memclk_levels = dpm_clk->NumClocks;
 	for (i = 0; i < dpm_clk->NumClocks && i < NUM_CLOCK_LEVELS; i++)
-		clk_table->entries[i].memclk_mhz = dpm_clk->Clocks[i];
+		clk_table->entries[i].memclk_mhz = khz_to_mhz_ceil(dpm_clk->Clocks[i]);
 	if (num_entries->num_memclk_levels)
 		clk_mgr->base.bw_params->max_memclk_mhz =
 				clk_table->entries[num_entries->num_memclk_levels - 1].memclk_mhz;
@@ -567,7 +567,7 @@ static void dcn60_populate_clk_table(struct clk_mgr_internal *clk_mgr,
 	dpm_clk = &init_table->PPClocks[PPCLK_FCLK];
 	num_entries->num_fclk_levels = dpm_clk->NumClocks;
 	for (i = 0; i < dpm_clk->NumClocks && i < NUM_CLOCK_LEVELS; i++)
-		clk_table->entries[i].fclk_mhz = dpm_clk->Clocks[i];
+		clk_table->entries[i].fclk_mhz = khz_to_mhz_ceil(dpm_clk->Clocks[i]);
 
 	if (num_entries->num_memclk_levels >= num_entries->num_fclk_levels)
 		clk_table->num_entries = num_entries->num_memclk_levels;
@@ -688,7 +688,7 @@ void dcn60_init_clocks(struct clk_mgr *clk_mgr_base)
 	memset(&(clk_mgr_base->clks), 0, sizeof(struct dc_clocks));
 	clk_mgr_base->clks.p_state_change_support = true;
 	clk_mgr_base->clks.fclk_p_state_change_support = false;
-	clk_mgr_base->force_smu_not_present = true; // temporary until SMU ready
+	//clk_mgr_base->force_smu_not_present = true; // temporary until SMU ready
 	clk_mgr->smu_present = !clk_mgr_base->force_smu_not_present /* not force-disabled */
 			&& dcn60_smu_get_msg_header_version(clk_mgr, &smu_header_ver)
 			&& smu_header_ver != 0;
@@ -951,28 +951,38 @@ static void dcn60_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned
 		params = &clk_mgr60->block_sequence[i].params;
 
 		switch (clk_mgr60->block_sequence[i].func) {
-		case CLK_MGR60_UPDATE_HARDMIN_PPCLK:
-			if (params->update_hardmin_params.response)
-				*params->update_hardmin_params.response = dcn60_smu_set_hard_min_by_freq(
+		case CLK_MGR60_SET_PPCLK:
+			if (params->set_ppclk_params.response)
+				*params->set_ppclk_params.response = dcn60_smu_set_clock_freq(
 						clk_mgr_internal,
-						params->update_hardmin_params.ppclk,
-						params->update_hardmin_params.freq_mhz);
+						params->set_ppclk_params.ppclk,
+						params->set_ppclk_params.freq_mhz);
 			else
-				dcn60_smu_set_hard_min_by_freq(clk_mgr_internal,
-						params->update_hardmin_params.ppclk,
-						params->update_hardmin_params.freq_mhz);
+				dcn60_smu_set_clock_freq(clk_mgr_internal,
+						params->set_ppclk_params.ppclk,
+						params->set_ppclk_params.freq_mhz);
 			break;
-		case CLK_MGR60_UPDATE_HARDMIN_PPCLK_OPTIMIZED:
-			if (params->update_hardmin_optimized_params.response)
-				*params->update_hardmin_optimized_params.response =
-					dcn60_set_hard_min_by_freq_optimized(
+		case CLK_MGR60_SET_PPCLK_OPTIMIZED:
+			if (params->set_ppclk_optimized_params.response)
+				*params->set_ppclk_optimized_params.response =
+					dcn60_set_clock_freq_optimized(
 						clk_mgr_internal,
-						params->update_hardmin_optimized_params.ppclk,
-						params->update_hardmin_optimized_params.freq_khz);
+						params->set_ppclk_optimized_params.ppclk,
+						params->set_ppclk_optimized_params.freq_khz);
 			else
-				dcn60_set_hard_min_by_freq_optimized(clk_mgr_internal,
-						params->update_hardmin_optimized_params.ppclk,
-						params->update_hardmin_optimized_params.freq_khz);
+				dcn60_set_clock_freq_optimized(clk_mgr_internal,
+						params->set_ppclk_optimized_params.ppclk,
+						params->set_ppclk_optimized_params.freq_khz);
+			break;
+		case CLK_MGR60_UPDATE_HARDMIN_DCFCLK:
+			if (params->update_hardmin_dcfclk_params.response)
+				*params->update_hardmin_dcfclk_params.response =
+					dcn60_smu_set_hard_min_dcfclk_by_freq(
+						clk_mgr_internal,
+						params->update_hardmin_dcfclk_params.freq_mhz);
+			else
+				dcn60_smu_set_hard_min_dcfclk_by_freq(clk_mgr_internal,
+						params->update_hardmin_dcfclk_params.freq_mhz);
 			break;
 		case CLK_MGR60_UPDATE_DEEP_SLEEP_DCFCLK:
 			dcn60_smu_set_min_deep_sleep_dcfclk(
@@ -1169,13 +1179,12 @@ static unsigned int dcn60_build_bandwidth_clocks_block_sequence_with_action(
 		num_steps++;
 	}
 
-	/* CLK_MGR60_UPDATE_HARDMIN_PPCLK — DCFCLK */
+	/* CLK_MGR60_UPDATE_HARDMIN_DCFCLK — DCFCLK */
 	if (action->dcfclk.send_message) {
-		block_sequence[num_steps].params.update_hardmin_params.ppclk = PPCLK_DCFCLK;
-		block_sequence[num_steps].params.update_hardmin_params.freq_mhz =
+		block_sequence[num_steps].params.update_hardmin_dcfclk_params.freq_mhz =
 			(uint16_t)khz_to_mhz_ceil(new_clocks->dcfclk_khz);
-		block_sequence[num_steps].params.update_hardmin_params.response = NULL;
-		block_sequence[num_steps].func = CLK_MGR60_UPDATE_HARDMIN_PPCLK;
+		block_sequence[num_steps].params.update_hardmin_dcfclk_params.response = NULL;
+		block_sequence[num_steps].func = CLK_MGR60_UPDATE_HARDMIN_DCFCLK;
 		num_steps++;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
index 1c9cd4e95aac..0625f060e8c6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
@@ -17,14 +17,20 @@ union dcn60_clk_mgr_block_sequence_params {
 		uint16_t freq_mhz;
 		/* outputs */
 		int *response;
-	} update_hardmin_params;
+	} set_ppclk_params;
 	struct {
 		/* inputs */
 		uint32_t ppclk;
 		int freq_khz;
 		/* outputs */
 		int *response;
-	} update_hardmin_optimized_params;
+	} set_ppclk_optimized_params;
+	struct {
+		/* inputs */
+		uint16_t freq_mhz;
+		/* outputs */
+		int *response;
+	} update_hardmin_dcfclk_params;
 	struct {
 		/* inputs */
 		uint16_t freq_mhz;
@@ -72,8 +78,7 @@ union dcn60_clk_mgr_block_sequence_params {
 
 enum dcn60_clk_mgr_block_sequence_func {
 	CLK_MGR60_READ_CLOCKS_FROM_DENTIST,
-	CLK_MGR60_UPDATE_HARDMIN_PPCLK,
-	CLK_MGR60_UPDATE_HARDMIN_PPCLK_OPTIMIZED,
+	CLK_MGR60_UPDATE_HARDMIN_DCFCLK,
 	CLK_MGR60_UPDATE_DEEP_SLEEP_DCFCLK,
 	CLK_MGR60_INDICATE_PSTATE_STATUS,
 	CLK_MGR60_UPDATE_DPPCLK_DTO,
@@ -81,7 +86,9 @@ enum dcn60_clk_mgr_block_sequence_func {
 	CLK_MGR60_UPDATE_DENTIST,
 	CLK_MGR60_UPDATE_PSR_WAIT_LOOP,
 	CLK_MGR60_UPDATE_STUTTER_EFFICIENCY,
-	CLK_MGR60_UPDATE_UTM_QOS_REQUEST
+	CLK_MGR60_UPDATE_UTM_QOS_REQUEST,
+	CLK_MGR60_SET_PPCLK,
+	CLK_MGR60_SET_PPCLK_OPTIMIZED,
 };
 
 struct dcn60_clk_mgr_block_sequence {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c
index 697ed8f747d4..f56a49151c4d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c
@@ -8,9 +8,9 @@
 #include "reg_helper.h"
 
 #include "dalsmc.h"
-#include "dcn401/dcn401_smu14_driver_if.h"
+#include "dcn60/dcn60_smu_driver_if.h"
 
-/* MMIO = MP1_BASE__INST0_SEG1 (0x16200 from at2_offset.h)
+/* MMIO = MP1_BASE__INST0_SEG1 (0x16200 from <dgpu>_offset.h)
  *      + regMP1_SMN_C2PMSG_N  (sequential from 0xA2)
  * MSG=C2PMSG_98, RESP=C2PMSG_99, ARG0..3=C2PMSG_100..103
  */
@@ -159,11 +159,9 @@ static unsigned int dcn60_smu_get_hard_min_status(struct clk_mgr_internal *clk_m
 }
 
 
-static bool dcn60_smu_wait_hard_min_status(struct clk_mgr_internal *clk_mgr, uint32_t ppclk)
+static bool dcn60_smu_wait_hard_min_status(struct clk_mgr_internal *clk_mgr)
 {
 	const unsigned int max_delay_us = 1000000;
-
-	unsigned int hardmin_status_mask = (1 << ppclk);
 	unsigned int total_delay_us = 0;
 	bool hardmin_done = false;
 
@@ -182,37 +180,183 @@ static bool dcn60_smu_wait_hard_min_status(struct clk_mgr_internal *clk_mgr, uin
 
 		hardmin_status = dcn60_smu_get_hard_min_status(clk_mgr, &no_timeout, &read_total_delay_us);
 		total_delay_us += read_total_delay_us;
-		hardmin_done = hardmin_status & hardmin_status_mask;
+		hardmin_done = hardmin_status;
 	}
 
 	return hardmin_done;
 }
 
-/* TODO: update callers to pass kHz directly for finer granularity
- * now that the DALSMC interface supports 24-bit kHz encoding.
+/*
+ * DCFCLK still uses a hard-min arbiter request. Send the DCFCLK-specific
+ * hard-min message and poll ReturnHardMinStatus until the arbiter reports the
+ * minimum has been satisfied. PMFW returns the actual configured freq (kHz).
  */
-unsigned int dcn60_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz)
+unsigned int dcn60_smu_set_hard_min_dcfclk_by_freq(struct clk_mgr_internal *clk_mgr, uint16_t freq_mhz)
 {
-	DALSMC_SetHardMinByFreq_arg_t arg = {};
+	DALSMC_SetClockFreq_arg_t arg = {};
 	uint32_t response = 0;
 	bool hard_min_done = false;
 
-	smu_print("SMU Set hard min by freq: clk = %d, freq_mhz = %d MHz\n", clk, freq_mhz);
+	smu_print("SMU Set DCFCLK hard min by freq: freq_mhz = %d MHz\n", freq_mhz);
 
-	/* New interface encodes frequency in kHz (24-bit) and PPCLK in bits [31:24] */
-	arg.FreqKhz = (uint32_t)freq_mhz * 1000;
-	arg.Ppclk   = clk;
+	arg.FreqMhz = freq_mhz;
 
 	dcn60_smu_send_msg_with_args(clk_mgr,
-			DALSMC_MSG_SetHardMinByFreq, arg.Args, &response, NULL);
+			DALSMC_MSG_SetHardMinDcfclkByFreq, arg.Args, &response, NULL);
 
 	/* wait until hardmin acknowledged */
-	hard_min_done = dcn60_smu_wait_hard_min_status(clk_mgr, clk);
-	smu_print("SMU Frequency set = %d KHz hard_min_done %d\n", response, hard_min_done);
+	hard_min_done = dcn60_smu_wait_hard_min_status(clk_mgr);
+	smu_print("SMU DCFCLK set = %d KHz hard_min_done %d\n", response, hard_min_done);
 
 	return response;
 }
 
+/*
+ * DISPCLK / DPPCLK / DTBCLK are programmed directly (not via a hard-min arbiter
+ * request). PMFW returns the actual configured frequency in kHz.
+ */
+static unsigned int dcn60_smu_set_dispclk_freq(struct clk_mgr_internal *clk_mgr, uint16_t freq_mhz)
+{
+	DALSMC_SetClockFreq_arg_t arg = {};
+	uint32_t response = 0;
+
+	arg.FreqMhz = freq_mhz;
+	dcn60_smu_send_msg_with_args(clk_mgr,
+			DALSMC_MSG_SetDispclkFreq, arg.Args, &response, NULL);
+
+	return response;
+}
+
+static unsigned int dcn60_smu_set_dppclk_freq(struct clk_mgr_internal *clk_mgr, uint16_t freq_mhz)
+{
+	DALSMC_SetClockFreq_arg_t arg = {};
+	uint32_t response = 0;
+
+	arg.FreqMhz = freq_mhz;
+	dcn60_smu_send_msg_with_args(clk_mgr,
+			DALSMC_MSG_SetDppclkFreq, arg.Args, &response, NULL);
+
+	return response;
+}
+
+static unsigned int dcn60_smu_set_dtb_clk(struct clk_mgr_internal *clk_mgr, uint16_t freq_mhz)
+{
+	DALSMC_SetClockFreq_arg_t arg = {};
+	uint32_t response = 0;
+
+	arg.FreqMhz = freq_mhz;
+	dcn60_smu_send_msg_with_args(clk_mgr,
+			DALSMC_MSG_SetDtbClk, arg.Args, &response, NULL);
+
+	return response;
+}
+
+static unsigned int dcn60_smu_get_dispclk_freq_khz(struct clk_mgr_internal *clk_mgr)
+{
+	DALSMC_args_t args = {};
+	uint32_t response = 0;
+
+	dcn60_smu_send_msg_with_args(clk_mgr,
+			DALSMC_MSG_GetDispclkFreq, args, &response, NULL);
+
+	return response;
+}
+
+static unsigned int dcn60_smu_get_dppclk_freq_khz(struct clk_mgr_internal *clk_mgr)
+{
+	DALSMC_args_t args = {};
+	uint32_t response = 0;
+
+	dcn60_smu_send_msg_with_args(clk_mgr,
+			DALSMC_MSG_GetDppclkFreq, args, &response, NULL);
+
+	return response;
+}
+
+static unsigned int dcn60_smu_get_dtbclk_freq_khz(struct clk_mgr_internal *clk_mgr)
+{
+	DALSMC_args_t args = {};
+	uint32_t response = 0;
+
+	dcn60_smu_send_msg_with_args(clk_mgr,
+			DALSMC_MSG_GetDtbclkFreq, args, &response, NULL);
+
+	return response;
+}
+
+/* Return the current frequency (KHz) for a display-domain clock. */
+static unsigned int dcn60_smu_get_clock_freq_khz(struct clk_mgr_internal *clk_mgr, uint32_t clk)
+{
+	switch (clk) {
+	case PPCLK_DISPCLK:
+		return dcn60_smu_get_dispclk_freq_khz(clk_mgr);
+	case PPCLK_DPPCLK:
+		return dcn60_smu_get_dppclk_freq_khz(clk_mgr);
+	case PPCLK_DTBCLK:
+		return dcn60_smu_get_dtbclk_freq_khz(clk_mgr);
+	default:
+		return 0;
+	}
+}
+
+/*
+ * Poll the matching Get*Freq message until the reported frequency reaches the
+ * requested target. Replaces the ReturnHardMinStatus poll used for hard-mins.
+ */
+static bool dcn60_smu_wait_clock_freq(struct clk_mgr_internal *clk_mgr,
+		uint32_t clk, uint16_t target_mhz)
+{
+	const unsigned int max_delay_us = 1000000;
+	unsigned int total_delay_us = 0;
+	bool done = false;
+
+	while (!done && total_delay_us < max_delay_us) {
+		done = khz_to_mhz_ceil(dcn60_smu_get_clock_freq_khz(clk_mgr, clk)) >= target_mhz;
+		if (!done) {
+			udelay(500);
+			total_delay_us += 500;
+		}
+	}
+
+	return done;
+}
+
+/*
+ * Set a display-domain clock (DISPCLK, DPPCLK or DTBCLK) frequency and poll the
+ * matching Get*Freq message until the clock reaches the requested target.
+ * Only these three clocks are handled here.
+ */
+unsigned int dcn60_smu_set_clock_freq(struct clk_mgr_internal *clk_mgr,
+		uint32_t clk, uint16_t freq_mhz)
+{
+	unsigned int actual_clk_khz = 0;
+
+	smu_print("SMU Set clock freq: clk = %d, freq_mhz = %d MHz\n", clk, freq_mhz);
+
+	switch (clk) {
+	case PPCLK_DISPCLK:
+		actual_clk_khz = dcn60_smu_set_dispclk_freq(clk_mgr, freq_mhz);
+		break;
+	case PPCLK_DPPCLK:
+		actual_clk_khz = dcn60_smu_set_dppclk_freq(clk_mgr, freq_mhz);
+		break;
+	case PPCLK_DTBCLK:
+		actual_clk_khz = dcn60_smu_set_dtb_clk(clk_mgr, freq_mhz);
+		break;
+	default:
+		/* set_clock_freq only handles DISPCLK, DPPCLK and DTBCLK */
+		smu_print("SMU Set clock freq: unsupported clk %d\n", clk);
+		return 0;
+	}
+
+	/* confirm the clock reached the requested target */
+	dcn60_smu_wait_clock_freq(clk_mgr, clk, freq_mhz);
+
+	smu_print("SMU Clock set = %d KHz\n", actual_clk_khz);
+
+	return actual_clk_khz;
+}
+
 
 void dcn60_smu_set_stutter_efficiency(struct clk_mgr_internal *clk_mgr, uint8_t base_efficiency, uint8_t low_power_efficiency)
 {
@@ -225,7 +369,7 @@ void dcn60_smu_set_stutter_efficiency(struct clk_mgr_internal *clk_mgr, uint8_t
 	arg.LowPowerEfficiencyPct = low_power_efficiency;
 
 	dcn60_smu_send_msg_with_args(clk_mgr,
-			DALSMC_MSG_SetStutterEfficiency, arg.Args, NULL, NULL);
+			DALSMC_MSG_StutterEfficiency, arg.Args, NULL, NULL);
 }
 
 void dcn60_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, uint32_t freq_mhz)
@@ -247,26 +391,36 @@ void dcn60_smu_set_pme_workaround(struct clk_mgr_internal *clk_mgr)
 	smu_print("SMU Set PME workaround (BacoAudioD3PME)\n");
 
 	dcn60_smu_send_msg_with_args(clk_mgr,
-			DALSMC_MSG_BacoAudioD3PME, args, NULL, NULL);
+			DALSMC_MSG_SacoAudioD3PME, args, NULL, NULL);
 }
 
 void dcn60_smu_indicate_pstate_status(struct clk_mgr_internal *clk_mgr,
 		bool allow_fclk, bool allow_uclk,
 		bool wait_resp, bool drr_enable, bool alt_ch_enable)
 {
-	DALSMC_IndicatePstateStatus_arg_t arg = {};
-
-	smu_print("SMU Indicate pstate status: allow_fclk=%d allow_uclk=%d wait_resp=%d drr_enable=%d alt_ch_enable=%d\n",
-			allow_fclk, allow_uclk, wait_resp, drr_enable, alt_ch_enable);
-
-	arg.AllowFclk = allow_fclk ? 1 : 0;
-	arg.AllowUclk = allow_uclk ? 1 : 0;
-	arg.WaitResp  = wait_resp ? 1 : 0;
-	arg.DrrEnable = drr_enable ? 1 : 0;
-	arg.AltCh = alt_ch_enable ? 1 : 0;
-
-	dcn60_smu_send_msg_with_args(clk_mgr,
-			DALSMC_MSG_IndicatePstateStatus, arg.Args, NULL, NULL);
+	//TODO: Re-enable this function once PMFW has support for this message
+	// Temporary until message is implemented on PMFW side
+	(void)clk_mgr;
+	(void)allow_fclk;
+	(void)allow_uclk;
+	(void)wait_resp;
+	(void)drr_enable;
+	(void)alt_ch_enable;
+
+	//DALSMC_IndicatePstateStatus_arg_t arg = {};
+
+	//smu_print("SMU Indicate pstate status: allow_fclk=%d allow_uclk=%d wait_resp=%d drr_enable=%d alt_ch_enable=%d\n",
+	//		allow_fclk, allow_uclk, wait_resp, drr_enable, alt_ch_enable);
+
+	//arg.AllowFclk = allow_fclk ? 1 : 0;
+	//arg.AllowUclk = allow_uclk ? 1 : 0;
+	//arg.WaitResp  = wait_resp ? 1 : 0;
+	//arg.DrrEnable = drr_enable ? 1 : 0;
+	//arg.AltCh = alt_ch_enable ? 1 : 0;
+
+	// DALSMC_MSG_IndicatePstateStatus not defined in latest dalsmc.h header. Comment out for now.
+	//dcn60_smu_send_msg_with_args(clk_mgr,
+	//		DALSMC_MSG_IndicatePstateStatus, arg.Args, NULL, NULL);
 }
 
 static bool dcn60_smu_transfer_table_smu_2_dram(struct clk_mgr_internal *clk_mgr,
@@ -341,7 +495,7 @@ bool dcn60_smu_update_utm_qos_request(struct clk_mgr_internal *clk_mgr,
 	arg.LsdmaBandwidthKBps   = lsdma_bandwidth_KBps;
 
 	return dcn60_smu_send_msg_with_args(clk_mgr,
-			DALSMC_MSG_UpdateUTMQoSRequest, arg.Args, NULL, NULL);
+			DALSMC_MSG_UpdateUtmQosParams, arg.Args, NULL, NULL);
 }
 
 bool dcn60_smu_get_msg_header_version(struct clk_mgr_internal *clk_mgr,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h
index b1a212246c54..656213ca4d9e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h
@@ -11,7 +11,172 @@
 
 struct clk_mgr_internal;
 
-unsigned int dcn60_smu_set_hard_min_by_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz);
+/** Generic register overlay — four 32-bit C2PMSG argument registers. */
+typedef struct {
+	uint32_t Reg0;
+	uint32_t Reg1;
+	uint32_t Reg2;
+	uint32_t Reg3;
+} DALSMC_args_t;
+
+
+/**
+ * DALSMC_MSG_SetDispclkFreq - Set the DISPCLK frequency (MHz).
+ * DALSMC_MSG_SetDppclkFreq  - Set the DPPCLK frequency (MHz).
+ * DALSMC_MSG_SetDtbClk      - Set the DTBCLK frequency (MHz).
+ *
+ * Directly programs the target display-domain clock instead of requesting an
+ * arbiter hard-min. PMFW returns the actual configured frequency (kHz) in Reg0.
+ * Poll the matching DALSMC_MSG_Get*Freq message to confirm the clock has
+ * reached the requested target.
+ *
+ * Request:  FreqMhz — target frequency in MHz
+ * Response: Reg0    — actual configured frequency in kHz
+ */
+typedef union {
+	struct {
+		uint32_t FreqMhz;
+		uint32_t Reserved[3];
+	};
+	DALSMC_args_t Args;
+} DALSMC_SetClockFreq_arg_t;
+
+/**
+ * DALSMC_MSG_StutterEfficiency - Report DCN stutter efficiency to PMFW.
+ *
+ * Informs PMFW of the current stutter utilisation for base and low-power stutter
+ * modes so PMFW can adjust memory power policy accordingly.
+ *
+ * Base mode    — lower enter+exit latency (PHY LP1, no UCIE LP).
+ * Low-power mode — higher enter+exit latency (PHY LP2, UCIE LP1).
+ *
+ * Request:  BaseEfficiencyPct[7:0]     — stutter efficiency % in base mode
+ *           LowPowerEfficiencyPct[15:8] — stutter efficiency % in low-power mode
+ * Response: (none beyond result code)
+ */
+typedef union {
+	struct {
+		uint32_t BaseEfficiencyPct     : 8;
+		uint32_t LowPowerEfficiencyPct : 8;
+		uint32_t Reserved              : 16;
+		uint32_t Reserved1[3];
+	};
+	DALSMC_args_t Args;
+} DALSMC_SetStutterEfficiency_arg_t;
+
+/**
+ * DALSMC_MSG_SetMinDeepSleepDcfclk - Set the minimum DCFCLK frequency in deep sleep.
+ *
+ * Request:  MinDcfclkMhz — minimum DCFCLK frequency in MHz during deep sleep
+ * Response: (none beyond result code)
+ */
+typedef union {
+	struct {
+		uint32_t MinDcfclkMhz;
+		uint32_t Reserved[3];
+	};
+	DALSMC_args_t Args;
+} DALSMC_SetMinDeepSleepDcfclk_arg_t;
+
+/**
+ * DALSMC_MSG_IndicatePstateStatus - Indicate to PMFW various DMU behaviors required
+ * to support UCLK P-state, for example whether or not DMU needs to modulate refresh
+ * rate to perform UCLK switches.
+ *
+ * Request:  WaitResp[0]   — DAL requires a synchronous response before proceeding
+ *           DrrEnable[1]  — DRR (dynamic refresh rate modulation) is active
+ *           AltCh[2]      — alternate-channel mode is active
+ *           AllowUclk[16] — DCN can tolerate UCLK P-state switches
+ *           AllowFclk[17] — DCN can tolerate FCLK P-state switches
+ * Response: (none beyond result code)
+ */
+typedef union {
+	struct {
+		uint32_t WaitResp  : 1;
+		uint32_t DrrEnable : 1;
+		uint32_t AltCh     : 1;
+		uint32_t Reserved  : 13;
+		uint32_t AllowUclk : 1;
+		uint32_t AllowFclk : 1;
+		uint32_t Reserved1 : 14;
+		uint32_t Reserved2[3];
+	};
+	DALSMC_args_t Args;
+} DALSMC_IndicatePstateStatus_arg_t;
+
+/**
+ * DALSMC_MSG_TransferTableSmu2Dram - Transfer a PMFW table into DRAM.
+ * DALSMC_MSG_TransferTableDram2Smu - Transfer a DRAM buffer into PMFW.
+ *
+ * Both directions use the same argument layout. The DRAM address must be set
+ * beforehand (AddrLow / AddrHigh are the GPU MC address bits [31:0] / [63:32]).
+ *
+ * Smu2Dram supported tables: TABLE_DAL_INIT (DPM clocks + UTM QoS + memory config)
+ * Dram2Smu supported tables: TABLE_SOC_UTM  (debug override of UTM QoS parameters)
+ *
+ * Request:  TableId  — table identifier (TABLE_* defines below)
+ *           AddrLow  — GPU MC address bits [31:0]  of destination/source buffer
+ *           AddrHigh — GPU MC address bits [63:32] of destination/source buffer
+ * Response: (none beyond result code)
+ */
+typedef union {
+	struct {
+		uint32_t TableId;
+		uint32_t AddrLow;
+		uint32_t AddrHigh;
+		uint32_t Reserved;
+	};
+	DALSMC_args_t Args;
+} DALSMC_TransferTable_arg_t;
+
+/**
+ * DALSMC_MSG_UpdateUTMQoSRequest - Update the active UTM QoS bandwidth/latency request.
+ *
+ * Passes the current display bandwidth and latency requirements to PMFW so it
+ * can select the appropriate SoC operating point (UCLK/FCLK level) from the
+ * UTM table. Called whenever the display configuration changes.
+ *
+ * The QoS requirement must take effect before PMFW sends its response.
+ *
+ * Request:  LatencySopIndex      — index into the UTM SOP table that satisfies latency
+ *           NominalBandwidthKBps — required nominal (average) bandwidth in KB/s
+ *           UrgentBandwidthKBps  — required urgent bandwidth in KB/s
+ *           LsdmaBandwidthKBps   — required LSDMA bandwidth in KB/s
+ * Response: (none beyond result code)
+ */
+typedef union {
+	struct {
+		uint32_t LatencySopIndex;
+		uint32_t NominalBandwidthKBps;
+		uint32_t UrgentBandwidthKBps;
+		uint32_t LsdmaBandwidthKBps;
+	};
+	DALSMC_args_t Args;
+} DALSMC_UpdateUTMQoSRequest_arg_t;
+
+/**
+ * DALSMC_MSG_SetDisplayIdleOptimizations - Notify PMFW of DCN idle-state conditions.
+ *
+ * Indicates which display-side power optimizations are currently safe to apply.
+ * PMFW uses these flags to gate deeper SoC power states such as S0i2.
+ *
+ * Request:  DfRequestDisabled[0] — DF (data fabric) requests from DCN are disabled
+ *           PhyRefClkOff[1]      — PHY reference clock has been gated off
+ *           S0i2Rdy[2]           — DCN is ready for the system to enter S0i2
+ * Response: (none beyond result code)
+ */
+typedef union {
+	struct {
+		uint32_t DfRequestDisabled : 1;
+		uint32_t PhyRefClkOff      : 1;
+		uint32_t S0i2Rdy           : 1;
+		uint32_t Reserved          : 29;
+		uint32_t Reserved1[3];
+	};
+	DALSMC_args_t Args;
+} DALSMC_SetDisplayIdleOptimizations_arg_t;
+unsigned int dcn60_smu_set_hard_min_dcfclk_by_freq(struct clk_mgr_internal *clk_mgr, uint16_t freq_mhz);
+unsigned int dcn60_smu_set_clock_freq(struct clk_mgr_internal *clk_mgr, uint32_t clk, uint16_t freq_mhz);
 void dcn60_smu_set_stutter_efficiency(struct clk_mgr_internal *clk_mgr,
 		uint8_t base_efficiency, uint8_t low_power_efficiency);
 void dcn60_smu_set_min_deep_sleep_dcfclk(struct clk_mgr_internal *clk_mgr, uint32_t freq_mhz);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h
new file mode 100644
index 000000000000..3e101fa87cfd
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_driver_if.h
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: MIT
+//
+// Copyright 2026 Advanced Micro Devices, Inc.
+//
+// This is a stripped-down version of the smu13_driver_if.h file for the relevant DAL interfaces.
+
+#define DCN6_DRIVER_IF_VERSION  0x1
+
+//Only Clks that have DPM descriptors are listed here
+// This should be the same order as DPM_e
+typedef enum {
+  PPCLK_GFXCLK = 0,
+  PPCLK_BTNCLK = 1,
+  PPCLK_LCLK = 2,
+  PPCLK_UCLK = 3,
+  PPCLK_FCLK = 4,
+  PPCLK_G7FCLK = 5,
+  PPCLK_SOCCLK = 6,
+  PPCLK_ACLK = 7,
+  PPCLK_DCFCLK = 8,
+  PPCLK_VPECLK = 9,
+  PPCLK_DISPCLK = 10,
+  PPCLK_DPPCLK = 11,
+  PPCLK_DPREFCLK = 12,
+  PPCLK_CFPUCLK = 13,
+  PPCLK_LOGANCLK = 14,
+  PPCLK_MSPCLK = 15,
+  PPCLK_MOVADCLK = 16,
+  PPCLK_DTBCLK = 17,
+  PPCLK_DCLK_0 = 18,
+  PPCLK_VCLK_0 = 19,
+  PPCLK_COUNT = 20,
+} PPCLK_e;
+
+typedef struct {
+  uint8_t  WmSetting;
+  uint8_t  Flags;
+  uint8_t  Padding[2];
+
+} WatermarkRowGeneric_t;
+
+#define NUM_WM_RANGES 4
+
+typedef enum {
+  WATERMARKS_CLOCK_RANGE = 0,
+  WATERMARKS_DUMMY_PSTATE,
+  WATERMARKS_MALL,
+  WATERMARKS_COUNT,
+} WATERMARKS_FLAGS_e;
+
+typedef struct {
+  // Watermarks
+  WatermarkRowGeneric_t WatermarkRow[NUM_WM_RANGES];
+} Watermarks_t;
+
+typedef struct {
+	Watermarks_t Watermarks;
+  uint32_t  Spare[16];
+
+  uint32_t     MmHubPadding[8]; // SMU internal use
+} WatermarksExternal_t;
+
+// Table types
+#define TABLE_PMFW_PPTABLE            0
+#define TABLE_COMBO_PPTABLE           1
+#define TABLE_WATERMARKS              2
+#define TABLE_AVFS_PSM_DEBUG          3
+#define TABLE_PMSTATUSLOG             4
+#define TABLE_SMU_METRICS             5
+#define TABLE_DRIVER_SMU_CONFIG       6
+#define TABLE_ACTIVITY_MONITOR_COEFF  7
+#define TABLE_OVERDRIVE               8
+#define TABLE_I2C_COMMANDS            9
+#define TABLE_DRIVER_INFO             10
+#define TABLE_ECCINFO                 11
+#define TABLE_COUNT                   12
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 51596f445a09..f20a7b99d20c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -76,7 +76,8 @@ void dcn401_initialize_min_clocks(struct dc *dc)
 		if (dc->clk_mgr->funcs->get_dispclk_from_dentist) {
 			clocks->dispclk_khz = dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
 		} else {
-			clocks->dispclk_khz = dc->clk_mgr->boot_snapshot.dispclk * 1000;
+			// Boot snapshot is already in Khz
+			clocks->dispclk_khz = dc->clk_mgr->boot_snapshot.dispclk;
 		}
 	}
 	clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
-- 
2.43.0

