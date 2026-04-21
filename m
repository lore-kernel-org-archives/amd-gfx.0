Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE6DF8FA80
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 14:20:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5927910E8CB;
	Tue, 21 Apr 2026 14:20:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FxRfIfNM";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EBC010E8BE
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 14:20:45 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2e92c54bab4so267395eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 07:20:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776781245; cv=none;
 d=google.com; s=arc-20240605;
 b=WqUn8DawaqhN02WI+8IbtPpHQsSLqCs3qzVpzOpTgIs4TDpQK5GmVZ7tdCqMLtJyTa
 QCqJ8UshlR0vpzQnKt1BY7BQLN11qzVwOUZ335vkJJBDrk0NfEyyA+1nrxnT+4ryOfmA
 WG7llEsePCD6enMD0sgI0wX3qGDR5N/5x7CStCmCAMt511u46wWx6ncp7BrnMc3IY0Cm
 SpgclBVXedKPBw4ryxqMA6h7jmRf1MKRfCjbpmA7zFXAJpc+ZEYu2fXVWsy7C7EzrW4n
 8hH/BVx/kN4YtoNaq9wbn7F46TPusBK6DYe1ek3pSPLoqm6RjaCDzCHXlrSROqyaq2WB
 UZ7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6ecIPKCl9xaMqTZ1iZfdRln8cLYWJAZ+Dy7s9vdXJ+o=;
 fh=E/SACSLIjJSza37UAEphhj5fYwKS3HtqNPhKlayxxvc=;
 b=kssOyFkk59lOHWV8YiTpd5up6cofcJWnS5hS+goJrZXXF5dp37uoui/dFwYhNMrdw/
 ZWBEuHOvVziHvYsMOwEw0CJru7IEtAvFBWllHfgBGZoLIz5m0ALlB/EVaZW/S6RtG96f
 VcnydBMZ4eDCe2G5JCRQXjY3Q1QLGOkZJXGMWy5eLvjAbuPtBZ1qF1hFJzwOmo/btMEE
 3/D2QLN05LGj49FrYswWop7kEa/Rh5ig82inZLWlyzp2uZqJlrDAB0Nvu8fgOeIu8OKe
 EmpECD4c+jQWck7c6xnNYAqxSCZ+YyDhzKbVyilRcrrENMexaIfUACWrL4ToDZ/Qoj3Z
 z0hQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776781245; x=1777386045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ecIPKCl9xaMqTZ1iZfdRln8cLYWJAZ+Dy7s9vdXJ+o=;
 b=FxRfIfNMLGgmndQalaNyq9CUcdApI7p7Zgh5MGig/dtiqLAHYGtO7m9k2VdrPBr0oa
 yyddAPMMVFJ/rNBfAhVdKyGfcR3tgb6YHim8nqH8FbKmPyeAbReWy4NQLGTg/oEeO/lQ
 Ezt+sxs6TEXdFmIS34AhyhXOyHACsvXbsk8vzJT1HzgDB3KY2v2qtuqCicmfW5dBtiK0
 uYQ72lSc3yzYX6qjn6rBNcM51E0OBFe33z0XIOc1jMU64wWR2zyulK6agP5WSY1ArLCP
 g4QNicC0RHHUatWehJA162+k+RFux6vjhjj3sjzj+EHxFE0HOPYmXmwZ0kmPOkwsVZt/
 iEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781245; x=1777386045;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ecIPKCl9xaMqTZ1iZfdRln8cLYWJAZ+Dy7s9vdXJ+o=;
 b=NT0MGTaYBUtFyZKIzB8lfbPfokiW7QnagKdM6Bg0lVCgVDunFOMRLD7sZlczxNSAOH
 F5nRHlNXzsY53Da48R3ByI2FNradbCi1YFoHGozvUYjYxee/1BgdBmGyXVWnKlHd84di
 AXEKlo8TpBREJW5SZhLSdMaAJ8lVaSatqkKVZO5rhYXBFOgsHkq402xwMnrP53Nxwz6H
 4qU+bAgIetUmnFgqqH3eZSVIJ6nws9ciZeTxNv9d+1r+2jmuCkNERwZWHWFt97QRIgEE
 SEaSYVHSc1Pa9uODP4+xn0YV6wpOk+e1L+hy4aHG0sXEpc+V1dPJyiZZlqNWdfIvMiv+
 XwFA==
X-Gm-Message-State: AOJu0Yz8CilmRKSSevCnBOwNE7iKHjcrwighljdJV6vqlsSIJeJ46PSo
 VnQpdQeg3PjAGLvGRwKzCG91GAZuKKZO94HovLkSIOHe+ofhm9fmaRKBXf4UucxzT6ase5CsVbx
 4DY4eVeoTpws3uz4EtOB6dRNdOYMExSOY6A==
X-Gm-Gg: AeBDietBSA90C9QVErmAOW1O/kiBGxbcQzt05NWgKxoA/h44qwL+1TuEiR+qEZMo4NP
 K6S27u5CuWzqEKProWhwrSe4eKF4AYMU3IPgD4SDsJE3SXM5Ubb+vbueQ584ZkLPi4fVZdiOs9S
 lxuxq8pLwLI3ZOnULAMFF8DWaHbn55+iMjoQunz+02DOhwzmrBoPK9o/yYhnCU0/4e9r0tH2ta6
 L0tzB0tnO3Jw6SgwAKUIKfs+qaq1TCAxp/nttmsN37ryCmmNoNV/MNODQyW1qQZGFY3Te2jpvGj
 AAUJKPr0u2uUpJOdA63oMyQcyn0MZwSmw6ivuyNM0aCNwMIchv7WxmvQpOUoDixpVioREdKFroL
 TUXxr
X-Received: by 2002:a05:7022:6988:b0:12c:8862:368d with SMTP id
 a92af1059eb24-12c8862379fmr1663675c88.4.1776781244504; Tue, 21 Apr 2026
 07:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260420235504.17998-1-timur.kristof@gmail.com>
In-Reply-To: <20260420235504.17998-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Apr 2026 10:20:32 -0400
X-Gm-Features: AQROBzD6zYjKlucSemxP8Npx8Z5QEDsattxTawfv_AEWLoiBo1NQbhDoKNivAL4
Message-ID: <CADnq5_P8f+uNO_roJR=qz9VY2rcFCCRkxHhWAZ+ddLW6MfW1uw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Disable 10-bit truncation and dithering
 on DCE 6.x
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>
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

Alex

On Mon, Apr 20, 2026 at 8:14=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> DCE 6.x doesn't support 10-bit truncation and 10-bit dithering
> because the following fields are 1-bit only:
> FMT_TEMPORAL_DITHER_DEPTH
> FMT_SPATIAL_DITHER_DEPTH
> FMT_TRUNCATE_DEPTH
> Programming these fields to "2" will program them as if the
> dithering option was 6-bit, resulting in sub-par picture
> quality and an ugly "color banding" effect.
>
> Note that a recent commit changed the default 10-bit dithering
> option to DITHER_OPTION_SPATIAL10 which improves the picture
> quality because it happens to look better, but is still not
> actually supported by DCE 6.x versions.
>
> When the color depth is 10-bit or more, just disable
> any kind of dithering options on DCE 6.x.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5151
> Fixes: 529cad0f945c ("drm/amd/display: Add function to set dither option"=
)
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index 19526a278b2a5..1ab76c2d0f723 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -5069,6 +5069,12 @@ void resource_build_bit_depth_reduction_params(str=
uct dc_stream_state *stream,
>                 }
>         }
>
> +       if (stream->ctx->dce_version < DCE_VERSION_8_0 &&
> +           stream->timing.display_color_depth >=3D COLOR_DEPTH_101010) {
> +               /* DCE 6.x doesn't support 10-bit truncation or dither op=
tions. */
> +               option =3D DITHER_OPTION_DISABLE;
> +       }
> +
>         if (option =3D=3D DITHER_OPTION_DISABLE)
>                 return;
>
> --
> 2.53.0
>
