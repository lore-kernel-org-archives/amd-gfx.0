Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE816D5C0D1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 08:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3D510E73D;
	Tue, 16 Dec 2025 08:07:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KtRBnVrU";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3184410E42A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 11:52:50 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-477b91680f8so33850465e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 03:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765799569; x=1766404369; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HLPAAzkZX672SPFPNzY//QzztDCRnjOssmaLt2g73S0=;
 b=KtRBnVrUiolzEiUfoJ0yw5m6MWBa24sxBkcLhctvZgVXoBcJL3n3u3FhR+Uh/Eujz9
 hTJAot37AvNQ20pf4tGgEAL59a8fjwXmUqhqmFXVR309MKIL0xXk7Z7nxvAKlzRSieXK
 ys5/obnNGU0OOVFLAcbAwhOhPHpnkqh17zW634+mbO5wdqvXNSiObByJhCYWKndkHQn0
 2tvPXWsSq/u/YB3yizgn0xatQDBRZCMx0gjA+m8jv9l0W46to/lpX8QF495y6CKUa99m
 kzExNw6ueZ0dOUOTAKc1bPXmdx3fg3IJGYbP2InTcs946N22/x23sxF/lgWpNVbPOhmX
 KzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765799569; x=1766404369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLPAAzkZX672SPFPNzY//QzztDCRnjOssmaLt2g73S0=;
 b=b3/w3oLdpLf2p0A5A0dglHpBaF2jNCvM/o3rZ4BvzaLXkZ6Aztzx3gDw4fVbu2cF+s
 J0PIr1WUunE9+Zq5fFU9UP0YMM97QWEAvfCsrauiFgo4i4rPSayomIojeiIaThKyvg4l
 cqjI3uedpgfLrMeayX4d3UtNNBRvoVIu1rZY+/TccSnqidBkBg1Ms6e7scG1lzNF55cg
 QNShpz7wi6yLEDdIfiR16OYcAhLVZ/k6lDIM8vyxylAwSM7T7sQrIhv0SK25XYa0XSAI
 pOJUvRbli7Ldr6yORweP8P0R6EZbM9LIN0S7qYwIJZlLGO+04bYyJfQ1Wfj7OO3Jm7QS
 ICYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMC8iPjzZhhh2ISwZXDA2Ks/Ggk+aWbCNYpLHan1bK4ibqZpar+qFV8nltKCEOir4dBDF5dcLd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlTFpZUohhYrOyXnCG4zL9oZ7pdF724XXVk8UtmQs1XXi48qU+
 nmY1UyDeSxk6vbhaweA8c/LFbJ9JDDivCDCB5ZpsURW+u+oaIS1U7QdX
X-Gm-Gg: AY/fxX7xHokjppZUy5rlkWK2VnIoeyVkGZdBMncm0wZFqmFg6WFFS0ON0HM6/AOxvb9
 xlCtxGla7ZKlVSiIeZ70rQqXwRif8u7TEKgJZbdhIeYkQYfaQbQPFueNsC2Pv9gVhDRaPDf1Ghj
 EgiSCmCMUOssN6FfiTv97pl66CVKsq7X+MRk7NzFMO2FkuC2exSntWR4qrxDfoVrtBrXeB/MWBs
 /ctzEG9Gc4Pw3Qblm3eRL7UIkE+als2r4Bb3sByGgKCfn8dhaoFpAAL9ALQia0acN5qKK7re/FU
 3vTwMZCLN4PSETC8sXZuSBHeqg1WV4cVfssaN6ms8kkXHAl5SwawFUak2gnasS5cKazocI2U6g5
 iwIZFFm2bLjZg/BtNqMHaU0KMZ5qQbhdsmQ5XQJgaRwXniRFjwsVVXKJiN7hWhQe8kPJgcXcI3h
 lD8oB3LpCySw==
X-Google-Smtp-Source: AGHT+IE7KWwtiusfSz6ItVQJ6jWC1LkkJEmabme0vGMp/wCpVgK/njPeo+/ZPD4RDxUphEA/jNlIVw==
X-Received: by 2002:a05:600c:4f84:b0:475:dd89:acb with SMTP id
 5b1f17b1804b1-47a8f904528mr113128355e9.22.1765799568419; 
 Mon, 15 Dec 2025 03:52:48 -0800 (PST)
Received: from localhost ([87.254.0.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fbc6e3392sm17181159f8f.13.2025.12.15.03.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 03:52:48 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Fix a couple of spelling mistakes
Date: Mon, 15 Dec 2025 11:51:50 +0000
Message-ID: <20251215115150.3581277-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Dec 2025 08:07:42 +0000
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

There are a couple of spelling mistakes, one in a pr_warn message
and one in a seq_printf message. Fix these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c               | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 2f66ebb5b029..adffa44fff2c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -830,7 +830,7 @@ int kfd_create_process_sysfs(struct kfd_process *process)
 	int ret;
 
 	if (process->kobj) {
-		pr_warn("kobject already exsists for the kfd_process\n");
+		pr_warn("kobject already exists for the kfd_process\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 5f8cda4733f9..d7d37f01f51c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1115,7 +1115,7 @@ int pqm_debugfs_mqds(struct seq_file *m, void *data)
 				break;
 			default:
 				seq_printf(m,
-				"  Qeueu node with bad user queue type %d on device %x\n",
+				"  Queue node with bad user queue type %d on device %x\n",
 					   q->properties.type, q->device->id);
 				continue;
 			}
-- 
2.51.0

