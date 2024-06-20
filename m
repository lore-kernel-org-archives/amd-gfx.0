Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF84EC2BA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A4E210EB0D;
	Thu, 20 Jun 2024 16:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2GVM9UFe";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4640710EB0D
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnfxPtEkSCWDfgZgIRLtTBzVWPqlvXEHDXs+OxLGmFA0d+tIKvroA6xaELoOSB3iJuee+jw5AvLPVa4zqCQ0ijypXmio7XifagBnPN6cIInkuxUUI5o5N7rC6lpvt/0RYIvHfZzBPutblPwiQtKDTEq8T7KSzC/CL0OtDAw/NfeA6MKAiDzBXcbcBa3VDgxuTqlfpJ/wqLDr5TnOemqa2Mo7Z+Y4cBgCiBHmum0u29Xa0+6x8xknoOiDNV00Smdnsj8zlOfnuhIwxDyQqaLOLXCmkvz15r1s+Pr1F51yxLRZNuwBH8q94kwDUGEGcN4B5ShTkFq7Fxx3EzyQiFREhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAgpjYwXqeA1eGgEgAFN8nf7hweJTcqcQmnXjttNx4s=;
 b=Gy540r092onb5ZbJkUgHayvZh8FAr6GLMzcWlcyrWDuNEnLWI9ZpdauVwwXml8OoxLMSo666bxkLf19+5OPy2QLDZJU9U6js20dQnLd5dVowzh4yLpfwRQ6MiXtizqgzyIA5PrBsSSQm33WVO1tTRG6G4A/EmntvBpIPw2wCF8yIRWEI9yDvGxYp9sWXgwHLo2hDjDrP9+JYtpmidYAacb8S9RlBlMVHouzWKLhD9ZuigqoqL3Hz6Kj/aTE/E2qLj/pv8EIUxxb3ayBmj8MGW8UeiYII00iP2ZEB1063BUL2d8MXY4y1uYWjGw0+Z88BgtshHaSMECxn4P3afq7yog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAgpjYwXqeA1eGgEgAFN8nf7hweJTcqcQmnXjttNx4s=;
 b=2GVM9UFepz6xYuX4Ql4qy6HkZ+iDMOoRs3JfJv7XNEckxLMqXkaHlYgefbcDeiL0fIYhq16OUlsorm+KudOWueqev6vECLKGb6imnT5r6/CYcty31VhgCDS9zigNMn7+Zqkh0Qaf5tq6RIffXDqW1SqNg5wsAouqbXZhyu7HbtM=
Received: from CH0PR08CA0005.namprd08.prod.outlook.com (2603:10b6:610:33::10)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Thu, 20 Jun
 2024 16:17:37 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::5d) by CH0PR08CA0005.outlook.office365.com
 (2603:10b6:610:33::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:17:37 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:17:33 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 23/39] drm/amd/display: Add null checks before accessing
 struct elements
Date: Thu, 20 Jun 2024 10:11:29 -0600
Message-ID: <20240620161145.2489774-24-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 545fea97-835d-4192-855e-08dc9144801b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|82310400023|376011|36860700010|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XUnqm8pPgMo+Fhq9ypKShAPIa6CZIlmN2tWyo6274tICG0MIpdt0+hso3XiB?=
 =?us-ascii?Q?O+ce6pJSmDxRHuVFYqzuHDWLvxeo1kCxR5AnCsZuYfN48ngiNDIHFhJz3hsz?=
 =?us-ascii?Q?/ho80beoHFzmMgOqgZ1/KgOENqfPCJodn2m9xCJitCvN0CePIVd7Q0bNVtcN?=
 =?us-ascii?Q?VYqTl3tUchHOvEvG0N9aqx5N9mo0+3n9Qk1kz2SHaoXxvwx7uR48YRHMUULE?=
 =?us-ascii?Q?t7cWTPekYbMohgk484xhHH+2/4AHX5Hag6w0DQXVHYa5VnGGBgl4WE/XfMLE?=
 =?us-ascii?Q?UuQENbqCyZUD10H2b/5IFBYpdFcRtMFpwDUUFUWd5N7J58kb1rK7fUUaAfSc?=
 =?us-ascii?Q?x2MXAQWq3J4W2GQH5meGEaDRamQ+LL1M3fXcENrXYcQe3z4qCQmcy/jFcA1w?=
 =?us-ascii?Q?WzdDarSJ7oh9iOQAD/0z7nUZnoEOTDFig5MLJ8e0KzRwZYm9SZXTtxHuuUW3?=
 =?us-ascii?Q?jOizCQr7pIEwxA+Nzwg8TX25ZjUhgKybWA/r2AgO9P5Ee5QIR+AdH2paw75x?=
 =?us-ascii?Q?JNGoj3eX31pj25MKhh5g1pgIQzlBLfaZJZxfLtzC5yVNOCvFyGUj8X13I7iC?=
 =?us-ascii?Q?huC0GL5bNY5yoeNEkUluvUJl8FlS+8KVpNBByDTpf/3JCTKUTY6ZNahOb4rB?=
 =?us-ascii?Q?ywQDCsyQZPBbmYQg16RTFHNckpCd0FfQH7Nc/cI+cTKRADAqiQhw3HhhoF9c?=
 =?us-ascii?Q?Z30KD0kVa5RCYN5dwFkJQyF/fiuA8Siq9HD4nact63b+9tLlEkgxkyuz2T4W?=
 =?us-ascii?Q?ZFZC1qgg13gtJA2o1hr8kN9LjV00Ivas5n6A0Ch8H4uCbE/qRtVFtbc1lJkD?=
 =?us-ascii?Q?CzbToHO05FsIIzNHUjUnwYSPg3xzFz5ayZuznYQqAhPVOPLZ0Ct2sIYHdTmO?=
 =?us-ascii?Q?YxbNy5RCSKoQmNejoJO7hgNyLTw8xDBj6EszmaZ+vA1DWfDsfdO1JYo0cA+l?=
 =?us-ascii?Q?vVTiGvaAxHVvS4Y6XMZxcdeANtqlMByzoaauYvOHjfz5eqj/JZTMvcxHeV03?=
 =?us-ascii?Q?RY62iSxU5oQHHNr0Mn7g1Nq47e6AUDbi2BmLq+q1E3rnUufLYNj2KSfHMaLm?=
 =?us-ascii?Q?8Vg3cwjsMtdgACdEruUYObb5s5J2IA2M1VnPagiSUDySVnhEj30xILfrOesj?=
 =?us-ascii?Q?YZ59ZL3XxABylc3h/qplAE4nsTsElbwzUq0WKaxv3+tJGI+YXssD852Pku+f?=
 =?us-ascii?Q?8IvoZL4qZBIBuqaZvVe8oC1YEUKy6yIHcgy5w+1VIYonpzeov9+7znwTsD41?=
 =?us-ascii?Q?gHagpQsb4HneeqOM16GKIutpBLJlI9pQizTKGYOAE0qum/KJtQ3XkiKudq29?=
 =?us-ascii?Q?CBibbP/oorL6FAMZJ2h3WaUdPIEAcA8YXzzMh+byk93B7j/sAqbvx0PSQfOO?=
 =?us-ascii?Q?ORdMY8VnzfNiP608oVdMwx97nBRNc2OwPIHYm8tvTRHfaFVmdw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(82310400023)(376011)(36860700010)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:17:37.1921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545fea97-835d-4192-855e-08dc9144801b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887
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

[WHAT]
1. is_pwrseq0 needs to check link before accessing link->link_index.
2. context is checked before accessing its bw_ctx.dml2
3. clk_mgr_base->bw_params is checked before clk_table.num_entries_per_cl

This fixes 4 REVERSE_INULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c   | 10 ++++++----
 .../drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c | 10 ++++++----
 drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c   |  2 +-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c     |  4 +++-
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 06f0c41ad6f1..3b10b24f5e23 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -163,9 +163,14 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	unsigned int num_levels;
-	struct clk_limit_num_entries *num_entries_per_clk = &clk_mgr_base->bw_params->clk_table.num_entries_per_clk;
+	struct clk_limit_num_entries *num_entries_per_clk;
 	unsigned int i;
 
+	if (!clk_mgr_base->bw_params)
+		return;
+
+	num_entries_per_clk = &clk_mgr_base->bw_params->clk_table.num_entries_per_clk;
+
 	memset(&(clk_mgr_base->clks), 0, sizeof(struct dc_clocks));
 	clk_mgr_base->clks.p_state_change_support = true;
 	clk_mgr_base->clks.prev_p_state_change_support = true;
@@ -173,9 +178,6 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	clk_mgr->smu_present = false;
 	clk_mgr->dpm_present = false;
 
-	if (!clk_mgr_base->bw_params)
-		return;
-
 	if (!clk_mgr_base->force_smu_not_present && dcn30_smu_get_smu_version(clk_mgr, &clk_mgr->smu_ver))
 		clk_mgr->smu_present = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 70f06a7c882e..606b2411eee9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -207,9 +207,14 @@ static void dcn401_build_wm_range_table(struct clk_mgr *clk_mgr)
 void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct clk_limit_num_entries *num_entries_per_clk = &clk_mgr_base->bw_params->clk_table.num_entries_per_clk;
+	struct clk_limit_num_entries *num_entries_per_clk;
 	unsigned int i;
 
+	if (!clk_mgr_base->bw_params)
+		return;
+
+	num_entries_per_clk = &clk_mgr_base->bw_params->clk_table.num_entries_per_clk;
+
 	memset(&(clk_mgr_base->clks), 0, sizeof(struct dc_clocks));
 	clk_mgr_base->clks.p_state_change_support = true;
 	clk_mgr_base->clks.prev_p_state_change_support = true;
@@ -217,9 +222,6 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base)
 	clk_mgr->smu_present = false;
 	clk_mgr->dpm_present = false;
 
-	if (!clk_mgr_base->bw_params)
-		return;
-
 	if (!clk_mgr_base->force_smu_not_present && dcn30_smu_get_smu_version(clk_mgr, &clk_mgr->smu_ver))
 		clk_mgr->smu_present = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 54dd7e164635..8a8efe408a9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -1084,7 +1084,7 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 		struct dc_stream_status *stream_status = &context->stream_status[0];
 		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
-		bool is_pwrseq0 = link->link_index == 0;
+		bool is_pwrseq0 = (link && link->link_index == 0);
 		bool is_psr = (link && (link->psr_settings.psr_version == DC_PSR_VERSION_1 ||
 						link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) && !link->panel_config.psr.disable_psr);
 		bool is_replay = link && link->replay_settings.replay_feature_enabled;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index f4038ac2e476..90bb6e718301 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -687,12 +687,14 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 
 static bool dml2_validate_only(struct dc_state *context)
 {
-	struct dml2_context *dml2 = context->bw_ctx.dml2;
+	struct dml2_context *dml2;
 	unsigned int result = 0;
 
 	if (!context || context->stream_count == 0)
 		return true;
 
+	dml2 = context->bw_ctx.dml2;
+
 	/* Zero out before each call before proceeding */
 	memset(&dml2->v20.scratch, 0, sizeof(struct dml2_wrapper_scratch));
 	memset(&dml2->v20.dml_core_ctx.policy, 0, sizeof(struct dml_mode_eval_policy_st));
-- 
2.34.1

