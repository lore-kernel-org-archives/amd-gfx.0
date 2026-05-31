Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FB3CD5BD1
	for <amd-gfx@archiver.kernel.org>; Sun, 31 May 2026 10:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE7610E612;
	Sun, 31 May 2026 10:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q68768eW";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79EED10E610
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 10:57:50 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490a7a9f81bso2534305e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780225069; x=1780829869; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I668lwd5SLul5IOrPcF/oA6+I6LEkoID2bipgaUemN8=;
 b=q68768eWGsbdUaygsp0lmfx6+BaXqUNPnnZW8VjYNNCeDx+MaqGlnHqJszEbyd59Zp
 iVXSq81zI/KeSGBShQDUnnpc7SBhGt0ndaW5ZS05PPxF6jDWfcHiTk2vwOUdY9xYARAK
 HOt9+c3IbFS8AVopmFgJN5kwn04uG97tPBIIX7ZnmP7IwXbzUqdJWIMsbN6huumRYmsR
 0OY9gQ40HnLdjNt/hBmKzE4QJwKl5FlSrHyATGfwX9snUHFQM6ZN0PflvD71iJFsJDy7
 P2pSYiWL5KKUp0Bwy1TC0BPMwlqSBjIQUABrh4mdT+nCh0mRje143lGhImTiASQcwlo8
 ZTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780225069; x=1780829869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I668lwd5SLul5IOrPcF/oA6+I6LEkoID2bipgaUemN8=;
 b=tSXfIA3iGgt94mw6SjdL3xGIJuPMEfaWVhp2fO+18/+9ockn7Qj4sOTNSjekY/j1Ch
 vJHAZTgD3cOMCeZLzN+pKTCrXcmQC0HHrIJRv03rk9YXXg+8xQtAh4ozXdR89nb/jdKV
 NsMC1c8KXVLs4fbumXQ4R5QEUDiQf/EgRQyTeGIA3GsTe79baV4K+Hl2fXTVYnJvB1ES
 7AEmA7Kw5Vh0ap3gceaXgzpW0JEj6ukP6BiroOhn244KPZSi7n+t3Pi/COUahXJbk4Gf
 VX03YiGxTTlAUS2t4+TVffAUDsdgHVLusqLqAVC/x2cC1OFcn8tBh60+m+GJM5VpjgOa
 TUnw==
X-Gm-Message-State: AOJu0YwNpScZBuM+AwaoFogfHn8x8hTyorBrrND7IwaBykaK3N4Jr0M0
 8MCnThdpNsBEI9x0IU4piW21hIsS/djk36uIeCHsZpxKqGnSCrfhYbFISJiBXcaj
X-Gm-Gg: Acq92OHWyRRSwdFJDxVtYZgq00n8PCjy9GZuvKoA0RbPwq5Qyq9p60HZpLhcOlnPH5b
 sHgxemrzqoUhhf6C5tWRirRWygiQFnvRVS7UTqtx4/DI1+GCb3acLorG6Xb2sfDrRzPW7YMrPK2
 nOMyAn55UVBsPjGXXMZNZ/rMllHLOS3R3p8o5CKMi3nOufKDnI6t3uwZy4dCgjNQd4mGts1Yqx/
 JCYq+WxyH/QSPAk9Kzt9sbT6KF7xzb5qb3dbaGGKCUY/erANDtvmI6XxpCwAB3J7A3RgpJPh9Jj
 SZ+TouwDBAoPFFjIG47wZyxnyT909eJqiVh72TK2P/SAWHcHROgLOnBFWyaqar4nGdrsxxeT0hY
 XbpHS+GVLPYzcW9m0GrUmRciFiAVJ/OjJgJj3moCHeZ+iOELwtB77E6jkvK9QmkzDLwQpRpJYo7
 em5pomP347WzM3DT5MJyWkStFgtmM799rfZ5QNyDDaE5sMipwBPcE/FA6+riAYKtWZynLKBsfBG
 TrFLuAkuQHMJHJH
X-Received: by 2002:a05:600c:45c9:b0:490:8b0b:d3b1 with SMTP id
 5b1f17b1804b1-490a2a4bac0mr91980615e9.12.1780225068954; 
 Sun, 31 May 2026 03:57:48 -0700 (PDT)
Received: from Timur-Max.c.hoisthospitality.com (184.31.0.109.rev.sfr.net.
 [109.0.31.184]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68980csm192904065e9.1.2026.05.31.03.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 03:57:48 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/5] drm/amd/display: Add detect reason to
 handle_hpd_irq_helper
Date: Sun, 31 May 2026 12:57:40 +0200
Message-ID: <20260531105744.28717-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531105744.28717-1-timur.kristof@gmail.com>
References: <20260531105744.28717-1-timur.kristof@gmail.com>
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

This makes it possible to reuse the function for other purposes
in the next few commits, such as HPD RX.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index af0af7519517..c071c27d8313 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -239,7 +239,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_state *state);
 
-static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector);
+static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
+				  enum dc_detect_reason reason);
 static void handle_hpd_rx_irq(void *param);
 
 static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
@@ -887,7 +888,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 		if (notify->type == DMUB_NOTIFICATION_HPD) {
 			if (hpd_aconnector->dc_link->hpd_status == (notify->hpd_status == DP_HPD_PLUG))
 				drm_warn(adev_to_drm(adev), "DMUB reported hpd status unchanged. link_index=%u\n", link_index);
-			handle_hpd_irq_helper(hpd_aconnector);
+			handle_hpd_irq_helper(hpd_aconnector, DETECT_REASON_HPD);
 		} else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ) {
 			handle_hpd_rx_irq(hpd_aconnector);
 		}
@@ -4300,7 +4301,8 @@ static void hdmi_hpd_debounce_work(struct work_struct *work)
 	}
 }
 
-static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
+static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
+				  enum dc_detect_reason reason)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
@@ -4347,7 +4349,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 		dm_restore_drm_connector_state(dev, connector);
 		drm_modeset_unlock_all(dev);
 
-		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
+		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED ||
+		    reason == DETECT_REASON_HPDRX)
 			drm_kms_helper_connector_hotplug_event(connector);
 	} else if (debounce_required) {
 		/*
@@ -4379,7 +4382,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 
 		scoped_guard(mutex, &adev->dm.dc_lock) {
 			dc_exit_ips_for_hw_access(dc);
-			ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+			ret = dc_link_detect(aconnector->dc_link, reason);
 		}
 		if (ret) {
 			/* w/a delay for certain panels */
@@ -4390,7 +4393,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 			dm_restore_drm_connector_state(dev, connector);
 			drm_modeset_unlock_all(dev);
 
-			if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
+			if (aconnector->base.force == DRM_FORCE_UNSPECIFIED ||
+			    reason == DETECT_REASON_HPDRX)
 				drm_kms_helper_connector_hotplug_event(connector);
 		}
 	}
@@ -4400,7 +4404,7 @@ static void handle_hpd_irq(void *param)
 {
 	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
 
-	handle_hpd_irq_helper(aconnector);
+	handle_hpd_irq_helper(aconnector, DETECT_REASON_HPD);
 
 }
 
-- 
2.54.0

