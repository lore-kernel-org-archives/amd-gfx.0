Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2914E87834
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 14:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9182C10E334;
	Tue,  3 Feb 2026 14:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="US/b3CUu";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9B7A10E334
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 14:42:55 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1233608c7e9so325691c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 06:42:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770129775; cv=none;
 d=google.com; s=arc-20240605;
 b=AMZcO3zMZhaRPJFtIVxOTdF90u0ys71sfyg0bJtR/qqvthdB2aKCP6hXCYc8nps6la
 wQ3ryjfMzKf8d2tmLnpX8ah9EfpOLypjBPyIhWtDXB02lnD5RWigtaxw5rvuPffYmeRA
 c9+3Gg/iCtUWgblv9CIeH32WpkDTyT7g2d3WRAo77L+A6dv54wjpACVQcefeKC5VwkQt
 QVKJvZ3XjDuwKZJdxr6w/O4vjuPpajWh6kJ8YiBOFaj2rvpssIMvJxkSeUKd+tOS877o
 ah1PpnS28jm20WfHpGSZfTL8etcAAP6HeRNBIWmUKkiOalpWOdWeT8MWDxd01LgSFR+I
 Omaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zAyJ1LchLlBb/G1x5b+ldeIF871jaIpswKOgTAKLV0M=;
 fh=xZfaXxucE4ISKQoWJiaUZ8w0Esj6KEgk4l1ctH5vEso=;
 b=ZtWsOCux6Dk7xYczA5UwRBTnjw40Nx9jh7pLaf1peog++ET9Ri+bm6+f/ogm9IHGNx
 bBaNRj9eABeW48akSMessqiV7UqQzvKk1ULu6kNLFsrb6EM0hpmlybxlZ/m9lCvsvWh2
 pzKgBz1CkO6OeLxfuC7370tNF6yTwIFs/cNa3vy/d2Sz3ynL/Hd7dB51ACr7eQ3Q8eWz
 KHHAPvVXhxB/ht2V3UHDfKhihrBYIW71F2ZsB0YcbbqeDIWSj1KkcUPygre4ht8PSCOe
 POOPrF9g++1vS1n8Gb6HRY008gmsAvA6cOQw9LvgRg8/c9qiOJqbbbhmbG9jEzaeqQt+
 sbTw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770129775; x=1770734575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAyJ1LchLlBb/G1x5b+ldeIF871jaIpswKOgTAKLV0M=;
 b=US/b3CUutL7zeiySmIK+MKFFtuPnIllGfPNVAfCSxSpNl6F0m8JA4IaLV8q97sq+yH
 8Zv9Mg8nh0hxs4NMBPAIxqH+idlwQ1G0F6fcB8876o7BqMpuhTKQgaP3OZKdQBV98POt
 odaNBwaI0pEDB3zi18CcN/zJiaY4ZTuFdF6LjKN95GEOqI4tWeFXq6zjwSkYl+UReLap
 dS3je/YaAEROE0NwSTGjNH4hb/IW1deGtjZ+7ymfinmbsfbzUdvLiFQ6znaURanMOkHt
 awAqxLSJNpe2+QsmzsUCNkKFZ/V0I0iMOP5XZn6StK/+sgafcPD+i4CQFvFyEGK55bZS
 7PFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770129775; x=1770734575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zAyJ1LchLlBb/G1x5b+ldeIF871jaIpswKOgTAKLV0M=;
 b=H0AMJAK5kVqud28/G7PTnSiA8uTMnNknkwtpOQLzpFmP2eXif5kzu9rygqPXq+9awi
 IQJ6hpArTgCgFnNDpYJVnZpW7INmuWQ/jEauH77cPJKqRP7cVSJI/R081kNH1hehBN56
 goj41/U1vUeQx7sStCnlWd7ugDvuRwatlpv91d224zOtr6712YyWMu1SzVCli8RMtIg8
 aYf7zolBSKHOazoFi5mYf96A5LcL1TYjmaU3IgconyKxKUyD+r+Pjcl+6OcAu9Lamdzo
 zhsZhod5k0ymwYItwN0typQGBb+ozqzosUqx98p146uqX1P88c9Rw029Y90S0jZ6KOKF
 ZFMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhCGIab/LWHR7rnQdw77Do5kFEf/ua3rApRfwFCrkH1T4bW9SacHn98mPpu4laeEYaWWx0rDHu@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzeu7bDmv4ljDH+grk51Sx3Kv1Yh69p/IhEdeyP4doGYpDmbC8A
 Gn1dZHtXvGXLehKa6XCMBfEFJ5spl64h8xcuQzDQEGxsScqQhLgwaMC1nDpQ72vZVyosWPXdL1H
 bH4ls/p3NCbE8ZjzIJcGBlMtqX5o7uug5cbzo
X-Gm-Gg: AZuq6aLT/d5XSxNICWfUdmWEmk/2RdGtg0L4zNhhXI6OdQJ/ZQT4FisYbwZIp4hthwu
 VtfmTvsZXKqbcwrQkxARt0qCX6+pG++c8JVUkG7kNdVuSj8b1hbdTnc9WVfolPUazXpqpqFKep1
 adQ7DvXEazjv8zSskdLANKeZcSDvpiuyyPdssFh/yYpNI6Ejsq6e+7gVHlufTBT8MLQa3EmkCD5
 Pnep+gj0h+R+dIqQudLTyEHPcW2yGOJX1+pmcM3tsm/sA+bh+i/qeq7I2COMdYiZnpd4wLq
X-Received: by 2002:a05:7301:2288:b0:2b0:4a1a:657 with SMTP id
 5a478bee46e88-2b7c8948086mr3806459eec.8.1770129775051; Tue, 03 Feb 2026
 06:42:55 -0800 (PST)
MIME-Version: 1.0
References: <20260203065529.1360282-1-sunil.khatri@amd.com>
In-Reply-To: <20260203065529.1360282-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Feb 2026 09:42:43 -0500
X-Gm-Features: AZwV_Qj3lUywzH5r5dJrhrAvg_0eikkaWTcAROCxwD4-HaFhg0cEdIPceOfH8kE
Message-ID: <CADnq5_NA2ghiTOJ=Z=jw0pv5TLX4ZvV13un1BxBFTzEmEw1OSg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clean up the amdgpu_cs_parser_bos
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, kernel test robot <lkp@intel.com>, 
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

On Tue, Feb 3, 2026 at 2:09=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> In low memory conditions when kmalloc can fail and hence
> we need to clean up the memory and unlock the mutex for
> clean exit.
>
> Fixes: 737da5363cc0 ("drm/amdgpu: update the functions to use amdgpu vers=
ion of hmm")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202602030017.7E0xShmH-lkp@intel.com/
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index d591dce0f3b3..831063971f71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -892,8 +892,11 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_par=
ser *p,
>                 struct amdgpu_bo *bo =3D e->bo;
>
>                 e->range =3D amdgpu_hmm_range_alloc(NULL);
> -               if (unlikely(!e->range))
> +               if (unlikely(!e->range)) {
> +                       mutex_unlock(&p->bo_list->bo_list_mutex);
> +                       amdgpu_bo_list_put(p->bo_list)
>                         return -ENOMEM;

I think this should probably be:
r =3D -ENOMEM;
goto out_free_user_pages;

Also, does that error path need amdgpu_bo_list_put()?

Alex

> +               }
>
>                 r =3D amdgpu_ttm_tt_get_user_pages(bo, e->range);
>                 if (r)
> --
> 2.34.1
>
