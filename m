Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C32D2ECE5
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 20:36:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A87EF10E515;
	Mon, 19 Jan 2026 20:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ILO8yyPh";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62CC110E513
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 20:36:37 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-652fec696c9so8353165a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 12:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768854996; x=1769459796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z5V5wNGE1IEVLk2jrfJ22v5SveuYW4LlMsRXUZy2NOI=;
 b=ILO8yyPhmnqaven/PP7O9i5pVoCf9q6kl/G0x+Ouh6Y6LiZxi4FAjw1PeqEMsnmUhM
 T08KypIeL2Uzic1f3mSykogfzv4NBEJWCYzDSHn8ycJDyxY5csgyAFCp+brSIyRKoRYy
 8hIzj3WRK33zDiuMpVOLEQwYlgHS5BTcT5bvgET1Acd5DUWOiRZVmKYUpDORPOx8/Wnj
 8CoA7e6kA1SqZ1mgF+gnkm3pnEYa35zWviZtAkO231f7fwBuNRfj7x7NbtaPMiOreJJD
 gaPYejdkK8wlfa8GYaWQ9HPy5QxMMhpnMqJgZGMmPNOLzKA9yjnxHh38C6fhGWF+OiaN
 KhNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768854996; x=1769459796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z5V5wNGE1IEVLk2jrfJ22v5SveuYW4LlMsRXUZy2NOI=;
 b=VzL3M/Gb5wRQ5hag9oqbHfcYMvgIZN2ExFZFApEsbBh9Czk//yRU6fSbd3MulNTHws
 DmgDnMPLoqynYfRKcBj7IxX6VxYU3NiKAqgYy/ElKhYRAGacCVD7h5LrMVAu36Zu7L6W
 NYHsclPZykU2iZb6qbqCPUJA9/xJQDKkSPDQfVpFn8MveyWW8pzmsVK6w4j8sjqkn9np
 9DPy2RgCSqtHL6E60ID7Z5Y6M9sUv1fyOn/vyjhbh5El6fC2nBEicYP8/tT5YwPgnkGn
 6i1yI4NJCq8Rr3D2eRl9taTEybpSt+TffYWKt/BP8B8Hnr4UuhD0IOEDSpy1h0QwEWJz
 8faA==
X-Gm-Message-State: AOJu0Yx2t/8Bx6BtzdwDvSC41cCMpuE/w2xe0z7imZ6iG23LuEfxnaEM
 gCJZT6jsP9ztnRStRNamzUy6VRGlbXPTfi9bECYaJEh/xa4/1Wl7KH70H0g+NQ==
X-Gm-Gg: AZuq6aKUQaT69p6IvWE+bW3e7Ca9pygVlCtPLTcqucd6k8mX0kP5V4VF65/+h+SzSbu
 qmcmVp/BclbIFuE05lbXblihJjfI9MPahFQio6ahUJQlgEaVq9GNgeUE5azmTz3ZZc+PuUX04QI
 CmBZcv+VQnX3emNDGwcZ6xvyO9Ouos0tKQwhel7uxPUTe0WObA1MN1zoQiKNF4R4LXqUEOU+Ojm
 yrTbMAXbLZVoIYb4sA3J9BeDv0XTXAJqRdN3dZCRZ1VGZp94vu3bOCDXKkemz1a9dc3KoidxL6r
 8FKm7bM1LawJcJQTc8JoQSGPTNjBkxLNGZGSYL5O1qP7o8LG3p5gZ8aGz/jT4JqiHZJYtddsh+8
 SfR60UVP6jLpu2ZmFh2EKUzNNN0W91E5k4T8Wmjqm91T5OcoYUJmyHcqsf7k1QVzcZpXQJcxpNX
 WGkEExlknDdseRzq0/mDJ1Sc/efU5cqCfF7H1On52zujteX2erCgo5SRygKxq3A//eF59gmmNqZ
 RIgWwrsHkF/8j7hfSiierw=
X-Received: by 2002:a05:6402:5253:b0:64d:170:7976 with SMTP id
 4fb4d7f45d1cf-65452acdaf8mr9345343a12.16.1768854995874; 
 Mon, 19 Jan 2026 12:36:35 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65452bce213sm11375492a12.2.2026.01.19.12.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 12:36:35 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Prike Liang <Prike.Liang@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/5] drm/amd/pm: Correct comment above power2_cap attributes
Date: Mon, 19 Jan 2026 21:36:26 +0100
Message-ID: <20260119203626.16070-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119203626.16070-1-timur.kristof@gmail.com>
References: <20260119203626.16070-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Previously only Van Gogh supported this, but that is not true
anymore since:
commit f9005c8896f8 ("drm/amd/pm: Expose ppt1 limit for gc_v9_5_0")

Update the comment to reflect that.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 4c152df3fdfa..1ea0f073706d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3879,7 +3879,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	     attr == &sensor_dev_attr_temp3_emergency.dev_attr.attr))
 		return 0;
 
-	/* only Vangogh has fast PPT limit and power labels */
+	/* only a few GPUs have fast PPT limit and power labels */
 	if ((attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
 	     attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
-- 
2.52.0

