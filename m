Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A86A10ED664
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A36A810EE0C;
	Fri, 27 Mar 2026 12:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CZp95l9S";
	dkim-atps=neutral
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com
 [209.85.161.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9195610EBF2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 18:56:06 +0000 (UTC)
Received: by mail-oo1-f49.google.com with SMTP id
 006d021491bc7-67c1b8b1f96so850416eaf.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774551366; x=1775156166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ves6/eFJLAs0HG68Znj+VH4wZtUdDvx4ZnDak47UPW8=;
 b=CZp95l9S9Yg0SfZ7f6KlJmcbF3c0GrNH5LivAhepCkzOCZxIzhYPQ5V0+MMdGr0oPj
 qvAAfkr2NuO6GnJMh2ijqtP1zTRFNQhamyI/4PfpO1PiSQ1HndiWySTNnYySVUGeGm0X
 MM1O1au+mgT/HW8nm+YBrfA/D1gKUpHmUrfjqgg9E/P55ms/lAfgqX0tfSkymtmadq44
 73IGoPISKS5Xcj9/vDEA7fzJeLZvJrTDFcd8KT9rMF33QhtrQbuGFICeLu3bYJXX/zrO
 pvzjML5Mf7pO4S7J3YI+mca0pEIRL6tZy5SPN7zezyG54qtBL5YI6ePzU5mXILcNUvbE
 2f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774551366; x=1775156166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ves6/eFJLAs0HG68Znj+VH4wZtUdDvx4ZnDak47UPW8=;
 b=jVro1JIMsfRdFax71JQuxXodBm6NeLX6S+mGYRfAcr2elJUgfAKZuuSSduub6boE2g
 oC4tU+pzhM7M5gWH04GopPdx7U7/hVRxPx4L8UWpeg/EUBZfGdq1BHD5o+mBSLgJq4m0
 8KuCTzsX1Oc19rMf6fyMMUNI/ytDK+xdVmFRFAEz/KtQqg8ysecrWZC0FYkEEXQWZQhG
 sWP86l5xMPR5/ym4VNBbWHQ0YkL9YbVlZYJHvq2pudxZBTeSqa5KAuO8/JDJORjyDmX9
 XaglvzOmrBAUHIkXQmm8otJxhiLBmEjVLGxtvOQYCdw194HhH5TWMwBUHq68VOmHpFLM
 WAFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUdtBGEkN/gKrSEvnZMWPRHxCUi3CaGMbDsxjK/dpkhiJzkogJB/9kMi5NIPIlIPonLHkQCszm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWhpvj31mIIWrQCFm+KAmqIxKIyZUfruQdLAc0wY5oRHn+CGwq
 5b9mwif9/lQoFZbLvUTmEPB4WayXGKqxoy9nHaRWBY4D84B6VASjhLIF
X-Gm-Gg: ATEYQzwyZ8fTpxARMqNDIzlXyFZKoNkXFCO9wPVc0TkMgVOn9YZBASXnhtHfAqNDoVp
 ox33xGQV5uw+p95GE/56CY/CNYiM4wAXSpCui3658PnPH0B8ylHWz9hPcsux8od0opb8OEh8P7/
 /xW5j5UN4pMB6+djRiBwpa2w+5UBDynKxUQTY4XAUkrEYX1C2Evm26sKMj6cmpnlZzmtn8vlmp3
 XHz929kV2/ZI01IFLw3331jojHZ/rsWeN6jeN7bj1JVnzfZCM7imPF3yZQrbxlvMVHeaSA/VL4w
 ptOJGKtc9ZlUg114JZAL1WY4RleVIjdNX27HmGIbMzHSxduonN0hXzvYxC0ujkc+KKF8W8SW69c
 A+qusR+zK8m/VwQNm/ApamIkAhthtXEREir88clpBFqvCdd98/blFeulsqTSoRSqPjxKJE8IIW0
 wTnG0D2K/84Sha6cvxY5b/dB6zqyk5l1TCAuvynpC0rBaUBYhG
X-Received: by 2002:a05:6820:1506:b0:660:ffcf:42e7 with SMTP id
 006d021491bc7-67dff45c71dmr3869491eaf.30.1774551365754; 
 Thu, 26 Mar 2026 11:56:05 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 586e51a60fabf-41cc7760c08sm3075171fac.4.2026.03.26.11.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 11:56:05 -0700 (PDT)
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
Subject: [PATCH v12 62/69] drm-dyndbg: add DRM_CLASSMAP_USE to the qxl driver
Date: Thu, 26 Mar 2026 12:54:06 -0600
Message-ID: <20260326185413.1205870-63-jim.cromie@gmail.com>
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

The qxl driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 2bbb1168a3ff..73998bb331d9 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -67,6 +67,8 @@ module_param_named(modeset, qxl_modeset, int, 0400);
 MODULE_PARM_DESC(num_heads, "Number of virtual crtcs to expose (default 4)");
 module_param_named(num_heads, qxl_num_crtc, int, 0400);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct drm_driver qxl_driver;
 static struct pci_driver qxl_pci_driver;
 
-- 
2.53.0

