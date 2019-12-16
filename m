Return-Path: <SRS0=GTlj=2G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAB0C43603
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 17:18:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E9B206D7
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2019 17:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nakbxxWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E9B206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7664E6E842;
	Mon, 16 Dec 2019 17:18:48 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E08806E842
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 17:18:47 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id z14so5830149qkg.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2019 09:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yFhFCWPDQb8g9R11mLSEvpgYbxGn8Zm9QLmBRd+JfXY=;
 b=nakbxxWP59CaRW8fpGxrytNPrt3sPr8k1AJP60HP0I+AEY/NzmNwJredDBnLovbXkU
 ZMK+BC7e709n/RepLPEKYGZU3W/CC2tL0O+uxRiKBlHBOrCv9VugWcdfIARentPoC0Vo
 gAOTjMG2ne4tyhBoMLJKBSHQsqVkZVIxp7zUhNbonaPIK1xBUFthC+btaxqURL/4hTMJ
 CHcPuIogvUEYFxdeopHD6pDhqK8PbCCToX9+OIzEtz1gNJWFuGtdJe15r4tXkic8F8rK
 /YP7zHBrBrAiOpa3GMiCm69WU763gIxZV2t38TY3AhwF2rjsMxCSi+cjos/QlMTRf4PU
 P0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yFhFCWPDQb8g9R11mLSEvpgYbxGn8Zm9QLmBRd+JfXY=;
 b=WMUBLFMohLF6yTcecu/AwLO+mdvLR+GCSUVNN7DOsfwqtlVBSOahQZlN3s/P5lbHa5
 YwjiR1r7CXrokfhmGY1LFXiJhUxdc1aLWBEx6fLNnuV1bKtCCfdVkdfePe4slcvAw7Oz
 lCHTHnhTZZiD1F/1RDVbGFiwu8x/HdVMUNMICCz7ucuyFeVEFsdh5ARZOHhQyg0WngpU
 8ZpOvq764k81ebGaM4CvAgFagtp5+nxW0D+mmPwcVlaqIcE7ZU+qjgMpTO6exQkHUZgJ
 qzBjuLNYErsgZP8WPtzkrRqbBEy3Izx9vQtJ3JytBISb6Jq0Cd4iSClhyJGqe6Ii9pbc
 TE5Q==
X-Gm-Message-State: APjAAAXhWMi1G3R5o0oczP/dx0M45FCu+LM5F7Lh2Y+NrTPbn58+s0S+
 eVYrZWGXIO2/ZGL3VwSAPyzgdhAE
X-Google-Smtp-Source: APXvYqznw4xQl7R0rWsfOSi0FKuE+kNg8IxzwCWqsRCTuhyQA9X8ziRXvBF/LfmM30cAW7XmnDf2Og==
X-Received: by 2002:a37:68d5:: with SMTP id d204mr305227qkc.171.1576516726898; 
 Mon, 16 Dec 2019 09:18:46 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id k50sm7219291qtc.90.2019.12.16.09.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 09:18:46 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Enter low power state if CRTC active.
Date: Mon, 16 Dec 2019 12:18:34 -0500
Message-Id: <20191216171834.217251-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191216171834.217251-1-alexander.deucher@amd.com>
References: <20191216171834.217251-1-alexander.deucher@amd.com>
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
 Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

CRTC in DPMS state off calls for low power state entry.
Support both atomic mode setting and pre-atomic mode setting.

v2: move comment

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 45 +++++++++++++++++++++----
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 61dc26515c7e..e7f7463a0cbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1296,24 +1296,55 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_dev->dev_private;
-	struct drm_crtc *crtc;
+	/* we don't want the main rpm_idle to call suspend - we want to autosuspend */
+	int ret = 1;
 
 	if (!adev->runpm) {
 		pm_runtime_forbid(dev);
 		return -EBUSY;
 	}
 
-	list_for_each_entry(crtc, &drm_dev->mode_config.crtc_list, head) {
-		if (crtc->enabled) {
-			DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
-			return -EBUSY;
+	if (amdgpu_device_has_dc_support(adev)) {
+		struct drm_crtc *crtc;
+
+		drm_modeset_lock_all(drm_dev);
+
+		drm_for_each_crtc(crtc, drm_dev) {
+			if (crtc->state->active) {
+				ret = -EBUSY;
+				break;
+			}
 		}
+
+		drm_modeset_unlock_all(drm_dev);
+
+	} else {
+		struct drm_connector *list_connector;
+		struct drm_connector_list_iter iter;
+
+		mutex_lock(&drm_dev->mode_config.mutex);
+		drm_modeset_lock(&drm_dev->mode_config.connection_mutex, NULL);
+
+		drm_connector_list_iter_begin(drm_dev, &iter);
+		drm_for_each_connector_iter(list_connector, &iter) {
+			if (list_connector->dpms ==  DRM_MODE_DPMS_ON) {
+				ret = -EBUSY;
+				break;
+			}
+		}
+
+		drm_connector_list_iter_end(&iter);
+
+		drm_modeset_unlock(&drm_dev->mode_config.connection_mutex);
+		mutex_unlock(&drm_dev->mode_config.mutex);
 	}
 
+	if (ret == -EBUSY)
+		DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
+
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_autosuspend(dev);
-	/* we don't want the main rpm_idle to call suspend - we want to autosuspend */
-	return 1;
+	return ret;
 }
 
 long amdgpu_drm_ioctl(struct file *filp,
-- 
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
