Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E96FCCF9E4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 07:51:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D293410E8B3;
	Thu, 23 Oct 2025 07:51:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l3ZvOTHY";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269BE10E752
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 11:04:47 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47109187c32so31496595e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761131086; x=1761735886; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ec4fethFoS2+SPeTVw+Fwof3KrdKYWIF/kwJYkEKmFY=;
 b=l3ZvOTHYo5JjuLjxcjoTrC7Wx4WKjMFW3RVwoSA3f8hUEBqs8OE8bu72jrSj9UP0PI
 l0Y3Pz19HldafAfaCAjky16qtOcQF9x6h91o+WY5Ln48Jn+SZCdxzJAJAeLyxxL+MgYR
 OPJpzDQjbxrKcANt9yeGBLhTvDh0/S5HzgpjzL79u9M2eqblEAOjStei2qLPmO6ibw+4
 1qycKIlQLY5vzJyrLhcUORpfpYvfJw00/QreDsv8rosegcj0VONXEveo7SaLo7gZnUTH
 /kzBmNgmc4kSYFG8CYayT3v4lF5imtbJViGIe3AsiXgCsM2WXy5is98pLL/V56QBzqeW
 7q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761131086; x=1761735886;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ec4fethFoS2+SPeTVw+Fwof3KrdKYWIF/kwJYkEKmFY=;
 b=fClY4UGiH656JiArL4hhpPRqlOb3b+5vV4LkmIngK88yBi4e3P5DsugggMzc9x4P5w
 8C/NiuAwNbZGgDsPrvqo06zWcY4rZjV6J2cn0J3dXkFoJrH0cm2yK23r4yx/zgt8qTVZ
 zheCbowgx4VpVIJ0cEaOzPMC6YQcf7jKfEvvdJPfeeaeJiWuunFXENZKHh4V4PivoBSI
 VmIG0XLRM/5aYW5KLI1I5Hs2BO3SVZNYhf9qNTGa8/1mabR4gCDhJLxdhEYmORzC+iL8
 y8oL5dJBgDeS/+Hge+KGqGaAgTUwr4DhKg8nFGpY4QMnhT53zkdWtBXfyOnGoMh9i+dL
 ROAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUegqn3W14e25nfqj+DntAq4KHEbLECC53ntpLp9m9QBY+gaRx+OyiT9X6AjKgIpEBYm5NU5QuT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRDIA5ffZcqEJB8aHLRaXaQTEmSZxej2NWrrV0s2c7+z4o4FHM
 EK3wF9xH790ck4mFqHMdYjDzdw9KU91PyWNJ3fVRLgYfDVS5K7WeKehqDFW53V7efUU=
X-Gm-Gg: ASbGncvTQTLIwU2gclqFlFAjA7X+y7E+F5psExUB/RcPGa/k38Nh2WDMsA34yRqEVWO
 yeq2/H5bJ1g60UFIfSp31sXtVcNmcQKDjTJnTrPz995EP69ulwWD+pfs7cDEEtX98jx4Fi6DD9N
 hF/FYr9xx60783cO0WN1Jjh0Ka44qBJns4c15KsL/IoTXPcO/w4NOVDyWSKkO+Oy67C+1DdMv8r
 wyABqC9+tgZfKLq1gVZlgWecPTf/V5w3hkbdnAswZ6GH6yfgff4b+GUCASLm9cabzNtzFwiglk1
 jlFuqO9j0rKw7507XbPZ1lnu/CspAJco0JyOn0oOlb4W197tzjoT1cx/vJ6ygixwzx3JSxDB2ky
 /Zd9eobdo7PG6KiURWvC3wsWjwzpmCWRHu1mLqStoGd5PKo6tw9X9cx440TLzYb9ubHZZEWyQSp
 kGzTtZAgVk9qidhbaO
X-Google-Smtp-Source: AGHT+IGMYkocvaBnPACpDrQqTQlINhZBUKIMjE+J1fPKEeBjdhwvP+lt5c1FWsAPVXg7BnBQuKDcjw==
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id
 5b1f17b1804b1-4711791fbbbmr156254735e9.33.1761131085678; 
 Wed, 22 Oct 2025 04:04:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-47496d4b923sm33430975e9.14.2025.10.22.04.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 04:04:45 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:04:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/ras: delete an unnecessary NULL check
Message-ID: <aPi6SqcrGtBvK24S@stanley.mountain>
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

The list iterator in a list_for_each_entry() loop can never be NULL.
Delete the unnecessary NULL check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index 4067359bb299..03c4cddfbfd9 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -207,7 +207,7 @@ int ras_umc_log_pending_bad_bank(struct ras_core_context *ras_core)
 	mutex_lock(&ras_umc->pending_ecc_lock);
 	list_for_each_entry_safe(ecc_node,
 		tmp, &ras_umc->pending_ecc_list, node){
-		if (ecc_node && !ras_umc_log_bad_bank(ras_core, &ecc_node->ecc)) {
+		if (!ras_umc_log_bad_bank(ras_core, &ecc_node->ecc)) {
 			list_del(&ecc_node->node);
 			kfree(ecc_node);
 		}
-- 
2.51.0

