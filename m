Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09798C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Jul 2022 19:07:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 828C910F86A;
	Mon, 18 Jul 2022 19:07:44 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691C010F851
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 19:07:43 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id ss3so23009407ejc.11
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Jul 2022 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=d1EsRYsrFcVhqYe4UO8ZXO5ahBBHcUfIDb3IMgr66Ww=;
 b=IYWMUEl2BSZV6xQvtzRcNY0qngRJdMFUes9ugI+BerQqsM5fZKdDGB2xwuRKwpfGq8
 iOH4V98s78W5N3OtOhjZDKkpY2QwHX6FdgSZBKT6PFXinZPORQLp9tq+2gNRpFg5t/KZ
 IjM9S8Ao11YOHs3IQOI/YXTezsUT7HHKLdtg2XeZXT3SMcGGNthEveOEtERNLFcC4snx
 QLJ3DC0vqvRyE5/ZTQmD0g7V//AoynVNiyTIubGWBZdjtCpqzQGJkc5EUSxxEfupK0ZJ
 vEpTyEil24KJD1wVCVy+x7hg0CLzJ0Iq4wyUor1ZL9ZvUyBhfbADr+7qUeYRJ4PMt+C0
 mU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=d1EsRYsrFcVhqYe4UO8ZXO5ahBBHcUfIDb3IMgr66Ww=;
 b=ETjqL4L12ZsyKWfUPmuMqQqhJO32nYGYeguHL78ljptQ8rbAZz/rNNaCJqG9ZMqveO
 KSKpozbXXnvKBY+EiSso7mavme+yQkPsdnrQCFG5MX3oUQ3OCSEfc4acv02w38RQ81ia
 OfJ9HFDbLqzkjhu1rkvsGVKd2KnUpdb8RRIz2InrXCaFhscUbU7AFFCdTQW53+1jeJyE
 CL4aGK83OkCHEYcQVvK9/MUd9bcqWFoGgkiA7oiWzhyL3w9RlhB/3eDMhoJxPNuHHR+g
 GvuZD2k92r713jPbdB6WGnjNl8Ux5T70UNQ/sxn7MWr3wAXc6ToAOCbNLVivcbclUisR
 ZHdA==
X-Gm-Message-State: AJIora9B2WxRsvgieJoPeeKeDPEQvmmohdCYbMiHM1KWUXujaNE2WXy5
 z0G3Y6WgWHX8Ll/93M7k9p2DEcVxvlurAXeMjGA=
X-Google-Smtp-Source: AGRyM1t9iiOJzTdQ5QsGPH8QnERUgZ9dLU+MGZoKziZttmoPDFnU6cxZsBdgcMSilSHpLxooQdnjL5v0Pm6EmHwzOu4=
X-Received: by 2002:a17:907:2888:b0:72b:8f41:1405 with SMTP id
 em8-20020a170907288800b0072b8f411405mr26111910ejc.564.1658171261957; Mon, 18
 Jul 2022 12:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220714164507.561751-1-mairacanal@riseup.net>
In-Reply-To: <20220714164507.561751-1-mairacanal@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Jul 2022 15:07:30 -0400
Message-ID: <CADnq5_NaOO0MNy=84U9GJboVziAakYNMt_qqWVxm6p2At+rzfg@mail.gmail.com>
Subject: Re: [PATCH 01/12] drm/amdgpu: Write masked value to control register
To: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
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
Cc: Magali Lemes <magalilemes00@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
 xinhui pan <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Melissa Wen <mwen@igalia.com>, David Airlie <airlied@linux.ie>,
 Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Thu, Jul 14, 2022 at 12:45 PM Ma=C3=ADra Canal <mairacanal@riseup.net> w=
rote:
>
> On the dce_v6_0 and dce_v8_0 hpd tear down callback, the tmp variable
> should be written into the control register instead of 0.
>
> Fixes: b00861b9 ("drm/amd/amdgpu: port of DCE v6 to new headers (v3)")
> Fixes: 2285b91c ("drm/amdgpu/dce8: simplify hpd code")
> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index f5a29526684d..0a7b1c002822 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -339,7 +339,7 @@ static void dce_v6_0_hpd_fini(struct amdgpu_device *a=
dev)
>
>                 tmp =3D RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_con=
nector->hpd.hpd]);
>                 tmp &=3D ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
> -               WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd], 0);
> +               WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd], tmp);
>
>                 amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index 780a8aa972fe..f57f4a25cf5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -333,7 +333,7 @@ static void dce_v8_0_hpd_fini(struct amdgpu_device *a=
dev)
>
>                 tmp =3D RREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_con=
nector->hpd.hpd]);
>                 tmp &=3D ~DC_HPD1_CONTROL__DC_HPD1_EN_MASK;
> -               WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd], 0);
> +               WREG32(mmDC_HPD1_CONTROL + hpd_offsets[amdgpu_connector->=
hpd.hpd], tmp);
>
>                 amdgpu_irq_put(adev, &adev->hpd_irq, amdgpu_connector->hp=
d.hpd);
>         }
> --
> 2.36.1
>
