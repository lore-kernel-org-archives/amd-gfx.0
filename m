Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D365C10ED677
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5A010EE2D;
	Fri, 27 Mar 2026 12:40:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XrHNz6CC";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6794B10EBF1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:16 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-4670464029eso730519b6e.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551376; x=1775156176; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FB+tfLWkD+EbK14YUmCdfR6TCrKrYU/mryJ+Tht/PKw=;
 b=XrHNz6CCgaDEUAEukvcraDrd2glQXYXVpWkB7rhXY2nf3WX+5hlbxBnTALSuuh8Uwe
 y0EzW8aSNpA5ez7iRydKoSlT69VBke5mS5l7s6jyyK1au7n7gtggTcnwkfVyiPCXX/Dy
 yKLKAjuc4fQfL3yGyOYebh7AKGV5j+Fi8i8tB0+VUkq73FstiSgzA6lxS+VCJqwSciEG
 q1pZPirCsrcfGun1fepGu+VrmR0MrHJCga/J+2N5Gaq5+gaG51tqGAsiFT8qjY0q1A04
 3QFgQrBLaoH86LYC9onq/Y1NBbJakcWVOTldKlTFcaJi2l7njV6h7wC+B5ngSoHHlBSS
 yFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551376; x=1775156176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FB+tfLWkD+EbK14YUmCdfR6TCrKrYU/mryJ+Tht/PKw=;
 b=Ag3ZbbeU7FLIg1sBmgEbrdC89Pbgvsh3h0sKGqfNjE+YsG/IwYLvUGWh/0EkeHlhGV
 4nAkSTFuPTAIcf16kUbXurEiqczdhytqz7xozMSg8hBB5if8yT2/WhnWMSoykigh5Mw2
 ynQh8f0ig8qJO/0t4e2fynBOMswvvCL9jxaJb2Jp6K5vZ+pUuRKNsvrcy8ElqBVbFgeA
 decRIUCUH+jm84712Sy6sqZlZ2RIE3yMkYWR56bPoD4EE7pUPVPlFR9WtuM8bRwapDQx
 186roDceWJvK2yLV0xeGqdr7gQYuDWrKs+cHr282E7wLm6knhDFlEJt8NwKlKfg4k0wo
 cnJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlspiserRczFf1Sb/kjvDWEzunZH5lVpQTEM5OVNkMx5qgQebHzKxA2asDxgx+4pt744v3ZrR5@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkwBTWss6WhdK1eIbTmZ5z97+trL/oj8YqPmh8ymY7lBQK++Qp
 n+zeyaKb40o/WmvcJcCPE6CY8VZakggv/CWVBsiGA8+XTXVjcCLN3aQL
X-Gm-Gg: ATEYQzzGWW7MUr8bOdinFGaEcQVcAFU53HqrHR5bvbgFYHyFDUvjfze45wM2LMwGQz2
 1SdsQucQCQgtOry3XE0BEFkYYl43Ide7cfRXOMlPnLImJEjiCP9vIwDy2ISr534JITNUtxloZhT
 xjMO2YJsnUmtfItoPojqPo5IEyvw2jKGWC0y8Vi+J6zuHLc1DQ8W1U61SttZriSVtl2J/6nTvBA
 hFVx6JtdCj9hRVQu+0rckG9czfiBaQ8HD0DxgbDZrzHkHiTNIjtvM7/KH5ny/dJ4MJRp8/okDIV
 DFfEAp0iB943s8/GNqiB9cMNakcEMwh+KX+Z8m4T7ClfhPAYJ3xheQjunDdldxZT6mZeR/JdaJm
 vRWG+peE66MN4doXbZI4sDmeTGZ8RlctMyr+vgjxjlZseqtAKW2y63XOjhWeTonV5RYwYC3WDSs
 rvPWlNplsZBLwsAb2QtBty4lfn6WX03BEiLq82+eMkT6pZMPeW
X-Received: by 2002:a05:6808:6f92:b0:467:db5:8b1c with SMTP id
 5614622812f47-46a5c610272mr3956953b6e.21.1774551375644; 
 Thu, 26 Mar 2026 11:56:15 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:15 -0700 (PDT)
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
Subject: [PATCH v12 69/69] accel/rocket: call DRM_CLASSMAP_USE
Date: Thu, 26 Mar 2026 12:54:13 -0600
Message-ID: <20260326185413.1205870-70-jim.cromie@gmail.com>
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

rocket.ko has several drm*dbg() calls, it must call DRM_CLASSMAP_USE
to tell dynamic-debug what classmap enables them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/accel/rocket/rocket_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index b6a385d2edfc..0d06857b96ad 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -11,6 +11,8 @@
 #include "rocket_drv.h"
 #include "rocket_gem.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static void rocket_gem_bo_free(struct drm_gem_object *obj)
 {
 	struct rocket_gem_object *bo = to_rocket_bo(obj);
-- 
2.53.0

