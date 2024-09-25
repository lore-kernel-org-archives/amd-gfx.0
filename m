Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 774DDCCF9E6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 15:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A1BE10EA56;
	Wed, 25 Sep 2024 15:48:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZVIzxd5L";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C03410EA3F
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 15:48:09 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2058ba82fbfso3600885ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 08:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727279288; x=1727884088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWJCgoGdwCbFoVo4I9Y2ei2WhLDre2CJdrUa0/9N/0k=;
 b=ZVIzxd5L+wIdvU9NgEZ+EtCnXV9Vzcyy13gJry/rm4bBr3gziklF1G9RTc3mbwqkiA
 6K2BNDr7U71Z7jMNYNMy61N3ZH/IPdr7wA9TzXhGJ8X4Kz5L8F3OxKGkhV1klziSfcN+
 o20TwUKThE1bkiZfGLsl6dJJjSDtUteK2Et8NH2NCJwYIbARJkEfxqnaROmMQG9p/UVd
 hR04UIl6lSUEwmoV9rHgpZh3xmSQHH19Wo4+FrGfsvxeuJOKC4Zwp52k3p11/SZ1h+L/
 vQGLIUShBgNJAp0cjSHwcBSrvlb9cz/zAbuLmS6Au35zJOmCLBec+xUO7A8jM51gySgn
 20Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727279288; x=1727884088;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWJCgoGdwCbFoVo4I9Y2ei2WhLDre2CJdrUa0/9N/0k=;
 b=TnjXzJTsS2wBe6F7dNtsVO8L1YOnJWjK5WSpHJEynz2AJHYJkknDn/aB2gcgBUagzy
 CwI5qc6acJ6Q0pSEw7EwFlteGq4KaMWKPSM1098e+NMYeyGOKgNvQ1+GvjvM0sIla+xW
 r/B+syqe/C4EFLk21r0k/yK6MJ4Q2cxsQV7Bp607trc+qPGf4xF5q2zdNjdv2u246xIG
 4CU9gZ47VdTJ8ctKaXlJ8xVqK7+T34ERDcqvC+QtcrE3SEu/f6v/YEVWhBoQbjKBrHsH
 dYlMV06eoeCXIXe6j2DcnGJUyZypk5GNgKDD9tTYbz3f1+97ugnC2TIkzgn8ABpU0tut
 kj9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOCeNux7kONWPDgnBnbIAoxksjzaK6eZ7rXyw/L51yEzDlHLGA92OPOuxA1Gkctmf0Vd1889oG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMPD6cO0YR0aoWyNl2DyyA2VtCXu6Yb1Kakmdtv9w1YhiZATVD
 1HexZZvPvJ2jNZ0reMgJ4U6KnyIRuWYaVEmnBWoazD5B+8Y18XJmOSibyPNHjw7rbDeQqG5TCCf
 HTuHP1j4pVU+qqnh4Z9nZMuCNO1QkvA==
X-Google-Smtp-Source: AGHT+IFYrK02/Jz25omQM6aP5eGfXi6STLELdKK/jzknwoL2dS1u4qqHMm+B8P6EG0tfDQ3x5yIXprkeZsNlPeUGTBg=
X-Received: by 2002:a17:902:e811:b0:205:76c9:795d with SMTP id
 d9443c01a7336-20afc4ab948mr19893915ad.6.1727279288445; Wed, 25 Sep 2024
 08:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240925075607.23929-1-pierre-eric.pelloux-prayer@amd.com>
 <20240925075607.23929-7-pierre-eric.pelloux-prayer@amd.com>
 <30fb4696-0ac6-40cf-a493-7849e34cf0db@amd.com>
In-Reply-To: <30fb4696-0ac6-40cf-a493-7849e34cf0db@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Sep 2024 11:47:54 -0400
Message-ID: <CADnq5_OMVtreagUPQ20Hv29619M8UWaFwmm=q_WJFjWot6EXeg@mail.gmail.com>
Subject: Re: [PATCH v1 6/9] drm/amd/pm: stop extra checks for runtime pm state
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, kenneth.feng@amd.com, mario.limonciello@amd.com
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

On Wed, Sep 25, 2024 at 9:38=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 9/25/2024 1:24 PM, Pierre-Eric Pelloux-Prayer wrote:
> > pm_runtime_get_if_in_use already checks if the GPU is active,
> > so there's no need for manually checking runtimepm status:
> >
> >    if (adev->in_suspend && !adev->in_runpm)
> >       return -EPERM;
> >
> > Tested-by: Mario Limonciello <mario.limonciello@amd.com>
> > Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@a=
md.com>
> > ---
> >  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 46 ------------------------------
> >  1 file changed, 46 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/p=
m/amdgpu_pm.c
> > index f1f339b75380..13be5e017a01 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -142,8 +142,6 @@ static ssize_t amdgpu_get_power_dpm_state(struct de=
vice *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
>
> I believe this check is for accesses before the device is fully resumed
> from a suspend sequence. That is not tied to runtime PM.

In theory, user processes should not be resumed until the kernel
drivers have resumed so I think the check was probably not needed in
the first place.

Alex

>
> Thanks,
> Lijo
>
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -265,8 +263,6 @@ static ssize_t amdgpu_get_power_dpm_force_performan=
ce_level(struct device *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -361,8 +357,6 @@ static ssize_t amdgpu_get_pp_num_states(struct devi=
ce *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -396,8 +390,6 @@ static ssize_t amdgpu_get_pp_cur_state(struct devic=
e *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -523,8 +515,6 @@ static ssize_t amdgpu_get_pp_table(struct device *d=
ev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -837,8 +827,6 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct =
device *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -927,8 +915,6 @@ static ssize_t amdgpu_get_pp_features(struct device=
 *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -993,8 +979,6 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct devic=
e *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -1242,8 +1226,6 @@ static ssize_t amdgpu_get_pp_sclk_od(struct devic=
e *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -1299,8 +1281,6 @@ static ssize_t amdgpu_get_pp_mclk_od(struct devic=
e *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -1376,8 +1356,6 @@ static ssize_t amdgpu_get_pp_power_profile_mode(s=
truct device *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -1464,8 +1442,6 @@ static int amdgpu_hwmon_get_sensor_generic(struct=
 amdgpu_device *adev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       r =3D pm_runtime_get_if_active(adev->dev, true);
> >       if (r <=3D 0)
> > @@ -1574,8 +1550,6 @@ static ssize_t amdgpu_get_pcie_bw(struct device *=
dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       if (adev->flags & AMD_IS_APU)
> >               return -ENODATA;
> > @@ -1784,8 +1758,6 @@ static ssize_t amdgpu_get_pm_metrics(struct devic=
e *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -1822,8 +1794,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct devi=
ce *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(ddev->dev, true);
> >       if (ret <=3D 0)
> > @@ -2697,8 +2667,6 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(struc=
t device *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(adev->dev, true);
> >       if (ret <=3D 0)
> > @@ -2825,8 +2793,6 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct devic=
e *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       err =3D pm_runtime_get_if_active(adev->dev, true);
> >       if (err <=3D 0)
> > @@ -2852,8 +2818,6 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struct=
 device *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       err =3D pm_runtime_get_if_active(adev->dev, true);
> >       if (err <=3D 0)
> > @@ -2913,8 +2877,6 @@ static ssize_t amdgpu_hwmon_get_fan1_target(struc=
t device *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       err =3D pm_runtime_get_if_active(adev->dev, true);
> >       if (err <=3D 0)
> > @@ -2983,8 +2945,6 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(struc=
t device *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(adev->dev, true);
> >       if (ret <=3D 0)
> > @@ -3149,8 +3109,6 @@ static ssize_t amdgpu_hwmon_show_power_cap_generi=
c(struct device *dev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       r =3D pm_runtime_get_if_active(adev->dev, true);
> >       if (r <=3D 0)
> > @@ -3682,8 +3640,6 @@ static int amdgpu_retrieve_od_settings(struct amd=
gpu_device *adev,
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       ret =3D pm_runtime_get_if_active(adev->dev, true);
> >       if (ret <=3D 0)
> > @@ -4649,8 +4605,6 @@ static int amdgpu_debugfs_pm_info_show(struct seq=
_file *m, void *unused)
> >
> >       if (amdgpu_in_reset(adev))
> >               return -EPERM;
> > -     if (adev->in_suspend && !adev->in_runpm)
> > -             return -EPERM;
> >
> >       r =3D pm_runtime_resume_and_get(dev->dev);
> >       if (r < 0)
