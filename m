Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9F2C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 17:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C866510E11D;
	Wed, 30 Apr 2025 17:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZRRWJS9r";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F46F10E100
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 17:02:40 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-224104a9230so102775ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 10:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746032559; x=1746637359; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hrcTk95DO0WXpBvqp53JmQpzotGvILWdaMy7unXEkms=;
 b=ZRRWJS9rW1A5RflI9x9evTc+6PnGaA4Qq1CZK+QRzmHRNoJ4BulhXP3FW7++W+oVt+
 CHxN090GikQ218KLr0qxQFs68WZVmQsXd58xCWGN2XsnQ56xX49usGMQnPUq9mftU/cQ
 mseck/P0Z2pQIkeDTTjpYycKx3xxkVMfyn56rnUfvW1mcj5n4nzIAF3LmxMKQ1y3jlwh
 W4P/Q/VT5cMVq2VbWAnsZOx2KBdjBUx95vqrNf6hA9bdz0TlIosL8LDpAQTfSIji2Qvr
 MVuUR+Y4reQHvyP7GLIvof8xM9knMLs8aokcDxbx+z9hYBss65/o4k9DURgAZaHxRIMf
 ZvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032559; x=1746637359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hrcTk95DO0WXpBvqp53JmQpzotGvILWdaMy7unXEkms=;
 b=UB646M6bLBnhqFwkO4NiJHcK1iwyEr5SzJPGWSsTRYpwFDNCiTjHVwJ07M5AOa4tRk
 OQuRbJleAtGBiJsH/CoiIlH7ZW9tV7bMEJHq7IlzPWM5KQQ4nne7GsbX59K/uRqjXFW5
 6I6F8zXxR2umuPVmYy7BD22+abYKHncEOScQQjBx7Jbvd0QOppe+y6k51Z6/eIjnEfJ+
 OEVMRhUZ/62ImtRM6T7SIMuXBhmSLMUYPfxTPYO9zmewvslgnks2lMLCBVvx+TUvD1rM
 LG6+SPRvmRHbIMBjfS/9vOUXlPMDxuZx5kyVIEzDzohgERoeNqVNEUXokfLHPTsVn2QJ
 /UnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtruBVCQFVBpHsc+Nsm7pdwXJoyZvgxgh1uVRM2gHvD/9O16ia40b/UfAA621jnr/KkRvqhR6R@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzclT9casLZZGqauB4PmrLjGHDkEHHj+nelPNrUpfL5ouQd1Fim
 W9pVF0byTsBhK75fMESkIz4yiD5A5XKsirJhLLA4zPXHOg8ETa1+//+ARaWvMEeopoqqaY0h+Gi
 +pGi1gi0HlKVKrAH1C4bcWVd5M5s=
X-Gm-Gg: ASbGncu74ymemW7WHxPMzjb5tozNggf+5fkmdgrFonaon7kGbtU3sbmCFYLS7MBCobU
 DJRxM8xfzlW/VDwaZPifolrsagzp4QxdSVDF7/Dr8S2ZnfBiVA4Wxx+nwhHvb7Hj8Ot8l80JDoF
 ELAMQS7Lm4DKOndz67YaBa7g==
X-Google-Smtp-Source: AGHT+IGZYtRTwkllesTRS6LfZJGNRe2tk8jPxJIyPAkvCTQw1p/1ZLuwwpCgEwZVztSYRGzbzfv9HlDmzTOpXAE7hcg=
X-Received: by 2002:a17:902:db06:b0:224:10b0:4ee5 with SMTP id
 d9443c01a7336-22df56afd7amr17603035ad.0.1746032559481; Wed, 30 Apr 2025
 10:02:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250429134739.1523228-1-alexander.deucher@amd.com>
 <60f0bac7-cc46-444f-8985-efe889ec4ac3@mailbox.org>
In-Reply-To: <60f0bac7-cc46-444f-8985-efe889ec4ac3@mailbox.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 13:02:28 -0400
X-Gm-Features: ATxdqUEURMjuvQnnTn_oS5keIkc86r6Vw34bRPK73SF6HQ6MJAK2hnzyxsec3K0
Message-ID: <CADnq5_Muw-vCqWZ+OnPnJWnX4gKDFr=S0s9dwV-sobTe9DzzRg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/psp: mark securedisplay TA as optional
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
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

On Wed, Apr 30, 2025 at 4:04=E2=80=AFAM Michel D=C3=A4nzer
<michel.daenzer@mailbox.org> wrote:
>
> On 2025-04-29 15:47, Alex Deucher wrote:
> > This is an optional TA which is only available on
> > certain embedded systems.  Mark it as optional to avoid
> > user confusion.  This mirrors what we already do for
> > other optional TAs.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4181
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_psp.c
> > index d54bb13772622..1c843b888475e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -2214,7 +2214,8 @@ static int psp_securedisplay_initialize(struct ps=
p_context *psp)
> >
> >       if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
> >           !psp->securedisplay_context.context.bin_desc.start_addr) {
> > -             dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta=
 ucode is not available\n");
> > +             dev_info(psp->adev->dev,
> > +                      "SECUREDISPLAY: optional securedisplay ta ucode =
is not available\n");
> >               return 0;
> >       }
> >
>
> Does it need to be dev_info, or could it be dev_dbg?

The customers that do use these optional TAs generally want
notification of their absence.

Alex

>
>
> --
> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa devel=
oper
> https://redhat.com             \               Libre software enthusiast
