Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C843AC433E9
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 16:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613E564DAE
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 16:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613E564DAE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC27D6E854;
	Mon,  1 Feb 2021 16:56:18 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C61746E850
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 16:56:17 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id a12so16872278qkh.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Feb 2021 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MkvgFkWT5VPFA43uk1UzCG09s9T2iFsw1Tp17OHsX8o=;
 b=hblVJQRAfra31brK7QMU7BxjIS6zQtwcfbY6HFgbPnIEER+H/pytlxbH1Z7ePAWYL7
 EYu3QyStFEzP28CHbP0pGtYonWyKLOx33zc4OH0B0fe87RYwfphnxPojVrP/i9y2OBmG
 FSQpstWbjfJMuGGl2P9lk03tXrV2JVD6J22Jz4PMuZfW9mxrRjGf95qihXzLZTcxLQtY
 hPoBF3wR2e7NCCKqFIha4lrk99gA/uspv+6wWJaBakrF2IxRg2125/9U0GBqFJXIP5hq
 duwE+WsctW/vgrxzmVzOBdzJ6b3tuecOAycVJny/MLj4eCSpD9FqAMqWk/ViW3gliXk6
 swPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MkvgFkWT5VPFA43uk1UzCG09s9T2iFsw1Tp17OHsX8o=;
 b=opAXlxzqmEBGNj5VtQQd3QuXSUm5k6HXs0NA6G1j2PtN6tRzesgYTqMhsvjD9D5b+S
 cNajDAYFwYedqZJooR2TRT0Cs5q/Ovj9DMWb5mBrD6GGtr580iLNz2NoG31TP4bftNsT
 gLZAHAihnChk7C+vKj4tbWSevvnpKIxmRNUSqdR7+rRkpRLNkmMi3XNrmvANrXSGUbrj
 AVSGbDD8wXxf6YWwfZ+J7VzDXh6CP8P/+gmCIvCq4HxsYwOtuvBhmyGhg+PRu2ViCBGT
 sTD8fUAJg2NiDBSY4hkdza0bpz5EZH78/HpOpJLxTrZZC5TGNgnITrd7ZAnF1v30V+4N
 //Pg==
X-Gm-Message-State: AOAM531/UGyWM9r7JzVSuLmvfAwK3ZBCOOrLRJ0k4UPVk5jKoEmOEFDq
 GnhjueJZ6P1gGgj86DpaFstGXTHRv5Y=
X-Google-Smtp-Source: ABdhPJwG2ofsQjhexbc7R9eULg81OyDo9397nqfqxbZr39KD2/GD7IW3wgXJw1EGvSEeofIFY+NM9w==
X-Received: by 2002:a05:620a:12d7:: with SMTP id
 e23mr16794767qkl.58.1612198576905; 
 Mon, 01 Feb 2021 08:56:16 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id v145sm15022479qka.27.2021.02.01.08.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 08:56:16 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: bump driver version for new video codec INFO
 ioctl query
Date: Mon,  1 Feb 2021 11:56:05 -0500
Message-Id: <20210201165605.465228-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210201165605.465228-1-alexander.deucher@amd.com>
References: <20210201165605.465228-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

So mesa can check when to query the kernel vs use hardcoded
codec bandwidth data.

Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8fde2318a03c..79608949e8e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -90,9 +90,10 @@
  * - 3.38.0 - Add AMDGPU_IB_FLAG_EMIT_MEM_SYNC
  * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
  * - 3.40.0 - Add AMDGPU_IDS_FLAGS_TMZ
+ * - 3.41.0 - Add video codec query
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	40
+#define KMS_DRIVER_MINOR	41
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
