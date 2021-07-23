Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B32C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 09:00:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0627B60EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 09:00:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0627B60EBD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A49876E852;
	Fri, 23 Jul 2021 09:00:28 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2606E880
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 09:00:27 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id he41so2634834ejc.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=H26XLDHAuR0jPZ2O2Q0bOo1MF/EVyLPQLBSZ6hdsVnM=;
 b=BiQl2gBbigvHJE/9/tHAh7I+BwJmeQGRnucu07I6wHNJ0qPhWZChQPXnHDdONxxB80
 fc82S5R044fRYwcTJ2ELDam/CC5efspA2CuaVREFuvzbd/OM4BqTPki+AWtrcKYU3Jqz
 H5hEXS2uTlpgWgJgE+ShQtKqt+TSoczqoyMxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=H26XLDHAuR0jPZ2O2Q0bOo1MF/EVyLPQLBSZ6hdsVnM=;
 b=LFslXJVaYSujiF7vQJzrojl7vxxUQ35/JVaFFn9F632mWmWGhMtRAqZIF++q9cnuMo
 ha/yjVPJX698rwt9ZeLmGePm7gxSDLCPiY4VGq4TXMaHbx1qyrpfI/goDi+EGv99phAI
 x6JHwz8meN5/GIb9uk8RbpjdNfrriaTH+afN5hknwzDYIrOMblEMHuh9c0fE5HMHjEjg
 0KgKc47+b/kUMoEx8+omwtfP58hHgh00qm5DszM1lBWxPF9MJRbzGgqUdg6VulkDzKYN
 86ov0p9J+80yvTanagt9UPYxTkm4hTuWl3JXQLBq2KgJbt7Achc0oOrulSrrGSQnOtPq
 DTOg==
X-Gm-Message-State: AOAM533cXSkdRzWTi2r0S+KWa32M0JB8PZrSweDkXpGHQsYacgVKex+u
 lB7x2b3UxAItvVMvyNOFR7yTaw==
X-Google-Smtp-Source: ABdhPJxaqRvTTcawwQoh7Z4vp5PxhjTlxsn7RgYfy3eAl/e8KGn8cJ6GjJc+BMI4dcYMZFxDziF80Q==
X-Received: by 2002:a17:906:86d0:: with SMTP id
 j16mr3701421ejy.20.1627030825944; 
 Fri, 23 Jul 2021 02:00:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id b25sm13844275edv.9.2021.07.23.02.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jul 2021 02:00:25 -0700 (PDT)
Date: Fri, 23 Jul 2021 11:00:23 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH v3 1/1] drm/ttm: Fix COW check
Message-ID: <YPqFJ0GSciZnyszl@phenom.ffwll.local>
References: <20210712220636.475675-1-Felix.Kuehling@amd.com>
 <d617d831-7168-51a4-042e-e36a5af7761d@gmail.com>
 <CADnq5_NCg6VnWgH7Hn61CjZBZiRuAdROW5s6imwQ8AR=9Bm4=g@mail.gmail.com>
 <1dd35814-c2bb-6e71-6259-e9d4f77d8969@amd.com>
 <CAKMK7uH7YUgFUkgdrRrxypqkHoYx_NN6vcvTB=LOwVGDriov9Q@mail.gmail.com>
 <ab0b302e-436a-f5e6-b111-957f79d18da0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab0b302e-436a-f5e6-b111-957f79d18da0@gmail.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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
Cc: Daniel Vetter <daniel@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Alex Deucher <alexdeucher@gmail.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 23, 2021 at 10:33:48AM +0200, Christian K=F6nig wrote:
> =

> =

> Am 23.07.21 um 10:21 schrieb Daniel Vetter:
> > On Wed, Jul 14, 2021 at 10:51 AM Christian K=F6nig
> > <christian.koenig@amd.com> wrote:
> > > =

> > > =

> > > Am 13.07.21 um 17:28 schrieb Alex Deucher:
> > > > On Tue, Jul 13, 2021 at 2:57 AM Christian K=F6nig
> > > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > > > =

> > > > > Am 13.07.21 um 00:06 schrieb Felix Kuehling:
> > > > > > KFD Thunk maps invisible VRAM BOs with PROT_NONE, MAP_PRIVATE.
> > > > > > is_cow_mapping returns true for these mappings. Add a check for
> > > > > > vm_flags & VM_WRITE to avoid mmap failures on private read-only=
 or
> > > > > > PROT_NONE mappings.
> > > > > > =

> > > > > > v2: protect against mprotect making a mapping writable after th=
e fact
> > > > > > v3: update driver-specific vm_operations_structs
> > > > > > =

> > > > > > Fixes: f91142c62161 ("drm/ttm: nuke VM_MIXEDMAP on BO mappings =
v3")
> > > > > > Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> > > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > Reviewed-by: Christian K=F6nig <christian.koenig@amd.com>
> > > > Are you planning to push this to drm-misc?
> > > Yes, just didn't found time yesterday.
> > This is pushed to the wrong tree drm-misc-next-fixes, should have been
> > in drm-misc-fixes. Please be careful with that because every time that
> > goes wrong the script gets confused about which the current tree is,
> > and pushes the wrong tree to linux-next branches.
> > =

> > I'm going to hard-reset drm-misc-next-fixes now and hope that's good
> > enough to fix things up (since Thomas is not around all the time for
> > this merge window).
> =

> STOP! I'm about to push a revert for this patch.
> =

> And yes that was pushed to the wrong branch, but it turned out that this =
was
> fortunate since the patch doesn't work correctly.

Well I just hard-reset, so you can push the right patch to the right
branch now. The trouble is that outside of the merge window no one is
allowed to push to drm-misc-next-fixes. If you do, then dim pushes
drm-misc-next-fixes to for-linux-next instead of drm-misc-next, and we
have bad surprises.

Which unfortunately happens like every merge window a few times and always
takes a few days/weeks to get caught.
-Danie

> =

> Christian.
> =

> > -Daniel
> > =

> > =

> > > Christian.
> > > =

> > > > Alex
> > > > =

> > > > > > ---
> > > > > >     drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c  |  3 ++-
> > > > > >     drivers/gpu/drm/nouveau/nouveau_gem.c    |  3 ++-
> > > > > >     drivers/gpu/drm/radeon/radeon_gem.c      |  3 ++-
> > > > > >     drivers/gpu/drm/ttm/ttm_bo_vm.c          | 14 +++++++++++++-
> > > > > >     drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c |  1 +
> > > > > >     include/drm/ttm/ttm_bo_api.h             |  4 ++++
> > > > > >     6 files changed, 24 insertions(+), 4 deletions(-)
> > > > > > =

> > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_gem.c
> > > > > > index b3404c43a911..1aa750a6a5d2 100644
> > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > > > > > @@ -79,7 +79,8 @@ static const struct vm_operations_struct amdg=
pu_gem_vm_ops =3D {
> > > > > >         .fault =3D amdgpu_gem_fault,
> > > > > >         .open =3D ttm_bo_vm_open,
> > > > > >         .close =3D ttm_bo_vm_close,
> > > > > > -     .access =3D ttm_bo_vm_access
> > > > > > +     .access =3D ttm_bo_vm_access,
> > > > > > +     .mprotect =3D ttm_bo_vm_mprotect
> > > > > >     };
> > > > > > =

> > > > > >     static void amdgpu_gem_object_free(struct drm_gem_object *g=
obj)
> > > > > > diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gp=
u/drm/nouveau/nouveau_gem.c
> > > > > > index 5b27845075a1..164ea564bb7a 100644
> > > > > > --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> > > > > > +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> > > > > > @@ -70,7 +70,8 @@ static const struct vm_operations_struct nouv=
eau_ttm_vm_ops =3D {
> > > > > >         .fault =3D nouveau_ttm_fault,
> > > > > >         .open =3D ttm_bo_vm_open,
> > > > > >         .close =3D ttm_bo_vm_close,
> > > > > > -     .access =3D ttm_bo_vm_access
> > > > > > +     .access =3D ttm_bo_vm_access,
> > > > > > +     .mprotect =3D ttm_bo_vm_mprotect
> > > > > >     };
> > > > > > =

> > > > > >     void
> > > > > > diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/=
drm/radeon/radeon_gem.c
> > > > > > index 458f92a70887..c19ad07eb7b5 100644
> > > > > > --- a/drivers/gpu/drm/radeon/radeon_gem.c
> > > > > > +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> > > > > > @@ -77,7 +77,8 @@ static const struct vm_operations_struct rade=
on_gem_vm_ops =3D {
> > > > > >         .fault =3D radeon_gem_fault,
> > > > > >         .open =3D ttm_bo_vm_open,
> > > > > >         .close =3D ttm_bo_vm_close,
> > > > > > -     .access =3D ttm_bo_vm_access
> > > > > > +     .access =3D ttm_bo_vm_access,
> > > > > > +     .mprotect =3D ttm_bo_vm_mprotect
> > > > > >     };
> > > > > > =

> > > > > >     static void radeon_gem_object_free(struct drm_gem_object *g=
obj)
> > > > > > diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/=
ttm/ttm_bo_vm.c
> > > > > > index f56be5bc0861..fb325bad5db6 100644
> > > > > > --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > > > > > +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> > > > > > @@ -542,17 +542,29 @@ int ttm_bo_vm_access(struct vm_area_struc=
t *vma, unsigned long addr,
> > > > > >     }
> > > > > >     EXPORT_SYMBOL(ttm_bo_vm_access);
> > > > > > =

> > > > > > +int ttm_bo_vm_mprotect(struct vm_area_struct *vma, unsigned lo=
ng start,
> > > > > > +                    unsigned long end, unsigned long newflags)
> > > > > > +{
> > > > > > +     /* Enforce no COW since would have really strange behavio=
r with it. */
> > > > > > +     if (is_cow_mapping(newflags) && (newflags & VM_WRITE))
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(ttm_bo_vm_mprotect);
> > > > > > +
> > > > > >     static const struct vm_operations_struct ttm_bo_vm_ops =3D {
> > > > > >         .fault =3D ttm_bo_vm_fault,
> > > > > >         .open =3D ttm_bo_vm_open,
> > > > > >         .close =3D ttm_bo_vm_close,
> > > > > >         .access =3D ttm_bo_vm_access,
> > > > > > +     .mprotect =3D ttm_bo_vm_mprotect,
> > > > > >     };
> > > > > > =

> > > > > >     int ttm_bo_mmap_obj(struct vm_area_struct *vma, struct ttm_=
buffer_object *bo)
> > > > > >     {
> > > > > >         /* Enforce no COW since would have really strange behav=
ior with it. */
> > > > > > -     if (is_cow_mapping(vma->vm_flags))
> > > > > > +     if (is_cow_mapping(vma->vm_flags) && (vma->vm_flags & VM_=
WRITE))
> > > > > >                 return -EINVAL;
> > > > > > =

> > > > > >         ttm_bo_get(bo);
> > > > > > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c b/drivers=
/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> > > > > > index e6b1f98ec99f..e4bf7dc99320 100644
> > > > > > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> > > > > > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ttm_glue.c
> > > > > > @@ -61,6 +61,7 @@ int vmw_mmap(struct file *filp, struct vm_are=
a_struct *vma)
> > > > > >                 .fault =3D vmw_bo_vm_fault,
> > > > > >                 .open =3D ttm_bo_vm_open,
> > > > > >                 .close =3D ttm_bo_vm_close,
> > > > > > +             .mprotect =3D ttm_bo_vm_mprotect,
> > > > > >     #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > > >                 .huge_fault =3D vmw_bo_vm_huge_fault,
> > > > > >     #endif
> > > > > > diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm=
_bo_api.h
> > > > > > index f681bbdbc698..40eb95875355 100644
> > > > > > --- a/include/drm/ttm/ttm_bo_api.h
> > > > > > +++ b/include/drm/ttm/ttm_bo_api.h
> > > > > > @@ -605,6 +605,10 @@ void ttm_bo_vm_close(struct vm_area_struct=
 *vma);
> > > > > > =

> > > > > >     int ttm_bo_vm_access(struct vm_area_struct *vma, unsigned l=
ong addr,
> > > > > >                      void *buf, int len, int write);
> > > > > > +
> > > > > > +int ttm_bo_vm_mprotect(struct vm_area_struct *vma, unsigned lo=
ng start,
> > > > > > +                    unsigned long end, unsigned long newflags);
> > > > > > +
> > > > > >     bool ttm_bo_delayed_delete(struct ttm_device *bdev, bool re=
move_all);
> > > > > > =

> > > > > >     vm_fault_t ttm_bo_vm_dummy_page(struct vm_fault *vmf, pgpro=
t_t prot);
> > =

> =


-- =

Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
