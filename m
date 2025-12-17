Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA55FD65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 14:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8555A10ECFB;
	Wed, 17 Dec 2025 14:25:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dMaPpQ2w";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7C110ECF3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 14:25:48 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-29f3018dfc3so9767315ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 06:25:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1765981548; cv=none;
 d=google.com; s=arc-20240605;
 b=IgD7ftVdCX8lKW8k9nu8O+Crmlkrj9V1hlQ/3FgUct+DgXFnGAcHau75lgenM+Uhg/
 YJ2eGjWyx2Hh7hFTMcu55iJUKGvCTrvPxz3dJ//Nv+pcXF6UoPpuqCO4TVh4UQYcFJaO
 iJelQLPjB07Ca+tA/SKhlbfjw4BBDE1o6p3cYWP3x6kNz2HYLel8k4KwM7qyzUSGSLXk
 WgG47DcvrFCuemp4dBTGqqn9i7NOPhhffGgftrnDGjZL98AGgd6mA/Mpi4NGcY/nRrMY
 5ME9Q6aCxo5KSApoIpkNvQFlth08wD4cuNT1/LKPPRU5wRx4LpjheZU+hUyQBZeu4xvb
 hA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1tjvqWn9td6WoUv1AS94mZ0/oGw8iaygCKL03aU2xpY=;
 fh=3MftZBC0SfJKyCbeT4Sq1kFwN4mPxLPvU3yqxpveBek=;
 b=RVHJl3ZI+TZzILRPYUm6vlIRNUwPxyD02iRxhis2/WAk9ZL4HAtbh2GsoeVpwrdG7q
 4JB6c2IMnAoFuVXGAFWACJXvm5XmDvCPg3zFEhZ9k3iqTcw2fWOeXBmnZd83xs4xu2Lu
 ID1PsJSCANpxprC41DPRVVYnddEorsgpc7vmOPY/y0NYJewUs/lMbgAc/8prH+dIE+Hu
 NZNVIT0EbsPEaGEPSmBi5Vru2oqKYS8/Ka5afMYGErje6iMyvH+sDMC2EFR0IQ11HCmx
 ElNkTCrS+fY5nVGhhOCUuefXA/ukjgWZhAoZ7IeD3TxyitIXUrIExFtpyrjc2H1LGFRa
 QfeQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765981548; x=1766586348; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1tjvqWn9td6WoUv1AS94mZ0/oGw8iaygCKL03aU2xpY=;
 b=dMaPpQ2w0t0LyqgjgNuw5MWDCkvgiXfrYPchQylKEmZlr5x9tDuy/F/OIwgCxF5GSv
 dESVVOpbQNEH5/x/GMLVgH+CUIQ+xjFSaXzpBRKWzOIVaaTKPHRk8jQ6dA0CBDjHizhV
 uYXc9mrBwp9Am0KUr5aR5YkkARaCLxYxjsqeTX22Su7pupD9uJnxZA4yVpm3M8OWMeGY
 cgGQW5TkTvVjLUiEMK2mnkmAbJBhjQdhUvJHRiiv6pggMHF4bLIRxkalRN56hg0f26s0
 5sidB+OGYyeQpBsq/y9Sh0k/7JQu9NGeoC/lgukIzmUoSju2JK4Q+AoDQLcSoMuTbZNY
 x8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765981548; x=1766586348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1tjvqWn9td6WoUv1AS94mZ0/oGw8iaygCKL03aU2xpY=;
 b=W9Xe8roSMtiRuu9ZkTcp92iC4ObP4mBoPG9fDHMY/fh+mUe6vwAFg+gUWN7jMtSGM5
 4PEXL+hor0kqT6o2ZXZcGKRtwx62/cnPAo2j0CXGgmA5hI/rS4xQOqqbAtzQQqrzensC
 duKoxnr4X6vbDVmM8iHTNqH2haa44LRhpdfBGznTe+fSeSzeQOsidf2Ap3uXWSD0qlD4
 RlUCoCkMCEcrFerDc408epGm4d4n4XzIbNyQNkH4A2COqyCzERpBqhQ8KoodyPS4cUrQ
 ukux5zOKIGSWhzAWJ5bV8huYopokqLChJDFWgI7MsZCs40YFIEgaE8/2zXdkWV1iIVgm
 0Wgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb9XUs/tWYoyKbS7zZpPnltDrvTQrlZy2GWNRapeTLLIPcoCUSMSxcrw1QEZe0xuLo6B9DTHVZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2HHTSmLE+ilICanLNufCzgdDXhAszgeF4DhnbA62YW8zORPik
 bci/NlaSf638bLnjEyiUkoPOZDM01bd8wM71fSD8sZyFnVOq9rtFiExosDLv/CDCQscPwrAADxB
 Nwzj5tXnlxtRsabm4SUVWflD5E2f3I+Y=
X-Gm-Gg: AY/fxX56ILq6W0XyUR6gEuciBMOHg++Akqq10PPHY5OHBGDhpXwiV0iJvqscUhJM1B1
 RmfL41Ng4ZHMsqXQYjxXN+6B8PE1F455y0gSX4ASKnLymA8B2JX4Oypu51QefekAElO8fZTIkUu
 DRT+DWtl9bmIN2S9B1vrKBfkukPVUx0qyxPlFROhgpc9f8S+iXIamZxRTwitCunuBuSsoq9tMj6
 RQslU33nQeVFUaTOQDJmETqNUoKpWE2qQmMOyDMaDjAgR+ganF6fBp1mtR46zrC2BoZS5lQcfun
 Zv1ulLU=
X-Google-Smtp-Source: AGHT+IEVk9nROQVa6lHGZAq/d0NljVNDr35DRVumIC6lT1kaTRJlUeEZYcXY0ncYXPrPo08OEtkRky595swcayvjR7g=
X-Received: by 2002:a05:7022:e997:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-11f34c1e37dmr7092008c88.4.1765981547905; Wed, 17 Dec 2025
 06:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20251217140151.1984057-1-alexander.deucher@amd.com>
 <18588297-a934-4e51-87b3-b2aa453f7672@amd.com>
In-Reply-To: <18588297-a934-4e51-87b3-b2aa453f7672@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Dec 2025 09:25:35 -0500
X-Gm-Features: AQt7F2rkURDp4WGQgDK0PYEhgUxUJtX4i6q0huR2sRdXnnYHO34emlZiLrcqP38
Message-ID: <CADnq5_Nmfgq77ef+i4npb=EJbcA7vMJqSPvVPoh_wuUg4hgn0Q@mail.gmail.com>
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

On Wed, Dec 17, 2025 at 9:17=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 17-Dec-25 7:31 PM, Alex Deucher wrote:
> > clockInfo[] is a generic uchar pointer to variable sized structures
> > which vary from ASIC to ASIC.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4374
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> There is one more -
> https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/radeon/ppta=
ble.h#L463

Thanks, I'll squash that one in too.

Alex

>
> Thanks,
> Lijo
>
> > ---
> >   drivers/gpu/drm/radeon/pptable.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/pptable.h b/drivers/gpu/drm/radeon/=
pptable.h
> > index 969a8fb0ee9e0..f4e71046dc91c 100644
> > --- a/drivers/gpu/drm/radeon/pptable.h
> > +++ b/drivers/gpu/drm/radeon/pptable.h
> > @@ -450,7 +450,7 @@ typedef struct _ClockInfoArray{
> >       //sizeof(ATOM_PPLIB_CLOCK_INFO)
> >       UCHAR ucEntrySize;
> >
> > -    UCHAR clockInfo[] __counted_by(ucNumEntries);
> > +    UCHAR clockInfo[] /*__counted_by(ucNumEntries)*/;
> >   }ClockInfoArray;
> >
> >   typedef struct _NonClockInfoArray{
>
