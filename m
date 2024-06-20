Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC811C27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 14:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E3210EA23;
	Thu, 20 Jun 2024 14:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PT9Tt4il";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B6D10EA23
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 14:38:18 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-1f992388bbbso8528395ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 07:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718894298; x=1719499098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/4weo1kvf7Q97pF+mggFinlbUMgINBy5YGcTzAIUXaA=;
 b=PT9Tt4ilAKqynEBluBYrYdAf41SUUmSVsdO0baU6s4c/v0PC+YxlIHO/vuTT4WJnR+
 wviXG5fAbQAPdH3UQm9YLU8Ipp21JoeeJEwgNhsSiEjYn3BB5SgM6TyvQwPPBV86LhwW
 IigrJGhnjmHv9Q1Hysz1eoMO2Go9D6pefdMo4bAsooLMgk1hfpKAekRHyS2/Q+WGtupD
 +BekqE1+IFrZJLYOZG5+T+kD1HnLDctbt1xCl1KuzpxyxgpoBCMi8E8x74Fdh3AUmHFt
 /q6Jp9ZhZxZanxTzn7nTwkl72xskxT5FWVSheHfmhz/o2yDMgLJV1NYHpSbx147YZHMB
 F+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718894298; x=1719499098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/4weo1kvf7Q97pF+mggFinlbUMgINBy5YGcTzAIUXaA=;
 b=DaNlReTA1zunMlmaR8B9aoyC19m3aZ8AV2U6Ahcb8EKbFkzF/SLkkfqt3vZRAKvKtA
 rCGDmh+WBmEEA3Pu4lP5lylDIXKene73OHO3UmdgABSdfMFho2lQkJuBq7mYFsiMq2Hy
 PgGYsIvE2PPUFfO7Z1rb9Bmh1gJWI7Oq9ramj517u4+F7K4IhUXuvzXxxA+QTD0/iL0w
 ZchIyybD2FVcUbDYaQNu+KUQKL0P9IYRj+1wck2U4po/v8VDeNNDeBBqoG9TYOCljSjH
 Flm0QRElLtPLYdj4egaO1BI2Qc3qauSBHIXTcDwjLwQAeeo3YDy9tAbNiLlb1dSZ/T9J
 Yo2Q==
X-Gm-Message-State: AOJu0YxfCICnhyly3nzqin9unJUOnWt+RrH9YHs904Xq8Zg0ix/7FVqL
 eL9p4TLYeNBZJ65KTWreq9L1f1ur3LmzcXiz9uPYJTPG0h5IhLf8Vr+nwe7Xa/qSJvz7zozVVeS
 Yc+wlhOZ7fEWLQw7+HCqheXUOdPc=
X-Google-Smtp-Source: AGHT+IFA4P0QBSBE9XQGeIFEqQOE//jk71Be5OLBTXX8ckV0YKHYiCkfA5PoeseHe8GR+ZPsw9tXr/NnWFd1aTCapjg=
X-Received: by 2002:a17:902:f64c:b0:1f7:38a2:f1e6 with SMTP id
 d9443c01a7336-1f9aa473e72mr62852225ad.43.1718894298050; Thu, 20 Jun 2024
 07:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240620062618.3285-1-Frank.Min@amd.com>
 <SA1PR12MB5659B0EAF1A7F230F5875C73E9C82@SA1PR12MB5659.namprd12.prod.outlook.com>
 <SA3PR12MB7902C19B353CA08B038A7F08E9C82@SA3PR12MB7902.namprd12.prod.outlook.com>
In-Reply-To: <SA3PR12MB7902C19B353CA08B038A7F08E9C82@SA3PR12MB7902.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jun 2024 10:38:05 -0400
Message-ID: <CADnq5_P=NBiyYaxAHhNuVxXpdpXQ666Fu6-sQ2BBLmv7Hgakpw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update gfxhub client id for gfx12
To: "Min, Frank" <Frank.Min@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
 "Gao, Likun" <Likun.Gao@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

On Thu, Jun 20, 2024 at 10:32=E2=80=AFAM Min, Frank <Frank.Min@amd.com> wro=
te:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> From: Frank Min <Frank.Min@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> update gfxhub client id for gfx12
>
> Signed-off-by: Frank Min <Frank.Min@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfxhub_v12_0.c
> index 7ea64f1e1e48..7609b9cecae8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
> @@ -35,7 +35,27 @@
>  #define regGRBM_GFX_INDEX_DEFAULT      0xe0000000
>
>  static const char *gfxhub_client_ids[] =3D {
> -       /* TODO */
> +       "CB",
> +       "DB",
> +       "GE1",
> +       "GE2",
> +       "CPF",
> +       "CPC",
> +       "CPG",
> +       "RLC",
> +       "TCP",
> +       "SQC (inst)",
> +       "SQC (data)",
> +       "SQG/PC/SC",
> +       "Reserved",
> +       "SDMA0",
> +       "SDMA1",
> +       "GCR",
> +       "Reserved",
> +       "Reserved",
> +       "WGS",
> +       "DSM",
> +       "PA"
>  };
>
>  static uint32_t gfxhub_v12_0_get_invalidate_req(unsigned int vmid,
> --
> 2.34.1
>
