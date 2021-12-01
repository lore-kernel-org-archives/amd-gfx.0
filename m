Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0C6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Dec 2021 05:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B0116E9CB;
	Thu,  2 Dec 2021 05:06:38 +0000 (UTC)
Received: from mta-p8.oit.umn.edu (mta-p8.oit.umn.edu [134.84.196.208])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FA2B6E8A8
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 15:13:20 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p8.oit.umn.edu (Postfix) with ESMTP id 4J42f76Kkmz9vjCT
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 15:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I7Je6mGjWlnl for <amd-gfx@lists.freedesktop.org>;
 Wed,  1 Dec 2021 09:13:19 -0600 (CST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 4J42f74ByZz9vjC7
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 09:13:19 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 4J42f74ByZz9vjC7
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 4J42f74ByZz9vjC7
Received: by mail-pg1-f197.google.com with SMTP id
 t1-20020a6564c1000000b002e7f31cf59fso12231215pgv.14
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Dec 2021 07:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h4LXZln8T4HCcWzcanaTdpJLL3mZ2EfocGb+bUhELaY=;
 b=gD54pJwHKo5GPwYSZC10YNFg45mxtJJimjm+RtSINIL55BTNvRdZVZ8dEpn+Ezenhj
 8UVNeopOWpW6w275TNAoSZoe5qgb6YM6clzu+KzVkxtWZce7JBbxir8KaO9NiN2d79z2
 jDYv+3bGgG+FjKJ20zwdA9GBO61o4Z/yKROeuFCqF5YWXe3K2024+bZqrLTNwyPRGMWc
 sdJpo0APo3ipGHUYST547Tgcb/9rH450dJov8i0D/n72+2x7qcRF3luoNlMGS6jLe6oy
 nDnZhpBP9UwaF5FiW9eFfR72bsu9EBwFgrImdGfHqNnRlp50ayx2H/wOv7qt7Zm4cdT2
 gZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h4LXZln8T4HCcWzcanaTdpJLL3mZ2EfocGb+bUhELaY=;
 b=GsqscvJV6KnNsy5XqtnqVMxJka0ZJpPsHsh3OPFNl+XURQGJmfGh27jKrHwKRdXppH
 LTiH/ASpkTukKBRmnexyYFvRzBzKqV5P10NdJx06zG4wGSY+4i3vp+qS4FxlYfk5ZVfB
 /GfkSdzzz+ELLwPZ0VzzOmAmfg8gqzfeC4G4RQWhwPrgVZmqanDN1jYqmZo4vWPk+xnW
 zKiFVK7td/HfusG5G2xwiOUC8eU0N7SCPBAP80vwtMtBXlzgccrxDjUO45FqLBiC3DQK
 2Q5iThDYQFRrKmjCn9tvBt1TPQvFxI/upIjLu7F7XvMSNOkdB5KISUbnsQZsjfrTki2E
 LghQ==
X-Gm-Message-State: AOAM532qb689T442BX6EUEHhxVIT85NnXdK5+gK2DBxDfnLUgjQB6Inz
 N+TiAm93M/xlRMFmZ5rFGILMogYvHRt4cdgz9AMHdDJK84VaOJlcnyVC5zfeqQp96zHUn94EDK8
 TV5SP5vavFepAcbvZ8sBkuCgo7AG2cQ==
X-Received: by 2002:a17:90b:2252:: with SMTP id
 hk18mr8258162pjb.218.1638371598657; 
 Wed, 01 Dec 2021 07:13:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzQ3lgZ5HmEc+yg40LHvZgBrCVXftuWXu3L1JO3qkgIlyIo5lNUuY4CI/ttBB11keXNxAGag==
X-Received: by 2002:a17:90b:2252:: with SMTP id
 hk18mr8258135pjb.218.1638371598394; 
 Wed, 01 Dec 2021 07:13:18 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.22])
 by smtp.gmail.com with ESMTPSA id mh1sm6496pjb.6.2021.12.01.07.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Dec 2021 07:13:17 -0800 (PST)
From: Zhou Qingyang <zhou1615@umn.edu>
To: zhou1615@umn.edu
Subject: [PATCH v5] drm/radeon/radeon_kms: Fix a NULL pointer dereference in
 radeon_driver_open_kms()
Date: Wed,  1 Dec 2021 23:13:10 +0800
Message-Id: <20211201151310.177671-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <e2685075-fbc5-6f36-907f-76b6f76a59ce@amd.com>
References: <e2685075-fbc5-6f36-907f-76b6f76a59ce@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Dec 2021 05:06:37 +0000
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kjlu@umn.edu, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In radeon_driver_open_kms(), radeon_vm_bo_add() is assigned to
vm->ib_bo_va and passes and used in radeon_vm_bo_set_addr(). In
radeon_vm_bo_set_addr(), there is a dereference of vm->ib_bo_va,
which could lead to a NULL pointer dereference on failure of
radeon_vm_bo_add().

Fix this bug by adding a check of vm->ib_bo_va.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_RADEON=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: cc9e67e3d700 ("drm/radeon: fix VM IB handling")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
Changes in v5:
  -  Use conditions to avoid unnecessary initialization

Changes in v4:
  -  Initialize the variables to silence warning

Changes in v3:
  -  Fix the bug that good case will also be freed
  -  Improve code style

Changes in v2:
  -  Improve the error handling into goto style

 drivers/gpu/drm/radeon/radeon_kms.c | 36 ++++++++++++++++-------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 482fb0ae6cb5..66aee48fd09d 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -648,6 +648,8 @@ void radeon_driver_lastclose_kms(struct drm_device *dev)
 int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 {
 	struct radeon_device *rdev = dev->dev_private;
+	struct radeon_fpriv *fpriv;
+	struct radeon_vm *vm;
 	int r;
 
 	file_priv->driver_priv = NULL;
@@ -660,8 +662,6 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 
 	/* new gpu have virtual address space support */
 	if (rdev->family >= CHIP_CAYMAN) {
-		struct radeon_fpriv *fpriv;
-		struct radeon_vm *vm;
 
 		fpriv = kzalloc(sizeof(*fpriv), GFP_KERNEL);
 		if (unlikely(!fpriv)) {
@@ -672,35 +672,39 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		if (rdev->accel_working) {
 			vm = &fpriv->vm;
 			r = radeon_vm_init(rdev, vm);
-			if (r) {
-				kfree(fpriv);
-				goto out_suspend;
-			}
+			if (r)
+				goto out_fpriv;
 
 			r = radeon_bo_reserve(rdev->ring_tmp_bo.bo, false);
-			if (r) {
-				radeon_vm_fini(rdev, vm);
-				kfree(fpriv);
-				goto out_suspend;
-			}
+			if (r)
+				goto out_vm_fini;
 
 			/* map the ib pool buffer read only into
 			 * virtual address space */
 			vm->ib_bo_va = radeon_vm_bo_add(rdev, vm,
 							rdev->ring_tmp_bo.bo);
+			if (!vm->ib_bo_va) {
+				r = -ENOMEM;
+				goto out_vm_fini;
+			}
+
 			r = radeon_vm_bo_set_addr(rdev, vm->ib_bo_va,
 						  RADEON_VA_IB_OFFSET,
 						  RADEON_VM_PAGE_READABLE |
 						  RADEON_VM_PAGE_SNOOPED);
-			if (r) {
-				radeon_vm_fini(rdev, vm);
-				kfree(fpriv);
-				goto out_suspend;
-			}
+			if (r)
+				goto out_vm_fini;
 		}
 		file_priv->driver_priv = fpriv;
 	}
 
+	if (!r)
+		goto out_suspend;
+
+out_vm_fini:
+	radeon_vm_fini(rdev, vm);
+out_fpriv:
+	kfree(fpriv);
 out_suspend:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
2.25.1

