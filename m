Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1874C433E6
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 10:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68F6D221F0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 10:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F6D221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D731589A35;
	Mon, 28 Dec 2020 10:19:26 +0000 (UTC)
Received: from m15111.mail.126.com (m15111.mail.126.com [220.181.15.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 590E389A0F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 03:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=z0RBXr31F2ios8V7Fp
 YTtcsONT7xFb8GSiDADGswyOk=; b=gycD6y1lGtSW6CsapTcIjnhVgeOQL0z8Ry
 wRCuSjI5UTifBBQr6VeKjTlpgAA195GAZXyHjfpNIQogNCphJ6yt71u2NjzAPyso
 6NkhbUDmgy5H+AmPirR7psidac6C6Jeh+6SA3m/3Vo+/2FTFmyY0vItOo0hZfKng
 1hS+vWQG0=
Received: from localhost.localdomain (unknown [36.112.86.14])
 by smtp1 (Coremail) with SMTP id C8mowACXWUmZV+lfp_UtNA--.28418S2;
 Mon, 28 Dec 2020 11:57:15 +0800 (CST)
From: Defang Bo <bodefang@126.com>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH] drm/amd/display: avoid null pointer dereference in
 dm_set_vblank
Date: Mon, 28 Dec 2020 11:57:06 +0800
Message-Id: <1609127826-264749-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8mowACXWUmZV+lfp_UtNA--.28418S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFykXw1kur48JFWrKw18AFb_yoW8XF1fpr
 s3JFyjqr48ZF1xW3srCF109r98K393Xa48GrW3Cw1aga4UAwn8Cw1rArZ2gw47WFWxC3y7
 XFy7CFW3Z3Wq9w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKQ6XUUUUU=
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbitRIJ11pECvx6lgAAs9
X-Mailman-Approved-At: Mon, 28 Dec 2020 10:19:24 +0000
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
Cc: stylon.wang@amd.com, luben.tuikov@amd.com, amonakov@ispras.ru,
 Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, aurabindo.pillai@amd.com, hersenxs.wu@amd.com,
 Defang Bo <bodefang@126.com>, Bhawanpreet.Lakha@amd.com,
 nicholas.kazlauskas@amd.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Similar to commit<dddc0557e3a0>("drm/amd/display: Guard against null crtc in CRC IRQ"), a null pointer deference can occur if crtc is null in
dm_set_vblank.

[How]
Check that CRTC is non-null before accessing its fields.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e2b23486..f820962 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4875,11 +4875,19 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
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
 
+	if (crtc == NULL)
+		return -EINVAL;
+
+	acrtc = to_amdgpu_crtc(crtc);
+	adev = drm_to_adev(crtc->dev);
+	acrtc_state = to_dm_crtc_state(crtc->state);
+
+
 	if (enable) {
 		/* vblank irq on -> Only need vupdate irq in vrr mode */
 		if (amdgpu_dm_vrr_active(acrtc_state))
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
