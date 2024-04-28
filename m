Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5107EC19F4F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 14:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8738B112372;
	Sun, 28 Apr 2024 14:06:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="glC072xR";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F6BD10FF8A
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 12:57:06 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-a58eb9a42d9so111604966b.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 05:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714309024; x=1714913824; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ng058NZ9Nj+W4KweKWLHemyFc1EwGYUwsROdFC21IRA=;
 b=glC072xRjmlpRUWDySWNoKYYQgsr8ZFMpSW9IKQAgEaDHUDq8FC6kxcvv1ZehYmcPM
 LgLynI5y9xsUfKle31AqW3kGUrDv27iJyPHVTrGaEcUbcGu9Pub2QpUxl3esInGP7WkO
 QhRsesnpnrUrJewoIHNRSUicv+9szzdb4Xg0zEIVdS0mch8BFIdmy6E6y/YFyUY0en9t
 bCYGSOUTVD++pj8twhJVhY819lKOM6cSS7XLMVvTwDYG+50eLpYxo3bmD6tLFgrhTRLx
 kIpzAA5k4Ug21IkTMZ6D3G2Tl5LS79cNzHm/NiEgMSrD0cTFTQDkgwKNnxmVZ24MO9Ko
 nbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714309024; x=1714913824;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ng058NZ9Nj+W4KweKWLHemyFc1EwGYUwsROdFC21IRA=;
 b=cEzAZVe01vqBDnjSgwfnp/vIg2rBBjJ8mzfY05PIydBegP7cMWwKoDKUprZ+0RWAgc
 DmdpqKLR8FAbJ+oovqjWEx3poaFL2lwhDzrrcJeSczvlCL2+/mCEKKA39yDASWGMUZCJ
 WXTpA/gV96Wa0xt9gF+4OidWBNZA/yfTbPfzUTctH8qxF5tQDWDqU4QXU23BrVrDf4U3
 Eg/7gb1HEXUFE/5F6jnhZzocgYmacfkwO8CVHQan9dUS43eoI79mprXeeznTMcmnW+cb
 jDAHzwUOHvwrK3hiG3Cf6kOJuwfGHToDdxhV7oFnxLKYgLBbMywqgOenPrsFQcPfOpEg
 jtFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtmfzTWNABk1C4VyXpsQXACGjE6AW5UcPxh57Iwpuq1qDvf91GtrjGtHVcZuA0m7z5XkCCDzvK+ScOq8TyIa+Sn6e59+1XIfkG8lBBtA==
X-Gm-Message-State: AOJu0Yy6cdk7qWBCYMNSpM3ycJ9J4bRiCdM2mVqzzsGQJtfVu5boC9Ub
 UwNlnRb30nvisax8JotBCM2BW+nEjVHtktmQlvDtg5ayX9MezOopWVsDvaxEoGw=
X-Google-Smtp-Source: AGHT+IF2bconLYEiVsCFSWzXhwOMR/6nTlbaxbFyyM1sjiNBblck1WsWiEU8lcUPzjFP3RiywB5d8Q==
X-Received: by 2002:a17:906:13c9:b0:a58:8fa6:df18 with SMTP id
 g9-20020a17090613c900b00a588fa6df18mr4813693ejc.41.1714309024203; 
 Sun, 28 Apr 2024 05:57:04 -0700 (PDT)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 e20-20020a170906315400b00a5591a644c8sm10726019eje.17.2024.04.28.05.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Apr 2024 05:57:03 -0700 (PDT)
Date: Sun, 28 Apr 2024 15:57:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bob Zhou <bob.zhou@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>,
 Guchun Chen <guchun.chen@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Fix signedness bug in sdma_v4_0_process_trap_irq()
Message-ID: <afb229a9-3f18-44cb-b305-5fbb2e1b4ee3@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Sun, 28 Apr 2024 14:06:41 +0000
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

The "instance" variable needs to be signed for the error handling to work.

Fixes: b34ddc71267a ("drm/amdgpu: add error handle to avoid out-of-bounds")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 101038395c3b..772604feb6ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2017,7 +2017,7 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
-	uint32_t instance;
+	int instance;
 
 	DRM_DEBUG("IH: SDMA trap\n");
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
-- 
2.43.0

