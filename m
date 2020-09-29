Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0703C4743A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 20:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276AA206B5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 20:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tgfMJko0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276AA206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9BC6E147;
	Tue, 29 Sep 2020 20:43:20 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBCF6E04B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 20:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgDPq04f93nR9xMyTHoJHCA/E35OGz08Sizoi3CL4cYCgTrZCtTJc1TU8OrBvSTMvRQ55jjHrY+XgCjDCLNPu6+YtZG0oTfDY3dSvoybvzL48cHIuhnSWzYsjP6d5RNHGg45ie+14/+HayxJ70rPFfzRgG2UYmcuJIovolamFXKiUqpZ5yifHEqR+coaVdWg6EGMHYGP1GQlziXU3d0sjEl9v4zdxHh51knOrfwqeFVLh02E4VDcIF/IY6Lg44g2jxxfFwRLJstxBfvmPbjG4YCl9/6UZQIowF9d9ZOysMbnyda3mZvzV8faDb+rMvBVfHIZ9BFTSglUkstoc4r2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbLVADvXjGqNUWSg6mwoeZmSCPxkMOea/vtWAb0XxYo=;
 b=KCkxOsjozBDYUGmi9FksJXfEbwHrdkwUXx2mMO9kY1qlydNyXz8EgXaFT5DB28vZSrLslZHu8h+JoYd22deBnH8ZcBDMoNelRhalHGNaM+yRTP+yCMouFfSib7gXbjSVOSZdoOzyqjNxLS3c0/Iaf2YO9UBZ8uwm9MdNR/6msLvXhGCxEoIcEi4kzrn68vCSs5VW+Qaer/q0apclO456Lg/MYZoZo+7St0iJbfeEdns07CTqymiJX2X7xeQi71JeCeogsqyg+xmFI4yFYusKtgHtGvYxD/N7ogboysyBN4P9x/UC4+4HcntSKs3624Q95p5BT33tv3Noka/yJfBlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbLVADvXjGqNUWSg6mwoeZmSCPxkMOea/vtWAb0XxYo=;
 b=tgfMJko0BCUV+FZJVeTcitZDStrAgb538AvF9+dZVZ8MEif3j7lIAehRXrivqvpzyFYF78NyGIygDZ6l2+iLOJcTHv886zKpT1udrgXFnfpNAvVnvO6Wqh5czA1XG34VnExnpcCeRHDxwmAapxBbFNxpcpq4vuo3tlAwzsLfvG4=
Received: from MWHPR13CA0025.namprd13.prod.outlook.com (2603:10b6:300:95::11)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 20:43:17 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::c1) by MWHPR13CA0025.outlook.office365.com
 (2603:10b6:300:95::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.27 via Frontend
 Transport; Tue, 29 Sep 2020 20:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 20:43:17 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Tue, 29 Sep
 2020 15:43:16 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 29 Sep 2020 15:43:15 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: add pipe reassignment prevention code to dcn3
Date: Tue, 29 Sep 2020 16:43:13 -0400
Message-ID: <20200929204313.2050455-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95939745-a28b-4d25-0fd4-08d864b84b38
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-Microsoft-Antispam-PRVS: <DM5PR12MB243884F7AD2FB9DF8A1A3D03F9320@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJnVAAWpWWIoSeS1146QMaqbpXw+pKamTi3PAq0DpVCgUaIVyCJkyjL9IMiXYnxJ+XRINMRIyyBP7vECoQg2OwCNVl3AETdu5FxsyIyAQY3N8Dst/RMlKpxnNGXclDvuyuCLGUydO4MQ42BAB4WtZQeK2onMmUIpFv0dfAHbk0Tzl1/kJ/7fhMartZNvKjsE6vrltV9Ig/Mi2w9ejBlSbmsIMjyqB7QLq0zWWqB1ZW8p0hUhvByMdDMb/DM/UQoBVzIxDaat6LUNO2/5lf8YrUmUs8fWJ6wwUmsUMtpDi26ALGl8Njhu0rfFfqdiJtwwrnAmtg8qimrfc01ZC6m5JXQXD5jd/4ZwVMU9bRdL5ULBpE9As3xidAmyaIQZVKIqj4tjRZjxDvTrd7hADAg00Eum1xIxoMwwrxL9mulnPXWqFPWiqJ6rXQPLkaAPVmNK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(5660300002)(86362001)(70206006)(2906002)(6636002)(356005)(82310400003)(6862004)(7696005)(8676002)(8936002)(70586007)(316002)(37006003)(47076004)(54906003)(82740400003)(26005)(36756003)(478600001)(1076003)(426003)(186003)(4326008)(83380400001)(81166007)(336012)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 20:43:17.0071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95939745-a28b-4d25-0fd4-08d864b84b38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, rodrigo.siqueira@amd.com,
 nicholas.kazlauskas@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Add code to gracefuly handle any pipe reassignment
occuring on dcn3 hardware. This should only happen when new
surfaces are used for an update rather than old ones updated.

Fixes: f64d8ebe9ed2 ("amd/drm/display: avoid dcn3 on flip opp change for slave pipes")

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 61 +++++++++++++++----
 1 file changed, 49 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index c223f8af2084..24fb39a11e5d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1901,21 +1901,28 @@ static bool dcn30_split_stream_for_mpc_or_odm(
 
 static struct pipe_ctx *dcn30_find_split_pipe(
 		struct dc *dc,
-		struct dc_state *context)
+		struct dc_state *context,
+		int old_index)
 {
 	struct pipe_ctx *pipe = NULL;
 	int i;
 
-	for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
-		if (dc->current_state->res_ctx.pipe_ctx[i].top_pipe == NULL
-				&& dc->current_state->res_ctx.pipe_ctx[i].prev_odm_pipe == NULL) {
-			if (context->res_ctx.pipe_ctx[i].stream == NULL) {
-				pipe = &context->res_ctx.pipe_ctx[i];
-				pipe->pipe_idx = i;
-				break;
+	if (old_index >= 0 && context->res_ctx.pipe_ctx[old_index].stream == NULL) {
+		pipe = &context->res_ctx.pipe_ctx[old_index];
+		pipe->pipe_idx = old_index;
+	}
+
+	if (!pipe)
+		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+			if (dc->current_state->res_ctx.pipe_ctx[i].top_pipe == NULL
+					&& dc->current_state->res_ctx.pipe_ctx[i].prev_odm_pipe == NULL) {
+				if (context->res_ctx.pipe_ctx[i].stream == NULL) {
+					pipe = &context->res_ctx.pipe_ctx[i];
+					pipe->pipe_idx = i;
+					break;
+				}
 			}
 		}
-	}
 
 	/*
 	 * May need to fix pipes getting tossed from 1 opp to another on flip
@@ -2082,8 +2089,10 @@ static bool dcn30_internal_validate_bw(
 
 	for (i = 0, pipe_idx = -1; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *hsplit_pipe = NULL;
 		bool odm;
+		int old_index = -1;
 
 		if (!pipe->stream || newly_split[i])
 			continue;
@@ -2095,7 +2104,20 @@ static bool dcn30_internal_validate_bw(
 			continue;
 
 		if (split[i]) {
-			hsplit_pipe = dcn30_find_split_pipe(dc, context);
+			if (odm) {
+				if (split[i] == 4 && old_pipe->next_odm_pipe->next_odm_pipe)
+					old_index = old_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
+				else if (old_pipe->next_odm_pipe)
+					old_index = old_pipe->next_odm_pipe->pipe_idx;
+			} else {
+				if (split[i] == 4 && old_pipe->bottom_pipe->bottom_pipe &&
+						old_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+					old_index = old_pipe->bottom_pipe->bottom_pipe->pipe_idx;
+				else if (old_pipe->bottom_pipe &&
+						old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+					old_index = old_pipe->bottom_pipe->pipe_idx;
+			}
+			hsplit_pipe = dcn30_find_split_pipe(dc, context, old_index);
 			ASSERT(hsplit_pipe);
 			if (!hsplit_pipe)
 				goto validate_fail;
@@ -2109,8 +2131,16 @@ static bool dcn30_internal_validate_bw(
 			repopulate_pipes = true;
 		}
 		if (split[i] == 4) {
-			struct pipe_ctx *pipe_4to1 = dcn30_find_split_pipe(dc, context);
+			struct pipe_ctx *pipe_4to1;
 
+			if (odm && old_pipe->next_odm_pipe)
+				old_index = old_pipe->next_odm_pipe->pipe_idx;
+			else if (!odm && old_pipe->bottom_pipe &&
+						old_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+				old_index = old_pipe->bottom_pipe->pipe_idx;
+			else
+				old_index = -1;
+			pipe_4to1 = dcn30_find_split_pipe(dc, context, old_index);
 			ASSERT(pipe_4to1);
 			if (!pipe_4to1)
 				goto validate_fail;
@@ -2120,7 +2150,14 @@ static bool dcn30_internal_validate_bw(
 				goto validate_fail;
 			newly_split[pipe_4to1->pipe_idx] = true;
 
-			pipe_4to1 = dcn30_find_split_pipe(dc, context);
+			if (odm && old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe)
+				old_index = old_pipe->next_odm_pipe->next_odm_pipe->next_odm_pipe->pipe_idx;
+			else if (!odm && old_pipe->bottom_pipe->bottom_pipe->bottom_pipe &&
+						old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->plane_state == old_pipe->plane_state)
+				old_index = old_pipe->bottom_pipe->bottom_pipe->bottom_pipe->pipe_idx;
+			else
+				old_index = -1;
+			pipe_4to1 = dcn30_find_split_pipe(dc, context, old_index);
 			ASSERT(pipe_4to1);
 			if (!pipe_4to1)
 				goto validate_fail;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
