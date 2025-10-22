Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1AACCD1BC
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 07:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F134910E8AC;
	Thu, 23 Oct 2025 07:51:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Eo7pnWJI";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235E810E74D
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 11:03:00 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso50100195e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761130978; x=1761735778; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w9oIpyKZKP65JjkSPCQNgE2Eec7phDpEBv4WlPPRGpA=;
 b=Eo7pnWJI6w9V7dNlBAG0qVONBUH5nWJ9jiKvFsh5qJ2zTA/1HHOBndSDeVv/SjqfPO
 4fqybjOdcRKtHuLduDUbpWzrBye1s5lzdrJZkUnv/8YYImjnkRtSIZCaS/smBCVivXAy
 c5+JCmPB6bzaUFws/C8jKRSA+IgXb+4uZ2NF0Aajd0VjRsH7C1scI/jyP+ssIrt8FZ6q
 LGzmDB9lkYRMKhEu4bQqYB0iP3dD5kAy82tVmZRuOUbCd/FUZ8am0Qv/dwvOdWwbP3Js
 u6Wegc5T5RaF+1fGn47AASniUWRNLMnutgcUWq4Vs0pdTCuTtiCChRrXIoX7BbKt+Rf2
 K3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761130978; x=1761735778;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w9oIpyKZKP65JjkSPCQNgE2Eec7phDpEBv4WlPPRGpA=;
 b=WoQk8pJIpZ70g0m/htcoiO6EBpi74Iku0/ebG2JfhCN79CHewkgEQVMqaP5R5H1FKs
 O005RlwysqWPwaBB86PldMvD1rpCT0ELHRVi8V8XhEJZhd08+6dx3nNe5tZKE/ol5cDT
 XiCRHBM6SGGT6FmFy5oK75EaQMgdcqiNoUBL5vnxDB5pdCTZHrWTKyMnUB4qt5uhNLKO
 vFulwT1Lykeu4qwsLCAn93S/wvFUUv4kurHqz04DEWNiCuDHjTT4JzSDEwXxvc+fraET
 IuPtSJs/sRpeDwqcpdNfbSX0ETziYfp6OxXdHolCSI5Y+VNZqg9jbHBOS+WTVP3PiMpl
 2tig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmAxUvz1Y0P2W/eklspx1JehH4WZ3W9A3idvVVA7lzacVZ3URUA57Q4ntsdtxBlRjJwHbGeIAa@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yynp6rp8XI3MSRm2QX4ww40K0SfxEEdqc4eROJFM7m284XnUTD5
 pktlmuQn7gDmt+Bmw7+X4JpBNJ0wKQZCl6qtt3IfeHF+GMn0NLAKuz/n/VbfKfu7Mgc=
X-Gm-Gg: ASbGncvL0jFm/7owdIsBY9Ls8AOS35vPhl5neH5edlxk3c+lplWqV+pkUYHU7uUCJNc
 bXOZ7q6Bf7kZu+de0srDe+ALom9Q/xG0WpBxzcf4dIAxGDOYdBP51F6n/zU1pqF920lFh4vjy2b
 OE2jm3RiXyljyJQrSoiSAGkD34Ac6OHbivLspRf5ZDrtRC1Mr9x6jGSFXnl/3ARD4kZJQRTDsHp
 +5FIPJ6XMkOM38RFhktuQN3+YOLVCGN5QLQlzsOjUZyzbiJfWab9ZNlGWCifpi91ecSRRRtdG4c
 nvi64XcVqWIUM6+tB0ppVBc0ISmUw8GgBkLmmS+P5PWKlpSA2ZOOhD16X5WA540xPYdoDkaVQc/
 o8aLKQteegW+EVZMvZUQ2tIVkkEZbReQ4YGjTS/n+dBP80hNj4TQ0mkz/CNh19vCAHixQsqsoa5
 4I22Hhcww5Amt6RAPu
X-Google-Smtp-Source: AGHT+IHuoJkLRfik10AD7NBPZIudPe/zz0dSg5CN+bjMkIVUA3hu11mzQRZgc9RP/6950DlYAOSGLQ==
X-Received: by 2002:a05:600c:5298:b0:46e:432f:32ab with SMTP id
 5b1f17b1804b1-4711791d1e3mr152626135e9.33.1761130978504; 
 Wed, 22 Oct 2025 04:02:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47494ae5510sm35646435e9.3.2025.10.22.04.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 04:02:58 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:02:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Liu01 Tong <Tong.Liu01@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amdgpu: unlock and cleanup on error in
 amdgpu_cs_parser_bos()
Message-ID: <aPi53iS_z4y4uVef@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 23 Oct 2025 07:51:01 +0000
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

If amdgpu_hmm_range_alloc() fails then free the previous iterations and
call mutex_unlock(&p->bo_list->bo_list_mutex) before returning.

Fixes: e095b55155ef ("drm/amdgpu: use user provided hmm_range buffer in amdgpu_ttm_tt_get_user_pages")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ecdfe6cb36cc..dac0b15823f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -892,8 +892,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		struct amdgpu_bo *bo = e->bo;
 
 		e->range = amdgpu_hmm_range_alloc(NULL);
-		if (unlikely(!e->range))
-			return -ENOMEM;
+		if (unlikely(!e->range)) {
+			r = -ENOMEM;
+			goto out_free_user_pages;
+		}
 
 		r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
 		if (r)
-- 
2.51.0

