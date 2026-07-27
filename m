Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD420C531D0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2026 16:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 637E510E474;
	Mon, 27 Jul 2026 16:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P8DhfUDG";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0C210E474
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 16:16:49 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3856d4015e0so228150a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 09:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785169009; cv=none;
 d=google.com; s=arc-20260327;
 b=XoNgNyNgbhfeqj7jL4t7xVnABotSow2jPRl+YhCawujNCTaRt1OYdWv8KVeipAXDZz
 EWtxeO3MsIbbYZtEWD0RhXStNX/aUUh7Ifk4enM3UQzwgMBC8PqelhkFOOiGWrHHa5rj
 4Mf4C0uhKcNv/XLRwwXzbBdwXUlEC+DALWNOp3L7LI060kqgEWF2NhbeMphHvTeBQoxY
 xMuRV4mBymVR03frcUmiwN5+SEq1WxOHfGSy5e375HtmlLaJnwC26xFvjnIlkuHJAgCi
 aOHFithFZPtSsa2GHa7joFRs+gSFkbPYF7EBn1OmnDWzMDRqiFtedIcyyifMFIDnXjXv
 ZZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XLKcVZtw4v4H+d2QYfNZy8/ekK4kFOJ8RM/AcAcmDVA=;
 fh=6jdE0khLQaWCKkuH0uk30oA+ZViv0FRgQb0JGyzrF2U=;
 b=caKD01DsLydfsP6lbjIiI2ohledznWql15mfk/sgtXh4KYZYpYnTVU8Ez9MaBdx67G
 yj7Gi7UtD4JNGRRE26y9AdsvK3FNRP5MMDARwohYTqj7Xh3OYAiGtWbEY/ZtkYgabvu3
 AsJ/r+PS6/F3/j9JwvTe8d+vOPn+UroOT25per353+lxGn4spRHOI3MKfm5UWx8ipHgU
 g67wH9AfNSLOv/R+MM1Q6MlQYnJOtv1scMINfQOYZft87Mog0tOE2Ft/OaEJb/q9L+A7
 rxUKIldh5jb3TUZr2ZyO+quNgeOxcF9IILFpcpiQGca+drB3hL2/tYhqz3/xR9UKMCGw
 ui5A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785169009; x=1785773809; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XLKcVZtw4v4H+d2QYfNZy8/ekK4kFOJ8RM/AcAcmDVA=;
 b=P8DhfUDGngJ+7i2gT/RH+fT/ZyadE32iXnGr42VKDjwJ3cMukZlNh8Fbw2ZoJKAdmP
 CfzTrCcdg1NxTm2ywikO/P/fg9HU2QO8b7cygHoCFMR4BeiHx0GUbG4dNwmVsbPoICZn
 8vYD1pbJr5Tco+dWiJzHquVs2isdBbEKdDdj77NIwdzeURRCdDnJ36JzuQ77Kfq/xOme
 nFGhTMoHBao2av7zswR+sZ/WOgF/g7u2XiBzLE4i1Qd8BzeQCdvBMbeY1cPTFeFXKr5i
 0JLF/9OGw1SFXRXvD73p2ktIPhT20XgDdeT/dWhBI+sn7Q/nxk6vPSkJYNkzUoK9Bxb0
 aZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785169009; x=1785773809;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XLKcVZtw4v4H+d2QYfNZy8/ekK4kFOJ8RM/AcAcmDVA=;
 b=Qcq4gv2WrHcAd2K1A3HZlCJO/P+2SRWUiOjoLMxOleTmMANH86VXOzeIXLHjGpiUu3
 IkiZ0MZcMOJTmsl6QqcvKI789s4HhGt8Cd1L33lk99j1k9DZmBzBhfE9on7RiyT04wxk
 GwnmagQN0pZ3J3Wlo9Njd5+lMd18P5afo+TwubhAL+nOKizyfxBWOzLbWpCge7nNmYJJ
 ViqQKYccJiAAlJZBQFAwW/7TUET2GlYPfYP3OEFpq9mvwUKGrtN0HloKwLuz/YYy82Y2
 4KpaugAMt06y/BseXjT6nJK7g3LSrFs8Xtj35bwaGVupDokvrt9q+xqlNiugqBZaudGo
 HLWA==
X-Gm-Message-State: AOJu0YzG99rdvkAJ3Jpc+caQK6BYBsekNk62qnV2Fu6BIQMi3s8Uyfl+
 O+sKRrZ/sW8Uw9u2vkBv+xdco4jSBn/efZwPZ9LE+Ix3V4Lwq8onxLyyiIr04PGK4Lwkz8e6eif
 ltmwht0dhmMe4TqI/WbVA1yBF99xw4UYgTA==
X-Gm-Gg: AR+sD12JjXd30iy0jhUm4Hthn4gU7vh4hiVmPm2oVu74dUqvxQuW3THhNd4uymMohYn
 fkNNt6eKXf1ezNLpqoGV4eqWzjnmy2AIzYu7zxk4nm7P49SYns/tVpfr21TDFO2rhJdQz9gJdDN
 33+QHi2QiHB7CJ4FUkvfC9yuyPOOcgtGbFRyfzxUwtaas77sKzKXBKVsA4jJbPxj7LsngH3zZ65
 +C5ReVRYu63zKGs5X0JTdfh0QZ0UCfXV9YdcaCEXlcl8whWNgeK1Q68z9Lg6rgwgX9NRLn/B7YD
 JzUzB55j2EixkArtSQPhmu925iTfZl9b+0uxZ6/uBI028UKO
X-Received: by 2002:a17:90b:3dc8:b0:37f:eda5:516f with SMTP id
 98e67ed59e1d1-38f6227e724mr528147a91.0.1785169009238; Mon, 27 Jul 2026
 09:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260727160126.9758-1-reiver@improbability.net>
In-Reply-To: <20260727160126.9758-1-reiver@improbability.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Jul 2026 12:16:36 -0400
X-Gm-Features: AUfX_mwEho9ZpCGUpUhjJYnNDF3bmRVKVgCzK2f-PRffS2GJOCcMIE93AvARe68
Message-ID: <CADnq5_P02gJeoHQ3aTrFdRAymFoYnxH_m5tf1VPWvDdmLCdxMA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Silence link_dpms I2C retimer failures
To: Alan Swanson <reiver@improbability.net>
Cc: amd-gfx@lists.freedesktop.org
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

Applied.  Thanks!

On Mon, Jul 27, 2026 at 12:11=E2=80=AFPM Alan Swanson <reiver@improbability=
.net> wrote:
>
> Commit a4f01bf729b2 ("drm/amd/display: Refactor and fix link_dpms I2C")
> had also changed the "Set retimer failed" messages from DC_LOG_DEBUG()
> to DC_LOG_ERROR(). This unfortunately can create log spam.
>
> Change those back to DC_LOG_DEBUG() only.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5520
> Signed-off-by: Alan Swanson <reiver@improbability.net>
> ---
>  drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gp=
u/drm/amd/display/dc/link/link_dpms.c
> index 335ae952ef..1f7060ed49 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
> @@ -384,7 +384,7 @@ static bool write_i2c_retimer_vga(
>
>         for (size_t i =3D 0; i < ARRAY_SIZE(vga_data); i++) {
>                 if (!write_i2c_retimer_offset_value(link, address, vga_da=
ta[i][0], vga_data[i][1])) {
> -                       DC_LOG_ERROR("Set retimer failed, vga index: %zu\=
n", i);
> +                       DC_LOG_DEBUG("Set retimer failed, vga index: %zu\=
n", i);
>                         return false;
>                 }
>         }
> @@ -405,7 +405,7 @@ static bool write_i2c_retimer_byte(
>                 return true;
>
>         if (!write_i2c_retimer_offset_value(link, address, index, value))=
 {
> -               DC_LOG_ERROR("Set retimer failed, 3g index: 0x%x, value: =
0x%x\n", index, value);
> +               DC_LOG_DEBUG("Set retimer failed, 3g index: 0x%x, value: =
0x%x\n", index, value);
>                 return false;
>         }
>
> @@ -421,14 +421,14 @@ static bool write_i2c_retimer_byte(
>                         if (!link_query_ddc_data(
>                                         link->ddc, address, &offset, 1, &=
value, 1
>                         )) {
> -                               DC_LOG_ERROR("Set retimer failed, link_qu=
ery_ddc_data\n");
> +                               DC_LOG_DEBUG("Set retimer failed, link_qu=
ery_ddc_data\n");
>                                 return false;
>                         }
>                 }
>
>                 value |=3D apply_rx_tx_change;
>                 if (!write_i2c_retimer_offset_value(link, address, offset=
, value)) {
> -                       DC_LOG_ERROR("Set retimer failed, 3g offset: 0x%x=
, value: 0x%x\n", offset, value);
> +                       DC_LOG_DEBUG("Set retimer failed, 3g offset: 0x%x=
, value: 0x%x\n", offset, value);
>                         return false;
>                 }
>         }
> @@ -449,7 +449,7 @@ static bool write_i2c_retimer_setting(
>                 uint8_t value =3D settings->reg_settings[i].i2c_reg_val;
>
>                 if (!write_i2c_retimer_byte(link, address, index, value))=
 {
> -                       DC_LOG_ERROR("Set retimer failed, index: %zu\n", =
i);
> +                       DC_LOG_DEBUG("Set retimer failed, index: %zu\n", =
i);
>                         return false;
>                 }
>         }
> @@ -460,7 +460,7 @@ static bool write_i2c_retimer_setting(
>                         uint8_t value =3D settings->reg_settings_6g[i].i2=
c_reg_val;
>
>                         if (!write_i2c_retimer_byte(link, address, index,=
 value)) {
> -                               DC_LOG_ERROR("Set retimer failed, 6g inde=
x: %zu\n", i);
> +                               DC_LOG_DEBUG("Set retimer failed, 6g inde=
x: %zu\n", i);
>                                 return false;
>                         }
>                 }
> @@ -492,7 +492,7 @@ static bool write_i2c_default_retimer_setting(
>
>         for (size_t i =3D 0; i < ARRAY_SIZE(data); i++) {
>                 if (!write_i2c_retimer_offset_value(link, address, data[i=
][0], data[i][1])) {
> -                       DC_LOG_ERROR("Set default retimer failed, index: =
%zu\n", i);
> +                       DC_LOG_DEBUG("Set default retimer failed, index: =
%zu\n", i);
>                         return false;
>                 }
>         }
> @@ -524,7 +524,7 @@ static bool write_i2c_redriver_setting(
>         );
>
>         if (!success)
> -               DC_LOG_ERROR("Set redriver failed");
> +               DC_LOG_DEBUG("Set redriver failed");
>         return success;
>  }
>
> --
> 2.54.0
>
