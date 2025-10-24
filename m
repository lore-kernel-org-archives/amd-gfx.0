Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BF3CCD1BF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Oct 2025 16:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4855610EB18;
	Fri, 24 Oct 2025 16:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="U/0z5f4q";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3E310EB18
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 16:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LvDXLFqekXWxtjxJIkUlc5HICvoFg+nF9wEslaMbKis=; b=U/0z5f4q76qefTAYrXYieh+6GI
 NRdpYfASVybF21P3Z+hxoQI2Gtn0Jmj1TiJ6nWlXp1O7pLqMw4CM54vBbgrC7bxcGt183zhxBmDGN
 nnZPIRVDo1OaiYBcwKJO/zUgENClwQ4OQZWjB1bzMSSU1sStfZt2uzJNw8/fSzxvwr9T9yg6P+FOD
 qaDEa0b/RqBjC4w4erAWN5GVs1B0UNbe8d6ejWC5fPKaIJ2xmbU0yShVoAuTNfh2Z4AnnWcCo87Bi
 ZKruT1t+qgEXXv2vbUgR1mWtMSht2NiRyNCYqnwsBFU5JYSJ4bMK2xBUpM/aIC5yTnr9cN4sYkz3A
 sc3EDrlQ==;
Received: from [90.242.12.242] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vCKxj-00EpxU-Ur; Fri, 24 Oct 2025 18:48:24 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu: Fixup VCN IB emission
Date: Fri, 24 Oct 2025 17:48:14 +0100
Message-ID: <20251024164814.80558-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
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

A mistake crept in
commit [SHA TBD]

After the VCN unified header is emitted the rest of the commands must not
overwrite them but append to the buffer.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexdeucher@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 2295578d6330..8f75cfe3239f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -815,7 +815,7 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 		goto err;
 
 	ib = &job->ibs[0];
-	ptr = ib->ptr;
+	ib->length_dw = 0;
 
 	/* single queue headers */
 	if (adev->vcn.inst[ring->me].using_unified_queue) {
@@ -824,6 +824,8 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, ib_pack_in_dw, false);
 	}
 
+	ptr = &ib->ptr[ib->length_dw];
+
 	*ptr++ = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
 	*ptr++ = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
 	decode_buffer = (struct amdgpu_vcn_decode_buffer *)ptr;
@@ -947,12 +949,14 @@ static int amdgpu_vcn_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 		return r;
 
 	ib = &job->ibs[0];
-	ptr = ib->ptr;
+	ib->length_dw = 0;
 	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
+	ptr = &ib->ptr[ib->length_dw];
+
 	*ptr++ = 0x00000018;
 	*ptr++ = 0x00000001; /* session info */
 	*ptr++ = handle;
@@ -1016,12 +1020,14 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 		return r;
 
 	ib = &job->ibs[0];
-	ptr = ib->ptr;
+	ib->length_dw = 0;
 	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg->gpu_addr);
 
 	if (adev->vcn.inst[ring->me].using_unified_queue)
 		ib_checksum = amdgpu_vcn_unified_ring_ib_header(ib, 0x11, true);
 
+	ptr = &ib->ptr[ib->length_dw];
+
 	*ptr++ = 0x00000018;
 	*ptr++ = 0x00000001;
 	*ptr++ = handle;
-- 
2.48.0

