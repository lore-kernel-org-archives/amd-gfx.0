Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FEFE9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 13:43:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F63010E5BA;
	Wed, 18 Feb 2026 13:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kghikySw";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13AB110E5BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 13:43:53 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2bd5658b901so1989eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 05:43:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771422232; cv=none;
 d=google.com; s=arc-20240605;
 b=RDwukh3Hd6r0pxXF2Ibm5fSmBkI16hPWVJ0z4oMEDDOXaWTxZjCJpzqs9oVh3bEEDX
 gK253+qcGNkTOoEc9eHXaD+cGXzhVcCAe3pg5u7MhyPN7vYFuWS3k56os41fH2vNxI2l
 zvCuZcZc/6DQD3l0zceXIZwQyIGT3nn/xmWfJWgIOKfe1joX7rn2ENfMQqnuewVALcew
 d4GnmrRW3HjPhWMzt0m2oLIUKcJdnyjQW0Dpwkyznjs7mRWwWTjzHxwot9q1QgGcGLlv
 dZBqnAqmBho9zwH/OGVQA/4irAFGrl2Jr6XMmW9b6X17dlvM4tL2B8LW8WCp1Y4B4kbj
 p3sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZsTOq2yjOZ10TqAAZzbF+iH5liO+jEK8mhwciq3eeMk=;
 fh=sN9lHjfQgBY6fORl+AnBCHZUFbjxtDik1bv+B/xT3Eg=;
 b=LWO3vNJmjDxfVhU2k+016lZqH/vclh2x/1NPGhSVqqTroaOdQMFZzQVhvMEEtS8jwC
 tq1LwnOETv3aDJLm7uKI6sCF9pEktGIcAhP+OWsMhFsNJFMjcHG+gn6hwympuDM4aExd
 vk5f11Ttwaa0DF+O3PH9dwVR70hIszQoiLMFXA+QSL7xqlMDOhf8ByZCdRGrnjEYL4EO
 AZ2ale4CTnorpfHBRWQwpvj6mT6PiGNP/8PEH63MvdiQ0WB5+Gsp/hk89MePIGNt6ciz
 Zho9XLE/JicIyEbZZmp85lsB1M8s5skP/IQY/h5gItdAua16XNScpbR6ubewFlxLiLRD
 a1sg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771422232; x=1772027032; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsTOq2yjOZ10TqAAZzbF+iH5liO+jEK8mhwciq3eeMk=;
 b=kghikySw4y7M09TZ1L3r2izRAV2WeVtDZBKZpXbLi7WdfbA41hFjfkNvZtISw/jO3s
 8IjOBNEGA2vub2v84bJFJNUaRp/uwUk/ohgJErn9KDkjDYsjgnavHDnrBHjVqIeIyn2Y
 ZHuR6tWQkL3HBV7joEy5TgrNHCyxnTXABxp4wFzwr+5DNSdUDL+loonB1GBb4Ys0E7od
 4xQqE23KRlyTYDa4iz/sBVuRNNaTgC1xa5lbeWGACGRlv//jNcyhAzMglT85T0AWtqZY
 W3t8AvDUAvUCyBkFBZlGHdBiJPmzb2mSFVcjsXwGgm+aJhZOEtBJ+doEmybWdPCn5Z/X
 qWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771422232; x=1772027032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZsTOq2yjOZ10TqAAZzbF+iH5liO+jEK8mhwciq3eeMk=;
 b=oPeCodEVHk66Ur4mn1GMM2ie0nJFHnKDd9Ob/637OANTOoMST0xq3R6ZfHUh4WeiWt
 aPUiLtV07bCMGgLcyfgTtWrLv/G3d1VAeHV4c857twMNh4ftLMPy2tRGrgqQhVmhCcJ/
 wU6BKbGObsbUlCNyza6YOyAq3CqoTzz/w0cKEmIHKyRGVQ2lo7XymCyaRYJOltfu9kxh
 Uq86Iw/O9CGs5Zwn4eD8yHa0YvEIeuQIkjutX2JyWInugkIIGVJ9PMHHQ4MyvfTxb92E
 1QJoIplxdRGH8tfebR6gM8QC4T6seDmP2A3BKahqABjQQlWZHcSESiBeY+ed84+Mt4ln
 p0QA==
X-Gm-Message-State: AOJu0YxErDwMKF6o57Nnx33U1rK3pmLAo6XAG11WqaaGz9kmHF20z5Cs
 75Kz2e+4GhLAkkSXz87mQ9FLt6PNebKrCXHMu50fwbu0gx2OjBP3j0GYJhNxWPVV8ZQpBkm3qYq
 6kq9qs/SWVxwQ8QBNx3twxr8Z9bRXLOU=
X-Gm-Gg: AZuq6aJBseVXN90MWU7wZG6/et9A3iXUAMn5g91j2GUtGHFzwh+KOnqelkciuT7KAS3
 C9GSAPJ3U6uxgOebiSBGkKn42zdDDNIKUMT7KXFvNPUg7rxIQ8UZ43gtGMaHPPZTOFCCxo8YKPs
 mAKoZ3NFDQZ/tND9suQpvp/kP2oinDa6RwtOwpWAD13r+izgyQF21AOj4YVE5zB1hzQwulFSCso
 hn0VCX0+ASXh66LpTWoIHTI51185rUVZoW0utrWnN7m0tnKVY37oQAF8ftzsyXh1mmqRKZxLMYu
 Zo1INEDm8Ss1CEwnz6OogYBpqaybBKdOTkF0xTZrno/eP/CM/IXRkiSS3zRcPe5Z8BIzng==
X-Received: by 2002:a05:693c:2c93:b0:2ab:ca55:89cb with SMTP id
 5a478bee46e88-2baba0ae6b2mr3950854eec.6.1771422232130; Wed, 18 Feb 2026
 05:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20260218113832.1312089-1-lijo.lazar@amd.com>
In-Reply-To: <20260218113832.1312089-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Feb 2026 08:43:40 -0500
X-Gm-Features: AaiRm52c4L8gFZsw-w3dSGkMKD2WRgFEySLFPHxwtqGM3zCSI3fyIV3O4GKinUE
Message-ID: <CADnq5_Mnguf99uqP165PK7_HQ9VB+dBU7oA5z0QxJddKps5URA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Print full vbios info
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com
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

On Wed, Feb 18, 2026 at 6:49=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add build number, version and date to the existing part number print.
>
> Example:
>
> [drm] ATOM BIOS: 113-PN000108-103, build: 00159017, ver: 022.040.003.043.=
000001, 2025/07/27
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/atom.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdg=
pu/atom.c
> index 371ee82a8912..cc5b6ea7f6d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -1462,8 +1462,6 @@ static void atom_get_vbios_pn(struct atom_context *=
ctx)
>
>                 ctx->vbios_pn[count] =3D 0;
>         }
> -
> -       drm_info(ctx->card->dev, "ATOM BIOS: %s\n", ctx->vbios_pn);
>  }
>
>  static void atom_get_vbios_version(struct atom_context *ctx)
> @@ -1520,6 +1518,30 @@ static void atom_get_vbios_build(struct atom_conte=
xt *ctx)
>                 strscpy(ctx->build_num, str, len);
>  }
>
> +static inline void atom_print_vbios_info(struct atom_context *ctx)
> +{
> +       char vbios_info[256];
> +       int off =3D 0;
> +
> +       if (ctx->vbios_pn[0])
> +               off +=3D scnprintf(vbios_info + off, sizeof(vbios_info) -=
 off,
> +                                "%s", ctx->vbios_pn);
> +       if (ctx->build_num[0])
> +               off +=3D scnprintf(vbios_info + off, sizeof(vbios_info) -=
 off,
> +                                "%sbuild: %s", off ? ", " : "",
> +                                ctx->build_num);
> +       if (ctx->vbios_ver_str[0])
> +               off +=3D scnprintf(vbios_info + off, sizeof(vbios_info) -=
 off,
> +                                "%sver: %s", off ? ", " : "",
> +                                ctx->vbios_ver_str);
> +       if (ctx->date[0])
> +               off +=3D scnprintf(vbios_info + off, sizeof(vbios_info) -=
 off,
> +                                "%s%.10s", off ? ", " : "",
> +                                ctx->date);
> +       if (off)
> +               drm_info(ctx->card->dev, "ATOM BIOS: %s\n", vbios_info);
> +}
> +
>  struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bio=
s)
>  {
>         int base;
> @@ -1582,6 +1604,8 @@ struct atom_context *amdgpu_atom_parse(struct card_=
info *card, void *bios)
>         atom_get_vbios_version(ctx);
>         atom_get_vbios_build(ctx);
>
> +       atom_print_vbios_info(ctx);
> +
>         return ctx;
>  }
>
> --
> 2.49.0
>
