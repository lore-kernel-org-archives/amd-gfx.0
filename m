Return-Path: <SRS0=yJoC=B3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0156C433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 19:53:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B9920658
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2020 19:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhmL2gU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B9920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE2FB89F19;
	Mon, 17 Aug 2020 19:53:41 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2850D89CB2
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 19:53:40 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id s15so8406569qvv.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2020 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rl/oL1qZstWe35hBpi77kD0PjPTL5DGp8T2u1cafgj0=;
 b=lhmL2gU4ndgmnH8gBWp20z14Cts/LBqDJX2U7dqVZsGKuN3wqYwj+zLoJp0TDTvmYP
 eFenJgeoAdLS+e5xSZr+0tOOcBhFHTnv3HT80KynrMyRg8Qf5XXthm7pF1st1FCebpDM
 krSsYjW80sH2pIsR0vUVDDkff9hYJXUqSUex4NEF/nNn/QUw3or3M5+qG35rqlexH8fi
 Wd5cfvMPiK6ZHb1esqTTvkA4f46zb6kiQLNWiniOKdBmKapWA0Byop1q5gjM2PsMzDBA
 OZWeaQ+q38ZFcm+K2mVy6XXtRgvI6sfahQ0QLfHjN/XuAfKSeN4DZd0geCJ3PDnyIcUi
 NL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rl/oL1qZstWe35hBpi77kD0PjPTL5DGp8T2u1cafgj0=;
 b=fjTXXoHww7jsPkz/XK8mtsGBoyniu+JPyC2wZQEP4nd5VHpIL3BseA16eRaSV+zAre
 uuufm9ZeYEHN7t1LmFZtEShCpUbayLEpcbrsDb8kHPzN0MY5t9yRw8UiLi0LuN6jLklP
 oXB57pQIsLRiYQkL3DR5s8T+g04MjPvcCR4bh3vWBiyvTHpXg9AR433+r3E/XlstwqC7
 t55SJFxZ6ZSPQGEqpXlMqmRYNiDH5cXogmg+7E6G/IffTOYH9I0Thh/MfzXzw8Poq/lv
 kqc6HO/VXTNZao3hGgo7hQO3f7fM0A8zxUIgRpV/9c28idlLssbJCHlONtGCa6GzVPzT
 9+bw==
X-Gm-Message-State: AOAM531yCVy0ka+IKbtutDh4f2l8tC7Gwi87o8dbUgHrcOLmjoGVY++0
 16dIX5gKzUGBcZ4m9nN3/XFYTzCksvU=
X-Google-Smtp-Source: ABdhPJzjPqJBUA5y+Byxn4RTA5693Rq6E2By4KuGBw3/E6BprkUZmRUT0p/XQ3zgpznHrS5f0+1CxA==
X-Received: by 2002:a0c:ca86:: with SMTP id a6mr15586186qvk.209.1597694019033; 
 Mon, 17 Aug 2020 12:53:39 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id p189sm18103161qkb.61.2020.08.17.12.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 12:53:38 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu/swsmu: implement voltage metrics for RENOIR
Date: Mon, 17 Aug 2020 15:53:27 -0400
Message-Id: <20200817195329.1971490-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200817195329.1971490-1-alexander.deucher@amd.com>
References: <20200817195329.1971490-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Grab the data from the SMU metrics table.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 186929c31e9e..ac81f2f605a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -616,6 +616,27 @@ static int renoir_get_current_activity_percent(struct smu_context *smu,
 	return 0;
 }
 
+static int renoir_get_vddc(struct smu_context *smu, uint32_t *value,
+			   unsigned int index)
+{
+	int ret = 0;
+	SmuMetrics_t metrics;
+
+	if (index >= 2)
+		return -EINVAL;
+
+	if (!value)
+		return -EINVAL;
+
+	ret = smu_cmn_get_metrics_table(smu, &metrics, false);
+	if (ret)
+		return ret;
+
+	*value = metrics.Voltage[index];
+
+	return 0;
+}
+
 /**
  * This interface get dpm clock table for dc
  */
@@ -952,6 +973,14 @@ static int renoir_read_sensor(struct smu_context *smu,
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
+	case AMDGPU_PP_SENSOR_VDDGFX:
+		ret = renoir_get_vddc(smu, (uint32_t *)data, 0);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDNB:
+		ret = renoir_get_vddc(smu, (uint32_t *)data, 1);
+		*size = 4;
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
