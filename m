Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA59ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 07:27:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A56010E27B;
	Mon, 12 Sep 2022 07:27:04 +0000 (UTC)
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
 by gabe.freedesktop.org (Postfix) with ESMTP id 878A810EE1C;
 Fri,  9 Sep 2022 19:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=MD7Ku
 o/8ZI7rK5baDMxuo/yBRJbppXCYTo0SO7OLZo0=; b=Onm3pJflkFpnGTNMGJRku
 18aUFeyWrqhJRW0O6o/rgRoR3sb9MIdAW5yU/YpKy3Dc+A/1/kryYJ9kVDzhgfy9
 Yk6ncVo+YIYckjsS2tfvM00KTDvrWNLaStn13MMO95oL+bR6h9r+1gPkqeQ22GVq
 j4c42uPtyJgU++9GK5RQNE=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown
 [1.203.67.201])
 by smtp7 (Coremail) with SMTP id C8CowAB3C228mRtjZhFoEg--.50987S4;
 Sat, 10 Sep 2022 03:53:43 +0800 (CST)
From: Jingyu Wang <jingyuwang_vip@163.com>
To: arry.wentland@amd.com, Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
 daniel@ffwll.ch
Subject: [PATCH] drm/amdgpu/display: remove unneeded "default n" options
Date: Sat, 10 Sep 2022 03:53:30 +0800
Message-Id: <20220909195330.85888-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAB3C228mRtjZhFoEg--.50987S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw1fKry5XF4kXryDWFWfZrb_yoWDXrX_K3
 yUAw1rZF15AasFgr12vr4rury0ya1UZrZ7XFy8tryavr17ur4fW3s7u3y3Kr17u3ZrCFZx
 u3yrCF4aywn3tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi5r2tUUUUU==
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbCoAd3F1zmWJAhuAAAss
X-Mailman-Approved-At: Mon, 12 Sep 2022 07:26:53 +0000
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
Cc: Jingyu Wang <jingyuwang_vip@163.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove "default n" options. If the "default" line is removed, it
defaults to 'n'.

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/gpu/drm/amd/display/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 413d8c6d592f..6925e0280dbe 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -28,7 +28,6 @@ config DRM_AMD_DC_SI
 	bool "AMD DC support for Southern Islands ASICs"
 	depends on DRM_AMDGPU_SI
 	depends on DRM_AMD_DC
-	default n
 	help
 	  Choose this option to enable new AMD DC support for SI asics
 	  by default. This includes Tahiti, Pitcairn, Cape Verde, Oland.
@@ -43,7 +42,6 @@ config DEBUG_KERNEL_DC
 
 config DRM_AMD_SECURE_DISPLAY
         bool "Enable secure display support"
-        default n
         depends on DEBUG_FS
         depends on DRM_AMD_DC_DCN
         help

base-commit: 5957ac6635a1a12d4aa2661bbf04d3085a73372a
-- 
2.34.1

