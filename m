Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3B1CA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 19:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD4E510E7EA;
	Tue,  9 Sep 2025 19:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j+dFUaXS";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB19E10E7EA
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 19:42:08 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-77253037b5eso500946b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757446928; x=1758051728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tt1nbhrV7qE0kEW//BEgpwej7R5la/lL9STfDHdXKI4=;
 b=j+dFUaXS/xu/Jfmj+mPKS/aTZqDMAthHt2VilvWAoQluaHpbLlIdJOaZtLoNcGPW6J
 X7t8YtIOO5t/TeGNu378MnUfxbqy4G6sppVDOCozjRRWuutidJhXkL+FuSkVjRLxqcIj
 gT2lBOhxNvkOJeXfGHxwa9R/aCQTH0k9Jy5bUlCM13d7ZiICi+TFwF1C3VYpMsWub8ky
 961ePu22SfzzEbxKJKzJzg5XgjDYFEIB2a4P302PqZQjaYFURXlq/SdrmWrK/QjjrYl6
 /2pbbY5bNBT+HRIzaOYottmsUBIRAS7iGFsTwAMdIGAUnlILyMhOlritQ+yGh8u2imY/
 FdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757446928; x=1758051728;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tt1nbhrV7qE0kEW//BEgpwej7R5la/lL9STfDHdXKI4=;
 b=ukcpyPeo+G9R1eDldTz/pxLE90pSBJdnr1j7ZYHJ0j16HxPvXyMamOAKh3gIL4ZnQk
 PQCCjb/n1H0nB0yV90WBk2SEls94+PInjzxDvnRC+9vZjhl5AXH5EO3WDesxFYPT0Jvp
 ERSpOk6Tv+aTfnj+q+5JaH4DTCWHWxqeAij14K1wIGYMrGjji6lZE7dy7jmHfGs0QVyK
 AmPro5ueKRf5yTUYioroO0KPhb2KAZo1K9xenjbjat26F/QXiwqN0Pe5wS02ONkvy9Kw
 ArKyspe0Fjkz4u7ktBq/2X9/7eGFwopV7TDfG5yNnYzB6Zyqef7q60FYE+ZWRRwihte3
 X1Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYZQx276GZ0mYSfzQ/Nx4AOhtY16KcrlSIEKZLuMNXfW6fcIOx7EqiMfGFzaSg3A7Hz92KjcjW@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywn23HwFIuNtKbN3/ZrGTYot+0zsAWCaOiNMzHlUHQ7O1cE4LU1
 yVVumoGxNYSTF7mXesV/CovIpQHiOz/4Gp3bZwtxikK9cMuOW1/g0zjk9vacFE3nbUwhJnEnoGo
 ETO4n+JK9Dv9tsyJYdLXSzVYGeuwsBqQ=
X-Gm-Gg: ASbGnctXQuuFdz/9pqdTfyIidkxhgdoMvYYrIefItqGuFdOwnQlmORwI3VuwrqHqvpn
 wpVDSg2gWzdaJNb0Ec3gk0NVKy10Ej+hagabU/hIaJHkBYhCJK9FDMIccLPdEGEDEXJ5xUna4kv
 VQcs6BHiv6/mMf40bdizkz9Tpq3GdKAYzvrPjAnstYcx3zdy+ODZ/v0cXWQTq0b5NnNmNlT+xDe
 PBMvJ4=
X-Google-Smtp-Source: AGHT+IGuqwZUuYGG1g6HtaFsCIhKncvH6h4aKdjJ/S30VeBFhwA1eqMmpcLVB9SJVrzo5nQs97BbxOM1Dy3jHKAvkeU=
X-Received: by 2002:a17:902:ea03:b0:24c:b69d:5929 with SMTP id
 d9443c01a7336-2516da048f8mr98203935ad.2.1757446928256; Tue, 09 Sep 2025
 12:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250908204207.8397-1-stefan.silviu.alexandru@gmail.com>
 <BL1PR12MB51442BF8FBDCE9F4A23C21D0F70CA@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CAB7_Ay8KKxn_unO6RiLKn=ZPrFoapHkMQjUWO6+_o0FjTkLy3A@mail.gmail.com>
In-Reply-To: <CAB7_Ay8KKxn_unO6RiLKn=ZPrFoapHkMQjUWO6+_o0FjTkLy3A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 15:41:56 -0400
X-Gm-Features: Ac12FXz4-uma-zy0NSQjL2xa4_VaF5sjHeChDS32l_yfH88CrzdNg-00lXvK0Q4
Message-ID: <CADnq5_PyD=_wv+kOSQ5FoyLU=YLhW3tRLc4_MX3uvM-qgim+YA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Register DP aux only if used
To: Silviu-Alexandru Stefan <stefan.silviu.alexandru@gmail.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
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

On Tue, Sep 9, 2025 at 1:39=E2=80=AFPM Silviu-Alexandru Stefan
<stefan.silviu.alexandru@gmail.com> wrote:
>
> On Tue, 9 Sept 2025 at 00:16, Deucher, Alexander
> <Alexander.Deucher@amd.com> wrote:
> >
> > [Public]
> >
> > > -----Original Message-----
> > > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Si=
lviu-
> > > Alexandru =C8=98tefan
> > > Sent: Monday, September 8, 2025 4:42 PM
> > > To: amd-gfx@lists.freedesktop.org
> > > Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > > <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Silviu-
> > > Alexandru =C8=98tefan <stefan.silviu.alexandru@gmail.com>
> > > Subject: [PATCH] drm/amd/display: Register DP aux only if used
> > >
> > > The aux channel is always registered if the connector is DP, even whe=
n the link
> > > doesn't contain DP. When using the DisplayPort connector in DP++ mode=
, the I2C
> > > is done directly over the pins, not over an aux channel. The practica=
l effect is the
> > > creation of
> > > 2 I2C devices for DDC, one from the actual pins, and another from the=
 aux channel.
> > >
> > > This generates duplicate results from tools like ddcutil, for example=
 using a cheap
> > > passive DP-to-DVI cable:
> > >
> > > Display 1
> > >    I2C bus:  /dev/i2c-3
> > >    DRM_connector:           card1-DP-1
> > > ...
> > > Display 3
> > >    I2C bus:  /dev/i2c-7
> > >    DRM_connector:           card1-DP-1
> > > ...
> > >
> > > The "real" bus is i2c-3, while the aux i2c-7 doesn't work.
> > >
> > > Any read on the aux channel succeeds, but always returns an all-zero =
buffer,
> > > further confusing ddcutil which just says "Maximum retries exceeded",=
 even if it will
> > > never work.
> > >
> > > The dc_link->aux_mode is true if the link actually intends to use aux=
 for DDC I2C,
> > > so skip registering aux unless the link is actually in aux mode.
> >
> > I don't think you can skip this otherwise you'll never have the other b=
us.  E.g., if you unplug the DP++ monitor and then plug in a DP monitor, th=
e aux bus won't exist and then you'll have the opposite problem.
>
> Hello,
>
> Thanks for the review. You're right, the bus doesn't come back if I
> switch around my monitors, I should have thought of that. I was
> thinking the extra bus has to be wrong because other things only show
> up in /dev if something is actually there, but I guess that isn't
> necessarily correct here.
>
> > You just need to use the right one based on what monitor is attached.  =
In general, userspace shouldn't be messing with the i2c buses in the first =
place.  If you need access to the EDIDs, the drm provides access to them.
>
> I want to change input source and/or brightness for 2 monitors with a
> script, so it's more about commands over DDC than EDID. I see there is
> a symlink "/sys/class/drm/card1-DP-1/ddc", but that has the opposite
> issue as it always points to the non-aux i2c (good for DP++, bad for
> normal DP).
>
> Would it make sense to at least update the ddc symlink when the DP
> link changes? That way it would always point at the actual i2c being
> used for DDC, aux or not.
> Or should I leave it like this and figure out in userspace which bus to u=
se?

I'm not sure how the symlink is managed.  If that can be handled
dynamically that would be ok I think.

Another option would be to only expose a single i2c bus for each
physical connector and then internally the driver would use either the
legacy i2c pins or the aux bus depending on what was connected.  That
would prevent use of both buses independently however and it would
make it impossible to use different i2c devices independently for each
internal bus.

Alex

>
> Thanks,
> Silviu
>
>
>
> >
> > Alex
> > >
> > > i2cdetect -y 3:
> > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > 00:                         -- -- -- -- -- -- -- --
> > > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 30: -- -- -- -- -- -- -- 37 -- -- 3a -- -- -- -- --
> > > 40: 40 41 -- -- -- -- -- -- -- 49 -- -- -- -- -- --
> > > 50: 50 -- -- -- -- -- -- -- -- 59 -- -- -- -- -- --
> > > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 70: -- -- -- -- -- -- -- --
> > >
> > > i2cdetect -y 7:
> > >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > > 00:                         -- -- -- -- -- -- -- --
> > > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > > 70: -- -- -- -- -- -- -- --
> > >
> > > Signed-off-by: Silviu-Alexandru =C8=98tefan <stefan.silviu.alexandru@=
gmail.com>
> > > ---
> > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++--
> > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > index fadc6098eae..1759071e02a 100644
> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > @@ -7429,6 +7429,16 @@ amdgpu_dm_connector_atomic_duplicate_state(str=
uct
> > > drm_connector *connector)
> > >       return &new_state->base;
> > >  }
> > >
> > > +static inline bool amdgpu_dm_should_register_dp_aux(
> > > +     struct amdgpu_dm_connector *amdgpu_dm_connector) {
> > > +     int connector_type =3D amdgpu_dm_connector->base.connector_type=
;
> > > +
> > > +     return ((connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort) =
||
> > > +             (connector_type =3D=3D DRM_MODE_CONNECTOR_eDP)) &&
> > > +            amdgpu_dm_connector->dc_link->aux_mode;
> > > +}
> > > +
> > >  static int
> > >  amdgpu_dm_connector_late_register(struct drm_connector *connector)  =
{ @@ -
> > > 7445,8 +7455,7 @@ amdgpu_dm_connector_late_register(struct drm_connec=
tor
> > > *connector)
> > >
> > >       amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
> > >
> > > -     if ((connector->connector_type =3D=3D
> > > DRM_MODE_CONNECTOR_DisplayPort) ||
> > > -         (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP)) =
{
> > > +     if (amdgpu_dm_should_register_dp_aux(amdgpu_dm_connector)) {
> > >               amdgpu_dm_connector->dm_dp_aux.aux.dev =3D connector->k=
dev;
> > >               r =3D drm_dp_aux_register(&amdgpu_dm_connector-
> > > >dm_dp_aux.aux);
> > >               if (r)
> > >
> > > base-commit: 837f3abbfebdb355ed049c2b06b54108e2bbdf35
> > > --
> > > 2.51.0
> >
