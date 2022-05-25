Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8940FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C23AE10F94F;
	Wed, 25 May 2022 16:20:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E8FA10E7E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGCHpzKK5uzHCTRupazH0vS5djCUEQckNc4I6q/6qULBUAzdebMlkyTKjuluz0FH4hWmo1OYQ+LhHrO8+455Tq9c+zsyqWXEvDXd50CGChsp6hVjzYNS1u7kZIJxt2S9V9O6UY/CL7BH13SHC3S6xyr5mnPOy9ecYEZQH6dVIqqUg18HCeMdZcuALya2Tth6ht94fk3BFNJTiENm51CUlL/l2VrzYHfL0Sk1jslpbBJNVmnX/J7G8d7EIJa93P+Is8ndd8LOw2JRyyOd0ODVKQc9WCVZ1ZSLvWmfmTGVGQ2SdfJPffHC96jRHtBInn827ebmkp/2m7W2V2P3rArgew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhrY6Lhi5FPkqU+w239G7Pdr2LoQWixQExM24fq/I28=;
 b=GLC/JsrA/WOI0tWLC8weA7XyymQ9EnuunXJ2rU2FQZR1I5ScUi0WSAxED0ZxQgvrovjsewW+ZTbMnGTeibyBGLBd94kwcCai+uh+9dsyy/fTz5fnnHn20ISky8QvM7csIY2oZ4tIVfCxobtTDenWEvuodmsgbdYAO1l7/u5qhsEJpm9CiZ5kZFQyz6Tvdh2x9fdMNTbu/6WSIuB4wYyfNoGys/ETGgWOVwIs7a3W5xjXV52cv6CYItQYJYp9b+or7wIEP6AklFSzR5eLuhF0XiWPLaoNGii/CNBparK8DM1gWBroiIictHEN+Yk00/oZrHj7KFShVfQfnqAPi+Dr9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhrY6Lhi5FPkqU+w239G7Pdr2LoQWixQExM24fq/I28=;
 b=uY5ATbztv3f9DWNTWUpNHiP/LTyyNGa0X6YYONFThKRudlByZQpQebInrQuSjPZ7J9uOC3eHyGLSEAJLX68bsBKELxxYGyeafiDvB26OlApCAhkEXW3/S63OAm/rkjOo54c65N65HRJBTel3TkoJ2yJEb4LjtPzZTo1vHZw4Fdk=
Received: from DM5PR05CA0005.namprd05.prod.outlook.com (2603:10b6:3:d4::15) by
 DM5PR12MB1532.namprd12.prod.outlook.com (2603:10b6:4:6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.19; Wed, 25 May 2022 16:20:22 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::9b) by DM5PR05CA0005.outlook.office365.com
 (2603:10b6:3:d4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Wed, 25 May 2022 16:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 36/43] drm/amd/display: cleaning up smu_if to add future
 flexibility
Date: Wed, 25 May 2022 12:19:34 -0400
Message-ID: <20220525161941.2544055-36-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 589919ce-4c48-48b2-3b8a-08da3e6a77e4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1532:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15325F6337D755B49318F6C1F7D69@DM5PR12MB1532.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlcH3zvqlJDY9UGTv6I0UpYbPEFdAyVQnsc4wxXARrvB7y7Tg7hordQgAXqIQWVRO3bueYKDN0pjSpIXp68EE8NAYqI6sjO7uFyNW4HX5eBCOtmOZz2Ryaea3SB0zRpwZAeXv3cIPxpSEPraikH2R9ufqTAJMyPBYdA5WP3p96Mj6EjDAZLWBLsF2f4VqpAoZUKB2kjF6oU66YOvSmaq3GUR9tUPlgfFoTUBygwKn6wHnwJRL5wY6glcYOf+0Z2ywAUpbC/BDGjtoGN3tQBXQ3Hul9fTwmqXEO4VD91OxPdwXh4s9FNcwSK/P4ID1X7Bj+/g67pbg3hYNRvafG4yLT8NdVhCAUQqIvc2SLHz/y6msneHOYb1Gx5B56ik1nV+vtJMCdvFkDMuLchDIXdqYNGMUx+YLyWUqh6V9eIS5YuCvsYCitVaNwHC11CvoVP8EtTlHoW9kU86qVfuZztuqy1N1visMz2eJjVwLt9OPmIJljPvzDliALzqB8w22B5IPpEf/XzSkeiS+5u/amwIheielQyTE5ZaOzqa+NBn0xawGcjcKND399jlFHfyQGSd2nk0+bfBAMUX4ly624RgHkjsnzCFcQNtd2AhdmokEQSGZmptk4zcbsgy8XeAwUGyFeuqrwTc66c9oiZRIiOZf7rPUXihDt+SEXVlvSbh/9ZFwmAIL/DaLVczK+4po91+SCHyP13udbpPBgNtCX42ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(70586007)(8676002)(70206006)(4326008)(186003)(16526019)(36860700001)(81166007)(2906002)(82310400005)(47076005)(5660300002)(8936002)(356005)(54906003)(6916009)(2616005)(1076003)(6666004)(26005)(7696005)(316002)(426003)(508600001)(40460700003)(336012)(36756003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:22.4154 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 589919ce-4c48-48b2-3b8a-08da3e6a77e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1532
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Martin Leung <Martin.Leung@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <Martin.Leung@amd.com>

This commit cleans up code that uses old variables and adds some SMU
interfaces for future flexibility.

Signed-off-by: Martin Leung <Martin.Leung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  | 19 +++---
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  |  7 +--
 .../dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h  | 63 +++++++++++++++++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  5 +-
 4 files changed, 78 insertions(+), 16 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
index 35e8afe6db93..95ab268e9179 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c
@@ -27,6 +27,8 @@
 
 #include "clk_mgr_internal.h"
 #include "reg_helper.h"
+#include "dalsmc.h"
+#include "smu13_driver_if.h"
 
 #define mmDAL_MSG_REG  0x1628A
 #define mmDAL_ARG_REG  0x16273
@@ -38,8 +40,6 @@
 	mm ## reg_name
 
 #include "logger_types.h"
-#include "dalsmc.h"
-#include "smu13_driver_if.h"
 
 #define smu_print(str, ...) {DC_LOG_SMU(str, ##__VA_ARGS__); }
 
@@ -100,14 +100,6 @@ void dcn32_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool e
 			DALSMC_MSG_SetFclkSwitchAllow, enable ? FCLK_PSTATE_SUPPORTED : FCLK_PSTATE_NOTSUPPORTED, NULL);
 }
 
-void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr)
-{
-       smu_print("SMU Transfer WM table DRAM 2 SMU\n");
-
-       dcn32_smu_send_msg_with_param(clk_mgr,
-                       DALSMC_MSG_TransferTableDram2Smu, TABLE_WATERMARKS, NULL);
-}
-
 void dcn32_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsigned int num_ways)
 {
 	smu_print("Numways for SubVP : %d\n", num_ways);
@@ -115,3 +107,10 @@ void dcn32_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsig
 	dcn32_smu_send_msg_with_param(clk_mgr, DALSMC_MSG_SetCabForUclkPstate, num_ways, NULL);
 }
 
+void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr)
+{
+	smu_print("SMU Transfer WM table DRAM 2 SMU\n");
+
+	dcn32_smu_send_msg_with_param(clk_mgr,
+			DALSMC_MSG_TransferTableDram2Smu, TABLE_WATERMARKS, NULL);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
index 11b25de1527f..ee6259108add 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h
@@ -38,12 +38,9 @@
 #define DALSMC_Result_OK				0x1
 
 void
-dcn32_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr,
-				   bool enable);
-
+dcn32_smu_send_fclk_pstate_message(struct clk_mgr_internal *clk_mgr, bool enable);
 void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
-
 void dcn32_smu_send_cab_for_uclk_message(struct clk_mgr_internal *clk_mgr, unsigned int num_ways);
-
+void dcn32_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
 
 #endif /* __DCN32_CLK_MGR_SMU_MSG_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
new file mode 100644
index 000000000000..d30fbbdd1792
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_smu13_driver_if.h
@@ -0,0 +1,63 @@
+// This is a stripped-down version of the smu13_driver_if.h file for the relevant DAL interfaces.
+
+#define SMU13_DRIVER_IF_VERSION  0x18
+
+//Only Clks that have DPM descriptors are listed here
+typedef enum {
+	PPCLK_GFXCLK = 0,
+	PPCLK_SOCCLK,
+	PPCLK_UCLK,
+	PPCLK_FCLK,
+	PPCLK_DCLK_0,
+	PPCLK_VCLK_0,
+	PPCLK_DCLK_1,
+	PPCLK_VCLK_1,
+	PPCLK_DISPCLK,
+	PPCLK_DPPCLK,
+	PPCLK_DPREFCLK,
+	PPCLK_DCFCLK,
+	PPCLK_DTBCLK,
+	PPCLK_COUNT,
+} PPCLK_e;
+
+typedef struct {
+	uint8_t  WmSetting;
+	uint8_t  Flags;
+	uint8_t  Padding[2];
+
+} WatermarkRowGeneric_t;
+
+#define NUM_WM_RANGES 4
+
+typedef enum {
+	WATERMARKS_CLOCK_RANGE = 0,
+	WATERMARKS_DUMMY_PSTATE,
+	WATERMARKS_MALL,
+	WATERMARKS_COUNT,
+} WATERMARKS_FLAGS_e;
+
+typedef struct {
+	// Watermarks
+	WatermarkRowGeneric_t WatermarkRow[NUM_WM_RANGES];
+} Watermarks_t;
+
+typedef struct {
+	Watermarks_t Watermarks;
+	uint32_t  Spare[16];
+
+	uint32_t     MmHubPadding[8]; // SMU internal use
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
+#define TABLE_COUNT                   11
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index d298f6016e0b..a76da0131add 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -39,7 +39,10 @@
 
 const struct dmub_srv_dcn32_regs dmub_srv_dcn32_regs = {
 #define DMUB_SR(reg) REG_OFFSET_EXP(reg),
-		{ DMUB_DCN32_REGS() },
+	{
+		DMUB_DCN32_REGS()
+		DMCUB_INTERNAL_REGS()
+	},
 #undef DMUB_SR
 
 #define DMUB_SF(reg, field) FD_MASK(reg, field),
-- 
2.35.3

