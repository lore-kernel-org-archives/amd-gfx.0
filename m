Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E3FC9EC67
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 10:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E3510E336;
	Mon, 12 Jan 2026 10:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YPwvm185";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C4610E333
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L8CKEkYi+0VnPetSngoexJD1ZBbfyPUl+p4EfVFjrEg=; b=YPwvm185oVPHfshCFwggmAjogO
 6Ve1tPvFn4/eOZcYA6w522TWlOJUk2w/RcjvnfMYPUxQlF4FF9qlUcCGctKyyJJmAkWdKTP40+w5A
 ElTu5ZuUuXrEY3JAbwLXnoLJ7PQ3N/fQlRQRnSnK3D7ypC1+W4MrK6ymvPiGLnmJuF0y/FZB4AdpG
 iQ7Cpd9ZSoPfobqL2WC6FcwTWhXcqKT594/OUhzlb6emxiwRT0ueNyMEJzAdh73ay9FgsW6ETgtoX
 JopKK5tg7MUtHv135iIRRqWivI9evYAkkeV6l98+nZ3wG42RAMw0+qOHknPhO/mAyc0+iVokefJB7
 6cqri8WA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vfF4W-004Lck-Af; Mon, 12 Jan 2026 11:22:52 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 07/12] drm/amdgpu: Remove arbitrary number of contexts
 limitation
Date: Mon, 12 Jan 2026 10:22:39 +0000
Message-ID: <20260112102244.63308-8-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
References: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
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

There is no need for an arbitrary limit to number of contexts userspace
can be allowed to create. Remove the AMDGPU_VM_MAX_NUM_CTX (4096) and
allow for full 32-bit of handles to be allocated.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9f9774f58ce1..80dba6276aa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -274,7 +274,6 @@ extern int amdgpu_rebar;
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
 
-#define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
 #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 02988be1fae7..325833ed2571 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -490,14 +490,14 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
 		return -ENOMEM;
 
 	mutex_lock(&mgr->lock);
-	r = idr_alloc(&mgr->ctx_handles, ctx, 1, AMDGPU_VM_MAX_NUM_CTX, GFP_KERNEL);
-	if (r < 0) {
+	*id = 1;
+	r = idr_alloc_u32(&mgr->ctx_handles, ctx, id, UINT_MAX, GFP_KERNEL);
+	if (r) {
 		mutex_unlock(&mgr->lock);
 		kfree(ctx);
 		return r;
 	}
 
-	*id = (uint32_t)r;
 	r = amdgpu_ctx_init(mgr, priority, filp, ctx);
 	if (r) {
 		idr_remove(&mgr->ctx_handles, *id);
-- 
2.52.0

