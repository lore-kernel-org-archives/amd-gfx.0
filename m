Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D524C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 14:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F29C910EC6B;
	Thu, 20 Apr 2023 14:29:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4551110EC68
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 14:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682000970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6BdrM5PAXOTQN54lsRvoJTmZEachvXpdp/asoBdEKLk=;
 b=aT8EZ86DUPAHN92fEAy6StOJsD1rcXTLvQr91jFB+EAptiLU6l5S08U0ftPfADA2emX4q3
 ovi9BtjmlLtpwc9ldxM6IxzFWc1sadE7bVJX3CvyzhOWyXRqbFzEmNwGpowV/9Crpqj7+a
 FodbhqWR2JlhuzYJ+zAp2R/JYbvkLrw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-yL32NlUUPJygqp6B3AAhPg-1; Thu, 20 Apr 2023 10:29:29 -0400
X-MC-Unique: yL32NlUUPJygqp6B3AAhPg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-5efc80e8485so10642426d6.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 07:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682000969; x=1684592969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6BdrM5PAXOTQN54lsRvoJTmZEachvXpdp/asoBdEKLk=;
 b=Ooj6gyU+nfigMoHb+YILoU0VY3kzvrk49G5/tYscRjLoIWKyemzZ2xzX3c3KoCkRMM
 lVaIsQYG+wmePsq5/80NmkVhFA1f2InnzMYsbyIuqS615VKcaxaFLOP5Kkj+wlsyJB1t
 FUOFBnfAe+0n2/Id5/XTT5amPmvs9TqZXwGVFItss7xEJIV5FoHrjeLRewKBOXMC7SAC
 p/ZlJnwMAzRpki7XgxE6G1a0AN+eDERpLy/SL9YNNt/cOm3M94pVbwiKvAcXZaTYHeTB
 nOEVvMMAuJ7n1RU6nylnvSN3ySJ81p4XOkbOPnkxEyE+CZhrH8si9/9Tz2KG5KGkpWL8
 /j2Q==
X-Gm-Message-State: AAQBX9f+nhPF+gEjLFm1xOOfHvo3Qa1Nq0WN5Idut6kZnc0rd9ngVv0w
 ydqDt2be0NLVF+WKhuXFhU1fWDtA9gfphSS0h2cDcDid6oXZMgrcruJ7taO+JkvIongkg/Vztlc
 2Zf2rZ9Ey/CZfAK6pd6njfOj+uQ==
X-Received: by 2002:a05:6214:301e:b0:56e:b557:2d4e with SMTP id
 ke30-20020a056214301e00b0056eb5572d4emr2242319qvb.6.1682000968837; 
 Thu, 20 Apr 2023 07:29:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350bh4jP9BRcxAXAQBGpztEZgR2c1DlH5MA0cabHVDBgEfStN28QcPkDWcM8pWXDcVwsX39FA5w==
X-Received: by 2002:a05:6214:301e:b0:56e:b557:2d4e with SMTP id
 ke30-20020a056214301e00b0056eb5572d4emr2242276qvb.6.1682000968521; 
 Thu, 20 Apr 2023 07:29:28 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com
 (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id
 b27-20020a0cb3db000000b005e750d07153sm420904qvf.135.2023.04.20.07.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Apr 2023 07:29:28 -0700 (PDT)
From: Tom Rix <trix@redhat.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, Hawking.Zhang@amd.com, le.ma@amd.com,
 Jack.Xiao@amd.com, YiPeng.Chai@amd.com, Lang.Yu@amd.com, Likun.Gao@amd.com,
 Arunpravin.PaneerSelvam@amd.com, andrealmeid@igalia.com
Subject: [PATCH] drm/amdgpu: remove unused variable j
Date: Thu, 20 Apr 2023 10:29:25 -0400
Message-Id: <20230420142925.3890505-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Apr 2023 14:29:49 +0000
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
Cc: Tom Rix <trix@redhat.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

gcc with W=1 reports
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function
  ‘amdgpu_gfx_mqd_sw_fini’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:451:16: error: variable
  ‘j’ set but not used [-Werror=unused-but-set-variable]
  451 |         int i, j;
      |                ^
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function
  ‘amdgpu_gfx_disable_kcq’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:486:13: error: variable
  ‘j’ set but not used [-Werror=unused-but-set-variable]
  486 |         int j;
      |             ^
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function
  ‘amdgpu_gfx_enable_kcq’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:529:19: error: variable
  ‘j’ set but not used [-Werror=unused-but-set-variable]
  529 |         int r, i, j;
      |                   ^

These variables are not used, so remove them.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7f5c60381103..ac6fd8620279 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -448,7 +448,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 {
 	struct amdgpu_ring *ring = NULL;
-	int i, j;
+	int i;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 
 	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
@@ -462,7 +462,6 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 	}
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		j = i + xcc_id * adev->gfx.num_compute_rings;
 		ring = &adev->gfx.compute_ring[i];
 		kfree(adev->gfx.mec.mqd_backup[i]);
 		amdgpu_bo_free_kernel(&ring->mqd_obj,
@@ -483,7 +482,6 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	int i, r = 0;
-	int j;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
@@ -495,11 +493,9 @@ int amdgpu_gfx_disable_kcq(struct amdgpu_device *adev, int xcc_id)
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		j = i + xcc_id * adev->gfx.num_compute_rings;
+	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		kiq->pmf->kiq_unmap_queues(kiq_ring, &adev->gfx.compute_ring[i],
 					   RESET_QUEUES, 0, 0);
-	}
 
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->job_hang)
 		r = amdgpu_ring_test_helper(kiq_ring);
@@ -526,7 +522,7 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *kiq_ring = &kiq->ring;
 	uint64_t queue_mask = 0;
-	int r, i, j;
+	int r, i;
 
 	if (!kiq->pmf || !kiq->pmf->kiq_map_queues || !kiq->pmf->kiq_set_resources)
 		return -EINVAL;
@@ -562,10 +558,8 @@ int amdgpu_gfx_enable_kcq(struct amdgpu_device *adev, int xcc_id)
 		queue_mask = ~0ULL;
 
 	kiq->pmf->kiq_set_resources(kiq_ring, queue_mask);
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		j = i + xcc_id * adev->gfx.num_compute_rings;
+	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		kiq->pmf->kiq_map_queues(kiq_ring, &adev->gfx.compute_ring[i]);
-	}
 
 	r = amdgpu_ring_test_helper(kiq_ring);
 	spin_unlock(&kiq->ring_lock);
-- 
2.27.0

