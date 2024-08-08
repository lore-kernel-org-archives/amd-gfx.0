Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A7BC52D7D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 01:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD4A10E62A;
	Thu,  8 Aug 2024 01:09:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="TJECWRZe";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F07D10E627
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 01:09:14 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3684b48d586so6845f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 18:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1723079352; x=1723684152;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c88dre8TrKy/j2/Ihz4L8tUG0qkF3i1CfHD8qmad/1g=;
 b=TJECWRZeWNuIKmBdieDJWSUU5WpKehnh6L2WkRejG7gqdVtSghoEaJ5+aw7gU3cAJY
 8PDZuo2BVIpO1RoBshPS7KGrtED15VnuZ7uvNgrVoLpL4rplmCH59U62+LTvII08325d
 4blN2AYG+WJ6AgDZMQ7JB984SP7H2lYjv2Y6pDU3uLvSpN6UfjjsKyd45kHbG8wQ1nyJ
 JjeQp4Wl/CfsD4ZxpCsyd7WZEYwF4vUBiUJIcb91mjVEmHxOx6qd5WdKVaN7BoDwZohS
 IALxsfaVUkcE0+yZl/SiNrv/N7zBR5NG2Mqec0XnO1VsXFNqQOVp7vWuwWySWdy9hNd2
 AC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723079352; x=1723684152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c88dre8TrKy/j2/Ihz4L8tUG0qkF3i1CfHD8qmad/1g=;
 b=J2vNswDtEtKrTMV8IjxohwjeDvs/ZDx2iUDtl0Bowh8QizEjA1imwR+F7UlwW6c99P
 vwOOrg+QUv3LPwKlreUr//6dT0TX5njCSDnvleQ+ZkzJiwXC6iRjmFS5IzU5hznDmiGk
 p46HMmmQ7xw/Ykb3lYh73r1TtCNhLbRRSo2I536gQcjA8sr79r0ZHDgXhhGh4ql5T/Ed
 mXXCa+GOiWP53H7WL5516qUb4i4H4+Q5koOgDCsevCZfLbkB7JqKaz/ktEYVbLD89R/H
 FaJIGAuNQJ4dAj8DuPZqvDQXofht6KN63HYCloNEeHv980ymFb1RfCHeTARHeNaNR7Zf
 gpEw==
X-Gm-Message-State: AOJu0YzvDWHG2YnsT4vP2KTlq5dy4BcaYThOnxGaKZ1ySNpbiEln/blc
 sQrxECf7e2x9/KJhovkcAeM8sje3gAFF6Z/hnZIRlrD4HfBguNtYRV5pxToDqgccfwMADXLOCzc
 U19k=
X-Google-Smtp-Source: AGHT+IFp6eNrFdYlQiKP9PKS4ypteewCaZvwAwNcUWC9+NUy+FTL+uiaI+KZuCo1PSva39rqGE1c+Q==
X-Received: by 2002:a05:6000:4022:b0:367:9cf7:6df8 with SMTP id
 ffacd0b85a97d-36d273d07eemr92955f8f.2.1723079352177; 
 Wed, 07 Aug 2024 18:09:12 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a781:a500:aaa1:59ff:feea:fd4f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d272095b9sm240753f8f.68.2024.08.07.18.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 18:09:11 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, airlied@gmail.com, faith@gfxstrand.net,
 friedrich.vock@gmx.de, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 5/6] drm/amdgpu: Implement disabling implicit sync per
 submission.
Date: Thu,  8 Aug 2024 03:09:04 +0200
Message-ID: <20240808010905.439060-6-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
References: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
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

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 21 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h |  1 +
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 8d6f42e308fb..e1ba48644a0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -185,9 +185,11 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	int ret;
 	int i;
 
-	if (cs->in.flags)
+	if (cs->in.flags & ~AMDGPU_CS_FLAGS_MASK)
 		return -EINVAL;
 
+	p->flags = cs->in.flags;
+
 	chunk_array = kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t),
 				     GFP_KERNEL);
 	if (!chunk_array)
@@ -1194,15 +1196,18 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 	}
 
 	drm_exec_for_each_locked_object(&p->exec, index, obj) {
+		enum dma_resv_usage usage = DMA_RESV_USAGE_READ;
 		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 
 		struct dma_resv *resv = bo->tbo.base.resv;
 		enum amdgpu_sync_mode sync_mode;
 
+		if (p->flags & AMDGPU_CS_NO_IMPLICIT_SYNC)
+			usage = DMA_RESV_USAGE_KERNEL;
+
 		sync_mode = amdgpu_bo_explicit_sync(bo) ?
 			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
-		r = amdgpu_sync_resv(p->adev, &p->sync, resv,
-				     DMA_RESV_USAGE_READ, sync_mode,
+		r = amdgpu_sync_resv(p->adev, &p->sync, resv, usage, sync_mode,
 				     &fpriv->vm);
 		if (r)
 			return r;
@@ -1259,6 +1264,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
 	struct amdgpu_job *leader = p->gang_leader;
+	enum dma_resv_usage read_usage = DMA_RESV_USAGE_READ;
+	enum dma_resv_usage write_usage = DMA_RESV_USAGE_WRITE;
 	struct amdgpu_bo_list_entry *e;
 	struct drm_gem_object *gobj;
 	unsigned long index;
@@ -1310,6 +1317,10 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 		return r;
 	}
 
+	if (p->flags & AMDGPU_CS_NO_IMPLICIT_SYNC) {
+		read_usage = write_usage = DMA_RESV_USAGE_BOOKKEEP;
+	}
+
 	p->fence = dma_fence_get(&leader->base.s_fence->finished);
 	drm_exec_for_each_locked_object(&p->exec, index, gobj) {
 
@@ -1322,11 +1333,11 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 
 			dma_resv_add_fence(gobj->resv,
 					   &p->jobs[i]->base.s_fence->finished,
-					   DMA_RESV_USAGE_READ);
+					   read_usage);
 		}
 
 		/* The gang leader as remembered as writer */
-		dma_resv_add_fence(gobj->resv, p->fence, DMA_RESV_USAGE_WRITE);
+		dma_resv_add_fence(gobj->resv, p->fence, write_usage);
 	}
 
 	seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_leader_idx],
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
index 39c33ad100cb..683c6eca4f1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
@@ -50,6 +50,7 @@ struct amdgpu_cs_parser {
 	struct amdgpu_device	*adev;
 	struct drm_file		*filp;
 	struct amdgpu_ctx	*ctx;
+	uint32_t		flags;
 
 	/* chunks */
 	unsigned		nchunks;
-- 
2.45.2

