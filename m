Return-Path: <SRS0=LS4N=HH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F99C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 16:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589CE64E35
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Feb 2021 16:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589CE64E35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92BA46F482;
	Fri,  5 Feb 2021 16:15:43 +0000 (UTC)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B72F26E311
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Feb 2021 16:15:41 +0000 (UTC)
Received: by mail-qt1-x82e.google.com with SMTP id x3so3426999qti.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Feb 2021 08:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SnsaVs3yj7V6me++7B+upwy0Wfv3gAfiqlqzB/LwrTY=;
 b=Bpe5FzByTSZUPNCnb3drjCElM0z70LRcfRJGlxlBv3dRHLcYHlCo2N6NmsYO8v4vPw
 lWZ5XlKg4aoKZ9DCBaPsY8rY17G7+jniyLr0KpZVn69TfP4hIc5dSw2mSBdFYOpGv22R
 cWREWqjvjGvATFId/rviMwLtADHvBfMc5yZMnzenkvNlxMZZjQfNG7rf7CBh+PCvu6qA
 hPnv7Sn4zvDi7oZeO8K1xihMM3Zrp35ppYLatsTN4AGi0p0amQMLWqITauy2e76rrERw
 Un5lMwxk8/jmWKF7xeKn4LgWSnqwEAQSsTN1WZNaKBDHVEQ0TvIf7DYi1q3S+K6qBchu
 jfDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SnsaVs3yj7V6me++7B+upwy0Wfv3gAfiqlqzB/LwrTY=;
 b=XiBC7Jdgp8PBlNNikWu5m6qA9UoQKmg86bWXzL2hoM33y5j191/GdL1YpCHT91i2j1
 spyujKZ2+3I0Zi08V4Q05vTPMEq9S4AepAM9TKPu+g+z8WjA+2iHKyJbV1LIx5CK95hy
 KF2qlcFvFRVyaNoBZfUQFUaPfCI77J2e8IbSExH0KmIQq3LW+R7a5NocYXT2HFT2Spcj
 Y1ptryFoW9gmrNmFkiOseLMkMOG2jX5F5Zp6Cnv1Dp17/xjJrQ4DtIB8h79swOak25xR
 N2R8qVvQ3hYgoIhcQ8yN9BbrrXr098CM1WUsrQmQ4aQubP1OXGut72TWKOfJG1xX5hIh
 EzgA==
X-Gm-Message-State: AOAM533tfkwbz4r0dDh2mBl4SjSd1XkxyBjFuQXaiUVjLIgc7yXRcKNm
 6ne817XQoyA4L9E+7hVyyJH8EY79EvQ=
X-Google-Smtp-Source: ABdhPJzhWdwiFHWpAKTX/x2UCefwyPNJ4Bp/5d3sAjeVdFvmyHH62OOxE7qDpcw5/Wgjd4/4hTV+HA==
X-Received: by 2002:ac8:590b:: with SMTP id 11mr4983473qty.114.1612541740427; 
 Fri, 05 Feb 2021 08:15:40 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id o17sm8636947qtl.47.2021.02.05.08.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 08:15:40 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags (v2)
Date: Fri,  5 Feb 2021 11:15:28 -0500
Message-Id: <20210205161528.37055-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210205161528.37055-1-alexander.deucher@amd.com>
References: <20210205161528.37055-1-alexander.deucher@amd.com>
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
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Once the device has runtime suspended, we don't need to power it
back up again for system suspend.  Likewise for resume, we don't
to power up the device again on resume only to power it back off
again via runtime pm because it's still idle.

v2: add DPM_FLAG_SMART_PREPARE as well

Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com> (v1)
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b4780182f990..94672b5c2776 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -206,6 +206,13 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		if (amdgpu_device_supports_atpx(dev) &&
 		    !amdgpu_is_atpx_hybrid())
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+		/* we want direct complete for BOCO */
+		if ((amdgpu_device_supports_atpx(dev) &&
+		    amdgpu_is_atpx_hybrid()) ||
+		    amdgpu_device_supports_boco(dev))
+			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_PREPARE |
+						DPM_FLAG_SMART_SUSPEND |
+						DPM_FLAG_MAY_SKIP_RESUME);
 		pm_runtime_use_autosuspend(dev->dev);
 		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
 		pm_runtime_allow(dev->dev);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
