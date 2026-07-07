Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DD3C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 18:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BED7A10E217;
	Tue,  7 Jul 2026 18:20:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SUFZNpCN";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A31E210E217
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 18:20:28 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2ccae46de39so2716295ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 11:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783448428; cv=none;
 d=google.com; s=arc-20260327;
 b=jMARjV0FCxlTh1pvNQoQs/JeyQltcSz9ce2/UawPGgYIw+PDy8nZPBDHf2JkZIIGhE
 X7GL9VZhlcRSS2ecEWIHcnsX3Joef+ajY2kesOq9JWvBEScAepO08TZFO4oPG/kNoYLN
 qlJ8vX24K4q85yp7OAztAMaZqoHe5mW8jV8d5EH3X+8nzhEnHUQnJH+2KFZb0spbrRn/
 wk6QqNWgEBvKDdFBpEQvhF3EEX+cVE6XR0LIBu6LsuFh05ZWBm5lZnZpI2Ax6sSs07kg
 4Rvoi2bhhvqbmYQCp7xfjsTmHliARZ307dimJr81hl4273ECisVh5BPRPVMPl401HbjZ
 DCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7FLFAqUAb+IhdQzk0m7mjDj+EixUh+byFPy2bjyN8v8=;
 fh=D/WwHOQEydKi+O2iY7If+mmjyr1shGLfCLS2FRv42iE=;
 b=cCVYg/UlPVph0/D2J8KYUObQhtkPgGf8R2WoMei/3pxAgugjZWwGVgXMKjnosVtlMf
 qajOv7OCO9wd5qPTf9lIQS38lBIf3I+QjkSTR02TB9rjFREgHyG+6FiMQkBkKFKW2eqv
 jL6Z4WxqLvuQhnI860Z3/qPcHnovAzYm+nhFPXC9Oli+ZCF0vMppvqGD/jthkMJIwZn2
 HLFyxDCtVlQJvYx2r+uQ+OVcsqXAsGoFMDHCrzP9sl9z0kHVWOUXaJFgEfYdiREsTknL
 n73AwbA5bWGMQXey1lir2moPGuLykVBqm4vH1MQNOl5DKvM4koFmEHbav/hGd0cqBxHN
 hArw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783448428; x=1784053228; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7FLFAqUAb+IhdQzk0m7mjDj+EixUh+byFPy2bjyN8v8=;
 b=SUFZNpCNxjKBNebifde1iJVzjmmqPc06N4AF3jMpmw0MlgpX6u3WcXF87ZlzDcA6Jc
 Kjzl1bj9BPVaG9JXTeP13KizwEn3OnTjYIn/yrg077aQeSM2v2kctYS2mE5tm00IUXR/
 NGrDaOAemFqz0e7xtxo7gaPuq4ZdVVF7ltks6giOf930d7YO1MpowwGz0nOZng6iJgw5
 nHOp+bVJ/mwOVJwDNI5pgqCgR0mhlc7VZSe0E1udeQEF3aXqTbM8eJ5knLNKWbTv1n8L
 87SbOOj1Eyk0TeZe6KD5FU6DHcXpTLeLuUkjryGjY9O8t3PCyxAlvnX4xJvhbwrca+6S
 mxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448428; x=1784053228;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7FLFAqUAb+IhdQzk0m7mjDj+EixUh+byFPy2bjyN8v8=;
 b=D33Jes645K8gLbBiBeY/x+OKew/gVKF9k/ejybQgs8ChT29RSZC9RIkTXVTYrPDGDX
 +jmiKyqO/bJ8oyLRklNYc5FFe9lZ7RJtOQr2RG5GN3qzSpzUQ5oGGLaxkFLZF7DQI5tu
 ffsY107Jh2wtFNT9VjICyeUX71geJf2+4jaGnv86Y3XY7zdZyHd184FOwRVJXO4KtW9B
 RqQCxGt8KbqQTnkFx6u7nxIRB4QHPkJ/hj9NsFNPQD4GyX5s/j8lMfQW5/TMC44OLezT
 xGTlj7qjTfoDcANw4f2Y39Yyq69QBH1UEE2+uAB2L4uYjhuQ2aH9wyfYbV/swC9WNdgk
 q0+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwtgjIUzlL1kpjNFacAziro9jxKGCXseWWo+DOmjTP/vE7ns/NzRJIBP55P4vj1hhBudojZwYk@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1p541Ub0J8Gm9Q/mFZk7wjDWe+F6eqKBOrTwrJ+1UxVqgevNu
 U1RQcRh4p1z1ZfgjRqWj4iydmwBCczyMVhT7mBdm8KRkoXrjL878BQcheuYZqyx2m7gNWbU4kP7
 wYkJn2OOiPw4B1EiziKbO4sHzmB/G9t39Kg==
X-Gm-Gg: AfdE7cnB4iQPhvPxsXVYimVDH/i9BLQLMlvVE/SFAufi5a2dSaiSgGzVaPAuOOhqd+1
 I11tnXHnq6+H65gSFQ1pToU5woG+JVEUXpMDbEuLgkrgN51ec89b+drfoEKeRd3gL0teY8OUZ2q
 ToPTb0Xk/2ARURZn11MCZX7H3Vt2VviK61TbUcJrISSW3QtDI/dvMlN5RMlYME9VmzxLwuiYWjd
 EZN1NbOXnWsVSFbyzNsRKkBCtGPm5eKKjDDt8dtwY7SvdRti5SMdpqUbvhTdi057Bl56I9VXctz
 FDqPiX6XV2J7VpXbps7M1L6hNIKin2KEhr40s385IxJVVncQLhZxUBhSuik=
X-Received: by 2002:a17:902:ef02:b0:2ca:d344:7752 with SMTP id
 d9443c01a7336-2cbb9f5cc1bmr119128405ad.8.1783448428027; Tue, 07 Jul 2026
 11:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260707180021.2642432-1-alexander.deucher@amd.com>
 <20260707180021.2642432-5-alexander.deucher@amd.com>
 <9cdf7dfd-4c78-48c5-9cd1-d6523b8039d2@amd.com>
In-Reply-To: <9cdf7dfd-4c78-48c5-9cd1-d6523b8039d2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jul 2026 14:20:15 -0400
X-Gm-Features: AVVi8CdKgxFpFk1ogrqfjBhb5CHYYmQ1B3Axa-GJBjvon2A_AMbIrC7RxH_7YR8
Message-ID: <CADnq5_MHwzBZcfTUsEOyjYK9aJL4nHXZUFxDQjY2-tfjO8rCQg@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/amdgpu/gx12.1: Add ip dump support
To: Mukul Joshi <mukul.joshi@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Jul 7, 2026 at 2:19=E2=80=AFPM Mukul Joshi <mukul.joshi@amd.com> wr=
ote:
>
> Please do before pushing:
>
> s/gx12.1/gfx12.1 in the patch headline

Yup.  Already fixed.  thanks!

>
> Regards,
>
> Mukul
>
> On 7/7/2026 2:00 PM, Alex Deucher wrote:
>
> Add support for dumping IP register state.
>
> v2: fixes suggested by Mukul
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 277 +++++++++++++++++++++++++
>  1 file changed, 277 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index 408fd23c6bd43..1d09f1771dde3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -69,6 +69,127 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc_1.bin");
>   (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 << SH_MEM_CONFIG__ALIGNMENT_=
MODE__SHIFT) | \
>   (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
>
> +
> +static const struct amdgpu_hwip_reg_entry gc_reg_list_12_1[] =3D {
> + SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> + SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
> + SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
> + SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
> + SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
> + SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
> + SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
> + SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
> + SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
> + SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
> + SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
> + SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
> + SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
> + SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
> + SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO32),
> + SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI32),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
> + /* cp header registers */
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> + /* SE status registers */
> + SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
> + SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
> +};
> +
> +static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12_1[] =3D {
> + /* compute registers */
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
> + /* cp header registers */
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> + SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +};
> +
>  static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, i=
nt xcc_id);
>  static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
>  static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
> @@ -1148,6 +1269,155 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable=
(struct amdgpu_device *adev)
>   return 0;
>  }
>
> +static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
> +{
> + uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
> + uint32_t *ptr, inst, num_xcc;
> +
> + num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +
> + ptr =3D kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
> + if (!ptr) {
> + DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
> + adev->gfx.ip_dump_core =3D NULL;
> + } else {
> + adev->gfx.ip_dump_core =3D ptr;
> + }
> +
> + /* Allocate memory for compute queue registers for all the instances */
> + reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> + inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
> + adev->gfx.mec.num_queue_per_pipe;
> +
> + ptr =3D kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP_KERNE=
L);
> + if (!ptr) {
> + DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
> + adev->gfx.ip_dump_compute_queues =3D NULL;
> + } else {
> + adev->gfx.ip_dump_compute_queues =3D ptr;
> + }
> +}
> +
> +static void gfx_v12_1_ip_print(struct amdgpu_ip_block *ip_block,
> +       struct drm_printer *p)
> +{
> + struct amdgpu_device *adev =3D ip_block->adev;
> + uint32_t i, j, k;
> + uint32_t xcc_id, xcc_offset, inst_offset;
> + uint32_t num_xcc, reg, num_inst;
> + uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
> +
> + if (!adev->gfx.ip_dump_core)
> + return;
> +
> + num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> + drm_printf(p, "Number of Instances:%d\n", num_xcc);
> + for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> + xcc_offset =3D xcc_id * reg_count;
> + drm_printf(p, "\nInstance id:%d\n", xcc_id);
> + for (i =3D 0; i < reg_count; i++)
> + drm_printf(p, "%-50s \t 0x%08x\n",
> +   gc_reg_list_12_1[i].reg_name,
> +   adev->gfx.ip_dump_core[xcc_offset + i]);
> + }
> +
> + /* print compute queue registers for all instances */
> + if (!adev->gfx.ip_dump_compute_queues)
> + return;
> +
> + reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> + drm_printf(p, "\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue: %d\n",
> +   num_xcc,
> +   adev->gfx.mec.num_mec,
> +   adev->gfx.mec.num_pipe_per_mec,
> +   adev->gfx.mec.num_queue_per_pipe);
> +
> + num_inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
> + adev->gfx.mec.num_queue_per_pipe;
> + for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> + xcc_offset =3D xcc_id * reg_count * num_inst;
> + inst_offset =3D 0;
> + for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> + for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> + for (k =3D 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
> + drm_printf(p,
> +   "\nxcc:%d mec:%d, pipe:%d, queue:%d\n",
> +    xcc_id, i, j, k);
> + for (reg =3D 0; reg < reg_count; reg++) {
> + drm_printf(p,
> +   "%-50s \t 0x%08x\n",
> +   gc_cp_reg_list_12_1[reg].reg_name,
> +   adev->gfx.ip_dump_compute_queues
> +   [xcc_offset + inst_offset +
> +    reg]);
> + }
> + inst_offset +=3D reg_count;
> + }
> + }
> + }
> + }
> +}
> +
> +static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
> +{
> + struct amdgpu_device *adev =3D ip_block->adev;
> + uint32_t i, j, k;
> + uint32_t num_xcc, reg, num_inst;
> + uint32_t xcc_id, xcc_offset, inst_offset;
> + uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
> +
> + if (!adev->gfx.ip_dump_core)
> + return;
> +
> + num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +
> + amdgpu_gfx_off_ctrl(adev, false);
> + for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> + xcc_offset =3D xcc_id * reg_count;
> + for (i =3D 0; i < reg_count; i++)
> + adev->gfx.ip_dump_core[xcc_offset + i] =3D
> + RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_list_12_1[i],
> +   GET_INST(GC, xcc_id)));
> + }
> + amdgpu_gfx_off_ctrl(adev, true);
> +
> + /* dump compute queue registers for all instances */
> + if (!adev->gfx.ip_dump_compute_queues)
> + return;
> +
> + num_inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
> + adev->gfx.mec.num_queue_per_pipe;
> + reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> + amdgpu_gfx_off_ctrl(adev, false);
> + mutex_lock(&adev->srbm_mutex);
> + for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> + xcc_offset =3D xcc_id * reg_count * num_inst;
> + inst_offset =3D 0;
> + for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> + for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> + for (k =3D 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
> + /* ME0 is for GFX so start from 1 for CP */
> + soc_v1_0_grbm_select(adev, 1 + i, j, k, 0,
> +     GET_INST(GC, xcc_id));
> +
> + for (reg =3D 0; reg < reg_count; reg++) {
> + adev->gfx.ip_dump_compute_queues
> + [xcc_offset +
> + inst_offset + reg] =3D
> + RREG32(SOC15_REG_ENTRY_OFFSET_INST(
> +       gc_cp_reg_list_12_1[reg],
> +       GET_INST(GC, xcc_id)));
> + }
> + inst_offset +=3D reg_count;
> + }
> + }
> + }
> + }
> + soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
> + mutex_unlock(&adev->srbm_mutex);
> + amdgpu_gfx_off_ctrl(adev, true);
> +}
> +
>  static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>   uint16_t major_ver, minor_ver;
> @@ -1286,6 +1556,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block=
 *ip_block)
>   if (r)
>   return r;
>
> + gfx_v12_1_alloc_ip_dump(adev);
> +
>   mutex_init(&adev->gfx.mec.reset_mutex);
>
>   return 0;
> @@ -1325,6 +1597,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>   gfx_v12_1_free_microcode(adev);
>   amdgpu_gfx_sysfs_fini(adev);
>
> + kfree(adev->gfx.ip_dump_core);
> + kfree(adev->gfx.ip_dump_compute_queues);
> +
>   return 0;
>  }
>
> @@ -3914,6 +4189,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs=
 =3D {
>   .set_clockgating_state =3D gfx_v12_1_set_clockgating_state,
>   .set_powergating_state =3D gfx_v12_1_set_powergating_state,
>   .get_clockgating_state =3D gfx_v12_1_get_clockgating_state,
> + .dump_ip_state =3D gfx_v12_1_ip_dump,
> + .print_ip_state =3D gfx_v12_1_ip_print,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute =3D {
