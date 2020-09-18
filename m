Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EF5C43465
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 13:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF8421D24
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 13:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="C4Hm1mXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF8421D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 652EB6ECFB;
	Fri, 18 Sep 2020 13:25:17 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C5F6ECF4
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 13:25:15 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id z9so5574853wmk.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 06:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bqA8wRk5Nq48ozg18p/JKqMGUJq+nJzeTZVZ0hWoQos=;
 b=C4Hm1mXrEZIpzJLmmnj9SW/UFx7zjK6EuR3i3MW4mFiIYbSwKMcxIG3IWt4gnhRZJu
 KnWAekST9k368aQae2zhwPEa37MUPkHUZYjhqmqep26crrRIO13HXIv8JAt6FN4C22sN
 M+WKIFcCZAwvM/gH7X5UD8r/GHOuKqIgjibjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bqA8wRk5Nq48ozg18p/JKqMGUJq+nJzeTZVZ0hWoQos=;
 b=aUtFU9iGbnc8d/Eu9R40Z6zrTCQUxgL6UM9iOKvu/X4Hv3bLPKvrzpvBwd2x+AJtQN
 h2ROlWiMFU/NRq0AHp8ZAH2MWnV6S2+ssV0HbXACTZ8mqAhX6smAlMEUsboGEnGTG/Yu
 9yCX6C526cx5whlSHo74QTLUgPDcl9ho9pRjy51M1eUQKCdnnBruq1BL6RrJAv3ahv/I
 ahLciKGuFv6gvSpPE2l4rVdgS2iK5hkYQVgO+yV2Gy99vNajlZ+wVtq9aEa8Rfq1ZPrW
 EBOXQ/YRtN+a7c5D2+4+rfi3ZnFo/hgM7FWT9S6YLAf3gE6nBCeBDoG0TDF6UwnO1qk+
 m18A==
X-Gm-Message-State: AOAM530/uG8Jm0s1QptWneowldTdiNRdWyHSo+daBXrDqCz4RLb4lQcJ
 Nl87sz0ViiUX3dkvvlV1jMvA7g==
X-Google-Smtp-Source: ABdhPJwVtnqw7M6swccNbGpHxkdHeMxmPX5dearv/JGiLGTZ/LiJWe4vzfqEie1ExiM+YfwlbAWt3A==
X-Received: by 2002:a1c:bbd7:: with SMTP id
 l206mr16570930wmf.185.1600435514370; 
 Fri, 18 Sep 2020 06:25:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id k6sm4872693wmi.1.2020.09.18.06.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 06:25:13 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdgpu: Convert to using devm_drm_dev_alloc() (v2)
Date: Fri, 18 Sep 2020 15:25:04 +0200
Message-Id: <20200918132505.2316382-4-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918132505.2316382-1-daniel.vetter@ffwll.ch>
References: <20200918132505.2316382-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Luben Tuikov <luben.tuikov@amd.com>

Convert to using devm_drm_dev_alloc(),
as drm_dev_init() is going away.

v2: Remove drm_dev_put() since
    a) devres doesn't do refcounting, see
    Documentation/driver-api/driver-model/devres.rst,
    Section 4, paragraph 1; and since
    b) devres acts as garbage collector when
    the DRM device's parent's devres "action" callback
    is called to free the container device (amdgpu_device),
    which embeds the DRM dev.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 6edde2b9e402..3ded6f43f982 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1142,25 +1142,20 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
-	if (!adev)
-		return -ENOMEM;
+	adev = devm_drm_dev_alloc(&pdev->dev, &kms_driver, typeof(*adev), ddev);
+	if (IS_ERR(adev))
+		return PTR_ERR(adev);
 
 	adev->dev  = &pdev->dev;
 	adev->pdev = pdev;
 	ddev = adev_to_drm(adev);
-	ret = drm_dev_init(ddev, &kms_driver, &pdev->dev);
-	if (ret)
-		goto err_free;
-
-	drmm_add_final_kfree(ddev, adev);
 
 	if (!supports_atomic)
 		ddev->driver_features &= ~DRIVER_ATOMIC;
 
 	ret = pci_enable_device(pdev);
 	if (ret)
-		goto err_free;
+		return ret;
 
 	ddev->pdev = pdev;
 	pci_set_drvdata(pdev, ddev);
@@ -1188,8 +1183,6 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 
 err_pci:
 	pci_disable_device(pdev);
-err_free:
-	drm_dev_put(ddev);
 	return ret;
 }
 
@@ -1206,7 +1199,6 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	amdgpu_driver_unload_kms(dev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
-	drm_dev_put(dev);
 }
 
 static void
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
