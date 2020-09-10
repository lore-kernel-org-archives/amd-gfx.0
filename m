Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156E8C07548
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB4F21D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D+H5ho5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB4F21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 710D76E940;
	Thu, 10 Sep 2020 13:47:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC5A86E93D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7EDjG4WBcrbcUeLYPJSzGROLgoIyoJTSueWzO90IUMgp3s1gFt+kEJQ5CqwWNVodZZNtM4LczEu0lU+IFHhAp2pnUPPqAa4WxxP4Cjb1cEfr2OhuDKT2GZ2BWTwQNc7PdSWDwBBVyjL95gRdgV4Or07aC7OzOhhZT8qBi4CV7hlVqxK/+DcOW8V/SCXHDxjowvearx4AnR2p6CQgr7IcSHDHY54JyO4ELfj4+S35FhhM/stBJG+rRRg6nhgRXssscfrSAvesI1YdIMPRN38dT0Msw8Z4B56iwPxSK5c/2gNwQmcWP4MLYelGeltdoKmzMXNDAuh9BXu2JaZjsevfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo2b/7JtpFhsXhI2zZVVK4cnFXZZS70OiYwpkVs0x+k=;
 b=AONgorDvOsSShAkDKEeEcC4XeRr3GPbYVYuuqiXYWJ+v8bXaThZRwijCP8d/iPmOw2X8mKo4lU2zvs7ejCwMJwBducknn13suAKt4iNYgj1IluP/sGz7QN0WACnaNxkhS/aJFib/XGAHu57v0eBZCvKlvv66dcSLyMwxXM5UNaSRl5KciG1HeOcWF3fUCwIe9BKzuDE7JaH3F+0Rim/7nTKWr1zPli9RsdXJXmiY6k5BimPCQn6M6Ji3Kh2eW5f1PV2ZXbch4AC1nTDWdLc3k7kTcYhqkDAMyfVEhPOEvXG+PX2qhqvk1SesSYHzzZiiSF9BIk7zxrge3B5SLctreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo2b/7JtpFhsXhI2zZVVK4cnFXZZS70OiYwpkVs0x+k=;
 b=D+H5ho5UO9MMs7NOg+TtkWd5GibjGhkIJoVZJFPxJ3Cx91yDWd8eOeBu4AsLCn0PndikZPFSl1ynB54tQJ2wZOKHv/TuvYMGlGgBHa2VKzmGvuAF+OwSxzLaRHe07bq6fYog8aVTk9LCtEHriRSnIGk6wFqHG2E6lX2nvhh3APQ=
Received: from BN6PR2001CA0035.namprd20.prod.outlook.com
 (2603:10b6:405:16::21) by CY4PR1201MB0168.namprd12.prod.outlook.com
 (2603:10b6:910:1d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:29 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::78) by BN6PR2001CA0035.outlook.office365.com
 (2603:10b6:405:16::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:28 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:28 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:27 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/42] drm/amd/display: Compare mpcc_inst to mpcc_count
 instead of a constant
Date: Thu, 10 Sep 2020 09:46:47 -0400
Message-ID: <20200910134723.27410-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6991bcc-7ce6-4353-4bbe-08d855900ee8
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0168:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB01685D3B430FA5D3286031F88B270@CY4PR1201MB0168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:260;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4qhXQTagIPWeEvFwYaenQRabkHhmE1IK2IqILzA/E2yBPdEa81jYiFZ+21KeCWyNfffgW86PzjJHsfyrN0/QWna6Hejtb4MZtS3peJOZMKtM0cSWaaWQs8q/5MCeZzMEKZ+IvlcI0j51JxlwnMOp4TFtNDSPHdCtsjA2WoFZD3WBadfLqrBD4NXd5693RW17VPivptCWWyH7iUyYlqykSL+4TyzhB2iUr4tIhTBXIGAM+OolWczhxQBYgAhelDnJA2XOwrhnd7aIOfuL69DH+ex8dZqsIFpAtOtUOi9DUJxM8Gs9lU1UW1VmX7lkoshmQlEXhSL6HMS3tIQhQkhFnwHLPLwtLmP1rnw2qUeGQLkJ9mT1rUxhLNO/FkuctXpR5wYsJc6DSUEEDATKnyRTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966005)(1076003)(6666004)(8936002)(2906002)(70206006)(70586007)(5660300002)(36756003)(86362001)(6916009)(26005)(7696005)(44832011)(8676002)(186003)(2616005)(336012)(426003)(316002)(4326008)(54906003)(478600001)(82310400003)(81166007)(356005)(47076004)(82740400003)(83380400001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:28.6241 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6991bcc-7ce6-4353-4bbe-08d855900ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0168
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
This assert triggers a false negative because there are more than 4 MPCCs
on many asics.

[How]
 - change assert comparisson
 - remove unused variable

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index a5d750ed569e..1390ff1ce7be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -220,15 +220,13 @@ static void dcn30_set_writeback(
 		struct dc_writeback_info *wb_info,
 		struct dc_state *context)
 {
-	struct dwbc *dwb;
 	struct mcif_wb *mcif_wb;
 	struct mcif_buf_params *mcif_buf_params;
 
 	ASSERT(wb_info->dwb_pipe_inst < MAX_DWB_PIPES);
 	ASSERT(wb_info->wb_enabled);
 	ASSERT(wb_info->mpcc_inst >= 0);
-	ASSERT(wb_info->mpcc_inst < 4);
-	dwb = dc->res_pool->dwbc[wb_info->dwb_pipe_inst];
+	ASSERT(wb_info->mpcc_inst < dc->res_pool->mpcc_count);
 	mcif_wb = dc->res_pool->mcif_wb[wb_info->dwb_pipe_inst];
 	mcif_buf_params = &wb_info->mcif_buf_params;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
