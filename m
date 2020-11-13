Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C0C56202
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D07C20B80
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ8WmeoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D07C20B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F39616E81E;
	Fri, 13 Nov 2020 20:40:48 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D10776E7D5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:40:47 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id v11so7667177qtq.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 12:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WfQZfYgNo9sPmBqXM0h4LaFYnDmUC+Us7ip2s9NeuGw=;
 b=OZ8WmeoSmDMc3LrkyiTnEtCAR7v/9SydXXJgpOJHsA08bOyEy+XQ00jZJBOhOl+FQ8
 kk2Ylcx5QkjFIm4RXS+COV9s+MYRpqMtEluq5fGIj6NjmUlPEgx8nQXNbT5WametfpKd
 6zNl0TujOf0pFv1eibESBf6V+bM3E6tuncUHtcqxySzO4+Oh6JjG7LLO98idkGXq1l6A
 OJVauHE45j48yCMRdxUM9+xkGC1x9VBAHhpmUw9x5GJNl6LuyO32TfHwn12n7RsMBeci
 0mXZnRmi+pGkSpuqizBfHtP5mERPgnQ/dot1PbvU8yL9FVkxamilB0lAuNoUZ8Zgexqy
 UVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WfQZfYgNo9sPmBqXM0h4LaFYnDmUC+Us7ip2s9NeuGw=;
 b=odS8a+P6dHncM2d3tps95ddcgCRalJaF85k2vNIpATwHjPSew1ACSoD6iOQzAsjZe4
 t5m9Vo9aJ4wF75kd9WcOudesMQ/7A5ZroAamxnDe+nCcBID6ShpexxSlrPhHw/R+KWcd
 eJ1SAtl2mpqIL7J/DIrzomWxk0jmanK1wKChzteS7R4yd+o8rMGd4AvrFIPkglIuOb4i
 ll4PXnwAkN8SjQuH+Kw33u3DF+zqenMwi2fDkw5RtJl1kUILrwG1R7v8+2isu6ogFCDa
 H7BxF53EzrDcowrslTAVJ9KRKbkxUT+JlBcU2AL0wlwSKiXOGqa33UGtFmZ1fTaYTuIj
 1a6Q==
X-Gm-Message-State: AOAM533KuD3pTgHynMonLWUog+0s+HLRU6/NZpqTcHjor3jxudz3nXcO
 D0qaHcm54S7kySA/jYKUPqRGZMgfys4=
X-Google-Smtp-Source: ABdhPJwjaaKKI2NyVTNETzWe6oSG0Dz1SkqnM9h1wavU1cy+d+0IFlW97LpeDZBZUjia/os1I1Fs4A==
X-Received: by 2002:ac8:5196:: with SMTP id c22mr3690742qtn.387.1605300046750; 
 Fri, 13 Nov 2020 12:40:46 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id y5sm4524026qth.53.2020.11.13.12.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2020 12:40:46 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu/swsmu: add missing callback for gfx state
 change
Date: Fri, 13 Nov 2020 15:40:36 -0500
Message-Id: <20201113204037.978207-1-alexander.deucher@amd.com>
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

The function was added, but the callback was not registered,
possibly lost in a rebase.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index c4e205c33aef..46c44f0abdfb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1177,6 +1177,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
 	.get_gpu_metrics = renoir_get_gpu_metrics,
+	.gfx_state_change_set = renoir_gfx_state_change_set,
 };
 
 void renoir_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
