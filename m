Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68267C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 14:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 982D510E773;
	Wed, 13 Dec 2023 14:19:22 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54CE110E773
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 14:19:19 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3b9e6262fccso4286001b6e.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702477158; x=1703081958; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNbzb+bqNXUneriwAc3xxBRVtv/cFxiNLClNRRnx0AE=;
 b=LJpprpwIAkin38I6Q0prQDdqQ3BpXpxPO/faR/Rb45jAh5bYYGmhZPD0Znj8JdjjyD
 9CG8wBlOfsd2kUpcZoKjV4ozsizRKbsTS8w2aR+l1TP8YGeHB4+NTywTGIOACmyM8TVq
 DEK/OpLDuz/WSQJTOUal0jEP5UXf7LmoUqeaMJDWJzXQKc70pHWDZjfkss+LFy+SHz3T
 Szrc/w9E0Lrfmah69LRDNsz5nyMr4Hq8P6cAEEovUzr8M52JpFfnHun23V3FYgqSwDG+
 d+XObbn5ql5Ot1DLfXuoyo3lYNkORPeDDGzg/zEmWzK5ypdhtMKZ1/WFwLDvXafdhJwn
 ZTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702477158; x=1703081958;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aNbzb+bqNXUneriwAc3xxBRVtv/cFxiNLClNRRnx0AE=;
 b=haFBJoc1R0dh+fpiDBcJz75P+Q/RKh2TiDO8JuLIefd/ByUuOoKD4HFK5v/iauaZjN
 z3XvyC+YwLvzhNSdGpRxCeqRv5bkXzDlL6VxH5xyw1Z336j+drGpF8VIDIw5dsdp491L
 4RBv3oYZQEqkEfGlzk+5Sd76wSWcb7PjIa9lDe2Aobh3B3YoqkXKIkMspjEgA0zPfT7n
 PaOWZRNgz+RbK7wI4hd0/mQgIi/Dul6/WgxYe1kOnmAGzJpUBOOfAfXwWphaxuFdYlfL
 qUOM/ALgg/7FwsRg1B6v9KoY8bnVdBEjlcyxMJ6+XS4pCc8ohZ+DCEEP37ofYyLA4DVf
 yUDg==
X-Gm-Message-State: AOJu0Yy+7bOCCEaYVOQPYHCd/Ll/rGlqksbtvWWFJMC0Y0kaTgyCKZHT
 s3JRE9u/I2pkddPUyBjBHRvGsQhMUAT8Q5bjU2O2JRsT
X-Google-Smtp-Source: AGHT+IGPM0Dk9QRZAjfqpjk4h4IoFmBl6Uf9gnnI//dWRQ3O870qE1ADugXKdL/IwktYVbcfyz1lf2r9iu2dj3Fipgs=
X-Received: by 2002:a05:6870:b99:b0:1d5:b2ba:bc93 with SMTP id
 lg25-20020a0568700b9900b001d5b2babc93mr10349923oab.13.1702477158394; Wed, 13
 Dec 2023 06:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
 <20231213061227.1750663-4-Wayne.Lin@amd.com>
In-Reply-To: <20231213061227.1750663-4-Wayne.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 13 Dec 2023 09:19:07 -0500
Message-ID: <CADnq5_PbodcizoyoLXm=mBbxMvi8unkwC7o=e=ggW-RP=LE4og@mail.gmail.com>
Subject: Re: [PATCH 03/25] drm/amd/display: Revert " drm/amd/display: Use
 channel_width = 2 for vram table 3.0"
To: Wayne Lin <Wayne.Lin@amd.com>
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Samson Tam <samson.tam@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, Alvin Lee <alvin.lee2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 13, 2023 at 3:40=E2=80=AFAM Wayne Lin <Wayne.Lin@amd.com> wrote=
:
>
> From: Alvin Lee <alvin.lee2@amd.com>
>
> [Description]
> Revert commit 8c5660987ee1 ("drm/amd/display: Use channel_width =3D 2 for=
 vram table 3.0")
> Because the issue is being fixed from VBIOS side.
>
> Reviewed-by: Samson Tam <samson.tam@amd.com>
> Acked-by: Wayne Lin <wayne.lin@amd.com>
> Signed-off-by: Alvin Lee <alvin.lee2@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers=
/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index 875a064bb9a5..fcd65a2057ad 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -2386,13 +2386,7 @@ static enum bp_result get_vram_info_v30(
>                 return BP_RESULT_BADBIOSTABLE;
>
>         info->num_chans =3D info_v30->channel_num;
> -       /* As suggested by VBIOS we should always use
> -        * dram_channel_width_bytes =3D 2 when using VRAM
> -        * table version 3.0. This is because the channel_width
> -        * param in the VRAM info table is changed in 7000 series and
> -        * no longer represents the memory channel width.
> -        */
> -       info->dram_channel_width_bytes =3D 2;
> +       info->dram_channel_width_bytes =3D (1 << info_v30->channel_width)=
 / 8;
>
>         return result;
>  }
> --
> 2.37.3
>
