Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C72C4363C
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DD4206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kjkhKUso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DD4206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D745D89E35;
	Sun,  4 Oct 2020 17:20:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC41E89EB8
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:20:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCh9n7GEzL41VFjj6ZGdsmDyDC2D7/TjfkMa0tNHMr2YpWo+i9lNYwpWclsP1yLKg0SZPe5iFCr87m7N+aI5uVuHj49L+RhUalg+Jrbi9dHv/9/OsFhEeFUeVK5zVm6G6zyfuCdorRgzFskJ+L9m/akQoNMIlP9/H1DCeVJ/o20oDOfAy9DP6eIqH7sWK8tUWXaoct4n5r5A+2RyT65WTrfdeehRGYEzJTk+M6cPAOiNV6bbE2KGFi+1iOe/Ts9QCnW7QR5NdYVQsz3z7GFz778E0KzdeEory5qiW1Yu1W9DC6aDDVyzcxWJh1DRgGTrVKPBMxNA/zZHJFez+EgQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6BLEOPZQh2QuWhyWKkabwuCOYXJugx/SnswlL4U9hc=;
 b=mdixXGBuD+9BXoV7hZKRxB4zugiNfu7N1rMeyfMvznU9Gu1/DjVp7MgZjKBT9MWQtH9wC8PxC68Bfdc8d3ymOrkYtWwXdJlaFEq77ohZiu0sXCPvQdd2FzDNDYpkTGJ40WgD3vzbeQDZ+kowlYNYcbi3zVmvSXBYtVf5xum2KQa8xGmcbko570YW8qfuZinb7950mqJB5a5rDgMwNjx79rqPX/lz9uCNKuhFTh9oilbzKiwPuF0oAYXCBF3ccjXhkeKQqkCoUDE01vVEYwM8QrxuSPoO+6Wa5VZDEWAfBeoaOeExLe+4e5z0fEVt9aL5iU/7Ldr/Grk5zzlWS9f4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6BLEOPZQh2QuWhyWKkabwuCOYXJugx/SnswlL4U9hc=;
 b=kjkhKUsoZ7IRNy43jZLcL9V5JVk7vBS6VbVSWdoT4xHe0LGMcImNvaaZG1W6BM9kpO2ahJoa9f4K0bhpAsWYUj0/ezlf57fnHpxU3Ze8S2AhKZYINQe0Q6TSNSEdaAMIbKqXawkl/sCeVzoM1c0/Dfwol9/npzgtOZRgJSpkm0s=
Received: from MWHPR17CA0058.namprd17.prod.outlook.com (2603:10b6:300:93::20)
 by DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Sun, 4 Oct
 2020 17:20:06 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::65) by MWHPR17CA0058.outlook.office365.com
 (2603:10b6:300:93::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Sun, 4 Oct 2020 17:20:06 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:20:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:20:05 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:20:04 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:19:59 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/18] drm/amd/display: Hardcode 45W Bounding Box for DCN2.1
 Diags
Date: Sun, 4 Oct 2020 13:18:08 -0400
Message-ID: <20201004171813.7819-14-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dac81790-41b9-4e00-ea4a-08d86889bce2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4545:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4545FB71E87FF98A3F6EF775E50F0@DM6PR12MB4545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAS4ndn9vLN3JhJB5jxQFgyHVCWbzTNatqcg6cNOI418gYxGfFiB10BPjgJLwm7/HdS1U8dLJKML2Px+j8hyZr1ndQq7uSmpHz4j34pUiKX/wM4twshUUdwDWnqZGB7hQzrcNj6fPlYesKojNl0Pr3P2kqsek6ZYUlT6+k6f204rt0ScHurGMabKAEnuPsB+ypa1RUBCwXxtQynghUDpGalbCcAp0EEeceIMnO5mxo+WQtFD0mNCpvCv0BETuL9BLSN6Riiaou7KA5XDtg1gMILaLKRhFDWYkz6DAE3nS1TE+jDswfxf0C3hvS6zc3hD6kbZwwstF0bDMOdZLavFu7EuxCFmg7Wo47PyHCVbgLWAMYoXi1JG9dY2GV9vAt6j3Gj7SMG4nG7wp9IkhBmhpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39850400004)(376002)(396003)(46966005)(426003)(336012)(54906003)(316002)(82310400003)(6916009)(6666004)(26005)(4326008)(70206006)(70586007)(8676002)(2616005)(47076004)(36756003)(81166007)(1076003)(2906002)(186003)(8936002)(83380400001)(478600001)(5660300002)(44832011)(356005)(86362001)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:20:05.9932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dac81790-41b9-4e00-ea4a-08d86889bce2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4545
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk Brol <eryk.brol@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
Currently construction of clock limits gets skipped for diags.
This logic would be useful to get tested in diags.

[HOW]
Copy existing states to clk_table such that update_bw_bounding_box
logic gets used to fill the table.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 119 ++++++------------
 1 file changed, 36 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 0ab718fd43b1..686e1d47faa4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1393,87 +1393,46 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	unsigned int i, closest_clk_lvl;
 	int j;
 
-	// Default clock levels are used for diags, which may lead to overclocking.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-		dcn2_1_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
-		dcn2_1_ip.max_num_dpp = pool->base.pipe_count;
-		dcn2_1_soc.num_chans = bw_params->num_channels;
-
-		ASSERT(clk_table->num_entries);
-		for (i = 0; i < clk_table->num_entries; i++) {
-			/* loop backwards*/
-			for (closest_clk_lvl = 0, j = dcn2_1_soc.num_states - 1; j >= 0; j--) {
-				if ((unsigned int) dcn2_1_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
-					closest_clk_lvl = j;
-					break;
-				}
+	dcn2_1_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
+	dcn2_1_ip.max_num_dpp = pool->base.pipe_count;
+	dcn2_1_soc.num_chans = bw_params->num_channels;
+
+	ASSERT(clk_table->num_entries);
+	for (i = 0; i < clk_table->num_entries; i++) {
+		/* loop backwards*/
+		for (closest_clk_lvl = 0, j = dcn2_1_soc.num_states - 1; j >= 0; j--) {
+			if ((unsigned int) dcn2_1_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
+				closest_clk_lvl = j;
+				break;
 			}
-
-			clock_limits[i].state = i;
-			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
-
-			clock_limits[i].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-			clock_limits[i].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-			clock_limits[i].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			clock_limits[i].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			clock_limits[i].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			clock_limits[i].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			clock_limits[i].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
-		}
-		for (i = 0; i < clk_table->num_entries; i++)
-			dcn2_1_soc.clock_limits[i] = clock_limits[i];
-		if (clk_table->num_entries) {
-			dcn2_1_soc.num_states = clk_table->num_entries;
-			/* duplicate last level */
-			dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] = dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
-			dcn2_1_soc.clock_limits[dcn2_1_soc.num_states].state = dcn2_1_soc.num_states;
 		}
+
+		clock_limits[i].state = i;
+		clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+		clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+		clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+		clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+
+		clock_limits[i].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+		clock_limits[i].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+		clock_limits[i].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+		clock_limits[i].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+		clock_limits[i].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+		clock_limits[i].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+		clock_limits[i].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+	}
+	for (i = 0; i < clk_table->num_entries; i++)
+		dcn2_1_soc.clock_limits[i] = clock_limits[i];
+	if (clk_table->num_entries) {
+		dcn2_1_soc.num_states = clk_table->num_entries;
+		/* duplicate last level */
+		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states] = dcn2_1_soc.clock_limits[dcn2_1_soc.num_states - 1];
+		dcn2_1_soc.clock_limits[dcn2_1_soc.num_states].state = dcn2_1_soc.num_states;
 	}
 
 	dml_init_instance(&dc->dml, &dcn2_1_soc, &dcn2_1_ip, DML_PROJECT_DCN21);
 }
 
-/* Temporary Place holder until we can get them from fuse */
-static struct dpm_clocks dummy_clocks = {
-		.DcfClocks = {
-				{.Freq = 400, .Vol = 1},
-				{.Freq = 483, .Vol = 1},
-				{.Freq = 602, .Vol = 1},
-				{.Freq = 738, .Vol = 1} },
-		.SocClocks = {
-				{.Freq = 300, .Vol = 1},
-				{.Freq = 400, .Vol = 1},
-				{.Freq = 400, .Vol = 1},
-				{.Freq = 400, .Vol = 1} },
-		.FClocks = {
-				{.Freq = 400, .Vol = 1},
-				{.Freq = 800, .Vol = 1},
-				{.Freq = 1067, .Vol = 1},
-				{.Freq = 1600, .Vol = 1} },
-		.MemClocks = {
-				{.Freq = 800, .Vol = 1},
-				{.Freq = 1600, .Vol = 1},
-				{.Freq = 1067, .Vol = 1},
-				{.Freq = 1600, .Vol = 1} },
-
-};
-
-static enum pp_smu_status dummy_set_wm_ranges(struct pp_smu *pp,
-		struct pp_smu_wm_range_sets *ranges)
-{
-	return PP_SMU_RESULT_OK;
-}
-
-static enum pp_smu_status dummy_get_dpm_clock_table(struct pp_smu *pp,
-		struct dpm_clocks *clock_table)
-{
-	*clock_table = dummy_clocks;
-	return PP_SMU_RESULT_OK;
-}
-
 static struct pp_smu_funcs *dcn21_pp_smu_create(struct dc_context *ctx)
 {
 	struct pp_smu_funcs *pp_smu = kzalloc(sizeof(*pp_smu), GFP_KERNEL);
@@ -1481,17 +1440,11 @@ static struct pp_smu_funcs *dcn21_pp_smu_create(struct dc_context *ctx)
 	if (!pp_smu)
 		return pp_smu;
 
-	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment) || IS_DIAG_DC(ctx->dce_environment)) {
-		pp_smu->ctx.ver = PP_SMU_VER_RN;
-		pp_smu->rn_funcs.get_dpm_clock_table = dummy_get_dpm_clock_table;
-		pp_smu->rn_funcs.set_wm_ranges = dummy_set_wm_ranges;
-	} else {
+	dm_pp_get_funcs(ctx, pp_smu);
 
-		dm_pp_get_funcs(ctx, pp_smu);
+	if (pp_smu->ctx.ver != PP_SMU_VER_RN)
+		pp_smu = memset(pp_smu, 0, sizeof(struct pp_smu_funcs));
 
-		if (pp_smu->ctx.ver != PP_SMU_VER_RN)
-			pp_smu = memset(pp_smu, 0, sizeof(struct pp_smu_funcs));
-	}
 
 	return pp_smu;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
