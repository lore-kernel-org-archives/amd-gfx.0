Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23A5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 07:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 741322068E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 07:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="inDQYcmH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741322068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07AC489FD7;
	Mon, 15 Jun 2020 07:28:03 +0000 (UTC)
Received: from mta-p8.oit.umn.edu (mta-p8.oit.umn.edu [134.84.196.208])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 900226E029
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Jun 2020 02:21:25 +0000 (UTC)
Received: from localhost (unknown [127.0.0.1])
 by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49kyrP22Jwz9vYVN
 for <amd-gfx@lists.freedesktop.org>; Sun, 14 Jun 2020 02:21:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
 by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LmL74xk3jRx0 for <amd-gfx@lists.freedesktop.org>;
 Sat, 13 Jun 2020 21:21:25 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49kyrP0GJvz9vYWB
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jun 2020 21:21:25 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49kyrP0GJvz9vYWB
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49kyrP0GJvz9vYWB
Received: by mail-il1-f200.google.com with SMTP id c11so9482795ilq.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jun 2020 19:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=umn.edu; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1skhAYqgTNSWsq4lvqV5pXURB90mGpd6sDboa81hzn4=;
 b=inDQYcmHcL3Cz+asrBz/w7/AH+tbLoHWzIu2j3/vBKxYRotaYrR5dtjBlReiW10muR
 JgRA7bR5vnj1ZLaL/RZraj1F3mx2KnqSqFmaI0AN1pl7t3wXWBnHQtOwIfAiEqxfhDwV
 HKUtr3/gv03Oz+PzAaaeW8sVCHIlPPzRLIpmlfBvilKpr1GJWbfuWfSLNFDpXlZKwGhc
 AjwoKU9MfTAeNWiZ1q47UyU7QzPSNrEgTkJ73Byh6v5PoKL7iiSeU/4R35njyzj/5+uT
 qCxwAwiiUTmGJIYYBX51YNcIcbOIgx4uvW6caEEPkoLiC+gnepFHBVifLyZ9PhjKnCD8
 ZIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1skhAYqgTNSWsq4lvqV5pXURB90mGpd6sDboa81hzn4=;
 b=o0tVPJhHz+QHCjNMMY0TiAsqpgxUdPH1RX3/LZIPQzJ5aBG/2KrY1vytrpG2X1/w0h
 tvqVZL8LDws4WldVlw78SOnJ0PxFc/kiVb0zupC76sj4mUNSfRp1xjbbHkdJhcywIxqw
 feXTVuaERrPjb2yjCcCugegqh7IheFrM4csWL/3z2YXLeOXTbY+WG/jrbrm0PoU/bR24
 NgjLTaGAOcxU7Gnc9mzVzUpEh7bQCFO5M6drj0Rlw70AmGmbt7Y4iYA6nnJVzaSJICwS
 bQzBdGwySetL/ScYAeYEwHvNJwZAzKn0qnukV4k7kNNU2Z0DQcvVmGayRmD7tvGuOUkP
 O1iQ==
X-Gm-Message-State: AOAM533/1sijD/8GxED4uZDN5+S42+TeJpwXaz8LUfXLK+7665wCrmgE
 mWjrJccAIBUVKE8xLr3LGE9e1XnhsIBAdw25MqMz3qy5RiEv75N65fBbo3nDV0sQuh3uRpFBW3o
 FhaBuFdSovziGZayrJzHf6tFTQlwL4w==
X-Received: by 2002:a92:6a06:: with SMTP id f6mr19738335ilc.89.1592101284491; 
 Sat, 13 Jun 2020 19:21:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwE+vPbigALAessccDcAKFOmVWqMDFxxHN2H7lviB9iL6LRnhGo3tuBBjuUyQNOGb53QjP8Ew==
X-Received: by 2002:a92:6a06:: with SMTP id f6mr19738330ilc.89.1592101284325; 
 Sat, 13 Jun 2020 19:21:24 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
 by smtp.gmail.com with ESMTPSA id l26sm5762514ild.59.2020.06.13.19.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 19:21:23 -0700 (PDT)
From: Aditya Pakki <pakki001@umn.edu>
To: pakki001@umn.edu
Subject: [PATCH] drm/radeon: Fix reference count leaks caused by
 pm_runtime_get_sync
Date: Sat, 13 Jun 2020 21:21:22 -0500
Message-Id: <20200614022122.124908-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 15 Jun 2020 07:27:54 +0000
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
Cc: wu000273@umn.edu, David Airlie <airlied@linux.ie>, kjlu@umn.edu,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
reference count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_display.c | 4 +++-
 drivers/gpu/drm/radeon/radeon_drv.c     | 4 +++-
 drivers/gpu/drm/radeon/radeon_kms.c     | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 35db79a168bf..df1a7eb73651 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -635,8 +635,10 @@ radeon_crtc_set_config(struct drm_mode_set *set,
 	dev = set->crtc->dev;
 
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	ret = drm_crtc_helper_set_config(set, ctx);
 
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index bbb0883e8ce6..62b5069122cc 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -549,8 +549,10 @@ long radeon_drm_ioctl(struct file *filp,
 	long ret;
 	dev = file_priv->minor->dev;
 	ret = pm_runtime_get_sync(dev->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return ret;
+	}
 
 	ret = drm_ioctl(filp, cmd, arg);
 	
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index c5d1dc9618a4..99ee60f8b604 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -638,8 +638,10 @@ int radeon_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	file_priv->driver_priv = NULL;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return r;
+	}
 
 	/* new gpu have virtual address space support */
 	if (rdev->family >= CHIP_CAYMAN) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
