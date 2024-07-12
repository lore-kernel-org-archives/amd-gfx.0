Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F3EC2BD09
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jul 2024 13:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD8A410ED16;
	Fri, 12 Jul 2024 13:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IMdimkvz";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9CD10ED16
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 13:48:32 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-7611b6a617cso1483733a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jul 2024 06:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720792112; x=1721396912; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlfYj7Z3m+0AkCilfY7EhFD+i2IxG4dekIdbLaI62AA=;
 b=IMdimkvzXTsCukLDsdATGE7NLQJGFM0uRLRx69JiuAOTH3DjgXAGVqr8dAxs2kPi1I
 3bFvtXKNIzMzS1qbJltDjcjRN4q/cWnQBUIiuBlzWi1a0xvHLpbsmaPEhVpV8iWQdUvf
 txpZzdPOjbQywvMi7gIWPh3qYyFy3y7I8Jm4pezpadNlwVuFl1Q+KOnxZNSlJ2iZReDq
 1WQeik37nWNV3nuRjIZfrr9bhvUQfssAN5PMqWbwcmizOgcukZBYmY2U69gGmJoQeTqv
 C0difdRzR4Rp36uC5IrpP1KIJckV/EtgGAU8iPjN5nDBd61FzNeg7RgSolcI30dza4wa
 uVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720792112; x=1721396912;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wlfYj7Z3m+0AkCilfY7EhFD+i2IxG4dekIdbLaI62AA=;
 b=Nf/A4+EWz34Pr0mhGSOU9nD9vXt/bQPGEO/SuxARCqjQlRjLeV8C1e9I1mOzibw+aX
 33jwKjhPkJa0xWbW4ooa6oHswk3i5tLo67QxMbhBy9ucNGzei9SWAPkMsiiKLpN7XlGN
 wVd3t7NJdttUficKq7kTgMXAbDu21Kp5Hf7A9FfCSG1jiJPGQpvFZmRfns/b83anwcp0
 m84oP6AUFZeZeE9R+LvVm14lGVs5u7Aida4Ch95maU4vLOfNJJpQ7S53qXgtMvl+wHqX
 q7xKLFlIyGrSnrVvcgLgWK7/y4XEGhqaTnpHm2qsniqXB6hFx4ByKLRxKgxii5oY3Yz8
 7BNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzSgxEbmAXFXzdCeUEPkwvdyBlZLSDhajOSzXOsP2JXEpznE/gYSi4lq5qBSC4MvEq3Jg4xa6NiceBPv6+wv4QqrCzHTyb3G9kQbe6fA==
X-Gm-Message-State: AOJu0YxBbRpE4IDHuXBYh4Jl2JejfFKoQHafSCQ3mc1Hh0m/4tTmkGuq
 jviWjfzEnLQafQuH+ZnPdF9AxC9KlDrE4CpEQ5uD1b+bVxTYrytOUpLJ7xL6i1yBaDS8S0UVaPo
 GKProzKWRTprCzKlbTY6HkGhgULosqw==
X-Google-Smtp-Source: AGHT+IHm6UZNVpSUrQQbikPMDN0CL93KxeyvMKJ55r72oRD+CjQNjViEWeI2FB1IpHkxqy6/n8Y+WLgOHqN3+kdSUvY=
X-Received: by 2002:a05:6a21:33a7:b0:1c0:f648:8571 with SMTP id
 adf61e73a8af0-1c298215b0emr13442494637.4.1720792112276; Fri, 12 Jul 2024
 06:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240712122800.225367-1-sunil.khatri@amd.com>
In-Reply-To: <20240712122800.225367-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Jul 2024 09:48:20 -0400
Message-ID: <CADnq5_NeggTqN8R7N8xUehV_aNGnM5-VuE-U2Pmr-uw_hbr0mQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix the print message in devcoredump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Fri, Jul 12, 2024 at 8:28=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Fix the memory type logged for gtt memory size
> which is wrongly logged as visible vram size.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index f0a44d0dec27..f6806ae1c061 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -236,7 +236,7 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, =
size_t count,
>         drm_printf(&p, "\nSOC Memory Information\n");
>         drm_printf(&p, "real vram size: %llu\n", coredump->adev->gmc.real=
_vram_size);
>         drm_printf(&p, "visible vram size: %llu\n", coredump->adev->gmc.v=
isible_vram_size);
> -       drm_printf(&p, "visible vram size: %llu\n", coredump->adev->mman.=
gtt_mgr.manager.size);
> +       drm_printf(&p, "gtt size: %llu\n", coredump->adev->mman.gtt_mgr.m=
anager.size);
>
>         /* GDS Config */
>         drm_printf(&p, "\nGDS Config\n");
> --
> 2.34.1
>
