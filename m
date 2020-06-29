Return-Path: <SRS0=Kvqq=AK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6D1C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 15:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A7D4252B2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2020 15:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6gwq+Tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7D4252B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31F1489E36;
	Mon, 29 Jun 2020 15:37:03 +0000 (UTC)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3117C89E36
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 15:37:01 +0000 (UTC)
Received: by mail-pg1-x543.google.com with SMTP id d194so5092857pga.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2020 08:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vbKqvypAhiCCpniI6h4+wSlQ4ZrGKtROASd1AFVcwiI=;
 b=h6gwq+TtoD+JHWMmd5ezYGBNzLM1mT4DgKVoixX786m1E3JDTtYDDOsYTaqtTBYMv+
 oCgqeIPEd0rOnvYEUfsC8XvjRrUAQqZPC2JKauCr7HM20Yz3s3/fc8jAiq9lM9o29AeR
 Pu6LDg9KUladXip3gsd5diZb153cUAwK/IDN1fxuoLGbyrmY/sbDPQ1Cfu1mmKJdlBxG
 eCa2/lWGNrs+uGJIoSNe1vwtgoD6NgEvOtKHErR+AJMkn+fveioAV95pVqPms/6GmXzE
 l8F0PndOqZwEYCwS4JtpeJTgazRRbPwjMfBYC+pgTKXfp3pdOJkpbNHEyY42wUjGm/Ko
 DY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vbKqvypAhiCCpniI6h4+wSlQ4ZrGKtROASd1AFVcwiI=;
 b=I/XF1euXgstwhyq2wEYV0c58cVypLpGjk9JKrbdAsxWfgg4lW6smSJ0eKOiOGCKdnk
 Lwb1/uf1BeggjsmPE74omUXUGIcqszSo37f9KsRGmdIzlvkFrpLLvTv6QpjVLVT2qhcd
 6fOvwDVyqlMjDtZon/7In3Y3H1SE65zcsDrphdDU8yh8PrM5eO4biBfsdjPRRbp+sBfn
 b30sUA2IUEdDx4o61khPK56H2tb6zyi/KL0ANYFzO1PPKB72G2IxSuP//6bHOZpS99uW
 2NNJgojrB7cFyxwb1xPanbCMQOCovd8jLT562aoRypawepbmMlnmQkuMO7LCLtcL0g5i
 uBDw==
X-Gm-Message-State: AOAM533c0o9D3w7nxiODGwI457UA3hRBr8/B8eOiJjYbLXOiejbfcNHN
 eVhHPLo5xl5vYvDnt/3scseUsiRw
X-Google-Smtp-Source: ABdhPJxL99CJ6qyUynI0g5JSeC0q6b64foinDJkig2ljVvJlIMFhC7yI2PRUzVIaGb8CfkiwmLzbOg==
X-Received: by 2002:a63:e057:: with SMTP id n23mr10705392pgj.368.1593445021371; 
 Mon, 29 Jun 2020 08:37:01 -0700 (PDT)
Received: from localhost.localdomain ([71.219.51.205])
 by smtp.gmail.com with ESMTPSA id s10sm2778pjl.41.2020.06.29.08.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 08:37:00 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: Revalidate bandwidth before
 commiting DC updates"
Date: Mon, 29 Jun 2020 11:36:52 -0400
Message-Id: <20200629153652.101179-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

Seems to cause stability issues for some users.

This reverts commit a24eaa5c51255b344d5a321f1eeb3205f2775498.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1191
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 67402d75e67e..94230bb3195d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2607,12 +2607,6 @@ void dc_commit_updates_for_stream(struct dc *dc,
 
 	copy_stream_update_to_stream(dc, context, stream, stream_update);
 
-	if (!dc->res_pool->funcs->validate_bandwidth(dc, context, false)) {
-		DC_ERROR("Mode validation failed for stream update!\n");
-		dc_release_state(context);
-		return;
-	}
-
 	commit_planes_for_stream(
 				dc,
 				srf_updates,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
