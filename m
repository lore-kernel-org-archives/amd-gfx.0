Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31615CA0EFA
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 12:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26AB910E475;
	Mon, 25 Aug 2025 12:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="BfF2ZCNl";
	dkim-atps=neutral
X-Greylist: delayed 522 seconds by postgrey-1.36 at gabe;
 Mon, 25 Aug 2025 07:11:20 UTC
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBF710E1AB;
 Mon, 25 Aug 2025 07:11:20 +0000 (UTC)
Message-ID: <88fec8864f2544df67113bf7282a1b2965a1eabd.camel@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1756105357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ww1l4kU6XoG6+pq0FKhmMqbZI3C0dck0vI2yup0Q6Ys=;
 b=BfF2ZCNlgiauBfEnpXCc3Mvuj0qOEvCEDy8EsJMvt6fCQMDuHPqMlB6uXl7vyLOC0IVykR
 vpBECokdqz0xm8dkS8r44Uq/24bw2dOqVAXLJvuYxAccZ+RDV8vVX12McBFOqotntKft+J
 xMyVG3JyVUQxpkjLiYfZ3mLa8yLdH4u7BcF8rxj+XZq1HuxKN44YRDXHMaWdT6qS56XNPj
 MJyhUlyAa2djoTKSfgrsbPhA+ZTYWzjJXjMscFOoMfO2alOJ24qjs3Ljls/uJJwaukE5Xb
 ZYj/HsTb9KlAQilavvZmdK3MLXbNAWlhXjYxGFUg8JnTusfXMvHFasjk7C8ynw==
Subject: Re: [PATCH v1 2/2] drm/amd/display: Adjust AUX brightness to be a
 granularity of 100
From: Philip Mueller <philm@manjaro.org>
To: Antheas Kapenekakis <lkml@antheas.dev>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Alex
 Deucher	 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Rodrigo
 Siqueira	 <siqueira@igalia.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Peyton Lee <peytolee@amd.com>, Lang Yu
 <lang.yu@amd.com>
Date: Mon, 25 Aug 2025 09:02:34 +0200
In-Reply-To: <CAGwozwH7m5CgGiK5Xu_q0JbJvRQbcHkgQd9nFXJNq3DQhWO7QQ@mail.gmail.com>
References: <20250824085351.454619-1-lkml@antheas.dev>
 <20250824085351.454619-2-lkml@antheas.dev>
 <CAGwozwH7m5CgGiK5Xu_q0JbJvRQbcHkgQd9nFXJNq3DQhWO7QQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org
X-Mailman-Approved-At: Mon, 25 Aug 2025 12:53:21 +0000
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

On Sun, 2025-08-24 at 21:33 +0200, Antheas Kapenekakis wrote:
> Well Phil managed to fall into the value 332800, which has a 0 minor
> bit. Unfortunate. In hindsight, every 256 hundreds there would be a
> zero anyway.
>=20
> Before I made this patch I made a partial refactor of panel-quirks
> where a quirk like this could go to. But I would really prefer not to
> do quirks. Ill send that too.
>=20
> Antheas

I was already looking into that OLED issue for several weeks. Changing
granularity might hid the root cause and you might hit the issue less
frequently.

Currently checking [1] which changes the first byte to 3 since when
DP_SOURCE_BACKLIGHT_LEVEL is written to with
the first byte being 0x00 and sometimes 0x01, the panel forcibly
turns off until the device sleeps again.

In the end the panel vendor has to fix it in firmware. If not a quirk
might be better specific for each panel vendor.

I'm still not sure if that refactoring is needed, or a separate quirk
function is more logical to be accepted upstream.

[1]
https://lore.kernel.org/lkml/20250824200202.1744335-5-lkml@antheas.dev/T/#u
