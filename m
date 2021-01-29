Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2707BC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99D1F64E00
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 21:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D1F64E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FCF6EC1E;
	Fri, 29 Jan 2021 21:28:19 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690058.outbound.protection.outlook.com [40.107.69.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD3C6EC27
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 21:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnUjQIP+fDetEs0svGLjayU5o+53Hnt1W3RMFv+BvmKKX+BCN4XWNrLJ0O0G0JKVa2b3ChfhBZNkW4eN6QeOSs8y4v5YzELhI/ltARS88D09L4uySVr5r7bLPSjdFTKkUEPvtK0AngAE3RTjbsXeJzcMtm8crvm6CrNRGBHQdkMfsANDKUur1HBPHn25mapFJKK/LdkZSmc6Go/4lcPuURMBPDxrq0k1834G3AJS7ZPxnhJ7P10UvoqechBfJPuCVZT98YlNCBWbqcHew7N/VF0xXMqXNYeal9M8cX0mi6FYCcPjMP5EC22+5kw+LdZLBKJaQmjKP4vDoluI9BYbhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wegywMvXwUQQaEN/PpwnvdOo6YLWQZHxkCOcPLahelc=;
 b=RkWmyW0CbxOjNsPi+hipotJAJxy4wHoPlD8Pmqk7rHEaKxEd17vENo02LMKQER50vsXE1UEfR8lBx2kg9rfaXMb/0328/wCjAIQ7iJDOxhI6GeH9XcIRGZrBu+OlS3Rff1RQXQ9wtDE6zpMv3OZJArcfyM6Rwoiwf4GAsryoaoxGNd8AFqEMllRXNeSrX4DUKcuswm0qPy+I/l5xKWRRPCqBeTFgBBMODB+Zfp6PTitXEJ663X9Qny9z5n2V2Ea3EswtgWOEVZpk4wF0i9FfsiMTnziuQAE+CunvT1+EAC3rrhcHKaAV1diwhQdmTf12YBsGzEQjBCArC4yOuEamUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wegywMvXwUQQaEN/PpwnvdOo6YLWQZHxkCOcPLahelc=;
 b=aw1kLVDl09XrJmhXUcOU6V7cvDI5KW40buTxcmTaT5cZ3iVCyAIo2HGz02F3445lLXrT0PG+9A4/gSn6PCkOY8lPD2yLVoUeRjIbKTfA5+TF1yZAqhFg8Sgd5xHeao81/h4v1yRbWzNKSSYUFXU6wtxaPLxMrSLmujzlVSqWmNw=
Received: from BN6PR03CA0082.namprd03.prod.outlook.com (2603:10b6:405:6f::20)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 21:28:12 +0000
Received: from BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::99) by BN6PR03CA0082.outlook.office365.com
 (2603:10b6:405:6f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Fri, 29 Jan 2021 21:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT011.mail.protection.outlook.com (10.13.176.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Fri, 29 Jan 2021 21:28:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:07 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 29 Jan
 2021 15:28:06 -0600
Received: from Bumblebee.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 29 Jan 2021 15:28:06 -0600
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/27] drm/amd/display: Add more Clock Sources to DCN2.1
Date: Fri, 29 Jan 2021 16:27:33 -0500
Message-ID: <20210129212752.38865-9-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129212752.38865-1-Anson.Jacob@amd.com>
References: <20210129212752.38865-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70c356ba-46f1-4dec-9ad8-08d8c49cc6f8
X-MS-TrafficTypeDiagnostic: BY5PR12MB4292:
X-Microsoft-Antispam-PRVS: <BY5PR12MB42923ECBE73994B4F0C3892CEBB99@BY5PR12MB4292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CjxUxqe7RDPNl2doeLux00GuheF9912Jtv0FcwCSLRFlqw5hoQSoIjbIi98lG9LuqTBu21yuz+yp27IpTF3hZ7+HB4F+heAqsNctLhpOx3/Ss8LEZzN+9mM+8cOWC372WTtgq40o//QD+ev/NYeTNhZF28er+USRbLGwQFxcIiAptL29jTCCYPFEQECVBx61IhqSS/BJXlr7xmlFQ23qA+5aeowWLzhX27hadNpyl4dEfzK5kzBOFhFKmhindEc7/K7Np02uh3wBoE4gMEsLPgut8l4NA8ZHKf9oYZLJl0GD1MOtSZV5K0Sp/4VqIxwccqVnUDdYDtTQW2bfrsLGRhtxW8nhngwZaY9HvOORs2aF16YXioBsvPeO17BbVQdGlxlLSsMjSF8SQncKX2rbbcJFX64OvVXW9C5vSMO6k6QBuZ5ClmXYxZdw0tku8O9YnpQ08VCLp6cxuWkxwN5Jz3lNlCPraSPEYYMnqHpqNV4s5u2fDQ24ZeWU9QKrbqT4j8otMejqP7FoJP1FrFlBzvzOI7i0Aq+YbKj9/po6Pvf9HmkdewkZnApXu5ozxTC0Vy5xgeBCgpzPdtotjpLfHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(70586007)(1076003)(26005)(47076005)(70206006)(81166007)(356005)(82740400003)(5660300002)(336012)(2616005)(186003)(36756003)(7696005)(478600001)(426003)(83380400001)(2906002)(82310400003)(8936002)(54906003)(6666004)(6916009)(316002)(86362001)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 21:28:10.4599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70c356ba-46f1-4dec-9ad8-08d8c49cc6f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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
Cc: Sung Lee <sung.lee@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Tony
 Cheng <Tony.Cheng@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY]
When enabling HDMI on ComboPHY, there are not
enough clock sources to complete display detection.

[HOW]
Initialize more clock sources.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index b000b43a820d..674376428916 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -906,6 +906,8 @@ enum dcn20_clk_src_array_id {
 	DCN20_CLK_SRC_PLL0,
 	DCN20_CLK_SRC_PLL1,
 	DCN20_CLK_SRC_PLL2,
+	DCN20_CLK_SRC_PLL3,
+	DCN20_CLK_SRC_PLL4,
 	DCN20_CLK_SRC_TOTAL_DCN21
 };
 
@@ -2030,6 +2032,14 @@ static bool dcn21_resource_construct(
 			dcn21_clock_source_create(ctx, ctx->dc_bios,
 				CLOCK_SOURCE_COMBO_PHY_PLL2,
 				&clk_src_regs[2], false);
+	pool->base.clock_sources[DCN20_CLK_SRC_PLL3] =
+			dcn21_clock_source_create(ctx, ctx->dc_bios,
+				CLOCK_SOURCE_COMBO_PHY_PLL3,
+				&clk_src_regs[3], false);
+	pool->base.clock_sources[DCN20_CLK_SRC_PLL4] =
+			dcn21_clock_source_create(ctx, ctx->dc_bios,
+				CLOCK_SOURCE_COMBO_PHY_PLL4,
+				&clk_src_regs[4], false);
 
 	pool->base.clk_src_count = DCN20_CLK_SRC_TOTAL_DCN21;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
