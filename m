Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E0910ED671
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24B810EE13;
	Fri, 27 Mar 2026 12:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="efrYnTab";
	dkim-atps=neutral
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com
 [209.85.161.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF9D10EBF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:13 +0000 (UTC)
Received: by mail-oo1-f46.google.com with SMTP id
 006d021491bc7-67deb70bc76so796876eaf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551373; x=1775156173; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wgXq6jE50vtzY84cY1V8ERFkQj1I8fWL7chL4/tqUbE=;
 b=efrYnTabT5PosLMfK9xl79O3HVi+hloAlJzaiPtkdmX6Cc2zQGd+N+bwbscdhG1TXS
 7ah8ECRFInP1EsIjFYxLGZUA0SYsQP72ZnjfyFHtGC8wMisxe/KxBG4ZNmTSSwLQTOIP
 wjqtUk4P0GJoP6/U0ln2PWmBeh040kvuB3PHeDg0goVWnkHHUTfcPC84rnNyIAm2Ka74
 Xb4vL9G5LpAvFAVcMpb/XVkz+gkr+KXwJ/pi/Ot1taCbX++ON4+7D1Q1wm8mAe1FIY/D
 xjglKxqmq9euyqhnKuuOgvsYaAkoUo23jX7OK7FnrM76wynAEPLcSXqm80pUGM0SqmfZ
 OItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551373; x=1775156173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wgXq6jE50vtzY84cY1V8ERFkQj1I8fWL7chL4/tqUbE=;
 b=paiR8uKtAQ08fIi30pKlZqz7b2gd/pjRz+obBU4FsCtbJIkFbIhT8KVJX/ST+c9AaX
 PtIjCdxexgwQihCZCQU3KURAfHcuYyx5j4U0h6YaPgzGXenWUJzZislblQHtn090xeCa
 CewRXE8k20v7m8JXdVU38Z3Vs65LO6sVPdxH9ESr0Sm1QHr0KnXCdDQ3/Rlr1ls7uRLM
 Ii/rhHSZKNXhZ7MOmM+h6OYgM2ECVA8Scvureqmhyi45O3Txfseji7DG4f7wpMGPL4Jb
 7HmwgwbC+x4u4yfS1GfXnzFe9JlzBkE4LkbtB2wJoLDvgQBnTv1uB7KtuoMp7HUq2ZHp
 ezbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMw2hfWlvjea6h09b5tO61MlbRBQddvqgXEy7S8I4Qiw+xhbWN4QD06VnYr2vDDS6z6sl/IbGR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwalTLGGJ39VJWN9kLRnWtaxkIiTfCutpGhwoqSdI0R+kJjtKJC
 k/3txMdcKE3c6FE7ytkBG8yBNPNIpvVmQC7XYRDbqHqQPqJ19bKXQrhy
X-Gm-Gg: ATEYQzxhZ9rtDFDHBlrEbmLI2J92QSK+2VYVatkbGlrmG7sYDRqn23RoacrhJVrQAw0
 GbvCKjLhu2lvcbYEP5VHRDQn4hbl64B4DgNldoR7pwBlOJo7gCzSpG+UDZST3SJbhrCYMVGFUTC
 8Hjhc70n/Lzo4gHGM746Jsm2XyUKl6KWU4n78e0N2JL53sugUgCf/JzHJvARn7RDNHKHlEO99yV
 4wm8NnsjH6v+WWTyTFc0rLMZsiE0VUARk03Jl8ZF6vibssa0+YrWTPV0uUZpaNewJuIuPXB+kVP
 dTza2Csshn3op9km9VAzXsV64LnzXjkHWzUy6jJxhsXKYxCV6isxyeMNNa5CpBKj7ezocWvYr9k
 siCdtTbdVsL8dzMsuXIHqB1Vn0WH4HxoAr0qcZqFpQ+57x//1VD3+zP0MZxYZy5BYLAv+FCyWZf
 eScyXnH1duYompoWbKyucDyOoy+5GO5J20mBCv34swQRfl6LVO
X-Received: by 2002:a05:6820:3106:b0:67d:e17b:31ac with SMTP id
 006d021491bc7-67dff51609emr4069367eaf.45.1774551373018; 
 Thu, 26 Mar 2026 11:56:13 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:12 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jbaron@akamai.com, gregkh@linuxfoundation.org
Cc: jim.cromie@gmail.com, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v12 67/69] accel/ivpu: implement IVPU_DBG_* as a dyndbg
 classmap
Date: Thu, 26 Mar 2026 12:54:11 -0600
Message-ID: <20260326185413.1205870-68-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326185413.1205870-1-jim.cromie@gmail.com>
References: <20260326185413.1205870-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 12:40:00 +0000
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

Invoke DRM_CLASSMAP_DEFINE to create a classmap of
class-ids/categories for ivpu_dbg().

This brings static-key optimized-off benefits to the ivpu_dbg()
callsites.  DRM_CLASSMAP_PARAM_REF wires the sysfs kparam to the
classmap.

This is the 1st real-world example of a module avoiding another
module's classmap's class_id range reservation.

Its also something of an oddity: it "is" a DRM module only cuz

1. CONFIG_DRM_ACCEL_IVPU exists.

2. code therefore uses CONFIG_DRM_USE_DYNAMIC_DEBUG, so must also use
   it's dependent wrappers: DRM_CLASSMAP_*

accel/amdxdna is already using drm.debug via dev_dbg(), so it is more
fully DRM but iirc its a single call.

Anyway, to play nice with DRM, we change all the constants, from
macros calling BIT(X), to an explicit "enum ivpu_dbg_category"
starting at 16 to avoid DRM_UT_CORE..RES.  This is all in an indef to
avoid changing the constants for the non-dyndbg case.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 27 +++++++++++++++++++--
 drivers/accel/ivpu/ivpu_drv.h | 45 ++++++++++++++++++++++++++++++-----
 2 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 5900a40c7a78..214fdbf06470 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2020-2025 Intel Corporation
  */
 
+#include <linux/dynamic_debug.h>
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -37,8 +38,30 @@
 #define DRIVER_VERSION_STR "1.0.0 " UTS_RELEASE
 #endif
 
-int ivpu_dbg_mask;
-module_param_named(dbg_mask, ivpu_dbg_mask, int, 0644);
+unsigned long ivpu_dbg_mask;
+
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+
+module_param_named(dbg_mask, ivpu_dbg_mask, ulong, 0644);
+#else
+DRM_CLASSMAP_DEFINE(ivpu_dbg_classes, DD_CLASS_TYPE_DISJOINT_BITS,
+		IVPU_DBG_REG,
+		"IVPU_DBG_REG",
+		"IVPU_DBG_IRQ",
+		"IVPU_DBG_MMU",
+		"IVPU_DBG_FILE",
+		"IVPU_DBG_MISC",
+		"IVPU_DBG_FW_BOOT",
+		"IVPU_DBG_PM",
+		"IVPU_DBG_IPC",
+		"IVPU_DBG_BO",
+		"IVPU_DBG_JOB",
+		"IVPU_DBG_JSM",
+		"IVPU_DBG_KREF",
+		"IVPU_DBG_RPM",
+		"IVPU_DBG_MMU_MAP");
+DRM_CLASSMAP_PARAM_REF(dbg_mask, ivpu_dbg_mask, ivpu_dbg_classes, p);
+#endif
 MODULE_PARM_DESC(dbg_mask, "Driver debug mask. See IVPU_DBG_* macros.");
 
 int ivpu_test_mode;
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 5b34b6f50e69..ef5a96b961fc 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -65,6 +65,10 @@
 
 #define IVPU_SCHED_MODE_AUTO -1
 
+extern unsigned long ivpu_dbg_mask;
+
+#if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
+
 #define IVPU_DBG_REG	 BIT(0)
 #define IVPU_DBG_IRQ	 BIT(1)
 #define IVPU_DBG_MMU	 BIT(2)
@@ -81,6 +85,41 @@
 #define IVPU_DBG_MMU_MAP BIT(13)
 #define IVPU_DBG_IOCTL   BIT(14)
 
+#define ivpu_dbg(vdev, type, fmt, args...) do {				\
+	if (unlikely(IVPU_DBG_##type & ivpu_dbg_mask))			\
+		dev_dbg((vdev)->drm.dev, "[%s] " fmt, #type, ##args);	\
+} while (0)
+
+#else /* !!CONFIG_DRM_USE_DYNAMIC_DEBUG */
+
+enum ivpu_dbg_category {
+	/*
+	 * since accels are drm-devices (CONFIG_DRM_ACCEL_*), adjust
+	 * IVPU_DBG_* to avoid DRMs 0..10 class_id reservations.
+	 */
+	IVPU_DBG_REG = 16,
+	IVPU_DBG_IRQ,
+	IVPU_DBG_MMU,
+	IVPU_DBG_FILE,
+	IVPU_DBG_MISC,
+	IVPU_DBG_FW_BOOT,
+	IVPU_DBG_PM,
+	IVPU_DBG_IPC,
+	IVPU_DBG_BO,
+	IVPU_DBG_JOB,
+	IVPU_DBG_JSM,
+	IVPU_DBG_KREF,
+	IVPU_DBG_RPM,
+	IVPU_DBG_MMU_MAP,
+	IVPU_DBG_IOCTL
+};
+
+#define ivpu_dbg(vdev, type, fmt, ...)                    \
+	_dynamic_func_call_cls(IVPU_DBG_##type, fmt, __dynamic_dev_dbg,	\
+			       (vdev)->drm.dev, fmt, ##__VA_ARGS__)
+
+#endif /* !!CONFIG_DRM_USE_DYNAMIC_DEBUG */
+
 #define ivpu_err(vdev, fmt, ...) \
 	drm_err(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
 
@@ -95,11 +134,6 @@
 
 #define ivpu_info(vdev, fmt, ...) drm_info(&(vdev)->drm, fmt, ##__VA_ARGS__)
 
-#define ivpu_dbg(vdev, type, fmt, args...) do {                                \
-	if (unlikely(IVPU_DBG_##type & ivpu_dbg_mask))                         \
-		dev_dbg((vdev)->drm.dev, "[%s] " fmt, #type, ##args);          \
-} while (0)
-
 #define IVPU_WA(wa_name) (vdev->wa.wa_name)
 
 #define IVPU_PRINT_WA(wa_name) do {					\
@@ -197,7 +231,6 @@ struct ivpu_file_priv {
 	bool aborted;
 };
 
-extern int ivpu_dbg_mask;
 extern u8 ivpu_pll_min_ratio;
 extern u8 ivpu_pll_max_ratio;
 extern int ivpu_sched_mode;
-- 
2.53.0

