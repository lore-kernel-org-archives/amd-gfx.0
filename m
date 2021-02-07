Return-Path: <SRS0=WKN7=HK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD3DC433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 08:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A43764E87
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Feb 2021 08:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A43764E87
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88F746E832;
	Mon,  8 Feb 2021 08:24:52 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF396E0A1
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Feb 2021 12:49:25 +0000 (UTC)
Received: by mail-lf1-x134.google.com with SMTP id f1so17919719lfu.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 07 Feb 2021 04:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GP+1zKAf4jaOeCWXD3mTFYtQougOv4DCPOpfz6V4HPw=;
 b=oMOPEgtDNJ6UagRKjUGNrL1Zdiibl0AwErKOhUNrpJlO6VmCoVaqInQZ7RTZI2Fm0J
 ae3VmYhWPQF2ba2ZTjVQGx0rqsJrCh+ZWie61yIxfaxzEjYDMUAPTYp+bbbuuBmw9C5g
 O+r9kNfIWs1geh+tskg7DCj3oUqiQPtgrQPiL28mG4LZgMH7+PVzFyx8t99i6nPCSE90
 iT6UZM+io5Po/SwKTMeaQnC/cDZfZykO8loPAv6kswrMTFEcTEMQRGXeO3x8GfGb3N+D
 LFn2XzRn8B+vB5LNwWYu1Ahl7dReudFPFLBJH2h2P7bt5AjGf1N2QI67tbupz65WvHdH
 eB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GP+1zKAf4jaOeCWXD3mTFYtQougOv4DCPOpfz6V4HPw=;
 b=m3/HwXPkHpYu8iIlRBTQd5AaSfBf/SbCNOF+XqOHMFkeKNr37GtUcvqr+SxrO7sLqp
 UoL9x9eqMX4Pwz/kz8x1osS7UNpL1ZV3lOWrMPKzvTnjTeMKVQw48EK5APuWXU6Q8Bko
 xkpQlIqNXKFSOJkP0Rw2KZhtw1SyS9SRU+jGBD7hOAx7IHYRY2VNeJevRjITUYnM9g5G
 d2J9cct5Y4WR3tRTBnQijal0hHZiDMsi/FCFC3z3k5YaQofFCgq5RCQXlKHiilq8K08w
 MAuf6lczHXiOmdJzPPb/8CctKjgxbkjNiikdTe60uzWjnEjc+8/w3qnSL9OBWJ3MTcqC
 l2Mg==
X-Gm-Message-State: AOAM5303ugjfYyWihdix9EEyuuMknUiCyXCwUnREcFK3+H2Pmi0RVshu
 gZREGjOgsHWuD2RBc4tX+osKH5HYVk6QHw==
X-Google-Smtp-Source: ABdhPJwdLOX2DEWz8tXeAC+OgRiAmgs7OMPk9gcD6/YnjipD/PmvSGryZ88JYoikNimHSJBuYN++Ig==
X-Received: by 2002:ac2:4e8a:: with SMTP id o10mr7732763lfr.656.1612702164050; 
 Sun, 07 Feb 2021 04:49:24 -0800 (PST)
Received: from raszit-komputer-amd.raszit-server.ovh ([62.122.232.191])
 by smtp.gmail.com with ESMTPSA id t27sm108213ljk.132.2021.02.07.04.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Feb 2021 04:49:23 -0800 (PST)
From: Marcin Raszka <djraszit@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] radeon: added support for 2560x1080 resolution
Date: Sun,  7 Feb 2021 13:49:01 +0100
Message-Id: <20210207124901.6541-1-djraszit@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 08 Feb 2021 08:24:49 +0000
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
Cc: Marcin Raszka <djraszit@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I was wondering why I can't set the resolution to 2560x1080, while in windows 7 I can without a problem.
I looked at the radeon driver code and found it doesn't support this resolution. So I made some changes.
I added the hdmi_mhz parameter. In cmdline I set radeon.hdmi_mhz=190
Only tested on the Radeon HD 5830
---
 drivers/gpu/drm/radeon/radeon_benchmark.c  |  5 +++--
 drivers/gpu/drm/radeon/radeon_connectors.c | 25 +++++++++++++---------
 drivers/gpu/drm/radeon/radeon_drv.c        |  5 +++++
 drivers/gpu/drm/radeon/radeon_encoders.c   |  6 ++++--
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_benchmark.c b/drivers/gpu/drm/radeon/radeon_benchmark.c
index ac9a5ec481c3..c283b6b15925 100644
--- a/drivers/gpu/drm/radeon/radeon_benchmark.c
+++ b/drivers/gpu/drm/radeon/radeon_benchmark.c
@@ -30,7 +30,7 @@
 #define RADEON_BENCHMARK_COPY_DMA  0
 
 #define RADEON_BENCHMARK_ITERATIONS 1024
-#define RADEON_BENCHMARK_COMMON_MODES_N 17
+#define RADEON_BENCHMARK_COMMON_MODES_N 18
 
 static int radeon_benchmark_do_move(struct radeon_device *rdev, unsigned size,
 				    uint64_t saddr, uint64_t daddr,
@@ -184,7 +184,8 @@ void radeon_benchmark(struct radeon_device *rdev, int test_number)
 		1680 * 1050 * 4,
 		1600 * 1200 * 4,
 		1920 * 1080 * 4,
-		1920 * 1200 * 4
+		1920 * 1200 * 4,
+		2560 * 1080 * 4
 	};
 
 	switch (test_number) {
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 607ad5620bd9..182f1e364cbd 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -37,6 +37,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
 
+extern int hdmimhz;
+
 static int radeon_dp_handle_hpd(struct drm_connector *connector)
 {
 	struct radeon_connector *radeon_connector = to_radeon_connector(connector);
@@ -503,7 +505,7 @@ static void radeon_add_common_modes(struct drm_encoder *encoder, struct drm_conn
 	struct mode_size {
 		int w;
 		int h;
-	} common_modes[17] = {
+	} common_modes[] = {
 		{ 640,  480},
 		{ 720,  480},
 		{ 800,  600},
@@ -520,10 +522,11 @@ static void radeon_add_common_modes(struct drm_encoder *encoder, struct drm_conn
 		{1680, 1050},
 		{1600, 1200},
 		{1920, 1080},
-		{1920, 1200}
+		{1920, 1200},
+		{2560, 1080}
 	};
 
-	for (i = 0; i < 17; i++) {
+	for (i = 0; i < ARRAY_SIZE(common_modes); i++) {
 		if (radeon_encoder->devices & (ATOM_DEVICE_TV_SUPPORT)) {
 			if (common_modes[i].w > 1024 ||
 			    common_modes[i].h > 768)
@@ -1491,25 +1494,27 @@ static enum drm_mode_status radeon_dvi_mode_valid(struct drm_connector *connecto
 	    (mode->clock > 135000))
 		return MODE_CLOCK_HIGH;
 
-	if (radeon_connector->use_digital && (mode->clock > 165000)) {
+	if (radeon_connector->use_digital && (mode->clock > (hdmimhz * 1000))) {
 		if ((radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_I) ||
 		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_DUAL_LINK_DVI_D) ||
-		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B))
+		    (radeon_connector->connector_object_id == CONNECTOR_OBJECT_ID_HDMI_TYPE_B)){
 			return MODE_OK;
-		else if (ASIC_IS_DCE6(rdev) && drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
+		}else if (ASIC_IS_DCE6(rdev) && drm_detect_hdmi_monitor(radeon_connector_edid(connector))) {
 			/* HDMI 1.3+ supports max clock of 340 Mhz */
-			if (mode->clock > 340000)
+			if (mode->clock > 340000){
 				return MODE_CLOCK_HIGH;
-			else
+			}else{
 				return MODE_OK;
+			}
 		} else {
 			return MODE_CLOCK_HIGH;
 		}
 	}
 
 	/* check against the max pixel clock */
-	if ((mode->clock / 10) > rdev->clock.max_pixel_clock)
+	if ((mode->clock / 10) > rdev->clock.max_pixel_clock){
 		return MODE_CLOCK_HIGH;
+	}
 
 	return MODE_OK;
 }
@@ -1809,7 +1814,7 @@ static enum drm_mode_status radeon_dp_mode_valid(struct drm_connector *connector
 				if (mode->clock > 340000)
 					return MODE_CLOCK_HIGH;
 			} else {
-				if (mode->clock > 165000)
+				if (mode->clock > (hdmimhz * 1000))
 					return MODE_CLOCK_HIGH;
 			}
 		}
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index e45d7344ac2b..fce8f9ab8018 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -281,6 +281,11 @@ int radeon_cik_support = 1;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
 module_param_named(cik_support, radeon_cik_support, int, 0444);
 
+int hdmimhz = 165;
+MODULE_PARM_DESC(hdmi_mhz, "set HDMI max frequency, default is 165");
+module_param_named(hdmi_mhz, hdmimhz, int, 0444);
+
+
 static struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/radeon/radeon_encoders.c
index 46549d5179ee..6b805bcd5726 100644
--- a/drivers/gpu/drm/radeon/radeon_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_encoders.c
@@ -35,6 +35,8 @@
 #include "radeon_legacy_encoders.h"
 #include "atom.h"
 
+extern int hdmimhz;
+
 static uint32_t radeon_encoder_clones(struct drm_encoder *encoder)
 {
 	struct drm_device *dev = encoder->dev;
@@ -389,7 +391,7 @@ bool radeon_dig_monitor_is_duallink(struct drm_encoder *encoder,
 				else
 					return false;
 			} else {
-				if (pixel_clock > 165000)
+				if (pixel_clock > (hdmimhz * 1000))
 					return true;
 				else
 					return false;
@@ -414,7 +416,7 @@ bool radeon_dig_monitor_is_duallink(struct drm_encoder *encoder,
 				else
 					return false;
 			} else {
-				if (pixel_clock > 165000)
+				if (pixel_clock > (hdmimhz * 1000))
 					return true;
 				else
 					return false;
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
