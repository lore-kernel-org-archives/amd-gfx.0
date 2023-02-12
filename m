Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47673C05027
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D9D10E2EC;
	Sun, 12 Feb 2023 17:00:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE2710E2E7
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkkOgyGZb3TWPrJvh7QP8pygk7Vymnq2rxII4DzL8e2G3FIqrPhkcSmZCoVOvcX2y9jaRynq+eeyArCou/H0XfSUpjE3Uw74PwJmRredRI24IPMARIg1K1nsy6u0sHLOOkEPEZVn5SO4OgRg5y4jv3CrWMzYh1RJp/PeZ3xo9PVroyL6uStIrim2uJrcBzQtuB7EW5jF7f8diP0YG0CE6RscZKXnv2JoxtVra+Z/+2XAGD538xs3CwJjjJxfgTmH8qvsM12rVSZv+7v24kOqiTEsLDlZBhMuNDYC+HjVCKRGk3RuSVCC3al5OufcHEpZqAJ3PXlJVmodbVt8Kpr2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnJiJp+Dbzre2dkY3SZT4/p8tPC7/y1b4G7H3gS2TIo=;
 b=fVrm9zkvL4Uu3HdFuXNxP9IsTNsradThp+QESkniV3/dCCbnSgaGnMaQcq6urMt+tdMYSdnE8oQXug6XjWrvWFwX9YgZemoRKvbcvshK9WUJrWWzJUpkxfGEYId/LXV7uA793uE1jsO3QCUXcdvirgqocjvpc7sEowlyVAIjWsO1Yu/IxHjINQ2hsx3rDhvs5rmK8VeKwiO/MMdgMTSv6dyBj8CJKo2uxy06RueksEQTqjtqt1nmDOurJpIlO5FN+UwZtte0uUd3FcR9mWWJKxSTYJTqnC4071jxf30DizV33YPqdhPcacRE3gB3qQ+HC74yyFory80QGbznHfUv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnJiJp+Dbzre2dkY3SZT4/p8tPC7/y1b4G7H3gS2TIo=;
 b=0mqsJDAfstkqdi22qUZCMFpXKdQvD/qr1wCh3d/4PaNBL7FjAnJBdoSeTrM3cMGw4cvZmjYBTn/O7w6mvRQGi6tMa2WQ4u9TwBI/lQHXNlvLVeccMlfET5blExhfpTbRq9aMm6PiIZ5D9RJcxULGkl374KyGhfsQoGRU5eIfB10=
Received: from DS7PR05CA0018.namprd05.prod.outlook.com (2603:10b6:5:3b9::23)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:35 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::8) by DS7PR05CA0018.outlook.office365.com
 (2603:10b6:5:3b9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:34 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:33 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/22] drm/amd/display: fix k1 k2 divider programming for
 phantom streams
Date: Sun, 12 Feb 2023 11:59:36 -0500
Message-ID: <20230212165955.1993601-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cfa3e4-2586-4fd2-5912-08db0d1aa898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kx6nbqYeat5/esoLOGyb7VN0j9o9eKEDvMHGbU//u6LXTqG2298vGkNkcFg9SRjtAfGo0f+4MGEqmGsj27GjQbwfsNfppIQheC5zXhhbFJtwBPRL77YpWjB7h9S7KbfCKIOdD5tWx0jBzG8vje/8KRyS2MFef36SRvF9pQW9FbZhaiNLg757lj7bxOqfcOj81geKzbFYmLvQ0vBQicAGOH4jEzjr0e8UtAr14CBdIjmtssBP4POAZSI7EyvO1xU7ees3l1/UX1II1sYZNGnnRS62Z5bJWEFlhopYoGVuR3vpnske1CGI7KnWiM9zYuXodPhIbfGS20r7fFfF/kScx0HeZFJNbdc/1DUwyb2T0wQ6TYoH6wTMLDnBuzjdcIwPN6hs95KyHyWFgfe2EXlTPDzmOIQC9PLC6Fzp2m1C4faryUOnji+/R75kO3qjU7VdoBo0/fQzp180a2RS3Rj51MTcTLM3A5RuCUA2wSB3HqPA6jNCz1yrQp7FaQV/qstbItKhOR868ov5uDcqZVvn35Rm0xGmcQeFl2m72eixNlYA9+ypVRuuZGEelYfpEIy2ptCZUqifrwKvWQTHEsiSPRvzLOwSwinj2K70XlukINXx/Ji0kDxQADco7I/ig0WfUgym8mK+n12Pe500+Z2GyULTCN3vcSNhqA7EZ2n+VWa/TSUqHHuuRTVe8mWHzl5RstaXePS+vqroxSQBUdLqi2qQ6d6FHzJz8j+tM5N80cU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199018)(46966006)(36840700001)(40470700004)(81166007)(82740400003)(82310400005)(86362001)(40460700003)(40480700001)(36756003)(356005)(2616005)(6916009)(4326008)(8676002)(316002)(70206006)(70586007)(478600001)(1076003)(26005)(186003)(16526019)(54906003)(2906002)(44832011)(36860700001)(47076005)(426003)(8936002)(41300700001)(336012)(83380400001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:35.1143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cfa3e4-2586-4fd2-5912-08db0d1aa898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why & How]
When k1 and k2 divider programming logic is executed for a phantom
stream, the corresponding master stream should be used for the
calculation. Fix the if condition to use the master stream for checking
signal type instead of the phantom stream.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index f803827b8d40..16f892125b6f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1098,13 +1098,13 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	if (link_is_dp_128b_132b_signal(pipe_ctx)) {
 		*k1_div = PIXEL_RATE_DIV_BY_1;
 		*k2_div = PIXEL_RATE_DIV_BY_1;
-	} else if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) || dc_is_dvi_signal(pipe_ctx->stream->signal)) {
+	} else if (dc_is_hdmi_tmds_signal(stream->signal) || dc_is_dvi_signal(stream->signal)) {
 		*k1_div = PIXEL_RATE_DIV_BY_1;
 		if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
 			*k2_div = PIXEL_RATE_DIV_BY_2;
 		else
 			*k2_div = PIXEL_RATE_DIV_BY_4;
-	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+	} else if (dc_is_dp_signal(stream->signal) || dc_is_virtual_signal(stream->signal)) {
 		if (two_pix_per_container) {
 			*k1_div = PIXEL_RATE_DIV_BY_1;
 			*k2_div = PIXEL_RATE_DIV_BY_2;
-- 
2.25.1

