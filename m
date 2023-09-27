Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F3FE82CA1
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 18:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F350110E591;
	Wed, 27 Sep 2023 18:25:17 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7666B10E58E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 18:25:15 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1e0ee4e777bso496619fac.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695839114; x=1696443914; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PdaQVqPVOwBqMwEkV8r+K9MrUoIWrnVkoTig6ijVtlY=;
 b=g/dg9S762ezSwEFn+5/MKyu/fVYQESeoJvxwWnAsoDPBtWRzk7onz0D+5IMVLEZPfY
 NTz/jerDaDDvhAusUNLzXDCiMa1bxkIghDi0xhGfteo7yhe6J/i4zHp+DFzSWgqrhWhg
 c8al1IlQL30kKJPhbH2PSVTuQe73xRJBht4ipJM5qAdvE0rO4+8YVufRVFucYoGp5GBH
 vN3+mJn/58F6B/SKGbeKVuOLpm+uCobUStddckmR0D9ZQsd5kvaoOnRq8E7qXNW8k+uK
 Fhp07Rxp3eRxDIoOKz3zsoM+5XvUI7UPTr5AoN64CVlkinmSlV1tEgjub4d+Bvb9PHOW
 BqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695839114; x=1696443914;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PdaQVqPVOwBqMwEkV8r+K9MrUoIWrnVkoTig6ijVtlY=;
 b=woexyGft6Z6nFIyjzIujDJL02Uco234RCWLnbgCEovAqychRhEhCq27vwlC/Fvb1r3
 ujPWE4HydSWfppZdKuZsFBrLDPpuc7P50F0gJqG/Xnl/eP9j37gW1EAXYUxMz++RKmnk
 HQw/44A628492EEr5U6GWEWirR/msFB4/McxDjGCbKVuexjHrI3qllxxPE4aZtKdDLbb
 SSLP/s8D1hhxzqOTqjQx3uAsRhRjU1P+iNhxoz9kd/V9S8rkpcGCNdieVkxz7SfFh1+f
 q10K/b/DBeXN1uF04OzsrIWjqSKkHoPARKiFo+NZxDd7oJucig66a62ZIg+h+4q+piCh
 P0RQ==
X-Gm-Message-State: AOJu0Yx4NcwJEpcl7pqIsv6oUiqG6CauIyFmwMmGR5hMoGTAiLeYJ6KR
 LePLhJNmeHQGcvh+ML0xJGqDG72jOqoCU7bUYjE=
X-Google-Smtp-Source: AGHT+IE6PAwvovE+oBqPGxiDmIMvQIxjjIYxcWeXR2G5DVIN9PesDgCJs5rXc/tGB3WoFOt0+LzasGsoBWmgVgKM0H8=
X-Received: by 2002:a05:6870:164e:b0:1bb:fa96:ae0e with SMTP id
 c14-20020a056870164e00b001bbfa96ae0emr3429903oae.22.1695839114583; Wed, 27
 Sep 2023 11:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230926123741.280030-1-mario.limonciello@amd.com>
In-Reply-To: <20230926123741.280030-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Sep 2023 14:25:03 -0400
Message-ID: <CADnq5_PtgEDqe8HCtm5cm4Xu+5K2hjtGDx7Hg2JUifd=+2jC6g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Move `enum drm_amdgpu_ta_fw_type` to uapi
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 27, 2023 at 2:21=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Enum values used by the ioctl `AMDGPU_INFO_FW_VERSION`/`AMDGPU_INFO_FW_TA=
`
> are not exported so clients need to keep their own copy of the definition=
s
> while looking up firmware versions for the TA.
>
> Move this to uapi instead.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 12 ------------
>  include/uapi/drm/amdgpu_drm.h             | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ucode.h
> index ae5fa61d2890..73a84af54d70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
> @@ -145,18 +145,6 @@ struct ta_firmware_header_v1_0 {
>         struct psp_fw_legacy_bin_desc securedisplay;
>  };
>
> -enum ta_fw_type {
> -       TA_FW_TYPE_UNKOWN,
> -       TA_FW_TYPE_PSP_ASD,
> -       TA_FW_TYPE_PSP_XGMI,
> -       TA_FW_TYPE_PSP_RAS,
> -       TA_FW_TYPE_PSP_HDCP,
> -       TA_FW_TYPE_PSP_DTM,
> -       TA_FW_TYPE_PSP_RAP,
> -       TA_FW_TYPE_PSP_SECUREDISPLAY,
> -       TA_FW_TYPE_MAX_INDEX,
> -};
> -
>  /* version_major=3D2, version_minor=3D0 */
>  struct ta_firmware_header_v2_0 {
>         struct common_firmware_header header;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 984fc16577ca..225dec3634f0 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -912,6 +912,18 @@ struct drm_amdgpu_cs_chunk_cp_gfx_shadow {
>  #define AMDGPU_INFO_MMR_SH_INDEX_SHIFT 8
>  #define AMDGPU_INFO_MMR_SH_INDEX_MASK  0xff
>
> +enum drm_amdgpu_ta_fw_type {
> +       TA_FW_TYPE_UNKOWN,
> +       TA_FW_TYPE_PSP_ASD,
> +       TA_FW_TYPE_PSP_XGMI,
> +       TA_FW_TYPE_PSP_RAS,
> +       TA_FW_TYPE_PSP_HDCP,
> +       TA_FW_TYPE_PSP_DTM,
> +       TA_FW_TYPE_PSP_RAP,
> +       TA_FW_TYPE_PSP_SECUREDISPLAY,
> +       TA_FW_TYPE_MAX_INDEX,
> +};

Prefix these with AMDGPU_?

Alex

> +
>  struct drm_amdgpu_query_fw {
>         /** AMDGPU_INFO_FW_* */
>         __u32 fw_type;
> --
> 2.34.1
>
