Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E02CAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:03:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C4910EAC2;
	Fri, 26 Sep 2025 18:03:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m+hCmBVv";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8865D10EAC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:39 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-27a6c3f482dso20506435ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909819; x=1759514619; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tM3EgE2D1EZ6aCNFVNKWsGNgouP+I5mfEFAOPS6GBek=;
 b=m+hCmBVvdJgRVLJzB+Orp3TW0v/IKP9wC9Hpid/rqPXrsfTAJ2E8dvhZnDIIJl5mxz
 Z6uf8xRys6fZ0aQ43g7854/GxW0OSoZ/5LXyVQyvrKRKOOCOEhLkgK8nSfx4zbcUcMHH
 E4f+kcsnPb8Bp14iEmeeVCNsDxJJseihhpGuKt/zws49bN0AwlByf5YIb0D5cA9CfrnU
 iCYwmnpdrFTGFr1yAfKJf3a3NgoCVKndaWhRloD+n1Y20rbHhMoTlI8Ps62HTsq0osHd
 1UKFb2jC7/ryii1V6S6CeHCqe9kFf3SaY3NsiheaH0flbgQykVUA3MOfGRiKuJupORRF
 fBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909819; x=1759514619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tM3EgE2D1EZ6aCNFVNKWsGNgouP+I5mfEFAOPS6GBek=;
 b=La+pjZ4w69Q1TaW/UKGL2YEfVY1hACR20x7tx9kOMdOTjklPRi+4Hs3IX8kQC4EHhT
 k5aI0tG7JDErLPtVx7wLOVSEjswrfIAPb0N0QUJ5xLe/P7ouTj0ZOfZbQ0qQJarah0/I
 9eiB08aGNr7PSA22g6bJip9uPren0nS85rLdK5JSyAAqW5dqeI6aX00zTRzJ2XRfxOFy
 C4BSbP+FnyuFSgKjI3iTicWZjZy7pUYitCBLLogXb4QyOHcEEFr5PkH/nYzP1DPq1nZG
 96r/aw7V3HsKMwOz6LkYrpiwpoXG0fBiPmO3nHFrhVfb6hSpeYVjMs4bWndT8tPEIz54
 LUIg==
X-Gm-Message-State: AOJu0YxaEE4yR75DG0Vc0FtQU1mG8KYWmipXLMabrG2YvuxlYLwhoDm8
 iFHDHgcCnCvugSn0zNG4yaxjkUM/FwOjdBqgDrZpUqc4wewNnaCO0oq+K9bLOQ==
X-Gm-Gg: ASbGncsSuCgz/JZpsK1fCyvuJSIeHKjVbcI16R3ltdOALzDQWVbKb3ZYNWNUGM3Qnu0
 09zNCCiWlV8RIiXFsIeuYN1/xHbvtPRqZm/6iJt8y6lw6peBVj/u3jUajBD+CjCx9znDV86Ljl4
 Sfm/wEnnZg/smAgoMl5Z9FHkUlXw+qyTaZQxK2GU/v4TSAoocOoKtrcx+TQOL4FVAlnzKDZ9WNt
 0Ti5F/aZoddP3S0bYQL10+U+RQsYZpahijTFEgTztt5RJ6/2XkqVt67rO936M7cx40kPJ8KQdmI
 mGHNxLaGbjDkKb+Jlye+5fnEtAyyG+5D5TMj1mhoOavPpHO4jE0jPzgP1SEow8ii5PVT3k8DYrw
 TbYm7oVOv6NetccF0X4iuK2vd4LwVA/VD6ZiewlUBqeVLwgt+UU7wNL61Xs2tjU6RMDC6c+d0/X
 L6e0r1EayiZnEJORbsygPLDFDZbzrUdg==
X-Google-Smtp-Source: AGHT+IHuRVUjxK3vlQ45sdSVUvDSae1hpONjM0Ju2TJpsQjqY4WPBqmELg6iLZeWAs7xNKYZbt8Qdw==
X-Received: by 2002:a17:902:db0f:b0:269:9e4d:4c8b with SMTP id
 d9443c01a7336-27ed4a3ed4cmr102044265ad.21.1758909818708; 
 Fri, 26 Sep 2025 11:03:38 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:38 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 16/23] drm/amd/display: Poll analog connectors (v2)
Date: Fri, 26 Sep 2025 20:01:56 +0200
Message-ID: <20250926180203.16690-17-timur.kristof@gmail.com>
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

VGA connectors don't support any hotplug detection, so the kernel
needs to periodically poll them to see if a display is connected.

DVI-I connectors have hotplug detection for digital signals, and
some analog DVI cables pull up that pin to work with that.
However, in general not all DVI cables do this so we can't rely on
this feature, therefore we need to poll DVI-I connectors as well.

v2:
Call drm_kms_helper_poll_fini in amdgpu_dm_hpd_fini.
Disable/enable polling on suspend/resume.
Don't call full link detection when already connected.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 73 ++++++++++++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 20 +++++
 2 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cdc6112e5875..07cfd9cae0df 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3768,7 +3768,9 @@ void amdgpu_dm_update_connector_after_detect(
 	drm_dbg_kms(dev, "DCHPD: connector_id=%d: Old sink=%p New sink=%p\n",
 		    aconnector->connector_id, aconnector->dc_sink, sink);
 
-	guard(mutex)(&dev->mode_config.mutex);
+	/* When polling, DRM has already locked the mutex for us. */
+	if (!drm_kms_helper_is_poll_worker())
+		mutex_lock(&dev->mode_config.mutex);
 
 	/*
 	 * 1. Update status of the drm connector
@@ -3831,6 +3833,10 @@ void amdgpu_dm_update_connector_after_detect(
 	}
 
 	update_subconnector_property(aconnector);
+
+	/* When polling, the mutex will be unlocked for us by DRM. */
+	if (!drm_kms_helper_is_poll_worker())
+		mutex_unlock(&dev->mode_config.mutex);
 }
 
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
@@ -7123,12 +7129,63 @@ create_stream_for_sink(struct drm_connector *connector,
 	return stream;
 }
 
+/**
+ * amdgpu_dm_connector_poll() - Poll a connector to see if it's connected to a display
+ *
+ * Used for connectors that don't support HPD (hotplug detection)
+ * to periodically checked whether the connector is connected to a display.
+ */
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
+		/* Only call full link detection when a sink isn't created yet,
+		 * ie. just when the display is plugged in, otherwise we risk flickering.
+		 */
+		if (link->local_sink ||
+			dc_link_detect(link, DETECT_REASON_HPD))
+			status = connector_status_connected;
+
+		mutex_unlock(&adev->dm.dc_lock);
+	}
+
+	if (connector->status != status) {
+		if (status == connector_status_disconnected) {
+			if (link->local_sink)
+				dc_sink_release(link->local_sink);
+
+			link->local_sink = NULL;
+			link->dpcd_sink_count = 0;
+			link->type = dc_connection_none;
+		}
+
+		amdgpu_dm_update_connector_after_detect(aconnector);
+	}
+
+	mutex_unlock(&aconnector->hpd_lock);
+	return status;
+}
+
 /**
  * amdgpu_dm_connector_detect() - Detect whether a DRM connector is connected to a display
  *
  * A connector is considered connected when it has a sink that is not NULL.
  * For connectors that support HPD (hotplug detection), the connection is
  * handled in the HPD interrupt.
+ * For connectors that may not support HPD, such as analog connectors,
+ * DRM will call this function repeatedly to poll them.
  *
  * Notes:
  * 1. This interface is NOT called in context of HPD irq.
@@ -7148,6 +7205,14 @@ amdgpu_dm_connector_detect(struct drm_connector *connector, bool force)
 	else if (aconnector->base.force == DRM_FORCE_OFF)
 		return connector_status_disconnected;
 
+	/* Poll analog connectors and only when either
+	 * disconnected or connected to an analog display.
+	 */
+	if (drm_kms_helper_is_poll_worker() &&
+		dc_connector_supports_analog(aconnector->dc_link->link_id.id) &&
+		(!aconnector->dc_sink || aconnector->dc_sink->edid_caps.analog))
+		return amdgpu_dm_connector_poll(aconnector, force);
+
 	return (aconnector->dc_sink ? connector_status_connected :
 			connector_status_disconnected);
 }
@@ -8545,9 +8610,13 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 			link->link_enc->features.dp_ycbcr420_supported ? true : false;
 		break;
 	case DRM_MODE_CONNECTOR_DVID:
-	case DRM_MODE_CONNECTOR_DVII:
 		aconnector->base.polled = DRM_CONNECTOR_POLL_HPD;
 		break;
+	case DRM_MODE_CONNECTOR_DVII:
+	case DRM_MODE_CONNECTOR_VGA:
+		aconnector->base.polled =
+			DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index a1c722112c22..61b0bf7b8269 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -476,6 +476,7 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
 
 void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 {
+	struct drm_device *dev = adev_to_drm(adev);
 	int src;
 	struct list_head *hnd_list_h;
 	struct list_head *hnd_list_l;
@@ -512,6 +513,9 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
+
+	if (dev->mode_config.poll_enabled)
+		drm_kms_helper_poll_disable(dev);
 }
 
 void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
@@ -537,6 +541,7 @@ void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 
 void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 {
+	struct drm_device *dev = adev_to_drm(adev);
 	int src;
 	struct list_head *hnd_list_h, *hnd_list_l;
 	unsigned long irq_table_flags;
@@ -557,6 +562,9 @@ void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
+
+	if (dev->mode_config.poll_enabled)
+		drm_kms_helper_poll_enable(dev);
 }
 
 /*
@@ -893,6 +901,7 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 	struct drm_connector_list_iter iter;
 	int irq_type;
 	int i;
+	bool use_polling = false;
 
 	/* First, clear all hpd and hpdrx interrupts */
 	for (i = DC_IRQ_SOURCE_HPD1; i <= DC_IRQ_SOURCE_HPD6RX; i++) {
@@ -906,6 +915,8 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		struct amdgpu_dm_connector *amdgpu_dm_connector;
 		const struct dc_link *dc_link;
 
+		use_polling |= connector->polled != DRM_CONNECTOR_POLL_HPD;
+
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
 
@@ -947,6 +958,9 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	if (use_polling)
+		drm_kms_helper_poll_init(dev);
 }
 
 /**
@@ -963,12 +977,15 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	int irq_type;
+	bool use_polling = false;
 
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
 		struct amdgpu_dm_connector *amdgpu_dm_connector;
 		const struct dc_link *dc_link;
 
+		use_polling |= connector->polled != DRM_CONNECTOR_POLL_HPD;
+
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
 
@@ -997,4 +1014,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev)
 		}
 	}
 	drm_connector_list_iter_end(&iter);
+
+	if (dev->mode_config.poll_enabled)
+		drm_kms_helper_poll_fini(dev);
 }
-- 
2.51.0

