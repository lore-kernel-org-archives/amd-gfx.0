Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7902C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 14:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37BBA10E1B7;
	Fri, 20 May 2022 14:52:45 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5985C10E1B7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 14:52:43 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id q10so10219114oia.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 07:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OwzUJfvpDQMDoYRJbR8M2kuP05MX8OCwljv9/gtYRLU=;
 b=jzasruQknWepqrIEmET6Xwo1rG3nhIDVYm+MpRrZ9JenMFqg6e/BWW5AXtrP+hYfV4
 PawZK1SWoOBgRU+N9q53nTd2exQ6OdAShtCW8bbxYoiQgoYTTSh+m4I8tKVPIHwbwSgJ
 y2gJeIsK+/7WL/QSi7mYGAQzYgvF86hhs1spFi38g9/HJFXF7JyU8IKJx8sF1mw5L7pi
 qIbEvHRH2K0jC/nMq6TjTpBTNa5ciwV/FNzZBrbD73Ul6jWU9bgGURHKRUxyDIPlsufm
 4mxgpUbQqV56HeZAf7ZJqrzTXeVWmTMVecFgGYJoRtfSUTAApRzIeAcIbCDkujywrv76
 UYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OwzUJfvpDQMDoYRJbR8M2kuP05MX8OCwljv9/gtYRLU=;
 b=7/gINzWXBL5szG3CfVka3jf5As4stG0S0Og8dJ0KhEIknFvRtIo/U4B3OqlUFBm5s1
 4jEQLaWenQZlwMZxPeI3Fnr83PW7VyvWfyOJsBDS5TTNk/yKP9ko43P4wJ1WUMBS0Tjx
 RVQE/IJMwCCOzBwoQNHUcUwrJtvR5gqG1v18gYNHOBRVgqv7J4OEJvwmMd/VRh5tf2Ti
 56kOU6Q1/bKIxLwSmzjOtWm4fRSKdKTw0nrn5SiD2ICm/glrm0tLAQ8i3qRCBpBIL5QX
 6PDWV4DGTNZQawEqT7zk/xX+pOgdz4tiVUxruQTBwiTN331MaUXI5rNwisYDnBT4C92X
 XYZA==
X-Gm-Message-State: AOAM530O/4ilDXQAZ64oy+Ih3JqPDme4QhQEDwQMcrcFtfG2k8iJpMUn
 yc6c/tmaBirixhdhTTbvlbwjWgjQtZQe58A15HNKju7S
X-Google-Smtp-Source: ABdhPJwrYOfTVow916Y2yGUQumF2OH6B0QLsnfrhPBAVcuyEm6g/aRe1TVvKauCAX9TTqquAPaSeLr8W45YZoxs4DQE=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr5860532oiw.253.1653058362680; Fri, 20
 May 2022 07:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220520075932.186691-1-danijel.slivka@amd.com>
 <CADnq5_P8p5zKiW20xek0M0DVs+YRDX6qcy+b01NWXP_NUs9O5Q@mail.gmail.com>
 <BYAPR12MB3094F87BED21F64FE5BD4C4798D39@BYAPR12MB3094.namprd12.prod.outlook.com>
 <CADnq5_PArQi9FdOufwO7XnHXf85euPN_H_3hvqyJYUW47nHFCg@mail.gmail.com>
 <BYAPR12MB30941FC0900BB87D03F2C20898D39@BYAPR12MB3094.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB30941FC0900BB87D03F2C20898D39@BYAPR12MB3094.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 May 2022 10:52:31 -0400
Message-ID: <CADnq5_NEw929TkfWuT359wzMDfnS9_=+896PByf1kFeCst8zFw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Skip init fbdev if virtual_display is enabled
To: "Slivka, Danijel" <Danijel.Slivka@amd.com>
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

On Fri, May 20, 2022 at 10:49 AM Slivka, Danijel <Danijel.Slivka@amd.com> w=
rote:
>
> [AMD Official Use Only - General]
>
> But for virtual display enabled we are not using display capability so sh=
ouldn't it be considered as hw without DCE.

I thought the goal of virtual DCE was for it to be just like real DCE.
Why would you want to treat it differently?  There is no need to
register an fbdev device if there is no display hardware, virtual or
real, but I don't see why you would want to treat virtual DCE any
differently than real DCE.

Alex

>
> BR,
> Danijel Slivka
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, May 20, 2022 4:33 PM
> To: Slivka, Danijel <Danijel.Slivka@amd.com>
> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] drm/amdgpu: Skip init fbdev if virtual_display is en=
abled
>
> On Fri, May 20, 2022 at 10:12 AM Slivka, Danijel <Danijel.Slivka@amd.com>=
 wrote:
> >
> > [AMD Official Use Only - General]
> >
> > Hi,
> >
> > Based on the code we shouldn't init the fbdev on hw without DCE:
>
> That comment means don't init fbdev on chips without display hardware (ei=
ther real or virtual).  E.g., iceland or MI100.
>
> Alex
>
> >
> >         /*
> >          * 1. don't init fbdev on hw without DCE
> >          * 2. don't init fbdev if there are no connectors
> >          */
> >         if (adev->mode_info.mode_config_initialized &&
> >             !list_empty(&adev_to_drm(adev)->mode_config.connector_list)=
) {
> >                 /* select 8 bpp console on low vram cards */
> >                 if (adev->gmc.real_vram_size <=3D (32*1024*1024))
> >                         drm_fbdev_generic_setup(adev_to_drm(adev), 8);
> >                 else
> >                         drm_fbdev_generic_setup(adev_to_drm(adev), 32);
> >         }
> >
> > For virtualization we always use virtual_display and doesn=E2=80=99t ha=
ve the hw DCE for that reason setting up fbdev should be skipped.
> >
> >
> > BR,
> > Danijel Slivka
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, May 20, 2022 3:30 PM
> > To: Slivka, Danijel <Danijel.Slivka@amd.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > Subject: Re: [PATCH] drm/amdgpu: Skip init fbdev if virtual_display is
> > enabled
> >
> > On Fri, May 20, 2022 at 3:59 AM Danijel Slivka <danijel.slivka@amd.com>=
 wrote:
> > >
> > > In case virtaul_display is enabled there is no hw DCE so need to
> > > skip setting up fbdev.
> >
> > Wouldn't you theoretically still want fbdev even if it is virtual?
> >
> > Alex
> >
> > >
> > > Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > index 3b9dc1803be9..8d03eec49eef 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -2095,6 +2095,7 @@ static int amdgpu_pci_probe(struct pci_dev *pde=
v,
> > >          * 2. don't init fbdev if there are no connectors
> > >          */
> > >         if (adev->mode_info.mode_config_initialized &&
> > > +           !adev->enable_virtual_display &&
> > >             !list_empty(&adev_to_drm(adev)->mode_config.connector_lis=
t)) {
> > >                 /* select 8 bpp console on low vram cards */
> > >                 if (adev->gmc.real_vram_size <=3D (32*1024*1024))
> > > --
> > > 2.25.1
> > >
