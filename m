Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C8BC5B54E
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 09:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCF010E57B;
	Wed, 28 May 2025 09:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="Q0L42pDc";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172C510E5AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 09:13:26 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so33783555e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1748423604; x=1749028404; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rUNx2qLvPxlyA1uIjktFx0p0uHzbMXbhqe0Zofo8lM=;
 b=Q0L42pDcTVVaUNHX8VWbLxUsiiJrFBckd6OvBP2T0G+HUb6icaOba7YhpyRsrrT7kR
 JeDF48FpH45QYjUUNvGdo6XHbaERqXkhBtyrvthnoDLbman1oe5YFMGqNNkttPtjjBLi
 Ad6z/nKAOU3C6LAFC4U45vSV6/rYbAtk7OhK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748423604; x=1749028404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rUNx2qLvPxlyA1uIjktFx0p0uHzbMXbhqe0Zofo8lM=;
 b=K4j1nJh3uMSnBxWIrNexoD2aKv1d5zv1Hgf217fh+AAdGdY2/RoFuWFYjtaWhOhNoK
 ENoTE8U0G/1X0YvZBxI1YWjCExq+cDjlfxJn8kYcNims4Yvo0NITYbf7Sphzs37y5iUj
 4MDpTdiBsxIQvEuqMATF8nxjcTLfz81Gcud3kfmZSaW/TjH+jrFzMxyFlf4cDm28xuGx
 bwNri/HNioRwEMg4mOkqANlAOf71KxOOk7peJJ4HeeuQAWWlIKUlarTuw6T3zlQnRb1m
 /y3d03cBF2KC5ca3oTCSY3UXy+bgBPUxmWydw1IJbH0zYLk/INLVARx+BdUTsHKhUmhC
 PU3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHP253dQC8YODSk2obWbIcZ6P0DUHVi8bf2HQU4PPwDs6AKRK6J2YSAjlLmlumbmCuWYBFTnYZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyOpMg1x6aw8S6NXub5FC1ESp/EvsgGCQdYcNf7EYEfgkQis3Ug
 gIcJedZZI0WXtOJJPHm6LEFHGTo2DJ1yRoqXP0lWrWFMsxbUOTjYQexJJjKRflL4mSc=
X-Gm-Gg: ASbGncuixP1LcjzDanedlc1dKbsOqrmTBd1wtlSmVbIhKf5ez3UOsNjerP8FyQEKtdI
 QYSu9X5ez3r/IKRcssJyjG3m/eIyfWMiyBSoj0v8De8fb/SqddK3hmk535mXtEBRQkvHmjIReCq
 2mW02hfyRz/hTJyP5jhMK760K2xq07aAjQPD5cMgjDVJ9vKRJ+bdIg0GbyN0yXoTY1dFseAe8pR
 3UDJ2bb4xyX8iDB8qoLQqVvhmRzDSKe1Z38xShSMgSYyKKTFMHluAypDPJU6RyODNvucy/MyOWf
 TMX+m1vu0CkWwRCDiJYnQENYqowH+QHIFmS3FL2B/0fdGs0ksF4FBtHW4Pj8DWU=
X-Google-Smtp-Source: AGHT+IFZkApOHN9sH0BUqdg15pZy112PVQjbkz64sKp26gJaeulIgTUAHu2/9z9Dg6eHy8aNy2Dh3A==
X-Received: by 2002:a05:600c:6214:b0:43c:e467:d6ce with SMTP id
 5b1f17b1804b1-44cc05358b3mr154675735e9.4.1748423604488; 
 Wed, 28 May 2025 02:13:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm14811715e9.32.2025.05.28.02.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 02:13:24 -0700 (PDT)
From: Simona Vetter <simona.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: intel-xe@lists.freedesktop.org, Simona Vetter <simona.vetter@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 Simona Vetter <simona.vetter@intel.com>
Subject: [PATCH 5/8] drm/amd/kfd: Add comment about possible
 drm_gem_handle_create() race
Date: Wed, 28 May 2025 11:13:03 +0200
Message-ID: <20250528091307.1894940-6-simona.vetter@ffwll.ch>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250528091307.1894940-1-simona.vetter@ffwll.ch>
References: <20250528091307.1894940-1-simona.vetter@ffwll.ch>
MIME-Version: 1.0
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

I've long ago stopped trying to fully understand all the locking in
amdkfd, so maybe this is safe for a contrived reason. It's definitely
not how this should be done. Considers this more a request for a
proper patch.

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Simona Vetter <simona.vetter@intel.com>
Signed-off-by: Simona Vetter <simona.vetter@ffwll.ch>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 260165bbe373..aa51930a012b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1774,6 +1774,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	ret = drm_gem_handle_create(adev->kfd.client.file, gobj, &(*mem)->gem_handle);
 	if (ret)
 		goto err_gem_handle_create;
+	/* FIXME: Thou shall completely initialize the bo before calling
+	 * drm_gem_handle_create. Or explain why this is safe. */
 	bo = gem_to_amdgpu_bo(gobj);
 	if (bo_type == ttm_bo_type_sg) {
 		bo->tbo.sg = sg;
-- 
2.49.0

