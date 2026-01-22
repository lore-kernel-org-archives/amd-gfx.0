Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA02D6CFA3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 19:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449A310EA7B;
	Thu, 22 Jan 2026 19:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jGTL2nvB";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B70D10EA7B
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 19:52:52 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2b71e7dab12so123430eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 11:52:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769111572; cv=none;
 d=google.com; s=arc-20240605;
 b=aVdK/qsBOXTd2dtAjiQg7ktZzKz2t/RAfBqgqRQPzfDDXgXaUU0Fkh5DYj3JbfB/qM
 SQO6AOY3Pqr/PWbdvPlQgWP1ZvyTUFGePa0SDeTvnc0V+H/1UQX8VQqTZU4f1hcfC950
 eGoFPKD+Sf5e/maORp0NK1PRZO21KXh5IKmWp6bcA1CZMuhQtZnCfjc4ASkrD0o5Oefs
 5KknSmXxod2u6Te/o05kzUePGEDy4VI3x5y62jnG2JiquIp4YOEsDL22iJcWHJJpJEf7
 cTfusIue4AYJ651VXbiLoUFxw+wZ9oVL3bmX+KGeXJ1znZ71FNInB5Nge5eu3oqXORlu
 Hq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xaMFit0Tb4xJygbdiK4hkfzlD0N/rHzeqbTVXcn+6qI=;
 fh=hqFcqVI5QaCMUuPdkHn0ojxE6JSVSSdOK4B6oQVTPxI=;
 b=JjHXmoaUwYRUpUVEWpaA1mcyrIfYFebzLbnZqlNe3GmOh351WgDoJbi8+NTruvYU+0
 0pupf/A1it5omATbujHoZXmjSoPezdF6j4YsbXRjFTQtQkX2IwHJNsvGzGGSZsdwCVhh
 wElsbbLElf/FeEWcpp61GwLWVrw0luy3W8rxKxoy0uhFJEfW2MGeihGejjD/cTTqkJBV
 c4u/3vEB8nD8P1gm90GpN6+ZKwXOmY0TLUW0YbEUxnKEDEtPMj7hZg5eLOIrgm8c96dE
 42VcYKbhwLF86TZyM6xxUvn5mgADgfvJ9lcMEq34DpQu5IWRMcG5uUFpvsCTK5NM5Ocs
 CEfQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769111572; x=1769716372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xaMFit0Tb4xJygbdiK4hkfzlD0N/rHzeqbTVXcn+6qI=;
 b=jGTL2nvBpYQWJYvmUqRjldhm2mC+el5cGK30oUOIozQr8Lev9UPQNCt6tHDAQXUyeX
 wSU85Izm0Fjxz9V8NkI3I61e4cFML8dNdn0MbhJF8lgzcUxqMLA/ttQn7PRlbJPDH0A7
 0AGsyv0iKetZ9SVGHW0ay7DnC6uXZTarXNOl8zJCcMvTXRgsJGGoNgoihOMBxjVUnnQI
 9jS2JUP+qVrwy25NJkG5qGHalyTyNFouow1BiElDgwsVaoAXDPeXofuPOlMcIAq8G3iy
 l5gyQ32SWTHubwVQNmRyMP06IJYtc7cRCTzdJ2NjyFSJ8DMAKo+hTbIxo4L/o4ivghF4
 hqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769111572; x=1769716372;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xaMFit0Tb4xJygbdiK4hkfzlD0N/rHzeqbTVXcn+6qI=;
 b=vC9lTdA1LFtQpZvdNorRaGeS9P2lQiHGY0yct9RWiwFWanOG26TDbEKjJ8aMze0/jF
 xmGTFvCNHLBQRk2yI0b9XmRowQIab9pB9ZcWxjWMrcgfc9Gwl9xBRc6RgRLwgyAq8d0U
 Jfap1+6TbX6nAZh7ln5d+3P6cmUsIv7rwkm2uJ4cNeXc+2gof6/oD3m1ISdu/Yzda5Hn
 9a1Me5kC41W2K1jgAEYsGjiLiVpnBeDPETozbfjLVvhhHlY6ghd8b6j4oowPIVf/iQsn
 +TSko6GDhiTPH40DmF/HV1q5ynCq2rLAk/wmURi/UAJgUAKIJ5KBebgat++maFNcYus3
 BwfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRP+yLYtfY/tqWQglrmYckIUu4xgofnWWNOXRzSboQzaWTtmYKlbdPPnQbiNbUG/QHW+eF/K20@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxPx8ANvdHYmDcMz85GalHB1bMr4R1I7FQZdOYVpP2u7eTYMWA2
 lTxgUgxMOc6AuI4VbyTkcQXb+s6oHUidEm66786VCQMGDy+5uebwHpeNS/Et0iknu851DUO5SIY
 NVM0qFdXBsxx1WX3rXbyrTsO7mncou/A=
X-Gm-Gg: AZuq6aJz14eFDnqk9PTvb0BBSjY4owRGj3I8FXcbC07+t2MJwSKyc7vE2oZLJ69AIDk
 r9WIk40OiQD6dcA/MlMV2OeMAqY8JAd0G9edzqJagGEb/ITb/5+esUsOeb8+Rv4sRCbVJmElW6w
 AxEMcW79VQZrPXinBrzNGAGYIfWy4ESLV3cNI06V+iVyN410XjQ35W23Xx4kW7owZo7oOzH7ZAt
 3oAO+wwq8F/sxXngosIwCdk5oHvenOIapuI13yYOqM4o58UCLOHo81HgIJTUHsGHfmr80Cz
X-Received: by 2002:a05:7022:e10:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-1247dbae784mr140953c88.1.1769111571754; Thu, 22 Jan 2026
 11:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20260122170218.3077-1-pierre-eric.pelloux-prayer@amd.com>
 <20260122170218.3077-2-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20260122170218.3077-2-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Jan 2026 14:52:39 -0500
X-Gm-Features: AZwV_QgDO4aDvgH3QpGF7ldVkfWjlAeaoZ3Prs-K3h3nGM9vUVZoMgemHp6YqlU
Message-ID: <CADnq5_O3dRsUKXiYG=twk+ccvMQVw0G_zt91xjeD1GV2p4fjwA@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] drm/amdgpu: remove gart_window_lock usage from
 gmc v12_1
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
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

On Thu, Jan 22, 2026 at 12:17=E2=80=AFPM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Same as what was done in commit 904de683fa5f
> ("drm/amdgpu: remove gart_window_lock usage from gmc v12") for v12.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_1.c
> index ef6e550ce7c3..dc8865c5879c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -345,9 +345,7 @@ static void gmc_v12_1_flush_gpu_tlb(struct amdgpu_dev=
ice *adev, uint32_t vmid,
>                 return;
>         }
>
> -       mutex_lock(&adev->mman.gtt_window_lock);
>         gmc_v12_1_flush_vm_hub(adev, vmid, vmhub, 0);
> -       mutex_unlock(&adev->mman.gtt_window_lock);
>         return;
>  }
>
> --
> 2.43.0
>
