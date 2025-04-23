Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F17C369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 13:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF3F10E6AD;
	Wed, 23 Apr 2025 13:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X0y9M8QV";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9260A10E6AD
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 13:48:49 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b0ec7f3a205so285308a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 06:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745416129; x=1746020929; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vVAfGIc63CIWO9pd7JpzNLwSs6/YsJYkFTdIIwA+Yo=;
 b=X0y9M8QVBhCswyEhd649D3v72y5GtR7PO6nHXsznZVT8l1VUOkiO0XHVMNVz0fxxCo
 mdbikL6LtfisWp2tv4lEiF9F4Mk+cHfMgHBGfzs5slY0UkAvPuzCk1p5ZHCVvr9rvdY4
 sibREYx9LxqKROZSk9tWlMDjpXEoweyqYK1c6j+b3m+mWAeSMyMarD597Cb3SCtDyjrC
 E92RGXZe5Xk1gyTIsSBCjg9SmG5R7CufzzEiC3OCmrphn/6MP5G/WPUziwtoiJZrTFQ9
 lZ6rvFsVUkpQ01hYYL5iwFSA2G0tbYan9KGeN10m0Nb+sBFUC5gBwIHN2H7PMCgOMNxY
 vPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745416129; x=1746020929;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vVAfGIc63CIWO9pd7JpzNLwSs6/YsJYkFTdIIwA+Yo=;
 b=Fuk2YIc4o2Dt1ZfWwnh3FglfVepw1AA5zOj8MDKAL3TqKgL69IB9EzVj66jjowPbg+
 1bjh/UGA7fk/0h68XkL/XFe0XasCtsLzewuGKKPchfC8dUJj4MfMjMqCijp+cxTFkLVb
 R/6TOQRhxMWYcbVQJOhFIaDBZzN8C/7XY3CFuY6Itgd6bQqNnR6az1/EHtS8UI9OYCEI
 y9jOK1ASs9O7uupX56rn6sJvZls4uTGzVkCRXpU24BDmxPsy9xfXcSgaRHAck5ksyytE
 QdUEgB8FUl3krZHUU7xV7U5hppz0TwyLylvfhThdDw5IXkKUDvzyBljToNxc48XV/kE0
 cvBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMpvYuBU9kWmMCZPpJGaB8/Yd4FpKLdvjrMvi9xH9T+fwOCmsc0FH2jj0TnP1vAHhMvEy4O+5b@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywqa0S0x+zFhTochKW1Yp2uBVmblVrSdbyQ6ywZUxjX71bt37Bz
 zccYujwQQFe1meq7dmYd5CeuiXfsJHTnRBg6LsnCuaBGAF7/MuVuiaBYnjbDvXLtKBPshgNY7dF
 mI9XqJcnbo97hk3YCFX1JYSeOugccXQ==
X-Gm-Gg: ASbGncsm2X4FeELtohfsLJHrl9yaKf7BNl7nHKlb52zOQR1KeCrR3/Mgo2W50K7trxa
 v4I2O0MvuBNGW83g6S3qs9YCiB9DQImjY/mumVIQC3EFm5dldnuqUUV/mg2FU6Kr2Vej43eA1dn
 h4ccVMcbfuLXFGDgR2d2/GT8I0RYKlG4Zu
X-Google-Smtp-Source: AGHT+IHEnrWi56MmakALp5nL0wx5OoeCmFVh1tvEy7D8UBkzSnYMimcRTPXue5dt2lANp751ba8Z4SRxr5cF4y9cgHA=
X-Received: by 2002:a17:90b:380c:b0:305:5f25:59ad with SMTP id
 98e67ed59e1d1-309dee7834fmr1664835a91.7.1745416128754; Wed, 23 Apr 2025
 06:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250423093359.4424-1-Arvind.Yadav@amd.com>
 <7bd591c8-8101-431c-980d-edadfe26b047@amd.com>
In-Reply-To: <7bd591c8-8101-431c-980d-edadfe26b047@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 23 Apr 2025 09:48:37 -0400
X-Gm-Features: ATxdqUHYcxlOhsJBdbm0ofD6bl0sAWpCvQbnDuNwUI3bsEi_iXryQny9pMVE98Y
Message-ID: <CADnq5_Obbx8Zvm7ViGDHhT-bk7aMsb=03OMZfEcY8r_MLBU2gA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: remove DRM_AMDGPU_NAVI3X_USERQ config for
 UQ
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Arvind Yadav <Arvind.Yadav@amd.com>, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, sunil.khatri@amd.com, 
 Arunpravin.PaneerSelvam@amd.com, amd-gfx@lists.freedesktop.org
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

On Wed, Apr 23, 2025 at 6:03=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
> LGTM, Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
>
> I think you should also get an acknowledgement from Alex too before
> pushing to ASDN.

Please go ahead.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Regards
> Sunil khatri
>
> On 4/23/2025 3:03 PM, Arvind Yadav wrote:
> > DRM_AMDGPU_NAVI3X_USERQ config support is not required for
> > usermode queue.
> >
> > v2: rebase.
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Sunil Khatri <sunil.khatri@amd.com>
> > Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> > Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/Kconfig             |  8 --------
> >   drivers/gpu/drm/amd/amdgpu/Makefile            |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  7 +------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c        |  5 +----
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c      |  8 --------
> >   .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    | 18 -----------------=
-
> >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  4 ----
> >   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         |  2 --
> >   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c         |  3 +--
> >   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c         |  3 ---
> >   10 files changed, 4 insertions(+), 56 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/a=
mdgpu/Kconfig
> > index 7b95221d2f3d..1a11cab741ac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> > +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> > @@ -96,14 +96,6 @@ config DRM_AMDGPU_WERROR
> >         Add -Werror to the build flags for amdgpu.ko.
> >         Only enable this if you are warning code for amdgpu.ko.
> >
> > -config DRM_AMDGPU_NAVI3X_USERQ
> > -     bool "Enable amdgpu usermode queues"
> > -     depends on DRM_AMDGPU
> > -     default n
> > -     help
> > -       Choose this option to enable GFX usermode queue support for GFX=
/SDMA/Compute
> > -          workload submission. This feature is experimental and suppor=
ted on GFX11+.
> > -
> >   source "drivers/gpu/drm/amd/acp/Kconfig"
> >   source "drivers/gpu/drm/amd/display/Kconfig"
> >   source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/=
amdgpu/Makefile
> > index 8595e05c691b..87080c06e5fc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > @@ -177,7 +177,7 @@ amdgpu-y +=3D \
> >       mes_v12_0.o \
> >
> >   # add GFX userqueue support
> > -amdgpu-$(CONFIG_DRM_AMDGPU_NAVI3X_USERQ) +=3D mes_userqueue.o
> > +amdgpu-y +=3D mes_userqueue.o
> >
> >   # add UVD block
> >   amdgpu-y +=3D \
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index b96e0613ea7e..fe68ba9997ae 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3513,9 +3513,7 @@ static int amdgpu_device_ip_fini_early(struct amd=
gpu_device *adev)
> >       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> >
> >       amdgpu_amdkfd_suspend(adev, false);
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >       amdgpu_userq_suspend(adev);
> > -#endif
> >
> >       /* Workaround for ASICs need to disable SMC first */
> >       amdgpu_device_smu_fini_early(adev);
> > @@ -5086,9 +5084,7 @@ int amdgpu_device_suspend(struct drm_device *dev,=
 bool notify_clients)
> >
> >       if (!adev->in_s0ix) {
> >               amdgpu_amdkfd_suspend(adev, adev->in_runpm);
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >               amdgpu_userq_suspend(adev);
> > -#endif
> >       }
> >
> >       r =3D amdgpu_device_evict_resources(adev);
> > @@ -5156,11 +5152,10 @@ int amdgpu_device_resume(struct drm_device *dev=
, bool notify_clients)
> >               r =3D amdgpu_amdkfd_resume(adev, adev->in_runpm);
> >               if (r)
> >                       goto exit;
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> > +
> >               r =3D amdgpu_userq_resume(adev);
> >               if (r)
> >                       goto exit;
> > -#endif
> >       }
> >
> >       r =3D amdgpu_device_ip_late_init(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index cb9ffb17ab98..cc5d6250ac69 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -1980,9 +1980,7 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu=
_device *adev, u32 idx,
> >               if (adev->gfx.userq_sch_req_count[idx] =3D=3D 0) {
> >                       cancel_delayed_work_sync(&adev->gfx.enforce_isola=
tion[idx].work);
> >                       if (!adev->gfx.userq_sch_inactive[idx]) {
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >                               amdgpu_userq_stop_sched_for_enforce_isola=
tion(adev, idx);
> > -#endif
> >                               if (adev->kfd.init_complete)
> >                                       amdgpu_amdkfd_stop_sched(adev, id=
x);
> >                               adev->gfx.userq_sch_inactive[idx] =3D tru=
e;
> > @@ -2040,9 +2038,8 @@ void amdgpu_gfx_enforce_isolation_handler(struct =
work_struct *work)
> >               /* Tell KFD to resume the runqueue */
> >               WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
> >               WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> > +
> >               amdgpu_userq_start_sched_for_enforce_isolation(adev, idx)=
;
> > -#endif
> >               if (adev->kfd.init_complete)
> >                       amdgpu_amdkfd_start_sched(adev, idx);
> >               adev->gfx.userq_sch_inactive[idx] =3D false;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userq.c
> > index b0e8098a3988..451890ee3fb7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -129,7 +129,6 @@ amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr=
)
> >       return ret;
> >   }
> >
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >   static struct amdgpu_usermode_queue *
> >   amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
> >   {
> > @@ -520,13 +519,6 @@ int amdgpu_userq_ioctl(struct drm_device *dev, voi=
d *data,
> >
> >       return r;
> >   }
> > -#else
> > -int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> > -                    struct drm_file *filp)
> > -{
> > -     return -ENOTSUPP;
> > -}
> > -#endif
> >
> >   static int
> >   amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > index be068e8e37d1..3288c2ff692e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> > @@ -216,7 +216,6 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_us=
erq_fence_driver *fence_drv)
> >       kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy)=
;
> >   }
> >
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >   static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq=
_fence)
> >   {
> >       *userq_fence =3D kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_AT=
OMIC);
> > @@ -288,7 +287,6 @@ static int amdgpu_userq_fence_create(struct amdgpu_=
usermode_queue *userq,
> >
> >       return 0;
> >   }
> > -#endif
> >
> >   static const char *amdgpu_userq_fence_get_driver_name(struct dma_fenc=
e *f)
> >   {
> > @@ -343,7 +341,6 @@ static const struct dma_fence_ops amdgpu_userq_fenc=
e_ops =3D {
> >       .release =3D amdgpu_userq_fence_release,
> >   };
> >
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >   /**
> >    * amdgpu_userq_fence_read_wptr - Read the userq wptr value
> >    *
> > @@ -594,15 +591,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *d=
ev, void *data,
> >
> >       return r;
> >   }
> > -#else
> > -int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
> > -                           struct drm_file *filp)
> > -{
> > -     return -ENOTSUPP;
> > -}
> > -#endif
> >
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >   int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> >                           struct drm_file *filp)
> >   {
> > @@ -968,10 +957,3 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev=
, void *data,
> >
> >       return r;
> >   }
> > -#else
> > -int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
> > -                         struct drm_file *filp)
> > -{
> > -     return -ENOTSUPP;
> > -}
> > -#endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index ac7ac58e25a6..519b82f77cff 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -1630,7 +1630,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
> >       case IP_VERSION(11, 0, 0):
> >       case IP_VERSION(11, 0, 2):
> >       case IP_VERSION(11, 0, 3):
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >               if (!adev->gfx.disable_uq &&
> >                   adev->gfx.me_fw_version  >=3D 2390 &&
> >                   adev->gfx.pfp_fw_version >=3D 2530 &&
> > @@ -1639,7 +1638,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
> >                       adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_me=
s_funcs;
> >                       adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &user=
q_mes_funcs;
> >               }
> > -#endif
> >               break;
> >       case IP_VERSION(11, 0, 1):
> >       case IP_VERSION(11, 0, 4):
> > @@ -1647,13 +1645,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_b=
lock *ip_block)
> >       case IP_VERSION(11, 5, 1):
> >       case IP_VERSION(11, 5, 2):
> >       case IP_VERSION(11, 5, 3):
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >               /* add firmware version checks here */
> >               if (0 && !adev->gfx.disable_uq) {
> >                       adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_me=
s_funcs;
> >                       adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &user=
q_mes_funcs;
> >               }
> > -#endif
> >               break;
> >       default:
> >               break;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_0.c
> > index dfa0830a4eb1..f09d96bfee16 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -1416,7 +1416,6 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
> >       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> >       case IP_VERSION(12, 0, 0):
> >       case IP_VERSION(12, 0, 1):
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >               if (!adev->gfx.disable_uq &&
> >                   adev->gfx.me_fw_version  >=3D 2780 &&
> >                   adev->gfx.pfp_fw_version >=3D 2840 &&
> > @@ -1425,7 +1424,6 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
> >                       adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_me=
s_funcs;
> >                       adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &user=
q_mes_funcs;
> >               }
> > -#endif
> >               break;
> >       default:
> >               break;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v6_0.c
> > index 6bb36187a53d..da5b5d64f137 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > @@ -1363,11 +1363,10 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_b=
lock *ip_block)
> >       else
> >               DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n"=
);
> >
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >       /* add firmware version checks here */
> >       if (0 && !adev->sdma.disable_uq)
> >               adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_funcs;
> > -#endif
> > +
> >       r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
> >       if (r)
> >               return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v7_0.c
> > index 943c6446a0a7..befe013b11a7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > @@ -1338,12 +1338,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_bl=
ock *ip_block)
> >       else
> >               DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n"=
);
> >
> > -#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
> >       /* add firmware version checks here */
> >       if (0 && !adev->sdma.disable_uq)
> >               adev->userq_funcs[AMDGPU_HW_IP_DMA] =3D &userq_mes_funcs;
> > -#endif
> > -
> >
> >       return r;
> >   }
