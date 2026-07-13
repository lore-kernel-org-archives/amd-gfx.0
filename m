Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FE1C44501
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66C6D10E5F1;
	Mon, 13 Jul 2026 13:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sZAatYSf";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F7010E5F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:57:24 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2c7ab2b9dceso11112005ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951043; cv=none;
 d=google.com; s=arc-20260327;
 b=S2PTJADK9XFRvBIduhTZApKZu2g50DLgNGsNXshhA2rv6RGl1DbSzFq48BFkSEODoA
 bTytpfxYKQEAnEpbLc+HtWxa0LLlDm+93dykQ6sOS7I1KPqngrrh+ngFGFUSdLHhITJH
 NO/sj8V1B3W1lwra/+Xnr5eeSz1unwgQMGOiQsVnUWqrfz5dxo3d3k5dClwzps6GirWH
 l9Duh+/av1YJb42VhMc0NeHGo65gEkOwUfO3sF189hM3cH8Us+JPjAxsnois7iHlVPqy
 FZefkbOiUz/bqKATOJTn1mwj1tO1ypMTWwOaNKlI6smg5KEtgUJnswzlpN/GnBJlgpNq
 +5ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aXjs3YYcGNNn2734HcXJyS7grUOq3W21fSa4MLD3xxk=;
 fh=y1rmks9Dc0xc5TLFe4NWfH4qHR5EfXWS+G0Vlrjk8zs=;
 b=RVdxxCENhcMjhQ0xpzSa3h9zONpdZcSeDsM6A6ckSyzZBeDFWJjn0kQSJqW1T/zr0C
 LHhUsjPoBiXsafYsp+Eu7Tvbem/VfkAxKbstVkPuiIZEe1jOGvzA2y543742L75Ub4yb
 nU1siohv2EQhcjw2ny5oAfp63o8uiPaeL6/4RWLz3T3H4OOD7L/mVs9jCuE6ntNotGwC
 V0MAc4ABEm3TkKDHSiqNcO8jZRARObmTRPO8HQ662gLHZ/gC2ji+HNbzjxCfdFftZ6hx
 YUh3h2WLkaAyxUUL8JlqRTO86uh+0sko/XqysUnBTCPrJ5HrX3bZrihh334/7sbZq1CN
 1Kpg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783951043; x=1784555843; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aXjs3YYcGNNn2734HcXJyS7grUOq3W21fSa4MLD3xxk=;
 b=sZAatYSf5d99jLQQwNOOyGysuGkJgiiLL2DAcrbmugcbEq+iL+5438FLw9cs1z6p7M
 pt1ou/XYPZkK9HK0u7/6A42VSU0pOd9hD9VP74zb/PoLt/k5hi9Ps6gmyUjV+xmfRla/
 VvUdSlPTKXEwHU3i3Sp8Nljd9m3x8OaVX6t6SOdJR/kmHQte3tXbSNjWfCpfHu8ERhvb
 xnW0HHorpbwM1FLzcQ731EIFZhDqga7q+JUwXxgWtX/WxHbI6RoZmQy99li4EW8LPQAY
 inq4HcBmuUbJScu5jvyQZCs7K7pnL+8dKjSilyQ5pGF4ABBAwjWMZ4JtLRCA1Q2JjgXR
 dyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783951043; x=1784555843;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aXjs3YYcGNNn2734HcXJyS7grUOq3W21fSa4MLD3xxk=;
 b=DGbFwzWjWKyAMPSXmsVajygPHhg2zgV/uIzZ6IKJKKDMiOp7dPTZ0oU2J+tO0Iu/vQ
 JXJYpEIxyvKKbhQ3/rStWIogZa+35s4+ZAT5xrxNDLZGDAthU+bMh/EopJ6SFQljUtyc
 3QMef2eQCUAlUZ1te7Q62683hh6B20Ex/J+Jkfwhk5KUwWqjx/Tevt6cd2qb7Qq8HQ5V
 1/MzJd6JI1OwTB6M6n8maIg1T6ZdTqlYHuoZrWyNV7xKNzz6wcpIvV8ilOZqdIkJPkv/
 KRymV3jtnssLGyUBsAseLKgzG6WmXaoMDDmtoqfPGbyM79iSiNWt3yZIrVGwo+x5qor8
 vFvQ==
X-Gm-Message-State: AOJu0YyMqKdGkHhjVEU4QlE2+5UOv4J9NWb0cWUcZHcuIpyVLaK8oERM
 FwQGBfH2HMLfC08qPXUcWfx6AyLpPIxPfXYu8yrC+F+Hd3qoUxiq/eXn0R6eYlZVUCodwp6rySk
 cckv2x1djvK6AFHx3+0L3YBODY2kGh9A=
X-Gm-Gg: AfdE7clD1tW0u1gL2TdzB7nCImicA5/2aWemoR43HXphvEubxK7ApYEZ6iW2NdOWPK8
 6pJgi/xY218xlyQqhpXyYVaznSqChH0PjOliKHJND/tFDB2z+Zfvw6Q0OC8dZApTJVEcwX1ALC7
 62p5mo7Tdoap7fXMH3k/QmCC4X1wq8Sd6YgTc+faChnZwoLwKWeAENwZ/9VB6t2DSK1FVFyXonI
 F104M6V0LO3U7iI8tfK9x3WhtTQ1n+UUR2OdwkJWKxxQOOkBfx61Q1WIhPTvV91Azh5nJHhOIYU
 yY2AZIBx5GlrAoSZnfWCwRcQtJFpu7yHW5bE9JGIj6f+XKtxQtVD41z3Vi4=
X-Received: by 2002:a17:902:da2d:b0:2ca:bca8:109b with SMTP id
 d9443c01a7336-2ce9f176961mr66689625ad.5.1783951043577; Mon, 13 Jul 2026
 06:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260713061443.32561-1-timur.kristof@gmail.com>
In-Reply-To: <20260713061443.32561-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 09:57:11 -0400
X-Gm-Features: AVVi8Ce5SAbe2mVlLEoye3BNVFjI34DsgZDgSbI0S0WvAXuU2wuxC0XUA5ALRy4
Message-ID: <CADnq5_M8GfJm5MjM=9+vHZbpCA=BnLEOUZO8Ds0HudNUfhvR+w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm/ci: Don't disable MCLK DPM on Bonaire 0x6658
 (R7 260X)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <natalie.vock@gmx.de>
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

Applied.  Thanks!

On Mon, Jul 13, 2026 at 2:54=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> The old radeon driver has a documented workaround in ci_dpm.c
> which claims that Bonaire 0x6658 with old memory controller
> firmware is unstable with MCLK DPM, so as a precaution I
> disabled MCLK DPM on this ASIC in amdgpu.
>
> Note that the old MC firmware is not actually used with
> amdgpu, but in theory it's possible that the VBIOS sets
> up the ASIC with an old MC firmware that is already running
> when amdgpu initializes (in which case amdgpu doesn't
> load its own firmware).
>
> What I expected to happen is that the GPU would simply use
> its maximum memory clock, and indeed this is what seemed
> to happen according to amdgpu_pm_info which reads the
> current MCLK value from the SMU.
> However, some users reported a huge perf regression
> and upon a closer look it seems that the GPU seems to
> not actually use the highest MCLK value, despite the SMU
> reporting that it does.
>
> Let's not disable MCLK DPM on Bonaire 0x6658 (R7 260X).
>
> Keep MCLK DPM disabled on R9 M380 in the 2015 iMac
> because that still hangs if we enable it.
>
> Fixes: 9851f29cb06c ("drm/amd/pm/ci: Disable MCLK DPM on problematic CI A=
SICs")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c b/drivers/gpu=
/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> index 1d6e30269d56..4d553be56396 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c
> @@ -106,11 +106,8 @@ int hwmgr_early_init(struct pp_hwmgr *hwmgr)
>                 hwmgr->od_enabled =3D false;
>                 switch (hwmgr->chip_id) {
>                 case CHIP_BONAIRE:
> -                       /* R9 M380 in iMac 2015: SMU hangs when enabling =
MCLK DPM
> -                        * R7 260X cards with old MC ucode: MCLK DPM is u=
nstable
> -                        */
> -                       if (adev->pdev->subsystem_vendor =3D=3D 0x106B ||
> -                           adev->pdev->device =3D=3D 0x6658) {
> +                       /* R9 M380 in iMac 2015: SMU hangs when enabling =
MCLK DPM */
> +                       if (adev->pdev->subsystem_vendor =3D=3D 0x106B) {
>                                 dev_info(adev->dev, "disabling MCLK DPM o=
n quirky ASIC");
>                                 adev->pm.pp_feature &=3D ~PP_MCLK_DPM_MAS=
K;
>                                 hwmgr->feature_mask &=3D ~PP_MCLK_DPM_MAS=
K;
> --
> 2.55.0
>
