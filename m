Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D925BD6CFA1
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 20:05:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FF0010EA8F;
	Thu, 22 Jan 2026 20:05:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rdeobuu8";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66DA10EA7E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 20:05:41 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-124713e4244so51565c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 12:05:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769112341; cv=none;
 d=google.com; s=arc-20240605;
 b=gch9azJS1g7S5T7OqCFcZ9KfybNpT0pI9HbsG+S8ZXVqco7rkSkfQ0wBpDqnADHqbO
 KNH8XxvAFCdWfbz6rEUnoIHrk6tv6ZwMcMh/P6Md3bgiibH8FzVb3APGNFZ+ijyDJw/W
 YF7FhFIaW3QxQ2toXqwzzTDgEDX7pVWG2ZyWiNJuym3CG6jn+BXUcnr4OXsSDfnNX7U8
 sSxN/W0Tz9ORRfZx0he/ppdRVEGvF+joFP2NncILPmkxw/yDJZaAqMBDGYIUlwb4W6rN
 hmtr+acUX4ahFjP24OGNYn4D2rTyx5QE2qkJto0EJ4f6Xe5+tHSmXRhUzWrxWL6ZqsY5
 S9Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OLlk6nXR5M23jwKocik97n5gyjP+RTFmt1pJfUomvu0=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=MSGALwVVZaz5OSVruS8Ih65/tkNZY7DvTKQNwfG1JFWKhPZxOIWMbvJ8XA09OJ1GF2
 P5XKL1CmOvlY8rWgkRB5heTb5/847Juo+bKHK5IvtFhkln+QESDCRJZ0WoAteVs2EzJX
 7Znz+LTEsI9X7VszxPBkJ82TSAURz+CfXBNH6HZE0RPAOkAx9+Fi/FS1vmwEIcQDI9HI
 OY83GgaashHdMYVIVpuopxO0SR1vFw2Pzueop0F5GwtFV1eMFjrDsexpP+/1FWDXEu2x
 dBkkb26+6JkZJTyHV2KMGjfi2CJvVNPTxDRU91dnBbwjXD67BYHjExj2/ysDUTX4NT5Q
 Q7UQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769112341; x=1769717141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OLlk6nXR5M23jwKocik97n5gyjP+RTFmt1pJfUomvu0=;
 b=Rdeobuu8R8l5RFSGUDpwgzVxvLiAyKdXPctdWGdh3yF1znlHBgfvQXtogsInF1p0b9
 5elSEk7BnK3fviLvqu4Fgn5v9XR2F9ygstigPPYAUlNR2WK1K6PDIbt/gnWA0P8+2xOk
 kQshM2Q2jKbSHAnepqyOT5kUA4IgLCeXCPUxyViJAUNTKzTd9dGFcPs41Z3iJrjvBK4I
 UgBn5iV8Ai8LZ8jHYOw34sbgWkqzgbpXi71LZZ65rjCBXZqEPIAAkc8/2rBNFoJ3c9Dg
 PDwYRA1XZdUsh5nPHRRhF4ehOoazgKgezStbmitmkCkbPLVvGOVaW6rSP2sD47/jpnWh
 cL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769112341; x=1769717141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OLlk6nXR5M23jwKocik97n5gyjP+RTFmt1pJfUomvu0=;
 b=K2tuesP/5WGzP9buIYgeBZGPfVFSw5KYwtLvZF8tTYwo3ZwJKBoEwVoBbPSy9nkMZM
 amYwC9KKY9jZb8vfaHowHs7wdcmwyNdyoJAmgM88UG0wnpt026uD8t9kDSdrgQFosFKj
 V1r2K3DtSA8rjq36r3ek3Vc1be/0vD+pvBmz0Icd1R1iK3h+kSsSJWGCzvcjfc43tlRo
 8owUqkzUg+L1DcIt+canQEijPxokSnu6VcVZlii5JhaGLUXjd5rFZf9DTD3B3SM64l5n
 MgyZ/eKDNny20gbMzCh9Ql2qrAP7fEZTDybG6blLbYdNUhtzPCj9CGb+RocHJX62tsFo
 5TMQ==
X-Gm-Message-State: AOJu0YxHaRgtZCnt0fFglg78V4w0Fso+sdDsDp8dC8ssPmaM4EvX/R05
 5PlGQYZkL3eCs9MQ7D3LjBbkvSE0ZXsTS2mMxtpARcoGkxsG+YCxQ3sOiV6nQeFwEQemAX1Hovi
 0/idKHhPQZxlk8XY7qwf+4Z49paT93uTABkFD
X-Gm-Gg: AZuq6aIQRhQvNpT4+4WbAmwFotMSr8/6FM0itsYknQpGUWcW0M/hhpoQMGYcttWHMew
 ra/HFRUG7HSokHWRyVn3TZTMCIFJvk+YbAR4jneycY9KJYW/PY1pxrYf0NWFJEwM7gJMl+7LNw5
 RmTMeavMcmGVkrc5RHkVob9eA4mREAuG2hRHzfQSVw+U0AC4u3LdJjHuyHtbDnv4cK/JyJr0ZSX
 hJCSxO1wHUyVgQ2XaX2ZNcrbcprKrkpBtr0xRAHhxeJrswHSGjwZZM9yDp/RZykXRXsS8mM
X-Received: by 2002:a05:7022:112:b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-1247dbae094mr169997c88.2.1769112341059; Thu, 22 Jan 2026
 12:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Jan 2026 15:05:29 -0500
X-Gm-Features: AZwV_QidYYHgnOSlsbcqHnOQAcG0hn3c2h0EE4a6iH_vlxt0GHBEgTrI60ZPMD4
Message-ID: <CADnq5_Pw1Fc_g2v7q7dLKz0dDWOP=8KZah9BZz+MQcPDrN4Z3A@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amd/amdgpu: Add update_mqd callback to amdgpu_mqd
 struct
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Thu, Jan 22, 2026 at 3:57=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Extend the amdgpu_mqd structure with a new 'update_mqd' callback to suppo=
rt
> runtime updates of MQD properties for user queues
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 11a36c132905..f997fa17e8bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -815,6 +815,8 @@ struct amdgpu_mqd {
>         unsigned mqd_size;
>         int (*init_mqd)(struct amdgpu_device *adev, void *mqd,
>                         struct amdgpu_mqd_prop *p);
> +       int (*update_mqd)(struct amdgpu_device *adev, void *mqd,
> +                         struct amdgpu_mqd_prop *p);

Do we actually need a new callback, or can we just call init_mqd()
again with updated parameters?

Alex

>  };
>
>  struct amdgpu_pcie_reset_ctx {
> --
> 2.49.0
>
