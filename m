Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A966ACCFA10
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C1110E600;
	Tue,  4 Nov 2025 14:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BFUhKImu";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25DD10E5FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z8Jq2J31XkeoiuB2pW6siJ620NN4BUmNuakawHTyj9g=; b=BFUhKImuIHuCawULCp5q/Lczo9
 ssfdA2KME99bdQgkXh6uVukFhm2wHouHcdcpxRbrRuYu+/ZvMe4tyXoLGB8kf8UeCV+BsDDXMvOrO
 LbN4jMVu9bDetc2qhS+OmG2SIFHeN3/l4nqdDCnchvBI6Hch1qvMi191aPhTmfBXHi94zyzYHI3Ma
 dFQgPci4qpjzv7AysgEqE/cc/CESQOtx7IkeutskLB/Q+lGiE3u8BHCxHBAB8eMK0wL0dmmFYmOXt
 cUSuoXeDJA3lN8DVwzx6pNsXE6vyI5yKxNvrsrTMmbCQLj7qXl07jsUq7Dhoa82qY6wKsnUuZc663
 8h9YbBsw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHgE-001OFS-3p; Tue, 04 Nov 2025 15:06:38 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 11/25] drm/amdgpu: More compact VCE IB emission
Date: Tue,  4 Nov 2025 14:04:07 +0000
Message-ID: <20251104140421.88520-12-tvrtko.ursulin@igalia.com>
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
pointer and only updating the size at the end of each helper.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 96 +++++++++++++------------
 1 file changed, 50 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index ce318f5de047..62f549dbf827 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -444,7 +444,8 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	struct amdgpu_ib ib_msg;
 	struct dma_fence *f = NULL;
 	uint64_t addr;
-	int i, r;
+	u32 *ptr;
+	int r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
@@ -462,45 +463,46 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 		goto err;
 
 	ib = &job->ibs[0];
+	ptr = ib->ptr;
 	/* let addr point to page boundary */
 	addr = AMDGPU_GPU_PAGE_ALIGN(ib_msg.gpu_addr);
 
 	/* stitch together an VCE create msg */
-	ib->length_dw = 0;
-	ib->ptr[ib->length_dw++] = 0x0000000c; /* len */
-	ib->ptr[ib->length_dw++] = 0x00000001; /* session cmd */
-	ib->ptr[ib->length_dw++] = handle;
+	*ptr++ = 0x0000000c; /* len */
+	*ptr++ = 0x00000001; /* session cmd */
+	*ptr++ = handle;
 
 	if ((ring->adev->vce.fw_version >> 24) >= 52)
-		ib->ptr[ib->length_dw++] = 0x00000040; /* len */
+		*ptr++ = 0x00000040; /* len */
 	else
-		ib->ptr[ib->length_dw++] = 0x00000030; /* len */
-	ib->ptr[ib->length_dw++] = 0x01000001; /* create cmd */
-	ib->ptr[ib->length_dw++] = 0x00000000;
-	ib->ptr[ib->length_dw++] = 0x00000042;
-	ib->ptr[ib->length_dw++] = 0x0000000a;
-	ib->ptr[ib->length_dw++] = 0x00000001;
-	ib->ptr[ib->length_dw++] = 0x00000080;
-	ib->ptr[ib->length_dw++] = 0x00000060;
-	ib->ptr[ib->length_dw++] = 0x00000100;
-	ib->ptr[ib->length_dw++] = 0x00000100;
-	ib->ptr[ib->length_dw++] = 0x0000000c;
-	ib->ptr[ib->length_dw++] = 0x00000000;
+		*ptr++ = 0x00000030; /* len */
+	*ptr++ = 0x01000001; /* create cmd */
+	*ptr++ = 0x00000000;
+	*ptr++ = 0x00000042;
+	*ptr++ = 0x0000000a;
+	*ptr++ = 0x00000001;
+	*ptr++ = 0x00000080;
+	*ptr++ = 0x00000060;
+	*ptr++ = 0x00000100;
+	*ptr++ = 0x00000100;
+	*ptr++ = 0x0000000c;
+	*ptr++ = 0x00000000;
 	if ((ring->adev->vce.fw_version >> 24) >= 52) {
-		ib->ptr[ib->length_dw++] = 0x00000000;
-		ib->ptr[ib->length_dw++] = 0x00000000;
-		ib->ptr[ib->length_dw++] = 0x00000000;
-		ib->ptr[ib->length_dw++] = 0x00000000;
+		*ptr++ = 0x00000000;
+		*ptr++ = 0x00000000;
+		*ptr++ = 0x00000000;
+		*ptr++ = 0x00000000;
 	}
 
-	ib->ptr[ib->length_dw++] = 0x00000014; /* len */
-	ib->ptr[ib->length_dw++] = 0x05000005; /* feedback buffer */
-	ib->ptr[ib->length_dw++] = upper_32_bits(addr);
-	ib->ptr[ib->length_dw++] = addr;
-	ib->ptr[ib->length_dw++] = 0x00000001;
+	*ptr++ = 0x00000014; /* len */
+	*ptr++ = 0x05000005; /* feedback buffer */
+	*ptr++ = upper_32_bits(addr);
+	*ptr++ = addr;
+	*ptr++ = 0x00000001;
 
-	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+	ib->length_dw = ptr - ib->ptr;
+
+	memset32(ptr, 0, ib_size_dw - ib->length_dw);
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
 	amdgpu_ib_free(&ib_msg, f);
@@ -534,7 +536,8 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
-	int i, r;
+	u32 *ptr;
+	int r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
@@ -546,27 +549,28 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 		return r;
 
 	ib = &job->ibs[0];
+	ptr = ib->ptr;
 
 	/* stitch together an VCE destroy msg */
-	ib->length_dw = 0;
-	ib->ptr[ib->length_dw++] = 0x0000000c; /* len */
-	ib->ptr[ib->length_dw++] = 0x00000001; /* session cmd */
-	ib->ptr[ib->length_dw++] = handle;
+	*ptr++ = 0x0000000c; /* len */
+	*ptr++ = 0x00000001; /* session cmd */
+	*ptr++ = handle;
 
-	ib->ptr[ib->length_dw++] = 0x00000020; /* len */
-	ib->ptr[ib->length_dw++] = 0x00000002; /* task info */
-	ib->ptr[ib->length_dw++] = 0xffffffff; /* next task info, set to 0xffffffff if no */
-	ib->ptr[ib->length_dw++] = 0x00000001; /* destroy session */
-	ib->ptr[ib->length_dw++] = 0x00000000;
-	ib->ptr[ib->length_dw++] = 0x00000000;
-	ib->ptr[ib->length_dw++] = 0xffffffff; /* feedback is not needed, set to 0xffffffff and firmware will not output feedback */
-	ib->ptr[ib->length_dw++] = 0x00000000;
+	*ptr++ = 0x00000020; /* len */
+	*ptr++ = 0x00000002; /* task info */
+	*ptr++ = 0xffffffff; /* next task info, set to 0xffffffff if no */
+	*ptr++ = 0x00000001; /* destroy session */
+	*ptr++ = 0x00000000;
+	*ptr++ = 0x00000000;
+	*ptr++ = 0xffffffff; /* feedback is not needed, set to 0xffffffff and firmware will not output feedback */
+	*ptr++ = 0x00000000;
 
-	ib->ptr[ib->length_dw++] = 0x00000008; /* len */
-	ib->ptr[ib->length_dw++] = 0x02000001; /* destroy cmd */
+	*ptr++ = 0x00000008; /* len */
+	*ptr++ = 0x02000001; /* destroy cmd */
 
-	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+	ib->length_dw = ptr - ib->ptr;
+
+	memset32(ptr, 0, ib_size_dw - ib->length_dw);
 
 	if (direct)
 		r = amdgpu_job_submit_direct(job, ring, &f);
-- 
2.48.0

