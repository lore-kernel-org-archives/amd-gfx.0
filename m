Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93094C6FA8B
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 09:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7338410ECF8;
	Fri, 16 Sep 2022 09:09:01 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F6FB10ECFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 09:08:52 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id n10so4376922wrw.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=x0sxuA40CGAfTo3hYlFLhHB52EytmtxpQpGrsvH7/NE=;
 b=bbXm2WcMV/JpBIiDUqDVl8CpN/5gqYpDRZp1L+v5/VrVAMZjKuwnIzcq1R9O0ieljy
 qgBlv5mNXzUbzG4oLnIkDHWpQ2stXaghrhacU0bz1HyxvdBPRsF/G7aILTOW4gukUPus
 AwRArTBsv+tXTNopymptSVzovjjwLxedM3nC3uL1EKQAoLJSUG+PgV/3G41HpY4ok1xf
 qJk6mAt7MiGiQut5bUH6umyxaVXnbaO7hI7RO35TKC8twFs8+EwbbitLbiHpw3Igwghw
 a09p4iDNV3faiTdZN+KE/HU/iJmlahxs++/k0yDYO0RRbRPAGAz3pD2RPE3PqNw2Cyot
 UEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=x0sxuA40CGAfTo3hYlFLhHB52EytmtxpQpGrsvH7/NE=;
 b=SV17ZSTTy0Zm1ArOjbZkz9WLbNqXBQ5P1+5ncqfJbZWSajnbC7iTCLGRZfwNskz350
 r8Ac4onhxDdsmJfzXar0ngKEHjaesC4XgqoxJK4Chvti5jgEOA3KaciyrKITJ/py9I2D
 RWPsN+qRVfxtVQOoWah2dpIIKuttxqS1cKSd4PZXcYuweUdpykDZSEBfXAmF/NJ+pP/S
 XOEvq7l2TdkhVTRHVIvGhy4jcO83hoyjQXfuNLZoxWcQo4rfXSjp0PtxZqyVlwShVesm
 j2NmKSRHyIj40rlRDKKOR1jT9QAVZT+bjqSY69lDyPbTcCcJ5zDWagG7dubUD3gaXD4U
 xpLw==
X-Gm-Message-State: ACrzQf1AwG+v+oQ4n7mGHO2oN/MrAFZtT+5lc4EPLH551Jm6FZOFtjMl
 89hOLJJiSVJ7jnCf9qZZ0Mbh3AZizV4=
X-Google-Smtp-Source: AMsMyM5O/bXYwy8iLPosam7BYriwslDFzjQP7bDIl4hQyVtTrsaVP1Nkq3eepYQndTgGetnBCBwmEA==
X-Received: by 2002:a5d:6852:0:b0:228:c94b:a5b0 with SMTP id
 o18-20020a5d6852000000b00228c94ba5b0mr2126416wrw.540.1663319330950; 
 Fri, 16 Sep 2022 02:08:50 -0700 (PDT)
Received: from able.fritz.box (p4fc20ebf.dip0.t-ipconnect.de. [79.194.14.191])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff24c000000b00226d1711276sm4604145wrp.1.2022.09.16.02.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Sep 2022 02:08:50 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH 2/8] drm/amdgpu: cleanup error handling in amdgpu_cs_parser_bos
Date: Fri, 16 Sep 2022 11:08:39 +0200
Message-Id: <20220916090845.3336-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916090845.3336-1-christian.koenig@amd.com>
References: <20220916090845.3336-1-christian.koenig@amd.com>
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
Cc: bas@basnieuwenhuizen.nl,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Return early on success and so remove all those "if (r)" in the error
path.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 37 +++++++++++++-------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index c04073f4ead5..5c37dde97ff2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -933,35 +933,34 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	if (r)
 		goto error_validate;
 
-	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
-				     p->bytes_moved_vis);
-
-	amdgpu_job_set_resources(p->job, p->bo_list->gds_obj,
-				 p->bo_list->gws_obj, p->bo_list->oa_obj);
-
-	if (!r && p->uf_entry.tv.bo) {
+	if (p->uf_entry.tv.bo) {
 		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(p->uf_entry.tv.bo);
 
 		r = amdgpu_ttm_alloc_gart(&uf->tbo);
+		if (r)
+			goto error_validate;
+
 		p->job->uf_addr += amdgpu_bo_gpu_offset(uf);
 	}
 
+	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
+				     p->bytes_moved_vis);
+	amdgpu_job_set_resources(p->job, p->bo_list->gds_obj,
+				 p->bo_list->gws_obj, p->bo_list->oa_obj);
+	return 0;
+
 error_validate:
-	if (r)
-		ttm_eu_backoff_reservation(&p->ticket, &p->validated);
+	ttm_eu_backoff_reservation(&p->ticket, &p->validated);
 
 out_free_user_pages:
-	if (r) {
-		amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
-			struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
+	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
+		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
 
-			if (!e->user_pages)
-				continue;
-			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
-			kvfree(e->user_pages);
-			e->user_pages = NULL;
-		}
-		mutex_unlock(&p->bo_list->bo_list_mutex);
+		if (!e->user_pages)
+			continue;
+		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
+		kvfree(e->user_pages);
+		e->user_pages = NULL;
 	}
 	return r;
 }
-- 
2.25.1

