Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2A0CD1291
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:33:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C368112679;
	Fri, 29 Mar 2024 11:33:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="ZBP9Oc1U";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6405D112331
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:25:50 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-5dca1efad59so1224907a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 00:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711697090; x=1712301890; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPRyZsExaX9jqH4yhl7xuz7hAOg3yG/uDoq2R6sqbZQ=;
 b=ZBP9Oc1UhfF/VLkjlgaRmIkoPohAAhTqQBvoAK3rACcnzFxHGaSNIdMQjYha8nWvO4
 eqMGhzyovRXhBibtNv7WWD0OQco2mvIerM8u353SYgFN85uoKBr2oqjtrxplaS+e2Uuq
 szhHYgxt5U3GadW5A5Y+YhzV3Vuya2AIlhIHabvUHYF5gKH1XmMusvmlk4c2oLlz/ibB
 HZk/n9nyH/YFK7XQFKi91qoqIiPn5AvleBOPPERHrQ6+MoJqrB2b+2W48mEcHF2r2yi0
 M1SbGhnWVXzoG9t98FSvLy5Jx2vkmw8/DFQsKg62jgOgTc6lRrp9PbKXitIhK+/TRxV4
 pniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711697090; x=1712301890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RPRyZsExaX9jqH4yhl7xuz7hAOg3yG/uDoq2R6sqbZQ=;
 b=ZM92jSM5WrON8wX2ylh0lrIbQEhyGXQ4bn5S+ywhmT707O8g94HjLKRXa0NxsYQ83K
 nbnKURcy2CYhv+R3WDW08SR34wgHAeoppN4zb9h4yTNHI3eKBqbkqs1Lrk+gFsVyj4dQ
 9c/tWgD34eM4k9Lg2x7vW5VqSvgPgrDiih9mg+XqF2yIMI17Iv6pFy0aREUZyz95vfml
 JInXUINbaQUOMWRdXR5dbeFKXTAKgjxH77sNt7tNfeSIG8pQjydyQ5pv4/PCYki6zQy9
 +RAZOFgulpT/YSMee6pR+RMld2RFGeTeTdNNi6hl0ef24AXy9gtFMkKzdKB25vyrAfZN
 6tdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEK5VxbsoiaNFjrEOtePTMp6CJpLuoSRMd56dMfkG3x41OWn1rKbUuyoHCwVseQNzrhrdatYTE8xfh70wIyay70eWnPpwXFNm12IAVLg==
X-Gm-Message-State: AOJu0YyQZ2QPxK/3lBTQQFk2s1o6bkgqohg2qv/aT9ltlDSoYNshqTWQ
 5Zlk+Tsvv0/z736J+wM5jbhhNVA4sX3KU1dhrlWJfhOHHlqveo0mD1QH+x+ugvo=
X-Google-Smtp-Source: AGHT+IGTP4+TuVjePLHUufBWyrdagoR69ieuL91+Fm218jTRMOa2nDQVrtkL7zzrGfUrh4aL4xmRCg==
X-Received: by 2002:a05:6a20:2db:b0:1a3:71f7:df3d with SMTP id
 27-20020a056a2002db00b001a371f7df3dmr1114388pzb.30.1711697089806; 
 Fri, 29 Mar 2024 00:24:49 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 00:24:49 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 05/15] arm64: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Fri, 29 Mar 2024 00:18:20 -0700
Message-ID: <20240329072441.591471-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 29 Mar 2024 11:32:14 +0000
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
2.44.0

