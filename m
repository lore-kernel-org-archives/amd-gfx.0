Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67A5C624A5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 15:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37ADD10E211;
	Mon, 31 Aug 2026 15:12:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p1mD17yx";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0227A10E211
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 15:12:03 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-cc1cb48db3eso390362a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 08:12:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788189123; cv=none;
 d=google.com; s=arc-20260327;
 b=eDAqeAmC7Do/4fgGPeSqFYCH9VayoWuT5ZfZOPfb6w35lL0YmFFiO/TdUv3LbjD/tr
 Wg4N1655X76j5Z68hxw9YrLRblzTEBKZiV7SWIvjkcEvAIZ3J4ANqs7Lart1lPvE9Xnn
 RsegJcSnIk1bLbiJlPLk2lg+diebGIAY3wMhQR7+ENhw2/qTlRpIbyMMQzJQGJWbA9n2
 R8lJnoyU2NjqpiTbm4hjLAFmtqvglrEsGEhOq+bAiTDZTW7Kv6/Mm4gMipDdqtD55d1j
 Pn1S20MU3jb+7+CLVKXQC4oM9HFUIbwFa3GuHT6MdTAzDSnIV9Q+0xgRzX8L3YfwKM0B
 Wyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bU/p4LQuVp49PubOCZU3/XcXzDJhNDNay2ZcTvCxHKE=;
 fh=o+xcdZqtsV+hweoMyXx7yDR29gwxAAHiM1joBJOFz+Q=;
 b=SUhlFYYs4CUwMrymXnrja3+1TE/P85jJfDObpTv5uW6EL+oWdNIBrwCMBLX9ADKOFD
 1PUjBNxq67MzJH4WJLAwyjLLXEmLHkC10wvrK3ahOt9+pWzjWVEzHzx24tDYqWHNJl4i
 QaW5uVwbFjx57NLlH95oB08HQF93DVyPnSQxh152+SKaYeY+SZOgkuGmxWyfAtTtgS77
 yyA5tORBUyGihgVl0APE+K1wsplIgnVTVbNI3nT+UnT5yXfzIIGcOufW7YdqmIR9d/bl
 ud4hqCV9qnPEs9VX9QYHuE3OgAu4+0Z+SplUmCdXdWuzzvrbsTcNm2NuC2OfW2bGd0rV
 FLRg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788189123; x=1788793923; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bU/p4LQuVp49PubOCZU3/XcXzDJhNDNay2ZcTvCxHKE=;
 b=p1mD17yxTUSEh5AWsarNHMlQEoQZGOQCLQo/Mx7tEmg7iyFudhLBKYtpkB1DOaeSGM
 GBhJ1ZPqLpTOIlkU4uzs9o+tp80n3qh0a6dF/6sXduNj+1stMhhjgRaPLoP8wXuq/bZo
 0rXSRFqhNcEMl1Uru78BDIQrFbpdu0SvftrwVReRItb62mBN2kY8YiHp4SGcW7VA8nXm
 K2P3hem0xBsv/XL/QQJGgP/ewSHXZ2d1xpYsOe6j6CJyZAqKIqyFcyfoq+OQCN8XP3XN
 77MUB212ymv6U/0/IEW3QE8jl3Hfbx0TAv5YIoKcLT+/r4N9cIOokKH8FwkkbQavEqME
 AivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788189123; x=1788793923;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bU/p4LQuVp49PubOCZU3/XcXzDJhNDNay2ZcTvCxHKE=;
 b=PVwsnCYq/3amhdonmuWgMxl4BtzT+EtesIVpqjx9/nyUrQwVWYEb6ZVwvizseRCFbN
 UwOvd5WROlcm9cUp6SlEloFNk9jgDG2S+CUigHECqg21VwxY6QjOnFz0oBhkDTfPbEjg
 nFU0f3cnr4oeh6tW+oP8KWcqsUUjON3blovpHw85AAnOEUG5qnAnloJCrKIVwURvaJKh
 F3pemSlurpiadyMcEyccArO73cMTg9cTPtnDVyUpBGPt26xoONYdBKWAwT/aSuO8av4N
 ukKk++Dzhx9i2GDJpX7Q4uyp9L9+LXeu7riwV7z+khlRMhyLaA4bkQMPGQ1C/s2G3Qv1
 qQzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdDPvd1cDq3dMD3scmaPUijvFCfXLTfgB9DFaIpeJqIZWUPE+xbu9e8GVQRb5vbhQY13GWEFQF@lists.freedesktop.org
X-Gm-Message-State: AFuF++npXO7ktPfumNN1Yyh+c0yq/wP0mPjvVXaEDfsEX8Oyn7RBlxjt
 YLNYhC0h7luiRCaeNonTBs42EA+h9oxVgdDgJf9d+7IcmGBzUHwN1pS2i25onqNp4yOBLd1F/Wg
 mGTNIKq2Ez34kDA8ISV8C7tQRenop5WciRw==
X-Gm-Gg: AYBFou2PM1mgkwdDvAKOd0bjTHumNeCJQbo0EqFS9I655LDfkaIe2julbcZmagpZpB9
 KGPOIBvBKzyuEmvsvomT69DeZmmJd24dC5qFUzeFIKQYf/X0+UgFuv3aIA9mmZs8KOKKSRU/9JW
 AJ2cDCPTAPLO7j2+dLwRqRxKO8d2kxDZdQLngKufCbQ3/t5eeMXHdwMhRv6osvMRuGq+FxWCeGT
 heg2HIZv9zLI4cSyRNub+gs7ZQEzosx2DSBRJbMvTQR4gYPJ+L5jPa12Ba24PL0Ucvn5gFMPVy8
 eodK2aLP3X+/YIOliD/kdQq16GpNPQl/reOJelG91B7dA3X8v8lqVV+B+SKNYGNo4zFgjPi9OhP
 b/cYl6p518SZPtJc08Oz5/eJQzxukTjY=
X-Received: by 2002:a17:90b:3e50:b0:398:bac0:238d with SMTP id
 98e67ed59e1d1-398bac026a5mr13798473a91.5.1788189123270; Mon, 31 Aug 2026
 08:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260831150211.1486154-1-sunil.khatri@amd.com>
 <20260831150211.1486154-3-sunil.khatri@amd.com>
In-Reply-To: <20260831150211.1486154-3-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 31 Aug 2026 11:11:51 -0400
X-Gm-Features: AcwNN1WBk3gUMGBXX6fUXwJCrg-lCKSyC2W9yahylHp4nECBDMOrYiIyqmjye5o
Message-ID: <CADnq5_PnhBHs_aSjLKP+DDz_0DUUUJTjvq8+d257hzGfdNsxxw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/amdgpu: add the fw check for gfx11 missing ips
 for uq
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Mon, Aug 31, 2026 at 11:02=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com=
> wrote:
>
> Add the proper checks for some of the gfx11 variant IP's
> for firmware support of userqueues.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 2c160ec9dc57..ca142c69cc28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1670,7 +1670,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_bloc=
k *ip_block)
>         case IP_VERSION(11, 5, 2):
>         case IP_VERSION(11, 5, 3):
>                 /* add firmware version checks here */
> -               if (0 && !adev->gfx.disable_uq) {
> +               if (!adev->gfx.disable_uq &&
> +                   adev->gfx.me_fw_version  >=3D 3090 &&
> +                   adev->gfx.pfp_fw_version >=3D 3190 &&
> +                   adev->gfx.mec_fw_version >=3D 3450 &&
> +                   adev->mes.fw_version[0] >=3D 147) {

We should verify this on all of these APUs first.  I'm not sure if the
fixes have landed for phoenix parts yet.  We may need to split the
checks for stix vs phx depending on the firmware versions.

Alex

>                         adev->userq_funcs[AMDGPU_HW_IP_GFX] =3D &userq_me=
s_funcs;
>                         adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =3D &user=
q_mes_funcs;
>                 }
> --
> 2.34.1
>
