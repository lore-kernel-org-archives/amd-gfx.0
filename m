Return-Path: <SRS0=Inwe=AH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38FBC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF36206BE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2020 16:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gZZEFqvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF36206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731406ECE2;
	Fri, 26 Jun 2020 16:20:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 302E56ECE1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2020 16:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzhc8yQ/mq6iadR3Cr5UpZUz7B+oj+fH6a6LpO4G/KnG2KEzIxF1poRj28weOnyDEP6ceiIwgB5OD+EDC3cndUD/VMNbRzEraGAWBy5eChUSq1SaJ5bqayLMKyhWoGChrXGIBwtiJnpejEzgnsb0I3QaZGApQItIIyXb4LT1OLFyQBrhFyVawjxCYrZWQhLVIQD9L6a1rC1xdvOP7wufyvC8EO0R7yRPXatgcsJgVe2JE79bDqGp3hhj3Kus9agrgE1icuesESdOsysZK6Z4ZLXOhBl35Yv8549/H7DwAzv74urA9YRyGqXYmpGfu/4RmMWM5fKizrpNpVrrH6+w1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nH0AEPbpqXo+DyEA0ZEu1WB8Dm2nsVCUisX58SIu1bY=;
 b=EpxvQ8BoS4HhT+jk7WP8wjHlkAwbM+OqUK+9f2jpoHcejhjWwaOW06UiFuYdLh0y4ITUn8lWblaHEYYi0KqciNWpnYjmiha+Pc+Yo3r70QNhjngZv21+Uiu1QzjsYdCx+fmuah7MSOWurZNTWmuv0oxiqxX4wCeBRzfuIvNxVc3vb245x4EB/vYlsLAPkibKd5rutWBB4MY4+GUrVa5N0l0LnmY1wBo9e2M/2egfrjWB090+lNO45VOXAvlmKS0rw3iaLMl9+LoIYRRG4QO+QcmBBnlsevFZMET7dAlYRNziC0cyewO2yCkNByJGEzVTNuZI5WD1F6YOD1nv+Wt1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nH0AEPbpqXo+DyEA0ZEu1WB8Dm2nsVCUisX58SIu1bY=;
 b=gZZEFqvDq5B6pbDcTndgugsF9nsAywZnu1tYdrdW773X+YXOlpvdezsEwh9jx0AP+huAo/PGw84uGdeO9VTMK4+YSpkXxNM9ll7H58TvZDwCYGtKb61ewWhTKRVKTRfbIujKYTTAFcMCjcYFtg9rBxbjmA+TsEVUdA7OYvoynTg=
Received: from DM5PR1101CA0019.namprd11.prod.outlook.com (2603:10b6:4:4c::29)
 by SN6PR12MB2768.namprd12.prod.outlook.com (2603:10b6:805:72::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Fri, 26 Jun
 2020 16:20:00 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::35) by DM5PR1101CA0019.outlook.office365.com
 (2603:10b6:4:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23 via Frontend
 Transport; Fri, 26 Jun 2020 16:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3131.20 via Frontend Transport; Fri, 26 Jun 2020 16:20:00 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:59 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jun
 2020 11:19:59 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 26 Jun 2020 11:19:59 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amd/display: Enable 4 to 1 mpc combine for max
 detile use
Date: Fri, 26 Jun 2020 12:18:47 -0400
Message-ID: <20200626161847.16000-12-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626161847.16000-1-eryk.brol@amd.com>
References: <20200626161847.16000-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966005)(1076003)(5660300002)(186003)(336012)(426003)(54906003)(8936002)(316002)(83380400001)(44832011)(2616005)(36756003)(8676002)(2906002)(82740400003)(478600001)(4326008)(70586007)(47076004)(82310400002)(6916009)(86362001)(356005)(70206006)(26005)(6666004)(81166007);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fc3b575-4d69-4444-86f2-08d819ecc660
X-MS-TrafficTypeDiagnostic: SN6PR12MB2768:
X-Microsoft-Antispam-PRVS: <SN6PR12MB27684E6C8FA9DE23669F1839E5930@SN6PR12MB2768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbgMEPpsoZvhvGEwoocU1DuhYhJEnPxUBUk0hrJmTMdAyR+BJ5D2ryuZMdwJYWJUYJsOB7JU6jRe3/DKQD7rKI6kn3A2k9VHMe1qYwpVdrGe4D0e0zkd5iUU6BjkbeyNM6bIjNXrrc6pDggmQY/sdJ7x8WMd+RHAaWW2UKPXkXO7C/jZkGXwswjV+EUCmZ1LL8NTjqYixRdbTvJb9vZGAKme2BJxHEdOYqIL6VP5rKmKcoIyHD1a0YN/8xCP648FCtFrftPZ5z/+aDUYDImko5qs/+T/Cx4uJXmm3Jm/LMm89er6CNs/cjiczQt4lL2vGqXYxowFwfwon8DOx7k/Q/QsVPPXZ3MVzhmD22clSRh2OywmTQ1p2zsI+gRIets2l9gq+zlqFsANxKjtXXdKDQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 16:20:00.3276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc3b575-4d69-4444-86f2-08d819ecc660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2768
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
Cc: eryk.brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Eric Bernstein <Eric.Bernstein@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

In case of certain display configurations we want to allow max detile
buffer utilization by using 4 to 1 mpc combine

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Eric Bernstein <Eric.Bernstein@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 0983bcc25117..e226647088b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2102,11 +2102,20 @@ int dcn20_populate_dml_pipes_from_context(
 		if (res_ctx->pipe_ctx[i].top_pipe && res_ctx->pipe_ctx[i].top_pipe->plane_state
 				== res_ctx->pipe_ctx[i].plane_state) {
 			struct pipe_ctx *first_pipe = res_ctx->pipe_ctx[i].top_pipe;
+			int split_idx = 0;
 
 			while (first_pipe->top_pipe && first_pipe->top_pipe->plane_state
-					== res_ctx->pipe_ctx[i].plane_state)
+					== res_ctx->pipe_ctx[i].plane_state) {
 				first_pipe = first_pipe->top_pipe;
-			pipes[pipe_cnt].pipe.src.hsplit_grp = first_pipe->pipe_idx;
+				split_idx++;
+			}
+			/* Treat 4to1 mpc combine as an mpo of 2 2-to-1 combines */
+			if (split_idx == 0)
+				pipes[pipe_cnt].pipe.src.hsplit_grp = first_pipe->pipe_idx;
+			else if (split_idx == 1)
+				pipes[pipe_cnt].pipe.src.hsplit_grp = res_ctx->pipe_ctx[i].pipe_idx;
+			else if (split_idx == 2)
+				pipes[pipe_cnt].pipe.src.hsplit_grp = res_ctx->pipe_ctx[i].top_pipe->pipe_idx;
 		} else if (res_ctx->pipe_ctx[i].prev_odm_pipe) {
 			struct pipe_ctx *first_pipe = res_ctx->pipe_ctx[i].prev_odm_pipe;
 
@@ -2258,7 +2267,7 @@ int dcn20_populate_dml_pipes_from_context(
 					|| (res_ctx->pipe_ctx[i].top_pipe && res_ctx->pipe_ctx[i].top_pipe->plane_state == pln)
 					|| pipes[pipe_cnt].pipe.dest.odm_combine != dm_odm_combine_mode_disabled;
 
-			/* stereo is never split, nor odm combine */
+			/* stereo is not split */
 			if (pln->stereo_format == PLANE_STEREO_FORMAT_SIDE_BY_SIDE ||
 			    pln->stereo_format == PLANE_STEREO_FORMAT_TOP_AND_BOTTOM) {
 				pipes[pipe_cnt].pipe.src.is_hsplit = false;
@@ -2721,12 +2730,11 @@ int dcn20_validate_apply_pipe_split_flags(
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
 
-		if (force_split || v->NoOfDPP[vlevel][max_mpc_comb][pipe_plane] > 1) {
-			if (split4mpc)
-				split[i] = 4;
-			else
+		if (split4mpc || v->NoOfDPP[vlevel][max_mpc_comb][pipe_plane] == 4)
+			split[i] = 4;
+		else if (force_split || v->NoOfDPP[vlevel][max_mpc_comb][pipe_plane] == 2)
 				split[i] = 2;
-		}
+
 		if ((pipe->stream->view_format ==
 				VIEW_3D_FORMAT_SIDE_BY_SIDE ||
 				pipe->stream->view_format ==
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
