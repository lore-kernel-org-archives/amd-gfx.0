Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F85C433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 11:23:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1414112122;
	Fri,  6 May 2022 11:23:20 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B887112120
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 11:23:17 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id c12so861078edv.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 May 2022 04:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=LO1Tr9EEMi+cM0uVuvATx9dFt0sNJGMf9O4+1CkkUTw=;
 b=ZQxRKWWjfq6udVdP+kET7o0Crofb0s4ETNetOtubcWGkaWEvUBe1wwWXLgImIH/os8
 Bu56Pjfe6Ne1Du3AtWyvSSZ4//s3Hh27F81EqKGjv6BlJpRO5SBb1OL6AdoXgAsY17lv
 gPbjISY2+yif0rAZh3iby9XJEHBVFmyblu+jbypIEmNXIotJ409wmngvZQNdbuJXTAA7
 a0Z5FAmaxZc0u97iqbC9H+YHKdFBnDaT4+T0cpHFIxIL33yyYzsB+1u7gzL2Sslk2NyH
 JchPylZct6KMtnsoIqsdn6DTGKuXZazrUwvM2ocnm0neZfQW1wKwic3M56I8ceC7TNdR
 33Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LO1Tr9EEMi+cM0uVuvATx9dFt0sNJGMf9O4+1CkkUTw=;
 b=jqhUY0P0OwWF+t7lP33eRoS81jDp0+O+9Lu70wnejGccr/UyKTkphhG2YWn8lBR3+H
 1i0x2zZ0HuPOYtrXpA9PxIWtUhvG3Cu4rWpAAOwCMYGWktCykHwOYZJGDSozb4kf1+OB
 5CcTYXw7V161RC4oc8ORfpShgdvDZOcWSSsPK3DRQ3JEiSqbfqwoavS4lWK0687/VkOT
 DcoiCkkPe9sp+SoXemmZRmLzKiTcpofl4Txpps4X5o472BVyX7SoZHAqUzskqAfTtYV8
 ngte0H3qTjKFOT70uAyhJrT2l9/6jYiLlVbqGIOQrtg+QIJu5kxSjZFKQP3L1lrhX72u
 Si8g==
X-Gm-Message-State: AOAM532q+BbSW0WBN3p1ooWQqg4vMnzFBP+blYzFUiJKsPEeSPq0HzTb
 GC7nfiMbtj8BvZ+NnUOqxgepaIPU/Ck=
X-Google-Smtp-Source: ABdhPJwAxk2lc0mX2j2KPSk2DVADTvDnfeiMO1T8X4Mx0Q2J7fLhcLFXe1xDr0g0q9PhVZFbcr72Ow==
X-Received: by 2002:a05:6402:2790:b0:427:d09b:df82 with SMTP id
 b16-20020a056402279000b00427d09bdf82mr2929125ede.151.1651836196086; 
 Fri, 06 May 2022 04:23:16 -0700 (PDT)
Received: from baker.fritz.box (p57b0b3fd.dip0.t-ipconnect.de.
 [87.176.179.253]) by smtp.gmail.com with ESMTPSA id
 a24-20020a170906369800b006f3ef214e37sm1816684ejc.157.2022.05.06.04.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 04:23:15 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Marek.Olsak@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: bump minor version number
Date: Fri,  6 May 2022 13:23:12 +0200
Message-Id: <20220506112312.347519-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506112312.347519-1-christian.koenig@amd.com>
References: <20220506112312.347519-1-christian.koenig@amd.com>
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

Increase the minor version number to indicate that the new flags are
avaiable.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16871baee784..3dbf406b4194 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -99,10 +99,11 @@
  * - 3.43.0 - Add device hot plug/unplug support
  * - 3.44.0 - DCN3 supports DCC independent block settings: !64B && 128B, 64B && 128B
  * - 3.45.0 - Add context ioctl stable pstate interface
- * * 3.46.0 - To enable hot plug amdgpu tests in libdrm
+ * - 3.46.0 - To enable hot plug amdgpu tests in libdrm
+ * * 3.47.0 - Add AMDGPU_GEM_CREATE_DISCARDABLE and AMDGPU_VM_NOALLOC flags
  */
 #define KMS_DRIVER_MAJOR	3
-#define KMS_DRIVER_MINOR	46
+#define KMS_DRIVER_MINOR	47
 #define KMS_DRIVER_PATCHLEVEL	0
 
 int amdgpu_vram_limit;
-- 
2.25.1

