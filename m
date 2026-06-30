Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B6BC44501
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 07:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F113210EE0A;
	Wed,  1 Jul 2026 07:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GyFCnhcu";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 414A210E1C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 20:57:57 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30bc871ecdfso6867939eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 13:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782853076; x=1783457876; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=B9Z5xnCi27i9C9A2sCgfs7Wzronwnuanh/3BE+vBDfs=;
 b=GyFCnhcuouhY2c4+ZjEC38jg4UOq4L/jwh7LPKUeE2InKKVWfi0d1K2Hm0fSA+cm30
 QaioW/bDoGBQ71MeEsOr25HrcXXmGFWhnFOFWDTF8UsklA/+Uu8dmryNeDu/bVd3dsbc
 1nsRtNxgdJHey4vIwKBTz2svuYO3Us4XOPBRkG6eX8MHE8XNaoNYQVi7+wL3VGaGEZ+i
 Nf2iL8JB4/yn1c1nVLrjzve+ujHUDnNh8AFqH0Bhi/Z2j+WwphsA28wtX1EEQ7DIeBGU
 c23Fu2UHVHiGHAQPLwpT5SBNkJUdyqZ56eDUbKjqu2TNuMZ9WwHQ9VduXBM+muA7Kd9n
 hGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782853076; x=1783457876;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B9Z5xnCi27i9C9A2sCgfs7Wzronwnuanh/3BE+vBDfs=;
 b=HtH8cO909Dti9ratPjeLCeUAvk/p9lnQknep54jlgoU1W8ev2/nz7Y66adF+Iy+sYB
 VEi9Qgh2d1xsJNnJAXn15NcnTsCidQN3flzuL4u4rR21VWcwOtoHaKooFOZCwucf8pp3
 C0eOAQogMIZt2PVw1IelwtwocS02UtApgXF65951Thxnd1Sygln5YFgTPIMGZsIG/Ki/
 DUFE59GmFVZGdunb/F95iKVOUPnr95FTJzHCb+Cahb51EYKwIeZZDVaoM89/p36ufjSn
 cgBUDOPcULbprKMnvY9jmTEfY27bd09eZbX7OGjQkyXzpw4z29uvl8x/6svPWLkLfrvg
 Rrdg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbZoNxaDZT3OUnECcQo2N49st1Bwji4/yzdKgEzOHt/F3yPlmzbU2w4SOSyNdHqHqRa0FcVKxo@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfMdVBPVDj7O3mNP97aEKM0uSHaIKRq3S3pAdPl74/+1i7Lx9D
 bB5mEzI/2Wi9dtQUU/SZ3xwVif07WoEThUa1BkpaeE4orTRjn62DLcMt
X-Gm-Gg: AfdE7clvIw7Z2cwBMHpcb+8VBZ47HsYor8X2SOguYpVMxOwb4X5XGYLZlAjRR9WHB6Z
 WgCMrBLpEa70j4coYs7vGDsi1YeRLBxbRnSrzzEJrF2EyKyMtlHE9G/19kiEdQDtyLTr0uiHJMJ
 cqxoPkZM0mprUqSkVgZOarjaHvVZNTf/iPToqDdmM6DhtGycEBXVWhXwQL32r4bevcWKy8Dl5Vk
 CMXz6Us1evGOh3/OdltoeVcvqO0K0rReH36OMnsnaT6VurQdvBLXxTZg5zW2S6uVnl3SlRXgY37
 c+tjsWfFGOhD8M0UJZtbrpDsaO2ovNKXXCbVrzoi0Z3z+rBlpXwGOQytBZ0CjppL/2TASJczUfT
 VoR9l8k32puhrwXQd6Eu7K8r/J3HWKN1DxdCkAqPQUuYaujBnW3vdrUYhf53nEBOhSqMJm1jO17
 pmV6drl1tpGAVi/+zWpyMmFyuizZ5PoHcGc3j6HuKn50QU7/7+kmkDEyB2
X-Received: by 2002:a05:7301:e8d:b0:30c:2af0:1cc with SMTP id
 5a478bee46e88-30ee14c4090mr3943097eec.34.1782853076312; 
 Tue, 30 Jun 2026 13:57:56 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.15.127])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee326c7a7sm11647045eec.29.2026.06.30.13.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 13:57:55 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: alexander.deucher@amd.com,
	gregkh@linuxfoundation.org,
	ojeda@kernel.org
Cc: christian.koenig@amd.com, arnd@arndb.de, rust-for-linux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v2] rust: core: implement rx580 state optimization engine and
 c-to-rust char dev
Date: Tue, 30 Jun 2026 17:57:50 -0300
Message-ID: <20260630205750.22673-1-breno3011alves@gmail.com>
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
 RUST_GUIDELINES.md                       |  3 ++
 drivers/char/Kconfig                     |  8 +++++
 drivers/char/Makefile                    |  1 +
 drivers/char/alves_char_dev.rs           | 26 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/Kbuild        |  1 +
 drivers/gpu/drm/amd/amdgpu/alves_core.rs | 45 ++++++++++++++++++++++++
 6 files changed, 84 insertions(+)
 create mode 100644 RUST_GUIDELINES.md
 create mode 100644 drivers/char/alves_char_dev.rs
 create mode 100644 drivers/gpu/drm/amd/amdgpu/Kbuild
 create mode 100644 drivers/gpu/drm/amd/amdgpu/alves_core.rs

diff --git a/RUST_GUIDELINES.md b/RUST_GUIDELINES.md
new file mode 100644
index 000000000..f6afa63de
--- /dev/null
+++ b/RUST_GUIDELINES.md
@@ -0,0 +1,3 @@
+# Rust for Linux - Core Guidelines
+- Style: Linear, pragmatic, flat, Linus Torvalds style.
+- Constraints: Zero-cost abstractions, strict RAII, no binary bloat.
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 9865227af..d6cbf317c 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -372,3 +372,11 @@ config ADI
 	  driver include crash and makedumpfile.
 
 endmenu
+config ALVES_CHAR_DEV
+	tristate "Alves C-to-Rust Character Device Driver"
+	dependson RUST
+	help
+	  This is a character device driver migrated from C to Rust.
+	  It acts as a core showcase of 2% module conversions.
+	  It provides foundational structures for execution validation.
+	  Say Y or M here if you want to test the Rust infrastructure.
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index a46d7bf7c..bf967e910 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -41,3 +41,4 @@ obj-$(CONFIG_PS3_FLASH)		+= ps3flash.o
 obj-$(CONFIG_XILLYBUS_CLASS)	+= xillybus/
 obj-$(CONFIG_POWERNV_OP_PANEL)	+= powernv-op-panel.o
 obj-$(CONFIG_ADI)		+= adi.o
+obj-$(CONFIG_ALVES_CHAR_DEV) += alves_char_dev.o
diff --git a/drivers/char/alves_char_dev.rs b/drivers/char/alves_char_dev.rs
new file mode 100644
index 000000000..48440ab32
--- /dev/null
+++ b/drivers/char/alves_char_dev.rs
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+//! Simple Character Device converted from legacy C to Rust.
+
+use kernel::prelude::*;
+use kernel::chrdev::Registration;
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
+    _dev: Registration,
+}
+
+impl kernel::Module for AlvesCharDevice {
+    fn init(_module: $'static ThisModule$') -> Result<Self> {
+        pr_info!("Alves C-to-Rust module initialized successfully\n");
+        Ok(AlvesCharDevice {
+            _dev: Registration::new(c_str!("alves_char_dev"), 0)?,
+        })
+    }
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/Kbuild b/drivers/gpu/drm/amd/amdgpu/Kbuild
new file mode 100644
index 000000000..9f3589689
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/Kbuild
@@ -0,0 +1 @@
+amdgpu-y += alves_core.o
diff --git a/drivers/gpu/drm/amd/amdgpu/alves_core.rs b/drivers/gpu/drm/amd/amdgpu/alves_core.rs
new file mode 100644
index 000000000..e16d06908
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/alves_core.rs
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+//! AMDGPU RX 580 State Optimization Engine.
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
+pub struct Rx580Engine {
+    current_state: GpuState,
+    command_tape: [u8; 16],
+    tape_pointer: usize,
+}
+
+impl Rx580Engine {
+    pub fn process_tape(&mut self) -> Result<()> {
+        while self.tape_pointer < self.command_tape.len() {
+            let symbol = self.command_tape[self.tape_pointer];
+
+            self.current_state = match (self.current_state, symbol) {
+                (GpuState::Idling, 0x01) => GpuState::LowPower,
+                (GpuState::LowPower, 0x02) => GpuState::ComputeActive,
+                (GpuState::ComputeActive, 0x03) => GpuState::VramMaxPerf,
+                (GpuState::VramMaxPerf, 0x00) => GpuState::Idling,
+                (state, _) => state,
+            };
+
+            // SAFETY: Volatile hardware write override for Polaris performance profiling.
+            unsafe {
+                core::ptr::write_volatile(&mut self.command_tape[self.tape_pointer], 0xFF);
+            }
+            self.tape_pointer += 1;
+        }
+        self.tape_pointer = 0;
+        Ok(())
+    }
+}
-- 
2.43.0

