Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1A0CAC5BB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 19:46:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB3910E9A5;
	Thu, 25 Sep 2025 19:46:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HE0ZEkIp";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BF5010E9B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 19:46:15 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-24498e93b8fso2046165ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 12:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758829575; x=1759434375; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q6FpShBoBzCrektmbg86ZchJKKaFLhaOD1mCbblL0yY=;
 b=HE0ZEkIpPfcJAGl/7mwlFXvkUe1t+/4C12VEHnOViLtzZqLL4BLCc++GU49FpIWeeN
 LoaXe1vfFUQZ3/xs1XAbZ/fHqvJ3WuDntABaYIjnry/saOjvqZCNodGTmvEYIrFq5ORS
 6wCUCO8OevOQA+wQdzrJF1v/DjEROZk20Il+N8a/nrGXj7nqfWaG/z+wyYnG6h+QVGzO
 OV+MCaRqqlNX1BC77FVzYjkYsl0rl7DCsNfzv1YBveRBgeKcGBEz+xFwCupRfHzeDEZA
 Pgej+hEC60TbeyY5X5cYOvyvIh/QLXv4zshVqraBrM0+dHAJ2mOrbCYBuFfnAXZMGVdJ
 QcnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758829575; x=1759434375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q6FpShBoBzCrektmbg86ZchJKKaFLhaOD1mCbblL0yY=;
 b=B6wyTYpLvFuktsKxpCr6S2zgwrsuC546+aJEKvlWFQO7NuZsqfEryAuuX0rLjHFHl+
 sVdJLRVjCr0voPo9ZwPFWrVz/141nr/KFSQ8PXKAmHCEYCR7Hx+m+18A+b/jm4JGmmbC
 qv1Z6eyMAy9/nrZZPSCTW2oYu92NQX/nVfK2U+CJOJGyS6l4eFrCEELdc5stmxu3cz0/
 dcsZrdyop8wAATo7GChNfX70Zo+2sHCbKeaLW0qkLAOeMe+3aApoKDThIvbyvrukXXv+
 pcOl/udZ0Z0U4g2ffftEcI+rmQWKdKF2u12tI94cH/CQrYnov0A4e1Qwh/2an+G+6k0d
 i8bA==
X-Gm-Message-State: AOJu0Yx69Xt75iY0vh5rFY9delIuaSbrKiwJF2bqjavhQ9eaktZVtXMb
 MMElNeYwSi5MVzu86cBcV3UXKv1+xNwNaQ5XAMMqLdQ6NxkplUGmRX7VVlIc9/R9qpTdnetX/g7
 pPFcMsnAOCLrhHYf5euKiBkopRaurmTVWPg==
X-Gm-Gg: ASbGncsF6UFL0ZgzkvwLzPsvPG6Er9/znUVI2VATURPTlP+Y+c7zlkkTxb6dq/ybLi7
 iVZqkBqZzQQ0cAIuMDOTro5P+hKFIfceEX2hPyDZwv56hDCBQiA/xfqorUS3AoF6nVRuLHSYb5e
 VMiuyQESm1fuamURlaTc0H2iB2jq80paROyM15Oqk9A4ft10S05so2B3+ZFYn0odG8BMCoX2Q+l
 Tm/i4U=
X-Google-Smtp-Source: AGHT+IHYNu/1DlHxI4hhGH/6UhG6QS258LUhau9++okNUjiRviYuQRNwYpPTEHM8z2j2AU3wXRRSO0a889b5y2ZGw+A=
X-Received: by 2002:a17:903:32cf:b0:269:80e2:c5a8 with SMTP id
 d9443c01a7336-27ed4a36556mr31818495ad.7.1758829574854; Thu, 25 Sep 2025
 12:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250925191402.2518978-1-mario.limonciello@amd.com>
In-Reply-To: <20250925191402.2518978-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Sep 2025 15:46:03 -0400
X-Gm-Features: AS18NWBkYF777Mh0vmwHQp9yrSiGoymEyDr3TSl4Uske-Bly4jU7uLN2CKY8Cp4
Message-ID: <CADnq5_M7_LTPz7KjtCWHH3XP5OZsFZoO=odqNPtkOLdgxXU-LA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Check whether secure display TA loaded
 successfully
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Thu, Sep 25, 2025 at 3:39=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> [Why]
> Not all renoir hardware supports secure display.  If the TA is present
> but the feature isn't supported it will fail to load or send commands.
> This shows ERR messages to the user that make it seems like there is
> a problem.
>
> [How]
> Check the resp_status of the context to see if there was an error
> before trying to send any secure display commands.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1415
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I think the tricky part is that we want it to throw an error on a
system where it is supported so the user knows something is wrong.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 693357caa9a8..70d4bfb13f46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2356,6 +2356,9 @@ static int psp_securedisplay_initialize(struct psp_=
context *psp)
>         } else
>                 return ret;
>
> +       if (psp->securedisplay_context.context.resp_status)
> +               return 0;
> +
>         mutex_lock(&psp->securedisplay_context.mutex);
>
>         psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
> --
> 2.51.0
>
