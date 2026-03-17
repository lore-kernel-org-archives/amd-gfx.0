Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612A7FD876A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 13:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0524810E17D;
	Tue, 17 Mar 2026 13:23:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cI4eYp0N";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF37D10E17D
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 13:23:17 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-128edc72f3eso396519c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 06:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773753797; cv=none;
 d=google.com; s=arc-20240605;
 b=jZtgyjx/gACf5zyDfCIkvTP5DNecd5jJoKdfkvnQPCeUhsWUFNdq2EppJ239YTDZf4
 YGzhya45dwo9flLDu4Q7IDyQYml2s8lsJOUJaokkgQ8olUeBICEBpwybCdeJe/cXTKGX
 1wBlEbD3RAwHZKqtdmxC6xqwHs88dNcw89Za4HvPhPnZQToSzRq6uzzuDQbqUkkxrs8Z
 uKeBnJaeUvAmQclY8yVkPLNes9zLofixmGLpiRa44AFtBPitoBhOpvveZT3T+iCvpj66
 BE21cR/l7rQR/iUFMyszISmfOrzF1lpVKRzynuLBMuwWUbKPvCBL+lX0WsOhrcuhvRni
 PbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QmfkFN+YvKsA5XeLDWG2qXNkHvEcQ6ZQ6BCzFyPgejI=;
 fh=sN9lHjfQgBY6fORl+AnBCHZUFbjxtDik1bv+B/xT3Eg=;
 b=EYkKHDerQP1JC5UljatmkVGe9kHrGoZEcsYrRNI578NYiJA6xMkavTyFQQ+rAYgHwX
 y8ld7h2m2APzw6xstLrjcDmUqLP0A77SUHZx19Jd7511Lb6LUEMnOj5aBVDP5J27WYB8
 NNXiZhCeXayJ2k740pOYn2dfNqf5g0yENiQyHQyFUpfCqor0tZugFznpurS78y7wzPGr
 vPmiMVyhL+OkQDZs/VPqW5qqBApC6uPalZtC3vj0oYLlCX0OL2f53nVKVdBDSbh2lWzf
 SjH6oHe0b33EV4dR00w22SRJOWmiJv1YqMmQxF8H0snhByOmSrHaoZ6dBaMG5dSO8iif
 i7YQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773753797; x=1774358597; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QmfkFN+YvKsA5XeLDWG2qXNkHvEcQ6ZQ6BCzFyPgejI=;
 b=cI4eYp0NLdzC2B3ua0lZABmQAg9V0ORXbDJ+KvGAHNt92G1btHEscPBk317TcS1hyJ
 6FHqxuD8F0mvDusV14srfHGuhmAs8mKXS7ZKua16zSfVE88/Fp/BR9VgkXDrMdRPvU84
 ztX6L4w9aHoil+HLQVl7pcTPi3EPMcCk99wsNvsT5STXe6tU/ohjxMlWOgsyhMd/GXUs
 ky7qAQpobjLILqLRhHu4zp4SLut0F0456KI6RzF8G7+q/W5ePwH1H5LaM3MGmFaXoPHL
 toqZHT7+Ibu9gaOiWc76/aNxj/PXrMiynR20zLPY33f+mxb/Lf/U/ydxM+7CQE3LjRV6
 PVJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773753797; x=1774358597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QmfkFN+YvKsA5XeLDWG2qXNkHvEcQ6ZQ6BCzFyPgejI=;
 b=nPpIFnc/hG3y5rtbIkK4rsPwnmL60zKcKxXzinh4a6LjtO6kUBJ+XwA2OBdG9A4fPZ
 rJewmiyItbK0CnaP70Iv8qE/VNb6IyKJ0R6K/8UIn5XCDW5Xh541eE2Zs2W4BxNCIs2T
 rHNfg+sIEHtavmrKHUFNchpc+6Gqg0XtzNFp1IVWYAR+0DOxmkoQJ/x3edP4mK9tZ1B/
 WEZAGKDc6XUqriQ/WIyt9/CjKC7HHtHXWTivK4S3Za/I4pulI6j5wNmKs78k7kfrDi6q
 qaCaE572JH4DPyJXu2T3pJzaTm+Mdpm53hfrgmJ7qgilB9Wg3dt0Em5c6MnVedQ6CVJ6
 uQgw==
X-Gm-Message-State: AOJu0YwupVMrjS0DqV4bEIqWrfEBjMXBLGpZNXTKnK6fiSv5a31rcyfJ
 qyMbMMhuz1uJ/SjOxlVJUxcEeI4n+YgOvfNOnGlDZSrIm7SDsSM5iSwTs9kZYgtCcCjCI+iAKk4
 rCwbgCNZYpsJWosqk5djOKOJ0miFny2I=
X-Gm-Gg: ATEYQzwOfYfoDcD7ys/coJZqpnNcPMVhO923wPHv6LO01KLK18Gd5R2oO3p7GoVn9A4
 ZIFjjKFo6wcCsUXlQWF0qm42tEM3BIGu31Hvpko5OsPPUGNm3X2+irTNFYlqZjTnVAJ5PL9K9V2
 IBx73ZsTPXDf7YnTFJunaYoSDN6xn2+UCX0BuB+2s6dN0Y8YonA5nm7QIcnRYLO9b6dD0Coqerq
 Y7K7XPQlffMxRJjMAX+xKhgwe/kEPL64WadXM7zjyC8pY7W0WqkIe/eiDN/azqDkuve0dHm4tpD
 c+xrYNYBevqijmyPnbGJKo1yzwBdsmesBNp517R4qfOAvpBj4ml5j0BfXcJZ3at4dEqdEg==
X-Received: by 2002:a05:7023:a88:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-128f3e1775emr3356290c88.4.1773753797036; Tue, 17 Mar 2026
 06:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260317122529.361748-1-lijo.lazar@amd.com>
In-Reply-To: <20260317122529.361748-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Mar 2026 09:23:04 -0400
X-Gm-Features: AaiRm50VWnyipACXaze-hs1FzIqltB0mU6wQURQTaDczAofLFCiv5boGFKZ6kBY
Message-ID: <CADnq5_Nu+1UfUGBMmsaEaef5bqxSBra5nXjogzo9uuP=pRfB7w@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu: Add client id helpers to mmhub
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

On Tue, Mar 17, 2026 at 8:25=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Add data structure and helpers to get client id data of mmhub.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h | 25 +++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_mmhub.h
> index 92918101a95d..6b8214650e5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h
> @@ -66,12 +66,37 @@ struct amdgpu_mmhub_funcs {
>         int (*get_xgmi_info)(struct amdgpu_device *adev);
>  };
>
> +struct amdgpu_mmhub_client_ids {
> +       const char * const (*names)[2];
> +       unsigned int size;
> +};
> +
>  struct amdgpu_mmhub {
>         struct ras_common_if *ras_if;
>         const struct amdgpu_mmhub_funcs *funcs;
>         struct amdgpu_mmhub_ras  *ras;
> +       struct amdgpu_mmhub_client_ids client_ids;
>  };
>
> +static inline void
> +amdgpu_mmhub_init_client_info(struct amdgpu_mmhub *mmhub,
> +                             const char * const (*names)[2],
> +                             unsigned int size)
> +{
> +       mmhub->client_ids.names =3D names;
> +       mmhub->client_ids.size =3D size;
> +}
> +
> +static inline const char *
> +amdgpu_mmhub_client_name(struct amdgpu_mmhub *mmhub,
> +                         u32 cid, bool is_write)
> +{
> +       if (cid < mmhub->client_ids.size)
> +               return mmhub->client_ids.names[cid][is_write];
> +
> +       return NULL;
> +}
> +
>  int amdgpu_mmhub_ras_sw_init(struct amdgpu_device *adev);
>
>  #endif
> --
> 2.49.0
>
