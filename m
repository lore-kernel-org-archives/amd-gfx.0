Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC703CCFA13
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 18:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 524D210E9B6;
	Thu,  6 Nov 2025 18:46:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SSQB3jBz";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA1D710E9B5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 18:46:02 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-93514afb23dso684727241.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 10:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762454762; x=1763059562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kL35refeizf0dM4lsy9TfWXoqzgIt5xH5Mu+z3PI3XE=;
 b=SSQB3jBzsJkfSs99CKmVV8JAPcgmiQxY+lnJ0eSeArhf0WxMhwIXEbeEqcApLS/S8v
 pVnLeoGZawXoBf/H1hJrZQmLoLNIfAk1/f+qHHd+RAY/xwGzZQ0++GSq4lbEO64eCKEq
 S8YkjjD9HKs3fjbjkhma/ewHZhPDvAKUkwN6fW0bpjtuV2wxx2VCbaskpSC29yDDHyFw
 IYfvm/GfM5B2EvafNso0FVGkFZVm6m96KmXdsB5bpg9JKKIu0Laj67VK0Q094QpKgQzM
 EYp0yfXM0hQDj8O7IK5Ysry816IH/khJBY2adEPyjd/kM9c2o5E1lQD0RDGxtbQsPXU8
 VEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454762; x=1763059562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kL35refeizf0dM4lsy9TfWXoqzgIt5xH5Mu+z3PI3XE=;
 b=H2laquMzjcvxp3JEmwI4wJsvwKdmmJ/F2qbqIXQCpLg+qw5yJt9qnqlO9a4dde3RAV
 K8EoVv7lf6UnQ0Qlondf24UTqrwmReF+KH9t0aEtbASI3Ym97xNKlrEOQ1r46yhK/yFX
 mDOMmTyRZjJ/+d3rDyx48f4MxlCu//0HUbMNBGsCXt+xLkIib+Z0LuQbVaAn0kkFGQu6
 Pa+IRuuRi0Vw2rVE9/+HLYstvwprsv0NLFwLQ4PZTRblgP41XZnzxjzw0d5h8IsNau3g
 tRG/8Ar2SsnaTJMiYbIxCjqdqpEsMVHZu61B6n8uVA5qBvR96G6oSfuAHUF+Lf013aAv
 YLYQ==
X-Gm-Message-State: AOJu0Yw+IKspF1yXOxbriNCBDGaaGPWfE5rQiLciwoEY0fo/7ZoykCMo
 ZDsALJkj492aUGlKg2xENfCw+vzP1hYZPOL45pGwWigajx9lqCngnrSAmAZl1Ka5
X-Gm-Gg: ASbGnctrKeJ8VKlOZh23smzqeaTRDhM/ejYIAFqN9PJi1L3yS+mYzNQWUA13tkVAZ29
 NZYHQURlm2Mdcy3opZkT2pTamcZqboCehesBQMiVNRUbvsoum1X+gj1uCDAoClFQ6nsForfBWE0
 dxLEMZ0rSzObD9XMcVy6LaCsGL/46YQ0457hJXsZ9H4yoNujCdcfEMNahc2siAolN/HUWsU2csO
 gMcKv9ngZSCye2VlvoZbJpL+vN+Ys+6THeSjhlFPjaTtjbvL/sIqxO+oBXABslnQMHsHts3OyKz
 CYjOyTe0hg0nu/zOfBhQHHc8ee7kOwMU366E9ZhzTawT5q5Z+F4R9wsH7Z1Y/2D7q2lsTZ676cd
 Sd6kU+xRnhNOhsFNK9bf90oP+g9cdX+bwhHyvdkCJs83WwywOtt3OJHkL6bFbM1f7KcI+YxnLnM
 xugaNd6HmO1umicdt9D2Q=
X-Google-Smtp-Source: AGHT+IGJ6nETYAtXcOPns4mWHSE8y5FZ4aQGR0pDHQ/VJ5Q1i1bQtkSkNGtSeyDJZZP+So1RJHB+2A==
X-Received: by 2002:a05:6102:94c:b0:5db:ef7e:8dc9 with SMTP id
 ada2fe7eead31-5ddb225659cmr218951137.22.1762454761855; 
 Thu, 06 Nov 2025 10:46:01 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-559957fb3c1sm1810004e0c.12.2025.11.06.10.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:46:01 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 13/13] drm/amdgpu/vce1: Workaround PLL timeout on FirePro W9000
Date: Thu,  6 Nov 2025 19:44:48 +0100
Message-ID: <20251106184448.8099-14-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106184448.8099-1-timur.kristof@gmail.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
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

Sometimes the VCE PLL times out waiting for CTLACK/CTLACK2.
When it happens, the VCE still works, but much slower.
Observed on a Tahiti GPU, but not all:
- FirePro W9000 has the issue
- Radeon R9 280X not affected
- Radeon HD 7990 not affected

As a workaround, on the affected chip just don't put the
VCE PLL in sleep mode. Leaving the VCE PLL in bypass mode
or reset mode both work. Using bypass mode is simpler.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 9d769222784c..f7288372ee61 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1918,6 +1918,14 @@ static int si_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ecclk)
 		     ~VCEPLL_BYPASS_EN_MASK);
 
 	if (!evclk || !ecclk) {
+		/*
+		 * On some chips, the PLL takes way too long to get out of
+		 * sleep mode, causing a timeout waiting on CTLACK/CTLACK2.
+		 * Leave the PLL running in bypass mode.
+		 */
+		if (adev->pdev->device == 0x6780)
+			return 0;
+
 		/* Keep the Bypass mode, put PLL to sleep */
 		WREG32_SMC_P(CG_VCEPLL_FUNC_CNTL, VCEPLL_SLEEP_MASK,
 			     ~VCEPLL_SLEEP_MASK);
-- 
2.51.0

