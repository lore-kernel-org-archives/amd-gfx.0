Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2831C2BBCA
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jun 2024 18:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579C210E71F;
	Tue, 25 Jun 2024 18:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RhBSGYu7";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F6C610E71F
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 18:34:37 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1fa55dbf2e7so16968635ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719340477; x=1719945277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BZ14lYy154Ja8M370bx8Y9tE5mk1mjIrzKq7S/hOyp8=;
 b=RhBSGYu7/QeXTbeD+LL39ne5Y2Dn0BxmBpxl7IwjfGIoVn4oilm6s26MRAlxHMcppp
 j7l3eYdcPYUOA4m8MZRQ9hn9jREEUIohiiDSJ+8whNWeBp4xN7FTTItLTz1bI7uGiKrr
 cL9hE9RwtqH/aLNkPB1wTcJTWOZiyK8dT9Fuc48LKM4H/dXfIwxSmwmLWBakqXaK92UK
 oh8mLzrDP708jcsMJA1Xuft2iToCUbD+foHyS1HIIPVakaoYIVzLCpiqqgARhpwpmBrs
 plUAi7nJ5ZIST5X+sh1/aaip9uuqBvsFkzSGGRtoQscu6CVtpSGBXvmPA1N12orGg0+6
 +xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719340477; x=1719945277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZ14lYy154Ja8M370bx8Y9tE5mk1mjIrzKq7S/hOyp8=;
 b=rAnIzMFpXHiRPBryc/+4UMZja1/ak5QSbLYVNrCY9+zsTix060X+O/JCT1aVD0WbYe
 RPBzaM9/dkRIYyCq68XVL23SBSQ5ph7wkvo1j7lFZvEr9dezWr119bjFyZ/86vZhA2fX
 VQuRBb4e5W6t5mp/uEZabsFSE+mr5DUeSczlE+HkaW7IAZ1gLH9j4S0AbyTTCadrWqW5
 Ht7qQf8ty74SUI8aB1XIWH54vkSCOkEJGi/0RYB/7I67xFAILL3kSfIK3d/uZw2wcC5p
 rty8FlpipuDfOPvp5jtSLIx5wQ9iLT10boiqtD0ffLa2uTwEV90aTzqGgI59n+/oRmV6
 5DDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8yrz3Iwj/Cz9Qd/EL5tdQx4NZQNm/IdBrjrH7yk0Ix6VYFVFZAy6zwa5mWwktg6+NrNbyAo1ivkM1OWlhOnSUCKwEhSLXMnTp3CYbog==
X-Gm-Message-State: AOJu0YwxetkRaHeOfUHfSSUIM3m9JOfwzeRmWoxHb20pJyOd2sLkbQ7d
 czgt/f/AU9ZuIaE6yuckAZ2kl2Vi9IJWPSM+S2W9e599Ovv5rtslEBvp6gwxszUuFbumuEl6r+A
 TpwfxxcVK+zseoorUxRamLb9Br/A=
X-Google-Smtp-Source: AGHT+IEnZx/9/gEHRkJnfXTd+04Gk6EzsYAIfBua2gUL2lFP6IIwRJBJ+lwZJQ/OkgoZXD7u+95kruqL+G+G/siuONw=
X-Received: by 2002:a17:902:e851:b0:1fa:cbf:c8b9 with SMTP id
 d9443c01a7336-1fa158f79b2mr115676815ad.38.1719340476798; Tue, 25 Jun 2024
 11:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240625182248.319867-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240625182248.319867-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jun 2024 14:34:24 -0400
Message-ID: <CADnq5_Oh3V-zNAPOmHGsTXAkD=qS4Dt8e7P046f_QtT2h+igYg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add some missing register definitions
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: tom.stdenis@amd.com, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, harry.wentland@amd.com, rodrigo.siqueira@amd.com
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

On Tue, Jun 25, 2024 at 2:32=E2=80=AFPM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> Add some register offsets that are required for Display DCC on DCN401
>
> Fixes: 000342e3a22 ("drm/amd: Add reg definitions for DCN401 DCC")
> Reported-by: Tom St Denis <tom.stdenis@amd.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../include/asic_reg/dcn/dcn_4_1_0_offset.h    | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h =
b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
> index 5dabf0abccce..15e5a65cf492 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
> @@ -1777,6 +1777,8 @@
>  #define regDCHUBBUB_SDPIF_MEM_PWR_CTRL_BASE_IDX                         =
                                2
>  #define regDCHUBBUB_SDPIF_MEM_PWR_STATUS                                =
                                0x0487
>  #define regDCHUBBUB_SDPIF_MEM_PWR_STATUS_BASE_IDX                       =
                                2
> +#define regDCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL                       =
                                0x0488
> +#define regDCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL_BASE_IDX              =
                                2
>
>
>  // addressBlock: dcn_dcec_dchubbubl_hubbub_ret_path_dispdec
> @@ -2089,6 +2091,8 @@
>  #define regHUBP0_DCSURF_TILING_CONFIG_BASE_IDX                          =
                                2
>  #define regHUBP0_DCSURF_PRI_VIEWPORT_START                              =
                                0x05e9
>  #define regHUBP0_DCSURF_PRI_VIEWPORT_START_BASE_IDX                     =
                                2
> +#define regHUBP0_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE                =
                                0x05ea
> +#define regHUBP0_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE_BASE_IDX       =
                                2
>  #define regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                          =
                                0x05eb
>  #define regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                 =
                                2
>  #define regHUBP0_DCSURF_PRI_VIEWPORT_START_C                            =
                                0x05ec
> @@ -2121,6 +2125,8 @@
>  #define regHUBP0_DCHUBP_MALL_SUB_VP1_BASE_IDX                           =
                                2
>  #define regHUBP0_DCHUBP_MALL_SUB_VP2                                    =
                                0x05fa
>  #define regHUBP0_DCHUBP_MALL_SUB_VP2_BASE_IDX                           =
                                2
> +#define regHUBP0_DCHUBP_MCACHEID_CONFIG                                 =
                                0x05fb
> +#define regHUBP0_DCHUBP_MCACHEID_CONFIG_BASE_IDX                        =
                                2
>  #define regHUBP0_HUBPREQ_DEBUG_DB                                       =
                                0x05fc
>  #define regHUBP0_HUBPREQ_DEBUG_DB_BASE_IDX                              =
                                2
>  #define regHUBP0_HUBPREQ_DEBUG                                          =
                                0x05fd
> @@ -2378,6 +2384,8 @@
>  #define regHUBP1_DCSURF_TILING_CONFIG_BASE_IDX                          =
                                2
>  #define regHUBP1_DCSURF_PRI_VIEWPORT_START                              =
                                0x06c5
>  #define regHUBP1_DCSURF_PRI_VIEWPORT_START_BASE_IDX                     =
                                2
> +#define regHUBP1_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE                =
                                0x06c6
> +#define regHUBP1_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE_BASE_IDX       =
                                2
>  #define regHUBP1_DCSURF_PRI_VIEWPORT_DIMENSION                          =
                                0x06c7
>  #define regHUBP1_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                 =
                                2
>  #define regHUBP1_DCSURF_PRI_VIEWPORT_START_C                            =
                                0x06c8
> @@ -2410,6 +2418,8 @@
>  #define regHUBP1_DCHUBP_MALL_SUB_VP1_BASE_IDX                           =
                                2
>  #define regHUBP1_DCHUBP_MALL_SUB_VP2                                    =
                                0x06d6
>  #define regHUBP1_DCHUBP_MALL_SUB_VP2_BASE_IDX                           =
                                2
> +#define regHUBP1_DCHUBP_MCACHEID_CONFIG                                 =
                                0x06d7
> +#define regHUBP1_DCHUBP_MCACHEID_CONFIG_BASE_IDX                        =
                                2
>  #define regHUBP1_HUBPREQ_DEBUG_DB                                       =
                                0x06d8
>  #define regHUBP1_HUBPREQ_DEBUG_DB_BASE_IDX                              =
                                2
>  #define regHUBP1_HUBPREQ_DEBUG                                          =
                                0x06d9
> @@ -2667,6 +2677,8 @@
>  #define regHUBP2_DCSURF_TILING_CONFIG_BASE_IDX                          =
                                2
>  #define regHUBP2_DCSURF_PRI_VIEWPORT_START                              =
                                0x07a1
>  #define regHUBP2_DCSURF_PRI_VIEWPORT_START_BASE_IDX                     =
                                2
> +#define regHUBP2_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE                =
                                0x07a2
> +#define regHUBP2_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE_BASE_IDX       =
                                2
>  #define regHUBP2_DCSURF_PRI_VIEWPORT_DIMENSION                          =
                                0x07a3
>  #define regHUBP2_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                 =
                                2
>  #define regHUBP2_DCSURF_PRI_VIEWPORT_START_C                            =
                                0x07a4
> @@ -2699,6 +2711,8 @@
>  #define regHUBP2_DCHUBP_MALL_SUB_VP1_BASE_IDX                           =
                                2
>  #define regHUBP2_DCHUBP_MALL_SUB_VP2                                    =
                                0x07b2
>  #define regHUBP2_DCHUBP_MALL_SUB_VP2_BASE_IDX                           =
                                2
> +#define regHUBP2_DCHUBP_MCACHEID_CONFIG                                 =
                                0x07b3
> +#define regHUBP2_DCHUBP_MCACHEID_CONFIG_BASE_IDX                        =
                                2
>  #define regHUBP2_HUBPREQ_DEBUG_DB                                       =
                                0x07b4
>  #define regHUBP2_HUBPREQ_DEBUG_DB_BASE_IDX                              =
                                2
>  #define regHUBP2_HUBPREQ_DEBUG                                          =
                                0x07b5
> @@ -2957,6 +2971,8 @@
>  #define regHUBP3_DCSURF_TILING_CONFIG_BASE_IDX                          =
                                2
>  #define regHUBP3_DCSURF_PRI_VIEWPORT_START                              =
                                0x087d
>  #define regHUBP3_DCSURF_PRI_VIEWPORT_START_BASE_IDX                     =
                                2
> +#define regHUBP3_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE                =
                                0x087e
> +#define regHUBP3_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE_BASE_IDX       =
                                2
>  #define regHUBP3_DCSURF_PRI_VIEWPORT_DIMENSION                          =
                                0x087f
>  #define regHUBP3_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                 =
                                2
>  #define regHUBP3_DCSURF_PRI_VIEWPORT_START_C                            =
                                0x0880
> @@ -2989,6 +3005,8 @@
>  #define regHUBP3_DCHUBP_MALL_SUB_VP1_BASE_IDX                           =
                                2
>  #define regHUBP3_DCHUBP_MALL_SUB_VP2                                    =
                                0x088e
>  #define regHUBP3_DCHUBP_MALL_SUB_VP2_BASE_IDX                           =
                                2
> +#define regHUBP3_DCHUBP_MCACHEID_CONFIG                                 =
                                0x088f
> +#define regHUBP3_DCHUBP_MCACHEID_CONFIG_BASE_IDX                        =
                                2
>  #define regHUBP3_HUBPREQ_DEBUG_DB                                       =
                                0x0890
>  #define regHUBP3_HUBPREQ_DEBUG_DB_BASE_IDX                              =
                                2
>  #define regHUBP3_HUBPREQ_DEBUG                                          =
                                0x0891
> --
> 2.45.2
>
