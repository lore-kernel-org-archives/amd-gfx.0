Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC87C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 09:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1176F10E3C2;
	Mon, 24 Jun 2024 09:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nhEAH3jE";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE92110E3C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 09:10:56 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-366edce6493so697305f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719220255; x=1719825055; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i4bgfw0LDsr8qHLXe/OdNwayeeqX9TbFXbVkcNAWRxU=;
 b=nhEAH3jEvQxxp/7IkTIqc2EGFJYO68pi9JvXIRJtZy4Z/2FOUrK1TWEsbdNjpCwoAk
 gbi9H5AQ6JnvmQby4TAGXuEpB7ws5D/4+IRm8u2QVIXEi3putKKh7MkS87ikNts7ffGf
 +crbqtPbqbmeS/KFfzSdZPvOiR3yOKOnG5m4vBASSRUAk5fEJfLDMgJAx0XpN3biD+CU
 97+TDYZiuCGcbC/mrB74ItzvcV1/MItuVVDhyqcdrTmEUQFvHwVIgCluAY5JqDZwGhgX
 4wWYprLWHP7ElgZ4evZT5D/+GSc/6cLynfbfaru3umaKb1DH5T/3WhapeZErlcNG0wlS
 yoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719220255; x=1719825055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i4bgfw0LDsr8qHLXe/OdNwayeeqX9TbFXbVkcNAWRxU=;
 b=q00HBFhvwtg6MZqyHMZRl6ljQ57wZJimIr/WtYLfZtT4Q/mvLWrpBQETosSS+b8QkI
 VSMDSsFi1qu6frejgB+rJ3938WIL6hKUKdqhnQrEYOnZkgHXIrzbGUilIbkY/XCywIrZ
 aEGJJ2TGtwyY/N1JO3vCKrO7DE52jTTykqFKceVJigWvfnV3sWezAopkaNwM+do/hQI2
 cr6Pn4tiIHNOIfU+SmvAUVERVYOBmdDd79rFGfr4DVrFV6ND3FaN3XzHFXvWwpODkBC4
 L26cPddrFrSTuq0QoPqb7tr/mf8ZThHrYTdVafLeKxqumzUYqj3abBFldwU3KTNXeJTp
 s81A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN54MdbGYNKjc5BIn3z4EH04y76s37CEoeqx6x0pIzork6RPSJKFpy9kG2yLi+D3t1XONKCuSYjx55n0Dy3yWbw52oCyT/HB5LjoPmKA==
X-Gm-Message-State: AOJu0YxLk7n/s3lc5VYSawzy6mPf/xLwphmu1SJNLEFSAlxxgCBLB68m
 W9IMEIOferkW1wNiDfa6N3Rs1O+loyh4JtKaniTs1iyORVgkvuTp357ALA==
X-Google-Smtp-Source: AGHT+IHsOPXR3vRuau1FAw6qp6uRRcafSNkCkjwjsR3i/DeIC7+anzGC4CoWchoQMV8vUV3G1Is3Gg==
X-Received: by 2002:a05:6000:1863:b0:366:ecd1:2f38 with SMTP id
 ffacd0b85a97d-366ecd12fb6mr2443565f8f.7.1719220254502; 
 Mon, 24 Jun 2024 02:10:54 -0700 (PDT)
Received: from EliteBook.amd.com (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366383f6717sm9570897f8f.9.2024.06.24.02.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 02:10:53 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: revert allow write access to mapped userptrs"
Date: Mon, 24 Jun 2024 11:10:40 +0200
Message-Id: <20240624091040.1623473-1-christian.koenig@amd.com>
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

This reverts commit 358c258a816baed4c6997b59c2117578a1360498.

Jerome actually pointed out why that stuff doesn't work in 2016:
https://lists.freedesktop.org/archives/dri-devel/2016-March/103062.html

Unfortunately the revert somehow got lost.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 358c258a816baed4c6997b59c2117578a1360498
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 3adaa4670103..331969b96a5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -433,10 +433,12 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	    AMDGPU_GEM_USERPTR_REGISTER))
 		return -EINVAL;
 
-	if (!(args->flags & AMDGPU_GEM_USERPTR_READONLY) &&
-	     !(args->flags & AMDGPU_GEM_USERPTR_REGISTER)) {
+	if (!(args->flags & AMDGPU_GEM_USERPTR_READONLY) && (
+	     !(args->flags & AMDGPU_GEM_USERPTR_ANONONLY) ||
+	     !(args->flags & AMDGPU_GEM_USERPTR_REGISTER))) {
 
-		/* if we want to write to it we must install a MMU notifier */
+		/* if we want to write to it we must require anonymous
+		   memory and install a MMU notifier */
 		return -EACCES;
 	}
 
-- 
2.34.1

