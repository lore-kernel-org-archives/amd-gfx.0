Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CC9C3DA66
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Aug 2023 13:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FEF610E688;
	Fri, 25 Aug 2023 13:01:19 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5111C10E686
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 13:01:17 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-570f0cb0c1eso553871eaf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Aug 2023 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692968476; x=1693573276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oS6wueY5M6XJ3swlOVPlLRXnvkIBM7Vv+MT61xuH6/U=;
 b=DFfunTDYYmet6i6CIle3AGofqY29462P2AHgs7ra3Q7Ooc8kt4hKoN56fBLOLZJp+M
 fJBt9fJLRUWDvfLEor22f9t7X2lr27Y8V3htHT6ethyVvHSShWewxDC3AJQ43rrKtGcH
 wLbCKMYdeNW/rpJAWJI3pVcgwNeAn9H4xoxAK4FlH9R5NV+rD8qr3o423efvCxUaleOd
 Ld/sTJ6TgJHiWSbdb/AAj+duNHGMIYJiY3Mq0adFRKvFP1fNntcOhbADBvMgWN+C7K2X
 mCsFIjCiylWgtImHmOx4GF75ZsXiLvIbh1BRsQCA/j/kb/E4eUnXSEg6M1zQkuwBU5Xv
 /UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692968476; x=1693573276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oS6wueY5M6XJ3swlOVPlLRXnvkIBM7Vv+MT61xuH6/U=;
 b=c5lZ57REwd2ZkSLdXMObKsBmo+wZyq1aGwDtRmq34CQLMoYus5zXYtNS+r+StEl26C
 OBl9DPiLsSES/ktdm/jST6zQVaEEZf/GH8hrz2bRe6inY0DiU+v34opaztEVO/M33Tl3
 I/NM8e0hGZw6UF2y3q48D3+y61xEqjcec6k1yqQtHwOrHpt1T5HYuv+w81tYb5X/7Zt9
 3dC4J/jLWOQDzKE95fCCz4WEehw84moUEWl4Wr4pgmgkEdYp0OwPU0Cb0QgwQajF4pMY
 tMvGa+JpLBXMpJcu0TIEJopwsGlzD9nJVNXurUKl/TFiNdN6mRj957H+kFbmub9nV08x
 lk8g==
X-Gm-Message-State: AOJu0YxhvXbTC4YfxOGK1ub6HW/od4ku6JdbbZ+TW43GfPBR+qF90zGv
 DkGKnu5mPqm138fNNlcV5L6i/xQVMwqMccN6AnQ=
X-Google-Smtp-Source: AGHT+IGa9gXSkd3Aewr3aDPfGa0weAdKmhNZ9Yvxtm1lWmZCfsnqHoxYeluDHLvC6fwnlqq6TBOTN2/IVYtBY1DiyNY=
X-Received: by 2002:a4a:6211:0:b0:56e:4921:deb0 with SMTP id
 x17-20020a4a6211000000b0056e4921deb0mr4938805ooc.8.1692968465834; Fri, 25 Aug
 2023 06:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230823063406.1195151-1-evan.quan@amd.com>
 <20230823063406.1195151-3-evan.quan@amd.com>
 <CADnq5_N4vB_mDX0ofpc8ivonAZ3vu3xPOHj3KHoy2UB_L0rgxA@mail.gmail.com>
 <DM6PR12MB2619C63084EA0C0BD945F009E41DA@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_Nyr_3v8HWV0oC2Cp5CW3McxxObB9vGXb3XZt-e22QKKQ@mail.gmail.com>
 <DM6PR12MB26193AF3C6F4B7CF20A62B0CE4E3A@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26193AF3C6F4B7CF20A62B0CE4E3A@DM6PR12MB2619.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Aug 2023 09:00:54 -0400
Message-ID: <CADnq5_MK2esPLX25=++vbMs62LLehcyPiH5Qha0_BMwbS68STg@mail.gmail.com>
Subject: Re: [V2 3/8] drm/amd/pm: add fan mode OD setting support for SMU13
To: "Quan, Evan" <Evan.Quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 24, 2023 at 10:02=E2=80=AFPM Quan, Evan <Evan.Quan@amd.com> wro=
te:
>
> [AMD Official Use Only - General]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, August 24, 2023 10:51 PM
> > To: Quan, Evan <Evan.Quan@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Subject: Re: [V2 3/8] drm/amd/pm: add fan mode OD setting support for
> > SMU13
> >
> > On Wed, Aug 23, 2023 at 10:28=E2=80=AFPM Quan, Evan <Evan.Quan@amd.com>
> > wrote:
> > >
> > > [AMD Official Use Only - General]
> > >
> > > > -----Original Message-----
> > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > Sent: Wednesday, August 23, 2023 9:29 PM
> > > > To: Quan, Evan <Evan.Quan@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>
> > > > Subject: Re: [V2 3/8] drm/amd/pm: add fan mode OD setting support
> > > > for
> > > > SMU13
> > > >
> > > > On Wed, Aug 23, 2023 at 2:45=E2=80=AFAM Evan Quan <evan.quan@amd.co=
m>
> > > > wrote:
> > > > >
> > > > > Add SMU13 fan mode OD setting support.
> > > > >
> > > > > Signed-off-by: Evan Quan <evan.quan@amd.com>
> > > > > --
> > > > > v1->v2:
> > > > >   - add missing kerneldoc for the new interface(Alex)
> > > > > ---
> > > > >  Documentation/gpu/amdgpu/thermal.rst          |   6 +
> > > > >  .../gpu/drm/amd/include/kgd_pp_interface.h    |   4 +-
> > > > >  drivers/gpu/drm/amd/pm/amdgpu_pm.c            | 200
> > > > +++++++++++++++++-
> > > > >  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |   4 +
> > > > >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   2 +
> > > > >  drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |   1 +
> > > > >  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  35 ++-
> > > > > .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  35 ++-
> > > > >  8 files changed, 279 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/Documentation/gpu/amdgpu/thermal.rst
> > > > > b/Documentation/gpu/amdgpu/thermal.rst
> > > > > index 5e27e4eb3959..8757ec7f0136 100644
> > > > > --- a/Documentation/gpu/amdgpu/thermal.rst
> > > > > +++ b/Documentation/gpu/amdgpu/thermal.rst
> > > > > @@ -64,6 +64,12 @@ gpu_metrics
> > > > >  .. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > > > >     :doc: gpu_metrics
> > > > >
> > > > > +fan_mode
> > > > > +--------
> > > > > +
> > > > > +.. kernel-doc:: drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > > > > +   :doc: fan_mode
> > > > > +
> > > > >  GFXOFF
> > > > >  =3D=3D=3D=3D=3D=3D
> > > > >
> > > > > diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > > > b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > > > index 84c5224d994c..020c9ce1f735 100644
> > > > > --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > > > +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > > > > @@ -113,6 +113,7 @@ enum pp_clock_type {
> > > > >         OD_RANGE,
> > > > >         OD_VDDGFX_OFFSET,
> > > > >         OD_CCLK,
> > > > > +       OD_FAN_MODE,
> > > > >  };
> > > > >
> > > > >  enum amd_pp_sensors {
> > > > > @@ -186,7 +187,8 @@ enum PP_OD_DPM_TABLE_COMMAND {
> > > > >         PP_OD_EDIT_VDDC_CURVE,
> > > > >         PP_OD_RESTORE_DEFAULT_TABLE,
> > > > >         PP_OD_COMMIT_DPM_TABLE,
> > > > > -       PP_OD_EDIT_VDDGFX_OFFSET
> > > > > +       PP_OD_EDIT_VDDGFX_OFFSET,
> > > > > +       PP_OD_EDIT_FAN_MODE,
> > > > >  };
> > > > >
> > > > >  struct pp_states_info {
> > > > > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > > > > b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > > > > index beb3303fc832..d53d60903fe9 100644
> > > > > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > > > > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > > > > @@ -3383,7 +3383,205 @@ static const struct attribute_group
> > > > *hwmon_groups[] =3D {
> > > > >         NULL
> > > > >  };
> > > > >
> > > > > -static struct od_feature_set amdgpu_od_set;
> > > > > +static int amdgpu_retrieve_od_settings(struct amdgpu_device *ade=
v,
> > > > > +                                      enum pp_clock_type od_type=
,
> > > > > +                                      char *buf) {
> > > > > +       int size =3D 0;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (amdgpu_in_reset(adev))
> > > > > +               return -EPERM;
> > > > > +       if (adev->in_suspend && !adev->in_runpm)
> > > > > +               return -EPERM;
> > > > > +
> > > > > +       ret =3D pm_runtime_get_sync(adev->dev);
> > > > > +       if (ret < 0) {
> > > > > +               pm_runtime_put_autosuspend(adev->dev);
> > > > > +               return ret;
> > > > > +       }
> > > > > +
> > > > > +       size =3D amdgpu_dpm_print_clock_levels(adev, od_type, buf=
);
> > > > > +       if (size =3D=3D 0)
> > > > > +               size =3D sysfs_emit(buf, "\n");
> > > > > +
> > > > > +       pm_runtime_mark_last_busy(adev->dev);
> > > > > +       pm_runtime_put_autosuspend(adev->dev);
> > > > > +
> > > > > +       return size;
> > > > > +}
> > > > > +
> > > > > +static int parse_input_od_command_lines(const char *buf,
> > > > > +                                       size_t count,
> > > > > +                                       u32 *type,
> > > > > +                                       long *params,
> > > > > +                                       uint32_t *num_of_params) =
{
> > > > > +       const char delimiter[3] =3D {' ', '\n', '\0'};
> > > > > +       uint32_t parameter_size =3D 0;
> > > > > +       char buf_cpy[128] =3D {0};
> > > > > +       char *tmp_str, *sub_str;
> > > > > +       int ret;
> > > > > +
> > > > > +       if (count > sizeof(buf_cpy) - 1)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       memcpy(buf_cpy, buf, count);
> > > > > +       tmp_str =3D buf_cpy;
> > > > > +
> > > > > +       /* skip heading spaces */
> > > > > +       while (isspace(*tmp_str))
> > > > > +               tmp_str++;
> > > > > +
> > > > > +       switch (*tmp_str) {
> > > > > +       case 'c':
> > > > > +               *type =3D PP_OD_COMMIT_DPM_TABLE;
> > > > > +               return 0;
> > > > > +       default:
> > > > > +               break;
> > > > > +       }
> > > > > +
> > > > > +       while ((sub_str =3D strsep(&tmp_str, delimiter)) !=3D NUL=
L) {
> > > > > +               if (strlen(sub_str) =3D=3D 0)
> > > > > +                       continue;
> > > > > +
> > > > > +               ret =3D kstrtol(sub_str, 0, &params[parameter_siz=
e]);
> > > > > +               if (ret)
> > > > > +                       return -EINVAL;
> > > > > +               parameter_size++;
> > > > > +
> > > > > +               while (isspace(*tmp_str))
> > > > > +                       tmp_str++;
> > > > > +       }
> > > > > +
> > > > > +       *num_of_params =3D parameter_size;
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +static int
> > > > > +amdgpu_distribute_custom_od_settings(struct amdgpu_device *adev,
> > > > > +                                    enum PP_OD_DPM_TABLE_COMMAND=
 cmd_type,
> > > > > +                                    const char *in_buf,
> > > > > +                                    size_t count) {
> > > > > +       uint32_t parameter_size =3D 0;
> > > > > +       long parameter[64];
> > > > > +       int ret;
> > > > > +
> > > > > +       if (amdgpu_in_reset(adev))
> > > > > +               return -EPERM;
> > > > > +       if (adev->in_suspend && !adev->in_runpm)
> > > > > +               return -EPERM;
> > > > > +
> > > > > +       ret =3D parse_input_od_command_lines(in_buf,
> > > > > +                                          count,
> > > > > +                                          &cmd_type,
> > > > > +                                          parameter,
> > > > > +                                          &parameter_size);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       ret =3D pm_runtime_get_sync(adev->dev);
> > > > > +       if (ret < 0)
> > > > > +               goto err_out0;
> > > > > +
> > > > > +       ret =3D amdgpu_dpm_odn_edit_dpm_table(adev,
> > > > > +                                           cmd_type,
> > > > > +                                           parameter,
> > > > > +                                           parameter_size);
> > > > > +       if (ret)
> > > > > +               goto err_out1;
> > > > > +
> > > > > +       if (cmd_type =3D=3D PP_OD_COMMIT_DPM_TABLE) {
> > > > > +               ret =3D amdgpu_dpm_dispatch_task(adev,
> > > > > +                                              AMD_PP_TASK_READJU=
ST_POWER_STATE,
> > > > > +                                              NULL);
> > > > > +               if (ret)
> > > > > +                       goto err_out1;
> > > > > +       }
> > > > > +
> > > > > +       pm_runtime_mark_last_busy(adev->dev);
> > > > > +       pm_runtime_put_autosuspend(adev->dev);
> > > > > +
> > > > > +       return count;
> > > > > +
> > > > > +err_out1:
> > > > > +       pm_runtime_mark_last_busy(adev->dev);
> > > > > +err_out0:
> > > > > +       pm_runtime_put_autosuspend(adev->dev);
> > > > > +
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * DOC: fan_mode
> > > > > + *
> > > > > + * The amdgpu driver provides a sysfs API for checking and
> > > > > +adjusting the fan
> > > > > + * control mode.
> > > > > + *
> > > > > + * Reading back the file shows you current fan control mode (e.g=
. '0'
> > > > > +for auto
> > > > > + * mode and '1' for manual mode) and permitted settings if chang=
able.
> > > >
> > > > typo: changeable
> > > >
> > > > Also what does manual vs auto mean in this case?  Is the idea that
> > > > you need to switch to manual mode before you make any other
> > > > adjustments (fan curve or
> > > > acoustic) or is this some independent setting?
> > > Auto mode here means PMFW handling the fan speed control in response =
to
> > the asic temperature. While driver/user can do some fine tuning like ac=
oustic
> > limit/target, fan target-temperature and minimum pwm.
> > > Manual mode here means the fan curve setting specifically. Driver/use=
r can
> > customize how the fan speed in response to the asic temperature.
> > > The two modes are mutually exclusive. Switching to one mode will inva=
lid all
> > those settings installed for the other mode.
> > > Per current implementation for SMU13.0.0 and 13.0.7, user does not ne=
ed
> > to adjust the fan mode manually. Driver will handle that. For example, =
on
> > user's setting of fan curve, driver will handle the fan mode switching =
to manual
> > mode.
> > >
> >
> > If I understand things correctly, the driver will automatically set man=
ual mode
> > if the user adjusts the fan curve?  If so, do we need a separate attrib=
ute for
> > manual vs automatic?  For the documentation, I'd like to see all of the=
 fan
> > options and what sets are required to enable them and what combinations=
 are
> > allowed.
> >
> > 1. temp/pwm fan curve - requires setting manual mode.  Mutually exclusi=
ve
> > with 2, 3.
> > 2. acoustic targets - requires setting manual mode.  Mutually exclusive=
 with 1,
> > 3.
> > 3. temperature targets - requires setting manual mode.  Mutually exclus=
ive
> > with 1, 2.
> > 4. minimum fan speed - requires setting manual mode.  works with 1,2,3.
> >
> > If the first 3 are mutually exclusive, then maybe we need a fan mode at=
tribute
> > with the following options:
> > 0. auto - let the SMU manage the fan
> > 1. manual - temp/pwm curve
> > 2. manual - acoustic targets
> > 3. manual - temp targets
> [Quan, Evan] No, not such complicated. There are only two fan control mod=
e: auto and manual.
> The settings working under manual mode:  temp/pwm curve settings
> The settings working under auto mode: all others (acoustic limit/target, =
temperature target, minimum pwm...)
> And those settings for auto mode can co-work with each other. They affect=
 the auto fan control via different manners and are not mutually exclusive.
> >
> > If they are not mutually exclusive, then how do they interact?  E.g., w=
hat
> > happens if you set a custom temp/pwm curve and acoustic targets and the=
y
> > are not compatible?  Does that make sense?
> [Quan, Evan] For the sequence above:
> 1. set a custom temp/pwm curve
>   - this will switch the fan control to manual mode in order to make the =
settings to take effect
>   - this will invalid all other settings working under auto mode only
> 2. acoustic targets
>   - this will switch the fan control to auto mode in order to make the se=
tting to take effect
>   - this will invalid the temp/pwm curve settings working under manual mo=
de only
>

Thanks for clarifying.  Can you include this information in the
kerneldoc?  Also, I think we should either:
1. make the auto/manual required to select enable their respective
subfeatures.  (e.g., fail to set the fan curve if auto and vice versa
for the other features)
2. remove the auto/manual attribute and make whatever was last set
take priority.
and document it.

I think 1 is the most obvious from a user perspective, but I don't
have that strong of an opinion.

Alex


> Evan
> >
> > Alex
> >
> >
> >
> > > Please check whether the explanations above make sense to you.  I can=
 add
> > them in the code comment part.
> > >
> > > Evan
> > > >
> > > > Alex
> > > >
> > > > > + *
> > > > > + * Writing an integer to the file, sets the fan control mode
> > correspondingly.
> > > > > + *
> > > > > + * When you have finished the editing, write "c" (commit) to the
> > > > > +file to commit
> > > > > + * your changes.
> > > > > + */
> > > > > +static ssize_t fan_mode_show(struct kobject *kobj,
> > > > > +                            struct kobj_attribute *attr,
> > > > > +                            char *buf) {
> > > > > +       struct od_kobj *container =3D container_of(kobj, struct o=
d_kobj, kobj);
> > > > > +       struct amdgpu_device *adev =3D (struct amdgpu_device
> > > > > +*)container->priv;
> > > > > +
> > > > > +       return (ssize_t)amdgpu_retrieve_od_settings(adev,
> > > > > +OD_FAN_MODE, buf); }
> > > > > +
> > > > > +static ssize_t fan_mode_store(struct kobject *kobj,
> > > > > +                             struct kobj_attribute *attr,
> > > > > +                             const char *buf,
> > > > > +                             size_t count) {
> > > > > +       struct od_kobj *container =3D container_of(kobj, struct o=
d_kobj, kobj);
> > > > > +       struct amdgpu_device *adev =3D (struct amdgpu_device
> > > > > +*)container->priv;
> > > > > +
> > > > > +       return (ssize_t)amdgpu_distribute_custom_od_settings(adev=
,
> > > > > +                                                            PP_O=
D_EDIT_FAN_MODE,
> > > > > +                                                            buf,
> > > > > +
> > > > > + count); }
> > > > > +
> > > > > +static umode_t fan_mode_visible(struct amdgpu_device *adev) {
> > > > > +       umode_t umode =3D 0000;
> > > > > +
> > > > > +       if (adev->pm.od_feature_mask &
> > > > OD_OPS_SUPPORT_FAN_MODE_RETRIEVE)
> > > > > +               umode |=3D S_IRUSR | S_IRGRP | S_IROTH;
> > > > > +
> > > > > +       if (adev->pm.od_feature_mask &
> > OD_OPS_SUPPORT_FAN_MODE_SET)
> > > > > +               umode |=3D S_IWUSR;
> > > > > +
> > > > > +       return umode;
> > > > > +}
> > > > > +
> > > > > +static struct od_feature_set amdgpu_od_set =3D {
> > > > > +       .containers =3D {
> > > > > +               [0] =3D {
> > > > > +                       .name =3D "fan_ctrl",
> > > > > +                       .sub_feature =3D {
> > > > > +                               [0] =3D {
> > > > > +                                       .name =3D "fan_mode",
> > > > > +                                       .ops =3D {
> > > > > +                                               .is_visible =3D f=
an_mode_visible,
> > > > > +                                               .show =3D fan_mod=
e_show,
> > > > > +                                               .store =3D fan_mo=
de_store,
> > > > > +                                       },
> > > > > +                               },
> > > > > +                       },
> > > > > +               },
> > > > > +       },
> > > > > +};
> > > > >
> > > > >  static void od_kobj_release(struct kobject *kobj)  { diff --git
> > > > > a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > > > > b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > > > > index 4cab6a2efb63..b54f84e2408a 100644
> > > > > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > > > > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > > > > @@ -314,6 +314,9 @@ struct config_table_setting
> > > > >         uint16_t fclk_average_tau;  };
> > > > >
> > > > > +#define OD_OPS_SUPPORT_FAN_MODE_RETRIEVE               BIT(0)
> > > > > +#define OD_OPS_SUPPORT_FAN_MODE_SET                    BIT(1)
> > > > > +
> > > > >  struct amdgpu_pm {
> > > > >         struct mutex            mutex;
> > > > >         u32                     current_sclk;
> > > > > @@ -368,6 +371,7 @@ struct amdgpu_pm {
> > > > >         enum amdgpu_runpm_mode rpm_mode;
> > > > >
> > > > >         struct list_head        od_kobj_list;
> > > > > +       uint32_t                od_feature_mask;
> > > > >  };
> > > > >
> > > > >  int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum
> > > > > amd_pp_sensors sensor, diff --git
> > > > > a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > index f005a90c35af..01ccfd219d6b 100644
> > > > > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > > > > @@ -2481,6 +2481,8 @@ static enum smu_clk_type
> > > > smu_convert_to_smuclk(enum pp_clock_type type)
> > > > >                 clk_type =3D SMU_OD_VDDGFX_OFFSET; break;
> > > > >         case OD_CCLK:
> > > > >                 clk_type =3D SMU_OD_CCLK; break;
> > > > > +       case OD_FAN_MODE:
> > > > > +               clk_type =3D SMU_OD_FAN_MODE; break;
> > > > >         default:
> > > > >                 clk_type =3D SMU_CLK_COUNT; break;
> > > > >         }
> > > > > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> > > > > b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> > > > > index e57265cf637c..498000850212 100644
> > > > > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> > > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> > > > > @@ -280,6 +280,7 @@ enum smu_clk_type {
> > > > >         SMU_OD_VDDC_CURVE,
> > > > >         SMU_OD_RANGE,
> > > > >         SMU_OD_VDDGFX_OFFSET,
> > > > > +       SMU_OD_FAN_MODE,
> > > > >         SMU_CLK_COUNT,
> > > > >  };
> > > > >
> > > > > diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > > > > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > > > > index 1041ba22f8f8..45b42e43f9a3 100644
> > > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> > > > > @@ -101,6 +101,7 @@
> > > > >  #define PP_OD_FEATURE_UCLK_FMIN                                2
> > > > >  #define PP_OD_FEATURE_UCLK_FMAX                                3
> > > > >  #define PP_OD_FEATURE_GFX_VF_CURVE                     4
> > > > > +#define PP_OD_FEATURE_FAN_MODE                         5
> > > > >
> > > > >  #define LINK_SPEED_MAX                                 3
> > > > >
> > > > > @@ -1110,6 +1111,10 @@ static void
> > > > smu_v13_0_0_get_od_setting_limits(struct smu_context *smu,
> > > > >                 od_min_setting =3D overdrive_lowerlimits-
> > > > >VoltageOffsetPerZoneBoundary;
> > > > >                 od_max_setting =3D overdrive_upperlimits-
> > > > >VoltageOffsetPerZoneBoundary;
> > > > >                 break;
> > > > > +       case PP_OD_FEATURE_FAN_MODE:
> > > > > +               od_min_setting =3D overdrive_lowerlimits->FanMode=
;
> > > > > +               od_max_setting =3D overdrive_upperlimits->FanMode=
;
> > > > > +               break;
> > > > >         default:
> > > > >                 od_min_setting =3D od_max_setting =3D INT_MAX;
> > > > >                 break;
> > > > > @@ -1329,6 +1334,16 @@ static int
> > > > > smu_v13_0_0_print_clk_levels(struct
> > > > smu_context *smu,
> > > > >                                       od_table-
> > > > >OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
> > > > >                 break;
> > > > >
> > > > > +       case SMU_OD_FAN_MODE:
> > > > > +               if (!smu_v13_0_0_is_od_feature_supported(smu,
> > > > > +                                                        PP_OD_FE=
ATURE_FAN_CURVE_BIT))
> > > > > +                       break;
> > > > > +
> > > > > +               size +=3D sysfs_emit_at(buf, size, "OD_FAN_MODE:\=
n");
> > > > > +               size +=3D sysfs_emit_at(buf, size, "%d\n",
> > > > > +                                       (int)od_table->OverDriveT=
able.FanMode);
> > > > > +               break;
> > > > > +
> > > > >         case SMU_OD_RANGE:
> > > > >                 if (!smu_v13_0_0_is_od_feature_supported(smu,
> > > > PP_OD_FEATURE_GFXCLK_BIT) &&
> > > > >                     !smu_v13_0_0_is_od_feature_supported(smu,
> > > > > PP_OD_FEATURE_UCLK_BIT) && @@ -1789,6 +1804,15 @@ static
> > ssize_t
> > > > smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
> > > > >         return sizeof(struct gpu_metrics_v1_3);  }
> > > > >
> > > > > +static void smu_v13_0_0_set_supported_od_feature_mask(struct
> > > > > +smu_context *smu) {
> > > > > +       struct amdgpu_device *adev =3D smu->adev;
> > > > > +
> > > > > +       if (smu_v13_0_0_is_od_feature_supported(smu,
> > > > > +                                               PP_OD_FEATURE_FAN=
_CURVE_BIT))
> > > > > +               adev->pm.od_feature_mask |=3D
> > > > > +OD_OPS_SUPPORT_FAN_MODE_RETRIEVE; }
> > > > > +
> > > > >  static int smu_v13_0_0_set_default_od_settings(struct smu_contex=
t
> > > > > *smu)  {
> > > > >         OverDriveTableExternal_t *od_table =3D @@ -1838,8 +1862,1=
2
> > > > >@@  static int smu_v13_0_0_set_default_od_settings(struct
> > smu_context *smu)
> > > > >                 for (i =3D 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
> > > > >                         user_od_table-
> > > > >OverDriveTable.VoltageOffsetPerZoneBoundary[i] =3D
> > > > >
> > > > > user_od_table_bak.OverDriveTable.VoltageOffsetPerZoneBoundary[i];
> > > > > +               user_od_table->OverDriveTable.FanMode =3D
> > > > > +                       user_od_table_bak.OverDriveTable.FanMode;
> > > > >         }
> > > > >
> > > > > +       smu_v13_0_0_set_supported_od_feature_mask(smu);
> > > > > +
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > @@ -1850,9 +1878,10 @@ static int
> > > > smu_v13_0_0_restore_user_od_settings(struct smu_context *smu)
> > > > >         OverDriveTableExternal_t *user_od_table =3D table_context=
-
> > > > >user_overdrive_table;
> > > > >         int res;
> > > > >
> > > > > -       user_od_table->OverDriveTable.FeatureCtrlMask =3D 1U <<
> > > > PP_OD_FEATURE_GFXCLK_BIT |
> > > > > -                                                       1U << PP_=
OD_FEATURE_UCLK_BIT |
> > > > > -                                                       1U <<
> > PP_OD_FEATURE_GFX_VF_CURVE_BIT;
> > > > > +       user_od_table->OverDriveTable.FeatureCtrlMask =3D
> > > > BIT(PP_OD_FEATURE_GFXCLK_BIT) |
> > > > > +                                                       BIT(PP_OD=
_FEATURE_UCLK_BIT) |
> > > > > +
> > > > > + BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
> > > > > +
> > > > > + BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
> > > > >         res =3D smu_v13_0_0_upload_overdrive_table(smu, user_od_t=
able);
> > > > >         user_od_table->OverDriveTable.FeatureCtrlMask =3D 0;
> > > > >         if (res =3D=3D 0)
> > > > > diff --git
> > a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > > > > b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > > > > index 328765f89c94..28c2e4b0e55d 100644
> > > > > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > > > > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> > > > > @@ -77,6 +77,7 @@
> > > > >  #define PP_OD_FEATURE_UCLK_FMIN                                2
> > > > >  #define PP_OD_FEATURE_UCLK_FMAX                                3
> > > > >  #define PP_OD_FEATURE_GFX_VF_CURVE                     4
> > > > > +#define PP_OD_FEATURE_FAN_MODE                         5
> > > > >
> > > > >  #define LINK_SPEED_MAX                                 3
> > > > >
> > > > > @@ -1096,6 +1097,10 @@ static void
> > > > smu_v13_0_7_get_od_setting_limits(struct smu_context *smu,
> > > > >                 od_min_setting =3D overdrive_lowerlimits-
> > > > >VoltageOffsetPerZoneBoundary;
> > > > >                 od_max_setting =3D overdrive_upperlimits-
> > > > >VoltageOffsetPerZoneBoundary;
> > > > >                 break;
> > > > > +       case PP_OD_FEATURE_FAN_MODE:
> > > > > +               od_min_setting =3D overdrive_lowerlimits->FanMode=
;
> > > > > +               od_max_setting =3D overdrive_upperlimits->FanMode=
;
> > > > > +               break;
> > > > >         default:
> > > > >                 od_min_setting =3D od_max_setting =3D INT_MAX;
> > > > >                 break;
> > > > > @@ -1315,6 +1320,16 @@ static int
> > > > > smu_v13_0_7_print_clk_levels(struct
> > > > smu_context *smu,
> > > > >                                       od_table-
> > > > >OverDriveTable.VoltageOffsetPerZoneBoundary[0]);
> > > > >                 break;
> > > > >
> > > > > +       case SMU_OD_FAN_MODE:
> > > > > +               if (!smu_v13_0_7_is_od_feature_supported(smu,
> > > > > +                                                        PP_OD_FE=
ATURE_FAN_CURVE_BIT))
> > > > > +                       break;
> > > > > +
> > > > > +               size +=3D sysfs_emit_at(buf, size, "OD_FAN_MODE:\=
n");
> > > > > +               size +=3D sysfs_emit_at(buf, size, "%d\n",
> > > > > +                                       (int)od_table->OverDriveT=
able.FanMode);
> > > > > +               break;
> > > > > +
> > > > >         case SMU_OD_RANGE:
> > > > >                 if (!smu_v13_0_7_is_od_feature_supported(smu,
> > > > PP_OD_FEATURE_GFXCLK_BIT) &&
> > > > >                     !smu_v13_0_7_is_od_feature_supported(smu,
> > > > > PP_OD_FEATURE_UCLK_BIT) && @@ -1770,6 +1785,15 @@ static
> > ssize_t
> > > > smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
> > > > >         return sizeof(struct gpu_metrics_v1_3);  }
> > > > >
> > > > > +static void smu_v13_0_7_set_supported_od_feature_mask(struct
> > > > > +smu_context *smu) {
> > > > > +       struct amdgpu_device *adev =3D smu->adev;
> > > > > +
> > > > > +       if (smu_v13_0_7_is_od_feature_supported(smu,
> > > > > +                                               PP_OD_FEATURE_FAN=
_CURVE_BIT))
> > > > > +               adev->pm.od_feature_mask |=3D
> > > > > +OD_OPS_SUPPORT_FAN_MODE_RETRIEVE; }
> > > > > +
> > > > >  static int smu_v13_0_7_set_default_od_settings(struct smu_contex=
t
> > > > > *smu)  {
> > > > >         OverDriveTableExternal_t *od_table =3D @@ -1819,8 +1843,1=
2
> > > > >@@  static int smu_v13_0_7_set_default_od_settings(struct
> > smu_context *smu)
> > > > >                 for (i =3D 0; i < PP_NUM_OD_VF_CURVE_POINTS; i++)
> > > > >                         user_od_table-
> > > > >OverDriveTable.VoltageOffsetPerZoneBoundary[i] =3D
> > > > >
> > > > > user_od_table_bak.OverDriveTable.VoltageOffsetPerZoneBoundary[i];
> > > > > +               user_od_table->OverDriveTable.FanMode =3D
> > > > > +                       user_od_table_bak.OverDriveTable.FanMode;
> > > > >         }
> > > > >
> > > > > +       smu_v13_0_7_set_supported_od_feature_mask(smu);
> > > > > +
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > @@ -1831,9 +1859,10 @@ static int
> > > > smu_v13_0_7_restore_user_od_settings(struct smu_context *smu)
> > > > >         OverDriveTableExternal_t *user_od_table =3D table_context=
-
> > > > >user_overdrive_table;
> > > > >         int res;
> > > > >
> > > > > -       user_od_table->OverDriveTable.FeatureCtrlMask =3D 1U <<
> > > > PP_OD_FEATURE_GFXCLK_BIT |
> > > > > -                                                       1U << PP_=
OD_FEATURE_UCLK_BIT |
> > > > > -                                                       1U <<
> > PP_OD_FEATURE_GFX_VF_CURVE_BIT;
> > > > > +       user_od_table->OverDriveTable.FeatureCtrlMask =3D
> > > > BIT(PP_OD_FEATURE_GFXCLK_BIT) |
> > > > > +                                                       BIT(PP_OD=
_FEATURE_UCLK_BIT) |
> > > > > +
> > > > > + BIT(PP_OD_FEATURE_GFX_VF_CURVE_BIT) |
> > > > > +
> > > > > + BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
> > > > >         res =3D smu_v13_0_7_upload_overdrive_table(smu, user_od_t=
able);
> > > > >         user_od_table->OverDriveTable.FeatureCtrlMask =3D 0;
> > > > >         if (res =3D=3D 0)
> > > > > --
> > > > > 2.34.1
> > > > >
