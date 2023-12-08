Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8C6C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 08:37:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0560510EA23;
	Fri,  8 Dec 2023 08:37:03 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A2A10E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 05:55:06 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d0c93b1173so12966615ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 21:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702014906; x=1702619706; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LqG7sh4TEQnomN1Pb8iughMffScuejFKYmgaMeTCLmM=;
 b=AhGMQ59t7iW9++HJfyoSgVhCOjY7BF//mlMwRLqzH/ojGQRu1sMmNQeKKPf7SWTU8j
 v7OuKe862TzfLyFf4c0oPVanRFz3vAtYzwpr2VUiBZ4vKWQuupTuD1C23jc2IFCUoXhe
 Yr6LnerLIkGqqL5cgXxGaZYgl5GdQB3cT1h3pTUuBrRnDk3Q6XwWcYgu+uh4RzK9Tdar
 YMaeHEEeaY0f7QsBLqlIRU+3rSZK9SMEz5W+3DXjtNf0Z5skFfyfwsZ3s0Lks4Ec5WEa
 LjRZdsokr2Ol5w2SMqaCqV3cEJGmXepIj8SGruo9AndoGoLGMaa4AAZrNoLO9FMCkmac
 dOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702014906; x=1702619706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqG7sh4TEQnomN1Pb8iughMffScuejFKYmgaMeTCLmM=;
 b=m4JWqS3SYjvHK0g1FKRU/CN9s75ISyPsQ7bsl30b/w3N1Y5EgACot4OBCeHZf0mm/B
 Rtcz95Xz6yv1sxfl5jlsaWaE2r7hJs/skf0ZlBaxPhe4spePw78O+5/rn2b0iz1Ggxhv
 IfYxhv6F8mNwfk6Z/8Wz6ejgCYEe21jZz6fjAJs8G8+S65PQl/Ys01s2jYfXm+CEbv2z
 SymT04WNDaHN2d0+cOwl88gSiQBv7XIgRCqeo/78F174oCTepSTM1F08FcL6UqGvzZq0
 /xH2ziM7xmUJkbMXMjnMjlcM5vgrX2CPewQudhXyVzvJ90yT8emewO4kWG15X0mKm3bD
 uWOw==
X-Gm-Message-State: AOJu0YzHu/sqLl5k642v60/p0D/gjXBNfUe2cMndluN56oEFUb7IwxG3
 SXkYIMTBRTYxwvu7NzWWnQuTYQ==
X-Google-Smtp-Source: AGHT+IFmoFC5Jy7QDutaZzebMhgROVCbFnFB+FkSDZrKf0b9QQV81pWWj0y7Aq09xAemAJ7UXgVmYQ==
X-Received: by 2002:a17:902:ee45:b0:1d0:6ffd:f205 with SMTP id
 5-20020a170902ee4500b001d06ffdf205mr3064563plo.91.1702014906581; 
 Thu, 07 Dec 2023 21:55:06 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 21:55:06 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 03/12] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Thu,  7 Dec 2023 21:54:33 -0800
Message-ID: <20231208055501.2916202-4-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208055501.2916202-1-samuel.holland@sifive.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Dec 2023 08:37:01 +0000
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

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

