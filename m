Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D583C3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 10:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E9C410E0AB;
	Thu, 28 Dec 2023 10:02:16 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6198610E1B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 01:42:29 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6d099d316a8so5281252b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 17:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1703727749; x=1704332549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BoxXzLgzl7b5Y0xu5pjyo/VkU/XWb+SGTLxU4jp8p0k=;
 b=YZ912498pHhLaUHxJkKoV6RPnaIhZKcPlTIaGuV23owgx+nlBO4JUPGqhBuFIt0w6f
 pBKBgbde39pyVuq2khynspBNZejgH0Nd4l2KqC6Sqq8ra0nLwMYDWoSbD0Kp9OQGtENM
 83t237GYytMS0yDTuRKJkEhvl7iukzE0lHjKJxYN2Nt5hWrgEl77k1l/lzFebYb8N7ci
 2kNmhPkMzum3jcSkwkZlHA8UleiREe5oyVgpS0SM6WiHSmIBwaCSHAKnMIjhELiTHSUG
 FZQPv9gs7Ze1cJLAP2NRcIdwyME0yjSqOzBl94RPfXUBdYp7hgmsm/TURzYebKHWyOdJ
 B6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703727749; x=1704332549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BoxXzLgzl7b5Y0xu5pjyo/VkU/XWb+SGTLxU4jp8p0k=;
 b=U2Cm/5UhN203VaqfcKh9YKIipnTRFnxMGFsOj31QuXeDCW3WqIS8gnQ2ixLOO2GJqG
 fYH/rMgC7BV+SunnnDueKZhMI6icOhQNY+H2YQR00rHZ9FyN1qRpIu1Die5V+Zx3edX7
 QX+5YQrvlZh6nJ/NMDioo6yNd2i4RHFc2w6RkDzKHobzZHa2TenQvsSjcL8qwcNxOAzu
 NAWZw7M7PhHqsL805RGLH7ewUYVjmpBTQO1beRQUo+QaHP8krUBtsm0wSpp3s5e+90Df
 GOUcaIlgnIzaSeOt+KzrjbaB0vygG2cAogtbguZ/7h6yUS35ujVabv6hCVh2VCvqL3wk
 bdFA==
X-Gm-Message-State: AOJu0YwXxZu9HD1xKRLIT9EkIIx3WJXSbhAx4u2LEgNYqaFhRlQnkpVB
 +THrUwf1BQX2NcitT4QPGLV/7lZQisKf5A==
X-Google-Smtp-Source: AGHT+IFXwothAr5BJIcCMrRvq4/mKzewsdDIu4/j3geKR8xiDFkrXQfFhz/93Qk1mZI7uGYnkNSdng==
X-Received: by 2002:a05:6a00:4c81:b0:6d9:bc67:82a with SMTP id
 eb1-20020a056a004c8100b006d9bc67082amr5349494pfb.54.1703727748958; 
 Wed, 27 Dec 2023 17:42:28 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 17:42:28 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 05/14] arm64: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Dec 2023 17:41:55 -0800
Message-ID: <20231228014220.3562640-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231228014220.3562640-1-samuel.holland@sifive.com>
References: <20231228014220.3562640-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Dec 2023 10:02:14 +0000
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
Cc: linux-arch@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 Samuel Holland <samuel.holland@sifive.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - New patch for v2

 arch/arm64/lib/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 29490be2546b..13e6a2829116 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -7,10 +7,8 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
 obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
-CFLAGS_REMOVE_xor-neon.o	+= -mgeneral-regs-only
-CFLAGS_xor-neon.o		+= -ffreestanding
-# Enable <arm_neon.h>
-CFLAGS_xor-neon.o		+= -isystem $(shell $(CC) -print-file-name=include)
+CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_xor-neon.o	+= $(CC_FLAGS_NO_FPU)
 endif
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
-- 
2.42.0

