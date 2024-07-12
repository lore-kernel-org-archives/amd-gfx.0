Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29268C3DA45
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 15:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF6C510ED2A;
	Fri, 12 Jul 2024 15:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dr9+qahs";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 068EB10ED2B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BwMmDtFzcM2KhLLH1pEmoYNIgUq2n4ZObwFzcn32rtQ=; b=dr9+qahsrUZq7fI+VFXsHUlc+r
 whNEzpldLtF7UoTNDgucUtVN0ZsTqbHfGRB6Zi5DAgJJdqqgqvDqfBACUlogt9NUkSU3g47PyxRut
 JuEl340t84nWYV0ru6BFlP/UvOCIg+nHIXgOtQfpqgoJQiDJH686Rs0uLViEHoAqQUET9PVJOtFQU
 dyhWcg1nbzTrS1NoZd7RjnktK3gyG5yMbSm6NAkjaS3DPAau+tjzzWnJfseLggeO7pODDuFiqzk+e
 UnPaAfx3lEVPDVeI8/yKdr6m1mErsjCzwIJ/RIRU8ymvK2G1CJ2Qa9E6e6nZFywHzRZC08x1Xlx+b
 rNVZQB0A==;
Received: from [84.69.19.168] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sSICg-00ENIs-8x; Fri, 12 Jul 2024 17:28:58 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 1/3] drm/amdpgu: Micro-optimise amdgpu_ring_commit
Date: Fri, 12 Jul 2024 16:28:53 +0100
Message-ID: <20240712152855.45284-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240712152855.45284-1-tursulin@igalia.com>
References: <20240712152855.45284-1-tursulin@igalia.com>
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

For some value of optimisation we can replace the division with an
bitwise and. And it even shrinks the code. Before:

     6c9:       53                      push   %rbx
     6ca:       4c 8b 47 08             mov    0x8(%rdi),%r8
     6ce:       31 d2                   xor    %edx,%edx
     6d0:       48 89 fb                mov    %rdi,%rbx
     6d3:       8b 87 c8 05 00 00       mov    0x5c8(%rdi),%eax
     6d9:       41 8b 48 04             mov    0x4(%r8),%ecx
     6dd:       f7 d0                   not    %eax
     6df:       21 c8                   and    %ecx,%eax
     6e1:       83 c1 01                add    $0x1,%ecx
     6e4:       83 c0 01                add    $0x1,%eax
     6e7:       f7 f1                   div    %ecx
     6e9:       89 d6                   mov    %edx,%esi
     6eb:       41 ff 90 88 00 00 00    call   *0x88(%r8)

After:

     6c9:       53                      push   %rbx
     6ca:       48 8b 57 08             mov    0x8(%rdi),%rdx
     6ce:       48 89 fb                mov    %rdi,%rbx
     6d1:       8b 87 c8 05 00 00       mov    0x5c8(%rdi),%eax
     6d7:       8b 72 04                mov    0x4(%rdx),%esi
     6da:       f7 d0                   not    %eax
     6dc:       21 f0                   and    %esi,%eax
     6de:       83 c0 01                add    $0x1,%eax
     6e1:       21 c6                   and    %eax,%esi
     6e3:       ff 92 88 00 00 00       call   *0x88(%rdx)

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <ckoenig.leichtzumerken@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index ad49cecb20b8..1a1963318424 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -144,7 +144,7 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
 	/* We pad to match fetch size */
 	count = ring->funcs->align_mask + 1 -
 		(ring->wptr & ring->funcs->align_mask);
-	count %= ring->funcs->align_mask + 1;
+	count &= ring->funcs->align_mask;
 	ring->funcs->insert_nop(ring, count);
 
 	mb();
-- 
2.44.0

