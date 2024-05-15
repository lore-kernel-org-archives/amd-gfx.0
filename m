Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417A5C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 15 May 2024 21:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9305610E0F8;
	Wed, 15 May 2024 21:47:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=icloud.com header.i=@icloud.com header.b="Ch4Zu3UZ";
	dkim-atps=neutral
Received: from st43p00im-ztfb10073301.me.com (st43p00im-ztfb10073301.me.com
 [17.58.63.186])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E70A10E305
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 May 2024 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
 s=1a1hai; t=1715802405;
 bh=gChLto0wuBmBkw+d7DrIrxrJwuCOppo9zmpl1lXbdD8=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=Ch4Zu3UZFybf4qUpSGPtPIZH9oawKUAoMeJvZMTVX6UC13MQsFT4dCjC1farXCWd0
 PsG1QFQG10cWETKtduIg4z3HP+UPq11fZ0l5lOTXhyOJbf8tbu8fhaEmg1+crjPQUt
 NNTAGGhNyCT8a5l44O1JHGPPI9n77CC4yljsLmugra8huC0q0IEn59wL0Un5pBiiNT
 DKb7/mvDrMeTQi0vOLcftEyVdxyPknxZI4TMJeAqCrgrzUF0K75PuZGOhFoAeesbYY
 RdRBMsbMkaLpMjm44Sxqu0wjrzRhi4p1ddv2hSXiZdchGV5ZLeuf7lOsWT8XPvQBPN
 UQXs+3VrbzshQ==
Received: from kendalls-iMac.lan (st43p00im-dlb-asmtp-mailmevip.me.com
 [17.42.251.41])
 by st43p00im-ztfb10073301.me.com (Postfix) with ESMTPSA id 2B49080028C;
 Wed, 15 May 2024 19:46:45 +0000 (UTC)
From: Kendall Smith <kendallsm2@icloud.com>
To: amd-gfx@lists.freedesktop.org
Cc: Kendall Smith <kendallsm2@icloud.com>
Subject: [PATCH] drm/radeon: initialize atom DIG backlight for iMac12,
 1 and iMac12, 2 with Radeon 6750M
Date: Wed, 15 May 2024 15:42:31 -0400
Message-Id: <20240515194230.15430-1-kendallsm2@icloud.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 01lK80zzQUvVen4gJfs4ONZkr4fmTB28
X-Proofpoint-ORIG-GUID: 01lK80zzQUvVen4gJfs4ONZkr4fmTB28
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_12,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2405150142
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8
X-Mailman-Approved-At: Wed, 15 May 2024 21:47:38 +0000
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

If a Radeon 6750M GPU from an iMac12,1 is installed into an iMac 12,2, there is no backlight device initialized during boot. Everything else is functional, but the display brightness cannot be controlled. There are no directories present in /sys/class/backlight after booting. A simple one line modification to an if statement fixes this issue by initializing the radeon backlight device for an iMac12,2 as well if it has a 6750M. After the patch, brightness can be controlled and radeon_bl0 is present in /sys/class/backlight. This was tested by compiling the latest kernel with and without the patch.

Signed-off-by: Kendall Smith <kendallsm2@icloud.com>
---
 drivers/gpu/drm/radeon/atombios_encoders.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 2bff0d9e20f5..7b11674f5d45 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -201,7 +201,7 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 	 */
 	if ((rdev->pdev->subsystem_vendor == PCI_VENDOR_ID_APPLE) &&
 	    (rdev->pdev->device == 0x6741) &&
-	    !dmi_match(DMI_PRODUCT_NAME, "iMac12,1"))
+	    !(dmi_match(DMI_PRODUCT_NAME, "iMac12,1") || dmi_match(DMI_PRODUCT_NAME, "iMac12,2")))
 		return;
 
 	if (!radeon_encoder->enc_priv)
-- 
2.34.1

