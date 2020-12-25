Return-Path: <SRS0=eRNB=F5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E3C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 09:43:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA90230FF
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Dec 2020 09:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA90230FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E33889CD5;
	Fri, 25 Dec 2020 09:42:20 +0000 (UTC)
X-Greylist: delayed 1949 seconds by postgrey-1.36 at gabe;
 Fri, 25 Dec 2020 06:58:58 UTC
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221D189B46
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Dec 2020 06:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=Vn9E15e7ykS2S6ec+4
 W/tpv3fMxhhJsX6GTrHdLZGxw=; b=USDzUqvTG0rEEt1IkIRcebIUVFxHwy5aIN
 1a/p2we0ZOuqKtmDiPESUg2GHw2EKNj9r2JmzifRjbAhs2DFenbg0oNQyAQdmh/J
 YAthet6CPGWEJxujjE15WTx29GijqhxtBKqurY0TVzjwB8Z5R6ZXhSmkr56EFOJh
 c3MegT1+4=
Received: from localhost.localdomain (unknown [36.112.86.14])
 by smtp8 (Coremail) with SMTP id NORpCgCHlaWiheVftx8KBA--.3451S2;
 Fri, 25 Dec 2020 14:24:35 +0800 (CST)
From: Defang Bo <bodefang@126.com>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH] drm/amd/display: avoid null pointer dereference in
 dm_set_vblank
Date: Fri, 25 Dec 2020 14:24:27 +0800
Message-Id: <1608877467-2270263-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NORpCgCHlaWiheVftx8KBA--.3451S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4kJrWkuw1xuw17JFW7XFb_yoW8Xr1Upr
 s7JFyYqr1UZF1xW3srA3W09r98Kws3Xa48KrW5Cw1aga45Jwn8Cw1rArW2gr47WFWxC3y3
 JFy7AFW3Z3Wq9w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRpVbPUUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbi6wMG11pD9alAwgAAs+
X-Mailman-Approved-At: Fri, 25 Dec 2020 09:42:16 +0000
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
Cc: Defang Bo <bodefang@126.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Similar to commit<dddc0557e>("drm/amd/display: Guard against null crtc in CRC IRQ"),
a null pointer deference can occur if crtc is null in
dm_set_vblank.

[How]

Check that CRTC is non-null before accessing its fields.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e2b23486..df23d28 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4875,10 +4875,17 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
 static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 {
 	enum dc_irq_source irq_source;
-	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
-	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
+	struct amdgpu_crtc *acrtc;
+	struct amdgpu_device *adev;
+	struct dm_crtc_state *acrtc_state;
 	int rc = 0;
+
+	if (crtc == NULL)
+		return rc;
+
+	acrtc = to_amdgpu_crtc(crtc);
+	adev = drm_to_adev(crtc->dev);
+	acrtc_state = to_dm_crtc_state(crtc->state);
 
 	if (enable) {
 		/* vblank irq on -> Only need vupdate irq in vrr mode */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
