Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DCCCCF9EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 09:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCB410E420;
	Mon, 27 Oct 2025 09:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="oLvghQto";
	dkim-atps=neutral
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C13F210EB33
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 17:03:16 +0000 (UTC)
Received: from relay10 (localhost.localdomain [127.0.0.1])
 by relay10.grserver.gr (Proxmox) with ESMTP id 4EE2F463AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 20:03:15 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay10.grserver.gr (Proxmox) with ESMTPS id 07914463B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 20:03:14 +0300 (EEST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id 553661FED90
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 20:03:13 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1761325393;
 bh=2uh4Hu5oF778q2RG3BU/i8gp4RJVifOIvQ7MfNW8lMg=;
 h=Received:From:Subject:To;
 b=oLvghQtojnZX1FGGV6lxHAyIJf/fVm9DZ/Qhc8hcGwbO2Xx1wTfHD2cRLZ3pbyw+Q
 SlGwxqOQcZHfNBiL72Fnkpu7yUqRlFNMipsRLV1JdR/LOwf+N8A1rrP1ri0q/e411x
 p/6q7amzw/hqY3W4VOos+CrfcjGP8FR/DUT0pRpJg+oAQQwlRE3zBV31ZL5kFrV0q8
 /wOiwO7zGLPqFA5vIOSm0GeLBrvRffyyXI79eksoK1mQSLDIJ2nRPDS5oDHTGs7oP9
 gAlYeBtAPDEWK4MdZ6VexhcK3tQ8qDPWACZczQRxUqc81fUj7AekVP7y3x2SLQXzFj
 TY3G9mL58nNYw==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.208.169) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f169.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-378d65d8184so30468821fa.0
 for <amd-gfx@lists.freedesktop.org>;
 Fri, 24 Oct 2025 10:03:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUUDbYqtOxP0EyXDIijYaBP6LzOGCKTrsyO0rukSY0Rzv2uL/w5YwIBPi1hKGX0Z/VBhnjuofsu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaNAmUP8lP7Gv6l3B5gnFBST6H0PW7I/x83uzt0k2fyPF8yyQ4
 J2UHK8/CghuPbk8OR05BeicZrSggYFWIf8I2UdgFkT7l7ejN+9PzkpqLXmVOyeVuhKkcVRExu9I
 O0g4kCIY9yHmLIiXfPzJpWVe2igQbkdU=
X-Google-Smtp-Source: AGHT+IHSVOpvuxZQwkAvU2HVI755kiLErr9dfGJ/DcnbSxRqSriCA+0cyKGJ1N3vQwDRxKCB85Byec6b91RJ2bTLdtc=
X-Received: by 2002:a05:651c:3608:b0:360:c716:2666 with SMTP id
 38308e7fff4ca-37797a39591mr102797741fa.30.1761325392822; Fri, 24 Oct 2025
 10:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20251024161216.345691-1-mario.limonciello@amd.com>
 <20251024161216.345691-2-mario.limonciello@amd.com>
 <CADnq5_PCK1ttQki=9aGCpYSKinfy36C_s1f10p7wT-9rwc63ug@mail.gmail.com>
In-Reply-To: <CADnq5_PCK1ttQki=9aGCpYSKinfy36C_s1f10p7wT-9rwc63ug@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 24 Oct 2025 19:03:01 +0200
X-Gmail-Original-Message-ID: <CAGwozwECr9n_SBU_Gt6+zASGZN8jD68dH3cLitz05nJug56O1w@mail.gmail.com>
X-Gm-Features: AWmQ_bkWPWqcTa7p_GLHIPvOJx2eKDD9DdSlde5bvNqg6Dk6GL8-eMq6c7lOywc
Message-ID: <CAGwozwECr9n_SBU_Gt6+zASGZN8jD68dH3cLitz05nJug56O1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd: Move Van Gogh specific suspend code into
 common `set_mp1_state`
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Robert Beckett <bob.beckett@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: <176132539355.2712913.5944874093096472760@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 27 Oct 2025 09:35:56 +0000
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

On Fri, 24 Oct 2025 at 18:59, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Oct 24, 2025 at 12:21=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > [Why]
> > An `.notify_rlc_state` callback and wrappers for it were introduced
> > to support notifying the PMFW that the system is about to suspend.
> >
> > There are already callbacks for `set_mp1_state` which get called at
> > suspend though from `amdgpu_device_ip_suspend_phase2`.
>
> This won't work.  PMFW needs to be notified that RLC is being turned
> off before the driver turns it off.  I think the call in
> amdgpu_device_suspend() is superfluous (but someone should check S3),
> but the important one is in smu_disable_dpms() since that is called
> right before we stop rlc.  I think something like the attached patches
> should do the trick.
>
> Alex

S3 on the OLED works with the three lines in amdgpu_device_suspend removed.

> >
> > [How]
> > Tear out all the notify_rlc_state callbacks and instead move the
> > Van Gogh specific code to a `set_mp1_state` callback.
> >
> > Cc: Robert Beckett <bob.beckett@collabora.com>
> > Cc: Antheas Kapenekakis <lkml@antheas.dev>
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  4 ----
> >  .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 -
> >  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 18 ------------------
> >  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 --
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 10 ----------
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  5 -----
> >  .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 19 ++++++++++++++++++-
> >  drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 -
> >  8 files changed, 18 insertions(+), 42 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 3ffb9bb1ec0b..4dbdcb7b11e9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -5281,10 +5281,6 @@ int amdgpu_device_suspend(struct drm_device *dev=
, bool notify_clients)
> >         if (amdgpu_sriov_vf(adev))
> >                 amdgpu_virt_release_full_gpu(adev, false);
> >
> > -       r =3D amdgpu_dpm_notify_rlc_state(adev, false);
> > -       if (r)
> > -               return r;
> > -
> >         return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/g=
pu/drm/amd/include/kgd_pp_interface.h
> > index 87814c2b526e..48846a3e4b7b 100644
> > --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> > @@ -523,7 +523,6 @@ struct amd_pm_funcs {
> >                                    struct dpm_clocks *clock_table);
> >         int (*get_smu_prv_buf_details)(void *handle, void **addr, size_=
t *size);
> >         void (*pm_compute_clocks)(void *handle);
> > -       int (*notify_rlc_state)(void *handle, bool en);
> >  };
> >
> >  struct metrics_table_header {
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/=
pm/amdgpu_dpm.c
> > index 5d08dc3b7110..5c4d0eb198c4 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> > @@ -195,24 +195,6 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device =
*adev,
> >         return ret;
> >  }
> >
> > -int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en)
> > -{
> > -       int ret =3D 0;
> > -       const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_func=
s;
> > -
> > -       if (pp_funcs && pp_funcs->notify_rlc_state) {
> > -               mutex_lock(&adev->pm.mutex);
> > -
> > -               ret =3D pp_funcs->notify_rlc_state(
> > -                               adev->powerplay.pp_handle,
> > -                               en);
> > -
> > -               mutex_unlock(&adev->pm.mutex);
> > -       }
> > -
> > -       return ret;
> > -}
> > -
> >  int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
> >  {
> >         const struct amd_pm_funcs *pp_funcs =3D adev->powerplay.pp_func=
s;
> > diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/=
amd/pm/inc/amdgpu_dpm.h
> > index 3bce74f8bb0a..c7ea29385682 100644
> > --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> > @@ -424,8 +424,6 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *ad=
ev);
> >  int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
> >                              enum pp_mp1_state mp1_state);
> >
> > -int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en);
> > -
> >  int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev);
> >
> >  int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/dr=
m/amd/pm/swsmu/amdgpu_smu.c
> > index 4317da6f7c38..10d42267085b 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -2072,16 +2072,6 @@ static int smu_disable_dpms(struct smu_context *=
smu)
> >                 }
> >         }
> >
> > -       /* Notify SMU RLC is going to be off, stop RLC and SMU interact=
ion.
> > -        * otherwise SMU will hang while interacting with RLC if RLC is=
 halted
> > -        * this is a WA for Vangogh asic which fix the SMU hang issue.
> > -        */
> > -       ret =3D smu_notify_rlc_state(smu, false);
> > -       if (ret) {
> > -               dev_err(adev->dev, "Fail to notify rlc status!\n");
> > -               return ret;
> > -       }
> > -
> >         if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(9, 4, 2=
) &&
> >             !((adev->flags & AMD_IS_APU) && adev->gfx.imu.funcs) &&
> >             !amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs->stop)
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gp=
u/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > index c48028abc8c4..361e09f20ead 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> > @@ -1496,11 +1496,6 @@ struct pptable_funcs {
> >          */
> >         int (*set_mall_enable)(struct smu_context *smu);
> >
> > -       /**
> > -        * @notify_rlc_state: Notify RLC power state to SMU.
> > -        */
> > -       int (*notify_rlc_state)(struct smu_context *smu, bool en);
> > -
> >         /**
> >          * @is_asic_wbrf_supported: check whether PMFW supports the wbr=
f feature
> >          */
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > index 53579208cffb..3dc1919b8c64 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> > @@ -2208,6 +2208,23 @@ static int vangogh_notify_rlc_state(struct smu_c=
ontext *smu, bool en)
> >         return ret;
> >  }
> >
> > +static int vangogh_set_mp1_state(struct smu_context *smu,
> > +                                enum pp_mp1_state mp1_state)
> > +{
> > +       int ret;
> > +
> > +       switch (mp1_state) {
> > +       case PP_MP1_STATE_UNLOAD:
> > +               ret =3D vangogh_notify_rlc_state(smu, false);
> > +               break;
> > +       default:
> > +               /* Ignore others */
> > +               ret =3D 0;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  static int vangogh_post_smu_init(struct smu_context *smu)
> >  {
> >         struct amdgpu_device *adev =3D smu->adev;
> > @@ -2524,7 +2541,7 @@ static const struct pptable_funcs vangogh_ppt_fun=
cs =3D {
> >         .print_clk_levels =3D vangogh_common_print_clk_levels,
> >         .set_default_dpm_table =3D vangogh_set_default_dpm_tables,
> >         .set_fine_grain_gfx_freq_parameters =3D vangogh_set_fine_grain_=
gfx_freq_parameters,
> > -       .notify_rlc_state =3D vangogh_notify_rlc_state,
> > +       .set_mp1_state =3D vangogh_set_mp1_state,
> >         .feature_is_enabled =3D smu_cmn_feature_is_enabled,
> >         .set_power_profile_mode =3D vangogh_set_power_profile_mode,
> >         .get_power_profile_mode =3D vangogh_get_power_profile_mode,
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/=
drm/amd/pm/swsmu/smu_internal.h
> > index c09ecf1a68a0..b9976313e741 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
> > @@ -96,7 +96,6 @@
> >  #define smu_get_default_config_table_settings(smu, config_table)      =
 smu_ppt_funcs(get_default_config_table_settings, -EOPNOTSUPP, smu, config_=
table)
> >  #define smu_set_config_table(smu, config_table)                       =
         smu_ppt_funcs(set_config_table, -EOPNOTSUPP, smu, config_table)
> >  #define smu_init_pptable_microcode(smu)                               =
         smu_ppt_funcs(init_pptable_microcode, 0, smu)
> > -#define smu_notify_rlc_state(smu, en)                                 =
 smu_ppt_funcs(notify_rlc_state, 0, smu, en)
> >  #define smu_is_asic_wbrf_supported(smu)                        smu_ppt=
_funcs(is_asic_wbrf_supported, false, smu)
> >  #define smu_enable_uclk_shadow(smu, enable)            smu_ppt_funcs(e=
nable_uclk_shadow, 0, smu, enable)
> >  #define smu_set_wbrf_exclusion_ranges(smu, freq_band_range)           =
 smu_ppt_funcs(set_wbrf_exclusion_ranges, -EOPNOTSUPP, smu, freq_band_range=
)
> > --
> > 2.49.0
> >

