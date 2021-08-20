Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC76C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 08:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08C1E6112D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 08:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08C1E6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB2B6EA42;
	Fri, 20 Aug 2021 08:30:35 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D0A36EA42
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 08:30:34 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z9so12963951wrh.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Fn6YfCz91TWkXlIF9gLRefFqJcE+72n8T/p6nlRerH8=;
 b=JTlUBZF201UyUUmjbV89FdLDfHCy8Vems4QUjEpmc2ImtkdFBG9tuRR8AEg91HKuO3
 Az6nLCFvDeV6wlRw98aVjbcxTt9/Hd4H6f0J0XTm1nn+e4BmEAHefbOVg3Dbw0Q038gX
 j3YmD2eKfwoavF/mXNqeJJFK1sh0fHjwnuhFeOS8895oJwhQCU0y6ALf97PSAyPGz3Ja
 afKglNzgT9CUiz6gX1PM9/N11wADbyG57Haz9at5oo8wJzrjgVPXWzbhRRQszAr0WyTn
 1Jit6wGp41Nhy7Dr9EfqnpCOpngJ9Y4LWJ92rhAEDoHfNRshPISuO2ojWyGAMVYx/2A5
 wiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Fn6YfCz91TWkXlIF9gLRefFqJcE+72n8T/p6nlRerH8=;
 b=GjJAyN0p8dIsfy1cpK1k3r87johIOE/O00izA6WPta9s+BM6GCW4RYEPet9gjxuxJo
 R6BcKhjm//4ytUGZlvom91MECjgRTtto7xchUfeLngy2EhM6WMI0DHWx3DctJgKxhNAa
 OTVo2qGDDFKaA9dcGYT60kbXrC7IuQKhNjz4TbLcz+0QF/cBUdRirFJA0ZihQROfMqcY
 lp+HFEjPKcF8jfY9JKKpDe3Z0yYAkmF0G+d2/7DniyS7cGkEBlRL7t77xC97icHx82tW
 vTEPglA3o32saMmToyPg9PL+5YuuELem88Z2LAkEN13jH1bmj3DuWU1njhyly/+A98T9
 i4sQ==
X-Gm-Message-State: AOAM533V08lk4JWCnzJKxjoUmeySR/iELgWxorbHyDwnvHWSlAu65564
 zruvgFyZOphWx8xFYUiESxh/E5QHgzK3N+jFILU=
X-Google-Smtp-Source: ABdhPJxbheDGFgJG4rx75j/kiUYQD1mmrw8CSpZWXa3r7DFNDiLiRIqunpcO8fAAd2pT3xED7/M9Nw==
X-Received: by 2002:a5d:4c87:: with SMTP id z7mr8774928wrs.284.1629448232820; 
 Fri, 20 Aug 2021 01:30:32 -0700 (PDT)
Received: from abel.fritz.box (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id
 k1sm5391516wrz.61.2021.08.20.01.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Aug 2021 01:30:32 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
Subject: [PATCH] drm/amdgpu: use the preferred pin domain after the check
Date: Fri, 20 Aug 2021 10:30:31 +0200
Message-Id: <20210820083031.1533-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

For some reason we run into an use case where a BO is already pinned
into GTT, but should be pinned into VRAM|GTT again.

Handle that case gracefully as well.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 795fa7445abe..92c8e6e7f346 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -920,11 +920,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 			return -EINVAL;
 	}
 
-	/* This assumes only APU display buffers are pinned with (VRAM|GTT).
-	 * See function amdgpu_display_supported_domains()
-	 */
-	domain = amdgpu_bo_get_preferred_pin_domain(adev, domain);
-
 	if (bo->tbo.pin_count) {
 		uint32_t mem_type = bo->tbo.resource->mem_type;
 		uint32_t mem_flags = bo->tbo.resource->placement;
@@ -949,6 +944,11 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 		return 0;
 	}
 
+	/* This assumes only APU display buffers are pinned with (VRAM|GTT).
+	 * See function amdgpu_display_supported_domains()
+	 */
+	domain = amdgpu_bo_get_preferred_pin_domain(adev, domain);
+
 	if (bo->tbo.base.import_attach)
 		dma_buf_pin(bo->tbo.base.import_attach);
 
-- 
2.25.1

