Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76F3CAC5B9
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 21:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7475E10E059;
	Thu, 25 Sep 2025 21:16:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Pm21tDFK";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AC8810E059
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 21:16:52 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-26808b24a00so2084955ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 14:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758835012; x=1759439812; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ytr8xhBNyoPI+ZLHl2kc2AkIZBBrVwCcZWbNUz1BTw=;
 b=Pm21tDFK0s5UYcVqwp6CSDTmtt89cdOZj+XQWWa31UCGMuwsCJi57LB6hwQZe39FlF
 zdvsEBXBEgVsh1e1U24CN2nS7ekcAJG7aaEukp9QxOvecltXqS7AJ5MOTau4sLa9bOGZ
 gQgt4yQk2jDLgmfHawzYzsTBcKqdGVjHv8KAom5ESXYeMW2tbsY+wgln17N35Q17bTEl
 v25wrvSeVq7PpLgQSpaY9YUESIz+b9Aj+K7pWrXupqERgxHvVQnUtL1c6IkgEQ2jV4vA
 EubbKvgp7wEUo3EDI4WLTFb8buqfEbDj/AlilxXOCfdHRFga3/hOQVueEufiRbOnCLWA
 w4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758835012; x=1759439812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ytr8xhBNyoPI+ZLHl2kc2AkIZBBrVwCcZWbNUz1BTw=;
 b=ad6FWZQrPx6C3FlT1XcoRCDVZz6eXL0GhLwUEippJJJg2x6+jGrG8Uf2QTxflnkaYH
 tLZZGK11kyZ7wWeqBod+lqIBWmFeGl32f3rSSDMGp7y7RFDEFQczMv6NU9QX0VgJ8xmg
 rdHZvTKEYv88ivIiWW3nkwHp74Y+EyRuipJ3c+NFPct+HjzSwsP03QpaEx2Mz/aEUdqO
 L1ff7ZoDkSDxOAMNZMZqbZiBjlBho8qrRG0UcxjXlH/uVZadkZ7AARvt2HbYnz3IBrb1
 igD06U8Ni+joAW8yd2EH76p0UHShc8Kj+HH/q9duYOCzKZb6SK4diTkMKIuMSzM35ODF
 7JUw==
X-Gm-Message-State: AOJu0Yw1CQ65OaT4DgGZuEGLPnSA6ZjqwiCcXpO+yLWC2pRrp88gQQoi
 LWkj9r39UVO9kgDT2y2593/YRmyfK+6UowplaXlxQYde8CcVvmKgJ3xn2FTU0JXDgiUkvT525DL
 wQhv3KwBxG10D2gOZ+kd3+lwI3dTIApsNdQ==
X-Gm-Gg: ASbGnctaDzOWeKQey7pp/KSexAuqXTsxAEaDSgBvgqptmhI9INxlQHHnXz9AyUVB9xb
 sDCwwn91n8AHGqx92UyX9INNkLUZEGTtaRK9gR4P8wQbzw83CnpMje01dXWM+IrAqt/8dwmbG7t
 JcO647zHGuPhoMImtgq8UvsGdA+0s4GUoJik+zr+J/RFwQ64gYHENO9o+ey8SYa37yWUKvlsg0N
 5shdPk=
X-Google-Smtp-Source: AGHT+IEhxurO9FlEm/LPUWHYNIWjbNgkqyKqZ5mCTqDEgOUe269Xp90iSaoSi2WVEdfAWXfOGdJbhsLZAH4zIHdIqAA=
X-Received: by 2002:a17:902:8210:b0:27e:eabe:7604 with SMTP id
 d9443c01a7336-27eeabe7ad7mr5059075ad.9.1758835011931; Thu, 25 Sep 2025
 14:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250925191402.2518978-1-mario.limonciello@amd.com>
 <CADnq5_M7_LTPz7KjtCWHH3XP5OZsFZoO=odqNPtkOLdgxXU-LA@mail.gmail.com>
 <b9863279-9303-4acf-961d-bbcd624c1cc5@amd.com>
In-Reply-To: <b9863279-9303-4acf-961d-bbcd624c1cc5@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Sep 2025 17:16:40 -0400
X-Gm-Features: AS18NWAshhNv-GmVMLZ2NhLXvMDiCArX6VvD7bLpML4M2eiD9q_KIFAIt7uZ5as
Message-ID: <CADnq5_Punstwk7HgX7R_gQ7+3pp5o81uirPY+VAkwF70N8JJcQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Check whether secure display TA loaded
 successfully
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Sep 25, 2025 at 3:50=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 9/25/2025 2:46 PM, Alex Deucher wrote:
> > On Thu, Sep 25, 2025 at 3:39=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> [Why]
> >> Not all renoir hardware supports secure display.  If the TA is present
> >> but the feature isn't supported it will fail to load or send commands.
> >> This shows ERR messages to the user that make it seems like there is
> >> a problem.
> >>
> >> [How]
> >> Check the resp_status of the context to see if there was an error
> >> before trying to send any secure display commands.
> >>
> >> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1415
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >
> > I think the tricky part is that we want it to throw an error on a
> > system where it is supported so the user knows something is wrong.
>
> But a system that it's supported would have loaded the TA correctly, righ=
t?

Yes, it should.

>
> This is specifically checking if the TA load failed which is being used
> as a proxy to show you shouldn't bother with the other commands.

That makes sense, but I don't think it fixes the bug report.  The
driver will still report the error on TA load.  I'm not sure how we
can avoid that.

Alex

>
> We still show WARN messages from
> psp_ta_load()
> ->psp_cmd_submit_buf()
>
> I guess arguably this change really should be:
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 693357caa9a8..1c790dfccc9f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2350,7 +2350,7 @@ static int psp_securedisplay_initialize(struct
> psp_context *psp)
>          }
>
>          ret =3D psp_ta_load(psp, &psp->securedisplay_context.context);
> -       if (!ret) {
> +       if (!ret && !psp->securedisplay_context.context.resp_status) {
>                  psp->securedisplay_context.context.initialized =3D true;
>                  mutex_init(&psp->securedisplay_context.mutex);
>          } else
> >
> > Alex
> >
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_psp.c
> >> index 693357caa9a8..70d4bfb13f46 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >> @@ -2356,6 +2356,9 @@ static int psp_securedisplay_initialize(struct p=
sp_context *psp)
> >>          } else
> >>                  return ret;
> >>
> >> +       if (psp->securedisplay_context.context.resp_status)
> >> +               return 0;
> >> +
> >>          mutex_lock(&psp->securedisplay_context.mutex);
> >>
> >>          psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
> >> --
> >> 2.51.0
> >>
>
