Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF4ACC44515
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 19:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BA4010E10A;
	Thu, 16 Jul 2026 19:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L37Sdlnv";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012046.outbound.protection.outlook.com
 [40.107.200.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2275910E3BA
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 19:07:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaR2TL3wutH+y5JpX28L4+omASs66D4ji2/fG0Y5kTN1o8jB50fiskRsUdnx/UzCoL1kD3t+r8yX8pxpT2Fk6YMliI2XqwCQZosj2c53NoqAlinVPop9e5ptvuQG1Ae1FuOSnBLRJI1qIIQxxv6CNGyYIqiZZw4rCDK76raBjO+Y7r4SHNBll/f8w/D+eoWMTj6uYVTdkYzps5uOdE0MHf7oHPScdWF1An9OWARqioA8MMJ+uJ0kANq8LK0zRc6kc9rut0j9a+GPaCq7RsMbHnzkGgHINOKW5NZ/TCRcQ72zcUksqaX0nvR7CLGd+96J841oNNCZeIEGxU0giTHzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkeaeFgEDj9lUT8TuYC9rhqm1Gbn3hztKj3zitn7BF8=;
 b=IQAP854DrqKlhZiZ9v3Q/a8LuYo1WkVhaV02OjSWdCzNDcu4sThV751ezmpKur6HbII0QcpPuZize9kpUihg5WnBLWkjI+4oh0+jDNxhyku+sbbMBmVbN1Co6eoGQ2swIiOjtaWMks5C3NbJ3J18bS6mWE8eHexFn9dZ+8pGV68GCbwiSfAtHYlm1HC45nTZ4V04N+CE1H9B9WsimnKHm18tYaTqWfrFgWYoGTKhi+iwoi7u7BvckIx0faZEdM9KU/asF/j7q5tLVV0qr4yOJLE/Va7I3tWAvSLKa170MPmHubmLg5XdQR1jYCnmBtYPhrQe5IjYiGfgZiD9cOqQYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkeaeFgEDj9lUT8TuYC9rhqm1Gbn3hztKj3zitn7BF8=;
 b=L37Sdlnv3gnp+L30d7i0MmwEOlLkLw577dDCL8dRM3Knuj0cfer36xZhqLFhGUTfSNdYQcwYk72TIwzjuDrkQCDzFh+f0OEAAkZR1WtuWe4SrRzIwo3S1v5g00+BjrSMjU+anHaz3bBCk0Au7vZxyszVfLVvRXgWJp12lJ6uaQQ=
Received: from MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8) by
 IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.12; Thu, 16 Jul 2026 19:06:58 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::30) by MN2PR01CA0039.outlook.office365.com
 (2603:10b6:208:23f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 19:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 19:06:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 14:06:58 -0500
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 14:06:57 -0500
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Ray Wu <Ray.Wu@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Chuanyu Tseng
 <Chuanyu.Tseng@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 2/2] drm/amd/display: add dcn42b specific SMU clock table read
Date: Thu, 16 Jul 2026 15:07:36 -0400
Message-ID: <20260716190844.368565-3-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716190844.368565-1-Matthew.Stewart2@amd.com>
References: <20260716190844.368565-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 781b5837-c111-425e-2651-08dee36d692e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +Wt+fk1IHAay48xzYZW44rTo34WqqoyinF1zK9ihA2slcVX68DmJZabCmqV8V75DKTkLDNN2HbDvRKLsdyRwvYZGA9DTmwI/7XJxymgFORWACO9A0VxzjThx21Uof+Qu1SLKnBXN0ARI7ACuU8W6CJhdDXgFUM91Ov4bKVeKCpgbpkBeN0WI4YEDSn1V9IHgIZ9Su0Ke0uTYV3prrd/zZUWj9v9apWEJxB5uugsDrihSZn/9qB36udwdtQV+C25iGYkeHc5QsJVd7PC6PZ2CPD3CDNrBjigLrcu53hrWePc3epZnRmM3Ntl6S7e+BU+Jn6vK2DwT1FxRs4wYj3c7/zU/HJ7EHayQ/IoFSr5ID9JSrSnHQoh2y/FZH9QJXJU6lJfoG8gd8kAMta+LfWDiSdJoILBClqjaP+3YgzrQKXYT59ialFxJCsbfQyJeJhi4oboTccTSdqmut4cpZ7PhVtKg5U5bu8FWwX3HE5/VWusvKmYPsaknPlOt7DDx/bLIf4CNMpcvnIgtY1Ubmp1fkctj+Sq5vlOmzTK2nOBRmRa3ptUSIL354gV/ILe3Bf8TsfHfH6zgczwGu/E2eomHswK4cPrRfh8VBG4HBRoajwoijG1rH3i9eP+QeYZaUYgTRp6s6tlW/lrK/bL/Ji6+1T0iy6P8CVAz8wpoRffwyosrB3XG0VU1WU+15beL7VfwaEr7smUZOHEzE0sQ/qVOOQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YKk9Q6yJP1UX6NyVM9b5ggVk19dOJ4aza8/7SpcSJ51ZTn3C+alMUoukwYiILguVWuF4JbwoZbbGpTb8MQ1aP/WFHIVIIjcwRKRSMHVAHo3foPpouKSL6hqdI+uM++gh6tRpAmhuAw6A4INgHyJP7/LqAC3QLgRrXZJ1ERKweAq23ck10YAvB4rGAdUEEXRuxEiTw/8AdFzNMTxBG166CEp6PWgt5MEQjrG2hbKxpCgmLPq55BQfO6wXdk0gC070Npe0ilN1abCtoSrbNT5T0kYTS01KrQXKm2AThDEQTgEGYeAFbQusrw5yloxM0p6ibDBAK1Lmb6XrVqPXB5uly+WZbK4zOEA45bpYu2ithz3baVuX2jXn0U4o2OCn85Goabb0klxhdOONBd22u2NIQii995z/7r5MuigP5Pp2kXEpBRFTzMk90pi2LzMbkkgN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 19:06:58.8319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781b5837-c111-425e-2651-08dee36d692e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
On DCN42B the SMU reports its DpmClocks table in a different
layout than DCN42, with extra clock domains. The clk_mgr was
parsing it with the DCN42 layout.
[How]
Add a DCN42B DpmClocks struct and a dcn42b_get_smu_clocks() that
allocates and parses the DCN42B layout, reusing the shared dcn42
helpers so DCN42 is untouched. Populate DCF, SOC, DISP, DPP and
FCLK levels and the memory pstate table.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        | 183 ++++++++++++++++--
 1 file changed, 172 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
index 4be5abdc60ea..2c2ba09221e4 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c
@@ -221,10 +221,6 @@ static void init_clk_states(struct clk_mgr *clk_mgr)
 	clk_mgr->clks.zstate_support = DCN_ZSTATE_SUPPORT_UNKNOWN;
 }
 
-/* dcn42b_get_dpm_table_from_smu removed: reuse dcn42_get_dpm_table_from_smu.
- * Function is identical - only uses SMU calls, no hardware register differences.
- */
-
 void dcn42b_init_clocks(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr_base);
@@ -412,6 +408,176 @@ static struct clk_mgr_funcs dcn42b_funcs = {
 	.is_smu_present = dcn42_is_smu_present,
 };
 
+typedef struct {
+	uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
+	uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
+	uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
+	uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
+	uint32_t VPEClocks[NUM_VPE_DPM_LEVELS];
+	uint32_t FclkClocks_Freq[NUM_FCLK_DPM_LEVELS];
+	uint32_t FclkClocks_Voltage[NUM_FCLK_DPM_LEVELS];
+	uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
+	MemPstateTable_t MemPstateTable[NUM_MEM_PSTATE_LEVELS];
+
+	uint8_t  NumDcfClkLevelsEnabled;
+	uint8_t  NumDispClkLevelsEnabled; //Applies to both Dispclk and Dppclk
+	uint8_t  NumSocClkLevelsEnabled;
+	uint8_t  VpeClkLevelsEnabled;
+
+	uint8_t  NumMemPstatesEnabled;
+	uint8_t  NumFclkLevelsEnabled;
+	uint8_t  Spare1;
+	uint8_t  Spare2;
+
+	uint8_t  Spare3;
+	uint8_t  Spare4;
+	uint8_t  Spare5[2];
+
+	uint32_t MinGfxClk;
+	uint32_t MaxGfxClk;
+
+	uint32_t Spare6[8];
+	uint32_t Spare7[8];
+	uint32_t Spare8[8];
+	uint32_t Spare9[8];
+} DpmClocks_t_dcn42b;
+struct dcn42b_smu_dpm_clks {
+	DpmClocks_t_dcn42b *dpm_clks;
+	union large_integer mc_address;
+};
+
+static void dcn42b_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
+		struct dcn42b_smu_dpm_clks *smu_dpm_clks)
+{
+	DpmClocks_t_dcn42b *table = smu_dpm_clks->dpm_clks;
+
+	if (!clk_mgr->smu_ver)
+		return;
+
+	if (!table || smu_dpm_clks->mc_address.quad_part == 0)
+		return;
+
+	memset(table, 0, sizeof(*table));
+
+	dcn42_smu_set_dram_addr_high(clk_mgr,
+			smu_dpm_clks->mc_address.high_part);
+	dcn42_smu_set_dram_addr_low(clk_mgr,
+			smu_dpm_clks->mc_address.low_part);
+	dcn42_smu_transfer_dpm_table_smu_2_dram(clk_mgr);
+}
+
+static void dcn42b_get_smu_clocks(struct clk_mgr_internal *clk_mgr_int)
+{
+	struct clk_mgr *clk_mgr_base = &clk_mgr_int->base;
+	struct dcn42b_smu_dpm_clks smu_dpm_clks = { 0 };
+
+	DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
+	(void)dc_logger;
+
+	smu_dpm_clks.dpm_clks = (DpmClocks_t_dcn42b *)dm_helpers_allocate_gpu_mem(
+				clk_mgr_base->ctx,
+				DC_MEM_ALLOC_TYPE_GART,
+				sizeof(DpmClocks_t_dcn42b),
+				&smu_dpm_clks.mc_address.quad_part);
+
+	ASSERT(smu_dpm_clks.dpm_clks);
+	if (clk_mgr_base->ctx->dc->debug.pstate_enabled && smu_dpm_clks.mc_address.quad_part != 0) {
+		int i;
+		DpmClocks_t_dcn42b *dpm_clks = smu_dpm_clks.dpm_clks;
+
+		dcn42b_get_dpm_table_from_smu(clk_mgr_int, &smu_dpm_clks);
+		DC_LOG_SMU("NumDcfClkLevelsEnabled: %d\n"
+				   "NumDispClkLevelsEnabled: %d\n"
+				   "NumSocClkLevelsEnabled: %d\n"
+				   "VpeClkLevelsEnabled: %d\n"
+				   "FClkLevelsEnabled: %d\n"
+				   "NumMemPstatesEnabled: %d\n"
+				   "MinGfxClk: %d\n"
+				   "MaxGfxClk: %d\n",
+				   dpm_clks->NumDcfClkLevelsEnabled,
+				   dpm_clks->NumDispClkLevelsEnabled,
+				   dpm_clks->NumSocClkLevelsEnabled,
+				   dpm_clks->VpeClkLevelsEnabled,
+				   dpm_clks->NumFclkLevelsEnabled,
+				   dpm_clks->NumMemPstatesEnabled,
+				   dpm_clks->MinGfxClk,
+				   dpm_clks->MaxGfxClk);
+
+		for (i = 0; i < NUM_DCFCLK_DPM_LEVELS; i++)
+			DC_LOG_SMU("dpm_clks->DcfClocks[%d] = %d\n", i, dpm_clks->DcfClocks[i]);
+		for (i = 0; i < NUM_DISPCLK_DPM_LEVELS; i++)
+			DC_LOG_SMU("dpm_clks->DispClocks[%d] = %d\n", i, dpm_clks->DispClocks[i]);
+		for (i = 0; i < NUM_SOCCLK_DPM_LEVELS; i++)
+			DC_LOG_SMU("dpm_clks->SocClocks[%d] = %d\n", i, dpm_clks->SocClocks[i]);
+		for (i = 0; i < NUM_FCLK_DPM_LEVELS; i++) {
+			DC_LOG_SMU("dpm_clks->FclkClocks_Freq[%d] = %d\n", i, dpm_clks->FclkClocks_Freq[i]);
+			DC_LOG_SMU("dpm_clks->FclkClocks_Voltage[%d] = %d\n", i, dpm_clks->FclkClocks_Voltage[i]);
+		}
+		for (i = 0; i < NUM_SOCCLK_DPM_LEVELS; i++)
+			DC_LOG_SMU("dpm_clks->SocVoltage[%d] = %d\n", i, dpm_clks->SocVoltage[i]);
+
+		for (i = 0; i < NUM_MEM_PSTATE_LEVELS; i++)
+			DC_LOG_SMU("dpm_clks.MemPstateTable[%d].UClk = %d MemClk = %d Voltage = %d\n",
+					i, dpm_clks->MemPstateTable[i].UClk, dpm_clks->MemPstateTable[i].MemClk, dpm_clks->MemPstateTable[i].Voltage);
+
+		if (clk_mgr_base->ctx->dc_bios->integrated_info && clk_mgr_base->ctx->dc->config.use_default_clock_table == false) {
+			/* DCFCLK */
+			dcn42_init_single_clock(&clk_mgr_base->bw_params->clk_table.entries[0].dcfclk_mhz,
+					dpm_clks->DcfClocks,
+					dpm_clks->NumDcfClkLevelsEnabled);
+			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels = dpm_clks->NumDcfClkLevelsEnabled;
+
+			/* SOCCLK */
+			dcn42_init_single_clock(&clk_mgr_base->bw_params->clk_table.entries[0].socclk_mhz,
+					dpm_clks->SocClocks,
+					dpm_clks->NumSocClkLevelsEnabled);
+			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_socclk_levels = dpm_clks->NumSocClkLevelsEnabled;
+
+			/* DISPCLK */
+			dcn42_init_single_clock(&clk_mgr_base->bw_params->clk_table.entries[0].dispclk_mhz,
+					dpm_clks->DispClocks,
+					dpm_clks->NumDispClkLevelsEnabled);
+			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dispclk_levels = dpm_clks->NumDispClkLevelsEnabled;
+
+			/* DPPCLK */
+			dcn42_init_single_clock(&clk_mgr_base->bw_params->clk_table.entries[0].dppclk_mhz,
+					dpm_clks->DppClocks,
+					dpm_clks->NumDispClkLevelsEnabled);
+			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dppclk_levels = dpm_clks->NumDispClkLevelsEnabled;
+
+			/* FCLK */
+			dcn42_init_single_clock(&clk_mgr_base->bw_params->clk_table.entries[0].fclk_mhz,
+					dpm_clks->FclkClocks_Freq,
+					NUM_FCLK_DPM_LEVELS);
+			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_fclk_levels = dpm_clks->NumFclkLevelsEnabled;
+			clk_mgr_base->bw_params->clk_table.num_entries = dpm_clks->NumFclkLevelsEnabled;
+
+			/* Memory Pstate table is in reverse order for dcn42. Proper way to map this is for pmfw to provide an fclk indexed uclk key since we consume fclk matched pairs.*/
+			ASSERT(dpm_clks->NumMemPstatesEnabled <= NUM_MEM_PSTATE_LEVELS);
+			if (dpm_clks->NumMemPstatesEnabled > NUM_MEM_PSTATE_LEVELS)
+				dpm_clks->NumMemPstatesEnabled = NUM_MEM_PSTATE_LEVELS;
+			for (i = 0; i < dpm_clks->NumDcfClkLevelsEnabled; i++) {
+				if (i < dpm_clks->NumMemPstatesEnabled) {
+					clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].memclk_mhz = dpm_clks->MemPstateTable[i].MemClk;
+					clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].wck_ratio = dcn42_convert_wck_ratio(dpm_clks->MemPstateTable[i].WckRatio);
+				} else {
+					clk_mgr_base->bw_params->clk_table.entries[i].memclk_mhz = dpm_clks->MemPstateTable[0].MemClk;
+					clk_mgr_base->bw_params->clk_table.entries[i].wck_ratio = dcn42_convert_wck_ratio(dpm_clks->MemPstateTable[0].WckRatio);
+				}
+			}
+
+			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels = dpm_clks->NumDcfClkLevelsEnabled;
+
+			/* DTBCLK tied off in DCN42B */
+			clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz = 0;
+			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels = 0;
+		}
+	}
+	if (smu_dpm_clks.dpm_clks && smu_dpm_clks.mc_address.quad_part != 0)
+		dm_helpers_free_gpu_mem(clk_mgr_base->ctx, DC_MEM_ALLOC_TYPE_GART,
+				smu_dpm_clks.dpm_clks);
+}
+
 void dcn42b_clk_mgr_construct(
 		struct dc_context *ctx,
 		struct clk_mgr_dcn42 *clk_mgr,
@@ -473,11 +639,6 @@ void dcn42b_clk_mgr_construct(
 	dcn42b_read_ss_info_from_lut(&clk_mgr->base);
 
 	clk_mgr->base.base.bw_params = &dcn42b_bw_params;
-	if (clk_mgr->base.smu_present) {
-		dcn42_get_smu_clocks(&clk_mgr->base);
-		//overwrite values from dcn42_get_smu_clocks since dtbclk is tied off in DCN42B
-		clk_mgr->base.base.bw_params->clk_table.entries[0].dtbclk_mhz = 0;
-		clk_mgr->base.base.bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels = 0;
-		clk_mgr->base.base.clks.ref_dtbclk_khz = 0;
-	}
+	if (clk_mgr->base.smu_present)
+		dcn42b_get_smu_clocks(&clk_mgr->base);
 }
-- 
2.55.0

