Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED2EC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Apr 2022 21:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DF5010E379;
	Fri, 22 Apr 2022 21:00:48 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC42F10E379
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 21:00:46 +0000 (UTC)
Received: by mail-oi1-x22e.google.com with SMTP id r85so10377624oie.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Apr 2022 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4gs/Vh8903FpUkW0dXiCjK4YIBncxrhYtxwTiU2vvBY=;
 b=BWo/lU8Y+uOVhFmnHRoKfm0FdzDaqnTOEpSnPZlnFSGC/bzWwFrIQflZ3j4B7C2CuP
 I9+KRAaB7gax42oGT3oA67tV1G19DlygEfOdziw/i6vEkgeMYoZcW9Cnot473Ajpz4Bx
 cYuYof3qf/nyhDfiJaydj87H9CmhlRoFDj4auB5WcTWk5esinmPuHA4py5Gqc2gt50ZW
 AQhagC4Lb5tJUG6wCwDCZctchT0Ev0jm4W22Cp3io8Z3jkHSGdgTAUorLhV9h5I1VOra
 U72E9d4mXy/5sdxIU3p4OZ4jPTGPYFZ19isuWVc3z0yaFxcKP0rgNo8sDmcDTxCObxwD
 eKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4gs/Vh8903FpUkW0dXiCjK4YIBncxrhYtxwTiU2vvBY=;
 b=Lta6F37VS4Yt11pQwkcQ5yEhDr2hPVIzeVjVhndD53tKyNf0vbwLCGVTvNNtw9jBU0
 /pHNiYz4eE+/rPADeJwFbQkVOTb37aaQlHszRXZDyrYx2Jv8CNlMRTjEJJn04fWOrotY
 ltAvcWYevNmabBvhMOWgL4fODEKK9p6xzG+yqks2WTU4loTDrk7F0W0fH8+L0RstY0yX
 k8/dq8KDw0cxKoGKUCYpx6LjniaRGBSzuawdIQb7HhBKkWPFT7HpvOE/lEdi3jfSwTmH
 9tZYLOm/PDU0cYLzeCD3RsndmhAjq8E/LQZVRRLU2sHccpUZOaT0XDnjxw3aSYBYTc7X
 qHgw==
X-Gm-Message-State: AOAM531KJALZ4QNlBOFZosVUUc6tNzUiQXibvXU/64o4Wv2G9d/xf5su
 RmUXPV7pJlI//MRjaV/9cEV7BCOWc2spi1QPTyE=
X-Google-Smtp-Source: ABdhPJy0rrXBBB35T0Uj/coqJ0kl9hN5Yx0x230yE8vr6ay7bHT7v4I8sU/e7KqHQwovCySLTPnPdQgKKY6mCvIn0yE=
X-Received: by 2002:aca:3d88:0:b0:321:141:ce0b with SMTP id
 k130-20020aca3d88000000b003210141ce0bmr7208249oia.200.1650661246199; Fri, 22
 Apr 2022 14:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220420214715.2644898-1-shiwei.wong@amd.com>
 <CADnq5_ORQYj6ro4u9P4j7+NHVCMmn-iJ_FNzcNsiVHCro0J8KQ@mail.gmail.com>
 <DM6PR12MB3963944F7765140E05D7AEA3EBF79@DM6PR12MB3963.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3963944F7765140E05D7AEA3EBF79@DM6PR12MB3963.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Apr 2022 17:00:34 -0400
Message-ID: <CADnq5_N7yckjOTwEDnVZCBrtcqj7YE+gnkfGWofy0-b=ah3CeA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clean up psp ip if hw_init failed v2
To: "Wong, Alice" <Shiwei.Wong@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 22, 2022 at 3:54 PM Wong, Alice <Shiwei.Wong@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Hi Alex,
>
> The attached patch freed most of the allocated memory except for one allo=
cated by psp_tmr_init during psp_load_fw.
> Combination of the attached patch and calling psp_hw_fini when psp_hw_ini=
t failed would fix the issue.
>
> As a proper fix, we can call psp_tmr_terminate in psp_load_fw when psp_lo=
ad_non_psp_fw failed. (attached patch)
> We can't move psp_tmr_init to sw_init because we need to load toc to get =
the TMR size.
> Do you have any concerns with this approach?

That only covers failures in hw_init().  It doesn't handle resume().
Looks like all of the ta functions also potentially leak.  I'm working
on a cleanup to handle all of these.

Alex

>
> Alice
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: April 21, 2022 1:31 AM
> To: Wong, Alice <Shiwei.Wong@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: clean up psp ip if hw_init failed v2
>
> On Wed, Apr 20, 2022 at 5:48 PM Alice Wong <shiwei.wong@amd.com> wrote:
> >
> > If at any point psp_hw_init failed, psp_hw_fini would not be called
> > during unload due to ip_blocks[PSP].status.hw not being set to true.
> > This could cause a memory leak when the driver unloads.
> > As a rule of thumb, each IP block should cleanup themselves when their
> > hw_init fails. Only previously intialized blocks should be cleaned up
> > by the common framework.
> >
> > v1: Call IP blocks' respective hw_fini when hw_init failed from
> >     the common framework
> > v2: Call psp_hw_fini when psp_hw_init failed.
> >
> > Signed-off-by: Alice Wong <shiwei.wong@amd.com>
>
> I don't think this is a good idea.  The hw programming in hw_fini makes n=
o sense if the driver never set it up in the first place if hw_init failed =
before initializing the hw.  It would be better to just properly unwind the=
 relevant functions.  Presumably the problem you are seeing is the failure =
to free the GPU memory allocated in fw_fini, depending on where it fails.  =
We should just allocate the memory in sw_init; that is what we do in other =
IPs.  Does the attached patch fix the issue you are seeing?
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 57
> > +++++++++++++------------
> >  1 file changed, 29 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index 5b9e48d44f5b..52b14efa848a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -2537,6 +2537,34 @@ static int psp_load_fw(struct amdgpu_device *ade=
v)
> >         return ret;
> >  }
> >
> > +static int psp_hw_fini(void *handle)
> > +{
> > +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > +       struct psp_context *psp =3D &adev->psp;
> > +
> > +       if (psp->ta_fw) {
> > +               psp_ras_terminate(psp);
> > +               psp_securedisplay_terminate(psp);
> > +               psp_rap_terminate(psp);
> > +               psp_dtm_terminate(psp);
> > +               psp_hdcp_terminate(psp);
> > +       }
> > +
> > +       psp_asd_terminate(psp);
> > +
> > +       psp_tmr_terminate(psp);
> > +       psp_ring_destroy(psp, PSP_RING_TYPE__KM);
> > +
> > +       amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> > +                             &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
> > +       amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> > +                             &psp->fence_buf_mc_addr, &psp->fence_buf)=
;
> > +       amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
> > +                             (void **)&psp->cmd_buf_mem);
> > +
> > +       return 0;
> > +}
> > +
> >  static int psp_hw_init(void *handle)
> >  {
> >         int ret;
> > @@ -2563,37 +2591,10 @@ static int psp_hw_init(void *handle)
> >  failed:
> >         adev->firmware.load_type =3D AMDGPU_FW_LOAD_DIRECT;
> >         mutex_unlock(&adev->firmware.mutex);
> > +       psp_hw_fini(handle);
> >         return -EINVAL;
> >  }
> >
> > -static int psp_hw_fini(void *handle)
> > -{
> > -       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> > -       struct psp_context *psp =3D &adev->psp;
> > -
> > -       if (psp->ta_fw) {
> > -               psp_ras_terminate(psp);
> > -               psp_securedisplay_terminate(psp);
> > -               psp_rap_terminate(psp);
> > -               psp_dtm_terminate(psp);
> > -               psp_hdcp_terminate(psp);
> > -       }
> > -
> > -       psp_asd_terminate(psp);
> > -
> > -       psp_tmr_terminate(psp);
> > -       psp_ring_destroy(psp, PSP_RING_TYPE__KM);
> > -
> > -       amdgpu_bo_free_kernel(&psp->fw_pri_bo,
> > -                             &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
> > -       amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> > -                             &psp->fence_buf_mc_addr, &psp->fence_buf)=
;
> > -       amdgpu_bo_free_kernel(&psp->cmd_buf_bo, &psp->cmd_buf_mc_addr,
> > -                             (void **)&psp->cmd_buf_mem);
> > -
> > -       return 0;
> > -}
> > -
> >  static int psp_suspend(void *handle)
> >  {
> >         int ret;
> > --
> > 2.25.1
> >
