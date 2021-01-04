Return-Path: <SRS0=8zgd=GH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52346C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12BC82068D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Jan 2021 17:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BC82068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C826789FD9;
	Mon,  4 Jan 2021 17:44:00 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDBB189FD9
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Jan 2021 17:43:59 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id 19so24104228qkm.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Jan 2021 09:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lEWWf85tQDj5S67oT2/KtxG4E8/Vpl0DtSmKFLFMvCE=;
 b=Eh1xrcW/iBn2+oIsMSOQGUN1CaFJGqjhR3MFfE4/Fp+fR508wQW+ewqfq8/9/fDXd4
 Sr2ry5sUa3zEs+3ID7TGeq6F3lpihE5rittOTYSPE5WaqM2wIZ7WVhorI87ftIdcSxic
 XzPwvLfRoRKo6BonJl0Uv5ytm2vgv/0VVhF09GZOtcTu+6t0z74ARrLFipDFY9lLM8nK
 Rc67orEIjTx0j1qoY5/t+y8Ek9nwT+r+xdHg37lIr2xKoORwYDaG8vw7f4xEjL/VMBPT
 S8ohA2j5yuZ+oeipx93JaSXPvRcYH1xS8Z9Og3pb+HybHw0Y4r6HiG7UH5wJ4lJCJ9Tq
 sfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lEWWf85tQDj5S67oT2/KtxG4E8/Vpl0DtSmKFLFMvCE=;
 b=WLph6wjrFyfMxH5ZNvYXJpk3l8eLDOWShp5TgL/bNhRtiAsYpq35d6As9YHauLO1uH
 86+IUeqheU48JHEAPclTvmX/XmbmK5KfY+EHEhhS1GyYt2t64b6BiMmhO1V3rCzOOqNa
 EjzUgmtx+9bfVWztjaCeWBUYi/3Cg1f1OSXeX0xKKByxXNm4fBC8jBPUpTaHSBmgIxAM
 TMKZuQ6d5KsAVMok+X0b1tQzqTX4x4yh61JrWG7oZdwi5pwkSJ2FTsqZe7sK77qti/iW
 ipROptEzcvyiXwwIccq3zK6H6822YADc+sjsiSqjPYK9l00SPL8Ci7i1VaJ9wk2UuSNf
 2CxQ==
X-Gm-Message-State: AOAM530vTTC5BvGj1xvLmRHSzxyp2FAWcNQJOhCdX48BbwUdibngIY9v
 NVQhwWFT7gJhOfReA9JruvPwuTlygt4=
X-Google-Smtp-Source: ABdhPJyiI2G8+nUeLuJH3q9b9KDzeeFKMTEt5HrJcILMQf3CWBD0iplXxhSX2wYanneFmMrP38HLww==
X-Received: by 2002:a37:6358:: with SMTP id x85mr72795979qkb.68.1609782238933; 
 Mon, 04 Jan 2021 09:43:58 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.241])
 by smtp.gmail.com with ESMTPSA id w22sm37917662qtt.76.2021.01.04.09.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Jan 2021 09:43:58 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: check the result of copy_from_user in secure
 display debugfs
Date: Mon,  4 Jan 2021 12:43:49 -0500
Message-Id: <20210104174349.609143-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

Make sure the copy succeeded.  Also fixes a warning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
index 455978781380..1f98ce4e56f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -101,7 +101,9 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const char __u
 		return -EINVAL;
 
 	memset(str,  0, sizeof(str));
-	copy_from_user(str, buf, size);
+	ret = copy_from_user(str, buf, size);
+	if (ret >= size)
+		return -EINVAL;
 
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0) {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
