Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0765FC433FC
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5EB8223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0wJ+Hmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EB8223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9AB46E844;
	Tue, 14 Jul 2020 18:24:36 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52EB6E844
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:35 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id r22so16479400qke.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MwumQPOooRJK1774BEU/JDj4ikcAtZMyolSgGf2oupA=;
 b=o0wJ+HmvpF/duWUVabx4HNgfNkeumdcImi/HgX2OkxhDzXAxUg1hkfxdIRPnF/Rr5e
 RWo8+c5Yj3QVal2AwNgl0E4OdcyqW5C3xjBIdWX1l/GC4uxEVwdM9KbnUgtbVjdSVOYG
 lNDBAzm9IWwyHLLfpazgH/0NnMkUMlOjZ1S6fnzQXa9MI9lR+WGp8Yz0GSR3uXu1zP33
 X/o+7JJPOvEYD5c/qCdcDLViSkUWDo2d7HadorG1amyoUNHjav54mWaDZ/h5/q8hNYa+
 Hj6SuavRLpZ67H1O9OBHBtqziOxH5bMuc1mfkzKo4NGLas5hhaH5eGRYqutraQRz4cuZ
 9DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MwumQPOooRJK1774BEU/JDj4ikcAtZMyolSgGf2oupA=;
 b=jKf6u7pqSedX4TysylKsok0SFAMfsBqZZnGefvioEddXM1eObw3F2WzX5pvy2Cys42
 p5vuS2+Z3s2ViVIugDkudfOkv4rDFESn0yL45g78jRC2VrVP/Lku6BfeQ27bTN02dyc5
 fURfsd4KgOkCO1Y60BOOgaho0HtfkMGzB4s0PVGWL3bMR+WBTWncg5t5HdUtclJRUbul
 Iuo4aweV//5ysPV1ZIs0quXIfOxonbMYS4ehrsMsxgUvoySOdknt9RcTkcD+nbKSXPxX
 lFV4j2FhaXokIzxS8x4XrV18aVTZUtr54m0Ov/KYtdBtjmZp4CXPVQvrG8hwRfKKITdF
 03Uw==
X-Gm-Message-State: AOAM533BqSToikVnVnTglKa1ikd47mnPoEj+9xfGdyu0EXnU+JF7QJaj
 kjU0MHjSDfGKycCPsk5UDSYkJ9nj
X-Google-Smtp-Source: ABdhPJycVbJvXjOoAg7GwX1BNvyqxWyEyGqFadZIcSTbWYtUiVRnz7qhqpJVEBbXUm6/821GSBk45g==
X-Received: by 2002:a37:4050:: with SMTP id n77mr5776475qka.431.1594751074674; 
 Tue, 14 Jul 2020 11:24:34 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:34 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 20/42] drm/amdgpu: add gmc cg support for navy_flounder
Date: Tue, 14 Jul 2020 14:23:31 -0400
Message-Id: <20200714182353.2164930-21-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

The athub version used for navy_flounder is v2.1.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 55fedadd78c6..ec90c62078d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -1125,7 +1125,8 @@ static int gmc_v10_0_set_clockgating_state(void *handle,
 	if (r)
 		return r;
 
-	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER)
 		return athub_v2_1_set_clockgating(adev, state);
 	else
 		return athub_v2_0_set_clockgating(adev, state);
@@ -1137,7 +1138,8 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
 
 	mmhub_v2_0_get_clockgating(adev, flags);
 
-	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER)
 		athub_v2_1_get_clockgating(adev, flags);
 	else
 		athub_v2_0_get_clockgating(adev, flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 5500f9d8d18f..757fa8e83f5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -482,6 +482,7 @@ int mmhub_v2_0_set_clockgating(struct amdgpu_device *adev,
 	case CHIP_NAVI14:
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		mmhub_v2_0_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE);
 		mmhub_v2_0_update_medium_grain_light_sleep(adev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
