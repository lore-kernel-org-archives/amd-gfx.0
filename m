Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD950C2D0E1
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6D121D7E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1wKV+zYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6D121D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5AF46E94C;
	Thu, 10 Sep 2020 13:47:44 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F746E954
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLy+KYSq/ZpyLDnQ4e7mfTP2gJfXDjoxSyAyu3tyu6zkQo11q+lt6L/KRUDe0VG+3aNHxgg0qUHZxvOuphKJxUN0RfRUTQ258Yje9cKmkf1lZgv9/ea9JohGponSYeFnDmIGVF+PiRvMUT7/xMsP2at5Vp55+8eFqaSSkU1nEg3j8qaD4Xkuqj6bXRkEwKAt1C5lPODqMUxeDsJdoTShnhT69PAbTgBbRld5av+Ui3CWSbuFxeGAyoqP42fry05n/M+2IzNRxfwK1OUKhjhbT0c/y24JLgYlWL5cNUWmRfnn6XneMrs3KWJs8G5PJfUYpxtVLgPrUlX1VDxb6ggicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as/Nu0jreGCEMXNsDQ98V/9+6SQQdnchqoK3VSrMvjE=;
 b=Sc/l680vAda0aoluU480mabnvQZSiNyf3Bpli3VjRcuAKo+4/BQEy2w5Kmq3Wi2HcW76Z4htwMnF1kQfsNkSCdF6eRQOhLKbaXnOSd3Mr3T1oV7vG07LepVC5NlsK3zSDG/X1WW81iBTTc/gBLJZU0AUF8808HH3QEMP44j0+O3HJp1JVOuX1GjWOxikI44VZ+fIW9YaxMPmX/ZJaRTW1mu7cKFc/kY0KD1Hl/ljV4RHLhAbCpqHDplxXkPO84MVvGC2iojkOaIQI3AYha+hWPc5tkRxMzLsLCk8xb339ppBZhgLE/ZCAP9tU5pbgW4ktPPXnbhRbSLe7YdOdW6zLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as/Nu0jreGCEMXNsDQ98V/9+6SQQdnchqoK3VSrMvjE=;
 b=1wKV+zYu2Bjkvezz6QW7MDF6VH+ihiTfkCBPJVYLTZ0PcFbmd2rIoqFIaG974HntJEV2o/hcp+tP00fDc5wiISECaJC6XtL/wAeJFU92/4YThdMbNwwzUxEKiLbMVLrMwU52zcWeyCoImCZw0H/Kt/C4c0rNP+S085NZdDwvDZg=
Received: from BN6PR2001CA0031.namprd20.prod.outlook.com
 (2603:10b6:405:16::17) by CY4PR12MB1846.namprd12.prod.outlook.com
 (2603:10b6:903:11b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:39 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::a) by BN6PR2001CA0031.outlook.office365.com
 (2603:10b6:405:16::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:39 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:38 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:38 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:37 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/42] drm/amd/display: Compare plane when looking for pipe
 split being lost
Date: Thu, 10 Sep 2020 09:47:02 -0400
Message-ID: <20200910134723.27410-22-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de04ffbe-e8e3-411a-7bd9-08d85590152f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18465DB94B71CCD953FE4BBB8B270@CY4PR12MB1846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wljUK3obuJ3o+QyB3fMyUctRFpipPvmEYDbW7Rbf+u6da/KJG60Jo9bjGP6ayTyb6fs/2VxPoShQ0FOs5N3oTTAG8TkJYstQnefO7eiw+GDxHy/f8idY9G4FyOSaNYHzAGj7AL2+6PZ5HItX4y3pATUqlv4wCITxny4R0tCCppqO5cGId1pw1wlQ3nZC+5EZRYN4JpzbhMNB0gUEzxXYMj1uPMhJA4LPSRMxfeA1npczzQ+XyTA3ZXKSozPRtXArvv/E1ZmK+OrJOl7whd9B4pndLfYK/60QPh0JUgy0fPmaFRe5VS6NWZerIhR+2qYs+/2F4Pc/vHNifpI9j34Qs/FXWAagitH24N6tySelVopypGqW4fLh1nD9JD296UQ196KcutPAnlnZ6VH7wVWAiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966005)(478600001)(82310400003)(70206006)(26005)(83380400001)(44832011)(6916009)(356005)(81166007)(5660300002)(54906003)(70586007)(36756003)(47076004)(86362001)(82740400003)(336012)(8936002)(186003)(1076003)(316002)(4326008)(2616005)(426003)(8676002)(2906002)(6666004)(7696005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:39.1580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de04ffbe-e8e3-411a-7bd9-08d85590152f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1846
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
There are situations where we go from 2 pipe to 1 pipe in MPO, but this
isn't a pipe split being lost -- it's a plane disappearing in (i.e. video overlay
goes away) so we lose one pipe. In these situations we don't want to
disable the pipe in a separate operation from the rest of the pipe
programming sequence. We only want to disable a pipe in a
separate operation when we're actually disabling pipe split.

[How]
Make sure the pipe being lost has the same stream AND plane
as the old top pipe to ensure.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 8ca94f506195..d0f3bf953d02 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2765,7 +2765,7 @@ bool dcn10_disconnect_pipes(
 		struct dc *dc,
 		struct dc_state *context)
 {
-		bool found_stream = false;
+		bool found_pipe = false;
 		int i, j;
 		struct dce_hwseq *hws = dc->hwseq;
 		struct dc_state *old_ctx = dc->current_state;
@@ -2805,26 +2805,28 @@ bool dcn10_disconnect_pipes(
 					old_ctx->res_ctx.pipe_ctx[i].top_pipe) {
 
 					/* Find the top pipe in the new ctx for the bottom pipe that we
-					 * want to remove by comparing the streams. If both pipes are being
-					 * disabled then do it in the regular pipe programming sequence
+					 * want to remove by comparing the streams and planes. If both
+					 * pipes are being disabled then do it in the regular pipe
+					 * programming sequence
 					 */
 					for (j = 0; j < dc->res_pool->pipe_count; j++) {
 						if (old_ctx->res_ctx.pipe_ctx[i].top_pipe->stream == context->res_ctx.pipe_ctx[j].stream &&
+							old_ctx->res_ctx.pipe_ctx[i].top_pipe->plane_state == context->res_ctx.pipe_ctx[j].plane_state &&
 							!context->res_ctx.pipe_ctx[j].top_pipe &&
 							!context->res_ctx.pipe_ctx[j].update_flags.bits.disable) {
-							found_stream = true;
+							found_pipe = true;
 							break;
 						}
 					}
 
 					// Disconnect if the top pipe lost it's pipe split
-					if (found_stream && !context->res_ctx.pipe_ctx[j].bottom_pipe) {
+					if (found_pipe && !context->res_ctx.pipe_ctx[j].bottom_pipe) {
 						hws->funcs.plane_atomic_disconnect(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
 						DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
 						mpcc_disconnected = true;
 					}
 				}
-				found_stream = false;
+				found_pipe = false;
 			}
 		}
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
