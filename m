Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37133CA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 15:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A696D10E1E6;
	Mon, 18 Aug 2025 15:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mz5rYjqG";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9550C10E1E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 15:14:32 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-24498e93b8fso688445ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755530072; x=1756134872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBNMYuZoJFbgAewKamk69Z4Nk7xeSBiFAMZMBDWd7WM=;
 b=Mz5rYjqGXLlnU6hlde+n05x8/bbQaKkC1qwI735LrLysxEt9dugE/hrwxvDgMszy3M
 KXmnRyb9OAI9oZnmoCT9xseoNkHqoKf2vsJbJAELuqXsWQXa+A7K4znhYlDvWDlqYyWm
 4J2vymtdXhkLmRPKte8xjgxrSky1gy3o9ib0WkH6QnR3rK+NanjqULt6BEPKJNxIQOwz
 m5joE/HT/k/0/rbqms1PU1iBl49J41WY5u+RdT4j+nFVCFJbaL4ZhIBQ4op7hGkhND6k
 70vLwBieS0SXb4Ietb1Jj8kymX+bSxBmtj/49i6VlC+xbLZWFRQwN5zmBia5BSkgpq9s
 iHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755530072; x=1756134872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBNMYuZoJFbgAewKamk69Z4Nk7xeSBiFAMZMBDWd7WM=;
 b=PsUFIXdrWo19HEvNQjhLlUJwAn6TLurH9N6GJqH/uqWGWQMbyv4YQmyPW8BI4dAgeg
 bMjE0StF9uK+zOXyKl5EHk9ZEsDNS5JGCsef4HA7brjYGeHzggbhXF2vyQxAq3Z3WXdp
 aYXIe6gKy44fVJH08rBq/l1p7bcWQYegRGcm2uqwhTJzzLRJYheF7bXXJ1Frx6CYcCPf
 PfWd/sDbI4XzdOVlXPypxfQ5jaOsX/nsQGcp4lgAFPMuLacvbqGNb67bcha8Vl0s/DPD
 3bG2FgrP4fkrG3c1XnLCEldUMwTtwNVEhijnp0HDtD3P7Vdn2PtWlqSdi5rx2S6R340k
 rQeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcyCt1BzpRPOZi8sHb07OMOuKlhkBoNOxkkIAOKwI1eHw1NNK3N2HOp5mMsnXu6ib0M3G3tdeF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySq4pMySkSGv1YpQNG+CM0t2FtkMUedIaN8izs41W1yeGd8E49
 JqQ1mi9ZtI9MHfrep+ubABytz/o9g60DLigYca1AXKDDOyUk82wUJ3IhVgwBnmrR6KsFfGqCiek
 6Dlow/vz/ncVgKBwkcJB6JKhwZaEjW1I=
X-Gm-Gg: ASbGncvYKiWcyeGMfFHMryOo/MCqnXWtqkbgePIneKU/RgQ5Sb3SRoUEuQx6KsM8jZx
 kTePwFE3jonidXQaAgdDyQXM97NGHeJ379MYyjnH9I2ef+QJ+WzRm3YUZ9QxxuxZ82OWoUbS/Jh
 tBSEkXKc4pBJuXq89RzSZDlH5UYty7AcvY3iMpeJeDbnKxMk8foMADfJnNJJsjYPD0ZD9tVyZYM
 R9juv/TV2i5pjaEDA==
X-Google-Smtp-Source: AGHT+IG70EVIpFGW77+UJEZUs65tGnTJk7A7GBgxoOiVU9CUbfeThU2VvvoSWUf+sszfEa2bVuWr3ZsvsY7nNL0668s=
X-Received: by 2002:a17:903:2311:b0:240:63bd:2701 with SMTP id
 d9443c01a7336-2446d888aa6mr96882055ad.6.1755530072040; Mon, 18 Aug 2025
 08:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250816162806.1301791-1-siqueira@igalia.com>
 <20250816162806.1301791-3-siqueira@igalia.com>
In-Reply-To: <20250816162806.1301791-3-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 11:14:20 -0400
X-Gm-Features: Ac12FXwsvZ5KWFrhLlmujtqd-PAFNnSXLWlRuxsFjkiPdq8jVWsF2LCPJV3pHSQ
Message-ID: <CADnq5_OfLpc4=Pune97GL9Jk1qGHhkKJQJsLFewDAqjHBjUk1g@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amdgpu/vcn: Remove unnecessary check
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 James Zhu <James.Zhu@amd.com>, Jesse Zhang <jesse.zhang@amd.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com
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

On Sat, Aug 16, 2025 at 12:28=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.=
com> wrote:
>
> The function amdgpu_vcn_sysfs_reset_mask_init already returns 0, which
> makes the check of the result unnecessary in the vcn_v4_0_3_sw_init().
> Just return the amdgpu_vcn_sysfs_reset_mask_init directly.
>
> Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_3.c
> index 018a526a8801..168c394deeba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -242,11 +242,7 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         if (r)
>                 return r;
>
> -       r =3D amdgpu_vcn_sysfs_reset_mask_init(adev);
> -       if (r)
> -               return r;
> -
> -       return 0;
> +       return amdgpu_vcn_sysfs_reset_mask_init(adev);
>  }
>
>  /**
> --
> 2.47.2
>
