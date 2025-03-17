Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A25C36000
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 10:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7256F10E3EF;
	Mon, 17 Mar 2025 10:53:38 +0000 (UTC)
X-Greylist: delayed 527 seconds by postgrey-1.36 at gabe;
 Mon, 17 Mar 2025 03:07:02 UTC
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F08B010E049
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 03:07:02 +0000 (UTC)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZGKR46gCxz1DFH
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 10:58:08 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mxde.zte.com.cn (FangMail) with ESMTPS id 4ZGKR20zLVz63hXl
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 10:58:06 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGKQv5KDCz8R042;
 Mon, 17 Mar 2025 10:57:59 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
 by mse-fl1.zte.com.cn with SMTP id 52H2vif5071879;
 Mon, 17 Mar 2025 10:57:44 +0800 (+08)
 (envelope-from feng.wei8@zte.com.cn)
Received: from mapi (xaxapp04[null]) by mapi (Zmail) with MAPI id mid32;
 Mon, 17 Mar 2025 10:57:45 +0800 (CST)
Date: Mon, 17 Mar 2025 10:57:45 +0800 (CST)
X-Zmail-TransId: 2afb67d78fa9634-63c34
X-Mailer: Zmail v1.0
Message-ID: <20250317105745891-NnPPMd8T0guyJikMgM6p@zte.com.cn>
Mime-Version: 1.0
From: <feng.wei8@zte.com.cn>
To: <alexander.deucher@amd.com>
Cc: <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vcmFkZW9uL3V2ZDogUmVwbGFjZSBuZXN0ZWQgbWF4KCkgd2l0aCBzaW5nbGUgbWF4Mygp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 52H2vif5071879
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D78FBF.000/4ZGKR46gCxz1DFH
X-Mailman-Approved-At: Mon, 17 Mar 2025 10:53:32 +0000
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

From: FengWei <feng.wei8@zte.com.cn>

Use max3() macro instead of nesting max() to simplify the return
statement.

Signed-off-by: FengWei <feng.wei8@zte.com.cn>
---
 drivers/gpu/drm/radeon/radeon_uvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index 058a1c8451b2..ded5747a58d1 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -961,7 +961,7 @@ int radeon_uvd_calc_upll_dividers(struct radeon_device *rdev,
 	unsigned optimal_score = ~0;

 	/* loop through vco from low to high */
-	vco_min = max(max(vco_min, vclk), dclk);
+	vco_min = max3(vco_min, vclk, dclk);
 	for (vco_freq = vco_min; vco_freq <= vco_max; vco_freq += 100) {

 		uint64_t fb_div = (uint64_t)vco_freq * fb_factor;
-- 
2.25.1
