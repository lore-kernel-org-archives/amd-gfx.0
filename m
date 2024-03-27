Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2D4C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 13:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DCB11241D;
	Thu, 28 Mar 2024 13:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="SMvvvtIe";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4025510FFA8
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 20:02:06 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1e0bec01232so2083185ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711569726; x=1712174526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9egB7QSoDAHRW6tgRYqVd+NUTiSQfL/JcKX7OjtD5w=;
 b=SMvvvtIeP/sY+HjiZhM0UcoSnJcZ/cAlKwjt9OTLNQLPcNTi8i7I9eFiWLJWetSHRh
 fKieDsys+GZyhDdpbOln7J+iiY7GYRT0fBztJdr4idKre6kcFa3NxmZxQPTBBJfUQnOG
 lmErfG0x/+IG+XKp7AlXDbvIbCzeCVQMrz1pnKli1WyLXD7gKKG7cLyhVdSFlrjyyvsy
 QU8XFPqhhrPmF2EQu/imJUcanAHeb6ULZl8/pPqjFUshRERw1qiMhL+J5ZD6uS3GkHei
 QGTmz1sC7dpZc9NtJT5Qq9QHCk3iv8QM6j89mksI1K/Zhg7aciyZ3GFjHTtsWeDNUKKL
 jHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711569726; x=1712174526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9egB7QSoDAHRW6tgRYqVd+NUTiSQfL/JcKX7OjtD5w=;
 b=IPjgP79zzB2hUiElWs/tmIrJr8aUuDDoCItmW2H66Tidjpn5n19IsMw0iT/aNDZVgN
 m1Y8kt2xxRhB6C+YSqP9k9BbsjoyJLJhjaJ9YmhT98iNaIi0/GqAssXgleuo8ufdnR2E
 dFH19yFT57iMoYLQSezJrjLGVDtFtGEe36RzJ/XVedZsfnMP1KKzHYV62eSDneBj/ez3
 cKiHFDs724zXXTl2NETxFuACxuIa8cldI+tlXq6qzqhVAsyO4xTmD1bi37xwcXOU45B5
 LoaM9l2OMHJiIxg8M/T+po2GOjmkZyak30kEJMsNggJqvF17NB6FdHk0dLWvKD+ZbyxX
 xFwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWunmTvG2yzyinDlNmmGARt5hheeRh92xvIYZudtDHHJRFJO+6cb8gLhg4x9924zK9zeW6dWKBXEmu7JS1WrLSbcY2qMja0V5t5wLDShA==
X-Gm-Message-State: AOJu0YyCTxsCXCuoPoEQmRefy9k8WgNR9Fsx5jLQyPVav8dDRlQFAdUL
 kdPZnIW4HjYKkQWYEW0ga897cEJgQf/lq/jAz284t0xv9J3EjUbtrekdLDFQ63I=
X-Google-Smtp-Source: AGHT+IFGHdi74bAZSMUCS5nBpcP7LI5Cfqz6VZFaIDx36rlYRojmLVaB4TIyZga5IdN5tuwaxR1nKA==
X-Received: by 2002:a17:903:2b05:b0:1dc:a605:5435 with SMTP id
 mc5-20020a1709032b0500b001dca6055435mr854470plb.31.1711569725718; 
 Wed, 27 Mar 2024 13:02:05 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:02:05 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v3 05/14] arm64: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Mar 2024 13:00:36 -0700
Message-ID: <20240327200157.1097089-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327200157.1097089-1-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 Mar 2024 13:32:06 +0000
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

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

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
2.43.1

