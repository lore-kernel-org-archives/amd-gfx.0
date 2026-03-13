Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24445107BCCD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B6610EC82;
	Fri, 13 Mar 2026 16:51:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m2M9ZwD8";
	dkim-atps=neutral
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC02310EC1F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:24:31 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id
 5614622812f47-4671cbce32bso548592b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408271; x=1774013071; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6v3HiIDRukL8wqePVR5l3Bo2Gj7Iv9DgR3CyiTeT7DE=;
 b=m2M9ZwD8aCUQtZGu7iVH6hWRTABvTAlsoDXTyuJ7V2AahorDA73SlA/GShhM01BBaR
 mMMrVw2bippTj04HCqWBNB9kzvLdR85tnQiU40PU/c+cVWzj+RYTipaghy+dLDZV2Lin
 nAls1bqx9PNdfIjdU0yKzrjZxSY7kP6aij2aWNc6Gu/fdb3Wv9vw1IxPttWY0FkrcJHu
 HvUzOY5LX76fCN9j6NGDFFpDmKLMxd/JR+PHGjnTWhvr7bLWsvB+ewvyLkxQ4AiAIlCm
 l05EIJv7hPaW9ibVMHNDV4IK5+lmmgk7CWZkooQEIe20bsHDUsIK2Gzc+LjWG9vHZVWz
 lCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408271; x=1774013071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6v3HiIDRukL8wqePVR5l3Bo2Gj7Iv9DgR3CyiTeT7DE=;
 b=i2/rjhS4hUgjPxIgRApuJy/YywhwLk+3huo5u+V6dUt0lUfkynJzmu5D2RorI0NTR6
 r+LvP+Xzqhy5WJnHDAosscOtLzCHcaCLagG61DBW5q7A5cP66VgJdwLFdIacdLjnp3iP
 nYFvoaBPv1Kw+FarutIcyT0rLtSX4cKLwUiMuzE8UuiPZktxg+0MFcw5QnD1TTtH0Wiq
 d6AdoHCHsqS2VaKYTBd+aO2xyiMVTBlQ5TKWjNvorltHFqfzTjqWb9pBAsgBD9Leh1v+
 RmkWbeEZvU61JVzPy9/Ip7GdSlhwuwTUNzdUYbraFbUFfFoeYalB1zwMxJroYS3/2Fbl
 v9BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGEbegjmZP338vigCDV8Bpx+2lRWuOsfSX56Vft41/i1x19aVochDR/85ZiXEYUGb7isGjWvvp@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2SO6e5lzq/uASSITdseBm0EF1TTjJIy5m273IVbRBmCumuoQq
 m2pof5hJaW7hTn9yu0LoYosZVqx9D+fcpjLW225TVCayP3GR4T7oyL4A
X-Gm-Gg: ATEYQzwU9TT/XlZEiUpHdd03TCsBRYa+EFf2t9RGcnuv3krtOjqX1LfW9r03w+1ekM0
 U2HSDGIgboQFLTb3SeaqrCNhLtKjFxm6dbCpVDmzxMU6TEHvUrovBiDSQ7NPozs+oYBS+bnUwAL
 J3GDOcE8eO9x1vJ0RCehvA44XPiiG760ZnGU96MnC8mGToK6BQwMQexOKYabrbidOKgpu8cV3N1
 w5GYUfi5iabLmpKik75Y3V+67O+K/y6mKWtLZd8xzIdEqaNYnDV7xybJ3PhFxAtcVXgmd5PJ46Y
 8RoawEr/saNRXVEdGJjxJg/8iJS86WO3721YaYbjK/NGJwBL8JDgThcp0kCXk77LpTe/hDRkU6x
 L3qRTROT3d+cgZZwaQNvTPOiIAOWx8IA2uWrV6xrKlUj2M8GSyIWoM71o9b74KURvHiTa+CXR3r
 8AmZMA9YvISElSTAvJze3SkaPxsqAL7nH2mIgr5xmgPhDyeAFo
X-Received: by 2002:a05:6808:1203:b0:467:32c1:acf1 with SMTP id
 5614622812f47-467572f2d47mr1467910b6e.39.1773408270898; 
 Fri, 13 Mar 2026 06:24:30 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:24:30 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 44/65] drm-dyndbg: add DRM_CLASSMAP_USE to Xe driver
Date: Fri, 13 Mar 2026 07:20:09 -0600
Message-ID: <20260313132103.2529746-45-jim.cromie@gmail.com>
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

Invoke DRM_CLASSMAP_USE from xe_drm_client.c.  When built with
CONFIG_DRM_USE_DYNAMIC_DEBUG=y, this tells dydnbg that Xe has
drm.debug callsites.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/xe/xe_drm_client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index 84b66147bf49..3af476f0449f 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -21,6 +21,8 @@
 #include "xe_pm.h"
 #include "xe_trace.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /**
  * DOC: DRM Client usage stats
  *
-- 
2.53.0

