Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBF6C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 10:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D54010E4A2;
	Thu, 13 Aug 2026 10:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="dgphkjyc";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5505510E0AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 10:30:06 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-84a4d8fd6ecso615593b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 03:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786617006; cv=none;
 d=google.com; s=arc-20260327;
 b=pmA6jv8paFXpJ7B2KW+oQnZAgdW0q7czORpQAQQohPsbfI9VOo0Nxj1JXqX1bUznn0
 HRzqgVzoG7p3QgNK6U1NnnTLIutMcRpWQhqkHWfrcqeP6/TNY8d7kwKbmMo04vPL5BwO
 VUnduCh6WRukRP+qqLbtRiQWMEpeBYK6BU/+tpL/L5ecpmQ/CazpfsdJwN+3VSsqT8yt
 yYFHwUlFKBzZA0GL1hugi8aAkK/0zJAAwwsjfjBjr9atisD3DZ7XmLQiztzyPOemwIhr
 2xcLpEiIuWn+geD5j0NsTbghQbFbhduKoWC3/PcU25d+oNZYxPjTgMUk/dR/MheuyV1j
 RU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WXpJ0s2z/yoiEHWuJMF9fdHN283vjFazEZaxaUcCo5I=;
 fh=osGbdIexd8wDtakz7amC5nOx+xbi+k8eOWVFIFoMl+A=;
 b=RmCZe1Opy+xDcA053TBm/xkhi7pakM+bD90UUYdOPYp3RL1jD31/nYfJla5KCb4CpP
 qYcCLthvLmc0YqIt5x3x/D1qMXmsIiDfDo1dszX4unwZUQs0G33E41DrWAxIN/AQ2yaA
 2udDegBUUxdVR4MzXrw6Q7xOsMeP7sOKA2l+EG+lV4lkOJbch1e0NCZ6LSMoB0KWgE04
 aF4wZ4Bm7sjY4MIdSvON4h4p0Y3zwmbXRZG1q0YjzymmvV41oddoPxD+HgGiT5aJeYU8
 nS0tn2uDNe7TsypdSpCZR9L052y9U9mS1Hq3cxwpMAuPF0u2mmdEqgweXDK3tb2Dhb+s
 /BVQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1786617006; x=1787221806;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WXpJ0s2z/yoiEHWuJMF9fdHN283vjFazEZaxaUcCo5I=;
 b=dgphkjycg+cWzvWGiKjA/09JEi/G9rC3c5xINrgiunpMtCkEbW4rbsmAtFqt2x00xa
 l8KTDkHC7WJUpUg28dEnUpsKywUNDdQ6xyNp9s/OADHvCktukFoW7V0h1sHMbMNt7kdt
 LJXYgY8MZ1CGVi/TY+cEUlFKDLJmUqYeZtEKXkRZOSfwMo+hfEAVu6i03mLTZTX+cMnf
 j6CSvPMbg/jfi1wfdInvKLUhVyWIeLGc5NPRfvwwqILSowZiWtOaGuEYGDoc1LIcRTRi
 My2tM73XkT4vU0DgYljhsaDeQywVmDkDKQqC/jo31t1aWGlwanN7gSx4IJFQombKVAAC
 VbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786617006; x=1787221806;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WXpJ0s2z/yoiEHWuJMF9fdHN283vjFazEZaxaUcCo5I=;
 b=Jd8fYA2CcA2Q9AoZNBLMaL7tq9IrIvwU4DY80lxNMZeB66qlb4OliL2iyx9ALVvMYO
 Ctx+IYqtHA8EKyhJECeJDPIAAEZ7tdy/L33dgDmEqMKrF+hoig24Q+6eQyhWE6HaVF+v
 N/gL6w82AubHB8wZrePKjqP5U071XGL7e3KA67wkYt3oNfVEeh9UwmXqCHssgA7NYQdG
 LAihU7CIDb269F3ch56FlRSIuQv8jrydNZRXYfeUxbLA3wvkFLG3fGVECmZpQa8RcSjp
 ykxSOustFqGC1UL5y58ZptnmakVE8Wll5ux3ngma0l4z7wzo16yaYqkbU8BXXfqwyQ2C
 kVYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrR/YRtlVaGajvssCQc958EHfYQTnFKqxEM5OZugQbKq+VogZCwXtrxfPa7GLQ5CBakmOKx5eVa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwArDUC1w9KdbbKav6ji+GPxEznQtcXwlCGE+LxIowYAKRXb3Uf
 0Bt6MSADk39voCdPechVZmb4lTYJkuPJGj6LbwKT197VD0LjB2ne0B9FFMbfGBwBZVdALcphEk4
 8Tf95fSX0WWSbimIEMJYiNFHy+mgKZVtAtmEKnjCgl6BvumM/dGru
X-Gm-Gg: AR+sD10D1oe7rPIyREY7hH9o3UxLMA4DPYNXh3yGzxqbhhtUaZly3AsZ66Fxx412KWD
 DCr7qbTlcZQ7dDO3N7QNsXSLdwX72joAC2m+zadSEmT7XFqYcLrhzieNjGscEOUXVml39UzLkXP
 jithK2rVJxnxSXzeuc1SP6JFVBMuxZ9NuUbfEhwuVwvLwitAxHGME6fqUkAwemoRM+ox/8ID1PO
 3RrvobG8P54VDqjcVLceB7vSEsKDIkpau8k8Ih4W24PeEtGpa23rfe+9Jn9ZQr74bU9Mf3qbx6w
 bIJbO0C+k6E4ZkQRnmuLH1pQUV4wjydjocmcMZDM5bp3
X-Received: by 2002:a05:6a00:b47:b0:848:56ff:6ced with SMTP id
 d2e1a72fcca58-84fc749497bmr4495492b3a.8.1786617005678; Thu, 13 Aug 2026
 03:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
 <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
 <e7bd40e5-b0fb-47da-aae8-fa16838f9185@amd.com>
In-Reply-To: <e7bd40e5-b0fb-47da-aae8-fa16838f9185@amd.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 13 Aug 2026 11:29:54 +0100
X-Gm-Features: AUfX_mww3yBHM5AmV0obwFDMSKP_QrJHvyHW5GJ3zS0Ihbtesai0qAGpr8B-AgQ
Message-ID: <CAPj87rMv1si7XBC4QRk_5yhn5+0558VTJnRq3NpU4pT-LqVz4g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
To: Harry Wentland <harry.wentland@amd.com>
Cc: Derek Foreman <derek.foreman@collabora.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 11 Aug 2026 at 18:42, Harry Wentland <harry.wentland@amd.com> wrote:
> On 2026-08-11 11:23, Daniel Stone wrote:
> > On Tue, 11 Aug 2026 at 14:54, Derek Foreman <derek.foreman@collabora.com> wrote:
> >> Tying this to Gaming-VRR seems potentially surprising. Gaming-VRR
> >> doesn't mean we're playing a game. We might be using it to play back
> >> judder free video (where we'd like ALLM off to preserve the sink's image
> >> enhancement), or we might be at the desktop.
> >>
> >> I'd imagine some users would still want their sink to use all the image
> >> enhancements they saw in the showroom even when playing a game, so I'm
> >> not sure any kind of "auto" decision making in the kernel makes sense at
> >> all, even based on content type. It's a very subjective trade-off.
> >>
> >> To me, this seems like something a compositor would want control of with
> >> a simple boolean property.
> >
> > I strongly agree. I really don't want to see more magic implicit
> > semantics unless they're completely necessary for some reason.
> >
>
> Yes, though I wonder what's the point of the content_type property
> then. It's another one of those properties that's defined and unused
> by all canonical upstream compositors.

Poor old Weston, no longer canonical ... !

Seriously though, I see the point, I'm just really wary about the
kernel trying to be too cute about policy. If you want to use Weston
as a vehicle for an ALLM property, we'll happily give you one
tomorrow. It would be static as is all our current output
configuration, but we could also type up something easily enough to
implement the content-type hint protocol for dynamic use, with a user
configuration of 'enable ALLM if there are no games on screen'.

Cheers,
Daniel
