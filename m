Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924C6C4451C
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2026 14:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA08A10F594;
	Fri, 17 Jul 2026 14:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oxAP8+kG";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7606710F594
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 14:55:24 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cab1f435afso14935195ad.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2026 07:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784300124; cv=none;
 d=google.com; s=arc-20260327;
 b=jRo5BLETtoacDnoSwgMSS+k2ufDwhJBHBNyHNtlxaFiyCAXS8XC+6ufHbV0XxDAaud
 H6kh+Df2A7sNxnp+gUeOwFKQ2weziS02y2IyvU4PZuLB7noxUyzN4HuEtsCX1nrA9sMS
 gMRKiF7QPoyYmwKXwJX+DAmhLSUsxASM8voAOXkX6rUkqZad0RbhqXs5/HR7uhG1kLbb
 0fAc5xRcNFcSsXxOLqdkS9GBrqGyqLPHjnUaNiRa6wFbGLdQl7BKtXs80X1dBJAGenwp
 aRX0MAkwxXdD8f4bb/E7/3kojwCm4UZPj6Zf9rLCm7myZLKWkQHwwXyLzVt6ddaNEPNw
 NOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ar+1Hu+PGKB3bctJhS4XtPd2fbL2DABSj6SyXwdhS78=;
 fh=7A/YqYZ/jkw8OyKa1kmAeSpucSljyHmGgfIYC2eInts=;
 b=gOZ8L+vpacrsC6pJZm8GFScK6l3ticU2ZZc5p0sAyyJlHwwVVOoYpxOE64hW7dn37e
 4lGQ8h4M963eC9L1YWSJh8lu7P0rZLK3dzdX54C4SPFEclTM9b8bMnz4n8ZlTQTIYRhi
 55rZEQ8KNjzkRViVnYvGXskTCFL8LNjypCRWNvw3TJYwBvVgklqBBELr9ZMwPenJKgA5
 0N1rRFxNNJZ1L9jetSkU2+Ez1D2wexhovPMzZCoutMmEzd48pQ/7d/SpAOzT8D4r8n1k
 XvWcS3mxX5uhfv9mCeJ4Lm3ZFQGKb0wms4WsKCCnnaJwy1WI9oIlSsQZur7rYXjbi2ug
 L2nw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784300124; x=1784904924; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ar+1Hu+PGKB3bctJhS4XtPd2fbL2DABSj6SyXwdhS78=;
 b=oxAP8+kGWqYwU0IGnUP/MZZ2qRGNxa19JgGWvXJHvYBDxZnpNZqzD3J+ssx7B2aB3F
 oxlFA8qvnpHKqvlg8WXJcH8xKHdDRHt+iAtwEr9GOCWa7KUH2bZ4nksdvgRtSHXhc9wt
 +4b1lOrPZVKhvvs8/5ld6jThyyQf/OZGFcIzT0jCKTNXXgPjXaH26526mvtijzp7eLLH
 CF7W/oYUa8a/AWyOTPREhOEWn5ytcPaFoIfB8JiE/EhQpoacEO8a4CUQxwotXcwz4Jks
 wsHl4khGPUs9QvbHsaeenYjq+4I/Wq2cUILAL7PBqbaMF/eu04/IrSi0KyZeiSDUAIjn
 aXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784300124; x=1784904924;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ar+1Hu+PGKB3bctJhS4XtPd2fbL2DABSj6SyXwdhS78=;
 b=ftIrOcKuVkrqCGAUsLrbNHYmbKh6HVXmDsfUQANNhgSHBH4VMM0xEZY4VfAlZq6aW/
 uEJYs1DWxJtC6uCmKCixm8vnhDwGSy2ry93HvI5WyQweLGsTX5n1huc1ebuPGSGS3JCr
 4qitx9LwBz6IQf7QXb4UmUGSiigCr8vGKzdVNLrExnMuaCXRrlXD8nkVXfCzAcFVuLzK
 akpa/Mg1qqrDSd5LlBCIGmEkEm70DFfQFvikhDrNQEe3QQpWa9Jg5g/f4P/lV3ClEYLw
 btjuWG/enHEHeJzBTDNQaIAKTS5F2h3+QxPtByvc4d16D8y3ep5rTdor+ZB2f7HmJ0+I
 WU6w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoYjtTB786cFh5hr1eYSl0lep8JazfWfUoWhzzw6CxZrDgBT2fjwN2j9uBaD6AVvyn2EGqzMitG@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOdKgLwtTEcmv3vxVHBNeXGkNNp4CaoGv1ONAMXp/CnntYtLpr
 wYQmRmECYHTy/RojUDLTQeBinCL6EcUOf4dJWVPrT+Kr0MX2Ui2mb4G2WNB3qQkwW0iYHslwO39
 zFMVDXx92lQC66D63g0ldP4uhe0NaKYs=
X-Gm-Gg: AfdE7cngZ69dnABU3pgFU9TVxCi9cL32SVCMVwNYDKf7LjJtC5n+sdVs9svr9jvQKWp
 z6cPmJgfLOVOj1aSd8+PlQpjvjQ3EG1vbN+WyspYMMkSMVeWwUqH0nQJazxKv+LopFuyqGe9jeQ
 ASFhlCfDONmytqIDjiPbkbsM1RPUS0Tvl5CZ3bD1hD7gW7F2x9dTGOacc5vwFC/AxGk6m3KdWbA
 oM+2Zseu0YJVl5eNXe/OgbhbKEy2nE9i028QEOGhyUe2x+h9F6ewW+/waRlw3w8OA63I8jGMHZR
 Syy4RmNPHuyBp+quu6gROgCsfPIU0h1lLewTn2RJbyrNlRKR/MLKlMw0H08=
X-Received: by 2002:a17:902:d4c9:b0:2ca:ecf6:9105 with SMTP id
 d9443c01a7336-2cf3485978amr26279085ad.1.1784300123950; Fri, 17 Jul 2026
 07:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260716152933.6744-1-spasswolf@web.de>
In-Reply-To: <20260716152933.6744-1-spasswolf@web.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Jul 2026 10:55:11 -0400
X-Gm-Features: AUfX_mwnPugTm_pl4sjXfiipoM2X5NDIEbYMRhDvStaI7DQRbBnnWEYgh9sQs-I
Message-ID: <CADnq5_PEN=iuspWbQ9C3gJZ5qJVOLmJ5hrsi6FH0Dg2Y_u2mZQ@mail.gmail.com>
Subject: Re: warnings from validate_blend_mode_for_alpha_formats() in
 next-20260715
To: Bert Karwatzki <spasswolf@web.de>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, 
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 Leandro Ribeiro <leandro.ribeiro@collabora.com>, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-next@vger.kernel.org, 
 Jesse Zhang <jesse.zhang@amd.com>, Amber Lin <Amber.Lin@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>
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

+ Some display folks

On Fri, Jul 17, 2026 at 9:04=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> commit 860e748bddcc ("drm: ensure blend mode supported if pixel format wi=
th alpha exposed")
> introduces validate_blend_mode_for_alpha_formats() which prints warnings =
for amdpgu as
> amdgpu only set blend_mode_property for planes of type DRM_PLANE_TYPE_OVE=
RLAY. I tried to fix
> this by removing he (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY) check in =
amdgpu_dm_plane_init():
>
>         printk(KERN_INFO "%s: plane=3D%px plane->type=3D0x%x plane_cap=3D=
%px\n", __func__, plane, plane->type, plane_cap);
>         if (plane_cap)
>                 printk(KERN_INFO "%s: per_pixel_alpha =3D%u\n", __func__,=
 plane_cap->per_pixel_alpha);
>         if (plane_cap && plane_cap->per_pixel_alpha) {
>                 unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE=
) |
>                                           BIT(DRM_MODE_BLEND_PREMULTI) |
>                                           BIT(DRM_MODE_BLEND_COVERAGE);
>
>                 printk(KERN_INFO "%s: creating alpha and blend mode prope=
rties for plane %px\n", __func__, plane);
>                 drm_plane_create_alpha_property(plane);
>                 drm_plane_create_blend_mode_property(plane, blend_caps);
>         }
>
> But this does not completely silence the warnings becuase for planes of t=
ype DRM_PLANE_TYPE_CURSOR plane_cap is NULL.
> Is this a problem that should be fixed in amdgpu or is should validate_bl=
end_mode_for_alpha_formats() only be called
> for planes of certain types?
>
> Bert Karwatzki
>
