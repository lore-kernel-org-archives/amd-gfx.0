Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6698BC388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC62C2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uw+zpRvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC62C2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB6736EDCC;
	Wed, 21 Oct 2020 14:23:23 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A7F36EDCC
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYD3iGC31vd1FZZ2/FbtQObMKIie9jUVaxsDEn2zZ5R5wMgw5pLkIuOukkyis8uMr+jygZIMYsvgqUeKNl/Or4bQ97En38DLvnoUO+EsNp8tNcDssSQNzLxSyVg/gV+WDirsp6skC5LpijxUcHBdLc4yeQC7cX6b+rvyBGP+Do6Chq6SvALddX8SUJ/htiKO/Em8jQshlwaMOn5XY0ebxi/W0rgcqpp8/JFsHi/IjeywJSqfTqIUKP7l4NUKGLoKoCrCz8dsInUNGdfcKkjppWeXQNAD2L39xUstXTIeo/53wXqBcDXmNLK6rGsxww2DYQGh/NU5ifuWvJibdOOVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmXiKZtiQQ/jeYVWbWKUtJZymL1Syl4pMvYfpt1I4uw=;
 b=B2IAfe2yk2Ue/p1EaBB67mm/XSiy4FpzceRkfpBWEOvlmUTxvhlnH0++bsL7TkjTI4Q22XNwaRfgVJJMxwC5Rk8iEmBUVnMggbVQ8RrYqn8H2vyEi/MyyajXqRau+hW1/QozxKtYPAvwWUGmYIIUolzDLwbpGES75HWSriOHhHUm4KrJHWsz5H+cK5+BAsiLLM30qPoHwhEKJEHYJ8J2Wwx5LdUIKHdHy0LHlI26gxBkd22DMELkbtm4SNPhacrAG3Ytz/0HocNNOBt8KR9DFZRc7yIPZWZeIuz9tER/hrXZmv9OVSla2teDvOCujbv5tM1B5fFVUEbc7/f01TYzNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmXiKZtiQQ/jeYVWbWKUtJZymL1Syl4pMvYfpt1I4uw=;
 b=uw+zpRvLL9g1q8/RZeA3mj+WNdT6Hq+J7CHA/4th5yLGzRmHB9RYAsNOJSMfwBcR3Ir6Mj0Arb2iVCIwiYP1qlvIdpGh+ncfV0D2KZBCsVqMnYpx4uRe87Zay+PrEBuSobe0XasAt2nWiPiQTjwKE5QlBEPsQ4S55TfBuJlXHp4=
Received: from DM5PR12CA0007.namprd12.prod.outlook.com (2603:10b6:4:1::17) by
 BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.20; Wed, 21 Oct 2020 14:23:21 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::a7) by DM5PR12CA0007.outlook.office365.com
 (2603:10b6:4:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:20 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:20 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:19 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/33] drm/amd/display: Don't trigger flip twice when ODM
 combine in use
Date: Wed, 21 Oct 2020 10:22:44 -0400
Message-ID: <20201021142257.190969-21-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f5c8853-ea3c-4f23-6af7-08d875ccdcc4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4659:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4659594DBFA127EA7C89D0378B1C0@BL0PR12MB4659.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:207;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZzJSyF8DdmGp1i94OgTCq8cCkBVKS/myDYWcUB64totMzl4tOuNjBSLiOQlKok4CywQ2u7z66zzuY+qmyFfkWxThqOnQZ/j9gBEabdcESI/Df9RwzV/Npikgu73AZNvKmZ7w87xszbqHId/SL1ozmP0fZ2EVRZwTSXovBiuBH6qhyDJZQp4DMktyz/6xgcpRVgN+4KpsMZuY9QnhZlaGgBDGSdpte6btf1dEo467JVi7BVA8um5+Nb8MaXdLF+rRCM6w1T0CcSKcfEFjqXQAgcSf/n/ZIYjFfHNgssGzhzjyjOJB0mbohUTHGVcOPNSCGEhGz01Fen6YeqjHwcaCqm4viy6oBnlAiKiZHcZQuGfIPeBi/BU3Sg7yJ91VKAROd0FZrj7/bh6oNTSytafi8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(46966005)(82740400003)(336012)(26005)(478600001)(7696005)(86362001)(186003)(5660300002)(54906003)(2616005)(1076003)(316002)(426003)(82310400003)(2906002)(356005)(6666004)(83380400001)(47076004)(8676002)(81166007)(6916009)(4326008)(8936002)(44832011)(36756003)(70206006)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:20.9643 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f5c8853-ea3c-4f23-6af7-08d875ccdcc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4659
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
When ODM combine is in use we trigger multiple update events causing
issues with variable refresh rate.

[How]
Only trigger on a single ODM instance.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f188af1b310a..166dbaa251e9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2627,9 +2627,8 @@ static void commit_planes_for_stream(struct dc *dc,
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
-		if (pipe_ctx->bottom_pipe ||
-				!pipe_ctx->stream ||
-				pipe_ctx->stream != stream ||
+		if (pipe_ctx->bottom_pipe || pipe_ctx->next_odm_pipe ||
+				!pipe_ctx->stream || pipe_ctx->stream != stream ||
 				!pipe_ctx->plane_state->update_flags.bits.addr_update)
 			continue;
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
