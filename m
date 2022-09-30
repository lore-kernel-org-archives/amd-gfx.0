Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A8DC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Sep 2022 13:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19DE310ED0E;
	Fri, 30 Sep 2022 13:56:36 +0000 (UTC)
X-Greylist: delayed 69186 seconds by postgrey-1.36 at gabe;
 Fri, 30 Sep 2022 13:56:31 UTC
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F19FF10ED0C;
 Fri, 30 Sep 2022 13:56:31 +0000 (UTC)
Date: Fri, 30 Sep 2022 13:56:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1664546189; x=1664805389;
 bh=cu9NzPYuwmV2LIQD2ELCv5fVgsv89UQlLcoBUaRxZe8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID;
 b=EtZ7omISzDbfLkz7bbJG8BVd2rA0vTnI3D/5DXcTAqNTc3h3IIOQnoMbYYqLYGqNT
 ktCeN0X5gfedCjc5M6WCgnhrjUJVHGGZI6zJZgr03kVbWpaV6UyabmlLfr4F1rtNCA
 yT3XNd9P6+jl5U/k8IoKT/K36zDFoFqO77sXBedrD2vBQWJcFGnSxOhMsVedXXilIA
 WCirneUv8x8TLEmp93WV/IP99qM2oSOX7VjtKoSVbk5Yv30lSdzmsQw4tvosmBtmNr
 pXo2lTsJiF8iGsBVS8DXAoCtz9TxAAX1bd7NGRIooznSOYfmaH9iTZMCdJ8LnADXMK
 WVD5bcGBVhMIA==
To: =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v3 3/6] drm: introduce
 drm_mode_config.atomic_async_page_flip_not_supported
Message-ID: <TIyTbXwbugAMrWLflS6c6MSMb8Nfv0n3kzxZS8XYDPW2KhtzVxazMJUQPRdq0c7BUNLAaT125oFiZYCTIT-tF5QVCnKxffLfGYOMBCBpQWQ=@emersion.fr>
In-Reply-To: <Yzb0xhcvwnWg4iY6@intel.com>
References: <20220929184307.258331-1-contact@emersion.fr>
 <20220929184307.258331-4-contact@emersion.fr> <Yzb0xhcvwnWg4iY6@intel.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: andrealmeid@igalia.com, daniel.vetter@ffwll.ch,
 amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 mwen@igalia.com, dri-devel@lists.freedesktop.org, alexander.deucher@amd.com,
 hwentlan@amd.com, nicholas.kazlauskas@amd.com, joshua@froggi.es
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Friday, September 30th, 2022 at 15:53, Ville Syrj=C3=A4l=C3=A4 <ville.sy=
rjala@linux.intel.com> wrote:

> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/driver=
s/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 44235345fd57..7500e82cf06a 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -3808,6 +3808,7 @@ static int amdgpu_dm_mode_config_init(struct amdg=
pu_device *adev)
> >  =09=09adev_to_drm(adev)->mode_config.prefer_shadow =3D 1;
> >  =09/* indicates support for immediate flip */
> >  =09adev_to_drm(adev)->mode_config.async_page_flip =3D true;
> > +=09adev_to_drm(adev)->mode_config.atomic_async_page_flip_not_supported=
 =3D true;
>=20
> The flag polarity seems weird. Why opt out and not opt in?

Explained in the commit message.
