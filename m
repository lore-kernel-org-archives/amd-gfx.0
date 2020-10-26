Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE636C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 15:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67162217A0
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 15:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6morq30"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67162217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37F4C89EAC;
	Mon, 26 Oct 2020 15:57:53 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E97A089DE5
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 15:57:51 +0000 (UTC)
Received: by mail-qt1-x836.google.com with SMTP id c15so7058215qtc.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 08:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Gj5OhdHTU7yjhyZ2RzAH49akcndja0yGnDbdB63PrNs=;
 b=s6morq30WwdQzd/jT5mQpZZTcAKkvUtRJE3+NBlLtqZ7jTJEWDLAOZHlL/scnWfZYo
 OypXYi+A3FFExv5Iy9TN+420zfMdEPMRnJyKRYwoHORVkt04pKF9XyM1weaK4EzIY9L9
 /E4cdOsV6sVTmyUT1ZRW8alGMQd1NQfKx2ZRiyT1AjLpPEypECfW/F39uh2Elxp357VE
 PRJldQpEp2s7/g4gMKtA7zGAM/FJwJIsasfp6AenamwBxCvcP6+P3hOmDAcia7XZkV7j
 Kzd1HsPwUOXooiasBR+OsfKx65fat2Np3mdMs+dqQMZSl/FyTZKi5KlanS0psiuTmOYF
 l3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Gj5OhdHTU7yjhyZ2RzAH49akcndja0yGnDbdB63PrNs=;
 b=noanS+wWcSVUPmnuEBlS7lfT5zxL1x2fSwrFCfA8VZGcq6qZmmVUFUJElHKQIqzWc0
 hbpelNF7KgTyVxyAVDJxtKvtgBrnk5PHzEfjQI0/tWudirjT9AIcypxiqMdWzKI5zpjg
 rN2Nr2KiNOLtmY2ZE/3Q8eh5qZWrO2dKfmPquxCeuDXbm4VwVwP4KZPdx1BZkHrpinfi
 L2M5sz4rW5LGXfJf755XA/3baqTuzebXcY53aoPWzm8Mu/bv1lsxkLD7zCVP4bTgx/Tg
 AlwptB7qfYK9bCKCpyzOhl8oR1vxPaJdNOhTcez/A/pF/zT2sQtjnVo+xcXoGLkjDL+v
 XE0g==
X-Gm-Message-State: AOAM530SxGT94NcfLZi/wLT0MzzUrQEXmO/1PjfiPzaiva+Kc2SCg7gX
 /74V/PmvUBJKCgkcKkAeqZVOb+Dc8Xg=
X-Google-Smtp-Source: ABdhPJy59J0gRDtTKsD1Oc88ffui8n61po6sF0xD7kIPGQRRh95BX3/bXr50JbaicMWP8O9wKY7CIA==
X-Received: by 2002:ac8:937:: with SMTP id t52mr18287219qth.268.1603727870819; 
 Mon, 26 Oct 2020 08:57:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id 82sm6776489qke.130.2020.10.26.08.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 08:57:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu/display: drop disconnect_pipes callback for
 DCN3.01
Date: Mon, 26 Oct 2020 11:57:38 -0400
Message-Id: <20201026155738.964136-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201026155738.964136-1-alexander.deucher@amd.com>
References: <20201026155738.964136-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Was missed in a later update.

Fixes: 4d269c40066e ("drm/amd/display: Update GSL state if leaving immediate flip")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index d4bebb3a52e4..6d9587c39efd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -37,7 +37,6 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
-	.disconnect_pipes = dcn10_disconnect_pipes,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
