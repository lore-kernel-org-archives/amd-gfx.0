Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B20EC1425
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 12:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 539D610E143;
	Wed,  4 Mar 2026 12:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jkppyfbP";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF5D10E143
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 12:44:35 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4833115090dso69744915e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2026 04:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772628274; x=1773233074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHByxMKryOjmtkThOv7ygNgBhXzSd+UZ7YG3LhRsijU=;
 b=jkppyfbPOqu25R+wUGTuVOzRHl3jCV1JmqFCOfNn+TZy7oefDK5Ee4lpVEXIBtK7oi
 JQJQNUbiAASnQysGvMn06VirGsTsA+w8ATWz98mm6VVzUaViVs3K2xyoSslbM8+VSRx0
 4VEUZiMAOl018lK2Npa6qxRn8cLkBsUAipF5wPWaAUbq8R2q6BEwtBwtsRWM47Cktv07
 RTlEcBnWQw96/CG8r7x44qDwYW7MitfcJY5AvDf+GeFrhbPI0jxYjL9yBLiSidpKxHdN
 Yt7tCq12XeYXPzlRzPgt90tbmEFbH++e277bqbyOsKR/KImIVpJs0PMtEWwgeCLpYBFZ
 pYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772628274; x=1773233074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LHByxMKryOjmtkThOv7ygNgBhXzSd+UZ7YG3LhRsijU=;
 b=sak7aj9PJ4v9UjtISVl14JRN+sErb8SDTvAUjxQRigXfJzD+fu0ir3jjFOsYjpeFNF
 05HrIK9emrQ6lF2WOVD5glEreJq0DR7mGlAvNToyXebDrIDseNQDyxFJyF0WIzmtF+Y4
 wuN1eOghut4xHdgmHYOC05PUdiv5SIsh80RjZatvBcnDSjFEuKkHoYfa9jkc7R9+1MNJ
 9KbUFH6t7yDPoNnKpgi5/ZcSXZtn6RJJv1oNZcYJV7RfXeYkz8rsCDfaj5DTt2rVlB6o
 nzvP15nDCApq27CaRaDX0jMWs2YAMva/CuNgTRX5mcbDClJrdgJSRk9aubseNHiYEvO/
 qMIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP7lGQIhvmpL9AMvO4Av2pDQ/Q3Al0pRyvZ0GgYu6F570u8H3KROQZxxkcP/qle2Z0c76a75kM@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1LDaQkntl4s4K7tegLf6Rv/lCgYVbrbdMtLWFN/Sz8R6aAImJ
 KT/vY9Pj1DBQsT1jpD8Yz/h5CHPIcECEq8ZF2T/PBizsHf+uxFd6dAvF
X-Gm-Gg: ATEYQzyLBOEPRjJGj0VzOZZol8xR2S6BQNdI6EvUxc15aM4zXh7yD7vDE93fNrn97Ex
 7i/xxhGsIJOmG3f7YyB/i5Q6wz4ZiltV54KK9oZ/fcpNJcx+guAY3QwQMX6oMegtTY/I+OwVxZm
 q9/hhvOEXuCQ4GrkwJcnTpLjW/4pWIr6j19lt6dW5SM8Tr3osYmXGGOKfz0U7YHeZY75GKS3QQa
 ffcnlycL6tjbz9mZzlVbP2b/TpUcV59ilc90e+vIiobdRV3xH/QXTdfe/reOiCpXZmM8gJtMpe/
 uQwJWA2u0yjTWgkqCM0Z/UUPKrbrEjFa1aJ49ICImmbiJeZOBnD5zSy9t1iBhykf0aaHfo8r92e
 hXRpTGX456MROWygeXkikNdgSt5tfEBHZ8wbwIX2EI0aVEyGHHXgXZOOzKQA8YSwpOZpIHDr+Je
 bAzxA456subuBx+tECR6bkEuDTUxYAPsupM7AkXvSGz7OFJS4k3q+FKR4C8WiG0SAS4x9B+LTHe
 sq16YYb
X-Received: by 2002:a05:600c:1e2a:b0:465:a51d:d4 with SMTP id
 5b1f17b1804b1-48519848388mr27553155e9.6.1772628273692; 
 Wed, 04 Mar 2026 04:44:33 -0800 (PST)
Received: from timur-hyperion.localnet (540018D2.dsl.pool.telekom.hu.
 [84.0.24.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851884a24asm50661015e9.7.2026.03.04.04.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 04:44:33 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Rosen Penev <rosenp@gmail.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kenneth Feng <kenneth.feng@amd.com>,
 Alex Hung <alex.hung@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lijo Lazar <lijo.lazar@amd.com>, "chr[]" <chris@rudorff.com>,
 Sasha Levin <sashal@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>,
 "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 for 6.112 and 6.6 0/2] amdgpu: fix panic on old GPUs
Date: Wed, 04 Mar 2026 13:44:31 +0100
Message-ID: <5828571.IbC2pHGDlb@timur-hyperion>
In-Reply-To: <4d00945c-f439-4460-9f8b-12e7e498fb20@amd.com>
References: <20260228045356.3561-1-rosenp@gmail.com>
 <2596902.XAFRqVoOGU@timur-hyperion>
 <4d00945c-f439-4460-9f8b-12e7e498fb20@amd.com>
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

On Wednesday, March 4, 2026 11:06:53=E2=80=AFAM Central European Standard T=
ime=20
Christian K=C3=B6nig wrote:
> >=20
> > Hi Everyone,
> >=20
> > The patches actually come from a branch of mine:
> > https://gitlab.freedesktop.org/Venemo/linux/-/commits/v6.12.74_si_dc_fi=
xes
> >=20
> > For context:
> >=20
> > The crash comes from a patch that I wrote for 6.18 that fixes some issu=
es
> > on the default, non-DC code path, that was backported to stable kernels.
> > DC was not the default code path before Linux 6.19, so I didn't mark the
> > patches that also fix DC for backporting, because I had assumed nobody
> > uses the DC code path on these kernel versions.
> >=20
> > After a user reported to me that this causes issues for him with DC on
> > 6.17
> > and older kernels, I sent a backported series to Greg and Sasha, in an
> > email thread with the subject line "Fixing an amdgpu crash caused by a
> > backported patch". The fixes were backported to 6.17 then.
> >=20
> > I assumed that the stable maintainers would backport the fixes to all
> > older
> > kernels that were also affected, but Rosen brought it to my attention t=
hat
> > it didn't happen. So I made the backports in the above branch. Rosen th=
en
> > decided to send them to the mailing list.
> >=20
> > > Hope that helps clear up the situation.
>=20

Hi Christian,

> In theory Harry an Leo should take care of stuff like this

I don't blame them for this. It is my fault for breaking it in the first pl=
ace,=20
and I didn't think there was any interest in using DC on older kernels.

> pretty much everybody is overworked.

Yeah. We all are.

>=20
> In that case guys feel free to go ahead and ping the stable maintainers t=
hat
> something is missing.
>=20
> Just make sure that when a patch passes through your hands that you add a
> Signed-off-by tag.

Thanks! Probably I should have sent the patches myself, then they already=20
would have had all the necessary tags. Sorry for the confusion.

Now that the situation is cleared up, is there anything else we need to do =
for=20
these two patches here?

Best regards,
Timur



