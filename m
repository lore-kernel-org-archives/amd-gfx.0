Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA1EC5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 13:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F159810F023;
	Thu, 20 Aug 2026 13:24:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VOYGjDYv";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C556710F023
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 13:24:44 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-5bfa60aa6caso24342e0c.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 06:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787232284; cv=none;
 d=google.com; s=arc-20260327;
 b=SOBi+mj/eAkv5w5ACgF0Lpn1m91K1uPVrcXxhQeF4h/j4GgZbO/NvSsG+nNvZqVLLm
 HYhyCcXqSOS5BvCZA0bbEoFpPREi3VzMiiNHiWslkW1jXaBHxtPx4GeSneykmP3x+3AX
 Kf8ke1molWpGUogz0UoBfbLxq+9+bHxGuCx/vjlpa4l3+RQU7z5sm5xiJLU9lZHSuvi6
 KVLxEft7KorYhCtRTu490hvBx5Bq3S2dZO+YR/PscVhrkvoHlWdzHAZ9n5Yt13PFbsXE
 Yzf7o31egOJehVBpkEaIuwIdOf8ch2wKKasipG45pFQ18Itjdb6D+ms2mq6QKsRWELDk
 /kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=a/bb9TS4nrbeO9REdTEH+Ugx741KsO4AaWJeYnqJzhA=;
 fh=KMRBoCv2LFsbWeH5R0ppGIM64xo3ZYgnND0It1WmnO0=;
 b=IbnHF6bEj8FNVzS8bJR35HQr6khcZ1/Ms+dJnRBAHfeiN4Cvf1nomkdAxT3HiSMVqi
 +fqLp2N5B1XBpq3tcbKvzOPGNvc1lPLIlU0mKPoAlXihqmpXT3/uy0s3o3FIFWnEd8lE
 bma4h0o36e9iNM67S3+d0h/P4CQiDykQcn0cNXOCcw02UejfywIvOZscrzPGBlrbv/CP
 L0p72n7d8TuJigy2mUuHxk27kdOKIf9cs/gJ3ar7/+rXluM2b/POUpygMN2ThIRD8nRa
 kDLBKy1tWVo1xU4V444ck2XDuo1SfustyBgMuLZ3K64GgazQ/aT/oue2YQmOSW9LZgPy
 OuzA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787232284; x=1787837084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a/bb9TS4nrbeO9REdTEH+Ugx741KsO4AaWJeYnqJzhA=;
 b=VOYGjDYvsUv4Vcc6GQFRbgQz49HNqCluRVg+nmE5gpgb3XC3nVPjrctRA06FqLwbM7
 2Fb1u9UVkhCNMIgaGC1WmujprXamc95XCbyxqagDlPpIDz4Mvt/N1AH1duzR2hjnpXL+
 Yp8ks/WK6OFopBqIIRyUC68o15oFpwigJ9TEhFYosVodEcfJnewvOc/J5wGgKv5Fuzn4
 LsnTuvUW0k6+mkXwDGNk+iieSI9GE+XCPpQW7XPtGq7FecGNj9gbteG+d+6XiYd7lqcw
 N+MHds9FkpT3cIUWf7DDVkC53FA3WcuDzWTMWiACa4rL2aWbT2wPa2DirOm98FSyR1Qt
 ThZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787232284; x=1787837084;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a/bb9TS4nrbeO9REdTEH+Ugx741KsO4AaWJeYnqJzhA=;
 b=jd+7D/EVYFwzE9+kb4IOIDgbtSEZxAkxFeJVZNaoDrNDZOQ70+lVZTDzTGseOQnhCo
 FTdqvhg4v8NFOCzisZVrJDMde0RTn4PDQAxPeE7hNZWl5Y3rB6Z3SSgeoWsZuBxSeVhV
 5sqdWBNmPfnrAeX+xvcZLEAjqVwSFO7CUAgkEfiruyU40/1HdNdMTHAy+v2rCLbiBkY9
 Z4AY/FrHW2qd5oaxwKrtrDlgw3MHH7zi52QOpwh+ioe59mTscDB8HMb+Wan0tAsDKEIW
 /twoNfhGLjM6K+Krm/KqxDd8CPCZGFdtzzoKS8uvzTB37+0xOGjNau+/X3UosmSrHrSD
 LgTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQYzepp0of1XSpJRa2YL9E8BKmZ2bJepUYFOm6fj+LdTiCaRMbVrcGXXx2TK7nw8rSegiqfEWR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRo9TAkh7eXVFHpfAJ5cESYqTauyGlyD6dwodf/XUU2t4sUOv9
 r5GBfl8IBl6trqZ66tlK4WO7M0yQlKzsr675WYVHL2NzyuU2II7QcKRgafJtmS0kX4eTuDoHngW
 be5e8ewE63WyFAqwwR3o+Tei1O1s6QVM=
X-Gm-Gg: AR+sD110clCFUtgKg4ArrrHxrUiJz29DVH3LUi2QBdBj5Ii1Ha6E8VEt2UMBpRjWc5L
 SnCtCGFJoqKXdTHNSI1Cz6yT409mIIi0dCUVrtGIv+I1zWRNVs/kMIGgnYr5cbcIMGk+cFxxbVT
 UviknouHV2LHyBARWI5IuqWsUZpp6/Gzd7IrdQ2//yFqJqBc9BUJswTey5J+4+MSq+8BBUqXZWi
 QICuuEu/oWP4mcZA03TD6CPs/a4zm+/9B7rJ5LRsQrHc4Bi8Hl6jMoltky0hlWOx7+pujx3N9aM
 ALNl6qVscXURoy0NTagM9U+bJ1K5kBu+TWEc4fAz40dtVaDdnYqu4jPRLb4nfDeFOEVIt3MWDM2
 FQY2sYj3QUpxONXy1E49LPhi8P1TAhQ9aYKLV4IPm+Q==
X-Received: by 2002:a05:6102:8024:b0:772:cccb:f7eb with SMTP id
 ada2fe7eead31-777fb1adaf4mr1775409137.2.1787232283641; Thu, 20 Aug 2026
 06:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260601211931.2837-2-gilles.risch@gmail.com>
 <010001a01df94f48-3026542f-b8eb-4661-868e-1d35cfd0254b-000000@email.amazonses.com>
In-Reply-To: <010001a01df94f48-3026542f-b8eb-4661-868e-1d35cfd0254b-000000@email.amazonses.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Aug 2026 09:24:31 -0400
X-Gm-Features: AcwNN1X2Up83ezJvdOticUb5SaZjCUlqZ1r-YJnM-q1UsARSxIOswEHsKqhXwOU
Message-ID: <CADnq5_N7_w0k5mrgvcEgLZAa4Huv6PP-mTChsoxNx7Vnrb1qzQ@mail.gmail.com>
Subject: Re: [PATCH v5] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
To: Erik Gregg <hank@mowden.top>
Cc: gilles.risch@gmail.com, alexander.deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Thu, Aug 20, 2026 at 8:50=E2=80=AFAM Erik Gregg <hank@mowden.top> wrote:
>
> On Mon, 1 Jun 2026 23:19:32 +0200, Gilles Risch <gilles.risch@gmail.com> =
wrote:
> > The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 4850
> > (RV770/DCE3.1) with a 2560x1440 internal panel on an internal
> > DisplayPort path. Without this fix the display stays dark under KMS.
> >
> > This machine suffers from the same issue as iMac10,1 and iMac11,2:
> > Apple routes the internal display through Link B of the DIG encoder
> > instead of Link A. Add iMac11,1 to the existing DMI quirk and move
> > the Apple-specific encoder assignment into its own block, independent
> > of the DCE version check.
> >
> > Additionally, the 2560x1440 panel requires RADEON_PLL_USE_FRAC_FB_DIV
> > and ATOM_ENCODER_CMD_DP_VIDEO_ON, limited to iMac11,1 via dmi_match()
> > to avoid affecting other boards.
> >
> > Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
>
> I tested this patch on top of 7.1.7-arch1 on a Late 2009 27" iMac11,1
> with the Mobility Radeon HD 4850. With nomodeset the machine boots with
> a working (efifb) console. On vanilla 7.1.7 without nomodeset the panel
> stays completely black (backlight off) and no radeon init is visible in
> dmesg over SSH.
>
> With the patch and without nomodeset, radeon initializes normally per
> dmesg, but at the fbcon modeset (~4s) the panel goes blank and then
> shows flashing horizontal lines that start at the top and sweep down at
> regular intervals. It never recovers. The logs below are from that case,
> gathered by logging in blind on the console and running commands blind.
>
> I tried radeon.dpm=3D0, radeon.audio=3D0, video=3DeDP-1:2560x1440@60 and
> radeon.modeset=3D1, with no change.

I wonder if different variants of the board are wired up differently.
@Gilles Risch, can you attach your dmesg output as well?  Maybe there
are different panels on different variants?

Alex

>
> Renderer: AMD RV770 (DRM 2.51.0 / 7.1.7-arch1-1-imac), Mesa 26.1.6
>
> [    3.028962] radeon 0000:02:00.0: fence driver on ring 3 uses gpu addr =
0x0000000020000c0c
> [    3.029207] radeon 0000:02:00.0: fence driver on ring 5 uses gpu addr =
0x0000000000056230
> [    3.030250] radeon 0000:02:00.0: radeon: using MSI.
> [    3.030275] [drm] radeon: irq initialized.
> [    3.076796] [drm] ring test on 0 succeeded in 1 usecs
> [    3.076803] [drm] ring test on 3 succeeded in 2 usecs
> [    3.252855] radeon 0000:02:00.0: [drm] ring test on 5 succeeded in 1 u=
secs
> [    3.252861] radeon 0000:02:00.0: [drm] UVD initialized successfully.
> [    3.253264] [drm] ib test on ring 0 succeeded in 0 usecs
> [    3.253283] [drm] ib test on ring 3 succeeded in 0 usecs
> [    3.906199] radeon 0000:02:00.0: [drm] ib test on ring 5 succeeded
> [    3.906669] [drm] radeon atom DIG backlight initialized
> [    3.906672] radeon 0000:02:00.0: [drm] Radeon Display Connectors
> [    3.906674] radeon 0000:02:00.0: [drm] Connector 0:
> [    3.906676] radeon 0000:02:00.0: [drm]   DP-1
> [    3.906677] radeon 0000:02:00.0: [drm]   HPD2
> [    3.906679] radeon 0000:02:00.0: [drm]   DDC: 0x7e60 0x7e60 0x7e64 0x7=
e64 0x7e68 0x7e68 0x7e6c 0x7e6c
> [    3.906682] radeon 0000:02:00.0: [drm]   Encoders:
> [    3.906683] radeon 0000:02:00.0: [drm]     DFP1: INTERNAL_UNIPHY
> [    3.906685] radeon 0000:02:00.0: [drm] Connector 1:
> [    3.906687] radeon 0000:02:00.0: [drm]   eDP-1
> [    3.906688] radeon 0000:02:00.0: [drm]   HPD3
> [    3.906689] radeon 0000:02:00.0: [drm]   DDC: 0x7e20 0x7e20 0x7e24 0x7=
e24 0x7e28 0x7e28 0x7e2c 0x7e2c
> [    3.906692] radeon 0000:02:00.0: [drm]   Encoders:
> [    3.906693] radeon 0000:02:00.0: [drm]     LCD1: INTERNAL_UNIPHY
> [    3.906695] radeon 0000:02:00.0: [drm] Connector 2:
> [    3.906697] radeon 0000:02:00.0: [drm]   VGA-1
> [    3.906698] radeon 0000:02:00.0: [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7=
e44 0x7e48 0x7e48 0x7e4c 0x7e4c
> [    3.906701] radeon 0000:02:00.0: [drm]   Encoders:
> [    3.906702] radeon 0000:02:00.0: [drm]     CRT1: INTERNAL_KLDSCP_DAC1
> [    3.915213] [drm] Initialized radeon 2.51.0 for 0000:02:00.0 on minor =
0
> [    3.988184] [drm] fb mappable at 0xC0347000
> [    3.988187] [drm] vram apper at 0xC0000000
> [    3.988188] [drm] size 14745600
> [    3.988189] [drm] fb depth is 24
> [    3.988190] [drm]    pitch is 10240
> [    3.988263] fbcon: radeondrmfb (fb0) is primary device
> [    4.026022] radeon 0000:02:00.0: [drm] fb0: radeondrmfb frame buffer d=
evice
> [    5.366673] systemd[1]: Load Kernel Module drm skipped, unmet conditio=
n check ConditionKernelModuleLoaded=3D!drm
> [    8.464118] snd_hda_intel 0000:02:00.1: bound 0000:02:00.0 (ops radeon=
_audio_component_bind_ops [radeon])
>
> Happy to test further patches or gather more logs.
>
> Regards,
> Erik
