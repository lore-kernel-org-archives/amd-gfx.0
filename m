Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8EFFF885D
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 10:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E642A10E337;
	Tue, 28 Apr 2026 10:29:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eO5UbwRF";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0692210E337
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 10:29:42 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso114348145e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777372180; x=1777976980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wkbhnpVV9o6AAz/ksQ7onN22h9OeVQgTUfHZAdHIN8Q=;
 b=eO5UbwRFq2SXKQAr+kMI+JtdSkckMgPnh7UwNBc5d4PfPqmhOU6KSG83+BEo2Z0VZ9
 hiCJtUVvpl2hPxiVeM5L12ptFwSKi1Vpo+frcsqchEjNrXTb54ZxUlQZNJMvfszDw5cG
 lz4+HRzxHFOZV/cufEMr4/B6RmFxzG5VYYvCAWhAerYhQwCT3+RGXWrhG95A10Eg0jIW
 XugVq0iLEsmpH3SufA2Wn3asYfVcUJIa10fRTclCiXYcxktPK7QSXppxeBKeW0OPWWZS
 /fwnyx/+nNddyHxHcE3tzd/XIDyVBAb2fZQ4kxPo5SbJxadvD+fimTj/dwKWwNt3GVji
 Tn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777372180; x=1777976980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wkbhnpVV9o6AAz/ksQ7onN22h9OeVQgTUfHZAdHIN8Q=;
 b=fGZJ90dtxbi6S10eM5HoyHFKVVgij76IpWy9KsXF79tndZVDH7h7igGszC1ikBEPKM
 PiU4sSq799GieD1f9ha0tdNsacH7L1Tsvi6d/uB3xN0WLZbxh9loaoG21fzt71vM2K3o
 xmpjZ92ONW6Hmjh4qKcWcyEJ3fqJsTZvTKaJ5N3kfJhMbIIY24t9hvTkhbLtPclR7rLv
 sM3JNIGgOitEU4qsgrKRLlinRpRdBt7Wrmz5YZMCCg1R6HBTl3IHdouu+lVyWSPIQe9X
 x4zi3yd37YEBfwT8lGfG5oNV2K8e3FoMUy/Kft18kBxTBoRD5TjbLlLBwMH0bZ+Jqu6+
 jv4g==
X-Gm-Message-State: AOJu0YwcwYkjrWJwmA5ayn4rc9wlGuxLemvmVLlpLZt827oJety1espo
 6yLMzaBqlsay8zCqH03eqiUB0ohkfzDQn2pRfD6qaK1xSUMEJ2eLCXZicVR1Vw==
X-Gm-Gg: AeBDieumistO6KrDLVcIF9+KzgtahtoH8+tncBLmERVkC+l/xmnBHYSB7AsQaLYb/Bw
 Q5ZGnHvL4cIoklNtgT5SgadvhrZTbxIT3peJKqZEsS0N+6fxxinakCKFJ2UsPe5shF8c54l/W6R
 n67LfyLC91ZJez9VtBQRaUxDs7AHb5jutjj5UtXExwyqiSUE0uvAoSoz24+X6KvfVNadYl/med+
 OHXoi/juExKhxNJufONU7MpfH/Si5vAntyyJ5BLVizgLSf3HkbgFJwNDgm6f3ZlOGXKZyzxqz61
 J0kCx4FMH+oQQsNyCvzYGmfUlIWw27HNmmPb6xfd/MRWgqlHb2NWcMAMKTbSJr0H26Ws1r4VAdm
 2cKmM9rdJ5X8AEkaoA3E/1wt6/Xp5Bh81uXCxvfM/AHiTsIUi4wIS2Bt80eFQv+LBZv3MbxRepO
 KXJuAbuML5Y02vc7AN5iuMwEEd0YuwJW8SUKkcKgr0o2TerenxplMRHAUYgNHOgTRvvQnMqSVul
 TjUNR2fcw==
X-Received: by 2002:a05:600c:3ba6:b0:489:1baf:8c03 with SMTP id
 5b1f17b1804b1-48a78a43734mr30640055e9.11.1777372180283; 
 Tue, 28 Apr 2026 03:29:40 -0700 (PDT)
Received: from timur-hyperion.localnet (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7748f32dsm20777495e9.2.2026.04.28.03.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 03:29:39 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 2/2] drm/radeon: add missing revision check for CI
Date: Tue, 28 Apr 2026 12:29:39 +0200
Message-ID: <2010090.7Z3S40VBb9@timur-hyperion>
In-Reply-To: <20260427173103.1020723-2-alexander.deucher@amd.com>
References: <20260427173103.1020723-1-alexander.deucher@amd.com>
 <20260427173103.1020723-2-alexander.deucher@amd.com>
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

On Monday, April 27, 2026 7:31:03=E2=80=AFPM Central European Summer Time A=
lex Deucher=20
wrote:
> The memory level workarounds only apply to revision 0 SKUs.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

It is important that stable kernels (and stable distros) pick up this patch=
=2E=20
Can you please add a few tags to this commit to give extra context?

Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/1816
=46ixes: 127e056e2a82 ("drm/radeon: fix mclk vddc configuration for cards f=
or=20
hawaii")
=46ixes: 21b8a369046f ("drm/radeon: fix dram timing for certain hawaii boar=
ds")
=46ixes: 90b2fee35cb9 ("drm/radeon: fix dpm mc init for certain hawaii boar=
ds")

With that, this patch is also:
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Thanks & best regards,
Timur

> ---
>  drivers/gpu/drm/radeon/ci_dpm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c
> b/drivers/gpu/drm/radeon/ci_dpm.c index ba8db1d07c070..b47b91272b244 1006=
44
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -2461,7 +2461,8 @@ static void ci_register_patching_mc_arb(struct
> radeon_device *rdev,
>=20
>  	if (patch &&
>  	    ((rdev->pdev->device =3D=3D 0x67B0) ||
> -	     (rdev->pdev->device =3D=3D 0x67B1))) {
> +	     (rdev->pdev->device =3D=3D 0x67B1)) &&
> +	    (rdev->pdev->revision =3D=3D 0)) {
>  		if ((memory_clock > 100000) && (memory_clock <=3D=20
125000)) {
>  			tmp2 =3D (((0x31 * engine_clock) / 125000) -=20
1) & 0xff;
>  			*dram_timimg2 &=3D ~0x00ff0000;
> @@ -3304,7 +3305,8 @@ static int ci_populate_all_memory_levels(struct
> radeon_device *rdev) pi->smc_state_table.MemoryLevel[0].EnabledForActivity
> =3D 1;
>=20
>  	if ((dpm_table->mclk_table.count >=3D 2) &&
> -	    ((rdev->pdev->device =3D=3D 0x67B0) || (rdev->pdev->device =3D=3D=20
0x67B1))) {
> +	    ((rdev->pdev->device =3D=3D 0x67B0) || (rdev->pdev->device =3D=3D=20
0x67B1)) &&
> +	    (rdev->pdev->revision =3D=3D 0)) {
>  		pi->smc_state_table.MemoryLevel[1].MinVddc =3D
>  			pi->smc_state_table.MemoryLevel[0].MinVddc;
>  		pi->smc_state_table.MemoryLevel[1].MinVddcPhases =3D
> @@ -4493,7 +4495,8 @@ static int ci_register_patching_mc_seq(struct
> radeon_device *rdev,
>=20
>  	if (patch &&
>  	    ((rdev->pdev->device =3D=3D 0x67B0) ||
> -	     (rdev->pdev->device =3D=3D 0x67B1))) {
> +	     (rdev->pdev->device =3D=3D 0x67B1)) &&
> +	    (rdev->pdev->revision =3D=3D 0)) {
>  		for (i =3D 0; i < table->last; i++) {
>  			if (table->last >=3D=20
SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
>  				return -EINVAL;




