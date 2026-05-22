Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3388ACD5BB0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 09:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C3010F523;
	Fri, 22 May 2026 09:31:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="r7LrG3cb";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B3610F522
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 09:31:51 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so8994475e9.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779442309; x=1780047109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BIfl9QMpKfJfVry55fy6HvqQlJ4boThZ95rv0873Pwg=;
 b=r7LrG3cbe10RvVs1vqe8/8ZoJ41dIl1d0U0B0ZyBBnCu33WWRBdbYvnAFS6xUIk9Uy
 MokYP3rXGOd4mgZQw7o++P3ynLJ3Rx/vljwdda/vdBmi2R3fUE6FHkrmhnGYk7MRXE7n
 KV3bJRjJh66z32BTLQdtm9vcX0DnoDGFaMs3bYY5TP4TtoLUxBJePFSFczDdebEcAxoT
 NspCV9XalGvf5xUkhWiurakH73YSj1FPBtHQzLACiEL9/0fzoKw4FbBbhb5AFYnLC+l2
 xW83q2h/D0oPqdb+NOb/b+kuvgJcl8q+c1b0WZCY6uBnqIOyBz/ruJxXzeiMYQvd5ezO
 9M4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779442309; x=1780047109;
 h=content-transfer-encoding:reply-to:mime-version:message-id:date
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIfl9QMpKfJfVry55fy6HvqQlJ4boThZ95rv0873Pwg=;
 b=fDbTCrdmOkROnGvWxhxbjBNdJBkAcclQKfGgXZ9YmWumQ3fWsft2mQ/M0irpTq0JVe
 UP6BzS+6ASENd1jWOpkRR8DhtliockIHt/6SM8A02vlUIjRyL1R/If92xVIaaX+CznTi
 jcASZhvI9OjwsJT0aDtgboC+cAewa4PVphIbiWLqL422sjb7tqTR7UNhQwglkheXazkp
 5VmaB/GuZJG7QQVSRkW4ZHBDuAiRhn8teyO5/DTzYuj5txdNnmq5pe5SdIUQO7kdyl0u
 IaM8mmzdJUyWzZwjw2PIvRuWXxdAI2zXKRJ6hs2FWBO9T5vXH6/OmstJGTtWL303da0c
 0RdQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hlUzQEqA8s63t5juMGbJ2Aa1IBUqoEK1ohQBhmC/fTSPsnrrzNsuzzut1B0B7SyUwdL62oxM9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyP4VuoQ0YMRinHCxX465/543kptP66+APoU6R4jMr+10BuYXAR
 t7xxOPjBkV5/L1HJZkNa6jyOfL7Lxb762gWEA50dFHRoCAioVALmiaNH
X-Gm-Gg: Acq92OEJpWpC/+jBr7RR/ikTkE5tcQ6YNEdWYv6dPzmbX89eCs+IAvgfAqq/L8Cramy
 xCaCHPMTRD9audWkHlFvSIthi6L12g1124JmMN1Do2QQwY5tZPs1h0MIG4akgQpNlIYolMAiMR5
 U022aH4C+4Joh1nrOWSVpPg/EXSIIxthEm3XKKv5aJlInPyHFVMMdjFK9TqY98meow+uYV3xjp/
 3f5VsyAs7yRZccOmsw3lSICmGU3zT6wvFs1xk5mFIRc0MNWMIDfba5+wVLf9DpcoKblDt83xt4g
 glXDHKq/D1mC8UedXuY5Ztu4+PL5n6iyDaZSkpmqDqSn7uY5xPErhW1ZHgdAVaN4CjSygBif108
 V3f9uHLOxoO0I9C+jvAX22qCrsCvxzAJ0iHArjDa5ZJY9Wfj0Da02112rwTWH6PveEHF+LvmoRa
 6IHtaYd5LPKXB8X0IIWxRvfk0BbVDFT0lj6v/9
X-Received: by 2002:a05:600c:444b:b0:48f:e3e7:3d39 with SMTP id
 5b1f17b1804b1-490424aa04fmr35132285e9.11.1779442309273; 
 Fri, 22 May 2026 02:31:49 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15a5:b300:333a:f9ca:ce66:bcda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454c5eb0sm33305375e9.2.2026.05.22.02.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 02:31:48 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix amdgpu_vm_bo_reset_state_machine
Date: Fri, 22 May 2026 11:31:47 +0200
Message-ID: <20260522093147.11192-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Can't splice the list but need to handle each entry individually.

Otherwise we run into issues after a GPU reset.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b523a7b97d6f..e91504f04d97 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -266,12 +266,23 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 {
+	struct amdgpu_vm_bo_base *vm_bo, *tmp;
+
+	/*
+	 * Don't use list splice here, we need the special handling for the root
+	 * PD and set the moved flag appropriately.
+	 */
 	amdgpu_vm_assert_locked(vm);
-	list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
-	list_splice_init(&vm->always_valid.idle, &vm->always_valid.moved);
+	list_for_each_entry_safe(vm_bo, tmp, &vm->kernel.idle, vm_status)
+		amdgpu_vm_bo_moved(vm_bo);
+	list_for_each_entry_safe(vm_bo, tmp, &vm->always_valid.idle, vm_status)
+		amdgpu_vm_bo_moved(vm_bo);
 
 	spin_lock(&vm->individual_lock);
-	list_splice_init(&vm->individual.idle, &vm->individual.moved);
+	list_for_each_entry_safe(vm_bo, tmp, &vm->individual.idle, vm_status) {
+		vm_bo->moved = true;
+		list_move(&vm_bo->vm_status, &vm->individual.moved);
+	}
 	spin_unlock(&vm->individual_lock);
 }
 
-- 
2.43.0

