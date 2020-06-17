Return-Path: <SRS0=VPxi=76=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E0EC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 19:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7A72073E
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2020 19:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sygSXlzW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7A72073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 731106E8E9;
	Wed, 17 Jun 2020 19:02:25 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ACC66E176
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 19:02:24 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id di13so1553328qvb.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2020 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NBWI19xMEepbMQDKMfUCiVo1xfGmEF4haVk/c+9fEoc=;
 b=sygSXlzWIsOjyWVSy5B7MCAgzkiJbZuvB+fm0ZiVynDkmFlcH7yRSGCXO6l4Vnpd3Y
 0BZfPYsPHJkyicump/nufEJcVLT0EqPvng4RYLuFBZYlX98Ua3pbG5oOwItS34Dsd5gS
 uizIlwC3NjiDmlXbGfQbC1U6oTW8zkIAsjcAVCsVhhC1lQuBUyuyf2D3SatYjg6M2Nke
 w46WjnqnJQ6Xh5Gb2j4BwK8dnhtWt3rOesmlCeEU9Kl2Oyia0wM03BPdAeJd1EX4Q/cq
 QZimd9Iea51P9v4CRG3SBFXay3FxDPhblTBt13F0d6DwI38YZX0wNqw8wS5MtsPyiG0o
 E0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NBWI19xMEepbMQDKMfUCiVo1xfGmEF4haVk/c+9fEoc=;
 b=n+RIt7CXur3U+yP55lAQgFaxlpZZ5grnXmNln8UEAWunPB2RzZ3GXTf9eCLGcd8bns
 n6iNrOeG6RTxIc2NFCkP3rOJB3ewMXYly7fUac7ucpc+XhejWbReHhfUa+wQtnQ3bBm3
 DdHT1yRdm7trELYeTtQc9Y5GHEOR08MBz63onjGyk64xU00c++xPSWE5nFYOJUpb9diY
 lFdgww4BfqRVfZGnZinkg92IuKG27rXXjqoYsbhvgikIL4PLB/P4lqazD/tstEAzW7t9
 k/99UnQP3WwoNhIbtM3UWWzX3gxa6BdjbvzAuGBlaTKdxGfT/FWp80pyM1+mcW8/sHNu
 f/0Q==
X-Gm-Message-State: AOAM533CmAsLBSNUuaPQF4c+lhz/WVzx/GoI1Gr1chs/uIUXqjDZSTvT
 V8wkUfi4RvhAPSvDA8OxAa2jhHlZ
X-Google-Smtp-Source: ABdhPJzDNzqQmkX8UHB6GrvKYN+rIj4v6pOYjNsyckIcMsa/IdzjFp2+hMZhjR99B3u7JbOF1nAaag==
X-Received: by 2002:ad4:4b25:: with SMTP id s5mr96549qvw.212.1592420543312;
 Wed, 17 Jun 2020 12:02:23 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id v59sm705056qte.96.2020.06.17.12.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 12:02:22 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu/fence: fix ref count leak when
 pm_runtime_get_sync fails
Date: Wed, 17 Jun 2020 15:02:11 -0400
Message-Id: <20200617190212.3519907-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200617190212.3519907-1-alexander.deucher@amd.com>
References: <20200617190212.3519907-1-alexander.deucher@amd.com>
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

The call to pm_runtime_get_sync increments the counter even in case of
failure, leading to incorrect ref count.
In case of failure, decrement the ref count before returning.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 8537f4704348..60b323d7caf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -755,8 +755,10 @@ static int amdgpu_debugfs_gpu_recover(struct seq_file *m, void *data)
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
-	if (r < 0)
+	if (r < 0) {
+		pm_runtime_put_autosuspend(dev->dev);
 		return 0;
+	}
 
 	seq_printf(m, "gpu recover\n");
 	amdgpu_device_gpu_recover(adev, NULL);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
