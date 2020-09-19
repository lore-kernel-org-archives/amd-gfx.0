Return-Path: <SRS0=7fFe=C4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3510C43465
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Sep 2020 13:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A9320878
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Sep 2020 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DQo/gZuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A9320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B07206E480;
	Sat, 19 Sep 2020 13:40:40 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF3F6E43F
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Sep 2020 13:40:39 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id w2so7835300wmi.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Sep 2020 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jqv5YN8cuKpoP53km0dn9I4q1Jwk/X6asAw90xbvEY0=;
 b=DQo/gZuGIjuPa62ILYR0X41cZSMFXPViJqph/Wcb+Dgf2RbIGNpq9Xdhx+He/YEwN9
 pHzRnHKXQ0bS2J5nBP9tr9YrZXpJIHdIUyvhcsIkLAeqv8WPGx+yBz2KORCGgsqz3GyI
 pKYX/UQFXi+5dbNYsy5YozSVyIkqQfNslRhuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jqv5YN8cuKpoP53km0dn9I4q1Jwk/X6asAw90xbvEY0=;
 b=abEZnHNH7FBW9TMIsLQq2Zm/0KkZ0mfVmATLhmvQ0gOqNwtIxjIC/tXVjbWiNyg/Mm
 eYiQGiEuvixx0arQqEp/x74c8BMfIjo6oR9uFJt0IFmhrCT7KldZJXK7/dIYyQKdDLqt
 cOZdx4598copWuWo5AcckfPOY5FU5v5SEhy5++fO3WU9FMNCIgTARVBiil07WRomkNGs
 EOmCRaR2gYfM2pt5jgH1FcpygC9skcRgJdg5/jkMQ61uQ2+6L4XjXvGxT7A1rSXuYs3R
 c+gIsYJPbMHFsH+efLClO5Lngnzp+Clh0MJyCBO1Juru0AmpzAyq/UllMjY4AXFxlF69
 ilXA==
X-Gm-Message-State: AOAM533Oq6NrxPPn8uDbkzXNY2saNP412h1/QtD9unuP9cEG/+jUU6Lv
 kG37yRE3lu6L31g7xdGbq+OGpw==
X-Google-Smtp-Source: ABdhPJzb+FwjA8YiChED3XUSrDzmdcehl9EKww/0n/KvaOpReYci80Ur142gsUDZkzJXIG3LKUw/4A==
X-Received: by 2002:a1c:8109:: with SMTP id c9mr20708928wmd.130.1600522837983; 
 Sat, 19 Sep 2020 06:40:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id f14sm12526970wrt.53.2020.09.19.06.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2020 06:40:37 -0700 (PDT)
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: DRI Development <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/i915/selftests: align more to real device lifetimes
Date: Sat, 19 Sep 2020 15:40:32 +0200
Message-Id: <20200919134032.2488403-1-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918132505.2316382-3-daniel.vetter@ffwll.ch>
References: <20200918132505.2316382-3-daniel.vetter@ffwll.ch>
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 amd-gfx@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>,
 Matthew Auld <matthew.william.auld@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To avoid having to create all the device and driver scaffolding we
just manually create and destroy a devres_group.

v2: Rebased

v3: use devres_open/release_group so we can use devm without real
hacks in the driver core or having to create an entire fake bus for
testing drivers. Might want to extract this into helpers eventually,
maybe as a mock_drm_dev_alloc or test_drm_dev_alloc.

v4:
- Fix IS_ERR handling (Matt)
- Delete surplus put_device() in mock_device_release (intel-gfx-ci)

v5:
- do not switch to device_add - it breaks runtime pm in the tests and
  with the devres_group_add/release no longer needed for automatic
  cleanup (CI). Update commit message to match.
- print correct error in pr_err (Matt)

v6: Remove now unused err variable (CI).

v7: More warning fixes ...

Cc: Matthew Auld <matthew.william.auld@gmail.com>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com> (v3)
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Matthew Auld <matthew.william.auld@gmail.com> (v4)
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 .../gpu/drm/i915/selftests/mock_gem_device.c  | 39 +++++++++----------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/mock_gem_device.c b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
index ac600d395c8f..b6c42fd872ad 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gem_device.c
+++ b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
@@ -79,8 +79,6 @@ static void mock_device_release(struct drm_device *dev)
 
 out:
 	i915_params_free(&i915->params);
-	put_device(&i915->drm.pdev->dev);
-	i915->drm.pdev = NULL;
 }
 
 static struct drm_driver mock_driver = {
@@ -123,17 +121,10 @@ struct drm_i915_private *mock_gem_device(void)
 #endif
 	struct drm_i915_private *i915;
 	struct pci_dev *pdev;
-	int err;
 
 	pdev = kzalloc(sizeof(*pdev), GFP_KERNEL);
 	if (!pdev)
 		return NULL;
-	i915 = kzalloc(sizeof(*i915), GFP_KERNEL);
-	if (!i915) {
-		kfree(pdev);
-		return NULL;
-	}
-
 	device_initialize(&pdev->dev);
 	pdev->class = PCI_BASE_CLASS_DISPLAY << 16;
 	pdev->dev.release = release_dev;
@@ -144,8 +135,23 @@ struct drm_i915_private *mock_gem_device(void)
 	/* HACK to disable iommu for the fake device; force identity mapping */
 	pdev->dev.iommu = &fake_iommu;
 #endif
+	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL)) {
+		put_device(&pdev->dev);
+		return NULL;
+	}
+
+	i915 = devm_drm_dev_alloc(&pdev->dev, &mock_driver,
+				  struct drm_i915_private, drm);
+	if (IS_ERR(i915)) {
+		pr_err("Failed to allocate mock GEM device: err=%ld\n", PTR_ERR(i915));
+		devres_release_group(&pdev->dev, NULL);
+		put_device(&pdev->dev);
+
+		return NULL;
+	}
 
 	pci_set_drvdata(pdev, i915);
+	i915->drm.pdev = pdev;
 
 	dev_pm_domain_set(&pdev->dev, &pm_domain);
 	pm_runtime_enable(&pdev->dev);
@@ -153,16 +159,6 @@ struct drm_i915_private *mock_gem_device(void)
 	if (pm_runtime_enabled(&pdev->dev))
 		WARN_ON(pm_runtime_get_sync(&pdev->dev));
 
-	err = drm_dev_init(&i915->drm, &mock_driver, &pdev->dev);
-	if (err) {
-		pr_err("Failed to initialise mock GEM device: err=%d\n", err);
-		put_device(&pdev->dev);
-		kfree(i915);
-
-		return NULL;
-	}
-	i915->drm.pdev = pdev;
-	drmm_add_final_kfree(&i915->drm, i915);
 
 	i915_params_copy(&i915->params, &i915_modparams);
 
@@ -229,5 +225,8 @@ struct drm_i915_private *mock_gem_device(void)
 
 void mock_destroy_device(struct drm_i915_private *i915)
 {
-	drm_dev_put(&i915->drm);
+	struct device *dev = i915->drm.dev;
+
+	devres_release_group(dev, NULL);
+	put_device(dev);
 }
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
