Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E677C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 17:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF0710E0C1;
	Tue,  7 Jul 2026 17:59:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UcHXDgT+";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85EAF10E0C1
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 17:59:06 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2cad85b7b5aso2561545ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 10:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783447146; cv=none;
 d=google.com; s=arc-20260327;
 b=IcDO4FQR4IRIgzFn7qLAiYF59V+95VGXHbJtTKJA6E8fZOWknfJ4orHWqTiaBfuUc6
 91cCn4jSczB4nj2Z798xefB5BXRykJiC715ZYK9wpd1Wp+JSvbhWLMycd06E0R77Y/Y0
 GhEc/Y32st53cVbOsyUzkK0Eu385Ono8Id7ga1orFe8R+F7UdI0N05G/hVJdeaYABuip
 lhJTU3DLyUefKvxV4ajdGf4t8OIkdZcOMWwjTw/Wq2oe6tYVi3kCyJQF6M9OIdG/MFZp
 ViSKVjKKF1ehN/OfATzDVUPaN0/BkXlm/uBmC4ScYUWTXP4rPfTHx4Cuy6djzMfkiWPi
 fT8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1HIHg9nRf/GEmwU6tLK70lIBx9Q/8wEd+fQxFm175rE=;
 fh=MhhFalFohetxWQN3dJ+TAQVRxto7707vBIZkfJnYUd0=;
 b=sMa1y3wkOOZva9O4rcGk2lEl9PPKUaGcYVEqbuQg5Yvx5MvteIh5BY4mfXksNLd9tG
 86Lr2XKsR1IHIGz5U2njwtw7DnmVG8EST8A4w9Fxb++VCYuPDH9Z16gahA/UuWhGbUIw
 nzYuI3PEzLwgtzPsAqEdVn5HbWfyyK4eQTin1jYdtfoY+WoK7yODMtYma+ZBnH0/es5n
 pVa7+zAAiqUfc+2S4iyohZ1KnTivt4L3UjBS2ITqdCff1BdUvybUJ190xiyDCh0B3ohD
 qtVCviK5dPZg7t5p31yNWZ2Xb+H5co0KcujE41R6s5NeQL5gTtiIbTFpswrrurKw4+bD
 uOfw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783447146; x=1784051946; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1HIHg9nRf/GEmwU6tLK70lIBx9Q/8wEd+fQxFm175rE=;
 b=UcHXDgT+4WsuZr2++4vnsVXAafrFmz/yRG4mo2A8k3fkJm2MxCT90cBq82VGkjtze5
 /v1Tdj7Agwbx4+GQP2hAejLMRaHMPyFCQqGSrM2HcEQMgcSD5/WpSghQtPy0OuICvR0C
 mrBvp7M0cpcl6gibd41wEtkDh6262NibyNlbiu6Nk4EJKne4qx2dD/X5Ur+1G+AEv7WB
 fJIKCbpYwJKei9iVzR85O1t5Kdp5id55/OhgRwT9joQ5NnB5iah/rK6cHMbytUx4bwPV
 MwrMV+q4noxguO+jw6+DL9dO925ziyYQate4xdQBzThDZzuT6zO2a3T0PROKn1H5XRsK
 jvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783447146; x=1784051946;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1HIHg9nRf/GEmwU6tLK70lIBx9Q/8wEd+fQxFm175rE=;
 b=E6T7eclhJdw3MfJ4NkU3XrZtRYGo/HHdzCxJ//hLVDKL7uYBoG4fdyVvIa1Cnneoxb
 ktP1170LyQyJo1Rn8qWfz+K9USFvYUcAyRj4D8nXKEspJuCxrCl3N/Ncth66rv/19+v+
 2WBr7swbKmC+am+s0y45kt8noqSnKN4If9T2kmApts9HQHEySG5R1bauM7EOOf1cdiEC
 GaBUavhJS0txIbJR0xA5hfpoIBZpYH2rWYXaof6pztB5LabPLztb7Wq5C896oL1OIH1h
 p7pFxQd4hNKGBAz/6gekpKQFS2H9bWU/x5ANax58AD5toNGL50XYsB9wNh40xV60naN4
 /6Tg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rou30yoLZnDwgBC5XJdfpvbVU6PtUTAisbv0SACZOiifiP0kUoBka0h6meWGxiYc+VYkTW1Qh9B@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpvhOeH+lbpU9TaBKOGjBUAXES4w5/N8rgo4o6LNjB7aploEC4
 F91ugjbmErJXuKio8ra3unHZgPmi6g5621TA9kS8xuvOKcYOt0FQ+FQ8IWaBJnF6SY91rIbGTQr
 PwIqj3gcJL0mGsknc2rFFglCoQlu2f+Y=
X-Gm-Gg: AfdE7cmGrx4UKrire8yZyrsq7Md7L07MllEP8ILdckl6ZkLnpvKOjQQ+svy3FlStn/9
 r02V44mT8Xxq9XKMyMunggOovfVCxq5e3t8z4xNpW+pM/IZF/5gA1pKEZvg5pkWCwFXm+hIzReB
 ae35k1zu8xSuEQvQcYNdOa8ZEPRjALYDZvsahfR7wntJZHw4eSi9KncHDruiouimmxgIlnUX8Fg
 Wh2L1cbpDLHVaRK9FMcdsgCJt0/K2amGz3uWs7y9rrcS35gU6/RTboCXYtdh8PwpulXcClf+/7m
 CD7Jbdmvspea+shnN6MRDhTSzhyg6tg8gfeQlWdvUzBwPg+mjU+gJQQwWHlnKPGKhESs/g==
X-Received: by 2002:a17:903:2408:b0:2c9:ffc2:dffa with SMTP id
 d9443c01a7336-2cccad5eda4mr31469235ad.6.1783447145866; Tue, 07 Jul 2026
 10:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260618204550.753250-1-alexander.deucher@amd.com>
 <CADnq5_Pn732-q2h0jcXcRErbjO=dtwsOfVgZE_qCT3-xCW24BA@mail.gmail.com>
 <CADnq5_NWbd3DCNU_LA9WDdZKJOLT+bSRBiaUwmrHVo5GVNGfyg@mail.gmail.com>
 <c16e8451-5d2c-4a36-93ab-a345739c3a1c@amd.com>
In-Reply-To: <c16e8451-5d2c-4a36-93ab-a345739c3a1c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Jul 2026 13:58:53 -0400
X-Gm-Features: AVVi8CeE8TaZNYvHuU1Hz53Dl4nebMjHUeN8wTobrS-9gavrHaLawhOub25hrhk
Message-ID: <CADnq5_OOhwAjhp2ps+Arw=cnrmP4zgMeWtX79L0wam=SbSiitA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gx12.1: Add ip dump support
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

On Tue, Jul 7, 2026 at 12:25=E2=80=AFPM Mukul Joshi <mukul.joshi@amd.com> w=
rote:
>
> s/gx12.1/gfx12.1 in the patch headline.
>
>
> On 7/6/2026 11:01 AM, Alex Deucher wrote:
>
> Ping?
>
> On Mon, Jun 29, 2026 at 4:28=E2=80=AFPM Alex Deucher <alexdeucher@gmail.c=
om> wrote:
>
> Ping?
>
> On Thu, Jun 18, 2026 at 5:04=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
>
> Add support for dumping IP register state.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 275 +++++++++++++++++++++++++
>  1 file changed, 275 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index 5bdf2512f1540..ec4346a6c2af2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -69,6 +69,127 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc_1.bin");
>          (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 << SH_MEM_CONFIG__ALI=
GNMENT_MODE__SHIFT) | \
>          (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
>
> +
> +static const struct amdgpu_hwip_reg_entry gc_reg_list_12_1[] =3D {
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
> +       SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO3=
2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI3=
2),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
> +       /* cp header registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +       /* SE status registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
> +       SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
> +};
> +
> +static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12_1[] =3D {
> +       /* compute registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
> +       /* cp header registers */
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +       SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +};
> +
>  static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, i=
nt xcc_id);
>  static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
>  static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
> @@ -1148,6 +1269,153 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable=
(struct amdgpu_device *adev)
>         return 0;
>  }
>
> +static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
> +{
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
> +       uint32_t *ptr, inst, num_xcc;
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
> +
> +       /* Allocate memory for compute queue registers for all the instan=
ces */
> +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> +       inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
> +               adev->gfx.mec.num_queue_per_pipe;
> +
> +       ptr =3D kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP=
_KERNEL);
> +       if (!ptr) {
> +               DRM_ERROR("Failed to allocate memory for Compute Queues I=
P Dump\n");
> +               adev->gfx.ip_dump_compute_queues =3D NULL;
> +       } else {
> +               adev->gfx.ip_dump_compute_queues =3D ptr;
> +       }
> +}
> +
> +static void gfx_v12_1_ip_print(struct amdgpu_ip_block *ip_block,
> +                              struct drm_printer *p)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       uint32_t i, j, k;
> +       uint32_t xcc_id, xcc_offset, inst_offset;
> +       uint32_t num_xcc, reg, num_inst;
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
> +
> +       if (!adev->gfx.ip_dump_core)
> +               return;
> +
> +       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> +       drm_printf(p, "Number of Instances:%d\n", num_xcc);
> +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> +               xcc_offset =3D xcc_id * reg_count;
> +               drm_printf(p, "\nInstance id:%d\n", xcc_id);
> +               for (i =3D 0; i < reg_count; i++)
> +                       drm_printf(p, "%-50s \t 0x%08x\n",
> +                                  gc_reg_list_12_1[i].reg_name,
> +                                  adev->gfx.ip_dump_core[xcc_offset + i]=
);
> +       }
> +
> +       /* print compute queue registers for all instances */
> +       if (!adev->gfx.ip_dump_compute_queues)
> +               return;
> +
> +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> +       drm_printf(p, "\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue: =
%d\n",
> +                  num_xcc,
> +                  adev->gfx.mec.num_mec,
> +                  adev->gfx.mec.num_pipe_per_mec,
> +                  adev->gfx.mec.num_queue_per_pipe);
> +
> +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> +               xcc_offset =3D xcc_id * reg_count * num_inst;
>
> num_inst is never initialized here.

Fixed.

>
> +               inst_offset =3D 0;
> +               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> +                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec;=
 j++) {
> +                               for (k =3D 0; k < adev->gfx.mec.num_queue=
_per_pipe; k++) {
> +                                       drm_printf(p,
> +                                                  "\nxcc:%d mec:%d, pipe=
:%d, queue:%d\n",
> +                                                   xcc_id, i, j, k);
> +                                       for (reg =3D 0; reg < reg_count; =
reg++) {
> +                                               drm_printf(p,
> +                                                          "%-50s \t 0x%0=
8x\n",
> +                                                          gc_cp_reg_list=
_12_1[reg].reg_name,
> +                                                          adev->gfx.ip_d=
ump_compute_queues
> +                                                          [xcc_offset + =
inst_offset +
> +                                                           reg]);
> +                                       }
> +                                       inst_offset +=3D reg_count;
> +                               }
> +                       }
> +               }
> +       }
> +}
> +
> +static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
> +{
> +       struct amdgpu_device *adev =3D ip_block->adev;
> +       uint32_t i, j, k;
> +       uint32_t num_xcc, reg, num_inst;
> +       uint32_t xcc_id, xcc_offset, inst_offset;
> +       uint32_t reg_count =3D ARRAY_SIZE(gc_reg_list_12_1);
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
_list_12_1[i],
> +                                                                  GET_IN=
ST(GC, xcc_id)));
> +       }
> +       amdgpu_gfx_off_ctrl(adev, true);
> +
> +       /* dump compute queue registers for all instances */
> +       if (!adev->gfx.ip_dump_compute_queues)
> +               return;
> +
> +       num_inst =3D adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_m=
ec *
> +               adev->gfx.mec.num_queue_per_pipe;
> +       reg_count =3D ARRAY_SIZE(gc_cp_reg_list_12_1);
> +       amdgpu_gfx_off_ctrl(adev, false);
> +       mutex_lock(&adev->srbm_mutex);
> +       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
> +               xcc_offset =3D xcc_id * reg_count * num_inst;
> +               inst_offset =3D 0;
> +               for (i =3D 0; i < adev->gfx.mec.num_mec; i++) {
> +                       for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec;=
 j++) {
> +                               for (k =3D 0; k < adev->gfx.mec.num_queue=
_per_pipe; k++) {
> +                                       /* ME0 is for GFX so start from 1=
 for CP */
> +                                       soc_v1_0_grbm_select(adev, 1 + i,=
 j, k, 0,
> +                                                            GET_INST(GC,=
 xcc_id));
> +
> +                                       for (reg =3D 0; reg < reg_count; =
reg++) {
> +                                               adev->gfx.ip_dump_compute=
_queues
> +                                                       [xcc_offset +
> +                                                        inst_offset + re=
g] =3D
> +                                                       RREG32(SOC15_REG_=
ENTRY_OFFSET_INST(
> +                                                                      gc=
_cp_reg_list_12_1[reg],
> +                                                                      GE=
T_INST(GC, xcc_id)));
> +                                       }
> +                                       inst_offset +=3D reg_count;
> +                               }
> +                       }
> +               }
> +       }
> +       soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
> +       mutex_unlock(&adev->srbm_mutex);
> +       amdgpu_gfx_off_ctrl(adev, true);
>
> Do we support GFX OFF on GFX 12.1? .

No, it's a noop if a particular chip doesn't support it.

>
> +}
> +
>  static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>  {
>         uint16_t major_ver, minor_ver;
> @@ -1282,6 +1550,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block=
 *ip_block)
>         if (r)
>                 return r;
>
> +       gfx_v12_1_alloc_ip_dump(adev);
> +
>         r =3D amdgpu_gfx_sysfs_init(adev);
>         if (r)
>
> You may want to free the IP dump memory if the sysfs init fails or do the=
 alloc after the sysfs init.
>

Fixed.

Thanks,

Alex

> Regards,
>
> Mukul
>
>                 return r;
> @@ -1325,6 +1595,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>         gfx_v12_1_free_microcode(adev);
>         amdgpu_gfx_sysfs_fini(adev);
>
> +       kfree(adev->gfx.ip_dump_core);
> +       kfree(adev->gfx.ip_dump_compute_queues);
> +
>         return 0;
>  }
>
> @@ -3905,6 +4178,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs=
 =3D {
>         .set_clockgating_state =3D gfx_v12_1_set_clockgating_state,
>         .set_powergating_state =3D gfx_v12_1_set_powergating_state,
>         .get_clockgating_state =3D gfx_v12_1_get_clockgating_state,
> +       .dump_ip_state =3D gfx_v12_1_ip_dump,
> +       .print_ip_state =3D gfx_v12_1_ip_print,
>  };
>
>  static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute =3D {
> --
> 2.54.0
>
