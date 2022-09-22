Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC67C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 00:20:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7782210EA08;
	Thu, 22 Sep 2022 00:19:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B7E10EA08
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 00:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlvjNOnSlXBUFwAQOnaXAT5HkYYx3nCr1fpTyTRUuE1C0VfyyBmRc+7ENkTc2m1fNB9OWe5ljchAlI8MM8viVu7rxoDHFTO8qVDGhScWOWeWI4bJXe7VePA+g9aZueNTbCS8usTICtV41rkiXg/m0L0tJ7JT8MAXNHHqKovZ9KVlgAdTukwMklaoEU2062bFhCvegVQgqtFYboejZKDvm+cHqztrl4ehRWyEVzKW63CnXwHLdnBoUzNnMrR4usOZFtexekvBlc+R9lss1IC/dkHZAY7UmU4cnTSTXeAGG9ts8fR9hYHLtRgd96XParW1OAptYaw1gTekpE04qXwiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=296RnQq13Bw4crdn/O/v5I5gEO6aqjuNbO9mwikwtfw=;
 b=EhDHA+eouWjEhiHX4/kPKIKSOQvOr0tFdGy3HQG6AzDrdxcK7oMTDrj7xZ8z8woIbmMkTrkfaFwLHyFoPwVb48Iuxz0UfM9S1x0REu3nDd1Ik43mSII+yeZ/gHvtgqSbiljo/aTlUhNyktEffvtPg6kSEST2dxLuNZlcrQ0uFbgiIwlQKRTrM7jOJOZM5oeO20gLJAaV2jskRu4K1TWKmqSP0roKktxbJcDKmX+F/i9i6rEiyemcVMvIAtwtQeYym3T6S4CyDJ89ic/Q+lVMm9HOkybKsAqdx19RAgoa2K/SxLOQ29Em+lHyX9mXnU8/1pqCez6A3QwpTqXh6GIkzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=296RnQq13Bw4crdn/O/v5I5gEO6aqjuNbO9mwikwtfw=;
 b=tJfEXF6ctj5IZC8DvNP2V+fz+7cu/J9P2E3GvKr/pI8CbnIzdSiJo7jR8YmFr7ONGS4CTghve6RjfWPpI/9On+JmO9ixJJ5h/vM86Bh5orGbMI6zgVK4jNITUBj33xIiJcll3eZwgHR5Fcai7PZlq7r+NZnDYAM7AdpMTwMTa2Y=
Received: from BN9PR03CA0872.namprd03.prod.outlook.com (2603:10b6:408:13c::7)
 by BL1PR12MB5304.namprd12.prod.outlook.com (2603:10b6:208:314::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.15; Thu, 22 Sep
 2022 00:19:19 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::47) by BN9PR03CA0872.outlook.office365.com
 (2603:10b6:408:13c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Thu, 22 Sep 2022 00:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Thu, 22 Sep 2022 00:19:19 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 21 Sep 2022 19:19:14 -0500
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/31] drm/amd/display: fill in clock values when DPM is not
 enabled
Date: Wed, 21 Sep 2022 20:18:09 -0400
Message-ID: <20220922001821.320255-20-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220922001821.320255-1-jdhillon@amd.com>
References: <20220922001821.320255-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|BL1PR12MB5304:EE_
X-MS-Office365-Filtering-Correlation-Id: 19727638-de7a-4936-3a39-08da9c30176b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DahKMZW4I7TeQ1iRetuldVEx0DMVRRHXxYhYPhALVfTBnVzRhSCIN/fY80WfxpGzdrtV4W1iGA4JiwIkC+Yn+KAIU4AWNN7zSq9bLl/hi7KQ42iw9nm5Vjwd4JS8xBJljF3H1/DLG6mUaeak8O99VgsNLo0iOptdKRKFAOfNqx1B9tLHSiadKiu2PY/sNOm00ImF305PvotJX/ZVj377bRqtVAzXM1e1r9J/pI8tcHmPQZNlOCz+g7gHfOzktkqUwiwQNcMNmg1nL3NYNi5xEae8lJEbKpF1+o07tTgmn5nDWB0/sbB4IYpuz+Hwfr6EDSMbPSlmwKcmz9lUN5Zp1G2JCWyLRaY1UW/0WMBzBfmv+PcQ8706giYn+E9VAoVDgbySA1LIG6vgQkKTlDtgyLozMNwxkJqDRqkLmagJMzXerVx+wrJPE73BaHkU+C0h3hFI8kNpegAWcYLwMvyt2OCoIgX9WtgkKsVlYLzCOub4Ze8p4NZ5pfq7FuhP0+CDA2cRsm+qhQO4oMxiVJZbHiWMIyFMWpVzSV1T40TphTYpNiFx+n4jAxkB8EWsw7rZxli/hb9N/3oxoinHgmzWs3pE4v7Ks0kdZbcxPbuKqFeamImGhl2UbTO0r0u94Ggf0g0wm9t87YJaoNmz4I2l3lSTpVzBUmZaTPNx80N59XUbwaHA2dH3hhR09lhnhp6Yfr0IQur0sAsWxho2LEs0rhvnkDo1SPvWsaoGKYHoQbC8WjrVnXG06DOapyqtEnKox6Hmt8bYPctpjY7msmkoNU+ODP/jq5wQ7wczEgv7kIc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(6666004)(41300700001)(8936002)(82310400005)(5660300002)(40480700001)(8676002)(6916009)(54906003)(4326008)(316002)(70586007)(70206006)(40460700003)(81166007)(356005)(82740400003)(1076003)(2616005)(186003)(47076005)(16526019)(36860700001)(26005)(336012)(426003)(36756003)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 00:19:19.0831 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19727638-de7a-4936-3a39-08da9c30176b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5304
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
For individual feature testing, PMFW may not report all clock
values back. Driver will default them to 0 but this will
cause the BB table to be skipped and default to one state
with max clocks.

[How]
Add helper function to scan through initial clock values and
populate them with default clock limits so that BB table
can be built.
Add dpm_enabled flag to check when DPM is not enabled and
to trigger helper function.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 14 +++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 39 +++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  2 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  2 +
 4 files changed, 57 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index c6785969eb1a..f0f3f66629cc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -156,12 +156,14 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	unsigned int num_levels;
+	unsigned int num_dcfclk_levels, num_dtbclk_levels, num_dispclk_levels;
 
 	memset(&(clk_mgr_base->clks), 0, sizeof(struct dc_clocks));
 	clk_mgr_base->clks.p_state_change_support = true;
 	clk_mgr_base->clks.prev_p_state_change_support = true;
 	clk_mgr_base->clks.fclk_prev_p_state_change_support = true;
 	clk_mgr->smu_present = false;
+	clk_mgr->dpm_present = false;
 
 	if (!clk_mgr_base->bw_params)
 		return;
@@ -179,6 +181,7 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	dcn32_init_single_clock(clk_mgr, PPCLK_DCFCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].dcfclk_mhz,
 			&num_levels);
+	num_dcfclk_levels = num_levels;
 
 	/* SOCCLK */
 	dcn32_init_single_clock(clk_mgr, PPCLK_SOCCLK,
@@ -189,11 +192,16 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 		dcn32_init_single_clock(clk_mgr, PPCLK_DTBCLK,
 				&clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz,
 				&num_levels);
+	num_dtbclk_levels = num_levels;
 
 	/* DISPCLK */
 	dcn32_init_single_clock(clk_mgr, PPCLK_DISPCLK,
 			&clk_mgr_base->bw_params->clk_table.entries[0].dispclk_mhz,
 			&num_levels);
+	num_dispclk_levels = num_levels;
+
+	if (num_dcfclk_levels && num_dtbclk_levels && num_dispclk_levels)
+		clk_mgr->dpm_present = true;
 
 	if (clk_mgr_base->ctx->dc->debug.min_disp_clk_khz) {
 		unsigned int i;
@@ -658,6 +666,12 @@ static void dcn32_get_memclk_states_from_smu(struct clk_mgr *clk_mgr_base)
 			&num_levels);
 	clk_mgr_base->bw_params->clk_table.num_entries = num_levels ? num_levels : 1;
 
+	if (clk_mgr->dpm_present && !num_levels)
+		clk_mgr->dpm_present = false;
+
+	if (!clk_mgr->dpm_present)
+		dcn32_patch_dpm_table(clk_mgr_base->bw_params);
+
 	DC_FP_START();
 	/* Refresh bounding box */
 	clk_mgr_base->ctx->dc->res_pool->funcs->update_bw_bounding_box(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index cb97afbee097..4484a7ece4b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2044,6 +2044,45 @@ static void remove_entry_from_table_at_index(struct _vcs_dpi_voltage_scaling_st
 	memset(&table[--(*num_entries)], 0, sizeof(struct _vcs_dpi_voltage_scaling_st));
 }
 
+void dcn32_patch_dpm_table(struct clk_bw_params *bw_params)
+{
+	int i;
+	unsigned int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0,
+			max_phyclk_mhz = 0, max_dtbclk_mhz = 0, max_fclk_mhz = 0, max_uclk_mhz = 0;
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
+	}
+
+	/* Scan through clock values we currently have and if they are 0,
+	 *  then populate it with dcn3_2_soc.clock_limits[] value.
+	 *
+	 * Do it for DCFCLK, DISPCLK, DTBCLK and UCLK as any of those being
+	 *  0, will cause it to skip building the clock table.
+	 */
+	if (max_dcfclk_mhz == 0)
+		bw_params->clk_table.entries[0].dcfclk_mhz = dcn3_2_soc.clock_limits[0].dcfclk_mhz;
+	if (max_dispclk_mhz == 0)
+		bw_params->clk_table.entries[0].dispclk_mhz = dcn3_2_soc.clock_limits[0].dispclk_mhz;
+	if (max_dtbclk_mhz == 0)
+		bw_params->clk_table.entries[0].dtbclk_mhz = dcn3_2_soc.clock_limits[0].dtbclk_mhz;
+	if (max_uclk_mhz == 0)
+		bw_params->clk_table.entries[0].memclk_mhz = dcn3_2_soc.clock_limits[0].dram_speed_mts / 16;
+}
+
 static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index 732ed7fadb8a..3a3dc2ce4c73 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -71,4 +71,6 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 							    int pipe_cnt,
 							    int vlevel);
 
+void dcn32_patch_dpm_table(struct clk_bw_params *bw_params);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 68c2ed434d2c..cff5fd55a0ad 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -340,6 +340,8 @@ struct clk_mgr_internal {
 	bool smu_present;
 	void *wm_range_table;
 	long long wm_range_table_addr;
+
+	bool dpm_present;
 };
 
 struct clk_mgr_internal_funcs {
-- 
2.25.1

