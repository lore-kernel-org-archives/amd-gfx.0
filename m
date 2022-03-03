Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5359C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 02:28:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5C510EA01;
	Thu,  3 Mar 2022 02:28:35 +0000 (UTC)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73F4910E2D0;
 Thu,  3 Mar 2022 01:52:20 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=yang.lee@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0V64pKc2_1646272336; 
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0V64pKc2_1646272336) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 03 Mar 2022 09:52:17 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: airlied@linux.ie
Subject: [PATCH -next] drm/amdgpu: clean up some inconsistent indenting
Date: Thu,  3 Mar 2022 09:52:15 +0800
Message-Id: <20220303015215.92536-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Mar 2022 02:28:33 +0000
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
Cc: Xinhui.Pan@amd.com, Abaci Robot <abaci@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Yang Li <yang.lee@linux.alibaba.com>, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Eliminate the follow smatch warning:
drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:413 amdgpu_get_xgmi_hive()
warn: inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 91817a31f3e1..4ff6e06babca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -410,14 +410,14 @@ struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev)
 	 */
 	if (adev->reset_domain->type != XGMI_HIVE) {
 		hive->reset_domain = amdgpu_reset_create_reset_domain(XGMI_HIVE, "amdgpu-reset-hive");
-			if (!hive->reset_domain) {
-				dev_err(adev->dev, "XGMI: failed initializing reset domain for xgmi hive\n");
-				ret = -ENOMEM;
-				kobject_put(&hive->kobj);
-				kfree(hive);
-				hive = NULL;
-				goto pro_end;
-			}
+		if (!hive->reset_domain) {
+			dev_err(adev->dev, "XGMI: failed initializing reset domain for xgmi hive\n");
+			ret = -ENOMEM;
+			kobject_put(&hive->kobj);
+			kfree(hive);
+			hive = NULL;
+			goto pro_end;
+		}
 	} else {
 		amdgpu_reset_get_reset_domain(adev->reset_domain);
 		hive->reset_domain = adev->reset_domain;
-- 
2.20.1.7.g153144c

