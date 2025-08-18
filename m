Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C212DCA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 22:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677BC10E08E;
	Mon, 18 Aug 2025 22:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ru8NZ9uw";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C4210E08E
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 22:03:17 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-244581fdfd8so7400265ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 15:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755554597; x=1756159397; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5vi/BZmrYH+S11bJgrTF6LLPUpQRUbgSh8Pi+GcGc0=;
 b=Ru8NZ9uwLIwEb1kAD3qQWbTAgJGsnj0Kh7H8e+kOuDpFLPu3YdUMiOn4rZmfONd81d
 xXbhzpItHedqS1U4YmTsm6IqVkJUnb4T2Tw54zIj8/ecxcVJHZDqhRbFi5/LfRzyCcIL
 HEzrxgPViRwKeCNSpcdgRqd/WTqWTy5DUnRohAritFKTR77zwwc5mwMt2nhP4Yn5TuKv
 VbirJmD7e2Zjhvop2ES8INpUH9enLOQiqBNHKXyXy0t4tKCkAIspGgXc6crdZO607VSf
 2BegrAh+WvJDugW7jn3U48RcX8IDCKhjJ5WRXWQzVTF/bQhU6GOGz+5+Ae/abN4e+eNO
 Empw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755554597; x=1756159397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5vi/BZmrYH+S11bJgrTF6LLPUpQRUbgSh8Pi+GcGc0=;
 b=psGOYZb3jaF519tlCLor00CKTG/Q30wWj8btqY+BowHi6M56VnTfsgRIEJqxh35Cid
 W5kCJwzuN67qPs4CIuEtC6OluP/GYq7qZkkFu2zUNwGvmYiWlimPDFZNUgWkwC4dmIUo
 OyNrQov3ZAKj7AzYAKWvHv1yy0o99hY34toe1iiZVreqxjPxG76H0phlgTNaue5EqyYL
 3qcPrk3SfOF3MDlKFlBI4ZRVx8RVTdXqUkFfKdYuDIh9+UbHNRgLG2Yy7VFKF7Jyk2YN
 xWNe3c8ZjFZYe4fd7HL9kjvmpEgys9O79PDAoYHtXG4BSXFDKiarFJ5+uALEaZN0ZEzU
 ytQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU03dfR5Ex6ttKzEo9r609NlcI3FRRsLb0zTuIaAvCannHwD5qD/Mq0JwYeELs2Z4zFC8nfElMv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJd3SIwUcAG2vV5KDiTXw6Y/OvDeCRVTRyfCqEoxVG8Nds5Etc
 V3X7D50PEIe23lmjC7TBoJ9TzF8oYaJgNPXwEnMrPrt7DeHp/0xq4HIMLHBFSqMawuZmF1aZos1
 6c0HRPOZhex3v6opVs5Gmi2Z54EDfDd0=
X-Gm-Gg: ASbGncvldA4slHNVhAu1uEwUbNREL+KY1Kn1jQZesH0QQmTNDz2waegr7cDcm88xePM
 LfE3poaAINK87VPo61bk/muvhjCsR3/vtgrPWwW7OTwxJC2RaCoMcLrzy12oOdOQd3CgsOyxV4/
 T1Ok8XlNgRZYVwkSLdzSFAl3UaqQA15mHAEoMDdkCPnI+7iZs8ESFY7j7qbQLA8iyUS44oe8Qx9
 Y2qM3Y=
X-Google-Smtp-Source: AGHT+IGD6Qu5v9dO4w0VmqM3o+IFBIAaXTvtsW7A5VBTXOGyHwzJ6cVfvWUTMofJ3UVpFRNOS7CC/gqlHomaLoRLbX8=
X-Received: by 2002:a17:902:da84:b0:240:5bde:5353 with SMTP id
 d9443c01a7336-245e056e4dfmr1320885ad.7.1755554596732; Mon, 18 Aug 2025
 15:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250802160602.12698-1-timur.kristof@gmail.com>
 <20250802160602.12698-4-timur.kristof@gmail.com>
 <bb9c7df3-5175-4e13-b519-19d6db465a67@amd.com>
 <CADnq5_MnTaM4U+UgnpEmFf6i1eyavgh9XAT20BajxJ0S2t_7Gw@mail.gmail.com>
 <CAFF-SiVS9NY2MSd-ZmTnjwrOnC=amJrK2gh1CEOCgwiZOgjL4g@mail.gmail.com>
In-Reply-To: <CAFF-SiVS9NY2MSd-ZmTnjwrOnC=amJrK2gh1CEOCgwiZOgjL4g@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 18:03:04 -0400
X-Gm-Features: Ac12FXwysV_NmuW1zEvZ7DLMwiACnOnWEf3qttnyAXtuKf0vpy_s1fHEGeTH9o4
Message-ID: <CADnq5_NsTX59k5Pyuv67-dA0S10z3kO9OTF=0W+z_Zkb6yk=MQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Don't use non-registered VUPDATE on
 DCE 6
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: Alex Hung <alex.hung@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Mon, Aug 18, 2025 at 6:02=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
>
> Alex Deucher <alexdeucher@gmail.com> ezt =C3=ADrta (id=C5=91pont: 2025. a=
ug. 18., H=C3=A9t 22:30):
>>
>> On Mon, Aug 18, 2025 at 4:11=E2=80=AFPM Alex Hung <alex.hung@amd.com> wr=
ote:
>> >
>> >
>> >
>> > On 8/2/25 10:06, Timur Krist=C3=B3f wrote:
>> > > The VUPDATE interrupt isn't registered on DCE 6, so don't try
>> > > to use that.
>> > >
>> > > This fixes a page flip timeout after sleep/resume on DCE 6.
>> > >
>> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>> > > ---
>> > >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++---=
----
>> > >   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 ++++++++------
>> > >   2 files changed, 23 insertions(+), 15 deletions(-)
>> > >
>> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > > index 470f831a17f7..e8d2ba58cbfa 100644
>> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> > > @@ -2981,14 +2981,20 @@ static void dm_gpureset_toggle_interrupts(st=
ruct amdgpu_device *adev,
>> > >                               drm_warn(adev_to_drm(adev), "Failed to=
 %s pflip interrupts\n",
>> > >                                        enable ? "enable" : "disable"=
);
>> > >
>> > > -                     if (enable) {
>> > > -                             if (amdgpu_dm_crtc_vrr_active(to_dm_cr=
tc_state(acrtc->base.state)))
>> > > -                                     rc =3D amdgpu_dm_crtc_set_vupd=
ate_irq(&acrtc->base, true);
>> > > -                     } else
>> > > -                             rc =3D amdgpu_dm_crtc_set_vupdate_irq(=
&acrtc->base, false);
>> > > -
>> > > -                     if (rc)
>> > > -                             drm_warn(adev_to_drm(adev), "Failed to=
 %sable vupdate interrupt\n", enable ? "en" : "dis");
>> > > +                     if (dc_supports_vrr(adev->dm.dc->ctx->dce_vers=
ion)) {
>> > > +                             if (enable) {
>> > > +                                     if (amdgpu_dm_crtc_vrr_active(
>> > > +                                                     to_dm_crtc_sta=
te(acrtc->base.state)))
>> > > +                                             rc =3D amdgpu_dm_crtc_=
set_vupdate_irq(
>> > > +                                                     &acrtc->base, =
true);
>> > > +                             } else
>> > > +                                     rc =3D amdgpu_dm_crtc_set_vupd=
ate_irq(
>> > > +                                                     &acrtc->base, =
false);
>> > > +
>> > > +                             if (rc)
>> > > +                                     drm_warn(adev_to_drm(adev), "F=
ailed to %sable vupdate interrupt\n",
>> > > +                                             enable ? "en" : "dis")=
;
>> > > +                     }
>> >
>> > Hi Timur,
>> >
>> > There seem to be conflicts to amd-staging-drm-next. Could you please
>> > rebase and resend? This helps make sure new change fix the problem you
>> > observed.
>> >
>> > Really appreciate it. Thanks.
>>
>> If it's just the first patch, you can skip that one as the conflict
>> solves the issue with DSC.
>>
>> Alex
>
>
> Hi Alex,
>
> This is a different series, not the same one that had the patch for the D=
SC crash. I can send a rebased version tomorrow.
>
> Additionally, I have one more patch that solves another case of page flip=
 timeout on DCE 6, I will add that to the next version of the series too if=
 that's okay.

Sure.  Sorry for the confusion.

Alex

>
> Thanks,
> Timur
>
>
>>
>> >
>> > >
>> > >                       irq_source =3D IRQ_TYPE_VBLANK + acrtc->otg_in=
st;
>> > >                       /* During gpu-reset we disable and then enable=
 vblank irq, so
>> > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> > > index 2551823382f8..f2208e4224f9 100644
>> > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
>> > > @@ -298,13 +298,15 @@ static inline int amdgpu_dm_crtc_set_vblank(st=
ruct drm_crtc *crtc, bool enable)
>> > >
>> > >       irq_type =3D amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->=
crtc_id);
>> > >
>> > > -     if (enable) {
>> > > -             /* vblank irq on -> Only need vupdate irq in vrr mode =
*/
>> > > -             if (amdgpu_dm_crtc_vrr_active(acrtc_state))
>> > > -                     rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, tr=
ue);
>> > > -     } else {
>> > > -             /* vblank irq off -> vupdate irq off */
>> > > -             rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, false);
>> > > +     if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
>> > > +             if (enable) {
>> > > +                     /* vblank irq on -> Only need vupdate irq in v=
rr mode */
>> > > +                     if (amdgpu_dm_crtc_vrr_active(acrtc_state))
>> > > +                             rc =3D amdgpu_dm_crtc_set_vupdate_irq(=
crtc, true);
>> > > +             } else {
>> > > +                     /* vblank irq off -> vupdate irq off */
>> > > +                     rc =3D amdgpu_dm_crtc_set_vupdate_irq(crtc, fa=
lse);
>> > > +             }
>> > >       }
>> > >
>> > >       if (rc)
>> >
