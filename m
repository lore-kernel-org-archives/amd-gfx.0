Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F354AC47420
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 16:47:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570822073A
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 16:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sJjxjhrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570822073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA1DC89F19;
	Mon, 28 Sep 2020 16:47:09 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690073.outbound.protection.outlook.com [40.107.69.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 471A089F19
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 16:47:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXxacOjDnHpD7Z5De4Zc92tGNEzvKf/EyUszuDbWW6AHpL5ruOF+8fIPUKW17lj9YR9IRXH9dMwfCR/C32aq5luT0JVN/3e9eizerQ0dKNdmqhl1qtH+f6hJ5wLlRHf2cfaBxHhyyTGauOvqrE4z4s3JpMZsy5uCRst+LpvklmsKnQKvGG+jrSZCR+mxtVL+67c7qVy6rrubWE5myYZsHMc5TTLxvCDCR9GnOExACB43GCue3L99AlmMn4KPyn0Zo996ZFU/StHPDC3YTxJm20UYEVuJjtJ/WqUoTdvIZ1Gy3Bv1YOcvMbQj2V8nLWBy/12x8xgLGmjH3kYnY74uRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4c6IDPN039iwOzamNIKNjM82OrZSDoFII5zr1dy9cg=;
 b=CUeO4INhcZFKp5rYqRNCvI5GgvwolOq8tMOtaboGFwkbJvMJjhyJ5bpC9nl4b74d0ysN4aGLwzMjM6vxgUw/g8+J37OvKw/DdyDjEZKgnSUb+CQYeTKDoV4aJcSwCYHXtYP7NEIb4X8Vt6lqirXYxx3LqDDbBnW9DzmwEbnpMJcxko/moToyYPSU6So/pqym+pqBGBr0vsRvGFWIDYtfJLlYMEXuxbd5tWzpoB+dEFSWMnEKz3fi7bGY+J0hGqakVUWskBpPRI046GMw5ThAvuYnzaArEczsiSzGUbV3upyoMsMlbndmIFshVSezQhaQwiVE+wmPpSn2cCQD+PKd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4c6IDPN039iwOzamNIKNjM82OrZSDoFII5zr1dy9cg=;
 b=sJjxjhrEvKWGdnNd2ldNHpQxUXlxIgqfgKlVhuUucb+Hb4BRs/+5zUVbbJbEtj13GMmseG1qvgcgXQZk/rVThO+waK/avSXsvdfYaXBwA3IPFloVT/Jy8cXc9hSfhighlhyZQPKj5Pqzh42gtER94fsenZ8VHjOgQ1o7mdBPigA=
Received: from DM6PR17CA0030.namprd17.prod.outlook.com (2603:10b6:5:1b3::43)
 by BN6PR12MB1539.namprd12.prod.outlook.com (2603:10b6:405:6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 16:47:07 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::1d) by DM6PR17CA0030.outlook.office365.com
 (2603:10b6:5:1b3::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 16:47:07 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3412.21 via Frontend Transport; Mon, 28 Sep 2020 16:47:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 28 Sep
 2020 11:47:06 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 28 Sep
 2020 11:47:06 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Mon, 28 Sep 2020 11:47:05 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <alexander.deucher@amd.com>
Subject: [PATCH] amd/drm/display: avoid dcn3 on flip opp change for slave pipes
Date: Mon, 28 Sep 2020 12:46:53 -0400
Message-ID: <20200928164653.276877-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45de3632-89f8-4d3f-df16-08d863ce22db
X-MS-TrafficTypeDiagnostic: BN6PR12MB1539:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1539555B424AB3665A2FB7E4F9350@BN6PR12MB1539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXB9oaZIP1z5XBX59b3iqqr+rloHY1YvuWCefKt4Cjylk0eSEcsZoyMqLp5uI/9wPqPuT9pyhGnLnSMvXKVi8Qg0Jph3kXsULNKcg0W5RBDA6YsJvSVdjrfk50UkTlfwgkR1q3rRVeNjDRYqcrDTIrEqRgPujbu54tM72MOo5EbH6aNdoiHvcfNoQjq/AKkXxdxuHTXGrsXf8EV6fz7trExy/vmTHmvtd4FVU3fKDFl+ghh09kdbu2sonorF6Hfq86LbZlk3e9ToofwdiJ3Obv7vxvrxsPlqdTKZzgfBytXJ9AWtF34a+n3SLHtOXdj6ri9HR2cd2NIy3MeBxYNWT6GfgmoAabUWogO0i5zGxtkiJWB47HCwM4WQcU69m2NZ4rvcJ3GSvDJlUlf1dCH6x99MjTVow5cLYWV9h/MbVNxCX7hB0GA9ink05GcX4mQV
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(6666004)(356005)(186003)(336012)(426003)(26005)(478600001)(36756003)(2906002)(2616005)(6636002)(6862004)(8936002)(8676002)(4326008)(7696005)(5660300002)(47076004)(81166007)(82740400003)(83380400001)(70586007)(1076003)(70206006)(54906003)(82310400003)(316002)(37006003)(86362001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 16:47:07.1413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45de3632-89f8-4d3f-df16-08d863ce22db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1539
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

At the moment on flip opp reassignment does not work in all cases
for non root pipes.
This change simply makes sure we prefer pipes not used previously
when splitting in dcn3.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 43 +++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index dde87baf1370..60ee4062dc8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1899,6 +1899,41 @@ static bool dcn30_split_stream_for_mpc_or_odm(
 	return true;
 }
 
+static struct pipe_ctx *dcn30_find_split_pipe(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	struct pipe_ctx *pipe = NULL;
+	int i;
+
+	for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+		if (dc->current_state->res_ctx.pipe_ctx[i].top_pipe == NULL
+				&& dc->current_state->res_ctx.pipe_ctx[i].prev_odm_pipe == NULL) {
+			if (context->res_ctx.pipe_ctx[i].stream == NULL) {
+				pipe = &context->res_ctx.pipe_ctx[i];
+				pipe->pipe_idx = i;
+				break;
+			}
+		}
+	}
+
+	/*
+	 * May need to fix pipes getting tossed from 1 opp to another on flip
+	 * Add for debugging transient underflow during topology updates:
+	 * ASSERT(pipe);
+	 */
+	if (!pipe)
+		for (i = dc->res_pool->pipe_count - 1; i >= 0; i--) {
+			if (context->res_ctx.pipe_ctx[i].stream == NULL) {
+				pipe = &context->res_ctx.pipe_ctx[i];
+				pipe->pipe_idx = i;
+				break;
+			}
+		}
+
+	return pipe;
+}
+
 static bool dcn30_internal_validate_bw(
 		struct dc *dc,
 		struct dc_state *context,
@@ -2024,6 +2059,7 @@ static bool dcn30_internal_validate_bw(
 				dcn20_release_dsc(&context->res_ctx, dc->res_pool, &pipe->stream_res.dsc);
 			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
 			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
+			repopulate_pipes = true;
 		} else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
 			struct pipe_ctx *top_pipe = pipe->top_pipe;
 			struct pipe_ctx *bottom_pipe = pipe->bottom_pipe;
@@ -2038,6 +2074,7 @@ static bool dcn30_internal_validate_bw(
 			pipe->stream = NULL;
 			memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
 			memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
+			repopulate_pipes = true;
 		} else
 			ASSERT(0); /* Should never try to merge master pipe */
 
@@ -2058,7 +2095,7 @@ static bool dcn30_internal_validate_bw(
 			continue;
 
 		if (split[i]) {
-			hsplit_pipe = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
+			hsplit_pipe = dcn30_find_split_pipe(dc, context);
 			ASSERT(hsplit_pipe);
 			if (!hsplit_pipe)
 				goto validate_fail;
@@ -2072,7 +2109,7 @@ static bool dcn30_internal_validate_bw(
 			repopulate_pipes = true;
 		}
 		if (split[i] == 4) {
-			struct pipe_ctx *pipe_4to1 = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
+			struct pipe_ctx *pipe_4to1 = dcn30_find_split_pipe(dc, context);
 
 			ASSERT(pipe_4to1);
 			if (!pipe_4to1)
@@ -2083,7 +2120,7 @@ static bool dcn30_internal_validate_bw(
 				goto validate_fail;
 			newly_split[pipe_4to1->pipe_idx] = true;
 
-			pipe_4to1 = find_idle_secondary_pipe(&context->res_ctx, dc->res_pool, pipe);
+			pipe_4to1 = dcn30_find_split_pipe(dc, context);
 			ASSERT(pipe_4to1);
 			if (!pipe_4to1)
 				goto validate_fail;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
