Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B145C3DA59
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jul 2024 16:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1912510EC4E;
	Fri, 19 Jul 2024 16:05:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h5VswEq/";
	dkim-atps=neutral
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B6AD10EC4E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 16:05:40 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-2eede876fccso26093991fa.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jul 2024 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721405138; x=1722009938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=49CQAQerjgkuPp61bfF3a5t9ExKOAO60fJvR+XWNpbs=;
 b=h5VswEq/JktXQ7dTkFna/5TxpJ/ewhzVSI7do97y7SVJiNfH8kkVUjcy/ZSu4kPcK0
 fw2fmzobfKPrS/dD8t7NQUB78+CzhSaMt4jlK+iWVMXivOaT3FNvh6gtnx7T3B1Ipq3t
 agQqs6le79vj/VC/Ew/0GfelGdQxmg3b+n3bcIXqHr72IWn4Klg9o2YJXMoqAaobXaDQ
 in92zBvlUhNkfGl4kOjZQZ1t6jGc/+LdToYhZ+uP6uuvhGfCHjt6GIHacVZunyVObbI2
 er+srIKVqvv5SWDrNBiwu10UjQ+UCdHcQCJtF1gBRpq+02nX/M18nV4gh+i05zBLdaBY
 75VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721405138; x=1722009938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=49CQAQerjgkuPp61bfF3a5t9ExKOAO60fJvR+XWNpbs=;
 b=VPmMn5NUZqAlXg/FbewQLGjXwfxr9l59C9DU8HaxA2QkikqtcPsvEJzK8L/4un+bQh
 f53sQICGqrVatyYm77uVJR2trWf2DBl8mjJmN84xvcwT7qihDaQJ4IpdhQ6BuxC3jS35
 sz+ZIZB5QxIhKiiHXVz0cV0feu/B3yc5sIIVhQU+KSVyqaCXClcOSpQFEgnqpW5/y/Up
 6BnvyG1TlG35R/2D80C+ZXJgzZsJndRsQRFEyq/J1G7Up/ODtpVvjf+pAxS6JyZ0mO+r
 PuW8I0c9wf2nkuaPNsUqRepENnZZROhpK3eUjJ55JaGtU8Gym0MMf0p05XzJJrZE91BZ
 Ozag==
X-Gm-Message-State: AOJu0YwmXaxK56jqiq+v66bCdI+W9HFn2+yHfAfXGuuywi6MMHoFR3yW
 7vb9Fx2io0Nn8PvQmbfRb2yjNzOoD2JLcSp0M3mTTLc2mX6KSY4n
X-Google-Smtp-Source: AGHT+IFGCbPGduFnFtzaox+LJgW7QFy3GVcC1PFHSX7PgXjvmOyJ296PrDyZf+JDQS/psaZ84ryHVw==
X-Received: by 2002:a2e:8794:0:b0:2ee:8d81:5aa4 with SMTP id
 38308e7fff4ca-2ef16782aa3mr1463461fa.14.1721405137480; 
 Fri, 19 Jul 2024 09:05:37 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15ed:fd00:5268:a92:871a:85e8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a6efb6sm58253015e9.24.2024.07.19.09.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 09:05:36 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com,
	lijo.lazar@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: harden the HW access lockdep check
Date: Fri, 19 Jul 2024 18:05:35 +0200
Message-Id: <20240719160535.2650-1-christian.koenig@amd.com>
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

While Alex already fixed a bunch of them we still have tons of call
paths which are accessing the hw without holding the reset lock to
prevent concurrent GPU resets.

Start pointing those out so that we can eventually fix them. Only
point out the first misbehavior per driver load so that we won't
overflow the logs with them.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 30 +++++++---------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bcacf2e35eba..30d83ae3c14a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -567,31 +567,19 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
  */
 
 /* Check if hw access should be skipped because of hotplug or device error */
-bool amdgpu_device_skip_hw_access(struct amdgpu_device *adev)
+bool noinline amdgpu_device_skip_hw_access(struct amdgpu_device *adev)
 {
-	if (adev->no_hw_access)
-		return true;
-
-#ifdef CONFIG_LOCKDEP
 	/*
-	 * This is a bit complicated to understand, so worth a comment. What we assert
-	 * here is that the GPU reset is not running on another thread in parallel.
-	 *
-	 * For this we trylock the read side of the reset semaphore, if that succeeds
-	 * we know that the reset is not running in paralell.
+	 * HW access in process context requires that we hold the reset lock to
+	 * make sure that no concurrent reset is running in paralell.
 	 *
-	 * If the trylock fails we assert that we are either already holding the read
-	 * side of the lock or are the reset thread itself and hold the write side of
-	 * the lock.
+	 * Interrupt context obviously can't hold a mutex, but the reset
+	 * procedure is disabling interrupts as necessary.
 	 */
-	if (in_task()) {
-		if (down_read_trylock(&adev->reset_domain->sem))
-			up_read(&adev->reset_domain->sem);
-		else
-			lockdep_assert_held(&adev->reset_domain->sem);
-	}
-#endif
-	return false;
+	if (in_task())
+		lockdep_assert_held_once(&adev->reset_domain->sem);
+
+	return adev->no_hw_access;
 }
 
 /**
-- 
2.34.1

