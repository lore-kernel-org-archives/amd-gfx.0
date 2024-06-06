Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A3AC25B75
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 13:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA39C10E944;
	Thu,  6 Jun 2024 13:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FYsu0oOk";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B57FA10E944
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 13:05:48 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-1f6342c5fa8so9138265ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jun 2024 06:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717679148; x=1718283948; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NX2yPr7KXyWQDruLPR/zLtfyzq2a+JAq4CwQzmJP/3g=;
 b=FYsu0oOkGTdh8JO/iOSVICUJZLkUx5xjrD9NLl9Lyz9QJE6qDfzYOYsFl1M0iMXdw1
 qRNGs6C26CdN32KyUWCZDwLF6PRx+4eM1iAfp8ZqTz9t3qQCcGri2SinCkGtUx7UZzpj
 NFTMZ9LdEeJ49cXECsRGXsh4f/rGaYa2WYJBFFVY75w1RqLWLlkH8FWAq0r8TiRDYq+h
 3A6+Lsi5MvouyeBNYaoqOAapPEYrsrimOHff8bw6p0RLlgNvaWNgBHKPm2z9Iz9GVlLb
 HPYNELUsYsZWMbcFbM+C0K/KYvF2GVhx2hjT2xMa+9sb/ocl+FyMWs8KVLQ9RkHqQJNm
 smeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717679148; x=1718283948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NX2yPr7KXyWQDruLPR/zLtfyzq2a+JAq4CwQzmJP/3g=;
 b=tH4487U8tBVSAmLyhevJPwco/0Ah52ScX4jcwo4o6qaz1SBVPAd49KkTcJbNvIo9xL
 PRNy9wbK2K0lwax5FnstKqvHpQ3qjriJ3ZI/Q+6IH6/pXIFQmWf89NVk4dwXCBC+x4sH
 +vUk0HVerDN0jjNMGWQk2tAUQVGXrH3JJieEA2rPwEF3JAB10vR4FZ4slHYrTGoF0mQC
 8U6h0hl1elCl09k0EUlmoWi2f4UiHYnDwITiGKiGydTYt23Nn7Ff6GbsU1KS9cAppHQu
 eK3685JdRbyXeeMaDF958Wfc3ZQIs/xLGgmZk9cmH8JaUdN5QB62TMg2E7w4TfQW1o5Q
 ZAWA==
X-Gm-Message-State: AOJu0YzG7EUinfDurELVKx7i5s5Cz01elRjgrJrHn6du4uJ3J+1UBPbz
 MncCBYPqWUBu/cp9wePCOLihy/LBzS2ehrhC5BgUH4vVpETzqGTKYThggHZgUslpW6AQHm2ROov
 4iFI64tIipNwlED8iIBMSCoEq7ZsT2w==
X-Google-Smtp-Source: AGHT+IFhM6jETbvlFUmGi1tOJt/6xzNCxjRHfbM8n4zvecDdlZ2Spe+c8gsIWsNcN7lLUc1G0TwYdK96NKs4De0IWdo=
X-Received: by 2002:a17:90a:fe04:b0:2c1:ea2e:20b2 with SMTP id
 98e67ed59e1d1-2c27db57d16mr5387517a91.30.1717679147765; Thu, 06 Jun 2024
 06:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240605231654.6374-1-jay.cornwall@amd.com>
In-Reply-To: <20240605231654.6374-1-jay.cornwall@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jun 2024 09:05:35 -0400
Message-ID: <CADnq5_Ows0SumX7hAdtNyDm55xebFBQXngOT61rbrCt-QG4BKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Extend gfx12 trap handler fix to gfx10/11
To: Jay Cornwall <jay.cornwall@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lancelot Six <lancelot.six@amd.com>
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

On Wed, Jun 5, 2024 at 7:27=E2=80=AFPM Jay Cornwall <jay.cornwall@amd.com> =
wrote:
>
> In commit 6d1878882d2d
> ("drm/amdkfd: gfx12 context save/restore trap handler fixes") the
> following fix was introduced but incorrectly restricted to gfx12.
> The same issue and a corresponding fix apply to gfx10 and gfx11.
>
> Do not overwrite TRAPSTS.{SAVECTX,HOST_TRAP} when restoring this
> register. Both of these fields can assert while the wavefront is
> running the trap handler.
>
> Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdkfd/cwsr_trap_handler.h    | 16 +++++---
>  .../amd/amdkfd/cwsr_trap_handler_gfx10.asm    | 38 ++++++++++++++-----
>  2 files changed, 38 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h b/drivers/gpu=
/drm/amd/amdkfd/cwsr_trap_handler.h
> index 665122d1bbbd..02f7ba8c93cd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h
> @@ -1136,7 +1136,7 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D {
>         0x705d0000, 0x807c817c,
>         0x8070ff70, 0x00000080,
>         0xbf0a7b7c, 0xbf85fff8,
> -       0xbf82013d, 0xbef4037e,
> +       0xbf82013f, 0xbef4037e,
>         0x8775ff7f, 0x0000ffff,
>         0x8875ff75, 0x00040000,
>         0xbef60380, 0xbef703ff,
> @@ -1275,7 +1275,8 @@ static const uint32_t cwsr_trap_nv1x_hex[] =3D {
>         0x80788478, 0xbf8c0000,
>         0xb9eef815, 0xbefc036f,
>         0xbefe0370, 0xbeff0371,
> -       0xb9f9f816, 0xb9fbf803,
> +       0xb9f9f816, 0xb9fb4803,
> +       0x907b8b7b, 0xb9fba2c3,
>         0xb9f3f801, 0xb96e3a05,
>         0x806e816e, 0xbf0d9972,
>         0xbf850002, 0x8f6e896e,
> @@ -2544,7 +2545,7 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D {
>         0xe0704000, 0x705d0000,
>         0x807c817c, 0x8070ff70,
>         0x00000080, 0xbf0a7b7c,
> -       0xbf85fff8, 0xbf820134,
> +       0xbf85fff8, 0xbf820136,
>         0xbef4037e, 0x8775ff7f,
>         0x0000ffff, 0x8875ff75,
>         0x00040000, 0xbef60380,
> @@ -2683,7 +2684,8 @@ static const uint32_t cwsr_trap_gfx10_hex[] =3D {
>         0xf0000000, 0x80788478,
>         0xbf8c0000, 0xb9eef815,
>         0xbefc036f, 0xbefe0370,
> -       0xbeff0371, 0xb9fbf803,
> +       0xbeff0371, 0xb9fb4803,
> +       0x907b8b7b, 0xb9fba2c3,
>         0xb9f3f801, 0xb96e3a05,
>         0x806e816e, 0xbf0d9972,
>         0xbf850002, 0x8f6e896e,
> @@ -2981,7 +2983,7 @@ static const uint32_t cwsr_trap_gfx11_hex[] =3D {
>         0x701d0000, 0x807d817d,
>         0x8070ff70, 0x00000080,
>         0xbf0a7b7d, 0xbfa2fff8,
> -       0xbfa0013f, 0xbef4007e,
> +       0xbfa00143, 0xbef4007e,
>         0x8b75ff7f, 0x0000ffff,
>         0x8c75ff75, 0x00040000,
>         0xbef60080, 0xbef700ff,
> @@ -3123,7 +3125,9 @@ static const uint32_t cwsr_trap_gfx11_hex[] =3D {
>         0x80788478, 0xbf890000,
>         0xb96ef815, 0xbefd006f,
>         0xbefe0070, 0xbeff0071,
> -       0xb97bf803, 0xb973f801,
> +       0xb97b4803, 0x857b8b7b,
> +       0xb97b22c3, 0x857b867b,
> +       0xb97b7443, 0xb973f801,
>         0xb8ee3b05, 0x806e816e,
>         0xbf0d9972, 0xbfa20002,
>         0x846e896e, 0xbfa00001,
> diff --git a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm b/dri=
vers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> index ac3702b8e3c4..44772eec9ef4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> +++ b/drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx10.asm
> @@ -119,9 +119,12 @@ var SQ_WAVE_TRAPSTS_ADDR_WATCH_SHIFT               =
=3D 7
>  var SQ_WAVE_TRAPSTS_MEM_VIOL_MASK              =3D 0x100
>  var SQ_WAVE_TRAPSTS_MEM_VIOL_SHIFT             =3D 8
>  var SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK          =3D 0x800
> +var SQ_WAVE_TRAPSTS_ILLEGAL_INST_SHIFT         =3D 11
>  var SQ_WAVE_TRAPSTS_EXCP_HI_MASK               =3D 0x7000
>  #if ASIC_FAMILY >=3D CHIP_PLUM_BONITO
> +var SQ_WAVE_TRAPSTS_HOST_TRAP_SHIFT            =3D 16
>  var SQ_WAVE_TRAPSTS_WAVE_START_MASK            =3D 0x20000
> +var SQ_WAVE_TRAPSTS_WAVE_START_SHIFT           =3D 17
>  var SQ_WAVE_TRAPSTS_WAVE_END_MASK              =3D 0x40000
>  var SQ_WAVE_TRAPSTS_TRAP_AFTER_INST_MASK       =3D 0x100000
>  #endif
> @@ -137,14 +140,23 @@ var SQ_WAVE_IB_STS_RCNT_FIRST_REPLAY_MASK =3D 0x003=
F8000
>
>  var SQ_WAVE_MODE_DEBUG_EN_MASK                 =3D 0x800
>
> +var S_TRAPSTS_RESTORE_PART_1_SIZE              =3D SQ_WAVE_TRAPSTS_SAVEC=
TX_SHIFT
> +var S_TRAPSTS_RESTORE_PART_2_SHIFT             =3D SQ_WAVE_TRAPSTS_ILLEG=
AL_INST_SHIFT
> +
>  #if ASIC_FAMILY < CHIP_PLUM_BONITO
>  var S_TRAPSTS_NON_MASKABLE_EXCP_MASK           =3D SQ_WAVE_TRAPSTS_MEM_V=
IOL_MASK|SQ_WAVE_TRAPSTS_ILLEGAL_INST_MASK
> +var S_TRAPSTS_RESTORE_PART_2_SIZE              =3D 32 - S_TRAPSTS_RESTOR=
E_PART_2_SHIFT
> +var S_TRAPSTS_RESTORE_PART_3_SHIFT             =3D 0
> +var S_TRAPSTS_RESTORE_PART_3_SIZE              =3D 0
>  #else
>  var S_TRAPSTS_NON_MASKABLE_EXCP_MASK           =3D SQ_WAVE_TRAPSTS_MEM_V=
IOL_MASK         |\
>                                                   SQ_WAVE_TRAPSTS_ILLEGAL=
_INST_MASK     |\
>                                                   SQ_WAVE_TRAPSTS_WAVE_ST=
ART_MASK       |\
>                                                   SQ_WAVE_TRAPSTS_WAVE_EN=
D_MASK         |\
>                                                   SQ_WAVE_TRAPSTS_TRAP_AF=
TER_INST_MASK
> +var S_TRAPSTS_RESTORE_PART_2_SIZE              =3D SQ_WAVE_TRAPSTS_HOST_=
TRAP_SHIFT - SQ_WAVE_TRAPSTS_ILLEGAL_INST_SHIFT
> +var S_TRAPSTS_RESTORE_PART_3_SHIFT             =3D SQ_WAVE_TRAPSTS_WAVE_=
START_SHIFT
> +var S_TRAPSTS_RESTORE_PART_3_SIZE              =3D 32 - S_TRAPSTS_RESTOR=
E_PART_3_SHIFT
>  #endif
>  var S_TRAPSTS_HWREG                            =3D HW_REG_TRAPSTS
>  var S_TRAPSTS_SAVE_CONTEXT_MASK                        =3D SQ_WAVE_TRAPS=
TS_SAVECTX_MASK
> @@ -157,6 +169,7 @@ var SQ_WAVE_EXCP_FLAG_PRIV_SAVE_CONTEXT_MASK        =
=3D 0x20
>  var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_MASK   =3D 0x40
>  var SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT  =3D 6
>  var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_MASK      =3D 0x80
> +var SQ_WAVE_EXCP_FLAG_PRIV_HOST_TRAP_SHIFT     =3D 7
>  var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_MASK     =3D 0x100
>  var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT    =3D 8
>  var SQ_WAVE_EXCP_FLAG_PRIV_WAVE_END_MASK       =3D 0x200
> @@ -173,6 +186,11 @@ var S_TRAPSTS_NON_MASKABLE_EXCP_MASK               =
=3D SQ_WAVE_EXCP_FLAG_PRIV_MEM_VIOL_MASK          |\
>                                                   SQ_WAVE_EXCP_FLAG_PRIV_=
WAVE_START_MASK        |\
>                                                   SQ_WAVE_EXCP_FLAG_PRIV_=
WAVE_END_MASK          |\
>                                                   SQ_WAVE_EXCP_FLAG_PRIV_=
TRAP_AFTER_INST_MASK
> +var S_TRAPSTS_RESTORE_PART_1_SIZE              =3D SQ_WAVE_EXCP_FLAG_PRI=
V_SAVE_CONTEXT_SHIFT
> +var S_TRAPSTS_RESTORE_PART_2_SHIFT             =3D SQ_WAVE_EXCP_FLAG_PRI=
V_ILLEGAL_INST_SHIFT
> +var S_TRAPSTS_RESTORE_PART_2_SIZE              =3D SQ_WAVE_EXCP_FLAG_PRI=
V_HOST_TRAP_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> +var S_TRAPSTS_RESTORE_PART_3_SHIFT             =3D SQ_WAVE_EXCP_FLAG_PRI=
V_WAVE_START_SHIFT
> +var S_TRAPSTS_RESTORE_PART_3_SIZE              =3D 32 - S_TRAPSTS_RESTOR=
E_PART_3_SHIFT
>  var BARRIER_STATE_SIGNAL_OFFSET                        =3D 16
>  var BARRIER_STATE_VALID_OFFSET                 =3D 0
>  #endif
> @@ -1386,17 +1404,17 @@ L_SKIP_BARRIER_RESTORE:
>         s_setreg_b32    hwreg(HW_REG_SHADER_XNACK_MASK), s_restore_xnack_=
mask
>  #endif
>
> -#if ASIC_FAMILY < CHIP_GFX12
> -       s_setreg_b32    hwreg(S_TRAPSTS_HWREG), s_restore_trapsts
> -#else
> -       // EXCP_FLAG_PRIV.SAVE_CONTEXT and HOST_TRAP may have changed.
> +       // {TRAPSTS/EXCP_FLAG_PRIV}.SAVE_CONTEXT and HOST_TRAP may have c=
hanged.
>         // Only restore the other fields to avoid clobbering them.
> -       s_setreg_b32    hwreg(S_TRAPSTS_HWREG, 0, SQ_WAVE_EXCP_FLAG_PRIV_=
SAVE_CONTEXT_SHIFT), s_restore_trapsts
> -       s_lshr_b32      s_restore_trapsts, s_restore_trapsts, SQ_WAVE_EXC=
P_FLAG_PRIV_ILLEGAL_INST_SHIFT
> -       s_setreg_b32    hwreg(S_TRAPSTS_HWREG, SQ_WAVE_EXCP_FLAG_PRIV_ILL=
EGAL_INST_SHIFT, 1), s_restore_trapsts
> -       s_lshr_b32      s_restore_trapsts, s_restore_trapsts, SQ_WAVE_EXC=
P_FLAG_PRIV_WAVE_START_SHIFT - SQ_WAVE_EXCP_FLAG_PRIV_ILLEGAL_INST_SHIFT
> -       s_setreg_b32    hwreg(S_TRAPSTS_HWREG, SQ_WAVE_EXCP_FLAG_PRIV_WAV=
E_START_SHIFT, 32 - SQ_WAVE_EXCP_FLAG_PRIV_WAVE_START_SHIFT), s_restore_tra=
psts
> -#endif
> +       s_setreg_b32    hwreg(S_TRAPSTS_HWREG, 0, S_TRAPSTS_RESTORE_PART_=
1_SIZE), s_restore_trapsts
> +       s_lshr_b32      s_restore_trapsts, s_restore_trapsts, S_TRAPSTS_R=
ESTORE_PART_2_SHIFT
> +       s_setreg_b32    hwreg(S_TRAPSTS_HWREG, S_TRAPSTS_RESTORE_PART_2_S=
HIFT, S_TRAPSTS_RESTORE_PART_2_SIZE), s_restore_trapsts
> +
> +if S_TRAPSTS_RESTORE_PART_3_SIZE > 0
> +       s_lshr_b32      s_restore_trapsts, s_restore_trapsts, S_TRAPSTS_R=
ESTORE_PART_3_SHIFT - S_TRAPSTS_RESTORE_PART_2_SHIFT
> +       s_setreg_b32    hwreg(S_TRAPSTS_HWREG, S_TRAPSTS_RESTORE_PART_3_S=
HIFT, S_TRAPSTS_RESTORE_PART_3_SIZE), s_restore_trapsts
> +end
> +
>         s_setreg_b32    hwreg(HW_REG_MODE), s_restore_mode
>
>         // Restore trap temporaries 4-11, 13 initialized by SPI debug dis=
patch logic
> --
> 2.34.1
>
