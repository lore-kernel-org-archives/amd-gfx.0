Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE87C02184
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jan 2025 16:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C8B10E72A;
	Mon, 13 Jan 2025 16:45:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OlB/wQFW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5277710E72A;
 Mon, 13 Jan 2025 16:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736786709; x=1768322709;
 h=from:to:subject:in-reply-to:references:date:message-id:
 mime-version:content-transfer-encoding;
 bh=D/FEDvK/MGCzHnDd2wgr5sAsfkdhqlM2Z38rEqyK2tI=;
 b=OlB/wQFWj3PM0bH+OmqemAfKherlaHWAhutS43lA/IT+MEIol8GKy7+N
 rLL8CxvodduN9iRclDarqqfYzdGBXfJQDY9F7eHGhOY7o9qEbQj3PsBMt
 ahg4Utyim2TmI0U2jA6f3JK8UIZ+bdb0QK3/Ub/1SrYwvsdf829pdewp6
 onXklCYcAq+2FLzDbSSG+u3YKzQr0TC0wNvzil4E111wUwUT8bwh80T8K
 pHCRqU4tDNpBmqwY9Rc0zxT9BipSOdINzXQA9V4igJSNKXWl6j9s4E3bQ
 rmcD+aF6fOpfaBepT1r6WaBDW7Nltl2h2FkAb+q3mQPhWaf+s3f/yd8Oz A==;
X-CSE-ConnectionGUID: R3ZQhY4JQySodE7hsv94lQ==
X-CSE-MsgGUID: UsyBR3U2SoaZxCNBiSvVQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="37086429"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="37086429"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2025 08:45:09 -0800
X-CSE-ConnectionGUID: DEnqptPxRgS8rJl2kdAGdQ==
X-CSE-MsgGUID: wC4RiyGhQ2amzwMrqF5xaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="104313841"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.145])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2025 08:45:07 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Emil J Tywoniak <emil@tywoniak.eu>, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Subject: Re: oops in xe_bo_evict on 6.12.8
In-Reply-To: <1686df0ae8f7caf0d97369a685c810e09afdbca1@tywoniak.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1686df0ae8f7caf0d97369a685c810e09afdbca1@tywoniak.eu>
Date: Mon, 13 Jan 2025 18:45:04 +0200
Message-ID: <87a5buirxr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
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

On Fri, 10 Jan 2025, "Emil J Tywoniak" <emil@tywoniak.eu> wrote:
> What's up gamers,
>
> hope this is the right place to report this oops which possibly is due
> to amdgpu interaction. The community guidelines link for this list
> (https://01.org/linuxgraphics/community) doesn't work. Feel free to
> redirect me if not, even to /dev/null. The Video(DRI - Intel) section
> on kernel bugzilla doesn't seem to get much life.

For the longest time, the fdo gitlab has been the place to report i915
[1] (and lately xe [2]) driver bugs, with a bug filing guide at [3].

However, the backtrace is all amdgpu? You only mention xe_bo_evict in
the subject.

Cc: amd-gfx@lists.freedesktop.org


BR,
Jani.



[1] https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/
[2] https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/
[3] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


>
> I see there have been recent changes to things around bo eviction on
> xe and today I caught the following oops when spawning a second VS
> Code window in sway with the New Window command (Ctrl+Shift+N). VS
> Code was not running on XWayland. So far I haven't been able to
> reproduce this. I have amdgpu loaded as a fall back for my ryzen 7900X
> builtin graphics since I installed the funny GPU (Intel Arc B580 / BMG
> G21). I'm on Mesa 24.3.3.
>
> ------------[ cut here ]------------
> workqueue: WQ_MEM_RECLAIM sdma0:drm_sched_run_job_work [gpu_sched] is flu=
shing !WQ_MEM_RECLAIM events:amdgpu_device_delay_enable_gfx_off [amdgpu]
> WARNING: CPU: 5 PID: 29199 at kernel/workqueue.c:3704 check_flush_depende=
ncy+0x10f/0x130
> Modules linked in: rfcomm snd_seq_dummy snd_hrtimer snd_seq cmac algif_ha=
sh algif_skcipher af_alg nft_chain_nat xt_MASQUERADE nf_conntrack_netlink x=
frm_user xfrm_algo xt_addrtype overlay af_packet bnep btusb btrtl btintel b=
tbcm btmtk bluetooth mousedev cdc_acm joydev nls_iso8859_1 nls_cp437 vfat f=
at mei_gsc_proxy mei_gsc mei_me mei xt_conntrack ip6t_rpfilter mt7921e ipt_=
rpfilter mt7921_common mt792x_lib snd_hda_codec_hdmi mt76_connac_lib edac_m=
ce_amd edac_core mt76 snd_hda_intel amd_atl intel_rapl_msr snd_intel_dspcfg=
 xt_pkttype intel_rapl_common snd_intel_sdw_acpi crct10dif_pclmul xt_LOG ma=
c80211 snd_usb_audio uvcvideo nf_log_syslog snd_usbmidi_lib crc32_pclmul sn=
d_hda_codec xt_tcpudp polyval_clmulni videobuf2_vmalloc xe snd_ump polyval_=
generic uvc snd_hda_core ghash_clmulni_intel cfg80211 nft_compat snd_rawmid=
i sha512_ssse3 videobuf2_memops spd5118 sha256_ssse3 snd_seq_device videobu=
f2_v4l2 snd_hwdep r8169 sha1_ssse3 battery sp5100_tco videobuf2_common aesn=
i_intel snd_pcm watchdog realtek gf128mul
>  crypto_simd mdio_devres videodev snd_timer cryptd libphy rfkill snd i2c_=
piix4 drm_gpuvm wmi_bmof rapl libarc4 led_class mc nf_tables i2c_smbus k10t=
emp soundcore sch_fq_codel tpm_crb rtc_cmos evdev mac_hid tpm_tis gpio_amdp=
t tiny_power_button tpm_tis_core gpio_generic button uinput hid_xpadneo(O) =
ff_memless atkbd libps2 serio vivaldi_fmap loop xt_nat nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c br_netfilter veth tun tap macvlan b=
ridge stp llc kvm_amd ccp kvm fuse efi_pstore configfs nfnetlink efivarfs t=
pm libaescfb ecdh_generic ecc rng_core dmi_sysfs ip_tables x_tables autofs4=
 ext4 crc32c_generic mbcache jbd2 hid_generic usbhid hid ahci libahci xhci_=
pci libata nvme xhci_hcd scsi_mod nvme_core crc32c_intel scsi_common nvme_a=
uth dm_mod dax amdgpu video wmi amdxcp i2c_algo_bit drm_ttm_helper ttm drm_=
exec gpu_sched drm_suballoc_helper drm_buddy drm_display_helper cec crc16
> CPU: 5 UID: 0 PID: 29199 Comm: kworker/u96:0 Tainted: G        W  O      =
 6.12.8 #1-NixOS
> Tainted: [W]=3DWARN, [O]=3DOOT_MODULE
> Hardware name: Micro-Star International Co., Ltd. MS-7D75/MAG B650 TOMAHA=
WK WIFI (MS-7D75), BIOS 1.60 05/30/2023
> Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
> RIP: 0010:check_flush_dependency+0x10f/0x130
> Code: c0 f3 01 01 90 49 8b 45 18 48 8d b2 c0 00 00 00 48 8d 8b c0 00 00 0=
0 49 89 e8 48 c7 c7 a0 c7 df b4 48 89 c2 e8 82 7e fd ff 90 <0f> 0b 90 90 e9=
 0a ff ff ff 80 3d 99 c0 f3 01 00 75 8f e9 42 ff ff
> RSP: 0018:ffff95dd9ef97c60 EFLAGS: 00010046
> RAX: 0000000000000000 RBX: ffff9265c01b8e00 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffffffc0438c00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff92681a13b200
> R13: ffff9265c94338c0 R14: 0000000000000001 R15: ffff9265c01bce00
> FS:  0000000000000000(0000) GS:ffff926cb7e80000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000050d6d0 CR3: 00000002a38d6000 CR4: 0000000000f50ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  ? check_flush_dependency+0x10f/0x130
>  ? __warn.cold+0x93/0xf6
>  ? check_flush_dependency+0x10f/0x130
>  ? report_bug+0x10d/0x150
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? handle_bug+0x61/0xb0
>  ? exc_invalid_op+0x17/0x80
>  ? asm_exc_invalid_op+0x1a/0x20
>  ? __pfx_amdgpu_device_delay_enable_gfx_off+0x10/0x10 [amdgpu]
>  ? check_flush_dependency+0x10f/0x130
>  __flush_work+0x10c/0x320
>  cancel_delayed_work_sync+0x62/0x80
>  amdgpu_gfx_off_ctrl+0xb7/0x150 [amdgpu]
>  amdgpu_ring_alloc+0x40/0x70 [amdgpu]
>  amdgpu_ib_schedule+0xf0/0x750 [amdgpu]
>  amdgpu_job_run+0x8e/0x200 [amdgpu]
>  drm_sched_run_job_work+0x283/0x420 [gpu_sched]
>  process_one_work+0x18a/0x350
>  worker_thread+0x235/0x370
>  ? __pfx_worker_thread+0x10/0x10
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xcd/0x100
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x31/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> ---[ end trace 0000000000000000 ]---
>
> I hope this tells you something. I'm willing to switch to some cutting
> edge kernel commit and report back if I get an oops again, so feel
> free which remote and commit I should go get, or any other
> troubleshooting steps I could follow.
>
> Thanks for all your hard work,
>
> Emil J. Tywoniak (widlarizer)

--=20
Jani Nikula, Intel
