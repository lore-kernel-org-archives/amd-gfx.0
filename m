Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC86D10F45
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:30:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 607BB10E57A;
	Wed, 26 Nov 2025 13:30:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YMDX2AmL";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC1210E541
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:30:02 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so37344085e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 05:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764163800; x=1764768600; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vS2iIkmcCDhJz1qsHp0Y7ZK3WXDhDDogzyA2fp+lQY=;
 b=YMDX2AmL0Jrt463swdH6XEUA5nJGMff4siJRaIbgELIUV+FVAcPIta9r5Dj6qVUqgV
 pibCKFLg2NmEk81eOiI4NDdfNZ7g48fN2eyIQUn+1oYEHn94ln0UhLGHVpFqc2KUyZdJ
 no1sENYtukKMg63qXYkbXgy8llBwYazN7cHphwrSFWKT4p+XKjr7vq0s7Z8dliBNgo+Z
 E+145OnDInbYQ79Z6KWky6Mh15rI1aJ6wF9V0lSMofDTecUQuUZTBrsBD6oAJ0dbu79L
 tkUifFbR0ZBJvno1z0vSvWVmrowAl/zok2xwMxa9trY4Sxvl7kpV/5d5rzTgceN8FNyL
 cf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163800; x=1764768600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0vS2iIkmcCDhJz1qsHp0Y7ZK3WXDhDDogzyA2fp+lQY=;
 b=gIW+M9TZATu6OZoyjidzMWbPRwcVeBq1BqXj7bHoi708hdXLsrBOCA70kVITz3TAdb
 UZ4Cc4Ivc+UItzN5qJD9hl1zZtc7Krdl24Cve+p0Z/aIucGjhFiMyAIs/FQW18qgZQa1
 74efB2c8kB2J7T9QBNfeBS5mL2vj4t8UPmj2qJzGHCuuxb4UFbxze+qQ4ikZstG84pUo
 fYwpjYI5aXtQKa/70fjllC6vwH/8k83LVyYmQWfF5AB8+35agHJGK7FIVjKCy5+Fk4j8
 IX4uskh88VFZRTWGS+YBOh7lfSryBpzB/jNPFrjzn8m43w9VL3yGdjwR8NQqYHzwQPA+
 ytsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbCTrfFNIhpwJBNmje/ILGBEiBFp5q7MigHR6X6MfZvSkUl4eRHAFVdAdNtW8WEjCGIcx85gTy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAwlSVNJ0XUU1SI43EIpJaok4N9dylEu8SH4oZ/ZwgKt3bHewE
 ulpgyckuT7xZW5YlyYzCCXKjWkl0BB53V/Z8V5z8pYcoA9GXlUNOcvG/
X-Gm-Gg: ASbGncvU3ywFLA213wKUIe4eSrzzK5UTOztJlJB/0Jkykvz8hrnkw5SOPRXeUCrY4bJ
 VyW+2OYcod8JREXG7QKFpiY/q+zRlxOf9OftldP3ZpI/EzBZ0TqpLOospHh0GBAEiaxvoBm1wSU
 e1UHhyQCrCV+EqiixiyqNHjXfEvKv4L/9XToADvOni9B43+/vo5Ciw1RS5VdKy9HMqg8QWWr86y
 dQ4xouLXixpbCiqVzIk4D+N7MweCAG2Gc0vY7qTYMLr7dXJTSotz4m70QhI90AT7wlvMcsvNKo/
 E+xC6dk8KkRbAzL/q2Jw5NoNN5c28DcgMVJDYoMd+AIILsGILG402n4CT8pV/uGla5fHycsW2EE
 iXP4zmzKaHkGsItTy3TjYjRGnBnDCpP+BURZ0H4xXiftBGanzjiZc8DA6Xl4qSKjDh7yU2jXrC1
 3A7kJ2OcNNTuuq5u20ceAsm1xVKW5dZJgdyEp7QhGGj14C2VWQ/sIuJW9HKaXG82gIRnjpMiwJI
 ZVojLuc65w3YjQIb6A=
X-Google-Smtp-Source: AGHT+IESJWFoFjzSeUWpd6qW+x+umeinkX4hEHD7J+SlxPb6MV8x1n6wiwdk9Rv/hk+NbNreqJMkmQ==
X-Received: by 2002:a05:600c:19ca:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-477c1143073mr185090065e9.22.1764163800435; 
 Wed, 26 Nov 2025 05:30:00 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24D8E6005908B7D279C7B6B2.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:5908:b7d2:79c7:b6b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm40537696f8f.2.2025.11.26.05.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:29:59 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/10] drm/amdgpu/cz_ih: Enable soft IRQ handler ring
Date: Wed, 26 Nov 2025 14:29:47 +0100
Message-ID: <20251126132952.150452-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251126132952.150452-1-timur.kristof@gmail.com>
References: <20251126132952.150452-1-timur.kristof@gmail.com>
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

We are going to use the soft IRQ handler ring on GMC v8
to process interrupts from VM faults.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cz_ih.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index 2f891fb846d5..bc7a2e06ab5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -157,6 +157,9 @@ static int cz_ih_irq_init(struct amdgpu_device *adev)
 	/* enable interrupts */
 	cz_ih_enable_interrupts(adev);
 
+	if (adev->irq.ih_soft.ring_size)
+		adev->irq.ih_soft.enabled = true;
+
 	return 0;
 }
 
@@ -194,6 +197,9 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
 
 	wptr = le32_to_cpu(*ih->wptr_cpu);
 
+	if (ih == &adev->irq.ih_soft)
+		goto out;
+
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
 
@@ -297,6 +303,10 @@ static int cz_ih_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
+	if (r)
+		return r;
+
 	r = amdgpu_irq_init(adev);
 
 	return r;
-- 
2.51.1

