Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F34C3DA61
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jul 2024 07:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A143010E9BC;
	Wed, 17 Jul 2024 07:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJKy8Hmy";
	dkim-atps=neutral
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
 [209.85.166.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B8F10E845;
 Tue, 16 Jul 2024 18:59:23 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id
 ca18e2360f4ac-7f99d50c1a6so8661139f.0; 
 Tue, 16 Jul 2024 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721156362; x=1721761162; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WP6HptfiTdQ0tPqLXKJ5a+6n7jBPHeNyJUhIr64YncM=;
 b=dJKy8HmyoHgzhJiGDOBdbhOrDIgrcJ1n1agOAU5Ibu4wdSFdHvvZ78F7sQJakq5LlC
 0Eo48cmbhwGb/r8xv4lQvyX3pwpMP0tc9l8G+1Kf7HVSvBXGizQ/VxMai03zv6N7RFd/
 FqfMJziSbh9gkfW7thDdOnlvEwaQDJ8ltekdGzuih98rS99PvZ97ygM8DHicgBn5PZiS
 Y8iKcWy4YW9ju9OlayV4z2iXfaURYRCm/piefjpTTkHImXE2sFqmGgfe7U03XOF9FhSQ
 hDI78sUNpg31hL6Kuy1enJ8xsliWz6ubBFGYRdS5TYe1ohrAU8wFFzpmx3fqB7KPcvth
 duLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721156362; x=1721761162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WP6HptfiTdQ0tPqLXKJ5a+6n7jBPHeNyJUhIr64YncM=;
 b=ZV9vmrN15Yhu4bSAFBseHwBKIVL8vK2KT/DAUUytEi5pbr0JW1ro8vxf8/Hhve00ke
 Utmh6l+Z8nrOEh3V/C/lFNn52lvdE+jiECmCnK6AOC4Etv5ZAiLVN2I40Ski6SIfGS2h
 BRz1T7RYc0dUeuIn4UEcx/M3FQGbWatGdqijfoXo9yq86bUwlAhj848ZBIUYYsOKfekh
 vnhp7xLQQhFhCb3jFR/nNqWsB6ZyhEx8wqCbYAg8Z3bhqM023JQ63+J4ZHKmqnHzJn4O
 sklJR1T1k1W5W2viMYWgkvp4AV9BtDgyo+B6ldg/7VysXRWiHMT7m27zD3dERz33okYP
 inUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzUCn5oNb6qSqnahkEYLj3jJt6lLpbuaAPxiej8+TWoek4RZuHUObu5Ff3/n5X1L66L4HUs4eTKQwkoYFzYLT0YLsYo3wPJTFQy1u7Fw3IbSWOtHQ/igdBkpqR/gkRY7ZihaG7WoHiAcMF0bkUTOOA8rDROW/6yQm7FeRkTdpAPx+PFhABl4s/4IvucVz0syUBowz5zGZUSwLFme7NqExVjPCcjDuBPbUk2k6pRQqxi8zXX4g=
X-Gm-Message-State: AOJu0YyqGl3bw7pjZRLv8vghm0CzuKIoE9qbEnq9J7MaK5shong0V/oP
 7cCjHgm7f0kP0JKIpe6OYsD3q2kP9joD7EqDxbNsDIsDMaJNjb2r
X-Google-Smtp-Source: AGHT+IG0qJNgrwAVUIeZbI3iE5ZWAneLU5YeLYaL9upPtNIQr6xsAykXRcCjaAh8RTQq2lp/KAQPhg==
X-Received: by 2002:a05:6602:6019:b0:7fa:b6c1:c35a with SMTP id
 ca18e2360f4ac-816c51c7898mr35514039f.12.1721156362418; 
 Tue, 16 Jul 2024 11:59:22 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 11:59:22 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, jbaron@akamai.com,
 gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org, linux@rasmusvillemoes.dk, joe@perches.com,
 mcgrof@kernel.org, seanpaul@chromium.org, robdclark@gmail.com,
 groeck@google.com, yanivt@google.com, bleung@google.com,
 linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, kernelnewbies@kernelnewbies.org,
 Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 45/54] drm-dyndbg: add DRM_CLASSMAP_USE to vmwgfx
 driver
Date: Tue, 16 Jul 2024 12:57:57 -0600
Message-ID: <20240716185806.1572048-46-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Jul 2024 07:23:11 +0000
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

The vmwgfx driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 823d8d2da17c..fd6cd62608a9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -277,6 +277,8 @@ static int vmw_probe(struct pci_dev *, const struct pci_device_id *);
 static int vmwgfx_pm_notifier(struct notifier_block *nb, unsigned long val,
 			      void *ptr);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 MODULE_PARM_DESC(restrict_iommu, "Try to limit IOMMU usage for TTM pages");
 module_param_named(restrict_iommu, vmw_restrict_iommu, int, 0600);
 MODULE_PARM_DESC(force_coherent, "Force coherent TTM pages");
-- 
2.45.2

