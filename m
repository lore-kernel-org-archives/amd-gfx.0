Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E2BC433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 13:05:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D39112F61;
	Thu,  7 Jul 2022 13:05:10 +0000 (UTC)
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072FA10EE6B
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 12:55:06 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id g126so4765666pfb.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Jul 2022 05:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=djYDp0B0gztHKzMN1HyH5UR5VL/m7SL/hwecWzC/xyU=;
 b=xEVJs62ww8Zm9XOx+6s8ef+xPXYqM2mZOqcwLhD9RBe8nMGwM/rki7I4fcYc7mWKIM
 wF6lvl3JCQGGn59be7YFHFN8DV3tI9dIk9JHHkgTZWNcffdxwohgn/l/7meTZmupIO/T
 cn4HzGq2CLNg305C4eaP2dePKG6naoIuM94bPYYeq7URSPOtYSBfnCh7KWpA0EU0Cq3g
 L6Nihy8D6aMD+jp/Q4QCltk7dOn6wB821geE38IEwZtSgb7q4v1ot8LN9X1ScPUOYyJC
 nK+1xoA/NGrxBgL30YOspuejRysmKh4uZe+3GASm4BtX1PMAryrXxMshG1tXqzHpP2GE
 u/XQ==
X-Gm-Message-State: AJIora/vv8gemncIAJPBoWSB4i8cZOzMMBaYtrNXThJLtmEM2CDtWeF+
 vqjkHNC4X26zhDu94Ees1A==
X-Google-Smtp-Source: AGRyM1tsQHYY3ss6PLRUQEO52WR2JENZTdnZeq5P0fawokSFx6PG2+gxT2yTdaO76TadjVUsI29k2Q==
X-Received: by 2002:a63:105d:0:b0:40d:a82d:ef0e with SMTP id
 29-20020a63105d000000b0040da82def0emr40249055pgq.57.1657198505371; 
 Thu, 07 Jul 2022 05:55:05 -0700 (PDT)
Received: from localhost.localdomain ([156.146.53.107])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a170902e80700b0016bf28cc606sm6103044plg.156.2022.07.07.05.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Jul 2022 05:55:05 -0700 (PDT)
From: sunliming <sunliming@kylinos.cn>
To: harry.wentland@amd.com, alexander.deucher@amd.com, airlied@linux.ie,
 daniel@ffwll.ch
Subject: [PATCH] drm/amd/display: Remove redundant header file references.
Date: Thu,  7 Jul 2022 20:54:46 +0800
Message-Id: <20220707125446.379104-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Jul 2022 13:05:07 +0000
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
Cc: kernel test robot <yujie.liu@intel.com>, kelulanainsley@gmail.com,
 sunliming@kylinos.cn, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following includecheck warning:

drivers/gpu/drm/amd/display/dc/os_types.h: drm/drm_print.h is included more than once.

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 drivers/gpu/drm/amd/display/dc/os_types.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 795dd486b6d6..6b88ae14f1f9 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -39,8 +39,6 @@
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_print.h>
 
-#include <drm/drm_print.h>
-
 #include "cgs_common.h"
 
 #if defined(__BIG_ENDIAN) && !defined(BIGENDIAN_CPU)
-- 
2.25.1

