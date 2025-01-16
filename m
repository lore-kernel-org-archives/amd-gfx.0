Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09E4C02183
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 21:43:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 658F010E279;
	Thu, 16 Jan 2025 21:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="REGUq/nB";
	dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0365410E0F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 21:43:46 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f74e6c6cbcso297744a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 13:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737063825; x=1737668625; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=an7D1SSPfUQcyCBF74l0hd8zebNZ4mSUWBM1INChDpU=;
 b=REGUq/nB40a7o8RbnaQHuLFPhdjeBkM8LLS9NQkNfYM1szc8+xZhByJI3KrosufS/j
 kh2g2z0ubtw6PxP2T5qhMCQEreCxkZJRP2RTBHCHjgq0mLQEfF1r1ncS1kOCgf6rzVoh
 a//un3AIwlKsD8xWRkpa3wbKi/oFdXxw7tUX1lnoPRUlWkPdO3NwB0h2r2hjK9QzrREI
 5excAzEQAJnLLZ4zwdZ9GCq8iy+4J1nf1BXAAZ2JtvL6cyOZyp7WOjVzf9zb0jzSFmIf
 /a/L8DdILek+U9QoaI3LY1vsLVfPtQb49nLxG5NSZNOQyekp61oBob06yavqMgwm/y4Y
 kQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737063825; x=1737668625;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=an7D1SSPfUQcyCBF74l0hd8zebNZ4mSUWBM1INChDpU=;
 b=VAHdagmz84e3fs2UurGrLFqCqAwTrKCGCAK51GkDYFPd6Db6Lr4ChdlQk2o/Ibw+m9
 BgxNjIDhCXfYepU4/tnYzzFDa+1qhFJYzoNm7Cd83oKHMFEcsAFDxB6CjfDh76WwSrUd
 wKI8lGN2K3hEIjUqNi+cE8U2mFYN0VGHxJF9tQVPwwwiEPit8Liwc90mJGTCPzdaGdDB
 4DBJWI6yybShz8auceg9wl/bxIsF4sWuEAK7TRi3bKloA5wz7bEPI9NQgSKGl8Nr56JZ
 l3TQUwICHDHHd6xKLetgBFlihM5bzllQBJNRTvN6lkM29PLoY8AuguAYashC6ETHMqTn
 1NJg==
X-Gm-Message-State: AOJu0YxSaStE7L2bn7uWilP5dQUqSlUgCP7Wrck5XEcicDpWNgjcgZd1
 L57vc8HdWbDTmFSUuzz9JQTJcBpyFi5EQd4TlJrIKbourrB9rQlnljCgYpS1oESUfpeXnrACpES
 eU2Jx5F/xFjyepu//fuepJcjPbKo=
X-Gm-Gg: ASbGnctwpy/zvS3VeUmRB+VfHfeYqTPrU8A20zxHF4HbfiO2b3INrB+/sIMhhFYrIDy
 EJEvYG1CkotCRZDICzjO2+WEFOzxKIugXQDJD2g==
X-Google-Smtp-Source: AGHT+IGQWe7wwghEqCCtG8dTHQ9fQompkd2EVDjHpeLBqJtL6TYNRFSpvaIS4KE1/JUVheU7WLwDKFagNy8zt/8AvyQ=
X-Received: by 2002:a17:90b:514d:b0:2ee:f440:bb93 with SMTP id
 98e67ed59e1d1-2f782d90afdmr78134a91.4.1737063825526; Thu, 16 Jan 2025
 13:43:45 -0800 (PST)
MIME-Version: 1.0
References: <20250116182921.1730696-1-superm1@kernel.org>
 <CADnq5_NDhxidmtNhi5rONuZQv-vQF-gYanrVuFU0XYJA-RDqqw@mail.gmail.com>
 <ee899223-0304-420a-9489-6f6abc1b6791@kernel.org>
In-Reply-To: <ee899223-0304-420a-9489-6f6abc1b6791@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2025 16:43:33 -0500
X-Gm-Features: AbW1kvZ1ZgAmIBilw-dka75fj7pr7jf_hGuaOFUWC0DLCFPTKlmFZ5e_VNeZcP8
Message-ID: <CADnq5_MZd7=CkJ9=NVqAiamVwWXn7u-NYJZFztH4odjWYwU1GQ@mail.gmail.com>
Subject: Re: [RFC] drm/amd: Drop gttsize module parameter
To: Mario Limonciello <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Jan 16, 2025 at 4:42=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 1/16/2025 15:32, Alex Deucher wrote:
> > On Thu, Jan 16, 2025 at 1:29=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> When not set `gttsize` module parameter by default will get the
> >> value to use for the GTT pool from the TTM page limit, which is
> >> set by a separate module parameter.
> >>
> >> This inevitably leads to people not sure which one to set when they
> >> want more addressable memory for the GPU, and you'll end up seeing
> >> instructions online saying to set both.
> >>
> >> Drop the amdgpu module parameter and related code for it.  This way
> >> if users want to change the amount of addressable memory they can
> >> change it solely in TTM.
> >>
> >
> > I suspect we probably want to keep it for compatibility with users
> > that still use this option to change their GTT size.
>
> Could we mark it as deprecated?  Perhaps something like this:
>
> 0) Change kdoc
> 1) Some messaging to show it being deprecated
>
>         if (amdgpu_gttsize !=3D -1)
>                 drm_warn(dev, "Configuring gttsize via module parameter i=
s deprecated,
> please use ttm.ttm_page_limit");
>
> 2) Some messaging to show information if inconsistent values have been
> set against TTM
>
>         if (amdgpu_gttsize !=3D ttm_page_limit()
>                 drm_warn(dev, "GTT size has been set as %lu but TTM size =
has been set
> as %lu, this is unusual");
>
> Then after the "next" LTS release is declared we can pull it out entirely=
.
>

Seems reasonable to me.

Alex

> >
> > Alex
> >
> >
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 -
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 -------
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 9 ---------
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 9 ++-------
> >>   4 files changed, 2 insertions(+), 24 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h
> >> index 5e55a44f9eef..e728974114bb 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -164,7 +164,6 @@ extern int amdgpu_modeset;
> >>   extern unsigned int amdgpu_vram_limit;
> >>   extern int amdgpu_vis_vram_limit;
> >>   extern int amdgpu_gart_size;
> >> -extern int amdgpu_gtt_size;
> >>   extern int amdgpu_moverate;
> >>   extern int amdgpu_audio;
> >>   extern int amdgpu_disp_priority;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index 3774d12ebc4a..1b62b843e5fb 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -2031,13 +2031,6 @@ static int amdgpu_device_check_arguments(struct=
 amdgpu_device *adev)
> >>                  amdgpu_gart_size =3D -1;
> >>          }
> >>
> >> -       if (amdgpu_gtt_size !=3D -1 && amdgpu_gtt_size < 32) {
> >> -               /* gtt size must be greater or equal to 32M */
> >> -               dev_warn(adev->dev, "gtt size (%d) too small\n",
> >> -                                amdgpu_gtt_size);
> >> -               amdgpu_gtt_size =3D -1;
> >> -       }
> >> -
> >>          /* valid range is between 4 and 9 inclusive */
> >>          if (amdgpu_vm_fragment_size !=3D -1 &&
> >>              (amdgpu_vm_fragment_size > 9 || amdgpu_vm_fragment_size <=
 4)) {
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c
> >> index b911653dd8b6..62b09c518665 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -141,7 +141,6 @@ enum AMDGPU_DEBUG_MASK {
> >>   unsigned int amdgpu_vram_limit =3D UINT_MAX;
> >>   int amdgpu_vis_vram_limit;
> >>   int amdgpu_gart_size =3D -1; /* auto */
> >> -int amdgpu_gtt_size =3D -1; /* auto */
> >>   int amdgpu_moverate =3D -1; /* auto */
> >>   int amdgpu_audio =3D -1;
> >>   int amdgpu_disp_priority;
> >> @@ -279,14 +278,6 @@ module_param_named(vis_vramlimit, amdgpu_vis_vram=
_limit, int, 0444);
> >>   MODULE_PARM_DESC(gartsize, "Size of kernel GART to setup in megabyte=
s (32, 64, etc., -1=3Dauto)");
> >>   module_param_named(gartsize, amdgpu_gart_size, uint, 0600);
> >>
> >> -/**
> >> - * DOC: gttsize (int)
> >> - * Restrict the size of GTT domain (for userspace use) in MiB for tes=
ting.
> >> - * The default is -1 (Use 1/2 RAM, minimum value is 3GB).
> >> - */
> >> -MODULE_PARM_DESC(gttsize, "Size of the GTT userspace domain in megaby=
tes (-1 =3D auto)");
> >> -module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
> >> -
> >>   /**
> >>    * DOC: moverate (int)
> >>    * Set maximum buffer migration rate in MB/s. The default is -1 (8 M=
B/s).
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c
> >> index e6fc89440210..e3fee81d8646 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >> @@ -1957,13 +1957,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >>          DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
> >>                   (unsigned int)(adev->gmc.real_vram_size / (1024 * 10=
24)));
> >>
> >> -       /* Compute GTT size, either based on TTM limit
> >> -        * or whatever the user passed on module init.
> >> -        */
> >> -       if (amdgpu_gtt_size =3D=3D -1)
> >> -               gtt_size =3D ttm_tt_pages_limit() << PAGE_SHIFT;
> >> -       else
> >> -               gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
> >> +       /* Compute GTT size, based on TTM limit */
> >> +       gtt_size =3D ttm_tt_pages_limit() << PAGE_SHIFT;
> >>
> >>          /* Initialize GTT memory pool */
> >>          r =3D amdgpu_gtt_mgr_init(adev, gtt_size);
> >> --
> >> 2.48.0
> >>
>
