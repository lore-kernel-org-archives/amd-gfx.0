Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E41DC02192
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2025 15:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07F6B10E56D;
	Mon, 27 Jan 2025 15:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lKGCkchN";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55A2110E566
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2025 15:32:12 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-43618283d48so32586515e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2025 07:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737991931; x=1738596731; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O+C29FQAAsqcq/eSCAC8m1g/I0pkefooPYlJKiIkZ6k=;
 b=lKGCkchN66r99zQQPSuQjkiNXSVAJr1AG6iatVOwOHBhS0ADbg6JNXyF2ZOCP8vmfN
 7jfm4xFMdKVVGqlDYYT7o2en8Kn0+ujAr+Rz1rIDwLdLftL7uE7MK+2IJV6XVpyePiir
 93DWb79R0YyEM8joahVCOA4H+l9ro8TL2aZOP0gEON7TvysgtHUP34a8exfDQqI3Qcbv
 MF1KCSRw+calEFZLlVf/wnV7zcWKsPsWZ4jOZU30nigp4VF9U5RRK8PJXJ4actKGPbvt
 lhoTWDX3zuUrBlegVOQl7WjLe8HZ5sZS3cVeXhqnQB5+vUYDBcJUfoTztBSs8lg7QP3G
 nuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737991931; x=1738596731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+C29FQAAsqcq/eSCAC8m1g/I0pkefooPYlJKiIkZ6k=;
 b=ewZjO4U9xmaG9U56+YLfeF44egQfyxjybR22nNGNQ0yYvj7b3jTrZzlRbdJIPmkqBK
 VA3Ion47VkGui1R5wQl0qzGbcC8a597iHb+3lVmJTFDspW/U1JlmbgcBk+IjRuG4NIZz
 E5pm7eAcDc3Eexmwdb3DFymza7KYb6QmLjLLC89CfAXhG/0/6PUDuTUcHRHajv7d5psO
 VV6wcXRkLwkf/Tg7oumtr+fB+EsTToBh/rQA/EzETAqNCC2GXn7iwlRfPqM1EH0E8W5j
 a2BRSKbvij9lUil0aiXZFQasuHOqs8gPVQvTLA/Y2rdNUOJHV/BIIW+q3fIctbShwnea
 A+/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOCZLyTkBTrLSgUhzFVtpIFJ2JwY7PWYsCcSrhc1urTckn9HJxe658IaE5Nu3cXl8GmEgKYqxd@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyr4OW3/flXuPdststv22pUSQ/a1ijc5kHbcnFEvqga8FDuTB3+
 EqUWnpfz17a3oXMY9kYdi/tZB8uEu84xLUCktf7WmkTqu9raUv/8eJU+SO1n
X-Gm-Gg: ASbGncusAlRjxdbhjrH/zLWQffCHeQ17gAetq1ARgHv4oOu0aalwd2jFFt0PEVob4W6
 Pf6rMDRIixW2AUMlLm2zd8AnwVuf9IA0rdCxlhAOsuz4zpIXr+ytZd+y8rs8gXp6e8sLldsaeTK
 paxlkeiHC7T1VAMvz7Fwmu6HEqxBnm+R78qWDQchD/wKQ3xDIJzVhZpzmciIp0kF8rZWxaoVsOP
 QVcEFQi+0CfBL0mufRtfn8owQ2/e/bjcNUYdvDglcx72Tm4dW0SowBu0kW+83b2eAi9G9rWWZsA
 pCHZyCQi1F/GnWyuPA==
X-Google-Smtp-Source: AGHT+IHAyQwJ1QGQnXZvIklthKRvrwO4esBqSdT9SQZKo++JkHQWsAAiL6ncl66Vx34cAFRIbNelTw==
X-Received: by 2002:a05:600c:1e8b:b0:434:f609:1af7 with SMTP id
 5b1f17b1804b1-438913bf885mr393159125e9.4.1737991930540; 
 Mon, 27 Jan 2025 07:32:10 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:153d:dd00:1202:d6cf:5d6d:56cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd575468sm133904325e9.39.2025.01.27.07.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 07:32:10 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, srinivasan.shanmugam@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/6] drm/amdgpu: overwrite signaled fence in amdgpu_sync
Date: Mon, 27 Jan 2025 16:32:04 +0100
Message-Id: <20250127153207.5717-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127153207.5717-1-christian.koenig@amd.com>
References: <20250127153207.5717-1-christian.koenig@amd.com>
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

This allows using amdgpu_sync even without peeking into the fences for a
long time.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index 86c17a8946f5..bfe12164d27d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -135,11 +135,16 @@ static bool amdgpu_sync_add_later(struct amdgpu_sync *sync, struct dma_fence *f)
 	struct amdgpu_sync_entry *e;
 
 	hash_for_each_possible(sync->fences, e, node, f->context) {
-		if (unlikely(e->fence->context != f->context))
-			continue;
+		if (dma_fence_is_signaled(e->fence)) {
+			dma_fence_put(e->fence);
+			e->fence = dma_fence_get(f);
+			return true;
+		}
 
-		amdgpu_sync_keep_later(&e->fence, f);
-		return true;
+		if (likely(e->fence->context == f->context)) {
+			amdgpu_sync_keep_later(&e->fence, f);
+			return true;
+		}
 	}
 	return false;
 }
-- 
2.34.1

