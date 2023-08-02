Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8152BC001DF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 07:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B81B10E5A9;
	Thu,  3 Aug 2023 07:25:06 +0000 (UTC)
Received: from out28-91.mail.aliyun.com (out28-91.mail.aliyun.com
 [115.124.28.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E61010E506;
 Wed,  2 Aug 2023 07:24:49 +0000 (UTC)
X-Alimail-AntiSpam: AC=SUSPECT; BC=0.6737961|-1; BR=01201311R121b1; CH=blue;
 DM=|SUSPECT|false|; DS=CONTINUE|ham_alarm|0.0083597-0.000449926-0.99119;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047201; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6bVeRD_1690961081; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6bVeRD_1690961081) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 15:24:43 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in mes_v11_0.c
Date: Wed,  2 Aug 2023 07:24:40 +0000
Message-Id: <20230802072440.13073-1-sunran001@208suo.com>
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

ERROR: else should follow close brace '}'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 11fda318064f..6827d547042e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -788,8 +788,7 @@ static int mes_v11_0_mqd_init(struct amdgpu_ring *ring)
 				    DOORBELL_SOURCE, 0);
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_HIT, 0);
-	}
-	else
+	} else
 		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
 				    DOORBELL_EN, 0);
 	mqd->cp_hqd_pq_doorbell_control = tmp;
-- 
2.17.1

