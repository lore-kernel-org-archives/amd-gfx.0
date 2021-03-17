Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD04C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 16:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B82464D9D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 16:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B82464D9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 095A989AFF;
	Wed, 17 Mar 2021 16:27:46 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Wed, 17 Mar 2021 16:27:44 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C39E589AFF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1615998462;
 bh=zmFSFgNN51znqrudLCImE9WtgxUxhg8E8e96wUQV3zA=;
 h=X-UI-Sender-Class:From:Reply-To:To:Subject:Date;
 b=aSz/L0u1gKwiMnvDCeQyg9TJ7Y0JCb4A/CsGN49GE6w2tQefSQtQE+dP3vCShiuJ2
 +IjTpIh1o6RWKCqrjxwHsqS5OQFjdsiAqdXCMJQcbvCCJP0cUUfg8dEIYENG6VL6zq
 1Ml5/yw/g3v2JrePhPKhiNip7YV4+b2X005idqP4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.1] ([178.27.135.197]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8ofO-1ljIV62cMQ-015t3V for
 <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 17:22:38 +0100
From: Harvey <harv@gmx.de>
To: amd-gfx@lists.freedesktop.org
Subject: Amdgpu kernel oops and freezing on system suspend and hibernate
Message-ID: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
Date: Wed, 17 Mar 2021 17:20:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
X-Provags-ID: V03:K1:u+36Biz3ER/cPljQU8e7Kk0/H0+/hRCnBErJg5ZoFibxY/GkqWN
 OLLfh7fDPPbr9VI+kYR7FXX0eL0tq6LBRVFwkI6O/XT8K/emoIDDTSHmZ8zkXATNwKDalyq
 MdgO5Pi9KsL7Z0ht0w4ZoND6DY244Htx8S60iuRhDjWSsDUnNBD2wxaHAMRHP0M4pyoynYM
 04KWJeSzJDcd95a875ykA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MYInXGBjJHw=:eNJieLp1Fmt8+FooXSvYU3
 R/WujP8fIVcYxbjhRUNPwRgLHAew+6qdueSAqeffIJmuvAju45MZnuFB0fcoAeB7ZwnMMVWDn
 gs8Krbl4FbSiBpHpdeEXGMwWemgxVG4gu7yvKW9T263gv3h6zp0hl6N15n1JNMbsX7pj5/Xfr
 l+o933MSIOYxGTliGFeIsFhjnA42nlPbRpvb9hYspyHLrjr9dPSbqwF3sJ3zIZ8xTcOkXxQGC
 nI0rbMAqIx8Ezc79LQLbqaE6u7pK8LVG9SKaRCty6k2pQ1Y5QD55PPctp49+nQ1jCtGFB2paU
 HrjdqcLOvL1SDZpEA4W7gamNbhjEBCE6ragP8KsxvysaCWakOXPriftkeh7ZUhZXSbwKWRlda
 1REFfX24gW7KSh7xzvRjDSmHSUM1hYzBrraVSvFt0dKHwhDUCTSxuS/oYsFMmTFTwXHYFcl4T
 NBU0+J3EzSuzaUcoMpxjsmMmxX2c+eCpjOBB5YM/GCLq0a8l1+u3oc9mVUe/MSpO3x83O2kKZ
 oJnM75piBh4TV/5mekQOu84UviuJWpFUHygj8Yxp+Nq+WUgvj6/f7RDeTwhDQa5Pn/swsFlsE
 o7+rkbywqlzWDYCCOEXfRl8LqrVz21a1XACXnuJJF9+MJhiGNiYj5pGvjr5yobtNPtYiiToGK
 GYW8X0ZTCC/MUwYscQ+FbuCsVzWgVIoA9iS4xeSBmT/PjC14Ub+0vvC4wzTxZxZKi57/m4Aer
 4Mxq/tHhC1NS3q8ncfV2Z3jVUDAbo40tADS6caGdNyjqce6vw+Ljjom9DjtRIAzFikOQal5bw
 UlJrtqrHneqiCLbDo9ir5hvAy2meT74vs9Et8GMIOcwg0GPUNn6GjfVQqwC7Id2UK7aqtP2nK
 8eYx2feYVX28AxmpXJjg==
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
Reply-To: harv@gmx.de
Content-Type: multipart/mixed; boundary="===============0462031968=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0462031968==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hDJFAIjsVPuHYSukNpQEcmiPObeRc7IKF"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hDJFAIjsVPuHYSukNpQEcmiPObeRc7IKF
Content-Type: multipart/mixed; boundary="PAOFvJZ5u3HS3MkIaf87zWx7RIyCDde7E";
 protected-headers="v1"
From: Harvey <harv@gmx.de>
Reply-To: harv@gmx.de
To: amd-gfx@lists.freedesktop.org
Message-ID: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
Subject: Amdgpu kernel oops and freezing on system suspend and hibernate

--PAOFvJZ5u3HS3MkIaf87zWx7RIyCDde7E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello,

I own a laptop, a MSI Bravo 17 A4DDR/MS-17FK
with Ryzen 7 4800U and hybrid graphics on a Radeon RX 5500M.

DMI: Micro-Star International Co., Ltd. Bravo 17 A4DDR/MS-17FK, BIOS=20
E17FKAMS.117 10/29/2020

The system does not hibernate, it just freezes. Starting after a reset=20
it then resumes from the swap partition and gets the system up, but=20
shortly after that freezes again.

Even suspending is not working properly - on archlinux with kernel=20
5.11.6 and on 5.12-rc1 I see the following kernel oopses after resume:

The output of dmesg -l err,warn is:

[11020.188925] ------------[ cut here ]------------
[11020.188929] WARNING: CPU: 0 PID: 7736 at=20
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:2574=20
dc_link_set_backlight_level+0x8a/0xf0 [amdgpu]
[11020.189314] Modules linked in: rfcomm snd_hda_codec_realtek=20
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi cmac algif_hash=20
algif_skcipher af_alg bnep intel_rapl_msr intel_rapl_common iwlmvm=20
snd_hda_intel snd_intel_dspcfg soundwire_intel=20
soundwire_generic_allocation soundwire_cadence nls_iso8859_1 vfat=20
mac80211 snd_hda_codec fat edac_mce_amd uvcvideo btusb snd_hda_core=20
kvm_amd btrtl libarc4 videobuf2_vmalloc btbcm snd_hwdep videobuf2_memops =

hid_multitouch soundwire_bus videobuf2_v4l2 btintel pktcdvd iwlwifi=20
snd_soc_core kvm videobuf2_common bluetooth snd_compress videodev=20
ac97_bus snd_pcm_dmaengine snd_pcm snd_timer irqbypass msi_wmi=20
ecdh_generic joydev mousedev cfg80211 mc ecc rapl snd psmouse=20
snd_rn_pci_acp3x pcspkr sparse_keymap k10temp i2c_piix4 snd_pci_acp3x=20
soundcore rfkill tpm_crb tpm_tis tpm_tis_core pinctrl_amd i2c_hid=20
acpi_cpufreq mac_hid soc_button_array vboxnetflt(OE) vboxnetadp(OE)=20
vboxdrv(OE) usbip_host usbip_core sg fuse crypto_user bpf_preload=20
ip_tables x_tables
[11020.189400]  ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom uas=20
usb_storage dm_crypt cbc encrypted_keys dm_mod trusted tpm=20
crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel=20
aesni_intel crypto_simd cryptd glue_helper serio_raw ccp xhci_pci=20
xhci_pci_renesas rng_core wmi video usbhid r8168(OE) amdgpu=20
drm_ttm_helper ttm gpu_sched i2c_algo_bit drm_kms_helper syscopyarea=20
sysfillrect sysimgblt fb_sys_fops cec drm agpgart
[11020.189445] CPU: 0 PID: 7736 Comm: systemd-sleep Tainted: G=20
  OE     5.11.6-arch1-1 #1
[11020.189450] Hardware name: Micro-Star International Co., Ltd. Bravo=20
17 A4DDR/MS-17FK, BIOS E17FKAMS.117 10/29/2020
[11020.189453] RIP: 0010:dc_link_set_backlight_level+0x8a/0xf0 [amdgpu]
[11020.189792] Code: 88 03 00 00 31 c0 48 8d 96 f0 01 00 00 48 8b 0a 48=20
85 c9 74 06 48 3b 59 08 74 20 83 c0 01 48 81 c2 d0 04 00 00 83 f8 06 75=20
e3 <0f> 0b 45 31 e4 5b 44 89 e0 5d 41 5c 41 5d 41 5e c3 48 98 48 69 c0
[11020.189795] RSP: 0018:ffffc1f003373c38 EFLAGS: 00010246
[11020.189799] RAX: 0000000000000006 RBX: ffff9e244e0ea800 RCX:=20
0000000000000000
[11020.189802] RDX: ffff9e2582fe1ed0 RSI: ffff9e2582fe0000 RDI:=20
0000000000000000
[11020.189804] RBP: ffff9e244e0f0000 R08: 00000000000000f9 R09:=20
ffff9e244323a000
[11020.189806] R10: ffff9e244323ae40 R11: 0000000001320122 R12:=20
000000000000fa01
[11020.189808] R13: 0000000000000000 R14: 000000000000fa42 R15:=20
0000000000000003
[11020.189810] FS:  00007f6219470a40(0000) GS:ffff9e275f600000(0000)=20
knlGS:0000000000000000
[11020.189813] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11020.189815] CR2: 00007fb7a8980180 CR3: 0000000109cae000 CR4:=20
0000000000350ef0
[11020.189818] Call Trace:
[11020.189828]  amdgpu_dm_backlight_update_status+0xb4/0xc0 [amdgpu]
[11020.190185]  backlight_suspend+0x6a/0x80
[11020.190192]  ? brightness_store+0x80/0x80
[11020.190197]  dpm_run_callback+0x4c/0x150
[11020.190202]  __device_suspend+0x11c/0x4d0
[11020.190205]  dpm_suspend+0xef/0x230
[11020.190209]  dpm_suspend_start+0x77/0x80
[11020.190213]  suspend_devices_and_enter+0x109/0x800
[11020.190219]  pm_suspend.cold+0x329/0x374
[11020.190225]  state_store+0x71/0xd0
[11020.190230]  kernfs_fop_write_iter+0x124/0x1b0
[11020.190236]  new_sync_write+0x159/0x1f0
[11020.190241]  vfs_write+0x1fc/0x2a0
[11020.190245]  ksys_write+0x67/0xe0
[11020.190249]  do_syscall_64+0x33/0x40
[11020.190255]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[11020.190261] RIP: 0033:0x7f6219de10f7
[11020.190265] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f=20
1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f=20
05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[11020.190268] RSP: 002b:00007fff7ae91318 EFLAGS: 00000246 ORIG_RAX:=20
0000000000000001
[11020.190272] RAX: ffffffffffffffda RBX: 0000000000000004 RCX:=20
00007f6219de10f7
[11020.190275] RDX: 0000000000000004 RSI: 00007fff7ae91400 RDI:=20
0000000000000004
[11020.190276] RBP: 00007fff7ae91400 R08: 000055e3a1261b70 R09:=20
00007f6219e770c0
[11020.190278] R10: 00007f6219e76fc0 R11: 0000000000000246 R12:=20
0000000000000004
[11020.190280] R13: 000055e3a125d3c0 R14: 0000000000000004 R15:=20
00007f6219eb3700
[11020.190284] ---[ end trace e7dfefa87a0c3feb ]---
[11020.853160] IRQ 85: no longer affine to CPU1
[11020.856648] IRQ 86: no longer affine to CPU2
[11020.859859] IRQ 87: no longer affine to CPU3
[11020.862584] IRQ 88: no longer affine to CPU4
[11020.865211] IRQ 89: no longer affine to CPU5
[11020.867656] IRQ 90: no longer affine to CPU6
[11020.870520] IRQ 91: no longer affine to CPU7
[11020.873539] IRQ 92: no longer affine to CPU8
[11020.876530] IRQ 93: no longer affine to CPU9
[11020.879551] IRQ 94: no longer affine to CPU10
[11023.064667] amdgpu 0000:03:00.0: amdgpu: SMU driver if version not=20
matched

the lspci -k output is:

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Root Compl=
ex
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe=20
Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP=20
Bridge
	Kernel driver in use: pcieport
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe=20
Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP=20
Bridge
	Kernel driver in use: pcieport
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP=20
Bridge
	Kernel driver in use: pcieport
00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP=20
Bridge
	Kernel driver in use: pcieport
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe=20
Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal=20
PCIe GPP Bridge to Bus
	Kernel driver in use: pcieport
00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal=20
PCIe GPP Bridge to Bus
	Kernel driver in use: pcieport
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller=20
(rev 51)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c_piix4, sp5100_tco
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge=20
(rev 51)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
24: Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
24: Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
24: Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
24: Function 3
	Kernel driver in use: k10temp
	Kernel modules: k10temp
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
24: Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
24: Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
24: Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device=20
24: Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL=20
Upstream Port of PCI Express Switch (rev c1)
	Kernel driver in use: pcieport
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL=20
Downstream Port of PCI Express Switch
	Kernel driver in use: pcieport
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi=20
14 [Radeon RX 5500/5500M / Pro 5500M] (rev c1)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10=20
HDMI Audio
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
	Subsystem: Intel Corporation Device 0084
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.=20
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: r8168
	Kernel modules: r8169, r8168
06:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe=20
SSD Controller SM981/PM981/PM983
	Subsystem: Samsung Electronics Co Ltd Device a801
	Kernel driver in use: nvme
07:00.0 VGA compatible controller: Advanced Micro Devices, Inc.=20
[AMD/ATI] Renoir (rev c6)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu
07:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family =

17h (Models 10h-1fh) Platform Security Processor
	Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models=20
10h-1fh) Platform Security Processor
	Kernel driver in use: ccp
	Kernel modules: ccp
07:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1=

	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci
07:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1=

	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci
07:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]=20
Raven/Raven2/FireFlight/Renoir Audio Processor (rev 01)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x
07:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h=20
(Models 10h-1fh) HD Audio Controller
	DeviceName: HD Audio Controller
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
08:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA=20
Controller [AHCI mode] (rev 81)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: ahci
08:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA=20
Controller [AHCI mode] (rev 81)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: ahci

I suppose the amdgpu module is at fault here?

Greetings
Harvey


--PAOFvJZ5u3HS3MkIaf87zWx7RIyCDde7E--

--hDJFAIjsVPuHYSukNpQEcmiPObeRc7IKF
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wmMEABEIACMWIQRSRNvmxYqoNs6vm0SLlqqYsFRKCQUCYFIsYwUDAAAAAAAKCRCLlqqYsFRKCXUx
AKCEzeayL2VFs9niuIJUZRzMCHb85gCfSMn9bYXljAY+hAbrzPz8HA7nTQE=
=ZOgC
-----END PGP SIGNATURE-----

--hDJFAIjsVPuHYSukNpQEcmiPObeRc7IKF--

--===============0462031968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0462031968==--
