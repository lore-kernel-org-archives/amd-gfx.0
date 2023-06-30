Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C57EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 14:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99BA210E48E;
	Fri, 30 Jun 2023 14:29:43 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B581B10E48E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 14:29:40 +0000 (UTC)
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-38e04d1b2b4so1350847b6e.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688135379; x=1690727379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOv0aysYsCQjqwGoH0mQjcuIibs3Pny/1RTvzHnp3eY=;
 b=T8ZHtDMcNjdUws5atzVc2MzvoB3Q2nHpURNiGtNN8PQbJ4Apko+fn7Vi4IiDY5x1ln
 Ryifbe/J87OHJSTMIRy0weKjt83YMMMVavCl0kKbPqLg6PvhEuFcE6kr9jP58q8tdHoJ
 y1SK7lt8cm1NrOdSOxMRJmo9TB4qRp8BiQo90IZfyP8pnzMukwiZZagm9JKcSlptgWQ6
 Pe7Bx/B4NuQEwn1l3AF8SaARzP3bhSJAG+OPutbK2sxOhCZJse3QKvtJVTEAWUqrX4fr
 u0K4BdbbHwGAA1ZVZ4bCbvF4bde6QankN/cPY9PluNHQDJhdsHUKhkWU4OESnUipwsqL
 9axA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688135379; x=1690727379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOv0aysYsCQjqwGoH0mQjcuIibs3Pny/1RTvzHnp3eY=;
 b=bPmvcXdpHvSZMKsiFylo361tRlHTRfVYYXJ7Gq/TJm5TH2X0gjtbbJ/UGSfPxlj0VF
 0Fgc9XC1qrAW3+W2MB9k1ReksySjkscI9Q01tSxSmnVadjw/KjnHA8bwSZYkoL5vn/Rn
 n1hdicQSxH4VZWcqxD8xAy63G/acfdUhwbRQtIYjnLxv5FiESUDKWZJ1Dvu9lTMkIjxC
 lBraPr2lWbIS1nh/6dIvpct5hpKNZ9VhGHmcJ6lZgolE6N5T5MVzc+VDES1uToJzPmDN
 8TTbGLUdPj99x/BHM2dLsexThv44gAgMuflqmePJ1BsJcR5p+gsEzsxyHakrewBv27/u
 IKWw==
X-Gm-Message-State: AC+VfDx9EGMoMmc3rPGX6pD/AiryZBSYsUYvSyQ/nBg6zeof2p5QH4PH
 StlUEnvXXVuiqjpj1RSJ8y3ldrr5JnXebZuK/qUSc/N9JcU=
X-Google-Smtp-Source: ACHHUZ7p5fFpBMzf1OWVnw4S5DO6vgtzVcoUupOdgDMXY7MgqmhrEcVURpOqqk3a48lhf9Qf5Wbl1STbxiWA9Z7qaOw=
X-Received: by 2002:a05:6808:1792:b0:3a1:dfa4:b654 with SMTP id
 bg18-20020a056808179200b003a1dfa4b654mr3230467oib.11.1688135379422; Fri, 30
 Jun 2023 07:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230526011846.3331119-1-jiadong.zhu@amd.com>
 <DS7PR12MB63333AA94098FF3191BCE8FFF44B9@DS7PR12MB6333.namprd12.prod.outlook.com>
 <ZJ7Z2RIj0ckGKRiq@fedora>
 <CAB=+i9SC_eErQXqHBiiuztqvB2i9X2RarAD4DVVdXcHD9t3WpQ@mail.gmail.com>
In-Reply-To: <CAB=+i9SC_eErQXqHBiiuztqvB2i9X2RarAD4DVVdXcHD9t3WpQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Jun 2023 10:29:28 -0400
Message-ID: <CADnq5_MNOoxNKW92npaioQTYByuSi0ktNcTzmdy2VsDzducnrA@mail.gmail.com>
Subject: Re: [BUG REPORT][PATCH 1/2] drm/amdgpu: Modify indirect buffer
 packages for resubmission
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Zhu,
 Jiadong" <Jiadong.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 30, 2023 at 10:25=E2=80=AFAM Hyeonggon Yoo <42.hyeyoo@gmail.com=
> wrote:
>
> On Fri, Jun 30, 2023 at 10:34=E2=80=AFPM Hyeonggon Yoo <42.hyeyoo@gmail.c=
om> wrote:
> >
> > On Tue, May 30, 2023 at 06:23:53AM +0000, Zhu, Jiadong wrote:
> > > -----Original Message-----
> > > From: Zhu, Jiadong <Jiadong.Zhu@amd.com>
> > > Sent: Friday, May 26, 2023 9:19 AM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Zhu, Jiadong <Jiadong.Zhu@amd.com>
> > > Subject: [PATCH 1/2] drm/amdgpu: Modify indirect buffer packages for =
resubmission
> > >
> > > From: Jiadong Zhu <Jiadong.Zhu@amd.com>
> > >
> > > When the preempted IB frame resubmitted to cp, we need to modify the =
frame data including:
> > > 1. set PRE_RESUME 1 in CONTEXT_CONTROL.
> > > 2. use meta data(DE and CE) read from CSA in WRITE_DATA.
> > >
> > > Add functions to save the location the first time IBs emitted and cal=
lback to patch the package when resubmission happens.
> > >
> > > Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     | 18 ++++++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |  9 +++
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 60 ++++++++++++++++++=
++  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h | 15 +++++
> > >  4 files changed, 102 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring.c
> >
> > <...snip...>
> >
> > > +void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux,
> > > +                                   struct amdgpu_ring *ring, u64 off=
set,
> > > +                                   enum amdgpu_ring_mux_offset_type =
type) {
> > > +       struct amdgpu_mux_entry *e;
> > > +       struct amdgpu_mux_chunk *chunk;
> > > +
> > > +       e =3D amdgpu_ring_mux_sw_entry(mux, ring);
> > > +       if (!e) {
> > > +               DRM_ERROR("cannot find entry!\n");
> > > +               return;
> > > +       }
> > > +
> > > +       chunk =3D list_last_entry(&e->list, struct amdgpu_mux_chunk, =
entry);
> > > +       if (!chunk) {
> > > +               DRM_ERROR("cannot find chunk!\n");
> > > +               return;
> > > +       }
> > > +
> > > +       switch (type) {
> > > +       case AMDGPU_MUX_OFFSET_TYPE_CONTROL:
> > > +               chunk->cntl_offset =3D offset;
> > > +               break;
> >
> > Hello folks,
>
> (+Cc'ing Alex Deucher)
>
> > While booting my laptop I just observed a slab out of bounds error from=
 KASAN on this line.
>
> sorry for confusion, the offending function is not the function above
> (amdgpu_ring_mux_ib_mark_offset) but amdgpu_sw_ring_ib_mark_offset()
>
> This was tested on top of commit e55e5df193d247a38a
> (" csky: fix up lock_mm_and_find_vma() conversion")
> so you can check the line numbers on top of the commit :)
>
> let me know if you need more information.

I believe this was fixed in this patch:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/ef3c36a6e025e9b16ca3321=
479ba016841fa17a0

Alex

> thanks!
>
> > This splat disappears after reverting this whole series.
> > config file is attached.
> >
> > Thanks!
> >
> > [   18.223441] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   18.223444] BUG: KASAN: slab-out-of-bounds in amdgpu_sw_ring_ib_mark=
_offset (drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c:503 drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring_mux.c:428) amdgpu
> > [   18.224601] Write of size 8 at addr ffff8881208eb898 by task kworker=
/8:1/104
> >
> > [   18.224611] Hardware name: LENOVO 21DL/LNVNB161216, BIOS JPCN20WW(V1=
.06) 09/20/2022
> > [   18.224614] Workqueue: events amdgpu_device_delayed_init_work_handle=
r [amdgpu]
> > [   18.225558] Call Trace:
> > [   18.225561]  <TASK>
> > [   18.225563] dump_stack_lvl (lib/dump_stack.c:108)
> > [   18.225572] print_report (mm/kasan/report.c:365 (discriminator 1) mm=
/kasan/report.c:475 (discriminator 1))
> > [   18.225579] ? __virt_addr_valid (./include/linux/mmzone.h:1908 (disc=
riminator 1) ./include/linux/mmzone.h:2004 (discriminator 1) arch/x86/mm/ph=
ysaddr.c:65 (discriminator 1))
> > [   18.225585] ? amdgpu_sw_ring_ib_mark_offset (drivers/gpu/drm/amd/amd=
gpu/amdgpu_ring_mux.c:503 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c:428)=
 amdgpu
> > [   18.226530] kasan_report (mm/kasan/report.c:590)
> > [   18.226535] ? amdgpu_sw_ring_ib_mark_offset (drivers/gpu/drm/amd/amd=
gpu/amdgpu_ring_mux.c:503 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c:428)=
 amdgpu
> > [   18.227478] amdgpu_sw_ring_ib_mark_offset (drivers/gpu/drm/amd/amdgp=
u/amdgpu_ring_mux.c:503 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c:428) a=
mdgpu
> > [   18.228426] gfx_v9_0_ring_emit_ib_gfx (drivers/gpu/drm/amd/amdgpu/am=
dgpu_ring.h:373 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:5169) amdgpu
> > [   18.229397] amdgpu_ib_schedule (drivers/gpu/drm/amd/amdgpu/amdgpu_ib=
.c:252 (discriminator 1)) amdgpu
> > [   18.230342] gfx_v9_0_ring_test_ib (drivers/gpu/drm/amd/amdgpu/gfx_v9=
_0.c:1052) amdgpu
> > [   18.231295] ? __pfx_gfx_v9_0_ring_test_ib (drivers/gpu/drm/amd/amdgp=
u/gfx_v9_0.c:1023) amdgpu
> > [   18.232251] ? lock_acquire (kernel/locking/lockdep.c:467 (discrimina=
tor 4) kernel/locking/lockdep.c:5763 (discriminator 4) kernel/locking/lockd=
ep.c:5726 (discriminator 4))
> > [   18.232259] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5729)
> > [   18.232263] ? __pfx_lock_release (kernel/locking/lockdep.c:5769)
> > [   18.232267] amdgpu_ib_ring_tests (drivers/gpu/drm/amd/amdgpu/amdgpu_=
ib.c:436 (discriminator 1)) amdgpu
> > [   18.233219] ? __pfx_gfx_v9_0_ring_test_ib (drivers/gpu/drm/amd/amdgp=
u/gfx_v9_0.c:1023) amdgpu
> > [   18.234180] amdgpu_device_delayed_init_work_handler (drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c:3061) amdgpu
> > [   18.235110] process_one_work (kernel/workqueue.c:2602)
> > [   18.235119] ? __pfx_process_one_work (kernel/workqueue.c:2491)
> > [   18.235123] ? lock_acquired (kernel/locking/lockdep.c:6009 kernel/lo=
cking/lockdep.c:6042)
> > [   18.235130] worker_thread (./include/linux/list.h:292 (discriminator=
 2) kernel/workqueue.c:2749 (discriminator 2))
> > [   18.235136] ? __pfx_worker_thread (kernel/workqueue.c:2691)
> > [   18.235140] kthread (kernel/kthread.c:389)
> > [   18.235144] ? __pfx_kthread (kernel/kthread.c:342)
> > [   18.235148] ret_from_fork (arch/x86/entry/entry_64.S:314)
> > [   18.235155]  </TASK>
> >
> > [   18.235158] Allocated by task 456:
> > [   18.235160] kasan_save_stack (mm/kasan/common.c:46)
> > [   18.235163] kasan_set_track (mm/kasan/common.c:52 (discriminator 1))
> > [   18.235166] __kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c=
:383)
> > [   18.235168] __kmalloc (mm/slab_common.c:986 mm/slab_common.c:998)
> > [   18.235172] amdgpu_ring_mux_init (drivers/gpu/drm/amd/amdgpu/amdgpu_=
ring_mux.c:155 (discriminator 1)) amdgpu
> > [   18.236112] gfx_v9_0_sw_init (drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:=
2128) amdgpu
> > [   18.237083] amdgpu_device_init (drivers/gpu/drm/amd/amdgpu/amdgpu_de=
vice.c:2516 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:3993) amdgpu
> > [   18.238021] amdgpu_driver_load_kms (drivers/gpu/drm/amd/amdgpu/amdgp=
u_kms.c:146) amdgpu
> > [   18.238948] amdgpu_pci_probe (drivers/gpu/drm/amd/amdgpu/amdgpu_drv.=
c:2188) amdgpu
> > [   18.239904] local_pci_probe (drivers/pci/pci-driver.c:325)
> > [   18.239911] pci_device_probe (drivers/pci/pci-driver.c:392 (discrimi=
nator 1) drivers/pci/pci-driver.c:417 (discriminator 1) drivers/pci/pci-dri=
ver.c:460 (discriminator 1))
> > [   18.239915] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:65=
8)
> > [   18.239920] __driver_probe_device (drivers/base/dd.c:798)
> > [   18.239923] driver_probe_device (drivers/base/dd.c:828)
> > [   18.239926] __driver_attach (drivers/base/dd.c:1215)
> > [   18.239928] bus_for_each_dev (drivers/base/bus.c:368)
> > [   18.239931] bus_add_driver (drivers/base/bus.c:674)
> > [   18.239934] driver_register (drivers/base/driver.c:246)
> > [   18.239938] do_one_initcall (init/main.c:1232)
> > [   18.239942] do_init_module (kernel/module/main.c:2522)
> > [   18.239947] load_module (kernel/module/main.c:2973)
> > [   18.239950] init_module_from_file (kernel/module/main.c:3149)
> > [   18.239953] __x64_sys_finit_module (./include/linux/file.h:44 kernel=
/module/main.c:3172 kernel/module/main.c:3154 kernel/module/main.c:3154)
> > [   18.239956] do_syscall_64 (arch/x86/entry/common.c:50 (discriminator=
 1) arch/x86/entry/common.c:80 (discriminator 1))
> > [   18.239960] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.=
S:120)
> >
> > [   18.239967] The buggy address belongs to the object at ffff8881208eb=
800
> > which belongs to the cache kmalloc-128 of size 128
> > [   18.239969] The buggy address is located 24 bytes to the right of
> > allocated 128-byte region [ffff8881208eb800, ffff8881208eb880)
> >
> > [   18.239973] The buggy address belongs to the physical page:
> > [   18.239975] page:000000008ed9aff4 refcount:1 mapcount:0 mapping:0000=
000000000000 index:0x0 pfn:0x1208ea
> > [   18.239979] head:000000008ed9aff4 order:1 entire_mapcount:0 nr_pages=
_mapped:0 pincount:0
> > [   18.239981] flags: 0x17ffffc0010200(slab|head|node=3D0|zone=3D2|last=
cpupid=3D0x1fffff)
> > [   18.239986] page_type: 0xffffffff()
> > [   18.239990] raw: 0017ffffc0010200 ffff8881000428c0 dead000000000122 =
0000000000000000
> > [   18.239992] raw: 0000000000000000 0000000080200020 00000001ffffffff =
0000000000000000
> > [   18.239994] page dumped because: kasan: bad access detected
> >
> > [   18.239997] Memory state around the buggy address:
> > [   18.239999]  ffff8881208eb780: fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc
> > [   18.240001]  ffff8881208eb800: 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 00
> > [   18.240003] >ffff8881208eb880: fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc
> > [   18.240005]                             ^
> > [   18.240007]  ffff8881208eb900: 00 00 00 00 00 00 00 00 00 00 00 00 0=
0 00 00 fc
> > [   18.240009]  ffff8881208eb980: fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc
> > [   18.240010] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > --
> > Hyeonggon Yoo
> >
> > Undergraduate | Chungnam National University
