Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CD6C10DC1
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Dec 2023 08:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EB3A10EA2A;
	Fri,  8 Dec 2023 08:37:07 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A53E10E9CA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Dec 2023 05:55:03 +0000 (UTC)
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cfabcbda7bso21575425ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 21:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1702014903; x=1702619703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jIC4glHzB+IOAGM7YCu4gQFdGXeLpWj/I7OZVSGOh7k=;
 b=hhVTcG9F/VQOh/BVAhswyvYrv0LlY+xlgu5i7HiJKi8EkbO08tDafCi+K3AujLrIYT
 H2XXh5qujPa4q5nY1XXUGHTOrWLkbVTEWLwuEQI9gkJXoRW8LMYUqvveP3f4lybZpwWm
 Yjq/z3ZB+KPinxB1cg2kLyl3tdbg6BZuTb9BJd07KQ0h9h+GoaJoNEL8inFhNc/wSom4
 MOKrr6i1AQtVjWvpqOcy5YV2pXqitGGR/sjCVo9vVOb5Is4MUTTL3JHxg2yhaZLyS8Nz
 PJOYDmubjsA9gb7Lo9+t5/bfN6UqOR0dbCdPzzoglJQ40X76kYjjpplKC5gegZcI0Eyq
 WzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702014903; x=1702619703;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jIC4glHzB+IOAGM7YCu4gQFdGXeLpWj/I7OZVSGOh7k=;
 b=u0J/Bvyl4N6/GZj9tu4lJHOVfYmA4hKnSJjSX+NSb/3zVoAbp8/3Lj3iP5ey/ktxLa
 lgE8du7Nf11oaHGmOKY/yRQDek8ERMLfLNuvWNc4XjrjDtDwnY4JB5Hv1ZtLuy9YSx1n
 J6XCcsXGbNTBlaZgGDh81ajeOzfd2tGj89Y9LKRXCabjLjvGYxkKn7cpA44CRJbxKSqa
 EPB1z+gRrwYoTK4y52xdhhL0C9SKsLivqkGwOwMrF3IxF6ndETl3B451iLUmG5QFRo1B
 itaLCScK3FXMwNSq6DxDznUEEpHURNRdzN1Kln28Wy1eOnKq605UiQtuSAnwA6nboxw5
 SMdg==
X-Gm-Message-State: AOJu0Yx+ElFMkjYOw5BgZLeIixDo8+KCOQe2dWn9+qH4zH5hmOcLoFYS
 N/0MFa2wu7ZAVNmPZzHoBr2pLw==
X-Google-Smtp-Source: AGHT+IHobgnIbAqUwh0qy5g87XS9Ops6tA3mZ0Tbbi2vny+WXvVENlMrplaMBh4oGzh2rC3HGh0NRQ==
X-Received: by 2002:a17:902:c20c:b0:1d0:6ffd:610c with SMTP id
 12-20020a170902c20c00b001d06ffd610cmr481032pll.46.1702014902890; 
 Thu, 07 Dec 2023 21:55:02 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 21:55:02 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-riscv@lists.infradead.org, Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH 00/12] Unified cross-architecture kernel-mode FPU API
Date: Thu,  7 Dec 2023 21:54:30 -0800
Message-ID: <20231208055501.2916202-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
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

This series supersedes my earier RISC-V specific series[1].

This series unifies the kernel-mode FPU API across several architectures
by wrapping the existing functions (where needed) in consistently-named
functions placed in a consistent header location, with mostly the same
semantics: they can be called from preemptible or non-preemptible task
context, and are not assumed to be reentrant. Architectures are also
expected to provide CFLAGS adjustments for compiling FPU-dependent code.
For the moment, SIMD/vector units are out of scope for this common API.

This allows us to remove the ifdeffery and duplicated Makefile logic at
each FPU user. It then implements the common API on RISC-V, and converts
a couple of users to the new API: the AMDGPU DRM driver, and the FPU
self test.

The underlying goal of this series is to allow using newer AMD GPUs
(e.g. Navi) on RISC-V boards such as SiFive's HiFive Unmatched. Those
GPUs need CONFIG_DRM_AMD_DC_FP to initialize, which requires kernel-mode
FPU support.

[1]: https://lore.kernel.org/linux-riscv/20231122030621.3759313-1-samuel.holland@sifive.com/


Samuel Holland (12):
  arch: Add ARCH_HAS_KERNEL_FPU_SUPPORT
  ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
  arm64: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
  LoongArch: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  x86: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
  riscv: Add support for kernel-mode FPU
  drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
  selftests/fpu: Move FP code to a separate translation unit
  selftests/fpu: Allow building on other architectures

 Makefile                                      |  4 ++
 arch/Kconfig                                  |  9 +++++
 arch/arm/Kconfig                              |  1 +
 arch/arm/Makefile                             |  7 ++++
 arch/arm/include/asm/fpu.h                    | 17 +++++++++
 arch/arm/lib/Makefile                         |  3 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/Makefile                           |  9 ++++-
 arch/arm64/include/asm/fpu.h                  | 17 +++++++++
 arch/loongarch/Kconfig                        |  1 +
 arch/loongarch/Makefile                       |  5 ++-
 arch/loongarch/include/asm/fpu.h              |  1 +
 arch/powerpc/Kconfig                          |  1 +
 arch/powerpc/Makefile                         |  5 ++-
 arch/powerpc/include/asm/fpu.h                | 28 ++++++++++++++
 arch/riscv/Kconfig                            |  1 +
 arch/riscv/Makefile                           |  3 ++
 arch/riscv/include/asm/fpu.h                  | 26 +++++++++++++
 arch/riscv/kernel/Makefile                    |  1 +
 arch/riscv/kernel/kernel_mode_fpu.c           | 28 ++++++++++++++
 arch/x86/Kconfig                              |  1 +
 arch/x86/Makefile                             | 20 ++++++++++
 arch/x86/include/asm/fpu.h                    | 13 +++++++
 drivers/gpu/drm/amd/display/Kconfig           |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    | 33 +----------------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   | 36 +-----------------
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  | 36 +-----------------
 lib/Kconfig.debug                             |  2 +-
 lib/Makefile                                  | 26 ++-----------
 lib/raid6/Makefile                            | 31 ++++------------
 lib/{test_fpu.c => test_fpu_glue.c}           | 37 +++----------------
 lib/test_fpu_impl.c                           | 35 ++++++++++++++++++
 32 files changed, 255 insertions(+), 185 deletions(-)
 create mode 100644 arch/arm/include/asm/fpu.h
 create mode 100644 arch/arm64/include/asm/fpu.h
 create mode 100644 arch/powerpc/include/asm/fpu.h
 create mode 100644 arch/riscv/include/asm/fpu.h
 create mode 100644 arch/riscv/kernel/kernel_mode_fpu.c
 create mode 100644 arch/x86/include/asm/fpu.h
 rename lib/{test_fpu.c => test_fpu_glue.c} (71%)
 create mode 100644 lib/test_fpu_impl.c

-- 
2.42.0

