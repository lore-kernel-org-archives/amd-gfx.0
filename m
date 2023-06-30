Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BD2EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 14:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12ACB10E490;
	Fri, 30 Jun 2023 14:25:48 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A8610E166
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 14:05:28 +0000 (UTC)
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7870821d9a1so1328700241.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688133926; x=1690725926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S9fi82xI1XYGrAsReOfC7FEPGq3a43VtcEZV/xNSFt0=;
 b=NBbic8Pk5ScDrhIlHEwXqiB3dHcNE9wS9kF0b56zeI60TM394eq/ulwdbUWJkXXdBI
 g477ToFTphguxbovGvHP78niclxnGqzRBWrSlO+IrHLYR4Q6J05yAT/ePVCl3sYWu3Ec
 dRVAdV4K9PB02xIyc6+i8282iSN8+kwBXGN6AbN+MD86pT9FbZy+TJUs1fbN3m4DNJ0+
 CGTZO9lNz55gaGaIvfjED2v4Q3kqFnDOOjT9WUFjThW0seQcULt/iltC1YIGupqC+zf5
 pNXRy9Md8Q+CBAvLCJOTmYSafA9fl3uRhZxtjxiEuvPRSptH1k/S44nHzyhYazNpxmYF
 vloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688133926; x=1690725926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S9fi82xI1XYGrAsReOfC7FEPGq3a43VtcEZV/xNSFt0=;
 b=TQEPFbnNZ6m67OlUqwXJB9Axep6O3HhHrwfkeuhSC/6+DXBNV34gLhZ1yxX3rKBPki
 0P/FwzerlEUi0XQzPvqeOPRy0FeSLv3i414LfVoa/IZCw8jVdS2uMKAaxoZ6mKnaFAeW
 E04FVYY7AB6RURZcll9MH5WBxrEWFBMhQ+4id2kZe85MPpVWcmNH2aagOcctSj+sCalG
 dlO6/fHdKjSqe3E9RGFoTGp0N26682AVamCkt09Ux4t0flNjQrB6B3CrxYiszYtKsPuw
 sK9kS6fBnO6xyR1wqlupjEblzIi4bqSZGUbFMXxCvbXx6AalWSAhXpMLaHDPmKqKTU0b
 MZEg==
X-Gm-Message-State: AC+VfDxBmHFmGcgU9ChCBmr1Dnv/230jB511LrhgsnIlU8ZdCXu1uS9H
 B4Onh2a9Tgzi71+zCR8+jtR+KlchIU6Qnx0ERiw=
X-Google-Smtp-Source: ACHHUZ5tl/keabcFjuGs/VZW+3y4vZt2PmzYDkbYmlcz2hB52Am0GSPVLxMg+PMIpUtDmuji/sZosWIt/Gmr1SEuOnU=
X-Received: by 2002:a05:6102:f09:b0:43f:5fcc:7eee with SMTP id
 v9-20020a0561020f0900b0043f5fcc7eeemr3444539vss.8.1688133926164; Fri, 30 Jun
 2023 07:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230526011846.3331119-1-jiadong.zhu@amd.com>
 <DS7PR12MB63333AA94098FF3191BCE8FFF44B9@DS7PR12MB6333.namprd12.prod.outlook.com>
 <ZJ7Z2RIj0ckGKRiq@fedora>
In-Reply-To: <ZJ7Z2RIj0ckGKRiq@fedora>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Fri, 30 Jun 2023 23:05:14 +0900
Message-ID: <CAB=+i9SC_eErQXqHBiiuztqvB2i9X2RarAD4DVVdXcHD9t3WpQ@mail.gmail.com>
Subject: Re: [BUG REPORT][PATCH 1/2] drm/amdgpu: Modify indirect buffer
 packages for resubmission
To: "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 30 Jun 2023 14:25:46 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 30, 2023 at 10:34=E2=80=AFPM Hyeonggon Yoo <42.hyeyoo@gmail.com=
> wrote:
>
> On Tue, May 30, 2023 at 06:23:53AM +0000, Zhu, Jiadong wrote:
> > -----Original Message-----
> > From: Zhu, Jiadong <Jiadong.Zhu@amd.com>
> > Sent: Friday, May 26, 2023 9:19 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhu, Jiadong <Jiadong.Zhu@amd.com>
> > Subject: [PATCH 1/2] drm/amdgpu: Modify indirect buffer packages for re=
submission
> >
> > From: Jiadong Zhu <Jiadong.Zhu@amd.com>
> >
> > When the preempted IB frame resubmitted to cp, we need to modify the fr=
ame data including:
> > 1. set PRE_RESUME 1 in CONTEXT_CONTROL.
> > 2. use meta data(DE and CE) read from CSA in WRITE_DATA.
> >
> > Add functions to save the location the first time IBs emitted and callb=
ack to patch the package when resubmission happens.
> >
> > Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     | 18 ++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |  9 +++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 60 ++++++++++++++++++++=
  drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h | 15 +++++
> >  4 files changed, 102 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.c
>
> <...snip...>
>
> > +void amdgpu_ring_mux_ib_mark_offset(struct amdgpu_ring_mux *mux,
> > +                                   struct amdgpu_ring *ring, u64 offse=
t,
> > +                                   enum amdgpu_ring_mux_offset_type ty=
pe) {
> > +       struct amdgpu_mux_entry *e;
> > +       struct amdgpu_mux_chunk *chunk;
> > +
> > +       e =3D amdgpu_ring_mux_sw_entry(mux, ring);
> > +       if (!e) {
> > +               DRM_ERROR("cannot find entry!\n");
> > +               return;
> > +       }
> > +
> > +       chunk =3D list_last_entry(&e->list, struct amdgpu_mux_chunk, en=
try);
> > +       if (!chunk) {
> > +               DRM_ERROR("cannot find chunk!\n");
> > +               return;
> > +       }
> > +
> > +       switch (type) {
> > +       case AMDGPU_MUX_OFFSET_TYPE_CONTROL:
> > +               chunk->cntl_offset =3D offset;
> > +               break;
>
> Hello folks,

(+Cc'ing Alex Deucher)

> While booting my laptop I just observed a slab out of bounds error from K=
ASAN on this line.

sorry for confusion, the offending function is not the function above
(amdgpu_ring_mux_ib_mark_offset) but amdgpu_sw_ring_ib_mark_offset()

This was tested on top of commit e55e5df193d247a38a
(" csky: fix up lock_mm_and_find_vma() conversion")
so you can check the line numbers on top of the commit :)

let me know if you need more information.
thanks!

> This splat disappears after reverting this whole series.
> config file is attached.
>
> Thanks!
>
> [   18.223441] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   18.223444] BUG: KASAN: slab-out-of-bounds in amdgpu_sw_ring_ib_mark_o=
ffset (drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c:503 drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring_mux.c:428) amdgpu
> [   18.224601] Write of size 8 at addr ffff8881208eb898 by task kworker/8=
:1/104
>
> [   18.224611] Hardware name: LENOVO 21DL/LNVNB161216, BIOS JPCN20WW(V1.0=
6) 09/20/2022
> [   18.224614] Workqueue: events amdgpu_device_delayed_init_work_handler =
[amdgpu]
> [   18.225558] Call Trace:
> [   18.225561]  <TASK>
> [   18.225563] dump_stack_lvl (lib/dump_stack.c:108)
> [   18.225572] print_report (mm/kasan/report.c:365 (discriminator 1) mm/k=
asan/report.c:475 (discriminator 1))
> [   18.225579] ? __virt_addr_valid (./include/linux/mmzone.h:1908 (discri=
minator 1) ./include/linux/mmzone.h:2004 (discriminator 1) arch/x86/mm/phys=
addr.c:65 (discriminator 1))
> [   18.225585] ? amdgpu_sw_ring_ib_mark_offset (drivers/gpu/drm/amd/amdgp=
u/amdgpu_ring_mux.c:503 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c:428) a=
mdgpu
> [   18.226530] kasan_report (mm/kasan/report.c:590)
> [   18.226535] ? amdgpu_sw_ring_ib_mark_offset (drivers/gpu/drm/amd/amdgp=
u/amdgpu_ring_mux.c:503 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c:428) a=
mdgpu
> [   18.227478] amdgpu_sw_ring_ib_mark_offset (drivers/gpu/drm/amd/amdgpu/=
amdgpu_ring_mux.c:503 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c:428) amd=
gpu
> [   18.228426] gfx_v9_0_ring_emit_ib_gfx (drivers/gpu/drm/amd/amdgpu/amdg=
pu_ring.h:373 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:5169) amdgpu
> [   18.229397] amdgpu_ib_schedule (drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c=
:252 (discriminator 1)) amdgpu
> [   18.230342] gfx_v9_0_ring_test_ib (drivers/gpu/drm/amd/amdgpu/gfx_v9_0=
.c:1052) amdgpu
> [   18.231295] ? __pfx_gfx_v9_0_ring_test_ib (drivers/gpu/drm/amd/amdgpu/=
gfx_v9_0.c:1023) amdgpu
> [   18.232251] ? lock_acquire (kernel/locking/lockdep.c:467 (discriminato=
r 4) kernel/locking/lockdep.c:5763 (discriminator 4) kernel/locking/lockdep=
.c:5726 (discriminator 4))
> [   18.232259] ? __pfx_lock_acquire (kernel/locking/lockdep.c:5729)
> [   18.232263] ? __pfx_lock_release (kernel/locking/lockdep.c:5769)
> [   18.232267] amdgpu_ib_ring_tests (drivers/gpu/drm/amd/amdgpu/amdgpu_ib=
.c:436 (discriminator 1)) amdgpu
> [   18.233219] ? __pfx_gfx_v9_0_ring_test_ib (drivers/gpu/drm/amd/amdgpu/=
gfx_v9_0.c:1023) amdgpu
> [   18.234180] amdgpu_device_delayed_init_work_handler (drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c:3061) amdgpu
> [   18.235110] process_one_work (kernel/workqueue.c:2602)
> [   18.235119] ? __pfx_process_one_work (kernel/workqueue.c:2491)
> [   18.235123] ? lock_acquired (kernel/locking/lockdep.c:6009 kernel/lock=
ing/lockdep.c:6042)
> [   18.235130] worker_thread (./include/linux/list.h:292 (discriminator 2=
) kernel/workqueue.c:2749 (discriminator 2))
> [   18.235136] ? __pfx_worker_thread (kernel/workqueue.c:2691)
> [   18.235140] kthread (kernel/kthread.c:389)
> [   18.235144] ? __pfx_kthread (kernel/kthread.c:342)
> [   18.235148] ret_from_fork (arch/x86/entry/entry_64.S:314)
> [   18.235155]  </TASK>
>
> [   18.235158] Allocated by task 456:
> [   18.235160] kasan_save_stack (mm/kasan/common.c:46)
> [   18.235163] kasan_set_track (mm/kasan/common.c:52 (discriminator 1))
> [   18.235166] __kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:3=
83)
> [   18.235168] __kmalloc (mm/slab_common.c:986 mm/slab_common.c:998)
> [   18.235172] amdgpu_ring_mux_init (drivers/gpu/drm/amd/amdgpu/amdgpu_ri=
ng_mux.c:155 (discriminator 1)) amdgpu
> [   18.236112] gfx_v9_0_sw_init (drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:21=
28) amdgpu
> [   18.237083] amdgpu_device_init (drivers/gpu/drm/amd/amdgpu/amdgpu_devi=
ce.c:2516 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:3993) amdgpu
> [   18.238021] amdgpu_driver_load_kms (drivers/gpu/drm/amd/amdgpu/amdgpu_=
kms.c:146) amdgpu
> [   18.238948] amdgpu_pci_probe (drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:=
2188) amdgpu
> [   18.239904] local_pci_probe (drivers/pci/pci-driver.c:325)
> [   18.239911] pci_device_probe (drivers/pci/pci-driver.c:392 (discrimina=
tor 1) drivers/pci/pci-driver.c:417 (discriminator 1) drivers/pci/pci-drive=
r.c:460 (discriminator 1))
> [   18.239915] really_probe (drivers/base/dd.c:579 drivers/base/dd.c:658)
> [   18.239920] __driver_probe_device (drivers/base/dd.c:798)
> [   18.239923] driver_probe_device (drivers/base/dd.c:828)
> [   18.239926] __driver_attach (drivers/base/dd.c:1215)
> [   18.239928] bus_for_each_dev (drivers/base/bus.c:368)
> [   18.239931] bus_add_driver (drivers/base/bus.c:674)
> [   18.239934] driver_register (drivers/base/driver.c:246)
> [   18.239938] do_one_initcall (init/main.c:1232)
> [   18.239942] do_init_module (kernel/module/main.c:2522)
> [   18.239947] load_module (kernel/module/main.c:2973)
> [   18.239950] init_module_from_file (kernel/module/main.c:3149)
> [   18.239953] __x64_sys_finit_module (./include/linux/file.h:44 kernel/m=
odule/main.c:3172 kernel/module/main.c:3154 kernel/module/main.c:3154)
> [   18.239956] do_syscall_64 (arch/x86/entry/common.c:50 (discriminator 1=
) arch/x86/entry/common.c:80 (discriminator 1))
> [   18.239960] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:=
120)
>
> [   18.239967] The buggy address belongs to the object at ffff8881208eb80=
0
> which belongs to the cache kmalloc-128 of size 128
> [   18.239969] The buggy address is located 24 bytes to the right of
> allocated 128-byte region [ffff8881208eb800, ffff8881208eb880)
>
> [   18.239973] The buggy address belongs to the physical page:
> [   18.239975] page:000000008ed9aff4 refcount:1 mapcount:0 mapping:000000=
0000000000 index:0x0 pfn:0x1208ea
> [   18.239979] head:000000008ed9aff4 order:1 entire_mapcount:0 nr_pages_m=
apped:0 pincount:0
> [   18.239981] flags: 0x17ffffc0010200(slab|head|node=3D0|zone=3D2|lastcp=
upid=3D0x1fffff)
> [   18.239986] page_type: 0xffffffff()
> [   18.239990] raw: 0017ffffc0010200 ffff8881000428c0 dead000000000122 00=
00000000000000
> [   18.239992] raw: 0000000000000000 0000000080200020 00000001ffffffff 00=
00000000000000
> [   18.239994] page dumped because: kasan: bad access detected
>
> [   18.239997] Memory state around the buggy address:
> [   18.239999]  ffff8881208eb780: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   18.240001]  ffff8881208eb800: 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 00
> [   18.240003] >ffff8881208eb880: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   18.240005]                             ^
> [   18.240007]  ffff8881208eb900: 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00 fc
> [   18.240009]  ffff8881208eb980: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   18.240010] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> --
> Hyeonggon Yoo
>
> Undergraduate | Chungnam National University
