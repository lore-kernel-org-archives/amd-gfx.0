Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7928D2C559
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 14:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBCC10E696;
	Tue, 22 Oct 2024 14:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E9vrnB/2";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C266410E696
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 14:06:37 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2e2a96b242cso760281a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729605997; x=1730210797; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+extFXfwu2Y6kelMaX5gU9r/xV/bqxuKq/V3m9qWZ0g=;
 b=E9vrnB/2mD9r3ecGtsJVjyRf3NLrDS0+x46gjILT4ua5nZ5sGKQHdWnD0s2ClBz/Im
 Xfn+FK35uaccozx9f43QCDfc6/Y0k0IFFU7ItIoNzJ6jvr8Qh60UTJi67W/sIRD+IZV6
 YMvQhG93QIr4oJHPdzncRkWhZoL4nCTDnKCZoGdlqwcrTsS8ej7qJi/ctfJ0yFggWQWR
 9l6vigGmibeggCmounYKxpkGL2v3JGPIC6cGnEtJZAK+Kv3aWcD8eQXPoF9Hlp0fMn8r
 g54hxr/D4aBsRMLj2tV4mDzyZDdu14tRnf8nvhJECZRUxKaEGwa7LvvEekbZhb/r2bYT
 L9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729605997; x=1730210797;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+extFXfwu2Y6kelMaX5gU9r/xV/bqxuKq/V3m9qWZ0g=;
 b=L/CjHRBQTDO7ULNvZYoOwh5iFk6c910eU4PnVXvlVNpS7VhAcxgjXto0Z3HSe/RkC+
 MhVky8r5Er1238+uvZutaiszt98hNjSgLKmGrCZp8qK9LLkavtPuhUgOzLw2h3FnIfoU
 N3vWGttNnKXTNWOxGt8LetKw8aFMl9h4ty7QKGkzdCIvF7Zqs0S7EgzYVjs4/6XDdhow
 XHPDCJ9cAGTje6ZuNuy0+hi2uOQqBJBoNhHpbbr///03cFqXH5K9giYv7lOFGd81clQG
 Rqp9Vy1vUuqUz2dQFg+nvApQD4ni0+TZTpeUQb6c8Rg4B1yH5EvMpxpzWMPFQV7K5hC8
 TDCw==
X-Gm-Message-State: AOJu0Yy/LsYGBXhgxGGIxSABIbiN5mos1x+JOJP0Jv7HJKrVe7H2GfRn
 YeCrD6Ce8JpLScxGcvw3Uzp8HijNPerdDhOJVmyg0ElHLPAZSTaTYBKBQvcboP8AD8ED01CzTUo
 Tix4LbuNaGLE1XPHjxd6kasfaZdREFw==
X-Google-Smtp-Source: AGHT+IEr4Vy/n376inc3r8M69IDuMIlXgXTU9jd60s3MLMQuziIx4utu7rdnxA9YK0y91+LdXC215un/E3I6J36LlcI=
X-Received: by 2002:a17:90a:a418:b0:2e2:b20b:59de with SMTP id
 98e67ed59e1d1-2e5616e8789mr7509815a91.3.1729605997232; Tue, 22 Oct 2024
 07:06:37 -0700 (PDT)
MIME-Version: 1.0
References: <20241018063533.3082692-1-lijo.lazar@amd.com>
In-Reply-To: <20241018063533.3082692-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Oct 2024 10:06:25 -0400
Message-ID: <CADnq5_PGD8Bgt=oAiGA4FQcHNCt3dhKu2-EhNwj6NU0h_+nxCQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix the logic for NPS request failure
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, rajneesh.bhardwaj@amd.com, Ramesh.Errabolu@amd.com
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

On Fri, Oct 18, 2024 at 2:35=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> On a hive, NPS request is placed by the first one for all devices in the
> hive. If the request fails, mark the mode as UNKNOWN so that subsequent
> devices on unload don't request it. Also, fix the mutex double lock
> issue in error condition, should have been mutex_unlock.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Reviewed-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Fixes: 44d5206ec07c ("drm/amdgpu: Place NPS mode request on unload")
> ---
> v2: Add a debug log for debug purpose (Rajneesh)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 28 ++++++++++++++----------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_xgmi.c
> index fcdbcff57632..3ef5066ca529 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1586,26 +1586,30 @@ int amdgpu_xgmi_request_nps_change(struct amdgpu_=
device *adev,
>          * devices don't request anymore.
>          */
>         mutex_lock(&hive->hive_lock);
> +       if (atomic_read(&hive->requested_nps_mode) =3D=3D
> +           UNKNOWN_MEMORY_PARTITION_MODE) {
> +               dev_dbg(adev->dev, "Unexpected entry for hive NPS change"=
);
> +               mutex_unlock(&hive->hive_lock);
> +               return 0;
> +       }
>         list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) =
{
>                 r =3D adev->gmc.gmc_funcs->request_mem_partition_mode(
>                         tmp_adev, req_nps_mode);
>                 if (r)
> -                       goto err;
> +                       break;
> +       }
> +       if (r) {
> +               /* Request back current mode if one of the requests faile=
d */
> +               cur_nps_mode =3D
> +                       adev->gmc.gmc_funcs->query_mem_partition_mode(tmp=
_adev);
> +               list_for_each_entry_continue_reverse(
> +                       tmp_adev, &hive->device_list, gmc.xgmi.head)
> +                       adev->gmc.gmc_funcs->request_mem_partition_mode(
> +                               tmp_adev, cur_nps_mode);
>         }
>         /* Set to UNKNOWN so that other devices don't request anymore */
>         atomic_set(&hive->requested_nps_mode, UNKNOWN_MEMORY_PARTITION_MO=
DE);
> -
>         mutex_unlock(&hive->hive_lock);
>
> -       return 0;
> -err:
> -       /* Request back current mode if one of the requests failed */
> -       cur_nps_mode =3D adev->gmc.gmc_funcs->query_mem_partition_mode(tm=
p_adev);
> -       list_for_each_entry_continue_reverse(tmp_adev, &hive->device_list=
,
> -                                            gmc.xgmi.head)
> -               adev->gmc.gmc_funcs->request_mem_partition_mode(tmp_adev,
> -                                                               cur_nps_m=
ode);
> -       mutex_lock(&hive->hive_lock);
> -
>         return r;
>  }
> --
> 2.25.1
>
