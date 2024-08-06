Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E225C52D70
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Aug 2024 18:42:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7D810E3DA;
	Tue,  6 Aug 2024 18:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PKrt8LtK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B95A10E3D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Aug 2024 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722969739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTOhpRVmhZuXkHBiygGH1i2Eclfn36V87P5jpIjXJgU=;
 b=PKrt8LtKqNZkHvO3yf8JQ0ql0v3YO5aibeJ7xhUq6xXfgY788h5lt8SEND1OOYKKSyv9Y6
 ptkbX1piaK58r/KGNv0mOPTQDektEzyV3E4ROd635lx7O5zgFRg9BE9nBcSctjx9luQKKQ
 bDauQIbJpCcAFkMGKrp69IsZCOEe0No=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-vARqBibHPweYN7NOy93dzw-1; Tue, 06 Aug 2024 14:42:17 -0400
X-MC-Unique: vARqBibHPweYN7NOy93dzw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-368448dfe12so50362f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Aug 2024 11:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722969737; x=1723574537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GTOhpRVmhZuXkHBiygGH1i2Eclfn36V87P5jpIjXJgU=;
 b=jQXmYCM4iYusjxHD57ULE9GqMUJBydDFkqIS9dxttvefQAXSVsGP1UjRjaKRsCjwZx
 9tOwy7Oep8h2qM758Kt5cnfyZ9ACIXhtjcz6mDBpX1HKx8Tvh1SQpsLxLDlDoNEdkccj
 cG8FTO8UWS5HUswMy+4A21jlzimO7hE7WgVyvfavhxzqcexikIbBvG/pMxVZiy+WB1gX
 W3d/jBVMqkHWq8j309FGhscJtlHNYMJEfA1FOG5PKdhY78qNYPd0TkP2uDqwZP3Q/vJd
 JVx9+Q14OYNXtIrKCLkArkRUnWkoIvsn4OWXfUFWHsmVPoDzPE4RwE14FoZonH9uma3C
 9KvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxgNZfWytiXBRHMpcBRpjaCLzXbLLPzrzh8uv9M+YO7a5SCIyn9NrgHZM6Q+/0HZuhqTAx+VBYmPgYNTEGApwRquS9Kiin+csWwEe9Mg==
X-Gm-Message-State: AOJu0Yw0+iJ9KNdUepGD1GFEL6g3fJMAOOsOTGiNUyVGL2n13pi9bnKF
 LzPEzJHJhhey/0eg0fL3tjqlAnqThl7CiDpe4fO5JvTT/Eq6e40HUBBBF2B3OhWSDpcXBn8/e1C
 u69P2CVPi1Ftb34DPKPcqUqgYrSDuEipYwDd4qz1N7RI/9tTVyKe+E08jbJqO/oQ=
X-Received: by 2002:a05:600c:46cd:b0:424:8743:86b4 with SMTP id
 5b1f17b1804b1-428e4713f62mr134423515e9.6.1722969736664; 
 Tue, 06 Aug 2024 11:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr5Jf4uJJrllifZn/qGW9eINl+OCbwq5032Gwf/jPT83g6dT50HU1rINEr2nwgAWfHi7K58Q==
X-Received: by 2002:a05:600c:46cd:b0:424:8743:86b4 with SMTP id
 5b1f17b1804b1-428e4713f62mr134423345e9.6.1722969736214; 
 Tue, 06 Aug 2024 11:42:16 -0700 (PDT)
Received: from toolbox.fritz.box ([2001:9e8:898e:ab00:d894:f48:6689:8e30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6e3ef10sm196595695e9.24.2024.08.06.11.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 11:42:15 -0700 (PDT)
From: Sebastian Wick <sebastian.wick@redhat.com>
To: dri-devel@lists.freedesktop.org
Cc: Sebastian Wick <sebastian@sebastianwick.net>,
 Xaver Hugl <xaver.hugl@gmail.com>, Simon Ser <contact@emersion.fr>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Hung <alex.hung@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li <roman.li@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Revert "drm/amd/display: add panel_power_savings sysfs
 entry to eDP connectors"
Date: Tue,  6 Aug 2024 20:42:10 +0200
Message-ID: <20240806184214.224672-2-sebastian.wick@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806184214.224672-1-sebastian.wick@redhat.com>
References: <20240806184214.224672-1-sebastian.wick@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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

From: Sebastian Wick <sebastian@sebastianwick.net>

This reverts commit 63d0b87213a0ba241b3fcfba3fe7b0aed0cd1cc5.

The panel_power_savings sysfs entry can be used to change the displayed
colorimetry which breaks color managed setups.

The "do not break userspace" rule which was violated here is enough
reason to revert this commit.

The bigger problem is that this feature is part of the display chain
which is supposed to be controlled by KMS. This sysfs entry bypasses the
DRM master process and splits control to two independent processes which
do not know about each other. This is what caused the broken user space.
It also causes modesets which can be extremely confusing for the DRM
master process, causing unexpected timings.

We should in general not allow anything other than KMS to control the
display path. If we make an exception to this rule, this must be first
discussed on dri-devel with all the stakeholders approving the
exception.

This has not happened which is the second reason to revert this commit.

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 80 -------------------
 1 file changed, 80 deletions(-)

diff --git ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4d4c75173fc3..16c9051d9ccf 100644
--- ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ ../drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6772,82 +6772,10 @@ int amdgpu_dm_connector_atomic_get_property(struct drm_connector *connector,
 	return ret;
 }
 
-/**
- * DOC: panel power savings
- *
- * The display manager allows you to set your desired **panel power savings**
- * level (between 0-4, with 0 representing off), e.g. using the following::
- *
- *   # echo 3 > /sys/class/drm/card0-eDP-1/amdgpu/panel_power_savings
- *
- * Modifying this value can have implications on color accuracy, so tread
- * carefully.
- */
-
-static ssize_t panel_power_savings_show(struct device *device,
-					struct device_attribute *attr,
-					char *buf)
-{
-	struct drm_connector *connector = dev_get_drvdata(device);
-	struct drm_device *dev = connector->dev;
-	u8 val;
-
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-	val = to_dm_connector_state(connector->state)->abm_level ==
-		ABM_LEVEL_IMMEDIATE_DISABLE ? 0 :
-		to_dm_connector_state(connector->state)->abm_level;
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-
-	return sysfs_emit(buf, "%u\n", val);
-}
-
-static ssize_t panel_power_savings_store(struct device *device,
-					 struct device_attribute *attr,
-					 const char *buf, size_t count)
-{
-	struct drm_connector *connector = dev_get_drvdata(device);
-	struct drm_device *dev = connector->dev;
-	long val;
-	int ret;
-
-	ret = kstrtol(buf, 0, &val);
-
-	if (ret)
-		return ret;
-
-	if (val < 0 || val > 4)
-		return -EINVAL;
-
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
-	to_dm_connector_state(connector->state)->abm_level = val ?:
-		ABM_LEVEL_IMMEDIATE_DISABLE;
-	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-
-	drm_kms_helper_hotplug_event(dev);
-
-	return count;
-}
-
-static DEVICE_ATTR_RW(panel_power_savings);
-
-static struct attribute *amdgpu_attrs[] = {
-	&dev_attr_panel_power_savings.attr,
-	NULL
-};
-
-static const struct attribute_group amdgpu_group = {
-	.name = "amdgpu",
-	.attrs = amdgpu_attrs
-};
-
 static void amdgpu_dm_connector_unregister(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    amdgpu_dm_abm_level < 0)
-		sysfs_remove_group(&connector->kdev->kobj, &amdgpu_group);
-
 	drm_dp_aux_unregister(&amdgpu_dm_connector->dm_dp_aux.aux);
 }
 
@@ -6952,14 +6880,6 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 		to_amdgpu_dm_connector(connector);
 	int r;
 
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    amdgpu_dm_abm_level < 0) {
-		r = sysfs_create_group(&connector->kdev->kobj,
-				       &amdgpu_group);
-		if (r)
-			return r;
-	}
-
 	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
 
 	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
-- 
2.45.2

