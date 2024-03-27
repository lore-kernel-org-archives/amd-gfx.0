Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89271C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 13:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3347B112426;
	Thu, 28 Mar 2024 13:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="MbKRLy8k";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A28310FFA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 20:02:03 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1def59b537cso1590265ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711569723; x=1712174523; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3VQJildZHY1Bgj6r2iljFMqpw+vWq4Si7He8vtNBY4=;
 b=MbKRLy8kFG5ZbHju8H8dUJN+co/St9HsallG3Ne4hEP1lUB84kus6lUztdFhVv80ug
 EvesmGcDhfLMjr/qMSCYgQEhuGkTjK5WWUCyGk3TNcrXgyKtN6uVtPGH+94EmNf19lNC
 9/vYwSpCxER6eKulXivcj7l/HEeTzFCOuEUHWOOctwf9G24PSknWUfQ6/l9SGKDsA4gP
 DOZufmvBl0AY6M6+pON6Lz4CLmHg+it9anyw+1vLeqSzeXMFtUNn0Rb4hTE8v0uYp5rb
 gS31uhw9yx0jUIjTPtMvrQ6/yE2Q9OTGwHNXhZnUZRRVzVJanYK3+wifqN19PThFYPtO
 pcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711569723; x=1712174523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3VQJildZHY1Bgj6r2iljFMqpw+vWq4Si7He8vtNBY4=;
 b=jJcUSz6AAdFSQhc8OmQzmIpagSyOByCocdcTeJj1vmQjK5KeGlXIfooMFIOPTKlbcC
 QXg+h7K58vXJEydcRjs+l9SLk7T8h+mniRiVh+M7RYwjeLivcsbH1Slsml1SGOxv20hO
 aMYRoJkmcL8OxR77GmzygcQK6XH+YaMNFZSba8ElIO1pVJ+dB1prJ1Om6OTxbgFWVh/k
 g8kee+SFnUcf8xz2CP8tA6/WpaOUnG1UDJ9sa4JyDnea971mHgx3rN35ZgZJ3dbyDWjo
 Q4eaZ/Q2+QmnoKVdTOeJxlbqsT9JNQ4eSG/XacumHl/YifMICgfGSxDZj6wUmA2lIn4B
 ZgKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU31xTQPNYBlnPNRh7gncZimRnuY2wP6CartKI/g3VyJC4GqxsybEMAV0ih+fUOlJS4hHupPQf4dLKk3RrGlyIzvaCpL5L46XZZg3uw3Q==
X-Gm-Message-State: AOJu0Yy3JIZWbpadPBaXBnH5LICviK8X8EyQonZb2Vu+JlUaJ87bq3B/
 I4uBWiYyaeeFDw4kfIIyWW/dDgnr1yKhtx+CB87kLcB/cxpzX/D8AnjN2/Ui9E4=
X-Google-Smtp-Source: AGHT+IHYrCNFuZi7JM5PzLehk0tocOhYuLDObxCk9XIqMJvg9sySawc5MBuX1NvDT7qWP/3i+9Szlw==
X-Received: by 2002:a17:902:cece:b0:1dd:c7ea:81f3 with SMTP id
 d14-20020a170902cece00b001ddc7ea81f3mr964085plg.1.1711569722972; 
 Wed, 27 Mar 2024 13:02:02 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 13:02:02 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 Russell King <linux@armlinux.org.uk>
Subject: [PATCH v3 03/14] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Mar 2024 13:00:34 -0700
Message-ID: <20240327200157.1097089-4-samuel.holland@sifive.com>
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

(no changes since v1)

 arch/arm/lib/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 650404be6768..0ca5aae1bcc3 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -40,8 +40,7 @@ $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
 $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
-  NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
-  CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
+  CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
   obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
 endif
 
-- 
2.43.1

