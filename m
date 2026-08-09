Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B9BC5AC82
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7214110E180;
	Mon, 10 Aug 2026 06:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VRt/31eJ";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE1210E115
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2026 08:49:53 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-38e347638adso1005422a91.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Aug 2026 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786265392; x=1786870192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yOuPd/8nIM02AL24kWbQs53dFhNPEGw5UKtvK4sm+fI=;
 b=VRt/31eJLPC7bcox77zRXJbfN6aSnEwOWUUCLKcAQ8KBqPFWUxbt7iJvdfgUkeBWc3
 pwwJBaH10dVa0ANrPbbKldbibihVkz4z2gndC8UDQeZGL+O6HxFiZLm68ty9eBC0KJHV
 XX9simOJUasRkDkA12aMwblpFY3F08bzaA3LDQ76vAd6WAC898IPHxBUu46hxmRBcr+2
 oyjZmjbHdBiiCRbmQe/EU8durzlyX7yWK0h3OGpswfGcl/7gG9rX55JrW/omPTrSnnXx
 y46TJm1/YX+3IhE/C0JMmFP1tIP9GosVAvzEPrjJSFdj97hLmwOt8XewdxWINIiuHUbm
 Dz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786265392; x=1786870192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yOuPd/8nIM02AL24kWbQs53dFhNPEGw5UKtvK4sm+fI=;
 b=r4sskloioL6Ebz1j6ldoJ3Vg5vTtX1SBXuC4hr5bqVgAKOq0ppvIV8sXJ6NtoHRp+P
 wAJEjDI7VheRYsuk/hPy2BVRJwLTgyGYmDBY6Tpn9k3e+/eOxpJLOCjsCj40QfnrlHyg
 D6rVrPAAusbJzCwpYhVGk2qr8Vtc9muQ1YWKOWNinHVWxh+kSydUpkdp6iTrEYNg+DEd
 DpPqE+gJaNVd4MiG1i8cCA0Dy6nm5DDmJv0wdPZndo7z/HiF7zXvjaWLsQwmegdjB7YF
 DoPX93RJ40wWPjY5P6hUhP0WDi7cw8m1JIBnaGyLYRyLmnxHYQIsVKBkS2GhtmX2i7rT
 8G/w==
X-Gm-Message-State: AOJu0Yw08B7Mlrza6ZyyOEXPweJRurrxx+5tVKUMbz8f4mWh56wTbsRk
 ND/BMA1RCMXcYA23/pYp1khuTBrUoPe60JdS85C922q0u+HNla8haw3g
X-Gm-Gg: AR+sD119H6s9DTCsBL80i3pzukJp1YwAi8oPpo36cwWYHK27ta13nSJquXTtT8BlcOo
 jgk3thodOiSlVU+cUD+9vprwd2z1mgL291eYGa5mpBuMiZdoVVsca82nPM+Xs6sGxmlJbNPCIpo
 SHdcNNTGGBNt9UIJT75Xd9lCuSbHka1pCeKG0dGg6SonyJCwbBAHCu4qC8ps8nv7ixAYFiKAJwX
 gALRQQR36YXQ2vF/bbTkN71IOdR5yhgWaQ8K0BaKFEOXWM4r8b3PgcWfn4zgF0Vp99e4mOVocLQ
 wBJb2t3O1RAX9ElkheM016X0bbZXJE8nkj3OPR3DusxaITWprcqDrs1uZx4hTJe7lnU4IG1wkdR
 mGtp2s7XMqQ498Isesz51joOE59UrFqa50lDpY5vhPfybcSb+azTmu5OkvthUtcSgeupnq9gVln
 lO0ioJsy1wbI+syA7Q5z13NidUesM87zWRUfEM01JEgNsAvcWQCIH5f2UkEvkgizdVp2Uuhhtgm
 TGZn/IHypU=
X-Received: by 2002:a05:6a20:1602:b0:3b1:cce5:9140 with SMTP id
 adf61e73a8af0-3cbce98a610mr14359456637.33.1786265392386; 
 Sun, 09 Aug 2026 01:49:52 -0700 (PDT)
Received: from localhost.localdomain ([103.178.205.91])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86fc7bsm28800025eec.1.2026.08.09.01.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 01:49:51 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH v4 4/6] drm/amdgpu/aca: Add missing NULL check for banks
 parameter in aca_banks_add_bank
Date: Sun,  9 Aug 2026 08:47:33 +0000
Message-ID: <20260809084735.9743-5-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
References: <20260809084735.9743-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:03 +0000
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

aca_banks_add_bank() verified that the 'bank' parameter was non-NULL,
but passed 'banks' directly into list_add_tail(&node->node, &banks->list)
and incremented 'banks->nr_banks' without validating whether 'banks' was
NULL.

Add a NULL check for 'banks' to prevent a kernel NULL pointer
dereference if an invalid pointer is passed by a caller.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index c35f6be2ef77..dcddeb381628 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -49,7 +49,7 @@ static int aca_banks_add_bank(struct aca_banks *banks, struct aca_bank *bank)
 {
 	struct aca_bank_node *node;
 
-	if (!bank)
+	if (!banks || !bank)
 		return -EINVAL;
 
 	node = kvzalloc_obj(*node);
-- 
2.54.0

