Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F13FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 21:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A67010E701;
	Thu, 27 Oct 2022 21:53:51 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3677310E6B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 17:46:52 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id z14so3478391wrn.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VP61fLFjA5LsMsXAfCQvd1k28lduk9sBFeorZEG+mu0=;
 b=pgbwJulEXuXIQ50hAUVT9G6L6hOa9K+Y3yye8/ahQe2ivm/pSl7NZDiCIPfwAmGr2s
 POBvZSapa6+cPdqbRqiC+ZedgBkKxOs1nvuiSs60xIqCc+mRfe0my3kL1YacG/gk/6Mk
 Y12j8tnFzYADa2Ctr8QfxThjL2QlidbU857BSDcVP3PD3IUuixSYrlkp0Y2HFVaYqsfs
 XixfIIDW9aUTcFN7+A6JlIONeizzYEPc0C3gqIxqaN97qC2PBYRSZZydSKTRpfQszazF
 TDZZOuWy/eGuv3vA2rUkr+v1g4QQEujaoUMUMf3NR3EeNY6OogZASkRbwPKX+Bxb5vtF
 LtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VP61fLFjA5LsMsXAfCQvd1k28lduk9sBFeorZEG+mu0=;
 b=X0ixzFIrQ8m1aDPyT5dNo8RtSAPcnI+fbx0rSy6yGYuOdSua93nYiarsck/wKMaHpN
 f9JqSnRjTiOwbvx8j2dDnnPqvqzGdn5bvO3U7TCYRGVqnGvcmHDFdzKIlOAWlSLeregJ
 ofKGsSSTyj0SZGX/EIDG56+qDt7UXqVJ2Ces530/2jh0UuLupeo3Gd1UZTq4Z+9BP9on
 3EZvNktjNe8MsPT+4XIe29Ulf+HAOMGT+EbblBY1lRHqRKm4cXjwCKnZEf7OpE+vJVdt
 JRmq1vl5qduZtf0IWCDcfDhfIRWxHE6kgrGf3IGq9bCqWzOTVoKDBTEzvDVerUk2nNjI
 bsIQ==
X-Gm-Message-State: ACrzQf2HcIfw0ceP7VW4LTNlcd2RTY50Q7aqWD8e3m7UXbyF5O35qU8h
 y/7p02OkL8/v7hvu03JzgWw=
X-Google-Smtp-Source: AMsMyM5LNb3K4CHc6WHjeGfX5fxVU7bSRwL/G4yYPgazVruoW4u8kiD5Y9a+UfoTw/cJ0/gs7iQEWg==
X-Received: by 2002:a5d:5a8c:0:b0:22c:bc97:6fe2 with SMTP id
 bp12-20020a5d5a8c000000b0022cbc976fe2mr32125837wrb.640.1666892810439; 
 Thu, 27 Oct 2022 10:46:50 -0700 (PDT)
Received: from ?IPV6:2a02:908:4f6:d280::9a6? ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a05600c355100b003a8434530bbsm5785907wmq.13.2022.10.27.10.46.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Oct 2022 10:46:50 -0700 (PDT)
Message-ID: <aa4726b3-1efa-2d3d-db5b-5a09f8a83cde@gmail.com>
Date: Thu, 27 Oct 2022 19:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann
 <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
 <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
From: Ao Zhong <hacc1225@gmail.com>
In-Reply-To: <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Oct 2022 21:53:48 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 linux-arm-kernel@lists.infradead.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Here are some lshw information:

hacc-arm64-pc
    description: Desktop Computer
    product: HUAWEIPGU-WBY0 (C233)
    vendor: HUAWEI
    version: D1060
    serial:
    width: 64 bits
    capabilities: smbios-3.2.0 dmi-3.2.0 smp cp15_barrier setend swp tagged_addr_disabled
    configuration: chassis=desktop family=HUAWEI sku=C233 uuid=
  *-core
       description: Motherboard
       product: HUAWEIPGU-WBY0-PCB
       vendor: HUAWEI
       physical id: 0
       version: D1060
       serial:
       slot: Null
     *-firmware
          description: BIOS
          vendor: Byosoft
          physical id: 2
          version: 1.11
          date: 02/07/2020
          size: 128KiB
          capabilities: pci pnp upgrade cdboot bootselect edd acpi biosbootspecification uefi
     *-cache:0
          description: L1 cache
          physical id: 5
          slot: L1 Instruction Cache
          size: 1536KiB
          capacity: 1536KiB
          capabilities: synchronous internal write-back instruction
          configuration: level=1
     *-cache:1
          description: L1 cache
          physical id: 6
          slot: L1 Data Cache
          size: 1536KiB
          capacity: 1536KiB
          capabilities: synchronous internal write-back data
          configuration: level=1
     *-cache:2
          description: L2 cache
          physical id: 7
          slot: L2 Cache
          size: 12MiB
          capacity: 12MiB
          capabilities: synchronous internal varies unified
          configuration: level=2
     *-cache:3
          description: L3 cache
          physical id: 8
          slot: L3 Cache
          size: 24MiB
          capacity: 24MiB
          capabilities: synchronous internal varies unified
          configuration: level=3
     *-cpu
          description: CPU
          product: ARM (NULL)
          vendor: HISILICON
          physical id: 9
          bus info: cpu@0
          version: HUAWEI Kunpeng920 3211K
          serial: NULL
          slot: CPU0
          size: 2600MHz
          capacity: 2600MHz
          clock: 100MHz
          capabilities: lm
          configuration: cores=24 enabledcores=24 threads=24
     *-memory
          description: System Memory
          physical id: a
          slot: System board or motherboard
          size: 64GiB
        *-bank:0
             description: DIMM DDR4 Synchronous 3200 MHz (0,3 ns)
             product: F4-3200C22-32GRS
             vendor: Unknown
             physical id: 0
             serial:
             slot: SODIMM_B
             size: 32GiB
             width: 64 bits
             clock: 3200MHz (0.3ns)
        *-bank:1
             description: DIMM DDR4 Synchronous 3200 MHz (0,3 ns)
             product: F4-3200C22-32GRS
             vendor: Unknown
             physical id: 1
             serial:
             slot: SODIMM_A
             size: 32GiB
             width: 64 bits
             clock: 3200MHz (0.3ns)
     *-pci:0
          description: PCI bridge
          product: HiSilicon PCIe Root Port with Gen4
          vendor: Huawei Technologies Co., Ltd.
          physical id: 100
          bus info: pci@0000:00:00.0
          version: 21
          width: 32 bits
          clock: 33MHz
          capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:30 ioport:1000(size=4096) memory:e0c00000-e0efffff ioport:80080000000(size=6442450944)
        *-pci
             description: PCI bridge
             product: Navi 10 XL Upstream Port of PCI Express Switch
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 0
             bus info: pci@0000:01:00.0
             version: c7
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:29 memory:e0e00000-e0e03fff ioport:1000(size=4096) memory:e0c00000-e0dfffff ioport:80080000000(size=6442450944)
           *-pci
                description: PCI bridge
                product: Navi 10 XL Downstream Port of PCI Express Switch
                vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                physical id: 0
                bus info: pci@0000:02:00.0
                version: 00
                width: 32 bits
                clock: 33MHz
                capabilities: pci pm pciexpress msi normal_decode bus_master cap_list
                configuration: driver=pcieport
                resources: irq:37 ioport:1000(size=4096) memory:e0c00000-e0dfffff ioport:80080000000(size=6442450944)
              *-display
                   description: VGA compatible controller
                   product: Navi 24 [Radeon RX 6400 / 6500 XT]
                   vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                   physical id: 0
                   bus info: pci@0000:03:00.0
                   logical name: /dev/fb0
                   version: c7
                   width: 64 bits
                   clock: 33MHz
                   capabilities: pm pciexpress msi vga_controller bus_master cap_list rom fb
                   configuration: depth=32 driver=amdgpu latency=0 mode=3440x1440 resolution=3440,1440 visual=truecolor xres=3440 yres=1440
                   resources: iomemory:8010-800f iomemory:8000-7fff irq:250 memory:80100000000-801ffffffff memory:80080000000-800801fffff ioport:1000(size=256) memory:e0c00000-e0cfffff memory:e0d00000-e0d1ffff
              *-multimedia
                   description: Audio device
                   product: Navi 21/23 HDMI/DP Audio Controller
                   vendor: Advanced Micro Devices, Inc. [AMD/ATI]
                   physical id: 0.1
                   bus info: pci@0000:03:00.1
                   logical name: card0
                   logical name: /dev/snd/controlC0
                   logical name: /dev/snd/hwC0D0
                   logical name: /dev/snd/pcmC0D3p
                   logical name: /dev/snd/pcmC0D7p
                   version: 00
                   width: 32 bits
                   clock: 33MHz
                   capabilities: pm pciexpress msi bus_master cap_list
                   configuration: driver=snd_hda_intel latency=0
                   resources: irq:248 memory:e0d20000-e0d23fff
                 *-input:0
                      product: HDA ATI HDMI HDMI/DP,pcm=3
                      physical id: 0
                      logical name: input4
                      logical name: /dev/input/event4
                 *-input:1
                      product: HDA ATI HDMI HDMI/DP,pcm=7
                      physical id: 1
                      logical name: input5
                      logical name: /dev/input/event5
     *-pci:1
          description: PCI bridge
          product: HiSilicon PCIe Root Port with Gen4
          vendor: Huawei Technologies Co., Ltd.
          physical id: 101
          bus info: pci@0000:00:08.0
          version: 21
          width: 32 bits
          clock: 33MHz
          capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:31 ioport:2000(size=4096) memory:e0f00000-e10fffff ioport:80018000000(size=2097152)
        *-nvme
             description: NVMe device
             product: KINGSTON SNV2S1000G
             vendor: Kingston Technology Company, Inc.
             physical id: 0
             bus info: pci@0000:04:00.0
             logical name: /dev/nvme0
             version: SBI02102
             serial:
             width: 64 bits
             clock: 33MHz
             capabilities: nvme pm msi pciexpress msix nvm_express bus_master cap_list
             configuration: driver=nvme latency=0 nqn=nqn.2021-03.com.kingston:nvme:nvm-subsystem-sn- state=live
             resources: irq:29 memory:e0f00000-e0f03fff
           *-namespace:0
                description: NVMe disk
                physical id: 0
                logical name: hwmon1
           *-namespace:1
                description: NVMe disk
                physical id: 2
                logical name: /dev/ng0n1
           *-namespace:2
                description: NVMe disk
                physical id: 1
                bus info: nvme@0:1
                logical name: /dev/nvme0n1
                size: 931GiB (1TB)
                capabilities: gpt-1.00 partitioned partitioned:gpt
                configuration: guid= logicalsectorsize=512 sectorsize=512 wwid=eui.00000000000000000026b7784e21fbc5
              *-volume:0 UNCLAIMED
                   description: Windows FAT volume
                   vendor: mkfs.fat
                   physical id: 1
                   bus info: nvme@0:1,1
                   version: FAT32
                   serial:
                   size: 98MiB
                   capacity: 99MiB
                   capabilities: boot fat initialized
                   configuration: FATs=2 filesystem=fat
              *-volume:1
                   description: EFI partition
                   physical id: 2
                   bus info: nvme@0:1,2
                   logical name: /dev/nvme0n1p2
                   logical name: /
                   logical name: /home
                   serial:
                   capacity: 866GiB
                   configuration: mount.fstype=btrfs mount.options=rw,relatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=257,subvol=/@home state=mounted
              *-volume:2
                   description: EFI partition
                   physical id: 3
                   bus info: nvme@0:1,3
                   logical name: /dev/nvme0n1p3
                   logical name: /boot
                   serial:
                   capacity: 1023MiB
                   configuration: mount.fstype=xfs mount.options=rw,relatime,attr2,discard,inode64,logbufs=8,logbsize=32k,noquota state=mounted
              *-volume:3
                   description: Linux swap volume
                   vendor: Linux
                   physical id: 4
                   bus info: nvme@0:1,4
                   logical name: /dev/nvme0n1p4
                   version: 1
                   serial:
                   size: 64GiB
                   capacity: 64GiB
                   capabilities: nofs swap initialized
                   configuration: filesystem=swap pagesize=4096
     *-pci:2
          description: PCI bridge
          product: HiSilicon PCIe Root Port with Gen4
          vendor: Huawei Technologies Co., Ltd.
          physical id: 102
          bus info: pci@0000:00:0a.0
          version: 21
          width: 32 bits
          clock: 33MHz
          capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:32 ioport:3000(size=4096) memory:e1100000-e12fffff ioport:80018200000(size=2097152)
        *-nvme
             description: NVMe device
             product: KXG60ZNV512G TOSHIBA
             vendor: Toshiba Corporation
             physical id: 0
             bus info: pci@0000:05:00.0
             logical name: /dev/nvme1
             version: AGXA4103
             serial:
             width: 64 bits
             clock: 33MHz
             capabilities: nvme pciexpress pm msi msix nvm_express bus_master cap_list
             configuration: driver=nvme latency=0 nqn=nqn.2017-03.jp.co.toshiba:KXG60ZNV512G TOSHIBA: state=live
             resources: irq:29 memory:e1100000-e1103fff
           *-namespace:0
                description: NVMe disk
                physical id: 0
                logical name: hwmon0
           *-namespace:1
                description: NVMe disk
                physical id: 2
                logical name: /dev/ng1n1
           *-namespace:2
                description: NVMe disk
                physical id: 1
                bus info: nvme@1:1
                logical name: /dev/nvme1n1
                size: 476GiB (512GB)
                capabilities: gpt-1.00 partitioned partitioned:gpt
                configuration: guid= logicalsectorsize=512 sectorsize=512 wwid=eui.00000000000000018ce38e0300176ffe
              *-volume
                   description: EFI partition
                   physical id: 1
                   bus info: nvme@1:1,1
                   logical name: /dev/nvme1n1p1
                   logical name: /mnt/SSD2
                   serial:
                   capacity: 476GiB
                   configuration: mount.fstype=btrfs mount.options=rw,relatime,compress=zstd:1,ssd,discard=async,space_cache=v2,subvolid=5,subvol=/ state=mounted
     *-pci:3
          description: PCI bridge
          product: HiSilicon PCIe Root Port with Gen4
          vendor: Huawei Technologies Co., Ltd.
          physical id: c
          bus info: pci@0000:00:0c.0
          version: 21
          width: 32 bits
          clock: 33MHz
          capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:33 ioport:4000(size=4096) memory:e0000000-e0bfffff ioport:80018400000(size=2097152)
        *-network UNCLAIMED
             description: Network controller
             product: Huawei Technologies Co., Ltd.
             vendor: Huawei Technologies Co., Ltd.
             physical id: 0
             bus info: pci@0000:06:00.0
             version: 02
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi pciexpress cap_list
             configuration: latency=0
             resources: memory:e0000000-e07fffff memory:e0800000-e0803fff
     *-pci:4
          description: PCI bridge
          product: HiSilicon PCIe Root Port with Gen4
          vendor: Huawei Technologies Co., Ltd.
          physical id: d
          bus info: pci@0000:00:0d.0
          version: 21
          width: 32 bits
          clock: 33MHz
          capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:34 ioport:5000(size=4096) memory:e1300000-e14fffff ioport:80018600000(size=2097152)
        *-usb
             description: USB controller
             product: uPD720202 USB 3.0 Host Controller
             vendor: Renesas Technology Corp.
             physical id: 0
             bus info: pci@0000:07:00.0
             version: 02
             width: 64 bits
             clock: 33MHz
             capabilities: pm msi msix pciexpress xhci bus_master cap_list
             configuration: driver=xhci_hcd latency=0
             resources: irq:29 memory:e1300000-e1301fff
           *-usbhost:0
                product: xHCI Host Controller
                vendor: Linux 6.0.5-gentoo-arm64 xhci-hcd
                physical id: 0
                bus info: usb@2
                logical name: usb2
                version: 6.00
                capabilities: usb-2.00
                configuration: driver=hub slots=2 speed=480Mbit/s
              *-usb:0
                   description: USB hub
                   product: 4-Port USB 2.1 Hub
                   vendor: Generic
                   physical id: 1
                   bus info: usb@2:1
                   version: 1.01
                   capabilities: usb-2.10
                   configuration: driver=hub slots=4 speed=480Mbit/s
              *-usb:1 UNCLAIMED
                   description: Communication device
                   product: Goodix Fingerprint Device
                   vendor: Shenzhen Goodix Technology Co.,Ltd.
                   physical id: 2
                   bus info: usb@2:2
                   version: 2.00
                   capabilities: usb-2.00
                   configuration: maxpower=100mA speed=12Mbit/s
           *-usbhost:1
                product: xHCI Host Controller
                vendor: Linux 6.0.5-gentoo-arm64 xhci-hcd
                physical id: 1
                bus info: usb@3
                logical name: usb3
                version: 6.00
                capabilities: usb-3.00
                configuration: driver=hub slots=2 speed=5000Mbit/s
              *-usb
                   description: USB hub
                   product: 4-Port USB 3.1 Hub
                   vendor: Generic
                   physical id: 1
                   bus info: usb@3:1
                   version: 1.01
                   capabilities: usb-3.10
                   configuration: driver=hub slots=4 speed=5000Mbit/s
     *-pci:5
          description: PCI bridge
          product: HiSilicon PCIe Root Port with Gen4
          vendor: Huawei Technologies Co., Ltd.
          physical id: e
          bus info: pci@0000:00:0e.0
          version: 21
          width: 32 bits
          clock: 33MHz
          capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:35 ioport:6000(size=4096) memory:e1500000-e16fffff ioport:80018800000(size=2097152)
     *-pci:6
          description: PCI bridge
          product: HiSilicon PCIe Root Port with Gen4
          vendor: Huawei Technologies Co., Ltd.
          physical id: f
          bus info: pci@0000:00:0f.0
          version: 21
          width: 32 bits
          clock: 33MHz
          capabilities: pci pciexpress msi pm normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:36 ioport:7000(size=4096) memory:e1700000-e18fffff ioport:80018a00000(size=2097152)
     *-pci:7
          description: PCI bridge
          product: HiSilicon PCI-PCI Bridge
          vendor: Huawei Technologies Co., Ltd.
          physical id: 103
          bus info: pci@0000:74:00.0
          version: 20
          width: 64 bits
          clock: 33MHz
          capabilities: pci pciexpress pm normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: iomemory:1010-100f irq:0
     *-pci:8
          description: PCI bridge
          product: HiSilicon PCI-PCI Bridge
          vendor: Huawei Technologies Co., Ltd.
          physical id: 104
          bus info: pci@0000:74:01.0
          version: 20
          width: 64 bits
          clock: 33MHz
          capabilities: pci pciexpress pm normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: iomemory:1010-100f irq:0 ioport:141000000(size=8388608)
        *-generic UNCLAIMED
             description: Unassigned class
             product: SafeNet (wrong ID)
             vendor: SafeNet (wrong ID)
             physical id: 0
             bus info: pci@0000:76:00.0
             version: ff
             width: 32 bits
             clock: 66MHz
             capabilities: bus_master vga_palette cap_list
             configuration: latency=255 maxlatency=255 mingnt=255
             resources: memory:141000000-1413fffff memory:141400000-1417effff
     *-sas:0 UNCLAIMED
          description: Serial Attached SCSI controller
          product: HiSilicon SAS 3.0 HBA
          vendor: Huawei Technologies Co., Ltd.
          physical id: b
          bus info: pci@0000:74:02.0
          version: 21
          width: 32 bits
          clock: 33MHz
          capabilities: sas pciexpress msi pm cap_list
          configuration: latency=0
          resources: memory:a2000000-a2007fff
     *-sata
          description: SATA controller
          product: HiSilicon AHCI HBA
          vendor: Huawei Technologies Co., Ltd.
          physical id: 3
          bus info: pci@0000:74:03.0
          version: 21
          width: 32 bits
          clock: 33MHz
          capabilities: sata pciexpress msi pm ahci_1.0 bus_master cap_list
          configuration: driver=ahci latency=0
          resources: irq:235 memory:a2010000-a2010fff
     *-sas:1 UNCLAIMED
          description: Serial Attached SCSI controller
          product: HiSilicon SAS 3.0 HBA
          vendor: Huawei Technologies Co., Ltd.
          physical id: 4
          bus info: pci@0000:74:04.0
          version: 21
          width: 32 bits
          clock: 33MHz
          capabilities: sas pciexpress msi pm cap_list
          configuration: latency=0
          resources: memory:a2008000-a200ffff
     *-pci:9
          description: PCI bridge
          product: HiSilicon PCI-PCI Bridge
          vendor: Huawei Technologies Co., Ltd.
          physical id: 105
          bus info: pci@0000:78:00.0
          version: 20
          width: 32 bits
          clock: 33MHz
          capabilities: pci pciexpress pm normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: irq:0
     *-raid UNCLAIMED
          description: RAID bus controller
          product: HiSilicon RDE Engine
          vendor: Huawei Technologies Co., Ltd.
          physical id: 10
          bus info: pci@0000:78:01.0
          version: 21
          width: 64 bits
          clock: 33MHz
          capabilities: raid pciexpress msi pm cap_list
          configuration: latency=0
          resources: iomemory:20-1f memory:208000000-2083fffff
     *-usb:0
          description: USB controller
          product: HiSilicon USB 1.1 Host Controller
          vendor: Huawei Technologies Co., Ltd.
          physical id: 11
          bus info: pci@0000:7a:00.0
          version: 21
          width: 64 bits
          clock: 33MHz
          capabilities: pciexpress msi pm ohci bus_master cap_list
          configuration: driver=ohci-pci latency=0
          resources: iomemory:20-1f irq:249 memory:20c100000-20c100fff
        *-usbhost
             product: OHCI PCI host controller
             vendor: Linux 6.0.5-gentoo-arm64 ohci_hcd
             physical id: 1
             bus info: usb@6
             logical name: usb6
             version: 6.00
             capabilities: usb-1.10
             configuration: driver=hub slots=2 speed=12Mbit/s
     *-usb:1
          description: USB controller
          product: HiSilicon USB 2.0 2-port Host Controller
          vendor: Huawei Technologies Co., Ltd.
          physical id: 1
          bus info: pci@0000:7a:01.0
          version: 21
          width: 64 bits
          clock: 33MHz
          capabilities: pciexpress msi pm ehci bus_master cap_list
          configuration: driver=ehci-pci latency=0
          resources: iomemory:20-1f irq:237 memory:20c101000-20c101fff
        *-usbhost
             product: EHCI Host Controller
             vendor: Linux 6.0.5-gentoo-arm64 ehci_hcd
             physical id: 1
             bus info: usb@1
             logical name: usb1
             version: 6.00
             capabilities: usb-2.00
             configuration: driver=hub slots=2 speed=480Mbit/s
           *-usb
                description: Audio device
                product: Generic USB Audio
                vendor: Generic
                physical id: 1
                bus info: usb@1:1
                logical name: card1
                logical name: /dev/snd/controlC1
                logical name: /dev/snd/pcmC1D0c
                logical name: /dev/snd/pcmC1D0p
                logical name: /dev/snd/pcmC1D1c
                logical name: /dev/snd/pcmC1D1p
                logical name: /dev/snd/pcmC1D2c
                logical name: /dev/snd/pcmC1D2p
                logical name: input1
                logical name: /dev/input/event1
                version: 0.13
                capabilities: usb-2.00 audio-control usb
                configuration: driver=usbhid maxpower=100mA speed=480Mbit/s
     *-usb:2
          description: USB controller
          product: HiSilicon USB 3.0 Host Controller
          vendor: Huawei Technologies Co., Ltd.
          physical id: 12
          bus info: pci@0000:7a:02.0
          version: 21
          width: 64 bits
          clock: 33MHz
          capabilities: pciexpress msi pm xhci bus_master cap_list
          configuration: driver=xhci_hcd latency=0
          resources: iomemory:20-1f irq:246 memory:20c000000-20c0fffff
        *-usbhost:0
             product: xHCI Host Controller
             vendor: Linux 6.0.5-gentoo-arm64 xhci-hcd
             physical id: 0
             bus info: usb@4
             logical name: usb4
             version: 6.00
             capabilities: usb-2.00
             configuration: driver=hub slots=1 speed=480Mbit/s
           *-usb
                description: USB hub
                product: 4-Port USB 2.1 Hub
                vendor: Generic
                physical id: 1
                bus info: usb@4:1
                version: 1.01
                capabilities: usb-2.10
                configuration: driver=hub slots=4 speed=480Mbit/s
              *-usb:0
                   description: USB hub
                   product: USB2.1 Hub
                   vendor: GenesysLogic
                   physical id: 1
                   bus info: usb@4:1.1
                   version: 6.63
                   capabilities: usb-2.10
                   configuration: driver=hub maxpower=100mA slots=4 speed=480Mbit/s
                 *-usb:0
                      description: Bluetooth wireless interface
                      product: Bluetooth Radio
                      vendor: Realtek
                      physical id: 1
                      bus info: usb@4:1.1.1
                      version: 2.00
                      serial:
                      capabilities: bluetooth usb-1.10
                      configuration: driver=btusb maxpower=500mA speed=12Mbit/s
                 *-usb:1
                      description: Bluetooth wireless interface
                      product: Bluetooth Radio
                      vendor: Realtek
                      physical id: 2
                      bus info: usb@4:1.1.2
                      version: 2.00
                      serial:
                      capabilities: bluetooth usb-1.10
                      configuration: driver=btusb maxpower=500mA speed=12Mbit/s
                 *-usb:2
                      description: Video
                      product: FHD Camera Microphone: FHD Came
                      vendor: SunplusIT Inc
                      physical id: 3
                      bus info: usb@4:1.1.3
                      logical name: card3
                      logical name: /dev/snd/controlC3
                      logical name: /dev/snd/pcmC3D0c
                      logical name: input6
                      logical name: /dev/input/event6
                      version: 10.14
                      serial: 01.00.00
                      capabilities: usb-2.00 usb
                      configuration: driver=snd-usb-audio maxpower=500mA speed=480Mbit/s
                 *-usb:3
                      description: USB hub
                      product: HighSpeed Hub
                      vendor: NEC Corp.
                      physical id: 4
                      bus info: usb@4:1.1.4
                      version: 1.00
                      capabilities: usb-2.00
                      configuration: driver=hub maxpower=100mA slots=3 speed=480Mbit/s
                    *-usb
                         description: Keyboard
                         product: Topre Corporation HHKB Professional
                         vendor: Topre Corporation
                         physical id: 1
                         bus info: usb@4:1.1.4.1
                         logical name: input3
                         logical name: /dev/input/event3
                         logical name: input3::capslock
                         logical name: input3::compose
                         logical name: input3::kana
                         logical name: input3::numlock
                         logical name: input3::scrolllock
                         version: 1.02
                         capabilities: usb-1.10 usb
                         configuration: driver=usbhid maxpower=100mA speed=12Mbit/s
              *-usb:1
                   description: Human interface device
                   product: SAVITECH Bravo-X USB Audio
                   vendor: SAVITECH
                   physical id: 2
                   bus info: usb@4:1.2
                   logical name: card2
                   logical name: /dev/snd/controlC2
                   logical name: /dev/snd/pcmC2D0p
                   logical name: /dev/snd/pcmC2D1p
                   logical name: input2
                   logical name: /dev/input/event2
                   version: 0.01
                   capabilities: usb-1.10 usb
                   configuration: driver=snd-usb-audio maxpower=100mA speed=12Mbit/s
        *-usbhost:1
             product: xHCI Host Controller
             vendor: Linux 6.0.5-gentoo-arm64 xhci-hcd
             physical id: 1
             bus info: usb@5
             logical name: usb5
             version: 6.00
             capabilities: usb-3.00
             configuration: driver=hub slots=1 speed=5000Mbit/s
           *-usb
                description: USB hub
                product: 4-Port USB 3.1 Hub
                vendor: Generic
                physical id: 1
                bus info: usb@5:1
                version: 1.01
                capabilities: usb-3.10
                configuration: driver=hub slots=4 speed=5000Mbit/s
              *-usb
                   description: USB hub
                   product: USB3.1 Hub
                   vendor: GenesysLogic
                   physical id: 1
                   bus info: usb@5:1.1
                   version: 6.63
                   capabilities: usb-3.20
                   configuration: driver=hub slots=4 speed=5000Mbit/s
     *-generic
          description: System peripheral
          product: HiSilicon Embedded DMA Engine
          vendor: Huawei Technologies Co., Ltd.
          physical id: 13
          bus info: pci@0000:7b:00.0
          version: 21
          width: 64 bits
          clock: 33MHz
          capabilities: pciexpress msi pm bus_master cap_list
          configuration: driver=hisi_dma latency=0
          resources: iomemory:10-f irq:39 memory:148800000-148803fff
     *-pci:10
          description: PCI bridge
          product: HiSilicon PCI-PCI Bridge
          vendor: Huawei Technologies Co., Ltd.
          physical id: 0
          bus info: pci@0000:7c:00.0
          version: 20
          width: 64 bits
          clock: 33MHz
          capabilities: pci pciexpress pm normal_decode bus_master cap_list
          configuration: driver=pcieport
          resources: iomemory:1010-100f irq:0 ioport:120000000(size=2097152)
        *-network
             description: Ethernet interface
             product: HNS GE/10GE/25GE RDMA Network Controller
             vendor: Huawei Technologies Co., Ltd.
             physical id: 0
             bus info: pci@0000:7d:00.0
             logical name: enp125s0f0
             version: 21
             serial:
             size: 1Gbit/s
             capacity: 1Gbit/s
             width: 64 bits
             clock: 33MHz
             capabilities: pciexpress msix pm bus_master cap_list ethernet physical tp 10bt 10bt-fd 100bt 100bt-fd 1000bt-fd autonegotiation
             configuration: autonegotiation=on broadcast=yes driver=hns3 driverversion=6.0.5-gentoo-arm64 duplex=full firmware=1.8.15.0 ip=192.168.1.150 latency=0 link=yes multicast=yes port=twisted pair speed=1Gbit/s
             resources: iomemory:10-f iomemory:10-f irq:0 memory:120100000-12010ffff memory:120000000-1200fffff
     *-pnp00:00
          product: 16550A-compatible COM port
          physical id: 14
          capabilities: pnp
          configuration: driver=serial
  *-input:0
       product: Power Button
       physical id: 1
       logical name: input0
       logical name: /dev/input/event0
       capabilities: platform
  *-input:1
       product: MX Vertical Mouse
       physical id: 2
       logical name: input7
       logical name: /dev/input/event7
       logical name: /dev/input/mouse0
       capabilities: bluetooth

Am 27.10.22 um 16:29 schrieb Rodrigo Siqueira:
> Hi Ao/Arnd/Stephen/Nathan,
>
> Ao,
>
> Thanks a lot for this new patch.
>
> Since you have an ARM64 + AMD GPU, could you also run a couple of tests in your setup? If so, this is a good set of tests imho:
>
> 1. Check plug and unplug displays (let says 5x)
> 2. Change resolutions
> 3. (most wanted test) Could you run some IGT tests?
>
> About IGT, this is the official repository:
>
> https://gitlab.freedesktop.org/drm/igt-gpu-tools
>
> It should be easy to run IGT in your system. Follow a brief summary:
>
> 1. Install dependencies
>
> (maybe I missed something)
>
> Debian
> apt install flex bison pkg-config x11proto-dri2-dev python-docutils valgrind peg libpciaccess-dev libkmod-dev libprocps-dev libunwind-dev libdw-dev zlib1g-dev liblzma-dev libcairo-dev libpixman-1-dev libudev-dev libgsl-dev libasound2-dev libjson-c-dev libcurl4-openssl-dev libxrandr-dev libxv-dev meson libdrm-dev qemu-user qemu-user-static
>
> ArchLinux
> pacman -S gcc flex bison pkg-config libpciaccess kmod procps-ng libunwind libdwarf zlib xz cairo pixman libudev0-shim gsl alsa-lib xmlrpc-c json-c curl libxrandr libxv xorgproto python-docutils valgrind peg meson libdrm libtool make autoconf automake gtk-doc python-docutils git vim sudo
>
> 2. Build IGT
>
> meson build && ninja -C build
>
> 3. Turn off your GUI
>
> (You must run IGT without any GUI)
>
> sudo systemctl isolate multi-user.target
>
> After run this command, you should see the TTY.
>
> 4. Try to run this IGT test
>
> sudo ./build/tests/kms_flip
>
> And let me know if this test looks ok for you.
>
> On 10/27/22 06:52, Arnd Bergmann wrote:
>> On Thu, Oct 27, 2022, at 02:25, Ao Zhong wrote:
>>> After moving all FPU code to the DML folder, we can enable DCN support
>>> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
>>> code in the DML folder that needs to use hardware FPU, and add a control
>>> mechanism for ARM Neon.
>
> I recommend you to add the following info in your commit:
>
> 1. System that you use to validate this change (CPU name, monitor, distro, wayland/X, etc).
> 2. Describe the set of tests that you tried.
>
>>>
>>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
>>
>> There have been problems with stack frame overflows on this code
>> in the past, how much have you tested this with random configurations
>> to see if we still hit them in corner cases on arm64 that may not
>> show up on x86 or powerpc? I would expect to see a few more of them
>> for every new architecture port.
>
> Hi Arnd,
>
> We followed your suggestion to isolate all FPU code inside a single place (DML), and we recently completed most of this task. As a result, all FPU flags are only used in the DML code. I guess we might have issues in other non-x86 platforms, but this is something that we can improve over time, and from Ao message, it looks like that DCN is working on ARM.
>
> At this point, my main concern is that enabling ARM64 may causes some compilation issues that we did not reproduce yet. I cross-compiled amd-staging-drm-next + this patch with aarch64-linux-gnu-gcc version 12.2.0 and everything looks fine.
>
> Nathan/Stephen,
>
> Maybe I'm wrong, but I think you have access to some sort of CI that tests multiple builds with different compiles and configs, right? Is it possible to check this patch + amd-staging-drm-next in the CI to help us to anticipate any compilation issue if we merge this change?
>
> Or should we merge it and wait until it gets merged on the mainline? In case of a problem, we can easily revert a small patch like this, right?
>
> Thanks
> Siqueira
>
>>> index d0c6cf61c676..3cdd109189e0 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> @@ -33,6 +33,12 @@ ifdef CONFIG_PPC64
>>>   dml_ccflags := -mhard-float -maltivec
>>>   endif
>>>
>>> +ifdef CONFIG_ARM64
>>> +ifdef CONFIG_DRM_AMD_DC_DCN
>>> +dml_rcflags_arm64 := -mgeneral-regs-only
>>> +endif
>>> +endif
>>> +
>>
>>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags)
>>> -Wno-tautological-compare
>>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=
>>> $(dml_rcflags) $(dml_rcflags_arm64)
>>
>> Why do you need separate $(dml_rcflags) and $(dml_rcflags_arm64)
>> rather than adding -mgeneral-regs-only to $(dml_rcflags) directly?
>>
>>      Arnd
