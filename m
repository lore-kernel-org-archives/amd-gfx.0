Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8C4C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 17:27:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72A8210E93C;
	Thu,  8 May 2025 17:27:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ShZU4ztb";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 735C010E93C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 17:27:43 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-af5f28ecbcaso95380a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 May 2025 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746725263; x=1747330063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WqnzY9VULu1j4Ka/7konRgQcsFqxhtVILrM9trp6A4=;
 b=ShZU4ztbD/6MMya/ULwjTbbEjkH6A3OX8roQXSF1egJR8By3/oL6wZfuB9S6KxMrSU
 UsAQqlo5InxdPwfb4bRBhlzX1/l8N6wNvtixYouh7l5uKeBvZbjkXQIYsXMQjJFh5vOt
 AONS5Nq/NF6BePTHZhDERV0Ylk7AcAxDiDNMyTCW8H/syJ+cZcil+Q5O6n1S5pa1tpD0
 db2nPKNNmsfOTbf0idCjxUshoyufY+znGFuvlhUhVT7SLMDi+g8jOqIM6t27AQu2i3tJ
 yW0Byb38FDPWjRYugnacPampjvBy8b8zxVtHmagyIECi7CXHp3at2i0mvfRu4gdQ/fxz
 YtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746725263; x=1747330063;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2WqnzY9VULu1j4Ka/7konRgQcsFqxhtVILrM9trp6A4=;
 b=Lg7FWH0gOv25Czu+tDRnDSwJOYFJCKCd/REk3fG/l5hTlcWsqhE4d6R56GBrqeU7Gs
 UVvYVo8XjnKK1zVg5LXjwQdLc57qE/sDBTMrJmb9nxcIxD3+cCZ43R/d9RjsuNcrEQiT
 xlG2cW7o+Apw8LBzeEA/UIxYi9pvd/KdRCKnYOug+2di07I22QSUIDDbar3rtuD9ukzb
 cwIJyLcmvlO5rQcFq62w3Zdp4DoPiLZyM9WpJk0I4p5D0tJ9JpNreAxIMxknMjMEKKqM
 4yDzIRvTYIET3cCIopLa704y2IzKTDp59clz+iqpEXtfCnWsNahYDcmHmbqhNQA904M/
 b+8g==
X-Gm-Message-State: AOJu0YwGN/ZnIEHLrBr2U9aZoh9V2vAow9UAz2SIyNxmPPJ78XozwV8n
 Ruxgylpxjpq3ccZZvzMc20nZDuaMi3958yyvig1RaY8U9dZ9BEOzrrkSV+QFiVESYqFPEnkVRAF
 RKobjc4tubS64rqyxQOgD3vl3oBU=
X-Gm-Gg: ASbGnctoqHZt0/S+bIf03n8QLBT0oXeOgK1rp7Q6a1j72Ws85O69nCTavx94H0QCKA1
 MXLRegFZaeb6SCTssjl862QxxpUK/OsCqrn5e5H4egHEIN6Jkijxx6UjtMnKD0DdlQbD6pJoyZG
 b4psa4c/veOOyR4RXlMi+lWw==
X-Google-Smtp-Source: AGHT+IESK+cQuJGjEQ4fB6nXWa8s8WJ6rBn7137dFP/+b3+bCX5zFuSlY0HoiokfZlcE6t6jtAAd2P6Wi6KJxhhmVro=
X-Received: by 2002:a17:902:e84f:b0:224:e0e:e08b with SMTP id
 d9443c01a7336-22fc8946fbfmr1545995ad.0.1746725262950; Thu, 08 May 2025
 10:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250508124149.340361-1-FangSheng.Huang@amd.com>
In-Reply-To: <20250508124149.340361-1-FangSheng.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 8 May 2025 13:27:31 -0400
X-Gm-Features: ATxdqUF6-qlQd23Av-I8eH5dSQ0ed_dS0r1fbC4-Yxc8PWkEiozChQVQFk_LvZ4
Message-ID: <CADnq5_MX3eGXXmJkn+2QQ-08qi+ACvMk=H541B6oxw3_f4sv8Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add vcn v5_0_0 ip headers
To: fanhuang <FangSheng.Huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Ahmad.Rehman@amd.com, Vignesh.Chander@amd.com, 
 Guangwei.Ren@amd.com, Yunxiang.Li@amd.com
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

On Thu, May 8, 2025 at 8:42=E2=80=AFAM fanhuang <FangSheng.Huang@amd.com> w=
rote:
>
> Add vcn v5_0_0 register offset and shift masks
> header files
> Only include the registers required for MMSCH
> initialization
>
> Signed-off-by: fanhuang <FangSheng.Huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../include/asic_reg/vcn/vcn_5_0_0_offset.h   | 16 +++++++++++++
>  .../include/asic_reg/vcn/vcn_5_0_0_sh_mask.h  | 23 +++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h =
b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
> index 14574112c469..c4aaa86a95e2 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_offset.h
> @@ -1147,6 +1147,22 @@
>  #define regUVD_DPG_LMA_CTL2_BASE_IDX                                    =
                                1
>
>
> +// addressBlock: uvd_mmsch_dec
> +// base address: 0x20d2c
> +#define regMMSCH_VF_VMID                                                =
                                0x054b
> +#define regMMSCH_VF_VMID_BASE_IDX                                       =
                                1
> +#define regMMSCH_VF_CTX_ADDR_LO                                         =
                                0x054c
> +#define regMMSCH_VF_CTX_ADDR_LO_BASE_IDX                                =
                                1
> +#define regMMSCH_VF_CTX_ADDR_HI                                         =
                                0x054d
> +#define regMMSCH_VF_CTX_ADDR_HI_BASE_IDX                                =
                                1
> +#define regMMSCH_VF_CTX_SIZE                                            =
                                0x054e
> +#define regMMSCH_VF_CTX_SIZE_BASE_IDX                                   =
                                1
> +#define regMMSCH_VF_MAILBOX_HOST                                        =
                                0x0552
> +#define regMMSCH_VF_MAILBOX_HOST_BASE_IDX                               =
                                1
> +#define regMMSCH_VF_MAILBOX_RESP                                        =
                                0x0553
> +#define regMMSCH_VF_MAILBOX_RESP_BASE_IDX                               =
                                1
> +
> +
>  // addressBlock: uvd_vcn_umsch_dec
>  // base address: 0x21500
>  #define regVCN_UMSCH_MES_CNTL                                           =
                                0x0740
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h=
 b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
> index 5c119a6b87fb..bd7242e4e9c6 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_5_0_0_sh_mask.h
> @@ -5929,6 +5929,29 @@
>  #define UVD_DPG_LMA_CTL2__JPEG_WRITE_PTR_MASK                           =
                                      0x0000FE00L
>
>
> +// addressBlock: uvd_mmsch_dec
> +//MMSCH_VF_VMID
> +#define MMSCH_VF_VMID__VF_CTX_VMID__SHIFT                               =
                                      0x0
> +#define MMSCH_VF_VMID__VF_GPCOM_VMID__SHIFT                             =
                                      0x5
> +#define MMSCH_VF_VMID__VF_CTX_VMID_MASK                                 =
                                      0x0000001FL
> +#define MMSCH_VF_VMID__VF_GPCOM_VMID_MASK                               =
                                      0x000003E0L
> +//MMSCH_VF_CTX_ADDR_LO
> +#define MMSCH_VF_CTX_ADDR_LO__VF_CTX_ADDR_LO__SHIFT                     =
                                      0x6
> +#define MMSCH_VF_CTX_ADDR_LO__VF_CTX_ADDR_LO_MASK                       =
                                      0xFFFFFFC0L
> +//MMSCH_VF_CTX_ADDR_HI
> +#define MMSCH_VF_CTX_ADDR_HI__VF_CTX_ADDR_HI__SHIFT                     =
                                      0x0
> +#define MMSCH_VF_CTX_ADDR_HI__VF_CTX_ADDR_HI_MASK                       =
                                      0xFFFFFFFFL
> +//MMSCH_VF_CTX_SIZE
> +#define MMSCH_VF_CTX_SIZE__VF_CTX_SIZE__SHIFT                           =
                                      0x0
> +#define MMSCH_VF_CTX_SIZE__VF_CTX_SIZE_MASK                             =
                                      0xFFFFFFFFL
> +//MMSCH_VF_MAILBOX_HOST
> +#define MMSCH_VF_MAILBOX_HOST__DATA__SHIFT                              =
                                      0x0
> +#define MMSCH_VF_MAILBOX_HOST__DATA_MASK                                =
                                      0xFFFFFFFFL
> +//MMSCH_VF_MAILBOX_RESP
> +#define MMSCH_VF_MAILBOX_RESP__RESP__SHIFT                              =
                                      0x0
> +#define MMSCH_VF_MAILBOX_RESP__RESP_MASK                                =
                                      0xFFFFFFFFL
> +
> +
>  // addressBlock: uvd_vcn_umsch_dec
>  //VCN_UMSCH_MES_CNTL
>  #define VCN_UMSCH_MES_CNTL__PIPE_ID__SHIFT                              =
                                      0x0
> --
> 2.34.1
>
