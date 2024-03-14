Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555F3C54E60
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 12:58:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0052F10F94C;
	Thu, 14 Mar 2024 12:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fVfpEzZZ";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E18F10F94C
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 12:58:17 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-5dcc4076c13so620184a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710421096; x=1711025896; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VdWapim5Z8WCSHv4AMff/CftPTA/0At3lxzZWWYaN3g=;
 b=fVfpEzZZCITlPGbKA/NHOMRpOiRsk8BqP3Ef4oi5dBU9FYk/bnJBHX0Gd+8QsuSiFF
 6hV4OmL7VmswT2Q5fziUxDN9bc3EUCxWpzT6hds+uEx6BoB8Di/NNevqP1o9/sjAWD5h
 XiWH8ZmJlf8EavvKjSkJRWyBMFzUaurTcbfB5tAFxR+pGX44olBshCYRK4/6/ncMxy2v
 lrqVkk9d1R84VSA3D7Qq38kx8/D7DJvDutyfCySpxiAzqHH9cUpRMEHSkJrvNLQxWod1
 f72HARRGg1FIskuaoIVzen/2Ag6ZeOqpWHvV/Z1L9yKlVlrlOBruHr64cksYaZwVWR9t
 LV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710421096; x=1711025896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VdWapim5Z8WCSHv4AMff/CftPTA/0At3lxzZWWYaN3g=;
 b=CbDQcc/KcntWjKLuRLPwwoFyLLKLPyqIr0HBjr5lv7Kddin4BIK81B1fbrN+OVNVfF
 85GqUhMnNSjbLUzYdW/pRilWD4/yGWKJjMHp9ooz6W6Z+oDF6wT4LKz6lm6D5N5wTITj
 dxmPubaqs5JimESvPVm73yqz8stmKm7O0X9g+POQ8PFO5OoDxbWrLk16jXTPF9sU04l8
 E4gkvEW2VbBhJstp6miBCK8U8XboJhvfLxo4kWsWAzRLKWC0JxPAdjycsxNVcw6k2N/K
 c1a3upv1QnP4Vkg6NuUEG/sLpUDJPUEYczHf06jzUAsj+Gwhkn9UXI/+6C45P1zKBl1x
 2rlA==
X-Gm-Message-State: AOJu0YxXL6iV401Jw0ocGOI/n1XTUBel42awQzVZOa72bkjzFIjvDOfs
 SFKGwQ/lW79g2QFewWTz5Aw33eLmN9fLpeEv1ftPgZZ7d8Y0f5rfU05AGTKz3iZcn27bFXq5lrO
 eQ1B4PB9Zw7fpx1liMrw2Tnf8rZvLkf2/
X-Google-Smtp-Source: AGHT+IGxYhT8QZBm00AIKDO0JK0mG51ND0qtQWOdZ6SqC79wnTwFVwtzaKFmumGMqHPOxTRUbQqgypsloayrcw4bH5s=
X-Received: by 2002:a17:90a:bf08:b0:29c:6146:6adb with SMTP id
 c8-20020a17090abf0800b0029c61466adbmr2694449pjs.12.1710421096625; Thu, 14 Mar
 2024 05:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240313114451.1592772-1-peytolee@amd.com>
 <CADnq5_OTwaLWJ9LiicJu-hO+WDF6fPB5PFQWzAqopyrDVn6R5Q@mail.gmail.com>
 <MN2PR12MB4373845FF59F1ACC83AAEFC986292@MN2PR12MB4373.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4373845FF59F1ACC83AAEFC986292@MN2PR12MB4373.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 14 Mar 2024 08:58:04 -0400
Message-ID: <CADnq5_MzsCoj0VMKkQecWfGS1UAXE7Xvje3eoNbTP7fbdvXHRQ@mail.gmail.com>
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

On Wed, Mar 13, 2024 at 9:33=E2=80=AFPM Lee, Peyton <Peyton.Lee@amd.com> wr=
ote:
>
> [AMD Official Use Only - General]
>
> Hi Alex,
>
> There are two places where VPE will lose power: When there is a system ca=
ll to vpe_hw_fini(), and the vpe-thread finds that VEP has no jobs in the q=
ueue.
> This patch is to make sure that VPE is power up before loading firmware.

I think it will continue to be powered up until a VPE job comes in and
completes and the idle handler gets scheduled.  If a VPE job doesn't
come in, it will stay powered up I think.

Alex

>
> Thanks,
> Peyton
> -----=E5=8E=9F=E5=A7=8B=E9=83=B5=E4=BB=B6-----
> =E5=AF=84=E4=BB=B6=E8=80=85: Alex Deucher <alexdeucher@gmail.com>
> =E5=AF=84=E4=BB=B6=E6=97=A5=E6=9C=9F: Wednesday, March 13, 2024 9:17 PM
> =E6=94=B6=E4=BB=B6=E8=80=85: Lee, Peyton <Peyton.Lee@amd.com>
> =E5=89=AF=E6=9C=AC: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Al=
exander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>; Ma, Li <Li.M=
a@amd.com>; Yu, Lang <Lang.Yu@amd.com>
> =E4=B8=BB=E6=97=A8: Re: [PATCH] drm/amdgpu/vpe: power on vpe when hw_init
>
> On Wed, Mar 13, 2024 at 7:41=E2=80=AFAM Peyton Lee <peytolee@amd.com> wro=
te:
> >
> > To fix mode2 reset failure.
> > Should power on VPE when hw_init.
>
> When does it get powered down again?  Won't this leave it powered up?
>
> Alex
>
> >
> > Signed-off-by: Peyton Lee <peytolee@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vpe.c
> > index 70c5cc80ecdc..ecfe0f36e83e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> > @@ -396,6 +396,12 @@ static int vpe_hw_init(void *handle)
> >         struct amdgpu_vpe *vpe =3D &adev->vpe;
> >         int ret;
> >
> > +       /* Power on VPE */
> > +       ret =3D amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLO=
CK_TYPE_VPE,
> > +                                                    AMD_PG_STATE_UNGAT=
E);
> > +       if (ret)
> > +               return ret;
> > +
> >         ret =3D vpe_load_microcode(vpe);
> >         if (ret)
> >                 return ret;
> > --
> > 2.34.1
> >
