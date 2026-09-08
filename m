Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9686DC79F9E
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 18:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A58810ED0B;
	Tue,  8 Sep 2026 18:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lszKTBYE";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3CB810ED0B
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 18:11:13 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49b965570d7so56134175e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891072; x=1789495872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=abVFcV/MoCCd584KAPOCxJLPc1pWzvQXsvqhVcTMFmE=;
 b=lszKTBYE4Bc88RmwjVxSpT+Esn+9vS3l3tiQTaK36Lv0cFeCpBgELQeX2nvy/Y9Izm
 kbLBXRXOj+fi1UwSCm9gWqqpu0lqsLraVQEgFpNbXXo1u+KpGU+jj1+CqumihqbBOq1e
 eXSHqkZn+XrzymS9pDKSQmLAKmlINEbaruqYQMNTViU841uXgEbZioeqqxUyP0L8OoPC
 WqBbL5hittlMWj87KWgRo9o+xEiFyt0g6O1odxYyGD9Q5L7s64NeieUFdjn9K7ATa+kk
 cXKyWRhYKRLALErQYZEUEBB1ucFLfeTYD8h/ulaLUWB8PN9Ay/rKP4VPC/kjiZGh5RVD
 c6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891072; x=1789495872;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=abVFcV/MoCCd584KAPOCxJLPc1pWzvQXsvqhVcTMFmE=;
 b=EBPBpZm49WEHQ3cfOfleFGI6fHuR1zVFOMLr+HDMLruqmzLz1jYpjXGv76JUO7COeN
 cPrWMC07KibB/6ScWvE4QX5Jn7FwSfZSt5L75A3r9xTegztl/qFuuU+on9CoFg39e4Eq
 zOrTylDXEmEjj91Q0d+jWSsTyzwkq1SOwHThw5vTQnSbGizb+lfG6fO0FfkD6x9ha4Ex
 7hZycry6bqJS9v2KjjXJpuOpshc23wpuPe5QfxdPzx1Og/M2fuOhyRiKN52aaRxDm+3B
 6DUO+nvdmb3u7QsppEmFxmNyw2PRwkSYgGosa+k0ouH7WLPIA9vmuEzgDuf3j5pQMpJW
 bCGQ==
X-Gm-Message-State: AFuF++mcQW8bkeIWqf2GFsYNe2NXoKk8BbtsINi1E5eAX7F1FAJ+GwfA
 5N8ESMnDg48rlIItsQaaHB31dATG0ERP0wUEZvuUHAKJ9wnlqXG1bzQWLx6hBfVO
X-Gm-Gg: AYBFou2Q92o/ctXHJuowd80Zmg7S2HRD0bxOBAc7is6y30q2CF+LlU1CqKpjsCO7+Pt
 e/ZR3EBULZZUQ3D1tgWodNxaHZ19m/78JXdQsHUeSSh5RxoPZLBfxGaWV2SBqNOibeOftSJJt8c
 GrWqX6HDyri7o3m412/6ND0JDfP3cSGC9S4Nr/hEBJ4rHRTEWd63ZatL7kRpfEO+yGrucrLne5v
 ZfgLf1EhwlNizXn4VafOjOtc1VZxYb7PSJGuziLgz1oFi5HaJA6NnCWxcOB8wH16THzhqajDYXO
 ou4ahARfNOHNN9PsAgjQj9kJRMmlFZP4ju2KyXWyaMPJ4brCTHZgdRS72BU4hVBv25ZLPnPCyEg
 4ZqjnQ1fe4xeT3eM51GqF4cXm79mmDFzFJa1jH6V27S6NRC+1vG1coGdGAoAhG9oKeW+chrQquh
 vtYc60IhrOiLZW3Y3FJUbzC8CMHM89PdeULuLsW59Ga0ZzVuzHXflZ4LAV3e+YpAaaw6s6UAqqW
 H2T15+j1oP2QqMy+DqB
X-Received: by 2002:a05:600c:138a:b0:49c:fc6e:8cba with SMTP id
 5b1f17b1804b1-49cfc6e8e34mr281490835e9.30.1788891071869; 
 Tue, 08 Sep 2026 11:11:11 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e4e4sm5190125e9.2.2026.09.08.11.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:11:11 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/9] drm/amdgpu: Add amdgpu_ring_clear_ring_and_ptrs()
Date: Tue,  8 Sep 2026 20:10:48 +0200
Message-ID: <20260908181052.381126-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908181052.381126-1-timur.kristof@gmail.com>
References: <20260908181052.381126-1-timur.kristof@gmail.com>
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

A new helper function which clears the contents of
a ring and the relevant pointers such as rptr/wptr.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 61e30de1977b..49df2c4745a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -488,6 +488,25 @@ static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
 	memset32(ring->ring, ring->funcs->nop, ring->buf_mask + 1);
 }
 
+static inline void amdgpu_ring_clear_ring_and_ptrs(struct amdgpu_ring *ring)
+{
+	/* Clear the contents of the ring. */
+	amdgpu_ring_clear_ring(ring);
+
+	/* Clear the ring pointers on the CPU. */
+	ring->wptr = 0;
+
+	/*
+	 * Clear the ring pointers allocated in writeback.
+	 *
+	 * Note: we always allocate 64 bits for these pointers,
+	 * but older HW generations only use the lower 32 bits.
+	 * Use 64-bit atomics for simplicity.
+	 */
+	atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+	atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
+}
+
 static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
 {
 	ring->ring[ring->wptr++ & ring->buf_mask] = v;
-- 
2.55.0

