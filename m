Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D0AC07CA9
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Nov 2023 14:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFFEB10E70A;
	Thu, 30 Nov 2023 14:21:44 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4648610E70A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 14:21:44 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1f03d9ad89fso460738fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Nov 2023 06:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701354103; x=1701958903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+bKXwT05UG+snhgwAmWWj5n9+Zmy3GUtPSkIexOUaM=;
 b=cUFd5HZ/D1c+5L2k14DdzBFX5QkFUWc6ZJz1KNU8Uqj6L5i/htzQU46vgwCoUfaxYO
 Pf4RGPQAmp4LjXYMJ0LBZ7ROvupbWVIm/bVYiOqjqyaMDwT6+HCTd20b3JZappaC8xk+
 HwhrIyfEsqVpHpYqKP3KLtBuIqjvZTUFbvRh5R6VMw6dn7zgiu2HIsufxBS2azyE50Xi
 piVKc8BbhuuGrlnIV+WRoGMqc9vMsTqv19cNxyX1vrXy7chclDDAGBMFiKilgpIevSiw
 iyr+RocgkGnaLrULSR6mj4X/nz3G38uIpo2HRXPoe/uQV2GS6IvGHUFT69wWNngmtGMu
 JdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701354103; x=1701958903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L+bKXwT05UG+snhgwAmWWj5n9+Zmy3GUtPSkIexOUaM=;
 b=Ac825k12+/9MccqGW4d7R+49/1RtrhUpYXmhoBhlXM3a66WpYBVkerf/VhXHvGJoTU
 P/Jkn+OFUrVbyZA2UwKn47Pfx7WsBIU1DMj545n0/V2MWDyZuC+WGPDOl+x9BMiG8oNd
 //JKuNkmD34FSYtum2eQQDgn/A47H+nNBPV8Dy5ozz0kKsHsGk6leX6dOKLdcdog6fcv
 rswb/isMis/xbO4k60cml+HxHZA0qOo7U2KuIWMYFs/ILAzsVRrqovN3pkkGsqAszyjg
 j4YBIKSwJdhQ8m4X+xR2MN6hOpLh77mpVI3H7ibVgWVfJ6kWlxz2/fC4l/PgI61zY2ip
 WLag==
X-Gm-Message-State: AOJu0YwrWZfdFSeWEtHVwZDxrDdxp8cdEH1ebeJcB/zrhXet2G6w3ar4
 JGrH4RPdkgmArT5my74HSexo5rEHi2P+PQJ/AhM=
X-Google-Smtp-Source: AGHT+IEN8bNPEtMhOLYgkptd7ppzSMcfMpmGNxRItboBNznWfGRujGxufs1DcG3NaH+etX2MTh4T+mb96pfEnErO7IU=
X-Received: by 2002:a05:6870:612c:b0:1fa:26b3:a03d with SMTP id
 s44-20020a056870612c00b001fa26b3a03dmr21211720oae.39.1701354103073; Thu, 30
 Nov 2023 06:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20231129085156.30698-1-Jun.Ma2@amd.com>
 <CADnq5_NX1hfyq34+HkVirXxS28j69-hFdH-q9jwnfDwmdcBsLA@mail.gmail.com>
 <42d53ace-3cfb-469a-ad10-f2a2ee8609fb@amd.com>
In-Reply-To: <42d53ace-3cfb-469a-ad10-f2a2ee8609fb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Nov 2023 09:21:31 -0500
Message-ID: <CADnq5_PCTjUNwRHwb7sAynqRF98w=e09eYHbck3SFsvC-CgPzQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add a new module param to disable d3cold
To: "Ma, Jun" <majun@amd.com>
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
Cc: kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org,
 Ma Jun <Jun.Ma2@amd.com>, mario.limonciello@amd.com, Alexander.Deucher@amd.com,
 Kenneth.Feng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 30, 2023 at 1:29=E2=80=AFAM Ma, Jun <majun@amd.com> wrote:
>
> Hi Alex,
>
> On 11/30/2023 12:39 AM, Alex Deucher wrote:
> > On Wed, Nov 29, 2023 at 11:37=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote=
:
> >>
> >> Some platforms can't resume from d3cold state, So add a
> >> new module parameter to disable d3cold state for debugging
> >> purpose or workaround.
> >
> > Doesn't the runpm parameter already handle this?  If you set runpm=3D0,
> > that should disable d3cold.
> >
> runpm=3D0  prevents calls to driver runtime_suspend/resume functions.
> While d3cold=3D0 allows calls to runtime_suspend/resume functions and put=
s
> the device in d3hot state instead of d3cold.

But d3hot doesn't actually power down the card so it won't save any
power.  If we want to disable d3cold and still use runtime pm, it's
better to try and use BACO.

Alex

>
> Regards,
> Ma Jun
>
> > Alex
> >
> >>
> >> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
> >>  3 files changed, 16 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h
> >> index a9f54df9d33e..db9f60790267 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -166,6 +166,7 @@ extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEO=
UT_PARAM_LENGTH];
> >>  extern int amdgpu_dpm;
> >>  extern int amdgpu_fw_load_type;
> >>  extern int amdgpu_aspm;
> >> +extern int amdgpu_d3cold;
> >>  extern int amdgpu_runtime_pm;
> >>  extern uint amdgpu_ip_block_mask;
> >>  extern int amdgpu_bapm;
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_device.c
> >> index 22b6a910b7f2..90501c44e7d0 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -264,6 +264,13 @@ bool amdgpu_device_supports_px(struct drm_device =
*dev)
> >>  bool amdgpu_device_supports_boco(struct drm_device *dev)
> >>  {
> >>         struct amdgpu_device *adev =3D drm_to_adev(dev);
> >> +       struct pci_dev *parent;
> >> +
> >> +       if (!amdgpu_d3cold) {
> >> +               parent =3D pcie_find_root_port(adev->pdev);
> >> +               pci_d3cold_disable(parent);
> >> +               return false;
> >> +       }
> >>
> >>         if (adev->has_pr3 ||
> >>             ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c
> >> index 5f14f04cb553..c9fbb8bd4169 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >> @@ -145,6 +145,7 @@ char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARA=
M_LENGTH];
> >>  int amdgpu_dpm =3D -1;
> >>  int amdgpu_fw_load_type =3D -1;
> >>  int amdgpu_aspm =3D -1;
> >> +int amdgpu_d3cold =3D -1;
> >>  int amdgpu_runtime_pm =3D -1;
> >>  uint amdgpu_ip_block_mask =3D 0xffffffff;
> >>  int amdgpu_bapm =3D -1;
> >> @@ -359,6 +360,13 @@ module_param_named(fw_load_type, amdgpu_fw_load_t=
ype, int, 0444);
> >>  MODULE_PARM_DESC(aspm, "ASPM support (1 =3D enable, 0 =3D disable, -1=
 =3D auto)");
> >>  module_param_named(aspm, amdgpu_aspm, int, 0444);
> >>
> >> +/**
> >> + * DOC: d3cold (int)
> >> + * To disable d3cold (1 =3D enable, 0 =3D disable). The default is -1=
 (auto, enabled).
> >> + */
> >> +MODULE_PARM_DESC(d3cold, "d3cold support (1 =3D enable, 0 =3D disable=
, -1 =3D auto)");
> >> +module_param_named(d3cold, amdgpu_d3cold, int, 0444);
> >> +
> >>  /**
> >>   * DOC: runpm (int)
> >>   * Override for runtime power management control for dGPUs. The amdgp=
u driver can dynamically power down
> >> --
> >> 2.34.1
> >>
