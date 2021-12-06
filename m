Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268EEC433FE
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 10:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53DDB7AADB;
	Mon,  6 Dec 2021 10:22:40 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E5672DA1
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 08:45:54 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id c4so20762435wrd.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Dec 2021 00:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mGaHUn15eIzVYKnbxdDiP7ntjOxj8jf1lnHOHUmn1F8=;
 b=JFVt4N8+fK5t5R+ZvIcRff5m7UbB/pzMnT/sombHXqIt03InCnxJXpS2c+rgK+tMlO
 VcmejRgQtiJ7E33Dkp6Jcy3veX84qhrt9nocYFd0ivBNXJMnLXWvPDsGnE/r24pz6kH4
 H86wXqf5yJeK0MU8VH5KMBiV+Eh9GdfuPNv6QuYJo/34/VdJd2Pc9grhlBtVNOofQ0eY
 zjdyNm3ybK9yxGlDtg6O72wRdym6Ud0VVnrL5Y753gx8kQS6MkyHi5sWEnulub9/SOtp
 8LOzqZOTOyP0AoDRrdT+Cb8NV6b3s/zC5zITqncZ5zrx3VrbIo2un4+SY7KeZe68quO7
 12ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mGaHUn15eIzVYKnbxdDiP7ntjOxj8jf1lnHOHUmn1F8=;
 b=RGhy1WgCy2bwPUaMAWwuiAvFpY9ZpVGMzXt43U/3BrQzhdN9jo6xI02V6F2zO9xzfU
 BJ5C+AseUdJTf41yR7X7eUnUSUZNPr7HUYpMs0OlV/1K0sNc18urcP+AAxMMFPrEaiQ3
 Dk28sM9nUCE9SM/UDrlR3Qzlgl3LNjZrmkzBhJycUe2OGMEl1VBb8sGlk10O3Jz2Wkli
 w8Sjlt+SBaUnWUY/s35jVAH2xwhXC0u+0MZIZonBh8UC11SSFOAhGq/igQC/Wf2If17+
 ZYwCZupWTU3Fib5QTDzCtbWcfZOaM7fxKj4bWAZh1BR1cK1amolZIruR8eQAMY/waj4S
 0CXQ==
X-Gm-Message-State: AOAM532muccBKFa8TpKWDkFgAqK6owpNxZzbIbMLeAt0V8M0Zu/Kanny
 4+GmEAydPII3EuCbMfOCNRsEDx1m5Wk=
X-Google-Smtp-Source: ABdhPJwaEnoHMVucuB9LLEr4A/KS6Mpk7f37MDYT4BeIkf8cOCqqA2RL4ZQg1VkAzvdw8T75Xcf81g==
X-Received: by 2002:adf:8008:: with SMTP id 8mr41606668wrk.188.1638780353322; 
 Mon, 06 Dec 2021 00:45:53 -0800 (PST)
Received: from abel.fritz.box (p57b0b77b.dip0.t-ipconnect.de. [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id b15sm13192439wri.62.2021.12.06.00.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Dec 2021 00:45:52 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com
Subject: [PATCH] drm/amdgpu: don't skip runtime pm get on A+A config
Date: Mon,  6 Dec 2021 09:45:51 +0100
Message-Id: <20211206084551.92502-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The runtime PM get was incorrectly added after the check.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index ae6ab93c868b..4896c876ffec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -61,9 +61,6 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	if (pci_p2pdma_distance_many(adev->pdev, &attach->dev, 1, true) < 0)
 		attach->peer2peer = false;
 
-	if (attach->dev->driver == adev->dev->driver)
-		return 0;
-
 	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
 	if (r < 0)
 		goto out;
-- 
2.25.1

