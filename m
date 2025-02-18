Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C747C021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 16:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E47510E71A;
	Tue, 18 Feb 2025 16:14:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QzJN2mBY";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC3410E3F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 16:14:06 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-abb705e7662so603860066b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 08:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739895245; x=1740500045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O+C29FQAAsqcq/eSCAC8m1g/I0pkefooPYlJKiIkZ6k=;
 b=QzJN2mBYVQRRUYefXs1aeAKBL/xjocZLPluef3xTNJpNFCGA23tFmbSdMGj9sHepn0
 qh4jRZMpVze1AksN0Ve/ybUppotyK1szFvwtGEIYs/mR2phHroO+uia3ld7k9140wGzV
 U5gDS0ZOiWRpJ7XNiLy8KoCqXvDhu/IewTCHXJrWgnAi9WZAgW4Ch2QUz3YOZfbowaak
 s7HWW4S88v8sYkgfkh0z6LJA7a3xv6ZZbsyqCvT5gpUpcvNBsimNU7/bmKztfXCiU94f
 yfT+FJTS28HoNpHvY8daJWtqdimph91X1M45uKoegJsP/Ge7X0Ct4txoqA+8d0ODyufy
 RrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895245; x=1740500045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+C29FQAAsqcq/eSCAC8m1g/I0pkefooPYlJKiIkZ6k=;
 b=WTOhape03YNC/sxLbSGsXymdUGUgfwmrh5Ssf8WuaYYTA1GzSuIzANjcNa3Uke2IcX
 ar8kHhV8Vf8Lnc58kl0VHmcyYUMCedz8ggHnxyMwDNTCngbuJ9M56Pt/ChK3nDh9oBE2
 xFNlspzzBH0RgAICSsZQnXg2eCQXt+1Cvsr9ERSC4j3w+xSsD06stGt2jklkaWU1CnD5
 4h2zuv/X1cjLwT1V3f58bkaeHjU2ns5Ml0wvJRkex4CKGp0UW7xbuzqr9dvbQhPtwuqc
 fjpLHi1OvB/jZAW7seOjqmIc2pLTuLujNpsO2AopHc7h4LSMiLfh+1EmpDmY65GqmfZF
 /Hhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJkdSnOE00BZ+4Uu7jruau9LLDIve5uMxisxlUOzXqcfzQ+WXNWXp2Ecxkpvxu7N6OFfwokqyX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykuBO8w7+4yudLBeC+qoMleDwvzDgrNGMW4ybVwbLZjx4lsFtz
 vF+EEx4ZL2Fd+ToyVNE3ECNN2WrJM+xujWpHuuLSPfy1T/yb6/DFLp7OJw==
X-Gm-Gg: ASbGnctpDZZzuRJwgUE46iYwg8qrYobkM/7fiSAuwS0hc64FVzHeIcuBB28N+IfVKqP
 jiHkfbnmbX9zsapEHelGGwcru4du4m3YPZEgbfcg47ECzb+PMHtkErKBZFw7a2nAY73++uyn4Q+
 nr/RMFiog6VDG1skuMn6fuSQf+ggjCy1JWj6VmFrwDVR6BW1IOYTbeDL4MJjhG21/jZSARk2PUJ
 gksrZMkPCkZWcmQ78XbfR7hnC8rpUMvXpddnebFQ5/UrcO+LznfUNPS+AKWYv7r4kinTlc9F7Sk
 btkgtK1+9aZWRjkLkAOziPdDUgeJ
X-Google-Smtp-Source: AGHT+IH7TzYLwUxz6xVQm60VXD67ejssmObVQTbrlLnQZce/Y5Do3q5f24D4iItH7TBp6VyQLARQ3Q==
X-Received: by 2002:a17:906:9c92:b0:aba:6385:576e with SMTP id
 a640c23a62f3a-abbcc5ba657mr46992566b.3.1739895244457; 
 Tue, 18 Feb 2025 08:14:04 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15cb:ef00:7a4e:6292:55ba:b835])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba7848676sm306762466b.144.2025.02.18.08.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:14:04 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/8] drm/amdgpu: overwrite signaled fence in amdgpu_sync
Date: Tue, 18 Feb 2025 17:13:56 +0100
Message-Id: <20250218161401.2155-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218161401.2155-1-christian.koenig@amd.com>
References: <20250218161401.2155-1-christian.koenig@amd.com>
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

