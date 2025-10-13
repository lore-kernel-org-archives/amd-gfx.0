Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF7BCCD190
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7C4510E47A;
	Mon, 13 Oct 2025 14:35:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YWMTp/Pg";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E3B10E46E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:11 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-63b9da76e42so2392226a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366110; x=1760970910; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dcs5G3OnlnQFK9aYqll3CwX2/M7qzjpRhdjkxpesGLA=;
 b=YWMTp/PggdKievczQo56z4OHEtH5+YTYMeKheuUrui/WXLaYUpFoZcUem1G1VTj2AC
 65V+zSIq3z5EardgM2u0w5MKusSSgKBsJUYeBJgsq/z91JnB45kC2iCrv0qasz7g6TLD
 AqYftwjOO1/0r4nCVipawszj9tVI+pJEIJQQHU5lCSZEZxmp5FCLVoe92ulh/0HrEc+3
 NRWGGEX2PgtjxPw6dq/n8bCE8SAxarJNsXN4GPLR4ZOdxzlIvm2lo2WrA7yA5nJ+PmQZ
 p0Ctg8jcJepzS704O/2cKDCUUl/BpjFVH6iwrZt9QrlSNHdM0RUa/orMUDnlTEx8fkll
 J5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366110; x=1760970910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dcs5G3OnlnQFK9aYqll3CwX2/M7qzjpRhdjkxpesGLA=;
 b=pcghhccz3JrJv+KkZBErpLupz6OIM+mrfgqbK53mrVGD3yWMDw1eWq3Y//yi2IbPJO
 z/agASnzsYg7HFsiRKg5fo99ltFj1eadwss5QKoQ+Oa2o0EsQ8pNp+YGeYYZQGnUGVi3
 astQHqI5f05Y4u9RWighDD3+jsOT4JRwQ1jXlOy5+Fa3bp9xFr3ReZ6bpeVgQRWZzwkz
 RETxvNmdOuJQ1tTJjHOTERlBfDIgaiRjztiO5/MwA8nCUDpw32tTWKmnZ9Q97aY9PitG
 LUdbBdrZJSYP3E8yX/Q8OwTo9G6DINd3gI+YLXVQAOAJduA8206eqi0oi69bixTtnKxY
 zZAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn1N+yriJwqfPW4Fp3MoFxYQNwmpQqNhIeQDwn/jSWNkD1jhF3G02qgi+jZczxEJ3vAVuimeOM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwdzIHRCoWrxmnkfwEdbcn4reQ/8Xd2/4d4ddzbeuK2BvNKaR+Q
 cBg+LLFmqrizeyo8nwXku6+F6HK1QAxtJpx6ri6aQ2pDOM/HhxOPcdj0
X-Gm-Gg: ASbGncvSb4Gtg79aSNETx+T1dvGmQIkDJ8NBCSGlvn99wZCn1i4rM+GHIZP0o86Wtrl
 Bu9bW2ra7VA5zOXZzDHDa9Nz73rXvsQM2J/aajctloeSbYWYDIATIAKLnGtUdZpYO2gDb5EdOQc
 3isDIioeqzpwg7XgPhbUyQCc52NOS4n5OA7o79QooC6zTjcIbumrNJswZXJENhVLzKbCfoxfflr
 aQ4E5TIWhotDkZVm4t8+KP4c0NJcZqmDYNXJl0buafw9WKrNPm23PBIzw6luGLEb5taRKIbN9m4
 9D7BUbb0+XSah3oFsfE0ugNFkmuzIEpoTZSBEsrdmTVV4POacVl9f41VY5fSdq3HmHaYLFhBa73
 Ku8OiG0DO5uu3zykFzWJDuFHZPTbFqZFWWd50lYJ6b5c5J+ZBaEvx/Z9+8VCiaTEf4g==
X-Google-Smtp-Source: AGHT+IEUIFOIb5BRE+Mb+i7LjygPEzDEIsUwjT5ndJZqiW7ZYGEomZKLV3H66PtH/3ll02Pg8SvOXg==
X-Received: by 2002:a05:6402:1444:b0:63a:35c:6ebc with SMTP id
 4fb4d7f45d1cf-63a035c72c9mr13487401a12.23.1760366109937; 
 Mon, 13 Oct 2025 07:35:09 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:09 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/15] dma-buf: use inline lock for the dma-fence-array
Date: Mon, 13 Oct 2025 15:48:34 +0200
Message-ID: <20251013143502.1655-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013143502.1655-1-christian.koenig@amd.com>
References: <20251013143502.1655-1-christian.koenig@amd.com>
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

Just as proof of concept and minor cleanup.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/dma-buf/dma-fence-array.c | 5 ++---
 include/linux/dma-fence-array.h   | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-array.c b/drivers/dma-buf/dma-fence-array.c
index 6657d4b30af9..c2119a8049fe 100644
--- a/drivers/dma-buf/dma-fence-array.c
+++ b/drivers/dma-buf/dma-fence-array.c
@@ -204,9 +204,8 @@ void dma_fence_array_init(struct dma_fence_array *array,
 
 	array->num_fences = num_fences;
 
-	spin_lock_init(&array->lock);
-	dma_fence_init(&array->base, &dma_fence_array_ops, &array->lock,
-		       context, seqno);
+	dma_fence_init(&array->base, &dma_fence_array_ops, NULL, context,
+		       seqno);
 	init_irq_work(&array->work, irq_dma_fence_array_work);
 
 	atomic_set(&array->num_pending, signal_on_any ? 1 : num_fences);
diff --git a/include/linux/dma-fence-array.h b/include/linux/dma-fence-array.h
index 079b3dec0a16..370b3d2bba37 100644
--- a/include/linux/dma-fence-array.h
+++ b/include/linux/dma-fence-array.h
@@ -38,7 +38,6 @@ struct dma_fence_array_cb {
 struct dma_fence_array {
 	struct dma_fence base;
 
-	spinlock_t lock;
 	unsigned num_fences;
 	atomic_t num_pending;
 	struct dma_fence **fences;
-- 
2.43.0

