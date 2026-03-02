Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59026EC0488
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Mar 2026 09:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0948310E77E;
	Tue,  3 Mar 2026 09:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=yngvason.is header.i=@yngvason.is header.b="XTK0VG55";
	dkim-atps=neutral
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00C5610E521
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 15:07:50 +0000 (UTC)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-64aea64bf15so3888266d50.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2026 07:07:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772464070; cv=none;
 d=google.com; s=arc-20240605;
 b=VvNU9KxkwLr/LWJCUoK4VfxiN4HlzHaWTfba8B8azcedZ9drvtCCy3I0aXp7x9UxN8
 +JzLfXPmfs7ii6HTffav2UFsoX8ixTb5J2JJd+FGld2QaQqURvTmBSkmL4lNrPmOKopX
 6d9HSMSryz0SUcrQniTnNQP2c638Nv3665XORT4Y62z4oJ2hiJildxoKvnKslY/F/yMh
 QFq2QWB+lrbCrwawuDQiSFO7XxmIefMS1nc4J2RPTXB3CWAEkrMFjPloeVMoatQEby8d
 TmgNOovoriIFW2RW5FRUpnOkq0q0Skn3sr7Ff1WUnHJA1pmRbI1G7D0Jpw8gxmrsyjiW
 Na6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+gDTORrI2pQyWVeOn4meK1oMBrguCe1b/ScMwN2EmY8=;
 fh=AHbeDQJvqwNJ6+Y6wdM6uwuukqvxgo5gGshEMVvR78Y=;
 b=IXAGirxgmt698ByRRR0P0y+dZLsWM3bV3ix7435c/Jo+pJk8GABIFP3OBfOEuqkCkS
 0E1+X/ufkxnJUfNH99SIJubDnLM2QcbDSZH/ye0WFe5DpKXqdcpHdo3KnEC2t4kmpUcJ
 xY4udTuy2yaaFDb5CUEgPgdssNrDrlu913BNs2adE6M1e1RMEPxzchjsDabiuTbENXnM
 vR9JXysMotjJ4sQ8rbKIdWQLq4ZfMXnFoI5A6YeEPVoN2OS28+HA+n2SdJBfzfmAKsBV
 3A7210ZQ0jTZEzqBkt83QsYzTIYJv51lSg198Q+5hFJkXTY41C4LTJPV8Bie4hcegCFX
 w0xg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1772464070; x=1773068870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+gDTORrI2pQyWVeOn4meK1oMBrguCe1b/ScMwN2EmY8=;
 b=XTK0VG55hePAbMb19t8yRWiq0ocGIb6Q0hk42Co9/9oi++86Oelhu532rQObN6hH+a
 deT+Bgi2MDiDubVofKCtSe9Tbbm5cHrzXGqPke44mMqiFFD40kp7hiNFE7dg9c3VHrgF
 2SYctykfde//3kG9NAYjUK1c8X5qikuArzis8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772464070; x=1773068870;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+gDTORrI2pQyWVeOn4meK1oMBrguCe1b/ScMwN2EmY8=;
 b=w9Kgnn1NkeIgwcXGtD58fY34LSBDoYOkZUJTksfqhcMnEeg5wiFImA+bFT21g72NtK
 1q1vOEaAYa5y/mt7v9mVxjoydOP4KDbQUSKLwV9JWeOjTG71atElN1RqyEAyawovWRjg
 QFGQWVR4fXlNQ3eXGkYL0CdE+S5fnMeamRQWZocYKyvW8vZ9JEZEC4zrpmLV44UGo5mH
 tusbUQRyI/rd9/Wp5UCHK0K12zc8bcxUXfQBBWwCXHsWQsOs8nRzcuOD10gzwjSJhPLi
 o/9vVGUxxj2YOl4Ua8mm0MR3WcZdbQwUgKitjYC1SA5P5a1SfakLK/J8XnnKnwx13nv1
 hjgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/9RTHLM4/hqaPb41UYQocSDGfLJbnafsqXtikZyd+zbzEZ1QAUM5HCNUUtX9mHkZu1hNPQKdT@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywi0KwkzhRQjnuXQ5ZpKbNB+VGkos1tW67hdLeSu6RvmcUNb3uv
 72WzsMC7Zf5attRAQ6fuFQRZjZcrvZwc7t51NGrCeGnfAF9Ww4R1VvNRO1xCLTfWUKBc3z5CWa9
 L+9pArUN3kQiZ5Hs/w+pV3GxPWX81awyQcZZezTDX4g==
X-Gm-Gg: ATEYQzw6zeA1YYAALjV/l+yFmxqVubSoxw5mP5M7Slc3tJbRNwbMm6tmsqkhY/2pT58
 /dC/AtSfMiieRmqBlpp51S0OfRAT2uz5g50OinlbXpgbrwilA8VhpjWlXnqft3ENSegHo/xMpBA
 KRSCzR0QRXqXuicqr8ZX6jekmj2fnT8/MM1LR1YPzW+sbNwKLwAB6rzTKEJLX2fMu8kOwVvMZOs
 1ChV4ulbuo7cocUUhxylKzdEUqVghQJ+kyM1wJ+d1doP8+RLoeF3thaL0EgL47ApeN2wb4weEYG
 nSHzQt/tClQJzboDDORUzp6D3JDvWjS7rfLME7g=
X-Received: by 2002:a53:ab0a:0:b0:64c:c1b6:714c with SMTP id
 956f58d0204a3-64cc2379297mr8671268d50.70.1772464069335; Mon, 02 Mar 2026
 07:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20260227-color-format-v9-0-658c3b9db7ef@collabora.com>
 <20260227-color-format-v9-2-658c3b9db7ef@collabora.com>
 <y5ybjitphwydvtcjdtrmpcx7t7hwevjszpktcnmyvjqkgzinmu@hoitkl7lghxh>
 <5081457.31r3eYUQgx@workhorse>
In-Reply-To: <5081457.31r3eYUQgx@workhorse>
From: Andri Yngvason <andri@yngvason.is>
Date: Mon, 2 Mar 2026 15:07:12 +0000
X-Gm-Features: AaiRm531VbuvPlDMvL8ehAEpeh4QP_0yXJbIL2OEHZWnP0es8QNn2W0TYwz5fEU
Message-ID: <CAFNQBQymuv0roy_xupcgU1bHygfBeE3S1FepQYxpobLq8O0yEA@mail.gmail.com>
Subject: Re: [PATCH v9 02/19] drm: Add new general DRM property "color format"
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kernel@collabora.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Werner Sembach <wse@tuxedocomputers.com>,
 Marius Vlad <marius.vlad@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 03 Mar 2026 09:01:28 +0000
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

Hi Nicolas,

Thanks for carrying this forward.

m=C3=A1n., 2. mar. 2026 kl. 12:36 skrifa=C3=B0i Nicolas Frattaroli
<nicolas.frattaroli@collabora.com>:
>
> On Sunday, 1 March 2026 17:47:48 Central European Standard Time Dmitry Ba=
ryshkov wrote:
> > On Fri, Feb 27, 2026 at 08:20:07PM +0100, Nicolas Frattaroli wrote:
> > > From: Andri Yngvason <andri@yngvason.is>

N.b. this patch was originally from Werner Sembach, but it has grown
considerably since either of us touched it, so I think that
Co-developed-by tags would be more appropriate here.

Best regards,
Andri
