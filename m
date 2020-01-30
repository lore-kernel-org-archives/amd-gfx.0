Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6EAC2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 18:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016E920658
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 18:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XI1uto9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016E920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2836FA1A;
	Thu, 30 Jan 2020 18:29:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9266FA1A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 18:29:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lcu3ENRFEESAh/+YT4mUyB0Yd8LnAdObPiNWQC4Vuo5liveD/5QwPsJvyy/Acu/Du0V6HkOdBoYT6WN2Pc4+c5aZ05OozWiPMyRnjHNfCxc7n9/ifkpBnADVY/9yMbMnPBLYeunIrJbONhq2Wg76hb+2M0sc3UPWiLGN9d/qSRkLyNCEl7gf7ttmaOEz58qnk+nykOgwFDcu916PIZJLgJ66V/L3aBEBHdvJ9Zt4XcC70psiQNscyw8edpWWWDO4H2Ii7jyoUBx7ifLBycgr/rr4saFgC7DaZF7CY3NhgwHgpfFBeIf3aXnGqRM+X8IJp0ExmL5iJSpPp53R0O2bJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvInSnNrxUNT8apt4Z3TT6mJ/wB/6dDA+CgMpAVZeOY=;
 b=Lc574Wg57PkftvWxkNEKx63Di3PehomydgROB1NLOQKtZfDlNxvdvqwSFq88FJr5xi5inIV3K9YKBJl787woGtmmU84C+hWhFPfnXf7QK0J101KAXNoMhs0dgSQYGXXzS9rKsw5NXCBOVlTpwPpAu7vNMixA51xNMrCwrOD+/zuQSeT/9FJhnCWzS+u/JyQHExWwuIAtrmuN5mbY/uKfGocBRzslI0XDEls09DIfKucr/2lLSMB7/75PbtUTu5C8QKgZH+2bdv8g8kXhq6orO3xtkntDqYRBT1nUmyhiMs5lLCQmMlZSb0JSsIYVlCsfLY1F9USw7RXhK/ZDd9/+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvInSnNrxUNT8apt4Z3TT6mJ/wB/6dDA+CgMpAVZeOY=;
 b=XI1uto9WjswLKnM0r8aRn10OhxdU07PZt/Cc0HBi6rIR7NdT1C2st2uEeH537FNHczpv3M8jNBF9mVm1mwVz9oXCTk03Xp9AWkyXJ99moBt0tWLMgfihe9vzCv5tVLmVfuJAZAl2jLARI23YqYrhXrB9o+mL6K/L83cMdmRZkzI=
Received: from BN4PR12CA0007.namprd12.prod.outlook.com (2603:10b6:403:2::17)
 by BN6PR1201MB0113.namprd12.prod.outlook.com (2603:10b6:405:55::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20; Thu, 30 Jan
 2020 18:29:10 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eae::202) by BN4PR12CA0007.outlook.office365.com
 (2603:10b6:403:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.27 via Frontend
 Transport; Thu, 30 Jan 2020 18:29:10 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Thu, 30 Jan 2020 18:29:10 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jan
 2020 12:29:10 -0600
Received: from kazvm2.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jan 2020 12:29:09 -0600
From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Only enable cursor on pipes that need it
Date: Thu, 30 Jan 2020 13:29:05 -0500
Message-ID: <20200130182905.28249-1-nicholas.kazlauskas@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(428003)(189003)(199004)(2616005)(356004)(1076003)(4326008)(70206006)(36756003)(44832011)(426003)(70586007)(8936002)(26005)(86362001)(6916009)(186003)(336012)(2906002)(81156014)(498600001)(81166006)(5660300002)(7696005)(8676002)(6666004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0113; H:SATLEXMB02.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9f0af53-8833-4f60-c98c-08d7a5b24caa
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0113:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB011304AA9D4005872C59AEABEC040@BN6PR1201MB0113.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02981BE340
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRX3wY0muNggf3IA/CiwE80b15npcunq8DDEAP85PvSYuSuFQlBkq/JuB1+fbJ+OGEvmFcI8TVe04l74rjkeyX+XWwXWTxXonn8FHtHiC8fBOceIW1sz4m23p0K5dIa2SPNXa9z2PKuX6NJ6IaxOuHZVDtrakvNoOSC2GuS3HrL8Txbqvn3YKgDPWc1NLhB2r+YUUE6VRX7Fr/m+C93NrPuVDwTjjveJYOWnDg55UHHkpdS2CSWhMfYDb57vkn+cj6SU11rOsPd8yKrMeUrsEB04LcgR1AwNqKNGy74P5YzWAx2R1uNsstSsZz2BeRqQ1oFi8GFAotH4+TSx0d/0m7PoFlJjUD9El1tDXguSKRxGMLEP+YQ+9yY7FKTNKo54Sewu8KS9zOEEcbMMGhZFHEQDIHtPXymbmkBjvbDGs41+rBhvNwEP2/ULf2UtHyBv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2020 18:29:10.4817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f0af53-8833-4f60-c98c-08d7a5b24caa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0113
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
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
In current code we're essentially drawing the cursor on every pipe
that contains it. This only works when the planes have the same
scaling for src to dest rect, otherwise we'll get "double cursor" where
one cursor is incorrectly filtered and offset from the real position.

[How]
Without dedicated cursor planes on DCN we require at least one pipe
that matches the scaling of the current timing.

This is an optimization and workaround for the most common case where
the top-most plane is not scaled but the bottom-most plane is scaled.

Whenever a pipe has a parent pipe in the blending tree whose recout
fully contains the current pipe we can disable the pipe.

This only applies when the pipe is actually visible of course.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index f2127afb37b2..1008ac8a0f2a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2911,6 +2911,33 @@ void dcn10_update_dchub(struct dce_hwseq *hws, struct dchub_init_data *dh_data)
 	hubbub->funcs->update_dchub(hubbub, dh_data);
 }
 
+static bool dcn10_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
+{
+	struct pipe_ctx *test_pipe;
+	const struct rect *r1 = &pipe_ctx->plane_res.scl_data.recout, *r2;
+	int r1_r = r1->x + r1->width, r1_b = r1->y + r1->height, r2_r, r2_b;
+
+	/**
+	 * Disable the cursor if there's another pipe above this with a
+	 * plane that contains this pipe's viewport to prevent double cursor
+	 * and incorrect scaling artifacts.
+	 */
+	for (test_pipe = pipe_ctx->top_pipe; test_pipe;
+	     test_pipe = test_pipe->top_pipe) {
+		if (!test_pipe->plane_state->visible)
+			continue;
+
+		r2 = &test_pipe->plane_res.scl_data.recout;
+		r2_r = r2->x + r2->width;
+		r2_b = r2->y + r2->height;
+
+		if (r1->x >= r2->x && r1->y >= r2->y && r1_r <= r2_r && r1_b <= r2_b)
+			return true;
+	}
+
+	return false;
+}
+
 void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_cursor_position pos_cpy = pipe_ctx->stream->cursor_position;
@@ -2956,6 +2983,9 @@ void dcn10_set_cursor_position(struct pipe_ctx *pipe_ctx)
 			== PLN_ADDR_TYPE_VIDEO_PROGRESSIVE)
 		pos_cpy.enable = false;
 
+	if (pos_cpy.enable && dcn10_can_pipe_disable_cursor(pipe_ctx))
+		pos_cpy.enable = false;
+
 	// Swap axis and mirror horizontally
 	if (param.rotation == ROTATION_ANGLE_90) {
 		uint32_t temp_x = pos_cpy.x;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
