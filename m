Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3471BC001DF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 07:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300DE10E5B4;
	Thu,  3 Aug 2023 07:25:07 +0000 (UTC)
Received: from out28-112.mail.aliyun.com (out28-112.mail.aliyun.com
 [115.124.28.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73D6F10E50E;
 Wed,  2 Aug 2023 07:28:22 +0000 (UTC)
X-Alimail-AntiSpam: AC=SUSPECT; BC=0.6037459|-1; BR=01201311R621b1; CH=blue;
 DM=|SUSPECT|false|; DS=CONTINUE|ham_alarm|0.161814-0.00328592-0.8349;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047193; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6biHA-_1690961293; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6biHA-_1690961293) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 15:28:15 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_ring.h
Date: Wed,  2 Aug 2023 07:28:13 +0000
Message-Id: <20230802072813.13252-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Thu, 03 Aug 2023 07:25:02 +0000
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
Cc: Ran Sun <sunran001@208suo.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: spaces required around that ':' (ctx:VxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 028ff075db51..e2ab303ad270 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -389,7 +389,7 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	occupied = ring->wptr & ring->buf_mask;
 	dst = (void *)&ring->ring[occupied];
 	chunk1 = ring->buf_mask + 1 - occupied;
-	chunk1 = (chunk1 >= count_dw) ? count_dw: chunk1;
+	chunk1 = (chunk1 >= count_dw) ? count_dw : chunk1;
 	chunk2 = count_dw - chunk1;
 	chunk1 <<= 2;
 	chunk2 <<= 2;
-- 
2.17.1

