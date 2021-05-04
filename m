Return-Path: <SRS0=AKuh=J7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36947C433B4
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2E2B6117A
	for <amd-gfx@archiver.kernel.org>; Tue,  4 May 2021 14:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E2B6117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gatech.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 840026EB10;
	Tue,  4 May 2021 14:12:52 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C2486E20B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 May 2021 11:58:27 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id i67so5038853qkc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 May 2021 04:58:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:cc:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=ZMIfmo5NPdmEQp2pfRJs7vBPDb3/0VRxfUIKYmBMuTY=;
 b=q68OAx5jjyQ0odWWolHyCxDtWyS6gTgkrUQHlGgJR93A/9gw05hKMrNdTmD6Bpq+Jg
 92iWU9qAc+W/U6XfEGu9J3PsEYVNXJuS2MHo6TG3U6YNIwN2ICA5htvj84XTKkmqSbsX
 M6lshq+YB0KgvE20CajGW1WNqCQZndRp3/Sjo8gKiQd4aenIL+bdAN0GfLwW55yljPrb
 3ZQe+dqBeCtDLp8LulX8brgx3T1w1zhsn0AjBRiPAZYGf/kTPztbwrE2yDikUTU7Bdfq
 n43FX0G7E4iWbP4fluDr8TLmsbqpcwmzZv+RfWYSYSM8a+5GO9vOFGp9AX9kQQdMoBvw
 a3JA==
X-Gm-Message-State: AOAM530CEbcg5xmkNzNglqyCd1xEjb0yd9K2CimxjFruu4GLeXwm/QxQ
 cxxIuVd6k0Oi342UXcOXItw=
X-Google-Smtp-Source: ABdhPJyBBjuSL5+LO0i3GZFMsd9K47NNBnnjZYMJMAOMtP2AkvEtJrIW8hljQc662tjC3IcI+iadrQ==
X-Received: by 2002:a37:8bc2:: with SMTP id
 n185mr24556571qkd.320.1620129506651; 
 Tue, 04 May 2021 04:58:26 -0700 (PDT)
Received: from ?IPv6:2601:184:417f:5b5f::557e:48ed?
 ([2601:184:417f:5b5f::557e:48ed])
 by smtp.gmail.com with ESMTPSA id f125sm10865893qkj.38.2021.05.04.04.58.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 May 2021 04:58:26 -0700 (PDT)
Subject: Lockdep bug during hdcp_create_workqueue() (Was: BUG: key
 ffff8b521bda9148 has not been registered!)
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
References: <CABXGCsPZvfsUBiMr5fdQYRf26bMchN=UL8oXojgoVbWtwJhXjQ@mail.gmail.com>
From: David Ward <david.ward@gatech.edu>
Message-ID: <44b4dbe2-a808-9788-7a4f-dfd628a93256@gatech.edu>
Date: Tue, 4 May 2021 07:58:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CABXGCsPZvfsUBiMr5fdQYRf26bMchN=UL8oXojgoVbWtwJhXjQ@mail.gmail.com>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 04 May 2021 14:12:51 +0000
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
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Content-Type: multipart/mixed; boundary="===============1256770179=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1256770179==
Content-Type: multipart/alternative;
 boundary="------------A62E5A0F1856B9B23F63640F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A62E5A0F1856B9B23F63640F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 1/9/21 7:42 AM, Mikhail Gavrilov wrote:
> Hi folks!
> I started to see this message every boot after replacing Radeon VII to =
6900XT.
>
> <...>
>
> [    6.333672] [drm] REG_WAIT timeout 1us * 100000 tries -
> mpc2_assert_idle_mpcc line:480
> [    6.335258] BUG: key ffff8b521bda9148 has not been registered!
> [    6.335271] ------------[ cut here ]------------
> [    6.335273] DEBUG_LOCKS_WARN_ON(1)
> [    6.335279] WARNING: CPU: 18 PID: 525 at
> kernel/locking/lockdep.c:4618 lockdep_init_map_waits+0x18b/0x210
> [    6.335284] Modules linked in: fjes(-) amdgpu(+) iommu_v2 gpu_sched
> ttm drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel cec drm
> ghash_clmulni_intel ccp igb nvme nvme_core dca i2c_algo_bit wmi
> pinctrl_amd fuse
> [    6.335298] CPU: 18 PID: 525 Comm: systemd-udevd Not tainted
> 5.10.0-0.rc6.20201204git34816d20f173.92.fc34.x86_64 #1
> [    6.335302] Hardware name: System manufacturer System Product
> Name/ROG STRIX X570-I GAMING, BIOS 2802 10/21/2020
> [    6.335306] RIP: 0010:lockdep_init_map_waits+0x18b/0x210
> [    6.335309] Code: 00 85 c0 0f 84 75 ff ff ff 8b 3d 18 c4 f1 01 85
> ff 0f 85 67 ff ff ff 48 c7 c6 68 43 60 97 48 c7 c7 1d 90 5a 97 e8 70
> 1f b6 00 <0f> 0b e9 4d ff ff ff e8 19 59 bc 00 85 c0 74 21 44 8b 1d e6
> c3 f1
> [    6.335315] RSP: 0018:ffff9e5a013d3910 EFLAGS: 00010282
> [    6.335317] RAX: 0000000000000016 RBX: ffffffff97247d80 RCX: ffff8b5=
908fdb238
> [    6.335320] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8b5=
908fdb230
> [    6.335322] RBP: ffff8b520e2a7978 R08: 0000000000000000 R09: 0000000=
000000000
> [    6.335325] R10: ffff9e5a013d3740 R11: ffff8b592e2fffe8 R12: ffff8b5=
21bda9148
> [    6.335327] R13: 0000000000000000 R14: ffff8b521bc30330 R15: ffff8b5=
21bc30330
> [    6.335330] FS:  00007fe019eb9140(0000) GS:ffff8b5908e00000(0000)
> knlGS:0000000000000000
> [    6.335333] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    6.335336] CR2: 00007fe018f5e000 CR3: 00000001142ee000 CR4: 0000000=
000350ee0
> [    6.335338] Call Trace:
> [    6.335342]  __kernfs_create_file+0x7b/0x100
> [    6.335344]  sysfs_add_file_mode_ns+0xa3/0x190
> [    6.335347]  sysfs_create_bin_file+0x50/0x70
> [    6.335428]  hdcp_create_workqueue+0x3bd/0x410 [amdgpu]
> [    6.335499]  amdgpu_dm_init.isra.0.cold+0x136/0x126d [amdgpu]
> [    6.335570]  ? psp_set_srm+0xb0/0xb0 [amdgpu]
> [    6.335637]  ? hdcp_update_display+0x1f0/0x1f0 [amdgpu]
> [    6.335641]  ? dev_printk_emit+0x3e/0x40
> [    6.335709]  dm_hw_init+0xe/0x20 [amdgpu]
> [    6.335776]  amdgpu_device_init.cold+0x18c3/0x1bbc [amdgpu]
> [    6.335781]  ? pci_bus_read_config_word+0x39/0x50
> [    6.335831]  amdgpu_driver_load_kms+0x2b/0x1f0 [amdgpu]
> [    6.335879]  amdgpu_pci_probe+0x129/0x1b0 [amdgpu]
> [    6.335889]  local_pci_probe+0x42/0x80
> [    6.335891]  pci_device_probe+0xd9/0x1a0
> [    6.335896]  really_probe+0x205/0x460
> [    6.335898]  driver_probe_device+0xe1/0x150
> [    6.335901]  device_driver_attach+0xa8/0xb0
> [    6.335904]  __driver_attach+0x8c/0x150
> [    6.335907]  ? device_driver_attach+0xb0/0xb0
> [    6.335909]  ? device_driver_attach+0xb0/0xb0
> [    6.335911]  bus_for_each_dev+0x67/0x90
> [    6.335914]  bus_add_driver+0x12e/0x1f0
> [    6.335917]  driver_register+0x8b/0xe0
> [    6.335919]  ? 0xffffffffc0e4c000
> [    6.335922]  do_one_initcall+0x67/0x320
> [    6.335925]  ? rcu_read_lock_sched_held+0x3f/0x80
> [    6.335928]  ? trace_kmalloc+0xb2/0xe0
> [    6.335930]  ? kmem_cache_alloc_trace+0x157/0x270
> [    6.335934]  do_init_module+0x5c/0x260
> [    6.335936]  __do_sys_init_module+0x13d/0x1a0
> [    6.335940]  do_syscall_64+0x33/0x40
> [    6.335943]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    6.335945] RIP: 0033:0x7fe01aab2efe
> [    6.335948] Code: 48 8b 0d 7d 1f 0c 00 f7 d8 64 89 01 48 83 c8 ff
> c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4a 1f 0c 00 f7 d8 64 89
> 01 48
> [    6.335953] RSP: 002b:00007ffdf4879928 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000af
> [    6.335957] RAX: ffffffffffffffda RBX: 00005636774ad820 RCX: 00007fe=
01aab2efe
> [    6.335959] RDX: 00005636774856e0 RSI: 0000000000b4f95e RDI: 00007fe=
01840f010
> [    6.335962] RBP: 00007fe01840f010 R08: 000056367748bd30 R09: 0000000=
000b4f970
> [    6.335964] R10: 00005633142fc82b R11: 0000000000000246 R12: 0000563=
6774856e0
> [    6.335967] R13: 00005636774d22d0 R14: 0000000000000000 R15: 0000563=
6774a1d80
> [    6.335971] irq event stamp: 343839
> [    6.335973] hardirqs last  enabled at (343839):
> [<ffffffff96162861>] console_unlock+0x511/0x640
> [    6.335977] hardirqs last disabled at (343838):
> [<ffffffff961627c8>] console_unlock+0x478/0x640
> [    6.335981] softirqs last  enabled at (343730):
> [<ffffffff96e01112>] asm_call_irq_on_stack+0x12/0x20
> [    6.335984] softirqs last disabled at (343657):
> [<ffffffff96e01112>] asm_call_irq_on_stack+0x12/0x20
> [    6.335987] ---[ end trace a4445e953bea9224 ]---

Another user I am helping is seeing this bug, with a very similar stack=20
trace, in v5.12 (vanilla build) on different hardware.


> $ /usr/src/kernels/`uname -r`/scripts/faddr2line
> /lib/debug/lib/modules/`uname -r`/vmlinux lockdep_init_map_waits+0x18b
> lockdep_init_map_waits+0x18b/0x210:
> lockdep_init_map_waits at kernel/locking/lockdep.c:4618 (discriminator =
7)
>
> $ git blame -L 4613,4623 kernel/locking/lockdep.c

I assume the issue is not actually in the lockdep code itself, but more=20
likely in the amdgpu / amd display code that ultimately calls it.

Using scripts/decode_stacktrace.sh, the stack trace for v5.12 reads like =

this:

[ 12.817369] Call Trace:
[ 12.819991] __kernfs_create_file (fs/kernfs/file.c:998)
[ 12.824581] sysfs_add_file_mode_ns (fs/sysfs/file.c:324)
[ 12.829334] ? init_timer_key (kernel/time/timer.c:816)
[ 12.833527] sysfs_create_bin_file (fs/sysfs/file.c:558)
[ 12.838115] hdcp_create_workqueue=20
(drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_hdcp.c:648)=20
amdgpu
[ 12.843964] amdgpu_dm_init.isra.0.cold=20
(drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1481) amdgpu
[ 12.850303] ? lock_acquire (kernel/locking/lockdep.c:437=20
kernel/locking/lockdep.c:5513 kernel/locking/lockdep.c:5476)
[ 12.854303] ? lock_is_held_type (kernel/locking/lockdep.c:5254=20
kernel/locking/lockdep.c:5550)
[ 12.858779] ? smum_send_msg_to_smc_with_parameter=20
(drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smumgr.c:169) amdgpu
[ 12.865954] ? find_held_lock (kernel/locking/lockdep.c:5004)
[ 12.870065] ? smum_send_msg_to_smc_with_parameter=20
(drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smumgr.c:169) amdgpu
[ 12.877258] ? psp_set_srm=20
(drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_hdcp.c:396)=20
amdgpu
[ 12.882124] ? hdcp_update_display=20
(drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_hdcp.c:431)=20
amdgpu
[ 12.887914] ? arch_jump_label_transform (arch/x86/kernel/jump_label.c:99=
)
[ 12.892945] ? sched_clock_cpu (kernel/sched/clock.c:371)
[ 12.897051] dm_hw_init=20
(drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1712) amdgpu=

[ 12.901526] amdgpu_device_init.cold=20
(drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:295) amdgpu
[ 12.907703] ? _raw_spin_unlock_irqrestore=20
(./arch/x86/include/asm/paravirt.h:658=20
=2E/arch/x86/include/asm/irqflags.h:145=20
=2E/include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:191)
[ 12.913015] amdgpu_driver_load_kms=20
(drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:157 (discriminator 6)) amdgpu
[ 12.918773] amdgpu_pci_probe=20
(drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1221) amdgpu

Line numbers above correspond to the v5.12 tag in Linus's tree (this is=20
a vanilla kernel).


> Who can help fix this?
>
> Full kernel logs is here: https://pastebin.com/d2Nq01SX

I created an issue for this bug before I found this e-mail:
https://gitlab.freedesktop.org/drm/amd/-/issues/1586

The full kernel logs for v5.12 are posted there.


Thank you,

David


--------------A62E5A0F1856B9B23F63640F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 1/9/21 7:42 AM, Mikhail Gavrilov
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:%3CCABXGCsPZvfsUBiMr5fdQYRf26bMchN=UL8oXojgoVbWtwJhXjQ@mail.gmail.com%3E">
      <pre class="moz-quote-pre" wrap="">Hi folks!
I started to see this message every boot after replacing Radeon VII to 6900XT.

&lt;...&gt;

[    6.333672] [drm] REG_WAIT timeout 1us * 100000 tries -
mpc2_assert_idle_mpcc line:480
[    6.335258] BUG: key ffff8b521bda9148 has not been registered!
[    6.335271] ------------[ cut here ]------------
[    6.335273] DEBUG_LOCKS_WARN_ON(1)
[    6.335279] WARNING: CPU: 18 PID: 525 at
kernel/locking/lockdep.c:4618 lockdep_init_map_waits+0x18b/0x210
[    6.335284] Modules linked in: fjes(-) amdgpu(+) iommu_v2 gpu_sched
ttm drm_kms_helper crct10dif_pclmul crc32_pclmul crc32c_intel cec drm
ghash_clmulni_intel ccp igb nvme nvme_core dca i2c_algo_bit wmi
pinctrl_amd fuse
[    6.335298] CPU: 18 PID: 525 Comm: systemd-udevd Not tainted
5.10.0-0.rc6.20201204git34816d20f173.92.fc34.x86_64 #1
[    6.335302] Hardware name: System manufacturer System Product
Name/ROG STRIX X570-I GAMING, BIOS 2802 10/21/2020
[    6.335306] RIP: 0010:lockdep_init_map_waits+0x18b/0x210
[    6.335309] Code: 00 85 c0 0f 84 75 ff ff ff 8b 3d 18 c4 f1 01 85
ff 0f 85 67 ff ff ff 48 c7 c6 68 43 60 97 48 c7 c7 1d 90 5a 97 e8 70
1f b6 00 &lt;0f&gt; 0b e9 4d ff ff ff e8 19 59 bc 00 85 c0 74 21 44 8b 1d e6
c3 f1
[    6.335315] RSP: 0018:ffff9e5a013d3910 EFLAGS: 00010282
[    6.335317] RAX: 0000000000000016 RBX: ffffffff97247d80 RCX: ffff8b5908fdb238
[    6.335320] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8b5908fdb230
[    6.335322] RBP: ffff8b520e2a7978 R08: 0000000000000000 R09: 0000000000000000
[    6.335325] R10: ffff9e5a013d3740 R11: ffff8b592e2fffe8 R12: ffff8b521bda9148
[    6.335327] R13: 0000000000000000 R14: ffff8b521bc30330 R15: ffff8b521bc30330
[    6.335330] FS:  00007fe019eb9140(0000) GS:ffff8b5908e00000(0000)
knlGS:0000000000000000
[    6.335333] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.335336] CR2: 00007fe018f5e000 CR3: 00000001142ee000 CR4: 0000000000350ee0
[    6.335338] Call Trace:
[    6.335342]  __kernfs_create_file+0x7b/0x100
[    6.335344]  sysfs_add_file_mode_ns+0xa3/0x190
[    6.335347]  sysfs_create_bin_file+0x50/0x70
[    6.335428]  hdcp_create_workqueue+0x3bd/0x410 [amdgpu]
[    6.335499]  amdgpu_dm_init.isra.0.cold+0x136/0x126d [amdgpu]
[    6.335570]  ? psp_set_srm+0xb0/0xb0 [amdgpu]
[    6.335637]  ? hdcp_update_display+0x1f0/0x1f0 [amdgpu]
[    6.335641]  ? dev_printk_emit+0x3e/0x40
[    6.335709]  dm_hw_init+0xe/0x20 [amdgpu]
[    6.335776]  amdgpu_device_init.cold+0x18c3/0x1bbc [amdgpu]
[    6.335781]  ? pci_bus_read_config_word+0x39/0x50
[    6.335831]  amdgpu_driver_load_kms+0x2b/0x1f0 [amdgpu]
[    6.335879]  amdgpu_pci_probe+0x129/0x1b0 [amdgpu]
[    6.335889]  local_pci_probe+0x42/0x80
[    6.335891]  pci_device_probe+0xd9/0x1a0
[    6.335896]  really_probe+0x205/0x460
[    6.335898]  driver_probe_device+0xe1/0x150
[    6.335901]  device_driver_attach+0xa8/0xb0
[    6.335904]  __driver_attach+0x8c/0x150
[    6.335907]  ? device_driver_attach+0xb0/0xb0
[    6.335909]  ? device_driver_attach+0xb0/0xb0
[    6.335911]  bus_for_each_dev+0x67/0x90
[    6.335914]  bus_add_driver+0x12e/0x1f0
[    6.335917]  driver_register+0x8b/0xe0
[    6.335919]  ? 0xffffffffc0e4c000
[    6.335922]  do_one_initcall+0x67/0x320
[    6.335925]  ? rcu_read_lock_sched_held+0x3f/0x80
[    6.335928]  ? trace_kmalloc+0xb2/0xe0
[    6.335930]  ? kmem_cache_alloc_trace+0x157/0x270
[    6.335934]  do_init_module+0x5c/0x260
[    6.335936]  __do_sys_init_module+0x13d/0x1a0
[    6.335940]  do_syscall_64+0x33/0x40
[    6.335943]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    6.335945] RIP: 0033:0x7fe01aab2efe
[    6.335948] Code: 48 8b 0d 7d 1f 0c 00 f7 d8 64 89 01 48 83 c8 ff
c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00
00 0f 05 &lt;48&gt; 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4a 1f 0c 00 f7 d8 64 89
01 48
[    6.335953] RSP: 002b:00007ffdf4879928 EFLAGS: 00000246 ORIG_RAX:
00000000000000af
[    6.335957] RAX: ffffffffffffffda RBX: 00005636774ad820 RCX: 00007fe01aab2efe
[    6.335959] RDX: 00005636774856e0 RSI: 0000000000b4f95e RDI: 00007fe01840f010
[    6.335962] RBP: 00007fe01840f010 R08: 000056367748bd30 R09: 0000000000b4f970
[    6.335964] R10: 00005633142fc82b R11: 0000000000000246 R12: 00005636774856e0
[    6.335967] R13: 00005636774d22d0 R14: 0000000000000000 R15: 00005636774a1d80
[    6.335971] irq event stamp: 343839
[    6.335973] hardirqs last  enabled at (343839):
[&lt;ffffffff96162861&gt;] console_unlock+0x511/0x640
[    6.335977] hardirqs last disabled at (343838):
[&lt;ffffffff961627c8&gt;] console_unlock+0x478/0x640
[    6.335981] softirqs last  enabled at (343730):
[&lt;ffffffff96e01112&gt;] asm_call_irq_on_stack+0x12/0x20
[    6.335984] softirqs last disabled at (343657):
[&lt;ffffffff96e01112&gt;] asm_call_irq_on_stack+0x12/0x20
[    6.335987] ---[ end trace a4445e953bea9224 ]---</pre>
    </blockquote>
    <p>Another user I am helping is seeing this bug, with a very similar
      stack trace, in v5.12 (vanilla build) on different hardware.</p>
    <p><br>
    </p>
    <p>
    </p>
    <blockquote type="cite"
cite="mid:%3CCABXGCsPZvfsUBiMr5fdQYRf26bMchN=UL8oXojgoVbWtwJhXjQ@mail.gmail.com%3E">
      <pre class="moz-quote-pre" wrap="">$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname -r`/vmlinux lockdep_init_map_waits+0x18b
lockdep_init_map_waits+0x18b/0x210:
lockdep_init_map_waits at kernel/locking/lockdep.c:4618 (discriminator 7)

$ git blame -L 4613,4623 kernel/locking/lockdep.c
</pre>
    </blockquote>
    <p>I assume the issue is not actually in the lockdep code itself,
      but more likely in the amdgpu / amd display code that ultimately
      calls it.<br>
    </p>
    <p>Using scripts/decode_stacktrace.sh, the stack trace for v5.12
      reads like this:<br>
    </p>
    <pre class="code highlight" lang="plaintext"><span id="LC9" class="line" lang="plaintext">[   12.817369] Call Trace:</span>
<span id="LC10" class="line" lang="plaintext">[   12.819991]  __kernfs_create_file (fs/kernfs/file.c:998) </span>
<span id="LC11" class="line" lang="plaintext">[   12.824581]  sysfs_add_file_mode_ns (fs/sysfs/file.c:324) </span>
<span id="LC12" class="line" lang="plaintext">[   12.829334]  ? init_timer_key (kernel/time/timer.c:816) </span>
<span id="LC13" class="line" lang="plaintext">[   12.833527]  sysfs_create_bin_file (fs/sysfs/file.c:558) </span>
<span id="LC14" class="line" lang="plaintext">[   12.838115]  hdcp_create_workqueue (drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_hdcp.c:648) amdgpu</span>
<span id="LC15" class="line" lang="plaintext">[   12.843964]  amdgpu_dm_init.isra.0.cold (drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:1481) amdgpu</span>
<span id="LC16" class="line" lang="plaintext">[   12.850303]  ? lock_acquire (kernel/locking/lockdep.c:437 kernel/locking/lockdep.c:5513 kernel/locking/lockdep.c:5476) </span>
<span id="LC17" class="line" lang="plaintext">[   12.854303]  ? lock_is_held_type (kernel/locking/lockdep.c:5254 kernel/locking/lockdep.c:5550) </span>
<span id="LC18" class="line" lang="plaintext">[   12.858779]  ? smum_send_msg_to_smc_with_parameter (drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smumgr.c:169) amdgpu</span>
<span id="LC19" class="line" lang="plaintext">[   12.865954]  ? find_held_lock (kernel/locking/lockdep.c:5004) </span>
<span id="LC20" class="line" lang="plaintext">[   12.870065]  ? smum_send_msg_to_smc_with_parameter (drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/smumgr.c:169) amdgpu</span>
<span id="LC21" class="line" lang="plaintext">[   12.877258]  ? psp_set_srm (drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_hdcp.c:396) amdgpu</span>
<span id="LC22" class="line" lang="plaintext">[   12.882124]  ? hdcp_update_display (drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_hdcp.c:431) amdgpu</span>
<span id="LC23" class="line" lang="plaintext">[   12.887914]  ? arch_jump_label_transform (arch/x86/kernel/jump_label.c:99) </span>
<span id="LC24" class="line" lang="plaintext">[   12.892945]  ? sched_clock_cpu (kernel/sched/clock.c:371) </span>
<span id="LC25" class="line" lang="plaintext">[   12.897051]  dm_hw_init (drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:1712) amdgpu</span>
<span id="LC26" class="line" lang="plaintext">[   12.901526]  amdgpu_device_init.cold (drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:295) amdgpu</span>
<span id="LC27" class="line" lang="plaintext">[   12.907703]  ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/paravirt.h:658 ./arch/x86/include/asm/irqflags.h:145 ./include/linux/spinlock_api_smp.h:160 kernel/locking/spinlock.c:191) </span>
<span id="LC28" class="line" lang="plaintext">[   12.913015]  amdgpu_driver_load_kms (drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:157 (discriminator 6)) amdgpu</span>
<span id="LC29" class="line" lang="plaintext">[   12.918773]  amdgpu_pci_probe (drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1221) amdgpu</span>
</pre>
    <p>Line numbers above correspond to the v5.12 tag in Linus's tree
      (this is a vanilla kernel).<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
cite="mid:%3CCABXGCsPZvfsUBiMr5fdQYRf26bMchN=UL8oXojgoVbWtwJhXjQ@mail.gmail.com%3E">
      <pre class="moz-quote-pre" wrap="">Who can help fix this?

Full kernel logs is here: <a class="moz-txt-link-freetext" href="https://pastebin.com/d2Nq01SX">https://pastebin.com/d2Nq01SX</a>
</pre>
    </blockquote>
    <p>I created an issue for this bug before I found this e-mail:<br>
      <a class="moz-txt-link-freetext" href="https://gitlab.freedesktop.org/drm/amd/-/issues/1586">https://gitlab.freedesktop.org/drm/amd/-/issues/1586</a></p>
    <p>The full kernel logs for v5.12 are posted there.<br>
    </p>
    <p><br>
    </p>
    <p>Thank you,</p>
    <p>David<br>
    </p>
  </body>
</html>

--------------A62E5A0F1856B9B23F63640F--

--===============1256770179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1256770179==--
