Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451EDD3EE84
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 17:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D59AE10EA04;
	Thu, 22 Jan 2026 17:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cFRyvjY7";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2780410EA03
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 17:02:39 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12336c0ae91so130120c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 09:02:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769101358; cv=none;
 d=google.com; s=arc-20240605;
 b=bzzE7vNfjb97XBCG2jqHhtOwac4sitGOj7HWMXIZdSBFBV7UAMiOrhr1GXTyXEaLVS
 qt4vxQl3wHRbiPdCDcd7kjPPYx9sJiMkfX4XZcSAGv48scxg63EK2nbH7gpgcWTPxKNR
 uZkMQwYz01VetGOBXde/20f6iIDJqG0G/txUh/ZxSfbcsl1gVaAwRn+lXl3PfCBq5e6I
 AbpmUJquvPQzQN16HwhEs9J5Q0PX4bkmOpqtrm0islQyu8DY6YxnTYAXY0ip3bNWKsVc
 oFg4yaETTlNLD0iEAIEZiakS5G4rx5Fong3iRPT8dWDE3vnW0wTCPHixLLA2V6MyXoIU
 lWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UTVCrqSei0P29gKBmP/DGgxhoLfgUTwU0vl5mrdySvU=;
 fh=WHwqfn3JicTSu5O0EYyPC58FQLNj5hJK5iIS5X3ZmOM=;
 b=lNxDKJDoTrV4dqRcRUgyK8NQShC9vYjmV4AbwzemHHkR2gt50yeOXpTkIukp8uX8t2
 GAOW633sRuk/SE/YXZkWN5BvgZam5grYTqQ/oiQtd+RRy9fWNPRxFlf1XWPwJxk5QoX8
 cnpC4c+nd93lSBOKrJXtJmq+qbAQDTpwhHlpk8TBnwfFZxuDokI494mNJxGkmsMFKI19
 3YlGT4TYhmKUBOAX2FgDsRio9g+cJVQU3USuCl2GjlrSVAgWNlqc2ywpelp9tnDpXgWX
 /TNkww/F9DGrBGyZjJPkdSOVuxq7KbRCKLyd2eo9yiwO57pZJqhKf2A3xN1jVjQ13rzy
 g8yg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769101358; x=1769706158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTVCrqSei0P29gKBmP/DGgxhoLfgUTwU0vl5mrdySvU=;
 b=cFRyvjY7w2Mws2/L+G8XXm18/tAR/hVBBLH6k3OKyGGcKvtDRZHdbJup9KCA8WN0Pk
 8LircSJvIrnsrN2bWbjz1TDQUL2ZiDRm6WHvt2IDMppYrYgsn5N/UBjFELsnLdR6nFeY
 /NBq2XtNnJ0OZMIzkLo78XP6m/6V0uzuwrzWiqoKqr5mDuHz+78p3jiXSLzQF+WT/AFi
 okSdd4qA1KVOjGaUXkndzURuzz2Ii4lRoB6vK2nvrW14jchjHqFf1vyOO3qRLlPuAQtk
 4DAA4f48DEq4XtG2Rc+3nHMMnOXNoeaK/4kAi+u8zMTIw8P5vGb0Plr3hdZOZsFeXcok
 YMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769101358; x=1769706158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UTVCrqSei0P29gKBmP/DGgxhoLfgUTwU0vl5mrdySvU=;
 b=IO2kkyR7ab+e2uRUI5zmkE+gcQpUpf9W+uukHbIRhqOSEtEk/WEsh/T2q9DGpJPEvO
 SMDToxaOtpFTwqCbidUAKcNR2iRJIss2L+N72gxTpnX95/3tMJsvfRQq2KWP19AEKPNF
 FHIJQiw4lGIPR0da5eSDij9q7bK031+3QUm1JpDNfaMYd3rwQSjoUXJbsgZO/sCtC2XU
 Hkrr4D2BEwMMzZ/HWU1Ng8ZhC9su5szkmAdc1pad/GULWFcjOtz1jVRSwtdcbGP1WUY2
 DB0XAk+VknIyQDCT37gUz7kw3QrEyiTj1yXdZcNYG9LOIdvSUh63MzeSJ/gzOxu0G2Nz
 N4pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk9sFhkMWfDUcOEZICWUFuXSrBwLVkMHw64g9j+8rIvcy9t5wNIAC8EeLA0dxv/XTQ1mCAe735@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/6wyF+gFjdHfR63RbiGBygYaMv8k9/OCWxwEAjZqrqT2eP527
 xKspN4Ip5DvfpLFJL/qA+wKX7mJylEDs/ZPPYD2Olcx3LsjE09Qn8+eUDi/Yb/o+eZrw5lQ3l+f
 XpRlsEUjJ6flnXuaMWpCbCbh+J5jZR4t54g==
X-Gm-Gg: AZuq6aKQiCtXYzqHpkBUmQ2QrbJIW+Pm70C/4hP48G5AS8hA141LtQ6sFRWPM6ScLrO
 ghxHxTkyTHRnGf8DfLgALNKDcnzklh/QIILcJ4KlBNt5yy6qoTmL9ynTk7DmuEV0M5yph5cvH4A
 Xbu9kXlpwGPFpkRBqr2xaaMUZw48k9xjmSRNbo7gKv8W0VNVAUqB0D2q+Yj442Z+9bVtX/6z27g
 K1IMwi5Fo7noLmpieg0qVo8lqontgz8gO62Z5lQg1GyEiyDheQQwlDEFu2ziQgECVwy99Mv
X-Received: by 2002:a05:7022:6885:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-124770bf41dmr1142571c88.4.1769101358158; Thu, 22 Jan 2026
 09:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20260121031422.3431903-1-kevinyang.wang@amd.com>
 <52edd16f-a1ee-433b-b524-adf8c1164e57@amd.com>
In-Reply-To: <52edd16f-a1ee-433b-b524-adf8c1164e57@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Jan 2026 12:02:26 -0500
X-Gm-Features: AZwV_QgcNeADzKeocRGgAsfivAAk8KzrHQ4RfX1VVl83C0W5ZOjpN9DFk8ayNK0
Message-ID: <CADnq5_MxLO-9xyJr4jELJhiuXVVqAbpy58j0sw=BiMBHHG=a8A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: fix smu v13 soft clock frequency setting
 issue
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Yang Wang <kevinyang.wang@amd.com>, amd-gfx@lists.freedesktop.org, 
 hawking.zhang@amd.com, alexander.deucher@amd.com, kenneth.feng@amd.com
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

On Wed, Jan 21, 2026 at 1:27=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 21-Jan-26 8:44 AM, Yang Wang wrote:
> > resolve the issue where some freq frequencies cannot be set correctly
> > due to insufficient floating-point precision.
> >
> > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h   | 1 +
> >   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
> >   2 files changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu=
/drm/amd/pm/swsmu/inc/smu_v13_0.h
> > index efeaa3d57712..b0d6b7b0946d 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> > @@ -55,6 +55,7 @@
> >   #define SMUQ10_TO_UINT(x) ((x) >> 10)
> >   #define SMUQ10_FRAC(x) ((x) & 0x3ff)
> >   #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >=3D=
 0x200))
> > +#define SMU_V13_SOFT_FREQ_ROUND(x)   ((x) + 1)
> >
> >   extern const int pmfw_decoded_link_speed[5];
> >   extern const int pmfw_decoded_link_width[7];
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/g=
pu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > index 51f96fdcec24..e27ea0879429 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> > @@ -1554,6 +1554,7 @@ int smu_v13_0_set_soft_freq_limited_range(struct =
smu_context *smu,
> >               return clk_id;
> >
> >       if (max > 0) {
> > +             max =3D SMU_V13_SOFT_FREQ_ROUND(max);
>
> Looks more like a firmware issue. Isn't firmware supposed to round it to
> the closest DPM level frequency?

Arguably yes, but at this point, it's easier to fix in the driver for
existing programs considering all of the firmware out in the wild.

Alex

>
> Thanks,
> Lijo
>
> >               if (automatic)
> >                       param =3D (uint32_t)((clk_id << 16) | 0xffff);
> >               else
> > @@ -1565,6 +1566,7 @@ int smu_v13_0_set_soft_freq_limited_range(struct =
smu_context *smu,
> >       }
> >
> >       if (min > 0) {
> > +             min =3D SMU_V13_SOFT_FREQ_ROUND(min);

Does min need this too or just max?  Same question on smu14.  With
that clarified the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex


> >               if (automatic)
> >                       param =3D (uint32_t)((clk_id << 16) | 0);
> >               else
>
