Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B2DD41D68
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 17:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8513810E2DD;
	Thu, 11 Dec 2025 17:37:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ljmYOIaV";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776A810E840
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 17:37:31 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-297e239baecso2210585ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 09:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765474651; x=1766079451; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z0hbmDRbXFZrAQDUtqIbY5FJkgcRQcF0dFfjL7QqhFc=;
 b=ljmYOIaV/6xiQQuAL56JW8EMAoQpJKRvx4AliXabsMLScBePJivU13fsy9cBl3j8Mg
 klzpRxknHHg3zlj+RV2O1IYT1y6MIIhNvXNr4qNZIYZVyScLwhUXLiJw18Gr9q4Otofs
 SioXB+uGwhjRUk6r7RI20SHR2SuEzQrSMaJKBldHlh8dbBe5UhTlb6mvhZnhLMKQQyn1
 PQTjn41WkLmL0Xv2nM5+fIItfNKqrUq0qzU5Lxk/2aT5e3lYTt/kB9a7T6Xm6bVUdokp
 F3r+/2c95O/JjlpMkLtHVZu1VCIpttLwhN/PPjUuMOqA0S7jcBZJHk/1CPxA8SnEuq2+
 DiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765474651; x=1766079451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z0hbmDRbXFZrAQDUtqIbY5FJkgcRQcF0dFfjL7QqhFc=;
 b=ONUPpSa7XSVRwk0E2bnYBdiNEMoYc4E3d9DFZ2LBh50kH0jCwzaJNKideugwQ2A2Cn
 K6tma7rQI1eQ8lowTwGP+qlokeOcJLSERt3xIjo+sFu1vmfZ79HGtwLLdsgmAd6CZ5Ze
 20uf8o4DDN3DRs8H7SXOUscSDU5pHKlfjV88F3ucr4blQpCNMhNPxn5M7l20Rr1HgPoD
 6D59YcE5TdYamy/PLSXPZCwLdK7GgoKlDohmTaRldgN5WGoBwEUaXZMVhTBrBgGn4aFJ
 zyonNOBIUo2WxvZGz6F5GjAjN/Nwn165Kg9VHlucL1J27cgpfdPWVFvuPOIM2S1ktIh8
 G6zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx66f9RlPKC6IHApeaKG3s2Y+YbaUPyuKsxHr2POlQpXBY+r7AZ+QvxYccx/df0ZqFh/lDc4pE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzU8cEcmhXseL4H4UHCzLIZquP3Vcs3qN6qED1LhXsTPTZZK+WL
 arlUfa+GJhMp4s+mzRRucjbxELDZwlBz0YEq4cULIOi45nsXg0rK6fTL
X-Gm-Gg: AY/fxX7rnDAxhKzmY671W0V6BGPyp+4Lhm7Jq01bf8ixvOIDTzYB3TT4N/LubPskbw4
 bqook+EYsDQYSQpvbbrZ7dilXncmeu4mEs6BgNer0Wc8LJ7fksXQ0ao6jqGJz/oxVnoPek7Lt4k
 aP1D9EVHRE6GinQCekTJa6sb3XpcjoY1faCr+bPsiqhXtz8WzS2gA4BzrZWS1+nO88utr3g4wMZ
 NWR2QUNwVx455sR/QMdkUqidtgH/ds8Z37RMKSqrgFrLOUXRJkm/NpFJbBd7CVa9EdQoQtA/iQD
 qrxijhtkFGfVBk88kR5TSMLwEgpupPMk6nCkQ0uxNouPrrzJQ4DnjwImiaL3Svz+IM4pJv7LwGv
 Esfwy1jK+IPlgLAU14NNFNzqkKPtYL9Jb+uyVXk0tFT10AV8q2XrP7GAwminEF5DZ6LM3xw4WBw
 l2dfNXltYAQC1AfjRAOicfQw==
X-Google-Smtp-Source: AGHT+IG6Tz+OKiDUjkDG6KDZ0q6P2DnSGh1Y7L3vFX1ti9wXd9YPJyy6TMUtQ8BmxQmqXyApc/nt+Q==
X-Received: by 2002:a17:902:ebcb:b0:298:45e5:54a4 with SMTP id
 d9443c01a7336-29eeee9eea0mr27122375ad.1.1765474650876; 
 Thu, 11 Dec 2025 09:37:30 -0800 (PST)
Received: from sallu.. ([2402:e280:2130:b5:2300:5a6a:931b:624f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29eea0169easm30817565ad.50.2025.12.11.09.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 09:37:30 -0800 (PST)
From: Saleemkhan Jamadar <saleemkhan083@gmail.com>
To: Christian.Koenig@amd.com, alexander.deucher@amd.com,
 amd-gfx@lists.freedesktop.org, saleemkhan083@gmail.com
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v3] drm/amdgpu: do not use amdgpu_bo_gpu_offset_no_check
 individually
Date: Thu, 11 Dec 2025 23:06:53 +0530
Message-ID: <20251211173723.82165-1-saleemkhan083@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This should not be used indiviually, use amdgpu_bo_gpu_offset
with bo reserved.

v3 - unpin bo in queue destroy (Christian)
v2 - pin bo so that offset returned won't change after unlock (Christian)

Signed-off-by: Saleemkhan Jamadar <saleemkhan083@gmail.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  8 +++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    | 22 ++++++++++++++++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 3040437d99c2..bc7858567321 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -129,7 +129,7 @@ uint32_t amdgpu_doorbell_index_on_bar(struct amdgpu_device *adev,
 {
 	int db_bo_offset;
 
-	db_bo_offset = amdgpu_bo_gpu_offset_no_check(db_bo);
+	db_bo_offset = amdgpu_bo_gpu_offset(db_bo);
 
 	/* doorbell index is 32 bit but doorbell's size can be 32 bit
 	 * or 64 bit, so *db_size(in byte)/4 for alignment.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index bff39dcb4068..f8e66f6e8c09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -586,6 +586,14 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
 	amdgpu_bo_unref(&queue->db_obj.obj);
+
+	r = amdgpu_bo_reserve(queue->wptr_obj.obj, true);
+	if (!r) {
+		amdgpu_bo_unpin(queue->wptr_obj.obj);
+		amdgpu_bo_unreserve(queue->wptr_obj.obj);
+	}
+	amdgpu_bo_unref(&queue->wptr_obj.obj);
+
 	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
 #if defined(CONFIG_DEBUG_FS)
 	debugfs_remove_recursive(queue->debugfs_queue);
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 8b0aeb89025a..f2309d72bbe6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -94,8 +94,28 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 		return ret;
 	}
 
-	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset_no_check(wptr_obj->obj);
+	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
+	if (ret) {
+		DRM_ERROR("Failed to reserve wptr bo\n");
+		return ret;
+	}
+
+	/* TODO use eviction fence instead of pinning. */
+	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
+	if (ret) {
+		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
+		goto unresv_bo;
+	}
+
+	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
+	amdgpu_bo_unreserve(wptr_obj->obj);
+
 	return 0;
+
+unresv_bo:
+	amdgpu_bo_unreserve(wptr_obj->obj);
+	return ret;
+
 }
 
 static int convert_to_mes_priority(int priority)
-- 
2.43.0

