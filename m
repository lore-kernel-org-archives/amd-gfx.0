Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BA4606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SwTD7m7e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FD2D10F896;
	Tue, 27 Oct 2026 23:21:57 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A4210F896
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:21:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stboBXvAL7IkTU3JNjM9TVsKjsxGUmioTwsf4NGP3ZDS2tpChuUJ0hOXZcc0NFyRl7eb/A42vfgTfAhVosaIAAXeJfAy6CmRX8ulQI3yx2bZGOvMDQxmmIuRBqVu8eMKTLJL/VK3mVZl9PVkofYr31P2krBv0t5bLrZdTS6mjLPiiS1tkQbvBnK62PqjaIUjG2BVd4dMY2wiSeXXF4tpbcQjYy/Xw2oxj3k1gpU1UYHWl2ZDrur3BkCoCYdfc7SqekV2JgbzQI6HVlFbo4ZYjYFwLWtT4DP6NCPNj9W5hw2+jUiGaB/68ZhhAFIuJ4BM0oBrGhqe/OjFN+nTYe3IxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJDETRkbwNCC462m4ZzIdW/KH6LaincMYgzhs80Z8cs=;
 b=pypstk0nUyIdekKNrk9Mn75hoKcfW6oDnch2zPauylVAR7Ytdavo6F9/3mwq3JTSgGUWVbKbLld51Jv4FKWVlmG0elLqvQCvmpzuohFyrhg4Ku1hgtOfvPApZyGWOFSkG01OjPkS1cK7p0ZzjHyDMeLk2I9lsP+cq3+TMNmCaLvdefaekmDQ4DDre6920zY0Oi3i243LlbJhB+VOkvMIh1mfeqq0x2PV6TmxoNgQHPM6R49bQhF37c7YEKiPIVDfBLVW/Xrp4YRCpIW/auptgSk5vbZRKmGFdX/O6XKfEWvFrAK6dEyNvP0skLzpwzZOdu4YdGEQoRCG1KjxeXueWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJDETRkbwNCC462m4ZzIdW/KH6LaincMYgzhs80Z8cs=;
 b=SwTD7m7eV65zkFc7mtpIEt6EDzsrYR8CaK19d+vK1OeKfXAAbOBFmdTNQhD7pSg57GkHEoZCdFBGYP8KVWgUvFkv9Anui642hG38UnZZCNebY22KCG9qsPZdoXld5qT1Ux56Xn9Pdm368ojnc74DYj+upWTQ+mCr2rd39R4rO/E=
Received: from BN0PR04CA0070.namprd04.prod.outlook.com (2603:10b6:408:ea::15)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 23:21:45 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::ad) by BN0PR04CA0070.outlook.office365.com
 (2603:10b6:408:ea::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:21:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:21:44 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:21:41 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ilya Bakoulin <Ilya.Bakoulin@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 06/28] drm/amd/display: Adjust DSC slice calc. policy
Date: Tue, 27 Oct 2026 17:17:02 -0600
Message-ID: <20261027232005.2879750-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: 73148d5d-45e4-45a0-167d-08df348110fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|261009223027099003|261021121427099003|261021123027099003|10067099003|261022075727099003|56012099006|261022113327099003|261026121527099003|6133799003|3023799007|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: tv+zNRuA1F0kzYqrudBoCVpSgz7UTVmESN1uiZl6SbM5jaRSMrweSaee9tesUKs9Z24pOYqCQFnuZcD+nHI6Wd97rAQX/dv6BjHMinuQn6VIiy/b3K78OJ5df3TTOy09DPyWE9W/0t9/dn7l6ZwtEz/vJbDNVodtONCYuL0KkZ3X32SIfr2zBmdYlxDOZPhBPRlD+9eHTZOG4NmcYGfpEMWlQCmk0Fu51VVI8JpRBO5UTE4zNPY+cv9TUHEPk/XjC9YeOvdVt5woHzXl+h+r8wIePgWQam6LFf0o2zs/DGNQmn/oCWG0sCH7OEKeidOfUTjfMYOWvBlqWyEtC6iNjmjh2AMLNrbhSCFhiJ1z9DtEqt9dEx2vYdPSZC1dPBvcX+gbyAKRlZzwjow4NF6mYyGPuvg+7Ji3Db9git805QIY7XZkuqelAqs2bn67PvzBG9djPGrMu/NGq4leTgKuTBox0zDPQTxsFuqE+DS02qesD442jHGrRn6e8rJMudlgo39qMeoufnfr272JkGnt2Y2kO/LpE+nHeU/3KrPcfTPtTRjCWkGaP8SLrmMx/HfNwTSblbp9XER4fXCyI8DS31/dMMc5thCdYxUoGE2JljsTGLy7g1AhVzuw7dxvltiVxUn8+ePPMq9YPWFohdEKdb5HAmIaShgdQVq5V0O0OPZpwHmJq9QDB6Ji56VhC9EuviAdkOEp1qExKJ2kGyxiJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003)(261022075727099003)(56012099006)(261022113327099003)(261026121527099003)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +NddoPuVIp1cIBdOR3MRgKY1vIWr27/OS4Ujq3HHG8M4Jaw46HhmPRA1y3AFQ/Rzn5Q6BMExaTN57ahqg+8QVfvCS/eR226YRP5d6rUFJZ5TwQ51uwTJhwRGYAq5tNHfL32rnuWYV5wfcS65tKW+59YNyTrcFbVpjDcMbFbCBFSqhgLnah1JOePy2JjekucAuXt7GY6smRI0os7H826co02GXETGfHVobRo4cHDp+/SAmuEQ7initiilUGhgoykuQ7wjoyBvxGfy8URPXT1xRzI8GJUAjo5QxupzAI/56vZpufWRtrQDutwm4s0bcXtyrjRGvU8Z1oahcHxfJ+HkHPR1QM/3jPp3HTWa45JK16hI5MYTTs2FmvARdBy2zsIgk752cqi6HnAyoapo9bxBxZ6SNasVyS9vguffi5D4uGQ44WfAmfxIKfX6vB2ngb5Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:21:44.9982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73148d5d-45e4-45a0-167d-08df348110fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[WHY & HOW]
Need to adjust the DSC slice calculation to reflect the policy change
where given a 1-slice config limit:
- Throughput per slice is limited to the 1-slice limit up to 4 slices
- Throughput per slice is tied to DSC encoder caps for 8+ slices

This is needed to avoid cases where some DSC config can end up exceeding
the 1-slice throughput limit either by itself or with dynamic ODM.

Cc: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 31 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 24 +++++++++++++-
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |  1 +
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
index 29082b186134..1c8daa7d46a1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c
@@ -1778,6 +1778,35 @@ static void dcn60_execute_clk_mgr_block_sequence_bls(struct clk_mgr *clk_mgr_bas
 	dcn60_execute_block_sequence(clk_mgr_base, clk_mgr60->num_block_sequence_steps);
 }
 
+static unsigned int dcn60_get_max_clock_khz(struct clk_mgr *clk_mgr_base, enum clk_type clk_type)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+
+	unsigned int num_clk_levels;
+
+	switch (clk_type) {
+	case CLK_TYPE_DISPCLK:
+		num_clk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_dispclk_levels;
+		return dcn60_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DISPCLK) ?
+				clk_mgr->base.bw_params->clk_table.entries[num_clk_levels - 1].dispclk_mhz * 1000 :
+				clk_mgr->base.boot_snapshot.dispclk;
+	case CLK_TYPE_DPPCLK:
+		num_clk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_dppclk_levels;
+		return dcn60_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DPPCLK) ?
+				clk_mgr->base.bw_params->clk_table.entries[num_clk_levels - 1].dppclk_mhz * 1000 :
+				clk_mgr->base.boot_snapshot.dppclk;
+	case CLK_TYPE_DSCCLK:
+		num_clk_levels = clk_mgr->base.bw_params->clk_table.num_entries_per_clk.num_dispclk_levels;
+		return dcn60_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DISPCLK) ?
+				clk_mgr->base.bw_params->clk_table.entries[num_clk_levels - 1].dispclk_mhz * 1000 / 6 :
+				clk_mgr->base.boot_snapshot.dispclk / 6;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static struct clk_mgr_funcs dcn60_funcs = {
 		.get_dp_ref_clk_frequency = dcn10_get_dp_ref_freq_khz,
 		.get_dtb_ref_clk_frequency = dcn60_get_dtb_ref_freq_khz,
@@ -1790,7 +1819,7 @@ static struct clk_mgr_funcs dcn60_funcs = {
 		.enable_pme_wa = dcn60_enable_pme_wa,
 		.is_smu_present = dcn60_is_smu_present,
 		.get_dispclk_from_dentist = NULL,
-		.get_max_clock_khz = dcn401_get_max_clock_khz,
+		.get_max_clock_khz = dcn60_get_max_clock_khz,
 		.override_memory_bandwidth_request = dcn60_override_memory_bandwidth_request,
 		.get_requested_memory_qos = dcn60_get_requested_memory_qos,
 		.set_idle_power_optimizations = dcn60_set_idle_power_optimizations,
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index febb6af43827..45ef1f745c7d 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -1057,7 +1057,7 @@ static void build_dsc_enc_caps(
 	unsigned int max_dscclk_khz;
 	unsigned int num_dsc;
 	unsigned int max_odm_combine_factor;
-	struct dsc_enc_caps single_dsc_enc_caps;
+	struct dsc_enc_caps single_dsc_enc_caps = {0};
 
 	struct dc *dc;
 
@@ -1082,6 +1082,7 @@ static void build_dsc_enc_caps(
 	dsc_enc_caps->bpp_increment_div = single_dsc_enc_caps.bpp_increment_div;
 	dsc_enc_caps->color_formats.raw = single_dsc_enc_caps.color_formats.raw;
 	dsc_enc_caps->color_depth.raw = single_dsc_enc_caps.color_depth.raw;
+	dsc_enc_caps->single_slice_config_throughput_mps = single_dsc_enc_caps.single_slice_config_throughput_mps;
 
 	/* expand per DSC capabilities to global */
 	max_odm_combine_factor = dc->caps.max_odm_combine_factor;
@@ -1873,6 +1874,27 @@ static bool setup_dsc_config(
 		min_slices_h = inc_num_slices(dsc_common_caps.slice_caps, min_slices_h);
 	}
 
+	/* Increase minimum slice count to meet DSC encoder clock and dynamic ODM limitations.
+	 *
+	 * Make sure that dynamic ODM can't create a config where there is 1 slice per ODM pipe and
+	 * the required 1-slice throughput exceeds single_slice_config_throughput_mps.
+	 * E.g. a 2-to-1 ODM config with 4 total slices transitioning to 4-to-1 ODM.
+	 *
+	 * Also prevent a single-slice non-ODM config where 1-slice throughput exceeds
+	 * single_slice_config_throughput_mps.
+	 */
+	while (min_slices_h <= max_slices_h && dsc_enc_caps->single_slice_config_throughput_mps) {
+		int pix_clk_per_slice_khz = dsc_div_by_10_round_up(timing->pix_clk_100hz) / min_slices_h;
+		/* Don't care about this condition if there is a minimum of 2 slices per ODM at max split */
+		if (min_slices_h > 4)
+			break;
+		if (min_slices_h <= 4 &&
+				pix_clk_per_slice_khz <= (dsc_enc_caps->single_slice_config_throughput_mps * 1000))
+			break;
+
+		min_slices_h = inc_num_slices(dsc_common_caps.slice_caps, min_slices_h);
+	}
+
 	/* increase minimum slice count to meet divisibility requirements */
 	while (pic_width % min_slices_h != 0 && min_slices_h <= max_slices_h) {
 		min_slices_h = inc_num_slices(dsc_common_caps.slice_caps, min_slices_h);
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
index 91ec525b11d0..a349a416240d 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
@@ -458,6 +458,7 @@ void dsc60_get_single_enc_caps(struct dsc_enc_caps *dsc_enc_caps, unsigned int m
 	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_10_BPC = 1;
 	dsc_enc_caps->color_depth.bits.COLOR_DEPTH_12_BPC = 1;
 	dsc_enc_caps->max_total_throughput_mps = max_dscclk_khz * 3 / 1000;
+	dsc_enc_caps->single_slice_config_throughput_mps = 340;
 
 	dsc_enc_caps->max_slice_width = 5760; /* (including 64 overlap pixels for eDP MSO mode) */
 	dsc_enc_caps->bpp_increment_div = 16; /* 1/16th of a bit */
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
index cb7b0b1d8686..4f58d0ddbf22 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dsc.h
@@ -100,6 +100,7 @@ struct dsc_enc_caps {
 	union dsc_color_formats color_formats;
 	union dsc_color_depth color_depth;
 	int32_t max_total_throughput_mps; /* Maximum total throughput with all the slices combined */
+	int32_t single_slice_config_throughput_mps;
 	int32_t max_slice_width;
 	uint32_t bpp_increment_div; /* bpp increment divisor, e.g. if 16, it's 1/16th of a bit */
 	bool is_frl;
-- 
2.53.0

