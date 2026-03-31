Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80668109B47C
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 14:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A82110E1AD;
	Tue, 31 Mar 2026 14:50:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OCENolOC";
	dkim-atps=neutral
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com
 [209.85.217.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C39410E1AD
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 14:49:59 +0000 (UTC)
Received: by mail-vs1-f41.google.com with SMTP id
 ada2fe7eead31-604ea0b7789so258685137.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 07:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774968598; cv=none;
 d=google.com; s=arc-20240605;
 b=bFfN6jqE+D4niX5dwTzG+G+bgKu7aMlHWOEducPN/fa2zuwmbH1LmvfWcjrQqRkhpv
 kfVgo8M4BDmzOuNmImVAx5xkYXtP7vmz1bmX2lVhRT5xd3JPo7GktAC59dRy9CJFudMV
 4THFsnkzaAQS+PcreAcw9l7aq20EUB1lVe8m8piEnltOCB0L8RFP6U5D9rguroRuMKaj
 ky/t/VJbr9B1xqwh5zm7euiAd2Hx6Vy7+v3fYZ7exhexS/VoJJd6DwGMwXh5zNqU6sdh
 JnkJHUBU+UfrR5UQ/cyVMwmngKrYnVAdGsOfDnnz1rG/09/ADf4LJww3ud1yZMN4Yjv2
 e2cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Mkf0OB5moQvG4GasAeHoQXSqm+bAnxXSlhG9Kzvrg38=;
 fh=3ulBHqEiiILYHrupCCAz1owodLTh03pFYL7GUH8qNzM=;
 b=cOaMIt+afLBoy0GzJnSikEpJF/5NyMHgRXfMs99n8eb03tpu8Rx+DD1YYh0oG2p0Gr
 Ojm3oNp7ArwwzuzmnSk+j+AXxI1Ej9KR5ji6L7Ly2Jj9p+X5XTxRNI+tQEGo0hurIqMQ
 d31ybu14HoMEQJ/vFx5ObIxgnePHacXOMZaEXtkwyYZBogUIflRtposcSQiyImA3rGGm
 b6NypMdtPVZFilnJKIRbGXbIEryZrPIIuRG0K/BpdBIePsgKnLGyOstBJA40XDFJZ25Q
 k0ILeKQRspnLn1sgeQ/Yxvp1szORU2GJCPNC5kjzrwZV/NCVAHZDmT/uqjSw5fhK9jKr
 lBsg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774968598; x=1775573398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mkf0OB5moQvG4GasAeHoQXSqm+bAnxXSlhG9Kzvrg38=;
 b=OCENolOC1qkuPXCbKr16/Pq86HcJe9udimBfAC3OFEA0OjTgnEPh3teI2hSXEraYTU
 X9yWnV9N8r4hRfq8gEpzyHxwvvSWjCDUb7QHxy37hYzdUEDYVpsKXZ+vRKdz7IaGSYLG
 0MN6nHkzkvfdr1dnWb7TrkcJk2Y6nkTHM29K/ddLTzKsf/W4PkKOykpagIEbH36TjVsD
 6GKV8M5Eqt3746huvXEFSqIJziVLiIKBAj59f5Yo9zxcKSn/bSYgSLD5jOBWMLQ9uT8/
 0KTZQX9oxOQCNMdUU3rDP9yA9IwByD1ca0sk1bP5/wGsGTQuSSyuAHOONO+chYEZWtm1
 cqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774968598; x=1775573398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mkf0OB5moQvG4GasAeHoQXSqm+bAnxXSlhG9Kzvrg38=;
 b=ou/fwjGe6Ti4kqR936QJ6DwlB64dK7FQiSPoAtWjMV+Yehh7zWpDjpAptKYU8seYy/
 nnhBmA2XDsbeETaR/vfiilvqP6JziTehp3Nxr+jOZy3CMWet9zIKvtA1VP6XJogg14ty
 r5gsT+Ioc70QRH4l8bGGWbjS6OuPJjAdXzwCijGogHwFLvT9W79IH6mM1jsRd6rfNE+1
 U6duO/QdO9vcGrdawp8KVHpj1OS+GQUb4dKqYBX3NJPFpJtsl8lqT5T6YTd4x9LmAFj6
 x/5y0iCBWhzSxtYffB/fql+1OoCYXPGcCSb7zyrV7627JBaWbtFfZvOjPjzpk9LocwoP
 fRAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCghyTO/R9ERVyFvS1gbg/x36HoIng56Gp4HcQgDNOpJBA6IgS932S/wjE71+q3ZeeYSgkjIFb@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznYcfC3lUL1p+9TM6unkjaK2qYmYMyqIuXGQgCFfKrvb86dNkU
 GmqM9g1r5mdt5D2bvqMpG43hdR7zxq1TUIfsImKVHEOKXu9wqTFTXFxN3EVRo3uxNF6mpLZlxZZ
 odn1jRtbPrAvVuyNCfj9RSzSUZXUlYu8=
X-Gm-Gg: ATEYQzyEQNQDtdX60I8eHbvAYlphs4hUclaEBZWD1IyzQsLSqXdsdma/P9IUMELV9Hk
 vN+kyVb+RyIUn7M/PiaNP4PWxk8eyE4tEIOKw1g4XmQJOomUPqWJLojKLxhfYXe2TXHcbUszwxF
 aNUL7WCcfAIX3MiyVLiBDbVwRRLsfB5sFoq1ENe7O+isn8NcVUUp6hNOEOW+M2sIU6xJXKa7pwx
 fzyFNjGbGwaE8BQmpAtWtTjP8fRRED+98HJ0kmIPXSCMyHH7oNyxhZAlybeezSdSAl1tNGUNIjI
 TNtw3t52jvtLsLn5BYMCqHjBYzrv6xe4CRzehVpP66Zgi7jd2kFJ5sJIwhVJjM6mZk17IA==
X-Received: by 2002:a05:6102:21b2:b0:5e4:9fd:5a3 with SMTP id
 ada2fe7eead31-604f9296099mr2321940137.6.1774968597941; Tue, 31 Mar 2026
 07:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20251224144708.61167-1-marco.crivellari@suse.com>
 <20251224144708.61167-5-marco.crivellari@suse.com>
In-Reply-To: <20251224144708.61167-5-marco.crivellari@suse.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 10:49:45 -0400
X-Gm-Features: AQROBzDb5lfPIwy7SKyX75mQJqwLgD-PcWyA8-4y-kCD_P3pLCRi3gfxi94tegc
Message-ID: <CADnq5_P3ogoLiFumJieeLBQ6zktLO37=EwOaNtc=ROEK6Bt05w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/radeon: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philip Yang <yangp@amd.com>
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

Alex

On Wed, Dec 24, 2025 at 10:26=E2=80=AFAM Marco Crivellari
<marco.crivellari@suse.com> wrote:
>
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
>
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_w=
q")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
>
> The refactoring is going to alter the default behavior of
> alloc_workqueue() to be unbound by default.
>
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify WQ_U=
NBOUND
> must now use WQ_PERCPU. For more details see the Link tag below.
>
> In order to keep alloc_workqueue() behavior identical, explicitly request
> WQ_PERCPU.
>
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/gpu/drm/radeon/radeon_display.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/ra=
deon/radeon_display.c
> index 35fb99bcd9a7..99a3e4c480c1 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -685,7 +685,8 @@ static void radeon_crtc_init(struct drm_device *dev, =
int index)
>         if (radeon_crtc =3D=3D NULL)
>                 return;
>
> -       radeon_crtc->flip_queue =3D alloc_workqueue("radeon-crtc", WQ_HIG=
HPRI, 0);
> +       radeon_crtc->flip_queue =3D alloc_workqueue("radeon-crtc",
> +                                                 WQ_HIGHPRI | WQ_PERCPU,=
 0);
>         if (!radeon_crtc->flip_queue) {
>                 kfree(radeon_crtc);
>                 return;
> --
> 2.52.0
>
