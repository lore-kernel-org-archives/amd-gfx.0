Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7628BC43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 13:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA0910E5EF;
	Wed,  8 Jul 2026 13:39:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HIHwRioW";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CD5110E5EF
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 13:39:42 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-38115bbb83dso84839a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 06:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783517982; cv=none;
 d=google.com; s=arc-20260327;
 b=MfoKipEu5H35TB5EIltg5GNwTWBf5+uHpbS+a5j+OciswkeCTU/5sCq+1mJSKhYzw2
 fITIZaEa32RTXx6kmHFZ8ZvqXR2fDMpUO/Oyldz2vDhYz+2BP5RCbkfVRZNbVXGIYSuh
 /yri9cTkCxTehroEtt4ghDUosLYHJMccLd4wpVJCNUgq8nVHtyL8Meh0WEP2p1Yyh+yB
 kdl0LW2KDap/vIkTP2+DgfGuLYv9ghjGAmw9ymCKkZ9lOC65WOXnWzBcajfnzXIOYdOO
 bE+nNvOIi4TERfu+GTsfOg2jEINCjR/hHGNJTtPdPbJES+QFpOmofbai8tKmi9GO+LkR
 Yaiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TeN4q6If/rnBXJuV0jsut6YSkKXgnCtyXya/a1o2jkQ=;
 fh=evqTgW+tALMvdpXfYLTZyt5ZywD+/VBUVQ8ZNaSLclU=;
 b=ElZ9Xm7bIyDDl3EjgDpnOxsJVpoAnSN+UQQMUFCuBe5iZQ8YM2RPLOC8jYKH4kfAVu
 yLLbSXIMXtGM5rrmWLDB8zEuTCIReFBH8QsHIpDb3XT1lcRHEBZ0925MTvx4yhhXU5Ay
 0CSoEIGDDilG51/J2yrCiI+Yh1PpFVnrn/YvkdN09bnB5EeFsJr7vUVeRov3AvTq5YJK
 pq90jQ1wCyya7aYY6Bey4uorf+62v6zDzt24v/1n8AJeAnbMeJJ07f/bCfUc7gWn7VPh
 Uir162S3Ve+SRHVs7wwXuCR0gRAHulvAwYHZV/2wvSWVZrhR+3xjv1l06gbfcWvZdNnu
 qqMA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783517982; x=1784122782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TeN4q6If/rnBXJuV0jsut6YSkKXgnCtyXya/a1o2jkQ=;
 b=HIHwRioW9MGyykKJLri2V8/T/IdeLgNtPEdf+l3KJwuJKp2tPNSnl73hyn/LckPS7c
 3kyI2k73yACktmnc72wwDjXAdjZffMGiKRa9La3xp4B4p5w6udOUXB4TVh2+bL0DRhSS
 hTBR6xI42ZmVDGPN8gZjXFt8PQ6FIeiS2C7q4MOcaTXeGTUoGdcrq4gTh6rIz3KcXFKH
 kNrkzCJNcldXdRlkIuu5zllgdDkV5TxbQ15tc7A3g3KHCYH3Cp2CURJ4ZToZMR+22c12
 RgIiZKfvxKR6KfZvdBhMUeg9kKqbPdz6CAK+YtWD5ZdE3A7ZM1VvJvfGj11iBI92IelA
 FA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783517982; x=1784122782;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TeN4q6If/rnBXJuV0jsut6YSkKXgnCtyXya/a1o2jkQ=;
 b=BQyQkQwXGojoir0VMM1EwzD3HDeU7+xb7Zv6J1wJKKRawaS8zTeqE2fFvaK+xCS+hS
 tHFy4VG0uwvzvyHLajRIuvcPOp6qht+Elrdkz6I8OEzQgEULJVeWkAnhrt77PKwqAu+L
 J3QjeqYYkvi3UCDY/ES6/X6wRkbJtOWCls4qUWi8Zum/6oQAnSdOouj+EsWFX5IV/iHg
 lc9JP1wMZqbL2gistKx+/oUusw5+rD/oe/LMidkgsn3VPaIZmZ57Q9vMAZ1n3+wn7bP2
 UAKhu7GPHkTJDDWtYeVOmBg76bPt+VJFzbpM5yLWKXMvjJWaddui+zXUO+xIACwYRCXq
 +yuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RocLfXNAKs3BjEfcwzGFcr80dcR+mlVMkNQMVoSF6h2Cy+YwB7M3BwnmvvujzEleLX5OHxAFJYh@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDtguSthBD2pIUXhsTXk+XEWYuXfxo3KBWP+aiinHDnn6AjE6C
 PUG6pANfW/aY5Q2rYvGDuReDwutvpcdbndIiz1ssDgp/SkxPAl0MHe0S2lLQJj+LV+zfzITKHmZ
 mKeAiYEqwxYTH3Il+m+fk6645MwGvJoo=
X-Gm-Gg: AfdE7cl+epSzRtZ3pP+2lRZhCqMooZMgCgpcQS0nw6DVHGZ8JHbi4AXGKID9kvxsYB3
 RosQ8rdo1vMdurMxzDdvOol1O+uQ6a6mxTAFMfLq9eteNcTre8KmL+O1BroyoGljGWXegIektRm
 EBF8YearLpq3MrCILmlkDvcR1B7tEvQz26zTUJEPMxmuXK3kdxQczXcgalA8FyvaVIM8UB1k006
 VlXtykV8AOwKnvjKfjTxHT1lB51OAQ0OJb3ybankKBUXZ5RL4qrB9cOZ3aZbwpBjSglp1Kndxp6
 F9CPdZr+PQpFoDsec5dQTVqybbFTKHom0mvu8XCIiWk+LP9R8/U2y/Gi9MM=
X-Received: by 2002:a17:90b:17ca:b0:381:abcc:c8d8 with SMTP id
 98e67ed59e1d1-3894014e3fbmr2330872a91.1.1783517982031; Wed, 08 Jul 2026
 06:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260627043801.1025055-1-geoffrey.mcrae@amd.com>
 <20260627055720.1543432-1-geoffrey.mcrae@amd.com>
 <db4d886f-7310-42a8-a480-5b4c4c99e4de@amd.com>
In-Reply-To: <db4d886f-7310-42a8-a480-5b4c4c99e4de@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2026 09:39:29 -0400
X-Gm-Features: AVVi8CfdoxxGAW7qhi1nkU_uzhwKNlDzQYtcJNL4gC13VCJZ90hsqUIaYxFbjfc
Message-ID: <CADnq5_NDZqV4ihd70PBgXOrfRfzfYrgz948-FnNh+8tpvn7kxQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: remove gfx sysfs files on device unbind
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Geoffrey McRae <geoffrey.mcrae@amd.com>, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Mon, Jun 29, 2026 at 6:01=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 6/27/26 07:57, Geoffrey McRae wrote:
> > Fix more sysfs file duplication errors when reinitializing the device:
> >
> >   sysfs: cannot create duplicate filename '.../enforce_isolation'
> >   sysfs: cannot create duplicate filename '.../sdma_reset_mask'
> >   sysfs: cannot create duplicate filename '.../vcn_reset_mask'
> >   sysfs: cannot create duplicate filename '.../jpeg_reset_mask'
> >   sysfs: cannot create duplicate filename '.../vpe_reset_mask'
> >   sysfs: cannot create duplicate filename '.../current_memory_partition=
'
> >   sysfs: cannot create duplicate filename '.../available_memory_partiti=
on'
> >
> > Fix this by:
> >   - improve amdgpu_gfx_sysfs_init error unwinding so partially-created
> >     gfx sysfs files are removed on registration failure.
> >   - added adev->gfx.sysfs_registered tracking so gfx sysfs cleanup is
> >     idempotent when harware teardown runs before the existing software
> >     teardown cleanup path.
> >   - calling amdgpu_gfx_sysfs_fini, amdgpu_sdma_sysfs_reset_mask_fini,
> >     amdgpu_vcn_sysfs_reset_mask_fini, amdgpu_jpeg_sysfs_reset_mask_fini=
,
> >     amdgpu_vpe_sysfs_reset_mask_fini and amdgpu_gmc_sysfs_fini from
> >     amdgpu_device_sys_interface_fini
> >
> > Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Alex can you take a look at this?
>
> In general the coding seems correct, but Greg usually insists that we use=
 the managed sysfs functions which remove stuff automatically on driver unb=
ind.
>
> But if I'm not completely mistaken that doesn't work here because the dev=
ice structure is not released before all userspace refs drop.
>
> If the device is re-created before that happens we run into the error abo=
ve.

I think the proper fix for this is to properly unwind in
amdgpu_device_ip_init().  If sw_init() fails, we should goto a proper
unwind loop which calls sw_fini() for all IPs where status.sw =3D=3D true,
etc.

Alex

>
> Regards,
> Christian.
>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  8 ++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 32 +++++++++++++++++-----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  2 ++
> >  3 files changed, 35 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 70d07ca187a3..c0a22d2411f2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3674,6 +3674,14 @@ static int amdgpu_device_sys_interface_init(stru=
ct amdgpu_device *adev)
> >
> >  static void amdgpu_device_sys_interface_fini(struct amdgpu_device *ade=
v)
> >  {
> > +     amdgpu_gfx_sysfs_fini(adev);
> > +     amdgpu_sdma_sysfs_reset_mask_fini(adev);
> > +     amdgpu_vcn_sysfs_reset_mask_fini(adev);
> > +     amdgpu_jpeg_sysfs_reset_mask_fini(adev);
> > +     amdgpu_vpe_sysfs_reset_mask_fini(adev);
> > +     if (amdgpu_is_multi_aid(adev))
> > +             amdgpu_gmc_sysfs_fini(adev);
> > +
> >       if (adev->pm.sysfs_initialized)
> >               amdgpu_pm_sysfs_fini(adev);
> >       if (adev->ucode_sysfs_en)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 982b41606d48..ab37c4a9f415 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -2175,6 +2175,8 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *a=
dev)
> >  {
> >       int r;
> >
> > +     adev->gfx.sysfs_registered =3D false;
> > +
> >       r =3D amdgpu_gfx_sysfs_xcp_init(adev);
> >       if (r) {
> >               dev_err(adev->dev, "failed to create xcp sysfs files");
> > @@ -2182,23 +2184,39 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device =
*adev)
> >       }
> >
> >       r =3D amdgpu_gfx_sysfs_isolation_shader_init(adev);
> > -     if (r)
> > +     if (r) {
> >               dev_err(adev->dev, "failed to create isolation sysfs file=
s");
> > +             goto err_isolation_shader;
> > +     }
> >
> >       r =3D amdgpu_gfx_sysfs_reset_mask_init(adev);
> > -     if (r)
> > +     if (r) {
> >               dev_err(adev->dev, "failed to create reset mask sysfs fil=
es");
> > +             goto err_reset_mask;
> > +     }
> >
> > +     adev->gfx.sysfs_registered =3D true;
> > +
> > +     return 0;
> > +
> > +err_reset_mask:
> > +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
> > +     amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> > +err_isolation_shader:
> > +     amdgpu_gfx_sysfs_xcp_fini(adev);
> >       return r;
> >  }
> >
> >  void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
> >  {
> > -     if (adev->dev->kobj.sd) {
> > -             amdgpu_gfx_sysfs_xcp_fini(adev);
> > -             amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> > -             amdgpu_gfx_sysfs_reset_mask_fini(adev);
> > -     }
> > +     if (!adev->gfx.sysfs_registered)
> > +             return;
> > +
> > +     amdgpu_gfx_sysfs_xcp_fini(adev);
> > +     amdgpu_gfx_sysfs_isolation_shader_fini(adev);
> > +     amdgpu_gfx_sysfs_reset_mask_fini(adev);
> > +
> > +     adev->gfx.sysfs_registered =3D false;
> >  }
> >
> >  static void amdgpu_gfx_reset_start_compute_scheds(struct amdgpu_device=
 *adev,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.h
> > index aefd4f03b443..df7ce026bfa9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -477,6 +477,8 @@ struct amdgpu_gfx {
> >       struct amdgpu_irq_src           rlc_poison_irq;
> >       struct sq_work                  sq_work;
> >
> > +     bool                            sysfs_registered;
> > +
> >       /* gfx status */
> >       uint32_t                        gfx_current_status;
> >       /* ce ram size*/
>
