Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E82CF885B
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 20:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0132F10E012;
	Fri,  4 Oct 2024 20:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gigt0vJB";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B9610E012
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 20:44:55 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2e09a36f54eso171339a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Oct 2024 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728074695; x=1728679495; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33TPDIOKl+txl2LnPlTEazOV/nJSKgZka2Iw9bNVWBs=;
 b=Gigt0vJBhk+pcP9zeT9sbUClGKlk0n2gC8pPohi6+SmZx7Hs97LOtI3mpL7khF7zM2
 98hWvlBXVEmch5Cu44N9NOdlc1IdHhLehuvFUmCw/BUZ0b/Ah2QkjRS5iADWnhIm6dhq
 gs6aSqXpe4ZOabOBL1mIOFgULmPHXzy7JLacouMXLOR7RWFQEcDBkLUIx9v5stBmyn6a
 vwIcaU3Tg5agRPX1ss4GdHVS7zz61lsv7kAYWM0K2gMIJkAThjLSI3b49vgzoC30fJJf
 WBzgEBlzsmVUETdU73y9l2UTfF0CjYyDdw1/9YiirSyK0Mw1JlpN1sASmc6YYsfgNe1+
 Dq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728074695; x=1728679495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33TPDIOKl+txl2LnPlTEazOV/nJSKgZka2Iw9bNVWBs=;
 b=XubX0rO8wcidLUXrjF570TIu31JPDZgBnc78IbNosJdxVYfyiKI/NcLGuw63+g77rH
 QVaX+pO7yuQ6lwuHoli6bOyadCcuH5N3i0KJkePp9Wg7ZR64u1aEwD6+9QLEb9kO/Cfl
 4PTbF4lAPOwkq6VPDn0dZAvS1d2gdcex0HTI1I5WR0u3pLsLCh2U6oTSx26ZfM2PamG+
 IzTQnkE5EUcRuobScP7SrOTOU/nnEkK5kzGpfLu12PEw/JmQTU97xD705C/XoegpziDU
 EwRGNhwmTU2Ky3bGqTWQavKB5TJX34qEQiNBWzOa15NNEHGf0w7R7MS53Ck2opK3AUNs
 GrIg==
X-Gm-Message-State: AOJu0YxFQbRZ7+OSbHSGPVZs76va4tproo7JCQeof4hs+pCIzWOkqn8M
 cH8dEHrYQBSQWCNmX2pYCqC6B5Et93qoJdYiVJSDLa1nNUu/0+7zjRCYuYg6kIJcyK5zKCLvsGq
 UzvMXbhH939yka7XBvejpDXniElQ=
X-Google-Smtp-Source: AGHT+IEHwUdnPaDidhuyWbFnP6/MmldWv4Pb2bXbtceDlIC3yMyVKW1y4Mv9PQw2Wz0i29ACYQpuXfTFTpH8SkkcJQY=
X-Received: by 2002:a17:90b:3bc3:b0:2e0:876c:8cbe with SMTP id
 98e67ed59e1d1-2e1e6369885mr1877844a91.7.1728074695350; Fri, 04 Oct 2024
 13:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241004203350.201294-1-hamza.mahfooz@amd.com>
In-Reply-To: <20241004203350.201294-1-hamza.mahfooz@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Oct 2024 16:44:43 -0400
Message-ID: <CADnq5_M5ripf041=G2u+vkf-WS0_dFtLqtqwS16fOQTB3O6cBg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix hibernate entry for DCN35+
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, 
 Roman Li <roman.li@amd.com>, stable@vger.kernel.org
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

On Fri, Oct 4, 2024 at 4:43=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.com=
> wrote:
>
> Since, two suspend-resume cycles are required to enter hibernate and,
> since we only need to enable idle optimizations in the first cycle
> (which is pretty much equivalent to s2idle). We can check in_s0ix, to
> prevent the system from entering idle optimizations before it actually
> enters hibernate (from display's perspective).
>
> Cc: stable@vger.kernel.org # 6.10+
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4651b884d8d9..546a168a2fbf 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2996,10 +2996,11 @@ static int dm_suspend(struct amdgpu_ip_block *ip_=
block)
>
>         hpd_rx_irq_work_suspend(dm);
>
> -       if (adev->dm.dc->caps.ips_support)
> -               dc_allow_idle_optimizations(adev->dm.dc, true);
> -
>         dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
> +
> +       if (dm->dc->caps.ips_support && adev->in_s0ix)
> +               dc_allow_idle_optimizations(dm->dc, true);
> +

Is the ordering change with respect to dc_set_power_state() intended?

Alex

>         dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POW=
ER_STATE_D3);
>
>         return 0;
> --
> 2.46.0
>
