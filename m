Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A24BCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E093F112EDB;
	Mon,  1 Jun 2026 07:27:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KaFcxR+V";
	dkim-atps=neutral
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com
 [209.85.160.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4C2E10E10D
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 May 2026 12:51:24 +0000 (UTC)
Received: by mail-oa1-f47.google.com with SMTP id
 586e51a60fabf-43b7e186a0cso2603372fac.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 May 2026 05:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780145483; cv=none;
 d=google.com; s=arc-20240605;
 b=XLUF2ZOeYb5hu7X7/FTEsZWjZyUwXGrtkh2L98sr3DqJJvss3aBPGfEnPS4BWOBa1x
 ghnHOCAp2sn2qWGHjZKBDK57sMNIqY3o2Sc+CIGaDpLrw5/IqA3AXaaGtpUZdXBRbd54
 RcagqiPNdSbVBMJA0FBD3tDNYzBQkN7MpAtzTl2AwmZ4FxA4FErzaUe1t0H+unmzJ5ut
 7be0TShhm5U/c2nNQNmqN1LmU1dnwjrbS2M7fNVipBx8arr7ok6ZjiL2r5Go6g0EUwzK
 h53F7Ap98ZcFWVAkUtAYxM5MFpflwNY3s/ab3JIJrXzghGjsnsN3/TgGS0qfEvrXa8Fh
 J19w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=3A/dvjO6Xz0UeZnJkZnw68G7gu0kDizyypSKA1X9AYI=;
 fh=MmtVxSUe2WT0S+P/SDBVuCrs+InDkDRLIPbo+aKPf00=;
 b=Wd7gf8cwaaM6n8QH5X49nzANQcpkkK8GDhDeY3z0xlOMWptT7odEKefpBcFnKXNWlo
 +KxNiKeVpmuFG4hjpnjWp4HKZ+V0tiNT0Q3BsYd8oGQP2gH9LyoMqYJgjWFQKCvbm9vd
 22meRjIa4DY6EAKYk+/BwnOlaWIscW8dnF6+YNtCtOq6VroPOySbEJKQaobKMNhKFYx6
 Ol5m9sKDG/QZEFLUcFeao5rweVUZEyjYOA1Sr+daJIU7WugEpg5BZ5yItXxlpF+6eyBf
 F79vc15J7hVbbGN9+OHMrXqUtGGJ1Myr3/8i89NsiA6DMC37ol2ktFSYC9YmNo73C9Ut
 wvOQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780145483; x=1780750283; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3A/dvjO6Xz0UeZnJkZnw68G7gu0kDizyypSKA1X9AYI=;
 b=KaFcxR+VeKxlzZNwPSioe0XkDECsJPz4yK/+KA6+YxBYH1fS2G/ztvO5e+COwtU/kE
 Ti7ZfvBtZKsQ2Q+K1MfgetJDxeYNV7kHC6Rxoge7jCRA2dAyuLw6hR6qS5snAa3ng7ne
 hBOF+JqB0M9aQES2nOjKG8+tF7Td+zAMySsrmdLN37d5pqoZcyl7Hcb7I9GPIQk36jho
 bCStgcpNqJLQcX8uGIYlhlVNZtE1SVvEsiS84n/dZuW2vtZ4eTigNpSfcIWimhPsRuLv
 VQlzEhyRqLpy63+vUwKmjAiNIuh8wwRwHRvtnT4kdEGXPLOYjpwiHrIZCGKXHAxzIsni
 AcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780145483; x=1780750283;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3A/dvjO6Xz0UeZnJkZnw68G7gu0kDizyypSKA1X9AYI=;
 b=Z6zd6NhS9ExNDdGb8UQOR9YEhpsCd0/rMCStRfv2a73ZdEATtAWJI8x4+c1gYVe64c
 bqGLD32cjK9exi8oe3o5Tg2P29mQNb1iL3uFA2kO3uFn932Nu8pUbCN17eNJcKcZZi1u
 t3HpRSf27p2JF6bKbQKnCPMqC2EjQQB5JoPcCVwvxz4+Fp2yrwiu0kV3bqVxglYBixEe
 CdpbSsKEBTC5Tutfd5gsvI9+wGpS8qBBvIO6TfBTWfrTQjKF1kgi8b26UYeGWw5CUUnF
 s0sbESzqiz1ZaBDe8g8lsQYDzXkZg7EFGPmMoWI12GmUbaux8Vvnu9+DgwiAyp4bkt8q
 KHcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ86DhieMuit32UUTMtiyLcbsUM+By5X8+H6bN+JKUmYz1U8xheSrAhRO4ZXJlPV14w4E/tZUQZz@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywjo6YMPj1BZAQEWIttPDnI9/EPRR/gXnEy/7iqsuFmXk10/jWv
 FPDTvDGaaKdq4W5HOe6IswSg85U/Ag+jYawSfXdkROohGEk94UVZKw33X7J4OGoUcmyjsVtBwtg
 PDuD6dYJXMn0A8ZxLgsBuOAcx8ReWdAU=
X-Gm-Gg: Acq92OGQCyTOmmbZIE2ngyZEOS22HMNb4TZC9Kh5jrfSxxQlwEzww+TtqIbLeK9zGWq
 J37h6wIAjL6KStYuw3AN6tkF52D6LtV6DubepylHF8E8GgMwpkpBNwRgsXgZEhkxYHrjrD4QSur
 RzzM4oDZGuEuli3vpiR203V021wus15n3WI9KYzEfKUkbOT1DiMGj9i3aF2Xrf1xm1xtGN+KFrs
 5Vqbx3DQ6a4FGvCsN1CH/l+RlK079e7LaUwv4QB0KONfSvC284VFpKQlRdGOVtxyuc9fipOk6oc
 auZsehAoNvw/e+FNG03T5QxK2IyZ57WOMohq/mwZ7XLL+ygDAuf8qmWtF2fLsKg=
X-Received: by 2002:a05:6871:3a28:b0:42b:d6a3:7c49 with SMTP id
 586e51a60fabf-43ca4241d3dmr1945707fac.17.1780145483066; Sat, 30 May 2026
 05:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260519084158.72960-1-timur.kristof@gmail.com>
 <BL1PR12MB51440DCA164ED993EA5FAFBFF7162@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CAOGA6HgfUjbT9wKU1Baz3QXFsDaRTEUd8WCrRQn2D5Fh8REEbg@mail.gmail.com>
 <4899616.vXUDI8C0e8@timur-max>
In-Reply-To: <4899616.vXUDI8C0e8@timur-max>
From: Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Date: Sat, 30 May 2026 14:51:11 +0200
X-Gm-Features: AVHnY4KsfaPlskrn3TapYcDfI6AfggHpJZ8X32hB0GUE-0X7rA_g56N13fy-LzA
Message-ID: <CAOGA6Hj5q2uhb8ka2jNhBfDk7pX2NfJO2gcxzOb8VC1gPLxL1A@mail.gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000002ab1940653086b5c"
X-Mailman-Approved-At: Mon, 01 Jun 2026 07:27:37 +0000
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

--0000000000002ab1940653086b5c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested your patch without the ATOM_PP_PLATFORM_CAP_HARDWAREDC early exit
and saw the same behavior. Looks like it's a mutex issue:
both amdgpu_pm_acpi_event_handler and the modified
si_notify_hw_of_powersource are attempting to lock the power manager mutex
on the same thread.

On Sat, May 30, 2026 at 12:32=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@=
gmail.com>
wrote:

> On 2026. m=C3=A1jus 30., szombat 12:07:12 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Jeremy
> Klarenbeek
> wrote:
> > Thanks everyone.
> >
> > > My suggestion would be to call pm_compute_clocks() inside
> notify_ac_dc()
> >
> > I tried this patch and it's not working.
>
> Of course not. It wouldn't work without also inverting the HARDWAREDC
> check.
>
> > The specific behavior I see:
> > 1. Clocks do not respond to plugging/unplugging. Always idle.
> > 2. Severe system stability issues. After opening a process that uses th=
e
> > AMDGPU, opening any more GPU processes (glxgears, radeontop, etc.) hang=
s
> > forever during init. The system hangs while shutting down and requires
> > force power off.
> > 3. This message is seen in dmesg. Not sure if it's related.
> > [  151.684427] amdgpu 0000:01:00.0: bo 00000000c5a63ba0 va
> > 0x000010cb00-0x000010cb53 conflict with 0x000010cb44-0x000010cb45
> >
> > > Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary on
> your
> >
> > laptop?
> > Yes, without sending this message, the SMC switches to idle speeds
> instead
> > of AC/performance speeds. Unplugging the laptop ironically makes it clo=
ck
> > back up instead of down. This fix was found while reverse engineering t=
he
> > SMC and confirmed by the clock speeds beginning to rise after
> implementing
> > the message. Commenting out just the one line that sends the message
> undoes
> > the fix.
> >
> > > the ATOM_PP_PLATFORM_CAP_HARDWAREDC check is inverted
> >
> > I've implemented this into my branch. Thanks for checking.
> >
> > Here is the current state, still a 6th commit on top of the original
> series
> > of 5: https://github.com/luisfonsivevo/linux/commit/083a2bbe81d6for
> > applyingfdc670b5890de661a3bdd42e9b80
> > <
> https://github.com/luisfonsivevo/linux/commit/083a2bbe81d6fdc670b5890de66=
1a
> > 3bdd42e9b80>
> >
> > This has been working reliably for a week without any problems and I'd =
be
> > happy to submit it if there are no objections. A separate commit will b=
e
> > needed to apply this to SMU7.
> >
> > On Fri, May 29, 2026 at 10:33=E2=80=AFPM Deucher, Alexander <
> >
> > Alexander.Deucher@amd.com> wrote:
> > > AMD General
> > >
> > > I dug into this a bit more and the ATOM_PP_PLATFORM_CAP_HARDWAREDC
> check
> > > is inverted.  Switching that should fix it.
> > >
> > > Alex
> > >
> > > ------------------------------
> > > *From:* Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > *Sent:* Sunday, May 24, 2026 7:32 AM
> > > *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>;
> > > Deucher, Alexander <Alexander.Deucher@amd.com>; Jeremy Klarenbeek <
> > > jeremy.klarenbeek99@gmail.com>
> > > *Subject:* Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
> > >
> > > Hi Jeremy & Alex,
> > >
> > > > Apologies for my late reply. I tested the patch series (SI laptop
> > > > 1002:6606) and the problem remains where the clock speeds don't boo=
st
> > >
> > > upon
> > >
> > > > switching to AC. Timur and I investigated this and found 2 problems
> > >
> > > Thanks for getting back to us on this topic.
> > > At Alex's suggestion, I removed the clock recalculation and added the
> > > check to
> > > verify ATOM_PP_PLATFORM_CAP_HARDWAREDC. I'm sad to hear that this bro=
ke
> > > your
> > > patches. I apologize for that.
> > >
> > > Unfortunately I don't have a SI laptop GPU to test this stuff, so the=
re
> > > was no
> > > way for me to verify the correctness of those changes before I sent t=
he
> > > patches to the mailing list.
> > >
> > > > 1. It seems that it is necessary after all to recompute clock speed=
s
> > > > when
> > > > toggling AC/DC. Sending PPSMC_MSG_RunningOnAC on its own has no
> effect.
> > > > Each ASIC family's apply_state_adjust_rules appears to be responsib=
le
> > > > for
> > > > the switch by setting the max_limits, and this function is only
> called
> > > > as
> > > > part of computing clocks.
> > >
> > > That's right. I took another look at:
> > > si_apply_state_adjust_rules()
> > > smu7_apply_state_adjust_rules()
> > >
> > > Both of these rely on adev->pm.ac_power when determining max_limits,
> and
> > > they
> > > set the maximum clocks accordingly. We should indeed re-calculate the=
se
> > > clocks
> > > on both SI and SMU7 when there is an AC/DC switch to make sure to app=
ly
> > > the
> > > updated max_limits. Additionally I think we should probably lock the
> > > mutexes
> > > to ensure that we are sending only one message at a time.
> > >
> > > My suggestion would be to call pm_compute_clocks() inside
> notify_ac_dc(),
> > > and
> > > also to lock the mutexes:
> > > https://gitlab.freedesktop.org/Venemo/linux/-/commit/
> > > e98279dff480cc297cbb1fe50c2b71ebd65b9576
> > >
> > > if that works, I'd like to submit that patch (and will also port it t=
o
> > > SMU7).
> > >
> > > > I'm considering removing the .notify_ac_dc field
> > > > from the IP block entirely and just calling .pm_compute_clocks from
> > > > amdgpu_pm_acpi_event_handler, but I only know for certain that this
> > > > works
> > > > for my GPU.
> > >
> > > I don't agree with that. amdgpu_dpm is generic between all supported =
HW
> > > generations and shouldn't contain HW generation specific code. Also, =
it
> > > clearly
> > > doesn't work the same way on every GPU generation, so we shouldn't
> > > generalize.
> > >
> > > Furthermore, we should minimize the amount of messages we send to the
> SMU,
> > > so
> > > we shouldn't send the RunningOnAC message every time we recompute the
> > > clocks,
> > > only when it actually switches to AC.
> > >
> > > > 2. The ATOM_PP_PLATFORM_CAP_HARDWAREDC flag is enabled for my GPU,
> > >
> > > causing
> > >
> > > > PPSMC_MSG_RunningOnAC to never be sent. Either the flag is enabled
> > > > erroneously, or we're interpreting its intended usage incorrectly.
> > >
> > > It's hard to judge that without having access to the hardware or docs=
.
> > > Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary on
> your
> > > laptop? Isn't it enough to just re-compute the clocks?
> > >
> > > Can you check what exactly is the value of adev->pm.dpm.platform_caps
> on
> > > your
> > > laptop? Maybe we are looking at the wrong flag, or maybe the HARDWARE=
DC
> > > flag
> > > only refers to the AC->DC transition and not the DC->AC transition.
> > >
> > > This is just guesswork on my part, but maybe we should look at the
> > > SBIOSPOWERSOURCE flag instead, which is explained in pptable_v1_0.h:
> > > /* This cap indicates whether power source notificaiton is done by
> SBIOS
> > > directly. */
> > > Can you check if this flag is set on your laptop?
> > >
> > > Thanks & best regards,
> > > Timur
>
>
>
>
>

--0000000000002ab1940653086b5c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I tested your patch without the ATOM_PP_PLATFORM_CAP_HARDW=
AREDC early exit and saw the same behavior. Looks like it&#39;s a mutex iss=
ue: both=C2=A0amdgpu_pm_acpi_event_handler and the modified si_notify_hw_of=
_powersource are attempting to lock the power manager mutex on the same thr=
ead.<br></div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, May 30, 2026 at 12:32=E2=80=AFPM Timu=
r Krist=C3=B3f &lt;<a href=3D"mailto:timur.kristof@gmail.com">timur.kristof=
@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On 2026. m=C3=A1jus 30., szombat 12:07:12 k=C3=B6z=C3=A9p-eur=C3=
=B3pai ny=C3=A1ri id=C5=91 Jeremy Klarenbeek <br>
wrote:<br>
&gt; Thanks everyone.<br>
&gt; <br>
&gt; &gt; My suggestion would be to call pm_compute_clocks() inside notify_=
ac_dc()<br>
&gt; <br>
&gt; I tried this patch and it&#39;s not working.<br>
<br>
Of course not. It wouldn&#39;t work without also inverting the HARDWAREDC c=
heck.<br>
<br>
&gt; The specific behavior I see:<br>
&gt; 1. Clocks do not respond to plugging/unplugging. Always idle.<br>
&gt; 2. Severe system stability issues. After opening a process that uses t=
he<br>
&gt; AMDGPU, opening any more GPU processes (glxgears, radeontop, etc.) han=
gs<br>
&gt; forever during init. The system hangs while shutting down and requires=
<br>
&gt; force power off.<br>
&gt; 3. This message is seen in dmesg. Not sure if it&#39;s related.<br>
&gt; [=C2=A0 151.684427] amdgpu 0000:01:00.0: bo 00000000c5a63ba0 va<br>
&gt; 0x000010cb00-0x000010cb53 conflict with 0x000010cb44-0x000010cb45<br>
&gt; <br>
&gt; &gt; Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary=
 on your<br>
&gt; <br>
&gt; laptop?<br>
&gt; Yes, without sending this message, the SMC switches to idle speeds ins=
tead<br>
&gt; of AC/performance speeds. Unplugging the laptop ironically makes it cl=
ock<br>
&gt; back up instead of down. This fix was found while reverse engineering =
the<br>
&gt; SMC and confirmed by the clock speeds beginning to rise after implemen=
ting<br>
&gt; the message. Commenting out just the one line that sends the message u=
ndoes<br>
&gt; the fix.<br>
&gt; <br>
&gt; &gt; the ATOM_PP_PLATFORM_CAP_HARDWAREDC check is inverted<br>
&gt; <br>
&gt; I&#39;ve implemented this into my branch. Thanks for checking.<br>
&gt; <br>
&gt; Here is the current state, still a 6th commit on top of the original s=
eries<br>
&gt; of 5: <a href=3D"https://github.com/luisfonsivevo/linux/commit/083a2bb=
e81d6for" rel=3D"noreferrer" target=3D"_blank">https://github.com/luisfonsi=
vevo/linux/commit/083a2bbe81d6for</a><br>
&gt; applyingfdc670b5890de661a3bdd42e9b80<br>
&gt; &lt;<a href=3D"https://github.com/luisfonsivevo/linux/commit/083a2bbe8=
1d6fdc670b5890de661a" rel=3D"noreferrer" target=3D"_blank">https://github.c=
om/luisfonsivevo/linux/commit/083a2bbe81d6fdc670b5890de661a</a><br>
&gt; 3bdd42e9b80&gt;<br>
&gt; <br>
&gt; This has been working reliably for a week without any problems and I&#=
39;d be<br>
&gt; happy to submit it if there are no objections. A separate commit will =
be<br>
&gt; needed to apply this to SMU7.<br>
&gt; <br>
&gt; On Fri, May 29, 2026 at 10:33=E2=80=AFPM Deucher, Alexander &lt;<br>
&gt; <br>
&gt; <a href=3D"mailto:Alexander.Deucher@amd.com" target=3D"_blank">Alexand=
er.Deucher@amd.com</a>&gt; wrote:<br>
&gt; &gt; AMD General<br>
&gt; &gt; <br>
&gt; &gt; I dug into this a bit more and the ATOM_PP_PLATFORM_CAP_HARDWARED=
C check<br>
&gt; &gt; is inverted.=C2=A0 Switching that should fix it.<br>
&gt; &gt; <br>
&gt; &gt; Alex<br>
&gt; &gt; <br>
&gt; &gt; ------------------------------<br>
&gt; &gt; *From:* Timur Krist=C3=B3f &lt;<a href=3D"mailto:timur.kristof@gm=
ail.com" target=3D"_blank">timur.kristof@gmail.com</a>&gt;<br>
&gt; &gt; *Sent:* Sunday, May 24, 2026 7:32 AM<br>
&gt; &gt; *To:* <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"=
_blank">amd-gfx@lists.freedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a>&gt;=
;<br>
&gt; &gt; Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.co=
m" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Jeremy Klarenbeek &=
lt;<br>
&gt; &gt; <a href=3D"mailto:jeremy.klarenbeek99@gmail.com" target=3D"_blank=
">jeremy.klarenbeek99@gmail.com</a>&gt;<br>
&gt; &gt; *Subject:* Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-=
7<br>
&gt; &gt; <br>
&gt; &gt; Hi Jeremy &amp; Alex,<br>
&gt; &gt; <br>
&gt; &gt; &gt; Apologies for my late reply. I tested the patch series (SI l=
aptop<br>
&gt; &gt; &gt; 1002:6606) and the problem remains where the clock speeds do=
n&#39;t boost<br>
&gt; &gt; <br>
&gt; &gt; upon<br>
&gt; &gt; <br>
&gt; &gt; &gt; switching to AC. Timur and I investigated this and found 2 p=
roblems<br>
&gt; &gt; <br>
&gt; &gt; Thanks for getting back to us on this topic.<br>
&gt; &gt; At Alex&#39;s suggestion, I removed the clock recalculation and a=
dded the<br>
&gt; &gt; check to<br>
&gt; &gt; verify ATOM_PP_PLATFORM_CAP_HARDWAREDC. I&#39;m sad to hear that =
this broke<br>
&gt; &gt; your<br>
&gt; &gt; patches. I apologize for that.<br>
&gt; &gt; <br>
&gt; &gt; Unfortunately I don&#39;t have a SI laptop GPU to test this stuff=
, so there<br>
&gt; &gt; was no<br>
&gt; &gt; way for me to verify the correctness of those changes before I se=
nt the<br>
&gt; &gt; patches to the mailing list.<br>
&gt; &gt; <br>
&gt; &gt; &gt; 1. It seems that it is necessary after all to recompute cloc=
k speeds<br>
&gt; &gt; &gt; when<br>
&gt; &gt; &gt; toggling AC/DC. Sending PPSMC_MSG_RunningOnAC on its own has=
 no effect.<br>
&gt; &gt; &gt; Each ASIC family&#39;s apply_state_adjust_rules appears to b=
e responsible<br>
&gt; &gt; &gt; for<br>
&gt; &gt; &gt; the switch by setting the max_limits, and this function is o=
nly called<br>
&gt; &gt; &gt; as<br>
&gt; &gt; &gt; part of computing clocks.<br>
&gt; &gt; <br>
&gt; &gt; That&#39;s right. I took another look at:<br>
&gt; &gt; si_apply_state_adjust_rules()<br>
&gt; &gt; smu7_apply_state_adjust_rules()<br>
&gt; &gt; <br>
&gt; &gt; Both of these rely on adev-&gt;pm.ac_power when determining max_l=
imits, and<br>
&gt; &gt; they<br>
&gt; &gt; set the maximum clocks accordingly. We should indeed re-calculate=
 these<br>
&gt; &gt; clocks<br>
&gt; &gt; on both SI and SMU7 when there is an AC/DC switch to make sure to=
 apply<br>
&gt; &gt; the<br>
&gt; &gt; updated max_limits. Additionally I think we should probably lock =
the<br>
&gt; &gt; mutexes<br>
&gt; &gt; to ensure that we are sending only one message at a time.<br>
&gt; &gt; <br>
&gt; &gt; My suggestion would be to call pm_compute_clocks() inside notify_=
ac_dc(),<br>
&gt; &gt; and<br>
&gt; &gt; also to lock the mutexes:<br>
&gt; &gt; <a href=3D"https://gitlab.freedesktop.org/Venemo/linux/-/commit/"=
 rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.org/Venemo=
/linux/-/commit/</a><br>
&gt; &gt; e98279dff480cc297cbb1fe50c2b71ebd65b9576<br>
&gt; &gt; <br>
&gt; &gt; if that works, I&#39;d like to submit that patch (and will also p=
ort it to<br>
&gt; &gt; SMU7).<br>
&gt; &gt; <br>
&gt; &gt; &gt; I&#39;m considering removing the .notify_ac_dc field<br>
&gt; &gt; &gt; from the IP block entirely and just calling .pm_compute_cloc=
ks from<br>
&gt; &gt; &gt; amdgpu_pm_acpi_event_handler, but I only know for certain th=
at this<br>
&gt; &gt; &gt; works<br>
&gt; &gt; &gt; for my GPU.<br>
&gt; &gt; <br>
&gt; &gt; I don&#39;t agree with that. amdgpu_dpm is generic between all su=
pported HW<br>
&gt; &gt; generations and shouldn&#39;t contain HW generation specific code=
. Also, it<br>
&gt; &gt; clearly<br>
&gt; &gt; doesn&#39;t work the same way on every GPU generation, so we shou=
ldn&#39;t<br>
&gt; &gt; generalize.<br>
&gt; &gt; <br>
&gt; &gt; Furthermore, we should minimize the amount of messages we send to=
 the SMU,<br>
&gt; &gt; so<br>
&gt; &gt; we shouldn&#39;t send the RunningOnAC message every time we recom=
pute the<br>
&gt; &gt; clocks,<br>
&gt; &gt; only when it actually switches to AC.<br>
&gt; &gt; <br>
&gt; &gt; &gt; 2. The ATOM_PP_PLATFORM_CAP_HARDWAREDC flag is enabled for m=
y GPU,<br>
&gt; &gt; <br>
&gt; &gt; causing<br>
&gt; &gt; <br>
&gt; &gt; &gt; PPSMC_MSG_RunningOnAC to never be sent. Either the flag is e=
nabled<br>
&gt; &gt; &gt; erroneously, or we&#39;re interpreting its intended usage in=
correctly.<br>
&gt; &gt; <br>
&gt; &gt; It&#39;s hard to judge that without having access to the hardware=
 or docs.<br>
&gt; &gt; Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary=
 on your<br>
&gt; &gt; laptop? Isn&#39;t it enough to just re-compute the clocks?<br>
&gt; &gt; <br>
&gt; &gt; Can you check what exactly is the value of adev-&gt;pm.dpm.platfo=
rm_caps on<br>
&gt; &gt; your<br>
&gt; &gt; laptop? Maybe we are looking at the wrong flag, or maybe the HARD=
WAREDC<br>
&gt; &gt; flag<br>
&gt; &gt; only refers to the AC-&gt;DC transition and not the DC-&gt;AC tra=
nsition.<br>
&gt; &gt; <br>
&gt; &gt; This is just guesswork on my part, but maybe we should look at th=
e<br>
&gt; &gt; SBIOSPOWERSOURCE flag instead, which is explained in pptable_v1_0=
.h:<br>
&gt; &gt; /* This cap indicates whether power source notificaiton is done b=
y SBIOS<br>
&gt; &gt; directly. */<br>
&gt; &gt; Can you check if this flag is set on your laptop?<br>
&gt; &gt; <br>
&gt; &gt; Thanks &amp; best regards,<br>
&gt; &gt; Timur<br>
<br>
<br>
<br>
<br>
</blockquote></div>

--0000000000002ab1940653086b5c--
