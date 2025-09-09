Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4A5CAC583
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 15:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0485E10E74E;
	Tue,  9 Sep 2025 15:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ss+9/4+U";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79EF10E74E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 15:28:27 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-77263a06618so609140b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757431707; x=1758036507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWN8o4JYLZDtj29JTp4WHj2Vaw0XWspwLe074fN+V50=;
 b=Ss+9/4+UX/6jPpRuXWXgsCD376MaaD35c79zkr3x+8UglLI5PZ03BdLBZBcJ03q8Ob
 +/jLH1i3SnLW09HUasCD8z6RldWjYEYaj3A1IRyxnrpKp2QUgZbgN8ir3UAMmaNxUsyb
 T6XeTXfDUgB19oaqUJcBOBAsKQsybCb2AN2q4BeH4Au2qu7/5NopCASsQrthKC3Attgf
 IgqIlQCZ4ThzMMtlQXlTXqNSQHKTUeBJcC247mHm1RKFJ8f1goWPtgfLV1aqhqF7326m
 /LYzrm/6fGOPOkR2NQc1FgroB14Rlz8fZoSgxKE2PlEUG+ttuUu66n3/sD2EtCq6eY4D
 /YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757431707; x=1758036507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWN8o4JYLZDtj29JTp4WHj2Vaw0XWspwLe074fN+V50=;
 b=QgP/S2LnCuBjzHSkNy6FqvgE/WFTtxyvDAHrbk2XVCoI5MM4LxHZ6R0iWIhmrXJIa3
 2aWvMq6wq6IMYSL8NMBILOy4kGQwXSWBR6thBZeL/kbfPNjWeQ+TSpjXnKAnoZRAMFZg
 W3MXCnJShfZptpRAB9NF+9yH4cO41iRWos+BCKsXxs6prg17BTR4sTWE0v0RcdgQCNeT
 oR6Nnprda/AEMPUOZFIyDepFy2cod6mAtKnXW2squOyNlUCgcgDNY49VgHkkeqRPX2c7
 PA08UoGFxZZoS0yUMhlel4HCSo/3q6kfqIt1HdnW6TobUWe7bSjLVTdhfjCjGImsaTif
 6oMA==
X-Gm-Message-State: AOJu0YyCtODSyv0+lvDZ8XpzpJZTCPIW8JjL/xydcoFN1md8ETlO8HYk
 F6Z3GPD/gjrZ9JfQwhngC7RhxCpfzhrZBWRis0Fnu3QmZlLmakpqqB/lVq0LN6N9qAvnDKs2u+T
 /K9ykoX0sVeyZlLAs+uXpH3u/jgu0+tc=
X-Gm-Gg: ASbGncvzOzE6x+09y/KCE46Bwec4lmx9c3e/sOtLpFcPcARqLEm0aw89gaxb8/F4SOK
 I08YOfXEQvtrRMa/iBh+QEnXh8z8OzpyKNd3aBn98zMtSgHu3kgQOqzMXjhS+XzNIaE62UrJgU6
 DawYZ3aGo8aVjzSqbfR6N2ApGGChjqz/Rv4jS/+5ABh2y5EqHwCUMSlLXYYwKA6byCDkiNtAdrM
 e0ist1s33eRvsG/MA==
X-Google-Smtp-Source: AGHT+IE5c8pYU1i+ckQd+Q/olhdwafJRGWyLY2vaC5Ky4GGlm4DRCkH6tDEcpPM4IMRiRgN+iJoIISUOPhxzv9kO+4Q=
X-Received: by 2002:a17:902:e952:b0:252:3606:ce05 with SMTP id
 d9443c01a7336-2523606d0d3mr87158305ad.6.1757431707011; Tue, 09 Sep 2025
 08:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250909144937.22452-1-timur.kristof@gmail.com>
 <20250909144937.22452-3-timur.kristof@gmail.com>
In-Reply-To: <20250909144937.22452-3-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 11:28:13 -0400
X-Gm-Features: Ac12FXzh2v87eeWpzdEeK7eY8wyyFO9l52s-yjXIrwsbXxWm7ckJzjEM6lkk7e4
Message-ID: <CADnq5_PD+=xf8h-foHTmJJKPy_2MNm=Q7yZsdDR7k18CPat-RA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Use memset32 for ring clearing
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
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

Applied patches 1 and 3.

Thanks,

Alex

On Tue, Sep 9, 2025 at 10:49=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Use memset32 instead of open coding it, just because it is
> a tiny bit nicer.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 12783ea3ba0f..20133ff43af3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -481,10 +481,7 @@ static inline void amdgpu_ring_set_preempt_cond_exec=
(struct amdgpu_ring *ring,
>
>  static inline void amdgpu_ring_clear_ring(struct amdgpu_ring *ring)
>  {
> -       int i =3D 0;
> -       while (i <=3D ring->buf_mask)
> -               ring->ring[i++] =3D ring->funcs->nop;
> -
> +       memset32(ring->ring, ring->funcs->nop, ring->buf_mask + 1);
>  }
>
>  static inline void amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t =
v)
> --
> 2.51.0
>
