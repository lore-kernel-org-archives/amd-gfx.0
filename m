Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6594BC3DA7A
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 10:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF57A10E00B;
	Thu,  5 Jan 2023 10:03:20 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5789A10E00B
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 10:03:18 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id fc4so88823114ejc.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Jan 2023 02:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wAqqmtkDHigIBKawtjsAqAbgb6ELKYBTJn8qur95U04=;
 b=W2TNq24r6qn4HAY8wlaZ1vSykO+IyQZXnKtoY6dyYE2m23hb23+zFFgQ+Ax9XUji+R
 oWvbFDQOIxyaTK5EiXZuZEGd8g0pF3NxbsoKw/P5fg13sSyfOFijtADu6uALqoxUjHw1
 Fhfsv3501UwU+cT/Y2PoDv6rw1UYe45WPT9HcYdSqxFv4GDMXQEyhztmMtrWqa6fWyuE
 1wvZ0HKRVnMfdOX5panC4kGcOZPSS//qRSC9czMDDzeh7gKVX1oPXQ6ta8uOVFawa6/P
 IeqpdKHSOyvnB+3X7gTx8cISztav70WJdvNFBWUO8zwW25ko/Gj8SqgiE6NbM779RhZ2
 CUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wAqqmtkDHigIBKawtjsAqAbgb6ELKYBTJn8qur95U04=;
 b=dLBXj9OJ8bks+GCQ1mxF2pngzxupMMkY9k0kcLkrk+QVCxtpwQr4g9Lguid4skvDOD
 yeiSTOUYAN1OwxU53VNcyLv8XhfumwXSW+oM6zQEINjMssRFmiCowpWMu9nAtzkvoewk
 BtjCitkYBPCNyS0GeX6t7Glzekt/6nJVDOEXI2aYK/lFdSg/j6MYX0Ut5Gt2l/qIwC0J
 +H6j1mYvGY6f4ZrFwHV92BE3Ful/NtxLGibZRRaYy6MMN2Oe72DstjWHOnFC2x8yK3Gc
 GF/fwdlPAcz8J5Qnh0zuDG0NiZWdmR2lQK8/KKm9Apr5V3VTqmLAL4KiGpwY+dnK7WJ+
 GIfQ==
X-Gm-Message-State: AFqh2ko1QrjGaxGn9GkZ6aPs0+LtPldSUIAmQ+oN71QJsEKbe5G9B7sj
 vnuFlLvPmDy+C+FMzpaLurY=
X-Google-Smtp-Source: AMrXdXsWPxu0OlXgxGawu/qVTjmwQ/qSdJyr76jqVo5UItfcvKr/GOyU6PUeJwJwQzsGiLSR6/dWFg==
X-Received: by 2002:a17:907:d50f:b0:7c0:cf7e:b515 with SMTP id
 wb15-20020a170907d50f00b007c0cf7eb515mr45012006ejc.6.1672912996811; 
 Thu, 05 Jan 2023 02:03:16 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 gs2-20020a170906f18200b007c491f53497sm16656237ejb.170.2023.01.05.02.03.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jan 2023 02:03:16 -0800 (PST)
Message-ID: <e6b6a599-8fdd-a4fc-a2bb-d0750e6d477d@gmail.com>
Date: Thu, 5 Jan 2023 11:03:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: grab extra fence reference for
 drm_sched_job_add_dependency
Content-Language: en-US
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
References: <20221219104718.21677-1-christian.koenig@amd.com>
 <Y6BuZ2jv8n9dEVxS@zn.tnic>
 <CADnq5_M+TgiYw84meQNRJKnKYmr9V4v-scWZRAeFtG1o=aEeCw@mail.gmail.com>
 <7275efdb-4d22-eb76-cea3-333391472853@gmail.com>
 <CADnq5_NxbAgF6sXF6HuGzgcOoY8QOHU-0d9ghuKarx0jpt3Vog@mail.gmail.com>
 <CABXGCsOmtfo=7YWUv0QmGGrCat1Md59oz7UWw9-7MPn7f6AAdA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CABXGCsOmtfo=7YWUv0QmGGrCat1Md59oz7UWw9-7MPn7f6AAdA@mail.gmail.com>
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
Cc: michel@daenzer.net, Borislav Petkov <bp@alien8.de>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.01.23 um 02:44 schrieb Mikhail Gavrilov:
> On Tue, Jan 3, 2023 at 7:26 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>> On Tue, Jan 3, 2023 at 3:34 AM Christian König
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>> I assume that this was already upstreamed while I was on sick leave?
>> Yes.
>>
>> Alex
>>
> What about commit 2fdb8a8f07c2f1353770a324fd19b8114e4329ac ?

That one should be fixed by:

commit 9f1ecfc5dcb47a7ca37be47b0eaca0f37f1ae93d
Author: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Date:   Wed Nov 23 03:13:03 2022 +0300

     drm/scheduler: Fix lockup in drm_sched_entity_kill()

     The drm_sched_entity_kill() is invoked twice by 
drm_sched_entity_destroy()
     while userspace process is exiting or being killed. First time it's 
invoked
     when sched entity is flushed and second time when entity is 
released. This
     causes a lockup within wait_for_completion(entity_idle) due to how 
completion
     API works.

     Calling wait_for_completion() more times than complete() was 
invoked is a
     error condition that causes lockup because completion internally uses
     counter for complete/wait calls. The complete_all() must be used 
instead
     in such cases.

     This patch fixes lockup of Panfrost driver that is reproducible by 
killing
     any application in a middle of 3d drawing operation.

     Fixes: 2fdb8a8f07c2 ("drm/scheduler: rework entity flush, kill and 
fini")
     Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
     Reviewed-by: Christian König <christian.koenig@amd.com>
     Link: 
https://patchwork.freedesktop.org/patch/msgid/20221123001303.533968-1-dmitry.osipenko@collabora.com

Regards,
Christian.

> I checked twice and I'm sure that this commit is the reason why I
> can't terminate some games (and others processes).
> Demonstration: https://youtu.be/O0AfjiMdFGw
> I also attached a full kernel log.
>
> INFO: task ZAT.exe:4745 blocked for more than 122 seconds.
>        Tainted: G        W    L
> 6.1.0-rc1-13-2fdb8a8f07c2f1353770a324fd19b8114e4329ac+ #18
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:ZAT.exe         state:D stack:12608 pid:4745  ppid:1      flags:0x20004006
> Call Trace:
>   <TASK>
>   __schedule+0x4c5/0x1740
>   schedule+0x5d/0xe0
>   schedule_timeout+0xf0/0x130
>   __wait_for_common+0xa9/0x1f0
>   ? usleep_range_state+0x90/0x90
>   drm_sched_entity_kill.part.0+0x4d/0x210 [gpu_sched]
>   drm_sched_entity_flush+0xa0/0x260 [gpu_sched]
>   amdgpu_ctx_mgr_entity_flush+0x83/0xd0 [amdgpu]
>   amdgpu_flush+0x25/0x40 [amdgpu]
>   filp_close+0x31/0x70
>   put_files_struct+0x78/0xf0
>   do_exit+0x364/0xc30
>   ? sched_clock_cpu+0xb/0xc0
>   do_group_exit+0x33/0xa0
>   get_signal+0xb41/0xb50
>   arch_do_signal_or_restart+0x44/0x7a0
>   exit_to_user_mode_prepare+0x17b/0x250
>   syscall_exit_to_user_mode+0x16/0x50
>   __do_fast_syscall_32+0x94/0xf0
> 2132]: Reached target exit.target - Exit the Session.
> 1]: user@1000.service: Killing process 4402 (reaper) with signal SIGKILL.
> 1]: user@1000.service: Killing process 4745 (ZAT.exe) with signal SIGKILL.
> 1]: Started plymouth-reboot.service - Show Plymouth Reboot Screen.
> : SERVICE_START pid=1 uid=0 auid=4294967295 ses=4294967295
> subj=system_u:system_r:init_t:s0 msg='unit=plymouth-reboot
> comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
> terminal=? res=succe>
> 1]: plymouth-switch-root-initramfs.service - Tell Plymouth To Jump To
> initramfs was skipped because of an unmet condition check
> (ConditionPathExists=/run/initramfs/bin/sh).
> INFO: task ZAT.exe:4745 blocked for more than 122 seconds.
>        Tainted: G        W    L
> 6.1.0-rc1-13-2fdb8a8f07c2f1353770a324fd19b8114e4329ac+ #18
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:ZAT.exe         state:D stack:12608 pid:4745  ppid:1      flags:0x20004006
> Call Trace:
>   <TASK>
>   __schedule+0x4c5/0x1740
>   schedule+0x5d/0xe0
>   schedule_timeout+0xf0/0x130
>   __wait_for_common+0xa9/0x1f0
>   ? usleep_range_state+0x90/0x90
>   drm_sched_entity_kill.part.0+0x4d/0x210 [gpu_sched]
>   drm_sched_entity_flush+0xa0/0x260 [gpu_sched]
>   amdgpu_ctx_mgr_entity_flush+0x83/0xd0 [amdgpu]
>   amdgpu_flush+0x25/0x40 [amdgpu]
>   filp_close+0x31/0x70
>   put_files_struct+0x78/0xf0
>   do_exit+0x364/0xc30
>   ? sched_clock_cpu+0xb/0xc0
>   do_group_exit+0x33/0xa0
>   get_signal+0xb41/0xb50
>   arch_do_signal_or_restart+0x44/0x7a0
>   exit_to_user_mode_prepare+0x17b/0x250
>   syscall_exit_to_user_mode+0x16/0x50
>   __do_fast_syscall_32+0x94/0xf0
>   ? __do_fast_syscall_32+0x94/0xf0
>   ? lockdep_hardirqs_on+0x7d/0x100
>   ? __do_fast_syscall_32+0x94/0xf0
>   ? __do_fast_syscall_32+0x94/0xf0
>   do_fast_syscall_32+0x2f/0x70
>   entry_SYSCALL_compat_after_hwframe+0x62/0x6a
> RIP: 0023:0xf7f6b579
> RSP: 002b:00000000e8dffd40 EFLAGS: 00200282 ORIG_RAX: 00000000000000f0
> RAX: fffffffffffffe00 RBX: 00000000f0b54dcc RCX: 0000000000000189
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 00000000ffffffff R08: 00000000e8dffd40 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000200282 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>   </TASK>
>
> Showing all locks held in the system:
> 1 lock held by rcu_tasks_kthre/11:
>   #0: ffffffffae368a20 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at:
> rcu_tasks_one_gp+0x2b/0x3e0
> 1 lock held by rcu_tasks_rude_/12:
>   #0: ffffffffae368760 (rcu_tasks_rude.tasks_gp_mutex){+.+.}-{3:3}, at:
> rcu_tasks_one_gp+0x2b/0x3e0
> 1 lock held by rcu_tasks_trace/13:
>   #0: ffffffffae368460 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3},
> at: rcu_tasks_one_gp+0x2b/0x3e0
> 1 lock held by khungtaskd/182:
>   #0: ffffffffae369520 (rcu_read_lock){....}-{1:2}, at:
> debug_show_all_locks+0x15/0x16b
> 2 locks held by kworker/25:1/215:
> 1 lock held by systemd-journal/852:
> 1 lock held by ZAT.exe/4745:
>   #0: ffff9b087c337cf8 (&mgr->lock#3){+.+.}-{3:3}, at:
> amdgpu_ctx_mgr_entity_flush+0x3a/0xd0 [amdgpu]
>
> =============================================
> 1]: user@1000.service: Processes still around after final SIGKILL.
> Entering failed mode.
> 1]: user@1000.service: Failed with result 'timeout'.
> 1]: Stopped user@1000.service - User Manager for UID 1000.
>
>

