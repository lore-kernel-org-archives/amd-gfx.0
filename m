Return-Path: <SRS0=cqfu=BS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE3BC433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Aug 2020 20:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FDCD206B5
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Aug 2020 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=octaforge.org header.i=@octaforge.org header.b="eQ8dLqv6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S4c/Lb3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FDCD206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=octaforge.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D90106E265;
	Sat,  8 Aug 2020 20:51:22 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F9566E266
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2020 20:51:21 +0000 (UTC)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 9D314A82;
 Sat,  8 Aug 2020 16:42:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Sat, 08 Aug 2020 16:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=octaforge.org;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=B5rthDdjKEsXB
 vyMdPmCtdmPWyXog67nSwfZKnhkak0=; b=eQ8dLqv6Jm8k+jPF3lbT07ja6TBTp
 rQznzms5X0j2kJSQmsoPkUw1twkYdt7B9buL+JcEEZnrlo6jF3nFlBmyN/bMP3tn
 2Fpcpl+Um7yJ32sWgAX119onouZ/HEq84Fu+NiYPS2RCwYH1Yv4B6n9iBhTjN1nY
 3EAdXKbd5VUskq1hDupqRKG5fM9bVWPPmiclYoW055acyWighO3YJ2fRRzeigYZz
 wJPp0VL+Nm2w+IqsrXdbKvbRPT76hBcjr7zWa0fH3TyTs4uyI+FsmgX07+pCjuoU
 lRMdFSobKK4GA2WEwwGCme6R2ML+3tn+dVvkChqkC2R8vE1MxfuKgl6Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=B5rthDdjKEsXBvyMdPmCtdmPWyXog67nSwfZKnhkak0=; b=S4c/Lb3B
 eaiNrRpQ12Gjr4PZ9hLzMl1Y+jIw9NAIHzdojs51Hqemw34xYqvbudSX2KO1XgQ2
 4J06QC9SETxcyKb105iPJdOYupzOtHnhkWjJoiSgQOMz9voYldBfMgA87CfhFod1
 sQ6/hTTGeMG8CCKPh09MF/rPXpFzrJCOUhxUMEpHa/qhhYK0/YHAarAITq0bUiiG
 cXvVJUvqJC/PrMp+7UJW+yAro+6ttjMJKOL6QXA2LXiBIOGV/MaFrF9ukOQsOVZf
 k2ShSiGB3iZCX7fG82oG4b18ZyIVCvTyII8r193YqVbW5bBDEBvkFSMO7+VrRORB
 qHo5AIY9uRDZgA==
X-ME-Sender: <xms:Tg4vXwJO4DcJ9lDNbMHNqpKPtnaN85YB0F7S_O2nU3hVyssU5jGeRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkeeggddufedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
 dtredttdenucfhrhhomhepffgrnhhivghlucfmohhlvghsrgcuoegurghnihgvlhesohgt
 thgrfhhorhhgvgdrohhrgheqnecuggftrfgrthhtvghrnhepvedvheeuueevffetvdeggf
 ehleduheejtdetfffgvedtveeiudelhefhuedvudffnecukfhppeelgedrudduvddruddv
 kedrudekleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpegurghnihgvlhesohgtthgrfhhorhhgvgdrohhrgh
X-ME-Proxy: <xmx:Tg4vXwIfZT6TiT9Is_0bK-PnPtwF4fMjuXPiZuKhzUWAYriHn96lPw>
 <xmx:Tg4vXwtYIrR2TzMn5OH785f_M6uhbPU43PDLxv_AlsBMit7xEq-FZQ>
 <xmx:Tg4vX9bKwIaI0fmlbTMJHnRLiS71ocGvq5DMu-haC9S0G43ozMKGxg>
 <xmx:Tg4vXwm395QadEe2YDTo2n7aAGLc3BUhwyN0u0hFV3801lQkDzdCDQ>
Received: from localhost.localdomain (ip-94-112-128-189.net.upcbroadband.cz
 [94.112.128.189])
 by mail.messagingengine.com (Postfix) with ESMTPA id 6E3283280059;
 Sat,  8 Aug 2020 16:42:53 -0400 (EDT)
From: Daniel Kolesa <daniel@octaforge.org>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu/display: use GFP_ATOMIC in
 dcn20_validate_bandwidth_internal
Date: Sat,  8 Aug 2020 22:42:35 +0200
Message-Id: <20200808204235.12313-2-daniel@octaforge.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200808204235.12313-1-daniel@octaforge.org>
References: <20200808204235.12313-1-daniel@octaforge.org>
MIME-Version: 1.0
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
Cc: Daniel Kolesa <daniel@octaforge.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GFP_KERNEL may and will sleep, and this is being executed in
a non-preemptible context; this will mess things up since it's
called inbetween DC_FP_START/END, and rescheduling will result
in the DC_FP_END later being called in a different context (or
just crashing if any floating point/vector registers/instructions
are used after the call is resumed in a different context).

Signed-off-by: Daniel Kolesa <daniel@octaforge.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 991eddd10952..c31d1f30e505 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3141,7 +3141,7 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	int vlevel = 0;
 	int pipe_split_from[MAX_PIPES];
 	int pipe_cnt = 0;
-	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_KERNEL);
+	display_e2e_pipe_params_st *pipes = kzalloc(dc->res_pool->pipe_count * sizeof(display_e2e_pipe_params_st), GFP_ATOMIC);
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	BW_VAL_TRACE_COUNT();
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
