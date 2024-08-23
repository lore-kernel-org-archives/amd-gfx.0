Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAEFC531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 13:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A71310E640;
	Fri, 23 Aug 2024 13:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="osSw7uxD";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F7A510E622
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 12:50:37 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-428101fa30aso15764645e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 05:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724417435; x=1725022235; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wglUMOfSKj/CJM1zOfzFbHWNacB0avO+XJafuxMQMWw=;
 b=osSw7uxDPifzrVL2njVSz5RDT13sIz3nbZPxIIgXTpRaeTgAEXT2EAKPazKXMTO4Px
 SrU0oeWp7g/QU+R1qiZQl5Q/z3FKHfQnXDa4eutEPaGULIQ1gYtC4XhYmcM1ettdJ1Lt
 4CwbeUu9KH4qq3A/Ff4RjiocajDcZSJVFpKCJ0dMsel6Zvv5t/yxX54rJ5SsPxhUdOjb
 sUhNBbtxvrUYyoKFXjjlpX8cqFMvFrKNAPMGVmg0WgIuxpKGd0xdBYOJMLHZE6xy/dCd
 rPZyv9/uP7bJRGj3GYF5LGs5S7XxbR34Jt2U69zH1AGu8H7QidZLsZu81hmkfdWnH4zo
 /lDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724417435; x=1725022235;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wglUMOfSKj/CJM1zOfzFbHWNacB0avO+XJafuxMQMWw=;
 b=sfmyN4jarG1CGGV2G69kWjSovuru320AHIe++jA9ksNDZftPG1RSZ43Nxq4ja5LAO3
 wyxiwMdHbazGALOk/zvMPTZqMtxpJelCuySDLjaorttCTVk4XMxjwmYo9dea24/C7zeV
 ZXhCs4K5E2ztN2xxB12uBTPy4tZUzZNX31sCt78JGQ6ers9VIscWEL5ZAVbwcDgELp9i
 ZPUM6blUUyPyab7nLpSzKU7paD5hsWl7erV5Pb6GjHO18lgsiqPuGYcSQ/sJiiJ3YWO5
 uk+ZzKycMKcklNbOMI6GLXts2KX/xqnvbrkTOyVGbLtMiU29Ikr2iMIwyTRL2GAjNK7T
 a9Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVptzZFcInvAb1BGNonGUsR/82qQTmRe4d3LLkT/PegdZC6RfkALLv8zstK4FQzX8/2caGoIhCG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBZ8H7oetQYApEdtlTRMKPE2S0RXPYaUmqAJ5iPpYKEEXywnc+
 XZrhusJTJn31FBT4U5kRCsTWpQN+dW3hkOjxuIchFvWobFsROj3l4B1An2q23hQ=
X-Google-Smtp-Source: AGHT+IFLiLazjFQT+RbARqd6XebDKnhmp2PsLFcYq7T4M8t9bB2PBe0YloLgYQ2LGsntaXnC81G06g==
X-Received: by 2002:a05:600c:4f14:b0:426:6f81:d235 with SMTP id
 5b1f17b1804b1-42acc8dcb19mr17146615e9.15.1724417435283; 
 Fri, 23 Aug 2024 05:50:35 -0700 (PDT)
Received: from localhost ([196.207.164.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37308265ae6sm4074861f8f.109.2024.08.23.05.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 05:50:34 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:50:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Chaitanya Dhere <chaitanya.dhere@amd.com>,
 Austin Zheng <Austin.Zheng@amd.com>
Cc: Jun Lei <jun.lei@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Hung <alex.hung@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dillon Varone <dillon.varone@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/display: fix some indenting in
 CalculatePrefetchSchedule()
Message-ID: <f57c247f-ba47-4318-b2ee-75aef1726503@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Fri, 23 Aug 2024 13:06:47 +0000
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

These tabs were deleted accidentally in commit d07722e1fc74 ("drm/amd/display:
DML2.1 Reintegration for Various Fixes").  Add them back.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 .../dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index e2c45e498664..7d287b07108f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -5612,8 +5612,8 @@ static bool CalculatePrefetchSchedule(struct dml2_core_internal_scratch *scratch
 			s->TimeForFetchingVM = s->Tvm_equ;
 			s->TimeForFetchingRowInVBlank = s->Tr0_equ;
 
-		*p->dst_y_per_vm_vblank = math_ceil2(4.0 * s->TimeForFetchingVM / s->LineTime, 1.0) / 4.0;
-		*p->dst_y_per_row_vblank = math_ceil2(4.0 * s->TimeForFetchingRowInVBlank / s->LineTime, 1.0) / 4.0;
+			*p->dst_y_per_vm_vblank = math_ceil2(4.0 * s->TimeForFetchingVM / s->LineTime, 1.0) / 4.0;
+			*p->dst_y_per_row_vblank = math_ceil2(4.0 * s->TimeForFetchingRowInVBlank / s->LineTime, 1.0) / 4.0;
 
 #ifdef __DML_VBA_DEBUG__
 			dml2_printf("DML::%s: Using equ bw scheduling for prefetch\n", __func__);
-- 
2.43.0

