Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5756BC43327
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 08:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C312710F210;
	Thu,  2 Jul 2026 08:07:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v7kBGXlS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F44410E332
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 10:33:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DFC404033F;
 Wed,  1 Jul 2026 10:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD1C1F000E9;
 Wed,  1 Jul 2026 10:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1782901981;
 bh=aTZX0gXiTEE7JDt7/JZtMtv5Tbg1fdLtCyTAywHrS8c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=v7kBGXlSYYVGshBfp+N1nKM+kvPQ/oC8Ib7Am3whQXZVLiX3RI4/pYFF7m+ppYLJx
 YS9xHEqgZ2mlgbhr2IvgL3Tfu5nw4bBgD0cAdedyVNxuvfHoNkjn1Rz0Da0OopuC4R
 BI285oLaLgyRzX1cBz+0WCYfZII6uWAzv0zhxjiA=
Date: Wed, 1 Jul 2026 12:32:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Breno Rodrigues Alves <breno3011alves@gmail.com>
Cc: alexander.deucher@amd.com, ojeda@kernel.org, christian.koenig@amd.com,
 arnd@arndb.de, rust-for-linux@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: core: implement rx580 state optimization engine
 and c-to-rust char dev
Message-ID: <2026070136-unbent-mothball-49ba@gregkh>
References: <20260630210445.23103-1-breno3011alves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630210445.23103-1-breno3011alves@gmail.com>
X-Mailman-Approved-At: Thu, 02 Jul 2026 08:07:22 +0000
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

On Tue, Jun 30, 2026 at 06:04:45PM -0300, Breno Rodrigues Alves wrote:
> This patch introduces an automated indexed state mechanism to optimize
> VRAM latency and command loops for the Radeon RX 580 architecture.
> Additionally, it provides a converted C-to-Rust sample char driver.
> 
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
> ---
>  Documentation/rust/alves_guidelines.rst  |  3 ++
>  drivers/char/Kconfig                     |  7 +++++
>  drivers/char/alves_char_dev.rs           | 31 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/Makefile      |  1 +
>  drivers/gpu/drm/amd/amdgpu/alves_core.rs | 38 ++++++++++++++++++++++++
>  5 files changed, 80 insertions(+)
>  create mode 100644 Documentation/rust/alves_guidelines.rst
>  create mode 100644 drivers/char/alves_char_dev.rs
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/alves_core.rs
> 
> diff --git a/Documentation/rust/alves_guidelines.rst b/Documentation/rust/alves_guidelines.rst
> new file mode 100644
> index 000000000..f6afa63de
> --- /dev/null
> +++ b/Documentation/rust/alves_guidelines.rst
> @@ -0,0 +1,3 @@
> +# Rust for Linux - Core Guidelines
> +- Style: Linear, pragmatic, flat, Linus Torvalds style.
> +- Constraints: Zero-cost abstractions, strict RAII, no binary bloat.
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 9865227af..ace4df826 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -372,3 +372,10 @@ config ADI
>  	  driver include crash and makedumpfile.
>  
>  endmenu
> +config ALVES_CHAR_DEV
> +	tristate "Alves C-to-Rust Character Device Driver"
> +	depends on RUST
> +	help
> +	  This is a character device driver migrated from C to Rust.
> +	  It acts as a core showcase of 2% module conversions.
> +	  Say Y or M here if you want to test the Rust infrastructure.
> diff --git a/drivers/char/alves_char_dev.rs b/drivers/char/alves_char_dev.rs
> new file mode 100644
> index 000000000..5ccb80ea4
> --- /dev/null
> +++ b/drivers/char/alves_char_dev.rs
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +//! Simple Character Device converted from legacy C to Rust using core Miscdev API.

Where is the original C code?

And what is going to interact with this in userspace?  And how?

> +
> +use kernel::prelude::*;
> +use kernel::miscdev;
> +
> +module! {
> +    type: AlvesCharDevice,
> +    name: "alves_char_dev",
> +    author: "Breno Rodrigues Alves",
> +    description: "Pragmatic C-to-Rust converted character device driver",
> +    license: "GPL OR MIT",
> +}
> +
> +struct AlvesCharDevice {
> +    _dev: miscdev::Registration<AlvesCharDevice>,
> +}
> +
> +#[vtable]
> +impl miscdev::Options for AlvesCharDevice {
> +    const NAME: \&"static CStr = c_str!("alves_char_dev");
> +}
> +
> +impl kernel::Module for AlvesCharDevice {
> +    fn init(module: \&"static ThisModule) -> Result<Self> {
> +        pr_info!("Alves C-to-Rust module initialized successfully
> +");
> +        let dev = miscdev::Registration::new_reg(module)?;
> +        Ok(AlvesCharDevice { _dev: dev })
> +    }
> +}

This code doesn't actually do anything at all, how was it tested?


> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index ba80542ea..b9f98c3e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -349,3 +349,4 @@ include $(AMD_GPU_RAS_FULL_PATH)/Makefile
>  amdgpu-y += $(AMD_GPU_RAS_FILES)
>  
>  obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
> +amdgpu-y += alves_core.o
> diff --git a/drivers/gpu/drm/amd/amdgpu/alves_core.rs b/drivers/gpu/drm/amd/amdgpu/alves_core.rs
> new file mode 100644
> index 000000000..aa436763e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/alves_core.rs
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +//! AMDGPU RX 580 State Optimization Engine (Turing-inspired state machine)
> +//!
> +//! Copyright (C) 2026 Breno Rodrigues Alves.
> +
> +use kernel::prelude::*;
> +
> +#[derive(Copy, Clone, PartialEq, Eq)]
> +#[repr(u8)]
> +enum GpuState {
> +    Idling = 0,
> +    LowPower = 1,
> +    ComputeActive = 2,
> +    VramMaxPerf = 3,
> +}
> +
> +struct Rx580Engine {
> +    current_state: GpuState,
> +}
> +
> +impl Rx580Engine {
> +    fn transition(&mut self, symbol: u8) {
> +        self.current_state = match (self.current_state, symbol) {
> +            (GpuState::Idling, 0x01) => GpuState::LowPower,
> +            (GpuState::LowPower, 0x02) => GpuState::ComputeActive,
> +            (GpuState::ComputeActive, 0x03) => GpuState::VramMaxPerf,
> +            (GpuState::VramMaxPerf, 0x00) => GpuState::Idling,
> +            (state, _) => state,
> +        };
> +    }
> +}
> +
> +#[no_mangle]
> +pub extern "C" fn amdgpu_rust_rx580_optimize(register_sample: u32) {
> +    let mut engine = Rx580Engine { current_state: GpuState::Idling };
> +    let symbol = (register_sample \& 0xFF) as u8;
> +    engine.transition(symbol);
> +}

Same here, this code doesn't do anything that I can tell.  How was it
tested?

confused,

greg k-h
