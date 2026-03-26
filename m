Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5D610ED66F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0529E10EE1D;
	Fri, 27 Mar 2026 12:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dkjCJnPg";
	dkim-atps=neutral
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C94A10EBF0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:12 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-4670bcc40d7so499635b6e.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551372; x=1775156172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDrEVSsHN3/NxzQ31ZhlYG+/I6Z2jtFfe5b8tEwBAEg=;
 b=dkjCJnPgmwZXQDBSDoi4aUBvvDBV3dRyMClnqWfixRKMZiVaJ1gFMO9H7oZzwSkgyT
 cSZkqTprD3AzNqcs3OfIVGaOWUvWDT2Ox/yzC/xgbRDPEeqCBNXBUNZu/ynKZ0ab7CFy
 Do1vcb3l9QJF9zOWPsp4Gg8aRHTCj5gtET66AIdrZV9Vmnkb+8lS4mCdBW+pVYEqnb7K
 MRDtwIE9RfQ27NlRewnjxi7VE/6HkZ8KGBAYaMy6zgv/h4cd9IoRdPKZomUieaZPS3fU
 v93H1PvKkr8gDB+D3WuaDSVjN5bbl+UqUFV7HYjfLshM1GLr3SYlS1tF5UO9b1c/qAtL
 7xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551372; x=1775156172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NDrEVSsHN3/NxzQ31ZhlYG+/I6Z2jtFfe5b8tEwBAEg=;
 b=UiNXc5Tw4TfpE/H8EaiGqNiWplTGW0bWEXEjGiWTSgf1NhyM8Vbj9qPb+tnnFH78iR
 aLvikk6lM/lFMnY1Wmoc1X5NYx5v6LlVqWoVso1opiF0KbL6rVgWFCstZJPaL4AjxpB/
 PlzTMKX42bMN6voje5FWHTgpSVDpjaO2mCDt7KElGJX8yxffJLPYyi03YocePj3Oi0n3
 l4H+4fa25LiVQsSybTjTV81KGpKovS2iQDF8hNW5q8je3E6+cuvwwahibuaUaS+H9lM/
 +42zPVKjqe5cj8comAEzjfFPJeG26Kw+dlkpq32bJiZ4tg28od8m1zEtcGnk7GWj+x+e
 3Txg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6AXTkgPf9EugBemx1MHqTRRYomi3x/mG+BZd2xAoeoKvm8pQP6kPgLNwqn5JAEGsU2l6xXOo7@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyaRjb6Gr/TwnACYbovgVIBDY5dT4uv+Toxx2cU8771+REQ9lhe
 feqJNM0bJZ9ZykKP8RW0UN6UXaIzgT9UBhFD2IdtROgMOyoM5cT+Mt/U
X-Gm-Gg: ATEYQzyY11feZUOeBkJ3TkYf+FUG+00n1v5pySHrca/hI/9INnJQFybW2eeWFMukGbz
 5vE0XSGqKYfneRwl6JQerLcDN1ISJ2XooUrVhwGm7sHfYLYmDL8qpqCDsVl5Mt18kMbe6CSaIw8
 9sHmZwRZ0gPkdkFfTlCHtqX8s/uKxhpXF3NuhiqKP9r73/SUo1xf0Z7i9eG43Psb8ix0a6qF6Iy
 bDRUa4lOf9iNlSH0IbHJDKba6LLtGU8fgYaHqgtIKG5X07ZYF1GcuDT9/++jabwb8Hy+iGQ+aLV
 B7RsZQwSmVXq0VLrluTWH5iqbBFkNA+fJ/Wb4u0buOv7yK1fuUtV5Ufqb6/fFmZEs89OTbHU97u
 HAQBJ/t2Svji4WqgNMoRU2M2ZMt1wuYqUaBYkOzk/1f9ECvlb7nVFGWoArk/1AbBkOrXWYSxF9u
 7ofNm3OiWPQL6IUb/aVyyRM0faJA/5tz8HdM3iqhsT/VqvSehf
X-Received: by 2002:a05:6808:c295:b0:467:2926:123d with SMTP id
 5614622812f47-46a5c77d4b2mr3987875b6e.47.1774551371661; 
 Thu, 26 Mar 2026 11:56:11 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:11 -0700 (PDT)
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
Subject: [PATCH v12 66/69] accel: add -DDYNAMIC_DEBUG_MODULE to subdir-ccflags
Date: Thu, 26 Mar 2026 12:54:10 -0600
Message-ID: <20260326185413.1205870-67-jim.cromie@gmail.com>
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

