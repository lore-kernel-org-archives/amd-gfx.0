Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDA6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 19:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5C110E735;
	Thu, 17 Feb 2022 19:36:39 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3495710E733
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 19:36:38 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id s8so689508oij.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 11:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ShRtddw7T8Hqm9RtiUCrKzoxf0bqdoV5rfxBmXNuNb4=;
 b=BucXm0yA3W4AcQYaS8vGo73n8UVqeNvMA5PCRjZEXvKpxSeY45y2o70zyK2Yc2eolT
 hxuW/W13vW0DWGAhAD3lwj0gRyUERDbE5RW07Jo+z3xDN41AurwHSxrgQBthOrFIchxH
 ZE8t2P8581Gq89rFE51lUJBOe4XMdh8OajLO5gU4RpZ0Fsp/sju1WcDifdZe+bi2qHF/
 wwftS0NJkTA1Uq2T/15xV3EGtI5EJmgVQNXuR8yi4QGUodd+BMcLDN6LKDuUcwVoZxjR
 ho65XvgfkDMunRIJL89r/LUgEykDvmkEJHjVdHzsPoTVmFUdb1D9r14GPcdsiWct6j6W
 xGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ShRtddw7T8Hqm9RtiUCrKzoxf0bqdoV5rfxBmXNuNb4=;
 b=vqkxiFMQUPUyT1/OOMUfvzy6ldWgB8y5qCTvrz3Xg6YORGKWzpic2nuisfAEJurfq6
 N+F3+qAUS3Bh3bjZSbBBUOtGGjptwo8pFgd08aPepkzMN0XpW7+GzUy+Cc2q9ptokWXC
 nlhb8kaJZ6rfANPxs4GN8CHAEcYSJLBFOWgu4xwaXp9eg5nhGSrcndMrZfWq/cGW8UT/
 oalNvPUm83aeR3CGjbZe4PMbIHl5PqAFyDKv4qNz5Rys/tO7av2UAsIqnyZ9OkCAWkP1
 RsCD2DGfphzjKPzCCQDMceXG3umHKPbIsxFpgzVEVpq9haN0ARiHPY4CanS7ak7qZMSj
 +UaA==
X-Gm-Message-State: AOAM533ZwvNJzscm/5glbKKewUS/IRGxlK8stFNM63f59gDxeKA9M/O4
 7mKbMAVMmyMiD3Nx3lmCt+T684dOxmbpq+/TDPU=
X-Google-Smtp-Source: ABdhPJx154HHaGL36N88ULIIlVMKBVpbjosld37vXwivMng97+csNsO6+FLZ167K/YXotFr37HViKWQEEkOdvt53YvU=
X-Received: by 2002:aca:ab4c:0:b0:2d4:7c7d:606e with SMTP id
 u73-20020acaab4c000000b002d47c7d606emr1551775oie.132.1645126597410; Thu, 17
 Feb 2022 11:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20220217163556.6491-1-luben.tuikov@amd.com>
 <DM6PR12MB3547FD0D228E17F075341B81F7369@DM6PR12MB3547.namprd12.prod.outlook.com>
 <CADnq5_MwikUo68_NUpc5tuMPG5pB_S6zOgCk83y4OunzMzK=-Q@mail.gmail.com>
 <DM6PR12MB3547FAA765845791CDADC3ACF7369@DM6PR12MB3547.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3547FAA765845791CDADC3ACF7369@DM6PR12MB3547.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Feb 2022 14:36:26 -0500
Message-ID: <CADnq5_NZ1xDWkEpqN-D5T=oOsSFadw5c6qPpC=R4OZKcUo-xfA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Dynamically initialize IP instance attributes
To: "StDenis, Tom" <Tom.StDenis@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Tuikov,
 Luben" <Luben.Tuikov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 17, 2022 at 2:20 PM StDenis, Tom <Tom.StDenis@amd.com> wrote:
>
> [AMD Official Use Only]
>
> I can do IP name substitutions but that's kinda not the point.  We put he=
aders called "vcn_x_y_z*.h" in the source tree but call the IP block UVD.
>
> As for SDMA ... the IP discovery has entries for SDMA0 and SDMA1 IP block=
s on my navi10...
>
> [root@fedora umr]# cat /sys/class/drm/card0/device/ip_discovery/die/0/SDM=
A0/0/major
> 5
> [root@fedora umr]# cat /sys/class/drm/card0/device/ip_discovery/die/0/SDM=
A1/0/major
> 5
>
> If they're "behind the GC block" then there really isn't an SDMA block ri=
ght?

Sort of; different hardware teams own them, but then the IP gets
integrated into the GC hardware block on the SoC, so the team that
generates the register headers sees it all as GC rather than as GC and
SDMA.  I guess from the perspective of something like umr, you can
just use GC for both SDMA and GC.  The memory hubs are similar. GFXHUB
is part of GC so it's registers are part of GC, but MMHUB is it's own
block and has its own register headers.

Alex

>
> Right now umr just ignores anything it can't pair up but I imagine it'll =
cause some confusion later on.
>
> Tom
>
> ________________________________________
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, February 17, 2022 13:32
> To: StDenis, Tom
> Cc: Tuikov, Luben; amd-gfx@lists.freedesktop.org; Deucher, Alexander
> Subject: Re: [PATCH] drm/amdgpu: Dynamically initialize IP instance attri=
butes
>
> On Thu, Feb 17, 2022 at 1:25 PM StDenis, Tom <Tom.StDenis@amd.com> wrote:
> >
> > [AMD Official Use Only]
> >
> > This works, now I'm facing other issues.  Like we call the VCN block on=
 navi10 a "uvd 2.0.0".  Originally I was only accepting exact major hits wh=
ich meant my navi10 model had no video enc/dec block once I programmed it t=
o take the closest match it hit UVD 4.0.0 (pre-soc15/etc) and that's obviou=
sly wrong.
> >  Shouldn't IP discovered video enc/dec be name VCN?
>
> They used the UVD name since VCN was derived from UVD.  Not sure why
> they didn't rename it.  Still, all asics that use IP discovery use
> VCN, so no need to worry about UVD/VCE for IP discovery.
>
> >
> > On a semi related note we have no SDMA v5.x.y headers in the tree but n=
avi10+ uses it.  I guess the driver just uses SDMA 4.x.y headers because th=
ey're close enough but it means umr won't load in an SDMA model.
> >
>
> For navi10+, SDMA moved into the graphics block so the SDMA registers
> are part of the GC headers on navi1x and newer.
>
> > Which then gets us into weird conditions.  Right now I'm programming um=
r to find the closet abs() major hit, then minor, then revision.  But I ima=
gine we'll hit cases where say version X.Y+1.Z is better than X.Y-1.Z and v=
ice versa (etc with the other fields).   There's no way for umr to know if =
a newer or older header is better.
> >
> > Tom
> >
> > ________________________________________
> > From: Tuikov, Luben <Luben.Tuikov@amd.com>
> > Sent: Thursday, February 17, 2022 11:35
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Tuikov, Luben; Deucher, Alexander; StDenis, Tom
> > Subject: [PATCH] drm/amdgpu: Dynamically initialize IP instance attribu=
tes
> >
> > Dynamically initialize IP instance attributes. This eliminates bugs
> > stemming from adding new attributes to an IP instance.
> >
> > Cc: Alex Deucher <Alexander.Deucher@amd.com>
> > Reported-by: Tom StDenis <tom.stdenis@amd.com>
> > Fixes: c10b6aa7417b0a ("drm/amdgpu: Add "harvest" to IP discovery sysfs=
")
> > Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
> >  1 file changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index 6c7ec058125e1d..5848fec5c39251 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -482,16 +482,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] =3D=
 {
> >         __ATTR_RO(base_addr),
> >  };
> >
> > -static struct attribute *ip_hw_instance_attrs[] =3D {
> > -       &ip_hw_attr[0].attr,
> > -       &ip_hw_attr[1].attr,
> > -       &ip_hw_attr[2].attr,
> > -       &ip_hw_attr[3].attr,
> > -       &ip_hw_attr[4].attr,
> > -       &ip_hw_attr[5].attr,
> > -       &ip_hw_attr[6].attr,
> > -       NULL,
> > -};
> > +static struct attribute *ip_hw_instance_attrs[ARRAY_SIZE(ip_hw_attr) +=
 1];
> >  ATTRIBUTE_GROUPS(ip_hw_instance);
> >
> >  #define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, ko=
bj)
> > @@ -789,7 +780,7 @@ static int amdgpu_discovery_sysfs_recurse(struct am=
dgpu_device *adev)
> >  static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
> >  {
> >         struct kset *die_kset;
> > -       int res;
> > +       int res, ii;
> >
> >         adev->ip_top =3D kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
> >         if (!adev->ip_top)
> > @@ -814,6 +805,10 @@ static int amdgpu_discovery_sysfs_init(struct amdg=
pu_device *adev)
> >                 goto Err;
> >         }
> >
> > +       for (ii =3D 0; ii < ARRAY_SIZE(ip_hw_attr); ii++)
> > +               ip_hw_instance_attrs[ii] =3D &ip_hw_attr[ii].attr;
> > +       ip_hw_instance_attrs[ii] =3D NULL;
> > +
> >         res =3D amdgpu_discovery_sysfs_recurse(adev);
> >
> >         return res;
> >
> > base-commit: f736148ca7bf82654141a4411409c2d7a9e2269b
> > --
> > 2.35.1.129.gb80121027d
> >
