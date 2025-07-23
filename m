Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209D9C87FCA
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63DB10E809;
	Wed, 23 Jul 2025 15:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X4wx8iOQ";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC66110E17F
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:32 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-454f428038eso59711205e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286311; x=1753891111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEZJ0p+vd9HUeRl8dUJLFnSj5uJ/WaEBGxPMS8dMhac=;
 b=X4wx8iOQVMQgCamXnVgI4JXes+8lii80RUO3CrzGkz8EytuPC9/K+U/e67d1JLNlzc
 SUGMSbAUCQQkQscztCqCJsrKphwsdYFsL/dBMH6+yTJGc2QYoUl4FaLCtHH/aFXrQI4p
 RNoU6HvigtlgJJcuDqBE+5QTJsX3AzjbskW7b3eYb25J+vvU04kNRljetBw5KpCO1/84
 pUvxqChfuzG6XFimIt4xJmODA4RjNVCk8m1MU/WGUk7tIMmAzc5qRzuAb/6Hd7mdiWWD
 Bz8KbEjbfeSOUVPnKFklUAW0Z6w0vaUkJjl5E0pJyHriZ7JcqAU8JTBaCFCsrz2/EJwm
 KZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286311; x=1753891111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEZJ0p+vd9HUeRl8dUJLFnSj5uJ/WaEBGxPMS8dMhac=;
 b=LQ46BULi7EOO01n57va9EsUNogb6Ob3qrBAXoNkBp7rkYbiUo6d3BlYzbUobQApeHq
 yeBaG8M6Sz2e1Og/h68nXQaR2S/StD8HYneW+QTCdQnFsgZC/WiaJMgntIXSnZymAVhq
 R+df1W+4c4k8Gc66qF8/0bErxvJ2lGHwYQXUJCymOhg4g60hmIVBqPptfWUu9hRDIQwH
 wc3uL38wpL9xdGhER9GPreS9m0WcvMO151GVdVQbTiZwLbrHdaoXlrtT8VgCLZiy5kof
 l+tiN91mhP7Ix4bPlfNfCq44G4SJIHZZG1s5Ix5Y3zkwIHtYDg85gcqYhkDcYG0fdt7Y
 IYng==
X-Gm-Message-State: AOJu0Yxk1DW3EIJQkZ0ylWhp01mB0hXKlBjM58CyzuidEiP1NpPVweQj
 KAVpjDYwyw38djwP7kQcJCk/jvZcdggCnA5dr+YFknvzr9dkaK2FLc5EBVkR1g==
X-Gm-Gg: ASbGnctIyB44fNFXOCW03jeap/STL38im0A/+NYfCIs/7iiy8TSmYSDEt32wbuy8JQC
 IMArDpIgGfi64Yo2a1gF9Jf6lR4Oas4KVh8jOsZDjKKYYKVVbOWI/FIvRVxCpYAHXfa64S1L1Tr
 0w+o4CS3Pr746GH9QTWsMb48ggDXctuwop1gvhgt/y1d42UkwTbVSLJh708Qyz6jjXXg5bDScTp
 D2uIdahTiEMr9ifIKAZ0isyq4t4T6sxo/NPv/EQYtXLeYapBRUShbUn+FGSxm/ZNFtB7on0OL3u
 0Xw5gQT3o7ccUsPa5MnPSUfo3VNs/qY9chfupdc87+E44ZkAd8FI8qJLS+8TPRbjYz0nBLT5fg9
 BqOflmOAJAMdcfxlgwy8fCm1UdlOKZv0J/4TD8q7ZoTTZZbxbtDiViRF7CorE7W/7ylE/+4UFO1
 OKs8v0n53n4TnEqcKJK/9oUnNqYA==
X-Google-Smtp-Source: AGHT+IHGoyPgfgaPwAPR2HsZnrbkCX8CSDruZ26c/KBbPnU+IkUtT6gvTuqZkgD4reJ40KfsO9SL1A==
X-Received: by 2002:a05:600c:46c8:b0:44a:b478:1387 with SMTP id
 5b1f17b1804b1-45868cfba61mr36249055e9.17.1753286311136; 
 Wed, 23 Jul 2025 08:58:31 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:30 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 14/20] drm/amd/display: Poll analog connectors
Date: Wed, 23 Jul 2025 17:58:07 +0200
Message-ID: <20250723155813.9101-15-timur.kristof@gmail.com>
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

VGA connectors don't support any hotplug detection, so the kernel
needs to periodically poll them to see if a display is connected.

DVI-I connectors have hotplug detection for digital signals, and
some analog DVI cables pull up that pin to work with that.
However, in general not all DVI cables do this so we can't rely on
this feature, therefore we need to poll DVI-I connectors as well.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 60 ++++++++++++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  8 +++
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c347b232ae06..13823469fa7c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3736,7 +3736,9 @@ void amdgpu_dm_update_connector_after_detect(
 	drm_dbg_kms(dev, "DCHPD: connector_id=%d: Old sink=%p New sink=%p\n",
 		    aconnector->connector_id, aconnector->dc_sink, sink);
 
-	guard(mutex)(&dev->mode_config.mutex);
+	/* When polling, DRM has already locked the mutex for us. */
+	if (!drm_kms_helper_is_poll_worker())
+		mutex_lock(&dev->mode_config.mutex);
 
 	/*
 	 * 1. Update status of the drm connector
@@ -3799,6 +3801,10 @@ void amdgpu_dm_update_connector_after_detect(
 	}
 
 	update_subconnector_property(aconnector);
+
+	/* When polling, the mutex will be unlocked for us by DRM. */
+	if (!drm_kms_helper_is_poll_worker())
+		mutex_unlock(&dev->mode_config.mutex);
 }
 
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
@@ -7061,10 +7067,48 @@ create_stream_for_sink(struct drm_connector *connector,
 	return stream;
 }
 
+static enum drm_connector_status
+amdgpu_dm_connector_poll(struct amdgpu_dm_connector *aconnector, bool force)
+{
+	struct drm_connector *connector = &aconnector->base;
+	struct drm_device *dev = connector->dev;
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct dc_link *link = aconnector->dc_link;
+	enum dc_connection_type conn_type = dc_connection_none;
+	enum drm_connector_status status = connector_status_disconnected;
+
+	mutex_lock(&aconnector->hpd_lock);
+
+	if (dc_link_detect_connection_type(aconnector->dc_link, &conn_type) &&
+	    conn_type != dc_connection_none) {
+		mutex_lock(&adev->dm.dc_lock);
+
+		if (dc_link_detect(link, DETECT_REASON_HPD))
+			status = connector_status_connected;
+
+		mutex_unlock(&adev->dm.dc_lock);
+	}
+
+	if (status == connector_status_disconnected) {
+		if (link->local_sink)
+			dc_sink_release(link->local_sink);
+
+		link->local_sink = NULL;
+		link->dpcd_sink_count = 0;
+		link->type = dc_connection_none;
+	}
+
+	amdgpu_dm_update_connector_after_detect(aconnector);
+
+	mutex_unlock(&aconnector->hpd_lock);
+	return status;
+}
+
 static enum drm_connector_status
 amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 {
 	bool connected;
+	bool analog_connector;
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 
 	/*
@@ -7083,6 +7127,15 @@ amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 
 	update_subconnector_property(aconnector);
 
+	analog_connector =
+		aconnector->dc_link->link_id.id == CONNECTOR_ID_DUAL_LINK_DVII ||
+		aconnector->dc_link->link_id.id == CONNECTOR_ID_SINGLE_LINK_DVII ||
+		aconnector->dc_link->link_id.id == CONNECTOR_ID_VGA;
+
+	if (analog_connector && drm_kms_helper_is_poll_worker() &&
+		(!connected || aconnector->dc_sink->edid_caps.analog))
+		return amdgpu_dm_connector_poll(aconnector, force);
+
 	return (connected ? connector_status_connected :
 			connector_status_disconnected);
 }
@@ -8442,9 +8495,12 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 			link->link_enc->features.dp_ycbcr420_supported ? true : false;
 		break;
 	case DRM_MODE_CONNECTOR_DVID:
+		aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
+		break;
 	case DRM_MODE_CONNECTOR_DVII:
 	case DRM_MODE_CONNECTOR_VGA:
-		aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
+		aconnector->base.polled =
+			DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index b61e210f6246..327a3965fda1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -892,6 +892,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 	struct drm_connector_list_iter iter;
 	int irq_type;
 	int i;
+	bool need_polling = false;
 
 	/* First, clear all hpd and hpdrx interrupts */
 	for (i = DC_IRQ_SOURCE_HPD1; i <= DC_IRQ_SOURCE_HPD6RX; i++) {
@@ -905,6 +906,8 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		struct amdgpu_dm_connector *amdgpu_dm_connector;
 		const struct dc_link *dc_link;
 
+		need_polling |= connector->polled != DRM_CONNECTOR_POLL_HPD;
+
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
 
@@ -946,6 +949,11 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	if (need_polling) {
+		drm_kms_helper_poll_init(dev);
+		drm_kms_helper_poll_enable(dev);
+	}
 }
 
 /**
-- 
2.50.1

