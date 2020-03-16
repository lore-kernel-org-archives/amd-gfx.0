Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91ABC0044D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9892051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZqVuA3KU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9892051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFF96E46B;
	Mon, 16 Mar 2020 13:50:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E4E6E462
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+SCbsDl6Jp3YvI+kVmpeDxiryqEKgtiklHiopyNKfbTBC4wAKAGrV+h5k1Zwi2UWirtyLZBhtnkE6m4IT/aNxqzLg/xh5gEeSNz1+b2oln6xTniGKSl4i77y3peDwzdvB6/3JwYqC+1//DbnHRBGO36D7m+jgtrthq42Wh00UTPSGe61yGWHyDLEm2z/qXgyTbmIb9QxCNIyFDxAS1Jtn4kSalbSHqpdJRlxAh+8at4oi1KQyThDOYs58ir+lXU3a1yr2afMBGcqIjoCbxWFbpC4L9HeBwpa7WpTaClW/YYmd1om9x+GAfzCNSwGVIJmxTNu662y1P5x2DpNtLurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdfLIeYkU2jG1CgFnc4LAd9mjepVaKM33L6dWLRNzYQ=;
 b=nIpSDnoSdZWAvcTgrgVoQ970P2sLtIZ5kZ010UbOzRVZYuVsnwEdTWJTRG7yteBjt+1ajMUtxEc06pzap5pz84U8sXMNOQdhhq+FQD0VvlWYfhoi/A41s+5NURFHofIMKSaSygEPtjHMXmrc5SLbiMQNhDevSTZsywbRheUK27szan3n40mxdWSRloZZ+UpEM/yLftgQ+YGzjeeHSr3t7gvylTD7NZBznKalz7qbUZGBFQYvimWG4oKGv40lWE1/3ytwdj6MbkHiRDigqn+yjTuQ53tvnKRIE+rvlyl4YlmPTwL/hfoLSFfJHQJO/ChvVU9ddutvlhDF8x7AtO5FIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdfLIeYkU2jG1CgFnc4LAd9mjepVaKM33L6dWLRNzYQ=;
 b=ZqVuA3KUt2jTYtRPg4G5DAGWzXLqNaqLYxdlmVdex1HTIGVtDDEQjz2DZ3YhSJ4k/r66gQaztVVBvyCDIgSDoqA9XkGrtES9GOxPb+ty5YFlhI+MMB6gEI6QfD5HnLrVLe7vUG65zB4ZiI9XDxRUnZ9xDyET4BJI91jD/NuuQ+4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:01 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:01 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/19] drm/amd/display: Set disable_dmcu flag properly per asic
Date: Mon, 16 Mar 2020 09:49:10 -0400
Message-Id: <20200316134920.2526155-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
References: <20200316134920.2526155-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:50:00 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3fee3fb7-3055-4e99-5565-08d7c9b0ec55
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2396FE6BAB6A632F88C6D2C098F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(66946007)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kw0zxlw2DFi22WIHPPyy1e6hnOGloIuoJUmLsXuHqV7QgTP9UFXCHLxGKTQF4Vl8UTw/UfFs2fpSJW2eVi105oy2bi19lNp/K22VZmltweRoJMzXhR4RHtWmfRdhWHhmVSSAjXQZTDwJ/FVH50zbixc1IHNBQvaph4+ji3LOpX/m7f1pr1UV7/DCOMYOrwfAzJGOzRseTAtMZ6FAIoKFB1W6Byru4q5J/FgqsJuJ7Mt3ClCPeCkUL8YryrXNzm5NMJAPDPNG21PEZ0WQPR8fgg5o3Js+64tghPtXQDMRwG4b+HJeDyYPaYrQJ20KQjnXaADoXvtDjiVJLMGYX6gbTNsdt82quGRb5Q6aUweIculPA+aVHlGieS4DM387Ep63pOLbXE7KIyR9lcHZksgPBSVaJ7q5k0WzD+AzlDCQoPu5vxTiAzoEvBLxtqJs9Of
X-MS-Exchange-AntiSpam-MessageData: fwgJsUzGqCwsRG04LywJVgR9MwvSDsUEFJ/nmE+dRt0miAwMs3LNqOuSl82PFq6eR3jpkjifnseJpuVvyso2QIfaVOG2snMzp8v4yixNSE2DuLOT3zubQ5+mEaxML4whTFTcUoifZoVGTubPi6NE6g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fee3fb7-3055-4e99-5565-08d7c9b0ec55
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:01.5775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ef6mppthxycbv22JjF6YfmftH4PcnWJG/cjzLMG0oEjeCoBIfefFpPoAirf18BZsQcntfCu5VVHVdkCROEgksw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2396
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wyatt Wood <wyatt.wood@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
The default value for disable_dmcu is true, even for asics that require
dmcu.

[How]
Set flag properly per asic.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 95fda0b7523e..261bdc3a8218 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -570,7 +570,7 @@ static const struct dc_plane_cap plane_cap = {
 
 static const struct dc_debug_options debug_defaults_drv = {
 		.sanity_checks = true,
-		.disable_dmcu = true,
+		.disable_dmcu = false,
 		.force_abm_enable = false,
 		.timing_trace = false,
 		.clock_trace = true,
@@ -598,7 +598,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-		.disable_dmcu = true,
+		.disable_dmcu = false,
 		.force_abm_enable = false,
 		.timing_trace = true,
 		.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index faf4f5ef1795..e25ed6235812 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1041,7 +1041,7 @@ static const struct resource_caps res_cap_nv14 = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
-		.disable_dmcu = true,
+		.disable_dmcu = false,
 		.force_abm_enable = false,
 		.timing_trace = false,
 		.clock_trace = true,
@@ -1060,7 +1060,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-		.disable_dmcu = true,
+		.disable_dmcu = false,
 		.force_abm_enable = false,
 		.timing_trace = true,
 		.clock_trace = true,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 158f7c8b55ae..37f9a71eb4c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -855,7 +855,7 @@ static const struct dc_plane_cap plane_cap = {
 };
 
 static const struct dc_debug_options debug_defaults_drv = {
-		.disable_dmcu = true,
+		.disable_dmcu = false,
 		.force_abm_enable = false,
 		.timing_trace = false,
 		.clock_trace = true,
@@ -876,7 +876,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 };
 
 static const struct dc_debug_options debug_defaults_diags = {
-		.disable_dmcu = true,
+		.disable_dmcu = false,
 		.force_abm_enable = false,
 		.timing_trace = true,
 		.clock_trace = true,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
