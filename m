Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342B1C4706F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 10:02:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704F510E197;
	Thu, 28 Dec 2023 10:02:16 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA7110E02D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 01:42:28 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-204520717b3so3179292fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Dec 2023 17:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1703727748; x=1704332548; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJe+2iWG7zhbu2gjOAPKG3r+a1/tBb6PXcWtzUfSG2Y=;
 b=dqrvRRn5U4xr9lPM/2zpLCoGcJzK6TTSzuf7Bn5JL1cV4hNMVSsns4mWsCAFwgWa55
 GNnWq/D1NNmBPytCLhWZYG+Izw8nEjtceIAZVzd2ZGDgN5ImqhuJR1yohBVUdTgqvENf
 WCkp7InhQwg0JFRd7/7kwXwVYcjsFHO6QxUSUY86gHKdwzGkw0p/pmRprDgikW9gEu2U
 m+vhp3OSUY3c5SZ6PaJNjzBQNnAVZvd0dXf+IOX9VjOK2tto5D2vxwb0ZD9zl0CjVpaI
 XFSPpO2ikaf9trlZrt//F9JnIxwsR22NQbNE0g8O62R8YRUq6yrBGrs4pvPO1xUWbLeK
 Jjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703727748; x=1704332548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJe+2iWG7zhbu2gjOAPKG3r+a1/tBb6PXcWtzUfSG2Y=;
 b=rkaQvNNRw60SiQ8a1XNc79Jb7fYxmG9gWL6qoQ2cMAgcx9DQU5DqdQdBcTdGZwW6Vy
 OQS4vFuLUyqss2WJxFlAp6o4JWhsojuYmecupNbL00v4/Qm1XVVkjOGH9+hq3eZOEZXo
 n0iF5Rpd2fiwC63JAxYLY4p3wn9NYtG0s3dU/o6gAfSbqzPBZbbZFBc8lt+8Sz85zSvY
 kIx7aNFIIuZZxPJnTl+aD6T0vs92gRcmO21vGw7Eq+tLhxTtEJT6NWZZdRsanqiA0T16
 BC6u3UM2U4s8MhBUm+8EvecairJuw8N0b71HU0zCfC02oiymzCAqQkCq364+2Acl7jyf
 t+Bw==
X-Gm-Message-State: AOJu0YwlFYePSDoH/NqZ9EBbbM1R5Vi1zr5Fii5lk8pZKTd88oJvbKNy
 TuH7JR4erSwYdHDnTJhfEqCOlsORjTtbZQ==
X-Google-Smtp-Source: AGHT+IHYZaSMdp2QaO80SoY2qT34DsaM+IszcA+ix/EbDuC7szn+dKwMtM8zlpfibfh9dbJ1h4v/ng==
X-Received: by 2002:a05:6870:355:b0:203:e0bc:5e11 with SMTP id
 n21-20020a056870035500b00203e0bc5e11mr10237951oaf.70.1703727746413; 
 Wed, 27 Dec 2023 17:42:26 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 g24-20020aa78758000000b006d49ed3effasm7335440pfo.63.2023.12.27.17.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 17:42:26 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 03/14] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Dec 2023 17:41:53 -0800
Message-ID: <20231228014220.3562640-4-samuel.holland@sifive.com>
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
2.42.0

