Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1F2C77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 12:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F12610E306;
	Wed, 12 Apr 2023 12:20:43 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DF610E2A0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 12:20:42 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f080fc6994so3648555e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 05:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681302040; x=1683894040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oRjzeT6yzS5ekppVJWii3K/BjwY+l2NqEtQCNxKdBXw=;
 b=G5iTiR8bKjysyAEHap6lo98BbJ8tkOEQ/EA/v/B0yAGz/ch14TcsMUky/NnPrfsuVX
 9RTpSX5T0yx90GieWCFo+1vFXc6CjrayFFAiEMxPJfD3F9yc8pqrRgg8Nngt6ehJ1VP2
 4qd8ZgQhatsKz19/dOUXlvhPvQWUhSnU3d7bk+pZhe6rGCgG3ErWqL7cn/g9b2iZcdCo
 gYgEi/jCJEQeGelH1LXexzw9/TCntKlP4zANNWxqC0cFU3voq0R4kZ9tIlPczVHie23I
 n3RYbL/uFrepZpxc5jvlI/JAXLge6wc61yuRIkmaB2ZA0AMy7vIOyrS4FF6CErV/kyo4
 jDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681302040; x=1683894040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oRjzeT6yzS5ekppVJWii3K/BjwY+l2NqEtQCNxKdBXw=;
 b=HVMkI+ACQQJwIMal4qYqgvkp1ZGe8E5RuuMnAlz0nGPEAjDJ7+k/B5Ny5bVw51NvRS
 g8HxRzfKMzET9oDv3WbCZ/rdR6ptLW9tAkEWd+cMFX0Jq4zsv9KSZBloUR+/xdAkLBt2
 cnOzjJIV8EZ2kbO0CTqK+mzEm3Z02alJsOM5jhI+HJt5r27XSrZ3FCnGIIjEcb4izWJw
 T79igh4w/T6UrIGZeGp9RL7aF7PDkvpw5LDXfNpzjRfNw7b/TyTc6D5NL68PfeCSXuQ7
 16r7+aAwPet3hygRoUB13eOvkjZowlmx6dv/oR/ul6cGbkmqXRf98wwT7GAW++spZNQH
 8p/w==
X-Gm-Message-State: AAQBX9e8cibO6+tUOlSnIQe2osNsLJAl2tWSg4i+EPcBxHXh62KLiLYr
 n5tb1X/dn1UIRx8PEiHwGIzJ9OaJJBtU2pWs6u7uMg==
X-Google-Smtp-Source: AKy350bnjj4Zuse48kAR5nYOmaQxEul8h+g0iC6dYYHF1UiLlSvg9YKXo03T1C/T4TAy2QwhToERUA==
X-Received: by 2002:a05:600c:c8f:b0:3f0:9deb:c60a with SMTP id
 fj15-20020a05600c0c8f00b003f09debc60amr1621566wmb.4.1681302039764; 
 Wed, 12 Apr 2023 05:20:39 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a782:cc00::ab])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a05600c358500b003f09fd301ddsm1366428wmq.1.2023.04.12.05.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Apr 2023 05:20:38 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/2] drm/amdgpu: Add a max ibs per submission limit.
Date: Wed, 12 Apr 2023 14:18:26 +0200
Message-Id: <20230412121827.1122035-1-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.40.0
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
Cc: alexander.deucher@amd.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 christian.koenig@amd.com, maraeo@gmail.com, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

And ensure each ring supports that many submissions. This makes
sure that we don't get surprises after the submission has been
scheduled where the ring allocation actually gets rejected.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 25 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 7af3041ccd0e..8362738974c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -110,6 +110,9 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
 	if (r < 0)
 		return r;
 
+	if (num_ibs[r] >= amdgpu_ring_max_ibs(chunk_ib->ip_type))
+		return -EINVAL;
+
 	++(num_ibs[r]);
 	p->gang_leader_idx = r;
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index dc474b809604..abd70d2f26f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -49,6 +49,25 @@
  * them until the pointers are equal again.
  */
 
+/**
+ * amdgpu_ring_max_ibs - Return max IBs that fit in a single submission.
+ *
+ * @type: ring type for which to return the limit.
+ */
+unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type)
+{
+	switch (type) {
+	case AMDGPU_RING_TYPE_GFX:
+	case AMDGPU_RING_TYPE_COMPUTE:
+		/* gfx/compute are often used more extensively and radv
+		 * has historically assumed the limit was 192.
+		 */
+		return 192;
+	default:
+		return 50;
+	}
+}
+
 /**
  * amdgpu_ring_alloc - allocate space on the ring buffer
  *
@@ -182,6 +201,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 	int sched_hw_submission = amdgpu_sched_hw_submission;
 	u32 *num_sched;
 	u32 hw_ip;
+	unsigned int max_ibs_dw;
 
 	/* Set the hw submission limit higher for KIQ because
 	 * it's used for a number of gfx/compute tasks by both
@@ -290,6 +310,11 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		return r;
 	}
 
+	max_ibs_dw = ring->funcs->emit_frame_size +
+		     amdgpu_ring_max_ibs(ring->funcs->type) * ring->funcs->emit_ib_size;
+	max_ibs_dw = (max_ibs_dw + ring->funcs->align_mask) & ~ring->funcs->align_mask;
+	max_dw = max(max_dw, max_ibs_dw);
+
 	ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
 
 	ring->buf_mask = (ring->ring_size / 4) - 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 3989e755a5b4..e6e672727529 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -317,6 +317,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_patch_cond_exec(r,o) (r)->funcs->patch_cond_exec((r),(o))
 #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
 
+unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
 void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
 void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
-- 
2.40.0

