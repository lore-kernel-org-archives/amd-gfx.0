Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A28A1C25B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 19:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E80910EAE1;
	Tue, 28 May 2024 19:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yEEYPbJ4";
	dkim-atps=neutral
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E582C10E362
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 19:39:23 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5295c65d3fdso183786e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 12:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716925162; x=1717529962; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NAWjwCLmat0Pt42wss/KcevTPw7T7NPDEdWBIi4Ib0k=;
 b=yEEYPbJ4FWC7JgRbRUS2RvGG8bnJq8sNcyyLsuKgfySqWEIiXPL5BEVbStnftM7kBK
 vppxDIqfDU7y3y/OAXd1qfqbu1pIg/gkoS1jZggBSBeOuIYymmoAGJQOCXEHdlEYTcbS
 S4bJCwkA22fLIMFhuYj2uYWVTA+yK69c9pbPE6W6nw60ICye4iInbjFzKxZi9SjNV1jS
 DSlhIDBy81eiD6smrLyoXSNUNkU7y9wj1QYeTK+TUfRi4F4tdVoG5BkUdRbIfxH7Q5Kq
 qkkB9Lgx6/3+KjGRne7XMgSSEg2YpdPIkOlCi476rMlbLJqEWYQKHa0+bs4jI5QfUrUR
 455Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716925162; x=1717529962;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NAWjwCLmat0Pt42wss/KcevTPw7T7NPDEdWBIi4Ib0k=;
 b=ZHBXpn/iPNXhQ7EeCVjJBHQ51MGlHLkDpk521z1NH7R6ZJULIUrRydQC1l2GzgErF+
 0OTRa4cjPItNsLjegVh+avNv5bgRGY2mNGKly/unBGmj52lhy4n9rxfyirH0L/dRZ44e
 NLxAoOB+xg7KOI0nQnCcdkig6G56BcX8iikeDTPGqHPK9nkEpJmXYfLnghDKCwTk/8/H
 3pjIESqRvE57bcrODK0mSAZ6IRKpnB7HMkvbJ/6aiackrqJZSCkYAL47fXQdDtSfUmOZ
 C73H9eLy8omW7JVW5A+h7XvUzwU0/I27ZZ8xpXgjwC/sberygtQi1BykYet8hMMfkMAw
 CmbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2HGpVYF5Xx2exvjgOpfqijEuZ06DQaIjU1o2haSMIvHRiPXtZ3j9Om6qrvXaNhXsglAzGMsEsD5U3cb1JSDFMtug5g6B1MphNBzfrfA==
X-Gm-Message-State: AOJu0YwD90SiWwdaZDqqL/SNn5hbqq6AbYnwXBKFDxreQS9fmuWbECfH
 /8y4msugs+eV9PG8P/0EonETujCoQN88jvrRPWykCuFvz6AaXp/r4kW7cIEJT0w=
X-Google-Smtp-Source: AGHT+IFEcfUebNH9/3F7+tMGSmm6idGFX/etBkGLAL2JYR2M63YeQM1oJ70p2YpisBnpaZawk1xktw==
X-Received: by 2002:ac2:5181:0:b0:51f:9a88:be2a with SMTP id
 2adb3069b0e04-52a829140ccmr9443e87.23.1716925161963; 
 Tue, 28 May 2024 12:39:21 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-529711f96c9sm1045234e87.245.2024.05.28.12.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 12:39:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 28 May 2024 22:39:19 +0300
Subject: [PATCH v4 2/3] drm/panel/lg-sw43408: mark sw43408_backlight_ops as
 static
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-panel-sw43408-fix-v4-2-330b42445bcc@linaro.org>
References: <20240528-panel-sw43408-fix-v4-0-330b42445bcc@linaro.org>
In-Reply-To: <20240528-panel-sw43408-fix-v4-0-330b42445bcc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=0ZNKdxQ3JQtZLj0Gm+s5zrogyXn00ZSW+UEFR2j6wX0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVjLng5Aeh5SVikvcmyAnRHw7p/ThlBTJFm122
 2UcNeNowKyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlYy5wAKCRCLPIo+Aiko
 1fYqCACDlxEKTIMf+LG30I/ejey3MLX/dYsOzRn50AnSqjNYVvRap590vVb8JCAO/9+j/KSr+8d
 T4DAgUGFxwq6LDitmxf+/oQ4ADKYaCLCsnn3jAxJI5DYvDiKXYnXY6Rc3IcjzoQ6bz6mL7/t1wC
 mwRLcPAI/PJdLSms2esDsB98guDvQBNqsRnbpkwPHHwHdukZGq1onHOffn+Duuo69584l9r/zoQ
 JwEJltht3UiIiCeKyZ+MiVA1pViV3CcXIq/yBwiGuqewvjMtDg1sMBCatIlpaTAAX4CtHutzAEu
 SGFXB8p+FvwgGpODO05RIYqS5nLSPhZxdGWjx1coXC+42tjK
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

Fix sparse warning regarding symbol 'sw43408_backlight_ops' not being
declared.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404200739.hbWZvOhR-lkp@intel.com/
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Fixes: 069a6c0e94f9 ("drm: panel: Add LG sw43408 panel driver")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 115f4702d59f..2b3a73696dce 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -182,7 +182,7 @@ static int sw43408_backlight_update_status(struct backlight_device *bl)
 	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
 }
 
-const struct backlight_ops sw43408_backlight_ops = {
+static const struct backlight_ops sw43408_backlight_ops = {
 	.update_status = sw43408_backlight_update_status,
 };
 

-- 
2.39.2

