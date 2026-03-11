Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D170FED2E6
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 07:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F7F10E985;
	Thu, 12 Mar 2026 07:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="ZEskC8tv";
	dkim-atps=neutral
X-Greylist: delayed 1311 seconds by postgrey-1.36 at gabe;
 Wed, 11 Mar 2026 14:43:38 UTC
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93FE910E92B
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 14:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
 References; bh=zoopHjIT5W4j178u0z5GQnK5VFOmQdcXXviuFKle2iA=; b=ZEskC8tvVD5jWr
 pN0P4k2/ZrCiKlUUtQvWzacaygFSzu4YGFmigLeTBzhKA6XpR18/kdmR8Of3DCUXbPfp0D3XqDQ5a
 2hZyNucXvwVrqUUwGaTF0kLZvmXN53N/84RyDkkcOAtObKxYKiX9pSIyIAvyqUjkvhJA1614rJmet
 txzgmCFtiQboa/Ymejxb6GvGYoQIXUJkd1h/n5O+8UBY8d+Ns1+MUkRDu7bNJq5vuWgk1aIO4QRba
 9CDyU+4d3M8L5fwpL67gRuuXsasKgrIlvtSKz5eDzYHqwv0iaFkwJ4ejXnLGjy1Z8X9steonmMD3m
 wis1DruFY0oHwzY83EvA==;
Received: from [63.135.74.212] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1w0KRR-008K8m-P3; Wed, 11 Mar 2026 14:21:42 +0000
Received: from ben by rainbowdash with local (Exim 4.99.1)
 (envelope-from <ben@rainbowdash>) id 1w0KRR-00000002Dsh-1wGn;
 Wed, 11 Mar 2026 14:21:41 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, christian.koenig@amd.com
Cc: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] drm/radeon: fix __user annotation in radeon_info_ioctl()
Date: Wed, 11 Mar 2026 14:21:38 +0000
Message-Id: <20260311142138.530006-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Mar 2026 07:48:09 +0000
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

The radeon_info_ioctl() is obviously called from an ioctl()
entry for this device, and uses copy_{to,from)_user() on
the value_ptr variable.

This is generating sparse warnings due to use lack of __user
annotation on the value_ptr, so add this to remove the
following warnings:

drivers/gpu/drm/radeon/radeon_kms.c:262:43: warning: incorrect type in argument 2 (different address spaces)
drivers/gpu/drm/radeon/radeon_kms.c:262:43:    expected void const [noderef] __user *from
drivers/gpu/drm/radeon/radeon_kms.c:262:43:    got unsigned int [usertype] *[assigned] value_ptr
drivers/gpu/drm/radeon/radeon_kms.c:319:43: warning: incorrect type in argument 2 (different address spaces)
drivers/gpu/drm/radeon/radeon_kms.c:319:43:    expected void const [noderef] __user *from
drivers/gpu/drm/radeon/radeon_kms.c:319:43:    got unsigned int [usertype] *[assigned] value_ptr
drivers/gpu/drm/radeon/radeon_kms.c:331:43: warning: incorrect type in argument 2 (different address spaces)
drivers/gpu/drm/radeon/radeon_kms.c:331:43:    expected void const [noderef] __user *from
drivers/gpu/drm/radeon/radeon_kms.c:331:43:    got unsigned int [usertype] *[assigned] value_ptr
drivers/gpu/drm/radeon/radeon_kms.c:467:43: warning: incorrect type in argument 2 (different address spaces)
drivers/gpu/drm/radeon/radeon_kms.c:467:43:    expected void const [noderef] __user *from
drivers/gpu/drm/radeon/radeon_kms.c:467:43:    got unsigned int [usertype] *[assigned] value_ptr
drivers/gpu/drm/radeon/radeon_kms.c:592:43: warning: incorrect type in argument 2 (different address spaces)
drivers/gpu/drm/radeon/radeon_kms.c:592:43:    expected void const [noderef] __user *from
drivers/gpu/drm/radeon/radeon_kms.c:592:43:    got unsigned int [usertype] *[assigned] value_ptr
drivers/gpu/drm/radeon/radeon_kms.c:609:26: warning: incorrect type in argument 1 (different address spaces)
drivers/gpu/drm/radeon/radeon_kms.c:609:26:    expected void [noderef] __user *to
drivers/gpu/drm/radeon/radeon_kms.c:609:26:    got unsigned int [usertype] *[assigned] value_ptr

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index dc43fd790a9c..57bc60c33937 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -231,13 +231,14 @@ int radeon_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_radeon_info *info = data;
 	struct radeon_mode_info *minfo = &rdev->mode_info;
-	uint32_t *value, value_tmp, *value_ptr, value_size;
+	uint32_t *value, value_tmp, value_size;
+	uint32_t __user *value_ptr;
 	struct ttm_resource_manager *man;
 	uint64_t value64;
 	struct drm_crtc *crtc;
 	int i, found;
 
-	value_ptr = (uint32_t *)((unsigned long)info->value);
+	value_ptr = (uint32_t __user *)((unsigned long)info->value);
 	value = &value_tmp;
 	value_size = sizeof(uint32_t);
 
-- 
2.37.2.352.g3c44437643

