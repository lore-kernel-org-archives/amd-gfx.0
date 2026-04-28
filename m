Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72057FF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 10:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F7C10EF78;
	Wed, 29 Apr 2026 10:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="z872g9Zm";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 281FC10ECF8
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 14:47:17 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so10236486f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777387635; x=1777992435;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ctIsKyjLGAxorg+U+rmNLCdOJMyrX/ml0WoUktvYWis=;
 b=z872g9Zmd0iwVJxrJUmAvMdLRsNPyv3kwDa06ZmW+NgTaLAoQ/Ae+VmOOVhTCulaHZ
 3D3u9l4Eqckq3qvbx5Jldy8UjiGoLUnzQn8808PO2SrN6eO/+/wHMljzvAwKUaGCr2dB
 lVJCC6R2yn49vx3KA6Y9SGyghpxMk9kRywkuMj5jpUBiZxOc31+L51f4JT3ZrWQ1zrpk
 2vAJRsbefNumXCbpJN97WyDwNxTBTZYiC7wQihtVi1n+lwAKfeWje5WzlUxv67L9nGat
 Y+lpechD02o23xr8hXJtb/JPeR2u2NY4kHj7htHUF5nrJ89vp38IRU4hG32i4gnfCF2P
 fwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777387635; x=1777992435;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ctIsKyjLGAxorg+U+rmNLCdOJMyrX/ml0WoUktvYWis=;
 b=Nmfk9hkipYjvaGyb7gHFn3immEMWxGJ+cj/4wTNJBL7nGFHGeTPFiRrwcJLFQ3wVGJ
 HCfjHH8ZYBhX+VRfqLLMW6ODsZ56ORBMpfFBCQKHoZFL6Smswb6DVL43lFnFl6dIGOkP
 1k2xXfRNOzbczGKUtAiYTDqN+hcc4NuAur05tfU4S5Fnj4vFuXMB69C05VsAiruPpYcQ
 3Nvvcod/QUUc5/zd9qbgwxCD4KHDbuXY2IJAexGIkIP4a9OaXEiqSUSFYI3M0UUq4Ejh
 3eEWbRlF5Iw+c9kCB9uCkZFZ5QN1BE63CdT2uZSQn5MfYY3mrrFisj9rawXBNuWB2dSs
 PfCw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fhWD2nZLQq9YM8fygUwHd8E8W6Tcc0GUo9yA/w3njcXNkfm3YCkRtv4LAupD9NAfth/SHxjCj@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGJ/bOSD++YnewyH1E/ad03Je/obtdl86BobEKpDlvOtHMb1Nh
 DR7wF2+O2yb806toGHjdJ5zfCEonLLSyZX8jwocAdrint8Zb5q96UyW3RbEmAQjM7d8=
X-Gm-Gg: AeBDietZVpa8RQbmReXjMBXl/t1OGyiH80Scpz4q+TdGFrOJ7F+ZsWklbbhtBHhHMbJ
 yhYfJiT2tm65mS+YDwAVyp/yv3OXsZ0vdJCyqEraZ6AvFad21V4Ec+mP+GrGQVMq9Np+rDUyzgV
 GYeBDktHJmV+SkTq5mEYIuR09oUTF5/P3L5n6rIeNtEunNnE0DQ/0Cz6u8SXsJQcK+YACRTPlx6
 0YPlkIOriWvpj5qzliFqQnOMmak9YtU82M+dJWK6xjsffcdyXh7POQt/ckI2YfU5U+Ef0hiTEz9
 iFf4VwRMPylQ7JGqBsfHSFrqcGtjVCEj0QGW+m6Cmmn+sTsVwhkSQB6aNPOfZgU089zJKKUeFKs
 3Uk7C46q0UATOWbLl+4JMvIIJ/Q9G7A+isc7hbHMxq4Mqo8jy/cJOt9byPBehh5Fns2JNnMRTv5
 cKm3l2xZif55LHbM1sH6YSEWBedobtbbz0XQDLmVfXBRJEUZc/PzxFJdIn56xRabmmtkWyowO7s
 5kDbesTzCSGN4HYeRB+8qJBrA==
X-Received: by 2002:a05:6000:3107:b0:43b:5b25:67f8 with SMTP id
 ffacd0b85a97d-44648963af5mr6294818f8f.20.1777387635558; 
 Tue, 28 Apr 2026 07:47:15 -0700 (PDT)
Received: from localhost
 (p200300f65f114e083adbfb3674088b9a.dip0.t-ipconnect.de.
 [2003:f6:5f11:4e08:3adb:fb36:7408:8b9a])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4463cb59e65sm7467306f8f.1.2026.04.28.07.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:47:14 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Kees Cook <kees@kernel.org>,
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Don't use UTS_RELEASE directly
Date: Tue, 28 Apr 2026 16:47:03 +0200
Message-ID: <20260428144704.1114562-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=T/ApXNSXXSl6FROM6HS9+qFlZCnlOYwqQBBavKeuaVg=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp8MhozzAn6fh0oyFbng3DD+O55AKxKYvMEvAX0
 fNJRcIZd52JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafDIaAAKCRCPgPtYfRL+
 TsF0B/9wmHtE3j+P3DMorqCIPp2H5O0klH3BBl5IqPL608ZWjPOoYQx4q+H15H36JxjFRz1m02n
 q6j03BUVSvrDEqZQy7oAF+hub7dL/giJv3xM3k+sfnc5RKQWFwMpvUc+gpAwapy3wXQxneyEdE1
 HDWEkU9qD1EfDDWGOPAPjNrYFlqEsdfBOBjfLFNkMOQZfqYf6iMFrIbrjDtrY2DwK9S1YL5Wpue
 Xkz81bhbjI7ibXVqC64R66M+L/50hpY3m5Uiicnrnn10UpFO8E5t97FC/H8zjlsZYdSyM2O927h
 DLyI72a2bghslevEdLu6Hq3DrHt4BZuqE/ax0kebn6r66Poz
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:25:59 +0000
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

UTS_RELEASE evaluates to a static string and changes quite easily (e.g.
uncommitted changes in the source tree or new commits). So when checking
if a patch introduces changes to the resulting binary each usage of
UTS_RELEASE is source of annoyance.

Instead of using UTS_RELEASE directly use init_utsname()->release which
evaluates to the same string but with that a change of UTS_RELEASE
doesn't affect amdgpu_dev_coredump.o.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index d386bc775d03..20ae2bd4617a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -22,8 +22,8 @@
  *
  */
 
-#include <generated/utsrelease.h>
 #include <linux/devcoredump.h>
+#include <linux/utsname.h>
 #include "amdgpu_dev_coredump.h"
 #include "atom.h"
 
@@ -236,7 +236,7 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 
 	drm_printf(&p, "**** AMDGPU Device Coredump ****\n");
 	drm_printf(&p, "version: " AMDGPU_COREDUMP_VERSION "\n");
-	drm_printf(&p, "kernel: " UTS_RELEASE "\n");
+	drm_printf(&p, "kernel: %s\n", init_utsname()->release);
 	drm_printf(&p, "module: " KBUILD_MODNAME "\n");
 	drm_printf(&p, "time: %ptSp\n", &coredump->reset_time);
 

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

