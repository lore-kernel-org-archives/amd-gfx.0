Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC85C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5AB22077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LEGf6nLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AB22077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A0DD6EB92;
	Wed, 11 Dec 2019 15:34:21 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760040.outbound.protection.outlook.com [40.107.76.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3DAC6EB92
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6IwphZn3Ipgyl/UZbPuCIOzRWkWoQmliFKaI1axggE+F+iDwI/fNdVUYXf6foLlVJA1PRBc4ueuKdKWvCQFl8PFVf8sPzZtwaQT5EYZN8Lms1RExFAG3KbDqXA79Covo9gNUrsgSFVWotsw6jQ8x8E90Yf73hd1IaVd1Kj1omHsoDXte7JEGniBf6gXCW8rC019RBzEph5G3RZtMirFFTLqwCGCfXE1gdU0eYEubVlp0NbqTttUQ9gX4z7rfvfeWhgeQV/yQ+0khnapnQ77WKlGUnZR0RpNn74e2jA+w2Ox2DxaQw3a1hLuT2x9wJ6VoxnUJBsd24yA5OLlECuhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEyXT1V60kdecoIq40l9L3ngbKzppIeGuRN3R959R7A=;
 b=il6mvBv2+ZCP9kUnd+Ayc005XP0MgrWWD32UNfugnXgpP+YEKTuvsK2+E9eOr5K3yFYv9av3+UzRhBUkKSP/iHU0xnYwRIFU5n26vvhbWhhZnlXpDT45zpZNSJ+SbowY9i3u65K2gFMwtdsP2fM2hNdIZUEzgwJa563MA2x9nwQ5fs7jgQArNR+vqUQzrGap5U28ko3CsmBVWL/ln5sD1knSd34Mk/sM3Ju9XtXcgEcJTCYrjFKWTe5CABO1kMHAw46supY19QcYKXdU7Xi8HZVoGzJjeOiwagau3fgwbAJUYwnfY7XDVDLqtqSBwvoKISeoTUPUeUtfhff8favacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEyXT1V60kdecoIq40l9L3ngbKzppIeGuRN3R959R7A=;
 b=LEGf6nLPBXsOIbd+ApKyvTopA8OrDLaDudV0TgN+7L/wApp8OPpSEk1qsdDt0/vk00l+Ng6cOXLc+3flAb+8OZBLuqfPg/0dIxFPo+mlpUA/p27emx4anPjd0s3wU8gSfJfjkxZtkDCKvguW1k7ajyMKPhxgqFsEZ+4M4HWOkAc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:34:18 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:34:18 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 37/39] drm/amd/display: fix missing cursor on some rotated SLS
 displays
Date: Wed, 11 Dec 2019 10:32:51 -0500
Message-Id: <20191211153253.2291112-38-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f21d8d0-4437-464b-648b-08d77e4f84ee
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24917F89A8C926843C01B615985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(6666004)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtjFb+RcXDWf5K6t8UIYF30tHa4ev0QmE5l1q/tARJAOhNoNDH0pDBUSxkUQPjRk/TkGFV8Z/ay1vNPHtM9mqVDIpMqmp9MtBwHJ+434cshcsSzwdFiJRHA/B91TFuZ3lSSF34KTbG+mM3LxhkA70uvob2o97NptqglgYdaq6LdqNLhdKQE42RtpQXUpJtJEV850PIn13mV6QVaijboqKwm6antP/SEdp1TxS5A4bofaBSnX8oNBf+J2Zetb/1lhbwKXOfZoYxN+bIyJpam6QiiLr8b1+IcrcfCPTN/XBQau64OuuuE9biveyh3RJCVo/T54Ffxz4AMsmVaMhwKfs8DaThvd9OKW6tDOfAtk+/0QOPp3t8rcuZY49skyEimk4/x9hrJmyczF0W6PXhT3EFUk2WfIDcXtawAsYGPpkoOvF2PjkCV4WWm0HGcIQeFS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f21d8d0-4437-464b-648b-08d77e4f84ee
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:49.6265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aQd7C+1HqkZ0Q6ZO6tQzmGAbxpjhN0I25u1TBPCuPQ/i2IjQFNCfMeDIJabq/ZzPWtAOsSZCsB3WhoN1mFYNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Harry.Wentland@amd.com, Samson Tam <Samson.Tam@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Cursor disappears for some SLS displays that are rotated 180
and 270 degrees.  This occurs when there is no pipe split being
done ( ex. 3 or more displays ).  The cursor calculations assume
pipe splitting is done so when it calculates the new cursor
position in hwss.set_cursor_position(), it is out-of-bounds so
it disables the cursor in hubp.set_cursor_position().

[How]
In non pipe split cases, calculate cursor using viewport size
( width or height ) instead of viewport size * 2 ( the two
because pipe splitting divides the rectangle into two ).

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 51 +++++++++++++------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 9e53bbd5d2b5..9c55e4897fca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2916,6 +2916,8 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 		.rotation = pipe_ctx->plane_state->rotation,
 		.mirror = pipe_ctx->plane_state->horizontal_mirror
 	};
+	bool pipe_split_on = (pipe_ctx->top_pipe != NULL) ||
+		(pipe_ctx->bottom_pipe != NULL);
 
 	int x_plane = pipe_ctx->plane_state->dst_rect.x;
 	int y_plane = pipe_ctx->plane_state->dst_rect.y;
@@ -2948,6 +2950,7 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	// Swap axis and mirror horizontally
 	if (param.rotation == ROTATION_ANGLE_90) {
 		uint32_t temp_x = pos_cpy.x;
+
 		pos_cpy.x = pipe_ctx->plane_res.scl_data.viewport.width -
 				(pos_cpy.y - pipe_ctx->plane_res.scl_data.viewport.x) + pipe_ctx->plane_res.scl_data.viewport.x;
 		pos_cpy.y = temp_x;
@@ -2955,26 +2958,44 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	// Swap axis and mirror vertically
 	else if (param.rotation == ROTATION_ANGLE_270) {
 		uint32_t temp_y = pos_cpy.y;
-		if (pos_cpy.x >  pipe_ctx->plane_res.scl_data.viewport.height) {
-			pos_cpy.x = pos_cpy.x - pipe_ctx->plane_res.scl_data.viewport.height;
-			pos_cpy.y = pipe_ctx->plane_res.scl_data.viewport.height - pos_cpy.x;
-		} else {
-			pos_cpy.y = 2 * pipe_ctx->plane_res.scl_data.viewport.height - pos_cpy.x;
-		}
+		int viewport_height =
+			pipe_ctx->plane_res.scl_data.viewport.height;
+
+		if (pipe_split_on) {
+			if (pos_cpy.x > viewport_height) {
+				pos_cpy.x = pos_cpy.x - viewport_height;
+				pos_cpy.y = viewport_height - pos_cpy.x;
+			} else {
+				pos_cpy.y = 2 * viewport_height - pos_cpy.x;
+			}
+		} else
+			pos_cpy.y = viewport_height - pos_cpy.x;
 		pos_cpy.x = temp_y;
 	}
 	// Mirror horizontally and vertically
 	else if (param.rotation == ROTATION_ANGLE_180) {
-		if (pos_cpy.x >= pipe_ctx->plane_res.scl_data.viewport.width + pipe_ctx->plane_res.scl_data.viewport.x) {
-			pos_cpy.x = 2 * pipe_ctx->plane_res.scl_data.viewport.width
-					- pos_cpy.x + 2 * pipe_ctx->plane_res.scl_data.viewport.x;
-		} else {
-			uint32_t temp_x = pos_cpy.x;
-			pos_cpy.x = 2 * pipe_ctx->plane_res.scl_data.viewport.x - pos_cpy.x;
-			if (temp_x >= pipe_ctx->plane_res.scl_data.viewport.x + (int)hubp->curs_attr.width
-					|| pos_cpy.x <= (int)hubp->curs_attr.width + pipe_ctx->plane_state->src_rect.x) {
-				pos_cpy.x = temp_x + pipe_ctx->plane_res.scl_data.viewport.width;
+		int viewport_width =
+			pipe_ctx->plane_res.scl_data.viewport.width;
+		int viewport_x =
+			pipe_ctx->plane_res.scl_data.viewport.x;
+
+		if (pipe_split_on) {
+			if (pos_cpy.x >= viewport_width + viewport_x) {
+				pos_cpy.x = 2 * viewport_width
+						- pos_cpy.x + 2 * viewport_x;
+			} else {
+				uint32_t temp_x = pos_cpy.x;
+
+				pos_cpy.x = 2 * viewport_x - pos_cpy.x;
+				if (temp_x >= viewport_x +
+					(int)hubp->curs_attr.width || pos_cpy.x
+					<= (int)hubp->curs_attr.width +
+					pipe_ctx->plane_state->src_rect.x) {
+					pos_cpy.x = temp_x + viewport_width;
+				}
 			}
+		} else {
+			pos_cpy.x = viewport_width - pos_cpy.x + 2 * viewport_x;
 		}
 		pos_cpy.y = pipe_ctx->plane_res.scl_data.viewport.height - pos_cpy.y;
 	}
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
