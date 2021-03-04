Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86E1C433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 03:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC9564EAE
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 03:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC9564EAE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF49D6E43F;
	Thu,  4 Mar 2021 03:13:43 +0000 (UTC)
Received: from lucky1.263xmail.com (lucky1.263xmail.com [211.157.147.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC126E14F;
 Thu,  4 Mar 2021 01:25:42 +0000 (UTC)
Received: from localhost (unknown [192.168.167.69])
 by lucky1.263xmail.com (Postfix) with ESMTP id 3C267B945E;
 Thu,  4 Mar 2021 09:25:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
 by smtp.263.net (postfix) whith ESMTP id
 P17142T139833580455680S1614821138633857_; 
 Thu, 04 Mar 2021 09:25:38 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <622fa203a92ef646e76853adc9a0004c>
X-RL-SENDER: wangjingyu@uniontech.com
X-SENDER: wangjingyu@uniontech.com
X-LOGIN-NAME: wangjingyu@uniontech.com
X-FST-TO: alexander.deucher@amd.com
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From: wangjingyu <wangjingyu@uniontech.com>
To: alexander.deucher@amd.com
Subject: [PATCH] MIPS: drm/radeon: A gray screen appears when going into
 hibernation(S4)
Date: Thu,  4 Mar 2021 09:25:35 +0800
Message-Id: <20210304012535.25475-1-wangjingyu@uniontech.com>
X-Mailer: git-send-email 2.11.0
X-Mailman-Approved-At: Thu, 04 Mar 2021 03:13:42 +0000
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
Cc: zhuyong <zhuyong@uniontech.com>, airlied@linux.ie,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 wangjingyu <wangjingyu@uniontech.com>, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, christian.koenig@amd.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Radeon Card:
  Caicos[Radeon HD 6450/7450/8450 /R5 230 OEM]

there is no gray screen when echo 4>/sys/module/drm/parameters/debug,
so the WREG32 function after DRM_DEBUG_KMS may have wrong when going
into hibernation.the delay of msleep(50) just can fix gray screen.

Signed-off-by: wangjingyu <wangjingyu@uniontech.com>
Signed-off-by: zhuyong <zhuyong@uniontech.com>
---
 drivers/gpu/drm/radeon/radeon_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 652af7a134bd..1be50f949bb4 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -226,6 +226,8 @@ void radeon_crtc_load_lut(struct drm_crtc *crtc)
 	if (!crtc->enabled)
 		return;
 
+	sleep(50);
+
 	if (ASIC_IS_DCE5(rdev))
 		dce5_crtc_load_lut(crtc);
 	else if (ASIC_IS_DCE4(rdev))
-- 
2.11.0



_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
