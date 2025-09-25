Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BE1CAC5B5
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 21:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6880A10E9B4;
	Thu, 25 Sep 2025 21:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kOawOCh4";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12F3310E9B4
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 21:54:40 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-267fa729a63so2145845ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 14:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758837279; x=1759442079; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLmXZzsFIBXAX83WiXwIiMkvRMzal1Mzmrb6LFeHvIQ=;
 b=kOawOCh44VqNTIGH8Q8Ord4RytcXRAqvDRUn1xk1z8hmxmIfq4Ul1Aey0ahKwOVAZX
 fdeZmeuBsMJB+kN6AUDMh2YKJaCwuOFoKbXakOGp0f1/h0JYkxvXQbRnnIhD4+r71D6n
 FFAg8b/yaZNrEnMaeZOmLOhzva7GSICsvuSc9BIgXn3cXFaO3EAmlORHgzl7Dj+hW2RG
 RDQOYpPA+a9xDVms+FkgW8ZMfvqi9x4l6Rv6Na34hkv1EbdsG6B+fXBSdxW+Bbg1TxBC
 NPLdSFJN6WIMGCk6zGtmwTQ+XB+8SD6I2+d6gyu6rEesRbOzWW/TQl4EuazFuV0wcpO/
 /+TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758837279; x=1759442079;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLmXZzsFIBXAX83WiXwIiMkvRMzal1Mzmrb6LFeHvIQ=;
 b=wUCWnHm1gpqRANIiSl6Eg7ShrtQ7DurLPk47muQAxXUNJWz2hyNe17sp1CH85FEeLz
 q+U3asGjzlvHohyx+kEFgfaMybXvZdvRlb35SuGCWn/SPMfEAaZwdllNZlLOFEe/QewL
 tyJC5Bl4o0JgepytPNtXnIKS2Qg/i2PoMSLquC7G26jfRGAonw8ivXr3aDzIIpquUddk
 qoOiBjK8DcyTpL5INaLwBq0843DEZadi1osB9bXxveKKYorgMQdeq+biUgFmvEdfqKQJ
 FO7qNivEH/y0yV9kDx1YQmCKBmh1n5zJIQ3EDgnizEFaTjL5D/jXaUvyRVPI0jk09t6Z
 zPQw==
X-Gm-Message-State: AOJu0Yy0NLfzghrEUW9qkfk7lG8tx3VTDaJPKJLWY1hBNZDjEUj//zTo
 FrS7hOMfdHBq5CtkPK3ihhTo9TcdS3UAD4MZMCZX9u8lcfvY5wd+bDoVzlOmnYs9vXWa3/5AEg3
 u7H6oyKQz3reqwVKzeW3ILV0+ELw2lrGBYQ==
X-Gm-Gg: ASbGncsWsMEu/s/j5yCc55PIFsaN3rcxMdmcgEG/ocvXKv2KC7XdZgdc5KdCABagZBm
 6HNYzwQj6UJgLwuVIQboEN7wwIwKyXbdwfGhGhBKkNuDJKevE7U5Sf2vtLrT4nZ5X2MvPGj+88e
 Ndhuj9MMfu67UiKchDW7E3OBY1YeCY4Mgvi3F9/OroScmmuzlmu29+tYHzD3u4OupvRAt4nZF3f
 oam6u8+gkR96D37tQ==
X-Google-Smtp-Source: AGHT+IFh4OaIV6Ukh3Rl5bh6IxDmEeliy0MzWcnhsaeayQP00UJdvKapEEUv3UH7DI/EVHT5z5Y4P54z23RtYdt+qXE=
X-Received: by 2002:a17:903:2306:b0:26a:f96c:3099 with SMTP id
 d9443c01a7336-27ed4a1a2c2mr33948985ad.3.1758837279512; Thu, 25 Sep 2025
 14:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250925191402.2518978-1-mario.limonciello@amd.com>
 <CADnq5_M7_LTPz7KjtCWHH3XP5OZsFZoO=odqNPtkOLdgxXU-LA@mail.gmail.com>
 <b9863279-9303-4acf-961d-bbcd624c1cc5@amd.com>
 <CADnq5_Punstwk7HgX7R_gQ7+3pp5o81uirPY+VAkwF70N8JJcQ@mail.gmail.com>
 <594dacee-2475-4b79-8b41-897b47169df2@amd.com>
In-Reply-To: <594dacee-2475-4b79-8b41-897b47169df2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Sep 2025 17:54:28 -0400
X-Gm-Features: AS18NWBCLanGHN2hRVBjF5bZOnnU6djdOUrg4cxXBC9xFAfM8WxqH9aZ50NHGDY
Message-ID: <CADnq5_PMC8EQxLWYYpCwM=q-NVvcg18jUAmTb13X_i-57-OdEg@mail.gmail.com>
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

On Thu, Sep 25, 2025 at 5:47=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 9/25/2025 4:16 PM, Alex Deucher wrote:
> > On Thu, Sep 25, 2025 at 3:50=E2=80=AFPM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >>
> >>
> >> On 9/25/2025 2:46 PM, Alex Deucher wrote:
> >>> On Thu, Sep 25, 2025 at 3:39=E2=80=AFPM Mario Limonciello
> >>> <mario.limonciello@amd.com> wrote:
> >>>>
> >>>> [Why]
> >>>> Not all renoir hardware supports secure display.  If the TA is prese=
nt
> >>>> but the feature isn't supported it will fail to load or send command=
s.
> >>>> This shows ERR messages to the user that make it seems like there is
> >>>> a problem.
> >>>>
> >>>> [How]
> >>>> Check the resp_status of the context to see if there was an error
> >>>> before trying to send any secure display commands.
> >>>>
> >>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1415
> >>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>>
> >>> I think the tricky part is that we want it to throw an error on a
> >>> system where it is supported so the user knows something is wrong.
> >>
> >> But a system that it's supported would have loaded the TA correctly, r=
ight?
> >
> > Yes, it should.
> >
> >>
> >> This is specifically checking if the TA load failed which is being use=
d
> >> as a proxy to show you shouldn't bother with the other commands.
> >
> > That makes sense, but I don't think it fixes the bug report.  The
> > driver will still report the error on TA load.  I'm not sure how we
> > can avoid that.
>
> AFAICT there should be 4 messages showing up.
>   * 2 warning
>   * 2 error
>
> It will at least help the two error messages.  For the warning ones I
> guess we could plumb an arugment into psp_ta_load() and
> psp_cmd_submit_buf() whether it's an optional TA.

Ideally we'd have a way to detect which boards have this, but I don't
know of a way to do it so maybe we just have to live with the
warnings.  Patch at least removes the errors so:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> >
> > Alex
> >
> >>
> >> We still show WARN messages from
> >> psp_ta_load()
> >> ->psp_cmd_submit_buf()
> >>
> >> I guess arguably this change really should be:
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >> index 693357caa9a8..1c790dfccc9f 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >> @@ -2350,7 +2350,7 @@ static int psp_securedisplay_initialize(struct
> >> psp_context *psp)
> >>           }
> >>
> >>           ret =3D psp_ta_load(psp, &psp->securedisplay_context.context=
);
> >> -       if (!ret) {
> >> +       if (!ret && !psp->securedisplay_context.context.resp_status) {
> >>                   psp->securedisplay_context.context.initialized =3D t=
rue;
> >>                   mutex_init(&psp->securedisplay_context.mutex);
> >>           } else
> >>>
> >>> Alex
> >>>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
> >>>>    1 file changed, 3 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_psp.c
> >>>> index 693357caa9a8..70d4bfb13f46 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> >>>> @@ -2356,6 +2356,9 @@ static int psp_securedisplay_initialize(struct=
 psp_context *psp)
> >>>>           } else
> >>>>                   return ret;
> >>>>
> >>>> +       if (psp->securedisplay_context.context.resp_status)
> >>>> +               return 0;
> >>>> +
> >>>>           mutex_lock(&psp->securedisplay_context.mutex);
> >>>>
> >>>>           psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
> >>>> --
> >>>> 2.51.0
> >>>>
> >>
>
