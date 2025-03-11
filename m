Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C185C28B30
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 12:57:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0430710E1BD;
	Tue, 11 Mar 2025 12:57:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MSihYSIs";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 832B210E1BD
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 12:57:41 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-301001bc6a8so213839a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697861; x=1742302661; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rB0x/WkeXkEnGPDAM58E1h9lAoWIA4jbquvSXc2y3Eo=;
 b=MSihYSIsiuQBqBUO5tdqV6letnnTwWEfxUMeLb9+vb05LzciEYRNqOnyTWvuV12Uul
 zmliGIBJ/FmaHj22I3aCdmKOCpZ8WwFB3ljVb1YOS6RMeh/LSl8WOOq/nVPRXIuAiU6p
 iReiX/SG7rgruK92Na+ETTGvkbBSHadX6wy4n2ZFmGpTaTidB64pDhL/8JgSIByIjfYs
 JNftDOzVmjMc/bMcWr3AERkFb+1va5f2NftUCCj2L5LqWfrvCnQvNXiSav0rNff0KZfI
 0YG5QoFysze8jMKjtZuMrgo0hassKFULEt4XgU0m2b4jScp3CcpzbsdoMUaXYZd2btei
 idUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697861; x=1742302661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rB0x/WkeXkEnGPDAM58E1h9lAoWIA4jbquvSXc2y3Eo=;
 b=rhwNo/0CSiBAA39u+BC7OD4DHlcYo1jM3m06w1Pqi0hNly6+Q59oKw76r5IYidYlqS
 bGHMoyEo/q8CY7etVg9I1ATIc8qZoOYjcJmwRzsyTXDs5G6VodnrM3l55W7419rF+1ki
 Ht0MSfud8N/d7ODeBMHTYdezn0UqxonLEUDjZ+RecwbbaHp2xRldQU8EG72t7TRmkKdY
 VGaZU0/iJsF1TqB9Idi/h4DldkV0Tk9MU+ev0iLtSlavc+qiAFC4pQcI2cLdL8U+YbDp
 AnbzCw11rlgm3Hasopt8JmOQ6Fl2ebw+BCgohJzGozfCHUru27rfwXpAKYIENDOGPogV
 jv/A==
X-Gm-Message-State: AOJu0Yz3i3rP6RWpMieQqpwnfdwUt/m1VIP7bfLqk+1uX8OTCp7XFw8K
 0CW8FyoutQOE45OaB/jTEYt3da0LrLcsVM/7cyazUkqellszeuB+A1SSIzR5RXsvPWmCBBOcBIj
 6a68kgCDGh9EfqTT05t0XvwFykB3GSg==
X-Gm-Gg: ASbGnctWkpc56b+wlU9vgxUPqpo4EGtbHh/+wk7iOvUpUUO2QG/wMWMOW9RKk6cZcxK
 Wa21JAsvZqAjPYr04+xKJU8aCjji25NMMAFlePveP6mhc23JwJiVW48WFl9/ql7ZlFNkMWke1cm
 KoyzqerxKiFTDatIZ98LxF5iNrQg==
X-Google-Smtp-Source: AGHT+IEUHJQojBWZXiJdSzRh2GNGO5Y67y2A40um4I3PVXtp+3py6noCYD6FkGR8rsZ0YE//ZKWoBO3csLbq4WwSA44=
X-Received: by 2002:a17:90b:4d06:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-300ff8b9351mr1820080a91.4.1741697860906; Tue, 11 Mar 2025
 05:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250311085436.628620-1-kenneth.feng@amd.com>
 <20250311085436.628620-2-kenneth.feng@amd.com>
In-Reply-To: <20250311085436.628620-2-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Mar 2025 08:57:27 -0400
X-Gm-Features: AQ5f1JqwGBt01BW91PM0P0F7iYPJR4S7HfkCZzKDMp7j32fxEbbCtFy4pCGdpvw
Message-ID: <CADnq5_PL4ShDmgGnbOCOJ5J359g4afCn4UWnNOxTqJjdHvjSWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: prevent skipping the workload setting
 back to bootup default
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kevinyang.wang@amd.com, 
 alexander.deucher@amd.com
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

On Tue, Mar 11, 2025 at 5:03=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> This is a bug fix. The scenario is that the same client can add the certa=
in
> workload type refcount multiple times. Then the same client can not remov=
e
> this setting when it wants to get back to the default bootup workload.

This will break the ref count handling.

Alex

>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 8cfb07549f54..592bf54015c6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2273,7 +2273,8 @@ static int smu_bump_power_profile_mode(struct smu_c=
ontext *smu,
>  static void smu_power_profile_mode_get(struct smu_context *smu,
>                                        enum PP_SMC_POWER_PROFILE profile_=
mode)
>  {
> -       smu->workload_refcount[profile_mode]++;
> +       if (!smu->workload_refcount[profile_mode])
> +               smu->workload_refcount[profile_mode]++;
>  }
>
>  static void smu_power_profile_mode_put(struct smu_context *smu,
> --
> 2.34.1
>
