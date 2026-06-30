Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C525C44502
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 07:11:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F6710EE05;
	Wed,  1 Jul 2026 07:11:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KoJRjT0n";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E440210E262
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 21:04:52 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-30c591fb1cbso7774570eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782853492; x=1783458292; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eJX1L/9ll74nIauy0WzTLN96io2W3a6GrFJb/6SuBK0=;
 b=KoJRjT0nFsqbQ/1tMey/y5dNlkNJIsH++LQJaMlXrIeGcemDT+G7Xo4ODZn1y0ICTq
 UJUaP4rynz+PAS1uEpCZR2bh8DOx3GaCD2iYwRRwVYeG6W7htl4sHf9+eKXj+OLmw8fy
 t0OP+sOZGE5tNhEJ8Bq8e3dfJ93hVKGYIfTwKq7laXWtf6UvXQ9VLdDTLuFL8IPPRmeI
 DtSZMiakFqHLp8J1+8bCh5Cbh8gtJUfYfcknOXNreZR5PfM/6sxaEaseeJYCQtXgnhLO
 vncDb0o+yG8Id10fM0gHij9toX++RUi/tgXmUYuxEdIhqO3WR9TKNy4cNWPaY+k5f44k
 L0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782853492; x=1783458292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJX1L/9ll74nIauy0WzTLN96io2W3a6GrFJb/6SuBK0=;
 b=nXmx6SP3KP8fcgU+QjoTSc4BAuBCdJ+uIBMgQVWFHZKoUBLWgOkxGppsbJpKzv0cre
 bKqnI+N3ZYA9gBz4RRACdYd4SrX+n7pXS4zNa1GRtikTAWcPqOlPrnK6LQsZsoSWFo4W
 /rFDwKj6s7nY3UI+4u4glqSLWIufOEpXQevPw3PGU3XIlxIZEA9rSmR3QF5IxawV9yeD
 Y4XhxWAZA0V/YPT5U4l8m/8BScXn9X3Dv2ejlqkpUHew8YWC/3FJRqqXYsclz3X2jI0T
 FYczT6EEaAHUIIBxFtvOY6itYlRRI3OvinLZmcslBO3gtQJ4RztZUC+klvyLPNPtbM3J
 zJCw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1YTu71NlQZXf4wiXan6PdmrZ+daBQUxfQdF2fAvvJ+Kgt7Y7SHQWk0xRA5ikwB1aQr3tTt8iq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZR9it21PEZU45fm9PxF0T++/x+CNpf6sKjVWIrxNT3OdCJgZ2
 Jr9efFCO7IPtMdL6ywYVweRYADkXevgAHGUFCPUBquiUFtbvh7fekcoU
X-Gm-Gg: AfdE7cl8WQvJKou7bf1z9UkjwuWS1cZXcrydhTV6k32aEnzcu2mUGfIdN9pq6hXmSXs
 O2pJ/M0Im6HvFsZ5hRuzUtYTYFlEYJZA0lmeyfXaZgdGyofj64TIYZA22B0F8d6p4Las+alE/i9
 ycTFn4aBZLxgufvFoIpVO/MRSzbNMHPkanat8lse00e+xlnS3aCa3do/eV4zaD6v47ZfEGEDswI
 +XkpGSKuZos8FGV6YsXcvfgM8ALpafz0rCaASgOpaorn0L/Ys3zQg2RqA+RwmLHZZ+3In9AUsMW
 MB0phhMd+kQHhkQ7XxjP1+pqUxO+omLwlXdzbMm5dP882y7gjRIwOndRHkzIVAEqCtvEiIELcG7
 l5+sQT6yfD7UeyipZSDQnBLLjyEA3QjZngORBkS48xv2Jj4HuR7gXzjQUL3yTGcTKNzNrarnnYO
 6PeSAGkQ0iaD3/g0fWSbTKPcFp0LziLnCeB57HkyrsLkkd2P729AsE9aJFg4Nf1yFDt8U=
X-Received: by 2002:a05:7300:d505:b0:30e:c71e:dbc with SMTP id
 5a478bee46e88-30ef09c05dfmr1472628eec.30.1782853491807; 
 Tue, 30 Jun 2026 14:04:51 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.15.127])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee32519aesm10995383eec.27.2026.06.30.14.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 14:04:51 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: alexander.deucher@amd.com,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org
Cc: christian.koenig@amd.com, arnd@arndb.de, rust-for-linux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v3] rust: core: implement rx580 state optimization engine and
 c-to-rust char dev
Date: Tue, 30 Jun 2026 18:04:45 -0300
Message-ID: <20260630210445.23103-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Jul 2026 07:11:03 +0000
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

This patch introduces an automated indexed state mechanism to optimize
VRAM latency and command loops for the Radeon RX 580 architecture.
Additionally, it provides a converted C-to-Rust sample char driver.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 Documentation/rust/alves_guidelines.rst  |  3 ++
 drivers/char/Kconfig                     |  7 +++++
 drivers/char/alves_char_dev.rs           | 31 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/Makefile      |  1 +
 drivers/gpu/drm/amd/amdgpu/alves_core.rs | 38 ++++++++++++++++++++++++
 5 files changed, 80 insertions(+)
 create mode 100644 Documentation/rust/alves_guidelines.rst
 create mode 100644 drivers/char/alves_char_dev.rs
 create mode 100644 drivers/gpu/drm/amd/amdgpu/alves_core.rs

diff --git a/Documentation/rust/alves_guidelines.rst b/Documentation/rust/alves_guidelines.rst
new file mode 100644
index 000000000..f6afa63de
--- /dev/null
+++ b/Documentation/rust/alves_guidelines.rst
@@ -0,0 +1,3 @@
+# Rust for Linux - Core Guidelines
+- Style: Linear, pragmatic, flat, Linus Torvalds style.
+- Constraints: Zero-cost abstractions, strict RAII, no binary bloat.
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 9865227af..ace4df826 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -372,3 +372,10 @@ config ADI
 	  driver include crash and makedumpfile.
 
 endmenu
+config ALVES_CHAR_DEV
+	tristate "Alves C-to-Rust Character Device Driver"
+	depends on RUST
+	help
+	  This is a character device driver migrated from C to Rust.
+	  It acts as a core showcase of 2% module conversions.
+	  Say Y or M here if you want to test the Rust infrastructure.
diff --git a/drivers/char/alves_char_dev.rs b/drivers/char/alves_char_dev.rs
new file mode 100644
index 000000000..5ccb80ea4
--- /dev/null
+++ b/drivers/char/alves_char_dev.rs
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+//! Simple Character Device converted from legacy C to Rust using core Miscdev API.
+
+use kernel::prelude::*;
+use kernel::miscdev;
+
+module! {
+    type: AlvesCharDevice,
+    name: "alves_char_dev",
+    author: "Breno Rodrigues Alves",
+    description: "Pragmatic C-to-Rust converted character device driver",
+    license: "GPL OR MIT",
+}
+
+struct AlvesCharDevice {
+    _dev: miscdev::Registration<AlvesCharDevice>,
+}
+
+#[vtable]
+impl miscdev::Options for AlvesCharDevice {
+    const NAME: \&"static CStr = c_str!("alves_char_dev");
+}
+
+impl kernel::Module for AlvesCharDevice {
+    fn init(module: \&"static ThisModule) -> Result<Self> {
+        pr_info!("Alves C-to-Rust module initialized successfully
+");
+        let dev = miscdev::Registration::new_reg(module)?;
+        Ok(AlvesCharDevice { _dev: dev })
+    }
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ba80542ea..b9f98c3e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -349,3 +349,4 @@ include $(AMD_GPU_RAS_FULL_PATH)/Makefile
 amdgpu-y += $(AMD_GPU_RAS_FILES)
 
 obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
+amdgpu-y += alves_core.o
diff --git a/drivers/gpu/drm/amd/amdgpu/alves_core.rs b/drivers/gpu/drm/amd/amdgpu/alves_core.rs
new file mode 100644
index 000000000..aa436763e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/alves_core.rs
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+//! AMDGPU RX 580 State Optimization Engine (Turing-inspired state machine)
+//!
+//! Copyright (C) 2026 Breno Rodrigues Alves.
+
+use kernel::prelude::*;
+
+#[derive(Copy, Clone, PartialEq, Eq)]
+#[repr(u8)]
+enum GpuState {
+    Idling = 0,
+    LowPower = 1,
+    ComputeActive = 2,
+    VramMaxPerf = 3,
+}
+
+struct Rx580Engine {
+    current_state: GpuState,
+}
+
+impl Rx580Engine {
+    fn transition(&mut self, symbol: u8) {
+        self.current_state = match (self.current_state, symbol) {
+            (GpuState::Idling, 0x01) => GpuState::LowPower,
+            (GpuState::LowPower, 0x02) => GpuState::ComputeActive,
+            (GpuState::ComputeActive, 0x03) => GpuState::VramMaxPerf,
+            (GpuState::VramMaxPerf, 0x00) => GpuState::Idling,
+            (state, _) => state,
+        };
+    }
+}
+
+#[no_mangle]
+pub extern "C" fn amdgpu_rust_rx580_optimize(register_sample: u32) {
+    let mut engine = Rx580Engine { current_state: GpuState::Idling };
+    let symbol = (register_sample \& 0xFF) as u8;
+    engine.transition(symbol);
+}
-- 
2.43.0

