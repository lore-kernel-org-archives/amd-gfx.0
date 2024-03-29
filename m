Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D79CD128A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 11:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4F3811267E;
	Fri, 29 Mar 2024 11:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="YBam9lBZ";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB70112331
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 07:26:00 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-5cddc5455aeso1168063a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 00:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1711697100; x=1712301900; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzRar7ztYXEnRyKAelp48saozJM51jVm9Dh1Zr4pH8s=;
 b=YBam9lBZkRxieMt37OhVRFDo0XQp+RR0Skon/JzIy9krs9aywVBl665MeaflUK67he
 Z/fjg4oA5s7Dnh7yiF3vLUJbAfADxIGsMPy58FfR9qc6Oy3e8JD4/pqIDk3OvhSedN0n
 baCHIWntArjI/F7AzNZzygxrKkNffXRE0RuHmFZF8yUG5U4AR5Xir1oISZvRq0FMCa7a
 zWsoBhP3yfUONhpLf3MrpOdKTFpTrWu0wiFqHhdb0sC32QGW95iIhKdy0+YTo0X8znsF
 ch4MafePgTeUG8zShQB+YS7UJFUI4zr8Gs1JIXCSPgGPliKGYBBcUXfyxiiJDivxh5gU
 gXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711697100; x=1712301900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dzRar7ztYXEnRyKAelp48saozJM51jVm9Dh1Zr4pH8s=;
 b=Krs7TEVl0Fdka3V7DFNtNpZ1hGzQxMBcECka0+765oBqvmTg5868ZZKWlAPHW6bdUF
 iz7nSPZgLKMSD0H9lurl87Tkg+XQ7NQ+qrTcqLS21jxI8ztr48wCTOP3gTPtCzt7gja7
 f8Q0GjPCuIvcIBtDUUr+J0QHrA1E2qlGEYLDi5EENP/RjYY3dsWjSq9CWbMuHoYm85fo
 i/tj56kVd4FztBJ0dm3BwJyToewymRhAWpSpCOpPki96rUNuIBDwQoKRJPB3DDH3bGmP
 I8/kJW7CALg40QuwHvQlcdWhdlC2BzT93LWAWpcjcDk1pU9ABZPBiUJvaR0MfGXZagJ/
 r8wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLVmhZh8hAZxvQOlTCJVkmTqhOJmSfq59I8UuJgbzXLQ65AzggmjuTq4Q60MRt3H0RBsMR6SsrE0hwAizW9ZXk9bAzN00qK6M7sH3q6Q==
X-Gm-Message-State: AOJu0YyUMxEAIf+8nOPBAJWO8Ko1hfUi2C7pbR0r7dvZpQ3uMoWeEj/Z
 QpVhTuLecMxg4VGXkkx2ULjOoWkFUp08BUAnbFJxl/nB1C2aHHM80NdF4VCAVhA=
X-Google-Smtp-Source: AGHT+IEs8kBZu3dBChnRywCF22OnC9/Ej+znSx9gblpEFd+wsOZOeprciOlW3fwk28PpRrFgoWrM2Q==
X-Received: by 2002:a17:90a:d3c3:b0:29e:975:3500 with SMTP id
 d3-20020a17090ad3c300b0029e09753500mr1446912pjw.28.1711697100232; 
 Fri, 29 Mar 2024 00:25:00 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 00:24:59 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Samuel Holland <samuel.holland@sifive.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 09/15] x86/fpu: Fix asm/fpu/types.h include guard
Date: Fri, 29 Mar 2024 00:18:24 -0700
Message-ID: <20240329072441.591471-10-samuel.holland@sifive.com>
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

The include guard should match the filename, or it will conflict with
the newly-added asm/fpu.h.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - New patch for v4

 arch/x86/include/asm/fpu/types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index ace9aa3b78a3..eb17f31b06d2 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -2,8 +2,8 @@
 /*
  * FPU data structures:
  */
-#ifndef _ASM_X86_FPU_H
-#define _ASM_X86_FPU_H
+#ifndef _ASM_X86_FPU_TYPES_H
+#define _ASM_X86_FPU_TYPES_H
 
 #include <asm/page_types.h>
 
@@ -596,4 +596,4 @@ struct fpu_state_config {
 /* FPU state configuration information */
 extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg;
 
-#endif /* _ASM_X86_FPU_H */
+#endif /* _ASM_X86_FPU_TYPES_H */
-- 
2.44.0

