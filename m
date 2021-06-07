Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6178EC47095
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:47:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF8260FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF8260FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82236E92B;
	Mon,  7 Jun 2021 16:47:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B17756E928
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:47:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSYcivQt+4Is9eqQcCzbgeu0292fTp3kb8JRiCL63ZOQQxqjUblmYjR8yvCNID11WsEKbxiBQejamDNf1aLqkvDz7xfUFJyfp5gMCpmhv7WXJPatdH+/TrGEQI+xw96QiRRlUbVaegubJjCfmb5DFIKq09e/VKNwti/w1eTIW/EHBqS9I7qGHJCExDsF+pLN5PJ27FvfX6lnpnx1AUzkslQF9bDUqfpE+3LLouJK6n+Gizxz1IPAvRxLO3WR35a912CF7eQlFxxnOWK6HnFbhGPSe3gOj4hXhounb4yX1ZjNebNeO6bFdLEiix/AKLRiBY4YLnO4ZbEBYRGwODenkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKJdwdk6PT1RESZQ/sCzuzBaARTOCTf6I2TAbkTfrOI=;
 b=SUVXYPUPZzSw+LOOs6KXnbCpxh18fem1KSphkSVZN6Vm6mJlB9JkmF6yut5ZAT/veOiowEI0c1ylqF5gshbm3z2LwcrB5DI3rUD2BPwPePIrYLzJ5gXB15zadF/xJijeH2ik/rlxeg3MNOtVbbRMcOf1IVFWBs0Vqq5jCARNWoWf0s/AmHD/o9OX2AHkP4OtVa7saSDKungSQEXcQfP7XaQdAfnifxjfREZo/OZaCFk9iB2a3LjzkH3jNc8dQsc4PUw67gkgxYAzibjvsiNtaR977TQ6TuKNyagd0b/h/NstFA/BLBoAWBTD8ElNcivp6zx3uVk0Pst+lc5K6lZZUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKJdwdk6PT1RESZQ/sCzuzBaARTOCTf6I2TAbkTfrOI=;
 b=nRWILDeJyIpHxO/0KKdIMwY1AAF0eN2TmYAMeKjvC1qYjH2/WlQzEnfOYIidrcy9Sf4o1W1wwwmlYhkyt2qj8Po44yF+99mkAarBVr3GWdUF27Z/H9NTtX84/tVSAWr1+rWKwRKfEqCZddE2n7Tr+SS/W1qdnNP14z/bxHReiYU=
Received: from BN6PR13CA0027.namprd13.prod.outlook.com (2603:10b6:404:13e::13)
 by DM6PR12MB4698.namprd12.prod.outlook.com (2603:10b6:5:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Mon, 7 Jun
 2021 16:47:54 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::7) by BN6PR13CA0027.outlook.office365.com
 (2603:10b6:404:13e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend
 Transport; Mon, 7 Jun 2021 16:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:47:53 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:47:49 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/30] drm/amd/display: Enabling PSR support for multiple
 panels
Date: Tue, 8 Jun 2021 00:46:46 +0800
Message-ID: <20210607164714.311325-3-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bd1ca2c-7669-4d32-0d57-08d929d3fe83
X-MS-TrafficTypeDiagnostic: DM6PR12MB4698:
X-Microsoft-Antispam-PRVS: <DM6PR12MB46980F5D3BA8D12B2C26B63EFF389@DM6PR12MB4698.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NT+WsDH+BSbmgYnkRR0y+Mkzp3IWPy4ayMESb6oBfqFIZ1IfUMM601a8vno1AvBet1/GLESJCGG097BirF10OdJN1Gci/2AD/qX+sxzZ41+ACBPN2IPoPE07bMGh4VP+Lmj1q/Z+UaMpcm9pV/ZlfpxrJoccXCZ6LCJz/K1nHVNYjmNnj4flHX66YxZn53HX3SyPqLMg8cs3fs5qU+givQOHQ6j11dTWtv1DSKNfGVogrN5XWFdl7dyw8FFT0G6vDbnJh0q2PDmJU0cYWMHwniPqyvKRRcD9v17F18c24hUH8xzEYWALogOfYO3R6fYQauxXUSGWcxv9uFeT18ssjkXcdU9xoYVFqdxZb8BtJVuDxBiiLEisc+sk2lxngI7YxpLNQA8VB3A947r4E+SHmlppBJTCle6uYZos0i5bV1ZD+MoQ+VlqHtaBaqlajR6hDNTF7vkMGQoeZiAlbK+uKR5lSpGyagzB7eJUnjSb/pUA4uDnzKru3PcWIsOaVg2uuYk2OKqNsW6TyvBNH+UkV0SUjMAFRRz8cIa7ALATgcHPxSGM2vpkuUT27VsAuCT0KnDDmRau6PpVZFFupTdQ73oF8xxSQDt+SWZ4w+05wYIDSN0Xk+KQx9UK2rqAcE0gWzUCz5dbF8K00zZb1hMYvaLhtcvR4Tz/VwPRWYLpvZ/aukTFIfoFQzJEDjrD5omd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(8676002)(316002)(83380400001)(478600001)(54906003)(6916009)(5660300002)(426003)(2616005)(26005)(2906002)(8936002)(82740400003)(336012)(4326008)(1076003)(7696005)(6666004)(356005)(30864003)(81166007)(36756003)(36860700001)(16526019)(70206006)(44832011)(86362001)(186003)(82310400003)(70586007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:47:53.4035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd1ca2c-7669-4d32-0d57-08d929d3fe83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4698
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
Updating PSR interfaces to allow PSR enablement
per eDP panel.
[how]
- Copying PSR command structures to DC
- Changing function interfaces to pass panel instance
- Communicating with DMUB per link instead of assuming
to use a single one
-Iterating through all PSR capable panels when enabling/disabling
all

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 22 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 11 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 21 ++++-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 34 +++++---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h | 14 +--
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 85 ++++++++++++++++++-
 6 files changed, 153 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index dd52ebf56d62..7fcc32941f4d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -90,15 +90,20 @@ void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_m
 	struct dc_link *edp_links[MAX_NUM_EDP];
 	struct dc_link *edp_link = NULL;
 	int edp_num;
+	unsigned int panel_inst;
 
 	get_edp_links(dc, edp_links, &edp_num);
 	if (dc->hwss.exit_optimized_pwr_state)
 		dc->hwss.exit_optimized_pwr_state(dc, dc->current_state);
 
 	if (edp_num) {
-		edp_link = edp_links[0];
-		clk_mgr->psr_allow_active_cache = edp_link->psr_settings.psr_allow_active;
-		dc_link_set_psr_allow_active(edp_link, false, false, false);
+		for (panel_inst = 0; panel_inst < edp_num; panel_inst++) {
+			edp_link = edp_links[panel_inst];
+			if (!edp_link->psr_settings.psr_feature_enabled)
+				continue;
+			clk_mgr->psr_allow_active_cache = edp_link->psr_settings.psr_allow_active;
+			dc_link_set_psr_allow_active(edp_link, false, false, false);
+		}
 	}
 
 }
@@ -108,12 +113,17 @@ void clk_mgr_optimize_pwr_state(const struct dc *dc, struct clk_mgr *clk_mgr)
 	struct dc_link *edp_links[MAX_NUM_EDP];
 	struct dc_link *edp_link = NULL;
 	int edp_num;
+	unsigned int panel_inst;
 
 	get_edp_links(dc, edp_links, &edp_num);
 	if (edp_num) {
-		edp_link = edp_links[0];
-		dc_link_set_psr_allow_active(edp_link,
-				clk_mgr->psr_allow_active_cache, false, false);
+		for (panel_inst = 0; panel_inst < edp_num; panel_inst++) {
+			edp_link = edp_links[panel_inst];
+			if (!edp_link->psr_settings.psr_feature_enabled)
+				continue;
+			dc_link_set_psr_allow_active(edp_link,
+					clk_mgr->psr_allow_active_cache, false, false);
+		}
 	}
 
 	if (dc->hwss.optimize_pwr_state)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 156ba8d3d4dc..a368e7c5245d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3262,10 +3262,13 @@ bool dc_set_psr_allow_active(struct dc *dc, bool enable)
 			continue;
 
 		if (link->psr_settings.psr_feature_enabled) {
-			if (enable && !link->psr_settings.psr_allow_active)
-				return dc_link_set_psr_allow_active(link, true, false, false);
-			else if (!enable && link->psr_settings.psr_allow_active)
-				return dc_link_set_psr_allow_active(link, false, true, false);
+			if (enable && !link->psr_settings.psr_allow_active) {
+				if (!dc_link_set_psr_allow_active(link, true, false, false))
+					return false;
+			} else if (!enable && link->psr_settings.psr_allow_active) {
+				if (!dc_link_set_psr_allow_active(link, false, true, false))
+					return false;
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index c07b45c021d5..ce637bf0cb81 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2701,16 +2701,20 @@ bool dc_link_set_psr_allow_active(struct dc_link *link, bool allow_active,
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dmub_psr *psr = dc->res_pool->psr;
+	unsigned int panel_inst;
 
 	if (psr == NULL && force_static)
 		return false;
 
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
 	link->psr_settings.psr_allow_active = allow_active;
 
 	if (psr != NULL && link->psr_settings.psr_feature_enabled) {
 		if (force_static && psr->funcs->psr_force_static)
-			psr->funcs->psr_force_static(psr);
-		psr->funcs->psr_enable(psr, allow_active, wait);
+			psr->funcs->psr_force_static(psr, panel_inst);
+		psr->funcs->psr_enable(psr, allow_active, wait, panel_inst);
 	} else if ((dmcu != NULL && dmcu->funcs->is_dmcu_initialized(dmcu)) && link->psr_settings.psr_feature_enabled)
 		dmcu->funcs->set_psr_enable(dmcu, allow_active, wait);
 	else
@@ -2724,9 +2728,13 @@ bool dc_link_get_psr_state(const struct dc_link *link, enum dc_psr_state *state)
 	struct dc  *dc = link->ctx->dc;
 	struct dmcu *dmcu = dc->res_pool->dmcu;
 	struct dmub_psr *psr = dc->res_pool->psr;
+	unsigned int panel_inst;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
 
 	if (psr != NULL && link->psr_settings.psr_feature_enabled)
-		psr->funcs->psr_get_state(psr, state);
+		psr->funcs->psr_get_state(psr, state, panel_inst);
 	else if (dmcu != NULL && link->psr_settings.psr_feature_enabled)
 		dmcu->funcs->get_psr_state(dmcu, state);
 
@@ -2776,6 +2784,7 @@ bool dc_link_setup_psr(struct dc_link *link,
 	struct dmcu *dmcu;
 	struct dmub_psr *psr;
 	int i;
+	unsigned int panel_inst;
 	/* updateSinkPsrDpcdConfig*/
 	union dpcd_psr_configuration psr_configuration;
 
@@ -2791,6 +2800,9 @@ bool dc_link_setup_psr(struct dc_link *link,
 	if (!dmcu && !psr)
 		return false;
 
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return false;
+
 
 	memset(&psr_configuration, 0, sizeof(psr_configuration));
 
@@ -2897,7 +2909,8 @@ bool dc_link_setup_psr(struct dc_link *link,
 	psr_context->frame_delay = 0;
 
 	if (psr)
-		link->psr_settings.psr_feature_enabled = psr->funcs->psr_copy_settings(psr, link, psr_context);
+		link->psr_settings.psr_feature_enabled = psr->funcs->psr_copy_settings(psr,
+			link, psr_context, panel_inst);
 	else
 		link->psr_settings.psr_feature_enabled = dmcu->funcs->setup_psr(dmcu, link, psr_context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 5e99553fcdd4..c41db6d4e794 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -77,7 +77,7 @@ static enum dc_psr_state convert_psr_state(uint32_t raw_state)
 /*
  * Get PSR state from firmware.
  */
-static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state)
+static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state, uint8_t panel_inst)
 {
 	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
 	uint32_t raw_state = 0;
@@ -86,7 +86,7 @@ static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state)
 
 	do {
 		// Send gpint command and wait for ack
-		status = dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
+		status = dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, panel_inst, 30);
 
 		if (status == DMUB_STATUS_OK) {
 			// GPINT was executed, get response
@@ -105,7 +105,7 @@ static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state)
 /*
  * Set PSR version.
  */
-static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *stream)
+static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *stream, uint8_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
@@ -125,6 +125,8 @@ static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 		cmd.psr_set_version.psr_set_version_data.version = PSR_VERSION_UNSUPPORTED;
 		break;
 	}
+	cmd.psr_set_version.psr_set_version_data.cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
+	cmd.psr_set_version.psr_set_version_data.panel_inst = panel_inst;
 	cmd.psr_set_version.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_version_data);
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
@@ -137,7 +139,7 @@ static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 /*
  * Enable/Disable PSR.
  */
-static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait)
+static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait, uint8_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
@@ -147,6 +149,9 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait)
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.psr_enable.header.type = DMUB_CMD__PSR;
 
+	cmd.psr_enable.data.cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
+	cmd.psr_enable.data.panel_inst = panel_inst;
+
 	if (enable)
 		cmd.psr_enable.header.sub_type = DMUB_CMD__PSR_ENABLE;
 	else
@@ -164,7 +169,7 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait)
 	 */
 	if (wait) {
 		for (retry_count = 0; retry_count <= 1000; retry_count++) {
-			dmub_psr_get_state(dmub, &state);
+			dmub_psr_get_state(dmub, &state, panel_inst);
 
 			if (enable) {
 				if (state != PSR_STATE0)
@@ -186,13 +191,13 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait)
 /*
  * Set PSR level.
  */
-static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level)
+static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level, uint8_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
 	enum dc_psr_state state = PSR_STATE0;
 	struct dc_context *dc = dmub->ctx;
 
-	dmub_psr_get_state(dmub, &state);
+	dmub_psr_get_state(dmub, &state, panel_inst);
 
 	if (state == PSR_STATE0)
 		return;
@@ -202,7 +207,8 @@ static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level)
 	cmd.psr_set_level.header.sub_type = DMUB_CMD__PSR_SET_LEVEL;
 	cmd.psr_set_level.header.payload_bytes = sizeof(struct dmub_cmd_psr_set_level_data);
 	cmd.psr_set_level.psr_set_level_data.psr_level = psr_level;
-
+	cmd.psr_set_level.psr_set_level_data.cmd_version = PSR_VERSION_1;
+	cmd.psr_set_level.psr_set_level_data.panel_inst = panel_inst;
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
@@ -213,7 +219,8 @@ static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level)
  */
 static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		struct dc_link *link,
-		struct psr_context *psr_context)
+		struct psr_context *psr_context,
+		uint8_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
@@ -237,7 +244,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		return false;
 
 	// First, set the psr version
-	if (!dmub_psr_set_version(dmub, pipe_ctx->stream))
+	if (!dmub_psr_set_version(dmub, pipe_ctx->stream, panel_inst))
 		return false;
 
 	// Program DP DPHY fast training registers
@@ -286,6 +293,8 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->debug.bitfields.use_hw_lock_mgr		= 1;
 	copy_settings_data->fec_enable_status = (link->fec_state == dc_link_fec_enabled);
 	copy_settings_data->fec_enable_delay_in100us = link->dc->debug.fec_enable_delay_in100us;
+	copy_settings_data->cmd_version =  PSR_VERSION_1;
+	copy_settings_data->panel_inst = panel_inst;
 
 	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
 	dc_dmub_srv_cmd_execute(dc->dmub_srv);
@@ -297,12 +306,15 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 /*
  * Send command to PSR to force static ENTER and ignore all state changes until exit
  */
-static void dmub_psr_force_static(struct dmub_psr *dmub)
+static void dmub_psr_force_static(struct dmub_psr *dmub, uint8_t panel_inst)
 {
 	union dmub_rb_cmd cmd;
 	struct dc_context *dc = dmub->ctx;
 
 	memset(&cmd, 0, sizeof(cmd));
+
+	cmd.psr_force_static.psr_force_static_data.panel_inst = panel_inst;
+	cmd.psr_force_static.psr_force_static_data.cmd_version = DMUB_CMD_PSR_CONTROL_VERSION_1;
 	cmd.psr_force_static.header.type = DMUB_CMD__PSR;
 	cmd.psr_force_static.header.sub_type = DMUB_CMD__PSR_FORCE_STATIC;
 	cmd.psr_enable.header.payload_bytes = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index fe747c20a0d2..bf73c7edbd9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -35,11 +35,15 @@ struct dmub_psr {
 };
 
 struct dmub_psr_funcs {
-	bool (*psr_copy_settings)(struct dmub_psr *dmub, struct dc_link *link, struct psr_context *psr_context);
-	void (*psr_enable)(struct dmub_psr *dmub, bool enable, bool wait);
-	void (*psr_get_state)(struct dmub_psr *dmub, enum dc_psr_state *dc_psr_state);
-	void (*psr_set_level)(struct dmub_psr *dmub, uint16_t psr_level);
-	void (*psr_force_static)(struct dmub_psr *dmub);
+	bool (*psr_copy_settings)(struct dmub_psr *dmub, struct dc_link *link,
+	struct psr_context *psr_context, uint8_t panel_inst);
+	void (*psr_enable)(struct dmub_psr *dmub, bool enable, bool wait,
+	uint8_t panel_inst);
+	void (*psr_get_state)(struct dmub_psr *dmub, enum dc_psr_state *dc_psr_state,
+	uint8_t panel_inst);
+	void (*psr_set_level)(struct dmub_psr *dmub, uint16_t psr_level,
+	uint8_t panel_inst);
+	void (*psr_force_static)(struct dmub_psr *dmub, uint8_t panel_inst);
 	void (*psr_get_residency)(struct dmub_psr *dmub, uint32_t *residency);
 };
 
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 0b351da48563..ac8c366c6e8c 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -122,6 +122,17 @@
 /* Trace buffer offset for entry */
 #define TRACE_BUFFER_ENTRY_OFFSET  16
 
+/**
+ *
+ * PSR control version legacy
+ */
+#define DMUB_CMD_PSR_CONTROL_VERSION_UNKNOWN 0x0
+/**
+ * PSR control version with multi edp support
+ */
+#define DMUB_CMD_PSR_CONTROL_VERSION_1 0x1
+
+
 /**
  * ABM control version legacy
  */
@@ -1315,9 +1326,15 @@ struct dmub_cmd_psr_copy_settings_data {
 	 */
 	uint8_t fec_enable_delay_in100us;
 	/**
-	 * Explicit padding to 4 byte boundary.
+	 * PSR control version.
+	 */
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
 	 */
-	uint8_t pad3[2];
+	uint8_t panel_inst;
 };
 
 /**
@@ -1343,9 +1360,15 @@ struct dmub_cmd_psr_set_level_data {
 	 */
 	uint16_t psr_level;
 	/**
-	 * Explicit padding to 4 byte boundary.
+	 * PSR control version.
 	 */
-	uint8_t pad[2];
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
 };
 
 /**
@@ -1362,6 +1385,23 @@ struct dmub_rb_cmd_psr_set_level {
 	struct dmub_cmd_psr_set_level_data psr_set_level_data;
 };
 
+struct dmub_rb_cmd_psr_enable_data {
+	/**
+	 * PSR control version.
+	 */
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+};
+
 /**
  * Definition of a DMUB_CMD__PSR_ENABLE command.
  * PSR enable/disable is controlled using the sub_type.
@@ -1371,6 +1411,8 @@ struct dmub_rb_cmd_psr_enable {
 	 * Command header.
 	 */
 	struct dmub_cmd_header header;
+
+	struct dmub_rb_cmd_psr_enable_data data;
 };
 
 /**
@@ -1381,6 +1423,20 @@ struct dmub_cmd_psr_set_version_data {
 	 * PSR version that FW should implement.
 	 */
 	enum psr_version version;
+	/**
+	 * PSR control version.
+	 */
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
 };
 
 /**
@@ -1397,6 +1453,23 @@ struct dmub_rb_cmd_psr_set_version {
 	struct dmub_cmd_psr_set_version_data psr_set_version_data;
 };
 
+struct dmub_cmd_psr_force_static_data {
+	/**
+	 * PSR control version.
+	 */
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad[2];
+};
+
 /**
  * Definition of a DMUB_CMD__PSR_FORCE_STATIC command.
  */
@@ -1405,6 +1478,10 @@ struct dmub_rb_cmd_psr_force_static {
 	 * Command header.
 	 */
 	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__PSR_FORCE_STATIC command.
+	 */
+	struct dmub_cmd_psr_force_static_data psr_force_static_data;
 };
 
 /**
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
