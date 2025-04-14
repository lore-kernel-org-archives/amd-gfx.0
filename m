Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF30C369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 15:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E442610E600;
	Mon, 14 Apr 2025 15:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lY8XH2dO";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E162910E600
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 15:06:24 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-301317939a0so823195a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 08:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744643184; x=1745247984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4OqioES4oFR/lPfArXBqDS/g0p1Mz7Nfry0UQk9f3k=;
 b=lY8XH2dOwpCkimQ6FCusPA717QVoa8codOkhIzVHXsPcSGRX0EFa9Q9XHOKHou1Vc4
 D1/g4qW0vUsRVV8Sm88Q1iMl8hpCpsIZsVbaHHQlfqyi4o3+CCaDHxlSNIgbMEnQTzT4
 0bMrpUdH1ZfU6lBYlEQN8877tYbF27SlX0NoqG63IOt6Ko5oeZJFbrUolmt8A5GVLdiv
 JyKlzMKu6uW6eSQrmRkeFp9NtQ4qF2dMLbAOV0bxwrRbjWWviQ60SJQe1UgDi0zxSAfa
 gJlagaAMXK7iFyxxc8NcDQjpvLQUugbjEx1zm9B6lkug3iX8kqxVP7jOVdZt4CJzLyBj
 VYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744643184; x=1745247984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V4OqioES4oFR/lPfArXBqDS/g0p1Mz7Nfry0UQk9f3k=;
 b=VwWRCyf/auNBdHy33N2JFfcw/NZRG+3B1GTViKYQq7Pf5ck9YeLSNqGh3t8FUptUZc
 F+vMMNoLzOW3PGZDEVEJMf1N8ibq1IldA/xU/BrpSq9GgXU3shbzUCF+8X0oHeqYw4fx
 pHziisTLKhRT4XkyU6U4VC42PTXI+27Lqn2drBgf4VrQRbfckxus5KlSMcMBSFk/6Q/h
 LDZDbMnTo/GQ3P7mDTOwsCeUq637wXl7bOUMxYewwv9fQcXzx6FtUKt/wRPjqSanScrl
 Y1E/zxB3HwGeaSiLk7vSbhc4gYaMlsnzkPxBHrRK8U38mE8qXh4WlRhldyAUA7hZSdAF
 YtUw==
X-Gm-Message-State: AOJu0YyrZODCLawGr2jPJdVLe0Xcts+HMtv8+TIbFpt15wVeMf42uVil
 FOvxffVo6nG6jbS7N76IVucAUTJhX4uBrdU+Rhh6awcqBIrdxIgyZplTaAiVxcy53GXdkmMUNaG
 JvthCwZZzfrSKG4gZC0ufEGhoiA7Qsw==
X-Gm-Gg: ASbGncsyb2JOBSUhrz/0IyeOVpJHWjhI7rOv9O24hFPS+f6lBxbAupd76ecSRSpVp+U
 peagOlWwj4Hii8E0TSVQtfYg9cc9Nr2vkbUUQPZ/Uf4ZtF8iQ2byFRY14KcvfyAB2HeYYGQuboF
 WKH8HZCbNrB9Vam/cMNkQF2g==
X-Google-Smtp-Source: AGHT+IHUvz3w1Tu2BnFS+m5UC7sH367JFsL50n8GouEaA4vTgTW735JMDbAGSPTvssZsd+/GMZXewLkHJPDQ6MK8mGk=
X-Received: by 2002:a17:90b:4c02:b0:2ff:7b67:2358 with SMTP id
 98e67ed59e1d1-30823654968mr6890881a91.2.1744643184079; Mon, 14 Apr 2025
 08:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250408021100.5439-1-alexandre.f.demers@gmail.com>
 <20250408021100.5439-7-alexandre.f.demers@gmail.com>
In-Reply-To: <20250408021100.5439-7-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Apr 2025 11:06:12 -0400
X-Gm-Features: ATxdqUG2tzdGIHk78tUlQlkifP4tGhD2BYv0TY_5lSL0TXsQuShlVKpwxeT1GTI
Message-ID: <CADnq5_MGNi+Hg+rfa7Vr_vzqeFpo-oL1g1Qwg0Bo-Bs178tEqA@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amdgpu: fix typo in bios_parser.c
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

Applied the series.  Thanks.

Alex

On Mon, Apr 7, 2025 at 10:23=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> Probably a cut and paste error from using get_integrated_info_v8's commen=
t.
> This has to be get_integrated_info_v9
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/=
gpu/drm/amd/display/dc/bios/bios_parser.c
> index 3bacf470f7c5..67f08495b7e6 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -2384,10 +2384,10 @@ static enum bp_result get_integrated_info_v8(
>  }
>
>  /*
> - * get_integrated_info_v8
> + * get_integrated_info_v9
>   *
>   * @brief
> - * Get V8 integrated BIOS information
> + * Get V9 integrated BIOS information
>   *
>   * @param
>   * bios_parser *bp - [in]BIOS parser handler to get master data table
> --
> 2.49.0
>
