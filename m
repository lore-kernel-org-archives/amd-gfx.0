Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF40C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 02:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE5D710E704;
	Fri,  3 Feb 2023 02:07:59 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FD010E702
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 02:07:58 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id l8so2860344wms.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Feb 2023 18:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=froggi.es; s=google;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CB7JgucKeJ6phjSQlRY4scMyhMMpSUS4Rmo8NmixujE=;
 b=SwNhqEGTUaH2kj+FonmmL52VueekCZG7f4+4SnI7zaknfCbI7h7AAvms4I6h2jMe9c
 rOvtqPIpRzalBu86lrlnDnNvPlGoaFnJYeHIWzuZOik3xYd/Mh3wV4WPgeAFWD+SO77/
 WbtRtNUp41tL3H/mCEvFDNDigf77ls+ySW6M+Lo2oTeIt0lDRywole8nLLdWncDRVGg8
 bifMQq3Hr5S4VJj4SbG0Jk7iGSmtL0bgJKtkCboWxQEIumy+maFH1SpyGMZqtQGMSeoA
 uuC3C4OyKUCtzl8vuTZeshhpwpWTZkNlrRirMvvoX2O71GAEXZMo+1ps93ffxnYhgwCJ
 Bnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CB7JgucKeJ6phjSQlRY4scMyhMMpSUS4Rmo8NmixujE=;
 b=uSIwrqfgVazvbTdLbNNMQMgRzGIlgEQU9rdrmojDr81u2JhNb8qAKvB+obqAMx5rPt
 Y36S1JAGXrWxjPPTAov9o9LcoflPMuioH3+HRRGtxZkmm0NhuggNZXkWrrkp8ptEmYMp
 AOfyRECL+UxwNh7vBf9U9zROlTeW2h5FkK8aYYanQBQsbGklpAOwD6PAvwRZD0W6bbG2
 ZBCovRPpz4jGPAWl/Jw8UpDYrdI3Za5dQjy9AlGJz7F2XZc1RtKfAwMnUCd8Z+1O4Caj
 kdToUCc5SD6DXWXKwtUuK1x4Ug7jeS3k3cSGqOgno1LYlSLff0K/rvsqSM/Bmh7vkBkF
 jgLg==
X-Gm-Message-State: AO0yUKX4q3cGDWkX8R3lmc2XQUCK7imoi6i7Kx24h8Hq6ormCciF+WyU
 tv5pk6XGjpp+eNjPfVZIXdJ/Ew==
X-Google-Smtp-Source: AK7set91M+xvFaOAFSsE0hJX+6hdQd0Y60s7w8Z/RJF1gp3q5Vs3/rNN+nEGEwKkjOg/5BXA0XzNbw==
X-Received: by 2002:a05:600c:3d0b:b0:3d0:7fee:8a70 with SMTP id
 bh11-20020a05600c3d0b00b003d07fee8a70mr9310429wmb.19.1675390076978; 
 Thu, 02 Feb 2023 18:07:56 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 g10-20020a05600c310a00b003de77597f16sm1297327wmo.21.2023.02.02.18.07.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 18:07:56 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 2/3] drm/connector: Add enum documentation to drm_colorspace
Date: Fri,  3 Feb 2023 02:07:43 +0000
Message-Id: <20230203020744.30745-2-joshua@froggi.es>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230203020744.30745-1-joshua@froggi.es>
References: <20230203020744.30745-1-joshua@froggi.es>
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
Cc: Sebastian Wick <sebastian.wick@redhat.com>, amd-gfx@lists.freedesktop.org,
 Pekka Paalanen <ppaalanen@gmail.com>, Uma Shankar <uma.shankar@intel.com>,
 Joshua Ashton <joshua@froggi.es>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Vitaly.Prosyak@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To match the other enums, and add more information about these values.

Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Pekka Paalanen <ppaalanen@gmail.com>
Cc: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Vitaly.Prosyak@amd.com
Cc: Uma Shankar <uma.shankar@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Joshua Ashton <joshua@froggi.es>
Cc: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
---
 include/drm/drm_connector.h | 41 +++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index edef65388c29..eb4cc9076e16 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -363,13 +363,50 @@ enum drm_privacy_screen_status {
 	PRIVACY_SCREEN_ENABLED_LOCKED,
 };
 
-/*
- * This is a consolidated colorimetry list supported by HDMI and
+/**
+ * enum drm_colorspace - color space
+ *
+ * This enum is a consolidated colorimetry list supported by HDMI and
  * DP protocol standard. The respective connectors will register
  * a property with the subset of this list (supported by that
  * respective protocol). Userspace will set the colorspace through
  * a colorspace property which will be created and exposed to
  * userspace.
+ *
+ * @DRM_MODE_COLORIMETRY_DEFAULT:
+ *   sRGB (IEC 61966-2-1) or
+ *   ITU-R BT.601 colorimetry format
+ * @DRM_MODE_COLORIMETRY_SMPTE_170M_YCC:
+ *   SMPTE ST 170M colorimetry format
+ * @DRM_MODE_COLORIMETRY_BT709_YCC:
+ *   ITU-R BT.709 colorimetry format
+ * @DRM_MODE_COLORIMETRY_XVYCC_601:
+ *   xvYCC601 colorimetry format
+ * @DRM_MODE_COLORIMETRY_XVYCC_709:
+ *   xvYCC709 colorimetry format
+ * @DRM_MODE_COLORIMETRY_SYCC_601:
+ *   sYCC601 colorimetry format
+ * @DRM_MODE_COLORIMETRY_OPYCC_601:
+ *   opYCC601 colorimetry format
+ * @DRM_MODE_COLORIMETRY_OPRGB:
+ *   opRGB colorimetry format
+ * @DRM_MODE_COLORIMETRY_BT2020_CYCC:
+ *   ITU-R BT.2020 Y'c C'bc C'rc (linear) colorimetry format
+ * @DRM_MODE_COLORIMETRY_BT2020_RGB:
+ *   ITU-R BT.2020 R' G' B' colorimetry format
+ * @DRM_MODE_COLORIMETRY_BT2020_YCC:
+ *   ITU-R BT.2020 Y' C'b C'r colorimetry format
+ * @DRM_MODE_COLORIMETRY_DCI_P3_RGB_D65:
+ *   DCI-P3 (SMPTE RP 431-2) colorimetry format
+ * @DRM_MODE_COLORIMETRY_DCI_P3_RGB_THEATER:
+ *   DCI-P3 (SMPTE RP 431-2) colorimetry format
+ * @DRM_MODE_COLORIMETRY_RGB_WIDE_FIXED:
+ *   RGB wide gamut fixed point colorimetry format
+ * @DRM_MODE_COLORIMETRY_RGB_WIDE_FLOAT:
+ *   RGB wide gamut floating point
+ *   (scRGB (IEC 61966-2-2)) colorimetry format
+ * @DRM_MODE_COLORIMETRY_BT601_YCC:
+ *   ITU-R BT.609 colorimetry format
  */
 enum drm_colorspace {
 	/* For Default case, driver will set the colorspace */
-- 
2.39.1

