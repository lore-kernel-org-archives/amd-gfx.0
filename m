Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8B8C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 15:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE21810E926;
	Thu, 16 Dec 2021 15:13:15 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD15C10E961
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 15:13:14 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id r26so36839002oiw.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 07:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mn9pnd8B2JeTjOefCCTsVNs1YtbJLwmGaONw3usynWQ=;
 b=ONdrKWe3tHIDMRJP+JN2aW5UqP3msa3vZUpjB+wTNiV03vPEkwlE6Hi9ofI7MNoR5E
 xcdEk2XCvYRzTmw6HajZYSMyVZm4N3CmmUxiwhay3N228UjVc8LWuX9PLR+0AdurfWNN
 oseFkhrXkIQu/ecwBcWOeweqkiOm57Gfj+CtqqQsFYUHL2uBB7RUakFFix60gAlblOso
 H/OX+lwH1RvjAPSMMiURchlcx+K387IzwCjcEp0UC3AuQjA/xFay0NomzyR3d9j1HcGY
 fGGJWNi5w+FbvFgaKLDv6P0W5JJcNd108E9atVfK0BJnvBpbUbQowfa/kduaB2Bft0CM
 JE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mn9pnd8B2JeTjOefCCTsVNs1YtbJLwmGaONw3usynWQ=;
 b=i3qRArkCkHFevqlwtIk3hXEr4K+meNQJ3zp7nebz+z+hKUbnjSfemR4pZf2jW6IhB6
 xkE4HsHgCTnDJ6JQVL3cVcKhKfl7e5IPMBlkaZeaGEwwiVJp8QJIUP/AeeLPNg0fWMH2
 l/N9KA/qSXOXp6PhIMgAMgjVYvaFpjdFfeDkcSHauUh+p8Gzhi+Mv0H/FIx7/gnhJKx4
 PbJr8gBbGilxSKcNozJEEVmMjtJxUCjvWcTWiIsRlZZ73IJsSpKC0wd8LXXe+iKNWOjL
 tZw4xTnQfbniqEHJ213i0FYWET0lZGqg5WamMA0Yu8cw+HdMXvQE8iZXcmkRSG3FWHkT
 V5pA==
X-Gm-Message-State: AOAM531MNL4HhwyMF+hha9nX7kSPL8i4iXsAQihut23JS/9W66SOS2zZ
 NqvlDrDu03/G21jmiYorFBYQyEnzZO+A015tS3M=
X-Google-Smtp-Source: ABdhPJwxJ9t6jSk3e61fQaQDbBI5lnGat3RKrXYhgl9FHzEfCHj0sDMn1gMLNpkH6kA3bHycEBf0QFBv4udJg1GHGhA=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr4393150oib.120.1639667593945; 
 Thu, 16 Dec 2021 07:13:13 -0800 (PST)
MIME-Version: 1.0
References: <20211216141418.299554-1-alexander.deucher@amd.com>
 <f3482e11-c64e-2a4e-94f1-7906d2611ff4@gmail.com>
In-Reply-To: <f3482e11-c64e-2a4e-94f1-7906d2611ff4@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Dec 2021 10:13:02 -0500
Message-ID: <CADnq5_OEmJcT_S5C+JhZvpU=oQ_CMaPU1WiTbW4tUeFOj6S=KQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/UAPI: add new CTX OP to get/set stable
 pstates
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 16, 2021 at 9:24 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
>
>
> Am 16.12.21 um 15:14 schrieb Alex Deucher:
> > Add a new CTX ioctl operation to set stable pstates for profiling.
> > When creating traces for tools like RGP or using SPM or doing
> > performance profiling, it's required to enable a special
> > stable profiling power state on the GPU.  These profiling
> > states set fixed clocks and disable certain other power
> > features like powergating which may impact the results.
> >
> > Historically, these profiling pstates were enabled via sysfs,
> > but this adds an interface to enable it via the CTX ioctl
> > from the application.  Since the power state is global
> > only one application can set it at a time, so if multiple
> > applications try and use it only the first will get it,
> > the ioctl will return -EBUSY for others.  The sysfs interface
> > will override whatever has been set by this interface.
> >
> > Mesa MR: https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/207
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 145 ++++++++++++++++++++=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   1 +
> >   drivers/gpu/drm/amd/pm/amdgpu_pm.c         |   7 +
> >   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |   3 +
> >   include/uapi/drm/amdgpu_drm.h              |  17 ++-
> >   6 files changed, 171 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ctx.c
> > index 468003583b2a..327cf308c2ab 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -237,6 +237,7 @@ static int amdgpu_ctx_init(struct amdgpu_device *ad=
ev,
> >       ctx->vram_lost_counter =3D atomic_read(&adev->vram_lost_counter);
> >       ctx->init_priority =3D priority;
> >       ctx->override_priority =3D AMDGPU_CTX_PRIORITY_UNSET;
> > +     ctx->stable_pstate =3D AMDGPU_CTX_STABLE_PSTATE_NONE;
> >
> >       return 0;
> >   }
> > @@ -255,6 +256,102 @@ static void amdgpu_ctx_fini_entity(struct amdgpu_=
ctx_entity *entity)
> >       kfree(entity);
> >   }
> >
> > +static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
> > +                                     u32 *stable_pstate)
> > +{
> > +     struct amdgpu_device *adev =3D ctx->adev;
> > +     const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> > +     enum amd_dpm_forced_level current_level;
> > +
> > +     if (!ctx)
> > +             return -EINVAL;
> > +
> > +     if (pp_funcs->get_performance_level)
> > +             current_level =3D amdgpu_dpm_get_performance_level(adev);
> > +     else
> > +             current_level =3D adev->pm.dpm.forced_level;
> > +
> > +     switch (current_level) {
> > +     case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
> > +             *stable_pstate =3D AMDGPU_CTX_STABLE_PSTATE_STANDARD;
> > +             break;
> > +     case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
> > +             *stable_pstate =3D AMDGPU_CTX_STABLE_PSTATE_MIN_SCLK;
> > +             break;
> > +     case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
> > +             *stable_pstate =3D AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK;
> > +             break;
> > +     case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
> > +             *stable_pstate =3D AMDGPU_CTX_STABLE_PSTATE_PEAK;
> > +             break;
> > +     default:
> > +             *stable_pstate =3D AMDGPU_CTX_STABLE_PSTATE_NONE;
> > +             break;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
> > +                                     u32 stable_pstate)
> > +{
> > +     struct amdgpu_device *adev =3D ctx->adev;
> > +     const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_funcs;
> > +     enum amd_dpm_forced_level level, current_level;
> > +     int r =3D 0;
>
> I would avoid initializing the return value and rather set it below
> after everything worked out.

Will fix.

>
> > +
> > +     if (!ctx)
> > +             return -EINVAL;
> > +
> > +     mutex_lock(&adev->pm.stable_pstate_ctx_lock);
> > +     if (adev->pm.stable_pstate_ctx && adev->pm.stable_pstate_ctx !=3D=
 ctx) {
> > +             r =3D -EBUSY;
> > +             goto done;
> > +     }
> > +
> > +     switch (stable_pstate) {
> > +     case AMDGPU_CTX_STABLE_PSTATE_NONE:
> > +             level =3D AMD_DPM_FORCED_LEVEL_AUTO;
> > +             break;
> > +     case AMDGPU_CTX_STABLE_PSTATE_STANDARD:
> > +             level =3D AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
> > +             break;
> > +     case AMDGPU_CTX_STABLE_PSTATE_MIN_SCLK:
> > +             level =3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
> > +             break;
> > +     case AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK:
> > +             level =3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
> > +             break;
> > +     case AMDGPU_CTX_STABLE_PSTATE_PEAK:
> > +             level =3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
> > +             break;
> > +     default:
> > +             r =3D -EINVAL;
> > +             goto done;
> > +     }
> > +
> > +     if (pp_funcs->get_performance_level)
> > +             current_level =3D amdgpu_dpm_get_performance_level(adev);
> > +     else
> > +             current_level =3D adev->pm.dpm.forced_level;
>
> Mhm, that looks strongly like it doesn't belong into the ctx code.
>
> Didn't Evan had some patches to clean that up?

yeah, will rework this once Evan's patches land.

Alex

>
> Apart from those two nit picks looks good to me,
> Christian.
>
> > +
> > +     if ((current_level !=3D level) && pp_funcs->force_performance_lev=
el) {
> > +             mutex_lock(&adev->pm.mutex);
> > +             r =3D amdgpu_dpm_force_performance_level(adev, level);
> > +             if (!r)
> > +                     adev->pm.dpm.forced_level =3D level;
> > +             mutex_unlock(&adev->pm.mutex);
> > +     }
> > +
> > +     if (level =3D=3D AMD_DPM_FORCED_LEVEL_AUTO)
> > +             adev->pm.stable_pstate_ctx =3D NULL;
> > +     else
> > +             adev->pm.stable_pstate_ctx =3D ctx;
> > +done:
> > +     mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
> > +
> > +     return r;
> > +}
> > +
> >   static void amdgpu_ctx_fini(struct kref *ref)
> >   {
> >       struct amdgpu_ctx *ctx =3D container_of(ref, struct amdgpu_ctx, r=
efcount);
> > @@ -270,7 +367,7 @@ static void amdgpu_ctx_fini(struct kref *ref)
> >                       ctx->entities[i][j] =3D NULL;
> >               }
> >       }
> > -
> > +     amdgpu_ctx_set_stable_pstate(ctx, AMDGPU_CTX_STABLE_PSTATE_NONE);
> >       mutex_destroy(&ctx->lock);
> >       kfree(ctx);
> >   }
> > @@ -467,11 +564,41 @@ static int amdgpu_ctx_query2(struct amdgpu_device=
 *adev,
> >       return 0;
> >   }
> >
> > +
> > +
> > +static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
> > +                                 struct amdgpu_fpriv *fpriv, uint32_t =
id,
> > +                                 bool set, u32 *stable_pstate)
> > +{
> > +     struct amdgpu_ctx *ctx;
> > +     struct amdgpu_ctx_mgr *mgr;
> > +     int r;
> > +
> > +     if (!fpriv)
> > +             return -EINVAL;
> > +
> > +     mgr =3D &fpriv->ctx_mgr;
> > +     mutex_lock(&mgr->lock);
> > +     ctx =3D idr_find(&mgr->ctx_handles, id);
> > +     if (!ctx) {
> > +             mutex_unlock(&mgr->lock);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (set)
> > +             r =3D amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
> > +     else
> > +             r =3D amdgpu_ctx_get_stable_pstate(ctx, stable_pstate);
> > +
> > +     mutex_unlock(&mgr->lock);
> > +     return r;
> > +}
> > +
> >   int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
> >                    struct drm_file *filp)
> >   {
> >       int r;
> > -     uint32_t id;
> > +     uint32_t id, stable_pstate;
> >       int32_t priority;
> >
> >       union drm_amdgpu_ctx *args =3D data;
> > @@ -500,6 +627,20 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void =
*data,
> >       case AMDGPU_CTX_OP_QUERY_STATE2:
> >               r =3D amdgpu_ctx_query2(adev, fpriv, id, &args->out);
> >               break;
> > +     case AMDGPU_CTX_OP_GET_STABLE_PSTATE:
> > +             if (args->in.flags)
> > +                     return -EINVAL;
> > +             r =3D amdgpu_ctx_stable_pstate(adev, fpriv, id, false, &s=
table_pstate);
> > +             args->out.pstate.flags =3D stable_pstate;
> > +             break;
> > +     case AMDGPU_CTX_OP_SET_STABLE_PSTATE:
> > +             if (args->in.flags & ~AMDGPU_CTX_STABLE_PSTATE_FLAGS_MASK=
)
> > +                     return -EINVAL;
> > +             stable_pstate =3D args->in.flags & AMDGPU_CTX_STABLE_PSTA=
TE_FLAGS_MASK;
> > +             if (stable_pstate > AMDGPU_CTX_STABLE_PSTATE_PEAK)
> > +                     return -EINVAL;
> > +             r =3D amdgpu_ctx_stable_pstate(adev, fpriv, id, true, &st=
able_pstate);
> > +             break;
> >       default:
> >               return -EINVAL;
> >       }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ctx.h
> > index a44b8b8ed39c..142f2f87d44c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> > @@ -53,6 +53,7 @@ struct amdgpu_ctx {
> >       atomic_t                        guilty;
> >       unsigned long                   ras_counter_ce;
> >       unsigned long                   ras_counter_ue;
> > +     uint32_t                        stable_pstate;
> >   };
> >
> >   struct amdgpu_ctx_mgr {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index a24b4c374188..e0fc943e9f9b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3486,6 +3486,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
> >       init_rwsem(&adev->reset_sem);
> >       mutex_init(&adev->psp.mutex);
> >       mutex_init(&adev->notifier_lock);
> > +     mutex_init(&adev->pm.stable_pstate_ctx_lock);
> >
> >       r =3D amdgpu_device_init_apu_flags(adev);
> >       if (r)
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/p=
m/amdgpu_pm.c
> > index 082539c70fd4..bcbc3190ed47 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -390,12 +390,14 @@ static ssize_t amdgpu_set_power_dpm_force_perform=
ance_level(struct device *dev,
> >               return -EINVAL;
> >       }
> >
> > +     mutex_lock(&adev->pm.stable_pstate_ctx_lock);
> >       if (pp_funcs->force_performance_level) {
> >               mutex_lock(&adev->pm.mutex);
> >               if (adev->pm.dpm.thermal_active) {
> >                       mutex_unlock(&adev->pm.mutex);
> >                       pm_runtime_mark_last_busy(ddev->dev);
> >                       pm_runtime_put_autosuspend(ddev->dev);
> > +                     mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
> >                       return -EINVAL;
> >               }
> >               ret =3D amdgpu_dpm_force_performance_level(adev, level);
> > @@ -403,6 +405,7 @@ static ssize_t amdgpu_set_power_dpm_force_performan=
ce_level(struct device *dev,
> >                       mutex_unlock(&adev->pm.mutex);
> >                       pm_runtime_mark_last_busy(ddev->dev);
> >                       pm_runtime_put_autosuspend(ddev->dev);
> > +                     mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
> >                       return -EINVAL;
> >               } else {
> >                       adev->pm.dpm.forced_level =3D level;
> > @@ -412,6 +415,10 @@ static ssize_t amdgpu_set_power_dpm_force_performa=
nce_level(struct device *dev,
> >       pm_runtime_mark_last_busy(ddev->dev);
> >       pm_runtime_put_autosuspend(ddev->dev);
> >
> > +     /* override whatever a user ctx may have set */
> > +     adev->pm.stable_pstate_ctx =3D NULL;
> > +     mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
> > +
> >       return count;
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/=
amd/pm/inc/amdgpu_dpm.h
> > index c464a045000d..629cb1ec6c03 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > @@ -468,6 +468,9 @@ struct amdgpu_pm {
> >        * 0 =3D disabled (default), otherwise enable corresponding debug=
 mode
> >        */
> >       uint32_t                smu_debug_mask;
> > +
> > +     struct mutex            stable_pstate_ctx_lock;
> > +     struct amdgpu_ctx       *stable_pstate_ctx;
> >   };
> >
> >   #define R600_SSTU_DFLT                               0
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index 0b94ec7b73e7..7f01f9830bf8 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -206,6 +206,8 @@ union drm_amdgpu_bo_list {
> >   #define AMDGPU_CTX_OP_FREE_CTX      2
> >   #define AMDGPU_CTX_OP_QUERY_STATE   3
> >   #define AMDGPU_CTX_OP_QUERY_STATE2  4
> > +#define AMDGPU_CTX_OP_GET_STABLE_PSTATE      5
> > +#define AMDGPU_CTX_OP_SET_STABLE_PSTATE      6
> >
> >   /* GPU reset status */
> >   #define AMDGPU_CTX_NO_RESET         0
> > @@ -238,10 +240,18 @@ union drm_amdgpu_bo_list {
> >   #define AMDGPU_CTX_PRIORITY_HIGH        512
> >   #define AMDGPU_CTX_PRIORITY_VERY_HIGH   1023
> >
> > +/* select a stable profiling pstate for perfmon tools */
> > +#define AMDGPU_CTX_STABLE_PSTATE_FLAGS_MASK  0xf
> > +#define AMDGPU_CTX_STABLE_PSTATE_NONE  0
> > +#define AMDGPU_CTX_STABLE_PSTATE_STANDARD  1
> > +#define AMDGPU_CTX_STABLE_PSTATE_MIN_SCLK  2
> > +#define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
> > +#define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
> > +
> >   struct drm_amdgpu_ctx_in {
> >       /** AMDGPU_CTX_OP_* */
> >       __u32   op;
> > -     /** For future use, no flags defined so far */
> > +     /** Flags */
> >       __u32   flags;
> >       __u32   ctx_id;
> >       /** AMDGPU_CTX_PRIORITY_* */
> > @@ -262,6 +272,11 @@ union drm_amdgpu_ctx_out {
> >                       /** Reset status since the last call of the ioctl=
. */
> >                       __u32   reset_status;
> >               } state;
> > +
> > +             struct {
> > +                     __u32   flags;
> > +                     __u32   _pad;
> > +             } pstate;
> >   };
> >
> >   union drm_amdgpu_ctx {
>
