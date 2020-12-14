Return-Path: <SRS0=8Fgq=FS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB54C4361B
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 21:53:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A3F22262
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Dec 2020 21:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A3F22262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D96E389D43;
	Mon, 14 Dec 2020 21:53:50 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2942889D43
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 21:53:50 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id h4so12322493qkk.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Dec 2020 13:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dw19sI1p1/8ADM18HaG1KK8LYhI9ZquKJ780ZTkVD4U=;
 b=B51XxP0qiyyv6i6LOWrIaK29nZ6w5luG2Ly6PGf0C6HRH4Td1vWFAUmBmlDbJFh2oy
 nvb/yA7e3BCk7rdNMgLNw4jy8WiDVDsyUuSO58rqk1boRMTV9ZREYMvCpKurk/l8xdl6
 cwuNaBhJ90Ap5k6YGhrUN5lYMiBj5md5qC7b/FcBhMhHVw/WnWLxiXUFzbfZm48W2q+1
 QAp/uIInYtwFL4cjl3jUY4Z7ccdmabHdYGszjxMyqU7yTSbMYrv6NkfQ/G7TGMtGG1MT
 bQFdktuVw3s6Hm0VaJTPFXzV0CSnALPf4YrmYIGldVDUL/29V7/Gga1XTgarg5E3thXl
 6RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dw19sI1p1/8ADM18HaG1KK8LYhI9ZquKJ780ZTkVD4U=;
 b=bdVQtIgehBcD7AFpDux2HgUVgkipvHxkA8/lVPjouCPjE4vv2WjRRzkz/Eowvuduec
 TL0SJkQtn7MUf5ZNzIiy3qbia9eg8IAz5GDfY/4l0WHh32PNRYupUNOnUjUyb4h+uoYD
 BGxionAPk3k1er6LuvKMxrbclAwPR+ewtOOGU/HA+7gfsPFCn74d0mmHozgg0DJYfsN+
 Q2RVH8yJrrJoORYsnQgcLc/HhrujZ3ZpxFnMEiEwb0ExanHOqkjrZH3iA8NpGv47qi+5
 J+oTN2l7+U3LjxsgojE1Gc8ZQc53BU0A09dO5ZmJ0SeJ4ALLhOZRoW3wuCWrXr8WgP2Q
 mBZQ==
X-Gm-Message-State: AOAM533G4lrvr6dl4X+WWSCIVSNSoRH0PZFWTCX8OUde7odafeFWgzEB
 lK8AVIYFUU5cYSwqroQ+CTxY3q9Q6Kk=
X-Google-Smtp-Source: ABdhPJylZhsNmaKoEf6YBLR8nKkWwt5m8RvwxZrBHiSnXHaLeDVGRq9G8JSLpVDexT9mjuL4G+tHDg==
X-Received: by 2002:a37:bfc7:: with SMTP id
 p190mr34534596qkf.445.1607982829210; 
 Mon, 14 Dec 2020 13:53:49 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id e66sm15445102qkf.31.2020.12.14.13.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Dec 2020 13:53:48 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amd/display: disable stream if pixel clock
 changed with link active"
Date: Mon, 14 Dec 2020 16:53:39 -0500
Message-Id: <20201214215339.819374-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 8353d30e747f4e5cdd867c6b054dbb85cdcc76a9.

This causes a hang on a carrizo based laptop.  Revert until we can fix
it properly.

Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 58eb0d69873a..5a1340baade2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -895,6 +895,7 @@ static void disable_vbios_mode_if_required(
 		if (stream->link->local_sink &&
 			stream->link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
 			link = stream->link;
+			break;
 		}
 
 		if (link != NULL && link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
