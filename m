Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1918DC433E5
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA1920748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ks52OD7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA1920748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818E06ED0A;
	Fri, 10 Jul 2020 20:34:06 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750078.outbound.protection.outlook.com [40.107.75.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 726EC6ED0A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 20:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONyzxJj77SX/oW0YnEJLj7PJI2/iMrZ1PpM7ZGtEVQsVqgYQU970rqAfLYD0my2brjIBg5qRDZdNDGh+LG4YIspKec+Haj205ZDCMCYQ2xrMsJTRIDWkwMbWlzIuwSztb4nTuy9RqcUHJiqByERxOHIUd3Di9/rVgTedGLpc2QaDlxp03C6MfseJZgUWUrymiaL/tTG31NvoajIiywOS+xFkk8VdKlZHSklXTebbfM+FLYpmC2EPVTXxXvwJzinDHVI/6zksQcq77FUKHOfR7QxPgdPhccbJGO/YTFBwmM4DVBaA+2+gT8+bjMGlCJmjJtCZ7AYzVfejC1Gs66DcFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSk4Fj6pzPtW3rJ4YJgzAFPMoE3hSuKUBWTxTQfc3VY=;
 b=XaUgE6DOpE+0FzeSXULIuNOMRBEFqmb2nex4qCTFHzcW5rZFJrv4+A/cHvDalHvP4ITO4FsIExx6UKaxFGNg42VeQYX+mBCmZCk7UsNYlxgwwOSHIqM+7zp07lT42tKgscLTHQEizy4+akz8Nf6Tjx8eESWm2xcc7Q/BO6L0DYRa6Bilvhwstqh+LtLUxVZO6MSt1JlO7G/RW2GowlDsQSYNWqqt4xRHtHy123Y0DhM/U4utwoMAau2x373/8oY8gMPSV/+n2MeSuEHXUBhJ+uCuEn+0MlV1nCRgR06NPsx1FNFDNuUjmjLsxeOenrMT54U8mgFxevRBe9CVgyWLTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSk4Fj6pzPtW3rJ4YJgzAFPMoE3hSuKUBWTxTQfc3VY=;
 b=ks52OD7BYtBn6SBbWLjSuS5VTw+qj1Ahb748/W4EtQI0QfTYcl74rFVOeDBow/vYujjhVwJlzBpwU/VuwU6dOjgVJGTXvPCAsjrtbAN9TvI8H8UcuK8tk2E2TrDt7yB2i21iyvtSYXdYc18QvUezrQxnFTgQxEW+DW4/nlI9efE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 20:34:02 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 20:34:02 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 05/10] drm/amd/display: p-state warning occurs while changing
 resolution from 120hz to 60hz
Date: Fri, 10 Jul 2020 16:33:20 -0400
Message-Id: <20200710203325.1097188-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
References: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:8440::b10e) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 20:34:01 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 638a2540-3428-46d3-0f2b-08d825109508
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB42310152013EB0184F132F7A98650@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5+EcWa+YYOq2gL0FdWaFmk7kc9tEVyvzvbEQDDLoLCfJvWPT/OZLniC3LSlQnP+lQFBIjJ0OmmT+FLiwQXtYPDfNKvgrM2KEG/8xP35xmXNDDFDUY56/wNOFdDoRUB6uE4fa03Pl7MmxhHFXvb5WL364x2BX6ti5QguXL8T+1dhGOEJNL6k3652srJmdD0CL9D66a2DOjp3X57Z1GnhAxFlG+rSOpS2Uw2HwZ4Q/N8HKc8nPEMu1Vy6ZCMookrrqL5m9Mi6LJIh+i50DZEUdlJP7Kk+yQYXFTDrQs66VffcxmqOTKr2qCsSIgQ3XcBgtSYV8XmeTWnF0AXQuQ5xGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(54906003)(2616005)(8936002)(8676002)(6512007)(478600001)(316002)(16526019)(5660300002)(186003)(4326008)(86362001)(6916009)(52116002)(6506007)(6486002)(1076003)(6666004)(36756003)(66476007)(66556008)(66946007)(83380400001)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: n8iAZfisjsJPTtgk9PXxU/kEypPQdRTPMBRPBdWys3JICv8jQY1pxTELRFK6w/4Ztu5jSo9ihpb6yIyBhKBApzbKub6J53C4B7anKa3E+vIrDBjs4+IjSUcSbQRjBU8mHlZGmnhmOGkgQ3hYMNusKiIzRPUFEvWhtzqhjAxb+EMrIDNk478C1uUV9pbTAfof0D5cEvErvJwQAuS+NmX02FND+AmiOitCzgSN6zUSdSa6MRh3LwAcSjQVnNd68Ti8+asqnTN5X56aC9idCnnQaAPkaLTp1VqnTpdx+bu7eWp/Qm3WcyfIzyNhPqpr0MN7wOwsS5YoxX2vPU5N8D3EY+qGXItVvV/1yrr68VDPce3ty6Rb0tlfIGawRXJx1YL5flliE+Bws/zoS5uzV/hwkgSmRC4Hnhi5wCeRNVS0ETVeXL5VRwDIPIA14LbMfEQRcXA1IkEWlwX4SmYH0dqw6jk7kJDhXlfrmU2K++aTpTMkVWmhomtNvIHCli6dfYG6mJ/pIrKeZ24v1LszTKCZRQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 638a2540-3428-46d3-0f2b-08d825109508
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 20:34:02.4227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAew/f3IoGEfB0iZINETJWKKGwicHs8IL8tXc0qjgZgzCPmOxWU66vray0LofcHfgK32JTIhIN/elxCi/s6hhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 hersen wu <hersenxs.wu@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hersen wu <hersenxs.wu@amd.com>

[Why]
new calculated dispclk, dppclk are stored in
context->bw_ctx.bw.dcn.clk.dispclk_khz, dppclk_khz. Current dispclk,
dppclk are from dc->clk_mgr->clks.dispclk_khz. dcn_validate_bandwidth
compute new dispclk, dppclk. dispclk will put in use after
optimize_bandwidth when ramp_up_dispclk_with_dpp is called. There are
two places for dppclk be put in use. One location is the same as the
location as dispclk. Another is within update_dchubp_dpp which happens
between pre_bandwidth and optimize_bandwidth. dppclk updated within
update_dchubp_dpp will cause new clock values of dispclk and dppclk not
be in use at the same time. when clocks are decreased, this may cause
dppclk is lower than current configuration and let pipe stuck. for
example, eDP + external dp, change resolution of DP from 1920x1080x144hz
to 1280x960x60hz.

before change: dispclk = 337889 dppclk = 337889
change mode, dcn_validate_bandwidth calculate
             dispclk = 143122 dppclk = 143122
update_dchubp_dpp be executed before dispclk be updated,
dispclk = 337889, but dppclk use new value dispclk /2 =
168944. this will cause pipe pstate warning issue.

[How]
between pre_bandwidth and optimize_bandwidth, while dispclk is going to
be decreased, keep dppclk = dispclk

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 +++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 20466cad6ade..e8ba55401148 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2462,14 +2462,46 @@ static void dcn10_update_dchubp_dpp(
 	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	struct plane_size size = plane_state->plane_size;
 	unsigned int compat_level = 0;
+	bool should_divided_by_2 = false;
 
 	/* depends on DML calculation, DPP clock value may change dynamically */
 	/* If request max dpp clk is lower than current dispclk, no need to
 	 * divided by 2
 	 */
 	if (plane_state->update_flags.bits.full_update) {
-		bool should_divided_by_2 = context->bw_ctx.bw.dcn.clk.dppclk_khz <=
-				dc->clk_mgr->clks.dispclk_khz / 2;
+
+		/* new calculated dispclk, dppclk are stored in
+		 * context->bw_ctx.bw.dcn.clk.dispclk_khz / dppclk_khz. current
+		 * dispclk, dppclk are from dc->clk_mgr->clks.dispclk_khz.
+		 * dcn_validate_bandwidth compute new dispclk, dppclk.
+		 * dispclk will put in use after optimize_bandwidth when
+		 * ramp_up_dispclk_with_dpp is called.
+		 * there are two places for dppclk be put in use. One location
+		 * is the same as the location as dispclk. Another is within
+		 * update_dchubp_dpp which happens between pre_bandwidth and
+		 * optimize_bandwidth.
+		 * dppclk updated within update_dchubp_dpp will cause new
+		 * clock values of dispclk and dppclk not be in use at the same
+		 * time. when clocks are decreased, this may cause dppclk is
+		 * lower than previous configuration and let pipe stuck.
+		 * for example, eDP + external dp,  change resolution of DP from
+		 * 1920x1080x144hz to 1280x960x60hz.
+		 * before change: dispclk = 337889 dppclk = 337889
+		 * change mode, dcn_validate_bandwidth calculate
+		 *                dispclk = 143122 dppclk = 143122
+		 * update_dchubp_dpp be executed before dispclk be updated,
+		 * dispclk = 337889, but dppclk use new value dispclk /2 =
+		 * 168944. this will cause pipe pstate warning issue.
+		 * solution: between pre_bandwidth and optimize_bandwidth, while
+		 * dispclk is going to be decreased, keep dppclk = dispclk
+		 **/
+		if (context->bw_ctx.bw.dcn.clk.dispclk_khz <
+				dc->clk_mgr->clks.dispclk_khz)
+			should_divided_by_2 = false;
+		else
+			should_divided_by_2 =
+					context->bw_ctx.bw.dcn.clk.dppclk_khz <=
+					dc->clk_mgr->clks.dispclk_khz / 2;
 
 		dpp->funcs->dpp_dppclk_control(
 				dpp,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
