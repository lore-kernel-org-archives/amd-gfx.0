Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7A4C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E983F22D0A
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 20:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Dx/V93lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E983F22D0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77BF66E925;
	Fri, 20 Nov 2020 20:20:43 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680083.outbound.protection.outlook.com [40.107.68.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4586E92C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 20:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOzTIvP8QFnbgUhbfCKkPS3jfEQGvKVh5BxvYVTddiAkoIVuC5odbcWv4UYr2LQIlE/6JAJ8GqU8qghTIw9kjKAjxIdo+OoIDDXJVuYb6nhXwZZsxm4wwiaUFimT4tVAqEDh2UjobFWQnsCXHHFPDVXND/WkNnVknELLDj8X0k10fOorvTmRDJMvp9giP44Et50r+Tkv4jCbLAIro5DeZqzd9WBhyW+x+2nW4LCyS6IQu85oCIccFQWvJW9itLwHv2dtZgG1ijkzgc3/TEcXHYOg3a6ijX8/8+EDX+4yqiQ8W7HdcBA7bDihmp/OH6CD3jHiKfeDVNlXVe6LY+gWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDOfaR4Uh+pEf1mbGOkEnlgaVtnUsG7VBOKWCiBEdV8=;
 b=jwwQ1GZ5qoyZvhvgwcYRHCyTEmittnVv0WeCQAeBIMYvwkRdd0XcVTR1PUH56mTjTmNECt06A/y+TcN6nrkvTcvfohEJMCvv7U0puGcm4slzpt2E2i0fwcj7dPBNXslD+GE6D0zgtKFRgXqYKVhVxagjz6C0vd5vS6Ldv9BKeYJjRSFGMifNs6wH6ZJwyyOBNFnhHhfIQwAqYXWD+y3CyI2GME9uu4vBXMD5TyJVvvQbizCcbE+dYsgBqG/52RhGSKd4v9OTZLt4em368oC7ZnNHNYRPHU0I87XJRqeoOqwr9+6hc+OhHH9fjiYWy5qq6We0PiHmbCVq9JHkIrD2Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDOfaR4Uh+pEf1mbGOkEnlgaVtnUsG7VBOKWCiBEdV8=;
 b=Dx/V93lmqEBSwkGrBqYzkKyVxkImpQc82DizWmc25MU6mKptsMvbveHxlKq6DviW0Njh8dEbnIHggg8KuzLYAEvPdYwwdNHWpjweCMdiHsG/HgdgPAUjqx27SVCh7B8XbGCkfOaMBdc1iR92TDmOxkJhzt05t/FvA6QlneMbJsI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 20:20:35 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3589.024; Fri, 20 Nov 2020
 20:20:35 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/18] drm/amd/display: init soc bounding box for dcn3.01.
Date: Fri, 20 Nov 2020 15:19:58 -0500
Message-Id: <20201120201958.2455002-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
References: <20201120201958.2455002-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:610:50::35) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 20:20:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86e6f383-9cba-4200-58ad-08d88d91bcee
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB371701E42A3E2DEFD87ADA6E98FF0@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UjC1eqldhySpEopjadrkvNSpL+nLSG39nv/b/iNMP1+o1Kw2I5cDb+gNbQW4Ro1QT4AXXN3s/4HjcYFnT3JEwsaV67BjWnvsYKwwX2A3qE+yaKVPvDlAdPyXXNYbeYN6Jmf70k0+T0hu5KMAAxqVZ6gGaxlTfWm8yv6FckODYy11sBhyn4jvmrWQMyziPlSaeqsMXIJ/pI1NvTU2QEWTdpiM+ZWtUJ9L0n9JGdu7WW108GMeAPtKNxUqgLbsgrCHJEdlD5OFf0UfPhASH/n7fYWTpy6e2jcj8WGLzqAQury3+mcHuKfLwO8k6Grx7DHIVI70LxGxX+6OaERPuisEIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(86362001)(66476007)(6916009)(8676002)(54906003)(6512007)(8936002)(66946007)(52116002)(6506007)(16526019)(83380400001)(5660300002)(2616005)(186003)(1076003)(6486002)(36756003)(478600001)(66556008)(316002)(4326008)(2906002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: BW7Vivk449zWXHvytyAhTq9vdxskPtEhABxOpi4OvAsg6XDWZV065Yr+owUYWrLcmFuK6UqjGfS5eGDDJlYT7WK+ne7RGXfl7Ncoidi8Wmskjlc+6SjvaDbqTbzVC3mub51e10MDdspLUz/tgvRl+B3WkEFq9oHIzL+LDZgQ4kvhU5amTgmYXqDu6FFkql1pZa9VYNkSI5h+wn8jYU5gLyTPlRJpTOsshf+cjWdmagL/FFmoGfTRjzcUH55BxiS9iJN7/6ng3PtlyZO8YzaUNXY08s9PcJTk+c38DTAEjlxITJ6lXa1R5P9fUkovYx+OVz2pSkIAnRMNSOoDAtV+KnwF1CYcNZKonXrdCOyAojkiq+skdr1h9LstZlyULD4ATi5BzTIsj+ojLXz7GO+kd6PUN+pnAQpONlm71B1qGv+XPx7bzPWBKqm76O3mkB7NSbq1vA5BftRCzFNyD+RGdhzB/ydOWmpKHUAYRA/GF4B9y+hN/hH/vBpDGfuQL81jF8Y3n6hDdsopXAC1Z/klM5auN4sGWvthpxfb0pyqGpcQrvQfGJ3yHvULCSpaFB0UVeIVzgcP8dVGorSD9ZKH6TtKodbgnujC/jrgIa6Tx0n0WUBW+NhxFpU+W+zCJXgEzvvAM/NkcIO9uUFUPo92NsI21dvtP6nfuDTmvYAtE/8rGshn4liOkjrjkiYWhAVir86MpcMRfrcerT8qEcM2ANdLzJFXkn33NjmwHosrMpBwweX1B+4QAs4p36+XlxzGjZUUM8Jw6OmonPNvzbzCm6mywOI+7uCjjSGFFOMA3zL8942LcxIC1EaehAWxTBFn2h73PbYR6+LlksY9YmXSFtfoVQEcOE7s2Bk/ea5jnKMlk/rC/XiLIaIZ6cjLBIvMVbW/L8e23VoqDq51A8Sw9h5nSa/UJLnrylF330PXiaVC5cQdYtHpzctfsSixoww+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e6f383-9cba-4200-58ad-08d88d91bcee
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 20:20:35.4415 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dv/2YtrFGKXwoh/T61FexXNG7Fx8cX0QuZbcoAf8aBB3uITtr0oCOIRERWY4tRI7p/28/MZaLSAf4LrxO9ZUIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Tony Cheng <Tony.Cheng@amd.com>,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why & How]
Update init soc bounding box and bw bounding box for DCN3.01.
Remove pp smu interface which isn't used.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn301/dcn301_resource.c   | 118 +++++++++---------
 1 file changed, 60 insertions(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 4b029631a22c..124ae5253d4b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1345,9 +1345,6 @@ static void dcn301_destruct(struct dcn301_resource_pool *pool)
 
 	if (pool->base.dccg != NULL)
 		dcn_dccg_destroy(&pool->base.dccg);
-
-	if (pool->base.pp_smu != NULL)
-		dcn301_pp_smu_destroy(&pool->base.pp_smu);
 }
 
 struct hubp *dcn301_hubp_create(
@@ -1600,41 +1597,25 @@ static bool init_soc_bounding_box(struct dc *dc,
 		}
 	}
 
-	if (pool->base.pp_smu) {
-		struct pp_smu_nv_clock_table max_clocks = {0};
-		unsigned int uclk_states[8] = {0};
-		unsigned int num_states = 0;
-		enum pp_smu_status status;
-		bool clock_limits_available = false;
-		bool uclk_states_available = false;
+	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
+	loaded_ip->max_num_dpp = pool->base.pipe_count;
+	dcn20_patch_bounding_box(dc, loaded_bb);
 
-		if (pool->base.pp_smu->nv_funcs.get_uclk_dpm_states) {
-			status = (pool->base.pp_smu->nv_funcs.get_uclk_dpm_states)
-				(&pool->base.pp_smu->nv_funcs.pp_smu, uclk_states, &num_states);
+	if (!bb && dc->ctx->dc_bios->funcs->get_soc_bb_info) {
+		struct bp_soc_bb_info bb_info = {0};
 
-			uclk_states_available = (status == PP_SMU_RESULT_OK);
-		}
+		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
+			if (bb_info.dram_clock_change_latency_100ns > 0)
+				dcn3_01_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
 
-		if (pool->base.pp_smu->nv_funcs.get_maximum_sustainable_clocks) {
-			status = (*pool->base.pp_smu->nv_funcs.get_maximum_sustainable_clocks)
-					(&pool->base.pp_smu->nv_funcs.pp_smu, &max_clocks);
-			/* SMU cannot set DCF clock to anything equal to or higher than SOC clock
-			 */
-			if (max_clocks.dcfClockInKhz >= max_clocks.socClockInKhz)
-				max_clocks.dcfClockInKhz = max_clocks.socClockInKhz - 1000;
-			clock_limits_available = (status == PP_SMU_RESULT_OK);
-		}
+			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+				dcn3_01_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
 
-		if (clock_limits_available && uclk_states_available && num_states)
-			dcn20_update_bounding_box(dc, loaded_bb, &max_clocks, uclk_states, num_states);
-		else if (clock_limits_available)
-			dcn20_cap_soc_clocks(loaded_bb, max_clocks);
+			if (bb_info.dram_sr_exit_latency_100ns > 0)
+				dcn3_01_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
+		}
 	}
 
-	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
-	loaded_ip->max_num_dpp = pool->base.pipe_count;
-	dcn20_patch_bounding_box(dc, loaded_bb);
-
 	return true;
 }
 
@@ -1682,36 +1663,58 @@ static void set_wm_ranges(
 	pp_smu->nv_funcs.set_wm_ranges(&pp_smu->nv_funcs.pp_smu, &ranges);
 }
 
-static struct pp_smu_funcs *dcn301_pp_smu_create(struct dc_context *ctx)
+static void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct pp_smu_funcs *pp_smu = kzalloc(sizeof(*pp_smu), GFP_KERNEL);
-
-	if (!pp_smu)
-		return pp_smu;
-
-	if (!IS_FPGA_MAXIMUS_DC(ctx->dce_environment) && !IS_DIAG_DC(ctx->dce_environment)) {
-		dm_pp_get_funcs(ctx, pp_smu);
-
-		/* TODO: update once we have n21 smu*/
-		if (pp_smu->ctx.ver != PP_SMU_VER_NV)
-			pp_smu = memset(pp_smu, 0, sizeof(struct pp_smu_funcs));
-	}
-
-	return pp_smu;
-}
+	struct dcn301_resource_pool *pool = TO_DCN301_RES_POOL(dc->res_pool);
+	struct clk_limit_table *clk_table = &bw_params->clk_table;
+	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
+	unsigned int i, closest_clk_lvl;
+	int j;
+
+	// Default clock levels are used for diags, which may lead to overclocking.
+	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+		dcn3_01_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
+		dcn3_01_ip.max_num_dpp = pool->base.pipe_count;
+		dcn3_01_soc.num_chans = bw_params->num_channels;
+
+		ASSERT(clk_table->num_entries);
+		for (i = 0; i < clk_table->num_entries; i++) {
+			/* loop backwards*/
+			for (closest_clk_lvl = 0, j = dcn3_01_soc.num_states - 1; j >= 0; j--) {
+				if ((unsigned int) dcn3_01_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
+					closest_clk_lvl = j;
+					break;
+				}
+			}
 
-static void dcn301_pp_smu_destroy(struct pp_smu_funcs **pp_smu)
-{
-	if (pp_smu && *pp_smu) {
-		kfree(*pp_smu);
-		*pp_smu = NULL;
+			clock_limits[i].state = i;
+			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+
+			clock_limits[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+			clock_limits[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+			clock_limits[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			clock_limits[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			clock_limits[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			clock_limits[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			clock_limits[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		}
+		for (i = 0; i < clk_table->num_entries; i++)
+			dcn3_01_soc.clock_limits[i] = clock_limits[i];
+		if (clk_table->num_entries) {
+			dcn3_01_soc.num_states = clk_table->num_entries;
+			/* duplicate last level */
+			dcn3_01_soc.clock_limits[dcn3_01_soc.num_states] = dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
+			dcn3_01_soc.clock_limits[dcn3_01_soc.num_states].state = dcn3_01_soc.num_states;
+		}
 	}
-}
 
-static void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-{
 	dcn3_01_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+
+	dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_DCN30);
 }
 
 static struct resource_funcs dcn301_res_pool_funcs = {
@@ -1862,9 +1865,8 @@ static bool dcn301_resource_construct(
 		goto create_fail;
 	}
 
-	/* PP Lib and SMU interfaces */
-	pool->base.pp_smu = dcn301_pp_smu_create(ctx);
 	init_soc_bounding_box(dc, pool);
+
 	if (!dc->debug.disable_pplib_wm_range && pool->base.pp_smu->nv_funcs.set_wm_ranges)
 		set_wm_ranges(pool->base.pp_smu, &dcn3_01_soc);
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
