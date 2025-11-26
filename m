Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9410D10F50
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7949910E2B9;
	Wed, 26 Nov 2025 13:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W12rHWz8";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC63E10E12D
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:57 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-42bb288c219so5702404f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 05:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764163796; x=1764768596; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAKMDRCjGSSPwlYIU2rp3cXduMr5K7pof/kiZWbxpLQ=;
 b=W12rHWz8ALC/lTiTtOtDinVkKZa8XI0ktZDxMXHVGUI0P0kw9GX600j71bj0oWZIp0
 0eo9Daoodrn02SlS+W/vZmvHMz8+ARuHnUfW+W4Fdy00AH4HygdHi6BI9F7gq6zy20sW
 /quDJT+Vs5MNNSEslXHX43HkwSUzcYYz7jz9I/HXtRGsoM9kN8M3ifR5be2m93k1ZaM0
 8uXYtmR/tF9anVOAK0Tw+ZFtDLNaXE2U9k+iEIBG7V2NKZVQGZ3OpRbYOZzuTe6fmRyz
 B/PwAu8gPt8wFhf5uPEfMOSOgpo3lan9KMS3uf0rxqsXkfhB433YFn++nPXmqnuD+mg/
 JOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163796; x=1764768596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oAKMDRCjGSSPwlYIU2rp3cXduMr5K7pof/kiZWbxpLQ=;
 b=mcj40f+PGJoyW5KSkkXXVwd9hcX2xpLo3O+K6I1Id8rMP6N+XTc2in+1lvLA4L06XS
 okqNHDJK1sJV+EUqs06b+1ORSNPpoTHCEw8FQ4SSfOI7d8rx8ENEwQFoTUz1B742oCH0
 wReHw6V8nKe02AW0uMZZucHTcVPrfjaFFRG0i1g8uGnu+PBNnP6QJZA31jd0lqxUJp6w
 hf8jW1G9dICX3Wn2iv6siLldEpHyZM+AwkjIc2mQKbUaGX0tQ6fa7AzJz6XhIWUjKnTa
 YeCN4R+mnNBPjg6N3jZYjPpiBcm5wDTCpuggU4bOkbH+bd65mZPV44A7OU3WQrpttxtu
 Ie0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/kU5j3NCResvxFT1KJLhH+xJNm4xgtTj1WddV8WdcWF9lNWd7y7fV9oMv2S9ioRmOId4iBC3r@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyg2aLIxBdD+sd6os/3ioIzyDDJ7/SAhAkDhMj70dz58/PkRv2j
 RkpSNA6p9eY+/ip5+h1T/DIsqrcxHvjINavjrSens/dDUD2svhO0LqAH
X-Gm-Gg: ASbGncvzGzHimNcFXyhTJjH12fyv6bZNkys33+lF2Q3lJLmPR3OC3d2WfJm88qv5HCF
 oacOVO9PBKSrcmlzthRkgrz4lJSJztVrtq9zzvu7gaAWzG0u1CJXLVvsurh+557DSsQs0JyjrQD
 mxV/794iKq/s85sAtuZcWBwk+vKr4yBfZeKgt+QuyE2e1Ai5zAW0+y1yD9FaxwxYjalqhToOxIM
 Q7BVI3lzZT3i+leLjZx4B7u1PEJapz6JmHMY54bc2QpZxFPT9b1EbDwGk0jjr73Arp30ZkJog0+
 XHw+jSOF/jyatkQwCy4//VOKcY4Hkz92Cvs39SOkGTq7dnac6M3P7msMvuWb3LcukcKbbQzgk3z
 ikQSm9/rBFC6H96lK2E5rHd07Reqz4b7msLaBtBumDwxCpLr7nY4H+i/IcTy7wBeVIpUex+GP6L
 6ocLm3e8Fd23UUTZfUybRUDuGbtgBpJWZH2r0zMYoY1KuKup+rKlyfVlJ4vHyoN8CGvjIOLPCBH
 j4jR++6lNHXk6lRnOI=
X-Google-Smtp-Source: AGHT+IEucmFTRPENbq6lahds1LVlVOCMrB1sJ3Y+mCn8Oze7CWYPh95s7QpTzRtuP6Prk3UmUOMzFw==
X-Received: by 2002:a05:6000:2f88:b0:42b:3366:6330 with SMTP id
 ffacd0b85a97d-42cc1d22db5mr19121157f8f.57.1764163796251; 
 Wed, 26 Nov 2025 05:29:56 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24D8E6005908B7D279C7B6B2.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:5908:b7d2:79c7:b6b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm40537696f8f.2.2025.11.26.05.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:29:55 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 01/10] drm/amdgpu/si_ih: Enable soft IRQ handler ring
Date: Wed, 26 Nov 2025 14:29:43 +0100
Message-ID: <20251126132952.150452-2-timur.kristof@gmail.com>
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

We are going to use the soft IRQ handler ring on GMC v6 (SI)
to process interrupts from VM faults.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si_ih.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 1df00f8a2406..66f650f87243 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -96,6 +96,9 @@ static int si_ih_irq_init(struct amdgpu_device *adev)
 	pci_set_master(adev->pdev);
 	si_ih_enable_interrupts(adev);
 
+	if (adev->irq.ih_soft.ring_size)
+		adev->irq.ih_soft.enabled = true;
+
 	return 0;
 }
 
@@ -112,6 +115,9 @@ static u32 si_ih_get_wptr(struct amdgpu_device *adev,
 
 	wptr = le32_to_cpu(*ih->wptr_cpu);
 
+	if (ih == &adev->irq.ih_soft)
+		goto out;
+
 	if (wptr & IH_RB_WPTR__RB_OVERFLOW_MASK) {
 		wptr &= ~IH_RB_WPTR__RB_OVERFLOW_MASK;
 		dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08X, 0x%08X)\n",
@@ -127,6 +133,8 @@ static u32 si_ih_get_wptr(struct amdgpu_device *adev,
 		tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(IH_RB_CNTL, tmp);
 	}
+
+out:
 	return (wptr & ih->ptr_mask);
 }
 
@@ -175,6 +183,10 @@ static int si_ih_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
+	if (r)
+		return r;
+
 	return amdgpu_irq_init(adev);
 }
 
-- 
2.51.1

