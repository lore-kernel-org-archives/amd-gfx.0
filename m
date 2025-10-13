Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85D4CCD18E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62CB310E47D;
	Mon, 13 Oct 2025 14:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EU+qj7Xx";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8936410E477
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:13 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-636535e4b1aso8450531a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366112; x=1760970912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RL6rVAENXblPP/WtJ2kkdTszLuUIj+9DJtEA2dEhVX8=;
 b=EU+qj7XxS5PPdAK2kNWQkOrQRTE9umVjcmuxyEt+x2ZDPAtipDleZAXCyGt5u3eoJO
 dv+IBcbykc9qLjJ4PIe2sF2KOcY8pI/AjEIwhgC+CQ91qdDkUgJ7UH1N8SVFE6/xI371
 ZmFcIc32JmWUEGb5IDkYHmQi30DlSkfbRBT+PB86s4pqCU29fawdCi7k+Z1s1FZg6jIp
 a6wHyAsS/pAx4pkFccsgMSdoLN+WV0m66NbW6jjX7yUjCw0XxmEs8ht0y+koSkC3/z0i
 8Ig3AUMrsaMj/pYqkemuZ4unC7ivbUC4Y9XlU7w6EfUger7VyZOP32/vDRcQpTi0z3je
 Jzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366112; x=1760970912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RL6rVAENXblPP/WtJ2kkdTszLuUIj+9DJtEA2dEhVX8=;
 b=JF7TLnvXE9wr4CFIYHDUR3LGdpo476Zc18CoDU8XqSYcKttd139JoS/8ICUkq3Uxdx
 zQlLynlm2ukY87xjXr0x7ucJynwqq+7HUZR4Kt2tBLLNcvvCwP2ZNM5s/kucpPAYKLaw
 +35GkmB4NTgCvKogRs+QXb3hKz/rE0LUA4YHlcjBQbRlo318ZHqDQX5SWXZXseZF+4hB
 nl9htWK1d+WfL2ozXxSDNe0yXCqmdLFD/DbSFRg1nhSdtgxdPTe0G7nspos2mo9n8g2/
 JfLIQ/bsNhilckzfMCSx3VbvCYKaxnqCkdxI7s5NKdVyxkspCmI4KDeVjh0M1Zay7bWm
 1YjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/fJMzgHBXM0iYM7hmbIk3/3UNJA8iuwAUunYM5ri7QWspoxb3yk9zPM1LxjbcyUSn3nbtv6Fc@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1WQQaD7RAWzehkSstXtf695f6GMeE9TNnTR9rsu4+ZYmZLT5V
 whv8UAMD5SfZ41U33NkgREIuDunsoco5EwBudUmmtHmcHkXGL579cJlJCQbhUw==
X-Gm-Gg: ASbGnctNN5x/QWUXJWouQf24VBKBAM3ZlqTCWs3sPw1TDtKrXBzxajEeEJ3G27wAVjq
 3t5zV6B85IvW3jOMFDY5AG8aIvtsDxQhIVGzI4+agBbzCysVrJMlRA3jOr2/XojRIAakBbxwsS6
 xSDPHj20AtT0+P2UchkL6EsthBVpGeSDeKfnY+fM4d/wPQi95W2uSjcG6G+6VIVJvo6LfWAsnAy
 dcrT0KJdIPcmfXxxfuKL73Ih/6etsa2Z24H8dLv3ZyQW49PbV0eOabgxGFOz5pK+NlO/lbTgCs2
 OVldvBkMfGvQsHgfrIEdmQKMIW0MU7hAZvB9VuQxtPKvrBoYqhVQ0vxvUVL1tSfzEUWnY3vAppM
 I7tFtQ4vKKrHjrb41mwfkepgqdJDN62fpC6YcBnCmi6oTvkUWvbVAAkM=
X-Google-Smtp-Source: AGHT+IGGP8SEwMWac6436582fvmzSsJRI9J6R8Oxa4gb3xHIOYYorxhUyzBVYQImjrU89tQz8U/bZg==
X-Received: by 2002:a17:907:a4c4:b0:b57:d5de:444a with SMTP id
 a640c23a62f3a-b57d5de478amr859198266b.15.1760366111941; 
 Mon, 13 Oct 2025 07:35:11 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:11 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/15] drm/amdgpu: fix KFD eviction fence enable_signaling path
Date: Mon, 13 Oct 2025 15:48:37 +0200
Message-ID: <20251013143502.1655-11-christian.koenig@amd.com>
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

Calling dma_fence_is_signaled() here is illegal!

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 1ef758ac5076..09c919f72b6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -120,12 +120,6 @@ static bool amdkfd_fence_enable_signaling(struct dma_fence *f)
 {
 	struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
 
-	if (!fence)
-		return false;
-
-	if (dma_fence_is_signaled(f))
-		return true;
-
 	if (!fence->svm_bo) {
 		if (!kgd2kfd_schedule_evict_and_restore_process(fence->mm, f))
 			return true;
-- 
2.43.0

