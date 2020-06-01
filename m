Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12107C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFAF7206E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtQJ+1Aq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFAF7206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A524D6E29D;
	Mon,  1 Jun 2020 18:04:02 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB8546E29E
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:01 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id fc4so470945qvb.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uZHO3LroGSh+4yCa7JHe5vFm14p4x5FW/BYUwiut7QY=;
 b=UtQJ+1AqBWi1oRfycHI2u0pI2cC9zAP9yWcNC5Pt9PTW4GnXEjCFKufWBAYzr9Obsd
 T1c1GLouY84uFya9A6j9drKLe+Ftx2Bz0iytCvX8CGLINp50v/axzDA0CQMxpDZCu5iq
 aZnjODPJ1EgvWG7KzFVup/mTMvAa24XY4SZQ7y32L4LPdXLkAFjZC/bACKi23LmgdvUc
 Kk9M/kN0QuwQ84OsPWPfPLmEvLv2ZJM4aN0HTXvqDSnBpnAOugZ5oypO8aYgibPr5Gqg
 zROdQZ+OT7POZUKqpEmCWpY+pkW1ucMBD82fiJuCd4Ky8sZo9Uz3yx2wK62rZtmoIJrz
 6tZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uZHO3LroGSh+4yCa7JHe5vFm14p4x5FW/BYUwiut7QY=;
 b=lkHV0NMM4a9J53Po+63tTSavtTodBR176MFGTZk7c8xohhkTVjO0o8ReWKMSP09N/h
 w0/AD9Xwz/54bHWbbic9Qt9/Du1qTQVEJ5k6eVSOvbQmMvHxIS3s3je/6tjcqHKlFAeX
 dl15E4q08KO60Z8Er10+AIVu4OqkTQK/k1UY7Gc74gNcd9ysAjo1zUlmfmaK91jt92ew
 Xj3SKUxhY4ueKk/WZ+B0rZy+seNYzpanPiv+keysm4REBt0GVyFfPPke0OW48YkWTmRV
 2zgOOXQc9qeuiyrizxfuYVdTHO1Gm+8451Szc5/Jg6QJd4w9XIer8FWHelttHeanmJP3
 G2zQ==
X-Gm-Message-State: AOAM533/vMxDmjIoa/SNwJqyV/mQW8SQFKqhIOYVQGAaAG016RssChua
 9MIdcDU6lxQSyIvJKbbsU3SjOa1F
X-Google-Smtp-Source: ABdhPJzECc57cxoRmCNT3RB7msQZUJXC9PuMZU17xTCvrN/OgoDw9thRJ88LP3av/WTU1KhOzhQ0xA==
X-Received: by 2002:ad4:580b:: with SMTP id
 dd11mr22364724qvb.145.1591034640826; 
 Mon, 01 Jun 2020 11:04:00 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:00 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 052/207] drm/amdgpu: add gmc cg support for sienna_cichlid
Date: Mon,  1 Jun 2020 14:00:04 -0400
Message-Id: <20200601180239.1267430-49-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add gmc clockgating support for sienna_cichlid.
The athub version used for sienna_cichlid is v2.1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 11 +++++++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index afca175a092c..ce2f72430403 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -48,6 +48,7 @@
 #include "gfxhub_v2_1.h"
 #include "mmhub_v2_0.h"
 #include "athub_v2_0.h"
+#include "athub_v2_1.h"
 /* XXX Move this macro to navi10 header file, which is like vid.h for VI.*/
 #define AMDGPU_NUM_OF_VMIDS			8
 
@@ -1078,7 +1079,10 @@ static int gmc_v10_0_set_clockgating_state(void *handle,
 	if (r)
 		return r;
 
-	return athub_v2_0_set_clockgating(adev, state);
+	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		return athub_v2_1_set_clockgating(adev, state);
+	else
+		return athub_v2_0_set_clockgating(adev, state);
 }
 
 static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
@@ -1087,7 +1091,10 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
 
 	mmhub_v2_0_get_clockgating(adev, flags);
 
-	athub_v2_0_get_clockgating(adev, flags);
+	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		athub_v2_1_get_clockgating(adev, flags);
+	else
+		athub_v2_0_get_clockgating(adev, flags);
 }
 
 static int gmc_v10_0_set_powergating_state(void *handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index b83a56d67428..af0866af63a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -461,6 +461,7 @@ int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
+	case CHIP_SIENNA_CICHLID:
 		mmhub_v2_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		mmhub_v2_0_update_medium_grain_light_sleep(adev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
