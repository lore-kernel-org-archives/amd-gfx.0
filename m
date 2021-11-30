Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29720C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 16:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C1CB6E4CD;
	Tue, 30 Nov 2021 16:13:28 +0000 (UTC)
Received: from mta-p5.oit.umn.edu (mta-p5.oit.umn.edu [134.84.196.205])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA6FB6EA4D
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 15:04:57 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4J3QVx2nVxz9vpQB
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 15:04:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qEgZpQ4p4_gG for <amd-gfx@lists.freedesktop.org>;
 Tue, 30 Nov 2021 09:04:57 -0600 (CST)
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4J3QVx0mh4z9vpQX
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 09:04:57 -0600 (CST)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4J3QVx0mh4z9vpQX
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4J3QVx0mh4z9vpQX
Received: by mail-pg1-f200.google.com with SMTP id
 z4-20020a656104000000b00321790921fbso10403258pgu.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jkm3SRjlEMuj/OoI/keUI8sb3jpLnQn0wJDEn5YUqIA=;
 b=d+j0Y9bABjd3Q6pxla8ql2DGsgWbafWr4RzOLv5wUlwTydWGasWbCtKgQVgYEpxRze
 ZkOrFvwRyXqFs8SlIFQG02ZNIfmkVuQsPajnCwkD50d56H3GKZE+xYzBsQEfILfRbBLn
 M9O0IVxdg/4py2IrGbEO77kF/AESMA2YYEQ6iiDl/QW3qOf6qQ5Zh2YRZUyz4inrdOcD
 Xf9iNrX4dtooqBoBTrizwztrwu6mVF7qxrhOZxv+vGGBaKMKJ6X0FfldRPNmnTtIhDPD
 g+71UnqUrZpQwgcqkLG3EIKckBhZAa0GEiYKtlYWGLV6UA/Jnr5ZTkSdyxgiY+YXVLA/
 q5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jkm3SRjlEMuj/OoI/keUI8sb3jpLnQn0wJDEn5YUqIA=;
 b=vxgZJYRmGbxT8T4vxHU21KD+2nixh5Ms4hruVsRl7bbZ0D3OjSyNs7hc4ILQwlvZGJ
 FTrhkOUdDHokVhbhtm8+jFaRiM/yjmJKCUYob5eRSokKMipdGJHXPtS5+mdTw8MPtLcq
 AAGcBPtm02w5KbEkdfour+3DyJc/pJ4HpmNbOy6XffMK0iv67WVV5HVl95IPYqdMnXQu
 A6H+gQ+qHcNd82qIqNebAn9haW2lqe4lYuI6r6WTFI/3UhceRPreMEakh2FyeI4QSCiY
 uWg8cthTtY30gqPx1N6qX04ziQU9TMNIzSqySKMdna+pOcJSovd1yl1jIouz/HjeYb/O
 AYKg==
X-Gm-Message-State: AOAM533F6+h1NuvLLqSraYh3NYRdspVYVINVaLI+ar1/rZJje423hxen
 JLAigaKoJ8C772BzJwcNbtsqGP27HUrhl1vjvBuvim3MHzQbfvfuwpWuHRhl6wzK+1+nYLAH8U+
 8wB3+1UaUz6q9QPATRuw0qgB8D/2K4w==
X-Received: by 2002:a17:903:2292:b0:141:e76d:1b16 with SMTP id
 b18-20020a170903229200b00141e76d1b16mr66792818plh.21.1638284696187; 
 Tue, 30 Nov 2021 07:04:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8GWn6nizJsszaZRStEl3f7YTD0lEXqp9tlfH0fC2cLbTGzG/x+jCHUyEelCV+t398xQYrMQ==
X-Received: by 2002:a17:903:2292:b0:141:e76d:1b16 with SMTP id
 b18-20020a170903229200b00141e76d1b16mr66792771plh.21.1638284695794; 
 Tue, 30 Nov 2021 07:04:55 -0800 (PST)
Received: from zqy787-GE5S.lan ([36.7.42.137])
 by smtp.gmail.com with ESMTPSA id y28sm23124794pfa.208.2021.11.30.07.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Nov 2021 07:04:55 -0800 (PST)
From: Zhou Qingyang <zhou1615@umn.edu>
To: zhou1615@umn.edu
Subject: [PATCH] drm/radeon/radeon_kms: Fix a NULL pointer dereference in
 radeon_driver_open_kms()
Date: Tue, 30 Nov 2021 23:04:49 +0800
Message-Id: <20211130150449.166144-1-zhou1615@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 30 Nov 2021 16:13:26 +0000
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kjlu@umn.edu, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In radeon_driver_open_kms(), radeon_vm_bo_add() is assigned to
vm->ib_bo_va and passes and used in radeon_vm_bo_set_addr(). In
radeon_vm_bo_set_addr(), there is a dereference of vm->ib_bo_va,
which could lead to a NULL pointer dereference on failure of
radeon_vm_bo_add().

Fix this bug by adding a check of vm->ib_bo_va.

This bug was found by a static analyzer. The analysis employs
differential checking to identify inconsistent security operations
(e.g., checks or kfrees) between two code paths and confirms that the
inconsistent operations are not recovered in the current function or
the callers, so they constitute bugs.

Note that, as a bug found by static analysis, it can be a false
positive or hard to trigger. Multiple researchers have cross-reviewed
the bug.

Builds with CONFIG_DRM_RADEON=m show no new warnings,
and our static analyzer no longer warns about this code.

Fixes: cc9e67e3d700 ("drm/radeon: fix VM IB handling")
Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_kms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 482fb0ae6cb5..ead015c055fb 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -688,6 +688,13 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 			 * virtual address space */
 			vm->ib_bo_va = radeon_vm_bo_add(rdev, vm,
 							rdev->ring_tmp_bo.bo);
+			if (!vm->ib_bo_va) {
+				r = -ENOMEM;
+				radeon_vm_fini(rdev, vm);
+				kfree(fpriv);
+				goto out_suspend;
+			}
+
 			r = radeon_vm_bo_set_addr(rdev, vm->ib_bo_va,
 						  RADEON_VA_IB_OFFSET,
 						  RADEON_VM_PAGE_READABLE |
-- 
2.25.1

