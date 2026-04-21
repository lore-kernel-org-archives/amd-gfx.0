Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B846BF8FA72
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 12:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A7110E1D0;
	Tue, 21 Apr 2026 12:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fuRf1S1+";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D15110E1BA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 12:55:20 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so53817065e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 05:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776776119; x=1777380919; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/3ofVpq0X7zodalrigakUx9Dgkxk1Jcpvm/hfJB9ks=;
 b=fuRf1S1+4eZVEFqBIjLdaf8grhEHKS/oUwqInJ/o0Ah0xp6BuEcPjb97DrYczUtpP8
 QZS2IK31jcY2OfVzXXLTv0URZi8e/Ata3fES+80VdbP/a8LZZfk6o++qG2TRBYBcxyY9
 xqdJ6Smirskjc9xTaO/0QBiVaQ106PRBTg/cBoVbqH7mApKD3alfSMnlCkARyHpwrn5f
 32lvjxwATs5dAn27ptrwq6yPuFXSn2dlHfK7I6MWpQMqnnk0z3jyAZzq+wyiIvHRhIv7
 OHBSgsm0K51+8EfooABiu4CNQUWjU+UHcjPfwHERd4dKrtb+KAWdEFatgfnHR1zXyxu9
 rYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776119; x=1777380919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j/3ofVpq0X7zodalrigakUx9Dgkxk1Jcpvm/hfJB9ks=;
 b=V3B3DzAGbAfWWchv58CYSb2Eve++4vJbXIrZbrVTKrhis9/cTksh9X50/Lk3IqLZkt
 S59NcwjWPzld2SpB5MWe6xzvAL1RSi2pgqw/zjDZBBVId79Ai6hTEPNXcQYoCHO/wyrX
 Rbagq6uXoFa7wWymr5QCcvR7NFrGLUEZ7/YQ4M+wxVN2qcv3OmfmKuXv1+NjYR1OAT7o
 0wI9/7DylOxzJdrElPgDVXsat4QcJh+AnONhraJ6BwSmvOGGeSDu1zo/XTxNB7Flbj33
 cTrWDV6/M6Y+IZ099zrwX5Yaw4rbgn/Lo+VWBc1h6iVoUAqo8WJgVCZi5OCNmMAL7Vbe
 UOnw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+t2GZSZwROo9lgXow9eEEc1y7JfxHWhDAVMHZ2J13SMIhtzOvu0xyZpSsOythB9/poCGK30D8U@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLnzVDUqQfIiFfRL4ZIGHspT/NxJqkfT1otP4RUGzFeeCs78yK
 DdmxKUL4RiyiUKHb4qG2Bt5AJN5gB1totVYxPncZHb3XpYSXcx3/TFHSK6oHIQ==
X-Gm-Gg: AeBDiesyDjB6Qjgja3ZCT5ImknaW9HfBkzrmSKn3aCELlpZukEpX2+PnoVHVPBzwrSw
 g051gqN+Ri3pmOhanVdeHUYqKC6jjbsT4LsQbP66uXKhDDOjIBNI0ftGypk0sqPahR2Bc930TJM
 mO3QoERWrgL62a1BzqGFbEezLJRPGHteXvTfWJvy5uXMojlirYx558jTFC9cn2S4qwK+4kjOuxA
 t8U/KdhQqWGHJ+mIs3GAjprMVnA/oQHMxFa165/sj5FlcLRdWtK8qQXcQ44Mi0jKdOUi2DINCar
 yP7knzw7vaOhS6NobqMnrgORJ02SnV2JNxs5h3gBfuWHuXTDDs+4YTa8RCy5CxX5ZqxrEW5gky4
 VgLnEYW8xB65SoiePS6kDIG9k/Kqm7sVy1CTDFaVhZzUoVxd05r7tF/QEnz8NLXaUqcAP28lXOU
 FIKxyIimrfjKyG/20qG4O2XK3sdMhasE9rbp00jJfWeGndt/A=
X-Received: by 2002:a05:600c:8901:b0:485:3fa9:358c with SMTP id
 5b1f17b1804b1-488fb778117mr192853205e9.17.1776776118387; 
 Tue, 21 Apr 2026 05:55:18 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15aa:5a00:935c:42ec:dfce:89a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb79ecb9sm154777915e9.8.2026.04.21.05.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:55:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [PATCH 02/11] drm/amdgpu: remove deadlocks from amdgpu_userq_pre_reset
Date: Tue, 21 Apr 2026 14:55:04 +0200
Message-ID: <20260421125513.4545-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421125513.4545-1-christian.koenig@amd.com>
References: <20260421125513.4545-1-christian.koenig@amd.com>
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

The purpose of a GPU reset is to make sure that fence can be signaled
again and the signal and resume workers can make progress again.

So waiting for the resume worker or any fence in the GPU reset path is
just utterly nonsense.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 26 +++++++++++------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8f48520cb822..b632bc3c952b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1496,23 +1496,21 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
 {
 	const struct amdgpu_userq_funcs *userq_funcs;
 	struct amdgpu_usermode_queue *queue;
-	struct amdgpu_userq_mgr *uqm;
 	unsigned long queue_id;
 
+	/* TODO: We probably need a new lock for the queue state */
 	xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
-		uqm = queue->userq_mgr;
-		cancel_delayed_work_sync(&uqm->resume_work);
-		if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
-			amdgpu_userq_wait_for_last_fence(queue);
-			userq_funcs = adev->userq_funcs[queue->queue_type];
-			userq_funcs->unmap(queue);
-			/* just mark all queues as hung at this point.
-			 * if unmap succeeds, we could map again
-			 * in amdgpu_userq_post_reset() if vram is not lost
-			 */
-			queue->state = AMDGPU_USERQ_STATE_HUNG;
-			amdgpu_userq_fence_driver_force_completion(queue);
-		}
+		if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
+			continue;
+
+		userq_funcs = adev->userq_funcs[queue->queue_type];
+		userq_funcs->unmap(queue);
+		/* just mark all queues as hung at this point.
+		 * if unmap succeeds, we could map again
+		 * in amdgpu_userq_post_reset() if vram is not lost
+		 */
+		queue->state = AMDGPU_USERQ_STATE_HUNG;
+		amdgpu_userq_fence_driver_force_completion(queue);
 	}
 }
 
-- 
2.43.0

