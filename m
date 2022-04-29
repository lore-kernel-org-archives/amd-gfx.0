Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C59C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 13:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65BCE10E7AA;
	Mon,  2 May 2022 13:00:20 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9875610FAD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 21:29:41 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id i19so17661953eja.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 14:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A4tb+kpVXoD73NInbjSATT1BdOWknN5AdCUevh6ywsw=;
 b=Ih5KlrR+vVPxM2eoAmzd0U+jiXefhTX3p9PdRZcWXCUmVzRCozSxuWmfX1gzVHK1Ur
 VUR4cKBQf90bLAevvWSTrtRJzN4S5v0z906F3s78O+kftrD4kzVlyi7rse76SqLuOind
 99o3egnBOaOfBntugvH9VPQV5seVY3ESBAruEFdty+heNVKcxuqrEGPWaDgwHEOJ4hjm
 mgtOUK8+ovuvGotp3UFFOL0zSAuy3a5KMO1RfTJss24NAi8ASeQ9uSO7ke4E/Hy5JCbr
 kIGnq+ftI46edXnhLArGhcp5o1rMdVu8zzcpj8MA3vs4nU/tKfqsYyqWYuncWHYChxff
 bZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=A4tb+kpVXoD73NInbjSATT1BdOWknN5AdCUevh6ywsw=;
 b=YSR6oI5Yw9QwLsINRK1CJbcSGuux1mRa8aUAOd980ryq96Nh6nVKUH87KMyLYhbjA5
 41rrQ822VscHLx7cDcVpilat3me2TA6wbm6ONyJOHHcPNnrgNs1ZZkVN1FluMqyPXaLQ
 LP1M0duIYENdp8dYjcef7MUOxwshXyfJ16QCPZu2U6WMgaQNyUJL2VWC0Yb+qA/seSDt
 7J93utCVVZTEVC0LBiG5J6NNxrV9qTiXqlCUacHA9XKhK1RV9CFPN+pfglv5XSRYQY/B
 Kp+Uc7yBjEnnq1ab8S8XJS6NgAOa1LjZAcHyxfusSoDvYE1KxO6QFulX5moOMMe2shp6
 Y2Mw==
X-Gm-Message-State: AOAM532QwSJihRi9Eds8cfM78nYLK8pfkDXPOg/nAgLwq3WV9HHzopFw
 aror+sx0yZNxLzJbi87Xe6Do5nr4bdI=
X-Google-Smtp-Source: ABdhPJytXHKDYEFTUcP+AYX5HV98u/Vy/5sIMje9lvz7FOllVDPfoSzlRoexK3qihjq9HXq4MNA+YQ==
X-Received: by 2002:a17:907:6ea4:b0:6f3:c09a:e97f with SMTP id
 sh36-20020a1709076ea400b006f3c09ae97fmr1178821ejc.18.1651267780000; 
 Fri, 29 Apr 2022 14:29:40 -0700 (PDT)
Received: from nlaptop.localdomain (178-117-137-225.access.telenet.be.
 [178.117.137.225]) by smtp.gmail.com with ESMTPSA id
 s25-20020aa7d799000000b0042617ba6397sm3414407edq.33.2022.04.29.14.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Apr 2022 14:29:39 -0700 (PDT)
From: Niels Dossche <dossche.niels@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH] drm/amdgpu: fix EFAULT return value for debugfs ctrl
 parse data
Date: Fri, 29 Apr 2022 23:29:04 +0200
Message-Id: <20220429212904.83002-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 May 2022 13:00:18 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Niels Dossche <dossche.niels@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_ras_debugfs_ctrl_parse_data is reachable from a debug fs write.
A write is supposed to return EFAULT when the user buffer is outside
the address space. Right now it returns EINVAL.
Change the EINVAL to EFAULT.

Fixes: 96ebb3073275 ("drm/amdgpu: add human readable debugfs control support (v2)")
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---

I found this issue using static analysis to find inconsistent error
handling regarding kernel APIs. Found on v5.17.4.
As I do not have the necessary hardware, I only managed to compile test
this on x86_64. I put this as an RFC as I'm a bit worried about possible
userspace API breakage that might rely on the EINVAL behaviour.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 424c22a841f4..9bbdf0519c31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -253,7 +253,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 	memset(data, 0, sizeof(*data));
 
 	if (copy_from_user(str, buf, s))
-		return -EINVAL;
+		return -EFAULT;
 
 	if (sscanf(str, "disable %32s", block_name) == 1)
 		op = 0;
@@ -308,7 +308,7 @@ static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
 			return -EINVAL;
 
 		if (copy_from_user(data, buf, sizeof(*data)))
-			return -EINVAL;
+			return -EFAULT;
 	}
 
 	return 0;
-- 
2.35.2

