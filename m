Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E44DC54EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 16:48:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B33D110EA2D;
	Fri, 13 Jan 2023 16:48:36 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C8F10EA2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 16:48:34 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id h185so18130274oif.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 08:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hv9TwrU38tNIh820HfxIuraK/buEwMAzSLgY9mxaBBg=;
 b=NDN2yX8n3mpl3nQVCfaLxVOVC/MrFAvhXf7TstDb98+4wTJS0WcOBe5317nIp5jjAO
 9YzDKKrbWIbpIIwIxVj/pTqXC8PZxbn9NpwnqNhjG6VuWe8MHmHt8k4AQwFNRKn/+v/e
 1y+KNbHBXHoevut3GNvGR0GGBzjrRL6Y1CJFi5zWeb/nNbAuTqUg0Ozmo1wnXJsLpWGg
 k0xD9D33nVAJw3+sAUR5KgERGRdxFHa0mvTMfrMee1DKtftMNF3wnrlLUWblN0NV1N62
 +eS3I+ph1EiBitKgrlK+72v7L8dLjE8MIC8coHtvVvnCjkMd/YkA+xd5dXA/k38mn69m
 QTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hv9TwrU38tNIh820HfxIuraK/buEwMAzSLgY9mxaBBg=;
 b=PUUawK+pFShkG0CivG5t2AGGXQtcTcDSzF7bXyk6R086Hcl2q6VLAo1VjYEDtcZnJc
 mu5s0GeaWI4gdWKdBP/yWfpc0UiUgBOwtO32EgpmVsL6FPcZmvzkJIU7Alkmtn6tFdN+
 FtReAhH9ccdR5sPL1M+LxUoptdiJ1/WKHpsL0vmuHO0moChngawBYbfhWwUjl0+4cGoe
 XMqDhlgxIRyH2xIB9vam8UYORljKoMEG6FgS6OIMXTMW4YN2OsQLf5eTNGnBBDJGuBt1
 IQzP3RP+NeqtyZ463+cHEmqeat/4pDhjbRTeiqaF8DdeFJOJ3tf3+k4JRyNhSqXdcDje
 r0RQ==
X-Gm-Message-State: AFqh2krJ8seKUOHCWyQaNIasS6aZHuxuL9NOzG85ZcfcbsKI/LyIKLV4
 JwBldIKIYoh2WgSy5JR+3LMCpvTWR/mdbEzXmNM=
X-Google-Smtp-Source: AMrXdXvz/9Tj+9FDDlrusM0LraZs1y2JBZm9a6Ygeq2esfEv1ZSnqHVsUzbHYxqQyF/UfgMr5s6jDuJaCyIPRdbKvgA=
X-Received: by 2002:a05:6808:2994:b0:35b:f5f7:3ed0 with SMTP id
 ex20-20020a056808299400b0035bf5f73ed0mr5516817oib.46.1673628514083; Fri, 13
 Jan 2023 08:48:34 -0800 (PST)
MIME-Version: 1.0
References: <20230113163531.175294-1-christian.koenig@amd.com>
In-Reply-To: <20230113163531.175294-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jan 2023 11:48:22 -0500
Message-ID: <CADnq5_OjeFLZ-s=8nr2N_ERecX3dCSiGg1R9XPc=cxB=f2RYDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix cleaning up reserved VMID on release
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Candice.Li@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 13, 2023 at 11:35 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> We need to reset this or otherwise run into list corruption later on./

Drop the / above.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Fixes: 16be3e9f6f03 ("drm/amdgpu: rework reserved VMID handling")
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.c
> index 6481b43ffe25..a0545d51b6bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -499,6 +499,7 @@ void amdgpu_vmid_free_reserved(struct amdgpu_device *=
adev,
>             !--id_mgr->reserved_use_count) {
>                 /* give the reserved ID back to normal round robin */
>                 list_add(&id_mgr->reserved->list, &id_mgr->ids_lru);
> +               id_mgr->reserved =3D NULL;
>         }
>         vm->reserved_vmid[vmhub] =3D false;
>         mutex_unlock(&id_mgr->lock);
> --
> 2.34.1
>
