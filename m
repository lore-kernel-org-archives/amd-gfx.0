Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DC5C282EC
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 23:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4AA810E0E3;
	Wed,  5 Mar 2025 23:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B8A2R9Io";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8693910E0D7
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 23:04:24 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ff66327419so20684a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Mar 2025 15:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741215864; x=1741820664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tio3otTwBhOXQlB4nV0gvDLfBXAdS1m8rtmQ9EGScVo=;
 b=B8A2R9IoFKSoiPfJFT97el99FQfSgS9WSpKu+7ZCz50nKeSfhvIr4LgcJr/a/Gc67O
 bxXOPUW8jlK0O4ZJeilW8NZpn6XDiq5DI7CmQ5pnWu3u0Uenl2PEbu2RCQMba3HaDSuz
 PxZp8eSQCF4dLcM2IkavBvudJNn8y52N33e/TytiEp+YyS1QYrKUxcKbA0ogVLP3J3Sf
 B0AhI7Kkn5AsSWUrleIYdmU5oI0xeHiUap6CkapqJynhBFCUEJJSxy/JX2MJKgaZ93/T
 uRuT1TE9+SQH7gNpFQgAfrCgJ9qKEr4OzRI5Ou3BeP40aqZ7NjbJBNiXfVYJzmDFTtL4
 gPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741215864; x=1741820664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tio3otTwBhOXQlB4nV0gvDLfBXAdS1m8rtmQ9EGScVo=;
 b=W7tTdvxevFfBNSBuhrA/40d32xwJq0mhsHjOxD+4FCx7CtZjYlq6DsagWXs6u/6jVk
 tcfi+U5ujQNZn1JtWnHLqkJgQiVw05zlIw2CRlhwMfbGuuqfCZr3z5b3m6AdvcRujqCC
 lp4bQ/HTqrsCyu4uqOxPfDn0EiD/c79HtcPiohXvBH5LhJLnb2/DE4732vurZrRKOg5h
 dpzi2/7eU8Ok3HNTnxPxbB6ubK/xdnAx1yKydGzbSQ3w6CNlTqpjYwwfvP5rejA8G/m4
 r6LrgSU2XWH8+Q8fAf6sAky19xzhWG7VHvklOFc3Xqm6LzXrsSKZyiRwUiWhom/ElMFA
 rDLw==
X-Gm-Message-State: AOJu0YweDRRcPpAfdE5nX5SpMOG/V23jCrRh4Mxj9ed4jZD8MeprktZS
 ECSECZl+MbqLwy6tqvSEtY+v0oWf6t4Tb9h8KUkm6O6zVSzb2BJUJjAaghHSo1klNkj2V+6Kbbw
 uV9UbAsI0ZDFpwYIwVMB6WRQLnbG2TCDy
X-Gm-Gg: ASbGncu8cGzDgbknj9jAyHou82ZOs4Irq+McJhlMPAys8JUGoT1x3VdrsLTZhtZX1RY
 qMCmypp3122ExcFTxmtdanrcA8lXcF4KESaP3L22765so23Eus3RyDm/iHOYZOZB0L+fB4cV0tX
 v+iK+9UlTlTFBqh/xdNcL/gY31ow==
X-Google-Smtp-Source: AGHT+IH7VhUNEmr0pu7ctr99N0CnS8AgiHUdViIBIKvl20hy0sahExcjG5PDBC0H/qp7igi14uTJV4MlyZPN6Nkd6pk=
X-Received: by 2002:a17:90b:17d0:b0:2fb:f9de:9497 with SMTP id
 98e67ed59e1d1-2ff498223fdmr3306927a91.5.1741215863742; Wed, 05 Mar 2025
 15:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20250305213742.13559-1-mario.limonciello@amd.com>
 <5f8f95a9-ca19-4d28-82fc-7445e2be24ba@amd.com>
In-Reply-To: <5f8f95a9-ca19-4d28-82fc-7445e2be24ba@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Mar 2025 18:04:10 -0500
X-Gm-Features: AQ5f1JqCVSbIxFnpY_JDSiATg145bXOQydm_I2o5qjKdYy0B8DXaMvNjXoUlXMo
Message-ID: <CADnq5_P-i0TJ35Q6EEbT6994=BH2tjE5Fj_236rfK6wn8OXDFQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fail initialization earlier when DC is disabled
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Wed, Mar 5, 2025 at 4:53=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 3/5/2025 15:37, Mario Limonciello wrote:
> > Modern APU and dGPU require DC support to be able to light up the
> > display.  If DC support has been disabled either by kernel config
> > or by kernel command line fail init early so that the system won't
> > freeze with a lack of display.
> >
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 24 +++++++++++++++---=
-
> >   1 file changed, 19 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index a4258127083d..c4e1505dcaac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -2139,10 +2139,6 @@ static int amdgpu_discovery_set_display_ip_block=
s(struct amdgpu_device *adev)
> >               return 0;
> >       }
> >
> > -     if (!amdgpu_device_has_dc_support(adev))
> > -             return 0;
> > -
> > -#if defined(CONFIG_DRM_AMD_DC)
> >       if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> >               switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
> >               case IP_VERSION(1, 0, 0):
> > @@ -2166,15 +2162,24 @@ static int amdgpu_discovery_set_display_ip_bloc=
ks(struct amdgpu_device *adev)
> >               case IP_VERSION(3, 5, 1):
> >               case IP_VERSION(3, 6, 0):
> >               case IP_VERSION(4, 1, 0):
> > +                     if (!amdgpu_device_has_dc_support(adev)) {
> > +                             dev_err(adev->dev,
> > +                                     "DC support is required for dm ip=
 block(DCE_HWIP:0x%x)\n",
> > +                                     amdgpu_ip_version(adev, DCE_HWIP,=
 0));
> > +                             return -EINVAL;
> > +                     }
> > +
> >                       /* TODO: Fix IP version. DC code expects version =
4.0.1 */
> >                       if (adev->ip_versions[DCE_HWIP][0] =3D=3D IP_VERS=
ION(4, 1, 0))
> >                               adev->ip_versions[DCE_HWIP][0] =3D IP_VER=
SION(4, 0, 1);
> >
> > +#if defined(CONFIG_DRM_AMD_DC)
> >                       if (amdgpu_sriov_vf(adev))
> >                               amdgpu_discovery_set_sriov_display(adev);
> >                       else
> >                               amdgpu_device_ip_block_add(adev, &dm_ip_b=
lock);
> >                       break;
> > +#endif
> >               default:
>
> Looking closer at this failure path I *think* this patch will cause
> issues on GPU without DC support.
>
> In the 'default' case now I think it should do something like this:
>
> if (amdgpu_device_has_dc_support(adev))
>         //existing error flow
> else
>         return 0;
>
> Agree?

I think it would be better to just dump a warning in the log if the
board supports displays but CONFIG_DRM_AMD_DC=3Dn rather than failing to
initialize the driver.  The end result is pretty much the same and it
wouldn't break users that want this scenario for some reason.

Alex

>
> >                       dev_err(adev->dev,
> >                               "Failed to add dm ip block(DCE_HWIP:0x%x)=
\n",
> > @@ -2186,11 +2191,21 @@ static int amdgpu_discovery_set_display_ip_bloc=
ks(struct amdgpu_device *adev)
> >               case IP_VERSION(12, 0, 0):
> >               case IP_VERSION(12, 0, 1):
> >               case IP_VERSION(12, 1, 0):
> > +
> > +             if (!amdgpu_device_has_dc_support(adev)) {
> > +                     dev_err(adev->dev,
> > +                             "DC support is required for dm ip block(D=
CI_HWIP:0x%x)\n",
> > +                             amdgpu_ip_version(adev, DCI_HWIP, 0));
> > +                     return -EINVAL;
> > +             }
> > +
> > +#if defined(CONFIG_DRM_AMD_DC)
> >                       if (amdgpu_sriov_vf(adev))
> >                               amdgpu_discovery_set_sriov_display(adev);
> >                       else
> >                               amdgpu_device_ip_block_add(adev, &dm_ip_b=
lock);
> >                       break;
> > +#endif
> >               default:
> >                       dev_err(adev->dev,
> >                               "Failed to add dm ip block(DCI_HWIP:0x%x)=
\n",
> > @@ -2198,7 +2213,6 @@ static int amdgpu_discovery_set_display_ip_blocks=
(struct amdgpu_device *adev)
> >                       return -EINVAL;
> >               }
> >       }
> > -#endif
> >       return 0;
> >   }
> >
>
