Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9F2C4BA28
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 20:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E7D2072D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 20:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVkubcmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E7D2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B28A6EBC0;
	Wed, 26 Feb 2020 20:34:40 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF9A6EBC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 20:34:38 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id i10so4286006wmd.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 12:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sGgx2NQB1lSisbR0V23+LoLqZTq0MxI+qW6URGswysg=;
 b=aVkubcmrVfDjjnRd9UCS6z7rlOF6jiWO1YXilL55mDSXhBnrxKJP4JgiRhHLvE1W/l
 Bye1JaMMw15bHrieYWsdYb2ARAGok08uhT2n2lC/wg8D70PwBnbqaC/YaI8iVk1KEWmX
 a6s1/aoGvRJRAdvBFIKHtPsYz97uFsdcV56IdfONJiR/4bj7dp32V72LQEVLEuAvkanY
 4a0YRp+VymobkM/uTcxfjOIOjivSRU+t2FXlS3anQB5p/mXEEFI6yQ9utPFYlIvdIxj+
 rfBPwLdJwRvRCXhOqhJ0JQa9mM9hVGQfb9bZ3osrGN22ZdFJjPnX6mFf+q3WWAhGDHPv
 H4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sGgx2NQB1lSisbR0V23+LoLqZTq0MxI+qW6URGswysg=;
 b=arVQvG4u97PUmrHnkV3WqXLB+IDxiXbdwklJaxOgKxeCQOT30twu29CQb0478WCYOy
 Z8KtIsor4moiBZtfO1+zIm2r273N5hJ+azvhaVd3h2wTMeKu7DyMc9OozfqIJzkxsSbE
 nVkHEDeIV4ZcpzGHKWOMMXiN8VppBXu+fUPAxD++K//sc3vfYAjOaJn2d5jgTVGV3m6g
 IgjuMSgqe/KuwIDT8157cO2alJ7eAjZddk5+u1Sugz5QKZgm7BS2g3WPo/EQU8XXSXLt
 3ysm6UJvvKxbMpbBH4jAzX74gbPGmjt6eojRmVZBD/zsmXRB8tqaFH/iR93Y9gv57aNJ
 aBqQ==
X-Gm-Message-State: APjAAAUGXbNdhxuXFkYZQWkJAH9JAF9BRRVtSM1ig/mDDxRuutuoiHJF
 YEQdEZSK18l5WHndmsEvrY2NmreYqFE=
X-Google-Smtp-Source: APXvYqxf8nmifawC+BH1yIutkglfH5Xv3V0ri8ilq0nzQrMx8EXwO0I8EB4StmjHwOvggo+HvD1rqg==
X-Received: by 2002:a7b:cd92:: with SMTP id y18mr668046wmj.133.1582749276901; 
 Wed, 26 Feb 2020 12:34:36 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F275300BB8A7FF1D96B1B54.dip0.t-ipconnect.de.
 [2003:c5:8f27:5300:bb8a:7ff1:d96b:1b54])
 by smtp.gmail.com with ESMTPSA id d76sm4406191wmd.39.2020.02.26.12.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 12:34:36 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 3/3] drm/amdgpu: remove unused functions
Date: Wed, 26 Feb 2020 21:37:30 +0100
Message-Id: <20200226203730.4621-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226203730.4621-1-nirmoy.das@amd.com>
References: <20200226203730.4621-1-nirmoy.das@amd.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove unused amdgpu_ring_priority_put() and amdgpu_ring_priority_get()

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 70 ------------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 --
 2 files changed, 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 4501ae7afb2e..8ac4b569c036 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -150,76 +150,6 @@ void amdgpu_ring_undo(struct amdgpu_ring *ring)
 		ring->funcs->end_use(ring);
 }
 
-/**
- * amdgpu_ring_priority_put - restore a ring's priority
- *
- * @ring: amdgpu_ring structure holding the information
- * @priority: target priority
- *
- * Release a request for executing at @priority
- */
-void amdgpu_ring_priority_put(struct amdgpu_ring *ring,
-			      enum drm_sched_priority priority)
-{
-	int i;
-
-	if (!ring->funcs->set_priority)
-		return;
-
-	if (atomic_dec_return(&ring->num_jobs[priority]) > 0)
-		return;
-
-	/* no need to restore if the job is already at the lowest priority */
-	if (priority == DRM_SCHED_PRIORITY_NORMAL)
-		return;
-
-	mutex_lock(&ring->priority_mutex);
-	/* something higher prio is executing, no need to decay */
-	if (ring->priority > priority)
-		goto out_unlock;
-
-	/* decay priority to the next level with a job available */
-	for (i = priority; i >= DRM_SCHED_PRIORITY_MIN; i--) {
-		if (i == DRM_SCHED_PRIORITY_NORMAL
-				|| atomic_read(&ring->num_jobs[i])) {
-			ring->priority = i;
-			ring->funcs->set_priority(ring, i);
-			break;
-		}
-	}
-
-out_unlock:
-	mutex_unlock(&ring->priority_mutex);
-}
-
-/**
- * amdgpu_ring_priority_get - change the ring's priority
- *
- * @ring: amdgpu_ring structure holding the information
- * @priority: target priority
- *
- * Request a ring's priority to be raised to @priority (refcounted).
- */
-void amdgpu_ring_priority_get(struct amdgpu_ring *ring,
-			      enum drm_sched_priority priority)
-{
-	if (!ring->funcs->set_priority)
-		return;
-
-	if (atomic_inc_return(&ring->num_jobs[priority]) <= 0)
-		return;
-
-	mutex_lock(&ring->priority_mutex);
-	if (priority <= ring->priority)
-		goto out_unlock;
-
-	ring->priority = priority;
-	ring->funcs->set_priority(ring, priority);
-
-out_unlock:
-	mutex_unlock(&ring->priority_mutex);
-}
-
 /**
  * amdgpu_ring_init - init driver ring struct.
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index a109373b9fe8..e6c3bcb990fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -259,10 +259,6 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
 void amdgpu_ring_commit(struct amdgpu_ring *ring);
 void amdgpu_ring_undo(struct amdgpu_ring *ring);
-void amdgpu_ring_priority_get(struct amdgpu_ring *ring,
-			      enum drm_sched_priority priority);
-void amdgpu_ring_priority_put(struct amdgpu_ring *ring,
-			      enum drm_sched_priority priority);
 int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		     unsigned ring_size, struct amdgpu_irq_src *irq_src,
 		     unsigned irq_type);
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
