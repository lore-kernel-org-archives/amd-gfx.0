Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E0AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE9AD60BD3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 18:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE9AD60BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67D046E34B;
	Fri, 15 Oct 2021 18:39:13 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A656E34B
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 18:39:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LykLSbxzjUiLmMtAYEq4sBICVnDHd3Z55VqWcVakD+XFeJprqWEReN6pn3NNCs56Klft6w7NFGSKYinEhWJW9BmDdXwg7GwRdNB/GUM0au5eLrzGZ0tggXEF/61oQP3HPiRz3bhFcL627+zkibkCJYthxINpsimScCPjj1NwGyeymdkgwcyBVpSpPGa70A5yyroiSRZ5EDMq9ymSN9iVDnheNMVJJqp/kw3mrZuVpBQ0ckER6Iwal6N6Gng3iDRRbMGPYi293gRhpg9Bu0DL0sfGYpouofwejl62KscKznhpOIp2ZdfhPGBnLYPu6/5tZqUS8T5lEj4font+XI8T/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/R7CyaJFNN/IDEQIQML1PRrUODjVbuoSmedtEPmCeE=;
 b=On5A6q01jFAY9FvNqc1OgeoUpKpHG3GIhYwx99iUeqDRga7FXlYzTSqG7qv4oBPm3AueJ0dg3/itqp0wLfk2eBKWK0FeUBHu0CUj5DX2smYYnerS0Mlhe6D7ur6ZQaXPKpywVlazY/3NVBf1KfkellhpI7q1BenY09JCmfBV4gTJ5xYwwQ2iXrgHbPHAeSqCzuyWzl6VVeZMzur5axAM/xHeQ+X2LtbLAwCjAtBBt2Aa+clVLM2KKgcw14e1XunlGHugRHdqzQt/SlZdItYfnFzl/kFJ8Pktq1IcbGiys0VEv1ad8YMkfOloENA7VUNGht5WLD9hcvRqaZnRf7ChPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/R7CyaJFNN/IDEQIQML1PRrUODjVbuoSmedtEPmCeE=;
 b=xqpYALH/mmi5kNQvmlRPghq5uoNZsOqOcaVPWSOBki5Mi+v/gnZmop3/9oVQkbi8poChVvGFu1qNxo11gpFM5myD7aKWoIC+/IoYihNGRlB8WWlW5WeDCfa5oymYAHQKzphU0qJWN7OpnseGU59Prh66MKAnboF7VOLgM5f+gaQ=
Received: from MWHPR04CA0064.namprd04.prod.outlook.com (2603:10b6:300:6c::26)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 18:39:10 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::35) by MWHPR04CA0064.outlook.office365.com
 (2603:10b6:300:6c::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Fri, 15 Oct 2021 18:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 18:39:09 +0000
Received: from ubuntu.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 15 Oct
 2021 13:39:07 -0500
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>, Jake Wang <haonan.wang2@amd.com>, Eric Yang
 <eric.yang2@amd.com>
Subject: [PATCH 01/27] drm/amd/display: Disable dpp root clock when not being
 used
Date: Fri, 15 Oct 2021 14:38:19 -0400
Message-ID: <20211015183845.220831-2-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211015183845.220831-1-agustin.gutierrez@amd.com>
References: <20211015183845.220831-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec7de468-9d70-40e9-07b4-08d9900b137b
X-MS-TrafficTypeDiagnostic: MN2PR12MB4423:
X-Microsoft-Antispam-PRVS: <MN2PR12MB442313E8F9B4476AFAD8A68DF5B99@MN2PR12MB4423.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdW7es3JmE7LTwc9C8lykeuNg9EEPWZCI/yohCjSP9G69TC7fBH0PpF4DcvDzpQ28UAHodwytVfBCobcCIReSB0APw/S9NMQaISifRdXq6ulIrKDeiKcCtorklrSmRweS1Acsbh4+fFirMlfZPcug83966AcvqotiK757161dYhjxHs4LszepK9gAyYetTHD5W9s8Jc9mqmBiq1yk5mYR4rmkhtUZPB5UAgOiW0m95PQ8uDJDj3YpWiKeB0zQTZ41dGTdj0YxzR5uM4l2mJDepsUAjCrztByKlnoCGV2Vjra6VpujAeO9YRaO2pKYwUOZS29xXc4iessctXu1zlfroeQ4vzKT3I60QxbXY0Sa1pkipNKcvNctu7HNKmpY2Zt97Be8OXYmFo5BQ/M36R6FbbPZBwRJsWyOaRCSy4emcxp9Yg6EMygmOBKNeb0tXKmUTrpH3dSjkxfubGfruDYyyiFS0k7yJSr82RtCox0lQ2p9YMCj8RA4Mxwd8ZOOANQax6ipRLOKUfnYGZWvX7Lz8a3rsJTYxQ+HKcZNAOmzQSSbzme6eS36NUTlFDoHQvz/p/v5drWJjUGgTGZLzqrkgba4RmcqJfj4nyQi3hEPwt0cEwwOqrv/AWcufOK0zcYX2xps2HZmtdGRspQHkjs+Zbq7+rBClxwEexBPfm3a4GmHTOaLsRIDf/Xa3IafClx2q2JDpaYlGyMOuvLgwD+IeSi8sjPzmQa3/c6MqIhFEY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(70586007)(8676002)(4326008)(2906002)(86362001)(6916009)(1076003)(6666004)(36756003)(54906003)(70206006)(316002)(82310400003)(508600001)(356005)(26005)(36860700001)(16526019)(44832011)(186003)(47076005)(5660300002)(83380400001)(426003)(8936002)(2616005)(81166007)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 18:39:09.4056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7de468-9d70-40e9-07b4-08d9900b137b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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

From: Jake Wang <haonan.wang2@amd.com>

[Why & How]
Disable root clock for dpp when not being used.

Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Agustin Gutierrez Sanchez <agustin.gutierrez@amd.com>
Signed-off-by: Jake Wang <haonan.wang2@amd.com>
---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  5 ++-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c | 41 ++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index d7bf9283dc90..3fae1f1f028d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -219,14 +219,17 @@ static void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 		update_dispclk = true;
 	}
 
-	/* TODO: add back DTO programming when DPPCLK restore is fixed in FSDL*/
 	if (dpp_clock_lowered) {
 		// increase per DPP DTO before lowering global dppclk
+		dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 		dcn31_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 	} else {
 		// increase global DPPCLK before lowering per DPP DTO
 		if (update_dppclk || update_dispclk)
 			dcn31_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
+		// always update dtos unless clock is lowered and not safe to lower
+		if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
+			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 	}
 
 	// notify DMCUB of latest clocks
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
index 9896adf67425..582c500ecb49 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c
@@ -42,6 +42,45 @@
 #define DC_LOGGER \
 	dccg->ctx->logger
 
+static void dccg31_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	if (dccg->ref_dppclk && req_dppclk) {
+		int ref_dppclk = dccg->ref_dppclk;
+		int modulo, phase;
+
+		// phase / modulo = dpp pipe clk / dpp global clk
+		modulo = 0xff;   // use FF at the end
+		phase = ((modulo * req_dppclk) + ref_dppclk - 1) / ref_dppclk;
+
+		if (phase > 0xff) {
+			ASSERT(false);
+			phase = 0xff;
+		}
+
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+				DPPCLK0_DTO_PHASE, phase,
+				DPPCLK0_DTO_MODULO, modulo);
+		REG_UPDATE(DPPCLK_DTO_CTRL,
+				DPPCLK_DTO_ENABLE[dpp_inst], 1);
+	} else {
+		//DTO must be enabled to generate a 0Hz clock output
+		if (dccg->ctx->dc->debug.root_clock_optimization.bits.dpp) {
+			REG_UPDATE(DPPCLK_DTO_CTRL,
+					DPPCLK_DTO_ENABLE[dpp_inst], 1);
+			REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+					DPPCLK0_DTO_PHASE, 0,
+					DPPCLK0_DTO_MODULO, 1);
+		} else {
+			REG_UPDATE(DPPCLK_DTO_CTRL,
+					DPPCLK_DTO_ENABLE[dpp_inst], 0);
+		}
+	}
+	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
+}
+
+
 void dccg31_set_dpstreamclk(
 		struct dccg *dccg,
 		enum hdmistreamclk_source src,
@@ -401,7 +440,7 @@ void dccg31_init(struct dccg *dccg)
 }
 
 static const struct dccg_funcs dccg31_funcs = {
-	.update_dpp_dto = dccg2_update_dpp_dto,
+	.update_dpp_dto = dccg31_update_dpp_dto,
 	.get_dccg_ref_freq = dccg31_get_dccg_ref_freq,
 	.dccg_init = dccg31_init,
 	.set_dpstreamclk = dccg31_set_dpstreamclk,
-- 
2.25.1

