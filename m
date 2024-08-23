Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D6DC52D7C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Aug 2024 14:31:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE0910E0D6;
	Fri, 23 Aug 2024 14:31:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TIYdN/4p";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BAE310E0D6
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 14:31:48 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-7cd90dbf42fso43639a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Aug 2024 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724423508; x=1725028308; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYj6IWAr6PU2M12c2n6qd3lRp6oUmDzzbseXM8SLfW0=;
 b=TIYdN/4prAtfQ507NE+09YmOFjn7/BZ66qLMqeoR3dB6PsE3jGexYSLoDTbGHaD42Y
 B+5m+tN2kfxRC25f5j9hJV69mC7Dxurho/KNS+hP3Xz/LCcKfQleyjR8IbgwTWe3axiw
 oL4wSWAVMaDRKZfizmmzJ3sjMgUguxrH+Kk/RJ4r+ur/slvWM22HKlwEG2UrxeCJsPPR
 6QoP4/+mf4Ngsh+tY+Tfde3LYtJIapZkcIRI/Rs+yYCj4XVXhZWiFmZIJZjvScHnQL9Z
 mVpaEJWDfPnMnLpzb1qDzjfXqinGh8o2gUb9Xfp9EiuI4HTYVSmfmGT7jVaL/hORcgyL
 LBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724423508; x=1725028308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYj6IWAr6PU2M12c2n6qd3lRp6oUmDzzbseXM8SLfW0=;
 b=COj9w6ayFL4FkDH2DNwYRMjs2WjpU16MLCAu6OE55C9y32HHk0psOUQuEYBrKzrvaK
 ibjNcq2ImGJLjYTM30fSxMEIX6DTpBC75fgoOsTFUv7RaVsSYX4YEof8WJJIoae8/1x5
 /vVSKvU+/OY2fCTrJNx3iuWfeFhQrA6/KjRWcnY4z6v1xr7QCImf1j3E0dbCBq/uTCTy
 GCGnTiNPlCdbc2ebHpSP1vpXmjmUOMbv+QxBh+NBxggZzN8bKo3SXlKtFMhwNp1qAToo
 rFfL/h4/UIZ21+VVmFILoR7L19U2fhcVKAHMueoBhNPUnCginZ2pvt8KB3uxc+ze1paE
 3BpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjoc6JlEPPd7sVHd/ME+FPuBR810/hMkuebhznEN0rDYR3OMFWDnya99s1X73Y8zmB/K9DDhdA@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yznz3xsDHeOT0rcjrqRQkR5J9JUymCloIhb6YzFmDTQpZvYVcDS
 DauxUeac01jQAE0alSVc57hj4NfDWCCe6GSvm6sdLX4Ls9r1Ji8dndeSdP+WKuSfrDSjtoBLhAh
 HLXe5iNKYceuYFOT5GjAUbgfBqqc=
X-Google-Smtp-Source: AGHT+IF71aY0k+Ctg/vvsRCXuzlSVd9sHniNLAiAKU4F1tbBfptN+DknjLopbFlDM4rW6ORiHgPzC13JHCh2uNsAkvk=
X-Received: by 2002:a05:6a21:9999:b0:1c2:88eb:1d33 with SMTP id
 adf61e73a8af0-1cc8a24d209mr1752708637.6.1724423507343; Fri, 23 Aug 2024
 07:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240820020435.472490-1-superm1@kernel.org>
 <CADnq5_O3uTj_Zu9+iY_k8i2MQhXH=Ac2+GhCe5DeW=CWY6jn4w@mail.gmail.com>
 <0e8d0a26-3dca-4669-96fc-d9f4bffbe5f6@amd.com>
In-Reply-To: <0e8d0a26-3dca-4669-96fc-d9f4bffbe5f6@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Aug 2024 10:31:35 -0400
Message-ID: <CADnq5_OL=W_Uz9LCeoYAEZ=XX=1tu0=Hky=pjLmfz0x8vWUT-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Don't wake dGPUs while reading sensors
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
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

On Fri, Aug 23, 2024 at 10:13=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 8/23/2024 09:09, Alex Deucher wrote:
> > On Mon, Aug 19, 2024 at 10:30=E2=80=AFPM Mario Limonciello <superm1@ker=
nel.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> If the dGPU is off, then reading the sysfs files with a sensor monitor=
ing
> >> application will wake it. Change the behavior to return an error when =
the
> >> dGPU is in D3cold.
> >
> > I'm a little concerned that this will generate a flurry of bug reports
> > if this now reports an error.  One more comment below.
> >
>
> Do you have a particular app you're worried about, or just a general
> worry?  I've had a lot of people reach out to me complaining about
> battery life on A+A systems, and it comes down to the use of sensor
> monitoring software waking the dGPU which people don't seem to expect.

Nothing in particular.  Just expecting reports of "I checked my GPU
temperature and it returned an error.  It was working with the last
kernel."

>
> I did double check that software like 'sensors', 'mission center' and
> 'nvtop' don't freak out from this change.

Do we know what other devices do?  I wonder if it would make more
sense to have the userspace tools check the runpm state before trying
to access the device.  Of course there are a lot of them and fixing
them all is non-trivial...

Alex

>
> Here is what 'sensors' shows on my local workstation with this change.
>
> amdgpu-pci-6100
> Adapter: PCI adapter
> vddgfx:           N/A
> ERROR: Can't get value of subfeature fan1_min: Can't read
> ERROR: Can't get value of subfeature fan1_max: Can't read
> fan1:             N/A  (min =3D    0 RPM, max =3D    0 RPM)
> edge:             N/A  (crit =3D +97.0=C2=B0C, hyst =3D -273.1=C2=B0C)
> ERROR: Can't get value of subfeature power1_cap: Can't read
> PPT:              N/A  (cap =3D   0.00 W)
>
> >>
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 90 +++++++++++++++-------------=
--
> >>   1 file changed, 45 insertions(+), 45 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/=
pm/amdgpu_pm.c
> >> index c11952a4389bc..d6e38466fbb82 100644
> >> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> >> @@ -142,7 +142,7 @@ static ssize_t amdgpu_get_power_dpm_state(struct d=
evice *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -173,7 +173,7 @@ static ssize_t amdgpu_set_power_dpm_state(struct d=
evice *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          if (strncmp("battery", buf, strlen("battery")) =3D=3D 0)
> >> @@ -270,7 +270,7 @@ static ssize_t amdgpu_get_power_dpm_force_performa=
nce_level(struct device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -309,7 +309,7 @@ static ssize_t amdgpu_set_power_dpm_force_performa=
nce_level(struct device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          if (strncmp("low", buf, strlen("low")) =3D=3D 0) {
> >> @@ -371,7 +371,7 @@ static ssize_t amdgpu_get_pp_num_states(struct dev=
ice *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -409,7 +409,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct devi=
ce *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -448,7 +448,7 @@ static ssize_t amdgpu_get_pp_force_state(struct de=
vice *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          if (adev->pm.pp_force_state_enabled)
> >> @@ -471,7 +471,7 @@ static ssize_t amdgpu_set_pp_force_state(struct de=
vice *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          adev->pm.pp_force_state_enabled =3D false;
> >> @@ -541,7 +541,7 @@ static ssize_t amdgpu_get_pp_table(struct device *=
dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -577,7 +577,7 @@ static ssize_t amdgpu_set_pp_table(struct device *=
dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -760,7 +760,7 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct=
 device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          if (count > 127 || count =3D=3D 0)
> >> @@ -862,7 +862,7 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct=
 device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -922,7 +922,7 @@ static ssize_t amdgpu_set_pp_features(struct devic=
e *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D kstrtou64(buf, 0, &featuremask);
> >> @@ -957,7 +957,7 @@ static ssize_t amdgpu_get_pp_features(struct devic=
e *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -1026,7 +1026,7 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct de=
vice *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -1095,7 +1095,7 @@ static ssize_t amdgpu_set_pp_dpm_clock(struct de=
vice *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D amdgpu_read_mask(buf, count, &mask);
> >> @@ -1280,7 +1280,7 @@ static ssize_t amdgpu_get_pp_sclk_od(struct devi=
ce *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -1309,7 +1309,7 @@ static ssize_t amdgpu_set_pp_sclk_od(struct devi=
ce *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D kstrtol(buf, 0, &value);
> >> @@ -1342,7 +1342,7 @@ static ssize_t amdgpu_get_pp_mclk_od(struct devi=
ce *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -1371,7 +1371,7 @@ static ssize_t amdgpu_set_pp_mclk_od(struct devi=
ce *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D kstrtol(buf, 0, &value);
> >> @@ -1424,7 +1424,7 @@ static ssize_t amdgpu_get_pp_power_profile_mode(=
struct device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -1463,7 +1463,7 @@ static ssize_t amdgpu_set_pp_power_profile_mode(=
struct device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          tmp[0] =3D *(buf);
> >> @@ -1517,7 +1517,7 @@ static int amdgpu_hwmon_get_sensor_generic(struc=
t amdgpu_device *adev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >> @@ -1630,7 +1630,7 @@ static ssize_t amdgpu_get_pcie_bw(struct device =
*dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          if (adev->flags & AMD_IS_APU)
> >> @@ -1673,7 +1673,7 @@ static ssize_t amdgpu_get_unique_id(struct devic=
e *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          if (adev->unique_id)
> >> @@ -1846,7 +1846,7 @@ static ssize_t amdgpu_get_pm_metrics(struct devi=
ce *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -1887,7 +1887,7 @@ static ssize_t amdgpu_get_gpu_metrics(struct dev=
ice *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -2005,7 +2005,7 @@ static ssize_t amdgpu_set_smartshift_bias(struct=
 device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          r =3D pm_runtime_get_sync(ddev->dev);
> >> @@ -2227,7 +2227,7 @@ static ssize_t amdgpu_get_xgmi_plpd_policy(struc=
t device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          mode =3D amdgpu_dpm_get_xgmi_plpd_mode(adev, &mode_desc);
> >> @@ -2250,7 +2250,7 @@ static ssize_t amdgpu_set_xgmi_plpd_policy(struc=
t device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D kstrtos32(buf, 0, &mode);
> >> @@ -2652,7 +2652,7 @@ static ssize_t amdgpu_hwmon_get_pwm1_enable(stru=
ct device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >> @@ -2684,7 +2684,7 @@ static ssize_t amdgpu_hwmon_set_pwm1_enable(stru=
ct device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          err =3D kstrtoint(buf, 10, &value);
> >> @@ -2742,7 +2742,7 @@ static ssize_t amdgpu_hwmon_set_pwm1(struct devi=
ce *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          err =3D kstrtou32(buf, 10, &value);
> >> @@ -2787,7 +2787,7 @@ static ssize_t amdgpu_hwmon_get_pwm1(struct devi=
ce *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          err =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >> @@ -2817,7 +2817,7 @@ static ssize_t amdgpu_hwmon_get_fan1_input(struc=
t device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          err =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >> @@ -2881,7 +2881,7 @@ static ssize_t amdgpu_hwmon_get_fan1_target(stru=
ct device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          err =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >> @@ -2912,7 +2912,7 @@ static ssize_t amdgpu_hwmon_set_fan1_target(stru=
ct device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          err =3D kstrtou32(buf, 10, &value);
> >> @@ -2956,7 +2956,7 @@ static ssize_t amdgpu_hwmon_get_fan1_enable(stru=
ct device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >> @@ -2988,7 +2988,7 @@ static ssize_t amdgpu_hwmon_set_fan1_enable(stru=
ct device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          err =3D kstrtoint(buf, 10, &value);
> >> @@ -3128,7 +3128,7 @@ static ssize_t amdgpu_hwmon_show_power_cap_gener=
ic(struct device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
> >> @@ -3209,7 +3209,7 @@ static ssize_t amdgpu_hwmon_set_power_cap(struct=
 device *dev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          if (amdgpu_sriov_vf(adev))
> >> @@ -3663,7 +3663,7 @@ static int amdgpu_retrieve_od_settings(struct am=
dgpu_device *adev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D pm_runtime_get_sync(adev->dev);
> >> @@ -3747,7 +3747,7 @@ amdgpu_distribute_custom_od_settings(struct amdg=
pu_device *adev,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D parse_input_od_command_lines(in_buf,
> >> @@ -4626,7 +4626,7 @@ static int amdgpu_debugfs_pm_info_show(struct se=
q_file *m, void *unused)
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >
> > I'd prefer to keep the current behavior for debugfs.
>
> OK.  I'll exclude it for debugfs in the next spin.
>
> >
> > Alex
> >
> >>
> >>          r =3D pm_runtime_get_sync(dev->dev);
> >> @@ -4671,7 +4671,7 @@ static ssize_t amdgpu_pm_prv_buffer_read(struct =
file *f, char __user *buf,
> >>
> >>          if (amdgpu_in_reset(adev))
> >>                  return -EPERM;
> >> -       if (adev->in_suspend && !adev->in_runpm)
> >> +       if (adev->in_suspend || adev->in_runpm)
> >>                  return -EPERM;
> >>
> >>          ret =3D amdgpu_dpm_get_smu_prv_buf_details(adev, &smu_prv_buf=
, &smu_prv_buf_size);
> >> --
> >> 2.43.0
> >>
>
