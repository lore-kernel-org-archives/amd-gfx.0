Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B8BCA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 17:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1F5010E339;
	Tue,  9 Sep 2025 17:29:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hg6MDznB";
	dkim-atps=neutral
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com
 [209.85.166.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FF3A10E339
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 17:29:23 +0000 (UTC)
Received: by mail-io1-f47.google.com with SMTP id
 ca18e2360f4ac-88776dcac7aso79738439f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 10:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757438962; x=1758043762; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzyBvEbnGSsmWqqSlXPhLWziMqXa3vJ5VhXcSuRHhP4=;
 b=hg6MDznBdyvZBQ5Tqotv5Z7rCEtJFBuq7KNmg42gB71Qq0u12wPkLZWkcDrx/nP6Pb
 RXX4mTmGnsm44YX5hlhP+PwuffyxJA25K3wkiHViETDXKeUU8Kzq+nBr2RFCFz17LUxs
 PSmVmM0iADHU3jTuGuaPfJYMYWMnzE0y8YY9Sva599NZlMPuTmTLlnmlCKTr9LFOcgct
 AntPZR/kSFePnwpm0de/avNx8AzuNpaP4KqSdNpIeTttdsHURszLw9V5vcNLVP8AOSV+
 lpF7JNLMEJ8Me7O1hFWpsrH32guAdNIsbxz/KwEnaOz1vXwlixPgo3muxHvCPoYJd579
 VURw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757438962; x=1758043762;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rzyBvEbnGSsmWqqSlXPhLWziMqXa3vJ5VhXcSuRHhP4=;
 b=Ki+FrvLU7E7FnhKG2hV6ITDSj6uZRGrJDcqMWrupbPDx91EK5FuZYNl3tqwlsykdWu
 czSDgKtZznRwyoYQnZvSfdzn4jEVoZAePLIpCk6OLC9e0t+4u4W2kAhq69Lc+OZ+L6pt
 aXxjVOG2s8RlbZ/6YeaS/y5BcioZd9KJ24Iqxz45gKCeaRBb9xv1WX9DyvqMhZNLCSFO
 9Dx0DqgI24bvr00/w80x1jGvt/VZMlnKE5n2rZsDlKKQkdpetSgcjmoixfm9dCj27X0Z
 IPK9JOW8b1L7vyTnXJc8wwAsQjyNWofyz7VNhfvt0zvwsTeDjaeruuBiPSxTkAM7WWbQ
 /O2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWVU7tOCszbNNUmme1mb68cYuglIwTadPTjgWJh7MXETmQMO0OJ5tiw/xQVYenOiOJrV2tOcM7@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8fY+McB70dxdK7cypB7dBYrbyPPkmzis14TBQKZptZ9V0E5YO
 p/EKBva1HxNZqwDAqxuE5GUdNhhS12b1z5wdsMQPpCEn305ttje0WaOnjMxaB8gRKF8I5J27M5Q
 01iPO8rN24PFmOvHgWqsLnwgI+EAS4aydGroG9oCf6Zo1
X-Gm-Gg: ASbGncv1SQfFJ3FwlLNxtNV+gU0yYvbMebkbaM9VfVl3xAgB8BORadFql9YbrzBvzXk
 AyHcwg2c7iuH5wV7nQdVbXx4Afi25PRc5ks94xKq2z6flLO2rcwZ6xd+l7E1zF1NPA722n7zFp0
 bZK13c82ikRSd/rcvoqjL32v5PBuif+eekn9V7GRhfmkqSndFv8tPGc87AMDLUosNS+/GctwB3e
 UHGfKgesJ4vsFhfq8yVjaHRBPVGPlcwe5KTmRPYXORgEzJjrk3l4lCr8gl7r9I=
X-Google-Smtp-Source: AGHT+IFChRdeC0Ev5aW0Qu8cl8ayA8ncXldl8O3l1x6DfhicxS4rMben287XZ9odx6UIN665zNZmmeVxZj1UZ4RLnmU=
X-Received: by 2002:a05:6e02:1486:b0:3eb:9359:d88e with SMTP id
 e9e14a558f8ab-3fd85e91ecdmr176834775ab.21.1757438961452; Tue, 09 Sep 2025
 10:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250908204207.8397-1-stefan.silviu.alexandru@gmail.com>
 <BL1PR12MB51442BF8FBDCE9F4A23C21D0F70CA@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51442BF8FBDCE9F4A23C21D0F70CA@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Silviu-Alexandru Stefan <stefan.silviu.alexandru@gmail.com>
Date: Tue, 9 Sep 2025 20:29:10 +0300
X-Gm-Features: Ac12FXwKUwWRP4Iz1bzkNK6mGf6fNNXnWHRmvprjUNyueVq6gIRiQI8xTjfbZFc
Message-ID: <CAB7_Ay8KKxn_unO6RiLKn=ZPrFoapHkMQjUWO6+_o0FjTkLy3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Register DP aux only if used
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, 
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

On Tue, 9 Sept 2025 at 00:16, Deucher, Alexander
<Alexander.Deucher@amd.com> wrote:
>
> [Public]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Silv=
iu-
> > Alexandru =C8=98tefan
> > Sent: Monday, September 8, 2025 4:42 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> > <Sunpeng.Li@amd.com>; Rodrigo Siqueira <siqueira@igalia.com>; Silviu-
> > Alexandru =C8=98tefan <stefan.silviu.alexandru@gmail.com>
> > Subject: [PATCH] drm/amd/display: Register DP aux only if used
> >
> > The aux channel is always registered if the connector is DP, even when =
the link
> > doesn't contain DP. When using the DisplayPort connector in DP++ mode, =
the I2C
> > is done directly over the pins, not over an aux channel. The practical =
effect is the
> > creation of
> > 2 I2C devices for DDC, one from the actual pins, and another from the a=
ux channel.
> >
> > This generates duplicate results from tools like ddcutil, for example u=
sing a cheap
> > passive DP-to-DVI cable:
> >
> > Display 1
> >    I2C bus:  /dev/i2c-3
> >    DRM_connector:           card1-DP-1
> > ...
> > Display 3
> >    I2C bus:  /dev/i2c-7
> >    DRM_connector:           card1-DP-1
> > ...
> >
> > The "real" bus is i2c-3, while the aux i2c-7 doesn't work.
> >
> > Any read on the aux channel succeeds, but always returns an all-zero bu=
ffer,
> > further confusing ddcutil which just says "Maximum retries exceeded", e=
ven if it will
> > never work.
> >
> > The dc_link->aux_mode is true if the link actually intends to use aux f=
or DDC I2C,
> > so skip registering aux unless the link is actually in aux mode.
>
> I don't think you can skip this otherwise you'll never have the other bus=
.  E.g., if you unplug the DP++ monitor and then plug in a DP monitor, the =
aux bus won't exist and then you'll have the opposite problem.

Hello,

Thanks for the review. You're right, the bus doesn't come back if I
switch around my monitors, I should have thought of that. I was
thinking the extra bus has to be wrong because other things only show
up in /dev if something is actually there, but I guess that isn't
necessarily correct here.

> You just need to use the right one based on what monitor is attached.  In=
 general, userspace shouldn't be messing with the i2c buses in the first pl=
ace.  If you need access to the EDIDs, the drm provides access to them.

I want to change input source and/or brightness for 2 monitors with a
script, so it's more about commands over DDC than EDID. I see there is
a symlink "/sys/class/drm/card1-DP-1/ddc", but that has the opposite
issue as it always points to the non-aux i2c (good for DP++, bad for
normal DP).

Would it make sense to at least update the ddc symlink when the DP
link changes? That way it would always point at the actual i2c being
used for DDC, aux or not.
Or should I leave it like this and figure out in userspace which bus to use=
?

Thanks,
Silviu



>
> Alex
> >
> > i2cdetect -y 3:
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00:                         -- -- -- -- -- -- -- --
> > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 30: -- -- -- -- -- -- -- 37 -- -- 3a -- -- -- -- --
> > 40: 40 41 -- -- -- -- -- -- -- 49 -- -- -- -- -- --
> > 50: 50 -- -- -- -- -- -- -- -- 59 -- -- -- -- -- --
> > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 70: -- -- -- -- -- -- -- --
> >
> > i2cdetect -y 7:
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00:                         -- -- -- -- -- -- -- --
> > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 70: -- -- -- -- -- -- -- --
> >
> > Signed-off-by: Silviu-Alexandru =C8=98tefan <stefan.silviu.alexandru@gm=
ail.com>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index fadc6098eae..1759071e02a 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -7429,6 +7429,16 @@ amdgpu_dm_connector_atomic_duplicate_state(struc=
t
> > drm_connector *connector)
> >       return &new_state->base;
> >  }
> >
> > +static inline bool amdgpu_dm_should_register_dp_aux(
> > +     struct amdgpu_dm_connector *amdgpu_dm_connector) {
> > +     int connector_type =3D amdgpu_dm_connector->base.connector_type;
> > +
> > +     return ((connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort) ||
> > +             (connector_type =3D=3D DRM_MODE_CONNECTOR_eDP)) &&
> > +            amdgpu_dm_connector->dc_link->aux_mode;
> > +}
> > +
> >  static int
> >  amdgpu_dm_connector_late_register(struct drm_connector *connector)  { =
@@ -
> > 7445,8 +7455,7 @@ amdgpu_dm_connector_late_register(struct drm_connecto=
r
> > *connector)
> >
> >       amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
> >
> > -     if ((connector->connector_type =3D=3D
> > DRM_MODE_CONNECTOR_DisplayPort) ||
> > -         (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP)) {
> > +     if (amdgpu_dm_should_register_dp_aux(amdgpu_dm_connector)) {
> >               amdgpu_dm_connector->dm_dp_aux.aux.dev =3D connector->kde=
v;
> >               r =3D drm_dp_aux_register(&amdgpu_dm_connector-
> > >dm_dp_aux.aux);
> >               if (r)
> >
> > base-commit: 837f3abbfebdb355ed049c2b06b54108e2bbdf35
> > --
> > 2.51.0
>
