Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7FEC6FA8E
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Sep 2022 12:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1031610E6B0;
	Tue, 20 Sep 2022 12:55:51 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8FF10E6B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 12:55:46 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id e16so4133524wrx.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Sep 2022 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=umO3QimaAupCPzcO0aBXwYlRJ9kArardKD4Ns6OFTcs=;
 b=OAJVVFcdTHlBtlD8gfGEfkb1PxMAbzab9n09ggDc9aQOXi6G65FZYxypqKQj1RfuOg
 OgG9CqySLc+SlZ9TLqgk7hm5AG4ATyEXYtbW3l43aRBPlJgCL0m0s7b/2mWhDjo+jxpg
 OeJid+ivIWIEawKu4y8wOtbWzl3xOAqC+eWXc0e6qnhGy3PVgOXqPZ3KqlwVQ+qlNzos
 2VEXZrYDM60D/6F7QkXb9rOnI6A87IDCKRVtgf73LhTA6tBdmkHFsyB/nJF1veqV9BlI
 6ehsh0P86KgydiCpnBfvXEct2Rv+urmLeNR4UJdY6flDzG8u0F3fR7aPx7ag/0hG9YCq
 CIxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=umO3QimaAupCPzcO0aBXwYlRJ9kArardKD4Ns6OFTcs=;
 b=jENP9wmbfDc2Ft0wimg0RhhYZ6HDoVLmcaNnM7nVdtK8SiapzFCh3wK3fQ1/4i9cGX
 K7KPBQBzJwVM0v3CDdsq/8/MzQNKL2WR0qmrAWe3Bs32q64RMlKftJVWJ7Otbaslxxq6
 A/ANlc54SHiKNi/rRdZUGd/5kapzxXmyIwmkeRUNEoaKDYn2I58P4uZxVMq9MF6hCC6K
 vJja9KFQ5+8eLQi4377BJLAmtk4q1l8ZUjFcDGkLY+CBT+ljkKCouFBSgQiiF9IidBVB
 FS+kx7mJRYfngk1YzdD7qOqFHnG2VHWl2j54TtWo6xkwejtPqVyfTgkQUQL2AwO4Qa/q
 dt6Q==
X-Gm-Message-State: ACrzQf2f01iG1y+9xxThVGBK/LS6ovZ76ri6zH7qTiQLFb3PXUOUxMNm
 iwEKVlwG0pu8kbQMxGqep6YkXqnFDOk=
X-Google-Smtp-Source: AMsMyM4P8+NuZ9OWaanRPFSGnOGiN+jezzP0cHgneUT/WJmFhHxP3qR/1ycEEKRbDIQEFjKXcURmYg==
X-Received: by 2002:a5d:58da:0:b0:22a:c3cb:e3cb with SMTP id
 o26-20020a5d58da000000b0022ac3cbe3cbmr14018466wrf.34.1663678545221; 
 Tue, 20 Sep 2022 05:55:45 -0700 (PDT)
Received: from able.fritz.box (p4fc20ebf.dip0.t-ipconnect.de. [79.194.14.191])
 by smtp.gmail.com with ESMTPSA id
 k5-20020adfe8c5000000b00226f39d1a3esm1578703wrn.73.2022.09.20.05.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Sep 2022 05:55:44 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: bump minor for gang submit
Date: Tue, 20 Sep 2022 14:55:43 +0200
Message-Id: <20220920125543.3965-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since that has now landed bump the minor to let userspace know about it.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 81b22c1bd8df..16f6a313335e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -102,9 +102,10 @@
  * - 3.46.0 - To enable hot plug amdgpu tests in libdrm
  * - 3.47.0 - Add AMDGPU_GEM_CREATE_DISCARDABLE and AMDGPU_VM_NOALLOC flags
  * - 3.48.0 - Add IP discovery version info to HW INFO
+ *   3.49.0 - Add gang submit into CS IOCTL
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	48
+#define KMS_DRIVER_MINOR	49
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.25.1

