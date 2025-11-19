Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9460ECF2591
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 14:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F7E910E608;
	Wed, 19 Nov 2025 14:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zd4Xd9/O";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D113110E608
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 14:00:43 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7ba92341f07so368354b3a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 06:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763560843; x=1764165643; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpHN/UyBJbMF+AbxAkpCThddgdIWCYthSZU+MuSsZCM=;
 b=Zd4Xd9/OIow8Sgmx8YIOHCDdx4jGFbm8HBexiE7RrrRAT0uTAi9wP08qo0A0Qmda6g
 WqMgGMZUj50twTbVbr5gKyl2buEOe7r/MVDvaw6o5yIUjPmXNxeJVI+iYsi4dKrwQX6q
 F3909OmWzCbrV5kNgPwG/DycowZ/pV+ORUdJ1c1ZC6ucCgjlwCdnYRv77E1HTC++2q70
 IXQTW3MK3W7FOV7ebsj1TnAUlpfTGl7BkJgjKynnWCZNBXpX/MmOcBKQbYfShYpgVce3
 B/RTarRZd8GP6L0D/66jfcdIYZYooiY4yUtYSXVoTsCXrpLQPYhS4WjH5/7fcmJze/bg
 pRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763560843; x=1764165643;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FpHN/UyBJbMF+AbxAkpCThddgdIWCYthSZU+MuSsZCM=;
 b=BdtgKXFzoeMy1Ckc0wYSIF3kkY5PeZmlytEmEXYnesEWzRmMLmKT4NWihZEdDQOkrV
 YH+cgMpodmIXlHNrxpa8V00vgs8tRFMmUfZiIU1X/AzQtpYkPI4ctFZ2MtY8nq8DIjnH
 qNVScnJkDKVAwpPSQK5wuJRZNqU0HO2TBs/sKHoBRAEiHyR6PJD/IAkRX48wrysLscqj
 f23kX/s8vIkhEj/aBjrrawhEQkTUIe/AqhTp2qrkc82jqbLaqPdp7pdlsWGvetL8fNCh
 msy36yVtZR8b8DRQ6sGE0qLWiVVz5uRqpWVE0M1FfAPSAMWKXY5i7/1vOKPdj/C7t6j0
 I/kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5xQp4gG1LwGmNLBI9UfbT260M0CB0nvqG8ElT36+/A57blGOyLPnG7/nRDwHFxsSDJo4o5uV8@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUhuO7b90y6jIhWB81HIrxX1qz7zW+UIRaFC7xpNFDKUVsC70L
 9/su32JWw7cmQcy+fQxIlVKK/D88VimcCjKraS0zVuMM1EEQa80Ipl86B4raXsB3ukiXsJvCipm
 fbq4dQDuUUyvH9EVvTxINBqYPn9tGpN4=
X-Gm-Gg: ASbGncsCjeaijDst0ZbEqbfaPLdEK9r0wJUTgCfxETAqfWRGjaJMYE1HGudKK/zFaLo
 Eq/Jp6d7b7OdPfayyY8fNzLdPAoAXxhdkg20Q6fSh7X721SEnfynImXuLossijqUgCU+vxCW/gD
 01C6LQjmA9twB2zjVhlWKyVYzBDG3HDZD9jueyYoukXLIzKN50iLJGyftaE8P2V5VW/ote6QWdw
 v8imupghL0O75oN+YcNbb1W2Mb0yiirqa0TE/vOq4AkeTsMfstSeVFdmAHA/LNJgP2YMJYP3O/L
 6XK2fg==
X-Google-Smtp-Source: AGHT+IENO67JtY7BfGheEmQIu00+firY6Yph+PxOj3InL3XI0bkdKI7hZLXvhBC1oaONiG2tqR07SiSf8cvO9+2A864=
X-Received: by 2002:a05:7022:ea46:10b0:119:e55a:95a1 with SMTP id
 a92af1059eb24-11c7966cf23mr1980510c88.3.1763560841019; Wed, 19 Nov 2025
 06:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20251119002348.4118647-1-siqueira@igalia.com>
 <20251119002348.4118647-2-siqueira@igalia.com>
 <462b1556-264b-4ee8-afb9-e5e0869192f0@amd.com>
In-Reply-To: <462b1556-264b-4ee8-afb9-e5e0869192f0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Nov 2025 09:00:27 -0500
X-Gm-Features: AWmQ_bmuWP1EUmJ8T2uH50dUSdBZDxhtzCM13345ouIEhXtM2TriXYgGfbpq-Bk
Message-ID: <CADnq5_PvUGYZiHr3572cqeQxCHTNFkDodaZDbmOg02tMV=vuPw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu
 is reloaded
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Mario Limonciello <superm1@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>, 
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Wed, Nov 19, 2025 at 4:29=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 11/19/25 01:22, Rodrigo Siqueira wrote:
> > When trying to unload amdgpu in the SteamDeck (TTY mode), the following
> > set of errors happens and the system gets unstable:
> >
> > [..]
> >  [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
> >  amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB te=
st failed on gfx_0.0.0 (-110).
> >  amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
> > [..]
> >  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous comm=
and: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
> >  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> >  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous comm=
and: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
> >  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> > [..]
> >
> > When the driver initializes the GPU, the PSP validates all the firmware
> > loaded, and after that, it is not possible to load any other firmware
> > unless the device is reset. What is happening in the load/unload
> > situation is that PSP halts the GC engine because it suspects that
> > something is amiss. To address this issue, this commit ensures that the
> > GPU is reset (mode 2 reset) in the unload sequence.
>
> Mhm doing that on unload sounds like a bad idea to me.
>
> We should rather do that on re-load to also cover the case of aborted VMs=
 for example.

That's what we already do for dGPUs, but for APUs, there's not really
a good way to detect this case on startup.  On dGPUs we check to see
if the PSP is running, on APUs the PSP is always running because it's
shared with the whole SoC.  Always resetting on init is not desirable
as it adds latency and causes screen flicker.

Alex

>
> Regards,
> Christian.
>
> >
> > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 860ac1f9e35d..80d00475bc9f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -3680,6 +3680,15 @@ static int amdgpu_device_ip_fini_early(struct am=
dgpu_device *adev)
> >                               "failed to release exclusive mode on fini=
\n");
> >       }
> >
> > +     /* Reset the device before entirely removing it to avoid load iss=
ues
> > +      * caused by firmware validation.
> > +      */
> > +     if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu) {
> > +             r =3D amdgpu_asic_reset(adev);
> > +             if (r)
> > +                     dev_err(adev->dev, "asic reset on %s failed\n", _=
_func__);
> > +     }
> > +
> >       return 0;
> >  }
> >
>
