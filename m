Return-Path: <SRS0=ENO8=65=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D726C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D26520657
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2020 18:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="m3W/ecfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D26520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E416ECFF;
	Fri, 15 May 2020 18:13:42 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760053.outbound.protection.outlook.com [40.107.76.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C796E193
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2020 18:13:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzdRS3tYTaUcc31ieuESXcAGC/0xXV18NWG2Cx2uHbdlqi8VEb8eI9svU3nDRtpGUlMxmMikFCGQEyQn5ww+HrsaZNwlszwWJDg2GmQXDz/6a8LI6yD8OIQVyDviXD6GvhZQZ42U9zUc7qdNjJC/Gty6/MlgtB0ldXpasFF6dd0+gx33K3ZJ26kWTuxF9MucJHmzM9WTwOpc9wW/FHWhtSZ4MwpiNvfwSfEXc0yM1pw/hkpCZvMVmNrctkn5iXa+Mm2CyPBMcbGZeeJCnMI3lBmYezdAmw0RuMJ+GkgWoRHJo2/pIve1II6iX80mP2WxcAik6ffnUwJFIhNeceNVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTCjGAarx/sRCsSxtXWHtuP8Gi0awW5EZWJUBbfj48c=;
 b=MFLsK7I6enA6Y6Gwc/IZJNVQnW5iguDBhiULMLeWJF6nwVzZacSjpey2AnHhwzpdhpzWaDM5H4os2tVHBzCMM1y2AKrJ3tnGQKgLk6UwqaNzbFR3fZZLV7MMYQzc3jy+mSNYZHqE9niplZF5RXI26bZjuU8shVJxTd9niygsyxLYf7XOoR53hh+3BKL4bwm7cD15I2LZXDgvQGkhqOdpvD8XcyNfFlCru4JoCvOQpKRYIHC8tbhInbWYX/J28+mNnGPQsDr/sicMGBmD+iC5rjpjx2H4u8S/VQtuJzQ7okn9oEB761QmmZBh0FNRSf95HtmaFLAqb4LYOproW56Pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTCjGAarx/sRCsSxtXWHtuP8Gi0awW5EZWJUBbfj48c=;
 b=m3W/ecfg8hVxixutzRVste6oB2crwi/9CzAtBXl89vASkosaGjukhdVdD1Ul7kh8/QBMJGR0NyFVCa6Mpts/eQ0MaT9k068Aoc0CIR9IibJuSnj5QvSy08jaUBL6YoiD4c/TQ9EeOZqdGZ+wA3lMtZLBD6loET2Ak2yJc1cfU9k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 15 May
 2020 18:13:38 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 18:13:38 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/27] drm/amd/display: Minimize DSC resource re-assignment
Date: Fri, 15 May 2020 14:12:48 -0400
Message-Id: <20200515181315.1237251-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
References: <20200515181315.1237251-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN7PR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:408:20::47) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 18:13:37 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ddb64504-cb93-4a26-2adf-08d7f8fbb097
X-MS-TrafficTypeDiagnostic: CH2PR12MB3848:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3848F0E4C720EDBEE7A145DE98BD0@CH2PR12MB3848.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HF44Y6eNJaD2SLW2APQBI09eTty+Jbf7VnbXeDnnw1nn+mBeJe9JcOKlGuCjt0gvPmMveY0iLcbNUTlBCPQhyG1THeT3Wt9WvGEqn2eGREhIL3W8Nx19i5SPffjXRrEHjQ8uCXlyUkrQYFHNINT5pr7mHrYcJYQOyyIYfhsdrNLE5pGDQnNC9/WJtf5IVbO7mo4WlF2mTstqEjhIYDmwQi5jHLw+FiRz9pe7RY+2A0duwDkrok1mAdUJgUcvjwn10Gktzq4RW6vmbghiAg2vpFwxUrTJvvRzyEiFu+yqFOY3zPMaiF3dJrqoxSCO/+i96UMv8FZGg8LYLASoJKCV5K3NByMH91fqhiIt4uPFNeM7IQUA1UXPiJ3sJfu9zmDB5lFpA+WYdrTfY+wLi3XeT0ja1gkY9etiy9NP1CEJmoLCt0usyEwyyHM4QP+KYcsk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(86362001)(2906002)(186003)(8936002)(52116002)(6506007)(6512007)(8676002)(36756003)(316002)(5660300002)(16526019)(4326008)(6916009)(66556008)(478600001)(1076003)(66946007)(6486002)(66476007)(6666004)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: c3+APQogDedGW8gbi8c5NF1R1swjMRVQGuOD5HYiFqxW0K53iYoUGzAxSoNoyoq9yIs0ADyjGpHvK1YZVaIbR0wmh28/mW/nSoQARuvThcIVRgTCfnbzWifZ8ecCqutXjlguptZZqNMuZauVNG+Lwb00ECIsFbWITF+pxXA9+SYQ3BPuoA1gJcq0Ep3OCzReiDASVvtO28TeB/GBsITSuhYgv3qcSNLIDjeTdiBC0N6DoOD1h3NTYd4TTnSPzPxHYeg2oC+tWV9xdwjfpu/Vj6FZoqz/X5Rase9xP3gyK0RsfTR1cnfhLm2eCqcoeBIYGm6ToJ4NI/kDPEcpNnbnINC0OGRNpXBVvCm+ydYUza91snsoCogg12tun/j3XmaGmWkmbQRSezKyp66AX5wMuxDi81iAmNaZ7fdVpIwbnxnntoQa8QEe7ctXdUsycq/W+weBoaLQtnTklkcBjU76g9LXLvpzKuo6JHeG8VSN1pql/4ritFotPa5tp0w/QSzFXcvsdryftVUqF5UjOu3KVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb64504-cb93-4a26-2adf-08d7f8fbb097
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 18:13:38.1641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3qG36uuqli5bSt1r87PoEyMox6NPJi7IBiZyTvhCTiAqzFeiixNLfUlOY7MKOdFuTzv9i5Xmjn6bETo+6aDWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3848
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
 Nikola Cornij <nikola.cornij@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nikola Cornij <nikola.cornij@amd.com>

[why]
Assigning a different DSC resource than the one previosly used is
currently not handled. This causes black screen on mode change when more
than one monitor is connected on some ASICs.

[how]
- Acquire the previously used DSC if available
- Make sure re-program is triggered if new DSC is used

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Nikola Cornij <nikola.cornij@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  3 ++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 28 +++++++++++++------
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |  2 +-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index cb5d11f11cad..bbef8c67d1db 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2666,6 +2666,9 @@ bool pipe_need_reprogram(
 		false == pipe_ctx_old->stream->dpms_off)
 		return true;
 
+	if (pipe_ctx_old->stream_res.dsc != pipe_ctx->stream_res.dsc)
+		return true;
+
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 778e2e8fd2c6..4912160f81b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1663,22 +1663,32 @@ enum dc_status dcn20_build_mapped_resource(const struct dc *dc, struct dc_state
 }
 
 
-static void acquire_dsc(struct resource_context *res_ctx,
-			const struct resource_pool *pool,
+static void acquire_dsc(const struct dc *dc,
+			struct resource_context *res_ctx,
 			struct display_stream_compressor **dsc,
 			int pipe_idx)
 {
 	int i;
+	const struct resource_pool *pool = dc->res_pool;
+	struct display_stream_compressor *dsc_old = dc->current_state->res_ctx.pipe_ctx[pipe_idx].stream_res.dsc;
 
-	ASSERT(*dsc == NULL);
+	ASSERT(*dsc == NULL); /* If this ASSERT fails, dsc was not released properly */
 	*dsc = NULL;
 
+	/* Always do 1-to-1 mapping when number of DSCs is same as number of pipes */
 	if (pool->res_cap->num_dsc == pool->res_cap->num_opp) {
 		*dsc = pool->dscs[pipe_idx];
 		res_ctx->is_dsc_acquired[pipe_idx] = true;
 		return;
 	}
 
+	/* Return old DSC to avoid the need for re-programming */
+	if (dsc_old && !res_ctx->is_dsc_acquired[dsc_old->inst]) {
+		*dsc = dsc_old;
+		res_ctx->is_dsc_acquired[dsc_old->inst] = true;
+		return ;
+	}
+
 	/* Find first free DSC */
 	for (i = 0; i < pool->res_cap->num_dsc; i++)
 		if (!res_ctx->is_dsc_acquired[i]) {
@@ -1710,7 +1720,6 @@ enum dc_status dcn20_add_dsc_to_stream_resource(struct dc *dc,
 {
 	enum dc_status result = DC_OK;
 	int i;
-	const struct resource_pool *pool = dc->res_pool;
 
 	/* Get a DSC if required and available */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1722,7 +1731,7 @@ enum dc_status dcn20_add_dsc_to_stream_resource(struct dc *dc,
 		if (pipe_ctx->stream_res.dsc)
 			continue;
 
-		acquire_dsc(&dc_ctx->res_ctx, pool, &pipe_ctx->stream_res.dsc, i);
+		acquire_dsc(dc, &dc_ctx->res_ctx, &pipe_ctx->stream_res.dsc, i);
 
 		/* The number of DSCs can be less than the number of pipes */
 		if (!pipe_ctx->stream_res.dsc) {
@@ -1850,12 +1859,13 @@ static void swizzle_to_dml_params(
 }
 
 bool dcn20_split_stream_for_odm(
+		const struct dc *dc,
 		struct resource_context *res_ctx,
-		const struct resource_pool *pool,
 		struct pipe_ctx *prev_odm_pipe,
 		struct pipe_ctx *next_odm_pipe)
 {
 	int pipe_idx = next_odm_pipe->pipe_idx;
+	const struct resource_pool *pool = dc->res_pool;
 
 	*next_odm_pipe = *prev_odm_pipe;
 
@@ -1913,7 +1923,7 @@ bool dcn20_split_stream_for_odm(
 	}
 	next_odm_pipe->stream_res.opp = pool->opps[next_odm_pipe->pipe_idx];
 	if (next_odm_pipe->stream->timing.flags.DSC == 1) {
-		acquire_dsc(res_ctx, pool, &next_odm_pipe->stream_res.dsc, next_odm_pipe->pipe_idx);
+		acquire_dsc(dc, res_ctx, &next_odm_pipe->stream_res.dsc, next_odm_pipe->pipe_idx);
 		ASSERT(next_odm_pipe->stream_res.dsc);
 		if (next_odm_pipe->stream_res.dsc == NULL)
 			return false;
@@ -2792,7 +2802,7 @@ bool dcn20_fast_validate_bw(
 			hsplit_pipe = dcn20_find_secondary_pipe(dc, &context->res_ctx, dc->res_pool, pipe);
 			ASSERT(hsplit_pipe);
 			if (!dcn20_split_stream_for_odm(
-					&context->res_ctx, dc->res_pool,
+					dc, &context->res_ctx,
 					pipe, hsplit_pipe))
 				goto validate_fail;
 			pipe_split_from[hsplit_pipe->pipe_idx] = pipe_idx;
@@ -2821,7 +2831,7 @@ bool dcn20_fast_validate_bw(
 				}
 				if (context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_idx]) {
 					if (!dcn20_split_stream_for_odm(
-							&context->res_ctx, dc->res_pool,
+							dc, &context->res_ctx,
 							pipe, hsplit_pipe))
 						goto validate_fail;
 					dcn20_build_mapped_resource(dc, context, pipe->stream);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
index d5448c9b0e15..ed5d31253314 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.h
@@ -136,8 +136,8 @@ void dcn20_split_stream_for_mpc(
 		struct pipe_ctx *primary_pipe,
 		struct pipe_ctx *secondary_pipe);
 bool dcn20_split_stream_for_odm(
+		const struct dc *dc,
 		struct resource_context *res_ctx,
-		const struct resource_pool *pool,
 		struct pipe_ctx *prev_odm_pipe,
 		struct pipe_ctx *next_odm_pipe);
 struct pipe_ctx *dcn20_find_secondary_pipe(struct dc *dc,
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
