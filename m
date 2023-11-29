Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7685EC4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 14:34:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCADF10E56F;
	Wed, 29 Nov 2023 14:34:46 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0604810E56F
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 14:34:44 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1f9e0e44fecso3383862fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 06:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701268484; x=1701873284; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPy0455NjTWsvZrcSKCPIxgYJTw+AvybZxKrpGgwzxU=;
 b=BXxmGo8vrdcN3f4ZQ50vtvYp559eJ1eqbMsx6CMlKrbM4RpyMLpfn1niUc8aJKI/we
 I+Mw1LsAy/+bSXZl6wXwHihKPRcN0wObzKSFBoctMFidQhpH16QDDNAPFUAyw/tF9bQA
 32UPcXxm+dPJ7qGPX7lAgbkzgU+ZQnsEUNoC88qbEWeDOP9iV2gOj3csrDTa8SQYHjRC
 2p2MnbjjZ6pQKl2kXGpDBwDQHJ0AqlRYhDlCM3s9Ojvzd2Z7uPUrZnYVL0Qadi2EuuOW
 lSueUAmFi1OCj0LdmMjvvPg75XXNiPpEc4vZPhkk04di2LOpl9/5Ik6py9g5lwS3xwV+
 ZvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701268484; x=1701873284;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cPy0455NjTWsvZrcSKCPIxgYJTw+AvybZxKrpGgwzxU=;
 b=q4UpuDCpQafvWzVs/AHOYAmJhKhAFyKAUrv/xN737srr+7shFLtS70xy8qAzdQB6BM
 Cy76wns3BgGemy6vquToCmoSfwyQbbh9NfRoJnylSwSm96/4VhJBhWiNotsGXw1tjxW1
 bZ4gyCcRzd+LLXjZvand7zgcDKf5mPx4jerbHJ0UWE2m+kmEUwvzWHlNMZiljOOnvvfb
 8RQ/OuGS0w0GjM234XDjnd2mT1CO/pU2Y7g63wugEd/BVpAtOKisv9F23nLEFARW+m8C
 Hl2MMmydNqOMEm00bOU9XUVKuEu5ZLXCWzEZj0eYWh8Fgw/SAYjHeoLPDQCxrSMd3sif
 4h0A==
X-Gm-Message-State: AOJu0YzAyI7NtsVALF694n2oL8ZGIQ9ExHivv+921ujA7uUx3DiUUdcN
 ys4k3/cytgA3Wzmelp8bGbHNrr9ICeHIinOTAfKpKjh9
X-Google-Smtp-Source: AGHT+IHMkIrhj+CkmH88ajwxGw2WwsG87vGEEkNTEXvmMA49UJTPtkmovbjyT1jVsy5ELwWiwRxvtgElbdQHp+TmWZI=
X-Received: by 2002:a05:6871:e488:b0:1fa:a7d2:2985 with SMTP id
 pz8-20020a056871e48800b001faa7d22985mr1788313oac.56.1701268484137; Wed, 29
 Nov 2023 06:34:44 -0800 (PST)
MIME-Version: 1.0
References: <20231128185238.187381-1-mario.limonciello@amd.com>
 <20231128185238.187381-4-mario.limonciello@amd.com>
 <eedd6f6b-5d22-4e2b-afe8-81879f3b54da@amd.com>
In-Reply-To: <eedd6f6b-5d22-4e2b-afe8-81879f3b54da@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Nov 2023 09:34:33 -0500
Message-ID: <CADnq5_NJ8+J0Y5r+H7uogFdb5f35Vx5_p2rFki_eNyOAqi4Zhg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd: Drop calls for checking "support" for
 BACO/BOCO/PX
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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
Cc: Jun.Ma2@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 29, 2023 at 6:17=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 11/29/2023 12:22 AM, Mario Limonciello wrote:
> > As the module parameter can be used to control behavior, all parts
> > of the driver should obey what has been programmed by user or
> > detected by auto mode rather than what "can" be supported.
> >
>
> This is also not correct. You can very well disable runpm mode and the
> rest of the logic will still apply. A substitution like this doesn't
> work when runpm mode is disabled. Only in cases where the support check
> is used for runpm related logic, this replacement can be applied.

Right.  There are cases where we use BACO for things besides runtime
pm.  E.g., GPU reset.

Alex

>
> Thanks,
> Lijo
>
> > Drop calls to all functions that check for BACO/BOCO/PX runpm modes
> > and instead use the variable that is programmed when device is probed.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  7 +++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 34 ++++++++++++---------=
-
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  |  3 +-
> >   3 files changed, 24 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 1181fe4baf0f..8f7377b37f2f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1822,9 +1822,10 @@ static void amdgpu_switcheroo_set_state(struct p=
ci_dev *pdev,
> >                                       enum vga_switcheroo_state state)
> >   {
> >       struct drm_device *dev =3D pci_get_drvdata(pdev);
> > +     struct amdgpu_device *adev =3D drm_to_adev(dev);
> >       int r;
> >
> > -     if (amdgpu_device_supports_px(dev) && state =3D=3D VGA_SWITCHEROO=
_OFF)
> > +     if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX && state =3D=3D VGA_=
SWITCHEROO_OFF)
> >               return;
> >
> >       if (state =3D=3D VGA_SWITCHEROO_ON) {
> > @@ -4244,7 +4245,7 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
> >       if ((adev->pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA)
> >               vga_client_register(adev->pdev, amdgpu_device_vga_set_dec=
ode);
> >
> > -     px =3D amdgpu_device_supports_px(ddev);
> > +     px =3D (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX);
> >
> >       if (px || (!dev_is_removable(&adev->pdev->dev) &&
> >                               apple_gmux_detect(NULL, NULL)))
> > @@ -4392,7 +4393,7 @@ void amdgpu_device_fini_sw(struct amdgpu_device *=
adev)
> >       kfree(adev->fru_info);
> >       adev->fru_info =3D NULL;
> >
> > -     px =3D amdgpu_device_supports_px(adev_to_drm(adev));
> > +     px =3D (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX);
> >
> >       if (px || (!dev_is_removable(&adev->pdev->dev) &&
> >                               apple_gmux_detect(NULL, NULL)))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index e39f3a334c9d..12fb8398fb45 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -2248,10 +2248,10 @@ static int amdgpu_pci_probe(struct pci_dev *pde=
v,
> >
> >       if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
> >               /* only need to skip on ATPX */
> > -             if (amdgpu_device_supports_px(ddev))
> > +             if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
> >                       dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DI=
RECT_COMPLETE);
> >               /* we want direct complete for BOCO */
> > -             if (amdgpu_device_supports_boco(ddev))
> > +             if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
> >                       dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_SMART=
_PREPARE |
> >                                               DPM_FLAG_SMART_SUSPEND |
> >                                               DPM_FLAG_MAY_SKIP_RESUME)=
;
> > @@ -2284,7 +2284,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
> >                * into D0 state. Then there will be a PMFW-aware D-state
> >                * transition(D0->D3) on runpm suspend.
> >                */
> > -             if (amdgpu_device_supports_baco(ddev) &&
> > +             if ((adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO ||
> > +                  adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BAMACO) &&
> >                   !(adev->flags & AMD_IS_APU) &&
> >                   (adev->asic_type >=3D CHIP_NAVI10))
> >                       amdgpu_get_secondary_funcs(adev);
> > @@ -2466,7 +2467,7 @@ static int amdgpu_pmops_prepare(struct device *de=
v)
> >       /* Return a positive number here so
> >        * DPM_FLAG_SMART_SUSPEND works properly
> >        */
> > -     if (amdgpu_device_supports_boco(drm_dev) &&
> > +     if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO &&
> >           pm_runtime_suspended(dev))
> >               return 1;
> >
> > @@ -2664,7 +2665,7 @@ static int amdgpu_pmops_runtime_suspend(struct de=
vice *dev)
> >       }
> >
> >       adev->in_runpm =3D true;
> > -     if (amdgpu_device_supports_px(drm_dev))
> > +     if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
> >               drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING=
;
> >
> >       /*
> > @@ -2674,7 +2675,7 @@ static int amdgpu_pmops_runtime_suspend(struct de=
vice *dev)
> >        * platforms.
> >        * TODO: this may be also needed for PX capable platform.
> >        */
> > -     if (amdgpu_device_supports_boco(drm_dev))
> > +     if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
> >               adev->mp1_state =3D PP_MP1_STATE_UNLOAD;
> >
> >       ret =3D amdgpu_device_prepare(drm_dev);
> > @@ -2683,15 +2684,15 @@ static int amdgpu_pmops_runtime_suspend(struct =
device *dev)
> >       ret =3D amdgpu_device_suspend(drm_dev, false);
> >       if (ret) {
> >               adev->in_runpm =3D false;
> > -             if (amdgpu_device_supports_boco(drm_dev))
> > +             if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
> >                       adev->mp1_state =3D PP_MP1_STATE_NONE;
> >               return ret;
> >       }
> >
> > -     if (amdgpu_device_supports_boco(drm_dev))
> > +     if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO)
> >               adev->mp1_state =3D PP_MP1_STATE_NONE;
> >
> > -     if (amdgpu_device_supports_px(drm_dev)) {
> > +     if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX) {
> >               /* Only need to handle PCI state in the driver for ATPX
> >                * PCI core handles it for _PR3.
> >                */
> > @@ -2700,9 +2701,10 @@ static int amdgpu_pmops_runtime_suspend(struct d=
evice *dev)
> >               pci_ignore_hotplug(pdev);
> >               pci_set_power_state(pdev, PCI_D3cold);
> >               drm_dev->switch_power_state =3D DRM_SWITCH_POWER_DYNAMIC_=
OFF;
> > -     } else if (amdgpu_device_supports_boco(drm_dev)) {
> > +     } else if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO) {
> >               /* nothing to do */
> > -     } else if (amdgpu_device_supports_baco(drm_dev)) {
> > +     } else if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO ||
> > +                adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BAMACO) {
> >               amdgpu_device_baco_enter(drm_dev);
> >       }
> >
> > @@ -2725,7 +2727,7 @@ static int amdgpu_pmops_runtime_resume(struct dev=
ice *dev)
> >       if (!pci_device_is_present(adev->pdev))
> >               adev->no_hw_access =3D true;
> >
> > -     if (amdgpu_device_supports_px(drm_dev)) {
> > +     if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX) {
> >               drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING=
;
> >
> >               /* Only need to handle PCI state in the driver for ATPX
> > @@ -2737,22 +2739,22 @@ static int amdgpu_pmops_runtime_resume(struct d=
evice *dev)
> >               if (ret)
> >                       return ret;
> >               pci_set_master(pdev);
> > -     } else if (amdgpu_device_supports_boco(drm_dev)) {
> > +     } else if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO) {
> >               /* Only need to handle PCI state in the driver for ATPX
> >                * PCI core handles it for _PR3.
> >                */
> >               pci_set_master(pdev);
> > -     } else if (amdgpu_device_supports_baco(drm_dev)) {
> > +     } else if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO) {
> >               amdgpu_device_baco_exit(drm_dev);
> >       }
> >       ret =3D amdgpu_device_resume(drm_dev, false);
> >       if (ret) {
> > -             if (amdgpu_device_supports_px(drm_dev))
> > +             if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
> >                       pci_disable_device(pdev);
> >               return ret;
> >       }
> >
> > -     if (amdgpu_device_supports_px(drm_dev))
> > +     if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
> >               drm_dev->switch_power_state =3D DRM_SWITCH_POWER_ON;
> >       adev->in_runpm =3D false;
> >       return 0;
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/dr=
m/amd/pm/swsmu/amdgpu_smu.c
> > index f464610a959f..d7977185f4e2 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1618,7 +1618,8 @@ static int smu_disable_dpms(struct smu_context *s=
mu)
> >       bool use_baco =3D !smu->is_apu &&
> >               ((amdgpu_in_reset(adev) &&
> >                 (amdgpu_asic_reset_method(adev) =3D=3D AMD_RESET_METHOD=
_BACO)) ||
> > -              ((adev->in_runpm || adev->in_s4) && amdgpu_asic_supports=
_baco(adev)));
> > +              ((adev->in_runpm || adev->in_s4) &&
> > +              (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO || adev->pm.=
rpm_mode =3D=3D AMDGPU_RUNPM_BAMACO)));
> >
> >       /*
> >        * For SMU 13.0.0 and 13.0.7, PMFW will handle the DPM features(d=
isablement or others)
