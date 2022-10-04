Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FFCC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Oct 2022 13:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5449A10E5FC;
	Tue,  4 Oct 2022 13:11:20 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E637310E18C
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Oct 2022 08:14:54 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id d6so5905463lfs.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Oct 2022 01:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bell-sw-com.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date;
 bh=ytTaJNbSesq9NlfGsMtZmuKLx/97tJRkLOeMKZt3OJI=;
 b=GbZdVI4XAPTNIDiHmxgeGvv6e/LIxTL7euq/xwEEKJDtAOWIV9YUo4irDIY0L8Ph9u
 lihGNO8kKatkjx3cIRTzsWESDY4bXDrLKZL9YHYfXLLu4KFvmQNENgfrayB63hcvLhxB
 x2UeT9VZtHXvSr0kEAny2YowRGc2uy8/mElWKejk7O/T92GKrjKaoH9zcL3sELBD/inV
 pG4dD774HMpyWkR/JiRwYvOqzhvU5PhbB9/AuMaZuFtPuEJYF4teI+DIPfU6KGQyGuLt
 RmxyCSFF/C/w3g66nIkxtv/aXc5Qzg5tOx07eWY5+95MLNDMLsTQ25lkHKrvqdE/l0jz
 /95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date;
 bh=ytTaJNbSesq9NlfGsMtZmuKLx/97tJRkLOeMKZt3OJI=;
 b=swTFPIX+3gq/CRVzQVzfH8XLLSMZ28cqrYAcOeNI0K2X/AKiG8fqQXwbmkowAWebbS
 fhBLzweemg/eJWoOMzQ3HmEaaQTR5EBxkJi87p92LTjCqQnDrMTW+wXTCr0HLIJ3/0NN
 I7ydsG8WLj4uNcQVPWdF059650PkvtuibmFaUWGwj153F3g6a1FRZNEX0zwFvkaamyEn
 XRRmXXwzIn5t9oygvImCdm4AoUuvNLhWAjjCtTDwgKKODSNt6iqrhdSs1xhZLd1olqOL
 RntODwUbE6CrLt5wm+sOLFW1TLwfjrSQfyF51oKn5DHLU0tNPnfap3CeBr6dr5eVqany
 8HUQ==
X-Gm-Message-State: ACrzQf2ckBb8mEUz4Duc4caUtcvcW7ZdUsvB0KJs2eqUwGpdp9z7pkTb
 lwb1STCeZdd4v/R2LSss1sK1U7v+lYmf
X-Google-Smtp-Source: AMsMyM4DFXwX8exdphkc5MAvJZEbHr8uvwc+GxbO3pmD+Ce4yh2hbgRT6NCBYVsX8AZX+dTTXKw20g==
X-Received: by 2002:a05:6512:3d1a:b0:499:c00f:d95f with SMTP id
 d26-20020a0565123d1a00b00499c00fd95fmr8760591lfv.575.1664871292561; 
 Tue, 04 Oct 2022 01:14:52 -0700 (PDT)
Received: from localhost.localdomain ([95.161.223.113])
 by smtp.gmail.com with ESMTPSA id
 cf31-20020a056512281f00b00492c663bba2sm1808982lfb.124.2022.10.04.01.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Oct 2022 01:14:52 -0700 (PDT)
From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: vega10_hwmgr: fix potential off-by-one
 overflow in 'performance_levels'
Date: Tue,  4 Oct 2022 11:14:01 +0300
Message-Id: <20221004081402.49069-1-aleksei.kodanev@bell-sw.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 04 Oct 2022 13:11:14 +0000
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
Cc: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since 'hardwareActivityPerformanceLevels' is set to the size of the
'performance_levels' array in vega10_hwmgr_backend_init(), using the
'<=' assertion to check for the next index value is incorrect.
Replace it with '<'.

Detected using the static analysis tool - Svace.
Fixes: f83a9991648b ("drm/amd/powerplay: add Vega10 powerplay support (v5)")
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 99bfe5efe171..c8c9fb827bda 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3155,7 +3155,7 @@ static int vega10_get_pp_table_entry_callback_func(struct pp_hwmgr *hwmgr,
 			return -1);
 
 	PP_ASSERT_WITH_CODE(
-			(vega10_ps->performance_level_count <=
+			(vega10_ps->performance_level_count <
 					hwmgr->platform_descriptor.
 					hardwareActivityPerformanceLevels),
 			"Performance levels exceeds Driver limit!",
-- 
2.25.1

