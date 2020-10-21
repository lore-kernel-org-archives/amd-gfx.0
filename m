Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35434C56202
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAD752224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nP/UItqc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAD752224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 540006EDB9;
	Wed, 21 Oct 2020 14:23:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5501A6EDB4
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB+0lh4JrO7IsQ9HmBcl5OOKc7T7TWQ8me+QqjUgbO6utinPHbp17MdhCKp/ofR7OJ9eMA/KX2Axd3f3LBkMCz8YwXctxlzPZ3mSAEAvknUDNQJoFWjsWt2eodZAifdoke1hvRQ2uOAJcVenMZB8fbHzKFQ3jLAenG3iZeJOC+vTwWZO6cUFDDG/TzP8DWs9A+039aAZxJZsbSGEhlndEU82R1RFWroQyyv8MTXd+JKtmUGOlgQ13h5jDsbQ0jxszEP1jYXzAktg6mCjsne8rUQIWfJJr7Tfir1QGGRPqbn28xj6XDUpKB5tnZIjynQVweRxe9ap8XSISYkH4J9eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOCgr7Q9c8lyCZzVSbXlhVgpHZWes8psmC3YbWzV0Z0=;
 b=Bwkeh2U2XkJHZD1xxY+tduoXRgV2S94ppaZNVKkvQahZEvaInqq1VU/k+81ler7QMzokwPt0S/ELi5bJG/JooDCB+/NjAihpp+2QIt97vNSMgfd4f2r41k2KbS51cvHle/GczpNkQ+uy/m9aVlM45j0lnij8AM6AvjprTth5cC71ZwuOqYF6B2vJrHeJBRCLWtyIGeKrWNP3nM7+Aie/L0ghXwQBFhfk/wbIWIKlxQFBBUj/3YUwgJC5xv+CK8BTLbxiBlHv0qS5uTFEBqe+XbZlxA306Et/Z4p1f/Z2U/erteGv9NmWyWGdI74JMyRaserzjcX9/ytqfdsco+hzqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOCgr7Q9c8lyCZzVSbXlhVgpHZWes8psmC3YbWzV0Z0=;
 b=nP/UItqcgJym7eX+6o4O5jdnr2N8s+B3SOEWFX9E3hBWQc2JukU2qT1ojDy0//oeJqVjTnNlIpQThYFPy8MXuxEphPKZrA9eAzZ4Kg8Og1ieLN5NX/EJh7JvnbCy/Jd8d9tgAKGoUbFe+fwWOSYGxGyvL6b2YlM/36yHrtpQGqo=
Received: from BN1PR10CA0014.namprd10.prod.outlook.com (2603:10b6:408:e0::19)
 by CY4PR12MB1703.namprd12.prod.outlook.com (2603:10b6:903:122::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Wed, 21 Oct
 2020 14:23:01 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::f7) by BN1PR10CA0014.outlook.office365.com
 (2603:10b6:408:e0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:01 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:01 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:00 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:00 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/33] drm/amd/display: enable odm + full screen mpo on dcn21
Date: Wed, 21 Oct 2020 10:22:27 -0400
Message-ID: <20201021142257.190969-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49911518-f66d-4cc1-d5d6-08d875ccd12e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1703:
X-Microsoft-Antispam-PRVS: <CY4PR12MB170307577A0BE0EBFA0DAD528B1C0@CY4PR12MB1703.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DPQWfsOqdbziInQ2o5WQ+51kE2tn3pTbFzc+zIcznopOgjPpvb0fPEqat/BnG6Iit3p5aVhLMm1OYC5NMqBxwdUIwkXxRGruDJYzmWSrOgWh+KtDXzr7AoAu0oV2YIPrcFqawuhoRSMqrDZaD5f/2IlFY9VNUE4lDpA1SUJeywqzeIZ8/E3riWmz/JdqxQnUZ9rDrItt1xvUpOHtX2uL4VCpxpxfS3bO2dBih6pWj2xmlTEt/02mGMOyAzPhiq9g/Qh+U7Q73sMpkEGfXE28L2PtKEIzk7RfXBy9TlByUBjNyTfqyKi2dmyLjD63i2+cg48I51oBueGfucjD+4HhCUu/xpPI152JeQoWz+PI5Got1xEeYBZkDcpG+h+27NZh2WYuij9sF25DUA4ouf/Svg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966005)(44832011)(36756003)(426003)(2616005)(26005)(6666004)(336012)(316002)(86362001)(186003)(54906003)(2906002)(356005)(1076003)(70206006)(82310400003)(7696005)(478600001)(83380400001)(5660300002)(82740400003)(4326008)(8676002)(47076004)(81166007)(6916009)(8936002)(70586007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:01.5771 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49911518-f66d-4cc1-d5d6-08d875ccd12e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1703
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
index ab105f26b511..d49a8b3e5137 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1510,6 +1510,14 @@ bool dc_add_plane_to_context(
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
