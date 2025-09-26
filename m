Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643F4CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA0010EAC4;
	Fri, 26 Sep 2025 18:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Beduoa9L";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E041010EAC4
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:33 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-27c369f898fso28132005ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909813; x=1759514613; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L22togU/qBY3wsQuifK1qZodV5w4j293ozUl4teAp9U=;
 b=Beduoa9L1A366fvOfHC81M3ZGE1jupZRmMXpJw/zN9EZNTssF+13obix7t1jtkB/47
 eC3yvr2tlz6rcNCJwr0ZsGUykvpd9JDp92tW7ejAbkQCVDVVwis510QpNo/N+WQ/xsVt
 OBEQt46+sB1Za+km5fN16BtCII7+aF2nqyojjzt3NJkxnALqtHpTfW16xipdtfNpxzLN
 fEj/P0Nf9f4PsMMjFuTvuyUF8NT26PJj2iaf2LK9pKNNfwjzjmhznhGaND6ABnv0doXJ
 Q/ehBmeJxweMUFM9w0mMFqh5Zyw0uA+HVWZaJLjzw6ey5MIUBZR7+1saWmjOAEbmVnTx
 VCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909813; x=1759514613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L22togU/qBY3wsQuifK1qZodV5w4j293ozUl4teAp9U=;
 b=ux9xQf8a9XKLBaGizKbCUFTbfYw/F3RBkaMDDT3RRq7dwLRIVM0JCITu306DfmJCeE
 30lpneED/FVHr8sqgJCANGlrh8IGLqeqOgUM1uxQnjXZ935gLA+xgkgGB6zrx17Vl96j
 lMzbRpZuW2lSmLuF+dqdyL+oDLxDjGuZK36vehR6jqhj5YACuXvqqIhwwwZmzHUVwGZ3
 FV/PIn0CCSb2S4SwufwG1lLrsck+n6vDksENPk+Tx1WElouQ/6H9GAxesG+8g7roZNsp
 bGU5HlzAhRJ+OFyo2QAZXt3UPnJ1wWQVQj42ZCHwOL6EeUbckax7GsahhtxhwTP1c9dv
 nqHQ==
X-Gm-Message-State: AOJu0YxJz00YlbAjiUWKRo73OVhzOtEhiG/Ji6SqiVue7DL1k158cV+a
 XhjW1WqfMDFIw61DnQGWK7CoxZWyVgNJzqt9jEZhSog7SVPR8Mfk2jL0js85lA==
X-Gm-Gg: ASbGncv6bMv3WVXjrymU+BlRPha+F+7ah7mNC+bIpakxoF35uGU2DX2sHT8c1egKLTn
 IF/G42T+91beV8bIpnzXquFYa3x26XhPudAmpteT8GaQYIkdM2195vtqb6N89JTJaaGjHDMaLNi
 SaLGpKqXLDDlqFhfyEuOuZ71cQBiQitsD9bDbmocF5pPJGiXbOp8Hb1P4SBz/2ufu7lr5JfXG4Z
 ULDyxT6UfVg6Abe5gBK34acy9uF+QhrW5QeRstlH9me0RNYLvAn6CH56XFZ/fNyVksXuc4iUuMi
 FT43qsZbl2EZbI9L+pzmtTq8uQqOI2JvJS6K4WHyf7xfwYe7/PnJxlMUFOVGEYeneLHPYCh/mA9
 23xaWp9undk8AIYkqFu9Qw1WVUZ3yRIfdi7+GIkwXZFpiD7ckP9EPm8czzbBAH2UD6a4X82k2w3
 JiNLmZzBpVXkUg1Gkv0aE=
X-Google-Smtp-Source: AGHT+IH+RyIgNVlS+kcONlE+n5icOrsstxHCFmPeohKcKuLfjEzS09kol39uVqJe4LeDZvdGzekwvw==
X-Received: by 2002:a17:903:bc8:b0:278:9051:8e9c with SMTP id
 d9443c01a7336-27ed4a56ce7mr71930245ad.42.1758909813388; 
 Fri, 26 Sep 2025 11:03:33 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 15/23] drm/amd/display: Refactor amdgpu_dm_connector_detect
 (v2)
Date: Fri, 26 Sep 2025 20:01:55 +0200
Message-ID: <20250926180203.16690-16-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
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

Prepare for polling analog connectors.
Document the function better.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 ++++++++++---------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4a9109818672..cdc6112e5875 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7123,29 +7123,32 @@ create_stream_for_sink(struct drm_connector *connector,
 	return stream;
 }
 
+/**
+ * amdgpu_dm_connector_detect() - Detect whether a DRM connector is connected to a display
+ *
+ * A connector is considered connected when it has a sink that is not NULL.
+ * For connectors that support HPD (hotplug detection), the connection is
+ * handled in the HPD interrupt.
+ *
+ * Notes:
+ * 1. This interface is NOT called in context of HPD irq.
+ * 2. This interface *is called* in context of user-mode ioctl. Which
+ *    makes it a bad place for *any* MST-related activity.
+ */
 static enum drm_connector_status
 amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 {
-	bool connected;
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
-	/*
-	 * Notes:
-	 * 1. This interface is NOT called in context of HPD irq.
-	 * 2. This interface *is called* in context of user-mode ioctl. Which
-	 * makes it a bad place for *any* MST-related activity.
-	 */
-
-	if (aconnector->base.force == DRM_FORCE_UNSPECIFIED &&
-	    !aconnector->fake_enable)
-		connected = (aconnector->dc_sink != NULL);
-	else
-		connected = (aconnector->base.force == DRM_FORCE_ON ||
-				aconnector->base.force == DRM_FORCE_ON_DIGITAL);
-
 	update_subconnector_property(aconnector);
 
-	return (connected ? connector_status_connected :
+	if (aconnector->base.force == DRM_FORCE_ON ||
+		aconnector->base.force == DRM_FORCE_ON_DIGITAL)
+		return connector_status_connected;
+	else if (aconnector->base.force == DRM_FORCE_OFF)
+		return connector_status_disconnected;
+
+	return (aconnector->dc_sink ? connector_status_connected :
 			connector_status_disconnected);
 }
 
-- 
2.51.0

