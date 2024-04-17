Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F080AC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 17:30:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81A7810F38F;
	Wed, 17 Apr 2024 17:30:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HsXqIB8U";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D00810F38F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 17:30:46 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-5d8ddbac4fbso4061948a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713375046; x=1713979846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eCaQEMVmK/UACHGCB7ac4PA/78iRHqRDxl/+aCfnD8=;
 b=HsXqIB8UP9F5PyAEnXPaHiBCuo4hZumkWJ4z8AlFJMnOgFLcXxkeO+YeIP/gkfRnfc
 q9eQ4UzAx/CFMhf+ZDzgoLd+Wkh8qn5PUwuuPfKnFDWtoKvBXSKY2BQWSCU/Ap82MLPi
 SQTAcE/53wq/CpRqwtUYv8J9WXrxkAkMuRpTzrWUeWH1HRlrG58aQ+udh4/ifMoKyK9U
 JIYeIJLLcUpN5hE8ZVFu7DyfGOhFha1jQRNF5eMpkUsDDT4SZQYgBoEptW/YJSaDgR0u
 omShNcaqq0T4vP8DWvwlznwaHU0qhhmbuUvBPB4oOp3QrbGhHbCFK+khH0m4IhKUqoJU
 MC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713375046; x=1713979846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eCaQEMVmK/UACHGCB7ac4PA/78iRHqRDxl/+aCfnD8=;
 b=W2jdONscNocxaDNaE/Q3teEdb7q3nHrtOBeRn3S8/XZ48H0mWETm+d4BHrARD5ucBk
 hWlKE6fSaWe7TrzegGX1smtFB+bsJX8A4o9N6g7vMV4kTzqMUZ5mAD5oRbYFLxcaednX
 6hr8jsbcyGI4dDPw9iIi5CXyruAVm3mnh3R8X44mr/Bq8E7bw+EcdBHEGNvy5p4azQaD
 bopNWkxOzBw2deELRudyBLDfuTfnHyaOxjSN0dnlNmFQYcyRBXyVrqKmQ+uI+Xrwm3XT
 fB9QloGD4pAjmRTKIlkxKs2H2FpEK9qGKiI9BhnPH40NQWRuJbS5giIW+Pegpmzfr8i8
 WHeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtxU3o4ZIB5zOa5/Nx3TZ0Fp2gcUo+05/i+SmFUtXhrXeq7kVNi+CI9T6qN6ulL/Y2e3QCPlmBJt1aeyF96lCKC9XbPw6ASOb8sFGaHQ==
X-Gm-Message-State: AOJu0YyAwh0qdsVvZO3FQ8sSJ+Nz4iapr42c4U7AxOU9+aJYGcv5AjjN
 itaAl7rcZ2sVmio6XYgUfgWJVoyAnRVVd+Tzm+cIiF3jhRUTH8FuWFMMK3pictreUX7Mb/ZmHz9
 Hst/M3RQ/AY0UKz/Uni6M4rtQJzCOtNKM
X-Google-Smtp-Source: AGHT+IEpdVh+r6lcl939uZY5KJ3WH4sUajE6QO6bIwqeVycgZgtafJ5PdJ7EdQxg5s9e/DcG3n2j43IbpNJayUWm73A=
X-Received: by 2002:a17:90a:6585:b0:2a6:f977:39e0 with SMTP id
 k5-20020a17090a658500b002a6f97739e0mr42559pjj.3.1713375045821; Wed, 17 Apr
 2024 10:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240417093809.168002-1-sunil.khatri@amd.com>
 <20240417093809.168002-2-sunil.khatri@amd.com>
 <CADnq5_MkYKO5Z3LBRdJsTO0+Wf+YWVgUONTt5Y1Lrm+6SXJfTQ@mail.gmail.com>
 <fbf4f592-77db-4087-9dcb-3d9a49302164@amd.com>
 <07e86900-125f-457f-95b0-1f6d4a6e9598@amd.com>
 <DS0PR12MB7804D33979E4F1CF29AC8722970F2@DS0PR12MB7804.namprd12.prod.outlook.com>
 <CADnq5_MQuZiRvTumvQVw6HxM7ZxQ25DPQbOc2aEu7Mxvm2RgNA@mail.gmail.com>
 <83a9afb6-6a2a-40e4-a86b-4a0d373a0cfa@amd.com>
In-Reply-To: <83a9afb6-6a2a-40e4-a86b-4a0d373a0cfa@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Apr 2024 13:30:33 -0400
Message-ID: <CADnq5_NpDU8usDe=G1VmaFKQOgOGB5AkbGO47sC38CvHAR_68A@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] drm/amdgpu: add support of gfx10 register dump
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Wed, Apr 17, 2024 at 1:01=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
>
> On 4/17/2024 10:21 PM, Alex Deucher wrote:
> > On Wed, Apr 17, 2024 at 12:24=E2=80=AFPM Lazar, Lijo <Lijo.Lazar@amd.co=
m> wrote:
> >> [AMD Official Use Only - General]
> >>
> >> Yes, right now that API doesn't return anything. What I meant is to ad=
d that check as well as coredump API is essentially used in hang situations=
.
> >>
> >> Old times, access to registers while in GFXOFF resulted in system hang=
 (basically it won't go beyond this point). If that happens, then the purpo=
se of the patch - to get the context of a device hang - is lost. We may not=
 even get a proper dmesg log.
> > Maybe add a call to amdgpu_get_gfx_off_status(), but unfortunately,
> > it's not implemented on every chip yet.
> So we need both the things do gfx_off and then try status and then read
> reg and enable gfx_off again.

RIght, but first we need to implement the get_gfxoff_status smu
callback for all of the chips that are missing it.

Alex

>
>   amdgpu_gfx_off_ctrl(adev, false);
>   r=3D amdgpu_get_gfx_off_status
>   if (!r) {
>
>         for (i =3D 0; i < reg_count; i++)
>                 adev->gfx.ip_dump[i] =3D
>                 RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
> }
> amdgpu_gfx_off_ctrl(adev, true);
>
> Sunil
>
> >
> > Alex
> >
> >> Thanks,
> >> Lijo
> >> -----Original Message-----
> >> From: Khatri, Sunil <Sunil.Khatri@amd.com>
> >> Sent: Wednesday, April 17, 2024 9:42 PM
> >> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Alex Deucher <alexdeucher@gmail.=
com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> >> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian =
<Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
> >> Subject: Re: [PATCH v5 2/6] drm/amdgpu: add support of gfx10 register =
dump
> >>
> >>
> >> On 4/17/2024 9:31 PM, Lazar, Lijo wrote:
> >>> On 4/17/2024 9:21 PM, Alex Deucher wrote:
> >>>> On Wed, Apr 17, 2024 at 5:38=E2=80=AFAM Sunil Khatri <sunil.khatri@a=
md.com> wrote:
> >>>>> Adding gfx10 gc registers to be used for register dump via
> >>>>> devcoredump during a gpu reset.
> >>>>>
> >>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >>>> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >>>>
> >>>>> ---
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   8 ++
> >>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   4 +
> >>>>>    drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        | 130 ++++++++++++=
+++++-
> >>>>>    drivers/gpu/drm/amd/amdgpu/soc15.h            |   2 +
> >>>>>    .../include/asic_reg/gc/gc_10_1_0_offset.h    |  12 ++
> >>>>>    5 files changed, 155 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>>>> index e0d7f4ee7e16..cac0ca64367b 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>>>> @@ -139,6 +139,14 @@ enum amdgpu_ss {
> >>>>>           AMDGPU_SS_DRV_UNLOAD
> >>>>>    };
> >>>>>
> >>>>> +struct amdgpu_hwip_reg_entry {
> >>>>> +       u32             hwip;
> >>>>> +       u32             inst;
> >>>>> +       u32             seg;
> >>>>> +       u32             reg_offset;
> >>>>> +       const char      *reg_name;
> >>>>> +};
> >>>>> +
> >>>>>    struct amdgpu_watchdog_timer {
> >>>>>           bool timeout_fatal_disable;
> >>>>>           uint32_t period; /* maxCycles =3D (1 << period), the numb=
er
> >>>>> of cycles before a timeout */ diff --git
> >>>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>>> index 04a86dff71e6..64f197bbc866 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>>>> @@ -433,6 +433,10 @@ struct amdgpu_gfx {
> >>>>>           uint32_t                        num_xcc_per_xcp;
> >>>>>           struct mutex                    partition_mutex;
> >>>>>           bool                            mcbp; /* mid command buff=
er preemption */
> >>>>> +
> >>>>> +       /* IP reg dump */
> >>>>> +       uint32_t                        *ip_dump;
> >>>>> +       uint32_t                        reg_count;
> >>>>>    };
> >>>>>
> >>>>>    struct amdgpu_gfx_ras_reg_entry {
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>>>> index a0bc4196ff8b..4a54161f4837 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>>>> @@ -276,6 +276,99 @@ MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec.bin");
> >>>>>    MODULE_FIRMWARE("amdgpu/gc_10_3_7_mec2.bin");
> >>>>>    MODULE_FIRMWARE("amdgpu/gc_10_3_7_rlc.bin");
> >>>>>
> >>>>> +static const struct amdgpu_hwip_reg_entry gc_reg_list_10_1[] =3D {
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS2),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS3),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT1),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_STALLED_STAT2),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STALLED_STAT1),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STALLED_STAT1),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_BUSY_STAT),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_BUSY_STAT2),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_BUSY_STAT2),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPF_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_ERROR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_GFX_HPD_STATUS0),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_BASE),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_RPTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB_WPTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_BASE),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_RPTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB0_WPTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_BASE),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_RPTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB1_WPTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_BASE),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_RB2_WPTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_CMD_BUFSZ),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_CMD_BUFSZ),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_CMD_BUFSZ),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_CMD_BUFSZ),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_LO),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BASE_HI),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB1_BUFSZ),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_LO),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BASE_HI),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_IB2_BUFSZ),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_LO),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BASE_HI),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB1_BUFSZ),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_LO),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BASE_HI),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_IB2_BUFSZ),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPF_UTCL1_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPC_UTCL1_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCPG_UTCL1_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGDS_PROTECTION_FAULT),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGDS_VM_PROTECTION_FAULT),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmIA_UTCL1_STATUS_2),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmPA_CL_CNTL_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_UTCL1_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRMI_UTCL1_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQC_DCACHE_UTCL0_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQC_ICACHE_UTCL0_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSQG_UTCL0_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmTCP_UTCL0_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmWD_UTCL1_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL)=
,
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGCVM_L2_PROTECTION_FAULT_STATU=
S),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_DEBUG),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC_CNTL),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_CNTL),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CE_INSTR_PNTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC1_INSTR_PNTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MEC2_INSTR_PNTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_DEBUG_INTERRUPT_INSTR_P=
NTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_MES_INSTR_PNTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_ME_INSTR_PNTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_PFP_INSTR_PNTR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_CPC_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_STAT),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_COMMAND),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_MESSAGE),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_1),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_2),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_3),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_ARGUMENT_4),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmSMU_RLC_RESPONSE),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SAFE_MODE),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SMU_SAFE_MODE),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_GPM_STAT_2),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_SPP_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_RLCS_BOOTLOAD_STATUS),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_INT_STAT),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_GENERAL_6),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_A),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_B),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_GPM_DEBUG_INST_ADDR),
> >>>>> +       SOC15_REG_ENTRY_STR(GC, 0, mmRLC_LX6_CORE_PDEBUG_INST) };
> >>>>> +
> >>>>>    static const struct soc15_reg_golden golden_settings_gc_10_1[] =
=3D {
> >>>>>           SOC15_REG_GOLDEN_VALUE(GC, 0, mmCB_HW_CONTROL_4, 0xffffff=
ff, 0x00400014),
> >>>>>           SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_CPF_CLK_CTRL,
> >>>>> 0xfcff8fff, 0xf8000100), @@ -4490,6 +4583,22 @@ static int gfx_v10_=
0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
> >>>>>                                hw_prio, NULL);
> >>>>>    }
> >>>>>
> >>>>> +static void gfx_v10_0_alloc_dump_mem(struct amdgpu_device *adev) {
> >>>>> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_10_1);
> >>>>> +       uint32_t *ptr;
> >>>>> +
> >>>>> +       ptr =3D kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
> >>>>> +       if (ptr =3D=3D NULL) {
> >>>>> +               DRM_ERROR("Failed to allocate memory for IP Dump\n"=
);
> >>>>> +               adev->gfx.ip_dump =3D NULL;
> >>>>> +               adev->gfx.reg_count =3D 0;
> >>>>> +       } else {
> >>>>> +               adev->gfx.ip_dump =3D ptr;
> >>>>> +               adev->gfx.reg_count =3D reg_count;
> >>>>> +       }
> >>>>> +}
> >>>>> +
> >>>>>    static int gfx_v10_0_sw_init(void *handle)
> >>>>>    {
> >>>>>           int i, j, k, r, ring_id =3D 0; @@ -4642,6 +4751,8 @@ stat=
ic
> >>>>> int gfx_v10_0_sw_init(void *handle)
> >>>>>
> >>>>>           gfx_v10_0_gpu_early_init(adev);
> >>>>>
> >>>>> +       gfx_v10_0_alloc_dump_mem(adev);
> >>>>> +
> >>>>>           return 0;
> >>>>>    }
> >>>>>
> >>>>> @@ -4694,6 +4805,8 @@ static int gfx_v10_0_sw_fini(void *handle)
> >>>>>
> >>>>>           gfx_v10_0_free_microcode(adev);
> >>>>>
> >>>>> +       kfree(adev->gfx.ip_dump);
> >>>>> +
> >>>>>           return 0;
> >>>>>    }
> >>>>>
> >>>>> @@ -9154,6 +9267,21 @@ static void gfx_v10_0_emit_mem_sync(struct a=
mdgpu_ring *ring)
> >>>>>           amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
> >>>>>    }
> >>>>>
> >>>>> +static void gfx_v10_ip_dump(void *handle) {
> >>>>> +       struct amdgpu_device *adev =3D (struct amdgpu_device *)hand=
le;
> >>>>> +       uint32_t i;
> >>>>> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_10_1);
> >>>>> +
> >>>>> +       if (!adev->gfx.ip_dump)
> >>>>> +               return;
> >>>>> +
> >>>>> +       amdgpu_gfx_off_ctrl(adev, false);
> >>>>> +       for (i =3D 0; i < reg_count; i++)
> >>>>> +               adev->gfx.ip_dump[i] =3D
> >>>>> + RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_10_1[i]));
> >>> This may cause a bigger hang, if PMFW is already hung (in that case
> >>> reset also won't work, but a dump is still useful). To be on the safe=
r
> >>> side, there should be some sort of return value for gfx_off which
> >>> should be checked.
> >> amdgpu_gfx_off_ctrl doesnt return any value to confirm if it worked or=
 not else would have checked return value.
> >> I guess assumption is that it will work until there is a bigger hang a=
s you  mentioned and i guess in that case nothing will work and needs a res=
et only.
> >>
> >> Regards
> >> Sunil Khatri
> >>
> >>> Thanks,
> >>> Lijo
> >>>
> >>>>> +       amdgpu_gfx_off_ctrl(adev, true); }
> >>>>> +
> >>>>>    static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {
> >>>>>           .name =3D "gfx_v10_0",
> >>>>>           .early_init =3D gfx_v10_0_early_init, @@ -9170,7 +9298,7 =
@@
> >>>>> static const struct amd_ip_funcs gfx_v10_0_ip_funcs =3D {
> >>>>>           .set_clockgating_state =3D gfx_v10_0_set_clockgating_stat=
e,
> >>>>>           .set_powergating_state =3D gfx_v10_0_set_powergating_stat=
e,
> >>>>>           .get_clockgating_state =3D gfx_v10_0_get_clockgating_stat=
e,
> >>>>> -       .dump_ip_state =3D NULL,
> >>>>> +       .dump_ip_state =3D gfx_v10_ip_dump,
> >>>>>    };
> >>>>>
> >>>>>    static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx =
=3D {
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.h
> >>>>> b/drivers/gpu/drm/amd/amdgpu/soc15.h
> >>>>> index 1444b7765e4b..282584a48be0 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/soc15.h
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.h
> >>>>> @@ -88,6 +88,8 @@ struct soc15_ras_field_entry {
> >>>>>    };
> >>>>>
> >>>>>    #define SOC15_REG_ENTRY(ip, inst, reg) ip##_HWIP, inst,
> >>>>> reg##_BASE_IDX, reg
> >>>>> +#define SOC15_REG_ENTRY_STR(ip, inst, reg) \
> >>>>> +       { ip##_HWIP, inst, reg##_BASE_IDX, reg, #reg }
> >>>>>
> >>>>>    #define SOC15_REG_ENTRY_OFFSET(entry)
> >>>>> (adev->reg_offset[entry.hwip][entry.inst][entry.seg] +
> >>>>> entry.reg_offset)
> >>>>>
> >>>>> diff --git
> >>>>> a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> >>>>> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> >>>>> index 4908044f7409..4c8e7fdb6976 100644
> >>>>> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> >>>>> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_1_0_offset.h
> >>>>> @@ -4830,6 +4830,8 @@
> >>>>>    #define mmCP_ECC_FIRSTOCCURRENCE_RING2_BASE_IDX                 =
                                       0
> >>>>>    #define mmGB_EDC_MODE                                           =
                                       0x1e1e
> >>>>>    #define mmGB_EDC_MODE_BASE_IDX                                  =
                                       0
> >>>>> +#define mmCP_DEBUG                                                =
                                     0x1e1f
> >>>>> +#define mmCP_DEBUG_BASE_IDX                                       =
                                     0
> >>>>>    #define mmCP_FETCHER_SOURCE                                     =
                                       0x1e22
> >>>>>    #define mmCP_FETCHER_SOURCE_BASE_IDX                            =
                                       0
> >>>>>    #define mmCP_PQ_WPTR_POLL_CNTL                                  =
                                       0x1e23
> >>>>> @@ -7778,6 +7780,8 @@
> >>>>>    #define mmCP_MES_DOORBELL_CONTROL5_BASE_IDX                     =
                                       1
> >>>>>    #define mmCP_MES_DOORBELL_CONTROL6                              =
                                       0x2841
> >>>>>    #define mmCP_MES_DOORBELL_CONTROL6_BASE_IDX                     =
                                       1
> >>>>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR                       =
                                     0x2842
> >>>>> +#define mmCP_MES_DEBUG_INTERRUPT_INSTR_PNTR_BASE_IDX              =
                                     1
> >>>>>    #define mmCP_MES_GP0_LO                                         =
                                       0x2843
> >>>>>    #define mmCP_MES_GP0_LO_BASE_IDX                                =
                                       1
> >>>>>    #define mmCP_MES_GP0_HI                                         =
                                       0x2844
> >>>>> @@ -9332,10 +9336,16 @@
> >>>>>    #define mmRLC_LB_CNTR_INIT_1_BASE_IDX                           =
                                       1
> >>>>>    #define mmRLC_LB_CNTR_1                                         =
                                       0x4c1c
> >>>>>    #define mmRLC_LB_CNTR_1_BASE_IDX                                =
                                       1
> >>>>> +#define mmRLC_GPM_DEBUG_INST_ADDR                                 =
                                     0x4c1d
> >>>>> +#define mmRLC_GPM_DEBUG_INST_ADDR_BASE_IDX                        =
                                     1
> >>>>>    #define mmRLC_JUMP_TABLE_RESTORE                                =
                                       0x4c1e
> >>>>>    #define mmRLC_JUMP_TABLE_RESTORE_BASE_IDX                       =
                                       1
> >>>>>    #define mmRLC_PG_DELAY_2                                        =
                                       0x4c1f
> >>>>>    #define mmRLC_PG_DELAY_2_BASE_IDX                               =
                                       1
> >>>>> +#define mmRLC_GPM_DEBUG_INST_A                                    =
                                     0x4c22
> >>>>> +#define mmRLC_GPM_DEBUG_INST_A_BASE_IDX                           =
                                     1
> >>>>> +#define mmRLC_GPM_DEBUG_INST_B                                    =
                                     0x4c23
> >>>>> +#define mmRLC_GPM_DEBUG_INST_B_BASE_IDX                           =
                                     1
> >>>>>    #define mmRLC_GPU_CLOCK_COUNT_LSB                               =
                                       0x4c24
> >>>>>    #define mmRLC_GPU_CLOCK_COUNT_LSB_BASE_IDX                      =
                                       1
> >>>>>    #define mmRLC_GPU_CLOCK_COUNT_MSB                               =
                                       0x4c25
> >>>>> @@ -9720,6 +9730,8 @@
> >>>>>    #define mmRLC_SPM_THREAD_TRACE_CTRL_BASE_IDX                    =
                                       1
> >>>>>    #define mmRLC_LB_CNTR_2                                         =
                                       0x4de7
> >>>>>    #define mmRLC_LB_CNTR_2_BASE_IDX                                =
                                       1
> >>>>> +#define mmRLC_LX6_CORE_PDEBUG_INST                                =
                                     0x4deb
> >>>>> +#define mmRLC_LX6_CORE_PDEBUG_INST_BASE_IDX                       =
                                     1
> >>>>>    #define mmRLC_CPAXI_DOORBELL_MON_CTRL                           =
                                       0x4df1
> >>>>>    #define mmRLC_CPAXI_DOORBELL_MON_CTRL_BASE_IDX                  =
                                       1
> >>>>>    #define mmRLC_CPAXI_DOORBELL_MON_STAT                           =
                                       0x4df2
> >>>>> --
> >>>>> 2.34.1
> >>>>>
