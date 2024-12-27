Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358B3E7718F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Dec 2024 11:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D5610E39E;
	Fri, 27 Dec 2024 11:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bBHHnLj7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E237710E3A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mdDmNZjBzxz4iAJUSSeAlfnbig3yygdx6eELhAfypBo=; b=bBHHnLj71I4mZHy9yqp3qIFVmg
 COkndOHjSyXb9HCOs88fhOlCCCUzUfBi5rpCH9ye9PDtlPEsy0Lp17Bo3WqqlwKkmarV9zgxqRGS5
 A+bfe22L1C0dWOlwP5uNVWzd5RjrQFdoVb4LgA9tEsIOyQr0YBWRch5rr4sO7MRSfJCJg40XrA+Ja
 F548QGwEi5075i2G66HsIsnqam3bVzcqD6B7JfFbSx0yjcGzLkkFIjehmS7RSEJUgUGhp1ms+DEGT
 7ouIYHv/FkWc8NERd9Hld5wNnKt4JxRztSdDnuCWqF9NudmOKN+LtLjDGz8nfAAWP4yoLG1DLLvvK
 CnReUj5g==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tR8Nj-008EGG-4G; Fri, 27 Dec 2024 12:19:51 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 02/12] drm/amdgpu: Use memset32 for ring clearing
Date: Fri, 27 Dec 2024 11:19:28 +0000
Message-ID: <20241227111938.22974-3-tursulin@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241227111938.22974-1-tursulin@igalia.com>
References: <20241227111938.22974-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Use memset32 instead of open coding it, just because it is
a tiny bit nicer.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index dee5a1b4e572..96bfc0c23413 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -369,10 +369,7 @@ static inline void amdgpu_ring_set_preempt_cond_exec(struct amdgpu_ring *ring,
 
 static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
 {
-	int i = 0;
-	while (i <= ring->buf_mask)
-		ring->ring[i++] = ring->funcs->nop;
-
+	memset32(ring->ring, ring->funcs->nop, ring->buf_mask + 1);
 }
 
 static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)
-- 
2.47.1

