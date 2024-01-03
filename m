Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D887C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:40:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B01F10E32D;
	Wed,  3 Jan 2024 14:40:38 +0000 (UTC)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16DF210E32D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:40:37 +0000 (UTC)
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2044d093b3fso6857827fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 06:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704292836; x=1704897636; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1i8+U5CzXInZW8ALoVN1fQ9mlAoBZK6FYHu3ipdjuLM=;
 b=S74gbF0U7jjtTFfheFhwNr6c7t81IBe77+I5aI6ySxoxQIKfnGrWH9QNUiX9AcaGdE
 3OgC279NBeZWk6h0nT/V6VLDTD+NBuYjTwlsYnyo7lsdGiMYr+CVUj/dkCe4BZoaELgw
 PWqA+EV2WUqn1lqf6/+essXOC4MAo+TQeE4liZLb6/rf/vePkwaNzpktCzO8YYMgM3OZ
 8BFm0VJ3utKUMqsUGauaZfyprrOeOYLTOgT+50LS1ehbn7cLvO57n/bDVVqgWd51QWpp
 38Zummu9j5sxHwTt8+D6s4cxirRDFU3pTGZRcEXkKad2tRJC03E2++sJS0pGGxC2wIbg
 LBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292836; x=1704897636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1i8+U5CzXInZW8ALoVN1fQ9mlAoBZK6FYHu3ipdjuLM=;
 b=OvlYgbxUqIxE8jxizRFpqk1rtgxHmz/bj1f3PsivpA0ztX6uItKxXlpDNfNU75ktI8
 16wr/hUDAEbMx7TF2NaVPUrc6uWUJ3HQxiRNEKQ6TqZvmiWkLrgWstMWLeNM9bLTcaZF
 YfejINrzx1q0UwaCRoylP+V4uKnBjaL99JvmmC2DeVVIHRtg7NSZc0pDYZyBxdR0YQkc
 eXFUUCVCHI2ry/WHVl81GeSnSk0UGco0DAJfltnlV8kTNy83QtSbpFv5S6sKFWRI7nHJ
 brBqXB4AJbjtMz0JGnETpSo0KzGpMAKlZ3NDrIMjIQbrXJAqWcJgZqL5WGIBxmu+Yrsh
 tSXw==
X-Gm-Message-State: AOJu0Yzl/Or1q8JrSVt1fCbkHOwO4Zq5FhUGq2/G2tI6bMEwAqOKu2fX
 +20qbWiRJ470bs62zaO0lT+K+kCE51pa1MGQ8bw=
X-Google-Smtp-Source: AGHT+IFIh3EYtsQ+1zBWp5E2MXZRzu/TdP3UUuzuFS02WDpnbBUvI945duyKW4WJNxNsraomG0Oe4XG5EmwHAuFrgJ4=
X-Received: by 2002:a05:6870:1693:b0:203:2253:bd8d with SMTP id
 j19-20020a056870169300b002032253bd8dmr24217449oae.77.1704292836247; Wed, 03
 Jan 2024 06:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20231229174156.1800-1-marcelomspessoto@gmail.com>
 <20231229174156.1800-8-marcelomspessoto@gmail.com>
In-Reply-To: <20231229174156.1800-8-marcelomspessoto@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:40:25 -0500
Message-ID: <CADnq5_M31u-qhFbBoaDN7C_oaZzoyn=EuDSdHBjREMSghv58qQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/amd/display: Fix power_helpers.c codestyle
To: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Fri, Dec 29, 2023 at 1:20=E2=80=AFPM Marcelo Mendes Spessoto Junior
<marcelomspessoto@gmail.com> wrote:
>
> Place define macro expression inside () in power_helpers.c file
>
> Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com=
>
> ---
>  drivers/gpu/drm/amd/display/modules/power/power_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c b/=
drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> index 1675314a3..4e8af166e 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_helpers.c
> @@ -31,7 +31,7 @@
>
>  #define DIV_ROUNDUP(a, b) (((a)+((b)/2))/(b))
>  #define bswap16_based_on_endian(big_endian, value) \
> -       (big_endian) ? cpu_to_be16(value) : cpu_to_le16(value)
> +       ((big_endian) ? cpu_to_be16(value) : cpu_to_le16(value))
>
>  /* Possible Min Reduction config from least aggressive to most aggressiv=
e
>   *  0    1     2     3     4     5     6     7     8     9     10    11 =
  12
> --
> 2.39.2
>
