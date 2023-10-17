Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA6DCDB474
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 12:10:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0F810E2D0;
	Tue, 17 Oct 2023 12:10:23 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8754B10E2D0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 12:10:21 +0000 (UTC)
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c51388ccebso38681971fa.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Oct 2023 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697544619; x=1698149419; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fc0SvsJZRpSmasPqMScgCf4LQFUmWUzpLvd7e2d5LMI=;
 b=UmiWufmlDK8SlrzI2E6kVLu+nRU3OVXqnoMRwu2r+TgQCW4uEoRflOmiHp3gOdd1Fk
 qGwqhkyRiO0ezBuaeLQM8TXYsWL+ATbF2K+Ii+Eph4T6F7XWHZtoN364G3cjsFJhGm5V
 NQjLNAhKpqVIiWh+HLU9eabkO9gMj+oklx1zJibeJPEOZrx88ZNOtlsU77MGuvo+ja4A
 wnQgemavSW2SOfiHHRlMfSRPp78oMq0duZsbj2EQH4S59Er33XKew9Sz1NIr0jYSBXYZ
 eYewdJ5gZmtMtY5nTWXMu3fd+VQIGfhSD+ovqqduXv+XySneyvnrk8VuT2oLXQ7fYIEf
 LR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697544619; x=1698149419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fc0SvsJZRpSmasPqMScgCf4LQFUmWUzpLvd7e2d5LMI=;
 b=Qh9n/45JT3JrvbdrMirAXNgDyl8nXe4Q0OQZFgz6qRWz1E/gHCvNw1KJYciEsCXGFs
 JsQWrSNK63ogfoDtGEPZWKx2Nsg7TniJJhUWt6XJ3FBI2j2Xbh0hZoxvTOE+sMG4pQEc
 WHeBIrfJ+EYuJDCjtVytXzhUhKXwq6Ccnz4abAUvxLI32G4wz+0XT0aNb5qZVLDagIhZ
 GDwk0O50d5siz64WjKng1zPkNdMbHZgRzexM7RdNZc39jxCfnwh3d8BLtT0OxeB/t0Y+
 dzIkhiLDI37l7g3paa1rasZa89tZ/2wojelohRC995p+MbDM216mukVLm0ZPDyGY/DED
 BWMA==
X-Gm-Message-State: AOJu0Yx/C1sdt4+RHNihF26M2SYVKNL5DWhq3Op2QXtzr3XMm+S3/s9E
 aPmMCC1bG+xHoNXFyPQmO+l2xS9/qD7zVA==
X-Google-Smtp-Source: AGHT+IF6TOwNOu3hRhxBSV9jNImK9HUypYPB8B0uP8nAqrW5KhJXCUDvn7fao01eCMrSikIOdYKu3A==
X-Received: by 2002:a2e:b88b:0:b0:2c5:6d8:8dfc with SMTP id
 r11-20020a2eb88b000000b002c506d88dfcmr1610766ljp.13.1697544619284; 
 Tue, 17 Oct 2023 05:10:19 -0700 (PDT)
Received: from EliteBook.amd.com (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 fc10-20020a05600c524a00b0040535648639sm1749553wmb.36.2023.10.17.05.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 05:10:18 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: ignore duplicate BOs again
Date: Tue, 17 Oct 2023 14:10:15 +0200
Message-Id: <20231017121015.1336786-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Looks like RADV is actually hitting this.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: ca6c1e210aa7 ("drm/amdgpu: use the new drm_exec object for CS v3")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index efdb1c48f431..d93a8961274c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -65,7 +65,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 	}
 
 	amdgpu_sync_create(&p->sync);
-	drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+	drm_exec_init(&p->exec, DRM_EXEC_INTERRUPTIBLE_WAIT |
+		      DRM_EXEC_IGNORE_DUPLICATES);
 	return 0;
 }
 
-- 
2.34.1

