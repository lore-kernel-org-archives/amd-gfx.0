Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A4EC54EBE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 16:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E86E810EA5E;
	Fri, 13 Jan 2023 16:35:37 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227E810EA5E
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 16:35:36 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id u9so53607633ejo.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 08:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qRuDRTPrKzBaIJpdmX0GfY5bqrQ6L1VwK1H29+A+SKI=;
 b=lkKXDjYBXQKiRAWlqdNI+uhxURl2yMsvl/lci5BWScoSsr2XIjaqFueR1FUYjXSymN
 0xV6H2e05cqP52qiPU8Z2qAGZhzQpdWzjo2NVNLc57NMXY25DIgvusYwCG0j86ImB+3g
 AglCIBZ9U+0IhyDWCOGsW/S3RZ4KTg8QCIvP9J3GGIA60vsBHJPW020M5IFmmMxEgW5e
 B/JzXErq6GTLTnhWgpB/jjFXD1qrFOQPKvAtZw9DoOlNpYXVv72nd+SF4Jb26ycz0vNl
 tW64hUX1RHk7WwXI3w/lw6NIlOQLsTNhnBY+ETg3P7XXramSDnDOZl4XQd/XdZ7uBh0u
 akWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qRuDRTPrKzBaIJpdmX0GfY5bqrQ6L1VwK1H29+A+SKI=;
 b=6RoP3xCm4Zj//306soPSla0Vi2+CXKzwGouBxliRNMVBN6/9pmhaq+GmK/YFEGRQWU
 VDSgAIRu1HwOYC9sbIr6ieEnnq956ev3rq4dC02kcClTO2QRVWSp+5QZ7WM1Qh1P0gjM
 9gDrabBAHwVQA1hPi3r0FC11Ut3k4xTXh9+KQIqlYU6NHOonznlwx255alcafw3IHloo
 TIME9eRe6vM9mxGjOGLZsm3CI+lGAHi6zPUHWVTF4ujbymChQtV4hLXOQYxpvSjAr4FK
 qwPvPHEeT4st0ndj55Fo5zhE653y+/PZLfdfIJjfPeNvq9WV70AlVf62zL3biLX+wspb
 lFyA==
X-Gm-Message-State: AFqh2kqq5UqkhzWdsszLXgsfEvbmwu3gqhRKPEpgcjAmnliXE1tErdXR
 ctP2cqSnWqNSxRWtb4DHJd0MmEDO4/4=
X-Google-Smtp-Source: AMrXdXvp63MwQc6MMjt/h6+IrOq2qlM4xYxlhdyYNQtSm0ue48ko2rZfEpbT8iQV/WBq4PnfLFzYQA==
X-Received: by 2002:a17:906:714b:b0:7c0:e98d:b27 with SMTP id
 z11-20020a170906714b00b007c0e98d0b27mr3695766ejj.58.1673627734583; 
 Fri, 13 Jan 2023 08:35:34 -0800 (PST)
Received: from able.fritz.box (p5b0ea2e7.dip0.t-ipconnect.de. [91.14.162.231])
 by smtp.gmail.com with ESMTPSA id
 17-20020a170906059100b007933047f923sm8713855ejn.118.2023.01.13.08.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jan 2023 08:35:34 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix cleaning up reserved VMID on release
Date: Fri, 13 Jan 2023 17:35:31 +0100
Message-Id: <20230113163531.175294-1-christian.koenig@amd.com>
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
Cc: Candice.Li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to reset this or otherwise run into list corruption later on./

Fixes: 16be3e9f6f03 ("drm/amdgpu: rework reserved VMID handling")
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 6481b43ffe25..a0545d51b6bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -499,6 +499,7 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *adev,
 	    !--id_mgr->reserved_use_count) {
 		/* give the reserved ID back to normal round robin */
 		list_add(&id_mgr->reserved->list, &id_mgr->ids_lru);
+		id_mgr->reserved = NULL;
 	}
 	vm->reserved_vmid[vmhub] = false;
 	mutex_unlock(&id_mgr->lock);
-- 
2.34.1

