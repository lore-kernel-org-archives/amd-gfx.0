Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26C1C52D6F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Aug 2024 01:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6B3510E619;
	Thu,  8 Aug 2024 01:09:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=basnieuwenhuizen.nl header.i=@basnieuwenhuizen.nl header.b="GV6Oj/Su";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0313410E029
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Aug 2024 01:09:10 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4281ddd3ae8so63305e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Aug 2024 18:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1723079349; x=1723684149;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XgJZG2gy27ZtkrRF1qxbr/+Jz5wIICcDJHBUyX+7d/A=;
 b=GV6Oj/Sui4tgc9RDNcm+AyWvvLUJeRob3uf///x/Gx3w7AIua63+mO7n8jHY6/Ca+K
 yU1MgDfVfgy0N1kwgh6NLvEcnUjfM0xCMZoV4NzlZqSCN7WFKFw8tow4Aai+J3uNdptf
 NvpNg5GM6xzBlMG5Fsg5FptozUszbbN/vo6Qt84VOBeKV5CUgMzEnJCPyxbB3JJU7lQ1
 y36jm8HvtTru7Muhi7ZhmHorur2/MIjSitVsHpmwfDFzA4YNuAIXQIgLKsmvhx2Ai6Id
 iedUgI2hU5Mu/WNJ0c+TGE5zIu+y51QD/WA8xetGBJtBGd6ZM1oUtO/998yfZocy/EDt
 90eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723079349; x=1723684149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgJZG2gy27ZtkrRF1qxbr/+Jz5wIICcDJHBUyX+7d/A=;
 b=cg5j40bhbiaMDorGXV0/r9MTXro8GZ/+1uO5OiXWi3hCMTJxCwJ18WaPt/r+7Icow0
 sCi6jORGONnn25sm2l18bXq1GaCxm0pCW+kl0n1yH6ltM0DgNS5qhGX/48eRCMFuYIlx
 WuDTJp/BGZkdOMk7ufnud2fmWR1jPb29TEJI+TD7qiCsaoAbJKT7Cu2NHYwrDZQZdMh9
 zHfrdtdWH7JVVfBq9E/PPJP2OXzOzwi3cnbUmSVU27b1uL3TaLxTR+VLIyJnGHKzUZ/1
 ANiDJ7vMPy2412WcoL+mVuZE2M5DFvwGJMFGa2i946Lo5xx855dpoH7nmNMU8z2ubi9i
 FIiQ==
X-Gm-Message-State: AOJu0YxoG/UjBIR+OSMdoertwwn/hQkPIO6XoyXrRU8WKj0p5YRt+R3m
 u0BcuSO0NbNZvk6lE0HoSDB5kh3ZSkGa7oF7WaDTGgUSgO77FZ8Qoy+PrjWn0uKdzIoB8Lsd+Ne
 GISE=
X-Google-Smtp-Source: AGHT+IG4lL82m7huZXVLavZRTxZ7TAawmLYT18vtJX965VMPcb0Zi25xGRak3aHDkZDw6671ZSALzA==
X-Received: by 2002:a05:600c:1c07:b0:424:ac9f:5c61 with SMTP id
 5b1f17b1804b1-4290af22b44mr1737395e9.3.1723079348998; 
 Wed, 07 Aug 2024 18:09:08 -0700 (PDT)
Received: from bas-workstation.. ([2a02:aa12:a781:a500:aaa1:59ff:feea:fd4f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d272095b9sm240753f8f.68.2024.08.07.18.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 18:09:08 -0700 (PDT)
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, airlied@gmail.com, faith@gfxstrand.net,
 friedrich.vock@gmx.de, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Subject: [PATCH 2/6] amdgpu: Ignore BOOKKEEP fences for submissions.
Date: Thu,  8 Aug 2024 03:09:01 +0200
Message-ID: <20240808010905.439060-3-bas@basnieuwenhuizen.nl>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
References: <20240808010905.439060-1-bas@basnieuwenhuizen.nl>
MIME-Version: 1.0
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

Should be safe to do. Writers of BOOKKEEP fences:

- amdgpu_vm_tlb_flush: Per the comments, only to prevent frees.

- amdgpu_vm_sdma_commit: Uses AMDGPU_FENCE_OWNER_VM, which was
   already ignored by amdgpu_sync_test_fence for cs submissions.

- amdgpu_amdkfd_remove_eviction_fence: Adds a stub fence, so always
   signaled.

- amdgpu_amdkfd_bo_validate_and_fence: This is used for eviction
   fences which shouldn't interact with amdgpu userspace submissions,
   as we detect owner as AMDGPU_FENCE_OWNER_KFD and then it should be
   ignored by amdgpu_sync_test_fence for userspace submissions.

I've done this for just submissions instead of all dma_sync_resv
users as there are some that need to wait for BOOKKEEP fences, at
least for now, like the VM update operations.

(Yes, I know there is a series to make VM updates less implicit,
 which currently works through AMDGPU_SYNC_EQ_OWNER/EXPLICIT. I
 think this doesn't conflict and would like to leave the VM side
 out of it as much as possible in this series to land something
 to resolve some radv/radeonsi issues for cross process sharing)

Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index a578da8e2da5..b4f55f40ce0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1199,7 +1199,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 		sync_mode = amdgpu_bo_explicit_sync(bo) ?
 			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
 		r = amdgpu_sync_resv(p->adev, &p->sync, resv,
-				     DMA_RESV_USAGE_BOOKKEEP, sync_mode,
+				     DMA_RESV_USAGE_READ, sync_mode,
 				     &fpriv->vm);
 		if (r)
 			return r;
-- 
2.45.2

