Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77242D10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AC4B10E5B8;
	Wed, 26 Nov 2025 13:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dkqidOA/";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD9810E5B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:30:05 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-42b2a0c18caso4142955f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 05:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764163804; x=1764768604; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2XmCo063eYyIA9dKU0U2n6BuEsWy50R3sjAbd10GL68=;
 b=dkqidOA/IYpxECIlDEhSAzpcIL5FP+jGnSrWbvfnDDuhiE+DRMv8BIAv6eLKKSeTQ3
 FEKMAYuamqvYKhlZGx7ypHfIL4jM/TlfUjVnNpr+3bpKmjb9tAs4SFDNARn9PtlE1/+c
 174pPG/S+D12ajkXmyHmBF+wEsPzBW4pI1GardeMa9wbjv8Qq3K5xZDAExoROHsJVaq8
 5rrcC/D/byBOnMq2jZ16LsgpEwQgfm681dXgjAGYePUfyjUX3VJXjzGrma0f/dtR9i3t
 5MzwyBGoe9cyVJcZc6Q+gnIHgIuGINJhrUsQdsH7fw8WNBUnHBkjDMH4bqzrF+YTyrIS
 lMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163804; x=1764768604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2XmCo063eYyIA9dKU0U2n6BuEsWy50R3sjAbd10GL68=;
 b=Y5X7vDcJ0ChyJp130FlxDmqTQdgVVjZLuZhNKOs09Pqg3nUN35wZ5EDT5L38LkIxtK
 vuYerYEKYcRFKfLaJ15v/KR51lbp4oJ2l7MrXXnv72De+ZOquUvQiUsYB9haKyb0r/gO
 uKsBDLi6u9qMbnxssibryH2uhhHmJClk7JSNDBHug2+Yf2i1e78iWOiOiKAbNlZR+VF3
 +Oq2/Z6LTyZihky2bGElRT8nAKA4fa6YPvn5iw+zyOjrBY6IqsYuc0aY0/I7fiqwTSDU
 +0mUdMZR8kH29qHRtWjagrneAIcifpm2ISdtiYhNWk4ys8HTpw9NwToaxuuDgmsB29vZ
 WMSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmn4HQJr9hPaxRsKnMvRgkT1hhM0/uqsthbz1CJi/fC+bgK+2XzZH/ujSVHhSna8iWOtCm9+zd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvrLA+vWrVgWBU+sgzi0TLgdFbmq4eW7D3pbpACr/+ZhJ9PZ7b
 7UeZkgMF53fd7m3Tkhpuquzw5EhqHIbJN6py2M2IfdX1mueR8NbuzOaV
X-Gm-Gg: ASbGncudGcMupIzrm+yZ+sifScJ69MEZGUOb/yzp8un/g8dlqRFGKvuJ9o56OXEXnhg
 N14XpxpXMn64BQzvar0OnnOjyS9qKoHB0KnMmfolWchuToKYogOUQMJM6qyM4fqDiB3QyN4jeLn
 IFB/gpvrFaddmPdHgk0SLJzKJPWkyS1ymH58+ZgaShf/S120HY4h+eEY0UWwUN31M52vSanepl7
 8CL7t2N2BTJzkrrrBWCnxNGYu0zITUBNm537I1hIJliMzxskBJ5zz2+x07OhgDblOrQdy12pmrp
 a5Ulj5RuksbYLLe6Si4rWRDC/79N094ffSHdCLV1WTTlosOmBJU2YgbLlIXft/0H2Qy0HWkLOkM
 lF0Qx7jIDEehqcHeobEHRqT0eJstCkpXqWwQCqrJQxDTWPnIUMlo6Se1iKxKAckG3slEC7h/brC
 zX4kiwEZAoBJOaWj7zjMSjZHdI9wGDdJpGSp8JyCV4Q1VoiwLDcbQkqr8D72+h7yXCL55iINiNg
 L1/68nx5jHntumpML0=
X-Google-Smtp-Source: AGHT+IHsJdqPNvD+Ik5XItXpUWM2COYIUn8nHDQGhuJCHxfabesmT8cXY/VQVsWT2LJMZ4UsME43QA==
X-Received: by 2002:a05:6000:240b:b0:42b:3b8a:3090 with SMTP id
 ffacd0b85a97d-42cc1cbd456mr20662539f8f.23.1764163803681; 
 Wed, 26 Nov 2025 05:30:03 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24D8E6005908B7D279C7B6B2.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:5908:b7d2:79c7:b6b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm40537696f8f.2.2025.11.26.05.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:30:02 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 08/10] drm/amdgpu/gmc6: Delegate VM faults to soft IRQ handler
 ring
Date: Wed, 26 Nov 2025 14:29:50 +0100
Message-ID: <20251126132952.150452-9-timur.kristof@gmail.com>
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

On old GPUs, it may be an issue that handling the interrupts from
VM faults is too slow and the interrupt handler (IH) ring may
overflow, which can cause an eventual hang.

Delegate the processing of all VM faults to the soft
IRQ handler ring.

As a result, we spend much less time in the IRQ handler that
interacts with the HW IH ring, which significantly reduces the
chance of hangs/reboots.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index bc6a74903f4e..a8ec95f42926 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -1070,6 +1070,12 @@ static int gmc_v6_0_process_interrupt(struct amdgpu_device *adev,
 {
 	u32 addr, status;
 
+	/* Delegate to the soft IRQ handler ring */
+	if (adev->irq.ih_soft.enabled && entry->ih != &adev->irq.ih_soft) {
+		amdgpu_irq_delegate(adev, entry, 4);
+		return 1;
+	}
+
 	addr = RREG32(mmVM_CONTEXT1_PROTECTION_FAULT_ADDR);
 	status = RREG32(mmVM_CONTEXT1_PROTECTION_FAULT_STATUS);
 	WREG32_P(mmVM_CONTEXT1_CNTL2, 1, ~1);
-- 
2.51.1

