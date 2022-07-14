Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97B9C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Jul 2022 10:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48FA1A458F;
	Thu, 14 Jul 2022 10:39:10 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91360A451C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 10:39:08 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id va17so2729735ejb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Jul 2022 03:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YDl995fGKuVB8hPUyxoO63PQ5Y5qiRzfN5wmQe1YPkY=;
 b=L/anpjnDHwegTTYJviPcOYxj1DuXDd0VsUQRQQrdawm0YA58SKj00pcW4kC6k5fG+L
 g8MhOqqxg2a6m61sH83sZET/BLlSy421q0/aJstDurlJmSx4Nq+vd5KU2cKTXDzlYmCr
 Fo2N4+VAGPzcqg5u1eduyskTPnniFiBCbvvdtcMbXmwa+mFI4hrUxYRets6DS7eKkujg
 esSQVwo16tjZkyYirkVTsM7Kb7bbl4dOGn9Mtg/bneZ11nD88BiA9obIcDWhyaT3BHHN
 epE10cPBVEJilT9qcRIYGNy0y2Nv32rDaiEUlVBz70ejRURHYWUHUI1k1nFIXC9WZEBT
 U7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YDl995fGKuVB8hPUyxoO63PQ5Y5qiRzfN5wmQe1YPkY=;
 b=jMSvyjiipH2vxQKzRyHN6lwVTSH+OOJVfpiHUmGi2n2AxhBEj2BYBQ8GSFk+PmiP1U
 51Wfgx06IK3jGkucy87GwP2r66hPyMnXuGEmkDpXKQrL3vMJdWD4s4sbPI5uSAhM9byl
 hHTRPmRX0hiNahAD2+R5cFB4z9Bij2E5gpSUeHFoaVIQFE5haosNyaMZbD5Uv2evxtyJ
 NqT8XYOqoxGeDSTIY1PwwD/KMKcdE/26n3LvgX5NQGlZudWXgAhTUNE5U/dJqqWWeNBV
 kpLqZJAnuT++LR7eYk3yTOtOvSFhQF+YUr6gmO6KXeitQ2hNENXGHZVzvPTU2wS/3M7O
 446A==
X-Gm-Message-State: AJIora8wIP+AKbh2/k5AZWjqRCYm9n4YVkmT6F+klojydeVQytKKNDZM
 8BxZolaqycs+Vq59Nh6uzjXZynN9pp4=
X-Google-Smtp-Source: AGRyM1uEwWmJPOIbtICkMeMoTHGEhzxSgYsyF6WJ5QQ6p2IGeuu+zCpq+WXOytXPTE3X9TiMOqaepA==
X-Received: by 2002:a17:907:7604:b0:72b:4ad5:b21c with SMTP id
 jx4-20020a170907760400b0072b4ad5b21cmr7946288ejc.412.1657795146960; 
 Thu, 14 Jul 2022 03:39:06 -0700 (PDT)
Received: from able.fritz.box (p57b0bd9f.dip0.t-ipconnect.de. [87.176.189.159])
 by smtp.gmail.com with ESMTPSA id
 z13-20020aa7d40d000000b0043adc6552d6sm799487edq.20.2022.07.14.03.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jul 2022 03:39:06 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Marek.Olsak@amd.com,
 timur.kristof@gmail.com, andrey.grodzovsky@amd.com,
 Yogesh.Mohanmarimuthu@amd.com
Subject: [PATCH 02/10] drm/amdgpu: Protect the amdgpu_bo_list list with a
 mutex v2
Date: Thu, 14 Jul 2022 12:38:54 +0200
Message-Id: <20220714103902.7084-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714103902.7084-1-christian.koenig@amd.com>
References: <20220714103902.7084-1-christian.koenig@amd.com>
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Luben Tuikov <luben.tuikov@amd.com>

Protect the struct amdgpu_bo_list with a mutex. This is used during command
submission in order to avoid buffer object corruption as recorded in
the link below.

v2 (chk): Keep the mutex looked for the whole CS to avoid using the
	  list from multiple CS threads at the same time.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Vitaly Prosyak <Vitaly.Prosyak@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2048
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 16 +++++++++++++---
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 714178f1b6c6..2168163aad2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -40,7 +40,7 @@ static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
 {
 	struct amdgpu_bo_list *list = container_of(rcu, struct amdgpu_bo_list,
 						   rhead);
-
+	mutex_destroy(&list->bo_list_mutex);
 	kvfree(list);
 }
 
@@ -136,6 +136,7 @@ int amdgpu_bo_list_create(struct amdgpu_device *adev, struct drm_file *filp,
 
 	trace_amdgpu_cs_bo_status(list->num_entries, total_size);
 
+	mutex_init(&list->bo_list_mutex);
 	*result = list;
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
index 529d52a204cf..9caea1688fc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
@@ -47,6 +47,10 @@ struct amdgpu_bo_list {
 	struct amdgpu_bo *oa_obj;
 	unsigned first_userptr;
 	unsigned num_entries;
+
+	/* Protect access during command submission.
+	 */
+	struct mutex bo_list_mutex;
 };
 
 int amdgpu_bo_list_get(struct amdgpu_fpriv *fpriv, int id,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b28af04b0c3e..d8f1335bc68f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -519,6 +519,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 			return r;
 	}
 
+	mutex_lock(&p->bo_list->bo_list_mutex);
+
 	/* One for TTM and one for the CS job */
 	amdgpu_bo_list_for_each_entry(e, p->bo_list)
 		e->tv.num_shared = 2;
@@ -651,6 +653,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 			kvfree(e->user_pages);
 			e->user_pages = NULL;
 		}
+		mutex_unlock(&p->bo_list->bo_list_mutex);
 	}
 	return r;
 }
@@ -690,9 +693,11 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
 {
 	unsigned i;
 
-	if (error && backoff)
+	if (error && backoff) {
 		ttm_eu_backoff_reservation(&parser->ticket,
 					   &parser->validated);
+		mutex_unlock(&parser->bo_list->bo_list_mutex);
+	}
 
 	for (i = 0; i < parser->num_post_deps; i++) {
 		drm_syncobj_put(parser->post_deps[i].syncobj);
@@ -832,12 +837,16 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			continue;
 
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
-		if (r)
+		if (r) {
+			mutex_unlock(&p->bo_list->bo_list_mutex);
 			return r;
+		}
 
 		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
-		if (r)
+		if (r) {
+			mutex_unlock(&p->bo_list->bo_list_mutex);
 			return r;
+		}
 	}
 
 	r = amdgpu_vm_handle_moved(adev, vm);
@@ -1278,6 +1287,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
 	mutex_unlock(&p->adev->notifier_lock);
+	mutex_unlock(&p->bo_list->bo_list_mutex);
 
 	return 0;
 
-- 
2.25.1

