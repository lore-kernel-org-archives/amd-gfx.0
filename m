Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1466C61DB3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 13:36:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADB7910E8E9;
	Thu, 12 Jan 2023 13:35:59 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B443A10E189
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 09:41:23 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id x37so18719323ljq.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 01:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xcBBA5m/IiORnDaKHbjnduMHgdd58lT2vpAvoSmhJOA=;
 b=0+KRRgm3Eq15s4x5Fy/5XZcojr4CB8aLFyrcB9p3aFRUAHqVn0rJTUNmhLG0T+kGYj
 R4GLPDI19cZ534hJjq2cJT/fMnfkObtYpR8N6C27p0x7Z7T6B8xY2AuSFksofI8+0isk
 nTtSufvCcFGMTwqM+G19dxd0s/OYGEpGG5ohUvcdcXuBDl+sQD4/T3ALiPUolSpd53d0
 l4xn+vzWBuGRsk3abBjpdNK2CNaLPhbKDmWEEEGwvedL6oqFlRM/4w5Q9FPmstEBJpjM
 ppamOBdRJ/tbZvZ60V+sgWpeGUsGhJQNfkMaiAM4vc9QtxM0sfHXqsM83YRow9m5tXqM
 16fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xcBBA5m/IiORnDaKHbjnduMHgdd58lT2vpAvoSmhJOA=;
 b=sjZSGvgL4ttwSV67PBZuXpM0fM4OH9KIThoxZXu33eJ4vYV7MD7kW/aBo6lIjBh6Qn
 Elw3kvW4XnhVUpAb2YY3XBkQvB3ZwzOcXTqAXToEiB64uh2Iy2Th6rrR9VgU2Vw8SFxt
 jWdTW+cr/Jng2bl0yPuEV7V8cYqhDZek2OxHYzBe9lowqTp7+nFrTzw/J9MpF5cVVUH8
 yvPapoRajXJERqb4l9dJgJXAaFS35GvH9wGYqAiBUWZh2aFNd84sIbGKq9A8RwH4NTOY
 m9bQ8sZ4LLpWVL/p3hFHuD8gejYfXYwEgXrWubJvA4f+suMyu3c0DqlkdDaqGtM7/UiJ
 c9aA==
X-Gm-Message-State: AFqh2kr3GOKUicgE/r4LE3PqanlEgTJA+p0Yv1ZERZqO4c2px0EWlmUi
 87aMLb7ANXldXo9vPulHNZr0zd/GPxjy0rw=
X-Google-Smtp-Source: AMrXdXu4vThKbG6u8k9NV/985waTyDGlS3et+u5PH8TP2PrXJN7ol3PD2+Gwts+LZqpSN+aINOyFzw==
X-Received: by 2002:a2e:8e88:0:b0:285:8a8:1c08 with SMTP id
 z8-20020a2e8e88000000b0028508a81c08mr4386069ljk.38.1673516481746; 
 Thu, 12 Jan 2023 01:41:21 -0800 (PST)
Received: from localhost.localdomain ([95.161.223.113])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a2ea450000000b002799d097c02sm2091985ljn.32.2023.01.12.01.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jan 2023 01:41:21 -0800 (PST)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: drop unnecessary NULL check in
 dce60_should_enable_fbc()
Date: Thu, 12 Jan 2023 12:40:34 +0300
Message-Id: <20230112094034.177220-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Jan 2023 13:35:57 +0000
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
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

pipe_ctx pointer cannot be NULL when getting the address of
an element of the pipe_ctx array.

Detected using the static analysis tool - Svace.
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
index 920c7ae29d53..f0c002a6a538 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
@@ -72,9 +72,6 @@ static bool dce60_should_enable_fbc(struct dc *dc,
 
 			pipe_ctx = &res_ctx->pipe_ctx[i];
 
-			if (!pipe_ctx)
-				continue;
-
 			/* fbc not applicable on underlay pipe */
 			if (pipe_ctx->pipe_idx != underlay_idx) {
 				*pipe_idx = i;
-- 
2.25.1

