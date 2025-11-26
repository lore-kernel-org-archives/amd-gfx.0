Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161A6D10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ED9610E595;
	Wed, 26 Nov 2025 13:30:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H1//JH0Y";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1507010E2AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:30:00 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-42b3b0d76fcso4180004f8f.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 05:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764163799; x=1764768599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjWeYLq7KP0+TibtxKS5Vc5g0zJyegFRPl9n3c/oWnQ=;
 b=H1//JH0YKq5R9fHEy+SeQB4vvYV/WG8+tEdor51wrbGjLvyCdbpmXlJBMBR9PEZBVa
 teYYqJb3gvawWH1kaasqcGq/OT9cR+UuvELjpg7GSc7t0TyfgPkDQLo7eLHbOSxPIemx
 pnxiYWZ89Hjc39iiplpFnjhumfnhbg/9Z8Z/tEKn5xTJx+p3kMxQJ53W2PRo++RKlqy+
 3gUq14gi5yEPTylOphfkP9IMPecissJqNhXIKPGDw5Tspu3Z/2bZiX6vRr8WV5ITMC+6
 dXWIE03xt5qUieZApK81MU8qsXIRAjpg1MOkLuoUFftybgfycNaNSmvKCh95OOII0dzy
 +vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764163799; x=1764768599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DjWeYLq7KP0+TibtxKS5Vc5g0zJyegFRPl9n3c/oWnQ=;
 b=Q5htakTAXEfSSU1d8aMc6yfsigK4U/6mV+fbOsbbmcU25cMclIpkX2N1h5WHaq3OWB
 8w2g01NsOhpn6BW0OZo04fRjfczxVtBjfks/tdEivFvP2qukKi6nSC6iSUQ6ri8Dvora
 bKfOKZI0pnLzHNLhXmhFRGPdrmTU2mms68toLiy47XqBHEilnkor1C01amaReNGH2P1W
 DFMrrsTVvR3/rqtdZwg7dg2wZjl1+bnEh13fxqMZOSNbMeCiDgv/abBxB97Qt30ERsFN
 hd7QQpRpy4pceXqaH1zKLLJxfBXVn/LiQxggGoVXdJltxHTweLc80lkNGc6W6jU1NSo6
 WSBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCURzrlynBdOPuQvQZxA+ACoVI8o/gPQ8QOPnS7CVE2B5/2atYzCbvsQuXTump+rvHiVIXtQqgE/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6DqS75+u3e00WyfRteur9JJeroNPBPMl/U8uNgqIkt7rL2neD
 ouJM8Q0rxEbBAjsuS2tnyk2N0dh61sU7qUUgr52Sxj+TzpcYhKL8+1ju
X-Gm-Gg: ASbGncv4YtHz+L9G7K1Y3OMiNHtZQrQ4CTGFq3zoTRpfwM5KbSmRfCJSqyu2dS9t2Gu
 Vsq6mt5Mpj00AYPlX9LPV334sHDkxgwLvK7ispBbz5HklwAWR18RTbROFlPD1U8FDa7F9Qs2c/+
 JeF6gnd1CAQooNmtwayR8ioxyrPyioi+uC5ifihYLmYr2s0rmIGk31e9aLSz76gVXgiX0Bt7huO
 c8NCxdNXAw0xogRY0ARt3+IkaS4xVH85S+nA6uzybvEqlxqiQFZZ+cpauKWezfpsy5xQpdZIoUG
 tyBf1cm2b4405lXTesCs5vawS8tYypBKOGIsc0jw8ABJdouj12KiF+AwtfaDZ5aw99vZMufd45v
 6MZvKixSTgW9oYZ9kz51BH5P9YSEQWb1ExilBDYGtAAa7cdCrORsekSP4fiETnNLfvLVp/SeE4b
 +xmvC/GsXR6a+2nBALrZKE+h9R5cya4BPfDpy9pQ4VjWmcHu8d7U5H5Ctt9d9P/qcpFEN+NaCCY
 IwsSdxX9UUrzF/UOwqfeIUuiSCjeQ==
X-Google-Smtp-Source: AGHT+IGBnPQSp+5MJNDNUG3xog+2EeZkwr+wjGi1v2gReuA2adohoFEq39ZVTOg2f14ZbCu5CENLsg==
X-Received: by 2002:a05:6000:1a8e:b0:3ff:17ac:a34b with SMTP id
 ffacd0b85a97d-42cc1d351ffmr19862429f8f.42.1764163798473; 
 Wed, 26 Nov 2025 05:29:58 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24D8E6005908B7D279C7B6B2.dsl.pool.telekom.hu.
 [2001:4c4e:24d8:e600:5908:b7d2:79c7:b6b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm40537696f8f.2.2025.11.26.05.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 05:29:58 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 03/10] drm/amdgpu/iceland_ih: Enable soft IRQ handler ring
Date: Wed, 26 Nov 2025 14:29:45 +0100
Message-ID: <20251126132952.150452-4-timur.kristof@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index 1317ede131b6..01cadf898c00 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -157,6 +157,9 @@ static int iceland_ih_irq_init(struct amdgpu_device *adev)
 	/* enable interrupts */
 	iceland_ih_enable_interrupts(adev);
 
+	if (adev->irq.ih_soft.ring_size)
+		adev->irq.ih_soft.enabled = true;
+
 	return 0;
 }
 
@@ -194,6 +197,9 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *adev,
 
 	wptr = le32_to_cpu(*ih->wptr_cpu);
 
+	if (ih == &adev->irq.ih_soft)
+		goto out;
+
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
 
@@ -296,6 +302,10 @@ static int iceland_ih_sw_init(struct amdgpu_ip_block *ip_block)
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

