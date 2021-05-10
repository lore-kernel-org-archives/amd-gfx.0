Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E337C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 09:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EC486142D
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 09:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EC486142D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gatech.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97A1D6E448;
	Mon, 10 May 2021 09:31:19 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABBC6E448
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 09:31:18 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id 1so11463297qtb.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 02:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hqKZErfDTVgnRRLW9tni03vbMIZzey8Ak61d8VcBQg0=;
 b=t3Frga+Y7fl4Nz7XNWMdX3fjm022xmD8gV18HBBIeQNEmdm4nCrEkUQqYSf7/wkDSp
 p88KDhcxPdfcaQ8fgj3jaG8PU9//sCp40uBjx7rY4qLApwx7gTgUIeJAHd7FU6pOQxKX
 ZfgttFPB0t/JPl5/26flfzATtyA/ZRfwW494djDcenbe8bXUlpWUBIi9bScfU62DjbaH
 ltPKDLgSrB0PTqQOtTvJlputjho5Jz2s0vGnKL3ktKy2YCi2MbBJwKrPzugfjtKtMlBt
 FeN+s/Mh+rabSccS2nsl5AyfHh/Sv1lPeDAgMTi3+10OAzhApuZ05YZZrx+10I7XVoci
 T/Ow==
X-Gm-Message-State: AOAM533QrErSIgDdsx6uLgH2T6ivXt4zbNuv9Shd4R1x4ZasSk6BcM51
 gcXd2kuSDA0RrgBm1iBjKos=
X-Google-Smtp-Source: ABdhPJzCmzejZVkyc3DmnhpjY5jt651q14faiVCihtar8McfFS2sAxRzZiPOrfd2BXsKD8ESpOFmnw==
X-Received: by 2002:ac8:5650:: with SMTP id 16mr10678516qtt.220.1620639077530; 
 Mon, 10 May 2021 02:31:17 -0700 (PDT)
Received: from localhost.localdomain ([2601:184:417f:5b5f::557e:48ed])
 by smtp.gmail.com with ESMTPSA id t18sm11089876qkj.75.2021.05.10.02.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 02:31:17 -0700 (PDT)
From: David Ward <david.ward@gatech.edu>
To: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amd/display: Initialize attribute for hdcp_srm sysfs file
Date: Mon, 10 May 2021 05:30:39 -0400
Message-Id: <20210510093039.28502-1-david.ward@gatech.edu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <44b4dbe2-a808-9788-7a4f-dfd628a93256@gatech.edu>
References: <44b4dbe2-a808-9788-7a4f-dfd628a93256@gatech.edu>
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
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 David Ward <david.ward@gatech.edu>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is stored in dynamically allocated memory, so sysfs_bin_attr_init() must
be called to initialize it. (Note: "initialization" only sets the .attr.key
member in this struct; it does not change the value of any other members.)

Otherwise, when CONFIG_DEBUG_LOCK_ALLOC=y this message appears during boot:

    BUG: key ffff9248900cd148 has not been registered!

Fixes: a193ed2094ba ("drm/amd/display: Add sysfs interface for set/get srm")
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1586
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Signed-off-by: David Ward <david.ward@gatech.edu>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
index 60f91853bd82..6965126d771d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
@@ -644,6 +644,7 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
 
 	/* File created at /sys/class/drm/card0/device/hdcp_srm*/
 	hdcp_work[0].attr = data_attr;
+	sysfs_bin_attr_init(&hdcp_work[0].attr);
 
 	if (sysfs_create_bin_file(&adev->dev->kobj, &hdcp_work[0].attr))
 		DRM_WARN("Failed to create device file hdcp_srm");
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
