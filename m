Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A88D1D495
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 20:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FD9010E223;
	Thu,  8 Jan 2026 20:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZWwgQU4l";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEFE610E223
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 20:46:56 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-121a15dacd1so284929c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Jan 2026 12:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767905216; x=1768510016; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ApZFie8VOTZeFKCdAbci02VHI8/8cEnu2T1arLcUg7c=;
 b=ZWwgQU4lJFgoCAk3deFvU/RaGG5Hs4J8kHsjR6aEJcab7PFFLCIvKgOy+UtiVcEmKK
 MH3S/J4EXR+TPDWiosuHxPOLTQwjkfnK8pPTBh1EqqGaLOCU2Zw+UPu3lMr9sLxNRXJu
 MKgcyXjw7BHgH8r9ZblGZ7QQhyXdjzYcnkw3FvAVthY3MteyRcB+DJua0TyavQV9jx8A
 9vFyQFCiKVtSoOCcvpTisRDZ2Fh2pTBqCvKAJm/THwwglUzQMFkNiR0H84m3whEoGH7w
 izDzvmIqhdV5ztCCZwTljxZMybUc3dnuTeGwetyJ2pNt5MAcueSJw9flZe0biZLTwm4v
 xFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767905216; x=1768510016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ApZFie8VOTZeFKCdAbci02VHI8/8cEnu2T1arLcUg7c=;
 b=mUa0jIXlQ4tVlgXuKvXxm+UUZx7U8jHbWsc4ywbQ0E+RUbhhtoLhppBfv3oSdzvGSL
 wpuYTxIdUwbQg4yZ1AQN/oYnMZkLDh45DpaTM+x2bcOHkwOF+5iitvoVR981GpXNCHhk
 qlgoK5HX/6OYiGaet4B9SFDv2Cru8MNK4fvaSHlO+iUytMHgn3MheiIsUl0DoUVUhmf2
 ilzQun3T9aYeQP1nDYbKwpxS5M8h5lDhgNgO/xisrnVg7+GOEhkTIB4bQU3mXsl/J+xq
 h/lq9dwZsRDg9y3B8K/DLr95vlL16Qk3sumuIqSUAkJnF7tBsqab5pMqL3uweTuK5fX1
 yjPw==
X-Gm-Message-State: AOJu0YwxjgztB4vcqponQcZXPqMWwDxFs7KNwLYv02bChkkhIK+wCOKx
 2OHPZI8yabtSVntEc6BmwLMjE/B8l6R0RG4OCcC2ORBh3TCBej2qbh1hz5KJCdU+HREZFVN3RmV
 UIVL77mOmZ2Sw2vv8REO/6CKBg3RNE9Y=
X-Gm-Gg: AY/fxX6dHqikNxnPjtZAfT5dY6+poT5vK/bhEj5io202fFzQTHd24QdYlpw1qOUjASK
 nSjCIML7lJinZ8MhGycYDEJMFsmZ9PKMuui0tYwt7TdojdkLm63mqj2am09geebqrlT2ETesw6M
 zzxM2ulmEsx2M5f+WHeKViODK3mgwaeJU6t2qvrvMBdy0DdjGW39tZuXV9AhXu4NoR+/1mdY/2R
 W9vOiJc+atYADHSgInI7H3tR7VbdnUHM/W6iGlnMX6/Ie4Yh0GEHV2YK9T0yWI0ZqAftTEG
X-Google-Smtp-Source: AGHT+IEGptn9xtrzU+PGdlREn91jQUHsh0m+6FrB9CWk5BhcLMj7hyXi48k8y809yhXWvGQA2E4AtfqLZ5JW6lL++N0=
X-Received: by 2002:a05:7022:6293:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-121f8abea5cmr4019435c88.2.1767905215640; Thu, 08 Jan 2026
 12:46:55 -0800 (PST)
MIME-Version: 1.0
References: <CAPEhTTGamEFapOA4pKgMQxDz9Go1k0QeGRkk5bR-X2jR+iBCcg@mail.gmail.com>
 <CADnq5_Mh7M=019sJ274GLtMyKDH5MSMfR=k6pVTS1z2DV1tQCw@mail.gmail.com>
 <CAPEhTTGJb85fP4iJXAWVkg+vai2xDi-76RFhbmuG0Gc-XT+dKg@mail.gmail.com>
 <CADnq5_PJ+1pJcoxGZPU3xv19nTac76e8bTi+rabfXCRmdnfcQw@mail.gmail.com>
 <CAPEhTTFMmvNHeCknvGbCo46fFv9vbKCov98Zn46b_mXZD25rSA@mail.gmail.com>
In-Reply-To: <CAPEhTTFMmvNHeCknvGbCo46fFv9vbKCov98Zn46b_mXZD25rSA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 Jan 2026 15:46:44 -0500
X-Gm-Features: AQt7F2qwgi57SriZE2QVlz-6o-90PiuFhzLIO-saXrxDuiaiUNgQtzxpdD2syf0
Message-ID: <CADnq5_OG-1rnj47hgSyx0+v2ehFzU8+MydPGb2c5P_jYNNF+9A@mail.gmail.com>
Subject: Re: SI - are power and voltage readings supported by the hardware
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>, 
 Alexander Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Tue, Dec 23, 2025 at 2:01=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Hi again Alex,
>
> First, a follow up on VDDCI. From some sources I've found, I
> understand that it would be the VDD at the interface. Which interface
> is unclear, but one source was referring to the voltage at the PCIe
> interface. Would that make sense?

I'm pretty sure it's the memory interface.  Power team said same thing
from what they can remember.

>
> Next, I'd like your thoughts and inputs on a project I'd like to work
> on (in fact, I've been working on it in the last few weeks already).
> I'd like to bring BACO on par with CI. I know there is a minimal
> implementation for reset purposes already present. I think it is

There is no BACO support in the driver for SI yet. The reset support
for SI doesn't use BACO.

> linked to the legacy dpm. And then, I'd like to go as far as possible
> in moving from the legacy DPM code to use the same (or similar) code
> path used by CI+. Do you think this could work?

You could port the existing SI dpm code to the powerplay code base
that is used by CI, but you can't reuse the CI code directly.  It
would need its own BACO sequence.  I should be able to dig that up for
you if you get to that point.

>
> Also, was SMU6 significantly different from SMU7? Looking at how the
> driver sends messages to SMU7 and 8, it looks like an iterative
> process where new messages/features were added to the previous SMU
> version. Can we expect SMU6 to work mostly like the two subsequent
> versions with a subset of their supported messages/features?

Sort of.  We've been iterating on SMU firmware interfaces since R7xx.
There are a number of differences.  We supported both SI and CI in
radeon with the same framework.  When we started amdgpu, we inherited
the radeon interface there too, but later ported CI to the powerplay
interface.  So it's doable.  You'll have to add smu6 equivalents of
smu7_hwmgr.c and smu7_smumgr.c, add powerplay table parsing, etc.  You
can reference the existing code bases in amdgpu and radeon.

>
> Finally, was SMU6 able to use any of the power tune features? CI is
> able to receive a request to use one of a few power profiles. Was this
> only available from CI or was it also present under SI?

The powertune stuff is already there.  For the profiles, do you mean
the PP_SMC_POWER_PROFILE_* stuff?  That was only available on SMU7.

>
> Thank you very much for your time and knowledge and have a great
> Holidays season.

Happy New Year!

Alex

>
> On Mon, Dec 8, 2025 at 9:32=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
> >
> > On Sat, Dec 6, 2025 at 11:30=E2=80=AFAM Alexandre Demers
> > <alexandre.f.demers@gmail.com> wrote:
> > >
> > > OK, I was hoping for a similar SMU7 implementation never completed.
> > >
> > > I see both VDDC and VDDCI (for Evergreen+) values available. When
> > > looking at amdgpu_pm_info, VDDC would be reported as VDDGFX I suppose
> > > (and inX_label under /sys/class/drm/cardX/device/hwmon/hwmonY/), isn'=
t
> > > it?
> >
> > Yes.
> >
> > >
> > > What would VDDCI correspond to? I mean, how should it be displayed
> > > (maybe it has its specific inX_label)?
> >
> > I don't recall off hand what voltage domain VDDCI was off hand.  I
> > think it may have been the memory interface.  I'll see if I can dig it
> > up.
> >
> > Alex
> >
> > >
> > > Cheers,
> > > Alexandre
> > >
> > > On Mon, Dec 1, 2025 at 10:26=E2=80=AFAM Alex Deucher <alexdeucher@gma=
il.com> wrote:
> > > >
> > > > On Sat, Nov 29, 2025 at 8:44=E2=80=AFPM Alexandre Demers
> > > > <alexandre.f.demers@gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > I was wondering if SI GPUs support reporting power and voltage va=
lues
> > > > > at the hardware level? I read somewhere that it was supported fro=
m
> > > > > GCN1.2 (Tonga and over), but I haven't found anything on prior
> > > > > generations. Going through the register names, I wasn't able to
> > > > > identify any who may correspond to power or voltage level.
> > > > >
> > > > > So I'm asking, just in case it is supported and I missed the
> > > > > information while searching for it.
> > > >
> > > > Correct.  There is no interface to query the power.  For voltages y=
ou
> > > > can look at mmTARGET_AND_CURRENT_PROFILE_INDEX to find out the curr=
ent
> > > > DPM level and then convert that into struct si_ps to look up the
> > > > voltages, similar to what is done for sclk and mclk.  See
> > > > si_dpm_read_sensor().
> > > >
> > > > Alex
