Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC2FC79F82
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 18:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34C0310ED0C;
	Tue,  8 Sep 2026 18:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GnLpgAAE";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6069C10ED0C
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 18:11:15 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso41768045e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891074; x=1789495874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eo+DR0nSTOR5s+U9wuQddWyA1wNrx5VvbWvWqFL9RNY=;
 b=GnLpgAAEG67YRPNKhoBF/+IyadfMV+2umtaggzUBuL3PmuDKs+YNN2CGFFDlprVA+M
 iZZL5qX2VIHMWKOGM/6vfDxC06+nGZrKtrtS8Z/iqiTCAsxZOK6iJu6V5Wqb2UmfDlIz
 U1kAUy5PLxY41A1rlBOE6lNUrPowIW7vRpHRqh7343AwtzoXnTiZUDyPdOEVHG11Xpxz
 kjg8Fwdop7tkehwjWvRSlief2+mTO40KdcgPImuKxlHF9wioKJz+RLR27IUFy7RE3Y0D
 EfIPhUi7ZBuYnmxGW33DPMpoU79WjyS7R97O8BqF9z5lO3+XnHYoWkzTuRQccoWwXkTg
 AHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891074; x=1789495874;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eo+DR0nSTOR5s+U9wuQddWyA1wNrx5VvbWvWqFL9RNY=;
 b=VHCk+wcQ8Y1W7qnTYQ71LQe5ZBOJMMSrvzp0m341Fz8IikaGHcL6t63u2A5c8d3tDl
 8Aguf0A+4r42p2gvfm5YOtoI9znG5Eyob8SsTob/UyVf1FGCfWiTIEbsD53wP7OBFpNa
 RBF3S5MfbaVBWjdHUvIv4nv7loYdGNv7QnxdXVxP9oPsiZnsku2tVrlHrvx4PqCAlcwD
 HIx2RSULk1OtlePq6KR9L0Escz2WVqQI6kwFTSeIzmeUHhbbg5VEquFESB4mizX7gHup
 tFaVg/gHSdX757TJsq7Cx7KGeQ5aBb9aHQnvYDVvI68bLZA617BlSHJdS4iqZqfy54LV
 uwxw==
X-Gm-Message-State: AFuF++lopw9l6/BdhdMsk49fXI9A3QpbMDhI67xPpHOt6lB6f1YgGZ2d
 qy2hDc2Ej6+IpTrhn6uOM07iqw3m9AVS2+NwMV7o0v0gHYcV9BtKt56Le2FgrVfO
X-Gm-Gg: AYBFou3y+y1TjW92aukGkBVTHRIx7FZ70KQ3NTH1iRchP6DDuupBH4lDITA4h46lAik
 Srp+FpggPgsRlEt1uKOYafg6d7kmXZl+WixoWrs7RB5mpIBkclKlJUCDi305H3puvngpltdnI/e
 DAmasV4VIjXikq6OPiKfTg/MIn9XCMEjy9zxE0JiBzFwg8J9EMSXLtMNv3Cpscc6oIxAEtPprP5
 bMfbt3MCmIA0EuZU4GJGnlWBQ2LBObsBF05QfHj4HeXrTmxyTxoCEkGe/b3jiMg0d0mAjvQOHLt
 +DPwH9RVGjCVqlt42VexOW9dKVHdOb8ZNgFvIURFXeYQYqELQDBR7WA7oYnPR9+8plyE6xlEdr1
 pQlNZ8CT5l2yxDpwXNOKSKiAjcGynRo5q0oiyz7vnmt+tJ9zHpug6dPDqNigSVgc7kWn2XoaW+a
 Fnms81e5a7RXKzuW78oexI8nBHszKdcUJRtEC2uhI6Fl/BtBDEUnMIOSoXjYMgffkZ9bwE3f4te
 whDPFGwc8P2oF5O6aKzTnGcxxZ/LIE=
X-Received: by 2002:a05:600c:4515:b0:49c:c0d4:53d9 with SMTP id
 5b1f17b1804b1-49cf8273002mr299266095e9.14.1788891073749; 
 Tue, 08 Sep 2026 11:11:13 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e4e4sm5190125e9.2.2026.09.08.11.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:11:13 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/9] drm/amdgpu/sdma: Clear SDMA rings after reset before
 starting them
Date: Tue,  8 Sep 2026 20:10:49 +0200
Message-ID: <20260908181052.381126-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908181052.381126-1-timur.kristof@gmail.com>
References: <20260908181052.381126-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

The ring contains commands that were emitted before the reset.
These need to be cleared to make sure the HW doesn't execute
them, because they are garbage at this point.

Note that the ring reset helpers will re-emit the commands
that are necessary after the reset.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fbac732f3e01..3495b7553950 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -593,6 +593,11 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		goto exit;
 	}
 
+	amdgpu_ring_clear_ring_and_ptrs(gfx_ring);
+
+	if (adev->sdma.has_page_queue)
+		amdgpu_ring_clear_ring_and_ptrs(page_ring);
+
 	if (sdma_instance->funcs->start_kernel_queue) {
 		sdma_instance->funcs->start_kernel_queue(gfx_ring);
 		if (adev->sdma.has_page_queue)
-- 
2.55.0

