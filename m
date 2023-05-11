Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DA6C77B7C
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 02:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BEE10E585;
	Thu, 11 May 2023 02:24:58 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B33F110E585
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 02:24:57 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-54feb6cb568so620134eaf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 19:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683771896; x=1686363896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yw7+7DfMAN/H8KOV3HF4FojTDXYgpqYspoX44aYHQX4=;
 b=L+ACE9YysrGs8lw5RHjeMqCio3/rGUO00KW0HfASbU16bD1SAPaElqUyqyBWfIXN3b
 rtgoxIFrnfY74u1cHyMowQG/cea6WTTA+HquvF37h8CxujQ2msSovqBrx08hUGw1cDsw
 6OjnXq1F+TOgcqjCYxf0lJKqF+NpjpYDMe5y/lVgEuMiL4OXCLq6dEetScMiUTqYJBoa
 O2dMSk5AJHdIw/Gg+EzZz5a68Bd7WgDRhjdNTPIU97GwQvHui4SBb7/E0R3goPvx/Qrt
 b4Jz8ECLlXkjcByuHPk/Mimp5K5lZRJ+QI0d4tks3AvsQ26Q2IZmm53FQHCwF7vXJP1z
 0oew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683771896; x=1686363896;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yw7+7DfMAN/H8KOV3HF4FojTDXYgpqYspoX44aYHQX4=;
 b=i78ppzBkL64818EkXtKpjFGEkkYJybfrbGJbE9BxBWsnXaTOyAfqlwld3El1EBkWYE
 VhtcqJho3aex1xqrTxqKzY8urysiyNUTI/Td/1rHp/mccspchzz4A9sbGeAm/u0XkNrm
 opjEgj3km+fq4FZ9WPGV+cOs7wTVQT+hrsRjgdGr0a+g4Us93mAjkOWULwSTfoT0Kc8q
 iecXkzGMFsP682PUb293fWcQOpkCnVgcXAD9isLnbzC+ovO6Zz3HWngJEeXNOAW/Nb2z
 aa7Rvhqp+38GXpzZAy/lb4q7OS+hUbmyF9FHT0TMOxJp3rcHVYTsm3TjRJz/A8SiVyYO
 e/0Q==
X-Gm-Message-State: AC+VfDwF0LRWPyTrLFXwd8iPEionl7mYaPcsDjMCcjCxPfgVIs4oLYJ5
 aSkIUWGGxp5m8Ovv3RcUkSGvvXXgSP8n7d/Rh8YkN1TM
X-Google-Smtp-Source: ACHHUZ4StSHBQFz86LNJwUOOU1qvTsJDB8Pvy5aRKzjStANqn1oMWkav1RkzYIfmPETV+8IRLOQkTF78u9dNWoYydRY=
X-Received: by 2002:a05:6808:3b7:b0:38e:4ff:8142 with SMTP id
 n23-20020a05680803b700b0038e04ff8142mr4247401oie.47.1683771896370; Wed, 10
 May 2023 19:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230508152929.1114091-1-srinivasan.shanmugam@amd.com>
 <CADnq5_OfvZbUCiiOw1CHs2DkfjnmTwWedvDvnVgZUif7NBtUyg@mail.gmail.com>
 <MN2PR12MB41289C3850B0CEF7E2D0687390769@MN2PR12MB4128.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB41289C3850B0CEF7E2D0687390769@MN2PR12MB4128.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 May 2023 22:24:45 -0400
Message-ID: <CADnq5_OSa_8DzrP=vwbQPUof=DgfDMeSm=kAM01rYyY0PVmAdw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Remove redundant else branch in
 amdgpu_encoders.c
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 9, 2023 at 1:17=E2=80=AFAM SHANMUGAM, SRINIVASAN
<SRINIVASAN.SHANMUGAM@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
>
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Monday, May 8, 2023 9:27 PM
> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander <Ale=
xander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amd/amdgpu: Remove redundant else branch in amdg=
pu_encoders.c
>
> On Mon, May 8, 2023 at 11:29=E2=80=AFAM Srinivasan Shanmugam <srinivasan.=
shanmugam@amd.com> wrote:
> >
> > Adhere to Linux kernel coding style.
> >
> > Reported by checkpatch:
> >
> > WARNING: else is not generally useful after a break or return
> >
>
> What about the else in the previous case statement?
>
> Alex
>
> Hi Alex,
>
> Thanks a lot for your feedbacks,
>
> the else in the previous case ie., is binded to if statement ie., "if (am=
dgpu_connector->use_digital) {", am I correct please?, please correct me, i=
f my understanding is wrong? & the best solution with your tips pls, so tha=
t I can edit & resend the patch please?
>

Yes that one.  It follows a similar pattern to the case you changed.
Shouldn't checkpatch warn on both?

Alex

> Much appreciate for your help in advance,
>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c | 26
> > ++++++++++----------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> > index c96e458ed088..049e9976ff34 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c
> > @@ -242,19 +242,18 @@ bool amdgpu_dig_monitor_is_duallink(struct drm_en=
coder *encoder,
> >                 if ((dig_connector->dp_sink_type =3D=3D CONNECTOR_OBJEC=
T_ID_DISPLAYPORT) ||
> >                     (dig_connector->dp_sink_type =3D=3D CONNECTOR_OBJEC=
T_ID_eDP))
> >                         return false;
> > -               else {
> > -                       /* HDMI 1.3 supports up to 340 Mhz over single =
link */
> > -                       if (connector->display_info.is_hdmi) {
> > -                               if (pixel_clock > 340000)
> > -                                       return true;
> > -                               else
> > -                                       return false;
> > -                       } else {
> > -                               if (pixel_clock > 165000)
> > -                                       return true;
> > -                               else
> > -                                       return false;
> > -                       }
> > +
> > +               /* HDMI 1.3 supports up to 340 Mhz over single link */
> > +               if (connector->display_info.is_hdmi) {
> > +                       if (pixel_clock > 340000)
> > +                               return true;
> > +                       else
> > +                               return false;
> > +               } else {
> > +                       if (pixel_clock > 165000)
> > +                               return true;
> > +                       else
> > +                               return false;
> >                 }
> >         default:
> >                 return false;
> > --
> > 2.25.1
> >
