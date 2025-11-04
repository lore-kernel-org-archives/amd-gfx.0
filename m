Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12A9CCFA04
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 520A210E5F9;
	Tue,  4 Nov 2025 14:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LHp/oD69";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1708E10E5F1
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s0Xj21aWmCGV2Ea6lieO5rFE0LnFLAbSnlr317nl8vQ=; b=LHp/oD69GBFxTZEkk8jRDNfcW2
 wOMVevDhr57BtP3KbwXomwSkT7Gb4VEdukxSe1hKXB31K6csh97aeQnOBahRLgX0ADs4WIYDOzz+T
 yNndg7vzFKsEs0qeXiYzxIOyWgHqYI78QyVl96JstubUPLHr4Dv0h9jj/yDFXj4YSpDgL9GxefBA/
 TRT1kcoMSU2SlIESdjj61yH/i9pN+CE7l7U/M5bLnIuAZiGfq+ozWdKqYeGY2ytl/INy1Wt6ib5ol
 jgoQF7W18AhWJokftDTT/1QgOQwQtoonC+HoaX8vCDk/sztyQlrs3qJgJqJbn0UGGcmjjmXVjeA1C
 Bgw1CtNw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHgA-001OEh-Bs; Tue, 04 Nov 2025 15:06:34 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 06/25] drm/amdgpu/gfx10.0: More compact reading of wave data
Date: Tue,  4 Nov 2025 14:04:02 +0000
Message-ID: <20251104140421.88520-7-tvrtko.ursulin@igalia.com>
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

Trivial compaction of some repetitive code:

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-216 (-216)
Function                                     old     new   delta
gfx_v10_0_read_wave_data                     580     364    -216
Total: Before=8979233, After=8979017, chg -0.00%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 38 ++++++++++++++------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 4999e57a11df..0ff7a4e1a449 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4497,6 +4497,8 @@ static void wave_read_regs(struct amdgpu_device *adev, uint32_t wave,
 
 static void gfx_v10_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd, uint32_t wave, uint32_t *dst, int *no_fields)
 {
+	u32 *_dst = dst;
+
 	/* in gfx10 the SIMD_ID is specified as part of the INSTANCE
 	 * field when performing a select_se_sh so it should be
 	 * zero here
@@ -4504,23 +4506,25 @@ static void gfx_v10_0_read_wave_data(struct amdgpu_device *adev, uint32_t xcc_id
 	WARN_ON(simd != 0);
 
 	/* type 2 wave data */
-	dst[(*no_fields)++] = 2;
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_STATUS);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_LO);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_HI);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID1);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID2);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_INST_DW0);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_GPR_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_LDS_ALLOC);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_TRAPSTS);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
-	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
+	*dst++ = 2;
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_STATUS);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_LO);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_HI);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID1);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID2);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_INST_DW0);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_GPR_ALLOC);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_LDS_ALLOC);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_TRAPSTS);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
+	*dst++ = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
+
+	*no_fields += _dst - dst;
 }
 
 static void gfx_v10_0_read_wave_sgprs(struct amdgpu_device *adev, uint32_t xcc_id, uint32_t simd,
-- 
2.48.0

