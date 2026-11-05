Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8146606A31B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yRwRYxBp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A2B3112484;
	Thu,  5 Nov 2026 13:46:05 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0077E11240E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 13:16:11 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2e96502e447so15652095ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 05:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793884571; x=1794489371; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w+HDLvKsrc2Sqexk3V8n4iZX3w0H0J6c4qfjNhM5pQw=;
 b=yRwRYxBpS6OPXPtBQHi8ukjHbKdqZPwB9brXyZVXXJRc4zcX+kF658rolFLagmrWc1
 IUKtCIMLH/uUQuKlb4IN6kztUz0tgJCrZj/VMzK6MDvn7C+r3OrOnFvrrJd+XX5M6oxr
 8qSgezzxWh2szV4gIDBPCExLmrhL/WGfOSxM+x180jT9H6jkuY12Lo83FDttGnj1Q7q6
 JLx8cvenCgQOdVP7kZVXzWIN4tGVOYQZhQxCrHvUyMSI7POFlslWXPTGLe6PFjirtA+M
 Br8k4GJEtiGlQSww5tr5w1ohNajOp18FWABiX25wA+6KF4HZCkwE/RBa3/oG5sdxfBHw
 DrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793884571; x=1794489371;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w+HDLvKsrc2Sqexk3V8n4iZX3w0H0J6c4qfjNhM5pQw=;
 b=Ann8HVeZUTdgGGJXgroI0ibJWTaETGGQ99tJNt38rvABb6COidSJsv/at8Z1F7DMhL
 9TK5crj/wjNItoeHkh2omE552/bfRI8ABOb36uyXEBgdXhl3wWpB+vVeeMJ0+VBuHFmE
 KAm5aPY1lPlP014jHim+Kh07aIsEv6qZ2GKsqOh0IngVFeAHqZ2KS7RqIAhNuBfFKQGS
 24OohxPbkNsWs7ziOuJ78SJx5CY5bmmg2bAx1odAVj/+UKQW1sAe45ti8BvgkyHQNLhf
 DD+S2ul8q7WBv12d8whhhvl7obKSEmsFk0+kjV+FTqaSd6F66Uta3/Zx23VLNVgYh4F0
 xKUw==
X-Gm-Message-State: APuU4Z8ax7s8K+w6MqLhlMeoXriMv+N0qT0WCq1UtahkwIBvz5gocBAr
 c5oQo18DmOnRxfPD8eynGgTTLR/IChqPdcLOEBCzU7O3DL3iIqA3z53O
X-Gm-Gg: AYBFou2cO8ZtCp8niPd3yB/BlWrH+aVLhn9aR0/Nz/M7HgPLwrzTv9+y92hOf11ZgTM
 i9/IcjB3Mo+x4noMLXb6RIKavT6jRIwyfJqy0E0SPRmFfYPFzVQri7c6XV56Dis+J+K163i2Ckh
 o9o2nkysojGYWwIG+zGIopV5Eqh8VOdwIEzwepDws5podF2LhIJuNk2tB/3LeQr1OtmibHzrWKT
 oW28LbugJQWeg/vCoTokFIdKK0j7X2w0xTbEF3IKpTAjWp9tQ0Rq3/IFNtoJyWGwP7ygLDSYM66
 p1UkNFDQIRXtt2T+BRb/we/3Z53PTMe+JHVaPuBlxSHH90ivq6fERZC0PwyntPpkBI+7U1r3JBV
 S/3Vh0a9nm6WY3otDL327krIpN1zvtj3RDkp52Y+ekbed1Rp/m/u5BbJjR4MpOLIU9svxzlTDLN
 d3xSy+R7vXuqae746Pa+ywyDbTeabmu+Thg5EWlIWbq1f8ND9QGUqApEaVyqXIqVV/VfbvGfy/u
 VHX5Y4MP/mkLxS0t+IxhO7fNokvTFk2xBTDUNZTJks9+xFGWo6v4iE3I+6c+V3ydWHehLL90yz5
 UapDnCdAlo/IgakatHVdIaTZt+sZogNwPA==
X-Received: by 2002:a17:903:244c:b0:2e2:cc25:b232 with SMTP id
 d9443c01a7336-2eb364f3256mr182447845ad.42.1793884571426; 
 Thu, 05 Nov 2026 05:16:11 -0800 (PST)
Received: from pop-os.lan ([2409:4090:1015:ce03:77a8:d3bd:bd43:9560])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed08fe3238sm17266485ad.17.2026.11.05.05.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 05:16:11 -0800 (PST)
From: saad <primecoder8@gmail.com>
Date: Thu, 05 Nov 2026 18:45:56 +0530
Subject: [PATCH] drm/amdgpu: use drm_gem_ttm_dumb_map_offset() for
 dumb_map_offset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-amdgpu-dumb-map-offset-v1-1-7299d94ede11@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIuB7GoC/x3MQQ5AMBBA0avIrE2iqIiriEXpTM2iNC0iEXfXW
 L7F/w8kikIJhuKBSJck2bcMVRawrGZzhGKzoa7qTqlKo/HWhRPt6Wf0JuDOnOjAjk2rqLcNzxp
 yHCKx3P94nN73A5BMTrBoAAAA
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, saad <primecoder8@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793884564; l=3075;
 i=primecoder8@gmail.com; s=20261105; h=from:subject:message-id;
 bh=wZvOA5y+L/diQOxcxDKyx4BTPQFg9Be4nZzKofFPvDA=;
 b=g1Fzekx0b+PXo/Alppv0Oy9v2TdYSCpS1xXhAxXlSwX7LSwpu8FA8n1iLO8UQl6/oLhv6LP6K
 vEsWoY89eFrC2KHGl+gRB8I7XUrosjdVCx9t3J56cjmbR0E4+R6NctO
X-Developer-Key: i=primecoder8@gmail.com; a=ed25519;
 pk=vJlTVYISGHXXppWzVCeFm0dcME82FTjmVlWBQkyLiKg=
X-Mailman-Approved-At: Thu, 05 Nov 2026 13:45:29 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As part of the DRM TODO item "Remove custom dumb_map_offset
implementations", switch amdgpu's &drm_driver.dumb_map_offset callback
from the driver-specific amdgpu_mode_dumb_mmap() to the generic TTM
helper drm_gem_ttm_dumb_map_offset(), for both amdgpu_kms_driver and
amdgpu_partition_driver.

amdgpu_mode_dumb_mmap() additionally rejected userptr BOs and BOs
created with AMDGPU_GEM_CREATE_NO_CPU_ACCESS with -EPERM. Dropping
those checks from the dumb path does not allow such BOs to be mapped:
returning an offset does not create a mapping, and the actual mmap()
goes through drm_gem_mmap() -> amdgpu_gem_object_mmap(), which performs
the same two checks and still returns -EPERM. The only user-visible
difference is that DRM_IOCTL_MODE_MAP_DUMB on such a handle now succeeds
and the subsequent mmap() fails, instead of the ioctl failing. Dumb
buffers created by amdgpu_mode_dumb_create() are never userptr BOs and
always have AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED set, so they are not
affected.

amdgpu_mode_dumb_mmap() is kept, because it still backs the
driver-specific DRM_IOCTL_AMDGPU_GEM_MMAP via amdgpu_gem_mmap_ioctl(),
which is used by libdrm_amdgpu and Mesa. That path is unchanged.

Build-tested with CONFIG_DRM_AMDGPU=m (W=1 for amdgpu_drv.o and
amdgpu_gem.o), no new warnings. Not runtime tested.

The code change was written by hand and reviewed with the help of
Claude (AI coding assistant); the commit message was written by Claude.

Signed-off-by: saad <primecoder8@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 731fe8f9e..134d2fe4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -27,6 +27,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_fbdev_ttm.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_pciids.h>
 #include <drm/drm_probe_helper.h>
@@ -3151,7 +3152,7 @@ static const struct drm_driver amdgpu_kms_driver = {
 	.ioctls = amdgpu_ioctls_kms,
 	.num_ioctls = ARRAY_SIZE(amdgpu_ioctls_kms),
 	.dumb_create = amdgpu_mode_dumb_create,
-	.dumb_map_offset = amdgpu_mode_dumb_mmap,
+	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
 	DRM_FBDEV_TTM_DRIVER_OPS,
 	.fops = &amdgpu_driver_kms_fops,
 	.release = &amdgpu_driver_release_kms,
@@ -3177,7 +3178,7 @@ const struct drm_driver amdgpu_partition_driver = {
 	.ioctls = amdgpu_ioctls_kms,
 	.num_ioctls = ARRAY_SIZE(amdgpu_ioctls_kms),
 	.dumb_create = amdgpu_mode_dumb_create,
-	.dumb_map_offset = amdgpu_mode_dumb_mmap,
+	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
 	DRM_FBDEV_TTM_DRIVER_OPS,
 	.fops = &amdgpu_driver_kms_fops,
 	.release = &amdgpu_driver_release_kms,

---
base-commit: 279235273fc6c0a33df863b4a1cc52ec1e73aba5
change-id: 20261105-amdgpu-dumb-map-offset-6fa41e8d3fb5

Best regards,
-- 
saad <primecoder8@gmail.com>

