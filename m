Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E03EEF32B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 08:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B94510EB8F;
	Thu,  5 Mar 2026 08:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BdkV6JO8";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A134310EAC4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:23:46 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b936505e7a0so529096666b.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2026 14:23:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772663025; cv=none;
 d=google.com; s=arc-20240605;
 b=UgI/PKHXZAClPPAWl+imla0opXsxXCfuh9L3u+PYruclknDEH2K1BeMI207PyQCrRh
 RoAgROhfvlW9yLK9wo78HMR7rv6xzM5G1XbD9IZRBLQxBqmzlV4XfiQOBITzRNr9bqPT
 HF8cWigWkSFPn4B4f8WlN6ClFYRsfGcFYDVfWjXBhYYzckPQK6ChR+VWhPB5AlCMgkXT
 O7LRF5Hb1DHI3MjyMrT5BYi2knMvsvTiebGtsaRk+vKIx5M8uxeNN5Azze5IMnWg3Ddd
 FGvK0Q4Fup4BPdSfJsnVjUVx/ubj+o3uoT6N8wbdeQB918Rw91hBCnk8XEmY6W5rNzhS
 U/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6SzQXrMu6157NmI8m7MFrfeo16+um+qkfnMEtnr1Qaw=;
 fh=pwL2BMsbfpKXKyxIH1p5V4ZXvJ4NL8xbnF8x+uxGEfM=;
 b=ecwkiOEKMWH2HeGPh5Fj6i1qNTXWEOtBmvQmyI0AbZk0kJWGeb53sxDPTTDqX+SqyE
 qfgaf4LcOGwJF2/pgXXwm743ARSalK6/aZtjgrWmPHMCx6QHwEDNyRi0gJFnHZIGzM/q
 zo2Utl4ciiqj867US66ehaUqM9YkRQ7anIqHSXgqeVBEI5JCndkHB3R8LcptJqj+vkaY
 mv2ASiIXO+KqESXxqo6MSwAR8tmkb6qKbWtZBJ6nCOBQgWloGhn5PRPerE/suiIGOJUa
 clo+uBWXfMlT4s5iz134DmYCGw/hp6UE5J6ODhTB5cHDB278F8CzR1ezYqhQep4PuRLy
 ZO8w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772663025; x=1773267825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SzQXrMu6157NmI8m7MFrfeo16+um+qkfnMEtnr1Qaw=;
 b=BdkV6JO813tHrwVJo+H+mZ3cLVgAa6K9/rPNS/MBWnjw01NvLlMhsG6kQ50iiMvN3t
 RzZh4a9xT8SgR6TOhG7ji59BmwQwWYNcjG7An2+9DB9N5mRONfkyy4kMOqRSzpjHVILD
 UmtyoRS8NVpQAfZXK7Da1epVV45AxwTt8Dj4bZIqt3pWBSzZ6lXoC53Z2cZb7eS14NUK
 xwRsRYcG6USX5UX/mfX6sDkBRGAGTuyBOUq7ryLyUHegek9KLqtaTFQl+womrXA4Nx78
 DWSOYHxox65T5ZN/G/WYhg340I7WiB1rp0D8tPN+QCwmwut6XA9A6pznPkF0My7CsfUS
 5xVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772663025; x=1773267825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6SzQXrMu6157NmI8m7MFrfeo16+um+qkfnMEtnr1Qaw=;
 b=qsC5yaOl3fq8HwlA7kmmGR0SIySUddsw2fxWSswlQrqKpHUzNcPDK0wtaOjQKmP9kT
 Q+h3gyrHJwNh2LXECfLdn1pSY2XinzKpQpsPpto42SPf0owNxOv1D03YFa2uBZUSQzCK
 dfPEfFn2GUW65QJg3kwz4fLmUTCIKgyzsuq3T4eSVBDEnKeNlpMJ3ANljqcMqRkGS4TP
 trcGgc2ZRdvZVr8Jdq575AfJEvmdljjcbSflH5mYlTh9uwVNSJ2klk2/1mjqpYhu1TC6
 ZC4ydzF9EWTqmCCEYycUtBYTnUnTpw6IDdXDjudpxZOwihlbjRiIseiENwc64YkGapH8
 smmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZhknhyOszrda0MEYtjT3kZPj5M1/GTV+yYYvibwV9DgzKPhSJRBNnIY9kBrFuVkDyW5ODq6xz@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzp99M3yPFbm+t/zc5SovOJ0vwROCJpGzk/JyV2rdvNTXHLJNmZ
 lrPTOnAVT9H4NvLSABA3lzVVSQn0VLbEaLogfND14dNmdAqJH5DiblFyUMUUcEaw46VHE6XTI69
 UBoj5Mdvkofx8UvCRcCcSpKj8UZ6lbxg=
X-Gm-Gg: ATEYQzxFwkbsHWtJmJ02KN+FhjIZilUCeoVP7VFNl2v9eH378I23I86nBDGRjgpNsQf
 RVnozUjLcnXqhvcob0OHgULocM3jBnIxcuBEJ1qfdB+o6yzKm4FXTZGVKaqoBGFsDzLcVmO0/PR
 unDmktUhhcMlU5xuYBUH4V5FDAfiQQUrOPHspozjqMw41fKb21goFSeb/jlXy/lHFxy5LMSj5hp
 HM8PFHWxy9175EkjQ2BXDwgYVS8diDUQUgDf9eiVoFUDQT0xVYd4plyX9LPIgSUzEO/xL5sOlBl
 r2ZmZP0jneZiCHyROB9FXa6ZDtkoFOIjl+DyJVqynpApINKXXApYpGcl/0WRVnnmPQOIvlcIm+z
 LfT2k0A==
X-Received: by 2002:a17:907:971a:b0:b90:77bb:5aa3 with SMTP id
 a640c23a62f3a-b9409d99535mr11282366b.16.1772663024812; Wed, 04 Mar 2026
 14:23:44 -0800 (PST)
MIME-Version: 1.0
References: <20260228045356.3561-1-rosenp@gmail.com>
 <2596902.XAFRqVoOGU@timur-hyperion>
 <4d00945c-f439-4460-9f8b-12e7e498fb20@amd.com>
 <5828571.IbC2pHGDlb@timur-hyperion>
In-Reply-To: <5828571.IbC2pHGDlb@timur-hyperion>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 4 Mar 2026 14:23:33 -0800
X-Gm-Features: AaiRm52dSio9iCYsE9GD2Rplzjp2tDUV5pP5zcsLpbimyZ1W4JLCk1ijysOQt9o
Message-ID: <CAKxU2N9MHp+m3A0w38pfGEJUkLKCCsLgvmgAG3sfSn-Rhc0sgA@mail.gmail.com>
Subject: Re: [PATCHv2 for 6.112 and 6.6 0/2] amdgpu: fix panic on old GPUs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Kenneth Feng <kenneth.feng@amd.com>,
 Alex Hung <alex.hung@amd.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lijo Lazar <lijo.lazar@amd.com>, 
 "chr[]" <chris@rudorff.com>, Sasha Levin <sashal@kernel.org>,
 Wentao Liang <vulab@iscas.ac.cn>, 
 "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 05 Mar 2026 08:15:04 +0000
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

On Wed, Mar 4, 2026 at 4:44=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@gm=
ail.com> wrote:
>
> On Wednesday, March 4, 2026 11:06:53=E2=80=AFAM Central European Standard=
 Time
> Christian K=C3=B6nig wrote:
> > >
> > > Hi Everyone,
> > >
> > > The patches actually come from a branch of mine:
> > > https://gitlab.freedesktop.org/Venemo/linux/-/commits/v6.12.74_si_dc_=
fixes
> > >
> > > For context:
> > >
> > > The crash comes from a patch that I wrote for 6.18 that fixes some is=
sues
> > > on the default, non-DC code path, that was backported to stable kerne=
ls.
> > > DC was not the default code path before Linux 6.19, so I didn't mark =
the
> > > patches that also fix DC for backporting, because I had assumed nobod=
y
> > > uses the DC code path on these kernel versions.
The DC code path just works bettter. So what if suspend is broken. I
would much rather a working system. Hyprsunset for example doesn't
work without DC. No idea why.

Speaking of suspend, the fixes for it are fairly trivial to backport
to 6.12 as well.
> > >
> > > After a user reported to me that this causes issues for him with DC o=
n
> > > 6.17
> > > and older kernels,
That was me.
> > > I sent a backported series to Greg and Sasha, in an
> > > email thread with the subject line "Fixing an amdgpu crash caused by =
a
> > > backported patch". The fixes were backported to 6.17 then.
> > >
> > > I assumed that the stable maintainers would backport the fixes to all
> > > older
> > > kernels that were also affected, but Rosen brought it to my attention=
 that
> > > it didn't happen. So I made the backports in the above branch. Rosen =
then
> > > decided to send them to the mailing list.
> > >
> > > > Hope that helps clear up the situation.
> >
>
> Hi Christian,
>
> > In theory Harry an Leo should take care of stuff like this
>
> I don't blame them for this. It is my fault for breaking it in the first =
place,
> and I didn't think there was any interest in using DC on older kernels.
>
> > pretty much everybody is overworked.
>
> Yeah. We all are.
>
> >
> > In that case guys feel free to go ahead and ping the stable maintainers=
 that
> > something is missing.
> >
> > Just make sure that when a patch passes through your hands that you add=
 a
> > Signed-off-by tag.
>
> Thanks! Probably I should have sent the patches myself, then they already
> would have had all the necessary tags. Sorry for the confusion.
>
> Now that the situation is cleared up, is there anything else we need to d=
o for
> these two patches here?
Speaking of which, it's probably best to take over here. It's not fun
dealing with stable. I also didn't author these patches.
>
> Best regards,
> Timur
>
>
>
