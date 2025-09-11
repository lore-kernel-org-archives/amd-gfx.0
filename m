Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BE8CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 11:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A987710EAC4;
	Thu, 11 Sep 2025 11:42:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gkCn7QKu";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C20C10E0D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bcS8fEt+fhnlZISfdxIgzaGM6+MQglviE6Pl0JYJMPk=; b=gkCn7QKus5a3HQ1RaUOMsEFv4Z
 Z0Nh44Pw7x4E6vpiA4DfqhbWgvd2luh221cZNbo0ys6irXd8RjPoW9wewMcjAa/saE64xRKO3OSMi
 RzNsDwUs5uuPJ5uIBZ2DJKQqcc/QJj6VgyVpn7I2JyTt4hsx1MYOUaDxgJwilxKXaILaPa8xa3Jxx
 0UfU/PW1jByuy+6rCt8iEYkuuxJDSXl/tZGaOfdW5MTwW0BrSULTeqDx0TFBPA1i19w36ib6yyzMa
 6dJFUmGhC11TchlqqS65Mxacb+w+ZVc17Bp8XccHmV0lzi4r7MvJFWVTOcfhHzhTQtaUoZSTVVnpO
 qsDmUpEQ==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwfgp-009n2U-0e; Thu, 11 Sep 2025 13:42:11 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 01/16] drm/amdgpu: Use memset32 for IB padding
Date: Thu, 11 Sep 2025 12:41:40 +0100
Message-ID: <20250911114155.24786-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250911114155.24786-1-tvrtko.ursulin@igalia.com>
References: <20250911114155.24786-1-tvrtko.ursulin@igalia.com>
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

Use memset32 instead of open coding it, just because it is
that bit nicer.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 6379bb25bf5c..0918d832da94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -159,8 +159,16 @@ void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
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
2.48.0

