Return-Path: <SRS0=XXlo=6X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6D8C28CBC
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 05:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9875E21582
	for <amd-gfx@archiver.kernel.org>; Sat,  9 May 2020 05:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5Ebw7qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9875E21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E136E2DD;
	Sat,  9 May 2020 05:48:52 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269C86E2DD
 for <amd-gfx@lists.freedesktop.org>; Sat,  9 May 2020 05:48:51 +0000 (UTC)
Received: by mail-pl1-x643.google.com with SMTP id f8so1681473plt.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 May 2020 22:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ey8ihMDcq5lPVGGt9tCUN35dcPOnrYdAtKJxhMeE0cg=;
 b=k5Ebw7qyMGYj5Y4XFR4a0Tt8qdkixY/WwVsAmMhYo/PH5NByBnnw6kbnh6ZhXW3g1o
 Pm3b+qekRNtcZGDp8NJ+DqPj9beD60ArZLfWZm0DgnKTJQpomDee80OV9K4NudX5BG2h
 JGJepBdrrSMLMmiXly/qcsDerb3HUMOzcAeYC2hIcCL6Ad6t6VvSTFVrgQWiBtE88c8f
 DTUzxkyv083eem0wK/e2rICZB0eQJ5ACy2oBSTYwJGtm5ayyVvb6IXe5OO7f+wOOwz+a
 5DLA5uGvXIHvN+BlE83OnFntDP2YoGjMJMetA25pDuGPAgfWiE4jlILzOQvU6fxQhahf
 IbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ey8ihMDcq5lPVGGt9tCUN35dcPOnrYdAtKJxhMeE0cg=;
 b=DZGzKu7FhDbY/T7pUEJB1RLpUssltPLfejfHWqyyKOWpeIfZlbbaf636J2XVDUFSad
 bB6RpeuQEXbzfsAO0q88OTN7OWmgjA3SkWLjHpoNIu9kLke/w4RJlkmwnVivIg0Hi6Qx
 aAO74rHZJl6Nsj2AyxXtjfqUFm51eTUhT3InQ0gq8A3TyAtm+MXJu52xWeHRftqFBrC0
 Nwu+fb1mcvg2alSSMHH3BabEvNc140vay37dxa/saO58qi8wrCV2+aBdzqodPm8OMKaK
 avB48Xe+UlEgjHYE9/5e4qnLOUk+szk8g/2neJ7CGrKE+mR5F/hJZq3JDmiKAYCEcn2X
 G5WQ==
X-Gm-Message-State: AGi0PuYS8GMai8ICP4nBNiwvRTaNwacYk0k9qiKUCvHchh0Qila3kStG
 qKA0oti5j0CpmEWgPM8x34PPdnUzXjk=
X-Google-Smtp-Source: APiQypKY4TDfhlVNqTeoA0OsgRkJTKHenCAXBKwLCv3c3mqDCW65elQj41+oScX8BRcwkBXm2Xm73Q==
X-Received: by 2002:a17:902:fe92:: with SMTP id
 x18mr4487437plm.261.1589003330708; 
 Fri, 08 May 2020 22:48:50 -0700 (PDT)
Received: from localhost.localdomain ([203.90.236.159])
 by smtp.gmail.com with ESMTPSA id c2sm3530328pfp.118.2020.05.08.22.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 22:48:49 -0700 (PDT)
From: Binbin Zhou <zhoubb.aaron@gmail.com>
To: alexander.deucher@amd.com,
	hristian.koenig@amd.com
Subject: [PATCH] drm/admgpu: check HDMI HPD status after ddc probe
Date: Sat,  9 May 2020 13:48:34 +0800
Message-Id: <20200509054834.21484-1-zhoubb.aaron@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: zhoubinbin@uniontech.com, Binbin Zhou <zhoubb.aaron@gmail.com>,
 amd-gfx@lists.freedesktop.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now, we check the presence of the EDID to determine if there is a monitor
present.

DVI-I connectors have both analog and digital encoders and the HPD pin
is only reliable on the digital part.

But when I pull out the Radeon HD8570's HDMI connector, the HDMI status
in system is still perform connected.

asd@asd-PC:~$ cat /sys/class/drm/card0-HDMI-A-1/status 
connected

At this moment, if I want to read the EDID by /dev/i2c-X with I2C
driver, there is no EDID can be read.

Dmesg witha drm.debug=0x6, we can find the following message:

[drm:drm_helper_hpd_irq_event] [CONNECTOR:41:HDMI-A-1] status
updated from connected to connected

Based on the appearance, I thought to check the HPD status again, because
the HPD status is perform disconnected, after amdgpu_display_ddc_probe().
If the amdgpu_display_hpd_sense() return false, I think the HDMI connector
status is undefined, and just return disconnected simply.

I'm not sure if it happened to other AMD cards.

Signed-off-by: Binbin Zhou <zhoubb.aaron@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index f355d9a752d2..ee657db9a228 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -973,7 +973,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 	const struct drm_encoder_helper_funcs *encoder_funcs;
 	int r;
 	enum drm_connector_status ret = connector_status_disconnected;
-	bool dret = false, broken_edid = false;
+	bool dret = false, broken_edid = false, undefined_flag = false;
 
 	if (!drm_kms_helper_is_poll_worker()) {
 		r = pm_runtime_get_sync(connector->dev->dev);
@@ -988,7 +988,12 @@ amdgpu_connector_dvi_detect(struct drm_connector *connector, bool force)
 
 	if (amdgpu_connector->ddc_bus)
 		dret = amdgpu_display_ddc_probe(amdgpu_connector, false);
-	if (dret) {
+
+	/* Check the HDMI HPD pin status again */
+	if (!amdgpu_display_hpd_sense(adev, amdgpu_connector->hpd.hpd))
+		undefined_flag = true;
+
+	if (dret && !undefined_flag) {
 		amdgpu_connector->detected_by_load = false;
 		amdgpu_connector_free_edid(connector);
 		amdgpu_connector_get_edid(connector);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
