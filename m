Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA9CC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 11:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF4BD10E4B0;
	Thu,  2 Jul 2026 11:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kUj0rQ1Y";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7155F10E4B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 11:53:58 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so11974295e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jul 2026 04:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782993237; x=1783598037; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9wzEXddGggGlr58UGBs32bXaslha6L6eA4D2wq02q+g=;
 b=kUj0rQ1YCW56tgP/nqBuu9bSVJ3ujbfS8rIOj3VvqVUBBlNmb3IprezHh8SK/6r0Sg
 oSrttumv/2VZFdrENtSDKRtKqKYyv0BHFp0Cm+Jc35G2JUQybltofusiSJuC5B4Te5Me
 Xb9CT7qynK40B0+F9Svv57zDOgaDxbWnsc/j8qwKOmcNVPI0Y9L72I9wsKCleK/hThTq
 srdN1XWt34l3cyQWyp3BCd9jbCubQ6zqVyO+IqxKnxHIdUkKBlYOhFQAgT5PP9DP/q2J
 jG5vlZvNrBYMoCyOiW6L8v/7DFio/+iE3R4CCDFWJ9kP5Molcz485K1HOqzmJnC/Zbfs
 G2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782993237; x=1783598037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9wzEXddGggGlr58UGBs32bXaslha6L6eA4D2wq02q+g=;
 b=j5IIqTJF/MlFCGPHfanJyJV8Fn5uzHA0m6ST4V4tOkpDo9QspJEcGDd3T2e2ONAssQ
 hkp042L7hKXrwg6IoAkUOnBBC8aC0jLCStNdIPA4tDiVnSPqI1UNnWz1uv3m/GS/f6PH
 OMF3h9OQdV1NLhMbyfehY9EuARKFSSdpBDs7cfFhJy/U2zg/vX0CSo5VwtXMu8dqxZiJ
 lo9bQE4YcVlf9VOcD+pzbXwU4XNUHTd9zcjDpHZgYwEf58ts1YwYj6RagKzg8w3nMmAP
 XA1Kv/3rrOaIsPqV4JCfkkBX07mUYcQkwIBuU85EQzjZIaGfoQnQ+hRSAtChBeAXpIka
 kRkA==
X-Gm-Message-State: AOJu0Yz1UM/BZmh0NmRw5QUvbXN1mnLXNaFc3NzmpWNz7/VuOVAHRZih
 U658tR/Lb524lHm9deqb1pHzf4UbFV9L3swmmQ3WrW3PNd/03ga5/Am9p8/4Honb
X-Gm-Gg: AfdE7cmN126u4S/qu0lyu/CWVGk/OsJJGO09gAuzP6ESmi3YytG5C6I9W63TkjooS0F
 gSWAFrigJ82vIAWvN/xl/cbLIZDbRVufYuzbn0lnVVfrpmC8zsY6MF6qm1O/GYxX2tIBiGNQ/5X
 e1obrE9RBjBCjTV0q+clYLJbe0lavEtcYzGO8pkdrnw0t5XjrNI8XU9deCCTYP86OXqrxXTVHyX
 i/JTQ1xPu2Rdb8hW6fZCet8aCk1jWYIYokvrhXYe0IYzvn2Bb+umR7wesN3LjWMbUUrySNpOvA4
 tzq36zKgiGUddNpfiEzTurTGzy2+ORddFhgOTLCZ2xaQcuyR7qJChoaAZs3jgtdKBi4fKr1SSAf
 sZ1QkZ7aydqyl0UuWsBl3xnM8BaAHpycYHWnUYd4Gx89BbTSJaHR8LrcSfwuw8tzUUmUMkXmxS6
 5pFElbdi83WkjKYPRmYvY0mN28HYyMNc6WcsMAkDGuqG2v9stKtIMDQ2kn/72VzRFJRN5KfKV6w
 j76rEeRk9FDSw+yd/yNUdIxGFwe
X-Received: by 2002:a05:600d:4452:10b0:493:bdde:e400 with SMTP id
 5b1f17b1804b1-493c2b38c42mr61171115e9.4.1782993236317; 
 Thu, 02 Jul 2026 04:53:56 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EF0F0080162CDB5B2DFACF.dsl.pool.telekom.hu.
 [2001:4c4e:24ef:f00:8016:2cdb:5b2d:facf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c6368f89sm39758585e9.8.2026.07.02.04.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 04:53:55 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 14/14] drm/amdgpu/ih7.0: Enable retry CAM on Navi 4 dGPUs
Date: Thu, 02 Jul 2026 13:53:54 +0200
Message-ID: <5873192.ZASKD2KPVS@timur-max>
In-Reply-To: <dee4f6f3-0494-40e6-94d9-e0249633d0bc@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <20260701161721.85681-15-timur.kristof@gmail.com>
 <dee4f6f3-0494-40e6-94d9-e0249633d0bc@amd.com>
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

On 2026. j=C3=BAlius 2., cs=C3=BCt=C3=B6rt=C3=B6k 12:38:12 k=C3=B6z=C3=A9p-=
eur=C3=B3pai ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 7/1/26 18:17, Timur Krist=C3=B3f wrote:
> > The retry CAM can filter interrupts which occur repeatedly,
> > such as page fault interrupts when retry faults are enabled.
> > This makes processing those interrupts much more efficient,
> > because the CPU won't have to deal with processing the same
> > interrupt repeatedly.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c index 291326d2ee8b..ec0919fa8254
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> > @@ -390,7 +390,8 @@ static int ih_v7_0_irq_init(struct amdgpu_device
> > *adev)
> >=20
> >  	pci_set_master(adev->pdev);
> >=20
> > -	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(7, 1,=20
0)) {
> > +	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(7, 1, 0=
)=20
||
> > +	    !(adev->flags & AMD_IS_APU)) {
>=20
> I think the check should be the other way around.
>=20
> In other words we can enable the cam on dGPU or APUs with IP version 7.1
> because that one has the CAM as well.

What do you mean by the other way around?

The patch keeps pre-existing behaviour on IH 7.1 and additionally enables t=
he=20
retry CAM on dGPUs. The patch makes no functional changes to IH 7.1, on tha=
t=20
version the retry CAM is always enabled regardless of whether it's an APU o=
r=20
dGPU.

>=20
> >  		/* Enable IH Retry CAM */
> >  		tmp =3D RREG32_SOC15(OSSSYS, 0,=20
regIH_RETRY_INT_CAM_CNTL);
> >  		tmp =3D REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE,=20
1);




