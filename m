Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2989BEE20A6
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 15:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE4E10E7FF;
	Fri,  6 Feb 2026 15:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YbZoaQmE";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A39010E7FF
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 15:30:00 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-124a2dc92dbso132285c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 07:30:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770391799; cv=none;
 d=google.com; s=arc-20240605;
 b=hQIM9PfE7ig0pDwpw1U0m0ySGZfCv3BNRk3WtL6p9I2dFAyKkSwOhPb8csVrkOeUzT
 V0Ol+HMu5vzMIcz9mXcAeknXDZ2LBOCxwFwyhen1a3W3gqCukMvdp+sDuf4+f+8hNy0E
 LnMd1vfRRux6ntA3RM+sB8VJUCnugVt3+QhVrjLwGxsredHSwoktR2wMYjQTtQGOZA6n
 WEdgW48QJlPUFjP1JK6oSWE8cuv3v22Jq/6timGTKTAYGP9tac7gVKMvHxGTjYkpCpe8
 du3+EWSNGV/kupC5q3KhUEurCBKEIIJXA7v7Ux5lod3eBiP6Wmj3oYMdUrGtUJI2Gp5o
 U2YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xAJe2FL/OXd5GgsMuHVgTUR6a0DEm7QyRdzu46yBqQE=;
 fh=3Sqop/F48HGO/fblw7eXhLg0iij498fKLwoUH89NpDI=;
 b=Zr1PcHF9aNoBxT9pOC/yU/exvUl8dCgyorKPu61DY0vTpx8nDg5e5dIkZL1ROK7sJe
 L3NiAukbehE5JS8sGTVjflistVf6lM2N3XojiCuUCI7ekdXt/BXkQ9uxwy3mSJ0PFF0r
 QTbqYYJfB7No3mOwuqgF4ZSskwgTZSe+uU+IW/ZGMGt+937Zte/euyCrLTbRJqRTDDJd
 9aw7qlNBCeajfs7CHY5ufp2sXL8VzLoFNDatpL8ZCXr5fyJOO5f89GN/SXMKnFP9O64I
 H5wS2PKj2gLtDIBWKPz7CupojFs+zOU01yrJC3a51YNDHQXojZkyXyPRKeZCPg3c7Wmu
 NR8A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770391799; x=1770996599; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xAJe2FL/OXd5GgsMuHVgTUR6a0DEm7QyRdzu46yBqQE=;
 b=YbZoaQmEx5bo+Laxw39fklax3GfL+Iif7ywAW1kpjLdMNdH9jveyWv6h1mGa9UoK6r
 MfdXlKcKRiLTHwKIUDBKsWXrAlGdyw8Q+2a4KRpcr85Sm5BLKVjtsGORrITtT5eDFJ29
 /OlSeEvYCDBRZA47AwII60Pi2JQMFidQQB00YYZcISgn1EpsX9IymPjfyEQgexP/3C0Z
 VDwhuSWTcM9wlrE5nWriGfBlTq0rWqpO+It6jLtDLaeD/AsLbpuvLtck/++pqJHaAvxF
 Cn289fjCxNh3/Rhx5pHN1jHvaED6cb625lILyCRWeJdA9Y5IG9pXWlsKUGN8WEx6Ra2e
 WnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770391799; x=1770996599;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xAJe2FL/OXd5GgsMuHVgTUR6a0DEm7QyRdzu46yBqQE=;
 b=gtLTTko4c03lxTZLaMkxRtnLxVVmax/z4zgdY5tdwQYFzjm1epZeSC/YYwKQ39xGcL
 Vz++D3qW6ZX42R/YMaNwGTQEfsNgTJrXAjpNlWAKhnN0aXdRLRsVEcItGgoLPzkkEdWp
 DErBI8ylW/IDwlXcTjpINDeNd89D7iP3meqRkBBOm4YCHNBggaoQKx1uxhU31IurJ+DK
 Acfw3S6XFAm5Okc54PS8ldff6oApR5LzZrZr6dOUJ7Iz4kx61zB40GcpkQhitZjDr2uv
 1psGY6qP5raPGA5OF7OcSo77aeWvpXlnEDUS1BoElHl+SFRpExoRVuzjGeAOm4ORxyrh
 NMYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/HiBUdqedvNpU/oGiRauZut+HfElPfkNbEiHJy3VdKhMT0vehebuF6I6AqkHYQIGuoVv9lExr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXt6oce+htAH76GxqNL/oiq6B2tnKj7A8hEr7k888YqkzjiNxH
 NHVLEaV7c+16FxFL8ing7R/P/+E22HAolRV8r1rJTNj9qnu7SItu2p/pLO2RgIaailDDnkHl2v3
 8Ru7TY4fMzLRreE73idiZR1IafZxAUvk=
X-Gm-Gg: AZuq6aK4GKOTIP+c1aEriUEwvxvgtdYuHEsKs7YmvhMcIlMLmdH/qzjWztGZAez+OBV
 FH8fKienBz47Vcoi6OSQZ0AM9nUh6IpBsPyNrjgkWqCvC1QEPAxZVKeZdrtKDWR+IRcq47YdEaL
 KAd5Lkiv1tBKBIyonIHtUv5CYdSnajTh6yc3pPObyEiAPM0PC61utuj30kdtrB0gVSXrFW/xihx
 p9m7Xtdr3uFEp/OZ+8/xkSsIO98My7tfmQJsaC2MZVCaWGWlgQf0+V3+A0TA4DuR2SLjaIH
X-Received: by 2002:a05:7022:f110:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-1270400d2efmr839594c88.4.1770391799399; Fri, 06 Feb 2026
 07:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20260206142445.1476609-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260206142445.1476609-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Feb 2026 10:29:47 -0500
X-Gm-Features: AZwV_QijqbE92NV9bWZ79-5g2fZ_KrgjBI3L-YTIIVzGec3EFHZDVweTJiQRqT0
Message-ID: <CADnq5_OoXJGHveCPLOuvtTHURqvsK9m=syj3RiuCq-DDotULwA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix missing unwind in amdgpu_ib_schedule()
 error path
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Dan Carpenter <dan.carpenter@linaro.org>
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

On Fri, Feb 6, 2026 at 9:32=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> If amdgpu_vm_flush() fails, amdgpu_ib_schedule() returns early after
> calling amdgpu_ring_undo().  This skips the common free_fence cleanup
> path.  Other error paths were already changed to use goto free_fence,
> but this one was missed.
>
> Change the early return to goto free_fence so all error paths clean up
> the same way.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c:232 amdgpu_ib_schedule()
> warn: missing unwind goto?
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
>     124 int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num=
_ibs,
>     125                        struct amdgpu_ib *ibs, struct amdgpu_job *=
job,
>     126                        struct dma_fence **f)
>     127 {
>
>     ...
>
>     224
>     225         if (ring->funcs->insert_start)
>     226                 ring->funcs->insert_start(ring);
>     227
>     228         if (job) {
>     229                 r =3D amdgpu_vm_flush(ring, job, need_pipe_sync);
>     230                 if (r) {
>     231                         amdgpu_ring_undo(ring);
> --> 232                         return r;
>
> The patch changed the other error paths to goto free_fence but this one
> was accidentally skipped.
>
>     233                 }
>     234         }
>     235
>     236         amdgpu_ring_ib_begin(ring);
>
>     ...
>
>     338
>     339 free_fence:
>     340         if (!job)
>     341                 kfree(af);
>     342         return r;
>     343 }
>
> Fixes: f903b85ed0f1 ("drm/amdgpu: fix possible fence leaks from job struc=
ture")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index 44f230d67da2..bfa64cd7a62d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -229,7 +229,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>                 r =3D amdgpu_vm_flush(ring, job, need_pipe_sync);
>                 if (r) {
>                         amdgpu_ring_undo(ring);
> -                       return r;
> +                       goto free_fence;
>                 }
>         }
>
> --
> 2.34.1
>
