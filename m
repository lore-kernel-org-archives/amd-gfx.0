Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10887EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8117C10E5BA;
	Wed, 12 Jul 2023 17:14:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29DA010E5B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvxAxqn9Ln6CPdBbM0sQHIr1hXk4x4HP4VvPpBcV3eyond4dGPxSB7Mw/cfppZza9mfCM17/wmzRK2u5CRNDA1UfjZpeip9NkXgy6eK2LTqHlZ0wMZFnONJwLdA4kWdt/3kOhURgTgwo4q/MoflPWA+OAEt18MSBYLWdoZY9TRn6Mhyb8WgkCfLDg63eNu9kOSxraQb49hmZt0z+9Q9wjtSZOodaWw0b28AqjHR3Fc9vs6v8ibRXx9wM+Er7nnrHl2U4zXYbTTx+D+G+n9CYzvpE8yK4v3s59qOlwry1yRKjeTHGAhkDlPpWgZkqufKvXSLmedfG4PjGofLP9adlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCvfMj4RpTyLDTOKDoek8OS8zYUMF/qBqQZHKjHALyQ=;
 b=jcg0REzNUu2t8iC4SdzxWhAUQzKs8JNAkLAB33WF2J8N4SXLE5avBL8S0LtL3fsahgpjVnPgpcVn8pyi0uDT6er5J9M+VoHOxXkFW3X4gYOrMsDEbGA85+e36/S3vKUgqy+sZG0KMn2WfWbNffOyd4JbSgx2dnxP5E6pxPHdUdtXqQlxTGXK7Ve3bewMKhrwvAmBlZh76kmXDpffJq3N3+Qx1uuHAygjPProz5VfiEVfMzkl2MmHWWIxtA26ojq+jXBmrnFLTV+W/fqRevaN3lC1dQSrWOsRttF4XSDIhQbEuIN6/O/FftBcJLm40RmDjDJVWqLKuelX1k5I7Nh+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCvfMj4RpTyLDTOKDoek8OS8zYUMF/qBqQZHKjHALyQ=;
 b=bLjtGWFU4UoUzVFgzu1k5qvJy2/z3F59O/zEAQ9UVKs5Ov/ykW24RZxJIHwonbG5YhB0JbViMHA7FKbbCsDfT+I1wDsPjv53Ky/Scl4xv43MROkOyJzS8gxFpYU6goGHtBVrxenlA8gew6DaZeEpurSdp8xxYO99WtApjroXKLg=
Received: from BN6PR17CA0049.namprd17.prod.outlook.com (2603:10b6:405:75::38)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 17:14:27 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::70) by BN6PR17CA0049.outlook.office365.com
 (2603:10b6:405:75::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 17:14:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:14:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:14:26 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:14:22 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 27/33] drm/amd/display: add additional refresh rate conditions
 for SubVP cases
Date: Thu, 13 Jul 2023 01:11:31 +0800
Message-ID: <20230712171137.3398344-28-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d75ada-9384-4eb1-790a-08db82fb722a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JBBYmLFM08FX9fLeI5nF+hprl5rcbf+N+eylH3LPNG6cxzRv7yPkB6rWX982VW1ot1kCa10hkc40xY8bTH0ODc71AFIqwljsVqNTpTVTzk9sY0GLYeCDXnx+3WfWbaKRVocVzyfwO6R0xYaQtBmOb2EPCvWCIoZB9wBGrlS5Iw6znH92zWQ4gqjbPH+/3s8L3fsCLQvYlhKfauCbwv/4M6+nwhKcB4g77MUoQQZyAWr1fkCqXklsWOmTOnJGfwgGrXi1rzTbcnlK5fggzDGIRWVgkQM+7oAWJ0hhLYF+IjXJVMhar86PnQO/60SrogklaYN/Gp+SFDZKx1IJVNVEwJEIJKj8mPu4ivQgiUhDURwwbGr2OYOYtG7fy/3iczMJFoMvXN1VE0xrui0k/5AEnddtIGKdq7Gr54FlDoUxXusIf3a19+w4j+ShcgQUeOH4WobYTyrBYYoz4UtTHM1s8s9Tpa/flAUGy9CalRwLNXdx4m9KcfhYCQv/jImPW5xcdTATeta2mJAYsVsgobFESllCGwmj8VXUJXCx5D4bApL7hr0xLrScLhJb9bBRfm1rOIt8Sa4xEj+LsnZb27KyVjKqG9ob7uDAl9mSTHt59z53BGKu5B92+zjkDdjkFM1V6peJc+4MdbgF/iw0wDR7ktPsbB7GA9tLKEYeccjazZA64cC48G+1QsqVbrvJja4dZqeyL7G4I/ztvi3KffpyHqmU/qk8OQ0FO5ZQabhpX/T8U6JM5Uj6r0PO1LMpSsnZnmYgrx8mgYormfexIf5L8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(478600001)(7696005)(6916009)(4326008)(70206006)(6666004)(36756003)(41300700001)(316002)(86362001)(70586007)(54906003)(47076005)(1076003)(83380400001)(40480700001)(2616005)(336012)(186003)(426003)(26005)(82740400003)(40460700003)(356005)(81166007)(2906002)(8936002)(8676002)(5660300002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:14:26.6376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d75ada-9384-4eb1-790a-08db82fb722a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <samson.tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <samson.tam@amd.com>

[Why]
Want to further constrain these refresh rate conditions for SubVP:
- SubVP + SubVP: either both <= 120Hz or both between 120-165Hz
- SubVP + DRR: SubVP <= 120Hz
- SubVP + VBlank: SubVP <= 120Hz

[How]
Add constraints in subvp_subvp_admissable(),
dcn32_subvp_drr_admissable() and dcn32_subvp_vblank_admissable()

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
---
 .../display/dc/dcn32/dcn32_resource_helpers.c | 24 +++++++++++++++----
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 20 +++++++++-------
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 5be242a1b82c..db9c55a09d9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -641,6 +641,7 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 	uint8_t non_subvp_pipes = 0;
 	bool drr_pipe_found = false;
 	bool drr_psr_capable = false;
+	uint64_t refresh_rate = 0;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -649,8 +650,14 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 			continue;
 
 		if (pipe->plane_state && !pipe->top_pipe) {
-			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN)
+			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				subvp_count++;
+
+				refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
+					pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
+				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
+				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.h_total);
+			}
 			if (pipe->stream->mall_stream_config.type == SUBVP_NONE) {
 				non_subvp_pipes++;
 				drr_psr_capable = (drr_psr_capable || dcn32_is_psr_capable(pipe));
@@ -662,7 +669,8 @@ bool dcn32_subvp_drr_admissable(struct dc *dc, struct dc_state *context)
 		}
 	}
 
-	if (subvp_count == 1 && non_subvp_pipes == 1 && drr_pipe_found && !drr_psr_capable)
+	if (subvp_count == 1 && non_subvp_pipes == 1 && drr_pipe_found && !drr_psr_capable &&
+		((uint32_t)refresh_rate < 120))
 		result = true;
 
 	return result;
@@ -693,6 +701,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 	bool drr_pipe_found = false;
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 	bool vblank_psr_capable = false;
+	uint64_t refresh_rate = 0;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -701,8 +710,14 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 			continue;
 
 		if (pipe->plane_state && !pipe->top_pipe) {
-			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN)
+			if (pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 				subvp_count++;
+
+				refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
+					pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
+				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
+				refresh_rate = div_u64(refresh_rate, pipe->stream->timing.h_total);
+			}
 			if (pipe->stream->mall_stream_config.type == SUBVP_NONE) {
 				non_subvp_pipes++;
 				vblank_psr_capable = (vblank_psr_capable || dcn32_is_psr_capable(pipe));
@@ -715,7 +730,8 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
 	}
 
 	if (subvp_count == 1 && non_subvp_pipes == 1 && !drr_pipe_found && !vblank_psr_capable &&
-			vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_vblank_w_mall_sub_vp)
+		((uint32_t)refresh_rate < 120) &&
+		vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_vblank_w_mall_sub_vp)
 		result = true;
 
 	return result;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index a95034801712..0e2f25985378 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1040,7 +1040,7 @@ static bool subvp_subvp_admissable(struct dc *dc,
 	uint32_t i;
 	uint8_t subvp_count = 0;
 	uint32_t min_refresh = subvp_high_refresh_list.min_refresh, max_refresh = 0;
-	uint32_t refresh_rate = 0;
+	uint64_t refresh_rate = 0;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
@@ -1050,19 +1050,21 @@ static bool subvp_subvp_admissable(struct dc *dc,
 
 		if (pipe->plane_state && !pipe->top_pipe &&
 				pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
-			refresh_rate = (pipe->stream->timing.pix_clk_100hz * 100 +
-					pipe->stream->timing.v_total * pipe->stream->timing.h_total - 1)
-					/ (double)(pipe->stream->timing.v_total * pipe->stream->timing.h_total);
-			if (refresh_rate < min_refresh)
-				min_refresh = refresh_rate;
-			if (refresh_rate > max_refresh)
-				max_refresh = refresh_rate;
+			refresh_rate = (pipe->stream->timing.pix_clk_100hz * (uint64_t)100 +
+				pipe->stream->timing.v_total * pipe->stream->timing.h_total - (uint64_t)1);
+			refresh_rate = div_u64(refresh_rate, pipe->stream->timing.v_total);
+			refresh_rate = div_u64(refresh_rate, pipe->stream->timing.h_total);
+
+			if ((uint32_t)refresh_rate < min_refresh)
+				min_refresh = (uint32_t)refresh_rate;
+			if ((uint32_t)refresh_rate > max_refresh)
+				max_refresh = (uint32_t)refresh_rate;
 			subvp_count++;
 		}
 	}
 
 	if (subvp_count == 2 && ((min_refresh < 120 && max_refresh < 120) ||
-			(min_refresh >= 120 && max_refresh >= 120)))
+		(min_refresh >= 120 && max_refresh <= 165)))
 		result = true;
 
 	return result;
-- 
2.34.1

