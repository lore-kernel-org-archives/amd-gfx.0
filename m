Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A83CA1016
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 11:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BE4510EAD3;
	Thu, 11 Sep 2025 11:42:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jjv06rjo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E60C110EAD2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 11:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pDe88f0o5Z3exyJdzf56CA5i5h/+E72YTOICai1a/UI=; b=jjv06rjoveJ10M/hmR+C7xJMcQ
 DGRF/Ms0Dnd5ISzMX/z6/7+ca2N5nVuVC+Tw/leUGe42Ihr7QYY2/XplU6cYOLGZgC0bAfXxZC2X5
 8mzGkM50+wUVdGIVIdA9WnVM8uWVNWbi6v859hrSlrrVUCzzUGsMqtud3+U1vDi/KqDNiX0X0hEtc
 Ajjyd5o5iFk4lML+jhlhFM1zeX8JThfS6AiPY9oqjRyp7aTLO6foOLRijf3GOomO5+lUd2+zc0Z1a
 NJtiDKTB4ZTeAjoQh7tsnBOd7wGc/skk0MHTEJhBuGrUHGXgQlYht8KX/E2uZKMHvPeFPGf/dBMlC
 LbDQdP1Q==;
Received: from [84.66.36.92] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uwfgu-009n2o-I1; Thu, 11 Sep 2025 13:42:16 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 04/16] drm/amdgpu: More compact UVD 6 IB emission
Date: Thu, 11 Sep 2025 12:41:43 +0100
Message-ID: <20250911114155.24786-5-tvrtko.ursulin@igalia.com>
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

Avoid constant register reloads while emitting IBs by using a local write
pointer and only updating the size at the end of each helper.uvd 6

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 66 +++++++++++++++------------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index ceb94bbb03a4..815952ccccf0 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -214,6 +214,7 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint64_t addr;
+	u32 *ptr;
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
@@ -223,27 +224,29 @@ static int uvd_v6_0_enc_get_create_msg(struct amdgpu_ring *ring, uint32_t handle
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
+
+	ib->length_dw = ptr - ib->ptr;
 
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+		*ptr++ = 0x0;
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r)
@@ -279,6 +282,7 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
 	struct amdgpu_ib *ib;
 	struct dma_fence *f = NULL;
 	uint64_t addr;
+	u32 *ptr;
 	int i, r;
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw * 4,
@@ -288,27 +292,29 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu_ring *ring,
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
+
+	ib->length_dw = ptr - ib->ptr;
 
 	for (i = ib->length_dw; i < ib_size_dw; ++i)
-		ib->ptr[i] = 0x0;
+		*ptr++ = 0x0;
 
 	r = amdgpu_job_submit_direct(job, ring, &f);
 	if (r)
-- 
2.48.0

