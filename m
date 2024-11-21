Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689B6E6400D
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Nov 2024 20:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D2510E22E;
	Thu, 21 Nov 2024 20:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GbT/mL/L";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A22710E22E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 20:19:19 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-724d5e309dfso69192b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Nov 2024 12:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732220359; x=1732825159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7QNB6LJkxP0HdfMaBEz3a+AFUzeDA9EyhV+KERVuLQ=;
 b=GbT/mL/LT7ByKNUTGenX81P4KYEmcuFPDvqvhCuh0Sp7solq9AThGOs2SLhvQQJdr6
 7ch7PmAUD5CCL+AYHvsTBsC8WUWXmSv3tLuzXodRgX1zVJjCnJT5AF4RjjmnC7nnsNCg
 46mhoV1uVKkFiXMx4gAd7YiR3epoF4CxAvvRtqKZF2FVZGV6Mpwe3VvxR39B69WcDUdR
 A5wXREqSWXQs+y4bUtBwqEht9TB3zCIw+Cr+NQ0BWltjqqNrWQ2s7rvK7kNCBgDMbek4
 xHz1V3qrvlBiC+6/0VeUZT1c5tJ3FcT6TVjsPMEo/ZbLcKjVULLthJVo4ZUYF30DSXAP
 sd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732220359; x=1732825159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l7QNB6LJkxP0HdfMaBEz3a+AFUzeDA9EyhV+KERVuLQ=;
 b=i0i+NO5YdYqQnM9e0lODqTj+sW1WML1Kf9YGr/j89EmK0iA2o9sViQe2CcuJETAqih
 0UIMMJbjUdAG9LtBl46V4bCn1/NW0k4EZyAoKFTOUfYzm5LkOJSC/Ho9e+Vim8uxCwKR
 cQbOjczkozSaziDXT1Cz3+syCyL911P6B/uKWDwx51ZDRvv0xEKSJYsg2ZB0wkTWywy7
 0a8pkjIxb1dua08he9T/KLS+3/WxKXBSITRDTNvhaPZJzmzqJOgpEtge1fyl7qGd8K7Q
 86pdZljeVs0hTUQ2Xs/DOpFqMcb8wGqSwFKW9DPtziBYR+lnOi7pL0O3jqeiDZGDotou
 D8yQ==
X-Gm-Message-State: AOJu0YwqztNOh+bKPbHCcjcr0ekhLfmms7MGmacJecm6Owf81um6WTJi
 FlSmjfDBWX1pMByoz6oG9Uhn6fcamvyL/Vahf9m3HotQyb996BJJmjtfG0YqQaBqp1Z7oCtlhiK
 P0BLkx7KxIH666FDpJqexbOxb7UiH7Q==
X-Gm-Gg: ASbGncu79Jp+fDDnwYf+KVUexoIdgRu9qs4VCt/+nU4kxnfCTJ2s0TcL63vG22AmGLh
 byoPtDtGyTpdwShgDkZUyGAPhx0zIYWM=
X-Google-Smtp-Source: AGHT+IEoWmsiHGUDPveV5U49vQtNq5uZcyRkjfZ+a2Zf63FBujViJuuPwmZn0mBMqSkPcqxYPn4YFOUuH7xKv2Hojv4=
X-Received: by 2002:a17:90b:4c86:b0:2ea:bb3a:8f09 with SMTP id
 98e67ed59e1d1-2eb0d4fd5acmr98332a91.0.1732220359007; Thu, 21 Nov 2024
 12:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20241121133307.594-1-shashank.sharma@amd.com>
 <20241121133307.594-6-shashank.sharma@amd.com>
In-Reply-To: <20241121133307.594-6-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 21 Nov 2024 15:19:07 -0500
Message-ID: <CADnq5_Nr8bzEZqkj+ddJAZmRxVAQnk3ibuJC2ybxmG0kbSUeEg@mail.gmail.com>
Subject: Re: [PATCH 5/9] drm/amdgpu/sdma7: update mqd init for UQ
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
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

On Thu, Nov 21, 2024 at 8:42=E2=80=AFAM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Set the addresses for the UQ metadata.
>
> V2: Fix lower offset mask (Shashank)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_0.c
> index eb35ec9f3da2..fc9cb989aa6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -887,6 +887,9 @@ static int sdma_v7_0_mqd_init(struct amdgpu_device *a=
dev, void *mqd,
>         m->sdmax_rlcx_rb_aql_cntl =3D 0x4000;     //regSDMA0_QUEUE0_RB_AQ=
L_CNTL_DEFAULT;
>         m->sdmax_rlcx_dummy_reg =3D 0xf;  //regSDMA0_QUEUE0_DUMMY_REG_DEF=
AULT;
>
> +       m->sdmax_rlcx_csa_addr_lo =3D prop->csa_addr & 0xFFFFFFFC;

Same comment here as the previous patch.

Alex

> +       m->sdmax_rlcx_csa_addr_hi =3D upper_32_bits(prop->csa_addr);
> +
>         return 0;
>  }
>
> --
> 2.46.2
>
