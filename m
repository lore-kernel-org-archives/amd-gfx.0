Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21A2E63F3F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 08:51:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EA6B10E1A5;
	Mon, 16 Feb 2026 08:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i/YepRGu";
	dkim-atps=neutral
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A9110E242
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Feb 2026 10:56:16 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-794fe16d032so15827617b3.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Feb 2026 02:56:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771066575; cv=none;
 d=google.com; s=arc-20240605;
 b=MyGDaWaqMb+GlzcsX4kT9Up28J6FIk6Ut7AZXFHg5jXR84ZGzWKKOwGTnGOTLEkU7P
 hJCzDdWIkwKj2IPrw47yxB832zSvsHdnBn1d6ZJPoti24NWZtJVQSBafAOXOWmruUZe0
 sZhJAhmiYjuZsBHsxS2Q/eRPcIyRmUrw2ggCS15w5tpTvPdZxMWLHTvffNPMYajE2UDd
 o49czc6B+YH4tA03D3e45yOS9WNSW4fFOycKllb3JyUoYfON+XTyhjLd33AiGNStaJIO
 UJxEhQqdlbcddcuY0V/xBbAnRVVgicvqcVzqhFxlwr3g/mAQYzXsGknpkfF+DU4W2zWy
 xaVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=8L4oWNjn98+MIKnP6WovLCu+A7/I1KYKwjVzhrIOunE=;
 fh=geMLhvqPvax/SxqZx0MHxBQwimqOLVM3Zh1qkufLTaY=;
 b=NYw9cLnyGf5okx/2TWA2MCZUQEOHX8fM/jV1eI1Dfeeo8CQTUsyx5xPUmkMwGYTa3V
 bRFbMNiRHXb762hCiAPP8q7KoM70WM33ymRUf2HdiW5sQGNmga2sIpM6UV1xqrYSsBMl
 Xjg7Ftq92WwkCC1pqUeUM1mmDjrA4SlwnAAQvWk2QYGqqU8H5vsqzfQckaloHmPT8Ldd
 3S9InMgYfiESCqT5y54iN/daNWoU7mTyKNY1bYZK1QBq4kFfXaclQ8eFcItifnYeMR+c
 /beg7ixTSuperr8uDOh2CrEPfrn7T1EqB7JyIizya5A0bp+XTZ8N9n+RmUeqYqO3JehC
 32vw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771066575; x=1771671375; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8L4oWNjn98+MIKnP6WovLCu+A7/I1KYKwjVzhrIOunE=;
 b=i/YepRGuZddrPRqVGEGpSTqXCrs0wYBksOEpu354X1oxzfunItiH77UTz6g18HO8br
 zHUdeVhWLaa93QX4NI115z2tsegJuHiCaTaObu9zzdFA0o6RJ+ZW3/adKxRJGt1lwVOe
 LMiWE3udhwpAIlYt6N4LkNIGkQ+B1G58zyMipQIi5mzk94o1lF40u2eY67sFcMce/P1N
 9aBNDq0zVGm4L99Vr+fdegDGmjXtdQP7CMJLn94IJE5nXfSRUT0LvTaXVPZSL22qETSY
 VLhO3IrfPXRQi8VQolBQeRdFz6u75EFCMfOiOWt9EzBZ5n2JE9sO3lIy8aJ5RKIN5dkx
 sF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771066575; x=1771671375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8L4oWNjn98+MIKnP6WovLCu+A7/I1KYKwjVzhrIOunE=;
 b=JZ804WWr98FmYrQk5ImoCvq0sr0jyiJIHjFTYu8rw5rUasXlN/rSNVX6pLobuIvLvt
 hwgTN0vyA+KNlBz6qKP6G4nv1kXTWwXxVWSHv2gw+8AiySRhvCsHgKNhR2azPmWMGzqL
 7mbvX0v0FEO7AQkWq0CpPYQEUNHCDgzLlgSWsCXZOAuDtbJGmO811Cn1nCEUhp+VkOQO
 /CZVBRL+aMz3ZWJicmOWjvhthxZqDH89pgKvT3VIcoP/WU17bisJNlX/NO48Hor8kBsf
 /qHflBTJhUWrvg4R5SO8KhIX4xAm9sKafCkZncnUpWONAJVxni+r3s90lK5tx2VjOkpL
 JNlw==
X-Gm-Message-State: AOJu0YxUrQziL7an2g73+YhCZvb/LAeFreyXw1bgrgFCWB9QJDwuojng
 ggw+adBtfEjpSONHrjYQMkX3XaqPHziW6P0K3K3NIf7OeMs0IccEJfbSIvNamN6+2TsX4oBfIk5
 ux5Kdb95LmO/UtPi2ZmNf+CDgKZ4dpDQ=
X-Gm-Gg: AZuq6aILjktW8UWnenKJH4fQqm3s0l49eGnYeEl6EMvXIsNHe1t91tWkEdNgT75p5bi
 erMOQl65Xx2f5QVJREH+NQDoT3qBMpLydrBB4Vj5DfyS+PHiH8yuR4W00SyqNox6iwZZfSsikUJ
 Gd+kaUI54hHDII9mMZj6YMb46ee1XOqWmuFCETWYO2Xjf05RWiJQWftyVgEGQD5FJgUuuKAGi1/
 KjRGN7HpfYAKDFAiURpT1olX7HsyQogONNVOPYHdWAHLUZL4gW6qH1Bg2+9G19axEQL+jcFE4T1
 kNL7fE1DjGYtt+Riwk+d6kkUHeITz7e/vswt1Hqg++0oSBeupA==
X-Received: by 2002:a05:690c:60c2:b0:787:f755:5ae5 with SMTP id
 00721157ae682-797a0ce7ab6mr38711657b3.40.1771066575179; Sat, 14 Feb 2026
 02:56:15 -0800 (PST)
MIME-Version: 1.0
From: Mykhailo Kalashnikov <mihal.kalashnikov@gmail.com>
Date: Sat, 14 Feb 2026 11:56:04 +0100
X-Gm-Features: AZwV_QhIq3MeSwFtZwMis-nNk6ik_7bileeN_GoTxTk4AFFQGI-Q_u8U-3ouN7M
Message-ID: <CA+PMN8Hwsb=kNruwNcctX8LgcVqbUkPi52wQJu7ppu9VKamAyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Add "pixel_encoding" DRM connector
 property support for amdgpu
To: wiagn233@outlook.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 16 Feb 2026 08:51:46 +0000
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

Hi Shengyu,

I've been testing your pixel_encoding patch series (v2) on kernel 6.18.5
with an AMD RX 9070 XT (gfx1201/Navi 48) and found two bugs where
PIXEL_ENCODING_YCBCR422 handling is missing.

Both get_connector_state_pixel_encoding() and dc_pixel_encoding_to_drm_prop=
()
handle RGB, YCBCR444, and YCBCR420 but are missing the YCBCR422 case.
This causes YCbCr 4:2:2 to never be applied =E2=80=94 the switch falls thro=
ugh to
default, get_connector_state_pixel_encoding() returns false, and auto-selec=
t
picks RGB instead.

Fix 1: get_connector_state_pixel_encoding() missing YCBCR422
-------------------------------------------------------------

  case PIXEL_ENCODING_YCBCR444:
  ret =3D (info->color_formats & DRM_COLOR_FORMAT_YCBCR444);
  break;
+ case PIXEL_ENCODING_YCBCR422:
+ ret =3D (info->color_formats & DRM_COLOR_FORMAT_YCBCR422);
+ break;
  case PIXEL_ENCODING_YCBCR420:
  ret =3D drm_mode_is_420(info, mode_in);
  break;

Fix 2: dc_pixel_encoding_to_drm_prop() missing YCBCR422
--------------------------------------------------------

  case PIXEL_ENCODING_YCBCR444:
  propval =3D DRM_COLOR_FORMAT_YCBCR444;
  break;
+ case PIXEL_ENCODING_YCBCR422:
+ propval =3D DRM_COLOR_FORMAT_YCBCR422;
+ break;
  case PIXEL_ENCODING_YCBCR420:
  propval =3D DRM_COLOR_FORMAT_YCBCR420;
  break;

Both are in drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c.

Tested with amdgpu.pixel_encoding=3DDP-2:ycbcr422 on the following setup:

  GPU:     AMD RX 9070 XT (gfx1201 / Navi 48)
  Kernel:  6.18.5
  KVM:     TESmart HKD402-M24 (DP 1.4 in, HDMI 2.1 out)
  Monitor: Dell AW3225QF (HDMI 2.1)
  Link:    GPU DP 1.4 -> KVM -> HDMI 2.1 -> Monitor

Without these fixes, the module parameter is accepted but ignored =E2=80=94=
 display
stays in RGB. With both fixes, YCbCr 4:2:2 is correctly applied and
confirmed via modetest (pixel encoding property value: 4).

Thanks for the patch series =E2=80=94 it fills an important gap for users w=
ith
DP-to-HDMI KVM setups who need non-RGB pixel encoding.

Regards,
Mykhailo Kalashnikov
