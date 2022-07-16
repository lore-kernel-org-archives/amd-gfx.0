Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B963CCA47F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 12:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8450A14A874;
	Tue, 19 Jul 2022 12:55:21 +0000 (UTC)
Received: from smtpbg.qq.com (biz-43-154-221-58.mail.qq.com [43.154.221.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBCC818AA3A;
 Tue, 19 Jul 2022 11:59:49 +0000 (UTC)
X-QQ-mid: bizesmtp84t1658231978t4u9l6dy
Received: from localhost.localdomain ( [171.223.96.21])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 19 Jul 2022 19:59:36 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: 3uhoZqdeMHMkGTYpkkjDgOhxGAR++wlBx2LmCDenBU68zf3/NsGKrawlk8a1s
 3GQwHzKIHhUpq7Vu+NnGP8opGQyr2IOdnZl4QEr4ZnffrQzsOtA5tEIu5VtWrr5Rr6nZWth
 DVpxdk96/GLl1wgNxcXRsGDK8r0iIgh8XYuTEbPY8wfMDnaGvH1r/tzbSSVawuNaqL81awY
 ctlUKbRpH0G+drjgv+GDGXQJ9uQNVinQtZrDe5Xe+mpHq7lRvDeGgdR+UFuf5WNoyPSDNL7
 3m++iuZYOAm1S/vXw0mj0PYzFxWxnYKuTFtA/YBZa/6juNsubDupYkhSUC56oBtoXH7BdRw
 XPBh/SripEEQzVeC6jDZLqNXIUb2C9k8gNDGXOm9strZoQEVCV72qy1+f5oZw==
X-QQ-GoodBg: 0
From: Jason Wang <wangborong@cdjrlc.com>
To: daniel@ffwll.ch
Subject: [PATCH] drm/radeon: Fix comment typo
Date: Sat, 16 Jul 2022 11:57:32 +0800
Message-Id: <20220716035732.30449-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Mailman-Approved-At: Tue, 19 Jul 2022 12:55:20 +0000
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
Cc: airlied@linux.ie, Xinhui.Pan@amd.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Jason Wang <wangborong@cdjrlc.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The double `have' is duplicated in line 696, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 84843b3b3aef..261fcbae88d7 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -693,7 +693,7 @@ int radeon_gem_va_ioctl(struct drm_device *dev, void *data,
 	}
 
 	/* !! DONT REMOVE !!
-	 * We don't support vm_id yet, to be sure we don't have have broken
+	 * We don't support vm_id yet, to be sure we don't have broken
 	 * userspace, reject anyone trying to use non 0 value thus moving
 	 * forward we can use those fields without breaking existant userspace
 	 */
-- 
2.35.1

