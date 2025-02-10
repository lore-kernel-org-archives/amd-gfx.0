Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C0CC02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 21:01:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F9BA10E3C3;
	Mon, 10 Feb 2025 21:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HsIRGYZQ";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB9B10E3C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 21:01:43 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2fa0f70bfecso1098475a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 13:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739221303; x=1739826103; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrxDhaMmD5KHDNiCU5os6ZvT3z8GUbjaXdloQGTdyqI=;
 b=HsIRGYZQcNUuTMyj7djICZC8omkH7ULhCncXKaq7toqrR1H+bQ0ku6HOh2mPGBf3QY
 fk4F4VsoOU7SuZcVYbkRzokhF2YWEYFFjRUC0sjo/HVNHO2KHlqu3AvlSNU+/seFbB9e
 YVLj23cM7Xjq7X/a1yIcmE88quWIRyPzGvb3FfKvQ5msSjn+Xl1qW7aDXkp31+nzLPRN
 BEtXjAew+NUk0oFqk5KVDscl3JTGLsml5jGR5sgo/KU2fRh0fs29f9yvZ0JRpSG4ktIL
 zBjQK6PEE2z2RzVXySqHarAtXmKfSmS90jODXWxmcF/iGwrkBZrLPdEApmSAuzcmub4g
 iIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739221303; x=1739826103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrxDhaMmD5KHDNiCU5os6ZvT3z8GUbjaXdloQGTdyqI=;
 b=uYY8QM3KHntsevpN+i7idNe/WFYACBWwBM5+Aj9zKZLeJl/4BmlulBEkQZEiW5zlzl
 1lZ9lCZv6DJ1kW3yEuSf+RCycF5555Uf1GbWNEf3S0ei7IIUhx59JyPnE3GPWuE77ewX
 CW37yXzoaiAQPL0oqLNSLzEEigqG2kgk6wotda6SbetRIiilv35e/Ip4cZtp4UA4EhjV
 CwbfuCL5y1chd4RhNva3/UtPGAzrU8hxRoQm15aACzlS07hJSIvvuW7Yw4YbE8uCqUts
 NALmbg27EcK7eoc+RpLB7yUIyruY5e3hXbRnlyW1aYU+Nz5kAbaiEFQYO75OiPnV6Yzb
 wkwg==
X-Gm-Message-State: AOJu0Yyl+6opGXLXRraDqDK49OVYena2va+U5a4xlwCG1DXennw6/eCP
 qD0QEQTjQn8hKbT7MJj6fYhn33WDE6F6NGiAVmPPz5mIzMlbfDg0eBA5lgYF9HN2ndM3fgsrPsL
 HYPrmkZrwXI2UIzTz/fjZ+YBywqo=
X-Gm-Gg: ASbGnctBRh4kq3PBTvRuqFhKPF0ybWjFnjiblZK+NCog5uhehKO81PdYgNX2LgGpnYh
 VGMEvuaHNHpNii0iw1zoW/ZguMPE+yurjCARtLsU7lRbHfjG+NdXo+/6MIysgtxBV42um5BEb
X-Google-Smtp-Source: AGHT+IEmHKmLOm/ZzFDSLVrQC+HaPk4mh2W1XEfQK9ABXJNSA9II5XhYsC+3zeq57JqEF7PbdAiTFeRkWXv0wB7jWQ8=
X-Received: by 2002:a17:90b:38c3:b0:2f4:f7f8:f70b with SMTP id
 98e67ed59e1d1-2fa24544c36mr9647554a91.5.1739221303161; Mon, 10 Feb 2025
 13:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20250205184055.104040-1-shaoyun.liu@amd.com>
In-Reply-To: <20250205184055.104040-1-shaoyun.liu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Feb 2025 16:01:30 -0500
X-Gm-Features: AWEUYZleBAFzch61xLUIdBsMD7NVK6B6X6qGn_UHd_UGiSncAz1N3pTqW0R8tQU
Message-ID: <CADnq5_Nrr=6LENgWUD8i5Q9fe=cNP34LNxsZUXSF4ZuM56v5Cw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/include : Update MES v12 API for fence update
To: Shaoyun Liu <shaoyun.liu@amd.com>
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

On Wed, Feb 5, 2025 at 1:52=E2=80=AFPM Shaoyun Liu <shaoyun.liu@amd.com> wr=
ote:
>
> MES fence_value will be updated in fence_addr if API success,
> otherwise upper 32 bit will be used to indicate error code.
> In any case, MES will trigger an EOP interrupt with 0xb1 as
> context id in the interrupt cookie
>
> Signed-off-by: Shaoyun Liu <shaoyun.liu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/include/mes_v12_api_def.h | 40 ++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/mes_v12_api_def.h b/drivers/gpu/=
drm/amd/include/mes_v12_api_def.h
> index 1938150a1943..fb918668ddae 100644
> --- a/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v12_api_def.h
> @@ -105,6 +105,43 @@ struct MES_API_STATUS {
>         uint64_t api_completion_fence_value;
>  };
>
> +/*
> + * MES will set api_completion_fence_value in api_completion_fence_addr
> + * when it can successflly process the API. MES will also trigger
> + * following interrupt when it finish process the API no matter success
> + * or failed.
> + *     Interrupt source id 181 (EOP) with context ID (DW 6 in the int
> + *     cookie) set to 0xb1 and context type set to 8. Driver side need
> + *     to enable TIME_STAMP_INT_ENABLE in CPC_INT_CNTL for MES pipe to
> + *     catch this interrupt.
> + *     Driver side also need to set enable_mes_fence_int =3D 1 in
> + *     set_HW_resource package to enable this fence interrupt.
> + * when the API process failed.
> + *     lowre 32 bits set to 0.
> + *     higher 32 bits set as follows (bit shift within high 32)
> + *         bit 0  -  7    API specific error code.
> + *         bit 8  - 15    API OPCODE.
> + *         bit 16 - 23    MISC OPCODE if any
> + *         bit 24 - 30    ERROR category (API_ERROR_XXX)
> + *         bit 31         Set to 1 to indicate error status
> + *
> + */
> +enum { MES_SCH_ERROR_CODE_HEADER_SHIFT_12 =3D 8 };
> +enum { MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 =3D 16 };
> +enum { MES_ERROR_CATEGORY_SHIFT_12 =3D 24 };
> +enum { MES_API_STATUS_ERROR_SHIFT_12 =3D 31 };
> +
> +enum MES_ERROR_CATEGORY_CODE_12 {
> +       MES_ERROR_API                =3D 1,
> +       MES_ERROR_SCHEDULING         =3D 2,
> +       MES_ERROR_UNKNOWN            =3D 3,
> +};
> +
> +#define MES_ERR_CODE(api_err, opcode, misc_op, category) \
> +                       ((uint64) (api_err | opcode << MES_SCH_ERROR_CODE=
_HEADER_SHIFT_12 | \
> +                       misc_op << MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 | =
\
> +                       category << MES_ERROR_CATEGORY_SHIFT_12 | \
> +                       1 << MES_API_STATUS_ERROR_SHIFT_12) << 32)
>
>  enum { MAX_COMPUTE_PIPES =3D 8 };
>  enum { MAX_GFX_PIPES    =3D 2 };
> @@ -248,7 +285,8 @@ union MESAPI_SET_HW_RESOURCES {
>                                 uint32_t enable_mes_sch_stb_log : 1;
>                                 uint32_t limit_single_process : 1;
>                                 uint32_t unmapped_doorbell_handling: 2;
> -                               uint32_t reserved : 11;
> +                               uint32_t enable_mes_fence_int: 1;
> +                               uint32_t reserved : 10;
>                         };
>                         uint32_t uint32_all;
>                 };
> --
> 2.34.1
>
