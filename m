Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBDF6C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 13:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 797A310E095;
	Thu,  8 May 2025 13:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MaFQ3WqE";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E8910E095
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 13:35:41 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-301a8b7398cso157747a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 May 2025 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746711341; x=1747316141; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZEq6Wg/jVV+kLoKqExUw+pz9CysrDDS6+6ZYGW1d7E=;
 b=MaFQ3WqEpJ96k7BOeoHCIhlugldQ9sU2g28njJL/1n9gdvrZRSGRAWOMJgdapJUNuz
 01rgmofquEkdqMP+3qcgmfQvEeaMCYcn21dqhIkn7/CVmUcLKeDDDVi3l+s9EO31LUEc
 /OcXVTO8ht5FPQ2DnJ4H7GM9zuFaiYsBo4NnqBGaf06cpN1fBf3DY1j7gKBOAK/aJ7Or
 8xGzMn1lbRK2HACUNslBmAf4ssIoR2w2lKv/DxPzhz+0/sjjbF6WEbbaQg+7Un6YiCuN
 8qDPWdJxbrXbVZeGEC69yzN5DuBUestY9kY1aV/WqgtS+8JLd3Lza+IU9ffeeSUC6tBm
 XndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746711341; x=1747316141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZEq6Wg/jVV+kLoKqExUw+pz9CysrDDS6+6ZYGW1d7E=;
 b=aVN+HaNbBWcAf0924iLBk8wSAG/ByO0LaltDXwjv5HdzjhyIw1mxrx5BxNDad0AWPE
 WTbcZ+XKAczcxKE6rLo42J6RKhwtdRbEGXH8tStfZzckupww9Csh7/1zsZkPxnHHPgLh
 uMO9BvQqnnA7CAOEb4mrdp3ukDp3PTzABVewkYcmECoG/uDdNIG16q8XDp7OUhKZKkCb
 lDT9803nLlHMIhQMtOtTXl5dSRTZNZs0BKmj7BGeeUBFDDmrEjwfUM6X39yH59MI95x5
 6Zpmn0NP+0ubDh2MN+pnvz4j0YRVlMiXe1PCKx9bmkMV4XUATYNFMJRgyv5EKvltb7Lg
 L/Cw==
X-Gm-Message-State: AOJu0YxEi2Rk/OYAitPHK/0E4JlzeWWN8BYvyMXJz88tnBlgp+xragJj
 IOa/fT672SVVF9Unx0peN3LTznVrRvs25cCzD9GPCnVqSp97nvoyEPJJSNY3N8Hk24rEdQO+D6x
 ZBG60qrlqcfbMrPFg4IGIHKyt72bqOQ==
X-Gm-Gg: ASbGnct9GTD/SHLtOsAE96f43uJtxOvmWzabf5k/3At69JABvO+F23yY2CO124cywsV
 pnSfmaIXQ/EmbWIEENtGQ09rCUM/tuHa7FAh99hKKLyJZlT2ENdeoMIZ5uo2qoLU+5t0ILxt4HW
 1U+U3P2xCTMVXS6S7id6pNrg==
X-Google-Smtp-Source: AGHT+IGUq9zwY/Hi/M2ns56Wdbey8ADbX5NXAORBIhknU8cOLzJYDOQbL4ShBT0Mr7xOpXNv71y3FpIrXqAIBvpX36o=
X-Received: by 2002:a17:90b:1648:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-30aac20b7camr4006181a91.3.1746711341286; Thu, 08 May 2025
 06:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250508073000.1172588-1-tim.huang@amd.com>
In-Reply-To: <20250508073000.1172588-1-tim.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 May 2025 09:35:29 -0400
X-Gm-Features: ATxdqUGLaYkwPz7r80jm77EkDypzMoPiougGEIeKi2n5gd3Sb4ULuV6P4HE5AAI
Message-ID: <CADnq5_PtDb4pHmrLzh-CimsrYfXUV4jgOCwXonGXJiCN5rLODw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix incorrect MALL size for GFX1151
To: Tim Huang <tim.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Yifan1.zhang@amd.com
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

On Thu, May 8, 2025 at 3:31=E2=80=AFAM Tim Huang <tim.huang@amd.com> wrote:
>
> On GFX1151, the reported MALL cache size reflects only
> half of its actual size; this adjustment corrects the discrepancy.
>
> Signed-off-by: Tim Huang <tim.huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v11_0.c
> index 917d894a1316..72211409227b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -748,6 +748,18 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block =
*ip_block)
>         adev->gmc.vram_type =3D vram_type;
>         adev->gmc.vram_vendor =3D vram_vendor;
>
> +       /* The mall_size is already calculated as mall_size_per_umc * num=
_umc.
> +        * However, for gfx1151, which features a 2-to-1 UMC mapping,
> +        * the result must be multiplied by 2 to determine the actual mal=
l size.
> +        */
> +       switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
> +       case IP_VERSION(11, 5, 1):
> +               adev->gmc.mall_size *=3D 2;
> +               break;
> +       default:
> +               break;
> +       }
> +
>         switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
>         case IP_VERSION(11, 0, 0):
>         case IP_VERSION(11, 0, 1):
> --
> 2.43.0
>
