Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B936C5AE49
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948C810E6C3;
	Mon, 10 Aug 2026 06:42:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LJcSjUok";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78A9E10E05B
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 05:13:45 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso6497105ad.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 22:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786252425; x=1786857225; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jxy36nydTdeDBb8ceeDdse8qoQ8B4JIq+QDkrcZSSIw=;
 b=LJcSjUokiCclrB5Xspc5rh5W9gAweGlVDZeRieIPm5F6UDSLvuuiiCtFOMZ16qKzP/
 5ttYtrgcXIIQTg3+tH9EqRM67n2sW82bhcDK5qyvUC4DfaW2d8xBz8eOUIVWbb9oGLKc
 EwSotZQUo9EwkedMCT8OTYcYRsjOpTLoX3LT6pVLyGczHe5D5p41tQJwZoikpsVPOxrg
 PQOzRBQ+bDGeI4ZVxJWSnSEdwawCZzHm2jjt+0KGP+E/qEi20Fqx6ZV65NMnpWrdQWOt
 4v+7/uidBfhDgEMyu1GEuqCmwZAeoqaCDG4IS5l+ByRTk3lKtIKOx95udyH+LRgK93jz
 4h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786252425; x=1786857225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jxy36nydTdeDBb8ceeDdse8qoQ8B4JIq+QDkrcZSSIw=;
 b=f3ZbBS+RvL4YhuVtquQhGuaz2+jUxcMF4eub551n8f6GVVxCS6qJCZDbh7UUmQuHjK
 8UOj25zxSwtSH6TA7wIxVyaR2/Yb5ZlFnpCkihcNtD4wtWDkrXhSrjJetvgRqhkCVzdU
 FVL/r+Fgxe+NMB5Mj6cHAGb7JLxeuxHA2SEx/OFWaffINWrhgJ58GomeUHjOhJ3c3MGj
 +z0zIJm0QKKeZ2iuJWs6iDmn3vXNNJyDk4vvDb/eSKDFxwfC5SMsxhqcdefAivtmWXgk
 t/zNqKVBS+4vgxVRAZR9nf9d/gPGH02gofx2ozRfkIzzT2EP8Zi2DxXA79Jor8FSK/vZ
 bnhw==
X-Gm-Message-State: AOJu0YyWdozOxbQ8/E17LohkBC1CYNt/+39jL1hDVnBdvbE+mdcUgi6k
 O7NT/nV4AUzm7ivbBIxaSgPBZQkSh9qJskWHCNSnVzCa21w/dAy54aV9
X-Gm-Gg: AR+sD13wU5b0tX84waxw5UC13dV7qsbFW9QyPSeUJKT44mkfBw4TRjeh1BvpSFXHYm3
 s41KY2q7JdHsUfRfRzNTuVMfD3lxdq78mwf/DyL6M8TVJT6i8tyT2/2FCNNj3d8w4gAFzpC9OF5
 +GAHeGlu/OsUs9pnYeG4iWMmsdz3sMuwxsyOZ9UnzMzERzzVS/JnqvRLWGVEb+HA//b9EAbwOOQ
 ML1BmVzO7/RaBxPTJOJCrXBIXuFXZMEqN4I2BcPSaoqFUl/uVSC0lVILuuUXK3tjbBUrApqxvb1
 LZlJPzueZo8VUVtjsG4lRgaPjzp45T/UVNfdl5JL2t2BHx2gTt9plkRVg2tCQtXc2fJeCTs+vXB
 pNgzJYUx6UREtb+xAX+5wt2rAyF/8lC6tLfznI0kyXrCHCk7c71uCrHF4Rtqugb16zvVOtGXcNh
 NPleyhLtHuZwo4hC3nyCqwJItwuZXfadFt4sHcidRPNzvv/gN2kVq9NyJasEx3dDkIutdZ2OA3i
 JKbIRMSxlDf
X-Received: by 2002:a05:6a21:69a:b0:3c8:e313:8d42 with SMTP id
 adf61e73a8af0-3cbce96f6dcmr12821608637.31.1786252424949; 
 Sat, 08 Aug 2026 22:13:44 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm27095702eec.9.2026.08.08.22.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 22:13:44 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v3 6/6] drm/amdgpu/ras: Cancel delayed work before ACA
 teardown in amdgpu_ras_fini
Date: Sun,  9 Aug 2026 05:12:00 +0000
Message-ID: <20260809051200.3276-7-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
References: <20260809051200.3276-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

In amdgpu_ras_fini(), cancel_delayed_work_sync() is currently called
after ACA subsystems and locks are destroyed. If the delayed work
(ras_counte_delay_work) runs concurrently during teardown, it can
evaluate aca_handle_is_valid() right before remove_aca_handle()
frees the handle and destroys its mutex, resulting in a use-after-free
and locking violation.

Move cancel_delayed_work_sync() to the beginning of amdgpu_ras_fini()
to ensure all pending work is flushed and stopped before resource
deallocation starts.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 764cd4950408..118716ad0437 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -4751,6 +4751,7 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	if (!adev->ras_enabled || !con)
 		return 0;
 
+	cancel_delayed_work_sync(&con->ras_counte_delay_work);
 	amdgpu_ras_critical_region_fini(adev);
 	mutex_destroy(&con->critical_region_lock);
 
@@ -4785,8 +4786,6 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
 	if (AMDGPU_RAS_GET_FEATURES(con->features))
 		amdgpu_ras_disable_all_features(adev, 0);
 
-	cancel_delayed_work_sync(&con->ras_counte_delay_work);
-
 	amdgpu_ras_set_context(adev, NULL);
 	kfree(con);
 
-- 
2.54.0

