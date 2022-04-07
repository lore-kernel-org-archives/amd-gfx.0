Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B808C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Apr 2022 16:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2A7D10EB9C;
	Thu,  7 Apr 2022 16:29:19 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B352410EB9C
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Apr 2022 16:29:18 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id b188so6129694oia.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Apr 2022 09:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=w53aAF7RH3tPgi9ViONkPgS2RnlytBdz70g88cet3eo=;
 b=NstXekDlXIsP+D5dFhvJfM0sTedMEDkzhUPPGTMw7xvD7ShC8+W3GzkBZ9QIa1Ag/k
 FsQi1mkwUfscliclk54pWHaHkpEgvYDgA1zM6Wrv5eA5G/q4WyWXLLOyaPQvLJc9+NTp
 SAV5+5OAFvAYmXfnBUsrQmIcsYGjm/fm1QCMNBijxuA+3H4B76D4d8UWtkVYbOItuiem
 Fr69vZk8in5cD+otWbdVkryFo0FktD2O2pg/lzXGikwOrqcEg/gBHLUDsN7VzpvJyXGZ
 9WeoUbR3zK83S1oFC83gzVwT6mOcZPPeuW0DJsOxvQ0JdWnixWnWRZsE6vZH6LvOxUlK
 Cvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=w53aAF7RH3tPgi9ViONkPgS2RnlytBdz70g88cet3eo=;
 b=L4fwc3RNNTOlkyXgxpkEH9MAl4fsi0ZXTNrGb5iNlMXYxkJ16hoajZzHmRzyUTzLka
 pS7WC8wh7/v0tqq/wZcaB5YSF9n1VYMKMHgO1U7CQakS3VJAIJSV90YzZEyenm8RTbpr
 ucnJyxBN+Tmn2kUGRMNzXkf20IAjMZxDCU/lATVIs8vX42dke/HU0lwMQ6IEI60XjMwL
 8SyJ7DUp3h95tfjtFpD4zoWVSrGwjZ1oopxt1+KygsS+b9Fsh890VaIvs6Irw6is6rOG
 m1u8V6l0IcTqeT9hjfr7EEOSuAGYWguK65NFia3aO4vqC7AuQ4cLeIBK5ehZknuDGssb
 a4kw==
X-Gm-Message-State: AOAM533IuMiqdDLZirVNaXfp2iS8vNJhNmcxGUg8RpzzPZSLD59DQ1Zm
 s66V225om36WLl3sKJ8Z1OEzA3Caf/hqQg83oiKCDXx/
X-Google-Smtp-Source: ABdhPJzjEjvpPIIDLUGMT9VICT5RROVeEc7aT1tbCGIoamITap7YhoEaQBDL6f3pScQDimiY3zwYXi3EDVFcJBYU434=
X-Received: by 2002:aca:6006:0:b0:2f9:c685:f4e2 with SMTP id
 u6-20020aca6006000000b002f9c685f4e2mr362539oib.200.1649348957836; Thu, 07 Apr
 2022 09:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220406194921.2459-1-desowin@gmail.com>
In-Reply-To: <20220406194921.2459-1-desowin@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Apr 2022 12:29:06 -0400
Message-ID: <CADnq5_MQzr7nOgh1db=H5_EO1qwn6+Fr7JgKvXVkxy4L2sAcDw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable gfxoff quirk on MacBook Pro
To: =?UTF-8?Q?Tomasz_Mo=C5=84?= <desowin@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Apr 6, 2022 at 3:49 PM Tomasz Mo=C5=84 <desowin@gmail.com> wrote:
>
> Enabling gfxoff quirk results in perfectly usable graphical user
> interface on MacBook Pro (15-inch, 2019) with Radeon Pro Vega 20 4 GB.
>
> Without the quirk, X server is completely unusable as every few seconds
> there is gpu reset due to ring gfx timeout.
>
> Signed-off-by: Tomasz Mo=C5=84 <desowin@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 46d4bf27ebbb..b8cfcc6b1125 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -1205,6 +1205,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxo=
ff_quirk_list[] =3D {
>         { 0x1002, 0x15dd, 0x103c, 0x83e7, 0xd3 },
>         /* GFXOFF is unstable on C6 parts with a VBIOS 113-RAVEN-114 */
>         { 0x1002, 0x15dd, 0x1002, 0x15dd, 0xc6 },
> +       /* Apple MacBook Pro (15-inch, 2019) Radeon Pro Vega 20 4 GB */
> +       { 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
>         { 0, 0, 0, 0, 0 },
>  };
>
> --
> 2.35.1
>
