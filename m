Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC44ACA1013
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 20:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EB8C10E8F9;
	Thu, 18 Sep 2025 20:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KC2Rq3+b";
	dkim-atps=neutral
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com
 [209.85.215.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D63210E8F9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 20:34:22 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id
 41be03b00d2f7-b54deb8508eso52416a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758227662; x=1758832462; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pJO6D91Yaxwfneqcoreh9cmZORLD8JSvOfOeKUfeTXs=;
 b=KC2Rq3+bHgDHSypODuC2IWW12YQEAJMWWRLwd9wqgqAIvGGUCOl04WMOGTXjIXr643
 T1hOenfmIl4bAEAWflkDWa/Yb8B0Dolv9uh2+Bq+xZoGwEWjgEL1VRI6grD4tPyIaEO+
 blxUVGYer33Zho/msaR3bqBSUTCljK1okM8aHbBeJD3Hfk6w3B1ux/5LkPeIbB3KNumU
 AEQitANaGJAQYXrHgItXhKlZMUJz+ZZ6ueMpxx9V9tCPQvpRUGpGQTEP4565vkpnHTUw
 CO7aRTR5jLDbhqDNnrqyK0906K5/+GN2FcGCsS+Q7bDtKqjeGDYJMoaoDKyXjiQ4o6UL
 s//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758227662; x=1758832462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJO6D91Yaxwfneqcoreh9cmZORLD8JSvOfOeKUfeTXs=;
 b=c91SKfmZZ9gG1DyE1N30/FVzWK11LjkY1/t3JWCwUJ1zXCrmT5QYz7GtQJBjrj8cJF
 yGvnEVJGLoSCs7pP5TIXK5x7L2ShkjGwEkLsIK3aecwbPXNzIbV1JupCOgoHskgK22fo
 St2qh1cdiRLNaU4eLjs+OObCCb+RFdhwxDw25O5goAreVYS2fwe0L+l+FVM6RqkMykAQ
 kekFRMuL591blxiaS3TExSHNmNrwbYjolct6TJWTYNp5D1rxZU8FYBq+yV7Sgn3yf0zU
 bA+BJ9fDGfc6WBI+1u/nu1jSbObkVIMNyKjg7Y6pZclWeNICKqPFfNtuQ2lDL9kzsdzV
 T6oA==
X-Gm-Message-State: AOJu0Yw7ctHV/Agqi71Dvy6UYUAmMbvwex7kQCrMfCsqMyuD7u7bC7mi
 CZvWYOwfjEjjYgpkKiTCzXTVaQXiC0e+95fBMLal4fCQ9syMb94bPd5s/b5HkUSM3MeRFHY9lPX
 dSe6YoB/jBu6u32iMk2hdU7TQus7M1Co=
X-Gm-Gg: ASbGnct+Q8ouT0Mxom83cl9DaQ4ZzXm4Y3fM6NA0DqzftvlAg3KR9tlJ8AoWlkNTXhX
 oYKRHYOknhhfX5WZpHBdMXE9vRo6m9i5WnYwEJKIfl0R8+b2kBqt9DvHE1DqZB/mQdESPBAj6M0
 eU8GYnlen1lXGwx5pgjkDSRiIdzuq4tXTqk1iZuyyZbUKl+so4iJMqYLRvnt9LSs9nhhUFxT4VO
 DgZGmdX7A21wmt6C/i6GKhXzg==
X-Google-Smtp-Source: AGHT+IGqMj5MbQ/sJLpIArHr7MSRLkYt1rWzeYmTaDNCYG5jW8exmWNW0kkwFgbOEdkdJ46XgNEmqtXnsWj9xj7jHqQ=
X-Received: by 2002:a17:90b:4c88:b0:32e:4924:68f8 with SMTP id
 98e67ed59e1d1-33097ff4c7bmr468214a91.2.1758227661759; Thu, 18 Sep 2025
 13:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250918081815.2755437-1-Prike.Liang@amd.com>
 <20250918081815.2755437-5-Prike.Liang@amd.com>
In-Reply-To: <20250918081815.2755437-5-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 Sep 2025 16:34:09 -0400
X-Gm-Features: AS18NWCbUB98mUe3LxzxDXGmnodd7hTrPGYKoKyeNk3ZSKRHuoX2j_nkQLQfabY
Message-ID: <CADnq5_Njw1VXqpMwafgHsAg09dQVtz1gsNu0tB46qc0i4tWT8g@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] drm/amdgpu: add userq invalid VA query
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Thu, Sep 18, 2025 at 4:29=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Add the userq invalid VA query interface.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 83f0ecdaa0b7..3b57352e523a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -577,6 +577,8 @@ amdgpu_userq_query_status(struct drm_file *filp, unio=
n drm_amdgpu_userq *args)
>         if (queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->vm)=
)
>                 args->out_qs.flags |=3D AMDGPU_USERQ_QUERY_STATUS_FLAGS_V=
RAMLOST;
>
> +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_INVALID_VA)
> +               args->out_qs.flags |=3D AMDGPU_USERQ_QUERY_STATUS_FLAGS_I=
NVALID_VA;
>         mutex_unlock(&uq_mgr->userq_mutex);
>
>         return 0;
> --
> 2.34.1
>
