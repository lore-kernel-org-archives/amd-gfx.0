Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A001C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 13:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D942310E3EE;
	Tue, 15 Nov 2022 13:38:58 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74DEE10E3EE
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 13:38:56 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id d9so19598720wrm.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 05:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xhw7zVFQzyExBVv/MFeq1ubZyjPDmCJOWkDiH0gTkHg=;
 b=eeE63QYI9iWiKjEmzatf39jZcU2dMF260h2MbO33BfuyvRb9eqKTnIoz6nPQCXrCrW
 x6srakh3UXn5t95yMcHaBHOG7pNrZ/j5ls5BkEgY1UOEz/PT3We4oejbgsJ4Zt/eNyCZ
 Drgfx47x/OY5cGUtoMHhTMIZ/P5xZ3NHzPC6yL7up81zHV/Vny6y8gG5p8+ELFqrqPEx
 MzIXvrLLMt3APvwFdFl91VJF6MxIZlNmTDsd9def/am9RKIg9A6HuiAiQPsVXkvVodRe
 cLE3+ZDh/oVouqlHgjEGxR4BWP9lQMa+AvNKq96lvzs5Har5x/MwcA9cSBATnVDl3UUs
 G6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xhw7zVFQzyExBVv/MFeq1ubZyjPDmCJOWkDiH0gTkHg=;
 b=M+zL5CZC7bWDYRhmqbu7vemKy9TX5dm9n7dmJMfHzLd6Vf7ofFK5xdrnwsZpRJ82MM
 fALoo9ndCQG1l6oZVEUqWQ6HL0egOgj+vQzfxOBJ3rxOyOW31cYqqzTPV5cBTnCTqi98
 wqWT4G1c0BG9+A+/qzQfXoCsT0l87CsFELHEvz8Axw/pf2sZlZd5Ver1m1hNg+c7SbIl
 CA4D2hb9apY+46kQs+qPvWmVLYzNand97UiB2kzBekgCzJSCj1Rtny/WKhZ/EOll2NyK
 FWHKdHojPsr+3D9NaXlkj5/dDVNJFVZSbAMEYBL7lBu002/tXYXgZfJl2RuY9Vus0e5T
 PM/Q==
X-Gm-Message-State: ANoB5pkHzQmHMj9TqOsVXd2pE/bxCGg4wB7FMmIaQQCdPdAVCiXLPJCK
 xSdrU8DvOHC+AzdhuOWtDCabg1aNXX0=
X-Google-Smtp-Source: AA0mqf5bpmAjXQ7s2ASFhTek3g+tMSEY5YyBPe9Jth6NlRy1tFA+YWg61rlLNFPEyBgk3ZyaBXmT+w==
X-Received: by 2002:a5d:452d:0:b0:22e:371d:a472 with SMTP id
 j13-20020a5d452d000000b0022e371da472mr10931061wra.713.1668519534851; 
 Tue, 15 Nov 2022 05:38:54 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 c7-20020a1c3507000000b003c6f1732f65sm20405469wma.38.2022.11.15.05.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Nov 2022 05:38:54 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: mikhail.v.gavrilov@gmail.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: always register an MMU notifier for userptr
Date: Tue, 15 Nov 2022 14:38:50 +0100
Message-Id: <20221115133853.7950-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

Since switching to HMM we always need that because we no longer grab
references to the pages.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
CC: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8ef31d687ef3..111484ceb47d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -413,11 +413,9 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	if (r)
 		goto release_object;
 
-	if (args->flags & AMDGPU_GEM_USERPTR_REGISTER) {
-		r = amdgpu_mn_register(bo, args->addr);
-		if (r)
-			goto release_object;
-	}
+	r = amdgpu_mn_register(bo, args->addr);
+	if (r)
+		goto release_object;
 
 	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
 		r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
-- 
2.34.1

