Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789DBCD4F3C
	for <amd-gfx@archiver.kernel.org>; Sat, 16 May 2026 18:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C84110E586;
	Sat, 16 May 2026 18:52:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PmfbwzMe";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C4710E547
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 May 2026 18:52:36 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso4293515e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 May 2026 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778957555; x=1779562355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Of5uJ4G2xF4w03OvBq3FrKhJGQfgKwZiWtACnNDXJdY=;
 b=PmfbwzMeen5/Oz3+AprV4zHq7Zr6oMmV13yJ8Fk8IQW+NatzIDyJtVNdmRxKNv0USf
 G0C6s0LOzYhF0ATQdi2ALbxG7pH3mj8ArnU0IIC6IQrETnZhtOb1f3vb51sQHi89Unle
 F3c2R22r5rTOgfYwK185wgnUKxxdgJvzCjzN8MprI6Mxm7iKBXzx11S9Awxt3MAUaYM4
 5bFMcsSsdfItD8afXjwwZBIyj6afdYAMAqT2Zblo14/9ER0pWrx6yyWf9d28FX/754GZ
 fj7CLfREmFk1qLaTwHh506wwD4SEOxC6qJk0vhLExhPdYfZ/UNVb6aZbkVcZjKlqahbm
 g4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778957555; x=1779562355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Of5uJ4G2xF4w03OvBq3FrKhJGQfgKwZiWtACnNDXJdY=;
 b=eXbLTK17YuE90lkcU6X1PYEyte4MvfSl8olFxnTSnEMdqWn/OqLPQI5yJd0eD4hK4n
 PXLKzmfh+zI1Ad+WpAclZE0ksrBn8MBc6VNkzHHCS6Zq/2E+z9a5lFaYJPlGu4n6gOKP
 vV8YUGmTx/IGbvSUlPaPJjIR8YL1RPDU8dOO8nf0wFywfhfEMQMWFjtrFjLQ4m/3D4Vh
 oSY8nrQJG9ql7FgXyAsqGiP6TgN2KHUJoqGNeY7/n8q4oRnC6KHym7FrNZquAHzz+qCy
 5lf1eZpxGXcjt36sEJ9jhxHu0g4YAYhrqMowzHniIcICsqdDF+1VMaXFWe7XOK8X9SWM
 wmQA==
X-Gm-Message-State: AOJu0YzsplWHNZKGHjQd1LJiBf43royEPDoPxHHGoY+81Cvl2dsetBJu
 Jq9dGo2RTbd5xeupJYTuP4hmOMwgAfA1uXkqvHFvqZkWYg6vRB83oBi4
X-Gm-Gg: Acq92OFtIdt3R8KRX30HilZYYPyZ8yiic6Dl+FijEcuwAfvGrUmDxHRsBTaWp7ezK31
 C2qf7fVFk8+JZYbJSibwh5TBpklXp+hRwyyPQ9mD62GXN4WBnS+RzwgZBnamcL2YF/W9faEdh4i
 7Cu8NhSujDfBdbdS6HJnqXMP8KAWa+FLmBqflj1Dx0fgaeiv8g6bCqUKMjdqs/QKf1uxDaWE0BL
 BnNoulrUxouWmtSN9FuhJsiryeae5JWgQOGC1HXRuh08ojCwB07YxCjfJ1qDHS3f4jzE3gvpqSk
 UwHHcjDY97zNqJvANkdyIzFkqpGWPWjApEyqB2AAHhXxY7kJtEhNMte+7O7CuHG8yHtO6A3zaE7
 INMlbxzq1kwYPcoW7LIDkA317yKpEUTbnOkoy2hgrSUfRHrMxp1vEnKfS8eaIZzKmpVFKXPPPgZ
 An8bXVf8KY2bdk9pvdAQtSFS7DBEi7B8oJS+acJw==
X-Received: by 2002:a05:600d:10:b0:489:e696:8362 with SMTP id
 5b1f17b1804b1-48fe60d7882mr105852915e9.13.1778957555135; 
 Sat, 16 May 2026 11:52:35 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:d904:da17:d4e8:49c7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5cab818sm147773865e9.14.2026.05.16.11.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 11:52:34 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH] drm/radeon: fix eDP resume from suspend on iMac11,
 1 / DCE3.1 systems
Date: Sat, 16 May 2026 20:52:26 +0200
Message-ID: <20260516185226.3005-1-gilles.risch@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260516092420.3579-2-gilles.risch@gmail.com>
References: <20260516092420.3579-2-gilles.risch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

After suspend/resume the internal eDP display on iMac11,1 (and
potentially other DCE3.1 systems) stays dark because
atombios_set_edp_panel_power() skips panel power control for
anything older than DCE4.

Fix this by:
- Extending atombios_set_edp_panel_power() to also handle DCE3.1
  by changing the !ASIC_IS_DCE4() guard to !ASIC_IS_DCE31().
  HPD polling works correctly on DCE3.1 (verified: HPD is asserted
  at iteration 0 on iMac11,1).
- Issuing ATOM_ENCODER_CMD_DP_VIDEO_ON/OFF for DCE3.1 in addition
  to DCE4+.

Tested on iMac11,1 (Mobility Radeon HD 4850, RV770/DCE3.1).

Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
---
 drivers/gpu/drm/radeon/atombios_encoders.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 4e984973c043..b62fd713efcf 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -1383,7 +1383,7 @@ atombios_set_edp_panel_power(struct drm_connector *connector, int action)
 	if (connector->connector_type != DRM_MODE_CONNECTOR_eDP)
 		goto done;
 
-	if (!ASIC_IS_DCE4(rdev))
+	if (!ASIC_IS_DCE31(rdev))
 		goto done;
 
 	if ((action != ATOM_TRANSMITTER_ACTION_POWER_ON) &&
@@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *encoder, int mode)
 		if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)) && connector) {
 			/* DP_SET_POWER_D0 is set in radeon_dp_link_train */
 			radeon_dp_link_train(encoder, connector);
-			if (ASIC_IS_DCE4(rdev))
+			if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev))
 				atombios_dig_encoder_setup(encoder, ATOM_ENCODER_CMD_DP_VIDEO_ON, 0);
 		}
 		if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) {
@@ -1724,7 +1724,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *encoder, int mode)
 	case DRM_MODE_DPMS_SUSPEND:
 	case DRM_MODE_DPMS_OFF:
 
-		if (ASIC_IS_DCE4(rdev)) {
+		if (ASIC_IS_DCE4(rdev) || ASIC_IS_DCE31(rdev)) {
 			if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)) && connector)
 				atombios_dig_encoder_setup(encoder, ATOM_ENCODER_CMD_DP_VIDEO_OFF, 0);
 		}
-- 
2.47.3

