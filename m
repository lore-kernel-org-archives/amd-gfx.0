Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FDBC52D7C
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Aug 2024 16:10:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C833A10E384;
	Tue, 13 Aug 2024 16:10:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R/YfH7Si";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4731910E384
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 16:10:29 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-1fc65329979so51810825ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Aug 2024 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723565429; x=1724170229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmFeCtswayIgQp+eVIgXlNfd3NLUWlBXCA3WEP10b1k=;
 b=R/YfH7Sit/Nm6/7XipXdNjU+AEuQb8T8KBctxLmo5JqoEvG3c6iqQCsj2XtN1+y1lV
 TDYY+wScN+mHRbMJOEmqV9150knWZ65lKXJXDkeR1oX9jeF5fmKyzzMFht22CgmbbDtk
 SxTBJnPABlo1uL9WNTkmUpdgR9sZDdD+JKmpvB5fb5gG0+z5xrIcAHdEIQwLG2Llq0D0
 gC+5OP3Edmy8bg8m1MHtTwtGqajrmLIa9SNnI6brhLDqJYbey6vCI5DSvBAGq9XoV7J+
 B1swjhsgu+jJjXSW7obuhLg6AT5yf+nlAPbVF4iJMXM9jYpaFDOxGCOuyTm6NHCr+ppi
 nGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723565429; x=1724170229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmFeCtswayIgQp+eVIgXlNfd3NLUWlBXCA3WEP10b1k=;
 b=JSyKAWUiD+Euf621hoqAwfF5JZD9zgjyF0BFiwYImCjbIVTROOxqe5eMEkF2k9lHL7
 5ORQ9Wi2zT3xYtAcFAtjq6afvOCoevu5tDgjENBA9wwJ3W+Xgz3TYY4KPnWBACfua/FX
 JE3A6k13Tzvg9zU7bomqSYscqguennOr4LZmnXvk+A3blG6VocksY8xArpFJT5L/92X6
 gK6/3OvmVlYHM6+2ZeMwIRl9n+docB9ZriUrBQdaGjcHinV3ehB5xABgIq0mktC0/UXp
 uYZCHAqvvCiqgU2eqEQpOnm8R/dIisfz0rrxv1+GRzBWyzZDGDb55U+SZCV1j9XAsbmD
 SU8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwqFigEbOx7Ta0HwFwIwfjFacjlW/FOMbEeWNtlW8/eNGMUO5xLHn3jTl5vnE82cOShOwAu0jTM7TPROU7tvIXWevcMjdmIEc60esupw==
X-Gm-Message-State: AOJu0YyIMAcgkQSlyOvvozXO+qjkhwuis8TkqRq2wrmIPanXaQxzm2Rp
 iC0WbD9bSumWKNvlTWaIi2UDJ6zOgCmADUU326L50/2l2BASSH1yBeJtIF6ZITZAwGG7RKuskEs
 1dc8PBRkWUaiJ+5wiQVzwgqreXXxdzvJw
X-Google-Smtp-Source: AGHT+IFBWGH3qT8SD1MonFxkqIb/QQxN/hZQU6unTMRlWZ8IkQENVemS+/su2SPocLWcVIxTXizdTzBOu8OYsmkUILg=
X-Received: by 2002:a17:902:f708:b0:1fc:5f3a:4d9a with SMTP id
 d9443c01a7336-201ca1d827amr56194555ad.58.1723565428524; Tue, 13 Aug 2024
 09:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240809124822.4063927-1-sunil.khatri@amd.com>
In-Reply-To: <20240809124822.4063927-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Aug 2024 12:10:16 -0400
Message-ID: <CADnq5_NFAvqWNY1q+3HZaiAxXpoWM=ncFpLMDaW+6=d7wgzjQg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/amdgpu: add gfx9_4_3 register support in ipdump
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

On Fri, Aug 9, 2024 at 8:54=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> Add general registers of gfx9_4_3 in ipdump for
> devcoredump support.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 133 +++++++++++++++++++++++-
>  1 file changed, 132 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 8455fda750a6..3bd84acba643 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -63,6 +63,94 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
>  #define NORMALIZE_XCC_REG_OFFSET(offset) \
>         (offset & 0xFFFF)
>
> +static const struct amdgpu_hwip_reg_entry gc_reg_list_9_4_3[] =3D {
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB1_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB2_WPTR),

Actually, I'm not sure if there is much value in dumping the CP_RB_*
registers as there is no ME0.  I guess the registers may exist, but I
don't there is anything behind them.  I guess if they dumped ok, we
can leave them.

> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB1_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_IB2_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),

Same with the CP_IB and CP_CE registers.

> +       SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGDS_PROTECTION_FAULT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGDS_VM_PROTECTION_FAULT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_CNTL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),

same for IA and PA registers.

> +       SOC15_REG_ENTRY_STR(GC, 0, regRLC_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regSQC_DCACHE_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regSQC_ICACHE_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regSQ_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regTCP_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regVM_L2_PROTECTION_FAULT_CNTL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regVM_L2_PROTECTION_FAULT_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC1_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC2_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),

Same for CP_CE, CP_PFP, CP_ME

> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRLC_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_COMMAND),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_MESSAGE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_ARGUMENT_1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_ARGUMENT_2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regSMU_RLC_RESPONSE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRLC_SAFE_MODE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRLC_SMU_SAFE_MODE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRLC_INT_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRLC_GPM_GENERAL_6),
> +       /* cp header registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CE_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME2_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),

Same for CP_CE, CP_PFP, CP_ME

> +       /* SE status registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE3)
> +};
> +
>  struct amdgpu_gfx_ras gfx_v9_4_3_ras;
>
>  static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
> @@ -885,6 +973,22 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgp=
u_device *adev, int ring_id,
>                                 hw_prio, NULL);
>  }
>
> +static void gfx_v9_4_3_alloc_ip_dump(struct amdgpu_device *adev)
> +{
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_9_4_3);
> +       uint32_t *ptr, num_xcc;
> +
> +       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +
> +       ptr =3D kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL=
);
> +       if (!ptr) {
> +               DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
> +               adev->gfx.ip_dump_core =3D NULL;
> +       } else {
> +               adev->gfx.ip_dump_core =3D ptr;
> +       }
> +}
> +
>  static int gfx_v9_4_3_sw_init(void *handle)
>  {
>         int i, j, k, r, ring_id, xcc_id, num_xcc;
> @@ -986,6 +1090,8 @@ static int gfx_v9_4_3_sw_init(void *handle)
>         if (!amdgpu_sriov_vf(adev))
>                 r =3D amdgpu_gfx_sysfs_init(adev);
>
> +       gfx_v9_4_3_alloc_ip_dump(adev);
> +
>         return r;
>  }
>
> @@ -1010,6 +1116,8 @@ static int gfx_v9_4_3_sw_fini(void *handle)
>         if (!amdgpu_sriov_vf(adev))
>                 amdgpu_gfx_sysfs_fini(adev);
>
> +       kfree(adev->gfx.ip_dump_core);
> +
>         return 0;
>  }
>
> @@ -4196,6 +4304,29 @@ static void gfx_v9_4_3_ring_insert_nop(struct amdg=
pu_ring *ring, uint32_t num_no
>                 amdgpu_ring_write(ring, ring->funcs->nop);
>  }
>
> +static void gfx_v9_4_3_ip_dump(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       uint32_t i;
> +       uint32_t xcc_id, xcc_offset, num_xcc;
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_9_4_3);
> +
> +       if (!adev->gfx.ip_dump_core)
> +               return;
> +
> +       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +
> +       amdgpu_gfx_off_ctrl(adev, false);
> +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> +               xcc_offset =3D xcc_id * reg_count;
> +               for (i =3D 0; i < reg_count; i++)
> +                       adev->gfx.ip_dump_core[xcc_offset + i] =3D
> +                               RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg=
_list_9_4_3[i],
> +                                                                  GET_IN=
ST(GC, xcc_id)));
> +       }
> +       amdgpu_gfx_off_ctrl(adev, true);
> +}
> +
>  static const struct amd_ip_funcs gfx_v9_4_3_ip_funcs =3D {
>         .name =3D "gfx_v9_4_3",
>         .early_init =3D gfx_v9_4_3_early_init,
> @@ -4212,7 +4343,7 @@ static const struct amd_ip_funcs gfx_v9_4_3_ip_func=
s =3D {
>         .set_clockgating_state =3D gfx_v9_4_3_set_clockgating_state,
>         .set_powergating_state =3D gfx_v9_4_3_set_powergating_state,
>         .get_clockgating_state =3D gfx_v9_4_3_get_clockgating_state,
> -       .dump_ip_state =3D NULL,
> +       .dump_ip_state =3D gfx_v9_4_3_ip_dump,
>         .print_ip_state =3D NULL,
>  };
>
> --
> 2.34.1
>
