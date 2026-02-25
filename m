Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC74FD45FA
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 23:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B1FB10E0A7;
	Wed, 25 Feb 2026 23:48:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ubuntu.com header.i=@ubuntu.com header.b="qWx7r0gI";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A80F10E0A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 23:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ubuntu.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-953a8a3ca9; t=1772063291;
 bh=a72o1eKooeGmHtbJLLLnIbzueZGjbSAZo2/6cP1YAyM=;
 b=qWx7r0gIFkZUa6dLanLCWFIeIDiBoPwSYx8fC5iYwa8HeUCuZvfaTVMJ5auUsjM6P+sLB2CQ1
 kjd43QElr7KnHFMy4PiEO4BGObVGfa5OR75pUidyDGH9Jh33IrhGs0h7idTYXe7Bil5xoDmaTz1
 qLdiQhN7LEuzELxsD44mg2vaosqaM8Qv7EI42v5T1Nggy0nuCT5BN1NRMwvdFaS9FtOkNZ1bisK
 aFZyRzGfCXQdx9z02x+Tjhq4mUWDJVZ9PnAKsRqUarBN9o/dt7gnPovEV7VMsQd5qfumnUXs8f3
 O8yrujZnL2WeoqP0rP+xFleDSVuN2zBDRY/fJiDZKtVQ==
X-Forward-Email-ID: 699f8a3474fd58a9a37ae2b5
X-Forward-Email-Sender: rfc822; jpeisach@ubuntu.com, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.24
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Joshua Peisach <jpeisach@ubuntu.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Joshua Peisach <jpeisach@ubuntu.com>
Subject: [PATCH] amdgpu/display/dc/link: fix sparse warning on assigning int
 as nullptr
Date: Wed, 25 Feb 2026 18:46:03 -0500
Message-ID: <20260225234707.37597-1-jpeisach@ubuntu.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes a sparse message about link_stream being assigned an int
value of 0, instead of NULL.

Signed-off-by: Joshua Peisach <jpeisach@ubuntu.com>
---
 drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 693d852b1..918993a3c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -957,7 +957,7 @@ void dp_set_preferred_link_settings(struct dc *dc,
 {
 	int i;
 	struct pipe_ctx *pipe;
-	struct dc_stream_state *link_stream = 0;
+	struct dc_stream_state *link_stream = NULL;
 	struct dc_link_settings store_settings = *link_setting;
 
 	link->preferred_link_setting = store_settings;
-- 
2.51.0

