Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A7CC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 08:46:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B9F10E055;
	Fri, 25 Nov 2022 08:46:30 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E4010E70A
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 07:39:57 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id t1so2799967wmi.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Nov 2022 23:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x2uDBlTkBIecsJ0/pVRgZ1UNVKyp5BR8++/Ee6tOums=;
 b=kpu1wXauOilz8J5X8C4St9E56b95mRasnUl4vlQfR+SLfhQkPcWpca+WeHFuOhMX6q
 i/fppI2mFwu+gCcf8izuX8iSqrLuuAUUE6AVRpe7bn5Q01Tau1lrKiZwzTxbXSJLEPuK
 vSSk0DvyXjs91IxMjPt/gXMgK/PR1b7ICrMzemEy/Hb6nFtfoC/eFMPJMmpliGYQKI4w
 Mq2NZ73RdB4F7UdIUpTq6pvlDiQfaW6pq8YxJWrXictO7fPBbqx4V60oxAgVm8rdMEN5
 dIjvxjnLPINK3pzV4CC8QV2+JJY4D65LbBN0tJpoFGlxuO/uGAJmo51S/HgdEk/q3h3f
 g9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x2uDBlTkBIecsJ0/pVRgZ1UNVKyp5BR8++/Ee6tOums=;
 b=eyAjeLbaOHG0hWdKAcv+nXkNG2rsOTR0iXN+ck9L+sU1yJg4DdkXNGyw8j5xb4ZMEr
 V4+qISHml/v1U5LZ7boTdmQCw+gkasikpXSP3FcZU6luMzXchMLnRk3HpaBsHuRtrWUy
 sMAul2vkXJ1Vi5WQX4/D5pnf1s9wWkbbpmiahLJs0sB0EN18Vd89+W1udxG1pg7itVBE
 egBnB/tqLBJIOl+Ua99lh8szCoWuWVbI/yZ26xzwrFkdDn58ICSx6K7M6+MkpDbzcKjP
 AQOchwY3zyqEyD5/BhXiQ3O1aJVw8p616/IvS/13LqjhZfUX55jPpSOoikWR+Mhc2E0s
 1MmQ==
X-Gm-Message-State: ANoB5pkbMi3grCaQZLf583LhfBOJJ/9BZoEjFPEjUoKxhmIpl6bP/q0o
 SpWwMgQJc5bXtRqp1MNxGv2kBAC3TLQ=
X-Google-Smtp-Source: AA0mqf7AyhvECyDinFaapQedyGVNf0RiHnyQY1A32J0XXVfS85Ijp1ONmn55E/m2R9bigPakliMf2g==
X-Received: by 2002:a05:600c:5406:b0:3d0:21f6:43ec with SMTP id
 he6-20020a05600c540600b003d021f643ecmr15867408wmb.162.1669361995675; 
 Thu, 24 Nov 2022 23:39:55 -0800 (PST)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 h16-20020a05600c315000b003cfb7c02542sm4606184wmo.11.2022.11.24.23.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Nov 2022 23:39:55 -0800 (PST)
Date: Fri, 25 Nov 2022 10:39:49 +0300
From: Dan Carpenter <error27@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Remove unnecessary condition in
 kfd_topology_add_device()
Message-ID: <Y4BxRRU+aiblAj2Y@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Fri, 25 Nov 2022 08:46:27 +0000
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, kernel-janitors@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We re-arranged this code recently so "ret" is always zero at this point.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 6f01ebc8557b..bceb1a5b2518 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2012,10 +2012,9 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 	kfd_debug_print_topology();
 
-	if (!res)
-		kfd_notify_gpu_change(gpu_id, 1);
+	kfd_notify_gpu_change(gpu_id, 1);
 
-	return res;
+	return 0;
 }
 
 /**
-- 
2.35.1

