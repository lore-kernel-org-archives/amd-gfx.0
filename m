Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EE4E677E9
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Dec 2025 15:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C641810E6A7;
	Mon, 22 Dec 2025 15:34:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Brjw5unT";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1607310E57B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 08:23:00 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7b7828bf7bcso4176495b3a.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Dec 2025 00:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766391779; x=1766996579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Elt5R/CoR9iQcckLm+LWmPbMBH4lmPXk70cWipXnli0=;
 b=Brjw5unTzSHDsmO8miQo7SuVGXWhpnHe8uK4Llhf4P+Ah/vxasi986m80Ij17e909g
 YLiLZI6m0xYGqQ+oI6fum0WYyYFjbxaVdMBVB+bxjg+hmL3e5+zYnF5SONQsYkDZ1rP9
 5z5089WXBijkuVrQh6wSPE+QzPXIuSEO8vboUiqDANJERjspRYm9D/aWiBPdQfyUCnDh
 BdeCHPrr1gPePOudj8l4PlgNTKoC3/SLqzN+HZoZe46+m01I3VJtnXO7G6li6hYpLGp6
 RRLHedrd1c5kySrAK3lh8XI6kZaLgztsoGmB4i3ITo9l8GHS3MUFanCCCFdtmBFF+HlM
 T3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766391779; x=1766996579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Elt5R/CoR9iQcckLm+LWmPbMBH4lmPXk70cWipXnli0=;
 b=CfU3AVASvyq90d1sBKS29EAdHwpbXjd8yCq+YoyJF+K4Wel/tJ8pdnb/FjKFRJb7oo
 VjgwamUSHqwHwDecNuj700BAgaYO04Bbxsdu54bZZrZN3mLBBGRR5XDBBdYvx3Zvlt00
 r3M9c7fE3vTC+vGdpV8zJ21ug2G5hHzBY5/YJoTp7Kgl3gAVll7JdqB8wCUoXOIKkWzQ
 DBNAonnWvm/ZD0jtr4SNrunu9ZdxpkDjpwKXrV/BEsj4JXI9TKMMPh9dxDYhdHk906aM
 Qp9IuMPPlxPpEG5k0uZ18DCsZR4Fesksk6sLA1sgpgSo7B+gKxOBFJh+1QdHG/YZoCfF
 kQwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcazkhu4Q9J5tvtjSlhbSRPsnFLsn8ubsTxrQ6I3KGfGAz5MECKMIXoXgddpKjSjBAfA4I7U5Q@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxtw32RSX7voTUkBqFZjg/kyiF5MFG/5aYyuY6vk3uUr4VXbBKn
 xS/jaJFgPrejnpGJBN33vJAVfjiEwRBYBtJNWQIwtx6/VRSAflVs0AlF
X-Gm-Gg: AY/fxX6dw+KRK70+DuUfecIjht+5qtARXtBA4WeM6mySBYXAVlKPO6omqqSJ87rqXrw
 B6ljrabInO/OEMf/EK5/VyVl7HiFfk8kkdNV6VrOEZ5GsH40RF1s+7F0vMnh9VwH/60tTz4t5VE
 dMWgYPTIsvePSCKdcWWmiJmwpKWwoj2ZIQLnIqKJ2XkeF59QD/5RHgX3agLVSa2RsKuoClhnYz5
 FWYmG5EdFyG+HPP4UjiSE0PZdFxCZyw7H073YjMW8ZKLKNGnq3PRkbH17qu7p75iO5hukf4jW9x
 YIAjsfq76pzLFOqDs5QmnTxSUaUg3p+BvwUp0Lk1NqrfCNv/OkqjgLJ6v25UZaDGJPFe7ALCkGn
 gibRiRZDLAnnOgeIwgM7bATOTvBc8vrJa6B69dxFObRPVtIS4mBBjTjMcn7mYGvUS2dQDQrk3W+
 kA4uv+wWxaLDq371V16sA=
X-Google-Smtp-Source: AGHT+IGPhjVEd8hFCFWSuzrJ6/8E9Tcr4jw08Ck32qa0ZVNPKd3V6Hm2f6vkNyl5Idf/bQen/LCS2Q==
X-Received: by 2002:a05:6a00:b902:b0:7a1:49f7:ad04 with SMTP id
 d2e1a72fcca58-7ff642154b6mr9938622b3a.14.1766391779554; 
 Mon, 22 Dec 2025 00:22:59 -0800 (PST)
Received: from frodo ([2404:4400:417e:3d00:8b90:7f55:1261:772f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm9540699b3a.50.2025.12.22.00.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 00:22:58 -0800 (PST)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org, jbaron@akamai.com,
 gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com,
 jani.nikula@intel.com, ville.syrjala@linux.intel.com,
 seanpaul@chromium.org, robdclark@gmail.com, groeck@google.com,
 yanivt@google.com, bleung@google.com, quic_saipraka@quicinc.com,
 will@kernel.org, catalin.marinas@arm.com, quic_psodagud@quicinc.com,
 maz@kernel.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, mingo@redhat.com, jim.cromie@gmail.com
Subject: [PATCH v7 09/31] dyndbg: tweak pr_fmt to avoid expansion conflicts
Date: Mon, 22 Dec 2025 21:20:26 +1300
Message-ID: <20251222082049.1782440-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222082049.1782440-3-jim.cromie@gmail.com>
References: <20251222082049.1782440-3-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 22 Dec 2025 15:34:03 +0000
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

Disambiguate pr_fmt(fmt) arg, by changing it to _FMT_, to avoid naming
confusion with many later macros also using that argname.

no functional change

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d2ff203d0873..21c1db7e8705 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -11,7 +11,7 @@
  * Copyright (C) 2013 Du, Changbin <changbin.du@gmail.com>
  */
 
-#define pr_fmt(fmt) "dyndbg: " fmt
+#define pr_fmt(_FMT_) "dyndbg: " _FMT_
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.52.0

