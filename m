Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40189D2ED1A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jan 2026 08:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E56B410E584;
	Tue, 20 Jan 2026 08:25:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hmEchLZp";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9558410E4BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jan 2026 06:38:37 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-81c72659e6bso4188929b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 22:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768891117; x=1769495917; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23Yab1Aml37M0q2X0GSrkWMBaoajqXvi7yvWyWBhLVA=;
 b=hmEchLZpfArby97fMVeHEVpf0bEmXZQbHLSeaxtZRKMF2sZB2Kxahg/2yZk7gewblB
 AT8nQNvhsRkVWmRJXvsYO9Il2VJlIXTd3nd5AiQkl8Oc4TpC78VnDdqBjlSKKEeI1dLJ
 bS+0jsEvo8SIV4kkx0IMPdmaazlqSxsttAPhslI6bX94NtsQbpbPs38k9roeK7N3N8d4
 qLUjqb/VmNPYqITtchgT51AWWSAvseuVcKVr+v4/DcXNdEaJ/L3rdZkoI82SFXz+8nvC
 bYAwqoBe1VK+yt2j7TUqva7tfoagkYsYGj2ffZmy/O4Fjwhtea9FDqpPylfweBqlF6Gt
 opzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768891117; x=1769495917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=23Yab1Aml37M0q2X0GSrkWMBaoajqXvi7yvWyWBhLVA=;
 b=bCEFRYcX2T5/bBormJS55M6CDFBjnLPKnskjrFOQ/Jfxsdc29pPEgiwZ/XbxwhnQ5k
 RIn+A5KeyVLUXXzjrs19GZy8mVyCTqxx/tZZj31NJxvvD1ynn5nPZpTZ/7zGoJ3/Al1c
 SwwbyyFPJOqSzM3NKBS0g/rTFgl/Eby7WKS6zGEoyuuIM+uZW5dmQuVqpaLPCQfRmI2l
 873p0PoeNX8QWXtecMQYx3N9R8CewKUS2LbD5ctffRq3bjzjGcmVIHq0/x6y0LM9Ihtu
 Bvtgu/gwnx4leZtA/1PDMipvKa4YFwoNa6oWFFGCqcDolaJIxvTWs3YX3Kx2dbmORZsD
 gXbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+FYRw/qEVw8gDWpQKFHxbZumm13lKh7NOprQlS/MmHn3EKtaZlfmvXr6WFRA+TIYjmRottQ6L@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPwxQNMZ4oIZsdlcMbmJsH9yhCgh0PgJc3IMVdL+AP0auNuWM/
 hKicp/6uSzoXLWmpeiy0qMZPM4OfrmRZtVd3nRngB/6JhP6KTEl0FNKY
X-Gm-Gg: AY/fxX6dLvonV46kF6KuCstgXHhCVyzGbucb/qQKwKCl6vuqsYZC9Bq/kp2S7+nHcKa
 D7dp3SK6eFQefjO5A/X9AIDeWwvzIr22TwVB+6V8z5FNN/KUxCOa9Vef3VHswJrL4J6ynds6J+d
 8h5Zz1pmtPxySkKB2aLVq32Ocoy2ZLh3Jy2O3TtdolbnEYQmKQuylWQS4I9WDpszAhRE3VZGWvo
 aWqv5QeQDlU5R9jsrytXAHtqyTtjufbLSplQnteKmQEVm36BwfBrj8MYpz5CgHTYvEUEoJjVcf0
 WnCA6yuxyfQKRr8FtbmU9YrSnm4I/xqpb0F4aIElIfNT7rO185OPw0BtpKMAA0x8sMdlwSpikSN
 9HQBEZBnsn9/dldX0fLA5tiet/SHvvsgnaEC2m+mNfRLom9/+abhFd4L/sFU5M0KY61B0WP+GBh
 6tJLAzCv4SEDZ+frrw4QZJYcb4yzN0CHP1d+RTomCy7raHfH31Xs3IN80jkIUdRkA=
X-Received: by 2002:a05:6a21:b95:b0:371:5a31:e487 with SMTP id
 adf61e73a8af0-38dfe93bb92mr9776007637.70.1768891117009; 
 Mon, 19 Jan 2026 22:38:37 -0800 (PST)
Received: from rahul-mintos.ban-spse ([165.204.156.251])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf264b9csm10561055a12.15.2026.01.19.22.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 22:38:36 -0800 (PST)
From: Mukesh Ogare <mukeshogare871@gmail.com>
To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mukesh Ogare <mukeshogare871@gmail.com>
Subject: [PATCH] drm/radeon: convert VCE logging to drm_* helpers
Date: Tue, 20 Jan 2026 12:07:18 +0530
Message-ID: <20260120063718.203785-1-mukeshogare871@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b6bd1fdd-fae7-4ee9-ae06-9abe168adbd4@amd.com>
References: <b6bd1fdd-fae7-4ee9-ae06-9abe168adbd4@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Jan 2026 08:25:58 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace legacy DRM_INFO() logging in the VCE code with drm_info()
helper that takes a struct drm_device.

This provides proper device context in dmesg on multi-GPU systems and
aligns the radeon driver with current DRM logging practices.

Note that this change logs firmware version information at info level
and does not indicate a failure.

Signed-off-by: Mukesh Ogare <mukeshogare871@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_vce.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index bdbc1bbe8a9b..ed631c0e5e28 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -121,8 +121,9 @@ int radeon_vce_init(struct radeon_device *rdev)
 	if (sscanf(c, "%2u]", &rdev->vce.fb_version) != 1)
 		return -EINVAL;
 
-	DRM_INFO("Found VCE firmware/feedback version %d.%d.%d / %d!\n",
-		 start, mid, end, rdev->vce.fb_version);
+	drm_info(&rdev->ddev,
+			"Found VCE firmware/feedback version %d.%d.%d / %d!\n",
+			start, mid, end, rdev->vce.fb_version);
 
 	rdev->vce.fw_version = (start << 24) | (mid << 16) | (end << 8);
 
-- 
2.43.0

