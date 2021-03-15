Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08913C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:13:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589C464F18
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589C464F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E057D6E155;
	Mon, 15 Mar 2021 19:13:00 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FACC89F2D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 19:13:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaEhSkPSiaZWNtADhOCuNXuSwX4htCldA6AdttqJlro7GpHrCI+XX63gUAfOWxk5NDCphqbOTIt15JJGHOXFUqivlpx9tt8Cyk59ZEaht3eebBAPQLEKondMAQC2ZVTYKAJmjjCB/egLRNG8ShmsJNW1uETzPETr3Zau7MKQcJUzgoCFs+kWS8hB2nK1yFdiK0co+3HxNYNM+shp7+nmY0ES7oe3jkCDIBWxKhBuaElwroq7131pw7EULg24tJ47gj4APnlTUHlO0+8ssWx+CBAGMVr3FGQraRv3kz1SeYoPAdTmaukW7EpPMkTBXc7Sz/fI8WV8EKBCPuyCq11QNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGUbaBYcbP6UyJ3l8NTdHwCeSovzlv8X5yYm65zM7ME=;
 b=ND+KC+fgF7HAoeHbl+Wd4KBxD1WI69VzNBwjMp1SBbwGjhJr2q+W83OV/7VN8LBin80CjTNA/DqyPS81tNz+VfIm4y5yKesTe7Rw3Q/DSoQcN/F/bMhtK6oPVjRBvIma/tBYyG5rnV9LUzeXSIS3NDs6lvInc90S87hxmbetBBa/Ri6tNJyBTaTuVO2+37Ei5i1FoWDil+A0ith2xCZJdvJbsjt7uBDJCRQFE5qEiNbRFvge7voQrHGj4TFwR4haElJ07rRYGD5EKwgy5k+o5qZ3fbmgqbBTBFljmt6W0jlUIR7xvlpzxbIYsecCuFxk00ioiei4KAVrVd8afdWZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGUbaBYcbP6UyJ3l8NTdHwCeSovzlv8X5yYm65zM7ME=;
 b=isojAvdYeQaqPBVT7zSZh1qNP49Vm6e3NoW9vJwcizJMqs1hZltSI3GB/2u0vnTvhkTbrlTCSB31PfpAjODWKZO/Gqe1hyv1Bw6vJjHeFHZgRvJu/7KbAHT03CcPd5EIHMJVVTj2/21t1oL3Lwp1AVtHKpL7Tygfw5HErSpr15g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4128.namprd12.prod.outlook.com (2603:10b6:208:1dd::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 19:12:58 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 19:12:58 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: drop unused DCN3.01 functions
Date: Mon, 15 Mar 2021 15:12:41 -0400
Message-Id: <20210315191241.1526008-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [192.161.79.247]
X-ClientProxiedBy: MN2PR16CA0033.namprd16.prod.outlook.com
 (2603:10b6:208:134::46) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.247) by
 MN2PR16CA0033.namprd16.prod.outlook.com (2603:10b6:208:134::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Mon, 15 Mar 2021 19:12:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd7cd1a2-9663-4e44-6517-08d8e7e65817
X-MS-TrafficTypeDiagnostic: MN2PR12MB4128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41282FC70B6521A01C978D44F76C9@MN2PR12MB4128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 36SzEVtFSRQ7tjwMRpy5USj0go84WnUaP+ekjeYvO3J9X1k8nOyO6tsuwOVKp2Y15S/rdZpB4hqAf8a1vFP+56RRSwvZIGJGmsGrTBkNKmM8OxxmMevDjiv+FDj9fna71/9Q2tTdc5qC819I+J6rD0cuCzWyJQeHx9ArjVTNczs782AktArRAEAQb3W4sZlqrLH5zNN6yIMWaSUQQOjEhz9HyAwQXQI09n00ccriWOaIsDyN3zYZ9WLD1vdBC3OMzc1l9FdfXlTljgZyijQ6939LCZGy4Sza2I7TfnMt07h46gRzNiNzu3ddGfsuS0TWGCcPumBprG9ik7xURtF8ukpwb68AfqDlFsPrujpwIDx5RGhQ4UC2B4WfZJGwQUUETwg8QBxzIs2VYxR2cUQTw9RdCoJ1rPpGscuwAss68omQFivRGqTToyVaRatyX6Aq5pNYgvQaK9hnM0oLFMQJAat9fRfMM5oKN8lBQmd2qu7GydH0qA3SH6asWsDVkSZhbqadoivL0078AI8e5E6iMkiWnlx75xIG2pYPaAVHMExF9Jsl4V14OqQGByFGRwkEWeqlKgKo0/tGS34uiodFrmtcRRd/mNN7PQTjkY+CQwFUHGeM2rGGCZTV4sQkwLS0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(478600001)(6512007)(54906003)(4326008)(5660300002)(186003)(66556008)(36756003)(66946007)(86362001)(16526019)(316002)(1076003)(66476007)(6506007)(8936002)(2616005)(69590400012)(83380400001)(26005)(956004)(8676002)(6486002)(2906002)(6666004)(52116002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?JrDCQj4Qj8ZyoyNZbGhBN7Cym7Ymc1TRYaiNGvsKk8VXeQKXjMR4my0UQEfg?=
 =?us-ascii?Q?UzQKZGpwdbR8gqaFS1boIhwhp0Tf6OxCoeX6yID45Xbg7ZT039a/40CCcG5c?=
 =?us-ascii?Q?q3l4IhRD+eO6tYXSyWjTKm62OsjqZZOB5HLm8eMSWTlZZJgfzJnYAv9cf7p9?=
 =?us-ascii?Q?dpfjU+yblAPFv1/sSS0bs/bcVTzns22AP6co6b03CiNcImpO8zlVYz2GSSaR?=
 =?us-ascii?Q?XEm70VG85df6ghHArhnQ9Pn20AJ68DfRzWVoanVJ3/8ULgNKNjBDCxulAlLK?=
 =?us-ascii?Q?TQU4Q7W/NO+rWvBJV5ggWpdcmclyakNSZ0G2J5GuzruCgcm9Zq5VEM8mvcrx?=
 =?us-ascii?Q?BLgq3zBtKFULGNk6AmeOQOerMiOuJ7u7DV+dQnkGlm0P5Ex0odd8IaVFVbVs?=
 =?us-ascii?Q?SXz3f7naTfAOpouJYN2SaqjdY+qsdqVggQ28YEm/UqpCdNGjRFkXtlW8hEEy?=
 =?us-ascii?Q?xyJ39qMK0ZHCeQAy34M5XIS9X/5mLnFWTS6c7f9bI+HoSE8g6JSad4eCOM3o?=
 =?us-ascii?Q?wJUa2mij4vIdan0sCE9zR6uWn+ymgKUycDTb+1i8M+iCJouDH/khZKGrErbt?=
 =?us-ascii?Q?PVNvCmmL2ZyHMW3I0D0INjoAbQh/oiD1z8NIU3nqM7A+JK0S7MWDYxj1COIe?=
 =?us-ascii?Q?0dLVYIq8mYrezaFoTLhEJQwHuwJILo1BJXIU2mrvoIBTWXf+nxkNtbiXzcrU?=
 =?us-ascii?Q?3t/rbs2nkVKfcR/IrCfWzpD/SlPVgM8MFQ9EdTex9hjDj9S1uIXVxgD/DChf?=
 =?us-ascii?Q?vctcLE1xij7V2yZSqsbXP/2u6UiKLaywdNVf8KQ4ZtJpDfXZqu+rp7K06cLS?=
 =?us-ascii?Q?1kp18MKvdo1SvY1PwlkojHxtr5soOXLPlSgPlaT/ERrYUbBrIeMn+enZ2jw5?=
 =?us-ascii?Q?ICDUSong3NnfrWZbMIQqbP8ACB3duL0EFFRpchJY83kW6izMsVF6rKvDahf/?=
 =?us-ascii?Q?W0GqC0UWsLtbewmM8NayXXJ8WKGRqzA14/l2FYTfeRyPaSVTkzXwQ4U3vIWd?=
 =?us-ascii?Q?qFVt/ZUOkS4/gvoSbKtmfN1CzbYQ9EfRyIzpn7ywv1uW1sFWe32bITlU/qYc?=
 =?us-ascii?Q?waf4mt6oQGh/bfJ7TiSQDSxzkYw3dXqIKQ57HWjg2GNev5Rce3D12IsRURF8?=
 =?us-ascii?Q?bl4jrmJgLwtKvv64wa6kZTGghTDYXGp+thenK2RGDB1R/yilBCgKV4R/RIai?=
 =?us-ascii?Q?/Bc+Dku1IJk40Lyt/fHUl8D4LJazYBy/8SU0ecpbbWSS9cFWbvaxm7iq96hB?=
 =?us-ascii?Q?490DDljPaORTxEoNl+4eT5DijmdrbiLXgRaJ8o8JkwqN05s/ttfTBfBFOe1g?=
 =?us-ascii?Q?svFliP7uRNkxTTPkgJtwNkIB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7cd1a2-9663-4e44-6517-08d8e7e65817
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 19:12:58.1060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xU9IKce6hqYilLructzvPG555yUT6ZFUN2acgZSPVSLEOsAAffrTPbs3gVgaLmGt0iwNik6DKr8p5NKcspp8NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4128
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Charles Sun <charles.sun@amd.com>,
 Nikola Cornij <nikola.cornij@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No longer used.  Drop to avoid warnings.

Fixes: e0e33d4006aa ("[why]  the dcn301_calculate_wm_and_dl() calculation exposed a issue  - switch to dcn30 version for now.  still need to follow up with dcn301 watermark updates version.")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Charles Sun <charles.sun@amd.com>
Cc: Nikola Cornij <nikola.cornij@amd.com>
---
 .../amd/display/dc/dcn301/dcn301_resource.c   | 94 -------------------
 1 file changed, 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 22ffd7c64bde..c109d0cdab42 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1621,100 +1621,6 @@ static void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
 	dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_DCN30);
 }
 
-static void calculate_wm_set_for_vlevel(
-		int vlevel,
-		struct wm_range_table_entry *table_entry,
-		struct dcn_watermarks *wm_set,
-		struct display_mode_lib *dml,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt)
-{
-	double dram_clock_change_latency_cached = dml->soc.dram_clock_change_latency_us;
-
-	ASSERT(vlevel < dml->soc.num_states);
-	/* only pipe 0 is read for voltage and dcf/soc clocks */
-	pipes[0].clks_cfg.voltage = vlevel;
-	pipes[0].clks_cfg.dcfclk_mhz = dml->soc.clock_limits[vlevel].dcfclk_mhz;
-	pipes[0].clks_cfg.socclk_mhz = dml->soc.clock_limits[vlevel].socclk_mhz;
-
-	dml->soc.dram_clock_change_latency_us = table_entry->pstate_latency_us;
-	dml->soc.sr_exit_time_us = table_entry->sr_exit_time_us;
-	dml->soc.sr_enter_plus_exit_time_us = table_entry->sr_enter_plus_exit_time_us;
-
-	wm_set->urgent_ns = get_wm_urgent(dml, pipes, pipe_cnt) * 1000;
-	wm_set->cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(dml, pipes, pipe_cnt) * 1000;
-	wm_set->cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(dml, pipes, pipe_cnt) * 1000;
-	wm_set->cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
-	wm_set->pte_meta_urgent_ns = get_wm_memory_trip(dml, pipes, pipe_cnt) * 1000;
-	wm_set->frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(dml, pipes, pipe_cnt) * 1000;
-	wm_set->frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(dml, pipes, pipe_cnt) * 1000;
-	wm_set->urgent_latency_ns = get_urgent_latency(dml, pipes, pipe_cnt) * 1000;
-	dml->soc.dram_clock_change_latency_us = dram_clock_change_latency_cached;
-
-}
-
-static void dcn301_calculate_wm_and_dlg(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel_req)
-{
-	int i, pipe_idx;
-	int vlevel, vlevel_max;
-	struct wm_range_table_entry *table_entry;
-	struct clk_bw_params *bw_params = dc->clk_mgr->bw_params;
-
-	ASSERT(bw_params);
-
-	vlevel_max = bw_params->clk_table.num_entries - 1;
-
-	/* WM Set D */
-	table_entry = &bw_params->wm_table.entries[WM_D];
-	if (table_entry->wm_type == WM_TYPE_RETRAINING)
-		vlevel = 0;
-	else
-		vlevel = vlevel_max;
-	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.d,
-						&context->bw_ctx.dml, pipes, pipe_cnt);
-	/* WM Set C */
-	table_entry = &bw_params->wm_table.entries[WM_C];
-	vlevel = min(max(vlevel_req, 2), vlevel_max);
-	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.c,
-						&context->bw_ctx.dml, pipes, pipe_cnt);
-	/* WM Set B */
-	table_entry = &bw_params->wm_table.entries[WM_B];
-	vlevel = min(max(vlevel_req, 1), vlevel_max);
-	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.b,
-						&context->bw_ctx.dml, pipes, pipe_cnt);
-
-	/* WM Set A */
-	table_entry = &bw_params->wm_table.entries[WM_A];
-	vlevel = min(vlevel_req, vlevel_max);
-	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.a,
-						&context->bw_ctx.dml, pipes, pipe_cnt);
-
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-
-		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
-		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-
-		if (dc->config.forced_clocks) {
-			pipes[pipe_idx].clks_cfg.dispclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
-			pipes[pipe_idx].clks_cfg.dppclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
-		}
-		if (dc->debug.min_disp_clk_khz > pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
-			pipes[pipe_idx].clks_cfg.dispclk_mhz = dc->debug.min_disp_clk_khz / 1000.0;
-		if (dc->debug.min_dpp_clk_khz > pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
-			pipes[pipe_idx].clks_cfg.dppclk_mhz = dc->debug.min_dpp_clk_khz / 1000.0;
-
-		pipe_idx++;
-	}
-
-	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
-}
-
 static struct resource_funcs dcn301_res_pool_funcs = {
 	.destroy = dcn301_destroy_resource_pool,
 	.link_enc_create = dcn301_link_encoder_create,
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
