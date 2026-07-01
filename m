Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93B7C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C48C10EFBC;
	Wed,  1 Jul 2026 16:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FpEiMlQ5";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70EB810EFBC
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:41 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493c4ce68fbso178155e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922660; x=1783527460; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwiCBKCT2C+BQ2/OA9r19z26V1Q/P0Sd4sBcSdmyQ1I=;
 b=FpEiMlQ5l0UxIu21U2PTiatGq9ngYra27KOjFx1rPwjA94QNLuqkOjj6y4Nf71dTiW
 DxsEmMz8al+hWAWzSIq2Zh6MnFW9C9EoxBEB9fxoVqMnPRGBfwo+g08VexoOhvqsEW6x
 Hx499gqwYo5eL23aJUFA5t+CB3q1ZE6Kj28URoczQSbxCqEEH3U2jH4yxnVS6zZmGIj3
 cOcJc4ku9QheXOS8AIyOQOSQeD4Jdrvp0n7BzGPWQDb2zh27dRtMxXgisPZYsAiUAS1c
 M58TokHIclRhUtPIwvwqdt98kxDp65gfwIkB/SbAqJ4I2Vi7MpE2CL5kJ/MVUtLowqqP
 XmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922660; x=1783527460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MwiCBKCT2C+BQ2/OA9r19z26V1Q/P0Sd4sBcSdmyQ1I=;
 b=lj/xD9vZBWWc666uhmYSxH0OLneo1mA8F/+dFb96tsKqhfALwGaN+PbEqSYdsesLgT
 U3FnBKCqArYD4bACPHcdtcOiXy3TKHYkv501JgGHahtsrov9d6h4FPOJIGJCDcRnv4fs
 6YliG7jcAZtAqy+shuWqLgGZZZc1vdERqStWa578KRPuldfTaQrFoovMdoLBMG8JT/Nx
 gVuoe5u82TNrSPi+0i97cxd/4jb7IK6uQd23V4NY54gnGXcEf9QaQSqXokDmmc+vK5FF
 eaifRq5klDQ5BnhUW7DrfiimMa7Ky7qu5/MGqzCMWZpWNTcwH4EvRNnQSIJMHhVgnBku
 zN6g==
X-Gm-Message-State: AOJu0YyVgCFxljLnzWEjgpyWr2Vg+x02CoZidq2iZqwsKRqM771cdZK6
 Dwy9Kq7TsCDF1GK4Rl/zFtIhLvNu38q3lzXhdJ4PhakBvHrAQfgImAlbivMVWJWs
X-Gm-Gg: AfdE7cndUBEtTlBVmIh467ZsvPmki4ukEPfBCNQ/EsA66q6xcOC4xYr5hJbHydAoXmM
 fC0a0cdLac6eh6sj5B/and8GjdFQkrE670sZvflGZzhjEVzQJLnGUGamz7R+xXnrEM4aenf8ssj
 f9amoNJn++1F03HlIb5cqsEtbcMB3afqndP0uXY2l+fZ+XFPvlTBUUdgVKxuR+Nkwac//Zm7bRD
 HOdhBnxcL+d92JPK/IWHFSeeg+Fd04oOfe6tc1RiIdrnbOpDRNwWo78JIWJO4Zku45msZPrLYSf
 iI2y/Gm17H53VE1ulbjAL37Hh5NPe08PHxiugC8ajWpdWDneH4NRJj8Rqh2DIMvNyXchDJV5Qs+
 2MAvj2ES1IvZ4OfG9YR8N4p5jI+i27pUf+dzHt1mU22KTfIqozppngzaxqiXArRJIwsBeRob32q
 JoMkOFYhQ3WGblIeDj
X-Received: by 2002:a05:600c:5883:b0:493:b6ee:fcb7 with SMTP id
 5b1f17b1804b1-493c2b506d8mr25670745e9.14.1782922659745; 
 Wed, 01 Jul 2026 09:17:39 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:39 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 06/14] drm/amdgpu/ih7.0: Use IH_SW_RING_SIZE for soft IH ring
 instead of PAGE_SIZE
Date: Wed,  1 Jul 2026 18:17:13 +0200
Message-ID: <20260701161721.85681-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701161721.85681-1-timur.kristof@gmail.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
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

When there are a lot of retry faults happening, the soft IH ring
can fill up really quickly and possibly overflow. PAGE_SIZE was
too small, use IH_SW_RING_SIZE to match what other GPU generations
are doing.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
index 24be9d726428..f1de6450a31d 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
@@ -601,7 +601,6 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 	bool use_bus_addr;
-	unsigned int sw_ring_size;
 
 	r = amdgpu_irq_add_id(adev, SOC21_IH_CLIENTID_IH, 0,
 			      &adev->irq.self_irq);
@@ -633,9 +632,7 @@ static int ih_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	/* initialize ih control register offset */
 	ih_v7_0_init_register_offset(adev);
 
-	sw_ring_size = (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) == IP_VERSION(7, 1, 0)) ?
-			IH_SW_RING_SIZE : PAGE_SIZE;
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, sw_ring_size, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
-- 
2.54.0

