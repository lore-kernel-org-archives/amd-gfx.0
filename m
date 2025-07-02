Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20151C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jul 2025 13:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8E710E704;
	Wed,  2 Jul 2025 13:12:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lzY0cBIa";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D4210E6FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jul 2025 13:12:48 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-31305ee3281so857959a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Jul 2025 06:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751461968; x=1752066768; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtU8O/Jb5Tb6dH5emzv7f+G4oJ8n9L9XWl9SgOPMqT8=;
 b=lzY0cBIaK+Hqxs6TQE/2yL0iWk/APx6kznWAG43xLo9BIsPc8G7GjojCKmXlP/PujC
 kite7hD/GB+I6AT3gDgNE4fwpmk7uptBgKgdfiuAuhuX+GoOfrOp+4g4wzIj/R2pMay7
 CD/CTPcXSB4xOp6fGvRAmH9Ay7syzAiF7KWCodtLOu9znup+kpXi8xhUD/gJki4njKvg
 51STAn+1LzlTLsT+iunIhRFlyPdA8QKU5/A1tWf8fRV3xx25eH5274jmhWljahFrEFmI
 vwqBYQSHNivxyv5m3k301Y5YzjBsjSYltmIKJDIcd0sYznq/fQOIeuEYPVhr+e8PlpY1
 u7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751461968; x=1752066768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QtU8O/Jb5Tb6dH5emzv7f+G4oJ8n9L9XWl9SgOPMqT8=;
 b=MPehfsLdBjRtDBlAwVl+iAm4qDExfKmvAfLVeG/wz2/y+/7FwgX8h8nActEsku7gk2
 kdCxi5FY5/+x5IcozwELM2lM7bnadr01rusaztiEXJVNL3h4OYRDdNbq9JiKqHmHJHwX
 oglFktIU41crKnoKFfm493dY2SrMs7SAFC+F/Ww6btQE027xHGxfT821Kmh9pqnAAMzv
 0P2wQF+gIpLVrql4uYnak0Yn1bLlsQ/mw5QCMM1Xu2pZ9XwrF8R/NXNG3ealNs3tNh2V
 hNXZ8kHHa+ovgDefmO9a7KsdvgQhhg/QMdGZOYRDSXNFSJiCyEp5Z1W1Tn6ABA8sdxeG
 7bvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUixO3c3t50hOKFXRF7Gum5kBuKVPPoBE9/0J+DbJmtv5uwGh2TGnovtMhS4YwSBZJ0LKg1fepn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwOfweebjRBw7Rcw0FbMSNB2krvVfoPrC4FoxmUFrQptW+AzIwK
 yUE7p0OQHYFYV8xRl95omNZpVlYCHvOg9pCAeWTtlimLL4VTbsWFPX1dobNms/hwCY7y771oJgE
 Twm5NctEh0pMxqBY4UkoRv1CfEaWXLXw=
X-Gm-Gg: ASbGncusydpIF/EK87nyd7e1i3rlMO0pinuevjiT3Snfrwvw5cF3vbJ90/cL+bvHIZZ
 BtkaH8gHn6Mvur1der7hp3Mw2tKZ7BMBgccxdvsO9ZBjIXiYwFCy7RWp/4DfkZ2Og92mC1Jkvi7
 we4UTmdFzZV0MDbXhWB2onb0uRGNA5adn0FIUQxUbF18Vd
X-Google-Smtp-Source: AGHT+IG20cpSIPzxCDtl8YGvMEEOmFz2z1Q2potddsge9qcpbiQvJ+PaCKmMzN3gA8CblOIDvl71Pg1OiiRWyyCCJjQ=
X-Received: by 2002:a17:90b:55c8:b0:312:639:a06d with SMTP id
 98e67ed59e1d1-31a90c304acmr1609225a91.5.1751461968041; Wed, 02 Jul 2025
 06:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250701152538.5832-1-alexander.deucher@amd.com>
 <DM4PR12MB5152D2C3C56C7F0E8F4B54A7E340A@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_Nxvf_e3JYOHpQb375kWr9ZW79ybQwdtf97QD+8kK2M3w@mail.gmail.com>
In-Reply-To: <CADnq5_Nxvf_e3JYOHpQb375kWr9ZW79ybQwdtf97QD+8kK2M3w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Jul 2025 09:12:36 -0400
X-Gm-Features: Ac12FXwIflMKXn-zYJGAXyeBblRWEqKPhn4biDALzDVUK6KmBI_q7IFVxaFjKEQ
Message-ID: <CADnq5_NdfnB8Bu5N8Yn6_9fu=PenZtwEuKCR-XhKG6R_nLb=eg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma: don't actually disable any SDMA rings
 via debugfs
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Wed, Jul 2, 2025 at 9:03=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Tue, Jul 1, 2025 at 10:08=E2=80=AFPM Zhang, Jesse(Jie) <Jesse.Zhang@am=
d.com> wrote:
> >
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi Alex,
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex=
 Deucher
> > Sent: Tuesday, July 1, 2025 11:26 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH] drm/amdgpu/sdma: don't actually disable any SDMA rings=
 via debugfs
> >
> > We can disable various queues via debugfs for IGT testing, but in doing=
 so, we race with the kernel for VM updates or buffer moves.
> >
> > Fixes: d2e3961ae371 ("drm/amdgpu: add amdgpu_sdma_sched_mask debugfs")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 25 ++++--------------------
> >  1 file changed, 4 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_sdma.c
> > index 8b8a04138711c..4f98d4920f5cf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> > @@ -350,9 +350,8 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *a=
dev)  static int amdgpu_debugfs_sdma_sched_mask_set(void *data, u64 val)  {
> >         struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
> > -       u64 i, num_ring;
> > +       u64 num_ring;
> >         u64 mask =3D 0;
> > -       struct amdgpu_ring *ring, *page =3D NULL;
> >
> >         if (!adev)
> >                 return -ENODEV;
> > @@ -372,25 +371,9 @@ static int amdgpu_debugfs_sdma_sched_mask_set(void=
 *data, u64 val)
> >
> >         if ((val & mask) =3D=3D 0)
> >                 return -EINVAL;
> > -
> > -       for (i =3D 0; i < adev->sdma.num_instances; ++i) {
> > -               ring =3D &adev->sdma.instance[i].ring;
> > -               if (adev->sdma.has_page_queue)
> > -                       page =3D &adev->sdma.instance[i].page;
> > -               if (val & BIT_ULL(i * num_ring))
> > -                       ring->sched.ready =3D true;
> > -               else
> > -                       ring->sched.ready =3D false;
> >
> >
> > Is it possible to change the write ring->sched.ready  via WRITE_ONCE or=
 atomic_set to avoid the race?
> > And check val to avoid disabling all sdma queues.
> >     /* Get current valid mask (reuses _get logic) */
> >     ret =3D amdgpu_debugfs_sdma_sched_mask_get(data, current_mask);
> >     if (ret)
> >         return ret;
> >
> >     /* Reject invalid masks */
> >     if (val & ~current_mask)
> >         return -EINVAL;
>
> There are two things we need to handle.
> 1. The ring used for BO moves and clears:
> adev->mman.buffer_funcs_ring
> This would need to be changed to a different SDMA ring if the once
> currently assigned is disabled or we'd need to fall back to do copies
> and clears with the CPU, but that won't work without large BARs.
> 2. The VM scheduling entities:
> vm->immediate
> vm->delayed
> We'd need to adjust adev->vm_manager.vm_pte_scheds and
> adev->vm_manager.vm_pte_num_scheds to reflect what's currently
> disabled and then update the drm sched entity.

Here's the segfault I'm seeing with the latter:

[  193.939200] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[  193.939226] #PF: supervisor read access in kernel mode
[  193.939238] #PF: error_code(0x0000) - not-present page
[  193.939250] PGD 10836d8067 P4D 10836d8067 PUD 10d5e76067 PMD 0
[  193.939275] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  193.939291] CPU: 15 UID: 0 PID: 4678 Comm: amd_deadlock Tainted: G
          E      6.14.0+ #1976
[  193.939312] Tainted: [E]=3DUNSIGNED_MODULE
[  193.939322] Hardware name: System manufacturer System Product
Name/ROG STRIX X399-E GAMING, BIOS 1002 02/15/2019
[  193.939339] RIP: 0010:drm_sched_job_arm+0x1f/0x50 [gpu_sched]
[  193.939366] Code: 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00
55 53 48 8b 6f 20 48 85 ed 74 3d 48 89 fb 48 89 ef e8 a5 36 00 00 48
8b 45 18 <48> 8b 10 48 89 53 10 8b 45 2c 89 43 28 b8 01 00 00 00 f0 48
0f c1
[  193.939395] RSP: 0018:ffffa70898ecbaa8 EFLAGS: 00010206
[  193.939410] RAX: 0000000000000000 RBX: ffff8e382cc3e400 RCX: 00000000000=
00000
[  193.939425] RDX: 0000000000000001 RSI: ffff8e3808c16ed0 RDI: 00000000fff=
fffff
[  193.939440] RBP: ffff8e384213b350 R08: ffff8e3811ab0968 R09: 00000000000=
00000
[  193.939454] R10: ffff8e3808c16ed0 R11: 0000000000000003 R12: ffffa70898e=
cbc20
[  193.939468] R13: ffff8e382cc3e400 R14: 0000000000000000 R15: 00000000000=
00000
[  193.939484] FS:  00007fd1a992bac0(0000) GS:ffff8e47be580000(0000)
knlGS:0000000000000000
[  193.939502] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  193.939515] CR2: 0000000000000000 CR3: 00000010ded50000 CR4: 00000000003=
506f0
[  193.939530] Call Trace:
[  193.939541]  <TASK>
[  193.939553]  ? __die_body.cold+0x19/0x27
[  193.939571]  ? page_fault_oops+0x116/0x280
[  193.939587]  ? srso_return_thunk+0x5/0x5f
[  193.939603]  ? srso_return_thunk+0x5/0x5f
[  193.939617]  ? do_user_addr_fault+0x63/0x620
[  193.939630]  ? irq_work_queue+0xa/0x50
[  193.939649]  ? exc_page_fault+0x7a/0x190
[  193.939665]  ? asm_exc_page_fault+0x22/0x30
[  193.939688]  ? drm_sched_job_arm+0x1f/0x50 [gpu_sched]
[  193.939711]  ? drm_sched_job_arm+0x1b/0x50 [gpu_sched]
[  193.939732]  amdgpu_job_submit+0x15/0xe0 [amdgpu]
[  193.940502]  amdgpu_vm_sdma_commit+0x76/0x210 [amdgpu]
[  193.941144]  amdgpu_vm_update_range+0x423/0x830 [amdgpu]
[  193.941631]  amdgpu_vm_clear_freed+0x108/0x270 [amdgpu]
[  193.942063]  amdgpu_gem_va_ioctl+0x4be/0x800 [amdgpu]
[  193.942475]  ? up_read+0x37/0x70
[  193.942492]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
[  193.942904]  drm_ioctl_kernel+0x82/0xe0 [drm]
[  193.942974]  drm_ioctl+0x25c/0x4f0 [drm]
[  193.943038]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
[  193.943457]  amdgpu_drm_ioctl+0x47/0x80 [amdgpu]
[  193.943853]  __x64_sys_ioctl+0x93/0xc0
[  193.943867]  do_syscall_64+0x62/0x180
[  193.943882]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  193.943895] RIP: 0033:0x7fd1ab8e514d
[  193.943934] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10
c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00
00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00
00 00
[  193.943957] RSP: 002b:00007ffe6261f400 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[  193.943973] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd1ab8=
e514d
[  193.943985] RDX: 00007ffe6261f4a0 RSI: 00000000c0286448 RDI: 00000000000=
00004
[  193.943996] RBP: 00007ffe6261f450 R08: 0000000110000000 R09: 00000000000=
0000e
[  193.944008] R10: 0000000000000003 R11: 0000000000000246 R12: 00007ffe626=
1f4a0
[  193.944019] R13: 00000000c0286448 R14: 0000000000000004 R15: 0000000021e=
92a70

Alex

>
> Alex
>
> > -
> > -               if (page) {
> > -                       if (val & BIT_ULL(i * num_ring + 1))
> > -                               page->sched.ready =3D true;
> > -                       else
> > -                               page->sched.ready =3D false;
> > -               }
> > -       }
> > -       /* publish sched.ready flag update effective immediately across=
 smp */
> > -       smp_rmb();
> > +       /* Just return success here. We can't disable any rings otherwi=
se
> > +        * we race with vm udpates or buffer ops.
> > +        */
> >         return 0;
> >  }
> >
> > --
> > 2.50.0
> >
