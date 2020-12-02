Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD7BC64E90
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 03:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673F92158C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 03:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673F92158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA07D6E9A6;
	Wed,  2 Dec 2020 03:05:17 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25C476E9A5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 03:05:16 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id g17so109302qts.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Dec 2020 19:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YkAHxa7B3vFe3m26R7M0aX5o3mZJOSCbc4e6h86XD18=;
 b=N+IcWzqHmKoWLcB8AnflF2ZW5vbURf168jmQLBTn1tvvlDAEOuIalR3XBTPFwJjiPC
 Z+vVETux+aCdc95uy3+X4rIYxAC6Qb6DubVGV4YMv/UThN5+33rWqNtLykZ7Jmtv/TJ9
 yJbVHasJQuKSv+hSPtPtJxPVjk2kTy+TyE9BT/VihZFQAbLT2ebEAf7+3DSbU2n88NGW
 h6nq9TxrrpMyDIG15oQwXQ1NMK534bE5DG/aq2V2VhABcxosd6Q0uaDDyjhpV6nQ17FU
 pg0coQ7Zs1Bb8aD1f4BI1IAAr8cZBBSyXgYOc9eFown9G0C0pkwjFbE0yo6JCSzY5lU2
 NkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YkAHxa7B3vFe3m26R7M0aX5o3mZJOSCbc4e6h86XD18=;
 b=dsA14Vnh7PVBpGMFVRbnpVRQ5ficdAzcjX9m4OvaRU09zGc5nHWXRHZEy5WPEnCKmz
 pKgLATkYxLeYSd0JfCVtqInSy38UHANu7jNrR+FU7YGETQawcjpIToSAIwrweLDiGXnh
 pMRYYTUvzataQFKAoT/Tieye7AQoLG7ptY1K/ZFDO/3ikfQmfSnOuKjr570zmKAaXQZI
 bT//WcDgsnCirTw1HOunCf0TCzTX4rSNQkceUab0HbzutheJDI0Y+SjtLS2mwhVHrLkN
 nxK1PpnWVKNbAtjFOgwaM3Dz+n/95jE4I2EJ409KdSWMBeUAq8DQ9ZdLWWTX68RnpWVA
 cOQg==
X-Gm-Message-State: AOAM533+3TXmd0AUvlLfSqr5ACR5h6jEUturCTFU45ZvfFU71SNZcCkQ
 6J9TUVMQdgNEQ1fj970LZUZXvwYa6jg=
X-Google-Smtp-Source: ABdhPJyLuN0t3uHrUR+0KdGTp7ulVs0JyS6PNzdBYko5ll9l1nCjSjfk0x4syKNGarXStNsF8JTpHw==
X-Received: by 2002:ac8:6d15:: with SMTP id o21mr660487qtt.83.1606878315068;
 Tue, 01 Dec 2020 19:05:15 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id b64sm471411qkg.19.2020.12.01.19.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Dec 2020 19:05:14 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu/swsmu/vangogh: use metrics table for voltages
 (v2)
Date: Tue,  1 Dec 2020 22:05:04 -0500
Message-Id: <20201202030505.1310154-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201202030505.1310154-1-alexander.deucher@amd.com>
References: <20201202030505.1310154-1-alexander.deucher@amd.com>
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

Fixes voltage reading for vddgfx and adds support for vddsoc.

v2: use new voltage enum

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 1645509cdab8..d5a06cc44dbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -265,6 +265,12 @@ static int vangogh_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_THROTTLER_STATUS:
 		*value = metrics->ThrottlerStatus;
 		break;
+	case METRICS_VOLTAGE_VDDGFX:
+		*value = metrics->Voltage[2];
+		break;
+	case METRICS_VOLTAGE_VDDSOC:
+		*value = metrics->Voltage[1];
+		break;
 	default:
 		*value = UINT_MAX;
 		break;
@@ -469,13 +475,21 @@ static int vangogh_read_sensor(struct smu_context *smu,
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
 		ret = vangogh_get_smu_metrics_data(smu,
-						    METRICS_AVERAGE_GFXCLK,
-						    (uint32_t *)data);
+						   METRICS_AVERAGE_GFXCLK,
+						   (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VDDGFX:
-		ret = smu_v11_0_get_gfx_vdd(smu, (uint32_t *)data);
+		ret = vangogh_get_smu_metrics_data(smu,
+						   METRICS_VOLTAGE_VDDGFX,
+						   (uint32_t *)data);
+		*size = 4;
+		break;
+	case AMDGPU_PP_SENSOR_VDDNB:
+		ret = vangogh_get_smu_metrics_data(smu,
+						   METRICS_VOLTAGE_VDDSOC,
+						   (uint32_t *)data);
 		*size = 4;
 		break;
 	default:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
