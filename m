Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81763C77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 09:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D78310E108;
	Wed, 12 Apr 2023 09:35:54 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C90C10E108
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 09:35:52 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id j1so14216347wrb.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 02:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681292150; x=1683884150;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eMfzatlo4zrVAAA/ragyBpCaxBoQgu4J/wop/R19/Sc=;
 b=mONufBF7qCZtpwdwNQkMIbIXFQuaPCEDCyq5KgKeoxG+mXe6PRRfcsSK/QjKrSPuFP
 EkOO3X6IaPyu3Zr0mh4PJi9Z2GDbWQ/87TZbWzFjgtLraXaNJQ7Z4NPiq3s4vDYkJHxq
 gRgNN5NQvdOUsKDCoWWNM/j2gxxzUaPfwSlhF6uhFyHOSJl7cJmRNIbars1RUAZJ951J
 0fQ8BGUOC2m5Re6ZNlDNPPpKt+/vdLvZ985kxGsUu2rzBpi7oYbQcbBzjjO96pL/Qwk4
 x82FdkknGukmAyowe9Myomo87aoD6o+e4XqOI6gdyo+aMBFz8balEJWOYn5zPFJHxQcm
 OkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681292150; x=1683884150;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eMfzatlo4zrVAAA/ragyBpCaxBoQgu4J/wop/R19/Sc=;
 b=FNIYI9k4tyX5UGXkVmHarABAi3/cLFmzAYRobRiZd0PHPkozqge8xQ+krwjytsUYMT
 vFnRL0TCMBDtZexfAbJxurF0tAzGyXflVZOrPnEbTqc65DcTa/LF6j6MTmrpfJRuTqjm
 Vv/T8BFqkEgh4MKaZ6unFD1RtK6O2+iHl7S7z4rJ59dwWbtlBctqnPLk7lfUVr8h9zRz
 RbiPH3LWO4WiQ0qUqOKNx54FaI+0/STdc218Ksk7S7LBhBSCSJEjcdaLa/XSSAen8sHv
 Y5sZWNMTRhEatKlih+hdYoWWAUNWW6RHSN4uKfPuNcGKo/RQWK6SyTiS99/M2AzvXdJr
 y3CQ==
X-Gm-Message-State: AAQBX9d7wMiTOmwH8ly0xUMyvH42y/OsLC3qTM1BIWFgnp9Y6X0RjdCH
 7s+eWoZttTQUff4ktJzjEnk=
X-Google-Smtp-Source: AKy350ZAanpCuis7w66my/CWazR4R3ffdjI7oPgMcZadNAd3AJCIt/R8d//tDcwu0x6hDFvVQchVXA==
X-Received: by 2002:adf:ea11:0:b0:2f0:2dd5:ee7 with SMTP id
 q17-20020adfea11000000b002f02dd50ee7mr1307477wrm.36.1681292150179; 
 Wed, 12 Apr 2023 02:35:50 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fe02:9bb5:5deb:be0e?
 ([2a02:908:1256:79a0:fe02:9bb5:5deb:be0e])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b002e5f6f8fc4fsm16682217wrs.100.2023.04.12.02.35.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Apr 2023 02:35:49 -0700 (PDT)
Message-ID: <10a3f103-49f0-e231-846d-76e8f3b83ed9@gmail.com>
Date: Wed, 12 Apr 2023 11:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] drm/sched: Check scheduler ready before calling timeout
 handling
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>, Alex Deucher <alexdeucher@gmail.com>
References: <20230406200054.633379-1-luben.tuikov@amd.com>
 <CADnq5_PdpyvkzQftKcRW7KCTn6tfhWP8u+DyN9F_BG8XfOmEeQ@mail.gmail.com>
 <b959acc1-b504-8489-4e6b-1beb1d08e995@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <b959acc1-b504-8489-4e6b-1beb1d08e995@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.04.23 um 02:00 schrieb Luben Tuikov:
> On 2023-04-11 17:39, Alex Deucher wrote:
>> On Thu, Apr 6, 2023 at 4:01 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>>
>>> During an IGT GPU reset test we see the following oops,
>>>
>>> [  +0.000003] ------------[ cut here ]------------
>>> [  +0.000000] WARNING: CPU: 9 PID: 0 at kernel/workqueue.c:1656 __queue_delayed_work+0x6d/0xa0
>>> [  +0.000004] Modules linked in: iptable_filter bpfilter amdgpu(OE) nls_iso8859_1 snd_hda_codec_realtek snd_hda_codec_generic intel_rapl_msr ledtrig_audio snd_hda_codec_hdmi intel_rapl_common snd_hda_intel edac_mce_amd snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hda_core iommu_v2 gpu_sched(OE) kvm_amd drm_buddy snd_hwdep kvm video drm_ttm_helper snd_pcm ttm snd_seq_midi drm_display_helper snd_seq_midi_event snd_rawmidi cec crct10dif_pclmul ghash_clmulni_intel sha512_ssse3 snd_seq aesni_intel rc_core crypto_simd cryptd binfmt_misc drm_kms_helper rapl snd_seq_device input_leds joydev snd_timer i2c_algo_bit syscopyarea snd ccp sysfillrect sysimgblt wmi_bmof k10temp soundcore mac_hid sch_fq_codel msr parport_pc ppdev drm lp parport ramoops reed_solomon pstore_blk pstore_zone efi_pstore ip_tables x_tables autofs4 hid_generic usbhid hid r8169 ahci xhci_pci gpio_amdpt realtek i2c_piix4 wmi crc32_pclmul xhci_pci_renesas libahci gpio_generic
>>> [  +0.000070] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W OE      6.1.11+ #2
>>> [  +0.000003] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming 3/AB350-Gaming 3-CF, BIOS F7 06/16/2017
>>> [  +0.000001] RIP: 0010:__queue_delayed_work+0x6d/0xa0
>>> [  +0.000003] Code: 7a 50 48 01 c1 48 89 4a 30 81 ff 00 20 00 00 75 38 4c 89 cf e8 64 3e 0a 00 5d e9 1e c5 11 01 e8 99 f7 ff ff 5d e9 13 c5 11 01 <0f> 0b eb c1 0f 0b 48 81 7a 38 70 5c 0e 81 74 9f 0f 0b 48 8b 42 28
>>> [  +0.000002] RSP: 0018:ffffc90000398d60 EFLAGS: 00010007
>>> [  +0.000002] RAX: ffff88810d589c60 RBX: 0000000000000000 RCX: 0000000000000000
>>> [  +0.000002] RDX: ffff88810d589c58 RSI: 0000000000000000 RDI: 0000000000002000
>>> [  +0.000001] RBP: ffffc90000398d60 R08: 0000000000000000 R09: ffff88810d589c78
>>> [  +0.000002] R10: 72705f305f39765f R11: 7866673a6d72645b R12: ffff88810d589c58
>>> [  +0.000001] R13: 0000000000002000 R14: 0000000000000000 R15: 0000000000000000
>>> [  +0.000002] FS:  0000000000000000(0000) GS:ffff8887fee40000(0000) knlGS:0000000000000000
>>> [  +0.000001] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  +0.000002] CR2: 00005562c4797fa0 CR3: 0000000110da0000 CR4: 00000000003506e0
>>> [  +0.000002] Call Trace:
>>> [  +0.000001]  <IRQ>
>>> [  +0.000001]  mod_delayed_work_on+0x5e/0xa0
>>> [  +0.000004]  drm_sched_fault+0x23/0x30 [gpu_sched]
>>> [  +0.000007]  gfx_v9_0_fault.isra.0+0xa6/0xd0 [amdgpu]
>>> [  +0.000258]  gfx_v9_0_priv_reg_irq+0x29/0x40 [amdgpu]
>>> [  +0.000254]  amdgpu_irq_dispatch+0x1ac/0x2b0 [amdgpu]
>>> [  +0.000243]  amdgpu_ih_process+0x89/0x130 [amdgpu]
>>> [  +0.000245]  amdgpu_irq_handler+0x24/0x60 [amdgpu]
>>> [  +0.000165]  __handle_irq_event_percpu+0x4f/0x1a0
>>> [  +0.000003]  handle_irq_event_percpu+0x15/0x50
>>> [  +0.000001]  handle_irq_event+0x39/0x60
>>> [  +0.000002]  handle_edge_irq+0xa8/0x250
>>> [  +0.000003]  __common_interrupt+0x7b/0x150
>>> [  +0.000002]  common_interrupt+0xc1/0xe0
>>> [  +0.000003]  </IRQ>
>>> [  +0.000000]  <TASK>
>>> [  +0.000001]  asm_common_interrupt+0x27/0x40
>>> [  +0.000002] RIP: 0010:native_safe_halt+0xb/0x10
>>> [  +0.000003] Code: 46 ff ff ff cc cc cc cc cc cc cc cc cc cc cc eb 07 0f 00 2d 69 f2 5e 00 f4 e9 f1 3b 3e 00 90 eb 07 0f 00 2d 59 f2 5e 00 fb f4 <e9> e0 3b 3e 00 0f 1f 44 00 00 55 48 89 e5 53 e8 b1 d4 fe ff 66 90
>>> [  +0.000002] RSP: 0018:ffffc9000018fdc8 EFLAGS: 00000246
>>> [  +0.000002] RAX: 0000000000004000 RBX: 000000000002e5a8 RCX: 000000000000001f
>>> [  +0.000001] RDX: 0000000000000001 RSI: ffff888101298800 RDI: ffff888101298864
>>> [  +0.000001] RBP: ffffc9000018fdd0 R08: 000000527f64bd8b R09: 000000000001dc90
>>> [  +0.000001] R10: 000000000001dc90 R11: 0000000000000003 R12: 0000000000000001
>>> [  +0.000001] R13: ffff888101298864 R14: ffffffff832d9e20 R15: ffff888193aa8c00
>>> [  +0.000003]  ? acpi_idle_do_entry+0x5e/0x70
>>> [  +0.000002]  acpi_idle_enter+0xd1/0x160
>>> [  +0.000003]  cpuidle_enter_state+0x9a/0x6e0
>>> [  +0.000003]  cpuidle_enter+0x2e/0x50
>>> [  +0.000003]  call_cpuidle+0x23/0x50
>>> [  +0.000002]  do_idle+0x1de/0x260
>>> [  +0.000002]  cpu_startup_entry+0x20/0x30
>>> [  +0.000002]  start_secondary+0x120/0x150
>>> [  +0.000003]  secondary_startup_64_no_verify+0xe5/0xeb
>>> [  +0.000004]  </TASK>
>>> [  +0.000000] ---[ end trace 0000000000000000 ]---
>>> [  +0.000003] BUG: kernel NULL pointer dereference, address: 0000000000000102
>>> [  +0.006233] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx_low timeout, signaled seq=3, emitted seq=4
>>> [  +0.000734] #PF: supervisor read access in kernel mode
>>> [  +0.009670] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process amd_deadlock pid 2002 thread amd_deadlock pid 2002
>>> [  +0.005135] #PF: error_code(0x0000) - not-present page
>>> [  +0.000002] PGD 0 P4D 0
>>> [  +0.000002] Oops: 0000 [#1] PREEMPT SMP NOPTI
>>> [  +0.000002] CPU: 9 PID: 0 Comm: swapper/9 Tainted: G        W OE      6.1.11+ #2
>>> [  +0.000002] Hardware name: Gigabyte Technology Co., Ltd. AB350-Gaming 3/AB350-Gaming 3-CF, BIOS F7 06/16/2017
>>> [  +0.012101] amdgpu 0000:0c:00.0: amdgpu: GPU reset begin!
>>> [  +0.005136] RIP: 0010:__queue_work+0x1f/0x4e0
>>> [  +0.000004] Code: 87 cd 11 01 0f 1f 80 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41 57 41 56 41 55 49 89 d5 41 54 49 89 f4 53 48 83 ec 10 89 7d d4 <f6> 86 02 01 00 00 01 0f 85 6c 03 00 00 e8 7f 36 08 00 8b 45 d4 48
>>>
>>> For gfx_rings the schedulers may not be initialized by
>>> amdgpu_device_init_schedulers() due to ring->no_scheduler flag being set to
>>> true and thus the timeout_wq is NULL. As a result, since all ASICs call
>>> drm_sched_fault() unconditionally even for schedulers which have not been
>>> initialized, it is simpler to use the ready condition which indicates whether
>>> the given scheduler worker thread runs and whether the timeout_wq of the reset
>>> domain has been initialized.
>>>
>>> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> Please make sure this lands in drm-misc.  Generally all scheduler
>> patches should go through drm-misc unless there is a particular driver
>> dependency.
> drm-misc-next, drm-misc-fixes or both?

I think drm-misc-fixes should be appropriate.

Christian.
