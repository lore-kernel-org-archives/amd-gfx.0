Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58A4CD11DD
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5034710E5AB;
	Thu, 28 Mar 2024 19:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V8OxZUL2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A3C510E588
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKcm9npMB4W84cTPP/DkU5EXpv5cPSFt1dQb2BhFwYQMdQ7n3wg96+612vidIsZRZ39n1/ULRKKxeqWYlwTdQMU4wcERcVVT2Xo6Z3yR8tlCjfKFCfNxX2t1IbwYrPXq1Q69pZX3HJmBCGOYWhhPBJcK8g5/YW2WQoPFr+PzcUUJyQdr5uUc4vZ/Mj8j6c4p0fwxNFAJ9ssHNROKrJGPDXIr/e6MAkey0QekD4wHS5jxuigJGCzp78HYe34SojEbCM6hMCJffEyRl/585x7fl87p50Bj+mrbEXOHU9l99FprwNr9BcWXxDnEOt+FkwRG3GxFlm/0/y4CJBmv2YkiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHJspUUnpdQlltNbuxVqU7Se8dmp70v9a656UImNjxM=;
 b=RGkPEfY6En9mR2pJ/zJ7F4ljsBXwILxLb9Dm/2kPKYyI3+EgB3ZdrAy/5jIhkKr2Z7yKj18uBUFQZvILuLUrqX8jYZtDhJXY9WOPDfuLwAHvKCitqEWVSR08To0ngF5nUSFr3HoHiAL6tkEHGdK84TVp79v8L/LCXRWoGE7xiZqNRXF8/N0RdZ8D5+gD0RTwHm3pao8m3wvJHVVAofWKnlzYXmt0o3yR9Gu+H63J/GqYTPxyQV/dv0Au3Ssfm64BFTJLuXrZ1BQaFoQP0NJrzx3gDdXmEjCp8tJwCCDlBTTfI9B+Y0UrxhYMiKNLBBRhCQkeik42N5GYkvM8L3ScbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHJspUUnpdQlltNbuxVqU7Se8dmp70v9a656UImNjxM=;
 b=V8OxZUL2BJJitjRTn+rDh6X7rir/TSJTPV4I8uQwNy+MrMzJ86Wylf39JLXpwIQWF2NxFJ+9g4+/zwC5P/ooT1esLOCbODjiJClqSwP18VWc4ll1t+0r6v64wJ4oEH332PPPf1gjP1UKR5/hVRj78A+Exrb2IzBh5LpfAk4BJVQ=
Received: from CH2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:610:54::19)
 by DM3PR12MB9415.namprd12.prod.outlook.com (2603:10b6:8:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 19:51:38 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::ad) by CH2PR11CA0009.outlook.office365.com
 (2603:10b6:610:54::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:36 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:35 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:35 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Joshua Aberback
 <joshua.aberback@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 09/43] drm/amd/display: handle invalid connector indices
Date: Thu, 28 Mar 2024 15:50:13 -0400
Message-ID: <20240328195047.2843715-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DM3PR12MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bd28bb-34a6-416f-2619-08dc4f607b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYJLA7SMxZSJzvdF6F0Y4nPeIMTMRvj20FE7dbYOKNO5oL9kloR9akTIwO2VGJECxLXtkJJipHr//HmA+d0MuiyeVBpZEl0Bdkb1bEY3MHzm/u98oCk1p2JHuJzPCIeejucexgex3CQQY53mICkSMJwHKY5bv8AurNAR2p3JHKjU8ZCWXzsVSSjMFf5hLr6wyjygFxSao3W6WOYLmYDnKu7IxcpGqjXiJsppIh7cXkrUovR+9euBOdXnhydkPjN7NVxtL/yyAAnw8momIuiiOAcaS67qancEYZVodhAxcAjirFs/ZMMZnmZ3/WRL5rLbYuhMmtdxUU9/Mvo6i2He6zD3pvilNfOxynnLqlLA5RVZ+KSBZVXFBdUTy9cK6t8b3g9+5/je62VHv0GZ3pU3fZJ0eGdrOWWyjwsMHDwKO2ZlFepmu8f/iIEI0dTS7sNed256hbAxuz2VTF/KdoMGGDWrqeommYPxuqA9/qkxjL9OxwEBedPhQEoHvaPsruc4bewYfeZcySe4ro3xavNB2ovweiqXBh6PoafD1kdMw0zCJqyTA1ENalerg8ZqFO358Q5L1gIGc0FrQSn+1R6hIm8tCMsavy9TroFE9J9XLMsr6v5v24KkCgIzj8kZFiAMHDrKiCeXRRINlibZgMk30Nx3LlKw+VzObk4sorj0cqBGwgtRUOA82yY9ozTBxXhbka1zGGexWeewqRKYcUDPvrxmT8k+90boCceOBleTEukmPQ1ZLBtfsBehQ+HuLC8u
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:38.0397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bd28bb-34a6-416f-2619-08dc4f607b2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9415
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

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
The function to count the number of valid connectors does not
guarantee that the first n indices are valid, only that there
exist n valid indices. When invalid indices are present, this
results in later valid connectors being missed, as processing
would end after checking n indices.

[How]
 - count valid indices separately from total indices examined
 - add explicit definition of MAX_LINKS

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c     | 2 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c                      | 3 ++-
 drivers/gpu/drm/amd/display/dc/dc.h                           | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h      | 2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h             | 1 +
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c   | 4 ++--
 8 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 5ee87965a078..bb4f3bd7532e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -503,7 +503,7 @@ static void dcn2_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct dc
 
 	clk_mgr->cur_phyclk_req_table[link->link_index] = link->cur_link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
 
-	for (i = 0; i < MAX_PIPES * 2; i++) {
+	for (i = 0; i < MAX_LINKS; i++) {
 		if (clk_mgr->cur_phyclk_req_table[i] > max_phyclk_req)
 			max_phyclk_req = clk_mgr->cur_phyclk_req_table[i];
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index e3e1940198a9..f65bb4c21b7d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -548,7 +548,7 @@ static void rn_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct dc_l
 
 	clk_mgr->cur_phyclk_req_table[link->link_index] = link->cur_link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
 
-	for (i = 0; i < MAX_PIPES * 2; i++) {
+	for (i = 0; i < MAX_LINKS; i++) {
 		if (clk_mgr->cur_phyclk_req_table[i] > max_phyclk_req)
 			max_phyclk_req = clk_mgr->cur_phyclk_req_table[i];
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 3271c8c7905d..4cb0db0ed92f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -474,7 +474,7 @@ static void dcn30_notify_link_rate_change(struct clk_mgr *clk_mgr_base, struct d
 
 	clk_mgr->cur_phyclk_req_table[link->link_index] = link->cur_link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
 
-	for (i = 0; i < MAX_PIPES * 2; i++) {
+	for (i = 0; i < MAX_LINKS; i++) {
 		if (clk_mgr->cur_phyclk_req_table[i] > max_phyclk_req)
 			max_phyclk_req = clk_mgr->cur_phyclk_req_table[i];
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 667655d0e5b9..c3510cdd0ec8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -212,7 +212,8 @@ static bool create_links(
 		connectors_num,
 		num_virtual_links);
 
-	for (i = 0; i < connectors_num; i++) {
+	// condition loop on link_count to allow skipping invalid indices
+	for (i = 0; dc->link_count < connectors_num && i < MAX_LINKS; i++) {
 		struct link_init_data link_init_params = {0};
 		struct dc_link *link;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 29fd8daa9d15..3ed41cf6a59d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1327,7 +1327,7 @@ struct dc {
 	struct dc_phy_addr_space_config vm_pa_config;
 
 	uint8_t link_count;
-	struct dc_link *links[MAX_PIPES * 2];
+	struct dc_link *links[MAX_LINKS];
 	struct link_service *link_srv;
 
 	struct dc_state *current_state;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index f4d4a68c91dc..4ba18ea57aad 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -349,7 +349,7 @@ struct clk_mgr_internal {
 	enum dm_pp_clocks_state cur_min_clks_state;
 	bool periodic_retraining_disabled;
 
-	unsigned int cur_phyclk_req_table[MAX_PIPES * 2];
+	unsigned int cur_phyclk_req_table[MAX_LINKS];
 
 	bool smu_present;
 	void *wm_range_table;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
index c1835ad6550f..c80ebb407add 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h
@@ -44,6 +44,7 @@
  */
 #define MAX_PIPES 6
 #define MAX_PHANTOM_PIPES (MAX_PIPES / 2)
+#define MAX_LINKS (MAX_PIPES * 2)
 #define MAX_DIG_LINK_ENCODERS 7
 #define MAX_DWB_PIPES	1
 #define MAX_HPO_DP2_ENCODERS	4
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 5491b707cec8..68a8fd7f84d0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -166,7 +166,7 @@ static uint8_t get_lowest_dpia_index(struct dc_link *link)
 	uint8_t idx = 0xFF;
 	int i;
 
-	for (i = 0; i < MAX_PIPES * 2; ++i) {
+	for (i = 0; i < MAX_LINKS; ++i) {
 
 		if (!dc_struct->links[i] ||
 				dc_struct->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
@@ -196,7 +196,7 @@ static int get_host_router_total_dp_tunnel_bw(const struct dc *dc, uint8_t hr_in
 	struct dc_link *link_dpia_primary, *link_dpia_secondary;
 	int total_bw = 0;
 
-	for (uint8_t i = 0; i < (MAX_PIPES * 2) - 1; ++i) {
+	for (uint8_t i = 0; i < MAX_LINKS - 1; ++i) {
 
 		if (!dc->links[i] || dc->links[i]->ep_type != DISPLAY_ENDPOINT_USB4_DPIA)
 			continue;
-- 
2.34.1

