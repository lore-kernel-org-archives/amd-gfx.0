Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94027C47DA2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 09:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE24C10E8C1;
	Thu, 11 Jan 2024 09:05:08 +0000 (UTC)
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1D67710E1CB;
 Thu, 11 Jan 2024 08:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=C41GvdsfCnJ5btfTlf
 7ADFG8GCPBwf9UbjaedLoXgJ4=; b=EZHVndKzTLc0xLguuz56/JzUQpjoov5KMS
 K/oPLO8pet+bdyH3aOcrJorjs4neL5wC727T+R+F33Fl5tGwUzbM9dOOHuHWTvet
 c94D5tBU5k/3OMiWUYGEYuhKll7vTQINIJw6zdb9QwqF0jntr0czo7CJKAqet+fJ
 XV+x2fetc=
Received: from localhost.localdomain (unknown [182.148.14.173])
 by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wCX__VDpp9lalCVAA--.15415S2;
 Thu, 11 Jan 2024 16:26:43 +0800 (CST)
From: GuoHua Chen <chenguohua_716@163.com>
To: daniel@ffwll.ch, Xinhui.Pan@amd.com, alexander.deucher@amd.com,
 airlied@gmail.com, christian.koenig@amd.com
Subject: [PATCH] drm/radeon: Clean up errors in uvd_v1_0.c
Date: Thu, 11 Jan 2024 08:26:41 +0000
Message-Id: <20240111082641.11892-1-chenguohua_716@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wCX__VDpp9lalCVAA--.15415S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1xtFWUWFyUGF4rKryUJrb_yoW3ZFc_KF
 4UZ3y5GwsrZ3Z7ZF12kFs8AF92yw45uFs3uw1Yqas3tryYqw4rWry7ury3Xw4rGFn3JF95
 Cw4vgFyfZFsxZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUZXo7UUUUU==
X-Originating-IP: [182.148.14.173]
X-CM-SenderInfo: xfkh0w5xrk3tbbxrlqqrwthudrp/xtbBEhxi1mVOBk+X-AACsx
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
Cc: GuoHua Chen <chenguohua_716@163.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the following errors reported by checkpatch:

ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
---
 drivers/gpu/drm/radeon/uvd_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/uvd_v1_0.c b/drivers/gpu/drm/radeon/uvd_v1_0.c
index 58557c2263a7..5684639d20a6 100644
--- a/drivers/gpu/drm/radeon/uvd_v1_0.c
+++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
@@ -142,7 +142,7 @@ int uvd_v1_0_resume(struct radeon_device *rdev)
 	addr = (rdev->uvd.gpu_addr >> 32) & 0xFF;
 	WREG32(UVD_LMI_EXT40_ADDR, addr | (0x9 << 16) | (0x1 << 31));
 
-	WREG32(UVD_FW_START, *((uint32_t*)rdev->uvd.cpu_addr));
+	WREG32(UVD_FW_START, *((uint32_t *)rdev->uvd.cpu_addr));
 
 	return 0;
 }
-- 
2.17.1

