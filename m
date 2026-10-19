Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19A1606A31D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 09:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nasledov.com header.i=@nasledov.com header.a=rsa-sha256 header.s=mail header.b=k58Zbnxz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535CF10E848;
	Tue, 20 Oct 2026 09:19:19 +0000 (UTC)
X-Greylist: delayed 412 seconds by postgrey-1.36 at gabe;
 Mon, 19 Oct 2026 23:50:37 UTC
Received: from smtpauth.rollernet.us (smtpauth.rollernet.us [208.79.240.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553AA10F0F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 23:50:37 +0000 (UTC)
Received: from smtpauth.rollernet.us (localhost [127.0.0.1])
 by smtpauth.rollernet.us (Postfix) with ESMTP id 7BC0F2801D03;
 Mon, 19 Oct 2026 16:43:38 -0700 (PDT)
Received: from nasledov.com (162-224-188-88.lightspeed.sntcca.sbcglobal.net
 [162.224.188.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by smtpauth.rollernet.us (Postfix) with ESMTPSA;
 Mon, 19 Oct 2026 16:43:37 -0700 (PDT)
Received: from deepthot.lan.foggyden.org
 (76-210-4-7.lightspeed.sntcca.sbcglobal.net [76.210.4.7])
 by nasledov.com (Postfix) with ESMTPSA id B7C56FF889;
 Mon, 19 Oct 2026 16:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nasledov.com;
 s=mail; t=1792453416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CQTotrkNMR4MpCie0Y79Xge9qGBIr2fldIVNOxUBLz8=;
 b=k58Zbnxzy6Qub2scFaWuAMONHIsUafTLG0TnqcU/JN7/TrZLZPLrGKHbAJ203qgRY51bAG
 h/jXzZuJbLnxdQ5wzV96kVdxH1HyYgNQG6oVJwfDrexlzjlS3cXH5vITJ6LtnYQNhjFN1j
 qI9RMILUG4PcuC8nWR0xDCp+1n2bC341/RqSuiTTe5xnfzCZx/FTxL7Sp/1JEf/wXKM/Kn
 KDXDrqCeO5ZdbEMw0WjYuoMr95KDTcScuS6ZpMyzwA/9quBMyRxohavvYFZ/caoD/RITyL
 am/epeSazMPPIe2FlUZXgFwJgn4z9+Mbw50n75QjEAJr2gF+yCsmqW/AojwI5w==
From: Misha Nasledov <misha@nasledov.com>
To: misha@nasledov.com,
	amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Drop clock requirements on DCN32 when no
 displays are active
Date: Mon, 19 Oct 2026 16:42:32 -0700
Message-ID: <20261019234232.33760-1-misha@nasledov.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rollernet-Abuse: mailto:abuse@rollernet.us https://www.rollernet.us/policy
X-Rollernet-Submit: Submit ID 1fdfa3.6ad6ab29.2b0d8.0
X-Mailman-Approved-At: Tue, 20 Oct 2026 09:19:18 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_dm builds the new dc_state as a copy of the old one. When the last
stream is removed, dml1_validate() returns early on pipe_cnt == 0 and
never reaches dcn32_calculate_dlg_params(), so bw.dcn.clk keeps the
dramclk/dcfclk/fclk requirements of the display that was just turned off.
dcn32_update_clocks() then keeps those hard minimums applied.

On an RX 7900 XTX this leaves UCLK at 456 MHz and DCFCLK at 637 MHz with
the monitor off, and the board idles at 28.4 W. With this change they
drop to 96 MHz and 145 MHz and board power falls to 15.3 W.

Reset the clock requirements in that case, as calculate_dlg_params()
already does when no HUBP is active and as the DML2 path does for
stream_count == 0.

Signed-off-by: Misha Nasledov <misha@nasledov.com>
---
Tested on an RX 7900 XTX on v7.2.11, where the patch applies cleanly.
This version is against amd-staging-drm-next.

I used an LLM to help trace the clock path and draft this change, and
I reviewed and tested it myself.

DCN 2.0 and 2.1 (dcn20_validate_bandwidth_internal() and
dcn21_validate_bandwidth_fp() in dml/dcn20/dcn20_fpu.c) and DCN 3.0
(dcn30_validate_bandwidth()) take the same pipe_cnt == 0 early exit, so
they probably keep stale clocks with all displays off as well. I've left
them alone because I only have DCN 3.2 hardware to test on. I'm happy to
send the same change for them if that's wanted.

 .../display/dc/resource/dcn32/dcn32_resource.c    | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index c9eba16ef359..c22ffbe74d9b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1941,8 +1941,21 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, enum dc_valid
 	out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, validate_mode);
 	DC_FP_END();
 
-	if (pipe_cnt == 0)
+	if (pipe_cnt == 0) {
+		/* The context is a copy of the previous state, so without this the
+		 * clocks the last display needed stay applied with all displays off.
+		 */
+		context->bw_ctx.bw.dcn.clk.socclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = true;
+		context->bw_ctx.bw.dcn.clk.num_ways = 0;
 		goto validate_out;
+	}
 
 	if (!out)
 		goto validate_fail;
-- 
2.55.0

