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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527E2C48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 08:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E0961289
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 08:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E0961289
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D85C06E40C;
	Tue, 22 Jun 2021 08:12:52 +0000 (UTC)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E846E192
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 06:07:16 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id g4so11483626pjk.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 23:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition;
 bh=C2BsSCuEEmRCddtgAxqVh2meXkFZVrya2AaC0x0Wyy4=;
 b=Kx/SxTULRn3X9l2oxV9aWKSNrYRWKoHZPeqn9kHpKZsngkOXClFw+XgAcJfoStI/dh
 MYzvkWlGqOAhg6IriLEsc36iWmI1OLZ3VPy94jdPZu7Jn6PAep8co3L8dOjzf53UTzQb
 MNXVmFefn1Z37CkOwRc0CcyhK/CPiXAPUsCL9lU74gnnn8LfDOLUQzTs1lCX8xTKC4qE
 09kmWA629UUWajWfU4fRdtxeQy4mRsvAPOvN4nm0zrZRNNwVP+X7bxCUQD8RrDez5YXV
 eIgWnN/Jvj/xnDcqaJdC6isoDvhoWMFulADt8+8BfKrKYK5nCnawtPwhDJuVnZcbovXe
 07Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition;
 bh=C2BsSCuEEmRCddtgAxqVh2meXkFZVrya2AaC0x0Wyy4=;
 b=JwSfMkzjQuVw41jOhiyv8eju2s5zKNEFkxiJvKZZ9jGFruaiOLvjBU8kwhkGqFtHhf
 ErVkZvUW7ou2eIDdvgVxST81mqWpUvpcdu0fLs+9GdUtPsJ9STV/ubw4qTarRiXD0f+B
 vMZE6WTcG50dB4j7UJUduYQEj88VipCUYxLFqFmvUc3pykkNNOsNTW+yJC6taUIGbilK
 oN9NvRpgMfMA/wSvWHbmdyXeEsDCcaHvT6DTgPk1SffsiLFmU23Nt9p0QcFcm0bdqrSf
 sUm/zY4O94IruRO7Da1ayqkOUCJ+ePs40Wv8aWKUoE9oXXHe06DLhpOA3D4XM4QmKSYz
 yzHQ==
X-Gm-Message-State: AOAM5337VlSssYSjFr52FTtAxg71LZAtDAOeaQQjIUl345N8PR2LGqln
 QtfF2IuVFG56GZKOjVDET/E=
X-Google-Smtp-Source: ABdhPJx8l2KGaKCkgy34p/BeK5Eyz7A6wHlEC6idFHdIMX3GIUtiOIGgLvMBHUZKYoGYExuIAoD4+g==
X-Received: by 2002:a17:903:2c3:b029:11b:cbb9:edfb with SMTP id
 s3-20020a17090302c3b029011bcbb9edfbmr21135204plk.12.1624342036348; 
 Mon, 21 Jun 2021 23:07:16 -0700 (PDT)
Received: from reb0rn ([106.214.189.31])
 by smtp.gmail.com with ESMTPSA id r128sm5272007pfc.138.2021.06.21.23.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jun 2021 23:07:15 -0700 (PDT)
Date: Tue, 22 Jun 2021 11:37:06 +0530
From: Aman Jain <ahjain2706@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] This patch replaces all the instances of dev_info with
 drm_info macro
Message-ID: <YNF+Cr9wHupnt3Za@reb0rn>
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
 drivers/gpu/drm/radeon/radeon_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index efeb115ae70e..75e84914c29b 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -308,7 +308,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		case CHIP_VERDE:
 		case CHIP_OLAND:
 		case CHIP_HAINAN:
-			dev_info(&pdev->dev,
+			drm_info(&pdev->dev,
 				 "SI support disabled by module param\n");
 			return -ENODEV;
 		}
@@ -320,7 +320,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
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
