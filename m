Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF095C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1371310FB7F;
	Sat, 16 Jul 2022 14:36:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0191E10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA3F33gRLGQAIjPRIZgnX9kQ/VjQX/91uU9ilt5wm6qT2gwcFl2pXwLT3VrN+0rEehCPCg3Pf868nYG1uFZHhuYc6TqqRX+RQw/AYpxfkRIu6siDDMFlKgW8isS0LpHSVYEfsgjE07dCnO6fZ39/5tPHFrkZikksWagP8M4NjxMOlAHUUFOwSncNGxyvkwC9+0VZKOsdGy+t2znHowxrwaMRSk1hlDGhffT1HMHLY1rp7Ddruh/zxXf1Uhn0Ny5AW3vtXBP6ttiZRueLfp2WnVEXbCG6RFWj1zbKby+Kq6DHREcqSZ6qU9D8rPvOTNBwaYfydgrMx7/xuNI5ax9+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMdDSRMcq9SIVz1eVXVDJeEzEK8871XUzeehxMEZEqo=;
 b=Kr8WLFkH6i9SiLFvtOj3jEZ7ZmPlu4l39JseGJsx3xCPYgC0XM3/7OpU0d5YKoIAjk/5qlgk1Ess03fYfWCTbZNjWICQ9qLnSOrbwOHimoOKtjboOyf7k27XOrwZy3llRfKjeCv9uR5Ck0JzglHSUWCYXCyXupHTsFfvhRgSLqy3Qo0J2llo9mlIkdxh4TI+VfuzutF3vTboVqSG/8bi16qRxWuET03Zy24jtkbt7OGicb9I/XNJUVwvXqg+J3LZfOGZ6qq3wBQ/1E0br1OShTr8CA/lj4eSkw89vgOOGACbXFAxHvkLKSQ2KQefvxgRvHLaVTYsm9UWq8Q8Ovkbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMdDSRMcq9SIVz1eVXVDJeEzEK8871XUzeehxMEZEqo=;
 b=M0vsgSnBwAE6PebLLFHFRGX7DU1roW5VCcp/emZ5lJQ4ovIBRAJDpDyvUo0ivNaXyIB9U0bnOK7KVctaZtMJhCuhwqKZJOX0XT0rP84oyJpRyrAKF38cI64y0+ypkSv9rIhGIMAdn1l4PLB9WsZNrPJk1XLiFGN21SAM25dORk4=
Received: from DS7PR03CA0324.namprd03.prod.outlook.com (2603:10b6:8:2b::24) by
 DM6PR12MB3851.namprd12.prod.outlook.com (2603:10b6:5:1c2::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.23; Fri, 15 Jul 2022 18:18:00 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::be) by DS7PR03CA0324.outlook.office365.com
 (2603:10b6:8:2b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12 via Frontend
 Transport; Fri, 15 Jul 2022 18:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 11:17:58 -0700
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:58 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/31] drm/amd/display: Drop FPU code from dcn321 resource
Date: Fri, 15 Jul 2022 14:17:04 -0400
Message-ID: <20220715181705.1030401-31-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 875d7a78-63c7-4dd7-761c-08da668e5978
X-MS-TrafficTypeDiagnostic: DM6PR12MB3851:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yH29OaPzePR79L0vRmvP0uitOm9ZFf7RneHO1oK7rpI+ugLjbHNtMb5zMiWEKuYDpDCKsHFhxvgQm2FpMZw5HljSFt9s0Qtlz6Haws8slxWUWnkhY9T9Zi+sIObRfcLv+wK+AC7Vbj2l3WTTuTxz8gmwPY4EnzIrmf9qEVPcnSpM93n2FUwFHAH8MeZFLnGnvyZnzrMCv1e06d6o3hWDfTOmJpknp8zvjDf3Sk6DjxvJ1hyUqqmbBw2IvRenfT4A5y+v+Ykxfe/lQ1ANmomquq9FDl7tAVux5HDonP6nAeC0/KX3vS8dqUQwG/s090CqnSBzfCsgRPpoeBmGuo1q0xjSaFxqfgfa5XNQWwFjTER+856O2jD7OP9AoeoF1baCBcK+7oTJjZcTip2hYWuhqXZIdgsPAF8BX1csZKHG6m0R35gz+r/00zErNImugjm6sRFZmURaqQlCTLHkOcStfvmzwTf1ofbc3mFocgbvefdIw9D4gGd0QK8kjEY27bKFTTYSmQHLzLN40TrOzNQdXCEezr2k5GkVkSJMVeVWyKz34FzsNj3rpddMlv96ukUGBlxAsMydjbPEa7tSQzCLLG4hWS2yf6iygUQQuO6TR83RKUinOM+KxAEqbWNuvMVjcWDb81+lZ1uLohXUo5vw6O2WBYy0G7b89TyMjkJYqFA68cAQYGsGfP4CCdmkcltcpvmbl3fdYL2GVGM1U0Hq7nWBOX/AJh2eVuQsyMFCvGpAPZIebngNIudxf57zboq3h4iweWZOBMZbQZC42OkugF492T/b77i3nZ7cSpalgf0sZ6eolrAvna+3brooF/ulqTB9L8aaGHTE07G/4TW2VAF2iJdE2VXpHZG0ToZCwA8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(40470700004)(70586007)(70206006)(82310400005)(2616005)(47076005)(356005)(1076003)(40460700003)(336012)(478600001)(426003)(6666004)(8676002)(186003)(316002)(6916009)(83380400001)(8936002)(86362001)(5660300002)(30864003)(81166007)(26005)(41300700001)(4326008)(54906003)(36860700001)(40480700001)(82740400003)(40140700001)(2906002)(36756003)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:59.7865 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 875d7a78-63c7-4dd7-761c-08da668e5978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3851
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This commit fully move the missing FPU operations from dcn321 resource
to dcn321 fpu. It also remove those FPU flags from the Makefile.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn321/Makefile    |  25 -
 .../amd/display/dc/dcn321/dcn321_resource.c   | 452 +-----------------
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    | 446 +++++++++++++++++
 .../amd/display/dc/dml/dcn321/dcn321_fpu.h    |   2 +
 4 files changed, 450 insertions(+), 475 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
index e554fd6c16f2..0a199c83bb5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/Makefile
@@ -12,31 +12,6 @@
 
 DCN321 = dcn321_resource.o dcn321_dio_link_encoder.o
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn321/dcn321_resource.o += -msse2
-endif
-endif
-
 AMD_DAL_DCN321 = $(addprefix $(AMDDALPATH)/dc/dcn321/,$(DCN321))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN321)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 6619bcb30de7..9ac0fcf79bed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1570,459 +1570,11 @@ static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
 
-
-static void dcn321_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
-		unsigned int *optimal_dcfclk,
-		unsigned int *optimal_fclk)
-{
-	double bw_from_dram, bw_from_dram1, bw_from_dram2;
-
-	bw_from_dram1 = uclk_mts * dcn3_21_soc.num_chans *
-		dcn3_21_soc.dram_channel_width_bytes * (dcn3_21_soc.max_avg_dram_bw_use_normal_percent / 100);
-	bw_from_dram2 = uclk_mts * dcn3_21_soc.num_chans *
-		dcn3_21_soc.dram_channel_width_bytes * (dcn3_21_soc.max_avg_sdp_bw_use_normal_percent / 100);
-
-	bw_from_dram = (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;
-
-	if (optimal_fclk)
-		*optimal_fclk = bw_from_dram /
-		(dcn3_21_soc.fabric_datapath_to_dcn_data_return_bytes * (dcn3_21_soc.max_avg_sdp_bw_use_normal_percent / 100));
-
-	if (optimal_dcfclk)
-		*optimal_dcfclk =  bw_from_dram /
-		(dcn3_21_soc.return_bus_width_bytes * (dcn3_21_soc.max_avg_sdp_bw_use_normal_percent / 100));
-}
-
-static void remove_entry_from_table_at_index(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries,
-		unsigned int index)
-{
-	int i;
-
-	if (*num_entries == 0)
-		return;
-
-	for (i = index; i < *num_entries - 1; i++) {
-		table[i] = table[i + 1];
-	}
-	memset(&table[--(*num_entries)], 0, sizeof(struct _vcs_dpi_voltage_scaling_st));
-}
-
-static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
-		struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
+static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	int i, j;
-	struct _vcs_dpi_voltage_scaling_st entry = {0};
-
-	unsigned int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0,
-			max_phyclk_mhz = 0, max_dtbclk_mhz = 0, max_fclk_mhz = 0, max_uclk_mhz = 0;
-
-	unsigned int min_dcfclk_mhz = 199, min_fclk_mhz = 299;
-
-	static const unsigned int num_dcfclk_stas = 5;
-	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {199, 615, 906, 1324, 1564};
-
-	unsigned int num_uclk_dpms = 0;
-	unsigned int num_fclk_dpms = 0;
-	unsigned int num_dcfclk_dpms = 0;
-
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
-
-		if (bw_params->clk_table.entries[i].memclk_mhz > 0)
-			num_uclk_dpms++;
-		if (bw_params->clk_table.entries[i].fclk_mhz > 0)
-			num_fclk_dpms++;
-		if (bw_params->clk_table.entries[i].dcfclk_mhz > 0)
-			num_dcfclk_dpms++;
-	}
-
-	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dtbclk_mhz)
-		return -1;
-
-	if (max_dppclk_mhz == 0)
-		max_dppclk_mhz = max_dispclk_mhz;
-
-	if (max_fclk_mhz == 0)
-		max_fclk_mhz = max_dcfclk_mhz * dcn3_21_soc.pct_ideal_sdp_bw_after_urgent / dcn3_21_soc.pct_ideal_fabric_bw_after_urgent;
-
-	if (max_phyclk_mhz == 0)
-		max_phyclk_mhz = dcn3_21_soc.clock_limits[0].phyclk_mhz;
-
-	*num_entries = 0;
-	entry.dispclk_mhz = max_dispclk_mhz;
-	entry.dscclk_mhz = max_dispclk_mhz / 3;
-	entry.dppclk_mhz = max_dppclk_mhz;
-	entry.dtbclk_mhz = max_dtbclk_mhz;
-	entry.phyclk_mhz = max_phyclk_mhz;
-	entry.phyclk_d18_mhz = dcn3_21_soc.clock_limits[0].phyclk_d18_mhz;
-	entry.phyclk_d32_mhz = dcn3_21_soc.clock_limits[0].phyclk_d32_mhz;
-
-	// Insert all the DCFCLK STAs
-	for (i = 0; i < num_dcfclk_stas; i++) {
-		entry.dcfclk_mhz = dcfclk_sta_targets[i];
-		entry.fabricclk_mhz = 0;
-		entry.dram_speed_mts = 0;
-
-		DC_FP_START();
-		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
-		DC_FP_END();
-	}
-
-	// Insert the max DCFCLK
-	entry.dcfclk_mhz = max_dcfclk_mhz;
-	entry.fabricclk_mhz = 0;
-	entry.dram_speed_mts = 0;
-
 	DC_FP_START();
-	dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
+	dcn321_update_bw_bounding_box_fpu(dc, bw_params);
 	DC_FP_END();
-
-	// Insert the UCLK DPMS
-	for (i = 0; i < num_uclk_dpms; i++) {
-		entry.dcfclk_mhz = 0;
-		entry.fabricclk_mhz = 0;
-		entry.dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
-
-		DC_FP_START();
-		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
-		DC_FP_END();
-	}
-
-	// If FCLK is coarse grained, insert individual DPMs.
-	if (num_fclk_dpms > 2) {
-		for (i = 0; i < num_fclk_dpms; i++) {
-			entry.dcfclk_mhz = 0;
-			entry.fabricclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
-			entry.dram_speed_mts = 0;
-
-			DC_FP_START();
-			dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
-			DC_FP_END();
-		}
-	}
-	// If FCLK fine grained, only insert max
-	else {
-		entry.dcfclk_mhz = 0;
-		entry.fabricclk_mhz = max_fclk_mhz;
-		entry.dram_speed_mts = 0;
-
-		DC_FP_START();
-		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
-		DC_FP_END();
-	}
-
-	// At this point, the table contains all "points of interest" based on
-	// DPMs from PMFW, and STAs.  Table is sorted by BW, and all clock
-	// ratios (by derate, are exact).
-
-	// Remove states that require higher clocks than are supported
-	for (i = *num_entries - 1; i >= 0 ; i--) {
-		if (table[i].dcfclk_mhz > max_dcfclk_mhz ||
-				table[i].fabricclk_mhz > max_fclk_mhz ||
-				table[i].dram_speed_mts > max_uclk_mhz * 16)
-			remove_entry_from_table_at_index(table, num_entries, i);
-	}
-
-	// At this point, the table only contains supported points of interest
-	// it could be used as is, but some states may be redundant due to
-	// coarse grained nature of some clocks, so we want to round up to
-	// coarse grained DPMs and remove duplicates.
-
-	// Round up UCLKs
-	for (i = *num_entries - 1; i >= 0 ; i--) {
-		for (j = 0; j < num_uclk_dpms; j++) {
-			if (bw_params->clk_table.entries[j].memclk_mhz * 16 >= table[i].dram_speed_mts) {
-				table[i].dram_speed_mts = bw_params->clk_table.entries[j].memclk_mhz * 16;
-				break;
-			}
-		}
-	}
-
-	// If FCLK is coarse grained, round up to next DPMs
-	if (num_fclk_dpms > 2) {
-		for (i = *num_entries - 1; i >= 0 ; i--) {
-			for (j = 0; j < num_fclk_dpms; j++) {
-				if (bw_params->clk_table.entries[j].fclk_mhz >= table[i].fabricclk_mhz) {
-					table[i].fabricclk_mhz = bw_params->clk_table.entries[j].fclk_mhz;
-					break;
-				}
-			}
-		}
-	}
-	// Otherwise, round up to minimum.
-	else {
-		for (i = *num_entries - 1; i >= 0 ; i--) {
-			if (table[i].fabricclk_mhz < min_fclk_mhz) {
-				table[i].fabricclk_mhz = min_fclk_mhz;
-				break;
-			}
-		}
-	}
-
-	// Round DCFCLKs up to minimum
-	for (i = *num_entries - 1; i >= 0 ; i--) {
-		if (table[i].dcfclk_mhz < min_dcfclk_mhz) {
-			table[i].dcfclk_mhz = min_dcfclk_mhz;
-			break;
-		}
-	}
-
-	// Remove duplicate states, note duplicate states are always neighbouring since table is sorted.
-	i = 0;
-	while (i < *num_entries - 1) {
-		if (table[i].dcfclk_mhz == table[i + 1].dcfclk_mhz &&
-				table[i].fabricclk_mhz == table[i + 1].fabricclk_mhz &&
-				table[i].dram_speed_mts == table[i + 1].dram_speed_mts)
-			remove_entry_from_table_at_index(table, num_entries, i + 1);
-		else
-			i++;
-	}
-
-	// Fix up the state indicies
-	for (i = *num_entries - 1; i >= 0 ; i--) {
-		table[i].state = i;
-	}
-
-	return 0;
-}
-
-/* dcn321_update_bw_bounding_box
- * This would override some dcn3_2 ip_or_soc initial parameters hardcoded from spreadsheet
- * with actual values as per dGPU SKU:
- * -with passed few options from dc->config
- * -with dentist_vco_frequency from Clk Mgr (currently hardcoded, but might need to get it from PM FW)
- * -with passed latency values (passed in ns units) in dc-> bb override for debugging purposes
- * -with passed latencies from VBIOS (in 100_ns units) if available for certain dGPU SKU
- * -with number of DRAM channels from VBIOS (which differ for certain dGPU SKU of the same ASIC)
- * -clocks levels with passed clk_table entries from Clk Mgr as reported by PM FW for different
- *  clocks (which might differ for certain dGPU SKU of the same ASIC)
- */
-static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-{
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
-		/* Overrides from dc->config options */
-		dcn3_21_ip.clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
-
-		/* Override from passed dc->bb_overrides if available*/
-		if ((int)(dcn3_21_soc.sr_exit_time_us * 1000) != dc->bb_overrides.sr_exit_time_ns
-				&& dc->bb_overrides.sr_exit_time_ns) {
-			dcn3_21_soc.sr_exit_time_us = dc->bb_overrides.sr_exit_time_ns / 1000.0;
-		}
-
-		if ((int)(dcn3_21_soc.sr_enter_plus_exit_time_us * 1000)
-				!= dc->bb_overrides.sr_enter_plus_exit_time_ns
-				&& dc->bb_overrides.sr_enter_plus_exit_time_ns) {
-			dcn3_21_soc.sr_enter_plus_exit_time_us =
-				dc->bb_overrides.sr_enter_plus_exit_time_ns / 1000.0;
-		}
-
-		if ((int)(dcn3_21_soc.urgent_latency_us * 1000) != dc->bb_overrides.urgent_latency_ns
-			&& dc->bb_overrides.urgent_latency_ns) {
-			dcn3_21_soc.urgent_latency_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
-		}
-
-		if ((int)(dcn3_21_soc.dram_clock_change_latency_us * 1000)
-				!= dc->bb_overrides.dram_clock_change_latency_ns
-				&& dc->bb_overrides.dram_clock_change_latency_ns) {
-			dcn3_21_soc.dram_clock_change_latency_us =
-				dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
-		}
-
-		if ((int)(dcn3_21_soc.dummy_pstate_latency_us * 1000)
-				!= dc->bb_overrides.dummy_clock_change_latency_ns
-				&& dc->bb_overrides.dummy_clock_change_latency_ns) {
-			dcn3_21_soc.dummy_pstate_latency_us =
-				dc->bb_overrides.dummy_clock_change_latency_ns / 1000.0;
-		}
-
-		/* Override from VBIOS if VBIOS bb_info available */
-		if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
-			struct bp_soc_bb_info bb_info = {0};
-
-			if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
-				if (bb_info.dram_clock_change_latency_100ns > 0)
-					dcn3_21_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
-
-			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
-				dcn3_21_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
-
-			if (bb_info.dram_sr_exit_latency_100ns > 0)
-				dcn3_21_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
-			}
-		}
-
-		/* Override from VBIOS for num_chan */
-		if (dc->ctx->dc_bios->vram_info.num_chans)
-			dcn3_21_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
-
-		if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
-			dcn3_21_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
-
-	}
-
-	/* Override dispclk_dppclk_vco_speed_mhz from Clk Mgr */
-	dcn3_21_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
-	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
-
-	/* Overrides Clock levelsfrom CLK Mgr table entries as reported by PM FW */
-	if ((!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) && (bw_params->clk_table.entries[0].memclk_mhz)) {
-		if (dc->debug.use_legacy_soc_bb_mechanism) {
-			unsigned int i = 0, j = 0, num_states = 0;
-
-			unsigned int dcfclk_mhz[DC__VOLTAGE_STATES] = {0};
-			unsigned int dram_speed_mts[DC__VOLTAGE_STATES] = {0};
-			unsigned int optimal_uclk_for_dcfclk_sta_targets[DC__VOLTAGE_STATES] = {0};
-			unsigned int optimal_dcfclk_for_uclk[DC__VOLTAGE_STATES] = {0};
-
-			unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {615, 906, 1324, 1564};
-			unsigned int num_dcfclk_sta_targets = 4, num_uclk_states = 0;
-			unsigned int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0;
-
-			for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
-				if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
-					max_dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
-				if (bw_params->clk_table.entries[i].dispclk_mhz > max_dispclk_mhz)
-					max_dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
-				if (bw_params->clk_table.entries[i].dppclk_mhz > max_dppclk_mhz)
-					max_dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
-				if (bw_params->clk_table.entries[i].phyclk_mhz > max_phyclk_mhz)
-					max_phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
-			}
-			if (!max_dcfclk_mhz)
-				max_dcfclk_mhz = dcn3_21_soc.clock_limits[0].dcfclk_mhz;
-			if (!max_dispclk_mhz)
-				max_dispclk_mhz = dcn3_21_soc.clock_limits[0].dispclk_mhz;
-			if (!max_dppclk_mhz)
-				max_dppclk_mhz = dcn3_21_soc.clock_limits[0].dppclk_mhz;
-			if (!max_phyclk_mhz)
-				max_phyclk_mhz = dcn3_21_soc.clock_limits[0].phyclk_mhz;
-
-			if (max_dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
-				// If max DCFCLK is greater than the max DCFCLK STA target, insert into the DCFCLK STA target array
-				dcfclk_sta_targets[num_dcfclk_sta_targets] = max_dcfclk_mhz;
-				num_dcfclk_sta_targets++;
-			} else if (max_dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
-				// If max DCFCLK is less than the max DCFCLK STA target, cap values and remove duplicates
-				for (i = 0; i < num_dcfclk_sta_targets; i++) {
-					if (dcfclk_sta_targets[i] > max_dcfclk_mhz) {
-						dcfclk_sta_targets[i] = max_dcfclk_mhz;
-						break;
-					}
-				}
-				// Update size of array since we "removed" duplicates
-				num_dcfclk_sta_targets = i + 1;
-			}
-
-			num_uclk_states = bw_params->clk_table.num_entries;
-
-			// Calculate optimal dcfclk for each uclk
-			for (i = 0; i < num_uclk_states; i++) {
-				dcn321_get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
-						&optimal_dcfclk_for_uclk[i], NULL);
-				if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz) {
-					optimal_dcfclk_for_uclk[i] = bw_params->clk_table.entries[0].dcfclk_mhz;
-				}
-			}
-
-			// Calculate optimal uclk for each dcfclk sta target
-			for (i = 0; i < num_dcfclk_sta_targets; i++) {
-				for (j = 0; j < num_uclk_states; j++) {
-					if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
-						optimal_uclk_for_dcfclk_sta_targets[i] =
-								bw_params->clk_table.entries[j].memclk_mhz * 16;
-						break;
-					}
-				}
-			}
-
-			i = 0;
-			j = 0;
-			// create the final dcfclk and uclk table
-			while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
-				if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
-					dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
-					dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
-				} else {
-					if (j < num_uclk_states && optimal_dcfclk_for_uclk[j] <= max_dcfclk_mhz) {
-						dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
-						dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
-					} else {
-						j = num_uclk_states;
-					}
-				}
-			}
-
-			while (i < num_dcfclk_sta_targets && num_states < DC__VOLTAGE_STATES) {
-				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
-				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
-			}
-
-			while (j < num_uclk_states && num_states < DC__VOLTAGE_STATES &&
-					optimal_dcfclk_for_uclk[j] <= max_dcfclk_mhz) {
-				dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
-				dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
-			}
-
-			dcn3_21_soc.num_states = num_states;
-			for (i = 0; i < dcn3_21_soc.num_states; i++) {
-				dcn3_21_soc.clock_limits[i].state = i;
-				dcn3_21_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
-				dcn3_21_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
-
-				/* Fill all states with max values of all these clocks */
-				dcn3_21_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz;
-				dcn3_21_soc.clock_limits[i].dppclk_mhz  = max_dppclk_mhz;
-				dcn3_21_soc.clock_limits[i].phyclk_mhz  = max_phyclk_mhz;
-				dcn3_21_soc.clock_limits[i].dscclk_mhz  = max_dispclk_mhz / 3;
-
-				/* Populate from bw_params for DTBCLK, SOCCLK */
-				if (i > 0) {
-					if (!bw_params->clk_table.entries[i].dtbclk_mhz) {
-						dcn3_21_soc.clock_limits[i].dtbclk_mhz  = dcn3_21_soc.clock_limits[i-1].dtbclk_mhz;
-					} else {
-						dcn3_21_soc.clock_limits[i].dtbclk_mhz  = bw_params->clk_table.entries[i].dtbclk_mhz;
-					}
-				} else if (bw_params->clk_table.entries[i].dtbclk_mhz) {
-					dcn3_21_soc.clock_limits[i].dtbclk_mhz  = bw_params->clk_table.entries[i].dtbclk_mhz;
-				}
-
-				if (!bw_params->clk_table.entries[i].socclk_mhz && i > 0)
-					dcn3_21_soc.clock_limits[i].socclk_mhz = dcn3_21_soc.clock_limits[i-1].socclk_mhz;
-				else
-					dcn3_21_soc.clock_limits[i].socclk_mhz = bw_params->clk_table.entries[i].socclk_mhz;
-
-				if (!dram_speed_mts[i] && i > 0)
-					dcn3_21_soc.clock_limits[i].dram_speed_mts = dcn3_21_soc.clock_limits[i-1].dram_speed_mts;
-				else
-					dcn3_21_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
-
-				/* These clocks cannot come from bw_params, always fill from dcn3_21_soc[0] */
-				/* PHYCLK_D18, PHYCLK_D32 */
-				dcn3_21_soc.clock_limits[i].phyclk_d18_mhz = dcn3_21_soc.clock_limits[0].phyclk_d18_mhz;
-				dcn3_21_soc.clock_limits[i].phyclk_d32_mhz = dcn3_21_soc.clock_limits[0].phyclk_d32_mhz;
-			}
-		} else {
-			build_synthetic_soc_states(bw_params, dcn3_21_soc.clock_limits, &dcn3_21_soc.num_states);
-		}
-
-		/* Re-init DML with updated bb */
-		dml_init_instance(&dc->dml, &dcn3_21_soc, &dcn3_21_ip, DML_PROJECT_DCN32);
-		if (dc->current_state)
-			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_21_soc, &dcn3_21_ip, DML_PROJECT_DCN32);
-	}
 }
 
 static struct resource_funcs dcn321_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index 78408698985b..6e72336b7975 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -24,6 +24,7 @@
  *
  */
 
+#include "clk_mgr.h"
 #include "resource.h"
 #include "dcn321_fpu.h"
 #include "dcn32/dcn32_resource.h"
@@ -236,3 +237,448 @@ void dcn321_insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *t
 	}
 }
 
+static void remove_entry_from_table_at_index(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries,
+		unsigned int index)
+{
+	int i;
+
+	if (*num_entries == 0)
+		return;
+
+	for (i = index; i < *num_entries - 1; i++) {
+		table[i] = table[i + 1];
+	}
+	memset(&table[--(*num_entries)], 0, sizeof(struct _vcs_dpi_voltage_scaling_st));
+}
+
+static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
+		struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
+{
+	int i, j;
+	struct _vcs_dpi_voltage_scaling_st entry = {0};
+
+	unsigned int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0,
+			max_phyclk_mhz = 0, max_dtbclk_mhz = 0, max_fclk_mhz = 0, max_uclk_mhz = 0;
+
+	unsigned int min_dcfclk_mhz = 199, min_fclk_mhz = 299;
+
+	static const unsigned int num_dcfclk_stas = 5;
+	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {199, 615, 906, 1324, 1564};
+
+	unsigned int num_uclk_dpms = 0;
+	unsigned int num_fclk_dpms = 0;
+	unsigned int num_dcfclk_dpms = 0;
+
+	for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
+		if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
+			max_dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
+		if (bw_params->clk_table.entries[i].fclk_mhz > max_fclk_mhz)
+			max_fclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
+		if (bw_params->clk_table.entries[i].memclk_mhz > max_uclk_mhz)
+			max_uclk_mhz = bw_params->clk_table.entries[i].memclk_mhz;
+		if (bw_params->clk_table.entries[i].dispclk_mhz > max_dispclk_mhz)
+			max_dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
+		if (bw_params->clk_table.entries[i].dppclk_mhz > max_dppclk_mhz)
+			max_dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
+		if (bw_params->clk_table.entries[i].phyclk_mhz > max_phyclk_mhz)
+			max_phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
+		if (bw_params->clk_table.entries[i].dtbclk_mhz > max_dtbclk_mhz)
+			max_dtbclk_mhz = bw_params->clk_table.entries[i].dtbclk_mhz;
+
+		if (bw_params->clk_table.entries[i].memclk_mhz > 0)
+			num_uclk_dpms++;
+		if (bw_params->clk_table.entries[i].fclk_mhz > 0)
+			num_fclk_dpms++;
+		if (bw_params->clk_table.entries[i].dcfclk_mhz > 0)
+			num_dcfclk_dpms++;
+	}
+
+	if (!max_dcfclk_mhz || !max_dispclk_mhz || !max_dtbclk_mhz)
+		return -1;
+
+	if (max_dppclk_mhz == 0)
+		max_dppclk_mhz = max_dispclk_mhz;
+
+	if (max_fclk_mhz == 0)
+		max_fclk_mhz = max_dcfclk_mhz * dcn3_21_soc.pct_ideal_sdp_bw_after_urgent / dcn3_21_soc.pct_ideal_fabric_bw_after_urgent;
+
+	if (max_phyclk_mhz == 0)
+		max_phyclk_mhz = dcn3_21_soc.clock_limits[0].phyclk_mhz;
+
+	*num_entries = 0;
+	entry.dispclk_mhz = max_dispclk_mhz;
+	entry.dscclk_mhz = max_dispclk_mhz / 3;
+	entry.dppclk_mhz = max_dppclk_mhz;
+	entry.dtbclk_mhz = max_dtbclk_mhz;
+	entry.phyclk_mhz = max_phyclk_mhz;
+	entry.phyclk_d18_mhz = dcn3_21_soc.clock_limits[0].phyclk_d18_mhz;
+	entry.phyclk_d32_mhz = dcn3_21_soc.clock_limits[0].phyclk_d32_mhz;
+
+	// Insert all the DCFCLK STAs
+	for (i = 0; i < num_dcfclk_stas; i++) {
+		entry.dcfclk_mhz = dcfclk_sta_targets[i];
+		entry.fabricclk_mhz = 0;
+		entry.dram_speed_mts = 0;
+
+		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
+	}
+
+	// Insert the max DCFCLK
+	entry.dcfclk_mhz = max_dcfclk_mhz;
+	entry.fabricclk_mhz = 0;
+	entry.dram_speed_mts = 0;
+
+	dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
+
+	// Insert the UCLK DPMS
+	for (i = 0; i < num_uclk_dpms; i++) {
+		entry.dcfclk_mhz = 0;
+		entry.fabricclk_mhz = 0;
+		entry.dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
+
+		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
+	}
+
+	// If FCLK is coarse grained, insert individual DPMs.
+	if (num_fclk_dpms > 2) {
+		for (i = 0; i < num_fclk_dpms; i++) {
+			entry.dcfclk_mhz = 0;
+			entry.fabricclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
+			entry.dram_speed_mts = 0;
+
+			dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
+		}
+	}
+	// If FCLK fine grained, only insert max
+	else {
+		entry.dcfclk_mhz = 0;
+		entry.fabricclk_mhz = max_fclk_mhz;
+		entry.dram_speed_mts = 0;
+
+		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
+	}
+
+	// At this point, the table contains all "points of interest" based on
+	// DPMs from PMFW, and STAs.  Table is sorted by BW, and all clock
+	// ratios (by derate, are exact).
+
+	// Remove states that require higher clocks than are supported
+	for (i = *num_entries - 1; i >= 0 ; i--) {
+		if (table[i].dcfclk_mhz > max_dcfclk_mhz ||
+				table[i].fabricclk_mhz > max_fclk_mhz ||
+				table[i].dram_speed_mts > max_uclk_mhz * 16)
+			remove_entry_from_table_at_index(table, num_entries, i);
+	}
+
+	// At this point, the table only contains supported points of interest
+	// it could be used as is, but some states may be redundant due to
+	// coarse grained nature of some clocks, so we want to round up to
+	// coarse grained DPMs and remove duplicates.
+
+	// Round up UCLKs
+	for (i = *num_entries - 1; i >= 0 ; i--) {
+		for (j = 0; j < num_uclk_dpms; j++) {
+			if (bw_params->clk_table.entries[j].memclk_mhz * 16 >= table[i].dram_speed_mts) {
+				table[i].dram_speed_mts = bw_params->clk_table.entries[j].memclk_mhz * 16;
+				break;
+			}
+		}
+	}
+
+	// If FCLK is coarse grained, round up to next DPMs
+	if (num_fclk_dpms > 2) {
+		for (i = *num_entries - 1; i >= 0 ; i--) {
+			for (j = 0; j < num_fclk_dpms; j++) {
+				if (bw_params->clk_table.entries[j].fclk_mhz >= table[i].fabricclk_mhz) {
+					table[i].fabricclk_mhz = bw_params->clk_table.entries[j].fclk_mhz;
+					break;
+				}
+			}
+		}
+	}
+	// Otherwise, round up to minimum.
+	else {
+		for (i = *num_entries - 1; i >= 0 ; i--) {
+			if (table[i].fabricclk_mhz < min_fclk_mhz) {
+				table[i].fabricclk_mhz = min_fclk_mhz;
+				break;
+			}
+		}
+	}
+
+	// Round DCFCLKs up to minimum
+	for (i = *num_entries - 1; i >= 0 ; i--) {
+		if (table[i].dcfclk_mhz < min_dcfclk_mhz) {
+			table[i].dcfclk_mhz = min_dcfclk_mhz;
+			break;
+		}
+	}
+
+	// Remove duplicate states, note duplicate states are always neighbouring since table is sorted.
+	i = 0;
+	while (i < *num_entries - 1) {
+		if (table[i].dcfclk_mhz == table[i + 1].dcfclk_mhz &&
+				table[i].fabricclk_mhz == table[i + 1].fabricclk_mhz &&
+				table[i].dram_speed_mts == table[i + 1].dram_speed_mts)
+			remove_entry_from_table_at_index(table, num_entries, i + 1);
+		else
+			i++;
+	}
+
+	// Fix up the state indicies
+	for (i = *num_entries - 1; i >= 0 ; i--) {
+		table[i].state = i;
+	}
+
+	return 0;
+}
+
+static void dcn321_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
+		unsigned int *optimal_dcfclk,
+		unsigned int *optimal_fclk)
+{
+	double bw_from_dram, bw_from_dram1, bw_from_dram2;
+
+	bw_from_dram1 = uclk_mts * dcn3_21_soc.num_chans *
+		dcn3_21_soc.dram_channel_width_bytes * (dcn3_21_soc.max_avg_dram_bw_use_normal_percent / 100);
+	bw_from_dram2 = uclk_mts * dcn3_21_soc.num_chans *
+		dcn3_21_soc.dram_channel_width_bytes * (dcn3_21_soc.max_avg_sdp_bw_use_normal_percent / 100);
+
+	bw_from_dram = (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;
+
+	if (optimal_fclk)
+		*optimal_fclk = bw_from_dram /
+		(dcn3_21_soc.fabric_datapath_to_dcn_data_return_bytes * (dcn3_21_soc.max_avg_sdp_bw_use_normal_percent / 100));
+
+	if (optimal_dcfclk)
+		*optimal_dcfclk =  bw_from_dram /
+		(dcn3_21_soc.return_bus_width_bytes * (dcn3_21_soc.max_avg_sdp_bw_use_normal_percent / 100));
+}
+
+/** dcn321_update_bw_bounding_box
+ * This would override some dcn3_2 ip_or_soc initial parameters hardcoded from spreadsheet
+ * with actual values as per dGPU SKU:
+ * -with passed few options from dc->config
+ * -with dentist_vco_frequency from Clk Mgr (currently hardcoded, but might need to get it from PM FW)
+ * -with passed latency values (passed in ns units) in dc-> bb override for debugging purposes
+ * -with passed latencies from VBIOS (in 100_ns units) if available for certain dGPU SKU
+ * -with number of DRAM channels from VBIOS (which differ for certain dGPU SKU of the same ASIC)
+ * -clocks levels with passed clk_table entries from Clk Mgr as reported by PM FW for different
+ *  clocks (which might differ for certain dGPU SKU of the same ASIC)
+ */
+void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	dc_assert_fp_enabled();
+	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) {
+		/* Overrides from dc->config options */
+		dcn3_21_ip.clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
+
+		/* Override from passed dc->bb_overrides if available*/
+		if ((int)(dcn3_21_soc.sr_exit_time_us * 1000) != dc->bb_overrides.sr_exit_time_ns
+				&& dc->bb_overrides.sr_exit_time_ns) {
+			dcn3_21_soc.sr_exit_time_us = dc->bb_overrides.sr_exit_time_ns / 1000.0;
+		}
+
+		if ((int)(dcn3_21_soc.sr_enter_plus_exit_time_us * 1000)
+				!= dc->bb_overrides.sr_enter_plus_exit_time_ns
+				&& dc->bb_overrides.sr_enter_plus_exit_time_ns) {
+			dcn3_21_soc.sr_enter_plus_exit_time_us =
+				dc->bb_overrides.sr_enter_plus_exit_time_ns / 1000.0;
+		}
+
+		if ((int)(dcn3_21_soc.urgent_latency_us * 1000) != dc->bb_overrides.urgent_latency_ns
+			&& dc->bb_overrides.urgent_latency_ns) {
+			dcn3_21_soc.urgent_latency_us = dc->bb_overrides.urgent_latency_ns / 1000.0;
+		}
+
+		if ((int)(dcn3_21_soc.dram_clock_change_latency_us * 1000)
+				!= dc->bb_overrides.dram_clock_change_latency_ns
+				&& dc->bb_overrides.dram_clock_change_latency_ns) {
+			dcn3_21_soc.dram_clock_change_latency_us =
+				dc->bb_overrides.dram_clock_change_latency_ns / 1000.0;
+		}
+
+		if ((int)(dcn3_21_soc.dummy_pstate_latency_us * 1000)
+				!= dc->bb_overrides.dummy_clock_change_latency_ns
+				&& dc->bb_overrides.dummy_clock_change_latency_ns) {
+			dcn3_21_soc.dummy_pstate_latency_us =
+				dc->bb_overrides.dummy_clock_change_latency_ns / 1000.0;
+		}
+
+		/* Override from VBIOS if VBIOS bb_info available */
+		if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
+			struct bp_soc_bb_info bb_info = {0};
+
+			if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
+				if (bb_info.dram_clock_change_latency_100ns > 0)
+					dcn3_21_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
+
+			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+				dcn3_21_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
+
+			if (bb_info.dram_sr_exit_latency_100ns > 0)
+				dcn3_21_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
+			}
+		}
+
+		/* Override from VBIOS for num_chan */
+		if (dc->ctx->dc_bios->vram_info.num_chans)
+			dcn3_21_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
+
+		if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
+			dcn3_21_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
+
+	}
+
+	/* Override dispclk_dppclk_vco_speed_mhz from Clk Mgr */
+	dcn3_21_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+
+	/* Overrides Clock levelsfrom CLK Mgr table entries as reported by PM FW */
+	if ((!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment)) && (bw_params->clk_table.entries[0].memclk_mhz)) {
+		if (dc->debug.use_legacy_soc_bb_mechanism) {
+			unsigned int i = 0, j = 0, num_states = 0;
+
+			unsigned int dcfclk_mhz[DC__VOLTAGE_STATES] = {0};
+			unsigned int dram_speed_mts[DC__VOLTAGE_STATES] = {0};
+			unsigned int optimal_uclk_for_dcfclk_sta_targets[DC__VOLTAGE_STATES] = {0};
+			unsigned int optimal_dcfclk_for_uclk[DC__VOLTAGE_STATES] = {0};
+
+			unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {615, 906, 1324, 1564};
+			unsigned int num_dcfclk_sta_targets = 4, num_uclk_states = 0;
+			unsigned int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0;
+
+			for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
+				if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
+					max_dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
+				if (bw_params->clk_table.entries[i].dispclk_mhz > max_dispclk_mhz)
+					max_dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
+				if (bw_params->clk_table.entries[i].dppclk_mhz > max_dppclk_mhz)
+					max_dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
+				if (bw_params->clk_table.entries[i].phyclk_mhz > max_phyclk_mhz)
+					max_phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
+			}
+			if (!max_dcfclk_mhz)
+				max_dcfclk_mhz = dcn3_21_soc.clock_limits[0].dcfclk_mhz;
+			if (!max_dispclk_mhz)
+				max_dispclk_mhz = dcn3_21_soc.clock_limits[0].dispclk_mhz;
+			if (!max_dppclk_mhz)
+				max_dppclk_mhz = dcn3_21_soc.clock_limits[0].dppclk_mhz;
+			if (!max_phyclk_mhz)
+				max_phyclk_mhz = dcn3_21_soc.clock_limits[0].phyclk_mhz;
+
+			if (max_dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+				// If max DCFCLK is greater than the max DCFCLK STA target, insert into the DCFCLK STA target array
+				dcfclk_sta_targets[num_dcfclk_sta_targets] = max_dcfclk_mhz;
+				num_dcfclk_sta_targets++;
+			} else if (max_dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+				// If max DCFCLK is less than the max DCFCLK STA target, cap values and remove duplicates
+				for (i = 0; i < num_dcfclk_sta_targets; i++) {
+					if (dcfclk_sta_targets[i] > max_dcfclk_mhz) {
+						dcfclk_sta_targets[i] = max_dcfclk_mhz;
+						break;
+					}
+				}
+				// Update size of array since we "removed" duplicates
+				num_dcfclk_sta_targets = i + 1;
+			}
+
+			num_uclk_states = bw_params->clk_table.num_entries;
+
+			// Calculate optimal dcfclk for each uclk
+			for (i = 0; i < num_uclk_states; i++) {
+				dcn321_get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
+						&optimal_dcfclk_for_uclk[i], NULL);
+				if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz) {
+					optimal_dcfclk_for_uclk[i] = bw_params->clk_table.entries[0].dcfclk_mhz;
+				}
+			}
+
+			// Calculate optimal uclk for each dcfclk sta target
+			for (i = 0; i < num_dcfclk_sta_targets; i++) {
+				for (j = 0; j < num_uclk_states; j++) {
+					if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
+						optimal_uclk_for_dcfclk_sta_targets[i] =
+								bw_params->clk_table.entries[j].memclk_mhz * 16;
+						break;
+					}
+				}
+			}
+
+			i = 0;
+			j = 0;
+			// create the final dcfclk and uclk table
+			while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
+				if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
+					dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
+					dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
+				} else {
+					if (j < num_uclk_states && optimal_dcfclk_for_uclk[j] <= max_dcfclk_mhz) {
+						dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
+						dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
+					} else {
+						j = num_uclk_states;
+					}
+				}
+			}
+
+			while (i < num_dcfclk_sta_targets && num_states < DC__VOLTAGE_STATES) {
+				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
+				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
+			}
+
+			while (j < num_uclk_states && num_states < DC__VOLTAGE_STATES &&
+					optimal_dcfclk_for_uclk[j] <= max_dcfclk_mhz) {
+				dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
+				dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
+			}
+
+			dcn3_21_soc.num_states = num_states;
+			for (i = 0; i < dcn3_21_soc.num_states; i++) {
+				dcn3_21_soc.clock_limits[i].state = i;
+				dcn3_21_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
+				dcn3_21_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
+
+				/* Fill all states with max values of all these clocks */
+				dcn3_21_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz;
+				dcn3_21_soc.clock_limits[i].dppclk_mhz  = max_dppclk_mhz;
+				dcn3_21_soc.clock_limits[i].phyclk_mhz  = max_phyclk_mhz;
+				dcn3_21_soc.clock_limits[i].dscclk_mhz  = max_dispclk_mhz / 3;
+
+				/* Populate from bw_params for DTBCLK, SOCCLK */
+				if (i > 0) {
+					if (!bw_params->clk_table.entries[i].dtbclk_mhz) {
+						dcn3_21_soc.clock_limits[i].dtbclk_mhz  = dcn3_21_soc.clock_limits[i-1].dtbclk_mhz;
+					} else {
+						dcn3_21_soc.clock_limits[i].dtbclk_mhz  = bw_params->clk_table.entries[i].dtbclk_mhz;
+					}
+				} else if (bw_params->clk_table.entries[i].dtbclk_mhz) {
+					dcn3_21_soc.clock_limits[i].dtbclk_mhz  = bw_params->clk_table.entries[i].dtbclk_mhz;
+				}
+
+				if (!bw_params->clk_table.entries[i].socclk_mhz && i > 0)
+					dcn3_21_soc.clock_limits[i].socclk_mhz = dcn3_21_soc.clock_limits[i-1].socclk_mhz;
+				else
+					dcn3_21_soc.clock_limits[i].socclk_mhz = bw_params->clk_table.entries[i].socclk_mhz;
+
+				if (!dram_speed_mts[i] && i > 0)
+					dcn3_21_soc.clock_limits[i].dram_speed_mts = dcn3_21_soc.clock_limits[i-1].dram_speed_mts;
+				else
+					dcn3_21_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
+
+				/* These clocks cannot come from bw_params, always fill from dcn3_21_soc[0] */
+				/* PHYCLK_D18, PHYCLK_D32 */
+				dcn3_21_soc.clock_limits[i].phyclk_d18_mhz = dcn3_21_soc.clock_limits[0].phyclk_d18_mhz;
+				dcn3_21_soc.clock_limits[i].phyclk_d32_mhz = dcn3_21_soc.clock_limits[0].phyclk_d32_mhz;
+			}
+		} else {
+			build_synthetic_soc_states(bw_params, dcn3_21_soc.clock_limits, &dcn3_21_soc.num_states);
+		}
+
+		/* Re-init DML with updated bb */
+		dml_init_instance(&dc->dml, &dcn3_21_soc, &dcn3_21_ip, DML_PROJECT_DCN32);
+		if (dc->current_state)
+			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_21_soc, &dcn3_21_ip, DML_PROJECT_DCN32);
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h
index 5b6b28526e18..e8fad9b4be69 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h
@@ -33,4 +33,6 @@ void dcn321_insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *t
 					   unsigned int *num_entries,
 					   struct _vcs_dpi_voltage_scaling_st *entry);
 
+void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params);
+
 #endif
-- 
2.37.0

