Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6E6C02197
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 11:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE76A10E49E;
	Mon,  3 Feb 2025 11:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RhmQhO+S";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2399010E49B
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 11:58:51 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2167799f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Feb 2025 03:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738583929; x=1739188729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+C29FQAAsqcq/eSCAC8m1g/I0pkefooPYlJKiIkZ6k=;
 b=RhmQhO+SeadKbQdKXZsGmeb8Z2AFeilsFu0VRR1rjemLJucYzRjl/t78shrGPebO1/
 pHZN/V3a7ckYvBBoW9PVPJ6pKd4ThoMSXKOJ48ppKMI8oAyUPLPRQfnG0Mk5stlFN36n
 bExIJGX6QqUl/lW8YsXtM2u9EnBA7p2LQ032Vm60eh8ADENfbOgl5DE+iC3WuE7TcBg5
 0nblMSFZJ72HB39FWeT9cc3Ss0WvxbncoCStTecoWFxO2oi5RntPoov4EwBRGpqghQiY
 TSr6P06RQKvu3ar4moTxxSBKulmKQT1XL4j9Kml1yySodPQDzm1ocoyJsYsnd8w8ypJd
 dQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738583929; x=1739188729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+C29FQAAsqcq/eSCAC8m1g/I0pkefooPYlJKiIkZ6k=;
 b=s40yDO0b7qt+qVO9TQ8+rbanVc2EgN9nVWeQ0v9HvpAnW4uxd+/lZUw/hcTiRrqYVC
 8ItN8gQy2aWP1pgpR8i/SA+5k/lT6OMoVyCEn0AvYvKQXj0Scm6BIZ1QiArb9vDuW18l
 Jlvpb6MIu0GIqoTrHGLvWfI/vaPi9/2LlB2AJyGofZvazaKd2nx9FRVonU5tavcCrAVK
 uoajXvDx+9DERI7xw0ynu+VDGKVq303Y/qmPhi/l6f+68UrxCL7Xg7c+IPxvBZAXZOKh
 l2IqGFldupGNrWISJdL5AD72i6u6P48oBJXCsMFJqsWslf5mf7jN8AMz5fpGT4HaKDuS
 3b+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHlJ9QRcvtqRQIsbAkZ9iZ1+cJwIsAyk9a09hTzVwobYRg8TCDmgumPOEk/KVJj3SylPVLlg8h@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrrkO6Qeqzovj5EQd6WuGCunPnO0QFXThZe52lB+Nz5kY2qhdN
 9sKpG7Dz1mstQNZ3mjNKJlm/0QtNydf4xxyruH+g34DPyRd1h1+A
X-Gm-Gg: ASbGncu2Tr6tMTmtIPdT3JPQcCL7yJIdQJ3ZqVE92jPLAu0y6bh7HmcnMTlXlsxrLYa
 nxILK7MkTfbf19IEuC8jl5w+pOnPE49suALP+UbQ+dT9wnSFxUEeUqW/1U59WOj4IpUBJcoPIkA
 4XLywSxb3a+kpgwOUlw+cd5sOm9QXBukssHpZbrXJB7jFBTTfX2zp/Z+9QPLWfxTUf28tw530Kg
 cPRGlaxodBiACEf80ruLMqIzqY6nai+2LtRRPZeQjqcFDMM8uQcVwaLzxekyqQqIY2sClJNW8ox
 O8m65t6lVCDQUAe4fMh3Ne2CBNA=
X-Google-Smtp-Source: AGHT+IHu7ZXY+mbeL4dou5LhF6Fd4bfG0P3fa8JQ6yyEEZ16RCaYI4UOyZuKeImK9tSZtWncXlPBRQ==
X-Received: by 2002:a5d:5988:0:b0:38b:ed1c:a70d with SMTP id
 ffacd0b85a97d-38c5167b477mr19118755f8f.0.1738583929293; 
 Mon, 03 Feb 2025 03:58:49 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15c2:700:903a:ba89:5ce0:8312])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1017besm12298928f8f.26.2025.02.03.03.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 03:58:48 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH 3/6] drm/amdgpu: overwrite signaled fence in amdgpu_sync
Date: Mon,  3 Feb 2025 12:58:43 +0100
Message-Id: <20250203115846.13142-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250203115846.13142-1-christian.koenig@amd.com>
References: <20250203115846.13142-1-christian.koenig@amd.com>
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

