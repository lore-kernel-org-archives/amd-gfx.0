Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23CCC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 13:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C08207D3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 13:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzPZ/pXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C08207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53E0B6E570;
	Thu, 28 May 2020 13:44:56 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE156E570
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 13:44:54 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id c12so16547qtq.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=getT7JCz6qtmiSGMcZGt36VjlRCEtqBZ38qEuz9Qbgc=;
 b=jzPZ/pXSIw2xfJMg7N4HOgt8IlXGaNHczGYZLEPi3BqM7yCA7+AVoOS5mSC1TbZQ1X
 96hpoV1mkvzDfpIG8Am/+LHnM/VQRUkX/wILn7F+GGpfwbXZcV/zxOWwZkz8/KZe1xsq
 1DbbJnyaZOdkQG1LCH2J5zXDtcTXBOpuPuQ8tBMDGcPhMY30chUXknJ6HagAe2I7D6fC
 TynMMWuBWILxD6hY2wQwJtH4j4ijQ9FbBrea2AMrc63QVWtac4oU3PpXD5suVF1m8/me
 G+w2adkYRTR7w1IcuPInnu4Pq1WpzeOYplDYplIQgpo9VTwsPG8G+S28AaSLZHb26mGc
 1nXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=getT7JCz6qtmiSGMcZGt36VjlRCEtqBZ38qEuz9Qbgc=;
 b=pD+kE36wjGoGQUaULqVFCALxMFt4RRL3+blt6dImyUicTCNqaurSS9aJwy7arn9rRu
 CnlYH/UUU68pstOi0POrkRB95E3oK5oPwXbfEQxQfX+dhlC/JhbbW3G3JjXQdiWILFjS
 XwT++TCbqF/karTzYJK0gLh4Ii2rNKkhuGAscJW9BadUy141lM91t9x3Qx/+IXdlEEPB
 m41PDFGBuB0csZ2JGvDLU6rgwBJGFpZKaQn7DT4BY8GtqeisvL/p1bbaU/VCr8o2Fidn
 wBTZGsN62vf6c+gdNHRXlTfOgRga6BiJzGQO1txXHOcPFqz3gtPBp18noq10RmknXMll
 xuew==
X-Gm-Message-State: AOAM533vSIwghy57YsdFnx33KMaOzWvmN5e3vbegi3j/8yRtqIaRADZK
 y9dxKj71A9iYyavaKgF2sDspaFKW
X-Google-Smtp-Source: ABdhPJxQmwiIWQ+pv/ST2OYxlR95nkvhlqa5mz/UJjXlFLxCEpUPScl/mlpwOKWgoOLrRi6hwvxO3g==
X-Received: by 2002:ac8:31f3:: with SMTP id i48mr3149284qte.128.1590673493502; 
 Thu, 28 May 2020 06:44:53 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m126sm4914629qke.99.2020.05.28.06.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 06:44:52 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/fru: fix header guard and include header
Date: Thu, 28 May 2020 09:44:45 -0400
Message-Id: <20200528134445.246773-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the fru eeprom header guard and include it in the .c file.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 815c072ac4da..6ae80b33182c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -26,6 +26,7 @@
 #include "amdgpu_i2c.h"
 #include "smu_v11_0_i2c.h"
 #include "atom.h"
+#include "amdgpu_fru_eeprom.h"
 
 #define I2C_PRODUCT_INFO_ADDR		0xAC
 #define I2C_PRODUCT_INFO_ADDR_SIZE	0x2
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
index 968115c97e33..f29a8611d69b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.h
@@ -21,8 +21,8 @@
  *
  */
 
-#ifndef __AMDGPU_PRODINFO_H__
-#define __AMDGPU_PRODINFO_H__
+#ifndef __AMDGPU_FRU_EEPROM_H__
+#define __AMDGPU_FRU_EEPROM_H__
 
 int amdgpu_fru_get_product_info(struct amdgpu_device *adev);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
