Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276B6C43327
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEAAE10F02A;
	Wed,  1 Jul 2026 16:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YzoEy+5P";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993DB10F02A
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:51 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493c1950518so4663725e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922670; x=1783527470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EYi43a5oU0PJiWAzBW953N0ns5EY6CwN+MnmDXquGU=;
 b=YzoEy+5PtdnsmTi2pjT893ZQ28p94sxgrJNRNgPTBJ6188nA7lmS7tFPP7GCn3MK95
 HEhOyF3IKVFFJwKj6TI7U7AiASTjxFQBAn4wxx11UXp9i9J8Vlocb4b4uNDLHYyuyLDy
 6mxX3zh4C8nVvEcV/sAia+wok1pmYtfG9YavjZErTsAQ3SpTezKyP+9ZEpsn92M2cIM0
 a0uE3wO3jorDxjKiKSQDVobehz28GT6V6RZ0OYM97ilPSpbQIjdDWp3kN/bSPbovp3GD
 gen6mrF4jaUOu1UH5cbZRHj/uBqA1wdEqz6Vx+9paDdTXv4pEHON0u4ZK+/uxyo8BLZ9
 E1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922670; x=1783527470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7EYi43a5oU0PJiWAzBW953N0ns5EY6CwN+MnmDXquGU=;
 b=X49Z7FW9pZqL3nXlmFJpjnrbJ5o0bBJiU/1XGoaG5YBd9soho+JvobL2tGcRpFtQ71
 sBHIKfXSLTgaEb6HQdQNd10YFfxbeb9TtmV4c09GKcgZnuVVXAa53d4fjkSkB1n6tXJH
 egRRnwwTz1phhtQXgN9q8qUDuf7IiPYhyOgHq4MCYT26dgQ+aMlTsi6BKLkfyNEUJ2YK
 /n6UL+Rz42HD36+qOaPB29ijtgak1iwRsjKigYchGWk7XeMp2XaXOoTzRawPdoiRfVzP
 hrqY8gbx8b02tb5ECNg0hrXs6fLJ8c5cnHB+YPEykn0bgmW9j0Pfs1ahFq67/cwCIKmw
 8S/w==
X-Gm-Message-State: AOJu0YxnDFt+VoErS7jz6CX/bcyZxfODHemqasG5+cnECWT0ykf7ftOb
 bLXOMxnuGs3AbPf9mu0AeB5a0FbVdEghipj3/hfa5UAIQazWGvOxT41RBdQMj6+E
X-Gm-Gg: AfdE7clQSEyH9myM5HVL6LUIZciMqVQHDA7toyiOSkMpGdXU7qQbQrGBHFXBAxms78R
 IGPToEa/SwhFQOU6gTzrfIdUyhrSjzv/I29qyq/3O5SIRmT2M+N1IHQYCH9Ty2Mh0wLQBMhoOS9
 Y+b5XeyVHnWFOUwESeca714SLXrGzx8fSbek4fX8FLiOi8jVUUkrd/sQuaDi1uraDvCYBi/P9RI
 DZgRA95Nkgv6uQl9Edfq4Zxy5Ji5JTBBJ2xQg8Ni0Hz62IwZAi7tc51xlzkG51dNCd+22yuAscZ
 pyOeNZbGwJUOGE+338XnO/SJtGhbhyT56WNfzvCxQsAgbiXZqhSf4NVNxwpaOyPc98i3QCBv/+C
 4IJFzxuyOwK9O/5l9tMC/CEJEyG/yrLVbBS1dcO/DGF9GlIIZELyxGUdKd6aNOyxKD5IGz35qV7
 MPxMLFq8yu5t4/OluC
X-Received: by 2002:a05:600c:e548:20b0:493:c2ac:58f with SMTP id
 5b1f17b1804b1-493c2ac0743mr23597465e9.8.1782922670030; 
 Wed, 01 Jul 2026 09:17:50 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:49 -0700 (PDT)
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
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 13/14] drm/amdgpu/ih6.0: Enable retry CAM on Navi 3 dGPUs
Date: Wed,  1 Jul 2026 18:17:20 +0200
Message-ID: <20260701161721.85681-14-timur.kristof@gmail.com>
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

The retry CAM can filter interrupts which occur repeatedly,
such as page fault interrupts when retry faults are enabled.
This makes processing those interrupts much more efficient,
because the CPU won't have to deal with processing the same
interrupt repeatedly.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index a97c85b0cb99..bbe399f9e233 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -397,6 +397,16 @@ static int ih_v6_0_irq_init(struct amdgpu_device *adev)
 
 	pci_set_master(adev->pdev);
 
+	if (!(adev->flags & AMD_IS_APU)) {
+		/* Enable IH Retry CAM */
+		tmp = RREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL);
+		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE, 1);
+		tmp = REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, CAM_SIZE, 0xF);
+		WREG32_SOC15(OSSSYS, 0, regIH_RETRY_INT_CAM_CNTL, tmp);
+
+		adev->irq.retry_cam_enabled = true;
+	}
+
 	/* enable interrupts */
 	ret = ih_v6_0_toggle_interrupts(adev, true);
 	if (ret)
-- 
2.54.0

