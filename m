Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEE1107BCD4
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5F6310ECBC;
	Fri, 13 Mar 2026 16:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JYdwpci1";
	dkim-atps=neutral
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 460EF10EC20
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:58 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-4671cbce32bso548716b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408297; x=1774013097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDrEVSsHN3/NxzQ31ZhlYG+/I6Z2jtFfe5b8tEwBAEg=;
 b=JYdwpci1Yd7N3lJxHR/Ue0LFCgIZrz5BNSRVr37NSRL3qI8GEbpoAkROUuGz+0wKXw
 xF7RSwgveMEzzEl51Sxfzf9KpXkii9DB3y6OrloIoUF33OP+/8U2aaqzrwJPuSqtMLHV
 d6x8RFZeA8dfRXyZm9C81mbcz8MZUuFcaUz52KLpZ3QgrszPO1qyRHLsxFWET8ZGlIhk
 gTQJ6waZhVrJGsnX2/3RiqR9idjCjZ/PBa2Y7dJNpE+5teFq4aejZR5de9609RQ/0dnx
 qBK5jQF4C4KvK3wKYeNna8SLaEAQirCRsdeT0L49RbN715dqg7wH0p4hH4g/AZTUhLe3
 NLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408297; x=1774013097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NDrEVSsHN3/NxzQ31ZhlYG+/I6Z2jtFfe5b8tEwBAEg=;
 b=VwQTSIqfc2HiCfFhoga6I6j2gd2bOpXLy0bhmOlR5wGnceSP/pa/MKEv4tlIodhqr4
 L+SR9Ka955QrmxAAmKuoGIC4ip95kd5d7eyDsKP8TsHWeQ/sssGMMtFSNo0wGg2pglXh
 dMcNc8I2U9Oyr9bj6Z0xkN1HUbBwBEreB6o8jRtGy88rWqACiSJ5sSPet8UuvHtnDXuG
 uk5+hN8Z/p8Ta7+bL4CegREmi0p+09x/0kTt2QFo8eqrKabWsnVBT7hXyWE3asJcK56R
 H+2LL3QVzOtH0OxZikjbPrNJ6pdE+X+6DdPXJX8lFkq3+FtIwB3uiWSbd39VHS2IyNgx
 j82A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3s4YqNV0BaZuiqK7kW3EV0a4dckQJ5NVTCxTIbcnlUtDHu3VFCpWPjf0udP0IFlibL8X0AgtV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdUVknnm0QohFh9xtLR5kp+YFcVzaJd6aTlC7w7wLzctDwQXst
 DwP1m5I2PzU0W7NbvciUfrT+ksho/FJG4oj3+Dj/iLYaC0bvUyBEal3V
X-Gm-Gg: ATEYQzyUyh2vxVGWwth/HGSw7/2ZMef1F47Bj9lxe4yb/opaPl5DaxwDxflCPQDWyGx
 atngDnIPl3yNj3GlF7tO1ZaET1frxvVCWxwLwpyN+L2Q84EJ+Bkxzu57b/NxpHmZ1M1dl1+pGuj
 JHhEoCN0DTkUb4BpGMRFcpbsc2qQPiyIvZViTDNGSVHIE//A7uxpYkwiWBtR4Rozhy8jVLT9UT3
 0p/VajHd4qt+5OHqEj3y0v8ekUNpeDWE9p2nSJYvlfkeYJWemxxlngQpuuOXL3GN5gNeB1AVhw1
 +v0okkmh1xzgaxzDk08rx3ZURiWdLPztHMcuhh3+kM5LKdQ6+YUEjD3WTwrvsEIZEEWtuZBodKX
 X0A1tpEel7GJeH1TwMuWZV7SDIhtP88Cg2PrwI3gWjfcs+tlUnycP1CNz9dWCt90k57XcK+G1Cm
 E1nL8DTUKVquZqv56setCu19ecOXyVsVrgEnrdO+b77E19R+z+
X-Received: by 2002:a05:6808:670b:b0:450:275b:d942 with SMTP id
 5614622812f47-467570374e6mr1313194b6e.10.1773408297398; 
 Fri, 13 Mar 2026 06:24:57 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:56 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 58/65] accel: add -DDYNAMIC_DEBUG_MODULE to subdir-ccflags
Date: Fri, 13 Mar 2026 07:20:23 -0600
Message-ID: <20260313132103.2529746-59-jim.cromie@gmail.com>
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

With CONFIG_DRM_USE_DYNAMIC_DEBUG=y and CONFIG_DYNAMIC_DEBUG=n,
accelerator modules are currently missing the _dynamic_func_call_cls
macro, due to its conditional definition in dynamic_debug.h, which
depends upon -DDYNAMIC_DEBUG_MODULE.

So add that to subir-ccflags for all accels, in accel/Makefile.

Notes:

The added "indirection" allows modules to individually enable
dynamic-debug, where a CONFIG_ option would be global to the build.

Several accelerator modules make drm*dbg() calls, so in effect they
*are* DRM modules.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/accel/Makefile | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/Makefile b/drivers/accel/Makefile
index 1d3a7251b950..44db786ea223 100644
--- a/drivers/accel/Makefile
+++ b/drivers/accel/Makefile
@@ -1,8 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+# several accel modules use drm*dbg, so they *are* DRM modules.
+# When built with only CONFIG_DYNAMIC_DEBUG_CORE
+# (and not CONFIG_DYNAMIC_DEBUG), they need this flag
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG) += -DDYNAMIC_DEBUG_MODULE
+
 obj-$(CONFIG_DRM_ACCEL_AMDXDNA)		+= amdxdna/
 obj-$(CONFIG_DRM_ACCEL_ARM_ETHOSU)	+= ethosu/
 obj-$(CONFIG_DRM_ACCEL_HABANALABS)	+= habanalabs/
 obj-$(CONFIG_DRM_ACCEL_IVPU)		+= ivpu/
 obj-$(CONFIG_DRM_ACCEL_QAIC)		+= qaic/
-obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
\ No newline at end of file
+obj-$(CONFIG_DRM_ACCEL_ROCKET)		+= rocket/
-- 
2.53.0

