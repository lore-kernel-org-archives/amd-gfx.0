Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698DBC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 16:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A71B610F7DE;
	Wed, 25 May 2022 16:20:41 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2072.outbound.protection.outlook.com [40.107.212.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9395F10E677
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 16:20:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHLvUZkR62OVi4sAJo/seJLJRu/Brtjh9BGJdJXlQxz7399Vfsf777vzcqPpIbLrpRP+O7nGPGUaEYZwjOgQTyHKhqAhZhR0wz0/2LI6MHIwNlgoZdUnnL1IxSaIYaGAQTJbVzYxMZdK/X7DI9T0RRjW8DRBbPbMTtd4o/GUYBLQVz8sEPOWUsphn96Q/a8dH8apvc58CJCKa8InW/HjNHEDwp1SLj5PbzpQEqQy0kOj2ThSw/Ob42UaN3AX/HLvqANj89fiUPA3/sOk/R05GKp4dzxsTNy9O7jNAe1VfPE0M4V0smGbYUD1FGbGmb8E9CyH8GU8Lx7JHekWXdcxCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f08S6WZQFYDrpTBpP/nC7a0acI01nsmDBCnwpzHFSuc=;
 b=IuU+np41Vy28FvPqk2lydQgd97qHxdkaGf5ZZgF+fciX3g+MVHNND/Gtp3jhlqMg886/pcGvGjxnQiO32DD6RE1M9LJvbOwiI3rscLsiPPHJKKwAeJJ5yuQjSMccBHlofM5wdy8IO5tFVKXsFK5JQJbNZSp3K8lJhuZZ4lHM9lrh6qpvgebALPON+cS6gsMh+S9Js5/8JZQCHVb9PHYf26WIQUv3xVfobmQ0h/BeVHpj37o1gc4hav/n67AtmDrnT4lceo55ZukTUrQPVeW2U6q9eTkvwxp2XaVinGoREoK77Pcs55E51PZoZBj0GhCnS4teAx6fq3kEeaPEQEK/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f08S6WZQFYDrpTBpP/nC7a0acI01nsmDBCnwpzHFSuc=;
 b=FojerS+SsnyGUj3ZenvKaRVV4MKDYKfg4RvWWXT/752sycpWDl8jsd08xTsBH0dR7YL8+/uEvakXJIcyBRjTKdpvgeUtJ+ogpfaH57q9wwgDIHPHJIaXcu6lz363rna1os9/f7Ds0p6DIojjL7wvjoWfUGFvgUILmpIgUj3RZeA=
Received: from DM5PR05CA0017.namprd05.prod.outlook.com (2603:10b6:3:d4::27) by
 BYAPR12MB3334.namprd12.prod.outlook.com (2603:10b6:a03:df::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.22; Wed, 25 May 2022 16:20:23 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::da) by DM5PR05CA0017.outlook.office365.com
 (2603:10b6:3:d4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 16:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 16:20:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 25 May
 2022 11:20:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 38/43] drm/amd/display: Introduce new update_clocks logic
Date: Wed, 25 May 2022 12:19:36 -0400
Message-ID: <20220525161941.2544055-38-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220525161941.2544055-1-alexander.deucher@amd.com>
References: <20220525161941.2544055-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1560220d-999a-4707-6f21-08da3e6a785b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3334:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3334626586AF6703A1C880A7F7D69@BYAPR12MB3334.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zvqcy5ORCj4lTevwZ3MCBLX1zuJBwYgqzwWBw0HjZVL423Jz6t27jDBGCY4yd+g5gJoOeQT9xEeJg2sU4RtoCQnuupZ/j89bRJjZEKqsTUfajlFWT7Ar6h8NjsiGBpWfGMojAYO3gnET5KOi8Bl3odsrCiqN12KBovNoq1Pnnetxg3m4P9soOQ7HfvvEhoQYqHQCn8u8lRy0MFfXlC5jMcob8K3JxSsf2WzjqipuvpQ+y4+KRHTKjgo0Cg+p+tynYF66NCQiFLFos3mjAnqCLsQzKXD8pjpGe0cxkEXGAqQ2g/AqYxSMUPRdQmDZk91U82R0wZtC0UaV5GjBRLGyqfXPxRz06fYXQ0rH9GywieftHrEDoD51hDfrFauypZd9uiMUpRSYpx3IwthfrNM6wlpkLGbj+i/tzuSmf5uwa4WxCPOJWPs8n/CqJeYTIL98BEf7GkVqtBuCbHIyHQcV20pvJ/lCHp+PIJGr3SQg8Zpp68TX/qG1CD/usaHYqbRZ3iXt76OpQ4fp42kwytnYY4qWD7hbREKbrJi08Jr1+db61YKRTrXbgQKpGxSRd8fsAJt2STQs8miQ2Xo9iLZ8fXEp/QFxHBtb2TfQfZMTnZWEgH9zfX37AoSgTc99WNped5yyouyDwqTPDF8Ip2euawX6cKIozHkxOom7buVUCnuT+EYaSoSkxNGP8A3dW9DY/lKuN2384oCEQ0DKdkVs4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(186003)(2906002)(15650500001)(26005)(82310400005)(316002)(81166007)(356005)(54906003)(36756003)(8936002)(6916009)(7696005)(4326008)(508600001)(36860700001)(5660300002)(86362001)(1076003)(40460700003)(83380400001)(336012)(70206006)(47076005)(426003)(6666004)(8676002)(16526019)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 16:20:23.1966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1560220d-999a-4707-6f21-08da3e6a785b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3334
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <Jun.Lei@amd.com>

[why]
DCN has sidebands to control some clocks, it is useful for clk_mgr to
always update the clocks it explicitly controls rather than skip them
because it enables more configurations to work without SMU

[how]
only skip handling clocks where SMU manages the frequency for clocks
with DENTIST sideband (DISP/DPP), only skip the voltage request when SMU
not available, but otherwise proceed normally

Signed-off-by: Jun Lei <Jun.Lei@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 125 ++++++++++--------
 1 file changed, 73 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index bd2352e61040..390432537305 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -310,69 +310,84 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (display_count == 0)
 		enter_display_off = true;
 
-	if (enter_display_off == safe_to_lower)
-		dcn30_smu_set_num_of_displays(clk_mgr, display_count);
+	if (clk_mgr->smu_present) {
+		if (enter_display_off == safe_to_lower)
+			dcn30_smu_set_num_of_displays(clk_mgr, display_count);
 
-	if (dc->debug.force_min_dcfclk_mhz > 0)
-		new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
-				new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
+		if (dc->debug.force_min_dcfclk_mhz > 0)
+			new_clocks->dcfclk_khz = (new_clocks->dcfclk_khz > (dc->debug.force_min_dcfclk_mhz * 1000)) ?
+					new_clocks->dcfclk_khz : (dc->debug.force_min_dcfclk_mhz * 1000);
 
-	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
-		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCFCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
-	}
+		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
+			clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
+			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DCFCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz));
+		}
 
-	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
-		clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
-		dcn30_smu_set_min_deep_sleep_dcef_clk(clk_mgr, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz));
-	}
+		if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
+			clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
+			dcn30_smu_set_min_deep_sleep_dcef_clk(clk_mgr, khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz));
+		}
 
-	if (should_set_clock(safe_to_lower, new_clocks->socclk_khz, clk_mgr_base->clks.socclk_khz))
-		/* We don't actually care about socclk, don't notify SMU of hard min */
-		clk_mgr_base->clks.socclk_khz = new_clocks->socclk_khz;
+		if (should_set_clock(safe_to_lower, new_clocks->socclk_khz, clk_mgr_base->clks.socclk_khz))
+			/* We don't actually care about socclk, don't notify SMU of hard min */
+			clk_mgr_base->clks.socclk_khz = new_clocks->socclk_khz;
 
-	clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
-	clk_mgr_base->clks.fclk_prev_p_state_change_support = clk_mgr_base->clks.fclk_p_state_change_support;
+		clk_mgr_base->clks.prev_p_state_change_support = clk_mgr_base->clks.p_state_change_support;
+		clk_mgr_base->clks.fclk_prev_p_state_change_support = clk_mgr_base->clks.fclk_p_state_change_support;
+		clk_mgr_base->clks.prev_num_ways = clk_mgr_base->clks.num_ways;
 
-	total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
-	p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
-	fclk_p_state_change_support = new_clocks->fclk_p_state_change_support || (total_plane_count == 0);
-	if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
-		clk_mgr_base->clks.p_state_change_support = p_state_change_support;
+		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
+				clk_mgr_base->clks.num_ways < new_clocks->num_ways) {
+			clk_mgr_base->clks.num_ways = new_clocks->num_ways;
+			dcn32_smu_send_cab_for_uclk_message(clk_mgr, clk_mgr_base->clks.num_ways);
+		}
 
-		/* to disable P-State switching, set UCLK min = max */
-		if (!clk_mgr_base->clks.p_state_change_support)
-			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
-					clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
-	}
+		total_plane_count = clk_mgr_helper_get_active_plane_cnt(dc, context);
+		p_state_change_support = new_clocks->p_state_change_support || (total_plane_count == 0);
+		fclk_p_state_change_support = new_clocks->fclk_p_state_change_support || (total_plane_count == 0);
+		if (should_update_pstate_support(safe_to_lower, p_state_change_support, clk_mgr_base->clks.p_state_change_support)) {
+			clk_mgr_base->clks.p_state_change_support = p_state_change_support;
+
+			/* to disable P-State switching, set UCLK min = max */
+			if (!clk_mgr_base->clks.p_state_change_support)
+				dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK,
+						clk_mgr_base->bw_params->clk_table.entries[clk_mgr_base->bw_params->clk_table.num_entries - 1].memclk_mhz);
+		}
+
+		if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 &&
+				should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
+			clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
 
-	if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 &&
-			should_update_pstate_support(safe_to_lower, fclk_p_state_change_support, clk_mgr_base->clks.fclk_p_state_change_support)) {
-		clk_mgr_base->clks.fclk_p_state_change_support = fclk_p_state_change_support;
+			/* To disable FCLK P-state switching, send FCLK_PSTATE_NOTSUPPORTED message to PMFW */
+			if (!clk_mgr_base->clks.fclk_p_state_change_support) {
+				/* Handle code for sending a message to PMFW that FCLK P-state change is not supported */
+				dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_NOTSUPPORTED);
+			}
+		}
 
-		/* To disable FCLK P-state switching, send FCLK_PSTATE_NOTSUPPORTED message to PMFW */
-		if (!clk_mgr_base->clks.fclk_p_state_change_support) {
-			/* Handle code for sending a message to PMFW that FCLK P-state change is not supported */
-			dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_NOTSUPPORTED);
+		/* Always update saved value, even if new value not set due to P-State switching unsupported */
+		if (should_set_clock(safe_to_lower, new_clocks->dramclk_khz, clk_mgr_base->clks.dramclk_khz)) {
+			clk_mgr_base->clks.dramclk_khz = new_clocks->dramclk_khz;
+			update_uclk = true;
 		}
-	}
 
-	/* Always update saved value, even if new value not set due to P-State switching unsupported */
-	if (should_set_clock(safe_to_lower, new_clocks->dramclk_khz, clk_mgr_base->clks.dramclk_khz)) {
-		clk_mgr_base->clks.dramclk_khz = new_clocks->dramclk_khz;
-		update_uclk = true;
-	}
+		/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
+		if (clk_mgr_base->clks.p_state_change_support &&
+				(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support))
+			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+
+		if (clk_mgr_base->clks.fclk_p_state_change_support &&
+				(update_uclk || !clk_mgr_base->clks.fclk_prev_p_state_change_support)) {
 
-	/* set UCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
-	if (clk_mgr_base->clks.p_state_change_support &&
-			(update_uclk || !clk_mgr_base->clks.prev_p_state_change_support))
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_UCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dramclk_khz));
+			/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
+			dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_SUPPORTED);
+		}
 
-	if (clk_mgr_base->ctx->dce_version != DCN_VERSION_3_21 &&
-			clk_mgr_base->clks.fclk_p_state_change_support &&
-			(update_uclk || !clk_mgr_base->clks.fclk_prev_p_state_change_support)) {
-		/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
-		dcn32_smu_send_fclk_pstate_message(clk_mgr, FCLK_PSTATE_SUPPORTED);
+		if (clk_mgr_base->clks.num_ways != new_clocks->num_ways &&
+				clk_mgr_base->clks.num_ways > new_clocks->num_ways) {
+			clk_mgr_base->clks.num_ways = new_clocks->num_ways;
+			dcn32_smu_send_cab_for_uclk_message(clk_mgr, clk_mgr_base->clks.num_ways);
+		}
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr_base->clks.dppclk_khz)) {
@@ -380,13 +395,19 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			dpp_clock_lowered = true;
 
 		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
+
+		if (clk_mgr->smu_present)
+			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
+
 		update_dppclk = true;
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
-		dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dispclk_khz));
+
+		if (clk_mgr->smu_present)
+			dcn30_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dispclk_khz));
+
 		update_dispclk = true;
 	}
 
-- 
2.35.3

