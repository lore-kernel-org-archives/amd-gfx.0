Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1863CCD190
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 08:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD13510EB6B;
	Fri, 10 Oct 2025 08:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f5aeN0Nh";
	dkim-atps=neutral
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com
 [209.85.166.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34DCE10EAD8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 17:58:55 +0000 (UTC)
Received: by mail-il1-f172.google.com with SMTP id
 e9e14a558f8ab-4248b34fc8eso13946815ab.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760032734; x=1760637534; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pU2dh1AcXNpIKiB0LgzN/RHkM4liyYcW5Vvv24TZfyg=;
 b=f5aeN0NhO9k3xDakgGg4s6SDBZtldx7Df2GD+RkXJrDR8jy9nwele2/aj3LRRCXVmm
 Szndy2dVazeQgHhPG338Vd+JKHbcOcy93lZIy8lq4S1xtqSzMWCiffKSjhoCU79FW4ok
 Y4Tv7JyPWGFrLdIkeuRS9bJFAYSoROnx2gNEXboe19zK7XM58tUYFyh3Zo8veWxJrofI
 AawR8CmGuLqfbf11OysWhzW5bSNvDWjzE+9yNXidX3jxMw/R4xDmNMFnR/K1oVB60l7S
 EEYCeWvXkIOveY/r7LtQQmJc/Lonn1Gru6Afel5vmqCWQJpXn5vsSxRFg6uT0LdloDIZ
 Ht+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760032734; x=1760637534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pU2dh1AcXNpIKiB0LgzN/RHkM4liyYcW5Vvv24TZfyg=;
 b=eRAqs3oleUjnih9IKDAgdI75mOPZuJWZgW3M0aPWturxqR8eCZl7YRmbsxEQqv9Wka
 uA6OEpZr1Qsz6+NSYu3idhf5g7E8mkehLyDwRa/5BQZuRmZPBq2RoYEUyPD3aSN1ZJg8
 +BINyphi6zEDZqRnh5mL2lWlWNhqRaANyj+roNhg6P5hlGOJ8JpfEuBPTl2LDMtOoKLa
 ZhtEyh6rL3qFm94PMQE2Yot3VWwWj/3PyF8ig/9D5YD9qPvLmT5SPL9RBhwu5CnfJzLb
 WwkTUvn3G60RfFJ6/ewn9TlBRaitnghgRF3GmRluBI6oQJwtCnXMJCzvK+6NDGbU59ok
 mt6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBwAIEPbB5f1zpzprPjnHjtE/th6kbafWYyobrq0DkELaFW4IGLT1GhbtJAaJCCySXP0UIfUf/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz93Y0X1n9fs7pw23UKh1O+CrOoikrpmDKRA55Rk4szH1TW1U02
 8Y7Rg+9MthPOR7L1/nUCqyNX89uLJbcmpaQ9HokMM6se6bAEC1UTgBFr
X-Gm-Gg: ASbGncusivZx7gpN51HUd/55Ga2laDGyVeZmPnaHYD1ccWkd/T48tty/AIwgUFDh6av
 1+wjDO/AKoYkDWtA7XC30JSnhRWm36nxoSLdtKBsDofmobFpNKZ0UBClP5p/IhFqXfUzP0FWbxA
 m0YqpydIPmcpqnIvKLYofzeMXgS2+AMj1u/10BqDemRlhbSFSCKIPYDnJkZaGhtHOG+4To7cOSq
 nOrC8IRmBOKKzMzHYTEa0i+RnoZkiJVhKYd5HxVRzMwPpDsR21gx60oKXPnlKyS3r0xsaKgZsCd
 Ejjwkr+fZPQQ7RyeCmfYro4KkciqP5I/V0MSfikFcyR05LczomsKUWV0kA4D+KNBCKxsEuC9s/6
 EOilz4wT+Rt8nU652g2wHurLcBF+G3iaqNYQpjzFIbQv/SkuF6EnVUCrYWt/+aejl4wA9X2wkIj
 KQYIRjBSJXQRsQzQxcyzprC9A2mGHmwaTUTrZzeA==
X-Google-Smtp-Source: AGHT+IGG3nRCWoDD4V/nkCQ4bWDSLxtN1n0qdt7xwh20BiNzOL9cD9tMw7g0yxq5IwKvmpy6qvXj6A==
X-Received: by 2002:a05:6e02:270a:b0:425:951f:52fa with SMTP id
 e9e14a558f8ab-42f87376e77mr84960835ab.14.1760032734175; 
 Thu, 09 Oct 2025 10:58:54 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net
 (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
 by smtp.googlemail.com with ESMTPSA id
 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:58:53 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org, ukaszb@chromium.org, louis.chauvet@bootlin.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
 tvrtko.ursulin@linux.intel.com, jani.nikula@intel.com,
 ville.syrjala@linux.intel.com, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 07/30] dyndbg: tweak pr_fmt to avoid expansion conflicts
Date: Thu,  9 Oct 2025 11:58:11 -0600
Message-ID: <20251009175834.1024308-8-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Oct 2025 08:03:12 +0000
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

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 55df35df093b..2751056a5240 100644
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
2.51.0

