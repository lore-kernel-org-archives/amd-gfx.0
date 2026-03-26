Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCED109E543
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:01:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F405310E936;
	Thu, 26 Mar 2026 03:01:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mzT5SGji";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F7A210E933
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAhT5lnCBNRDjnMPmyMVDlyVJE2XnzBafPie435YZ3zLuH2DOhBcB7iR8g5ssXcuIpFdkX1pvYKjVops+UOKUbSrvyOy9FXgZQm4SHoqJEolnVG9laQ/Lqof/pHHJrqpU6P4Gm6/9obaToRBnQFlsrBaCtzk5L7ppnyd2333xynzcvQc3auBrR+YnzwmqHoiu/G4Lb7Do8IYv2hKtf9KhaCWrn/Pe0uHSUycTuX+KMciOe9+yrJ8zXrnSmnlIrnRcG+gX0TwUt0+KK2g4Xeem1oUkb/OZLD6fP0a9MJGDI3Z3Qn2ScXVg7oEsXc19VeOuKuYUxvsTU7AWv+D7iNLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSdoYDdqtHM1JgQcdn3e1sRJbxGnj9dkWpozF2y2zF4=;
 b=LLhIqavg5KDxbCD6NwYjJz1lzMfw5PuHxyg7vE/1TFN2mT+UKTIp9DEpPFGYr7N8AHbaXL8qfp2icDwnWYm2+bTFfQDWhxvbWm/pdm1+dS988Oavf9ntCRqbmAJEiBlmeuEN5lgaE/Qi/vB4+kkTRHcDfAzlPGBzhFbURDfO+tXL9EdRinZHHRtNTnr/V8lVv95VlLtnqZK2W5MWGneIkQOVKJq9JsPM1fX6noU34UoVGa5qAgUvZ9XrXkya92W0S7MzWBPUpg62K421oI+jZWOrCZ7iuNXUhYSX581eZvKbOSSoYW0Hro+Sn1BsxGb/wC/RN4tZfN2go9Ca82LPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSdoYDdqtHM1JgQcdn3e1sRJbxGnj9dkWpozF2y2zF4=;
 b=mzT5SGjihtdanBxY+uFspgcKH7C48FCYm5b/Zu2MY2LaAQE11g5neC9KQIGdZWewsEpDaUYM7BC59Qu86eptypoKhfVqCb7FCCtwrvrUdbRcBTF3biLjFhb8xCiejRH2wa+ossKKMJoU7IxDt5vBC3pK8JdVN1eWRPFGH83r+hM=
Received: from MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 03:01:15 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::72) by MN2PR15CA0063.outlook.office365.com
 (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:01:14 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:01:10 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Austin Zheng
 <austin.zheng@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 12/30] drm/amd/display: Fix silence signed/unsigned
 mismatch warnings in dml
Date: Thu, 26 Mar 2026 10:57:03 +0800
Message-ID: <20260326030153.406612-13-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ec2d16-4dd9-4ec5-96bb-08de8ae3f178
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: smBDPVP5VEwz4Zj+1pxq4V+sBqtsaSAFCU/qmyA2SMtsLh3GCNRoYjqES1uxhvlfiZdCiJ5WXEryODWnA83mNWOzjz/B9oe0o8r0d9KYVzoTnICsamoUDfEyB683gc7MoDwJz8EoTzsZ0wOgVJF64ZmXXM2D3ajDVupO92vGIoeCROLuAp1gXy6E0kTxMS6sZJ0nCeJc1Bd8yYTjKx5Ui3qyJ1k4bGP3fvpkbRYpm6lJXF4rYSIF+BmEHrq1L8soZcOqJKzlfiqDP2rch1YVhzamkRTtpIu+p3FN9Q38LzGG3CxQlMcoIy+V3pF1W4b4haqXbFIPWNz7VDDP1leVSwdzzEZeAQWgBubOii02lhLG/TbshSBW49XLrcpNKGHkgiBYjLCASXXnAn4yZslsRQ5y6AJqaV6sP/x5/2zpVU+vhb5r9R82CUC2eHjDn6nbOVP+FNxxe3EVFfEscoEhMpmxFPW+zuOOQu06jhK2/NapyraVBJKOYx3pBnmX3WWAg184jGIVaMXI4zLC/tHSFxPlWzy5789TuuOpWwayP8t76C4kv4V3v03ETD/2RL5k1nJtE4WP9cOWXCS+0ShnUpqQFV/qGh+GUfXO1+7IT5fbTrzds8kHe5GruppVBw63+37r6P3fe5SxDHvAWGZy9SUqwFzH6Duc16w6VuyOymm6Fk9kDngiKgVAKzDluV1OW9HGlPsv0lYXEA/BLCC+DBz/ISZW2eUJ3rrTVZfVSnH8PxT5v2lEh6gFS4L3x/XH12hKNyK5BCa8EJIlMtm/Og==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2BDn749PDwhNiCygAmweJ3cPgKO57ynArlz9ychilrhHAhrHMEzAIkrVJQ1T1919GwSwbRsx7T4Q21o7mMoTMQqzaT0v28n2FvfWOHUDEoCZnz/Pdku2tb5ZazilOvQnG0btwIDxoVKJI2gZAbxAZuE22s2Qu2hPw2gIKI1m6AoM9hDv7PMae/FXH1c2ahX2J3Zq8NDq9+r4e5q0DRqTKWiPkvvPG5ZwpLji0p6qHeYTNUpN2k3qQglto2Og8xkcU18lx2OT8/MPWoo6vrImsmGEA5yeDWL7iY9fs7IfKwwr3c5v7qOXNrXglv3lzyzuXLwRRoG3WukxtHIhlhnTzEwmFyxwBKozo7xEmuy4g61bWxaNgzsJJw27G12d46eP0Y/1RCPA6Vqi7tbs0lGELxDFNQmnfSRCmRy5oBVMEMC5xIlQ3a750uHrCvBGqAYy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:01:14.6254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ec2d16-4dd9-4ec5-96bb-08de8ae3f178
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
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

From: Clay King <clayking@amd.com>

[Why & How]
Fix signed/unsigned mismatch warnings by using the same signedness for a
given value

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h   |  1 +
 .../drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c  | 10 +++++-----
 .../amd/display/dc/dml2_0/dml2_translation_helper.c    |  4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
index 42aea81fb61c..9568ca06f00f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h
@@ -74,6 +74,7 @@ unsigned int dcn42_get_max_clock_khz(struct clk_mgr *clk_mgr_base, enum clk_type
 bool dcn42_is_smu_present(struct clk_mgr *clk_mgr_base);
 bool dcn42_has_active_display(struct dc *dc, const struct dc_state *context);
 int dcn42_get_active_display_cnt_wa(struct dc *dc, struct dc_state *context, int *all_active_disps);
+bool dcn42_has_active_display(struct dc *dc, const struct dc_state *context);
 void dcn42_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr, struct dc_state *context, bool safe_to_lower);
 void dcn42_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr, struct dc_state *context, int ref_dtbclk_khz);
 bool dcn42_is_spll_ssc_enabled(struct clk_mgr *clk_mgr_base);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
index fd3c61509f1b..40f2f1ebab3a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_dc_resource_mgmt.c
@@ -35,7 +35,7 @@
 #define MAX_MPCC_FACTOR 4
 
 struct dc_plane_pipe_pool {
-	int pipes_assigned_to_plane[MAX_ODM_FACTOR][MAX_MPCC_FACTOR];
+	unsigned int pipes_assigned_to_plane[MAX_ODM_FACTOR][MAX_MPCC_FACTOR];
 	bool pipe_used[MAX_ODM_FACTOR][MAX_MPCC_FACTOR];
 	int num_pipes_assigned_to_plane_for_mpcc_combine;
 	int num_pipes_assigned_to_plane_for_odm_combine;
@@ -340,8 +340,8 @@ static bool is_pipe_in_candidate_array(const unsigned int pipe_idx,
 static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 	struct dc_state *state, // The state we want to find a free mapping in
 	unsigned int stream_id, // The stream we want this pipe to drive
-	int *assigned_pipes,
-	int *assigned_pipe_count,
+	unsigned int *assigned_pipes,
+	unsigned int *assigned_pipe_count,
 	int pipes_needed,
 	const struct dc_state *existing_state) // The state (optional) that we want to minimize remapping relative to
 {
@@ -406,8 +406,8 @@ static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 static bool find_more_free_pipes(struct dml2_context *ctx,
 	struct dc_state *state, // The state we want to find a free mapping in
 	unsigned int stream_id, // The stream we want this pipe to drive
-	int *assigned_pipes,
-	int *assigned_pipe_count,
+	unsigned int *assigned_pipes,
+	unsigned int *assigned_pipe_count,
 	int pipes_needed,
 	const struct dc_state *existing_state) // The state (optional) that we want to minimize remapping relative to
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
index e25b88f2d6b9..57f45b27de1d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_translation_helper.c
@@ -330,8 +330,8 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 {
 	struct dml2_policy_build_synthetic_soc_states_scratch *s = &dml2->v20.scratch.create_scratch.build_synthetic_socbb_scratch;
 	struct dml2_policy_build_synthetic_soc_states_params *p = &dml2->v20.scratch.build_synthetic_socbb_params;
-	unsigned int dcfclk_stas_mhz[NUM_DCFCLK_STAS] = {0};
-	unsigned int dcfclk_stas_mhz_new[NUM_DCFCLK_STAS_NEW] = {0};
+	int dcfclk_stas_mhz[NUM_DCFCLK_STAS] = {0};
+	int dcfclk_stas_mhz_new[NUM_DCFCLK_STAS_NEW] = {0};
 	unsigned int dml_project = dml2->v20.dml_core_ctx.project;
 
 	unsigned int i = 0;
-- 
2.43.0

