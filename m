Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FBFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 18:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F82610E1EA;
	Thu, 17 Feb 2022 18:32:27 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFCE010E1EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 18:32:26 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 s203-20020a4a3bd4000000b003191c2dcbe8so594109oos.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WgGZ6kmyrdo3zOak8aGNNQeSSqU2jvsjqdD2WACKzuU=;
 b=BfNKbx0Qy5J6wAvOMa/HzQwkfIUMcCebD5sstMWps3RQMHSb+Ifz8rQaOU2jU+BSHO
 pF7Zs9lEj/uCJp9lomTGJNZr82qJodkQ6L6VaHYepxyMeGI5Ik6Q19ZMlOgGcom+kMWu
 H19400eMTyIRv+ZZ7Q/sfTQTONJyNDngQjAhSxtnUJCJimr4sBFFMWp56iTmpLg85qsr
 ab5BtkqHB8E+olTB69iTm2nuLD5QBF2zeO7P193d2AD9T2x68pbTOefZ93vuGTfulTiT
 LKdx1eSBnNOVW8d6h5YpnBwCjNh12nSxcFyydF/tdgYSybZEMW3OPoayFiZbmIMuy/OF
 /3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WgGZ6kmyrdo3zOak8aGNNQeSSqU2jvsjqdD2WACKzuU=;
 b=yjNBKKsWoG2NcnJ2TqMD1YQTwC+yKdRNIE7qqGDQpTqnt37AEhQUbtJAgk+Cw8pcrZ
 hMJDrCq4uKKkLVfUgZPTIQ65/hMDRKL+tUi7Z0KrCUrAPLa/fkhb9+v+O8WFxVoJNdSv
 AMK7uuCyLtGBtHMSL8Elclez1fFUJEPETVHJI/r6uPLZA19R/t4IOngtYm+Witt3ro5g
 qPoLNvAh4mCjGOCjKNd40hS1r1Kx79jI2saYDTbZFL4OA8XlfE1ceiR0Svt+jLFRuxQO
 uaVH7090CL6XpsdcLCeJW+L77OS+qBzLQWa0e0LAYxek0CQBMdy9SJq9oLZRY3w2bW1B
 lXyg==
X-Gm-Message-State: AOAM5310oi+30/z040XrBoxZmhFTknni6SvDZeX5TwjU9lfIdwZkyv5u
 XloIj9FOEbUdkcgIGIpXQHin50z09J1ev2Cs1VvvZD9a
X-Google-Smtp-Source: ABdhPJySkdSqiLrNIPg3AUFURZ7fvsP8eJ/FEDSSD5tr9DsjP5qOrbx7G5Ts8E0+E9mVBFIUwFLOg7ogusEA4nwmyAA=
X-Received: by 2002:a05:6870:b281:b0:d3:e9c:811d with SMTP id
 c1-20020a056870b28100b000d30e9c811dmr1505476oao.225.1645122746159; Thu, 17
 Feb 2022 10:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20220217163556.6491-1-luben.tuikov@amd.com>
 <DM6PR12MB3547FD0D228E17F075341B81F7369@DM6PR12MB3547.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3547FD0D228E17F075341B81F7369@DM6PR12MB3547.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 17 Feb 2022 13:32:15 -0500
Message-ID: <CADnq5_MwikUo68_NUpc5tuMPG5pB_S6zOgCk83y4OunzMzK=-Q@mail.gmail.com>
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

On Thu, Feb 17, 2022 at 1:25 PM StDenis, Tom <Tom.StDenis@amd.com> wrote:
>
> [AMD Official Use Only]
>
> This works, now I'm facing other issues.  Like we call the VCN block on n=
avi10 a "uvd 2.0.0".  Originally I was only accepting exact major hits whic=
h meant my navi10 model had no video enc/dec block once I programmed it to =
take the closest match it hit UVD 4.0.0 (pre-soc15/etc) and that's obviousl=
y wrong.
>  Shouldn't IP discovered video enc/dec be name VCN?

They used the UVD name since VCN was derived from UVD.  Not sure why
they didn't rename it.  Still, all asics that use IP discovery use
VCN, so no need to worry about UVD/VCE for IP discovery.

>
> On a semi related note we have no SDMA v5.x.y headers in the tree but nav=
i10+ uses it.  I guess the driver just uses SDMA 4.x.y headers because they=
're close enough but it means umr won't load in an SDMA model.
>

For navi10+, SDMA moved into the graphics block so the SDMA registers
are part of the GC headers on navi1x and newer.

> Which then gets us into weird conditions.  Right now I'm programming umr =
to find the closet abs() major hit, then minor, then revision.  But I imagi=
ne we'll hit cases where say version X.Y+1.Z is better than X.Y-1.Z and vic=
e versa (etc with the other fields).   There's no way for umr to know if a =
newer or older header is better.
>
> Tom
>
> ________________________________________
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Thursday, February 17, 2022 11:35
> To: amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben; Deucher, Alexander; StDenis, Tom
> Subject: [PATCH] drm/amdgpu: Dynamically initialize IP instance attribute=
s
>
> Dynamically initialize IP instance attributes. This eliminates bugs
> stemming from adding new attributes to an IP instance.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Reported-by: Tom StDenis <tom.stdenis@amd.com>
> Fixes: c10b6aa7417b0a ("drm/amdgpu: Add "harvest" to IP discovery sysfs")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 6c7ec058125e1d..5848fec5c39251 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -482,16 +482,7 @@ static struct ip_hw_instance_attr ip_hw_attr[] =3D {
>         __ATTR_RO(base_addr),
>  };
>
> -static struct attribute *ip_hw_instance_attrs[] =3D {
> -       &ip_hw_attr[0].attr,
> -       &ip_hw_attr[1].attr,
> -       &ip_hw_attr[2].attr,
> -       &ip_hw_attr[3].attr,
> -       &ip_hw_attr[4].attr,
> -       &ip_hw_attr[5].attr,
> -       &ip_hw_attr[6].attr,
> -       NULL,
> -};
> +static struct attribute *ip_hw_instance_attrs[ARRAY_SIZE(ip_hw_attr) + 1=
];
>  ATTRIBUTE_GROUPS(ip_hw_instance);
>
>  #define to_ip_hw_instance(x) container_of(x, struct ip_hw_instance, kobj=
)
> @@ -789,7 +780,7 @@ static int amdgpu_discovery_sysfs_recurse(struct amdg=
pu_device *adev)
>  static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>  {
>         struct kset *die_kset;
> -       int res;
> +       int res, ii;
>
>         adev->ip_top =3D kzalloc(sizeof(*adev->ip_top), GFP_KERNEL);
>         if (!adev->ip_top)
> @@ -814,6 +805,10 @@ static int amdgpu_discovery_sysfs_init(struct amdgpu=
_device *adev)
>                 goto Err;
>         }
>
> +       for (ii =3D 0; ii < ARRAY_SIZE(ip_hw_attr); ii++)
> +               ip_hw_instance_attrs[ii] =3D &ip_hw_attr[ii].attr;
> +       ip_hw_instance_attrs[ii] =3D NULL;
> +
>         res =3D amdgpu_discovery_sysfs_recurse(adev);
>
>         return res;
>
> base-commit: f736148ca7bf82654141a4411409c2d7a9e2269b
> --
> 2.35.1.129.gb80121027d
>
