Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F017C109E540
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 932F410E917;
	Thu, 26 Mar 2026 03:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LBA1/b1D";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6047310E917
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:00:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXN7ufhVTPsvLBvwByQay2u8OtOJG4IuxNPt5DJ76jA9mlGx9QNwtNvEKUkbYD8G4/V5yyUTdVtNbsmRIjFA5vIT6N7J3hvMTeqnODbxuiHk8obqGhUpQ3sQTwhSJbN5pQTL3RaARtkK2ihf+AvQe/twmM50HpUgWt9lGJsKlYUF/7oVmLFrgOaSYNvx0PIdXxYyyBm+RYdy/D8B1tU7QYkAAH1Fan7tXIBHz78D2PBld3SgIUHLp6vDiPVlV6Ooj6vu4fnTNmE17d8dqgXYVv+88tAWE62EP29QNTv+1XhXs293MFsGh7wx5fLhBUso6Y0osXxC03MoVg7oYPH0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpewwE/ncNEKwi9N9J94SfD6eQj22kOPQe2IsAaXqy4=;
 b=LhDti7gT4i8ocznXSlvu51g7ApzGQAgik64dQzJ9zvsD/fHvKHsGKphguon2JyV4QpQwsk1nHhjusA9c3/brlYAK9kIgK2dZb7vtxPhN/LDN7syNZoZFJfJ22c9zP4kWrfJ/v9FR28FgAH0HKZtOcCKEYMMLc/+klaeQuGcdfSH+sfWuPCQOmEq26TasRQsvRsU0voHJ7gm5D0VWgmxhCDEIhRUxrjuQBBmDL2JrcCompJZOyNJQzjONX2xZGcXs2BE/MurElyjG+Jgqjq530Jp30PO879qV9507PeBApRVWZpDXR2DRSj+97kVXDujDP3EsC5Bjw71uKc7iG2t7bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpewwE/ncNEKwi9N9J94SfD6eQj22kOPQe2IsAaXqy4=;
 b=LBA1/b1D4ae6x+8DGDKZurGNq1Z8xFXDywCxarNp3pdBkjj1GJTo6OLdnRqhdJcI8KYxORNVBmVUGZfcb+O//UMSG+jplSfrOaCGZdLVWnHIpaXQZlZkpWDZ0/QLYTddxGNqXQIDhSteRkVLjpylZSjVjpHy8vLRYY0vre2bGBg=
Received: from MN2PR01CA0004.prod.exchangelabs.com (2603:10b6:208:10c::17) by
 MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 03:00:37 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::e5) by MN2PR01CA0004.outlook.office365.com
 (2603:10b6:208:10c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:00:36 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:00:33 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH v2 03/30] drm/amd/display: Should support p-state under dcn21
Date: Thu, 26 Mar 2026 10:56:54 +0800
Message-ID: <20260326030153.406612-4-ChuanYu.Tseng@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|MN0PR12MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 2330277e-33bf-4d7b-aea3-08de8ae3db02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18092099006|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2o5fUe/NbJ9NJ4qrss+Y2a+c14TCAtcCJppILvBqwja+fB5HMXnRR0M5aHXYf3YHli6na0dCx7xzVGQlks61O+s/9NEfxR4AtwX6tGaYefskkhqw1cBWTXLqvo560OdxOTIcMOe8GB7ePWkcTHDEo9jFiBZ8nzhuRnbv8chuCzYG69Awv6fDh4WdY0icWqn7Ck1raLTNZ5go+macBH2u6MoJC4puhQrbVaQGBvIYsK+R7jsjDvUZHqejvs0V8nS+2zltcnMyDqnsPisuOSrvaKcVNE3kdFWmI2vTOepcgESuSaCniC6sqC8eRkO4o/RFaINbOhFhN907M+YH1A+Y4SvRNlQeysgfIOEo539O8owbz/b0+HNOIHskn9F9QzwIXUTGHuFwUNVxXO7zY7eW0O5tjj1+oAXV8xJZjVrIVjU6TlbYAArmPg1umbgQ61mvLZlk5YwkCsq0A9ZBkiNR6d7ROoHz/0MXS03YZELcwAU0ZWWk5IlKmeRt7JMzG7cgLgy762JuzEzcuBOzzRDXiTHby8ZDCOgv4qObmIyiA/NqKRv7D6/+s5pcpt8ZDRL+xSpnH0wP/GP8wUbSZMZIMqbDZ8FKLdFlwggp8Fhirw4yoFBic5Qm4NbED5EAKAVpKt8fsf+nlUJeixUAu6qXzyLybfHJAtOyXKFO3WB21EL+hHCxFIJS0diBcQPtM9mpZOeUleXVoQskGQkj2uT+NspS49dCdCa6lIR2kCF99us7G/tM6Vh8iz4aN+s1r+54ko2WNM2DfcywFquUJ6avXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18092099006)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fdnal4rtSg54ews2WOSmLhC858ygAImTFhsXVl+o9C9kW2OdiPxB0hx6CTgRdvMfxJaUZjgoFFrbaZKZS2nP1mEj4KQ2qcFsCITCmmuREEMBshJdDAa83nVrWoEbGViWJIV//KKN4R9/zA6CwLk8tSq8onvJozVgq542+00WGjIxS/s9B1nlzc7ek6aPkY14VvCwUZrifTsJU4HxbegtynkyoqFDrc8vLezoGksShDK6Vw9I1tF8MPXszlD1E25Kv9Nge16ajo+jv5Ej+o2pOphJ9V4damsjXyqHvE31fvgMHy0N4DQ3VTfexmnu6AQrwmN5N1vN6NpKR8UmjY+UonyxPv/30LgRL4iPlDTaPp9lmFsOEN4Pi1l9v4+2Tw/ZKAGCLUJdEfXL2Mw2EvOMelGzwIgSJ6LpMnhWSyb04n6TpdWwUVcq6uycsx81whrP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:00:36.9336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2330277e-33bf-4d7b-aea3-08de8ae3db02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Under DCN21, observe flip_done timeout issue while
running 3D benchmark under MPO case. Timeout is caused
by driver fails validate_bandwidth() during
atomic_commit_tail but passes atomic_check.

Under further analysis, indicates the delta of
atomic_check and atomic_commit_tail are
dc->current_state->bw_ctx.dml.soc.sr_exit_time_us and
dc->current_state->bw_ctx.dml.soc.sr_enter_plus_exit_time_us.

We set validate_mode as DC_VALIDATE_MODE_ONLY while calling
dc_validate_global_state() at atomic_check, but set mode as
DC_VALIDATE_MODE_AND_PROGRAMMING during atomic_commit_tail.
If dc_validate_mode set as DC_VALIDATE_MODE_ONLY,
validate_bandwidth() will skip the wm and dlg calculation.

During commit_tail, validate_bandwidth() is called with
dc_validate_mode set as DC_VALIDATE_MODE_AND_PROGRAMMING and
dc_state->bw_ctx.dml.soc.sr_exit_time_us might get modified
after the wm_calculation and stored into dc->current_state.
Which means dc->current_state->bw_ctx.dml.soc.sr_exit_time_us
might not aligned with the one stored in dm_state->context.
That causes duplicated dm_state->context not aligned with
dc->current_state, and might have bandwidth validation pass
in atomic_check and fail in commit_tail later.

[How]
When the issue occurs, it fails dml_get_voltage_level() with
the condition dm_allow_self_refresh_and_mclk_switch but pass
with the condition dm_allow_self_refresh. However, we should
support p-state. So we should not pass validate_bandwidth by
allowing self refresh only. Change the policy under DCN21.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  2 +-
 .../dc/resource/dcn21/dcn21_resource.c        | 30 +++++++++++--------
 .../dc/resource/dcn21/dcn21_resource.h        |  3 +-
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 7aaf13bbd4e4..ae34982b1b1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2335,7 +2335,7 @@ bool dcn21_validate_bandwidth_fp(struct dc *dc, struct dc_state *context,
 	/*Unsafe due to current pipe merge and split logic*/
 	ASSERT(context != dc->current_state);
 
-	out = dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel, validate_mode);
+	out = dcn21_fast_validate_bw(dc, context, pipes, &pipe_cnt, pipe_split_from, &vlevel, validate_mode, false);
 
 	if (pipe_cnt == 0)
 		goto validate_out;
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
index e57022af2c2a..a612c8932da9 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c
@@ -772,7 +772,8 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 			    int *pipe_cnt_out,
 			    int *pipe_split_from,
 			    int *vlevel_out,
-			    enum dc_validate_mode validate_mode)
+			    enum dc_validate_mode validate_mode,
+			    bool allow_self_refresh_only)
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
@@ -803,18 +804,23 @@ bool dcn21_fast_validate_bw(struct dc *dc,
 	vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 
 	if (vlevel > context->bw_ctx.dml.soc.num_states) {
-		/*
-		 * If mode is unsupported or there's still no p-state support then
-		 * fall back to favoring voltage.
-		 *
-		 * We don't actually support prefetch mode 2, so require that we
-		 * at least support prefetch mode 1.
-		 */
-		context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
-					dm_allow_self_refresh;
-		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
-		if (vlevel > context->bw_ctx.dml.soc.num_states)
+
+		if (allow_self_refresh_only) {
+			/*
+			 * If mode is unsupported or there's still no p-state support then
+			 * fall back to favoring voltage.
+			 *
+			 * We don't actually support prefetch mode 2, so require that we
+			 * at least support prefetch mode 1.
+			 */
+			context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
+						dm_allow_self_refresh;
+			vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+			if (vlevel > context->bw_ctx.dml.soc.num_states)
+				goto validate_fail;
+		} else {
 			goto validate_fail;
+		}
 	}
 
 	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.h
index a017fd9854d1..23d3a36872bb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.h
@@ -51,6 +51,7 @@ bool dcn21_fast_validate_bw(
 		int *pipe_cnt_out,
 		int *pipe_split_from,
 		int *vlevel_out,
-		enum dc_validate_mode validate_mode);
+		enum dc_validate_mode validate_mode,
+		bool allow_self_refresh_only);
 
 #endif /* _DCN21_RESOURCE_H_ */
-- 
2.43.0

