Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDFAC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D978610E99B;
	Mon, 13 Jul 2026 13:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UHTeKyjs";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71DA10E9A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:07:32 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so3200509f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783948051; x=1784552851; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oxx7Qsy+ieRgA3BgUsSUxLrN/DkG1gm6+dl7rGVDtS8=;
 b=UHTeKyjsD6MVwL1CPJQIUw7iF0cnzrT7+5nGHWGp9zNqaNw0Hr7UdEiuT8bJzwz2CE
 7V5rtGeCKNra7zUYE99xGBy4RPZbDt3sT6jw7MeBmASL4VKKrq+6TSkO9Gn1Ur7ksCdp
 5nTEvEN17+YFdkzFU9FFKdWPU3J9RHbDcaRNM6kVFqKzvQcz0Bn10WM0rq+fR0vUOyP5
 0QcAZJaV8lW9mM/IQx3j2L0i/vAe0kdN1uRoaQjKcU5cuTLcswwR9knu+G5GjeKowJNq
 KdaYDZa6bn78LxczmBK9aozNlI2mX7SnxxVP9Oab8w8HMPnbXAS4YDtqmNAp71ZMBynB
 lIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948051; x=1784552851;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oxx7Qsy+ieRgA3BgUsSUxLrN/DkG1gm6+dl7rGVDtS8=;
 b=ORDW2G6OwvzkKFrQKWC+zuEeqGmJukjI+Kf2lAHHdfZEPzfcWc0Zai0nqkIyLTPL2C
 LLCuo0KzbTuBXh54skOeJBU+Km5VaXhHt8IrqM75uzUm2QyERxjKH1Q0Nb/GY1J7SPJK
 IAPM31fmIXQTizEKmvwV6f39X8futJhimlBM4TIseEd2hVTrH5MxU21Yh/xUQ630atLQ
 g5GlX407j+Vr2pm83vgtIe6x8ToGeGKcc0Z5AWA0CCmNWNii9h/xWM7dUhF35nGiSVEE
 l12xpcxC+sj0Bep0346skMt76zhuwTW1P0Hadu5HIT6FeU1vTQ3Blut1LfUYc0Y4O/s4
 i5/w==
X-Gm-Message-State: AOJu0YwqYLJ1yuaIx+NonZpplB9mRIaYSluegLL/DygVlWHWnnXl58BS
 ZBcEoGjI8BAocMVg8/X395hWs594iBbGTclnzbV3Om5M+0vA31zzmDCA1KFHGg==
X-Gm-Gg: AfdE7cnqdoJ4HaviZzSRxahSWSbYCJ7AJqF0IDnudrX3RNc8NxPt4ANfXzRlYTdqMF0
 dv5WvbO44RMa0Zx41vxuWnJSUgUDOyoqWGOzO3v3goBd2OXpY56ayOfx7aDZpc5Q2dkJqYdbjLa
 Cz45hMhVs5EdSiRHj3IsqhKJDWGa4yVHN0KRQm6oCb477qW25uE1ogKkjHcGAP9hk1gpp9M5n/q
 NvKjCAX+5Cj78hq4/tYZ1UDfttSbtsGCvWoIAsw8EKOn7EVhrbTBxpV3b1FJDGnZjfg3hWEXduT
 oQ3nUCmKi2XluBfnpIzWL2U15fvaYicDtyX+n1FVNwIuRrna0gmD1h1p/kB4j2K6cvJelLNzCTk
 nZdHO7NRVtDUwLU9v2cL/AXcj9fY/5qyCWF5dPTVg34Wpv4i2q+1YrwDx3VXlEHBin3laDLY0jU
 tQnTLs/djlKwV6AICOLDCWHY5kvdY9y78JzWWrGdbJJv0qQLC3SKglrmIE+EgcLetc
X-Received: by 2002:a05:600c:6387:b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-493f87d918emr87920795e9.7.1783948051067; 
 Mon, 13 Jul 2026 06:07:31 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm387974995e9.8.2026.07.13.06.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 06:07:28 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/11] drm/amdgpu/gfx6: Properly enable/disable priv_req and
 priv_inst interrupts
Date: Mon, 13 Jul 2026 15:07:05 +0200
Message-ID: <20260713130709.34262-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713130709.34262-1-timur.kristof@gmail.com>
References: <20260713130709.34262-1-timur.kristof@gmail.com>
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

These were used without ever calling get()/put() on them.
Implement it like on GFX7-8:

* Call amdgpu_irq_get() from gfx_v6_0_late_init()
* Call amdgpu_irq_put() from gfx_v6_0_hw_fini()

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 5b570a4b5c01..1c7cd265fbca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3131,6 +3131,22 @@ static int gfx_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int gfx_v6_0_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
+	if (r)
+		return r;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
+	if (r)
+		return r;
+
+	return 0;
+}
+
 static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
@@ -3243,6 +3259,8 @@ static int gfx_v6_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 	gfx_v6_0_cp_enable(adev, false);
 	adev->gfx.rlc.funcs->stop(adev);
 	gfx_v6_0_fini_pg(adev);
@@ -3532,6 +3550,7 @@ static void gfx_v6_0_emit_mem_sync(struct amdgpu_ring *ring)
 static const struct amd_ip_funcs gfx_v6_0_ip_funcs = {
 	.name = "gfx_v6_0",
 	.early_init = gfx_v6_0_early_init,
+	.late_init = gfx_v6_0_late_init,
 	.sw_init = gfx_v6_0_sw_init,
 	.sw_fini = gfx_v6_0_sw_fini,
 	.hw_init = gfx_v6_0_hw_init,
-- 
2.55.0

