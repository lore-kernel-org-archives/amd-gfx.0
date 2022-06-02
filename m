Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEA0C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 18:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1095113187;
	Thu,  2 Jun 2022 18:11:44 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FF2F113191
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 18:11:42 +0000 (UTC)
Received: by mail-pj1-x1032.google.com with SMTP id a10so5602783pju.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jun 2022 11:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/3VbB9fS6jbkx277f1aUya9qcWV9ymVmDWUy0P/kJ8k=;
 b=QVyNvi5KREDqbwQgFu9LYqgSkVeOpzK/CFZ4XRju1soqxdK0R8w9KyC6CC0hPyMH2i
 ksv1qRF914ZXhJGMC7JJx4SqwmsI/9KnSlIOdVCO86x91bdQGt6n5Ug3MYTGs3tUlzsH
 kUplw3UQ4xhv/+D3aAP5/umsbotb45HchtrZW/YvJ+20uy3AW/TQTyfpS0YDtGpewO0j
 HwO3UXuQXjBONopPNe/4cADHrq7J7Iu5VSGo9J6CbyY1VSeVfhrznkIOgOPSwL71MFnS
 32Ve0WLibDFf5VeY1P08eig9/eLTuKfirKtgj82NDJ+vN6fmXft9294pdhoh2rrofow1
 4rLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/3VbB9fS6jbkx277f1aUya9qcWV9ymVmDWUy0P/kJ8k=;
 b=5iVGSorpK8dPi0ZHxloRwMj+G61gGnWPFeuTe+wCpV4w4G5dt4Dx2bUxTvnbXNzbe7
 AAlRx45nugB99K+bIud5qbUaxSKhroqHYkN7SGyLSJwJkqTuW5/Lzk2mdiTxjD+vgqDd
 fa8oPigZvzF0r5U3QU3XlzBN5kGKHGZIApBylHFPMCfnVXE5rrX2WEznNM1Y92Vh7QUX
 Tz62ysh4bnb4Mr3v+nh5sN+0w2CTDdB+zpQPe55jAtKrE6siAubGVmn9ld30q1gU3vWj
 ULJFJNNaXbGWEEPk7J1yxUi/bht96XQJUjpn8cnC4Z988vgO0T0UI4eRIbvC+OvKUMYP
 nRwA==
X-Gm-Message-State: AOAM532sp04XZmkSigGAw3Unc7q5Dxry0RNu481O6kjB7x7gemsttdgl
 R4YymsHqUME+hFYBFu9yJww4KMR19Z5baNVtAmsPzA==
X-Google-Smtp-Source: ABdhPJy2+eHBjsd4LXnPCTGNgq8rRSslVV19c5xG7hiS4TH30VNM0XSZ+MfXXjENckXtmfFF/FgD+bX0+PDMp7HB2sg=
X-Received: by 2002:a17:902:e947:b0:163:91e5:d3c with SMTP id
 b7-20020a170902e94700b0016391e50d3cmr5983666pll.39.1654193501954; Thu, 02 Jun
 2022 11:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220602154734.7854-1-christian.koenig@amd.com>
 <CADnq5_MopB5aUpzo_iWz5TXbxAxYXttm8L6L_SwFayUPEyZxhw@mail.gmail.com>
 <CAHbf0-FZJnD7PQNFhVkg64XqKvwbuhN115yVFDd8_XG54nD_Ow@mail.gmail.com>
In-Reply-To: <CAHbf0-FZJnD7PQNFhVkg64XqKvwbuhN115yVFDd8_XG54nD_Ow@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Thu, 2 Jun 2022 19:11:31 +0100
Message-ID: <CAHbf0-HSEKcFUhpeiTm4sjEGzFjm14VwV7JhWFfbidjU2g5raA@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: fix bulk move handling during resource init
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Here's the output from drm-misc too:

Jun 02 19:05:32 axion.fireburn.co.uk kernel: BUG: kernel NULL pointer
dereference, address: 00000000000000d8
Jun 02 19:05:32 axion.fireburn.co.uk kernel: #PF: supervisor read
access in kernel mode
Jun 02 19:05:32 axion.fireburn.co.uk kernel: #PF: error_code(0x0000) -
not-present page
Jun 02 19:05:32 axion.fireburn.co.uk kernel: PGD 11dfbb067 P4D
11dfbb067 PUD 170cd7067 PMD 0
Jun 02 19:05:32 axion.fireburn.co.uk kernel: Oops: 0000 [#1] PREEMPT SMP NO=
PTI
Jun 02 19:05:32 axion.fireburn.co.uk kernel: CPU: 1 PID: 1040 Comm:
GravityMark.x64 Tainted: G        W         5.18.0-rc5-misc+ #10
Jun 02 19:05:32 axion.fireburn.co.uk kernel: Hardware name: ASUSTeK
COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.318
03/29/2022
Jun 02 19:05:32 axion.fireburn.co.uk kernel: RIP:
0010:ttm_device_swapout+0x6a/0x3d0
Jun 02 19:05:32 axion.fireburn.co.uk kernel: Code: 85 ed 74 51 80 7d
01 00 74 4b 48 89 e6 48 89 ef e8 7b dd ff ff 48 85 c0 74 3b 48 89 c3
49 89 e6 48 8b 7b 30 4c 89 ee 44 89 e2 <4c> 8b bf d8 00 00 00 e8 fa a5
>
Jun 02 19:05:32 axion.fireburn.co.uk kernel: RSP:
0000:ffff888125a17c70 EFLAGS: 00010286
Jun 02 19:05:32 axion.fireburn.co.uk kernel: RAX: ffff888104f45aa0
RBX: ffff888104f45aa0 RCX: 0000000000000000
Jun 02 19:05:32 axion.fireburn.co.uk kernel: RDX: 0000000000000cc0
RSI: ffff888125a17d50 RDI: 0000000000000000
Jun 02 19:05:32 axion.fireburn.co.uk kernel: RBP: ffff888104f45118
R08: ffff88812278da68 R09: ffff888102eaa680
Jun 02 19:05:32 axion.fireburn.co.uk kernel: R10: 0000000000000063
R11: ffffffff818212a0 R12: 0000000000000cc0
Jun 02 19:05:32 axion.fireburn.co.uk kernel: R13: ffff888125a17d50
R14: ffff888125a17c70 R15: 0000000000691000
Jun 02 19:05:32 axion.fireburn.co.uk kernel: FS:
00007fd9e0671740(0000) GS:ffff888fde440000(0000)
knlGS:0000000000000000
Jun 02 19:05:32 axion.fireburn.co.uk kernel: CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Jun 02 19:05:32 axion.fireburn.co.uk kernel: CR2: 00000000000000d8
CR3: 0000000125c5a000 CR4: 0000000000150ee0
Jun 02 19:05:32 axion.fireburn.co.uk kernel: Call Trace:
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  <TASK>
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  ? ttm_global_swapout+0xae/0xc=
0
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  ? ttm_tt_populate+0x7d/0x130
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  ?
ttm_bo_vm_fault_reserved+0x237/0x270
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  ? amdgpu_gem_fault+0x92/0xd0
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  ? do_fault+0x28e/0x4b0
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  ? handle_mm_fault+0x849/0xa80
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  ? do_user_addr_fault+0x275/0x=
450
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  ? asm_exc_page_fault+0x9/0x30
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  ? exc_page_fault+0x5f/0x150
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  ? asm_exc_page_fault+0x1f/0x3=
0
Jun 02 19:05:32 axion.fireburn.co.uk kernel:  </TASK>
Jun 02 19:05:32 axion.fireburn.co.uk kernel: Modules linked in:
Jun 02 19:05:32 axion.fireburn.co.uk kernel: CR2: 00000000000000d8
Jun 02 19:05:32 axion.fireburn.co.uk kernel: ---[ end trace
0000000000000000 ]---
Jun 02 19:05:32 axion.fireburn.co.uk kernel: RIP:
0010:ttm_device_swapout+0x6a/0x3d0
Jun 02 19:05:32 axion.fireburn.co.uk kernel: Code: 85 ed 74 51 80 7d
01 00 74 4b 48 89 e6 48 89 ef e8 7b dd ff ff 48 85 c0 74 3b 48 89 c3
49 89 e6 48 8b 7b 30 4c 89 ee 44 89 e2 <4c> 8b bf d8 00 00 00 e8 fa a5
>
Jun 02 19:05:32 axion.fireburn.co.uk kernel: RSP:
0000:ffff888125a17c70 EFLAGS: 00010286
Jun 02 19:05:32 axion.fireburn.co.uk kernel: RAX: ffff888104f45aa0
RBX: ffff888104f45aa0 RCX: 0000000000000000
Jun 02 19:05:32 axion.fireburn.co.uk kernel: RDX: 0000000000000cc0
RSI: ffff888125a17d50 RDI: 0000000000000000
Jun 02 19:05:32 axion.fireburn.co.uk kernel: RBP: ffff888104f45118
R08: ffff88812278da68 R09: ffff888102eaa680
Jun 02 19:05:32 axion.fireburn.co.uk kernel: R10: 0000000000000063
R11: ffffffff818212a0 R12: 0000000000000cc0
Jun 02 19:05:32 axion.fireburn.co.uk kernel: R13: ffff888125a17d50
R14: ffff888125a17c70 R15: 0000000000691000
Jun 02 19:05:32 axion.fireburn.co.uk kernel: FS:
00007fd9e0671740(0000) GS:ffff888fde440000(0000)
knlGS:0000000000000000
Jun 02 19:05:32 axion.fireburn.co.uk kernel: CS:  0010 DS: 0000 ES:
0000 CR0: 0000000080050033
Jun 02 19:05:32 axion.fireburn.co.uk kernel: CR2: 00000000000000d8
CR3: 0000000125c5a000 CR4: 0000000000150ee0
Jun 02 19:05:32 axion.fireburn.co.uk kernel: note:
GravityMark.x64[1040] exited with preempt_count 1

On Thu, 2 Jun 2022 at 19:08, Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Hi
>
> I'm still seeing Null pointers against Linus's tree and drm-misc with thi=
s patch
>
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: BUG: kernel NULL pointer
> dereference, address: 0000000000000008
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: #PF: supervisor write
> access in kernel mode
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: #PF: error_code(0x0002) -
> not-present page
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: PGD 11ee04067 P4D
> 11ee04067 PUD 15eccb067 PMD 0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Oops: 0002 [#1] PREEMPT SMP =
NOPTI
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CPU: 0 PID: 1021 Comm:
> GravityMark.x64 Tainted: G        W         5.18.0-tip+ #3177
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Hardware name: ASUSTeK
> COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.318
> 03/29/2022
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RIP:
> 0010:ttm_resource_init+0x108/0x210
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Code: 48 8b 74 0a 08 48
> 39 de 0f 84 82 00 00 00 48 8b 7b 38 4c 8b 4b 40 4c 8d 44 0a 08 48 8d
> 56 38 4c 89 4f 08 49 89 39 48 8b 4e 38 <48> 89 41 08 48 89 4b 38 48 89
> >
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RSP:
> 0018:ffff888112e73918 EFLAGS: 00010202
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RAX: ffff888206b715d8
> RBX: ffff888206b715a0 RCX: 0000000000000000
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RDX: ffff888206b71cf8
> RSI: ffff888206b71cc0 RDI: ffff888110605b00
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RBP: ffff88816c848c08
> R08: ffff88812235c790 R09: ffff8881306a4bd8
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: R10: 0000000000000000
> R11: ffffffff81851320 R12: ffff888110605ad0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: R13: ffff888206b715a0
> R14: ffff88816c848c58 R15: ffff888110605ad0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: FS:
> 00007f4c257c1740(0000) GS:ffff888fde400000(0000)
> knlGS:0000000000000000
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CS:  0010 DS: 0000 ES:
> 0000 CR0: 0000000080050033
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CR2: 0000000000000008
> CR3: 00000001183fc000 CR4: 0000000000350ef0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Call Trace:
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  <TASK>
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_vram_mgr_new+0xbb/=
0x4b0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? ttm_bo_mem_space+0x89/0x1=
e0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? ttm_bo_validate+0x80/0x1a=
0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_cs_bo_validate+0xe=
9/0x2b0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> amdgpu_syncobj_lookup_and_add_to_sync+0xa0/0xa0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> amdgpu_vm_validate_pt_bos+0xce/0x1c0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_cs_parser_bos+0x52=
2/0x6e0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_cs_ioctl+0x7fe/0xd=
00
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> amdgpu_cs_report_moved_bytes+0x60/0x60
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? drm_ioctl_kernel+0xcb/0x1=
30
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? drm_ioctl+0x2f5/0x400
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> amdgpu_cs_report_moved_bytes+0x60/0x60
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? amdgpu_drm_ioctl+0x42/0x8=
0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? __x64_sys_ioctl+0x5e/0xa0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ? do_syscall_64+0x6a/0x90
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> exit_to_user_mode_prepare+0x19/0x90
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  ?
> entry_SYSCALL_64_after_hwframe+0x46/0xb0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel:  </TASK>
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Modules linked in:
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CR2: 0000000000000008
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: ---[ end trace
> 0000000000000000 ]---
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RIP:
> 0010:ttm_resource_init+0x108/0x210
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: Code: 48 8b 74 0a 08 48
> 39 de 0f 84 82 00 00 00 48 8b 7b 38 4c 8b 4b 40 4c 8d 44 0a 08 48 8d
> 56 38 4c 89 4f 08 49 89 39 48 8b 4e 38 <48> 89 41 08 48 89 4b 38 48 89
> >
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RSP:
> 0018:ffff888112e73918 EFLAGS: 00010202
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RAX: ffff888206b715d8
> RBX: ffff888206b715a0 RCX: 0000000000000000
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RDX: ffff888206b71cf8
> RSI: ffff888206b71cc0 RDI: ffff888110605b00
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: RBP: ffff88816c848c08
> R08: ffff88812235c790 R09: ffff8881306a4bd8
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: R10: 0000000000000000
> R11: ffffffff81851320 R12: ffff888110605ad0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: R13: ffff888206b715a0
> R14: ffff88816c848c58 R15: ffff888110605ad0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: FS:
> 00007f4c257c1740(0000) GS:ffff888fde400000(0000)
> knlGS:0000000000000000
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CS:  0010 DS: 0000 ES:
> 0000 CR0: 0000000080050033
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: CR2: 0000000000000008
> CR3: 00000001183fc000 CR4: 0000000000350ef0
> Jun 02 19:04:05 axion.fireburn.co.uk kernel: note:
> GravityMark.x64[1021] exited with preempt_count 1
>
> On Thu, 2 Jun 2022 at 17:54, Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > On Thu, Jun 2, 2022 at 11:47 AM Christian K=C3=B6nig
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> > >
> > > The resource must be on the LRU before ttm_lru_bulk_move_add() is cal=
led.
> > >
> > > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > This should at least fix the null pointer in these bugs:
> >
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1992
> > Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2034
> >
> > Alex
> >
> > > ---
> > >  drivers/gpu/drm/ttm/ttm_resource.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm=
/ttm_resource.c
> > > index 65889b3caf50..928b9140f3c5 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_resource.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> > > @@ -169,15 +169,17 @@ void ttm_resource_init(struct ttm_buffer_object=
 *bo,
> > >         res->bus.is_iomem =3D false;
> > >         res->bus.caching =3D ttm_cached;
> > >         res->bo =3D bo;
> > > -       INIT_LIST_HEAD(&res->lru);
> > >
> > >         man =3D ttm_manager_type(bo->bdev, place->mem_type);
> > >         spin_lock(&bo->bdev->lru_lock);
> > >         man->usage +=3D res->num_pages << PAGE_SHIFT;
> > > -       if (bo->bulk_move)
> > > +       if (bo->bulk_move) {
> > > +               list_add_tail(&res->lru, &man->lru[bo->priority]);
> > >                 ttm_lru_bulk_move_add(bo->bulk_move, res);
> > > -       else
> > > +       } else {
> > > +               INIT_LIST_HEAD(&res->lru);
> > >                 ttm_resource_move_to_lru_tail(res);
> > > +       }
> > >         spin_unlock(&bo->bdev->lru_lock);
> > >  }
> > >  EXPORT_SYMBOL(ttm_resource_init);
> > > --
> > > 2.25.1
> > >
