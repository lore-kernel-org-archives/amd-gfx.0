Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB0CC47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 20:46:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E0F61008
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 20:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E0F61008
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3268F6E1D8;
	Wed,  2 Jun 2021 20:46:43 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06A6F6E1D8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 20:46:41 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id u24so4469409edy.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jun 2021 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FChgAP8pCui0F80QWe5zcZ+vfjL1ss/2FeAKbzcmji4=;
 b=SQoIBaPVAT9kkDHHeX4tWNQJ804b7nSCskB9zL3Ux75jhdwCsqOP5fr9XQ2xgOMYMl
 Vo8fauiDs8RIjQebPEaST/Gof9xr4fZqw6OKEGmUZTxpo2RyMTskJ6ukBB5lKWCRQ8Hv
 gle+fHwGe9DKWlulFqUed4aT7bvDiF0A+Sf/IN54FBgBPSlq+DRRepnErfGkuTRHPTon
 vvJdeb42ds7IXyEeaMPZRFeP68U/t203Kr3QxU+NwE4gs0QSGJdWISM/k2ubOXPsxDji
 dqBUl7XAdA76fXZcO6yA7nSXA/1HbGt69uLsRuOSlorfQu+n2mo2XVOwSWgBof9FM8KJ
 Cy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=FChgAP8pCui0F80QWe5zcZ+vfjL1ss/2FeAKbzcmji4=;
 b=Y1zrjfEPuhSuluVmviZ3cxMSegJQ5KxGG0J81PQjIB/BUM0v5CcG17O0cxQ+B1B6IH
 Qfw30CUCXLFdWybtl6ryPKNI+akSidd9hP6CHTCkPqQujt2+arpZDH5/ZqR3D4EplQQK
 J86g4PUWNHnU1e6VjgRa4OYEj52SJevW8R/Txj1zKCzz66jP/QAFnPJBryOuMVxWWoZi
 U73w9KeFxFORdnBULmnf94ZU+NAWVus9bnE5RO6EMonJzwhJB8eyelInWLURuV0oYp4J
 tSSZfZKMmUX4f2loWxzCAiTQAzHxJT3b0V7ekkzHVPk+5zrsXHr5/zQioEMqB/aNBBan
 6Kxg==
X-Gm-Message-State: AOAM530Rk7in/U+2lxOjqbFji3zauxxskd+n5OkaJN/7r7et6WZyW81X
 cqQLIVEgFjJUqCo+TVKDcGa+epEKVD8=
X-Google-Smtp-Source: ABdhPJzAvN8n+6ewqC/pw167rosXqkkVNkp8xsvycjZUPrMPXv8tUEz+U0gktuqo3Lxe8aNNMZob1g==
X-Received: by 2002:aa7:c04e:: with SMTP id k14mr39638051edo.157.1622666800383; 
 Wed, 02 Jun 2021 13:46:40 -0700 (PDT)
Received: from twisty.localdomain
 (dynamic-2a01-0c23-7c7f-8100-6cbb-50d4-b91e-5b37.c23.pool.telefonica.de.
 [2a01:c23:7c7f:8100:6cbb:50d4:b91e:5b37])
 by smtp.gmail.com with ESMTPSA id gv11sm522640ejb.13.2021.06.02.13.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jun 2021 13:46:39 -0700 (PDT)
From: Mario Kleiner <mario.kleiner.de@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Keep linebuffer pixel depth at 30bpp for
 DCE-11.0.
Date: Wed,  2 Jun 2021 22:45:56 +0200
Message-Id: <20210602204556.17324-1-mario.kleiner.de@gmail.com>
X-Mailer: git-send-email 2.24.0
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
Cc: Tom.StDenis@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 mario.kleiner.de@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Testing on AMD Carizzo with DCE-11.0 display engine showed that
it doesn't like a 36 bpp linebuffer very much. The display just
showed a solid green.

Testing on RavenRidge DCN-1.0, Polaris11 with DCE-11.2 and Kabini
with DCE-8.3 did not expose any problems, so for now only revert
to 30 bpp linebuffer depth on asics with DCE-11.0 display engine.

Reported-by: Tom StDenis <Tom.StDenis@amd.com>
Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index b2ee3cd77b4e..a4f1ae8930a4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1213,9 +1213,16 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	 * on certain displays, such as the Sharp 4k. 36bpp is needed
 	 * to support SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 and
 	 * SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616 with actual > 10 bpc
-	 * precision on at least DCN display engines.
+	 * precision on at least DCN display engines. However, at least
+	 * Carrizo with DCE_VERSION_11_0 does not like 36 bpp lb depth,
+	 * so use only 30 bpp on DCE_VERSION_11_0. Testing with DCE 11.2 and 8.3
+	 * did not show such problems, so this seems to be the exception.
 	 */
-	pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
+	if (plane_state->ctx->dce_version != DCE_VERSION_11_0)
+		pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
+	else
+		pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
+
 	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = plane_state->per_pixel_alpha;
 
 	pipe_ctx->plane_res.scl_data.recout.x += timing->h_border_left;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
