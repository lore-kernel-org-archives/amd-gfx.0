Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1216C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71A5910EAC2;
	Mon,  6 Jul 2026 20:32:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nP7byTzy";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8703B10EAC2
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:32:44 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2caa0551d8bso10632835ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2026 13:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783369964; cv=none;
 d=google.com; s=arc-20260327;
 b=sOFGwc1bwQ44AuBvUzF8FSDBovTW8EORWMVEnp2bXKaq/D3hF4ucE50XOsHopaOFIT
 UZP9bZ7gImb5eDXwgEOUJuz6w2Gcvv+MkfyCZ8cfbFsLB3hJ3uwYwEC3inOTzzCubbDT
 QORQOs+S5Z0avvvIT6Qi4DBRJxXnJzdeFzm/BHipiOH+o/9j8MBCLrqchqOan1YZ7tYq
 ywhc+RLAldAoshyWzYHJyh4hKC+FGqvhjAk72/nN2ElBPfm0jtMlSp76bZXbWxsxxHxf
 PT1BFSkAL2KttYOyo40yw1tLYboxS3wvTTyELbaw1yXnIqNrZaw3LJFcvQLkRplbWV45
 zzYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9BAoSMEaYfdIAvP0FbX8iEgcDanH+P5Fz/F0K/lKlaY=;
 fh=g1/2dWnfO5+U9t8BX7P3iZGb5EynlWa2cbhVqI2lqXM=;
 b=oUalEtVZSxggVsVMTNe/4l0q4FhRO8bQmyhc2jSJ1OlE+c+MtY6EcdjYamrEOWdCro
 QJLl9zL3AhzqE4r/oMcnNqHykrCx4K/4Cz6wqxHFrU5I/NZYzwGiqqP3HHi5eEbstt26
 D4eEGWYQTJKNqHmyhDoMBygws8DuA23prJlAnlOJkjYIjC7FZS76ineCGNkF6WfhmVj7
 GeGrTO+urXX1JK/8ZVI8XL6f6WfY4p5awEN0asV9fyaGInr2IKo28eG5jNEuMkWauIkh
 d165SPjzFjSC/u+6glBawuVsnyxsGAdxole2D4IMl/bQXYluigrLN2ABVpssvpN4b1iV
 Xhfg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783369964; x=1783974764; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9BAoSMEaYfdIAvP0FbX8iEgcDanH+P5Fz/F0K/lKlaY=;
 b=nP7byTzyn2OiTIVB7Iw7jraSa7R7gkd/WqzCZ/yphnd6bHtEDRsHQcwfs+t6WAqU8Y
 Oqi64lz5ba2Z7Xh4gpFFzJevN+ouxPLQF4uca4VpRgH+qXWzjuHgEFUZzJhAyMzcYxz+
 XdtUc4NQs6wIovJXLyQbu6KcK8omtF/M5QO5xDAIwLbHlmYMCGi7LDXGJo+BedYgHOAf
 Z43PaYDSENOYWrlpxTVodR+q4VqFiNNJatwtkAN+okKUSg66nlEA1t5Xm+NQQb4LIm0m
 J4RIKMWNCGGxfFf8XTszdhdaO8X1OeqQIrAxMlgt7nw75Jxy+ICl0tS6MhN/dPlMf5R1
 E6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783369964; x=1783974764;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9BAoSMEaYfdIAvP0FbX8iEgcDanH+P5Fz/F0K/lKlaY=;
 b=khDIMU7OxT4l7S+So/iYzKSXz5cyJGMulC6ZB4x6vyT+CshToS2XbDL3V6fnDo/d3Q
 LLzGD765mn+XmCLTuqFi/cp7yq4wXwqrL+rxkexzoWTcjFvjtxsFImUFQAv0TOBbwnCY
 i4JRFiQvu2vX3Kgyx9YSMBpm/itsbCKNsdtDe0Q/XFnqZOZ/3LnMGApHN4lF1/QUF1n5
 PTDJtSlf9IsSk3WN5neD22UmjFCqZGp/nBtgGDyUM9IGkjCaLGfOPv363uOCfTynSsP+
 /9AW/PIrbkFtvXDyX/VRLuzcMhUsX1Cs3CTO8KhurgsRF2jGdthQJsfOwAKZXgrBejML
 ChwA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLnU0dV+k/8Ce4ENodW8CjzMwLUAV3XM+H9T9P/0Hc+OKgLZqhAUb92OVLD2EsrSP/dFXO9lsR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzUsllKdJW6sBXY5uIIh7Hiyr2PNdMg+qN/qSDd7kpvLdx3mHId
 1CuY+1Tq+oV4l8DEtNHavchfUxdY6Y0vVPot7Xw4be2JsHqJdeluBtw/MH98TdabCi4cqKIBrx0
 WTdBOdFm5C4xWlDeuSZLQ0YsCsYK8s5pCGWh+
X-Gm-Gg: AfdE7clJBqot8MxIsQPnq9Il0isBCpuLIGp3Zv6/oT9+n7qZwK2ytB9WfaYUwpz9HOg
 Z3/chA24UvqmVBZ513b6luYyPhX/TftnyhrfIJ+NIiU+RhDJ/GKysCwyIihfT/Jfd8t6ZFI9Ymp
 C2+HKOy8FJY4J/BCFM6SWxm0bCQ7H6vdd2LxUEWJDmpVgAAOIanhZ3ngtamrtpv5CZ9F3O2sfyg
 nwIZZgNv5tGdJ1M/0Qy4b/X9XeZ5QFIbZ7stiYm6JgIGO4rQz8pV5yleZp8NELuYi9fRaIxCq13
 43CFcOAkZh1ROYPUAEQMaoLhqjPQJPkMwJ3Lnzn3pAYAZ0pAUn/vSIfR42U=
X-Received: by 2002:a17:903:1208:b0:2ca:e134:9e6d with SMTP id
 d9443c01a7336-2cbb9f1f9b6mr74359595ad.8.1783369963946; Mon, 06 Jul 2026
 13:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260611143326.2870571-1-srinivasan.shanmugam@amd.com>
 <20260611143326.2870571-4-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260611143326.2870571-4-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jul 2026 16:32:32 -0400
X-Gm-Features: AVVi8CfZXaBwmCkBlYBEFZNU-88qj5AlYP2Hp0g19SC3Xq56Tzj1kWDMV9UVY8Q
Message-ID: <CADnq5_O9OrTGxscHdsAPjoG__d0y3ksbkLks12201_Ow+miHEw@mail.gmail.com>
Subject: Re: [PATCH v12 3/5] drm/amdgpu: Add helper to access the fpriv
 eventfd manager
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Jun 11, 2026 at 10:44=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Provide a helper to retrieve the per-file eventfd manager associated
> with a user queue manager.
>
> The helper resolves the eventfd manager through the existing drm_file ->
> driver_priv link instead of storing an additional eventfd manager
> pointer inside amdgpu_userq_mgr.
>
> This keeps the ownership model unchanged and avoids maintaining
> duplicate references between USERQ and EVENTFD state.
>
> v10: (per Christian)
> - Remove the extra eventfd_mgr pointer from userq_mgr.
> - Use the existing drm_file link to access the eventfd manager when
>   needed.
>
> v11:
> - Replace defensive NULL checks with WARN_ON() for conditions that
>   should never occur. (Christian)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 ++
>  2 files changed, 21 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 99c711ddf71e..427c09c83d6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -34,6 +34,25 @@
>  #include "amdgpu_hmm.h"
>  #include "amdgpu_userq_fence.h"
>
> +/*
> + * Get the per-file eventfd manager associated with this userq manager.
> + */
> +struct amdgpu_eventfd_mgr *
> +amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +       struct amdgpu_fpriv *fpriv;
> +
> +       if (WARN_ON(!userq_mgr || !userq_mgr->file))
> +               return NULL;
> +
> +       fpriv =3D userq_mgr->file->driver_priv;
> +
> +       if (WARN_ON(!fpriv))
> +               return NULL;
> +
> +       return &fpriv->eventfd_mgr;
> +}
> +
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
>  {
>         int i;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index d1751febaefe..8c4b55517a0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -183,4 +183,6 @@ int amdgpu_userq_input_va_validate(struct amdgpu_devi=
ce *adev,
>
>  void amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>                                         struct amdgpu_bo_va_mapping *mapp=
ing);
> +struct amdgpu_eventfd_mgr *
> +amdgpu_userq_eventfd_mgr(struct amdgpu_userq_mgr *userq_mgr);
>  #endif
> --
> 2.34.1
>
