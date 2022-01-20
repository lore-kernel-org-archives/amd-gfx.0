Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892E1C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 09:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06FE210E972;
	Thu, 20 Jan 2022 09:03:43 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEA6A10E97A
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 09:03:40 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 l12-20020a7bc34c000000b003467c58cbdfso20259353wmj.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 01:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yyeA/TTPAufB7bGckS8mYnPgcPa+2tyDkJSP88vQs5M=;
 b=UXVCWWS5e13JxX0I0rfIHaJu0Q2zCuRGa3sgP1VB5a3oTl4X0qUBfCzXVB4Q7Iuf6p
 vXBdFiDmvblZTSyycfSidT4YEJoUKYWRm3mq8Q3Dkf2xF1ycKCtuS6ZDGUHF4nk+t/pU
 Y2KSYOGLBaADRwb714zcl8e0Xl73efQUvfDdVlrukcnBM89mgXa6z4xn0z2cunykiVFg
 c6iTLL+2huhrzHbsHXMOiJ6mAsH/4AP/Qy70BYxCrYbw6HzYiPhW8khPTu8pvPVs8Whr
 HWTBzvwjsjtKrp9EGgf23n9aInqX3bIGD07VL+H/3skWi3GMIQ+9NR7HloFwzki9k9g/
 ZWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yyeA/TTPAufB7bGckS8mYnPgcPa+2tyDkJSP88vQs5M=;
 b=LJmkNRPb3ipMJWHuokrXb/HEiBQgXPRfAsYPw3yMeiFjfUGE8unax2CRbDSYRUDJd+
 Rr4r1mQsvfk5kLYfu+n1axoKIPl4NVU4r25QQMEdafZxDei3SlXtth03LO957PocbLPx
 AffOjg7aZzJVQt90lojiE+ISNQHO9og4O603EAoKZ5H1TfyyMYy2k2DfkG/qtsaBMwh2
 5PVMNcrXLkDRLBjOqEU64LaQep1o7PlCJvW/bmdjfuP1YU/floysOBWmJU+AtG6hsPye
 zdNsv+by5mtXyqTXGQ4+biOR3wImG3AZUVxXzj2HjWKn25d13Y/Ng0+kGLLuuEbaOeud
 Ik+A==
X-Gm-Message-State: AOAM533Ocu1zxiMLWb1wdWPrIpTvI16BGAgsjcAbXYMr5NhZcvELBMWh
 LdPIBnfYbSo7o8p7lid+Z1c=
X-Google-Smtp-Source: ABdhPJwfTTvAitWpzx84IGS13KDohk06RJBN2PrSKgsTjArHItVE/1mR9y8bxnAdLM12Dz5TMYcGHQ==
X-Received: by 2002:a7b:c40c:: with SMTP id k12mr7970337wmi.185.1642669419471; 
 Thu, 20 Jan 2022 01:03:39 -0800 (PST)
Received: from abel.fritz.box (p57b0bff8.dip0.t-ipconnect.de. [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id i13sm9313307wmq.45.2022.01.20.01.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 01:03:39 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: andrey.grodzovsky@amd.com, Alexander.Deucher@amd.com,
 Anatoli.Antonovitch@amd.com
Subject: [PATCH 1/2] drm/amdgpu: grab a PM reference on importing DMA-bufs
Date: Thu, 20 Jan 2022 10:03:36 +0100
Message-Id: <20220120090337.2542-1-christian.koenig@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need the device alive and kicking for the move notify callback to work
correctly. Not sure if we should have that here or in the callback itself,
but go with the defensive variant for now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 37 ++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  4 +--
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index a9475b207510..8756f505c87d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -512,6 +512,7 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 {
 	struct dma_buf_attachment *attach;
 	struct drm_gem_object *obj;
+	int r;
 
 	if (dma_buf->ops == &amdgpu_dmabuf_ops) {
 		obj = dma_buf->priv;
@@ -525,20 +526,48 @@ struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 		}
 	}
 
+	r = pm_runtime_resume_and_get(dev->dev);
+	if (r)
+		return ERR_PTR(r);
+
 	obj = amdgpu_dma_buf_create_obj(dev, dma_buf);
-	if (IS_ERR(obj))
-		return obj;
+	if (IS_ERR(obj)) {
+		r = PTR_ERR(obj);
+		goto err_pm;
+	}
 
 	attach = dma_buf_dynamic_attach(dma_buf, dev->dev,
 					&amdgpu_dma_buf_attach_ops, obj);
 	if (IS_ERR(attach)) {
-		drm_gem_object_put(obj);
-		return ERR_CAST(attach);
+		r = PTR_ERR(attach);
+		goto err_put;
 	}
 
 	get_dma_buf(dma_buf);
 	obj->import_attach = attach;
 	return obj;
+
+err_put:
+	drm_gem_object_put(obj);
+
+err_pm:
+	pm_runtime_put_autosuspend(dev->dev);
+	return ERR_PTR(r);
+}
+
+/**
+ * amdgpu_gem_prime_destroy - destroy an imported BO again
+ * @bo: the imported BO
+ *
+ * Make sure to cleanup the SG table, detach from the DMA-buf and drop the PM
+ * reference we grabbed.
+ */
+void amdgpu_gem_prime_destroy(struct amdgpu_bo *bo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+
+	drm_prime_gem_destroy(&bo->tbo.base, bo->tbo.sg);
+	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
index 3e93b9b407a9..14cc6a873444 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.h
@@ -29,6 +29,7 @@ struct dma_buf *amdgpu_gem_prime_export(struct drm_gem_object *gobj,
 					int flags);
 struct drm_gem_object *amdgpu_gem_prime_import(struct drm_device *dev,
 					    struct dma_buf *dma_buf);
+void amdgpu_gem_prime_destroy(struct amdgpu_bo *bo);
 bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
 				      struct amdgpu_bo *bo);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ff9dc377a3a0..6a22eaf38056 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -39,6 +39,7 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_dma_buf.h"
 
 /**
  * DOC: amdgpu_object
@@ -58,9 +59,8 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
 
 	amdgpu_bo_kunmap(bo);
-
 	if (bo->tbo.base.import_attach)
-		drm_prime_gem_destroy(&bo->tbo.base, bo->tbo.sg);
+		amdgpu_gem_prime_destroy(bo);
 	drm_gem_object_release(&bo->tbo.base);
 	amdgpu_bo_unref(&bo->parent);
 	kvfree(bo);
-- 
2.25.1

