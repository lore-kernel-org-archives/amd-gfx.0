Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA63FEA818
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:09:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B460F10E7A4;
	Wed, 25 Mar 2026 07:09:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hyq5ZqKe";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB6610E7A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:09:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iqr+9SUDjOhu0dSc4EBa9aKXZAWUroNISyDEcFB3/qTlBK7/5XVq+L6QyqYe+pBUE4CaxnxIvGzyw7NweGx4PeO35gEnBFuDtyTNXdlHqQ9Cw3Y/6z/nzTNejj4TkNxc6oAu4TcF7c/+zK71VnFeZTz07tLHPt200FqSLPs7z2ukR4kW9JMxfMoEBYo02kl7RD0Lk+RQ2o3Y7RqNafBAa3g0TeVlCCEgRrOe13kNYlhoigeQ2wXDGdZYxDGq2TPU2gmvIFN0NdXayk3jvnjBvB6qbd0hQCII67Fkd4Bb5a/1zYMHWUkhS/7pVbXZM+3erbSPWMdJUhuSy9aymO71Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSdoYDdqtHM1JgQcdn3e1sRJbxGnj9dkWpozF2y2zF4=;
 b=R0yiinpDIEwRrNhrwKDDVWw8vHubf/FvnwPDzoQMBEErvenVDy4W6k90OHOIxplq00eYshxfzrGnmtM/GQJbfSBEjwZdFPwJC2Ltu2J1UeNEfxHskcenCCaj088SBWKjdpOG4ublcU0n4rw/LRpUTj5HIXb1uiYh+x593fXgXX0HBV0qcwMrRv+pAjzp+pb5RHoEOlwwT730NIPnHwuv0f1OiRRH/t1qptjAZKR4WKMe6H76/GsgtuvBa44rMPxVUhosS6ay3PecDNBQxk0C9X7VRjtcIslHHa8wGrObik5br7w7nWl34KAoBXzX+hOTx8kd/1Nzi4pR2Szims81PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSdoYDdqtHM1JgQcdn3e1sRJbxGnj9dkWpozF2y2zF4=;
 b=hyq5ZqKe0n19UlCmb66pD3uWmshfYX+78ImrJnS8j1YwLp5JwVeVsoX/mXJkLuCNp/SmIiC7A2EKZfP8XgAcPu4tDjpvMP/DIA36SpOHeYWv66SYmWKcPiM3oLxfc9atg9d7BhFKH2K526MSaurW413PWbxVU4WCS8IT4pGfzDg=
Received: from BL1P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::24)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 07:09:17 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::dd) by BL1P222CA0019.outlook.office365.com
 (2603:10b6:208:2c7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:09:16 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:13 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Austin Zheng
 <austin.zheng@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 11/29] drm/amd/display: Fix silence signed/unsigned mismatch
 warnings in dml
Date: Wed, 25 Mar 2026 15:06:17 +0800
Message-ID: <20260325071003.4022594-12-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ac21928-8cfc-4a1c-ebd0-08de8a3d6d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 61l7OnTKWNe9MR56X9/Lp95bgKPth66AuQiMhLr73CrncDL/fP/TbTwR0brSVWvUUyRU37hwtMfn/tR8Md+OGhHWoPyDYvTCjjkoVZChP2d6Uz04W/sPn8nhwPKPRvSw2yZxcQpeObMr8lBN1iYL9oLnpqIzzkFyhZK1fwX4hxnfEkFlbDcwzNl0Xd51NSpUy7k3+Omkio79YHVq7ce/oU70EmZ5nNI9Jl+cT4D4LpfDT2WokfTT+JF/XHjvSdhfvB+WPXDXgt/tYloJKoHehaQCZIVlutL2iMKFSllB9/qQKpYMWvAT1fMoXV3KYqfnP9R8QUssT6H8NYhtCHTPGDf75JavvviMDNBEgGlvQTEi/GyfG0sd0v3XTBjWdeAnlc3WChSwALEnsgMXvxnd2nwd6oNh5+yZSA1JD/+NlAOXK7PaObdsYDXxDtzls3+5axESMi9qsLgbTRMV3xBDhTaVo4XPeV0UP6VGbYmJU07lTaAoEtsVHVmAZGj44tS+dqjx0VKdjux5e7rcwm2oW2AFxVk9D3vYcYQZ+u0ReHa7qXgDqi0+wUejpp1LDshnaOv+28enj+eUQ1F9GjJzQmSl922Sl3hyc0bR5u4GVHoxfZG2j1CtWM62VkFIKtNZrOF2hD6xpInC9GcLcNv7D4r5YuF9CyZoGpdjigt2qcSerfft0sLv6jGJy9Lm9KbtW8QzR2ud4aUE+DUNsmMHl2BCWh86YN7g/j2ZK/11rb454Wxz4oINARtiGjuP+VUnYNZZhyYRHY4Qwu8mvcxWfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xFWAZXIldzwKsr+/S7ccAV7QWV/5GujsqRV90ypVBwGVXQQ5Q2rFN/CH7eKY3hJKvQ0fv8co+JlgfZ6qFpS1qHDfn2N2k6x9vGmsyZqDvfo8PbuU0DCK68HRWbr0IHs/+PsQNUsHNjF27Rfm+2hP6i5noYDpBUP2AcMaTJtcSEsYqxWUFEoYQI+nVsXs8SWwAqN1fDKEGg3MesIi6hNkpG7GSM4bq/pzzuUDVkj75j6iZxgI4OG5WY2Zk+Vi1EbxYORePHj9BWVin+hkvZoHsQ8lSSvIeo3wlKkCf/0tkVsX0hzxZ0STqtruStC8a3UKvp752LRfhwvCstYjM7ICUIpjOBpUiLHHlf6J96Uds8H0eqdzRyHogW8hctxceyJslpLCUc+bdJfo+0z2CI+9GGTwjaOq3obaT8WUJ5ltSf9VEEu+7t1VAgG6Zrq/i+F5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:16.7552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac21928-8cfc-4a1c-ebd0-08de8a3d6d80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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

