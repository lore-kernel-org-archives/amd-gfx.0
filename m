Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32A8CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A30D10E541;
	Tue,  4 Nov 2025 08:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kluwrNpM";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5E310E201
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 18:08:17 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-b98e6ff90cbso1545451a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 10:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762193297; x=1762798097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Frfwa345H88CrVWdtRCwdX7IPCmH70e3211AOFpaNfs=;
 b=kluwrNpMoeG1nbZwM2WQkewnLOk3qOdirjuoih6ZszaZ3V7yDBLJn+Fxfbzo/09NST
 EuXRiEcHr7fz+6Zc18pE+Y/s+IXHHdfTJGHXGNbneB7GS0dfUFuH/X5YhhSexRtAl4Yf
 LEX2w0DKHjxT+e+tE3npvC2qlQFtcfme+dK1kmDByG0QhB4myjVb7xTtvrq3XOqSgHOC
 HFaTssFU7kpu+18IeAyKua/eNCdAdfEdDtpaT6XAfLtzA9P3lJcgGGiAoxevnF6zhvFc
 8m1Hbm9FqHfhGUW/91x4R76CHE7/TVHGe87vudvGzNIoctv+DOByid5JHy6Oj8IihjUu
 C16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762193297; x=1762798097;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Frfwa345H88CrVWdtRCwdX7IPCmH70e3211AOFpaNfs=;
 b=dZwYhdMk4dP5rFHR3RzREkT8h5N0NXlmHgkL9UYHEEFn1kfXYbUTGOpaftwMUYha5N
 S/t6YCehWGsflQ2GWJGjSjcMGLjD5TGE0tWJOpfdJLoeK/fha9mxfJSrwwNz6D7j3jCT
 rSsNdAXDhqz3OJQq8htFEF1KRXGuBF3T3B4BQ5VWqGTWC3XLft0F1qdIai36cEuKOc2c
 fyJif1AHhsNrcYIYYORgLeQDO6VEi1BUci1uzsIwFSBhcRCgcZK1rpq3S7OkkVKHufVR
 lQnbmuPKojYY6jTd9So0rYRu/M9mm3hNwWLBV830K3oBs//LT4vAr4867/7TzHMCuflJ
 iVuA==
X-Gm-Message-State: AOJu0Yy5fh/+gWaHprRlWi5ETFvco5OQSaw9EqcMA7JRRM2Yyy+6iJx0
 9zj9r6oitAJxc8IUNg6J6JLY2gDflYhHWdX62Pq7C9UfQ9QJnqcPr1Mg
X-Gm-Gg: ASbGnctlIksV/YbePsDPu6titxo/mjEofju+jFdToDaT4DNpIC4jDxpOfDuDUmCg7om
 /9i0uNG7Le9ikIb8J1AB1PpkeYXN1qzao/npo/hnl9N7XLazv8O2CTKAn5OSWlm4zyEgJoTtzfJ
 iJSN7t8Orv6Dy/x7iZn1ghCOJPfL0FX3WHEzmYWESOxhvfo7U61RwieOYii+kDkjfDCbqHCknCX
 W+/DECOu3I86oHlK3kBy22TO06vsmezwPKh4ZmtGSH3ujraYh33qH+5ofDH8D08t7b5c70TgJY+
 uOzs0xMhvjPSt6TrOm96bZGoGdfcAjrs0fhrU2cf6zI/Ym31P/As2/yejsER6PK2ANxg+ztN989
 rx9ylN9DbdtiaMwNjhOA6B2ILnFNIG4aWar07/5DJeQx09LB2hFh9lCmcBK4OaNziGCFfdpbEr9
 vbDnYsVoHV3XNq2krOJNVWiIdWfg==
X-Google-Smtp-Source: AGHT+IHGntG1Sm02Nexg5ky/LahI7hng6h4/EiKDnICJQxmXLYfqJK7C95190g2OAfp3VipnLPLSww==
X-Received: by 2002:a17:903:24f:b0:295:24c3:8b49 with SMTP id
 d9443c01a7336-29524c38fcdmr163866155ad.46.1762193297223; 
 Mon, 03 Nov 2025 10:08:17 -0800 (PST)
Received: from yjshouse-pc.. ([2401:7400:c804:fff5:49a8:2576:bfa8:b373])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-295357a1851sm115236505ad.27.2025.11.03.10.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 10:08:16 -0800 (PST)
From: Yong Jie Wong <yjwong92@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
	Yong Jie Wong <yjwong92@gmail.com>
Subject: [PATCH] drm/amdgpu/vcn: Fix sysfs cleanup in vcn_v4_0_5_sw_fini
Date: Tue,  4 Nov 2025 02:07:43 +0800
Message-ID: <20251103180743.265023-1-yjwong92@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Nov 2025 08:30:34 +0000
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

Add missing amdgpu_vcn_sysfs_reset_mask_fini() call to properly clean
up the vcn_reset_mask sysfs file during driver unload. Without this
cleanup, subsequent driver reloads fail with "sysfs: cannot create
duplicate filename" errors.

The vcn_v4_0_5 driver creates the vcn_reset_mask sysfs file in
vcn_v4_0_5_sw_init() via amdgpu_vcn_sysfs_reset_mask_init(), but was
missing the corresponding amdgpu_vcn_sysfs_reset_mask_fini() call in
vcn_v4_0_5_sw_fini(). This left the sysfs file orphaned after driver
unload, causing -EEXIST errors on reload.

Error without fix:
  sysfs: cannot create duplicate filename '/devices/.../vcn_reset_mask'
  amdgpu_vcn_sysfs_reset_mask_init+0x2c/0x40 [amdgpu]
  vcn_v4_0_5_sw_init+0x2d6/0x480 [amdgpu]
  [drm:amdgpu_device_ip_init [amdgpu]] *ERROR* sw_init of IP block
  <vcn_v4_0_5> failed -17

Signed-off-by: Yong Jie Wong <yjwong92@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index b107ee80e4728..cd26d45845322 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -269,9 +269,12 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 		r = amdgpu_vcn_suspend(adev, i);
 		if (r)
 			return r;
+	}
+
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
 
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
 		amdgpu_vcn_sw_fini(adev, i);
-	}
 
 	return 0;
 }
-- 
2.43.0

