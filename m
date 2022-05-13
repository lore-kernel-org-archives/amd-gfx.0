Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3FFC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 20:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 285F310E955;
	Fri, 13 May 2022 20:51:36 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23BA110E955
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 20:51:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4OCnuyelbmX4/hGozMdmtm7xxUlm9PWIumynzli32cMQHaEAy5wP1gMloSUiHjF+Y1EwP8IwPuWDY05uBgbOiBdDjU9YYJO8+bMEXn+6Nm4vX/7ZhXFYLmVvR3zmXsgC6Lzlm5iCSEYl0DEKeE8YF0kRMdW9b06lCQU+UW3khIbkGAYi2n02dvobxKer8WIFKXuhqbu9VylQxxprnBlGqSEWAxYqlZLnovbMc9q6q79A/zpVhLyXpBfgvNPtXMlTQM/cVvjY2rZFmnlZTKBMndVBZKhHZbe6oiHActiOzcg+rtc4fKIIvQybgFXuG7InLRReFPMDLWiuY2ILkt4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H9BA1AkC/w1FSEUSj0YobsSXK9Y+gbOdyDtbdejtWAk=;
 b=d+NDpBSn+kICmUVFEQMSTROBJM2DXmWUlkh7xSziB54LzJL8UQDGMrE4tRls6W8BRjDkltcjzV78FTAYaYLK2vKzcU72G2E0HY92FFktOy5g6BSSrW3VM6UsEFCudskkiwQTgXrTI6XBEVP48GNvZ/WB51/HoinR+1OMP4dJXflrsxzciJAXheXdcoVfNO+3IFNRfpRSMBGJDlZLrEnCFhMAG2ad+A3tSgmFyiBRRAA7YM+Ba+wcqaYeEkQd3W5x6prSXYmS9BLrfqtapfJ4I8CxWZdBaeSqJloLb7+OySluvflq7erXn++s+i9ZcmGglfPYMUajESjsrp/gTfZuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9BA1AkC/w1FSEUSj0YobsSXK9Y+gbOdyDtbdejtWAk=;
 b=DAMzgrKTLkJ4qWBoErnKV6+PHKjzl5jJoCnAAwqzH5JHlXOCdbVp1V849vleJlgaSS+KUqZ2Z+dmfESecwCa+Nb43FA8U3hMiKDqcSaxuD1BEu6PC3hvULQ4ELBorslP5i7BF8eso2PixZ/f9SSBTzuat2ZxqZIC+/lU6asOG5A=
Received: from MW4PR03CA0285.namprd03.prod.outlook.com (2603:10b6:303:b5::20)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 20:51:33 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::79) by MW4PR03CA0285.outlook.office365.com
 (2603:10b6:303:b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Fri, 13 May 2022 20:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 20:51:33 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 13 May
 2022 15:51:31 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/11] drm/amd/display: Fic incorrect pipe being used for clk
 update
Date: Fri, 13 May 2022 16:50:39 -0400
Message-ID: <20220513205041.1311639-10-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
References: <20220513205041.1311639-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e006860-ac14-4c80-6f5d-08da35225d0e
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6323FBC409C53262E95B8783FBCA9@CY5PR12MB6323.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IseV6WCwTG890vp76LcjaGWa6VscrkxOCon04RlZKl7Cfh1QKQ8s/m7FEBadVdgWzKge4jQw2xsKfIYKnvYy/UjPQ3DDtFAx6EGiKpE107uCptomul6WRytBVqn0vFXqtYXK6vJCC1CKVL0bswkJaEpG4VKpt3mWH9zzANtU3XeXx7ztNkmg30HiIs1Y2+ReFRdzQYJpzFgcKGxe+k/jiGiTGZOJKIjXI+lhBaSsmJxwOTYsouHSJRwTkNRQ29mi/tQAeiCdohNakSRmQl40+mT+nnE+fPgK+OMSml+CZn5INbrQsavUxnVVBMcCqwIGomxcsrP5pWxpFKzwd7Cbj2qwP5+BA4Xwaftozn105nKf+DBi8yvJP2wtpM4FI31fWRqnGTXJ0BCQPWNQx9MHsQtOxnXJYrgCTOkCNOkCoW3KSNruoCuq1wp8KGyO3mdcyo9wKhEMMJBg0JUHmY7XCF6Q4WIqmdz+dhB/FHbu7GIocmWOLiTxdhWspgIkf5iO9BACrs/OcEQrCySeUawXmsNwGUiUjPGNOqNjasEkVnpM5A97OIIlbkOcXF8110d8Sq4HxPyLcd4itz5Fn/XPQTjda74graHJsUvdde4DH54fih2rvoBeoSu6QPweTQNhDosgdBGTOig/3fHP03+TT0QgLnsDaXqQVO2MDW7BHMG788KUpk5Rtm2n1CSzqfSBkircZBduJnybR2U9ygQtzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(2906002)(508600001)(81166007)(26005)(83380400001)(1076003)(5660300002)(44832011)(2616005)(15650500001)(36860700001)(86362001)(54906003)(82310400005)(6916009)(8936002)(356005)(36756003)(336012)(426003)(316002)(70586007)(47076005)(40460700003)(186003)(16526019)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 20:51:33.0858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e006860-ac14-4c80-6f5d-08da35225d0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

[Why]
we save the prev_dppclk value using "dpp_inst" but
when reading this value we use the index "i". In
a case where a pipe is fused off we can end up reading
the incorrect instance because i != dpp_inst in this
case.

[How]
read the prev_dppclk using dpp_inst instead of i

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 02943ca65807..cf1b5f354ae9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -122,7 +122,7 @@ static void rn_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
 		dpp_inst = clk_mgr->base.ctx->dc->res_pool->dpps[i]->inst;
 		dppclk_khz = context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz;
 
-		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[i];
+		prev_dppclk_khz = clk_mgr->dccg->pipe_dppclk_khz[dpp_inst];
 
 		if (safe_to_lower || prev_dppclk_khz < dppclk_khz)
 			clk_mgr->dccg->funcs->update_dpp_dto(
-- 
2.25.1

