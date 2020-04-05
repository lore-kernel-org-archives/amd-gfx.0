Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557F7C2BA19
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DCB20644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aEa/Hhp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DCB20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA67F6E2B6;
	Sun,  5 Apr 2020 20:42:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DDAF6E2C0
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCDW9Mqx9YmEzHZRLzEI4XInvwWgeM1UxrtiKTEC05bmNL4s0+mKvVqYDEnHx5GdXlIJ0gv/Rs8vY53nCcaadvHOsnWzqt/PE98pE0d+raNV9CL19gdqFym+dWvRR3TbE/ZXX+gZtIdn2MqhqzAOA00QVvrxMKk5rtedG0cK8Aj6h15HHOG2NnwZAmt/yVvus3dgJ0cnmvbrtXBxC05OfsBVzmpLZybCw5fhjQ6Yql+KTmChGwee/Qokj99xD1oXi1oolQ10ryxjdOr5rnJasAy14xuLhK70xhfGtcD/nMRCsBbhTkQpparObb15uKb77aVTEjqfRB2s50JPlNvPlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qagxajxGlsAHJnSAN8Z8TtOqaPAPOObL3QXgu8N4O2M=;
 b=g4QJBWUnI1QXHfrfbRB/lFbXIANZvPwmGEKYQmC/xoA0b4oOyxkI1y/lJKbBP1kpU/EZidzP2l5CKXVY58xEbci5fNdtMe34+TaUY0h5frEl+QTVH0Z7KE0vYGfrRueJx/+emL2NFQa1E17/GN+jOvFSE4TVAgQH9sQMBiiewMYFLAprqQ5shMXRgsuiuQoNZAwlZi+/EZGUludElKKlXLU50ag3XD/OQyGUFcxP47IB8L8P9lXYuC/k5SVN/EYt/G3DhTdw+1/iQXhcp7T580yCtlrQn6rkxDgYflJJQbvbvRpERY92Elf/dOwFvbHrTCBe9jvTWeiZbn7roTjGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qagxajxGlsAHJnSAN8Z8TtOqaPAPOObL3QXgu8N4O2M=;
 b=aEa/Hhp/miKE7RHzboxAVZu6pHXnAPOvXh9OEOvgfq0QfDY5EW2d5PEqVleZ3Of9nlCrgZkzrGPDA873VBbghOmtKKP2OXy/Oslb7R2utsXQTXJg2BOB+MmhsJh6CU3TC2Znhj3OoOlb9ugf9gCBRDRRmPcPYgLLBrgEoz1ZsN4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:42:07 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:42:07 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 29/36] drm/amd/display: Make cursor source translation
 adjustment optional
Date: Sun,  5 Apr 2020 16:41:08 -0400
Message-Id: <20200405204115.683559-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
References: <20200405204115.683559-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::4) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Sun, 5 Apr 2020 20:42:06 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c8d4d18-edc5-46ba-4777-08d7d9a1ce43
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2555DDCCEC6E407DCDA6514F98C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03648EFF89
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(1076003)(8676002)(6916009)(8936002)(6486002)(81156014)(81166006)(16526019)(52116002)(36756003)(2906002)(6512007)(186003)(86362001)(316002)(54906003)(6506007)(66556008)(66476007)(2616005)(66946007)(478600001)(4326008)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZePg7psi6kw8E9lRDG/LQrL0EOCFjTrRo2YbOJ5VjaWnrXpkdlKifJWckX4ikqYv+XsSoQ5KNFfh5XmkZIHJN7H/b7XTUrdAU725q8/2QrENCRT7KC+0bFRWhlslcqM3MHfTw0e9RYSRwhiB78hButv02f5hFW11SlYL7PtlfOn1vCOIODFx9K+nfFe9kGMQb8VjILzNOdrDtySUWjlZnCmbK4j2bueaz+LeZz7Zadlem7wUve2DCgh35gm4/1aQTGOY/9BYx8oww2doFskMR/eZEOau3LaaDSgq7Ko/g9/PMhnQbu9R3pB/3JJdC5rqK6xvcrdfzX1I/Eap6WMXqjRMJ4kD47sVanqpM/y69aGMV9J8u83ASFbKMs81Z/AyrWFOyf+cEBHcWU8GSaB4LpfjQH2J7QGWPTJivupsiD7m0VLgMA8gv+tue2zPBfbo
X-MS-Exchange-AntiSpam-MessageData: CdgGRP3WW2Jpyr3lq19JBzSQQtPBtbr99XQd/6RcKWw4Q9lpO/9VKvdTxgaWdMGLMoggLh2pR9D0i2Xs65xJbBb/zeEdgSika3wkC/kgrVfjEnr/9kdPWGYIKplezY9osc2LvrwZfBInjiEIbEcURgu9aCfgueVqIQEbwi+2Ark=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8d4d18-edc5-46ba-4777-08d7d9a1ce43
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:42:07.1541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBd89QH5g/dNDpvWhW5hNBGpAmmkAbihWv2igZq1/Oq8aCXs044UFZ5jEKHEb//6IKr3geHeJSfpkfnljRxXVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2555
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Tony Cheng <Tony.Cheng@amd.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
In some usecases, like tiled display, the stream and plane configuration
can be setup in a way where the caller expects DAL to perform the
clipping, eg:

P0:
src_rect(0, 0, w, h)
dst_rect(0, 0, w, h)

P1:
src_rect(w, 0, w, h)
dst_rect(0, 0, w, h)

Cursor is enabled on both streams with the same position.

This can result in double cursor on tiled display, even though this
behavior is technically correct from the DC interface point of view.

We need a mechanism to control this dynamically.

[How]
This is something that should live in the DM layer based on detection
of the specified configuration but it's not something that we really
have enough information to deal with today.

Add a flag to the cursor position state that specifies whether we
want DC to do the translation or not and make it opt-in and let
the DM decide when to do it.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      |  1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h           |  2 ++
 .../drm/amd/display/dc/dce110/dce110_hw_sequencer.c    | 10 ++++++++--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 10 ++++++++--
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 47af6e9a31bc..4b791e6909c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6380,6 +6380,7 @@ static int get_cursor_position(struct drm_plane *plane, struct drm_crtc *crtc,
 		y = 0;
 	}
 	position->enable = true;
+	position->translate_by_source = true;
 	position->x = x;
 	position->y = y;
 	position->x_hotspot = xorigin;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 25c50bcab9e9..a8dc3082e3e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -385,6 +385,8 @@ struct dc_cursor_position {
 	 */
 	bool enable;
 
+	/* Translate cursor x/y by the source rectangle for each plane. */
+	bool translate_by_source;
 };
 
 struct dc_cursor_mi_param {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 67f7ca346696..c279982947e1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2692,9 +2692,15 @@ void dce110_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	 *
 	 * This translation isn't affected by scaling so it needs to be
 	 * done *after* we adjust the position for the scale factor.
+	 *
+	 * This is only done by opt-in for now since there are still
+	 * some usecases like tiled display that might enable the
+	 * cursor on both streams while expecting dc to clip it.
 	 */
-	pos_cpy.x += pipe_ctx->plane_state->src_rect.x;
-	pos_cpy.y += pipe_ctx->plane_state->src_rect.y;
+	if (pos_cpy.translate_by_source) {
+		pos_cpy.x += pipe_ctx->plane_state->src_rect.x;
+		pos_cpy.y += pipe_ctx->plane_state->src_rect.y;
+	}
 
 	if (pipe_ctx->plane_state->address.type
 			== PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 9ef5747e5077..9f41efddc9bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3095,9 +3095,15 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	 *
 	 * This translation isn't affected by scaling so it needs to be
 	 * done *after* we adjust the position for the scale factor.
+	 *
+	 * This is only done by opt-in for now since there are still
+	 * some usecases like tiled display that might enable the
+	 * cursor on both streams while expecting dc to clip it.
 	 */
-	x_pos += pipe_ctx->plane_state->src_rect.x;
-	y_pos += pipe_ctx->plane_state->src_rect.y;
+	if (pos_cpy.translate_by_source) {
+		x_pos += pipe_ctx->plane_state->src_rect.x;
+		y_pos += pipe_ctx->plane_state->src_rect.y;
+	}
 
 	/**
 	 * If the position is negative then we need to add to the hotspot
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
