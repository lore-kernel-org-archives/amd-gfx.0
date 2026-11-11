Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC4606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ejA0qEOh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DDC410F8C5;
	Wed, 11 Nov 2026 01:41:50 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011033.outbound.protection.outlook.com [52.101.57.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E01E10F8C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ15BPZeqaFza9dfCUA+VokYSjEsPt5m0wVR6n7nN+mGFAcAODp0d4Y3F6gpUQg184oR6zvQFnkzPG5L9UPwW1CfYqFDDEbtG6AqK5s5e8kBX4h8RmjVR4FCa3EgTfvhcmUNI+3Uf5rF360j5/jGN+rEIytFLtJl+USrxdyKtl+TtgeI+n/Ak1WvuFmwuCImkvi+LiRUJJ3Ajmnq2ElVtJlVDeRRSHvFD7XKWijuwY2vgxS9A8KlB/D1krtoHlNsIF+CxP1tcx1ubZ6n+RHQ7sLqqvJ0T89Ov4sIz9YY3ZzVzeIgHPYh6CGIv8+YwZw3Pc7L+ghr8wjMaYDy02mMJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVaR8Yi/n3P8R3/zNBxEVhy1vN1N4D4ar68k9tUJOqM=;
 b=GJt2zeqn2BcdP2UrunbO5OPidLMoL1NJnIH/1+lCgYDSsOi/bWo1Bgg2EzdYSnsFtoT3JI7HRG2NHmGWk3HM8zGfS6kgDtfduxjEV4jAMYtTTkKKIAGdLinh3tq99Wcw/XscE/cpl3/9fJL7+Y4kT8f3XZfQuBPLMymBpgtSMheSGzpON/Kxs07mxWN0iTQjhl54n6p+/wbVXdMuZ0H/Ph9tt+b6/0knraemXcbdp9FYG1WRhT25U1vqTF54ypzcZhKAOJyAd7RKsFk49zylxM2rEPvsBXIaA7rPqV8gu4rpUXxb7KYrym4DAzoBvNYV4nIg367kDiYTXwMcHdWgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVaR8Yi/n3P8R3/zNBxEVhy1vN1N4D4ar68k9tUJOqM=;
 b=ejA0qEOho+Mteew08vSX9NR6PkOwpvfqQkFtHlbpkBZoz4ojybjI66H7JjXrpq8KnlyQer8rCEWYCExyrWUeThFBPHXp1aYtNmHhpWmDLXiYMPqI1s1dTOFDFJd++3qtnonM1bF4dZnzTkHms/FrAe6ClxcpcbBIqhGBGMJj/nY=
Received: from SJ0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:a03:2c2::24)
 by LV3PR12MB9235.namprd12.prod.outlook.com (2603:10b6:408:1a4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 01:41:37 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::28) by SJ0PR13CA0049.outlook.office365.com
 (2603:10b6:a03:2c2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:41:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:41:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:36 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:41:35 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:41:32 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 19/74] drm/amd/display: Resolve the DCN401 DENTIST divider
 when the sequence is built
Date: Wed, 11 Nov 2026 09:28:25 +0800
Message-ID: <20261111014100.3596072-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|LV3PR12MB9235:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5b05ce-d88f-462d-f604-08df3f94ecc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|56012099006|261009223027099003|261026121527099003|261028144727099003|11063799006|261021121427099003|261021123027099003|261026140227099003|261022105027099003|261102123227099003|22082099003|18002099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: Dg3e1qxRfqZujYpXFv34EnC4USiwQa9CqvHVZQuIPRTmehfP0ASlGKS7lEEsxWgjL2JbXPBgGfhokugSlWY2i9mR5cdeE8OdXygisQcCONdea+E09uOlZcyGByeqIIvrchXjPROuxejryT3SUpsL3alvNv29qbBQfytu3tZW+cUymbch4MUAOVjrVLHWMw4scikxV3zGo7L6CXsRfNFUfWwkNqdxiL/EISOQV2KFFyMECNHqLZGAWx3+i62xbkDYk1LfmdowiKgP0P+9gnkJZCX6+bI/0fkFu3VYmG1+/+siV1B2TPe779IgmFwXS9oGi2lJJ9qqJUxrI5bGvWvx1hfjJeiYv/HHBljqomHp4bK3wvZG2rbg7S46Dnlx7BcevN9QWOWxMwYIRso1wwrEp8tPJGHMShIj3buUhWEh9PivBDy89Acux8w2tYxf7KdOJaPTps1+/iZg7LaLnLe57HEkkvaxbSbMwWtINnTLjAiM6+vvRomAVuBwuRjzm1iDOl/nr7McuWBH+Stq88KuYMGDDlIPNWTYu+M3V17SVXPIiG3o8eyefycwmq+wEjuz2WCFel5woiERrPnbXa0wSl6DJpVTBjHpNIc7zIkkOnuf0SXVqAaBc28/S5Sr8YT/Zr6Cnr6SLqLeh4nhWbOEc257T6Sr+zcJeg+WWA78qCpL4lHDxUNeUr18BHgNGCVJEy6/QqkII4fQ8HMlcsepcg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(56012099006)(261009223027099003)(261026121527099003)(261028144727099003)(11063799006)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(261102123227099003)(22082099003)(18002099003)(6133799003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RJVKMTMScM7kc2Ua2c5teKq16dRdtZN7poC1HqILMi1pgkPds1npAXwqgscBsOsjccAN33GhsdxMB+7pax8I3qUrKiG1/abN+mM6G+pEDBMX3yaLbklr8EWy7sxk88Ekrt6pBJo/gN6KoyNHXDeFe9D2Z6y3yzvNPM+Z/baiNKqodJqQp75DZGkyBxECis7mDPmP0EZv1rsD7Xp8YNoUnFzg+JbDZSJTJves/YIU1z2Ljc6DPof13HSQ0JIJgRbTrAnLChvI97xi+ShtMYYoMjthV/zaKTDp4iOJ+CtO2eJe43DH0iZ5xzA3bLwaLkYy9CSsIr6D9VA5ZmGCyhAyxwmDk8NMPXl/a98bNcnnYcXm4Eo9V9HtNPPI0VTK2T9sjtelWHke6XoAfa8BQUECatR4JuJ7cj5TN3eKOX4GdAKWF4EaqDOaMH+TSjH9+d8x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:41:36.8469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5b05ce-d88f-462d-f604-08df3f94ecc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9235
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

From: Piotr Maziarz <piotr.maziarz@amd.com>

[WHY]
The DCN401 clk_mgr DENTIST step keeps an unused dc_state pointer and, when
it executes, reads the current DISPCLK from clk_mgr, the DENTIST VCO
frequency and dc->debug.override_dispclk_programming to decide whether
and how to program the divider. DCN60 still declares the same unused
dc_state-carrying parameters.

[HOW]
Compute the DISPCLK divider when the sequence is built and store it in the
step. Emit the step only when the debug override is set and DISPCLK is
known, which is when the executor used to program anything; the executor
keeps only the register read-back and update.

Drop the unused DENTIST parameters from the DCN60 sequence.

Cc: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 63 ++++++++++---------
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |  2 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h  |  4 --
 3 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 0785f70fb535..dccc9012c7fc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -548,33 +548,18 @@ static int dcn401_set_hard_min_by_freq_optimized(struct clk_mgr_internal *clk_mg
 
 static void dcn401_update_clocks_update_dentist(
 		struct clk_mgr_internal *clk_mgr,
-		struct dc_state *context)
+		uint32_t new_dispclk_wdivider)
 {
-	(void)context;
-	uint32_t new_disp_divider = 0;
-	uint32_t new_dispclk_wdivider = 0;
 	uint32_t dentist_dispclk_wdivider_readback = 0;
-	struct dc *dc = clk_mgr->base.ctx->dc;
-
-	if (clk_mgr->base.clks.dispclk_khz == 0)
-		return;
-
-	new_disp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-			* clk_mgr->base.dentist_vco_freq_khz / clk_mgr->base.clks.dispclk_khz;
 
-	new_dispclk_wdivider = dentist_get_did_from_divider(new_disp_divider);
+	REG_GET(DENTIST_DISPCLK_CNTL,
+			DENTIST_DISPCLK_WDIVIDER, &dentist_dispclk_wdivider_readback);
 
-	if (dc->debug.override_dispclk_programming) {
-		REG_GET(DENTIST_DISPCLK_CNTL,
-				DENTIST_DISPCLK_WDIVIDER, &dentist_dispclk_wdivider_readback);
-
-		if (dentist_dispclk_wdivider_readback > new_dispclk_wdivider) {
-			REG_UPDATE(DENTIST_DISPCLK_CNTL,
-					DENTIST_DISPCLK_WDIVIDER, new_dispclk_wdivider);
-			REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 2000);
-		}
+	if (dentist_dispclk_wdivider_readback > new_dispclk_wdivider) {
+		REG_UPDATE(DENTIST_DISPCLK_CNTL,
+				DENTIST_DISPCLK_WDIVIDER, new_dispclk_wdivider);
+		REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 2000);
 	}
-
 }
 
 static void dcn401_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned int num_steps)
@@ -678,7 +663,7 @@ static void dcn401_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned
 		case CLK_MGR401_UPDATE_DENTIST:
 			dcn401_update_clocks_update_dentist(
 					clk_mgr_internal,
-					params->update_dentist_params.context);
+					params->update_dentist_params.dispclk_wdivider);
 			break;
 		case CLK_MGR401_UPDATE_PSR_WAIT_LOOP:
 			params->update_psr_wait_loop_params.dmcu->funcs->set_psr_wait_loop(
@@ -1009,6 +994,27 @@ static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 	return num_steps;
 }
 
+/* Outside the dispclk programming debug override, DENTIST is not reprogrammed here. */
+static unsigned int dcn401_add_update_dentist_step(
+		struct clk_mgr *clk_mgr_base,
+		struct dcn401_clk_mgr_block_sequence *block_sequence,
+		unsigned int num_steps)
+{
+	uint32_t new_disp_divider;
+
+	if (!clk_mgr_base->ctx->dc->debug.override_dispclk_programming ||
+			clk_mgr_base->clks.dispclk_khz == 0)
+		return num_steps;
+
+	new_disp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+			* clk_mgr_base->dentist_vco_freq_khz / clk_mgr_base->clks.dispclk_khz;
+
+	block_sequence[num_steps].params.update_dentist_params.dispclk_wdivider =
+			dentist_get_did_from_divider(new_disp_divider);
+	block_sequence[num_steps].func = CLK_MGR401_UPDATE_DENTIST;
+	return num_steps + 1;
+}
+
 static unsigned int dcn401_build_update_display_clocks_sequence(
 		struct clk_mgr *clk_mgr_base,
 		struct dc_state *context,
@@ -1119,9 +1125,7 @@ static unsigned int dcn401_build_update_display_clocks_sequence(
 			block_sequence[num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
 			num_steps++;
 
-			block_sequence[num_steps].params.update_dentist_params.context = context;
-			block_sequence[num_steps].func = CLK_MGR401_UPDATE_DENTIST;
-			num_steps++;
+			num_steps = dcn401_add_update_dentist_step(clk_mgr_base, block_sequence, num_steps);
 
 			if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DPPCLK)) {
 				block_sequence[num_steps].params.update_hardmin_optimized_params.ppclk = PPCLK_DPPCLK;
@@ -1146,11 +1150,8 @@ static unsigned int dcn401_build_update_display_clocks_sequence(
 				num_steps++;
 			}
 
-			if (update_dppclk || update_dispclk) {
-				block_sequence[num_steps].params.update_dentist_params.context = context;
-				block_sequence[num_steps].func = CLK_MGR401_UPDATE_DENTIST;
-				num_steps++;
-			}
+			if (update_dppclk || update_dispclk)
+				num_steps = dcn401_add_update_dentist_step(clk_mgr_base, block_sequence, num_steps);
 
 			block_sequence[num_steps].params.update_dppclk_dto_params.ref_dppclk_khz = &clk_mgr_base->clks.actual_dppclk_khz;
 			clk_mgr_build_dpp_dto_targets(dc, context, safe_to_lower,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
index a2ba8b665a14..c87fb8e794a6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
@@ -61,7 +61,7 @@ union dcn401_clk_mgr_block_sequence_params {
 	struct clk_mgr_dtbclk_dto_target update_dtbclk_dto_params;
 	struct {
 		/* inputs */
-		struct dc_state *context;
+		uint32_t dispclk_wdivider;
 	} update_dentist_params;
 	struct {
 		/* inputs */
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
index bd61817a5ef9..9f945d2eb78a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h
@@ -50,10 +50,6 @@ union dcn60_clk_mgr_block_sequence_params {
 		struct clk_mgr_dpp_dto_targets targets;
 	} update_dppclk_dto_params;
 	struct clk_mgr_dtbclk_dto_target update_dtbclk_dto_params;
-	struct {
-		/* inputs */
-		struct dc_state *context;
-	} update_dentist_params;
 	struct {
 		/* inputs */
 		struct dmcu *dmcu;
-- 
2.43.0

