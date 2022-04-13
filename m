Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4261EC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Apr 2022 11:15:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFE7210E0EB;
	Wed, 13 Apr 2022 11:15:37 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5997510E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 11:15:36 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 g17-20020a9d6191000000b005e8d8583c36so930397otk.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Apr 2022 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wcTO4H6EvSVU3LNEDsQgGZiM0vb4tIbXFE79XHrr7oY=;
 b=KdBaguexsZjvP1LHGomfE0UzVrjQYg/o3XC89FcziiBZYMz/OQY824Nb8ApfVrKG2v
 ALkESKDdKOAc62BkiR8Iz+fhPL7XdvIXbfOZqC6O2PrFQ+2mMp4mYezb5y0fqfp39tD4
 z2vMJ6Zp0ELXFmgZhptu/Kqly2yOpX2xFmSn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wcTO4H6EvSVU3LNEDsQgGZiM0vb4tIbXFE79XHrr7oY=;
 b=LEfwr62ZjzPnwjMRCFn5x6NI3qMLpLvqJz99P3DKFaxLLRp9MUmXhEWl4HYMBH0ZkN
 NEEA+Ht0LXM8ptUcUYl8Egy7DW9Hpg9AGHbPo2yT+vGQWSTdst4OLt5TJfZIuTYeJgKy
 zm9/0orZhwLeLpwEeVxkIYtSPEiW66LZVQg6Jf0FDjY95VQDgXkamj0wkHOZS5BBmAGk
 bSSidVIROsN+YkPK8egeYd5+cQrDEcvjTKE021sjBykh7bzvFLej3U86oHYYQ0p6MJHt
 gOnogmvL58sNlHVhTO/SfcDGRolALatBvEH7WZvLFuwmHhk96IV8KbTw2UJjxT4ywIPF
 7m2A==
X-Gm-Message-State: AOAM533sCc1d6nzuq1hSKpCVBcCzkHJElOpsv72sAT4mMLU+MpqK/sTp
 aktxBJWBCLfX5PXZB34oTHiMyf+IgUkoFC9zHC+E+g==
X-Google-Smtp-Source: ABdhPJzdSiZdpR0kdRDspMH4Jvq3DBoGPmoS3zee0c7Qbx+jH3zwEulL2lHOY97smJyjs6OEMh1LGplWr7we14OznCM=
X-Received: by 2002:a9d:57c7:0:b0:5b2:3d6d:6469 with SMTP id
 q7-20020a9d57c7000000b005b23d6d6469mr14412599oti.301.1649848535569; Wed, 13
 Apr 2022 04:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220412120322.28169-1-xinhui.pan@amd.com>
 <299dca93-dc4d-8b1a-6de7-bfab8ebc8c19@amd.com>
In-Reply-To: <299dca93-dc4d-8b1a-6de7-bfab8ebc8c19@amd.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 13 Apr 2022 13:15:24 +0200
Message-ID: <CAKMK7uEVSuUf29fOHJ-vAk_=Yxhf7iW4TMSAeAirXOn=Jet7rw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix one use-after-free of VM
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: alexander.deucher@amd.com, xinhui pan <Xinhui.Pan@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 12 Apr 2022 at 14:11, Christian K=C3=B6nig <christian.koenig@amd.co=
m> wrote:
>
> Am 12.04.22 um 14:03 schrieb xinhui pan:
> > VM might already be freed when amdgpu_vm_tlb_seq_cb() is called.
> > We see the calltrace below.
> >
> > Fix it by keeping the last flush fence around and wait for it to signal
> >
> > BUG kmalloc-4k (Not tainted): Poison overwritten
> >
> > 0xffff9c88630414e8-0xffff9c88630414e8 @offset=3D5352. First byte 0x6c
> > instead of 0x6b Allocated in amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
> > age=3D44 cpu=3D0 pid=3D2343
> >   __slab_alloc.isra.0+0x4f/0x90
> >   kmem_cache_alloc_trace+0x6b8/0x7a0
> >   amdgpu_driver_open_kms+0x9d/0x360 [amdgpu]
> >   drm_file_alloc+0x222/0x3e0 [drm]
> >   drm_open+0x11d/0x410 [drm]
> >   drm_stub_open+0xdc/0x230 [drm]
> >   chrdev_open+0xa5/0x1e0
> >   do_dentry_open+0x16c/0x3c0
> >   vfs_open+0x2d/0x30
> >   path_openat+0x70a/0xa90
> >   do_filp_open+0xb2/0x120
> >   do_sys_openat2+0x245/0x330
> >   do_sys_open+0x46/0x80
> >   __x64_sys_openat+0x20/0x30
> >   do_syscall_64+0x38/0xc0
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> > Freed in amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu] age=3D22 cpu=
=3D1
> > pid=3D2485
> >   kfree+0x4a2/0x580
> >   amdgpu_driver_postclose_kms+0x3e9/0x550 [amdgpu]
> >   drm_file_free+0x24e/0x3c0 [drm]
> >   drm_close_helper.isra.0+0x90/0xb0 [drm]
> >   drm_release+0x97/0x1a0 [drm]
> >   __fput+0xb6/0x280
> >   ____fput+0xe/0x10
> >   task_work_run+0x64/0xb0
> >   do_exit+0x406/0xcf0
> >   do_group_exit+0x50/0xc0
> >   __x64_sys_exit_group+0x18/0x20
> >   do_syscall_64+0x38/0xc0
> >   entry_SYSCALL_64_after_hwframe+0x44/0xae
> >
> > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: xinhui pan <xinhui.pan@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 22 +++++++++++++++++++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  1 +
> >   2 files changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.c
> > index 645ce28277c2..e2486e95ca69 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -932,9 +932,12 @@ int amdgpu_vm_update_range(struct amdgpu_device *a=
dev, struct amdgpu_vm *vm,
> >
> >       if (flush_tlb || params.table_freed) {
> >               tlb_cb->vm =3D vm;
> > -             if (!fence || !*fence ||
> > -                 dma_fence_add_callback(*fence, &tlb_cb->cb,
> > -                                        amdgpu_vm_tlb_seq_cb))
> > +             if (fence && *fence &&
> > +                 !dma_fence_add_callback(*fence, &tlb_cb->cb,
> > +                                        amdgpu_vm_tlb_seq_cb)) {
> > +                     dma_fence_put(vm->last_delayed_tlb_flush);
> > +                     vm->last_delayed_tlb_flush =3D dma_fence_get(*fen=
ce);
> > +             } else
> >                       amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> >               tlb_cb =3D NULL;
> >       }
> > @@ -2258,6 +2261,19 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, =
struct amdgpu_vm *vm)
> >       dma_fence_wait(vm->last_unlocked, false);
> >       dma_fence_put(vm->last_unlocked);
> >
> > +     if (vm->last_delayed_tlb_flush) {
>
> You can initialize last_delayed_tlb_flush() with the dummy fence, see
> how last_unlocked works.
>
> > +             /* Wait until fence is signaled.
> > +              * But must double check to make sure fence cb is called.
> > +              * As dma_fence_default_wait checks DMA_FENCE_FLAG_SIGNAL=
ED_BIT without
> > +              * holding fence lock(the first test_bit).
> > +              * So call dma_fence_get_status which will hold the fence=
 lock.
> > +              * Then we can make sure fence cb has been called.
> > +              */
>
> Uff, that is a really good point and most likely a bug in dma_fence_wait(=
).
>
> I'm pretty sure that a couple of other callers rely on that as well.
>
> Daniel what's you opinion about that?

dma_fence_wait + dma_fence_signal provide a barrier (like the other
wake_up/wait function pairs we have), but nothing more. So you're not
really guaranteed at all that any other waiters have received the
wakeup. This is also why we had that wording that waiters need to hold
a dma_fence reference or things can go boom. This is also standard
linux and I have honestly no idea how we could guarantee more without
either making this all more expensive (forcing more refcounting would
probably be needed) or making it look like there's a guarantee that
really doesn't hold when you try to use it. wait/wake_up functions
pair really should not provide more ordering than just the barrier
(and that barrier is even conditional on "an actual wake-up has
happened").

I'm not exactly sure how to best fix this here, but I guess you either
want your own spinlock to protect the link between the fence and the
vm, or some other refcounting scheme changes (like you have the gpu
ctx that run on top of a vm hold the refence on the fence, and the
fence itself holds a full reference on the vm) to make sure there's
not use after free here.

I don't think the spinlock fence you propose below is enough, I think
you also need to protect any vm dereference from under that spinlock
(i.e. set some vm pointer to NULL while holding that spinlock, or
whatever you need to do to unlink the fence from the vm).
-Daniel

>
> Thanks,
> Christian.
>
> > +             (void)dma_fence_wait(vm->last_delayed_tlb_flush, false);
> > +             (void)dma_fence_get_status(vm->last_delayed_tlb_flush);
> > +             dma_fence_put(vm->last_delayed_tlb_flush);
> > +     }
> > +
> >       list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
> >               if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
> >                       amdgpu_vm_prt_fini(adev, vm);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.h
> > index 1a814fbffff8..c1a48f5c1019 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -286,6 +286,7 @@ struct amdgpu_vm {
> >
> >       /* Last finished delayed update */
> >       atomic64_t              tlb_seq;
> > +     struct dma_fence        *last_delayed_tlb_flush;
> >
> >       /* Last unlocked submission to the scheduler entities */
> >       struct dma_fence        *last_unlocked;
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
