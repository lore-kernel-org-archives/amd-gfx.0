Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A986606A32E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XO7c3SyH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1EF810E341;
	Tue, 24 Nov 2026 16:57:09 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55BF10E6D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 16:57:03 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so61010985e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 08:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795539422; x=1796144222; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jbUthWdRMMj51XLCsqRl2+vc3sJ3ROclkjX4dXujHnA=;
 b=XO7c3SyHY7d6DcUPBg8JIahBADVcjT2mKPiJI0bs/0o3h+U1lT35OA5DrIQG0NsY8o
 qR/OPD5AkmO6XQfC+mA8U2vvwSKO0ZRiWPZdKLYoUIva8+B97tX/6lCVQHloK+mCCLAO
 tjldV3IQqg+d78jkS9Vx9BphtR3m3+59hmNVZov5tQGDNM4FPEZSg4YiFy26ZdD9C56W
 zpwdlzMpe07gQg4bVsKEwnwFTv+JKlYc0uIlFSa4ZEsDJza+dOrezgIK+75MoVkSF41/
 WBi1ZNaxOXB++fQSCPEij4RUhc//Ga1W2mx3S03akVeqX+ctRfBHL8TFZUEmkV/l7vEv
 gaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795539422; x=1796144222;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jbUthWdRMMj51XLCsqRl2+vc3sJ3ROclkjX4dXujHnA=;
 b=VqiDrrxF5fel+bZU6yTwzOyfM3Xsr++1SHtpa9UQ5Z90KH3LuUpb0UckCLRRLUqUAC
 +B4bOwY47IJdwddENsVB7WrWgPuCItVQNLXwkLOkrJ3IWz4zT9TCVVAM08pfev3z0FOj
 s1Jw0SFia4+SBthEwFJ/MY6QYmOzk8SOAqBFcxBCeJCYtF1UgnJeCp3I9qjzrmevnVj9
 +E89JgykZxAwLE6uTxeln16fa1YUszjaFJkc2etwMFXMPf6/PVxfbvRS+dnfu05ZZU6W
 TG8CMvbYoXMsVXAeBsiQtjl/O1c4pHJY9vBYpCdpim0TGi8WL5sbVqPEZIZ4YEhn5nor
 AQeA==
X-Gm-Message-State: APuU4Z8BUBWnP1K/8Sg4GkaBvv/5/Of91OrK+2LKF2FNXDiU+XLQmbuk
 ntSBLg0mFnPsDknVrlhttnKkUWf7ZoN1ppLyAWX9sJHhj9c32o/6E7dDrUEtYi4=
X-Gm-Gg: AZFdTZfBhc4bTIHEOh/ZGDg6WqoGXgvk2Os4Q/FUstACwu53Y534EPO50+npGVVdHhl
 a3bp2meJLk3NB3cdYmitV5D41hsBH0zmn5oqguJJCBUABdeYumEjq5JEjW361ddwJ+pm+dDIE20
 zB6oFWeBSf0MsIcaP3mrRwRjzvv8go+gDl8pKL+V+a6PckvOZOrRLsAFsJGS8zcLamExBQqQsXN
 qYKXcfZJuqmeZsYsH52IWQTBmSc7IlOWLQNsYqVbZMOL322rs+e/3HJ+HedB0oOq1MJQ+ksIlNt
 MPqNfu6CIYT31lxm0pW/eC16hdVS8CUjtf2OvP5HkmZXk9n4tb1gcuOZVCbzm9Bq7dZm72zi0X4
 qmhMglJUdUnoZYMBr/poMv47vIwLJSQxXRGK69SLSef+sryxrPan2QSg8/8OVG9DmYJPDhI8qiD
 Br2sNqANUQ7yhTMAqk98mfM5pRmsGVHJUB6F0hJqNY/Uox6X2sbiG+TdzS8HXL73IfLuIJt03IW
 2C+b0s9v+LooGtbACJcEjWee8y1IVkVY9FwQdex4K2L4YyQk4WK0FrqVafbLPnxZKqwvp6Ldg6e
 ei5j6f7FXTx0aaj8OW08JMBYPhR0ow==
X-Received: by 2002:a05:600c:c173:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4bb88800134mr299004235e9.11.1795539421842; 
 Tue, 24 Nov 2026 08:57:01 -0800 (PST)
Received: from Vivobook.home ([80.116.179.188])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm503208055e9.10.2026.11.24.08.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:57:01 -0800 (PST)
From: ivano <ivano.cristofolini@gmail.com>
X-Google-Original-From: ivano <ivano@Vivobook.home>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Ivano Cristofolini <ivano.cristofolini@gmail.com>
Subject: [PATCH] drm: add min-backlight quirk for ASUS Vivobook 14 M1407KA
 (CSW MNE007QS3-6)
Date: Tue, 24 Nov 2026 17:56:43 +0100
Message-ID: <20261124165643.10016-1-ivano@Vivobook.home>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ivano Cristofolini <ivano.cristofolini@gmail.com>

The ASUS Vivobook 14 M1407KA (AMD Krackan iGPU) uses a CSW MNE007QS3-6
eDP panel.  Its ATIF backlight caps report a minimum input signal of
12/255, so amdgpu clamps the PWM backlight at 12/255 (3084/65535) —
far too bright for the lowest slider step in dark environments.
Windows on the same machine reaches visibly lower levels.

Add a drm panel backlight quirk lowering the minimum to 1/255
(257/65535), following the existing Framework entries.  The panel is
stable at these levels; no flicker observed.

Tested on ASUS Vivobook 14 M1407KA, BIOS M1407KA.332, kernel
7.0.0-44-generic.  Boot log:

  amdgpu 0000:03:00.0: [drm] Applying panel backlight quirk, min_brightness: 1

and writing 200 to /sys/class/backlight/amdgpu_bl1/brightness now
yields actual_brightness 257 (stock driver clamps at 3084); maximum
brightness unchanged.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/6198
Signed-off-by: Ivano Cristofolini <ivano.cristofolini@gmail.com>
---
 drivers/gpu/drm/drm_panel_backlight_quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_backlight_quirks.c b/drivers/gpu/drm/drm_panel_backlight_quirks.c
index 2d02383..0ee711d 100644
--- a/drivers/gpu/drm/drm_panel_backlight_quirks.c
+++ b/drivers/gpu/drm/drm_panel_backlight_quirks.c
@@ -54,6 +54,16 @@ static const struct drm_get_panel_backlight_quirk drm_panel_min_backlight_quirks
 		.ident.name = "NE135A1M-NY1",
 		.quirk = { .min_brightness = 1, },
 	},
+	/* ASUS Vivobook 14 M1407KA: ATIF caps keep the PWM minimum at 12/255,
+	 * which is far brighter than the panel can safely go
+	 */
+	{
+		.dmi_match.field = DMI_SYS_VENDOR,
+		.dmi_match.value = "ASUSTeK COMPUTER INC.",
+		.ident.panel_id = drm_edid_encode_panel_id('C', 'S', 'W', 0x143f),
+		.ident.name = "MNE007QS3-6",
+		.quirk = { .min_brightness = 2, },
+	},
 	/* Steam Deck models */
 	{
 		.dmi_match.field = DMI_SYS_VENDOR,
-- 
2.53.0

