Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7599C87FCF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Aug 2025 12:57:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E268F886A4;
	Thu,  7 Aug 2025 12:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="d7doqlbP";
	dkim-atps=neutral
X-Greylist: delayed 1804 seconds by postgrey-1.36 at gabe;
 Thu, 07 Aug 2025 10:33:16 UTC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 by gabe.freedesktop.org (Postfix) with ESMTP id E644D10E0B4
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Aug 2025 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Yu
 060HFp7OokvIbTOySWGWsGGcfzytPoIFqY1n1bEK8=; b=d7doqlbPLjZP9cOhIp
 oyEjnKydTXd3Xi9ISgffSmOz8L4Ll/P4v2qDSJYrcIJp442vFq1+1jGi+9bechSL
 uxDGZscJmF8inMQANFJBone/LNUUdTxOU5/FrlN8G5z39OED93O+6oaHJAIYjAzt
 IZq4IfKGm9q6mx4t0PYILmO4w=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wB3kiYpdpRoIY9GAQ--.12087S2; 
 Thu, 07 Aug 2025 17:47:23 +0800 (CST)
From: oushixiong1025@163.com
To: Alex Deucher <alexander.deucher@amd.com>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] drm/amdgpu: skip disabling audio when device is unplugged
Date: Thu,  7 Aug 2025 17:47:19 +0800
Message-Id: <20250807094719.56145-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3kiYpdpRoIY9GAQ--.12087S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1DJF48Wr4xtw13ZrWxCrg_yoW5Aw18pF
 yFya4Fkw48Zw4jqa1IyF9rXrn8A3ZFg3Wfur4kJr1a9ayDA3s0qa4rJF18u3s8JrWqvF42
 q343J3yUZ3ZYg3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0XdbUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/1tbiXRGZD2iI7Tg5FAACsA
X-Mailman-Approved-At: Thu, 07 Aug 2025 12:57:25 +0000
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

From: Shixiong Ou <oushixiong@kylinos.cn>

When Stopping lightdm and removing amdgpu driver are executed, the following
error is triggered probably:

Unable to handle kernel paging request at virtual address 0000000000005e00
.....
[ 2] [T10084] Call trace:
[ 2] [T10084]  amdgpu_device_wreg.part.0+0x58/0x110 [amdgpu]
[ 2] [T10084]  amdgpu_device_wreg+0x20/0x38 [amdgpu]
[ 2] [T10084]  dce_v6_0_audio_endpt_wreg+0x64/0xd8 [amdgpu]
[ 2] [T10084]  dce_v6_0_sw_fini+0xa0/0x118 [amdgpu]
[ 2] [T10084]  amdgpu_device_ip_fini.isra.0+0xdc/0x1e8 [amdgpu]
[ 2] [T10084]  amdgpu_device_fini_sw+0x2c/0x220 [amdgpu]
[ 2] [T10084]  amdgpu_driver_release_kms+0x20/0x40 [amdgpu]
[ 2] [T10084]  devm_drm_dev_init_release+0x8c/0xc0 [drm]
[ 2] [T10084]  devm_action_release+0x18/0x28
[ 2] [T10084]  release_nodes+0x5c/0xc8
[ 2] [T10084]  devres_release_all+0xa0/0x130
[ 2] [T10084]  device_unbind_cleanup+0x1c/0x70
[ 2] [T10084]  device_release_driver_internal+0x1e4/0x228
[ 2] [T10084]  driver_detach+0x90/0x100
[ 2] [T10084]  bus_remove_driver+0x74/0x100
[ 2] [T10084]  driver_unregister+0x34/0x68
[ 2] [T10084]  pci_unregister_driver+0x24/0x108
[ 2] [T10084]  amdgpu_exit+0x1c/0x3270 [amdgpu]
[ 2] [T10084]  __do_sys_delete_module.constprop.0+0x1d0/0x330
[ 2] [T10084]  __arm64_sys_delete_module+0x18/0x28
[ 2] [T10084]  invoke_syscall+0x4c/0x120
[ 2] [T10084]  el0_svc_common.constprop.0+0xc4/0xf0
[ 2] [T10084]  do_el0_svc+0x24/0x38
[ 2] [T10084]  el0_svc+0x24/0x88
[ 2] [T10084]  el0t_64_sync_handler+0x134/0x150
[ 2] [T10084]  el0t_64_sync+0x14c/0x150
[ 2] [T10084] Code: f9401bf7 f9453e60 8b150000 d50332bf (b9000016)
[ 2] [T10084] ---[ end trace 0000000000000000 ]---

The adev->rmmio has been unmmaped in amdgpu_device_fini_hw().

So skip disabling audio when device is unplugged.

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 276c025c4c03..48b29990da7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -23,6 +23,7 @@
 
 #include <linux/pci.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_modeset_helper.h>
@@ -1459,8 +1460,10 @@ static void dce_v6_0_audio_fini(struct amdgpu_device *adev)
 	if (!adev->mode_info.audio.enabled)
 		return;
 
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++)
-		dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
+	if (!drm_dev_is_unplugged(adev_to_drm(adev))) {
+		for (i = 0; i < adev->mode_info.audio.num_pins; i++)
+			dce_v6_0_audio_enable(adev, &adev->mode_info.audio.pin[i], false);
+	}
 
 	adev->mode_info.audio.enabled = false;
 }
-- 
2.25.1

