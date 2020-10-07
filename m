Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309CFC47095
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD32B2064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZElZOfiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD32B2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EEC86E968;
	Wed,  7 Oct 2020 16:32:22 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D72F46E972
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:20 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id s4so3466788qkf.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R4WRSjhNKptS+5WBZXnyvAHc1nUM402wl+sQIFhe/Uw=;
 b=ZElZOfiymOm9qFX56pqKRlBOk+v6kwKlu5wKAXSCjgo/8AP7An8na3+kuIm6xsVIXK
 TqUTqDOYD81W1/vG5a8LYSOlrGsSS9BANqDpnGy4CBzjn187kwOtC6u2Ld752VvHQld3
 SA2eskfIoD2CLQyerjKdC/oFqfQQ2x4e4nGI2osMdIx0QbW2HefZiOC0JIcOEwW9B1BF
 07K8E8n2zoHuUtqRKZ2RxOLcbY363JOPP3KFqqDRRnHksTfaBYCz/tyq+z/RKmZxjGTn
 zUUl1CGIBKjn+iGcs4LyhWacFVQTP4oVKgvCzuMCe+JpyijkzOdc5J9Tqf+UkZiEa2UC
 yXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R4WRSjhNKptS+5WBZXnyvAHc1nUM402wl+sQIFhe/Uw=;
 b=sEPCbFVNabFHzJEC8DDdvmevIbgqqKdAwiV7DdVIWE9bzIDlqG7Zu1VuiGYpOAjlLa
 /g9dmzbAzVQ2izYRYjR/Jc9OBXgA1qVwv0JDGBCV2NjV95Jhdweda8ALcyhFRBVIDwSC
 2CcPV7hyQJGo27YoZ9Zq6s4jUiF6TDYcviHxYRh81cgQHilXHBAnv8tfTvwvG09jfbCS
 8z33bHw8jrMkl4abDTAAeAFwKT4RKxW59KgtbOHjwSLdtjgvlH/5XKrrdsKI7L/omM62
 P4oEdH8rdYd2oYtjX5EnOYWgBLE9pFnU0HMeCEP1PAK+HW/RLp8iq+GfiCEi8K2sLH8Y
 IrAA==
X-Gm-Message-State: AOAM532dRRvUT2cRPpLS7cYPgG+ieXb8UET7+pU/+Knr9SnS+iQvUaps
 VWHomUGzVjiM6IIXXqoziN7AkLXnQd8=
X-Google-Smtp-Source: ABdhPJxlTSlkaqEY99kGICrlSyxXSUs2NSTWTtN5GuDtrqBXKpINOu/fn8mEhawTpCUZqvkos6SKxQ==
X-Received: by 2002:ae9:f305:: with SMTP id p5mr1852288qkg.481.1602088339879; 
 Wed, 07 Oct 2020 09:32:19 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:19 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/50] drm/amdgpu: add gmc cg support for dimgrey_cavefish
Date: Wed,  7 Oct 2020 12:31:06 -0400
Message-Id: <20201007163135.1944186-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

The athub version for dimgrey_cavefish is v2.1.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 7710862f5748..f7a8417b2946 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1107,8 +1107,8 @@ static int gmc_v10_0_set_clockgating_state(void *handle,
 	if (r)
 		return r;
 
-	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER)
+	if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
+	    adev->asic_type <= CHIP_DIMGREY_CAVEFISH)
 		return athub_v2_1_set_clockgating(adev, state);
 	else
 		return athub_v2_0_set_clockgating(adev, state);
@@ -1120,8 +1120,8 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
 
 	adev->mmhub.funcs->get_clockgating(adev, flags);
 
-	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER)
+	if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
+	    adev->asic_type <= CHIP_DIMGREY_CAVEFISH)
 		athub_v2_1_get_clockgating(adev, flags);
 	else
 		athub_v2_0_get_clockgating(adev, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index e590c60cedaf..4ac8ac0c56c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -639,6 +639,7 @@ static int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		mmhub_v2_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		mmhub_v2_0_update_medium_grain_light_sleep(adev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
