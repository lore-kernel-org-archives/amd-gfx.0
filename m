Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB7EC83F1A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC04D10E193;
	Wed, 23 Jul 2025 15:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VC7ON7iK";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D2F010E7FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:23 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so10108f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286302; x=1753891102; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UXyXfkMxp22o+M/HQSxdQFREv7spjYdUT6dNcW9SsNk=;
 b=VC7ON7iKqAsrOy2mq6qjylovqV0nG/kyUhJHg+Bm/o1u1RGWiqGtOqV/+W227gdjOA
 Yaa1boGlO/PYIRbp+iAZhQu1+RjwaoI9i9ECf0QWdjVtZjDssNo4lU9lLo7xbWJ/B0r0
 z2FOC36tCyoHXN9Jrd9P0vcHVuCKBNf4a5kcj8qywNYNhNMnf4azovWS4vVZ5JXbueGP
 pxKKOjEq8rGQeyZengJqiZZpLgX/kM8jESsYZdjEowVRV24LGiCAyS0McDwqqh/jVHlh
 H5a5vpjxnIfQwKGEQ3rU8EZxAqKE5ZpZOC4EOxvPiKud0WdsssyoH/fj6W4KzlMbojuU
 uSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286302; x=1753891102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UXyXfkMxp22o+M/HQSxdQFREv7spjYdUT6dNcW9SsNk=;
 b=ssUdA7ZClpEHuIbkgsHdUARTH8XbvMNti20hzWFf4LPEBmOyBWZvBLJU4kI+e8W1Gq
 0c67OwAtXDkZAH1yg4MrU8px7oITMEwO/R5qA+a7W191UYfjRFllQiuptrJT5yEzn3xQ
 CYWUcHYJHg8tcXYjLQ9+z2gI4GDf/aMi4df8Tyh1OQfzMf4XhZoet2tFUHLhfSzArnL7
 ylZo+qAXrlO3udEDwsatddR2QpiLzwi/ZarRP+q1UzAZvht8wx6aZ4Q2fgGwTLiGiZE7
 2J/xcHKWaKylcutPqmJ6XLUSYooTtLmYni6vR8PXhrSthCHn5bBKAbLf5dZbJ2pfBcA3
 a9FQ==
X-Gm-Message-State: AOJu0YyKRKd/icKWV3IcspNEsrbKFPS8HZq88W+adllyAxc0vOBtKoDc
 v/UY/RJSIYksijeG3AocwCvaBgipMjEvPvXVksko5fGfdOdsegOQXQkSyJb6LA==
X-Gm-Gg: ASbGncvMjhaCOsGqkHvGc7v0OsZ4gtyw/8vJ+XyeloqUEgVwX/rqBYOhZFGEV20sJco
 6vg+Cux4RpGauEiRCoHTaqI16wESEtoPjomUuMg3looWrv4+ergCYVzgqZfx+oaX9Gaoi3NSQkq
 SbKDfITxcP+/l+1Rl1oFS9Q3FGHitIWwUQHDiKV4mDlzEnE4oLOc4Uc2su7liYiWXCw0ESQPVeh
 mdpofWa8A8gsXX1dku/7mhF9rNfZQoFuuLKIKOdn7ChjdAA0qF8XEBoNirg6ddt8SvdqgztWDty
 bYAw/ZxslytnlrKxHiCyC0OM34oyr1OMq0nguJQRhfrV77wT36h4wPvuXy2bUlEjPoqLXFaMuhX
 q9dHxr6qr4rIvewzYKJgzx109hd8VYj+kzfDxkTJNMwLfockl/VJUh1no91dQKykQIwsutVF169
 riVt1OM6uTX5Q0Ir/cWmXUx6VoYA==
X-Google-Smtp-Source: AGHT+IFGBpAk0Tzc7xDYzMzGtRmFcOu9JDOHA6b7T8yZVIguTcguQHicxKQdg69gYlELfW8Xshh19A==
X-Received: by 2002:a05:6000:230d:b0:3b3:9c56:b834 with SMTP id
 ffacd0b85a97d-3b768c9d38dmr2736475f8f.1.1753286301423; 
 Wed, 23 Jul 2025 08:58:21 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:21 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 01/20] drm/amd/display: Determine DRM connector type more
 accurately
Date: Wed, 23 Jul 2025 17:57:54 +0200
Message-ID: <20250723155813.9101-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Previously, DC determined the DRM connector type based on the
signal type, which becomes problematic when a connector may
support different signal types, such as DVI-I.

With this patch, it is now determined according to the actual
connector type in DC, meaning it can now distinguish between
DVI-D and DVI-I connectors.

A subsequent commit will enable polling for these connectors.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 096b23ad4845..c347b232ae06 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8038,24 +8038,26 @@ static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_state *state,
 	return 0;
 }
 
-static int to_drm_connector_type(enum signal_type st)
+static int to_drm_connector_type(uint32_t connector_id)
 {
-	switch (st) {
-	case SIGNAL_TYPE_HDMI_TYPE_A:
+	switch (connector_id) {
+	case CONNECTOR_ID_HDMI_TYPE_A:
 		return DRM_MODE_CONNECTOR_HDMIA;
-	case SIGNAL_TYPE_EDP:
+	case CONNECTOR_ID_EDP:
 		return DRM_MODE_CONNECTOR_eDP;
-	case SIGNAL_TYPE_LVDS:
+	case CONNECTOR_ID_LVDS:
 		return DRM_MODE_CONNECTOR_LVDS;
-	case SIGNAL_TYPE_RGB:
+	case CONNECTOR_ID_VGA:
 		return DRM_MODE_CONNECTOR_VGA;
-	case SIGNAL_TYPE_DISPLAY_PORT:
-	case SIGNAL_TYPE_DISPLAY_PORT_MST:
+	case CONNECTOR_ID_DISPLAY_PORT:
 		return DRM_MODE_CONNECTOR_DisplayPort;
-	case SIGNAL_TYPE_DVI_DUAL_LINK:
-	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+	case CONNECTOR_ID_SINGLE_LINK_DVID:
+	case CONNECTOR_ID_DUAL_LINK_DVID:
 		return DRM_MODE_CONNECTOR_DVID;
-	case SIGNAL_TYPE_VIRTUAL:
+	case CONNECTOR_ID_SINGLE_LINK_DVII:
+	case CONNECTOR_ID_DUAL_LINK_DVII:
+		return DRM_MODE_CONNECTOR_DVII;
+	case CONNECTOR_ID_VIRTUAL:
 		return DRM_MODE_CONNECTOR_VIRTUAL;
 
 	default:
@@ -8440,6 +8442,8 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 			link->link_enc->features.dp_ycbcr420_supported ? true : false;
 		break;
 	case DRM_MODE_CONNECTOR_DVID:
+	case DRM_MODE_CONNECTOR_DVII:
+	case DRM_MODE_CONNECTOR_VGA:
 		aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
 		break;
 	default:
@@ -8631,7 +8635,7 @@ static int amdgpu_dm_connector_init(struct amdgpu_display_manager *dm,
 		goto out_free;
 	}
 
-	connector_type = to_drm_connector_type(link->connector_signal);
+	connector_type = to_drm_connector_type(link->link_id.id);
 
 	res = drm_connector_init_with_ddc(
 			dm->ddev,
-- 
2.50.1

