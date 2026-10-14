Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22792CC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 15:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DA810E19D;
	Wed, 14 Oct 2026 15:41:03 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC9FF10E19D
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 15:40:57 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-7ca232bbed3so65095137.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 08:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791992456; cv=none;
 d=google.com; s=arc-20260327;
 b=XFR+Zh3do20P1vaXPG4F74MZISTCSHXHvbpv6JFUBwJrX4p8pl3Qr3q0J+yQFQGOJE
 dd4H+Z3r5MvrtVw2TZ++/FRcyvLcJHSp0MNJK01AsdU7GF9qd7aH4nGP9j9T9AH4d+R1
 OWRC05JxvSsDbRJ4ivcHpqWDUzYv4VhAmvkZyKED/a1GSRXH/3H2QimyHmKLBy/Q2FD5
 Su4LFziBh+cLZLDRUolqhIkqiLPYx7JH9O+T4CmTBnuiZF81UYh/yDv37PdQq0vVqLUI
 Dq58+0SMgRIpFM/uol+1+oLjjYEHwoCcaXRj6FLsfGjvhbFAWCj0q0eO0+X/z+8Q4kxL
 /nVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DbKzH4i6zRAMVk8eEw5RFUvTFq2T+6ztKAjhHEjk4vM=;
 fh=ztqXYamQgkSPkPmBYbkvat+QPGL7YvgManDAUjofzak=;
 b=PctctSYsk/DoW6Ic4Jp45OYElO/+vRKmW4p/6nnyaytxnA7ERcKvou4HGOFvnkfQ8S
 //WgCRfE24c0ZZPRyLM2FI41d8j9AY3ZyGdvD/EBqVTx2XPFjvph8srBsRGTNxfSQQzR
 SXIY8//Qv7tU1HjOh6934dGoVUp5GHlIS/ZT+UWa+cXolzPv2nmOs21NbtxkT/2canc8
 GQhaC2vGtNweC3X6NUB9FCGXG7tUWyEQJ9G4ZPwXk5XLn9PwyHGY/o8ga4k7DeYUp8lx
 Dh0SjAYBD50W8S7h4YXga3XaD0ngc8fltDro+n6wkiU+kF+Q6TutS3BudmXE8wo16VCE
 bOmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791992456; x=1792597256; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DbKzH4i6zRAMVk8eEw5RFUvTFq2T+6ztKAjhHEjk4vM=;
 b=fNiBWGAWJ7MUtSuMFZF13AgBiuyxNxU4tJF5Y6gHKofoVJiEnXf9x8HK2BVKx43gjF
 zFOX2ChPQQ1S5+j3ivnkrp9hr5vbUQBGR8quEIenpenm36pQfht8d60pvYnHE5Bid7nh
 d31v67rkyXgcx+RX5L+D1whOvpMrXzNb1oQgLBFil4KV4vUnGRhpxuDNsoOe1DG9G+Ja
 ar4kBTj5T7myP9G+gNo0Xwa3Q5rvGi9DbiB/dfSQI+sPTWy+wEhsDJ00hMjMa19DKmIj
 Kaz0s3oyNyGdld+Jhieikk6MrEGVYcbDwQL87e32fCEUNdyoNsrVjaMsONx6mduw9Y3w
 yzKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791992456; x=1792597256;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DbKzH4i6zRAMVk8eEw5RFUvTFq2T+6ztKAjhHEjk4vM=;
 b=xRFCJtB6eAPZsdtTXvfG4huOyNR3IJmme1AIM2KtSDJ83wg8oJHeLjFTtQfuyqRUy1
 2P4WLTiY0WglPtJVdpN7dj0nvXVzGc0l9BWObyCaausFSpOM26I1bh8IhZe61XSLzYIY
 aGpAPw/Bu4f2Asj2yz9fubaLyu3t3SyntUp9a4GsdGaFaB7t9Bd5g482oXCAGDCc7ytB
 vpsulnnfOiWZ/0degbuk3GSneejN+ru8WRD86uqOehm3NTF+mWgoKt3f1J/wnvfxbZ7L
 orcktM7EY0KazkGzUMqx9xPTh6uzeBXNpmG+tIi/7HNMbnQnWuVtuP+e2+1wMRmdUDC3
 XpBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgK91gub74hqRaazZAGjACCQaSAnXePsdd3NY0BBJW+13c2VgEUFOVDWn/GECt65YWAlttz1Jb@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLlfaPx8LYW1Qj2WqXO0b11AWk6zXKtQS8Ue/hvEcxbZ7LHTN69
 icvZhlc8/8T3mNh2yb7vNjDJqUmSkPECBeTZetYcSsDKeLJPYFKu910wSeyQIFBF8PPfovCXXV/
 N5iGuXfQ7j0oG9F8wlg9OYj8C0ICfAQ8=
X-Gm-Gg: AYBFou0OiBb3OG7wQUN7PAVAorJxRbh7BSXTqlyOza5P2Ps5CWIaKaT91MufjSEAWRH
 eP3Wxf26FYq32PDCj7qrCjEPiSJzraA5fNhbK9FgBcw8AL+KiJJ5S+e4r80yQRUpxYweqJjvUQ5
 zujBIlFU2e3QIdpYrS6dXozHZ//Z7g/3uNEclISJDMov27KmR4cjf3pPykO3a1N4oOIJVnKcj8K
 jq/k6RqYeJG/PX49pNquulePqY1MEWFMDZrMg9xfzUiBJRDFeVCCHlg9xaK35g2UAe2UPjz9D9a
 70pTMb16Rw6X3NHqOatu8IqfrGwDaknsAr2GHq++LGlmJLTxoyh1bs4SnIJChYzofXB5JylGxM+
 ekRuid7FqZqWMlRI4vxWmNagJCJkeY1CzZTs0U8/WZg==
X-Received: by 2002:a05:6102:c07:b0:7b4:f1cd:80dd with SMTP id
 ada2fe7eead31-7cb3668aa3fmr4015389137.1.1791992456409; Wed, 14 Oct 2026
 08:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20261013140104.32179-1-omer.e.idrissi@gmail.com>
In-Reply-To: <20261013140104.32179-1-omer.e.idrissi@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 11:40:34 -0400
X-Gm-Features: AclHuK9I1qQZX4KcbB9N2WEIH08IUM_G0_q_Cb0vteRJPQ5eD7bXK10TL33mfvM
Message-ID: <CADnq5_N_c9OdhcTo_ByJM+w__hhu97=1m9zsR74crivKGiiauA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove unused tracepoint
To: Omer El Idrissi <omer.e.idrissi@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
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

On Wed, Oct 14, 2026 at 8:56=E2=80=AFAM Omer El Idrissi
<omer.e.idrissi@gmail.com> wrote:
>
> Remove unused tracepoint "amdgpu_reset_reg_dumps", flagged by UT=3D1,
> from amdgpu/amdgpu_trace.h
>
> Signed-off-by: Omer El Idrissi <omer.e.idrissi@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 16 ----------------
>  1 file changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_trace.h
> index fcd4cf2f4cd8..6fecee5be1ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -564,22 +564,6 @@ TRACE_EVENT(amdgpu_ib_pipe_sync,
>                       __get_str(ring), __entry->ctx, __entry->seqno)
>  );
>
> -TRACE_EVENT(amdgpu_reset_reg_dumps,
> -           TP_PROTO(uint32_t address, uint32_t value),
> -           TP_ARGS(address, value),
> -           TP_STRUCT__entry(
> -                            __field(uint32_t, address)
> -                            __field(uint32_t, value)
> -                            ),
> -           TP_fast_assign(
> -                          __entry->address =3D address;
> -                          __entry->value =3D value;
> -                          ),
> -           TP_printk("amdgpu register dump 0x%x: 0x%x",
> -                     __entry->address,
> -                     __entry->value)
> -);
> -
>  DECLARE_EVENT_CLASS(amdgpu_userq_queue,
>             TP_PROTO(struct amdgpu_usermode_queue *queue),
>             TP_ARGS(queue),
> --
> 2.53.0
>
