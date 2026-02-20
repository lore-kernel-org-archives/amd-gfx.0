Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70797C561F8
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 14:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3C010E7F9;
	Fri, 20 Feb 2026 14:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CsglhUmS";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F265F10E362
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 14:19:16 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12739fe9a0eso173658c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 06:19:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771597156; cv=none;
 d=google.com; s=arc-20240605;
 b=Tb+VxxFulYFYJy28YIuPMLTYf9j+7npseplAIe5r3bKPQpe24nIkN79lnB0J6QAJZH
 w5JD9/MiyUw4R7zlrusGdvLIVUNamLcBa2PDPQ9fBMtOR8Dhg8y0ozM1tpX3DAXHApzp
 y47tVAb7CCdXgEtm0785zBK5StuiGDM09ovXrI5wNjRIyf9JL8gwqj107bPuO2r7AMOp
 edEav+VumUzAaC3pP+EvTPQxVYFoZ3DD1HFWA5co+XRiNwFuW5Uq3yecnZVAR45H55uY
 Z48z2X7dWUTpWWG6TPCYkKn1RWHGtcx2gV4LfdZWRVyVNGxZWeHBnSC4vM97qqzjpCkB
 8edg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aZXJQAQrVXxCJ/WykTcPSLUaX9IEzIdYJjcXqC2BPoI=;
 fh=fRgywwe9yaXcO04jDD0WIqYxK86zogMkBb9hsQGvfso=;
 b=b3vkGzeABnrbj58cibSrfxHG/I4xHeBI24K1euu8Bhsdg2ClUpkRkNYWLelBkh4HT3
 17INqBRYava6hXOks9VyWal/qXEm5ShrpUb+UKnT0WC4E08M2/RheNyoxPE8axJ1+/tt
 0ZM3IIUE9mmalTmXNRSN6vBDtX5LocBxj/aPS8Y34fOxN4k8Xtf5icr/1SYrealJfj1B
 IRGk7Cg2mvVRqYVuxg7PCrDkpx9VPKGM0kxxHq6aqeJ5kJLNDT5+oHcV7OqBLvdiKM0D
 DOCCgP71Ex5gVOVkKKe/q5zpCMvMAwYPCk0TkO0U98IxLsE58ohrSDdL6T2eqsEDBJEo
 uutA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771597156; x=1772201956; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZXJQAQrVXxCJ/WykTcPSLUaX9IEzIdYJjcXqC2BPoI=;
 b=CsglhUmS/+z+tQ2yvW1dPY6xNuGbXfxOZWdQx5k4kdEhG4d794HqqqQPd0oiHfELOY
 zn8vcZmRygtTzdEY32XFdfn3SRfhQ468R8/EdWluOn3JXjHy990BU1B6vykvWESpRHqB
 Tf1mk36ZWq2vzGXQ9r4ARIeFDOvrBi6H5NSr9faobO96vJ1tuYTEL2aSE0RNw79y8GGt
 qZn3SK9gm8Hd7INp8PnTiMBvrCIzMCbkiof6I7mdhH66+Nxu/h+nMvSZsgG+krqwVXdN
 wzZMoNHz3Vxy+tLcQ0NbeCeSZ5XCMtJnaierXrhCzdpI9bbpP6FUeahfEIfbJVIIYL6C
 UvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771597156; x=1772201956;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aZXJQAQrVXxCJ/WykTcPSLUaX9IEzIdYJjcXqC2BPoI=;
 b=C4msKf+nDAoWEoRT8g1G247MWaIXXSRu/L410x1wraCQm855V7yGAusKIsToUIlykz
 NjvRS5cgqWQ+K9jjbFDA+w1IgyhUvvWzA5Uni26jokTgf2QgP1727/9rpVwGbPDCV9Zm
 Bm0ljs/ThfDGEblSwZEoTrZ2skQWTCrzAP/6fBMC5aQ3ALmc0JzmiLbL4+tdZjkvpHY9
 Otuqd2fkPBKOPhwUFrZwi7cvnkqkQytGk/IsdD28n6mODnk3DHCxewbwVPms/MCchFdh
 I85Nqy7A1eymDo9ILCvvx5QWV0mQYCc0XQJQzI1oQhi/HxCSlM1g5TK4JJ7ltmOGUyJq
 FMJQ==
X-Gm-Message-State: AOJu0YxbvRYkW9uJOLH00fpRvEPJ/DtPOi0+LPqLHDRpstJEZATyTCBt
 OZzywumeTcN30qStvpdnTO6XOebsN8+xseH7UiYct0tXqXjnYNonA0z0QidrujA4S9TcmfO4wHS
 520O+eNtVPR/tLJBB7Jvtf3TTcj3oPLE=
X-Gm-Gg: AZuq6aKW6+o9l2lQw7Bt7Cwewl7iqTaNTsrVXfXT2cq9MaZyuoVEkhMV1em227HriNx
 t5kzsaZhodVd8d5iFxXrYwp+V/EcwDQGFXrRoRLnFQYWzROjCEOddk12xsHYdGo2rP36Gy+EmaV
 p9IFO/aEQZ8msfRhNJIFeJylu+xBfyPl5ZP9mSFqxpGla9mWYctnv8PUmkizCuXSnAKVlQhT0DY
 9NLBkeWJ2+8n4ddbT4YNb7SPGRXd8V+ZCb0VT5expVPSBoD8FXgEiKEMxltrIr2o0v/JkWxWTm6
 uooMfv1mxGKaLaB7VOh6WkZb+KKH8gODjqxMSq76l6+3ihrYfvLm99LeXqV1+7tKHzNxqw==
X-Received: by 2002:a05:7022:221f:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-1273983ac5dmr5234784c88.5.1771597156047; Fri, 20 Feb 2026
 06:19:16 -0800 (PST)
MIME-Version: 1.0
References: <20260219160224.1976043-1-alexander.deucher@amd.com>
 <20260219160224.1976043-3-alexander.deucher@amd.com>
In-Reply-To: <20260219160224.1976043-3-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Feb 2026 09:19:03 -0500
X-Gm-Features: AaiRm50CsP1mHJz6hwDXWWEf8gKdec77OdqvK3prMkWQXys57TB6KPVlfs4pHyE
Message-ID: <CADnq5_NQpwi2Yz_eOQXa4ip1Drw0GbB9_QUWxVQbSYNH-CPutQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amdgpu/sdma5.0: adjust SDMA limits
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Vitaly Prosyak <vitaly.prosyak@amd.com>
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

On Thu, Feb 19, 2026 at 11:02=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> SDMA 5.0 has increased transfer limits.

The current limits are correct as is for 5.0.  Dropping this patch.

Alex

>
> Cc: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v5_0.c
> index 52f4e9e099cbf..0b83598cd9980 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -2041,11 +2041,11 @@ static void sdma_v5_0_emit_fill_buffer(struct amd=
gpu_ib *ib,
>  }
>
>  static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs =3D {
> -       .copy_max_bytes =3D 0x400000,
> +       .copy_max_bytes =3D 1 << 30,
>         .copy_num_dw =3D 7,
>         .emit_copy_buffer =3D sdma_v5_0_emit_copy_buffer,
>
> -       .fill_max_bytes =3D 0x400000,
> +       .fill_max_bytes =3D 1 << 30,
>         .fill_num_dw =3D 5,
>         .emit_fill_buffer =3D sdma_v5_0_emit_fill_buffer,
>  };
> --
> 2.53.0
>
