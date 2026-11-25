Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B3A606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=x+XcSdNA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7799410F74D;
	Wed, 25 Nov 2026 06:58:59 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928AE10F74D
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:58:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCADue6AdYuK2Kw2xkfDvrtTGcBP5uc63J2gfPww5cLr+yCn3TkfAKScaWvtkkp93AnS9tkhi4Z67QRt/Z0+QEmM3bRfw4Gs5rrdEXRehjouwU09JL2ixd+oU+xDEi6sMTFoY7g10iWknLbH9CNkCugam2E8tl3znc0V4UhZBPojfKfNdFLADvAjSavBC9cIYksG0A66gIRyf2F3Nd1ZFrRB9pXKrhVbYPz/Rwo+9eMUKQ+1ZLwYuVEEAlo/LocdglHg+a2aipJfZUTRSANCMTqz3WPW2LpWpVWhG3LQYGdmKtLAgeBv3Vtgq85+G1L262XaQepnzbsAmHQIclCCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGlY0poJetv+vpgpOLxZbgOAZV88ycfg9NNaVZ2Wmfo=;
 b=y6QtLiozL63VSp9wJnpWKkNwuACaCu+Pie/CPv+szYkOOzQd5JT4jrvjGkC31E30hQ3waHCveovNt6SgK15MB/tSKalTg8YcPRVbqt9EcmoFjL2cBQy42W/XN80CIZTpQf8IXQ9Wm4DlccdkHdLURrpXDaNHCCHup9suqxs+QKCRF0vE2OJTByMid6YBwnan2t97ZzBcc9qDIGmJ/ZMIUxFJnKrKzp4HKS9hru16UEzLvlWX4ru6U6VPQRLPvvnKVdVrCRErR6VhzSKuu62haSURX7Uio7ef3DCmQWttVcpcbv9Da9XHvlYY7e5YB3ycBP9d3dWX/p6Ay7ANPpKVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGlY0poJetv+vpgpOLxZbgOAZV88ycfg9NNaVZ2Wmfo=;
 b=x+XcSdNA6BH3MF+lfR9va8CLRUkCsKoKk2NjV0LtCDv/3zt4XsKixi2rltcXNSintjyZYCgeU1gYdQa8mfrnz1XxG4dA/2vRpKTtZ/YfZ8oZl+oMqFl2KN2Hfzww/4NCZ8QlDUYH7+z19hY5eAtmD9IJu9CLdNKujOGR4x/5ecI=
Received: from SJ0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:a03:333::27)
 by IA0PR12MB7508.namprd12.prod.outlook.com (2603:10b6:208:440::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 06:58:45 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::56) by SJ0PR03CA0112.outlook.office365.com
 (2603:10b6:a03:333::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 25
 Nov 2026 06:58:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:58:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:58:43 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:58:43 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:58:34 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 23/27] drm/amd/display: Use Z8 enter plus exit for vblank
 reserve
Date: Wed, 25 Nov 2026 14:55:12 +0800
Message-ID: <20261125065631.3889665-24-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|IA0PR12MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 207dc799-0ab8-4c74-ab50-08df4ac18bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|22082099003|18002099003|3023799007|261009223027099003|261021123027099003|261026121527099003|261022113327099003|261028144727099003|11063799006|261021121427099003|56012099006|261026135527099003|261102123227099003|261022115727099003|261021135927099003|261026130827099003|261022105027099003|261026140227099003|261021133027099003|261021130227099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: mApN3AitlCcBM6CUcbRuzXPgSJ4B0AwDm7F/dnkx6PcUhOMZacTtXtz5uoZDPVcmrr4d+495ad1uzJbgisFH0MZ59ul5sZ9ZhBTTUI53+aoQIaENfBGro6lezlWsvq+MVvRgmN9iKzfyeuPTJzjqrxpyivEB/Qv4/r2ViohNjxPnbYA/dtCm7XtR2sbIBRYX5/aQ8gnORY51Zp6IAvnNZU+9wiLDkKuAizqPwqViiPmVV5XoFR6gcHRQiVvLlq23iZTB+7S3x8cu1A5B+sWQwgIR282KaxEbxpaxcX0ZYguJ/Cqr33A0WdCGGXFmc6kMncWAb+6x57S5LPzdPtSxRyz+8Y3xMiTrAB5ahqfWMiTwybnMtVoZbPC3UaNmLqgQ4/tQP6wxdh7Dzxs+cv3O7TTna6edgXwvAb88FefvaSIeoZur9Fb24PGDJmqGL+ZfrKRksK3IG0mbZAyPNycQcSRVioNzmmPSy/7aRLMOiZGADHqpBPAnKKnrSIihkF9nBDZM7MkvNI4he1Mq2U97CAdnyQ4WQ7rxQkib/d64Znu5hYMAdYwgTkpqogVLZdRBSdebCc0Z3qXMpSFGorMthUbVa3pqDBoAPovSvA8SWSrr1NNA7/2SpkYYt8k8VAOYLCMTvaFSPPBkUztDpNqU+AYeHqy+geKK4eburp3cUN2/h52gbrLeIK+JI9mKW9deEuhaRNGUH9Ojliiy0+5Rdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(22082099003)(18002099003)(3023799007)(261009223027099003)(261021123027099003)(261026121527099003)(261022113327099003)(261028144727099003)(11063799006)(261021121427099003)(56012099006)(261026135527099003)(261102123227099003)(261022115727099003)(261021135927099003)(261026130827099003)(261022105027099003)(261026140227099003)(261021133027099003)(261021130227099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tt5gw/hLf7D+JZhN2ujxuQP+6Okmgz+jbV36CuVgK1zf2X/09CluiBmQsPzd2wgwv2KqE7MHasewhp82JXnOcGeDWUEeRjg0Ptv+zaNsair82RgbeotjOZ5VubaDDOzrNnWNkDEv5OGoy7Xmwj5varYNnZvnXUSu6zj/wAISuu1T+zpFfCEMcKpD5n9YhgVZIVHKgBygnLhq/eG7aRhFBl2zLlilqsC+Ao6EQkRLY5fQWzo8MgYfy/0HDAoltzxj19LOdiLby2LBijWRDjvEoCkXubjFqTP3esNeMg1/9drb4rRWR+8v2itQZephsGwVRPUG03zsPMeTgdeexeCYgecvpGrOnglTaYUNoumQjpSfEeyZMKpw4/4wcanc5deL6boxnQUT0Pg2+5sxpLUWNRKfAZKZ6acrhH+9GfG0AtnkGsKHyQvvvI9+adRUyudg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:58:44.6592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 207dc799-0ab8-4c74-ab50-08df4ac18bf6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7508
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[Why]
The FAMS2 PMO stutter optimization uses the Z8 stutter exit latency
both to decide whether Z8 meets its eco requirement and as the vblank
time to reserve for Z8. The reserved vblank time is what feeds
min_ttu_vblank, so it only covered the exit latency rather than the
full Z8 enter plus exit latency.

Also, the stutter candidate index is never advanced, so when the Z8
candidate fails mode support the regular stutter candidate is never
attempted and the whole stutter optimization is dropped.

[How]
Use z8_stutter_enter_plus_exit_latency_us instead of
z8_stutter_exit_latency_us in pmo_dcn4_fams2_init_for_stutter() for
the Z8 eco check and for the Z8 vblank reserved time candidate, and in
pmo_dcn4_fams2_test_for_stutter() for the reserved vblank time check.

In pmo_dcn4_fams2_optimize_for_stutter(), advance to the next
candidate on each attempt instead of giving up after the first one
fails. Track which candidate is the Z8 one, and only require the Z8
reserved time in the stutter test while that candidate is the one
being attempted.

Fewer configs now meet the Z8 eco check. Configs that still meet it
reserve more vblank time (Z8 enter plus exit latency). Configs that no
longer meet it fall back to the regular stutter candidate.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 35 +++++++++++--------
 .../src/inc/dml2_internal_shared_types.h      |  1 +
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
index 62ac29dfe9be..cd68b5010a06 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c
@@ -2387,7 +2387,7 @@ bool pmo_dcn4_fams2_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in
 
 	for (i = 0; i < in_out->base_display_config->display_config.num_planes; i++) {
 		if (in_out->base_display_config->mode_support_result.cfg_support_info.plane_support_info[i].active_latency_hiding_us <
-			pmo->soc_bb->power_management_parameters.z8_stutter_exit_latency_us + pmo->soc_bb->power_management_parameters.z8_min_idle_time) {
+			pmo->soc_bb->power_management_parameters.z8_stutter_enter_plus_exit_latency_us + pmo->soc_bb->power_management_parameters.z8_min_idle_time) {
 			stutter_period_meets_z8_eco = false;
 			break;
 		}
@@ -2414,8 +2414,9 @@ bool pmo_dcn4_fams2_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in
 	pmo->scratch.pmo_dcn4.cur_stutter_candidate = 0;
 
 	if (stutter_period_meets_z8_eco && !z8_stutter_optimization_too_expensive) {
-		if (pmo->soc_bb->power_management_parameters.z8_stutter_exit_latency_us > 0) {
-			pmo->scratch.pmo_dcn4.optimal_vblank_reserved_time_for_stutter_us[pmo->scratch.pmo_dcn4.num_stutter_candidates] = (unsigned int)pmo->soc_bb->power_management_parameters.z8_stutter_exit_latency_us;
+		if (pmo->soc_bb->power_management_parameters.z8_stutter_enter_plus_exit_latency_us > 0) {
+			pmo->scratch.pmo_dcn4.optimal_vblank_reserved_time_for_stutter_us[pmo->scratch.pmo_dcn4.num_stutter_candidates] = (unsigned int)pmo->soc_bb->power_management_parameters.z8_stutter_enter_plus_exit_latency_us;
+			pmo->scratch.pmo_dcn4.stutter_candidate_is_z8[pmo->scratch.pmo_dcn4.num_stutter_candidates] = true;
 			pmo->scratch.pmo_dcn4.num_stutter_candidates++;
 			pmo->scratch.pmo_dcn4.z8_vblank_optimizable = true;
 		}
@@ -2425,6 +2426,7 @@ bool pmo_dcn4_fams2_init_for_stutter(struct dml2_pmo_init_for_stutter_in_out *in
 
 	if (!stutter_optimization_too_expensive && pmo->soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us > 0) {
 		pmo->scratch.pmo_dcn4.optimal_vblank_reserved_time_for_stutter_us[pmo->scratch.pmo_dcn4.num_stutter_candidates] = (unsigned int)pmo->soc_bb->power_management_parameters.stutter_enter_plus_exit_latency_us;
+		pmo->scratch.pmo_dcn4.stutter_candidate_is_z8[pmo->scratch.pmo_dcn4.num_stutter_candidates] = false;
 		pmo->scratch.pmo_dcn4.num_stutter_candidates++;
 	}
 
@@ -2442,9 +2444,9 @@ bool pmo_dcn4_fams2_test_for_stutter(struct dml2_pmo_test_for_stutter_in_out *in
 	unsigned int i;
 
 	for (i = 0; i < in_out->base_display_config->display_config.num_planes; i++) {
-		if (pmo->soc_bb->power_management_parameters.z8_stutter_exit_latency_us > 0 &&
+		if (pmo->soc_bb->power_management_parameters.z8_stutter_enter_plus_exit_latency_us > 0 &&
 			pmo->scratch.pmo_dcn4.z8_vblank_optimizable &&
-			in_out->base_display_config->display_config.plane_descriptors[i].overrides.reserved_vblank_time_ns < (int)pmo->soc_bb->power_management_parameters.z8_stutter_exit_latency_us * 1000) {
+			in_out->base_display_config->display_config.plane_descriptors[i].overrides.reserved_vblank_time_ns < (int)pmo->soc_bb->power_management_parameters.z8_stutter_enter_plus_exit_latency_us * 1000) {
 			success = false;
 			break;
 		}
@@ -2466,17 +2468,20 @@ bool pmo_dcn4_fams2_optimize_for_stutter(struct dml2_pmo_optimize_for_stutter_in
 
 	memcpy(in_out->optimized_display_config, in_out->base_display_config, sizeof(struct display_configuation_with_meta));
 
-	if (!in_out->last_candidate_failed) {
-		if (pmo->scratch.pmo_dcn4.cur_stutter_candidate < pmo->scratch.pmo_dcn4.num_stutter_candidates) {
-			for (i = 0; i < in_out->optimized_display_config->display_config.num_planes; i++) {
-				/* take the max of the current and the optimal reserved time */
-				in_out->optimized_display_config->display_config.plane_descriptors[i].overrides.reserved_vblank_time_ns =
-						(long)math_max2(pmo->scratch.pmo_dcn4.optimal_vblank_reserved_time_for_stutter_us[pmo->scratch.pmo_dcn4.cur_stutter_candidate] * 1000,
-						in_out->optimized_display_config->display_config.plane_descriptors[i].overrides.reserved_vblank_time_ns);
-			}
-
-			success = true;
+	if (pmo->scratch.pmo_dcn4.cur_stutter_candidate < pmo->scratch.pmo_dcn4.num_stutter_candidates) {
+		for (i = 0; i < in_out->optimized_display_config->display_config.num_planes; i++) {
+			/* take the max of the current and the optimal reserved time */
+			in_out->optimized_display_config->display_config.plane_descriptors[i].overrides.reserved_vblank_time_ns =
+					(long)math_max2(pmo->scratch.pmo_dcn4.optimal_vblank_reserved_time_for_stutter_us[pmo->scratch.pmo_dcn4.cur_stutter_candidate] * 1000,
+					in_out->optimized_display_config->display_config.plane_descriptors[i].overrides.reserved_vblank_time_ns);
 		}
+
+		/* only require the Z8 reserved time in the stutter test while the Z8 candidate is the one being attempted */
+		pmo->scratch.pmo_dcn4.z8_vblank_optimizable =
+				pmo->scratch.pmo_dcn4.stutter_candidate_is_z8[pmo->scratch.pmo_dcn4.cur_stutter_candidate];
+
+		pmo->scratch.pmo_dcn4.cur_stutter_candidate++;
+		success = true;
 	}
 
 	return success;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index 54ec7ef7cbae..3f51c26dc238 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -1093,6 +1093,7 @@ struct dml2_pmo_scratch {
 			struct dml2_pstate_meta stream_pstate_meta[DML2_MAX_PLANES];
 
 			unsigned int optimal_vblank_reserved_time_for_stutter_us[DML2_PMO_STUTTER_CANDIDATE_LIST_SIZE];
+			bool stutter_candidate_is_z8[DML2_PMO_STUTTER_CANDIDATE_LIST_SIZE];
 			unsigned int num_stutter_candidates;
 			unsigned int cur_stutter_candidate;
 			bool z8_vblank_optimizable;
-- 
2.43.0

