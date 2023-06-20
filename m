Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CE2EB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 11:18:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE1110E2CF;
	Tue, 20 Jun 2023 11:18:19 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9279010E2CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 11:18:17 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3110a5f2832so4347515f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 04:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687259895; x=1689851895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qWsp4yYru4kXBlNawXqd7nUHoJlFCWUW68NeTeczsFY=;
 b=Q2vQa+FQd8YNPYSxe2Y6FLVyD9QOh34DvL5kEcwuIBBj+gFbpdrLzVCpL4PQu0YU0D
 UY7Z16kz0+UNyWDZEHbJEimoJPH3zrBiyRYVWGol20s1J3lhmPXK9hlmm7CXztyU4El9
 fIvvhd6igbDpTGiikx72Uk5VdZEA2qd9BI5ZotHHfPCqtFPb7ddiEGsB6NVp4YWqz3oj
 WAUCgx88HdSE/hQPb3EGBkPqnAlVEVgs5tivwrIbhneBblR1oK9hF2JRwW5jD/pZ6mLM
 DKcGMSRa0273NrWB0828WQqvtpJAD/ibqyCSqb4wAWZbh0iF0FWpCQxSxC6pkZtOaJZg
 LUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259895; x=1689851895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qWsp4yYru4kXBlNawXqd7nUHoJlFCWUW68NeTeczsFY=;
 b=ireiVq0Kp1j1szFmALS9Mu/xMHNsMFYhq+gzKpz7+NRZgvX3sjLKk0qEyQ7W3z9LRZ
 doUAbRHMywV8aJHKyMCg4UwmKfPY+ZPNHugQBItMUpc/gxb/6aZg0ihgWPBrY30MS24C
 xtZ8txryLVyRXMguaBcM1CcIc+Db8cvp1bNfKxXwefv2rq/X1iNib3GYqq7Ri0OWKvFv
 ojOm7w+s/lIw35+EiIP3BP6tJ452wf2ZqfhwumiRN6y1dFPyJspeoEqg5Pn6T+Zd7k93
 SwcwR/3YSL8EXNAjo4wTfhQKSpuudyJvSVB2SITb8PV9lt8mbMgWrix6TctZdvBwHJBq
 eN+g==
X-Gm-Message-State: AC+VfDz/7yW+4XVKtP7t+en8v8HpiXEiYWBvuotlTFMTNtYcJqRnOfZ5
 Q9N0wjKzuOpKxy1r1CWTTgk=
X-Google-Smtp-Source: ACHHUZ5Sg24OYgdntcqERFz5wqRJZVM5vjHy3fcKd4ZLuBzw43CabGQWmTmVi5cZxWFFWQ364qXlEw==
X-Received: by 2002:adf:ea45:0:b0:30f:df4e:217d with SMTP id
 j5-20020adfea45000000b0030fdf4e217dmr10286140wrn.6.1687259895373; 
 Tue, 20 Jun 2023 04:18:15 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154d:9c00:2ee6:f0fd:671e:1d86])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a5d54c8000000b0030fae360f14sm1758757wrv.68.2023.06.20.04.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:18:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, Yunxiang.Li@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix number of fence calculations
Date: Tue, 20 Jun 2023 13:18:13 +0200
Message-Id: <20230620111813.2523-1-christian.koenig@amd.com>
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

Since adding gang submit we need to take the gang size into account
while reserving fences.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 4624459c84d7 ("drm/amdgpu: add gang submit frontend v6")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index d9503882ea97..b34f9f8d33d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -136,9 +136,6 @@ static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
 	bo = amdgpu_bo_ref(gem_to_amdgpu_bo(gobj));
 	p->uf_entry.priority = 0;
 	p->uf_entry.tv.bo = &bo->tbo;
-	/* One for TTM and two for the CS job */
-	p->uf_entry.tv.num_shared = 3;
-
 	drm_gem_object_put(gobj);
 
 	size = amdgpu_bo_size(bo);
@@ -912,15 +909,19 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 
 	mutex_lock(&p->bo_list->bo_list_mutex);
 
-	/* One for TTM and one for the CS job */
+	/* One for TTM and one for each CS job */
 	amdgpu_bo_list_for_each_entry(e, p->bo_list)
-		e->tv.num_shared = 2;
+		e->tv.num_shared = 1 + p->gang_size;
+	p->uf_entry.tv.num_shared = 1 + p->gang_size;
 
 	amdgpu_bo_list_get_list(p->bo_list, &p->validated);
 
 	INIT_LIST_HEAD(&duplicates);
 	amdgpu_vm_get_pd_bo(&fpriv->vm, &p->validated, &p->vm_pd);
 
+	/* Two for VM updates, one for TTM and one for each CS job */
+	p->vm_pd.tv.num_shared = 3 + p->gang_size;
+
 	if (p->uf_entry.tv.bo && !ttm_to_amdgpu_bo(p->uf_entry.tv.bo)->parent)
 		list_add(&p->uf_entry.tv.head, &p->validated);
 
-- 
2.34.1

