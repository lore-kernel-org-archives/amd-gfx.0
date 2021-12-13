Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9BDC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 20:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1560410E8A1;
	Mon, 13 Dec 2021 20:36:20 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055E910E8BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 20:36:19 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 h19-20020a9d3e53000000b0056547b797b2so18711915otg.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 12:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7ymw4zzbx0fGEGW9oOqaMZw8xenwjMHHLGEYhutDDMI=;
 b=VqRj8hZn6aVzmGCiI1bqFAsrrdWp2dKCRPrOjRTu8VPhRnGlOBKJTLHeMY1U+v/1Lm
 Et08IkhtoVY2aIRLiCrFA3Ft6J+zrPBP4SvUOjVi2vLsPu/GvtMnumz38wQPlumjwlGW
 qsd1PYDswXnoQeZSZhbGxSV2w8TwF3cnpjIbXPMrFZ1SkrTeYBGR0FXKxMD0j6OdQLug
 rlTcP13JwdVK+dPclSJJ5ad2XO0dpnA+dK1TM6u2edPQxxl7wB+E+ZLgD0nj0JlLb4k4
 A3zn4amE9as8f333FaP+CKh7nZx7EojXkGq6e+C64pVcS453pNqtCZzVGs66J8e+iQhD
 hUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7ymw4zzbx0fGEGW9oOqaMZw8xenwjMHHLGEYhutDDMI=;
 b=f9ARBe+dpgedZAI5lR+5z/91kSiJml3UFSOVlQZfLj4yDnL2n2WVMLzp9FqSK8BogI
 57FIGjT6P2MYgAUC8ftJZmSWyETtwsPCn+8ICKgg5RoDp5bTwe9/gaVo9ljjZ6kqguAg
 OKPF0hBjU1JoJHCDS41/U65Fp/ifKqSQKtCitYMdFiViBLtqU0nYXRUTAy1A7vI5su2x
 jjBDJC9Ls07IJfYmAUOk6l51VcSPcPeS/bQ0GnbL5X+7Cmo4jOfrxGlhrj/d5wV+4yOV
 ux8ptG7fO4Trenl58TOg6+4W0SY7yjEzjmLjaMdFUNU7QKiNx7TqlaYTiycpF0teFUbv
 7e3g==
X-Gm-Message-State: AOAM531IsBeG6xnZXaNXBmiIRO8KqwH0O6ErOfo/1TW/WY7RfCI3bkA8
 Zpx6SzJ2uTlKz7iiLdXsXGEUHB7UDQNJutJ0sr8=
X-Google-Smtp-Source: ABdhPJw21J+2Oiu0OYbofiF9BdcRlQNtwFLgBXvwOvMcNEupDAT8bQ4oFJjaWmh/O5e44Pc+zeHBarTSH1EFBu3EBCE=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr703100otn.299.1639427778116;
 Mon, 13 Dec 2021 12:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20211210182030.3834-1-ydirson@free.fr>
 <20211210182030.3834-2-ydirson@free.fr>
 <c47a7b5b-a77c-6538-97e9-cb665f6e4dae@amd.com>
In-Reply-To: <c47a7b5b-a77c-6538-97e9-cb665f6e4dae@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Dec 2021 15:36:07 -0500
Message-ID: <CADnq5_OyHMOyFYXXEYRvZb_Mefm8JH10T8vMMNXqKk-WQHkXzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Documentation/gpu: split amdgpu/index for
 readability
To: Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Yann Dirson <ydirson@free.fr>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied. thanks!

Alex

On Mon, Dec 13, 2021 at 3:07 PM Rodrigo Siqueira Jordao
<rjordrigo@amd.com> wrote:
>
>
>
> On 2021-12-10 1:20 p.m., Yann Dirson wrote:
> > This starts to make the formated index much more manageable to the reader.
> >
> > Signed-off-by: Yann Dirson <ydirson@free.fr>
> > ---
> >   Documentation/gpu/amdgpu/driver-core.rst      |  65 ++++
> >   Documentation/gpu/amdgpu/driver-misc.rst      | 112 ++++++
> >   Documentation/gpu/amdgpu/index.rst            | 342 +-----------------
> >   .../gpu/amdgpu/module-parameters.rst          |   7 +
> >   Documentation/gpu/amdgpu/ras.rst              |  62 ++++
> >   Documentation/gpu/amdgpu/thermal.rst          |  65 ++++
> >   Documentation/gpu/amdgpu/xgmi.rst             |   5 +
> >   7 files changed, 324 insertions(+), 334 deletions(-)
> >   create mode 100644 Documentation/gpu/amdgpu/driver-core.rst
> >   create mode 100644 Documentation/gpu/amdgpu/driver-misc.rst
> >   create mode 100644 Documentation/gpu/amdgpu/module-parameters.rst
> >   create mode 100644 Documentation/gpu/amdgpu/ras.rst
> >   create mode 100644 Documentation/gpu/amdgpu/thermal.rst
> >   create mode 100644 Documentation/gpu/amdgpu/xgmi.rst
> >
> > diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu/amdgpu/driver-core.rst
> > new file mode 100644
> > index 000000000000..97f9a9b68924
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/driver-core.rst
> > @@ -0,0 +1,65 @@
> > +============================
> > + Core Driver Infrastructure
> > +============================
> > +
> > +.. _amdgpu_memory_domains:
> > +
> > +Memory Domains
> > +==============
> > +
> > +.. kernel-doc:: include/uapi/drm/amdgpu_drm.h
> > +   :doc: memory domains
> > +
> > +Buffer Objects
> > +==============
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +   :doc: amdgpu_object
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +   :internal:
> > +
> > +PRIME Buffer Sharing
> > +====================
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +   :doc: PRIME Buffer Sharing
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +   :internal:
> > +
> > +MMU Notifier
> > +============
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> > +   :doc: MMU Notifier
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> > +   :internal:
> > +
> > +AMDGPU Virtual Memory
> > +=====================
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +   :doc: GPUVM
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +   :internal:
> > +
> > +Interrupt Handling
> > +==================
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +   :doc: Interrupt Handling
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +   :internal:
> > +
> > +IP Blocks
> > +=========
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> > +   :doc: IP Blocks
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> > +   :identifiers: amd_ip_block_type amd_ip_funcs
> > diff --git a/Documentation/gpu/amdgpu/driver-misc.rst b/Documentation/gpu/amdgpu/driver-misc.rst
> > new file mode 100644
> > index 000000000000..e3d6b2fa2493
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/driver-misc.rst
> > @@ -0,0 +1,112 @@
> > +================================
> > + Misc AMDGPU driver information
> > +================================
> > +
> > +GPU Product Information
> > +=======================
> > +
> > +Information about the GPU can be obtained on certain cards
> > +via sysfs
> > +
> > +product_name
> > +------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +   :doc: product_name
> > +
> > +product_number
> > +--------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +   :doc: product_name
> > +
> > +serial_number
> > +-------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +   :doc: serial_number
> > +
> > +unique_id
> > +---------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: unique_id
> > +
> > +GPU Memory Usage Information
> > +============================
> > +
> > +Various memory accounting can be accessed via sysfs
> > +
> > +mem_info_vram_total
> > +-------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > +   :doc: mem_info_vram_total
> > +
> > +mem_info_vram_used
> > +------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > +   :doc: mem_info_vram_used
> > +
> > +mem_info_vis_vram_total
> > +-----------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > +   :doc: mem_info_vis_vram_total
> > +
> > +mem_info_vis_vram_used
> > +----------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > +   :doc: mem_info_vis_vram_used
> > +
> > +mem_info_gtt_total
> > +------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > +   :doc: mem_info_gtt_total
> > +
> > +mem_info_gtt_used
> > +-----------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > +   :doc: mem_info_gtt_used
> > +
> > +PCIe Accounting Information
> > +===========================
> > +
> > +pcie_bw
> > +-------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: pcie_bw
> > +
> > +pcie_replay_count
> > +-----------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +   :doc: pcie_replay_count
> > +
> > +GPU SmartShift Information
> > +==========================
> > +
> > +GPU SmartShift information via sysfs
> > +
> > +smartshift_apu_power
> > +--------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: smartshift_apu_power
> > +
> > +smartshift_dgpu_power
> > +---------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: smartshift_dgpu_power
> > +
> > +smartshift_bias
> > +---------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: smartshift_bias
> > diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
> > index ff38c360b04e..a24e1cfa7407 100644
> > --- a/Documentation/gpu/amdgpu/index.rst
> > +++ b/Documentation/gpu/amdgpu/index.rst
> > @@ -5,339 +5,13 @@
> >   The drm/amdgpu driver supports all AMD Radeon GPUs based on the Graphics Core
> >   Next (GCN) architecture.
> >
> > -Module Parameters
> > -=================
> > -
> > -The amdgpu driver supports the following module parameters:
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > -
> > -Core Driver Infrastructure
> > -==========================
> > -
> > -This section covers core driver infrastructure.
> > -
> > -.. _amdgpu_memory_domains:
> > -
> > -Memory Domains
> > ---------------
> > -
> > -.. kernel-doc:: include/uapi/drm/amdgpu_drm.h
> > -   :doc: memory domains
> > -
> > -Buffer Objects
> > ---------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > -   :doc: amdgpu_object
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > -   :internal:
> > -
> > -PRIME Buffer Sharing
> > ---------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > -   :doc: PRIME Buffer Sharing
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > -   :internal:
> > -
> > -MMU Notifier
> > -------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> > -   :doc: MMU Notifier
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> > -   :internal:
> > -
> > -AMDGPU Virtual Memory
> > ----------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > -   :doc: GPUVM
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > -   :internal:
> > -
> > -Interrupt Handling
> > -------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > -   :doc: Interrupt Handling
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > -   :internal:
> > -
> > -IP Blocks
> > ----------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> > -   :doc: IP Blocks
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> > -   :identifiers: amd_ip_block_type amd_ip_funcs
> > -
> > -Display Core
> > -============
> > -
> > -This section covers Display core.
> > -
> > -.. toctree::
> > -
> > -  display/index
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > -   :doc: overview
> > -
> > -AMDGPU XGMI Support
> > -===================
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> > -
> > -AMDGPU RAS Support
> > -==================
> > -
> > -The AMDGPU RAS interfaces are exposed via sysfs (for informational queries) and
> > -debugfs (for error injection).
> > -
> > -RAS debugfs/sysfs Control and Error Injection Interfaces
> > ---------------------------------------------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > -   :doc: AMDGPU RAS debugfs control interface
> > -
> > -RAS Reboot Behavior for Unrecoverable Errors
> > ---------------------------------------------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > -   :doc: AMDGPU RAS Reboot Behavior for Unrecoverable Errors
> > -
> > -RAS Error Count sysfs Interface
> > --------------------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > -   :doc: AMDGPU RAS sysfs Error Count Interface
> > -
> > -RAS EEPROM debugfs Interface
> > -----------------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > -   :doc: AMDGPU RAS debugfs EEPROM table reset interface
> > -
> > -RAS VRAM Bad Pages sysfs Interface
> > -----------------------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > -   :doc: AMDGPU RAS sysfs gpu_vram_bad_pages Interface
> > -
> > -Sample Code
> > ------------
> > -Sample code for testing error injection can be found here:
> > -https://cgit.freedesktop.org/mesa/drm/tree/tests/amdgpu/ras_tests.c
> > -
> > -This is part of the libdrm amdgpu unit tests which cover several areas of the GPU.
> > -There are four sets of tests:
> > -
> > -RAS Basic Test
> > -
> > -The test verifies the RAS feature enabled status and makes sure the necessary sysfs and debugfs files
> > -are present.
> > -
> > -RAS Query Test
> > -
> > -This test checks the RAS availability and enablement status for each supported IP block as well as
> > -the error counts.
> > -
> > -RAS Inject Test
> > -
> > -This test injects errors for each IP.
> > -
> > -RAS Disable Test
> > -
> > -This test tests disabling of RAS features for each IP block.
> > -
> > -
> > -GPU Power/Thermal Controls and Monitoring
> > -=========================================
> > -
> > -This section covers hwmon and power/thermal controls.
> > -
> > -HWMON Interfaces
> > -----------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: hwmon
> > -
> > -GPU sysfs Power State Interfaces
> > ---------------------------------
> > -
> > -GPU power controls are exposed via sysfs files.
> > -
> > -power_dpm_state
> > -~~~~~~~~~~~~~~~
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: power_dpm_state
> > -
> > -power_dpm_force_performance_level
> > -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: power_dpm_force_performance_level
> > -
> > -pp_table
> > -~~~~~~~~
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: pp_table
> > -
> > -pp_od_clk_voltage
> > -~~~~~~~~~~~~~~~~~
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: pp_od_clk_voltage
> > -
> > -pp_dpm_*
> > -~~~~~~~~
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie
> > -
> > -pp_power_profile_mode
> > -~~~~~~~~~~~~~~~~~~~~~
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: pp_power_profile_mode
> > -
> > -\*_busy_percent
> > -~~~~~~~~~~~~~~~
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: gpu_busy_percent
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: mem_busy_percent
> > -
> > -gpu_metrics
> > -~~~~~~~~~~~~~~~~~~~~~
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: gpu_metrics
> > -
> > -GPU Product Information
> > -=======================
> > -
> > -Information about the GPU can be obtained on certain cards
> > -via sysfs
> > -
> > -product_name
> > -------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > -   :doc: product_name
> > -
> > -product_number
> > ---------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > -   :doc: product_name
> > -
> > -serial_number
> > --------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > -   :doc: serial_number
> > -
> > -unique_id
> > ----------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: unique_id
> > -
> > -GPU Memory Usage Information
> > -============================
> > -
> > -Various memory accounting can be accessed via sysfs
> > -
> > -mem_info_vram_total
> > --------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > -   :doc: mem_info_vram_total
> > -
> > -mem_info_vram_used
> > -------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > -   :doc: mem_info_vram_used
> > -
> > -mem_info_vis_vram_total
> > ------------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > -   :doc: mem_info_vis_vram_total
> > -
> > -mem_info_vis_vram_used
> > -----------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> > -   :doc: mem_info_vis_vram_used
> > -
> > -mem_info_gtt_total
> > -------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > -   :doc: mem_info_gtt_total
> > -
> > -mem_info_gtt_used
> > ------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > -   :doc: mem_info_gtt_used
> > -
> > -PCIe Accounting Information
> > -===========================
> > -
> > -pcie_bw
> > --------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: pcie_bw
> > -
> > -pcie_replay_count
> > ------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > -   :doc: pcie_replay_count
> > -
> > -GPU SmartShift Information
> > -==========================
> > -
> > -GPU SmartShift information via sysfs
> > -
> > -smartshift_apu_power
> > ---------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: smartshift_apu_power
> > -
> > -smartshift_dgpu_power
> > ----------------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: smartshift_dgpu_power
> > -
> > -smartshift_bias
> > ----------------
> > -
> > -.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > -   :doc: smartshift_bias
> > -
> > -AMDGPU Glossary
> > -===============
> > -
> >   .. toctree::
> >
> > -   amdgpu-glossary.rst
> > +   module-parameters
> > +   driver-core
> > +   display/index
> > +   xgmi
> > +   ras
> > +   thermal
> > +   driver-misc
> > +   amdgpu-glossary
> > diff --git a/Documentation/gpu/amdgpu/module-parameters.rst b/Documentation/gpu/amdgpu/module-parameters.rst
> > new file mode 100644
> > index 000000000000..ea538c8dda35
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/module-parameters.rst
> > @@ -0,0 +1,7 @@
> > +===================
> > + Module Parameters
> > +===================
> > +
> > +The amdgpu driver supports the following module parameters:
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > diff --git a/Documentation/gpu/amdgpu/ras.rst b/Documentation/gpu/amdgpu/ras.rst
> > new file mode 100644
> > index 000000000000..047f76e395cf
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/ras.rst
> > @@ -0,0 +1,62 @@
> > +====================
> > + AMDGPU RAS Support
> > +====================
> > +
> > +The AMDGPU RAS interfaces are exposed via sysfs (for informational queries) and
> > +debugfs (for error injection).
> > +
> > +RAS debugfs/sysfs Control and Error Injection Interfaces
> > +========================================================
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +   :doc: AMDGPU RAS debugfs control interface
> > +
> > +RAS Reboot Behavior for Unrecoverable Errors
> > +============================================
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +   :doc: AMDGPU RAS Reboot Behavior for Unrecoverable Errors
> > +
> > +RAS Error Count sysfs Interface
> > +===============================
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +   :doc: AMDGPU RAS sysfs Error Count Interface
> > +
> > +RAS EEPROM debugfs Interface
> > +============================
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +   :doc: AMDGPU RAS debugfs EEPROM table reset interface
> > +
> > +RAS VRAM Bad Pages sysfs Interface
> > +==================================
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> > +   :doc: AMDGPU RAS sysfs gpu_vram_bad_pages Interface
> > +
> > +Sample Code
> > +===========
> > +Sample code for testing error injection can be found here:
> > +https://cgit.freedesktop.org/mesa/drm/tree/tests/amdgpu/ras_tests.c
> > +
> > +This is part of the libdrm amdgpu unit tests which cover several areas of the GPU.
> > +There are four sets of tests:
> > +
> > +RAS Basic Test
> > +
> > +The test verifies the RAS feature enabled status and makes sure the necessary sysfs and debugfs files
> > +are present.
> > +
> > +RAS Query Test
> > +
> > +This test checks the RAS availability and enablement status for each supported IP block as well as
> > +the error counts.
> > +
> > +RAS Inject Test
> > +
> > +This test injects errors for each IP.
> > +
> > +RAS Disable Test
> > +
> > +This test tests disabling of RAS features for each IP block.
> > diff --git a/Documentation/gpu/amdgpu/thermal.rst b/Documentation/gpu/amdgpu/thermal.rst
> > new file mode 100644
> > index 000000000000..8aeb0186c9ef
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/thermal.rst
> > @@ -0,0 +1,65 @@
> > +===========================================
> > + GPU Power/Thermal Controls and Monitoring
> > +===========================================
> > +
> > +HWMON Interfaces
> > +================
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: hwmon
> > +
> > +GPU sysfs Power State Interfaces
> > +================================
> > +
> > +GPU power controls are exposed via sysfs files.
> > +
> > +power_dpm_state
> > +---------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: power_dpm_state
> > +
> > +power_dpm_force_performance_level
> > +---------------------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: power_dpm_force_performance_level
> > +
> > +pp_table
> > +--------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: pp_table
> > +
> > +pp_od_clk_voltage
> > +-----------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: pp_od_clk_voltage
> > +
> > +pp_dpm_*
> > +--------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: pp_dpm_sclk pp_dpm_mclk pp_dpm_socclk pp_dpm_fclk pp_dpm_dcefclk pp_dpm_pcie
> > +
> > +pp_power_profile_mode
> > +---------------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: pp_power_profile_mode
> > +
> > +\*_busy_percent
> > +---------------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: gpu_busy_percent
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: mem_busy_percent
> > +
> > +gpu_metrics
> > +-----------
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +   :doc: gpu_metrics
> > diff --git a/Documentation/gpu/amdgpu/xgmi.rst b/Documentation/gpu/amdgpu/xgmi.rst
> > new file mode 100644
> > index 000000000000..23f2856f4524
> > --- /dev/null
> > +++ b/Documentation/gpu/amdgpu/xgmi.rst
> > @@ -0,0 +1,5 @@
> > +=====================
> > + AMDGPU XGMI Support
> > +=====================
> > +
> > +.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> >
>
> lgtm
>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
> Thanks.
