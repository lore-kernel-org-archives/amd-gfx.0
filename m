Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982CEECAAD2
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 13:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91E910EEF4;
	Mon, 29 Aug 2022 13:43:46 +0000 (UTC)
X-Greylist: delayed 3757 seconds by postgrey-1.36 at gabe;
 Mon, 29 Aug 2022 13:41:13 UTC
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7496B10F278
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 13:41:13 +0000 (UTC)
X-QQ-mid: bizesmtp72t1661776623taqf4by8
Received: from localhost.localdomain ( [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 29 Aug 2022 20:36:57 +0800 (CST)
X-QQ-SSF: 01400000002000C0K000B00A0000000
X-QQ-FEAT: ao4JQgu0M3/UgU+YkHy4njb4NNdIn11x9nwLEL07GbnOzmiQXUMUeaKluCk/G
 GWneyTH3RyNn9YPtOJX1r+pKTbLJAZhBaG5JtqljRhiFnkjCKIpMm+e8eEFqNW7yFXElM1C
 WB03tfyjp6jCR+lkhukBGnL03JVi/SR/FIqx8P5xwhzmJVVnrNCIvXMy++KKF7MqaR2nlKn
 2LaoSuWZ+zTN9Xhw2lf20BOUaKM1ja3TWaoOk8FN3FWXMzrdTQxjecE1+G5nqRyigBrJCxS
 n0+2Nsd6dgwKEh38a3k40Al1j4ifoGaBhTNQXEkj4SGIStP4/9TrNFrhVEqhhAkVNEqBMNB
 APZy4G1SPFqke7zO+yRC0eA0zvssfSH1dg76/RBQ08YUX+i+UGj7Y0p4PKjfA==
X-QQ-GoodBg: 2
From: Zhen Ni <nizhen@uniontech.com>
To: airlied@linux.ie,
	daniel@ffwll.ch,
	evan.quan@amd.com
Subject: [PATCH] drm/amd/amdgpu: Add modeset module parameter support
Date: Mon, 29 Aug 2022 20:36:54 +0800
Message-Id: <20220829123654.4333-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr5
X-Mailman-Approved-At: Mon, 29 Aug 2022 13:43:44 +0000
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
Cc: Zhen Ni <nizhen@uniontech.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Nomodeset kernel parameter is for all graphics cards. Amdgpu cannot
be set separately in some scenarios, such as hybrid graphics(i + a).
Add modeset module parameter for amdgpu to set kernel mode separately.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 429fcdf28836..856a70370e3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -107,6 +107,7 @@
 #define KMS_DRIVER_MINOR	48
 #define KMS_DRIVER_PATCHLEVEL	0
 
+int amdgpu_modeset = -1;
 int amdgpu_vram_limit;
 int amdgpu_vis_vram_limit;
 int amdgpu_gart_size = -1; /* auto */
@@ -199,6 +200,13 @@ struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
 	.period = 0x0, /* default to 0x0 (timeout disable) */
 };
 
+/**
+ * DOC: modeset (int)
+ * Disable/Enable kernel modesetting (1 = enable, 0 = disable, -1 = auto (default)).
+ */
+MODULE_PARM_DESC(modeset, "Disable/Enable kernel modesetting");
+module_param_named(modeset, amdgpu_modeset, int, 0400);
+
 /**
  * DOC: vramlimit (int)
  * Restrict the total amount of VRAM in MiB for testing.  The default is 0 (Use full VRAM).
@@ -2753,7 +2761,10 @@ static int __init amdgpu_init(void)
 {
 	int r;
 
-	if (drm_firmware_drivers_only())
+	if (drm_firmware_drivers_only() && amdgpu_modeset == -1)
+		amdgpu_modeset = 0;
+
+	if (amdgpu_modeset == 0)
 		return -EINVAL;
 
 	r = amdgpu_sync_init();
-- 
2.20.1

