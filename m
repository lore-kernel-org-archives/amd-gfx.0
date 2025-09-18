Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AA2CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 20:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99AA010E8F8;
	Thu, 18 Sep 2025 20:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bPeQOcEJ";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE6510E8F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 20:33:34 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-26808b24a00so2170595ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758227614; x=1758832414; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sF7sr8KQUGU2LKMm66IhaFtG9MvgDqsZEh4N0bzpHSs=;
 b=bPeQOcEJJutSzLIYzSAifU4iw6a2Mu/I9DGdEu0xnKZ6zwEWE4mb+do2smrRROKBa6
 eRmFWblIiOe75gtfdAfY3Y50zeEotGdiG2jNilZv17Ten0LFB1iJucKhFopQuIf9g8Xh
 f5WDRlwf3plG9Ih/zNqMlU2HgOrDqJl6YwZWzgdEkwDwI3OD+nn1eeed3p7eyblP0kMG
 dK9vud7piwU9278DBais2glYRQLAUMpCnLdlVgoqMDRTIRK6MBzmskkHRc7kkptQ+E8x
 99DGz143jd3d+rDO65q8Y2Bc7G5P+6As9WjLQwE361MfJtTE0YdgAKrNM3QvsFSM80xB
 UVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758227614; x=1758832414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sF7sr8KQUGU2LKMm66IhaFtG9MvgDqsZEh4N0bzpHSs=;
 b=tBA2e/on+rvFjTFEbnzTEvVBHfYxlWfbcnhUR0Nx1pna5PfMTM+qBozUmeuRtmjadz
 om/2OqY3yDTsPbMN6UtTunWvCkqgioSn4MwVfIhdOPTdBQzSv9dEDB7fmGwsQaTUcFkA
 d1hprOaUTO8Fhf6AS2EXJxWKEMJzyCWrhb7d62y826D8FmuoYvyQdxQ8YU6KclKK9bod
 sZ6IDIyZWqbI9LZVBgvYg2tgeBTbj+j99yKIrvvsygb65Zb/58uN4Xvq3DCGg3G1AbWN
 oOfkvyUpblEHilNkmU0+aDFepiyJoGM2tUWDnnlKOu0A69aYaGEKKSC8HTInDttk9DxU
 dh+Q==
X-Gm-Message-State: AOJu0YyfTsaYAAJqiMCv9oN8M5KPJmNoZEnXYm39MnOzdyFeeBMSdsTe
 jzyth2gpYsthH/Ma+qkgtsqJC0dQgyu12KkIMQlyDbTDvLKuXjjnDNwLlAyLExazbJ961Ou5rsz
 XUu+miqbJ1gF3AbnDC31eXpXWNq2NdpllWg==
X-Gm-Gg: ASbGnctLiBEXVjwt/zb3RAeR0D4V09Fqw1t08cfe96k5roXgtI/AzOjoFoeRGqMvVK0
 u7/Cq39onEJ0VNERJJTSPfl3mJFBJally34p+GlkdrfRjg6yyGaf/Kw+yQ8obx/23biKr9319o+
 qYceWBWKT8c9X5UYT2JAA6lG4Vq7OT3EoTOIVsxDTXQbB0KSfrFXIWVqC96vcVa2HeV5ZVe2laG
 VBNVyaD2kovvW5SoOYFWGklfA==
X-Google-Smtp-Source: AGHT+IEilJn4bzlfKQK3OSZxpgP5bZWR6B111186+7m/5uhKYa8uCOZmSls0ZVR/IRBu33H4cUQ92WDOl54DYtNRLi4=
X-Received: by 2002:a17:902:d2cc:b0:266:120a:29cc with SMTP id
 d9443c01a7336-269ba43e278mr6087685ad.3.1758227614109; Thu, 18 Sep 2025
 13:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
 <20250918081815.2755437-4-Prike.Liang@amd.com>
In-Reply-To: <20250918081815.2755437-4-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 16:33:20 -0400
X-Gm-Features: AS18NWDAJxfRnpZuove37sJkXUcGKl9I2ds6E5aBkjKK7H6kBfPB_6R_i2ogxbw
Message-ID: <CADnq5_NFjLm8DQoD+04EdHadvuJELDcVxDwoLbAtWB7e6A4_sw@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] drm/amdgpu/userq: extend userq state
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Thu, Sep 18, 2025 at 4:18=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Extend the userq state for identifying the
> userq invalid cases.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 2260b1fb8a22..33a582200dda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -37,6 +37,7 @@ enum amdgpu_userq_state {
>         AMDGPU_USERQ_STATE_MAPPED,
>         AMDGPU_USERQ_STATE_PREEMPTED,
>         AMDGPU_USERQ_STATE_HUNG,
> +       AMDGPU_USERQ_STATE_INVALID_VA,
>  };
>
>  struct amdgpu_mqd_prop;
> --
> 2.34.1
>
