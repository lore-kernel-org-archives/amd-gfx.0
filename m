Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F30CD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 13:30:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E205110F4EA;
	Fri,  8 May 2026 13:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UiOqZgrl";
	dkim-atps=neutral
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A02A810F4D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 13:30:15 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-56f705e3e87so65994e0c.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 May 2026 06:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778247014; cv=none;
 d=google.com; s=arc-20240605;
 b=dJcDYu9gVVByiNc5f/ai7U8xYeQcgJLqeWPnNCgYWX/coD2GIHRB7sk50zHJU/a0ZU
 FuToavgwF0n7FFw4CQcKIHLjGbhIdhhLuNLgo3tDOyXOpcNMjgXcZXGGVt0vP0YAxADE
 /XPrY6lvXC5XQ8Fz62EWLQxIl8ut/Ay2pZoM9IClgE+wvVdgTiPVtI4GgmCLvw+tdpBe
 yCRATU5rznplwnCC9yw1RtNHPKRA/egeCIVDAihhKCtIjZdmRf4Vyd0cjpnHx4FH3UCj
 LmOz+v5T7Aa7Uy3cknY9S7WAQ1EmjboFzQ5Yx4fuclE9/yJ4bfhGE3UDO47rX7bjnLi/
 QQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HY6tLwcLbtGSbdMKWvwW03s7LqvUkLjr1vwCmWoFC+E=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=gKLL5LGXP8PtsABXImGlyMKHAjw8jSnaJz6h3W2RPYZMkoWvzdcSaW5DG+1XP17Xa4
 y0fwB2VFp1K3UueDYJ+gr0UBKMmbbW+TlgVsn1yuCi5lESVfBKqsoMJ62XaqwRzcIbNB
 /FttXbJuOQolmQ6JJmF3EdWx+aFh8G9GavxuT0XZa8RGi6KyCy6WlF68SzAMhYV7EMgh
 yoXm++8oJu5gVABFF4wL2u7FutKbsJVN4GRbISDgTE2oBQ5AiOlvZBYXGrABzVVa3H8g
 eUztDJ4SbILDxQVnYhdGsRkH+x+ylp05fkBFECTyk0ROjdN6/p2RaE+7BdnKWw8FllZZ
 v5ag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778247014; x=1778851814; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HY6tLwcLbtGSbdMKWvwW03s7LqvUkLjr1vwCmWoFC+E=;
 b=UiOqZgrl1ISTfJNF352/AlA0CqOeXWIHVuqKXvwYmBMkaNU2ToGdkoFzD9tPDpDaIp
 VMBZXpxpOV0lNvi7madimD5Yppa4Bv2u/W+qT0tnHNBH4r0UK+OWJMsLD7FlyAofrOqH
 OtJr4jApYs1WDZreJKSYPUYpf/gfI1zW8kpLE4FSRUbjBFuc+y/RT8igbe22YT0DLwJk
 KICuhcxFyVooGX9/5cLM03y+iRkDLUHmJX/WEdDSy0XMv+E13z38ZHdd0ky/AMFI8yIC
 jaypcHHYZH9Kztf9X/uhVyb/AGo/ZaMozSDLG32J2t/9SUqz9I79o8nfLQrA4Xn3Bf7i
 WzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778247014; x=1778851814;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HY6tLwcLbtGSbdMKWvwW03s7LqvUkLjr1vwCmWoFC+E=;
 b=JMInoIMe7VURgS1hLJGTEGATY+EEM1rtD7vFzwYJXSXylIWVtUDyJ6lwcpReJYZAQo
 vlSvTFpJn+xbFlUFi/S6i6cYm0wEvTL9hFDiB8Xy/hSaWCKDo+QaS5k5gf13Bqto9qSH
 xLKs+ItF0RQRfj1nKwmwovq3OTFXJ1Gv4vikL9jps7UM8hZoj9H1Rjwf907ihYHuB3KF
 xnsIHQjkg0j/iBxqO59tK7HTaPgOKHvZMwWXytD6afNTN6HXR5cT29rTcvmsmifwPRWG
 i9t+3+Yk78uLi8heImXOO+WyeBbFzE8ItS5Oc8XDX5K8GmvfUgh53yKQFliUUnhYtxx7
 WcUw==
X-Gm-Message-State: AOJu0Yx5FwePLugSwAPg5NPV0zkusjk5hxvW3vHHU5EeV8JtV3tOrbfT
 Uf0YQ2cs48J+gDdRtY3asCx0XFcucw9o63jNEb63+gdgqKIpEZDwdMdJwrbu7/zQKLdmUBUAPau
 arrVUzhDk1DWYemq2/YrZR2R9qw+vc+A=
X-Gm-Gg: Acq92OEWFEnQZjiLbosbFZ6KX8jhHMjBhVYBCC4/SeBsFZB6fhDDBlmuHvPowIWzXgD
 qoViBVBh+sBiZp5033sjH3Sw14bmIZtMljWGHFgX3Oa69ycVE306sQ0KOV0Xny/pJQEwOAUY/Sy
 dBaKnSrwxiFWoYNEIq092cZhKzSqsIy1W75kjtL/9+DDuxNmY+TUUTmdGhWNxMJ9xzGOJvWc1Xn
 Rrnod5gJWLSu5eA6GVbdsHkkgtJGwGOAFo8YqgDNUwEIFrDMz1OTsxzdjeRhxVq2EXt1RZr19am
 8Xm7loXtAmA6RZ0FmkcWD7fFZSvwHBp9Lm2KGiztXsltPFR4ospyXdW0JUO2dwUHkP55r1pGDbT
 q1J4A
X-Received: by 2002:a05:6122:889a:b0:56d:a70d:7f06 with SMTP id
 71dfb90a1353d-5755b0b591amr1951883e0c.0.1778247014422; Fri, 08 May 2026
 06:30:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260508071351.442816-1-Jesse.Zhang@amd.com>
 <20260508071351.442816-3-Jesse.Zhang@amd.com>
In-Reply-To: <20260508071351.442816-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 May 2026 09:30:02 -0400
X-Gm-Features: AVHnY4Jkr5Y3DC2jJVN7LnbZWYFH-o17a-ett4o6GAn5Qk3GPsZb1C_BbRH3W6g
Message-ID: <CADnq5_OEAX+J9X8FqVKhhM=w0ZtgHruuUY2Zfv+=pPdmZ_wRCg@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/amdgpu/gfx_v12_0: set gfx.rs64_enable from PFP
 header on GFX12
To: Jesse Zhang <Jesse.Zhang@amd.com>
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

On Fri, May 8, 2026 at 3:49=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> gfx_v12_0_init_microcode() always loads RS64 CP ucode but never set
> adev->gfx.rs64_enable, so it stayed false and code that branches on it
> (e.g. MEC pipe reset) used the legacy CP_MEC_CNTL path incorrectly.
>
> Match GFX11: derive RS64 mode from the PFP firmware header (v2.0) via
> amdgpu_ucode_hdr_version(). Log at debug when RS64 is enabled.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

This can land right away.
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index b866a944f878..f47928dcd848 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -602,6 +602,13 @@ static int gfx_v12_0_init_microcode(struct amdgpu_de=
vice *adev)
>                                    "amdgpu/%s_pfp.bin", ucode_prefix);
>         if (err)
>                 goto out;
> +
> +       adev->gfx.rs64_enable =3D amdgpu_ucode_hdr_version(
> +                               (union amdgpu_firmware_header *)
> +                               adev->gfx.pfp_fw->data, 2, 0);
> +       if (adev->gfx.rs64_enable)
> +               dev_dbg(adev->dev, "CP RS64 enable\n");
> +
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP);
>         amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0=
_STACK);
>
> --
> 2.49.0
>
