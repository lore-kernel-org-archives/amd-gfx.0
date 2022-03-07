Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A7FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 19:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8091310E176;
	Mon,  7 Mar 2022 19:47:35 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE07910E076
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 16:26:46 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id r13so33171390ejd.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Mar 2022 08:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sz5H5EvXLmeixNUq00HsyaYiLLK9c2PGHArUw7XSbEs=;
 b=U+zQ8Nk6GGsS/yEaMMAXl1DLWnhjC5qaWL9AZDWvdkUFeUm6CZ9IWPg9l8bD4IRW92
 vM1TNxG6mcdoQUUkgzu5Ee8CU7oBZZiqCWNoQECVCI+MWRw82nOcntOF2Rx7imv/dDoU
 M1holSLndhEaMqgagrqxAwz/aGymFiLEIlcJ5tVBnTky6eoOf02eDEPrenWV0IdWcDwb
 O/KdAPkpgIPYYGSvXEteCWI6jD2thBWkIy7za8QZ27ZiPtoCFiJ0Up+O46UTESoT5ppK
 /DseFf7w5wJG6yGTSEAfyMZ21rGZ84WK3ujGQVuDO2bv+SCQzkROFEc1F02kECrnl930
 pxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sz5H5EvXLmeixNUq00HsyaYiLLK9c2PGHArUw7XSbEs=;
 b=Vf1jIlhsGE3H7IYZ5Ix6QESbBI1PSw3gly1gRQrruOyxGkTiXU9rCcWeKDSgY9csce
 xWLD7TxSK6dAWi4cCkMDnoXCO4304jnnzLjasHWKNrnVD7JKEWGVQKzuFhpaFFz5qUbg
 Pmyb5l0R85I5qcOa2ODdZgVDCZ+DvY9v8UTknMN0NubzgBAyzjOqOBHH4S+ZpPe1AcDC
 41JI7Y2qvumLtgb/BW7blMho5fN9mqhZ7U96dPZ32wzxEXyPZZew6Q850P4Eqm8jtTNb
 D4wVBfvbgjmDA+BoJCveJtye62Svvuj1aSDwTcilbellgNI3qYSqs0om0UI5tcyonaVh
 kwYQ==
X-Gm-Message-State: AOAM53048KU8hSMjwWRojAQy6e4NdRLxAefPUL68xIxLioaHPYIhrN2Y
 UWqA6Pw+yR1bzIkQ+3uQCaaBKfpvM97RoXqb
X-Google-Smtp-Source: ABdhPJwTZEcOViFf+DrDlZqud9AWP9VAkr37Zmw2r52Wv6lTX1+LKeezRwryDtsOQ8gCnJt4p0UTUQ==
X-Received: by 2002:a17:906:d7aa:b0:6cf:1fb3:2986 with SMTP id
 pk10-20020a170906d7aa00b006cf1fb32986mr9908085ejb.594.1646670404950; 
 Mon, 07 Mar 2022 08:26:44 -0800 (PST)
Received: from shashanks-buildpc.. ([2a02:8109:b540:9438:acf8:f35b:33d6:e937])
 by smtp.gmail.com with ESMTPSA id
 5-20020a508e45000000b003fe03798eafsm6667027edx.32.2022.03.07.08.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Mar 2022 08:26:44 -0800 (PST)
From: Shashank Sharma <contactshashanksharma@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm: Add GPU reset sysfs event
Date: Mon,  7 Mar 2022 17:26:30 +0100
Message-Id: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Mar 2022 19:47:33 +0000
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
Cc: Alexandar Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com, Christian Koenig <christian.koenig@amd.com>,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <shashank.sharma@amd.com>

This patch adds a new sysfs event, which will indicate
the userland about a GPU reset, and can also provide
some information like:
- which PID was involved in the GPU reset
- what was the GPU status (using flags)

This patch also introduces the first flag of the flags
bitmap, which can be appended as and when required.

Cc: Alexandar Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
 include/drm/drm_sysfs.h     |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 430e00b16eec..52a015161431 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct drm_device *dev)
 }
 EXPORT_SYMBOL(drm_sysfs_hotplug_event);
 
+/**
+ * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU reset
+ * @dev: DRM device
+ * @pid: The process ID involve with the reset
+ * @flags: Any other information about the GPU status
+ *
+ * Send a uevent for the DRM device specified by @dev. This indicates
+ * user that a GPU reset has occurred, so that the interested client
+ * can take any recovery or profiling measure, when required.
+ */
+void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_t flags)
+{
+	unsigned char pid_str[21], flags_str[15];
+	unsigned char reset_str[] = "RESET=1";
+	char *envp[] = { reset_str, pid_str, flags_str, NULL };
+
+	DRM_DEBUG("generating reset event\n");
+
+	snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
+	snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
+	kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
+}
+EXPORT_SYMBOL(drm_sysfs_reset_event);
+
 /**
  * drm_sysfs_connector_hotplug_event - generate a DRM uevent for any connector
  * change
diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
index 6273cac44e47..63f00fe8054c 100644
--- a/include/drm/drm_sysfs.h
+++ b/include/drm/drm_sysfs.h
@@ -2,6 +2,8 @@
 #ifndef _DRM_SYSFS_H_
 #define _DRM_SYSFS_H_
 
+#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
+
 struct drm_device;
 struct device;
 struct drm_connector;
@@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
 void drm_class_device_unregister(struct device *dev);
 
 void drm_sysfs_hotplug_event(struct drm_device *dev);
+void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, uint32_t reset_flags);
 void drm_sysfs_connector_hotplug_event(struct drm_connector *connector);
 void drm_sysfs_connector_status_event(struct drm_connector *connector,
 				      struct drm_property *property);
-- 
2.32.0

