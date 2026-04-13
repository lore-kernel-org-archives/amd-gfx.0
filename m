Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042D2F531C1
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 18:23:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7891510E13D;
	Mon, 13 Apr 2026 18:23:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AqOjuwgL";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C21D210E13D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 18:23:34 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-12c22b9bdabso284592c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 11:23:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776104614; cv=none;
 d=google.com; s=arc-20240605;
 b=DqqvLnKTgiZMkpsT6DYpxyDi69DvE2/p5NAd+3GzG9jLSb/CVjZ8Wuh6gpdnLnhxw8
 9J7XPlEOPCJk3P3Y9KZPQnxHkHe9n32pKA9lMqlAEwk5pr1M856EHQ49FMaLbjYeRVa4
 uo2Mqw9Kj6uz/ybKnS50DL6oDU4KjQGZcUyPzNMbOcQ6nKhvyCbECvVskEtAcG6FP+Q3
 qhCEd8VOBW5Kofy4AAMc0EocpTXSF4MHPhqpz7h+ka9z+6/n9NbrchBs05tuCJGLKLSZ
 RmkV0UB5OzO5BiBHBK4Y6fb7VNbV5a/HUPlgC8CB3oeDkF5kTZb3EhN1WF+VARxcoBTd
 D6EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=An4JK7d4T1eGJnlpfGik9vJYn6Y98TDJK/A6PG9VAsg=;
 fh=UTD6ddlIpGSd1D7xw+74FAGUaPL8YCiOwBmZMcE278o=;
 b=HtSPt8zaZZQi6Hp7hhzJJCBIpVIcmg9v3xiCIhaCFsRtBhDOrziAw9VfjDlNfJB2Mf
 +YrWxT54qsrM8IvnKSLfTedY+GoeJB6pvC/QwmubbUKhPYSXqB/jrBkDGCxAjPk8NEpv
 8XaugsWY4c5qmGFdo+8KBZ5oaMtcUwiqiXzJAANWGIhYUdmJSsrpYo80zK7Ck1YYble4
 ONO0L79uDem3soJlfLtt7TRytLA5gEI2MwUNfSJy+v73aX6gt2eRNShy/ImhyY62VAly
 tQHTNoQfYY9Bu0h05p9dYQa6BMDuU1pWlQ7sshvqrOscdv+GskjDNjd4qIsBpY9MKnw7
 RZGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776104614; x=1776709414; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=An4JK7d4T1eGJnlpfGik9vJYn6Y98TDJK/A6PG9VAsg=;
 b=AqOjuwgLkSTr8rOY1uUEbmK7Uls6ih0tqI33cI5bThYkl3JH9+dK+FyyD7mhA5VkxS
 rmC947xUA/eMnO200N/+O5rvvmvYrkDSO6mcwXrHS2rixNEiucXn8ji6hGU1JbsFz8CT
 ZOatGxs7rb9j1tvnPCkqfyenlb6V0HYkf4Wbu3OzdxUYZwTnSUpse9K9qC6WRivwZtbX
 gwdwYzffEKs26fGPBeku8+bfzQP4o2yuds2Y5LM0+v3R/VKiX26DwJb7DDnpIjdnKPbZ
 pz8cjuK6mQ4M5vZMk6eKrIFHTTKckyG5vmh72D3T+ER9Midk6lXGZQPWO4FXg2/85rQd
 pyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776104614; x=1776709414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=An4JK7d4T1eGJnlpfGik9vJYn6Y98TDJK/A6PG9VAsg=;
 b=YOxxcLddRbVlr5u0YS5e8nDBWOlacOEu+X+7+cQbTaSx6xzqYrMyf2h5bvVaA2oOoN
 AxX1xlqJTbGNhqewxhcycNrOZO1G//ijlKBq+EgcTCpUjpMMt+LESqGRlhdw+4lTw4dO
 jOD1SDZuogR7rq2AG1Dwq6tMqFOW8JrfBQ/3bsrJZosv4jK8OyQCf+Oxw1gsJaz2tEuN
 /4MnO4s2Qs/A8CeWs65HM3pCRGZ53V8jNpAQC6r1OPNS53KymT8UaGp6QjrFa1yD9hGV
 WZmGXJ1CiblVB0ZSjBN09AuctNdnZ0+zlHrvt8p9zICTm6j9rn9qOjoETd9L6vSRkeEE
 H2Vw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+O+xGxjEPtlYt3imptFcokbKNrnY+EHM6xmGCc79T5aGdD2WEHIX8Xwiz0wmrMBokblIAaJQsn@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxm+R0/Q7Q4fLnQ1Mh5Jdghpyp3TezFfbR7rOtd4YvH3VsNVXQJ
 h5vAGfvGWUkCIHJOrO1jOIVFH5b2lSf9V6sRbwUOBHzyFckUQN4oToQTmlNDUrVboeswb/Yk739
 blcIjmlKyGKmzs6vvtCN1P5R/3bVlsNw=
X-Gm-Gg: AeBDieshB/xWM7ZCta1QvGJoUDqiE7mCEzY0rPdmu+ns5PDwxHrnL/3YGfbifSKEE85
 IJdRoqyyzOZg2epHf1b/aH9VPSsCecihjSrsUenYNdeNSYs5Z7jClc1D4F+/7SS/iWRKCz5B8ne
 sPCYFEjx4U43fu2a69e/f/g2H5nEw3e6skgBi0E5LOP7wdd+nfEEnS9bltZqQU8BZjqydDHy2NI
 hOPDwJP1kU+b/fAzzkXEA3FhKenbaisGFVA+IjGmlT4XnqaCKoAfHSIG1lW1DQOxfQI5miFCTKS
 /P2c1zUbaJnpUpBcGapgoya7Kz4FpiY/2yirX4Y47gX5LZIC34+xdU7GTAYabKebebtM+g==
X-Received: by 2002:a05:693c:3109:b0:2c4:76a3:bdfc with SMTP id
 5a478bee46e88-2d5838e93eemr2983048eec.0.1776104613801; Mon, 13 Apr 2026
 11:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260407181407.1052586-2-thorsten.blum@linux.dev>
In-Reply-To: <20260407181407.1052586-2-thorsten.blum@linux.dev>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Apr 2026 14:23:22 -0400
X-Gm-Features: AQROBzCf-wMoHRshxqW11QnJtwMo1Vt8jMJXSXXZ-lSPV9mxoaWE_sl-W08jpOM
Message-ID: <CADnq5_NVfEN9QcmuJJfUAw24MvoqsAoHStnTvM7XhrCj=87_GQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: replace nested min calls with min3
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Apr 8, 2026 at 3:19=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.d=
ev> wrote:
>
> In dce6_available_bandwidth() and dce8_available_bandwidth(), replace
> nested min() calls with min3().
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/gpu/drm/radeon/cik.c | 2 +-
>  drivers/gpu/drm/radeon/si.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
> index 51a3e0fc2f56..a13635443833 100644
> --- a/drivers/gpu/drm/radeon/cik.c
> +++ b/drivers/gpu/drm/radeon/cik.c
> @@ -9063,7 +9063,7 @@ static u32 dce8_available_bandwidth(struct dce8_wm_=
params *wm)
>         u32 data_return_bandwidth =3D dce8_data_return_bandwidth(wm);
>         u32 dmif_req_bandwidth =3D dce8_dmif_request_bandwidth(wm);
>
> -       return min(dram_bandwidth, min(data_return_bandwidth, dmif_req_ba=
ndwidth));
> +       return min3(dram_bandwidth, data_return_bandwidth, dmif_req_bandw=
idth);
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index 26197aceb001..4681ff28630a 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -2150,7 +2150,7 @@ static u32 dce6_available_bandwidth(struct dce6_wm_=
params *wm)
>         u32 data_return_bandwidth =3D dce6_data_return_bandwidth(wm);
>         u32 dmif_req_bandwidth =3D dce6_dmif_request_bandwidth(wm);
>
> -       return min(dram_bandwidth, min(data_return_bandwidth, dmif_req_ba=
ndwidth));
> +       return min3(dram_bandwidth, data_return_bandwidth, dmif_req_bandw=
idth);
>  }
>
>  static u32 dce6_average_bandwidth(struct dce6_wm_params *wm)
