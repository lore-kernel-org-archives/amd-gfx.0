Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2350ECAAA1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Aug 2022 08:16:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A4E10EBD6;
	Tue, 30 Aug 2022 08:16:31 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D568910EBD6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 08:16:28 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id nc14so15628881ejc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Aug 2022 01:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc;
 bh=s+qEz0hKLfXFu/IJkE2coYGi0IVaIf0nvZ/Eq+C3WTE=;
 b=mvOFTt0TvH+PsQaJTiF6DMHiw9zaEbLFuv178VDhlEjPjfoHbVxkgNhcfe4SUNAnEK
 YO7sUiOTzItFd+SEM2gae4BykFG6hRWHuNxJ27y3n5n2Z3BGOG/BZ+dWZC6S/sNS9fCR
 rtSXsEuN2c7KFOqYrkYw6YT7zUFtDk4BHkjo5QL4dcD5O4a8V66UjeWJ1LMHtZaGd11Y
 cgULfMU4N0oPnRwmDMFCby9t2aTqx9QBUMB9iUvhlcAMfy/jUXTu9avgNdUx1PeBTfGo
 apHPcuA72cWlu1oYuTSQQZfHryNyHh6HNOpxvm2b5mk60YpZ0wx1Jlbnze6R9BgC0DFA
 dBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=s+qEz0hKLfXFu/IJkE2coYGi0IVaIf0nvZ/Eq+C3WTE=;
 b=x3bE11bOTAKFOu1gajyMTJsEvMLSNtl6r6PGnYlofC7fMMgpVym+zJaAKtJSoykvGJ
 OWSrCaCoH/IrVTYLzzzQ/BNvb5TQqd4YIpEqKpXBcxW/yB+2MbJlCtdLAODSd2qBt3Yr
 7cv7wuXJxpgGTCSihYshIFXcvGHZJj52NY8cIamxRx77mZF2yllqsihj/l0anCeMmJRO
 t86nEVsU2d8OyXS2wtzvN5Wd4aLMFYAWKAHVe1mB18q1MaAarS9FKuL+PSS4EMBEBwL/
 tORME+cGLl6WUOfgsfmgmSQ0dwsSN/cobrYiZ4A3m4JGM3M4j56m1aGbirHtnOlrk9AP
 Ietw==
X-Gm-Message-State: ACgBeo0n7H3WKgFsTJ6vy7hLVAtGmggEbH6Lv+xmC68MUXFvD2a/SnVT
 lIKJUC8ztknTT1L239JFpDx9ReR9lRE=
X-Google-Smtp-Source: AA6agR71Q+cApg6+PcFO73CVhSQTxLSxiTaOwWQ3hsCFytVoCLgCDxHWNLK7koBnTMRP5MiitjrrYQ==
X-Received: by 2002:a17:906:cc5d:b0:73f:e0cd:9e64 with SMTP id
 mm29-20020a170906cc5d00b0073fe0cd9e64mr12028010ejb.536.1661847387460; 
 Tue, 30 Aug 2022 01:16:27 -0700 (PDT)
Received: from able.fritz.box (p4fc20ad4.dip0.t-ipconnect.de. [79.194.10.212])
 by smtp.gmail.com with ESMTPSA id
 d8-20020aa7ce08000000b0044838efb8f8sm4454221edv.25.2022.08.30.01.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Aug 2022 01:16:26 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/radeon: remove modeset parameter
Date: Tue, 30 Aug 2022 10:16:25 +0200
Message-Id: <20220830081625.48043-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

People sometimes still think they can enable UMS by specifying
radeon.modeset=0 on the kernel command line, but UMS support was
removed years ago and the driver just fails to load when the option is
specified.

If the driver shouldn't load at all then this can be easily done with
modprobe.blacklist=radeon on the kernel command line.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/radeon/radeon.h     | 1 -
 drivers/gpu/drm/radeon/radeon_drv.c | 9 +--------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 08f83bf2c330..c7f31a9ab403 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -88,7 +88,6 @@
  * Modules parameters.
  */
 extern int radeon_no_wb;
-extern int radeon_modeset;
 extern int radeon_dynclks;
 extern int radeon_r4xx_atom;
 extern int radeon_agpmode;
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 956c72b5aa33..fca6702213a5 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -144,7 +144,6 @@ static inline bool radeon_is_atpx_hybrid(void) { return false; }
 #endif
 
 int radeon_no_wb;
-int radeon_modeset = -1;
 int radeon_dynclks = -1;
 int radeon_r4xx_atom = 0;
 int radeon_agpmode = -1;
@@ -179,9 +178,6 @@ int radeon_vce = 1;
 MODULE_PARM_DESC(no_wb, "Disable AGP writeback for scratch registers");
 module_param_named(no_wb, radeon_no_wb, int, 0444);
 
-MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
-module_param_named(modeset, radeon_modeset, int, 0400);
-
 MODULE_PARM_DESC(dynclks, "Disable/Enable dynamic clocks");
 module_param_named(dynclks, radeon_dynclks, int, 0444);
 
@@ -636,10 +632,7 @@ static struct pci_driver radeon_kms_pci_driver = {
 
 static int __init radeon_module_init(void)
 {
-	if (drm_firmware_drivers_only() && radeon_modeset == -1)
-		radeon_modeset = 0;
-
-	if (radeon_modeset == 0)
+	if (drm_firmware_drivers_only())
 		return -EINVAL;
 
 	DRM_INFO("radeon kernel modesetting enabled.\n");
-- 
2.25.1

