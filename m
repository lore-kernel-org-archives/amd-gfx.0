Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04410C5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 14:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5792E10F04E;
	Wed, 12 Aug 2026 14:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kFF4zeti";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A3210F04E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 14:49:56 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-ca5b707b78aso66198a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 07:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786546196; cv=none;
 d=google.com; s=arc-20260327;
 b=e9tREljm/4RKkUl39o7zfeRyp6f9XcHqHrS01Sbm9LYZpPZrX4gTcLxXVXwxfQVQOk
 22ZIE+4C41lVE8n0EikN217kve/YNPZCtKeH0IfZ0o4amFD4ZJ1kXF7pbBU3yAv5eSMT
 LDL6j4dQrySwaGwz2wgPctSyge64pmsQ93Dw8jOlpqKBlU9H/OK/U84nXoLAfjLvip1M
 z8KK7MGEgf5pZLvRrV9CMSKFS6MbVNYj07iSoUvfQI2R9egKcn0gcHVjDQ3RG8Nfu7pX
 icopbvNuL4q6/jMDwKNqUvPZz4PjuKBJhf3p9mZX6YrfLQ+F22pERw77pus8+CbwrMC9
 jt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ot/f134CaNd2ZZh1uYzIr3IyXzUgXu59DTxBXmvb+90=;
 fh=mgb+bqs/tKmtoPbLcHGEtruznyVk1rF3ldfPclhDahs=;
 b=ncUUBMUgk0dXIZUaDOKYH8o6GKEQw5VGkdBJhXw/sN3SnEsHoQdt0uMIvtIuCE6Dpw
 HIpdQu2hn6EzD+D0yIsUXScgNacBzBrgi9trdDl4GgggVA7qnMm4lpjKiikFAUGBTYOK
 WlMAl39FDAXj61HOZS9gp199va65bNUDadkouSyptfBZL7TkRfrivrEHiwMHYF31wI0d
 PknywyJcJ3tX408h5Q5d/HNQl43FsIyC/vo1gSxAlFZUiymCWYSuMnvOqriW5DzXAN01
 /43gpbkUu0fAy8huSJzDZljnRuVkjDCSOAU3m70sIbjc+gtRCllzFxjZE++1mjV3ml9h
 kryQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786546196; x=1787150996; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ot/f134CaNd2ZZh1uYzIr3IyXzUgXu59DTxBXmvb+90=;
 b=kFF4zetiOzIp7Q7Z2r/lwKrubvsRRRtt4EjDZxSCgMBDkVBfZv1fPgqOIfWCIDISro
 rTUf7SRdj2NH7QoFaT84P6wim08mZE4hT7+vZjMRC9ARf6I2ZFtfc0AXj2TTP/LtavQs
 CaaAb3o+LJyTwaY5cR9RR8rh4aqDtErAtbQ5X4Misl/D4MVfx/3f4j+B/WTlSWxGpwCm
 rDLtOXGHUE9oXBogwfF4ejxIG292X/KZTclmOrDE56LBWpsW8Lloh0bCOlSawg9afVA3
 TiL/dX9k8f1NiB1QjQhARoFjUkn0tp0a/R2F6ZNVGf9//nUanH+MTOyBn8NP3p2eAngA
 /N2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786546196; x=1787150996;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ot/f134CaNd2ZZh1uYzIr3IyXzUgXu59DTxBXmvb+90=;
 b=nwwDre157+NVkB+OEmHwHGCGv7Hu6EySrlx7WMloJ2cPDX+2ofSvYGhf6z/ptBSPS6
 RDwjiGmysZJxUeqcCW2p+hiYHMBuXuEK/YPjmD/nuSU2Jm6w5dCtQPDhB1XebdZ90BN9
 8QvJ+z4lUr1Gfh52lnbj+oeV4ZeeuMbxWCeWqJgjiwnAsIM1dyEPDNyeYxcJ9V5wkJmy
 WVT0Uj0RRX5MujiQu+EwTeIaQjZ7qJ1QoCDC4pU71DBSXIIkdb2dipxwiDr8n/VqgK0x
 a5TM1rmbl60iC5AosVBGwnBy9MZzQPuBmtHYa5yaUb4Nqi1Ke7+w7aPAI+jPGiBj0oiK
 pSKA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpuvODd0hS/710P6C8T3XcYXQm6ffobNyBx+DibZXlpoFCaS7UPlagy8CPfvQxrjp2pXjrQZ2eG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUgjCgcHmgVA04fmDwEcmPvpvLtEIByu9F/GDJETzjQW4GgjWj
 Hi1yQShrEXZig5zmzn1x1qtzFk7dWPrsTqpPiIqkouTpHsFWCWK90jgks1/lLAoa2//TYfKRQeu
 ZY8IrFNPtU08gMpY/03S1tsaQcIy7QZQ=
X-Gm-Gg: AR+sD10Snr5sv0Png6sqoym4qXqxYcUQDiSRf0kmsuag+iOON1o429c44ybqXJln8/G
 83GS0KPWVQ1rKvKiFNAPLxn1SkofP3jTYb7+FsY+RPxrReJbUUYHP1sqGOOc3ToaykJLMDE3pj5
 amAd5TTjEd1Calo7c2RyQTD6coduSzQudpbuRHUMM0CocNiVRUe9YnKAmQE1n2fj5lG5+hPBIyJ
 zJ8uznju6RARU6KRpz1Z41LbtEi2ItuTWnniTNc4L8Sq4n6GlWa6VMFHAcodZiQBfM/90oCyazP
 NJAP51BYUz7Odhz28Vp0vAERhSe/SVJRzteTXCg8XU92nUNOlZKtLwFEkZKsVKj6aHHBb4Mq/hy
 4p7hjjMkg4sWvVPD8TL9qdZ4FExMhZuo=
X-Received: by 2002:a17:90b:1c87:b0:38e:76f8:fcbb with SMTP id
 98e67ed59e1d1-3930165d7ebmr4278871a91.4.1786546196340; Wed, 12 Aug 2026
 07:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
 <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
 <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
 <2026081151-reabsorb-calamari-7442@gregkh>
 <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com>
 <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>
 <2026081216-goon-nicotine-6d62@gregkh>
In-Reply-To: <2026081216-goon-nicotine-6d62@gregkh>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2026 10:49:44 -0400
X-Gm-Features: AUfX_mzj2HCarj37nq6qUUz4-f_2TcoeI2QeBqGSJvYG-vDLTLtMkqvEmu0fq64
Message-ID: <CADnq5_OySMeizELEwN7Okjc-SKRJMvO6dN7X-zwPp_eQuz67hA@mail.gmail.com>
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sergio Callegari <sergio.callegari@gmail.com>, 
 Thorsten Leemhuis <regressions@leemhuis.info>, stable@vger.kernel.org, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Linux kernel regressions list <regressions@lists.linux.dev>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 George Zhang <george.zhang@amd.com>
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

On Tue, Aug 11, 2026 at 8:13=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, Aug 11, 2026 at 01:25:14PM -0400, Alex Deucher wrote:
> > On Tue, Aug 11, 2026 at 11:25=E2=80=AFAM Sergio Callegari
> > <sergio.callegari@gmail.com> wrote:
> > >
> > > On 11/08/2026 10:08, Greg KH wrote:
> > > > We aim to be "bug compatible" with Linus's branch, otherwise the
> > > > "pressure" to fix those bugs goes down.  But I defer to the maintai=
ners
> > > > of the code involved if it is being worked on, and they want it
> > > > reverted, great, we can do that.  Otherwise we prefer to leave it a=
s-is.
> > >
> > > I understand. Sorry for asking about things that might be obvious to
> > > most people here. My expectation was that only a selected subset of t=
he
> > > patches on the Linus' tree were to enter in stable, so do we really n=
eed
> > > to have stable "bug compatible" wrt this bug? The original behavior w=
as
> > > not free of issues, but they were rather minor (a reporting issue). N=
ow
> > > we have this very bad behavior where the display remains dark.
> > >
> > > To make the matter worse, on systems that have encrypted root the scr=
een
> > > remains dark also on that password prompt (observed with plymouth).
> > >
> > > In any case, I managed testing 7.2.0RC7 and it is fine again.
> > >
> > > Looks like the Linus' tree has more changes wrt backlight, and the
> > > interesting ones are probably those in the cumulative fix
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D973fd9493ec21f12e760fbbedeb7b0b2317c02f4.
> > >
> >
> > Thanks for testing.  It sounds like we should revert the change from
> > stable.  There must be some dependency we are missing in stable.
>
> Great, can someone send a revert?
>

Just sent.  Thanks.

Alex

> thanks,
>
> greg k-h
