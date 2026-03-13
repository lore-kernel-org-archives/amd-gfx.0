Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887C9107BCCD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB5B10ECBB;
	Fri, 13 Mar 2026 16:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JHhoQ1LH";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1221410EC16
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:26 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-467166cb638so882313b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408265; x=1774013065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWuUyl3pJMGaRe5YpqoxGiWQwsY1kd47fne8B+3aeoU=;
 b=JHhoQ1LHbhboxKzHssmKPQavUUSA9XfexDh9MzwWt/CfUYvXh9u2emKWta+s/Lgi9s
 cVmZU5HRH+g8VRE6LxWxAqwy4sOm/KqiT98i0VsooX/633mPOAPYrNlAjlraNOSuOc15
 jxGKEa0+ChhjZvhvdlDUfbB8Ey8euoRQixOx3OV9YlcMdN/iCAxpnEhRSz+DfQMOJ073
 myeJJIGOmdbX54vquwxbRytPL7kimfIqXQH5kjzO5z/lj2ZN9/aZTswOWrsROZK/0iEs
 2rICOXrSdVrU//84Vn0TahNNtJZf9AeeTc+aCG5R5idzVKWb9jRb53+PZDs3ZQtTnmU+
 9aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408265; x=1774013065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nWuUyl3pJMGaRe5YpqoxGiWQwsY1kd47fne8B+3aeoU=;
 b=gev4tQI5UeEEYYsIizL8H41Ip+9UQCVMOPUO4NR0eKoT1ykUbFpA8T3jkchP+Eb+Pg
 6zMPdbuWelOKxYii4A4t+EM5D+V4zGzvvJET7TgMHRM/CvEO18ucM+Pwc6XQIRQZC24N
 EEJWuEqu/eSBPL/cCVzNyCjUXw0m2sTaH1XgQ+vS7VnK9KEIvj/ca60OIRWglAElAkRO
 YIomY2rBryDr0HiOQi9yj67VpawArghjK8t6nv68lDvzRj1GXpEKwDv6har42pQ47dIS
 7DsX5Dow7NZdMCMjc8pWzov5zG0Z/2HuJKM5o8UholFGrTn3NMjqAU7wKWbVDYpL+yeO
 oV8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhrNvwV63AUvSpaYNOnW2jsp23a/o+Z0K8EfQGsJ0n7GXdI6wVp9Ixh3Hc9hyHl5cCvDE7kF8h@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxswW1qWBkxzzuKW760/ssFDQC/W1A5TE+ZdHn2HjFjeiagefWV
 2GpJB6z+btAPhHzwSxB40qgrITywZgXxQpsrqpZLniQibRWekN1KOmHx
X-Gm-Gg: ATEYQzx1gli4Ua8gCi12OPi/ALejuFudpSyiPSdM9L6XUzsAYkAW5iTgXl5krgXzeDD
 KuQDOT/gjxmqvzI5+kFtA3cD9RoNGPbyVEd/SHHiw/hOvGPtKYYJNqi8akRYcoW61PdyRRb4Oqk
 sVU80oU35U5YUVcXfrKvloWiLvB2H5BKnTFlwmX100Nedg1+Wmp+AC2g9w3OsVju1j4Pm5yMvaG
 stfAauE5ajIE+ecHAa2Mea67EReYASTtsHjtpRoqajix0Ra/9j7Xv8bFUgXtO3UjWAwX1wyGI9/
 yQBxQgg93DJ7N6EG3d78uDd1Xa8DFdPbH79D5cp/3lT+96xZclJ2r3Gx3IFyYczIdCgRmGgWmob
 1puJTolg3EbW/37ChnytoWWBgLvoVPOzT8+YHBC2TwZ/DdNZ/EyWp4mDRiBDIDzaryDKQ9O7uIK
 MXuWP0WsQWQqSokMV6Y1Odj6msGrP+PCpPau2Q5bJMINvmdmwM
X-Received: by 2002:a05:6808:30a7:b0:467:100d:22ad with SMTP id
 5614622812f47-4675708e938mr1535630b6e.18.1773408265054; 
 Fri, 13 Mar 2026 06:24:25 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:24 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Jim Cromie <jim.cromie@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 christian.koenig@amd.com, matthew.auld@intel.com,
 arunpravin.paneerselvam@amd.com, louis.chauvet@bootlin.com,
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org,
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 41/65] drm-dyndbg: DRM_CLASSMAP_USE in drm_crtc_helper
Date: Fri, 13 Mar 2026 07:20:06 -0600
Message-ID: <20260313132103.2529746-42-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313132103.2529746-1-jim.cromie@gmail.com>
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Mar 2026 16:51:10 +0000
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

Following the dyndbg-api-fix, replace DECLARE_DYNDBG_CLASSMAP with
DRM_CLASSMAP_USE.  This refs the defined & exported classmap, rather
than re-declaring it redundantly, and error-prone-ly.

This resolves the appearance of "class:_UNKNOWN_" in the control file
for the driver's drm_dbg()s.

Fixes: f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/drm_crtc_helper.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 5de9aaa5ba04..31c5294b252c 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -50,17 +50,7 @@
 
 #include "drm_crtc_helper_internal.h"
 
-DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"DRM_UT_CORE",
-			"DRM_UT_DRIVER",
-			"DRM_UT_KMS",
-			"DRM_UT_PRIME",
-			"DRM_UT_ATOMIC",
-			"DRM_UT_VBL",
-			"DRM_UT_STATE",
-			"DRM_UT_LEASE",
-			"DRM_UT_DP",
-			"DRM_UT_DRMRES");
+DRM_CLASSMAP_USE(drm_debug_classes);
 
 /**
  * DOC: overview
-- 
2.53.0

