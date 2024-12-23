Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD48E7718B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2024 16:39:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CCAF10E582;
	Mon, 23 Dec 2024 16:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="lbM+dRFF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E70910E582
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Dec 2024 16:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iD6fWTgz+7D0+HSNP/yTyJ1wRfPXTWbiXiv8YRdH9+E=; b=lbM+dRFFzQV/F2KSHo9cCK/41L
 LQ1WB8yJek+6Ss2EKZ5OdBXSeb1o5VI8x7wDvWuNUJTpRFwIAIQEP+vsOoR8RE2RvQOXstPLaRK45
 IwDry4up7yrKXQPsAWRr2h1Ni6oTPGeOqt/G5lWIaKlh4WkF/lupRkHUII9WhbKqiflZKrKNLa6If
 KAaHA7VMSj9AkDEVGrJlyHS+PLrgPjRaLUm+gyR32VVtLr8tDX1Wc/bJA4TP2S0mVz4+G5vxmDkTk
 XPottJW0l5kBOK367RoNsqEqkFW+cICGRkGbL0/zzdBb/MztWF6FcPPTWbUlkV5obZ4mmz58tzBMm
 2omp+prg==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tPlSp-006tt6-8m; Mon, 23 Dec 2024 17:39:27 +0100
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Use memset32 for padding IB ring
Date: Mon, 23 Dec 2024 16:39:11 +0000
Message-ID: <20241223163913.38767-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223163913.38767-1-tursulin@igalia.com>
References: <20241223163913.38767-1-tursulin@igalia.com>
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

Use memset32 instead of open coding it, just because it is that bit nicer.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index a6e28fe3f8d6..a27e32f48f99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -136,8 +136,16 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
  */
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
-	while (ib->length_dw & ring->funcs->align_mask)
-		ib->ptr[ib->length_dw++] = ring->funcs->nop;
+	u32 align_mask = ring->funcs->align_mask;
+	u32 count = ib->length_dw & align_mask;
+
+	if (count) {
+		count = align_mask + 1 - count;
+
+		memset32(&ib->ptr[ib->length_dw], ring->funcs->nop, count);
+
+		ib->length_dw += count;
+	}
 }
 
 /**
-- 
2.47.1

