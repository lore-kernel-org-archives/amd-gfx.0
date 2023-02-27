Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DA6C64ED6
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Feb 2023 09:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BABB10E3A3;
	Mon, 27 Feb 2023 09:57:33 +0000 (UTC)
X-Greylist: delayed 739 seconds by postgrey-1.36 at gabe;
 Mon, 27 Feb 2023 07:56:46 UTC
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5BF10E350;
 Mon, 27 Feb 2023 07:56:46 +0000 (UTC)
X-QQ-mid: bizesmtp89t1677483605t3p8ysbx
Received: from localhost.localdomain ( [58.240.82.166])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Feb 2023 15:39:57 +0800 (CST)
X-QQ-SSF: 0040000000200070C000B00A0000000
X-QQ-FEAT: 3GqwhZhMvTvfQjpR/B2tBV5yWXh5qI9xpTn1g/xB6K4m9QHxfp3TKCpkbOi8u
 SX5oUZA8JPczDI7eBe50wCktPsgIy1DvR6QkcJz8aadvplJS9cG3FdSW4H9Aszizw9J8jyx
 s2nfL1FENw50Bg44lyJOzCnosxyJ/cbCNojhlE4wCQSdjqrFTeyOJnZ9cag+w2jDY+8NN9K
 Do2eaGpNa70chPZuBddq2qdshf62XTDae70QLL6kbfih0XFnnBFBAubjZ2xKHXdtWNT2Mr7
 XHs2720dKbvcEZqugi94t0x+/Gnh/QRM1p1InHydsKA5KZBY4HrKRhRD8EuyMguxfNDPguV
 pgOrrGW0l8Q0ANch2M1QkXI4fLqARvZboCI0p6vfu8cROaBM9KH9NxY9zL11G0wXEtlKGZC
 awVGfvFsflY=
X-QQ-GoodBg: 2
From: Yuanzhi Wang <wangyuanzhi@uniontech.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, mario.limonciello@amd.com,
 Bokun.Zhang@amd.com, tzimmermann@suse.de, hdegoede@redhat.com,
 jingyuwang_vip@163.com, rafael.j.wysocki@intel.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] amdgpu: add a filter condition when set brightness
Date: Mon, 27 Feb 2023 15:39:53 +0800
Message-Id: <20230227073953.326-1-wangyuanzhi@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr2
X-Mailman-Approved-At: Mon, 27 Feb 2023 09:57:31 +0000
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
Cc: Yuanzhi Wang <wangyuanzhi@uniontech.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When the laptop is plugged into AC or DC power supply,
the brightness obtained ACPI may be smaller than current
brightness.As a result the screen becomes dark，this is
not what people want.

Signed-off-by: Yuanzhi Wang <wangyuanzhi@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index d4196fcb85a0..93f1567028c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -406,6 +406,7 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 {
 	struct amdgpu_atif *atif = &amdgpu_acpi_priv.atif;
 	int count;
+	int old_brightness;
 
 	DRM_DEBUG_DRIVER("event, device_class = %s, type = %#x\n",
 			event->device_class, event->type);
@@ -443,7 +444,13 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
 				 * hardwired to post BACKLIGHT_UPDATE_SYSFS.
 				 * It probably should accept 'reason' parameter.
 				 */
-				backlight_device_set_brightness(atif->bd, req.backlight_level);
+				old_brightness = backlight_get_brightness(atif->bd);
+				if (old_brightness > req.backlight_level)
+					DRM_WARN("old brightness %d is greater than ACPI brightness
+						%d\n", old_brightness, req.backlight_level);
+				else
+					backlight_device_set_brightness(atif->bd,
+						req.backlight_level);
 			}
 		}
 
-- 
2.20.1

