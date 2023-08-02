Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407BBC04E69
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Aug 2023 07:25:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C14D10E5B0;
	Thu,  3 Aug 2023 07:25:06 +0000 (UTC)
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com
 [115.124.28.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 255A310E511;
 Wed,  2 Aug 2023 07:35:51 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.6869546|0.7553379; CH=green;
 DM=|SPAM|false|; DS=CONTINUE|ham_alarm|0.0371214-0.00110484-0.961774;
 FP=0|0|0|0|0|-1|-1|-1; HT=ay29a033018047203; MF=sunran001@208suo.com; NM=1;
 PH=DS; RN=5; RT=5; SR=0; TI=SMTPD_---.U6cNhFG_1690961743; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6cNhFG_1690961743) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 15:35:45 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in mxgpu_vi.c
Date: Wed,  2 Aug 2023 07:35:42 +0000
Message-Id: <20230802073542.13515-1-sunran001@208suo.com>
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

ERROR: spaces required around that '-=' (ctx:WxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 288c414babdf..59f53c743362 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -334,7 +334,7 @@ static void xgpu_vi_mailbox_send_ack(struct amdgpu_device *adev)
 			break;
 		}
 		mdelay(1);
-		timeout -=1;
+		timeout -= 1;
 
 		reg = RREG32_NO_KIQ(mmMAILBOX_CONTROL);
 	}
-- 
2.17.1

