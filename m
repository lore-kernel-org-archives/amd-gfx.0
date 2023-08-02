Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8366BC04FE1
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 07:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C59010E502;
	Wed,  2 Aug 2023 07:20:18 +0000 (UTC)
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com
 [115.124.28.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9533410E4A5;
 Wed,  2 Aug 2023 06:46:19 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.4706627|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0490271-0.00171531-0.949258; FP=0|0|0|0|0|-1|-1|-1;
 HT=ay29a033018047202; MF=sunran001@208suo.com; NM=1; PH=DS; RN=5; RT=5; SR=0;
 TI=SMTPD_---.U6Z6Jsd_1690958768; 
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com
 fp:SMTPD_---.U6Z6Jsd_1690958768) by smtp.aliyun-inc.com;
 Wed, 02 Aug 2023 14:46:09 +0800
From: Ran Sun <sunran001@208suo.com>
To: alexander.deucher@amd.com
Subject: [PATCH] drm/amdgpu: Clean up errors in vega20_ih.c
Date: Wed,  2 Aug 2023 06:46:06 +0000
Message-Id: <20230802064606.12005-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Wed, 02 Aug 2023 07:20:04 +0000
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

ERROR: trailing statements should be on next line
ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 544ee55a22da..dbc99536440f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -500,7 +500,8 @@ static int vega20_ih_self_irq(struct amdgpu_device *adev,
 	case 2:
 		schedule_work(&adev->irq.ih2_work);
 		break;
-	default: break;
+	default:
+		break;
 	}
 	return 0;
 }
@@ -710,8 +711,7 @@ static void vega20_ih_set_interrupt_funcs(struct amdgpu_device *adev)
 	adev->irq.ih_funcs = &vega20_ih_funcs;
 }
 
-const struct amdgpu_ip_block_version vega20_ih_ip_block =
-{
+const struct amdgpu_ip_block_version vega20_ih_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_IH,
 	.major = 4,
 	.minor = 2,
-- 
2.17.1

