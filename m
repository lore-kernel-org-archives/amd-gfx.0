Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A139C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 19:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F6742067B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 19:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n4Ngc+li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6742067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9D1289829;
	Mon, 15 Jun 2020 19:01:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 602E889829
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 19:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yk+b0WX9q4JMHhyp/WWU+iJWLYWxv+gSjezDKVSr02S4D2JUsHVNGF7HMtXmM8szn/fVTPrzaikLztNHL7gugemDTZEDdRuSs1zmhsdQ8epG9827wm7peDeX+gmebS+WMGU2XuKspyEcOvvckruAJ0YyRy8mJd3YKThtILIBVdDemgoX6aAvxtg+BhWs5iz17ta3V2pghE4XgkpsWkIQ1lkkBGGxs/HazSAVI5l9sMwJRfAtvPT1kyLlW/m/kDRqEeGo4YPrdfOA3DEvtzuikfsVebuz+uFO6qucQ0+RhNyvG7oKf+21jfQFF9fly9BnTvpnQBruwh+HJraQMqZz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1YTPqeDlylMD/1kBeiekRrQE3F1KC6ZNccP9+r22RM=;
 b=akOS3FnqHuu5ZoBzYHD1trZVlrhKQgCELu01N0N7GizuHy8pQ9dHydsvou0GCgLgGKvNWSE+wCRyh2G/mZAGW33ixsnu2PYT1xYeohCW6uQIaI15AxVREP+W/nZuQi4jnnCkKD+768YN/zvEisVnMkm1ECajTwR5tFR/UxwtRrGOObVJma15SUsZBToTi9pvl4qplzRY6QtLYmDiSGCXGN6jC+PUrd9r8GA3sGtbAvSGe5n52i1mroRUX+V7ChDLpU8KoNtcCnzTc/2PVqnMysQXV+3VEy3l7Lf9MH1bpW3jJEvghfibLGg8NH1sApgR2XkLmlw2Wv+OeUCfijJJLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1YTPqeDlylMD/1kBeiekRrQE3F1KC6ZNccP9+r22RM=;
 b=n4Ngc+li+PTuBAqYIYjchxXXLajq5HXCauXJD1iKVVOn7z+IIgKoNDSJE8XTwk2Q3e6HrMgEjgnEBfS7OQZGSIV68EPw8OmdGlwoBWm751erUtGffUz7fbPORddNowm7nVaVY7CfZn9AYdyiDuELe4MN0jlMmjkDxZspJ28HjjE=
Received: from BN6PR11CA0067.namprd11.prod.outlook.com (2603:10b6:404:f7::29)
 by CY4PR1201MB0006.namprd12.prod.outlook.com (2603:10b6:903:d3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 19:01:45 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::ee) by BN6PR11CA0067.outlook.office365.com
 (2603:10b6:404:f7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend
 Transport; Mon, 15 Jun 2020 19:01:45 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 19:01:45 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 15 Jun
 2020 14:01:45 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 15 Jun
 2020 14:01:45 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 15 Jun 2020 14:01:44 -0500
From: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: Update DCN3 bounding box
Date: Mon, 15 Jun 2020 15:01:34 -0400
Message-ID: <20200615190135.16562-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966005)(6916009)(36756003)(478600001)(81166007)(336012)(82310400002)(356005)(6666004)(8676002)(83380400001)(4326008)(316002)(8936002)(86362001)(2616005)(426003)(70586007)(1076003)(82740400003)(70206006)(47076004)(15650500001)(26005)(5660300002)(2906002)(7696005)(186003)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd896f5f-739d-4a0a-72fd-08d8115e8c91
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0006:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB00069CFA8FBBF3BC976173F5E59C0@CY4PR1201MB0006.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xh8IwD/CvLL/AZP2ZTlW2KSxg90iPuJGu5UmKv1YGr9owwZTACWoAn9jgVjB8nH0dWYgmdskns4Y1Zc8yBOVYU2WOaNN14dWykZ1WGdMtm7gcvaIUanvyoueqWmLigyiMN+5bwQfTi2Tc+dDz/VejsV8g9oK+B1wjx8dFdg/ZLbb1HRD4anxey40vTkFCdDtT4Rw7o+/V6e7CofsjUGcgWZy7Cg5LCMo5m/vD7Fr5+6dIUPADlj3yLZL+lIljtm11FjGd+83AkTND+tXvMbKJ0VRokqCGUQXbn8Ryg8WXHi6YjSLhhyKvDJX48qIiDRdL08+0sGUIaZ8snuS3ianm49qUiks0YPoLU4ezjgoKqAURpWQ2Idw8HKHILdW3hf/tpafFKNspZQ7ETlVSaJU1Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 19:01:45.5435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd896f5f-739d-4a0a-72fd-08d8115e8c91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0006
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
Cc: Alexander.Deucher@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>,
 harry.wentland@amd.com, Nicholas.Kazlauskas@amd.com,
 Alvin Lee <alvin.lee2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
We want to update the bounding box to have more granular control of the
DCFCLK.

[How]
Setup DCFCLK to use STA values and also optimal values based on
UCLK.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 114 ++++++++++++++++--
 1 file changed, 102 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 654fdbbff86b..821bde9a376e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2237,9 +2237,41 @@ bool dcn30_validate_bandwidth(struct dc *dc, struct dc_state *context,
 	return out;
 }
 
+static void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
+                                                       unsigned int *optimal_dcfclk,
+                                                       unsigned int *optimal_fclk)
+{
+       double bw_from_dram, bw_from_dram1, bw_from_dram2;
+
+       bw_from_dram1 = uclk_mts * dcn3_0_soc.num_chans *
+                       dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.max_avg_dram_bw_use_normal_percent / 100);
+       bw_from_dram2 = uclk_mts * dcn3_0_soc.num_chans *
+                       dcn3_0_soc.dram_channel_width_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100);
+
+       bw_from_dram = (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;
+
+       if (optimal_fclk)
+               *optimal_fclk = bw_from_dram /
+               (dcn3_0_soc.fabric_datapath_to_dcn_data_return_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100));
+
+       if (optimal_dcfclk)
+               *optimal_dcfclk =  bw_from_dram /
+               (dcn3_0_soc.return_bus_width_bytes * (dcn3_0_soc.max_avg_sdp_bw_use_normal_percent / 100));
+}
+
 static void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	unsigned int i;
+	unsigned int i, j;
+	unsigned int num_states = 0;
+
+	unsigned int dcfclk_mhz[DC__VOLTAGE_STATES] = {0};
+	unsigned int dram_speed_mts[DC__VOLTAGE_STATES] = {0};
+	unsigned int optimal_uclk_for_dcfclk_sta_targets[DC__VOLTAGE_STATES] = {0};
+	unsigned int optimal_dcfclk_for_uclk[DC__VOLTAGE_STATES] = {0};
+
+	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {694, 875, 1000, 1200};
+	unsigned int num_dcfclk_sta_targets = 4;
+	unsigned int num_uclk_states;
 
 	if (dc->ctx->dc_bios->vram_info.num_chans)
 		dcn3_0_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
@@ -2250,13 +2282,78 @@ static void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 	dcn3_0_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
 
-	/* UCLK first, it determines number of states */
 	if (bw_params->clk_table.entries[0].memclk_mhz) {
-		dcn3_0_soc.num_states = bw_params->clk_table.num_entries;
+
+		if (bw_params->clk_table.entries[1].dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+			// If max DCFCLK is greater than the max DCFCLK STA target, insert into the DCFCLK STA target array
+			dcfclk_sta_targets[num_dcfclk_sta_targets] = bw_params->clk_table.entries[1].dcfclk_mhz;
+			num_dcfclk_sta_targets++;
+		} else if (bw_params->clk_table.entries[1].dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+			// If max DCFCLK is less than the max DCFCLK STA target, cap values and remove duplicates
+			for (i = 0; i < num_dcfclk_sta_targets; i++) {
+				if (dcfclk_sta_targets[i] > bw_params->clk_table.entries[1].dcfclk_mhz) {
+					dcfclk_sta_targets[i] = bw_params->clk_table.entries[1].dcfclk_mhz;
+					break;
+				}
+			}
+			// Update size of array since we "removed" duplicates
+			num_dcfclk_sta_targets = i + 1;
+		}
+
+		num_uclk_states = bw_params->clk_table.num_entries;
+
+		// Calculate optimal dcfclk for each uclk
+		for (i = 0; i < num_uclk_states; i++) {
+			get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
+					&optimal_dcfclk_for_uclk[i], NULL);
+			if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz) {
+				optimal_dcfclk_for_uclk[i] = bw_params->clk_table.entries[0].dcfclk_mhz;
+			}
+		}
+
+		// Calculate optimal uclk for each dcfclk sta target
+		for (i = 0; i < num_dcfclk_sta_targets; i++) {
+			for (j = 0; j < num_uclk_states; j++) {
+				if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
+					optimal_uclk_for_dcfclk_sta_targets[i] =
+							bw_params->clk_table.entries[j].memclk_mhz * 16;
+					break;
+				}
+			}
+		}
+
+		i = 0;
+		j = 0;
+		// create the final dcfclk and uclk table
+		while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
+			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
+				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
+				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
+			} else {
+				if (j < num_uclk_states && optimal_dcfclk_for_uclk[j] <= bw_params->clk_table.entries[1].dcfclk_mhz) {
+					dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
+					dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
+				} else {
+					j = num_uclk_states;
+				}
+			}
+		}
+
+		while (i < num_dcfclk_sta_targets && num_states < DC__VOLTAGE_STATES) {
+			dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
+			dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
+		}
+
+		while (j < num_uclk_states && num_states < DC__VOLTAGE_STATES &&
+				optimal_dcfclk_for_uclk[j] <= bw_params->clk_table.entries[1].dcfclk_mhz) {
+			dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
+			dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
+		}
 
 		for (i = 0; i < dcn3_0_soc.num_states; i++) {
-			dcn3_0_soc.clock_limits[i].state = i;
-			dcn3_0_soc.clock_limits[i].dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
+			dcn3_0_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
+			dcn3_0_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
+			dcn3_0_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
 		}
 	}
 
@@ -2265,12 +2362,6 @@ static void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 		/* Some clocks can come from bw_params, if so fill from bw_params[1], otherwise fill from dcn3_0_soc[1] */
 		/* Temporarily ignore bw_params values */
 
-		/* DCFCLK */
-		/*if (bw_params->clk_table.entries[0].dcfclk_mhz)
-			dcn3_0_soc.clock_limits[i].dcfclk_mhz = bw_params->clk_table.entries[1].dcfclk_mhz;
-		else*/
-			dcn3_0_soc.clock_limits[i].dcfclk_mhz = dcn3_0_soc.clock_limits[1].dcfclk_mhz;
-
 		/* DTBCLK */
 		/*if (bw_params->clk_table.entries[0].dtbclk_mhz)
 			dcn3_0_soc.clock_limits[i].dtbclk_mhz = bw_params->clk_table.entries[1].dtbclk_mhz;
@@ -2297,7 +2388,6 @@ static void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 
 		/* These clocks cannot come from bw_params, always fill from dcn3_0_soc[1] */
 		/* FCLK, PHYCLK_D18, SOCCLK, DSCCLK */
-		dcn3_0_soc.clock_limits[i].fabricclk_mhz = dcn3_0_soc.clock_limits[1].fabricclk_mhz;
 		dcn3_0_soc.clock_limits[i].phyclk_d18_mhz = dcn3_0_soc.clock_limits[1].phyclk_d18_mhz;
 		dcn3_0_soc.clock_limits[i].socclk_mhz = dcn3_0_soc.clock_limits[1].socclk_mhz;
 		dcn3_0_soc.clock_limits[i].dscclk_mhz = dcn3_0_soc.clock_limits[1].dscclk_mhz;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
