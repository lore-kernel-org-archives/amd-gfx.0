Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA636C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 08:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D06D10FAB5;
	Mon, 15 Apr 2024 08:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="fz6VLLod";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF1AB10E795
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Apr 2024 23:39:38 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-56c5d05128dso2496322a12.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Apr 2024 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713137977; x=1713742777;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QT+4H6LMJlz+8DH7pQ8tCzWtRow/zNF+rdLqCVP9iDo=;
 b=fz6VLLodRvtrWGC2zn7YaIEBPFK92Ux/4ojP+dlOhmT102DUgwjixxhbzD/d+m2J7a
 mppX0Txv/UuDQ5DwisWHOXSo6HTn5bJql9e8zbzvAeRlch5hieo2Ai0aMNKnFBGH/Abb
 +edrYpPmY1R7OGzBE3tICLC2e4C6Yu+PA7XGE51rSjreOrhPSj+A8/4TJLaCKi5rzOnq
 D1ufCw12Z91IRnNQw1vN+6N0tBKJPx4ktRBoSYqGd1d+iSB8Evwc1USYtzYFgtxondDK
 U2eLe+Nt/3d/jbNA2pW5bu8IL/8ZHm2eMhesYNIhH9jQVUzBuUOhFpBWwsgAo9MaqDvN
 h0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713137977; x=1713742777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QT+4H6LMJlz+8DH7pQ8tCzWtRow/zNF+rdLqCVP9iDo=;
 b=N+PrEtJuRTtxikoCz9i868FYmjpYMfL9wpVq5/rvs4xJ972G6ndWPAz4kMVCqW6fyq
 pVfhrJbIQGCUvmIdlO5NWIuuiPrxgc+mQKM/rHDoMG+8jCUicNWxOWHpeyLv76fto7dM
 kXd2pDrkpwWUpNisvwCk5hVsWrMjg0EFUJ2F9G8L5PZtiBNUo/13ANpmXWHpSrCM3+Ot
 JkuzQxoCYvZCuR5BewNO8FBczjgu1dll8ewdRJ2xoYnm7MiZbmWKxeAP2gWBQM4b+Hmv
 dlmVEDpVybi0DIF/YfGy2TzNc0PdUCmZjZQZuX5Y66oV/yydRpRmemtlQs9eFW08y/we
 Tjrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlqPSIW51gJScLe4d1IQqLQ8aFqkqbu/qHvYwvirn7U6FqCWucFa98DHW+RcC/wx0c0PwowzKf2MqRrZUFfZdcjBLBRpHqk1IGpsfOVA==
X-Gm-Message-State: AOJu0YyIVqGsOCNM55ZqM7VUuoxUgBZIpvtrxThzKvRnJeNcGMsqBbJR
 ulpNsE+VueQROZb0JXxy0OCQ+0AHOFtQajPECehM1+0xwRr5P64yisyVo6reFlg=
X-Google-Smtp-Source: AGHT+IFb2HPMbxbzo+Z0wMa+oIFoQ5KEgnlxWzihlJ20RFpTeq9w5TDvQeaOwMubtpEelzwV72ysew==
X-Received: by 2002:a50:d7d6:0:b0:56e:e76:6478 with SMTP id
 m22-20020a50d7d6000000b0056e0e766478mr5380764edj.31.1713137976751; 
 Sun, 14 Apr 2024 16:39:36 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-212.dynamic.mnet-online.de.
 [82.135.80.212]) by smtp.gmail.com with ESMTPSA id
 d24-20020a056402401800b0057009a23d4dsm2495701eda.95.2024.04.14.16.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Apr 2024 16:39:36 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] drm/amdgpu: Add missing space to DRM_WARN() message
Date: Mon, 15 Apr 2024 01:38:39 +0200
Message-Id: <20240414233838.359190-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Apr 2024 08:40:08 +0000
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

s/,please/, please/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7753a2e64d41..3cba0e196ca8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1455,7 +1455,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	/* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
 	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
-		DRM_WARN("System can't access extended configuration space,please check!!\n");
+		DRM_WARN("System can't access extended configuration space, please check!!\n");
 
 	/* skip if the bios has already enabled large BAR */
 	if (adev->gmc.real_vram_size &&
-- 
2.39.2

