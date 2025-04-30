Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA589C369D9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 21:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88C0710E013;
	Wed, 30 Apr 2025 21:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mEGPLdLM";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9ECE10E013
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 21:21:09 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-73de140046eso62688b3a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 14:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746048069; x=1746652869; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dCtIEoqSgDyYIjoIu4tSLUAXWzMYb6kClJRKK4zaU8U=;
 b=mEGPLdLMUhbBT+un/1EAl0RHfYLGgrevYmugPbk2XTSj6NOMuU8arQkB2tlPsj2j6G
 ceZ52KGivatjMHMuArAwCJwPRkfLnOAAaWpdeuJ3R3aqSqLjwBLlB8Me9TjikPgvzmdK
 9sS9376t/l/RfslB45jf0UB4o/zpqvyz5QzHLJlSP+q3pydg3gqHd449PeSZ07WyvWIa
 g2a6qLquJBe7/663mG94UwNrIwnFMmyrzoTA04CUYPz/IN0IxSk1vq/KVvZKqYYy413Z
 RjGj5pSVtSfz/5mc9+KE9hatAFRIg/wEHfr/SxOJF1qvdut5HIm7FZ1kWTZ12WK45FWO
 dxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746048069; x=1746652869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCtIEoqSgDyYIjoIu4tSLUAXWzMYb6kClJRKK4zaU8U=;
 b=Yh3AlDASxi+cjyWBtsuMpjHiwhFd7ojEhPuL8UCuJ3QyJIZT4FSGGkfCyGldjVyUPs
 VhHOMjODs8uH1A8RHDlsROIHke71wLVO1V7pcBF63AHfl6pk/AdBTsUsmGIFPdiHjP+Y
 Qn/pVmJF03pE5A6OnsXHAla7PJ69zwHgMKXLHRBnywd2W38CR4pOJUVH7Zy4GX+w/G5p
 W3y4nKqsW6OD6O5L8L6Oqsl2LA17XSi/VJnRfmHAfqo1GkkM2oXo1jzIb72FexUZUIht
 ELEvYeWRWEM3j5miSHNZOSyKo0jtyyVVx0Ki2f8F7igKflm/BQRjQVhAJqumLfKf7coN
 NIgA==
X-Gm-Message-State: AOJu0YwumbgCEanaPrGrT89x4eKmwQ2Fh1UxIaWwwKxR8kVYHfOOYYwH
 CjBsX7RvvwD+vjnxvAoQZysMyst6sjQABJJn2/TMR7WGabxttuxOludBNRrNsJQF1RWuAajwvf+
 dccBVJ0CKZ69qe5oRnqa/VphHk60=
X-Gm-Gg: ASbGncvSdBgSZoLmL7GipB6LPORcNtY+ohnBcRaipu1VvGQV9bqV0oHPFXodfUErAW0
 fZx+JSbwmucf8PqqZvAIl5klZSWGK8f/60pFdHnsHaIpbJOaBXBEHvrY8mg3iHJR4uFhe6IQo3M
 UiB3K/zPApmw3VIL6Bz6PCHw==
X-Google-Smtp-Source: AGHT+IFE+mO6GqCa6/cWogO99bXLNfryNCzp8GblKEXxWJ9wdYvdzinmbUnDMP4Fjvls2cS74eGaaQP5uQi7VH4jMUc=
X-Received: by 2002:a17:90b:17c6:b0:304:eacf:8bba with SMTP id
 98e67ed59e1d1-30a34a77e55mr2312340a91.4.1746048069401; Wed, 30 Apr 2025
 14:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250429112429.5646-1-john.olender@gmail.com>
 <20250429112429.5646-2-john.olender@gmail.com>
In-Reply-To: <20250429112429.5646-2-john.olender@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Apr 2025 17:20:58 -0400
X-Gm-Features: ATxdqUGFeOzr53AA_I6nEUFJBs_qFF9K_ppnrQgR3pR5PGXeuWsDPueZt4te0jQ
Message-ID: <CADnq5_OMd-oHqPV9cC-GQGjf4OnN7EdvL3T9gopC-rEPMWs0vA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to
 total vram
To: John Olender <john.olender@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, arunpravin.paneerselvam@amd.com
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

+ Christian

On Tue, Apr 29, 2025 at 7:24=E2=80=AFAM John Olender <john.olender@gmail.co=
m> wrote:
>
> The drm_mm allocator tolerated being passed end > mm->size, but the
> drm_buddy allocator does not.
>
> Restore the pre-buddy-allocator behavior of allowing such placements.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
> Signed-off-by: John Olender <john.olender@gmail.com>

This looks correct to me.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_vram_mgr.c
> index 2d7f82e98df9..abdc52b0895a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -463,7 +463,7 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_ma=
nager *man,
>         int r;
>
>         lpfn =3D (u64)place->lpfn << PAGE_SHIFT;
> -       if (!lpfn)
> +       if (!lpfn || lpfn > man->size)
>                 lpfn =3D man->size;
>
>         fpfn =3D (u64)place->fpfn << PAGE_SHIFT;
> --
> 2.47.2
>
