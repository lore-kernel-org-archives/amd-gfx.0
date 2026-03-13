Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A91107BCCD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 16:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036E410ECBF;
	Fri, 13 Mar 2026 16:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lX6evrPp";
	dkim-atps=neutral
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093D910EC24
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 13:25:06 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-46703fb602fso907334b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 06:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773408305; x=1774013105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FB+tfLWkD+EbK14YUmCdfR6TCrKrYU/mryJ+Tht/PKw=;
 b=lX6evrPpLbTkpimTR3Ca+L1AVrOsppWbLU33iifFbe9ZLJlcAYAHh1HoiHFF5ZhH+V
 JxkMmOdasgqY8R7PXnVycpkpVVYuplg8oyY/OwcYKqiC7aWLbqH+ai4Tw2tLNt55w3A4
 IRaHN/XMmHiFF2Cn5oyQ98qSeQIGEAeu2slFv/RrflY4FzAEGp27W2+8HiLQsK4UDWPJ
 BbVPSs9e8hG9mKgKcSzD9kF6OcZWAIYtOQcrEIyybfcIMi45e5re0zNSubDL6t9bEzkC
 1+LvGqQLCpu2m7n8ahGcjWRW6KYVt6jyNlFb31ajN8nOzoLbs/chhBCRA7au26D1AQkx
 FNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773408305; x=1774013105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FB+tfLWkD+EbK14YUmCdfR6TCrKrYU/mryJ+Tht/PKw=;
 b=dtiwsx4nZR8SDPSAYMupvax9seIRuvuor0gYi9+x5MjNDTG3man5kxRm8AFuKVEvaC
 phjdNTP69Mgkz4r48BxyNtXg4xbQoMpVGRgp9wyHAbyINctuMdyvDulxMSU2/KwTpDrv
 odRECWAFSd+rQceWK1HsM7q8kesx2ncFwx4gZwx1qc6lxgKo7CDjzKfux61dccnuVwBF
 uJsRT7Dp5W+67GIbWX2ttzZSDkP+Vq+aRlaizswexseyz7jA8JKFJ8udc8kG6RDNRurR
 A/6RgSmqqCy/QtWXIJBVH7gpJN1dH03FYbKS8l5cu9TZbUvkDZCEXS6Bms9uwLD3zV8H
 YbaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHGLBth5OJVaYCRPW2I6KIGUioBreIFP7K8vzwGutE5b/A3+9igfcq4g4lZS2C6X9a6hQFI2/r@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxG8kAZukFtE8hI8yheJc+Zl03QKKEsBH7kRfNBkdyLoYQXFIc+
 7HWUnXwN+jH17aKEd/5vT5XJNHeBgGNlR1K6Br1PFWdCMpIqnNvkvElk
X-Gm-Gg: ATEYQzzmiXkTATXAzmTymIo6EXbsabXWXd09HWkRKFfby5qUa7+Cy0bmbTilNU++T9T
 nbA9q9Sj3u76FwsdvTV4iOtGcI2fKCigdWzad1UQZyfPiNszMdurIHbY4Go7Hdcw0QNwFcynAxu
 UeTIuAPG4Ql6+OcgtF5TKTe2zDg92V492E5svEeg/MtxPtGKtF/odrUU79oh5hpsJ3KF0QQl44v
 JFeb1OLrMWSL1iY4bqyUdL1UZAbYzVFxKZaLMtL8i0D3sbXv+muYD4JYSLN6rOiWaLj96SIjqs/
 /J25ZLIOpHjz8X/3NeYs6/ksdyiKj1kN3NKa2m7tFhtm7XPrB6P9OHoxeMNxAOFJfoHsJ/NxtXN
 49RkefiID/Y7+ZHVSWvnax7c+e5c2qqG+B7rc9rn0duHC9SNoXdT0+HHQ0jonwrhTYE1nsRVrvh
 rrN/sxtSNnoMEFKiaQSCOypHcASRGvOTU8kVlq1X1rm5PRzZKg
X-Received: by 2002:a05:6808:1187:b0:467:3f4:907d with SMTP id
 5614622812f47-467575812d0mr1643061b6e.56.1773408305157; 
 Fri, 13 Mar 2026 06:25:05 -0700 (PDT)
Received: from frodo (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 5614622812f47-4673434a35csm4795987b6e.20.2026.03.13.06.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 06:25:04 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com,
 gregkh@linuxfoundation.org, Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jim Cromie <jim.cromie@gmail.com>, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, christian.koenig@amd.com,
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com,
 louis.chauvet@bootlin.com, skhan@linuxfoundation.org, pmladek@suse.com,
 ukaszb@chromium.org, intel-gfx@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH v11 62/65] accel/rocket: enable drm.debug control
Date: Fri, 13 Mar 2026 07:20:27 -0600
Message-ID: <20260313132103.2529746-63-jim.cromie@gmail.com>
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

