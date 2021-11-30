Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D158C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 16:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B426E0F6;
	Tue, 30 Nov 2021 16:13:27 +0000 (UTC)
Received: from mta-p6.oit.umn.edu (mta-p6.oit.umn.edu [134.84.196.206])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06DD389E2A
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 15:58:04 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4J3RhC4wB9z9w6Rp
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 15:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YnksitLlnWoC for <amd-gfx@lists.freedesktop.org>;
 Tue, 30 Nov 2021 09:58:03 -0600 (CST)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4J3RhC2d7nz9w6Rk
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 09:58:03 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 4J3RhC2d7nz9w6Rk
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 4J3RhC2d7nz9w6Rk
Received: by mail-pj1-f71.google.com with SMTP id
 mv1-20020a17090b198100b001a67d5901d2so11721476pjb.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bTXkxPkhvwkgKe3CfQ7oKNFqLLxsibJM72YviuHICJY=;
 b=JXLhE+gLz8807ShPZSZBtudJocl+w6stUALlj11N7rM24NN8HXfOXGqMUBWF6f9IYK
 4tmgYEOcRw/QvKTRyOwZfpfmnqzsmA/hrkVGyp6sbzvGR8IJz7Eae2Db2itgWd2hJh6k
 FT1Vps8hTXW4OuK7IkVnGNU0EFN25oMFBeZjJitk2c1IzzpIMqSUG5KjCLIMngKJB51T
 HcFCQRDcSgoh8/UcsiseRNjQjbruj0ErYBwux3J8lLI8E7l6flcIPzCSVOLUG4dkdZht
 E9+2I7o3/hGSbZgptPnE/cbwb19FsDWZBKItWc6DAfFm7RLgXAx61vNw3OOnvPFJ+uBV
 iYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bTXkxPkhvwkgKe3CfQ7oKNFqLLxsibJM72YviuHICJY=;
 b=fCawDJ9NTzWnH+fnlFeTxcbtWY3lFTPn19PdrKxglg7QBdBMHsMcVqyw6Y54gz2vjo
 pku9Hx7205ngxI7IU7Dx7Jf3xKMCrAJf/sPACN2PUS6sa7x96K4kq7j/znvk2TdLvnDS
 V131t9rgWcV4KTkInUngUsKaEUhbPwxEAQRxY9finuPpshgXeXbqYPURHNrYTnzeyvev
 izsEBkors+juOugnuToNyIOaXqs8KogtCwh38ltF0xAd5IkUOyNU+KuxAHqc9ljkOcZF
 b+I7JYGQHjKk1twiqGB2kFICrslbKvtRn8xJTwx8I7H2wypyR2Qrpu9v0D/VU+0pzivN
 5+pQ==
X-Gm-Message-State: AOAM531m6VdOhzKPkZ8RhiFdj57/i4f2RWjE7ApdVg2i2vQEcHet7RKb
 1su+8b2GN1sOjioQKUmSBZKemhAJ+o8LOs0AY6MbaO1bZqLn6MuvoXquI9r3iaLOUySpQ9PryC/
 V25XrD/h59+q51tCHZkIr5xVBubbuEg==
X-Received: by 2002:a63:155d:: with SMTP id 29mr21860pgv.302.1638287882665;
 Tue, 30 Nov 2021 07:58:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIaxwNEDzH7cmq7l7LiRaYXMObjxXyqF8evR41ZnOQZpK9G2rDCI1/FqCk8Jv+9cm2uvYXJw==
X-Received: by 2002:a63:155d:: with SMTP id 29mr21828pgv.302.1638287882411;
 Tue, 30 Nov 2021 07:58:02 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
 by smtp.gmail.com with ESMTPSA id h13sm15230838pgg.16.2021.11.30.07.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Nov 2021 07:58:02 -0800 (PST)
From: Zhou Qingyang <zhou1615@umn.edu>
To: zhou1615@umn.edu
Subject: [PATCH v3] drm/radeon/radeon_kms: Fix a NULL pointer dereference in
 radeon_driver_open_kms()
Date: Tue, 30 Nov 2021 23:57:19 +0800
Message-Id: <20211130155720.178214-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f776cb6f-d599-a543-9177-dac7d08cf7d4@amd.com>
References: <f776cb6f-d599-a543-9177-dac7d08cf7d4@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Nov 2021 16:13:26 +0000
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
Changes in v3:
  -  Fix the bug that good case will also be freed
  -  Improve code style

Changes in v2:
  -  Improve the error handling into goto style

 drivers/gpu/drm/radeon/radeon_kms.c | 35 ++++++++++++++++-------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 482fb0ae6cb5..439f4d1fdd65 100644
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
@@ -672,35 +672,38 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
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
 
+out_vm_fini:
+	if (r)
+		radeon_vm_fini(rdev, vm);
+out_fpriv:
+	if (r)
+		kfree(fpriv);
 out_suspend:
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
-- 
2.25.1

