Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1844CD80CE
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Oct 2023 13:25:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4760610E36A;
	Tue, 10 Oct 2023 13:25:14 +0000 (UTC)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2DE310E36A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 13:25:12 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57b9193b1aeso3370874eaf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Oct 2023 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696944312; x=1697549112; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XX6NrfKbVHZCg8JFREwp2vkxg/RStpLOR6o54oq5U6g=;
 b=B58Uip8sScLruKNmcF0nFRJcmMhG9wpWebm/0+wH+qD6Udy6iBzlZLAvU5Tz4v1roh
 iSWizUg2Cau0aiNSS7bgeFoypQARcY/H3smWW0EHqAvbWVIaS4ura1sDdRbOYkURWk9t
 vOhbgQKF3HCiJHWSI8PgexNXjJxnifzJDy8cGzG6XMmqtW6otvx1WIsLMTUILd3IjOQJ
 fhQlyf2YqlxswMcOeyvMqw0tqd4sS5hPIVkD2L7NGvJs4kwkdSj0bv10BsFnaENUNarC
 KOIUKzXUsN3S9dMFvYaE9kgtf8qkgRFPNirMq0UbwmoLG3urAKrV9Q6b5m3y8ll7NhQ+
 Z5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696944312; x=1697549112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XX6NrfKbVHZCg8JFREwp2vkxg/RStpLOR6o54oq5U6g=;
 b=XaIxsfLtrgkGiaoBtjOl376n0GWdcjLiy0y7nvyReUUiemGy8JSGFbGU7h+qlUgrPv
 62r5sdm67aRUOKaYouLqusY6XevxEYN09ucOYw58cLMY0o/ckqpYsCG14bQD5f17UYG5
 w2sowla8QzrAfrGIFUhZSf1Li63Hmhw/GszIOUkFU/MaJPPoM/bx+nFEw/mr7s+JZfbo
 G3OCPjylwEnD9tTKNPWjl9ngmosvXj/Ld6GEpfs4Dn/OZYrk2tAhHyhVBu9cKDQQjLOj
 +N2O5awkJd5ELzhVz+LCV2i3HNBjpG6ppuJ2bMekfxrfYiTmEgsMq6tApVAfhHzc9LR8
 XHbw==
X-Gm-Message-State: AOJu0YzIm5Eh08Vsjb3k0aHajb5HmU1jGEIaGKn9KHsez99Zzr8Fh6Ne
 M9so3wCc+bg9eWhrDtz8cQKEk2zfU+QykVO8+nM=
X-Google-Smtp-Source: AGHT+IFYbz/PTFuqeD/Lb6ERpLFdftUxHQ2QX40MWUQ9LtM17PgFIQuUjMiUMaZokjwrr6d14T+bM5FysMUZgYXwLBk=
X-Received: by 2002:a05:6870:b08:b0:1e9:830e:cf52 with SMTP id
 lh8-20020a0568700b0800b001e9830ecf52mr48075oab.1.1696944311932; Tue, 10 Oct
 2023 06:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231010054953.20156-1-bob.zhou@amd.com>
In-Reply-To: <20231010054953.20156-1-bob.zhou@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 10 Oct 2023 09:25:00 -0400
Message-ID: <CADnq5_NmejwB82i8xjekhW-uC5xBN2UWnX5ue=RDv2r3oL3bZg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add missing NULL check for DML2
To: Bob Zhou <bob.zhou@amd.com>
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
Cc: alexander.deucher@amd.com, Jun.Ma2@amd.com, Qingqing.Zhuo@amd.com,
 amd-gfx@lists.freedesktop.org, feifei.xu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 10, 2023 at 2:07=E2=80=AFAM Bob Zhou <bob.zhou@amd.com> wrote:
>
> Recently, the driver introduce DML2 for future ASIC support.
> But, some ASIC's hubbub pointer is null before calling.
> It cause the below null pointer issue, so add null check to fix it.
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> RIP: 0010:dc_create_resource_pool+0xc1/0x2c0 [amdgpu] Call Trace:
>  <TASK>
>  ? show_regs.cold+0x1a/0x1f
>  ? __die_body+0x20/0x70
>  ? __die+0x2b/0x37
>  ? page_fault_oops+0x136/0x2c0
>  ? do_user_addr_fault+0x303/0x660
>  ? exc_page_fault+0x77/0x170
>  ? asm_exc_page_fault+0x27/0x30
>  ? dc_create_resource_pool+0xc1/0x2c0 [amdgpu]  ? dc_create_resource_pool=
+0x243/0x2c0 [amdgpu]
>  dc_create+0x23f/0x6b0 [amdgpu]
>  ? dmi_matches+0xa3/0x200
>  amdgpu_dm_init+0x2bd/0x22a0 [amdgpu]
>
> Fixes: a2815ada8616 ("drm/amd/display: Introduce DML2")
>
> Signed-off-by: Bob Zhou <bob.zhou@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index 25562b262555..d20e01226353 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -321,7 +321,7 @@ struct resource_pool *dc_create_resource_pool(struct =
dc  *dc,
>                                 res_pool->ref_clocks.xtalin_clock_inKhz;
>                         res_pool->ref_clocks.dchub_ref_clock_inKhz =3D
>                                 res_pool->ref_clocks.xtalin_clock_inKhz;
> -                       if ((res_pool->hubbub->funcs->get_dchub_ref_freq)=
)
> +                       if (res_pool->hubbub && res_pool->hubbub->funcs->=
get_dchub_ref_freq)
>                                 res_pool->hubbub->funcs->get_dchub_ref_fr=
eq(res_pool->hubbub,
>                                         res_pool->ref_clocks.dccg_ref_clo=
ck_inKhz,
>                                         &res_pool->ref_clocks.dchub_ref_c=
lock_inKhz);
> --
> 2.34.1
>
