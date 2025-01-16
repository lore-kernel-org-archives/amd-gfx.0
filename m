Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AACDC02187
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2025 14:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADAB410E979;
	Thu, 16 Jan 2025 14:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MEOH+m6p";
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9203D10E979
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 14:03:38 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ef7733a1dcso209088a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jan 2025 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737036218; x=1737641018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xvJwQzVp3hDKrG1a6cOl0Ml0tD0p58J+JaoMZ4bveAY=;
 b=MEOH+m6prmHIZdEVgbZGTJhknorycVNJ0JchURCqGCBhYBCh0VRziz5hBGieGx7jNp
 u7wedl9JmhtR/BpoA3Lm1ShiJAkImPt3gVbONi/g0Rcdt7NRO804Dlm9TXgQbu95/7M7
 UKWyaeRXgQDVaTy7bouH3Rzqy36irzP5g7eZYNrb4mTMmJKQiR1UEYj3zM2264W/5Rac
 Mw4UUxAQlACZ6U7nfDcCBNr1zuyTEps+Pdb8UqrzBJVU0t58bp9FdYIcbBcTXlFKegIB
 7v1rt3I0pDeJ7LzoZtMPLryNyIfLvlE7xd7mRBHVXAw9SkMP38WerFxHzFrFaxPo0yj+
 OXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737036218; x=1737641018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xvJwQzVp3hDKrG1a6cOl0Ml0tD0p58J+JaoMZ4bveAY=;
 b=va77pKP/Wo6i4knzs/WIWJ6mA1GmLXQ0xvbxHwMWAPa6TLRmqIbRAk7orrTpCcK1c7
 HDNedBOblqq8hc6UQYgabLeoIi/vApEcqZERBf9IzOnAphRT8DRwfYNTxLimT+YXqigp
 +PKydVV5EWXvY2ijU/QG1DQRz6YMo7ZE2YEdfdQVUTmzF3L0GISl5k4FPVf+Av/1JeIG
 uwRgMiZTw4tgUPlFdJ8JlaKHRV/gkIIDEU19uvocgxLhuZZVxos+FyM6QRv/c/8NzAQm
 u2iMwbS5JzCO7QG0H6D2D71BUet8j8eeCzAr8C88Np4PiY3ImH189H3d2VvZSxlLMQc7
 mX8w==
X-Gm-Message-State: AOJu0Yz+25p/Y3IQVHPX2PBUoOzX+Py6LKG4ND34dWZPN+pXRampLkYs
 fv+YCq/4/Le0cJDbib1LirT13zMt7OVIXH69Vy6aGWuU3HqJzrGoqcmo4tWfOQQqjv8fClmTk/n
 dq7epOlUybH+RJrmI76sLQHp3WdyhjQ==
X-Gm-Gg: ASbGnctyxa6z6x3PtkLb7nr8Io5h0kKy7i2MCoI1ghxB3NPgJv0llcJVFteakxLsUxw
 cc2KPyoU9jSpI0s6mwb2vV/kkat6c1O2F5xPYDQ==
X-Google-Smtp-Source: AGHT+IEPJmRZtgcNwk8sms/8quc54SvgTYHxx3vX9gTMhgxb9VWStps8MXgN2FlLUeNtfkh/VG8CFaopjYQ8x+djCmM=
X-Received: by 2002:a17:90b:3bcb:b0:2f4:465d:5c91 with SMTP id
 98e67ed59e1d1-2f5490f77e5mr18458853a91.8.1737036216399; Thu, 16 Jan 2025
 06:03:36 -0800 (PST)
MIME-Version: 1.0
References: <20250114193715.3662180-1-alexander.deucher@amd.com>
In-Reply-To: <20250114193715.3662180-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jan 2025 09:03:24 -0500
X-Gm-Features: AbW1kvYsmGRNsdjYfJ6tc0FJBCxyEXw0UYpX3QdWrEk02ccFrGckyDRvN65NLBI
Message-ID: <CADnq5_OGyOfso3eA1XOtm_Lhpbfz04boD3SdQyXzQRzJS5vt0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix CEC DC_DEBUG_MASK documentation
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
 Kun Liu <Kun.Liu2@amd.com>
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

Ping?

Alex

On Tue, Jan 14, 2025 at 3:02=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This needs to be kerneldoc formatted.
>
> Fixes: 7594874227e1 ("drm/amd/display: add CEC notifier to amdgpu driver"=
)
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kun Liu <Kun.Liu2@amd.com>
> ---
>  drivers/gpu/drm/amd/include/amd_shared.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/a=
md/include/amd_shared.h
> index 05bdb4e020ae3..030d99a873a71 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -345,7 +345,7 @@ enum DC_DEBUG_MASK {
>          */
>         DC_DISABLE_ACPI_EDID =3D 0x8000,
>
> -       /*
> +       /**
>          * @DC_DISABLE_HDMI_CEC: If set, disable HDMI-CEC feature in amdg=
pu driver.
>          */
>         DC_DISABLE_HDMI_CEC =3D 0x10000,
> --
> 2.47.1
>
