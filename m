Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B5606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=csUXIFpG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73B0110E229;
	Mon, 26 Oct 2026 13:32:50 +0000 (UTC)
X-Greylist: delayed 302 seconds by postgrey-1.36 at gabe;
 Mon, 26 Oct 2026 11:17:09 UTC
Received: from mta1.migadu.com (out-202.mta1.migadu.com [95.215.58.202])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A85210E074
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 11:17:09 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=Jv1JLity/HyGd23H851ZcH74mWl+hMmP7+oxHglKuF0=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793013427; v=1; x=1793618227;
 b=csUXIFpGctBodcMy7F6Us8oNPvAjsxPucQL+Jw6EYKtbiIPTH/WL97rYDlM3KwsEK1mHLQSy
 LYmih7LTfl8VYs7NE3p5/bAzNQ+dYA+2HrQA0DLEJpZ/houPaOlAALxPyfLRGt5zw1t7bb/8ceZ
 g3SMIL+5buD/vaCkbItNvqfk=
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id a4e10bcd9f5fb55e;
 Mon, 26 Oct 2026 11:11:03 +0000
X-Mizu-Trace-ID: a4e10bcd9f5fb55e
X-Migadu-Flow: FLOW_OUT
From: Jackie Liu <liu.yun@linux.dev>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix logger leak on perf trace allocation
 failure
Date: Mon, 26 Oct 2026 19:10:47 +0800
Message-ID: <20261026111047.97178-1-liu.yun@linux.dev>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 13:32:48 +0000
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jackie Liu <liuyun01@kylinos.cn>

dc_construct_ctx() allocates a logger and stores an alias in dc->dml.logger
before allocating the performance trace object. If dc_perf_trace_create()
fails, the function frees dc_ctx without releasing the logger. Since
dc->ctx is assigned only after the trace allocation succeeds,
dc_destruct() cannot reclaim the logger on this error path.

Free the logger before discarding dc_ctx and clear dc->dml.logger to avoid
leaving a dangling alias after the failed construction.

Fixes: 5d72e247e58c ("drm/amd/display: switch DC over to the new DRM logging macros")
Cc: stable@vger.kernel.org
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1143916391e79..03179633cd036 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1022,6 +1022,8 @@ static bool dc_construct_ctx(struct dc *dc,
 
 	dc_ctx->perf_trace = dc_perf_trace_create();
 	if (!dc_ctx->perf_trace) {
+		kfree(dc_ctx->logger);
+		dc->dml.logger = NULL;
 		kfree(dc_ctx);
 		ASSERT_CRITICAL(false);
 		return false;
-- 
2.43.0

