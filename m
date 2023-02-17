Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD47C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Feb 2023 15:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9270210E0AA;
	Fri, 17 Feb 2023 15:30:11 +0000 (UTC)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DC010E0AA
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 15:30:09 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 bg14-20020a056820080e00b005200828499dso262510oob.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 07:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/Bx3XTzPNo3r3YvTtBrE4QNiOG4BlfUWmR6EHFywQk=;
 b=e5u+tb3t/POXeEAJK6NWG9dS9NV/utSMFy6aE3FI+OqCeypfNqEm0yFJ1vIcu+xm+Z
 owUFzVJWNE6b4QrtyBJY8QmGUTKgK9yKYraBh+cCnTZyGZpmECLqusLubJG9m7CYdCB2
 NFrRx3BKJfbgJfMQfQBxzzY7l41txaymNNdTwjTG+jUbiCSK1Ed+vvU/+zErZOxUC0BV
 v1W4J8jbB86lMLThWHseYQAltCbggZW30y2HSLA0e6qgYx+fC82puR4Dyp1h4rXcTuoV
 pHbOxhObV3OSmYvX+uKwABFmerzrvBH/SMPGnMDAHOH2KPQ8igIZUnubP6qYS2juKU8s
 2jTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F/Bx3XTzPNo3r3YvTtBrE4QNiOG4BlfUWmR6EHFywQk=;
 b=1wX3N/YwSPBwqHACGRYLn8o5yqqiL++I0Eam4ciRv6n5YBEFN94pXL8uBGVz/V3ry3
 huiqtjzPoIarI8mnwWnqp5mSMvYr9JBBlHe3PzjwptrVg/JoxN/A3n6vL5a9FRbLaBAC
 oEd/6EsMzHuCX9sn3zZ2TrGsXuZEZhWkET0GAbi0D22kkO+UWXN6WrRe+IFhE9Z2forj
 SO7zQOJUA5r7aqWx58pKTIHfs2yvPF5hJbxubsoHDRqwdHRfNaiQel8BaQnMXbdBebNL
 t8e8Q8mRu3px+N4Vyfb1VUDsva4J5Kduea2usNMQo97dCkYMaX4ABVU8w0TZrLzyblGi
 ntuA==
X-Gm-Message-State: AO0yUKUhpFJq/MYhgzJKuvUD5aqr2rs4+487UR36Pl+4S1A+cSlGHQ34
 /88qOgPuQa9bTl9QXz8tZ/JS1N2jg6GNz0MMGPUaB8fb
X-Google-Smtp-Source: AK7set9UweAP4WFYvOVakSj574Ty9Q2jJIoA2N1BmM6Z3/qUnorf9ZtO6Z9Ocib3VtqE/tIGZE3rl5jPsa6mD/3ILiw=
X-Received: by 2002:a4a:acc5:0:b0:51a:bd4d:5116 with SMTP id
 c5-20020a4aacc5000000b0051abd4d5116mr189164oon.0.1676647808650; Fri, 17 Feb
 2023 07:30:08 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsM7jMMomy_=oNN236LfLJzMJbcNR=YWWJ74TgNO_16PWQ@mail.gmail.com>
 <CADnq5_PUCRGZoUu3RHrbD6+Dr_RHWdqkJKDBD2cWenWhQQiyKw@mail.gmail.com>
 <CABXGCsO-GLzahLgNtbzsM-HiPk7cZvHu56ckSMLD7XeUvf28hw@mail.gmail.com>
 <CADnq5_NMuc=moNDgL1bx9riUtkfuPvj4sLM-i3Qmf-rtAHV+=Q@mail.gmail.com>
 <c79dcbb5-5c8c-2620-1b92-15b643fb5530@amd.com>
 <CABXGCsMkAoWJaX4k+7e3G9wxfd0=5eDnD6y8hWJ5XCq=5gEZiQ@mail.gmail.com>
In-Reply-To: <CABXGCsMkAoWJaX4k+7e3G9wxfd0=5eDnD6y8hWJ5XCq=5gEZiQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Feb 2023 10:29:57 -0500
Message-ID: <CADnq5_NcE7MEa1cYF5C2jvH86Wj3g4CUYuHJWo+8ZHKOLbJKgw@mail.gmail.com>
Subject: Re: [bug][vaapi][h264] The commit
 7cbe08a930a132d84b4cf79953b00b074ec7a2a7
 on certain video files leads to problems with VAAPI hardware decoding.
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
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
Cc: "Chen, Guchun" <guchun.chen@amd.com>, Thong Thai <thong.thai@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, James.Zhu@amd.com,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 17, 2023 at 1:10 AM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Fri, Dec 9, 2022 at 7:37 PM Leo Liu <leo.liu@amd.com> wrote:
> >
> > Please try the latest AMDGPU driver:
> >
> > https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-ne=
xt/
> >
>
> Sorry Leo, I miss your message.
> This issue is still actual for 6.2-rc8.
>
> In my first message I was mistaken.
>
> > Before kernel 5.16 this only led to an artifact in the form of
> > a green bar at the top of the screen, then starting from 5.17
> > the GPU began to freeze.
>
> The real behaviour before 5.18:
> - vlc could plays video with small artifacts in the form of a green
> bar on top of the video
> - after playing video process vlc correctly exiting
>
> On 5.18 this behaviour changed:
> - vlc show black screen instead of playing video
> - after playing the process not exiting
> - if I tries kill vlc process with 'kill -9' vlc became zombi process
> and many other processes start hangs (in kernel log appears follow
> lines after 2 minutes)
>
> INFO: task vlc:sh8:5248 blocked for more than 122 seconds.
>       Tainted: G        W    L   --------  ---  5.18.0-60.fc37.x86_64+deb=
ug #1
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:vlc:sh8         state:D stack:13616 pid: 5248 ppid:  1934 flags:0x00=
004006
> Call Trace:
>  <TASK>
>  __schedule+0x492/0x1650
>  ? _raw_spin_unlock_irqrestore+0x40/0x60
>  ? debug_check_no_obj_freed+0x12d/0x250
>  schedule+0x4e/0xb0
>  schedule_timeout+0xe1/0x120
>  ? lock_release+0x215/0x460
>  ? trace_hardirqs_on+0x1a/0xf0
>  ? _raw_spin_unlock_irqrestore+0x40/0x60
>  dma_fence_default_wait+0x197/0x240
>  ? __bpf_trace_dma_fence+0x10/0x10
>  dma_fence_wait_timeout+0x229/0x260
>  drm_sched_entity_fini+0x101/0x270 [gpu_sched]
>  amdgpu_vm_fini+0x2b5/0x460 [amdgpu]
>  ? idr_destroy+0x70/0xb0
>  ? mutex_destroy+0x1e/0x50
>  amdgpu_driver_postclose_kms+0x1ec/0x2c0 [amdgpu]
>  drm_file_free.part.0+0x20d/0x260
>  drm_release+0x6a/0x120
>  __fput+0xab/0x270
>  task_work_run+0x5c/0xa0
>  do_exit+0x394/0xc40
>  ? rcu_read_lock_sched_held+0x10/0x70
>  do_group_exit+0x33/0xb0
>  get_signal+0xbbc/0xbc0
>  arch_do_signal_or_restart+0x30/0x770
>  ? do_futex+0xfd/0x190
>  ? __x64_sys_futex+0x63/0x190
>  exit_to_user_mode_prepare+0x172/0x270
>  syscall_exit_to_user_mode+0x16/0x50
>  do_syscall_64+0x67/0x80
>  ? do_syscall_64+0x67/0x80
>  ? rcu_read_lock_sched_held+0x10/0x70
>  ? trace_hardirqs_on_prepare+0x5e/0x110
>  ? do_syscall_64+0x67/0x80
>  ? rcu_read_lock_sched_held+0x10/0x70
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f82c2364529
> RSP: 002b:00007f8210ff8c00 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 00007f82c2364529
> RDX: 0000000000000000 RSI: 0000000000000189 RDI: 00007f823022542c
> RBP: 00007f8210ff8c30 R08: 0000000000000000 R09: 00000000ffffffff
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000001 R15: 00007f823022542c
>  </TASK>
> INFO: lockdep is turned off.
>
> I bisected this issue and problematic commit is
>
> =E2=9D=AF git bisect bad
> 5f3854f1f4e211f494018160b348a1c16e58013f is the first bad commit
> commit 5f3854f1f4e211f494018160b348a1c16e58013f
> Author: Alex Deucher <alexander.deucher@amd.com>
> Date:   Thu Mar 24 18:04:00 2022 -0400
>
>     drm/amdgpu: add more cases to noretry=3D1
>
>     Port current list from amd-staging-drm-next.
>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> Unfortunately I couldn't simply revert this commit on 6.2-rc8 for
> checking, because it leads to conflicts.
>
> Alex, you as author of this commit could help me with it?

append amdgpu.noretry=3D0 to the kernel command line in grub.

Alex

>
>
> --
> Best Regards,
> Mike Gavrilov.
