Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBD1FD3760
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Feb 2026 14:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F5D910E082;
	Wed, 25 Feb 2026 14:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RspXEc9B";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A153810E082
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 14:24:09 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-127337e3870so453350c88.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Feb 2026 06:24:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772029449; cv=none;
 d=google.com; s=arc-20240605;
 b=lnkZ+x3v0qaAmkHAg8MF/DAeoC3sq6iLS8OmkKePU9xgr98pDvWYyGUfSD7pqasYlP
 sL3dbB2FGRI/JFUR9PRk0jyYrOziHVAqUD4m++AbVm5spe6U8+Zyby1uL2fVwBvliDY9
 oi9stjxshy3xTQDt00+jXEljF+dYEofXqlKUdSxsn+ZWCCsyCj5AvSXh1dsIW1dje/np
 izIGZf9ALPcRxSwbbbUP+JLfSs3OGMpxZALD0uGbyc0msBPdW9e4PIkhOksXsWqKusDj
 G64RoqPdIlkPd5BRPeIR1DP4uIk2Fl7Uq1ekftbURgjkIVdb+9MChDzddnTOp0bvCdfj
 g0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m3qEBEXmpv4JwozKSjUi1if3b9RC/ddChLrGOjDEFEI=;
 fh=7HdDirIWVTYH0o/a0buKmgYXTLj9iBgJFOogXhOPrmw=;
 b=RLsCjyYtg1klvZXBbZph8rA3PZbdlJ0PQ1nZVUjk/CmJ9O27eFlVfuCO+4hK9SKMKo
 LcvxKLF5fkBQHlnSLxWqMaRXBS43Z77qS8lAD20gE6Cmr9nSMsjPEhtw707RRD9Q2CH/
 t8Ozmz8AHuaLuI1ibLjeg7fWbP7KKsW3fsDhfR4e62ducHkmmuccDKMrrgv2EbSx3kKM
 GB47tSwazO05ZIuLpPhOiJ3GDQgSXq5HED4346Z29MpMCwrv8XDEYWAmMq/viDfyeu+j
 9jTo6mRNv5C0l3cLCLlw/cSGrDYO5MzJpgD09GmfU9/1bLul/RaCQNqnDdxmFJ7c/+J8
 bJxQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772029449; x=1772634249; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3qEBEXmpv4JwozKSjUi1if3b9RC/ddChLrGOjDEFEI=;
 b=RspXEc9BuMmsa6FFoL5zNcrdOCzmL6Dof2NOCpMpvR0JdiBQ2O7kheSYcobOawA2dm
 dBQ/8AyTiIpQMH8RlsKosMs6tnC6oiCvJ8bb9+Av6ugNAOeWXeaIijEgb/glFLDjJTlX
 NTwJsT7a7rrueafHVpH9HEpT+UeEVFvbos5tCX/jqbRzizOxTnuB8/kda14rQAduieSj
 Mw2fUf9tHG099phHPI2c3Y0e6WIQMfwR9jr08mgH3lrAax9GB8Bbdld8uF4Q5nFKl4Uq
 7epK/JOm4t7kxGGBa8HwouuW83KkI8mUu/gZNWl5tSQHBG6dyib6Qz0DECE7iuwdrX15
 81Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772029449; x=1772634249;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m3qEBEXmpv4JwozKSjUi1if3b9RC/ddChLrGOjDEFEI=;
 b=B40/nniBLvNm7j/bMuntz/tD4bdiNRiiSWmkITY6pDyEfow88eRT7NxLms9c6FtBnr
 kTgFq5gnn7w1KhKqlGhoRaAWAU9U5OWOTBYNijCTtx4kqxvBX1ZnINVBY5ABhYOLg7DB
 pudStiIhglghJIQdz4y/a8+3l2nkf9ZQysi3VC4xQGkDVcXbiilsNXOHPDdcIDp2qlws
 eGjB7Hn94g4xmXp5TKJ/V41vDxEL+uV9JKzFMy1AwFGIzX1mTDlEb0eiDq0UE2gZBBRK
 1CrEmx2pJjCdAmgh8c5rQ7fehCe076L9TzKc6FNP9e/3tyPsHzaREzCXCvrqMskJJWqu
 k97g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYl95UIpal2PPa1HWJ5RAJ1yXnxRS5wjRkrVp7A3ribBVTNtpnPOvhO1LFQdfUgFHuXAsSIZzI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzR/8z1NKA3/H/swR3ndyp86+qMfDE7fMDLuBa53RcrWA3x2cN7
 0LEJ0/pVXZi5ZUxBl5TGtb0GTiO2OofxJRFrv5qmeTm2+/7icufihmUYXlOUAnIZdrgfUkCbLim
 P1Pe8lQhOQFG4YCZTtJuABL+pPtJMXYw=
X-Gm-Gg: ATEYQzwSt57cHtHnHiybZxoG3RAS0xqqkOsi1XuF6wCCSux61/PFDkv6s8jpiU1+qm0
 ozTjrBQXTmvLsvL9vYf2z0VCSCR423BJHcSJCIH+oJ/aMQwDXqoVwymJGQSMd8WNt+JhI70TuJ6
 UBF1dVDAKswAemX5vHq8dlvXEYjXcDg6/nCM2fLyfk3L3IlJnJqghTG9QbwnrDte0duDpjO5eJI
 OdHefSb6/mRJ+bFsvoIOYc1ws30JrOFB/lJrg2Qep/QnB084zHIBvVY7nqKq/Fut7Mt41XB1Ywk
 we3fjTevlLCp7UeY1qBlV+0M9zc+C3WNG3GCTqXy0tnUJL9OehtwVwJSiiMb+rzy9v8+Zw==
X-Received: by 2002:a05:7022:45a8:b0:122:33e:6ec1 with SMTP id
 a92af1059eb24-1276ac58439mr3264777c88.0.1772029448455; Wed, 25 Feb 2026
 06:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20260225093406.498727-1-kevinyang.wang@amd.com>
 <96885b73-a1fc-4b3f-a35e-0177a415a331@amd.com>
In-Reply-To: <96885b73-a1fc-4b3f-a35e-0177a415a331@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Feb 2026 09:23:57 -0500
X-Gm-Features: AaiRm51fG2ScPpeyNO5BZk42b1qgVkVa-kqOd_DSpRURxDTlbpNisNMtQ-eVaB4
Message-ID: <CADnq5_O4u+v9f5XNFipKHPa1qC6tEr0k4ppZXX0tUqrAjY8PXQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: restrict sensor load values to 0-100
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, hawking.zhang@amd.com, kenneth.feng@amd.com
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

On Wed, Feb 25, 2026 at 7:14=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 25-Feb-26 3:04 PM, Yang Wang wrote:
> > Limit GPU/MEM/VCN load sensor values to 0-100 range via clamp_t to ensu=
re
> > validity.
> >
>
> Is this a workaround? If it's not within range, it indicates some
> underlying issue.

Likely for:
https://gitlab.freedesktop.org/drm/amd/-/issues/4905

Alex

>
> Thanks,
> Lijo
>
> > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 27 +++++++++++++++++++++++----
> >   1 file changed, 23 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/p=
m/amdgpu_pm.c
> > index 938361ecae05..86ef1ffbf1dd 100644
> > --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> > @@ -1414,20 +1414,39 @@ static ssize_t amdgpu_set_pp_power_profile_mode=
(struct device *dev,
> >
> >   static int amdgpu_pm_get_sensor_generic(struct amdgpu_device *adev,
> >                                       enum amd_pp_sensors sensor,
> > -                                     void *query)
> > +                                     uint32_t *val)
> >   {
> > -     int r, size =3D sizeof(uint32_t);
> > +     uint32_t tmp =3D UINT_MAX, size =3D sizeof(tmp);
> > +     int r;
> > +
> > +     if (!val)
> > +             return -EINVAL;
> >
> >       r =3D amdgpu_pm_get_access_if_active(adev);
> >       if (r)
> >               return r;
> >
> >       /* get the sensor value */
> > -     r =3D amdgpu_dpm_read_sensor(adev, sensor, query, &size);
> > +     r =3D amdgpu_dpm_read_sensor(adev, sensor, (void *)&tmp, &size);
> >
> >       amdgpu_pm_put_access(adev);
> >
> > -     return r;
> > +     if (r)
> > +             return r;
> > +
> > +     switch (sensor) {
> > +     case AMDGPU_PP_SENSOR_GPU_LOAD:
> > +     case AMDGPU_PP_SENSOR_MEM_LOAD:
> > +     case AMDGPU_PP_SENSOR_VCN_LOAD:
> > +             tmp =3D clamp_t(uint32_t, tmp, 0, 100);
> > +             break;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     *val =3D tmp;
> > +
> > +     return 0;
> >   }
> >
> >   /**
>
