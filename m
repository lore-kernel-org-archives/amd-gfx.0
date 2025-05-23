Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDC0C54ED0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 May 2025 01:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B44E10E059;
	Fri, 23 May 2025 01:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rv6vpHa+";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 344FF10E059
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 May 2025 01:41:34 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-231ba912ba1so8786165ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 18:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747964494; x=1748569294; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7aykBg3xec0L91zaz1r7hsU3qbDEpEJrcI+TRSqOuY=;
 b=Rv6vpHa+PTMwbE8mevkz8AhZPURpocgoF75Exwy3zQgmnUaaaQpW/1hNr/HpLj37sX
 OeUx7ceJTAYPXkQbu+nKU85Z6HwNc/kyfkZeMp7GehHg85P0yMTIAspKuIZxtnI1MQGX
 LuunUqRpr/9detltgne0562PuzFOmPFbfUlMhaH32+wi8yYji18IUmrNiUeASUhBevQf
 +d1gxmCTJNaQ840DZuGfOCv1GrGEwDa+0oyuO9+k8slKZnvxP8C4C0XlW9YbQue8r0UF
 wtfP0G4/vZFGtz+rhjAQgkVNMQExdpLcHlb7tqtqwvxP4gyg8VTpUWKb0h+LUWBF98DF
 6Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747964494; x=1748569294;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v7aykBg3xec0L91zaz1r7hsU3qbDEpEJrcI+TRSqOuY=;
 b=lVcG9sgWxVg+BHLKhc/VDcvca96nOwn01Q0zUqkUPdLOIkxTsKwRyI88AbTqg7uHeX
 I2fOA0KBo1mxI2UADZoF3rVRg4Kn5ZE2lTGoNGL1nO0oOKF2I6XOdVBEI60CQE8GKcq0
 dNhsq55P1eB/+4fOdxyXy1uge0etHLHJhUs0CzqOmxAJfcMs3WyrRVYB8fEzamenEWfE
 Ag7QOO01Up+wkBiScsUR1ja9C4zUnvSFgEKSo+Gd8dKGuv80eS7Ev7RpOh8QBt1ZX3/N
 ZpuzOJJ3xC+WB2eEtbUCPuE66MNwmsoxrh08nozo2zsuVVAbt7PLUEzdQLzGAX5AbPm7
 UY8w==
X-Gm-Message-State: AOJu0Yya6K7OCtV9whGj4Mhtpkmai8+ciAWUDvrxau2RZp/oFRueEI4r
 nC3Rfso/KwkTWcsdAANgasIP5xqVlxcT6MMp44xzeEnrzPhOG5KGwON4evLPbnqw9gaBLOAFZe2
 zNheMZtQz3qPcS07u2MMqnu+79ODigkI=
X-Gm-Gg: ASbGncuquoF3ysuoqTIxXYQnTvQ2pN5GqM57IncvApsa5kI1XDLQBIgz4ZnPtmEkfjR
 9o3iWPdZ5nKrwtfbD3VfBUl8f7da0qThnoge41v9u9y3X49MhOakS/kJhPnZH9MNOOyNTC6NX7o
 wX9GMV3O94kwiagpqkkq6wjYqC1+3pf3kZ+w==
X-Google-Smtp-Source: AGHT+IGhevvp1J+EsUSaJqmQBjlSaAIvRRoyvzjfbmO1g/0Jn+rlv2q1jrNjRTIHWi3zHaW/MkYTt1cup+p3TgOEut8=
X-Received: by 2002:a17:902:cf0a:b0:216:3dd1:5460 with SMTP id
 d9443c01a7336-233f36587cfmr3866635ad.2.1747964493549; Thu, 22 May 2025
 18:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250522215559.14677-1-alexander.deucher@amd.com>
 <20250522215559.14677-5-alexander.deucher@amd.com>
In-Reply-To: <20250522215559.14677-5-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 May 2025 21:41:22 -0400
X-Gm-Features: AX0GCFuygi6nl7Pa72bPJd1oKbkSvrVyUIi6CHtnnYBpZOOtg7hMFhvH3CFQyO8
Message-ID: <CADnq5_NsYL6fKLjvQ1it+oi9ZpzcCeq5TVv6RF_SZf4ZQs=Ucw@mail.gmail.com>
Subject: Re: [PATCH 04/10] drm/amdgpu: set the exec flag on the IB fence
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com
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

Ignore this patch.  I meant to drop it when I rebased these patches.
It's not necessary.

Alex

On Thu, May 22, 2025 at 5:56=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This is to make sure the CP executes this packet in
> the event of a preemption or reset.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index 802743efa3b39..d74bd6dffcbd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -274,7 +274,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned int num_ibs,
>         /* wrap the last IB with fence */
>         if (job && job->uf_addr) {
>                 amdgpu_ring_emit_fence(ring, job->uf_addr, job->uf_sequen=
ce,
> -                                      fence_flags | AMDGPU_FENCE_FLAG_64=
BIT);
> +                                      fence_flags | AMDGPU_FENCE_FLAG_64=
BIT |
> +                                      AMDGPU_FENCE_FLAG_EXEC);
>         }
>
>         if (ring->funcs->emit_gfx_shadow && ring->funcs->init_cond_exec) =
{
> --
> 2.49.0
>
