Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC758C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:05:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699B410E8BD;
	Thu, 11 Jan 2024 09:05:08 +0000 (UTC)
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
 by gabe.freedesktop.org (Postfix) with ESMTP id AB30C10E1A0;
 Thu, 11 Jan 2024 08:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=hFyLYRGrdMsKKrb572
 UmJNs+TslUNdb4TSStKU71wo4=; b=DEhWlRLc5nBvJc7T1kmQf5FQf0jlfjkFW3
 Hhnec7P3YSfo8sSEuXaPZh6Zo8tqBw508Gb6QmnpMCTo6GRaIL2FQuUqxPux05ko
 5WKs0iMfCHdvTVJNb08oxXKhZZHscYNnJJ616H9rt3dTmPpAdBd51Jf4NWTk9SSo
 84hhgL+lI=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnb5SnqJ9l0suUAA--.19779S2;
 Thu, 11 Jan 2024 16:36:55 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, alexander.deucher@amd.com,
 airlied@gmail.com, christian.koenig@amd.com
Subject: [PATCH] drm/radeon: Clean up errors in r600.c
Date: Thu, 11 Jan 2024 08:36:54 +0000
Message-Id: <20240111083654.12411-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wDnb5SnqJ9l0suUAA--.19779S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWDZrWxuFy5Kry8JFWfuFg_yoW3WFX_Ca
 48Xws5JFW0vasY9F1IvF4DZr92ya18u397Gw1xKFn3Kry2q3yfua95Gr1fX3y8JF42qF1D
 Aan3XFy3CFsIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZXo7UUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEAti1mVOBk-1wgACs4
X-Mailman-Approved-At: Thu, 11 Jan 2024 09:04:24 +0000
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
Cc: GuoHua Chen <chenguohua_716@163.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/r600.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index a17b95eec65f..b5e97d95a19f 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -99,8 +99,7 @@ MODULE_FIRMWARE("radeon/SUMO_me.bin");
 MODULE_FIRMWARE("radeon/SUMO2_pfp.bin");
 MODULE_FIRMWARE("radeon/SUMO2_me.bin");
 
-static const u32 crtc_offsets[2] =
-{
+static const u32 crtc_offsets[2] = {
 	0,
 	AVIVO_D2CRTC_H_TOTAL - AVIVO_D1CRTC_H_TOTAL
 };
-- 
2.17.1

