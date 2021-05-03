Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F6BC43616
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:37:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B0F613CA
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B0F613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B45F6E952;
	Mon,  3 May 2021 16:37:18 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DC106E951;
 Mon,  3 May 2021 16:37:16 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13F17613BB;
 Mon,  3 May 2021 16:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620059836;
 bh=VUsUoSoPL5v+qZayowjA+mySGwhYA3TEbe5Rg7Vt3YI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JcU0M8V7+hrTS/KXjj+/7Uy5HDrmdB05EcYVVLzdzX4RlDWTBPj9VvJ1oROOyGdky
 voXuBh6bQ5Kd64yFACKTaaZJnciaSnOcEgEoiUaSvo48u6z6NzCxbZzKQ818W42WLs
 AkWedfAmyh4jG0dsE069CpExuKq38bBTQA2fW3DsyVwtPbgWZIeU2ZedeyrrT5qfYX
 XVawuC13/q8QqOuYw62OpJEIvt9XXWvjw9Zx5yWf2cSW6UhTQiyZwDGYkPBkoXQBGj
 n6SkMEa7UnxFqy+TLNQwSNXbs+8vftDvNpkD/Lr+WHtKkrjVVmK6PIgHyZJGyNOrWJ
 gZ7CaJ6QzU8wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.11 010/115] drm/amd/display: Return invalid state if
 GPINT times out
Date: Mon,  3 May 2021 12:35:14 -0400
Message-Id: <20210503163700.2852194-10-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503163700.2852194-1-sashal@kernel.org>
References: <20210503163700.2852194-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Wheeler <daniel.wheeler@amd.com>, dri-devel@lists.freedesktop.org,
 Wyatt Wood <wyatt.wood@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[ Upstream commit 8039bc7130ef4206a58e4dc288621bc97eba08eb ]

[Why]
GPINT timeout is causing PSR_STATE_0 to be returned when it shouldn't.
We must guarantee that PSR is fully disabled before doing hw programming
on driver-side.

[How]
Return invalid state if GPINT command times out. Let existing retry
logic send the GPINT until successful.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 17e84f34ceba..e0b195cad9ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -81,13 +81,18 @@ static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state)
 {
 	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
 	uint32_t raw_state;
+	enum dmub_status status = DMUB_STATUS_INVALID;
 
 	// Send gpint command and wait for ack
-	dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
-
-	dmub_srv_get_gpint_response(srv, &raw_state);
-
-	*state = convert_psr_state(raw_state);
+	status = dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
+
+	if (status == DMUB_STATUS_OK) {
+		// GPINT was executed, get response
+		dmub_srv_get_gpint_response(srv, &raw_state);
+		*state = convert_psr_state(raw_state);
+	} else
+		// Return invalid state when GPINT times out
+		*state = 0xFF;
 }
 
 /**
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
