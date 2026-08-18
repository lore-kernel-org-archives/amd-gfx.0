Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE0EC5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 15:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC8F10EBB0;
	Tue, 18 Aug 2026 15:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cc3EItQo";
	dkim-atps=neutral
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com
 [209.85.222.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B978610E00D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 15:20:03 +0000 (UTC)
Received: by mail-ua1-f50.google.com with SMTP id
 a1e0cc1a2514c-9775d28882fso12433241.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 08:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787066402; cv=none;
 d=google.com; s=arc-20260327;
 b=aUgg6GLJkzg6RWofmhplnrLKzkDxgxOXtiynND2Spj6z3WjROsS3A7dgCvccvpnZhX
 71cKFY0WkV1AZawRbvHq+UP8ec0ulQU7coHzJuKguIJs1NHKKhrl9wIVOvElmB3vbMaT
 rwZer3zI2XLgd4wpje8yDakpMFuplDKlbEGxmIrd6yAQrjY4UBQg5Qt9A7tOSs9EP3JE
 LJEomaCp27Hd57ZBlnMrE2+0uw/znl/6EROF6G2eUI7RpaEVKj4YbMWWP1f/M7iBuTnf
 crB2yeW8L9jEta0lG25E2ver/GgwQzei4muXbuUJowPu8929PkM02awF3DYoCmlgfGD0
 3K7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dO6gA5OlpY7aviUwecug9Lffky6dHdY0Bx4b8yQq6s4=;
 fh=9Zvjnk8syr6rM8+byHvVgrxszVhmWv1F5FkQICjMFZ8=;
 b=ACtmcvYok150Z/EfllSAdz/8K8zn+FeXITfGBF6UMlQsCZ+V1VyPimodH2qCvA1jtR
 Ctp6W0jX8PodIAidXkfNkB3zrH6sRqAY0Jv9XoBfhu+yTAbp8jqjXz9v6xJCAHnWgqH4
 pzTChI6/i903dMdYr3v4cCNWvnxj/GtO5jBdFnsMHag34RSatfho4rzuSO+8z4KpnxF7
 Hjw4hxM0vzZKaXw5uZAAKdWuI9r3XFaB77rtO2F5BklqAzyT9grsTnkIVX59mSS8D24L
 NSy/tF25hEpIPY41EPWhmIgskZUwxho+aD12pbyj7OrJhVdYk93DlWJxfjXN0luiIacn
 6yWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787066402; x=1787671202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dO6gA5OlpY7aviUwecug9Lffky6dHdY0Bx4b8yQq6s4=;
 b=cc3EItQoLp2Tn/HR+8zf/+WylJ3XV9wF1psi79IqX+NNbmSZ9N8B9y1zKpByaOfKzt
 sKRv+ZNtv//fXANWxAKx7jMlfZU3+1oO+uRpLXXYckMyT2MDS6CedS1g9aa7MXlwnxss
 Ffp47gmNolTzqCOAJAqvfGKqNGs2nJHuZXcfsS2UPbJJWu9Rjnkteib9EeOVDGbE61nZ
 xHwOm0VFWlz2FEYHPvJvXh+LhPPZTVWl2D5PZqV/m3EYBllA/VqyOuDsOfNV2w02Ks5r
 QaoZgKRK+vekoysr8s4vUgx5fSDtQWpLdEpHxMwfStDgAJcIORYxTW2Uh9i5GAva0wEd
 Xo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787066402; x=1787671202;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dO6gA5OlpY7aviUwecug9Lffky6dHdY0Bx4b8yQq6s4=;
 b=F6j7tCTKzoEZz6gYqK4HmEPtnN16rPAVp56bvC4IZu4JahAA3zeEQz5DZvPFvThZUO
 XbIOtKpLAU0weY2+NzwPtdsVrCKy5xGF+PbwoDRq49DYcwgsdedA6sxh+6UjkijQ1GaH
 FQdP63G9ZRrpmkFYaSpdJM5Yea3es8m3AOGAf3emiEQ59Vm8yUp8ugeFYo4MU+gtvftn
 4prZrsM/kM+ldDbl7w3UuE5mBUcFMnvsO8b8R+gRy63haT3AVptFXQNVMyejzxJSVNy2
 TZiuKlHlQZVn85yU2yEdLzxtfmI/3OjVWADf4PX2viSkEv3h1Y8R9KDxXpQ17GgCGkde
 1tMA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roq0AAsHKa0Vg0fHG4k1ZySpgzcGg7lbcDh+x+e0N+wOwE5f876ZSzE/mD3iHiy6JThRELPIloj@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5wwsfC6kX/c5Qo6UnFBDkncypKWmnYCbQl3MkLA/bekWPa4Pr
 NHhXFNx/uxnSmBJKvP2l6EOv5D5BlUzZx+YB88Y6xSYQArDNTdLVbZj503itNYeziq6Zg5Op+4I
 Pe0UxPgZ01d8U/nn61fBS/6umpBLB0cw=
X-Gm-Gg: AR+sD10GGXxT6sAfhMPe9l/K2OjW57iJxrB/L96k1IV8On2tmfYK/PmYpt0oSc95ovi
 vZ6DdJ3rG57qx+wXxPovldQOj3Iije/Il6DW9IRvUCyfLq6v4A11UCnjlIaujvZ8fp2rbJQLmSO
 L0Pus83jRDLhNnVUlNfKjOJnDs/myUDYz2QSK9M0moGq4CVrD0nuYJXjC/0QnSTbGXBvlWq4qi+
 GUs9AbMazxg1wL2rYr1olFX+MikZxS9MCHzJ0nTv16l+0aFjzKWKuakqjPYi6XfWqXjjvawpqP0
 2ki3xrB0dv84RsYc9OX3z3Ro184DxbXy4ZvBbrwQBUnWqHLOCKFtg9BAw6aVJiRE9ZMzHg1XvPf
 mCMDzRN2LRmDDO24LVPWmxEUDS7RwNIZuJV8RMKCJOA==
X-Received: by 2002:a05:6102:5091:b0:72f:6669:286a with SMTP id
 ada2fe7eead31-76f2c540eb2mr2697798137.2.1787066402226; Tue, 18 Aug 2026
 08:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260817062728.2535467-1-kevinyang.wang@amd.com>
 <CADnq5_PhiEzW7eA311hSyCo=ve1Bx2dBUEf3LArLbPTK2s==Ww@mail.gmail.com>
 <SA1PR12MB67997EAEAAE352E689CAD3408EA62@SA1PR12MB6799.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB67997EAEAAE352E689CAD3408EA62@SA1PR12MB6799.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 18 Aug 2026 11:19:49 -0400
X-Gm-Features: AcwNN1Ug5pdNHxn9phM5CUEU1LrfOGMd-ZmU35E9zL1jnqzuMMRCxLs5R7OGlEg
Message-ID: <CADnq5_MRobntqZFWHw6+Qep62BfLX7h6odwp_KAp1PAuDBw=1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix smu messages after system resume for smu
 11.0.x
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
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

On Tue, Aug 18, 2026 at 11:13=E2=80=AFAM Feng, Kenneth <Kenneth.Feng@amd.co=
m> wrote:
>
> AMD General
>
> Hi Alex,
>
> Mp1 unload is not expected to be used on S3 suspend/resume scenarios orig=
inally since there is a mode1 reset during S3 suspend.
> The mode1 reset erases everything so psp will reload mp1 fw anyway during=
 S3 resume, no need to ask amdgpu driver to 'remind the psp to reload mp1 f=
w' by sending the unload message to mp1.
> Kevin's patch addresses this issue: when S3 suspend is triggered, the GPU=
 happens to be in runtime pm suspended state already. Then GPU does runtime=
 pm resume first, then continue the S3 suspend -> S3 resume.
> In this case, during runtime pm resume, psp might mark this as 'no need t=
o load MP1 fw again during reinitialization'. Then even a latter mode1 rese=
t is executed, psp may keep the mark somehow.
> So MP1 unload is added in S3 suspend for this scenario.
> But this is not verified on all dGPUs.

I suspect the mode1 reset in S3 resume was probably a workaround.  It
sounds like doing mp1unload is perhaps a better approach overall?

Alex

> Thanks.
>
>
>
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Monday, August 17, 2026 9:27 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@=
amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Fe=
ng@amd.com>
> Subject: Re: [PATCH] drm/amd/pm: fix smu messages after system resume for=
 smu 11.0.x
>
> On Mon, Aug 17, 2026 at 3:45=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com=
> wrote:
> >
> > SMU 11.0.x can retain an unfinished command across system suspend,
> > causing SMU messages such as RunDcBtc to fail during resume.
> >
> > Prepare MP1 for unload during system suspend and record successful
> > completion, reload SMC firmware after PSP restart before resume sends
> > further SMU messages, then clear the reload state.
>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> Is there any reason not to do mp1 unload for all dGPUs in this case?
>
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5620
> >
> > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   |  9 ++++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  2 ++
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 38
> > ++++++++++++++++++++---
> >  3 files changed, 42 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index 04f6ebf31cca..5c00683c1edd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -3512,11 +3512,16 @@ static int psp_load_non_psp_fw(struct psp_conte=
xt *psp)
> >         struct amdgpu_firmware_info *ucode;
> >         struct amdgpu_device *adev =3D psp->adev;
> >
> > -       if (psp->autoload_supported &&
> > -           !psp->pmfw_centralized_cstate_management) {
> > +       if (psp->smu_fw_needs_reload ||
> > +           (psp->autoload_supported &&
> > +            !psp->pmfw_centralized_cstate_management)) {
> > +               if (psp->smu_fw_needs_reload)
> > +                       dev_dbg(adev->dev,
> > +                               "Reloading SMU firmware after MP1
> > + unload\n");
> >                 ret =3D psp_load_smu_fw(psp);
> >                 if (ret)
> >                         return ret;
> > +               psp->smu_fw_needs_reload =3D false;
> >         }
> >
> >         /* Load P2S table first if it's available */ diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > index d80c85793e3b..20338caa4921 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > @@ -443,6 +443,8 @@ struct psp_context {
> >         bool                            boot_time_tmr;
> >         /* flag to mark whether df cstate management centralized to PMF=
W */
> >         bool                            pmfw_centralized_cstate_managem=
ent;
> > +       /* SMC firmware reload required during resume */
> > +       bool                            smu_fw_needs_reload;
> >
> >         /* xgmi ta firmware and buffer */
> >         const struct firmware           *ta_fw;
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index 559afdc5815d..8d499d9a86df 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -2182,12 +2182,36 @@ static int smu_smc_hw_cleanup(struct
> > smu_context *smu)  static int smu_reset_mp1_state(struct smu_context
> > *smu)  {
> >         struct amdgpu_device *adev =3D smu->adev;
> > -       int ret =3D 0;
> > +       u32 mp1_version =3D amdgpu_ip_version(adev, MP1_HWIP, 0);
> > +       bool needs_mp1_unload;
> > +       int ret;
> >
> > -       if ((!adev->in_runpm) && (!adev->in_suspend) &&
> > -               (!amdgpu_in_reset(adev)) && !smu->is_apu &&
> > -                       amdgpu_ip_version(adev, MP1_HWIP, 0) >=3D IP_VE=
RSION(13, 0, 0))
> > -               ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
> > +       if (adev->in_runpm || amdgpu_in_reset(adev) || smu->is_apu)
> > +               return 0;
> > +
> > +       switch (mp1_version) {
> > +       case IP_VERSION(11, 0, 7):
> > +       case IP_VERSION(11, 0, 11):
> > +       case IP_VERSION(11, 0, 12):
> > +       case IP_VERSION(11, 0, 13):
> > +               /*
> > +                * These SMU versions require MP1 unload before system =
suspend.
> > +                * The shutdown path already requests it through mp1_st=
ate.
> > +                */
> > +               needs_mp1_unload =3D adev->mp1_state !=3D PP_MP1_STATE_=
UNLOAD;
> > +               break;
> > +       default:
> > +               needs_mp1_unload =3D !adev->in_suspend &&
> > +                       mp1_version >=3D IP_VERSION(13, 0, 0);
> > +               break;
> > +       }
> > +
> > +       if (!needs_mp1_unload)
> > +               return 0;
> > +
> > +       ret =3D smu_set_mp1_state(smu, PP_MP1_STATE_UNLOAD);
> > +       if (!ret && adev->in_suspend)
> > +               adev->psp.smu_fw_needs_reload =3D true;
> >
> >         return ret;
> >  }
> > @@ -2279,6 +2303,10 @@ static int smu_suspend(struct amdgpu_ip_block *i=
p_block)
> >         if (ret)
> >                 return ret;
> >
> > +       ret =3D smu_reset_mp1_state(smu);
> > +       if (ret)
> > +               return ret;
> > +
> >         smu->watermarks_bitmap &=3D ~(WATERMARKS_LOADED);
> >
> >         smu_set_gfx_cgpg(smu, false);
> > --
> > 2.54.0
> >
