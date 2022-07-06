Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9EEC43334
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jul 2022 21:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79CA10E009;
	Wed,  6 Jul 2022 21:40:11 +0000 (UTC)
X-Greylist: delayed 399 seconds by postgrey-1.36 at gabe;
 Wed, 06 Jul 2022 20:09:04 UTC
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086BF11BF17
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jul 2022 20:09:03 +0000 (UTC)
Received: (wp-smtpd smtp.tlen.pl 19338 invoked from network);
 6 Jul 2022 22:02:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
 t=1657137740; bh=/S//IAWVRTbBPPNIHjPWh5PsIkJnvKQ93EBXncvo+ss=;
 h=From:To:Cc:Subject;
 b=jYN/rGwwnfPbTq9wy+40wbPLVoq6ZBRLrtb1nxN5pLMzk5x8EGxQbl5DtjHfS4wkK
 N4WYuQK8PeX5IDE/limNYstVfuEcmZSwTf8ZxHahhhIHxh1bbWGRyR+kBx+WNDd+Io
 APIBanZVIdh1VXKmxMcLRAw7tBT9d4rE4TZfM9rA=
Received: from aafi210.neoplus.adsl.tpnet.pl (HELO localhost.localdomain)
 (mat.jonczyk@o2.pl@[83.4.138.210])
 (envelope-sender <mat.jonczyk@o2.pl>)
 by smtp.tlen.pl (WP-SMTPD) with SMTP
 for <amd-gfx@lists.freedesktop.org>; 6 Jul 2022 22:02:20 +0200
From: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: avoid bogus "vram limit (0) must be a power of 2"
 warning
Date: Wed,  6 Jul 2022 22:01:44 +0200
Message-Id: <20220706200144.68851-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: e277a5e13a496bf62bb0d4eefa7f83b2
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [cfO0]                               
X-Mailman-Approved-At: Wed, 06 Jul 2022 21:40:10 +0000
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
Cc: Jonathan Gray <jsg@jsg.id.au>,
 =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I was getting the following message on boot on Linux 5.19-rc5:
        radeon 0000:01:05.0: vram limit (0) must be a power of 2
(I didn't use any radeon.vramlimit commandline parameter).

This is caused by
commit 8c2d34eb53b9 ("drm/radeon: use kernel is_power_of_2 rather than local version")
which removed radeon_check_pot_argument() and converted its users to
is_power_of_2(). The two functions differ in its handling of 0, which is
the default value of radeon_vram_limit: radeon_check_pot_argument()
"incorrectly" considered it a power of 2, while is_power_of_2() does not.

An appropriate conditional silences the warning message.

It is not necessary to add a similar test to other callers of
is_power_of_2() in radeon_device.c. The matching commit in amdgpu:
commit 761175078466 ("drm/amdgpu: use kernel is_power_of_2 rather than local version")
is unaffected by this bug.

Tested on Radeon HD 3200.

Not ccing stable, this is not serious enough.

Fixes: 8c2d34eb53b9 ("drm/radeon: use kernel is_power_of_2 rather than local version")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jonathan Gray <jsg@jsg.id.au>
Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
---
 drivers/gpu/drm/radeon/radeon_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 15692cb241fc..429644d5ddc6 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1113,7 +1113,7 @@ static int radeon_gart_size_auto(enum radeon_family family)
 static void radeon_check_arguments(struct radeon_device *rdev)
 {
 	/* vramlimit must be a power of two */
-	if (!is_power_of_2(radeon_vram_limit)) {
+	if (radeon_vram_limit != 0 && !is_power_of_2(radeon_vram_limit)) {
 		dev_warn(rdev->dev, "vram limit (%d) must be a power of 2\n",
 				radeon_vram_limit);
 		radeon_vram_limit = 0;

base-commit: 88084a3df1672e131ddc1b4e39eeacfd39864acf
-- 
2.25.1

