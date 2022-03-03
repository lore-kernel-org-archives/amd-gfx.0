Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297BCC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 08:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F30D10EF12;
	Thu,  3 Mar 2022 08:23:14 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C69B10EF12
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 08:23:13 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id yy13so83735ejb.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Mar 2022 00:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EkIAvZvH9iiQKAQTS6bhzU6S8ihTp2oNWkBQzPdSSZs=;
 b=OI7cuzcVaSNNPuPBKZC+tsIF1VVtK+04iAgbYAGmmbIk47B4CZijl4vYbMBswj2bEh
 ZiylxndnG8H4I1Y5wD/GyZb5QGrvHKC0sWvjY7RxPOYf0PjBZ54BecJL/78TPms0F38n
 uLP0JLpZxCCYTLfkc44G+Qu+Rp4DDtlrq33ZNGuuJgKjijnd4rHSNubNPMcfBJjx/ONv
 kGryP4bbtfvf7bxvxlrmlqH9H2yRcJ+Wyh0m2FCeUR+m6JTkJDohpLbp5UfNt7KtXvtf
 on+CScWKGTS1NiZwkHkNTKTtPA2u0c43ApGVj4PzrJCoEoH1ccpIrz+IZ3Q0MePb7nCn
 mkDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EkIAvZvH9iiQKAQTS6bhzU6S8ihTp2oNWkBQzPdSSZs=;
 b=tQbjfW9SIUVkWhysYhWJyzLd17vyBKg2dUFewPtUQ9xT3RZml9/BJFysVq6FBs9m8P
 1u6WI5NmPfzZUr8obGKwyhOdxTFuOv7Z2N09wsadKeaohKbbCPugyElrJpdQ+QJmbW0W
 JGCO2vVX5gX9JhoiFjV9hzMJ95/6VAXSqKci17X0TzlX3Cim61Fsw1k1TXcBg9Z2FkFA
 dpO6Pw2hxN5GLQGGv4+6O0Lmpks5jMyxUqnm78RTO0vOaXedy8zyJaznQh3WXCQW87nc
 mTAkA6Pohe5S9qlbP02M6PmTgKgtV3u11NLro8YlU9YdofLtN07TJanuJHvn+E3Zf5me
 JXNA==
X-Gm-Message-State: AOAM530qZ1S7dTg+f257h2sQzTbVugKOop7sD8afjmCErM8EzAz80ngH
 T6c38i+BatFv7bDIkboyNGUndxBgxvfsgA==
X-Google-Smtp-Source: ABdhPJz39N9UC6QsCB5bGCwZuV9IWcFDGrYH/a+B57tG8lDowCL6xaQsWDWNmTxgmZVuA9JY2YX4Cg==
X-Received: by 2002:a17:906:c114:b0:6d7:1065:a8b0 with SMTP id
 do20-20020a170906c11400b006d71065a8b0mr8030594ejc.181.1646295791667; 
 Thu, 03 Mar 2022 00:23:11 -0800 (PST)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a056402060400b00415a1f9a4dasm548308edv.91.2022.03.03.00.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 00:23:11 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Marek.Olsak@amd.com
Subject: [PATCH 01/10] drm/amdgpu: install ctx entities with cmpxchg
Date: Thu,  3 Mar 2022 09:22:59 +0100
Message-Id: <20220303082308.38217-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303082308.38217-1-christian.koenig@amd.com>
References: <20220303082308.38217-1-christian.koenig@amd.com>
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

Since we removed the context lock we need to make sure that not two threads
are trying to install an entity at the same time.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: e68efb27647f ("drm/amdgpu: remove ctx->lock")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index c1f8b0e37b93..72c5f1c53d6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -204,9 +204,15 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	if (r)
 		goto error_free_entity;
 
-	ctx->entities[hw_ip][ring] = entity;
+	/* It's not an error if we fail to install the new entity */
+	if (cmpxchg(&ctx->entities[hw_ip][ring], NULL, entity))
+		goto cleanup_entity;
+
 	return 0;
 
+cleanup_entity:
+	drm_sched_entity_fini(&entity->entity);
+
 error_free_entity:
 	kfree(entity);
 
-- 
2.25.1

