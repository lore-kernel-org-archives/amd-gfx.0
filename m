Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81CEC4167B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Dec 2023 19:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499B510E642;
	Wed,  6 Dec 2023 19:52:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481BA10E553
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Dec 2023 19:52:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+ghOl9TMnsaiFIBKxWbtSuShZc4RlDmtqrLwt1cD4yb8kyfigUspc592cE9gJVGJaF3kjZ5wc5L7F57TwOrYUsaQ6BFsUnZTNZrISD2XF4N9qNUPf0h3kjq7SIc4v6hJxccxCoyva2yG6U20UnQNHf1GStaBVWWJdl6ISsUApumwTd4ciL4Dl/D0Bvv6ID+dYkhDCgHxwgnq3YsY75KKxZ38rWP/65p3THuGZcD4vZCPpLSGADCoM6NS6ntYc5SFHSB5cNHcUjsOCAxHy5JEOYlO6cTMSZkairNyP2rBCP94pp6HgQPDl3E23V6zJlZrBc/FKDjn79Okl/oFMuLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CZKasInGzrIudVamK1EOHOybVVfq6VNSZpyYeARvEI=;
 b=UMfcj0p0DbRAuLlpj06pi5W/DMN9iXecKr1KfxHsyIyBgFpuFRLX4DimDUoyB5Xzd1egBG5O5hrxyc2nsun/N59a3sLag8i6TH4Hlmgy6tXT9/DkNMckgo+QDWE8xJPW0RosPZrzH9ikHHfjfUjcM2OnhGqz6bznGo1OggA6asFwB/vmwYDCpl56EufRUxODTyjzbR5NstY9ZGfO1IdFT4dibNHotFYnPHug2/4oIYpZmKA9yQolrnyNs21LHMv6PzFxjaiZX+7sRfHOYmgv/+IPGzCIKyHNlEv/Yje4sA7LxrkzQBwRlzA840F/T67t/NC/f4IeO8hg6IQHeYcFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CZKasInGzrIudVamK1EOHOybVVfq6VNSZpyYeARvEI=;
 b=3oAuoHD+L8cYhQpEx3VNk2zeVu1eGJ7HyhyfCSGntq87kBsna2+WV7DeXNGMChNOWvDDSyI3CENB1HXWC3ERKCt24zGsKnfHThL7Ju9hH1DoBbdVV6B9YH/gHwRvy0tG0mti7gwNPHfOElLN1bCDA/5ZSkk4WCcU885PuUdTlw0=
Received: from CH0PR03CA0071.namprd03.prod.outlook.com (2603:10b6:610:cc::16)
 by SA0PR12MB7478.namprd12.prod.outlook.com (2603:10b6:806:24b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 19:52:46 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::57) by CH0PR03CA0071.outlook.office365.com
 (2603:10b6:610:cc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 19:52:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 19:52:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 13:52:45 -0600
Received: from debaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 13:52:45 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amd/display: fix HW block PG sequence
Date: Wed, 6 Dec 2023 14:52:33 -0500
Message-ID: <20231206195234.182989-13-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231206195234.182989-1-aurabindo.pillai@amd.com>
References: <20231206195234.182989-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|SA0PR12MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7b8bec-d9cf-464b-bb9e-08dbf694eb38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /1e4vLl9mqM8jXmtPE5Qspj3ElqCoVlCXVBswy347kBDA+0rwK0RpeXXJo3Ke4yVuPGgDhHjN23iPewm0e7uRIteI/5JQeffjvX+mC0BPcHJg9Aj6izQgu2UHw6zlzPzuG2c0+154hKMBE47Vw6aaW+9pjs6qNw6pja2ZwliDO+4ARBENAQcaYOQKDwzU/usZUXv4KoTN/SMpImkRzl81nbYewasVpyWJZ1KRL7CdvGCCr/KYZi+Umx9H2dQpdWT2+SGC3bfUVJBDaOhuee6L64xXKYzcm5Wa1PiFYQ0wbxDKt4Vaclrst9yGss7m5ntW2/7as5NNkKHXghMASFTySbMgw+R3QHyEAyG/GuO7SP9uoqijJPU7kwJaNLg5tzLbE1AjlJm3t+dVPf9ngfmRfVuoPR9N5ALTe1pmanlPnd9SQSJhbp2CsAbDZgXDSwr/TWV6o5YfDSi60eY2ERrxetE2J6nyXiIYdf/1f/ztxq9MqqSHwJsEs9gmOeei4H96dqKtZ+dvSbuAYKzOa6UKH8hn/fn/5tMFKfATOUzQiKif0lUpbTEG/uKB5TA2UmA1FApCB4I6ni5buGPcJb3tVRzzEjkmZUYEq/qRoEjyp31QlB5QDNAa838rFzCsEKR/ViXgT1YsKfhvu5/l+9n4cb2lFDUMVDHPbHugr+kMECb/H68bNK479wbULRckY2dOyIsVmBNtHg9rC0lnH7ybjMeUUHzWp/z0DZKZC6hqlcoRSNbog9Cx/+qgb28zIcsqB2Cwh1DrzFs0I2ZSX3JpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(41300700001)(83380400001)(2906002)(336012)(2616005)(5660300002)(86362001)(40480700001)(426003)(1076003)(26005)(30864003)(36860700001)(44832011)(47076005)(40460700003)(356005)(4326008)(7696005)(8936002)(81166007)(8676002)(6666004)(70206006)(6916009)(70586007)(478600001)(316002)(36756003)(54906003)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:52:46.4232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7b8bec-d9cf-464b-bb9e-08dbf694eb38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7478
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

[why]
Power up and power down has reverted programming order.
also make sure disable root clock last.

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |   3 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 134 +++++++++++++-----
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   6 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   6 +-
 4 files changed, 105 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
index 296bf3a38cb9..d594905eb246 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
@@ -118,7 +118,8 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.update_dsc_pg = dcn32_update_dsc_pg,
 	.calc_blocks_to_gate = dcn35_calc_blocks_to_gate,
 	.calc_blocks_to_ungate = dcn35_calc_blocks_to_ungate,
-	.block_power_control = dcn35_block_power_control,
+	.hw_block_power_up = dcn35_hw_block_power_up,
+	.hw_block_power_down = dcn35_hw_block_power_down,
 	.root_clock_control = dcn35_root_clock_control,
 	.set_idle_state = dcn35_set_idle_state,
 	.get_idle_state = dcn35_get_idle_state
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 09498aa92096..9262d3336182 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1123,9 +1123,23 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 		update_state->pg_res_update[PG_HPO] = true;
 
 }
-
-void dcn35_block_power_control(struct dc *dc,
-	struct pg_block_update *update_state, bool power_on)
+/**
+	 * power down sequence
+	 * ONO Region 3, DCPG 25: hpo - SKIPPED
+	 * ONO Region 4, DCPG 0: dchubp0, dpp0
+	 * ONO Region 6, DCPG 1: dchubp1, dpp1
+	 * ONO Region 8, DCPG 2: dchubp2, dpp2
+	 * ONO Region 10, DCPG 3: dchubp3, dpp3
+	 * ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will pwr dwn at IPS2 entry
+	 * ONO Region 5, DCPG 16: dsc0
+	 * ONO Region 7, DCPG 17: dsc1
+	 * ONO Region 9, DCPG 18: dsc2
+	 * ONO Region 11, DCPG 19: dsc3
+	 * ONO Region 2, DCPG 24: mpc opp optc dwb
+	 * ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED. will be pwr dwn after lono timer is armed
+*/
+void dcn35_hw_block_power_down(struct dc *dc,
+	struct pg_block_update *update_state)
 {
 	int i = 0;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
@@ -1134,66 +1148,99 @@ void dcn35_block_power_control(struct dc *dc,
 		return;
 	if (dc->debug.ignore_pg)
 		return;
+
 	if (update_state->pg_res_update[PG_HPO]) {
 		if (pg_cntl->funcs->hpo_pg_control)
-			pg_cntl->funcs->hpo_pg_control(pg_cntl, power_on);
+			pg_cntl->funcs->hpo_pg_control(pg_cntl, false);
 	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
 			update_state->pg_pipe_res_update[PG_DPP][i]) {
 			if (pg_cntl->funcs->hubp_dpp_pg_control)
-				pg_cntl->funcs->hubp_dpp_pg_control(pg_cntl, i, power_on);
+				pg_cntl->funcs->hubp_dpp_pg_control(pg_cntl, i, false);
 		}
-
+	}
+	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++)
 		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
 			if (pg_cntl->funcs->dsc_pg_control)
-				pg_cntl->funcs->dsc_pg_control(pg_cntl, i, power_on);
-		}
-
-		if (update_state->pg_pipe_res_update[PG_MPCC][i]) {
-			if (pg_cntl->funcs->mpcc_pg_control)
-				pg_cntl->funcs->mpcc_pg_control(pg_cntl, i, power_on);
-		}
-
-		if (update_state->pg_pipe_res_update[PG_OPP][i]) {
-			if (pg_cntl->funcs->opp_pg_control)
-				pg_cntl->funcs->opp_pg_control(pg_cntl, i, power_on);
-		}
-
-		if (update_state->pg_pipe_res_update[PG_OPTC][i]) {
-			if (pg_cntl->funcs->optc_pg_control)
-				pg_cntl->funcs->optc_pg_control(pg_cntl, i, power_on);
+				pg_cntl->funcs->dsc_pg_control(pg_cntl, i, false);
 		}
-	}
 
-	if (update_state->pg_res_update[PG_DWB]) {
-		if (pg_cntl->funcs->dwb_pg_control)
-			pg_cntl->funcs->dwb_pg_control(pg_cntl, power_on);
-	}
 
 	/*this will need all the clients to unregister optc interruts let dmubfw handle this*/
 	if (pg_cntl->funcs->plane_otg_pg_control)
-		pg_cntl->funcs->plane_otg_pg_control(pg_cntl, power_on);
+		pg_cntl->funcs->plane_otg_pg_control(pg_cntl, false);
 
-}
+	//domain22, 23, 25 currently always on.
 
-void dcn35_root_clock_control(struct dc *dc,
-	struct pg_block_update *update_state, bool power_on)
+}
+/**
+	 * power up sequence
+	 * ONO Region 0, DCPG 22: dccg dio dcio - SKIPPED
+	 * ONO Region 2, DCPG 24: mpc opp optc dwb
+	 * ONO Region 5, DCPG 16: dsc0
+	 * ONO Region 7, DCPG 17: dsc1
+	 * ONO Region 9, DCPG 18: dsc2
+	 * ONO Region 11, DCPG 19: dsc3
+	 * ONO Region 1, DCPG 23: dchubbub dchvm dchubbubmem - SKIPPED. PMFW will power up at IPS2 exit
+	 * ONO Region 4, DCPG 0: dchubp0, dpp0
+	 * ONO Region 6, DCPG 1: dchubp1, dpp1
+	 * ONO Region 8, DCPG 2: dchubp2, dpp2
+	 * ONO Region 10, DCPG 3: dchubp3, dpp3
+	 * ONO Region 3, DCPG 25: hpo - SKIPPED
+ */
+void dcn35_hw_block_power_up(struct dc *dc,
+	struct pg_block_update *update_state)
 {
 	int i = 0;
 	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
 
 	if (!pg_cntl)
 		return;
+	if (dc->debug.ignore_pg)
+		return;
+	//domain22, 23, 25 currently always on.
+	/*this will need all the clients to unregister optc interruts let dmubfw handle this*/
+	if (pg_cntl->funcs->plane_otg_pg_control)
+		pg_cntl->funcs->plane_otg_pg_control(pg_cntl, true);
+
+	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++)
+		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
+			if (pg_cntl->funcs->dsc_pg_control)
+				pg_cntl->funcs->dsc_pg_control(pg_cntl, i, true);
+		}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
 			update_state->pg_pipe_res_update[PG_DPP][i]) {
-			if (dc->hwseq->funcs.dpp_root_clock_control)
-				dc->hwseq->funcs.dpp_root_clock_control(dc->hwseq, i, power_on);
+			if (pg_cntl->funcs->hubp_dpp_pg_control)
+				pg_cntl->funcs->hubp_dpp_pg_control(pg_cntl, i, true);
 		}
+	}
+	if (update_state->pg_res_update[PG_HPO]) {
+		if (pg_cntl->funcs->hpo_pg_control)
+			pg_cntl->funcs->hpo_pg_control(pg_cntl, true);
+	}
+}
+void dcn35_root_clock_control(struct dc *dc,
+	struct pg_block_update *update_state, bool power_on)
+{
+	int i = 0;
+	struct pg_cntl *pg_cntl = dc->res_pool->pg_cntl;
 
+	if (!pg_cntl)
+		return;
+	/*enable root clock first when power up*/
+	if (power_on)
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
+				update_state->pg_pipe_res_update[PG_DPP][i]) {
+				if (dc->hwseq->funcs.dpp_root_clock_control)
+					dc->hwseq->funcs.dpp_root_clock_control(dc->hwseq, i, power_on);
+			}
+		}
+	for (i = 0; i < dc->res_pool->res_cap->num_dsc; i++) {
 		if (update_state->pg_pipe_res_update[PG_DSC][i]) {
 			if (power_on) {
 				if (dc->res_pool->dccg->funcs->enable_dsc)
@@ -1204,6 +1251,15 @@ void dcn35_root_clock_control(struct dc *dc,
 			}
 		}
 	}
+	/*disable root clock first when power down*/
+	if (!power_on)
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			if (update_state->pg_pipe_res_update[PG_HUBP][i] &&
+				update_state->pg_pipe_res_update[PG_DPP][i]) {
+				if (dc->hwseq->funcs.dpp_root_clock_control)
+					dc->hwseq->funcs.dpp_root_clock_control(dc->hwseq, i, power_on);
+			}
+		}
 }
 
 void dcn35_prepare_bandwidth(
@@ -1217,9 +1273,9 @@ void dcn35_prepare_bandwidth(
 
 		if (dc->hwss.root_clock_control)
 			dc->hwss.root_clock_control(dc, &pg_update_state, true);
-
-		if (dc->hwss.block_power_control)
-			dc->hwss.block_power_control(dc, &pg_update_state, true);
+		/*power up required HW block*/
+		if (dc->hwss.hw_block_power_up)
+			dc->hwss.hw_block_power_up(dc, &pg_update_state);
 	}
 
 	dcn20_prepare_bandwidth(dc, context);
@@ -1235,9 +1291,9 @@ void dcn35_optimize_bandwidth(
 
 	if (dc->hwss.calc_blocks_to_gate) {
 		dc->hwss.calc_blocks_to_gate(dc, context, &pg_update_state);
-
-		if (dc->hwss.block_power_control)
-			dc->hwss.block_power_control(dc, &pg_update_state, false);
+		/*try to power down unused block*/
+		if (dc->hwss.hw_block_power_down)
+			dc->hwss.hw_block_power_down(dc, &pg_update_state);
 
 		if (dc->hwss.root_clock_control)
 			dc->hwss.root_clock_control(dc, &pg_update_state, false);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 0dff10d179b8..3837038dc4a8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -63,8 +63,10 @@ void dcn35_calc_blocks_to_gate(struct dc *dc, struct dc_state *context,
 	struct pg_block_update *update_state);
 void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 	struct pg_block_update *update_state);
-void dcn35_block_power_control(struct dc *dc,
-	struct pg_block_update *update_state, bool power_on);
+void dcn35_hw_block_power_up(struct dc *dc,
+	struct pg_block_update *update_state);
+void dcn35_hw_block_power_down(struct dc *dc,
+	struct pg_block_update *update_state);
 void dcn35_root_clock_control(struct dc *dc,
 	struct pg_block_update *update_state, bool power_on);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 452680fe9aab..45dc6d4e9562 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -414,8 +414,10 @@ struct hw_sequencer_funcs {
 		struct pg_block_update *update_state);
 	void (*calc_blocks_to_ungate)(struct dc *dc, struct dc_state *context,
 		struct pg_block_update *update_state);
-	void (*block_power_control)(struct dc *dc,
-		struct pg_block_update *update_state, bool power_on);
+	void (*hw_block_power_up)(struct dc *dc,
+		struct pg_block_update *update_state);
+	void (*hw_block_power_down)(struct dc *dc,
+		struct pg_block_update *update_state);
 	void (*root_clock_control)(struct dc *dc,
 		struct pg_block_update *update_state, bool power_on);
 	void (*set_idle_state)(const struct dc *dc, bool allow_idle);
-- 
2.39.2

