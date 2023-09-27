Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E6FE7F14F
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 13:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 738DA10E50D;
	Wed, 27 Sep 2023 13:13:33 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE9F10E50D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 13:13:32 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1dd5b98d9aeso2265906fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 06:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695820411; x=1696425211; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nK6CQRh71E3xSN91ct0AbhMnuM48H6fOU5TevpSYH9E=;
 b=IAgj5IK17FVGW040V3IELBJiFvcdppLmNt5mN77sCcnzXUoVVjJ3AUjcunrvPCKB/p
 go5vOp4m/15DkFb5HYNkbPWBVIsjVIWp6g7pR3+F25BevYXSK4CwgjMrstGY+DHkrT6J
 K1VU3PFcEAasCGKdadw46gSDxT94WUxD0O7ATkf1awBUh4BD53WLICrxuNO/pkn10rWW
 79bywn7ybLzGNIk/aXl+AQh7oQvkGgpndR+3tiLHWeTpwDxL7hi0icQedxt+dsJwhnwv
 +mew/Zl4MzMo1hU67Dqb1qxI3tX45DKX17JycUU/h8yVRhs3fchsclsVE/pJK2TkfGJp
 8+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695820411; x=1696425211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nK6CQRh71E3xSN91ct0AbhMnuM48H6fOU5TevpSYH9E=;
 b=LHJQ4qnGiFpLRX3c6+Xxmi3DQCDkst83HcEMTKbyoMMPDijLtb1V+qd8gKJiqbMeYE
 HN9DXq1paM+y1YV5zAPkK5kTBsdov8ANCMgMbcBMbjhw6yGbcXw3h494NXlT/lOUgCqS
 RzKHHLq9ya9dstDhV8iCxJARHjB6eN2ELpw0zgObif0aONxIQ1ZDCvZXRAjgiEWg+cW2
 9u8qXWtWcYb3gYJI3qgJtI9VinMVdbfJYWY4744IdA9I4op0ybk7cZtnzdbopR9m5C5o
 jEfC3ZSDWTDQ8tZ4l1tbULfF2w3mpS7CJtr6eryeBE+uukGF28kgh7JaO8nQz8GW2E57
 /R0Q==
X-Gm-Message-State: AOJu0Yy9rQ9534MA79+tnVJrdCoN7nNG18SURN5fsCXqSxao3H9/roFx
 WeyRwmsagSOoXHcDSTQvyG61Sexza3X3iFgQkTw=
X-Google-Smtp-Source: AGHT+IE3P2s6tkNPtycwp0NLhx978W9UN7xsmEQ5VyEMP5uo3NRuLdxSwqjQ7sfNdfpsqD1LnLe0ra9BN2cOdqSmyC0=
X-Received: by 2002:a05:6870:e990:b0:1d6:5f77:5127 with SMTP id
 r16-20020a056870e99000b001d65f775127mr3686003oao.5.1695820411506; Wed, 27 Sep
 2023 06:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230927054143.2169903-1-yifan1.zhang@amd.com>
 <5a02f9df-a198-600b-f413-79b60d2a2561@amd.com>
In-Reply-To: <5a02f9df-a198-600b-f413-79b60d2a2561@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Sep 2023 09:13:20 -0400
Message-ID: <CADnq5_PD3n9Wmuf8ep8g50E3PZDQLsk-OWw=3eoZQn10W=RKGw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: enable S/G display for for recent APUs
 by default
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Harry.Wentland@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 27, 2023 at 8:26=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 27.09.23 um 07:41 schrieb Yifan Zhang:
> > With S/G display becomes stable, enable S/G display for recent APUs
> > by default rather than white list.
> >
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> > ---
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 43 +++++-------------=
-
> >   1 file changed, 10 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 7e6a693d6369..241fd8defdee 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -1626,41 +1626,18 @@ static int amdgpu_dm_init(struct amdgpu_device =
*adev)
> >               break;
> >       }
> >
> > -     switch (adev->asic_type) {
> > -     case CHIP_CARRIZO:
> > -     case CHIP_STONEY:
> > +     if ((adev->asic_type =3D=3D CHIP_CARRIZO ||
> > +             adev->asic_type =3D=3D CHIP_STONEY ||
> > +             ((adev->flags & AMD_IS_APU) &&
> > +             amdgpu_ip_version(adev, DCE_HWIP, 0) >=3D IP_VERSION(1, 0=
, 0) &&
> > +             !(adev->apu_flags & AMD_APU_IS_RAVEN))) &&
> > +             amdgpu_sg_display !=3D 0) {
>
> Looks like a good idea to me, but please double check your coding style
> settings. The second line of an "if (" should be indented so that it
> starts after the "(" of the previous line.
>
> Additional to that this check actually looks quite messy to me and
> should probably be converted to always using the IP version instead of
> the asic_type.

Or just explicitly disable it on the handful or pre-CZ chips that
don't actually support it.
E.g.,

switch (asic_type) {
case CHIP_KAVERI:
case CHIP_KABINI:
case CHIP_MULLINS:
   vm =3D false;
   break;
case CHIP_RAVEN:
   if (apu_flags & AMD_APU_IS_RAVEN)
       vm =3D false;
   else
       vm =3D amdgpu_sg_display !=3D 0;
   break;
default:
   vm =3D (amdgpu_sg_display !=3D 0) && (flags && AMD_IS_APU);
   break;

}

>
> Regards,
> Christian.
>
> >               init_data.flags.gpu_vm_support =3D true;
> > -             break;
> > -     default:
> > -             switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> > -             case IP_VERSION(1, 0, 0):
> > -             case IP_VERSION(1, 0, 1):
> > -                     /* enable S/G on PCO and RV2 */
> > -                     if ((adev->apu_flags & AMD_APU_IS_RAVEN2) ||
> > -                         (adev->apu_flags & AMD_APU_IS_PICASSO))
> > -                             init_data.flags.gpu_vm_support =3D true;
> > -                     break;
> > -             case IP_VERSION(2, 1, 0):
> > -             case IP_VERSION(3, 0, 1):
> > -             case IP_VERSION(3, 1, 2):
> > -             case IP_VERSION(3, 1, 3):
> > -             case IP_VERSION(3, 1, 4):
> > -             case IP_VERSION(3, 1, 5):
> > -             case IP_VERSION(3, 1, 6):
> > -             case IP_VERSION(3, 5, 0):
> > -                     init_data.flags.gpu_vm_support =3D true;
> > -                     break;
> > -             default:
> > -                     break;
> > -             }
> > -             break;
> > -     }
> > -     if (init_data.flags.gpu_vm_support &&
> > -         (amdgpu_sg_display =3D=3D 0))
> > -             init_data.flags.gpu_vm_support =3D false;
> > -
> > -     if (init_data.flags.gpu_vm_support)
> >               adev->mode_info.gpu_vm_support =3D true;
> > +     } else {
> > +             init_data.flags.gpu_vm_support =3D false;
> > +             adev->mode_info.gpu_vm_support =3D false;
> > +     }
> >
> >       if (amdgpu_dc_feature_mask & DC_FBC_MASK)
> >               init_data.flags.fbc_support =3D true;
>
