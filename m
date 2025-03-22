Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBF9C36008
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 18:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7807310E15F;
	Sat, 22 Mar 2025 18:38:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ffv1DuYM";
	dkim-atps=neutral
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A2A510E15B
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 18:37:56 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-7c54b651310so485097185a.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668675; x=1743273475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZbviwD+fHyd3+NeLaEwjiSHbxQr92I/3aRsXdYTH0YM=;
 b=ffv1DuYMgYD8JYtS0SacIubgNhdT16727Qopw0rKlSlpNGuIeJ9T+GXd1CmzX9LGoP
 JZTPv/B0SQK5/10O5siC0q1SM76I9j3B9e1lOAqWIeEEXtNTaxkJDayj72x69CC8yNMM
 caCd5zKA6Cnt7rV8CYm2Yh2Y+n16ymBFkctpqWzR5ZfNLBY8+gws1TcTmsbzTMOeO84+
 jjsypj0pWQhKfB5b0Vj7o72dqS2Fnm+EnMitBgxXiHdfuAqXfwpA7xX804iprVR3RKKx
 p+xZF8rvNYbHscRbF3uZwIA1EPSXIJbGRfgbdQjzxZm+gDnjPeK0/aBQr4ZVcXOHW88X
 njuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668675; x=1743273475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZbviwD+fHyd3+NeLaEwjiSHbxQr92I/3aRsXdYTH0YM=;
 b=hdZe3MOTjyGJtddsuF046/9K7RWolMf37uM++h5LU1AK1h8WFlV3ycGRQjpBMFxe3q
 hh9MoTrF0auw81LWQ+KDiq8o4MeCizYU8PQXf/AGeqfdM7MJPmMUYc4JnUJ9Xu5BDbZm
 lbZmCRjNLKNz0dulhs0g6CSw5T3BfucgWwANjjznvRs9efCqRkzga6fl80TFnK0Hh+qg
 RakcP72DLlgwG3Z1r/FjoWQ1csYwVX2/2yJHkqrTD3x9vW+usl0R7YVvufUIH4D4jZDS
 AQZlh84iNgpJXAqV4ezMjtIOOkJu/2VAg4/qto4bnLrDSN4CVH9OSgX/+rd9E4hFUXpx
 +ZIA==
X-Gm-Message-State: AOJu0YwoTAOZR9eghnFtOrJXO22o9w7kw3qUztf+9sLkn/CvEMPbq5/8
 e0xFHaS/EwO/GQF/o1kgdX2xNV3iCVY2DGUSQNueqGjAp1Ybyh2MzFdTkw==
X-Gm-Gg: ASbGncswSeumqdTzcg7eMf4kZz5O5zU5QF3540DoBMjsqZLxM+9M+GwzPHhOtgttzBD
 q+L5KRNbO1HVvTjNgdvgRCVC8m66E1mR9CH07KJmR1lSxNbT9Nw4f6TN0k+gosdQ2+avkYxkiFQ
 LHRAwwdJ/eeqHLuW+YEC2CQQoghTbPbumv5cX8qQ8tew1MNELRxoYU4JaNQgJ9MKTJSxuSovVlY
 KL8NISOYtNLilJfWbqbAnmdYSf1R0VVgg7YTx8WQq5wUW/BheOt8kIK3b+uiz42Nw7wKKVMPnXQ
 7uQHi9cDqULUO2MzwbqP3FQ45QdV88P0VkNSiD5Sqy3FpqunyafZrrnX4hEJqCW4ohPuQ9Xsuoh
 baA==
X-Google-Smtp-Source: AGHT+IFUCWTUPvDFtT/9YETxqh3byaB9Gb9O7moBxr278UyIVhaFz6g4N84IQIqGjRu9wSx7hnXOBQ==
X-Received: by 2002:a05:620a:d8c:b0:7c5:9993:ba7e with SMTP id
 af79cd13be357-7c5ba237673mr1284414385a.50.1742668675403; 
 Sat, 22 Mar 2025 11:37:55 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec688sm279895085a.64.2025.03.22.11.37.54
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:37:54 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: use cik_sdma_is_idle() in CIK SDMA
Date: Sat, 22 Mar 2025 14:37:43 -0400
Message-ID: <20250322183746.86002-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
References: <20250322183746.86002-1-alexandre.f.demers@gmail.com>
MIME-Version: 1.0
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

cik_sdma_is_idle() does exactly what we need, so use it.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index ede1a028d48d..e7c06ce7ffae 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -1038,14 +1038,10 @@ static bool cik_sdma_is_idle(void *handle)
 static int cik_sdma_wait_for_idle(struct amdgpu_ip_block *ip_block)
 {
 	unsigned i;
-	u32 tmp;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32(mmSRBM_STATUS2) & (SRBM_STATUS2__SDMA_BUSY_MASK |
-				SRBM_STATUS2__SDMA1_BUSY_MASK);
-
-		if (!tmp)
+		if (cik_sdma_is_idle(adev))
 			return 0;
 		udelay(1);
 	}
-- 
2.49.0

