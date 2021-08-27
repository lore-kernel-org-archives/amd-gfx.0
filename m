Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BCAC432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 19:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D03C60F39
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 19:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D03C60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301006E9B2;
	Fri, 27 Aug 2021 19:06:28 +0000 (UTC)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD9B6E9AE;
 Fri, 27 Aug 2021 18:59:16 +0000 (UTC)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net
 [80.193.200.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 55A493F0B8; 
 Fri, 27 Aug 2021 18:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1630090755;
 bh=z7f03Sa4CCURuujvzK1MHTPz7baSRU44/y891L4NA0Q=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
 b=pj9RbSMRCtpUrJwJPi9lYfFXOhFAhSpw//ztg0Nb0qNHt9wZCC4fZbilnKxbnWOry
 UxYO2SjZePd4BhCOjCM5ri/a8dO20qwj5qzs41V8nvl7iUHMc6Ro7D5w8SEDaPf4Cr
 GO7AG77xzK3ZZdIOJWlKmgBJn/gjVv63yOToWJI3FBh0jN4tLpUAKxEGPYuKeSKRFe
 ej/IBwc/J2NChP5bB9MGQBkzqhm1y76ceYayNkZidrXmHui9yZHvOBBlHFsGcsDNlw
 GnUo0FDJM2WJTRHNmfOHyJkD9AFSlxDbCx4G2wlX9YEHRTcAhsW0VXLUcfBPc3rECq
 RpgGzSzbQeW9g==
From: Colin King <colin.king@canonical.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui.Pan@amd.com, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/swsmu: fix spelling mistake "minimun" -> "minimum"
Date: Fri, 27 Aug 2021 19:59:14 +0100
Message-Id: <20210827185914.507508-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Aug 2021 19:06:27 +0000
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

From: Colin Ian King <colin.king@canonical.com>

There are three identical spelling mistakes in dev_err messages.
Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c     | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c      | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index ad52f7ecfb87..629bb8e926fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -1869,7 +1869,7 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
 		} else {
 			if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
 				dev_err(smu->adev->dev,
-					"The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
+					"The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
 					smu->gfx_actual_hard_min_freq,
 					smu->gfx_actual_soft_max_freq);
 				return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index b39138041141..5aa175e12a78 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -426,7 +426,7 @@ static int renoir_od_edit_dpm_table(struct smu_context *smu,
 		} else {
 			if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
 				dev_err(smu->adev->dev,
-					"The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
+					"The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
 					smu->gfx_actual_hard_min_freq,
 					smu->gfx_actual_soft_max_freq);
 				return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 0f17c2522c85..627ba2eec7fd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -731,7 +731,7 @@ static int yellow_carp_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM
 		} else {
 			if (smu->gfx_actual_hard_min_freq > smu->gfx_actual_soft_max_freq) {
 				dev_err(smu->adev->dev,
-					"The setting minimun sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
+					"The setting minimum sclk (%d) MHz is greater than the setting maximum sclk (%d) MHz\n",
 					smu->gfx_actual_hard_min_freq,
 					smu->gfx_actual_soft_max_freq);
 				return -EINVAL;
-- 
2.32.0

