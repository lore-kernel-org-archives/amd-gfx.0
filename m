Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA1EE7717F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Dec 2024 18:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88E610E76B;
	Mon, 16 Dec 2024 18:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GWs76XgU";
	dkim-atps=neutral
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD3BE10E76A
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 18:36:41 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ef6edddf70so486726a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Dec 2024 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734374201; x=1734979001; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GoHpaxKC0+kkzVuZNNTWmHCNqinn+c7Ii7MrNklMZsg=;
 b=GWs76XgUGuozEUQVEGcSPnAtL7bpzVD3OuJKwpY+InNFQcBr2asjEmVKmPOXKUPi5v
 H9Rmyg9YvHNdxCmq361iDqb7FY1rcg4aOgHSZ93xjxuBiiT+ay74esOzPA4Z0R4eTnDG
 6VASQMMMN3kqFqBLqrRmgNGZn1WgeIUzYS+ITk9WJJ3fTHoiEqY6Btqv9mvsijnluL5L
 kUx2JNFpqAJyIftzWw1uupssxK5kc0u/R2EXeUftJxO4A9O0poRI/PFLK/Mvv6bRTY4w
 5kKSZmgs+ItaraZdydY8urxLWHZARmVBBQwnfMrJrBgfdJOh99S2eiRFpDhMBchhF3pX
 z1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734374201; x=1734979001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GoHpaxKC0+kkzVuZNNTWmHCNqinn+c7Ii7MrNklMZsg=;
 b=Sm+gZn8o0ZiaJOQYouZ/cfBhRJKSMvQ3O7EbZwtGpcfFI463xaTWHziRSj5Ywr3WHk
 CGyiJ2uYENw2riyOCwdGDF/v2+YkCvAG2i4KjKKYxsBsOIPevWZ/AkYAVeQ5Ud766IL/
 iZQfY/f7PphRnj209Us9ORlgROC45DIEYRqSaX9COnSoSUvTia2LUX9FukiNkOLZAOLA
 on5SE7TFCF/qxV3Q9m5rpqZ++uea/UM7QNj1EP8T8cqyLIz/M7rm3dZztWz/q4lOnf9V
 lSu9sTFzh3+9YzSH54eeWl+aXw4wjk42jZxsXRgrlJoduO/sm4vcqAWnPjOmyy3Y0G3o
 d9vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhhm0QYUu+MpawEpBL+L8pe5gmqGP3jdcIX4DP7lUQmLqSjUwp8ZQ7KNatC3iT3Er2LHhg0yFp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMecMC7MB5JS9j+p2nzF/ehjNuMfHb8rNagz7H/G7lsebgeAqR
 VpIQne6Yn4yXYRpx+vBVo040ToKJl53xz7hyFOO8gCy38cQie93YMVHTK8OupGBq0nS9kpNVxBB
 kXZK4enIY/aP6lu3sTkHOwjIfgvc=
X-Gm-Gg: ASbGnctl1l46bztGM/0eBInmG8NNovRicwfzws8A5ZurztXobD1mrH+1zurw20nI9Ue
 PD5KqqhckNN0Yx/eJeyGMBrzfsGrawOPeeWvT0Q==
X-Google-Smtp-Source: AGHT+IFPLgnnULim77ZTS270N6gKqb4/FH6nXr2RxedlEA0Rm8kILkobAryUZlvNCyspmPnYuTcIgcSTLnIq+n/hKJU=
X-Received: by 2002:a17:90b:4d08:b0:2ee:f64b:9aab with SMTP id
 98e67ed59e1d1-2f2901a8b82mr7359185a91.6.1734374201367; Mon, 16 Dec 2024
 10:36:41 -0800 (PST)
MIME-Version: 1.0
References: <CAK2bqVJXY2CkR4Od2bj8wnYYfzZCpFYhaiPAcwpw0Uk7zXUVkg@mail.gmail.com>
In-Reply-To: <CAK2bqVJXY2CkR4Od2bj8wnYYfzZCpFYhaiPAcwpw0Uk7zXUVkg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Dec 2024 13:36:29 -0500
Message-ID: <CADnq5_OYjnFhVnQmVLQ7ucSYLm4NZ_wmRnLSOfJQzY33VQZ+EA@mail.gmail.com>
Subject: Re: [WARNING][AMDGPU] WQ_MEM_RECLAIM with Radeon RX 6600
To: Chris Rankin <rankincj@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Matthew Brost <matthew.brost@intel.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Dec 13, 2024 at 7:53=E2=80=AFAM Chris Rankin <rankincj@gmail.com> w=
rote:
>
> Hi,
>
> I've just noticed this warning in my dmesg log. This is a vanilla
> 6.12.4 kernel, with a Radeon RX6600 graphics card.

That was caused by this commit:

commit 746ae46c11137ba21f0c0c68f082a9d8c1222c78
Author: Matthew Brost <matthew.brost@intel.com>
Date:   Wed Oct 23 16:59:17 2024 -0700

    drm/sched: Mark scheduler work queues with WQ_MEM_RECLAIM

    drm_gpu_scheduler.submit_wq is used to submit jobs, jobs are in the pat=
h
    of dma-fences, and dma-fences are in the path of reclaim. Mark schedule=
r
    work queue with WQ_MEM_RECLAIM to ensure forward progress during
    reclaim; without WQ_MEM_RECLAIM, work queues cannot make forward
    progress during reclaim.

However, after further discussion, I think the warning is actually a
false positive.  See this discussion:
https://lists.freedesktop.org/archives/amd-gfx/2024-November/117349.html

From the thread:
"Question is - does check_flush_dependency() need to skip the
!WQ_MEM_RECLAIM flushing WQ_MEM_RECLAIM warning *if* the work is already
running *and* it was called from cancel_delayed_work_sync()?"

Thanks,

Alex


>
> Cheers,
> Chris
>
> [ 4624.741148] ------------[ cut here ]------------
> [ 4624.744474] workqueue: WQ_MEM_RECLAIM sdma0:drm_sched_run_job_work
> [gpu_sched] is flushing !WQ_MEM_RECLAIM
> events:amdgpu_device_delay_enable_gfx_off [amdgpu]
> [ 4624.744942] WARNING: CPU: 2 PID: 9069 at kernel/workqueue.c:3704
> check_flush_dependency+0xbe/0xd0
> [ 4624.765285] Modules linked in: snd_seq_dummy rpcrdma rdma_cm iw_cm
> ib_cm ib_core af_packet nf_conntrack_netbios_ns nf_conntrack_broadcast
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat
> ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw
> ip6table_security iptable_nat iptable_mangle iptable_raw
> iptable_security nf_nat_ftp nf_conntrack_ftp nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 nf_tables libcrc32c ebtable_filter
> ebtables ip6table_filter ip6_tables iptable_filter ip_tables x_tables
> bnep it87 hwmon_vid binfmt_misc snd_hda_codec_realtek
> snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_scodec_component
> snd_hda_intel uvcvideo btusb uvc videobuf2_vmalloc btintel
> videobuf2_memops videobuf2_v4l2 videodev btbcm snd_usb_audio bluetooth
> snd_intel_dspcfg intel_powerclamp snd_hda_codec videobuf2_common
> coretemp snd_virtuoso snd_usbmidi_lib snd_oxygen_lib snd_ctl_led
> kvm_intel input_leds mc snd_hwdep led_class snd_mpu401_uart
> [ 4624.765400]  snd_hda_core joydev snd_rawmidi rfkill kvm snd_seq
> snd_seq_device gpio_ich snd_pcm pktcdvd iTCO_wdt snd_hrtimer r8169
> snd_timer intel_cstate realtek snd mdio_devres intel_uncore libphy
> i2c_i801 soundcore lpc_ich tiny_power_button mxm_wmi i7core_edac
> acpi_cpufreq i2c_smbus pcspkr button nfsd auth_rpcgss nfs_acl lockd
> grace dm_mod fuse sunrpc loop configfs dax nfnetlink zram zsmalloc
> ext4 crc32c_generic mbcache jbd2 amdgpu video amdxcp i2c_algo_bit
> mfd_core drm_ttm_helper ttm drm_exec gpu_sched hid_microsoft
> drm_suballoc_helper drm_buddy drm_display_helper drm_kms_helper usbhid
> sr_mod sd_mod cdrom drm pata_jmicron ahci libahci uhci_hcd xhci_pci
> libata ehci_pci ehci_hcd xhci_hcd scsi_mod firewire_ohci psmouse
> firewire_core usbcore crc32c_intel sha512_ssse3 sha256_ssse3 bsg
> serio_raw sha1_ssse3 drm_panel_orientation_quirks scsi_common crc16
> usb_common crc_itu_t wmi msr gf128mul crypto_simd cryptd
> [ 4624.932496] CPU: 2 UID: 0 PID: 9069 Comm: kworker/u32:3 Tainted: G
>         I        6.12.4 #1
> [ 4624.939803] Tainted: [I]=3DFIRMWARE_WORKAROUND
> [ 4624.942773] Hardware name: Gigabyte Technology Co., Ltd.
> EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
> [ 4624.950340] Workqueue: sdma0 drm_sched_run_job_work [gpu_sched]
> [ 4624.954967] RIP: 0010:check_flush_dependency+0xbe/0xd0
> [ 4624.958806] Code: 75 2a 48 8b 55 18 48 8d 8b c8 00 00 00 4d 89 e0
> 48 81 c6 c8 00 00 00 48 c7 c7 1b d6 e9 81 c6 05 a3 5f 56 01 01 e8 32
> 30 fe ff <0f> 0b 5b 5d 41 5c c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90
> 90 90
> [ 4624.976253] RSP: 0018:ffffc9000bec7c88 EFLAGS: 00010086
> [ 4624.980177] RAX: 0000000000000000 RBX: ffff888100118000 RCX: 000000000=
0000027
> [ 4624.986003] RDX: 0000000000000003 RSI: ffffffff81eab2b9 RDI: 00000000f=
fffffff
> [ 4624.991835] RBP: ffff888155daa900 R08: 0000000000000000 R09: 7067646d6=
1006600
> [ 4624.997668] R10: 0000000000000091 R11: fefefefefefefeff R12: ffffffffa=
05ec880
> [ 4625.003501] R13: 0000000000000001 R14: ffff88810011c600 R15: ffff88816=
3600000
> [ 4625.009334] FS:  0000000000000000(0000) GS:ffff888343c80000(0000)
> knlGS:0000000000000000
> [ 4625.016118] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 4625.020555] CR2: 0000000099837000 CR3: 0000000144e4c000 CR4: 000000000=
00026f0
> [ 4625.026381] Call Trace:
> [ 4625.027525]  <TASK>
> [ 4625.028323]  ? __warn+0x90/0x120
> [ 4625.030255]  ? report_bug+0xe2/0x160
> [ 4625.032532]  ? check_flush_dependency+0xbe/0xd0
> [ 4625.035768]  ? handle_bug+0x53/0x80
> [ 4625.037959]  ? exc_invalid_op+0x13/0x60
> [ 4625.040499]  ? asm_exc_invalid_op+0x16/0x20
> [ 4625.043384]  ? __pfx_amdgpu_device_delay_enable_gfx_off+0x10/0x10 [amd=
gpu]
> [ 4625.049366]  ? check_flush_dependency+0xbe/0xd0
> [ 4625.052598]  ? check_flush_dependency+0xbe/0xd0
> [ 4625.055830]  __flush_work+0xb2/0x1f0
> [ 4625.058109]  ? work_grab_pending+0x3f/0x120
> [ 4625.060996]  ? set_work_pool_and_clear_pending+0x14/0x20
> [ 4625.065008]  ? __cancel_work+0x89/0xc0
> [ 4625.067460]  __cancel_work_sync+0x4a/0x70
> [ 4625.070173]  amdgpu_gfx_off_ctrl+0xa6/0x100 [amdgpu]
> [ 4625.074231]  amdgpu_ring_alloc+0x52/0x60 [amdgpu]
> [ 4625.077974]  amdgpu_ib_schedule+0x155/0x640 [amdgpu]
> [ 4625.081988]  amdgpu_job_run+0xda/0x140 [amdgpu]
> [ 4625.085663]  drm_sched_run_job_work+0x246/0x310 [gpu_sched]
> [ 4625.089935]  process_scheduled_works+0x19c/0x2c0
> [ 4625.093252]  worker_thread+0x13b/0x1c0
> [ 4625.095706]  ? __pfx_worker_thread+0x10/0x10
> [ 4625.098678]  kthread+0xef/0x100
> [ 4625.100523]  ? __pfx_kthread+0x10/0x10
> [ 4625.102976]  ret_from_fork+0x24/0x40
> [ 4625.105256]  ? __pfx_kthread+0x10/0x10
> [ 4625.107709]  ret_from_fork_asm+0x1a/0x30
> [ 4625.110338]  </TASK>
> [ 4625.111228] ---[ end trace 0000000000000000 ]---
