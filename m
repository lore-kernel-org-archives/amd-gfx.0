Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F04C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 01:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D6F206DA
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 01:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRaicaGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D6F206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156C26E2C7;
	Fri, 14 Aug 2020 01:15:46 +0000 (UTC)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA96B6E2C7
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 01:15:45 +0000 (UTC)
Received: by mail-il1-x144.google.com with SMTP id p13so7165307ilh.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 18:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K7VIr6aUz6jLLNe2EysFd5oqjvrc74mjotVluikRvDw=;
 b=WRaicaGXvLkfjTddb2jJqSR5wmXUQuYVv1wzTDauAwSQWDr8MO9u9fn6X5kI7yWvk6
 CPtqNQfpg2q0gPe2wdBMG7kPMmY/ogDJPkDivY7NI0Ea2EPVFSCzATBy8GJUQZI6M9iv
 fP9OR+u4hCpUvqA9hHDJjH3Qu0LRDwp4xXP1ECarzM5JaC1iGn5ePBiq+d3oscRHHhGU
 Q4Qd4tIV2FrdfaFdzbMm/fkjUZ+I0yTrZ6AK7EFSpwhJNMpUUW9XnaPD4nQGZrEfATtg
 g9CcW4pMOUbU+LkT66I69vz+aIY7ei+xIRFYvSzf6zV7E7epH7alQyWTsRxwtMCJJgZa
 Xrfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=K7VIr6aUz6jLLNe2EysFd5oqjvrc74mjotVluikRvDw=;
 b=LL+Y4FkO/yVQbY05OvbbIEI8ryyqaR42+lzlWK7u5oFiBgvqrMeEbqngYJmOO+exmk
 2ldCvHCgQLNb43/be0+kLzlaqwTao1lAdYeR9ti99eb14ruIksw4dXxBZYxaMh++m2tz
 qmtNo8IQCxgNMPh+nu5EjKFx3i/LEolikEv7jEIwhi/UIj5J74i4eoozo8f471y2nhHJ
 4XvCurQJq3kJ3hBk/Hz4L92bpHES1zaNbrRW9ITOPRujllJwU5pCHzZZV5RVsJ9ZVLo6
 gybkWf9ql+YqAsBBl1xAyZS1pL/8AjpC25Wzh/ZGtnpuQjmbnx2FM62bbiYLGNyDRCRM
 3hiA==
X-Gm-Message-State: AOAM5321aTkIpbRtjP4bP6+/qq8zEIk740lx62QOyUm3tbCTbPlMgj3j
 d2oyC+613idNfMQGmqXgR4lbwWYb
X-Google-Smtp-Source: ABdhPJyFZ6gGvHCfutHX8YtYNd4Mn0+MvDfglq0z9LDfSLqSCGGpuo7REQ1USH4T5flrgxYQ1llqeA==
X-Received: by 2002:a92:c0d0:: with SMTP id t16mr482673ilf.225.1597367744566; 
 Thu, 13 Aug 2020 18:15:44 -0700 (PDT)
Received: from mcoffin-dev-tower.ec2.internal
 ([2602:4b:a6ae:c000:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id o62sm3632934ilb.38.2020.08.13.18.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 18:15:43 -0700 (PDT)
From: Matt Coffin <mcoffin13@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs for
 pp_od_clk_voltage
Date: Thu, 13 Aug 2020 19:15:28 -0600
Message-Id: <20200814011528.10862-1-mcoffin13@gmail.com>
X-Mailer: git-send-email 2.28.0
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
Cc: Matt Coffin <mcoffin13@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The changes in edad8312cbbf9a33c86873fc4093664f150dd5c1 introduced an
issue with the sysfs interface for pp_od_clk_voltage. It overwrites the
return value to 0 when it calls another function, then returns 0. The
intended behavior is that a positive return value indicates the number
of bytes from the buffer that you processed in that call.

With the 0 return value, clients would submit the same value to be
written over and over again, resulting in an infinite loop.

This is resolved by returning the count of bytes read (in this case the
whole message), when the desired return is 0 (success).

Fixes: edad8312cbbf ("drm/amdgpu: fix system hang issue during GPU")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1245
Signed-off-by: Matt Coffin <mcoffin13@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 1705e328c6fc..f00c7ed361d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -937,7 +937,11 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 
 pro_end:
 	up_read(&adev->reset_sem);
-	return ret;
+	if (ret) {
+		return ret;
+	} else {
+		return count;
+	}
 }
 
 static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
