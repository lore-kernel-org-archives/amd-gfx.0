Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75C4C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA0610E8AF;
	Thu,  6 Oct 2022 21:27:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B8210E8AA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EORJfI7p/NdiU+UpsU+ZxL47Aoawy9cR3YG+ueB3g3KWR4jTuyE1SZSJVOKkedr2iGjxfWmA+dHHEksBOZD8Ax2d5ogKZQUsjyA9shUSs0WAjoSPRYqADje6xV0Zky+ngeHnyAC+Ceo3wPsmBJQ3jsP/BAbu6bq6LWnVi3hGsaZXJBhMWdGZSvcOQPMHjofx4AP2lKCzL6zaE8S+QlX0SGJqivDdA3hcVKcy4D/SZnkELMjAGPgGeXRLSJ57qqt5Xi2O5OPZt0Fx8f/Svr3wLzFjyZdQJCO+xXJ0DAq77BFehoYk52qoiDKmqIX+jU5we5vR/OMAXXhMfMlLc/97Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFu7JzgdrLpEs3nFRNkSpd9etcIzq7PNaGscBRdMBzA=;
 b=VWAjsoCeB61hfrGJedPy0SqbPPIhZ/Q3UO6OUOUKmZYIaaYw7dyiO57qKZDqL/IU+iPna4p2Nd9lA2nkxuCoWnPR/DLI032dfNN0mQ0scXYRFcDuQgoUD7FIvdwrtwSQxxCP0akZct1UtQ1jNU2JxBbTZwQjsh6cmJBWNZMXko8U6SBlAwpwP1vsLHPibneezHBZuykVKKt312Qdk6nU9oy66pHQJAaizqnhI1SKrU5wB6mRZbF/sQum+Ofp/OzHmhkrXVwUd6R9pF30gvSf+nm7TiCfoe9Us8L0E1lw0rg3/Pznd0PCyErF4AK3xL/3qsptTh40AMgdItnPgqT8ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFu7JzgdrLpEs3nFRNkSpd9etcIzq7PNaGscBRdMBzA=;
 b=IZV6zb+YH1szuahNu/Z4JOz/WOzpdQ6iDJGXfoOKVj1vY39FzO9jSuYP5os2dems39apWxoaCONuXo7YubC31aTvJHyc//LOCvVX4IDPqYGEJj27P4bgJxpBi75EaE9/HOjZaZdnxxudZXT+olfsvWyWZvrv3z7P+A7AZ/R0agc=
Received: from BN8PR03CA0002.namprd03.prod.outlook.com (2603:10b6:408:94::15)
 by PH8PR12MB7280.namprd12.prod.outlook.com (2603:10b6:510:220::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:27:33 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::f1) by BN8PR03CA0002.outlook.office365.com
 (2603:10b6:408:94::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:32 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:31 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/23] drm/amd/display: properly configure DCFCLK when
 enable/disable Freesync
Date: Thu, 6 Oct 2022 17:26:30 -0400
Message-ID: <20221006212650.561923-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT066:EE_|PH8PR12MB7280:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3c3d7b-25e5-4b50-ab0b-08daa7e194b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvPr+l0WF7eTR++aQTHIBijZnkP6gE2Ac6j913CAAzNhL5B40E6Zd4/wt5bqziAYWViDuSbZtfks+/gQBRDHMj88lNOCn2xj3zVXF+KQFc05yj2J5fL6b5Cp3MyPY3C8gHUv2RjraDxQ3Tj0PHz09sv5t+Voi6qVNCjga737LE8OvKeC3cm9b9T0o1OZPgSSw5vPKZLS++R+imlvsAw0QDZ8dFwq1Qk3SvWWmJAyc8WX4V4RsqnsIYH2/mie1uhLqLYJdMgg6Cv1GRTXstj1XeBK7i/+a8ebkhk768Z8c8GxYcd7Ah1IZnSGqwKQ8RrOy97ozQ4Lur6ElBgPszI6hv3aaJNlUijI5EvLNQ2p6RHaRTTP+AuB495DUOkK6cwrZlC6JygbLepLcXsMsRc/D2qvYeY7UI90l9Z8MbNKw52kgEFFyMCSSmzslvUMjbCFP/rUe73P+1UoHnUtYdb/dp0OMohDwrf1GpQ9S7kKsYAZEDYlTL09z0dvi/+QGfDQvur1CMfaYp01liRN0kt8Liou9DdRTgUdDf3Z0R3OisYhsT1zx2ZxJik/T788ZpD8JM5GrbehPDt4Qc5Zj0Sm1RQw3G78s64+n4rPKft9IJlgqJmlKJ7G8dKHMcgG6YJFLlpPaoPQsY5GvL5Oxu3UKzE/4pkX4Ga5h8c5xLpRSPoYLzVp8SUFQ5sEmkO0vmQZG1nARm6YE4efDhiJVHNVaneLUD5lf9ggPEJAu094q+hCB6fdmtZvAe+LQ4Dc56IdwvDokZRi1pEcE7T0x2gnGdzqwA2hdouuqY6OR+SzHAc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(4326008)(83380400001)(86362001)(16526019)(81166007)(82740400003)(54906003)(478600001)(2616005)(41300700001)(6916009)(356005)(316002)(8676002)(40460700003)(26005)(70206006)(44832011)(336012)(82310400005)(5660300002)(2906002)(47076005)(8936002)(1076003)(426003)(186003)(70586007)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:32.9651 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3c3d7b-25e5-4b50-ab0b-08daa7e194b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7280
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
Cc: stylon.wang@amd.com, Vladimir Stempen <vladimir.stempen@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Nevenko
 Stupar <Nevenko.Stupar@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Vladimir Stempen <vladimir.stempen@amd.com>

[Why]
Bandwidth validation is using Freesync parameters
from previous Freesync state.
Bandwidth validation ignores DCFCLK calculated
after Freesync parameters are configured

[How]
Set Freesync bandwidth parameters to its default
state before running bandwidth validation.
Take DCFCLK calculated after Freesync bandwidth
parameters are assigned and bandwidth is
recalculated.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Vladimir Stempen <vladimir.stempen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 7 ++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 9585b25f10e5..a88dd7b3d1c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1805,6 +1805,13 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 	int pipe_cnt = 0;
 	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
 	struct mall_temp_config mall_temp_config;
+
+	/* To handle Freesync properly, setting FreeSync DML parameters
+	 * to its default state for the first stage of validation
+	 */
+	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
+	context->bw_ctx.dml.soc.dram_clock_change_requirement_final = true;
+
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	/* For fast validation, there are situations where a shallow copy of
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 6bdd509d292a..819de0f11012 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1769,6 +1769,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	int i, pipe_idx, vlevel_temp = 0;
 	double dcfclk = dcn3_2_soc.clock_limits[0].dcfclk_mhz;
 	double dcfclk_from_validation = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+	double dcfclk_from_fw_based_mclk_switching = dcfclk_from_validation;
 	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] !=
 			dm_dram_clock_change_unsupported;
 	unsigned int dummy_latency_index = 0;
@@ -1804,7 +1805,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 					dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 			dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
 			maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
-			dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+			dcfclk_from_fw_based_mclk_switching = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 			pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] !=
 					dm_dram_clock_change_unsupported;
 		}
@@ -1890,6 +1891,10 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	pipes[0].clks_cfg.dcfclk_mhz = dcfclk_from_validation;
 	pipes[0].clks_cfg.socclk_mhz = context->bw_ctx.dml.soc.clock_limits[vlevel].socclk_mhz;
 
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+		pipes[0].clks_cfg.dcfclk_mhz = dcfclk_from_fw_based_mclk_switching;
+	}
+
 	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
 		min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
 		min_dram_speed_mts_margin = 160;
-- 
2.25.1

