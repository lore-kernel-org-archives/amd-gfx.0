Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823DBC5321D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 12:03:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C0910E8DE;
	Wed, 21 Aug 2024 12:03:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rxo4W0Q5";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C34010E8E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 12:03:30 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-3719896b7c8so2923796f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 05:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724241808; x=1724846608; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=849xw/jZ8nRmtfSoNzLh8h/oEYXMxGOZEbwUdj43ES0=;
 b=Rxo4W0Q5DVwOz+j6pY+7/u2tShMnrBj4oSrTBcqXBSuxAw+6nIqDprb7ZpB5OmycbR
 UpSGks8r6PIykSNQB48Ewx/hag7IUDGRMaxVqG00yDJ34SwmXUp5+kTvp/Z27Xzv7x6R
 /Jkxb+rTyE6hAsEq2sbyWg2GItljZJ6XLgyefJ6Dmqe+St3Jp2Qm4Qtmj27Pw+1jOw/T
 a6KbEimmxIm1A6+2yDsMWRNWl9jRMBec3KBKRlt0+owCW8k6fV91cY9dNP3OQv41n+7a
 ZBZqD9+ZtnsLkxrOrbSBgjm62a6KioRhQkpN9FNGTEN503TqxozocYl6HO93nDuDtx+i
 1rEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724241808; x=1724846608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=849xw/jZ8nRmtfSoNzLh8h/oEYXMxGOZEbwUdj43ES0=;
 b=tYg7na1t6UpaKZQndHjH8qxeZtHv7tS9GC4+xrxzMY6qCVzP0GQmcXWtPBhby0BIOI
 I75EwI8uMNh9RNZ3XyMJiFWDO8gkeEiCaK0WSDWW1enNW+ZnXzPatZe+Se5WWqRC3BHl
 5zuVLWZJbsQn+s7xFY+qpHnSGzcu32rzCeqLvrUnVx41odZZPx+v/y8xvcLyQJsfDaHU
 nRQ0bdJsAIjHmW1uvcJu92LNb2WLflYLLOeLEMFi3nTftufyijzPqHaR5O/oww1EvTxC
 GX52LSnLMhpej+DAl6byeTJcfeWTd2VkL9ifOVZwvBC/NdwTAxFq4lZgNLJD/GMS8gGc
 kyWQ==
X-Gm-Message-State: AOJu0YzQMQqO3Iv88zMDXc3aK5BWqhZZUhOLX0aNoHrvutcESNWT5M+k
 XGAirojtDmz0zQgXs81/VQ8NBykjsbAR45rw4uAyI0mVDBJa4U84
X-Google-Smtp-Source: AGHT+IFAvzwqyTW01zmQvPPfUzi/h1VhLq2wvxaGGy6uTgy+jqAx8ElpkSuTDuPeKUzSY4JEOlWvNQ==
X-Received: by 2002:a5d:4a44:0:b0:371:7a07:d3d5 with SMTP id
 ffacd0b85a97d-372fd701512mr1246423f8f.49.1724241808001; 
 Wed, 21 Aug 2024 05:03:28 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1526:a800:3751:35d:98bf:f3ee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ac2c6sm15534814f8f.108.2024.08.21.05.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 05:03:27 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: friedrich.vock@gmx.de, bas@basnieuwenhuizen.nl, ishitatsuyuki@gmail.com,
 felix.kuehling@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: stop syncing PRT map operations
Date: Wed, 21 Aug 2024 14:03:24 +0200
Message-Id: <20240821120324.4583-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821120324.4583-1-christian.koenig@amd.com>
References: <20240821120324.4583-1-christian.koenig@amd.com>
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

Requested by both Bas and Friedrich. Mapping PTEs as PRT doesn't need to
sync for anything.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 13d429b91327..a42e172b7dbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1158,7 +1158,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	int r;
 
 	amdgpu_sync_create(&sync);
-	if (clear || !bo) {
+	if (clear) {
 		mem = NULL;
 
 		/* Implicitly sync to command submissions in the same VM before
@@ -1173,6 +1173,10 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 			if (r)
 				goto error_free;
 		}
+	} else if (!bo) {
+		mem = NULL;
+
+		/* PRT map operations don't need to sync to anything. */
 
 	} else {
 		struct drm_gem_object *obj = &bo->tbo.base;
-- 
2.34.1

