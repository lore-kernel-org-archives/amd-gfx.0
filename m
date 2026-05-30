Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A20CD5BD0
	for <amd-gfx@archiver.kernel.org>; Sat, 30 May 2026 10:32:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A07010E1C7;
	Sat, 30 May 2026 10:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pI0cbbnu";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1860110E1C7
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 May 2026 10:32:40 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4909e3fa4b2so12838095e9.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 May 2026 03:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780137158; x=1780741958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dLlZhRM+wi8G/RLdcmONLqEf/W3CyEq5CgwTiG7lD5c=;
 b=pI0cbbnu0pMC7NqWPEXlKp+zvFqhSwKd1ROJVWXiJ3wwKegYNcNzIzqXBEmHi5PmfF
 fgcxS8Yx3z0s0c/2EEKbibtcS9jUrT8gbyZdfnhN9+qXcdncc9YyS3Dslh5r4XYWcL/e
 YrG1A1bvGDhL80iZ9JWgPQotvqajKN1j/2hzjaCkKXTqt7DKaS8OAl2RXgrwEmehB7nu
 zo4z1PBltkt76pYv90Z5nnsR0s+2T0g5DuuKwI8jRaxyquqX5Hh1V0uaD8ilvUxaM7vp
 p86gdvg7uE/IO6GN4B3aZTdRihWGXxbKcj+Kx9FdO9sj2BZgHTi+3Wx33QVhQQ/2ORND
 uDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780137158; x=1780741958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dLlZhRM+wi8G/RLdcmONLqEf/W3CyEq5CgwTiG7lD5c=;
 b=Stz8N5WFodxJFL1GC8s9idhegPEKB2Lh1XbSCkSioklUvP4NC424+qmJtr9ikHPoRU
 Te8rMATNr+zGqIszDHF+jrqh18z5PxQEmX4JE6tL58Mz+HqdBPuP0BgS3IGXsxh2e5LG
 7Ppjjo6iVY1q+3HjMlzNwfAzbSXR4eUJK721RAzyLThJgVTMpEZ4T/0vXLW9vrgQ/S+F
 JM2Ohwztr6SiOjRNDpK3fosSedHh4lX3u2sF4BfUr8b4wwICOQDU2nfm9SDDNnBQYIhG
 gErnIzLzvoWD+DIbH5o/FEwjVR6ZAAcMjlJx9QiM2JS5yrDjnPKScrIhip0gjikrQ9+Q
 ERjw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Cm5G360SWQ0E34mAqIp8HSd8HzXNHz1C7p6hgRlAv213ocyxjklojF5cZLuyeEboeckZkaPjG@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyz9k5+ObT4i2KSp1npQ3f/EkFx4f/K1ZsOnActyfiBbF6Fs6Xv
 GQ3MLOjCDcxzNyZRJ0hTMShpaG0kL50p2oIFZ/+fnjxpCm8GKPEp9ghV
X-Gm-Gg: Acq92OEFxO+rHKQi93DwCVSig64NXUMM8jqtUQtnq911356trhMD7qaAlBzk8dDQZLe
 nbsfyOnEIU0zVLfMRAouR4ZCm7DSGDX+TJ4kVP58e84kOXbtMr7ltp17V9RWa4p1QPcxqEq3s0J
 1rhBHVywwoz6oF9JtdCQE/fx2woe7kwz7m0DyoYbSMIXtFAsnEfmtfFnY7A6JC6bTGvAvXDFWTk
 /XHU2Kaz+MuB4yKWSLb3Imjcj3uPFTnbSRoa3tGo9WX1fFwj1GapOal6Ve3q0hTheMlDCPJ6nyX
 Gu3pLW1sxbaYT/AQVdWc2nNTLhBJe8+GCPgd20yGlKgvvxgm3qgbQfJHpOGaI1mI5XDLKIPCZu/
 M036F+BKV4jPyEpI4k6PT41+0p/cpx8iV36T9E/JLgTgqCxc4PyenhMc1ORaUdPQQz9lc1uJIGu
 7NlyYx3fNSj5OYSQJrT/90rpj9d9HeVSxRPiPw7Lwu4Tfakx+XN9GzL7KL01K//2ghjVozNg==
X-Received: by 2002:a05:600d:844e:20b0:490:9df1:f0cf with SMTP id
 5b1f17b1804b1-490a290cdb7mr39521925e9.2.1780137158353; 
 Sat, 30 May 2026 03:32:38 -0700 (PDT)
Received: from timur-max.localnet (184.31.0.109.rev.sfr.net. [109.0.31.184])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c12f4d0sm33594555e9.34.2026.05.30.03.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 03:32:37 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Jeremy Klarenbeek <jeremy.klarenbeek99@gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
Date: Sat, 30 May 2026 12:32:36 +0200
Message-ID: <4899616.vXUDI8C0e8@timur-max>
In-Reply-To: <CAOGA6HgfUjbT9wKU1Baz3QXFsDaRTEUd8WCrRQn2D5Fh8REEbg@mail.gmail.com>
References: <20260519084158.72960-1-timur.kristof@gmail.com>
 <BL1PR12MB51440DCA164ED993EA5FAFBFF7162@BL1PR12MB5144.namprd12.prod.outlook.com>
 <CAOGA6HgfUjbT9wKU1Baz3QXFsDaRTEUd8WCrRQn2D5Fh8REEbg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. m=C3=A1jus 30., szombat 12:07:12 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Jeremy Klarenbeek=20
wrote:
> Thanks everyone.
>=20
> > My suggestion would be to call pm_compute_clocks() inside notify_ac_dc()
>=20
> I tried this patch and it's not working.

Of course not. It wouldn't work without also inverting the HARDWAREDC check.

> The specific behavior I see:
> 1. Clocks do not respond to plugging/unplugging. Always idle.
> 2. Severe system stability issues. After opening a process that uses the
> AMDGPU, opening any more GPU processes (glxgears, radeontop, etc.) hangs
> forever during init. The system hangs while shutting down and requires
> force power off.
> 3. This message is seen in dmesg. Not sure if it's related.
> [  151.684427] amdgpu 0000:01:00.0: bo 00000000c5a63ba0 va
> 0x000010cb00-0x000010cb53 conflict with 0x000010cb44-0x000010cb45
>=20
> > Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary on yo=
ur
>=20
> laptop?
> Yes, without sending this message, the SMC switches to idle speeds instead
> of AC/performance speeds. Unplugging the laptop ironically makes it clock
> back up instead of down. This fix was found while reverse engineering the
> SMC and confirmed by the clock speeds beginning to rise after implementing
> the message. Commenting out just the one line that sends the message undo=
es
> the fix.
>=20
> > the ATOM_PP_PLATFORM_CAP_HARDWAREDC check is inverted
>=20
> I've implemented this into my branch. Thanks for checking.
>=20
> Here is the current state, still a 6th commit on top of the original seri=
es
> of 5: https://github.com/luisfonsivevo/linux/commit/083a2bbe81d6for
> applyingfdc670b5890de661a3bdd42e9b80
> <https://github.com/luisfonsivevo/linux/commit/083a2bbe81d6fdc670b5890de6=
61a
> 3bdd42e9b80>
>=20
> This has been working reliably for a week without any problems and I'd be
> happy to submit it if there are no objections. A separate commit will be
> needed to apply this to SMU7.
>=20
> On Fri, May 29, 2026 at 10:33=E2=80=AFPM Deucher, Alexander <
>=20
> Alexander.Deucher@amd.com> wrote:
> > AMD General
> >=20
> > I dug into this a bit more and the ATOM_PP_PLATFORM_CAP_HARDWAREDC check
> > is inverted.  Switching that should fix it.
> >=20
> > Alex
> >=20
> > ------------------------------
> > *From:* Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > *Sent:* Sunday, May 24, 2026 7:32 AM
> > *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Jeremy Klarenbeek <
> > jeremy.klarenbeek99@gmail.com>
> > *Subject:* Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
> >=20
> > Hi Jeremy & Alex,
> >=20
> > > Apologies for my late reply. I tested the patch series (SI laptop
> > > 1002:6606) and the problem remains where the clock speeds don't boost
> >=20
> > upon
> >=20
> > > switching to AC. Timur and I investigated this and found 2 problems
> >=20
> > Thanks for getting back to us on this topic.
> > At Alex's suggestion, I removed the clock recalculation and added the
> > check to
> > verify ATOM_PP_PLATFORM_CAP_HARDWAREDC. I'm sad to hear that this broke
> > your
> > patches. I apologize for that.
> >=20
> > Unfortunately I don't have a SI laptop GPU to test this stuff, so there
> > was no
> > way for me to verify the correctness of those changes before I sent the
> > patches to the mailing list.
> >=20
> > > 1. It seems that it is necessary after all to recompute clock speeds
> > > when
> > > toggling AC/DC. Sending PPSMC_MSG_RunningOnAC on its own has no effec=
t.
> > > Each ASIC family's apply_state_adjust_rules appears to be responsible
> > > for
> > > the switch by setting the max_limits, and this function is only called
> > > as
> > > part of computing clocks.
> >=20
> > That's right. I took another look at:
> > si_apply_state_adjust_rules()
> > smu7_apply_state_adjust_rules()
> >=20
> > Both of these rely on adev->pm.ac_power when determining max_limits, and
> > they
> > set the maximum clocks accordingly. We should indeed re-calculate these
> > clocks
> > on both SI and SMU7 when there is an AC/DC switch to make sure to apply
> > the
> > updated max_limits. Additionally I think we should probably lock the
> > mutexes
> > to ensure that we are sending only one message at a time.
> >=20
> > My suggestion would be to call pm_compute_clocks() inside notify_ac_dc(=
),
> > and
> > also to lock the mutexes:
> > https://gitlab.freedesktop.org/Venemo/linux/-/commit/
> > e98279dff480cc297cbb1fe50c2b71ebd65b9576
> >=20
> > if that works, I'd like to submit that patch (and will also port it to
> > SMU7).
> >=20
> > > I'm considering removing the .notify_ac_dc field
> > > from the IP block entirely and just calling .pm_compute_clocks from
> > > amdgpu_pm_acpi_event_handler, but I only know for certain that this
> > > works
> > > for my GPU.
> >=20
> > I don't agree with that. amdgpu_dpm is generic between all supported HW
> > generations and shouldn't contain HW generation specific code. Also, it
> > clearly
> > doesn't work the same way on every GPU generation, so we shouldn't
> > generalize.
> >=20
> > Furthermore, we should minimize the amount of messages we send to the S=
MU,
> > so
> > we shouldn't send the RunningOnAC message every time we recompute the
> > clocks,
> > only when it actually switches to AC.
> >=20
> > > 2. The ATOM_PP_PLATFORM_CAP_HARDWAREDC flag is enabled for my GPU,
> >=20
> > causing
> >=20
> > > PPSMC_MSG_RunningOnAC to never be sent. Either the flag is enabled
> > > erroneously, or we're interpreting its intended usage incorrectly.
> >=20
> > It's hard to judge that without having access to the hardware or docs.
> > Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary on yo=
ur
> > laptop? Isn't it enough to just re-compute the clocks?
> >=20
> > Can you check what exactly is the value of adev->pm.dpm.platform_caps on
> > your
> > laptop? Maybe we are looking at the wrong flag, or maybe the HARDWAREDC
> > flag
> > only refers to the AC->DC transition and not the DC->AC transition.
> >=20
> > This is just guesswork on my part, but maybe we should look at the
> > SBIOSPOWERSOURCE flag instead, which is explained in pptable_v1_0.h:
> > /* This cap indicates whether power source notificaiton is done by SBIOS
> > directly. */
> > Can you check if this flag is set on your laptop?
> >=20
> > Thanks & best regards,
> > Timur




