Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67B8EB64D8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jun 2023 17:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E23DB10E155;
	Wed, 14 Jun 2023 17:58:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75AEA10E14D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jun 2023 17:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdWlbBrICvWK9PMiYGSTocX1jszXUwl9zUz/mQFl2ui7tWVe8eEJUBLrNV9NLIZ54hSF4nObjHKHIMPisI+nrm3vefReUi45AS7DSV1J6pMlOpJyR62kWbEO+0EHO5S8uuFZLUWU+5Mxjc4hg3rV020TX7Oq6qOLd2Q9OdHfIjpUlP4tpY+cMsbJlgNGMWEDBzPdi9GlgEufiF5w466YiPbX9njtHOh/eo3Lb2kYdwqQoKHI1+s/uBoQ63+4mFGLW2WQDRAinUUd08lJKGhAyfvtIAbpxF4c+mb83gTvrmk4AgzeYRcMeC93NTiU16HFhr4diA0s42HlCvRCoXb2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SO5oLnCUhPdnCoUsJJFCCR2nfxgC82afrb0+fXpzh6I=;
 b=egoHghl/Qp6SNR3lXgxeerNqrm09nUe9zOqRRXY14ivwFaZ9KmVNeJe2IvMHhLyNUZG2KX+kidCfgqimXE8bWFFnesG/QeO2dQKu0DDDhmqiVW6J/D6cznta9Stzi1skdTJMUbbh6IF8BBPfrDoZUJyCAM9oFdd1DUM2Q+vCP2c3iqSCdrdRQkgUZ1NvLP90qax64NJE4Y+qNn6168sMHlX3eY6w8pTlVJ6lpkVZuJw+l7tp/hQocwg8XhXu565lJTclqvy/50saAqwwrjbvd+Jf+tYFMy6awVwpOqwh6y1cavgjwzapjnm3nQf8TBRw5lMH6bZCUibnUiKx6Zny0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SO5oLnCUhPdnCoUsJJFCCR2nfxgC82afrb0+fXpzh6I=;
 b=b2CLldjfQ3YB1T7d1S+T1R+pd2Sk39VwmcX2lmpifbwapWpucT+LF6qc0xBpHQt1D3bNkdGmTsW0Krn3m1lXpts12sI3yhc4N9K9NBgKfrnF7QOpZ+PuWTd2dXz9gxb6k7MtltKHk03rLr6GP+V1X1sjBR1tm35shqyhJyV9NCM=
Received: from MW4PR04CA0171.namprd04.prod.outlook.com (2603:10b6:303:85::26)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 17:58:18 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::7c) by MW4PR04CA0171.outlook.office365.com
 (2603:10b6:303:85::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Wed, 14 Jun 2023 17:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.25 via Frontend Transport; Wed, 14 Jun 2023 17:58:17 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 12:58:15 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/17] drm/amd/display: Add Clock Table Entry With Max DC
 Values
Date: Wed, 14 Jun 2023 13:57:38 -0400
Message-ID: <20230614175750.43359-6-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614175750.43359-1-hamza.mahfooz@amd.com>
References: <20230614175750.43359-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: d09ba214-e5ff-4440-8de5-08db6d00eee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +XX+T12APJyuN3aFC6pTST6yua9vfn5rWXddmzLOR6E305+0l2eG83zufeVTrYFI/p3PpVKxDJl1ANY2BPeBd3zO69oojSiqitarrku+HoZcs6cGeSDa6Cg5PHZF6n4qRdMYMoS/PVI1n2oFO3UCE7JuXTdroKCmJwkK0TxLc9CT4dleEHV5VigZvWpGW7edSjS+8Sz9GVO6CCOBSltrdWdYutmKBbeG29KKdCcSV4rCFOA9NARvkrnqVaBFxrJMur6qilKr66qUwuqQKwTXKMQmEWROb0NC1aovBOggzkISWqK8Gif7scemzlYDtLvRUVipcfQdq0ByQZNutJlOy+zc7Q4BVPmYnlVWyMg2Kvwy54zo94onu+UJA7LIAoPdg4yHsnkAvr/rvSexMCsjShm9uup0SkZryHpPI/w+iXXBRVa/i4G8OewBzs0GXFSHX74d93x1Fgw7M0Ywx9QV6s08juvc/VA+OElwKvdqSNQDzRVq+dvC+cWcs/5IcHRrM79TsCoC+I5qH/ZnrlbUpn33Ui2bDP7bncAINuOIYpQ0QpsjKg2Wmkip9BwyewRHB5iHRyfw7VF/q57zlET/N2o2iRSosqHLTkAIXiIexR26YnY6w/ntcrfDXvND1lzERjbStUhbSnCcWYlBjAlIg67Et/w29oEg8idZMA76paDSfim1xOCbg+l1dbZrUpnF7vakWjZBQ8eEcxX0Rx+mIEQODjSfMVgQFXIrnHsO6VjbGL0cr3J+aBImQYnj6rpev9vA+wdu71CUtIhbmunLZq8vH3MYDlWN1PPtV2MsjDng3WWqLGNaN1abbTk0sVuq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(70586007)(426003)(36756003)(47076005)(70206006)(336012)(4326008)(6916009)(16526019)(186003)(478600001)(2616005)(2906002)(30864003)(54906003)(316002)(8676002)(41300700001)(86362001)(82310400005)(40460700003)(356005)(36860700001)(1076003)(6666004)(44832011)(8936002)(5660300002)(83380400001)(26005)(82740400003)(40480700001)(81166007)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 17:58:17.6943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d09ba214-e5ff-4440-8de5-08db6d00eee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
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
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <austin.zheng@amd.com>

Why:
Certain display configs resulted in underflow

How:
Add an entry containing all max DC clock timings

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 90 ++++++++++++++++--
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  4 -
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    | 92 +++++++++++++++++--
 .../amd/display/dc/dml/dcn321/dcn321_fpu.h    |  4 -
 .../amd/display/dc/dml/display_mode_structs.h |  1 +
 5 files changed, 171 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index e2bb2b9971f3..a95034801712 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -485,24 +485,20 @@ static void get_optimal_ntuple(struct _vcs_dpi_voltage_scaling_st *entry)
 	}
 }
 
-void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
+static void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
 				    unsigned int *num_entries,
 				    struct _vcs_dpi_voltage_scaling_st *entry)
 {
 	int i = 0;
 	int index = 0;
-	float net_bw_of_new_state = 0;
 
 	dc_assert_fp_enabled();
 
-	get_optimal_ntuple(entry);
-
 	if (*num_entries == 0) {
 		table[0] = *entry;
 		(*num_entries)++;
 	} else {
-		net_bw_of_new_state = calculate_net_bw_in_kbytes_sec(entry);
-		while (net_bw_of_new_state > calculate_net_bw_in_kbytes_sec(&table[index])) {
+		while (entry->net_bw_in_kbytes_sec > table[index].net_bw_in_kbytes_sec) {
 			index++;
 			if (index >= *num_entries)
 				break;
@@ -2349,6 +2345,63 @@ void dcn32_patch_dpm_table(struct clk_bw_params *bw_params)
 		bw_params->clk_table.entries[0].memclk_mhz = dcn3_2_soc.clock_limits[0].dram_speed_mts / 16;
 }
 
+static void swap_table_entries(struct _vcs_dpi_voltage_scaling_st *first_entry,
+		struct _vcs_dpi_voltage_scaling_st *second_entry)
+{
+	struct _vcs_dpi_voltage_scaling_st temp_entry = *first_entry;
+	*first_entry = *second_entry;
+	*second_entry = temp_entry;
+}
+
+/*
+ * sort_entries_with_same_bw - Sort entries sharing the same bandwidth by DCFCLK
+ */
+static void sort_entries_with_same_bw(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
+{
+	unsigned int start_index = 0;
+	unsigned int end_index = 0;
+	unsigned int current_bw = 0;
+
+	for (int i = 0; i < (*num_entries - 1); i++) {
+		if (table[i].net_bw_in_kbytes_sec == table[i+1].net_bw_in_kbytes_sec) {
+			current_bw = table[i].net_bw_in_kbytes_sec;
+			start_index = i;
+			end_index = ++i;
+
+			while ((i < (*num_entries - 1)) && (table[i+1].net_bw_in_kbytes_sec == current_bw))
+				end_index = ++i;
+		}
+
+		if (start_index != end_index) {
+			for (int j = start_index; j < end_index; j++) {
+				for (int k = start_index; k < end_index; k++) {
+					if (table[k].dcfclk_mhz > table[k+1].dcfclk_mhz)
+						swap_table_entries(&table[k], &table[k+1]);
+				}
+			}
+		}
+
+		start_index = 0;
+		end_index = 0;
+
+	}
+}
+
+/*
+ * remove_inconsistent_entries - Ensure entries with the same bandwidth have MEMCLK and FCLK monotonically increasing
+ *                               and remove entries that do not
+ */
+static void remove_inconsistent_entries(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
+{
+	for (int i = 0; i < (*num_entries - 1); i++) {
+		if (table[i].net_bw_in_kbytes_sec == table[i+1].net_bw_in_kbytes_sec) {
+			if ((table[i].dram_speed_mts > table[i+1].dram_speed_mts) ||
+				(table[i].fabricclk_mhz > table[i+1].fabricclk_mhz))
+				remove_entry_from_table_at_index(table, num_entries, i);
+		}
+	}
+}
+
 /*
  * override_max_clk_values - Overwrite the max clock frequencies with the max DC mode timings
  * Input:
@@ -2480,6 +2533,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = 0;
 
+		get_optimal_ntuple(&entry);
+		entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
 		insert_entry_into_table_sorted(table, num_entries, &entry);
 	}
 
@@ -2488,6 +2543,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	entry.fabricclk_mhz = 0;
 	entry.dram_speed_mts = 0;
 
+	get_optimal_ntuple(&entry);
+	entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
 	insert_entry_into_table_sorted(table, num_entries, &entry);
 
 	// Insert the UCLK DPMS
@@ -2496,6 +2553,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
 
+		get_optimal_ntuple(&entry);
+		entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
 		insert_entry_into_table_sorted(table, num_entries, &entry);
 	}
 
@@ -2506,6 +2565,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 			entry.fabricclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
 			entry.dram_speed_mts = 0;
 
+			get_optimal_ntuple(&entry);
+			entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
 			insert_entry_into_table_sorted(table, num_entries, &entry);
 		}
 	}
@@ -2515,6 +2576,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 		entry.fabricclk_mhz = max_clk_data.fclk_mhz;
 		entry.dram_speed_mts = 0;
 
+		get_optimal_ntuple(&entry);
+		entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
 		insert_entry_into_table_sorted(table, num_entries, &entry);
 	}
 
@@ -2530,6 +2593,21 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 			remove_entry_from_table_at_index(table, num_entries, i);
 	}
 
+	// Insert entry with all max dc limits without bandwidth matching
+	if (!disable_dc_mode_overwrite) {
+		struct _vcs_dpi_voltage_scaling_st max_dc_limits_entry = entry;
+
+		max_dc_limits_entry.dcfclk_mhz = max_clk_data.dcfclk_mhz;
+		max_dc_limits_entry.fabricclk_mhz = max_clk_data.fclk_mhz;
+		max_dc_limits_entry.dram_speed_mts = max_clk_data.memclk_mhz * 16;
+
+		max_dc_limits_entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&max_dc_limits_entry);
+		insert_entry_into_table_sorted(table, num_entries, &max_dc_limits_entry);
+
+		sort_entries_with_same_bw(table, num_entries);
+		remove_inconsistent_entries(table, num_entries);
+	}
+
 	// At this point, the table only contains supported points of interest
 	// it could be used as is, but some states may be redundant due to
 	// coarse grained nature of some clocks, so we want to round up to
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index a4206b71d650..defbee866be6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -39,10 +39,6 @@ void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
 uint8_t dcn32_predict_pipe_split(struct dc_state *context,
 				  display_e2e_pipe_params_st *pipe_e2e);
 
-void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
-				    unsigned int *num_entries,
-				    struct _vcs_dpi_voltage_scaling_st *entry);
-
 void dcn32_set_phantom_stream_timing(struct dc *dc,
 				     struct dc_state *context,
 				     struct pipe_ctx *ref_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
index f0683fd9d3f0..190776063f46 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -207,24 +207,20 @@ static float calculate_net_bw_in_kbytes_sec(struct _vcs_dpi_voltage_scaling_st *
 	return limiting_bw_kbytes_sec;
 }
 
-void dcn321_insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
+static void dcn321_insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
 					   unsigned int *num_entries,
 					   struct _vcs_dpi_voltage_scaling_st *entry)
 {
 	int i = 0;
 	int index = 0;
-	float net_bw_of_new_state = 0;
 
 	dc_assert_fp_enabled();
 
-	get_optimal_ntuple(entry);
-
 	if (*num_entries == 0) {
 		table[0] = *entry;
 		(*num_entries)++;
 	} else {
-		net_bw_of_new_state = calculate_net_bw_in_kbytes_sec(entry);
-		while (net_bw_of_new_state > calculate_net_bw_in_kbytes_sec(&table[index])) {
+		while (entry->net_bw_in_kbytes_sec > table[index].net_bw_in_kbytes_sec) {
 			index++;
 			if (index >= *num_entries)
 				break;
@@ -252,6 +248,63 @@ static void remove_entry_from_table_at_index(struct _vcs_dpi_voltage_scaling_st
 	memset(&table[--(*num_entries)], 0, sizeof(struct _vcs_dpi_voltage_scaling_st));
 }
 
+static void swap_table_entries(struct _vcs_dpi_voltage_scaling_st *first_entry,
+		struct _vcs_dpi_voltage_scaling_st *second_entry)
+{
+	struct _vcs_dpi_voltage_scaling_st temp_entry = *first_entry;
+	*first_entry = *second_entry;
+	*second_entry = temp_entry;
+}
+
+/*
+ * sort_entries_with_same_bw - Sort entries sharing the same bandwidth by DCFCLK
+ */
+static void sort_entries_with_same_bw(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
+{
+	unsigned int start_index = 0;
+	unsigned int end_index = 0;
+	unsigned int current_bw = 0;
+
+	for (int i = 0; i < (*num_entries - 1); i++) {
+		if (table[i].net_bw_in_kbytes_sec == table[i+1].net_bw_in_kbytes_sec) {
+			current_bw = table[i].net_bw_in_kbytes_sec;
+			start_index = i;
+			end_index = ++i;
+
+			while ((i < (*num_entries - 1)) && (table[i+1].net_bw_in_kbytes_sec == current_bw))
+				end_index = ++i;
+		}
+
+		if (start_index != end_index) {
+			for (int j = start_index; j < end_index; j++) {
+				for (int k = start_index; k < end_index; k++) {
+					if (table[k].dcfclk_mhz > table[k+1].dcfclk_mhz)
+						swap_table_entries(&table[k], &table[k+1]);
+				}
+			}
+		}
+
+		start_index = 0;
+		end_index = 0;
+
+	}
+}
+
+/*
+ * remove_inconsistent_entries - Ensure entries with the same bandwidth have MEMCLK and FCLK monotonically increasing
+ *                               and remove entries that do not follow this order
+ */
+static void remove_inconsistent_entries(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
+{
+	for (int i = 0; i < (*num_entries - 1); i++) {
+		if (table[i].net_bw_in_kbytes_sec == table[i+1].net_bw_in_kbytes_sec) {
+			if ((table[i].dram_speed_mts > table[i+1].dram_speed_mts) ||
+				(table[i].fabricclk_mhz > table[i+1].fabricclk_mhz))
+				remove_entry_from_table_at_index(table, num_entries, i);
+		}
+	}
+}
+
 /*
  * override_max_clk_values - Overwrite the max clock frequencies with the max DC mode timings
  * Input:
@@ -383,6 +436,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = 0;
 
+		get_optimal_ntuple(&entry);
+		entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
 		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
 	}
 
@@ -391,6 +446,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	entry.fabricclk_mhz = 0;
 	entry.dram_speed_mts = 0;
 
+	get_optimal_ntuple(&entry);
+	entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
 	dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
 
 	// Insert the UCLK DPMS
@@ -399,6 +456,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
 
+		get_optimal_ntuple(&entry);
+		entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
 		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
 	}
 
@@ -409,6 +468,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 			entry.fabricclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
 			entry.dram_speed_mts = 0;
 
+			get_optimal_ntuple(&entry);
+			entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
 			dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
 		}
 	}
@@ -418,6 +479,8 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 		entry.fabricclk_mhz = max_clk_data.fclk_mhz;
 		entry.dram_speed_mts = 0;
 
+		get_optimal_ntuple(&entry);
+		entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&entry);
 		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
 	}
 
@@ -433,6 +496,23 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 			remove_entry_from_table_at_index(table, num_entries, i);
 	}
 
+	// Insert entry with all max dc limits without bandwitch matching
+	if (!disable_dc_mode_overwrite) {
+		struct _vcs_dpi_voltage_scaling_st max_dc_limits_entry = entry;
+
+		max_dc_limits_entry.dcfclk_mhz = max_clk_data.dcfclk_mhz;
+		max_dc_limits_entry.fabricclk_mhz = max_clk_data.fclk_mhz;
+		max_dc_limits_entry.dram_speed_mts = max_clk_data.memclk_mhz * 16;
+
+		max_dc_limits_entry.net_bw_in_kbytes_sec = calculate_net_bw_in_kbytes_sec(&max_dc_limits_entry);
+		dcn321_insert_entry_into_table_sorted(table, num_entries, &max_dc_limits_entry);
+
+		sort_entries_with_same_bw(table, num_entries);
+		remove_inconsistent_entries(table, num_entries);
+	}
+
+
+
 	// At this point, the table only contains supported points of interest
 	// it could be used as is, but some states may be redundant due to
 	// coarse grained nature of some clocks, so we want to round up to
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h
index e8fad9b4be69..c6623b3705ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h
@@ -29,10 +29,6 @@
 
 #include "dml/display_mode_vba.h"
 
-void dcn321_insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
-					   unsigned int *num_entries,
-					   struct _vcs_dpi_voltage_scaling_st *entry);
-
 void dcn321_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index ff0246a9458f..fb17f8868cb4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -167,6 +167,7 @@ struct _vcs_dpi_voltage_scaling_st {
 	double phyclk_mhz;
 	double dppclk_mhz;
 	double dtbclk_mhz;
+	float net_bw_in_kbytes_sec;
 };
 
 /**
-- 
2.40.1

