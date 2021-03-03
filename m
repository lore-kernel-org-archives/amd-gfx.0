Return-Path: <SRS0=hRd6=IB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2979C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 14:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5853A64EDC
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Mar 2021 14:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5853A64EDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD7296E05A;
	Wed,  3 Mar 2021 14:22:32 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 983716E05A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Mar 2021 14:22:31 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id d20so26082127oiw.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Mar 2021 06:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BKMoJ+FV+nYu5u8Sz6LdWOtG5ZjwxNjVQhDSXYTXMB4=;
 b=oE6QUBpXqVDWH2pW/Zqsz+ipDdjSRpDluQV+IQDtzgDZeFrsTGGaeUWxTr+WbUpyNM
 PlbgMeyOYznwRF1ViM0ZcShobcf2u1BpevFaOjxfkpR0PsTj5iOIVO2aTvHc39yIfTOu
 v2SuXJ908Mo48QIeWLnH8nZ/543ueCTgTrvoG7T5pLPt1Gtkr1NlfB/jLDgCQMT31Mi2
 MsVmYwzRqBCMyipZlt4bQXGHh36uxIGm5/uNCe96PT8Y0Qxw6HDPt6pdDOuwsk/stWRk
 7Sfag2ZyXmYfUFr0+z+uPo+Fy+aWo/9b3wyLHx5QdJc6BQ5T1c/T4ukbx0w7XC29hFt4
 tuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BKMoJ+FV+nYu5u8Sz6LdWOtG5ZjwxNjVQhDSXYTXMB4=;
 b=o0E32DO7NxAlC29yZLikLizJe4ibVOKLhCA2ZgMD35q6v/QTFhfO1MDzxuMAotqRuZ
 Ug+PbU7COBU4TSg4M071OoLFwonGFRRoi/nUa5BbMCT1BdAsiMiFEaEzv6sTWpLq4LF4
 odP3J5mKut0grIFuEAxyKeTgBE++9JyakD7MsVriKMjAFCUnnloYM8lUuFTYR6FV6hY3
 8OKQczfq75pX6J+E44wE/LJdaF4f0dN64Az00WBeCkLWXGclxgckuPG1qvJFi3ZKyOP5
 V6e6Ak9bnLgFpyT1kMPSq9yoQySSZqdLiV/DrQZmO9G4OZTNW6tu9Z1GeV3lCTJLpmEw
 oYfw==
X-Gm-Message-State: AOAM532lTHMvSQR113WrPRTncvjLoHbxC9uIpBNOBzJjYdNo4OuhpA9W
 hJ0H/BcFHqkRl9bXuDLLlIs0RkRjkO2Dtnrr+1B3DblSLxQ=
X-Google-Smtp-Source: ABdhPJz0iOyz5GgL0lmeBj15+lF0dBEGQbHKiMLQzLG+yDPGockWzgV6PZ2nDWLiKLMBzXfSXLGYKFgfFKL21MQclfE=
X-Received: by 2002:aca:f485:: with SMTP id s127mr7454441oih.120.1614781350907; 
 Wed, 03 Mar 2021 06:22:30 -0800 (PST)
MIME-Version: 1.0
References: <84c1be4bb2e60dd8e19256dd51945ca2@talpidae.net>
In-Reply-To: <84c1be4bb2e60dd8e19256dd51945ca2@talpidae.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Mar 2021 09:22:19 -0500
Message-ID: <CADnq5_Oii3xB-wz1b6JMVjmfkgMqzjuQ8teH1uPD9Gz5nWHr+w@mail.gmail.com>
Subject: Re: AMDGPU Linux 5.11.0 freezes (divide error)
To: Jonas Zeiger <jonas.zeiger@talpidae.net>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 3, 2021 at 8:52 AM Jonas Zeiger <jonas.zeiger@talpidae.net> wrote:
>
> Hi all,
>
> I am experiencing random system freezes (about once per day) after updating to Linux 5.11 (vanilla kernel).
>
> Only a manual power-cycle makes the system usable again afterwards.
>
> These freezes didn't occur on 5.10.x but I hadn't assigned "nohz_full=2-16" and "cpuidle.governor=teo" back then.

Should be fixed with this patch I think:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=41401ac67791810dd880345962339aa1bedd3c0d

Alex

>
> Hardware:
>
> ThinkPad T14 (gen1)
> CPU: AMD Ryzen 7 PRO 4750U with Radeon Graphics
>
> Kernel cmdline:
>
> BOOT_IMAGE=/vmlinuz-5.11.0zlinux-svr-docker-wg root=/dev/nvme0n1p2 ro nohz_full=2-16 cpuidle.governor=teo rootfstype=ext4 rootwait ivrs_ioapic[4]=00:14.0 ivrs_ioapic[5]=00:00.2
>
> This is logged to the journal:
>
> kernel: divide error: 0000 [#1] PREEMPT SMP
> kernel: CPU: 8 PID: 2914 Comm: Xorg Not tainted 5.11.0zlinux-svr-docker-wg #8
> kernel: Hardware name: LENOVO 20UD0013GE/20UD0013GE, BIOS R1BET58W(1.27 ) 10/20/2020
> kernel: RIP: 0010:Calculate256BBlockSizes+0x50/0xc1 [amdgpu]
> kernel: Code: 83 ff 02 75 09 41 c7 00 04 00 00 00 eb 15 83 ff 08 75 09 41 c7 00 10 00 00 00 eb 07 4>
> kernel: RSP: 0018:ffffa35e815fb688 EFLAGS: 00010246
> kernel: RAX: 0000000000000100 RBX: ffff98afc1debaf8 RCX: 0000000000000000
> kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> kernel: RBP: ffff98afc1de2090 R08: ffff98afc1debab8 R09: ffff98afc1debad8
> kernel: R10: 0000000000000002 R11: ffff98afc1debb18 R12: ffff98a8d9ddd000
> kernel: R13: 0000000000000000 R14: ffff98afc1de31c8 R15: ffff98afc1de2090
> kernel: FS:  00007f41f3ff0a40(0000) GS:ffff98b35fa00000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 00007f0486175000 CR3: 0000000116542000 CR4: 0000000000350ee0
> kernel: Call Trace:
> kernel:  DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation+0xdb8/0x>
> kernel:  ? ModeSupportAndSystemConfiguration+0x77/0xe7 [amdgpu]
> kernel:  ? dcn_bw_ceil2+0x19/0x3b [amdgpu]
> kernel:  ? dml21_recalculate+0x59c/0x5b3 [amdgpu]
> kernel:  get_wm_urgent+0x9/0x13 [amdgpu]
> kernel:  dml21_rq_dlg_get_dlg_reg+0x6c/0x1804 [amdgpu]
> kernel:  ? dcn_bw_ceil2+0x19/0x3b [amdgpu]
> kernel:  ? DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation+0x3e06>
> kernel:  dcn20_calculate_dlg_params+0x333/0x3af [amdgpu]
> kernel:  dcn21_validate_bandwidth+0x4cd/0x581 [amdgpu]
> kernel:  dc_validate_global_state+0x1a7/0x1c5 [amdgpu]
> kernel:  amdgpu_dm_atomic_check+0x84c/0xa00 [amdgpu]
> kernel:  ? __radix_tree_lookup+0x2a/0x91
> kernel:  drm_atomic_check_only+0x5bb/0x6b7
> kernel:  ? drm_mode_object_put+0x21/0x2d
> kernel:  ? drm_atomic_set_property+0x7b3/0x7c5
> kernel:  drm_atomic_commit+0xe/0x44
> kernel:  drm_mode_obj_set_property_ioctl+0x112/0x268
> kernel:  ? __fpu__restore_sig+0x21e/0x46d
> kernel:  ? drm_mode_obj_find_prop_id+0x23/0x23
> kernel:  drm_ioctl_kernel+0x7d/0xbc
> kernel:  drm_ioctl+0x1f2/0x2c9
> kernel:  ? drm_mode_obj_find_prop_id+0x23/0x23
> kernel:  ? rpm_resume+0x43e/0x450
> kernel:  amdgpu_drm_ioctl+0x45/0x71 [amdgpu]
> kernel:  vfs_ioctl+0x1a/0x28
> kernel:  __do_sys_ioctl+0x51/0x74
> kernel:  do_syscall_64+0x33/0x40
> kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> kernel: RIP: 0033:0x7f41f445bcc7
> kernel: Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1>
> kernel: RSP: 002b:00007ffd7b9f4db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> kernel: RAX: ffffffffffffffda RBX: 00007ffd7b9f4df0 RCX: 00007f41f445bcc7
> kernel: RDX: 00007ffd7b9f4df0 RSI: 00000000c01864ba RDI: 000000000000000f
> kernel: RBP: 00000000c01864ba R08: 0000000000000073 R09: 00000000cccccccc
> kernel: R10: 0000000000000fff R11: 0000000000000246 R12: 0000561f30685480
> kernel: R13: 000000000000000f R14: 0000000000000000 R15: 0000000000000003
> kernel: Modules linked in: iwlmvm iwlwifi amdgpu drm_ttm_helper ttm mfd_core gpu_sched r8169
> kernel: ---[ end trace 7e898fd18a4b26cd ]---
> kernel: ------------[ cut here ]------------
> kernel: WARNING: CPU: 8 PID: 2914 at rcu_note_context_switch+0x3a/0x2d5
> kernel: Modules linked in: iwlmvm iwlwifi amdgpu drm_ttm_helper ttm mfd_core gpu_sched r8169
> kernel: CPU: 8 PID: 2914 Comm: Xorg Tainted: G      D           5.11.0zlinux-svr-docker-wg #8
> kernel: Hardware name: LENOVO 20UD0013GE/20UD0013GE, BIOS R1BET58W(1.27 ) 10/20/2020
> kernel: RIP: 0010:rcu_note_context_switch+0x3a/0x2d5
> kernel: Code: 40 65 02 00 55 53 89 fb 65 4c 03 25 ff cb ed 68 48 8b 3d c8 af b0 01 e8 3d cd ff ff 8>
> kernel: RSP: 0018:ffffa35e815fb160 EFLAGS: 00010002
> kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
> kernel: RDX: 0000000000000002 RSI: ffffa35e815fb230 RDI: ffffffff9884fce6
> kernel: RBP: ffffa35e815fb1c0 R08: ffffffff9884fce6 R09: ffff98a880060020
> kernel: R10: ffff98a880060000 R11: ffffa35e815fb37b R12: ffff98b35fa26540
> kernel: R13: ffff98a884cf6900 R14: 0000000000000000 R15: ffffffff97ac8616
> kernel: FS:  00007f41f3ff0a40(0000) GS:ffff98b35fa00000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 00007f0486175000 CR3: 0000000116542000 CR4: 0000000000350ee0
> kernel: Call Trace:
> kernel:  __schedule+0x87/0x522
> kernel:  ? __default_send_IPI_dest_field+0x1c/0x44
> kernel:  ? usleep_range+0x4f/0x4f
> kernel:  schedule+0x81/0xa7
> kernel:  schedule_timeout+0x1c/0xb4
> kernel:  ? try_to_wake_up+0x1ba/0x1e8
> kernel:  __wait_for_common+0xaa/0x10a
> kernel:  virt_efi_query_variable_info+0xff/0x135
> kernel:  efi_query_variable_store+0x7e/0x166
> kernel:  efivar_entry_set_safe+0x148/0x1b5
> kernel:  efi_pstore_write+0xdc/0x10c
> kernel:  pstore_dump+0x1f5/0x239
> kernel:  kmsg_dump+0x8b/0xa0
> kernel:  oops_end+0x3d/0x8d
> kernel:  do_trap+0x77/0xf6
> kernel:  ? Calculate256BBlockSizes+0x50/0xc1 [amdgpu]
> kernel:  ? Calculate256BBlockSizes+0x50/0xc1 [amdgpu]
> kernel:  do_error_trap+0x6a/0x90
> kernel:  ? dcn_bw_ceil2+0x19/0x3b [amdgpu]
> kernel:  ? dml21_recalculate+0x59c/0x5b3 [amdgpu]
> kernel:  get_wm_urgent+0x9/0x13 [amdgpu]
> kernel:  dml21_rq_dlg_get_dlg_reg+0x6c/0x1804 [amdgpu]
> kernel:  ? dcn_bw_ceil2+0x19/0x3b [amdgpu]
> kernel:  ? DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation+0x3e06/0x3eba [amdgpu]
> kernel:  dcn20_calculate_dlg_params+0x333/0x3af [amdgpu]
> kernel:  dcn21_validate_bandwidth+0x4cd/0x581 [amdgpu]
> kernel:  dc_validate_global_state+0x1a7/0x1c5 [amdgpu]
> kernel:  amdgpu_dm_atomic_check+0x84c/0xa00 [amdgpu]
> kernel:  ? __radix_tree_lookup+0x2a/0x91
> kernel:  drm_atomic_check_only+0x5bb/0x6b7
> kernel:  ? drm_mode_object_put+0x21/0x2d
> kernel:  ? drm_atomic_set_property+0x7b3/0x7c5
> kernel:  drm_atomic_commit+0xe/0x44
> kernel:  drm_mode_obj_set_property_ioctl+0x112/0x268
> kernel:  ? __fpu__restore_sig+0x21e/0x46d
> kernel:  ? drm_mode_obj_find_prop_id+0x23/0x23
> kernel:  drm_ioctl_kernel+0x7d/0xbc
> kernel:  drm_ioctl+0x1f2/0x2c9
> kernel:  ? drm_mode_obj_find_prop_id+0x23/0x23
> kernel:  ? rpm_resume+0x43e/0x450
> kernel:  amdgpu_drm_ioctl+0x45/0x71 [amdgpu]
> kernel:  vfs_ioctl+0x1a/0x28
> kernel:  __do_sys_ioctl+0x51/0x74
> kernel:  do_syscall_64+0x33/0x40
> kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> kernel: RIP: 0033:0x7f41f445bcc7
> kernel: Code: 00 00 00 48 8b 05 c9 91 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 99 91 0c 00 f7 d8 64 89 01 48
> kernel: RSP: 002b:00007ffd7b9f4db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> kernel: RAX: ffffffffffffffda RBX: 00007ffd7b9f4df0 RCX: 00007f41f445bcc7
> kernel: RDX: 00007ffd7b9f4df0 RSI: 00000000c01864ba RDI: 000000000000000f
> kernel: RBP: 00000000c01864ba R08: 0000000000000073 R09: 00000000cccccccc
> kernel: R10: 0000000000000fff R11: 0000000000000246 R12: 0000561f30685480
> kernel: R13: 000000000000000f R14: 0000000000000000 R15: 0000000000000003
> kernel: ---[ end trace 7e898fd18a4b26ce ]---
> kernel: RIP: 0010:Calculate256BBlockSizes+0x50/0xc1 [amdgpu]
> kernel: Code: 83 ff 02 75 09 41 c7 00 04 00 00 00 eb 15 83 ff 08 75 09 41 c7 00 10 00 00 00 eb 07 41 c7 00 08 00 00 00 b8 00 01 00 00 31 d2 <f7> f6 31 d2 41 f7 30 89 03 41 c7 01 00 00 00 00 41 c7 03 00 00 00
> kernel: RSP: 0018:ffffa35e815fb688 EFLAGS: 00010246
> kernel: RAX: 0000000000000100 RBX: ffff98afc1debaf8 RCX: 0000000000000000
> kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
> kernel: RBP: ffff98afc1de2090 R08: ffff98afc1debab8 R09: ffff98afc1debad8
> kernel: R10: 0000000000000002 R11: ffff98afc1debb18 R12: ffff98a8d9ddd000
> kernel: R13: 0000000000000000 R14: ffff98afc1de31c8 R15: ffff98afc1de2090
> kernel: FS:  00007f41f3ff0a40(0000) GS:ffff98b35fb80000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 00007f79e14ed000 CR3: 0000000116542000 CR4: 0000000000350ee0
>
> Feel free to contact me if you think I can help narrow down this issue.
>
> Thank you for your great work on the AMDGPU driver and Linux kernel.
>
> Kind regards,
> Jonas Zeiger
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
