Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56A6C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 13:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EC8110E941;
	Thu,  6 Jun 2024 13:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xlq09iBV";
	dkim-atps=neutral
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01B8610E846
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 03:07:00 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-250671a1bc7so192057fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Jun 2024 20:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717643219; x=1718248019; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bQLxLw5XfrRgCJkEb3ofHiwXVDIOe5ZgnFrSAh37QG0=;
 b=Xlq09iBVV2cIZRGKsx9qSNBcEqWbSnFKCw+7l7IdWTQzYRMcXMjsx9nZVNkoEC0Ceo
 b7fewel9sNOTx9ReMVzYhfbldzimXt0J0xKnMC26b9K7oEItNWHhOFjR5LeuWk08EwjN
 2tD5AS7sIvsplZq+Q+qIqD0QKajkDf6CWa1NxwGmPIDoywpCTCxNr2678hX9y/dccb9/
 N48Ez9NV3p1ryxDux1U5uEc15iI84ob4l/SoZOMq8boU0N+jYKMpTKPz6xqSqs9G0Fnd
 obml30R5LpnugIbQzFYI7JBKw85/lU/Qxs7HFMhFXKeQ/v/xAc/T7ikiXfuAcbDySTvT
 7/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717643219; x=1718248019;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bQLxLw5XfrRgCJkEb3ofHiwXVDIOe5ZgnFrSAh37QG0=;
 b=whnpy8Nf5P8OuBB/Y6/ojmo/k/K9Hcv2Fz2g42keJW4peAD0y3jK5nI7gFfcxU5FDV
 Jag+GngiUOmbs2llytYmLp+R6khshm6SWsccrd20LjPnMwGyBYDOUS9a62g3hWwqszxb
 q5bL95FzvQh067EHDpHqeHTNpI2MHaSkQ4SJD4EJ5aG+KR/6GKd5iIErRg6XgDxibGni
 q3LvRHpJEHSXiSlQILns7ypaSYWCeXRzZTsZpbgvD6FeGwCkze4xTlz8ZrhLtcptjgfB
 a7cPyCO6n+tcIEbCG4+ObHlGVXW73na3ieVdN6nHv7q/ukyjYLno/WmtQrE/kl4tbMaz
 qzsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSJtsoXH96Cqi3+h88+J/XGDdpueGE6XEyBPhOmrdV/d+Pp63mAGAu61PM1tpCQkVvWV3bZJYFTLPgc5CCcyEi+GLwArV98ONxXoM21g==
X-Gm-Message-State: AOJu0YzY6HVEfIQOxhEv3tbP4Izvy+rF7mlp8IzR3S92dSJjB8dddgGR
 SfWSPdb6RCVdCcs9gj5kMG9S4qMBtyI/iPqihG0BWioLHjS/c3CgqdKuQXze+Cvf9FTX01SDQfs
 acrE5sQ0/7mQjfFsXewrZpeOpDRun0DACW/Y=
X-Google-Smtp-Source: AGHT+IEUXVp02NqRRq9gTBhkDN7qI+IBVyJkGbbAfazFxcWKY5gwYj0h/OoPn44ssUm4nAWnOOYDZRkLjumBHJ+w2VU=
X-Received: by 2002:a05:6871:60f:b0:250:8afa:8144 with SMTP id
 586e51a60fabf-25121fec12dmr5203980fac.37.1717643219304; Wed, 05 Jun 2024
 20:06:59 -0700 (PDT)
MIME-Version: 1.0
From: Winston Ma <winstonhyypia@gmail.com>
Date: Thu, 6 Jun 2024 11:06:48 +0800
Message-ID: <CAMOvFfkQscju1spNKHmEC_Rut+2=qfhKGZSvGhCk_nd5VhuDkg@mail.gmail.com>
Subject: Re: [bug report] drm/amdgpu: amdgpu crash on playing videos,
 linux 6.10-rc
To: mac-wang@sjtu.edu.cn
Cc: Felix.Kuehling@amd.com, Xinhui.Pan@amd.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: multipart/alternative; boundary="000000000000f00bd3061a2ff9b4"
X-Mailman-Approved-At: Thu, 06 Jun 2024 13:01:46 +0000
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

--000000000000f00bd3061a2ff9b4
Content-Type: text/plain; charset="UTF-8"

Hi I got the same problem on Linux Kernel 6.10-rc2. I got the problem by
following the procedure below:


   1. Boot Linux Kernel 6.10-rc2
   2. Open Firefox (Any browser should work)
   3. Open a Youtube Video
   4. On the playing video, toggle fullscreen quickly Then after 10-20
   times of fullscreen toggling, the screen would enter freeze mode. This is
   the log that I captured using the above method.

This is the kernel log

2024-06-06T10:26:40.747576+08:00 kernel: gmc_v10_0_process_interrupt:
6 callbacks suppressed
2024-06-06T10:26:40.747618+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
[mmhub] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
2024-06-06T10:26:40.747623+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
in process RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
2024-06-06T10:26:40.747625+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
 in page starting at address 0x0000800106ffe000 from client 0x12 (VMC)
2024-06-06T10:26:40.747628+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
MMVM_L2_PROTECTION_FAULT_STATUS:0x00203811
2024-06-06T10:26:40.747629+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 Faulty UTCL2 client ID: VCN (0x1c)
2024-06-06T10:26:40.747631+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 MORE_FAULTS: 0x1
2024-06-06T10:26:40.747651+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 WALKER_ERROR: 0x0
2024-06-06T10:26:40.747653+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 PERMISSION_FAULTS: 0x1
2024-06-06T10:26:40.747655+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 MAPPING_ERROR: 0x0
2024-06-06T10:26:40.747656+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x0
2024-06-06T10:26:40.747658+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
[mmhub] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
2024-06-06T10:26:40.747660+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
in process RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
2024-06-06T10:26:40.747662+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
 in page starting at address 0x0000800106e00000 from client 0x12 (VMC)
2024-06-06T10:26:40.747663+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
2024-06-06T10:26:40.747664+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 Faulty UTCL2 client ID: MP0 (0x0)
2024-06-06T10:26:40.747666+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 MORE_FAULTS: 0x0
2024-06-06T10:26:40.747667+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 WALKER_ERROR: 0x0
2024-06-06T10:26:40.747668+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 PERMISSION_FAULTS: 0x0
2024-06-06T10:26:40.747670+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 MAPPING_ERROR: 0x0
2024-06-06T10:26:40.747671+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x0
2024-06-06T10:26:40.747674+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
[mmhub] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
2024-06-06T10:26:40.747677+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
in process RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
2024-06-06T10:26:40.747680+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
 in page starting at address 0x0000800106e07000 from client 0x12 (VMC)
2024-06-06T10:26:40.747683+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
2024-06-06T10:26:40.747686+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 Faulty UTCL2 client ID: MP0 (0x0)
2024-06-06T10:26:40.747688+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 MORE_FAULTS: 0x0
2024-06-06T10:26:40.747691+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 WALKER_ERROR: 0x0
2024-06-06T10:26:40.747693+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 PERMISSION_FAULTS: 0x0
2024-06-06T10:26:40.747696+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 MAPPING_ERROR: 0x0
2024-06-06T10:26:40.747698+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x0
2024-06-06T10:26:40.747700+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
[mmhub] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
2024-06-06T10:26:40.747703+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
in process RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
2024-06-06T10:26:40.747705+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
 in page starting at address 0x0000800107001000 from client 0x12 (VMC)
2024-06-06T10:26:40.747707+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
MMVM_L2_PROTECTION_FAULT_STATUS:0x00000000
2024-06-06T10:26:40.747710+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 Faulty UTCL2 client ID: MP0 (0x0)
2024-06-06T10:26:40.747713+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 MORE_FAULTS: 0x0
2024-06-06T10:26:40.747716+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 WALKER_ERROR: 0x0
2024-06-06T10:26:40.747718+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 PERMISSION_FAULTS: 0x0
2024-06-06T10:26:40.747721+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
	 MAPPING_ERROR: 0x0
2024-06-06T10:26:40.747723+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW: 0x0
2024-06-06T10:26:51.094991+08:00 kernel: [drm:amdgpu_job_timedout
[amdgpu]] *ERROR* ring vcn_dec_0 timeout, signaled seq=24897, emitted
seq=24898
2024-06-06T10:26:51.095023+08:00 kernel: [drm:amdgpu_job_timedout
[amdgpu]] *ERROR* Process information: process RDD Process pid 39524
thread firefox-bi:cs0 pid 40342
2024-06-06T10:26:51.095025+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
GPU reset begin!
2024-06-06T10:26:52.305509+08:00 kernel: [drm] Register(0)
[mmUVD_POWER_STATUS] failed to reach value 0x00000001 != 0x00000002n
2024-06-06T10:26:52.586019+08:00 kernel: [drm] Register(0)
[mmUVD_RBC_RB_RPTR] failed to reach value 0x000003c0 != 0x00000360n
2024-06-06T10:26:52.639506+08:00 kernel: [drm] Register(0)
[mmUVD_POWER_STATUS] failed to reach value 0x00000001 != 0x00000002n
2024-06-06T10:26:52.639521+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
MODE2 reset
2024-06-06T10:26:52.650614+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
GPU reset succeeded, trying to resume
2024-06-06T10:26:52.650633+08:00 kernel: [drm] PCIE GART of 1024M
enabled (table at 0x000000F41FC00000).
2024-06-06T10:26:52.650637+08:00 kernel: [drm] VRAM is lost due to GPU reset!
2024-06-06T10:26:52.650641+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
PSP is resuming...
2024-06-06T10:26:52.673474+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
reserve 0xa00000 from 0xf41e000000 for PSP TMR
2024-06-06T10:26:53.001513+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
RAS: optional ras ta ucode is not available
2024-06-06T10:26:53.013802+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
RAP: optional rap ta ucode is not available
2024-06-06T10:26:53.013816+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
SECUREDISPLAY: securedisplay ta ucode is not available
2024-06-06T10:26:53.013819+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
SMU is resuming...
2024-06-06T10:26:53.016519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
SMU is resumed successfully!
2024-06-06T10:26:53.017502+08:00 kernel: [drm] DMUB hardware
initialized: version=0x04000044
2024-06-06T10:26:53.677511+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q 0
2024-06-06T10:26:53.958512+08:00 kernel: amdgpu 0000:03:00.0:
[drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring vcn_dec_0 test
failed (-110)
2024-06-06T10:26:53.958536+08:00 kernel:
[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP
block <vcn_v3_0> failed -110
2024-06-06T10:26:53.958539+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
GPU reset(1) failed
2024-06-06T10:26:53.958541+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
GPU reset end with ret = -110
2024-06-06T10:26:53.959180+08:00 kernel: [drm:amdgpu_job_timedout
[amdgpu]] *ERROR* GPU Recovery Failed: -110
2024-06-06T10:26:55.261509+08:00 kernel: [drm] Register(0)
[mmUVD_POWER_STATUS] failed to reach value 0x00000001 != 0x00000002n
2024-06-06T10:26:55.540507+08:00 kernel: [drm] Register(0)
[mmUVD_RBC_RB_RPTR] failed to reach value 0x00000010 != 0x00000000n
2024-06-06T10:27:04.407149+08:00 kernel: [drm] Register(0)
[mmUVD_POWER_STATUS] failed to reach value 0x00000001 != 0x00000002n
2024-06-06T10:27:04.407252+08:00 kernel: [drm:amdgpu_job_timedout
[amdgpu]] *ERROR* ring vcn_dec_0 timeout, signaled seq=24898, emitted
seq=24898
2024-06-06T10:27:04.407257+08:00 kernel: [drm:amdgpu_job_timedout
[amdgpu]] *ERROR* Process information: process RDD Process pid 39524
thread firefox-bi:cs0 pid 40342
2024-06-06T10:27:04.407259+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
GPU reset begin!
2024-06-06T10:27:05.033745+08:00 kernel: ------------[ cut here ]------------
2024-06-06T10:27:05.033773+08:00 kernel: WARNING: CPU: 8 PID: 47039 at
drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x9c/0xb0
[amdgpu]
2024-06-06T10:27:05.033777+08:00 kernel: Modules linked in:
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject xt_conntrack
nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype nft_compat nf_tables
libcrc32c br_netfilter bridge stp llc hid_logitech_hidpp usbhid
xfrm_interface xfrm6_tunnel tunnel4 tunnel6 xfrm_user xfrm_algo uhid
rfcomm snd_seq_dummy snd_hrtimer cmac algif_hash algif_skcipher af_alg
overlay qrtr bnep binfmt_misc uvcvideo videobuf2_vmalloc uvc
videobuf2_memops videobuf2_v4l2 btusb btrtl videodev btintel btbcm
snd_acp6x_pdm_dma snd_soc_dmic snd_soc_acp6x_mach amd_atl
intel_rapl_msr btmtk videobuf2_common bluetooth mc intel_rapl_common
snd_sof_amd_acp63 snd_sof_amd_vangogh snd_sof_amd_rembrandt iwlmvm
snd_sof_amd_renoir snd_sof_amd_acp snd_sof_pci snd_sof_xtensa_dsp
amdgpu snd_sof edac_mce_amd mac80211 snd_sof_utils snd_pci_ps
snd_hda_codec_realtek snd_amd_sdw_acpi kvm_amd soundwire_amd
snd_hda_codec_generic soundwire_generic_allocation soundwire_bus
2024-06-06T10:27:05.033782+08:00 kernel:  snd_hda_scodec_cs35l41_spi
nls_iso8859_1 snd_hda_codec_hdmi snd_hda_scodec_component libarc4 kvm
snd_soc_core snd_hda_intel snd_ctl_led snd_intel_dspcfg snd_compress
snd_intel_sdw_acpi amdxcp snd_seq_midi ac97_bus crct10dif_pclmul
drm_exec snd_hda_codec polyval_clmulni snd_pcm_dmaengine
snd_seq_midi_event gpu_sched polyval_generic iwlwifi
ghash_clmulni_intel snd_rpl_pci_acp6x drm_buddy sha256_ssse3
snd_hda_core snd_rawmidi snd_acp_pci drm_suballoc_helper
snd_hda_scodec_cs35l41_i2c sha1_ssse3 drm_ttm_helper
snd_acp_legacy_common snd_hwdep snd_hda_scodec_cs35l41 aesni_intel
snd_pci_acp6x amd_pmf snd_hda_cs_dsp_ctls ttm crypto_simd
snd_pci_acp5x snd_soc_cs_amp_lib asus_nb_wmi cs_dsp cryptd amdtee
snd_seq snd_rn_pci_acp3x drm_display_helper snd_pcm asus_wmi
snd_acp_config rapl wmi_bmof sparse_keymap snd_seq_device cfg80211
snd_soc_cs35l41_lib cec snd_soc_acpi ccp rc_core snd_timer
i2c_algo_bit i2c_piix4 snd_pci_acp3x k10temp amd_sfh tee snd
platform_profile soundcore serial_multi_instantiate amd_pmc acpi_tad
2024-06-06T10:27:05.033784+08:00 kernel:  joydev input_leds mac_hid
serio_raw parport_pc ppdev lp parport efi_pstore nfnetlink dmi_sysfs
ip_tables x_tables autofs4 hid_multitouch nvme video ucsi_acpi
hid_generic crc32_pclmul nvme_core typec_ucsi xhci_pci i2c_hid_acpi
xhci_pci_renesas nvme_auth typec i2c_hid wmi hid 8250_dw
2024-06-06T10:27:05.033785+08:00 kernel: CPU: 8 PID: 47039 Comm:
kworker/u64:0 Tainted: G        W          6.10.0-061000rc2-generic
#202406022333
2024-06-06T10:27:05.033787+08:00 kernel: Hardware name: ASUSTeK
COMPUTER INC. Zenbook UM5302TA_UM5302TA/UM5302TA, BIOS UM5302TA.311
01/17/2023
2024-06-06T10:27:05.033788+08:00 kernel: Workqueue: amdgpu-reset-dev
drm_sched_job_timedout [gpu_sched]
2024-06-06T10:27:05.033789+08:00 kernel: RIP:
0010:amdgpu_irq_put+0x9c/0xb0 [amdgpu]
2024-06-06T10:27:05.033790+08:00 kernel: Code: 31 f6 31 ff e9 c0 05 2f
e6 44 89 e2 48 89 de 4c 89 f7 e8 97 fc ff ff 5b 41 5c 41 5d 41 5e 5d
31 d2 31 f6 31 ff e9 9f 05 2f e6 <0f> 0b b8 ea ff ff ff eb c3 b8 fe ff
ff ff eb bc 0f 1f 40 00 90 90
2024-06-06T10:27:05.033791+08:00 kernel: RSP: 0018:ffffb65847227c18
EFLAGS: 00010246
2024-06-06T10:27:05.033793+08:00 kernel: RAX: 0000000000000000 RBX:
ffff9ac0a0280c60 RCX: 0000000000000000
2024-06-06T10:27:05.033794+08:00 kernel: RDX: 0000000000000000 RSI:
0000000000000000 RDI: 0000000000000000
2024-06-06T10:27:05.033796+08:00 kernel: RBP: ffffb65847227c38 R08:
0000000000000000 R09: 0000000000000000
2024-06-06T10:27:05.033797+08:00 kernel: R10: 0000000000000000 R11:
0000000000000000 R12: 0000000000000000
2024-06-06T10:27:05.033798+08:00 kernel: R13: 0000000000000001 R14:
ffff9ac0a0280000 R15: ffff9ac0a0280000
2024-06-06T10:27:05.033799+08:00 kernel: FS:  0000000000000000(0000)
GS:ffff9ac38e600000(0000) knlGS:0000000000000000
2024-06-06T10:27:05.033800+08:00 kernel: CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
2024-06-06T10:27:05.033802+08:00 kernel: CR2: 00007d1a5edfe000 CR3:
000000001863c000 CR4: 0000000000f50ef0
2024-06-06T10:27:05.033803+08:00 kernel: PKRU: 55555554
2024-06-06T10:27:05.033805+08:00 kernel: Call Trace:
2024-06-06T10:27:05.033806+08:00 kernel:  <TASK>
2024-06-06T10:27:05.033807+08:00 kernel:  ? show_regs+0x6c/0x80
2024-06-06T10:27:05.033845+08:00 kernel:  ? __warn+0x88/0x140
2024-06-06T10:27:05.034598+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0 [amdgpu]
2024-06-06T10:27:05.034615+08:00 kernel:  ? report_bug+0x182/0x1b0
2024-06-06T10:27:05.034618+08:00 kernel:  ? handle_bug+0x51/0xa0
2024-06-06T10:27:05.034619+08:00 kernel:  ? exc_invalid_op+0x18/0x80
2024-06-06T10:27:05.034620+08:00 kernel:  ? asm_exc_invalid_op+0x1b/0x20
2024-06-06T10:27:05.034621+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0 [amdgpu]
2024-06-06T10:27:05.034623+08:00 kernel:  ? amdgpu_irq_put+0x55/0xb0 [amdgpu]
2024-06-06T10:27:05.035573+08:00 kernel:  gmc_v10_0_hw_fini+0x67/0xe0 [amdgpu]
2024-06-06T10:27:05.035580+08:00 kernel:  gmc_v10_0_suspend+0xe/0x20 [amdgpu]
2024-06-06T10:27:05.035581+08:00 kernel:
amdgpu_device_ip_suspend_phase2+0x251/0x480 [amdgpu]
2024-06-06T10:27:05.035582+08:00 kernel:
amdgpu_device_ip_suspend+0x49/0x80 [amdgpu]
2024-06-06T10:27:05.036529+08:00 kernel:
amdgpu_device_pre_asic_reset+0xd1/0x490 [amdgpu]
2024-06-06T10:27:05.036546+08:00 kernel:
amdgpu_device_gpu_recover+0x406/0xa30 [amdgpu]
2024-06-06T10:27:05.036548+08:00 kernel:
amdgpu_job_timedout+0x141/0x200 [amdgpu]
2024-06-06T10:27:05.036550+08:00 kernel:
drm_sched_job_timedout+0x70/0x110 [gpu_sched]
2024-06-06T10:27:05.036551+08:00 kernel:  process_one_work+0x186/0x3e0
2024-06-06T10:27:05.036552+08:00 kernel:  worker_thread+0x304/0x440
2024-06-06T10:27:05.036554+08:00 kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
2024-06-06T10:27:05.036555+08:00 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
2024-06-06T10:27:05.036556+08:00 kernel:  ? __pfx_worker_thread+0x10/0x10
2024-06-06T10:27:05.036557+08:00 kernel:  kthread+0xe4/0x110
2024-06-06T10:27:05.036558+08:00 kernel:  ? __pfx_kthread+0x10/0x10
2024-06-06T10:27:05.036559+08:00 kernel:  ret_from_fork+0x47/0x70
2024-06-06T10:27:05.036561+08:00 kernel:  ? __pfx_kthread+0x10/0x10
2024-06-06T10:27:05.036562+08:00 kernel:  ret_from_fork_asm+0x1a/0x30
2024-06-06T10:27:05.036563+08:00 kernel:  </TASK>
2024-06-06T10:27:05.036564+08:00 kernel: ---[ end trace 0000000000000000 ]---
2024-06-06T10:27:05.036565+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
MODE2 reset
2024-06-06T10:27:05.046502+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
GPU reset succeeded, trying to resume
2024-06-06T10:27:05.047516+08:00 kernel: [drm] PCIE GART of 1024M
enabled (table at 0x000000F41FC00000).
2024-06-06T10:27:05.047533+08:00 kernel: [drm] VRAM is lost due to GPU reset!
2024-06-06T10:27:05.047538+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
PSP is resuming...
2024-06-06T10:27:05.070481+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
reserve 0xa00000 from 0xf41e000000 for PSP TMR
2024-06-06T10:27:05.397519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
RAS: optional ras ta ucode is not available
2024-06-06T10:27:05.409509+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
RAP: optional rap ta ucode is not available
2024-06-06T10:27:05.409517+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
SECUREDISPLAY: securedisplay ta ucode is not available
2024-06-06T10:27:05.409518+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
SMU is resuming...
2024-06-06T10:27:05.411482+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
SMU is resumed successfully!
2024-06-06T10:27:05.413504+08:00 kernel: [drm] DMUB hardware
initialized: version=0x04000044
2024-06-06T10:27:06.055474+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q 0
2024-06-06T10:27:06.335476+08:00 kernel: amdgpu 0000:03:00.0:
[drm:amdgpu_ring_test_helper [amdgpu]] *ERROR* ring vcn_dec_0 test
failed (-110)
2024-06-06T10:27:06.335495+08:00 kernel:
[drm:amdgpu_device_ip_resume_phase2 [amdgpu]] *ERROR* resume of IP
block <vcn_v3_0> failed -110
2024-06-06T10:27:06.335498+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
GPU reset(2) failed
2024-06-06T10:27:06.335499+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:
GPU reset end with ret = -110
2024-06-06T10:27:06.335631+08:00 kernel: [drm:amdgpu_job_timedout
[amdgpu]] *ERROR* GPU Recovery Failed: -110

--000000000000f00bd3061a2ff9b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi I got the same problem on Linux Kernel 6.10-rc2. I=
 got the problem by following the procedure below:<br></div><div><br></div>=
<div><ol><li>Boot Linux Kernel 6.10-rc2</li><li>Open Firefox (Any browser s=
hould work)</li><li>Open a Youtube Video</li><li>On the playing video, togg=
le fullscreen quickly
Then after 10-20 times of fullscreen toggling, the screen would enter freez=
e mode. This is the log that I captured using the above method.</li></ol></=
div><div>This is the kernel log<br></div><div><br></div><div><pre class=3D"=
gmail-code gmail-highlight" lang=3D"plaintext" style=3D"color:rgb(0,0,0);fo=
nt-style:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0px;t=
ext-decoration:none">2024-06-06T10:26:40.747576+08:00 kernel: gmc_v10_0_pro=
cess_interrupt: 6 callbacks suppressed
2024-06-06T10:26:40.747618+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhu=
b] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
2024-06-06T10:26:40.747623+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  in p=
rocess RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
2024-06-06T10:26:40.747625+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:   in =
page starting at address 0x0000800106ffe000 from client 0x12 (VMC)
2024-06-06T10:26:40.747628+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_=
L2_PROTECTION_FAULT_STATUS:0x00203811
2024-06-06T10:26:40.747629+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 Fau=
lty UTCL2 client ID: VCN (0x1c)
2024-06-06T10:26:40.747631+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MOR=
E_FAULTS: 0x1
2024-06-06T10:26:40.747651+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 WAL=
KER_ERROR: 0x0
2024-06-06T10:26:40.747653+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 PER=
MISSION_FAULTS: 0x1
2024-06-06T10:26:40.747655+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MAP=
PING_ERROR: 0x0
2024-06-06T10:26:40.747656+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW:=
 0x0
2024-06-06T10:26:40.747658+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhu=
b] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
2024-06-06T10:26:40.747660+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  in p=
rocess RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
2024-06-06T10:26:40.747662+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:   in =
page starting at address 0x0000800106e00000 from client 0x12 (VMC)
2024-06-06T10:26:40.747663+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_=
L2_PROTECTION_FAULT_STATUS:0x00000000
2024-06-06T10:26:40.747664+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 Fau=
lty UTCL2 client ID: MP0 (0x0)
2024-06-06T10:26:40.747666+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MOR=
E_FAULTS: 0x0
2024-06-06T10:26:40.747667+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 WAL=
KER_ERROR: 0x0
2024-06-06T10:26:40.747668+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 PER=
MISSION_FAULTS: 0x0
2024-06-06T10:26:40.747670+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MAP=
PING_ERROR: 0x0
2024-06-06T10:26:40.747671+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW:=
 0x0
2024-06-06T10:26:40.747674+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhu=
b] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
2024-06-06T10:26:40.747677+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  in p=
rocess RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
2024-06-06T10:26:40.747680+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:   in =
page starting at address 0x0000800106e07000 from client 0x12 (VMC)
2024-06-06T10:26:40.747683+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_=
L2_PROTECTION_FAULT_STATUS:0x00000000
2024-06-06T10:26:40.747686+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 Fau=
lty UTCL2 client ID: MP0 (0x0)
2024-06-06T10:26:40.747688+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MOR=
E_FAULTS: 0x0
2024-06-06T10:26:40.747691+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 WAL=
KER_ERROR: 0x0
2024-06-06T10:26:40.747693+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 PER=
MISSION_FAULTS: 0x0
2024-06-06T10:26:40.747696+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MAP=
PING_ERROR: 0x0
2024-06-06T10:26:40.747698+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW:=
 0x0
2024-06-06T10:26:40.747700+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhu=
b] page fault (src_id:0 ring:8 vmid:2 pasid:32789)
2024-06-06T10:26:40.747703+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:  in p=
rocess RDD Process pid 39524 thread firefox-bi:cs0 pid 40342
2024-06-06T10:26:40.747705+08:00 kernel: amdgpu 0000:03:00.0: amdgpu:   in =
page starting at address 0x0000800107001000 from client 0x12 (VMC)
2024-06-06T10:26:40.747707+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_=
L2_PROTECTION_FAULT_STATUS:0x00000000
2024-06-06T10:26:40.747710+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 Fau=
lty UTCL2 client ID: MP0 (0x0)
2024-06-06T10:26:40.747713+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MOR=
E_FAULTS: 0x0
2024-06-06T10:26:40.747716+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 WAL=
KER_ERROR: 0x0
2024-06-06T10:26:40.747718+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 PER=
MISSION_FAULTS: 0x0
2024-06-06T10:26:40.747721+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 MAP=
PING_ERROR: 0x0
2024-06-06T10:26:40.747723+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: 	 RW:=
 0x0
2024-06-06T10:26:51.094991+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]]=
 *ERROR* ring vcn_dec_0 timeout, signaled seq=3D24897, emitted seq=3D24898
2024-06-06T10:26:51.095023+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]]=
 *ERROR* Process information: process RDD Process pid 39524 thread firefox-=
bi:cs0 pid 40342
2024-06-06T10:26:51.095025+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU r=
eset begin!
2024-06-06T10:26:52.305509+08:00 kernel: [drm] Register(0) [mmUVD_POWER_STA=
TUS] failed to reach value 0x00000001 !=3D 0x00000002n
2024-06-06T10:26:52.586019+08:00 kernel: [drm] Register(0) [mmUVD_RBC_RB_RP=
TR] failed to reach value 0x000003c0 !=3D 0x00000360n
2024-06-06T10:26:52.639506+08:00 kernel: [drm] Register(0) [mmUVD_POWER_STA=
TUS] failed to reach value 0x00000001 !=3D 0x00000002n
2024-06-06T10:26:52.639521+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MODE2=
 reset
2024-06-06T10:26:52.650614+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU r=
eset succeeded, trying to resume
2024-06-06T10:26:52.650633+08:00 kernel: [drm] PCIE GART of 1024M enabled (=
table at 0x000000F41FC00000).
2024-06-06T10:26:52.650637+08:00 kernel: [drm] VRAM is lost due to GPU rese=
t!
2024-06-06T10:26:52.650641+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: PSP i=
s resuming...
2024-06-06T10:26:52.673474+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: reser=
ve 0xa00000 from 0xf41e000000 for PSP TMR
2024-06-06T10:26:53.001513+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: RAS: =
optional ras ta ucode is not available
2024-06-06T10:26:53.013802+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: RAP: =
optional rap ta ucode is not available
2024-06-06T10:26:53.013816+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SECUR=
EDISPLAY: securedisplay ta ucode is not available
2024-06-06T10:26:53.013819+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SMU i=
s resuming...
2024-06-06T10:26:53.016519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SMU i=
s resumed successfully!
2024-06-06T10:26:53.017502+08:00 kernel: [drm] DMUB hardware initialized: v=
ersion=3D0x04000044
2024-06-06T10:26:53.677511+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q 0
2024-06-06T10:26:53.958512+08:00 kernel: amdgpu 0000:03:00.0: [drm:amdgpu_r=
ing_test_helper [amdgpu]] *ERROR* ring vcn_dec_0 test failed (-110)
2024-06-06T10:26:53.958536+08:00 kernel: [drm:amdgpu_device_ip_resume_phase=
2 [amdgpu]] *ERROR* resume of IP block &lt;vcn_v3_0&gt; failed -110
2024-06-06T10:26:53.958539+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU r=
eset(1) failed
2024-06-06T10:26:53.958541+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU r=
eset end with ret =3D -110
2024-06-06T10:26:53.959180+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]]=
 *ERROR* GPU Recovery Failed: -110
2024-06-06T10:26:55.261509+08:00 kernel: [drm] Register(0) [mmUVD_POWER_STA=
TUS] failed to reach value 0x00000001 !=3D 0x00000002n
2024-06-06T10:26:55.540507+08:00 kernel: [drm] Register(0) [mmUVD_RBC_RB_RP=
TR] failed to reach value 0x00000010 !=3D 0x00000000n
2024-06-06T10:27:04.407149+08:00 kernel: [drm] Register(0) [mmUVD_POWER_STA=
TUS] failed to reach value 0x00000001 !=3D 0x00000002n
2024-06-06T10:27:04.407252+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]]=
 *ERROR* ring vcn_dec_0 timeout, signaled seq=3D24898, emitted seq=3D24898
2024-06-06T10:27:04.407257+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]]=
 *ERROR* Process information: process RDD Process pid 39524 thread firefox-=
bi:cs0 pid 40342
2024-06-06T10:27:04.407259+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU r=
eset begin!
2024-06-06T10:27:05.033745+08:00 kernel: ------------[ cut here ]----------=
--
2024-06-06T10:27:05.033773+08:00 kernel: WARNING: CPU: 8 PID: 47039 at driv=
ers/gpu/drm/amd/amdgpu/amdgpu_irq.c:630 amdgpu_irq_put+0x9c/0xb0 [amdgpu]
2024-06-06T10:27:05.033777+08:00 kernel: Modules linked in: nft_reject_inet=
 nf_reject_ipv4 nf_reject_ipv6 nft_reject xt_conntrack nft_chain_nat xt_MAS=
QUERADE nf_nat nf_conntrack_netlink nf_conntrack nf_defrag_ipv6 nf_defrag_i=
pv4 xt_addrtype nft_compat nf_tables libcrc32c br_netfilter bridge stp llc =
hid_logitech_hidpp usbhid xfrm_interface xfrm6_tunnel tunnel4 tunnel6 xfrm_=
user xfrm_algo uhid rfcomm snd_seq_dummy snd_hrtimer cmac algif_hash algif_=
skcipher af_alg overlay qrtr bnep binfmt_misc uvcvideo videobuf2_vmalloc uv=
c videobuf2_memops videobuf2_v4l2 btusb btrtl videodev btintel btbcm snd_ac=
p6x_pdm_dma snd_soc_dmic snd_soc_acp6x_mach amd_atl intel_rapl_msr btmtk vi=
deobuf2_common bluetooth mc intel_rapl_common snd_sof_amd_acp63 snd_sof_amd=
_vangogh snd_sof_amd_rembrandt iwlmvm snd_sof_amd_renoir snd_sof_amd_acp sn=
d_sof_pci snd_sof_xtensa_dsp amdgpu snd_sof edac_mce_amd mac80211 snd_sof_u=
tils snd_pci_ps snd_hda_codec_realtek snd_amd_sdw_acpi kvm_amd soundwire_am=
d snd_hda_codec_generic soundwire_generic_allocation soundwire_bus
2024-06-06T10:27:05.033782+08:00 kernel:  snd_hda_scodec_cs35l41_spi nls_is=
o8859_1 snd_hda_codec_hdmi snd_hda_scodec_component libarc4 kvm snd_soc_cor=
e snd_hda_intel snd_ctl_led snd_intel_dspcfg snd_compress snd_intel_sdw_acp=
i amdxcp snd_seq_midi ac97_bus crct10dif_pclmul drm_exec snd_hda_codec poly=
val_clmulni snd_pcm_dmaengine snd_seq_midi_event gpu_sched polyval_generic =
iwlwifi ghash_clmulni_intel snd_rpl_pci_acp6x drm_buddy sha256_ssse3 snd_hd=
a_core snd_rawmidi snd_acp_pci drm_suballoc_helper snd_hda_scodec_cs35l41_i=
2c sha1_ssse3 drm_ttm_helper snd_acp_legacy_common snd_hwdep snd_hda_scodec=
_cs35l41 aesni_intel snd_pci_acp6x amd_pmf snd_hda_cs_dsp_ctls ttm crypto_s=
imd snd_pci_acp5x snd_soc_cs_amp_lib asus_nb_wmi cs_dsp cryptd amdtee snd_s=
eq snd_rn_pci_acp3x drm_display_helper snd_pcm asus_wmi snd_acp_config rapl=
 wmi_bmof sparse_keymap snd_seq_device cfg80211 snd_soc_cs35l41_lib cec snd=
_soc_acpi ccp rc_core snd_timer i2c_algo_bit i2c_piix4 snd_pci_acp3x k10tem=
p amd_sfh tee snd platform_profile soundcore serial_multi_instantiate amd_p=
mc acpi_tad
2024-06-06T10:27:05.033784+08:00 kernel:  joydev input_leds mac_hid serio_r=
aw parport_pc ppdev lp parport efi_pstore nfnetlink dmi_sysfs ip_tables x_t=
ables autofs4 hid_multitouch nvme video ucsi_acpi hid_generic crc32_pclmul =
nvme_core typec_ucsi xhci_pci i2c_hid_acpi xhci_pci_renesas nvme_auth typec=
 i2c_hid wmi hid 8250_dw
2024-06-06T10:27:05.033785+08:00 kernel: CPU: 8 PID: 47039 Comm: kworker/u6=
4:0 Tainted: G        W          6.10.0-061000rc2-generic #202406022333
2024-06-06T10:27:05.033787+08:00 kernel: Hardware name: ASUSTeK COMPUTER IN=
C. Zenbook UM5302TA_UM5302TA/UM5302TA, BIOS UM5302TA.311 01/17/2023
2024-06-06T10:27:05.033788+08:00 kernel: Workqueue: amdgpu-reset-dev drm_sc=
hed_job_timedout [gpu_sched]
2024-06-06T10:27:05.033789+08:00 kernel: RIP: 0010:amdgpu_irq_put+0x9c/0xb0=
 [amdgpu]
2024-06-06T10:27:05.033790+08:00 kernel: Code: 31 f6 31 ff e9 c0 05 2f e6 4=
4 89 e2 48 89 de 4c 89 f7 e8 97 fc ff ff 5b 41 5c 41 5d 41 5e 5d 31 d2 31 f=
6 31 ff e9 9f 05 2f e6 &lt;0f&gt; 0b b8 ea ff ff ff eb c3 b8 fe ff ff ff eb=
 bc 0f 1f 40 00 90 90
2024-06-06T10:27:05.033791+08:00 kernel: RSP: 0018:ffffb65847227c18 EFLAGS:=
 00010246
2024-06-06T10:27:05.033793+08:00 kernel: RAX: 0000000000000000 RBX: ffff9ac=
0a0280c60 RCX: 0000000000000000
2024-06-06T10:27:05.033794+08:00 kernel: RDX: 0000000000000000 RSI: 0000000=
000000000 RDI: 0000000000000000
2024-06-06T10:27:05.033796+08:00 kernel: RBP: ffffb65847227c38 R08: 0000000=
000000000 R09: 0000000000000000
2024-06-06T10:27:05.033797+08:00 kernel: R10: 0000000000000000 R11: 0000000=
000000000 R12: 0000000000000000
2024-06-06T10:27:05.033798+08:00 kernel: R13: 0000000000000001 R14: ffff9ac=
0a0280000 R15: ffff9ac0a0280000
2024-06-06T10:27:05.033799+08:00 kernel: FS:  0000000000000000(0000) GS:fff=
f9ac38e600000(0000) knlGS:0000000000000000
2024-06-06T10:27:05.033800+08:00 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0=
000000080050033
2024-06-06T10:27:05.033802+08:00 kernel: CR2: 00007d1a5edfe000 CR3: 0000000=
01863c000 CR4: 0000000000f50ef0
2024-06-06T10:27:05.033803+08:00 kernel: PKRU: 55555554
2024-06-06T10:27:05.033805+08:00 kernel: Call Trace:
2024-06-06T10:27:05.033806+08:00 kernel:  &lt;TASK&gt;
2024-06-06T10:27:05.033807+08:00 kernel:  ? show_regs+0x6c/0x80
2024-06-06T10:27:05.033845+08:00 kernel:  ? __warn+0x88/0x140
2024-06-06T10:27:05.034598+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0 [amdgp=
u]
2024-06-06T10:27:05.034615+08:00 kernel:  ? report_bug+0x182/0x1b0
2024-06-06T10:27:05.034618+08:00 kernel:  ? handle_bug+0x51/0xa0
2024-06-06T10:27:05.034619+08:00 kernel:  ? exc_invalid_op+0x18/0x80
2024-06-06T10:27:05.034620+08:00 kernel:  ? asm_exc_invalid_op+0x1b/0x20
2024-06-06T10:27:05.034621+08:00 kernel:  ? amdgpu_irq_put+0x9c/0xb0 [amdgp=
u]
2024-06-06T10:27:05.034623+08:00 kernel:  ? amdgpu_irq_put+0x55/0xb0 [amdgp=
u]
2024-06-06T10:27:05.035573+08:00 kernel:  gmc_v10_0_hw_fini+0x67/0xe0 [amdg=
pu]
2024-06-06T10:27:05.035580+08:00 kernel:  gmc_v10_0_suspend+0xe/0x20 [amdgp=
u]
2024-06-06T10:27:05.035581+08:00 kernel:  amdgpu_device_ip_suspend_phase2+0=
x251/0x480 [amdgpu]
2024-06-06T10:27:05.035582+08:00 kernel:  amdgpu_device_ip_suspend+0x49/0x8=
0 [amdgpu]
2024-06-06T10:27:05.036529+08:00 kernel:  amdgpu_device_pre_asic_reset+0xd1=
/0x490 [amdgpu]
2024-06-06T10:27:05.036546+08:00 kernel:  amdgpu_device_gpu_recover+0x406/0=
xa30 [amdgpu]
2024-06-06T10:27:05.036548+08:00 kernel:  amdgpu_job_timedout+0x141/0x200 [=
amdgpu]
2024-06-06T10:27:05.036550+08:00 kernel:  drm_sched_job_timedout+0x70/0x110=
 [gpu_sched]
2024-06-06T10:27:05.036551+08:00 kernel:  process_one_work+0x186/0x3e0
2024-06-06T10:27:05.036552+08:00 kernel:  worker_thread+0x304/0x440
2024-06-06T10:27:05.036554+08:00 kernel:  ? srso_alias_return_thunk+0x5/0xf=
bef5
2024-06-06T10:27:05.036555+08:00 kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
2024-06-06T10:27:05.036556+08:00 kernel:  ? __pfx_worker_thread+0x10/0x10
2024-06-06T10:27:05.036557+08:00 kernel:  kthread+0xe4/0x110
2024-06-06T10:27:05.036558+08:00 kernel:  ? __pfx_kthread+0x10/0x10
2024-06-06T10:27:05.036559+08:00 kernel:  ret_from_fork+0x47/0x70
2024-06-06T10:27:05.036561+08:00 kernel:  ? __pfx_kthread+0x10/0x10
2024-06-06T10:27:05.036562+08:00 kernel:  ret_from_fork_asm+0x1a/0x30
2024-06-06T10:27:05.036563+08:00 kernel:  &lt;/TASK&gt;
2024-06-06T10:27:05.036564+08:00 kernel: ---[ end trace 0000000000000000 ]-=
--
2024-06-06T10:27:05.036565+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: MODE2=
 reset
2024-06-06T10:27:05.046502+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU r=
eset succeeded, trying to resume
2024-06-06T10:27:05.047516+08:00 kernel: [drm] PCIE GART of 1024M enabled (=
table at 0x000000F41FC00000).
2024-06-06T10:27:05.047533+08:00 kernel: [drm] VRAM is lost due to GPU rese=
t!
2024-06-06T10:27:05.047538+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: PSP i=
s resuming...
2024-06-06T10:27:05.070481+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: reser=
ve 0xa00000 from 0xf41e000000 for PSP TMR
2024-06-06T10:27:05.397519+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: RAS: =
optional ras ta ucode is not available
2024-06-06T10:27:05.409509+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: RAP: =
optional rap ta ucode is not available
2024-06-06T10:27:05.409517+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SECUR=
EDISPLAY: securedisplay ta ucode is not available
2024-06-06T10:27:05.409518+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SMU i=
s resuming...
2024-06-06T10:27:05.411482+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: SMU i=
s resumed successfully!
2024-06-06T10:27:05.413504+08:00 kernel: [drm] DMUB hardware initialized: v=
ersion=3D0x04000044
2024-06-06T10:27:06.055474+08:00 kernel: [drm] kiq ring mec 2 pipe 1 q 0
2024-06-06T10:27:06.335476+08:00 kernel: amdgpu 0000:03:00.0: [drm:amdgpu_r=
ing_test_helper [amdgpu]] *ERROR* ring vcn_dec_0 test failed (-110)
2024-06-06T10:27:06.335495+08:00 kernel: [drm:amdgpu_device_ip_resume_phase=
2 [amdgpu]] *ERROR* resume of IP block &lt;vcn_v3_0&gt; failed -110
2024-06-06T10:27:06.335498+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU r=
eset(2) failed
2024-06-06T10:27:06.335499+08:00 kernel: amdgpu 0000:03:00.0: amdgpu: GPU r=
eset end with ret =3D -110
2024-06-06T10:27:06.335631+08:00 kernel: [drm:amdgpu_job_timedout [amdgpu]]=
 *ERROR* GPU Recovery Failed: -110</pre></div></div>

--000000000000f00bd3061a2ff9b4--
