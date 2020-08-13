Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1097C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 04:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CDD120768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 04:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hg+bref4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDD120768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156176E1BE;
	Thu, 13 Aug 2020 04:25:40 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 866BD6E1BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 04:25:38 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id k18so3370130qtm.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 21:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PH8jNdAWKz9+rZ3n3Z6dxbhyEPb93rpC2pv5bqDUa9E=;
 b=Hg+bref4pAGvZGZqT3ahTgvBINqry5oLKfm2oe8/MtkiSRVJpIqVRMuOJW9Qf+vWco
 hLUexDVgv4w2VA0df09fp9Rxf3pYsToY7BDzMgBc5Wn9SpYWV8qcmV7+lZLfJRexEpms
 Y2i49s8+MpXIA/3be8nAhlxFluu6Z6NxqlIzzW5qDns0THCr/3m92zN+jAH+eyE6zPpJ
 zWsUSMznP5oo/RrON4s1Ra6S88pNgWhPErlryGMEnbJe4OXeCRJunO9DxKOhPAtRi4NB
 NxnRtR8W/u7sd+cJllaDK/FH9ANXs8hE55Uc8N2iPWEaYQI2ys3xpx2O3H25j+jY72yU
 iDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PH8jNdAWKz9+rZ3n3Z6dxbhyEPb93rpC2pv5bqDUa9E=;
 b=bpfc6gZxtYi2EIe6fXviLMp+/r4i+hqjJrs/QWzp/s6Hvqq+Q5hbPDLnsv+/HtONdq
 fu3uLtpNPGeuyFFUfiiCFlN0103ioUwoI0A8lZo0vHBt/qDL4+6F6OEUUkdMx6acA1rG
 luvvPkSNC6U6AtoNOTIr/Gn0JwY9/6ccGJWfUPuudPvn3O33JU2S8jH2vVRQH9rtp+B8
 7f5llnJqRM/6ZPpFZQd8A3QMt2mBwuYRwy9w4nl3Jeh3TwXjBw3FRzlTne6FjdqRV8pE
 KUd4wbrHKIvP7uLwEuac5CthtSxcUhKT7WW4U71Af4iFJPZPfogpad9qUE8nb+8qVapN
 cswQ==
X-Gm-Message-State: AOAM530/qBPRMKkccaVFyYZvB+6srMgN0Bk5Q8vF9cyjsCOTLTrvWbv9
 0YZ/l7y9gG/Dv8B8zwMfRrL3GCdc
X-Google-Smtp-Source: ABdhPJzoS9HkuoJHpNLulUsqxWLj23B4NG2x+BxmlUn4cBGrV+Umu+7NgLXD3TqiVsUQZVWeCMWXQg==
X-Received: by 2002:aed:2352:: with SMTP id i18mr3346289qtc.167.1597292737494; 
 Wed, 12 Aug 2020 21:25:37 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id d20sm4265414qkl.36.2020.08.12.21.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 21:25:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: drop log message in amdgpu_dpm_baco_reset()
Date: Thu, 13 Aug 2020 00:25:19 -0400
Message-Id: <20200813042519.4793-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
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

The caller does this now for all reset types.  This is now
a duplicate call.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index 2082c0acd216..1c661c7ab49f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1110,8 +1110,6 @@ int amdgpu_dpm_baco_reset(struct amdgpu_device *adev)
 	struct smu_context *smu = &adev->smu;
 	int ret = 0;
 
-	dev_info(adev->dev, "GPU BACO reset\n");
-
 	if (is_support_sw_smu(adev)) {
 		ret = smu_baco_enter(smu);
 		if (ret)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
