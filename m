Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DE6C5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 17:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2506910ED2D;
	Tue, 11 Aug 2026 17:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ely88fgw";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2887A10ED48
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 17:25:26 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3856d4015e0so22168a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 10:25:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786469126; cv=none;
 d=google.com; s=arc-20260327;
 b=klKm633+xmtEMiVsvBNHlRjHUlGYxCZ44kRncIy2+BNYgm0lZAcVr1h8mFeWHAyVa/
 HxPxwow3sLJ2ESSsfv34dGmCD83NXYIa4SpdNP2vbv11lXoBMvix/g9rzpiroon9XI5a
 KYJGV0iNyw005qqCfCuPkocg8256YAsv5AvJ4pmX9Z6KhvpMBwD39OgT1Sxmosa+4eAn
 CCpZDuf0uxnwHgGvNQCBiz7uPzf0z3fNkSjy+0QVOAVgLGNVKmLRzvehOFKNO6+OTY3d
 h0z12RbKekB/Jrdcu7sNSky4sYnducxoFarnOuqfrk+d1Rp5F6q6jD60urL/IIzRVJ1I
 0KmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VnCf0z9Ked0EoU1PHfiMbSxVtjmvWOlMFbDKXa+KErw=;
 fh=/nOk36HOVq4tZonIn1/aZjCx65V8Xs590AoBbzELtw0=;
 b=G0vLPPwhy7SOIXulMXv1cDehS3BJ1puHC+ssSXmImxKIgNk8DXXUQOWq+1TBzfpOXn
 keRwyBwm6xRdWXwp97rQjwsqw/J0nW2oK9o3wcLOXtUJAeRBomz9ow5z4cbZ4hiKVF+7
 MF8ZS2F/YYwhhcdIpIndxFCN9S49iVmzZOnRwCM6rLq4TgX4GmpExojxgR6/2uhHoyaQ
 97C1H0V3V96eeXikNvmBzUFFdnRLRXgbGG22T3twMhPAiBskx8gjH5pQna64WBezX74e
 ZrrByPOVUf5kMJgYrNKiwLKX7cS8CJzmbkVaeCxJsnJM6UbNsK+hashBXU55QeNyzaWl
 0XlA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786469126; x=1787073926; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VnCf0z9Ked0EoU1PHfiMbSxVtjmvWOlMFbDKXa+KErw=;
 b=ely88fgwSeBgsQsflIWvQI799whqIzQR4LHsNWUftMcBGcYhGdz69aJYvxVXFgBZT4
 9LaNMnCb6PTSSMAfRgPAK6BjfJ5nuE9eaK5X1okdkBqb1wpf+plI4xJhdqYFzDtG79s4
 ZwM1E9l4u8Oafa1HbpqE5lBZvz1guM6MXxevuiq29YEEOE5KjcZDDLqxvQWKRqI4i2aI
 awQpDfpxj7LCJHIUQVn8uDwLAvoMXHQw7x3AeKIoO/VtJYbq4BqMKxQGDINPSMVJNpoQ
 wMBDjOB5rxe5egOl4zYmuhK3JVTVzFyd3h9nJ4obkBgKhlhY22UhfQpLhdsOmWKQinhn
 aPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786469126; x=1787073926;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VnCf0z9Ked0EoU1PHfiMbSxVtjmvWOlMFbDKXa+KErw=;
 b=Gk/1VXZOeCosR6lwOO0BFyZnvKlu0r/miU5dSCrzh0UCGZJ917kFv0dzzi0+cAj7Vf
 zWBSZgCNhRaxKR+A30WrSSBy9X3MsRFxN4YOg9IoWla9wRE09zW8SUFQD/6DZm+gIM9D
 XFho5Y25+heyNF7W7WehAyN/gfghKjvVDrI7Dr48DYHFWbJ0jEtIUbaAboTQi3A1RQum
 KqW5I0TBSfvZP9b1jpi+2XiItBE1JjGo0BjeiseWO1WLGKXYyJ4Ae7IQ7LqTS/wPNdM4
 4S+DJZhNUnAs0Q+yFDkc7VC3NrBUgFmU2eh7aWfb1X3HfoILbuHHBNhDXOThKHQ+0GdN
 TeHA==
X-Forwarded-Encrypted: i=1;
 AHgh+RopdeyGum36ka16nDPZFNn2tOTOwOWR19jaj93DB6JI4pl3f5itooR323UL+VeB+tX7k9k7BGFw@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyx2QUXvkV7TwYnH2BdKqey79+/sG5n1AX6SJXoUDJOhxZfw16n
 phdB2joHHxWUsBzR+L4ff1giJSkcQkz7kEFibccChIxJ9fh48i7ba6fqox/E1xCwCEEHUgFN0YN
 QXCpv1ykIsc5rbd9Jtb+gExzmxixrt2o=
X-Gm-Gg: AR+sD11PL51992E8jytBWyGxXG0fWw/thvO6xyoYG5COUTT9EkW9Jrw2bpKf501feE2
 LjN6xziWvwHABbZi7YwcZD8ryf2VXNlOWcc+iFkbgv55ATICYQUd7BU4YWFnbBgsKruID3+kIDn
 5mNjZwv9+3MrKYSuHQvNESS3SQlQoZZOSrFAj1CeHPedQ3KPq+CHPAoDNjJI5MP0BAqCtpiycnA
 ZrOJt+6LVK28rdhSITg1p7z8KtHuxLP/D98Z66QvNl7khgBTgheqIklmsgMRjFC6vrG28vYvQhn
 GvXbsoiEYdmM9nTB8SnSxiFFQT4qGx6Q+Moi3PV/1QqtjbkhFXQoys6NAbZaHL519IrPyZDd6WN
 ZGuJmnrXGALzbOky5DYIZTIslVW/tGw==
X-Received: by 2002:a17:90a:ec87:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-392ec4d2710mr3743472a91.1.1786469125571; Tue, 11 Aug 2026
 10:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <9c6acb62-4080-48e6-9ba2-d1c457c4ec88@gmail.com>
 <2026081106-pebbly-cahoots-37a7@gregkh>
 <23db5f95-c2d6-4712-856e-28f647e184f7@leemhuis.info>
 <1caea72e-b9c8-452b-a3ff-5690d948b4fc@gmail.com>
 <2026081151-reabsorb-calamari-7442@gregkh>
 <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com>
In-Reply-To: <8a0fad2d-788a-403f-a880-2f97c6708275@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Aug 2026 13:25:14 -0400
X-Gm-Features: AUfX_mz9ctPsNNIvI5n7PNT1dVO_8-kv7BTU0GjEEq0Wv5KbQ8xlxsfBpZDT3qU
Message-ID: <CADnq5_Pb=ox3nWfdpb3Qeo_eSQayuc7UqUOnm0x+WS+EQTVWjA@mail.gmail.com>
Subject: Re: [REGRESSION] Please revert 1191285ecb42 from 7.1.y
To: Sergio Callegari <sergio.callegari@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
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

On Tue, Aug 11, 2026 at 11:25=E2=80=AFAM Sergio Callegari
<sergio.callegari@gmail.com> wrote:
>
> On 11/08/2026 10:08, Greg KH wrote:
> > We aim to be "bug compatible" with Linus's branch, otherwise the
> > "pressure" to fix those bugs goes down.  But I defer to the maintainers
> > of the code involved if it is being worked on, and they want it
> > reverted, great, we can do that.  Otherwise we prefer to leave it as-is=
.
>
> I understand. Sorry for asking about things that might be obvious to
> most people here. My expectation was that only a selected subset of the
> patches on the Linus' tree were to enter in stable, so do we really need
> to have stable "bug compatible" wrt this bug? The original behavior was
> not free of issues, but they were rather minor (a reporting issue). Now
> we have this very bad behavior where the display remains dark.
>
> To make the matter worse, on systems that have encrypted root the screen
> remains dark also on that password prompt (observed with plymouth).
>
> In any case, I managed testing 7.2.0RC7 and it is fine again.
>
> Looks like the Linus' tree has more changes wrt backlight, and the
> interesting ones are probably those in the cumulative fix
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D973fd9493ec21f12e760fbbedeb7b0b2317c02f4.
>

Thanks for testing.  It sounds like we should revert the change from
stable.  There must be some dependency we are missing in stable.

Alex

> Best,
>
> Sergio
>
>
