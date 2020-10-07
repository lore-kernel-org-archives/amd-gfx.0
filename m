Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C17C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F247920789
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 12:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gar+cDFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F247920789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E0B6E8D9;
	Wed,  7 Oct 2020 12:42:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088046E8D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 12:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmZIYJgpBkapt8/BRwoiWGtRHbd1LeThuhxtqllfjxP1uzzOBj1dvn2vU/gCIJIyhx//tNcNszbz7CkiFUFKmGK+YnRbF6O/AcVfdFdOm9TdIw0qODvUaWRfTAM8QT3JFDm6sWVtq1zwICuo3Rvt4AAxnPpKXeoBOJ9duKzuE8i39BxnEiZR0NayGei2X61gZ6F7VjQENnv2x9mfsLA/eN94r1ntb5+GKVaZDB5lKO0UAXsZZkeHT97zUMpXd+yAN033e643pXw4AGyhPq3q1Qub4jzapguZHr2rOo0ibjW4csGZy4Yn/mepNhl82yjaX8UAjlL49mhKaHi3uzQ/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IuMhgKBLJJqaAuy8syMhxIR9XEK5tplBCAJfzpQ8Ag=;
 b=V21q48T/IEnz8fR6mNk1MrL0aENMvn/n5nKBuXYRbJTp3+zqz1cJVBefGYmlw4Tv+L7IQxcTGTj/H/To6Jh3I3vCfRVEIJ5QmXhN+s8OQyf4YR3F1eMes+M3vBgnwQadKu2b8KyRddy1qbsh7DbQeFP2KZJkqXUxsO20k0YYZ7uE/0EgQujX0JoB6DgIzDW90sUoV4fWNJJA56CMiiITmO0y3T4q+eW/1fu6DV0ACAZ6TXTD09VyoiVCBOL7c0pwN6rHff6HwyVryZD1qpExkOdLZf0sa2xMf/o/QYyTFH4lVfKm1WKRZVUkXKpjUwpsoXS9Nn2HvI3naBvTQTssBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IuMhgKBLJJqaAuy8syMhxIR9XEK5tplBCAJfzpQ8Ag=;
 b=gar+cDFAv49etqmegng97gNvNCYYTfMINS77BbsRi1eWV91KfKQjPgs7M3L4AZkTXpl7WmqzG0L6la2TkaYNU2N8dY+tHtqxX7iUD6lW5G2z/DSdN1t0+z0omVeCCd/mdk+pYJJ3laAZwJhPh5e5wte+U2Hz/ZuuwlwdP2iPG14=
Received: from CO1PR15CA0091.namprd15.prod.outlook.com (2603:10b6:101:21::11)
 by SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Wed, 7 Oct
 2020 12:42:30 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::d1) by CO1PR15CA0091.outlook.office365.com
 (2603:10b6:101:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Wed, 7 Oct 2020 12:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 12:42:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:28 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 7 Oct 2020
 07:42:28 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 7 Oct 2020 07:42:27 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/12] drm/amd/display: enable odm + full screen mpo on dcn21
Date: Wed, 7 Oct 2020 08:42:16 -0400
Message-ID: <20201007124224.18789-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007124224.18789-1-aurabindo.pillai@amd.com>
References: <20201007124224.18789-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85b4a47d-538a-4458-bcd1-08d86abe73f8
X-MS-TrafficTypeDiagnostic: SN6PR12MB4719:
X-Microsoft-Antispam-PRVS: <SN6PR12MB47194554AB3AC7AB4008D4EB8B0A0@SN6PR12MB4719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3D5018aRPp9MhUmYOZbkVrsGIUouGexC+wE4gAmOxw//pF1X6aztwfPWhqyMLmknWLERe+0XyQIc/MYwfXjjwtlFhM8Dw4kY0YLPGZ8DMMsdHcfgezf3QbZ0In8lP0pGoYbpIBFC/OefKcVpEv0Zbf4KvYungD8OsVTo1cGa16Hp76PJ9tVun8EP32idHd2GP9l2WcCxRoNAzIrWho9LmfnZF5ynr46o+rq6Z3gqOiuv/A6aSFGKmhP+Q1IU85bjscmnAZcoF0z7zotg911TI+SL2IOAA0LiA4IcOc4EAJ1itqG2Yu+0Ycg8lz2g7D8fbIOAyhJd/vPMbFWmbs4XWYbnTvjXUxp3oA40Dmmb+fmqF93gLFCr0VF9fLdRIy3Jrj2I7az/bm3ePFfhUHXDVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(376002)(136003)(346002)(46966005)(86362001)(44832011)(2616005)(1076003)(316002)(6916009)(54906003)(82740400003)(5660300002)(6666004)(47076004)(478600001)(8676002)(36756003)(2906002)(81166007)(356005)(8936002)(70206006)(70586007)(26005)(82310400003)(4326008)(83380400001)(336012)(426003)(186003)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 12:42:29.3387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b4a47d-538a-4458-bcd1-08d86abe73f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4719
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
Cc: Sung Lee <sung.lee@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[WHY & HOW]
Enable ODM Combine + Fullscreen MPO on DCN2.1
For lower power consumption in video use cases.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Signed-off-by: Sung Lee <sung.lee@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  8 ++++++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 14 +++++++++--
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 25 +++++++++++++++----
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 13 +++++++++-
 4 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f240576a87a2..75b6aee1d664 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1493,6 +1493,14 @@ bool dc_add_plane_to_context(
 			free_pipe->clock_source = tail_pipe->clock_source;
 			free_pipe->top_pipe = tail_pipe;
 			tail_pipe->bottom_pipe = free_pipe;
+			if (!free_pipe->next_odm_pipe && tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
+				free_pipe->next_odm_pipe = tail_pipe->next_odm_pipe->bottom_pipe;
+				tail_pipe->next_odm_pipe->bottom_pipe->prev_odm_pipe = free_pipe;
+			}
+			if (!free_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe) {
+				free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
+				tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
+			}
 		}
 		head_pipe = head_pipe->next_odm_pipe;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 01fa8de8ff86..2e613960516a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1882,9 +1882,16 @@ bool dcn20_split_stream_for_odm(
 		next_odm_pipe->next_odm_pipe = prev_odm_pipe->next_odm_pipe;
 		next_odm_pipe->next_odm_pipe->prev_odm_pipe = next_odm_pipe;
 	}
+	if (prev_odm_pipe->top_pipe && prev_odm_pipe->top_pipe->next_odm_pipe) {
+		prev_odm_pipe->top_pipe->next_odm_pipe->bottom_pipe = next_odm_pipe;
+		next_odm_pipe->top_pipe = prev_odm_pipe->top_pipe->next_odm_pipe;
+	}
+	if (prev_odm_pipe->bottom_pipe && prev_odm_pipe->bottom_pipe->next_odm_pipe) {
+		prev_odm_pipe->bottom_pipe->next_odm_pipe->top_pipe = next_odm_pipe;
+		next_odm_pipe->bottom_pipe = prev_odm_pipe->bottom_pipe->next_odm_pipe;
+	}
 	prev_odm_pipe->next_odm_pipe = next_odm_pipe;
 	next_odm_pipe->prev_odm_pipe = prev_odm_pipe;
-	ASSERT(next_odm_pipe->top_pipe == NULL);
 
 	if (prev_odm_pipe->plane_state) {
 		struct scaler_data *sd = &prev_odm_pipe->plane_res.scl_data;
@@ -1922,7 +1929,10 @@ bool dcn20_split_stream_for_odm(
 				sd->ratios.horz_c, sd->h_active - sd->recout.x));
 		sd->recout.x = 0;
 	}
-	next_odm_pipe->stream_res.opp = pool->opps[next_odm_pipe->pipe_idx];
+	if (!next_odm_pipe->top_pipe)
+		next_odm_pipe->stream_res.opp = pool->opps[next_odm_pipe->pipe_idx];
+	else
+		next_odm_pipe->stream_res.opp = next_odm_pipe->top_pipe->stream_res.opp;
 	if (next_odm_pipe->stream->timing.flags.DSC == 1) {
 		dcn20_acquire_dsc(dc, res_ctx, &next_odm_pipe->stream_res.dsc, next_odm_pipe->pipe_idx);
 		ASSERT(next_odm_pipe->stream_res.dsc);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index c5108029f75e..8a85e07935b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1205,6 +1205,26 @@ static bool dcn21_fast_validate_bw(
 
 	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
 
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *mpo_pipe = pipe->bottom_pipe;
+		struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+
+		if (!pipe->stream)
+			continue;
+
+		/* We only support full screen mpo with ODM */
+		if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
+				&& pipe->plane_state && mpo_pipe
+				&& memcmp(&mpo_pipe->plane_res.scl_data.recout,
+						&pipe->plane_res.scl_data.recout,
+						sizeof(struct rect)) != 0) {
+			ASSERT(mpo_pipe->plane_state != pipe->plane_state);
+			goto validate_fail;
+		}
+		pipe_idx++;
+	}
+
 	/*initialize pipe_just_split_from to invalid idx*/
 	for (i = 0; i < MAX_PIPES; i++)
 		pipe_split_from[i] = -1;
@@ -1235,11 +1255,6 @@ static bool dcn21_fast_validate_bw(
 		if (pipe->top_pipe && pipe->plane_state == pipe->top_pipe->plane_state)
 			continue;
 
-		/* We do not support mpo + odm at the moment */
-		if (hsplit_pipe && hsplit_pipe->plane_state != pipe->plane_state
-				&& context->bw_ctx.dml.vba.ODMCombineEnabled[pipe_idx])
-			goto validate_fail;
-
 		if (split[i] == 2) {
 			if (!hsplit_pipe || hsplit_pipe->plane_state != pipe->plane_state) {
 				/* pipe not split previously needs split */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 783a1d7ae7d3..060c2e65718a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1873,11 +1873,22 @@ static bool dcn30_split_stream_for_mpc_or_odm(
 			sec_pipe->next_odm_pipe = pri_pipe->next_odm_pipe;
 			sec_pipe->next_odm_pipe->prev_odm_pipe = sec_pipe;
 		}
+		if (pri_pipe->top_pipe && pri_pipe->top_pipe->next_odm_pipe) {
+			pri_pipe->top_pipe->next_odm_pipe->bottom_pipe = sec_pipe;
+			sec_pipe->top_pipe = pri_pipe->top_pipe->next_odm_pipe;
+		}
+		if (pri_pipe->bottom_pipe && pri_pipe->bottom_pipe->next_odm_pipe) {
+			pri_pipe->bottom_pipe->next_odm_pipe->top_pipe = sec_pipe;
+			sec_pipe->bottom_pipe = pri_pipe->bottom_pipe->next_odm_pipe;
+		}
 		pri_pipe->next_odm_pipe = sec_pipe;
 		sec_pipe->prev_odm_pipe = pri_pipe;
 		ASSERT(sec_pipe->top_pipe == NULL);
 
-		sec_pipe->stream_res.opp = pool->opps[pipe_idx];
+		if (!sec_pipe->top_pipe)
+			sec_pipe->stream_res.opp = pool->opps[pipe_idx];
+		else
+			sec_pipe->stream_res.opp = sec_pipe->top_pipe->stream_res.opp;
 		if (sec_pipe->stream->timing.flags.DSC == 1) {
 			dcn20_acquire_dsc(dc, res_ctx, &sec_pipe->stream_res.dsc, pipe_idx);
 			ASSERT(sec_pipe->stream_res.dsc);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
