Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEC2C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 23:38:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD4F910F73E;
	Mon, 13 Jun 2022 23:38:00 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69DB610F73E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 23:38:00 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id r5so260954pgr.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 16:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WWS+RTT/I/lDwwmxMeSM860X9v3cDtTSoiZ7XUnJEAE=;
 b=cGiC/L30QDyWOnXUrF7TdS0ebGVrUXMFPJGoIm2jv+CwpD17E0l2CJJwys1d3iWIc7
 F/e+j66oMqp039Aqr6JhpD9jNAOQf1+RIDo9SABo8/QmLIL8TzNd/sHKfxySqCsiakXj
 SPfPZGWzIBYJ9k5j9ZJTG62JlU8vSN2jMXdxCpYg5iCB/L7b5hgiC+ssJl50LRuN3oGW
 sCtYMgYPiO0Sg0L/tzhQTM9TiGhG8Q8dcAgqLuuF3r95GVDcJA1n1wtmyTU0ChOg2+X8
 Y6KowvmJAwFHRy4CcJsqXH6YNaZycb7scLXHX/rjJ0CNCkZbbDOi9f9M3Tdm/zJbnVld
 uvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WWS+RTT/I/lDwwmxMeSM860X9v3cDtTSoiZ7XUnJEAE=;
 b=Psf9ySQa6p68G6sh0gDcFphbrZT2KXMY6fP2jcqaYsOv+qiJMvAQapMzkKhz0f01HA
 FjpFLvtZOnA1p0z4OoIVVoaEif5QaQgfaPBCETG6pkKiGb/61i+BRsVS64trccg4JJk8
 qdYHrcRalGHbAXs/Di9rQ0AuB+NIX6/qBlcK8sWv9kddNOqYnK19338ewLone1Xq+J4I
 oCYhRDzf5fqyr9+vwyyYxQ9YbwGMRc56sxFusHclN0q3HH4ibEjKndeS9HYPO6va462d
 yD1x3JOwsc8UU6OTc7HqUSwELQa3nxniyzo+F/e59Ocs8E8VK+X7UlwGbu+7/fJchcq4
 s3SA==
X-Gm-Message-State: AOAM531RaIsa9x6RbwIrKXQ/pJejMlRsD2mZpHvxRBjg32mw/gH1wInE
 vaWNnyY+aZRBYgKEjqHh0mEchxmiD9IapN9HnJ2XCA==
X-Google-Smtp-Source: ABdhPJzRFx9OCqLjSpi37Cp1lcyTZVbjiW+VfeFOooyI9BmsYsV7wuVB2Y3Os4Nvjt8CIHZURiiDmHeRITZOlvH1Yh8=
X-Received: by 2002:a63:e74a:0:b0:3fe:7c2a:4b17 with SMTP id
 j10-20020a63e74a000000b003fe7c2a4b17mr1808463pgk.293.1655163479330; Mon, 13
 Jun 2022 16:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210414233533.24012-2-qingqing.zhuo@amd.com>
 <20210509121055.24728-1-youling257@gmail.com>
 <CADnq5_MF0y0sHH6Vz8KZH5j=iXToq3WPw7+kW=BqMk=oNZ=Ppw@mail.gmail.com>
 <CAOzgRdZf0R7mVY+spDZz_CG1Kpf7qmP6oGaOJ_XKauZA3ZhZeg@mail.gmail.com>
 <CAP+8YyEv3NPqeEVmFvQDoq_+=h8Q_goHUbgt7fNPUXJbR5AcKw@mail.gmail.com>
 <CAOzgRdYbmnA3M5d30i94TwGNtOWOviChBq9eEdhTjbfvGXaSfw@mail.gmail.com>
 <CAOzgRdaKpwd5ze8om4F22yq_DeREma1H6KUquqJ34dnSTvsjiQ@mail.gmail.com>
 <CAJUqKUoxKdp+U5y0gzi=_N94zs6b9DjUoYT3Mfn0-z-X0hCbMQ@mail.gmail.com>
 <CAOzgRdYEGELkhOOkkm=OOZsmrCrKjR+GKJ_ZyqVVjUURX+Szfw@mail.gmail.com>
 <CAOzgRdYgM6j8RKzTdy-MwrW+NeLaAn1fy0Q6-ACnvA5K=a-z3A@mail.gmail.com>
 <CAJUqKUrr_JWLSEf8djCqmoJw6WSYZBedKsRFh6F3as+BiomJEw@mail.gmail.com>
 <CAOzgRdbmz0ShtgO9MaKw_jycbPkc9Yj4vVQouLFTk_nRwdkArw@mail.gmail.com>
 <CAOzgRdYCChmY0XbVsOqHZ1gO5FYko3WAr8pPC+LZjkCfda7X_A@mail.gmail.com>
In-Reply-To: <CAOzgRdYCChmY0XbVsOqHZ1gO5FYko3WAr8pPC+LZjkCfda7X_A@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 14 Jun 2022 00:37:47 +0100
Message-ID: <CAHbf0-Hw1LBVnbNbX9+=50g5V84r7H5+q_fviEx523U0ciD51A@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "Revert "drm/amdgpu: Ensure that the modifier
 requested is supported by plane.""
To: youling 257 <youling257@gmail.com>
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
Cc: Mark Yacoub <markyacoub@chromium.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>, "Wheeler,
 Daniel" <daniel.wheeler@amd.com>, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

I'm seeing the following warning when building agd5f's tree with clang 14:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:4940:6:
warning: unused variable 'i' [-Wunused-variable]
       int i;
           ^
1 warning generated.

Which points to this revert

On Mon, 10 May 2021 at 18:43, youling 257 <youling257@gmail.com> wrote:
>
> 05-10 17:18:46.509     0     0 I         : [drm] amdgpu kernel
> modesetting enabled.
> 05-10 17:18:46.510     0     0 I amdgpu  : Topology: Add APU node [0x0:0x0]
> 05-10 17:18:46.510     0     0 D         : checking generic (e0000000
> fa0000) vs hw (e0000000 10000000)
> 05-10 17:18:46.510     0     0 I fb0     : switching to amdgpudrmfb from EFI VGA
> 05-10 17:18:46.510     0     0 I Console : switching to colour dummy
> device 80x25
> 05-10 17:18:46.510     0     0 I amdgpu 0000: 0b:00.0: vgaarb:
> deactivate vga console
> 05-10 17:18:46.510     0     0 I         : [drm] initializing kernel
> modesetting (RAVEN 0x1002:0x15D8 0x1002:0x15D8 0xC8).
> 05-10 17:18:46.510     0     0 I amdgpu 0000: 0b:00.0: amdgpu: Trusted
> Memory Zone (TMZ) feature enabled
> 05-10 17:18:46.510     0     0 I         : [drm] register mmio base: 0xFC900000
> 05-10 17:18:46.510     0     0 I         : [drm] register mmio size: 524288
> 05-10 17:18:46.510     0     0 I         : [drm] add ip block number 0
> <soc15_common>
> 05-10 17:18:46.510     0     0 I         : [drm] add ip block number 1
> <gmc_v9_0>
> 05-10 17:18:46.510     0     0 I         : [drm] add ip block number 2
> <vega10_ih>
> 05-10 17:18:46.510     0     0 I         : [drm] add ip block number 3 <psp>
> 05-10 17:18:46.510     0     0 I         : [drm] add ip block number 4
> <gfx_v9_0>
> 05-10 17:18:46.510     0     0 I         : [drm] add ip block number 5
> <sdma_v4_0>
> 05-10 17:18:46.510     0     0 I         : [drm] add ip block number 6
> <powerplay>
> 05-10 17:18:46.510     0     0 I         : [drm] add ip block number 7 <dm>
> 05-10 17:18:46.510     0     0 I         : [drm] add ip block number 8
> <vcn_v1_0>
> 05-10 17:18:46.533     0     0 I         : [drm] BIOS signature incorrect 0 0
> 05-10 17:18:46.533     0     0 I amdgpu 0000: 0b:00.0: amdgpu: Fetched
> VBIOS from ROM BAR
> 05-10 17:18:46.533     0     0 I amdgpu  : ATOM BIOS: 113-PICASSO-115
> 05-10 17:18:46.534     0     0 I         : [drm] VCN decode is enabled
> in VM mode
> 05-10 17:18:46.534     0     0 I         : [drm] VCN encode is enabled
> in VM mode
> 05-10 17:18:46.534     0     0 I         : [drm] JPEG decode is
> enabled in VM mode
> 05-10 17:18:46.534     0     0 I         : [drm] vm size is 262144 GB,
> 4 levels, block size is 9-bit, fragment size is 9-bit
> 05-10 17:18:46.534     0     0 I amdgpu 0000: 0b:00.0: amdgpu: VRAM:
> 64M 0x000000F400000000 - 0x000000F403FFFFFF (64M used)
> 05-10 17:18:46.534     0     0 I amdgpu 0000: 0b:00.0: amdgpu: GART:
> 1024M 0x0000000000000000 - 0x000000003FFFFFFF
> 05-10 17:18:46.534     0     0 I amdgpu 0000: 0b:00.0: amdgpu: AGP:
> 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
> 05-10 17:18:46.534     0     0 I         : [drm] Detected VRAM RAM=64M, BAR=64M
> 05-10 17:18:46.534     0     0 I         : [drm] RAM width 64bits DDR4
> 05-10 17:18:46.534     0     0 I [drm] amdgpu: 64M of VRAM memory ready
> 05-10 17:18:46.534     0     0 I [drm] amdgpu: 3072M of GTT memory ready.
> 05-10 17:18:46.534     0     0 I [drm] GART: num cpu pages 262144, num
> gpu pages 262144
> 05-10 17:18:46.534     0     0 I         : [drm] PCIE GART of 1024M enabled.
> 05-10 17:18:46.534     0     0 I         : [drm] PTB located at
> 0x000000F400FA0000
> 05-10 17:18:46.536     0     0 I amdgpu  : hwmgr_sw_init smu backed is smu10_smu
> 05-10 17:18:46.536     0     0 D [drm:dm_sw_init [amdgpu]] dm: DMCU
> firmware not found
> 05-10 17:18:46.537     0     0 I         : [drm] Found VCN firmware
> Version ENC: 1.12 DEC: 2 VEP: 0 Revision: 1
> 05-10 17:18:46.537     0     0 I         : [drm] PSP loading VCN firmware
> 05-10 17:18:46.558     0     0 I         : [drm] reserve 0x400000 from
> 0xf403c00000 for PSP TMR
> 05-10 17:18:46.567     0     0 I iwlwifi 0000: 07:00.0: base HW
> address: e0:d4:e8:48:f5:67
> 05-10 17:18:46.615     0     0 I amdgpu 0000: 0b:00.0: amdgpu: RAS:
> optional ras ta ucode is not available
> 05-10 17:18:46.620     0     0 I amdgpu 0000: 0b:00.0: amdgpu: RAP:
> optional rap ta ucode is not available
> 05-10 17:18:46.620     0     0 I amdgpu 0000: 0b:00.0: amdgpu:
> SECUREDISPLAY: securedisplay ta ucode is not available
> 05-10 17:18:46.622     0     0 I         : [drm] kiq ring mec 2 pipe 1 q 0
> 05-10 17:18:46.622     0     0 D         : [drm:amdgpu_dm_irq_init
> [amdgpu]] DM_IRQ
> 05-10 17:18:46.622     0     0 D         :
> [drm:dal_firmware_parser_init_cmd_tbl [amdgpu]] Don't have
> set_crtc_timing for v1
> 05-10 17:18:46.623     0     0 I [drm] DM_PPLIB: values for F clock
> 05-10 17:18:46.623     0     0 I [drm] DM_PPLIB: 400000 in kHz, 3099 in mV
> 05-10 17:18:46.623     0     0 I [drm] DM_PPLIB: 933000 in kHz, 3574 in mV
> 05-10 17:18:46.623     0     0 I [drm] DM_PPLIB: 1200000 in kHz, 4399 in mV
> 05-10 17:18:46.623     0     0 I [drm] DM_PPLIB: 1333000 in kHz, 4399 in mV
> 05-10 17:18:46.623     0     0 I [drm] DM_PPLIB: values for DCF clock
> 05-10 17:18:46.623     0     0 I [drm] DM_PPLIB: 300000 in kHz, 3099 in mV
> 05-10 17:18:46.623     0     0 I [drm] DM_PPLIB: 600000 in kHz, 3574 in mV
> 05-10 17:18:46.623     0     0 I [drm] DM_PPLIB: 626000 in kHz, 4250 in mV
> 05-10 17:18:46.623     0     0 I [drm] DM_PPLIB: 654000 in kHz, 4399 in mV
> 05-10 17:18:46.623     0     0 D         : [drm:dc_create [amdgpu]]
> BIOS object table - number of connectors: 4
> 05-10 17:18:46.624     0     0 D [drm:dc_create [amdgpu]] DC:
> create_links: connectors_num: physical:4, virtual:0
> 05-10 17:18:46.624     0     0 D         : [drm:dc_create [amdgpu]]
> BIOS object table - printing link object info for connector number: 0,
> link_index: 0
> 05-10 17:18:46.624     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - link_id: 19
> 05-10 17:18:46.624     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - is_internal_display: 0
> 05-10 17:18:46.625     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - hpd_gpio id: 3
> 05-10 17:18:46.625     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - hpd_gpio en: 0
> 05-10 17:18:46.625     0     0 D         : [drm:link_create [amdgpu]]
> Connector[0] description:signal 32
> 05-10 17:18:46.625     0     0 D         : [drm:dal_ddc_service_create
> [amdgpu]] BIOS object table - i2c_line: 0
> 05-10 17:18:46.625     0     0 D         : [drm:dal_ddc_service_create
> [amdgpu]] BIOS object table - i2c_engine_id: 1
> 05-10 17:18:46.626     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - DP_IS_USB_C: 0
> 05-10 17:18:46.626     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.acpi_device: 0
> 05-10 17:18:46.626     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.dev_id.device_type: 3
> 05-10 17:18:46.626     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.dev_id.enum_id: 1
> 05-10 17:18:46.626     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - ddi_channel_mapping: 0x00E4
> 05-10 17:18:46.627     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - chip_caps: 0
> 05-10 17:18:46.627     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - dc_link_construct finished successfully.
> 05-10 17:18:46.627     0     0 D         : [drm:dc_create [amdgpu]]
> BIOS object table - printing link object info for connector number: 1,
> link_index: 1
> 05-10 17:18:46.627     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - link_id: 12
> 05-10 17:18:46.627     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - is_internal_display: 0
> 05-10 17:18:46.628     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - hpd_gpio id: 3
> 05-10 17:18:46.628     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - hpd_gpio en: 1
> 05-10 17:18:46.628     0     0 D         : [drm:link_create [amdgpu]]
> Connector[1] description:signal 4
> 05-10 17:18:46.628     0     0 D         : [drm:dal_ddc_service_create
> [amdgpu]] BIOS object table - i2c_line: 1
> 05-10 17:18:46.628     0     0 D         : [drm:dal_ddc_service_create
> [amdgpu]] BIOS object table - i2c_engine_id: 1
> 05-10 17:18:46.629     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - DP_IS_USB_C: 0
> 05-10 17:18:46.629     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.acpi_device: 0
> 05-10 17:18:46.629     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.dev_id.device_type: 3
> 05-10 17:18:46.629     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.dev_id.enum_id: 2
> 05-10 17:18:46.629     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - ddi_channel_mapping: 0x00E4
> 05-10 17:18:46.629     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - chip_caps: 8
> 05-10 17:18:46.630     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - dc_link_construct finished successfully.
> 05-10 17:18:46.630     0     0 D         : [drm:dc_create [amdgpu]]
> BIOS object table - printing link object info for connector number: 2,
> link_index: 2
> 05-10 17:18:46.630     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - link_id: 12
> 05-10 17:18:46.630     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - is_internal_display: 0
> 05-10 17:18:46.630     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - hpd_gpio id: 3
> 05-10 17:18:46.630     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - hpd_gpio en: 2
> 05-10 17:18:46.630     0     0 D         : [drm:link_create [amdgpu]]
> Connector[2] description:signal 4
> 05-10 17:18:46.631     0     0 D         : [drm:dal_ddc_service_create
> [amdgpu]] BIOS object table - i2c_line: 2
> 05-10 17:18:46.631     0     0 D         : [drm:dal_ddc_service_create
> [amdgpu]] BIOS object table - i2c_engine_id: 1
> 05-10 17:18:46.631     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - DP_IS_USB_C: 1
> 05-10 17:18:46.631     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.acpi_device: 0
> 05-10 17:18:46.631     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.dev_id.device_type: 3
> 05-10 17:18:46.631     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.dev_id.enum_id: 3
> 05-10 17:18:46.632     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - ddi_channel_mapping: 0x00E4
> 05-10 17:18:46.632     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - chip_caps: 256
> 05-10 17:18:46.632     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - dc_link_construct finished successfully.
> 05-10 17:18:46.632     0     0 D         : [drm:dc_create [amdgpu]]
> BIOS object table - printing link object info for connector number: 3,
> link_index: 3
> 05-10 17:18:46.632     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - link_id: 12
> 05-10 17:18:46.632     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - is_internal_display: 0
> 05-10 17:18:46.632     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - hpd_gpio id: 3
> 05-10 17:18:46.633     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - hpd_gpio en: 3
> 05-10 17:18:46.633     0     0 D         : [drm:link_create [amdgpu]]
> Connector[3] description:signal 4
> 05-10 17:18:46.633     0     0 D         : [drm:dal_ddc_service_create
> [amdgpu]] BIOS object table - i2c_line: 3
> 05-10 17:18:46.633     0     0 D         : [drm:dal_ddc_service_create
> [amdgpu]] BIOS object table - i2c_engine_id: 1
> 05-10 17:18:46.633     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - DP_IS_USB_C: 1
> 05-10 17:18:46.633     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.acpi_device: 0
> 05-10 17:18:46.633     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.dev_id.device_type: 3
> 05-10 17:18:46.634     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - device_tag.dev_id.enum_id: 4
> 05-10 17:18:46.634     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - ddi_channel_mapping: 0x00E4
> 05-10 17:18:46.634     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - chip_caps: 264
> 05-10 17:18:46.634     0     0 D         : [drm:link_create [amdgpu]]
> BIOS object table - dc_link_construct finished successfully.
> 05-10 17:18:46.634     0     0 D         : [drm:dc_create [amdgpu]]
> BIOS object table - end
> 05-10 17:18:46.634     0     0 D         : [drm:dc_create [amdgpu]]
> Display Core initialized
> 05-10 17:18:46.635     0     0 I         : [drm] Display Core
> initialized with v3.2.132!
> 05-10 17:18:46.666     0     0 D         :
> [drm:dm_helpers_dp_read_dpcd [amdgpu]] Failed to find connector for
> link!
> 05-10 17:18:46.679     0     0 D         : [drm:mpc1_assert_idle_mpcc
> [amdgpu]] REG_WAIT taking a while: 5ms in mpc1_assert_idle_mpcc
> line:108
> 05-10 17:18:46.679     0     0 D         :
> [drm:dcn10_plane_atomic_disable [amdgpu]] Power gated front end 0
> 05-10 17:18:46.680     0     0 D         : [drm:dcn10_init_pipes
> [amdgpu]] Power down front end 0
> 05-10 17:18:46.680     0     0 D         :
> [drm:dcn10_plane_atomic_disable [amdgpu]] Power gated front end 1
> 05-10 17:18:46.680     0     0 D         : [drm:dcn10_init_pipes
> [amdgpu]] Power down front end 1
> 05-10 17:18:46.680     0     0 D         :
> [drm:dcn10_plane_atomic_disable [amdgpu]] Power gated front end 2
> 05-10 17:18:46.680     0     0 D         : [drm:dcn10_init_pipes
> [amdgpu]] Power down front end 2
> 05-10 17:18:46.681     0     0 D         :
> [drm:dcn10_plane_atomic_disable [amdgpu]] Power gated front end 3
> 05-10 17:18:46.681     0     0 D         : [drm:dcn10_init_pipes
> [amdgpu]] Power down front end 3
> 05-10 17:18:46.681     0     0 D         : [drm:drm_connector_init]
> cmdline mode for connector DP-1  2560x1600@60Hz
> 05-10 17:18:46.681     0     0 D         : [drm:dc_link_detect_helper
> [amdgpu]] link=0, dc_sink_in=0000000000000000 is now Disconnected
> prev_sink=0000000000000000 dpcd same=1 edid same=0
> 05-10 17:18:46.681     0     0 D         : [drm:drm_connector_init]
> cmdline mode for connector HDMI-A-1  2560x1600@60Hz
> 05-10 17:18:46.706     0     0 D         : [drm:drm_add_display_info]
> Supported Monitor Refresh rate range is 48 Hz - 75 Hz
> 05-10 17:18:46.706     0     0 D         : [drm:drm_add_display_info]
> non_desktop set to 0
> 05-10 17:18:46.706     0     0 D [drm:drm_add_display_info] HDMI: DVI
> dual 0, max TMDS clock 320000 kHz
> 05-10 17:18:46.706     0     0 D         : [drm:drm_add_display_info]
> hdmi_21 sink detected. parsing edid
> 05-10 17:18:46.706     0     0 D         : [drm:drm_add_display_info]
> CEA VCDB 0xff
> 05-10 17:18:46.706     0     0 D         : [drm:drm_add_display_info]
> Supported Monitor Refresh rate range is 48 Hz - 75 Hz
> 05-10 17:18:46.706     0     0 D         : [drm:drm_add_display_info]
> non_desktop set to 0
> 05-10 17:18:46.706     0     0 D [drm:drm_add_display_info] HDMI: DVI
> dual 0, max TMDS clock 320000 kHz
> 05-10 17:18:46.706     0     0 D         : [drm:drm_add_display_info]
> hdmi_21 sink detected. parsing edid
> 05-10 17:18:46.706     0     0 D         : [drm:drm_add_display_info]
> CEA VCDB 0xff
> 05-10 17:18:46.707     0     0 D [drm:dc_link_detect_helper [amdgpu]]
> HDMI: [Block 0]
> 05-10 17:18:46.707     0     0 D [drm:dc_link_detect_helper [amdgpu]]
> HDMI: [Block 1]
> 05-10 17:18:46.707     0     0 D [drm:dc_link_detect_helper [amdgpu]]
> dc_link_detect_helper: manufacturer_id = 1863, product_id = 101,
> serial_number = 1010101, manufacture_week = 20, manufacture_year = 29,
> display_name = HDMI, speaker_flag = 1, audio_mode_count = 1
> 05-10 17:18:46.707     0     0 D [drm:dc_link_detect_helper [amdgpu]]
> dc_link_detect_helper: mode number = 0, format_code = 1, channel_count
> = 2, sample_rate = 7, sample_size = 7
> 05-10 17:18:46.707     0     0 D         : [drm:dc_link_detect_helper
> [amdgpu]] link=1, dc_sink_in=00000000e79abeb2 is now Connected
> prev_sink=0000000000000000 dpcd same=1 edid same=0
> 05-10 17:18:46.707     0     0 D         : [drm:drm_connector_init]
> cmdline mode for connector HDMI-A-2  2560x1600@60Hz
> 05-10 17:18:46.707     0     0 D         : [drm:dc_link_detect_helper
> [amdgpu]] link=2, dc_sink_in=0000000000000000 is now Disconnected
> prev_sink=0000000000000000 dpcd same=1 edid same=0
> 05-10 17:18:46.707     0     0 D         : [drm:drm_connector_init]
> cmdline mode for connector HDMI-A-3  2560x1600@60Hz
> 05-10 17:18:46.708     0     0 D         : [drm:dc_link_detect_helper
> [amdgpu]] link=3, dc_sink_in=0000000000000000 is now Disconnected
> prev_sink=0000000000000000 dpcd same=1 edid same=0
> 05-10 17:18:46.708     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 00000000c614992a for: dal_src=78,
> irq context=1
> 05-10 17:18:46.708     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 000000009e2a0026 for: dal_src=79,
> irq context=1
> 05-10 17:18:46.708     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 00000000acf6dfe7 for: dal_src=80,
> irq context=1
> 05-10 17:18:46.708     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 00000000696d7950 for: dal_src=81,
> irq context=1
> 05-10 17:18:46.708     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 00000000ce7f5912 for: dal_src=72,
> irq context=1
> 05-10 17:18:46.708     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 00000000a96b7920 for: dal_src=73,
> irq context=1
> 05-10 17:18:46.709     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 00000000de906a3f for: dal_src=74,
> irq context=1
> 05-10 17:18:46.709     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 0000000071d9647b for: dal_src=75,
> irq context=1
> 05-10 17:18:46.709     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 00000000d8d507bc for: dal_src=26,
> irq context=1
> 05-10 17:18:46.709     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 0000000056c37432 for: dal_src=27,
> irq context=1
> 05-10 17:18:46.709     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 00000000c1abaf1d for: dal_src=28,
> irq context=1
> 05-10 17:18:46.709     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 000000004c8a831f for: dal_src=29,
> irq context=1
> 05-10 17:18:46.710     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 00000000ba66a8e0 for: dal_src=1,
> irq context=0
> 05-10 17:18:46.710     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 000000009a8dde8f for: dal_src=7,
> irq context=0
> 05-10 17:18:46.710     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 00000000b049c0cd for: dal_src=2,
> irq context=0
> 05-10 17:18:46.710     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 0000000010e5f25b for: dal_src=3,
> irq context=0
> 05-10 17:18:46.710     0     0 D [drm:amdgpu_dm_irq_register_interrupt
> [amdgpu]] DM_IRQ: added irq handler: 000000003e0c16ec for: dal_src=4,
> irq context=0
> 05-10 17:18:46.721     0     0 I         : [drm] VCN decode and encode
> initialized successfully(under SPG Mode).
> 05-10 17:18:46.722     0     0 I         : kfd kfd: amdgpu: Allocated
> 3969056 bytes on gart
> 05-10 17:18:46.722     0     0 E         : kfd kfd: amdgpu: error
> getting iommu info. is the iommu enabled?
> 05-10 17:18:46.722     0     0 E         : kfd kfd: amdgpu: Error
> initializing iommuv2
> 05-10 17:18:46.722     0     0 E         : kfd kfd: amdgpu: device
> 1002:15d8 NOT added due to errors
> 05-10 17:18:46.722     0     0 I amdgpu 0000: 0b:00.0: amdgpu: SE 1,
> SH per SE 1, CU per SH 11, active_cu_number 11
> 05-10 17:18:46.722     0     0 D         : [drm:drm_client_modeset_probe]
> 05-10 17:18:46.722     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 78:DP-1]
> 05-10 17:18:46.722     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 78:DP-1]
> status updated from unknown to disconnected
> 05-10 17:18:46.722     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 78:DP-1]
> disconnected
> 05-10 17:18:46.722     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 85:HDMI-A-1]
> 05-10 17:18:46.722     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 85:HDMI-A-1]
> status updated from unknown to connected
> 05-10 17:18:46.722     0     0 D         : [drm:drm_add_edid_modes]
> ELD monitor HDMI
> 05-10 17:18:46.722     0     0 D [drm:drm_add_edid_modes] HDMI:
> latency present 0 0, video latency 0 0, audio latency 0 0
> 05-10 17:18:46.722     0     0 D         : [drm:drm_add_edid_modes]
> ELD size 28, SAD count 1
> 05-10 17:18:46.722     0     0 D         : [drm:drm_add_display_info]
> Supported Monitor Refresh rate range is 48 Hz - 75 Hz
> 05-10 17:18:46.722     0     0 D         : [drm:drm_add_display_info]
> non_desktop set to 0
> 05-10 17:18:46.722     0     0 D [drm:drm_add_display_info] HDMI: DVI
> dual 0, max TMDS clock 320000 kHz
> 05-10 17:18:46.722     0     0 D         : [drm:drm_add_display_info]
> hdmi_21 sink detected. parsing edid
> 05-10 17:18:46.722     0     0 D         : [drm:drm_add_display_info]
> CEA VCDB 0xff
> 05-10 17:18:46.722     0     0 D         :
> [drm:drm_for_each_detailed_block.part.0] stereo mode not supported
> 05-10 17:18:46.722     0     0 D         :
> [drm:drm_for_each_detailed_block.part.0] stereo mode not supported
> 05-10 17:18:46.722     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:2560  height:1600
> 05-10 17:18:46.722     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> 05-10 17:18:46.723     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> 05-10 17:18:46.723     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> 05-10 17:18:46.723     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> 05-10 17:18:46.723     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1680  height:1050
> 05-10 17:18:46.724     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1400  height:1050
> 05-10 17:18:46.724     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1600  height:900
> 05-10 17:18:46.724     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:1024
> 05-10 17:18:46.724     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:1024
> 05-10 17:18:46.724     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1440  height:900
> 05-10 17:18:46.725     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:960
> 05-10 17:18:46.725     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
> 05-10 17:18:46.725     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
> 05-10 17:18:46.725     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
> 05-10 17:18:46.725     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
> 05-10 17:18:46.725     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
> 05-10 17:18:46.726     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
> 05-10 17:18:46.726     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:800  height:600
> 05-10 17:18:46.726     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:800  height:600
> 05-10 17:18:46.726     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
> 05-10 17:18:46.726     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
> 05-10 17:18:46.726     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
> 05-10 17:18:46.727     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:720  height:400
> 05-10 17:18:46.727     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:800
> 05-10 17:18:46.727     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1600  height:1200
> 05-10 17:18:46.727     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1200
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1920x1080i": 60 74250
> 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_prune_invalid] Not using 1920x1080i mode: NO_INTERLACE
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1920x1080i": 60 74176
> 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_prune_invalid] Not using 1920x1080i mode: NO_INTERLACE
> 05-10 17:18:46.727     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 85:HDMI-A-1]
> probed modes :
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "2560x1600": 60 267810
> 2560 2608 2640 2720 1600 1603 1608 1641 0x68 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1920x1200": 60 267810
> 1920 2608 2640 2720 1200 1603 1608 1641 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1920x1080": 60 148500
> 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0xa
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1920x1080": 60 148500
> 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1920x1080": 60 148352
> 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1920x1080": 50 148500
> 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1600x1200": 60 267810
> 1600 2608 2640 2720 1200 1603 1608 1641 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1680x1050": 60 119000
> 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1400x1050": 60 101000
> 1400 1448 1480 1560 1050 1053 1057 1080 0x40 0x9
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1600x900": 60 108000 1600
> 1624 1704 1800 900 901 904 1000 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1280x1024": 75 135000
> 1280 1296 1440 1688 1024 1025 1028 1066 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1280x1024": 60 108000
> 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1440x900": 60 88750 1440
> 1488 1520 1600 900 903 909 926 0x40 0x9
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1280x960": 60 108000 1280
> 1376 1488 1800 960 961 964 1000 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1280x800": 60 267810 1280
> 2608 2640 2720 800 1603 1608 1641 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1280x720": 60 74250 1280
> 1390 1430 1650 720 725 730 750 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1280x720": 60 74250 1280
> 1390 1430 1650 720 725 730 750 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1280x720": 60 74176 1280
> 1390 1430 1650 720 725 730 750 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1024x768": 75 78750 1024
> 1040 1136 1312 768 769 772 800 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1024x768": 70 75000 1024
> 1048 1184 1328 768 771 777 806 0x40 0xa
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "1024x768": 60 65000 1024
> 1048 1184 1344 768 771 777 806 0x40 0xa
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "800x600": 75 49500 800
> 816 896 1056 600 601 604 625 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "800x600": 60 40000 800
> 840 968 1056 600 601 605 628 0x40 0x5
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "640x480": 75 31500 640
> 656 720 840 480 481 484 500 0x40 0xa
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "640x480": 60 25200 640
> 656 752 800 480 490 492 525 0x40 0xa
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "640x480": 60 25175 640
> 656 752 800 480 490 492 525 0x40 0xa
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_mode_debug_printmodeline] Modeline "720x400": 70 28320 720
> 738 846 900 400 412 414 449 0x40 0x6
> 05-10 17:18:46.727     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 90:HDMI-A-2]
> 05-10 17:18:46.727     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 90:HDMI-A-2]
> status updated from unknown to disconnected
> 05-10 17:18:46.727     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 90:HDMI-A-2]
> disconnected
> 05-10 17:18:46.727     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 94:HDMI-A-3]
> 05-10 17:18:46.727     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 94:HDMI-A-3]
> status updated from unknown to disconnected
> 05-10 17:18:46.727     0     0 D
> [drm:drm_helper_probe_single_connector_modes] [CONNECTOR: 94:HDMI-A-3]
> disconnected
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_client_modeset_probe] connector 78 enabled? no
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_client_modeset_probe] connector 85 enabled? yes
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_client_modeset_probe] connector 90 enabled? no
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_client_modeset_probe] connector 94 enabled? no
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_client_modeset_probe] Not using firmware configuration
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_client_modeset_probe] looking for cmdline mode on connector
> 85
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_client_modeset_probe] found mode 2560x1600
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_client_modeset_probe] picking CRTCs for 16384x16384 config
> 05-10 17:18:46.727     0     0 D         :
> [drm:drm_client_modeset_probe] desired mode 2560x1600 set on crtc 67
> (0,0)
> 05-10 17:18:46.727     0     0 D amdgpu 0000: 0b:00.0:
> [drm:__drm_fb_helper_initial_config_and_unlock] test CRTC 0 primary
> plane
> 05-10 17:18:46.727     0     0 D amdgpu 0000: 0b:00.0:
> [drm:__drm_fb_helper_initial_config_and_unlock] test CRTC 1 primary
> plane
> 05-10 17:18:46.727     0     0 D amdgpu 0000: 0b:00.0:
> [drm:__drm_fb_helper_initial_config_and_unlock] test CRTC 2 primary
> plane
> 05-10 17:18:46.727     0     0 D amdgpu 0000: 0b:00.0:
> [drm:__drm_fb_helper_initial_config_and_unlock] test CRTC 3 primary
> plane
> 05-10 17:18:46.729     0     0 I         : [drm] fb mappable at 0xDD26A000
> 05-10 17:18:46.729     0     0 I         : [drm] vram apper at 0xDC000000
> 05-10 17:18:46.729     0     0 I         : [drm] size 16384000
> 05-10 17:18:46.729     0     0 I         : [drm] fb depth is 24
> 05-10 17:18:46.729     0     0 I         : [drm]    pitch is 10240
> 05-10 17:18:46.729     0     0 I fbcon   : amdgpudrmfb (fb0) is primary device
> 05-10 17:18:46.729     0     0 D         : [drm:create_stream_for_sink
> [amdgpu]] Destination Rectangle x:0  y:0  width:2560  height:1600
> 05-10 17:18:46.730     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.730     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.730     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.730     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.730     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.730     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.731     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.731     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.731     0     0 D [drm:dc_commit_state [amdgpu]]
> dc_commit_state: 1 streams
> 05-10 17:18:46.731     0     0 D         : [drm:dc_stream_log
> [amdgpu]] core_stream 0x000000008f34ae37: src: 0, 0, 2560, 1600; dst:
> 0, 0, 2560, 1600, colorSpace:6
> 05-10 17:18:46.731     0     0 D [drm:dc_stream_log [amdgpu]]
>         pix_clk_khz: 267810, h_total: 2720, v_total: 1641, pixelencoder:3,
> displaycolorDepth:2
> 05-10 17:18:46.731     0     0 D [drm:dc_commit_state [amdgpu]]         link: 1
> 05-10 17:18:46.732     0     0 D         :
> [drm:dcn10_plane_atomic_disable [amdgpu]] Power gated front end 0
> 05-10 17:18:46.732     0     0 D         : [drm:dcn10_init_pipes
> [amdgpu]] Power down front end 0
> 05-10 17:18:46.732     0     0 D         :
> [drm:dcn10_plane_atomic_disable [amdgpu]] Power gated front end 1
> 05-10 17:18:46.732     0     0 D         : [drm:dcn10_init_pipes
> [amdgpu]] Power down front end 1
> 05-10 17:18:46.732     0     0 D         :
> [drm:dcn10_plane_atomic_disable [amdgpu]] Power gated front end 2
> 05-10 17:18:46.732     0     0 D         : [drm:dcn10_init_pipes
> [amdgpu]] Power down front end 2
> 05-10 17:18:46.733     0     0 D         :
> [drm:dcn10_plane_atomic_disable [amdgpu]] Power gated front end 3
> 05-10 17:18:46.733     0     0 D         : [drm:dcn10_init_pipes
> [amdgpu]] Power down front end 3
> 05-10 17:18:46.753     0     0 D         : [drm:drm_dp_dpcd_access]
> AMDGPU DM aux hw bus 0: Too many retries, giving up. First error: -5
> 05-10 17:18:46.759     0     0 D         : [drm:optc1_disable_crtc
> [amdgpu]] REG_WAIT taking a while: 1ms in optc1_disable_crtc line:544
> 05-10 17:18:46.761     0     0 D         :
> [drm:write_i2c_retimer_setting [amdgpu]] retimer write to
> slave_address = 0x5d,                           offset = 0xa, reg_val= 0x13, i2c_success = 0
> 05-10 17:18:46.761     0     0 D         :
> [drm:write_i2c_retimer_setting [amdgpu]] Set retimer failed
> 05-10 17:18:46.764     0     0 D         : [drm:mod_hdcp_add_display
> [amdgpu]] [Link 0] > HDCP_INITIALIZED
> 05-10 17:18:46.765     0     0 D         : [drm:dcn10_program_pipe
> [amdgpu]] Un-gated front end for pipe 0
> 05-10 17:18:46.765     0     0 D         : [drm:dc_commit_state
> [amdgpu]] {2560x1600, 2720x1641@267810Khz}
> 05-10 17:18:46.778     0     0 D         : [drm:dcn10_program_pipe
> [amdgpu]] Un-gated front end for pipe 0
> 05-10 17:18:46.779     0     0 I Console : switching to colour frame
> buffer device 320x100
> 05-10 17:18:46.779     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.779     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.779     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.779     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.779     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.779     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.780     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.780     0     0 D         :
> [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> 05-10 17:18:46.780     0     0 D         : [drm:event_mall_stutter
> [amdgpu]] Allow idle optimizations (MALL): 0
> 05-10 17:18:46.780     0     0 D         : [drm:dcn10_program_pipe
> [amdgpu]] Un-gated front end for pipe 0
> 05-10 17:18:46.802     0     0 I amdgpu 0000: 0b:00.0: [drm] fb0:
> amdgpudrmfb frame buffer device
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> gfx uses VM inv eng 0 on hub 0
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> comp_1.0.0 uses VM inv eng 1 on hub 0
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> comp_1.1.0 uses VM inv eng 4 on hub 0
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> comp_1.2.0 uses VM inv eng 5 on hub 0
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> comp_1.3.0 uses VM inv eng 6 on hub 0
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> comp_1.0.1 uses VM inv eng 7 on hub 0
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> comp_1.1.1 uses VM inv eng 8 on hub 0
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> comp_1.2.1 uses VM inv eng 9 on hub 0
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> comp_1.3.1 uses VM inv eng 10 on hub 0
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> kiq_2.1.0 uses VM inv eng 11 on hub 0
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> sdma0 uses VM inv eng 0 on hub 1
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> vcn_dec uses VM inv eng 1 on hub 1
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> vcn_enc0 uses VM inv eng 4 on hub 1
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> vcn_enc1 uses VM inv eng 5 on hub 1
> 05-10 17:18:46.807     0     0 I amdgpu 0000: 0b:00.0: amdgpu: ring
> jpeg_dec uses VM inv eng 6 on hub 1
> 05-10 17:18:46.812     0     0 I         : [drm] Initialized amdgpu
> 3.41.0 20150101 for 0000:0b:00.0 on minor 0
> 05-10 17:18:46.831     0     0 I modprobe: /sbin/modprobe
> hdaudio:v1002AA01r00100700a01
> 05-10 17:18:46.832     0     0 I snd_hda_intel 0000: 0b:00.1: bound
> 0000:0b:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
> 05-10 17:18:46.833     0     0 D         :
> [drm:amdgpu_dm_audio_component_get_eld [amdgpu]] Get ELD : idx=0 ret=0
> en=0
> 05-10 17:18:46.833     0     0 D         :
> [drm:amdgpu_dm_audio_component_get_eld [amdgpu]] Get ELD : idx=1
> ret=28 en=1
> 05-10 17:18:46.833     0     0 D         :
> [drm:amdgpu_dm_audio_component_get_eld [amdgpu]] Get ELD : idx=2 ret=0
> en=0
>
> 2021-05-11 1:05 GMT+08:00, youling 257 <youling257@gmail.com>:
> > error dmesg,
> >
> > 05-10 16:59:27.004     0     0 I init    : Service 'bootanim' (pid
> > 1912) exited with status 0
> > 05-10 16:59:27.016  1684  1684 E hwc-drm-display-compositor: Commit
> > test failed for display 0, FIXME
> > 05-10 16:59:27.016  1684  1684 E hwc-drm-two: Failed to apply the
> > frame composition ret=-22
> > 05-10 16:59:27.016  1684  1684 E HWComposer: commit: present failed
> > for display 0: BadParameter (4)
> > 05-10 16:59:27.009     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
> > 05-10 16:59:27.009     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 105]
> > 05-10 16:59:27.009     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
> > 05-10 16:59:27.009     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 105]
> > 05-10 16:59:27.009     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 106]
> > 05-10 16:59:27.009     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 107]
> > 05-10 16:59:27.009     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 108]
> > 05-10 16:59:27.023  1684  1684 E hwc-drm-display-compositor: Commit
> > test failed for display 0, FIXME
> > 05-10 16:59:27.016     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
> > 05-10 16:59:27.016     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 105]
> > 05-10 16:59:27.023  1684  1684 E hwc-drm-two: Failed to apply the
> > frame composition ret=-22
> > 05-10 16:59:27.024  1684  1684 E HWComposer: commit: present failed
> > for display 0: BadParameter (4)
> > 05-10 16:59:27.040  1684  1684 E hwc-drm-display-compositor: Commit
> > test failed for display 0, FIXME
> > 05-10 16:59:27.040  1684  1684 E hwc-drm-two: Failed to apply the
> > frame composition ret=-22
> > 05-10 16:59:27.032     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
> > 05-10 16:59:27.032     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 105]
> > 05-10 16:59:27.032     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 106]
> > 05-10 16:59:27.032     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 107]
> > 05-10 16:59:27.032     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 108]
> > 05-10 16:59:27.033     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
> > 05-10 16:59:27.033     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 105]
> > 05-10 16:59:27.041  1684  1684 E HWComposer: commit: present failed
> > for display 0: BadParameter (4)
> > 05-10 16:59:27.049     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
> > 05-10 16:59:27.049     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 105]
> > 05-10 16:59:27.049     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 106]
> > 05-10 16:59:27.049     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 107]
> > 05-10 16:59:27.049     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 108]
> >
> > normal dmesg,
> > 5-10 17:00:51.837     0     0 I init    : Service 'bootanim' (pid
> > 1922) exited with status 0
> > 05-10 17:00:51.850     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 104]
> > 05-10 17:00:51.850     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 105]
> > 05-10 17:00:51.857     0     0 D         : [drm:dcn10_program_pipe
> > [amdgpu]] Un-gated front end for pipe 0
> > 05-10 17:00:51.858     0     0 D         : [drm:dcn10_program_pipe
> > [amdgpu]] Un-gated front end for pipe 3
> > 05-10 17:00:51.876     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
> > 05-10 17:00:51.876     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 106]
> >
> > 2021-05-11 0:50 GMT+08:00, Mark Yacoub <markyacoub@chromium.org>:
> >> A userspace problem was due to the modifier used when you're creating
> >> a buffer but this check renders it as invalid modifier.
> >> Review patch 1 of this series and it will give you a good idea of a
> >> userspace bug that was caught using the check in this patch and fixed
> >> now.
> >> An easy way to figure out what exactly went wrong so to debug the
> >> kernel code and check which check returns false for the modifier
> >> check. That will tell you exactly what you are missing wrt the
> >> modifier.
> >>
> >> On Mon, May 10, 2021 at 12:45 PM youling 257 <youling257@gmail.com>
> >> wrote:
> >>>
> >>> I use androidx86 nougat on amdgpu, these porting to androidx86 nougat.
> >>> https://github.com/youling257/mesa
> >>> https://github.com/youling257/llvm
> >>> https://github.com/youling257/minigbm
> >>> https://github.com/youling257/drm_hwcomposer
> >>>
> >>> 2021-05-11 0:32 GMT+08:00, youling 257 <youling257@gmail.com>:
> >>> > what userspace problem?
> >>> >
> >>> > 05-10 16:23:35.438  1686  1686 I SurfaceFlinger: OpenGL ES
> >>> > informations: format=0x1
> >>> > 05-10 16:23:35.438  1686  1686 I SurfaceFlinger: vendor    : AMD
> >>> > 05-10 16:23:35.438  1686  1686 I SurfaceFlinger: renderer  : AMD
> >>> > Radeon(TM) Vega 11 Graphics (RAVEN, DRM 3.41.0,
> >>> > 5.13.0-rc1-android-x86_64+, LLVM 12.0)
> >>> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: version   : OpenGL ES
> >>> > 3.2 Mesa 21.1.0 (git-1a53901057)
> >>> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: extensions:
> >>> > GL_EXT_debug_marker GL_EXT_blend_minmax GL_EXT_multi_draw_arrays
> >>> > GL_EXT_texture_filter_anisotropic GL_EXT_texture_compression_s3tc
> >>> > GL_EXT_texture_compression_dxt1 GL_EXT_texture_compression_rgtc
> >>> > GL_EXT_texture_format_BGRA8888 GL_OES_compressed_ETC1_RGB8_texture
> >>> > GL_OES_depth24 GL_OES_element_index_uint GL_OES_fbo_render_mipmap
> >>> > GL_OES_mapbuffer GL_OES_rgb8_rgba8 GL_OES_standard_derivatives
> >>> > GL_OES_stencil8 GL_OES_texture_3D GL_OES_texture_float
> >>> > GL_OES_texture_float_linear GL_OES_texture_half_float
> >>> > GL_OES_texture_half_float_linear GL_OES_texture_npot
> >>> > GL_OES_vertex_half_float GL_EXT_draw_instanced
> >>> > GL_EXT_texture_sRGB_decode GL_OES_EGL_image GL_OES_depth_texture
> >>> > GL_AMD_performance_monitor GL_OES_packed_depth_stencil
> >>> > GL_EXT_texture_type_2_10_10_10_REV GL_NV_conditional_render
> >>> > GL_OES_get_program_binary GL_APPLE_texture_max_level
> >>> > GL_EXT_discard_framebuffer GL_EXT_read_format_bgra GL_EXT_frag_depth
> >>> > GL_NV_fbo_color_attachments GL_OES_EGL_image_external GL_OES_EGL_sync
> >>> > GL_OES_vertex_array_object GL_OES_viewp
> >>> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: GL_MAX_TEXTURE_SIZE =
> >>> > 16384
> >>> > 05-10 16:23:35.439  1686  1686 I SurfaceFlinger: GL_MAX_VIEWPORT_DIMS
> >>> > =
> >>> > 16384
> >>> > 05-10 16:23:35.488     0     0 D
> >>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> >>> > [CONNECTOR: 78:DP-1]
> >>> > 05-10 16:23:35.488     0     0 D
> >>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> >>> > [CONNECTOR: 78:DP-1] disconnected
> >>> > 05-10 16:23:35.488     0     0 D
> >>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> >>> > [CONNECTOR: 85:HDMI-A-1]
> >>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_edid_modes
> >>> > [drm]] ELD monitor HDMI
> >>> > 05-10 16:23:35.488     0     0 D [drm:drm_add_edid_modes [drm]] HDMI:
> >>> > latency present 0 0, video latency 0 0, audio latency 0 0
> >>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_edid_modes
> >>> > [drm]] ELD size 28, SAD count 1
> >>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
> >>> > [drm]] Supported Monitor Refresh rate range is 48 Hz - 75 Hz
> >>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
> >>> > [drm]] non_desktop set to 0
> >>> > 05-10 16:23:35.488     0     0 D [drm:drm_add_display_info [drm]]
> >>> > HDMI: DVI dual 0, max TMDS clock 320000 kHz
> >>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
> >>> > [drm]] hdmi_21 sink detected. parsing edid
> >>> > 05-10 16:23:35.488     0     0 D         : [drm:drm_add_display_info
> >>> > [drm]] CEA VCDB 0xff
> >>> > 05-10 16:23:35.488     0     0 D         :
> >>> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
> >>> > supported
> >>> > 05-10 16:23:35.489     0     0 D         :
> >>> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
> >>> > supported
> >>> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:2560  height:1600
> >>> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1200
> >>> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> >>> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> >>> > 05-10 16:23:35.489     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> >>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1920  height:1080
> >>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1600  height:1200
> >>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1680  height:1050
> >>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1400  height:1050
> >>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1600  height:900
> >>> > 05-10 16:23:35.490     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:1024
> >>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:1024
> >>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1440  height:900
> >>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:960
> >>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:800
> >>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
> >>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
> >>> > 05-10 16:23:35.491     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1280  height:720
> >>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
> >>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
> >>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:1024  height:768
> >>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:800  height:600
> >>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:800  height:600
> >>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
> >>> > 05-10 16:23:35.492     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
> >>> > 05-10 16:23:35.493     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:640  height:480
> >>> > 05-10 16:23:35.493     0     0 D         : [drm:create_stream_for_sink
> >>> > [amdgpu]] Destination Rectangle x:0  y:0  width:720  height:400
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 60
> >>> > 74250 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> >>> > 05-10 16:23:35.493     0     0 D         : [drm:drm_mode_prune_invalid
> >>> > [drm]] Not using 1920x1080i mode: NO_INTERLACE
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080i": 60
> >>> > 74176 1920 2008 2052 2200 1080 1084 1094 1125 0x40 0x15
> >>> > 05-10 16:23:35.493     0     0 D         : [drm:drm_mode_prune_invalid
> >>> > [drm]] Not using 1920x1080i mode: NO_INTERLACE
> >>> > 05-10 16:23:35.493     0     0 D
> >>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> >>> > [CONNECTOR: 85:HDMI-A-1] probed modes :
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "2560x1600": 60
> >>> > 267810 2560 2608 2640 2720 1600 1603 1608 1641 0x68 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1200": 60
> >>> > 267810 1920 2608 2640 2720 1200 1603 1608 1641 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60
> >>> > 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0xa
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60
> >>> > 148500 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 60
> >>> > 148352 1920 2008 2052 2200 1080 1084 1089 1125 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1920x1080": 50
> >>> > 148500 1920 2448 2492 2640 1080 1084 1089 1125 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1600x1200": 60
> >>> > 267810 1600 2608 2640 2720 1200 1603 1608 1641 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1680x1050": 60
> >>> > 119000 1680 1728 1760 1840 1050 1053 1059 1080 0x40 0x9
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1400x1050": 60
> >>> > 101000 1400 1448 1480 1560 1050 1053 1057 1080 0x40 0x9
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1600x900": 60
> >>> > 108000 1600 1624 1704 1800 900 901 904 1000 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1024": 75
> >>> > 135000 1280 1296 1440 1688 1024 1025 1028 1066 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x1024": 60
> >>> > 108000 1280 1328 1440 1688 1024 1025 1028 1066 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1440x900": 60 88750
> >>> > 1440 1488 1520 1600 900 903 909 926 0x40 0x9
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x960": 60
> >>> > 108000 1280 1376 1488 1800 960 961 964 1000 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x800": 60
> >>> > 267810 1280 2608 2640 2720 800 1603 1608 1641 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74250
> >>> > 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74250
> >>> > 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1280x720": 60 74176
> >>> > 1280 1390 1430 1650 720 725 730 750 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 75 78750
> >>> > 1024 1040 1136 1312 768 769 772 800 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 70 75000
> >>> > 1024 1048 1184 1328 768 771 777 806 0x40 0xa
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "1024x768": 60 65000
> >>> > 1024 1048 1184 1344 768 771 777 806 0x40 0xa
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 75 49500
> >>> > 800 816 896 1056 600 601 604 625 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "800x600": 60 40000
> >>> > 800 840 968 1056 600 601 605 628 0x40 0x5
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 75 31500
> >>> > 640 656 720 840 480 481 484 500 0x40 0xa
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25200
> >>> > 640 656 752 800 480 490 492 525 0x40 0xa
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "640x480": 60 25175
> >>> > 640 656 752 800 480 490 492 525 0x40 0xa
> >>> > 05-10 16:23:35.493     0     0 D         :
> >>> > [drm:drm_mode_debug_printmodeline [drm]] Modeline "720x400": 70 28320
> >>> > 720 738 846 900 400 412 414 449 0x40 0x6
> >>> > 05-10 16:23:35.493     0     0 D
> >>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> >>> > [CONNECTOR: 90:HDMI-A-2]
> >>> > 05-10 16:23:35.493     0     0 D
> >>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> >>> > [CONNECTOR: 90:HDMI-A-2] disconnected
> >>> > 05-10 16:23:35.494     0     0 D
> >>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> >>> > [CONNECTOR: 94:HDMI-A-3]
> >>> > 05-10 16:23:35.494     0     0 D
> >>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> >>> > [CONNECTOR: 94:HDMI-A-3] disconnected
> >>> >
> >>> > 05-10 16:23:35.502     0     0 D
> >>> > [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]]
> >>> > [CONNECTOR: 85:HDMI-A-1]
> >>> > 05-10 16:23:35.502     0     0 D         : [drm:drm_add_edid_modes
> >>> > [drm]] ELD monitor HDMI
> >>> > 05-10 16:23:35.502     0     0 D [drm:drm_add_edid_modes [drm]] HDMI:
> >>> > latency present 0 0, video latency 0 0, audio latency 0 0
> >>> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_edid_modes
> >>> > [drm]] ELD size 28, SAD count 1
> >>> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
> >>> > [drm]] Supported Monitor Refresh rate range is 48 Hz - 75 Hz
> >>> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
> >>> > [drm]] non_desktop set to 0
> >>> > 05-10 16:23:35.503     0     0 D [drm:drm_add_display_info [drm]]
> >>> > HDMI: DVI dual 0, max TMDS clock 320000 kHz
> >>> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
> >>> > [drm]] hdmi_21 sink detected. parsing edid
> >>> > 05-10 16:23:35.503     0     0 D         : [drm:drm_add_display_info
> >>> > [drm]] CEA VCDB 0xff
> >>> > 05-10 16:23:35.503     0     0 D         :
> >>> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
> >>> > supported
> >>> > 05-10 16:23:35.503     0     0 D         :
> >>> > [drm:drm_for_each_detailed_block.part.0 [drm]] stereo mode not
> >>> > supported
> >>> >
> >>> > 05-10 16:23:35.797  1920  2001 I EGL-MAIN: found extension DRI_Core
> >>> > version
> >>> > 2
> >>> > 05-10 16:23:35.797  1920  2001 I EGL-MAIN: found extension
> >>> > DRI_IMAGE_DRIVER version 1
> >>> > 05-10 16:23:35.798  1920  2001 I EGL-MAIN: found extension
> >>> > DRI_ConfigOptions version 2
> >>> > 05-10 16:23:35.798  1920  2001 D libdrm  :
> >>> > /vendor/etc/hwdata/amdgpu.ids version: 1.0.0
> >>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
> >>> > DRI_TexBuffer version 2
> >>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI2_Flush
> >>> > version 4
> >>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI_IMAGE
> >>> > version
> >>> > 18
> >>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
> >>> > DRI_RENDERER_QUERY version 1
> >>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
> >>> > DRI_CONFIG_QUERY version 2
> >>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI2_Fence
> >>> > version 2
> >>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension
> >>> > DRI2_Interop version 1
> >>> > 05-10 16:23:35.802  1920  2001 I EGL-MAIN: found extension DRI_NoError
> >>> > version 1
> >>> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension DRI2_Blob
> >>> > version
> >>> > 1
> >>> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension DRI_IMAGE
> >>> > version
> >>> > 18
> >>> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension
> >>> > DRI2_BufferDamage version 1
> >>> > 05-10 16:23:35.803  1920  2001 I EGL-MAIN: found extension
> >>> > DRI_Robustness version 1
> >>> > 05-10 16:23:35.875     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 104]
> >>> > 05-10 16:23:35.875     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 104]
> >>> > 05-10 16:23:35.875     0     0 D         :
> >>> > [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> >>> > 05-10 16:23:35.876     0     0 D         : [drm:dcn10_program_pipe
> >>> > [amdgpu]] Un-gated front end for pipe 0
> >>> > 05-10 16:23:35.891     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
> >>> > 05-10 16:23:35.892     0     0 D [drm:drm_mode_addfb2 [drm]] [FB: 102]
> >>> > 05-10 16:23:35.892     0     0 D         :
> >>> > [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB bound
> >>> > 05-10 16:23:35.893     0     0 D         : [drm:dcn10_program_pipe
> >>> > [amdgpu]] Un-gated front end for pipe 0
> >>> >
> >>> > 2021-05-10 23:18 GMT+08:00, Mark Yacoub <markyacoub@chromium.org>:
> >>> >> Like the previous time it was reverted, there is a chance it's a user
> >>> >> space bug that's not passing the correct modifier.
> >>> >> Are you able to check what exactly returns false in the code above.
> >>> >> This will give you the greatest hint on what the userspace is missing
> >>> >> and needs to be fixed there.
> >>> >>
> >>> >> On Sun, May 9, 2021 at 10:09 PM youling 257 <youling257@gmail.com>
> >>> >> wrote:
> >>> >>>
> >>> >>> Revert "Revert "drm/amdgpu: Ensure that the modifier requested is
> >>> >>> supported by plane."" is first bad commt.
> >>> >>> "drm/amd/display: Fix two cursor duplication when using overlay" is
> >>> >>> second bad commit.
> >>> >>> they cause same problem, look the video.
> >>> >>> i have to revert two patch for my androidx86 run on amdgpu.
> >>> >>>
> >>> >>> 2021-05-10 5:42 GMT+08:00, youling 257 <youling257@gmail.com>:
> >>> >>> > error dmesg
> >>> >>> >
> >>> >>> > [  115.977746] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB
> >>> >>> > bound
> >>> >>> > [  115.980406] [drm:dcn10_program_pipe [amdgpu]] Un-gated front
> >>> >>> > end
> >>> >>> > for
> >>> >>> > pipe
> >>> >>> > 0
> >>> >>> > [  115.993656] [drm:drm_mode_addfb2 [drm]] [FB:104]
> >>> >>> > [  115.993694] [drm:drm_mode_addfb2 [drm]] [FB:105]
> >>> >>> > [  115.993722] [drm:drm_mode_addfb2 [drm]] [FB:106]
> >>> >>> > [  115.993750] [drm:drm_mode_addfb2 [drm]] [FB:107]
> >>> >>> > [  115.993777] [drm:drm_mode_addfb2 [drm]] [FB:108]
> >>> >>> > [  115.994215] [drm:drm_mode_addfb2 [drm]] [FB:104]
> >>> >>> > [  115.994371] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB
> >>> >>> > bound
> >>> >>> > [  115.997095] [drm:dcn10_program_pipe [amdgpu]] Un-gated front
> >>> >>> > end
> >>> >>> > for
> >>> >>> > pipe
> >>> >>> > 0
> >>> >>> > [  116.010298] [drm:drm_mode_addfb2 [drm]] [FB:102]
> >>> >>> > [  116.010337] [drm:drm_mode_addfb2 [drm]] [FB:105]
> >>> >>> > [  116.010366] [drm:drm_mode_addfb2 [drm]] [FB:106]
> >>> >>> > [  116.010394] [drm:drm_mode_addfb2 [drm]] [FB:107]
> >>> >>> > [  116.010422] [drm:drm_mode_addfb2 [drm]] [FB:108]
> >>> >>> > [  116.010853] [drm:drm_mode_addfb2 [drm]] [FB:102]
> >>> >>> > [  116.011018] [drm:dm_plane_helper_prepare_fb [amdgpu]] No FB
> >>> >>> > bound
> >>> >>> > [  116.013694] [drm:dcn10_program_pipe [amdgpu]] Un-gated front
> >>> >>> > end
> >>> >>> > for
> >>> >>> > pipe
> >>> >>> > 0
> >>> >>> >
> >>> >>> >
> >>> >>> > normal dmesg
> >>> >>> >  3464.827004] [drm:drm_mode_addfb2 [drm]] [FB:105]
> >>> >>> > [ 3464.833405] [drm:dcn10_program_pipe [amdgpu]] Un-gated front
> >>> >>> > end
> >>> >>> > for
> >>> >>> > pipe
> >>> >>> > 0
> >>> >>> > [ 3464.833981] [drm:dcn10_program_pipe [amdgpu]] Un-gated front
> >>> >>> > end
> >>> >>> > for
> >>> >>> > pipe
> >>> >>> > 3
> >>> >>> > [ 3464.842396] [drm:drm_mode_addfb2 [drm]] [FB:104]
> >>> >>> > [ 3464.842476] [drm:drm_mode_addfb2 [drm]] [FB:106]
> >>> >>> > [ 3464.842550] [drm:drm_mode_addfb2 [drm]] [FB:107]
> >>> >>> > [ 3464.842615] [drm:drm_mode_addfb2 [drm]] [FB:108]
> >>> >>> > [ 3464.842679] [drm:drm_mode_addfb2 [drm]] [FB:109]
> >>> >>> > [ 3464.842741] [drm:drm_mode_addfb2 [drm]] [FB:110]
> >>> >>> > [ 3464.843748] [drm:drm_mode_addfb2 [drm]] [FB:104]
> >>> >>> > [ 3464.843821] [drm:drm_mode_addfb2 [drm]] [FB:106]
> >>> >>> > [ 3464.850026] [drm:dcn10_program_pipe [amdgpu]] Un-gated front
> >>> >>> > end
> >>> >>> > for
> >>> >>> > pipe
> >>> >>> > 0
> >>> >>> > [ 3464.850378] [drm:dcn10_program_pipe [amdgpu]] Un-gated front
> >>> >>> > end
> >>> >>> > for
> >>> >>> > pipe
> >>> >>> > 3
> >>> >>> > [ 3464.858841] [drm:drm_mode_addfb2 [drm]] [FB:102]
> >>> >>> > [ 3464.858878] [drm:drm_mode_addfb2 [drm]] [FB:105]
> >>> >>> > [ 3464.858906] [drm:drm_mode_addfb2 [drm]] [FB:107]
> >>> >>> > [ 3464.858933] [drm:drm_mode_addfb2 [drm]] [FB:108]
> >>> >>> > [ 3464.858960] [drm:drm_mode_addfb2 [drm]] [FB:109]
> >>> >>> > [ 3464.858987] [drm:drm_mode_addfb2 [drm]] [FB:110]
> >>> >>> > [ 3464.859609] [drm:drm_mode_addfb2 [drm]] [FB:102]
> >>> >>> > [ 3464.859641] [drm:drm_mode_addfb2 [drm]] [FB:105]
> >>> >>> > [ 3464.866353] [drm:dcn10_program_pipe [amdgpu]] Un-gated front
> >>> >>> > end
> >>> >>> > for
> >>> >>> > pipe
> >>> >>> > 0
> >>> >>> > [ 3464.866653] [drm:dcn10_program_pipe [amdgpu]] Un-gated front
> >>> >>> > end
> >>> >>> > for
> >>> >>> > pipe
> >>> >>> > 3
> >>> >>> >
> >>> >>> > 2021-05-10 4:57 GMT+08:00, Bas Nieuwenhuizen
> >>> >>> > <bas@basnieuwenhuizen.nl>:
> >>> >>> >> It would be very helpful if you could enable drm.debug=0x4 and
> >>> >>> >> then
> >>> >>> >> take the dmesg to figure out what modifier was rejected
> >>> >>> >>
> >>> >>> >> On Sun, May 9, 2021 at 10:51 PM youling 257
> >>> >>> >> <youling257@gmail.com>
> >>> >>> >> wrote:
> >>> >>> >>>
> >>> >>> >>> look this video,
> >>> >>> >>> https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing
> >>> >>> >>>
> >>> >>> >>> 2021-05-09 23:52 GMT+08:00, Alex Deucher
> >>> >>> >>> <alexdeucher@gmail.com>:
> >>> >>> >>> > On Sun, May 9, 2021 at 11:42 AM youling257
> >>> >>> >>> > <youling257@gmail.com>
> >>> >>> >>> > wrote:
> >>> >>> >>> >>
> >>> >>> >>> >> I using amd 3400g running with android-x86, this patch is a
> >>> >>> >>> >> bad
> >>> >>> >>> >> commit
> >>> >>> >>> >> when i use android-x86 on amdgpu.
> >>> >>> >>> >
> >>> >>> >>> > Can you provide more details?  What sort of problem are you
> >>> >>> >>> > seeing?
> >>> >>> >>> > Please provide your dmesg output.
> >>> >>> >>> >
> >>> >>> >>> > Alex
> >>> >>> >>> >
> >>> >>> >>> >
> >>> >>> >>> >> _______________________________________________
> >>> >>> >>> >> amd-gfx mailing list
> >>> >>> >>> >> amd-gfx@lists.freedesktop.org
> >>> >>> >>> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>> >>> >>> >
> >>> >>> >>
> >>> >>> >
> >>> >>
> >>> >
> >>
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
