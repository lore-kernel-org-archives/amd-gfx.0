Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D505CF34D5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D23FC10E9B8;
	Thu,  3 Oct 2024 23:36:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b9F91ogp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC72A10E9B6
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPdQyXdQjn/m5Ur1KqGo/eWPGdYchcfbovhxhh0m93KeYBiWBriDVaOIyOjNgPyTb4JDkXvua3H46438kLqWfKMbaO9Bk84VjaXzThc0M87IL5P72b7lzNT2et9Xk0ZJmTC/B0j2UMp9w78kMG2b7+aVAqYAY1YkNcf823c0sitiR9+Wvw2Dxepcw4rrA0Gl6EcGa4b+Ohjm+wZ93Xtx6KK3RqmrXQhZiK6Vr4tv+HBbjoMqJIoet/BSKpxAR1yJAXk1DL9ZzL3OBUvs0BKjzQZU5echXD2fOrApheptdoO/48Tu5Fr0ymvSxUQxpS0eCgI0DuRzMycEO1DUtz5a3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHNLXd6QfYEHrIXyFRRwHKADqJ7ZEfvzc2hv7KaNzeM=;
 b=ubNCN/OHxFB/NUPAo63DWhoO5AsMxW5RrDcfpbVdvMrflwvRSn6dJBZCzxdK1UllWxhkVBHlDttU7PcpTWzPXuA0V1WXBrmYn9Wt+lTE88Ax6mfV1bt65utZ+y2y70+4iKrtvGGF6lYqCqA5TDp1GIF4/Ul2x9NnFCnSonKI0mQkJOTGiyTGhFuu0cWKu/qn6ICCSNUWXYBALEx0LkvvdHOsgxGtx+KlH1Zv1RqIAr38n0XKzzeNlppDOQhYcZpTc7KOjzIglUWYtBKz6r/8w7Jo57f3+0NC5wGPdWxydU61C69+2P/gnaubMpFpTWAdtwL8LtTHptNJj4BXfzsfBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHNLXd6QfYEHrIXyFRRwHKADqJ7ZEfvzc2hv7KaNzeM=;
 b=b9F91ogpxqZaAY9fTPYbNWWFDWvNBbA645zVUJWcKB5CDzG4rrlJgd7H+ivgZ77NyhvqchY+/BEcMkR0s0eWWUu6/dm4sS/4V6BwEgAM8gHiT5ca2mjP0Nuku+dEQ62BXIF6GddFqgyRi00eSIudB1olVK322bPSRyffULo6CAI=
Received: from DM5PR07CA0087.namprd07.prod.outlook.com (2603:10b6:4:ae::16) by
 SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 23:36:16 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::68) by DM5PR07CA0087.outlook.office365.com
 (2603:10b6:4:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:36:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:36:15 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:36:08 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 20/26] drm/amd/display: Update Interface to Check UCLK DPM
Date: Thu, 3 Oct 2024 17:33:38 -0600
Message-ID: <20241003233509.210919-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 38e3f9a9-a45e-4746-32a9-08dce4042c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xHA6iyJujmQz8BBb5jkmmjX1E9pYmO0J5QiJTa+1qZ9P/wFaMY9v4GJTvZhx?=
 =?us-ascii?Q?xl32KXPUL0QqZKWG0lsCostpOH8G4pCh9PIUccB8bNUP5bZfP7A2/FFAtMx+?=
 =?us-ascii?Q?Wb0tz8tvbAwKRW40k1uLTZmgCKhzh6veiQpdyHizDbL5sA4Gz+qPxFxVl0gG?=
 =?us-ascii?Q?4tlbliR3MNlKXKM4BLE+PQ2f7TGSpD6kZKU7uG0RFGf/DdBq0UjsZwWuAGuh?=
 =?us-ascii?Q?f5udiH0ch1xvVmj+UxnqDADySQCThHYAocCW556cND1BIpKita6wwQPqe7KX?=
 =?us-ascii?Q?Hsp9s8+OFCDQ7Y52QFn8AdUlnE2LkS7AFM4X7c70OnIIwmu5WTneA5nUqTH7?=
 =?us-ascii?Q?VFpxzXfqOrq5v8osUbL3XPUnyJHI8aCsZ/XuZ8Wz82XVwcYl3OoXRtBPONxK?=
 =?us-ascii?Q?naYjd7ROTQcJ+q0w2LiPM1V4a52SAmufUyXhbUaMVQBWCztmv0Segv/aWuiX?=
 =?us-ascii?Q?wsAeObbnsvyvB0FBzE4Ta0rLHx6cHXF200MVmMRgYMdBKGaR0pveMkA/c3XT?=
 =?us-ascii?Q?5W21gNC94C+IXkyxJAYf3Klq4VzYVtr3wCfpbVbN7/NLjmmkQvqL1pOPy0OS?=
 =?us-ascii?Q?uID/cNx9a8cdFEezzcPMXK4a9MlNowRHf1CHVYNa02PKYFyQaP3pLMWYuF0z?=
 =?us-ascii?Q?NKY9YVJT9lUTrPZ7qhT2eqp2tms1Oa9+SjAFw3xmBmLtGeAm7cQabaGXUW9u?=
 =?us-ascii?Q?+UnRbrnUJp8CUjGR6AAE1+GCZMpfcn/4Aev1oCSABxEo917gn9XB1M7QAshs?=
 =?us-ascii?Q?5Mh195ljjRdZ3dxmyWqxESECp2pvk6PiVDDkim8rWe9nnjXNpiHoKuNeBtxX?=
 =?us-ascii?Q?9CFhZOUHXiwqzb8h9Gpb4PJF/g6jYN/GAes5nOJ3fZgriBw0itCaa7PnG82w?=
 =?us-ascii?Q?a1hm1LkbTEGJJxHTZda6rj26sC/nAz8NaPbn/cxHMir+KgZyXCkTWZFSLU3C?=
 =?us-ascii?Q?AVMZ39SyEbaLgrGKaVYULmeKAmcyxAPan7wKz9CjDycmhsEQkvCBnLtET16C?=
 =?us-ascii?Q?L4lPdDkxaIxqvX+rBLAKmg9cMfxuKXyrIiCjXXpsaxZolOf7mNUwzxvFi9gN?=
 =?us-ascii?Q?6ODZkHwW64y0trfHRBjXmn9ScM+2kVKpHzTjXL8blVAanxh37A87DdpS2G8H?=
 =?us-ascii?Q?SMKbeOhCwWZHsSg4FNeESSGeggbFm9N9O0dL3TLMZpYoVoXYdJGvqQ0rrv3f?=
 =?us-ascii?Q?BPjLVd8TaDNMki+hLB0EZoXahx06mnclrV8CPTRoRjtBAEJgUz3J3AQJQUrU?=
 =?us-ascii?Q?RwPj6E3Rm6wFiJG4BjBMJJ2TFHuGRixtHHtpHbLmeKhGrTusIZyIZuKfM8fr?=
 =?us-ascii?Q?yKbsqrSWBmCulj4aLeDgLO8AW7CQB+Bte0spP5rLH+5JFuazdd9n09oLto1l?=
 =?us-ascii?Q?J2jtrHk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:36:15.6870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e3f9a9-a45e-4746-32a9-08dce4042c95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
Videos using YUV420 format may result in high power being used.
Disabling MPO may result in lower power usage.
Update interface that can be used to check power profile of a dc_state.

[How]
Add helper functions that can be used to determine power level:
- get power profile after a dc_state has undergone full validation

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c        |  7 ++++++-
 drivers/gpu/drm/amd/display/dc/inc/core_types.h |  4 ++++
 .../dc/resource/dcn315/dcn315_resource.c        |  6 ++++++
 .../dc/resource/dcn401/dcn401_resource.c        | 17 +++++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2d704c264b88..d1e397d5f84e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6071,7 +6071,12 @@ struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state
 {
 	struct dc_power_profile profile = { 0 };
 
-	profile.power_level += !context->bw_ctx.bw.dcn.clk.p_state_change_support;
+	if (!context || !context->clk_mgr || !context->clk_mgr->ctx || !context->clk_mgr->ctx->dc)
+		return profile;
+	struct dc *dc = context->clk_mgr->ctx->dc;
 
+
+	if (dc->res_pool->funcs->get_power_profile)
+		profile.power_level = dc->res_pool->funcs->get_power_profile(context);
 	return profile;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index bfb8b8502d20..8597e866bfe6 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -215,6 +215,10 @@ struct resource_funcs {
 
 	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
 	void (*build_pipe_pix_clk_params)(struct pipe_ctx *pipe_ctx);
+	/*
+	 * Get indicator of power from a context that went through full validation
+	 */
+	int (*get_power_profile)(const struct dc_state *context);
 };
 
 struct audio_support{
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 3f4b9dba4112..f6b840f046a5 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1812,6 +1812,11 @@ static void dcn315_get_panel_config_defaults(struct dc_panel_config *panel_confi
 	*panel_config = panel_config_defaults;
 }
 
+static int dcn315_get_power_profile(const struct dc_state *context)
+{
+	return !context->bw_ctx.bw.dcn.clk.p_state_change_support;
+}
+
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
@@ -1840,6 +1845,7 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.update_bw_bounding_box = dcn315_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn315_get_panel_config_defaults,
+	.get_power_profile = dcn315_get_power_profile,
 };
 
 static bool dcn315_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index f2653a86d3e7..59184abab1a7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1688,6 +1688,22 @@ static void dcn401_build_pipe_pix_clk_params(struct pipe_ctx *pipe_ctx)
 	}
 }
 
+static int dcn401_get_power_profile(const struct dc_state *context)
+{
+	int uclk_mhz = context->bw_ctx.bw.dcn.clk.dramclk_khz / 1000;
+	int dpm_level = 0;
+
+	for (int i = 0; i < context->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels; i++) {
+		if (context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz == 0 ||
+			uclk_mhz < context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz)
+			break;
+		if (uclk_mhz > context->clk_mgr->bw_params->clk_table.entries[i].memclk_mhz)
+			dpm_level++;
+	}
+
+	return dpm_level;
+}
+
 static struct resource_funcs dcn401_res_pool_funcs = {
 	.destroy = dcn401_destroy_resource_pool,
 	.link_enc_create = dcn401_link_encoder_create,
@@ -1714,6 +1730,7 @@ static struct resource_funcs dcn401_res_pool_funcs = {
 	.prepare_mcache_programming = dcn401_prepare_mcache_programming,
 	.build_pipe_pix_clk_params = dcn401_build_pipe_pix_clk_params,
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
+	.get_power_profile = dcn401_get_power_profile,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
-- 
2.45.2

