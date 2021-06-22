Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098BFC2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 08:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C955261353
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 08:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C955261353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62DF06E409;
	Tue, 22 Jun 2021 08:12:51 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 060196E332
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 07:15:39 +0000 (UTC)
Received: by mail-pf1-x42f.google.com with SMTP id q192so9135171pfc.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 00:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition;
 bh=hYMNCenjCAhamfzLr7D05l56NW7Op2cCAbN+Ba2rTZA=;
 b=EdhUCpG7O4Q16Ez0skkCkQdvnmN5fFwngV683KHpsxyW6XJYaMwQRjGOgfYRCCpLSK
 I+njOcG95b3SWmK3C5Uc7vUD0m/+iOeIrjCNxJvs+wxuXjTUWfyO32lPP7sDmeTManiF
 2l1g7L7d19r5vrfHerlrRI3cnE5iyQRQWs87Ov8mLkajWOrBiJ+SHb6hsFmjjqhpYefz
 DhUGoEmXcnRiamMcxKqjumtekd8zO0yMAykzFxT0e/e27k1ye9msSiBfQXESTqYNxNuD
 sjVm4XlL8itEuUlmXFbXBRZC5zZKE9ipWGz7kdtqtRMBX9aAgsJk+XpoWkm9h3S2G0qO
 72GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=hYMNCenjCAhamfzLr7D05l56NW7Op2cCAbN+Ba2rTZA=;
 b=PA9Bc5ScDR6jUEdas5s590s57Kp3LDdZKkewiDsl8Pl1ELXRYTVFS9A5lC9JRzK3UN
 iRnjLHIYK7WFDVw09W/j1+5auBmsJ52JU9LBvBapd8SoMBk/i2tm6oXjJNlE6gYJefo1
 LghZw3EECd1/KU0uDF55cgBG9HEsceEsskyQc1wiAR7Jogesqjz06mLOsifSigbzJtya
 IDdmv+pM3WkUu3vgkIG3z9jVw5/cJIcP9ey4kz0WhOTM+cL5f0rRTkxvX6ubuH783a8D
 zYZyY2WpKWwCpoFgAuLvidv1ubu6wvDxSWrb6pV02Lio7A0OxjAOAwzWTanpUHo4In40
 E/Mg==
X-Gm-Message-State: AOAM530RaNUzkpvYiMwrdO0ZL5NvL2FQAmqJipt9nJuJFyS3Al0XI5jc
 kqFm6M5eqrZCFZ02CXr9BU0=
X-Google-Smtp-Source: ABdhPJx6EN8dmlbBNZm3FErHhTPfGD/MEHfB2M3Jx4aPORDAgnRtIUsyttVHAvBAmUBtJGlGyKrBqg==
X-Received: by 2002:aa7:81c5:0:b029:2f7:d4e3:78e9 with SMTP id
 c5-20020aa781c50000b02902f7d4e378e9mr2303784pfn.31.1624346139636; 
 Tue, 22 Jun 2021 00:15:39 -0700 (PDT)
Received: from reb0rn ([106.214.189.31])
 by smtp.gmail.com with ESMTPSA id s16sm17666959pfc.33.2021.06.22.00.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jun 2021 00:15:39 -0700 (PDT)
Date: Tue, 22 Jun 2021 12:45:30 +0530
From: Aman Jain <ahjain2706@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] This patch replaces all the instances of dev_info with
 drm_info
Message-ID: <YNGOEugOA232znQD@reb0rn>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 22 Jun 2021 08:12:50 +0000
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When a driver has multiple instances it is necessary to differentiate
between them in the logs. This was done with dev_info/warn/err since
DRM_INFO/WARN/ERROR don't do this. We now have drm_info/warn/err for
printing the relevant debug messages. Hence, this patch uses
drm_* macros to achieve drm-formatted logging

Signed-off-by: Aman Jain <ahjain2706@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index efeb115ae70e..639c447d9a1f 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -49,6 +49,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/radeon_drm.h>
+#include <drm/drm_print.h>
 
 #include "radeon_drv.h"
 #include "radeon.h"
@@ -308,7 +309,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		case CHIP_VERDE:
 		case CHIP_OLAND:
 		case CHIP_HAINAN:
-			dev_info(&pdev->dev,
+			drm_info(&pdev->dev,
 				 "SI support disabled by module param\n");
 			return -ENODEV;
 		}
@@ -320,7 +321,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		case CHIP_HAWAII:
 		case CHIP_KABINI:
 		case CHIP_MULLINS:
-			dev_info(&pdev->dev,
+			drm_info(&pdev->dev,
 				 "CIK support disabled by module param\n");
 			return -ENODEV;
 		}
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
