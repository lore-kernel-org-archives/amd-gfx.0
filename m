Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5AA9C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 21:42:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E1210E05C;
	Fri, 28 Aug 2026 21:42:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ngU/xmo3";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F8510E05C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 21:42:52 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c250a2bc3b3so209588966b.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 14:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787953370; x=1788558170; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PoNruOz3H889Jd4TRwTkRFbUOYJ8a7jPBJvEHvBVRzw=;
 b=ngU/xmo32pglTQnr+7XbscpiaOp3/P6PpIPv4jjxO3czINY60bF+v0TjhsNDYPxSum
 xKSfH5vDKwEXU9sMylB8q+L9eCEofscAriPYkhevQLTmBYzB2RFfjc1yw1syYiVN5FVG
 O5RqRimw/eYApBNJVpx8Dfrk7st8nd3BvxYmiLfNfcEqX6ITcm4SLsMeequxKjgd/HLc
 EK8g0FXWU8sQqR7WbNAlIqm5KwxP7B3ieJ+dcc95xrO4ttG4XZw8DSXZs2lb7kia2j38
 X4eu3dhLdLUfiqTlT/0WpUVtsGitt8fNYtp1Fj4PscwY6fKmbRVzMaSwUQ+LPIVhISH3
 uR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787953370; x=1788558170;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PoNruOz3H889Jd4TRwTkRFbUOYJ8a7jPBJvEHvBVRzw=;
 b=NaSYzQM3+lPdz/SoV0TjzAGh/LqrmN5ytnP9ASYLJv34TxvCBQ+3/ZPdVovXEr6Y7q
 ugt5UdpZOrfp1zADBhQNZIdrGWtgqBTiiGerSL8hLkn1MhSOEDJgGMm1OXPgGCEPrLYM
 pe14IT3XFlQfV7AEqd4OB2nvD1P0iHbCGzoKCno5o1DF2FO7nutK4JCUIfGI6yrXWb5J
 NMtKKcZ8DFknXSpM+s9+it/pcaCO5G8GV/sxIShKTpc4fGhRheo73OnZtFJbpbGgP/gq
 uhLjtwiEQLKe6kn7ml99jDZvL/bXviBZIotIsHBk8B7IP/OzI9h0jSvR3EepmrWYejG1
 7xpw==
X-Gm-Message-State: AFuF++nAQrC50OL3tYhbUjJwTPJmTVCTijb54710xEpAlykdxB3Gg1Tr
 4S2J3VsrwZxjs9Hm2r1No0ffaIUiT8sim0+g/T7WsRsmbmDbnqzdLs90bxmoCw==
X-Gm-Gg: AR+sD102/qeWGcc6WgdNZ3ivqJjvCDj8EdAMZTv5E1TspHXalUI+RFzpN/cSULWUYwA
 NUnvLDx7v2VMJIVOwnW51+bgje+atl+2Qq8YjwL/DqTd8diWp+wCs0F/UII7blqkVu4IWlfjrGf
 ynR8UDpBhACc3QtZvQ8fcfAmlWl7brlrximRnBmyF/8NOtItj0kEU7WwbnJlQV7h8uIua7Vo6Lk
 EqIUt2CHmA6teWuJdt2X2+6Ml+lrqo4FbrYGJFrqwn0kzFdUYd1SwrC0FB9HsNAw2q7QSxQVspr
 tf+Agbo2bQHEBSj5XhCGCgpQ6p6Ix4n9hk2gb8FGwQQjNILCrgRxv8Fz0+wzTPce6q207te7Cw9
 YC0uhtnqzHvB+uj9X0J5vYCnbtGpWsuMIGyZH6KeBoPhQLAKL+Et4WiYce7MoFK1rroA/6GBZf5
 dY22T+72s/wfN9nLrDATXg1j9OxaacbSseIv9IteDKgogVo8C/4GhbWL/vYNuAaTCEh8fiAIRVF
 8XPyqcJBafycyd3mRNIV1/6l52U9bihKHzz56WVOaxJnohWgSgWc//wzhjCPzMUGg==
X-Received: by 2002:a17:907:3e25:b0:c25:5344:43cd with SMTP id
 a640c23a62f3a-c2556fe443emr655767766b.7.1787953370355; 
 Fri, 28 Aug 2026 14:42:50 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24E8D1009A9F6421981DD8FC.dsl.pool.telekom.hu.
 [2001:4c4e:24e8:d100:9a9f:6421:981d:d8fc])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255f1b5a4esm127396766b.32.2026.08.28.14.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 14:42:49 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 3/5] drm/amdgpu/sdma: Move SDMA v5.x queue reset to common
 code
Date: Fri, 28 Aug 2026 23:42:46 +0200
Message-ID: <l_sQTsYsQZ6YG8S92q2QAw@gmail.com>
In-Reply-To: <a9178bad-bf11-48d9-871f-15eb67335ba2@amd.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <EhsDbURtRYeOUXN6bnOG9Q@gmail.com>
 <a9178bad-bf11-48d9-871f-15eb67335ba2@amd.com>
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

On 2026. augusztus 28., p=C3=A9ntek 17:53:54 k=C3=B6z=C3=A9p-eur=C3=B3pai n=
y=C3=A1ri id=C5=91 Lazar, Lijo=20
wrote:
> >>=20
> >> Instead of moving it here - sdma_v5_x_reset_queue and using it for 5.2
> >> is better. This may not work in the same way for all legacy queues.
> >>=20
> >> Thanks,
> >> Lijo
> >=20
> > Hi,
> >=20
> > As far as I see, this function can be reused for all generations that
> > don't
> > use MES. If you don't think so, please explain why not.
>=20
> This function doesn't take care of paging ring (if enabled). Or, this
> could be made simlar to the one in sdma 4.4.2.

Hi Lijo,

I took another look at this, and I now see what you mean.

I think the solution is to remove the "caller_handles_kernel_queues" argume=
nt=20
and just check whether the workqueue on the SDMA gfx_ring is already stoppe=
d.
This would be similar to how amdgpu_multi_ring_reset_helper_begin() works, =
in=20
fact (with a few changes) that function could be adopted to work for this u=
se=20
case as well.

> not sure if the sequence reversal (save content -> kfd
> suspend vs kfd suspend -> save content) has other side effects.

Good point, thanks for noticing that.

I think the upstream SDMA v5 function is wrong and the correct sequence is =
the=20
SDMA v4.4.2 code: suspend the KFD first and then save the ring contents. I =
will=20
adjust my code to match the v4.4.2 behaviour in the next version of this=20
series.

@Alex - does that sound reasonable to you?

Thanks & best regards,
Timur



