Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65526C83006
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 15:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9B32074A
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 15:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=octaforge.org header.i=@octaforge.org header.b="csz8MmWP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuCCKBAK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9B32074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=octaforge.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026BC6EF29;
	Wed, 29 Apr 2020 15:08:51 +0000 (UTC)
X-Greylist: delayed 334 seconds by postgrey-1.36 at gabe;
 Wed, 29 Apr 2020 15:08:49 UTC
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com
 [64.147.123.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AEAF6E06E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2020 15:08:49 +0000 (UTC)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id 7A6858C5;
 Wed, 29 Apr 2020 11:03:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Wed, 29 Apr 2020 11:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=octaforge.org;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm3; bh=R+O/SRNVCj0j0
 R6wF8ujAwubHvk+Rj/BFOZjLfrpcRs=; b=csz8MmWPmC8Jv+Rq06zhrhF1Q/v0z
 tje9yKwQiRJGt5/51c/RM016RM/sen0vwe58dBBnncdOt3L94OBy8XW1L/xYiT0E
 SfZQzhaor2gJwHFGKhKwptDPqRL9DYgMCvZfiiTl+s1MXmsglGo6JlzUqFcVK1zP
 fS91m0ZBwQ9mbsFIkWCceLPOnzTOo/a92JIGsbT7tCLXACJBOWij5UZZDpqizZwz
 /9SCGmmo+vMdgozvgWGVXWG3QKo3kpLa4cUZzqr6ZjZVqQDTcMqx8TuM2ZPw6z3Z
 mDX78qmUjoQSF+MIkdiTLxG2Yy4clBVbYbmVF0y9XHlBZdRstYHP00+BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=R+O/SRNVCj0j0R6wF8ujAwubHvk+Rj/BFOZjLfrpcRs=; b=fuCCKBAK
 jqWFLTFglLq2MKtaB80MesBetqbcbUS2q0c7og8+xXV9u6pBAkCgHl0+WrR8UNUN
 5gx3JTbUR/WReR8Dl0LI7ANEnvg0/xyhhpH82Zhsj0VlKY0up+jtKjhj3xmfbuBy
 ykwG92qHgypCz4HEZPLqn/4SZZ+hSXZT7Q45q4hbze5LQhTWhPSSGY4ArnK0rOHQ
 8r8XYfZoCg9iHlZa7O3dkKR+KWkP6ePA3hfSiWUqCgl4ageBO+TD5+Ox4qq7wkbv
 NGSybYB8l2GZ+30wA5fXNQuXbW8wwmjm7Dhm7UJmua3NiqpKkGUeD3HIWN4BT2zg
 m8yON0OIRwkfwA==
X-ME-Sender: <xms:NZepXpZug7u_BqCYZMsQSXywmf8J38SXE3U8dEIU3jSaynG1VbmO8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdekfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
 ertddtnecuhfhrohhmpeffrghnihgvlhcumfholhgvshgruceouggrnhhivghlsehotght
 rghfohhrghgvrdhorhhgqeenucggtffrrghtthgvrhhnpeevvdehueeuvefftedvgefghe
 eludehjedtteffgfevtdevieduleehhfeuvdduffenucfkphepleegrdduuddvrdduvdek
 rddukeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epuggrnhhivghlsehotghtrghfohhrghgvrdhorhhg
X-ME-Proxy: <xmx:NZepXkrPvZOvsB5x6W35i_ieDYe0WuKc3_Woe1tLBr9nA3TIitivfg>
 <xmx:NZepXm-r8HWcIc4e1DLtQGExDZmSn9C_h40IlHFXQZ2oStAFbeEOCA>
 <xmx:NZepXr_B0czflEOI7IeOvaIzvihDRzORCFQZn2RGIOFaENnjr7hHJA>
 <xmx:NpepXimJ89T77DA8XbCBNKz6g9v8yj1jLxonr6rYyXyaGovMDDbm5A>
Received: from localhost.localdomain (ip-94-112-128-189.net.upcbroadband.cz
 [94.112.128.189])
 by mail.messagingengine.com (Postfix) with ESMTPA id 062343280063;
 Wed, 29 Apr 2020 11:03:16 -0400 (EDT)
From: Daniel Kolesa <daniel@octaforge.org>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amd/display: work around fp code being emitted
 outside of DC_FP_START/END
Date: Wed, 29 Apr 2020 17:02:36 +0200
Message-Id: <20200429150236.4626-2-daniel@octaforge.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429150236.4626-1-daniel@octaforge.org>
References: <20200429150236.4626-1-daniel@octaforge.org>
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

The dcn20_validate_bandwidth function would have code touching the
incorrect registers emitted outside of the boundaries of the
DC_FP_START/END macros, at least on ppc64le. Work around the
problem by wrapping the whole function instead.

Signed-off-by: Daniel Kolesa <daniel@octaforge.org>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e310d67..1b0bca9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3034,25 +3034,32 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 	return out;
 }
 
-
-bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
-		bool fast_validate)
+/*
+ * This must be noinline to ensure anything that deals with FP registers
+ * is contained within this call; previously our compiling with hard-float
+ * would result in fp instructions being emitted outside of the boundaries
+ * of the DC_FP_START/END macros, which makes sense as the compiler has no
+ * idea about what is wrapped and what is not
+ *
+ * This is largely just a workaround to avoid breakage introduced with 5.6,
+ * ideally all fp-using code should be moved into its own file, only that
+ * should be compiled with hard-float, and all code exported from there
+ * should be strictly wrapped with DC_FP_START/END
+ */
+static noinline bool dcn20_validate_bandwidth_fp(struct dc *dc,
+		struct dc_state *context, bool fast_validate)
 {
 	bool voltage_supported = false;
 	bool full_pstate_supported = false;
 	bool dummy_pstate_supported = false;
 	double p_state_latency_us;
 
-	DC_FP_START();
 	p_state_latency_us = context->bw_ctx.dml.soc.dram_clock_change_latency_us;
 	context->bw_ctx.dml.soc.disable_dram_clock_change_vactive_support =
 		dc->debug.disable_dram_clock_change_vactive_support;
 
 	if (fast_validate) {
-		voltage_supported = dcn20_validate_bandwidth_internal(dc, context, true);
-
-		DC_FP_END();
-		return voltage_supported;
+		return dcn20_validate_bandwidth_internal(dc, context, true);
 	}
 
 	// Best case, we support full UCLK switch latency
@@ -3081,7 +3088,15 @@ bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
 
 restore_dml_state:
 	context->bw_ctx.dml.soc.dram_clock_change_latency_us = p_state_latency_us;
+	return voltage_supported;
+}
 
+bool dcn20_validate_bandwidth(struct dc *dc, struct dc_state *context,
+		bool fast_validate)
+{
+	bool voltage_supported = false;
+	DC_FP_START();
+	voltage_supported = dcn20_validate_bandwidth_fp(dc, context, fast_validate);
 	DC_FP_END();
 	return voltage_supported;
 }
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
