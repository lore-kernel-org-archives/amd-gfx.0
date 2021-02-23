Return-Path: <SRS0=GAon=HZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DEEC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 15:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8272764E4D
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Feb 2021 15:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8272764E4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 146476E83E;
	Tue, 23 Feb 2021 15:22:57 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EEB76E83E
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 15:22:56 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id b14so16484324qkk.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Feb 2021 07:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Cc5DcHKGFnVlfx2wtYt3NsK9EpIWo1dpXnZzDaElpng=;
 b=NsKiAhnJewFsJkJfhXdufypAdCGhQw5VjgW3q/B1/HL/rIDkBWJ+JzgZ97ODV9zrVD
 Yq5xtsF87PY2FhcXwL2+xFl/lJI3ymZLN3j2q2MQH1QDvK/APywLQWAWJjRUr9JH6jkQ
 K19hEd+UfOsMtfbFSJpsFoEG+I/V1qmHtry4uT5GMHbTink4h5wy+kJM4YzzQRDc8jtO
 N6huQBOjTU4/Tr+r1kChuaVvirpww3Cm1aXNT2k+W3EKezwnXtwsWset/N8xZj1Svo1F
 W5dLnGyK882mWygKMRkA93Ufr26qF0mOeDgf7vTqSyZpSQjiIbOO721wHhPlbf//STDu
 S+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Cc5DcHKGFnVlfx2wtYt3NsK9EpIWo1dpXnZzDaElpng=;
 b=TMSFZbvmcLvLJyv1s/WWITudDZr5cVcdNr1YZV4yfK/ZwlK0rJ2dEsGKpZ0lU0WRZL
 VwPj21LZQEk0h62Makjq65Pq/WQKJuAZS+HJvoTYC1xUqpnqGl7K9FX3MVqueSOZBnrG
 4vNHPRPeSfShBEyWUfG7Sqi8qxSl0+tp/WC/gd0If0G7w7ZQov/2NoBjMwHbi4CYKtE+
 c6IjXWIpe6n07kWR7ClSngpJNf6VwQEThl9pAr762FEPSZlWyOzYPfLJJfR7PQKKui5z
 FZXulnOq/LwJpjcxqPjKRGRtY80RO/HFFaK7f87jPvayaRdlg2yK7x1ZzsrqBy0c7L95
 mt3g==
X-Gm-Message-State: AOAM5304auWtEF3a7+gCQiEhWaS4ZHxi+toye7bxghC7yZNnYHY7Ba4N
 bNm685FoI0QEjX/k/7xn3BGkj/v8RZ8=
X-Google-Smtp-Source: ABdhPJy2C3b00yDZVH9fpk7+6hEIb07m8BsjeHuHfPkEAdmMliCfpiX/KiMklEBLtZkgAySRa1jKWw==
X-Received: by 2002:a37:696:: with SMTP id 144mr26970807qkg.261.1614093775013; 
 Tue, 23 Feb 2021 07:22:55 -0800 (PST)
Received: from localhost.localdomain ([192.161.79.229])
 by smtp.gmail.com with ESMTPSA id s19sm2201303qth.53.2021.02.23.07.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Feb 2021 07:22:54 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/display: fix compilation when
 CONFIG_DRM_AMD_DC_DCN is not set
Date: Tue, 23 Feb 2021 10:22:39 -0500
Message-Id: <20210223152239.1323304-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Qingqing Zhuo <qingqing.zhuo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Missing some CONFIG_DRM_AMD_DC_DCN ifdefs.

Fixes: 9d99a805a9a0 ("drm/amd/display: Fix system hang after multiple hotplugs")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7a393eeae4b1..22443e696567 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5457,12 +5457,14 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (amdgpu_in_reset(adev))
 		return 0;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	spin_lock_irqsave(&dm->vblank_lock, flags);
 	dm->vblank_workqueue->dm = dm;
 	dm->vblank_workqueue->otg_inst = acrtc->otg_inst;
 	dm->vblank_workqueue->enable = enable;
 	spin_unlock_irqrestore(&dm->vblank_lock, flags);
 	schedule_work(&dm->vblank_workqueue->mall_work);
+#endif
 
 	return 0;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
