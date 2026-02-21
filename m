Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2BBE98E0D
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 376ED10E281;
	Mon, 23 Feb 2026 08:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hlViucer";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D39CC10E12D
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 05:54:14 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-65a2fea1a1eso6103686a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 21:54:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771653253; cv=none;
 d=google.com; s=arc-20240605;
 b=QYkeTtqRDrEZnWjA30U9ApTLRjylFKxdSfuboMZnLrJEh5BSPQzVt7bnvMAD5F2zfW
 ZL7AhXkOpAkPR9KLgqYdi8FzyCP5xd2b9JLgmLNpP3XwbL41KsEO2388LHdbd7icz0D5
 Bkeru4kx2W6/V20tb7b5E7GcXSR1+qUX3ya86vnO6RJI7Aua/MnRFoOEQ81vKmfpZ1DB
 qp7seF+yL3rSpGnii4pwGfdyVOU+inUoEw7V2OePn48ZDZxaLPgEBkv1eW9w4V98eEyX
 UHzpNz1mFHxRpofylKqD7LdOKzGGzayJyzBTIXnb4HFyeN2Zeqh5eLEfxqpnkrvkhRIU
 lVyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+tgY/mGK3l60LP3OprA602wtr51m0b3f7apbXmR/PtQ=;
 fh=0kJkmtpSIFZy9DsJCiIdCXU3VH22rRWWmZh8MtZHIB8=;
 b=Z8liShnbTVWaw2dPK4RgM4aSAzqAnyP7FWWwsdE/kHneqNrf3RQ3c+7eImS7gVtv9t
 oT5YRAxhG4UJpbsAFRjqnV1xWmt4wGh6sWgSiVimY+avDmCcpal4jtvVzNyfHSyM4gwo
 oVSaHiLx/6Z4eVT1UtviRj71+HmZjZV6IJHLFJVc5MDXEqFAefIY4CtkyyY1HyAQa/SE
 gttmQJwx/BWui622NIuvCdjqEjoC48EKVvGsGTgZMxXQA6hrya1OSfQ3AMpdY6rKlZhD
 Ah/FdQu1Y+GizITJTyQZxWQEqHBlkd+LfH17LE9YghR7lCuc2FcbdGWDfCs48qkidOez
 Ry6w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771653253; x=1772258053; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+tgY/mGK3l60LP3OprA602wtr51m0b3f7apbXmR/PtQ=;
 b=hlViucerc0uSByJ3zYHnh701eKX1M8CB/pdL8drrX71B+IYIndKuMzbA0QgHqhU28n
 MYYRSIr76F+QVsyz4N/AcfhctuceUwoj5GMEtnMquOPpqpnUrnMuHfR1zrI/p9LbFnTw
 xzeKmHMG+DG7it8ztLPY4QvQ4g+mB9asT0T1n+D5k79EusK/C2k/Ns1dyLT0HX4gmjUF
 3gLq8FZCZAaY3R6m8EaAUZGCAEZCMg/sYttl/aieEG6q9AsJEnTysvdOhzniIsuASGj7
 iYzeMEapPuP0OR9EdrPp5X2qJ3vMPDPQfj0IxhuWax5ct7CklLmfMBVn8aRnr9GycFYN
 jvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771653253; x=1772258053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+tgY/mGK3l60LP3OprA602wtr51m0b3f7apbXmR/PtQ=;
 b=i/1Bgp+bjC555rBP2RVL125qNQEfBRQqviuraVJaCZ4io75fN6d7tUayZxhnEH4xGv
 gVqM+FGudV74PKtkPB5Q68A9yhXmkNBWYhBBA8FE6mnOSv6zRg8yFSKFAlpf0gLx4d04
 q2k9opCH/XNWpNv61CnfpVkIzj36GuQXranthSmVU7pBz+YBeGl7SonQuhImiMJBVNOX
 hklGuxLTR/NjIfWpU+JSia0dxVi2HH7ngIj8fT4C24KWhuJZ1l/H/k4IEl3czKY/63Hg
 /XUFvzBvvcUECFEzcphxDKATAZ99+hsHfUkhU4X42JacNyfqlno2hiCn1+LyWR+gWIOE
 dmtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3E+hoEDKRTyxZG8jrSwf450+lw1N7zncnFhPaENhd1Du4DQGcNUXSLT4R+X/b/mbXWBY5ZwQB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNHtZRqYwVZNOBqb5DkPLrZ1X65xNMaxbeoGpMUK86ZDhQCI9B
 p33//IhDAu9pj8gDv9hJcm3OYr6aa07ud2Hhxy/mnTstx4N1SYKJ7euMPpCDX/XHnoqdij1xtnb
 ry2Pw22PLp5tRDv7WusYEAIEav/bLyYk=
X-Gm-Gg: AZuq6aJYTE+Y/LqnuLJ65nv5EchhLvqHPVO+uCBihcpG84LgZfT/UK2SJ7gSvvWXsT6
 jN3QCy873Ftc9mbFSs1HkK6kiS0S4O5AnAPuT+aA3gmMqp7ZylEHGSk7IDq1bNFRgQqE4BB/jz2
 q0/nQ+ukUqNBKXbOnAf7TOa0aYVJdglGK3yhKk/Ympq+AcgwoqznPNFLhMCxBGXPK4TqG1Zpx1z
 q8nLtWI1I31Dvzwc6qgRc3eDUm4aeYKjI6lFt6jrrl/K9WilBWKM6BlonUHdrBP6DCzdj+xiXxO
 sJbMHLj9/ySQuGayaiYxYW/bNLZr2ID3ppH9gxZlNgxA7qpU9GnxOdG2+hB/ajkFR4TXm9Xe1Kn
 isOM6sw==
X-Received: by 2002:a17:907:728e:b0:b8a:e013:9c5b with SMTP id
 a640c23a62f3a-b9080ec254fmr125502166b.4.1771653253038; Fri, 20 Feb 2026
 21:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20260221034402.69537-1-rosenp@gmail.com>
 <20260221034402.69537-2-rosenp@gmail.com>
 <2026022132-gem-stylishly-2c49@gregkh>
In-Reply-To: <2026022132-gem-stylishly-2c49@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Feb 2026 21:54:02 -0800
X-Gm-Features: AaiRm51WLD1sxY9MNhXBFSAsYS9PctRSAkLeekgnCI2YpU7VawQg_l6hW2FQy2s
Message-ID: <CAKxU2N8g+BRzyZ=5dWjrL3Eb4zRz-_yfv29tfJL2uvJpZWZUcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "drm/amd/pm: Disable MCLK switching on SI at
 high pixel clocks"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 "open list:AMD POWERPLAY AND SWSMU" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:29:06 +0000
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

On Fri, Feb 20, 2026 at 9:40=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Feb 20, 2026 at 07:44:01PM -0800, Rosen Penev wrote:
> > This reverts commit d033e8cf4e8f6395102cdbc3cb00dc7cb9542f53.
>
> Why?  You need to explain why you do something, not just what you are
> doing.
Not sure how to specify that it's a requirement for the second patch
so that git revert works without problems.
>
> And this is a 6.12.59 commit, explain, in detail why you aren't wanting
> it reverted anywhere else INCLUDING upstream.
>
> thanks,
>
> greg k-h
