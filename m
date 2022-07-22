Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749AAC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 13:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B1E11A5E0;
	Fri, 22 Jul 2022 13:16:30 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C55412AD20
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 13:16:29 +0000 (UTC)
Received: by mail-ed1-x52e.google.com with SMTP id v12so5802745edc.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PAaho0IhhQYlez98JfjRGU5nOjjU+e/Evp5xPq8myTY=;
 b=U9fJjqNKgCeSbr4xwU86R0+vE+ID1nYQ8p2QjiPqsKAKvER2C/oP5RsnpZ/j2t1zq/
 8bJko6JF2aPhTvdO00DVSTc083e+NGOwHcCsbA0H7dLOHgp3vhGVEVWLc9rrZIgiREWV
 kSdkKMosf1rpQN9uOc6SViJw8avfX6dcc5SaM9+i13JrEokL4c5bgTthjN2m3KK+0EYG
 MdjuFfnvMZfDcJ5SEEl+kuqIlPqZryP9fBbbHviS52P38NjJBQadVnhntPlkVHwEd235
 ZAvVdon9pNeHI4IAw7At/lODYvkpYN/bJ/M50fhfVDsvn4+LeM5Mj158wkE7dhMhuf43
 iA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PAaho0IhhQYlez98JfjRGU5nOjjU+e/Evp5xPq8myTY=;
 b=1swhxbEYKJ5Ma8Z7I7ILWeams2XXFTg2ZE5i9T8UicE9Wfdng69VyKdvGlZNju9YRC
 lli50sV3/zbTvpcUptCTyYPvSBgX8YnKfFz6gNms/Ws1tVpdIeBsz1YdWfjse5UHDMdu
 y1gf9ZejlJHPHzz1ldlp6R5ijygAjfveSW/9vwNfoupMemkb6XaKgqcOtEdT9F96tptC
 J7BATWi/QKBZCF0H60o07AHuNHasEU1tNvdAqksgGsgSYLdEJHsk8ioT+pMWIbpGO+M6
 o3w6/863Rb3j6n/opJp3zlxE/3/GZTFVR/N0ZPOcJb22ABToXYGLoBRbGSMe70zpsUHn
 LaOQ==
X-Gm-Message-State: AJIora9Wi6XfuaAkzHEVd3OVhj1NvAC+oUiNGSZ1yFioizKv+aHLAhMS
 GglsTYDZg3W9muTsiag8oI02IW/bNzXfStPW1jikoSlIKYY=
X-Google-Smtp-Source: AGRyM1vjWo7gzEipEqiaOYXC8lWIfAKi3OzGPPqB8hB9D//BIyHxdxW0cbcbeGTGD8SU93yBQ7lZeTbMM/L+qJr8ybY=
X-Received: by 2002:a05:6402:248d:b0:437:dd4c:e70e with SMTP id
 q13-20020a056402248d00b00437dd4ce70emr624147eda.75.1658495787983; Fri, 22 Jul
 2022 06:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220721095210.37519-1-horace.chen@amd.com>
 <CADnq5_PoE3m2qic2tqRn8pwgXBFS24u=5gRPpg90qHocqbietQ@mail.gmail.com>
 <BL1PR12MB5061D3195F5AF7BCBF12DA7BE1909@BL1PR12MB5061.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5061D3195F5AF7BCBF12DA7BE1909@BL1PR12MB5061.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Jul 2022 09:16:16 -0400
Message-ID: <CADnq5_POxVAB-Z0CZNC2LJWGgE4frYe0u6Ziove7AUeSAcVEWw@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: add CHIP_IP_DISCOVERY support for
 virtualization
To: "Chen, Horace" <Horace.Chen@amd.com>
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
Cc: "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>, "Xiao,
 Jack" <Jack.Xiao@amd.com>, "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu,
 Feifei" <Feifei.Xu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 21, 2022 at 11:32 PM Chen, Horace <Horace.Chen@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Alex,
>
> By current design, we will keep this register same for all new asics.
> Also, the amdgpu_detect_virtualization will be called before we read the =
IP discovery table (virtualization needs to send a message to host machine =
to request for the IP discovery table preparation). So we can't use any IP =
version to decide the register.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Regards,
> Horace.
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, July 21, 2022 10:37 PM
> To: Chen, Horace <Horace.Chen@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Grodzovsky, Andrey <Andrey.Grodzovsky@=
amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; W=
ang, Yang(Kevin) <KevinYang.Wang@amd.com>; Xiaojie Yuan <xiaojie.yuan@amd.c=
om>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.De=
ucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Koenig, Christian <Christia=
n.Koenig@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zh=
ang@amd.com>
> Subject: Re: [PATCH 1/6] drm/amdgpu: add CHIP_IP_DISCOVERY support for vi=
rtualization
>
> On Thu, Jul 21, 2022 at 5:52 AM Horace Chen <horace.chen@amd.com> wrote:
> >
> > For further chips we will use CHIP_IP_DISCOVERY, so add this support
> > for virtualization
>
> All current and future chips will use CHIP_IP_DISCOVERY.  If we plan to k=
eep the register the same for all new aics, this should be fine.
> If we might need to have it per asic I think you might want something mor=
e like this:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 9be57389301b..0bdd71f9a8fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -709,6 +709,16 @@ void amdgpu_detect_virtualization(struct
> amdgpu_device *adev)
>         case CHIP_ALDEBARAN:
>                 reg =3D RREG32(mmRCC_IOV_FUNC_IDENTIFIER);
>                 break;
> +       case CHIP_IP_DISCOVERY:
> +               switch (adev->ip_versions[GC_HWIP][0]) {
> +               case IP_VERSION(11, 0, 0):
> +                       reg =3D RREG32(mmRCC_IOV_FUNC_IDENTIFIER);
> +                       break;
> +               default:
> +                       reg =3D 0;
> +                       break;
> +               }
> +               break;
>         default: /* other chip doesn't support SRIOV */
>                 reg =3D 0;
>                 break;
>
> Alex
>
> >
> > Signed-off-by: Horace Chen <horace.chen@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > index 7d7044e9de2f..ab55602ff534 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -705,6 +705,7 @@ void amdgpu_detect_virtualization(struct amdgpu_dev=
ice *adev)
> >         case CHIP_SIENNA_CICHLID:
> >         case CHIP_ARCTURUS:
> >         case CHIP_ALDEBARAN:
> > +       case CHIP_IP_DISCOVERY:
> >                 reg =3D RREG32(mmRCC_IOV_FUNC_IDENTIFIER);
> >                 break;
> >         default: /* other chip doesn't support SRIOV */ @@ -748,6
> > +749,7 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
> >                 case CHIP_NAVI10:
> >                 case CHIP_NAVI12:
> >                 case CHIP_SIENNA_CICHLID:
> > +               case CHIP_IP_DISCOVERY:
> >                         nv_set_virt_ops(adev);
> >                         /* try send GPU_INIT_DATA request to host */
> >                         amdgpu_virt_request_init_data(adev);
> > --
> > 2.25.1
> >
