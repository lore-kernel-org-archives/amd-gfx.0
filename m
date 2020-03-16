Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B655C2BB1D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCCE2051A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 13:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pQw2+l93"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCCE2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1093C6E46C;
	Mon, 16 Mar 2020 13:50:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AFA56E462
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 13:50:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP4QDYzqzioUoAMtMGjh+KEPFNFN7fPZ1DvBiEz0gc1Lai/eIMBDjOn1D8rXQMcf9zJKQ+En4B3Y9vMkqUT9Xrg82pg0YrsWNCGVKTc+9AgYu/V4KPa05Wurl4mp4X3Tnin2XTeh5+ULWBzKf/vbCZ+Ht7+JKmnNkm4kZCU5iCTzWKEFc5tA6Lmigt2/rSFYpEiGoc/0SmSfnRHBeAWEo8sm06a5mqnA0ydu0MV09VuCx2LNvLr9DXLl2tPDGAsMJF8wtaxdMKc2bjo+fa7Y6sTYvvPJ/0hNvNi9wUyOqAtpHYS/bM3LZilqTkfcq7utqraq7/YQZTOoBkZvq5Gv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7O2QKD4eUSDM39Qp1w6sItlxpglHopZuQvM+7z0nLg=;
 b=nA1P0j+FJiph5bs44FOPnxlN/LjeyWjHg3k+VRF5AFGbNupukvYUU67ckAqqVZw4tyCci1JQOWYkQSQuX5U5lXcCThzA+5Z5zdIfuisIxrpXO5DqqNsubVAAyAmBSWgTSR+4cTCMem3VCpVqFU7V7wNx8KcmiXY1Vv9vnFae1qbiQxXjpxHdDWdyYOibk+TJ5Vc2GzTP4UnUHA8460FlzJV+NLwK547otBnLBrTl47Fz8Qsm9YqvYGVUU4twZaKTo9XNpAqJzAgRNOqaEPrc2ujME06DqtuMprhyI3GKAs2eXceZxOZ8N7Q03QioSScRBvstDyMzoMk1HCX6hwZJ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7O2QKD4eUSDM39Qp1w6sItlxpglHopZuQvM+7z0nLg=;
 b=pQw2+l93NaEstULiprzyqphugmCt2m0rqKPkmC5lrO/h/y54akdyoACqAcXgiKXl+bKh9mDvgKMDJHt2OhOW3t5aiLz/QyKLPjZdA55rvn5WtNBKHjI8jgAnkXfRP9eonp7LzRJpsm+eeeb0SJzrDnB8MhjE69Ki/vOfg0iKIkI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2396.namprd12.prod.outlook.com (2603:10b6:907:9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Mon, 16 Mar
 2020 13:50:03 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 13:50:03 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/19] drm/amd/display: Fallback to dmcub for psr when dmcu is
 disabled
Date: Mon, 16 Mar 2020 09:49:11 -0400
Message-Id: <20200316134920.2526155-11-Rodrigo.Siqueira@amd.com>
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
 15.20.2814.14 via Frontend Transport; Mon, 16 Mar 2020 13:50:01 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e38a063c-1ab4-4d1b-bb4f-08d7c9b0ecf0
X-MS-TrafficTypeDiagnostic: MW2PR12MB2396:|MW2PR12MB2396:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2396E5B504F2A42770F023EB98F90@MW2PR12MB2396.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(7696005)(6916009)(5660300002)(54906003)(26005)(36756003)(52116002)(1076003)(86362001)(66556008)(4744005)(66946007)(66476007)(8936002)(6666004)(81166006)(81156014)(316002)(478600001)(2616005)(16526019)(2906002)(956004)(4326008)(8676002)(186003)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2396;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqFduqsfDZjrKD1Gly/ZANDbZf2DbaZIS+S/8vPHJBTBtkCRf0yAX5DIerdYzINf1jsT8czfY75lOnowDU/CL+qlihVTFYfazXUNdxBLBEHAo1lnzpVxCYqwPyuXeKM8e9STkqTG71iYSjlb+bqwKnp9SwZZU/YSZkz/+u8uXDjFL2yDmf7Z/YPybVxYD7w7eAnFOa+TDu/2tW2dmJ4jtB+aHmoVFbX5dMDgEfaluB9944pkiLKevjDgHnNfwppNkIpUgWLog0+7scasaUn6u/jRJBvu46XSgSFnzGSjNSnQb6Ck43gXPtmULjZLwZZFzJIvj2By3gwewvT8JTeW22WKDCN751wQERoOKR7I4p+tNUrGQwXGexXklNGNbw2XrZpV9heGpyRUPgL3YiHc66rR3mKQTq/WDj5xbXyodGMz1G33Ttqy1u9V9jiwr7m9
X-MS-Exchange-AntiSpam-MessageData: GBa/0z0jHf4ABljC7BMAhgrD+A17Qi6MGN8w4SHeqqDVNS368Id0ISXihSaUhl1cXuPGgiFr6DttuJEg59yf2JJuDU/57OEswIHWTLobOuPyQKe3HnRt2qoyACyeczV6d4u8oNl08gdf7PNa6yN5yQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e38a063c-1ab4-4d1b-bb4f-08d7c9b0ecf0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 13:50:03.1446 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8SqAlwrBjC8kBkSl6reVMpyncT07os3G5KGngvqeYgTinoSddltkCeOg1UB2jL/cDL6x88/fipkooithAHV0qQ==
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
We want to be able to enable/disable psr on dmcub and fallback to dmcu
when necessary.

[How]
Use dc config option to do so.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 37f9a71eb4c1..51b5910cd05f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1864,7 +1864,7 @@ static bool dcn21_resource_construct(
 		goto create_fail;
 	}
 
-	if (dc->config.psr_on_dmub) {
+	if (dc->debug.disable_dmcu) {
 		pool->base.psr = dmub_psr_create(ctx);
 
 		if (pool->base.psr == NULL) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
