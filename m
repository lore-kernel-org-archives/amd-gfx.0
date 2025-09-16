Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5C1CAC598
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 13:11:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED6DE10E317;
	Tue, 16 Sep 2025 13:11:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V8qj3UsK";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A80210E317
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 13:11:49 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-24498e93b8fso7678875ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758028309; x=1758633109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZQGWLMYS20RM2PHRcKIUdzG/sbIcO56YCQjlhrSFJ0=;
 b=V8qj3UsKGi2mnX3xliyGKYv8zC6sNlOEd3TcEpGHeoQeXktJ3Ca5klMP80Fx9mpFJz
 nCwwlPjwP+f3ApQkgw5MqTT5W79iy27cPgB2Rc5TGqtOmoFxFZ1IVIuHLy7Ay+kZdkDQ
 eZG25Q4Uv4EubcKeLbw6LzFcdH79p7byp6c57RVLvUETrsbFbCEUCq/efdZgQODxiyWd
 pcQullhQwVE9Hfb9kFOl0z7DWApsCfDiiZ9c8ZVLoz1u8M4mP2v+cLEcQemQXO77781Z
 UfrHGe2F6DFgzvmR1xL56XT2IACpNz9Nyc4Qc9CVzFMfwCK2fytninVNRduS7neWoHCT
 6VJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758028309; x=1758633109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZQGWLMYS20RM2PHRcKIUdzG/sbIcO56YCQjlhrSFJ0=;
 b=aqUX/EhjxDy/PajJjSSIJwsniafr2DFB20ev+e0Q7lHmZhDKOySp1rz1xu3uXSK6UY
 sh6HzHniC20XVEYfRR+zUrTBNvsgEtSAwLAxTojGqJUkCrh3mYGOlwxwrM3Wens7qITw
 Mv1/TrPrmsCPBU1Jc3zp4cLE2I+ODnN8302hkpvClM9pKsSTyuaA/JK4KQzCg5BqMx3E
 JIvv/nQjneYjsgV7VPtaD/erq4Q+P3+72CxvrxXfCjpxAom82Zj26fPUk6Ma4DTcx8xF
 Ih7dJCREksDjLWSqbukn0IO512RdPpCX5PJ2X2Faqyek9OAk7VxbR+B7BQ/w+Ft6aKFQ
 rngA==
X-Gm-Message-State: AOJu0YzY6tcThcAA5rJKduJeeg4m/6HEImOqYN0h1puDP6Gv7I61toFo
 jOR+ry5khxT6G1JqXuwElY1oAKE0xRUSFvpPM5xrTId3adWqHpgCBDu/eBxHKUBCAKxADiB7mzA
 jdVcUxxa3qPCTgE0UTfCkEE/QhBbsYVM=
X-Gm-Gg: ASbGncvUjjFezpIoY88a+uIBoppdg/WWMGVy3iM3q/Rfoe+YAjJRUXMpaadzk39zPvu
 AHcOyow6mJdhEgQWv/1QQ5aTiZEs3o5HGrwtjOlCiAfpN4FrSl8S73ItkAbBiCKyMyYD7ryms/6
 HWrsu1g6FZX2sOQdXz4jZ1LrnGoPPL6dkTu8dFm+lmQjyYhy+IaG3FHf2HhkZ620Op4UxM/8FNT
 UNHYOU=
X-Google-Smtp-Source: AGHT+IHdBX+BDCzs72mqFiTaPcuHGQueiRO+jKRRLYirXl9AXm5yXijcUbkgPTo7POT8AC9lyHyKpRnsayPUaVFJHnc=
X-Received: by 2002:a17:903:ac5:b0:25c:b66e:9c2a with SMTP id
 d9443c01a7336-25d27c1df3cmr106987245ad.6.1758028308742; Tue, 16 Sep 2025
 06:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250916015902.77242-1-mario.limonciello@amd.com>
In-Reply-To: <20250916015902.77242-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Sep 2025 09:11:35 -0400
X-Gm-Features: AS18NWBHylpMVcq-hRpBq7PC5b0sPBeEzYLb6jrJrCkWt5NgsGld7AXBRsGzCGU
Message-ID: <CADnq5_PqbmO9JpzuG-Ry1Mw53Db62-wHJMLjKqy6Dnd47KMofw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Only restore cached manual clock settings in
 restore if OD enabled
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org, 
 =?UTF-8?B?SsOpcsO0bWUgTMOpY3V5ZXI=?= <jerome.4a4c@gmail.com>
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

On Mon, Sep 15, 2025 at 10:39=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> If OD is not enabled then restoring cached clock settings doesn't make
> sense and actually leads to errors in resume.
>
> Check if enabled before restoring settings.
>
> Fixes: 796ff8a7e01bd ("drm/amd: Restore cached manual clock settings duri=
ng resume")
> Cc: stable@vger.kernel.org
> Reported-by: J=C3=A9r=C3=B4me L=C3=A9cuyer <jerome.4a4c@gmail.com>
> Closes: https://lore.kernel.org/amd-gfx/0ffe2692-7bfa-4821-856e-dd0f18e2c=
32b@amd.com/T/#me6db8ddb192626360c462b7570ed7eba0c6c9733
> Suggested-by: J=C3=A9r=C3=B4me L=C3=A9cuyer <jerome.4a4c@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index bf2b38dd7e25..fb8086859857 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2263,7 +2263,7 @@ static int smu_resume(struct amdgpu_ip_block *ip_bl=
ock)
>                         return ret;
>         }
>
> -       if (smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL) {
> +       if (smu_dpm_ctx->dpm_level =3D=3D AMD_DPM_FORCED_LEVEL_MANUAL && =
smu->od_enabled) {
>                 ret =3D smu_od_edit_dpm_table(smu, PP_OD_COMMIT_DPM_TABLE=
, NULL, 0);
>                 if (ret)
>                         return ret;
> --
> 2.49.0
>
