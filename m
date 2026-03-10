Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8619EFD4F23
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Mar 2026 19:13:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFDB810E167;
	Tue, 10 Mar 2026 19:13:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PWtCoO8x";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3BB10E167
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 19:13:33 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso2707145e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Mar 2026 12:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773170012; x=1773774812; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xpaThhX36xEEn2Hplvv59tk+4S3WHwXj3Bc2pC+Mrpg=;
 b=PWtCoO8xXWYuRCPzbhANDVCjm2NGTVyC9eWiyqkf5W0bm9hcagO0YhrozpMxiFMD6K
 csegEqBQZN2/a+mmQ5l6L7pEwiuMpoK7rWXrdzUGaNvjRQ21YcxxO+NB1dEe9cs47fJS
 6uegvFUzdAASF6APhjtzR3eNUNK30fu/HsRratteRzXnJBeNlCcg+nEozsAArdl9EM5v
 aIj7ycLcldeGfmExz8bHhh2T5+X0PsI0EHIHXTtrU0aeGTaiPpaszT9FSEY5ftgcVfh4
 EuPWJkcocYYgSYbn3YZ2in5+PMJImVT/7Si0mihj+nX8RZLvE4LdzO0pl/ye0N+pwSmA
 QWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773170012; x=1773774812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xpaThhX36xEEn2Hplvv59tk+4S3WHwXj3Bc2pC+Mrpg=;
 b=JpPZ+qMrB5myDz1R64Wk65pY37Ncqey53Z7Qnl4sSvEHi928YfGM8oYTpsx05xBUZQ
 90rJPLQdIvpH3qGp1myu5swDONmsZg1PlIk13vRUrjNzaXvzjCc9AbksEmfEP59332z4
 JcgZkI4YfnLGb2wVgDOg88wZIRkngwN6yGJs+9ki1X7hrwlLWGDbbn8+iGdDeY6jBWrp
 8ZON6PyBfMwkwTnFd3R4gIAauuUoGgZiaPgY7gGbAjikeCJv/W44cxA+hOtumdB6M0qB
 z84XXZY52H2vmV/rOyp0jUYQObSvQ2DAGoD38+3TvHKtwf5zmTaWk9WxGHksaI+oSWag
 4BMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+gkJ3MBjvJvP3Ewu+GtYYh0/Tfsal7SubOludqQHKYkFCAcpwzW8fVQ2Z41PzKm1RLWA2YUpH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsIREF7DrrIMCBCewy8TzAPbmMHFy0oNwYQ7LQgWZ73OOxwsZ/
 XLVD2DAkgEOWY6YPIkt0a0DD72Uf3o0tgcwV7/5rKrg9KAsGNU6V2xid
X-Gm-Gg: ATEYQzxR9fkrW5iTxNYDMBfA3uO3Q22zV24OrUKY2vKIJEdOGRBQ3FOXf2UXk7a0uQt
 IVX4eD5Y5lhAZ4KVULScjy0OvTw+2MTqXK4j2j9SYenzD1XcSFJqtdInPiJi/xG3DlH/T/YeTNG
 PewGwdTMf6fZH7OIY5MnR/Yu5fSJmuRCQL0DpCWRuNFUNDZ8o8lz6gHEN7jBBZ5bPb7KlBDhbPe
 aEevtqKUfareKkeaO+Lxcphhd6CuEq70waUwNeF4KpIGHqlH6jgYnvqaccViEk++8y6vKqK48uN
 ZgS7uyTTi8Sms+QamcNLYwV0fZ/nbS86n3jf5zRHCekVc5C22rIB9qHwGSGE1kNJ08GfIRqKYhq
 02bLQ3klP3eXCqVX4Pn5JpkyQ8L2Eos3OVA692VeMWdH5NUNd0RKMe7/Y3Tqy6JuSLt7DEYw+3L
 vdCXE20DdY4q1egB1Eh+tAuZe8YgewYtGrVSU=
X-Received: by 2002:a05:600c:1d89:b0:485:3c2e:60d5 with SMTP id
 5b1f17b1804b1-485419a2774mr69976435e9.2.1773170011543; 
 Tue, 10 Mar 2026 12:13:31 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d0:d800:5198:df3e:59ca:cf4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a3079efsm2601625e9.7.2026.03.10.12.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 12:13:31 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/11] drm/amdgpu: fix amdgpu_userq_evict
Date: Tue, 10 Mar 2026 20:13:19 +0100
Message-ID: <20260310191327.2279-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310191327.2279-1-christian.koenig@amd.com>
References: <20260310191327.2279-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Canceling the resume worker synchonized can deadlock because it can in
turn wait for the eviction worker through the userq_mutex.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 65783f9584c5..85adc53eb523 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1331,13 +1331,8 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 	/* Signal current eviction fence */
 	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
 
-	if (evf_mgr->fd_closing) {
-		cancel_delayed_work_sync(&uq_mgr->resume_work);
-		return;
-	}
-
-	/* Schedule a resume work */
-	schedule_delayed_work(&uq_mgr->resume_work, 0);
+	if (!evf_mgr->fd_closing)
+		schedule_delayed_work(&uq_mgr->resume_work, 0);
 }
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
-- 
2.43.0

