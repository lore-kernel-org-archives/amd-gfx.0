Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5980CC3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 22:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2900E208C3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 22:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIC8CzGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2900E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2A996E4BB;
	Mon,  2 Mar 2020 22:43:23 +0000 (UTC)
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C38C6E4BB;
 Mon,  2 Mar 2020 22:43:00 +0000 (UTC)
Received: by mail-ot1-x341.google.com with SMTP id v22so995740otq.11;
 Mon, 02 Mar 2020 14:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VKkYrMHc3NgZY6dbFAxdV/unADRxNvh4mhPtiaguI7A=;
 b=XIC8CzGuyPBHte2kKanC/RDwY5VvcDxMFGRUM3q2+jBbOW2li3dBerBSC11xv+DH9e
 GaeGJz5+Yi3CFcQKM6fJTlQVDJLWvA35qyKbAs989RGnw1qVBS1wwggMGwSakNTsJnxK
 u/Fdg+4TI7KlyqZERL4iiw2haAvtgnFFLGTct4PqKkg95i4WmVULc9aMsm8hNxmW7NC4
 8A7Pt0CofzA5/KWr+6FKzyaIZQ6RBb89Eih1mBTHMrpdNE3CFclukXnFxiuz8Tpj25l9
 KUex2dMzeDDGf4GWRSLcYFJylM1Chg/72lLAsMOQynwsHVdrMZd6WL1VdY4PBtF8MdPY
 LbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VKkYrMHc3NgZY6dbFAxdV/unADRxNvh4mhPtiaguI7A=;
 b=iW3NHJ/5KR/BHheuG2eVQoJvEH6zVmD7KbuV/F1o2xXe0RMGdyeMC+P2Q7WBsRzv1A
 BA+P0kVuIt+thduLaGoqVIbxXo/1mg+kTTCy+AkAkbW5thzSwdq11Ta7JtmPYOKEpK+L
 f3NgLS+sTDyOnvedd0kNvnjsuqMyVshDTEniDi6QY1753WvC/lIBbUmAB6tSNn8dKCXC
 KV2DbEuQJeVgvX1PQnRGGok9URTBWCUKwvJ4vNRwId+TbbMBYn0qG1wh/3kWQcEhEFAs
 +pQHZmlGnspB9sPJyuSqYko7NBN8ftKbwfLjz0TIfLNCTitCc5WWvuSoNl8XyyqSEoDm
 oL+A==
X-Gm-Message-State: ANhLgQ3i7L3RJN90Fr3XRtANU0DpDSnUxD27I5zVPoAHht2Ia+L2m6tz
 iOs/1UhLCRZ1VfUQ2xNvcVI=
X-Google-Smtp-Source: ADFU+vty9MCY56f8nz95gUPIYIdOBnALry7IQ1WdGNOz6pwfhseTHVUiUMvHy5m82PlJErnpCTe2Hg==
X-Received: by 2002:a9d:21b4:: with SMTP id s49mr1078062otb.294.1583188980093; 
 Mon, 02 Mar 2020 14:43:00 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
 by smtp.gmail.com with ESMTPSA id z23sm2746739otm.79.2020.03.02.14.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 14:42:59 -0800 (PST)
From: Nathan Chancellor <natechancellor@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Subject: [PATCH] drm/amd/display: Remove pointless NULL checks in
 dmub_psr_copy_settings
Date: Mon,  2 Mar 2020 15:42:17 -0700
Message-Id: <20200302224217.22590-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
X-Mailman-Approved-At: Mon, 02 Mar 2020 22:43:22 +0000
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
Cc: clang-built-linux@googlegroups.com,
 Nathan Chancellor <natechancellor@gmail.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Clang warns:

drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:147:31: warning:
address of 'pipe_ctx->plane_res' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
                         ~ ~~~~~~~~~~^~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:147:56: warning:
address of 'pipe_ctx->stream_res' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
                                                  ~ ~~~~~~~~~~^~~~~~~~~~
2 warnings generated.

As long as pipe_ctx is not NULL, the address of members in this struct
cannot be NULL, which means these checks will always evaluate to false.

Fixes: 4c1a1335dfe0 ("drm/amd/display: Driverside changes to support PSR in DMCUB")
Link: https://github.com/ClangBuiltLinux/linux/issues/915
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 2c932c29f1f9..a9e1c01e9d9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -144,7 +144,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 		}
 	}
 
-	if (!pipe_ctx || !&pipe_ctx->plane_res || !&pipe_ctx->stream_res)
+	if (!pipe_ctx)
 		return false;
 
 	// First, set the psr version
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
