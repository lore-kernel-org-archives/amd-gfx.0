Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68953CA0EE6
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Aug 2025 16:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48EDD10E3A5;
	Sat, 16 Aug 2025 16:28:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cDIX6VHo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB3D10E3A8
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Aug 2025 16:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/pgXzKhPk0r5dnr0dHj74Ylt3y2uGWyJPBRUlw5w31w=; b=cDIX6VHoray7KSL4ErUeAc5N3q
 xr4k3qf2VPzmQ7V1VkgCw0Pb6Q+Vv5ZkZST1Nt/BhTNtwXylUcEufIWw3z1UgrcjRZKAazU5UfXb8
 n84eYWYi5DaRFW+b/YS9du4jknBcC4kI04gvWCgoN91iCFLi4dslVF0/GvrTTQyOF/eCKmDyifJHJ
 c0OcIBZAQFligZGi37k9FnQ+kSJT85RcYV/Q1CKgewsk4Du3Gea1G5YMI7NhWhutGgAimlqWb18JL
 zapw2TiVnOUHL/+sXeGIHKVhjakV2Y4yOz35l+WogfY3ee8XRhMjYRGJaDiboHsRA0QQVah42T62F
 5e9hZ/Jg==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1unJlX-00FASr-JA; Sat, 16 Aug 2025 18:28:23 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 James Zhu <James.Zhu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/3] drm/amdgpu/vcn: Use the correct irq for the ring
 initialization
Date: Sat, 16 Aug 2025 10:27:26 -0600
Message-ID: <20250816162806.1301791-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250816162806.1301791-1-siqueira@igalia.com>
References: <20250816162806.1301791-1-siqueira@igalia.com>
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

In the loop that iterates over the different VCN instances from VCN
4.0.3, the same irq source has been passed for different instances.
This commit addresses the issue by adding the missing index to the array
access for the IRQ.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index a63a1e3435ab..018a526a8801 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -212,7 +212,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 
 		ring->vm_hub = AMDGPU_MMHUB0(adev->vcn.inst[i].aid_id);
 		sprintf(ring->name, "vcn_unified_%d", adev->vcn.inst[i].aid_id);
-		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst->irq, 0,
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vcn.inst[i].irq, 0,
 				     AMDGPU_RING_PRIO_DEFAULT,
 				     &adev->vcn.inst[i].sched_score);
 		if (r)
-- 
2.47.2

