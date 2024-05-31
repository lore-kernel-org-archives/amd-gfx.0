Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E2BC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:54:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D9FC10E473;
	Fri, 31 May 2024 16:54:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dyc2+kwM";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C178910E536
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJS61VaQ9bzYFXzC250HBlHVJZtQhjtm88vOafSKAtxPJJ2IjPjdVfA0HVNACjOGZiOj1Z9RlPGePDmH2zejQMDSALcOiHnkFeImFsRiv94u8+ckmvK0UgihNTOSmK1vwYEskJbEB99+oxtGEjAB5yc77fGzOzLxgJ7B3jYLSRBEcbbXnB5Uu47RaPkTYvwynUfGqAtdd1EUZyvoiY3/ICCJfqEYmDXmD5uOQX2Ty+w5YSY2yT6dsqT9n90Y1yNuQ410zBOsS2wZOA4asNOtY3aVlzkwQ5Iy8yPF9oH9SjqS7YjP/JcegCmhSTwEbNAbqtAMTlYpZHktFJ0s/HQH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTOqfi0ZsxjkZ9A2SEjGED4G4Uqk5CcL2db9UkDRz+A=;
 b=kJ+It+JAicuzpwGQLz6KyZzvG5CznFNZM823vKSgOysmqFBpV+EAd1v01tLZw5WhbRobn9uhe9UjImWYSfXnlpcI5c1gM6w0JFNK+2G0S5pJzvsygDqcLwAbDM201a+Qzn1kNe9F9iM5Jk6PaI0vqRePCpOnQ0Tem541ExLGh6Q+VLN5qeUhZUbzMn4yOJ+UD/bnaLhS4KwYu0PD4MGqg21CB/E+DHao4ROeOw5V+gxvNh8ai+yuZYEMR0cgH920Cs1UQKwPKfuu903Z83JNK340WBSzNF9RyCTP0DYlVDx7NvqEWpP/z5opUyXVmmI5NeSX1FqzBLVOB1ykRPUwMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTOqfi0ZsxjkZ9A2SEjGED4G4Uqk5CcL2db9UkDRz+A=;
 b=Dyc2+kwM5IF8h0XQxxbCJiPIAbSqDdFLc1/ksin3Io7YUEHFkLnrdwPUu82/9g0JZFl89WkfQwfdSoVVgx8I70D8KzbvpQnA5AGXHFPg9K60rz8t8TKPTEBZeuq86j4CqjmdkhSDNAmiQonbPH/JjbJAzUcbWfwyrGd07T1BEKQ=
Received: from PH7PR10CA0013.namprd10.prod.outlook.com (2603:10b6:510:23d::9)
 by IA1PR12MB8238.namprd12.prod.outlook.com (2603:10b6:208:3f9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 16:52:53 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::d5) by PH7PR10CA0013.outlook.office365.com
 (2603:10b6:510:23d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 16:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:52 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:47 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Chaitanya Dhere
 <chaitanya.dhere@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 28/32] drm/amd/display: Various DML2 fixes for FAMS2
Date: Fri, 31 May 2024 12:51:41 -0400
Message-ID: <20240531165145.1874966-29-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|IA1PR12MB8238:EE_
X-MS-Office365-Filtering-Correlation-Id: f5fc2a8c-4c1c-4f01-0dfc-08dc81921caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pC4wZOMXSFBLfbLO1ucaNM17bjGqLoHcZ3FJxDkxEpHn6sLYBJbAoACGYv7X?=
 =?us-ascii?Q?Pu0sLVcU88B5jaF37ZBjiXIU7oulLNidiptUyG5YlvEGExjNG4u97e1q5tfN?=
 =?us-ascii?Q?h8vgQ18S8QKjV5XGmJesUYe3kxNl/4Gv1MN1z5tSX2/leE6QBcMvjbi9JY2W?=
 =?us-ascii?Q?v2Dnoxy0I9x/u+7r9iJuizrvL6aE4W4KEOf3aH1vQs67rumnFatErb15/DLt?=
 =?us-ascii?Q?KdPhddgpePhvzi9CXxEpmxvGtMD4fmIW3jG54tV0DfpAKx40OAn+KG3rJBzX?=
 =?us-ascii?Q?UlreXLDRPxfwioizWvA8/eLg/VrHIHo2cj22nDDTV6I54zzj7WD8QhZzuq4B?=
 =?us-ascii?Q?l480Pr76MJmgK7mY27XHR8O3nFRtoKpvalVuL7ZE0761WDZSAXPfECstekPc?=
 =?us-ascii?Q?bX2bp57VZXmIvA7wKLmyF1b9bGJfNOb5yyJJoUQ1XMoUdGYJ0M/2GODuVPhc?=
 =?us-ascii?Q?q2+glzmnwoaHlQPMguRjq2RKtDv1O+NCSyyodCmw8mapjKIZUfXgniYRF5a5?=
 =?us-ascii?Q?OzyihXnU/DJgLKghbVT4s3ySef1phriWsxZkvK4k7r7ml+m6oG+V8cbZpjua?=
 =?us-ascii?Q?aUVvkOANmYJGO5+JVbqBhkN2FG2obVH52cn6DNCPrJf68Y0ARkr4V396210F?=
 =?us-ascii?Q?lsKIglU3aYbArVOOVcFpeCGKzdg2kFRf5pi4TVKMr1S+Dez//l06lfJEpBdN?=
 =?us-ascii?Q?MarGYCoiAC2BrI2lCORf39fMn/JZOeaM7s2HFnS6FdqZti/EiuITJcRdClTp?=
 =?us-ascii?Q?Ksev1koaZclUqkz6SVhIavCOwLnZwpBZ1haGhnOgp7VdalpCFbXDHJc7PXKt?=
 =?us-ascii?Q?F3BHt8CKfd98lYXLysDhcHhkF+FEV5afY7S/6yHSVNC1OP/jKCjSN6s16pid?=
 =?us-ascii?Q?zdi7SpUnJRBCICVyL2d7DkoYmDrld3N+OgHhV1T4NMgh8DkH9GNZmXrmoHD3?=
 =?us-ascii?Q?Qds8NtOgOZ60h1ztymXp3Z8gEW7agjfU2mdSoF8VBzYDKyGgA70B1aG9460G?=
 =?us-ascii?Q?m1bkYtzYo9+5/bYfD/QdrJcv0jhvDGV7HnfC3I1V5y92k199GPUb7SBRe0he?=
 =?us-ascii?Q?GrYp/iDymT6+jOKbRs5uQAnErRQT++hQZGTid//yBGHWk3xCKf8rt56tdObb?=
 =?us-ascii?Q?N7+uRdiqm+MWtSdZjI8zUp5GItnTxgLSECj9rkCVCiEc7rCZB3cXJWknhj7L?=
 =?us-ascii?Q?Y5R9Ty3eyr1fd4fS+ZjxXhNxfiusCumxpoGHcQAuldHOfMF1Ag49IDdwPVKF?=
 =?us-ascii?Q?Xi4LIl6vHpiLu+y5xffGx2a4EWX5Qc4EQiCyL5eArRuOxx18byA0OskkYo3Z?=
 =?us-ascii?Q?dO48CXY1Ted0Fpev7jKPJRV9fXUT6ahBW4VHELRZgwgLv/KKN918r6a6cofp?=
 =?us-ascii?Q?mtFC7YewEXNs2MS+4lCVWCnmWhhO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:52.5116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5fc2a8c-4c1c-4f01-0dfc-08dc81921caf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8238
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

From: Dillon Varone <dillon.varone@amd.com>

- Ensure SubVP stream settings match ODM policy
- Fix MALL size calculations when DCC is enabled
- Fail if any stream fails DRR policy check

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  7 +++--
 .../amd/display/dc/dml2/dml21/dml21_utils.h   |  4 +--
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |  6 ++--
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |  1 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 29 -------------------
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  2 +-
 6 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
index 8c9e95b25eb3..4e12810308a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.c
@@ -85,8 +85,8 @@ void find_pipe_regs_idx(const struct dml2_context *dml_ctx,
 int dml21_find_dc_pipes_for_plane(const struct dc *in_dc,
 		struct dc_state *context,
 		struct dml2_context *dml_ctx,
-		struct pipe_ctx **dc_main_pipes,
-		struct pipe_ctx **dc_phantom_pipes,
+		struct pipe_ctx *dc_main_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__],
+		struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__],
 		int dml_plane_idx)
 {
 	unsigned int dml_stream_index;
@@ -100,6 +100,9 @@ int dml21_find_dc_pipes_for_plane(const struct dc *in_dc,
 	struct dc_plane_state *dc_phantom_plane;
 	int num_pipes = 0;
 
+	memset(dc_main_pipes, 0, sizeof(struct pipe_ctx *) * __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+	memset(dc_phantom_pipes, 0, sizeof(struct pipe_ctx *) * __DML2_WRAPPER_MAX_STREAMS_PLANES__);
+
 	dml_stream_index = dml_ctx->v21.mode_programming.programming->plane_programming[dml_plane_idx].plane_descriptor->stream_index;
 	main_stream_id = dml_ctx->v21.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id[dml_stream_index];
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.h
index 82080397a50e..d5153fbac921 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_utils.h
@@ -33,8 +33,8 @@ void find_pipe_regs_idx(const struct dml2_context *dml_ctx,
 int dml21_find_dc_pipes_for_plane(const struct dc *in_dc,
 		struct dc_state *context,
 		struct dml2_context *dml_ctx,
-		struct pipe_ctx **dc_main_pipes,
-		struct pipe_ctx **dc_phantom_pipes,
+		struct pipe_ctx *dc_main_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__],
+		struct pipe_ctx *dc_phantom_pipes[__DML2_WRAPPER_MAX_STREAMS_PLANES__],
 		int dml_plane_idx);
 void dml21_program_dc_pipe(struct dml2_context *dml_ctx,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 08f001cb61c5..c4542c3dded9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -156,7 +156,7 @@ static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_sta
 		for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
 			dml21_program_dc_pipe(in_ctx, context, dc_main_pipes[dc_pipe_index], pln_prog, stream_prog);
 
-			if (pln_prog->phantom_plane.valid) {
+			if (pln_prog->phantom_plane.valid && dc_phantom_pipes[dc_pipe_index]) {
 				dml21_program_dc_pipe(in_ctx, context, dc_phantom_pipes[dc_pipe_index], pln_prog, stream_prog);
 			}
 		}
@@ -325,7 +325,7 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 		}
 
 		/* get config for each phantom pipe */
-		if (pln_prog->phantom_plane.valid) {
+		if (pln_prog->phantom_plane.valid && dc_phantom_pipes[0]) {
 			mcache_config = &l->build_mcache_programming_params.mcache_configurations[dml_phantom_prog_idx];
 			memset(mcache_config, 0, sizeof(struct dml2_plane_mcache_configuration_descriptor));
 			mcache_config->plane_descriptor = pln_prog->plane_descriptor;
@@ -368,7 +368,7 @@ void dml21_prepare_mcache_programming(struct dc *in_dc, struct dc_state *context
 		}
 
 		/* get config for each phantom pipe */
-		if (pln_prog->phantom_plane.valid) {
+		if (pln_prog->phantom_plane.valid && dc_phantom_pipes[0]) {
 			for (dc_pipe_index = 0; dc_pipe_index < num_pipes; dc_pipe_index++) {
 				ASSERT(dc_phantom_pipes[dc_pipe_index]);
 				if (l->build_mcache_programming_params.per_plane_pipe_mcache_regs[dml_phantom_prog_idx][dc_pipe_index]) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
index 4b8691c43523..04edcde423a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -235,7 +235,6 @@ static void create_phantom_stream_from_main_stream(struct dml2_stream_parameters
 	phantom->timing.v_active = meta->v_active;
 	phantom->timing.v_front_porch = meta->v_front_porch;
 	phantom->timing.vblank_nom = phantom->timing.v_total - phantom->timing.v_active;
-	phantom->timing.dsc.enable = dml2_dsc_disable;
 	phantom->timing.drr_config.enabled = false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 8062144a5a6d..18223886a777 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -4501,24 +4501,6 @@ static void CalculateSurfaceSizeInMall(
 						math_floor2((double)composition->viewport.plane1.y_start + composition->viewport.plane1.height + ReadBlockHeightC[k] - 1, ReadBlockHeightC[k]) -
 						math_floor2(composition->viewport.plane1.y_start, ReadBlockHeightC[k])) * BytesPerPixelC[k]);
 			}
-			if (surface->dcc.enable) {
-				SurfaceSizeInMALL[k] = (unsigned int)(SurfaceSizeInMALL[k] +
-					math_min2(math_ceil2(surface->plane0.width, 8 * Read256BytesBlockWidthY[k]),
-						math_floor2(composition->viewport.plane0.x_start + composition->viewport.plane0.width + 8 * Read256BytesBlockWidthY[k] - 1, 8 * Read256BytesBlockWidthY[k]) -
-						math_floor2(composition->viewport.plane0.x_start, 8 * Read256BytesBlockWidthY[k])) *
-					math_min2(math_ceil2(surface->plane0.height, 8 * Read256BytesBlockHeightY[k]),
-						math_floor2(composition->viewport.plane0.y_start + composition->viewport.plane0.height + 8 * Read256BytesBlockHeightY[k] - 1, 8 * Read256BytesBlockHeightY[k]) -
-						math_floor2(composition->viewport.plane0.y_start, 8 * Read256BytesBlockHeightY[k])) * BytesPerPixelY[k] / 256) + (64 * 1024);
-				if (Read256BytesBlockWidthC[k] > 0) {
-					SurfaceSizeInMALL[k] = (unsigned int)(SurfaceSizeInMALL[k] +
-						math_min2(math_ceil2(surface->plane1.width, 8 * Read256BytesBlockWidthC[k]),
-							math_floor2(composition->viewport.plane1.y_start + composition->viewport.plane1.width + 8 * Read256BytesBlockWidthC[k] - 1, 8 * Read256BytesBlockWidthC[k]) -
-							math_floor2(composition->viewport.plane1.y_start, 8 * Read256BytesBlockWidthC[k])) *
-						math_min2(math_ceil2(surface->plane1.height, 8 * Read256BytesBlockHeightC[k]),
-							math_floor2(composition->viewport.plane1.y_start + composition->viewport.plane1.height + 8 * Read256BytesBlockHeightC[k] - 1, 8 * Read256BytesBlockHeightC[k]) -
-							math_floor2(composition->viewport.plane1.y_start, 8 * Read256BytesBlockHeightC[k])) * BytesPerPixelC[k] / 256);
-				}
-			}
 		} else {
 			SurfaceSizeInMALL[k] = (unsigned int)(math_ceil2(math_min2(surface->plane0.width, composition->viewport.plane0.width + ReadBlockWidthY[k] - 1), ReadBlockWidthY[k]) *
 				math_ceil2(math_min2(surface->plane0.height, composition->viewport.plane0.height + ReadBlockHeightY[k] - 1), ReadBlockHeightY[k]) * BytesPerPixelY[k]);
@@ -4527,17 +4509,6 @@ static void CalculateSurfaceSizeInMall(
 					math_ceil2(math_min2(surface->plane1.width, composition->viewport.plane1.width + ReadBlockWidthC[k] - 1), ReadBlockWidthC[k]) *
 					math_ceil2(math_min2(surface->plane1.height, composition->viewport.plane1.height + ReadBlockHeightC[k] - 1), ReadBlockHeightC[k]) * BytesPerPixelC[k]);
 			}
-			if (surface->dcc.enable) {
-				SurfaceSizeInMALL[k] = (unsigned int)(SurfaceSizeInMALL[k] +
-					math_ceil2(math_min2(surface->plane0.width, composition->viewport.plane0.width + 8 * Read256BytesBlockWidthY[k] - 1), 8 * Read256BytesBlockWidthY[k]) *
-					math_ceil2(math_min2(surface->plane0.height, composition->viewport.plane0.height + 8 * Read256BytesBlockHeightY[k] - 1), 8 * Read256BytesBlockHeightY[k]) * BytesPerPixelY[k] / 256) + (64 * 1024);
-
-				if (Read256BytesBlockWidthC[k] > 0) {
-					SurfaceSizeInMALL[k] = (unsigned int)(SurfaceSizeInMALL[k] +
-						math_ceil2(math_min2(surface->plane1.width, composition->viewport.plane1.width + 8 * Read256BytesBlockWidthC[k] - 1), 8 * Read256BytesBlockWidthC[k]) *
-						math_ceil2(math_min2(surface->plane1.height, composition->viewport.plane1.height + 8 * Read256BytesBlockHeightC[k] - 1), 8 * Read256BytesBlockHeightC[k]) * BytesPerPixelC[k] / 256);
-				}
-			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 85c64dcefa82..2e8c836bc632 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -1361,7 +1361,7 @@ static bool validate_pstate_support_strategy_cofunctionality(struct dml2_pmo_ins
 			break;
 		}
 
-		strategy_matches_drr_requirements =
+		strategy_matches_drr_requirements &=
 				stream_matches_drr_policy(pmo, display_cfg, per_stream_pstate_strategy[stream_index], stream_index);
 
 		if (per_stream_pstate_strategy[stream_index] == dml2_pmo_pstate_strategy_fw_svp ||
-- 
2.34.1

