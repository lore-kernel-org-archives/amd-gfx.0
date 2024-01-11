Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B173C47DB0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DCA410E8A6;
	Thu, 11 Jan 2024 09:04:30 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTP id 578D910E1AC;
 Thu, 11 Jan 2024 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=6AZs02xj1/cbg0BiYo
 +KmJRnfb8WZCPrXQoJKEmHzYI=; b=GGR2SuQrujnsc54YNSF+uxxnodPQeL2V9+
 V7RNolEXZMjC8F4P2oQdDTfLHoOsRnlrb/ivLerLV0SXttB0lsXZv85InIUpJ595
 TNdQEWO0tOFQkEyZ/FAMX00fgfq+s9q7Zv/AkttaErTfxFwJFv1tDJU9HCL5E4iY
 dG2K2S8Mo=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3n1bdo59lXLCUAA--.18346S2;
 Thu, 11 Jan 2024 16:16:30 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, airlied@gmail.com,
 christian.koenig@amd.com, alexander.deucher@amd.com
Subject: [PATCH] drm/radeon/kms: Clean up errors in rv6xx_dpm.h
Date: Thu, 11 Jan 2024 08:16:28 +0000
Message-Id: <20240111081628.11492-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3n1bdo59lXLCUAA--.18346S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF1kXF13tr13Ww17CFWDCFg_yoWxuwb_Ca
 4xX3y7WrW2kFn5XF47Zrs8JryIva15uF48uw4fta4fGry7Xr1fWa4vgrW7Xa1FgFn3JF9x
 Cw4kXFyfJFsFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjcTmDUUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEB5i1mVOBk+DPwAAsk
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:25 +0000
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
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, GuoHua Chen <chenguohua_716@163.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following struct go on the same line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/rv6xx_dpm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/rv6xx_dpm.h b/drivers/gpu/drm/radeon/rv6xx_dpm.h
index 8035d53ebea6..020c0dc8361d 100644
--- a/drivers/gpu/drm/radeon/rv6xx_dpm.h
+++ b/drivers/gpu/drm/radeon/rv6xx_dpm.h
@@ -28,8 +28,7 @@
 #include "r600_dpm.h"
 
 /* Represents a single SCLK step. */
-struct rv6xx_sclk_stepping
-{
+struct rv6xx_sclk_stepping {
     u32 vco_frequency;
     u32 post_divider;
 };
-- 
2.17.1

