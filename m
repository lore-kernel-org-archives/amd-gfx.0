Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F834C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 08:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6CA10E39A;
	Fri, 10 Dec 2021 08:39:33 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BB710E39D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 08:39:31 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 m25-20020a7bcb99000000b0033aa12cdd33so6688212wmi.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 00:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3Y/F1E//K83QeC1+KKb7wRfKU4YfLVkFshCatabhgsc=;
 b=q5yWlf7eWF8byxMBMZfTeNcWEuFQ9nFfKpODqi8Svkny0d6LNDlG5GNadHSEiGe2A8
 zv7u7dirOahYqQFZoQuCoIhkHq8DXpyjMwRstLJwXyFr8Lzw6aRFz0n8clg8/KJdnjAM
 f4kzmsz7EJvm6f04VGYpGw6IJ7Bk6kzE9q1UTq2RmOEZKxVg+Rz9ycmMBhO/kF+z9lji
 eNAle6Vsm6/Lw/4pKQTuwDWav3q85Ns9QcigqnnPeU28OtsMtNu2mQRI+EXU9+pkf+4f
 eRYCXovWY3SuPXj0vHA4OxWbvZiDtQH6qLanXyAplASbvXczB8L9197Sh6xHjIcja/Un
 gowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3Y/F1E//K83QeC1+KKb7wRfKU4YfLVkFshCatabhgsc=;
 b=GNy4HDf6eDdiUQMD0y2qZ/DzuYm2l9rJtZ5tDqFnmZ4rDpAeMjAKp3+LhmuIiOmgpf
 nZDAEfXTAG2aYtGD/OYFJ54gSsSypwTgHlfO/r9pS6AFp3N5VFKIEhr81+unhSxzcZ1T
 eAhq1ULFuL5EBhKVBTjbl7Z4miu5Zo2XsRH0VNzNGv1uPMjn/uc8b42lFEYpowlyn2dV
 7Sc9WbVnyPiyidqAX9iDm+rnSmtJ+ehn5qluVD/jnV9QGcWa6Rr5+vXATSBJgjgundEa
 PJj+AIipxVwOkSGKXBUC5r+vPn0a//5SRUL4Qq1s8fF8bwRFyTYSPD668NeccsQRq8GO
 ABsw==
X-Gm-Message-State: AOAM5311y+aVsRi+gHU3O0BmRUufo1HuIoRUQNrFnHQsVH9r+fDw+NnI
 q6EvzcdwUJGOxmX+elh8TecpTjqOFEQ=
X-Google-Smtp-Source: ABdhPJxhq8ijps0t8OnKKHlGf72yEAc0P0o9pV8my0XVEUhA8oCK3d8Bf6KKeep0tOQo3NuxZYpO1w==
X-Received: by 2002:a05:600c:3846:: with SMTP id
 s6mr14576918wmr.37.1639125570034; 
 Fri, 10 Dec 2021 00:39:30 -0800 (PST)
Received: from abel.fritz.box (p57b0bff8.dip0.t-ipconnect.de. [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id d2sm11933280wmb.24.2021.12.10.00.39.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Dec 2021 00:39:29 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexdeucher@gmail.com
Subject: [PATCH] drm/amdgpu: fix dropped backing store handling in
 amdgpu_dma_buf_move_notify
Date: Fri, 10 Dec 2021 09:39:27 +0100
Message-Id: <20211210083927.1754-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

bo->tbo.resource can now be NULL.

Signed-off-by: Christian König <christian.koenig@amd.com>
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1811
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index ae6ab93c868b..7444484a12bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -384,7 +384,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 	struct amdgpu_vm_bo_base *bo_base;
 	int r;
 
-	if (bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
+	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		return;
 
 	r = ttm_bo_validate(&bo->tbo, &placement, &ctx);
-- 
2.25.1

