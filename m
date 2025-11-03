Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD8EECCF9FE
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 14:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5728F10E3FC;
	Mon,  3 Nov 2025 14:06:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g4AUHa8m";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC9D10E3A1
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 10:10:21 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-640a3317b89so1666784a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 02:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762164619; x=1762769419; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a3PXmC0IgYzElrMaLpcs/3Pmu0PchQ9cqTJphwonA/o=;
 b=g4AUHa8mcBY5mnEkbCsTtcGQOwhd9au0b8H18ypCCOv6D1P4RiPSgiGFAO+czkpIk6
 HO8YKtzHt2qiu5yzs6iBZGZLJpUEShHHAmwMb7zMqEN42iBRg8KZx0+LkH4nOtiBPfyh
 Nl/7KgO1a/clgjIt4z4sOv2LTdRcun5KZVDfE7Zzy7QpmPa32WVOeHNBPdJuUUCRIVx/
 yiJTta0XsNA7HKmC5bvajN0HU4UNH+AIDpWzPR8PkTd3Gkg9cGww6GSJlePEEkcyv8Z+
 iOzSRFGzbQ7DnJ44f0PZhQvFyG7TNnFLsBtXncWLISao4zFhrOWm3guqhwM1KVvffpV8
 +WBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164619; x=1762769419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a3PXmC0IgYzElrMaLpcs/3Pmu0PchQ9cqTJphwonA/o=;
 b=jD+GeekHWRNNYvCe8F/29zX0w0JFAgLZzJTHt0gONa0K9pYsAvF7rd4eXbRH6afd8C
 x+WC/vZfCuy3eRlZK5l0g/R3qRUA8FIZAyK8mN5mbuuYPB0AHZPy770QNUJY6QcP93A5
 4RImPE+V0j4dnXFSH3XVX7OimeVyM4hJILjjShAELBI9zdOABi5ncbDd2po3AkmdbSMn
 X1etS4u2ZfBr45C+UBp1dQy+4tG89jRyDKEoCaG7YC1QFPVoBpjQZ+LOrG5yBgfB29AD
 qvPFdSJsi45mAefxX3QWtpir71jNrqlgV4gX40HJmDqcPqwi8qKuFGuqDJZperKx9SQk
 wD+Q==
X-Gm-Message-State: AOJu0YyrQtLjRjtg5abdkafJO/JlPMY6Qs0HdMfUDbCHUKepNbMr/Qsl
 GDt4g2aHd40CJyidDvu/UpQQV2E6erI+dYeoMNmWZ8cMLXGFljlRoqNvZtY0g2n/
X-Gm-Gg: ASbGncv5Z8YslweXrCXbdENbP5L10Bol8fx178KTvQkI0+8pBDZQeN29WIoPyhpDhPg
 OEfR8PJXnN8kNUMPeOG4U/nMMAQfzszn/BZbfyDJv+xl8GnqmShWbLsqOtJj2/3bVBxr2wE5pjH
 U4FdmN/g+1tCrwmQ4sRRuMFVTUSHzyPEpBv0LGCheJkymd0RzboXYmtIOqoT888BzaobQG+anyx
 ZMaWmEvAWvZRIeh608WVNG6JpsL0JJfQaHl18+GC5jLoDN+lqGPftKqxVbXsx0ZnJfALrGji+vT
 1IHplxC/1WX873VL3N6vgHhuTIR1TQbdpsVYJ8Ih0yqw0WKYsuoCa70C/sW7O7YZ7gDfiyVBrDe
 SH0Q9D9TY6YeEFG72H6egnKf/iyuY31Frr7H3iOuXipBa3ZL7hWeEQAXh55UewDpobO9DLX/LRh
 5OM3cAzmdx3LDuVnnjaBpyPeBnTaaZbmBD03LRIBu79KsG1vBMvYfJd3L1DO+yXSkq8vQff+sM
X-Google-Smtp-Source: AGHT+IFE5m2yHWNYm6c1wct4++rOwYRAX7qLun4fuDAZR0oq65xBHc/ujhVijTJwkcEni14iGcGtpA==
X-Received: by 2002:a05:6402:5113:b0:640:6638:1b2c with SMTP id
 4fb4d7f45d1cf-64077068aa9mr9819679a12.33.1762164619160; 
 Mon, 03 Nov 2025 02:10:19 -0800 (PST)
Received: from T9H90HGVX2.discovery.roo.tools (PC-77-46-83-136.euro-net.pl.
 [77.46.83.136]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64093b3868esm7291519a12.28.2025.11.03.02.10.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:10:18 -0800 (PST)
From: "=?UTF-8?q?Micha=C5=82=20Bie=C5=82aga?=" <mbielaga1@gmail.com>
X-Google-Original-From: =?UTF-8?q?Micha=C5=82=20Bie=C5=82aga?=
 <michal.bielaga@deliveroo.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, harry.wentland@amd.com,
 sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, Michal Bielaga <mbielaga1@gmail.com>
Subject: [PATCH] drm/amdgpu: Add VRR support for MST connectors
Date: Mon,  3 Nov 2025 11:08:45 +0100
Message-ID: <20251103100845.12802-1-michal.bielaga@deliveroo.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 03 Nov 2025 14:06:25 +0000
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

From: Michal Bielaga <mbielaga1@gmail.com>

Variable Refresh Rate (VRR/FreeSync) currently only works with
Single-Stream Transport (SST) DisplayPort connections. Monitors
connected via MST hubs cannot utilize VRR even when they support it,
because the driver only enables VRR for SST connections.

This patch enables VRR for DisplayPort MST by:
- Including SIGNAL_TYPE_DISPLAY_PORT_MST in VRR capability detection
- Reading VRR range from display EDID instead of MST hub DPCD, since
  dc_link points to the hub rather than the actual display
- Fixing call order to parse EDID before checking VRR capabilities,
  ensuring display_info.monitor_range is populated
- Properly attaching VRR property to MST connectors by reusing the
  master connector's property

Without this patch, MST displays cannot use VRR even if they support
it, limiting the user experience for multi-monitor DisplayPort MST
setups.

Signed-off-by: Michal Bielaga <mbielaga1@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     | 11 +++++++++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   |  9 ++++++---
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ef026143dc1c..ac5b6c22361f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -12644,9 +12644,16 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		parse_edid_displayid_vrr(connector, edid);
 
 	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
+		     sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
 		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
-		if (amdgpu_dm_connector->dc_link &&
-		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_param) {
+		/* For MST, check monitor range from EDID directly since the dc_link
+		 * points to the MST hub, not the actual display
+		 */
+		if ((sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
+		     (amdgpu_dm_connector->dc_link &&
+		      amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_param)) &&
+		    connector->display_info.monitor_range.min_vfreq &&
+		    connector->display_info.monitor_range.max_vfreq) {
 			amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
 			amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
 			if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfreq > 10)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 77a9d2c7d318..062259514b3c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -443,6 +443,9 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			}
 		}
 
+		/* Update connector with EDID first so display_info.monitor_range is populated */
+		drm_edid_connector_update(&aconnector->base, aconnector->drm_edid);
+
 		if (aconnector->dc_sink) {
 			amdgpu_dm_update_freesync_caps(
 					connector, aconnector->drm_edid);
@@ -459,8 +462,6 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 		}
 	}
 
-	drm_edid_connector_update(&aconnector->base, aconnector->drm_edid);
-
 	ret = drm_edid_connector_add_modes(connector);
 
 	return ret;
@@ -650,9 +651,11 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	if (connector->max_bpc_property)
 		drm_connector_attach_max_bpc_property(connector, 8, 16);
 
+	/* Reuse VRR property from master connector for MST connectors */
 	connector->vrr_capable_property = master->base.vrr_capable_property;
 	if (connector->vrr_capable_property)
-		drm_connector_attach_vrr_capable_property(connector);
+		drm_object_attach_property(&connector->base,
+					   connector->vrr_capable_property, 0);
 
 	drm_object_attach_property(
 		&connector->base,
-- 
2.51.1


