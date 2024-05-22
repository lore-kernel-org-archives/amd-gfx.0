Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F48C25B77
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 06:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DAE610F332;
	Wed, 22 May 2024 06:26:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xepnFh4h";
	dkim-atps=neutral
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7254810E562
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:25:59 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-51f57713684so7601624e87.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 23:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716359157; x=1716963957; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LQ30IMIqS4FxBzVdWL5H8+rA/52Tn4UUr+hikbOiM00=;
 b=xepnFh4hzKrl+UBLxPhp6oj7bVr9VwejCWjP+VvccYbXwE+g/w4NrRMzbm1EMcebvX
 bHISoqspTmbdIrfw1379ETcmhpTYdJpoz6RojT1Pv4zJNeyVny7fJtVcfKBp/K0HZXZE
 eGgwiu1dv7Xs89tNnGmQDjs692uFmtYdd5MTO4/9bWZkgCEUsc5DoHEI4ClIbzFos0SE
 OpWx0Zz8bPRQ7ZhiqETaUasJcWnFS14mNilC7vbjazL2tB2Ajv5SKVM2x9X1RHGawAbm
 BLXe6VQtwkn2ieiZiB+P3uRncZ/wPt5xvHyFfDiqABWKSPypb9gOCKLZkodVdMhJGpdM
 0Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716359157; x=1716963957;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQ30IMIqS4FxBzVdWL5H8+rA/52Tn4UUr+hikbOiM00=;
 b=BAbLPy2YRWgNY7+NhSvM+jlGzcmqPCKwRhMh27EJitiBO034yVJWlAM/AJMdKDsuaF
 sUmcdB7yd85xXCwTd0wpVQc6eflBFr+QSEg4s9WbidE3CbYkAg29I/QQfuJivjkd0+rR
 zQ9xYBfG1OeopAYtmjFzpuRnorHtfVKCOM4T9HmytvNNq28mTUjAegiOk6LOwua8phor
 6h9MSOdEQehyJ3HglyccpE/gsJ0SC/zSfNv/8PTw0VGe/3R8rsrk5zxq43WvH79wtWWF
 EID95hD/e5R7cr96lA8qg/XcbVL9xJKAGVB53HXx57+Ha79bxSqKge6wTVXXz/tA/KP7
 oMwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUtgiU0tIDxtL3nvV9KvJRV964YJnjYqDlkJDYf5Z5FR1YNYQkdcX0u5iuNESZEmAv+kQQ5iSvgXrEC8PBq9ZKeNQAxP+VfNXshrRl5w==
X-Gm-Message-State: AOJu0Yzhb0UWxPGvmbc7pFA0zhGHAqLG8sX3iBpCZi9W6Fu4ZY02WPnf
 XuD1fih+agW4ynOgu8PM0042pRyFr+MT9rv4xUHf78AAgxB5QLnFti8m3rJo5Qg=
X-Google-Smtp-Source: AGHT+IF/7QZ0tGCXiFYJB/x+q86OQI6ANWr9joQ1GchVETZy/vH8FMHjzEY05fxM+S1qk+o81MyouA==
X-Received: by 2002:a19:384e:0:b0:520:98ff:5554 with SMTP id
 2adb3069b0e04-526bf35c8c2mr521592e87.30.1716359157191; 
 Tue, 21 May 2024 23:25:57 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-521f35ad4d0sm4910023e87.49.2024.05.21.23.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 23:25:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 22 May 2024 09:25:54 +0300
Subject: [PATCH v3 2/3] drm/panel/lg-sw43408: select
 CONFIG_DRM_DISPLAY_DP_HELPER
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-panel-sw43408-fix-v3-2-6902285adcc0@linaro.org>
References: <20240522-panel-sw43408-fix-v3-0-6902285adcc0@linaro.org>
In-Reply-To: <20240522-panel-sw43408-fix-v3-0-6902285adcc0@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Vinod Koul <vkoul@kernel.org>, Caleb Connolly <caleb@connolly.tech>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=OzVLboiQq6/i7927qpGZm3VA/GBlmQcFYUqcIc2Gbpg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmTY/y3fKq7yHxjaGudmp6EIq0hsmBQi2qIcxkt
 wwyQWrXMseJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZk2P8gAKCRCLPIo+Aiko
 1ZOwB/9XTi/5fMAIsZRH09go2mO1GT8qtjrK4eDP42uTvxIB9XnQKdrUOLABIzsGrwK1kZMfn0q
 wfp4/kKHBuQgQthNE7p7+8smtARdS0TIcPNAWbc2QD0dLFgMyIUqYt9AYgrRtcQd95UMy/DdWKC
 nRvvBcugj/sYeyCgRMBXRl4nMWUmpbf55b6fWCygEWmfd/FO5SsrnY0sws9XiRHDiQchsCPDR5l
 Q9/0ALMepT5iKL3nIEmo7t+oyAFyGRg9K6RG9biicPfITKy98PVCGtYTQ5emoDN/zz4RmsyFdlx
 Yv00RFSQrYhIJ9jvkr2r2fT7Fshh/pvnqcW40+ltqqaFwfuF
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
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

This panel driver uses DSC PPS functions and as such depends on the
DRM_DISPLAY_DP_HELPER. Select this symbol to make required functions
available to the driver.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404200800.kYsRYyli-lkp@intel.com/
Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 4a2f621433ef..3e3f63479544 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -340,6 +340,8 @@ config DRM_PANEL_LG_SW43408
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
+	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for LG sw43408 panel.
 	  The panel has a 1080x2160@60Hz resolution and uses 24 bit RGB per

-- 
2.39.2

