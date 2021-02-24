Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE19C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 17:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1680264EDB
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 17:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1680264EDB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0EFE6EB0E;
	Wed, 24 Feb 2021 17:29:09 +0000 (UTC)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565456EB0E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 17:29:08 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id q85so2907778qke.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 09:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rJLg9gk4Ov2DNw9Xo8N0mIRi2VyyG5iJV2enlwINbBw=;
 b=ljiKRKzVbesd1xxKHLrGBbZu6gPE7ZL2uRXX0eoogLiRdwvnkiOVBuvuLYiGkdf2YX
 Ucog1osimlRW9Lc9NirgnxrheGbdzXXW5vicD+HCtMns5ipXOgxSqAc1UDiElV2by5iy
 onMpFhGKxXgN74WgLm980cNL40xQfKTWmDCI+yo1nlvKPWvWb3JapbwmbhDFm9QiA/1V
 x2MmOzK+meVKgJSP7j95Zm7w38PqB7N5si+QJsqzk2vzwpTeK4GGQ+Gu+Knfh0/RS0aZ
 69TDeiYZA63bvab4e/hOBuDyPc3O/CmBgE6vs3AecwBDDoJ7ojkyF2Nvy3FWdmTSQ0le
 4rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rJLg9gk4Ov2DNw9Xo8N0mIRi2VyyG5iJV2enlwINbBw=;
 b=S2aj+gzNoDoeAmvPSfT/T6aY3uHOK2VJ5mL+xAxtskNxJ3S/cmHBHYkZCpzSkjlE1x
 718KiyLlI7NBmcUIsZMRwHi7oOGl01hPDaE1HENyvDtRRz9IK6SJ5Du+joGcx5Yok0Tn
 cuK5eVpM1jXKEo74c1uArK5b1NurVU115XiaBmzy8rT/E4AQaPcA3/oJL7b2WhDD11ok
 nYFcqe8zychg0GTwSDhE6rCh5Az9hKmRS0++w/wjyKZ8lh2akEGRZD6igmhONiBbDwc7
 4h2AN0DLxAbngXjLRey+eCkS9fHvh892bv0gYMGKro8hsIyzfa7oCuyTwE9Jl2EcXjLQ
 iX4w==
X-Gm-Message-State: AOAM5323lGd5pEcO5P3ZJ0qTS+LPh7LSVhsypCR8lkE7mahPwrrsHfkW
 RhYSIwhYM0QlpJPm7HOCwLpnSjDGSVw=
X-Google-Smtp-Source: ABdhPJxsc5g6mgN+U87/VfUbKX94aRshQ6llOnC5c+PSdMloYRIlAh8y5HBXaVlZiMK8ZiKirx9Y9w==
X-Received: by 2002:a05:620a:7d5:: with SMTP id
 21mr28463988qkb.152.1614187747177; 
 Wed, 24 Feb 2021 09:29:07 -0800 (PST)
Received: from localhost.localdomain ([192.161.79.246])
 by smtp.gmail.com with ESMTPSA id 80sm1994698qkm.45.2021.02.24.09.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 09:29:06 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: make unsupported power profile messages debug
Date: Wed, 24 Feb 2021 12:28:58 -0500
Message-Id: <20210224172858.2779680-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

Making them an error confuses users and the errors are harmless
as not all asics support all profiles.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1488
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 45564a776e9b..9f0d03ae3109 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1322,7 +1322,7 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 						       CMN2ASIC_MAPPING_WORKLOAD,
 						       profile_mode);
 	if (workload_type < 0) {
-		dev_err(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
+		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on arcturus\n", profile_mode);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 7b7ae5532ddb..fd5539f8b53a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -810,7 +810,7 @@ static int vangogh_set_power_profile_mode(struct smu_context *smu, long *input,
 						       CMN2ASIC_MAPPING_WORKLOAD,
 						       profile_mode);
 	if (workload_type < 0) {
-		dev_err_once(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
+		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on VANGOGH\n",
 					profile_mode);
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 9a8b1a1e148e..c9f766cbe227 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -826,7 +826,7 @@ static int renoir_set_power_profile_mode(struct smu_context *smu, long *input, u
 		 * TODO: If some case need switch to powersave/default power mode
 		 * then can consider enter WORKLOAD_COMPUTE/WORKLOAD_CUSTOM for power saving.
 		 */
-		dev_err_once(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
+		dev_dbg(smu->adev->dev, "Unsupported power profile mode %d on RENOIR\n", profile_mode);
 		return -EINVAL;
 	}
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
