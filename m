Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B2EFD88F3
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 04:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A8610E2F6;
	Wed, 11 Mar 2026 04:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="guuu+Ku+";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0834810E303
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 04:04:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQPpB+4T2nUmnfPIdffWlV8mrgqPHQhN/sOrXBUQXoLFU9cuwD0IdM93J7LMcMnBsTkENQy5SHWW4qiMRlHWXYJ/j1WN4JpIqZdMKVE9OZiNLTyzeutQSb9AOxkE22L8cSorXRGbjjDHrfvn6PAFtay6gHfhmTm8vWtjbO175L5uOFW8V3Ma8CyMvSwAtkajrhu/QlgWGVew00pbhturEvHUY/QqhgdMb9I+BZaviGvVZg+89ZVcUk0ViQt/UlJCYZs3lq+SC0Mu9q41xIkkdwpgEXYcVtKK7mmjeQISCLQHHnT/uSvuQ5XycY+0dv9JHFYIHy984XhmXiD2C2m/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLV+omMMwruop4QwHhG9HU29opSSd/ZT2dKFQxBgYpE=;
 b=dtYasAtmkUOrSYmSy9ybuQlFQnR9R59BjG4cZEJTiVmPrF9tkK6wgZ1I3Gbl6eFTT1vrJEIW3dTDzhymZIcvBIfO3MF1mkyxUgPkZOJbODqRmh7o7GQLoSYE6IHF4FkTLqbNKiDY1dwddEdSWpUWfHWOZC/T2r9NI7YMjP8Esi6NJ3ycXZLuIRjTRuUYIdfeSQ6AGF8j5/GvqQ0SFCEzy15ZvJIId+m/4h2LVteoPOrYnDLsgZQ7GugqepQig+2khHXzXU3JJYu3IVkyW8D9j8UFLr+hj5RritRcAu+O1PKSxhlk8eM7Tq4HYL3njYJ+5WeG0rvVlg7Ok5YfldcqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLV+omMMwruop4QwHhG9HU29opSSd/ZT2dKFQxBgYpE=;
 b=guuu+Ku+QOv0rpL49+1Q2/poH/sQf7b70lAUJluYSWVPOs4tAULcNhDfMDKb6HOs6K8n+hlXXbN6Yf61gqQJCnCFp6jbFqHfymF2nvgE2cVRQmIWZ7IF/008KO8nLKcE3hqxLRKidYV+j7cF87n+QiP2JBSO9DFf3A2VKs+H6Ls=
Received: from PH8PR02CA0044.namprd02.prod.outlook.com (2603:10b6:510:2da::9)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 04:04:02 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::91) by PH8PR02CA0044.outlook.office365.com
 (2603:10b6:510:2da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 04:04:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 04:04:01 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 23:03:57 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Carbones <Nicholas.Carbones@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 7/9] drm/amd/display: Query DC for gfx handling when
 setting linear tiling
Date: Wed, 11 Mar 2026 11:33:02 +0800
Message-ID: <20260311040501.2693643-8-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
References: <20260311040501.2693643-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 088dca07-48ac-41f8-3e0f-08de7f233aad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: sfJwLWPgH3C+XpEbuHy9/73OYpaLsh1a4u2qM79cMEEPfqhMx9x3krCKf/vMHHqKbM71ms7tTCpYfF6X6dwNaNM/3trIwNxsnplEA9truf4AKz6aO3ZtpnAx9+jMIdVYfXi5PhrJBGNiSrnZLyMbyF9NXDU/tnx4Nb09ZA2OY/nfRSPwP4zedOZr7Oswi0V6Mjcud4InLPZL8SPcU0WOUph+7nu0/GidsrKPpGDnMNX3JZfo4U99FufgXnW5qhCewitW69BhV4Xjb18wrLSOkoAEqb6hWaWEMIQ/soNBq1S0/RztIP3ZEvaF+hrJr+NTmgHy2OX5bdyeYAu1T4QPq9IKMRUzKFfKzIrlb9eMul1ptmj6w2H26pXmeGwfbJz84tgA1xFbMy7863EbGEfpWpTsJIJ3pI38esWqhaaj9Iiaq/Q2W8+UVbOlz1wNj1Xe8bCmrmFDD9cJzfiWhmBvyiv733Uaez2dCrTqe+eDEHYtcLfE4FBtdNyV2RPBmeWBJJGypGLUsNy3a2y5sKxSxdY0nPQkzHk4NWGMUzM6mNw14TtEeaKd1Byvui9bvxiPx9YUh8byygocrIjWvZMwjnoZ6EnTOOqCoucHPY5IY9PjuS15S+J/nI8ogXVAUQZVev1vYrxUvmSzUy2tKGTr3n8PXAVF/onk6TOcMnEro9LudoFzNEGIozsUtWPwjatZY41JgYMZwAgvCW9f31H9M3/fUEfxLXA51WlPSBXf/8ZcYQBrT6ds+OoqLKRpFvYXz/8iFzKgcs9zQy+jLbE6wQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zX9J/k0+bgi6B7JxKX22CHajbthB3lfBeIobqfF7fZS9Xevahz99a/MpJbvhCd0xaDMJybxvaAK+aWaLpr8UPbLkMXOLX3bzVHyL6Z+K+znBQY2STU7og0OczydI1h93kYfdKDJLK5Cl+/1dFghrXoNNuRDB+BIhdPElwOFxKztZfEYO1czWT/WJG1wv1VL9XjlTnDq/zpLP5b5Yy5D0R+lc+1nSU4CjfntTUdYxnVhz5O2wNYrAPE/J2wshhl2aUCMNczUlnUgDngT4gBsK8c/X7OhbuBSMP1C08jPanFTfZK8xhDYTneYS9vc4yuTC13tKFPILdMajDixfd/raXP9qcY3PKqPBfXqlq4ogOE8zgvQY/hHU874DqYEULoFu71WNskuTwZ0527RBS7SUKtkmuR9FY/cq6ZA2e6xla0JpVFJVaRrAVEPdfJL+zhfR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 04:04:01.7827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 088dca07-48ac-41f8-3e0f-08de7f233aad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
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

From: Nicholas Carbones <Nicholas.Carbones@amd.com>

[Why]
Post-driver cases always use linear tiling yet gfx handling for this
case is improper, allowing for incorrect gfx structs to be populated and
used.

[How]
Query DC for the apporpriate linear tiling mode and populate the DCN
specific gfx version structs.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Nicholas Carbones <Nicholas.Carbones@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c               | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h                    | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/inc/core_types.h        |  1 +
 .../drm/amd/display/dc/resource/dcn10/dcn10_resource.c |  9 ++++++++-
 .../drm/amd/display/dc/resource/dcn10/dcn10_resource.h |  2 ++
 .../drm/amd/display/dc/resource/dcn20/dcn20_resource.c |  3 ++-
 .../amd/display/dc/resource/dcn201/dcn201_resource.c   |  3 ++-
 .../drm/amd/display/dc/resource/dcn21/dcn21_resource.c |  3 ++-
 .../drm/amd/display/dc/resource/dcn30/dcn30_resource.c |  3 ++-
 .../amd/display/dc/resource/dcn301/dcn301_resource.c   |  3 ++-
 .../amd/display/dc/resource/dcn302/dcn302_resource.c   |  3 ++-
 .../amd/display/dc/resource/dcn303/dcn303_resource.c   |  3 ++-
 .../drm/amd/display/dc/resource/dcn31/dcn31_resource.c |  1 +
 .../amd/display/dc/resource/dcn314/dcn314_resource.c   |  3 ++-
 .../amd/display/dc/resource/dcn315/dcn315_resource.c   |  3 ++-
 .../amd/display/dc/resource/dcn316/dcn316_resource.c   |  3 ++-
 .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c |  1 +
 .../amd/display/dc/resource/dcn321/dcn321_resource.c   |  1 +
 .../drm/amd/display/dc/resource/dcn35/dcn35_resource.c |  3 ++-
 .../amd/display/dc/resource/dcn351/dcn351_resource.c   |  3 ++-
 .../drm/amd/display/dc/resource/dcn36/dcn36_resource.c |  3 ++-
 .../amd/display/dc/resource/dcn401/dcn401_resource.c   |  9 ++++++++-
 .../amd/display/dc/resource/dcn401/dcn401_resource.h   |  2 ++
 23 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index aeafd2388c01..ef7108e94627 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2617,6 +2617,16 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 	dc->optimized_required = false;
 }
 
+void dc_get_default_tiling_info(const struct dc *dc, struct dc_tiling_info *tiling_info)
+{
+	if (!dc || !tiling_info)
+		return;
+	if (dc->res_pool && dc->res_pool->funcs && dc->res_pool->funcs->get_default_tiling_info) {
+		dc->res_pool->funcs->get_default_tiling_info(tiling_info);
+		return;
+	}
+}
+
 bool dc_set_generic_gpio_for_stereo(bool enable,
 		struct gpio_service *gpio_service)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c7a09724f569..b232de04a797 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1970,6 +1970,16 @@ void dc_plane_cm_retain(struct dc_plane_cm *cm);
 void dc_post_update_surfaces_to_stream(
 		struct dc *dc);
 
+/*
+ * dc_get_default_tiling_info() - Retrieve an ASIC-appropriate default tiling
+ * description for (typically) linear surfaces.
+ *
+ * This is used by OS/DM paths (e.g. SystemDisplayEnable/BSOD) that need a
+ * valid, fully-initialized tiling description without hardcoding gfx-version
+ * specifics in the caller.
+ */
+void dc_get_default_tiling_info(const struct dc *dc, struct dc_tiling_info *tiling_info);
+
 /**
  * struct dc_validation_set - Struct to store surface/stream associations for validation
  */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 43579b0e1482..e960ca9062ad 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -214,6 +214,7 @@ struct resource_funcs {
             unsigned int index);
 
 	void (*get_panel_config_defaults)(struct dc_panel_config *panel_config);
+	void (*get_default_tiling_info)(struct dc_tiling_info *tiling_info);
 	void (*build_pipe_pix_clk_params)(struct pipe_ctx *pipe_ctx);
 	/*
 	 * Get indicator of power from a context that went through full validation
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index 476780a5450f..9c1a57a1f989 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -1275,6 +1275,12 @@ static const struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn10_get_dcc_compression_cap
 };
 
+void dcn10_get_default_tiling_info(struct dc_tiling_info *tiling_info)
+{
+	tiling_info->gfxversion = DcGfxVersion9;
+	tiling_info->gfx9.swizzle = DC_SW_LINEAR;
+}
+
 static const struct resource_funcs dcn10_res_pool_funcs = {
 	.destroy = dcn10_destroy_resource_pool,
 	.link_enc_create = dcn10_link_encoder_create,
@@ -1286,7 +1292,8 @@ static const struct resource_funcs dcn10_res_pool_funcs = {
 	.add_stream_to_ctx = dcn10_add_stream_to_ctx,
 	.patch_unknown_plane_state = dcn10_patch_unknown_plane_state,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.h
index 7bc1be53e800..c7409298caa9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.h
@@ -53,5 +53,7 @@ struct stream_encoder *dcn10_find_first_free_match_stream_enc_for_link(
 
 unsigned int dcn10_get_vstartup_for_pipe(struct pipe_ctx *pipe_ctx);
 
+void dcn10_get_default_tiling_info(struct dc_tiling_info *tiling_info);
+
 #endif /* __DC_RESOURCE_DCN10_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 90a4b42bc7e7..b28e877fb99d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2231,7 +2231,8 @@ static const struct resource_funcs dcn20_res_pool_funcs = {
 	.set_mcif_arb_params = dcn20_set_mcif_arb_params,
 	.populate_dml_pipes = dcn20_populate_dml_pipes_from_context,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 bool dcn20_dwbc_create(struct dc_context *ctx, struct resource_pool *pool)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
index 90d38631f63a..5f0b592a3dc7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn201/dcn201_resource.c
@@ -1081,7 +1081,8 @@ static struct resource_funcs dcn201_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.set_mcif_arb_params = dcn20_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 static bool dcn201_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index 107612595db6..e57022af2c2a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -1379,7 +1379,8 @@ static const struct resource_funcs dcn21_res_pool_funcs = {
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link,
 	.update_bw_bounding_box = dcn21_update_bw_bounding_box,
 	.get_panel_config_defaults = dcn21_get_panel_config_defaults,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 static bool dcn21_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
index 6cfdc37dab58..66b1a1c2db1d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn30/dcn30_resource.c
@@ -2252,7 +2252,8 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.update_bw_bounding_box = dcn30_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn30_get_panel_config_defaults,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 #define CTX ctx
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
index e1d0c166b484..65781c10e83c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn301/dcn301_resource.c
@@ -1404,7 +1404,8 @@ static struct resource_funcs dcn301_res_pool_funcs = {
 	.release_post_bldn_3dlut = dcn30_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn301_update_bw_bounding_box,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
-	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+	.get_default_tiling_info = dcn10_get_default_tiling_info,
 };
 
 static bool dcn301_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
index c0d4a1dc94f8..7c4c5c8aa4b6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn302/dcn302_resource.c
@@ -1155,7 +1155,8 @@ static struct resource_funcs dcn302_res_pool_funcs = {
 		.update_bw_bounding_box = dcn302_update_bw_bounding_box,
 		.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 		.get_panel_config_defaults = dcn302_get_panel_config_defaults,
-		.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+		.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+		.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 static struct dc_cap_funcs cap_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
index 75e09c2c283e..360934bc5481 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn303/dcn303_resource.c
@@ -1099,7 +1099,8 @@ static struct resource_funcs dcn303_res_pool_funcs = {
 		.update_bw_bounding_box = dcn303_update_bw_bounding_box,
 		.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 		.get_panel_config_defaults = dcn303_get_panel_config_defaults,
-		.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe
+		.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
+		.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 static struct dc_cap_funcs cap_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 8ad72557b16a..a064d1fbce52 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -1855,6 +1855,7 @@ static struct resource_funcs dcn31_res_pool_funcs = {
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
 	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
 	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
+	.get_default_tiling_info = dcn10_get_default_tiling_info,
 	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
index 5f0fe6e5bd82..803b87986802 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn314/dcn314_resource.c
@@ -1786,7 +1786,8 @@ static struct resource_funcs dcn314_res_pool_funcs = {
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
 	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
 	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
-	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
+	.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 static struct clock_source *dcn30_clock_source_create(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
index 3ae787a377b1..67102b4c881f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c
@@ -1850,7 +1850,8 @@ static struct resource_funcs dcn315_res_pool_funcs = {
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
 	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
 	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
-	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
+	.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 static bool dcn315_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
index 4b8668458f03..fa51a9ae945f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c
@@ -1725,7 +1725,8 @@ static struct resource_funcs dcn316_res_pool_funcs = {
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
 	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
 	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
-	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
+	.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 static bool dcn316_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index a55078458ba5..e16774969aa2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -2113,6 +2113,7 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
 	.add_phantom_pipes = dcn32_add_phantom_pipes,
+	.get_default_tiling_info = dcn10_get_default_tiling_info,
 	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
 	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 188c3f24f110..b254e22a7628 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1623,6 +1623,7 @@ static struct resource_funcs dcn321_res_pool_funcs = {
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
 	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
 	.get_max_hw_cursor_size = dcn32_get_max_hw_cursor_size,
+	.get_default_tiling_info = dcn10_get_default_tiling_info,
 };
 
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 5ea805fcff48..f7e2e79bc0e1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -1805,7 +1805,8 @@ static struct resource_funcs dcn35_res_pool_funcs = {
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
 	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
 	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
-	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
+	.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 static bool dcn35_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
index 424b52e2dd7b..5dffaf12a7c0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
@@ -1778,7 +1778,8 @@ static struct resource_funcs dcn351_res_pool_funcs = {
 	.get_det_buffer_size = dcn31_get_det_buffer_size,
 	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
 	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
-	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
+	.get_default_tiling_info = dcn10_get_default_tiling_info
 };
 
 static bool dcn351_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
index 7582217bd06d..40894afd990e 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn36/dcn36_resource.c
@@ -1784,7 +1784,8 @@ static struct resource_funcs dcn36_res_pool_funcs = {
 	.get_preferred_eng_id_dpia = dcn36_get_preferred_eng_id_dpia,
 	.get_vstartup_for_pipe = dcn10_get_vstartup_for_pipe,
 	.update_dc_state_for_encoder_switch = dcn31_update_dc_state_for_encoder_switch,
-	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params
+	.build_pipe_pix_clk_params = dcn20_build_pipe_pix_clk_params,
+	.get_default_tiling_info = dcn10_get_default_tiling_info,
 };
 
 static bool dcn36_resource_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index f5e02a1ff771..57ae4b216b5d 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1843,9 +1843,16 @@ static struct resource_funcs dcn401_res_pool_funcs = {
 	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
 	.get_power_profile = dcn401_get_power_profile,
 	.get_vstartup_for_pipe = dcn401_get_vstartup_for_pipe,
-	.get_max_hw_cursor_size = dcn32_get_max_hw_cursor_size
+	.get_max_hw_cursor_size = dcn32_get_max_hw_cursor_size,
+	.get_default_tiling_info = dcn401_get_default_tiling_info
 };
 
+void dcn401_get_default_tiling_info(struct dc_tiling_info *tiling_info)
+{
+	tiling_info->gfxversion = DcGfxAddr3;
+	tiling_info->gfx_addr3.swizzle = DC_ADDR3_SW_LINEAR;
+}
+
 static uint32_t read_pipe_fuses(struct dc_context *ctx)
 {
 	uint32_t value = REG_READ(CC_DC_PIPE_DIS);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
index 08bec1755617..5f3b0319cb5b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.h
@@ -28,6 +28,8 @@ enum dc_status dcn401_validate_bandwidth(struct dc *dc,
 
 void dcn401_prepare_mcache_programming(struct dc *dc, struct dc_state *context);
 
+void dcn401_get_default_tiling_info(struct dc_tiling_info *tiling_info);
+
 unsigned int dcn401_get_vstartup_for_pipe(struct pipe_ctx *pipe_ctx);
 
 /* Following are definitions for run time init of reg offsets */
-- 
2.43.0

