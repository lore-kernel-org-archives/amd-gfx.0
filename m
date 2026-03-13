Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7616F107BCD3
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF7D710EC3B;
	Fri, 13 Mar 2026 16:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CCdlUqIj";
	dkim-atps=neutral
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C98B10EC09
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:11 +0000 (UTC)
Received: by mail-oi1-f172.google.com with SMTP id
 5614622812f47-464bc03efd8so1515337b6e.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408250; x=1774013050; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q+DKhn/7Y3l3C4FKBxAszRLz9P1Pf05n9UBGOlLEX4s=;
 b=CCdlUqIj86TorFk4KSYg+b4tsZCmtkzcAa6Rk//JUwPSP91VSl8MKtp6KZhbGtDEOO
 3oz3ev2tlbw4DONzwIJsDPdy0+GJ4J6XiXUHEKlPmI5B2/BSdpS7YLa3DggfUdnf8ISY
 6LRUlx/uIG5+tCjc7CwFH3aqvyUDKER9oG+Q0tOFdHSoIIIs0/W0X4/oiwXeussBhApw
 yTvnYNrBrhtLeKKoPKl8LthB8WExyn9ITQgdE9Gl33CnIIGEfQTLd1t7GcdlTHyVsQht
 qnfcsT1nywAN9G2DTywTq3+O0QGymJMl2ZV7P4N7Elgn4OI/pP0t+x9DyGRD8Xa41/Q7
 bbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408250; x=1774013050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Q+DKhn/7Y3l3C4FKBxAszRLz9P1Pf05n9UBGOlLEX4s=;
 b=E0w1WKRV88ah4l2Iruah1uYoHGLumzlRIVY5Gwc1YjLi+fxCq/DJAc8at6jqkUEdIG
 d3h5MnjZiFdCJbRdfJNwphqAlH6/8oIzXszbD7Ecdw8ca1n2YUV4hQ+H0/u9zW0V7MwU
 JuByTBgYmxh77VNfs+lsPBVykXber3ghVkldcBDC/SGdjjfY5Mbye5F0ZmZB2OgepYm9
 mbEgGXC97643Zl11E3hvDLasfRALEq1Z5LExI+1NShGFoJ8URLq2lZQGTZBK2dSH4QC5
 f8IrO6GUZMYt4BBtrXx9LFm9i6J+11PlWQ1riFjEVt/vdH8+dLzxZxpg50XdVfga8lQQ
 ECXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZLAYQFlmGR8rLnUzgmvuQzIIyTMi5n3512cIXr2w3AHuGLrWWnTspm6HyT0dBzeJBhIDMGGFg@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yws6kxXYAjENaVQZLFK3zbAoV5ezISJvbNaeiAQ4vnPupWbGjeK
 QnHZvXGEkUDuYzd6+WphzCvOPFAKOnotvUnT60Cm4k6K7pSEVrUIZW9X
X-Gm-Gg: ATEYQzwAPKVVUgR06U867CVGhGBHQGMVlKKv+BEi3aPV6ysQq4mfZ1C88jjTZepwDAE
 d6xc9JQH0xA/zSMIxRLmWVg+LMkm1hSx1yctWxZKwVbV9gtsD9IQJ2UgCFT4ONoo0hoBY3DIfXx
 uVs/P0Rg6wbtWH9lcXfZhSN9Gkhn5Ddl6gXylpw2iORP3p6K1L96Fts+ZfBl6gSMk0VGG8hUTi0
 qoHe1g46O5faIslqHwdNFdRFKTQ9QHCrwRMiYZi1yTObWxjxtas1m0zxJgZpXFyfatRexRx4EDa
 Xi2bXN7/83tkYQ4Z3ZiHtxpUCA5ScWG8qX2uRDQ1MwBiSSeRf3O2CdmsNqPYQ8toUejFRM72jHC
 JD4EM0ukxgoQd6HW36eJbSsl1X7l26cbyZUunzeJlYT9QrHMAlFuL+cwLNU0VZKWnz0IRjCNiD8
 cUWGp0UvFm06fyL/zG2WeZP4Vqrbx0VnuKU+EiOrydtjRnD7jU
X-Received: by 2002:a05:6808:15a2:b0:467:5571:1b0a with SMTP id
 5614622812f47-467570d9e44mr1817008b6e.26.1773408250365; 
 Fri, 13 Mar 2026 06:24:10 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:09 -0700 (PDT)
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
Subject: [PATCH v11 34/65] drm: use correct ccflags-y spelling
Date: Fri, 13 Mar 2026 07:19:59 -0600
Message-ID: <20260313132103.2529746-35-jim.cromie@gmail.com>
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

Incorrectly spelled CFLAGS- failed to add -DDYNAMIC_DEBUG_MODULE,
which disabled dynamic-debug in modules built with:

CONFIG_DYNAMIC_DEBUG=n		# 1
CONFIG_DYNAMIC_DEBUG_CORE=y	# 2
CONFIG_DRM_USE_DYNAMIC_DEBUG=y	# 3

NB: this adds the flag (when 3) more often than strictly needed;
modules built with CONFIG_DYNAMIC_DEBUG=y (!1) don't need the flag.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index aba4bf542a35..02e244688b48 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 # Unconditionally enable W=1 warnings locally
 # --- begin copy-paste W=1 warnings from scripts/Makefile.warn
-- 
2.53.0

