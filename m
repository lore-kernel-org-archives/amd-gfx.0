Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359CCCD4F4A
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 14:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A781E10E88F;
	Mon, 18 May 2026 14:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="isxrgDVA";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D797710E88F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:28:46 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12c87f1f8c8so122600c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779114526; cv=none;
 d=google.com; s=arc-20240605;
 b=fefr1GpTu2ATDE0LoiTl7FUq57Y7AeOKeaJGCfdnBO8bfCueNpIF67Up9gJAnUxSQ+
 5C5R6HWHPqnYQTA/PqgFnSfLKzhFatzqiszpRnb0wk0smCfvY+2tSbPJjpHX9i22XI5P
 TiOI9hzH+3nwnZlRVDRy0s0SUQwlAQsgw3RXwo2yDbzzjXJtMxGgf3T3TscEwpw2F6ID
 KGYI23yijKvMt451m+vAStrrkN4ls4abvCSi0bVPo4Y7rP4v51o/c/sPChY5ewR77WGk
 nf/1wVTZUtBW3YTYPChvmQIE6BRYpwsKR0Vbr7v4EzGnHrhKhOH6DBd1htuvaqxuEExb
 gOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eHp6HvgnAYfucxMy8r/T/zzkHFjLcckBg5P5ZMn7kls=;
 fh=uCJ+Cn59moqhZgX9T88H24gKBHNH+vwyf/9HmOLRarE=;
 b=PFuQZyByA79JDmGYB8OgvWCjzMbvB/MmplXGodeCOkBXfN8fkFxQJ+5xP1/KQ/5H6M
 NX1J3FbUTla//lMe6rdNOvMMW88xqkI/JjayTA00nC/4segcDcUGJUzidZc1yHw/0EG4
 57kouTOmqjIjPmKBQdpyX07rTINYTGnZuBxISVLHaQWTOJRsCewFMsa5Um+2R5T0CBQH
 RJ7nEG/KCyzGStzlWFgy2UDu1fPwsHS/2PZedO87NmuPTnjxl1QJX5DAegUAaCAl1HR7
 X9o4jDGDyxFD6+UZmFdm7X8UqSBRGtMAz8/o4ree7DgPEcKasNjilmeUFEfjXODDlWlT
 EeQw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779114526; x=1779719326; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHp6HvgnAYfucxMy8r/T/zzkHFjLcckBg5P5ZMn7kls=;
 b=isxrgDVAGDI1xylc1f5PZf6Nh2dAQ1PxcSHBTwJwikU3PCDZR1VOeO/z7/x3fvixjL
 RiavIaQyRQg6QRXCOS8QwxP7KmEz8rWqROyZ8Hw78cnm2zpnHc/HoOK1Jacy5AT/S5aB
 GpgDqlkMwt9STNdBNk2a1xRo1EgocKY3AZiCaiIm4kMFTE1okSocO7QDGoebBzmsLfPr
 m+HylMsPdfIY9adrpv4jeJs0C8w8OWEM17myIbCGPIkFDGSFb1ESMr3vDobcG//CDBaU
 vpjkCO88tP0tcCr26dqirEOmOWYcxcMP398hjWVf07iAJkOMFB3y3rfN1fQt+0GRCCpC
 QJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114526; x=1779719326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eHp6HvgnAYfucxMy8r/T/zzkHFjLcckBg5P5ZMn7kls=;
 b=YkJYmJkxFKgU+o63n4tIs3nV0UZus+uylfdAMdAgDsS2J/+b2PHfaeowqitOAh1XAm
 j2uRTrIEWkjjXj0s75eDgQMsCdRWydfFncRzMkAdbYPRTSbjEETLf9mSemXrJlRIu1Nz
 NZ/8kxt10Aa2iYysNOJyM2k/48xkHYO8w/oHKUCosD523G9KFEfTitaypO3lyRPVIUx9
 Lc1wu/5NQ9193xjN8hYe9GH5S0G28SkB0TPGDXeuvDIC/DsDYUPbLYsDYRztvZRZJW4H
 9jfLvAwAQFgfNS+WN1xabEOi000HcbEPVhts2WGF/bbPqAg4y818CizcPpnALMxTkAQy
 OQOA==
X-Gm-Message-State: AOJu0Yx4jpIv2A054peL2y/IIi3ljw8lW1XOf2cOI5GwGlSOFgfvMPrf
 l7xbmriHCxlUpN/68la3b4/gq3ZZq72PvP+XqH1cXSDxR/uEi5ua0eJ7XDkPbfCPjhYmOFq1XU0
 RIuTrWJbdASL/WpOZm0CCgncRg78GqN4=
X-Gm-Gg: Acq92OEDwLLDKyI7kHNMV8Ia8pm176IsEw9eOFZAMhNMlJ2nvyZjrA9yWud1EZSNX9T
 zU5ScrSX8tZPuX7QxDBk7qoj+87FrukKwhv+cDL94SjIC1URh0d5WJC5nLY1Y9mJdKYkcBdRsFj
 Z4P2nUroqXPDS5ugkGL0wUcdtZ1UC2EkHYSNQj15mt1kFtopBuAWYd8mRvTdb9DNRzVwVQ3Tv07
 znnTpBxMjEAJbgXdibKlCx/8NKX11GiAQwV7afTY+xar3igS3tmNDjezxBJ6/Yo7dmIfkDVNgJo
 zBP2dcqBCobVMnvP5F4WCuUf4iFXtI0OGsey03bhra6kdQnPolE+U5CoFbQybqharlDy0Q==
X-Received: by 2002:a05:7022:6994:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-1350483f16cmr2766421c88.5.1779114526072; Mon, 18 May 2026
 07:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260515091054.529610-1-arnd@kernel.org>
 <bcafbc27-9556-4891-94d1-ab81f707c127@triang3l.ru>
In-Reply-To: <bcafbc27-9556-4891-94d1-ab81f707c127@triang3l.ru>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 May 2026 10:28:33 -0400
X-Gm-Features: AVHnY4KEVCIFY2_WxOsoSrUG1gkZy82u0MLyGhmUX6PfRdrzTgyibhro0RIu6Yo
Message-ID: <CADnq5_Mv1ZFcGDx-3gX9CiDCCQgn3=HA9POcBu59umkjrScXJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon/evergreen_cs: Add missing NULL prefix check in
 surface check
To: Vitaliy Triang3l Kuzmin <ml@triang3l.ru>
Cc: amd-gfx@lists.freedesktop.org, Arnd Bergmann <arnd@kernel.org>
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

On Mon, May 18, 2026 at 6:29=E2=80=AFAM Vitaliy Triang3l Kuzmin <ml@triang3=
l.ru> wrote:
>
> 'evergreen_surface_check' is called with a NULL warning prefix when
> handling potentially recoverable issues or just to compute the alignment
> requirements, and 'evergreen_surface_check' is called again in case of
> failure (with the correct prefix, as opposed to NULL), therefore, the
> initial check must not print a warning, because the surface may be
> accepted successfully after having been corrected, however if it isn't,
> the final check will print the warning anyway. The surface check
> functions specific to array modes already implement this behavior, but
> the 'evergreen_surface_check' function itself doesn't.
>
> This is also supposed to fix the "'%s' directive argument is null
> [-Werror=3Dformat-overflow=3D]" compiler warning.
>
> Fixes: 285484e2d55e ("drm/radeon: add support for evergreen/ni tiling inf=
ormations v11")
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Vitaliy Triang3l Kuzmin <ml@triang3l.ru>
> ---
>   drivers/gpu/drm/radeon/evergreen_cs.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/rade=
on/evergreen_cs.c
> index 3142ef4da7f4..9196f85db9ce 100644
> --- a/drivers/gpu/drm/radeon/evergreen_cs.c
> +++ b/drivers/gpu/drm/radeon/evergreen_cs.c
> @@ -312,8 +312,10 @@ static int evergreen_surface_check(struct radeon_cs_=
parser *p,
>         case ARRAY_2D_TILED_THIN1:
>                 return evergreen_surface_check_2d(p, surf, prefix);
>         default:
> -               dev_warn(p->dev, "%s:%d %s invalid array mode %d\n",
> -                               __func__, __LINE__, prefix, surf->mode);
> +               if (prefix) {
> +                       dev_warn(p->dev, "%s:%d %s invalid array mode %d\=
n",
> +                                       __func__, __LINE__, prefix, surf-=
>mode);
> +               }
>                 return -EINVAL;
>         }
>         return -EINVAL;
> --
> 2.43.0
>
