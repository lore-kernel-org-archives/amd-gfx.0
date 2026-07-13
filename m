Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C635BC44501
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 10:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F09210E8C2;
	Mon, 13 Jul 2026 10:00:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YvWrLUqT";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8041410E8C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 10:00:38 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c1601d552a8so287558866b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 03:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783936837; x=1784541637; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F0Kx/6nJW7T5cbKLyiEiZrUgnE+tjOe7fg9BmmK1tj0=;
 b=YvWrLUqTFu3tEaIT5tZcc1lL3QqfbmRTo6mKQ7Z9uj5aYbQ2WssVcNRtzWfMvb3an+
 cxYTVLmqLEpUfY8myeuXLeVq3h8F7CDEfguIT2+TnKuBRfcySzEdlr9fNvMbufR0hzIj
 9mW7raWlejs4I494B/UJwwqE9GHPr827eH9u0FqyHuzHff88goFZyqsD7SFgEDUjtjfb
 fSAU4obsSKVrhhAIytaxtzBSwiMNfpcV3/NMGbE9MON8cXtCfikie58DiaQhX6QHUOs8
 1btZiSUbBfBR5nIHx7y4bmzwHmpXRXX6HV4wWZqpbUxiIV7F/jaKzpjuo3EU/5bHK8td
 XcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783936837; x=1784541637;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F0Kx/6nJW7T5cbKLyiEiZrUgnE+tjOe7fg9BmmK1tj0=;
 b=UxVyJ6J0HujUe4FN8iqgwObdKATsUqunC0rbQFQw7U5kifvANt6twKgouIVqqfwF/k
 bITG8q8hgf/Yi1N/apOM53LM5/vk9l+TBMDXziKVPBcFUC05ZVAQGpW2wFPcSDmsHSXc
 Bi+fpjpleWt7lCQFv6VrmTbbogQe5LIIpU69lPorZLas+Qz9+u+XeYx8E2IFoNofpYL5
 g5bpJevem1YFzHvM9KlCGoBFIWp1L58+R+q2LH3vrU4nKgpquHkezSkdUwQUOLXCaaxB
 nxz48pjnURhGeSnYkmeorBIdv1ksWMX5XIzlB2x7haKgUOGYeMVQfKwOTul9UEZ4tfQU
 fxUA==
X-Gm-Message-State: AOJu0YzHO8HHtWf/2amwI1X99JAmdRbWtSNmkDqpjbUt1yBJadzCrghC
 Xt5M8pAMN814/Rz/W9s1H9efNW6OKx3lKEmiK2TWUmJQibEkueTRWgkBlsTCUw==
X-Gm-Gg: AfdE7cnyITKUZG4+xddMkiPkt+UDFf41JHWZe28Fz4FJ2x/qIb3wn8eamos3F5SB+cS
 dbfdy6Z65WQd6tdAO9pIZTkbMO25cCw4FUVDx90byAfZ2O1tptMT51tSftwvWWqGj3Z3GRv1nSG
 mTOrir5o0g6z17v05OEhb/9Etyh5/up15qf6kcqMkWyfPTqltmlrxD/d2NIf324uB2Ounh7TRpM
 HVkBmY2v7iUCodGx+SH9pFK9lZ7XbZNMD9jndSiWrX8Aqnr8j8IwB8OJkAqr7O+whUiUZeGKcai
 LCCkQgMJpld8stZr3Qy3/AuKVI2XC4tq5v2G2JJ2H/OmzNbGCzt6W5eh0BJ7x9BSIbQqVn2ic2F
 yjWlqiA1wpl+K8GpIwL3yLYOzLjpxXbFIfVYMT5xlW0e0Nb1zGzb+P6FsYYNxooEEdPI/2aNeSO
 cU8oDnjrIBRa46qlYt13EmLovBukbPv6bKuGXwF/0BtQ/qDMPizMEvjG0P9Yo=
X-Received: by 2002:a17:907:db02:b0:c12:9471:e231 with SMTP id
 a640c23a62f3a-c161eaa950cmr296982966b.35.1783936836566; 
 Mon, 13 Jul 2026 03:00:36 -0700 (PDT)
Received: from timur-hyperion.localnet (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15e1289befsm636740266b.28.2026.07.13.03.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 03:00:35 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658
 (R7 260X)
Date: Mon, 13 Jul 2026 12:00:33 +0200
Message-ID: <fMZgsndLRnm1-Yt6VBK1JA@gmail.com>
In-Reply-To: <c2050464-7f95-4b6a-95db-698c637136df@leemhuis.info>
References: <20260713061443.32561-1-timur.kristof@gmail.com>
 <c2050464-7f95-4b6a-95db-698c637136df@leemhuis.info>
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

On Monday, July 13, 2026 10:28:08=E2=80=AFAM Central European Summer Time T=
horsten=20
Leemhuis wrote:
> On 7/13/26 08:14, Timur Krist=C3=B3f wrote:
> > The old radeon driver has a documented workaround in ci_dpm.c
> > which claims that Bonaire 0x6658 with old memory controller
> > firmware is unstable with MCLK DPM, so as a precaution I
> > disabled MCLK DPM on this ASIC in amdgpu.
> >=20
> > Note that the old MC firmware is not actually used with
> > amdgpu, but in theory it's possible that the VBIOS sets
> > up the ASIC with an old MC firmware that is already running
> > when amdgpu initializes (in which case amdgpu doesn't
> > load its own firmware).
> >=20
> > What I expected to happen is that the GPU would simply use
> > its maximum memory clock, and indeed this is what seemed
> > to happen according to amdgpu_pm_info which reads the
> > current MCLK value from the SMU.
> > However, some users reported a huge perf regression
>=20
> Were those private reports? If not, please consider linking them in the
> trailers using Link: or Closes: tags, as explained in the patch
> submission guidelines (and mandated by Linus, see the quotes and links
> in
> https://www.kernel.org/doc/html/latest/process/handling-regressions.html#=
on-> the-importance-of-pointing-to-bug-reports-using-link-closes-tags for
> details).
>=20
> Ciao, Thorsten

Hi Thorsten,

There is no bug report. I had a conversation on Reddit which brought my=20
attention to this issue, then I actually plugged in the GPU, tested it and=
=20
noticed that there is indeed a problem, and this patch here is the best fix=
 I=20
could find.

Best regards,
Timur

>=20
> > and upon a closer look it seems that the GPU seems to
> > not actually use the highest MCLK value, despite the SMU
> > reporting that it does.
> >=20
> > Let's not disable MCLK DPM on Bonaire 0x6658 (R7 260X).
> >=20
> > Keep MCLK DPM disabled on R9 M380 in the 2015 iMac
> > because that still hangs if we enable it.
> >=20
> > Fixes: 9851f29cb06c ("drm/amd/pm/ci: Disable MCLK DPM on problematic CI
> > ASICs") Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> > b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c index
> > 1d6e30269d56..4d553be56396 100644
> > --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> > +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> > @@ -106,11 +106,8 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
> >=20
> >  		hwmgr->od_enabled =3D false;
> >  		switch (hwmgr->chip_id) {
> >=20
> >  		case CHIP_BONAIRE:
> > -			/* R9 M380 in iMac 2015: SMU hangs when=20
enabling MCLK DPM
> > -			 * R7 260X cards with old MC ucode: MCLK DPM=20
is unstable
> > -			 */
> > -			if (adev->pdev->subsystem_vendor =3D=3D 0x106B=20
||
> > -			    adev->pdev->device =3D=3D 0x6658) {
> > +			/* R9 M380 in iMac 2015: SMU hangs when=20
enabling MCLK DPM */
> > +			if (adev->pdev->subsystem_vendor =3D=3D 0x106B)=20
{
> >=20
> >  				dev_info(adev->dev, "disabling=20
MCLK DPM on quirky ASIC");
> >  				adev->pm.pp_feature &=3D=20
~PP_MCLK_DPM_MASK;
> >  				hwmgr->feature_mask &=3D=20
~PP_MCLK_DPM_MASK;




