Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E91C19F32
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Mar 2025 18:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9728A88C11;
	Wed,  5 Mar 2025 18:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iq/ML3yY";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 941FC88C11
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Mar 2025 18:49:13 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2234f57b892so16792415ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Mar 2025 10:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741200551; x=1741805351; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eLJdHl9mT4c/0ssT4+NG0k9jaS/iFkUQGXLpXqKvALk=;
 b=iq/ML3yYwgkmgFZNdPizZOkYpuU5arTbRFrRqRVzkoLiKkA3jv7jd9X9a7C3Mj1qoG
 DriR62+ogDUw+pwfgsHL+cwCkdQuXiaFZl3ojeJd6Wa10iHgKoEc/TN7to2+qsAHN5Oc
 cPBoBaOgjRST5OYoum54mimcrMTFjX8zehT6kdCDe3IN6F86QODOx6w8OBqA1iEOHOqI
 H2xxPw+gA1tE7lK2nb3LWWgVVl+F8Km+fvGmO5YPiVHUo3PgGdFwEM4+Qi6gk7uQ7SZR
 Ke1bNy/yUhlCrXge4EEKgxUGCCwDDfZG7vWxG88NTyi9UOgcEul9Gsp64UsEwimhpiso
 XAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741200551; x=1741805351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLJdHl9mT4c/0ssT4+NG0k9jaS/iFkUQGXLpXqKvALk=;
 b=IBza30T8nluManEu3dn7J389/iB3zAxMMkmRyyT7fyd6z1mibC39fLBleHeLJ4xSjp
 6mvnTCRmQscuQXL73sgvd+QW6JK6uMGHNZFPLyD13Aw2BP6HajdcBWydIqC7XQZqpe2t
 JQbatyjy9Fw0+J0X9A0N9b1yZR8AlCn/uggApnb16p4wOEZfZ7ynjHTSoCRLWKg4NXPE
 uizyHIToiINLw/tYhHAbALllRo4rgJZdyc2jsCAM+FQyF8hzQinfgnVkyRleAUIIIaV7
 LZuPHcvXWJaUapH+wKfKMHI5JZXIHSmgo4bMDXBHGmPpHiBqErSd1Dv9XD7uZI0mNvxn
 +1Jg==
X-Gm-Message-State: AOJu0Yxc0/1tL/mbqs7NcgaIyHyj+TF2v84Bpv9nEQNGBcdNWOph2UkQ
 JCTZpgQ+L7N3jPXLjxKmDq5t7yECfGH4egsFzti7+WyAEHUTiAkhf+H8G0wAOFXJQ4shc0lW5z6
 kNVGcgRwofgyI7hafQtohYcVSvQSORQ==
X-Gm-Gg: ASbGnctqvGDzFBztBCqBqDMZjWeiypMUfcIFvCZOb76zDuyvU22UX16rE4pD788Cl+t
 oVSOfDCPugPk7JX3odqWiyFZdmJxrht6cxEvLOnlEJyOPYBltlJD1AUjHu4p0JFpM2Uk3vukmF1
 50az0+VJQ3RwRtb23ZxzfXEvkJ/Q==
X-Google-Smtp-Source: AGHT+IHLyuVU+fvC3q9Vr/c3WxZJtCVZtjuv8WjVzy+nscorsKJGcwNb8NRQb+lZA2tqf8VIDu0ppBQ2lI3QYe9JJlE=
X-Received: by 2002:a17:903:3c70:b0:223:f9a4:dc25 with SMTP id
 d9443c01a7336-223f9a4dfeemr15248305ad.14.1741200550674; Wed, 05 Mar 2025
 10:49:10 -0800 (PST)
MIME-Version: 1.0
References: <20250301023130.31277-1-alexandre.f.demers@gmail.com>
 <CAPEhTTFAy=+SXPNk4vEeYo0bpFuBPb+yvBE9QVCMZnML7PMmQw@mail.gmail.com>
 <CAPEhTTHpFeSywrgM1kTL=o+-h8-FnT-dwTArgRrV67sS_x8+Yg@mail.gmail.com>
In-Reply-To: <CAPEhTTHpFeSywrgM1kTL=o+-h8-FnT-dwTArgRrV67sS_x8+Yg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 5 Mar 2025 13:48:58 -0500
X-Gm-Features: AQ5f1Jo6jQHflPP_roPvzXAsBTuxP9vC2VEEyZW96cTm2FgfFbUkeeb_RODMMOs
Message-ID: <CADnq5_OWYsuq9Jdb2CqXkVpnYUn+Nejb_1e8gVzfB37uB5svSw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Uniformize defines between DCE6, DCE8 and DCE10
To: Alexandre Demers <alexandre.f.demers@gmail.com>
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

On Wed, Mar 5, 2025 at 1:04=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Ok, so wiring up sid.h in dce_v6_0.c brought a lot of redefinitions.
> Fixing them is not the problem, but it spreads out a bit over the two
> files.
>
> I'm having an issue with the following:
> In si_enums.h, we have :
> #define TAHITI_GB_ADDR_CONFIG_GOLDEN        0x12011003
> #define VERDE_GB_ADDR_CONFIG_GOLDEN         0x02010002
> #define HAINAN_GB_ADDR_CONFIG_GOLDEN        0x02011003
>
> However, under sid.h, we have:
> #define TAHITI_GB_ADDR_CONFIG_GOLDEN 0x12011003
> #define VERDE_GB_ADDR_CONFIG_GOLDEN 0x12010002
> #define HAINAN_GB_ADDR_CONFIG_GOLDEN 0x02010001
>
> The values under sid.h are exactly the same under both radeon and
> amdgpu, so I would be inclined to think they are the good ones.
> However, gfx_v6_0.c uses the si_enums.h definitions.
>
> Alex, what do you think of it?

Sure.  Sounds good.

Thanks,

Alex

>
> On Sat, Mar 1, 2025 at 4:35=E2=80=AFPM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > On Fri, Feb 28, 2025 at 9:31=E2=80=AFPM Alexandre Demers
> > <alexandre.f.demers@gmail.com> wrote:
> > >
> > > Keep a uniform way of where and how variables are defined between
> > > DCE6, DCE8 and DCE10. It is easier to understand the code, their
> > > similarities and their modifications.
> > >
> > > Alexandre Demers (2):
> > >   drm/amdgpu: add or move defines for DCE6 in sid.h
> > >   drm/amdgpu: add defines for pin_offsets in DCE8
> > >
> > >  drivers/gpu/drm/amd/amdgpu/cikd.h     |  9 ++++
> > >  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 63 ++++++++++++++-----------=
--
> > >  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 14 +++---
> > >  drivers/gpu/drm/amd/amdgpu/si_enums.h |  7 ---
> > >  drivers/gpu/drm/amd/amdgpu/sid.h      | 29 +++++++++---
> > >  5 files changed, 71 insertions(+), 51 deletions(-)
> > >
> > > --
> > > 2.48.1
> > >
> >
> > Please, don't consider this series. Adding sid.h throws out a lot of
> > redefinition. This needs to be
> > fixed first. I'll send a v3 once done.
> >
> > Alexandre
