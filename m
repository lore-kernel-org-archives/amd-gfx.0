Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052E2C636D4
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Feb 2023 06:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63CE310E1BE;
	Fri, 17 Feb 2023 06:10:13 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4237210E1BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 06:10:11 +0000 (UTC)
Received: by mail-qk1-x72d.google.com with SMTP id ow4so1439008qkn.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Feb 2023 22:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=huxdVieBvI7MK+4z06xTsp8u+jyTNbPbVgefB7Kff2c=;
 b=ZHjnXX0HrpxYU5lgw9XbEa58YIxuRpNShVLK47kCdyUBKRKkv7U6NcbfFmiJLXHRgG
 77rowhn9KQR6761+UKbwmYlEjIKzNxS0L/FsoZApNcDNJg+KkG9ZvgQE50FohEfJtXKy
 KwiQYgNR4LqAk1YcJGabX3kh+Ic3f+7npkddpx1wxp5vsneHddti1Le9VLSnP62CV5f1
 LbXGypJvAfL2EuLjKVv/fHaHbbdmH33Ov0aq4B4vf7wnXvlH7tYzuNm6iikWUB8xkctH
 m+DY3QobUuIeUiZyhmrJEClhsQOm53XBfUc4j+FZXhievtc9goZbl1WEcugg4Scn1jN6
 jb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=huxdVieBvI7MK+4z06xTsp8u+jyTNbPbVgefB7Kff2c=;
 b=KfLu3E9eHqGdZldxI3Shhhmmbq1s1gIVqJoOtH53nygmNbozi3xqy2HQpK3rIDDZO8
 eHKQz4k8HDt7WNynyUooZ/gZ+XRlypOKM/w+GL8B8zhkM/h4uRhQ52MYc02gyQ6hSYJl
 YbTIhb2HYuM6PaOr7Ku8m+9dERUyEM/fzpKnzy6kgx3VHcV0oq+S279TBUrIVxhsdVL0
 vDk6+DBHXQnr4zKQ+z7lzLs1YD0xAV4OQwySRjshW5/jh4/I1zxLwSH9teDz4bAFzPLs
 D2GZJas5TYK4O4wRtrYZmC74rswDbflD1bM6zDL8DZzUCCPp5pyUKzaIwAhOB2hZiM8F
 /JcQ==
X-Gm-Message-State: AO0yUKXgg8Otw0s8BOJvqYlHirIUwEj89LrxtY7sxLPz2gzXu10F21S7
 IV1XV9+8F+e1ZwZBuE3iMDFjC9UiRcjvOQVgdPs=
X-Google-Smtp-Source: AK7set+R9kUU/m/LS3ba+1qqg1chDoMWn+HsmCJ6urMbTsTnpArl8FBFqdQ3usMvi7f2ZdXQK2b+4zDfZsMItSNd2Ds=
X-Received: by 2002:a05:620a:1b85:b0:71f:b89c:4f34 with SMTP id
 dv5-20020a05620a1b8500b0071fb89c4f34mr640842qkb.14.1676614210076; Thu, 16 Feb
 2023 22:10:10 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsM7jMMomy_=oNN236LfLJzMJbcNR=YWWJ74TgNO_16PWQ@mail.gmail.com>
 <CADnq5_PUCRGZoUu3RHrbD6+Dr_RHWdqkJKDBD2cWenWhQQiyKw@mail.gmail.com>
 <CABXGCsO-GLzahLgNtbzsM-HiPk7cZvHu56ckSMLD7XeUvf28hw@mail.gmail.com>
 <CADnq5_NMuc=moNDgL1bx9riUtkfuPvj4sLM-i3Qmf-rtAHV+=Q@mail.gmail.com>
 <c79dcbb5-5c8c-2620-1b92-15b643fb5530@amd.com>
In-Reply-To: <c79dcbb5-5c8c-2620-1b92-15b643fb5530@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 17 Feb 2023 11:09:59 +0500
Message-ID: <CABXGCsMkAoWJaX4k+7e3G9wxfd0=5eDnD6y8hWJ5XCq=5gEZiQ@mail.gmail.com>
Subject: Re: [bug][vaapi][h264] The commit
 7cbe08a930a132d84b4cf79953b00b074ec7a2a7
 on certain video files leads to problems with VAAPI hardware decoding.
To: Leo Liu <leo.liu@amd.com>
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
 Alexander" <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 James.Zhu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 9, 2022 at 7:37 PM Leo Liu <leo.liu@amd.com> wrote:
>
> Please try the latest AMDGPU driver:
>
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next=
/
>

Sorry Leo, I miss your message.
This issue is still actual for 6.2-rc8.

In my first message I was mistaken.

> Before kernel 5.16 this only led to an artifact in the form of
> a green bar at the top of the screen, then starting from 5.17
> the GPU began to freeze.

The real behaviour before 5.18:
- vlc could plays video with small artifacts in the form of a green
bar on top of the video
- after playing video process vlc correctly exiting

On 5.18 this behaviour changed:
- vlc show black screen instead of playing video
- after playing the process not exiting
- if I tries kill vlc process with 'kill -9' vlc became zombi process
and many other processes start hangs (in kernel log appears follow
lines after 2 minutes)

INFO: task vlc:sh8:5248 blocked for more than 122 seconds.
      Tainted: G        W    L   --------  ---  5.18.0-60.fc37.x86_64+debug=
 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:vlc:sh8         state:D stack:13616 pid: 5248 ppid:  1934 flags:0x0000=
4006
Call Trace:
 <TASK>
 __schedule+0x492/0x1650
 ? _raw_spin_unlock_irqrestore+0x40/0x60
 ? debug_check_no_obj_freed+0x12d/0x250
 schedule+0x4e/0xb0
 schedule_timeout+0xe1/0x120
 ? lock_release+0x215/0x460
 ? trace_hardirqs_on+0x1a/0xf0
 ? _raw_spin_unlock_irqrestore+0x40/0x60
 dma_fence_default_wait+0x197/0x240
 ? __bpf_trace_dma_fence+0x10/0x10
 dma_fence_wait_timeout+0x229/0x260
 drm_sched_entity_fini+0x101/0x270 [gpu_sched]
 amdgpu_vm_fini+0x2b5/0x460 [amdgpu]
 ? idr_destroy+0x70/0xb0
 ? mutex_destroy+0x1e/0x50
 amdgpu_driver_postclose_kms+0x1ec/0x2c0 [amdgpu]
 drm_file_free.part.0+0x20d/0x260
 drm_release+0x6a/0x120
 __fput+0xab/0x270
 task_work_run+0x5c/0xa0
 do_exit+0x394/0xc40
 ? rcu_read_lock_sched_held+0x10/0x70
 do_group_exit+0x33/0xb0
 get_signal+0xbbc/0xbc0
 arch_do_signal_or_restart+0x30/0x770
 ? do_futex+0xfd/0x190
 ? __x64_sys_futex+0x63/0x190
 exit_to_user_mode_prepare+0x172/0x270
 syscall_exit_to_user_mode+0x16/0x50
 do_syscall_64+0x67/0x80
 ? do_syscall_64+0x67/0x80
 ? rcu_read_lock_sched_held+0x10/0x70
 ? trace_hardirqs_on_prepare+0x5e/0x110
 ? do_syscall_64+0x67/0x80
 ? rcu_read_lock_sched_held+0x10/0x70
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f82c2364529
RSP: 002b:00007f8210ff8c00 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 0000000000000000 RCX: 00007f82c2364529
RDX: 0000000000000000 RSI: 0000000000000189 RDI: 00007f823022542c
RBP: 00007f8210ff8c30 R08: 0000000000000000 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 00007f823022542c
 </TASK>
INFO: lockdep is turned off.

I bisected this issue and problematic commit is

=E2=9D=AF git bisect bad
5f3854f1f4e211f494018160b348a1c16e58013f is the first bad commit
commit 5f3854f1f4e211f494018160b348a1c16e58013f
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Thu Mar 24 18:04:00 2022 -0400

    drm/amdgpu: add more cases to noretry=3D1

    Port current list from amd-staging-drm-next.

    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
 1 file changed, 3 insertions(+)

Unfortunately I couldn't simply revert this commit on 6.2-rc8 for
checking, because it leads to conflicts.

Alex, you as author of this commit could help me with it?


--=20
Best Regards,
Mike Gavrilov.
