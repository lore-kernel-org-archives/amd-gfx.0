Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702F1C28B2F
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Mar 2025 15:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E15E310E4A8;
	Tue, 18 Mar 2025 15:13:50 +0000 (UTC)
X-Greylist: delayed 301 seconds by postgrey-1.36 at gabe;
 Tue, 18 Mar 2025 14:04:04 UTC
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9083E10E495
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Mar 2025 14:04:04 +0000 (UTC)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:2568:e3d1:1e11:17f3])
 by laurent.telenet-ops.be with cmsmtp
 id SDyj2E0091Mz0fJ01Dyj30; Tue, 18 Mar 2025 14:58:43 +0100
Received: from rox.of.borg ([192.168.97.57])
 by ramsan.of.borg with esmtp (Exim 4.97)
 (envelope-from <geert@linux-m68k.org>) id 1tuXSS-0000000EecJ-1JM6;
 Tue, 18 Mar 2025 14:58:43 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
 (envelope-from <geert@linux-m68k.org>) id 1tuXSt-0000000AJqr-1H6O;
 Tue, 18 Mar 2025 14:58:43 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Pratap Nirujogi <pratap.nirujogi@amd.com>,
 Benjamin Chan <benjamin.chan@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-gpio@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] pinctrl: PINCTRL_AMDISP should depend on DRM_AMD_ISP
Date: Tue, 18 Mar 2025 14:58:40 +0100
Message-ID: <3685561e8e3cd1d94bce220eeb6001d659da615c.1742306024.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 18 Mar 2025 15:13:49 +0000
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

The AMD Image Signal Processor GPIO pin control functionality is only
present on AMD platforms with ISP support, and its platform device is
instantiated by the AMD ISP driver.  Hence add a dependency on
DRM_AMD_ISP, to prevent asking the user about this driver when
configuring a kernel that does not support the AMD ISP.

Fixes: e97435ab09f3ad7b ("pinctrl: amd: isp411: Add amdisp GPIO pinctrl")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index cbb81f65c6eb22f0..0b355a7e7eeec412 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -51,6 +51,7 @@ config PINCTRL_AMD
 
 config PINCTRL_AMDISP
 	tristate "AMDISP GPIO pin control"
+	depends on DRM_AMD_ISP || COMPILE_TEST
 	depends on HAS_IOMEM
 	select GPIOLIB
 	select PINCONF
-- 
2.43.0

