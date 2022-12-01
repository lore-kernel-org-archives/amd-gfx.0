Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB98C4321E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Dec 2022 03:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37EFD10E533;
	Thu,  1 Dec 2022 03:18:11 +0000 (UTC)
X-Greylist: delayed 462 seconds by postgrey-1.36 at gabe;
 Thu, 01 Dec 2022 02:32:39 UTC
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF7FB10E529
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 02:32:39 +0000 (UTC)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4NN0K26zHKzK8l
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 10:24:54 +0800 (CST)
Received: from mxus.zte.com.cn (unknown [10.207.168.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxde.zte.com.cn (FangMail) with ESMTPS id 4NN0Jm1Gqtz4xD36
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 10:24:40 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxus.zte.com.cn (FangMail) with ESMTPS id 4NN0Jh58Cnz9tyD6
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Dec 2022 10:24:36 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NN0JZ3zMJz4xVnR;
 Thu,  1 Dec 2022 10:24:30 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
 by mse-fl2.zte.com.cn with SMTP id 2B12OKOH091870;
 Thu, 1 Dec 2022 10:24:20 +0800 (+08)
 (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid31;
 Thu, 1 Dec 2022 10:24:21 +0800 (CST)
Date: Thu, 1 Dec 2022 10:24:21 +0800 (CST)
X-Zmail-TransId: 2af963881055fffffffff8fd5203
X-Mailer: Zmail v1.0
Message-ID: <202212011024212258022@zte.com.cn>
Mime-Version: 1.0
From: <ye.xingchen@zte.com.cn>
To: <alexander.deucher@amd.com>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vYW1kZ3B1OiB1c2Ugc3lzZnNfZW1pdCgpIHRvIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B12OKOH091870
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.14.novalocal with ID
 63881075.000 by FangMail milter!
X-FangMail-Envelope: 1669861495/4NN0K26zHKzK8l/63881075.000/10.35.20.165/[10.35.20.165]/mxde.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63881075.000/4NN0K26zHKzK8l
X-Mailman-Approved-At: Thu, 01 Dec 2022 03:18:07 +0000
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
Cc: xinhui.pan@amd.com, john.clements@amd.com, tao.zhou1@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 yipeng.chai@amd.com, stanley.yang@amd.com, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, airlied@gmail.com, christian.koenig@amd.com,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_emit() to simplify the code.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 077404a9c935..ad490c1e2f57 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1267,7 +1267,7 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
 	struct amdgpu_ras *con =
 		container_of(attr, struct amdgpu_ras, features_attr);

-	return scnprintf(buf, PAGE_SIZE, "feature mask: 0x%x\n", con->features);
+	return sysfs_emit(buf, "feature mask: 0x%x\n", con->features);
 }

 static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
-- 
2.25.1
