Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4EBC43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 19:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16DDE113629;
	Thu,  2 Jun 2022 19:02:13 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9E3F113623
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 19:02:11 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id u4so2529548pgk.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jun 2022 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Qepe5DdWclhl2e4ZZhduPHMnj++5ANMg+Qb/KsbYb0M=;
 b=4NpeJNVxKFtIO9iTrrpDj8Ti1fRTmE+shbWcHdVrdaBz2HJXBIGA2MaCn7sGokZxkQ
 HstU2xRbOGd1mdx8/1aBmGhglCspsCIOhj1bEoR1HwGpez16jlRL308ixkS6kxRttRf7
 1L0iDJyxEZuKBAbxumVwIOa+6uIkc5hGRss7QQ7zkHwbdUJhKa1/2jjzcC7DS62bqpPx
 Wm8fqgdfcOKzJcfko0X+O3YfLLAH78652CBcPcoVhFEm2N0hUEHBttTRR25WIQYNHSpu
 I0fDEAPyyTvFLYqGanyT0hLjsF4kWC+eO/cR0Ap5bd4Trcniu6O0J9b0eyZv6lIgG78u
 pe3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Qepe5DdWclhl2e4ZZhduPHMnj++5ANMg+Qb/KsbYb0M=;
 b=bSBJHOkQk0ygGDdvDpIyr+3I0Z5BlXBvAc7PoerrOWzw8H8AsVUoubffXusLQyom0n
 mKpZ7g1E73rOIeuuY6Syc7Lmu9B+lynQFXmna5GZh6nYxFxTpxNioQks0w7Nx5LREIpE
 wNTu+LjYHaq1EHBLnymalSBy6jiOG+du5GyoOnWjy7jkhlO9fDaFrrX6EQk8fpS7MhpO
 AdLHTkGeX8VTe+OLI6Iy+ECLaGxHH2M77AdFBasOkRZdGC1vPanTcxXkM1X2eK9S++iU
 3z7abBZCp8dkiP60vvdfb3b5OvwCATEqfQg+84L28oia+ZZJDzBvxwRdUUcQMo+y49wA
 I7IQ==
X-Gm-Message-State: AOAM531mZpagA3mttf3Vp2US3NNsH7OuOdncx2QvJgzc5MemEiTkjdoO
 wJcyONdc81zZQvT2okBTIhYrPFOrMJloZ7J2rwG0tg==
X-Google-Smtp-Source: ABdhPJxHUFAMWRIvSOMq16HS2vXn6CiYUBd/3InKyCqVDDKCNuYLdNHDRwVgR9mLdDYJ/xgxvgOYjuomtHu7zsg/Ixw=
X-Received: by 2002:a63:d747:0:b0:3db:74a9:ff92 with SMTP id
 w7-20020a63d747000000b003db74a9ff92mr5453876pgi.293.1654196531346; Thu, 02
 Jun 2022 12:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220602154734.7854-1-christian.koenig@amd.com>
 <CADnq5_MopB5aUpzo_iWz5TXbxAxYXttm8L6L_SwFayUPEyZxhw@mail.gmail.com>
 <CAHbf0-FZJnD7PQNFhVkg64XqKvwbuhN115yVFDd8_XG54nD_Ow@mail.gmail.com>
 <bc546040-cbc5-0193-07d9-0dfe74592598@gmail.com>
In-Reply-To: <bc546040-cbc5-0193-07d9-0dfe74592598@gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 2 Jun 2022 20:02:00 +0100
Message-ID: <CAHbf0-HoL2v9GGcZP_aA56LD46cEXCDKjrdjZkmTTki+p__jow@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: fix bulk move handling during resource init
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The Null pointer against drm-next:

Jun 02 19:59:50 axion.fireburn.co.uk kernel: BUG: kernel NULL pointer
dereference, address: 00000000000000d8
Jun 02 19:59:50 axion.fireburn.co.uk kernel: #PF: supervisor read
access in kernel mode
Jun 02 19:59:50 axion.fireburn.co.uk kernel: #PF: error_code(0x0000) -
not-present page
Jun 02 19:59:50 axion.fireburn.co.uk kernel: PGD 118700067 P4D
118700067 PUD 11f116067 PMD 0
Jun 02 19:59:50 axion.fireburn.co.uk kernel: Oops: 0000 [#1] PREEMPT SMP NO=
PTI
Jun 02 19:59:50 axion.fireburn.co.uk kernel: CPU: 4 PID: 1029 Comm:
GravityMark.x64 Tainted: G        W         5.18.0-rc5-drm+ #1070
Jun 02 19:59:50 axion.fireburn.co.uk kernel: Hardware name: ASUSTeK
COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.318
03/29/2022
Jun 02 19:59:50 axion.fireburn.co.uk kernel: RIP:
0010:ttm_device_swapout+0x6a/0x3d0
Jun 02 19:59:50 axion.fireburn.co.uk kernel: Code: 85 ed 74 51 80 7d
01 00 74 4b 48 89 e6 48 89 ef e8 7b dd ff ff 48 85 c0 74 3b 48 89 c3
49 89 e6 48 8b 7b 30 4c 89 ee 44 89 e2 <4c> 8b bf d8 00 00 00 e8 fa a5
>
Jun 02 19:59:50 axion.fireburn.co.uk kernel: RSP:
0000:ffff8881605dfc70 EFLAGS: 00010282
Jun 02 19:59:50 axion.fireburn.co.uk kernel: RAX: ffff888104f85ac8
RBX: ffff888104f85ac8 RCX: 0000000000000000
Jun 02 19:59:50 axion.fireburn.co.uk kernel: RDX: 0000000000000cc0
RSI: ffff8881605dfd50 RDI: 0000000000000000
Jun 02 19:59:50 axion.fireburn.co.uk kernel: RBP: ffff888104f85140
R08: ffff888101566240 R09: ffff88814e57b880
Jun 02 19:59:50 axion.fireburn.co.uk kernel: R10: 0000000000000063
R11: ffffffff818238a0 R12: 0000000000000cc0
Jun 02 19:59:50 axion.fireburn.co.uk kernel: R13: ffff8881605dfd50
R14: ffff8881605dfc70 R15: 0000000000691000
Jun 02 19:59:50 axion.fireburn.co.uk kernel: FS:
00007f4623fb9740(0000) GS:ffff888fde500000(0000)
knlGS:0000000000000000
Jun 02 19:59:50 axion.fireburn.co.uk kernel: CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Jun 02 19:59:50 axion.fireburn.co.uk kernel: CR2: 00000000000000d8
CR3: 0000000102e3c000 CR4: 0000000000150ee0
Jun 02 19:59:50 axion.fireburn.co.uk kernel: Call Trace:
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  <TASK>
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  ? ttm_global_swapout+0xae/0xc=
0
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  ? ttm_tt_populate+0x7d/0x130
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  ?
ttm_bo_vm_fault_reserved+0x237/0x270
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  ? amdgpu_gem_fault+0x92/0xd0
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  ? do_fault+0x28e/0x4b0
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  ? handle_mm_fault+0x849/0xa80
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  ? amdgpu_drm_ioctl+0x68/0x80
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  ? do_user_addr_fault+0x275/0x=
450
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  ? asm_exc_page_fault+0x9/0x30
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  ? exc_page_fault+0x5f/0x150
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  ? asm_exc_page_fault+0x1f/0x3=
0
Jun 02 19:59:50 axion.fireburn.co.uk kernel:  </TASK>
Jun 02 19:59:50 axion.fireburn.co.uk kernel: Modules linked in:
Jun 02 19:59:50 axion.fireburn.co.uk kernel: CR2: 00000000000000d8
Jun 02 19:59:50 axion.fireburn.co.uk kernel: ---[ end trace
0000000000000000 ]---
Jun 02 19:59:50 axion.fireburn.co.uk kernel: RIP:
0010:ttm_device_swapout+0x6a/0x3d0
Jun 02 19:59:50 axion.fireburn.co.uk kernel: Code: 85 ed 74 51 80 7d
01 00 74 4b 48 89 e6 48 89 ef e8 7b dd ff ff 48 85 c0 74 3b 48 89 c3
49 89 e6 48 8b 7b 30 4c 89 ee 44 89 e2 <4c> 8b bf d8 00 00 00 e8 fa a5
>
Jun 02 19:59:50 axion.fireburn.co.uk kernel: RSP:
0000:ffff8881605dfc70 EFLAGS: 00010282
Jun 02 19:59:50 axion.fireburn.co.uk kernel: RAX: ffff888104f85ac8
RBX: ffff888104f85ac8 RCX: 0000000000000000
Jun 02 19:59:50 axion.fireburn.co.uk kernel: RDX: 0000000000000cc0
RSI: ffff8881605dfd50 RDI: 0000000000000000
Jun 02 19:59:50 axion.fireburn.co.uk kernel: RBP: ffff888104f85140
R08: ffff888101566240 R09: ffff88814e57b880
Jun 02 19:59:50 axion.fireburn.co.uk kernel: R10: 0000000000000063
R11: ffffffff818238a0 R12: 0000000000000cc0
Jun 02 19:59:50 axion.fireburn.co.uk kernel: R13: ffff8881605dfd50
R14: ffff8881605dfc70 R15: 0000000000691000
Jun 02 19:59:50 axion.fireburn.co.uk kernel: FS:
00007f4623fb9740(0000) GS:ffff888fde500000(0000)
knlGS:0000000000000000
Jun 02 19:59:50 axion.fireburn.co.uk kernel: CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Jun 02 19:59:50 axion.fireburn.co.uk kernel: CR2: 00000000000000d8
CR3: 0000000102e3c000 CR4: 0000000000150ee0
Jun 02 19:59:50 axion.fireburn.co.uk kernel: note:
GravityMark.x64[1029] exited with preempt_count 1

On Thu, 2 Jun 2022 at 19:55, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> That's because drm-misc-next is currently broken and needs a backmerge.
>
> Please try this patch on top of drm-next.
>
> Regards,
> Christian.
>
> Am 02.06.22 um 20:08 schrieb Mike Lothian:
> > Hi
> >
> > I'm still seeing Null pointers against Linus's tree and drm-misc with t=
his patch
> >
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: BUG: kernel NULL pointer
> > dereference, address: 0000000000000008
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: #PF: supervisor write
> > access in kernel mode
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: #PF: error_code(0x0002) -
> > not-present page
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: PGD 11ee04067 P4D
> > 11ee04067 PUD 15eccb067 PMD 0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: Oops: 0002 [#1] PREEMPT SM=
P NOPTI
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: CPU: 0 PID: 1021 Comm:
> > GravityMark.x64 Tainted: G        W         5.18.0-tip+ #3177
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: Hardware name: ASUSTeK
> > COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.318
> > 03/29/2022
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: RIP:
> > 0010:ttm_resource_init+0x108/0x210
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: Code: 48 8b 74 0a 08 48
> > 39 de 0f 84 82 00 00 00 48 8b 7b 38 4c 8b 4b 40 4c 8d 44 0a 08 48 8d
> > 56 38 4c 89 4f 08 49 89 39 48 8b 4e 38 <48> 89 41 08 48 89 4b 38 48 89
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: RSP:
> > 0018:ffff888112e73918 EFLAGS: 00010202
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: RAX: ffff888206b715d8
> > RBX: ffff888206b715a0 RCX: 0000000000000000
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: RDX: ffff888206b71cf8
> > RSI: ffff888206b71cc0 RDI: ffff888110605b00
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: RBP: ffff88816c848c08
> > R08: ffff88812235c790 R09: ffff8881306a4bd8
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: R10: 0000000000000000
> > R11: ffffffff81851320 R12: ffff888110605ad0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: R13: ffff888206b715a0
> > R14: ffff88816c848c58 R15: ffff888110605ad0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: FS:
> > 00007f4c257c1740(0000) GS:ffff888fde400000(0000)
> > knlGS:0000000000000000
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: CS:  0010 DS: 0000 ES:
> > 0000 CR0: 0000000080050033
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: CR2: 0000000000000008
> > CR3: 00000001183fc000 CR4: 0000000000350ef0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: Call Trace:
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  <TASK>
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_vram_mgr_new+0xb=
b/0x4b0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? ttm_bo_mem_space+0x89/0=
x1e0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? ttm_bo_validate+0x80/0x=
1a0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_cs_bo_validate+0=
xe9/0x2b0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> > amdgpu_syncobj_lookup_and_add_to_sync+0xa0/0xa0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> > amdgpu_vm_validate_pt_bos+0xce/0x1c0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_cs_parser_bos+0x=
522/0x6e0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_cs_ioctl+0x7fe/0=
xd00
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> > amdgpu_cs_report_moved_bytes+0x60/0x60
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? drm_ioctl_kernel+0xcb/0=
x130
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? drm_ioctl+0x2f5/0x400
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> > amdgpu_cs_report_moved_bytes+0x60/0x60
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_drm_ioctl+0x42/0=
x80
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? __x64_sys_ioctl+0x5e/0x=
a0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? do_syscall_64+0x6a/0x90
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> > exit_to_user_mode_prepare+0x19/0x90
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> > entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel:  </TASK>
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: Modules linked in:
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: CR2: 0000000000000008
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: ---[ end trace
> > 0000000000000000 ]---
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: RIP:
> > 0010:ttm_resource_init+0x108/0x210
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: Code: 48 8b 74 0a 08 48
> > 39 de 0f 84 82 00 00 00 48 8b 7b 38 4c 8b 4b 40 4c 8d 44 0a 08 48 8d
> > 56 38 4c 89 4f 08 49 89 39 48 8b 4e 38 <48> 89 41 08 48 89 4b 38 48 89
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: RSP:
> > 0018:ffff888112e73918 EFLAGS: 00010202
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: RAX: ffff888206b715d8
> > RBX: ffff888206b715a0 RCX: 0000000000000000
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: RDX: ffff888206b71cf8
> > RSI: ffff888206b71cc0 RDI: ffff888110605b00
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: RBP: ffff88816c848c08
> > R08: ffff88812235c790 R09: ffff8881306a4bd8
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: R10: 0000000000000000
> > R11: ffffffff81851320 R12: ffff888110605ad0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: R13: ffff888206b715a0
> > R14: ffff88816c848c58 R15: ffff888110605ad0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: FS:
> > 00007f4c257c1740(0000) GS:ffff888fde400000(0000)
> > knlGS:0000000000000000
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: CS:  0010 DS: 0000 ES:
> > 0000 CR0: 0000000080050033
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: CR2: 0000000000000008
> > CR3: 00000001183fc000 CR4: 0000000000350ef0
> > Jun 02 19:04:05 axion.fireburn.co.uk kernel: note:
> > GravityMark.x64[1021] exited with preempt_count 1
> >
> > On Thu, 2 Jun 2022 at 17:54, Alex Deucher <alexdeucher@gmail.com> wrote=
:
> >> On Thu, Jun 2, 2022 at 11:47 AM Christian K=C3=B6nig
> >> <ckoenig.leichtzumerken@gmail.com> wrote:
> >>> The resource must be on the LRU before ttm_lru_bulk_move_add() is cal=
led.
> >>>
> >>> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> This should at least fix the null pointer in these bugs:
> >>
> >> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1992
> >> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2034
> >>
> >> Alex
> >>
> >>> ---
> >>>   drivers/gpu/drm/ttm/ttm_resource.c | 8 +++++---
> >>>   1 file changed, 5 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm=
/ttm_resource.c
> >>> index 65889b3caf50..928b9140f3c5 100644
> >>> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> >>> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> >>> @@ -169,15 +169,17 @@ void ttm_resource_init(struct ttm_buffer_object=
 *bo,
> >>>          res->bus.is_iomem =3D false;
> >>>          res->bus.caching =3D ttm_cached;
> >>>          res->bo =3D bo;
> >>> -       INIT_LIST_HEAD(&res->lru);
> >>>
> >>>          man =3D ttm_manager_type(bo->bdev, place->mem_type);
> >>>          spin_lock(&bo->bdev->lru_lock);
> >>>          man->usage +=3D res->num_pages << PAGE_SHIFT;
> >>> -       if (bo->bulk_move)
> >>> +       if (bo->bulk_move) {
> >>> +               list_add_tail(&res->lru, &man->lru[bo->priority]);
> >>>                  ttm_lru_bulk_move_add(bo->bulk_move, res);
> >>> -       else
> >>> +       } else {
> >>> +               INIT_LIST_HEAD(&res->lru);
> >>>                  ttm_resource_move_to_lru_tail(res);
> >>> +       }
> >>>          spin_unlock(&bo->bdev->lru_lock);
> >>>   }
> >>>   EXPORT_SYMBOL(ttm_resource_init);
> >>> --
> >>> 2.25.1
> >>>
>
