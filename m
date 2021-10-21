Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590D8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 22:55:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD566128E
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 22:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9DD566128E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gabscap.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E77176E4EA;
	Thu, 21 Oct 2021 22:55:40 +0000 (UTC)
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Thu, 21 Oct 2021 22:55:38 UTC
Received: from mo4-p05-ob.smtp.rzone.de (mo4-p05-ob.smtp.rzone.de
 [85.215.255.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72466E4E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 22:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1634856392;
 s=strato-dkim-0002; d=gabriel-paradzik.de;
 h=Cc:To:Subject:From:Date:Message-ID:Cc:Date:From:Subject:Sender;
 bh=Fa0WnLh5+wQoYeJ1G2UcMfHfu2ZI/ky+mBzhdIFDqx0=;
 b=a5XjZ03Fv3zFCHV+/0s5oC4HZI47/I39tHZJCEu/K5wXcrVLk3O+AB4SGljSwl6Zv0
 Sw+idHUed7cTUutmpMlVwY2rd3dnZ2msLYNlKY9oPDMzyJJ6wy4xwBRS7i2n+cjVeou7
 8laLS78VYs0J6lO0JQhvw5vbGxJ2itXaRrWN+YCgPSRIEuHSLxNzvn8ZfHcRdYYYPtNh
 z+T675XgPcGsKH9dRVeFp2mfitdFeFEQKTEMgt7YPZTm3l7534cUoboziE0RKs5rBKA5
 cpQr1l37MarIN6ylfj2m8hpOvcDZCm1y0IqlrPbqAlPfHXrCb83Rpo13fobl0a+mbw6D
 BNwg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGMJcGCvev1+wXhJKJGLVC2PtapONPIil7eeggaqdH00btp3h3Y1fWtFwZmTMKmexf356jIFu9LB0bgeHSgF8smlW+Y4gzEseUemnqpe/Kk7p5xO"
X-RZG-CLASS-ID: mo05
Received: from [IPV6:2a02:8070:8ac0:c200:ef09:fbb1:8bb4:643b]
 by smtp.strato.de (RZmta 47.33.8 AUTH)
 with ESMTPSA id z012c2x9LMkWx9W
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Fri, 22 Oct 2021 00:46:32 +0200 (CEST)
Message-ID: <65fe9427-f649-596d-21dc-95c3f621b4eb@gabscap.de>
Date: Fri, 22 Oct 2021 00:46:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: de-DE
From: Gabriel <git@gabscap.de>
Subject: PROBLEM: Laptop kills USB-C hubs
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

[1.] One line summary of the problem:

Laptop kills USB-C hubs.


[2.] Full description of the problem/report:

I own a ThinkPad T14s (AMD) and used a USB-C Hub [a] without any 
problems for half a year. Then, I bought a new ThinkPad E15 Gen3 (AMD) 
and used it with my USB-C hub, which worked fine at the beginning. After 
a few days, the USB-C hub stopped working. I thought nothing of it and 
ordered a new one [b].
The new one worked fine for 1-2 days, until the HDMI ports stopped 
working while being connected to the new laptop. USB/Ethernet ports 
continued to work.
I ordered the USB-C hub [b] again. Same story, except it died 
completely. All ports stopped working.

I noticed a kernel warning [6.], which is the same for all three USB-C 
hub deaths. This only happened after the system woke up from susped mode.

I dont't know if this is a hardware or kernel issue. Unfortunately I 
can't debug this any further, because I don't have any excess USB-C hubs 
to brick.

[a] https://uniaccessories [dot] com/products/usb-c_8in1_hub
[b] https://www [dot] amazon [dot] 
de/gp/product/B08LDGYM2W/ref=ppx_yo_dt_b_asin_title_o01_s00?ie=UTF8&psc=1


[3.] Keywords (i.e., modules, networking, kernel):

amd display


[4.] Kernel information
[4.1.] Kernel version (from /proc/version):

Linux version 5.14.10-1-MANJARO (builduser@fv-az72-723) (gcc (GCC) 
11.1.0, GNU ld (GNU Binutils) 2.36.1) #1 SMP PREEMPT Thu Oct 7 06:43:34 
UTC 2021


[4.2.] Kernel .config file:
[5.] Most recent kernel version which did not have the bug:
[6.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/admin-guide/bug-hunting.rst)

[Do Okt 21 22:29:12 2021] WARNING: CPU: 13 PID: 3789 at 
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_link_encoder.c:216 
dcn21_link_encoder_acquire_phy+0x11d/0x160 [amdgpu]
[Do Okt 21 22:29:12 2021] Modules linked in: ccm rfcomm snd_usb_audio 
snd_usbmidi_lib snd_rawmidi snd_seq_device usbhid r8153_ecm cdc_ether 
usbnet r8152 mii cmac algif_hash algif_skcipher af_alg bnep btusb btrtl 
btbcm btintel uvcvideo bluetooth videobuf2_vmalloc videobuf2_memops 
videobuf2_v4l2 videobuf2_common videodev ecdh_generic ecc mc amdgpu 
snd_ctl_led snd_hda_codec_realtek joydev snd_hda_codec_generic 
snd_hda_codec_hdmi mousedev gpu_sched i2c_algo_bit drm_ttm_helper 
snd_hda_intel ttm snd_intel_dspcfg snd_intel_sdw_acpi drm_kms_helper 
snd_hda_codec snd_hda_core cec snd_hwdep agpgart snd_pcm syscopyarea 
intel_rapl_msr sysfillrect sysimgblt snd_rn_pci_acp3x intel_rapl_common 
fb_sys_fops snd_timer snd_pci_acp3x qrtr edac_mce_amd ns kvm_amd 
rtw88_8822ce rtw88_8822c ccp rtw88_pci rtw88_core kvm squashfs irqbypass 
mac80211 crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel 
ucsi_acpi crypto_simd r8169 wmi_bmof thinkpad_acpi cryptd typec_ucsi 
realtek vfat mdio_devres platform_profile
[Do Okt 21 22:29:12 2021]  sp5100_tco cfg80211 fat typec rapl psmouse 
libphy ledtrig_audio pcspkr tpm_crb libarc4 k10temp i2c_piix4 roles 
rfkill wmi snd video soundcore tpm_tis tpm_tis_core tpm i2c_scmi 
acpi_cpufreq rng_core pinctrl_amd mac_hid loop drm uinput sg fuse 
crypto_user ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 
serio_raw atkbd libps2 i8042 crc32c_intel xhci_pci serio
[Do Okt 21 22:29:12 2021] CPU: 13 PID: 3789 Comm: kworker/u32:56 Not 
tainted 5.14.10-1-MANJARO #1
[Do Okt 21 22:29:12 2021] Hardware name: LENOVO 20YHS00A00/20YHS00A00, 
BIOS R1OET27W (1.06 ) 05/17/2021
[Do Okt 21 22:29:12 2021] Workqueue: events_unbound async_run_entry_fn
[Do Okt 21 22:29:12 2021] RIP: 
0010:dcn21_link_encoder_acquire_phy+0x11d/0x160 [amdgpu]
[Do Okt 21 22:29:12 2021] Code: 00 00 00 0f b6 89 8b 00 00 00 e8 ae 69 
05 00 b8 01 00 00 00 48 8b 54 24 08 65 48 2b 14 25 28 00 00 00 75 43 48 
83 c4 10 5b c3 <0f> 0b 31 c0 eb e4 0f 0b 48 8b 53 60 48 8b 43 68 41 b9 
01 00 00 00
[Do Okt 21 22:29:12 2021] RSP: 0018:ffffb2e849e2f5c0 EFLAGS: 00010246
[Do Okt 21 22:29:12 2021] RAX: 0000000000163333 RBX: ffff982fe0a96800 
RCX: 0000000000000011
[Do Okt 21 22:29:12 2021] RDX: 0000000000000000 RSI: 000000000000608e 
RDI: ffff982fdfa40000
[Do Okt 21 22:29:12 2021] RBP: ffff982fe0a96800 R08: ffffb2e849e2f5c4 
R09: 0000000000020000
[Do Okt 21 22:29:12 2021] R10: ffff982fe2820000 R11: ffff982fe0a97d00 
R12: ffffb2e849e2f690
[Do Okt 21 22:29:12 2021] R13: 0000000000000008 R14: ffff982fc90d0de0 
R15: ffff982fe0a96800
[Do Okt 21 22:29:12 2021] FS:  0000000000000000(0000) 
GS:ffff98329f140000(0000) knlGS:0000000000000000
[Do Okt 21 22:29:12 2021] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Do Okt 21 22:29:12 2021] CR2: 0000000000000000 CR3: 0000000251c10000 
CR4: 0000000000350ee0
[Do Okt 21 22:29:12 2021] Call Trace:
[Do Okt 21 22:29:12 2021] 
dcn21_link_encoder_enable_dp_mst_output+0x18/0x40 [amdgpu]
[Do Okt 21 22:29:12 2021]  dp_enable_link_phy+0x1ce/0x2d0 [amdgpu]
[Do Okt 21 22:29:12 2021] 
perform_link_training_with_retries+0x108/0x240 [amdgpu]
[Do Okt 21 22:29:12 2021]  enable_link_dp+0xe5/0x230 [amdgpu]
[Do Okt 21 22:29:12 2021]  core_link_enable_stream+0x71f/0x860 [amdgpu]
[Do Okt 21 22:29:12 2021]  dce110_apply_ctx_to_hw+0x534/0x570 [amdgpu]
[Do Okt 21 22:29:12 2021]  dc_commit_state+0x307/0xa80 [amdgpu]
[Do Okt 21 22:29:12 2021]  amdgpu_dm_atomic_commit_tail+0x5aa/0x2620 
[amdgpu]
[Do Okt 21 22:29:12 2021]  ? kfree+0xc3/0x3d0
[Do Okt 21 22:29:12 2021]  ? ttm_bo_validate+0x5a/0x170 [ttm]
[Do Okt 21 22:29:12 2021]  commit_tail+0x94/0x120 [drm_kms_helper]
[Do Okt 21 22:29:12 2021]  drm_atomic_helper_commit+0x113/0x140 
[drm_kms_helper]
[Do Okt 21 22:29:12 2021] 
drm_atomic_helper_commit_duplicated_state+0xc9/0xe0 [drm_kms_helper]
[Do Okt 21 22:29:12 2021]  drm_atomic_helper_resume+0x9f/0x150 
[drm_kms_helper]
[Do Okt 21 22:29:12 2021]  dm_resume+0x2bd/0x560 [amdgpu]
[Do Okt 21 22:29:12 2021]  amdgpu_device_ip_resume_phase2+0x52/0xb0 [amdgpu]
[Do Okt 21 22:29:12 2021]  amdgpu_device_resume+0x81/0x210 [amdgpu]
[Do Okt 21 22:29:12 2021]  ? pci_pm_poweroff_noirq+0x110/0x110
[Do Okt 21 22:29:12 2021]  amdgpu_pmops_resume+0x19/0x40 [amdgpu]
[Do Okt 21 22:29:12 2021]  ? pci_pm_poweroff_noirq+0x110/0x110
[Do Okt 21 22:29:12 2021]  dpm_run_callback+0x49/0x150
[Do Okt 21 22:29:12 2021]  device_resume+0xa7/0x200
[Do Okt 21 22:29:12 2021]  async_resume+0x19/0x30
[Do Okt 21 22:29:12 2021]  async_run_entry_fn+0x30/0x130
[Do Okt 21 22:29:12 2021]  process_one_work+0x1e3/0x3b0
[Do Okt 21 22:29:12 2021]  worker_thread+0x50/0x3b0
[Do Okt 21 22:29:12 2021]  ? process_one_work+0x3b0/0x3b0
[Do Okt 21 22:29:12 2021]  kthread+0x132/0x160
[Do Okt 21 22:29:12 2021]  ? set_kthread_struct+0x40/0x40
[Do Okt 21 22:29:12 2021]  ret_from_fork+0x22/0x30
[Do Okt 21 22:29:12 2021] ---[ end trace f9fe0097333675e8 ]---
[Do Okt 21 22:29:12 2021] [drm] perform_link_training_with_retries: Link 
training attempt 1 of 4 failed
[Do Okt 21 22:29:13 2021] [drm] perform_link_training_with_retries: Link 
training attempt 2 of 4 failed
[Do Okt 21 22:29:13 2021] [drm] perform_link_training_with_retries: Link 
training attempt 3 of 4 failed
[Do Okt 21 22:29:14 2021] [drm] enabling link 2 failed: 15
[Do Okt 21 22:29:14 2021] [drm] VCN decode and encode initialized 
successfully(under DPG Mode).
[Do Okt 21 22:29:14 2021] [drm] JPEG decode initialized successfully.
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM 
inv eng 0 on hub 0
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 
uses VM inv eng 1 on hub 0
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 
uses VM inv eng 4 on hub 0
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 
uses VM inv eng 5 on hub 0
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 
uses VM inv eng 6 on hub 0
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 
uses VM inv eng 7 on hub 0
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 
uses VM inv eng 8 on hub 0
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 
uses VM inv eng 9 on hub 0
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 
uses VM inv eng 10 on hub 0
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring kiq_2.1.0 
uses VM inv eng 11 on hub 0
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses 
VM inv eng 0 on hub 1
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses 
VM inv eng 1 on hub 1
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 
uses VM inv eng 4 on hub 1
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 
uses VM inv eng 5 on hub 1
[Do Okt 21 22:29:14 2021] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec 
uses VM inv eng 6 on hub 1


[7.] A small shell script or example program which triggers the
      problem (if possible)
[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)

Linux laptop 5.14.10-1-MANJARO #1 SMP PREEMPT Thu Oct 7 06:43:34 UTC 
2021 x86_64 GNU/Linux

GNU C               	11.1.0
GNU Make            	4.3
Binutils            	2.36.1
Util-linux          	2.37.2
Mount               	2.37.2
Module-init-tools   	29
E2fsprogs           	1.46.4
Jfsutils            	1.1.15
Reiserfsprogs       	3.6.27
Xfsprogs            	5.13.0
PPP                 	2.4.9
Nfs-utils           	2.5.4
Bison               	3.8.1
Flex                	2.6.4
Linux C++ Library   	6.0.29
Linux C Library     	2.33
Dynamic linker (ldd)	2.33
Procps              	3.3.17
Kbd                 	2.4.0
Console-tools       	2.4.0
Sh-utils            	9.0
Udev                	249
Modules Loaded      	acpi_cpufreq aesni_intel af_alg agpgart algif_hash 
algif_skcipher amdgpu atkbd bluetooth bnep btbcm btintel btrtl btusb ccm 
ccp cdc_ether cec cfg80211 cmac crc16 crc32c_generic crc32c_intel 
crc32_pclmul crct10dif_pclmul cryptd crypto_simd crypto_user drm 
drm_kms_helper drm_ttm_helper ecc ecdh_generic edac_mce_amd ext4 fat 
fb_sys_fops fuse ghash_clmulni_intel gpu_sched i2c_algo_bit i2c_piix4 
i2c_scmi i8042 intel_rapl_common intel_rapl_msr ip_tables irqbypass jbd2 
joydev k10temp kvm kvm_amd ledtrig_audio libarc4 libphy libps2 loop 
mac80211 mac_hid mbcache mc mdio_devres mii mousedev ns pcspkr 
pinctrl_amd platform_profile psmouse qrtr r8152 r8153_ecm r8169 rapl 
realtek rfcomm rfkill rng_core roles rtw88_8822c rtw88_8822ce rtw88_core 
rtw88_pci serio serio_raw sg snd snd_ctl_led snd_hda_codec 
snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_codec_realtek 
snd_hda_core snd_hda_intel snd_hwdep snd_intel_dspcfg snd_intel_sdw_acpi 
snd_pci_acp3x snd_pcm snd_rawmidi snd_rn_pci_acp3x snd_seq_device 
snd_timer snd_usb_audio snd_usbmidi_lib soundcore sp5100_tco squashfs 
syscopyarea sysfillrect sysimgblt thinkpad_acpi tpm tpm_crb tpm_tis 
tpm_tis_core ttm typec typec_ucsi ucsi_acpi uinput usbhid usbnet 
uvcvideo vfat video videobuf2_common videobuf2_memops videobuf2_v4l2 
videobuf2_vmalloc videodev wmi wmi_bmof xhci_pci x_tables


[8.2.] Processor information (from /proc/cpuinfo):
[8.3.] Module information (from /proc/modules):
[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[8.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
	Subsystem: Lenovo Device 5097
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
	Subsystem: Lenovo Device 5097
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0
	Interrupt: pin A routed to IRQ -2147483648
	Capabilities: [40] Secure device <?>
	Capabilities: [64] MSI: Enable- Count=1/4 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [74] HyperTransport: MSI Mapping Enable+ Fixed+

00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe 
Dummy Host Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 0

00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe 
Dummy Host Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 1

00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP 
Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin ? routed to IRQ 26
	IOMMU group: 2
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff [disabled]
	Memory behind bridge: fd600000-fd6fffff [size=1M]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff 
[disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #1, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR+ OBFF 
Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ 
EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Lenovo Device 5097
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-
	Capabilities: [370 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=10us PortTPowerOnTime=150us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=10us LTR1.2_Threshold=32768ns
		L1SubCtl2: T_PwrOn=150us
	Kernel driver in use: pcieport

00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP 
Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin ? routed to IRQ 27
	IOMMU group: 3
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 00003000-00003fff [size=4K]
	Memory behind bridge: fd500000-fd5fffff [size=1M]
	Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff 
[disabled]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #3, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
			Slot #0, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState+
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR+ OBFF 
Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Lenovo Device 5097
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-
	Capabilities: [370 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=150us LTR1.2_Threshold=32768ns
		L1SubCtl2: T_PwrOn=150us
	Kernel driver in use: pcieport

00:02.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP 
Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin ? routed to IRQ 28
	IOMMU group: 4
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00002000-00002fff [size=4K]
	Memory behind bridge: fd400000-fd4fffff [size=1M]
	Prefetchable memory behind bridge: 0000000430000000-00000004301fffff 
[size=2M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #4, Speed 8GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (downgraded), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		SltCap:	AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+
			Slot #0, PowerLimit 75.000W; Interlock- NoCompl+
		SltCtl:	Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt- HPIrq+ LinkChg+
			Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
		SltSta:	Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
			Changed: MRL- PresDet- LinkState-
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
		RootSta: PME ReqID 0000, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp+ ExtTPHComp- ARIFwd+
			 AtomicOpsCap: Routing- 32bit+ 64bit+ 128bitCAS-
		DevCtl2: Completion Timeout: 65ms to 210ms, TimeoutDis- LTR+ OBFF 
Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Lenovo Device 5097
	Capabilities: [c8] HyperTransport: MSI Mapping Enable+ Fixed+
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-
	Capabilities: [370 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=30us PortTPowerOnTime=150us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=30us LTR1.2_Threshold=32768ns
		L1SubCtl2: T_PwrOn=150us
	Kernel driver in use: pcieport

00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe 
Dummy Host Bridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 5

00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal 
PCIe GPP Bridge to Bus (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 29
	IOMMU group: 5
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 00001000-00001fff [size=4K]
	Memory behind bridge: fd000000-fd3fffff [size=4M]
	Prefetchable memory behind bridge: 0000000460000000-00000004701fffff 
[size=258M]
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
	BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
		PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Express (v2) Root Port (Slot-), MSI 00
		DevCap:	MaxPayload 512 bytes, PhantFunc 0
			ExtTag+ RBE+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s 
<64ns, L1 <1us
			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
		RootCap: CRSVisible+
		RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ CRSVisible+
		RootSta: PME ReqID 0401, PMEStatus- PMEPending-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
MaxEETLPPrefixes 4
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- ARIFwd-
			 AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF 
Disabled, ARIFwd-
			 AtomicOpsCtl: ReqEn- EgressBlck-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 
2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ 
EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [c0] Subsystem: Device 5097:17aa
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [400 v1] Data Link Feature <?>
	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [440 v1] Lane Margining at the Receiver <?>
	Kernel driver in use: pcieport

00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller 
(rev 51)
	Subsystem: Lenovo Device 5097
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	IOMMU group: 6
	Kernel driver in use: piix4_smbus
	Kernel modules: i2c_piix4, sp5100_tco

00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge 
(rev 51)
	Subsystem: Lenovo Device 5097
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
	Latency: 0
	IOMMU group: 6

00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device 
24: Function 0
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 7

00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device 
24: Function 1
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 7

00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device 
24: Function 2
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 7

00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device 
24: Function 3
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 7
	Kernel driver in use: k10temp
	Kernel modules: k10temp

00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device 
24: Function 4
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 7

00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device 
24: Function 5
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 7

00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device 
24: Function 6
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 7

00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Device 
24: Function 7
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	IOMMU group: 7

01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd 
Device a809 (prog-if 02 [NVM Express])
	Subsystem: Samsung Electronics Co Ltd Device a801
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 30
	NUMA node: 0
	IOMMU group: 8
	Region 0: Memory at fd600000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s unlimited, L1 
unlimited
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 75.000W
		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
			MaxPayload 256 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x4 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink- Retimer- 
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ 
EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [b0] MSI-X: Enable+ Count=13 Masked-
		Vector table: BAR=0 offset=00003000
		PBA: BAR=0 offset=00002000
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ 
ECRCChkEn-
			MultHdrRecCap+ MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
	Capabilities: [158 v1] Power Budgeting <?>
	Capabilities: [168 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [188 v1] Latency Tolerance Reporting
		Max snoop latency: 1048576ns
		Max no snoop latency: 1048576ns
	Capabilities: [190 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=0us LTR1.2_Threshold=32768ns
		L1SubCtl2: T_PwrOn=150us
	Kernel driver in use: nvme

02:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 10)
	Subsystem: Lenovo Device 5097
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 62
	IOMMU group: 9
	Region 0: I/O ports at 3000 [size=256]
	Region 2: Memory at fd504000 (64-bit, non-prefetchable) [size=4K]
	Region 4: Memory at fd500000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 01
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 75.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 4096 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s unlimited, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
		Vector table: BAR=4 offset=00000000
		PBA: BAR=4 offset=00000800
	Capabilities: [d0] Vital Product Data
pcilib: sysfs_read_vpd: read failed: Input/output error
		Not readable
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ 
ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [140 v1] Virtual Channel
		Caps:	LPEVC=0 RefClk=100ns PATEntryBits=1
		Arb:	Fixed- WRR32- WRR64- WRR128-
		Ctrl:	ArbSelect=Fixed
		Status:	InProgress-
		VC0:	Caps:	PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
			Arb:	Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
			Ctrl:	Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
			Status:	NegoPending- InProgress-
	Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
	Capabilities: [170 v1] Latency Tolerance Reporting
		Max snoop latency: 1048576ns
		Max no snoop latency: 1048576ns
	Capabilities: [178 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=0us LTR1.2_Threshold=32768ns
		L1SubCtl2: T_PwrOn=150us
	Kernel driver in use: r8169
	Kernel modules: r8169

03:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822CE 
802.11ac PCIe Wireless Network Adapter
	Subsystem: Lenovo Device c123
	Physical Slot: 0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 67
	IOMMU group: 10
	Region 0: I/O ports at 2000 [size=256]
	Region 2: Memory at fd400000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [40] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [70] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
			ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 75.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
		LnkCap:	Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency 
L0s <4us, L1 <64us
			ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM L1 Enabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 2.5GT/s (ok), Width x1 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis+ NROPrPrP- LTR+
			 10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR+ OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 
2Retimers- DRS-
		LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [100 v2] Advanced Error Reporting
		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ 
ECRCChkEn-
			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
		HeaderLog: 00000000 00000000 00000000 00000000
	Capabilities: [148 v1] Device Serial Number 00-e0-4c-ff-fe-c8-22-01
	Capabilities: [158 v1] Latency Tolerance Reporting
		Max snoop latency: 1048576ns
		Max no snoop latency: 1048576ns
	Capabilities: [160 v1] L1 PM Substates
		L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
			  PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
		L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
			   T_CommonMode=0us LTR1.2_Threshold=32768ns
		L1SubCtl2: T_PwrOn=150us
	Kernel driver in use: rtw_8822ce
	Kernel modules: rtw88_8822ce

04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. 
[AMD/ATI] Lucienne (rev c1) (prog-if 00 [VGA controller])
	Subsystem: Lenovo Device 5097
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+ <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin A routed to IRQ 53
	IOMMU group: 5
	Region 0: Memory at 460000000 (64-bit, prefetchable) [size=256M]
	Region 2: Memory at 470000000 (64-bit, prefetchable) [size=2M]
	Region 4: I/O ports at 1000 [size=256]
	Region 5: Memory at fd300000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend+
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s 
<64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer+ 
2Retimers+ DRS-
		LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- 
ComplianceSOS-
			 Compliance De-emphasis: -6dB
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete+ 
EqualizationPhase1+
			 EqualizationPhase2+ EqualizationPhase3+ LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=1/4 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=4 Masked-
		Vector table: BAR=5 offset=00042000
		PBA: BAR=5 offset=00043000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Capabilities: [270 v1] Secondary PCI Express
		LnkCtl3: LnkEquIntrruptEn- PerformEqu-
		LaneErrStat: 0
	Capabilities: [2b0 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable+, Smallest Translation Unit: 00
	Capabilities: [2c0 v1] Page Request Interface (PRI)
		PRICtl: Enable- Reset-
		PRISta: RF- UPRGI- Stopped+
		Page Request Capacity: 00000100, Page Request Allocation: 00000000
	Capabilities: [2d0 v1] Process Address Space ID (PASID)
		PASIDCap: Exec+ Priv+, Max PASID Width: 10
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [400 v1] Data Link Feature <?>
	Capabilities: [410 v1] Physical Layer 16.0 GT/s <?>
	Capabilities: [440 v1] Lane Margining at the Receiver <?>
	Kernel driver in use: amdgpu
	Kernel modules: amdgpu

04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 1637
	Subsystem: Lenovo Device 5097
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin B routed to IRQ 70
	IOMMU group: 5
	Region 0: Memory at fd3c8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Legacy Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s 
<64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

04:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 
17h (Models 10h-1fh) Platform Security Processor
	Subsystem: Lenovo Device 5097
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin C routed to IRQ 30
	IOMMU group: 5
	Region 2: Memory at fd200000 (32-bit, non-prefetchable) [size=1M]
	Region 5: Memory at fd3cc000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s 
<64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=1/2 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=2 Masked-
		Vector table: BAR=5 offset=00000000
		PBA: BAR=5 offset=00001000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Kernel driver in use: ccp
	Kernel modules: ccp

04:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 
3.1 (prog-if 30 [XHCI])
	Subsystem: Lenovo Device 5097
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin D routed to IRQ 44
	IOMMU group: 5
	Region 0: Memory at fd000000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s 
<64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=8 Masked-
		Vector table: BAR=0 offset=000fe000
		PBA: BAR=0 offset=000ff000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

04:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 
3.1 (prog-if 30 [XHCI])
	Subsystem: Lenovo Device 5097
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 53
	IOMMU group: 5
	Region 0: Memory at fd100000 (64-bit, non-prefetchable) [size=1M]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D3 NoSoftRst- PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s 
<64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=1/8 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [c0] MSI-X: Enable+ Count=8 Masked-
		Vector table: BAR=0 offset=000fe000
		PBA: BAR=0 offset=000ff000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Kernel driver in use: xhci_hcd
	Kernel modules: xhci_pci

04:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] 
Raven/Raven2/FireFlight/Renoir Audio Processor (rev 01)
	Subsystem: Lenovo Device 5097
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Interrupt: pin B routed to IRQ 68
	IOMMU group: 5
	Region 0: Memory at fd380000 (32-bit, non-prefetchable) [virtual] 
[size=256K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s 
<64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable- Count=1/1 Maskable- 64bit+
		Address: 0000000000000000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x

04:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h 
(Models 10h-1fh) HD Audio Controller
	Subsystem: Lenovo Device 5097
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
	Latency: 0, Cache Line Size: 32 bytes
	Interrupt: pin C routed to IRQ 31
	IOMMU group: 5
	Region 0: Memory at fd3c0000 (32-bit, non-prefetchable) [size=32K]
	Capabilities: [48] Vendor Specific Information: Len=08 <?>
	Capabilities: [50] Power Management version 3
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [64] Express (v2) Endpoint, MSI 00
		DevCap:	MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0.000W
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
			MaxPayload 128 bytes, MaxReadReq 512 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		LnkCap:	Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s 
<64ns, L1 <1us
			ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
		LnkSta:	Speed 8GT/s (ok), Width x16 (ok)
			TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
			 10BitTagComp+ 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix+, 
MaxEETLPPrefixes 1
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS- TPHComp- ExtTPHComp-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
		LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete- 
EqualizationPhase1-
			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
			 Retimer- 2Retimers- CrosslinkRes: unsupported
	Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
		Address: 00000000fee00000  Data: 0000
	Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 
Len=010 <?>
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel


[8.6.] SCSI information (from /proc/scsi/scsi)
[8.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):
[X.] Other notes, patches, fixes, workarounds:
