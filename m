Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10666C5CFCF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ABB610EC7E;
	Tue, 11 Aug 2026 15:24:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="dtJtRIgs";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D97910E2D6
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:24:00 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2cca0c5799eso915505ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 08:24:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786461840; cv=none;
 d=google.com; s=arc-20260327;
 b=KCNNPvQ8WBWsE9DxpQs899i3uFgcJ/VvMOomTIWbAGVMElA1he4QxjvH3nQcBjUGAT
 GUW+UJCj0jCgpVNorQBM1cdw58zH2Dn9O7CDlkZwq2Y8vxKyetKUQN/KrqE9Ca1W1T0K
 zVdAwNnFMK+GE42REEq84EnlfPkJ1Ufr0LnoWFaBd7YQsRSMsf5OTvPcv8wJKPdCODVW
 yuzjiVHylOyezC5T7wDYVvC/lFGpBwGwCp2QBEwVL0orLmRWXkkHaRZQWZuXydGLie/H
 PricGH3/R/a519pcPOz4/4vHHesTdbLeu+VSEYOYD7CNYJcofMsVn1Re8bPQXrEYq0Sj
 Nuvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/STLSUIb/DMEpP+keoEG4UtLhN4foCJA+kk3jcncjDU=;
 fh=VPsdO+Ri3gVaUfiAfBr0ptaxJaOERshTLSzhNYISD8U=;
 b=pUWsc8eh4tGAefOb5trdXcD9QEtGgcpoNGgmuei2amAtjzY7NXPfHcSxqAvkrSdhYj
 cf9hnAYpbBLrLLn8MJoKyvW2aoeYzxyKlpXCkHEpxlTouwRuZy5E1L2byzaFFjNDPOpp
 VF4zRQlujvIP8afIxr6YXbwSkTEZLxj1RLDFHzaz3jKxXXn7lSoEeVd53KvPzWeF7t9n
 O6f5c1hfdyMLm364fenyZQR6wUOBawg8JYBAAatsBuOzDMI89Y0hBMs/4wJnaIDVEC2l
 fMvksYlKGePI4/PuVQeZhdFQFIJ9uY+tRr9YuZQh0fAnQ1fFSExSCXvYnO5CbHOH+i94
 gAzA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1786461840; x=1787066640;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/STLSUIb/DMEpP+keoEG4UtLhN4foCJA+kk3jcncjDU=;
 b=dtJtRIgsDQcVVEO7a5MSvnArg+lQV+BQb2dezL10wMS+s+eQVm8x98kBU5WGbUsb9Y
 X0kPaXRR8tgGRe4tbYivIfi9ACyT+h7U6b9lnbBwKIHFZrTfvb06Ko4ICeTIXzPvISfE
 olUX9mrSgx/sQK6u1ssIxFxjj+7DeEq4hUU1gCXPEkQGoifGvqCVtBaQNe2InrEjSnfU
 VVvRijQDAw/TVzVfKSurQbYAM4i8+/GpBSP/nt7ECkTMauFzA5GxUraEdSwxmU2oJMWO
 UpTJG/g1yhl0QsI1SFMx9NmK0tG7uwDE6xdsuLs60nQj9tZNaAsQPrj2helHjZ0bVJw9
 nZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786461840; x=1787066640;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/STLSUIb/DMEpP+keoEG4UtLhN4foCJA+kk3jcncjDU=;
 b=YozXK6s9yi1Q8/Ino5xonWy1vXV1ZLCRrHFeEaoKb+TDq7WtA1FY/FD5KC65ypxC48
 74dxJP5r0P73uZFlqt4lkeRMjw1EI85fyPVZAMrQIGkmbUzJvs1xlUV5LIOak7JUXH38
 bc3K7ll+UbLXJ3fne6pxCtHfBbn47eKM6WVYV2jpP07nPhJIriAlUrvknWhS+mMHKIf1
 I6CbzluHOuyv0BRJxSHaTUXCcDaRL+xEORXgWXh/xS+eEdOb4Sgntw+UiGMkR4oOnd7s
 DiuPxpwATY/1haEnK84y0VQb4a1udPDwXoyH4S2D4o2Aa0u6i5V2oYDliLrquZGMW0UO
 6DZA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOv2nfTt1sqICVIXL+n4uWUHFoJZY8wtRjxoEoTXtmcFzGltqYiekz3K462svYXKsAnlQLmDb7@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywob0fk/c0VbRX638VWJmsPKxmJVBOhnfE61fMwSUjry9DHUEkk
 7yRy37PGbtb5GD4yF1GeT2JmAa7+R5vZ0sjVbGYzYT6O1ZGFofacm68XSJb3+RZ7uOFjRTR1pxt
 kyLOIByClBnfBTNzUf5FTazWN6+mq+PnmzLEDj9Qlfw==
X-Gm-Gg: AR+sD13/QiYvIEPGImQNbW612q51Bz8i4elgQzW+u7N0NWTxZm0TxOGzEAd8Szb7gcY
 1CzNoWGmBgcggUxhF7R8k93IGzoU+jpXXJSSvxbAq0ibFcP3gG4I22DXFmjxWjv75tfj+++9jUh
 h+18LXFVrcdbvUyrS4Th61XbpGl5/+YzghXTSaVsmb2zZelb68TMQYofqEYxdQpqIwprxAwboHZ
 NdnkzfVOT6aWcFRQAERX/eJbXLnk6VjbFrQURXcWOjhttgiW+avTv1p8gib05Xbp6AHf5+6fK93
 C4m9I/pLak3PUicFzqrHL5rWBMu3R5rd089iNRVGyg==
X-Received: by 2002:a17:903:2405:b0:2c9:c991:6ed3 with SMTP id
 d9443c01a7336-2d3178c8ad7mr53856565ad.12.1786461839554; Tue, 11 Aug 2026
 08:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-5-jerry.zuo@amd.com>
 <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102019ff114857a-259b7f40-8202-425a-bfbc-71bb92acf184-000000@eu-west-1.amazonses.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 11 Aug 2026 16:23:48 +0100
X-Gm-Features: AUfX_mzW4vpKvpSLOTXQ7G_2xDxw4RcITaclPpwkDi_AI9CwVUZdC4ZfVyrenos
Message-ID: <CAPj87rMSYC0wKP66p5Q5uOL+-Fb04-gYJFcRxdxxZ2-_du89GQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amd/display: Add HDMI ALLM support
To: Derek Foreman <derek.foreman@collabora.com>
Cc: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
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

Hi,

On Tue, 11 Aug 2026 at 14:54, Derek Foreman <derek.foreman@collabora.com> wrote:
> On 8/10/26 7:39 PM, Fangzhi Zuo wrote:
> > +             /*
> > +              * Enable HDMI ALLM (Auto Low-Latency Mode) when the sink
> > +              * advertises ALLM in the SCDS and the content type is Game.
> > +              * Setting content-type = Game is how userspace requests the
> > +              * Sink's low-latency mode (HDMI GCTS HF1-56).
> > +              */

Is it mandatory for the source to set ALLM when the sink advertises
ALLM support, and content-type == game?

Is it allowable for the source to set ALLM when the sink advertises
ALLM support, and content-type != game?

> > +     /*
> > +      * HDMI ALLM: transmit the HF-VSIF with ALLM_Mode=1 when the sink
> > +      * advertises ALLM in the SCDS and either the content type is Game
> > +      * (HF1-56) or Gaming-VRR is active (VRR_EN=1, HF1-58 step 8.3.1).
> > +      * HDMI 2.1 7.6.6.
> > +      */

Is it mandatory for the source to set ALLM when the sink advertises
ALLM support, and game-VRR is active?

Is it allowable for the source to set ALLM when the sink advertises
ALLM support, and non-game-VRR is active?

> Tying this to Gaming-VRR seems potentially surprising. Gaming-VRR
> doesn't mean we're playing a game. We might be using it to play back
> judder free video (where we'd like ALLM off to preserve the sink's image
> enhancement), or we might be at the desktop.
>
> I'd imagine some users would still want their sink to use all the image
> enhancements they saw in the showroom even when playing a game, so I'm
> not sure any kind of "auto" decision making in the kernel makes sense at
> all, even based on content type. It's a very subjective trade-off.
>
> To me, this seems like something a compositor would want control of with
> a simple boolean property.

I strongly agree. I really don't want to see more magic implicit
semantics unless they're completely necessary for some reason.

Someone passed on second-hand that one of the reasons to do this was
to make it easier to support X11 - however, if X11 needs better ALLM
control, then it can be exposed as a connector property via RandR,
just like content-type.

Cheers,
Daniel
