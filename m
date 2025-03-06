Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C981C28B23
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 14:05:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2573310E99C;
	Thu,  6 Mar 2025 14:05:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MuIZQ648";
	dkim-atps=neutral
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E8110E07A
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 10:36:12 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id
 2adb3069b0e04-549662705ffso564755e87.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 02:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741257371; x=1741862171; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6MVkXRPG0DPog78nLFqW2ZPXVGeJ5h1mmD/8HDt9MY4=;
 b=MuIZQ648UFZnI1tTa335r70SSzkMTIYmbxSpgVYvyS38TBDcDt3xjLBXxMgQG95sIE
 3zyNSuBhLOtXeiEuq0lOPCTxVx3sDl9U+WFI+Zgii5yHZ823UZl02DqRWX+JBXxB9Dfx
 RfPCxYJTpDATzV0Xb3Mnd+ea14gyJCZ7ojuheqa4ourKc5Ta+idV6H2zMqVhlMXPBDsO
 R3Uq/a7tZQeRP9K0daeHwkDYeNTfF1UBBuj1kX5eWWeZU1NWDH1ERxM8N8YcTgZN9ZtT
 IRZyVbIBCDz+ygG/h+G7gLCS8mjd4RXsRC8iyjSh0TIHpt5moIvp5UECeBzc/6e36xKP
 CBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741257371; x=1741862171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6MVkXRPG0DPog78nLFqW2ZPXVGeJ5h1mmD/8HDt9MY4=;
 b=fSS1WBzpGjsyd7q1XQl8NVr+c0ZZeL1bqGNG0aukLcQ9dM4TUg4fyNGeoJ0cJSDgqH
 FHuEjAuk31l6GGs7NrfBHau724jcngmg2PqXVCBhIdAHBRbqlONY8/9Q1vUlEK2fc97u
 vaXjmPHEaj3eiaBgzx5Sx5oQFxbl2wQckLoh04LKRdmwuVUcL4Sy+oG7q8R4vYvYWOr9
 FJgGi0GwqbAReG9/T1RSL/4Wmg/0VVH9oQyhB84SKLcz9reuxxTdXs5GeZm6PDoY9O3w
 nCbHYobrJ1S0YdKwSH9yBcibruIxd49mwqAchWJtgcDi/XhqzwtqXVYlp4vtP61dLo6N
 ZJ7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxKnFpZVESzKOmIchDJomn+1qcY9yCyh3i2VEsrf3LYDeQDM2BNDneoLCPzizhtb1E1LbCpL+b@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxla0w0GZyydYDQSHG+MYnRkguCdYnJlxOl7DUdXEx9Dyf0K/d4
 3yp6ATCwQMUcEjehVfm0CX3/q8gcGwq/VY5S1RCwsaBAM8rQq4sg
X-Gm-Gg: ASbGncvXrtAj0h8hikfglBOTF+S2boGs0gLHNJUobrW/cgMTtG/Pwsa0tsQpo/y11lF
 flOskHVQQ4dWkcTn0chWqegxvL2bsc+pajpDuWoA/vxLfKGFw28XJ96ZdA+QTtQA1Z1277Pf6mT
 7pRdXuTcvywtU7Ri/ijyuAjj8vN9/fxgRvOYKHDb/ktY6NACuzNs1BH7551ciZYV3AVuTGt8kVo
 XiO1i9147swPqTxEWgNFmJwmzDh3oBBLW3nNwnDFyQJu7u8ze++vbOQDNGNidvpaAp6+AnR3Pqb
 2g5pJpb9Dl6IE5ytV5V0rK/137KcigmSqgytRoGfOJZGrIM/6WItvUdmte53iRXvY70jBClZO42
 cbzIiwwmEVpd4BTR2+2+rDGnHZONhsIPu8C7GXzh/vH4=
X-Google-Smtp-Source: AGHT+IG6KtRDh+F69rV7hy/nuHw4J4sKnbzSyyuUdpRjtB7N7ZDfH8cEooEy0RcqsW/KaB1XUi9UXA==
X-Received: by 2002:a05:6512:1392:b0:549:8d60:ca76 with SMTP id
 2adb3069b0e04-5498d60cb90mr341916e87.38.1741257370731; 
 Thu, 06 Mar 2025 02:36:10 -0800 (PST)
Received: from localhost.localdomain
 (mm-87-36-215-37.mfilial.dynamic.pppoe.byfly.by. [37.215.36.87])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5498ae46646sm138150e87.46.2025.03.06.02.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 02:36:10 -0800 (PST)
From: Aliaksei Urbanski <aliaksei.urbanski@gmail.com>
To: Aliaksei Urbanski <aliaksei.urbanski@gmail.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Rosen Penev <rosenp@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix missing .is_two_pixels_per_container
Date: Thu,  6 Mar 2025 13:36:03 +0300
Message-ID: <20250306103603.23350-1-aliaksei.urbanski@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Mar 2025 14:05:15 +0000
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

Starting from 6.11, AMDGPU driver, while being loaded with amdgpu.dc=1,
due to lack of .is_two_pixels_per_container function in dce60_tg_funcs,
causes a NULL pointer dereference on PCs with old GPUs, such as R9 280X.

So this fix adds missing .is_two_pixels_per_container to dce60_tg_funcs.

Reported-by: Rosen Penev <rosenp@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3942
Fixes: e6a901a00822 ("drm/amd/display: use even ODM slice width for two pixels per container")
Cc: <stable@vger.kernel.org> # 6.11+
Signed-off-by: Aliaksei Urbanski <aliaksei.urbanski@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
index e5fb0e8333..e691a1cf33 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
@@ -239,6 +239,7 @@ static const struct timing_generator_funcs dce60_tg_funcs = {
 				dce60_timing_generator_enable_advanced_request,
 		.configure_crc = dce60_configure_crc,
 		.get_crc = dce110_get_crc,
+		.is_two_pixels_per_container = dce110_is_two_pixels_per_container,
 };
 
 void dce60_timing_generator_construct(
-- 
2.48.1

