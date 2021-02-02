Return-Path: <SRS0=dhbh=HE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3949C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 17:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A9064ECE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Feb 2021 17:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A9064ECE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FFC6E22B;
	Tue,  2 Feb 2021 17:18:01 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6481C6E22B
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Feb 2021 17:17:59 +0000 (UTC)
Received: by mail-qt1-x830.google.com with SMTP id t17so15491306qtq.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Feb 2021 09:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=s2LpMzUHPVAJfeaFbJeM4L2dnt13kf2d8qe1sRF2d1A=;
 b=mAJ27f/0nylHPsi3QcSFOAhbND/tdAqjtaOYHwskzpLVagrUjPvyVMtRX7tLwXLv4X
 AZBYps6Y+g/bdf8zH9kn3GgL2iccDmomaIbOy3XqzpKbbB4IJEr3szNPhyv3y7pGS3G2
 hTM/VUphpsmEgcjoN0snUjme6xjZyrUMPdSBDUzZRHjNaV1ufzEOqK4JxBoip9Duh0q+
 qX0QRk55KpHgYpKciKgv8Gg8V3OcOELmU8ANxQL0tO64yp4xRV+sUT8RdhUdU6XUDJ84
 AaH9hkH4I+Kg65v+iV4u27/XrtXjyOP+SA8sl44UTORMCBxxmcSmpi9G4g0+HWcbzdJX
 +xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=s2LpMzUHPVAJfeaFbJeM4L2dnt13kf2d8qe1sRF2d1A=;
 b=tSJ1iZhc2PweBZHSFHk7Jht+sjm0EuR61H1bgNWhXaGoZnrOeslHU/lzWVigjHTCS6
 Bt6EiBUCeLRBbNWpprlc+T3Zk691/0EhdTgdmBg4/96GYfioHezQKZpg62cnXQLzVNwt
 EdziNrqPcLGrKkdeQ3vGfdyiRR1nxfNMYIBWJRlEb3af9lTyxlNuwdloxTX249mjzPqN
 rEOBrMW2+5XPewx7Iiwc74K1gPncaNdknnqDccFmifjN2vfQySQeYqIlGRfA1u9ttgl8
 5aOiphpy0StPvThULyhn5+VecvHz8P7Dik9umw6YI4AAGmio1MKswP9S4EwjqWGviAgE
 thCw==
X-Gm-Message-State: AOAM530qe7QGs8f6BAWZK9FV3gszsmb7w/3/93OWU9l8Jl8Ez/exCtK1
 0nEprjr6lyYC48PYoPtVeJslQUVlR8M=
X-Google-Smtp-Source: ABdhPJzIhKqLEgQAGqrOWpswm61qzbigu9BiMOJ6rDUcws/gQHw1KEP/3noErCulrxcSvloeqxNAkg==
X-Received: by 2002:ac8:7ca:: with SMTP id m10mr21513593qth.231.1612286278373; 
 Tue, 02 Feb 2021 09:17:58 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id q6sm9514981qkq.34.2021.02.02.09.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Feb 2021 09:17:57 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags
Date: Tue,  2 Feb 2021 12:17:48 -0500
Message-Id: <20210202171748.1062530-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210202171748.1062530-1-alexander.deucher@amd.com>
References: <20210202171748.1062530-1-alexander.deucher@amd.com>
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

Once the device has runtime suspended, we don't need to power it
back up again for system suspend.  Likewise for resume, we don't
to power up the device again on resume only to power it back off
again via runtime pm because it's still idle.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b4780182f990..b78847fa769b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -206,6 +206,12 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		if (amdgpu_device_supports_atpx(dev) &&
 		    !amdgpu_is_atpx_hybrid())
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+		/* we want direct complete for BOCO */
+		if ((amdgpu_device_supports_atpx(dev) &&
+		    amdgpu_is_atpx_hybrid()) ||
+		    amdgpu_device_supports_boco(dev))
+			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_SUSPEND |
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
