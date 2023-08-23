Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BC7EE49B5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 12:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A53D10E415;
	Wed, 23 Aug 2023 12:10:36 +0000 (UTC)
X-Greylist: delayed 421 seconds by postgrey-1.36 at gabe;
 Wed, 23 Aug 2023 09:00:45 UTC
Received: from iam.tj (soggy.cloud [IPv6:2a01:7e00:e000:151::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 393AF10E3FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 09:00:45 +0000 (UTC)
Received: from [IPV6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1] (unknown
 [IPv6:2a01:7e00:e001:ee80:145d:5eff:feb1:1df1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by iam.tj (Postfix) with ESMTPSA id 9D8F73414A
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 09:53:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=iam.tj; s=2019;
 t=1692780821; bh=dz25kycAHlSfcx4qXpNp5kM0z1nXfXAzq50otPD+EzY=;
 h=Date:To:From:Subject:From;
 b=lIbWdWZiqOsqQBeLhLNWlGRrGMs0keIA5erYLxsdvXD9oGkCk7UfAX0eNnugwblNG
 7/kM2FEG0qzpLzd5sXoHPU9P+XdXR/0uhnOboCTXTioghmQYO/y0miQBjpRryFbN4/
 GX+PhrTZdY2Yfd5S716Qz09Q7GDg47nR8M3DAIs/s3vGmid0Lp1upCBwwSxcWku5k7
 QHwu/pjRzCB7aJ+T+5WqQ057m2b1rWM/IleJkLP/tb++RPsE2ziyvpFC/Cw3TB46Xe
 HlZvXKQYFVRzp9zTwu/uJkHyuqdhAitR3yX3VAjjKQMk4AxO4JB7z6BEFLBJunWOdm
 /zOEfzgz7S/eg==
Message-ID: <590a06b6-9f59-2b4e-dd79-091091ccb3b6@iam.tj>
Date: Wed, 23 Aug 2023 09:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-GB
To: amd-gfx@lists.freedesktop.org
From: Tj <linux@iam.tj>
Subject: 6.5.0-rc7: RIP: 0010:radeon_gem_va_ioctl+0x3dc/0x4f0 [radeon]
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 23 Aug 2023 12:10:34 +0000
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

Recently, and I think especially since 6.5.0-rc5 (but possibly earlier), on resume from S3 suspend the host sees:

$ uname -r; lspci -nnk -d ::0300
6.5.0-rc7+debian+tj
0a:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde GL [FirePro W4100] [1002:682c]
         Subsystem: Dell Cape Verde GL [FirePro W4100] [1028:2b1e]
         Kernel driver in use: radeon
         Kernel modules: radeon, amdgpu


Aug 23 09:34:22 sunny kernel: BUG: kernel NULL pointer dereference, address: 00000000000001e8
Aug 23 09:34:22 sunny kernel: #PF: supervisor read access in kernel mode
Aug 23 09:34:22 sunny kernel: #PF: error_code(0x0000) - not-present page
Aug 23 09:34:22 sunny kernel: PGD 31fde8067 P4D 31fde8067 PUD 0
Aug 23 09:34:22 sunny kernel: Oops: 0000 [#2] PREEMPT SMP NOPTI
Aug 23 09:34:22 sunny kernel: CPU: 13 PID: 404742 Comm: Renderer Tainted: G      D W  OE      6.5.0-rc7+debian+tj #75
Aug 23 09:34:22 sunny kernel: Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 6042 04/28/2022
Aug 23 09:34:22 sunny kernel: RIP: 0010:radeon_gem_va_ioctl+0x3dc/0x4f0 [radeon]
Aug 23 09:34:22 sunny kernel: Code: d2 e6 a7 c0 e8 c5 98 2f ee c7 43 04 01 00 00 00 41 bd ea ff ff ff e9 b3 fe ff ff 49 8b 41 70 4c 89 ce 4c 89 e7 4c 89 4c 24 08 <48> 8b >
Aug 23 09:34:22 sunny kernel: RSP: 0018:ffffa6e9c5227bf0 EFLAGS: 00010282
Aug 23 09:34:22 sunny kernel: RAX: 0000000000000000 RBX: ffffa6e9c5227d28 RCX: 0000000000000000
Aug 23 09:34:22 sunny kernel: RDX: 0000000000000001 RSI: ffff9825ea5a9880 RDI: ffff9823c29dc000
Aug 23 09:34:22 sunny kernel: RBP: ffffa6e9c5227c90 R08: 0000000000000000 R09: ffff9825ea5a9880
Aug 23 09:34:22 sunny kernel: R10: 000000000007bee7 R11: ffffa6e900858000 R12: ffff9823c29dc000
Aug 23 09:34:22 sunny kernel: R13: 0000000000000000 R14: ffffa6e9c5227c08 R15: ffff982620c00c78
Aug 23 09:34:22 sunny kernel: FS:  00007fd4e32be6c0(0000) GS:ffff982aced40000(0000) knlGS:0000000000000000
Aug 23 09:34:22 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 23 09:34:22 sunny kernel: CR2: 00000000000001e8 CR3: 00000004609b8000 CR4: 0000000000350ee0
Aug 23 09:34:22 sunny kernel: Call Trace:
Aug 23 09:34:22 sunny kernel:  <TASK>
Aug 23 09:34:22 sunny kernel:  ? __die+0x1f/0x70
Aug 23 09:34:22 sunny kernel:  ? page_fault_oops+0x159/0x470
Aug 23 09:34:22 sunny kernel:  ? srso_return_thunk+0x5/0x10
Aug 23 09:34:22 sunny kernel:  ? do_user_addr_fault+0x65/0x640
Aug 23 09:34:22 sunny kernel:  ? exc_page_fault+0x73/0x170
Aug 23 09:34:22 sunny kernel:  ? asm_exc_page_fault+0x22/0x30
Aug 23 09:34:22 sunny kernel:  ? radeon_gem_va_ioctl+0x3dc/0x4f0 [radeon]
Aug 23 09:34:22 sunny kernel:  ? tomoyo_path_number_perm+0x68/0x1d0
Aug 23 09:34:22 sunny kernel:  ? __pfx_radeon_gem_va_ioctl+0x10/0x10 [radeon]
Aug 23 09:34:22 sunny kernel:  drm_ioctl_kernel+0xc1/0x160 [drm]
Aug 23 09:34:22 sunny kernel:  drm_ioctl+0x24c/0x490 [drm]
Aug 23 09:34:22 sunny kernel:  ? __pfx_radeon_gem_va_ioctl+0x10/0x10 [radeon]
Aug 23 09:34:22 sunny kernel:  radeon_drm_ioctl+0x49/0x80 [radeon]
Aug 23 09:34:22 sunny kernel:  __x64_sys_ioctl+0x93/0xd0
Aug 23 09:34:22 sunny kernel:  do_syscall_64+0x5b/0xc0
Aug 23 09:34:22 sunny kernel:  ? srso_return_thunk+0x5/0x10
Aug 23 09:34:22 sunny kernel:  ? __fget_light+0x9d/0x100
Aug 23 09:34:22 sunny kernel:  ? srso_return_thunk+0x5/0x10
Aug 23 09:34:22 sunny kernel:  ? fpregs_assert_state_consistent+0x22/0x50
Aug 23 09:34:22 sunny kernel:  ? srso_return_thunk+0x5/0x10
Aug 23 09:34:22 sunny kernel:  ? exit_to_user_mode_prepare+0x40/0x1d0
Aug 23 09:34:22 sunny kernel:  ? srso_return_thunk+0x5/0x10
Aug 23 09:34:22 sunny kernel:  ? syscall_exit_to_user_mode+0x27/0x40
Aug 23 09:34:22 sunny kernel:  ? srso_return_thunk+0x5/0x10
Aug 23 09:34:22 sunny kernel:  ? do_syscall_64+0x67/0xc0
Aug 23 09:34:22 sunny kernel:  ? srso_return_thunk+0x5/0x10
Aug 23 09:34:22 sunny kernel:  ? syscall_exit_to_user_mode+0x27/0x40
Aug 23 09:34:22 sunny kernel:  ? srso_return_thunk+0x5/0x10
Aug 23 09:34:22 sunny kernel:  ? do_syscall_64+0x67/0xc0
Aug 23 09:34:22 sunny kernel:  ? fpregs_assert_state_consistent+0x22/0x50
Aug 23 09:34:22 sunny kernel:  ? srso_return_thunk+0x5/0x10
Aug 23 09:34:22 sunny kernel:  ? exit_to_user_mode_prepare+0x40/0x1d0
Aug 23 09:34:22 sunny kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
Aug 23 09:34:22 sunny kernel: RIP: 0033:0x7fd4fd83db3b
Aug 23 09:34:22 sunny kernel: Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 >
Aug 23 09:34:22 sunny kernel: RSP: 002b:00007fd4e32bbe10 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
Aug 23 09:34:22 sunny kernel: RAX: ffffffffffffffda RBX: 00007fd49cb8a040 RCX: 00007fd4fd83db3b
Aug 23 09:34:22 sunny kernel: RDX: 00007fd4e32bbec0 RSI: 00000000c018646b RDI: 000000000000002d
Aug 23 09:34:22 sunny kernel: RBP: 00007fd4e32bbec0 R08: 00007fd4fd5ca3f0 R09: 00007fd48adeff80
Aug 23 09:34:22 sunny kernel: R10: 000000000007e000 R11: 0000000000000246 R12: 00000000c018646b
Aug 23 09:34:22 sunny kernel: R13: 000000000000002d R14: 00007fd4fd5ca358 R15: 00000000000c9000
Aug 23 09:34:22 sunny kernel:  </TASK>
Aug 23 09:34:22 sunny kernel: Modules linked in: uinput veth rfcomm snd_seq_dummy snd_hrtimer snd_seq snd_seq_device nft_masq nvme_fabrics rdma_ucm ib_uverbs rdma_cm iw_c>
Aug 23 09:34:22 sunny kernel:  bluetooth pcspkr sp5100_tco acpi_cpufreq snd_hda_core watchdog wmi_bmof snd_hwdep mxm_wmi ccp k10temp i2c_piix4 snd_pcm rng_core snd_timer >
Aug 23 09:34:22 sunny kernel:  crct10dif_generic crct10dif_pclmul scsi_common usb_common crct10dif_common gpio_amdpt wmi gpio_generic
Aug 23 09:34:22 sunny kernel: CR2: 00000000000001e8
Aug 23 09:34:22 sunny kernel: ---[ end trace 0000000000000000 ]---
Aug 23 09:34:22 sunny kernel: RIP: 0010:radeon_gem_va_ioctl+0x3dc/0x4f0 [radeon]
Aug 23 09:34:22 sunny kernel: Code: d2 e6 a7 c0 e8 c5 98 2f ee c7 43 04 01 00 00 00 41 bd ea ff ff ff e9 b3 fe ff ff 49 8b 41 70 4c 89 ce 4c 89 e7 4c 89 4c 24 08 <48> 8b >
Aug 23 09:34:22 sunny kernel: RSP: 0018:ffffa6e9ccd67c10 EFLAGS: 00010202
Aug 23 09:34:22 sunny kernel: RAX: 0000000000000000 RBX: ffffa6e9ccd67d48 RCX: 0000000000000000
Aug 23 09:34:22 sunny kernel: RDX: 0000000000000001 RSI: ffff9823c5fd3200 RDI: ffff9823c29dc000
Aug 23 09:34:22 sunny kernel: RBP: ffffa6e9ccd67cb0 R08: 0000000000000000 R09: ffff9823c5fd3200
Aug 23 09:34:22 sunny kernel: R10: 000000000004be00 R11: ffffa6e900858000 R12: ffff9823c29dc000
Aug 23 09:34:22 sunny kernel: R13: 0000000000000000 R14: ffffa6e9ccd67c28 R15: ffff982591b21478
Aug 23 09:34:22 sunny kernel: FS:  00007fd4e32be6c0(0000) GS:ffff982aced40000(0000) knlGS:0000000000000000
Aug 23 09:34:22 sunny kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Aug 23 09:34:22 sunny kernel: CR2: 00000000000001e8 CR3: 00000004609b8000 CR4: 0000000000350ee0

Note: tainted due to building out-of-tree it87 to support mobo sensors
