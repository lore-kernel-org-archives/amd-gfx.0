Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A882C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 12:54:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3160112247;
	Fri, 15 Mar 2024 12:54:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LYJHkhuN";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6285210E079
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 12:54:48 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-5d8b887bb0cso1557463a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 05:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710507287; x=1711112087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFjXCd8bcCsu32n851w/XlW3w6V7D5XNjxnjzZvTlh0=;
 b=LYJHkhuNXeRx+WqEaGOthFJCxgG6ZFmiMy0sPX3BJrboFp4XlP780KClExSVvuNLn/
 IploG9eybtaTYmA39fYTXXvvZsgXTKExWltUg3PivoxOhnmLxr5/Ll6GxDUeoq25WpOP
 81aAeuHa3Bw7Qo2SwzXhoUGXNiFWPB9Q5AKN+MBSaNWy6Yr+sk4Z9Y515hNvEmrPzHRo
 h25QKEoZgso2MorYG+dE3rl8JMzNyARcutqK9PGwOI2id4V26jWogX3pWIX9C8tiBB2P
 +rslYJvGC/hwZUkQsWpQJ/1WZTjHuI6IYcjSURPbavrp1KorIoP+4zVO6CbYUvqV4GSS
 LgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710507287; x=1711112087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFjXCd8bcCsu32n851w/XlW3w6V7D5XNjxnjzZvTlh0=;
 b=UlWVlpw4re0OahbfQs/xlZ1r0ReEEZvpWSKsoasjYqsNQnRMqbsy3WOWN8Lt/8uWUM
 xyR1FPMahK/cR1YsnLPf8WKWb7BdIq34lR1l3YGzEZJGgXIOAWDQ1OkUWUd2dEHQLlib
 JXk2/ZY6Ct77Rp6i2OpUsTP3uk2tRwyg6Wi6QN9Ee0+ZW/7Ni+Uolh8035Q2XAlX9fXD
 CJbL7QG4KTvfFwZbWKOM4UkNT9o68uDr2p9TtYgIMX5LzQAchLBZGbC/VjvwX/8Mn2Ux
 3bQWLYjnRp4woS3LI9rmqdKBatr9RWmGKelk9woww2foum4JeF2Lm568L7xumf2HfDFG
 wGuw==
X-Gm-Message-State: AOJu0Yyrgs4KjzER9rDE3CVJupL9xq7ZDVNpm5PtJ1+VUG9dR8LLDYaf
 QuQsa/3LhcsQBc6lllwT/ewiZX8Vfg7/J6btNFOV49qs5smDlzWaYKxDVeoCOhHwMSJ220oiU8w
 a5ZYLCnxx4SaMJef/8T7SMF7K9B/Ns6/o
X-Google-Smtp-Source: AGHT+IE8x9tMM420CsY3tlV+7uVLeCBftYFlaITBiuzY3A4e814of0YA+lv5crn/P3+Gix0tfe7unttMVpy+2yQYFxw=
X-Received: by 2002:a17:90a:ee93:b0:29b:acc6:c54f with SMTP id
 i19-20020a17090aee9300b0029bacc6c54fmr4517214pjz.35.1710507287365; Fri, 15
 Mar 2024 05:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240313114451.1592772-1-peytolee@amd.com>
 <CADnq5_OTwaLWJ9LiicJu-hO+WDF6fPB5PFQWzAqopyrDVn6R5Q@mail.gmail.com>
 <MN2PR12MB4373845FF59F1ACC83AAEFC986292@MN2PR12MB4373.namprd12.prod.outlook.com>
 <CADnq5_MzsCoj0VMKkQecWfGS1UAXE7Xvje3eoNbTP7fbdvXHRQ@mail.gmail.com>
 <MN2PR12MB437320223A607D4BAA8C182586282@MN2PR12MB4373.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB437320223A607D4BAA8C182586282@MN2PR12MB4373.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Mar 2024 08:54:35 -0400
Message-ID: <CADnq5_NciR_1wqRCSYTJ+nUsYbfGiEBJtt3cwzyvREODGkywWw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vpe: power on vpe when hw_init
To: "Lee, Peyton" <Peyton.Lee@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Yifan" <Yifan1.Zhang@amd.com>, 
 "Ma, Li" <Li.Ma@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>
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

On Thu, Mar 14, 2024 at 9:40=E2=80=AFPM Lee, Peyton <Peyton.Lee@amd.com> wr=
ote:
>
> [AMD Official Use Only - General]
>
> Hi Alex
>
> > I think it will continue to be powered up until a VPE job comes in and =
completes and the idle handler gets scheduled.  If a VPE job doesn't come i=
n, it will stay powered up I think.
> Yes, correct.
> And after the VPE is called to do initialization, a simple test is execut=
ed for checking VPE status, and the idle handler gets scheduled to power of=
f the VPE when the test finished.

Does the IB test take care of this?  I just want to confirm that we
aren't leaving it powered up unless a user runs a VPE workload which
might not happen.

Alex


>
> Thanks,
> Peyton
>
> -----=E5=8E=9F=E5=A7=8B=E9=83=B5=E4=BB=B6-----
> =E5=AF=84=E4=BB=B6=E8=80=85: Alex Deucher <alexdeucher@gmail.com>
> =E5=AF=84=E4=BB=B6=E6=97=A5=E6=9C=9F: Thursday, March 14, 2024 8:58 PM
> =E6=94=B6=E4=BB=B6=E8=80=85: Lee, Peyton <Peyton.Lee@amd.com>
> =E5=89=AF=E6=9C=AC: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Al=
exander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Ma, Li <Li.M=
a@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> =E4=B8=BB=E6=97=A8: Re: [PATCH] drm/amdgpu/vpe: power on vpe when hw_init
>
> On Wed, Mar 13, 2024 at 9:33=E2=80=AFPM Lee, Peyton <Peyton.Lee@amd.com> =
wrote:
> >
> > [AMD Official Use Only - General]
> >
> > Hi Alex,
> >
> > There are two places where VPE will lose power: When there is a system =
call to vpe_hw_fini(), and the vpe-thread finds that VEP has no jobs in the=
 queue.
> > This patch is to make sure that VPE is power up before loading firmware=
.
>
> I think it will continue to be powered up until a VPE job comes in and co=
mpletes and the idle handler gets scheduled.  If a VPE job doesn't come in,=
 it will stay powered up I think.
>
> Alex
>
> >
> > Thanks,
> > Peyton
> > -----=E5=8E=9F=E5=A7=8B=E9=83=B5=E4=BB=B6-----
> > =E5=AF=84=E4=BB=B6=E8=80=85: Alex Deucher <alexdeucher@gmail.com>
> > =E5=AF=84=E4=BB=B6=E6=97=A5=E6=9C=9F: Wednesday, March 13, 2024 9:17 PM
> > =E6=94=B6=E4=BB=B6=E8=80=85: Lee, Peyton <Peyton.Lee@amd.com>
> > =E5=89=AF=E6=9C=AC: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Ma,
> > Li <Li.Ma@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> > =E4=B8=BB=E6=97=A8: Re: [PATCH] drm/amdgpu/vpe: power on vpe when hw_in=
it
> >
> > On Wed, Mar 13, 2024 at 7:41=E2=80=AFAM Peyton Lee <peytolee@amd.com> w=
rote:
> > >
> > > To fix mode2 reset failure.
> > > Should power on VPE when hw_init.
> >
> > When does it get powered down again?  Won't this leave it powered up?
> >
> > Alex
> >
> > >
> > > Signed-off-by: Peyton Lee <peytolee@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> > > index 70c5cc80ecdc..ecfe0f36e83e 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> > > @@ -396,6 +396,12 @@ static int vpe_hw_init(void *handle)
> > >         struct amdgpu_vpe *vpe =3D &adev->vpe;
> > >         int ret;
> > >
> > > +       /* Power on VPE */
> > > +       ret =3D amdgpu_device_ip_set_powergating_state(adev, AMD_IP_B=
LOCK_TYPE_VPE,
> > > +                                                    AMD_PG_STATE_UNG=
ATE);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > >         ret =3D vpe_load_microcode(vpe);
> > >         if (ret)
> > >                 return ret;
> > > --
> > > 2.34.1
> > >
