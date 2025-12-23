Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B89E6FE23
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Dec 2025 19:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D261610E1BE;
	Tue, 23 Dec 2025 19:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DSFkX4x6";
	dkim-atps=neutral
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D0610E1BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 19:01:28 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7c75387bb27so2196754a34.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 11:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766516488; x=1767121288; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsTm4zVnJd+kp8FjPCZsq6n3UIJXxTOWvu+rCMPU/c0=;
 b=DSFkX4x6xGHxjFwCrO8dG8Y6ZP1KGT8Vqg++KNw/FEhzm1Xd3daRnv+O+3jjWu8kMi
 +udQJitQIUhrTR76vmAD0s4hHHqlOKrCnGhS+puxahu3KsNGl/4SP7JJ7Ty7TVhI9hvk
 1Xgjf33nA8tgBCpr4Wk6V68oN1xL0PoW0ksZb56ccXn3dlCoa+9OJl6+KprBOUm1alpn
 mhviF21ETVZEiPHOHY0T2umy0kHiqASCrljKewXVVKjq1tnuIMC3MLUk8gaJUB7E6noZ
 PU3665Qe8uc1yXfxaPWJjhzeDLSGeY0QTX2ZjTI3+QCvA/BGvg8YpSM5wdiJolstBehY
 p7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766516488; x=1767121288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IsTm4zVnJd+kp8FjPCZsq6n3UIJXxTOWvu+rCMPU/c0=;
 b=rr8G2c6caVGYHeTomJb7XhG6CffGID6mKDj3koB3qYTHkfEq0bGMEpjewYRKuSSOlV
 4vq3MlwBy3HZ4RfOtXaXU3Y2zfUrCLT68dnS+p5AqSjxaz4sK7GoZbMkntfiw0/JAG55
 1gVjuw/PzXgoG1AmzWCj06QfeF05PW+txx+R6NxFFk965FpdewN9Z/ltNMy5OLjz4HlT
 MEqp5U233EeYJoNvAFrXGcBa8A5YwoplDlWxpfgzUTwWusGwopTDAOZFSGEQoGyh+MTX
 6ek7BegGGPpzsfOzrKD3qb7R72rYOjnOQqdt1XtToWTJK2wFXGV6yoGngAuNrI5EaxtU
 Nw0g==
X-Gm-Message-State: AOJu0YyRZk/iQjiB3ai8PS1f46EmJYQxSE3m/kyDXQ+Bi8tPpk6TkKmG
 M41Pz+b0V+EPve1j54+89InN2kG9R7i3lVZgOpTlb7bF3qniLdh4DCEpUW/OQbgDqDaR32k0B0b
 bsh+36cF+WNB1ZhYJxtu5qG2RlQt825I=
X-Gm-Gg: AY/fxX5Hz3F6PWN/B17aJTslDEuW3UsikI9ObiKInHsPRomrYwwzQ5Pcczdwemkf8DF
 baU8wu7fPi0qV0NMEqOakRBqdPK0OwawK22cGRV4xeGQMU7k012YuZLKgR7V+o1MJBZaA0U2IwS
 /idw4GY87fVOqzrYOi32U2wa/HatiBGx/K6DARQW/8w9W/a3vlKitl7B6W9eSBbWRXcwhAMzhws
 CaVPzAYCdHJNaYDpYY6Dc84NUAeaSSV4GXslULkYzKKHu8ZK6RlI/5eOrPAKebwWU7zreBg
X-Google-Smtp-Source: AGHT+IH+HU/mDIdyV/msBnkjROQ+9/PU130vWEPVd07JS6Y5X8BC1KViWLkGSDffXrkPXBl9VBq/UL5ThI45plb/SNM=
X-Received: by 2002:a05:6830:7199:b0:7c2:8937:5d2e with SMTP id
 46e09a7af769-7cc66901f28mr7195107a34.15.1766516487566; Tue, 23 Dec 2025
 11:01:27 -0800 (PST)
MIME-Version: 1.0
References: <CAPEhTTGamEFapOA4pKgMQxDz9Go1k0QeGRkk5bR-X2jR+iBCcg@mail.gmail.com>
 <CADnq5_Mh7M=019sJ274GLtMyKDH5MSMfR=k6pVTS1z2DV1tQCw@mail.gmail.com>
 <CAPEhTTGJb85fP4iJXAWVkg+vai2xDi-76RFhbmuG0Gc-XT+dKg@mail.gmail.com>
 <CADnq5_PJ+1pJcoxGZPU3xv19nTac76e8bTi+rabfXCRmdnfcQw@mail.gmail.com>
In-Reply-To: <CADnq5_PJ+1pJcoxGZPU3xv19nTac76e8bTi+rabfXCRmdnfcQw@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Tue, 23 Dec 2025 14:01:16 -0500
X-Gm-Features: AQt7F2rP4cjFwAum5vL3TrXKdVRx82zo1RSKyybTaVedjs9jA9I9cZhI3fdk3pM
Message-ID: <CAPEhTTFMmvNHeCknvGbCo46fFv9vbKCov98Zn46b_mXZD25rSA@mail.gmail.com>
Subject: Re: SI - are power and voltage readings supported by the hardware
To: Alex Deucher <alexdeucher@gmail.com>
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

Hi again Alex,

First, a follow up on VDDCI. From some sources I've found, I
understand that it would be the VDD at the interface. Which interface
is unclear, but one source was referring to the voltage at the PCIe
interface. Would that make sense?

Next, I'd like your thoughts and inputs on a project I'd like to work
on (in fact, I've been working on it in the last few weeks already).
I'd like to bring BACO on par with CI. I know there is a minimal
implementation for reset purposes already present. I think it is
linked to the legacy dpm. And then, I'd like to go as far as possible
in moving from the legacy DPM code to use the same (or similar) code
path used by CI+. Do you think this could work?

Also, was SMU6 significantly different from SMU7? Looking at how the
driver sends messages to SMU7 and 8, it looks like an iterative
process where new messages/features were added to the previous SMU
version. Can we expect SMU6 to work mostly like the two subsequent
versions with a subset of their supported messages/features?

Finally, was SMU6 able to use any of the power tune features? CI is
able to receive a request to use one of a few power profiles. Was this
only available from CI or was it also present under SI?

Thank you very much for your time and knowledge and have a great
Holidays season.

On Mon, Dec 8, 2025 at 9:32=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Sat, Dec 6, 2025 at 11:30=E2=80=AFAM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > OK, I was hoping for a similar SMU7 implementation never completed.
> >
> > I see both VDDC and VDDCI (for Evergreen+) values available. When
> > looking at amdgpu_pm_info, VDDC would be reported as VDDGFX I suppose
> > (and inX_label under /sys/class/drm/cardX/device/hwmon/hwmonY/), isn't
> > it?
>
> Yes.
>
> >
> > What would VDDCI correspond to? I mean, how should it be displayed
> > (maybe it has its specific inX_label)?
>
> I don't recall off hand what voltage domain VDDCI was off hand.  I
> think it may have been the memory interface.  I'll see if I can dig it
> up.
>
> Alex
>
> >
> > Cheers,
> > Alexandre
> >
> > On Mon, Dec 1, 2025 at 10:26=E2=80=AFAM Alex Deucher <alexdeucher@gmail=
.com> wrote:
> > >
> > > On Sat, Nov 29, 2025 at 8:44=E2=80=AFPM Alexandre Demers
> > > <alexandre.f.demers@gmail.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > I was wondering if SI GPUs support reporting power and voltage valu=
es
> > > > at the hardware level? I read somewhere that it was supported from
> > > > GCN1.2 (Tonga and over), but I haven't found anything on prior
> > > > generations. Going through the register names, I wasn't able to
> > > > identify any who may correspond to power or voltage level.
> > > >
> > > > So I'm asking, just in case it is supported and I missed the
> > > > information while searching for it.
> > >
> > > Correct.  There is no interface to query the power.  For voltages you
> > > can look at mmTARGET_AND_CURRENT_PROFILE_INDEX to find out the curren=
t
> > > DPM level and then convert that into struct si_ps to look up the
> > > voltages, similar to what is done for sclk and mclk.  See
> > > si_dpm_read_sensor().
> > >
> > > Alex
