Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AA6C04FF9
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 13:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD21210E43A;
	Tue, 16 Apr 2024 13:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S0oprPaB";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E9A10E43A
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 13:55:45 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2a4df5d83c7so2888597a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 06:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713275744; x=1713880544; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlvZQw5iF3Zz2V+sIKzF+6waO+AXpzI5STfdJacqvoI=;
 b=S0oprPaBhcwAfpDXFPANqC6ih4s70Vy258XXji0uALwo+d9QPh2T71NKV1n0f26hcq
 iAqRGROQ/97DWqI1bu4RmOqXKMWabgfMmNi4Sng9Xv25Hvi/he5muSRc74fQYWIM7aKL
 +V3sqU3I9zjUSEWTIjHQw3pV/lk11zwabkC6zD9HHgLcHPlE0ApAxIv7yFQRW7sgoFK/
 A3dcrPzZhN74zXR9YCrywnEnG4TYU9iKyd9Mt535J+lE75qSUdpDSJO0V9LMFo8QJjqR
 RPhfaQuVfti1HlUhtTZk/9IEDeTDHs+wzADXBex2Ya57rK25deUYM8YIe5gRcYJBKlbl
 1M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713275744; x=1713880544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlvZQw5iF3Zz2V+sIKzF+6waO+AXpzI5STfdJacqvoI=;
 b=uxtqo+dJcxKDz2LXnHi7oqi6SOSYAWnCzMEZYd+o4ftbTJe1S9E/YxeRXBh11rpL0K
 v6KeelgJOSipnxsXy8QkpFjmny38C1B8KA004dTGjE5qJqwuPdnVR4gpliIRhZJf4Vll
 DTmV3w1jYrwAMt9hHbT6u/LV23DkmStuC9SN4EsZyJavZWLYu1fk7Rf0Aypuc6qCIt+C
 0a79HT4XvwOtqZAV4bEY2o1MP1hrNDDvIRayywWgnVHoh1XhJNaee5oAUP88EMzFPYdc
 hmB8ell/0s3fUWQl9KccSkKiHUmjM4ujeuwHj5iwztH9jIV7f/HswSiyXx43oJ1G0tyz
 RtMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWriQCUNrCuGoKQLkYEwr9IoVk1BauS1+pmiNKN1t1T+oYdktA2937HAya0yI1pO489oF00mOW4XQV8cHEXlglYVRHC89wMLQoh6Qgf8Q==
X-Gm-Message-State: AOJu0YxqxULdU1TYkbqRY6/F0OdXdLN5w68MXCiwj4lRd14DIn/Mj/Ck
 YxQKOB1hQiNYLziteX1I3gH6J4LlUXBcm8EuotURnpCSKuUZHyriDEHbhAy0n7DYiVH6KSCoZA7
 VO3fVcUF2MLx7B5+UhDOHvjtnTS0=
X-Google-Smtp-Source: AGHT+IGvOLI9l1wPTev4tPf8ClLvnD5Hftg35ZTqyny8trBeZI9ymdM+8JpLAbxuPMOzGGejK6/LzqpDU8VrBOx2W6c=
X-Received: by 2002:a17:90a:1190:b0:2a2:d48:9d50 with SMTP id
 e16-20020a17090a119000b002a20d489d50mr11936713pja.44.1713275744244; Tue, 16
 Apr 2024 06:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240416120804.607272-1-sunil.khatri@amd.com>
 <20240416120804.607272-3-sunil.khatri@amd.com>
In-Reply-To: <20240416120804.607272-3-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Apr 2024 09:55:31 -0400
Message-ID: <CADnq5_M3_4pjstwxsfiLAmDXLUHMVVeTHyOm-2gKTzaXZ7QFKQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] drm/amdgpu: add support of gfx10 register dump
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

On Tue, Apr 16, 2024 at 8:08=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Adding gfx10 gc registers to be used for register
> dump via devcoredump during a gpu reset.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  12 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 131 +++++++++++++++++-
>  .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
>  4 files changed, 158 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index e0d7f4ee7e16..e016ac33629d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -139,6 +139,18 @@ enum amdgpu_ss {
>         AMDGPU_SS_DRV_UNLOAD
>  };
>
> +struct hwip_reg_entry {
> +       u32     hwip;
> +       u32     inst;
> +       u32     seg;
> +       u32     reg_offset;
> +};
> +
> +struct reg_pair {
> +       u32     offset;
> +       u32     value;
> +};
> +
>  struct amdgpu_watchdog_timer {
>         bool timeout_fatal_disable;
>         uint32_t period; /* maxCycles =3D (1 << period), the number of cy=
cles before a timeout */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 04a86dff71e6..295a2c8d2e48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -433,6 +433,10 @@ struct amdgpu_gfx {
>         uint32_t                        num_xcc_per_xcp;
>         struct mutex                    partition_mutex;
>         bool                            mcbp; /* mid command buffer preem=
ption */
> +
> +       /* IP reg dump */
> +       struct reg_pair                 *ip_dump;
> +       uint32_t                        reg_count;
>  };
>
>  struct amdgpu_gfx_ras_reg_entry {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index a0bc4196ff8b..46e136609ff1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
>  MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
>  MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
>
> +static const struct hwip_reg_entry gc_reg_list_10_1[] =3D {
> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS2) },
> +       { SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS3) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT1) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_STALLED_STAT2) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STALLED_STAT1) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_BUSY_STAT) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_BUSY_STAT2) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_BUSY_STAT2) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPF_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_ERROR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_GFX_HPD_STATUS0) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_BASE) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_RPTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB_WPTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_BASE) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_RPTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB0_WPTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_BASE) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_RPTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB1_WPTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_BASE) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_RB2_WPTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_CMD_BUFSZ) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_CMD_BUFSZ) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_CMD_BUFSZ) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_CMD_BUFSZ) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_LO) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BASE_HI) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB1_BUFSZ) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_LO) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BASE_HI) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_IB2_BUFSZ) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_LO) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BASE_HI) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB1_BUFSZ) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_LO) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BASE_HI) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_IB2_BUFSZ) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCPF_UTCL1_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCPC_UTCL1_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCPG_UTCL1_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmGDS_PROTECTION_FAULT) },
> +       { SOC15_REG_ENTRY(GC, 0, mmGDS_VM_PROTECTION_FAULT) },
> +       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmIA_UTCL1_STATUS_2) },
> +       { SOC15_REG_ENTRY(GC, 0, mmPA_CL_CNTL_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_UTCL1_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRMI_UTCL1_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmSQC_DCACHE_UTCL0_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmSQC_ICACHE_UTCL0_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmSQG_UTCL0_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmTCP_UTCL0_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmWD_UTCL1_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL) },
> +       { SOC15_REG_ENTRY(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_DEBUG) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC_CNTL) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_CNTL) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CE_INSTR_PNTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC1_INSTR_PNTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MEC2_INSTR_PNTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_MES_INSTR_PNTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_ME_INSTR_PNTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_PFP_INSTR_PNTR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_STAT) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_COMMAND) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_MESSAGE) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_1) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_2) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_3) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_ARGUMENT_4) },
> +       { SOC15_REG_ENTRY(GC, 0, mmSMU_RLC_RESPONSE) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SAFE_MODE) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SMU_SAFE_MODE) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_GPM_STAT_2) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_SPP_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_INT_STAT) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_GENERAL_6) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_A) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_B) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR) },
> +       { SOC15_REG_ENTRY(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) }
> +};

Might want to add the string name for the register as well.  It would
be nice to print the register name rather than the offset in the
devcoredump.

E.g.,


> +
>  static const struct soc15_reg_golden golden_settings_gc_10_1[] =3D {
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffffff, 0x00=
400014),
>         SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL, 0xfcff8fff, 0x=
f8000100),
> @@ -4490,6 +4583,23 @@ static int gfx_v10_0_compute_ring_init(struct amdg=
pu_device *adev, int ring_id,
>                              hw_prio, NULL);
>  }
>
> +static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev)
> +{
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_10_1);
> +       struct reg_pair *ptr;
> +
> +       ptr =3D kcalloc(reg_count, sizeof(struct reg_pair), GFP_KERNEL);

I think you only need to allocate enough memory to store the register
values.  We already have the offsets in the array above.
{ SOC15_REG_ENTRY(GC, 0, mmGRBM_STATUS), "mmGRBM_STATUS" },

> +       if (ptr =3D=3D NULL) {
> +               DRM_ERROR("Failed to allocate memory for IP Dump\n");
> +               adev->gfx.ip_dump =3D NULL;
> +               adev->gfx.reg_count =3D 0;
> +       }
> +       else {
> +               adev->gfx.ip_dump =3D ptr;
> +               adev->gfx.reg_count =3D reg_count;
> +       }
> +}
> +
>  static int gfx_v10_0_sw_init(void *handle)
>  {
>         int i, j, k, r, ring_id =3D 0;
> @@ -4642,6 +4752,8 @@ static int gfx_v10_0_sw_init(void *handle)
>
>         gfx_v10_0_gpu_early_init(adev);
>
> +       gfx_v10_0_alloc_dump_mem(adev);
> +
>         return 0;
>  }
>
> @@ -4694,6 +4806,8 @@ static int gfx_v10_0_sw_fini(void *handle)
>
>         gfx_v10_0_free_microcode(adev);
>
> +       kfree(adev->gfx.ip_dump);
> +
>         return 0;
>  }
>
> @@ -9154,6 +9268,21 @@ static void gfx_v10_0_emit_mem_sync(struct amdgpu_=
ring *ring)
>         amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
>  }
>
> +static void gfx_v10_ip_dump(void *handle)
> +{
> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +       uint32_t i;
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_10_1);
> +
> +       if (!adev->gfx.ip_dump)
> +               return;
> +

Need turn disallow gfxoff before reading the gfx registers:

amdgpu_gfx_off_ctrl(adev, false);

> +       for (i =3D 0; i < reg_count; i++) {
> +               adev->gfx.ip_dump[i].offset =3D gc_reg_list_10_1[i].reg_o=
ffset;

No need to store the offset.  We already have it in the static array above.

> +               adev->gfx.ip_dump[i].value =3D RREG32(SOC15_REG_ENTRY_OFF=
SET(gc_reg_list_10_1[i]));
> +       }

And then allow it again:

amdgpu_gfx_off_ctrl(adev, true);

> +}
> +
>  static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {
>         .name =3D "gfx_v10_0",
>         .early_init =3D gfx_v10_0_early_init,
> @@ -9170,7 +9299,7 @@ static const struct amd_ip_funcs gfx_v10_0_ip_funcs=
 =3D {
>         .set_clockgating_state =3D gfx_v10_0_set_clockgating_state,
>         .set_powergating_state =3D gfx_v10_0_set_powergating_state,
>         .get_clockgating_state =3D gfx_v10_0_get_clockgating_state,
> -       .dump_ip_state =3D NULL,
> +       .dump_ip_state =3D gfx_v10_ip_dump,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx =3D {
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h b=
/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> index 4908044f7409..4c8e7fdb6976 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> @@ -4830,6 +4830,8 @@
>  #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                         =
                               0
>  #define mmGB_EDC_MODE                                                   =
                               0x1e1e
>  #define mmGB_EDC_MODE_BASE_IDX                                          =
                               0
> +#define mmCP_DEBUG                                                      =
                               0x1e1f
> +#define mmCP_DEBUG_BASE_IDX                                             =
                               0
>  #define mmCP_FETCHER_SOURCE                                             =
                               0x1e22
>  #define mmCP_FETCHER_SOURCE_BASE_IDX                                    =
                               0
>  #define mmCP_PQ_WPTR_POLL_CNTL                                          =
                               0x1e23
> @@ -7778,6 +7780,8 @@
>  #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                             =
                               1
>  #define mmCP_MES_DOORBELL_CONTROL6                                      =
                               0x2841
>  #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                             =
                               1
> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                             =
                               0x2842
> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX                    =
                               1
>  #define mmCP_MES_GP0_LO                                                 =
                               0x2843
>  #define mmCP_MES_GP0_LO_BASE_IDX                                        =
                               1
>  #define mmCP_MES_GP0_HI                                                 =
                               0x2844
> @@ -9332,10 +9336,16 @@
>  #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                                   =
                               1
>  #define mmRLC_LB_CNTR_1                                                 =
                               0x4c1c
>  #define mmRLC_LB_CNTR_1_BASE_IDX                                        =
                               1
> +#define mmRLC_GPM_DEBUG_INST_ADDR                                       =
                               0x4c1d
> +#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                              =
                               1
>  #define mmRLC_JUMP_TABLE_RESTORE                                        =
                               0x4c1e
>  #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                               =
                               1
>  #define mmRLC_PG_DELAY_2                                                =
                               0x4c1f
>  #define mmRLC_PG_DELAY_2_BASE_IDX                                       =
                               1
> +#define mmRLC_GPM_DEBUG_INST_A                                          =
                               0x4c22
> +#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                                 =
                               1
> +#define mmRLC_GPM_DEBUG_INST_B                                          =
                               0x4c23
> +#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                                 =
                               1
>  #define mmRLC_GPU_CLOCK_COUNT_LSB                                       =
                               0x4c24
>  #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                              =
                               1
>  #define mmRLC_GPU_CLOCK_COUNT_MSB                                       =
                               0x4c25
> @@ -9720,6 +9730,8 @@
>  #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                            =
                               1
>  #define mmRLC_LB_CNTR_2                                                 =
                               0x4de7
>  #define mmRLC_LB_CNTR_2_BASE_IDX                                        =
                               1
> +#define mmRLC_LX6_CORE_PDEBUG_INST                                      =
                               0x4deb
> +#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                             =
                               1
>  #define mmRLC_CPAXI_DOORBELL_MON_CTRL                                   =
                               0x4df1
>  #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                          =
                               1
>  #define mmRLC_CPAXI_DOORBELL_MON_STAT                                   =
                               0x4df2
> --
> 2.34.1
>
