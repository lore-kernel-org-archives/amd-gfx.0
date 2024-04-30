Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D169BC10F16
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 17:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63E76112D67;
	Tue, 30 Apr 2024 17:27:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QjtfZvYs";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DECC1112D66
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KdqmLEvOw5rHEZhdUab0OUgKaAtj5t98U4JWtQamQ6U=; b=QjtfZvYszUOeB2jSYkSGSYwpkj
 zE4lp22xamzfTvc7ZQzATZaoUzHEfrVRAQmM7708UlSh6X0gZUuIV2sMJhO+z8wa/Qs8XiqarY65q
 qBjRS6AHVtR8PSnwVoZqkH3RR6bsKYuZ4bdystF4xbwBqclj/W6xxY5LVCU3vDKwPFYxKofUj6deV
 T5TMZr3qk0ntQe81u99ZdEsGdTHXd45JCjEsokiw5daU8KLeECkNVyHU6BPIknQUWN6FYXU2DnLm/
 SBOVAB7nI13qbe5Lcds7h6Zxrcw6HzmD+5lQFUGbh2cxgsy9V/RAYh4FUYqzHjmmp3XurJFfL1Cye
 Ix+sT+MA==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s1rGj-001sRS-CQ; Tue, 30 Apr 2024 19:27:53 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [RFC 1/5] drm/amdgpu: Cache number of rings per hw ip type
Date: Tue, 30 Apr 2024 18:27:44 +0100
Message-ID: <20240430172748.61576-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430172748.61576-1-tursulin@igalia.com>
References: <20240430172748.61576-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

With the end goal being using the number of rings for exposing capacity in
fdinfo, and the observation that the number could be used elsewhere in the
driver, lets cache it during the driver init phase.

We count the number of created scheduler instances for user visible hw ip
block types, which correspond with the number of user visible rings.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index f87d53e183c3..4f394602bbd8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -964,6 +964,7 @@ struct amdgpu_device {
 	/* rings */
 	u64				fence_context;
 	unsigned			num_rings;
+	unsigned			num_ip_rings[AMDGPU_HW_IP_NUM];
 	struct amdgpu_ring		*rings[AMDGPU_MAX_RINGS];
 	struct dma_fence __rcu		*gang_submit;
 	bool				ib_pool_ready;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 861ccff78af9..e421f352d77e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2756,6 +2756,20 @@ static int amdgpu_device_init_schedulers(struct amdgpu_device *adev)
 				  ring->name);
 			return r;
 		}
+
+		BUILD_BUG_ON(AMDGPU_RING_TYPE_GFX	!= AMDGPU_HW_IP_GFX);
+		BUILD_BUG_ON(AMDGPU_RING_TYPE_COMPUTE	!= AMDGPU_HW_IP_COMPUTE);
+		BUILD_BUG_ON(AMDGPU_RING_TYPE_SDMA	!= AMDGPU_HW_IP_DMA);
+		BUILD_BUG_ON(AMDGPU_RING_TYPE_UVD	!= AMDGPU_HW_IP_UVD);
+		BUILD_BUG_ON(AMDGPU_RING_TYPE_VCE	!= AMDGPU_HW_IP_VCE);
+		BUILD_BUG_ON(AMDGPU_RING_TYPE_UVD_ENC	!= AMDGPU_HW_IP_UVD_ENC);
+		BUILD_BUG_ON(AMDGPU_RING_TYPE_VCN_DEC	!= AMDGPU_HW_IP_VCN_DEC);
+		BUILD_BUG_ON(AMDGPU_RING_TYPE_VCN_ENC	!= AMDGPU_HW_IP_VCN_ENC);
+		BUILD_BUG_ON(AMDGPU_RING_TYPE_VCN_JPEG	!= AMDGPU_HW_IP_VCN_JPEG);
+		BUILD_BUG_ON(AMDGPU_RING_TYPE_VPE 	!= AMDGPU_HW_IP_VPE);
+
+		if (ring->funcs->type < ARRAY_SIZE(adev->num_ip_rings))
+			adev->num_ip_rings[ring->funcs->type]++;
 	}
 
 	amdgpu_xcp_update_partition_sched_list(adev);
-- 
2.44.0

