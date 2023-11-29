Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D45C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Nov 2023 18:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29A8C10E052;
	Wed, 29 Nov 2023 18:40:36 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA1710E052
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 18:40:35 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6d84ec109fbso84697a34.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Nov 2023 10:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701283234; x=1701888034; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vk7JrAawAHloaVnarymRWt/jZosO9ViYZILZNMgjEHI=;
 b=RZ83c6lffrKqOW9ey9Xj/kxq9pQLmtSsAG7hq0Ul8bNBj5glH2BG8idK88+s3RnLPi
 6NNJY8bCq+/6eW8CrdOgRIZlzLEU1EWtR5B1AtUz2SALOQYSWecDEdQG1Od+wgfHFW2e
 o//MH883b7LCf/CAkonKHRvyW7gb1wstxcb/tsSHbREASE0xADrRL7PEL+zth+Ir63Pg
 Hyv1kriTcFoTTFKUrSZZkFwo9l1Navddvvz0HDKdkAwedAF4WOn4OilJEfDTp2Kkdc2K
 qaHxwikPkOUvjWppbr4rPpGgEm127Yti5yQ9uSXwkD/QOvVe9O0cSCZzXvdOMxjJNeLa
 aU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701283234; x=1701888034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vk7JrAawAHloaVnarymRWt/jZosO9ViYZILZNMgjEHI=;
 b=JOXbIVtV+BDW2MQemsIHF+Le+MWEuJHAnDIU7zq9rV79SdFoLFhrk9k3yT4yktlR/L
 cZ/adGVO+KuunGnBrwdsD2Fi3VQh+OjU3uFt4bQMsVDJ7vQojdfjZI+vtW4GhEsbpJno
 t+PukWG5dH+aMN3m2rmRbxRl/CJ/158RX+8OiYWa8jnJufFVnZoEbTEkLHW2FdpEvlTt
 5zCEFp/OTBNoOdT3aPuQI0wZYEcWbM4bNqtwSZ23+EY6iv9n2WtP3noz+b7TpY4KuY9w
 qBc/3HXrSlmodpaSqmqJGR/BHaTRDxAM8w4XDSI/yOqayVtHclCBN1rmoGqvLswWOi/0
 FfjA==
X-Gm-Message-State: AOJu0YxveDhZOJ9y1307CERwr5WGLjSgmgiLydSMr5kt8NxYcs/du/Ji
 cqLTHJkyBf676VramWyNBUWhEZqWNwnYsk+UnB4=
X-Google-Smtp-Source: AGHT+IGwuN8j/pNmEdCqGQigFXy++KsVa/CRDkhx5tt7E9BjTCyo5ukIXAEs91xuvuIUiY9H962LAgQSi5WRmn2N4nw=
X-Received: by 2002:a05:6870:f783:b0:1ea:746d:16f7 with SMTP id
 fs3-20020a056870f78300b001ea746d16f7mr27324881oab.6.1701283234217; Wed, 29
 Nov 2023 10:40:34 -0800 (PST)
MIME-Version: 1.0
References: <20231129085156.30698-1-Jun.Ma2@amd.com>
 <d21116d8-9747-4b0f-b574-18b0d5558f16@amd.com>
In-Reply-To: <d21116d8-9747-4b0f-b574-18b0d5558f16@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Nov 2023 13:40:22 -0500
Message-ID: <CADnq5_P0rArhq19Hq6_tBb2jB5OdY+TCtyb6ops12M2rJ6Owqw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add a new module param to disable d3cold
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Alexander.Deucher@amd.com, Ma Jun <Jun.Ma2@amd.com>, Kenneth.Feng@amd.com,
 kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 29, 2023 at 1:02=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 11/29/2023 02:51, Ma Jun wrote:
> > Some platforms can't resume from d3cold state, So add a
> > new module parameter to disable d3cold state for debugging
> > purpose or workaround.
> >
> > Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> > ---
>
> This patch is essentially an 'amdgpu knob' for d3cold on the root port.
> At least for debugging purposes we also have a sysfs file
> 'd3cold_allowed' that will enact the same behavior.
>
> I do have a patch that I proposed to PCI core that stops d3cold_allowed
> from working in favor of requesting pcie_port_pm=3Doff to be used instead
> for debugging purposes.
>
> However that's a 'relatively big' debugging knob however as it will
> apply to all PCIe root ports.
>
> Considering above I'm in favor of this being available as a localized
> debugging path for just the root port the dGPU is connected to.

What functionality does this option provide that runpm=3D0 does not?
AFAIK, the pci core should not enter d3cold at runtime if the driver
doesn't call pm_runtime_allow().

Alex

>
> Some comments below though:
>
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 8 ++++++++
> >   3 files changed, 16 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index a9f54df9d33e..db9f60790267 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -166,6 +166,7 @@ extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOU=
T_PARAM_LENGTH];
> >   extern int amdgpu_dpm;
> >   extern int amdgpu_fw_load_type;
> >   extern int amdgpu_aspm;
> > +extern int amdgpu_d3cold;
> >   extern int amdgpu_runtime_pm;
> >   extern uint amdgpu_ip_block_mask;
> >   extern int amdgpu_bapm;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 22b6a910b7f2..90501c44e7d0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -264,6 +264,13 @@ bool amdgpu_device_supports_px(struct drm_device *=
dev)
> >   bool amdgpu_device_supports_boco(struct drm_device *dev)
> >   {
> >       struct amdgpu_device *adev =3D drm_to_adev(dev);
> > +     struct pci_dev *parent;
> > +
> > +     if (!amdgpu_d3cold) {
> > +             parent =3D pcie_find_root_port(adev->pdev);
> > +             pci_d3cold_disable(parent);
> > +             return false;
> > +     }
> >
> >       if (adev->has_pr3 ||
> >           ((adev->flags & AMD_IS_PX) && amdgpu_is_atpx_hybrid()))
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> > index 5f14f04cb553..c9fbb8bd4169 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -145,6 +145,7 @@ char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM=
_LENGTH];
> >   int amdgpu_dpm =3D -1;
> >   int amdgpu_fw_load_type =3D -1;
> >   int amdgpu_aspm =3D -1;
> > +int amdgpu_d3cold =3D -1;
>
> If this was chained to a larger workaround (such as automatically
> applying to a DMI quirk) it would make sense as int and with using
> -1 for auto.  However there is a pretty dramatic downside for using this
> knob that it can break s2idle.
>
> In my testing I've found that the following happens on an A+A design
> after s2idle with this parameter in use.
>
> [   70.572270] pcieport 0000:01:00.0: Unable to change power state from
> D3cold to D0, device inaccessible
> [   70.572481] pcieport 0000:02:00.0: Unable to change power state from
> D3cold to D0, device inaccessible
> [   72.855769] amdgpu 0000:03:00.0: not ready 1023ms after resume; waitin=
g
> [   73.943545] amdgpu 0000:03:00.0: not ready 2047ms after resume; waitin=
g
> [   76.055602] amdgpu 0000:03:00.0: not ready 4095ms after resume; waitin=
g
> [   80.279550] amdgpu 0000:03:00.0: not ready 8191ms after resume; waitin=
g
> [   88.983562] amdgpu 0000:03:00.0: not ready 16383ms after resume; waiti=
ng
> [  105.879581] amdgpu 0000:03:00.0: not ready 32767ms after resume; waiti=
ng
> [  142.743646] amdgpu 0000:03:00.0: not ready 65535ms after resume;
> giving up
> [  142.743793] amdgpu 0000:03:00.0: Unable to change power state from
> D3cold to D0, device inaccessible
> [  142.804011] snd_hda_intel 0000:03:00.1: Unable to change power state
> from D3cold to D0, device inaccessible
>
> So I don't see us ever automatically using this and it should be
> debugging only.  IOW this doesn't need to be integer; it can be boolean.
>
> >   int amdgpu_runtime_pm =3D -1;
> >   uint amdgpu_ip_block_mask =3D 0xffffffff;
> >   int amdgpu_bapm =3D -1;
> > @@ -359,6 +360,13 @@ module_param_named(fw_load_type, amdgpu_fw_load_ty=
pe, int, 0444);
> >   MODULE_PARM_DESC(aspm, "ASPM support (1 =3D enable, 0 =3D disable, -1=
 =3D auto)");
> >   module_param_named(aspm, amdgpu_aspm, int, 0444);
> >
> > +/**
> > + * DOC: d3cold (int)
>
> If you flip it to boolean as I suggested this should probably either
> rename to disable_d3cold or you should default to TRUE.
>
> > + * To disable d3cold (1 =3D enable, 0 =3D disable). The default is -1 =
(auto, enabled).
> > + */
> > +MODULE_PARM_DESC(d3cold, "d3cold support (1 =3D enable, 0 =3D disable,=
 -1 =3D auto)");
> > +module_param_named(d3cold, amdgpu_d3cold, int, 0444);
> > +
> >   /**
> >    * DOC: runpm (int)
> >    * Override for runtime power management control for dGPUs. The amdgp=
u driver can dynamically power down
>
