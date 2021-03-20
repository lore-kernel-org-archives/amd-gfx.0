Return-Path: <SRS0=4T84=IS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE40C433C1
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CD76196F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 Mar 2021 04:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CD76196F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D258C6EB28;
	Sat, 20 Mar 2021 04:19:36 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750055.outbound.protection.outlook.com [40.107.75.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7D36EB28
 for <amd-gfx@lists.freedesktop.org>; Sat, 20 Mar 2021 04:19:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpMcttF1hSfR6l1NN45pW6vNkyKkCSm58uK62ISF77w5GQNlFGI3smOBTzKOYpA1MRIiHbFdBF+HTt0OolRpjk4JgmSt1Klqz72bmt4lJSXEBpMsRF8r6MKJpGR+E/O2+1C0T2wI2XtlsFPToBFFrkHdqTgY7BhEKqeFBkMCsb7E79d6Xko12Nx3U6WTf7MbOs3GSdJ64mhynSYo/zWPHGVV4lh6rC+DxkHWccojZ165l/03vpNt1SDMCy2oEu2hI1aSSaRqgXpi4fFl7Xzw9z//bK/E8ZfSGZZG51HVgcjv9dLBXCpgeg/+bJpyjPdq0Jq88i/D34xKwmgGM3g6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9TdFgyohnryuXAHWWkwyLzOS3tUrlQkvtn0mZGHnQg=;
 b=FVFwobOVv9mFhcUfL4b1Q4bwEv3Bz/uQu1tFXGHhISAFM6wR2fBzXqXCgTe87WRil2ZCzBjldal8Pw3LyhNAwRsw25ISX9TlSS5raZE9yyT4eUtg86UpV7Lj/JAHcu6iu2DD8xe3xMeBh8FXYDvcIx+gi/rRWP2iJMsFWpoWxIwZIeZNL16rC95D5pwSVIfmtLnxQ/a2mg/pVL4Ol82hmpJoTKRzTF+875VM2KAwYfnmA+UdC6vQHcJGW6vCMWfews+5CyW41JkizsY4ApM3cE3JVYTtRRwGrd45gi6tLmCptNty+q6Z3XDo1d16h9dAN78M/sFZ+586BU5eSEMQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9TdFgyohnryuXAHWWkwyLzOS3tUrlQkvtn0mZGHnQg=;
 b=yzIWJqpnP3y3XxMzRmcr1HnBSsKnui1yZ66qxUTgwAllDtWOSuozvl4fR6DCYGIU7tR6alIYjOz7/PmAtX2bw7GU5HhWnarLM1zq5JGPl/PXNIuDz9Y+mSW9Uvcc4MA4fPZUp2f92D9mMBOfeOMb6sH820PNqsm53Dp42gDYAJ8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2605.namprd12.prod.outlook.com (2603:10b6:805:6a::11)
 by SN6PR12MB4704.namprd12.prod.outlook.com (2603:10b6:805:e8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Sat, 20 Mar
 2021 04:19:34 +0000
Received: from SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1]) by SN6PR12MB2605.namprd12.prod.outlook.com
 ([fe80::5c4e:1bdd:5eed:b2d1%6]) with mapi id 15.20.3955.018; Sat, 20 Mar 2021
 04:19:33 +0000
From: Solomon Chiu <solomon.chiu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/14] drm/amd/display: Change input parameter for set_drr
Date: Sat, 20 Mar 2021 09:46:54 +0800
Message-Id: <20210320014656.23350-13-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210320014656.23350-1-solomon.chiu@amd.com>
References: <20210320014656.23350-1-solomon.chiu@amd.com>
X-Originating-IP: [165.204.134.249]
X-ClientProxiedBy: HKAPR03CA0030.apcprd03.prod.outlook.com
 (2603:1096:203:c9::17) To SN6PR12MB2605.namprd12.prod.outlook.com
 (2603:10b6:805:6a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from LAPTOP-K5LN3AJ2.localdomain (165.204.134.249) by
 HKAPR03CA0030.apcprd03.prod.outlook.com (2603:1096:203:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.9 via Frontend Transport; Sat, 20 Mar 2021 04:19:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1836014e-aef1-4057-80e3-08d8eb575d02
X-MS-TrafficTypeDiagnostic: SN6PR12MB4704:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4704431397F034D9AF87C95397679@SN6PR12MB4704.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ng3JlHlcK6OdbIgkGmbfOz56156OuUWX5hs5V4hOvltgB+jZbkVX43vyq+Tm4qYecrca7Zaq4q/gnRhwj2VgWZuTdRtr3vKNgMJJvqG2t7Q22zjQSuaZS/QP85ErXmFaBfEgQPhJvXbjl49T0SiAKDW2Ef+hZ/Gx5hu2KTzvclghRiYb7/XSaXZkLTr67E5Dc4WpsL+9fu9g7JjNUZGbrHqjRKk32z2nd6AEg1WeCOlYtV7GaqCWb8Q+h23R57gBtMN0nsUA8ln+HGKovxqB6o26h3l2zIHyrL/hBu4l3uZwcN0tdMaXevQC1cLA6iL0o84GIXOn56Nvc/r7VOTy2SW19Fd/Pzm0bbgR/jDFMTyj+3ghl5FmVyfPVVA+GNifvKHuHqxVXIsXUitUOHLj3eyWDZ7hvexKxT2LHk4yHM5jMcRbgRBysTQkJAHczMeECLI7OF4AURwRst+dV3vZkrDHbMn5u4Vsae+dbTGLd6qP7B3pX0pu4/rRvEIIzysrstiEvQD5c3u4CTjvyyh2YZsDRnpXaxsUj9vxwCzaSiU735uox0pgfQTNewZ1BTJDEHXHrDYRtvi1yq4WrEjCAZnDF6udruW4+7E9gFMHqap8haUmwzvxTgji0RciJv3Zu34HSMLB5xlEZm8ui4haBXUrCkTBIS1hKj35Gw7eh78=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2605.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(396003)(376002)(136003)(8936002)(6512007)(44832011)(6666004)(26005)(478600001)(4326008)(8676002)(52116002)(38100700001)(36756003)(316002)(86362001)(6916009)(6486002)(1076003)(2616005)(54906003)(83380400001)(5660300002)(66556008)(66946007)(186003)(956004)(16526019)(66476007)(2906002)(30864003)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ga0Y6siCZDmIf28vClFZJ6LLyttolWhKSBOYjuuUsG9H9PPSmqX3Dph3vHtM?=
 =?us-ascii?Q?yPn1kTXkPrQTIFJWSzHK+ripT0MBrA9yuSFwM4dGbOiJ3sQAcZ0XNuTdm1S3?=
 =?us-ascii?Q?ipLgPoK1+vjf+NBXNOa/rtmoOb1FfZyHA2bTdS8rdjcl2CjFbYxx5ct7TOE8?=
 =?us-ascii?Q?FhWcpjGtvEk7iGAKpA2CeUmIwCw00eC5oURtb1u7eTKiKrI4UOO/7CYpR+Xz?=
 =?us-ascii?Q?HuLmbkzrFdER9e4m41dcQ6rkBLODZRRyVPmVFW/234SMeQNvQHlsOutOJ7dz?=
 =?us-ascii?Q?omeKjl/AXgtPQTy70q854QLjuiE+E4t3UTKYh5605ApfamCi78ZgX9wb+/1D?=
 =?us-ascii?Q?0o/vSOGePQt5RitN8l8vey+Sd9v4Fu9gMz42DsMoZntg5DhtTskzFJADPgOV?=
 =?us-ascii?Q?Sh2KHt5OBDSir79FgU/baesEQwenxkdp8bFQ/xAyhMNa75QONBoYmHjjYyer?=
 =?us-ascii?Q?SaqtayE3+44lXHZD7RlrzsOsSLFVFkG9JuLmnwk7ckujKermGwQA/63LkLEj?=
 =?us-ascii?Q?Z5Zx3udxIBKyBD/qJo9YssXjkFhKgYlsB5h7KBlBmzQfeSWL5PkX7xjHtXr6?=
 =?us-ascii?Q?ZPtSaF/whPpgGc00OHyWMqfmP85kdITOlnZILduD0WG44kuPRN2ebCtT+N8g?=
 =?us-ascii?Q?dZOo1VK10vUyO42h3ATv/dC5C6gUsRsBVQHAuoS2WaFq72cYlION2TQFeyjc?=
 =?us-ascii?Q?nGLHLmt61hAETZecLiyxgQAwyKOV1FK9ZNGmdHToDPBZo5rpc4HTw/U6TNGU?=
 =?us-ascii?Q?j9xsRzPf0FsZVGU43VwJoRT4BJ1/UvY4XFUCQz+7N/LABNjZj9n0zeVaZJjy?=
 =?us-ascii?Q?EizO/juQfE5bSMzSKWWAbgSKUvWX6fhsgSLx8QesGsU987fSKYAjOvPJbcZY?=
 =?us-ascii?Q?SnJnM+Ad2zDwZUuk+gK05MXWB71K3Fm8qSYaBJxIqrlIDbhWilnT/AhuKeCu?=
 =?us-ascii?Q?xeJ7jGIDiiuzjchq73HOM9ZeQPWEShP1W7PNGYBe3wZLsU3KmfaNSQNPkOfJ?=
 =?us-ascii?Q?RSdO0JpZDIe3Ew953aChL0kblwAVY/0AweJmPBMZFzzWgcsMTNQMA6lQjjrr?=
 =?us-ascii?Q?8/3c1JWcZk+6OaTJMEkHOP3RNqNiaMk4AqQjBpj8FWyvm2MX0d2uyrNc+De+?=
 =?us-ascii?Q?5vM7rIzoDM2G94Y323Xq/qWbt7tM9jrRw5efpV7qzuiwxIvn4lZG3mbiBH9b?=
 =?us-ascii?Q?xm1WyqJQVbS3ptfQ/B0HH6nDK9Jw2QXV4Apl5Cz+otXiiMLQ1eHuxWefzpj6?=
 =?us-ascii?Q?voyzalIUoWApPWA2aYAnEYnDPIX2BnilX7y+CiVUbtH4VRy8KUDGgPYWUkqn?=
 =?us-ascii?Q?B7yZO/buc6HJnyVlyGzW8/oy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1836014e-aef1-4057-80e3-08d8eb575d02
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2605.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2021 04:19:33.6587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxaJa2eC+QDYAm1kv8af7NwQmAPsfKnN7uAVo4kYFd2HXSR7PzfASL87K2au1haByfDAA1btVvSsIlJcsRuHBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4704
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
Cc: Eryk.Brol@amd.com, Solomon Chiu <solomon.chiu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
Change set_drr to pass in the entire dc_crtc_timing_adjust
structure instead of passing in the parameters individually.
This is to more easily pass in required parameters in the
adjust structure when it gets updated.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 10 ++---
 .../display/dc/dce110/dce110_hw_sequencer.c   |  9 ++---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 14 +++----
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  3 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  3 +-
 .../amd/display/modules/freesync/freesync.c   | 37 +++++++++++++------
 .../amd/display/modules/inc/mod_freesync.h    |  7 +++-
 7 files changed, 49 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8e6c815b55d2..d55c1dd6464c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -304,7 +304,10 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	int i = 0;
 	bool ret = false;
 
-	stream->adjust = *adjust;
+	stream->adjust.v_total_max = adjust->v_total_max;
+	stream->adjust.v_total_mid = adjust->v_total_mid;
+	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
+	stream->adjust.v_total_min = adjust->v_total_min;
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
@@ -312,10 +315,7 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 		if (pipe->stream == stream && pipe->stream_res.tg) {
 			dc->hwss.set_drr(&pipe,
 					1,
-					adjust->v_total_min,
-					adjust->v_total_max,
-					adjust->v_total_mid,
-					adjust->v_total_mid_frame_num);
+					*adjust);
 
 			ret = true;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 804092f81f85..873c6f2d2cd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1846,8 +1846,7 @@ void dce110_set_safe_displaymarks(
  ******************************************************************************/
 
 static void set_drr(struct pipe_ctx **pipe_ctx,
-		int num_pipes, unsigned int vmin, unsigned int vmax,
-		unsigned int vmid, unsigned int vmid_frame_number)
+		int num_pipes, struct dc_crtc_timing_adjust adjust)
 {
 	int i = 0;
 	struct drr_params params = {0};
@@ -1856,8 +1855,8 @@ static void set_drr(struct pipe_ctx **pipe_ctx,
 	// Note DRR trigger events are generated regardless of whether num frames met.
 	unsigned int num_frames = 2;
 
-	params.vertical_total_max = vmax;
-	params.vertical_total_min = vmin;
+	params.vertical_total_max = adjust.v_total_max;
+	params.vertical_total_min = adjust.v_total_min;
 
 	/* TODO: If multiple pipes are to be supported, you need
 	 * some GSL stuff. Static screen triggers may be programmed differently
@@ -1867,7 +1866,7 @@ static void set_drr(struct pipe_ctx **pipe_ctx,
 		pipe_ctx[i]->stream_res.tg->funcs->set_drr(
 			pipe_ctx[i]->stream_res.tg, &params);
 
-		if (vmax != 0 && vmin != 0)
+		if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
 			pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
 					pipe_ctx[i]->stream_res.tg,
 					event_triggers, num_frames);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 9eb33eae0e81..e0aa88a7766b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3271,8 +3271,7 @@ void dcn10_optimize_bandwidth(
 }
 
 void dcn10_set_drr(struct pipe_ctx **pipe_ctx,
-		int num_pipes, unsigned int vmin, unsigned int vmax,
-		unsigned int vmid, unsigned int vmid_frame_number)
+		int num_pipes, struct dc_crtc_timing_adjust adjust)
 {
 	int i = 0;
 	struct drr_params params = {0};
@@ -3281,11 +3280,10 @@ void dcn10_set_drr(struct pipe_ctx **pipe_ctx,
 	// Note DRR trigger events are generated regardless of whether num frames met.
 	unsigned int num_frames = 2;
 
-	params.vertical_total_max = vmax;
-	params.vertical_total_min = vmin;
-	params.vertical_total_mid = vmid;
-	params.vertical_total_mid_frame_num = vmid_frame_number;
-
+	params.vertical_total_max = adjust.v_total_max;
+	params.vertical_total_min = adjust.v_total_min;
+	params.vertical_total_mid = adjust.v_total_mid;
+	params.vertical_total_mid_frame_num = adjust.v_total_mid_frame_num;
 	/* TODO: If multiple pipes are to be supported, you need
 	 * some GSL stuff. Static screen triggers may be programmed differently
 	 * as well.
@@ -3293,7 +3291,7 @@ void dcn10_set_drr(struct pipe_ctx **pipe_ctx,
 	for (i = 0; i < num_pipes; i++) {
 		pipe_ctx[i]->stream_res.tg->funcs->set_drr(
 			pipe_ctx[i]->stream_res.tg, &params);
-		if (vmax != 0 && vmin != 0)
+		if (adjust.v_total_max != 0 && adjust.v_total_min != 0)
 			pipe_ctx[i]->stream_res.tg->funcs->set_static_screen_control(
 					pipe_ctx[i]->stream_res.tg,
 					event_triggers, num_frames);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index e0800cd1cc02..ff1ce200432f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -145,8 +145,7 @@ bool dcn10_dummy_display_power_gating(
 		struct dc_bios *dcb,
 		enum pipe_gating_control power_gating);
 void dcn10_set_drr(struct pipe_ctx **pipe_ctx,
-		int num_pipes, unsigned int vmin, unsigned int vmax,
-		unsigned int vmid, unsigned int vmid_frame_number);
+		int num_pipes, struct dc_crtc_timing_adjust adjust);
 void dcn10_get_position(struct pipe_ctx **pipe_ctx,
 		int num_pipes,
 		struct crtc_position *position);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 2fedfcac6705..1a6366a6da1d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -118,8 +118,7 @@ struct hw_sequencer_funcs {
 			struct pipe_ctx *pipe_ctx,
 			enum vline_select vline);
 	void (*set_drr)(struct pipe_ctx **pipe_ctx, int num_pipes,
-			unsigned int vmin, unsigned int vmax,
-			unsigned int vmid, unsigned int vmid_frame_number);
+			struct dc_crtc_timing_adjust adjust);
 	void (*set_static_screen_control)(struct pipe_ctx **pipe_ctx,
 			int num_pipes,
 			const struct dc_static_screen_params *events);
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index e5f9d7704a63..4287be79c11a 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -118,7 +118,7 @@ static unsigned int calc_duration_in_us_from_v_total(
 	return duration_in_us;
 }
 
-static unsigned int calc_v_total_from_refresh(
+unsigned int mod_freesync_calc_v_total_from_refresh(
 		const struct dc_stream_state *stream,
 		unsigned int refresh_in_uhz)
 {
@@ -280,10 +280,10 @@ static void apply_below_the_range(struct core_freesync *core_freesync,
 
 		/* Restore FreeSync */
 		in_out_vrr->adjust.v_total_min =
-			calc_v_total_from_refresh(stream,
+			mod_freesync_calc_v_total_from_refresh(stream,
 				in_out_vrr->max_refresh_in_uhz);
 		in_out_vrr->adjust.v_total_max =
-			calc_v_total_from_refresh(stream,
+			mod_freesync_calc_v_total_from_refresh(stream,
 				in_out_vrr->min_refresh_in_uhz);
 	/* BTR set to "active" so engage */
 	} else {
@@ -442,16 +442,16 @@ static void apply_fixed_refresh(struct core_freesync *core_freesync,
 	if (update) {
 		if (in_out_vrr->fixed.fixed_active) {
 			in_out_vrr->adjust.v_total_min =
-				calc_v_total_from_refresh(
+				mod_freesync_calc_v_total_from_refresh(
 				stream, in_out_vrr->max_refresh_in_uhz);
 			in_out_vrr->adjust.v_total_max =
 					in_out_vrr->adjust.v_total_min;
 		} else {
 			in_out_vrr->adjust.v_total_min =
-				calc_v_total_from_refresh(stream,
+				mod_freesync_calc_v_total_from_refresh(stream,
 					in_out_vrr->max_refresh_in_uhz);
 			in_out_vrr->adjust.v_total_max =
-				calc_v_total_from_refresh(stream,
+				mod_freesync_calc_v_total_from_refresh(stream,
 					in_out_vrr->min_refresh_in_uhz);
 		}
 	}
@@ -1082,10 +1082,10 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 			refresh_range >= MIN_REFRESH_RANGE) {
 
 		in_out_vrr->adjust.v_total_min =
-			calc_v_total_from_refresh(stream,
+			mod_freesync_calc_v_total_from_refresh(stream,
 				in_out_vrr->max_refresh_in_uhz);
 		in_out_vrr->adjust.v_total_max =
-			calc_v_total_from_refresh(stream,
+			mod_freesync_calc_v_total_from_refresh(stream,
 				in_out_vrr->min_refresh_in_uhz);
 	} else if (in_out_vrr->state == VRR_STATE_ACTIVE_FIXED) {
 		in_out_vrr->fixed.target_refresh_in_uhz =
@@ -1099,7 +1099,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		} else {
 			in_out_vrr->fixed.fixed_active = true;
 			in_out_vrr->adjust.v_total_min =
-				calc_v_total_from_refresh(stream,
+				mod_freesync_calc_v_total_from_refresh(stream,
 					in_out_vrr->fixed.target_refresh_in_uhz);
 			in_out_vrr->adjust.v_total_max =
 				in_out_vrr->adjust.v_total_min;
@@ -1206,10 +1206,10 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 		/* Restore FreeSync */
 		if (in_out_vrr->btr.frame_counter == 0) {
 			in_out_vrr->adjust.v_total_min =
-				calc_v_total_from_refresh(stream,
+				mod_freesync_calc_v_total_from_refresh(stream,
 				in_out_vrr->max_refresh_in_uhz);
 			in_out_vrr->adjust.v_total_max =
-				calc_v_total_from_refresh(stream,
+				mod_freesync_calc_v_total_from_refresh(stream,
 				in_out_vrr->min_refresh_in_uhz);
 		}
 	}
@@ -1267,6 +1267,21 @@ unsigned long long mod_freesync_calc_nominal_field_rate(
 	return nominal_field_rate_in_uhz;
 }
 
+unsigned long long mod_freesync_calc_field_rate_from_timing(
+		unsigned int vtotal, unsigned int htotal, unsigned int pix_clk)
+{
+	unsigned long long field_rate_in_uhz = 0;
+	unsigned int total = htotal * vtotal;
+
+	/* Calculate nominal field rate for stream, rounded up to nearest integer */
+	field_rate_in_uhz = pix_clk;
+	field_rate_in_uhz *= 1000000ULL;
+
+	field_rate_in_uhz =	div_u64(field_rate_in_uhz, total);
+
+	return field_rate_in_uhz;
+}
+
 bool mod_freesync_is_valid_range(uint32_t min_refresh_cap_in_uhz,
 		uint32_t max_refresh_cap_in_uhz,
 		uint32_t nominal_field_rate_in_uhz) 
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index b64cd5bdc7b5..75a158a2514c 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -171,10 +171,15 @@ void mod_freesync_handle_v_update(struct mod_freesync *mod_freesync,
 unsigned long long mod_freesync_calc_nominal_field_rate(
 			const struct dc_stream_state *stream);
 
+unsigned long long mod_freesync_calc_field_rate_from_timing(
+		unsigned int vtotal, unsigned int htotal, unsigned int pix_clk);
+
 bool mod_freesync_is_valid_range(uint32_t min_refresh_cap_in_uhz,
 		uint32_t max_refresh_cap_in_uhz,
 		uint32_t nominal_field_rate_in_uhz);
 
-
+unsigned int mod_freesync_calc_v_total_from_refresh(
+		const struct dc_stream_state *stream,
+		unsigned int refresh_in_uhz);
 
 #endif
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
