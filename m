Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D82C55185
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E982076E
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 22:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DpokhzbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46E982076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 082D189E0C;
	Wed, 22 Apr 2020 22:08:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACCA989E0C
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 22:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuTtV8RGnM+F8w/mAemPKi2iQmzupYvdTIvu6vht/0nIZsalmIelesAf1X6iciRHnMKnlGd4eVR9EWvPOl+aK38dmNlm9GjcBVlA6jwdTUC6NG6wuB8guhgUcsjbXVkiKi4lN6ufeXqHeMnPRfZA1xzXJN6FBXHi7rbvEtog1T0aQrx0LmA4E5/Z07ZnLrP/sulN2C3Y5wAKHd8onJ3JeJMWKkcqIdR3EW77kCyHQMdqImT015Gxh8cZOWEYNWnZEM3bH1H9MoWWOXLz84nMlwTS7AKEsgpe7xtlLA+MnDrCjARWbeOI30kUht1pSKGsm+Dcpsevq+ZbijlzRd+t2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmY2npw9nRqey5W+QN3+sjLE7RwokVPDf5fjwFKtUgs=;
 b=k7RWK7IxhxAQ+ITz9dFyD76pGK739B0D9TGyuIiCKWb4yZ3a6ZvkseX30tiyaDpa/oX/pj4QVisjvEclZ6rlJ0o8LqAfGskLvLEAFbpOLSA94KB/gTG4Q99mjLSj1y3Ax8kKgFWozuh1saqGotRv6US9859rRcmQrzIaz4RHHkXLd+C4P0vXzVnfJ08aI4b2gWVElQNY532+7r4EbaE7V9HoIw6sq/6PA3j48FWvD6SRdJKKGcb2+RJ//kGZjSJv7r7+zDiUWnqMqdEYIvyI1xi3RxQbpfALHBeoZm+NR6Tqppjd5tKg8j4oCdopr6zlX79WgY14XQG9b9WXhTn7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZmY2npw9nRqey5W+QN3+sjLE7RwokVPDf5fjwFKtUgs=;
 b=DpokhzbIUw5QuKozepng18usO3vtD8GQP5o3+21ALJoB9h+kRZbjR5AfcsryRqMbTzAbmG0V4h1ecidaB9KUgsBHs88Ou9W0P67T0WdOtSg/HsXaSuZz7smdz/6gDJPZmV3li5L2ld9wDt3rPJI/kH5nvzdeFxkDxaQBM04aaj4=
Received: from MWHPR1701CA0020.namprd17.prod.outlook.com
 (2603:10b6:301:14::30) by DM5PR12MB1756.namprd12.prod.outlook.com
 (2603:10b6:3:108::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 22:08:20 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::30) by MWHPR1701CA0020.outlook.office365.com
 (2603:10b6:301:14::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Wed, 22 Apr 2020 22:08:19 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2937.15 via Frontend Transport; Wed, 22 Apr 2020 22:08:19 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 22 Apr
 2020 17:08:18 -0500
Received: from aes.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 22 Apr 2020 17:08:17 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/19] drm/amd/display: Fail validation if building scaling
 params fails
Date: Wed, 22 Apr 2020 18:07:54 -0400
Message-ID: <20200422220805.15759-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422220805.15759-1-aurabindo.pillai@amd.com>
References: <20200422220805.15759-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(396003)(346002)(428003)(46966005)(82310400002)(6916009)(70586007)(70206006)(81156014)(186003)(47076004)(8676002)(4326008)(81166007)(26005)(5660300002)(8936002)(36756003)(7696005)(316002)(356005)(54906003)(86362001)(1076003)(478600001)(336012)(2906002)(426003)(82740400003)(44832011)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66cb31ce-ec85-4315-ed94-08d7e709aa55
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:
X-Microsoft-Antispam-PRVS: <DM5PR12MB175679CBC2DF408BE9E2D5FE8BD20@DM5PR12MB1756.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-Forefront-PRVS: 03818C953D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4emH+6eyNTvXCeNho5VJ7kzgdQO3OcXQvSSVowJlWiPv0lLNBramTmCGq92mX/kkOSQMn1yCne7G1sM5VQ62JF/0GGYdB5YF1VcTKB2oU5+bgIG2hLwlistfxiesOkT9jUhPXABHUWIKKgNvfVWJ2PXnMrYhQITpHbzFcWAVISSpMRC6hX4aVBBk89RPLHnsxAMTKg0XjjGcOKmCwBVA6mh72qzs5QPqAszRNJBjEBKkwhxSkvJxiAJEONkotdMASbG5mnnaNOYZFFVX/MWY1kjqNfX6QoN79Q9ftoF/qyP9rv2WaM/jDBHTBwsqRNqMVKKh+ano/siQFGIWd2ONbptvLkbfdLqiRdV6Ems1r1Rs2ehhHuyk1Nf7r9Mon/B/DFowbqNUwWXXoDg2QuV78TkFQqKM8l/9zrNRMCPzMBUjesX9nSpIYgQCIej44TZ7eq/DtI1kaNv3lz+zAivwot5mrhJ1e0F4PuZY9m8VeJ+l8Lqyn0gptP7FuW7nVnO/F1YDsRy0byvNQWRzAi9nag==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 22:08:19.3085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cb31ce-ec85-4315-ed94-08d7e709aa55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Sung Lee <sung.lee@amd.com>,
 Rodrigo.Siqueira@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Lee <sung.lee@amd.com>

[WHY & HOW]
If building scaling parameters fails, validation
should also fail.

Signed-off-by: Sung Lee <sung.lee@amd.com>
Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c    | 16 ++++++++++------
 .../drm/amd/display/dc/dcn20/dcn20_resource.h    |  2 +-
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index f41fc322d50a..3a8a4c54738a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1936,7 +1936,7 @@ bool dcn20_split_stream_for_odm(
 	return true;
 }
 
-void dcn20_split_stream_for_mpc(
+bool dcn20_split_stream_for_mpc(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
 		struct pipe_ctx *primary_pipe,
@@ -1965,8 +1965,11 @@ void dcn20_split_stream_for_mpc(
 	secondary_pipe->top_pipe = primary_pipe;
 
 	ASSERT(primary_pipe->plane_state);
-	resource_build_scaling_params(primary_pipe);
-	resource_build_scaling_params(secondary_pipe);
+	if (!resource_build_scaling_params(primary_pipe) ||
+			!resource_build_scaling_params(secondary_pipe))
+		return false;
+
+	return true;
 }
 
 void dcn20_populate_dml_writeback_from_context(
@@ -2796,9 +2799,10 @@ bool dcn20_fast_validate_bw(
 						goto validate_fail;
 					dcn20_build_mapped_resource(dc, context, pipe->stream);
 				} else
-					dcn20_split_stream_for_mpc(
-						&context->res_ctx, dc->res_pool,
-						pipe, hsplit_pipe);
+					if (!dcn20_split_stream_for_mpc(
+							&context->res_ctx, dc->res_pool,
+							pipe, hsplit_pipe))
+						goto validate_fail;
 				pipe_split_from[hsplit_pipe->pipe_idx] = pipe_idx;
 			}
 		} else if (hsplit_pipe && hsplit_pipe->plane_state == pipe->plane_state) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index 9d5bff9455fd..578265ccbf5b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -129,7 +129,7 @@ void dcn20_release_dsc(struct resource_context *res_ctx,
 			const struct resource_pool *pool,
 			struct display_stream_compressor **dsc);
 bool dcn20_validate_dsc(struct dc *dc, struct dc_state *new_ctx);
-void dcn20_split_stream_for_mpc(
+bool dcn20_split_stream_for_mpc(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
 		struct pipe_ctx *primary_pipe,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
