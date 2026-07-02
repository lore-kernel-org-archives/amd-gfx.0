Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BEDC43458
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2026 12:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7E5110E4C3;
	Thu,  2 Jul 2026 12:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PL6oW6gV";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F258D10E4C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2026 12:47:29 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493b779003fso8833155e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jul 2026 05:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782996448; x=1783601248; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1mqQXlx2gPydwUwrfCYNn2v0/8t4N6+U8pWoCcjFd18=;
 b=PL6oW6gVEP8PdOQ+c0VdWpp00zA96zV2kCEojy5p/sjLfWsuor8wP8Z2PirHe7uMft
 t73gbFMvERoSkE9Li8CrwjHZc2FsPkDxkg1XzEGepAlCj3Xa4BPxnTfnFQ5187kALoXb
 s4uc4PhfhOj4Rg4/X6LT8v7ngnaBqAAmxn96JoUcB2aUBXt3VGR1IJ2MLSv4n1sb+TgG
 0kYsTeksUV0XILrejqCqIDlYFEzj5X2YlaMSE1bdE9Vliz7K9iCLNrJdJQvmLchY+cKW
 s9Q+Hk/Z8Dsn9Jow+dkOBnypYphPq5b/zaBXfE8+RpIFa0ap4azx4JDqWynuAnX74TwN
 qCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782996448; x=1783601248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1mqQXlx2gPydwUwrfCYNn2v0/8t4N6+U8pWoCcjFd18=;
 b=qMhx5tEXNRbFyEiGXEqVXgVdeqbcu2ZxkN1ufaDxgHR+FR9l5b5wgrhQigy9ZlQbtA
 hTe38rx9pI8xrlsLcHFbn87q2oGrfC2u2zFsNfXFfQT3qRzAkpNYwJ0kKQ/0vePrZZ0g
 xuOtDjRbwtmqMSsDeR5tgcpiwtF7/ZNvBDBW/Ru/lzQmHjYWF/MpTUtH5ezgoX+Y6dyr
 g7FANENaJhFlmm49VmnQtakXGPHapz3mDJF/D9ODGhwctcRsEKx2/cIutBA57kdj8FEh
 rK67Ey4RWYYsM701XipOuh1ss+TwQTkd3beVKB8KdS59MHFJoRDjo3sPbdL3nebVTO/a
 pjvw==
X-Gm-Message-State: AOJu0YxfT8GP6jyDvl2gW6hdZXbMcJAKmtr/AstB5/MKBzckgpJLVJi4
 4WUgcBxzRBes1ZBNCwNopCdI8TavY5RUAtTraUOBo3CidyJHj1tBebI4r4dN6yGO
X-Gm-Gg: AfdE7cl90evNAwC4Qmq7iWpqnu2qMvFNEPgtiPs8XghdCxJXFE2NV8t4PWJMgOADf0v
 GNccim170HU/inFeCxpRnrx9YLmGVlcVw/7q9AW+nziLP7h+SF6hJSd0cUtXFqz5R9x/HDYGy2C
 YXvs6yQVzK1dcXD5/qMMKQiepsiolOg6vPZ0Rcy6RHWaATezWfd7t0d2tlYnUT/TKmngzUQwEs9
 bIv72XSOuLF9HP+oYk8FWAZToJsVHsS7N968aBI9EIViOI18AFSUYX+iDLGPLp9DJS7LFPdHFlV
 AqbuObfq2iVoj1pn1Ynx2KhutXblHTipOPUBpqtAlqseNYeig5xKZ9mlxhiVDk46v50h+BcechX
 tdpmWt2ilL4b5Xz/8MLaMyTalZ1ht84REiHYpvxtJlNEl8+Un50pu5iPf+Gy+/Z15lm0egCIFmy
 4Bkq1LG17rp4rvx5gK08MOAsvP15RZQE4IDmXbJsp604XaW3cbu1BXLAuPUIOIBmNpkJrP4zIC9
 59hgr2Xlv5HsYmzhw==
X-Received: by 2002:a05:600d:c:b0:493:bc31:b2ae with SMTP id
 5b1f17b1804b1-493c2b4431amr73301135e9.10.1782996447928; 
 Thu, 02 Jul 2026 05:47:27 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EF0F0080162CDB5B2DFACF.dsl.pool.telekom.hu.
 [2001:4c4e:24ef:f00:8016:2cdb:5b2d:facf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c635c41dsm89611295e9.5.2026.07.02.05.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:47:27 -0700 (PDT)
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
Date: Thu, 02 Jul 2026 14:47:25 +0200
Message-ID: <20288636.fSG56mABFh@timur-max>
In-Reply-To: <15459d84-24fd-404c-b90f-97d2ecfb7af8@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <5873192.ZASKD2KPVS@timur-max> <15459d84-24fd-404c-b90f-97d2ecfb7af8@amd.com>
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

On 2026. j=C3=BAlius 2., cs=C3=BCt=C3=B6rt=C3=B6k 14:30:20 k=C3=B6z=C3=A9p-=
eur=C3=B3pai ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 7/2/26 13:53, Timur Krist=C3=B3f wrote:
> > On 2026. j=C3=BAlius 2., cs=C3=BCt=C3=B6rt=C3=B6k 12:38:12 k=C3=B6z=C3=
=A9p-eur=C3=B3pai ny=C3=A1ri id=C5=91 Christian
> > K=C3=B6nig>=20
> > wrote:
> >> On 7/1/26 18:17, Timur Krist=C3=B3f wrote:
> >>> The retry CAM can filter interrupts which occur repeatedly,
> >>> such as page fault interrupts when retry faults are enabled.
> >>> This makes processing those interrupts much more efficient,
> >>> because the CPU won't have to deal with processing the same
> >>> interrupt repeatedly.
> >>>=20
> >>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>> ---
> >>>=20
> >>>  drivers/gpu/drm/amd/amdgpu/ih_v7_0.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> >>> b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c index 291326d2ee8b..ec0919fa82=
54
> >>> 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v7_0.c
> >>> @@ -390,7 +390,8 @@ static int ih_v7_0_irq_init(struct amdgpu_device
> >>> *adev)
> >>>=20
> >>>  	pci_set_master(adev->pdev);
> >>>=20
> >>> -	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(7, 1,
> >=20
> > 0)) {
> >=20
> >>> +	if (amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(7, 1,=
 0)
> >>>=20
> >>> +	    !(adev->flags & AMD_IS_APU)) {
> >>=20
> >> I think the check should be the other way around.
> >>=20
> >> In other words we can enable the cam on dGPU or APUs with IP version 7=
=2E1
> >> because that one has the CAM as well.
> >=20
> > What do you mean by the other way around?
> >=20
> > The patch keeps pre-existing behaviour on IH 7.1 and additionally enabl=
es
> > the retry CAM on dGPUs. The patch makes no functional changes to IH 7.1,
> > on that version the retry CAM is always enabled regardless of whether
> > it's an APU or dGPU.
>=20
> I just wanted to make the logic more readable. In other words:
>=20
> if (!(adev->flags & AMD_IS_APU) ||
>     amdgpu_ip_version(adev, OSSSYS_HWIP, 0) =3D=3D IP_VERSION(7, 1, 0))

Thanks, and sorry for the confusion.
I'll apply this suggestion to the next version of the series.

>=20
> I still need to double check why we have the exception for OSSSYS 7.1.
>=20
> Could be that this is for some MI* product, but I'm not 100% sure yet.

It was added in commit e06d19420118
I don't know which products have IH 7.1 because the IH block versions are n=
ot=20
mentioned in the ASIC info table. I guess IH 7.1 goes with GFX 12.1 but I=20
don't have any way to verify that guess.


>=20
> >>>  		/* Enable IH Retry CAM */
> >>>  		tmp =3D RREG32_SOC15(OSSSYS, 0,
> >=20
> > regIH_RETRY_INT_CAM_CNTL);
> >=20
> >>>  		tmp =3D REG_SET_FIELD(tmp, IH_RETRY_INT_CAM_CNTL, ENABLE,
> >=20
> > 1);




