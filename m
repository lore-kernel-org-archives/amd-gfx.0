Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481D2C4828F
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 22:40:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E563210EB64;
	Wed,  7 Feb 2024 22:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gUurA1j9";
	dkim-atps=neutral
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53F9C10EB64
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 22:40:12 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-214ca209184so777232fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Feb 2024 14:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707345611; x=1707950411; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=unEf4OJp1khL23CcDyBrpz/lxzpIvdyB21jXVuRzZoE=;
 b=gUurA1j9ntiYloodV+Nebt4bL7D3VhvxiBt5DSCq+mbFHOIH0VnKXYIZOR9Kad+dwB
 jtqTQYBwtHtMfHBfjP4RgJDcA4cRbKRZ4BHHsJMIxjlT+/lIQ/JuN8XXLFCwl/MuXIAg
 NXwQoSbeKEBoy32Er3z2TZkYgg6diMV9pvnN+1Grxq+Alp7HuQQHFbYWKRJyIvFUtvNF
 bgDVglOcHEMP7HohWhpWfq3s4iimt0xWcCI4Bs7C+nLPNLX7rQJ5/Idm1GjYLF3BvR3u
 hMFwdhsoqgYNDdIiUwy+wbiew+VG9NJKxhCEQnXx+fo/RLR3tavH7qzXWNexALZjyNiv
 DPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707345611; x=1707950411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=unEf4OJp1khL23CcDyBrpz/lxzpIvdyB21jXVuRzZoE=;
 b=L7B97X61VMgJ6lnxBTkjeNP6K9YtQS+qywcuQiKtgxw9Dzq8wMfpaNyvEM2yXNBRRM
 Lycikl3cM1PI9o6NMvzlg89dvKvtV7eBLjeqc0kFnvAv46TXsAbY8mxgDwuvgT46vhyH
 RtQNKY9M571hA40oUguvsFIazp802zcHGYuxHNXBzCx2dvMOtO45ZaHzB/eOeXiU9RMS
 Sn/aN8MFeUeXPV6C5rN+mEUoturQOzNU0jzgbdPTcX0GNO1ysuDtjpkJSsxLtCCqwPTD
 rSsuJaohayXtOlF1PKVtTuXCkCJlL7g2Uu4RoFA49Lx8nAXG7ZmTtlq2qF2LwfG2Mnhp
 T85w==
X-Gm-Message-State: AOJu0Yzh/AA739aBt75HkCNrLRUurBu6ODss1TIliRdcIAJOJ7VgaAHU
 cmD6TJc+nJq58mDbhtfusdvckZwhHBDi2kNgU1El3PmxD56N6drRDe0Ud2/Od0hr56wghfFsu4E
 YWci2vK+JbbWHZX+OfExESOPXsgWO/GHk
X-Google-Smtp-Source: AGHT+IHGP5xSyDf+7GA84FnthjTuTggd9HYM6P3GVk7/AryBvZKmsv/PTyV+MGmdbQ+tmppsT51q7K81uC8dbNCsaXg=
X-Received: by 2002:a05:6870:e313:b0:219:4352:fc45 with SMTP id
 z19-20020a056870e31300b002194352fc45mr7913274oad.56.1707345611424; Wed, 07
 Feb 2024 14:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20240207204103.82789-1-mario.limonciello@amd.com>
 <20240207204103.82789-2-mario.limonciello@amd.com>
 <CADnq5_NZWoO_0tXx74P785H75ZBJph=nF_5XbAqkpBEztK9vSQ@mail.gmail.com>
 <4f58703b-f74d-4897-b100-f1e867297184@amd.com>
In-Reply-To: <4f58703b-f74d-4897-b100-f1e867297184@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Feb 2024 17:40:00 -0500
Message-ID: <CADnq5_PGJd9hOz_-oA6hpans1SKraOt4ZDOV=1Q4wp1TK50OEA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amd: Stop evicting resources on APUs in suspend
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
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

On Wed, Feb 7, 2024 at 5:36=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 2/7/2024 16:34, Alex Deucher wrote:
> > On Wed, Feb 7, 2024 at 3:48=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> commit 5095d5418193 ("drm/amd: Evict resources during PM ops prepare()=
 callback")
> >> intentionally moved the eviction of resources to earlier in the suspen=
d
> >> process, but this introduced a subtle change that it occurs before ade=
v->in_s0ix
> >> or adev->in_s3 are set. This meant that APUs actually started to evict
> >> resources at suspend time as well.
> >>
> >> Add a new `in_prepare` flag that is set for the life of the prepare() =
callback
> >> to return the old code flow. Drop the existing call to return 1 in thi=
s case because
> >> the suspend() callback looks for the flags too.
> >>
> >> Also, introduce a new amdgpu_device_freeze() function to call at S4 an=
d evict
> >> resources in this callback so that APUs will still get resources evict=
ed.
> >>
> >> Reported-by: J=C3=BCrg Billeter <j@bitron.ch>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3132#note_2271=
038
> >> Fixes: 5095d5418193 ("drm/amd: Evict resources during PM ops prepare()=
 callback")
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >> v1->v2:
> >>   * Add and use new in_prepare member
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  4 +-
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 46 ++++++++++++++++++++=
--
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 21 ++--------
> >>   3 files changed, 48 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h
> >> index 5d5be3e20687..f9db09a9017a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -1075,7 +1075,8 @@ struct amdgpu_device {
> >>          u8                              reset_magic[AMDGPU_RESET_MAGI=
C_NUM];
> >>
> >>          /* s3/s4 mask */
> >> -       bool                            in_suspend;
> >> +       bool                            in_prepare;
> >> +       bool                            in_suspend;
> >>          bool                            in_s3;
> >>          bool                            in_s4;
> >>          bool                            in_s0ix;
> >> @@ -1462,6 +1463,7 @@ int amdgpu_device_ip_suspend(struct amdgpu_devic=
e *adev);
> >>   int amdgpu_device_prepare(struct drm_device *dev);
> >>   int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
> >>   int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
> >> +int amdgpu_device_freeze(struct drm_device *drm_dev);
> >>   u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
> >>   int amdgpu_enable_vblank_kms(struct drm_crtc *crtc);
> >>   void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index 2bc460cb993d..0a337fcd89b4 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -4492,7 +4492,7 @@ static int amdgpu_device_evict_resources(struct =
amdgpu_device *adev)
> >>          int ret;
> >>
> >>          /* No need to evict vram on APUs for suspend to ram or s2idle=
 */
> >> -       if ((adev->in_s3 || adev->in_s0ix) && (adev->flags & AMD_IS_AP=
U))
> >> +       if ((adev->in_prepare) && (adev->flags & AMD_IS_APU))
> >
> > Could probably simplify this to:
> > if ((!adev->in_s4) && (adev->flags & AMD_IS_APU))
> >
> > Then you could drop the in_prepare variable.
> >
> >>                  return 0;
> >>
> >>          ret =3D amdgpu_ttm_evict_resources(adev, TTM_PL_VRAM);
> >> @@ -4521,10 +4521,12 @@ int amdgpu_device_prepare(struct drm_device *d=
ev)
> >>          if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
> >>                  return 0;
> >>
> >> +       adev->in_prepare =3D true;
> >> +
> >>          /* Evict the majority of BOs before starting suspend sequence=
 */
> >>          r =3D amdgpu_device_evict_resources(adev);
> >>          if (r)
> >> -               return r;
> >> +               goto unprepare;
> >>
> >>          for (i =3D 0; i < adev->num_ip_blocks; i++) {
> >>                  if (!adev->ip_blocks[i].status.valid)
> >> @@ -4533,10 +4535,46 @@ int amdgpu_device_prepare(struct drm_device *d=
ev)
> >>                          continue;
> >>                  r =3D adev->ip_blocks[i].version->funcs->prepare_susp=
end((void *)adev);
> >>                  if (r)
> >> -                       return r;
> >> +                       goto unprepare;
> >>          }
> >>
> >> -       return 0;
> >> +unprepare:
> >> +       adev->in_prepare =3D FALSE;
> >> +
> >> +       return r;
> >> +}
> >> +
> >> +/**
> >> + * amdgpu_device_freeze - run S4 sequence
> >> + *
> >> + * @dev: drm dev pointer
> >> + *
> >> + * Prepare to put the hw in the S4 state (all asics).
> >> + * Returns 0 for success or an error on failure.
> >> + * Called at driver freeze.
> >> + */
> >> +int amdgpu_device_freeze(struct drm_device *drm_dev)
> >> +{
> >> +       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >> +       int r;
> >> +
> >> +       adev->in_s4 =3D true;
> >> +
> >> +       r =3D amdgpu_device_evict_resources(adev);
> >
> > Won't this be too late to allocate memory?  Doesn't this need to
> > happen in prepare() even for S4?
>
> Hmm; possibly.  I'll swap it back with your other suggestion.

I think we need to know at prepare time what state we are targeting.
I think that would allow us to clean up a lot of the in_s3, in_s4,
in_s0x checks.  Something like adev->target_pm_state maybe?

Alex

>
> Thanks
> >
> > Alex
> >
> >> +       if (r)
> >> +               goto cleanup;
> >> +
> >> +       r =3D amdgpu_device_suspend(drm_dev, true);
> >> +       if (r)
> >> +               goto cleanup;
> >> +
> >> +       if (amdgpu_acpi_should_gpu_reset(adev))
> >> +               r =3D amdgpu_asic_reset(adev);
> >> +
> >> +cleanup:
> >> +       adev->in_s4 =3D false;
> >> +
> >> +       return r;
> >>   }
> >>
> >>   /**
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c
> >> index b74f68a15802..fc9caa14c9d6 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -2456,6 +2456,7 @@ static int amdgpu_pmops_prepare(struct device *d=
ev)
> >>   {
> >>          struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >>          struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >> +       int r;
> >>
> >>          /* Return a positive number here so
> >>           * DPM_FLAG_SMART_SUSPEND works properly
> >> @@ -2464,13 +2465,6 @@ static int amdgpu_pmops_prepare(struct device *=
dev)
> >>              pm_runtime_suspended(dev))
> >>                  return 1;
> >>
> >> -       /* if we will not support s3 or s2i for the device
> >> -        *  then skip suspend
> >> -        */
> >> -       if (!amdgpu_acpi_is_s0ix_active(adev) &&
> >> -           !amdgpu_acpi_is_s3_active(adev))
> >> -               return 1;
> >> -
> >>          return amdgpu_device_prepare(drm_dev);
> >>   }
> >>
> >> @@ -2488,6 +2482,7 @@ static int amdgpu_pmops_suspend(struct device *d=
ev)
> >>                  adev->in_s0ix =3D true;
> >>          else if (amdgpu_acpi_is_s3_active(adev))
> >>                  adev->in_s3 =3D true;
> >> +
> >>          if (!adev->in_s0ix && !adev->in_s3)
> >>                  return 0;
> >>          return amdgpu_device_suspend(drm_dev, true);
> >> @@ -2528,18 +2523,8 @@ static int amdgpu_pmops_resume(struct device *d=
ev)
> >>   static int amdgpu_pmops_freeze(struct device *dev)
> >>   {
> >>          struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> >> -       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> >> -       int r;
> >> -
> >> -       adev->in_s4 =3D true;
> >> -       r =3D amdgpu_device_suspend(drm_dev, true);
> >> -       adev->in_s4 =3D false;
> >> -       if (r)
> >> -               return r;
> >>
> >> -       if (amdgpu_acpi_should_gpu_reset(adev))
> >> -               return amdgpu_asic_reset(adev);
> >> -       return 0;
> >> +       return amdgpu_device_freeze(drm_dev);
> >>   }
> >>
> >>   static int amdgpu_pmops_thaw(struct device *dev)
> >> --
> >> 2.34.1
> >>
>
