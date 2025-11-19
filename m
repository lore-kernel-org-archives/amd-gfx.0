Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A283DCF34C3
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Nov 2025 15:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A87C10E246;
	Wed, 19 Nov 2025 15:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NM3KYLbU";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DDF710E246
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 15:16:47 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7ba92341f07so379339b3a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Nov 2025 07:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763565407; x=1764170207; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RxXp5Z1lD1WGFsysr/lgHnvY0dZ1CjYPt9VNL5XVkuU=;
 b=NM3KYLbUzlIdhJuJfrPsMXc8Av0wN/zczCGAYjXul4bFz9jr9HKo6NSG6AKWSbEEtA
 kd75BCKdnK6dJSycKg5z1+AEG0C76Oo0bfFpqLzY/HFUu7CcFDpdxGdntcHWEhySutUP
 fknoPObj/RB1DRSG5bUUd0LMg74q6iPbemUlG7B3nwDQ5totVCI2ZwiPQJmNwa8bli1d
 nHvmkNeytZvS8BXW4wFPv8IuFZlfTcAFLeBGQJ226ihn6oF9li0vwcpYY9Zc78/Ki5OQ
 LqqVF+oBJ7dNDvsE2KVLv2E3kqTOXtCSPCaOjoCtDdWGzP/6p+j5QLvQxXAw+YYwUidy
 HPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763565407; x=1764170207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RxXp5Z1lD1WGFsysr/lgHnvY0dZ1CjYPt9VNL5XVkuU=;
 b=jH2/mt0w+81VA3ooHq2SnCdeLadW4SOmwAzpbcE6Q2pe/uKc8q4SABBORZZ7LpDPGF
 s9K8L0Sh3nxK4RV2JKHmjz/Utw482M7c++BOT0qA4J+YZXI9tej+HrUl2vxNEZ/kN7Ng
 NfumJSek8yEdnR3f21ZMAE28+uyTYJX0qwYrgh+2UMp0bko9R0o5mpIAkyWdiFSK6vwG
 WlZ0Gcq0Sj4yfMYPVE6gYrlDO0TZSIOHO0yoDXIjCNztbr7A3q+6zJYYZM8EbI2gI3T6
 10C9uuAYML6LwbSStuhUy88fHFVruuWfcpOehX558pwMALC9snuI+FcsCUnWxHx6uqOj
 w0jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Fkgx/ujY8QA4txmz1mdaIY7UTIvWFQ2rCXhqaMzf8mtjjoQ6aLHZHYk4m7zr4n0yVZKXx48L@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjFbeqKsqKWh6n7df2zDy5XakiTdOQ8JoLQZRl16IaHXt4kp9C
 Rd0BZGKQ6wt4dZfC2NdOWuqQeGyo1hv94Loe8YLsq174ZGrBbddB+fVUwtgqgU9cQBE9IGkhHRI
 VblXqSeqrFZJkOLNUeXiAm/0koLMIt2U=
X-Gm-Gg: ASbGncvWX545GcC0xnUDiZbCrpKf1gNWs5yeqHtdnQWfvbVLThPAyzDqLLzCRjyHqie
 cXM3+iZZCkODTG7CzVGgrxFci/cymDwgCo2/6TUUkQUdJ13PIvtzg+4VA9b+pbLQkUKRPcoOYnG
 zA1bShnOiwNSn+OWz23QCkm6FwMFqfPPRv/l4UCHl435adkBaZF+PWDo74wWiYNEYqPh3V2qY2o
 ltsuqA3yd3rkrPucY0csjXlSTPY/TKsF6KOI7gkZUdLRNN9Infyzm503n1yRZncnhdAC76E5FVq
 a95odw==
X-Google-Smtp-Source: AGHT+IEEpKUujw/SeN2UIzMJsmmhIcOXgKKgC6gxWPN7z3B05iaYYk5WQIDVTGTPuuxguLuIZjPlNYB1H2UtUhb9Yoc=
X-Received: by 2002:a05:7022:b886:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-11c791120b7mr1336862c88.2.1763565406502; Wed, 19 Nov 2025
 07:16:46 -0800 (PST)
MIME-Version: 1.0
References: <20251118220637.3594610-1-alexander.deucher@amd.com>
 <264534d7-86cc-4964-8225-07a32e2373cd@damsy.net>
In-Reply-To: <264534d7-86cc-4964-8225-07a32e2373cd@damsy.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Nov 2025 10:16:33 -0500
X-Gm-Features: AWmQ_bl9Oit5xydVFMFMd6waWq-xCgOV1Gktd2dakxSHwArbyoEhak61Iz96CiE
Message-ID: <CADnq5_PZr7Ce4weM1zc+CnwREM6A2=e57QBKBsbkm0s4theseg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gmc11: add amdgpu_vm_handle_fault()
 handling
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
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

On Wed, Nov 19, 2025 at 3:14=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric@damsy.net> wrote:
>
>
>
> Le 18/11/2025 =C3=A0 23:06, Alex Deucher a =C3=A9crit :
> > We need to call amdgpu_vm_handle_fault() on page fault
> > on all gfx9 and newer parts to properly update the
> > page tables, not just for recoverable page faults.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 27 +++++++++++++++++++++++++=
+
> >   1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v11_0.c
> > index 7bc389d9f5c48..25cdcb850416c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > @@ -103,12 +103,39 @@ static int gmc_v11_0_process_interrupt(struct amd=
gpu_device *adev,
> >       uint32_t vmhub_index =3D entry->client_id =3D=3D SOC21_IH_CLIENTI=
D_VMC ?
> >                              AMDGPU_MMHUB0(0) : AMDGPU_GFXHUB(0);
> >       struct amdgpu_vmhub *hub =3D &adev->vmhub[vmhub_index];
> > +     bool retry_fault =3D !!(entry->src_data[1] & 0x80);
> > +     bool write_fault =3D !!(entry->src_data[1] & 0x20);
> >       uint32_t status =3D 0;
> >       u64 addr;
> >
> >       addr =3D (u64)entry->src_data[0] << 12;
> >       addr |=3D ((u64)entry->src_data[1] & 0xf) << 44;
> >
> > +     if (retry_fault) {
> > +             /* Returning 1 here also prevents sending the IV to the K=
FD */
> > +
> > +             /* Process it onyl if it's the first fault for this addre=
ss */
>
> typo: onyl -> only (same for patch 2/3)

Fixed locally.  thanks!

Alex

>
> Pierre-Eric
>
>
>
> > +             if (entry->ih !=3D &adev->irq.ih_soft &&
> > +                 amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry=
->pasid,
> > +                                          entry->timestamp))
> > +                     return 1;
> > +
> > +             /* Delegate it to a different ring if the hardware hasn't
> > +              * already done it.
> > +              */
> > +             if (entry->ih =3D=3D &adev->irq.ih) {
> > +                     amdgpu_irq_delegate(adev, entry, 8);
> > +                     return 1;
> > +             }
> > +
> > +             /* Try to handle the recoverable page faults by filling p=
age
> > +              * tables
> > +              */
> > +             if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr=
,
> > +                                        entry->timestamp, write_fault)=
)
> > +                     return 1;
> > +     }
> > +
> >       if (!amdgpu_sriov_vf(adev)) {
> >               /*
> >                * Issue a dummy read to wait for the status register to
