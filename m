Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6233C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E56010E479;
	Wed, 31 May 2023 04:49:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 087A610E478
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUA2pLZMbtLPuoNTiNmkRDwzWGmldDg5M0vOpKG8PJzM+SLo3cao3e/vOY32BLFTxA/tep19EP2NSSCYd3SrMWqSmUs0ZNgCYkD6yEIO/UmLTWk3mst1QlXsVwiaDeDnJ+9DS24K+IwDiVhuIfV+5TpfEgOLn+dWtzSoFXR0sWKrB1enVvQtY1/nin5Id+wV7pgHCcn6p8XSihTEv0eAP5WdSKl7iYOL1UuntMO7Yn9vp7y4bt4CHxQvFTTV3SRxZq+nW6bmm0tIbTXp7IHJD4eEm9+pdvdhQ64yAagshhbdOput8Ejt75KXzcKPPgWmx2P4zvJKhu6SlTS3+/oIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4myzWCvSWnN57FXSwnZ12HaAwl50am55AZEf5R915Q=;
 b=Pn97OIo5mRztis0iLyokUebnb0Aa/6hnA3h5U7TPfibXcC9cfFM8Yatm4ZZZ8wcvRQN/MuJTz9ln1naP+wDuTOlVXmIF776Z5fUdyq19cs5LyqLiuoXBZqUP+N+VdgSCM30ryK/DHvTr+nWexPPWPwIem8+wq31YV4/Ndc4540LQ9R8ngjoLrbfiXY90fiMiWUpYNaBvkMK9J2sSOcjIG66zcIQjUa/xP1INNF16z2FDbm2EmaKuFzgLqyB0fyZFh5bY5OCI5UHksr7sY/83GCnUsp0WNk50dpAge5spJ1eNiwWWTApHRpp5ZlFnjcogojBU48NNMqVaCChE9DEi+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4myzWCvSWnN57FXSwnZ12HaAwl50am55AZEf5R915Q=;
 b=pO3mbG7MJ3/9wih6stQ6Vvr9jwKivbqx21fRUSvt+HU8gvbrkKM684+UyeDrlR7CJdNj9/yPIN2/fNHR4Hflctr2bQ59Jdnuf6YggwrSKTljdojrEyTxVfAeY2RCW7z8/4Jl85lM17q1PzMJ/RundH4V+eXtvKDX2f9BVw3ZTP4=
Received: from BN9PR03CA0666.namprd03.prod.outlook.com (2603:10b6:408:10e::11)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 04:49:44 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::3f) by BN9PR03CA0666.outlook.office365.com
 (2603:10b6:408:10e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 04:49:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:43 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:49:39 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/14] drm/amd/display: Filter out AC mode frequencies on DC
 mode systems
Date: Wed, 31 May 2023 12:48:11 +0800
Message-ID: <20230531044813.145361-13-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ab32dd9-0ab7-48c4-2144-08db619273d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdULGmCq/9Oj3OXBPq8fkTXzxN59YzahK6We7h7UCG4dZzSPpN5MU3tHIEdSlHwgYIv7rbLxbyhxLlC6g0OdnAGaCvZAPGLnVGh23MrHqqH/5wM3BsbAwDzVzfy9E1AfJmZ7JSDD0g5aJOspfCQ1fsmJOP7R9com4RwEHIUTPQ0zoaUU75FUBjzh4ePv9jRaDGI+5nFJI3lnhMoPM5rmdhCsnXqUnt2MC9/j6bB+Sapt7K0Q+60qxBaO8Q9SJopNG/YtI3qYWPBb3/RfqFcxfx5vrHt5sSM9UnOVVGc+/3Nq+CZEU+BNKWzqtiQp4p1fye4hjpG7/qixji3/SVtMkDlqT31d3eGDjpenV9UQARPmvdsbe4KFE84ISxPqA3jXgiBDgcWG+3NxVCN+nKDjZQEG1JVKJ6Ayz7ThNeqy2ACWeH2nLX7n7SyLooCj1nD19XZ2ULrllcNqQkxqQkuiB9K3CiLbTuJm/zg9tJXdvoOU+yH+rmg0Q2kJ36NDdDSqBz9GIGd1DLPA9mPJmexUOEHpbhFqIEYzvQ5JnYcuysjPijxL2laqmg7PkuArq9H8EDg7RWvIeNEkrtBJ1z5FQQyCiaH9Ws0H4tlAajywrKwrE5ty9h6MsMcB61aw0xgrQFfIgdAsAaWWswtxVeRn6tbdwStGE/5NZjD4WECc7LuRNX4guZP3CoGaouz7eNg0v7bS4Cj5uMGSHmAIAvCJc3zm0baqzHe6QKyagRIpN0KT8MEUpu5S28d1F9Lx7fEfxH7H6hMj1G4i1B1BsotBEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(7696005)(36860700001)(26005)(1076003)(41300700001)(6666004)(16526019)(83380400001)(47076005)(186003)(426003)(336012)(2616005)(478600001)(8676002)(40460700003)(66899021)(54906003)(82310400005)(70586007)(6916009)(82740400003)(356005)(70206006)(4326008)(316002)(40480700001)(81166007)(5660300002)(8936002)(86362001)(44832011)(30864003)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:43.9186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab32dd9-0ab7-48c4-2144-08db619273d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
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
Cc: stylon.wang@amd.com, Austin Zheng <austin.zheng@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <austin.zheng@amd.com>

Why:
Limit maximum clock speeds to DC mode limits for DC mode systems
How:
Store DC mode limits when individual clocks are initialized and
cap the values when building the clock table

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  13 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 140 ++++++++++++-----
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    | 144 +++++++++++++-----
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 5 files changed, 216 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 20bff6a346ba..96fa68f166e0 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -182,23 +182,32 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	dcn32_init_single_clock(clk_mgr, PPCLK_DCFCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].dcfclk_mhz,
 			&num_entries_per_clk->num_dcfclk_levels);
+	clk_mgr_base->bw_params->dc_mode_limit.dcfclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DCFCLK);
 
 	/* SOCCLK */
 	dcn32_init_single_clock(clk_mgr, PPCLK_SOCCLK,
 					&clk_mgr_base->bw_params->clk_table.entries[0].socclk_mhz,
 					&num_entries_per_clk->num_socclk_levels);
+	clk_mgr_base->bw_params->dc_mode_limit.socclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_SOCCLK);
 
 	/* DTBCLK */
-	if (!clk_mgr->base.ctx->dc->debug.disable_dtb_ref_clk_switch)
+	if (!clk_mgr->base.ctx->dc->debug.disable_dtb_ref_clk_switch) {
 		dcn32_init_single_clock(clk_mgr, PPCLK_DTBCLK,
 				&clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz,
 				&num_entries_per_clk->num_dtbclk_levels);
+		clk_mgr_base->bw_params->dc_mode_limit.dtbclk_mhz =
+				dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DTBCLK);
+	}
 
 	/* DISPCLK */
 	dcn32_init_single_clock(clk_mgr, PPCLK_DISPCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].dispclk_mhz,
 			&num_entries_per_clk->num_dispclk_levels);
 	num_levels = num_entries_per_clk->num_dispclk_levels;
+	clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_DISPCLK);
+	//HW recommends limit of 1950 MHz in display clock for all DCN3.2.x
+	if (clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz > 1950)
+		clk_mgr_base->bw_params->dc_mode_limit.dispclk_mhz = 1950;
 
 	if (num_entries_per_clk->num_dcfclk_levels &&
 			num_entries_per_clk->num_dtbclk_levels &&
@@ -817,6 +826,7 @@ static void dcn32_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 	dcn32_init_single_clock(clk_mgr, PPCLK_UCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].memclk_mhz,
 			&num_entries_per_clk->num_memclk_levels);
+	clk_mgr_base->bw_params->dc_mode_limit.memclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_UCLK);
 
 	/* memclk must have at least one level */
 	num_entries_per_clk->num_memclk_levels = num_entries_per_clk->num_memclk_levels ? num_entries_per_clk->num_memclk_levels : 1;
@@ -824,6 +834,7 @@ static void dcn32_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 	dcn32_init_single_clock(clk_mgr, PPCLK_FCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].fclk_mhz,
 			&num_entries_per_clk->num_fclk_levels);
+	clk_mgr_base->bw_params->dc_mode_limit.fclk_mhz = dcn30_smu_get_dc_mode_max_dpm_freq(clk_mgr, PPCLK_FCLK);
 
 	if (num_entries_per_clk->num_memclk_levels >= num_entries_per_clk->num_fclk_levels) {
 		num_levels = num_entries_per_clk->num_memclk_levels;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7ded574f84ff..360dd83b1a7a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -897,6 +897,7 @@ struct dc_debug_options {
 	uint32_t fpo_vactive_min_active_margin_us;
 	uint32_t fpo_vactive_max_blank_us;
 	bool enable_legacy_fast_update;
+	bool disable_dc_mode_overwrite;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index b17f30afa189..50b0efef9892 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2325,14 +2325,48 @@ void dcn32_patch_dpm_table(struct clk_bw_params *bw_params)
 		bw_params->clk_table.entries[0].memclk_mhz = dcn3_2_soc.clock_limits[0].dram_speed_mts / 16;
 }
 
-static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
+/*
+ * override_max_clk_values - Overwrite the max clock frequencies with the max DC mode timings
+ * Input:
+ *	max_clk_limit - struct containing the desired clock timings
+ * Output:
+ *	curr_clk_limit  - struct containing the timings that need to be overwritten
+ * Return: 0 upon success, non-zero for failure
+ */
+static int override_max_clk_values(struct clk_limit_table_entry *max_clk_limit,
+		struct clk_limit_table_entry *curr_clk_limit)
+{
+	if (NULL == max_clk_limit || NULL == curr_clk_limit)
+		return -1; //invalid parameters
+
+	//only overwrite if desired max clock frequency is initialized
+	if (max_clk_limit->dcfclk_mhz != 0)
+		curr_clk_limit->dcfclk_mhz = max_clk_limit->dcfclk_mhz;
+
+	if (max_clk_limit->fclk_mhz != 0)
+		curr_clk_limit->fclk_mhz = max_clk_limit->fclk_mhz;
+
+	if (max_clk_limit->memclk_mhz != 0)
+		curr_clk_limit->memclk_mhz = max_clk_limit->memclk_mhz;
+
+	if (max_clk_limit->socclk_mhz != 0)
+		curr_clk_limit->socclk_mhz = max_clk_limit->socclk_mhz;
+
+	if (max_clk_limit->dtbclk_mhz != 0)
+		curr_clk_limit->dtbclk_mhz = max_clk_limit->dtbclk_mhz;
+
+	if (max_clk_limit->dispclk_mhz != 0)
+		curr_clk_limit->dispclk_mhz = max_clk_limit->dispclk_mhz;
+
+	return 0;
+}
+
+static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk_bw_params *bw_params,
 		struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
 {
 	int i, j;
 	struct _vcs_dpi_voltage_scaling_st entry = {0};
-
-	unsigned int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0,
-			max_phyclk_mhz = 0, max_dtbclk_mhz = 0, max_fclk_mhz = 0, max_uclk_mhz = 0;
+	struct clk_limit_table_entry max_clk_data = {0};
 
 	unsigned int min_dcfclk_mhz = 199, min_fclk_mhz = 299;
 
@@ -2343,51 +2377,76 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	unsigned int num_fclk_dpms = 0;
 	unsigned int num_dcfclk_dpms = 0;
 
-	for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
-		if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
-			max_dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
-		if (bw_params->clk_table.entries[i].fclk_mhz > max_fclk_mhz)
-			max_fclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
-		if (bw_params->clk_table.entries[i].memclk_mhz > max_uclk_mhz)
-			max_uclk_mhz = bw_params->clk_table.entries[i].memclk_mhz;
-		if (bw_params->clk_table.entries[i].dispclk_mhz > max_dispclk_mhz)
-			max_dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
-		if (bw_params->clk_table.entries[i].dppclk_mhz > max_dppclk_mhz)
-			max_dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
-		if (bw_params->clk_table.entries[i].phyclk_mhz > max_phyclk_mhz)
-			max_phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
-		if (bw_params->clk_table.entries[i].dtbclk_mhz > max_dtbclk_mhz)
-			max_dtbclk_mhz = bw_params->clk_table.entries[i].dtbclk_mhz;
+	unsigned int num_dc_uclk_dpms = 0;
+	unsigned int num_dc_fclk_dpms = 0;
+	unsigned int num_dc_dcfclk_dpms = 0;
 
-		if (bw_params->clk_table.entries[i].memclk_mhz > 0)
+	for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
+		if (bw_params->clk_table.entries[i].dcfclk_mhz > max_clk_data.dcfclk_mhz)
+			max_clk_data.dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
+		if (bw_params->clk_table.entries[i].fclk_mhz > max_clk_data.fclk_mhz)
+			max_clk_data.fclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
+		if (bw_params->clk_table.entries[i].memclk_mhz > max_clk_data.memclk_mhz)
+			max_clk_data.memclk_mhz = bw_params->clk_table.entries[i].memclk_mhz;
+		if (bw_params->clk_table.entries[i].dispclk_mhz > max_clk_data.dispclk_mhz)
+			max_clk_data.dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
+		if (bw_params->clk_table.entries[i].dppclk_mhz > max_clk_data.dppclk_mhz)
+			max_clk_data.dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
+		if (bw_params->clk_table.entries[i].phyclk_mhz > max_clk_data.phyclk_mhz)
+			max_clk_data.phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
+		if (bw_params->clk_table.entries[i].dtbclk_mhz > max_clk_data.dtbclk_mhz)
+			max_clk_data.dtbclk_mhz = bw_params->clk_table.entries[i].dtbclk_mhz;
+
+		if (bw_params->clk_table.entries[i].memclk_mhz > 0) {
 			num_uclk_dpms++;
-		if (bw_params->clk_table.entries[i].fclk_mhz > 0)
+			if (bw_params->clk_table.entries[i].memclk_mhz <= bw_params->dc_mode_limit.memclk_mhz)
+				num_dc_uclk_dpms++;
+		}
+		if (bw_params->clk_table.entries[i].fclk_mhz > 0) {
 			num_fclk_dpms++;
-		if (bw_params->clk_table.entries[i].dcfclk_mhz > 0)
+			if (bw_params->clk_table.entries[i].fclk_mhz <= bw_params->dc_mode_limit.fclk_mhz)
+				num_dc_fclk_dpms++;
+		}
+		if (bw_params->clk_table.entries[i].dcfclk_mhz > 0) {
 			num_dcfclk_dpms++;
+			if (bw_params->clk_table.entries[i].dcfclk_mhz <= bw_params->dc_mode_limit.dcfclk_mhz)
+				num_dc_dcfclk_dpms++;
+		}
+	}
+
+	if (!disable_dc_mode_overwrite) {
+		//Overwrite max frequencies with max DC mode frequencies for DC mode systems
+		override_max_clk_values(&bw_params->dc_mode_limit, &max_clk_data);
+		num_uclk_dpms = num_dc_uclk_dpms;
+		num_fclk_dpms = num_dc_fclk_dpms;
+		num_dcfclk_dpms = num_dc_dcfclk_dpms;
+		bw_params->clk_table.num_entries_per_clk.num_memclk_levels = num_uclk_dpms;
+		bw_params->clk_table.num_entries_per_clk.num_fclk_levels = num_fclk_dpms;
 	}
 
 	if (num_dcfclk_dpms > 0 && bw_params->clk_table.entries[0].fclk_mhz > min_fclk_mhz)
 		min_fclk_mhz = bw_params->clk_table.entries[0].fclk_mhz;
 
-	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dtbclk_mhz)
+	if (!max_clk_data.dcfclk_mhz || !max_clk_data.dispclk_mhz || !max_clk_data.dtbclk_mhz)
 		return -1;
 
-	if (max_dppclk_mhz == 0)
-		max_dppclk_mhz = max_dispclk_mhz;
+	if (max_clk_data.dppclk_mhz == 0)
+		max_clk_data.dppclk_mhz = max_clk_data.dispclk_mhz;
 
-	if (max_fclk_mhz == 0)
-		max_fclk_mhz = max_dcfclk_mhz * dcn3_2_soc.pct_ideal_sdp_bw_after_urgent / dcn3_2_soc.pct_ideal_fabric_bw_after_urgent;
+	if (max_clk_data.fclk_mhz == 0)
+		max_clk_data.fclk_mhz = max_clk_data.dcfclk_mhz *
+				dcn3_2_soc.pct_ideal_sdp_bw_after_urgent /
+				dcn3_2_soc.pct_ideal_fabric_bw_after_urgent;
 
-	if (max_phyclk_mhz == 0)
-		max_phyclk_mhz = dcn3_2_soc.clock_limits[0].phyclk_mhz;
+	if (max_clk_data.phyclk_mhz == 0)
+		max_clk_data.phyclk_mhz = dcn3_2_soc.clock_limits[0].phyclk_mhz;
 
 	*num_entries = 0;
-	entry.dispclk_mhz = max_dispclk_mhz;
-	entry.dscclk_mhz = max_dispclk_mhz / 3;
-	entry.dppclk_mhz = max_dppclk_mhz;
-	entry.dtbclk_mhz = max_dtbclk_mhz;
-	entry.phyclk_mhz = max_phyclk_mhz;
+	entry.dispclk_mhz = max_clk_data.dispclk_mhz;
+	entry.dscclk_mhz = max_clk_data.dispclk_mhz / 3;
+	entry.dppclk_mhz = max_clk_data.dppclk_mhz;
+	entry.dtbclk_mhz = max_clk_data.dtbclk_mhz;
+	entry.phyclk_mhz = max_clk_data.phyclk_mhz;
 	entry.phyclk_d18_mhz = dcn3_2_soc.clock_limits[0].phyclk_d18_mhz;
 	entry.phyclk_d32_mhz = dcn3_2_soc.clock_limits[0].phyclk_d32_mhz;
 
@@ -2401,7 +2460,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	}
 
 	// Insert the max DCFCLK
-	entry.dcfclk_mhz = max_dcfclk_mhz;
+	entry.dcfclk_mhz = max_clk_data.dcfclk_mhz;
 	entry.fabricclk_mhz = 0;
 	entry.dram_speed_mts = 0;
 
@@ -2429,7 +2488,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	// If FCLK fine grained, only insert max
 	else {
 		entry.dcfclk_mhz = 0;
-		entry.fabricclk_mhz = max_fclk_mhz;
+		entry.fabricclk_mhz = max_clk_data.fclk_mhz;
 		entry.dram_speed_mts = 0;
 
 		insert_entry_into_table_sorted(table, num_entries, &entry);
@@ -2441,9 +2500,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 
 	// Remove states that require higher clocks than are supported
 	for (i = *num_entries - 1; i >= 0 ; i--) {
-		if (table[i].dcfclk_mhz > max_dcfclk_mhz ||
-				table[i].fabricclk_mhz > max_fclk_mhz ||
-				table[i].dram_speed_mts > max_uclk_mhz * 16)
+		if (table[i].dcfclk_mhz > max_clk_data.dcfclk_mhz ||
+				table[i].fabricclk_mhz > max_clk_data.fclk_mhz ||
+				table[i].dram_speed_mts > max_clk_data.memclk_mhz * 16)
 			remove_entry_from_table_at_index(table, num_entries, i);
 	}
 
@@ -2756,7 +2815,8 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
 				dcn3_2_soc.clock_limits[i].phyclk_d32_mhz = dcn3_2_soc.clock_limits[0].phyclk_d32_mhz;
 			}
 		} else {
-			build_synthetic_soc_states(bw_params, dcn3_2_soc.clock_limits, &dcn3_2_soc.num_states);
+			build_synthetic_soc_states(dc->debug.disable_dc_mode_overwrite, bw_params,
+					dcn3_2_soc.clock_limits, &dcn3_2_soc.num_states);
 		}
 
 		/* Re-init DML with updated bb */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 1aaff6f2d453..f0683fd9d3f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -252,14 +252,48 @@ static void remove_entry_from_table_at_index(struct _vcs_dpi_voltage_scaling_st
 	memset(&table[--(*num_entries)], 0, sizeof(struct _vcs_dpi_voltage_scaling_st));
 }
 
-static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
+/*
+ * override_max_clk_values - Overwrite the max clock frequencies with the max DC mode timings
+ * Input:
+ *	max_clk_limit - struct containing the desired clock timings
+ * Output:
+ *	curr_clk_limit  - struct containing the timings that need to be overwritten
+ * Return: 0 upon success, non-zero for failure
+ */
+static int override_max_clk_values(struct clk_limit_table_entry *max_clk_limit,
+		struct clk_limit_table_entry *curr_clk_limit)
+{
+	if (NULL == max_clk_limit || NULL == curr_clk_limit)
+		return -1; //invalid parameters
+
+	//only overwrite if desired max clock frequency is initialized
+	if (max_clk_limit->dcfclk_mhz != 0)
+		curr_clk_limit->dcfclk_mhz = max_clk_limit->dcfclk_mhz;
+
+	if (max_clk_limit->fclk_mhz != 0)
+		curr_clk_limit->fclk_mhz = max_clk_limit->fclk_mhz;
+
+	if (max_clk_limit->memclk_mhz != 0)
+		curr_clk_limit->memclk_mhz = max_clk_limit->memclk_mhz;
+
+	if (max_clk_limit->socclk_mhz != 0)
+		curr_clk_limit->socclk_mhz = max_clk_limit->socclk_mhz;
+
+	if (max_clk_limit->dtbclk_mhz != 0)
+		curr_clk_limit->dtbclk_mhz = max_clk_limit->dtbclk_mhz;
+
+	if (max_clk_limit->dispclk_mhz != 0)
+		curr_clk_limit->dispclk_mhz = max_clk_limit->dispclk_mhz;
+
+	return 0;
+}
+
+static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk_bw_params *bw_params,
 		struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
 {
 	int i, j;
 	struct _vcs_dpi_voltage_scaling_st entry = {0};
-
-	unsigned int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0,
-			max_phyclk_mhz = 0, max_dtbclk_mhz = 0, max_fclk_mhz = 0, max_uclk_mhz = 0;
+	struct clk_limit_table_entry max_clk_data = {0};
 
 	unsigned int min_dcfclk_mhz = 199, min_fclk_mhz = 299;
 
@@ -270,53 +304,78 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	unsigned int num_fclk_dpms = 0;
 	unsigned int num_dcfclk_dpms = 0;
 
+	unsigned int num_dc_uclk_dpms = 0;
+	unsigned int num_dc_fclk_dpms = 0;
+	unsigned int num_dc_dcfclk_dpms = 0;
+
 	for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
-		if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
-			max_dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
-		if (bw_params->clk_table.entries[i].fclk_mhz > max_fclk_mhz)
-			max_fclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
-		if (bw_params->clk_table.entries[i].memclk_mhz > max_uclk_mhz)
-			max_uclk_mhz = bw_params->clk_table.entries[i].memclk_mhz;
-		if (bw_params->clk_table.entries[i].dispclk_mhz > max_dispclk_mhz)
-			max_dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
-		if (bw_params->clk_table.entries[i].dppclk_mhz > max_dppclk_mhz)
-			max_dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
-		if (bw_params->clk_table.entries[i].phyclk_mhz > max_phyclk_mhz)
-			max_phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
-		if (bw_params->clk_table.entries[i].dtbclk_mhz > max_dtbclk_mhz)
-			max_dtbclk_mhz = bw_params->clk_table.entries[i].dtbclk_mhz;
-
-		if (bw_params->clk_table.entries[i].memclk_mhz > 0)
+		if (bw_params->clk_table.entries[i].dcfclk_mhz > max_clk_data.dcfclk_mhz)
+			max_clk_data.dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
+		if (bw_params->clk_table.entries[i].fclk_mhz > max_clk_data.fclk_mhz)
+			max_clk_data.fclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
+		if (bw_params->clk_table.entries[i].memclk_mhz > max_clk_data.memclk_mhz)
+			max_clk_data.memclk_mhz = bw_params->clk_table.entries[i].memclk_mhz;
+		if (bw_params->clk_table.entries[i].dispclk_mhz > max_clk_data.dispclk_mhz)
+			max_clk_data.dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
+		if (bw_params->clk_table.entries[i].dppclk_mhz > max_clk_data.dppclk_mhz)
+			max_clk_data.dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
+		if (bw_params->clk_table.entries[i].phyclk_mhz > max_clk_data.phyclk_mhz)
+			max_clk_data.phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
+		if (bw_params->clk_table.entries[i].dtbclk_mhz > max_clk_data.dtbclk_mhz)
+			max_clk_data.dtbclk_mhz = bw_params->clk_table.entries[i].dtbclk_mhz;
+
+		if (bw_params->clk_table.entries[i].memclk_mhz > 0) {
 			num_uclk_dpms++;
-		if (bw_params->clk_table.entries[i].fclk_mhz > 0)
+			if (bw_params->clk_table.entries[i].memclk_mhz <= bw_params->dc_mode_limit.memclk_mhz)
+				num_dc_uclk_dpms++;
+		}
+		if (bw_params->clk_table.entries[i].fclk_mhz > 0) {
 			num_fclk_dpms++;
-		if (bw_params->clk_table.entries[i].dcfclk_mhz > 0)
+			if (bw_params->clk_table.entries[i].fclk_mhz <= bw_params->dc_mode_limit.fclk_mhz)
+				num_dc_fclk_dpms++;
+		}
+		if (bw_params->clk_table.entries[i].dcfclk_mhz > 0) {
 			num_dcfclk_dpms++;
+			if (bw_params->clk_table.entries[i].dcfclk_mhz <= bw_params->dc_mode_limit.dcfclk_mhz)
+				num_dc_dcfclk_dpms++;
+		}
+	}
+
+	if (!disable_dc_mode_overwrite) {
+		//Overwrite max frequencies with max DC mode frequencies for DC mode systems
+		override_max_clk_values(&bw_params->dc_mode_limit, &max_clk_data);
+		num_uclk_dpms = num_dc_uclk_dpms;
+		num_fclk_dpms = num_dc_fclk_dpms;
+		num_dcfclk_dpms = num_dc_dcfclk_dpms;
+		bw_params->clk_table.num_entries_per_clk.num_memclk_levels = num_uclk_dpms;
+		bw_params->clk_table.num_entries_per_clk.num_fclk_levels = num_fclk_dpms;
 	}
 
 	if (num_dcfclk_dpms > 0 && bw_params->clk_table.entries[0].fclk_mhz > min_fclk_mhz)
 		min_fclk_mhz = bw_params->clk_table.entries[0].fclk_mhz;
 
-	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dtbclk_mhz)
+	if (!max_clk_data.dcfclk_mhz || !max_clk_data.dispclk_mhz || !max_clk_data.dtbclk_mhz)
 		return -1;
 
-	if (max_dppclk_mhz == 0)
-		max_dppclk_mhz = max_dispclk_mhz;
+	if (max_clk_data.dppclk_mhz == 0)
+		max_clk_data.dppclk_mhz = max_clk_data.dispclk_mhz;
 
-	if (max_fclk_mhz == 0)
-		max_fclk_mhz = max_dcfclk_mhz * dcn3_21_soc.pct_ideal_sdp_bw_after_urgent / dcn3_21_soc.pct_ideal_fabric_bw_after_urgent;
+	if (max_clk_data.fclk_mhz == 0)
+		max_clk_data.fclk_mhz = max_clk_data.dcfclk_mhz *
+				dcn3_2_soc.pct_ideal_sdp_bw_after_urgent /
+				dcn3_2_soc.pct_ideal_fabric_bw_after_urgent;
 
-	if (max_phyclk_mhz == 0)
-		max_phyclk_mhz = dcn3_21_soc.clock_limits[0].phyclk_mhz;
+	if (max_clk_data.phyclk_mhz == 0)
+		max_clk_data.phyclk_mhz = dcn3_2_soc.clock_limits[0].phyclk_mhz;
 
 	*num_entries = 0;
-	entry.dispclk_mhz = max_dispclk_mhz;
-	entry.dscclk_mhz = max_dispclk_mhz / 3;
-	entry.dppclk_mhz = max_dppclk_mhz;
-	entry.dtbclk_mhz = max_dtbclk_mhz;
-	entry.phyclk_mhz = max_phyclk_mhz;
-	entry.phyclk_d18_mhz = dcn3_21_soc.clock_limits[0].phyclk_d18_mhz;
-	entry.phyclk_d32_mhz = dcn3_21_soc.clock_limits[0].phyclk_d32_mhz;
+	entry.dispclk_mhz = max_clk_data.dispclk_mhz;
+	entry.dscclk_mhz = max_clk_data.dispclk_mhz / 3;
+	entry.dppclk_mhz = max_clk_data.dppclk_mhz;
+	entry.dtbclk_mhz = max_clk_data.dtbclk_mhz;
+	entry.phyclk_mhz = max_clk_data.phyclk_mhz;
+	entry.phyclk_d18_mhz = dcn3_2_soc.clock_limits[0].phyclk_d18_mhz;
+	entry.phyclk_d32_mhz = dcn3_2_soc.clock_limits[0].phyclk_d32_mhz;
 
 	// Insert all the DCFCLK STAs
 	for (i = 0; i < num_dcfclk_stas; i++) {
@@ -328,7 +387,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	}
 
 	// Insert the max DCFCLK
-	entry.dcfclk_mhz = max_dcfclk_mhz;
+	entry.dcfclk_mhz = max_clk_data.dcfclk_mhz;
 	entry.fabricclk_mhz = 0;
 	entry.dram_speed_mts = 0;
 
@@ -356,7 +415,7 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	// If FCLK fine grained, only insert max
 	else {
 		entry.dcfclk_mhz = 0;
-		entry.fabricclk_mhz = max_fclk_mhz;
+		entry.fabricclk_mhz = max_clk_data.fclk_mhz;
 		entry.dram_speed_mts = 0;
 
 		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
@@ -368,9 +427,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 
 	// Remove states that require higher clocks than are supported
 	for (i = *num_entries - 1; i >= 0 ; i--) {
-		if (table[i].dcfclk_mhz > max_dcfclk_mhz ||
-				table[i].fabricclk_mhz > max_fclk_mhz ||
-				table[i].dram_speed_mts > max_uclk_mhz * 16)
+		if (table[i].dcfclk_mhz > max_clk_data.dcfclk_mhz ||
+				table[i].fabricclk_mhz > max_clk_data.fclk_mhz ||
+				table[i].dram_speed_mts > max_clk_data.memclk_mhz * 16)
 			remove_entry_from_table_at_index(table, num_entries, i);
 	}
 
@@ -689,7 +748,8 @@ void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 			dcn3_21_soc.clock_limits[i].phyclk_d32_mhz = dcn3_21_soc.clock_limits[0].phyclk_d32_mhz;
 		}
 	} else {
-		build_synthetic_soc_states(bw_params, dcn3_21_soc.clock_limits, &dcn3_21_soc.num_states);
+		build_synthetic_soc_states(dc->debug.disable_dc_mode_overwrite, bw_params,
+			dcn3_21_soc.clock_limits, &dcn3_21_soc.num_states);
 	}
 
 	/* Re-init DML with updated bb */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
index bef843cc32a1..6faf40fa5c69 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h
@@ -233,6 +233,7 @@ struct clk_bw_params {
 	struct clk_limit_table clk_table;
 	struct wm_table wm_table;
 	struct dummy_pstate_entry dummy_pstate_table[4];
+	struct clk_limit_table_entry dc_mode_limit;
 };
 /* Public interfaces */
 
-- 
2.40.1

