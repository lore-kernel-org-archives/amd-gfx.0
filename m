Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EB0C54798
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 19:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5621C10E38D;
	Thu,  7 Mar 2024 19:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=froggi.es header.i=@froggi.es header.b="QBGecP35";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0449110E38D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 19:04:52 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-33d36736d4eso861147f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Mar 2024 11:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1709838291; x=1710443091; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IujEeWp48Yow5VwuItpdeDL7053jowuL8P5RXX4WPpA=;
 b=QBGecP356qVuvlMUMmz5GUH21+JOwh9jFEqL6qBLU9FgIRv9rjlwFFvfSGOJjfo09Z
 6U+TaRpdYZ7vW8gHgBjAG1mt9k66A5TPJGj03PLv7U6tA4OzKgvE551WSdYKdebzygfC
 xdjSSASlpIQM/GQBzKnYcN6b3ZAUkPpWyjhQAnSpFn+sqb5OWfBU7W4KIVWatXJTRx7D
 JiST6fQBce/zpzO5W5XSJ4bXcWsf1B0GM/zNXzW52Fk4tDEbi9jotJbaJ4yTJZDsSoZ1
 EC7gCf5Ksdd3/OHVgwuNOU3CzSxJhBvFqbWVmbHPPOiJ/2goBe+iGYiRFHZk/Y1eY4+A
 zrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709838291; x=1710443091;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IujEeWp48Yow5VwuItpdeDL7053jowuL8P5RXX4WPpA=;
 b=uPwSWQPmS2PiDAU3x4uGAm9ytiaEnNhRPalOjBIxo0EWacXDtca1ViSiKzekPjqgKl
 5B1TSqlO7wksaYHMeQBL1Q49bjKJPsgZw8gvCDTbWea/hIeZ9lxMaeFld8aFO0o4MeQb
 yzgtsYTXCqULzYZH+ISnbAJTsKByiPteF5xeQf0xzPHuVlNSYVAT0uTP+SHGqIznzNZP
 iITuEtIVhOAvQn9kwAmGOftY5rp6Zy2rjl0QQDEZeX2kIQ7fggMAEjvqijfqKOHccVeR
 QH4djByTw+hAS+VjbX22EoHd0ANw2PH/5t+Ajz7TaAmGOMjwvFAKj/Rio54UbaDFB6RI
 Zlrw==
X-Gm-Message-State: AOJu0Yxp7s77oy/08qGW9dl0IyXmLhin73bPK8AM5yspMDQbXao8s0WK
 L7RsWj0TWVpd9twtM4wmWCenDGYQzQlDW5UuwElLyY+DZHcjjHxNX0mgY2QWH8OP6VoFxn57psy
 GGcc=
X-Google-Smtp-Source: AGHT+IEpLv4zX3uKGqCEeNnpYhUk7MLG/Vb/rhFeLja69jyu4o/rXvMNskBKHfq9LxPkbKlG7u8iaw==
X-Received: by 2002:a5d:67c6:0:b0:33e:5fb9:af1c with SMTP id
 n6-20020a5d67c6000000b0033e5fb9af1cmr2434433wrw.59.1709838290926; 
 Thu, 07 Mar 2024 11:04:50 -0800 (PST)
Received: from localhost.localdomain
 (darl-09-b2-v4wan-165404-cust288.vm5.cable.virginm.net. [86.17.61.33])
 by smtp.gmail.com with ESMTPSA id
 z17-20020a5d44d1000000b0033e5b28c97csm4105713wrr.37.2024.03.07.11.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 11:04:50 -0800 (PST)
From: Joshua Ashton <joshua@froggi.es>
To: amd-gfx@lists.freedesktop.org
Cc: Joshua Ashton <joshua@froggi.es>, Friedrich Vock <friedrich.vock@gmx.de>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
Subject: [PATCH 1/3] drm/amdgpu: Forward soft recovery errors to userspace
Date: Thu,  7 Mar 2024 19:04:31 +0000
Message-ID: <20240307190447.33423-1-joshua@froggi.es>
X-Mailer: git-send-email 2.44.0
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

As we discussed before[1], soft recovery should be
forwarded to userspace, or we can get into a really
bad state where apps will keep submitting hanging
command buffers cascading us to a hard reset.

1: https://lore.kernel.org/all/bf23d5ed-9a6b-43e7-84ee-8cbfd0d60f18@froggi.es/
Signed-off-by: Joshua Ashton <joshua@froggi.es>

Cc: Friedrich Vock <friedrich.vock@gmx.de>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Cc: Christian König <christian.koenig@amd.com>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 4b3000c21ef2..aebf59855e9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -262,9 +262,8 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 	struct dma_fence *fence = NULL;
 	int r;
 
-	/* Ignore soft recovered fences here */
 	r = drm_sched_entity_error(s_entity);
-	if (r && r != -ENODATA)
+	if (r)
 		goto error;
 
 	if (!fence && job->gang_submit)
-- 
2.44.0

