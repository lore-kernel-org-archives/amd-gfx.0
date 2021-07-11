Return-Path: <SRS0=L2kD=ME=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65602C07E9E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 07:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36CEC61153
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jul 2021 07:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CEC61153
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8844189B83;
	Mon, 12 Jul 2021 07:18:40 +0000 (UTC)
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com
 [IPv6:2607:f8b0:4864:20::d41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D97789CB3
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Jul 2021 07:48:28 +0000 (UTC)
Received: by mail-io1-xd41.google.com with SMTP id k16so18178084ios.10
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Jul 2021 00:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:mime-version:content-disposition
 :in-reply-to; bh=oiN0vnmpoji50n2iGXX508grn/AFQeSfObsX/Tp1QVM=;
 b=hXhu9WINbXogUFSGRnjNHeWvsQwrpKhXrpnnvzm+wfiIoRZkD9hva+k6sSpYkDIz7l
 k8NC50o6jzPILqb9VjNBa/OVmPZZlUO2qQWTTh+C19wzWVBbxR0E9E/77b8/JNTzEnZ4
 m1+fEBM/k4C9IeG8fFrWH+tcmoycVE/kALvZakSElJtkkfRltFM/HqkyQlAUK8R5kkq8
 pbqx3i5IsUdZjlgxPwFAo/nEcWpmIA3cdmtGBeHF6E4dL3QGCYrdY8zzp2RT5RiMAZIb
 3QSOe41E/LegMh7lebtIhvz29mdq/YqkOoMW3VYUPXRoTV3KFLmxy6Z9uJa0GnjMytfA
 ZcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-disposition:in-reply-to;
 bh=oiN0vnmpoji50n2iGXX508grn/AFQeSfObsX/Tp1QVM=;
 b=TebhxZwmWIr63DcS9bh8uTB2JT96ZDVcgJqtLZVhPORJvY2gVfaMWbyQpF3k1XUX/M
 6UTu+qecTj/9ac9n8JkaxCYcufNJKFMm7agKCFqK1OR2QIljip85HCKx2ZE+YUAqNhle
 2pzRqOHMFkT+y8hkbf99S9tCiH7d46v0lTRdYlhWpTxq90LB5TfBNgcti9Smtp6oy6XC
 N1c3gFVOCqUtyklXiI/lbm++29m8kn508nhw3mKyF+/f8V8cocMD+i1Fq6LCEQQaQwP7
 /QJNp1rJiVu/VJTFKyBYM37K6Epth4NxAMj0Jz1Yoeqhvmg8d4RBlJnXBbMuuhgdqaUN
 LquQ==
X-Gm-Message-State: AOAM533zEEdFkVYYfI3B1223CzO8ocqlJjMQPAEbsPMl98CHk3MZx8a7
 6aKOzpYU5AGCUFZIiqlyXPM81LXtEif7vF6X
X-Google-Smtp-Source: ABdhPJwM2rd8CsqNDsH8+EE2GzcMC17ahz+s+yFyep7RfxRL6IdBv/kgCAnPTKu0XPJN/nJnIcOzXA==
X-Received: by 2002:a6b:7702:: with SMTP id n2mr34915513iom.1.1625989707848;
 Sun, 11 Jul 2021 00:48:27 -0700 (PDT)
Received: from mainframe.localdomain ([139.193.230.49])
 by smtp.gmail.com with ESMTPSA id f4sm6073887ile.8.2021.07.11.00.48.24
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jul 2021 00:48:26 -0700 (PDT)
Date: Sun, 11 Jul 2021 14:48:18 +0700
From: Ketsui <esgwpl@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: Re: AMDGPU error: "[drm:amdgpu_dm_atomic_commit_tail [amdgpu]]
 *ERROR* Waiting for fences timed out!"
Message-ID: <YOqiQmAUTBWjbVb6@mainframe.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+a9ZkNVvEAjfb4BR"
Content-Disposition: inline
In-Reply-To: <7f461adc-8868-0b76-cedb-d8be8d527218@daenzer.net>
X-Mailman-Approved-At: Mon, 12 Jul 2021 07:18:38 +0000
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


--+a9ZkNVvEAjfb4BR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> So far, so good; no hang in a week. I'll try the rest of the new firmware as well now, will follow up if there's a hang again.

I've noticed that the VM_L2_PROTECTION_FAULT_STATUS error doesn't always result in a hang, looking through my journal I can see
maybe a dozen of them spread out across multiple boots but my system only became non-functional like two times so far (I know
because I have the dmesg when the hangs happened saved, you can find them attached to this mail).

To make myself clear, I haven't actually had a hang too with the new firmwares even though these messages still appear on my dmesg,
sorry if my feedback gave the wrong impression.

--+a9ZkNVvEAjfb4BR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=amdgpu_hang_3

-- Journal begins at Sat 2020-01-04 14:06:41 WIB, ends at Mon 2021-05-17 13:54:24 WIB. --
May 17 08:01:21 mainframe kernel: system 00:05: [mem 0xfec01000-0xfec01fff] could not be reserved
May 17 08:01:21 mainframe kernel: system 00:05: [mem 0xfedc0000-0xfedc0fff] has been reserved
May 17 08:01:21 mainframe kernel: system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
May 17 08:01:21 mainframe kernel: system 00:05: [mem 0xfed80000-0xfed8ffff] could not be reserved
May 17 08:01:21 mainframe kernel: system 00:05: [mem 0xfec10000-0xfec10fff] has been reserved
May 17 08:01:21 mainframe kernel: system 00:05: [mem 0xff000000-0xffffffff] has been reserved
May 17 08:01:21 mainframe kernel: system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
May 17 08:01:21 mainframe kernel: pnp: PnP ACPI: found 6 devices
May 17 08:01:21 mainframe kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
May 17 08:01:21 mainframe kernel: NET: Registered protocol family 2
May 17 08:01:21 mainframe kernel: tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
May 17 08:01:21 mainframe kernel: TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
May 17 08:01:21 mainframe kernel: TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
May 17 08:01:21 mainframe kernel: TCP: Hash tables configured (established 131072 bind 65536)
May 17 08:01:21 mainframe kernel: MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
May 17 08:01:21 mainframe kernel: UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
May 17 08:01:21 mainframe kernel: UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
May 17 08:01:21 mainframe kernel: NET: Registered protocol family 1
May 17 08:01:21 mainframe kernel: NET: Registered protocol family 44
May 17 08:01:21 mainframe kernel: pci 0000:02:00.0: PCI bridge to [bus 03]
May 17 08:01:21 mainframe kernel: pci 0000:02:01.0: PCI bridge to [bus 04]
May 17 08:01:21 mainframe kernel: pci 0000:02:04.0: PCI bridge to [bus 05]
May 17 08:01:21 mainframe kernel: pci 0000:02:06.0: PCI bridge to [bus 06]
May 17 08:01:21 mainframe kernel: pci 0000:02:07.0: PCI bridge to [bus 07]
May 17 08:01:21 mainframe kernel: pci 0000:02:07.0:   bridge window [io  0xf000-0xffff]
May 17 08:01:21 mainframe kernel: pci 0000:02:07.0:   bridge window [mem 0xfcd00000-0xfcdfffff]
May 17 08:01:21 mainframe kernel: pci 0000:01:00.2: PCI bridge to [bus 02-07]
May 17 08:01:21 mainframe kernel: pci 0000:01:00.2:   bridge window [io  0xf000-0xffff]
May 17 08:01:21 mainframe kernel: pci 0000:01:00.2:   bridge window [mem 0xfcd00000-0xfcdfffff]
May 17 08:01:21 mainframe kernel: pci 0000:00:01.2: PCI bridge to [bus 01-07]
May 17 08:01:21 mainframe kernel: pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
May 17 08:01:21 mainframe kernel: pci 0000:00:01.2:   bridge window [mem 0xfcd00000-0xfcefffff]
May 17 08:01:21 mainframe kernel: pci 0000:00:08.1: PCI bridge to [bus 08]
May 17 08:01:21 mainframe kernel: pci 0000:00:08.1:   bridge window [io  0xe000-0xefff]
May 17 08:01:21 mainframe kernel: pci 0000:00:08.1:   bridge window [mem 0xfc900000-0xfccfffff]
May 17 08:01:21 mainframe kernel: pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
May 17 08:01:21 mainframe kernel: pci 0000:00:08.2: PCI bridge to [bus 09]
May 17 08:01:21 mainframe kernel: pci 0000:00:08.2:   bridge window [mem 0xfcf00000-0xfcffffff]
May 17 08:01:21 mainframe kernel: pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
May 17 08:01:21 mainframe kernel: pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
May 17 08:01:21 mainframe kernel: pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
May 17 08:01:21 mainframe kernel: pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
May 17 08:01:21 mainframe kernel: pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
May 17 08:01:21 mainframe kernel: pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
May 17 08:01:21 mainframe kernel: pci_bus 0000:00: resource 10 [mem 0xe0000000-0xfec2ffff window]
May 17 08:01:21 mainframe kernel: pci_bus 0000:00: resource 11 [mem 0xfee00000-0xffffffff window]
May 17 08:01:21 mainframe kernel: pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
May 17 08:01:21 mainframe kernel: pci_bus 0000:01: resource 1 [mem 0xfcd00000-0xfcefffff]
May 17 08:01:21 mainframe kernel: pci_bus 0000:02: resource 0 [io  0xf000-0xffff]
May 17 08:01:21 mainframe kernel: pci_bus 0000:02: resource 1 [mem 0xfcd00000-0xfcdfffff]
May 17 08:01:21 mainframe kernel: pci_bus 0000:07: resource 0 [io  0xf000-0xffff]
May 17 08:01:21 mainframe kernel: pci_bus 0000:07: resource 1 [mem 0xfcd00000-0xfcdfffff]
May 17 08:01:21 mainframe kernel: pci_bus 0000:08: resource 0 [io  0xe000-0xefff]
May 17 08:01:21 mainframe kernel: pci_bus 0000:08: resource 1 [mem 0xfc900000-0xfccfffff]
May 17 08:01:21 mainframe kernel: pci_bus 0000:08: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
May 17 08:01:21 mainframe kernel: pci_bus 0000:09: resource 1 [mem 0xfcf00000-0xfcffffff]
May 17 08:01:21 mainframe kernel: pci 0000:08:00.1: D0 power state depends on 0000:08:00.0
May 17 08:01:21 mainframe kernel: pci 0000:08:00.3: extending delay after power-on from D3hot to 20 msec
May 17 08:01:21 mainframe kernel: pci 0000:08:00.4: extending delay after power-on from D3hot to 20 msec
May 17 08:01:21 mainframe kernel: PCI: CLS 64 bytes, default 64
May 17 08:01:21 mainframe kernel: Trying to unpack rootfs image as initramfs...
May 17 08:01:21 mainframe kernel: Freeing initrd memory: 18440K
May 17 08:01:21 mainframe kernel: pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
May 17 08:01:21 mainframe kernel: pci 0000:00:00.2: can't derive routing for PCI INT A
May 17 08:01:21 mainframe kernel: pci 0000:00:00.2: PCI INT A: not connected
May 17 08:01:21 mainframe kernel: pci 0000:00:01.0: Adding to iommu group 0
May 17 08:01:21 mainframe kernel: pci 0000:00:01.2: Adding to iommu group 1
May 17 08:01:21 mainframe kernel: pci 0000:00:08.0: Adding to iommu group 2
May 17 08:01:21 mainframe kernel: pci 0000:00:08.1: Adding to iommu group 3
May 17 08:01:21 mainframe kernel: pci 0000:00:08.2: Adding to iommu group 4
May 17 08:01:21 mainframe kernel: pci 0000:00:14.0: Adding to iommu group 5
May 17 08:01:21 mainframe kernel: pci 0000:00:14.3: Adding to iommu group 5
May 17 08:01:21 mainframe kernel: pci 0000:00:18.0: Adding to iommu group 6
May 17 08:01:21 mainframe kernel: pci 0000:00:18.1: Adding to iommu group 6
May 17 08:01:21 mainframe kernel: pci 0000:00:18.2: Adding to iommu group 6
May 17 08:01:21 mainframe kernel: pci 0000:00:18.3: Adding to iommu group 6
May 17 08:01:21 mainframe kernel: pci 0000:00:18.4: Adding to iommu group 6
May 17 08:01:21 mainframe kernel: pci 0000:00:18.5: Adding to iommu group 6
May 17 08:01:21 mainframe kernel: pci 0000:00:18.6: Adding to iommu group 6
May 17 08:01:21 mainframe kernel: pci 0000:00:18.7: Adding to iommu group 6
May 17 08:01:21 mainframe kernel: pci 0000:01:00.0: Adding to iommu group 7
May 17 08:01:21 mainframe kernel: pci 0000:01:00.1: Adding to iommu group 7
May 17 08:01:21 mainframe kernel: pci 0000:01:00.2: Adding to iommu group 7
May 17 08:01:21 mainframe kernel: pci 0000:02:00.0: Adding to iommu group 7
May 17 08:01:21 mainframe kernel: pci 0000:02:01.0: Adding to iommu group 7
May 17 08:01:21 mainframe kernel: pci 0000:02:04.0: Adding to iommu group 7
May 17 08:01:21 mainframe kernel: pci 0000:02:06.0: Adding to iommu group 7
May 17 08:01:21 mainframe kernel: pci 0000:02:07.0: Adding to iommu group 7
May 17 08:01:21 mainframe kernel: pci 0000:07:00.0: Adding to iommu group 7
May 17 08:01:21 mainframe kernel: pci 0000:08:00.0: Adding to iommu group 8
May 17 08:01:21 mainframe kernel: pci 0000:08:00.1: Adding to iommu group 9
May 17 08:01:21 mainframe kernel: pci 0000:08:00.2: Adding to iommu group 9
May 17 08:01:21 mainframe kernel: pci 0000:08:00.3: Adding to iommu group 9
May 17 08:01:21 mainframe kernel: pci 0000:08:00.4: Adding to iommu group 9
May 17 08:01:21 mainframe kernel: pci 0000:08:00.6: Adding to iommu group 9
May 17 08:01:21 mainframe kernel: pci 0000:09:00.0: Adding to iommu group 10
May 17 08:01:21 mainframe kernel: pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
May 17 08:01:21 mainframe kernel: pci 0000:00:00.2: AMD-Vi: Extended features (0x4f77ef22294ada):
May 17 08:01:21 mainframe kernel:  PPR NX GT IA GA PC GA_vAPIC
May 17 08:01:21 mainframe kernel: AMD-Vi: Interrupt remapping enabled
May 17 08:01:21 mainframe kernel: AMD-Vi: Virtual APIC enabled
May 17 08:01:21 mainframe kernel: AMD-Vi: Lazy IO/TLB flushing enabled
May 17 08:01:21 mainframe kernel: amd_uncore: 4  amd_df counters detected
May 17 08:01:21 mainframe kernel: amd_uncore: 6  amd_l3 counters detected
May 17 08:01:21 mainframe kernel: perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
May 17 08:01:21 mainframe kernel: check: Scanning for low memory corruption every 60 seconds
May 17 08:01:21 mainframe kernel: Initialise system trusted keyrings
May 17 08:01:21 mainframe kernel: Key type blacklist registered
May 17 08:01:21 mainframe kernel: workingset: timestamp_bits=41 max_order=22 bucket_order=0
May 17 08:01:21 mainframe kernel: zbud: loaded
May 17 08:01:21 mainframe kernel: Key type asymmetric registered
May 17 08:01:21 mainframe kernel: Asymmetric key parser 'x509' registered
May 17 08:01:21 mainframe kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
May 17 08:01:21 mainframe kernel: io scheduler mq-deadline registered
May 17 08:01:21 mainframe kernel: io scheduler kyber registered
May 17 08:01:21 mainframe kernel: io scheduler bfq registered
May 17 08:01:21 mainframe kernel: pcieport 0000:00:01.2: PME: Signaling with IRQ 26
May 17 08:01:21 mainframe kernel: pcieport 0000:00:01.2: AER: enabled with IRQ 26
May 17 08:01:21 mainframe kernel: pcieport 0000:00:08.1: PME: Signaling with IRQ 27
May 17 08:01:21 mainframe kernel: pcieport 0000:00:08.2: PME: Signaling with IRQ 28
May 17 08:01:21 mainframe kernel: pcieport 0000:00:08.2: AER: enabled with IRQ 28
May 17 08:01:21 mainframe kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
May 17 08:01:21 mainframe kernel: efifb: probing for efifb
May 17 08:01:21 mainframe kernel: efifb: framebuffer at 0xe0000000, using 8100k, total 8100k
May 17 08:01:21 mainframe kernel: efifb: mode is 1920x1080x32, linelength=7680, pages=1
May 17 08:01:21 mainframe kernel: efifb: scrolling: redraw
May 17 08:01:21 mainframe kernel: efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
May 17 08:01:21 mainframe kernel: fbcon: Deferring console take-over
May 17 08:01:21 mainframe kernel: fb0: EFI VGA frame buffer device
May 17 08:01:21 mainframe kernel: input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
May 17 08:01:21 mainframe kernel: ACPI: button: Power Button [PWRB]
May 17 08:01:21 mainframe kernel: input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
May 17 08:01:21 mainframe kernel: ACPI: button: Power Button [PWRF]
May 17 08:01:21 mainframe kernel: Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
May 17 08:01:21 mainframe kernel: 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
May 17 08:01:21 mainframe kernel: Non-volatile memory driver v1.3
May 17 08:01:21 mainframe kernel: AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
May 17 08:01:21 mainframe kernel: ahci 0000:01:00.1: version 3.0
May 17 08:01:21 mainframe kernel: ahci 0000:01:00.1: SSS flag set, parallel bus scan disabled
May 17 08:01:21 mainframe kernel: ahci 0000:01:00.1: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0x33 impl SATA mode
May 17 08:01:21 mainframe kernel: ahci 0000:01:00.1: flags: 64bit ncq sntf stag pm led clo only pmp pio slum part sxs deso sadm sds apst 
May 17 08:01:21 mainframe kernel: scsi host0: ahci
May 17 08:01:21 mainframe kernel: scsi host1: ahci
May 17 08:01:21 mainframe kernel: scsi host2: ahci
May 17 08:01:21 mainframe kernel: scsi host3: ahci
May 17 08:01:21 mainframe kernel: scsi host4: ahci
May 17 08:01:21 mainframe kernel: scsi host5: ahci
May 17 08:01:21 mainframe kernel: scsi host6: ahci
May 17 08:01:21 mainframe kernel: scsi host7: ahci
May 17 08:01:21 mainframe kernel: ata1: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80100 irq 39
May 17 08:01:21 mainframe kernel: ata2: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80180 irq 39
May 17 08:01:21 mainframe kernel: ata3: DUMMY
May 17 08:01:21 mainframe kernel: ata4: DUMMY
May 17 08:01:21 mainframe kernel: ata5: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80300 irq 39
May 17 08:01:21 mainframe kernel: ata6: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80380 irq 39
May 17 08:01:21 mainframe kernel: ata7: DUMMY
May 17 08:01:21 mainframe kernel: ata8: DUMMY
May 17 08:01:21 mainframe kernel: ahci 0000:09:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x2 impl SATA mode
May 17 08:01:21 mainframe kernel: ahci 0000:09:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part 
May 17 08:01:21 mainframe kernel: scsi host8: ahci
May 17 08:01:21 mainframe kernel: scsi host9: ahci
May 17 08:01:21 mainframe kernel: ata9: DUMMY
May 17 08:01:21 mainframe kernel: ata10: SATA max UDMA/133 abar m2048@0xfcf00000 port 0xfcf00180 irq 42
May 17 08:01:21 mainframe kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
May 17 08:01:21 mainframe kernel: ehci-pci: EHCI PCI platform driver
May 17 08:01:21 mainframe kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
May 17 08:01:21 mainframe kernel: ohci-pci: OHCI PCI platform driver
May 17 08:01:21 mainframe kernel: uhci_hcd: USB Universal Host Controller Interface driver
May 17 08:01:21 mainframe kernel: usbcore: registered new interface driver usbserial_generic
May 17 08:01:21 mainframe kernel: usbserial: USB Serial support registered for generic
May 17 08:01:21 mainframe kernel: rtc_cmos 00:02: RTC can wake from S4
May 17 08:01:21 mainframe kernel: rtc_cmos 00:02: registered as rtc0
May 17 08:01:21 mainframe kernel: rtc_cmos 00:02: setting system clock to 2021-05-17T01:01:19 UTC (1621213279)
May 17 08:01:21 mainframe kernel: rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
May 17 08:01:21 mainframe kernel: ledtrig-cpu: registered to indicate activity on CPUs
May 17 08:01:21 mainframe kernel: hid: raw HID events driver (C) Jiri Kosina
May 17 08:01:21 mainframe kernel: drop_monitor: Initializing network drop monitor service
May 17 08:01:21 mainframe kernel: Initializing XFRM netlink socket
May 17 08:01:21 mainframe kernel: NET: Registered protocol family 10
May 17 08:01:21 mainframe kernel: Segment Routing with IPv6
May 17 08:01:21 mainframe kernel: RPL Segment Routing with IPv6
May 17 08:01:21 mainframe kernel: NET: Registered protocol family 17
May 17 08:01:21 mainframe kernel: microcode: CPU0: patch_level=0x08108109
May 17 08:01:21 mainframe kernel: microcode: CPU1: patch_level=0x08108109
May 17 08:01:21 mainframe kernel: microcode: CPU2: patch_level=0x08108109
May 17 08:01:21 mainframe kernel: microcode: CPU3: patch_level=0x08108109
May 17 08:01:21 mainframe kernel: microcode: Microcode Update Driver: v2.2.
May 17 08:01:21 mainframe kernel: IPI shorthand broadcast: enabled
May 17 08:01:21 mainframe kernel: sched_clock: Marking stable (330017142, 540965)->(333918715, -3360608)
May 17 08:01:21 mainframe kernel: registered taskstats version 1
May 17 08:01:21 mainframe kernel: Loading compiled-in X.509 certificates
May 17 08:01:21 mainframe kernel: Loaded X.509 cert 'Build time autogenerated kernel key: b7dd4c6f26f0841761999fbe1c2bba3248c3959d'
May 17 08:01:21 mainframe kernel: zswap: loaded using pool lz4/z3fold
May 17 08:01:21 mainframe kernel: Key type ._fscrypt registered
May 17 08:01:21 mainframe kernel: Key type .fscrypt registered
May 17 08:01:21 mainframe kernel: Key type fscrypt-provisioning registered
May 17 08:01:21 mainframe kernel: PM:   Magic number: 5:335:3
May 17 08:01:21 mainframe kernel: RAS: Correctable Errors collector initialized.
May 17 08:01:21 mainframe kernel: ata1: SATA link down (SStatus 0 SControl 300)
May 17 08:01:21 mainframe kernel: ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 17 08:01:21 mainframe kernel: ata10.00: ATA-9: V-GEN08SM20AR128GBM2SDK, S0807A0, max UDMA/133
May 17 08:01:21 mainframe kernel: ata10.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 32), AA
May 17 08:01:21 mainframe kernel: ata10.00: configured for UDMA/133
May 17 08:01:21 mainframe kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 17 08:01:21 mainframe kernel: ata2.00: ATA-11: Patriot Burst, SBFME1.3, max UDMA/133
May 17 08:01:21 mainframe kernel: ata2.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 32), AA
May 17 08:01:21 mainframe kernel: ata2.00: configured for UDMA/133
May 17 08:01:21 mainframe kernel: scsi 1:0:0:0: Direct-Access     ATA      Patriot Burst    E1.3 PQ: 0 ANSI: 5
May 17 08:01:21 mainframe kernel: sd 1:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
May 17 08:01:21 mainframe kernel: sd 1:0:0:0: [sda] Write Protect is off
May 17 08:01:21 mainframe kernel: sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
May 17 08:01:21 mainframe kernel: sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 17 08:01:21 mainframe kernel:  sda: sda1 sda2 sda3 sda4 sda5
May 17 08:01:21 mainframe kernel: sd 1:0:0:0: [sda] Attached SCSI disk
May 17 08:01:21 mainframe kernel: tsc: Refined TSC clocksource calibration: 3593.234 MHz
May 17 08:01:21 mainframe kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33cb5bcd94d, max_idle_ns: 440795284310 ns
May 17 08:01:21 mainframe kernel: clocksource: Switched to clocksource tsc
May 17 08:01:21 mainframe kernel: ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 17 08:01:21 mainframe kernel: ata5.00: ATA-8: HGST HTS545050A7E680, GG2OAF10, max UDMA/133
May 17 08:01:21 mainframe kernel: ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
May 17 08:01:21 mainframe kernel: ata5.00: configured for UDMA/133
May 17 08:01:21 mainframe kernel: scsi 4:0:0:0: Direct-Access     ATA      HGST HTS545050A7 AF10 PQ: 0 ANSI: 5
May 17 08:01:21 mainframe kernel: sd 4:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
May 17 08:01:21 mainframe kernel: sd 4:0:0:0: [sdb] 4096-byte physical blocks
May 17 08:01:21 mainframe kernel: sd 4:0:0:0: [sdb] Write Protect is off
May 17 08:01:21 mainframe kernel: sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
May 17 08:01:21 mainframe kernel: sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 17 08:01:21 mainframe kernel:  sdb: sdb1 sdb2
May 17 08:01:21 mainframe kernel: sd 4:0:0:0: [sdb] Attached SCSI disk
May 17 08:01:21 mainframe kernel: ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
May 17 08:01:21 mainframe kernel: ata6.00: ATA-8: ST3160316CS, SC13, max UDMA/133
May 17 08:01:21 mainframe kernel: ata6.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 32)
May 17 08:01:21 mainframe kernel: ata6.00: configured for UDMA/133
May 17 08:01:21 mainframe kernel: scsi 5:0:0:0: Direct-Access     ATA      ST3160316CS      SC13 PQ: 0 ANSI: 5
May 17 08:01:21 mainframe kernel: sd 5:0:0:0: [sdc] 312581808 512-byte logical blocks: (160 GB/149 GiB)
May 17 08:01:21 mainframe kernel: sd 5:0:0:0: [sdc] Write Protect is off
May 17 08:01:21 mainframe kernel: sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
May 17 08:01:21 mainframe kernel: sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 17 08:01:21 mainframe kernel: scsi 9:0:0:0: Direct-Access     ATA      V-GEN08SM20AR128 7A0  PQ: 0 ANSI: 5
May 17 08:01:21 mainframe kernel: sd 9:0:0:0: [sdd] 250069680 512-byte logical blocks: (128 GB/119 GiB)
May 17 08:01:21 mainframe kernel: sd 9:0:0:0: [sdd] Write Protect is off
May 17 08:01:21 mainframe kernel: sd 9:0:0:0: [sdd] Mode Sense: 00 3a 00 00
May 17 08:01:21 mainframe kernel: sd 9:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 17 08:01:21 mainframe kernel:  sdd: sdd1
May 17 08:01:21 mainframe kernel:  sdc: sdc1
May 17 08:01:21 mainframe kernel: sd 9:0:0:0: [sdd] Attached SCSI disk
May 17 08:01:21 mainframe kernel: sd 5:0:0:0: [sdc] Attached SCSI disk
May 17 08:01:21 mainframe kernel: Freeing unused decrypted memory: 2036K
May 17 08:01:21 mainframe kernel: Freeing unused kernel image (initmem) memory: 1652K
May 17 08:01:21 mainframe kernel: Write protecting the kernel read-only data: 26624k
May 17 08:01:21 mainframe kernel: Freeing unused kernel image (text/rodata gap) memory: 2036K
May 17 08:01:21 mainframe kernel: Freeing unused kernel image (rodata/data gap) memory: 1248K
May 17 08:01:21 mainframe kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
May 17 08:01:21 mainframe kernel: rodata_test: all tests were successful
May 17 08:01:21 mainframe kernel: Run /init as init process
May 17 08:01:21 mainframe kernel:   with arguments:
May 17 08:01:21 mainframe kernel:     /init
May 17 08:01:21 mainframe kernel:   with environment:
May 17 08:01:21 mainframe kernel:     HOME=/
May 17 08:01:21 mainframe kernel:     TERM=linux
May 17 08:01:21 mainframe kernel: random: crng init done
May 17 08:01:21 mainframe systemd[1]: Successfully credited entropy passed from boot loader.
May 17 08:01:21 mainframe systemd[1]: systemd 248.2-2-arch running in system mode. (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
May 17 08:01:21 mainframe systemd[1]: Detected architecture x86-64.
May 17 08:01:21 mainframe systemd[1]: Running in initial RAM disk.
May 17 08:01:21 mainframe kernel: fbcon: Taking over console
May 17 08:01:21 mainframe systemd[1]: Hostname set to <mainframe>.
May 17 08:01:21 mainframe kernel: Console: switching to colour frame buffer device 240x67
May 17 08:01:21 mainframe systemd[1]: Queued start job for default target Initrd Default Target.
May 17 08:01:21 mainframe systemd[1]: Created slice system-systemd\x2dcryptsetup.slice.
May 17 08:01:21 mainframe systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
May 17 08:01:21 mainframe systemd[1]: Reached target Local File Systems.
May 17 08:01:21 mainframe systemd[1]: Reached target Paths.
May 17 08:01:21 mainframe systemd[1]: Reached target Slices.
May 17 08:01:21 mainframe systemd[1]: Reached target Swap.
May 17 08:01:21 mainframe systemd[1]: Reached target Timers.
May 17 08:01:21 mainframe systemd[1]: Listening on Journal Audit Socket.
May 17 08:01:21 mainframe systemd[1]: Listening on Journal Socket (/dev/log).
May 17 08:01:21 mainframe systemd[1]: Listening on Journal Socket.
May 17 08:01:21 mainframe systemd[1]: Listening on udev Control Socket.
May 17 08:01:21 mainframe systemd[1]: Listening on udev Kernel Socket.
May 17 08:01:21 mainframe systemd[1]: Reached target Sockets.
May 17 08:01:21 mainframe systemd[1]: Starting Create list of static device nodes for the current kernel...
May 17 08:01:21 mainframe systemd[1]: Starting Journal Service...
May 17 08:01:21 mainframe systemd[1]: Starting Load Kernel Modules...
May 17 08:01:21 mainframe systemd[1]: Starting Setup Virtual Console...
May 17 08:01:21 mainframe systemd[1]: Finished Create list of static device nodes for the current kernel.
May 17 08:01:21 mainframe systemd[1]: Starting Create Static Device Nodes in /dev...
May 17 08:01:21 mainframe systemd[1]: Finished Setup Virtual Console.
May 17 08:01:21 mainframe systemd[1]: Condition check resulted in dracut ask for additional cmdline parameters being skipped.
May 17 08:01:21 mainframe kernel: Asymmetric key parser 'pkcs8' registered
May 17 08:01:21 mainframe systemd[1]: Starting dracut cmdline hook...
May 17 08:01:21 mainframe systemd[1]: Finished Load Kernel Modules.
May 17 08:01:21 mainframe systemd[1]: Starting Apply Kernel Variables...
May 17 08:01:21 mainframe kernel: audit: type=1130 audit(1621213281.413:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:21 mainframe systemd[1]: Finished Create Static Device Nodes in /dev.
May 17 08:01:21 mainframe kernel: audit: type=1130 audit(1621213281.416:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:21 mainframe systemd[1]: Finished Apply Kernel Variables.
May 17 08:01:21 mainframe kernel: audit: type=1130 audit(1621213281.420:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:21 mainframe systemd[1]: Started Journal Service.
May 17 08:01:21 mainframe kernel: audit: type=1130 audit(1621213281.440:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:21 mainframe kernel: audit: type=1130 audit(1621213281.443:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:21 mainframe kernel: audit: type=1130 audit(1621213281.446:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:21 mainframe kernel: device-mapper: uevent: version 1.0.3
May 17 08:01:21 mainframe kernel: device-mapper: ioctl: 4.44.0-ioctl (2021-02-01) initialised: dm-devel@redhat.com
May 17 08:01:21 mainframe kernel: audit: type=1130 audit(1621213281.473:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:21 mainframe kernel: audit: type=1334 audit(1621213281.473:9): prog-id=6 op=LOAD
May 17 08:01:21 mainframe kernel: audit: type=1334 audit(1621213281.473:10): prog-id=7 op=LOAD
May 17 08:01:21 mainframe kernel: ACPI: video: Video Device [VGA1] (multi-head: yes  rom: no  post: no)
May 17 08:01:21 mainframe kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GP17.VGA.LCD._BCM.AFN7], AE_NOT_FOUND (20210105/psargs-330)
May 17 08:01:21 mainframe kernel: ACPI Error: Aborting method \_SB.PCI0.GP17.VGA.LCD._BCM due to previous error (AE_NOT_FOUND) (20210105/psparse-529)
May 17 08:01:21 mainframe kernel: ACPI: \_SB_.PCI0.GP17.VGA_.LCD_: _BCM evaluation failed
May 17 08:01:21 mainframe kernel: input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0f/LNXVIDEO:01/input/input2
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:01:00.0: xHCI Host Controller
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
May 17 08:01:21 mainframe kernel: ccp 0000:08:00.2: enabling device (0000 -> 0002)
May 17 08:01:21 mainframe kernel: ccp 0000:08:00.2: ccp enabled
May 17 08:01:21 mainframe kernel: ccp 0000:08:00.2: psp: unable to access the device: you might be running a broken BIOS.
May 17 08:01:21 mainframe kernel: cryptd: max_cpu_qlen set to 1000
May 17 08:01:21 mainframe kernel: AVX2 version of gcm_enc/dec engaged.
May 17 08:01:21 mainframe kernel: AES CTR mode by8 optimization enabled
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000000000410
May 17 08:01:21 mainframe kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.12
May 17 08:01:21 mainframe kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 17 08:01:21 mainframe kernel: usb usb1: Product: xHCI Host Controller
May 17 08:01:21 mainframe kernel: usb usb1: Manufacturer: Linux 5.12.3-arch1-1 xhci-hcd
May 17 08:01:21 mainframe kernel: usb usb1: SerialNumber: 0000:01:00.0
May 17 08:01:21 mainframe kernel: hub 1-0:1.0: USB hub found
May 17 08:01:21 mainframe kernel: hub 1-0:1.0: 10 ports detected
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:01:00.0: xHCI Host Controller
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
May 17 08:01:21 mainframe kernel: usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
May 17 08:01:21 mainframe kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.12
May 17 08:01:21 mainframe kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 17 08:01:21 mainframe kernel: usb usb2: Product: xHCI Host Controller
May 17 08:01:21 mainframe kernel: usb usb2: Manufacturer: Linux 5.12.3-arch1-1 xhci-hcd
May 17 08:01:21 mainframe kernel: usb usb2: SerialNumber: 0000:01:00.0
May 17 08:01:21 mainframe kernel: hub 2-0:1.0: USB hub found
May 17 08:01:21 mainframe kernel: hub 2-0:1.0: 4 ports detected
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.3: xHCI Host Controller
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus number 3
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000840000410
May 17 08:01:21 mainframe kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.12
May 17 08:01:21 mainframe kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 17 08:01:21 mainframe kernel: usb usb3: Product: xHCI Host Controller
May 17 08:01:21 mainframe kernel: usb usb3: Manufacturer: Linux 5.12.3-arch1-1 xhci-hcd
May 17 08:01:21 mainframe kernel: usb usb3: SerialNumber: 0000:08:00.3
May 17 08:01:21 mainframe kernel: hub 3-0:1.0: USB hub found
May 17 08:01:21 mainframe kernel: hub 3-0:1.0: 4 ports detected
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.3: xHCI Host Controller
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus number 4
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enhanced SuperSpeed
May 17 08:01:21 mainframe kernel: usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
May 17 08:01:21 mainframe kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.12
May 17 08:01:21 mainframe kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 17 08:01:21 mainframe kernel: usb usb4: Product: xHCI Host Controller
May 17 08:01:21 mainframe kernel: usb usb4: Manufacturer: Linux 5.12.3-arch1-1 xhci-hcd
May 17 08:01:21 mainframe kernel: usb usb4: SerialNumber: 0000:08:00.3
May 17 08:01:21 mainframe kernel: hub 4-0:1.0: USB hub found
May 17 08:01:21 mainframe kernel: hub 4-0:1.0: 4 ports detected
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.4: xHCI Host Controller
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus number 5
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000840000410
May 17 08:01:21 mainframe kernel: usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.12
May 17 08:01:21 mainframe kernel: usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 17 08:01:21 mainframe kernel: usb usb5: Product: xHCI Host Controller
May 17 08:01:21 mainframe kernel: usb usb5: Manufacturer: Linux 5.12.3-arch1-1 xhci-hcd
May 17 08:01:21 mainframe kernel: usb usb5: SerialNumber: 0000:08:00.4
May 17 08:01:21 mainframe kernel: hub 5-0:1.0: USB hub found
May 17 08:01:21 mainframe kernel: hub 5-0:1.0: 1 port detected
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.4: xHCI Host Controller
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus number 6
May 17 08:01:21 mainframe kernel: xhci_hcd 0000:08:00.4: Host supports USB 3.1 Enhanced SuperSpeed
May 17 08:01:21 mainframe kernel: usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
May 17 08:01:21 mainframe kernel: usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.12
May 17 08:01:21 mainframe kernel: usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 17 08:01:21 mainframe kernel: usb usb6: Product: xHCI Host Controller
May 17 08:01:21 mainframe kernel: usb usb6: Manufacturer: Linux 5.12.3-arch1-1 xhci-hcd
May 17 08:01:21 mainframe kernel: usb usb6: SerialNumber: 0000:08:00.4
May 17 08:01:21 mainframe kernel: hub 6-0:1.0: USB hub found
May 17 08:01:21 mainframe kernel: hub 6-0:1.0: 1 port detected
May 17 08:01:22 mainframe kernel: usb 1-5: new full-speed USB device number 2 using xhci_hcd
May 17 08:01:22 mainframe kernel: usb 1-5: New USB device found, idVendor=046d, idProduct=c534, bcdDevice=29.01
May 17 08:01:22 mainframe kernel: usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
May 17 08:01:22 mainframe kernel: usb 1-5: Product: USB Receiver
May 17 08:01:22 mainframe kernel: usb 1-5: Manufacturer: Logitech
May 17 08:01:22 mainframe kernel: input: Logitech USB Receiver as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.0/0003:046D:C534.0001/input/input3
May 17 08:01:22 mainframe kernel: hid-generic 0003:046D:C534.0001: input,hidraw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:01:00.0-5/input0
May 17 08:01:22 mainframe kernel: input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.1/0003:046D:C534.0002/input/input4
May 17 08:01:22 mainframe kernel: input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.1/0003:046D:C534.0002/input/input5
May 17 08:01:22 mainframe kernel: input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.1/0003:046D:C534.0002/input/input6
May 17 08:01:22 mainframe kernel: hid-generic 0003:046D:C534.0002: input,hiddev96,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:01:00.0-5/input1
May 17 08:01:22 mainframe kernel: usbcore: registered new interface driver usbhid
May 17 08:01:22 mainframe kernel: usbhid: USB HID core driver
May 17 08:01:22 mainframe kernel: usb 1-8: new low-speed USB device number 3 using xhci_hcd
May 17 08:01:22 mainframe kernel: logitech-djreceiver 0003:046D:C534.0001: hidraw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:01:00.0-5/input0
May 17 08:01:22 mainframe kernel: logitech-djreceiver 0003:046D:C534.0002: hiddev96,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:01:00.0-5/input1
May 17 08:01:22 mainframe kernel: logitech-djreceiver 0003:046D:C534.0002: device of type eQUAD nano Lite (0x0a) connected on slot 2
May 17 08:01:22 mainframe kernel: input: Logitech Wireless Mouse PID:4054 Mouse as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.1/0003:046D:C534.0002/0003:046D:4054.0003/input/input9
May 17 08:01:22 mainframe kernel: hid-generic 0003:046D:4054.0003: input,hidraw2: USB HID v1.11 Mouse [Logitech Wireless Mouse PID:4054] on usb-0000:01:00.0-5/input1:2
May 17 08:01:22 mainframe kernel: usb 1-8: New USB device found, idVendor=1c4f, idProduct=0002, bcdDevice= 1.10
May 17 08:01:22 mainframe kernel: usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=0
May 17 08:01:22 mainframe kernel: usb 1-8: Product: USB Keyboard
May 17 08:01:22 mainframe kernel: usb 1-8: Manufacturer: SIGMACHIP
May 17 08:01:22 mainframe kernel: input: SIGMACHIP USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-8/1-8:1.0/0003:1C4F:0002.0004/input/input13
May 17 08:01:22 mainframe kernel: input: Logitech Wireless Mouse as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.1/0003:046D:C534.0002/0003:046D:4054.0003/input/input14
May 17 08:01:23 mainframe kernel: hid-generic 0003:1C4F:0002.0004: input,hidraw2: USB HID v1.10 Keyboard [SIGMACHIP USB Keyboard] on usb-0000:01:00.0-8/input0
May 17 08:01:23 mainframe kernel: logitech-hidpp-device 0003:046D:4054.0003: input,hidraw3: USB HID v1.11 Mouse [Logitech Wireless Mouse] on usb-0000:01:00.0-5/input1:2
May 17 08:01:23 mainframe kernel: input: SIGMACHIP USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-8/1-8:1.1/0003:1C4F:0002.0005/input/input15
May 17 08:01:23 mainframe kernel: input: SIGMACHIP USB Keyboard System Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-8/1-8:1.1/0003:1C4F:0002.0005/input/input16
May 17 08:01:23 mainframe kernel: hid-generic 0003:1C4F:0002.0005: input,hidraw4: USB HID v1.10 Device [SIGMACHIP USB Keyboard] on usb-0000:01:00.0-8/input1
May 17 08:01:31 mainframe kernel: Key type encrypted registered
May 17 08:01:31 mainframe kernel: kauditd_printk_skb: 4 callbacks suppressed
May 17 08:01:31 mainframe kernel: audit: type=1130 audit(1621213291.590:15): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-cryptsetup@cryptroot comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:31 mainframe kernel: audit: type=1130 audit(1621213291.596:16): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:31 mainframe kernel: audit: type=1130 audit(1621213291.610:17): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:32 mainframe kernel: F2FS-fs (dm-0): Mounted with checkpoint version = 1a1d3332
May 17 08:01:32 mainframe kernel: audit: type=1334 audit(1621213292.120:18): prog-id=5 op=UNLOAD
May 17 08:01:32 mainframe kernel: audit: type=1334 audit(1621213292.120:19): prog-id=4 op=UNLOAD
May 17 08:01:32 mainframe kernel: audit: type=1334 audit(1621213292.120:20): prog-id=3 op=UNLOAD
May 17 08:01:32 mainframe kernel: audit: type=1334 audit(1621213292.120:21): prog-id=8 op=UNLOAD
May 17 08:01:32 mainframe kernel: audit: type=1334 audit(1621213292.120:22): prog-id=7 op=UNLOAD
May 17 08:01:32 mainframe kernel: audit: type=1334 audit(1621213292.120:23): prog-id=6 op=UNLOAD
May 17 08:01:32 mainframe kernel: audit: type=1334 audit(1621213292.213:24): prog-id=9 op=LOAD
May 17 08:01:34 mainframe systemd-journald[182]: Received SIGTERM from PID 1 (systemd).
May 17 08:01:34 mainframe systemd[1]: systemd 248.2-2-arch running in system mode. (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
May 17 08:01:34 mainframe systemd[1]: Detected architecture x86-64.
May 17 08:01:34 mainframe systemd[1]: initrd-switch-root.service: Deactivated successfully.
May 17 08:01:34 mainframe systemd[1]: Stopped Switch Root.
May 17 08:01:34 mainframe systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
May 17 08:01:34 mainframe systemd[1]: Created slice system-getty.slice.
May 17 08:01:34 mainframe systemd[1]: Created slice system-modprobe.slice.
May 17 08:01:34 mainframe systemd[1]: Created slice system-systemd\x2dfsck.slice.
May 17 08:01:34 mainframe systemd[1]: Created slice User and Session Slice.
May 17 08:01:34 mainframe systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
May 17 08:01:34 mainframe systemd[1]: Started Forward Password Requests to Wall Directory Watch.
May 17 08:01:34 mainframe systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
May 17 08:01:34 mainframe systemd[1]: Reached target Local Encrypted Volumes.
May 17 08:01:34 mainframe systemd[1]: Stopped target Switch Root.
May 17 08:01:34 mainframe systemd[1]: Stopped target Initrd File Systems.
May 17 08:01:34 mainframe systemd[1]: Stopped target Initrd Root File System.
May 17 08:01:34 mainframe systemd[1]: Reached target Paths.
May 17 08:01:34 mainframe systemd[1]: Reached target Remote File Systems.
May 17 08:01:34 mainframe systemd[1]: Reached target Slices.
May 17 08:01:34 mainframe systemd[1]: Reached target Local Verity Integrity Protected Volumes.
May 17 08:01:34 mainframe systemd[1]: Listening on Device-mapper event daemon FIFOs.
May 17 08:01:34 mainframe systemd[1]: Listening on LVM2 poll daemon socket.
May 17 08:01:34 mainframe systemd[1]: Listening on Process Core Dump Socket.
May 17 08:01:34 mainframe systemd[1]: Listening on udev Control Socket.
May 17 08:01:34 mainframe systemd[1]: Listening on udev Kernel Socket.
May 17 08:01:34 mainframe systemd[1]: Mounting Huge Pages File System...
May 17 08:01:34 mainframe systemd[1]: Mounting POSIX Message Queue File System...
May 17 08:01:34 mainframe systemd[1]: Mounting Kernel Debug File System...
May 17 08:01:34 mainframe systemd[1]: Mounting Kernel Trace File System...
May 17 08:01:34 mainframe systemd[1]: Starting Create list of static device nodes for the current kernel...
May 17 08:01:34 mainframe systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
May 17 08:01:34 mainframe systemd[1]: Starting Load Kernel Module configfs...
May 17 08:01:34 mainframe systemd[1]: Starting Load Kernel Module drm...
May 17 08:01:34 mainframe systemd[1]: Starting Load Kernel Module fuse...
May 17 08:01:34 mainframe systemd[1]: systemd-cryptsetup@cryptroot.service: Deactivated successfully.
May 17 08:01:34 mainframe systemd[1]: Stopped systemd-cryptsetup@cryptroot.service.
May 17 08:01:34 mainframe systemd[1]: Stopped Journal Service.
May 17 08:01:34 mainframe systemd[1]: Starting Journal Service...
May 17 08:01:34 mainframe kernel: fuse: init (API version 7.33)
May 17 08:01:34 mainframe systemd[1]: Starting Load Kernel Modules...
May 17 08:01:34 mainframe systemd[1]: Starting Remount Root and Kernel File Systems...
May 17 08:01:34 mainframe systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
May 17 08:01:34 mainframe systemd[1]: Starting Coldplug All udev Devices...
May 17 08:01:34 mainframe kernel: Linux agpgart interface v0.103
May 17 08:01:34 mainframe systemd[1]: sysroot.mount: Deactivated successfully.
May 17 08:01:34 mainframe systemd[1]: Started Journal Service.
May 17 08:01:36 mainframe kernel: Adding 2097148k swap on /swap.  Priority:-2 extents:3 across:51494424k SSFS
May 17 08:01:36 mainframe kernel: acpi_cpufreq: overriding BIOS provided _PSD data
May 17 08:01:36 mainframe kernel: piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
May 17 08:01:36 mainframe kernel: piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
May 17 08:01:36 mainframe kernel: piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
May 17 08:01:36 mainframe kernel: sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
May 17 08:01:36 mainframe kernel: sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
May 17 08:01:36 mainframe kernel: sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
May 17 08:01:36 mainframe kernel: input: PC Speaker as /devices/platform/pcspkr/input/input17
May 17 08:01:36 mainframe kernel: mousedev: PS/2 mouse device common for all mice
May 17 08:01:36 mainframe kernel: libphy: r8169: probed
May 17 08:01:36 mainframe kernel: r8169 0000:07:00.0 eth0: RTL8168h/8111h, 70:85:c2:c6:3b:6c, XID 541, IRQ 62
May 17 08:01:36 mainframe kernel: r8169 0000:07:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
May 17 08:01:36 mainframe kernel: RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
May 17 08:01:36 mainframe kernel: RAPL PMU: hw unit of domain package 2^-16 Joules
May 17 08:01:36 mainframe kernel: r8169 0000:07:00.0 enp7s0: renamed from eth0
May 17 08:01:36 mainframe kernel: snd_hda_intel 0000:08:00.1: enabling device (0000 -> 0002)
May 17 08:01:36 mainframe kernel: snd_hda_intel 0000:08:00.6: enabling device (0000 -> 0002)
May 17 08:01:36 mainframe kernel: kvm: Nested Virtualization enabled
May 17 08:01:36 mainframe kernel: SVM: kvm: Nested Paging enabled
May 17 08:01:36 mainframe kernel: SVM: Virtual VMLOAD VMSAVE supported
May 17 08:01:36 mainframe kernel: SVM: Virtual GIF supported
May 17 08:01:36 mainframe kernel: input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card0/input18
May 17 08:01:36 mainframe kernel: input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card0/input19
May 17 08:01:36 mainframe kernel: input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card0/input20
May 17 08:01:36 mainframe kernel: MCE: In-kernel MCE decoding enabled.
May 17 08:01:36 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC887-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
May 17 08:01:36 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
May 17 08:01:36 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
May 17 08:01:36 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
May 17 08:01:36 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:    inputs:
May 17 08:01:36 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
May 17 08:01:36 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
May 17 08:01:36 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
May 17 08:01:36 mainframe kernel: input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input21
May 17 08:01:36 mainframe kernel: input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input22
May 17 08:01:36 mainframe kernel: input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input23
May 17 08:01:36 mainframe kernel: input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input24
May 17 08:01:36 mainframe kernel: input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input25
May 17 08:01:36 mainframe kernel: intel_rapl_common: Found RAPL domain package
May 17 08:01:36 mainframe kernel: intel_rapl_common: Found RAPL domain core
May 17 08:01:36 mainframe kernel: [drm] amdgpu kernel modesetting enabled.
May 17 08:01:36 mainframe kernel: amdgpu: Topology: Add APU node [0x0:0x0]
May 17 08:01:36 mainframe kernel: checking generic (e0000000 7e9000) vs hw (e0000000 10000000)
May 17 08:01:36 mainframe kernel: fb0: switching to amdgpudrmfb from EFI VGA
May 17 08:01:36 mainframe kernel: Console: switching to colour dummy device 80x25
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: vgaarb: deactivate vga console
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: enabling device (0006 -> 0007)
May 17 08:01:36 mainframe kernel: [drm] initializing kernel modesetting (RAVEN 0x1002:0x15D8 0x1002:0x15D8 0xC9).
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: Trusted Memory Zone (TMZ) feature disabled as experimental (default)
May 17 08:01:36 mainframe kernel: [drm] register mmio base: 0xFCC00000
May 17 08:01:36 mainframe kernel: [drm] register mmio size: 524288
May 17 08:01:36 mainframe kernel: [drm] add ip block number 0 <soc15_common>
May 17 08:01:36 mainframe kernel: [drm] add ip block number 1 <gmc_v9_0>
May 17 08:01:36 mainframe kernel: [drm] add ip block number 2 <vega10_ih>
May 17 08:01:36 mainframe kernel: [drm] add ip block number 3 <psp>
May 17 08:01:36 mainframe kernel: [drm] add ip block number 4 <gfx_v9_0>
May 17 08:01:36 mainframe kernel: [drm] add ip block number 5 <sdma_v4_0>
May 17 08:01:36 mainframe kernel: [drm] add ip block number 6 <powerplay>
May 17 08:01:36 mainframe kernel: [drm] add ip block number 7 <dm>
May 17 08:01:36 mainframe kernel: [drm] add ip block number 8 <vcn_v1_0>
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: Fetched VBIOS from VFCT
May 17 08:01:36 mainframe kernel: amdgpu: ATOM BIOS: 113-PICASSO-114
May 17 08:01:36 mainframe kernel: [drm] VCN decode is enabled in VM mode
May 17 08:01:36 mainframe kernel: [drm] VCN encode is enabled in VM mode
May 17 08:01:36 mainframe kernel: [drm] JPEG decode is enabled in VM mode
May 17 08:01:36 mainframe kernel: [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
May 17 08:01:36 mainframe kernel: [drm] Detected VRAM RAM=2048M, BAR=2048M
May 17 08:01:36 mainframe kernel: [drm] RAM width 128bits DDR4
May 17 08:01:36 mainframe kernel: [TTM] Zone  kernel: Available graphics memory: 7155062 KiB
May 17 08:01:36 mainframe kernel: [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
May 17 08:01:36 mainframe kernel: [drm] amdgpu: 2048M of VRAM memory ready
May 17 08:01:36 mainframe kernel: [drm] amdgpu: 3072M of GTT memory ready.
May 17 08:01:36 mainframe kernel: [drm] GART: num cpu pages 262144, num gpu pages 262144
May 17 08:01:36 mainframe kernel: [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
May 17 08:01:36 mainframe kernel: amdgpu: hwmgr_sw_init smu backed is smu10_smu
May 17 08:01:36 mainframe kernel: [drm] Found VCN firmware Version ENC: 1.12 DEC: 2 VEP: 0 Revision: 1
May 17 08:01:36 mainframe kernel: [drm] PSP loading VCN firmware
May 17 08:01:36 mainframe kernel: [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAS: optional ras ta ucode is not available
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta ucode is not available
May 17 08:01:36 mainframe kernel: [drm] kiq ring mec 2 pipe 1 q 0
May 17 08:01:36 mainframe kernel: [drm] DM_PPLIB: values for F clock
May 17 08:01:36 mainframe kernel: [drm] DM_PPLIB:         1400000 in kHz, 4399 in mV
May 17 08:01:36 mainframe kernel: [drm] DM_PPLIB: values for DCF clock
May 17 08:01:36 mainframe kernel: [drm] DM_PPLIB:         300000 in kHz, 3099 in mV
May 17 08:01:36 mainframe kernel: [drm] DM_PPLIB:         600000 in kHz, 3574 in mV
May 17 08:01:36 mainframe kernel: [drm] DM_PPLIB:         626000 in kHz, 4250 in mV
May 17 08:01:36 mainframe kernel: [drm] DM_PPLIB:         654000 in kHz, 4399 in mV
May 17 08:01:36 mainframe kernel: [drm] Display Core initialized with v3.2.122!
May 17 08:01:36 mainframe kernel: snd_hda_intel 0000:08:00.1: bound 0000:08:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
May 17 08:01:36 mainframe kernel: [drm] VCN decode and encode initialized successfully(under SPG Mode).
May 17 08:01:36 mainframe kernel: kfd kfd: Allocated 3969056 bytes on gart
May 17 08:01:36 mainframe kernel: amdgpu: Topology: Add APU node [0x15d8:0x1002]
May 17 08:01:36 mainframe kernel: kfd kfd: added device 1002:15d8
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 11, active_cu_number 8
May 17 08:01:36 mainframe kernel: [drm] fb mappable at 0x39FBCE000
May 17 08:01:36 mainframe kernel: [drm] vram apper at 0x39F000000
May 17 08:01:36 mainframe kernel: [drm] size 8294400
May 17 08:01:36 mainframe kernel: [drm] fb depth is 24
May 17 08:01:36 mainframe kernel: [drm]    pitch is 7680
May 17 08:01:36 mainframe kernel: fbcon: amdgpudrmfb (fb0) is primary device
May 17 08:01:36 mainframe kernel: Console: switching to colour frame buffer device 240x67
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: [drm] fb0: amdgpudrmfb frame buffer device
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
May 17 08:01:36 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
May 17 08:01:36 mainframe kernel: [drm] Initialized amdgpu 3.40.0 20150101 for 0000:08:00.0 on minor 0
May 17 08:01:36 mainframe kernel: kauditd_printk_skb: 74 callbacks suppressed
May 17 08:01:36 mainframe kernel: audit: type=1130 audit(1621213296.910:97): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journal-flush comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:36 mainframe kernel: audit: type=1130 audit(1621213296.966:98): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:36 mainframe kernel: audit: type=1334 audit(1621213296.970:99): prog-id=26 op=LOAD
May 17 08:01:36 mainframe kernel: audit: type=1127 audit(1621213296.976:100): pid=749 uid=0 auid=4294967295 ses=4294967295 msg=' comm="systemd-update-utmp" exe="/usr/lib/systemd/systemd-update-utmp" hostname=? addr=? terminal=? res=success'
May 17 08:01:36 mainframe kernel: audit: type=1130 audit(1621213296.976:101): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-update-utmp comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:37 mainframe kernel: audit: type=1130 audit(1621213297.006:102): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-timesyncd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:37 mainframe kernel: audit: type=1130 audit(1621213297.023:103): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dbus comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:37 mainframe kernel: nct6775: Found NCT6793D or compatible chip at 0x2e:0x290
May 17 08:01:37 mainframe kernel: audit: type=1334 audit(1621213297.140:104): prog-id=27 op=LOAD
May 17 08:01:37 mainframe kernel: audit: type=1334 audit(1621213297.140:105): prog-id=28 op=LOAD
May 17 08:01:37 mainframe kernel: audit: type=1334 audit(1621213297.140:106): prog-id=29 op=LOAD
May 17 08:01:37 mainframe kernel: 8021q: 802.1Q VLAN Support v1.8
May 17 08:01:38 mainframe kernel: cfg80211: Loading compiled-in X.509 certificates for regulatory database
May 17 08:01:38 mainframe kernel: cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
May 17 08:01:38 mainframe kernel: platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
May 17 08:01:38 mainframe kernel: cfg80211: failed to load regulatory.db
May 17 08:01:38 mainframe kernel: Generic FE-GE Realtek PHY r8169-700:00: attached PHY driver (mii_bus:phy_addr=r8169-700:00, irq=MAC)
May 17 08:01:38 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Down
May 17 08:01:39 mainframe kernel: NET: Registered protocol family 38
May 17 08:01:40 mainframe kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp7s0: link becomes ready
May 17 08:01:40 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Up - 100Mbps/Full - flow control rx/tx
May 17 08:01:47 mainframe kernel: kauditd_printk_skb: 31 callbacks suppressed
May 17 08:01:47 mainframe kernel: audit: type=1130 audit(1621213307.440:121): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=man-db comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:47 mainframe kernel: audit: type=1131 audit(1621213307.440:122): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=man-db comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:48 mainframe kernel: audit: type=1100 audit(1621213308.193:123): pid=883 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:authentication grantors=pam_securetty,pam_shells,pam_faillock,pam_permit,pam_faillock acct="ketsui" exe="/usr/bin/login" hostname=mainframe addr=? terminal=/dev/tty1 res=success'
May 17 08:01:48 mainframe kernel: audit: type=1101 audit(1621213308.203:124): pid=883 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/bin/login" hostname=mainframe addr=? terminal=/dev/tty1 res=success'
May 17 08:01:48 mainframe kernel: audit: type=1103 audit(1621213308.203:125): pid=883 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_securetty,pam_shells,pam_faillock,pam_permit,pam_faillock acct="ketsui" exe="/usr/bin/login" hostname=mainframe addr=? terminal=/dev/tty1 res=success'
May 17 08:01:48 mainframe kernel: audit: type=1006 audit(1621213308.203:126): pid=883 uid=0 old-auid=4294967295 auid=1000 tty=tty1 old-ses=4294967295 ses=1 res=1
May 17 08:01:48 mainframe kernel: audit: type=1300 audit(1621213308.203:126): arch=c000003e syscall=1 success=yes exit=4 a0=5 a1=7ffeceb9ba10 a2=4 a3=3e8 items=0 ppid=1 pid=883 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=1000 fsgid=0 tty=tty1 ses=1 comm="login" exe="/usr/bin/login" key=(null)
May 17 08:01:48 mainframe kernel: audit: type=1327 audit(1621213308.203:126): proctitle=2F62696E2F6C6F67696E002D70002D2D00202020202020
May 17 08:01:48 mainframe kernel: audit: type=1130 audit(1621213308.226:127): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@1000 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:01:48 mainframe kernel: audit: type=1101 audit(1621213308.236:128): pid=891 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:02:05 mainframe kernel: kauditd_printk_skb: 12 callbacks suppressed
May 17 08:02:05 mainframe kernel: audit: type=1130 audit(1621213325.376:137): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=polkit comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:02:08 mainframe kernel: audit: type=1130 audit(1621213328.576:138): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=rtkit-daemon comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:02:12 mainframe kernel: audit: type=1130 audit(1621213332.092:139): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=udisks2 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:02:23 mainframe kernel: logitech-hidpp-device 0003:046D:4054.0003: HID++ 4.5 device connected.
May 17 08:10:35 mainframe kernel: audit: type=1130 audit(1621213835.834:140): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=openvpn-restart comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:10:35 mainframe kernel: PM: suspend entry (deep)
May 17 08:18:47 mainframe kernel: Filesystems sync: 0.094 seconds
May 17 08:18:47 mainframe kernel: Freezing user space processes ... (elapsed 0.002 seconds) done.
May 17 08:18:47 mainframe kernel: OOM killer disabled.
May 17 08:18:47 mainframe kernel: Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
May 17 08:18:47 mainframe kernel: printk: Suspending console(s) (use no_console_suspend to debug)
May 17 08:18:47 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Down
May 17 08:18:47 mainframe kernel: serial 00:04: disabled
May 17 08:18:47 mainframe kernel: sd 9:0:0:0: [sdd] Synchronizing SCSI cache
May 17 08:18:47 mainframe kernel: sd 9:0:0:0: [sdd] Stopping disk
May 17 08:18:47 mainframe kernel: sd 4:0:0:0: [sdb] Synchronizing SCSI cache
May 17 08:18:47 mainframe kernel: sd 5:0:0:0: [sdc] Synchronizing SCSI cache
May 17 08:18:47 mainframe kernel: sd 4:0:0:0: [sdb] Stopping disk
May 17 08:18:47 mainframe kernel: sd 5:0:0:0: [sdc] Stopping disk
May 17 08:18:47 mainframe kernel: sd 1:0:0:0: [sda] Synchronizing SCSI cache
May 17 08:18:47 mainframe kernel: sd 1:0:0:0: [sda] Stopping disk
May 17 08:18:47 mainframe kernel: [drm] free PSP TMR buffer
May 17 08:18:47 mainframe kernel: ACPI: Preparing to enter system sleep state S3
May 17 08:18:47 mainframe kernel: PM: Saving platform NVS memory
May 17 08:18:47 mainframe kernel: Disabling non-boot CPUs ...
May 17 08:18:47 mainframe kernel: smpboot: CPU 1 is now offline
May 17 08:18:47 mainframe kernel: smpboot: CPU 2 is now offline
May 17 08:18:47 mainframe kernel: smpboot: CPU 3 is now offline
May 17 08:18:47 mainframe kernel: ACPI: Low-level resume complete
May 17 08:18:47 mainframe kernel: PM: Restoring platform NVS memory
May 17 08:18:47 mainframe kernel: Enabling non-boot CPUs ...
May 17 08:18:47 mainframe kernel: x86: Booting SMP configuration:
May 17 08:18:47 mainframe kernel: smpboot: Booting Node 0 Processor 1 APIC 0x2
May 17 08:18:47 mainframe kernel: microcode: CPU1: patch_level=0x08108109
May 17 08:18:47 mainframe kernel: CPU1 is up
May 17 08:18:47 mainframe kernel: smpboot: Booting Node 0 Processor 2 APIC 0x1
May 17 08:18:47 mainframe kernel: microcode: CPU2: patch_level=0x08108109
May 17 08:18:47 mainframe kernel: CPU2 is up
May 17 08:18:47 mainframe kernel: smpboot: Booting Node 0 Processor 3 APIC 0x3
May 17 08:18:47 mainframe kernel: microcode: CPU3: patch_level=0x08108109
May 17 08:18:47 mainframe kernel: CPU3 is up
May 17 08:18:47 mainframe kernel: ACPI: Waking up from system sleep state S3
May 17 08:18:47 mainframe kernel: sd 1:0:0:0: [sda] Starting disk
May 17 08:18:47 mainframe kernel: sd 4:0:0:0: [sdb] Starting disk
May 17 08:18:47 mainframe kernel: sd 5:0:0:0: [sdc] Starting disk
May 17 08:18:47 mainframe kernel: [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
May 17 08:18:47 mainframe kernel: [drm] PSP is resuming...
May 17 08:18:47 mainframe kernel: usb usb1: root hub lost power or was reset
May 17 08:18:47 mainframe kernel: usb usb2: root hub lost power or was reset
May 17 08:18:47 mainframe kernel: serial 00:04: activated
May 17 08:18:47 mainframe kernel: [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
May 17 08:18:47 mainframe kernel: sd 9:0:0:0: [sdd] Starting disk
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAS: optional ras ta ucode is not available
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta ucode is not available
May 17 08:18:47 mainframe kernel: [drm] kiq ring mec 2 pipe 1 q 0
May 17 08:18:47 mainframe kernel: amdgpu: dpm has been enabled
May 17 08:18:47 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Down
May 17 08:18:47 mainframe kernel: [drm] VCN decode and encode initialized successfully(under SPG Mode).
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
May 17 08:18:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
May 17 08:18:47 mainframe kernel: ata1: SATA link down (SStatus 0 SControl 300)
May 17 08:18:47 mainframe kernel: usb 1-5: reset full-speed USB device number 2 using xhci_hcd
May 17 08:18:47 mainframe kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 17 08:18:47 mainframe kernel: ata2.00: configured for UDMA/133
May 17 08:18:47 mainframe kernel: ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 17 08:18:47 mainframe kernel: ata10.00: configured for UDMA/133
May 17 08:18:47 mainframe kernel: usb 1-8: reset low-speed USB device number 3 using xhci_hcd
May 17 08:18:47 mainframe kernel: OOM killer enabled.
May 17 08:18:47 mainframe kernel: Restarting tasks ... done.
May 17 08:18:47 mainframe kernel: video LNXVIDEO:01: Restoring backlight state
May 17 08:18:47 mainframe kernel: PM: suspend exit
May 17 08:18:47 mainframe kernel: audit: type=1130 audit(1621214327.463:141): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-suspend comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:18:47 mainframe kernel: audit: type=1131 audit(1621214327.463:142): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-suspend comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:18:47 mainframe kernel: audit: type=1131 audit(1621214327.476:143): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=openvpn-restart comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:18:47 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Up - 100Mbps/Full - flow control rx/tx
May 17 08:18:48 mainframe kernel: ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 17 08:18:48 mainframe kernel: ata5.00: configured for UDMA/133
May 17 08:18:49 mainframe kernel: ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
May 17 08:18:49 mainframe kernel: ata6.00: configured for UDMA/133
May 17 08:19:10 mainframe kernel: audit: type=1100 audit(1621214350.706:144): pid=2406 uid=1000 auid=1000 ses=1 msg='op=PAM:unix_chkpwd acct="ketsui" exe="/usr/bin/unix_chkpwd" hostname=? addr=? terminal=? res=success'
May 17 08:24:34 mainframe kernel: audit: type=1130 audit(1621214674.214:145): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-clean comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:24:34 mainframe kernel: audit: type=1131 audit(1621214674.214:146): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-clean comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 08:38:55 mainframe kernel: usb 3-2: new high-speed USB device number 2 using xhci_hcd
May 17 08:38:55 mainframe kernel: usb 3-2: New USB device found, idVendor=0b05, idProduct=7770, bcdDevice= 4.04
May 17 08:38:55 mainframe kernel: usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
May 17 08:38:55 mainframe kernel: usb 3-2: Product: ASUS_X00TDA
May 17 08:38:55 mainframe kernel: usb 3-2: Manufacturer: asus
May 17 08:38:55 mainframe kernel: usb 3-2: SerialNumber: J6AXGF03H233HBA
May 17 09:01:47 mainframe kernel: usb 3-2: USB disconnect, device number 2
May 17 09:01:47 mainframe kernel: usb 3-2: new high-speed USB device number 3 using xhci_hcd
May 17 09:01:47 mainframe kernel: usb 3-2: New USB device found, idVendor=0b05, idProduct=7773, bcdDevice= 4.04
May 17 09:01:47 mainframe kernel: usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
May 17 09:01:47 mainframe kernel: usb 3-2: Product: ASUS_X00TDA
May 17 09:01:47 mainframe kernel: usb 3-2: Manufacturer: asus
May 17 09:01:47 mainframe kernel: usb 3-2: SerialNumber: J6AXGF03H233HBA
May 17 09:41:38 mainframe kernel: audit: type=1130 audit(1621219298.828:147): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=fstrim comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 09:41:38 mainframe kernel: audit: type=1131 audit(1621219298.828:148): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=fstrim comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 09:57:03 mainframe kernel: usb 3-2: USB disconnect, device number 3
May 17 10:07:26 mainframe kernel: audit: type=1130 audit(1621220846.425:149): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=openvpn-restart comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 10:07:26 mainframe kernel: PM: suspend entry (deep)
May 17 10:44:24 mainframe kernel: Filesystems sync: 0.059 seconds
May 17 10:44:24 mainframe kernel: Freezing user space processes ... (elapsed 0.001 seconds) done.
May 17 10:44:24 mainframe kernel: OOM killer disabled.
May 17 10:44:24 mainframe kernel: Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
May 17 10:44:24 mainframe kernel: printk: Suspending console(s) (use no_console_suspend to debug)
May 17 10:44:24 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Down
May 17 10:44:24 mainframe kernel: serial 00:04: disabled
May 17 10:44:24 mainframe kernel: sd 4:0:0:0: [sdb] Synchronizing SCSI cache
May 17 10:44:24 mainframe kernel: sd 9:0:0:0: [sdd] Synchronizing SCSI cache
May 17 10:44:24 mainframe kernel: sd 5:0:0:0: [sdc] Synchronizing SCSI cache
May 17 10:44:24 mainframe kernel: sd 1:0:0:0: [sda] Synchronizing SCSI cache
May 17 10:44:24 mainframe kernel: sd 9:0:0:0: [sdd] Stopping disk
May 17 10:44:24 mainframe kernel: sd 4:0:0:0: [sdb] Stopping disk
May 17 10:44:24 mainframe kernel: sd 1:0:0:0: [sda] Stopping disk
May 17 10:44:24 mainframe kernel: sd 5:0:0:0: [sdc] Stopping disk
May 17 10:44:24 mainframe kernel: [drm] free PSP TMR buffer
May 17 10:44:24 mainframe kernel: ACPI: Preparing to enter system sleep state S3
May 17 10:44:24 mainframe kernel: PM: Saving platform NVS memory
May 17 10:44:24 mainframe kernel: Disabling non-boot CPUs ...
May 17 10:44:24 mainframe kernel: smpboot: CPU 1 is now offline
May 17 10:44:24 mainframe kernel: smpboot: CPU 2 is now offline
May 17 10:44:24 mainframe kernel: smpboot: CPU 3 is now offline
May 17 10:44:24 mainframe kernel: ACPI: Low-level resume complete
May 17 10:44:24 mainframe kernel: PM: Restoring platform NVS memory
May 17 10:44:24 mainframe kernel: Enabling non-boot CPUs ...
May 17 10:44:24 mainframe kernel: x86: Booting SMP configuration:
May 17 10:44:24 mainframe kernel: smpboot: Booting Node 0 Processor 1 APIC 0x2
May 17 10:44:24 mainframe kernel: microcode: CPU1: patch_level=0x08108109
May 17 10:44:24 mainframe kernel: CPU1 is up
May 17 10:44:24 mainframe kernel: smpboot: Booting Node 0 Processor 2 APIC 0x1
May 17 10:44:24 mainframe kernel: microcode: CPU2: patch_level=0x08108109
May 17 10:44:24 mainframe kernel: CPU2 is up
May 17 10:44:24 mainframe kernel: smpboot: Booting Node 0 Processor 3 APIC 0x3
May 17 10:44:24 mainframe kernel: microcode: CPU3: patch_level=0x08108109
May 17 10:44:24 mainframe kernel: CPU3 is up
May 17 10:44:24 mainframe kernel: ACPI: Waking up from system sleep state S3
May 17 10:44:24 mainframe kernel: usb usb1: root hub lost power or was reset
May 17 10:44:24 mainframe kernel: usb usb2: root hub lost power or was reset
May 17 10:44:24 mainframe kernel: serial 00:04: activated
May 17 10:44:24 mainframe kernel: [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
May 17 10:44:24 mainframe kernel: [drm] PSP is resuming...
May 17 10:44:24 mainframe kernel: sd 1:0:0:0: [sda] Starting disk
May 17 10:44:24 mainframe kernel: sd 4:0:0:0: [sdb] Starting disk
May 17 10:44:24 mainframe kernel: sd 5:0:0:0: [sdc] Starting disk
May 17 10:44:24 mainframe kernel: sd 9:0:0:0: [sdd] Starting disk
May 17 10:44:24 mainframe kernel: [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAS: optional ras ta ucode is not available
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta ucode is not available
May 17 10:44:24 mainframe kernel: [drm] kiq ring mec 2 pipe 1 q 0
May 17 10:44:24 mainframe kernel: amdgpu: dpm has been enabled
May 17 10:44:24 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Down
May 17 10:44:24 mainframe kernel: [drm] VCN decode and encode initialized successfully(under SPG Mode).
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
May 17 10:44:24 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
May 17 10:44:24 mainframe kernel: ata1: SATA link down (SStatus 0 SControl 300)
May 17 10:44:24 mainframe kernel: usb 1-5: reset full-speed USB device number 2 using xhci_hcd
May 17 10:44:24 mainframe kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 17 10:44:24 mainframe kernel: ata2.00: configured for UDMA/133
May 17 10:44:24 mainframe kernel: ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 17 10:44:24 mainframe kernel: ata10.00: configured for UDMA/133
May 17 10:44:24 mainframe kernel: usb 1-8: reset low-speed USB device number 3 using xhci_hcd
May 17 10:44:24 mainframe kernel: OOM killer enabled.
May 17 10:44:24 mainframe kernel: Restarting tasks ... done.
May 17 10:44:24 mainframe kernel: video LNXVIDEO:01: Restoring backlight state
May 17 10:44:24 mainframe kernel: PM: suspend exit
May 17 10:44:24 mainframe kernel: audit: type=1130 audit(1621223064.463:150): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-suspend comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 10:44:24 mainframe kernel: audit: type=1131 audit(1621223064.463:151): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-suspend comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 10:44:24 mainframe kernel: audit: type=1131 audit(1621223064.473:152): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=openvpn-restart comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 10:44:24 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Up - 100Mbps/Full - flow control rx/tx
May 17 10:44:25 mainframe kernel: ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 17 10:44:25 mainframe kernel: ata5.00: configured for UDMA/133
May 17 10:44:26 mainframe kernel: ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
May 17 10:44:26 mainframe kernel: ata6.00: configured for UDMA/133
May 17 10:44:31 mainframe kernel: audit: type=1100 audit(1621223071.893:153): pid=4515 uid=1000 auid=1000 ses=1 msg='op=PAM:unix_chkpwd acct="ketsui" exe="/usr/bin/unix_chkpwd" hostname=? addr=? terminal=? res=success'
May 17 12:10:15 mainframe kernel: audit: type=1334 audit(1621228215.470:154): prog-id=33 op=LOAD
May 17 12:10:15 mainframe kernel: audit: type=1334 audit(1621228215.470:155): prog-id=34 op=LOAD
May 17 12:10:15 mainframe kernel: audit: type=1334 audit(1621228215.470:156): prog-id=35 op=LOAD
May 17 12:10:15 mainframe kernel: audit: type=1130 audit(1621228215.504:157): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 12:10:45 mainframe kernel: audit: type=1131 audit(1621228245.591:158): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 12:10:45 mainframe kernel: audit: type=1334 audit(1621228245.728:159): prog-id=35 op=UNLOAD
May 17 12:10:45 mainframe kernel: audit: type=1334 audit(1621228245.728:160): prog-id=34 op=UNLOAD
May 17 12:10:45 mainframe kernel: audit: type=1334 audit(1621228245.728:161): prog-id=33 op=UNLOAD
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:5 pasid:32769, for process Xorg pid 932 thread Xorg:cs0 pid 933)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x800105a00000 from client 27
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00501031
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MORE_FAULTS: 0x1
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          WALKER_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          PERMISSION_FAULTS: 0x3
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MAPPING_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          RW: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:5 pasid:32769, for process Xorg pid 932 thread Xorg:cs0 pid 933)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x800105a01000 from client 27
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00501031
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MORE_FAULTS: 0x1
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          WALKER_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          PERMISSION_FAULTS: 0x3
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MAPPING_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          RW: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:5 pasid:32769, for process Xorg pid 932 thread Xorg:cs0 pid 933)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x800105a02000 from client 27
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00501031
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MORE_FAULTS: 0x1
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          WALKER_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          PERMISSION_FAULTS: 0x3
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MAPPING_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          RW: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:5 pasid:32769, for process Xorg pid 932 thread Xorg:cs0 pid 933)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x800105a03000 from client 27
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00501031
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MORE_FAULTS: 0x1
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          WALKER_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          PERMISSION_FAULTS: 0x3
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MAPPING_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          RW: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:5 pasid:32769, for process Xorg pid 932 thread Xorg:cs0 pid 933)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x800105a04000 from client 27
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00501031
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MORE_FAULTS: 0x1
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          WALKER_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          PERMISSION_FAULTS: 0x3
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MAPPING_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          RW: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:5 pasid:32769, for process Xorg pid 932 thread Xorg:cs0 pid 933)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x800105a05000 from client 27
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00501031
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MORE_FAULTS: 0x1
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          WALKER_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          PERMISSION_FAULTS: 0x3
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MAPPING_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          RW: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:5 pasid:32769, for process Xorg pid 932 thread Xorg:cs0 pid 933)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x800105a06000 from client 27
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00501031
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MORE_FAULTS: 0x1
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          WALKER_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          PERMISSION_FAULTS: 0x3
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MAPPING_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          RW: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:5 pasid:32769, for process Xorg pid 932 thread Xorg:cs0 pid 933)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x800105a07000 from client 27
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00501031
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MORE_FAULTS: 0x1
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          WALKER_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          PERMISSION_FAULTS: 0x3
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MAPPING_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          RW: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:5 pasid:32769, for process Xorg pid 932 thread Xorg:cs0 pid 933)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x800105a00000 from client 27
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00501031
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MORE_FAULTS: 0x1
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          WALKER_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          PERMISSION_FAULTS: 0x3
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MAPPING_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          RW: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:5 pasid:32769, for process Xorg pid 932 thread Xorg:cs0 pid 933)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x800105a01000 from client 27
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00501031
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          Faulty UTCL2 client ID: TCP (0x8)
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MORE_FAULTS: 0x1
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          WALKER_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          PERMISSION_FAULTS: 0x3
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MAPPING_ERROR: 0x0
May 17 12:20:44 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          RW: 0x0
May 17 12:20:54 mainframe kernel: [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for fences timed out!
May 17 12:20:54 mainframe kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, but soft recovered
May 17 12:21:03 mainframe kernel: kauditd_printk_skb: 6 callbacks suppressed
May 17 12:21:03 mainframe kernel: audit: type=1100 audit(1621228863.858:162): pid=6767 uid=1000 auid=1000 ses=1 msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock acct="ketsui" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 12:21:03 mainframe kernel: audit: type=1101 audit(1621228863.858:163): pid=6767 uid=1000 auid=1000 ses=1 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 12:21:03 mainframe kernel: audit: type=1110 audit(1621228863.858:164): pid=6767 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 12:21:03 mainframe kernel: audit: type=1105 audit(1621228863.865:165): pid=6767 uid=1000 auid=1000 ses=1 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 12:44:44 mainframe kernel: audit: type=1334 audit(1621230284.233:166): prog-id=36 op=LOAD
May 17 12:44:44 mainframe kernel: audit: type=1334 audit(1621230284.233:167): prog-id=37 op=LOAD
May 17 12:44:44 mainframe kernel: audit: type=1334 audit(1621230284.233:168): prog-id=38 op=LOAD
May 17 12:44:44 mainframe kernel: audit: type=1130 audit(1621230284.266:169): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 12:45:14 mainframe kernel: audit: type=1131 audit(1621230314.353:170): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 12:45:14 mainframe kernel: audit: type=1334 audit(1621230314.556:171): prog-id=38 op=UNLOAD
May 17 12:45:14 mainframe kernel: audit: type=1334 audit(1621230314.556:172): prog-id=37 op=UNLOAD
May 17 12:45:14 mainframe kernel: audit: type=1334 audit(1621230314.556:173): prog-id=36 op=UNLOAD
May 17 12:58:24 mainframe kernel: audit: type=1334 audit(1621231104.475:174): prog-id=39 op=LOAD
May 17 12:58:24 mainframe kernel: audit: type=1334 audit(1621231104.475:175): prog-id=40 op=LOAD
May 17 12:58:24 mainframe kernel: audit: type=1334 audit(1621231104.475:176): prog-id=41 op=LOAD
May 17 12:58:24 mainframe kernel: audit: type=1130 audit(1621231104.505:177): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 12:58:54 mainframe kernel: audit: type=1131 audit(1621231134.555:178): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 12:58:54 mainframe kernel: audit: type=1334 audit(1621231134.712:179): prog-id=41 op=UNLOAD
May 17 12:58:54 mainframe kernel: audit: type=1334 audit(1621231134.712:180): prog-id=40 op=UNLOAD
May 17 12:58:54 mainframe kernel: audit: type=1334 audit(1621231134.712:181): prog-id=39 op=UNLOAD
May 17 13:08:50 mainframe kernel: audit: type=1106 audit(1621231730.839:182): pid=6767 uid=1000 auid=1000 ses=1 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:08:50 mainframe kernel: audit: type=1104 audit(1621231730.839:183): pid=6767 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:42:27 mainframe kernel: audit: type=1100 audit(1621233747.917:184): pid=8352 uid=1000 auid=1000 ses=1 msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock acct="ketsui" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:42:27 mainframe kernel: audit: type=1101 audit(1621233747.917:185): pid=8352 uid=1000 auid=1000 ses=1 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:42:27 mainframe kernel: audit: type=1110 audit(1621233747.920:186): pid=8352 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:42:27 mainframe kernel: audit: type=1105 audit(1621233747.923:187): pid=8352 uid=1000 auid=1000 ses=1 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:47:18 mainframe kernel: audit: type=1334 audit(1621234038.661:188): prog-id=31 op=UNLOAD
May 17 13:47:18 mainframe kernel: audit: type=1334 audit(1621234038.661:189): prog-id=29 op=UNLOAD
May 17 13:47:18 mainframe kernel: audit: type=1334 audit(1621234038.661:190): prog-id=28 op=UNLOAD
May 17 13:47:18 mainframe kernel: audit: type=1334 audit(1621234038.661:191): prog-id=27 op=UNLOAD
May 17 13:47:18 mainframe kernel: audit: type=1334 audit(1621234038.664:192): prog-id=22 op=UNLOAD
May 17 13:47:18 mainframe kernel: audit: type=1334 audit(1621234038.664:193): prog-id=21 op=UNLOAD
May 17 13:47:18 mainframe kernel: audit: type=1334 audit(1621234038.664:194): prog-id=20 op=UNLOAD
May 17 13:47:18 mainframe kernel: audit: type=1334 audit(1621234038.664:195): prog-id=30 op=UNLOAD
May 17 13:47:18 mainframe kernel: audit: type=1334 audit(1621234038.671:196): prog-id=26 op=UNLOAD
May 17 13:47:18 mainframe kernel: audit: type=1334 audit(1621234038.684:197): prog-id=25 op=UNLOAD
May 17 13:49:11 mainframe kernel: kauditd_printk_skb: 14 callbacks suppressed
May 17 13:49:11 mainframe kernel: audit: type=1106 audit(1621234151.432:212): pid=8352 uid=1000 auid=1000 ses=1 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:49:11 mainframe kernel: audit: type=1104 audit(1621234151.432:213): pid=8352 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:51:01 mainframe kernel: audit: type=1100 audit(1621234261.280:214): pid=15318 uid=1000 auid=1000 ses=1 msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock acct="ketsui" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:51:01 mainframe kernel: audit: type=1101 audit(1621234261.284:215): pid=15318 uid=1000 auid=1000 ses=1 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:51:01 mainframe kernel: audit: type=1110 audit(1621234261.284:216): pid=15318 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:51:01 mainframe kernel: audit: type=1105 audit(1621234261.287:217): pid=15318 uid=1000 auid=1000 ses=1 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:51:03 mainframe kernel: audit: type=1106 audit(1621234263.670:218): pid=15318 uid=1000 auid=1000 ses=1 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:51:03 mainframe kernel: audit: type=1104 audit(1621234263.670:219): pid=15318 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:52:17 mainframe kernel: audit: type=1326 audit(1621234337.846:220): auid=1000 uid=1000 gid=1000 ses=1 pid=19948 comm="file" exe="/usr/bin/file" sig=31 arch=c000003e syscall=68 compat=0 ip=0x7f709f0eb5db code=0x0
May 17 13:52:17 mainframe kernel: audit: type=1701 audit(1621234337.846:221): auid=1000 uid=1000 gid=1000 ses=1 pid=19948 comm="file" exe="/usr/bin/file" sig=31 res=1
May 17 13:52:20 mainframe kernel: audit: type=1101 audit(1621234340.163:222): pid=20211 uid=1000 auid=1000 ses=1 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:52:20 mainframe kernel: audit: type=1110 audit(1621234340.163:223): pid=20211 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:52:20 mainframe kernel: audit: type=1105 audit(1621234340.166:224): pid=20211 uid=1000 auid=1000 ses=1 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:52:22 mainframe kernel: audit: type=1106 audit(1621234342.429:225): pid=20211 uid=1000 auid=1000 ses=1 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:52:22 mainframe kernel: audit: type=1104 audit(1621234342.429:226): pid=20211 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:52:22 mainframe kernel: audit: type=1101 audit(1621234342.459:227): pid=20225 uid=1000 auid=1000 ses=1 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:52:22 mainframe kernel: audit: type=1110 audit(1621234342.459:228): pid=20225 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:52:22 mainframe kernel: audit: type=1105 audit(1621234342.466:229): pid=20225 uid=1000 auid=1000 ses=1 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:52:23 mainframe kernel: audit: type=1106 audit(1621234343.839:230): pid=20225 uid=1000 auid=1000 ses=1 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:52:23 mainframe kernel: audit: type=1104 audit(1621234343.843:231): pid=20225 uid=1000 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
May 17 13:52:30 mainframe kernel: audit: type=1131 audit(1621234350.596:232): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dnscrypt-proxy comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 13:52:30 mainframe kernel: audit: type=1131 audit(1621234350.599:233): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=sshd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 13:52:30 mainframe kernel: audit: type=1131 audit(1621234350.599:234): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=rtkit-daemon comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 13:52:30 mainframe kernel: audit: type=1131 audit(1621234350.599:235): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=lm_sensors comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 13:52:30 mainframe kernel: audit: type=1131 audit(1621234350.612:236): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=polkit comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 13:52:30 mainframe kernel: audit: type=1131 audit(1621234350.612:237): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-shutdown comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 13:52:30 mainframe kernel: audit: type=1334 audit(1621234350.619:238): prog-id=49 op=UNLOAD
May 17 13:52:31 mainframe kernel: audit: type=1131 audit(1621234350.899:239): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=udisks2 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 17 13:52:31 mainframe kernel: audit: type=1104 audit(1621234351.972:240): pid=883 uid=0 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_securetty,pam_shells,pam_faillock,pam_permit,pam_faillock acct="ketsui" exe="/usr/bin/login" hostname=mainframe addr=? terminal=/dev/tty1 res=success'
May 17 13:52:31 mainframe kernel: audit: type=1106 audit(1621234351.972:241): pid=883 uid=0 auid=1000 ses=1 msg='op=PAM:session_close grantors=pam_loginuid,pam_keyinit,pam_limits,pam_unix,pam_permit,pam_mail,pam_systemd,pam_env acct="ketsui" exe="/usr/bin/login" hostname=mainframe addr=? terminal=/dev/tty1 res=success'
May 17 13:52:35 mainframe kernel: watchdog: watchdog0: watchdog did not stop!
May 17 13:52:35 mainframe systemd-shutdown[1]: Syncing filesystems and block devices.
May 17 13:52:35 mainframe systemd-shutdown[1]: Sending SIGTERM to remaining processes...

--+a9ZkNVvEAjfb4BR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=amdgpu_hang_5

-- Journal begins at Sat 2020-01-04 17:51:21 WIB, ends at Mon 2021-05-31 12:02:22 WIB. --
May 31 07:53:06 mainframe kernel: scsi host6: ahci
May 31 07:53:06 mainframe kernel: scsi host7: ahci
May 31 07:53:06 mainframe kernel: ata1: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80100 irq 39
May 31 07:53:06 mainframe kernel: ata2: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80180 irq 39
May 31 07:53:06 mainframe kernel: ata3: DUMMY
May 31 07:53:06 mainframe kernel: ata4: DUMMY
May 31 07:53:06 mainframe kernel: ata5: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80300 irq 39
May 31 07:53:06 mainframe kernel: ata6: SATA max UDMA/133 abar m131072@0xfce80000 port 0xfce80380 irq 39
May 31 07:53:06 mainframe kernel: ata7: DUMMY
May 31 07:53:06 mainframe kernel: ata8: DUMMY
May 31 07:53:06 mainframe kernel: ahci 0000:09:00.0: AHCI 0001.0301 32 slots 1 ports 6 Gbps 0x2 impl SATA mode
May 31 07:53:06 mainframe kernel: ahci 0000:09:00.0: flags: 64bit ncq sntf ilck pm led clo only pmp fbs pio slum part 
May 31 07:53:06 mainframe kernel: scsi host8: ahci
May 31 07:53:06 mainframe kernel: scsi host9: ahci
May 31 07:53:06 mainframe kernel: ata9: DUMMY
May 31 07:53:06 mainframe kernel: ata10: SATA max UDMA/133 abar m2048@0xfcf00000 port 0xfcf00180 irq 42
May 31 07:53:06 mainframe kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
May 31 07:53:06 mainframe kernel: ehci-pci: EHCI PCI platform driver
May 31 07:53:06 mainframe kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
May 31 07:53:06 mainframe kernel: ohci-pci: OHCI PCI platform driver
May 31 07:53:06 mainframe kernel: uhci_hcd: USB Universal Host Controller Interface driver
May 31 07:53:06 mainframe kernel: usbcore: registered new interface driver usbserial_generic
May 31 07:53:06 mainframe kernel: usbserial: USB Serial support registered for generic
May 31 07:53:06 mainframe kernel: rtc_cmos 00:02: RTC can wake from S4
May 31 07:53:06 mainframe kernel: rtc_cmos 00:02: registered as rtc0
May 31 07:53:06 mainframe kernel: rtc_cmos 00:02: setting system clock to 2021-05-31T00:53:04 UTC (1622422384)
May 31 07:53:06 mainframe kernel: rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
May 31 07:53:06 mainframe kernel: ledtrig-cpu: registered to indicate activity on CPUs
May 31 07:53:06 mainframe kernel: hid: raw HID events driver (C) Jiri Kosina
May 31 07:53:06 mainframe kernel: drop_monitor: Initializing network drop monitor service
May 31 07:53:06 mainframe kernel: Initializing XFRM netlink socket
May 31 07:53:06 mainframe kernel: NET: Registered protocol family 10
May 31 07:53:06 mainframe kernel: Segment Routing with IPv6
May 31 07:53:06 mainframe kernel: RPL Segment Routing with IPv6
May 31 07:53:06 mainframe kernel: NET: Registered protocol family 17
May 31 07:53:06 mainframe kernel: microcode: CPU0: patch_level=0x08108109
May 31 07:53:06 mainframe kernel: microcode: CPU1: patch_level=0x08108109
May 31 07:53:06 mainframe kernel: microcode: CPU2: patch_level=0x08108109
May 31 07:53:06 mainframe kernel: microcode: CPU3: patch_level=0x08108109
May 31 07:53:06 mainframe kernel: microcode: Microcode Update Driver: v2.2.
May 31 07:53:06 mainframe kernel: IPI shorthand broadcast: enabled
May 31 07:53:06 mainframe kernel: sched_clock: Marking stable (329193452, 391903)->(331605848, -2020493)
May 31 07:53:06 mainframe kernel: registered taskstats version 1
May 31 07:53:06 mainframe kernel: Loading compiled-in X.509 certificates
May 31 07:53:06 mainframe kernel: Loaded X.509 cert 'Build time autogenerated kernel key: f78d562a8f743e7d553d7ee61fcc9e5c97f478f3'
May 31 07:53:06 mainframe kernel: zswap: loaded using pool lz4/z3fold
May 31 07:53:06 mainframe kernel: Key type ._fscrypt registered
May 31 07:53:06 mainframe kernel: Key type .fscrypt registered
May 31 07:53:06 mainframe kernel: Key type fscrypt-provisioning registered
May 31 07:53:06 mainframe kernel: PM:   Magic number: 5:659:861
May 31 07:53:06 mainframe kernel: RAS: Correctable Errors collector initialized.
May 31 07:53:06 mainframe kernel: ata1: SATA link down (SStatus 0 SControl 300)
May 31 07:53:06 mainframe kernel: ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 31 07:53:06 mainframe kernel: ata10.00: ATA-9: V-GEN08SM20AR128GBM2SDK, S0807A0, max UDMA/133
May 31 07:53:06 mainframe kernel: ata10.00: 250069680 sectors, multi 1: LBA48 NCQ (depth 32), AA
May 31 07:53:06 mainframe kernel: ata10.00: configured for UDMA/133
May 31 07:53:06 mainframe kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 31 07:53:06 mainframe kernel: ata2.00: ATA-11: Patriot Burst, SBFME1.3, max UDMA/133
May 31 07:53:06 mainframe kernel: ata2.00: 468862128 sectors, multi 16: LBA48 NCQ (depth 32), AA
May 31 07:53:06 mainframe kernel: ata2.00: configured for UDMA/133
May 31 07:53:06 mainframe kernel: scsi 1:0:0:0: Direct-Access     ATA      Patriot Burst    E1.3 PQ: 0 ANSI: 5
May 31 07:53:06 mainframe kernel: sd 1:0:0:0: [sda] 468862128 512-byte logical blocks: (240 GB/224 GiB)
May 31 07:53:06 mainframe kernel: sd 1:0:0:0: [sda] Write Protect is off
May 31 07:53:06 mainframe kernel: sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
May 31 07:53:06 mainframe kernel: sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 31 07:53:06 mainframe kernel:  sda: sda1 sda2 sda3 sda4 sda5
May 31 07:53:06 mainframe kernel: sd 1:0:0:0: [sda] Attached SCSI disk
May 31 07:53:06 mainframe kernel: tsc: Refined TSC clocksource calibration: 3593.234 MHz
May 31 07:53:06 mainframe kernel: clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33cb5bcd94d, max_idle_ns: 440795284310 ns
May 31 07:53:06 mainframe kernel: clocksource: Switched to clocksource tsc
May 31 07:53:06 mainframe kernel: ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 31 07:53:06 mainframe kernel: ata5.00: ATA-8: HGST HTS545050A7E680, GG2OAF10, max UDMA/133
May 31 07:53:06 mainframe kernel: ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 32), AA
May 31 07:53:06 mainframe kernel: ata5.00: configured for UDMA/133
May 31 07:53:06 mainframe kernel: scsi 4:0:0:0: Direct-Access     ATA      HGST HTS545050A7 AF10 PQ: 0 ANSI: 5
May 31 07:53:06 mainframe kernel: sd 4:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
May 31 07:53:06 mainframe kernel: sd 4:0:0:0: [sdb] 4096-byte physical blocks
May 31 07:53:06 mainframe kernel: sd 4:0:0:0: [sdb] Write Protect is off
May 31 07:53:06 mainframe kernel: sd 4:0:0:0: [sdb] Mode Sense: 00 3a 00 00
May 31 07:53:06 mainframe kernel: sd 4:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 31 07:53:06 mainframe kernel:  sdb: sdb1 sdb2
May 31 07:53:06 mainframe kernel: sd 4:0:0:0: [sdb] Attached SCSI disk
May 31 07:53:06 mainframe kernel: ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
May 31 07:53:06 mainframe kernel: ata6.00: ATA-8: ST3160316CS, SC13, max UDMA/133
May 31 07:53:06 mainframe kernel: ata6.00: 312581808 sectors, multi 16: LBA48 NCQ (depth 32)
May 31 07:53:06 mainframe kernel: ata6.00: configured for UDMA/133
May 31 07:53:06 mainframe kernel: scsi 5:0:0:0: Direct-Access     ATA      ST3160316CS      SC13 PQ: 0 ANSI: 5
May 31 07:53:06 mainframe kernel: sd 5:0:0:0: [sdc] 312581808 512-byte logical blocks: (160 GB/149 GiB)
May 31 07:53:06 mainframe kernel: sd 5:0:0:0: [sdc] Write Protect is off
May 31 07:53:06 mainframe kernel: sd 5:0:0:0: [sdc] Mode Sense: 00 3a 00 00
May 31 07:53:06 mainframe kernel: sd 5:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 31 07:53:06 mainframe kernel: scsi 9:0:0:0: Direct-Access     ATA      V-GEN08SM20AR128 7A0  PQ: 0 ANSI: 5
May 31 07:53:06 mainframe kernel: sd 9:0:0:0: [sdd] 250069680 512-byte logical blocks: (128 GB/119 GiB)
May 31 07:53:06 mainframe kernel: sd 9:0:0:0: [sdd] Write Protect is off
May 31 07:53:06 mainframe kernel: sd 9:0:0:0: [sdd] Mode Sense: 00 3a 00 00
May 31 07:53:06 mainframe kernel: sd 9:0:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
May 31 07:53:06 mainframe kernel:  sdd: sdd1
May 31 07:53:06 mainframe kernel:  sdc: sdc1
May 31 07:53:06 mainframe kernel: sd 5:0:0:0: [sdc] Attached SCSI disk
May 31 07:53:06 mainframe kernel: sd 9:0:0:0: [sdd] Attached SCSI disk
May 31 07:53:06 mainframe kernel: Freeing unused decrypted memory: 2036K
May 31 07:53:06 mainframe kernel: Freeing unused kernel image (initmem) memory: 1652K
May 31 07:53:06 mainframe kernel: Write protecting the kernel read-only data: 26624k
May 31 07:53:06 mainframe kernel: Freeing unused kernel image (text/rodata gap) memory: 2036K
May 31 07:53:06 mainframe kernel: Freeing unused kernel image (rodata/data gap) memory: 1252K
May 31 07:53:06 mainframe kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
May 31 07:53:06 mainframe kernel: rodata_test: all tests were successful
May 31 07:53:06 mainframe kernel: Run /init as init process
May 31 07:53:06 mainframe kernel:   with arguments:
May 31 07:53:06 mainframe kernel:     /init
May 31 07:53:06 mainframe kernel:   with environment:
May 31 07:53:06 mainframe kernel:     HOME=/
May 31 07:53:06 mainframe kernel:     TERM=linux
May 31 07:53:06 mainframe kernel: random: crng init done
May 31 07:53:06 mainframe systemd[1]: Successfully credited entropy passed from boot loader.
May 31 07:53:06 mainframe systemd[1]: systemd 248.3-2-arch running in system mode. (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
May 31 07:53:06 mainframe systemd[1]: Detected architecture x86-64.
May 31 07:53:06 mainframe systemd[1]: Running in initial RAM disk.
May 31 07:53:06 mainframe kernel: fbcon: Taking over console
May 31 07:53:06 mainframe systemd[1]: Hostname set to <mainframe>.
May 31 07:53:06 mainframe kernel: Console: switching to colour frame buffer device 240x67
May 31 07:53:06 mainframe systemd[1]: Queued start job for default target Initrd Default Target.
May 31 07:53:06 mainframe systemd[1]: Created slice system-systemd\x2dcryptsetup.slice.
May 31 07:53:06 mainframe systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
May 31 07:53:06 mainframe systemd[1]: Reached target Local File Systems.
May 31 07:53:06 mainframe systemd[1]: Reached target Paths.
May 31 07:53:06 mainframe systemd[1]: Reached target Slices.
May 31 07:53:06 mainframe systemd[1]: Reached target Swap.
May 31 07:53:06 mainframe systemd[1]: Reached target Timers.
May 31 07:53:06 mainframe systemd[1]: Listening on Journal Audit Socket.
May 31 07:53:06 mainframe systemd[1]: Listening on Journal Socket (/dev/log).
May 31 07:53:06 mainframe systemd[1]: Listening on Journal Socket.
May 31 07:53:06 mainframe systemd[1]: Listening on udev Control Socket.
May 31 07:53:06 mainframe systemd[1]: Listening on udev Kernel Socket.
May 31 07:53:06 mainframe systemd[1]: Reached target Sockets.
May 31 07:53:06 mainframe systemd[1]: Starting Create list of static device nodes for the current kernel...
May 31 07:53:06 mainframe systemd[1]: Starting Journal Service...
May 31 07:53:06 mainframe systemd[1]: Starting Load Kernel Modules...
May 31 07:53:06 mainframe systemd[1]: Starting Setup Virtual Console...
May 31 07:53:06 mainframe systemd[1]: Finished Create list of static device nodes for the current kernel.
May 31 07:53:06 mainframe systemd[1]: Starting Create Static Device Nodes in /dev...
May 31 07:53:06 mainframe systemd[1]: Finished Setup Virtual Console.
May 31 07:53:06 mainframe systemd[1]: Condition check resulted in dracut ask for additional cmdline parameters being skipped.
May 31 07:53:06 mainframe kernel: Asymmetric key parser 'pkcs8' registered
May 31 07:53:06 mainframe systemd[1]: Starting dracut cmdline hook...
May 31 07:53:06 mainframe systemd[1]: Finished Load Kernel Modules.
May 31 07:53:06 mainframe kernel: audit: type=1130 audit(1622422386.414:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:06 mainframe systemd[1]: Finished Create Static Device Nodes in /dev.
May 31 07:53:06 mainframe kernel: audit: type=1130 audit(1622422386.414:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup-dev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:06 mainframe systemd[1]: Starting Apply Kernel Variables...
May 31 07:53:06 mainframe systemd[1]: Finished Apply Kernel Variables.
May 31 07:53:06 mainframe kernel: audit: type=1130 audit(1622422386.417:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:06 mainframe systemd[1]: Started Journal Service.
May 31 07:53:06 mainframe kernel: audit: type=1130 audit(1622422386.441:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:06 mainframe kernel: audit: type=1130 audit(1622422386.444:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:06 mainframe kernel: audit: type=1130 audit(1622422386.447:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:06 mainframe kernel: device-mapper: uevent: version 1.0.3
May 31 07:53:06 mainframe kernel: device-mapper: ioctl: 4.44.0-ioctl (2021-02-01) initialised: dm-devel@redhat.com
May 31 07:53:06 mainframe kernel: audit: type=1130 audit(1622422386.477:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:06 mainframe kernel: audit: type=1334 audit(1622422386.477:9): prog-id=6 op=LOAD
May 31 07:53:06 mainframe kernel: audit: type=1334 audit(1622422386.477:10): prog-id=7 op=LOAD
May 31 07:53:06 mainframe kernel: ACPI: video: Video Device [VGA1] (multi-head: yes  rom: no  post: no)
May 31 07:53:06 mainframe kernel: ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GP17.VGA.LCD._BCM.AFN7], AE_NOT_FOUND (20210105/psargs-330)
May 31 07:53:06 mainframe kernel: ACPI Error: Aborting method \_SB.PCI0.GP17.VGA.LCD._BCM due to previous error (AE_NOT_FOUND) (20210105/psparse-529)
May 31 07:53:06 mainframe kernel: ACPI: \_SB_.PCI0.GP17.VGA_.LCD_: _BCM evaluation failed
May 31 07:53:06 mainframe kernel: input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:0f/LNXVIDEO:01/input/input2
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:01:00.0: xHCI Host Controller
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
May 31 07:53:06 mainframe kernel: cryptd: max_cpu_qlen set to 1000
May 31 07:53:06 mainframe kernel: ccp 0000:08:00.2: enabling device (0000 -> 0002)
May 31 07:53:06 mainframe kernel: AVX2 version of gcm_enc/dec engaged.
May 31 07:53:06 mainframe kernel: AES CTR mode by8 optimization enabled
May 31 07:53:06 mainframe kernel: ccp 0000:08:00.2: ccp enabled
May 31 07:53:06 mainframe kernel: ccp 0000:08:00.2: psp: unable to access the device: you might be running a broken BIOS.
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:01:00.0: hcc params 0x0200ef81 hci version 0x110 quirks 0x0000000000000410
May 31 07:53:06 mainframe kernel: usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.12
May 31 07:53:06 mainframe kernel: usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 31 07:53:06 mainframe kernel: usb usb1: Product: xHCI Host Controller
May 31 07:53:06 mainframe kernel: usb usb1: Manufacturer: Linux 5.12.8-arch1-1 xhci-hcd
May 31 07:53:06 mainframe kernel: usb usb1: SerialNumber: 0000:01:00.0
May 31 07:53:06 mainframe kernel: hub 1-0:1.0: USB hub found
May 31 07:53:06 mainframe kernel: hub 1-0:1.0: 10 ports detected
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:01:00.0: xHCI Host Controller
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 2
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:01:00.0: Host supports USB 3.1 Enhanced SuperSpeed
May 31 07:53:06 mainframe kernel: usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
May 31 07:53:06 mainframe kernel: usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.12
May 31 07:53:06 mainframe kernel: usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 31 07:53:06 mainframe kernel: usb usb2: Product: xHCI Host Controller
May 31 07:53:06 mainframe kernel: usb usb2: Manufacturer: Linux 5.12.8-arch1-1 xhci-hcd
May 31 07:53:06 mainframe kernel: usb usb2: SerialNumber: 0000:01:00.0
May 31 07:53:06 mainframe kernel: hub 2-0:1.0: USB hub found
May 31 07:53:06 mainframe kernel: hub 2-0:1.0: 4 ports detected
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.3: xHCI Host Controller
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus number 3
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000840000410
May 31 07:53:06 mainframe kernel: usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.12
May 31 07:53:06 mainframe kernel: usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 31 07:53:06 mainframe kernel: usb usb3: Product: xHCI Host Controller
May 31 07:53:06 mainframe kernel: usb usb3: Manufacturer: Linux 5.12.8-arch1-1 xhci-hcd
May 31 07:53:06 mainframe kernel: usb usb3: SerialNumber: 0000:08:00.3
May 31 07:53:06 mainframe kernel: hub 3-0:1.0: USB hub found
May 31 07:53:06 mainframe kernel: hub 3-0:1.0: 4 ports detected
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.3: xHCI Host Controller
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.3: new USB bus registered, assigned bus number 4
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.3: Host supports USB 3.1 Enhanced SuperSpeed
May 31 07:53:06 mainframe kernel: usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
May 31 07:53:06 mainframe kernel: usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.12
May 31 07:53:06 mainframe kernel: usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 31 07:53:06 mainframe kernel: usb usb4: Product: xHCI Host Controller
May 31 07:53:06 mainframe kernel: usb usb4: Manufacturer: Linux 5.12.8-arch1-1 xhci-hcd
May 31 07:53:06 mainframe kernel: usb usb4: SerialNumber: 0000:08:00.3
May 31 07:53:06 mainframe kernel: hub 4-0:1.0: USB hub found
May 31 07:53:06 mainframe kernel: hub 4-0:1.0: 4 ports detected
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.4: xHCI Host Controller
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus number 5
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000840000410
May 31 07:53:06 mainframe kernel: usb usb5: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.12
May 31 07:53:06 mainframe kernel: usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 31 07:53:06 mainframe kernel: usb usb5: Product: xHCI Host Controller
May 31 07:53:06 mainframe kernel: usb usb5: Manufacturer: Linux 5.12.8-arch1-1 xhci-hcd
May 31 07:53:06 mainframe kernel: usb usb5: SerialNumber: 0000:08:00.4
May 31 07:53:06 mainframe kernel: hub 5-0:1.0: USB hub found
May 31 07:53:06 mainframe kernel: hub 5-0:1.0: 1 port detected
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.4: xHCI Host Controller
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.4: new USB bus registered, assigned bus number 6
May 31 07:53:06 mainframe kernel: xhci_hcd 0000:08:00.4: Host supports USB 3.1 Enhanced SuperSpeed
May 31 07:53:06 mainframe kernel: usb usb6: We don't know the algorithms for LPM for this host, disabling LPM.
May 31 07:53:06 mainframe kernel: usb usb6: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.12
May 31 07:53:06 mainframe kernel: usb usb6: New USB device strings: Mfr=3, Product=2, SerialNumber=1
May 31 07:53:06 mainframe kernel: usb usb6: Product: xHCI Host Controller
May 31 07:53:06 mainframe kernel: usb usb6: Manufacturer: Linux 5.12.8-arch1-1 xhci-hcd
May 31 07:53:06 mainframe kernel: usb usb6: SerialNumber: 0000:08:00.4
May 31 07:53:06 mainframe kernel: hub 6-0:1.0: USB hub found
May 31 07:53:06 mainframe kernel: hub 6-0:1.0: 1 port detected
May 31 07:53:06 mainframe kernel: usb 3-2: new high-speed USB device number 2 using xhci_hcd
May 31 07:53:07 mainframe kernel: usb 1-5: new full-speed USB device number 2 using xhci_hcd
May 31 07:53:07 mainframe kernel: usb 3-2: New USB device found, idVendor=0b05, idProduct=7770, bcdDevice= 4.04
May 31 07:53:07 mainframe kernel: usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
May 31 07:53:07 mainframe kernel: usb 3-2: Product: SDM636-QRD _SN:0BED088B
May 31 07:53:07 mainframe kernel: usb 3-2: Manufacturer: asus
May 31 07:53:07 mainframe kernel: usb 3-2: SerialNumber: J6AXGF03H233HBA
May 31 07:53:07 mainframe kernel: usb 1-5: New USB device found, idVendor=046d, idProduct=c534, bcdDevice=29.01
May 31 07:53:07 mainframe kernel: usb 1-5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
May 31 07:53:07 mainframe kernel: usb 1-5: Product: USB Receiver
May 31 07:53:07 mainframe kernel: usb 1-5: Manufacturer: Logitech
May 31 07:53:07 mainframe kernel: input: Logitech USB Receiver as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.0/0003:046D:C534.0001/input/input3
May 31 07:53:07 mainframe kernel: hid-generic 0003:046D:C534.0001: input,hidraw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:01:00.0-5/input0
May 31 07:53:07 mainframe kernel: input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.1/0003:046D:C534.0002/input/input4
May 31 07:53:07 mainframe kernel: input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.1/0003:046D:C534.0002/input/input5
May 31 07:53:07 mainframe kernel: input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.1/0003:046D:C534.0002/input/input6
May 31 07:53:07 mainframe kernel: hid-generic 0003:046D:C534.0002: input,hiddev96,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:01:00.0-5/input1
May 31 07:53:07 mainframe kernel: usbcore: registered new interface driver usbhid
May 31 07:53:07 mainframe kernel: usbhid: USB HID core driver
May 31 07:53:07 mainframe kernel: usb 1-8: new low-speed USB device number 3 using xhci_hcd
May 31 07:53:07 mainframe kernel: logitech-djreceiver 0003:046D:C534.0001: hidraw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:01:00.0-5/input0
May 31 07:53:07 mainframe kernel: logitech-djreceiver 0003:046D:C534.0002: hiddev96,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:01:00.0-5/input1
May 31 07:53:07 mainframe kernel: usb 1-8: New USB device found, idVendor=1c4f, idProduct=0002, bcdDevice= 1.10
May 31 07:53:07 mainframe kernel: usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=0
May 31 07:53:07 mainframe kernel: usb 1-8: Product: USB Keyboard
May 31 07:53:07 mainframe kernel: usb 1-8: Manufacturer: SIGMACHIP
May 31 07:53:07 mainframe kernel: input: SIGMACHIP USB Keyboard as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-8/1-8:1.0/0003:1C4F:0002.0003/input/input9
May 31 07:53:08 mainframe kernel: logitech-djreceiver 0003:046D:C534.0002: device of type eQUAD nano Lite (0x0a) connected on slot 2
May 31 07:53:08 mainframe kernel: input: Logitech Wireless Mouse PID:4054 Mouse as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.1/0003:046D:C534.0002/0003:046D:4054.0004/input/input10
May 31 07:53:08 mainframe kernel: hid-generic 0003:1C4F:0002.0003: input,hidraw2: USB HID v1.10 Keyboard [SIGMACHIP USB Keyboard] on usb-0000:01:00.0-8/input0
May 31 07:53:08 mainframe kernel: hid-generic 0003:046D:4054.0004: input,hidraw3: USB HID v1.11 Mouse [Logitech Wireless Mouse PID:4054] on usb-0000:01:00.0-5/input1:2
May 31 07:53:08 mainframe kernel: input: SIGMACHIP USB Keyboard Consumer Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-8/1-8:1.1/0003:1C4F:0002.0005/input/input14
May 31 07:53:08 mainframe kernel: input: SIGMACHIP USB Keyboard System Control as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-8/1-8:1.1/0003:1C4F:0002.0005/input/input15
May 31 07:53:08 mainframe kernel: hid-generic 0003:1C4F:0002.0005: input,hidraw3: USB HID v1.10 Device [SIGMACHIP USB Keyboard] on usb-0000:01:00.0-8/input1
May 31 07:53:08 mainframe kernel: logitech-hidpp-device 0003:046D:4054.0004: HID++ 4.5 device connected.
May 31 07:53:09 mainframe kernel: input: Logitech Wireless Mouse as /devices/pci0000:00/0000:00:01.2/0000:01:00.0/usb1/1-5/1-5:1.1/0003:046D:C534.0002/0003:046D:4054.0004/input/input16
May 31 07:53:09 mainframe kernel: logitech-hidpp-device 0003:046D:4054.0004: input,hidraw4: USB HID v1.11 Mouse [Logitech Wireless Mouse] on usb-0000:01:00.0-5/input1:2
May 31 07:53:14 mainframe kernel: Key type encrypted registered
May 31 07:53:14 mainframe kernel: kauditd_printk_skb: 4 callbacks suppressed
May 31 07:53:14 mainframe kernel: audit: type=1130 audit(1622422394.951:15): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-cryptsetup@cryptroot comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:15 mainframe kernel: audit: type=1130 audit(1622422395.127:16): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:15 mainframe kernel: audit: type=1130 audit(1622422395.141:17): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:15 mainframe kernel: F2FS-fs (dm-0): Mounted with checkpoint version = 1a1f2058
May 31 07:53:15 mainframe kernel: audit: type=1334 audit(1622422395.641:18): prog-id=5 op=UNLOAD
May 31 07:53:15 mainframe kernel: audit: type=1334 audit(1622422395.641:19): prog-id=4 op=UNLOAD
May 31 07:53:15 mainframe kernel: audit: type=1334 audit(1622422395.641:20): prog-id=3 op=UNLOAD
May 31 07:53:15 mainframe kernel: audit: type=1334 audit(1622422395.641:21): prog-id=8 op=UNLOAD
May 31 07:53:15 mainframe kernel: audit: type=1334 audit(1622422395.641:22): prog-id=7 op=UNLOAD
May 31 07:53:15 mainframe kernel: audit: type=1334 audit(1622422395.641:23): prog-id=6 op=UNLOAD
May 31 07:53:15 mainframe kernel: audit: type=1334 audit(1622422395.731:24): prog-id=9 op=LOAD
May 31 07:53:17 mainframe systemd-journald[183]: Received SIGTERM from PID 1 (systemd).
May 31 07:53:17 mainframe systemd[1]: systemd 248.3-2-arch running in system mode. (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
May 31 07:53:17 mainframe systemd[1]: Detected architecture x86-64.
May 31 07:53:17 mainframe systemd[1]: initrd-switch-root.service: Deactivated successfully.
May 31 07:53:17 mainframe systemd[1]: Stopped Switch Root.
May 31 07:53:17 mainframe systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
May 31 07:53:17 mainframe systemd[1]: Created slice system-getty.slice.
May 31 07:53:17 mainframe systemd[1]: Created slice system-modprobe.slice.
May 31 07:53:17 mainframe systemd[1]: Created slice system-systemd\x2dfsck.slice.
May 31 07:53:17 mainframe systemd[1]: Created slice User and Session Slice.
May 31 07:53:17 mainframe systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
May 31 07:53:17 mainframe systemd[1]: Started Forward Password Requests to Wall Directory Watch.
May 31 07:53:17 mainframe systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
May 31 07:53:17 mainframe systemd[1]: Reached target Local Encrypted Volumes.
May 31 07:53:17 mainframe systemd[1]: Stopped target Switch Root.
May 31 07:53:17 mainframe systemd[1]: Stopped target Initrd File Systems.
May 31 07:53:17 mainframe systemd[1]: Stopped target Initrd Root File System.
May 31 07:53:17 mainframe systemd[1]: Reached target Paths.
May 31 07:53:17 mainframe systemd[1]: Reached target Remote File Systems.
May 31 07:53:17 mainframe systemd[1]: Reached target Slices.
May 31 07:53:17 mainframe systemd[1]: Reached target Local Verity Integrity Protected Volumes.
May 31 07:53:17 mainframe systemd[1]: Listening on Device-mapper event daemon FIFOs.
May 31 07:53:17 mainframe systemd[1]: Listening on LVM2 poll daemon socket.
May 31 07:53:17 mainframe systemd[1]: Listening on Process Core Dump Socket.
May 31 07:53:17 mainframe systemd[1]: Listening on udev Control Socket.
May 31 07:53:17 mainframe systemd[1]: Listening on udev Kernel Socket.
May 31 07:53:17 mainframe systemd[1]: Mounting Huge Pages File System...
May 31 07:53:17 mainframe systemd[1]: Mounting POSIX Message Queue File System...
May 31 07:53:17 mainframe systemd[1]: Mounting Kernel Debug File System...
May 31 07:53:17 mainframe systemd[1]: Mounting Kernel Trace File System...
May 31 07:53:17 mainframe systemd[1]: Starting Create list of static device nodes for the current kernel...
May 31 07:53:17 mainframe systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
May 31 07:53:17 mainframe systemd[1]: Starting Load Kernel Module configfs...
May 31 07:53:17 mainframe systemd[1]: Starting Load Kernel Module drm...
May 31 07:53:17 mainframe systemd[1]: Starting Load Kernel Module fuse...
May 31 07:53:17 mainframe systemd[1]: systemd-cryptsetup@cryptroot.service: Deactivated successfully.
May 31 07:53:17 mainframe systemd[1]: Stopped systemd-cryptsetup@cryptroot.service.
May 31 07:53:17 mainframe systemd[1]: Stopped Journal Service.
May 31 07:53:17 mainframe systemd[1]: Starting Journal Service...
May 31 07:53:17 mainframe kernel: Linux agpgart interface v0.103
May 31 07:53:17 mainframe kernel: fuse: init (API version 7.33)
May 31 07:53:17 mainframe systemd[1]: Starting Load Kernel Modules...
May 31 07:53:17 mainframe systemd[1]: Starting Remount Root and Kernel File Systems...
May 31 07:53:17 mainframe systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
May 31 07:53:17 mainframe systemd[1]: Starting Coldplug All udev Devices...
May 31 07:53:17 mainframe systemd[1]: sysroot.mount: Deactivated successfully.
May 31 07:53:17 mainframe systemd[1]: Mounted Huge Pages File System.
May 31 07:53:17 mainframe systemd[1]: Mounted POSIX Message Queue File System.
May 31 07:53:17 mainframe systemd[1]: Mounted Kernel Debug File System.
May 31 07:53:17 mainframe systemd[1]: Mounted Kernel Trace File System.
May 31 07:53:17 mainframe systemd[1]: Started Journal Service.
May 31 07:53:18 mainframe kernel: Adding 2097148k swap on /swap.  Priority:-2 extents:3 across:51494424k SSFS
May 31 07:53:18 mainframe kernel: acpi_cpufreq: overriding BIOS provided _PSD data
May 31 07:53:18 mainframe kernel: piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
May 31 07:53:18 mainframe kernel: piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
May 31 07:53:18 mainframe kernel: piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
May 31 07:53:18 mainframe kernel: sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
May 31 07:53:18 mainframe kernel: sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
May 31 07:53:18 mainframe kernel: sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
May 31 07:53:18 mainframe kernel: input: PC Speaker as /devices/platform/pcspkr/input/input17
May 31 07:53:18 mainframe kernel: RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
May 31 07:53:18 mainframe kernel: RAPL PMU: hw unit of domain package 2^-16 Joules
May 31 07:53:18 mainframe kernel: mousedev: PS/2 mouse device common for all mice
May 31 07:53:18 mainframe kernel: libphy: r8169: probed
May 31 07:53:18 mainframe kernel: r8169 0000:07:00.0 eth0: RTL8168h/8111h, 70:85:c2:c6:3b:6c, XID 541, IRQ 62
May 31 07:53:18 mainframe kernel: r8169 0000:07:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
May 31 07:53:18 mainframe kernel: r8169 0000:07:00.0 enp7s0: renamed from eth0
May 31 07:53:18 mainframe kernel: snd_hda_intel 0000:08:00.1: enabling device (0000 -> 0002)
May 31 07:53:18 mainframe kernel: snd_hda_intel 0000:08:00.6: enabling device (0000 -> 0002)
May 31 07:53:18 mainframe kernel: kvm: Nested Virtualization enabled
May 31 07:53:18 mainframe kernel: SVM: kvm: Nested Paging enabled
May 31 07:53:18 mainframe kernel: SVM: Virtual VMLOAD VMSAVE supported
May 31 07:53:18 mainframe kernel: SVM: Virtual GIF supported
May 31 07:53:18 mainframe kernel: input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card0/input18
May 31 07:53:18 mainframe kernel: input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card0/input19
May 31 07:53:18 mainframe kernel: input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:08:00.1/sound/card0/input20
May 31 07:53:18 mainframe kernel: MCE: In-kernel MCE decoding enabled.
May 31 07:53:18 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC887-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
May 31 07:53:18 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
May 31 07:53:18 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
May 31 07:53:18 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
May 31 07:53:18 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:    inputs:
May 31 07:53:18 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:      Front Mic=0x19
May 31 07:53:18 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
May 31 07:53:18 mainframe kernel: snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
May 31 07:53:18 mainframe kernel: input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input21
May 31 07:53:18 mainframe kernel: input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input22
May 31 07:53:18 mainframe kernel: input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input23
May 31 07:53:18 mainframe kernel: input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input24
May 31 07:53:18 mainframe kernel: input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:08:00.6/sound/card1/input25
May 31 07:53:18 mainframe kernel: intel_rapl_common: Found RAPL domain package
May 31 07:53:18 mainframe kernel: intel_rapl_common: Found RAPL domain core
May 31 07:53:18 mainframe kernel: [drm] amdgpu kernel modesetting enabled.
May 31 07:53:18 mainframe kernel: amdgpu: Topology: Add APU node [0x0:0x0]
May 31 07:53:18 mainframe kernel: checking generic (e0000000 7e9000) vs hw (e0000000 10000000)
May 31 07:53:18 mainframe kernel: fb0: switching to amdgpudrmfb from EFI VGA
May 31 07:53:18 mainframe kernel: Console: switching to colour dummy device 80x25
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: vgaarb: deactivate vga console
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: enabling device (0006 -> 0007)
May 31 07:53:18 mainframe kernel: [drm] initializing kernel modesetting (RAVEN 0x1002:0x15D8 0x1002:0x15D8 0xC9).
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: Trusted Memory Zone (TMZ) feature disabled as experimental (default)
May 31 07:53:18 mainframe kernel: [drm] register mmio base: 0xFCC00000
May 31 07:53:18 mainframe kernel: [drm] register mmio size: 524288
May 31 07:53:18 mainframe kernel: [drm] add ip block number 0 <soc15_common>
May 31 07:53:18 mainframe kernel: [drm] add ip block number 1 <gmc_v9_0>
May 31 07:53:18 mainframe kernel: [drm] add ip block number 2 <vega10_ih>
May 31 07:53:18 mainframe kernel: [drm] add ip block number 3 <psp>
May 31 07:53:18 mainframe kernel: [drm] add ip block number 4 <gfx_v9_0>
May 31 07:53:18 mainframe kernel: [drm] add ip block number 5 <sdma_v4_0>
May 31 07:53:18 mainframe kernel: [drm] add ip block number 6 <powerplay>
May 31 07:53:18 mainframe kernel: [drm] add ip block number 7 <dm>
May 31 07:53:18 mainframe kernel: [drm] add ip block number 8 <vcn_v1_0>
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: Fetched VBIOS from VFCT
May 31 07:53:18 mainframe kernel: amdgpu: ATOM BIOS: 113-PICASSO-114
May 31 07:53:18 mainframe kernel: [drm] VCN decode is enabled in VM mode
May 31 07:53:18 mainframe kernel: [drm] VCN encode is enabled in VM mode
May 31 07:53:18 mainframe kernel: [drm] JPEG decode is enabled in VM mode
May 31 07:53:18 mainframe kernel: [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
May 31 07:53:18 mainframe kernel: [drm] Detected VRAM RAM=2048M, BAR=2048M
May 31 07:53:18 mainframe kernel: [drm] RAM width 128bits DDR4
May 31 07:53:18 mainframe kernel: [TTM] Zone  kernel: Available graphics memory: 7156082 KiB
May 31 07:53:18 mainframe kernel: [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
May 31 07:53:18 mainframe kernel: [drm] amdgpu: 2048M of VRAM memory ready
May 31 07:53:18 mainframe kernel: [drm] amdgpu: 3072M of GTT memory ready.
May 31 07:53:18 mainframe kernel: [drm] GART: num cpu pages 262144, num gpu pages 262144
May 31 07:53:18 mainframe kernel: [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
May 31 07:53:18 mainframe kernel: amdgpu: hwmgr_sw_init smu backed is smu10_smu
May 31 07:53:18 mainframe kernel: [drm] Found VCN firmware Version ENC: 1.12 DEC: 2 VEP: 0 Revision: 1
May 31 07:53:18 mainframe kernel: [drm] PSP loading VCN firmware
May 31 07:53:18 mainframe kernel: [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAS: optional ras ta ucode is not available
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta ucode is not available
May 31 07:53:18 mainframe kernel: [drm] kiq ring mec 2 pipe 1 q 0
May 31 07:53:18 mainframe kernel: [drm] DM_PPLIB: values for F clock
May 31 07:53:18 mainframe kernel: [drm] DM_PPLIB:         1400000 in kHz, 4399 in mV
May 31 07:53:18 mainframe kernel: [drm] DM_PPLIB: values for DCF clock
May 31 07:53:18 mainframe kernel: [drm] DM_PPLIB:         300000 in kHz, 3099 in mV
May 31 07:53:18 mainframe kernel: [drm] DM_PPLIB:         600000 in kHz, 3574 in mV
May 31 07:53:18 mainframe kernel: [drm] DM_PPLIB:         626000 in kHz, 4250 in mV
May 31 07:53:18 mainframe kernel: [drm] DM_PPLIB:         654000 in kHz, 4399 in mV
May 31 07:53:18 mainframe kernel: [drm] Display Core initialized with v3.2.122!
May 31 07:53:18 mainframe kernel: snd_hda_intel 0000:08:00.1: bound 0000:08:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
May 31 07:53:18 mainframe kernel: [drm] VCN decode and encode initialized successfully(under SPG Mode).
May 31 07:53:18 mainframe kernel: kfd kfd: Allocated 3969056 bytes on gart
May 31 07:53:18 mainframe kernel: amdgpu: Topology: Add APU node [0x15d8:0x1002]
May 31 07:53:18 mainframe kernel: kfd kfd: added device 1002:15d8
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 11, active_cu_number 8
May 31 07:53:18 mainframe kernel: [drm] fb mappable at 0x39FBCE000
May 31 07:53:18 mainframe kernel: [drm] vram apper at 0x39F000000
May 31 07:53:18 mainframe kernel: [drm] size 8294400
May 31 07:53:18 mainframe kernel: [drm] fb depth is 24
May 31 07:53:18 mainframe kernel: [drm]    pitch is 7680
May 31 07:53:18 mainframe kernel: fbcon: amdgpudrmfb (fb0) is primary device
May 31 07:53:18 mainframe kernel: Console: switching to colour frame buffer device 240x67
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: [drm] fb0: amdgpudrmfb frame buffer device
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
May 31 07:53:18 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
May 31 07:53:18 mainframe kernel: [drm] Initialized amdgpu 3.40.0 20150101 for 0000:08:00.0 on minor 0
May 31 07:53:19 mainframe kernel: nct6775: Found NCT6793D or compatible chip at 0x2e:0x290
May 31 07:53:19 mainframe kernel: 8021q: 802.1Q VLAN Support v1.8
May 31 07:53:19 mainframe kernel: cfg80211: Loading compiled-in X.509 certificates for regulatory database
May 31 07:53:19 mainframe kernel: cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
May 31 07:53:19 mainframe kernel: platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
May 31 07:53:19 mainframe kernel: cfg80211: failed to load regulatory.db
May 31 07:53:20 mainframe kernel: Generic FE-GE Realtek PHY r8169-700:00: attached PHY driver (mii_bus:phy_addr=r8169-700:00, irq=MAC)
May 31 07:53:20 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Down
May 31 07:53:20 mainframe kernel: kauditd_printk_skb: 89 callbacks suppressed
May 31 07:53:20 mainframe kernel: audit: type=1325 audit(1622422400.361:112): table=filter:4;?:0 family=1 entries=4 op=nft_register_table pid=715 comm="nft"
May 31 07:53:20 mainframe kernel: audit: type=1325 audit(1622422400.361:112): table=filter:4;input:1 family=1 entries=7 op=nft_register_chain pid=715 comm="nft"
May 31 07:53:20 mainframe kernel: audit: type=1325 audit(1622422400.361:112): table=filter:4;forward:2 family=1 entries=1 op=nft_register_chain pid=715 comm="nft"
May 31 07:53:20 mainframe kernel: audit: type=1325 audit(1622422400.361:112): table=filter:4;output:3 family=1 entries=0 op=nft_register_chain pid=715 comm="nft"
May 31 07:53:20 mainframe kernel: audit: type=1325 audit(1622422400.361:112): table=filter:4;__set0:4 family=1 entries=0 op=nft_register_set pid=715 comm="nft"
May 31 07:53:20 mainframe kernel: audit: type=1325 audit(1622422400.361:112): table=filter:4;__set0:4 family=1 entries=4 op=nft_register_setelem pid=715 comm="nft"
May 31 07:53:20 mainframe kernel: audit: type=1325 audit(1622422400.361:112): table=filter:4;__set0:4 family=1 entries=4 op=nft_register_setelem pid=715 comm="nft"
May 31 07:53:20 mainframe kernel: audit: type=1325 audit(1622422400.361:112): table=filter:4;input:1 family=1 entries=5 op=nft_register_rule pid=715 comm="nft"
May 31 07:53:20 mainframe kernel: audit: type=1325 audit(1622422400.361:112): table=filter:4;input:1 family=1 entries=6 op=nft_register_rule pid=715 comm="nft"
May 31 07:53:20 mainframe kernel: audit: type=1325 audit(1622422400.361:112): table=filter:4;input:1 family=1 entries=7 op=nft_register_rule pid=715 comm="nft"
May 31 07:53:21 mainframe kernel: NET: Registered protocol family 38
May 31 07:53:21 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Up - 100Mbps/Full - flow control rx/tx
May 31 07:53:21 mainframe kernel: IPv6: ADDRCONF(NETDEV_CHANGE): enp7s0: link becomes ready
May 31 07:53:30 mainframe kernel: kauditd_printk_skb: 14 callbacks suppressed
May 31 07:53:30 mainframe kernel: audit: type=1100 audit(1622422410.131:119): pid=836 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:authentication grantors=pam_securetty,pam_shells,pam_faillock,pam_permit,pam_faillock acct="ketsui" exe="/usr/bin/login" hostname=mainframe addr=? terminal=/dev/tty1 res=success'
May 31 07:53:30 mainframe kernel: audit: type=1101 audit(1622422410.141:120): pid=836 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/bin/login" hostname=mainframe addr=? terminal=/dev/tty1 res=success'
May 31 07:53:30 mainframe kernel: audit: type=1103 audit(1622422410.144:121): pid=836 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_securetty,pam_shells,pam_faillock,pam_permit,pam_faillock acct="ketsui" exe="/usr/bin/login" hostname=mainframe addr=? terminal=/dev/tty1 res=success'
May 31 07:53:30 mainframe kernel: audit: type=1006 audit(1622422410.144:122): pid=836 uid=0 old-auid=4294967295 auid=1000 tty=tty1 old-ses=4294967295 ses=1 res=1
May 31 07:53:30 mainframe kernel: audit: type=1300 audit(1622422410.144:122): arch=c000003e syscall=1 success=yes exit=4 a0=5 a1=7fff09aea350 a2=4 a3=3e8 items=0 ppid=1 pid=836 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=1000 fsgid=0 tty=tty1 ses=1 comm="login" exe="/usr/bin/login" key=(null)
May 31 07:53:30 mainframe kernel: audit: type=1327 audit(1622422410.144:122): proctitle=2F62696E2F6C6F67696E002D70002D2D00202020202020
May 31 07:53:30 mainframe kernel: audit: type=1130 audit(1622422410.157:123): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@1000 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:30 mainframe kernel: audit: type=1101 audit(1622422410.164:124): pid=844 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:30 mainframe kernel: audit: type=1103 audit(1622422410.164:125): pid=844 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=? acct="ketsui" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
May 31 07:53:30 mainframe kernel: audit: type=1006 audit(1622422410.167:126): pid=844 uid=0 old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=2 res=1
May 31 07:53:48 mainframe kernel: kauditd_printk_skb: 10 callbacks suppressed
May 31 07:53:48 mainframe kernel: audit: type=1130 audit(1622422428.885:133): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=polkit comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:52 mainframe kernel: audit: type=1130 audit(1622422432.608:134): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=rtkit-daemon comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 07:53:55 mainframe kernel: audit: type=1130 audit(1622422435.235:135): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=udisks2 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 08:08:15 mainframe kernel: audit: type=1130 audit(1622423295.650:136): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-clean comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 08:08:15 mainframe kernel: audit: type=1131 audit(1622423295.650:137): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-clean comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 08:12:00 mainframe kernel: audit: type=1334 audit(1622423520.416:138): prog-id=33 op=LOAD
May 31 08:12:00 mainframe kernel: audit: type=1334 audit(1622423520.416:139): prog-id=34 op=LOAD
May 31 08:12:00 mainframe kernel: audit: type=1334 audit(1622423520.416:140): prog-id=35 op=LOAD
May 31 08:12:00 mainframe kernel: audit: type=1130 audit(1622423520.449:141): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 08:12:30 mainframe kernel: audit: type=1131 audit(1622423550.539:142): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 08:12:30 mainframe kernel: audit: type=1334 audit(1622423550.689:143): prog-id=35 op=UNLOAD
May 31 08:12:30 mainframe kernel: audit: type=1334 audit(1622423550.689:144): prog-id=34 op=UNLOAD
May 31 08:12:30 mainframe kernel: audit: type=1334 audit(1622423550.689:145): prog-id=33 op=UNLOAD
May 31 08:25:12 mainframe kernel: pcieport 0000:00:08.1: PME: Spurious native interrupt!
May 31 09:02:59 mainframe kernel: usb 3-2: USB disconnect, device number 2
May 31 09:03:00 mainframe kernel: usb 3-2: new high-speed USB device number 3 using xhci_hcd
May 31 09:03:00 mainframe kernel: usb 3-2: New USB device found, idVendor=0b05, idProduct=7773, bcdDevice= 4.04
May 31 09:03:00 mainframe kernel: usb 3-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
May 31 09:03:00 mainframe kernel: usb 3-2: Product: SDM636-QRD _SN:0BED088B
May 31 09:03:00 mainframe kernel: usb 3-2: Manufacturer: asus
May 31 09:03:00 mainframe kernel: usb 3-2: SerialNumber: J6AXGF03H233HBA
May 31 09:13:34 mainframe kernel: usb 3-2: USB disconnect, device number 3
May 31 09:15:36 mainframe kernel: audit: type=1130 audit(1622427336.441:146): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=openvpn-restart comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 09:15:36 mainframe kernel: PM: suspend entry (deep)
May 31 10:05:19 mainframe kernel: Filesystems sync: 0.071 seconds
May 31 10:05:19 mainframe kernel: Freezing user space processes ... (elapsed 0.001 seconds) done.
May 31 10:05:19 mainframe kernel: OOM killer disabled.
May 31 10:05:19 mainframe kernel: Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
May 31 10:05:19 mainframe kernel: printk: Suspending console(s) (use no_console_suspend to debug)
May 31 10:05:19 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Down
May 31 10:05:19 mainframe kernel: serial 00:04: disabled
May 31 10:05:19 mainframe kernel: sd 9:0:0:0: [sdd] Synchronizing SCSI cache
May 31 10:05:19 mainframe kernel: sd 1:0:0:0: [sda] Synchronizing SCSI cache
May 31 10:05:19 mainframe kernel: sd 5:0:0:0: [sdc] Synchronizing SCSI cache
May 31 10:05:19 mainframe kernel: sd 4:0:0:0: [sdb] Synchronizing SCSI cache
May 31 10:05:19 mainframe kernel: sd 9:0:0:0: [sdd] Stopping disk
May 31 10:05:19 mainframe kernel: sd 4:0:0:0: [sdb] Stopping disk
May 31 10:05:19 mainframe kernel: sd 1:0:0:0: [sda] Stopping disk
May 31 10:05:19 mainframe kernel: sd 5:0:0:0: [sdc] Stopping disk
May 31 10:05:19 mainframe kernel: [drm] free PSP TMR buffer
May 31 10:05:19 mainframe kernel: ACPI: Preparing to enter system sleep state S3
May 31 10:05:19 mainframe kernel: PM: Saving platform NVS memory
May 31 10:05:19 mainframe kernel: Disabling non-boot CPUs ...
May 31 10:05:19 mainframe kernel: smpboot: CPU 1 is now offline
May 31 10:05:19 mainframe kernel: smpboot: CPU 2 is now offline
May 31 10:05:19 mainframe kernel: smpboot: CPU 3 is now offline
May 31 10:05:19 mainframe kernel: ACPI: Low-level resume complete
May 31 10:05:19 mainframe kernel: PM: Restoring platform NVS memory
May 31 10:05:19 mainframe kernel: Enabling non-boot CPUs ...
May 31 10:05:19 mainframe kernel: x86: Booting SMP configuration:
May 31 10:05:19 mainframe kernel: smpboot: Booting Node 0 Processor 1 APIC 0x2
May 31 10:05:19 mainframe kernel: microcode: CPU1: patch_level=0x08108109
May 31 10:05:19 mainframe kernel: CPU1 is up
May 31 10:05:19 mainframe kernel: smpboot: Booting Node 0 Processor 2 APIC 0x1
May 31 10:05:19 mainframe kernel: microcode: CPU2: patch_level=0x08108109
May 31 10:05:19 mainframe kernel: CPU2 is up
May 31 10:05:19 mainframe kernel: smpboot: Booting Node 0 Processor 3 APIC 0x3
May 31 10:05:19 mainframe kernel: microcode: CPU3: patch_level=0x08108109
May 31 10:05:19 mainframe kernel: CPU3 is up
May 31 10:05:19 mainframe kernel: ACPI: Waking up from system sleep state S3
May 31 10:05:19 mainframe kernel: sd 5:0:0:0: [sdc] Starting disk
May 31 10:05:19 mainframe kernel: sd 1:0:0:0: [sda] Starting disk
May 31 10:05:19 mainframe kernel: sd 4:0:0:0: [sdb] Starting disk
May 31 10:05:19 mainframe kernel: [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
May 31 10:05:19 mainframe kernel: [drm] PSP is resuming...
May 31 10:05:19 mainframe kernel: usb usb1: root hub lost power or was reset
May 31 10:05:19 mainframe kernel: usb usb2: root hub lost power or was reset
May 31 10:05:19 mainframe kernel: serial 00:04: activated
May 31 10:05:19 mainframe kernel: sd 9:0:0:0: [sdd] Starting disk
May 31 10:05:19 mainframe kernel: [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAS: optional ras ta ucode is not available
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta ucode is not available
May 31 10:05:19 mainframe kernel: [drm] kiq ring mec 2 pipe 1 q 0
May 31 10:05:19 mainframe kernel: amdgpu: dpm has been enabled
May 31 10:05:19 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Down
May 31 10:05:19 mainframe kernel: [drm] VCN decode and encode initialized successfully(under SPG Mode).
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
May 31 10:05:19 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
May 31 10:05:19 mainframe kernel: ata1: SATA link down (SStatus 0 SControl 300)
May 31 10:05:19 mainframe kernel: ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 31 10:05:19 mainframe kernel: ata2.00: configured for UDMA/133
May 31 10:05:19 mainframe kernel: ata10: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 31 10:05:19 mainframe kernel: ata10.00: configured for UDMA/133
May 31 10:05:19 mainframe kernel: usb 1-8: reset low-speed USB device number 3 using xhci_hcd
May 31 10:05:19 mainframe kernel: usb 1-5: reset full-speed USB device number 2 using xhci_hcd
May 31 10:05:19 mainframe kernel: OOM killer enabled.
May 31 10:05:19 mainframe kernel: Restarting tasks ... done.
May 31 10:05:19 mainframe kernel: video LNXVIDEO:01: Restoring backlight state
May 31 10:05:19 mainframe kernel: PM: suspend exit
May 31 10:05:19 mainframe kernel: audit: type=1130 audit(1622430319.566:147): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-suspend comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 10:05:19 mainframe kernel: audit: type=1131 audit(1622430319.566:148): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-suspend comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 10:05:19 mainframe kernel: audit: type=1131 audit(1622430319.573:149): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=openvpn-restart comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 10:05:19 mainframe kernel: r8169 0000:07:00.0 enp7s0: Link is Up - 100Mbps/Full - flow control rx/tx
May 31 10:05:20 mainframe kernel: ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
May 31 10:05:20 mainframe kernel: ata5.00: configured for UDMA/133
May 31 10:05:21 mainframe kernel: ata6: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
May 31 10:05:21 mainframe kernel: ata6.00: configured for UDMA/133
May 31 10:05:28 mainframe kernel: audit: type=1100 audit(1622430328.899:150): pid=4187 uid=1000 auid=1000 ses=1 msg='op=PAM:unix_chkpwd acct="ketsui" exe="/usr/bin/unix_chkpwd" hostname=? addr=? terminal=? res=success'
May 31 10:50:51 mainframe kernel: audit: type=1334 audit(1622433051.249:151): prog-id=36 op=LOAD
May 31 10:50:51 mainframe kernel: audit: type=1334 audit(1622433051.249:152): prog-id=37 op=LOAD
May 31 10:50:51 mainframe kernel: audit: type=1334 audit(1622433051.249:153): prog-id=38 op=LOAD
May 31 10:50:51 mainframe kernel: audit: type=1130 audit(1622433051.279:154): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 10:51:33 mainframe kernel: audit: type=1131 audit(1622433093.496:155): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 10:51:33 mainframe kernel: audit: type=1334 audit(1622433093.659:156): prog-id=38 op=UNLOAD
May 31 10:51:33 mainframe kernel: audit: type=1334 audit(1622433093.659:157): prog-id=37 op=UNLOAD
May 31 10:51:33 mainframe kernel: audit: type=1334 audit(1622433093.659:158): prog-id=36 op=UNLOAD
May 31 11:22:41 mainframe kernel: audit: type=1334 audit(1622434961.956:159): prog-id=39 op=LOAD
May 31 11:22:41 mainframe kernel: audit: type=1334 audit(1622434961.956:160): prog-id=40 op=LOAD
May 31 11:22:41 mainframe kernel: audit: type=1334 audit(1622434961.956:161): prog-id=41 op=LOAD
May 31 11:22:41 mainframe kernel: audit: type=1130 audit(1622434961.993:162): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 11:23:36 mainframe kernel: audit: type=1131 audit(1622435016.292:163): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 11:23:36 mainframe kernel: audit: type=1334 audit(1622435016.389:164): prog-id=41 op=UNLOAD
May 31 11:23:36 mainframe kernel: audit: type=1334 audit(1622435016.389:165): prog-id=40 op=UNLOAD
May 31 11:23:36 mainframe kernel: audit: type=1334 audit(1622435016.389:166): prog-id=39 op=UNLOAD
May 31 11:28:51 mainframe kernel: audit: type=1334 audit(1622435331.970:167): prog-id=42 op=LOAD
May 31 11:28:51 mainframe kernel: audit: type=1334 audit(1622435331.970:168): prog-id=43 op=LOAD
May 31 11:28:51 mainframe kernel: audit: type=1334 audit(1622435331.970:169): prog-id=44 op=LOAD
May 31 11:28:52 mainframe kernel: audit: type=1130 audit(1622435332.003:170): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 11:29:22 mainframe kernel: audit: type=1131 audit(1622435362.060:171): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 11:29:22 mainframe kernel: audit: type=1334 audit(1622435362.206:172): prog-id=44 op=UNLOAD
May 31 11:29:22 mainframe kernel: audit: type=1334 audit(1622435362.206:173): prog-id=43 op=UNLOAD
May 31 11:29:22 mainframe kernel: audit: type=1334 audit(1622435362.206:174): prog-id=42 op=UNLOAD
May 31 11:35:44 mainframe kernel: audit: type=1100 audit(1622435744.701:175): pid=6574 uid=1000 auid=1000 ses=1 msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock acct="ketsui" exe="/usr/lib/polkit-1/polkit-agent-helper-1" hostname=mainframe addr=? terminal=tty1 res=success'
May 31 11:35:44 mainframe kernel: audit: type=1101 audit(1622435744.705:176): pid=6574 uid=1000 auid=1000 ses=1 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/lib/polkit-1/polkit-agent-helper-1" hostname=? addr=? terminal=? res=success'
May 31 11:35:44 mainframe kernel: audit: type=1334 audit(1622435744.715:177): prog-id=45 op=LOAD
May 31 11:35:44 mainframe kernel: audit: type=1130 audit(1622435744.838:178): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=openvpn-client@protonvpn comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 11:35:47 mainframe kernel: tun: Universal TUN/TAP device driver, 1.6
May 31 11:42:47 mainframe kernel: [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for fences timed out!
May 31 11:42:47 mainframe kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0 timeout, signaled seq=395208, emitted seq=395209
May 31 11:42:47 mainframe kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process  pid 0 thread  pid 0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: GPU reset begin!
May 31 11:42:47 mainframe kernel: [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for fences timed out!
May 31 11:42:47 mainframe kernel: [drm] free PSP TMR buffer
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: MODE2 reset
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: GPU reset succeeded, trying to resume
May 31 11:42:47 mainframe kernel: [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
May 31 11:42:47 mainframe kernel: [drm] PSP is resuming...
May 31 11:42:47 mainframe kernel: [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAS: optional ras ta ucode is not available
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta ucode is not available
May 31 11:42:47 mainframe kernel: [drm] kiq ring mec 2 pipe 1 q 0
May 31 11:42:47 mainframe kernel: [drm] VCN decode and encode initialized successfully(under SPG Mode).
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: recover vram bo from shadow start
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: recover vram bo from shadow done
May 31 11:42:47 mainframe kernel: [drm] Skip scheduling IBs!
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: GPU reset(1) succeeded!
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: [gfxhub0] retry page fault (src_id:0 ring:0 vmid:7 pasid:32772, for process mpv pid 6694 thread mpv:cs0 pid 6724)
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:   in page starting at address 0x8001009fd000 from client 27
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: VM_L2_PROTECTION_FAULT_STATUS:0x00740C51
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          Faulty UTCL2 client ID: CPG (0x6)
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MORE_FAULTS: 0x1
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          WALKER_ERROR: 0x0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          PERMISSION_FAULTS: 0x5
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          MAPPING_ERROR: 0x0
May 31 11:42:47 mainframe kernel: amdgpu 0000:08:00.0: amdgpu:          RW: 0x1
May 31 11:42:58 mainframe kernel: [drm:amdgpu_dm_atomic_commit_tail [amdgpu]] *ERROR* Waiting for fences timed out!
May 31 11:42:58 mainframe kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, signaled seq=2117971, emitted seq=2117974
May 31 11:42:58 mainframe kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process mpv pid 6694 thread mpv:cs0 pid 6724
May 31 11:42:58 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: GPU reset begin!
May 31 11:42:58 mainframe kernel: [drm] free PSP TMR buffer
May 31 11:42:58 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: MODE2 reset
May 31 11:42:58 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: GPU reset succeeded, trying to resume
May 31 11:42:58 mainframe kernel: [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
May 31 11:42:58 mainframe kernel: [drm] PSP is resuming...
May 31 11:42:58 mainframe kernel: [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
May 31 11:42:58 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAS: optional ras ta ucode is not available
May 31 11:42:58 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: RAP: optional rap ta ucode is not available
May 31 11:42:58 mainframe kernel: [drm] kiq ring mec 2 pipe 1 q 0
May 31 11:42:58 mainframe kernel: amdgpu 0000:08:00.0: [drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring sdma0 test failed (-110)
May 31 11:42:58 mainframe kernel: [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP block <sdma_v4_0> failed -110
May 31 11:42:58 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: GPU reset(3) failed
May 31 11:42:58 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: GPU reset end with ret = -110
May 31 11:43:08 mainframe kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, but soft recovered
May 31 11:43:18 mainframe kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx timeout, but soft recovered
May 31 11:43:25 mainframe kernel: audit: type=1101 audit(1622436205.980:179): pid=6761 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/bin/sshd" hostname=192.168.0.124 addr=192.168.0.124 terminal=ssh res=success'
May 31 11:43:25 mainframe kernel: audit: type=1103 audit(1622436205.984:180): pid=6761 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_shells,pam_faillock,pam_permit,pam_env,pam_faillock acct="ketsui" exe="/usr/bin/sshd" hostname=192.168.0.124 addr=192.168.0.124 terminal=ssh res=success'
May 31 11:43:25 mainframe kernel: audit: type=1006 audit(1622436205.984:181): pid=6761 uid=0 old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=3 res=1
May 31 11:43:25 mainframe kernel: audit: type=1300 audit(1622436205.984:181): arch=c000003e syscall=1 success=yes exit=4 a0=3 a1=7ffd7a9796d0 a2=4 a3=3e8 items=0 ppid=834 pid=6761 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=3 comm="sshd" exe="/usr/bin/sshd" key=(null)
May 31 11:43:25 mainframe kernel: audit: type=1327 audit(1622436205.984:181): proctitle=737368643A206B6574737569205B707269765D
May 31 11:43:25 mainframe kernel: audit: type=1105 audit(1622436205.994:182): pid=6761 uid=0 auid=1000 ses=3 msg='op=PAM:session_open grantors=pam_loginuid,pam_keyinit,pam_limits,pam_unix,pam_permit,pam_mail,pam_systemd,pam_env acct="ketsui" exe="/usr/bin/sshd" hostname=192.168.0.124 addr=192.168.0.124 terminal=ssh res=success'
May 31 11:43:25 mainframe kernel: audit: type=1103 audit(1622436205.994:183): pid=6763 uid=0 auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_shells,pam_faillock,pam_permit,pam_env,pam_faillock acct="ketsui" exe="/usr/bin/sshd" hostname=192.168.0.124 addr=192.168.0.124 terminal=ssh res=success'
May 31 11:43:32 mainframe kernel: audit: type=1100 audit(1622436212.077:184): pid=6780 uid=1000 auid=1000 ses=3 msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock acct="ketsui" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
May 31 11:43:32 mainframe kernel: audit: type=1101 audit(1622436212.080:185): pid=6780 uid=1000 auid=1000 ses=3 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="ketsui" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
May 31 11:43:32 mainframe kernel: audit: type=1110 audit(1622436212.080:186): pid=6780 uid=1000 auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
May 31 11:43:32 mainframe kernel: audit: type=1105 audit(1622436212.084:187): pid=6780 uid=1000 auid=1000 ses=3 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
May 31 11:43:32 mainframe kernel: audit: type=1106 audit(1622436212.107:188): pid=6761 uid=0 auid=1000 ses=3 msg='op=PAM:session_close grantors=? acct="ketsui" exe="/usr/bin/sshd" hostname=192.168.0.124 addr=192.168.0.124 terminal=ssh res=failed'
May 31 11:43:32 mainframe kernel: audit: type=1104 audit(1622436212.110:189): pid=6761 uid=0 auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_shells,pam_faillock,pam_permit,pam_env,pam_faillock acct="ketsui" exe="/usr/bin/sshd" hostname=192.168.0.124 addr=192.168.0.124 terminal=ssh res=success'
May 31 11:43:32 mainframe kernel: audit: type=1106 audit(1622436212.110:190): pid=6780 uid=1000 auid=1000 ses=3 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
May 31 11:43:32 mainframe kernel: audit: type=1104 audit(1622436212.110:191): pid=6780 uid=1000 auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/2 res=success'
May 31 11:43:32 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: couldn't schedule ib on ring <sdma0>
May 31 11:43:32 mainframe kernel: [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
May 31 11:43:32 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: couldn't schedule ib on ring <sdma0>
May 31 11:43:32 mainframe kernel: [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
May 31 11:43:32 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: couldn't schedule ib on ring <sdma0>
May 31 11:43:32 mainframe kernel: [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
May 31 11:43:32 mainframe kernel: audit: type=1131 audit(1622436212.127:192): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dnscrypt-proxy comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 11:43:32 mainframe kernel: audit: type=1131 audit(1622436212.134:193): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=sshd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 11:43:32 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: couldn't schedule ib on ring <sdma0>
May 31 11:43:32 mainframe kernel: [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
May 31 11:43:32 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: couldn't schedule ib on ring <sdma0>
May 31 11:43:32 mainframe kernel: [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
May 31 11:43:32 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: couldn't schedule ib on ring <sdma0>
May 31 11:43:32 mainframe kernel: [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
May 31 11:43:32 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: couldn't schedule ib on ring <sdma0>
May 31 11:43:32 mainframe kernel: [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
May 31 11:43:32 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: couldn't schedule ib on ring <sdma0>
May 31 11:43:32 mainframe kernel: [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
May 31 11:43:32 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: couldn't schedule ib on ring <sdma0>
May 31 11:43:32 mainframe kernel: [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
May 31 11:43:32 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: couldn't schedule ib on ring <sdma0>
May 31 11:43:32 mainframe kernel: [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
May 31 11:43:32 mainframe kernel: amdgpu 0000:08:00.0: amdgpu: couldn't schedule ib on ring <sdma0>
May 31 11:43:32 mainframe kernel: [drm:amdgpu_job_run [amdgpu]] *ERROR* Error scheduling IBs (-22)
May 31 11:43:47 mainframe kernel: kauditd_printk_skb: 4 callbacks suppressed
May 31 11:43:47 mainframe kernel: audit: type=1104 audit(1622436227.150:198): pid=836 uid=0 auid=1000 ses=1 msg='op=PAM:setcred grantors=pam_securetty,pam_shells,pam_faillock,pam_permit,pam_faillock acct="ketsui" exe="/usr/bin/login" hostname=mainframe addr=? terminal=/dev/tty1 res=success'
May 31 11:43:47 mainframe kernel: audit: type=1106 audit(1622436227.153:199): pid=836 uid=0 auid=1000 ses=1 msg='op=PAM:session_close grantors=pam_loginuid,pam_keyinit,pam_limits,pam_unix,pam_permit,pam_mail,pam_systemd,pam_env acct="ketsui" exe="/usr/bin/login" hostname=mainframe addr=? terminal=/dev/tty1 res=success'
May 31 11:43:47 mainframe kernel: audit: type=1131 audit(1622436227.157:200): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=getty@tty1 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 31 11:47:05 mainframe kernel: INFO: task systemd:1 blocked for more than 122 seconds.
May 31 11:47:05 mainframe kernel:       Not tainted 5.12.8-arch1-1 #1
May 31 11:47:05 mainframe kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 31 11:47:05 mainframe kernel: task:systemd         state:D stack:    0 pid:    1 ppid:     0 flags:0x00004000
May 31 11:47:05 mainframe kernel: Call Trace:
May 31 11:47:05 mainframe kernel:  __schedule+0x2ff/0x8b0
May 31 11:47:05 mainframe kernel:  schedule+0x5b/0xc0
May 31 11:47:05 mainframe kernel:  schedule_preempt_disabled+0x11/0x20
May 31 11:47:05 mainframe kernel:  __mutex_lock.constprop.0+0x367/0x550
May 31 11:47:05 mainframe kernel:  amdgpu_dm_atomic_commit_tail+0x5db/0x2630 [amdgpu]
May 31 11:47:05 mainframe kernel:  commit_tail+0x94/0x120 [drm_kms_helper]
May 31 11:47:05 mainframe kernel:  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
May 31 11:47:05 mainframe kernel:  drm_client_modeset_commit_atomic+0x1fc/0x240 [drm]
May 31 11:47:05 mainframe kernel:  drm_client_modeset_commit_locked+0x56/0x150 [drm]
May 31 11:47:05 mainframe kernel:  drm_fb_helper_set_par+0x75/0xd0 [drm_kms_helper]
May 31 11:47:05 mainframe kernel:  fb_set_var+0x1d3/0x390
May 31 11:47:05 mainframe kernel:  fbcon_blank+0x186/0x280
May 31 11:47:05 mainframe kernel:  do_unblank_screen+0xaa/0x150
May 31 11:47:05 mainframe kernel:  vt_ioctl+0xdf4/0x1490
May 31 11:47:05 mainframe kernel:  ? _copy_to_user+0x2d/0x40
May 31 11:47:05 mainframe kernel:  ? tty_mode_ioctl+0x168/0x710
May 31 11:47:05 mainframe kernel:  tty_ioctl+0x377/0x930
May 31 11:47:05 mainframe kernel:  ? kmem_cache_free+0x10c/0x480
May 31 11:47:05 mainframe kernel:  ? do_sys_openat2+0x9b/0x160
May 31 11:47:05 mainframe kernel:  __x64_sys_ioctl+0x82/0xb0
May 31 11:47:05 mainframe kernel:  do_syscall_64+0x33/0x40
May 31 11:47:05 mainframe kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
May 31 11:47:05 mainframe kernel: RIP: 0033:0x7f6127af859b
May 31 11:47:05 mainframe kernel: RSP: 002b:00007fff42b8a5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
May 31 11:47:05 mainframe kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f6127af859b
May 31 11:47:05 mainframe kernel: RDX: 0000000000000000 RSI: 0000000000004b3a RDI: 0000000000000026
May 31 11:47:05 mainframe kernel: RBP: 0000000000000026 R08: 00007fff42b8a5d0 R09: 0000000000000000
May 31 11:47:05 mainframe kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000026
May 31 11:47:05 mainframe kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
May 31 11:47:05 mainframe kernel: INFO: task Xorg:cs0:886 blocked for more than 122 seconds.
May 31 11:47:05 mainframe kernel:       Not tainted 5.12.8-arch1-1 #1
May 31 11:47:05 mainframe kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 31 11:47:05 mainframe kernel: task:Xorg:cs0        state:D stack:    0 pid:  886 ppid:     1 flags:0x00000004
May 31 11:47:05 mainframe kernel: Call Trace:
May 31 11:47:05 mainframe kernel:  __schedule+0x2ff/0x8b0
May 31 11:47:05 mainframe kernel:  schedule+0x5b/0xc0
May 31 11:47:05 mainframe kernel:  schedule_preempt_disabled+0x11/0x20
May 31 11:47:05 mainframe kernel:  __mutex_lock.constprop.0+0x367/0x550
May 31 11:47:05 mainframe kernel:  amdgpu_ctx_get+0x23/0x90 [amdgpu]
May 31 11:47:05 mainframe kernel:  amdgpu_cs_ioctl+0x2b0/0x1e80 [amdgpu]
May 31 11:47:05 mainframe kernel:  ? calibrate_delay+0x431/0x4c0
May 31 11:47:05 mainframe kernel:  ? finish_task_switch.isra.0+0xaa/0x290
May 31 11:47:05 mainframe kernel:  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
May 31 11:47:05 mainframe kernel:  drm_ioctl_kernel+0xb2/0x100 [drm]
May 31 11:47:05 mainframe kernel:  drm_ioctl+0x21e/0x3b0 [drm]
May 31 11:47:05 mainframe kernel:  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
May 31 11:47:05 mainframe kernel:  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
May 31 11:47:05 mainframe kernel:  __x64_sys_ioctl+0x82/0xb0
May 31 11:47:05 mainframe kernel:  do_syscall_64+0x33/0x40
May 31 11:47:05 mainframe kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
May 31 11:47:05 mainframe kernel: RIP: 0033:0x7fc6f97b059b
May 31 11:47:05 mainframe kernel: RSP: 002b:00007fc6ef1f68b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
May 31 11:47:05 mainframe kernel: RAX: ffffffffffffffda RBX: 00007fc6ef1f6920 RCX: 00007fc6f97b059b
May 31 11:47:05 mainframe kernel: RDX: 00007fc6ef1f6920 RSI: 00000000c0186444 RDI: 000000000000000a
May 31 11:47:05 mainframe kernel: RBP: 00000000c0186444 R08: 00007fc6ef1f6a40 R09: 00007fc6ef1f69e8
May 31 11:47:05 mainframe kernel: R10: 000055d54f224e00 R11: 0000000000000246 R12: 000055d54f2071e0
May 31 11:47:05 mainframe kernel: R13: 000000000000000a R14: 00000000fffffffd R15: 000055d54f2255f0
May 31 11:47:05 mainframe kernel: INFO: task (-restore):6784 blocked for more than 122 seconds.
May 31 11:47:05 mainframe kernel:       Not tainted 5.12.8-arch1-1 #1
May 31 11:47:05 mainframe kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 31 11:47:05 mainframe kernel: task:(-restore)      state:D stack:    0 pid: 6784 ppid:     1 flags:0x00000000
May 31 11:47:05 mainframe kernel: Call Trace:
May 31 11:47:05 mainframe kernel:  __schedule+0x2ff/0x8b0
May 31 11:47:05 mainframe kernel:  schedule+0x5b/0xc0
May 31 11:47:05 mainframe kernel:  schedule_preempt_disabled+0x11/0x20
May 31 11:47:05 mainframe kernel:  __mutex_lock.constprop.0+0x367/0x550
May 31 11:47:05 mainframe kernel:  amdgpu_ctx_mgr_entity_flush+0x47/0xf0 [amdgpu]
May 31 11:47:05 mainframe kernel:  amdgpu_flush+0x25/0x40 [amdgpu]
May 31 11:47:05 mainframe kernel:  filp_close+0x32/0x70
May 31 11:47:05 mainframe kernel:  __close_range+0x184/0x1b0
May 31 11:47:05 mainframe kernel:  __x64_sys_close_range+0x13/0x20
May 31 11:47:05 mainframe kernel:  do_syscall_64+0x33/0x40
May 31 11:47:05 mainframe kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
May 31 11:47:05 mainframe kernel: RIP: 0033:0x7f6127afc18d
May 31 11:47:05 mainframe kernel: RSP: 002b:00007fff42b89f98 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
May 31 11:47:05 mainframe kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f6127afc18d
May 31 11:47:05 mainframe kernel: RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000003
May 31 11:47:05 mainframe kernel: RBP: 00007fff42b8a020 R08: 0000000000000004 R09: 0000002200000002
May 31 11:47:05 mainframe kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff42b8a030
May 31 11:47:05 mainframe kernel: R13: 0000000000000000 R14: 0000000000000001 R15: 00007fff42b89fa0
May 31 11:47:05 mainframe kernel: INFO: task (modprobe):6785 blocked for more than 122 seconds.
May 31 11:47:05 mainframe kernel:       Not tainted 5.12.8-arch1-1 #1
May 31 11:47:05 mainframe kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 31 11:47:05 mainframe kernel: task:(modprobe)      state:D stack:    0 pid: 6785 ppid:     1 flags:0x00000000
May 31 11:47:05 mainframe kernel: Call Trace:
May 31 11:47:05 mainframe kernel:  __schedule+0x2ff/0x8b0
May 31 11:47:05 mainframe kernel:  schedule+0x5b/0xc0
May 31 11:47:05 mainframe kernel:  schedule_preempt_disabled+0x11/0x20
May 31 11:47:05 mainframe kernel:  __mutex_lock.constprop.0+0x367/0x550
May 31 11:47:05 mainframe kernel:  amdgpu_ctx_mgr_entity_flush+0x47/0xf0 [amdgpu]
May 31 11:47:05 mainframe kernel:  amdgpu_flush+0x25/0x40 [amdgpu]
May 31 11:47:05 mainframe kernel:  filp_close+0x32/0x70
May 31 11:47:05 mainframe kernel:  __close_range+0x184/0x1b0
May 31 11:47:05 mainframe kernel:  __x64_sys_close_range+0x13/0x20
May 31 11:47:05 mainframe kernel:  do_syscall_64+0x33/0x40
May 31 11:47:05 mainframe kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
May 31 11:47:05 mainframe kernel: RIP: 0033:0x7f6127afc18d
May 31 11:47:05 mainframe kernel: RSP: 002b:00007fff42b89f98 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
May 31 11:47:05 mainframe kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f6127afc18d
May 31 11:47:05 mainframe kernel: RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000003
May 31 11:47:05 mainframe kernel: RBP: 00007fff42b8a020 R08: 0000000000000004 R09: 0000002200000002
May 31 11:47:05 mainframe kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff42b8a030
May 31 11:47:05 mainframe kernel: R13: 0000000000000000 R14: 0000000000000001 R15: 00007fff42b89fa0
May 31 11:47:05 mainframe kernel: INFO: task (dom-seed):6786 blocked for more than 122 seconds.
May 31 11:47:05 mainframe kernel:       Not tainted 5.12.8-arch1-1 #1
May 31 11:47:05 mainframe kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 31 11:47:05 mainframe kernel: task:(dom-seed)      state:D stack:    0 pid: 6786 ppid:     1 flags:0x00000000
May 31 11:47:05 mainframe kernel: Call Trace:
May 31 11:47:05 mainframe kernel:  __schedule+0x2ff/0x8b0
May 31 11:47:05 mainframe kernel:  schedule+0x5b/0xc0
May 31 11:47:05 mainframe kernel:  schedule_preempt_disabled+0x11/0x20
May 31 11:47:05 mainframe kernel:  __mutex_lock.constprop.0+0x367/0x550
May 31 11:47:05 mainframe kernel:  amdgpu_ctx_mgr_entity_flush+0x47/0xf0 [amdgpu]
May 31 11:47:05 mainframe kernel:  amdgpu_flush+0x25/0x40 [amdgpu]
May 31 11:47:05 mainframe kernel:  filp_close+0x32/0x70
May 31 11:47:05 mainframe kernel:  __close_range+0x184/0x1b0
May 31 11:47:05 mainframe kernel:  __x64_sys_close_range+0x13/0x20
May 31 11:47:05 mainframe kernel:  do_syscall_64+0x33/0x40
May 31 11:47:05 mainframe kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
May 31 11:47:05 mainframe kernel: RIP: 0033:0x7f6127afc18d
May 31 11:47:05 mainframe kernel: RSP: 002b:00007fff42b89f98 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
May 31 11:47:05 mainframe kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f6127afc18d
May 31 11:47:05 mainframe kernel: RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000003
May 31 11:47:05 mainframe kernel: RBP: 00007fff42b8a020 R08: 0000000000000004 R09: 0000002200000002
May 31 11:47:05 mainframe kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff42b8a030
May 31 11:47:05 mainframe kernel: R13: 0000000000000000 R14: 0000000000000001 R15: 00007fff42b89fa0
May 31 11:49:08 mainframe kernel: INFO: task systemd:1 blocked for more than 245 seconds.
May 31 11:49:08 mainframe kernel:       Not tainted 5.12.8-arch1-1 #1
May 31 11:49:08 mainframe kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 31 11:49:08 mainframe kernel: task:systemd         state:D stack:    0 pid:    1 ppid:     0 flags:0x00004000
May 31 11:49:08 mainframe kernel: Call Trace:
May 31 11:49:08 mainframe kernel:  __schedule+0x2ff/0x8b0
May 31 11:49:08 mainframe kernel:  schedule+0x5b/0xc0
May 31 11:49:08 mainframe kernel:  schedule_preempt_disabled+0x11/0x20
May 31 11:49:08 mainframe kernel:  __mutex_lock.constprop.0+0x367/0x550
May 31 11:49:08 mainframe kernel:  amdgpu_dm_atomic_commit_tail+0x5db/0x2630 [amdgpu]
May 31 11:49:08 mainframe kernel:  commit_tail+0x94/0x120 [drm_kms_helper]
May 31 11:49:08 mainframe kernel:  drm_atomic_helper_commit+0x113/0x140 [drm_kms_helper]
May 31 11:49:08 mainframe kernel:  drm_client_modeset_commit_atomic+0x1fc/0x240 [drm]
May 31 11:49:08 mainframe kernel:  drm_client_modeset_commit_locked+0x56/0x150 [drm]
May 31 11:49:08 mainframe kernel:  drm_fb_helper_set_par+0x75/0xd0 [drm_kms_helper]
May 31 11:49:08 mainframe kernel:  fb_set_var+0x1d3/0x390
May 31 11:49:08 mainframe kernel:  fbcon_blank+0x186/0x280
May 31 11:49:08 mainframe kernel:  do_unblank_screen+0xaa/0x150
May 31 11:49:08 mainframe kernel:  vt_ioctl+0xdf4/0x1490
May 31 11:49:08 mainframe kernel:  ? _copy_to_user+0x2d/0x40
May 31 11:49:08 mainframe kernel:  ? tty_mode_ioctl+0x168/0x710
May 31 11:49:08 mainframe kernel:  tty_ioctl+0x377/0x930
May 31 11:49:08 mainframe kernel:  ? kmem_cache_free+0x10c/0x480
May 31 11:49:08 mainframe kernel:  ? do_sys_openat2+0x9b/0x160
May 31 11:49:08 mainframe kernel:  __x64_sys_ioctl+0x82/0xb0
May 31 11:49:08 mainframe kernel:  do_syscall_64+0x33/0x40
May 31 11:49:08 mainframe kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
May 31 11:49:08 mainframe kernel: RIP: 0033:0x7f6127af859b
May 31 11:49:08 mainframe kernel: RSP: 002b:00007fff42b8a5e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
May 31 11:49:08 mainframe kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f6127af859b
May 31 11:49:08 mainframe kernel: RDX: 0000000000000000 RSI: 0000000000004b3a RDI: 0000000000000026
May 31 11:49:08 mainframe kernel: RBP: 0000000000000026 R08: 00007fff42b8a5d0 R09: 0000000000000000
May 31 11:49:08 mainframe kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000026
May 31 11:49:08 mainframe kernel: R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
May 31 11:49:08 mainframe kernel: INFO: task Xorg:cs0:886 blocked for more than 245 seconds.
May 31 11:49:08 mainframe kernel:       Not tainted 5.12.8-arch1-1 #1
May 31 11:49:08 mainframe kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 31 11:49:08 mainframe kernel: task:Xorg:cs0        state:D stack:    0 pid:  886 ppid:     1 flags:0x00000004
May 31 11:49:08 mainframe kernel: Call Trace:
May 31 11:49:08 mainframe kernel:  __schedule+0x2ff/0x8b0
May 31 11:49:08 mainframe kernel:  schedule+0x5b/0xc0
May 31 11:49:08 mainframe kernel:  schedule_preempt_disabled+0x11/0x20
May 31 11:49:08 mainframe kernel:  __mutex_lock.constprop.0+0x367/0x550
May 31 11:49:08 mainframe kernel:  amdgpu_ctx_get+0x23/0x90 [amdgpu]
May 31 11:49:08 mainframe kernel:  amdgpu_cs_ioctl+0x2b0/0x1e80 [amdgpu]
May 31 11:49:08 mainframe kernel:  ? calibrate_delay+0x431/0x4c0
May 31 11:49:08 mainframe kernel:  ? finish_task_switch.isra.0+0xaa/0x290
May 31 11:49:08 mainframe kernel:  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
May 31 11:49:08 mainframe kernel:  drm_ioctl_kernel+0xb2/0x100 [drm]
May 31 11:49:08 mainframe kernel:  drm_ioctl+0x21e/0x3b0 [drm]
May 31 11:49:08 mainframe kernel:  ? amdgpu_cs_find_mapping+0x110/0x110 [amdgpu]
May 31 11:49:08 mainframe kernel:  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
May 31 11:49:08 mainframe kernel:  __x64_sys_ioctl+0x82/0xb0
May 31 11:49:08 mainframe kernel:  do_syscall_64+0x33/0x40
May 31 11:49:08 mainframe kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
May 31 11:49:08 mainframe kernel: RIP: 0033:0x7fc6f97b059b
May 31 11:49:08 mainframe kernel: RSP: 002b:00007fc6ef1f68b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
May 31 11:49:08 mainframe kernel: RAX: ffffffffffffffda RBX: 00007fc6ef1f6920 RCX: 00007fc6f97b059b
May 31 11:49:08 mainframe kernel: RDX: 00007fc6ef1f6920 RSI: 00000000c0186444 RDI: 000000000000000a
May 31 11:49:08 mainframe kernel: RBP: 00000000c0186444 R08: 00007fc6ef1f6a40 R09: 00007fc6ef1f69e8
May 31 11:49:08 mainframe kernel: R10: 000055d54f224e00 R11: 0000000000000246 R12: 000055d54f2071e0
May 31 11:49:08 mainframe kernel: R13: 000000000000000a R14: 00000000fffffffd R15: 000055d54f2255f0
May 31 11:49:08 mainframe kernel: INFO: task (-restore):6784 blocked for more than 245 seconds.
May 31 11:49:08 mainframe kernel:       Not tainted 5.12.8-arch1-1 #1
May 31 11:49:08 mainframe kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 31 11:49:08 mainframe kernel: task:(-restore)      state:D stack:    0 pid: 6784 ppid:     1 flags:0x00000000
May 31 11:49:08 mainframe kernel: Call Trace:
May 31 11:49:08 mainframe kernel:  __schedule+0x2ff/0x8b0
May 31 11:49:08 mainframe kernel:  schedule+0x5b/0xc0
May 31 11:49:08 mainframe kernel:  schedule_preempt_disabled+0x11/0x20
May 31 11:49:08 mainframe kernel:  __mutex_lock.constprop.0+0x367/0x550
May 31 11:49:08 mainframe kernel:  amdgpu_ctx_mgr_entity_flush+0x47/0xf0 [amdgpu]
May 31 11:49:08 mainframe kernel:  amdgpu_flush+0x25/0x40 [amdgpu]
May 31 11:49:08 mainframe kernel:  filp_close+0x32/0x70
May 31 11:49:08 mainframe kernel:  __close_range+0x184/0x1b0
May 31 11:49:08 mainframe kernel:  __x64_sys_close_range+0x13/0x20
May 31 11:49:08 mainframe kernel:  do_syscall_64+0x33/0x40
May 31 11:49:08 mainframe kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
May 31 11:49:08 mainframe kernel: RIP: 0033:0x7f6127afc18d
May 31 11:49:08 mainframe kernel: RSP: 002b:00007fff42b89f98 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
May 31 11:49:08 mainframe kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f6127afc18d
May 31 11:49:08 mainframe kernel: RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000003
May 31 11:49:08 mainframe kernel: RBP: 00007fff42b8a020 R08: 0000000000000004 R09: 0000002200000002
May 31 11:49:08 mainframe kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff42b8a030
May 31 11:49:08 mainframe kernel: R13: 0000000000000000 R14: 0000000000000001 R15: 00007fff42b89fa0
May 31 11:49:08 mainframe kernel: INFO: task (modprobe):6785 blocked for more than 245 seconds.
May 31 11:49:08 mainframe kernel:       Not tainted 5.12.8-arch1-1 #1
May 31 11:49:08 mainframe kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 31 11:49:08 mainframe kernel: task:(modprobe)      state:D stack:    0 pid: 6785 ppid:     1 flags:0x00000000
May 31 11:49:08 mainframe kernel: Call Trace:
May 31 11:49:08 mainframe kernel:  __schedule+0x2ff/0x8b0
May 31 11:49:08 mainframe kernel:  schedule+0x5b/0xc0
May 31 11:49:08 mainframe kernel:  schedule_preempt_disabled+0x11/0x20
May 31 11:49:08 mainframe kernel:  __mutex_lock.constprop.0+0x367/0x550
May 31 11:49:08 mainframe kernel:  amdgpu_ctx_mgr_entity_flush+0x47/0xf0 [amdgpu]
May 31 11:49:08 mainframe kernel:  amdgpu_flush+0x25/0x40 [amdgpu]
May 31 11:49:08 mainframe kernel:  filp_close+0x32/0x70
May 31 11:49:08 mainframe kernel:  __close_range+0x184/0x1b0
May 31 11:49:08 mainframe kernel:  __x64_sys_close_range+0x13/0x20
May 31 11:49:08 mainframe kernel:  do_syscall_64+0x33/0x40
May 31 11:49:08 mainframe kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
May 31 11:49:08 mainframe kernel: RIP: 0033:0x7f6127afc18d
May 31 11:49:08 mainframe kernel: RSP: 002b:00007fff42b89f98 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
May 31 11:49:08 mainframe kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f6127afc18d
May 31 11:49:08 mainframe kernel: RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000003
May 31 11:49:08 mainframe kernel: RBP: 00007fff42b8a020 R08: 0000000000000004 R09: 0000002200000002
May 31 11:49:08 mainframe kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff42b8a030
May 31 11:49:08 mainframe kernel: R13: 0000000000000000 R14: 0000000000000001 R15: 00007fff42b89fa0
May 31 11:49:08 mainframe kernel: INFO: task (dom-seed):6786 blocked for more than 245 seconds.
May 31 11:49:08 mainframe kernel:       Not tainted 5.12.8-arch1-1 #1
May 31 11:49:08 mainframe kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
May 31 11:49:08 mainframe kernel: task:(dom-seed)      state:D stack:    0 pid: 6786 ppid:     1 flags:0x00000000
May 31 11:49:08 mainframe kernel: Call Trace:
May 31 11:49:08 mainframe kernel:  __schedule+0x2ff/0x8b0
May 31 11:49:08 mainframe kernel:  schedule+0x5b/0xc0
May 31 11:49:08 mainframe kernel:  schedule_preempt_disabled+0x11/0x20
May 31 11:49:08 mainframe kernel:  __mutex_lock.constprop.0+0x367/0x550
May 31 11:49:08 mainframe kernel:  amdgpu_ctx_mgr_entity_flush+0x47/0xf0 [amdgpu]
May 31 11:49:08 mainframe kernel:  amdgpu_flush+0x25/0x40 [amdgpu]
May 31 11:49:08 mainframe kernel:  filp_close+0x32/0x70
May 31 11:49:08 mainframe kernel:  __close_range+0x184/0x1b0
May 31 11:49:08 mainframe kernel:  __x64_sys_close_range+0x13/0x20
May 31 11:49:08 mainframe kernel:  do_syscall_64+0x33/0x40
May 31 11:49:08 mainframe kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
May 31 11:49:08 mainframe kernel: RIP: 0033:0x7f6127afc18d
May 31 11:49:08 mainframe kernel: RSP: 002b:00007fff42b89f98 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
May 31 11:49:08 mainframe kernel: RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f6127afc18d
May 31 11:49:08 mainframe kernel: RDX: 0000000000000000 RSI: 0000000000000021 RDI: 0000000000000003
May 31 11:49:08 mainframe kernel: RBP: 00007fff42b8a020 R08: 0000000000000004 R09: 0000002200000002
May 31 11:49:08 mainframe kernel: R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff42b8a030
May 31 11:49:08 mainframe kernel: R13: 0000000000000000 R14: 0000000000000001 R15: 00007fff42b89fa0

--+a9ZkNVvEAjfb4BR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--+a9ZkNVvEAjfb4BR--
