Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31A1C25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 13:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44AFE113AA8;
	Wed, 29 May 2024 13:46:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kMS6iINW";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9552113AA8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 13:46:33 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2c19ddf5fc3so115866a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 06:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716990393; x=1717595193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mC4w+3SVvjoYR6OBzYRssZF0PRus4o+0791erjyClQM=;
 b=kMS6iINWLv/U7pX0yX7RmRVg/g8hwjlaA1YLv129BixP08Ig3C9qtfLNx9dccsIWKU
 M8U2UU4+Qi2jW+DD9xCF1xicyxs9t6Nay8Ilyz+KFoznY6OQch+7XxqKPcsh8Aird+Xw
 Lq6K7KIpIybU6m/vQsswsJGjFlyd4dB8pTyqY/HI5ThCpgjxWV2UejLAakdUHzwVn4hQ
 f/PjzNK+ZJZMJ9Iz+khw3421oBmXwezoi1CL3LhwUWq1Kz6kQozpfVehleu/oTaU6paf
 iaJoIhb7WnIajSE4JuAQv5AgDoZK5A8F/ztrkqfFXaa2zPXAwu/Ne2uywUpar5kk+IJq
 KBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716990393; x=1717595193;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mC4w+3SVvjoYR6OBzYRssZF0PRus4o+0791erjyClQM=;
 b=jb7E8fE40+HS8Bgz4iW0HImYiR2nZXwsWPtC4NsrXbiiK8k44gOR+3TSmsMOS4ZZJG
 iIkk3+/AhHA3n8NKN6ybC9dc/wYy6AMY6uFshS5n3iI0E4LvnK9y4/IZcRajCIltLXr0
 QOTX9/gln9SkkQxnUZhC9KgHyWrZdHWmzMF30tmgTHrjgQR3AEw24PKb42x6Em6ceLHI
 H71otlSXBec0SyX0Uuc7nNGo5oN8xCM4A9vS0Npa323vmulgJ73gA3etmqwWe5Ne/J83
 VITNsHHdqfT/G8XymvanSlKCsMQwbZi9zDa4u6DWxgRnVRnZ9pmf7pIP/wWUiZIDS8Wl
 QCcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk6URsppi1uVBBuKsdcS/kg451kglBzkzx9w5JTr7kYENh2ja7N51PjskhPFO7/KrtoBZi2vl2bHRzQpzIevtErtQq6iD0jTfz3keBBg==
X-Gm-Message-State: AOJu0YxSLCNrHfuZUK/VZlvTfrU413qGOYnvdjrjuDbGq1QLUzLA6D53
 KGkZlgvypjz2G5Ne1PcQgQhAirtpG5lgt5GngU9xVECA2iveLnYWbqNat31+/rRCNoWeMmR0AnU
 Megz3wxoOk+4Uiro0oFW2cegipocO7v3L
X-Google-Smtp-Source: AGHT+IGzRZzI9qRwF0RKFN4VzwpEXmyWuIM5wWYVsPifGBGVkI5lta8kyMAaQB9PQRiwaYUbB5FQovrEVqaIQ0xAh9E=
X-Received: by 2002:a17:90b:3750:b0:2c1:948b:6f27 with SMTP id
 98e67ed59e1d1-2c1948b7dd4mr827531a91.26.1716990392903; Wed, 29 May 2024
 06:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240529095032.1669886-1-sunil.khatri@amd.com>
 <20240529095032.1669886-2-sunil.khatri@amd.com>
In-Reply-To: <20240529095032.1669886-2-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 May 2024 09:46:21 -0400
Message-ID: <CADnq5_P1JbaSh_g2e2hwJbmwzpQu81snSGqbCZDYcscooUS_Gg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] drm/amdgpu: add gfx9 register support in ipdump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Wed, May 29, 2024 at 5:50=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Add general registers of gfx9 in ipdump for
> devcoredump support.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 124 +++++++++++++++++++++++++-
>  1 file changed, 123 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 3c8c5abf35ab..528a20393313 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -149,6 +149,94 @@ MODULE_FIRMWARE("amdgpu/aldebaran_sjt_mec2.bin");
>  #define mmGOLDEN_TSC_COUNT_LOWER_Renoir                0x0026
>  #define mmGOLDEN_TSC_COUNT_LOWER_Renoir_BASE_IDX       1
>
> +static const struct amdgpu_hwip_reg_entry gc_reg_list_9[] =3D {
> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS2),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT2),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_ERROR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPF_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPC_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPG_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmGDS_PROTECTION_FAULT),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmGDS_VM_PROTECTION_FAULT),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_CNTL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmPA_CL_CNTL_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRMI_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQC_DCACHE_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQC_ICACHE_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQ_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmTCP_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmWD_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmVM_L2_PROTECTION_FAULT_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_DEBUG),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_CNTL),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC1_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC2_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_COMMAND),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_MESSAGE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_1),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_2),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmSMU_RLC_RESPONSE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SAFE_MODE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
> +       /* cp header registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_ME2_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_HEADER_DUMP),
> +       /* SE status registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
> +};

This list should probably be split between gfx and non-gfx registers
since MI chips don't have a gfx pipe, only compute.  If
adev->gfx.num_gfx_rings =3D=3D 0, then the chip does not have a gfx pipe.
Also MI300 probably needs special handling because it has multiple
XCCs.  For now, you might want to skip the IP dump for gfx9 chips with
adev->gfx.num_gfx_rings =3D=3D 0, and then add new register lists for the
MI parts later.

Alex

> +
>  enum ta_ras_gfx_subblock {
>         /*CPC*/
>         TA_RAS_BLOCK__GFX_CPC_INDEX_START =3D 0,
> @@ -1994,6 +2082,20 @@ static int gfx_v9_0_compute_ring_init(struct amdgp=
u_device *adev, int ring_id,
>                                 hw_prio, NULL);
>  }
>
> +static void gfx_v9_0_alloc_ip_dump(struct amdgpu_device *adev)
> +{
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_9);
> +       uint32_t *ptr;
> +
> +       ptr =3D kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> +       if (ptr =3D=3D NULL) {
> +               DRM_ERROR("Failed to allocate memory for IP Dump\n");
> +               adev->gfx.ip_dump_core =3D NULL;
> +       } else {
> +               adev->gfx.ip_dump_core =3D ptr;
> +       }
> +}
> +
>  static int gfx_v9_0_sw_init(void *handle)
>  {
>         int i, j, k, r, ring_id;
> @@ -2171,6 +2273,8 @@ static int gfx_v9_0_sw_init(void *handle)
>                 return -EINVAL;
>         }
>
> +       gfx_v9_0_alloc_ip_dump(adev);
> +
>         return 0;
>  }
>
> @@ -2206,6 +2310,8 @@ static int gfx_v9_0_sw_fini(void *handle)
>         }
>         gfx_v9_0_free_microcode(adev);
>
> +       kfree(adev->gfx.ip_dump_core);
> +
>         return 0;
>  }
>
> @@ -6840,6 +6946,22 @@ static void gfx_v9_0_emit_wave_limit(struct amdgpu=
_ring *ring, bool enable)
>         }
>  }
>
> +static void gfx_v9_ip_dump(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       uint32_t i;
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_9);
> +
> +       if (!adev->gfx.ip_dump_core)
> +               return;
> +
> +       amdgpu_gfx_off_ctrl(adev, false);
> +       for (i =3D 0; i < reg_count; i++)
> +               adev->gfx.ip_dump_core[i] =3D RREG32(SOC15_REG_ENTRY_OFFS=
ET(gc_reg_list_9[i]));
> +       amdgpu_gfx_off_ctrl(adev, true);
> +
> +}
> +
>  static const struct amd_ip_funcs gfx_v9_0_ip_funcs =3D {
>         .name =3D "gfx_v9_0",
>         .early_init =3D gfx_v9_0_early_init,
> @@ -6856,7 +6978,7 @@ static const struct amd_ip_funcs gfx_v9_0_ip_funcs =
=3D {
>         .set_clockgating_state =3D gfx_v9_0_set_clockgating_state,
>         .set_powergating_state =3D gfx_v9_0_set_powergating_state,
>         .get_clockgating_state =3D gfx_v9_0_get_clockgating_state,
> -       .dump_ip_state =3D NULL,
> +       .dump_ip_state =3D gfx_v9_ip_dump,
>         .print_ip_state =3D NULL,
>  };
>
> --
> 2.34.1
>
