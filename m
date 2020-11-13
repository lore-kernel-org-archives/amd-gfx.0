Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB191C63697
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7B42224A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f/2Z3Jlo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7B42224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CADFB6E83A;
	Fri, 13 Nov 2020 20:58:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15A6A6E83A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d0GlQYKg47yRsncfVLxBYNNhsBDdm2H+PiIe3KYcpbbGx73L4gmn0vjLXZJqnnadGxEosgVS+Fk/Wbavw0kzCWLfDP0K8Rl3fM+z8ZW0iE/vrtNUWmbHoMvnMCr5l3vCJ0A9afDfJ1HdXLsLEXzqDi21p1Re4G2r4I7D3dJZPCfe3WSWekI9zqKexwHylEKBnQbplzpHy7EULBuh8ZbsV0zMRzM0D9FMOp8/UltWwkrzcCXCSjYXf6jTpIjsTbh1dZv3s9UtJ4GN39M6tW4AUyloW6xwXDUmox8DIhZwGrydMaI+oGmPLcNRgRAivL15dY+Ta2lADU78q8zUQNsRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/4wuOYzG5OFf2bzACKoXp0Z53VlLKjgh4+91oDITq8=;
 b=d5M3y+5LIIUQQKu2s/rZ4DUIKEFcFEpYZ1mN/HzU9sIqLN0tWJTuef+DZ7TmhlRCgF3JiDA4BPMIyvbSpv+XO5QhE2sw987sdKtKZDO74+VzE+UZc1mzHaxzsDO184h3DAS+Q4WR1Or+6moxPoqnBfMNGwSQtbulfypIA+bwpcpGdJquLaKZ0ODEDAzIYFoKf7xpTHp+6ioi/QlptNg4Kx8a4R4olRSaKnuu+KzYtRUJ5mA5C0o9G2mhfvowjhpwFmyBYc8NECX8ufcFf52kqpG9IUFjmaGNAQufryFvBU3VQ49zlFuhsr1u/aHZNCUrhXZUFLIVDMiqJGJD8cWUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/4wuOYzG5OFf2bzACKoXp0Z53VlLKjgh4+91oDITq8=;
 b=f/2Z3JloiaRYzbc2jj9t6hEpGiHnrilj7QQ2wC3rftZMOXVFO2s7scJ9VDcFnLlmk5oq2rb8ojfMMuf7k+EdOfANRQFM/lDVRtawdkZ1YV1UqW0ieFVI4u/8CoP7MDTYhS3Pveo3jhK3eOrntqHQjyzUG1pk7Ggb3nwpnSKqvdY=
Received: from MWHPR19CA0078.namprd19.prod.outlook.com (2603:10b6:320:1f::16)
 by BN6PR12MB1332.namprd12.prod.outlook.com (2603:10b6:404:15::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Fri, 13 Nov
 2020 20:57:56 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::c5) by MWHPR19CA0078.outlook.office365.com
 (2603:10b6:320:1f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Fri, 13 Nov 2020 20:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:57:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:54 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:57:53 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:57:52 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/17] drm/amd/display: Program dpp dto based on actual dpp clk
Date: Fri, 13 Nov 2020 15:56:29 -0500
Message-ID: <20201113205645.640981-2-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e7b19fa-a7bb-4011-e652-08d88816cb30
X-MS-TrafficTypeDiagnostic: BN6PR12MB1332:
X-Microsoft-Antispam-PRVS: <BN6PR12MB13321A087392A650DDACD83EF5E60@BN6PR12MB1332.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlbIsGfRgbNFvMZN7LvC+SZSZj7KBfhsgKgH8XV+jRlBZJipgM0lpjAtYQhGDbwU2Qi7OTlnFssg0oA+/l6I0lKE0N7w/JWNl0BaaUiclZSVfv1UOScdbALslS3hD3saJSkcH2tGfG85O7qBoA4ma4Bny+ZcmAWP2YI30HuHkpsE4QBKU8n9Vv3X+UFAofniC85q62qWyGjL8udDL2U7ToNZK0gp+CVbczJO3xOG5q9avmspBaUvRfwdkvfOtrOijIFejBUyGBtgIyiEoZYtt+DUYCbevEyjN0odfvJzoRi+Qc1+/EYto6awtFKlhyQJs8IZejbgCL5WNNkm/nhtLjF1EroRsepmpS+JR292X74cu+zxw/U9/BhtyemXACmemWn8+txoT48svU3vnuTW4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(70586007)(70206006)(356005)(8936002)(2616005)(36756003)(316002)(26005)(5660300002)(86362001)(82310400003)(81166007)(82740400003)(478600001)(426003)(8676002)(2906002)(186003)(54906003)(336012)(47076004)(4326008)(6666004)(6916009)(7696005)(83380400001)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:57:55.0893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7b19fa-a7bb-4011-e652-08d88816cb30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1332
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Yongqiang Sun <yongqiang.sun@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
dpp dto phase and modulo are programmed with actual dpp global clk
and pipe clk. Need to use actual dpp clk to prgoram dpp dto modulo
to get more accuracy ratio.

[How]
assign actual dpp clk to dccg for dpp modulo programming.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index ec394e3d8367..9e3d8af3895f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -103,6 +103,30 @@ void rn_set_low_power_state(struct clk_mgr *clk_mgr_base)
 	clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
 }
 
+static void rn_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
+		struct dc_state *context, bool safe_to_lower)
+{
+	int i;
+
+	clk_mgr->dccg->ref_dppclk = clk_mgr->base.clks.actual_dppclk_khz;
+	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
+		int dpp_inst, dppclk_khz, prev_dppclk_khz;
+
+		/* Loop index will match dpp->inst if resource exists,
+		 * and we want to avoid dependency on dpp object
+		 */
+		dpp_inst = i;
+		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
+
+		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[i];
+
+		if (safe_to_lower || prev_dppclk_khz < dppclk_khz)
+			clk_mgr->dccg->funcs->update_dpp_dto(
+							clk_mgr->dccg, dpp_inst, dppclk_khz);
+	}
+}
+
+
 void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -177,7 +201,7 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 
 	if (dpp_clock_lowered) {
 		// increase per DPP DTO before lowering global dppclk
-		dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+		rn_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 		clk_mgr_base->clks.actual_dppclk_khz =
 				rn_vbios_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 
@@ -188,7 +212,7 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 					rn_vbios_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 		// always update dtos unless clock is lowered and not safe to lower
 		if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
-			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
+			rn_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
 	}
 
 	if (update_dispclk &&
@@ -199,7 +223,6 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	}
 }
 
-
 static int get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 {
 	/* get FbMult value */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
