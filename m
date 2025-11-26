Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58CCD10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BC410E2AD;
	Wed, 26 Nov 2025 13:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tf1bFdTA";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A7610E2AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:59 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-42b3d7c1321so4113724f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 05:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764163798; x=1764768598; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8semwm6LTdxruCEVTiGuW/7bxYWhStH26SMMAKLVQOg=;
 b=Tf1bFdTA3crUe40r7oI/V3fiTsEHZOsMKNwQXg/phpAYzvbsYzw/IpqGR6w7oxEBvy
 OV2Giif7OSM+4xDdiJxWDwIyntKqMos08gkje+ceZ0Qhgg1GMWRB9VLiVmC12yTJW96P
 56EJxOeG1QFHYkRYw28k/oLDcpAKAwD0gzTNc6df9HMhw4S9E34DLlvSTKHU0dx7LTqd
 WiH20zEJf4/1jP0yswVepS3I6OaoQdH5+aQNxRfYsaGEan5vdL7cTvzlpL8hxBPx//zP
 nHy05YLRMSVcxzqRLF1Xxd7nUGPTtIh6ReNk36ltRstd2ddKSV8o3SvuA43kEd68OJVo
 yN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163798; x=1764768598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8semwm6LTdxruCEVTiGuW/7bxYWhStH26SMMAKLVQOg=;
 b=xQma8dETMo2g6DEFDR5gyj+VzO2qJ3Dyc/kbCKq2DYkUavyKS/ttfMYmB46ngymkuJ
 Yk5ugBfhHXjO0ImzaiPtcber7VSoW6OKAuSecGRlg4idFY4RJKtF95iCJzEpc+GFzFzW
 uG4FfNwOYeFD2r9RxRuYgi1jZ+yCy+VaueXqIHQqN9t42GWeiq/sltqieIJ8kqWMgy91
 e6SUjpSkhkgfU70KQCYUXgogNQez6dMrBAG2H28PtEJYEgqhdWD4IMkGX1Ueg4rMSAk6
 DYDA8d30Mf93k2GVwqQV7UUyQqad+Xd7ysUZ9JT7FcCk7gmtdeP4fUCoxO0bJn/by2V2
 7Ppw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8ZgLkGXUenEtddlrAj3jPOf3gI7CCH9XcpLYatEEvDCzTgoj7hAFq2LELBbwPVo/YlIJpnsDl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXUdpBhQiQu5+jn5D8DFdW3gv3Q0cGNeBrRZPcL0rag7G24VMw
 TW4DYWhEIezo3k65Ahb4RjsACrzfVLvB5MEJ+M1jo2mb82gJP99Vhw1WkJFj9A==
X-Gm-Gg: ASbGncsllsf6zaP2X95qNw1cyUWyzv/JBESiLBP6SaVCGY08MO7Nhd6ZMAV6ApxxQCJ
 2GzyjOaa5aqFs+n7qUAUmflGhcQWjuRA4IMMJph8jZCvnMrZ1A6w8Lb9WBrEavQWEHdwZBTGCUz
 pOJmieQJueLtTOBaJLX6NIPWxBkRz1+9D7fC5juHJ+zjy+rpKnzyXLDrlRD8fEUDh7oMtZO3vI+
 3bFczellCARTbeDInfKlqigJ7WB6rFAY1z1p5OvQjQlipxjwgKFDDTV1NWQxpIm6vT7CUFxoMG8
 nX9iwFlgqWsmTUWA0knItMFp959GO1Q/6UqMx7Hmsjc0I0oOFWE5KPO7eCAtiki6Da/UDOnIKN0
 Sel/gMzm19OK968OzPY/Tn692G6XuX3IKAX/My+mXL1LH5xB5f+PefA3wSYLlcduvUX1RnDDsgU
 6Hj/r8ZfYkfEySVfE5nu5QuskB4umT7nyGxk/Kf9vvq6herdQ9M/Emfd1phc/ptPWIKY3uwtJRN
 UGKvGcgRVPqw2Pa8msBFGZNVeTOSw==
X-Google-Smtp-Source: AGHT+IG9FUI+jGU2DeKzPL2S7UCilYMSHvV0ioqgGtnWh/9wm/aazOxgoGxXqFd0+F6ac2Dw9ENoyA==
X-Received: by 2002:a05:6000:1889:b0:42b:3ab7:b8b9 with SMTP id
 ffacd0b85a97d-42e0f21e8c6mr7425642f8f.20.1764163797573; 
 Wed, 26 Nov 2025 05:29:57 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24D8E6005908B7D279C7B6B2.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:5908:b7d2:79c7:b6b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm40537696f8f.2.2025.11.26.05.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:29:56 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/10] drm/amdgpu/cik_ih: Enable soft IRQ handler ring
Date: Wed, 26 Nov 2025 14:29:44 +0100
Message-ID: <20251126132952.150452-3-timur.kristof@gmail.com>
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

We are going to use the soft IRQ handler ring on GMC v7 (CIK)
to process interrupts from VM faults.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_ih.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 41f4705bdbbd..876a3256dba4 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -156,6 +156,9 @@ static int cik_ih_irq_init(struct amdgpu_device *adev)
 	/* enable irqs */
 	cik_ih_enable_interrupts(adev);
 
+	if (adev->irq.ih_soft.ring_size)
+		adev->irq.ih_soft.enabled = true;
+
 	return 0;
 }
 
@@ -192,6 +195,9 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *adev,
 
 	wptr = le32_to_cpu(*ih->wptr_cpu);
 
+	if (ih == &adev->irq.ih_soft)
+		goto out;
+
 	if (wptr & IH_RB_WPTR__RB_OVERFLOW_MASK) {
 		wptr &= ~IH_RB_WPTR__RB_OVERFLOW_MASK;
 		/* When a ring buffer overflow happen start parsing interrupt
@@ -211,6 +217,8 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *adev,
 		tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(mmIH_RB_CNTL, tmp);
 	}
+
+out:
 	return (wptr & ih->ptr_mask);
 }
 
@@ -306,6 +314,10 @@ static int cik_ih_sw_init(struct amdgpu_ip_block *ip_block)
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

