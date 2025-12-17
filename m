Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC7AD65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 14:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7556610ECF3;
	Wed, 17 Dec 2025 14:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nrWNCwg4";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D51C10E84F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 14:29:12 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2a08c65fceeso7886095ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 06:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765981752; x=1766586552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmRm4+FVP5wy7/HP/JYrpBO95tz2xQ8XZAO1EFq4+Eg=;
 b=nrWNCwg4Pd9raj1KW7HaU8OR8PhTsaDda8tG/4rpAzKn0QcxlgZ70ro2XrnJVUQWvV
 mERsbtui7D4EGvlPETy2CrT1ZO8Idvplcs4FolvbCuSrbUZbt7f0QuzSwNHZTUsIKbdV
 e4nw8vCM3YFXW482WWwnyGSQ7sx287RtHASBaK4gz2QLsJtpadjnJlvRT7C8fOiIfoz9
 n2R/cIr2LEEXGkD/KI9hdbRowZW3pF95zJi0dKppZItda0c2kbMC44b3ACsBpp/425wf
 t8qBjJQcG3+94i6PkfNhpipI8Y3i6iZigjGvPu1FYB33+EFkJ0UeHm50prz4S5Nbw8+/
 Ctig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765981752; x=1766586552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RmRm4+FVP5wy7/HP/JYrpBO95tz2xQ8XZAO1EFq4+Eg=;
 b=Bs8Zm2I13N7d2GnbuONdOVkiM3SnxyAtzI1L3hft+XVqiNVyKW1e2qZbD20B4vGltk
 I2IV9u2kg0WRXUHRUBGsWW3sdZlqVQaHfrMOdZFYEIv35Cam7BTn7ylIOIW1puw8cuG0
 C9h9rwnhwFyQb5t+aU1wTQyGWKvM2FpXTxxif3y6oALj1j8qGOdvzf4NzM1f7CHmgpZ3
 FeoPMQK/+9tQuRXYJyLvX1nd7qV3xSLQ00dNQ7BIh8ce5de4q2p38RXaHrICUHf314av
 KpEmQrTXfeVRpACdS7AgLqDT+YNd9flniUm82S9X+cqDkmdpOYi9fmoqkO7jS8vvuHrC
 FZ1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvHuNPkYIlJzoqqyaavx61iOdHOX52ArReS+rewIWFhgT0QAfqWb9Ze35D3IBGfWdxT0Q4XWUg@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+8Oz8c5YaJDWrseA9krgev3Dy90qxqlmo8ArAWPEpf0D5aAtD
 az6dFpLr5XVSFiton5oXmgYMqQ0QUS52H/pnj4Zg1La1kY7OUVW15KvwCi2nvLeYmH8uFNNNe59
 4GVydXiv/zesA0sRs6UrnJ/sSb7a3BX8=
X-Gm-Gg: AY/fxX5ztjYVgIbY0tB0dQmrjMf7RS3a1np03ywba+2amTcywMgRkPNOcsFIVyVXAy5
 JAdNy9Aq8jugQCv2e8ddxkBRcgr7nNG537RzDCsu8ZWV+T6dUyCnHidmMKz9vsIbcD6Z8GFAAIV
 cxaH9v3aPq8Cnl+LWhd2ComdTE8gkjK+Pl0LV5CTt+J0eTCfpnbmUFdA5gk+HgzjgowOYzhuDwJ
 Qkt2CYo6z819WyTrQk3dQH67uGR/HjGEDQHDypcwM0i1SXRiBpRIaLdKm1p15f7jCWxrywwv/5E
 idkclZ4=
X-Google-Smtp-Source: AGHT+IE+iySXSkMvbSQ/a/1pPL4GzKw7dcOe1imcsbgsMOK3uVaHbiTdTwjSqT+ZaryilisAFC2v16kFnXj8TSYew3c=
X-Received: by 2002:a05:7022:b8a:b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-11f34bd3b7bmr9330535c88.2.1765981751590; Wed, 17 Dec 2025
 06:29:11 -0800 (PST)
MIME-Version: 1.0
References: <20251217140151.1984057-1-alexander.deucher@amd.com>
 <18588297-a934-4e51-87b3-b2aa453f7672@amd.com>
 <e0ef1d04-240e-4e07-b5be-7a4cc1d037d9@amd.com>
In-Reply-To: <e0ef1d04-240e-4e07-b5be-7a4cc1d037d9@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Dec 2025 09:28:59 -0500
X-Gm-Features: AQt7F2oWSgiRDX_hJzhPOI5wNkxsDiOiL1V0iBUHtOUwVgOf5ccbiAyWh1-DK00
Message-ID: <CADnq5_M487m3kH1jh1FGmCPFad8Ue0d=OvtGkCd6FhVc6O+BPw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Remove __counted_by from
 ClockInfoArray.clockInfo[]
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Wed, Dec 17, 2025 at 9:26=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 17-Dec-25 7:47 PM, Lazar, Lijo wrote:
> >
> >
> > On 17-Dec-25 7:31 PM, Alex Deucher wrote:
> >> clockInfo[] is a generic uchar pointer to variable sized structures
> >> which vary from ASIC to ASIC.
> >>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4374
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> > Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> >
> > There is one more -
> > https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/radeon/
> > pptable.h#L463
> >
>
> Please ignore. False alarm, has the right datatype.

Right.  Thanks!

>
> Thanks,
> Lijo
>
> > Thanks,
> > Lijo
> >
> >> ---
> >>   drivers/gpu/drm/radeon/pptable.h | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/
> >> radeon/pptable.h
> >> index 969a8fb0ee9e0..f4e71046dc91c 100644
> >> --- a/drivers/gpu/drm/radeon/pptable.h
> >> +++ b/drivers/gpu/drm/radeon/pptable.h
> >> @@ -450,7 +450,7 @@ typedef struct _ClockInfoArray{
> >>       //sizeof(ATOM_PPLIB_CLOCK_INFO)
> >>       UCHAR ucEntrySize;
> >> -    UCHAR clockInfo[] __counted_by(ucNumEntries);
> >> +    UCHAR clockInfo[] /*__counted_by(ucNumEntries)*/;
> >>   }ClockInfoArray;
> >>   typedef struct _NonClockInfoArray{
> >
>
