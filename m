Return-Path: <SRS0=w0EQ=5V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1553C2BA19
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53C320644
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2020 20:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rwLdQTBX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53C320644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76CE46E2A9;
	Sun,  5 Apr 2020 20:41:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F0F6E2A5
 for <amd-gfx@lists.freedesktop.org>; Sun,  5 Apr 2020 20:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kwuup0+sBwW0l3uBu8+IJSoAH5aPMjNpHeyvukDf8R3vriIROZXR+cTS2k32NCTxFq/wRWUlG7WpCclcl3pCJt/Iu62clZkoVcvfc1hJsEgkSGhYq0y9KcxAd8GHVaRGQR/6KZvZ/GtKAleHvwy6XtXU4r8StGpLfsLNTGw2MLZtF2MvrDxGqJHuori+ygV/7J458+GFJKNMQ2Ptxj8HpCuDKVeMV5b7O62sTC3s1tgHUo9DeMJYzkncEQFXHDP9v9xnr3PTg3/O6CDO+Iph8G+DNPx3d50Xsm+IKXZy8Ub1PFhZOkgzBSO+M+f40RPwC7Hw7vj0UsTwM+6BJb1b0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3ba8BJw9E6u4PBkvZT29lMI6JvnQt9YwCULAFRQ9+M=;
 b=kUgMzN5NGnW6pn4xF8MvnC/HuQoVm1WT2/D79P4K/F5pTdmRHjQgPE416ypBl5mk/Marzp+vTJ3Mrx10+9A30sciH1VSR4EBjwmHBv3yosFuflpZNrmD6AF7nE8qn2C06gJzZK9eksS3VfoHdkzHGlf6DbSd2H02dzfv3edbSg0Omp+5D2Qy5FQavCqYccL+xXzb+t3KLCgELW8j1A58Z88EyIxSrjL+vJoJleo4/zGP/YlyQ4BFskjQhGkFQrvH4yTfg7uqCdQYeOVe04YMPtXkZ79rFNINV97nN9MsQJc9Jicpg/aeCQJ5Il0yoCcj4NpBSKF+EJusuS/NNN3Wog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3ba8BJw9E6u4PBkvZT29lMI6JvnQt9YwCULAFRQ9+M=;
 b=rwLdQTBXVWZ4x1+D+uzNmCDzZM5cmeOz3bR0Fy37Y4ZFDiLY6/6ygi/vC4nJ44kFECM2Sxk+H6zhH6FOfMLseO6oWmq0KKuTsxr+rY42Q+bO3x2fhlDKF9j+NFxysJYccf1Gxr8M/hP+FPQnNJpnNQvtvIR02F9jHbOmHb41Dbc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2555.namprd12.prod.outlook.com (2603:10b6:907:b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Sun, 5 Apr
 2020 20:41:52 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2878.018; Sun, 5 Apr 2020
 20:41:52 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/36] drm/amd/display: Translate cursor position by source
 rect
Date: Sun,  5 Apr 2020 16:40:53 -0400
Message-Id: <20200405204115.683559-15-Rodrigo.Siqueira@amd.com>
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
 Transport; Sun, 5 Apr 2020 20:41:52 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfb4155f-9b70-415c-2d91-08d7d9a1c5b2
X-MS-TrafficTypeDiagnostic: MW2PR12MB2555:|MW2PR12MB2555:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB255504FBB7AB1F6E8978674598C50@MW2PR12MB2555.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
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
X-Microsoft-Antispam-Message-Info: vbwHA8RBBAEZq+OV+pniVEr9ziXaZvFDlIUggaJAM9HoQsnLQ5q8mxxjnlanC++QXkR+4vZzDSFThSQCQnqpoQLBja42fDb4f/tXzBZ/EaGUGxCk60zRGzncmqZEGGuu324hZ6AnOo6NIptZXqFDX5U2F2lOOxSC65RHQYdlMZp5H4timLWI0E0MKtHKIrp3sldnWQexrYzPa7jYATX5gwEboLdoJZcmAKu6IXDMJ+h+kGDUqpQSJ1pcD5fyHOT2zK/m71dWWK/l+Ob1QmQM8Q7EEq89AsHwNJv/eCpaeEQsoSGAji9y21Qc8nqlFFV0nbgv7M6OkufiLgxmZZaEoY/f+OBbz8Bcz/R0Aza44IsFgDDk6thKbdnmFtdoi1vgg9tKZjkuLW5Ck5OOQb0SHt7ncljkCg+NGSfgloDPtR28QLRE3iXdPhdDSFyHGvmS
X-MS-Exchange-AntiSpam-MessageData: C7ydx1t0UgWP9P0cdjXzTaqg2SBDrR8zkfrpNI1AJdCIxIfWB4fuX0Gc8NE8kLja4wLRcFSTJr25vUXjLH2hIFKmoYZuw1OaZFQpcRLz0EYUtr7sqPYgpIZwm+Yjfgkib6JMLDnj/3TevI6YHob+JZO9WoPIkAejUAba4UM87To=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb4155f-9b70-415c-2d91-08d7d9a1c5b2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2020 20:41:52.7624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WoRtAla8855egxJhM0SCdytfffDmXT1rnc6RZEmXYTyn7mV4Bb9LvQ+TaxOhVKqWqUkk3uqPExhpNZ4khTFsg==
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Zhan Liu <Zhan.Liu@amd.com>,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Cursor is drawn as part of the framebuffer for a plane on AMD hardware.
The cursor position on the framebuffer does not change even if the
source rect viewport for the cursor does. This causes the cursor to be
clipped.

The following IGT tests fail as a result of this issue:

- kms_plane_cursor@pipe-*-viewport-size-*

[How]
Offset cursor position by plane source rect viewport. If the viewport
is unscaled then the cursor is now correctly positioned on any
plane - primary or overlay.

There is still a hardware limitation for dealing with the cursor size
being incorrectly scaled but that's not something we can address.

Add some documentation explaining some of this in the code while we're
at it.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Reviewed-by: Zhan Liu <Zhan.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 34 ++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index ac133fac4dfc..9ef5747e5077 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -3066,12 +3066,44 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 	int x_pos = pos_cpy.x;
 	int y_pos = pos_cpy.y;
 
-	// translate cursor from stream space to plane space
+	/**
+	 * DC cursor is stream space, HW cursor is plane space and drawn
+	 * as part of the framebuffer.
+	 *
+	 * Cursor position can't be negative, but hotspot can be used to
+	 * shift cursor out of the plane bounds. Hotspot must be smaller
+	 * than the cursor size.
+	 */
+
+	/**
+	 * Translate cursor from stream space to plane space.
+	 *
+	 * If the cursor is scaled then we need to scale the position
+	 * to be in the approximately correct place. We can't do anything
+	 * about the actual size being incorrect, that's a limitation of
+	 * the hardware.
+	 */
 	x_pos = (x_pos - x_plane) * pipe_ctx->plane_state->src_rect.width /
 			pipe_ctx->plane_state->dst_rect.width;
 	y_pos = (y_pos - y_plane) * pipe_ctx->plane_state->src_rect.height /
 			pipe_ctx->plane_state->dst_rect.height;
 
+	/**
+	 * If the cursor's source viewport is clipped then we need to
+	 * translate the cursor to appear in the correct position on
+	 * the screen.
+	 *
+	 * This translation isn't affected by scaling so it needs to be
+	 * done *after* we adjust the position for the scale factor.
+	 */
+	x_pos += pipe_ctx->plane_state->src_rect.x;
+	y_pos += pipe_ctx->plane_state->src_rect.y;
+
+	/**
+	 * If the position is negative then we need to add to the hotspot
+	 * to shift the cursor outside the plane.
+	 */
+
 	if (x_pos < 0) {
 		pos_cpy.x_hotspot -= x_pos;
 		x_pos = 0;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
