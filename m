Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D6AE810D5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Sep 2023 02:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E74A10E097;
	Thu, 28 Sep 2023 02:24:55 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E9010E097
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Sep 2023 02:24:53 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1dd78b46995so2129954fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 19:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695867893; x=1696472693; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwbWTzEF26tkvrUDXa8g6EF1V6+cYDPwg5qB0QBbcYQ=;
 b=NZ2RuJl8A8mhOHU991kddqUsoVDH1o2n0JsxEXd/5BJ8A0e2HqQkDuvjm3ek9tyKV5
 E4zPnb9vqNpc/nzshT6s08rJaJjNODXQquHrRJzZnqA89gytcvcg/rbgkgafRYbzFK8O
 ju2RutjFMUJ9JAgbiW89Dys2toOBqeFugOHnmofGgiWZpUB9laCgGIodKQD7pHDkKRWR
 fbEKipGJjy6BR5MDKo8ffnqUhlouyB0rK1gukJhcyjyZuV1al0YPC9KYCI1yhjIPoe13
 H2hbAU1+A6uwqM9yTYhTaGsxr0Y49574gEVHBKi5HgpFKKQJqHFn4Nyr0iyWRA1uOmwL
 F0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695867893; x=1696472693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwbWTzEF26tkvrUDXa8g6EF1V6+cYDPwg5qB0QBbcYQ=;
 b=UmDrDKtlAsgSpK2EZlt8ADDh06oDfuHn7maLFEENWnQOLO+87saVb2Lg22casarlAd
 djf3vMVK8/I72C0zl8cS/6HwLdYumITPvF9y8Io2Xs/VUxf4U6StrkltFUu5rStA4jKA
 zNq9a1OnrcpearvEoZfCGqkq9AhnsSHkqUdSOZSgnCc9DWMqS2cVA6Gph6colGGYunew
 yJCNr/W0rkHaHF3OAEK2ehnGsb8ecBsikuXCwV66/Wjm4BCIdIOoGi6VdxYY7AMvclkw
 AdDC8wMG+ndQ2Ozn14gseb5BwuWoQd8YxwlXDw/5eOiWCG2zUTron/lc3X1u/xKM+cqE
 w1ug==
X-Gm-Message-State: AOJu0YyxhIOAmbubKIMCJHd2z0OywIxUoe/xDZXMzrsH0S6EoACyaFLJ
 QNVQY0ChXEt38jclKgM+G2GkdOQbcx+tObXRNpw=
X-Google-Smtp-Source: AGHT+IGuDADEcGLkGOl4njVwGCJKz0hXGdgnTNJPAhnZ5Jx73SAIdvOY6IopZJIp4gxu9KBbgCBWj1N3NX38p4Kmdao=
X-Received: by 2002:a05:6870:64aa:b0:1d5:aab3:ecd3 with SMTP id
 cz42-20020a05687064aa00b001d5aab3ecd3mr4519249oab.6.1695867893096; Wed, 27
 Sep 2023 19:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <b238c665-91d6-4afe-83a8-da2f2d59a75b@moroto.mountain>
 <PH7PR12MB5997674A218864F1B9C6B16882C2A@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997674A218864F1B9C6B16882C2A@PH7PR12MB5997.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Sep 2023 22:24:41 -0400
Message-ID: <CADnq5_NYB9HLDL60Qj4eQU8XXBVtuN=GqvWDuPtP=Ayq1FkgAw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: delete dead code
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "Kamal,
 Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 David Airlie <airlied@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Sep 27, 2023 at 2:57=E2=80=AFPM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Thanks.
>
> Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Wednesday, September 27, 2023 8:38 PM
> To: Evan Quan <evan.quan@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie <ai=
rlied@gmail.com>; Daniel Vetter <daniel@ffwll.ch>; Lazar, Lijo <Lijo.Lazar@=
amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Zhang, Hawking <Hawking.Zhang@a=
md.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesk=
top.org; kernel-janitors@vger.kernel.org
> Subject: [PATCH] drm/amd/pm: delete dead code
>
> "ret" was checked earlier inside the loop, so we know it is zero here.
> No need to check a second time.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 11a6cd96c601..0ffe55e713f3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2346,9 +2346,6 @@ static int mca_get_mca_entry(struct amdgpu_device *=
adev, enum amdgpu_mca_error_t
>                         return ret;
>         }
>
> -       if (ret)
> -               return ret;
> -
>         entry->idx =3D idx;
>         entry->type =3D type;
>
> --
> 2.39.2
>
