Return-Path: <SRS0=r3ut=A7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F253CC433E4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 08:21:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A0A21775
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 08:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="O7TMBOB2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A0A21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A85989E06;
	Mon, 20 Jul 2020 08:21:58 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 731FB89E06
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2020 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595233314;
 bh=1Q7CjeZf8Y3L/2Og33g51uL2ERmJH8GC1QbBVlEWQKs=;
 h=X-UI-Sender-Class:To:Reply-To:From:Subject:Date;
 b=O7TMBOB2biHuJEE7lBMCQJOXk5ZxStIQo57c2gaHFuAZV6+uapb193ToabFKfy8Cc
 ft1sk+0Z9Wgc3XUVQrqKjLaTIEld02Bo5Qs1n9nzdB1/Uvd5d7D1oeHMRQIzFmHBWO
 mRoTkl3DcLFE77r0/ZrjJDGeg1P3F+gWcOlb+7eM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.5] ([178.27.135.239]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1kXsL81nO0-00cjZ5 for
 <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2020 10:21:54 +0200
To: amd-gfx@lists.freedesktop.org
From: Harvey <harv@gmx.de>
Subject: Amdgpu kernel oops and freezing graphics
Message-ID: <44e135ed-dfb7-533f-3c55-8e852a349762@gmx.de>
Date: Mon, 20 Jul 2020 10:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:iwj7ZP8YNlkggu20ITmstlyuKRIreO7ekbU4+rwu0Bk1Iaqm8Ub
 1t0LQfrJOwnei2gnKDSsDB5BAdptC8Y0UJuY6RrY8C/cBM+wtvZR7GCQbMZJ9+hEx/6ucgc
 pHBKtLkMYUTML3gbqyXCGpJepjH14bjva/mJeadLp3uYeQk20GUg1AXLlMQKBKcvlUNatEs
 R+lX8QGeSYzCFqrePdUow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G30ZQ+LzJTo=:95xsb1namx+m6rpRAB7HFC
 qTw4ZIGoBFB68MZ6mIBkuDF+yqENxzilvaCGRn5cAqA/NQLj51BSHrtG2FSl7PUElSxWqMgWr
 dG/D9WRkAviPEWpu1XZtMpYmLFCxhyB1W+ZPXB8QGaAJqMJtQf6SpS0hYra5ke0Q6flhM/a7D
 kfiJYzk1qOK+8BSOYTDTT2AdkkkYQi8oE464DIOp2icAtDCpUupRDifo6rKhS4kqDMocVudIZ
 p7II7AraPa31072Z97OzvB/KXOlNP1Vqfj75+j2cCozOjOSnR2Gl4mytQNBokXDUApphPkey7
 4MehuxZm5VzsTcTt1ryHaxsdGovvwf28umSk6CKnjqal+q5Acw+mxkpXpo6IQk4hrFWZIvJcn
 KHMvK1qtLzQgdCcNaIrqLX7m93CRupIAxkmCJuXQA6SZpRB4HR+sygXYZwP4RtObOeyp1yP/w
 3wu78gKFxixwhq+uF3/C9rTp+IrDR1iynsCOddM7sOC2E3BzpI2BfMbtxRm5T6GkDIp97GKYI
 MtuTP4s9zGyU3m25xOV5WT1SlUYgiocA34HFtLWnQZrqEFmqVea76guiggLtTU4MiIaxcWFP1
 OOvCZkxwo2VZl0PymXe7YU2igbcBix6X8uJUv2S8sg8w43xKpK4kngnkWof1z9HPkOkifHaUU
 +ZnDbzRkt9wRKhqeGSmeoHOKElHUXnU6j8WUpeeEw1VtNGZhyIx2zPi2NKo4gkea6SS1E7fgN
 gWH2gLkR/CbcXz+gCOQUBJxAC76sTv8stvvlNuk9vr6J/XIGGeKj3rNG1B8YzvpoaarywWL34
 1Knjd8fyy7lK/aFXkuItjTR6Wflr/4xXO7cPj/FCukru4FECWW3I9zzQKZL508RCbiSohueTB
 O3eKCQ0bfWy3epd6/QNFUaoUd4T5lp5iNgRZzCxynnESGq8fcUHoDb19XxDJRNr5eTp6p9HED
 pdQShewzfHr0sALt+vn/hWE6Mznk5jwzinH1XFYLbe2/aV+ZfG2PKnk322HggrU1duR+phXT9
 X87ek3PaaFdMj4OrqBLjNRU6/Otyhmivomaf0UL+joE6N/MRrtXo9NWLoe9wzpfWtQzeRGO8d
 PG/0V7Sjwh4MaSd5ExD7uarVgJg7nMgfSxR+wnXulSdEkdcUrkJSoNKNY8vd60b0LHZL0cJpD
 yfJfWnAi3X708eLJPqdaDdHpY4c4X9RBt1VejV/WqWhrr9Cr9HMPw74EpYJzhXqPMZJxK8y/H
 3+marn3cvgLZEx2so
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

this is my first post to this list so please be patient with me ;)

The facts:

it is now one week that I own a new laptop, a MSI Bravo 17 A4DDR/MS-17FK
with Ryzen 7 4800U and hybrid graphics on a Radeon RX 5500M. I installed
my beloved Archlinux but I can't start any graphics withpout kernel oops
on it beside the normal console, even calling 'lspci' on the console is
provoking errors.

I am using linux kernel 5.7.9 and linux-firmware 20200619.e96c121

(FWIW: I even tried with a self-cmpiled kernel 5.8-rc5 and
linux-firmware directly from the git repository - no changes)

The following is only part of the information I can provide but I didn't
want to make this mail bigger than it already is.

the lspci -k output is:

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
	Subsystem: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe
Dummy Host Bridge
00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP
Bridge
	Kernel driver in use: pcieport
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe
Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP
Bridge
	Kernel driver in use: pcieport
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP
Bridge
	Kernel driver in use: pcieport
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe
Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal
PCIe GPP Bridge to Bus
	Kernel driver in use: pcieport
00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal
PCIe GPP Bridge to Bus
	Kernel driver in use: pcieport
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
(rev 51)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c_piix4, sp5100_tco
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
(rev 51)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 3
	Kernel driver in use: k10temp
	Kernel modules: k10temp
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device
24: Function 7
01:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
Upstream Port of PCI Express Switch (rev c1)
	Kernel driver in use: pcieport
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 XL
Downstream Port of PCI Express Switch
	Kernel driver in use: pcieport
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi
14 [Radeon RX 5500/5500M / Pro 5500M] (rev c1)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu
03:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Navi 10
HDMI Audio
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
04:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
	Subsystem: Intel Corporation Device 0084
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi
05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: r8169
	Kernel modules: r8169
06:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Renoir (rev c6)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu
06:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family
17h (Models 10h-1fh) Platform Security Processor
	Subsystem: Advanced Micro Devices, Inc. [AMD] Family 17h (Models
10h-1fh) Platform Security Processor
	Kernel driver in use: ccp
	Kernel modules: ccp
06:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci
06:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci
06:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD]
Raven/Raven2/FireFlight/Renoir Audio Processor (rev 01)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel modules: snd_pci_acp3x
06:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h
(Models 10h-1fh) HD Audio Controller
	DeviceName: HD Audio Controller
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel
07:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 81)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: ahci
07:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA
Controller [AHCI mode] (rev 81)
	Subsystem: Micro-Star International Co., Ltd. [MSI] Device 12ac
	Kernel driver in use: ahci

The output of dmesg -l err,warn is:

[    0.335758] TSC synchronization [CPU#0 -> CPU#8]:
[    0.335759] Measured 4524 cycles TSC warp between CPUs, turning off
TSC clock.
[    0.335763]   #9 #10 #11 #12 #13 #14 #15
[    0.388723] Expanded resource Reserved due to conflict with PCI Bus
0000:00
[    0.495565] pci 0000:00:00.2: can't derive routing for PCI INT A
[    0.495566] pci 0000:00:00.2: PCI INT A: not connected
[    0.497518]  PPR X2APIC NX GT IA GA PC GA_vAPIC
[    0.507325] efifb: Ignoring BGRT: unexpected or invalid BMP data
[    0.535452] Unstable clock detected, switching default tracing clock
to "global"
                If you want to keep using the local clock, then add:
                  "trace_clock=local"
                on the kernel command line
[    1.822245] soc_button_array ACPI0011:00: Unknown button index 0
upage 01 usage c6, ignoring
[    1.843906] i2c_hid i2c-PNP0C50:0b: supply vdd not found, using dummy
regulator
[    1.843924] i2c_hid i2c-PNP0C50:0b: supply vddl not found, using
dummy regulator
[    1.865149] snd_pci_acp3x 0000:06:00.5: Invalid ACP audio mode : 0
[    1.914676] sp5100-tco sp5100-tco: Watchdog hardware is disabled
[    1.933349] platform regulatory.0: Direct firmware load for
regulatory.db failed with error -2
[    2.057649] iwlwifi 0000:04:00.0: api flags index 2 larger than
supported by driver
[    2.057914] iwlwifi 0000:04:00.0: Direct firmware load for
iwl-debug-yoyo.bin failed with error -2
[    2.256189] uvcvideo 1-4:1.0: Entity type for entity Extension 4 was
not initialized!
[    2.256194] uvcvideo 1-4:1.0: Entity type for entity Extension 3 was
not initialized!
[    2.256196] uvcvideo 1-4:1.0: Entity type for entity Processing 2 was
not initialized!
[    2.256198] uvcvideo 1-4:1.0: Entity type for entity Camera 1 was not
initialized!
[    2.373041] ATPX version 1, functions 0x00000001
[    2.373173] ATPX Hybrid Graphics
[    2.393743] [drm:amdgpu_get_bios [amdgpu]] *ERROR* ACPI VFCT table
present but broken (too short #2)
[    2.615299] thermal thermal_zone1: failed to read out thermal zone (-61)
[    3.268390] SMU driver if version not matched
[    3.989144] sos fw version = 0x110d32.
[    4.160713] SMU driver if version not matched
[    4.294363] [drm:mod_hdcp_add_display_to_topology [amdgpu]] *ERROR*
Failed to add display topology, DTM TA is not initialized.
[    4.294366] [drm] [Link 0] WARNING MOD_HDCP_STATUS_FAILURE IN STATE
HDCP_UNINITIALIZED STAY COUNT 0
[    5.705210] kauditd_printk_skb: 21 callbacks suppressed
[   13.102593] kauditd_printk_skb: 10 callbacks suppressed
[   26.297372] kauditd_printk_skb: 13 callbacks suppressed
[   32.442652] kauditd_printk_skb: 6 callbacks suppressed
[  415.086058] failed send message:     RunBtc (58) 	param: 0x00000000
response 0xffffffc2
[  415.086059] RunBtc failed!
[  415.086101] [drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR*
resume of IP block <smu> failed -62
[  415.086138] [drm:amdgpu_device_resume [amdgpu]] *ERROR*
amdgpu_device_ip_resume failed (-62).
[  415.204513] snd_hda_intel 0000:03:00.1: CORB reset timeout#2, CORBRP
= 65535
[  421.356866] ------------[ cut here ]------------
[  421.357046] WARNING: CPU: 9 PID: 680 at
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1517
dm_suspend+0x4e/0x60 [amdgpu]
[  421.357047] Modules linked in: iwlmvm joydev snd_hda_codec_realtek
mousedev amdgpu uvcvideo mac80211 snd_hda_codec_generic
snd_hda_codec_hdmi btusb videobuf2_vmalloc ledtrig_audio
videobuf2_memops btrtl edac_mce_amd btbcm videobuf2_v4l2 btintel kvm_amd
hid_multitouch snd_hda_intel msi_wmi videobuf2_common libarc4 bluetooth
snd_intel_dspcfg hid_generic sparse_keymap kvm snd_hda_codec videodev
nls_iso8859_1 nls_cp437 gpu_sched i2c_algo_bit vfat ecdh_generic fat ttm
irqbypass iwlwifi mc ecc snd_hda_core drm_kms_helper snd_hwdep snd_pcm
crct10dif_pclmul crc32_pclmul r8169 cec ghash_clmulni_intel snd_timer
cfg80211 aesni_intel rc_core syscopyarea sysfillrect snd crypto_simd
sp5100_tco realtek sysimgblt cryptd glue_helper fb_sys_fops psmouse ccp
pcspkr input_leds i2c_piix4 k10temp snd_pci_acp3x soundcore libphy
rfkill wmi battery ac i2c_hid tpm_crb hid tpm_tis tpm_tis_core tpm evdev
mac_hid pinctrl_amd rng_core acpi_cpufreq soc_button_array drm
crypto_user agpgart ip_tables x_tables serio_raw
[  421.357115]  atkbd libps2 xhci_pci xhci_hcd i8042 serio ext4
crc32c_generic crc32c_intel crc16 mbcache jbd2
[  421.357128] CPU: 9 PID: 680 Comm: kworker/9:2 Not tainted
5.7.9-arch1-1 #1
[  421.357130] Hardware name: Micro-Star International Co., Ltd. Bravo
17 A4DDR/MS-17FK, BIOS E17FKAMS.113 05/18/2020
[  421.357138] Workqueue: pm pm_runtime_work
[  421.357296] RIP: 0010:dm_suspend+0x4e/0x60 [amdgpu]
[  421.357299] Code: 00 48 89 83 20 47 01 00 e8 ef fd ff ff 48 89 df e8
27 a1 00 00 48 8b bb a0 2c 01 00 be 08 00 00 00 e8 86 c2 0f 00 31 c0 5b
c3 <0f> 0b eb c1 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 0f 1f 44 00
[  421.357300] RSP: 0018:ffffb34c00b4fcb0 EFLAGS: 00010286
[  421.357302] RAX: ffffffffc10af180 RBX: ffffa34103ca0000 RCX:
0000000000000000
[  421.357304] RDX: 000000000000000a RSI: 0000000000000ff8 RDI:
ffffa34103ca0000
[  421.357305] RBP: 0000000000000005 R08: 0000000000000000 R09:
0000000000000000
[  421.357306] R10: 0000000000000002 R11: 00000000000000f0 R12:
ffffa34103ca0000
[  421.357307] R13: ffffa3411c4030b0 R14: ffffa34103ca0000 R15:
ffffa3411f86c9b0
[  421.357309] FS:  0000000000000000(0000) GS:ffffa3411f840000(0000)
knlGS:0000000000000000
[  421.357311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  421.357312] CR2: 00005562a24d6010 CR3: 00000003d240a000 CR4:
0000000000340ee0
[  421.357313] Call Trace:
[  421.357433]  amdgpu_device_ip_suspend_phase1+0x83/0xe0 [amdgpu]
[  421.357546]  amdgpu_device_suspend+0x9b/0x2c0 [amdgpu]
[  421.357553]  ? update_blocked_averages+0x539/0x620
[  421.357664]  amdgpu_pmops_runtime_suspend+0x9e/0x140 [amdgpu]
[  421.357672]  pci_pm_runtime_suspend+0x5e/0x170
[  421.357678]  ? __switch_to_asm+0x40/0x70
[  421.357683]  ? vga_switcheroo_runtime_resume+0x60/0x60
[  421.357686]  vga_switcheroo_runtime_suspend+0x22/0xb0
[  421.357689]  ? vga_switcheroo_runtime_resume+0x60/0x60
[  421.357692]  ? vga_switcheroo_runtime_resume+0x60/0x60
[  421.357694]  __rpm_callback+0x7b/0x130
[  421.357697]  ? vga_switcheroo_runtime_resume+0x60/0x60
[  421.357700]  rpm_callback+0x1f/0x70
[  421.357703]  ? vga_switcheroo_runtime_resume+0x60/0x60
[  421.357705]  rpm_suspend+0x174/0x6d0
[  421.357709]  pm_runtime_work+0x94/0xa0
[  421.357714]  process_one_work+0x1da/0x3d0
[  421.357717]  worker_thread+0x4d/0x3e0
[  421.357720]  ? rescuer_thread+0x3f0/0x3f0
[  421.357722]  kthread+0x13e/0x160
[  421.357726]  ? __kthread_bind_mask+0x60/0x60
[  421.357728]  ret_from_fork+0x22/0x40
[  421.357733] ---[ end trace 7a1af789893080c1 ]---
[  421.357928] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  421.357931] CPU: 9 PID: 680 Comm: kworker/9:2 Tainted: G        W
     5.7.9-arch1-1 #1
[  421.357932] Hardware name: Micro-Star International Co., Ltd. Bravo
17 A4DDR/MS-17FK, BIOS E17FKAMS.113 05/18/2020
[  421.357936] Workqueue: pm pm_runtime_work
[  421.358078] RIP: 0010:kernel_queue_uninit+0xd/0xf0 [amdgpu]
[  421.358081] Code: ee 48 89 c7 e8 a4 f9 ff ff 84 c0 0f 84 3a 40 1a 00
4c 89 e0 5d 41 5c 41 5d c3 0f 1f 00 0f 1f 44 00 00 55 48 8b 47 10 48 89
fd <8b> 50 28 83 fa 02 74 78 83 fa 03 0f 84 b1 00 00 00 48 8b 7f 08 4c
[  421.358083] RSP: 0018:ffffb34c00b4fca8 EFLAGS: 00010246
[  421.358085] RAX: 0000000000000010 RBX: ffffa341022cdc00 RCX:
0000000080800076
[  421.358087] RDX: 0000000080800077 RSI: 0000000000000000 RDI:
ffffa3411c874a80
[  421.358089] RBP: ffffa3411c874a80 R08: 0000000000000001 R09:
0000000000000001
[  421.358091] R10: ffffa34118da0660 R11: dead000000000100 R12:
ffffa341022cdd28
[  421.358092] R13: ffffa3411c4030b0 R14: ffffa34103ca0000 R15:
ffffa3411f86c9b0
[  421.358095] FS:  0000000000000000(0000) GS:ffffa3411f840000(0000)
knlGS:0000000000000000
[  421.358097] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  421.358098] CR2: 0000000000000038 CR3: 00000003d240a000 CR4:
0000000000340ee0
[  421.358100] Call Trace:
[  421.358240]  stop_cpsch+0x97/0xc0 [amdgpu]
[  421.358376]  kgd2kfd_suspend.part.0+0x2f/0x40 [amdgpu]
[  421.358489]  amdgpu_device_suspend+0xa7/0x2c0 [amdgpu]
[  421.358493]  ? update_blocked_averages+0x539/0x620
[  421.358604]  amdgpu_pmops_runtime_suspend+0x9e/0x140 [amdgpu]
[  421.358609]  pci_pm_runtime_suspend+0x5e/0x170
[  421.358612]  ? __switch_to_asm+0x40/0x70
[  421.358616]  ? vga_switcheroo_runtime_resume+0x60/0x60
[  421.358619]  vga_switcheroo_runtime_suspend+0x22/0xb0
[  421.358622]  ? vga_switcheroo_runtime_resume+0x60/0x60
[  421.358625]  ? vga_switcheroo_runtime_resume+0x60/0x60
[  421.358628]  __rpm_callback+0x7b/0x130
[  421.358631]  ? vga_switcheroo_runtime_resume+0x60/0x60
[  421.358634]  rpm_callback+0x1f/0x70
[  421.358637]  ? vga_switcheroo_runtime_resume+0x60/0x60
[  421.358640]  rpm_suspend+0x174/0x6d0
[  421.358645]  pm_runtime_work+0x94/0xa0
[  421.358648]  process_one_work+0x1da/0x3d0
[  421.358651]  worker_thread+0x4d/0x3e0
[  421.358654]  ? rescuer_thread+0x3f0/0x3f0
[  421.358657]  kthread+0x13e/0x160
[  421.358660]  ? __kthread_bind_mask+0x60/0x60
[  421.358663]  ret_from_fork+0x22/0x40
[  421.358667] Modules linked in: iwlmvm joydev snd_hda_codec_realtek
mousedev amdgpu uvcvideo mac80211 snd_hda_codec_generic
snd_hda_codec_hdmi btusb videobuf2_vmalloc ledtrig_audio
videobuf2_memops btrtl edac_mce_amd btbcm videobuf2_v4l2 btintel kvm_amd
hid_multitouch snd_hda_intel msi_wmi videobuf2_common libarc4 bluetooth
snd_intel_dspcfg hid_generic sparse_keymap kvm snd_hda_codec videodev
nls_iso8859_1 nls_cp437 gpu_sched i2c_algo_bit vfat ecdh_generic fat ttm
irqbypass iwlwifi mc ecc snd_hda_core drm_kms_helper snd_hwdep snd_pcm
crct10dif_pclmul crc32_pclmul r8169 cec ghash_clmulni_intel snd_timer
cfg80211 aesni_intel rc_core syscopyarea sysfillrect snd crypto_simd
sp5100_tco realtek sysimgblt cryptd glue_helper fb_sys_fops psmouse ccp
pcspkr input_leds i2c_piix4 k10temp snd_pci_acp3x soundcore libphy
rfkill wmi battery ac i2c_hid tpm_crb hid tpm_tis tpm_tis_core tpm evdev
mac_hid pinctrl_amd rng_core acpi_cpufreq soc_button_array drm
crypto_user agpgart ip_tables x_tables serio_raw
[  421.358700]  atkbd libps2 xhci_pci xhci_hcd i8042 serio ext4
crc32c_generic crc32c_intel crc16 mbcache jbd2
[  421.358710] CR2: 0000000000000038
[  421.358714] ---[ end trace 7a1af789893080c2 ]---
[  421.358848] RIP: 0010:kernel_queue_uninit+0xd/0xf0 [amdgpu]
[  421.358851] Code: ee 48 89 c7 e8 a4 f9 ff ff 84 c0 0f 84 3a 40 1a 00
4c 89 e0 5d 41 5c 41 5d c3 0f 1f 00 0f 1f 44 00 00 55 48 8b 47 10 48 89
fd <8b> 50 28 83 fa 02 74 78 83 fa 03 0f 84 b1 00 00 00 48 8b 7f 08 4c
[  421.358853] RSP: 0018:ffffb34c00b4fca8 EFLAGS: 00010246
[  421.358855] RAX: 0000000000000010 RBX: ffffa341022cdc00 RCX:
0000000080800076
[  421.358857] RDX: 0000000080800077 RSI: 0000000000000000 RDI:
ffffa3411c874a80
[  421.358858] RBP: ffffa3411c874a80 R08: 0000000000000001 R09:
0000000000000001
[  421.358860] R10: ffffa34118da0660 R11: dead000000000100 R12:
ffffa341022cdd28
[  421.358862] R13: ffffa3411c4030b0 R14: ffffa34103ca0000 R15:
ffffa3411f86c9b0
[  421.358864] FS:  0000000000000000(0000) GS:ffffa3411f840000(0000)
knlGS:0000000000000000
[  421.358866] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  421.358868] CR2: 0000000000000038 CR3: 00000003d240a000 CR4:
0000000000340ee0

I suppose the amdgpu module is at fault here?

Greetings
Harvey

--
I am root. If you see me laughing, you'd better have a backup!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
