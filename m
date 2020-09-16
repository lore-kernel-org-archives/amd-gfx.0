Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CB1C35257
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CBC208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AAhLTyTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CBC208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E9EC6EB07;
	Wed, 16 Sep 2020 19:42:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D7DF6EAE3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn0pm0uLuuJV1EAnLn1w0uvL08d5QsS065EBUee+gbeVRHeVHfn2WFKviIqW3Lpp3AmMW1fqRWFFWDqHrsQS9OVm3WwRuUizhZ7hksmk/is/yTmFkyviMWLV/gwBFqfSjmaFTl15nV5BjEaHncEgn/79kT7cbf2+bVDCvN82z5qeoj/2Ywg1LaDqDmnYzEBXmtnm7ANz2zGIiD/kA1eKdFhgtsVrn9lQT4y7p+Fnr4Hfb6YwB27Rtvsa4hjwiYLV5vvcMWp1Y1aPrqrYUeEbbA5JtXT3SQV9yzIn08wjwphJw9Q/pTUrZircVoPYkaHhLTbrs5qWk9w+ovApz2tDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJWNpgCjV24DWPW5Dh3Z5pM+obqVPeFa2gO2X5TyRiQ=;
 b=OtaZUw448pddns28WOjt7ekb+BUofd7pQI9HdNUAhz0vNaEbPjHw0OUC1XKK2zHx03rOjmnw4YedxFbbel3Ym9tHima2lw50MVDTAzPEgzbeb79CN8+gcrQhyThz6bbYqUrqq4ZYXA2K5KulvKyKv+CzvrxgYWHowsOEqqNvZCMOEboMLO4YKAJx0DM4ojjjZXr1qolkh/N1KFM4YbkIL6xfWHT0egq1pDE6PaZr6oip7LEMg+kIfyMoKSgMSKZbjRO/AB/XueaSWTJ1gz7eukRZFeynFcV/9ohCNB2nIEXn+Sp2JCWPYkBskO7JeJzK3BaVjH9vhjBKulo+iMktIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJWNpgCjV24DWPW5Dh3Z5pM+obqVPeFa2gO2X5TyRiQ=;
 b=AAhLTyTlK7RYB23+ItzBJq6oDqrgCT4FtBqORlIrLPBZZX01QU/S3ArASo/DqtsZe3i/VhWog3aYjbk6+xrVsK/Hy8i2lquTwZBz6Ki7rFRmc2e3W+bEVUBz+p9d2sGNE3vu8me3OQh6pz9AeCWyY37rY2Tql4O8gLzDsY6jkcw=
Received: from DM6PR06CA0012.namprd06.prod.outlook.com (2603:10b6:5:120::25)
 by CY4PR1201MB0261.namprd12.prod.outlook.com (2603:10b6:910:1c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 19:36:41 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::71) by DM6PR06CA0012.outlook.office365.com
 (2603:10b6:5:120::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:41 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:40 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:40 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/15] drm/amd/display: Fix ODM policy implementation
Date: Wed, 16 Sep 2020 15:36:27 -0400
Message-ID: <20200916193635.5169-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6609fc84-afae-44fa-276a-08d85a77d629
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0261:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0261B01727528025A937169EFB210@CY4PR1201MB0261.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pa55VauPsel5ZStNCYoCO9SO26xtWf8cFAI0fR1grS8s7oRw85LD0h7C0bRkZlXme6Osja9/RzOTuDB3LzbDGSnQr94Lm+qUQEoyKEw1wqwhPGmp7aUEvNtb5FhjszoZbJ/v7/I5E/EEiYIXCdWV0TkdO6A+XI+Jx0O/jpg5wGwZw82bVgR8qWReJuL1d0upDpfSJ2qu3EZsTufYANKk3ZxHD+h2woGWCffMvewsYeoltNuvpSnLTkiJkJwZRjBJIoYRPleFatWJjp//NqdlDbderZiZkRAsR5/UBGeasHm5P0jX5byO0B9wsQMUGEHqc64nUMLRDdedW73wP6I/H1kyDMG+pFZyVg75EdwGE/1R2v2FSEIaT5Kqj+uKAXbg6uM6UEfAL17hnLLFXEN5J9uTjs7aeRI0WbwTaHp9FR5tVlEWtksVTRm3zs6A8I9P
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39850400004)(396003)(136003)(46966005)(426003)(86362001)(316002)(6916009)(2616005)(44832011)(5660300002)(36756003)(70206006)(54906003)(70586007)(1076003)(6666004)(4326008)(8676002)(478600001)(336012)(8936002)(26005)(82310400003)(82740400003)(186003)(81166007)(83380400001)(47076004)(356005)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:41.2605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6609fc84-afae-44fa-276a-08d85a77d629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0261
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, stable@vger.kernel.org, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wesley Chalmers <Wesley.Chalmers@amd.com>

[WHY]
Only the leftmost ODM pipe should be offset when scaling. A previous
code change was intended to implement this policy, but a section of code
was overlooked.

Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Cc: <stable@vger.kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 4cea9344d8aa..e430148e47cf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -785,14 +785,15 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	/*
 	 * Only the leftmost ODM pipe should be offset by a nonzero distance
 	 */
-	if (!pipe_ctx->prev_odm_pipe)
+	if (!pipe_ctx->prev_odm_pipe) {
 		data->recout.x = stream->dst.x;
-	else
-		data->recout.x = 0;
-	if (stream->src.x < surf_clip.x)
-		data->recout.x += (surf_clip.x - stream->src.x) * stream->dst.width
+		if (stream->src.x < surf_clip.x)
+			data->recout.x += (surf_clip.x - stream->src.x) * stream->dst.width
 						/ stream->src.width;
 
+	} else
+		data->recout.x = 0;
+
 	data->recout.width = surf_clip.width * stream->dst.width / stream->src.width;
 	if (data->recout.width + data->recout.x > stream->dst.x + stream->dst.width)
 		data->recout.width = stream->dst.x + stream->dst.width - data->recout.x;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
