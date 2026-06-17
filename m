Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88640CD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 14:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2BD10EA48;
	Wed, 17 Jun 2026 14:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iLbwZgiG";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F6110EA48
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 14:12:27 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-137e836ccc8so399102c88.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 07:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781705546; cv=none;
 d=google.com; s=arc-20240605;
 b=NqK6g8avQ6PztL/zLkU/+EEtj1DS7TSig/KhuKY6fkrhwlq1A4mP72wVahS69XvIuE
 /sSedBppHJ3ej6etJ1OfDUTDAH1bpK9xN8nJM2nYQDyN2FhikkXMGjEgv6KA2a0nONXn
 Em+2tn+zlD49EcoK1pn1Op0P0NvBWh9cJHAhG6PXKCimt6q+4FXckz3z85DZ3z5NeiAA
 quVGZao0Qhz4JFHbPvWFp2bxhMD6CNO6FhfsBK6oXo16RzUU9dZ9/Myz/DUxPoBhKF19
 Iht3mmworYtEs94s6pulbRY2XjrJfGLxodPHeULs56fR4EQbgBqFzQBeXrS43Z7+X7p2
 xaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1kjTu2DufNhbme/iNHYhKVdb66u/pn74Nr3TS+YKtBI=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=OysibNBs61sZlEXupS/noZBpq4cps6tZUx2Gu154+wPL2Iak9jrPdENIYF7bm96aOT
 1Bqy5P8I/POI+ia7Ms9vh9oWS+1wMNuyoCFcbcNppTmJQOYOi35pYk6iStMQEmQ7+KE2
 3tfTL7TAWzzboGwr4iS9L88uyrjir5p1i+VsWNAp3xIM0k9LDEt39+SJrAdPtWMVd0ku
 ZoBCZxvPGSbylyx9j9DXCOJF0HFagkMaPV/18YnJ1ZKbQvHkSzs2yUzYzu5D/+fTgDSo
 05iu9wpeccH4DWFy6F2ArKt/QyJwy3so/dMAlInBuhvT9eBFsBN0Abox3TGsLXgGYEzU
 Tz7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781705546; x=1782310346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kjTu2DufNhbme/iNHYhKVdb66u/pn74Nr3TS+YKtBI=;
 b=iLbwZgiGC5M53cmesl5h4aaBWowhiPpkUQO5LErb9iiwMVbHBdEuMaN6ubcy8DEwL/
 t6p+aYujsR1+G4YvwEIKGXT+aR+CH+hDz78ZN2IHY/5rROCbBpwZD2cfWNKRBrg7ncdv
 XYgoMSANVggbmMVpuQvYJk0OdZ22gG4gq68uA3anu+hYPyoS9Sf22GJ0UT2CemGigg/R
 T0pCLRCkhtfl2qZ/QIBGBW3mj+jkS/uTm7HN/WJ5FaWU4w7rt/EUZLGts7gvQ6CmBmmi
 an0Nxc4sqyudC8DwIy4GujOVNKILOi6n+q/Jxgcj/HZdoEdA/7HjvmODA1SJ5/O57SkO
 /EGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781705546; x=1782310346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1kjTu2DufNhbme/iNHYhKVdb66u/pn74Nr3TS+YKtBI=;
 b=KOqRUsyNuv7oi+DymT+Fb+8M1oFyXQhfbUPaWGJPWD5nYw2aFOdFzOzS00SRA3v73x
 kJP6VYAzNDrZp+GFFBkVCt5dWRpTI0zEfB0redIf+j3B2A5eFuNr0pBpL39OU68ID+hf
 jvbjAEA+kJRNrUkujrwRjmYeQ92jLQUU6SiNZotva+UAMAiI3cQlSRWpjNpdmQK+3cnK
 cVE/C4PtAITEM4PU1Nx33jRcJfAsMCokLO1JYSoTN5OUf+g+ig6zab0yR5w15OS7c7DQ
 Xs+7/ucvFL9EN7WD3WEtiRDGIYi6n9ghp8tGMwGG7MTx4YRcPijQUlbLqAd7iStqCgwx
 K/4A==
X-Gm-Message-State: AOJu0Yx2/5YzyGumA0upJYua2xqtvgdyXyQZktDw9Poihd+LP/jnHIDa
 V1A7sdnsA2Nu1xzkNvvTu0ynPbvBvjNP1N7VufdzztIAbskjVRh0M8s3RIxZF07ubI/JZqpaFap
 XQZa+4EFr5MY/hYoaWKUZhB13PD3ZRAU=
X-Gm-Gg: Acq92OH6tgsyuzBAbOfZO3pxIxV6T78CaolMs1wTw8dNVaxjbEphs40vXhyDzuZ/Fdh
 4O5eTi5kPA7HIQ6Xe98WV8IJKu2oPHREHZUQsJOy0SKCbN5jV1q8pJUAEg64Za9Yx7FrNuc++j0
 d3ENKma4KkSxdXyJxx3a5faS4XjLfMgo5X6lMfkhwJjRtgibUKBUKRUanJ9GoNc3cYDxQtB6rZQ
 tM/kxrEYfiujK5or1fqZDj6FCGuK/G0q07KfgtTp4l7f+fgrkg44/qYgsepz/WfyQRlnyQx5avc
 Hz31sKwS0FBz4kDmEHYNcFyrGNrePRaYnmVO+Djqu2nV9EVyhhsWJanGyuzNGP5NAA3YbQ==
X-Received: by 2002:a05:701b:4550:10b0:139:90ab:36ac with SMTP id
 a92af1059eb24-13990ab3962mr362738c88.7.1781705545839; Wed, 17 Jun 2026
 07:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260615235645.737189-1-alexander.deucher@amd.com>
In-Reply-To: <20260615235645.737189-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jun 2026 10:12:11 -0400
X-Gm-Features: AVVi8CfTKw5pUy_sRdHM7uodPVNXTlxvPcvbBHXPm-eG27poy3Yjh0W9EKRF4-s
Message-ID: <CADnq5_NnQbH_poF4L-8PLD6unByMV6DLT_oyWwggGVTzetJs1A@mail.gmail.com>
Subject: Re: [PATCH 01/43] drm/amdgpu/gfx8: replace BUG_ON() with WARN_ON()
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping on this series?

On Mon, Jun 15, 2026 at 8:34=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> There's no need to crash the kernel for these cases.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 130196859ff3f..70ba81e6b4d43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -6256,9 +6256,6 @@ static void gfx_v8_0_ring_emit_fence_compute(struct=
 amdgpu_ring *ring,
>  static void gfx_v8_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 a=
ddr,
>                                          u64 seq, unsigned int flags)
>  {
> -       /* we only allocate 32bit for each seq wb address */
> -       BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> -
>         /* write fence seq to the "addr" */
>         amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
>         amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
> --
> 2.54.0
>
