Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E305CC38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78662083B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugBijXJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78662083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B13E6E133;
	Thu,  7 May 2020 16:08:18 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 487906E133
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 16:08:17 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id j2so5192054qtr.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2020 09:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mFG1UoXIRmXjS2tTugoFk8427HX4disvCONCDHdAAsM=;
 b=ugBijXJPJQWh7QUvfS36eTYO1AJDKDy8JE0c+xkQe262OTEY58nCqe5zslPX9E7/Ct
 wW2nyGVvwuG+6NzPk8MFZIU7kgjwcgrKLDqnja/JVQEQs5zUuLjk50Ef/WhgMGhjk6og
 6ndaL8SaWqa2wjns/h0DX956+p3qWStKPKEaaIeuYwSF44SCgGIbSCzoA9SvOzlnU/tM
 R8F5oDnXy+ArqIGOv3/GGq7H9oXsceeFX6gAt3rBGAa2MCmzNMnp8kzlkFgH4VhhJaH5
 caJJDblw0gZHjNYtOqQxj52gZXdglMXGcg5lN8R5RrbQJU8oz83VNs+eolGCnATHIVMW
 42JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mFG1UoXIRmXjS2tTugoFk8427HX4disvCONCDHdAAsM=;
 b=WumncDkBuiR1RHErZQHCWQR1kBJ6oNaZ1vh01cVTLJM/97ur4Vq31yTZh7sbN/Jhov
 cYG8UHAhBfOuzaRFduDLFelGHreIzSLVELRdWZeRYX5qAVlZIKjgbDV+cQsOtjIFukL8
 GrEfiNe8uplCd0RX7tUwhHDvk9COs04BDVz7PbCps1zbb5QbJ3elnYudChT0HINf4kee
 AA669Rg/9cvTSOfhjfuZsIHeDbSNSUSJ1yPp9PUeda78JJTBXUe4GkrAe/TwtsVLURfi
 gIz3IpPBbGGDMOKZY6uWmj45hVDifJt9+dOqrNa+JZewXpnAaR1dn1IRusu/vFmKlwnr
 Ggag==
X-Gm-Message-State: AGi0PuYAiFhwC9gVNgp71Aeey5P4g1tdGwmW9C5tNQp9llYh/Ac7Jc4z
 RNP/jdOG2qVM5IqBhN8fPaf1OJ+d
X-Google-Smtp-Source: APiQypJZdH9yaL35jP4sW9ES9sgIuKKeZDPOufIQpRVphPJCCznTSYkejmHFGC6OoTE/LsvYqX/YJQ==
X-Received: by 2002:ac8:6e8c:: with SMTP id c12mr15068801qtv.374.1588867696176; 
 Thu, 07 May 2020 09:08:16 -0700 (PDT)
Received: from localhost.localdomain ([71.219.37.167])
 by smtp.gmail.com with ESMTPSA id d6sm3186567qkj.72.2020.05.07.09.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 09:08:15 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: fix runpm logic in amdgpu_pmops_resume
Date: Thu,  7 May 2020 12:08:06 -0400
Message-Id: <20200507160808.4250-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200507160808.4250-1-alexander.deucher@amd.com>
References: <20200507160808.4250-1-alexander.deucher@amd.com>
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

We should be checking whether the driver enabled runtime pm
rather than whether the asic supports BOCO or BACO.  That said
in general they are equivalent unless the user has disabled
runpm or it has been disabled for a specific asic.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0ca396d4ebcb..ea2b4254d30c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1174,10 +1174,10 @@ static int amdgpu_pmops_suspend(struct device *dev)
 static int amdgpu_pmops_resume(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_dev->dev_private;
 
 	/* GPU comes up enabled by the bios on resume */
-	if (amdgpu_device_supports_boco(drm_dev) ||
-	    amdgpu_device_supports_baco(drm_dev)) {
+	if (adev->runpm) {
 		pm_runtime_disable(dev);
 		pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
