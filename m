Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC0CCCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C142110E5FD;
	Tue,  4 Nov 2025 14:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="bGpy0WJ/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555B110E5FE
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qMcrVmwjeF0GyptMQ2zLORfiPfflCxR224mYB2ru774=; b=bGpy0WJ/EncuzfjUcTmq2CkMXe
 +/O90UNgKdROZjDkCDJ7tMot8fXDDwqcMTDGKEK57lOjwcb4EMds6zal3z+1T+mWxTOMnPvzvMS/X
 mHU3eTdCfkxBHe0t7sscPq8nFE4O4ooFBHnY3a1J0RZqovQlLFJ1oyEd594zXbOkgrx2C5b8YdVbM
 fplw7LFdO1uN26W9eS0YSnKaj+9yWRIe/HvGPYFlkz0mdc7d91GBgcZ13xCBoIdosRt6Sglupd+gk
 vb8kCnZiWcFt7wgYzxs6x8lNStS89IMr1FwYYbYG3gFIP+AfcCattkmDbz3lXDSzopEUut7p/8FZe
 36BmqipA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHgF-001OFw-Jx; Tue, 04 Nov 2025 15:06:39 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 13/25] drm/amdgpu: More compact UVD 6 IB emission
Date: Tue,  4 Nov 2025 14:04:09 +0000
Message-ID: <20251104140421.88520-14-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
References: <20251104140421.88520-1-tvrtko.ursulin@igalia.com>
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

Avoid constant register reloads while emitting IBs by using a local write
pointer and only updating the size at the end of each helper.uvd 6

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 72 ++++++++++++++-------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index ceb94bbb03a4..0175bdae6f5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -214,7 +214,8 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint64_t addr;
-	int i, r;
+	u32 *ptr;
+	int r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
 				     AMDGPU_IB_POOL_DIRECT, &job,
@@ -223,27 +224,28 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 		return r;
 
 	ib = &job->ibs[0];
+	ptr = ib->ptr;
 	addr = amdgpu_bo_gpu_offset(bo);
 
-	ib->length_dw = 0;
-	ib->ptr[ib->length_dw++] = 0x00000018;
-	ib->ptr[ib->length_dw++] = 0x00000001; /* session info */
-	ib->ptr[ib->length_dw++] = handle;
-	ib->ptr[ib->length_dw++] = 0x00010000;
-	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
-	ib->ptr[ib->length_dw++] = addr;
+	*ptr++ = 0x00000018;
+	*ptr++ = 0x00000001; /* session info */
+	*ptr++ = handle;
+	*ptr++ = 0x00010000;
+	*ptr++ = upper_32_bits(addr);
+	*ptr++ = addr;
 
-	ib->ptr[ib->length_dw++] = 0x00000014;
-	ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
-	ib->ptr[ib->length_dw++] = 0x0000001c;
-	ib->ptr[ib->length_dw++] = 0x00000001;
-	ib->ptr[ib->length_dw++] = 0x00000000;
+	*ptr++ = 0x00000014;
+	*ptr++ = 0x00000002; /* task info */
+	*ptr++ = 0x0000001c;
+	*ptr++ = 0x00000001;
+	*ptr++ = 0x00000000;
 
-	ib->ptr[ib->length_dw++] = 0x00000008;
-	ib->ptr[ib->length_dw++] = 0x08000001; /* op initialize */
+	*ptr++ = 0x00000008;
+	*ptr++ = 0x08000001; /* op initialize */
 
-	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+	ib->length_dw = ptr - ib->ptr;
+
+	memset32(ptr, 0, ib_size_dw - ib->length_dw);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r)
@@ -279,7 +281,8 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint64_t addr;
-	int i, r;
+	u32 *ptr;
+	int r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
 				     AMDGPU_IB_POOL_DIRECT, &job,
@@ -288,27 +291,28 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
 		return r;
 
 	ib = &job->ibs[0];
+	ptr = ib->ptr;
 	addr = amdgpu_bo_gpu_offset(bo);
 
-	ib->length_dw = 0;
-	ib->ptr[ib->length_dw++] = 0x00000018;
-	ib->ptr[ib->length_dw++] = 0x00000001; /* session info */
-	ib->ptr[ib->length_dw++] = handle;
-	ib->ptr[ib->length_dw++] = 0x00010000;
-	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
-	ib->ptr[ib->length_dw++] = addr;
+	*ptr++ = 0x00000018;
+	*ptr++ = 0x00000001; /* session info */
+	*ptr++ = handle;
+	*ptr++ = 0x00010000;
+	*ptr++ = upper_32_bits(addr);
+	*ptr++ = addr;
 
-	ib->ptr[ib->length_dw++] = 0x00000014;
-	ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
-	ib->ptr[ib->length_dw++] = 0x0000001c;
-	ib->ptr[ib->length_dw++] = 0x00000001;
-	ib->ptr[ib->length_dw++] = 0x00000000;
+	*ptr++ = 0x00000014;
+	*ptr++ = 0x00000002; /* task info */
+	*ptr++ = 0x0000001c;
+	*ptr++ = 0x00000001;
+	*ptr++ = 0x00000000;
 
-	ib->ptr[ib->length_dw++] = 0x00000008;
-	ib->ptr[ib->length_dw++] = 0x08000002; /* op close session */
+	*ptr++ = 0x00000008;
+	*ptr++ = 0x08000002; /* op close session */
 
-	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+	ib->length_dw = ptr - ib->ptr;
+
+	memset32(ptr, 0, ib_size_dw - ib->length_dw);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r)
-- 
2.48.0

