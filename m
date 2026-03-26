Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E310BA434
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3148310EDFD;
	Fri, 27 Mar 2026 12:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jH8JNCjP";
	dkim-atps=neutral
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77CE10EBF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:55:53 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-40438e0cba6so843024fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551353; x=1775156153; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7n8LRPhTnKwHNdLKddxIC02c+MckVOPZFH0J7I21NQ=;
 b=jH8JNCjPnhoEXU8PXBKagfcumi83KxobSi9w6zSWsuLksp4W8J2B1gRcw772lV+oWG
 Z0pvsdQs15w1LZhq4r0oPX2zvEGnTctTZPFjg3TDovnf00IspfboybiKY3V++3SDFV3b
 7TRfM6q5V2mv+FEgitJ0HADKEBszbxqcT4EvNqpURVvc0y2ZRdI+/Ti8dtyChAMjUX4C
 NTVpOOGBQDiz7VoQXwM4oKRsWgdA6Oge8C7pJDih8T4/rG0rGS/bhNP9ZV0BiV8U4wjY
 kbrBXkImgcBLHCwTQzZH+AJkg2SNnVAc4AOynGxJTaJ0k7nNkiQKglLDd5k8bgWY/zD8
 OYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551353; x=1775156153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v7n8LRPhTnKwHNdLKddxIC02c+MckVOPZFH0J7I21NQ=;
 b=b44H3ZgQCbEDwGi7jfITe8bUkt+hqUsYMCZJwJzSlLZAns4lveu+RSrLbIac2ohNqC
 rxGB+yW6dpT0Kv0F2W/0yJLVFNaQUqIhDqVeQIJC4gtPQ+Dnndx08uxuTtgxtpmgnTX1
 2VedrDR4JsuOgzaFzfY8KxySCHJ+9e034xDPHbHLTObORMgY2poJuvR+PQq4G0mzd1s6
 AdY7G9CdzN/N/PrmInyECCUTK/rYbUVnBseaK7+3YXl+Z1OjEUah4xMsK18KenAeCeC+
 DgWyLmmnbrmxS4AOanHXsxNbkBKiHUGWgAJ70d9i1wd2kFC65n9LA7VF8Pc5NPeOgLFp
 Z79A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXen2Aha9J9F8i1KnMAgqs1P/MVpMFzJJa3EC7oUVwN8DI+JMyXTxtOfdnWxgrp+vcfQ5kUsICE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwuhN8l7KBLUm5K2BtR/Ss9m5DKPY3SINh++Qfw8G6DW/2B83/
 x0MtubwYigG66QfQexqvnFTolsg4A8DjySQhareyDlVJQoyk9l0NSzH4
X-Gm-Gg: ATEYQzxbBzW8UZy3sIqdl1rkz7dcvVmxdTxgBaGQ59A1IjruUdP++N/VUaF5J0TXxgc
 Ouh4ju8F803gaaXSrpMydvpM3yY1dQHbrTsgJnk6HUuuT62hAKXLZnni2hHjd6yKDwkjlGbDBJV
 kTxtEwE8Gzp0CbBSqqHweGd1jjqFuMVgTwXscjOIjKxH0h1phZn3uxb8pBnogufxmK8e5e3Gyuc
 +8gVx4KBnhoOyt0rfS7LXjcGzLPtbGcgvDYEuV2aqh1E4usAGj0Qp0c6fnEW385Yts5lIWUoNob
 89dl70tl/wlkq094RiUHcivRxfYL6fkWlph/J0yGscFXoiEiYxzwWqLkdkNpjkTihSwFfGChUAk
 bwBcsPPIsjMW0GNFUD/PuACizxm/917nQCpOVHLflUAMO3pf62EderHfGVWrg2sCk55+4AcLn3c
 5yAo7spdvDRGgnPdTd8f0qTeUZaKkK5Sw550GZUZVS9/V/pEBV
X-Received: by 2002:a05:6871:608:b0:41c:305b:14d0 with SMTP id
 586e51a60fabf-41ca7049e58mr4680983fac.35.1774551352968; 
 Thu, 26 Mar 2026 11:55:52 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:55:52 -0700 (PDT)
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
Subject: [PATCH v12 53/69] drm-dyndbg: add DRM_CLASSMAP_USE to bochs
Date: Thu, 26 Mar 2026 12:53:57 -0600
Message-ID: <20260326185413.1205870-54-jim.cromie@gmail.com>
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

tiny/bochs has 5 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 222e4ae1abbd..8f04666e7def 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -63,6 +63,8 @@ static int bochs_modeset = -1;
 static int defx = 1024;
 static int defy = 768;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 module_param_named(modeset, bochs_modeset, int, 0444);
 MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
 
-- 
2.53.0

