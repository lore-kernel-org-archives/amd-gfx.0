Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1268C44501
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 13:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64E9B10E069;
	Tue, 14 Jul 2026 13:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d/Io6Co3";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6640310E069
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 13:55:58 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-ca957338f14so530703a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 06:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784037358; cv=none;
 d=google.com; s=arc-20260327;
 b=e1X9bfpxHKZhazTawO/EspqgYCRhrO3Mrrvc1sLkSlhN1zLbze19Ys6VBakVa4KbG3
 jWsuKrLH4U/rnAFkGdJdxnj1ROT/Zmw3DjnYbGkeECTw4Zui3Ew/c7BPVJd6H/Y7eWPZ
 lHGDGJVk4elqpRu8DupORvFgmP3Iu39uT9575YYoWim4QhbP9T+I2b8/13Gp3/ZCKGB3
 jYwgyReZTDhKSVZJeJUwQE1WHOXP2+hEBp1rBte4DBU5FimMol9mwoUCvyRzI/k9kuej
 gjAq/lcraOCKhfULkDem9sQPP2QuCpFi2OmuId+bGFjcC5gX68rG92A+4GnJ9smZG8SG
 gbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pg63fAsCzqUCOXK609nTGzd1wiIjRJfrGFQbPBornkk=;
 fh=GodexM9FIVDdB1onryv8arwRPgNIIZj6AlbRJHptWss=;
 b=aN21mz4SmpvII2icQYJH/1bEuApw1R/GOpxnwyWDGf7mOdfsGVHFAKyU3+OFG5NiQr
 WxLB+2DXJiU3rQBdZHFS4Nz6MS0KAfDgKdyCMzGydwkJlwwJwHbANc/QDjpEz17CBbDC
 e8rU/aU+HxmwzBtx/Y9vhKLeWPzsJ7/VG/lR0Atj/W99rma+Mp7tHu3axJWPyyzWsgpH
 JE9U3R+r1aE0LQETNnz9/pxuwv45gFG9Q4ns7PQ44KcrjBw8vPMfncbn3/dBOPwRdFiw
 qJD9jUHC2tIAg6aqXqflr4GylR5FCjRmCleHtDqlyhfSd4Nd8Qu9BS2rKREYDdtUfZ7j
 U8wQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784037358; x=1784642158; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pg63fAsCzqUCOXK609nTGzd1wiIjRJfrGFQbPBornkk=;
 b=d/Io6Co3b4ruBqAeJzXhbWKULYh0mcfIN/jxp5j71YSshrpvGNb31OuBu7wcgV48Le
 ncCVe3bjSPpsHdIRI4nwSNkf9HIYLUMg2wamw10avqG7KdoccBVt0Ze7VA1SmoejAGQn
 lH8uLvH3I89vDWI7LTWUl3cyFoNOIU/YDs8Wsm7TGb70Xj3/t8BpiXJJkoCChK+hvGjo
 hIsLSRGrNQY3RSQIiofdXeeYsBm0Ibjbjlt4dpHA2zbFiTx4w5NgXyrlOFB5TNzl5Gkf
 svoVlTKXqBtjLOg/1CkNWwnYNyaN2mOPTLGL0PRZvaDhHDOoFxi6mG4o8t0ShMHUf0XD
 Tuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784037358; x=1784642158;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pg63fAsCzqUCOXK609nTGzd1wiIjRJfrGFQbPBornkk=;
 b=qMnqgHzr/6gBVS1x2IfOK7jL77wBPbrdZ/NOk/IRvSEbVaT5A4zh1q6pRhE5dwRlsJ
 2SjM698NqFT2SpPUpPJXc+J6S+NykFaqrTJDOMocmNhEkv4JSUT1+SE2RwvzkIa5cEyw
 uWqbE3KSvwfFcAjbHj1RLkcJSTUl0Ws2PWEnv7QP1rktH0fB9s0G25mR0ZZciAA/9zi+
 5y2d6kKoPiL9CHXv1PL9YiEMV9eeFwmrYBySRUqW4+HMjeNIU5U3Qh/FpQ/AHq1AVlti
 oPxkoNEUV8IJ1tz5M/hZFPFFbrAuuCzHp9xREV9OVcb2cgCCxN29V9EklkVJX7EqEYNX
 SBig==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAcsrt9GhSLxY5WmAJOHKiZGnh9E2blgv6WHvKiACQf4kQo4B65Pu6VI1geOB2CDP0p4XhjjKc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzASru3mMjonntKA1Guzyn8A9/GX/vrDOWCjXjn7unQG/ne+qdx
 vjBp2qqJ6ckJE5GBDcmhhjNLDqTxINFY7gGa7L7vaKekfEooA5Rfp8p+5wZAjRecVzkTe4prKlH
 iO9ERxqJqGO3ZB6K4UjjaQX5eRJOE2bA=
X-Gm-Gg: AfdE7cnWdfYFoC8402q+IUsAyMjZE/jjjKfOg1ZRmAX6jkEkilvgk4ovhIfzhDoOKay
 peblPv+4UHE31BlPgZ3GlEtme3NWtw4y0M20bdul4/vbhVTuDAQaqs7s4VJksEN4wSWJwhwWkjF
 9DOFiXArwJr4SHMp/nyHTa80+pwITmC4Ww7pv2lWMikOmSV0uvRZxUAJJsYCB7mYtOqUiFHDNA1
 nAexKNwiW3S9vE+l9PMp0TXTjLKfIonvX8LG4lxamtTJlQwZPP82oeHQInN8ksd82xncjAFdX10
 AwlG3cpinyCh55knv27YNVXzglEVfgI9817XN5b4xk1vnB3vY2UCXSt5f8PDpbZUUIQKnA==
X-Received: by 2002:a05:6a20:7287:b0:3bf:95f4:dacf with SMTP id
 adf61e73a8af0-3c110b15ba3mr10092073637.7.1784037357821; Tue, 14 Jul 2026
 06:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260713203850.650426-1-alexander.deucher@amd.com>
 <IA0PR12MB820888C41AF05BAA5C2CA57090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <3656074a-1a01-49f6-8f7c-129ab379f129@amd.com>
 <IA0PR12MB8208F00938342B8FD8377E0090F92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <9d575350-c3a2-4e9c-b842-b2a68678914e@amd.com>
 <IA0PR12MB8208EB469D4C2403243D321C90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
In-Reply-To: <IA0PR12MB8208EB469D4C2403243D321C90F92@IA0PR12MB8208.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Jul 2026 09:55:46 -0400
X-Gm-Features: AUfX_my2wCxGnkf944ACL0YRnwf9Ptk5qhqbv0X0tOscPaLJgdutZSFZf5mIAeI
Message-ID: <CADnq5_PbxvfpjCDQKyeySp1fipA12YduN2t7XzgE7iacc1v-Rg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liang,
 Prike" <Prike.Liang@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
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

On Tue, Jul 14, 2026 at 9:49=E2=80=AFAM SHANMUGAM, SRINIVASAN
<SRINIVASAN.SHANMUGAM@amd.com> wrote:
>
> AMD General
>
> > -----Original Message-----
> > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Sent: Tuesday, July 14, 2026 4:02 PM
> > To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd=
.com>
> > Subject: Re: [PATCH] drm/amdgpu/userq: properly account for resets
> >
> >
> >
> > On 14-Jul-26 3:57 PM, SHANMUGAM, SRINIVASAN wrote:
> > > AMD General
> > >
> > >
> > >
> > >
> > > Get Outlook for Android <https://aka.ms/AAb9ysg>
> > >
> > > ---------------------------------------------------------------------=
-
> > > --
> > > *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> > > *Sent:* Tuesday, July 14, 2026 3:14:34 PM
> > > *To:* SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
> > Deucher,
> > > Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedesktop.org
> > > <amd-gfx@lists.freedesktop.org>
> > > *Cc:* Liang, Prike <Prike.Liang@amd.com>; Khatri, Sunil
> > > <Sunil.Khatri@amd.com>
> > > *Subject:* Re: [PATCH] drm/amdgpu/userq: properly account for resets
> > >
> > >
> > >
> > > On 14-Jul-26 10:16 AM, SHANMUGAM, SRINIVASAN wrote:
> > >  > AMD General
> > >  >
> > >  >> -----Original Message-----
> > >  >> From: Alex Deucher <alexander.deucher@amd.com>  >> Sent: Tuesday,
> > > July 14, 2026 2:09 AM  >> To: amd-gfx@lists.freedesktop.org  >> Cc:
> > > Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,  >>
> > > SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike  >>
> > > <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>  >>
> > > Subject: [PATCH] drm/amdgpu/userq: properly account for resets  >>  >=
>
> > > We need to increment the reset counter, force fence completion, and
> > > set the  >> wedged event when a user queue is reset.
> > >  >>
> > >  >> mes_userq_reset_queue() handles this for collateral damage, but
> > > the caller needs  >> to handle this directly for the original guilty
> > > queue.
> > >  >>
> > >  >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>  >> Cc:
> > > Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>  >> Cc: Prike
> > > Liang <Prike.Liang@amd.com>  >> Cc: Sunil Khatri
> > > <sunil.khatri@amd.com>  >> ---  >>
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-  >>   1 file
> > > changed, 6 insertions(+), 1 deletion(-)  >>  >> diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > >  >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > >  >> index 6aa75da27f912..5e1262636e1e9 100644  >> ---
> > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > >  >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > >  >> @@ -146,8 +146,13 @@ static void
> > > amdgpu_userq_hang_detect_work(struct
> > >  >> work_struct *work)
> > >  >>                                                         queue,
> > > NULL, NULL);  >>                else  >>                        r =3D
> > > userq_funcs->reset(queue);  >> -             if (r)  >> +
> > > if (r) {  >>                        gpu_reset =3D true;  >> +
> > > } else {  >> +
> > > atomic_inc(&adev->gpu_reset_counter);
> > >  >> +
> > > amdgpu_userq_fence_driver_force_completion(queue);
> > >  >> +                     drm_dev_wedged_event(adev_to_drm(adev),
> > >  >> DRM_WEDGE_RECOVERY_NONE, NULL);
> > >  >> +             }
> > >  >>        } else {
> > >  >>                gpu_reset =3D true;
> > >  >>        }
> > >  >
> > >  > After the original queue was reset successfully, it did not update
> > > gpu_reset_counter, complete its pending fences, or send the wedged ev=
ent.
> > >  > mes_userq_reset_queue() already updates gpu_reset_counter,
> > > completes the pending fences, and sends the wedged event for the othe=
r
> > > affected queues,  > but skips the original queue because it has
> > > already been reset.
> > >
> > > What is the rationale of sending multiple device wedged events on a
> > > per queue basis?
> > >
> > > The question of whether drm_dev_wedged_event() should be emitted once
> > > per queue or once per overall recovery seems like a broader design
> > > discussion.
> > >
> >
> > Along with that, also need to consider if device reset_counter needs to=
 be
> > incremented on a per queue basis or based on reset event recovery. It c=
ould get
> > incremented multiple times inside this - mes_userq_reset_queue.
>
> Looking at the current flow, both gpu_reset_counter and drm_dev_wedged_ev=
ent() are updated once for each successfully reset queue. It would be helpf=
ul to clarify whether they are intended to be updated per affected queue or=
 once per overall recovery.
>

What are the semantics around the reset counter and wedged events?
Presumably each should be incremented for each queue that is reset? If
a hang affects multiple queues shouldn't each be a separate "reset"?
In the most common case, there should just be one since queue reset
should be able to reset just the guilty queue.

Alex

> Thanks,
> Srini
>
> >
> > Thanks,
> > Lijo
> >
> > > Thanks,
> > > Srini
> > >
> > >
> > >
>
