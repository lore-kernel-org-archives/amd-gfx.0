Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2707CEFC39
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 18:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C7A10E254;
	Tue,  8 Oct 2024 18:11:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bKIwBSFk";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85BC10E238
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 18:11:37 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-a9982f90e92so16007566b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Oct 2024 11:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728411096; x=1729015896; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ldOZwP/hYUF5WbwPzqJMo7IUkPS3uTcr7bBP4khFx28=;
 b=bKIwBSFkiiARl2G7Y8VWZ/D4CML0NHL2cblRZ6BNuGK7rE3li/ZJ3I7xVZ3wdd9Lxf
 FPBAR3mok9u31+VHO/pHDsOeiUHc0qMovk0TG7mGD2qT/aq4s7yxNpZNEw+avNl9UHMf
 1kUa3gExYp9ljgaBMW6jT7A+AD2yjWxKOq5ArcKRm0B1UQRjVleE1ivtWYeN+Rw+bqbn
 Di4W08iyg42aaeojo2HIwSwm7raLi14G6++wLZ0K2OJ/r3fCMKLJ6qhP+NwFbNhQ3ckK
 YLUlkjsZEhpNjunAgDfTRf3V9gAohLqB5qdPODF+uemtjuHouC0XWYVXAo+kJWAPUC+i
 TuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728411096; x=1729015896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldOZwP/hYUF5WbwPzqJMo7IUkPS3uTcr7bBP4khFx28=;
 b=GlPZr51BoIVCUM0hZS2PNIiIZtkk6xC7Zf8G6r3vUaUpuRLecI2PEIAHxmV7adL3pq
 hQsA7AEoEWN7/3jYV9Mm3EsstbDLH3PC7PqhZ+1o4T+OEKeq0NdNo01cVZpHkBMi+rA7
 qPNLBHw4nf0IcLwSD3m9OxlRomZevEpA895MUOUxBV3JpBufsURimUdJ75PSy5Y/3jwd
 CF9iciUseJaH+evZ7WdGFONGomp669OtpwDVj1S2BiZBVtSLXsBgw7ph9gEMXtBk9DvO
 RaXVDrPBki0nqoCniLlfFkH2SXib3qx6UGfiNz07sL3mOvq51QPK/rvNps1ev/F9TeHi
 OsVw==
X-Gm-Message-State: AOJu0YxzQLrgPldHG5KjetEfPVpbYE9h2mpB08eMUE1Wdo6ROZle+aNe
 4sLqv6FxhQQm2SPRH8VCcv/Z/R6TEClZHwyzEtaisCbCX4CDWa/I2SDd5DXq
X-Google-Smtp-Source: AGHT+IFgTf+vryl5Ms1YdiYbUzsVOSs4UIkaeFYl8eXe/xlsfQbcVI2dUff5OhrEHXnGdsPw+/Isow==
X-Received: by 2002:a17:907:7f12:b0:a99:52c3:e5f8 with SMTP id
 a640c23a62f3a-a998469169fmr107921566b.11.1728411096101; 
 Tue, 08 Oct 2024 11:11:36 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15ee:d600:b61a:9639:f0e8:34b5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a996274deeesm182016866b.103.2024.10.08.11.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 11:11:35 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, tursulin@igalia.com, sunil.khatri@amd.com
Subject: [PATCH 2/2] drm/amdgpu: stop masking the wptr all the time
Date: Tue,  8 Oct 2024 20:11:34 +0200
Message-Id: <20241008181134.1350-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008181134.1350-1-christian.koenig@amd.com>
References: <20241008181134.1350-1-christian.koenig@amd.com>
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

Stop masking the wptr and decrementing the count_dw while writing into
the ring buffer. We can do that all at once while pushing the changes to
the HW.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 11 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index a6e28fe3f8d6..364466d6d3de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -90,12 +90,11 @@ int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned int ndw)
 	if (WARN_ON_ONCE(ndw > ring->max_dw))
 		return -ENOMEM;
 
-	ring->count_dw = ndw;
-	ring->wptr_old = ring->wptr;
-
 	if (ring->funcs->begin_use)
 		ring->funcs->begin_use(ring);
 
+	ring->count_dw = ndw;
+	ring->wptr_old = ring->wptr;
 	return 0;
 }
 
@@ -122,8 +121,6 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 		memset32(ring->ring, ring->funcs->nop, chunk2);
 
 	ring->wptr += count;
-	ring->wptr &= ring->ptr_mask;
-	ring->count_dw -= count;
 }
 
 /**
@@ -153,9 +150,11 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
 {
 	uint32_t count;
 
-	if (ring->count_dw < 0)
+	if ((ring->wptr - ring->wptr_old) > ring->count_dw)
 		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
 
+	ring->wptr &= ring->ptr_mask;
+
 	/* We pad to match fetch size */
 	count = ring->funcs->align_mask + 1 -
 		(ring->wptr & ring->funcs->align_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 36fc9578c53c..439793206b89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -378,8 +378,6 @@ static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
 static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
 {
 	ring->ring[ring->wptr++ & ring->buf_mask] = v;
-	ring->wptr &= ring->ptr_mask;
-	ring->count_dw--;
 }
 
 static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
@@ -403,8 +401,6 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	}
 
 	ring->wptr += count_dw;
-	ring->wptr &= ring->ptr_mask;
-	ring->count_dw -= count_dw;
 }
 
 /**
-- 
2.34.1

