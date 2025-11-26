Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358F8D10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A148B10E543;
	Wed, 26 Nov 2025 13:30:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HVZLXSgh";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B7910E541
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:30:00 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-42b39d51dcfso4067939f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 05:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764163799; x=1764768599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7HTBin7eOO6bnDRDKJOf9MhTKmaoSUqwjS/S91ZAGa4=;
 b=HVZLXSghjBCdsoZ9YyzO8dN3Uf2xnImbNB3vJj1V09O0WXDWR4J2Nr1enykuRcMCE5
 9/4pymvq84BDMl953PLw6oEwqEm0k71kDrg8ihDonzTs66M8dKB4FyuxQHliVV0TzsMz
 3qOn0KYwWmvGSwEZMzhWjaWPO7ThlKu3FRZiQ8ioI5oEt6BQyhsvucphZ4nHOJSTLpO4
 84bBHIC14v2GSb3xC1hEM5dU0SxZtA0MQQfy/3PuAYrxWNxIugWWsSrk5gk5DiuFLHcE
 S7MssUoPaW0VsnWJm7SVUTCYMULApYHbgVSoiHuGiF16pK7FbtHmxIkG/0QxCbtxNl9L
 M57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163799; x=1764768599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7HTBin7eOO6bnDRDKJOf9MhTKmaoSUqwjS/S91ZAGa4=;
 b=RC/FHydFMwpVZPtCE+Kf9DDth9XGFh9yLEHQBwxrluVrxF3zd/XFajQNoRHaOxoV6U
 jDOerGBRM7QwXcJi7Avuo1MWWzkFQiI2bW5P8e30nOVl71iK3iKEHRd9SX+p8Yu5xL88
 FIFzdOC+z5u5nxHrRU1FGOjfH2MmZqMYZ4XvfxXNigEVU2Kg0wxd02QvncCok30GB68c
 UdD1IZwv7tp9Jz+TQG+n+g5kDXsHu20SVZvguzX42ZxwKStRx4YsDbT0YZxm+wp2rc7k
 zTCtBUONvV24mrX2EqgLCacb2mB9248rFTTalU+UGJiQbTm7JOIa+hT55MNKoMME5TkW
 Rt8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYRHgzAgqo3CcxhVPIo2gdaGZGdTRej2kvTMqK969GC6xSRh0X7PJTSfdj/c46P971HRIPJKIU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDq4PsCRGcjRSmiGYVBQv99Gf/UdH/0hrqP5BCbIId7T92+c+p
 MjTeDpLZxLTMo9obN24h0+AS/6OG8oKcfw2GuuYb5gCUXGlY0toa0Q8E
X-Gm-Gg: ASbGncvAjPCSBmaJ3C1z3R1tgknuGSNOa2PeKd1I8wvXMbVAtHTX7U1/m752ReNXKnr
 /JljHKNZSH+CTQCDZVpBOZM172FRRL5czJKWCFzjW/FPOx0l94RnCTc9U3zvZferDV0alosSfJS
 imLUf8zW1ksc0fAzyJ/75gwblxElpWiw5X6YGrjvU53PKGb3PG+JA2S1kZGJQheF4hczMvF3whO
 AKXH3qpdA/X5kPMCl3AKGbfrGC7XC7w5k8i4MEiW7fBFabNJZvExuspD2gxzkIM357XtJc2JKHI
 U0cKeFqJvPiJwdkLIAIlfh9LqJj3jwPQ3pqWlwy7plKkS4cVnY47Dr7SYI4amDOjQKK62W+PjF2
 getPwQ+KN8uTYGzxZhJu4m1okLR3BLL3KGAv47gt0W4zggXCx/2W/0HMFOaYzbQ5GZEpLIvA4fO
 xwXkHIXOFi2zB/zXR4Jl5sC2IAxB2s1fVHfUihu16Her95aqxqzycoYdrPdjhadKd99ZHvd22u6
 DRfp7vjNUnia4C/prw=
X-Google-Smtp-Source: AGHT+IHr5rueqhpa8868a+fqSx18if6qiet4tPvZ25F9AE7bzlvvMkQnf5Uuwg2Z2kaZsuQNjyvvyg==
X-Received: by 2002:a5d:64c7:0:b0:42b:4061:2416 with SMTP id
 ffacd0b85a97d-42cc1d19643mr20409584f8f.52.1764163799393; 
 Wed, 26 Nov 2025 05:29:59 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24D8E6005908B7D279C7B6B2.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:5908:b7d2:79c7:b6b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm40537696f8f.2.2025.11.26.05.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:29:58 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/10] drm/amdgpu/tonga_ih: Enable soft IRQ handler ring
Date: Wed, 26 Nov 2025 14:29:46 +0100
Message-ID: <20251126132952.150452-5-timur.kristof@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index 7d17ae56f901..ee8038df17e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -159,6 +159,9 @@ static int tonga_ih_irq_init(struct amdgpu_device *adev)
 	/* enable interrupts */
 	tonga_ih_enable_interrupts(adev);
 
+	if (adev->irq.ih_soft.ring_size)
+		adev->irq.ih_soft.enabled = true;
+
 	return 0;
 }
 
@@ -196,6 +199,9 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *adev,
 
 	wptr = le32_to_cpu(*ih->wptr_cpu);
 
+	if (ih == &adev->irq.ih_soft)
+		goto out;
+
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
 
@@ -306,6 +312,10 @@ static int tonga_ih_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
+	if (r)
+		return r;
+
 	adev->irq.ih.use_doorbell = true;
 	adev->irq.ih.doorbell_index = adev->doorbell_index.ih;
 
-- 
2.51.1

