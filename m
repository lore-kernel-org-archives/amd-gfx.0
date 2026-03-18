Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACF6FEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C145010E5E8;
	Wed, 18 Mar 2026 01:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vnlFt02v";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE05610E5EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ay9aFmTPEBERweoP/akTzY3p2Pdhk3QLY3/YcKr+IBj94NjP6f7dDQ3pNVv5IliqTUt4U0cqmUt6oy0vLhRpsHMoJeJvHlgIZr7x1wXf7H5vaqCboGLviI2nmh2h6Yko1nZjnhqUo5JDsrj+ps5zUGhpT11oJV7D3olyJShp/7TUv2+DVXGB3a5XImBXh0ENO+QJ1c1zK+owLplNPmq986sHYCkQ3WcN62Aq+QFIbc1GwWJsx8k2qbnh1WXYnuScmoEPkuO32ejluddjDEJ1yJQ07zQndjas1XcmK9kNY7E/R1e6FpmNULZtPQQMZeLAJt35eHdn3jBOEqLQVM/Iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfkFNL8XcpUTle/XIDg4NhuGb/fMmju4bo47QRR325Y=;
 b=DvkCzj352RUFGRsmasBrEOIfEczIA7jAMP/MVQdrJgZCLigW7Zhw+DLDo1yMaHHxC21E5SSsRa1zS/ZV3bOY5puTMbqEdDx/NRu8eBxm05M6HBROQJJJt5Oww2IGylpvYol5pkmG6wumvQWBTE+wW/sDXAoO0EjpCJOYLLoET9aZIQrkp3GpPXdC2vjHz+vWPiU+H0IMXkp6JH8Mgn+wVqcYnsuTy/1G6sCwU7DN0ha5iZ8lDCLoPumIXMhZd0ffTUT/6xI1Vn/ehU2doq4G8IHz2JcWpDzY29Gal65l6IyOXlskPopUYDngrI1afJRF1yOqk66bIPArQgZHDxSsIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfkFNL8XcpUTle/XIDg4NhuGb/fMmju4bo47QRR325Y=;
 b=vnlFt02vxSQQDrTAWKxTQXVuQHTNYZn9ym9mzmcBljPRFUR/Z++IbUb+MnYXbgDXmPuHo+MF54HdiK6gTEr5kjdzeVeOLDEwdGPwRKrL+ebAm/yBecsLwdK2qcISzrVeReIkGwbVqmPKvHughkWILl8dqaGjLvG9fo0bx+fR/bw=
Received: from SN7PR04CA0187.namprd04.prod.outlook.com (2603:10b6:806:126::12)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Wed, 18 Mar
 2026 01:01:15 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::16) by SN7PR04CA0187.outlook.office365.com
 (2603:10b6:806:126::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Wed,
 18 Mar 2026 01:00:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:15 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:11 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <charlene.liu@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Subject: [PATCH 04/31] drm/amd/display: Move DPM clk read to clk_mgr_construct
 in DCN42
Date: Wed, 18 Mar 2026 08:59:13 +0800
Message-ID: <20260318010224.513094-5-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c06113c-68d7-4e0c-36b2-08de8489dafe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: RXilQxD02+o/El6OOM2+EIYRXNLchFhtO6RH0Z4ZU/jwITsEE6UrN3gwmTeUwaldUjsWBL2SkPllDstFs36xsrsLbt7oRmgtRVNK3WAVhUGsvkg2B7V8C/y9qQfCZysi3zou7WjyRwrxHXnzqJErbD8e5pF9THdimACpj5dheRS+CrSe8OwRx2V5/N35sLYy+OiQbrBot7C/lhZph76xZtFa+P8eQkWeCr2jmgoNHXE16xn9yXFQKGVq53bmk7EWmRQhfQCR96bAfU18DBSC22M08O30BL6OqL+iZN1U0E2zo8gUaLLWrqA70oWP/soCRjFPnmuODTX4QyvHtgqH7qKyXHJvVZu7MdqD2IlRV3f0oPosDoh54LyketZZgC7b4Wi5gXRcoi86veb4W+fbgIWlCY/Wm7T1AblcsC9TG6erXp2LIfT0+qziV6NRY7MfInaND9r0TkxQF9y9w0SfdkrvND2vhSbdFMLgqwhbmV2oo9RleACFACnCDW0zlEQ46jGepjG2wT1LvfqfB9MTFeMjjGFsabvuK/DouYVgeFtTnGYViqtC0z+E5NHJ1mroNbSHoBxDYzKMkO9VSXc0pQVZdQwESol3ENjnavtE16ws5LoqMAaxh4x70cwrlRztFV5EgpTXzA3nqBcevVUpPp3r1z5YKM5PCGvbNoMuHnYdhq97HaAx8heBiy9+vxpixA3GfFGASGrNzpnsiOXSC9kzurQFY5vaSICLe/VB2cOEVImyTtMdl3r0GbZnm71FgRd5fIyUKdhtHR+KbGmxNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oUaaqIGTSf+egzVORMqDPJDoStvKz2keeLrG3P40bD8dSgma3L1ZPHk+7mF+MjCpxHgw4b6T8pVnplHJ857zIJOs24xyqshX/BTt3QRGP/BU08RsOL2bq20l/svAKt93jSliqPK8j2+9o29dw2OtcMMyqtYS/LgPEXyP0vgGjPAIoGNrwabN3TQRdhtasqbyZz2VdcGZ+tNThZ1nMN7P4+iZYVkOQPheiXzaFZV2Yf5JMatakY5Wa/pk2FsvThEpXbDMryyO1Xv371befxmZo5osA+oas+VfsjSmKHPpLmhdz7iy3KieVpfdv2M8zrPJovAaiX6M/Ks/SSqz5yj4ZNp4kt8RMclrxNMf3HJqMpjWGaNSeaUwLIy+d3sSWB1qjuauxMIEqrNfdja+0w0S77qqCtInKzzka+8rvGLvAj7IRGWFot29EuXWjy94wBCe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:15.2309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c06113c-68d7-4e0c-36b2-08de8489dafe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
The DPM clocks on DCN42 are currently read on every dm_resume, which can
cause in gpu memory freeing while the device is still in suspend.

Move the DPM clock read functionality to clk_mgr_construct() so it
completes once on driver enablement.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 250 +++++++++---------
 1 file changed, 126 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index 97c9f0ce13e4..df904b6fafe9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -569,7 +569,6 @@ void dcn42_init_clocks(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr_int = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct clk_mgr_dcn42 *clk_mgr = TO_CLK_MGR_DCN42(clk_mgr_int);
-	struct dcn42_smu_dpm_clks smu_dpm_clks = { 0 };
 
 	DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
 	(void)dc_logger;
@@ -591,127 +590,6 @@ void dcn42_init_clocks(struct clk_mgr *clk_mgr_base)
 		/*dtbclk enabled based on*/
 		clk_mgr_base->clks.dtbclk_en = true;
 	}
-
-	if (clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels != 0) {
-		/*skip to get clock table and notify pmfw watermark range again*/
-		DC_LOG_SMU("skip to get dpm_clks from pmfw from resume and acr\n");
-		return;
-	}
-
-	smu_dpm_clks.dpm_clks = (DpmClocks_t_dcn42 *)dm_helpers_allocate_gpu_mem(
-				clk_mgr_base->ctx,
-				DC_MEM_ALLOC_TYPE_GART,
-				sizeof(DpmClocks_t_dcn42),
-				&smu_dpm_clks.mc_address.quad_part);
-
-	ASSERT(smu_dpm_clks.dpm_clks);
-	if (clk_mgr_base->ctx->dc->debug.pstate_enabled && clk_mgr_int->smu_present && smu_dpm_clks.mc_address.quad_part != 0) {
-		int i;
-		DpmClocks_t_dcn42 *dpm_clks = smu_dpm_clks.dpm_clks;
-
-		dcn42_get_dpm_table_from_smu(clk_mgr_int, &smu_dpm_clks);
-		DC_LOG_SMU("NumDcfClkLevelsEnabled: %d\n"
-				   "NumDispClkLevelsEnabled: %d\n"
-				   "NumSocClkLevelsEnabled: %d\n"
-				   "VcnClkLevelsEnabled: %d\n"
-				   "FClkLevelsEnabled: %d\n"
-				   "NumMemPstatesEnabled: %d\n"
-				   "MinGfxClk: %d\n"
-				   "MaxGfxClk: %d\n",
-				   dpm_clks->NumDcfClkLevelsEnabled,
-				   dpm_clks->NumDispClkLevelsEnabled,
-				   dpm_clks->NumSocClkLevelsEnabled,
-				   dpm_clks->VcnClkLevelsEnabled,
-				   dpm_clks->NumFclkLevelsEnabled,
-				   dpm_clks->NumMemPstatesEnabled,
-				   dpm_clks->MinGfxClk,
-				   dpm_clks->MaxGfxClk);
-
-		for (i = 0; i < NUM_DCFCLK_DPM_LEVELS; i++) {
-			DC_LOG_SMU("dpm_clks->DcfClocks[%d] = %d\n",
-					   i,
-					   dpm_clks->DcfClocks[i]);
-		}
-		for (i = 0; i < NUM_DISPCLK_DPM_LEVELS; i++) {
-			DC_LOG_SMU("dpm_clks->DispClocks[%d] = %d\n",
-					   i, dpm_clks->DispClocks[i]);
-		}
-		for (i = 0; i < NUM_SOCCLK_DPM_LEVELS; i++) {
-			DC_LOG_SMU("dpm_clks->SocClocks[%d] = %d\n",
-					   i, dpm_clks->SocClocks[i]);
-		}
-		for (i = 0; i < NUM_FCLK_DPM_LEVELS; i++) {
-			DC_LOG_SMU("dpm_clks->FclkClocks_Freq[%d] = %d\n",
-					   i, dpm_clks->FclkClocks_Freq[i]);
-			DC_LOG_SMU("dpm_clks->FclkClocks_Voltage[%d] = %d\n",
-					   i, dpm_clks->FclkClocks_Voltage[i]);
-		}
-		for (i = 0; i < NUM_SOCCLK_DPM_LEVELS; i++)
-			DC_LOG_SMU("dpm_clks->SocVoltage[%d] = %d\n",
-					   i, dpm_clks->SocVoltage[i]);
-
-		for (i = 0; i < NUM_MEM_PSTATE_LEVELS; i++) {
-			DC_LOG_SMU("dpm_clks.MemPstateTable[%d].UClk = %d\n"
-					   "dpm_clks->MemPstateTable[%d].MemClk= %d\n"
-					   "dpm_clks->MemPstateTable[%d].Voltage = %d\n",
-					   i, dpm_clks->MemPstateTable[i].UClk,
-					   i, dpm_clks->MemPstateTable[i].MemClk,
-					   i, dpm_clks->MemPstateTable[i].Voltage);
-		}
-
-		if (clk_mgr_base->ctx->dc_bios->integrated_info && clk_mgr_base->ctx->dc->config.use_default_clock_table == false) {
-			/* DCFCLK */
-			dcn42_init_single_clock(&clk_mgr_base->bw_params->clk_table.entries[0].dcfclk_mhz,
-					dpm_clks->DcfClocks,
-					dpm_clks->NumDcfClkLevelsEnabled);
-			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dcfclk_levels = dpm_clks->NumDcfClkLevelsEnabled;
-
-			/* SOCCLK */
-			dcn42_init_single_clock(&clk_mgr_base->bw_params->clk_table.entries[0].socclk_mhz,
-					dpm_clks->SocClocks,
-					dpm_clks->NumSocClkLevelsEnabled);
-			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_socclk_levels = dpm_clks->NumSocClkLevelsEnabled;
-
-			/* DISPCLK */
-			dcn42_init_single_clock(&clk_mgr_base->bw_params->clk_table.entries[0].dispclk_mhz,
-					dpm_clks->DispClocks,
-					dpm_clks->NumDispClkLevelsEnabled);
-			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dispclk_levels = dpm_clks->NumDispClkLevelsEnabled;
-
-			/* DPPCLK */
-			dcn42_init_single_clock(&clk_mgr_base->bw_params->clk_table.entries[0].dppclk_mhz,
-					dpm_clks->DppClocks,
-					dpm_clks->NumDispClkLevelsEnabled);
-			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dppclk_levels = dpm_clks->NumDispClkLevelsEnabled;
-
-			/* FCLK */
-			dcn42_init_single_clock(&clk_mgr_base->bw_params->clk_table.entries[0].fclk_mhz,
-					dpm_clks->FclkClocks_Freq,
-					NUM_FCLK_DPM_LEVELS);
-			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_fclk_levels = dpm_clks->NumFclkLevelsEnabled;
-			clk_mgr_base->bw_params->clk_table.num_entries = dpm_clks->NumFclkLevelsEnabled;
-
-			/* Memory Pstate table is in reverse order*/
-			ASSERT(dpm_clks->NumMemPstatesEnabled <= NUM_MEM_PSTATE_LEVELS);
-			if (dpm_clks->NumMemPstatesEnabled > NUM_MEM_PSTATE_LEVELS)
-				dpm_clks->NumMemPstatesEnabled = NUM_MEM_PSTATE_LEVELS;
-			for (i = 0; i < dpm_clks->NumMemPstatesEnabled; i++) {
-				clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].memclk_mhz = dpm_clks->MemPstateTable[i].UClk;
-				clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].wck_ratio = dcn42_convert_wck_ratio(dpm_clks->MemPstateTable[i].WckRatio)	;
-			}
-			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels = dpm_clks->NumMemPstatesEnabled;
-
-			/* DTBCLK*/
-			clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz = clk_mgr_base->clks.ref_dtbclk_khz / 1000;
-			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels = 1;
-			/* Refresh bounding box */
-			clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
-				clk_mgr_base->ctx->dc, clk_mgr_base->bw_params);
-		}
-	}
-	if (smu_dpm_clks.dpm_clks && smu_dpm_clks.mc_address.quad_part != 0)
-		dm_helpers_free_gpu_mem(clk_mgr_base->ctx, DC_MEM_ALLOC_TYPE_GART,
-				smu_dpm_clks.dpm_clks);
 }
 
 static struct clk_bw_params dcn42_bw_params = {
@@ -1071,6 +949,127 @@ bool dcn42_is_smu_present(struct clk_mgr *clk_mgr_base)
 	return clk_mgr->smu_present;
 }
 
+static void dcn42_get_smu_clocks(struct clk_mgr_internal *clk_mgr_int)
+{
+	struct clk_mgr *clk_mgr_base = &clk_mgr_int->base;
+	struct dcn42_smu_dpm_clks smu_dpm_clks = { 0 };
+
+	DC_LOGGER_INIT(clk_mgr_base->ctx->logger);
+	(void)dc_logger;
+
+	smu_dpm_clks.dpm_clks = (DpmClocks_t_dcn42 *)dm_helpers_allocate_gpu_mem(
+				clk_mgr_base->ctx,
+				DC_MEM_ALLOC_TYPE_GART,
+				sizeof(DpmClocks_t_dcn42),
+				&smu_dpm_clks.mc_address.quad_part);
+
+	ASSERT(smu_dpm_clks.dpm_clks);
+	if (clk_mgr_base->ctx->dc->debug.pstate_enabled && smu_dpm_clks.mc_address.quad_part != 0) {
+		int i;
+		DpmClocks_t_dcn42 *dpm_clks = smu_dpm_clks.dpm_clks;
+
+		dcn42_get_dpm_table_from_smu(clk_mgr_int, &smu_dpm_clks);
+		DC_LOG_SMU("NumDcfClkLevelsEnabled: %d\n"
+				   "NumDispClkLevelsEnabled: %d\n"
+				   "NumSocClkLevelsEnabled: %d\n"
+				   "VcnClkLevelsEnabled: %d\n"
+				   "FClkLevelsEnabled: %d\n"
+				   "NumMemPstatesEnabled: %d\n"
+				   "MinGfxClk: %d\n"
+				   "MaxGfxClk: %d\n",
+				   dpm_clks->NumDcfClkLevelsEnabled,
+				   dpm_clks->NumDispClkLevelsEnabled,
+				   dpm_clks->NumSocClkLevelsEnabled,
+				   dpm_clks->VcnClkLevelsEnabled,
+				   dpm_clks->NumFclkLevelsEnabled,
+				   dpm_clks->NumMemPstatesEnabled,
+				   dpm_clks->MinGfxClk,
+				   dpm_clks->MaxGfxClk);
+
+		for (i = 0; i < NUM_DCFCLK_DPM_LEVELS; i++) {
+			DC_LOG_SMU("dpm_clks->DcfClocks[%d] = %d\n",
+					   i,
+					   dpm_clks->DcfClocks[i]);
+		}
+		for (i = 0; i < NUM_DISPCLK_DPM_LEVELS; i++) {
+			DC_LOG_SMU("dpm_clks->DispClocks[%d] = %d\n",
+					   i, dpm_clks->DispClocks[i]);
+		}
+		for (i = 0; i < NUM_SOCCLK_DPM_LEVELS; i++) {
+			DC_LOG_SMU("dpm_clks->SocClocks[%d] = %d\n",
+					   i, dpm_clks->SocClocks[i]);
+		}
+		for (i = 0; i < NUM_FCLK_DPM_LEVELS; i++) {
+			DC_LOG_SMU("dpm_clks->FclkClocks_Freq[%d] = %d\n",
+					   i, dpm_clks->FclkClocks_Freq[i]);
+			DC_LOG_SMU("dpm_clks->FclkClocks_Voltage[%d] = %d\n",
+					   i, dpm_clks->FclkClocks_Voltage[i]);
+		}
+		for (i = 0; i < NUM_SOCCLK_DPM_LEVELS; i++)
+			DC_LOG_SMU("dpm_clks->SocVoltage[%d] = %d\n",
+					   i, dpm_clks->SocVoltage[i]);
+
+		for (i = 0; i < NUM_MEM_PSTATE_LEVELS; i++) {
+			DC_LOG_SMU("dpm_clks.MemPstateTable[%d].UClk = %d\n"
+					   "dpm_clks->MemPstateTable[%d].MemClk= %d\n"
+					   "dpm_clks->MemPstateTable[%d].Voltage = %d\n",
+					   i, dpm_clks->MemPstateTable[i].UClk,
+					   i, dpm_clks->MemPstateTable[i].MemClk,
+					   i, dpm_clks->MemPstateTable[i].Voltage);
+		}
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
+			/* Memory Pstate table is in reverse order*/
+			ASSERT(dpm_clks->NumMemPstatesEnabled <= NUM_MEM_PSTATE_LEVELS);
+			if (dpm_clks->NumMemPstatesEnabled > NUM_MEM_PSTATE_LEVELS)
+				dpm_clks->NumMemPstatesEnabled = NUM_MEM_PSTATE_LEVELS;
+			for (i = 0; i < dpm_clks->NumMemPstatesEnabled; i++) {
+				clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].memclk_mhz = dpm_clks->MemPstateTable[i].UClk;
+				clk_mgr_base->bw_params->clk_table.entries[dpm_clks->NumMemPstatesEnabled - 1 - i].wck_ratio = dcn42_convert_wck_ratio(dpm_clks->MemPstateTable[i].WckRatio)	;
+			}
+			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_memclk_levels = dpm_clks->NumMemPstatesEnabled;
+
+			/* DTBCLK*/
+			clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz = clk_mgr_base->clks.ref_dtbclk_khz / 1000;
+			clk_mgr_base->bw_params->clk_table.num_entries_per_clk.num_dtbclk_levels = 1;
+		}
+	}
+	if (smu_dpm_clks.dpm_clks && smu_dpm_clks.mc_address.quad_part != 0)
+		dm_helpers_free_gpu_mem(clk_mgr_base->ctx, DC_MEM_ALLOC_TYPE_GART,
+				smu_dpm_clks.dpm_clks);
+}
+
 static struct clk_mgr_funcs dcn42_funcs = {
 	.get_dp_ref_clk_frequency = dce12_get_dp_ref_freq_khz,
 	.get_dtb_ref_clk_frequency = dcn31_get_dtb_ref_freq_khz,
@@ -1139,6 +1138,11 @@ void dcn42_clk_mgr_construct(
 			dcn42_bw_params.num_channels = ctx->dc_bios->integrated_info->ma_channel_number ? ctx->dc_bios->integrated_info->ma_channel_number : 1;
 			clk_mgr->base.base.dprefclk_khz = dcn42_smu_get_dprefclk(&clk_mgr->base);
 			clk_mgr->base.base.clks.ref_dtbclk_khz = dcn42_smu_get_dtbclk(&clk_mgr->base);
+
+			clk_mgr->base.base.bw_params = &dcn42_bw_params;
+
+			if (clk_mgr->base.smu_present)
+				dcn42_get_smu_clocks(&clk_mgr->base);
 		}
 		/* in case we don't get a value from the BIOS, use default */
 		if (clk_mgr->base.base.dentist_vco_freq_khz == 0)
@@ -1151,8 +1155,6 @@ void dcn42_clk_mgr_construct(
 	/*when clk src is from FCH, it could have ss, same clock src as DPREF clk*/
 
 	dcn42_read_ss_info_from_lut(&clk_mgr->base);
-
-	clk_mgr->base.base.bw_params = &dcn42_bw_params;
 }
 
 void dcn42_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr_int)
-- 
2.43.0

