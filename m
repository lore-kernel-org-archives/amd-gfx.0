Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D215CCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F99810E488;
	Mon, 13 Oct 2025 14:35:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJAm1CB4";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E1410E47F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:14 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-639fe77bb29so6570501a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366113; x=1760970913; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOlOmqRHN76msO6RGrvDtrbpjelQuT0RCQu/MYKK0XQ=;
 b=dJAm1CB4BXcpX8C6YWWit/grs4wO41dkOQFeh1uCJd2DYuLZ6VIIEg6xfmB0Wo8uWu
 1/RoV90KJ56Si/JYDJvp5zSFRDUo6Y4fce4akayd4Q3YdNPMUmvfcysd96YC6QPdrqjP
 GH8G8apZVn7EuW1kg3iX7xF4BtytZRKehA/5c3lQ+TDi31uPaziDYtu5kJ1X8wjvHfm2
 7R4RIbR1SobCMVla2LGZ8VEzme+ffM0JIMPYpM/ax5eh/jB4d9iEOBJ6G6TffYtq1wcy
 FoM0JlyElFAPR6PpZHhdKG8LdsBy63Cs+eVhnMhVrzTXtPU6ItmpeTXe3jqBbWiMqGDQ
 tBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366113; x=1760970913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOlOmqRHN76msO6RGrvDtrbpjelQuT0RCQu/MYKK0XQ=;
 b=nbNlPIYxzEDYkHA3CGHJ4NFwXWYkwLNpV5rnPRGWYGNWSgjk6BT9Yr/QsPh4exyfWo
 Z3BbLpyjWoxZGGs2Ilmb6vUmLOGDxuKECdILSsWNYUnqgQlLeoyG0ajmoR0qB5Mx3hRY
 WY0bHoJ336Ay3mzV34fmlRlAbfFnxhrDJOv0LP5CeUKpPubci96TrEHuCeffHcWtDIDM
 YXxoWm5Sk1TVfKAr0MbDH5oRd2UuXFWNOVXD8wKlaYY/CREIwCTi55kwwcV/Rd02fXWs
 MasKO6IH6f9go8HiNiv2rbSWly5fWWfpG4LCAl8kaKmBxknRyO21Bsx8SpJd4xhqnz6B
 nSqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrIR4Q3rnmaZKbV27bwuZR7yP8MSvr5QxBkUmTomXf1TW12ZZ1/a+O6uQy7iHBqBgSs5LVOrC2@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyq0vFdTNV6I0/RZ8gngXHStsnwAVcgDvh3BjDNXMlNkhVXyO3n
 jT8lUWsSSp4qhMWxM9M6Dgf0/uxDzyoEIzhJ/oWkqwdIczH8fYnxGvDljaLFhg==
X-Gm-Gg: ASbGncvCesktTC/U8K+lBYIKxptCjKXQq2xtef123PTVG7z+wn5AzMSeGvjjrj0RREr
 XlV9bjrvw2O1Dyi7jZu6JXcldxm8tQ1smEDzlsBxEFQ9jCgnXTGiyrcYlIxbBYNuelLFqzgs+tB
 pi3hDA7DyfkjD8zyt4rklNonzdK1L0c5saNimmqA3Rx38VPO5jee3w5iKPkrEmZU7y8MY/22oMp
 3z4Z2mCyBEr2c6pQliIbZ4YTE0x6zZu/1aZDPDxnA3lK/eyJOQNnYOmcQug4O5H1lZkVpMTN1ZF
 v8aHH3U9iQyREMiC93TK7nSYzIvJGI9N/8psPzgN3YDSCfZEMxH6ej0XI8s9RK/ApfxYmgNx4h0
 X1cr3G8wnokkOBGPKBH8jMaZvZxvcFL7cUZlMocTOOU/LEnDEqKROoqk=
X-Google-Smtp-Source: AGHT+IFpybMVN4/LLxPKJ7gzdcaBkTI9O5EugkuBRwCAW1Uu7p4kRusYN46n5y5JAeYhlQjd9UNfKw==
X-Received: by 2002:a05:6402:35cb:b0:634:bb0c:728 with SMTP id
 4fb4d7f45d1cf-639d5c2ae43mr18956170a12.23.1760366113351; 
 Mon, 13 Oct 2025 07:35:13 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/15] drm/amdgpu: independence for the amdgpu_eviction_fence!
Date: Mon, 13 Oct 2025 15:48:39 +0200
Message-ID: <20251013143502.1655-13-christian.koenig@amd.com>
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

This should allow amdgpu_fences to outlive the amdgpu module.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 23d7d0b0d625..95ee22c43ceb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -167,9 +167,8 @@ amdgpu_eviction_fence_create(struct amdgpu_eviction_fence_mgr *evf_mgr)
 
 	ev_fence->evf_mgr = evf_mgr;
 	get_task_comm(ev_fence->timeline_name, current);
-	spin_lock_init(&ev_fence->lock);
 	dma_fence_init64(&ev_fence->base, &amdgpu_eviction_fence_ops,
-			 &ev_fence->lock, evf_mgr->ev_fence_ctx,
+			 NULL, evf_mgr->ev_fence_ctx,
 			 atomic_inc_return(&evf_mgr->ev_fence_seq));
 	return ev_fence;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
index fcd867b7147d..fb70efb54338 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.h
@@ -27,7 +27,6 @@
 
 struct amdgpu_eviction_fence {
 	struct dma_fence base;
-	spinlock_t	 lock;
 	char		 timeline_name[TASK_COMM_LEN];
 	struct amdgpu_eviction_fence_mgr *evf_mgr;
 };
-- 
2.43.0

