Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5050109B462
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 13:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3365A10E381;
	Tue, 31 Mar 2026 13:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eGeuifHe";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1284A10E393
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 13:20:29 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2bd801b40dbso400742eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 06:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774963228; cv=none;
 d=google.com; s=arc-20240605;
 b=KhONK4YvWVTPc1kQTW/mFFNigwEYDshm6KOKFsV04GaCegSsMtaQ2Y+zhjuBlvInzj
 otFVdAoU3+c2YwEvBz7rmUZ7wPBcKjKc3b/cJcIeIw5jYs7RDzFQbzj32sGMnDgy+FDj
 RkskqG9ZpQaOR77ib+hsnlSlXFi1izyINy6wQs91AC6Ms17+XmcpTumcS+8OtAMPfLVw
 CXJe98hO4RSkBvZuOJRLHLM1cWPyi4oBUYyBe0DkrST7XutQKBpvqrXFLDXNYj+g79vk
 KdkvAa79DdBiBPmP8y0ufj6UyQQsYQwoDim526i/Ho9cH9ncIpX7qVis7wb9+a69p5FL
 0Srw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TBHcm+J+3TovwH7cWbqMLHI6dZy4DsmX740rY0qpt18=;
 fh=3Po+/RvD/5iFkIE0rqicnBb8D6OFtLYbkec0Nt4W/BI=;
 b=CHDqyfKD1v25KRC15BIYW9Fyw8Mqdwb7z2mHHu9YWO8lgMvS1+1985FqtYoTVz37Ol
 usLOpS0gynVn/7lfcqy2Xl8R21qo6UXWnNb9v5xQULeo2vN4M+ZSFK84jkRh2+g/v3As
 nBWkeIdUv9C7oT4PKySgCrS/V9HMYAH+kEkenkTLTbHjg2IBcaWG69gKznW0sD+eBnOU
 l5L5gCgHQXJDI5vYHfaW18pPZPVgeWAz5z9GuGBlTIgSo7uEz3QWRPF/nErEsrjDe397
 i/E8Xl1YK8rOQJXFKRnTV6+JT7/TdsL7UAPrzzFy7iwmp/ZxClnK/x7e4+W871u+c9p0
 bYMA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774963228; x=1775568028; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TBHcm+J+3TovwH7cWbqMLHI6dZy4DsmX740rY0qpt18=;
 b=eGeuifHeQ5e0LAzZOsVJ8hyRAv9mzpYHs29diVVj6zL1pnXKbu7a7v83lwz2DaZZ3E
 PBi6NkMCCBOOjpZZWckSpkFtGy/epRa6UvXxyI4vADAurampQi6rzyHgHLRkmYb6TWFI
 ueX7lWqC8uAIRSihmAh/9HLf3u8PzvZ2ey06F5E1ehaZlX1tvLyzvNw83vWRDccOrhO2
 YnsLzt6zpro12el+zZW/V785N/aQEf5/YErC+0A8jyS94E7vE7xh3SoWwa/VJ0iQb1Yt
 EugUn7x+tJ79xEHn+9nscveZeVvxwhI7FG7LCw9ZjPzdaOxp9ufVZz6sOsOLIkN0R7D+
 Josg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774963228; x=1775568028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TBHcm+J+3TovwH7cWbqMLHI6dZy4DsmX740rY0qpt18=;
 b=qOs6q3+6tY8DyscVVC8rKtTyWDgsdj9jgPgjHnd4J8ziWz+K+Yi6GT9OPhTmCNisCN
 fNmkcV5LZcspaz2GiHGR61GERXlE1/Ea47QnIVoQurtKuTLVvdRiVT7QP4PbTMUdVhOm
 s6+87ANzGbjxJGIUTXHIy+1J2+HnFkRrWznDIVvMfuuPIGNstF0har4O8KtZvEIklJ6l
 NUV8cWpp2rdBXEtACOPJ52EhGbfJpySuGaUSz7ZjW6b+wEKWG913hFw1T7o1LyKXiDC7
 KeoV+OlUmKFNYkyfxXPoC3gkfBf7qseAB/q+LY8Zi7qZWhFYNPAcEhzVXRulSd7PeDst
 Fjfw==
X-Gm-Message-State: AOJu0YwueDoBopzqQQKDeZwkkPX2hDUfQLzzK9bnkLeagJimVYjhupp0
 m3IiM42WjhtIgMB+v1XKSY/ieJViHljYF2cn5O6BnQ9/dUlDSWxpk8whh2110J295ZwfPEVlBA2
 2Q2ajT2fAk4CCFjSMICviXaY+Kqob9fo=
X-Gm-Gg: ATEYQzxghuaoRfI6KXl+M0hPurKPASTY1zIS4CuS+hChGhQOd2tZjmH7KW6cA8IjwJ2
 by0TQa2Q8pp+XHEynDvB8DQ7VauXPR0u8isa6+Krvv+qvMcIb4gzgK+P1uwRpwXFQLMeldFchPV
 xpFdaYdyMyLcKKK3/R8FmbJst8/305JtC2nK08YkvU5Ztzhk5vM4EwEVnB91FivOo/bF7RoOSYL
 fA/SKuaz4xWQkj4lepOYKMO2Z0HISkTAKTUkU8rmP7Dtm6j2MEDO0zJFJnNHWSNEJZK+KJf/Zt1
 VYcWgxIvcOReIXma1amzo7zPGHmtWK5gbDgtxbCyAefENgyhEZRydaOQQlcHy+WTMRUOxQ==
X-Received: by 2002:a05:7022:2209:b0:128:d4d5:93b9 with SMTP id
 a92af1059eb24-12ab290a664mr3940968c88.7.1774963228169; Tue, 31 Mar 2026
 06:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260331024705.1361626-1-kevinyang.wang@amd.com>
In-Reply-To: <20260331024705.1361626-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 09:20:16 -0400
X-Gm-Features: AQROBzA0nct8ZbdcqRSyQHYKpcdbVuSaSFYMThkBh8bqXpe7uDGv3eXzGPYJ6Rc
Message-ID: <CADnq5_NxOp5Xqk1kb9Gkq5q2MDwghdJ=2__XR40e+4YkmfbEag@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd/pm: fix memleak issue in
 smu_v15_0_8_get_gpu_metrics()
To: Yang Wang <kevinyang.wang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 hawking.zhang@amd.com, lijo.lazar@amd.com, Asad.Kamal@amd.com
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

On Mon, Mar 30, 2026 at 11:09=E2=80=AFPM Yang Wang <kevinyang.wang@amd.com>=
 wrote:
>
> remove unsued code to avoid memleak issue.
> (NOTE: This bug occurs during internal branch switching)
>
> Fixes: 60c033841eb9 ("drm/amd/pm: add get_gpu_metrics support for 15.0.8"=
)
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> index 89a44b456e8a..b158be7cd7bc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
> @@ -1601,8 +1601,6 @@ static ssize_t smu_v15_0_8_get_gpu_metrics(struct s=
mu_context *smu, void **table
>         uint32_t mid_mask =3D adev->aid_mask;
>         MetricsTable_t *metrics;
>
> -       metrics =3D kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
> -
>         ret =3D smu_v15_0_8_get_metrics_table_internal(smu, 1, NULL);
>         if (ret)
>                 return ret;
> --
> 2.47.3
>
