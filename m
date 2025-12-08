Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F12DD3B7F3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Dec 2025 14:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C4510E48C;
	Mon,  8 Dec 2025 14:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJY1K3aW";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71E8210E483
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Dec 2025 14:32:14 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-297ea4c2933so5313895ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Dec 2025 06:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765204334; x=1765809134; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjXDV8lOL1WRoXhZYFVhpCm6JuqkxRs01BIN1mXzN8g=;
 b=dJY1K3aWUF2wp2Bc9aN4VRKLmjC8mSV3rJCfOgQi366XI48XweuceFc45MOEJ81Hla
 zGdBw9I4Wa5L1WtruEzrEHhch5mqUZK2NLyH5CNbg0I1pQUnTtwM3nHYyvR8wh+Lxbeg
 TH8yhb6rGNRE9PPToUMIntl/f/w2bIAc5bS2TCZthbw8dZhOEDfwi4g4gQ5ld1YZ45lw
 j0wxizdMU3441KQHRcg/oOYeiS8M5MDIBTy+VP1hWh5U1ZGqm7TVO1ErMk9/sEj2zZCQ
 ERCLuvwkYLjw5Nx7/dK627DCmURg+xHl1qEJWCu9OJB/JKNGVFs5lX4UeM3UBIDhaJAf
 5Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765204334; x=1765809134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xjXDV8lOL1WRoXhZYFVhpCm6JuqkxRs01BIN1mXzN8g=;
 b=lxwFX0jPwevYAnRdu6Q/wM1iDqRzRROsBbI6grDDXsezw9XQCXjREUHOVkFxgTFrPg
 v90btRyAl5c5ZPIAmswqyqtSoKtmELNJna6uhl3VJOu/Tg1Gxqk4Hb+bSJnELlEVvNIj
 uMLOPHKuWo9IKg2sHchHhG3p/2bSiGxBNtobN7uNKMXxzXhb+0RUj8VeN7HQUQiayyjk
 vr2vfsprp3Vey5Gph9r5lKN9P484VeEPJwGdKhL4ZtSWwe8PeV9xWXVjPiGoyzPfk95N
 h3ZBae3s6Ht0o7iixw8QCVjnsbdNkyTFFaYsBl5QD9NDnoO4sgJ5q9GhQv08NVHAuLHa
 vi1Q==
X-Gm-Message-State: AOJu0YyIr3CjsYLL2ucRC7oK1XL21bJWfbAOs1oMerDANIr0I4Sa7tCB
 bBbypB4D7/UR1FeoUfAAdriRvwn0w0eBwy+u9UovFK5awMnhGSf4c+7uDsJa/kFihSF/57mK2tG
 RADgPGrBG43TTztIW0at5uLWq58Hz2SE=
X-Gm-Gg: ASbGnctcMcAQKtiENciS75gpTuBwtpICF6+AH1sE6Qm01puIlfAalq4Dj3Gz+r8lhyn
 ERX2NEifxCYr3cTNUzm4d2xWvXBODzwAJgByimkM08q/NrTTz4Op9yeWZZYoGncK9/QljvTMcW1
 2TmpbXGcKjXAE+okTrT/w+gIJYwjTjHQE7Rtx7giZHcnhg65tpvQ+ouVHAxLu9YQ86oBibclwJO
 shMDiSIxTu6x/xebKjZ/U0HjXApf7/UMIA+3P1ziceQpxZ/e9cZXNXIzRoQXz6BQN4oqG0=
X-Google-Smtp-Source: AGHT+IFcFEomnNNpY9mlbpy2COWIBe30lSD2jqNL2ZiN++9rz9WtPvpCpSRG+/TGYKABBUkCKpYvW+4toB0PHTxXWy4=
X-Received: by 2002:a05:7022:252b:b0:11e:3e9:3e97 with SMTP id
 a92af1059eb24-11e03e943cfmr2912822c88.6.1765204333697; Mon, 08 Dec 2025
 06:32:13 -0800 (PST)
MIME-Version: 1.0
References: <CAPEhTTGamEFapOA4pKgMQxDz9Go1k0QeGRkk5bR-X2jR+iBCcg@mail.gmail.com>
 <CADnq5_Mh7M=019sJ274GLtMyKDH5MSMfR=k6pVTS1z2DV1tQCw@mail.gmail.com>
 <CAPEhTTGJb85fP4iJXAWVkg+vai2xDi-76RFhbmuG0Gc-XT+dKg@mail.gmail.com>
In-Reply-To: <CAPEhTTGJb85fP4iJXAWVkg+vai2xDi-76RFhbmuG0Gc-XT+dKg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Dec 2025 09:32:02 -0500
X-Gm-Features: AQt7F2rm4GTsjjl4t_E5EAjio4fajCSzLxFLLP0wyZGzaTjmjqBn4qzdkTkMFO0
Message-ID: <CADnq5_PJ+1pJcoxGZPU3xv19nTac76e8bTi+rabfXCRmdnfcQw@mail.gmail.com>
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

On Sat, Dec 6, 2025 at 11:30=E2=80=AFAM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> OK, I was hoping for a similar SMU7 implementation never completed.
>
> I see both VDDC and VDDCI (for Evergreen+) values available. When
> looking at amdgpu_pm_info, VDDC would be reported as VDDGFX I suppose
> (and inX_label under /sys/class/drm/cardX/device/hwmon/hwmonY/), isn't
> it?

Yes.

>
> What would VDDCI correspond to? I mean, how should it be displayed
> (maybe it has its specific inX_label)?

I don't recall off hand what voltage domain VDDCI was off hand.  I
think it may have been the memory interface.  I'll see if I can dig it
up.

Alex

>
> Cheers,
> Alexandre
>
> On Mon, Dec 1, 2025 at 10:26=E2=80=AFAM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
> >
> > On Sat, Nov 29, 2025 at 8:44=E2=80=AFPM Alexandre Demers
> > <alexandre.f.demers@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > I was wondering if SI GPUs support reporting power and voltage values
> > > at the hardware level? I read somewhere that it was supported from
> > > GCN1.2 (Tonga and over), but I haven't found anything on prior
> > > generations. Going through the register names, I wasn't able to
> > > identify any who may correspond to power or voltage level.
> > >
> > > So I'm asking, just in case it is supported and I missed the
> > > information while searching for it.
> >
> > Correct.  There is no interface to query the power.  For voltages you
> > can look at mmTARGET_AND_CURRENT_PROFILE_INDEX to find out the current
> > DPM level and then convert that into struct si_ps to look up the
> > voltages, similar to what is done for sclk and mclk.  See
> > si_dpm_read_sensor().
> >
> > Alex
