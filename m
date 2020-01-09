Return-Path: <SRS0=R6+d=26=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8347C33C9E
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 03:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAEC62067D
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2020 03:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V16pXXGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAEC62067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A8356E388;
	Thu,  9 Jan 2020 03:16:12 +0000 (UTC)
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630266E388
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2020 03:16:11 +0000 (UTC)
Received: by mail-yw1-xc41.google.com with SMTP id 10so2185519ywv.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jan 2020 19:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K68CB38cbbMojYT5lMjJs9RA6dYriYrYEKkuyJ8CFDM=;
 b=V16pXXGSsCEStGvze7dfkXA7v21GhnrJ5woi31hEKfPxPDTAwGYuZFVeGSILJQoT0h
 BxQvEFLGy2++vCGYyBAl2CxrzlEzM5Qr4YBnVzVUovm3VCc2xpNxg1+tt6NZiggsE5Jn
 ch+mFUzZ1hhfYDIl+LBzZa490bqdMvAPOgGzy4WbZfRIivR1d5CEBHel0vQJgbZ/YYzS
 LhpCvsmf574CHeN8rOQRvuTHS7NikC2eKOPm5B6rIrloxSavo9fruRjuj/jS7+CEtjAL
 y4PJ4BGVIq/iuRgBsECLW+jE+0OgE/F7AxT+xtW7lkw92PUosw2Kmtc/4SBmsgKcGe/R
 7lXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K68CB38cbbMojYT5lMjJs9RA6dYriYrYEKkuyJ8CFDM=;
 b=n9yvECkhaZpyBZKNEkL+aQyL67SqqxLNg778FoN1IGqu7xHgtrguXQfSN4xnTyDjNT
 ta/RZJY6qLzzYbfg+5/chMnfOkrc3tWxNFRbdMIF0fC3kOsbXNy+qtHICV8j65IenlIp
 lSY97+BQNw4cxuTyXUQ6O1ZNhyANy67buVXvA5Rd61xIgZuXokfAI9ENE8kViepuwHVN
 AgTvEOnq9R9qdYMaDtrlUghKU5tUtrOBQG19rdNrHEdJ96g5UK80GK/XoRrG0h3NM0DS
 hNREL6YfYS/aq5L8yDM4etVhwsQwJOv7LWL9XHXu5EaTXftIcrlS4HDANsdJhxuHhHvS
 YmcA==
X-Gm-Message-State: APjAAAVlTRNfE29VXvOUd7fbfuNy0ZmIawZS7TigOBWA6S0d1M14wkTA
 Ja6DqBWQrSRnBRXc2H0qP5fStjT8
X-Google-Smtp-Source: APXvYqwUQN9Oo/sYNOSfymTNmoCciBMq/LSp4yukqugxIPCm/fnMEdQV3b3HaO/39mnxIIQMGSU7TA==
X-Received: by 2002:a81:415:: with SMTP id 21mr6167464ywe.432.1578539770387;
 Wed, 08 Jan 2020 19:16:10 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id e187sm2464973ywd.7.2020.01.08.19.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 19:16:09 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/gmc10: remove dead code
Date: Wed,  8 Jan 2020 22:16:01 -0500
Message-Id: <20200109031602.343800-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

Leftover from bring up.  We look up the actual pre-OS memory usage
value later in the same function.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 7dc8c068c62a..faa310b76b50 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -736,15 +736,6 @@ static int gmc_v10_0_sw_init(void *handle)
 	 */
 	adev->gmc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
 
-	/*
-	 * Reserve 8M stolen memory for navi10 like vega10
-	 * TODO: will check if it's really needed on asic.
-	 */
-	if (amdgpu_emu_mode == 1)
-		adev->gmc.stolen_size = 0;
-	else
-		adev->gmc.stolen_size = 9 * 1024 *1024;
-
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
 		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
