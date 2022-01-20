Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29F6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jan 2022 09:03:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2BB810E39F;
	Thu, 20 Jan 2022 09:03:42 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9514310E39F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 09:03:41 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id w26so10626268wmi.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jan 2022 01:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vtjk8pt+IYjOls6Kbc40my4JTGYBH+JLpUql49gp12Y=;
 b=SxTRmxSXXQDESHmDZgMBt03Px6lIsiRoGogugudoVS9nWrHAnv1khZy+0jjbX5gc53
 u/mrizJFw3DB5o60QlkS3V1lVaMOsUPozo3dJFf9UjHkDvWin2iaKsXvWbVbS8mKMcTb
 /kRroSVCdsIgwMXQAJ9PTLxyuWXOIpouRf3SSL0s3ndOhq5/PCPHRbpW7UErkOMjpE7+
 iAb8i+PIJNCBuBOQMJXIlFPMlCuTgp4+2lLe3+jLnVcjTDwc1JwN0SdXqWceW3+/g4E9
 tiDOpOPT9IkYXAmlmtY1k7830dB731Jb9bdxe8vCoD/qq7eUkj1XVtHZRME7FWPv/IfO
 /Hew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vtjk8pt+IYjOls6Kbc40my4JTGYBH+JLpUql49gp12Y=;
 b=5rjUOHmwNYh+bzNfm27lGmlPYZk173hyBcHPeWte1qU0T54tzXfKQJ3ZqJaieVSDVV
 GN/lbfQ/l1x3BNnLSDH7Jd1R0oEz15MPFrSA1RrFyTe5p/4iMUvaXAQpXt6mUWfOzH5q
 o+DsBLHdm7Ts1jUfXgZwGyK2dzL/YQSvRSe0VbaTSBotWuyelhLQNI6ajPaG1w6lvW5W
 A5w9ZULRE42xVgcsPeYCPRyCVEED/Dd+iQX9w5yguQFcmWU5txYA5+cLBh+BltTHp2zT
 pjVDi8JwO4qLK0wjlWgnd1qkDYsWW4+IZqt9oayCp1Lrt3wic4/EZGb+VUG3r9RSygrt
 R1Sw==
X-Gm-Message-State: AOAM530nraop+UwiFx/DV/iv6nO9j+NRi9raxbL2mFTbPdcevRtubB7z
 Lo6q0gImZhRnEAm4hCPbHKE=
X-Google-Smtp-Source: ABdhPJwV/iirj7JxXJ32DX3XSdo7o2f+i7nBk4nlPsNqEhF9at0u5FyoWQSwgX4INUGz653hfXE5nA==
X-Received: by 2002:a05:6000:1206:: with SMTP id
 e6mr6193525wrx.274.1642669420253; 
 Thu, 20 Jan 2022 01:03:40 -0800 (PST)
Received: from abel.fritz.box (p57b0bff8.dip0.t-ipconnect.de. [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id i13sm9313307wmq.45.2022.01.20.01.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jan 2022 01:03:39 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: andrey.grodzovsky@amd.com, Alexander.Deucher@amd.com,
 Anatoli.Antonovitch@amd.com
Subject: [PATCH 2/2] drm/amdgpu: protected amdgpu_dma_buf_move_notify against
 hotplug
Date: Thu, 20 Jan 2022 10:03:37 +0100
Message-Id: <20220120090337.2542-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120090337.2542-1-christian.koenig@amd.com>
References: <20220120090337.2542-1-christian.koenig@amd.com>
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

Add the proper drm_dev_enter()/drm_dev_exit() calls here.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 8756f505c87d..eb31ba3da403 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -36,6 +36,7 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_dma_buf.h"
 #include "amdgpu_xgmi.h"
+#include <drm/drm_drv.h>
 #include <drm/amdgpu_drm.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
@@ -447,14 +448,18 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 	struct ttm_operation_ctx ctx = { false, false };
 	struct ttm_placement placement = {};
 	struct amdgpu_vm_bo_base *bo_base;
-	int r;
+	int idx, r;
 
 	if (bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
 		return;
 
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		return;
+
 	r = ttm_bo_validate(&bo->tbo, &placement, &ctx);
 	if (r) {
 		DRM_ERROR("Failed to invalidate DMA-buf import (%d))\n", r);
+		drm_dev_exit(idx);
 		return;
 	}
 
@@ -490,6 +495,7 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 
 		dma_resv_unlock(resv);
 	}
+	drm_dev_exit(idx);
 }
 
 static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops = {
-- 
2.25.1

