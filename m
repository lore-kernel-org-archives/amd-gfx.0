Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB18C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 21:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FF32065F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 21:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VE4hIc5J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FF32065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5551C89F2D;
	Tue, 19 May 2020 21:10:17 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5701C89F2D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 21:10:16 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id d7so840075qtn.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mJkpc7veK+NtuK/XrzEvDniisyfP5m4byf4KQ7qK6nU=;
 b=VE4hIc5JXjSvjLHUQMoF/nDflIfjzhK67w+4XhhAKWkbe2YwSwXHnpbHs36MtlVzFT
 i8SWRNpVOjukzm/4QiuYtTkj4ewPiqgYtAbzRDO8fyKvdS+7d+GLmJnq3VWDgklVLxrX
 7/bWDzYhG2GrtFvL7gtMdSxVe4DVg4s3Ah227XbVcafDm8qTOhLlddCD84RXwQNP69Li
 gwDhwdO6BrPHMsuX2T1i+O4aTowyErQx3sXjdrxzhNCWguRsx6xDUgmerQXKfU3+oBcu
 IGJJHHXCDijtBNkqyWxm0I4ZHaNFlKV+ubnh3QwbAZ4Mm94z+/HdSvSx9KWfyaFzG232
 0+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mJkpc7veK+NtuK/XrzEvDniisyfP5m4byf4KQ7qK6nU=;
 b=m0h1yRtfZtx6fpZL5l7jV7guMnlu9p6GBgDgV1fPEVocSg6S4hcjMYRlBPCP7KO5Pv
 y2N/xioY0WkJxy6wUnb3RylAQWihivqKvJzb6h3AbI2hyByI0QVaZdSzYk7Ws+kvVX5m
 2Hvaq3QIzy1+mHwFPx6hvL5yw3tgp8aPcU4akjmn1RVphLQrRM21xmK8RJuJptTjy0N4
 lifcdBRBg2aUgPaOA4JuWMJvv4YozlVMiaw5ZSfcaY0MNVKO1PWgTrP/RwK6ZDAvKjsX
 ly3KrKRXR55Sb9xkkrDDlKMxwEBfOJvkm6+c7U2IoTxWr6ckC9cF2cyGE68u4R5jkarg
 Hkzg==
X-Gm-Message-State: AOAM530DbU5QI1sQTAj0v6Ge7V+a7fv/iw0VbEDtUv8iv/oJg/qX+JLU
 Jd4fcx4isgqNC87Mkyvcj0+tjQJf
X-Google-Smtp-Source: ABdhPJxgCr9CzFktCHGeHw8VgJX7dYcKJwSdxkas6jY1NE4NvSQiENRFQd6YK0fZV0u5QgNqSjv7ig==
X-Received: by 2002:aed:3ea1:: with SMTP id n30mr1909162qtf.31.1589922614884; 
 Tue, 19 May 2020 14:10:14 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id 21sm576176qkv.126.2020.05.19.14.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 14:10:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: improve error handling in pcie_bw
Date: Tue, 19 May 2020 17:10:05 -0400
Message-Id: <20200519211006.80492-1-alexander.deucher@amd.com>
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

1. Initialize the counters to 0 in case the callback
   fails to initialize them.
2. The counters don't exist on APUs so return an error
   for them.
3. Return an error if the callback doesn't exist.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index bc7de2f62d12..72bbb8175b22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1646,9 +1646,15 @@ static ssize_t amdgpu_get_pcie_bw(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = ddev->dev_private;
-	uint64_t count0, count1;
+	uint64_t count0 = 0, count1 = 0;
 	int ret;
 
+	if (adev->flags & AMD_IS_APU)
+		return -ENODATA;
+
+	if (!adev->asic_funcs->get_pcie_usage)
+		return -ENODATA;
+
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0)
 		return ret;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
