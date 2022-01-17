Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A46C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jan 2022 09:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF69D10E57A;
	Mon, 17 Jan 2022 09:38:52 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB7410E651
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 09:38:52 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id c2so13419023wml.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jan 2022 01:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9eEmD4Y7A7lZAnWiyLUgcpz5iL8400Wg0l7kQ7weosc=;
 b=lsFf7zWSiM6f7nehhuqzqG/gjJhFghuN834P9Ibj8prOsUPzMfMD0HOFS5dsszqWY8
 vnkM8CMslKF/f2ReqXgmQpIBQhoFNG3Bh9gd1nVBLiVMFOzaE4HYIn9eh3OA+SuEK4AW
 A2J+ktKDiqbSRY9oewb/5MSjGOGCRfZfNtPLbfkJ/+o1FWGfl/quSj91igqUiMzcuxuc
 nfp/fYtUR2k535uVD1ZG6/UcwboAKxrKTNALWY7XKHJfdCKnXWsov+jL/xKG2geOK5Kt
 blAzAKVVJLnQv9XWWqA6PuddhyZ6EOOZ3IX6b8RF/v/ZG2oMJoqBan7VVNp5qicpQ288
 63OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9eEmD4Y7A7lZAnWiyLUgcpz5iL8400Wg0l7kQ7weosc=;
 b=P5mzjeCOaezjR8lRmLeyVHPEC8W+gffK9s5diofab65sygdGeUXcycDFwuG39cDy7P
 yrTpRvcY38tqHhXEVEIwkIr/7Wf3FhJ6C1Kd5NUdEm8yf4tkPIkm7wUcBRRn2AKshETD
 Z3oj7tWiIjyXFfWDiHjLG7EF6fRutRGkFr0tI6fvltvV8RDbzyLyr2Hhk10cbsBF899C
 GNkpOQeBPU5TiOQskVodBAGYldo+3Z9E/NqkHOhg+qF9Vmn8gYcGKp8NJscv+4KXrIKH
 cWvb7aPNrRJgUOe0YZ8lt2EY7vD6VSsMGdCgnL7UZauXMmkkhDrr4H/HoBZfXi5ahi5H
 h5wQ==
X-Gm-Message-State: AOAM531+aoG09Ba/5Lwv0vM7wgXByWnTXOTQB2BNja9/2QjP31p8PIRW
 7yDqoYVEqkZEC5WTWh+2ceg=
X-Google-Smtp-Source: ABdhPJxrJfpTdxzTgcCRb0QYPmYQJXrd9Bqw7hQc4vZjxaT/4foI/HLcRNenruj9CMoaoByOg/ugfQ==
X-Received: by 2002:adf:fbcd:: with SMTP id d13mr18691007wrs.170.1642412330607; 
 Mon, 17 Jan 2022 01:38:50 -0800 (PST)
Received: from abel.fritz.box (p57b0bff8.dip0.t-ipconnect.de. [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id e15sm1164141wrg.85.2022.01.17.01.38.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jan 2022 01:38:50 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: bp@alien8.de,
	jstancek@redhat.com,
	arthur.marsh@internode.on.net
Subject: [PATCH] drm/radeon: fix error handling in radeon_driver_open_kms
Date: Mon, 17 Jan 2022 10:38:48 +0100
Message-Id: <20220117093848.1884-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The return value was never initialized so the cleanup code executed when
it isn't even necessary.

Just add proper error handling.

Fixes: 2ad5d8fca195 ("drm/radeon/radeon_kms: Fix a NULL pointer dereference in radeon_driver_open_kms()")
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index e2488559cc9f..11ad210919c8 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -666,18 +666,18 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 		if (unlikely(!fpriv)) {
 			r = -ENOMEM;
-			goto out_suspend;
+			goto err_suspend;
 		}
 
 		if (rdev->accel_working) {
 			vm = &fpriv->vm;
 			r = radeon_vm_init(rdev, vm);
 			if (r)
-				goto out_fpriv;
+				goto err_fpriv;
 
 			r = radeon_bo_reserve(rdev->ring_tmp_bo.bo, false);
 			if (r)
-				goto out_vm_fini;
+				goto err_vm_fini;
 
 			/* map the ib pool buffer read only into
 			 * virtual address space */
@@ -685,7 +685,7 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 							rdev->ring_tmp_bo.bo);
 			if (!vm->ib_bo_va) {
 				r = -ENOMEM;
-				goto out_vm_fini;
+				goto err_vm_fini;
 			}
 
 			r = radeon_vm_bo_set_addr(rdev, vm->ib_bo_va,
@@ -693,19 +693,21 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 						  RADEON_VM_PAGE_READABLE |
 						  RADEON_VM_PAGE_SNOOPED);
 			if (r)
-				goto out_vm_fini;
+				goto err_vm_fini;
 		}
 		file_priv->driver_priv = fpriv;
 	}
 
-	if (!r)
-		goto out_suspend;
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+	return 0;
 
-out_vm_fini:
+err_vm_fini:
 	radeon_vm_fini(rdev, vm);
-out_fpriv:
+err_fpriv:
 	kfree(fpriv);
-out_suspend:
+
+err_suspend:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
 	return r;
-- 
2.25.1

