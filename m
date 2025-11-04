Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127F2CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B30710E5FA;
	Tue,  4 Nov 2025 14:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Syg1rPIR";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A95F10E5F5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EgrI1p25oiEy32Vh219CeCvszvGHFqnB7w0UBAEnFfI=; b=Syg1rPIRCoq9ygs1H0w+itJuCf
 KTvBT+o0ULKNU2yhNB3f7e+DuyKSt10dchimtze2b2NUIh7cR7QJKoLe/+BFkmyrU7yBjfKl8ib5W
 MKy1V8zRwkg0m2SjWmg4oOmJ3Ne3wD2g6YngyU/HeQ8XEmA1FIKfLnbzYiS7YXZxvBw7RhEsJOfMp
 Fw2GDlNRxHqL4AfRgCSkmxejWYpfJb7aoqLwwrTFCrrwANFAFvOmrFNKwOiJY4HgkbnEtB6wTyLfe
 vOe+aH4IfxH0OmPV/xJaBo8t0CPVPf9bBWysQVWUd2AjyMsA7ZlIl/hTWxsQN4GYe/vrmh085EGfG
 LceJ/RnQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHgC-001OF5-JX; Tue, 04 Nov 2025 15:06:36 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 09/25] drm/amdgpu/vcn3.0.0: Use local variables more
Date: Tue,  4 Nov 2025 14:04:05 +0000
Message-ID: <20251104140421.88520-10-tvrtko.ursulin@igalia.com>
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

Compact some very long and repetitive lines of code by caching the
respective object in local variables. This is a concept which is already
used at places, but not consistently so.

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-27 (-27)
Function                                     old     new   delta
vcn_v3_0_ring_patch_cs_in_place              987     960     -27
Total: Before=8977359, After=8977332, chg -0.00%

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 3ee79a44ee40..414fd644fe26 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1991,6 +1991,8 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_ib *ib)
 {
 	struct amdgpu_ring *ring = amdgpu_job_ring(job);
+	struct amdgpu_vcn_reg *internal =
+		&ring->adev->vcn.inst[ring->me].internal;
 	uint32_t msg_lo = 0, msg_hi = 0;
 	unsigned i;
 	int r;
@@ -2003,11 +2005,11 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 		uint32_t reg = amdgpu_ib_get_value(ib, i);
 		uint32_t val = amdgpu_ib_get_value(ib, i + 1);
 
-		if (reg == PACKET0(p->adev->vcn.inst[ring->me].internal.data0, 0)) {
+		if (reg == PACKET0(internal->data0, 0)) {
 			msg_lo = val;
-		} else if (reg == PACKET0(p->adev->vcn.inst[ring->me].internal.data1, 0)) {
+		} else if (reg == PACKET0(internal->data1, 0)) {
 			msg_hi = val;
-		} else if (reg == PACKET0(p->adev->vcn.inst[ring->me].internal.cmd, 0) &&
+		} else if (reg == PACKET0(internal->cmd, 0) &&
 			   val == 0) {
 			r = vcn_v3_0_dec_msg(p, job,
 					     ((u64)msg_hi) << 32 | msg_lo);
-- 
2.48.0

