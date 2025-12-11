Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28874D41C12
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Dec 2025 09:47:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73BA410E7BE;
	Thu, 11 Dec 2025 09:47:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ih8cHupn";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC07610E7B8
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 08:59:33 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so3712525e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Dec 2025 00:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765443572; x=1766048372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d7Dcmeo17/ho3pwIJKnx+P3oKTwjiCKC8M+QuOO4Bzs=;
 b=ih8cHupn/Lci18bE92Oae1ZW9nhHdgCuXoDfE0ZRw8mQpMjZWzs30Sp/NgP9H11t3S
 soGcvfIv1oDFyeS1yG4H5YpBedq/ixvnV5IxwVumBa5l8JUpenapNVkKN5XTPKo94eWS
 8DrWgt3Blk6yvalEROgo4/VpUvQ1ELMXrdLMhFj8Co2v+ORVSApdzX7ihmJOZxd10rE9
 otYTHv//dcsvobGdRtCb0iy4G0FsA4VK9CJdTOBirwuFIYPq1FLbykcIbwgPqOuSaFmu
 LPVlRFpE3Ccao2bhKU9434Iaxn1hwxwVSsmlFxHcIe3kwl/kgL2vgj9srARz/rYYj8w7
 mqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765443572; x=1766048372;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d7Dcmeo17/ho3pwIJKnx+P3oKTwjiCKC8M+QuOO4Bzs=;
 b=jODxXtYbuYfJXr6ngxI5Z2yGblg9tcH9lKJFFmhX4Hzju16jXnEBGRFJrhNsXFlXkV
 Ivfp2YuMg3GEnxZI8o24RLWAdcKIFownX7b3n4GpzSfSd6sFyNQSXd7ela0Eg/p0ia6e
 xVIsTNf91yO1fdUo+Ri8iC3D+gnl42nsx2JkxG4ZDlOAtEwdwj6hB61+acKHJ1dX7s4q
 IJDtuzFla7hFc+pCQATeRKJxqkFIBPdRUCh6d955Rsxs/MjiKAcSCfNhE6bhAFXbeS55
 pd4Ihn++SuFlONvEsHl1b55ykzXUjpWOth9sALNjSrXHeqROqkH7i96ZdSjPblfW1yXc
 TAvg==
X-Gm-Message-State: AOJu0Yw2PsvtVSd0HpjuSxMcn4/iaiv3fOxDau4LtpS6wMyOp1MXTOCR
 DQlZK9MQ4aUSb2VSk6s8QGScmNaP3yny3Y1yQPnUGjX+0ga3hKnraQP3
X-Gm-Gg: AY/fxX5VCg+dOBnQedPKaJaeuNd5zqYwMtwosElxJ4g4D8k6Wncd7lWd4hxv8GVMk0V
 zYtEcN9aD5T2SpXFiBqLfRTdxQe8EsvwertrbBhr2Y1a8DkNc8lTMMp3mU+MTrLbyANzVcrAi9f
 0g9d7vQDM86olKpe0w1xMXWb3/a98Iq467gEbhTSs9jE17qAlGuX5BaansSfwnXZqToepvAAbvE
 HfB6JpHfbmxpLj9eH9sWdBR5+oyoOxxSz88pHNd0Idyw1vtSHlhth+gLPstg0mr89hWwdjeKPCw
 sH5VdfInWOMJVtqsE8c7kSQwGC4htzhZqal7BzXO1mbWUzB8MX8VXejOQdxcH8boueZXv7rCjHr
 WrI3WZQeG2imXBlv2t53wxBklY1ozFx7t3NtLWlkIyjG9gTwR1Cjmrz0nRXTx9SyZe9oqGtMolH
 zt/3zqTQ==
X-Google-Smtp-Source: AGHT+IFfevukgFnWT3LKBWertJrehx/v0qPaRwBDg4O1Pd1KYzneq0UfgHhekRMu8pvpp3JFeKvIGQ==
X-Received: by 2002:a05:600c:354a:b0:477:97c7:9be7 with SMTP id
 5b1f17b1804b1-47a837fcbb4mr55532325e9.1.1765443572110; 
 Thu, 11 Dec 2025 00:59:32 -0800 (PST)
Received: from pc.. ([105.163.2.215]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89ed6c64sm8683195e9.12.2025.12.11.00.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:59:31 -0800 (PST)
From: Erick Karanja <karanja99erick@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] drm/radeon : Use devm_i2c_add_adapter instead of
 i2c_add_adapter
Date: Thu, 11 Dec 2025 11:59:23 +0300
Message-ID: <20251211085923.737742-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Dec 2025 09:47:12 +0000
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

Replace i2c_add_adapter() with devm_i2c_add_adapter() and remove all
associated cleanup, as devm_i2c_add_adapter() handles adapter teardown
automatically.

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_i2c.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_i2c.c b/drivers/gpu/drm/radeon/radeon_i2c.c
index 1f16619ed06e..f3ba4187092c 100644
--- a/drivers/gpu/drm/radeon/radeon_i2c.c
+++ b/drivers/gpu/drm/radeon/radeon_i2c.c
@@ -931,7 +931,7 @@ struct radeon_i2c_chan *radeon_i2c_create(struct drm_device *dev,
 		snprintf(i2c->adapter.name, sizeof(i2c->adapter.name),
 			 "Radeon i2c hw bus %s", name);
 		i2c->adapter.algo = &radeon_i2c_algo;
-		ret = i2c_add_adapter(&i2c->adapter);
+		ret = devm_i2c_add_adapter(dev->dev, &i2c->adapter);
 		if (ret)
 			goto out_free;
 	} else if (rec->hw_capable &&
@@ -972,15 +972,6 @@ struct radeon_i2c_chan *radeon_i2c_create(struct drm_device *dev,
 
 }
 
-void radeon_i2c_destroy(struct radeon_i2c_chan *i2c)
-{
-	if (!i2c)
-		return;
-	WARN_ON(i2c->has_aux);
-	i2c_del_adapter(&i2c->adapter);
-	kfree(i2c);
-}
-
 /* Add the default buses */
 void radeon_i2c_init(struct radeon_device *rdev)
 {
@@ -999,10 +990,8 @@ void radeon_i2c_fini(struct radeon_device *rdev)
 	int i;
 
 	for (i = 0; i < RADEON_MAX_I2C_BUS; i++) {
-		if (rdev->i2c_bus[i]) {
-			radeon_i2c_destroy(rdev->i2c_bus[i]);
+		if (rdev->i2c_bus[i])
 			rdev->i2c_bus[i] = NULL;
-		}
 	}
 }
 
-- 
2.43.0

