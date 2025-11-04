Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8065DCCFA06
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 14:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A47E10E5F3;
	Tue,  4 Nov 2025 14:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="UdnlRdIH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214DC10E5E9
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 14:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oKKropakyjJGccPD9QJjegA92U5oN5kwaeBAt0i4480=; b=UdnlRdIHYgisZATApwdYQHWUCa
 bpFuAM+WB7jZ5T04sDfC7ZQ4MkjydTTJNtTb+JpG/4vzqjUHY34jr9VFKEDcHT479u4HW8mspUaoq
 6oxJRPMzuNl5/vG5gIqtQo2OeMWwrIsZGa7/7EF13oYzIEF8fhnaUFm9h/uCEudAG/YWhdR7QkbX4
 u1uovtWIGoHrQr5wdG6dg1LkHtpb2jBExyzjLVrr5rIWGj1F1fHLRvqv2bp0iJu3YNiP3ySXioa5n
 Ey04oLKYm8jKigvpfumDq+N09afXsUtHi2NZmn0xjVIQPohGltKkoVtjcZkb2olgMh6X+AQUadEtL
 vhS54pog==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vGHg6-001OEF-A0; Tue, 04 Nov 2025 15:06:30 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 01/25] drm/amdgpu/vcn4.0.3: Use an existing local variable
Date: Tue,  4 Nov 2025 14:03:57 +0000
Message-ID: <20251104140421.88520-2-tvrtko.ursulin@igalia.com>
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

There is already a cached vcn instance in vcn_v4_0_3_ring_reset() so lets
use it.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index eacf4e93ba2f..627ee85e879f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1619,7 +1619,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (RREG32_SOC15(VCN, GET_INST(VCN, 0), regVCN_RRMT_CNTL) & 0x100)
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
-	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
+	vcn_v4_0_3_start_dpg_mode(vinst, vinst->indirect_sram);
 
 	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
-- 
2.48.0

